Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE0535921
	for <lists+linux-edac@lfdr.de>; Fri, 27 May 2022 08:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbiE0GML (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 May 2022 02:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbiE0GMJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 May 2022 02:12:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B51B33A1B;
        Thu, 26 May 2022 23:12:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o9-20020a17090a0a0900b001df3fc52ea7so6285856pjo.3;
        Thu, 26 May 2022 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+4CVCMjz+0suAt8V5Y2817Osc9g0YmAmWa1n3bUS86Y=;
        b=lmx3tX9k6AOSJoTkQGbpLdrtvI5ZaVwsxfP8bjVoTWLSo1dHqzIeYMJRHxhuk0UJT+
         gBjA2TGNxuz/p2KTF/x+Tcg0akDRYfKBeBc6Jt6UBetR45v0/ZLVkXhI7pK/xG9fynEK
         DU04BZDDEE4e2R66ds4FvQsDr/5pW3D1wTcCbopRTWTCWk8NE7f6mQqgICtPonOwvUKF
         WSzPseu2Aqv/1rpB81PkZ8b+z4f4NbRYt4+NBs/jYsu0nGrzTmgPR+m92u1gjUxb3PFd
         wb2KIEuBDEpdhA91CF7JrEGR7NRs5oIfiH+ap/jdB8T24hVIjwoTrGZI+xrqatKuK5+U
         SiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+4CVCMjz+0suAt8V5Y2817Osc9g0YmAmWa1n3bUS86Y=;
        b=N+1zOwEMf9Tj8/MrKlMvGjv6BnkCjMx9KlxmJFD2QirQGQ/uFlU7xt1bDiPNVv5dnV
         PNwku9glXVcURmgj3rR44CCo1NGy/5PY/w7QN27i2Wer7s243HIE8kzBjbMaA8LD8V16
         LLHkn1+qyZA/iRMRNHJCUVDuH52dGnVv/jWdE6/4FH+l/Gz73cOWXsNJ1T44342lLrKq
         AHinOBkk+1F+Rf+pUKAMwZPZG29tdVOjJ6glXnpdd5rlqyVMxzScUB10vuPPX1OjkiIn
         vUgDF2NdzBpYyP5unkR+0HZpuRXewHDZ8xfAvoZ3JTT8/xgbBs9nGs7OKjYl07nGdMKV
         O8mg==
X-Gm-Message-State: AOAM531SZ0ijqjMHneZSNBVs4dvGcRM4n1q/Hafdbgw5ED2cxllYRDIw
        Bec/lChiSdIsz8aHjE9dNXs=
X-Google-Smtp-Source: ABdhPJwtkCLtZ2CB5urQeAYdWHsx1ni1FVx1r1wiewSN4VgwYDNIbHlVcbXShbFrKd0rLdmjAGETgg==
X-Received: by 2002:a17:902:d501:b0:162:4f2d:d32f with SMTP id b1-20020a170902d50100b001624f2dd32fmr14935527plg.6.1653631926577;
        Thu, 26 May 2022 23:12:06 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b0015e8d4eb2c2sm2636306plm.268.2022.05.26.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 23:12:06 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v11 2/3] ARM: dts: nuvoton: Add memory controller node
Date:   Fri, 27 May 2022 14:11:47 +0800
Message-Id: <20220527061148.14948-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527061148.14948-1-ctcchien@nuvoton.com>
References: <20220527061148.14948-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

ECC must be configured in the BootBlock header.
Then, you can read error counts via the EDAC kernel framework.

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

