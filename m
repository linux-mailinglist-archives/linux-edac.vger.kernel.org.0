Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93B13E033
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jan 2020 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgAPQeP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 11:34:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48590 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgAPQeO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jan 2020 11:34:14 -0500
Received: from zn.tnic (p200300EC2F0B2300140B140D62B5CC9C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:140b:140d:62b5:cc9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F9FC1EC0391;
        Thu, 16 Jan 2020 17:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579192453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=waSyRTZ8/lhsXH/OWB+jXSGGZbqUfyQsZNqfwd45Pyo=;
        b=l95hx+vHGYmND/zji6oFl6ubsI9qlIfQDQcaNG6k1mwj2xsvhSmen9ZebR15aVwNP+DNFm
        zjbixr/RHLN4IjKAeMZZFtCTdzOleHhwAdFX27ysdtf1G8jiUGrdEsx9gghr9zVqQ6ouUS
        BhJ/nv1Mxka1+o/2Ennk/Sz0JhLnFDQ=
Date:   Thu, 16 Jan 2020 17:34:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 0/5] MCA and EDAC updates for AMD Family 19h
Message-ID: <20200116163403.GF27148@zn.tnic>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 10, 2020 at 01:56:46AM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Hi Boris,
> 
> This patchset adds MCA and EDAC support for AMD Family 19h.
> 
> There aren't any functional changes. Mostly we just need to add new PCI
> IDs and a new MCA bank type. I've also included a couple of patches that
> do away with family checks where appropriate.
> 
> Thanks,
> Yazen
> 
> Yazen Ghannam (5):
>   x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit McaType
>   EDAC/mce_amd: Always load on SMCA systems
>   x86/amd_nb: Add Family 19h PCI IDs
>   EDAC/amd64: Add family ops for Family 19h Models 00h-0Fh
>   EDAC/amd64: Drop some family checks for newer systems
> 
>  arch/x86/include/asm/mce.h    |  1 +
>  arch/x86/kernel/amd_nb.c      |  3 ++
>  arch/x86/kernel/cpu/mce/amd.c |  2 ++
>  drivers/edac/amd64_edac.c     | 62 ++++++++++++++++++++---------------
>  drivers/edac/amd64_edac.h     |  3 ++
>  drivers/edac/mce_amd.c        | 41 ++++++++++++++++++++---
>  include/linux/pci_ids.h       |  1 +
>  7 files changed, 82 insertions(+), 31 deletions(-)
> 
> -- 

Btw, I'll slap this ontop:

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 16 Jan 2020 17:28:39 +0100
Subject: [PATCH] EDAC/mce_amd: Make fam_ops static global

... and do not kmalloc a three-pointer struct. Which simplifies
mce_amd_init() a bit.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/mce_amd.c | 69 ++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 524c63fdad42..df95a05c9f23 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -6,7 +6,7 @@
 
 #include "mce_amd.h"
 
-static struct amd_decoder_ops *fam_ops;
+static struct amd_decoder_ops fam_ops;
 
 static u8 xec_mask	 = 0xf;
 
@@ -583,7 +583,7 @@ static void decode_mc0_mce(struct mce *m)
 					    : (xec ? "multimatch" : "parity")));
 			return;
 		}
-	} else if (fam_ops->mc0_mce(ec, xec))
+	} else if (fam_ops.mc0_mce(ec, xec))
 		;
 	else
 		pr_emerg(HW_ERR "Corrupted MC0 MCE info?\n");
@@ -697,7 +697,7 @@ static void decode_mc1_mce(struct mce *m)
 			pr_cont("Hardware Assert.\n");
 		else
 			goto wrong_mc1_mce;
-	} else if (fam_ops->mc1_mce(ec, xec))
+	} else if (fam_ops.mc1_mce(ec, xec))
 		;
 	else
 		goto wrong_mc1_mce;
@@ -831,7 +831,7 @@ static void decode_mc2_mce(struct mce *m)
 
 	pr_emerg(HW_ERR "MC2 Error: ");
 
