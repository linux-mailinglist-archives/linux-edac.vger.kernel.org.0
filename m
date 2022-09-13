Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C95B67B3
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 08:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIMGSa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIMGS0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 02:18:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5635725A
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i19so7115463pgi.1
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y5P7by1jIpQzIvb2tD2gXNIWnK8iruU4UUaIlQg1bkU=;
        b=FURSNvAsrwuNMGImdijAMz8mE4g8/oBqhm2etPnz9/VXqv0Wwf67+KLa1RQz8Xk13f
         XiBgKDhzEU69AdabcMPz2RN3RilK93j0H1dS9dyPpWaQXYvGadDCcnqn1tsNr0VyzOqr
         EPQxGjZpaq3hOYm55EQ8n/LM7JO2D10khgdiMI88KNnABIowBIcPHZWrm/4YUlM8ivWu
         in3n05qIeaKrUeslPFcz9TDWIF85hPMvzC/tmIdmSXcBjHcwMxXPoooWmOXdtNveXf5R
         kLjeFBC324DCi0GbpIqmAGBPinp81KwIPJCEeYT+DFP+W+7EW75m4UdWiR+agje4LkfQ
         W5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y5P7by1jIpQzIvb2tD2gXNIWnK8iruU4UUaIlQg1bkU=;
        b=ZF/JXW0maqmHVZ7XCT4C7o+LT+e0ebo7xDvmmuIEM4pU66ZNthQWoy05SZmM1+RCxh
         NKkjy9vCrY7Z13fJdJUQ19hMtytsOzJgPaDI73Lw5jxScDt3U+A2rzVufAu4TfmOMcoI
         gE/ZUsQIIU8AwqMJLP6FiXrXsn/YbR+1qWn9+ENoo+WjhNHpxbTiCQDndJXgPkS7iJvk
         yTNp4XGqH1ONrPPlfcCOIslHMQYKQ++Y9/pLr2Ht7PflsPjzBvYJpa75VAmfJSovMh9o
         XkAmdYq0DmSjuEmfikxkispl3xM/q8tWWUmvdLPbdg58/eQwlmm4kvbab0DhVCCEj1T8
         JRHQ==
X-Gm-Message-State: ACgBeo2ol1RZ5/NJE1Uu9sSNWy0MX3D9Nt8uFZ+gw6ZLZKaZEakU0KfF
        JuTfmcuGyt8/cvjr/s5j/K3CDA==
X-Google-Smtp-Source: AA6agR5kuFJvWnGaHooiefmgt6Shu6OXVYfwtD+luhjkdQ8TycC57b+ASOg3PzAvilZOrJNJZdasbQ==
X-Received: by 2002:a05:6a00:21c8:b0:52e:3404:eba5 with SMTP id t8-20020a056a0021c800b0052e3404eba5mr31522452pfj.67.1663049904141;
        Mon, 12 Sep 2022 23:18:24 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:23 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 0/7] Use composable cache instead of L2 cache
Date:   Tue, 13 Sep 2022 06:18:10 +0000
Message-Id: <20220913061817.22564-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Change log in v5:
 - Add a patch to modify aux vector for sysconf

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

Greentime Hu (2):
  soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
  riscv: Add cache information in AUX vector

Zong Li (3):
  dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
  soc: sifive: ccache: determine the cache level from dts
  soc: sifive: ccache: define the macro for the register shifts

 ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
 arch/riscv/include/asm/elf.h                  |   4 +
 arch/riscv/include/uapi/asm/auxvec.h          |   4 +-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/sifive_edac.c                    |  12 +-
 drivers/soc/sifive/Kconfig                    |   6 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
 .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
 9 files changed, 158 insertions(+), 116 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
 rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
 rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)

-- 
2.17.1

