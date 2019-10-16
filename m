Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF104D998E
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 20:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394419AbfJPSuq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 14:50:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbfJPSuq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 14:50:46 -0400
Received: from zn.tnic (p200300EC2F093900DCD06DFF5C6D694B.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:3900:dcd0:6dff:5c6d:694b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A950E1EC0819;
        Wed, 16 Oct 2019 20:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571251844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bh4JdzfJ2C9Hk2wSwyELMYVuvfcCfCxqbcSnSMOYzIc=;
        b=c2huueg8UkQQqzX4ftXZdaCZy39E5bzrMSiIuHAQJV96pTQ7uULOkEufSZewhgQYOnjegu
        NzZY32b+gRdUvtAQ0kSlRrfiP1fxYVfB5wiu5Dh5376wYMHCHCNS1nXUnup71/OM2kmBor
        XmB+DguRjo+Pdygz4YSB+FKz10XmJ3k=
Date:   Wed, 16 Oct 2019 20:50:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Message-ID: <20191016185041.GM1138@zn.tnic>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
 <20191014175319.GH4715@zn.tnic>
 <20191016151751.GH1138@zn.tnic>
 <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 16, 2019 at 04:30:24PM +0100, James Morse wrote:
> There are a few more warts we should try and get rid of with this:
> ghes_edac_register() publishes the ghes_pvt pointer under the mutex, but the irq handler
> reads it without taking the mutex. (obviously it can't).
> 
> ghes_edac_register() publishes the pointer before its called edac_mc_add_mc(), which is
> pleasant.

Yeah, before we do this, lemme try to simplify the situation more. And
yeah, we don't need the mutex - we can use the spinlock only. But let's
get rid of the need to access the pvt in the IRQ handler. Yeah, we need
the *mci pointer but one can't have it all :)

Anyway, here's what I have, it is only build-tested. I wanna give it a
stern look tomorrow, on a clear head again:

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0bb62857ffb2..2075e55d49ab 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -19,15 +19,16 @@ struct ghes_edac_pvt {
 	struct list_head list;
 	struct ghes *ghes;
 	struct mem_ctl_info *mci;
-
-	/* Buffers for the error handling routine */
-	char detail_location[240];
-	char other_detail[160];
-	char msg[80];
 };
 
 static atomic_t ghes_init = ATOMIC_INIT(0);
 static struct ghes_edac_pvt *ghes_pvt;
+static struct mem_ctl_info *ghes_mci;
+
+/* Buffers for the error handling routine */
+static char detail_location[240];
+static char other_detail[160];
+static char msg[80];
 
 /*
  * Sync with other, potentially concurrent callers of
@@ -196,15 +197,10 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	enum hw_event_mc_err_type type;
-	struct edac_raw_error_desc *e;
-	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt = ghes_pvt;
+	struct edac_raw_error_desc e;
 	unsigned long flags;
-	char *p;
 	u8 grain_bits;
-
-	if (!pvt)
-		return;
+	char *p;
 
 	/*
 	 * We can do the locking below because GHES defers error processing
@@ -216,20 +212,20 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 	spin_lock_irqsave(&ghes_lock, flags);
 
-	mci = pvt->mci;
-	e = &mci->error_desc;
+	if (!ghes_mci)
+		goto unlock;
 
 	/* Cleans the error report buffer */
-	memset(e, 0, sizeof (*e));
-	e->error_count = 1;
-	strcpy(e->label, "unknown label");
-	e->msg = pvt->msg;
-	e->other_detail = pvt->other_detail;
-	e->top_layer = -1;
-	e->mid_layer = -1;
-	e->low_layer = -1;
-	*pvt->other_detail = '\0';
-	*pvt->msg = '\0';
+	memset(&e, 0, sizeof (e));
+	e.error_count = 1;
+	strcpy(e.label, "unknown label");
+	e.msg = msg;
+	e.other_detail = other_detail;
+	e.top_layer = -1;
+	e.mid_layer = -1;
+	e.low_layer = -1;
+	*other_detail = '\0';
+	*msg = '\0';
 
 	switch (sev) {
 	case GHES_SEV_CORRECTED:
@@ -251,7 +247,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 	/* Error type, mapped on e->msg */
 	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
-		p = pvt->msg;
+		p = msg;
 		switch (mem_err->error_type) {
 		case 0:
 			p += sprintf(p, "Unknown");
@@ -306,21 +302,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 				     mem_err->error_type);
 		}
 	} else {
-		strcpy(pvt->msg, "unknown error");
+		strcpy(msg, "unknown error");
 	}
 
 	/* Error address */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA) {
-		e->page_frame_number = mem_err->physical_addr >> PAGE_SHIFT;
-		e->offset_in_page = mem_err->physical_addr & ~PAGE_MASK;
+		e.page_frame_number = mem_err->physical_addr >> PAGE_SHIFT;
+		e.offset_in_page = mem_err->physical_addr & ~PAGE_MASK;
 	}
 
 	/* Error grain */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
