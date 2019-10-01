Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00944C3153
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfJAKZm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 06:25:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37600 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfJAKZl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Oct 2019 06:25:41 -0400
Received: from zn.tnic (p200300EC2F0A2D00017390E5B71D5792.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:173:90e5:b71d:5792])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E954B1EC067D;
        Tue,  1 Oct 2019 12:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569925540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RaP7lzEeNpwJFyEgd0ifXAeNVcOjPtxtxmyMVCw/82k=;
        b=krFKLzr/64jERMiS8rbqHaz/KmRtAxWpKemMjchmeKgQGnVBhiGs2i8Yf/dNdG637oDNs8
        RN15arnzmzP/He6Cf1AFm5FT4U3n7K1x+sobMkle1/ZIS2dwluBFqwdapXwlQJRCbCLTct
        ciZ3fMLF5QkcPbi+xSYzZmhllpktyQ4=
Date:   Tue, 1 Oct 2019 12:25:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Hanna Hawa <hhhawa@amazon.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Message-ID: <20191001102539.GB5390@zn.tnic>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com>
 <20190930145046.GH29694@zn.tnic>
 <20191001065649.a6454bh4ncgdpigf@rric.localdomain>
 <20191001083242.GA5390@zn.tnic>
 <20191001094659.5of5ul2tof6s75px@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001094659.5of5ul2tof6s75px@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 01, 2019 at 09:47:07AM +0000, Robert Richter wrote:
> If you move to static inline for edac_device_handle_{ce,ue} the
> symbols vanish and this breaks the abi. That's why the split in two
> patches.

ABI issues do not concern upstream. And that coming from me working at a
company who dance a lot to make ABI happy.

Also, I'm missing the reasoning why you use the ABI as an argument at
all: do you know of a particular case where people are thinking of
backporting this or this is all hypothetical.

> Your comment to not have a __ version as a third variant of the
> interface makes sense to me. But to keep ABI your patch still needs to
> be split.

Not really - normally, when you fix ABI issues with symbols
disappearing, all of a sudden, you add dummy ones so that the ABI
checker is happy.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
