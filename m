Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D5637BA3C
	for <lists+linux-edac@lfdr.de>; Wed, 12 May 2021 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELKYD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 May 2021 06:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhELKYD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 May 2021 06:24:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBB5D613D3;
        Wed, 12 May 2021 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620814975;
        bh=BiN1Wt4lO1o8C8atDFgSmUkdVu6v1nA2gtRzbZc/WVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QHT5knb6TINFIR49fr7XXJigUq1BPBjSqq9uhfOrRUt3czdQ2JU84Y6LBApfOzGT0
         846/jRuQKng7GV/CL+zujyqrNX5nQGL+WVqrPK2f1U27QPWuuDinycf5QhSkm/RIHq
         24jnX0v/3ZNpRQDIQgBbDE/aDOWWJ8jtEy0lVIJi5PnwN8IPHifE1yMcg4ONTeQju1
         LGudnFVdFcP8C1dYLqmfe2Hij+69s9/LkLdogPY6qwwQHoA/WYKkURNgQ3D2hWFLMO
         IrhyL9jI5c7OdjRzo0zUCE8pQ3FHZHNr9D9Vf5udhBNFH60v71xWPqH8gc6fX9Um4B
         p67TM9+RBrI0g==
Date:   Wed, 12 May 2021 12:22:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tony Luck <tony.luck@intel.com>, keyrings@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/53] docs: admin-guide: avoid using UTF-8 chars
Message-ID: <20210512122247.5c00c4e4@coco.lan>
In-Reply-To: <2b6e33a190803df207b59e8896777fe0f31c2044.camel@infradead.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
        <4b372b47487992fa0b4036b4bfbb6c879f497786.1620641727.git.mchehab+huawei@kernel.org>
        <878s4m301i.fsf@collabora.com>
        <20210512104416.265a477b@coco.lan>
        <2b6e33a190803df207b59e8896777fe0f31c2044.camel@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 12 May 2021 10:25:35 +0100
David Woodhouse <dwmw2@infradead.org> escreveu:

> On Wed, 2021-05-12 at 10:44 +0200, Mauro Carvalho Chehab wrote:
> > The main point here is that a large amount of those UTF-8 characters
> > appeared as result of document conversion from DocBook/LaTeX/Markdown.
> >=20
> > As the conversion ended, I don't expect the need of re-doing a series
> > like that in the near future.
> >=20
> > There are even some cases where the UTF-8 were doing wrong things, like
> > using an EN DASH instead of an hyphen in order to pass a command line
> > parameter, and the addition of non-printable BOM characters.
> >=20
> > So, IMO, this is a necessarily cleanup after the conversion. =20
>=20
> That part =E2=80=94 fixing characters that are *wrong*, such as convertin=
g a
> UTF-8 U+2014 EM DASH to a UTF-8 U+002D HYPHEN-MINUS, is reasonable
> enough.
>=20
> But you're not "avoiding using UTF-8 chars" there, as it says in the
> title of this patch. HYPHEN-MINUS encoded as 0x2D *is* UTF-8.

Yeah, you're right, as ASCII is a subset of UTF-8 - as ASCII is
also subset of other charsets as well[1].

[1] ASCII is a subset for all charsets mentioned at:
       https://man7.org/linux/man-pages/man7/charsets.7.html

A more precise title would be something like:

	Use ASCII instead of non-ASCII UTF-8 alternate symbols
or
	Use ASCII subset instead of UTF-8 alternate symbols

See, the goal of this series is to address the cases where there are
multiple UTF-8 alternate symbols with the same meaning as the
original ASCII set. Most of them were introduced by tools like
DocBook/LaTeX/pandoc during document conversions[2], not by design,
but just because the UTF-8 non-ASCII symbols produce a nicer output=20
in html or pdf. In another words, it was a toolset decision to change
them, diverging from what the author originally typed.

[2] I suspect that a few of them could have been introduced as a result
    of someone using a text editor like libreoffice (or equivalent),
    that has a similar behavior.=20

With ReST, there's no need to use any those, as the building tools will
already do the such conversion when generating html/pdf output.

So, better to stick with ASCII subset on such cases, as it allows
to better use tools like grep and it makes easier to edit such files
on editors like vi, nano, emacs, etc.

Thanks,
Mauro