+		e.grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
 
 	/* Memory error location, mapped on e->location */
-	p = e->location;
+	p = e.location;
 	if (mem_err->validation_bits & CPER_MEM_VALID_NODE)
 		p += sprintf(p, "node:%d ", mem_err->node);
 	if (mem_err->validation_bits & CPER_MEM_VALID_CARD)
@@ -337,12 +333,13 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "col:%d ", mem_err->column);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
+
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
 		int index = -1;
 
 		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
-		if (bank != NULL && device != NULL)
+		if (bank && device)
 			p += sprintf(p, "DIMM location:%s %s ", bank, device);
 		else
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
@@ -350,16 +347,16 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
 		if (index >= 0) {
-			e->top_layer = index;
-			e->enable_per_layer_report = true;
+			e.top_layer = index;
+			e.enable_per_layer_report = true;
 		}
 
 	}
-	if (p > e->location)
+	if (p > e.location)
 		*(p - 1) = '\0';
 
 	/* All other fields are mapped on e->other_detail */
-	p = pvt->other_detail;
+	p = other_detail;
 	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
 		u64 status = mem_err->error_status;
 
@@ -421,6 +418,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			break;
 		}
 	}
+
 	if (mem_err->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
 		p += sprintf(p, "requestorID: 0x%016llx ",
 			     (long long)mem_err->requestor_id);
@@ -430,19 +428,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_TARGET_ID)
 		p += sprintf(p, "targetID: 0x%016llx ",
 			     (long long)mem_err->responder_id);
-	if (p > pvt->other_detail)
+	if (p > other_detail)
 		*(p - 1) = '\0';
 
 	/* Generate the trace event */
-	grain_bits = fls_long(e->grain);
-	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
-		 "APEI location: %s %s", e->location, e->other_detail);
-	trace_mc_event(type, e->msg, e->label, e->error_count,
-		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
-		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-		       grain_bits, e->syndrome, pvt->detail_location);
-
-	edac_raw_mc_handle_error(type, mci, e);
+	grain_bits = fls_long(e.grain);
+	snprintf(detail_location, sizeof(detail_location),
+		 "APEI location: %s %s", e.location, e.other_detail);
+	trace_mc_event(type, msg, e.label, e.error_count,
+		       0, e.top_layer, e.mid_layer, e.low_layer,
+		       (e.page_frame_number << PAGE_SHIFT) | e.offset_in_page,
+		       grain_bits, e.syndrome, detail_location);
+
+	edac_raw_mc_handle_error(type, ghes_mci, &e);
+
+unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
 
@@ -500,6 +500,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	ghes_pvt	= mci->pvt_info;
 	ghes_pvt->ghes	= ghes;
 	ghes_pvt->mci	= mci;
+	ghes_mci	= mci;
 
 	mci->pdev = dev;
 	mci->mtype_cap = MEM_FLAG_EMPTY;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
