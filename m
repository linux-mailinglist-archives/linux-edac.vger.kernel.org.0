Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712A15A5952
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 04:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiH3CXD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Aug 2022 22:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiH3CXA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Aug 2022 22:23:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733A7FFA4;
        Mon, 29 Aug 2022 19:22:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f12so9570981plb.11;
        Mon, 29 Aug 2022 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=VJ968BoY2rUzhLmsHDPQEskN2/sLj9tYLwAiHbWfm18=;
        b=Pfeyo1U5xFkfRwohUHDvx+COd5YtApoO4czjrwwTzQ/9v1hAlbtkYRqOJHzbt94Ddm
         SbF+QDMx5TNCHY1DijR0F3ftlEChbxGIN/bR4pIubqKu+Lqw+Eb/qvtd1+I4061auP87
         97VSZlYW1hx5Azn9Ls4Eyn19FAMUdKLgSxsxHLbLGJ1Lrj1yNvoR8boQ3g7huDlpH0yv
         JE6RpjJungZEo3C8szILZHqwD83F9it4NbP/SHyvx/Ff5JeSHsqpLSFRf+wjW9rbdO1z
         lsxLNMQEvBKtffuGKFH+jz99UtW7EIpqC3L2X2nCgQrYb3XimaHJko9CnYBKtCvxWx+X
         fiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=VJ968BoY2rUzhLmsHDPQEskN2/sLj9tYLwAiHbWfm18=;
        b=A0vhimzgjnY+6mB1Avk3SLtITEKO/ojyW1heY5fXZpv3J27l6jmPs9fpsHsnPyhuee
         IMh5ve5JyKbnJ/i6kGenqfEXfGP70HB08JU9M1f2fI0YVb8VhZWTqwooqNvHf9FNsOUR
         6ojvlZWrcpUBsk1wZPnpphH0S8LKKGAnzNBl79bROBT8gj66a/e9YWMkrdUZBluOTzo2
         Fr54vgQeNPoZylloyv81MsQjpYNSlZ2y2fJrSkVL9LA/N0dnPjGtZiVab+Ghuxgtoevf
         KAzuL/4hTH3fmMijPaRAY4Uw6ahrM6b1vgokMdfs1Gpj0UQgRzg3AutRjLrKUpNpPSX9
         1oMw==
X-Gm-Message-State: ACgBeo3dm8kDQeELpUZR8zlRj5XAlvkT93Ww8ma7AUXuJG0tUo6apAyG
        GkKW4aWbn4xrtscrR6BcrihS0exi3d52yA==
X-Google-Smtp-Source: AA6agR5/dbSMlyjBlWjZEzKrJ8faCJwCcsd9bGaFn7fYBs8x3A0ZfgjKQQMdQraEkcEPZAqEVzyg5A==
X-Received: by 2002:a17:903:1ce:b0:16f:1c1f:50e5 with SMTP id e14-20020a17090301ce00b0016f1c1f50e5mr19679299plh.132.1661826177793;
        Mon, 29 Aug 2022 19:22:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c78-20020a621c51000000b00536531536adsm7916841pfc.47.2022.08.29.19.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:22:57 -0700 (PDT)
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
Subject: [PATCH v14 1/3] arm: dts: nuvoton: Add node for NPCM memory controller
Date:   Tue, 30 Aug 2022 10:22:36 +0800
Message-Id: <20220830022238.28379-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220830022238.28379-1-milkfafa@gmail.com>
References: <20220830022238.28379-1-milkfafa@gmail.com>
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

