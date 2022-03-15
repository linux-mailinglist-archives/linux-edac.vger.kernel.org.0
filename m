Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25944D942B
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 06:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbiCOF40 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 01:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiCOF40 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 01:56:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E236E2A;
        Mon, 14 Mar 2022 22:55:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s11so17884345pfu.13;
        Mon, 14 Mar 2022 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SV4CLPiAxFiZ9vJZfubS3i47B7zCkYU3tvd0pu0JO/Y=;
        b=Lcouch33BK7VsQZOzvwVm7+tfFF2P4ZBVrzYpbYiC++2XGF1kxTKqoIUOOarueI359
         YyBEdKPLcb79/SMvUjpXiTJHbqxCpRTdHHLB93bMYeZSfJUDfrWyrxWg92sMuTx76BjC
         GUxeHEpWd5+vcaB2Z7CuWmtL+ojktOXi/S1XVx1d2BzfAmu+9+UgPj4r5BFPbi0DEoEC
         Jyn+PtU8Vm88OYeqlokxmW9cnHQbuBXN29e7uWfooJUNDH6nr0PSNkPyn3eMMbU43qXq
         zsvL3w748Is89x0ABoo8C2RJl96bffbeZlHC1kE5GoJDiRAoYWp950GF4h0s78JZw+tB
         BPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SV4CLPiAxFiZ9vJZfubS3i47B7zCkYU3tvd0pu0JO/Y=;
        b=cJs9X2QgbJCTRAdR33mlv0hfxi/LD2vHx/h1ZgL5wcvg8Tp7uImcR4EFzlJ51xlo6s
         dhDFNcGLczqN/ivOc76r5sV7wzNWvJimMuHFKPlkrETgmsCTJFj/ypwSIhGseSp9+/ft
         LmJreLGGFpuomIXLM/mdE6CQhfokXw3O3zCgnuKp1DPwd/zM3YYdj6LfxgzdaaqPepNv
         FVRNRgip7H6tBzgDFbJHwaLYgwM20uQb4U5HEUT0uKP/35Igz2xtraBewDycbQkv8ii7
         uSagtPb0CYp9QqJ1ilWgl59zzZhV0KOGOO6VELOlHdrb1b7tyTnSKSx/aUnlVPUK4ac/
         ryEg==
X-Gm-Message-State: AOAM532q3lypBFvHJOsR3iFds2gzjJKsTvpmU1R69zun6vYyfnSDzRHu
        UltjGt2LNpvyUUWVrKEqcSk=
X-Google-Smtp-Source: ABdhPJynkqv+iB5TqmzLr7kHGGlCCmmXG20uJCopgsl2IFsJKNmDi2nONXmXFJXhU4BlSib2a/T7Ew==
X-Received: by 2002:a63:4c2:0:b0:381:113e:2b07 with SMTP id 185-20020a6304c2000000b00381113e2b07mr16052787pge.100.1647323714453;
        Mon, 14 Mar 2022 22:55:14 -0700 (PDT)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b00368f3ba336dsm18679369pgk.88.2022.03.14.22.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 22:55:13 -0700 (PDT)
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
Subject: [PATCH v4 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Tue, 15 Mar 2022 13:55:01 +0800
Message-Id: <20220315055504.27671-1-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Support memory controller for Nuvoton NPCM SoC.

Addressed comments from:
 - Rob Herring : https://lkml.org/lkml/2022/2/25/1103
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/2/27/63
 - Rob Herring : https://lkml.org/lkml/2022/3/2/828
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/3/11/294
 - Jonathan Neuschäfer : https://lkml.org/lkml/2022/3/11/1167
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/3/11/293
 - Rob Herring : https://lkml.org/lkml/2022/3/11/575
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/3/11/305
 - Avi Fishman : https://lkml.org/lkml/2022/3/13/339
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/3/14/93
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/3/14/95

Changes since version 4:
 - Update filename in nuvoton,npcm-memory-controller.yaml.
 - Add COMPILE_TEST in Kconfig.
 - Fix errors in npcm_edac.c.
 - Remove unnecessary checking after of_match_device() and of_device_get_match_data().

Changes since version 3:
 - Rename npcm-edac.yaml as nuvoton,npcm-memory-controller.yaml.
 - Drop 'EDAC' in title of nuvoton,npcm-memory-controller.yaml.
 - Update compatible in nuvoton,npcm-memory-controller.yaml.

Changes since version 2:
 - Update description and compatible in npcm-edac.yaml.
 - Remove address-cells and size-cells in npcm-edac.yaml.
 - Reorder the items of examples in npcm-edac.yaml.
 - Reorder header file in driver.

Changes since version 1:
 - Add nuvoton,npcm750-memory-controller property in NPCM devicetree.
 - Add new property in edac binding document.
 - Add new driver for nuvoton NPCM memory controller.

Medad CChien (3):
  ARM: dts: nuvoton: Add memory controller node
  dt-bindings: edac: nuvoton: add NPCM memory controller
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  62 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 710 ++++++++++++++++++
 5 files changed, 789 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

