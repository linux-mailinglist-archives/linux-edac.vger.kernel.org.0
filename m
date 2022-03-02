Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C414CA09C
	for <lists+linux-edac@lfdr.de>; Wed,  2 Mar 2022 10:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiCBJZ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Mar 2022 04:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiCBJZ0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Mar 2022 04:25:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB844BFFE;
        Wed,  2 Mar 2022 01:24:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so3645513pjq.0;
        Wed, 02 Mar 2022 01:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=WaWcwOHmu+CzQ075186NMnPBJxGmawZeuD/n9EcEdJQ=;
        b=YV/F6XpueBprSxXpQ6q0Cm3rSGNkZEJG8x9nlQAWmqx/yxUilVZV3Q1eRdrbBlSe1n
         +E4ziQn6svN4oFkSBNZRKYfOAFTPU12IDOpC0a4kNlL2zigBPVsAgRcUHQT+ADNdYGSH
         6qxCLxtcYBJsnNm6m+XTAjnuzMoZIl8Vj0hQP2827+CzP2k76GINKQdwmB23vgoGxdvk
         b7+17LJmP0skdRmMef8H/GqS0yzbwUT+ZOQunWgjTtbQNM81cJ7QiiVAQV6LlcKnUSEs
         58xKWwBWlAWPNxIxZm4jBr5285OrJhCIrJLEfXuLcduRliEPzZv/v6VUniwVH4Kn5qMz
         WHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WaWcwOHmu+CzQ075186NMnPBJxGmawZeuD/n9EcEdJQ=;
        b=zs+MWYu9wYen2m52yJaXte8AUidB+MXmHhTvIfXcqD9SyZNNzHvkAz7PxJ0GCs09dk
         IpEuYD7QiNP3/FiCGubS6nGm8zW/OvYzU1q1nEm5+MR6q12P8uuoK3kzg5819Zet6q1B
         jijbOnNOx7MLf1lFRKzC9BH/40s6rm/yvYJxEyg3rQtPUteABR+EVp7avkf7IAI2fiyF
         O9S96prgCmS17VogtPj5yWvVYFPK4D97jQ1GGPILZ2VyWsl3f92/LPwFyZaSkcGr35jC
         PJZT3jOMVviutOhERZz051yJ3uLng9Eu8zYDtydk18/p4BYiFz7S3Ah+HGxu6kARBxtA
         YFoA==
X-Gm-Message-State: AOAM533XIq9/wMESqPpUh3idKRz/XuL2oC9XlT/9h7RTUtFZcw1vHBu2
        pO6yfLIue+cyF6AD4BNcYB4=
X-Google-Smtp-Source: ABdhPJxQUjpx4IZqwNjxYN691wEWHajSm3tH6KYSJTbQPvAxF9vngl/KgZHDYw3IJw7JlEunIdCumg==
X-Received: by 2002:a17:903:32c8:b0:150:1189:c862 with SMTP id i8-20020a17090332c800b001501189c862mr30385943plr.134.1646213083073;
        Wed, 02 Mar 2022 01:24:43 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.140])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004f397d1f3b5sm21351153pfk.171.2022.03.02.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:24:42 -0800 (PST)
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
Subject: [PATCH v2 0/3] EDAC: nuvoton: Add nuvoton NPCM EDAC driver
Date:   Wed,  2 Mar 2022 17:24:31 +0800
Message-Id: <20220302092434.16625-1-ctcchien@nuvoton.com>
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

Medad CChien (3):
  ARM: dts: nuvoton: Add new device node
  dt-bindings: edac: npcm-edac.yaml
  EDAC: nuvoton: Add nuvoton NPCM EDAC driver

 .../devicetree/bindings/edac/npcm-edac.yaml   |  62 ++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 714 ++++++++++++++++++
 5 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

