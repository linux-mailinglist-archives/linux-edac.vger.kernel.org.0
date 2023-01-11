Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B687665795
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jan 2023 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAKJfw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Jan 2023 04:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjAKJet (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Jan 2023 04:34:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD411C0B;
        Wed, 11 Jan 2023 01:33:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so3237957pjb.1;
        Wed, 11 Jan 2023 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/rJpdWzIaY9d1c2EPyFR6eEs/FbkRXh+i26sis/kko=;
        b=PuwOwmy/u+HrxevdZjRX5deiNgIKXyH+IEixBVNqDoCHCU8DNlbvQ0w3csiuzeeRET
         XVKBngCbVEaJTjuKU5s7p22DnatmncfhOLyicBCD0X/WqkPFPRJmyhhAyKhNdSFLjHO9
         v1Y5vbPQZmi0tj4wjb0883cDT4tkXn2aWwDuXZtXsHT93rtwyHCpsVqxmRC7e8yA9938
         7EjlsQLTVQapdpbML3tuOMmYUvYMLUCM7NMzK5AtBptRqEwsXDEceJd5bzfmFFQOPA0U
         NvD9KGFMAM2c26JuYuAyKMn2pKvOrKlIuHvgqQYYUPe6T0xhyB+6jL1dmgRlLuf0pqOL
         2gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/rJpdWzIaY9d1c2EPyFR6eEs/FbkRXh+i26sis/kko=;
        b=pb4Q9Qa/Bdc4eVn00PDHa6EVvDxoRtwvGDaHYWSnfuKOtw4x5zoGsWwzrF4L6b586Z
         sHTNA7CRfxuL4QJOblKCVUWBiY4GxJyjdH4taRrKvDmLSX2RmdaDTpFMH2UexNRtWYSz
         u5lMxPHfL/3fb3DDF+nG5wmFIEfpOmhHoekJeQLIf3ku/lWq6EaUcWDeA4Nnl7CfHMSB
         PBMfEixe9aOFvI5Q1W/wrgiNVo6mXY2AHwFdBEtVfSyiRViqS9aMcJSYtDF5zyemMEnd
         AlHBpiLWI2RqJvDIc4c9FDb6vF3GMXiRx8bjpfBmvU48CzCO0nfOt+tv51KfktlkEET1
         4HJw==
X-Gm-Message-State: AFqh2kpWDMQsqxjznHctxTsIvw0l1MA9Zokdx6+d0m/YaT8V9mjvnUkn
        yvdf6MASrdIv4H2go9cExQk8BkW2iADKyg==
X-Google-Smtp-Source: AMrXdXuABVDv8CvIEbPtZ37RZbF6M6ibvQnFCYocTUZGQ8CZX64i+RSx0EueHceCmkpJhXDpIWlx0w==
X-Received: by 2002:a17:902:b713:b0:191:2a9c:52a1 with SMTP id d19-20020a170902b71300b001912a9c52a1mr72544630pls.19.1673429592130;
        Wed, 11 Jan 2023 01:33:12 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b001769e6d4fafsm2001341plm.57.2023.01.11.01.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:33:11 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory controller
Date:   Wed, 11 Jan 2023 17:32:43 +0800
Message-Id: <20230111093245.318745-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111093245.318745-1-milkfafa@gmail.com>
References: <20230111093245.318745-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add node for memory controller present on Nuvoton NPCM SoCs. The
memory controller supports single bit error correction and double bit
error detection.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..d875e8ac1e09 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,13 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		mc: memory-controller@f0824000 {
+			compatible = "nuvoton,npcm750-memory-controller";
+			reg = <0xf0824000 0x1000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.34.1

