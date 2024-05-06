Return-Path: <linux-edac+bounces-1000-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BAC8BCBE9
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8524B1F21119
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6901448EE;
	Mon,  6 May 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gY0DU4cb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BE142E84;
	Mon,  6 May 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990859; cv=none; b=OAXeUf2xHbUGk0p67sQHw2IJe/3iRQC8y6ZTFLiz+c8JcjckPc1DeTa+OI48VLh+exYY48m3s5AwpAKzhaYhql7ed0rPRjnc+0DvU2n4tIW63hFHISdPJvWdSu/Ivmm7u+N5LNC+yJ0N8OCcmwPOC0+9h+KhQoSofO4HJL/rTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990859; c=relaxed/simple;
	bh=8Wao3gYt+CEW0SQpRQ9Ae4PaD9ogSMaZly8/ad2PMEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esjbqf16EvaJwO2oWPkuhnRuBoXnkIaOxaC2Y5Vpe2eE8GyCExuQZSQzmFCbesyCOXj0EtWT1AunXN1eT0zirhSWtzSRaGlWxWcJ1lEAavmgWDufO4pfbjY5Drr2TRXfxhEFbPu9El5FAbHRUSanFXlbOxyhbOUHvfr1nPKJN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gY0DU4cb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD8BC40E0244;
	Mon,  6 May 2024 10:20:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I9DzhHUcwK8X; Mon,  6 May 2024 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714990851; bh=odPYvvukVUIG4z0+MLciC4/SrbCeCrd+21yQf+cBaO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gY0DU4cbRvFTSoxpiTlfTVOTkP+9+SH8Tyh9lzAouNZOYkQSFzbyYkYUSgMUtMXWX
	 35RXTvCuYMsgpfsmoL+0mU8aVAmvqKJnmSsum74GMZ+Tlrr/Fvga824Rmyi26nrCOq
	 bgkx6mjQG/v4L1MIMq9dLbzzzK49QWyqe0hR6+/wybPZ3RFwgVV018H3zDMUOk/vbZ
	 Q4JEPzaWamPaHCyHNLdLAB2x/jlEoxjStM1AjxFiQnfC96fEewpPZAPM8eX4jx8LTM
	 pCgUvulnBwbtIYimuz0Peye2I0IZmEyFaVlagJAkB7Eop2iBn8o0dazywd4KDnEv5b
	 ABhFhmn2DcgqtdE2yU3bnuZkirsU7f50hStyIM8AsmOfxW+wbianqsd7gVm+3dyjZs
	 9ZBt9d3QTKSkKYydwSFqbNW0BrJIJD7+PT1YvmwY8GZuEAP6s6nbiGtMBIbPdTW8ax
	 b8sRVLsXsCrHIM1y0mFCklMD4BD5+lrRffNDZ9Xm87o3lg/yJWwnrRLODiRkvYfrUU
	 ScCRTRrl1KBttUtgopsfi3Ut49sbdagHUVlHPCrNBJeHBuqFv/j8SiAS2Psx5Fn/kV
	 6DFhsTL40tlVOLIhi8o7a7JnnIIw1U4S3MYHE8ir8mONhFPCBvzQJuFZ6UEQw7hBwP
	 ZWH1rXtXq2oPPay4PF9wTrqo=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29AE340E01E8;
	Mon,  6 May 2024 10:20:35 +0000 (UTC)
Date: Mon, 6 May 2024 12:20:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ
 disable race condition
Message-ID: <20240506102029.GGZjiu7TKP9FVp-2Sb@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
 <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
 <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>
 <20240421100712.GAZiTlUOm1hrLQvaMi@fat_crate.local>
 <whgp2xx4dv3szezz3bvmgutgazz6kvie3q7rgpr35zqzuzsygk@wppqzusteru4>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <whgp2xx4dv3szezz3bvmgutgazz6kvie3q7rgpr35zqzuzsygk@wppqzusteru4>

On Thu, Apr 25, 2024 at 03:52:38PM +0300, Serge Semin wrote:
> Even if we get to add the spin-lock serializing the ECCCLR writes it
> won't solve the problem since the IRQ-disabler critical section could
> be executed a bit before the IRQ-handler critical section so the later
> one will just re-enable the IRQs disabled by the former one.
> 
> Here is what is suggested in my patch to fix the problem:
> 
>      IRQ-handler                        |    IRQ-disabler
>                                         |
> zynqmp_get_error_info:                  |
>                                         | lock_irqsave
>                                         | ECCCLR = 0; // disable IRQs
>                                         | unlock_irqrestore
>  lock_irqsave;                          |
>  tmp = ECCCLR | clear_sts_bits;         |
>  ECCCLR = tmp;                          |
>  unlock_irqrestore;                     |

<--- I'm presuming here the IRQ-disabler will reenable interrupts at
some point?

Otherwise we have the same problem as before when interrupts remain off
after the IRQ handler has run.

Other than that, yes, I see it, we will need the locking.

Thanks for elaborating.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

