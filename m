Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4364E7C1
	for <lists+linux-edac@lfdr.de>; Fri, 16 Dec 2022 08:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLPHcI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Dec 2022 02:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLPHcG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Dec 2022 02:32:06 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671253B9D5;
        Thu, 15 Dec 2022 23:32:05 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t18so1190746pfq.13;
        Thu, 15 Dec 2022 23:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WivkawWqftfG9cwjjZTcLDoOGcI8ZfyTyq38lUwyeaY=;
        b=E9+GJVu5jahV/qnD7b5BlMzb5S9DmG5setb7JajP3fVezDN8emP3EYVrfrikM2r2f4
         c738p6sSHPOFguw5+HhvpzSgBtK2FrkwTSS+gu3LVkKWlyZnEsUBhu/gz2KVSTwtIOEG
         U9qQ7eg+iNLfDn8ieq/IxiqILNkp9W4EqcW19LoQRUjndtv37kp4ZUx0Pzn+msS35yrM
         zmnkDR61s0SS9YvUHZKGht8Xi7FUiqSRkC83YXzorMF3k6aO8qeX+XHJfzkXp2ikPwz4
         wjGXIs4QAWkdfHo9s6b2e+bcPminNncasbIzQ/k+HCSEw1I1pTFUvBmVQzZgr64Yp41p
         ccOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WivkawWqftfG9cwjjZTcLDoOGcI8ZfyTyq38lUwyeaY=;
        b=v4CfNfR1Wd9F+v6ej4ReP8ZwKnFajqDcs00cfqoQF14TGVg1vwrjMcQ5P+wTi0zZ+A
         8R9ToHA+adZGwPqvnPUps55isM3RJsxufM6RESPyr+oaa4IMVzjtCzcXmiNkQqZEXU9d
         wIwnHH+txJphY7a/sWoUMC7TPaDQjier6TkRSr0J8I3zMlmKwf3daySCIhRcFF+U75si
         fLzGkyz/3I7Eh9bpktVBcmIIeLYyqui/cOOJj9JvBHBe9gyOqMI9rn77+Zio+9zyo53h
         QFfzgUDArW6Iu+jqTkRBtuUm3dQFQ7URmqAr/4niaKj6hcOVFsQH/h79I9yyEilawunZ
         ysiA==
X-Gm-Message-State: ANoB5plZCtGRl/4wHJSHixhtnC4xp8qzoQt66Is8RmNnOap4UrXI68XU
        qVYcdyKzCPXstkeABgNOFFwEz3dpAKMJug==
X-Google-Smtp-Source: AA0mqf7khtd2QiDF1uOXxGGs2YuY8T+Bx4nJEyTA1tddpi43KwrjwB0rnKY9V6NMNNm6uHGAbZwRNQ==
X-Received: by 2002:a62:4e96:0:b0:574:1d8a:d4f with SMTP id c144-20020a624e96000000b005741d8a0d4fmr30989136pfb.16.1671175924640;
        Thu, 15 Dec 2022 23:32:04 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 193-20020a6217ca000000b00574cf11aaf3sm770123pfx.208.2022.12.15.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 23:32:04 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v16 0/3] EDAC/nuvoton: Add NPCM memory controller driver
Date:   Fri, 16 Dec 2022 15:31:38 +0800
Message-Id: <20221216073141.3289309-1-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series add DTS node, dt-bindings document and driver for memory
controller present on Nuvoton NPCM SoCs.

The memory controller supports single bit error correction and double bit
error detection (in-line ECC in which a section 1/8th of the memory device
used to store data is used for ECC storage).

Changes in v16:
  - Correct dt-bindings document path in MAINTAINERS.
  - Fix wrong indentation in driver.

Changes in v15:
  - Move dt-bindings document to memory-controllers directory and remove
    superfluous string in content title.

Changes in v14:
  - Fix compile warnings.

Changes in v13:
  - Support error injection via debugfs.
  - Fix coding style issues.

Marvin Lin (3):
  Arm: dts: nuvoton: Add node for NPCM memory controller
  dt-bindings: edac: nuvoton: Add document for NPCM memory controller
  EDAC/npcm: Add NPCM memory controller driver

 .../memory-controllers/nuvoton,npcm-mc.yaml   |  54 ++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  11 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 520 ++++++++++++++++++
 6 files changed, 600 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.34.1

