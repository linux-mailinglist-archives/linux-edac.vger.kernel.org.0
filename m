Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17315665791
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jan 2023 10:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjAKJfa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Jan 2023 04:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjAKJem (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Jan 2023 04:34:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18C11A3C;
        Wed, 11 Jan 2023 01:33:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso19436433pjt.0;
        Wed, 11 Jan 2023 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5JGnjWO3i/HQRaWW/ClYSWUxpQJi0bOfxlRYOsa604=;
        b=fvIOX+2MbyDpb6mAaTbFjM1YhPGD7tQoZqeQcQ7md/GTnBQ8bYFDxwy/OHcXg0dttY
         Gl9Gkgm9G8gCKwKqEF1IHB5tZGq3Si/jVapjNqAeRig9M7j2cxAZ27h1oT7BSqMkF3ZQ
         BsuAwFBnp3/9SgjHzk+9m0ZMhgbrk4rVYmcBEsmvPqZobX+wJNU7FF/vacqlVbqos4ho
         bxiCzsIeLWcl3Qe+Ig1mm/wDVrz7/3yrXu/nViheKuZgDhOOpkwCBBu1+UYZYBS0BNa/
         2xqFKnTJ/ddZ2lQiSsTZn9Ei0ipn35200FjhN1JHzrr/phZYLP/++k16tr1sDhSrtzjR
         yvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5JGnjWO3i/HQRaWW/ClYSWUxpQJi0bOfxlRYOsa604=;
        b=A+NAiJomnPzjn+UWMZ/dP1MnSrgE8BcbshdKXdvdAnke4QM6rqOjXWC7xbcMPzBmtl
         7BtmXnydOETmBpgFK4PFhc7x6YNWr+aKcV2dSW9GfyJXzKD5bOJof4B0bspJYl172j8Z
         Ii84JxrBQ2Rj7ahlT8cfzQlnXKbtt68eVJumOeAlWxZA3SZMLl+ANu9A7UBBJJxRRLt1
         hjhjkpTBOecUsKfiZHciU+N3T2m8Y6wwy4U/UYiDI5qjqYxrWaJHTAEF87o4rEFR8YAY
         /MVJen5gS2f7XnQpA344FgGaCbAdPLzDHjUg4wMDYgKiLhUAJp04tw+b185pVPj8Hngn
         yN7Q==
X-Gm-Message-State: AFqh2krlHzMkdptGUxT0n9cpiwS0+LqXMHjYdKOb2BjUwbU7fnsIo4jL
        33rJAC/KUzuoTJVKyWd4FaM=
X-Google-Smtp-Source: AMrXdXv79Hzh19xnHhzpgtg3TWw5dDoLxm/jbNYyJredZsg0UrZElvPKgiCoOEFY/BNiSAmjhRC4eA==
X-Received: by 2002:a17:902:7c8a:b0:192:835d:c861 with SMTP id y10-20020a1709027c8a00b00192835dc861mr51821244pll.68.1673429588518;
        Wed, 11 Jan 2023 01:33:08 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b001769e6d4fafsm2001341plm.57.2023.01.11.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:33:08 -0800 (PST)
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
Subject: [PATCH v18 0/3] EDAC/nuvoton: Add NPCM memory controller driver
Date:   Wed, 11 Jan 2023 17:32:42 +0800
Message-Id: <20230111093245.318745-1-milkfafa@gmail.com>
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

Changes in v18:
  - Driver refinements
    - Adjust line breaks, order of variable declarations and destroy resources.
    - Catch weired cases by WARN_ON_ONCE.
    - Add defines for constants, and provide injection examples in comment.
  - Correct subject prefixes of patch 2/3.

Changes in v17:
  - Correct subject prefixes of patch 1/3.
  - Change dt-bindings document name to "nuvoton,npcm-memory-controller.yaml"
    and refine the document format.

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
  ARM: dts: nuvoton: Add node for NPCM memory controller
  dt-bindings: memory-controllers: nuvoton: Add NPCM memory controller
  EDAC/npcm: Add NPCM memory controller driver

 .../nuvoton,npcm-memory-controller.yaml       |  50 ++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  11 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 543 ++++++++++++++++++
 6 files changed, 620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.34.1

