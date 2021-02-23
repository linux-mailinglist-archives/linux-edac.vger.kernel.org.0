Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9932287F
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBWKCH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 05:02:07 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44846 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhBWKAh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 05:00:37 -0500
Received: by mail-ot1-f50.google.com with SMTP id f33so1705705otf.11;
        Tue, 23 Feb 2021 02:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWxe0P8DZYYU1z4RUHaP48wKAlVYUnjj2L7rokBCJ0s=;
        b=APPzSCus5OikqsUSK00T2XdhJlrq1l+YwJEh0gX/U5FYd1VT69nRynQblkvhqcUyIV
         B7r+nmOQxvejMze5uYAEE0R6j/TTIZy5xH6SpSGIXja+azGuW5E69Lnsdg3RQnr9kcb0
         a1P6jZOeHK11liqc2QABDPD8PfwyUV6YSuJKBJqFHnY6sIUlESAW6bYrWoRcuuxpSTui
         cyHpuhDWophwVUPI0ZgMl3Z6xpL4ny0JGicrPtKWc0nY3pg5iYtmyYoCoM60/ctLZf3G
         cEYLL1QED8KQZBgn1XwnsiZNKn3k/4G3LJrMi3/yEuPc1xIMoF3XcoTpWuB79Zk0ZD8q
         Z8pw==
X-Gm-Message-State: AOAM532f2V8MulRa1oLtsrvDcHhZqxui1/oNKSteVFA55r40GhpWKaGN
        y+OQ4uQzbkslsrZvB9YBSfimEI4kPE14hoOqHew=
X-Google-Smtp-Source: ABdhPJxqhTOmb+J2f7WHRsWK1hNdeG2LJuMbyL0sTISsxlaAKuhBEJtQxKAtMf8KWocNXDSnntOz/G4ujTJDxOdUTzA=
X-Received: by 2002:a9d:4a8e:: with SMTP id i14mr20306399otf.37.1614074395126;
 Tue, 23 Feb 2021 01:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-5-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-5-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Tue, 23 Feb 2021 10:59:44 +0100
Message-ID: <CAAdtpL7tj2CvK9w8PNofu1C6Do0gojwWgupJmB_XEYto+EEf3A@mail.gmail.com>
Subject: Re: [PATCH 4/5] arch: mips: remove dead references
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 5:22 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The domain lookup for linux-mips.org fails for quite some time now.
> Further, the two links:
>
>   http://decstation.unix-ag.org/

https://web.archive.org/web/20070609185805/http://decstation.unix-ag.org/

>   http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/
>
> refer to old webpages or contain no further technical information.
>
> Remove all those dead references.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/Kconfig             |  8 +-------
>  arch/mips/jazz/Kconfig        | 12 +++---------
>  tools/include/nolibc/nolibc.h |  3 +--
>  3 files changed, 5 insertions(+), 18 deletions(-)
