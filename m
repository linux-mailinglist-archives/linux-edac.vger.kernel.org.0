Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119C5ACDC1
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiIEIce (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiIEIcI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 04:32:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D6D6A
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 01:31:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso11481167pjh.5
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s3hOdjxXsap0YRXvjxYWIlEI0piYVKoTC0n9P5HnS8U=;
        b=VJJzPQJ1cWBEZK1HBWOn5P3vqsLLo9JWaWwO7q2CaasS7NEA3XlpZk4YrMbS0ioQmx
         2DUmKBWzVSo+TcyoNxbeoUPYTGV5zRpvAK88DxEdKCpeltfsC1tR14akp28UetRl3iu0
         XeNtjMnphRjAPxDSYQYmMfiyTFe/k/YOPhufSCMz5yM9rBUupijYpLpOoiKHXN+Ke+1T
         DFdXIBPXkmhEazPMWS9qvAiEJvTkBl2PBA98xz2lgeMQlFXLwzhpHfWCLZfcpqiafDpd
         aY8s5bh12f0Z3IJJbQzwPfk92ut5OVuOlIm/FXXh17AZX7mPSC66s4M6bmkTNx5Nhv7J
         b1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s3hOdjxXsap0YRXvjxYWIlEI0piYVKoTC0n9P5HnS8U=;
        b=5rXDvS03SPZFdwPBshDw3WCkjqBFMNByGXpLPOwWTQxpazkPMfgiMd/BnDH5hCzHVr
         MTOHAM/6K0xsBteHCcZDj9Q+vb2A9vMaruwMDtJVJgK/q6yME0Yz0M3sb/U1R27mQCE2
         +53wAEDl2C066B9y9ngyVMyvWKraJV6xhAV1I3Z69wc5oxid1dnWTgv2S4mX8TRCp0Fp
         /SP5fBeQgrqolKpVCmwbsBh7w5vLPUxoefZKZAbReMfWE08+HBO6iSuYYH3rdY0Ak8GT
         Pcp9DPKnIWbJus+pHj1LXZOyTJOrDhEpORyYeZpmSIF6xP/0Zd6wz2NwKJ1j1S446MFF
         TLng==
X-Gm-Message-State: ACgBeo1Kj57hJvZIJI2VT+LUhlMIDMS+f+/l1FT2BZmeTmuapOaBWLnb
        iI5JxNJoRHDKNn9b2SciUGVoMQ==
X-Google-Smtp-Source: AA6agR4nKAVKAuZX1ZISjF81oe65A4kGyO+0VV8EZk2A7ZosaG47IwTfakAHqqYoOBU8VO/tJRK1pg==
X-Received: by 2002:a17:90b:1b52:b0:1ff:f536:1f3c with SMTP id nv18-20020a17090b1b5200b001fff5361f3cmr17807344pjb.232.1662366691713;
        Mon, 05 Sep 2022 01:31:31 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00537dfd6e67esm7089721pfo.48.2022.09.05.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:30 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/6] Use composable cache instead of L2 cache
Date:   Mon,  5 Sep 2022 08:31:19 +0000
Message-Id: <20220905083125.29426-1-zong.li@sifive.com>
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

Ben Dooks (2):
  soc: sifive: ccache: reduce printing on init
  soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes

Greentime Hu (1):
  soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.

Zong Li (3):
  dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
  soc: sifive: ccache: determine the cache level from dts
  EDAC/sifive: use sifive_ccache instead of sifive_l2

 ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/sifive_edac.c                    |  12 +-
 drivers/soc/sifive/Kconfig                    |   6 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 .../{sifive_l2_cache.c => sifive_ccache.c}    | 183 +++++++++---------
 .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
 7 files changed, 136 insertions(+), 113 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
 rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (34%)
 rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)

-- 
2.17.1

