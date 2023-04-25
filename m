Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA926EE716
	for <lists+linux-edac@lfdr.de>; Tue, 25 Apr 2023 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjDYRsM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Apr 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjDYRsL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Apr 2023 13:48:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F69CC08
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 10:48:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so45695599a12.0
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682444888; x=1685036888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcxFO2xTMg36i/5Q7JJH9AJ6hiZ7aJBXinwK6USz+U8=;
        b=C+hC2vLGnqrjt5SK8tv5gRii/6G+4ON+BWBn3I7OgJtyc5iOGqVCLwciwDPWgAkQVZ
         WWSrszk2b7YsCbgx6m0IpcqPc0VUrVcIOOiKcmR5iL3hIqAd5shI03nDWeigC9X4OMlO
         Lw0iIC20hKARS04Tvaa4VSoi73dN47mvEBETc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444888; x=1685036888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcxFO2xTMg36i/5Q7JJH9AJ6hiZ7aJBXinwK6USz+U8=;
        b=HUIo7D7w7gscFskYnm/8bACgvze8VdVUht2V52O4GL7GwN6Z3czAuXnxMOF8JO5AQK
         nOLA9JiA9Og49tn0MVc1M3icWLLv+CoF6BjPG0K0Fhz/KiVc1zgwbezdCVud09/4YDQh
         yuVgDPb2jwmlt/WJ+N5V8d2Vudhr9lGB6ej3WZ0vyB3BIiDVXNIL76SVecpYMoifbKkp
         h/oOFCWa+n5rVUkDmhyZSHrf41PFrfOd8JKgHibmCc23wRBSe9G3GEkIrWkKEydsf1sD
         LDPL+HBqZjFCB20mFEHfXA/RrZJNzYKU2tindpRCdDpoR6bJhgVrL234DVFzFO7lZ7J9
         5ZOg==
X-Gm-Message-State: AAQBX9cFYXeSjYu6kCM1+oSFWqmGrvd1JNdMZAgfqFR0kN95qRxTPKIi
        o6dseHjvMdInFrquQk9lvC5xsG3nUER0lYNTjnsb/A==
X-Google-Smtp-Source: AKy350anunuvJjD8oecdUWB97Zidv1sVtvvlTcyWx4JaxPaMhj753jo3VtXXIQxl5vEZ7BYl+hSS5w==
X-Received: by 2002:a17:906:52c2:b0:946:c1d2:8b5d with SMTP id w2-20020a17090652c200b00946c1d28b5dmr15262282ejn.17.1682444888438;
        Tue, 25 Apr 2023 10:48:08 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm6881286ejo.206.2023.04.25.10.48.07
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:48:07 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so45608535a12.1
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 10:48:07 -0700 (PDT)
X-Received: by 2002:aa7:c50a:0:b0:504:81d4:118d with SMTP id
 o10-20020aa7c50a000000b0050481d4118dmr16059608edq.3.1682444887178; Tue, 25
 Apr 2023 10:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
 <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com> <20230425173520.GDZEgPWMmi7ZXrTLs2@fat_crate.local>
In-Reply-To: <20230425173520.GDZEgPWMmi7ZXrTLs2@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 10:47:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNnK--B_K7DHvU28PKX00fUpb9oUmSq9OpkOLPDrMkUQ@mail.gmail.com>
Message-ID: <CAHk-=wiNnK--B_K7DHvU28PKX00fUpb9oUmSq9OpkOLPDrMkUQ@mail.gmail.com>
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

On Tue, Apr 25, 2023 at 10:35=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> While we're on the topic: when we send you tip urgent fixes, we base
> each branch off of the current -rc, put the urgent fixes ontop, test,
> ... and send them to you in a week's time, roughly.
>
> Now, after you've pulled, we could fast-forward the urgent branch to the
> next -rc where new fixes come - and I do that most of the time - or we
> could not do that because of, as you say, if there's no really good
> reason to fast-forward (important other fix, new functionality from the
> newest -rc a patch needs, yadda yadda) then those urgent branches do not
> necessarily have to be fast-forwarded but simply get more fixes applied
> ontop.

That sounds right. Do the fast-forward thing if you want to update to
a newer rc for some other reason, but if there's no major other thing
going on, you can easily just continue on top of your existing fixes
branch.

There's no reason to actively seek a new base if you already had a
stable base that you were on.

So whatever works best for you.

(Of course, at some point "that base is just _really_ old" becomes a
reason in itself, and then fast-forwarding to have a newer base to do
your fixes on top just becomes a convenience)

> Oh, and I'm sure if a branch is based on what looks like a random point
> but there's a good explanation accompanying it why it is based on that
> random point, then I guess that's perfectly fine too.

Absolutely. Things that look wrong when I look at the pull request
result may have good reasons for them. If you know there's something
odd going on but you had a particular reason to do it that way, just
mention it.

For example - I can get quite upset when I see that all the commits
are very recent and have clearly not had a lot of testing. But if that
isn't your usual pattern, and you had a clear *reason* for the commits
all being shiny and new ("I had to rebase to remove a completely
broken commit"), please mention it.

Of course, if that particular reason keeps on happening, and there' sa
continual stream of "I know I did things wrong, but it was because of
X", then maybe that "X" is a huge problem and should be fixed?

So the occasional oddity with explanations is perfectly fine. But a
consistent _pattern_ of oddities is a problem, explanations
notwithstanding.

              Linus
