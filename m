Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB44D942E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 06:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiCOF4f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 01:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiCOF4e (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 01:56:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC3F3A1A3;
        Mon, 14 Mar 2022 22:55:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n2so15398670plf.4;
        Mon, 14 Mar 2022 22:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3REtX15upPnaASwcpch/4bkCB1kjQjGAtbk3icoBvk=;
        b=fqStOFE1vmgjthxI4YsIA8/39Jf9+YX0GVkFXQfKJRJ6LNFACFyV7zI5XfD5e0MR1+
         oW+honQ7ip47qs3lPC63by32LSh9Q4ILyX/MNdqvKICnFu3InLcS7KBRJ8iJMfs3i8nq
         K6nBstw/YlnUwDnY6aNKyj3+H4Z/VmzDk8DOafs/VoU5v2MKdrTD8eheLAna78CeP6oy
         RBQyJtnMquDxg3dFEM4OLteUY4CS1GM3lNLN9zTmcKC3pvNVgTUikThbTt/cycK2K2yx
         mdx5c/jm9Xa6k+9I2c66l2Em89JzKfNIMHafpXp1jR0adX9xsPyEC9DXM4I+lg83hv97
         Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3REtX15upPnaASwcpch/4bkCB1kjQjGAtbk3icoBvk=;
        b=Vem8NvstB8stabXUsmtsMV8bNrd+eRBRywpTi3NoMbez5d+07c8V9BTZkww8cqxEhY
         YmrhHpI1OliQjQ9V7B4njdskxlezKvVVOXP0rP1fy5ccGUf1dOdNOfN9eOkzc2GF1gvQ
         HKdOiaGAB8MeUgZCb7L7uVO8VvaBiZzDsqrTzBL8hh9yzZHm4aZwYKyZe5FnfsR2Bcy4
         59ekeMsoWcmdovGLRvN/O+FAdT3nKgN1yJHUBr3677cBYJZmnmqq4j0q9CoLGwRM8tB1
         qQDGm1Ujak9TJ93o0g3WHugESFoXW50I0ascZL3kJztHyZIZEMOPkMmuWfnBciOuE+/8
         qfRQ==
X-Gm-Message-State: AOAM5304QHtkE6iEUTwIKogTj8GYr6Xo7u4CXVBERtn70x+uh4iF9QJg
        /EM98Z1PUjmDRf0M14KWljg=
X-Google-Smtp-Source: ABdhPJxJtul1cYpBHB8+Y1xnB+gHX1DlHpjgdiiw0swhCA4/vELU4Be2hfbIa+a6HcYjCJpemq8uFg==
X-Received: by 2002:a17:90b:4f8f:b0:1bf:84ad:1fe6 with SMTP id qe15-20020a17090b4f8f00b001bf84ad1fe6mr2747965pjb.189.1647323721509;
        Mon, 14 Mar 2022 22:55:21 -0700 (PDT)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b00368f3ba336dsm18679369pgk.88.2022.03.14.22.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 22:55:21 -0700 (PDT)
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
Subject: [PATCH v4 1/3] ARM: dts: nuvoton: Add memory controller node
Date:   Tue, 15 Mar 2022 13:55:02 +0800
Message-Id: <20220315055504.27671-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315055504.27671-1-ctcchien@nuvoton.com>
References: <20220315055504.27671-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ECC must be configured in the BootBlock header.
Then, you can read error counts via
the EDAC kernel framework.

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

