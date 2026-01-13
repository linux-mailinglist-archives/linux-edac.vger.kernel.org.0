Return-Path: <linux-edac+bounces-5636-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B064FD1B513
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 21:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 779893007666
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99A318ED7;
	Tue, 13 Jan 2026 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mx8q2y99"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41831DDA4;
	Tue, 13 Jan 2026 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337840; cv=none; b=fIClQmTEzUI3u/+m+R93H1pkEl+6uIrHpELfaURVRAYBkYuR00y924UIzSCvpC8Wif5Q8kQo0qWpVBX5Oo0LpSaRScFAHzOC/lLkK0h1QFK93z04MEF2apAGfjMfBhb3na/7wCwc+4rYZ7XBsleBh5xFWu3i8pQWWgq/HMRrW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337840; c=relaxed/simple;
	bh=pFu32xM7CaiC8H5C6zEFRPUr8azv3kSMQbDlOkSOHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjfYq8tMvRwGO7fKfOtEZXUIB1wO19WFViB2v1i61C6C4Sv9fUgLabpTIMVROASDuRBhgCTKzQ9mZFZJ3HBFRD8wxrcoILHajeMihcIIlPa8+k8CCfVkjhuHT1rIh5sCuRL7gmpCOKp9pLHKgtNR49VXMhzLLLRAVXDg/ohMWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mx8q2y99; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2ECEF40E0252;
	Tue, 13 Jan 2026 20:57:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ua7ZwGIQXcf7; Tue, 13 Jan 2026 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768337832; bh=dhHw8ZFxrh9d7a0HJ3/PnTFd5TSATfCew2FWLwvF9II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx8q2y99Uc55a3Ek9TvqxC5Rfe18tsyA2/VHt3rVTTe/nEgogSYyuAcdT65AAFymT
	 WNEWBRq0Ya+t9Um77j5XR66cuVVKx1h5Hr+hWPvgZ/r9zxMJftt1zKm31p3OtO7OFf
	 piBTZXmfEyQle5RJBGglFTVY70BrsOBdxCspqlyS0b2SMSNvburTgGzBfiTaOuzpPO
	 r0QqK8ccHSl9AYu4eqmRFAd1I9Dj6quipNyoT8bc2LwBq+Ab6GH2Qbrj4HT3l0eb1J
	 HYSCgtodthl+WFZdlUYXwtkNCB8+ZorFPiGswh61+uYrdMdM+Dv7R3f8ey4KLZx07w
	 vOZ23ONEYgfNQVrVZwCicw/1zO5eHy3e+1fXM8PdUTSYF9e8w6rvrL/S2LiPPBsc4A
	 a48qxvIx4UVpv7DL+gBvZP8dm3MgHeRD4/10Dk6XC/Akf09gB1PiB1NsuDzaBVXal0
	 LnX+S65oc02/xqvf3ZzePTbXEYNSeReXn+DTuyoyVVHQCRHUT1IqV2tt0W0AcrMN5N
	 OpeRetPrNGxMMt3uFxHqwNnZeDB81/DBYD5P8bnX50IrQqoWTZ7QMczjr9gtCJSV67
	 Rs6SjMc3vLq4VTOIEANXCbrYMRMdFu0G69Mc1aP37Zh/c+TxyuIWLYxr5aPCUyirS+
	 ld3EFswYSwd/y2a4vOwgP1oQ=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9684E40E01A9;
	Tue, 13 Jan 2026 20:56:59 +0000 (UTC)
Date: Tue, 13 Jan 2026 21:56:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
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
Message-ID: <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Jan 13, 2026 at 06:53:13PM +0000, Luck, Tony wrote:
> I can reproduce here on an Icelake system. Booted with mce=no_cmci to force polling
> (and turned of BIOS firmware first mode).  Injecting an error every 30 seconds I also see
> constant 327 seconds between logs (multiple logs show up because my injection picks memory
> channel "randomly", so there can be several banks with errors when polling happens).

I'm assuming you also disabled the CEC? I.e., ras=cec_disable?

> $ dmesg | grep 'Machine Check Event:'

Did you see the "Machine check events logged\n" print from mce_notify_irq() in
dmesg too?

I'll try to repro here tomorrow.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

