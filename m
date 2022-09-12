Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6725B54A0
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 08:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiILGlL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiILGlK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 02:41:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157C22BFF
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:41:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z20so9385933ljq.3
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IUm/MN9hYg83su7ZYahLGm5MEwsIsG/QUzjstSeG6Mo=;
        b=kI34oFaT/0WS4Cfj03tST6nGUpXjNT380JwZ8FEdZt75QHxAkIIf6k0og+uTwf9eTq
         NucX3cDSq5+0xiCS0rQXRopsfEykwrDtmoLfDq5k1ccgq58Ym+3kbNX/k38bz/lnJhfd
         a5yFamW9SM3CFIxVNuRbQoPP7Su31yvXtOON777PIstuoMTTkLMqG/H/F6ObCibwPlCQ
         NEH3rmwq85391FHz4YrWGLtUoGLzBJgCcB04MAVXh/Kel3ysSkw/tN011zrV6s6epDp5
         IE+auP7GxK133EIlSC8Ez0IiUkBvtfxpVv8in9PJQMvU6spqLCbJIYuXosuQfHsL3edu
         xQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IUm/MN9hYg83su7ZYahLGm5MEwsIsG/QUzjstSeG6Mo=;
        b=wjHzFtnBJNenzfBQ19Yo+aiXm42ZsTvFLroz0rSOUdO1rwoXTLO3/VfBSfkURJjXKI
         DTLjuJKEnTGE1jSFFTz0CLER1TZEZSZ0gBTux5a5f//0ZB+bN0UeWkpuHNhuxVE4jXZ+
         YLzB2rRbh2Kz+aEhFUbQd9JiP1AmxeGYNQ+8iy1mmNX5EEh8+QL0wnNm5ZPErV9tIGak
         sK/3LIPkcOm5ag9yp1o3M0/NQaMncaAYXHh7vlIt4RUfsrz0qPgM8bJpOI8nD+xuuOgW
         GwY4au7JT9NIk61WWHgt/dZXC6B7V4wZ0bwV/kqCbWNPzbKrdclL7v00YSFXhKXMDqrI
         9F2w==
X-Gm-Message-State: ACgBeo1+V8V4ku9v0vpYUEjHjquVXOiCR5YCgARR2HrT/HjX32YaVWCv
        Ww2GPGNxC3HjagiXbtH9f9wkIfBp6GqxOnLbGVMPdw==
X-Google-Smtp-Source: AA6agR5s2whA7uWOJa+KmUu83OmHts4XhTJeLfLamvGr/SSqHLqGGJ3PE6/vnSEQ3bawMQV3MgXyResxjLGZLowFb1s=
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id
 o20-20020a2e7314000000b0026aca1860ebmr6790851ljc.69.1662964866499; Sun, 11
 Sep 2022 23:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220908144424.4232-1-zong.li@sifive.com> <20220908144424.4232-6-zong.li@sifive.com>
 <36fe0073-7fa2-9733-7041-d9f70da1a5ea@microchip.com>
In-Reply-To: <36fe0073-7fa2-9733-7041-d9f70da1a5ea@microchip.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 12 Sep 2022 14:40:55 +0800
Message-ID: <CANXhq0rRZhPtrpRQOnwbJj-GRVSCHErLxvGnPAxqfJBk8rNRPQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] soc: sifive: ccache: use pr_fmt() to remove
 CCACHE: prefixes
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, bp@alien8.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 9, 2022 at 2:40 AM <Conor.Dooley@microchip.com> wrote:
>
> On 08/09/2022 15:44, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Ben Dooks <ben.dooks@sifive.com>
> >
> > Use the pr_fmt() macro to prefix all the output with "CCACHE:"
> > to avoid having to write it out each time, or make a large diff
> > when the next change comes along.
> >
> > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> btw, I think Ben missed a print - a pr_err() in init().
>

I got that one, I will fix it in v4

> > ---
> >  drivers/soc/sifive/sifive_ccache.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
> > index 58d14f11a63a..b3929c4d6d5b 100644
> > --- a/drivers/soc/sifive/sifive_ccache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
> > @@ -5,6 +5,9 @@
> >   * Copyright (C) 2018-2022 SiFive, Inc.
> >   *
> >   */
> > +
> > +#define pr_fmt(fmt) "CCACHE: " fmt
> > +
> >  #include <linux/debugfs.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/of_irq.h>
> > @@ -85,13 +88,13 @@ static void ccache_config_read(void)
> >
> >         cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> >
> > -       pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
> > +       pr_info("%u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
> >                 (cfg & 0xff), (cfg >> 8) & 0xff,
> >                 BIT_ULL((cfg >> 16) & 0xff),
> >                 BIT_ULL((cfg >> 24) & 0xff));
> >
> >         cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> > -       pr_info("CCACHE: Index of the largest way enabled: %u\n", cfg);
> > +       pr_info("Index of the largest way enabled: %u\n", cfg);
> >  }
> >
> >  static const struct of_device_id sifive_ccache_ids[] = {
> > @@ -155,7 +158,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
> >         if (irq == g_irq[DIR_CORR]) {
> >                 add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
> >                 add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
> > -               pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
> > +               pr_err("DirError @ 0x%08X.%08X\n", add_h, add_l);
> >                 /* Reading this register clears the DirError interrupt sig */
> >                 readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
> >                 atomic_notifier_call_chain(&ccache_err_chain,
> > @@ -175,7 +178,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
> >         if (irq == g_irq[DATA_CORR]) {
> >                 add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
> >                 add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
> > -               pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
> > +               pr_err("DataError @ 0x%08X.%08X\n", add_h, add_l);
> >                 /* Reading this register clears the DataError interrupt sig */
> >                 readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
> >                 atomic_notifier_call_chain(&ccache_err_chain,
> > @@ -185,7 +188,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
> >         if (irq == g_irq[DATA_UNCORR]) {
> >                 add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
> >                 add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
> > -               pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
> > +               pr_err("DataFail @ 0x%08X.%08X\n", add_h, add_l);
> >                 /* Reading this register clears the DataFail interrupt sig */
> >                 readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
> >                 atomic_notifier_call_chain(&ccache_err_chain,
> > @@ -227,7 +230,7 @@ static int __init sifive_ccache_init(void)
> >                 rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc",
> >                                  NULL);
> >                 if (rc) {
> > -                       pr_err("CCACHE: Could not request IRQ %d\n", g_irq[i]);
> > +                       pr_err("Could not request IRQ %d\n", g_irq[i]);
> >                         return rc;
> >                 }
> >         }
> > --
> > 2.17.1
> >
>
