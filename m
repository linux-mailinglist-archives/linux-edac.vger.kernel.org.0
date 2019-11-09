Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522C3F5E34
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 10:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKIJIg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 04:08:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfKIJIg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 9 Nov 2019 04:08:36 -0500
Received: from zn.tnic (p200300EC2F1EA7009D7000FE00A4E362.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:a700:9d70:fe:a4:e362])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D52C1EC0716;
        Sat,  9 Nov 2019 10:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573290514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=No8b8en5ogzJh4B5ENDF8gmhuPMql4+9x8/mZNC194c=;
        b=F/Doc6ae6PZ+fX5F4GB/cGgnirsztA3mK7rp8bTmxXmu21kAfTH+bOqCD+hliwndAlb/6X
        wmdy1J793ES47X29MsutOWd0FQojmjuubtFMh4Tx9dTmJobf4CewQnIDoM1DKobMR1orEL
        JgUkuEd86etFPnNlOvVYYU7K2g6d+s8=
Date:   Sat, 9 Nov 2019 10:08:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/amd64: Get rid of the ECC disabled long message
Message-ID: <20191109090829.GA2699@zn.tnic>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic>
 <20191107103857.GC19501@zn.tnic>
 <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191107154006.GF19501@zn.tnic>
 <SN6PR12MB263925E6F18C3EDC8D398932F8780@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191107193429.GI19501@zn.tnic>
 <SN6PR12MB26395B751A59D86EFF3A77EBF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26395B751A59D86EFF3A77EBF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Ok, I've queued this:

---
From: Borislav Petkov <bp@suse.de>
Date: Sat, 9 Nov 2019 10:00:54 +0100

This message keeps flooding dmesg on boxes where ECC is disabled or the
DIMMs do not support ECC but the module gets auto-probed. What's even
worse is that autoprobing happens on every CPU due to the CPU-family
matching the driver does and uevent being generated for each CPU device.

What is more, this message is becoming even more useless on newer
systems where forcing ECC is not recommended and it should be done in
the BIOS so the BIOS can do all the necessary work, i.e., just setting a
bit in an MSR is not enough anymore.

So get rid of it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org
Link: https://lkml.kernel.org/r/20191106160607.GC28380@zn.tnic
---
 drivers/edac/amd64_edac.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3aeb5173e200..428ce98f6776 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3188,18 +3188,6 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
 		amd64_warn("Error restoring NB MCGCTL settings!\n");
 }
 
-/*
- * EDAC requires that the BIOS have ECC enabled before
- * taking over the processing of ECC errors. A command line
- * option allows to force-enable hardware ECC later in
- * enable_ecc_error_reporting().
- */
-static const char *ecc_msg =
-	"ECC disabled in the BIOS or no ECC capability, module will not load.\n"
-	" Either enable ECC checking or force module loading by setting "
-	"'ecc_enable_override'.\n"
-	" (Note that use of the override may cause unknown side effects.)\n";
-
 static bool ecc_enabled(struct amd64_pvt *pvt)
 {
 	u16 nid = pvt->mc_node_id;
@@ -3246,11 +3234,10 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 	amd64_info("Node %d: DRAM ECC %s.\n",
 		   nid, (ecc_en ? "enabled" : "disabled"));
 
-	if (!ecc_en || !nb_mce_en) {
-		amd64_info("%s", ecc_msg);
+	if (!ecc_en || !nb_mce_en)
 		return false;
-	}
-	return true;
+	else
+		return true;
 }
 
 static inline void
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
