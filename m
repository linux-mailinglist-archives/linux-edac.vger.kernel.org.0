Return-Path: <linux-edac+bounces-1249-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BBB901C3D
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2024 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8992812E9
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8F55886;
	Mon, 10 Jun 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EgbNaYdu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24E57323;
	Mon, 10 Jun 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006466; cv=none; b=d3lewerNsYtzO47hORweDsiugJQRBsYd7k9hMfNRowLWuxcagvZzBV1wQKe3oQM9Lv8tXCcSsOFdQZzf6l2DBCfuVIHKrAglPdD8M2DoFEhwWnik0+RJZmi8jTe5gxsubmqNj1bgrlWhcUNelEutEBpfiPS/yHcbk+tmVzvPGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006466; c=relaxed/simple;
	bh=8erf/E88jwuSkoF3P1BATcMvkdoOOMxwgKrtKmlQg3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI5HFOeHrFatXdAkObLlQlVViS7xY9v+rCMAm+hhfY3sAi8HKdAL7jKMAJV4af3yqKpnEBVUvYISGHSClLyDKncv0AChe1FCBjeeTEH4q+l3TaIpP6gJQNSUdrxA+qEsnCoC/15IwP/ghk6XUjlebI3JAwGZi6x09CBgNIVqs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EgbNaYdu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D1D9140E0081;
	Mon, 10 Jun 2024 08:01:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AXbXrPxKx3qC; Mon, 10 Jun 2024 08:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718006457; bh=LRJeHZ/E89jdwSKNTG+Gp6Yyqq4ajsR0sFmA+sxsrj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgbNaYdu5+GP8omIVudKSU/PK+yJhLjHBRyw0LbRsHcZNZHXsAd+ymCRxNIlUlXA7
	 xtm4CkPOb846bBX5NjDpUOqocQIcK+Jxpag2I/lekJnlb1MVRTjXF52SRfuJzTT+Qb
	 bqrOXtyz+Ca8lSFmc1qaPGgxW34xchv6lbqUvG6aaXdxakKQCslxQUAlg3U885o09g
	 83U3EJhhS0DRMXas3JRn0Q6HUP6NFiqP1E7JBUhRZMQRNhz4OXfaV9CMeYGOKv++P9
	 br1eipIQlY2OT2VaA3C+KfbiGcX78DDx237BCeFF68P2e6UCNojjTR+BY/y0pb6vIf
	 JtvfRisUU51N3REx84oWzBMpjfzYWpg40vnBx+uM2Xg5KSod0st9i5oTciSfdGNx4j
	 UphH85KcIjVOHiZ9mBs6bo+Xw3ifmdlFHe2h0lWGLaOpw0PFcC9ny2voa529GUADJh
	 9J2wyN/pK5s+5NCH5qmNZJNOePK2oW5iFcsnpURS7W063szA3N3GdJyUEvkodZcP9F
	 JcjUcIm+3pS3rqqz7ru8yQmhDasbPzBGb5tafoYuuE6LC4L9Bkevzrrw5kPq9GbjEv
	 Yl7r5+gcojUvuFYc5EtpHF+btffj+deP0Q2BYQWQSOAHuU9cx2D6wRaGnrknEnfuCx
	 TvcVsZcZmMullex2FC1AtgtE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4376D40E016A;
	Mon, 10 Jun 2024 08:00:42 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:00:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/20] EDAC/synopsys: Fix generic device type
 detection procedure
Message-ID: <20240610080037.GFZmaypaCbTsXdGeKw@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-3-fancer.lancer@gmail.com>
 <20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local>
 <5h32gfwdk6uztiv7kbsjbvbghu4yuox6h7b6pqughftztyk2yf@cmzsanqvwcmq>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5h32gfwdk6uztiv7kbsjbvbghu4yuox6h7b6pqughftztyk2yf@cmzsanqvwcmq>

