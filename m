Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B9E3ADACB
	for <lists+linux-edac@lfdr.de>; Sat, 19 Jun 2021 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhFSQEQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 19 Jun 2021 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhFSQEP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 19 Jun 2021 12:04:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12641C061574;
        Sat, 19 Jun 2021 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yZ8EK1peAp+rZl27kQzykP0A4qIXhF51chdQ2bPPVLI=; b=fCjCu26Cv4SbTA95lx5fBaSHfw
        Eu7OaIBaVgzL1bI3leej0PLBVAHkWiXnT7aP4uyagGhvpojh7/uP+sxBC3r2Ng0pQ5IdmAqSHnmOK
        fqZQZU71msvGGcpB4UWM+aZDEkBuxdrj+4jy4a6ph7EjSV9Am3IH19w2isE07fu/Inb/dqJqYnCUx
        0OkXZo4Jp6XVvQ6XURTIUk2rpPM5uTA5IizYlfuzjUBvXjoSuHGIaVZ53FQk4mAIlCciwGmk7Qvi6
        NTfpa93G6uYJ951EzMXVRUy623he7XmGot5EvvMNcpn4Mf01OXcKKM7iJA7rae0PixaxAis7IUMTN
        XmOf5UHg==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ludQ4-00HFmD-6K; Sat, 19 Jun 2021 16:02:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/igen6: fix core dependency
Date:   Sat, 19 Jun 2021 09:02:03 -0700
Message-Id: <20210619160203.2026-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

igen6_edac needs mce_register()/unregister() functions,
so it should depend on X86_MCE (or X86_MCE_INTEL).

That change prevents these build errors:

ld: drivers/edac/igen6_edac.o: in function `igen6_remove':
igen6_edac.c:(.text+0x494): undefined reference to `mce_unregister_decode_chain'
ld: drivers/edac/igen6_edac.o: in function `igen6_probe':
igen6_edac.c:(.text+0xf5b): undefined reference to `mce_register_decode_chain'

Fixes: 10590a9d4f23e ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20210618.orig/drivers/edac/Kconfig
+++ linux-next-20210618/drivers/edac/Kconfig
@@ -270,7 +270,8 @@ config EDAC_PND2
 
 config EDAC_IGEN6
 	tristate "Intel client SoC Integrated MC"
-	depends on PCI && X86_64 && PCI_MMCONFIG && ARCH_HAVE_NMI_SAFE_CMPXCHG
+	depends on PCI && PCI_MMCONFIG && ARCH_HAVE_NMI_SAFE_CMPXCHG
+	depends on X64_64 && X86_MCE_INTEL
 	help
 	  Support for error detection and correction on the Intel
 	  client SoC Integrated Memory Controller using In-Band ECC IP.
