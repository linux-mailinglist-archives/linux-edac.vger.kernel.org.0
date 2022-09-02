Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AB5AAB53
	for <lists+linux-edac@lfdr.de>; Fri,  2 Sep 2022 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiIBJ1i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Sep 2022 05:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIBJ1h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Sep 2022 05:27:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC753C88B1;
        Fri,  2 Sep 2022 02:27:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v5so1300578plo.9;
        Fri, 02 Sep 2022 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5QZAVY6PtM/UpT2AqmdEYUtNqMVpy95nBAyLFnaLaDs=;
        b=JldIlUqaOwQcgjZbTKgSvf6/UuDaDHa8T9vLQU8/w6tbTd3pk8fhQie7WjkNMhIXMx
         hQuc7uwMiX9g0E9iZ9Ox8pw5NjOJBl9d8+2z4zAPwKZ/HUVEpU3thuu6ewp8mCWZvAtz
         l41CRKOBsvoetLap/HYcN/8xHzqnQRekxZkcPa9GPWpEGDTbcAqH5K43jQAj6ttoPdbN
         51bAJtFskRMworNKcgKTYVgRPnw0e6ZTn043yR+b8geSXLhW2jvIllM/C8/fAVnyTIM5
         fllIdXOob54U9xfeFfmG/STlT4QzKNeazdePwCi6OycmsY3U9P+Sav2kd8r8rf6JhfsI
         iRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5QZAVY6PtM/UpT2AqmdEYUtNqMVpy95nBAyLFnaLaDs=;
        b=UBcFaRk2Q/EoZav3yWpQz2e8ItMCz+leooZWOdaLeENo4zrgoz/g7n3w2CvBTXXdAc
         4/UyT0jRWPxwAeAzJeDjrBwtvlZ63fU2apG4dnJLiRumpJp1OqSXek+gusKOY1dJkTo0
         w+emFlF6S6+181zZYmTmQXJY5wne3Mrc5aflsxXDlxDNiz+4F40qcxctBQRrevL7eWAF
         A29EhGBHa9Z2IklX0LK+6OGHyBazTM/S9qhte/0ZyY34Py3ug2I8o5dViC7L77LnWJAr
         KPhabUg7TrDdneuR+pase7Aj0/yppLI5e6fh5hmTGdK6wyI6wxbOunVQs5WbhchFhD4v
         xnfg==
X-Gm-Message-State: ACgBeo2IgEpbJp+8JGws4dJh9zFO8IZhqUJmLkw61t4m0UpyfdcHGtSg
        eFUzSTKqswP9UJQcp2fFS4g4Q3tDC3f/pA==
X-Google-Smtp-Source: AA6agR42oHmxraepUihQpdHUzAKLeBHv7VvYtEUbOz9GzLUaTxRE8KShE5PZ5/F7NLx/4oyi0NInvQ==
X-Received: by 2002:a17:90b:35c5:b0:1fd:9087:6a70 with SMTP id nb5-20020a17090b35c500b001fd90876a70mr3940310pjb.158.1662110855969;
        Fri, 02 Sep 2022 02:27:35 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b005350ea966c7sm1169315pfb.154.2022.09.02.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:27:35 -0700 (PDT)
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
Subject: [PATCH v15 1/3] arm: dts: nuvoton: Add node for NPCM memory controller
Date:   Fri,  2 Sep 2022 17:27:12 +0800
Message-Id: <20220902092714.3683980-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902092714.3683980-1-milkfafa@gmail.com>
References: <20220902092714.3683980-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

