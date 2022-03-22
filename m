Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7CA4E3723
	for <lists+linux-edac@lfdr.de>; Tue, 22 Mar 2022 04:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiCVDDh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 23:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiCVDDh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 23:03:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5AD1D0D9;
        Mon, 21 Mar 2022 20:02:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s42so17171541pfg.0;
        Mon, 21 Mar 2022 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3REtX15upPnaASwcpch/4bkCB1kjQjGAtbk3icoBvk=;
        b=mcndclZ69T0N48qXn3ceqE3elir7q/YFhadCs2NZmgLS1czEwYBRPnAonk8gJmv+CH
         biCecHAXQ4XsJ8d83S22Y85lBLDnxHiDRsaqDQJEEVumyAPkrZ5dODcOU2fES7LjurgJ
         UHh++9GEvUEVju+NaSlSkx6ae3t7A0LBEBOWD7f4QgIuP7C6HR9v4ulXRSPGKTDxX4iI
         K+OwMPvZC7ZP5V8ZnPqFob5ocbpDz024DL9L0sCEIWYtaNS/mB6aPW3NhACio3JJuEeu
         +yCQjieURIgRpX+QypeKKzia8FRGSPMXk7WGjiCck5vhVF8my7vwcr3r83L2gu2yAJoE
         mx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3REtX15upPnaASwcpch/4bkCB1kjQjGAtbk3icoBvk=;
        b=72az71giiRwWTqn0SasxuNvDrvohXbJ8dgn8IYYiah3mC2l7VbqBwyPhrO169zmzzO
         wcE+0ulXUEAxVr5i78r3sskNPQwuieqpIQrMKAJWaXj2azFc6LQXS2aLn0wCQczqPBYR
         gdhbci0COUzyceZlIAWCKr5X20LMqfCzew3UfwguAkq34h8WWVNwI+Te3eb+5kAbky7t
         sBOtRlvbT/RKLupQTw/CG11TIafxlgIDOT6IG+3gzQuyvZ9Z4IaqQRWraT+WpOjVvGiL
         LzMBSeF2GOywLwcC9KiW8nZ/1YWsu2jrhgPSYy0Noks2a4GOqqxC4sjATrZNeGacz9jZ
         FQZg==
X-Gm-Message-State: AOAM531wXQbDymKjj+aXirTqj2SbE5tPtjqNdAvoBjvQeW9bi9YjcyFx
        aenizbXFr6ckr2jKneTyBos=
X-Google-Smtp-Source: ABdhPJyoXPtKfUenn/xWqn5BuvfbSmEYH2OdT5G+2Ewk4e5v6O/GVygjcaeUs0wedFSBivf8Y2pDcg==
X-Received: by 2002:a65:524b:0:b0:383:1b87:2d21 with SMTP id q11-20020a65524b000000b003831b872d21mr1665757pgp.482.1647918129605;
        Mon, 21 Mar 2022 20:02:09 -0700 (PDT)
Received: from localhost.localdomain ([180.217.158.152])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm16660pfj.151.2022.03.21.20.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 20:02:09 -0700 (PDT)
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
Subject: [PATCH v6 1/3] ARM: dts: nuvoton: Add memory controller node
Date:   Tue, 22 Mar 2022 11:01:50 +0800
Message-Id: <20220322030152.19018-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322030152.19018-1-ctcchien@nuvoton.com>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
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

