Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC45B2397
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiIHQ1p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIHQ1o (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 12:27:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE2FF086
        for <linux-edac@vger.kernel.org>; Thu,  8 Sep 2022 09:27:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p7so28624842lfu.3
        for <linux-edac@vger.kernel.org>; Thu, 08 Sep 2022 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3t8eO6TrPLunxm/ZNbaRq3mczu/6c1Oc/NxBX2KRXH4=;
        b=GWgpBm78RlMWnyJ/irGaYihsJ3mDOF7/rXdbZg9UgWza5qlyN091Z5QcURInV65b23
         ZUKVKjG5xLepFcfIyJFbg/DHl9Kc5yGwFvdrPoZWcEULbYGDIhYudGrTPJTr+bkQcS2C
         uLTv1oDWmL5sVhFGWFNaaVNh9Mte4K9U1ejmzfXviDqiQHhDqsq3ztD6u3qY0lpz7qlu
         CTR/CFQSNVnxrsTtEo99gdMJc/JDyM9pG+aJuKJjB4+pNgTX5aSyvW+6pQSpbZ7I6Q/w
         n8vYHlqvhI/nID5aVJzAnKqCrO3Fr8Sof/cp3cRjSFSMNykmpuxN1yn4VaQxVbqBHrEf
         iciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3t8eO6TrPLunxm/ZNbaRq3mczu/6c1Oc/NxBX2KRXH4=;
        b=3/nQ0MHIhoMLV14gxWQh3Mpi3AwlszBP/f33H+h3ijVU7A8sdQVOlz4xh/bxFU3FNd
         tx6HFOeRlrntgHXsjIiQi5GW64Z1CMLGb0zH1Mwx8Ri5dbK0vqxm+m7BOR8SHDO4R5G5
         kc74DpywyOWnkfiW3Axex5TwG6/X5UNPniIehrm1mk0D9HpQ1ze6sjGmP7aF6em1G+iH
         h2iaJXzuOQYHxgUrEdD5Cf5/LDEuA0pfBtUtWAjpCmNV+pRwh7ZNY8LEJRiAnnQO0VS5
         GxhxjjUGzaynkoxtl3PUHFraPE3FeDlqfLnlI6mHVHqTjBkuqjuJPpLW3Pn2AlaUf6Xr
         Im3Q==
X-Gm-Message-State: ACgBeo0abnXn8i/x7z8xyPeng08vlCNFfBqJtjmuQgb6T/WvUqZPGae3
        fLSo4+XOGvD3tpdWrgKdM8omcwVwVOhU0kOdZuAVlQ==
X-Google-Smtp-Source: AA6agR7omRywjZirRBmZDGvfii9XD988RyhNFhSLDgoOFrn+8Ukwt/2iyM7jz70fct6R5sFzcdS5W2JieqWpVwy+VZI=
X-Received: by 2002:a05:6512:401d:b0:496:9971:78c5 with SMTP id
 br29-20020a056512401d00b00496997178c5mr2814007lfb.337.1662654460667; Thu, 08
 Sep 2022 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220908144424.4232-1-zong.li@sifive.com> <e56b67a3-4721-638b-a3d6-54e4d407598d@sifive.com>
In-Reply-To: <e56b67a3-4721-638b-a3d6-54e4d407598d@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 9 Sep 2022 00:27:30 +0800
Message-ID: <CANXhq0qAsYTeU8sLYUiAXq5by35RcURMihYb6DLv6okjS3YZow@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Use composable cache instead of L2 cache
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, bp@alien8.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 8, 2022 at 10:51 PM Ben Dooks <ben.dooks@sifive.com> wrote:
>
> On 08/09/2022 15:44, Zong Li wrote:
> > Since composable cache may be L3 cache if private L2 cache exists, we
> > should use its original name "composable cache" to prevent confusion.
> >
> > This patchset contains the modification which is related to ccache, such
> > as DT binding and EDAC driver.
> >
> > The DT binding is based on top of Conor's patch, it has got ready for
> > merging, and it looks that it would be taken into the next few 6.0-rc
> > version. If there is any change, the next version of this series will be
> > posted as well.
> > https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/
>
> Is there a change log for the v2..v3 versions of this patch series?
>

Sorry for missing that.

Change log in v3:
 - Merged the EDAC patch into L2 rename patch
 - Define the macro for register shift and refine the relative code
 - Fix some indent issues

Change log in v2:
 - Separate the rename and diff to different patches
 - Rebase the dt-bindings based on Conor's modification
 - Include the patches of Ben for refinement of printing message

> > Ben Dooks (2):
> >    soc: sifive: ccache: reduce printing on init
> >    soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
> >
> > Zong Li (4):
> >    dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
> >    soc: sifive: ccache: rename SiFive L2 cache to Composable cache.
> >    soc: sifive: ccache: determine the cache level from dts
> >    soc: sifive: ccache: define the macro for the register shifts
> >
> >   ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
> >   drivers/edac/Kconfig                          |   2 +-
> >   drivers/edac/sifive_edac.c                    |  12 +-
> >   drivers/soc/sifive/Kconfig                    |   6 +-
> >   drivers/soc/sifive/Makefile                   |   2 +-
> >   .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
> >   .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
> >   7 files changed, 151 insertions(+), 115 deletions(-)
> >   rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
> >   rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
> >   rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)
> >
>
