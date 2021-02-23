Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFE4322826
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBWJx7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 04:53:59 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33519 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBWJvd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 04:51:33 -0500
Received: by mail-ot1-f51.google.com with SMTP id c16so14999377otp.0;
        Tue, 23 Feb 2021 01:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkJl15U+2Mk0ZQUoUk6PEnWKifrGtnCFFXE6R5dUFh0=;
        b=qyMAevV2MqbdqsjxRe+NBZ0XpIR0v3km1RbN1KkTu4xzAtl2h9zR3pjRr5uCaGdiIc
         N7yYRdfbx8rVn3AJe1vQooq0mAh8O17hcoYzDG0u+uR7bH5JwTIkvKkZsC3qqIval27o
         Dr2uGg1cRzg3fmxL3H7+X+KjPD4nJt57144LtD9a/y36R07nDgjyanNMWslp+4YM39o8
         NYtKfQproAHNww36ig/QveBi9f+DxHA5gHLMz/aC7WTLFeoc1wcCXZtDkwFgkXZnZRlQ
         khy387vLmIPl+48T/BbI3KqrXzDTulYHNgJauXEIR/6CXku0Ckw5f3dEHUIBx2R8TLlG
         ShzA==
X-Gm-Message-State: AOAM530L9f3C+ceVj3/n4iA3nEs0o28py4jzZSNUjbd2FXN6C3jf8Ogj
        yxIJolTwQx2uv7ECvWBi9hEXpoeuqpp16b6ar0rS0sSE
X-Google-Smtp-Source: ABdhPJwNrkfw8bbvZFNVFFIr78KJa/f7hmHkcCunpE71+KFJwY2ZtQJdzC+FjkIxoZx6Vw9QoE/Ys3WH7zqHsYWB6XI=
X-Received: by 2002:a9d:4a8e:: with SMTP id i14mr20288040otf.37.1614073852621;
 Tue, 23 Feb 2021 01:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-6-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-6-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Tue, 23 Feb 2021 10:50:41 +0100
Message-ID: <CAAdtpL5yU0-0hR76zV5hDHWd7NOxa1E0g5=eteHvman1f7cWhQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] MIPS: SGI-IP27: fix spelling in Copyright
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
> This is a Copyright line, and just a typo slipped through.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/sgi-ip27/ip27-timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 79c434fece52..444b5e0e935f 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copytight (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
> - * Copytight (C) 1999, 2000 Silicon Graphics, Inc.
> + * Copyright (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)

If the email isn't valid anymore, why keep it?

> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
>   */
>  #include <linux/bcd.h>
>  #include <linux/clockchips.h>
> --
> 2.17.1
>
