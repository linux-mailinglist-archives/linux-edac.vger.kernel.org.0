Return-Path: <linux-edac+bounces-1422-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7DA91B0B1
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 22:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF04B1C2344A
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0171A08AF;
	Thu, 27 Jun 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jGhcRKaU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA051A00C4;
	Thu, 27 Jun 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521039; cv=none; b=VQkb7BY8gwOmloHH8yC5YfkQnu5LAO05lAKkv6+N0CAXJtP2QuZWbvcTN5ETJ8Zox89iz9d+kHaIuieYtnzDqJ6m+K52IAUYmqiH9Djd/JsbcgI1D0bxOSVZWHFzRYJrz23NvySB1GZrrzY/Hs8CLW54hsEFjALPUtA0nxiRg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521039; c=relaxed/simple;
	bh=/0ycm2l9j34jtAIWJSiu1VNq/2gkvHWjQune4ds9FHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+ZXIyYtMg/jromidqEyY+JTPHnsajZUzdRwFopfKK0HO/GaZM7biJHq21BFL0SsyCZbGAOoZelXVJ1ZrTvXq+PJzxWm4/3yobjryhGhJrw7N1vmYvJimjEA1YbDriX5hf+Sigzn7SoCl18vhwTNGJdhxfU+kYYqTF7SsZi2t78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jGhcRKaU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 299B740E0192;
	Thu, 27 Jun 2024 20:43:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GVxICnAt8jnR; Thu, 27 Jun 2024 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719521023; bh=gj/diKGPWDCvq6ujznbYp0uO62jv3WgqjfqjkC72k/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGhcRKaU9MLOnRKN6pLSgD+4DxjsPDyzqzLQ2qtB5OIlBiCoYdNnpF0UFTo4eCh8v
	 wGPReesggVgLq2ugqBg5cQ9+slKUOO3WoKrW4Av9yNYLsN+mYRcvDAQhNn8B3z0YoB
	 2AWOCRfSdnG0nE/fUo84OonJmd8PohrEZYtcGTmDRjyAwVY3H/WapXehoo5XE2dc9o
	 Tz4kwMJa+ylqns7JdC6lWLE1U4zVxUuKxjH9hMOMczgUhKbjQ0bUBRCM1ewJxmcuQC
	 w++/R8mLa2BkfVuAaXHOSQQam+aViqnV92aANO4BptHgWEjqaRE5VEw+ouMZW/qpb9
	 0l2ZajP/LvUp6qerGGUM/2X1YzOC/w4ILNFDGKdAsJMPN7XBn/s582SdV2iAGz1HTA
	 bINeMdl89gJ5BM3O1RoIifIcXgCjsR9OjZ15YQJBW42F0FeeFzu0Q9yJV5rLzDd1uo
	 KbdYaOgEnLyxTFSoqZRaf23mhzg+oRYg5atMAJK0xAnN02wdCUP9ssXSKYQBhm9LN7
	 hkx78qm1I7KMzVKw7K8WneBMltA/6tvDHydqoAqesEkcb2tWAKQdeABh9peQ5urOjL
	 4Nxc+90Piji8tIog9rNBQc8qWMaT02Isah+wBPU9m59n8zLjnuZ2dBen/b+JZBSdqL
	 BXAXzIfhRqO6n8+P+y8OZOTQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF8CA40E0194;
	Thu, 27 Jun 2024 20:43:27 +0000 (UTC)
Date: Thu, 27 Jun 2024 22:43:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Michal Simek <michal.simek@amd.com>,
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
Message-ID: <20240627204319.GEZn3O50ZppcI418Zx@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-3-fancer.lancer@gmail.com>
 <20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local>
 <5h32gfwdk6uztiv7kbsjbvbghu4yuox6h7b6pqughftztyk2yf@cmzsanqvwcmq>
 <20240610080037.GFZmaypaCbTsXdGeKw@fat_crate.local>
 <xgckna5pkrh6rgw4sz7hct6akndpewjmqzsep4lz23j6qdme33@f2y7gdqp2ihw>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xgckna5pkrh6rgw4sz7hct6akndpewjmqzsep4lz23j6qdme33@f2y7gdqp2ihw>

On Tue, Jun 11, 2024 at 07:57:26PM +0300, Serge Semin wrote:
> Well, I see it otherwise. If you posses the databook then by using the
> references you can find the info there straight away with no need in
> struggling through the _1.5K_ pages file. If you don't have one, then
> you can just skip that part of the log.
> 
> So I'd rather leave the refs be in the log.

Sorry, we don't do elitist logs: only for the people who have access to some
specs behind a paywall or whatnot.

If those are not available freely, then you should paraphrase the relevant
information into the commit message so that it explains the problem fully and
people don't need to have access to those databooks and then state that the
docs you reference to not publicly available. And you're doing former so I can
fixup latter.

> > Nope, that's up to the maintainer to decide.
> 
> ... and the review committee,

There's a review committee? 

I must've missed the PSA. :-P

> and the linux-kernel list members may participate in the discussion too. But
> that's not the point here, right?

No, that's exactly the point - the maintainer and the submitter decide that
- not stable people or your "committee".

If someone gives a good reason why a patch should go to stable, sure, but also
the maintainer's decision in the end.

You know why? Because in reality the maintainer gets to mop it up after
everybody and fix shit.

> It's up to the maintainers to decide.

Yes, what I said.

As to the reason whether a patch qualifies for stable, read this here:

Documentation/process/stable-kernel-rules.rst

> As you can see, I do and of two IP-core major versions (and plenty of
> the DW uMCTL2 IP-core databooks). So should you need some help with
> testing the bits coming for the Synopsys DW uMCTL2 EDAC driver, just
> send a ping to me. I'll test them out.a

You can also add yourself as a reviewer for that driver and get CCed on code
submissions and test them.

I can surely use the help.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

