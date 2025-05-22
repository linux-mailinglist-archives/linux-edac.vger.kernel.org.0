Return-Path: <linux-edac+bounces-3993-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70EAC10E7
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD2AA22B80
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30E86358;
	Thu, 22 May 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g2o6a9L6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DD3CF58;
	Thu, 22 May 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930841; cv=none; b=iePqOWF4u0x7rYsXD9Qqr6FtqrDpwTX7LbXq6Wpyh12Y3sWS08vxh+GQg5r4tWB4FJKAsllCKFBHvQi0Ie5n5njNKHu+elxcebZWlLCnVcdVAeYInVxAJgWCsj66dN9wzkW023Xy+B/iDiWw3bhCfyakotVQMtXtrh2ASwkJiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930841; c=relaxed/simple;
	bh=vjDOkbQJPeCHQdLjzb80j6kReUjfQOyax0Exyv33VFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsgGVPZplnUp5L9RXgopYr37vCWGzlKkbDujJAsFLYN//VZzIi4MIwq03fOmdH3I0OecLpAknR3tlKdFOWW2TQxVbpa8l97++5AWD69hK6AW45ZVoSkRkcvVxD62P1q2aW08ky5tTm/0/iRjB4QRgXb30hqKD0tt3+B2IVVEfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g2o6a9L6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4681940E0238;
	Thu, 22 May 2025 16:20:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZEKBJU_o0Asi; Thu, 22 May 2025 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747930829; bh=jup7dp1wpyFPvMkHA2/0L8YCzJUVV1Xivs6Wtb8oDF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2o6a9L60Zrk/VI3OcCkCom+2Hn9WIJnCAJEFxlPT0YzQjhW538GToiaBL21HncjJ
	 mcrKukMGkzjurLXePvSiJLZ8ZWIS9KLFanKG75FXzv/VbySS+wKb77fkvGsAFziKGS
	 E3flmgW8nqQxfwc3qCoN4E3Yn1PNOVxPfLZFTe7Y9+vxN4hz9NO2TfHhNn6d4GEg+/
	 GWtH/GBS5+x4/OOLo6qD6vtYl7Q/jN6RAad3DIkqJvLS9AeRPWvgdYhcG163SZVDtD
	 zb8LSfH6SOkmI/QUJOVgYg2f0X1B+wy3jZZ4u+Sk+yDBA0a7n6hOrKfy371SLSVda3
	 c2S+GQHcU1xj9O2euwII+AakDlOB6gulERLS9CXT9Rs/FLl4iY2Kli//p/HyQ1onVP
	 2A1iUB/AOf7R/GCPFm/hHWGViR8xU1bNdqPlyC/lMpxxJqceFnaPhwjpewrDnzSH5b
	 8ADsEFmcrfG8QzyfXVla4/1Gtm0fPKPbBYUSkCFspzOyNrkmmFqgDC9gnlrkSh9fNN
	 ksDRlRHRQhW1NpkTq4jrWTlQ4EjQ/lHzx4cz8g/Dci05zoXu8f49olCnMqThi0FzmF
	 OS46elbeIaR78RhewYxXF5Dclxe0Yd2lRH5BAdG0PSF2uiOOBXtw7T3xrJP7Q7Lar9
	 c53EguIlmNSThsIW2A4gOG8w=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A9BA40E0192;
	Thu, 22 May 2025 16:20:21 +0000 (UTC)
Date: Thu, 22 May 2025 18:20:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: Shravan Ramani <shravankr@nvidia.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/bluefield: dont use bluefield_edac_readl result on
 error
Message-ID: <20250522162015.GEaC9Ov72e1AEPivj4@fat_crate.local>
References: <20250318214747.12271-1-davthompson@nvidia.com>
 <PH7PR12MB590226280DF463501FA9D0F8C799A@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR12MB590226280DF463501FA9D0F8C799A@PH7PR12MB5902.namprd12.prod.outlook.com>

On Thu, May 22, 2025 at 03:41:23PM +0000, David Thompson wrote:
> > -----Original Message-----
> > From: David Thompson <davthompson@nvidia.com>
> > Sent: Tuesday, March 18, 2025 5:48 PM
> > To: Shravan Ramani <shravankr@nvidia.com>; bp@alien8.de;
> > tony.luck@intel.com; james.morse@arm.com; mchehab@kernel.org;
> > rric@kernel.org
> > Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; David Thompson
> > <davthompson@nvidia.com>
> > Subject: [PATCH] EDAC/bluefield: dont use bluefield_edac_readl result on error
> > 
> > The "bluefield_edac_readl()" routine returns an uninitialized result during error
> > paths. In those cases the calling routine should not use the uninitialized result.
> > The driver should simply log the error, and then return early.
> > 
> > Fixes: e41967575474 ("EDAC/bluefield: Use Arm SMC for EMI access on
> > BlueField-2")
> > Signed-off-by: David Thompson <davthompson@nvidia.com>
> > Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> > ---
> >  drivers/edac/bluefield_edac.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> 
> Refreshing this review...
> 
> Does anyone have feedback on this EDAC driver patch?

Looks like it fell through the cracks... :-\

Queued now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

