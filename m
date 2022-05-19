Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFE52CCEF
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiESHZN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 May 2022 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiESHZL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 May 2022 03:25:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C384A0D;
        Thu, 19 May 2022 00:25:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 10so598465plj.0;
        Thu, 19 May 2022 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7KTYEAzBj+UHeOYHPkQPvPY0nWRVQq1n8Qfv4AqkRw=;
        b=LgPneXHQcr5a2wUiKfofywt0n5ugbFygskIFcuyjBKNXMs+AZk/5MabsHL5IoJGvzY
         8k/q2hxkIuhEHovPPVupaRkOhh0GPIRzih9ZKMha8547f6EWsH3hjljN5B4JoqXPMXQQ
         dWUIgPph3HXR5zDsYrk0cLHbobI3HH16dtwtQoKH9RFOE2Ez6A1xdHYR0TE7gmCtvVkw
         /joO7RofkPky7H6xOHNgE/CiADNPGLvaD9qiazUJhe3l+Cu7J78MsqjkZU6ooV8gRty0
         g1O4guZmH0xLL7ebihegWWHv7p/9z5U1CH1mFR16M5m30OUXtK1v8trLO/h00HO87ZPo
         +oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7KTYEAzBj+UHeOYHPkQPvPY0nWRVQq1n8Qfv4AqkRw=;
        b=UfIPZwaBOA2s/tn1UgatAiQ/B851/CN/MT88lwAel4qDX76E4BqdHi29x+WBZKpBPq
         5OOy3iAFmCpq6JLKPitTun0h0repNGeiIrMcY3f0IJs9NpVoHBfiza7pgQIsreKLC/64
         RPcPI78wFsjTYJG8gJ6jf8Ia3P8hKOvAP2uAsNmWBf+Z6ClRtBVwNmkdGWSEYyZmvSrw
         kXrZH2p9LPeUy1bEeJil7HsQ9sfXVNhbJn8URVFDfAS8Xr1tE5nSzX6PYrPePaP6dRKp
         zqDxl7zjA9VV34C/sY5bkEPrgoVsiZIabV7hlLGRUk0D/iVcO5QrYVo3tm41VuiXaebc
         tTfg==
X-Gm-Message-State: AOAM531LYPCBhHOxZ1fScVugPxOQNAnoNprO/5KPtPliUpUWK8eu7jWg
        eTdIHZh8aKACTLsFm6tOPo4=
X-Google-Smtp-Source: ABdhPJyjibq4qVCxGzg3BADkPXuKeH/EjdBmVyRnufxJ0q+nWEGOqMRD0p8wN5jCOOvjCoEZThfK3Q==
X-Received: by 2002:a17:902:aa85:b0:155:ceb9:3710 with SMTP id d5-20020a170902aa8500b00155ceb93710mr3574445plr.59.1652945104460;
        Thu, 19 May 2022 00:25:04 -0700 (PDT)
Received: from localhost.localdomain ([116.89.141.50])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b00161ac982b9esm2974159plk.185.2022.05.19.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:25:03 -0700 (PDT)
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
Subject: [PATCH v10 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Thu, 19 May 2022 15:24:51 +0800
Message-Id: <20220519072454.24063-1-ctcchien@nuvoton.com>
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
  dt-bindings: edac: nuvoton: add NPCM memory controller
  ARM: dts: nuvoton: Add memory controller node
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  62 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  17 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 680 ++++++++++++++++++
 5 files changed, 767 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

