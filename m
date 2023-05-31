Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8F717C3B
	for <lists+linux-edac@lfdr.de>; Wed, 31 May 2023 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjEaJmY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 31 May 2023 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEaJmX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 31 May 2023 05:42:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CECA0;
        Wed, 31 May 2023 02:42:22 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAAC51EC01E0;
        Wed, 31 May 2023 11:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685526140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tRKEhraKn5cLA/55uMlHmfD9+ojwagmlDVVmoryTtMo=;
        b=dECg9zlQJq18P2A0Z2UCzYhCVsTC1nedo0r442ej/mi5vo6mMskvKRfVXL0646BcxNnRDH
        jmlQuC6RZJwnzVVNICocPI9cBW+v+icm7as10mWj6bUeGUlfAYmVphe/8cJz659ckaYiVz
        aplxdefyJNUTFcgkI9rk+EGtCGlWML4=
Date:   Wed, 31 May 2023 11:42:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        yazen.ghannam@amd.com, nchatrad@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 1/5] x86/amd_nb: Add MI200 PCI IDs
Message-ID: <20230531094212.GHZHcWdMDkCpAp4daj@fat_crate.local>
References: <20230515113537.1052146-1-muralimk@amd.com>
 <20230515113537.1052146-2-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515113537.1052146-2-muralimk@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 15, 2023 at 11:35:33AM +0000, Muralidhara M K wrote:
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 7e331e8f3692..8fd955414b08 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -23,6 +23,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
>  #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
>  #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
> +#define PCI_DEVICE_ID_AMD_MI200_ROOT	0x14bb
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> @@ -37,6 +38,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
>  #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
> +#define PCI_DEVICE_ID_AMD_MI200_DF_F4	0x14d4

Ontop:

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 31 May 2023 11:39:57 +0200
Subject: [PATCH] x86/amd_nb: Re-sort and re-indent PCI defines

Sort them by family, model and type and align them vertically for better
readability.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/amd_nb.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 8fd955414b08..035a3db5330b 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,30 +15,31 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-#define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
-#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
-#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
-#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
-#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
-#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
-#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
-#define PCI_DEVICE_ID_AMD_MI200_ROOT	0x14bb
-#define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4 0x1728
-#define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
-#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
-#define PCI_DEVICE_ID_AMD_MI200_DF_F4	0x14d4
+#define PCI_DEVICE_ID_AMD_17H_ROOT		0x1450
+#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT		0x15d0
+#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT		0x1480
+#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT		0x1630
+#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT		0x14b5
+#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT		0x14a4
+#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
+#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
+#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
+#define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
+
+#define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4	0x1494
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4	0x144c
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4	0x1444
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4	0x1728
+#define PCI_DEVICE_ID_AMD_19H_DF_F4		0x1654
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4	0x14b1
+#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4	0x167d
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4	0x166e
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
+#define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
