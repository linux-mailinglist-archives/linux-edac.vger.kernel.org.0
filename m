Return-Path: <linux-edac+bounces-5491-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB6C752D9
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9188D2AB63
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9E3314B5;
	Thu, 20 Nov 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FSTwtyRV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDC33BBB0;
	Thu, 20 Nov 2025 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654257; cv=none; b=dL6M1Oz7XSht056wmb4Bmzvw1yvTDsUcfyrsNNXVbG7HfNtrWjSA1YFomajIaV5i4efhFacBLnMNWCfn8DLKHvCFLhQoR0NQSUaktrxLHXfvnb6i171NosaNhsYTvYzUJZeaigGGGah5C9zmJRYcpD7BZZ12RraTrIYcL1EPslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654257; c=relaxed/simple;
	bh=BKIZ1xabx2177bNjT5SaYel2v25DYnxcDiqtgXsZy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8O+6GySW6koxwhfbDrSqZkuuqkXE645Hc49bDPVjo7//yWKi3nX81Ga8DAYvUrK98uGn3V6cXPggmAeAtRgDHg6wKfn5QR8HBENyfkNc7RDoitRzc+o2ujdX0q6FgbebzQbquJ6Hatbva9L/UGc6kmGn/744i7h8sDlsT2VT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FSTwtyRV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C33140E016D;
	Thu, 20 Nov 2025 15:57:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4ygtrtTKB8-J; Thu, 20 Nov 2025 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763654249; bh=uQ6us0y+nAHVHQLhvo3M/vAoSRzmlO4DcTjJqEpAP3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSTwtyRVvptB7ig8wa5hVgyZi1fa9PO5V0CKC9piSOsb7495BljYm5uMfN3EcE8e+
	 PU3NOpd6VI/j5QTHytn7e2FLoKZJkp885DNGkvRujzvfnJQLbbICzlBfkmqCUzr04I
	 Q7HotAt1Jzh2vyLy39hiSJOungilxT6k9IMY/9PoBZvLojwB5kGBZvUzzdif7H8bJj
	 2nDhAC/Hkx9dvcuKY9RXkjyrrkpwZzyLYSLAFGK++himjcCqZweVr1n5ntv0lF/7LI
	 c96adaSvAiQT78bV3NesMPx3xkhGQamaw05DX717SxWB+A4qlhrpkWSERArEvLdrFk
	 H7EoixRdw0x7uEAmzI89pbzlbipRP6PPWi756UdwoYogFvmdF/rs0NBWNQuah4t9Ya
	 FtTT0jDzvxj5NYn4ZjSh2jKb1weOYxD2tNvhVaQLFWVwTTRmqYrYtARpnCllF750Dj
	 bE1loeWFiuGNth45pAUTg71R+Qfd/u9EBoaEHpUZNgxnRYH0Fx68rn9Xp3XA9BEtgG
	 pRHn08s0WlSh/9crSaAM/+cntUZBn/KXPsvTo5ZsaMsab4uIn02RAUB11s6FuiS8nN
	 6sZ132vqsfMCZYvuekBY+kvuHfDlP+Zk0DUouIjsDMc6rwX/k4w+x2tXVZx7zwf5xc
	 wHZDnVI/0ZWHGCQEn3ftaaAo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id F18DB40E00DE;
	Thu, 20 Nov 2025 15:57:24 +0000 (UTC)
Date: Thu, 20 Nov 2025 16:57:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Yazen.Ghannam@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251120155718.GCaR86XjhRyHTrkZYl@fat_crate.local>
References: <20251113111125.823960-1-nik.borisov@suse.com>
 <20251118123352.GJaRxnsHRC6KcbQanQ@fat_crate.local>
 <edfc3212-dc28-43a5-9d9d-c838d253ea88@suse.com>
 <20251120154153.GBaR82wW8qjDQA8eoV@fat_crate.local>
 <7f942b9f-ce85-4e02-9317-3aef1dccd1c9@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f942b9f-ce85-4e02-9317-3aef1dccd1c9@suse.com>

On Thu, Nov 20, 2025 at 05:45:10PM +0200, Nikolay Borisov wrote:
> So are you saying the patch should be dropped altogether or that the
> changelog should be reworded?  The way I see it, the parity for the given
> bank's col/row are calculated and this then is used into calculating the
> hash.

For you it is the parity, for someone else it is XORing the bits. All boiling
down to the same operation.

The only upside to the change is the removal of the function and using the
builtin. Which begs the question, do all compilers support that builtin?

If yes, then you can reword and resend.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

