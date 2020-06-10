Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDEC1F508A
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFJIsl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 04:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgFJIsk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Jun 2020 04:48:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A5C03E96B;
        Wed, 10 Jun 2020 01:48:40 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x22so982877lfd.4;
        Wed, 10 Jun 2020 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC9z0YQVw/ovp7RcdPcoELOnuCQp6hRBgNQO9wmx/S4=;
        b=pgYRvjiWI9A4AuDA7s2i4gT5VqsCkDiNA5Q+kChiJCsMF9JGQLAV6ZdXISKFy8Y6ZJ
         NOTHCgAE1sIW3aluZnjE+2ms1ZgSQdlixIcx2+fPunWGZCFTZuPd/CQbkcMNBaq0r7VW
         Lz+K+h6q+GyXXyc8OgJIY9GuSXlLbfHc4O/c6JY9HmCEa6vcunouYF8BJognnuFmCMzr
         t3TtpAGHy/c9hghZlSFJ6RuDBfeqeQGU39jzyVHzqYb+YmwG3x/Lz0R2XUN9LlsJPHoJ
         n7zOLDs4k3BF+tP9jIT/pab+/VGu+fjKBIcNckh/VOAw8MPbLUmBGp/4qBDhC8+eghYh
         DFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC9z0YQVw/ovp7RcdPcoELOnuCQp6hRBgNQO9wmx/S4=;
        b=bL8OBvBmbWK/7eos4WxZlmIPL5DPLtkRpqQmSOfjfo9WnGVUV3i6gKnFyTsgUGQ8Sp
         QxAbv5ZFgMWNMo7lxzYIMditj9e+5gLXqxOXcv8k4I1nr6PAve5MJI5rtT04/0UVB0bw
         skMA5s7NomeFdNvWNKqwqV7SBSbNl7MhctmTvXiUPcurDaxwQNMtGgJdqXTBPzPJWDiR
         f0Q4m7fNNrTeNuwlWIO3++qqpMXEnf+vpTcYVJvBd3t1R3u+DpwKhcqYNcoQM6CWJ8Nz
         zuJKquE30OCNzfs0Zfh+2VArfDLtPXiVSd/ewoa7Yp7Wt8IE3Sh4OB401ibAR77hgA9E
         2LzQ==
X-Gm-Message-State: AOAM531yAsSBlJcUZa4i7Dz+Cuo97cEVFoC+ym+t6IAhrClzBE8frXpl
        tg+mbIQgXMaZf179Z47QmjMmq8qrPgnlkd+FfVE=
X-Google-Smtp-Source: ABdhPJxsPu3S/Zw+UKXoVa8bsgKlBQqtFzO4VbdBKA+uqODD6HONKVUcUzPacw2j/I2RQ+GOYTg8BcAd9QNwnEDl+BE=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr1128272lfg.55.1591778918010;
 Wed, 10 Jun 2020 01:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200610065801.3579-1-zhenzhong.duan@gmail.com> <20200610082040.GB14118@zn.tnic>
In-Reply-To: <20200610082040.GB14118@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 10 Jun 2020 16:48:26 +0800
Message-ID: <CAFH1YnNsM0okzpLru9Fd__F9yp-a00+J17L2atLBrnV3vWSqLw@mail.gmail.com>
Subject: Re: [PATCH] EDAC, {skx,i10nm}: Advice mcelog that the error were handled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        mchehab@kernel.org, james.morse@arm.com, rrichter@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 10, 2020 at 4:20 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 10, 2020 at 02:58:01PM +0800, Zhenzhong Duan wrote:
> > If one MCE error has been processed in kernel, it's not necessory
> > to pass it to user level mcelog.
> >
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > ---
> >  drivers/edac/skx_common.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
> > index 46be1a7..8c0165b 100644
> > --- a/drivers/edac/skx_common.c
> > +++ b/drivers/edac/skx_common.c
> > @@ -615,7 +615,8 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
> >
> >       skx_mce_output_error(mci, mce, &res);
> >
> > -     return NOTIFY_DONE;
> > +     /* Advice mcelog that the error were handled */
> > +     return NOTIFY_STOP;
> >  }
> >
> >  void skx_remove(void)
> > --
>
> No, we won't be doing that anymore. See here:
>
> https://git.kernel.org/tip/23ba710a0864108910c7531dc4c73ef65eca5568
>
> it should appear mainline soon-ish, I hope.

I see, thanks for showing.

Zhenzhong
