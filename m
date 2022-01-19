Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1C49376C
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jan 2022 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiASJiD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jan 2022 04:38:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43834 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235918AbiASJiC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 19 Jan 2022 04:38:02 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AA4B1EC01B5;
        Wed, 19 Jan 2022 10:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642585077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l8hXfzc4tNzXvNMHh+krnIwebhMr+nIyn6zzRElK4Jk=;
        b=rAi6ielVyHsK6XXnVr54FincTmQbgFoG11uhjSI3ckEsiBZQnMzPsoJUE5+RKaCRdEaS2/
        Qt1HwuI7liqPV+CGLh5ADMgLrhqhU3QjdjShMvpagkZRWq3DL9KN1d5C1CO6+RswfWPGnF
        iWmhd37EXF6me00EQ1t+8DwFfNdqxDk=
Date:   Wed, 19 Jan 2022 10:37:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <Yefb7zO9p1iPF3Jm@zn.tnic>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
 <YefXQHXNlsxk8yUc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YefXQHXNlsxk8yUc@kroah.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 19, 2022 at 10:17:52AM +0100, Greg Kroah-Hartman wrote:
> For this specific change, I do NOT think it should be backported at all,
> mostly for the reason that people are still arguing over the whole
> platform_get_*_optional() mess that we currently have.  Let's not go and
> backport anything right now to stable trees until we have all of that
> sorted out, as it looks like it all might be changing again.  See:
> 	https://lore.kernel.org/r/20220110195449.12448-1-s.shtylyov@omp.ru
> for all of the gory details and the 300+ emails written on the topic so
> far.

It sounds to me I should not even take this patch upstream yet,
considering that's still ongoing...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
