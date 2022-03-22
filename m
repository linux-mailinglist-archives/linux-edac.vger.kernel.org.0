Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411DC4E3724
	for <lists+linux-edac@lfdr.de>; Tue, 22 Mar 2022 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiCVDD3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 23:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiCVDD3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 23:03:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5611CFF0;
        Mon, 21 Mar 2022 20:02:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so977034pjl.4;
        Mon, 21 Mar 2022 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npO/c36OLuX8ktgimEwxNyS0embKrdq4vN/kIDV+XbE=;
        b=ZdIUakBnmgbr5X9tmq4wlQZUoUxKRJ6uCAdlPLslkIiEpy714ZQXAbiAWqYuXuWEb5
         xcOjCyxTbpgT21AkSI5bpjYylo802lUy3Oe9Eg6sDGBT8OHFQ15s3VvYOSVNkbcZ+ESu
         5NGXWnYTi3fDFQhyTZIV2JVORzy0qAsGZuIumTAyqFebZhO3hI0TzyDiojQkHO0ihkkm
         jPyXQTCMbj+oMqwQy9C07Zw8P6JF5/oJ8j0XbE8A554j7L8Kmtt7SB9WOPuPAYOlZLuM
         XGFQRCHmmz/mxzkMsOjFg/JfbIxLejbg+QVz8NJxWu1yYsG+USoB57pwIOAhj1bLfABg
         uuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npO/c36OLuX8ktgimEwxNyS0embKrdq4vN/kIDV+XbE=;
        b=F38sVMiuD77BtL5Nv2apymbnK6fMgcw02EJc70Lk1ECDDLouMxbbU9xlBNkGOEoONB
         NjBsQxGr0xzdJYLCDZz49w6IRHVXiDi5pgP78/kEyXJr4KuNqHZOFMJ+iwJjGQvfZhWe
         INgYbN2+NAcamlH/l6OWMo1724W5Fr8n+Yunqg7+AblGWqkSi8AW3iUr3DeTdsfzRsFD
         UjXAXuPZQvxnBauq+HMazIurFXKKt5rLnZXLfp1hYwc1IdpWGRYnonT5SiVkjO7wFOdu
         tffiZEBNRCA1tMujRnDfaxrNuleCfzKHYJkKRTyBnm/inrvG1+Wy+oMxcrRCeGlT2VG+
         Lh3Q==
X-Gm-Message-State: AOAM530V9PMAawo3p1TGal82/OO61om5cu1aLurkxLWhq3gX0QhBF4CM
        dJtLld9L1euSKZ7KJwGD6Ck=
X-Google-Smtp-Source: ABdhPJxAvLAnAZU7lVSyZ74gisM0GmFwTqK5nu4eceiJcUBU5Jo1s01SYQGPx4H2XmeiOwkChN1aCA==
X-Received: by 2002:a17:90a:4e87:b0:1c7:49c:2e3f with SMTP id o7-20020a17090a4e8700b001c7049c2e3fmr2441997pjh.191.1647918121329;
        Mon, 21 Mar 2022 20:02:01 -0700 (PDT)
Received: from localhost.localdomain ([180.217.158.152])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm16660pfj.151.2022.03.21.20.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 20:02:00 -0700 (PDT)
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
Subject: [PATCH v6 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Tue, 22 Mar 2022 11:01:49 +0800
Message-Id: <20220322030152.19018-1-ctcchien@nuvoton.com>
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

 .../edac/nuvoton,npcm-memory-controller.yaml  |  62 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 706 ++++++++++++++++++
 5 files changed, 785 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

