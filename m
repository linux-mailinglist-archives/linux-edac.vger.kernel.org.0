Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E114C2498
	for <lists+linux-edac@lfdr.de>; Thu, 24 Feb 2022 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiBXHsK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Feb 2022 02:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiBXHsK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Feb 2022 02:48:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F92171ECA;
        Wed, 23 Feb 2022 23:47:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s1so971975plg.12;
        Wed, 23 Feb 2022 23:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=W7sYQJpV/1TTOPCMlo79NSJ3PxinSPdjztCu/wR0/MI=;
        b=R0M4j5wpt3ujVcwAnddRhDbMtF74+yF4/g/MBaN4IdXRFF8nOHK3927oVp+cCdtyYh
         fEp2XRupymP01e/dVmrq7q2LEKgxx4m/HTNFVtPwqJw2EDYs0uo/Yp5RpP3+jKLqLE5e
         KRmoCEc/mxqNY0yvU82/4EFe2zO+Ku7Ug/nIu+iqt5P8A1mGDyFqFGftsdKNsycTu/8m
         UCDgjcNXlh95iD78UEd8QyChw8/evalUahwl2g+GzA15HPGNwHztT2JtAIt7jvvsOVyI
         V2QAfHK2CsrrIUdU+iEUCvRaJZnC1ImvjHsCmHgsgr1PQI+wee5dWZG5L5s6XrzvWOjW
         HvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W7sYQJpV/1TTOPCMlo79NSJ3PxinSPdjztCu/wR0/MI=;
        b=jrJQyWHwMv9LgPzSYMxwgFdoEBWFlb21ngGHWegUdwAybwzXudE65F2PXecthKMuQo
         jDvpMjecKs6Ak6NhIBpXfTIVaZ5Gfi7Fk3Awz+fqK8gCtV5Xkj6GJDKiqHXgAKdtMJIU
         ZFimtXsBxH+VMBV6Am/zqsD51wR+53qE3B49c5ARq688zKbdYHdcikAJvZNhJXGQXrpp
         a+B/bl2+RytMCK6gNg38KN6P6W4OwVeL/PUcUw8NzWJZrM3FVsyjB48HDKo7FpgBN/bf
         Bbk9tXhOxGaaYgxfGxgCncRLf/eVZeJkAnHnvUdtX9jXx2aJe5nzWauqBRboCfW3f/lH
         5aaw==
X-Gm-Message-State: AOAM5315qJw+Hmg3sHGLTWsYjp6pfe29BZY+W6npWWoUu98PtEfOsRyf
        rz3eAwmGguDFjGMf3DNrVLI=
X-Google-Smtp-Source: ABdhPJyJKUvcPSohgtvBJEQZQ6vW0pFCFCCUl76l5yrCsGIs1jk6IyIUOMdNVwojivXlJzO/h5cIGQ==
X-Received: by 2002:a17:902:f68b:b0:14f:c84c:ad6d with SMTP id l11-20020a170902f68b00b0014fc84cad6dmr1345785plg.155.1645688860171;
        Wed, 23 Feb 2022 23:47:40 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.140])
        by smtp.gmail.com with ESMTPSA id z21sm1616839pgv.21.2022.02.23.23.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 23:47:39 -0800 (PST)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>
Subject: [PATCH v1 0/3] edac: npcm: Add driver for Nuvoton NPCM SoCs
Date:   Thu, 24 Feb 2022 15:47:26 +0800
Message-Id: <20220224074729.5206-1-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The patch series add EDAC supoort for Nuvoton BMC.
Add driver to support EDAC for NPCM SoC.

Medad CChien (3):
  ARM: dts: nuvoton: Add new device node
  dt-bindings: edac: npcm-edac.yaml
  EDAC: nuvoton: Add nuvoton NPCM EDAC driver

 .../devicetree/bindings/edac/npcm-edac.yaml   |  64 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 712 ++++++++++++++++++
 5 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

