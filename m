Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE752CCEA
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiESHZ1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 May 2022 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiESHZR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 May 2022 03:25:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7484A25;
        Thu, 19 May 2022 00:25:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q4so4019619plr.11;
        Thu, 19 May 2022 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gmirLNjLGfJzW6YYZUOR8avyTXMQpr4Eec+Omnxr9sI=;
        b=oUoSk7CnlRMCqq9hO54muVaLUmgCKKOAwoVTP2rtdSuWxwgURKiQUolQjUJBW7b8j5
         mT9CWiPpZ2qoBfpSZN8MhHSPhRycuj8A+2bBTqjuVaSQe4yFlZHmxz3PcmYpOVEirtKq
         VXuauTL45uJHKfrWF153GF4SkjsQj/mz3lUynt0uKi0FQKO+TLNGRjuM/qFFAzQlUX4V
         eoruy5T+nX4NDK7TDZ3oRFukBxNjgoKqm7p8kFn8Q+Plc9+5Sh243x+FiqLvE1o9cJMZ
         T2nUNAUXG5EbzX0V273RxUrvHhOFYXfDbbF7tfBenG0PcHsHggoUFhAfWejEqxKz7s9s
         Bcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gmirLNjLGfJzW6YYZUOR8avyTXMQpr4Eec+Omnxr9sI=;
        b=pGpPHwO7eRVm91oT5SoZ+TR4TJ8as6Ie3ZUfNBWrJ8h7ZyAbcxOiAuvkfuZAJiCeTx
         NFzqXJ7uuR0xveIl56XbwToulu2HRtG1j0j3zP2nMBssFOlzxGplQyxidzEZXcQAH7yI
         uAu6Xia+lqFEOocq3kB7ksIyHNg7b0CVBvERGlGuOoR/Gz7xDrftL3EnLhBa260G2dKf
         NKJxvz9iF6hwO5IZfXhnLwHXhaN3+BCmi2bUR1VjnGdiDjtYN/dVsL66qZ1FRQaEpu74
         hGtnT07hA6twejxHIkC9GEYgpY6apitPmVN7Tnk7QtgPrneFfvVDUY+OGCalmQ7jweml
         uYNQ==
X-Gm-Message-State: AOAM532KXVcVuA/03ndMaewFgsQg1QYjumF6wm9fuHzU6Q400SEAsz8r
        VhnKPmsYao3lv3j9AVHyqWM=
X-Google-Smtp-Source: ABdhPJyaTGnm7nnQEQih6sRYmOiv45VMCDxaIAPaajssWkrJpJTlAmxvNDLzAAVtX/cFc8r0f3AwXQ==
X-Received: by 2002:a17:90a:f08c:b0:1df:6f35:361d with SMTP id cn12-20020a17090af08c00b001df6f35361dmr4331336pjb.161.1652945114466;
        Thu, 19 May 2022 00:25:14 -0700 (PDT)
Received: from localhost.localdomain ([116.89.141.50])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b00161ac982b9esm2974159plk.185.2022.05.19.00.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:25:13 -0700 (PDT)
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
Subject: [PATCH v10 2/3] ARM: dts: nuvoton: Add memory controller node
Date:   Thu, 19 May 2022 15:24:53 +0800
Message-Id: <20220519072454.24063-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519072454.24063-1-ctcchien@nuvoton.com>
References: <20220519072454.24063-1-ctcchien@nuvoton.com>
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

