Return-Path: <linux-edac+bounces-3920-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE262AB8687
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 14:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2897A60F7
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E6129992E;
	Thu, 15 May 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M1YstMjS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3C298C37;
	Thu, 15 May 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312649; cv=none; b=c01JwKpUM04gmAKX5kp4bo0oThzPWikYrMVgteSXwRpRm0DbdKDDFuBdJB6tCjva1pAapOytsnIWp2XWWVmDCc+keNLCHsx4SXqJLKKKxF8Dg39A2NFtq//cQ8/R/9qFMBQrHDPpRlKoEKJM4OSyhZpK7VuiNd0y0XYaEVefqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312649; c=relaxed/simple;
	bh=oUBmBEe2ii8BtwyBF2Q+wfvUX7Xj1f2iMT4zn68079k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxr7kHTX4tHw57J9xvXIooFf6aPkzYWwnjVWwFP3HPoDwjrchH6IvoIuLo0Gkkg1Ac6mV9uHCR5dmYi+pq2TizdYzb1naKo7oui07C4maDj8ACu5GyfJCJC6NjTfh7bRj40JANjfdDGsosS/TPwkX9DlYZdQmw3Pk8JS7Xe5/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M1YstMjS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3D1940E0222;
	Thu, 15 May 2025 12:37:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v0cjMTzp2qCl; Thu, 15 May 2025 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747312641; bh=BuDy4hEIt0KBDD5XgNb+TBGdfMJZjNXJURJrUohP5Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1YstMjS2fbmqi3/fst3t55CYfy+LrjssDtkFvCI4B6pbQmT7nyA66f60C8GjNjnK
	 kWjtqsUc2OSg0jMrCXbs186P4ijpetuWwzB4Meig4vjbktzkUio5VTFcFPI+saoTGa
	 YTWyH2i2NNplkaiY6Antt9yaqlM+cOtI2qo1wn6eoNELPzuVm9WbdixyEdFfH9bkaz
	 CAXS7lxGfly0gEqo3dA50uUWRbLY0IG4V+hhdq3PY6oSlP/pxQIoixpGAggXM7iMLd
	 iqKTmZ6xr5ZstjBCHgxxTzlnBzrv2ww0M00pxDpdOdHg2Uf5fG+ZR9W67yT6Oy0kQT
	 5MyDLIgS4oCiYM1Jf4ItUIa2t3Q+WKuqOFP2J2p4x9sqwa+0Km/4T4jdeb7kI7yy26
	 UYDmcU5e3L9IxuTH7EJx4io4aG9HE1mrdixK0kHpX81t5NYc2svOEiTVdCkz8o4nsn
	 2wRsQPxYEE7iQSM6DxJTjBCCIXuMPvuOWTDxHGWTliHp+K8btQV8bs78kHEv3ipgkb
	 xFs2b4sWIv7yvYfh3ffEcbABLxTqHfPX0dBJkPrq2TjdrIy6r9x1RaUbowhYOWDWCK
	 3tHpaRy2wNcVe1BN7v67uj6Ej7d6xf5iOGm6m6bZKfX1LXmsQZ+tjPlnZ03TKxPsmq
	 3QOh51PJum5SUvXSTzlMfK0g=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DDF640E0196;
	Thu, 15 May 2025 12:37:14 +0000 (UTC)
Date: Thu, 15 May 2025 14:37:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250515123708.GFaCXf9DLcsPqXhFSn@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
 <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
 <20250513210640.GA515295@yaz-khff2.amd.com>
 <SJ1PR11MB6083BB314BDEDB397861C845FC96A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250514143416.GA597208@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514143416.GA597208@yaz-khff2.amd.com>

On Wed, May 14, 2025 at 10:34:16AM -0400, Yazen Ghannam wrote:
> On AMD, MCA bank management is always 'local', i.e. per-CPU.
> 
> If a CPU is in the polling function, can it be preempted by an interrupt
> (not MCE)?

Well, ofc. We're polling with interrupts enabled.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

