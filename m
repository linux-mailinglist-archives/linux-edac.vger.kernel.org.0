Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF913545F7F
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiFJInv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jun 2022 04:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiFJInu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jun 2022 04:43:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8386F205E3;
        Fri, 10 Jun 2022 01:43:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c14so24126729pgu.13;
        Fri, 10 Jun 2022 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fnzztiv9XavT4IQNbT2bMnkx97CUI42MYbUmzR1Txe8=;
        b=osnoxH5cTtQfl6/nlBpHZXqOKwchJOW7c6MPa94k864V/AAgr3P3DwrNci01DQafpm
         fDQbtVzsLAwF9fIP3xHC1EOv/AGJea/tJ+39ydOMHEUSe1keNTiNsY8g8MzUBZ+9Fn/r
         ROp2MBqAyfmCRvCaGOeUIat8fLsvtZ0LkD0mEu5xC3mrgOOcZdXwO0TnVF7u/Myd1K5A
         alZvDpvEOPtcXYakblhG3iC5Mn1nVPTB1MCCYtsGNUUvYK31SPL3pFUyBgBY4fiSMVUQ
         7WUcrM6yd/pmxTfyluVHwiG5dlx68ynTmlXgXHffDN8PaSXTEQvq9x/wxRkTMPCWoZyD
         tlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fnzztiv9XavT4IQNbT2bMnkx97CUI42MYbUmzR1Txe8=;
        b=AnIAzKxhw/sD+oLCd9GzziM/cCCF3PM4IBjUIExontpN6bGWyfYHQOm8P67VixiTAm
         GAP2dnqqQVzCX3k9r4y9tpydQXWYOiUdwr1156caJ8KHRHGhSIaB0AZJSO5QC3K2S+58
         N8dnQmB+8cUmOMV0lVFj9tZ1r0NN5X7M33ng1QRbfdAcgf13XljV0ua/ChUPLxdiX4gd
         tK9ntwGQO2u7b3t8og7BppXuJG8pJj0dvnXteapIsYlziTx56n0tlNK6pnr5+EiuXUIt
         NPWYZ4btrhOsxby9cEst2eQMfGF76CFdPkPhOcfs4uLgP1p7i2dVdpgwnQ3gSEn9bAmC
         2Unw==
X-Gm-Message-State: AOAM530FslniwsW5VUzno9S36XmNhGASg3cmEwLxukXNOzL77d9uQeOD
        kWKF0JGNNOwFqZ6C+9PStK4=
X-Google-Smtp-Source: ABdhPJzEYrGovMTXImTbXk9YA87MxIb9ZVrue/3Zo4riO+iJWCIyynA12osskNdE0FBUUb1xsJE/1w==
X-Received: by 2002:a63:4726:0:b0:3fd:9e47:6b3f with SMTP id u38-20020a634726000000b003fd9e476b3fmr24629903pga.321.1654850628852;
        Fri, 10 Jun 2022 01:43:48 -0700 (PDT)
Received: from localhost.localdomain ([1.200.147.12])
        by smtp.gmail.com with ESMTPSA id c28-20020aa7953c000000b0051c01aa7d31sm11703568pfp.46.2022.06.10.01.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:43:48 -0700 (PDT)
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
Subject: [PATCH v12 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Fri, 10 Jun 2022 16:43:37 +0800
Message-Id: <20220610084340.2268-1-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

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
 - Rob Herring : https://lkml.org/lkml/2022/4/21/681
 - Paul Menzel : https://lkml.org/lkml/2022/5/3/307
 - Paul Menzel : https://lkml.org/lkml/2022/5/3/304
 - Borislav Petkov : https://lkml.org/lkml/2022/5/3/343
 - Paul Menzel https://lkml.org/lkml/2022/5/10/47
 - Paul Menzel https://lkml.org/lkml/2022/5/10/127

Changes since version 12:
 - Pass ecc event count to edac_mc_handle_error.

Changes since version 11:
 - Update MAINTAINERS file

Changes since version 10:
 - Add one more maintainer.
 - Correct indentation in npcm_edac.c.
 - Add datasheet information in commit message.

Changes since version 9:
 - Add a necessary blank line in Kconfig for EDAC_NPCM.
 - Reflow for 75 characters per line in commit message of devicetree file.
 - Remove wrong tags in all the commit message.
 - Reorder content in commit message of NPCM memory controller driver.

Changes since version 8:
 - Add new line character at the end of file of yaml file

Changes since version 7:
 - Refactor npcm_edac.c.
 - Sort strings in npcm_edac.c.
 - Reflow code for 75 characters per line.
 - Summarize errors and warnings reported by kernel test robot.
 - Shorten name of values to make them become more readable in npcm_edac.c.
 - Put spaces between the * and the text in npcm_edac.c.

Changes since version 6:
 - Fix warnings in npcm_edac.c.
 - Add information reported by kernel test robot <lkp@intel.com>.

Changes since version 5:
 - Update commit message for NPCM memory controller driver.

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
  dt-bindings: edac: nuvoton: add NPCM memory controller
  ARM: dts: nuvoton: Add memory controller node
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  62 ++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  17 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 680 ++++++++++++++++++
 6 files changed, 769 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

