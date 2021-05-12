Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD037B83D
	for <lists+linux-edac@lfdr.de>; Wed, 12 May 2021 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhELIpd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 May 2021 04:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhELIpd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 May 2021 04:45:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00852613C9;
        Wed, 12 May 2021 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620809065;
        bh=wtyfChv9H4tAXRucGeEUaqkwZzsSy8E4mSqAZXz/tBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TgBnKgiDkB7a0KA5HG/fO+8pykepeityp9fMt8RfDQZTB0RJnZS0+e3QAjJ+T63+g
         s170WY4+9Lp6RzAooO1vbnj1dmhE3UzlvKt8tN3+B0+VguYc5J6HUa48PnKiBIlF7Z
         mJLnnweiP/UaqE1YGElsRU1zhxPsce/c/i+GkakvTcCMIHN78vptzxl/5D64kD514Y
         7wd6oLntL4cpLkwcfL+AlogaxBps6nXp0hw8yrGVyum0ePAPZ8VCHpq2DGiqyACEG3
         FxiiBCI7ybdQ+QQMoSpEKGU6AY65OmsCAvlCa1jEjA7VYNZEjSD9C4nUNZOll2vmKe
         RhNnIcQDyPjRA==
Date:   Wed, 12 May 2021 10:44:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        "Jonathan Corbet" <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tony Luck <tony.luck@intel.com>, keyrings@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/53] docs: admin-guide: avoid using UTF-8 chars
Message-ID: <20210512104416.265a477b@coco.lan>
In-Reply-To: <878s4m301i.fsf@collabora.com>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
        <4b372b47487992fa0b4036b4bfbb6c879f497786.1620641727.git.mchehab+huawei@kernel.org>
        <878s4m301i.fsf@collabora.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Mon, 10 May 2021 14:40:09 -0400
Gabriel Krisman Bertazi <krisman@collabora.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > While UTF-8 characters can be used at the Linux documentation,
> > the best is to use them only when ASCII doesn't offer a good replacemen=
t.
> > So, replace the occurences of the following UTF-8 characters:
> >
> > 	- U+00a0 ('=C2=A0'): NO-BREAK SPACE
> > 	- U+2013 ('=E2=80=93'): EN DASH
> > 	- U+2014 ('=E2=80=94'): EM DASH
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/admin-guide/index.rst           |  2 +-
> >  Documentation/admin-guide/module-signing.rst  |  4 +-
> >  Documentation/admin-guide/ras.rst             | 94 +++++++++----------
> >  .../admin-guide/reporting-issues.rst          | 12 +--
> >  4 files changed, 56 insertions(+), 56 deletions(-) =20
>=20
> Hi Mauro,
>=20
> This patch misses one occurrence of U+2014 in
> Documentation/admin-guide/sysctl/kernel.rst:1288.

It ended to be on a separate patch.

> There are also countless occurrences in Documentation/, outside of
> Documentation/admin-guide.  I suppose another patch in the series, which
> I didn't receive, will fix them?

Yes. This series should fix all occurrences inside Documentation/ on
*.rst files and on ABI, except for Documentation/translations[1].

[1] Still it probably makes sense to do a subset of the changes
from this series there, but touching non-Latin translations are riskier.

> These characters will just reappear elsewhere, eventually. I'm not sure
> what is the gain here, other than minor consistence improvements.

The main point here is that a large amount of those UTF-8 characters
appeared as result of document conversion from DocBook/LaTeX/Markdown.

As the conversion ended, I don't expect the need of re-doing a series
like that in the near future.

There are even some cases where the UTF-8 were doing wrong things, like
using an EN DASH instead of an hyphen in order to pass a command line
parameter, and the addition of non-printable BOM characters.

So, IMO, this is a necessarily cleanup after the conversion.

> But we
> should add a Warning during documentation generation (if there isn't one
> already), to prevent them from spreading again.

Not sure if it is worth... See: people can (and should) use UTF-8
characters when needed, like for instance using Latin accented=20
characters on names and translations, and use Greek letters when
pertinent, like using MICRO SIGN or GREEK SMALL LETTER MU to
represent microsseconds.

On the other hand, using curly commas instead of ASCII ones and
dashes instead of -- and --- only makes harder for people to type
documents with normal editors without any gain, as Sphinx already
convert those into curly commas and EN/EM DASH when it generates=20
html/pdf docs.


Thanks,
Mauro
