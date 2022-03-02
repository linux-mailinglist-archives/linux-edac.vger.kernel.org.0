Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA04CA0A0
	for <lists+linux-edac@lfdr.de>; Wed,  2 Mar 2022 10:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiCBJZf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Mar 2022 04:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiCBJZb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Mar 2022 04:25:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE77D008;
        Wed,  2 Mar 2022 01:24:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x18so1395208pfh.5;
        Wed, 02 Mar 2022 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zp2ZyHLiVwn9zzywILbOxMKzjj2ZvgI+yMGcT3sB0gw=;
        b=cHV1lPfo7NWy7+g7/8TTLoHJHpSTVpNrlzJkw97UMC9K+1NahHHlxEb+r6XI/Gy6yx
         j7uYa+hMwtJ4rBSvyJme89vP2cH1C2xVYc66i/IR2t1LcBAr9BNiTPklecIMThKhnCOP
         ad+AGtu9O8Nk09jE//YtiN2QzH/H9DzuVhUqVVdK7PHs417GpFJ7YJmh5P/rnvwBsw5I
         472kM4Pbhqxis+EmQy5w2QQswCH0dTEjEsKVYti42+hoh0fUO3poqTvBw6Bz9724jgfb
         WdfyRjXLAwfAovhDa1TBvH+pT08ze/Y0gz2VYSUR+8cFfeuTWVhsrdtMx4gwAdsYJq/r
         GYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zp2ZyHLiVwn9zzywILbOxMKzjj2ZvgI+yMGcT3sB0gw=;
        b=BuN+Evzfqo5zoAwh1c06E0V3We7/6V2bjsFaZerJpmViHpzc0DJutovtIj/Uv8rf+H
         xQIJMy7JlyjcBZxjay8RIfZzhjkaAskL+CEurbL02/qzZaJfHgETUvnJ75+iTgLC/O1v
         ZvP2ZZd34hzQ+zqvcXwGh1ODSF0DIgnflkezzaHEz8ZqzMDMVsZGzDd3sEDmLM54oQt8
         ZgjgePi7FR4FujrhOD4QSwDjOdGi3akdYNlyqEOpHD/Q1CeXKKfhMtVfydt9X9PGexFS
         sjo8X9LmrtjapNDTTLLfb1BtCwY1eEQ2HTvQk0iuRx//0JFJN0z/x9aK/MJHyt4mkzb9
         jNhw==
X-Gm-Message-State: AOAM532LlYjUfo/usSk+mZhhYAa9Uq3E6m18CgpRQnheQ01E8/oU9qx0
        6eizgy8WHAMLn3BwsbEtCpoAlxR0PBVj2A==
X-Google-Smtp-Source: ABdhPJwRt9E0DiTyG+pojpoz77f1Nh6CdiqHiMmsUUfeNWQCbGRiF0emFTgEmQuirY6wBn6qVa4PQg==
X-Received: by 2002:a65:6251:0:b0:374:6621:9fe8 with SMTP id q17-20020a656251000000b0037466219fe8mr25817981pgv.254.1646213088704;
        Wed, 02 Mar 2022 01:24:48 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.140])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004f397d1f3b5sm21351153pfk.171.2022.03.02.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:24:48 -0800 (PST)
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
Subject: [PATCH v2 1/3] ARM: dts: nuvoton: Add new device node
Date:   Wed,  2 Mar 2022 17:24:32 +0800
Message-Id: <20220302092434.16625-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302092434.16625-1-ctcchien@nuvoton.com>
References: <20220302092434.16625-1-ctcchien@nuvoton.com>
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
index 3696980a3da1..b2871856f913 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -106,6 +106,13 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
+		mc: memory-controller@f0824000 {
+			compatible = "nuvoton,npcm7xx-memory-controller";
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

