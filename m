Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE9535914
	for <lists+linux-edac@lfdr.de>; Fri, 27 May 2022 08:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiE0GL7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 May 2022 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiE0GL6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 May 2022 02:11:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8782CC83;
        Thu, 26 May 2022 23:11:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d22so3300413plr.9;
        Thu, 26 May 2022 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaj4o6KB4et3eGOuzGM0PpQDMWKrL5arnah06TnbXQ4=;
        b=G9XtmURmydcxhnztlE1IZOI9Uw8lo6hQWlk1lXDSwa1kuSNHIChxZ283CWUuuBnhg0
         prW5Z60R7d9vJXE0qys+bEtIYWHaPRyfJQsmv1iH0sjFZEDShzMA1U89CjTJ60RdtnRg
         vvxWiO674fNG2HMnUJfQBQ26iNL24hB086gc5sbGty/bqhRtwuJ0yY08OztRiIsT+V3t
         Pyp9HcEMagZnxL9hZ8q9Rlbutcg31hx06KXXZYu+2nbTpL2WvNavpHoxWgU+eEgwyLM8
         Tx7Wu2m9RJK7O3jENxQxx8gHCFq1kUYZiy1KCqYPSC+IQIcA0YpSDznr31epGhVBm5OD
         aOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaj4o6KB4et3eGOuzGM0PpQDMWKrL5arnah06TnbXQ4=;
        b=IgI1+ooQQCEjp8VBxs/XfxeyxwMjPYHfhuuRoHhrOBxZggm8rSecVU/pwrceCouDjT
         SKH5qhsaGYKvXWelLaRADhlJHPm8rSBQgLxWZjxscaV+mlgR6QCypKyq91XvJ2/rIFKY
         +U0qo7zvRoJvWU2aL7/lSNzHAu6+jzerGgOujvP91Xs92kUneXlbApSRp9QfT27G5nEf
         hBQ6INNQMyOtRvvO+iYVgE8wJ1cTOM6RIWajPZAp/Avf5lraf/pjuiXs+D0cqnuZK/tJ
         9My/IlPOcfhv7d4qwCPwdBnq+Aqwnip5bN9qdGHj2wBqSl1ykX42Qor7jMxfAVPo+9Ug
         R67Q==
X-Gm-Message-State: AOAM531fp5uelaCf7too3B6/zkNuPlv2Rb8KiSWRhBrLUfSQ1CTVQ19c
        8CqW9ssxxo0rz73hNNxWy6o=
X-Google-Smtp-Source: ABdhPJx2NWadSw85FdMHFO1tiKadl8+kRx+T2vUIJ63qG9wYReVBpQoH1KNkO8BQtObf65s21VMeZQ==
X-Received: by 2002:a17:903:240c:b0:153:c452:f282 with SMTP id e12-20020a170903240c00b00153c452f282mr40222705plo.88.1653631917050;
        Thu, 26 May 2022 23:11:57 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b0015e8d4eb2c2sm2636306plm.268.2022.05.26.23.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 23:11:56 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v11 0/3] EDAC: nuvoton: Add nuvoton NPCM memory controller driver
Date:   Fri, 27 May 2022 14:11:45 +0800
Message-Id: <20220527061148.14948-1-ctcchien@nuvoton.com>
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

From: Medad CChien <ctcchien@nuvoton.com>

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
 - Paul Menzel https://lkml.org/lkml/2022/5/10/47
 - Paul Menzel https://lkml.org/lkml/2022/5/10/127

Changes since version 11:
 - Update MAINTAINERS file

Changes since version 10:
 - Add one more maintainer.
 - Correct indentation in npcm_edac.c.
 - Add datasheet information in commit message.

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
 - Shorten name of values to make them become more readable in npcm_edac.c.
 - Put spaces between the * and the text in npcm_edac.c.

Changes since version 6:
 - Fix warnings in npcm_edac.c.
 - Add information reported by kernel test robot <lkp@intel.com>.

Changes since version 5:
 - Update commit message for NPCM memory controller driver.

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
  dt-bindings: edac: nuvoton: add NPCM memory controller
  ARM: dts: nuvoton: Add memory controller node
  EDAC: nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  7 +++
 3 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

-- 
2.17.1

