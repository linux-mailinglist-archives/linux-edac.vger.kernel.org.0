Return-Path: <linux-edac+bounces-3506-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7CA83F67
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9211444087
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8921D587;
	Thu, 10 Apr 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fn2W7RJb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CF26A0FF;
	Thu, 10 Apr 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278710; cv=none; b=YFXa0FkyrIxpsnrMs6x5vbDHl3DfIlplqxIhjTSWzMKV9EzD6Jg7l7DHotXUkfZ4OyF6Ek7znxigWWv22qBf8vQhxtblhS2u8ydG03/p6e011bx3Bvz38vY8gKBb7OBl4hgm1P87NusDln2FxiVA5sz3ziYAuGF4VyFcxWqbejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278710; c=relaxed/simple;
	bh=tCIJGyaQUmqedU6vvHAhVJHYdQEDHVpP/IEZ8yovUFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEBY/QTal6wXI7EVZQoPdMJ7z6DjvXsbYzTViikF/tn68YSGTbpsZft+joJEcWDVn/9Y9qUgKsfNy0E4SkKjXUPTHJqhVndrrOytPeYfJ9m6+7w6phw8W1rQzBzopCmh2sPQzDn4lYwYOWrqWsSCdPmtuOglo2fhr5yd1eLffuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Fn2W7RJb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F402640E0196;
	Thu, 10 Apr 2025 09:51:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZR1h1Iy5n4g3; Thu, 10 Apr 2025 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744278702; bh=wOmuhn+27CllaNwZ8Im1Jn6SwZkk7Xa3K41POrhMKmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn2W7RJbYtYirc9bIrLuiyygDke7sPBYF1HZBcts2lXnHfeSdegEO7KtzYFveFvzE
	 poSChpEQKO2h4ggVTZlYVSsdKf+coQNP1p+imaWoiCq8l6Y1ywqIgLmLQQk4XGMjfP
	 pjH+Wbymbfo/6fQOhMzqoiEKvivLbRE8DkX2i/+81t146hR8vnVUGen9qxIWQ3qBtO
	 Px7R64w9pBOm1Ou4uvbRZEz6Lwyweg+EbexRrZIcoNe3fPdkLClwXo9fMiDthqRKRt
	 IowKDIuLee818Rgue5Eos2rSKoCovEc9aurjkSEc/z3zaD21QebCTe9axakoTouP50
	 xfVEOFB1cbWVDxpStry0g3gl/0V6doF1rn30MIRgP0KCK7qIWjgqW9UK80I/uej8qs
	 x2igi3CFo7ledvDosyGhPyyibgslSgt3RgNHozyMaMZ8iX4AmXyYtF1wmaSZAfTlD8
	 VdOAoypS2ud1kHnlkhT6HO/SUM5rkVsfmn7scAW8VxF5PYWHTMxfKMwfeImHEK+HU9
	 vTqskDzxeLuLwknVEDsZZCaF+NMZw1/z2NIEcRYZoDDA9/Ba00TK6uD46GLDqKvLuG
	 9r8qUYSbYK9J0ISYx7iOgCAflWtV7R4TjRSF7v0gy5eQtHCkWuA6lB4a+Qcgl/0G0p
	 X/6p18I0LDwTC7EM6xdeZMwI=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81B8C40E0242;
	Thu, 10 Apr 2025 09:51:37 +0000 (UTC)
Date: Thu, 10 Apr 2025 11:51:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Message-ID: <20250410095135.GBZ_eUp4QTXrx-slj1@fat_crate.local>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
 <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
 <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
 <20250407151657.GA1948540@yaz-khff2.amd.com>
 <20250408101415.GEZ_T29wiuh-_sExlk@fat_crate.local>
 <20250408155242.GA2523543@yaz-khff2.amd.com>
 <20250408173333.GEZ_Vd7V0hqJfBXFRu@fat_crate.local>
 <20250408201055.GA2700280@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408201055.GA2700280@yaz-khff2.amd.com>

On Tue, Apr 08, 2025 at 04:10:55PM -0400, Yazen Ghannam wrote:
> On Tue, Apr 08, 2025 at 07:33:33PM +0200, Borislav Petkov wrote:
> > On Tue, Apr 08, 2025 at 11:52:42AM -0400, Yazen Ghannam wrote:
> > > At the moment, FMPM only loads on MI300A. We can just have a local
> > > function to mask the addresses. I was thinking we can have function
> > > pointers to make things generic. But maybe we keep it simple until
> > > really necessary by just using the MI300 version by default.
> > 
> > Now you're talking! :-P
> > 
> > > Please see patch below.
> > 
> > ... which I simplified even more.
> > 
> > I'm thinking whoever is going to test fmpm on something else besides MI300A,
> > they will have to extend this address masking thing and then we can cross that
> > bridge when we get to it.
> > 
> > So this is keeping it simple for now.
> > 
> > Ack?
> 
> Yes, looks good to me.

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

