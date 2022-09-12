Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AF5B54BA
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiILGuo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiILGuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 02:50:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9D1BEAB
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q3so7062846pjg.3
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ouf6fZur6LuUgpPfN2BtmMmKETEefZcd37KbqJNHwP8=;
        b=MKYat+CAUn4trfJaDAE1pwd5fdLDnZso377mQnrLXJnzBgcDFugu5NEH99edoku8if
         SY60Nd2YBsrXLBdBSASbVDGeCtz7dp3wFUDHUcdKeX0/sLnEq9cTQJbXtCa+V9BGEs7v
         jJUfUR1yl+fstGbMcuVj1LNXc1px+4ozY4n2vdOEUi8uaOUL0flfNqNHZpD3bDDvNgPQ
         uogTmp8/jeAMRO4BM1AP8MPC8I7A/TpMGcqRxQ6fy2aIV34Mw355C2mbywvRxHusYK3l
         ekNEQmxfAK2tl6VLiOyW/MCC2hbt4bd0GMP9z8wk9l8q33O6PQJiE1EM4GfOym+Lnhu5
         rmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ouf6fZur6LuUgpPfN2BtmMmKETEefZcd37KbqJNHwP8=;
        b=0CJkfCatOA6H/d9Rjx+b1WbXmGguun1P4m+tt8LQff94QQBAVd7T9TCJNymKgzTNkS
         BbPyHu2O8PxY6ju7kCa153vqv0SOHka4UpIk5c4sb2a2gyJkY2e5Ouiexdr33dU0q/vC
         SOsc9dKkDs66DBnH8zun0/PrblwoZNqtE/Q+pC6WqiL4z+EnM+QBmCtddwwZ4vjXEFdg
         iqVq61a4e/q5wh2FwSwmObv27ieyX+wMogVnPpyl8qnpHsnbshPOMrePwmiTkcKAvTl9
         NzqMfqH8SPIoce7C9W+wuhwqSJXuP5NqeyKR202CUyNVpIvMCbAL4t27f3bj688ytc/4
         y6iA==
X-Gm-Message-State: ACgBeo2K7AKiKR69XPtICW1kp2VugxLQLFI5da5R3aq8d52pfzFBnc0d
        oy4VUB/Ioi3mtQ/C5GJNd5BPPg==
X-Google-Smtp-Source: AA6agR51HrLD4Ud2goFx43rUQhv8zP1ZxiUocnM6NglxFLvzViS0mNZeLyKBtzXZQlgBAj5V2CxzXA==
X-Received: by 2002:a17:902:8b8b:b0:178:1de4:1fe0 with SMTP id ay11-20020a1709028b8b00b001781de41fe0mr9434054plb.68.1662965436075;
        Sun, 11 Sep 2022 23:50:36 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:35 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/6] Use composable cache instead of L2 cache
Date:   Mon, 12 Sep 2022 06:50:23 +0000
Message-Id: <20220912065029.1793-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since composable cache may be L3 cache if private L2 cache exists, we
should use its original name "composable cache" to prevent confusion.

This patchset contains the modification which is related to ccache, such
as DT binding and EDAC driver.

The DT binding is based on top of Conor's patch, it has got ready for
merging, and it looks that it would be taken into the next few 6.0-rc
version. If there is any change, the next version of this series will be
posted as well.
https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/

Change log in v4:
 - Change the return value from from ENODEV to ENOENT
 - Apply pr_fmt refinement to all pr_err

Change log in v3:
 - Merged the EDAC patch into L2 rename patch
 - Define the macro for register shift and refine the relative code
 - Fix some indent issues

Change log in v2:
 - Separate the rename and diff to different patches
 - Rebase the dt-bindings based on Conor's modification
 - Include the patches of Ben for refinement of printing message


Ben Dooks (2):
  soc: sifive: ccache: reduce printing on init
  soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes

Greentime Hu (1):
  soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.

Zong Li (3):
  dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
  soc: sifive: ccache: determine the cache level from dts
  soc: sifive: ccache: define the macro for the register shifts

 ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/sifive_edac.c                    |  12 +-
 drivers/soc/sifive/Kconfig                    |   6 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
 .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
 7 files changed, 151 insertions(+), 115 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
 rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
 rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)

-- 
2.17.1

