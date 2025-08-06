Return-Path: <linux-edac+bounces-4530-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD9B1CE4B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 23:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364E218C2BF7
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147D1FF7BC;
	Wed,  6 Aug 2025 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MN7CXfnH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631619A;
	Wed,  6 Aug 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514952; cv=none; b=pfUkSUK0FC6eZDyE2aWRhSOYPGf2Tamye6Rt7LsVTIlsijbZ565lKBQ5B/ySZT+/Se2iJ1DERmbHZNtGuCwRYre1VlN9MyGF2QUmVzxeffkqeXEFIj3EuSmmKEkVCrDvqJgP+0pQR0dqePPjJmETiWi5SroI21/bkkfQ2uTuTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514952; c=relaxed/simple;
	bh=BSfPbafbrw1QJWLQpVD4umZIO4465Fn7SKiACi1n1HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHMQ2XZQyogVCdiYCe2qfKzmBYCndZjlBlDeRNwVChzQXmxOsZVlEi3aFBJl2w3aT02Lw4wEP4kMo0lsMq0gMMJlLXscMUcTZC4BjHELE3Yv2w3fCsvM0MzhswCp284pFf9bfePMBJai+Y8+JzIuWW/4Wrr59mqSV+K1n1pS3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MN7CXfnH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F101940E0191;
	Wed,  6 Aug 2025 21:15:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1bcjBTrVRFFF; Wed,  6 Aug 2025 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754514935; bh=yLPYI8FDAZE7JH6wqoJUyM9aszXF69z8hCx6R+NishU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MN7CXfnH4xoCVjG2G3TZo3OWHhYgtK761g+xgdQCiqEFNT6HcE7uVFHwqRiRsh1r6
	 rTj1Lp3x3BQBTI6YGnlqYLeeQtRc3HhCfEbHSiGdJhqJqwB48Xe8LSyv1E+6T+abr+
	 JfYfA7dy7FmWiEXps9ZDO4CHnFoxVaUKOkR8sUTNCfKJ5HeWQJN5BTH9wDXuFubN7E
	 cfBaVmJIyxY5ojSk2G5nrgpR47hGT2Lv0DhqjaWjvshLoY9+IR/7vJEDvRlfCTqTQq
	 AFK5rQvzUeHlEVukkTetB+6NhYiT+RiB1Evi4IdCZV2Ubi2Rgp/VoJn9L096mJYVBd
	 UtNSSATgXAxM8TuS3v44S928RJQACJnvEh9BVHoaNZwqLJ4VZR6z8nk0WNmVvqEPzf
	 AOYKOUFRzkyEsRH/0bLqytAW8kVnUjwNG1LySBFmrGu8ana9Vd8yFvHF5k2iWkc6/A
	 qQck2dZ0syHZQaeRZ4x8F3zzJlG7sVvASRTl3WpUo2t5AbZjSynHnsGggZtGlKYfr7
	 CLajzOANE6qv0WZXtMEVKsp/nobnUTRiFs8ONIDnfoWEcBfjr4qBMNN1gLK+52iwBI
	 k7MnUl9kXSd1iRCg4FQtDxWv5KZw5iUVWRlHhOi0T55n2NdG1bTg0t6sjSk1o4OLZu
	 IN2Xy9/zay5nxu/LdfEm8lTI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3360140E0163;
	Wed,  6 Aug 2025 21:15:29 +0000 (UTC)
Date: Wed, 6 Aug 2025 23:15:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	john.allen@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
Message-ID: <20250806211524.GFaJPF7Bk2dooZOVzc@fat_crate.local>
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-3-avadhut.naik@amd.com>
 <20250728151440.GB33292@yaz-khff2.amd.com>
 <c9ae8b26-e254-47a7-8e2f-b5da90f50030@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9ae8b26-e254-47a7-8e2f-b5da90f50030@amd.com>

On Wed, Aug 06, 2025 at 04:08:07PM -0500, Naik, Avadhut wrote:
> >> +			sprintf(s, "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x"
> >> +					   " Row: 0x%x Column: 0x%x"
> >> +					   " RankMul: 0x%x SubChannel: 0x%x",
> > 
> > There's a checkpatch warning here about splitting user-visible strings.
> > 
> > Why not use scnprintf() or the like?
> > 
> Had noticed the checkpatch warning initially.
> IIRC, it was for splitting the quoted string across multiple lines.
> Can use scnprintf here. But wont the warning still prevail?

Just do one long line. The idea is to be able to grep the code when you see
the string issued in dmesg.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

