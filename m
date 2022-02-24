Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF64C249C
	for <lists+linux-edac@lfdr.de>; Thu, 24 Feb 2022 08:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiBXHsU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Feb 2022 02:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBXHsU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Feb 2022 02:48:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5931704C4;
        Wed, 23 Feb 2022 23:47:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l9so557956pls.6;
        Wed, 23 Feb 2022 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lhYNg8GMF1N+MEP55KAG4b8yDkrDo7A6Roxvv5yYMtU=;
        b=qPW+/TKNMdfryYrGLo7YrU0iyxsHA3bhaCEyUYtXnkIpG7Y6hfcFJpGnNZsqTqE+GR
         99+a9JsBmYjkxxOswSvZ0MQinBYdvJ0ZFAKTpStLCBnubRsSVWJ8dhs/gWc1qL08x591
         8ATbcaqZ7J3ECMMH3oFDMI18IvTLpVCkpCKIqSWCki0D5QvxZ+cR6DX2aF876bJQ6XoV
         0o9G7YAz7cXhuqiE/PsL0WKy1KMZBdIGB+P59Z0+yDtmipD/6pIhTSe72nJ6wCIB/BgK
         RU5vhuKFp5yuFxW55L9RL7r3p+F7GumpBpi8RoqQEjEgNTJJPHlru8Qm9UewpukOv+nh
         yz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lhYNg8GMF1N+MEP55KAG4b8yDkrDo7A6Roxvv5yYMtU=;
        b=1CAQ7Mvyfgu5dcWBFWsScKFObYEnpFLdsbHoBhPYLW9ZuafdfOVqZZUBvTdNPhplXI
         0VnKdvkzcd/yBDqO4Ob4GL1eY8iw67WRb4e+y8OgyHogMbY7aO6Y4DFZfTFtY/gaU7as
         9RapEwfr+qGzuBKSl46YJOurvfPm6Ceto88J787EXafJaFWplE3HuD8c5g4ABaivI6B6
         Zdt5J4zt/3KCIuY5RLda6RFePKodanyztPLcvY3GIyr/nyCAs2JC7pPEnRposJHpLaZ0
         FiW91cd0rZ/70RfSqPm0taKfZSHPdRjKQMzQw0kV5r3mp9Pqg2iLmRKhbqhDCDJm8fda
         rmyg==
X-Gm-Message-State: AOAM5302TOBsti2Fo7YX5BOtoxv375COn9u8yk0XINodMTZZwIE3d2Rx
        bRtka3hShapqjAYtgpxZwgE=
X-Google-Smtp-Source: ABdhPJxevCQqyyqcbABclH2PnGFNzAoleD3glcYbnfTgWkmGXR/VuOt5kI9H4WEZ/pfQ/fIFpdFqHw==
X-Received: by 2002:a17:90b:fc7:b0:1bc:4fc0:6fbd with SMTP id gd7-20020a17090b0fc700b001bc4fc06fbdmr1546709pjb.198.1645688870713;
        Wed, 23 Feb 2022 23:47:50 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.140])
        by smtp.gmail.com with ESMTPSA id z21sm1616839pgv.21.2022.02.23.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 23:47:50 -0800 (PST)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>
Subject: [PATCH v1 1/3]  ARM: dts: nuvoton: Add new device node
Date:   Thu, 24 Feb 2022 15:47:27 +0800
Message-Id: <20220224074729.5206-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224074729.5206-1-ctcchien@nuvoton.com>
References: <20220224074729.5206-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

 Add NPCM7xx EDAC device node

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..0fb2465c218e 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -106,6 +106,13 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
+		mc: memory-controller@f0824000 {
+			compatible = "nuvoton,npcm7xx-edac";
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

