Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D666A280465
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgJAQ6W (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAQ6V (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Oct 2020 12:58:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E6C0613D0
        for <linux-edac@vger.kernel.org>; Thu,  1 Oct 2020 09:58:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f089d001daab592cfa658ec.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:9d00:1daa:b592:cfa6:58ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EB5B1EC04B9;
        Thu,  1 Oct 2020 18:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601571499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x+4wfkyKykDT7OmC2ro5Fq7KR9OqEfx1a1SOSUD37TA=;
        b=ll5h6dD5a5siocy2jE8WxL1appOI8KFgsREbcIOV5cL9PBaXbpxkdaOtkt/SZcYTxcL6PG
        K/zi0pYSUMcr65Lv9jTaVENoz0t8YdckZ82vKqYHljdLjeqHeE0NQsF/rdgwByS07e5NDC
        k7KeRIlN+g5rrbIjM7K2rVWxeRD4tmM=
Date:   Thu, 1 Oct 2020 18:58:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Corey Minyard <minyard@acm.org>, Andy Lutomirski <luto@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20201001165810.GF17683@zn.tnic>
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic>
 <20200930184906.GZ3674@minyard.net>
 <20201001113318.GC17683@zn.tnic>
 <20201001134449.GB3674@minyard.net>
 <20201001161645.GD17683@zn.tnic>
 <6c6238c0088747a994a2bdce38ad0242@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c6238c0088747a994a2bdce38ad0242@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 01, 2020 at 04:29:49PM +0000, Luck, Tony wrote:
> >> I was thinking about this some yesterday.  It seems to me that enabling
> >> IRQS in an MCE handler is just a bad idea, but it's really a bad idea
> >> for kdump.
> >
> > I don't think this code ever thought about kdump.
> 
> How useful is kdump after a machine check induced crash anyway?
> 
> kdump is useful for debugging software problems.  There are very
> few ways that a software bug can result in a machine check. There
> are many ways that a hardware problem can trigger a machine check
> and crash.
> 
> So it would seem (statistically) that the analysis of almost every kdump
> after a machine check just says "h/w issue".

You certainly have a point.

The only use case I can think of is being able to read out the MCE
signature from the first kernel's buffer - *if* it has landed there - to
at least know what it is that caused the explosion.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
