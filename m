Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAC6EE624
	for <lists+linux-edac@lfdr.de>; Tue, 25 Apr 2023 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjDYQzh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Apr 2023 12:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjDYQzg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Apr 2023 12:55:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E6D307
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 09:55:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f109b1808so1133606666b.1
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682441732; x=1685033732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIA68ceP7iZzPJ+vVNyRxj8lFQGUcY9/Iscq0YFStw0=;
        b=G49hTlL8E/5vGR8fm0auT2wYkKZaWNXVWQAKwkH+MOpk8DXQqAIjTIlHh1ahlr9LOy
         aNaix5qXGgNhkaYDX5tWl/KQ4BiaYNKjv05NRHZopTyTqjryGWP87mKWzT+hpHe1LTLa
         fE8ZsYyUvS1m6TQVWaR1kDmGBOjMnFyDGXbtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441732; x=1685033732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIA68ceP7iZzPJ+vVNyRxj8lFQGUcY9/Iscq0YFStw0=;
        b=R6M+Ta98d5mizuKDAGtyYTylUeBtEl3htEkLVqBHXmYeaGZ6ze61FXM9m8ay+6CZbl
         KDrQSTdVaiIolMJD5saPh+qyk2vVJLO2O+e7o6vM8FlwUdd51pxbpp8hck4rOG2613Jm
         D9BND2clyvrkI9IjK9+xKUDwNEkGqW4aA5vN5mHzVwlmjfPvfRSmVaGqb3uSUrIXQ4LR
         8ggXHYvDvFQoFyiFlrGA0/NTJb2m3ABdw2+ftVVVBvVn85EZf61xR43RYi/7uk8UcVCf
         Fp52yChR7y6oEDBRcZmQfBGArYjBB7MWIHiSroxshATz2nHmNLMznmMGmf/iSekYyAZq
         nVbg==
X-Gm-Message-State: AAQBX9fJJtYW7aK7sB+srbRSy9lNJxnOGidWhTeB2vQ/HLPEqIajOSRI
        iqObGVugW/Vouxxx+kCyV0BCtIc51pYd6iud8opk/H9H
X-Google-Smtp-Source: AKy350Y58Ljt0STvFi2QM7nhSzzbkTggz/VEhuKGhUqO8gYo/ysTNSz8MnfXqTfES7YgLYuEbfg+eQ==
X-Received: by 2002:a17:906:4d0d:b0:930:3916:df17 with SMTP id r13-20020a1709064d0d00b009303916df17mr15508933eju.0.1682441732605;
        Tue, 25 Apr 2023 09:55:32 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id w27-20020a17090633db00b0094ed0370f8fsm7077947eja.147.2023.04.25.09.55.31
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:55:32 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bc07so10159357a12.2
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 09:55:31 -0700 (PDT)
X-Received: by 2002:a50:fb8e:0:b0:506:843f:2f27 with SMTP id
 e14-20020a50fb8e000000b00506843f2f27mr14643641edq.11.1682441731504; Tue, 25
 Apr 2023 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
In-Reply-To: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 09:55:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com>
Message-ID: <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.4
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 24, 2023 at 12:28=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> For some stupid reason (juggling gazillion things at the same time,
> probably) I have based the edac-amd64 branch *not* ontop of plain
> v6.3-rc3 but there are a couple more of your merges ontop.

It's fine. Mistakes happen, and honestly, the "base your work on top
of a stable point" is - like almost everything else in life - a
recommendation for everybody's sanity, rather than any kind of
black-and-white rule.

And it comes mainly from people actively mis-using git, and merging
random upstream state without thought, and trying to set that kind of
behavior right, and have people _think_ about it.

IOW, it's not some "this gets enforced" thing - it's more of a "you
did something else horribly wrong, so let's clarify what the 'good
thoughtful git behavior' should be".

Sometimes starting at a random point can even be a feature - random
cleanups that depend on some helper that was added last release, and
it's just much more convenient to start at point X ratherr than wait
for the next -rc.

Now, the thing I do hope that people actively try to avoid is picking
a "kernel of the day" during the merge window to start on, but even
that is less about "well-defined starting point" and more about just
the fact that the merge window kernel *can* be really unstable and is
a really bad base.

But some "rc3+" kernel is certainly not that kind of _horribly_ bad
kernel to start at. It's probably better than starting at a rc1
release in practice.

So the "try to use a reasonably stable starting point" really is a
general recommendation, and mostly a reaction against people who tend
to do more of a mindless "rebase/merge to today's kernels without any
thought" kind of workflow.

So I'm not asking for surgical precision. I'm asking for "reasonable
workflow", where people avoid doing pointlessly silly things.

                 Linus
