Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87D520BBB
	for <lists+linux-edac@lfdr.de>; Tue, 10 May 2022 05:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiEJDPE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 23:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiEJDPD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 23:15:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43D24F222;
        Mon,  9 May 2022 20:11:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so923260pjb.3;
        Mon, 09 May 2022 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Cn0Iax5rOzavzXriVReY3HhABd017T/SlyLMAaHYpo=;
        b=Y4NcnejjPo1M8RpjDZ8EHHR8ZTk6IY4IB7CWtPN6gkQEBkChqUbmtpRTncGF9hTQ7p
         72iQivvn6PXUOKE6rWbDw15tyUswHqcJ1cPnRT9PFFJMogjcI8LIRi9Y3JMHmAPIL18l
         ru4zrS0fr9tWcnJvX2nH5pbuSJkHaPVgNMucK+qRABkWrfZNrgyYW4dF5YiBHly6LLsc
         +EtPwLXZjtqrfbAnIW4aGxrqyE+/Glu3ilxWdxIB0mH2n934FyJvglObu76HFWkn59XS
         BTamkQeSmh+k01s3qxjtPXjh0DrpMe96UCvbpg144/td6afxqBlm+CS0euGIj61QJy0m
         jxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Cn0Iax5rOzavzXriVReY3HhABd017T/SlyLMAaHYpo=;
        b=ctLW7adW6xoR7Q/n1U4TxEyAodfrKbjv9UhF3+qPn8EF6AsyLAydgElz9IyacYUai3
         UI74NW+XXUFwsrAAmE1e/wWCgFCl/jj8pCzH1gjBKDtZNMKWjrSEOkL7lzPWiod/bShk
         nQmweTtS129bLLmULRQbgSkrBJPC1pJ6uMEa2+7RK31Z+euOh9EbyEHO6gv4qIqNMRnE
         MkWeTF83pm1HPnuJbv749akmQWkkzS8MQTLuxQPr+uBEEflNa8shj6hSfAMtMdLz96Y5
         tk5s7Rc3xwOGcTxEyXw9EnfaaaiGQ6bQiaHt+AQ2mHAtM2h9F8EMcutBS58BhPyY7dIX
         /6Xg==
X-Gm-Message-State: AOAM530y1W1zgGpMwuBIIMVpF6mSdzUZWfK1K2SIArV4i7fENet9V50N
        UhbP90DqFA5hyiid5cG7aa0=
X-Google-Smtp-Source: ABdhPJzvlmVDUKzoYUn2RU95ygWNIlFZP9p1lAzbp19KM/aLR80P13cIP8gTmxvXDrXWySkd1o2fhw==
X-Received: by 2002:a17:902:d483:b0:15e:9e44:8a07 with SMTP id c3-20020a170902d48300b0015e9e448a07mr19014444plg.77.1652152267091;
        Mon, 09 May 2022 20:11:07 -0700 (PDT)
Received: from cs20-buildserver.lan ([112.78.91.252])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902c38d00b0015e8d4eb248sm648824plg.146.2022.05.09.20.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:11:06 -0700 (PDT)
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
Subject: [PATCH v9 0/3]  EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Tue, 10 May 2022 11:10:53 +0800
Message-Id: <20220510031056.1657-1-ctcchien@nuvoton.com>
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
  ARM: dts: nuvoton: Add memory controller node
  dt-bindings: edac: nuvoton: add NPCM memory controller
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  61 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  10 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 680 ++++++++++++++++++
 5 files changed, 759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