On Wed, Jun 05, 2024 at 01:11:27AM +0300, Serge Semin wrote:
> As I said because dev_type is the memory DRAM chips type (individual
> DRAM chip data bus width), and not the entire DQ-bus width or its
> currently active part. Even from that perspective the function name
> and the subsequent return value utilization is incorrect.

Well, maybe the author misunderstood it but the result of this goes to
sysfs:

	dimm->dtype     = p_data->get_dtype(priv->baseaddr);

which is in Documentation/ABI/testing/sysfs-devices-edac:

What:		/sys/devices/system/edac/mc/mc*/(dimm|rank)*/dimm_dev_type
Date:		April 2012
Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
		linux-edac@vger.kernel.org
Description:	This attribute file will display what type of DRAM device is
		being utilized on this DIMM (x1, x2, x4, x8, ...).

So you'd need to fix the comment above zynqmp_get_dtype() or I can do so
too while applying.

> First of all, not that much of the kinds.

What does that mean: "not that much of the kinds"?

> Just Xilinx ZynqMP DDRC (based on the DW uMCTL 2.40a IP-core) and some
> version of DW uMCTL 3.80a being possessed by Dinh Nguyen and, by
> a lucky coincident, turned to be mainly compatibly with the Xilinx
> ZynqMP DDR controller.

Then Dinh better holler here what the story is.

> > > 32 or 64.  At the same time the bus width mode (MSTR.data_bus_width)
> > > doesn't change the ECC feature availability. Thus it was wrong to
> > > determine the ECC state with respect to the DQ-bus width mode.
> 
> Sorry, but this part doesn't miss anything.

Gramatically:

"The IP-core reference manual says in [1,2] that the ECC support can't
be enabled during the IP-core synthesizes for the DRAM data bus widths
other than 16,..."

"synthesizes" looks wrong.

It either needs to be

"... be enabled *while* the IP-core synthesizes for the DRAM..." which
still doesn't make too much sense.

Or

"... be enabled during the IP-core *synthesis* for the DRAM..."

I don't know what you mean with that "synthesizes" thing.

> First of all, MSTR.data_bus_width field can have only one of the next
> three values: 0x1, 0x2 and 0x3. All of them are handled in
> zynqmp_get_dtype(). So in the current (incorrect) implementation it
> will never return DEV_UNKNOWN.
> 
> Secondly, dimm->dtype isn't utilized for something significant in the
> EDAC subsystem, but is just exposed to the user-space via the dev_type
> sysfs node.

See above.

> So based on that my bet is that since the incorrect code didn't affect
> the main driver functionality and since the dimm->dtype is just
> exposed to user-space, the bug has been living just fine unnoticed up
> until I started digging into the original DW uMCTL2 HW-manuals,
> started studying the driver code, and decided to convert the driver to
> supporting generic version of the DW uMCTL2 controller (not only the
> Xilinx version of it). That's what this series and the next two ones
> are about - about converting the driver to supporting truly generic DW
> uMCTL controllers.

I absolutely don't have a problem with that - good idea!

However, we don't break machines and don't introduce regressions.

> > Can those be freely accessed?
> > 
> > If not, you should say so.
> 
> No, they can't be.

Then you don't need to mention them.

> 
> > 
> > > Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
> > 
> > So this commit is in 4.20.
> > 
> > Does that mean that this fix needs to get backported to all stable
> > kernels?
> 
> It's up to the stable maintainers to decide.

Haha, you're funny. How can the stable maintainers know whether each
patch that has Fixes: tags is stable material?

Nope, that's up to the maintainer to decide.

> I've tested it on the devices with DW uMCTL 2.51a + DDR3 memory and DW
> uMCTL 3.10a + DDR4 memory. I am sure this will work for Xilinx ZynqMP
> too, especially seeing we've already got the Shubhrajyoti Datta Rb
> tag:

Yes, I've asked him to review that driver because this is not something
I have or use and so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

