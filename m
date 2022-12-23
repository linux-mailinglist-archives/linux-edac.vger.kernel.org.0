Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395F654BB7
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 04:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiLWD3i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 22:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiLWD3h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 22:29:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E831367;
        Thu, 22 Dec 2022 19:29:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so3808583pjj.4;
        Thu, 22 Dec 2022 19:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/rJpdWzIaY9d1c2EPyFR6eEs/FbkRXh+i26sis/kko=;
        b=SK/wRJeEnjG9XTKlKKVDmw9UOLZs3kaFkZd1Zuxq+hfvIf1F7tBQwCSnjXRTkSsLJl
         xrfcJyu6PsWdCT7b1SloQtIdQpUW1LtaLtIbMOb67VIUpFACmenU+/Eum+38Au9dwq+x
         5HhfTlKUfg/UaaGXai/Rjihun5iM3+ABXg9pshb7tYQNA4moHf/Tbz+gk1I8zCnXwSh2
         RSCc0AB7qHVZ6JKrFo8HYmiUE2ChxBva/co2bsDrenIzQxt57dQsW/2hW8mqc4dGqnkF
         VpLMUJyJj4cRw79bz5JKHfYn2cWlnanyHsSiiMKh56QXHciYQI1acWHp8dU5ylK/JwS4
         qTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/rJpdWzIaY9d1c2EPyFR6eEs/FbkRXh+i26sis/kko=;
        b=jaYp8zp5gJjJ6S61cDoVAqPOwrhJM5Yqvi2TVAkZr8gDWHslmouMV5PUjbz+D/QMMS
         xlSVewrCwzfgGADmeQjF8Pkpf6lJwHx4XglP292GB7t6LGeoN16fiEpWFspb81QvDWZQ
         NEa3NYHps2cPt2xRpyXjXvmpyrHti8tfjChqZEXjlns23Fh9qIE6p0WP0bMGn7RrOhTN
         f9aDKb1y7Z9xCmS7cdNoarVbrYWxerz5GAt3E9+83cEeJpK6AxCTVpfhUTqN6rd2hWew
         LD0MQ1D9p32LV8TVUiKQKTBDrEkEio0iMugNZ5j2HraacO4nz/hrDUs5FcLlveWT6VG3
         e66A==
X-Gm-Message-State: AFqh2kpHXz9BgQsbzJy5KPsC2AfN3ZIY82stYkRvuj2iyNjPjHV21LLJ
        CIexVK50AbWcu0Ia9ekVOCk=
X-Google-Smtp-Source: AMrXdXv45rm1v+XCWDM7o/5xmwHkciOA779S4Um6cM+38t7bt2rNOgQgNOZTlJFSoBENSWU7mWHeXw==
X-Received: by 2002:a05:6a20:1b1d:b0:ac:5429:e609 with SMTP id ch29-20020a056a201b1d00b000ac5429e609mr8422226pzb.32.1671766175897;
        Thu, 22 Dec 2022 19:29:35 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w192-20020a6282c9000000b00575448ab0e9sm1376854pfd.123.2022.12.22.19.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:29:35 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v17 1/3] ARM: dts: nuvoton: Add node for NPCM memory controller
Date:   Fri, 23 Dec 2022 11:28:57 +0800
Message-Id: <20221223032859.3055638-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223032859.3055638-1-milkfafa@gmail.com>
References: <20221223032859.3055638-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add node for memory controller present on Nuvoton NPCM SoCs. The
memory controller supports single bit error correction and double bit
error detection.

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

