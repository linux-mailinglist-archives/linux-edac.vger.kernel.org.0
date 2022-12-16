Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10E64E7C5
	for <lists+linux-edac@lfdr.de>; Fri, 16 Dec 2022 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLPHcL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Dec 2022 02:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLPHcJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Dec 2022 02:32:09 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9303B9D5;
        Thu, 15 Dec 2022 23:32:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g1so1236723pfk.2;
        Thu, 15 Dec 2022 23:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/rJpdWzIaY9d1c2EPyFR6eEs/FbkRXh+i26sis/kko=;
        b=iy7gtqzYwFpbrFJZ2i574V5yNAE2LG7GKTuXah46/YCfmlTFEZtKynM91LuatD2Rbl
         Jd79k8VsIJxutcLx0hKZKkhPK8XyakhIIVGL4Hos6QZqztVDMAuj3RziEKVqsmsoCaOD
         hzm2cR9g90qtFeIyRKLwnMQiot3hYQi5tc2J7uxl8rXIAqcRUYCLthfqyjzffE2dWP5z
         /fcZYRhPvSMTaTrRwmZJq/WD9GX3pzSVfWfItJ5nD/mca3lKp8c2pdpgPSdMRN+qjDka
         G3zWrYLC6nR2TUBqrbdiKnop2ztgvFMAJ4dBjAaHd7PaV3BQjAw/OKWNhzLKASlskB/z
         2odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/rJpdWzIaY9d1c2EPyFR6eEs/FbkRXh+i26sis/kko=;
        b=l58S9n+S7ZHdoETPzPxAJ6CRIxeNBa8Gn/6XM8lX/+gllY0ETrKjTGzGfU1VplnmZa
         08KkbxFpRDBaQ6RkvOZ1qbmruckvyW+MS/c38bkx5HPU8KNVC/AeaBNI7h7HSKQTOhlh
         +L1UFiMlvzipZ4vzkVJ6oq+4JlmjbUqKZewrpoibYqPLwe7VzXF6HBpX72KMNMR8/U7r
         weB8YN38jzI0IbIBE4Mnn95het0FnrR4IaxamR/pF0WOKObXTpH1nh5w2zddX2tm3aLb
         nRTpmdppZNQhhW0m3yyAt53EbE9BWbYdfl6E2mDv/x2rpyuQu48rHlI9L62ITPJKtFvT
         YrMQ==
X-Gm-Message-State: ANoB5pm5xQre+SUeEQMnVxn19CWQi8qYel1x+p3hQuivwFfWnFv1R++l
        wNWpsXJAp9ynmcG0Lgr3DniaAN4+4zbcdQ==
X-Google-Smtp-Source: AA0mqf7auwliSwA6t25hCI7z8wM800mt93XecjPKTKJeQL8XeD+TgTEvagUGm1LZ8enEDLc3SBOeHQ==
X-Received: by 2002:aa7:910f:0:b0:57b:5770:fd7e with SMTP id 15-20020aa7910f000000b0057b5770fd7emr11239315pfh.1.1671175928285;
        Thu, 15 Dec 2022 23:32:08 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 193-20020a6217ca000000b00574cf11aaf3sm770123pfx.208.2022.12.15.23.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 23:32:07 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v16 1/3] Arm: dts: nuvoton: Add node for NPCM memory controller
Date:   Fri, 16 Dec 2022 15:31:39 +0800
Message-Id: <20221216073141.3289309-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216073141.3289309-1-milkfafa@gmail.com>
References: <20221216073141.3289309-1-milkfafa@gmail.com>
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

