Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6351FBCDB
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgFPR1v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgFPR1t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 13:27:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74493C061573;
        Tue, 16 Jun 2020 10:27:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0F181EC0390;
        Tue, 16 Jun 2020 19:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592328468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyW1nFC270vzg9dZNSbY8jBdqqKGfBT20wS5Uy1NXJQ=;
        b=pPVl2rbPzfJ7lJ0LphheZhzBGD+DiidhaxraCQHeVV6cE7cFqBKc0MSVXjHxjLM07ZrWfi
        Ram5y2V+Mis1qeJBHk38EbZpO3QcASxuwPAQW8//Q1opg1Bq9eR2PQ/XptvBSKnMIrzgcA
        8l4ixUmdQx0qmokMfWNupDjyThxwJYA=
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] EDAC/ghes: Setup DIMM label from DMI and use it in error reports
Date:   Tue, 16 Jun 2020 19:27:34 +0200
Message-Id: <20200616172737.30171-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200616172737.30171-1-bp@alien8.de>
References: <20200616172737.30171-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

The ghes driver reports errors with 'unknown label' even if the actual
DIMM label is known, e.g.:

 EDAC MC0: 1 CE Single-bit ECC on unknown label (node:0 card:0
   module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM location:N0 DIMM_A0
   page:0x966a9b3 offset:0x0 grain:1 syndrome:0x0 - APEI location:
   node:0 card:0 module:0 rank:1 bank:0 col:13 bit_pos:16 DIMM
   location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
   DRAM memory)

Fix this by using struct dimm_info's label string in error reports:

 EDAC MC0: 1 CE Single-bit ECC on N0 DIMM_A0 (node:0 card:0 module:0
   rank:1 bank:515 col:14 bit_pos:16 DIMM location:N0 DIMM_A0
   page:0x99223d8 offset:0x0 grain:1 syndrome:0x0 - APEI location:
   node:0 card:0 module:0 rank:1 bank:515 col:14 bit_pos:16 DIMM
   location:N0 DIMM_A0 status(0x0000000000000400): Storage error in
   DRAM memory)

The labels are initialized by reading the bank and device strings
from DMI. Now, the label information can also read from sysfs. E.g. a
ThunderX2 system will show the following:

  /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
  /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
  /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
  /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
  /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
  /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
  /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
  /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
  /sys/devices/system/edac/mc/mc0/dimm8/dimm_label:N1 DIMM_I0
  /sys/devices/system/edac/mc/mc0/dimm9/dimm_label:N1 DIMM_J0
  /sys/devices/system/edac/mc/mc0/dimm10/dimm_label:N1 DIMM_K0
  /sys/devices/system/edac/mc/mc0/dimm11/dimm_label:N1 DIMM_L0
  /sys/devices/system/edac/mc/mc0/dimm12/dimm_label:N1 DIMM_M0
  /sys/devices/system/edac/mc/mc0/dimm13/dimm_label:N1 DIMM_N0
  /sys/devices/system/edac/mc/mc0/dimm14/dimm_label:N1 DIMM_O0
  /sys/devices/system/edac/mc/mc0/dimm15/dimm_label:N1 DIMM_P0

Since dimm_labels can be rewritten, that label will be used in a later
error report:

  # echo foobar >/sys/devices/system/edac/mc/mc0/dimm0/dimm_label
  # # some error injection here
  # dmesg | grep foobar
  [ 751.383533] EDAC MC0: 1 CE Single-bit ECC on foobar (node:0 card:0
  module:0 rank:1 bank:259 col:3 bit_pos:16 DIMM location:N0 DIMM_A0
  page:0x8c8dc74 offset:0x0 grain:1 syndrome:0x0 - APEI location:
  node:0 card:0 module:0 rank:1 bank:259 col:3 bit_pos:16 DIMM
  location:N0 DIMM_A0 status(0x0000000000000400): Storage error in DRAM
  memory)

 [ bp: Remove curly brackets around a single if-statement in dimm_setup_label(). ]

Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200528101307.23245-1-rrichter@marvell.com
---
 drivers/edac/ghes_edac.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..94c70c95a896 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -87,16 +87,27 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
+static struct dimm_info *find_dimm_by_handle(struct mem_ctl_info *mci, u16 handle)
 {
 	struct dimm_info *dimm;
 
 	mci_for_each_dimm(mci, dimm) {
 		if (dimm->smbios_handle == handle)
-			return dimm->idx;
+			return dimm;
 	}
 
-	return -1;
+	return NULL;
+}
+
+static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
+{
+	const char *bank = NULL, *device = NULL;
+
+	dmi_memdev_name(handle, &bank, &device);
+
+	/* both strings must be non-zero */
+	if (bank && *bank && device && *device)
+		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
 }
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
@@ -179,9 +190,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		dimm->dtype = DEV_UNKNOWN;
 		dimm->grain = 128;		/* Likely, worse case */
 
-		/*
-		 * FIXME: It shouldn't be hard to also fill the DIMM labels
-		 */
+		dimm_setup_label(dimm, entry->handle);
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
@@ -228,7 +237,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	memset(e, 0, sizeof (*e));
 	e->error_count = 1;
 	e->grain = 1;
-	strcpy(e->label, "unknown label");
 	e->msg = pvt->msg;
 	e->other_detail = pvt->other_detail;
 	e->top_layer = -1;
@@ -345,7 +353,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
-		int index = -1;
+		struct dimm_info *dimm;
 
 		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
 		if (bank != NULL && device != NULL)
@@ -354,13 +362,18 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
 
-		index = get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
-		if (index >= 0)
-			e->top_layer = index;
+		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strcpy(e->label, dimm->label);
+		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
 
+	if (!*e->label)
+		strcpy(e->label, "unknown memory");
+
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
 	p += snprintf(p, sizeof(pvt->other_detail),
-- 
2.21.0

