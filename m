Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137B157E23F
	for <lists+linux-edac@lfdr.de>; Fri, 22 Jul 2022 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiGVNVG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jul 2022 09:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiGVNVD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Jul 2022 09:21:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252B89E89;
        Fri, 22 Jul 2022 06:20:59 -0700 (PDT)
Received: from zn.tnic (p200300ea97297665329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7665:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E72C31EC0373;
        Fri, 22 Jul 2022 15:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658496054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jqIWKFzofK/hquuTs8gPLhPJxEinKZkFL/u4Q+zV6r0=;
        b=eQ8zEqv7LeRk1n4XE+/eUIK2fFcfUkJlYiEwxLsxM4qIu6xWXYnXKa2glEqsw9FpxErs1P
        Zl+RKTk+gmGWptsaw5UlPgp4OF0sqq0LBYSh+mmrY4tYKUVz2CXYBsgj1T0tMbQg8SGMbO
        t+ER55ATGBjAEo30ir4cqUaT3deZeCA=
Date:   Fri, 22 Jul 2022 15:20:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     mchehab@kernel.org, elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <YtqkMicKdZdPdUWB@zn.tnic>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220721180503.896050-1-toshi.kani@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+ fix Robert's address.

On Thu, Jul 21, 2022 at 12:05:03PM -0600, Toshi Kani wrote:
> The following buffer overflow BUG was observed on an HPE system.
> ghes_edac_register() called strlen() on an uninitialized label,
> which had non-zero values from krealloc_array().

I ended up massaging it into this:

---
From: Toshi Kani <toshi.kani@hpe.com>
Date: Thu, 21 Jul 2022 12:05:03 -0600
Subject: [PATCH] EDAC/ghes: Set the DIMM label unconditionally

The commit in Fixes enforced that both the bank and device strings
passed to dimm_setup_label() are not NULL.

However, there are BIOSes, for example on a

  HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/15/2019

which don't populate both strings:

  Handle 0x0020, DMI type 17, 84 bytes
  Memory Device
          Array Handle: 0x0013
          Error Information Handle: Not Provided
          Total Width: 72 bits
          Data Width: 64 bits
          Size: 32 GB
          Form Factor: DIMM
          Set: None
          Locator: PROC 1 DIMM 1        <===== device
          Bank Locator: Not Specified   <===== bank

This results in a buffer overflow because ghes_edac_register() calls
strlen() on an uninitialized label, which had non-zero values left over
from krealloc_array():

  detected buffer overflow in __fortify_strlen
   ------------[ cut here ]------------
   kernel BUG at lib/string_helpers.c:983!
   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
   CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          I       5.18.6-200.fc36.x86_64 #1
   Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/15/2019
   RIP: 0010:fortify_panic
   ...
   Call Trace:
    <TASK>
    ghes_edac_register.cold
    ghes_probe
    platform_probe
    really_probe
    __driver_probe_device
    driver_probe_device
    __driver_attach
    ? __device_attach_driver
    bus_for_each_dev
    bus_add_driver
    driver_register
    acpi_ghes_init
    acpi_init
    ? acpi_sleep_proc_init
    do_one_initcall

Change dimm_setup_label() to always initialize the label and use
"N/A" in case bank or device is null.

  [ bp: Rewrite commit message. ]

Fixes: cb51a371d08e ("EDAC/ghes: Setup DIMM label from DMI and use it in error reports")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Robert Elliott <elliott@hpe.com>
Link: https://lore.kernel.org/r/20220719220124.760359-1-toshi.kani@hpe.com
---
 drivers/edac/ghes_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 59b0bedc9c24..fcab10e26b43 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -103,9 +103,9 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
 
 	dmi_memdev_name(handle, &bank, &device);
 
-	/* both strings must be non-zero */
-	if (bank && *bank && device && *device)
-		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
+	snprintf(dimm->label, sizeof(dimm->label), "%s %s",
+		 (bank && *bank) ? bank : "N/A",
+		 (device && *device) ? device : "N/A");
 }
 
 static void assign_dmi_dimm_info(struct dimm_info *dimm, struct memdev_dmi_entry *entry)
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
