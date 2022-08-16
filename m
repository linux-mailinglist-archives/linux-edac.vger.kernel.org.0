Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E605959DD
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiHPLXI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 07:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiHPLWr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 07:22:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D715AA02;
        Tue, 16 Aug 2022 02:47:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p18so8723656plr.8;
        Tue, 16 Aug 2022 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=VJ968BoY2rUzhLmsHDPQEskN2/sLj9tYLwAiHbWfm18=;
        b=Mc0DJiitfZOS7yCuxHzYvAvxlxSXcfp4aULNBPnyc9MWQPwOM+x1ti8LNP+vpV6e2m
         uy2GmvN+b6M8Ro4qtjJ4r0hwOvKLverubGhrSjaMcfIIVFSdHmdJUfVj1FZL4nmguh83
         ml/5Uon6NXQI5SqHGyPbr9SfXfD90gFwujntLmmslNVRYapTZ5oTs7BAXc9rAUck56dr
         OWtim8Ag4JsLk0czDZBsqRAkFQcVBs6y3LYEE1snuEv0XHrjWeVsXuwzQYDereRUsrEz
         Otk0mWwa3pRihAdSKyAWg/cbzFR4MLJeNXAQLWxzemq+TvOIOssNXkO4R0EIub/Bz3IG
         Un1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=VJ968BoY2rUzhLmsHDPQEskN2/sLj9tYLwAiHbWfm18=;
        b=uolYMcwIYxZUNdo1m8AiT2Vod/lhGZrQXsIGVyZrjwxbWjSl9ke8lu655AWtGNCWZV
         umMyO9iZjMEvEH6oWwpqVI2mGQDR1h4bnWqhrYbq8W9/K51JMF1KuepVcPJZM9zCyTD4
         e+P4pfxk25PuTaR+OddHTfW0zwwk5nUHLaJf/URcYNVN+7BcJXTueODnQNrcW02EnS99
         CPXfkwq0XBFGdYhiYIme3BXJ5j0+SDc11wW8fAHxNwuv5Ry0J9idAQxQ/cP1AOQ91rDP
         /5e8l76L4kDFVpKsox3VUxtg9m1C8dWpOq9ZUPAE7f8W/GhkocWdtocdlJoI12rsqJ/0
         KQIw==
X-Gm-Message-State: ACgBeo3XnFETq/4cljM02N9zce0x21Y7v/hyyplOdOfxLfoMrtznqPTi
        DGyfPQlvGOPJNSJrvlJ4BrJj0Zw3a0SAqw==
X-Google-Smtp-Source: AA6agR7cUWZTBQOpiOYX6A7EaMt6CjvbcvtlD61oa6kpcAIGsXGbRz+Ybp6LF76hf3q2v1MC8dFI4Q==
X-Received: by 2002:a17:90a:c782:b0:1f7:a4ed:11a1 with SMTP id gn2-20020a17090ac78200b001f7a4ed11a1mr23516647pjb.12.1660643221832;
        Tue, 16 Aug 2022 02:47:01 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902e98c00b0016bee668a5asm8578767plb.161.2022.08.16.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:47:01 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v13 1/3] arm: dts: nuvoton: Add node for NPCM memory controller
Date:   Tue, 16 Aug 2022 17:46:39 +0800
Message-Id: <20220816094641.8484-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816094641.8484-1-milkfafa@gmail.com>
References: <20220816094641.8484-1-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add node for memory controller present on Nuvoton NPCM SoCs. The memory
controller supports single bit error correction and double bit error
detection.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..d875e8ac1e09 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,13 @@
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
2.17.1

