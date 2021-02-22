Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823EB321CBA
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBVQVQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 11:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBVQUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 11:20:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5170C06178A;
        Mon, 22 Feb 2021 08:20:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id t11so30320669ejx.6;
        Mon, 22 Feb 2021 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MfK8XHAdcFYl+ELW5xxKLzANic1ppzZqbz8B/li+uL0=;
        b=JHfGm8yVHwxZPf1iUJfWCfKokEIq00zIu1r3zSKaL8r+o0ieJOHCAX1NqngoexxyPT
         uilSl8cC3AJ28SpXBDlsveYM46RxtAgtt8Xkv2Cfu4xiMLXGm24Ik5M5ADXLbtGWhC0q
         snRCaMCtVoVOgtem5i2AgQAkL2nyP5BB5GHBNmVYCNgk3UhtK3uOUqFIvMDhpPfQF/FM
         IRpPlhAqgPRx6TxwyyhqcS3+OLNwmLbvqhV3EIJ0EJJVJvFz+LEvexK7MZK8GVTFQywL
         wzTlc5O1JkTOnGCeLXsxiUhz0/XsWz1TE2KeED3QN81NZffESJIUMSzQUdPng+GO93Y0
         BLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MfK8XHAdcFYl+ELW5xxKLzANic1ppzZqbz8B/li+uL0=;
        b=Y1XatKwg+HcjoI6Dyje4sonXm4Hfu7Da09EInuL2xEDn/YhJER5wZNy7T0rUnlj4Ye
         xCx09h/K4EYfWH5u6Z+1eBIDvfToUM+DCYcYLlVcTg4+bSQFDbNfB5FhDqq7L+j5js5L
         pv9wKvV2POI26V2NspPdNrUh7j/PY0yLmj6SCuT3DYzGr2FpQHiLvM5uxiDElDT7EroP
         9m8xJ9+yt41tSk+/yqqg5kOvZY10gJf2jLn362NvNf4Kxvrtcm4aj1E7T3HQIbRgpZTW
         yEtAY/Hl1/M0yvbWC5WWId+VgIqNAWKSKcEz2ji2OhJJoK7lECMVwHTak/9YGGu2CKjH
         JJLA==
X-Gm-Message-State: AOAM533jGG69YW3gssztxTJtFcSTA+MQh3gh6eN5LX7UfCpgcQKz7g6W
        VNZSXVZSN48515IFRJRfUu4=
X-Google-Smtp-Source: ABdhPJwCh2CPblEXvQM0Cp38XdCGExRMxECymPWlMvx13Qrcot9dBPJVxJBX+umvjcqn6cx7m3XcQQ==
X-Received: by 2002:a17:907:728b:: with SMTP id dt11mr21477172ejc.321.1614010807589;
        Mon, 22 Feb 2021 08:20:07 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d6b:2000:6504:2c93:2a67:f7e2])
        by smtp.gmail.com with ESMTPSA id i7sm67876ejf.59.2021.02.22.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:20:07 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/5] arch: mips: update references to current linux-mips list
Date:   Mon, 22 Feb 2021 17:19:03 +0100
Message-Id: <20210222161905.1153-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The linux-mips mailing list now lives at kernel.org. Update all references
in the kernel tree.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/kernel/r4k-bugs64.c | 2 +-
 arch/mips/lib/iomap-pci.c     | 2 +-
 arch/mips/sgi-ip32/ip32-irq.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/r4k-bugs64.c b/arch/mips/kernel/r4k-bugs64.c
index 1ff19f1ea5ca..35729c9e6cfa 100644
--- a/arch/mips/kernel/r4k-bugs64.c
+++ b/arch/mips/kernel/r4k-bugs64.c
@@ -18,7 +18,7 @@
 static char bug64hit[] __initdata =
 	"reliable operation impossible!\n%s";
 static char nowar[] __initdata =
-	"Please report to <linux-mips@linux-mips.org>.";
+	"Please report to <linux-mips@vger.kernel.org>.";
 static char r4kwar[] __initdata =
 	"Enable CPU_R4000_WORKAROUNDS to rectify.";
 static char daddiwar[] __initdata =
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index 210f5a95ecb1..a9cb28813f0b 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -32,7 +32,7 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
 		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
 		printk(KERN_WARNING "io_map_base of root PCI bus %s unset.  "
 		       "Trying to continue but you better\nfix this issue or "
-		       "report it to linux-mips@linux-mips.org or your "
+		       "report it to linux-mips@vger.kernel.org or your "
 		       "vendor.\n", name);
 #ifdef CONFIG_PCI_DOMAINS
 		panic("To avoid data corruption io_map_base MUST be set with "
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index 1bbd5bfb5458..e21ea1de05e3 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -343,7 +343,7 @@ static void ip32_unknown_interrupt(void)
 	printk("Register dump:\n");
 	show_regs(get_irq_regs());
 
-	printk("Please mail this report to linux-mips@linux-mips.org\n");
+	printk("Please mail this report to linux-mips@vger.kernel.org\n");
 	printk("Spinning...");
 	while(1) ;
 }
-- 
2.17.1

