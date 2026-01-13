Return-Path: <linux-edac+bounces-5632-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1574CD1B18A
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5629D3033DCB
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43136AB71;
	Tue, 13 Jan 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gYbR5RNm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BA25487C;
	Tue, 13 Jan 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333504; cv=none; b=FoLZFQ4/tQKI4yEQf+lBEBCTxwV7mwJuWWwE4dPmNOrUrEYZoYoUEUxMs+qVA/SuHo5+EvAbkTCUGB6dEpDX+Q3eCJZ7UQ3+z9fvoqqfxoL7U2UOlW+o5pIlYTs1wgcpQpMjTj0TfNqPqPfoxbqq52k/LtPgFsiCh4jVqg/fsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333504; c=relaxed/simple;
	bh=v84G4eiQWt6FQ2oowTyJHhNj0vUzzGoVJwEG9hGX9Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt+WoKaz/VuGtZwBYKfZkJu5qgUCmo+6bSpL2Alr3Vfc/1aiQ5h2PK48OtRDgbHI4wKA0hsKILn6QZVt2lU0bx7aiRCJqkeYR8hPBYLqsKHzqY/MeVm50jT2kKPieiF64rDOg7LJSlGdcvj+oCvxD9s595MyKpRkU1qR2xUAgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gYbR5RNm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 788C840E0281;
	Tue, 13 Jan 2026 19:45:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v40g-BGsuyee; Tue, 13 Jan 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768333498; bh=zVs9rqlRTgcbhqHpDqT3mqsYqBooilsLyeEEqLlhjUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYbR5RNm4OC5NtXN5lUtRHYK4mLdrGega4SBQ5sKcFdrgdLLoi8i9nYUcgZBPtugt
	 AAHvS6C+iSca3/CzquUKXYh4BuHaBDeQS64ZM5UF9vmcktwM5k7WpOL9ds9LRZKULy
	 dqLVcbeBfCh62Pg4hO9AhYdsj2hZS6JEPz26GPfhZdJvwUfm1+v5Pn4VaiXOoc0hSF
	 g+bXsJ35+UYlnEJDAjeoL1ukcGcpzgfvZwqup764bFGXdBfbiqb2X8o+lRmNVBAsWS
	 YdsxPWIXQeHoM2uWbJn9zCrkQvYluGK0NY8/7EuXwPMhcwUwUet3nz73P2miWYCT9J
	 AEfasvJjGHwv5ji67AMCk1AgTKLfBaW9xa4wQFXafJQRV9o4tEOJE2FAzfjMTiV4m/
	 c0YgbTmQLakAOF4r/b3AU5hzTcN+4nhXh2HCrFjuK5yKanDWPec+Hojf6dEoz3gvKe
	 GxC07F4l/veRQE+mhEAI3iQ/kzGr8uuGCRErN4KyhvVaoLTvCDXSOboZpQaLfw9UDG
	 rBHafoxtlFOmlyTumIcpNNYpmqzf05RekMN/AdX5lMi3WYe+CG4H26B4qpFkRmMDeT
	 xR8DbD4XhfyIfdI2ejMBFFK+PCRN3B858nqQJ1SOGfHn6plrhGd/EG/lpHW26yS9sR
	 WHlMQC4tnQuWKh14zgw6Mkvw=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0C56740E01A9;
	Tue, 13 Jan 2026 19:44:45 +0000 (UTC)
Date: Tue, 13 Jan 2026 20:44:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Li, Rongqing" <lirongqing@baidu.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNl?=
 =?utf-8?Q?=3A?= Fix timer interval adjustment after logging a MCE event
Message-ID: <20260113194438.GRaWagpmRGD0qGx9az@fat_crate.local>
References: <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
 <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
 <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>
 <20260113193327.GCaWaeB1rp7HCFJBHV@fat_crate.local>
 <c425bc04-2b01-4616-a244-01c896367f7a@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c425bc04-2b01-4616-a244-01c896367f7a@suse.com>

On Tue, Jan 13, 2026 at 09:37:13PM +0200, Nikolay Borisov wrote:
> Yes, and why is Li's approach not working, i.e if mc_poll_banks() returns a
> value signalling "i found an MCE" we halve, otherwise we double it?

It might be "working" but I don't like that "bool logged" thing and
marshalling it back'n'forth. This should be waaay simpler.

> That's certainly doable, but why should the interval setting be coupled to
> the initial notifier and not to mc_poll_banks?

What's the difference who notifies the timer? The banks polling will call the
notifier if it finds an error to log.

But before we do any of that, we need to figure out what commit broke this so
that we fix stable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

