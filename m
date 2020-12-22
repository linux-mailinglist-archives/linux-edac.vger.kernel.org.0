Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455B02E0E10
	for <lists+linux-edac@lfdr.de>; Tue, 22 Dec 2020 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgLVSA6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Dec 2020 13:00:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgLVSA6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Dec 2020 13:00:58 -0500
Received: from zn.tnic (p200300ec2f0ef2007354cce2a604b467.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f200:7354:cce2:a604:b467])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E15031EC047C;
        Tue, 22 Dec 2020 19:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608660017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yGOkMzQul/w6eCPpWTRobTNIWPZsEOMV9f86X1dGtTU=;
        b=A2DDqq7S8EaLV7u9R88N4bRkMF04hhF20OTbVG1Xsu//QnSC85o7OZvad+2VTJxE/J1A6V
        Son+Vp0PcZcOCuDPzDIEfJ+1VcZtt1QZV8ZRInARkbdJIc5E3ZbXgpho5mV0u3QXha6bcN
        SUm5xYF2qjz8lydO8gWYSMeIWxoRvBc=
Date:   Tue, 22 Dec 2020 19:00:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC/amd64: Merge error injection sysfs facilities
Message-ID: <20201222180013.GD13463@zn.tnic>
References: <20201215110517.5215-1-bp@alien8.de>
 <20201215110517.5215-2-bp@alien8.de>
 <20201215161120.GB2122783@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215161120.GB2122783@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 15, 2020 at 10:11:20AM -0600, Yazen Ghannam wrote:
> Related to the comment above, can this be changed to the following?
> 
> 	if (pvt->fam < 0x10 || pvt->fam >= 0x17)

I made that a "positive" list so that it is explicit which do support
it out of the box:

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 22 Dec 2020 18:55:06 +0100
Subject: [PATCH] EDAC/amd64: Limit error injection functionality to supported hw

Families up to and including 0x16 allow access to the injection
hardware. Starting with family 0x17, access to those registers is
blocked by security policy.

Limit that only on the families which support it.

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/Kconfig      | 8 ++++----
 drivers/edac/amd64_edac.c | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47953b06d6c8..27d0c4cdc58d 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -84,10 +84,10 @@ config EDAC_AMD64
 	  When EDAC_DEBUG is enabled, hardware error injection facilities
 	  through sysfs are available:
 
-	  Recent Opterons (Family 10h and later) provide for Memory Error
-	  Injection into the ECC detection circuits. The amd64_edac module
-	  allows the operator/user to inject Uncorrectable and Correctable
-	  errors into DRAM.
+	  AMD CPUs up to and excluding family 0x17 provide for Memory
+	  Error Injection into the ECC detection circuits. The amd64_edac
+	  module allows the operator/user to inject Uncorrectable and
+	  Correctable errors into DRAM.
 
 	  When enabled, in each of the respective memory controller directories
 	  (/sys/devices/system/edac/mc/mcX), there are 3 input files:
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d55f8ef2240c..9868f95a5622 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -828,9 +828,11 @@ static umode_t inj_is_visible(struct kobject *kobj, struct attribute *attr, int
 	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
 	struct amd64_pvt *pvt = mci->pvt_info;
 
-	if (pvt->fam < 0x10)
-		return 0;
-	return attr->mode;
+	/* Families which have that injection hw */
+	if (pvt->fam >= 0x10 && pvt->fam <= 0x16)
+		return attr->mode;
+
+	return 0;
 }
 
 static const struct attribute_group inj_group = {
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
