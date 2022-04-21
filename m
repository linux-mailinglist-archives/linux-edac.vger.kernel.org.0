Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5C50978F
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384860AbiDUGcH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384853AbiDUGbl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 02:31:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8376813F31;
        Wed, 20 Apr 2022 23:28:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s17so3918193plg.9;
        Wed, 20 Apr 2022 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J2a0MMW50oXViY1edzoxXF0rBee0FZ1e4ZEb2hYnjXI=;
        b=R54cezI/TzlUp+E6pXQAmw5yUojZ7Rh/adS5QJm9OuEnpDia5sL+2xhX4np38Et+QM
         oe05M1HSglIQIAwCi1SvS670xlCwCbGkH9CqftMfmpPsFhCghPZXjJmsFWpI2InDcbsh
         DwSpsQJ+PW1rBu7JrAdw84uT2Fm3NFGhiIO+2osxlNLSfKyxV7KmKfdExS9X8r/sgXqr
         6pJRaPuKlAu6a5571OmY/maOxm80No8QBTbNoZ8x3pHc7Qmcr37t3CC+N/aKKlWRCGdx
         c4uJWfOYDq2ZB+4OIv/z3gXxjTJsADjmFtehVuZqrLvl0/J8YE0srN0PYNKUYPw7KHa0
         FNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J2a0MMW50oXViY1edzoxXF0rBee0FZ1e4ZEb2hYnjXI=;
        b=wOjSbujcEvBHJl/UCl+w+7EQ/ZVdO254WL+qwcaik4597ZVHLQv9/15OG1s5/c+U6f
         Gd+bKwP+YbkYdBIneAlIafs2Ni3paEE8BoB4Lb8AzYQbUqg87qDL/H3hRZ/wWHQjdBu9
         EI5vDCa0dQZ9wIGnpuCsdU9x3mX7M79JQDwzCn5+9PcgQqL+9Y8fQccHuezU5bAYFIOH
         cR+e+TTQljFjSm+PZ1g5VCg8GAkXnVnqRLjJIByu7hcWUHgDLhMrehbSZF0JdTupcGr6
         qu9S/bdV5YvugpYDp7HUNq7ijccQtNP8jdmOJ/2eQb8A9nboxUAuARKzWttgxD2q0MHE
         v0Ig==
X-Gm-Message-State: AOAM531T1slLcQ5gDTaw2WPnk3jcMhZD7fUPs6Uz98oNcGD6kCsloUbW
        0diI2ldS699nDsYvqqJgB5c=
X-Google-Smtp-Source: ABdhPJz2mc6NvIPZCX18YFDJlxDUGPRkzTSoFcrVSseegzz7vvHoVhXryWneL2P9HbYKwJ9ZYEFvGQ==
X-Received: by 2002:a17:902:da8b:b0:158:fd5f:2b35 with SMTP id j11-20020a170902da8b00b00158fd5f2b35mr17721269plx.42.1650522531988;
        Wed, 20 Apr 2022 23:28:51 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.153.245])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090adf9700b001d6e0fe8d28sm273305pjv.22.2022.04.20.23.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:28:51 -0700 (PDT)
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
Subject: [PATCH v7 1/3] ARM: dts: nuvoton: Add memory controller node
Date:   Thu, 21 Apr 2022 14:28:34 +0800
Message-Id: <20220421062836.16662-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421062836.16662-1-ctcchien@nuvoton.com>
References: <20220421062836.16662-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ECC must be configured in the BootBlock header.
Then, you can read error counts via
the EDAC kernel framework.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
Reviewed-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
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

