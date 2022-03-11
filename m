Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDD4D577A
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 02:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiCKBoM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 20:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345416AbiCKBoK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 20:44:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913FE1795FC;
        Thu, 10 Mar 2022 17:43:07 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c11so6191500pgu.11;
        Thu, 10 Mar 2022 17:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GbrYLRy1W5aZewqUJiPpLaSO2PAR7xFlm0KF8fm8mKo=;
        b=EAl/7CigB5SVHJkwiwGkbitrg96A+cEiCSMckdj+NJiAGpCLvf664aUf1rcrLlH3L3
         DnDi7ddD/afc5MvPshGOGYdjCq+lG/xonM/1zH9eSa9ANdfmQ9Ui1BMzRCEclgwkD5Os
         yunus6AH+YVGHAhdZlsqDRh13OHFGRvxE3Zr7YVYbf/cYXsBNLL+M/HCov0/Ez0yo/LP
         S1s5gNKxpSl58YbFpXw6ZJr8aF6MmuOEhDi8a64FCCGznALoxPCdGY2U0faUxqws2Kdl
         pgqWCJid7aQR4+rYNJWTmsMdJlq7S4cak2QDikta7rVBXohwzKlDo9sEFLlNGeW0qVyd
         ijbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GbrYLRy1W5aZewqUJiPpLaSO2PAR7xFlm0KF8fm8mKo=;
        b=x4MHw3JQiwRBgRbbDGoTJqqo1tQaSNmFxRJ4iC/UzlmJA3/tz9I7iqrnj5ppWpRgEo
         y01CIy/T26ufQ2yyuB8wFOubGhhCq6bPkj+lXD6upkJ1YgUxvj4W4EZg8Wq12eLV8jan
         n9t3zx7hLrvzoEzdXNgK87aDZRrmAjRFIqm9SKJYnkGFAcSDbYPlZT2uYh4Nmi3sPbEH
         LwQT5d97mJdmWCP2yiS+d6C/h0cPuO5Kz0Nh0XIQi+OWPQ8oOWwbT/DFvJZ93y3o3hGT
         crehz2rk+g9/poZvO4wSvXxGO1ljj1zYbnbCCixRDXZklBWgOVer19HLY6NRNOuxGjH/
         BXaA==
X-Gm-Message-State: AOAM533iQxbT8dgePaNOwlqdXcW0Sf3sm9GQtd7czQeXHhma3jBlq+yz
        0URSkB6hgWHN40hCvBpDKXw=
X-Google-Smtp-Source: ABdhPJy0EmTMhPr3didLwQHpRflLIwW2lJsX4eanCr6kAJCQf4vaV84UdpC9oN/i/vbCkPKHn3t0Kg==
X-Received: by 2002:a63:4560:0:b0:370:1f21:36b8 with SMTP id u32-20020a634560000000b003701f2136b8mr6293000pgk.181.1646962982193;
        Thu, 10 Mar 2022 17:43:02 -0800 (PST)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a6b8500b001bf564e624esm7194383pjj.39.2022.03.10.17.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 17:43:01 -0800 (PST)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node
Date:   Fri, 11 Mar 2022 09:42:43 +0800
Message-Id: <20220311014245.4612-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311014245.4612-1-ctcchien@nuvoton.com>
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

 Add NPCM memory controller device node

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..ba542b26941e 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -106,6 +106,13 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
+		mc: memory-controller@f0824000 {
+			compatible = "nuvoton,npcm750-memory-controller";
+			reg = <0x0 0xf0824000 0x0 0x1000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		rstc: rstc@f0801000 {
 			compatible = "nuvoton,npcm750-reset";
 			reg = <0xf0801000 0x70>;
-- 
2.17.1

