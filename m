Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53083203A57
	for <lists+linux-edac@lfdr.de>; Mon, 22 Jun 2020 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgFVPJh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Jun 2020 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgFVPJh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Jun 2020 11:09:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E05C061573;
        Mon, 22 Jun 2020 08:09:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97BBC1EC02A1;
        Mon, 22 Jun 2020 17:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592838575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/M8cQv69sjHDtBYpaW+nVdAgbwtsE9FBDVAX2kPdWEI=;
        b=FSQ6dgLQPxm5Co76t4M2Keyyah3lHAhmdGnQh1hD0H6uEUMEFn6Np6+844Mb9aAevYtZm1
        2HpfEWeKTxaVZieQOUVPdn+kii0fFISDWWB4cR02BHQ0JmypnAXmXK1dVoHcQV1/GhdYgT
        PrL0FMe9gMD4cV5df7tjsYTj/qnpzXg=
Date:   Mon, 22 Jun 2020 17:09:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] EDAC/ghes: Some cleanups
Message-ID: <20200622150925.GC32200@zn.tnic>
References: <20200616172737.30171-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616172737.30171-1-bp@alien8.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 16, 2020 at 07:27:33PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi,
> 
> here are some cleanups which came up recently.
> 
> Thx.
> 
> Borislav Petkov (2):
>   EDAC/ghes: Scan the system once on driver init
>   EDAC: Remove edac_get_dimm_by_index()
> 
> Robert Richter (2):
>   EDAC/ghes: Setup DIMM label from DMI and use it in error reports
>   EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to
>     ghes_pvt
> 
>  drivers/edac/ghes_edac.c | 323 +++++++++++++++++++++++----------------
>  include/linux/edac.h     |  29 +---
>  2 files changed, 200 insertions(+), 152 deletions(-)

Queued for 5.9.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
