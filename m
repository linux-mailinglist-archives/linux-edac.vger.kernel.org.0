Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5528343AF1
	for <lists+linux-edac@lfdr.de>; Mon, 22 Mar 2021 08:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCVHxb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Mar 2021 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCVHw7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Mar 2021 03:52:59 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57BEC061756;
        Mon, 22 Mar 2021 00:52:58 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x16so12917853iob.1;
        Mon, 22 Mar 2021 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mfyVLjNNTM8+/QZpvr999C+UF8zqwK2EPElm0pDtBJ0=;
        b=CcqdTMUTKrb4AvlfL5F86RnWHr7dikqWnsnt++WGOTFFhLvFhWyLQXi1TDqd94AvNz
         UF7UCcrBER1FSVE1xS8/NOGI5weafoyQC8enHc/FHbMClsW4MkIffccmGqJ69jjdsFp4
         p1C/EoUXyfwsjdSgv7H0MIkL7PDD7IXzlrBuyv9O2GpJp6S3w7gF0AVbOs8Oy2ovXHX7
         dUQSsa5Eh8dhF1e7tPAYaiwRSuO5gU/3VyNiVLLI10YKE7xDHLH8BcBVTF6RdmggqIuy
         rl/0YYpQDxDntpFdw2yIgmVbH/nwo7naYbZNhbhALjtfmCrJ205ipLEP10ZnidarFlKl
         u8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mfyVLjNNTM8+/QZpvr999C+UF8zqwK2EPElm0pDtBJ0=;
        b=Gp4pguA/x0GnPB6L2UviB2n+icZO0t6K0+FnbVsqAf+LpWuZ0UnWVra8ffKDKn+QHX
         YsBv7hKg8vaHIeiEsXnHgGnkcY6rXYc9aFy8HoYDKeRl6GErctE3ulsmQyL7MFasRhiy
         +tTlGgI6F+SVUq+iNh+r0jEoMIP7kMvh96fMuAjOTOSm3+zTvd3CjsFMARwkLUxKai0/
         SGFDfNcb9f1hlDw9IlwjT6wDQYIRAwMxFvF/yOOYM1zaandyzHuf+z7eqtN5uAco2c9h
         c2zyXvIRuC/Fw37dIkxKtOj/Y1blh8R2Ae2cpMijMEDGyzcWZAgTbH3mZPgWjjktvVkm
         /MMQ==
X-Gm-Message-State: AOAM530QxQFsjeaUJ9Bt2kJ/P+v9nQT4ojLnTc+rDG6JrztgylxX+d0K
        u4Ov99Ru+e9ccA8HKtDCzo2V2g8KcmubRPqLwaUsM+z5
X-Google-Smtp-Source: ABdhPJwFfT/k4yUVHgU6P7QHyKrSqrki69jZ0SZYDWK0aq9VANjury8vtw1oS/s7/aM1vvH4KmdL4y1cmdz4CKD6Q5M=
X-Received: by 2002:a5e:8d05:: with SMTP id m5mr9777547ioj.114.1616399578170;
 Mon, 22 Mar 2021 00:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
 <alpine.DEB.2.21.2102221836030.1900@angie.orcam.me.uk> <BY5PR22MB1841658D64FB8D8B619BC870C7819@BY5PR22MB1841.namprd22.prod.outlook.com>
In-Reply-To: <BY5PR22MB1841658D64FB8D8B619BC870C7819@BY5PR22MB1841.namprd22.prod.outlook.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 22 Mar 2021 08:52:47 +0100
Message-ID: <CAKXUXMxOXCZyG3cw0NrNYfWjoTPuBahbT-sZo1N90PDvSJakZQ@mail.gmail.com>
Subject: Re: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org references
To:     Kurt Martin <kmartin@wavecomp.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 7:19 PM Kurt Martin <kmartin@wavecomp.com> wrote:
>
> Hi Everybody,
>
> This is Kurt Martin.  I'm part of the MIPS Customer Engineering team at W=
ave Computing.  Some of you may remember me.  I have just established conta=
ct with Ralf, and I will be working with him to restore linux-mips.org back=
 to life.  I just got the account and login information for the linux-mips.=
org hosting account at Hetzner from Chris Dearman.
>
> So as Maciej says, please hold off any actions at this time, and I will a=
ttempt to get linux-mips.org working again as quickly as possible.  Thanks!
>

It has been a month by now... I just wanted to check if linux-mips.org
is back on its way to be available. Or should Thomas pick up the
remaining patches of this series?

Lukas