-	if (!fam_ops->mc2_mce(ec, xec))
+	if (!fam_ops.mc2_mce(ec, xec))
 		pr_cont(HW_ERR "Corrupted MC2 MCE info?\n");
 }
 
@@ -1130,7 +1130,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (m->tsc)
 		pr_emerg(HW_ERR "TSC: %llu\n", m->tsc);
 
-	if (!fam_ops)
+	/* Doesn't matter which member to test. */
+	if (!fam_ops.mc0_mce)
 		goto err_code;
 
 	switch (m->bank) {
@@ -1185,10 +1186,6 @@ static int __init mce_amd_init(void)
 	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
-	fam_ops = kzalloc(sizeof(struct amd_decoder_ops), GFP_KERNEL);
-	if (!fam_ops)
-		return -ENOMEM;
-
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		xec_mask = 0x3f;
 		goto out;
@@ -1196,59 +1193,58 @@ static int __init mce_amd_init(void)
 
 	switch (c->x86) {
 	case 0xf:
-		fam_ops->mc0_mce = k8_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = k8_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x10:
-		fam_ops->mc0_mce = f10h_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = f10h_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x11:
-		fam_ops->mc0_mce = k8_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = k8_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x12:
-		fam_ops->mc0_mce = f12h_mc0_mce;
-		fam_ops->mc1_mce = k8_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = f12h_mc0_mce;
+		fam_ops.mc1_mce = k8_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x14:
-		fam_ops->mc0_mce = cat_mc0_mce;
-		fam_ops->mc1_mce = cat_mc1_mce;
-		fam_ops->mc2_mce = k8_mc2_mce;
+		fam_ops.mc0_mce = cat_mc0_mce;
+		fam_ops.mc1_mce = cat_mc1_mce;
+		fam_ops.mc2_mce = k8_mc2_mce;
 		break;
 
 	case 0x15:
 		xec_mask = c->x86_model == 0x60 ? 0x3f : 0x1f;
 
-		fam_ops->mc0_mce = f15h_mc0_mce;
-		fam_ops->mc1_mce = f15h_mc1_mce;
-		fam_ops->mc2_mce = f15h_mc2_mce;
+		fam_ops.mc0_mce = f15h_mc0_mce;
+		fam_ops.mc1_mce = f15h_mc1_mce;
+		fam_ops.mc2_mce = f15h_mc2_mce;
 		break;
 
 	case 0x16:
 		xec_mask = 0x1f;
-		fam_ops->mc0_mce = cat_mc0_mce;
-		fam_ops->mc1_mce = cat_mc1_mce;
-		fam_ops->mc2_mce = f16h_mc2_mce;
+		fam_ops.mc0_mce = cat_mc0_mce;
+		fam_ops.mc1_mce = cat_mc1_mce;
+		fam_ops.mc2_mce = f16h_mc2_mce;
 		break;
 
 	case 0x17:
 	case 0x18:
 		pr_warn("Decoding supported only on Scalable MCA processors.\n");
-		goto err_out;
-		break;
+		return -EINVAL;
 
 	default:
 		printk(KERN_WARNING "Huh? What family is it: 0x%x?!\n", c->x86);
-		goto err_out;
+		return -EINVAL;
 	}
 
 out:
@@ -1257,11 +1253,6 @@ static int __init mce_amd_init(void)
 	mce_register_decode_chain(&amd_mce_dec_nb);
 
 	return 0;
-
-err_out:
-	kfree(fam_ops);
-	fam_ops = NULL;
-	return -EINVAL;
 }
 early_initcall(mce_amd_init);
 
@@ -1269,7 +1260,7 @@ early_initcall(mce_amd_init);
 static void __exit mce_amd_exit(void)
 {
 	mce_unregister_decode_chain(&amd_mce_dec_nb);
-	kfree(fam_ops);
+	memset(&fam_ops, 0, sizeof(struct amd_decoder_ops));
 }
 
 MODULE_DESCRIPTION("AMD MCE decoder");
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
