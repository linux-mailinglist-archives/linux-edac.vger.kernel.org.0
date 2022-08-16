Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1835959C5
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiHPLUG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiHPLTr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 07:19:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC82274CDB;
        Tue, 16 Aug 2022 02:46:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so1192664pjb.0;
        Tue, 16 Aug 2022 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=pHRc3XNJRVdOlhGjXylbNoDow3CdvGIRDLCNfCwr39A=;
        b=Dp4lZy24fLiDRTYbfL/btDWe4UT2Mo6FngI8Ahi75hGbrSe27KKncW1seWJooFwbLJ
         0uBC+i730zsIwpaAsU4yLw7h92LkIXYX1aKtDy9vbOrPEt7vO3F7BNN4idj0EYfjvXQH
         ryBZWhKGJBJgqp2ZlTqzIsuLeik2oWjgyr/7Ch0tGITiYbn+7h9y4bmi9HK3WIjvXVsQ
         lQtm14c2utZhR0wKNDiSVrzDe5GMUP1D8FAtEcuNATnwiEQOKrY/bbHVm6W0kb4tIdD2
         Ul0rAkNIVycp6cuPgCp37eWPGfGVIX49WsFq6dvqCmBZvVk8jNBAS9PqudgsoEntOStt
         WlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pHRc3XNJRVdOlhGjXylbNoDow3CdvGIRDLCNfCwr39A=;
        b=zOJTiTTygKMA8Pz7B4KdmzFE6t3IUy8fHSY1lCRcECFrV2Qa8icLFcQJiG1bneFfsn
         yi38pccHxdqBDnbCcZ5VHUfuSxGjjLRz94oYUjZ/qUAcD6Qi5KGxU3ph9vjrvJj/dRnD
         ouYT1MFZq34pHXWAYwqvTKO6feT4nMht/BN/MFrlNeZ2nW56EqkwHU8hZYSg/hMD8gmS
         AWRwI4D2l6KDFj+JiNXUTG1hZPyLPOI6JgkTCJMPwWlTTNG1DkyA9DtsI+cecOkO9h3H
         Fk4lrLDQC9fkxpfg/I+2MkzSl/TaMjGSSieu0JY9G90nfMQ2zFiRM9T8uLNfV/XY+VKZ
         Wg0A==
X-Gm-Message-State: ACgBeo1DVyZSgSDH/1Qq+/2Czl+P/ppS//XLVys3HcbQzZImO+WFmmUU
        s/zDPRZyy9xdTkPTFgmSC/PUTvMFy2Rhig==
X-Google-Smtp-Source: AA6agR7c2QGtIrRRRVg2sQ3CWbprJCmOgPTeTKk7l5ouPudQj59Nh8ZSBuwCXdv+2WInsIlFSElPNA==
X-Received: by 2002:a17:902:d546:b0:16e:c70c:fdf5 with SMTP id z6-20020a170902d54600b0016ec70cfdf5mr21500871plf.100.1660643217711;
        Tue, 16 Aug 2022 02:46:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902e98c00b0016bee668a5asm8578767plb.161.2022.08.16.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:46:56 -0700 (PDT)
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
Subject: [PATCH v13 0/3] EDAC/nuvoton: Add NPCM memory controller driver
Date:   Tue, 16 Aug 2022 17:46:38 +0800
Message-Id: <20220816094641.8484-1-milkfafa@gmail.com>
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

Marvin Lin (3):
  arm: dts: nuvoton: Add node for NPCM memory controller
  dt-bindings: edac: nuvoton: Add document for NPCM memory controller
  EDAC/nuvoton: Add NPCM memory controller driver

 .../edac/nuvoton,npcm-memory-controller.yaml  |  54 ++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  11 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 512 ++++++++++++++++++
 6 files changed, 592 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.17.1

