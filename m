Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558F4BD139
	for <lists+linux-edac@lfdr.de>; Sun, 20 Feb 2022 21:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiBTUNW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Feb 2022 15:13:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbiBTUNV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 20 Feb 2022 15:13:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625837A02
        for <linux-edac@vger.kernel.org>; Sun, 20 Feb 2022 12:13:00 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b11so14893220lfb.12
        for <linux-edac@vger.kernel.org>; Sun, 20 Feb 2022 12:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFxI/E7GISHQoZSmk/0oS8AXoqkjxl7Cu/QeFTvV0Ys=;
        b=dnnhS450j/2Trb5ywwsqiILXa4WHzzPx8XIZdP4lB5VS0nlDpw5/RaI8iGmnF1bKXp
         BgJWyyrTd0n645DBU7Uv8OvZfuXr+eHfrWRH146QMxFda/S1HQav7o94a3+46wRg8tGK
         lMjskL7Lbw91TY3BtMevVeE9MtjinmRyll0kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFxI/E7GISHQoZSmk/0oS8AXoqkjxl7Cu/QeFTvV0Ys=;
        b=66kmHGU7Orc3XuRzKI8rAQLz4VoOzB1f+gCFL7z+EOOo5Gt0JZwTxBaS5t2mFQRJtD
         cesCmnpEpZne2+NUqAnaF+SHz8H5e9G3h/8gOdIQRoh5kXKSDoJCqQzQkX/1zOlC4aTw
         acshbdnBRxKXajWRqI+Gt4yPnLn+CTrsVp/elz0Qivv3M7v4GHu3+1D9BirCxON2Nsc0
         F3yGEWEn+wybWn/gOpyIbK/GnXffwDPTTYp8KmithHKMTxDyWw5bamMNv3iHwKsBYi5C
         ag49clx9yWKLwG1tvJ2eSoCdRHwPmh0HJdpwyZxhkrKs65Ayq0ndyXA0zJNPK4U87HpD
         nZow==
X-Gm-Message-State: AOAM5300dOvQgL+r9LAHOskKhUgOmZjI6yZM7tThCPyj3bsyjkTFVwpD
        CqtF3cn1CKpjaK+B68nNnzyFBYlpfv01daA7
X-Google-Smtp-Source: ABdhPJxly6VdBk7XE2KuAwV8+DoPYiJs8ScZ+/K/+o1AaaDwbX+uowBxxugJZSFYHAdjtWvGCX/q3w==
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id bq13-20020a056512150d00b00442aad52550mr12079756lfb.678.1645387978318;
        Sun, 20 Feb 2022 12:12:58 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id k9sm904208lfo.155.2022.02.20.12.12.57
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:12:57 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u20so14949860lff.2
        for <linux-edac@vger.kernel.org>; Sun, 20 Feb 2022 12:12:57 -0800 (PST)
X-Received: by 2002:ac2:4211:0:b0:438:2f1:83c4 with SMTP id
 y17-20020ac24211000000b0043802f183c4mr12021984lfh.435.1645387977368; Sun, 20
 Feb 2022 12:12:57 -0800 (PST)
MIME-Version: 1.0
References: <YhIq94B0MpYGrEm2@zn.tnic>
In-Reply-To: <YhIq94B0MpYGrEm2@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Feb 2022 12:12:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
Message-ID: <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC fix for 5.17
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Feb 20, 2022 at 3:50 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull a fix for a long-standing, hard-to-catch issue in the EDAC
> weird struct allocation code, for 5.17.

Heh. Yeah, that was subtly buggy.

Side note: the comment says that it will align to at least as much as
the compiler would do, but then it does something different, eg

        if (size > sizeof(long))
                align = sizeof(long long);
        ...

and it might make sense to use "__alignof__()" instead of "sizeof()"
just to make the code match the comment.

For example, on 32-bit x86, "sizeof(long long)" is 8, but
"__alignof__(long long)" is only 4.

And then we have m68k..

Or maybe the comment should be fixed instead, and talk about "natural
alignment" rather than "compiler alignment".

             Linus
