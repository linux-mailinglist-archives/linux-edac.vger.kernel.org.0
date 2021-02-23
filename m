Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B019232281B
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBWJwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 23 Feb 2021 04:52:19 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43072 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhBWJuI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 04:50:08 -0500
Received: by mail-oi1-f178.google.com with SMTP id d20so17024067oiw.10;
        Tue, 23 Feb 2021 01:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p88iZzyP29shfj++CGhdBvy6KZNf8uzYSi55mFPxJPU=;
        b=rulPxWFGCQ4+q3rNSjC9RYEeuFju5DYHfT8juXbhF/FOIkUoBWx/AVNk+JALXicD6R
         038NDRi2+y3FIKpp9Ged+IE3FcY+1yhujrkgowasSwCzm1mVN5j6yu9YPTO7WgoZ2IQF
         NLYd433oGVDXbFLBid45Zf+Xp3fgRtQd7v7o7umJxe/4XANgRD8gRZEaOQXNt4OScrtq
         wNeln9xFuW+OldzCxCnVCugQh9lMAkOQ3lW2QY4tBOyFbT6ZzY0yIAyRLDWvYi+CJHuj
         wZGmJEoyQAEY+svF4HtTw6O7+K6TnQLEgSwNWQaq4lftE6/qtlLm8LOXpd9tNd9WT9qF
         LNpw==
X-Gm-Message-State: AOAM533ZhgfDe2la1Uk1nHdKmi2Qzt6gGlDuMAXmu3TqC95d7hVlm5J8
        p58nmOU1TtFp3y8RThbYegJE3TpzDutvILe07shCovytUZE=
X-Google-Smtp-Source: ABdhPJxclUUUfISAO4sB/2rVd7veIxoB918nm647OCokP2t6IMFVoT/a4BLcT2tODwID5sF4yLr9WcQ+6aqHxHHHQ7I=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr18414499oia.46.1614073768196;
 Tue, 23 Feb 2021 01:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-4-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-4-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe@mathieu-daude.net>
Date:   Tue, 23 Feb 2021 10:49:17 +0100
Message-ID: <CAAdtpL4gB_O0j3QZEkUj-Yogj04NqFpLE5drFxPtVfWEZHNJNA@mail.gmail.com>
Subject: Re: [PATCH 3/5] arch: mips: update references to current linux-mips list
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 5:22 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The linux-mips mailing list now lives at kernel.org. Update all references
> in the kernel tree.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/kernel/r4k-bugs64.c | 2 +-
>  arch/mips/lib/iomap-pci.c     | 2 +-
>  arch/mips/sgi-ip32/ip32-irq.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
