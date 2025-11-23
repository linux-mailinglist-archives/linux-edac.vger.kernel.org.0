Return-Path: <linux-edac+bounces-5511-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A54C7E528
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 397B74E1831
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4C231A32;
	Sun, 23 Nov 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R8Bhv6nX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882A13777E;
	Sun, 23 Nov 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763920667; cv=none; b=c7yT10LSUhtIbMWDxmM2P+qHz/NFx5hBiGIImwPcGS/iIYTnvZqln3EQKLC2FPtWoYrPVPxZfUa6fUfHtAQquoZ3TPCzx5I1d5HdoAzWcceFOLITIepAJkKhbC7IzY9MlJtcp9GBNv4OBdkwlsv9Gi9dTyu7KMc+6/NOTjpPum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763920667; c=relaxed/simple;
	bh=Z9hwOgXb04eA8GDma4tCMTJAgvXxbdnF/RntYz9+SB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIvqgiR80dC+tASMB5Dgt/Bwv2K49eGh2k65DcxQsrtQyilhJ9oCN1fbCw86xyFazm0rdES1bL0GBpM7DbL/fk1mp7SIhXyUW1bs3Tm1OWYY9dSY9P8NYfDylFqukiR0KaT6Y9FUXshfpEDP23k8ZawX3uNcQKxgxvOEehdcD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R8Bhv6nX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 79B2C40E00DE;
	Sun, 23 Nov 2025 17:57:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IOMsLVzQOTjj; Sun, 23 Nov 2025 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763920655; bh=spvMtnFTrgsATv00nqO5uxjDqX0d9MqTELDDys4rl+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8Bhv6nXMwfES82R9JaWUGagat9miyUvIeUL0lcxqNnZH0DGOxC1f/TpRcjxHPozA
	 s8IcIlm23Po15N9JFp6ZYRxVIoj5AYz5lJl1yOa4iOmM64mIk4kxQ2Fmeryf3U96By
	 nUaLBjkJfQ50czuxADs/GiZYQbEk6tVpkrqE3jSSeH/D8cBGXJwNdVEm7SsUQJb2Oh
	 qJIVKFwmrAiFWoWBEmwOtFeaugFRyIPVmdr7NpL7Bg1pt80I7OP6TtRfuyhRRusMzO
	 baLmR6mteSB0S381woGKE/PZd8PDTLyfQBRIxuwjEK6S4fT/rzBEOs0n0GOq9KhK4G
	 S4IciHBtRlJWOEXAHDEgnmce9RWZD9nxcvoiSVM1SO/L5lhTRNxduzCOs/ackJHlx8
	 gCdL5miybYmlY5LOhn4NQt5kWE3WmR2w7TO8OdCjzqk7NKHekP53fCaxFtp+WQ+On9
	 TBfXuK0/DUXzM1iU1O4MJBDu0y8Yv7jqHvyXaQbaNmB2eaEYbPnkBXDplAZkPau1ye
	 8rhzSIDc7uZZQ9fONEz02lUSf1etkNxQl9EuKUBx5aOo4+54loPQnVcP8qaTcLQ4uq
	 mD6KWi2rAsC8pcW8oh2p9g+oUEq20CLU8PkRbbHh9bNEogSsIvxdu2xvoSZIqAiA5V
	 nGO97mJRI+HGYLMXEnW2jY9s=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0F49340E0191;
	Sun, 23 Nov 2025 17:57:24 +0000 (UTC)
Date: Sun, 23 Nov 2025 18:57:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Vyas, Devang nayanbhai" <Devangnayanbhai.Vyas@amd.com>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Garidapuri, Ramesh" <Ramesh.Garidapuri@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Message-ID: <20251123175707.GBaSNK82uGdKGyRoXM@fat_crate.local>
References: <20251123142746.1879744-1-devangnayanbhai.vyas@amd.com>
 <20251123153318.GAaSMpPrSZLkzx8D5c@fat_crate.local>
 <SA3PR12MB79493BC93CC40066895300B28AD3A@SA3PR12MB7949.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA3PR12MB79493BC93CC40066895300B28AD3A@SA3PR12MB7949.namprd12.prod.outlook.com>

Hi,

On Sun, Nov 23, 2025 at 04:41:25PM +0000, Vyas, Devang nayanbhai wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

This is clearly not internal distribution only.
 
> Do I need to raise the patch at below?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> 
> edac-for-next branch
> 
> Please confirm?

I just told you exactly that, wasn't that clear?

Also, please do not top-post - this is not internal email. The proper
etiquette on public mailing lists is to put your reply *below* the mail text
you're replying to.

There's a quick howto which I'm carrying in my signature exactly for newbies
to kernel development:

https://people.kernel.org/tglx/notes-about-netiquette

Please educate yourself.

Also, as previously mentioned:

> On Sun, Nov 23, 2025 at 07:57:45PM +0530, Devang Vyas wrote:
> 
> -ENOCOMMITMESSAGE
> 
> Use the commit message to explain why those need to load the EDAC driver at all.

Make sure your patch has a commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

