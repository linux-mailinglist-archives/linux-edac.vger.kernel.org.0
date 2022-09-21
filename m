Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D265BF5CB
	for <lists+linux-edac@lfdr.de>; Wed, 21 Sep 2022 07:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIUFJW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Sep 2022 01:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIUFJV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Sep 2022 01:09:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD17F268
        for <linux-edac@vger.kernel.org>; Tue, 20 Sep 2022 22:09:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h3so5613839lja.1
        for <linux-edac@vger.kernel.org>; Tue, 20 Sep 2022 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=TgTQReumepLDe4ov6CDHPrQQsIPWNDax0l8u9Rzrs0M=;
        b=FNR4DfsImI34Tdj1kbATrXg+qWoJ2JGx2IvHCZwimcpkwPVtI+exf/w3P+sQiU4kRY
         5x+aqYP5WCJlBUKUJzLq2GNaC0ZMWcL3rjTlBFT51m//vs15UHg8EhIKgKrr3WhLktZh
         sQf8VKiiQFN+KuZ+UW5fL1h8m5SO42WnXuwM3K0e3JfVqjI5qLaY6gik5p9xs4cEK4cK
         iFjnSkomxmOc4LiOSnKurQLLW+wRjyF5jZd+bPCZ/XTsuaey+bEqWnCBdpTFb+asFN9r
         txZGautSqkGqoejgYOYGPhIo/pUbGwFIJboHg4uoi8u7wEYxOAiAb18FN6nGX0S+abzm
         vDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TgTQReumepLDe4ov6CDHPrQQsIPWNDax0l8u9Rzrs0M=;
        b=j3anHdLCY67Iol3woYNIPsa6c389nOagj3TzLbnnMHNPoAkeUo0taw+HEvULzmzRfm
         njVq+y4ekktKbzoh/8RLtJhMEh04Aze3cMRQcnAn29ZitRTrpgJXFmWzH+RTkoyAVHs4
         J029uFl1/R4iMjBvCa9/YOpIoubkL6bpIPFG+Iw8dc5OJghcA8dWNoQnKO3ZKfyIJ5fv
         exVlqWPvQcrTZwHJZ+ruFwbcqwqJXEImS2e3sC8f0IdS12E+f3UnnuKDhUW2pp1TDHbi
         BJ4wdHfYVEvNdZN9UwTPXrKsFXfgAmmy+5EI2OS3HptVGO+77yeAyowQYaC0oTOhDaFp
         zrag==
X-Gm-Message-State: ACrzQf3TEIZdPYm70aVgbF1HBqBiT6dlzvyWbdxXHBTrgt7XZxkLc3Zg
        Fz7fAOQNBf+YrGZY1K/X+seVeoEghCODLc/6QXY1kTiNH6I=
X-Google-Smtp-Source: AMsMyM47NWYvjKJ/EBMRKSFdl0fTC0zOjyszTcSGJVSYFzud/66lHqmfYE77sEvbGyG3ANNIXiYNTN89bIxFqKpBLk0=
X-Received: by 2002:a05:651c:1611:b0:261:e11c:c2ef with SMTP id
 f17-20020a05651c161100b00261e11cc2efmr7794318ljq.340.1663736955640; Tue, 20
 Sep 2022 22:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220913061817.22564-1-zong.li@sifive.com>
In-Reply-To: <20220913061817.22564-1-zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 21 Sep 2022 13:09:04 +0800
Message-ID: <CANXhq0qG-aEEHxWbtRgC+RO-wC36MtPUfu+eMpX89wOtqGJL0w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Use composable cache instead of L2 cache
To:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ben Dooks <ben.dooks@sifive.com>, bp@alien8.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 13, 2022 at 2:18 PM Zong Li <zong.li@sifive.com> wrote:
>
> Since composable cache may be L3 cache if private L2 cache exists, we
> should use its original name "composable cache" to prevent confusion.
>
> This patchset contains the modification which is related to ccache, such
> as DT binding and EDAC driver.
>
> The DT binding is based on top of Conor's patch, it has got ready for
> merging, and it looks that it would be taken into the next few 6.0-rc
> version. If there is any change, the next version of this series will be
> posted as well.
> https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/
>
> Change log in v5:
>  - Add a patch to modify aux vector for sysconf
>
> Change log in v4:
>  - Change the return value from from ENODEV to ENOENT
>  - Apply pr_fmt refinement to all pr_err
>
> Change log in v3:
>  - Merged the EDAC patch into L2 rename patch
>  - Define the macro for register shift and refine the relative code
>  - Fix some indent issues
>
> Change log in v2:
>  - Separate the rename and diff to different patches
>  - Rebase the dt-bindings based on Conor's modification
>  - Include the patches of Ben for refinement of printing message
>
> Ben Dooks (2):
>   soc: sifive: ccache: reduce printing on init
>   soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
>
> Greentime Hu (2):
>   soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
>   riscv: Add cache information in AUX vector
>
> Zong Li (3):
>   dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
>   soc: sifive: ccache: determine the cache level from dts
>   soc: sifive: ccache: define the macro for the register shifts
>
>  ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
>  arch/riscv/include/asm/elf.h                  |   4 +
>  arch/riscv/include/uapi/asm/auxvec.h          |   4 +-
>  drivers/edac/Kconfig                          |   2 +-
>  drivers/edac/sifive_edac.c                    |  12 +-
>  drivers/soc/sifive/Kconfig                    |   6 +-
>  drivers/soc/sifive/Makefile                   |   2 +-
>  .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
>  .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
>  9 files changed, 158 insertions(+), 116 deletions(-)
>  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
>  rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
>  rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)
>
> --
> 2.17.1
>

Hi Palmer,
I was wondering if this series looks good to you, and could you please
help us to take it into riscv-tree?
Thanks.
