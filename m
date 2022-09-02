Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538685AAB4F
	for <lists+linux-edac@lfdr.de>; Fri,  2 Sep 2022 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiIBJ1e (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Sep 2022 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIBJ1d (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Sep 2022 05:27:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCDBFA97;
        Fri,  2 Sep 2022 02:27:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so4938014pjq.3;
        Fri, 02 Sep 2022 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pWy2kwNqBvwcyw3fBPdY/JfajG8Vs72kY13dOodD5tQ=;
        b=hG+sHGkjpI8EnZ0YS8lhCTS0vbXfiYfns2SbT+EcMHIJ2o1c8YBE6A3snWTGoljJ3V
         zSh+tpSxLWOKnxnXAtFtzdH2g3GGOkXKXMadTiTN1vHTCWKdSVDcRLvCL0tdFyPmrxt7
         jPs9q6Hsn/+TLWlHjsY4uKZptNsy462NFhU18Mm2fco4j2CRwbAp2QO5GM3DzvNIdmPO
         EsNst7yz5Vm0iL6aQo8PR+zAggIOSTU21O4LlLua4lq+kIcOZ5PEQnmtmDszPLWihx7K
         XqDpv/dLRGGtoKQJLqeTbAQHMoro8PgZ8wbJOL8XzqmRdi4qLGj68iYolMNqIDPvCoRy
         5JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pWy2kwNqBvwcyw3fBPdY/JfajG8Vs72kY13dOodD5tQ=;
        b=y9BfduC4P6AAXigdpfz10nwbvZJH3VrwEH4C7dMxxPJ9kaReRbgFoOk7AJ8z3LtOQ1
         kRbduiescIReBcpKUQVAOIScH13IFXOHsQH81M5dJSp4df66GxsMXLJTNJkIqwcTK7Oi
         fiDJYRR0RKWFap2IOC4qGjECtuRRcXGaxTfnfZWXCc3G2/rVjxx28mJaTM/oW5tmGyge
         vnFU3xywhPPdOdYUBPlcDgTn4cA+aiPcHK3L55XldxPQzGLkUusyzcQPZ2muoehVGSVu
         340s2muZ9Hgw5Wg/td/ZZZ65vIIEZwCBmotTQWDYjck3uCDbN4a8I6FaW4zIQKEQUtxp
         n4gg==
X-Gm-Message-State: ACgBeo3p+13yZF+JWAAtnxJlwBZloomiRnqQx4iIc/MXP8wa4sVO48rS
        XUEoQjl5c+S3oHd55m0Muj/ViHuTudhigw==
X-Google-Smtp-Source: AA6agR6vw56oJH0NMXCoOMzY/8aFlYkyziOZAMyASf3qy0cwfesRkYKFXmP+o0W6dit5vKyUYi3YKw==
X-Received: by 2002:a17:90a:d150:b0:1fd:9336:5db3 with SMTP id t16-20020a17090ad15000b001fd93365db3mr3851008pjw.242.1662110851662;
        Fri, 02 Sep 2022 02:27:31 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b005350ea966c7sm1169315pfb.154.2022.09.02.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:27:30 -0700 (PDT)
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
Subject: [PATCH v15 0/3] EDAC/nuvoton: Add NPCM memory controller driver
Date:   Fri,  2 Sep 2022 17:27:11 +0800
Message-Id: <20220902092714.3683980-1-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This patch series add DTS node, dt-bindings document and driver for memory
controller present on Nuvoton NPCM SoCs.

The memory controller supports single bit error correction and double bit
error detection (in-line ECC in which a section 1/8th of the memory device
used to store data is used for ECC storage).

v15:
  - Move dt-bindings document to memory-controllers directory and remove
    superfluous string in content title

v14:
  - Fix compile warnings

v13:
  - Support error injection via debugfs
  - Fix coding style issues

Marvin Lin (3):
  arm: dts: nuvoton: Add node for NPCM memory controller
  dt-bindings: edac: nuvoton: Add document for NPCM memory controller
  EDAC/nuvoton: Add NPCM memory controller driver

 .../memory-controllers/nuvoton,npcm-mc.yaml   |  54 ++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   7 +
 drivers/edac/Kconfig                          |  11 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/npcm_edac.c                      | 516 ++++++++++++++++++
 6 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
2.34.1

