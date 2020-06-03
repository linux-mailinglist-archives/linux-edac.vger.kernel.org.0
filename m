Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE21ED082
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jun 2020 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCNHs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Jun 2020 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCNHr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 Jun 2020 09:07:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51879C08C5C0
        for <linux-edac@vger.kernel.org>; Wed,  3 Jun 2020 06:07:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p5so2380398ile.6
        for <linux-edac@vger.kernel.org>; Wed, 03 Jun 2020 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gYyrJLaQ+cFgqqyyybhWb1AjC7iwBmUDVD65TKxqbuc=;
        b=PK4ZSsxY4oWONUmz6CvLNRX1Oo57xNQliufUxZenjtMzPVgmNxUMN1cB4FrrIKTK+Y
         kby2IlhlC+PnFBNgtEjq0qMCFR8RrvGYpw1Jxp3owP22uLiTrY2BdI7IAy8I5ZUPNUAV
         hoOzAyBa/cBCtoAYvkvL1mM5Her9iAwoMnfmMQ3ipF02lY+CVDJT2PMk3ZcYJbStlq8b
         n4k7nvSZPk2Qq4n67EVvePp+5R0OamzqHFcOOV078P23woUTn9Fir48useEA3HFtuDfc
         /W8ouGBp9NX6K43iUkXGw4pBad0rJ05C4y/vAnT00+MfTrUhYsZcZgfE53MhMFYwhvCR
         sj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gYyrJLaQ+cFgqqyyybhWb1AjC7iwBmUDVD65TKxqbuc=;
        b=oc20H2CVST3wPRLiO17SDcb4F/A3Ax/8+qWvwYQvt5vzFIof4m3R+mG5uS9VeZkgvO
         4Qi5fC5im685Nv492ewHvNEZC1EvxaCCpp+7fyVJJMMBSdAR2x2qAubGi6UZzaSxQagk
         7MRvsge47g+dL0jMcg6fY9MsZQQU1tey8n9z/y0jm5TXiBWLK0FDRlbmKdPtCkqJIhCQ
         wbilftIN3tqJv0XFc/t0ilQ3jW5ORWN0VO4WJ6MuG4jMeVd+APoRdPn4gAV+HTt6ZSk/
         HKAtMzSJFVhezc1ng980xM4v4tE1+w8EOTzQFyUF6kIpJcWmu4ZeQompWdsmCpvLbekX
         RjTg==
X-Gm-Message-State: AOAM530p2c8pe84v6IkYi8r+LMTDhw+c5iRK+OObT7P8Wcf9IG5JGYhR
        SoyP+lbzPVy35M5ngHCK0CD0E/iGDnWUYrcN0E8=
X-Google-Smtp-Source: ABdhPJx1RYysk1xIfkWkTh5RNz1fJydJOcO2OalECwxc+s36X7o/lVZ45kaSuIySzsqGammoiNWxKZ2TI1ib05hRmw8=
X-Received: by 2002:a92:730b:: with SMTP id o11mr3530215ilc.153.1591189666511;
 Wed, 03 Jun 2020 06:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200516162115.16545-1-wata2ki@gmail.com> <20200603112816.GC19711@zn.tnic>
In-Reply-To: <20200603112816.GC19711@zn.tnic>
From:   Naoto YAMAGUCHI <wata2ki@gmail.com>
Date:   Wed, 3 Jun 2020 22:07:36 +0900
Message-ID: <CABBJnRaLTT_B_-mdfQum0dcaNvvEadQMucT94wp+7t12GjTx9A@mail.gmail.com>
Subject: Re: [PATCH] EDAC/mc: Fix memory alignment calculation formula
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org,
        Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi

Out of tree driver (edac_injection) is under developing now by
Gabriele Paoloni.  This driver will upstream future.

When I was porting this driver to aarch64 environment, I found this bug.

This bug is also common bug for other edac me drivers.  My opinion,
this bug should be fixed instead of waiting for the driver to be
developed.
Because alignment miss may only cause performance degradation in case
of Intel, but it cause CPU exceptions (Oops/kernel panic) in case of
aarch64 and other risc like architecture.

This bug was supposed to be fixed in commit(a).
But this fix conflict with the commit(b) fix and consequently the bug
was not fixed.

commit(a): https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git=
/commit/drivers/edac/edac_mc.c?h=3Dlinux-3.7.y&id=3D8447c4d15e357a458c9051d=
dc84aa6c8b9c27000
commit(b): https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git=
/commit/drivers/edac/edac_mc.c?h=3Dlinux-3.7.y&id=3D93e4fe64ece4eccf0ff4ac6=
9bceb389290b8ab7c

Thanks

2020=E5=B9=B46=E6=9C=883=E6=97=A5(=E6=B0=B4) 20:28 Borislav Petkov <bp@alie=
n8.de>:
>
> On Sun, May 17, 2020 at 01:21:15AM +0900, wata2ki wrote:
> > From: Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
> >
> > During the development of the off-tree driver,
>
> Wait, what?
>
> Am I reading this correctly that you have an out-of-tree EDAC driver?
>
> If so, why? Why not submit it upstream?
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
