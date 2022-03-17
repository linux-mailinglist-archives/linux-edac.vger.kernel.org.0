Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74384DBCB9
	for <lists+linux-edac@lfdr.de>; Thu, 17 Mar 2022 02:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiCQCAU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiCQCAT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 22:00:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804081A801;
        Wed, 16 Mar 2022 18:59:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e13so3296901plh.3;
        Wed, 16 Mar 2022 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OOu3Dv7ymaz0yaa5xrcvhaRsxtjz1a2I15CMgD9fMiA=;
        b=fWjxUKjyrz8Pb620UJ5EtJrVsMOdAtUb6yYFngyCwkY7GZOqTWsU5uB1+qaBdW0GCX
         gjDTezBiAyI+zjEoZyxP80SKXj3E+f+FgYGxBbTZIUTQLjghEt/K+AhbWIXrs8LK+/nI
         7ec/KKLR7or3Dvr9OsN+JXEzsm2OaQk/5e50hsfpqQJZtlOv6mNlFzbTp783IPyoZr45
         17wCKQhTpjBrfGNZpJ52PTeMg6vqUN2CP9ExIHm/V5ksV/52c7FzlyOZDstZwX9U4lZy
         GqYKdtP3xgoUd2zZOisHLY3TFmNZDTotXYEBYXWN7ns6Tg4LT9KcgoyydkCa9Piu+s4h
         hGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OOu3Dv7ymaz0yaa5xrcvhaRsxtjz1a2I15CMgD9fMiA=;
        b=r8QMX35S0mt99uneRkv8MC5J1DlTgqxc1jiA0pG1GPDiJZV+ZvhVwHAejxAACa6F+M
         epLS4ODULckFoG49QZ1R930vIRS2JrlbdBLQjqRxJtTZqE6SacRY7sUqSGrP/2ESmKi1
         42pP+7pWiIPNbcRj6WCnx12RbFE1vX61bWw9wE1nRKZP2adkzAnzgpl+yAvakXH1ck41
         9/Y2SeTmUhZgllc5W8AX8XbQR+jtkLJluxQEvIQMIhTQeYObg3PdH2dnbhmHa7R6WZds
         k1IuecXbM857nZSlOM61hByw0J94DTuGGrvwAureX+VIlKqgukOQKzvnNr4iK4vLXRdy
         mS1Q==
X-Gm-Message-State: AOAM531mbdQiDBu5jA6sxDuOdiSVirS+cToGTMHk80XzVOxHjLDQ1EOI
        h9FY8AWEgtpmUAFtQos4L1M=
X-Google-Smtp-Source: ABdhPJx59NLfgkhIv20XhLC9jFj4zU7KpOCkjlO2ZZPnsvgxjnKo41ny/0Zwq6LktZcW5dSOKxoyMw==
X-Received: by 2002:a17:902:a40d:b0:153:7213:1584 with SMTP id p13-20020a170902a40d00b0015372131584mr2390788plq.56.1647482343703;
        Wed, 16 Mar 2022 18:59:03 -0700 (PDT)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001bfceefd8cfsm7945528pjb.48.2022.03.16.18.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:59:02 -0700 (PDT)
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
Subject: [PATCH v5 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Thu, 17 Mar 2022 09:58:51 +0800
Message-Id: <20220317015854.18864-1-ctcchien@nuvoton.com>
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
 drivers/edac/npcm_edac.c                      | 710 ++++++++++++++++++
 5 files changed, 789 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

