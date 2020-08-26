Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081C25297B
	for <lists+linux-edac@lfdr.de>; Wed, 26 Aug 2020 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHZIwf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Aug 2020 04:52:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgHZIwf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Aug 2020 04:52:35 -0400
Received: from zn.tnic (p200300ec2f0cee0024a26a8aa2aa63ac.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ee00:24a2:6a8a:a2aa:63ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCAAB1EC0301;
        Wed, 26 Aug 2020 10:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598431954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wrbb6+uQ8UOIr4v7FRvD1AMqEEw17QltJm0TB+jqX3o=;
        b=prQUtVvw0Qq/tyLheD2DsFqO43OeUlh1FWI3rxVJYaAbDeDvR8PdsrHjAGUio5RQAN5a8y
        SCLPdc+f9Uvp0ZaDRpRhKQ/QggwTagr7noZMK12Rfbik2J7S5JdFI6HMMxeILFJskXeavk
        D6JlkeEDtevC+evuE42all/VxRMwrxw=
Date:   Wed, 26 Aug 2020 10:52:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Message-ID: <20200826085229.GB22390@zn.tnic>
References: <20200825130108.2132-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825130108.2132-1-shiju.jose@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 25, 2020 at 02:01:08PM +0100, Shiju Jose wrote:
> After the 'commit b9cae27728d1 ("EDAC/ghes: Scan the system once on driver init")'
> applied, following error has occurred in ghes_edac_register() when
> CONFIG_DEBUG_TEST_DRIVER_REMOVE is enabled. The null ghes_hw.dimms pointer
> in the mci_for_each_dimm() of ghes_edac_register() caused the error.
> 
> The error occurs when all the previously initialized ghes instances are
> removed and then probe a new ghes instance. In this case, the ghes_refcount
> would be 0, ghes_hw.dimms and mci already freed. The ghes_hw.dimms would
> be null because ghes_scan_system() would not call enumerate_dimms() again.

Try the below instead and see if it fixes the issue for you too.

If it does, pls send it as v2 but do not add the splat to the commit
message - that's a lot of noise for something which is clear why it
happens and you explain it properly in text anyway.

Thx.

---
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index da60c29468a7..54ebc8afc6b1 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -55,6 +55,8 @@ static DEFINE_SPINLOCK(ghes_lock);
 static bool __read_mostly force_load;
 module_param(force_load, bool, 0);
 
+static bool system_scanned;
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -225,14 +227,12 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 
 static void ghes_scan_system(void)
 {
-	static bool scanned;
-
-	if (scanned)
+	if (system_scanned)
 		return;
 
 	dmi_walk(enumerate_dimms, &ghes_hw);
 
-	scanned = true;
+	system_scanned = true;
 }
 
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
@@ -631,6 +631,8 @@ void ghes_edac_unregister(struct ghes *ghes)
 
 	mutex_lock(&ghes_reg_mutex);
 
+	system_scanned = false;
+
 	if (!refcount_dec_and_test(&ghes_refcount))
 		goto unlock;
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
