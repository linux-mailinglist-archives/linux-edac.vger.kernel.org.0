Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB51520BBF
	for <lists+linux-edac@lfdr.de>; Tue, 10 May 2022 05:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiEJDPQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiEJDPM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 23:15:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735952532DF;
        Mon,  9 May 2022 20:11:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so15636535plg.0;
        Mon, 09 May 2022 20:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gmirLNjLGfJzW6YYZUOR8avyTXMQpr4Eec+Omnxr9sI=;
        b=REig6fitfjXTh0cqkooI1v3yC30UH7PBdPRRw6NFXIU0li08K0cNjk+ASddNB9scXD
         g8UCiNrkhu3XA26A4sw0fZmFg6Pcz5fLpTdSDyEv3OU1UimbJYyMDaMzQr9WqKBiipal
         olzgntEpk9PF9nPCi0GqlekbWoNgTdRzcFgB/j7H97M6Jt6Y7LGQlqgI+xDadH9WwogT
         H+oIsy3aiwcxsQ5mW9I0hHvMY7OBjP6/Kfz5zLg9+6poUXzcp8Zf5bBUSMZruCSNrTSD
         nEKqiezCIYqxWUE4KjlGm7HZ9ZWssX4K4YF6fkNmOBl/9N83ete9XUZIaxKaI/jY11sr
         vupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gmirLNjLGfJzW6YYZUOR8avyTXMQpr4Eec+Omnxr9sI=;
        b=CV4crOT+ULAHdOFN0LyuJ/Dc7ukiPD9wzaNjdUcLZ4d2EZAxSe0sJ1QMCzPBYrZVbv
         DWLTryinDyXOGR5kzNhzGcR7X3gInE37HS2vSHqFGJ4MtkYzWvWnyI3XH8GHBf5rX/Wk
         SHhKF1tZsO6Cr3oUrJZzjpVgjIxbxDdlM6Ha3WlIq6PdC7YNwI+a2rQG98s6yr6D4Y65
         sodsyJWrd7KboCUI2pff2mbzDkkrz8gcpuclUk+s6dIejYkTnJSpOwFTdhuih1NQkta8
         /IJacyPiQoYhf4rwiNiV2gJcjxK+8nZ02rdhUvWG8tKONUNQhnxaIN+BTgWYettYdQCA
         aonA==
X-Gm-Message-State: AOAM531YHC20YRJ+KpRWKpvplZVxb89gACUa/Ta5Rvosvu1r0Zk4XFmi
        cS7Vh6cfOhK8h8SzrEHnJz8=
X-Google-Smtp-Source: ABdhPJxHUAmfKwggfoJfp8yKKsjPSB1f3TQBxNzeIMTYC4JyKDyvezQacSVijmA4bAAfra/6quqWPQ==
X-Received: by 2002:a17:90b:33d0:b0:1dc:e4a1:a809 with SMTP id lk16-20020a17090b33d000b001dce4a1a809mr17892271pjb.21.1652152271681;
        Mon, 09 May 2022 20:11:11 -0700 (PDT)
Received: from cs20-buildserver.lan ([112.78.91.252])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902c38d00b0015e8d4eb248sm648824plg.146.2022.05.09.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:11:11 -0700 (PDT)
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
Subject: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
Date:   Tue, 10 May 2022 11:10:54 +0800
Message-Id: <20220510031056.1657-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220510031056.1657-1-ctcchien@nuvoton.com>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
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

