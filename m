Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9316546F23
	for <lists+linux-edac@lfdr.de>; Sat, 15 Jun 2019 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfFOJA2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Jun 2019 05:00:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfFOJA2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 15 Jun 2019 05:00:28 -0400
Received: from zn.tnic (p200300EC2F226700DD2F30DD753C39F6.dip0.t-ipconnect.de [IPv6:2003:ec:2f22:6700:dd2f:30dd:753c:39f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5696D1EC0947;
        Sat, 15 Jun 2019 11:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560589227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vlJBnzp21+NM4RW6JyCG8YKOog4tNPiJgDgxVqOYH6g=;
        b=gqRysxrJK/hgn9ID3Na39QuM6Vba+TceEaEyS4YJ1tDpE+nBzSFmJHeD9XsGS/11wByWMu
        Lq7ejTf3vlkpwZ3+ktZwTcxEpV0a2SANYXfYKQfqcV/Hy8xJCYeTGMxd/9I1vydugj2k7E
        2t/DKoGGTYwuxtGIKY78Ltd4Ko2mXkg=
Date:   Sat, 15 Jun 2019 11:00:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] edac: make edac_debugfs_create_x*() return void
Message-ID: <20190615090019.GA19758@zn.tnic>
References: <20190611175433.GA5108@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611175433.GA5108@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 11, 2019 at 07:54:33PM +0200, Greg Kroah-Hartman wrote:
> The return values of edac_debugfs_create_x16() and
> edac_debugfs_create_x8() are never checked (as they don't need to be),
> so no need to have them return anything, just make the functions return
> void instead.
> 
> This is done with the goal of being able to change the debugfs_create_x*
> functions to also not return a value.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: <linux-edac@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/edac/debugfs.c     | 12 ++++++------
>  drivers/edac/edac_module.h | 18 ++++++++----------
>  2 files changed, 14 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
