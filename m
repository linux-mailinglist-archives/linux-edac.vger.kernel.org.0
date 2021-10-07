Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF794250EC
	for <lists+linux-edac@lfdr.de>; Thu,  7 Oct 2021 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhJGKX2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Oct 2021 06:23:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240829AbhJGKXY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Oct 2021 06:23:24 -0400
Received: from zn.tnic (p200300ec2f0cc9001cdbae1e4e88a0d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c900:1cdb:ae1e:4e88:a0d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A56CE1EC04D1;
        Thu,  7 Oct 2021 12:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633602089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BVA4OluJCfZda/o6DNWoZhgwKmQ5lAHnyakc4WiZyT8=;
        b=SGsrZ13OHFC7SijYiwFo242yibFrt9Z2Ia4doV5Wgb9E/WEr34SGwTH3YfPDJfhWXxyBrN
        DO//LrKLzG3JjxkXznm1ftkNwCLq8PQY1c+Q3TGxa6dobeFua6aB8r2zods6Z/vVFbWsM/
        ikGXCXGOdVvn2W4gC75n9HXn+100BvA=
Date:   Thu, 7 Oct 2021 12:21:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric Badger <ebadger@purestorage.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Message-ID: <YV7KJAZFLG8JspVv@zn.tnic>
References: <20211003181653.GA685515@ebadger-ThinkPad-T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211003181653.GA685515@ebadger-ThinkPad-T590>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Oct 03, 2021 at 11:16:53AM -0700, Eric Badger wrote:
> This is cosmetically nicer for counts > INT32_MAX, and aligns the
> MC-scope format with that of the lower layer sysfs counter files.
> 
> Signed-off-by: Eric Badger <ebadger@purestorage.com>
> ---
>  drivers/edac/edac_mc_sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
