Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA434E6924
	for <lists+linux-edac@lfdr.de>; Thu, 24 Mar 2022 20:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbiCXTOf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Mar 2022 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCXTOe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Mar 2022 15:14:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9A10D;
        Thu, 24 Mar 2022 12:13:00 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2723D1EC064C;
        Thu, 24 Mar 2022 20:12:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648149175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C1OkYvs9cReO/b4n86DotV7napDICScYJeQn5JQy0cw=;
        b=XoiTeeUUxyO8kMPIsm9HNc/LrQ/O77aPApgys5fvyH+idB/sz8mneCuYiQ8SwU1wFL34MC
        mOnRIWQG4xzBL8Qq2VQ6ZLkoipHxv/wyTujtXlcYQBD7y+z5cVSpq0nMfklrCcJ6KwN3T9
        LoPiaWN9ufcr52goNDTCiSTSLcrIuy8=
Date:   Thu, 24 Mar 2022 20:10:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2] x86/amd_nb: unexport amd_cache_northbridges()
Message-ID: <YjzCMYxgraTI7wrY@zn.tnic>
References: <20220324122729.221765-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324122729.221765-1-nchatrad@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 24, 2022 at 05:57:29PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> amd_cache_northbridges() is exported by amd_nb.c and is used by
> amd64-agp.c and amd64_edac.c modules.
> 
> init_amd_nbs() already calls amd_cache_northbridges() unconditionally,
> during fs_initcall() phase, which happens before the device_initcall().

No, that's not even trying. I went and did your work for you. Please
try harder in the future to really really explain why you're doing what
you're doing so that a reader of your commit message can easily follow
your logic and not have to do research just to figure out why your
change is ok.

---
From f5e82ad4c749afb63cdebba6729452e516bc1fa9 Mon Sep 17 00:00:00 2001
From: Muralidhara M K <muralimk@amd.com>
Date: Thu, 24 Mar 2022 17:57:29 +0530
Subject: [PATCH] x86/amd_nb: Unexport amd_cache_northbridges()

amd_cache_northbridges() is exported by amd_nb.c and is called by
amd64-agp.c and amd64_edac.c modules at module_init() time so that NB
descriptors are properly cached before those drivers can use them.

However, the init_amd_nbs() initcall already does call
amd_cache_northbridges() unconditionally and thus makes sure the NB
descriptors are enumerated.

That initcall is a fs_initcall type which is on the 5th group (starting
from 0) of initcalls that gets run in increasing numerical order by the
init code.

The module_init() call is turned into an __initcall() in the MODULE=n
case and those are device-level initcalls, i.e., group 6.

Therefore, the northbridges caching is already finished by the time
module initialization starts and thus the correct initialization order
is retained.

Unexport amd_cache_northbridges(), update dependent modules to
call amd_nb_num() instead. While at it, simplify the checks in
amd_cache_northbridges().

  [ bp: Heavily massage and *actually* explain why the change is ok. ]

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324122729.221765-1-nchatrad@amd.com
---
 arch/x86/include/asm/amd_nb.h | 1 -
 arch/x86/kernel/amd_nb.c      | 7 +++----
 drivers/char/agp/amd64-agp.c  | 2 +-
 drivers/edac/amd64_edac.c     | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00d1a400b7a1..ed0eaf65c437 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -16,7 +16,6 @@ extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
 
 extern bool early_is_amd_nb(u32 value);
 extern struct resource *amd_get_mmconfig_range(struct resource *res);
-extern int amd_cache_northbridges(void);
 extern void amd_flush_garts(void);
 extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 020c906f7934..190e0f763375 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -188,7 +188,7 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
 
-int amd_cache_northbridges(void)
+static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *link_ids = amd_nb_link_ids;
@@ -210,14 +210,14 @@ int amd_cache_northbridges(void)
 	}
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)))
 		misc_count++;
 
 	if (!misc_count)
 		return -ENODEV;
 
 	root = NULL;
-	while ((root = next_northbridge(root, root_ids)) != NULL)
+	while ((root = next_northbridge(root, root_ids)))
 		root_count++;
 
 	if (root_count) {
@@ -290,7 +290,6 @@ int amd_cache_northbridges(void)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_cache_northbridges);
 
 /*
  * Ignores subdevice/subvendor but as far as I can figure out
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index dc78a4fb879e..84a4aa9312cf 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -327,7 +327,7 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 {
 	int i;
 
-	if (amd_cache_northbridges() < 0)
+	if (!amd_nb_num())
 		return -ENODEV;
 
 	if (!amd_nb_has_feature(AMD_NB_GART))
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fba609ada0e6..af2c578f8ab3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4269,7 +4269,7 @@ static int __init amd64_edac_init(void)
 	if (!x86_match_cpu(amd64_cpuids))
 		return -ENODEV;
 
-	if (amd_cache_northbridges() < 0)
+	if (!amd_nb_num())
 		return -ENODEV;
 
 	opstate_init();
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
