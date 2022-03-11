Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A654D5774
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 02:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbiCKBoE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 20:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiCKBoA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 20:44:00 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7452CF398;
        Thu, 10 Mar 2022 17:42:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t187so6237658pgb.1;
        Thu, 10 Mar 2022 17:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BP+86L+lIuRy6uRjMkCZyF2DvJ6c3trp41j9uZ3sVxs=;
        b=hgM8E+RBZ0dTNuJknt6CD2fx09iOVPsZUQOoCi6PwmLUGtVGN3RgqG96s0iVGH7iB1
         PH9jpN6UfH2GFamJQhWRogKeTgW4lZuDx45yvMMPWKv5WrEIz1RvJ71pj1kiqmygmZzU
         qJyVi0bP6jd3Ve7c6d7VhrECwmEtHyc6klMW+mWvtlkxEVVD5snRHAiNOILiQQUmy5o3
         G0Wi2ZgBtaXUwwh+Vrr67VWhCaWZD8gVVVLlyas8K5QS+f1NsHT7Wt8MJqHifrrMMf+F
         DpAqwyx4NdEqlY4MJwewIvzkktkvOg88oS4iwFYqRZfsGZh/W8SFHaZL/ehrgxX52k3A
         yUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BP+86L+lIuRy6uRjMkCZyF2DvJ6c3trp41j9uZ3sVxs=;
        b=pvg3g41TaY6JCbhqvKn2ZunPuJNN1x4z8f6BsyDSkGMCke+i3HnM0T40anfYWZ5mCd
         l3lHkAsv2yKdjb8qED9ImBieuVEIU7Vv6cTEXK7+E1LtYNkO+OYV+Irk2xDMnKu7Vc5m
         lHvNCUF80K4WnucWe5jLTYO/jtbWYSHZCtnNer3RlM/SeOxwqQQpAvRsy/nYAns0WOa/
         4b/VN3GWY2o8kAMZN5SgEtauRVdcQwBzu/VagAKJAfwnGFasfPT6QVIskKx4SOSMqhRe
         cBmIOLmmib7+pClpgGG6J/TwK+ut4BvyMWGMu230EqifvCnhKzltfjG2XfS7ZowZMWbV
         oujA==
X-Gm-Message-State: AOAM530rP5Y3N8K7iBfvYQPsrO94iBTPqRsBHgE06Jr27prb/j8NElC1
        JEJqg7X0rLXhpn1+GUZ6KSM=
X-Google-Smtp-Source: ABdhPJw4s8hxwtZjigPSX7XWokxaMTRbW0JF0Zac/tcWjw05dE0QhbsCicmgkB9Yqd+SzzZLuwA+fw==
X-Received: by 2002:a62:55c4:0:b0:4f6:b396:9caa with SMTP id j187-20020a6255c4000000b004f6b3969caamr7728287pfb.19.1646962975583;
        Thu, 10 Mar 2022 17:42:55 -0800 (PST)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a6b8500b001bf564e624esm7194383pjj.39.2022.03.10.17.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 17:42:54 -0800 (PST)
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
Subject: [PATCH v3 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Fri, 11 Mar 2022 09:42:42 +0800
Message-Id: <20220311014245.4612-1-ctcchien@nuvoton.com>
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

Add support for Nuvoton NPCM SoC.

Addressed comments from:
 - Rob Herring : https://lkml.org/lkml/2022/2/25/1103
 - Krzysztof Kozlowski : https://lkml.org/lkml/2022/2/27/63
 - Rob Herring : https://lkml.org/lkml/2022/3/2/828

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
  ARM: dts: nuvoton: Add new device node
  dt-bindings: edac: nuvoton,npcm-memory-controller.yaml
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  62 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 714 ++++++++++++++++++
 5 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

