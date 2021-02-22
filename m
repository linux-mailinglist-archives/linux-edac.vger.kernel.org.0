Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43A321E9F
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 18:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhBVR5R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhBVR5Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 12:57:16 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F6CC061786;
        Mon, 22 Feb 2021 09:56:35 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q7so14229993iob.0;
        Mon, 22 Feb 2021 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANOaJ+Dv36acdHUTyk+J+U0eqbyeMKrUZXEtS6SU5zg=;
        b=jh1bDuacVmABTLCM/yav8HOoP+zIh3JBPS5icgc0CmJWIGJT/9LpgnIIQhOBvM7TbI
         N9MBi9aoLkToiNFLaIFl0VGyy0cPlVKqUk52yNw/DcqnZBac4gwt94RYGKNwL2ObQPg/
         mE90zNYZd0vB8yCzomEQfAikk+JIwg/PZTNKH3iJUxa+RAG/tNW3z1uPG8geFs+4wn/d
         QaJNRdAAOwQtBOds/r+0lsYkhRy0ORHhPj2zbEJJOM56rxkgterH9tGxs72z93laSEbk
         VO/h5FXkFsQOh43sPq0EKPRND+5FgGovxUDtZvW+bzJGR2wju5asuz2tmZWokD8PHwVs
         ffeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANOaJ+Dv36acdHUTyk+J+U0eqbyeMKrUZXEtS6SU5zg=;
        b=beerLe+LgwdYMtbtVW77IuPT6OizRvFUDPsm8gfLJaNIFg4muJ0In2XzPJF3xJ9XEZ
         T2LNrQtDaKdJzpqjVUfAgCcQ3XCgmSPyHEoXeXkwvb6d++aN5ioE8qsUXSAFY9dHtRGJ
         j3vD6fNClNVggDPWAT3f+qbjoilblBIL+0IQORid/ufB1/U0HwIIYsATY8lRDHKkYiKR
         +KtsmE8XPVhTLelKbpwPo9X+vNl61C9JveX77azhhCOjkCvnuXWynEzWLt4I5up7kbVM
         X0fbh81elD+KTVmiygw8D3LO2Al8G19D2y5/WCe3Xi1neC1Vtl5Wanf86NaoEppEskk8
         FQHQ==
X-Gm-Message-State: AOAM533WHTXeUCAG0g68o9lrLuOR97m/oPwVkyTzv39+iCi3BMOJ8NzP
        H/i3ZUWbiXSFJRjnjTgUR01eyc3wg+W/e5D4X8iNK7mSaAE=
X-Google-Smtp-Source: ABdhPJxYBlZZUWJRd+aGk5or3+eMKWUmCRxlp0Mil2mJnedvFOedbAuNtC58ZXCC2Ou2/5yOlQ8mouRniGtAiGcRy+w=
X-Received: by 2002:a05:6638:22e:: with SMTP id f14mr10121385jaq.96.1614016595340;
 Mon, 22 Feb 2021 09:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <alpine.DEB.2.21.2102221836030.1900@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2102221836030.1900@angie.orcam.me.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 22 Feb 2021 18:56:24 +0100
Message-ID: <CAKXUXMwOpu3Ty4qMWaAjiAWSpdxrwKyJEt8D9wbzJb13-Z3xEg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Remove dead linux-mips.org references
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Willy Tarreau <w@1wt.eu>, linux-edac@vger.kernel.org,
        linux-hams@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 6:47 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Mon, 22 Feb 2021, Lukas Bulwahn wrote:
>
> > The domain lookup for linux-mips.org fails for quite some time now.
> > Hence, webpages, the patchwork instance and Ralf Baechle's email there is
> > not reachable anymore.
>
>  I have been contacted by Ralf a couple of weeks ago and he told me there
> had been a storage failure with the machine running linux-mips.org.
>
>  Due to a complex situation with linux-mips.org I do not want to dive the
> details of into here recovery of the site caused some trouble, however I
> was told it had been under way now.  So I suggest that we wait a couple of
> weeks yet and see how it goes before going ahead with this series.
>
>  As to Ralf personal commitments WRT maintenance duties I can't speak, but
> I have bcc-ed him on his alternative e-mail address with this message in
> case he wants to speak up.
>

Thanks for the update. Maybe we can then rescue some of the valuable
content from linux-mips.org and mirror it somewhere else as well?

The code mentioned some patch by referring to a linux-mips.org
patchwork id, but without the service running, there is no chance to
understand the comment. So, once linux-mips.org is up and running
again, we might want to recover that referred patch and change the
comment to a lore.kernel.org Link (that may stay with us for longer)
or quickly find out if that comment is obsolete by now.

Lukas
