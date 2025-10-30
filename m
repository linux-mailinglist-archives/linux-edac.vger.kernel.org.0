Return-Path: <linux-edac+bounces-5267-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F6C20D46
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011241A2074E
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF932DFF18;
	Thu, 30 Oct 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqsL5jEu"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F62DA759;
	Thu, 30 Oct 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836508; cv=none; b=OOB1fto1X3EvADIN2UF/Zvd9DShc/maLuENnBXws5lFzZaIGR4vorWjovjkfvWYCcIvDZhT+aLZ2J01+mMNgCRrB+XKZPcCw1qOtIu3VOwmI7BO10CoFX4ytR7zVQ3C2VaiH4le0ogZhK0+PUnFtCIt3aC9azrAKNbM21udjAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836508; c=relaxed/simple;
	bh=DlPlo9FJNjgGbqXjhpE/3RhOWvwERzb1fKLR9seCutc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sppSZPag/+mfRCz+70wl4/1izGpZ0sszxR96KNj0RrNv3FD0FvoIpjPXVkxHpMav3ZV1nwlnz3Kdgn4zRB5uB4tL9wsW3pFKqsT7rvfEkyFikOY7CoXlE5azUUYlnEx4cCjmts4A+oAFi7M4FgZuEzNLuNfxY8V8iAZftgg1jiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqsL5jEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AFEC4CEF8;
	Thu, 30 Oct 2025 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761836506;
	bh=DlPlo9FJNjgGbqXjhpE/3RhOWvwERzb1fKLR9seCutc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqsL5jEu8NQfy5/5dbc5WKhnPHHblAekoPEsFwQ8i5bu1XUC1iBsaKm/VTsEh4nU3
	 YA5tf5tcKv6nAIfXOaBcpX51pSJrBS492bLkg6vUrhc/kNjctnSxSwUQZgrq2reYo1
	 c/hyYx3rCGyZ3D9n7/xViDby4FchrC94k/YTqkks=
Date: Thu, 30 Oct 2025 16:01:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
Message-ID: <2025103029-reforest-negate-cc34@gregkh>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
 <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>

On Wed, Oct 29, 2025 at 06:24:19PM +0100, Borislav Petkov wrote:
> + Greg to tell us whether that would be a proper deprecation strategy.
> 
> On Mon, Oct 13, 2025 at 05:30:43PM +0000, Avadhut Naik wrote:
> > The legacy sysfs EDAC interface has been made obsolete more than a decade
> > ago through the introduction of a new per-DIMM interface.
> > 
> > The legacy interface however, hasn't been removed till date.
> > 
> > Begin deprecating it so that it can eventually be removed by v6.21.
> > 
> > Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> > ---
> >  drivers/edac/Kconfig         |  2 +-
> >  drivers/edac/edac_mc.h       |  5 +++++
> >  drivers/edac/edac_mc_sysfs.c | 16 ++++++++++++++++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index 39352b9b7a7e..fdfeba848114 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -25,7 +25,7 @@ if EDAC
> >  
> >  config EDAC_LEGACY_SYSFS
> >  	bool "EDAC legacy sysfs"
> 
> Add "DEPRECATED: EDAC ..."
> 
> here.

Hah, good luck!

> > -	default y
> > +	default n
> >  	help
> >  	  Enable the compatibility sysfs nodes.
> >  	  Use 'Y' if your edac utilities aren't ported to work with the newer
> > diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> > index 881b00eadf7a..78b49d6906fd 100644
> > --- a/drivers/edac/edac_mc.h
> > +++ b/drivers/edac/edac_mc.h
> > @@ -95,6 +95,11 @@ do {									\
> >  
> >  #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
> >  
> > +static inline void deprecate_interface(void)
> > +{
> > +	pr_warn_once("NOTICE: The legacy EDAC sysfs interface has been deprecated and will be removed by v6.21. Please switch to the new interface!\n");
> > +}
> 
> You don't need to have a function which you replicate everywhere. Simply dump
> this notice once...
> 
> edac_create_sysfs_mci_device:
> 
> 	...
> 
> #ifdef CONFIG_EDAC_LEGACY_SYSFS
> 
> <--- here.
> 
>         err = edac_create_csrow_objects(mci);
>         if (err < 0)
>                 goto fail;
> #endif
> 
> So that it gets issued and hopefully someone sees it.
> 
> Then, I'd say around 6.19 we should make those functions return an error
> unconditionally and then zap them in 6.21.
> 
> That is, if no one comes crawling out of the woodwork with a valid use case.

No one is going to notice this type of kernel log message.  If you think
that no one is using the sysfs files, delete them now.  Why wait?

sysfs is meant to be such that userspace can handle file removals (i.e.
that value is not present.)  Unfortunately, sometimes this does not
actually happen and user tools do mess up and rely on things.  So either
no one uses the file and it can be removed now, OR you have to leave it
in for "forever".  There's no real chance to remove it later, that's
just postponing the decision.

good luck!

greg k-h

