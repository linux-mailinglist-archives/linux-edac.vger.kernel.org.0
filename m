Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DB530CB5
	for <lists+linux-edac@lfdr.de>; Mon, 23 May 2022 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiEWJHB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 May 2022 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiEWJGX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 May 2022 05:06:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C902F9;
        Mon, 23 May 2022 02:06:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 1so3055670ljh.8;
        Mon, 23 May 2022 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c31VgxAPOxEUsROXeBcUQluD+gl7iW0O4zV+RmQn2l4=;
        b=VzeQybxfmt+mm9PPUb3UHtTpQKpSuDC/a9OVBfno9GR6vKLUGb4Pg4AjBLUNMWYTuy
         grgMIhNKERZ0dMKDNFL+KfdUIyK+8XxOh0w2JhcZ+MMjzatt8Wb10lxMces8JKUD2my8
         JdCgZHdUi4J0CdGGJfHcHaJXd7KvCpHpEDLm4sz+qmLjCR5rIHSsYWG5gfgU3Qcey6ym
         PJiciL2cQd+eRBmxKuE/OIc0mkdgtiyEhE+gdEZH7YfWX2wm1Cb3MVfldijAYlA2Tlj9
         Fz34w1fMiuZS9OsNY98EsFaBnu9lLEplLLp5wdpQou/0fSNnWTLkmCf+Oi12BjKoTlux
         sGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c31VgxAPOxEUsROXeBcUQluD+gl7iW0O4zV+RmQn2l4=;
        b=jfrw/n/vFc4K2F/HlQNpQwtFB/UFARxQO0K/51s6wHBBfTGs8RtSXTMERchw1hbnNj
         JLg1Zf0GmHEx4joFyKR/A9g0U4g5mHLd2lwwWr/KD+poY6sfkgtkPo3PGJN+69Qr3XUq
         s5ubPBfYiBgUkKiSad9tisNUsiqC6P+e/YqLyZ8H2lYyEbXVs2isE5/nPsj5MrLrxvoS
         MNcDYYEMQ2Lx/tKwnwqvIh2Kusq/viOFZeOlSNYFRSY4ftjtxxm5SvTS77mWaZY589FD
         AiPxGJWALcf3wbnMXWILh4vlmAP8OxbEjWhM1LMcvVPs80YohGOAbDbjgQcF/uo/XBCi
         nrpA==
X-Gm-Message-State: AOAM532N/OCbREF1+0hMn8NHA5P3VtZDVjgGOpdyWLNUFZisgTniArnh
        I9Me1Ptv1lbBKbkDnKyFlAQ5hXuTnwXT54WHwM5XyeF7oCMdYg==
X-Google-Smtp-Source: ABdhPJzQV4IXbyzcOthbMe7j41Fs7BnkjjlQ4eONXsKw18HGNDtmbpONBK22qWAVgeySQWNNUCwIXjvZj4PeAs2AJos=
X-Received: by 2002:a2e:8691:0:b0:253:def8:ed29 with SMTP id
 l17-20020a2e8691000000b00253def8ed29mr8503892lji.423.1653296779214; Mon, 23
 May 2022 02:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220510031056.1657-1-ctcchien@nuvoton.com> <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic> <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
 <YoYPGWreQuF9QZzc@zn.tnic> <CAHpyw9es-n+bW9SsGBmmr3ghBFk8Q8E6ZTbE42BpU-6p8LfHtw@mail.gmail.com>
 <YoeE8cBhUkF3K44/@zn.tnic>
In-Reply-To: <YoeE8cBhUkF3K44/@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 23 May 2022 17:06:07 +0800
Message-ID: <CAHpyw9fAfNf8j++JtLhuudSWj6N1-KAxA_fxEGL998WNVXTPdQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
To:     Borislav Petkov <bp@alien8.de>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Borislav,

thanks for your comments.

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=8820=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, May 20, 2022 at 10:31:05AM +0800, Medad Young wrote:
> > for the second warning, I did upadate my .git/config according to your
> > advise. but I thought I met orthe problem, I will try to fix it
>
> You need to do "git commit --amend" on the patch so that it updates the
> author.

I did do "git commit --amend",
I beleve the issue is about the mail server I used,
I use gmail to send the mail due to the mail server of my company
does't support smtp
so now I should sign the commit with my gmail account.

>
> > for the first warning, did I really need to fix it?
>
> Yes, you need to fix both.
>
> Again, before you send, run checkpatch on your patches, one by one.

OK

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

B.R.
Medad
