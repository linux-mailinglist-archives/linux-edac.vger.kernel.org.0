Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C028644F2F8
	for <lists+linux-edac@lfdr.de>; Sat, 13 Nov 2021 12:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhKMMBd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 13 Nov 2021 07:01:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbhKMMBd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 13 Nov 2021 07:01:33 -0500
Received: from zn.tnic (p200300ec2f288700728be1e72e2100a3.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:8700:728b:e1e7:2e21:a3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2D4B1EC0104;
        Sat, 13 Nov 2021 12:58:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636804720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8tJqxRydJGv8XffGvvwZBsIMIKeZ6Mtr5GA+XfzFi0Q=;
        b=JhxfNYCVvOyasa8H+ZJd+9wH52L8+EZbu8eLRE9hva30oD3/0xUItrsDUpNa/Nvwvy58e6
        Lk8Q1mdsgZ6M72dQqojLvUH4Zf3mBjECDoqxqTgEfEV9TxMSddotDRa8nR21BrRHViIhl8
        7Zae6Xj2dMPPL0z6WI5C1eCkKbjdRvk=
Date:   Sat, 13 Nov 2021 12:58:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 3/5] EDAC/amd64: Extend family ops functions
Message-ID: <YY+oaEIZ4nu6gK+v@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-4-nchatrad@amd.com>
 <YYwFUYDl8wvO02wL@zn.tnic>
 <0006a641-44e7-5cf0-04e2-8c4499765b77@amd.com>
 <YY7VqRcZFhyqZw1B@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YY7VqRcZFhyqZw1B@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 12, 2021 at 08:59:21PM +0000, Yazen Ghannam wrote:
> I've seen the same warning in some of my patches, but I've ignored it for
> readability. I'll need to make changes there too. :/

If readability is of concern, you can fixup the issues you see in a
pre-patch - I mean, you're touching the code so might as well fix them
while at it.

What I really don't want to have is patches which simply fix random
checkpatch issues and other whitespace crap because that becomes an
insane mess with new people not really concentrating on fixing actual
bugs but doing whitespace wankery only.

And having such patches always gets in the way when one does git
archeology to figure out why something was done the way it is.

But it's fine to fix those if you're going to touch the code anyway.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
