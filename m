Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F6545F81
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348024AbiFJIoA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jun 2022 04:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347819AbiFJIoA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jun 2022 04:44:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDA377E3;
        Fri, 10 Jun 2022 01:43:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i1so22260887plg.7;
        Fri, 10 Jun 2022 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+4CVCMjz+0suAt8V5Y2817Osc9g0YmAmWa1n3bUS86Y=;
        b=pfrJ5QyUStgTu3wsdDXoq+1PoBwxIGyoBXPKUo3MNO1LLWKG+tTrVTsF1PYdtPOkEC
         upjiirTkch6w5SwZEDjIIahT/E8W/YT6wj8wfkxr/zCT8Bqb8PNPPNcgl8+a1wfLrG0T
         IMxIViCExU3R3z7tMMZhfgWJCU2aoPx7YJrEJWD5PBAzDnH+r8LS8qHSWgWMPBwprYBK
         3yrlL2Jr6ryzeT1gCZgkeoDZ7S4+7P2ECDMYllx7QuhQvoXzvaDqZqcx1PmuZiqOINX6
         cWZXsbBZFoDDLUh6WLOeF16w/7Q+AUcRBWIz8FWsik2e8+BMmVF4uPSBKi0cD9yTA7dD
         dkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+4CVCMjz+0suAt8V5Y2817Osc9g0YmAmWa1n3bUS86Y=;
        b=GnRsTQhNe0hYsAw56mneBUnEcT6RjNWbjD2VV/yA9OiA4CMlpO605BYDwf+g/39sqh
         pfHoRN18d0w4FpiwgpIXo0FmhF9sVuSapYsOesI06rh4k6K6aH3M9nVnFQOpITqrOYOu
         Zcr3Jbh/Z7A/asazAXfb/SLGxOfF1XXX7WcCbgnQ5VZOAf0kjC8AiqWb3tRxhyQ8PzCd
         KSipsjFBZQyv+SybgxllsKJSPZrjl7ckrbi4krl0gRPDGhCyDqFQTzXDWbilQh3GPQbq
         elHl3D45efoV6G4VErms1j6JElZSYMXS3YOGTAmQRCsOP+Ya42SMsm+eA8qXpsBUaQLr
         bnMQ==
X-Gm-Message-State: AOAM531yw2J8yOTAqtL4h4du/ekAz48D9sX3KcW1dV6FmF4KL7zp9qe2
        1Qi+nRTMk8YkLI+5Q9HB47k=
X-Google-Smtp-Source: ABdhPJx/TGnEIt0E30M3ySae7AHUixMayQamXZWRkpJcKbREZoG5+tZp48aiUg+Dstw02YiyfcYUBg==
X-Received: by 2002:a17:90b:3789:b0:1e3:459a:1202 with SMTP id mz9-20020a17090b378900b001e3459a1202mr7665657pjb.113.1654850638455;
        Fri, 10 Jun 2022 01:43:58 -0700 (PDT)
Received: from localhost.localdomain ([1.200.147.12])
        by smtp.gmail.com with ESMTPSA id c28-20020aa7953c000000b0051c01aa7d31sm11703568pfp.46.2022.06.10.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:43:57 -0700 (PDT)
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
Subject: [PATCH v12 2/3] ARM: dts: nuvoton: Add memory controller node
Date:   Fri, 10 Jun 2022 16:43:39 +0800
Message-Id: <20220610084340.2268-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610084340.2268-1-ctcchien@nuvoton.com>
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
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

