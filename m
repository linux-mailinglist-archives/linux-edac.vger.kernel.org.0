Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A9518190
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiECJvN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 May 2022 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiECJvM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 May 2022 05:51:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088E326D8;
        Tue,  3 May 2022 02:47:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z16so14300600pfh.3;
        Tue, 03 May 2022 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjpV3+31EBNyUsVuJvlPGp9I1RXm2tUH/4rxv/DGe3s=;
        b=moTJzkHnFjjv71Xovd7gnwzgJx6VDoMjNUFmURvQDqrmU4g45U819+zEd5pQh58lvs
         I9YnfQwwSZH15Gul0VanY0j5e1Q7ZzFT5CSB8zc4Fb9ri2e1LsnWDRjj1lkCvVeUeFW4
         XdFlQ4f6vrLTSyLOq68x0gMS2d0nGktYFNoLFUUG13QCocXATXTddRUUMlMxnBTPnaWq
         A3SnYQVIfFlQ7OKOW/5NqBuGGfV/Clys9cDn98WRPw3MqUDDX+uxrbaVjxOf+ZTneztq
         Za5Pjt2p/UWutcA7ef1OWsBha5ZK1zrSYryLVzSoBkvSUEyVnJSv1wN0an8zmsl9x2s6
         q8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjpV3+31EBNyUsVuJvlPGp9I1RXm2tUH/4rxv/DGe3s=;
        b=IpOwC81nJUhixdKfxep1sUFYyQBGo3J30J4/qlVm9BKWPgogkJWMGD7EVzqRFd+6GF
         vQjOEc0bEQrMo6WaoN55BmM3XByZmSqeORbGjKsvVMT9PJU0FvzW27xi8wYPWch6bdWZ
         jSKWvglWeakPKTBi5FnSuY23uIXwT9rwuaQdBG6MffhhV4R+9P3AIQ1jCi8KPIyKhSEo
         IykwKiYxXsJX2ldKJN4I6Im8kQNWwnxGbGr14sovJ8muW/55/Q+Vc8t1THKWm4voICBO
         /nW4Kt830QN02eByIEnjyibtBgAqQDpH2fys8WmhASpavVL8R5nkT2HROMRV3U3RQA36
         rPVA==
X-Gm-Message-State: AOAM533YoMiY/2V2UD1/kDQO+r+iVQNbk4KsMjKA781LeUWXCu9CPYXh
        zg3P9n5bIXIoFzZ77jhhX1ka7u4L3puZQQ==
X-Google-Smtp-Source: ABdhPJzBUkPA1uZErb9GZC69Dlkgal8w1fuJ51a5baLHZWoZImwesjdf1ljfHWVPmtduXVQpDfXZJA==
X-Received: by 2002:a05:6a00:2408:b0:4f7:a8cb:9b63 with SMTP id z8-20020a056a00240800b004f7a8cb9b63mr15497522pfh.33.1651571259367;
        Tue, 03 May 2022 02:47:39 -0700 (PDT)
Received: from cs20-buildserver.lan ([180.217.147.224])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090a421300b001d90c8b6141sm1015222pjg.53.2022.05.03.02.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 02:47:38 -0700 (PDT)
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
Subject: [PATCH v8 0/3]  EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Tue,  3 May 2022 17:47:25 +0800
Message-Id: <20220503094728.926-1-ctcchien@nuvoton.com>
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
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 680 ++++++++++++++++++
 5 files changed, 758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

