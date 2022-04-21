Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF66509798
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 08:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356362AbiDUGcD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384847AbiDUGbg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 02:31:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07413F3E;
        Wed, 20 Apr 2022 23:28:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g9so3817329pgc.10;
        Wed, 20 Apr 2022 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEfkqCgw3vETZaUlrccz8XAbbh3VHlSfznVx6i0XsJA=;
        b=fbPmb7XexPeO+5C0cFMM9dkkAnaobFwFYz23maFjCWlk64GlweEEqmv7GlukDwTFIh
         y/aTbXD5xYb53Zgm4ePr9MtcU/hBhG6g27fXKdSvQgb8lbzM2fN9rge3QV6VNTA8RYUk
         cq2VVonCDIjwv776yULVviYsQM7ekjLG4ofRWnR0qqtdgdQ7YK7k9RjRzzLYdtCgVn06
         hilZ+jrNFRMQ62jUVOXOA0mmEN0El4rpcK1LZ63W7bkpnUQs076CVNgzaAymJ6dak7j7
         LmRwouLGkRIFLRTQYnezRZMoph6SmkrmdD4y6at8YmPuxQ0BAeYVcNWHzAYuu0HhxbFy
         iY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEfkqCgw3vETZaUlrccz8XAbbh3VHlSfznVx6i0XsJA=;
        b=gBgXjrP9OyShUGa343KwPBQHdNkU3zbQ/Pihf2n0NNMI6ADVhPioXQuHKjA4LkGxuq
         M4+I/3hkrx0koXrZ81JTF12HzxmajXyaLAE7KJE9WUyKRA3h65Q2Bwy5gfuBd7mzim2j
         KEAStdJAp83Y3e8wZc9Zs4p3Ex9ILCborc8DQFB5VMJwuxIKemcF/w8ZaRrStMyzQVvY
         EijUUethEagukd28fZASL8SKQHBWfpYpYLWgJw0crm32LFHVpLSXeC2NJL+AKVHlCZCx
         tvrlD7IPdo+XTHcoZ0lwsR9xvVgDXC1JYlVLOnW1RXSFA7/MDEVHYD1tFzeYNUvuiMEt
         LIQA==
X-Gm-Message-State: AOAM533auMa4ARskea1QTQ6jVkd1KBMlDPPCHuILOVqtuM1td8sXpVAQ
        fmrHDaByokMXzOqm5+mUFA4=
X-Google-Smtp-Source: ABdhPJyuZwmX0LcjxhTIT6sWFL8Km060Fm7pVLJI+PkCGyOf9RPl+BLJ0ZnjUC69KYrCQaWSVHme9A==
X-Received: by 2002:a62:685:0:b0:50a:5870:10b1 with SMTP id 127-20020a620685000000b0050a587010b1mr24659440pfg.61.1650522526873;
        Wed, 20 Apr 2022 23:28:46 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.153.245])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090adf9700b001d6e0fe8d28sm273305pjv.22.2022.04.20.23.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:28:46 -0700 (PDT)
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
Subject: [PATCH v7 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Thu, 21 Apr 2022 14:28:33 +0800
Message-Id: <20220421062836.16662-1-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/3/15/378
 - Boris Petkov : https://lkml.org/lkml/2022/3/17/561
 - Paul Menzel : https://lkml.org/lkml/2022/4/9/47
 - Paul Menzel : https://lkml.org/lkml/2022/4/11/182
 - Borislav Petkov : https://lkml.org/lkml/2022/4/8/871
 - Paul Menzel : https://lkml.org/lkml/2022/4/9/51
 - Paul Menzel : https://lkml.org/lkml/2022/4/9/65

Changes since version 7:
 - Refactor npcm_edac.c.
 - Sort strings in npcm_edac.c.
 - Reflow code for 75 characters per line.
 - Summarize errors and warnings reported by kernel test robot.
 - Shorten name of values to make them become more readable in npcm_edac.c..
 - Put spaces between the * and the text in npcm_edac.c.

Changes since version 6:
 - Fix warnings in npcm_edac.c.
 - Add information reported by kernel test robot <lkp@intel.com>.

Changes since version 5:
 - Update commit message of dt-bindings: edac: nuvoton: add NPCM memory controller.
 
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

Medad CChien (3):
  ARM: dts: nuvoton: Add memory controller node
  dt-bindings: edac: nuvoton: add NPCM memory controller
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  61 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 681 ++++++++++++++++++
 5 files changed, 759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

