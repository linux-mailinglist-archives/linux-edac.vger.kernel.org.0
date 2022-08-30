Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB95A594F
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 04:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiH3CW5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Aug 2022 22:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiH3CW4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Aug 2022 22:22:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF259A9E5;
        Mon, 29 Aug 2022 19:22:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p18so9735688plr.8;
        Mon, 29 Aug 2022 19:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=/6PPh9l5vsaOt8qDO3Ez01p7E33dQteARC0QV6D3NwI=;
        b=OYj2omWdT1HXZUp1tH7NwgUMRFIv2F4Eo+t7nMRMgtt4+ZOU5zWb8yRWVlzzERtvta
         QDcY0X8IHlNtdhHfPfpmzTnuVvn+c8qqjedTwPA/C3uJ+Pc0g+dizYe2eX31uIh+/rNx
         g49BjoFLhLXXVEjtiQIHqA4ZZxzgsqtiPfHifHYVhUSliZXlUlmOuOd9Sui5Ftpj5e1L
         0TrcMLds/ScYVcVS8aDKI0bnQUgfK9k8mAqDx5iQkmflV8OUYnt8KafY6wnuiUPLS3/d
         8i3XucImgitH8Eiy2+BhnD0V7/4nHnnf55+B3J4exmKcLwDu8SQ3hzOoNBzeSSOeWqiq
         0wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/6PPh9l5vsaOt8qDO3Ez01p7E33dQteARC0QV6D3NwI=;
        b=suNzU0vVRTv8sALupF9LnadKHgRU0SHNY4P1w2GgBs6eiuyQvMfrojXppcnF9Qf9Gp
         41eXsIra+rCgJdwTQ4k4zATiMhqeMVIcwfLAPBVpFweFDa8mtHK07kYineOfxvfpW0z8
         TCwGkJqPnRH6O347NalOMGrEJOThivNp0bwgn6Qgen++bR5iNsOPCls/ZylrbxaT6qrJ
         rPdvvGJIqD01ScWlxy+TlRR8QMbcrPtIPZQDZ9+3DSfFaOnfbYc9dgM2Ho/PWEtOIIZ8
         TAQwzGSgC82/9cesn34lkP/g1+VZkhXOv1XMMTY3fYoy1ibkIYF0kOXoKMPR6z0cGpXw
         oWqQ==
X-Gm-Message-State: ACgBeo2UFbEvPqvCW6eYPzK8+1Qh2BC+pJIs139zr/93cVeG68VYRF1J
        /F5tq+2pesu6dTiiBQQZJPW6DHzQjR6t4A==
X-Google-Smtp-Source: AA6agR6qaMqZKVUaPCzsKu+BoWnKtLk5qUQv9370Sb7fpu7MQNjYpNaybN34miguWBt8kG6Jp1RB/w==
X-Received: by 2002:a17:90a:cf8c:b0:1fd:7783:c340 with SMTP id i12-20020a17090acf8c00b001fd7783c340mr17244081pju.16.1661826173725;
        Mon, 29 Aug 2022 19:22:53 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c78-20020a621c51000000b00536531536adsm7916841pfc.47.2022.08.29.19.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:22:52 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v14 0/3] EDAC/nuvoton: Add NPCM memory controller driver
Date:   Tue, 30 Aug 2022 10:22:35 +0800
Message-Id: <20220830022238.28379-1-milkfafa@gmail.com>
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

This patch series add DTS node, dt-bindings document and driver for memory
controller present on Nuvoton NPCM SoCs.

The memory controller supports single bit error correction and double bit
error detection (in-line ECC in which a section 1/8th of the memory device
used to store data is used for ECC storage).

Changes in v14:
  - Fix compile warnings

Changes in v13:
  - Support error injection via debugfs
  - Fix coding style issues

Marvin Lin (3):
  arm: dts: nuvoton: Add node for NPCM memory controller
  dt-bindings: edac: nuvoton: Add document for NPCM memory controller
  EDAC/nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  54 ++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  11 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 516 ++++++++++++++++++
 6 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

