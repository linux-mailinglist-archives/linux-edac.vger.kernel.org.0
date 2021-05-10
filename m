Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001A9379720
	for <lists+linux-edac@lfdr.de>; Mon, 10 May 2021 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhEJSlT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 10 May 2021 14:41:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60396 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSlT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 May 2021 14:41:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DC9DC1F41D73
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Organization: Collabora
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
        <4b372b47487992fa0b4036b4bfbb6c879f497786.1620641727.git.mchehab+huawei@kernel.org>
Date:   Mon, 10 May 2021 14:40:09 -0400
In-Reply-To: <4b372b47487992fa0b4036b4bfbb6c879f497786.1620641727.git.mchehab+huawei@kernel.org>
        (Mauro Carvalho Chehab's message of "Mon, 10 May 2021 12:26:18 +0200")
Message-ID: <878s4m301i.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
>
> 	- U+00a0 (' '): NO-BREAK SPACE
> 	- U+2013 ('–'): EN DASH
> 	- U+2014 ('—'): EM DASH
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/index.rst           |  2 +-
>  Documentation/admin-guide/module-signing.rst  |  4 +-
>  Documentation/admin-guide/ras.rst             | 94 +++++++++----------
>  .../admin-guide/reporting-issues.rst          | 12 +--
>  4 files changed, 56 insertions(+), 56 deletions(-)

Hi Mauro,

This patch misses one occurrence of U+2014 in
Documentation/admin-guide/sysctl/kernel.rst:1288.

There are also countless occurrences in Documentation/, outside of
Documentation/admin-guide.  I suppose another patch in the series, which
I didn't receive, will fix them?

These characters will just reappear elsewhere, eventually. I'm not sure
what is the gain here, other than minor consistence improvements. But we
should add a Warning during documentation generation (if there isn't one
already), to prevent them from spreading again.

-- 
Gabriel Krisman Bertazi
