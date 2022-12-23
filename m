Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16B654BB4
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 04:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLWD3e (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 22:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLWD3d (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 22:29:33 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0963A31369;
        Thu, 22 Dec 2022 19:29:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u7so3792952plq.11;
        Thu, 22 Dec 2022 19:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeemHnrH9+ojMc2sxTxo6/NiqXsu00sy+aryfTNI9f8=;
        b=gvXwP+6gXQ4kSrjuu3ifNh1lfmhon2wh7iF4gmUIHN1mcyOotJ0/oVdmTzsrFlJPg7
         fawHXyM2SaEtSCNBwlvVjAWSfcTL79fsWeaEw4on7A2Wk7CSIUfj0nW8aYR2M3CiD9u2
         Q6OjQynP8I0l/Q8jBgL86DgNI4lM0rXXrvYEB/508d2UY+nvy5gXP1wdOfnyOnKsbkgF
         WMPDlj5Tt0f3CxXG+CZGIji91l5wv62i9WwZjirvToRFz2CLlvIcdd9vm5DzqAod5lDK
         zwKJme4vssgIqfIfL78kPx3XwmVEx/lR1TLhocJFdnETNBVxj27YHZkhHtKy72QMVagz
         wY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeemHnrH9+ojMc2sxTxo6/NiqXsu00sy+aryfTNI9f8=;
        b=jOxYxqCJirXJ9xT79IUD+Xlmy/UcYNPC4qbXbYuc0LLjCHygysU7ZIE2X8GSMJoTTv
         KcEdnPJj22Idi4FsFT7XzS09joL4S4FL2NZNeyqQprLQKhf6Pl5qc5l84I3eUk+60wxd
         qWfrrgHk2lfWotjtq6AbUJeeDBCw3og0GutCx//wdXc53XZjhJx/5yEH1r7rAdMoZuVw
         SiCAppOIpds7vlpdrz/7+8e8E2qaNFF67fpvltvofgdPQzkc2Hie8yaaSZthp0ImQ2+B
         Ug7Sovi7W8nF3cwsJPJqds6IVgUvT/w5j3lItTSxbmwlG4e62eQegepnymIzvlk8dGdu
         9OQg==
X-Gm-Message-State: AFqh2kp3Y3g6532bKVddO6AeXzgX20xeg+Q52E/uPY23WQEltipJU24i
        h604vXrUaKi+75p14pcj5Rg=
X-Google-Smtp-Source: AMrXdXscb+BT37NezP69AEJ6tWXDRwhw/NiLRGTS4VzkaSaKfZDCkOEC4jnQ1FfAKPu1+jIhgxAPfA==
X-Received: by 2002:a05:6a21:6d90:b0:b0:3318:ab59 with SMTP id wl16-20020a056a216d9000b000b03318ab59mr13387356pzb.14.1671766172324;
        Thu, 22 Dec 2022 19:29:32 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w192-20020a6282c9000000b00575448ab0e9sm1376854pfd.123.2022.12.22.19.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:29:31 -0800 (PST)
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
Subject: [PATCH v17 0/3] EDAC/nuvoton: Add NPCM memory controller driver
Date:   Fri, 23 Dec 2022 11:28:56 +0800
Message-Id: <20221223032859.3055638-1-milkfafa@gmail.com>
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
  dt-bindings: edac: nuvoton: Add document for NPCM memory controller
  EDAC/npcm: Add NPCM memory controller driver

 .../nuvoton,npcm-memory-controller.yaml       |  50 ++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  11 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 520 ++++++++++++++++++
 6 files changed, 597 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.34.1

