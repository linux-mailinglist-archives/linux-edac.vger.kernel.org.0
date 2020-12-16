Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BCD2DC501
	for <lists+linux-edac@lfdr.de>; Wed, 16 Dec 2020 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgLPRGT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Dec 2020 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLPRGT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Dec 2020 12:06:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1ADC061794
        for <linux-edac@vger.kernel.org>; Wed, 16 Dec 2020 09:05:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o17so47232635lfg.4
        for <linux-edac@vger.kernel.org>; Wed, 16 Dec 2020 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6fZrgiDJvZ1zhLy6Dd6vmNP9PRBh+c6sMUBeTapJMI=;
        b=ktS20647x+BwYDsRiSHt/w4Fv8NpuPYj1md4mA4pXcProuCayrEuK8PzRvcJwXZREp
         XwiixXDG4OuLxP58m7lSaCqt0+T5rjGiRZ7OqdQCfifqVyDIPoA6ItyF09xnE4o2q5Wa
         828D8l/W0cXuqe6u0IQuyedCysDVo8ORaP9n3bh23Bn65fj7ftSpq9lfJ94TcRbS43SB
         P1dmP1fTrvP0K/Sty3XLNJkwvnlb5l/+J0oMtAgq5lMJkstQK7ahRzewkQzCAMNo8/Yq
         Iz4EpNj/H2AH1294a8TkrORCm+UyldpwDEA+L5nH8r1I6OZr0Sdi+tVYqqN6GTU8MMze
         rmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6fZrgiDJvZ1zhLy6Dd6vmNP9PRBh+c6sMUBeTapJMI=;
        b=LE8EwDtxRG4NvLU5D1Mpq+CybHp3Ax7t67ii2nJI/l31kiFic24JPZkzk4swqlz7a5
         GFuyBmCBIcmoOkmrwdewjC0X7yhhQmY+l7DZZxaZZPRDRMWxrimYDb5rOR8RGw36aB+9
         BGRads5D1aLFLvzjIA4qUOxvA5mKskgKftuq5lqijoyqjWWw2tt1CS2DEbnlEGKDBKLx
         pQVvMa/BmshzWjNPwR9JXf5ACCKGjtqTjXXPB9REhArNApBdIgbgb45k43Nw7s5SjZSG
         LpQ/s0iQ+tRCJ8Q4ZSSiypgM+K94camqs+IHjNGeSypDuym3Ix0+nN0WPnH4CKJA5dxR
         ltnw==
X-Gm-Message-State: AOAM533jPzuPFML9NnHT6gLDoE0HpJYPPYLQdkfnplQPt3pPs1DN9LoP
        STskColEnfu0UMv888CGhMaQ1ejZtu7HiR3xEJ9s5Whc
X-Google-Smtp-Source: ABdhPJxyf9bL3zQSivR0meeOkFaC7Kh318SV7gxdKSnnmdw+rsoNUA4s6sb7UxFgwzarI8kAVwLTvd1DxKzY4A3Hv+8=
X-Received: by 2002:a2e:9296:: with SMTP id d22mr5721607ljh.197.1608138336512;
 Wed, 16 Dec 2020 09:05:36 -0800 (PST)
MIME-Version: 1.0
References: <CABOsP2O+42Kcf7F5mkzkSizTKGSG48giwkgiv3gN=KZZ+Ad+4g@mail.gmail.com>
 <20201216163427.GA6312@zn.tnic>
In-Reply-To: <20201216163427.GA6312@zn.tnic>
From:   Michael Di Domenico <mdidomenico4@gmail.com>
Date:   Wed, 16 Dec 2020 12:05:25 -0500
Message-ID: <CABOsP2POd8UhS5Acfg9Ht8NSpULBFbDX+_iK6BGm3ZNGLdRsaw@mail.gmail.com>
Subject: Re: dimm mapping
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

the problem i'm trying to solve is that when i run edac-util -v i
don't get the dimm labels.  so when MCE trips it's chore to figure out
which dimm it actually is when looking at the motherboard.  given that
dmidecode seems to report the dimm labels, it seems odd that edac
doesn't use them.  but then again i understand how all that's tied
together (if at all).



On Wed, Dec 16, 2020 at 11:34 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Dec 16, 2020 at 10:06:21AM -0500, Michael Di Domenico wrote:
> > is there some tool that merges the 'dmidecode -t memory' output with
> > 'edac-util -v' to give me the mapping of my motherboard for the
> > labels.db file?
> >
> > the only documentation i've been able to find on the net, says to
> > populate one dimm at a time and write down the mapping, which seems
> > horribly dated for 2020
>
> There's a whole subsystem - EDAC - trying to do that mapping between
> silkscreen labels on the motherboard and actual DIMMs and there are
> cases where that is simply impossible. Unfortunately.
>
> What is the problem you're trying to solve?
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
