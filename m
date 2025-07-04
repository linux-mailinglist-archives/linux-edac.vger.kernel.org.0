Return-Path: <linux-edac+bounces-4322-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80659AF915C
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264E73A803C
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BADA2C1597;
	Fri,  4 Jul 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pg+ub1sc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA3258CC0;
	Fri,  4 Jul 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751628024; cv=none; b=LoyKSliXiR8vrHk3SH+RQAu9Zz9PXva4NbAUgN+kwfndz+vTJlmb4wZfs2NvjrvskxoQ3kneS/DvPJTcHJN4MbeEDzLyzEjBBXY2l23ySlRsPuOKquDk6OmrsK+90Qo8cwp2bML5NKTEnB1rcwvXOm4mlaGaZj5IOny701FSmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751628024; c=relaxed/simple;
	bh=an+9EeNhe+f7NnClXdzy3GT6wr5ZBU9/N4Xn0aJS5Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HugWJH2wU4qW+imBpLuMhLAsnLoQWVbp4Y9NLpQRG/CB336dfQJ5V1ZTkQ/rL3IFG7/m7ceNfP+3DWxMnu2u1jSxFchoHbcipopMcYpkoThiwn2bULmKndlZbmj0QpnlEaMx3bd+7CVFonmR7Li6ppe1TN3n4vOlFo7rCzmHHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pg+ub1sc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E6CA940E021F;
	Fri,  4 Jul 2025 11:20:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ImRrZ82OTgD8; Fri,  4 Jul 2025 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751628016; bh=PbxPRHfo8N4/KU51gmHKmbPHvzNy62/CXTuO33u0tnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pg+ub1scvKldoKC9Ddw71bhRdkqL0oPyDEOyxXt/tLUSxq0lLyLLq4kuuENHD2X44
	 tmxZW9IeFIRwHFUHvv1IVUePmve4vx9evHRDQkSOr0N0LC0l5VSwgKQtUfhZbbDnN9
	 WioZ5lVAouTwMkBi8u1LkoxmtGVGGYwlTTeamzsT1LUux57EaKd9ln7HM3P90gYMWa
	 WhxVOYHVSDFp5FBsbWClz7LjPSQy2B/xQ0iA0jQbTtDmduCnSr4MDuuK6rrYO61KiH
	 99b0nZpXqWmsCMpfkBBU/4PuLz3KrjpxP6uUp34w0Lw6N1b4pCtSZ1tK9LeG9qdoUl
	 RdVmNfVfp/jWXAlfILdT24bluuiFejdLSFDBE6Vh2eQhkVIadmmtoukGGTgNZpaElX
	 2vUYNb79OXqmVFcPtFrbV7lf5je6N/abM4wf3Ka/NQwExEi0B2fKv8tyhQHe8TK+jW
	 iKfLfjh1rtc8TOADC+64EGNYMgrY63fWzQ8Uhea8Ds92V2OcoX5lO5dBdgMaLZ/aH1
	 j0evWwTP+yr/fuQv5h523cVSL612AyNBQ/NaA6jBE62avucrRo+4/wJMlmcXvNNtzG
	 dfKyyun2NRGQACwd7lp8x30EG6ho2IiUrK9aGkc8cStkxmG3yvQqiOCfvmZqexU/kO
	 ufm/8IhY1dxTkUA8dezDqfww=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7914C40E021E;
	Fri,  4 Jul 2025 11:20:00 +0000 (UTC)
Date: Fri, 4 Jul 2025 13:19:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com,
	rafael@kernel.org, Alexei Starovoitov <ast@kernel.org>,
	kbusch@kernel.org, rmikey@meta.com, kuba@kernel.org,
	linux-edac@vger.kernel.org, mchehab@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] panic: taint flag for recoverable hardware errors
Message-ID: <20250704111954.GBaGe42gY5_xADb17Z@fat_crate.local>
References: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>

On Fri, Jul 04, 2025 at 03:55:18AM -0700, Breno Leitao wrote:
> Add a new taint flag to the kernel (HW_ERROR_RECOVERED - for the lack of
> a better name) that gets set whenever the kernel detects and recovers
> from hardware errors.
> 
> The taint provides additional context during crash investigation *without*
> implying that crashes are necessarily caused by hardware failures
> (similar to how PROPRIETARY_MODULE taint works). It is just an extra
> information that will provide more context about that machine.

Dunno, looks like a hack to me to serve your purpose only.

Because when this goes up, then people will start wanting to taint the kernel
for *every* *single* correctable error.

So even if an error got corrected, the kernel will be tainted.

Then users will say, oh oh, my kernel is tainted, I need to replace my hw
because broken. Even if it isn't broken in the very least.

Basically what we're doing with drivers/ras/cec.c will be undone.

All because you want to put a bit of information somewhere that the machine
had a recoverable error.

Well, that bit of information is in your own RAS logs, no? I presume you log
hw errors in a big fleet and then you analyze those logs when the machine
bombs. So a mere look at those logs will tell you that you had hw errors.

And mind you, that proposed solution does not help people who want to know
what the errors were: "Oh look, my kernel got tainted because of hw errors. Now
where are those errors?"

So I think this is just adding redundant information which we already have
somewhere else and also actively can mislead users.

IOW, no need to taint - you want to simply put a bit of info in the kdump blob
which gets dumped by the second kernel that the first kernel experienced hw
errors. That is, if you don't log hw errors. But you should...!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

