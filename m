Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97715F27AF
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 04:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJCCmu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 2 Oct 2022 22:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJCCmt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 2 Oct 2022 22:42:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE62BE19
        for <linux-edac@vger.kernel.org>; Sun,  2 Oct 2022 19:42:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w13so10166362oiw.8
        for <linux-edac@vger.kernel.org>; Sun, 02 Oct 2022 19:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=kZ54JuJ/U11o6QZTC2tSUVSElKXkiA2E63Q+E0+5Ows=;
        b=M1kro5I7v0dN31CoUeGS0m8+9Yf45ZG6QCrky+SzJN7D4wnopN5pJ1iD4DKfrqhsd7
         934qA5PX17Ao3ydsvtEhSgZTHMUBPtu9uNl6vusKBV/tkvItvV7gEknxWTsRhMdrLnr7
         aTywdmbcaSLkjs79ZkeUk79OrjF/ylKboifLPFppb3jJFw2413QcVXHbF/Q3wCsNNnLE
         iOITOomXo7ldNNpnYi9z0wDF/PInT0aSIDKnQloOkU8uB+WqmqBx36HVPhH8yLTBe46j
         f4uOuwUtsnAaxRH9Z1trhygCxS190M6IkQj2h2d4WdUJiqa8Km70cxZ6PfucdC7AljWf
         wOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kZ54JuJ/U11o6QZTC2tSUVSElKXkiA2E63Q+E0+5Ows=;
        b=030X0Yy/cTrI0weY1E900pNXoXCCnn/yA/6Z1+HL5WPUcHp/9EepdCCl9hysUgTHyC
         IQmIQ5MJLND42DhN8322doOkDQKbsbXG/yT40FmBO+ES/KoEm86yoVZkvzPepSM38Fpy
         MyvvMNIZi0fegCNT1nAkHIkeu9sAwin/kGKyg5bidHj1OWmMIKORH49Kemm5lYY7l1v/
         t0FgA+x8EmN3pdMS5E8MNfdIXIqzgMKYMc4Zwi4sV45bPXA7Dhyl0C29KoJ+e17vMZfT
         +I5TUW+d1AX9sbawx8wqXIlDe5v8NZaMnuiyNMUkEjP6dt50owrk56rcZjwrnw8LZUEm
         jmJg==
X-Gm-Message-State: ACrzQf34x6qwFqvm66l02R7/WraxSIQtNzIOCvQptFshE/xlzAEsjMOY
        mX5xs8FMCA3US1wFYkfe8z+HjtLFT4aQJdx+OLgQkQ==
X-Google-Smtp-Source: AMsMyM5DzDNSJT7AYl3fCNPwDNPYomK9PSogJsIgE6W4jeqpRQGpNrt9ZTjcXZGRKMdL84uSEn0+9KxizakSfJAtYG8=
X-Received: by 2002:a05:6808:150c:b0:350:df64:edf6 with SMTP id
 u12-20020a056808150c00b00350df64edf6mr3125398oiw.283.1664764966993; Sun, 02
 Oct 2022 19:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220913061817.22564-1-zong.li@sifive.com> <CANXhq0qG-aEEHxWbtRgC+RO-wC36MtPUfu+eMpX89wOtqGJL0w@mail.gmail.com>
In-Reply-To: <CANXhq0qG-aEEHxWbtRgC+RO-wC36MtPUfu+eMpX89wOtqGJL0w@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 3 Oct 2022 10:42:34 +0800
Message-ID: <CANXhq0qnvUytyLOgGUiTP3nnic=FgRrezM_9vYwaGNaooU9J3w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 21, 2022 at 1:09 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Tue, Sep 13, 2022 at 2:18 PM Zong Li <zong.li@sifive.com> wrote:
> >
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
> >
> > Change log in v5:
> >  - Add a patch to modify aux vector for sysconf
> >
> > Change log in v4:
> >  - Change the return value from from ENODEV to ENOENT
> >  - Apply pr_fmt refinement to all pr_err
> >
> > Change log in v3:
> >  - Merged the EDAC patch into L2 rename patch
> >  - Define the macro for register shift and refine the relative code
> >  - Fix some indent issues
> >
> > Change log in v2:
> >  - Separate the rename and diff to different patches
> >  - Rebase the dt-bindings based on Conor's modification
> >  - Include the patches of Ben for refinement of printing message
> >
> > Ben Dooks (2):
> >   soc: sifive: ccache: reduce printing on init
> >   soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
> >
> > Greentime Hu (2):
> >   soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
> >   riscv: Add cache information in AUX vector
> >
> > Zong Li (3):
> >   dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
> >   soc: sifive: ccache: determine the cache level from dts
> >   soc: sifive: ccache: define the macro for the register shifts
> >
> >  ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
> >  arch/riscv/include/asm/elf.h                  |   4 +
> >  arch/riscv/include/uapi/asm/auxvec.h          |   4 +-
> >  drivers/edac/Kconfig                          |   2 +-
> >  drivers/edac/sifive_edac.c                    |  12 +-
> >  drivers/soc/sifive/Kconfig                    |   6 +-
> >  drivers/soc/sifive/Makefile                   |   2 +-
> >  .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
> >  .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
> >  9 files changed, 158 insertions(+), 116 deletions(-)
> >  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
> >  rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
> >  rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)
> >
> > --
> > 2.17.1
> >
>
> Hi Palmer,
> I was wondering if this series looks good to you, and could you please
> help us to take it into riscv-tree?
> Thanks.

Hi Palmer,
The new merge window is going to open, do you think is it suitable to
merge this series this time? Thanks.
