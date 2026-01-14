Return-Path: <linux-edac+bounces-5644-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 860BED1F88C
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 15:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC66730024CE
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA126ED48;
	Wed, 14 Jan 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CSN6sTDL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB921D3F6;
	Wed, 14 Jan 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402122; cv=none; b=hBxXibgq9rkM373GYaDwyo6rIuxcucDSxVXRmf+2qbB9Ys68UJ8Xq6Eou5zRzs26aQV4HGAWPTR5tT2BRvZP8ejy+u66iEPuSIzYuimjtr8Zx0qTRwiiqUm589zQ0H9NiQLoY5tsPTj42YbodSlCsV5e1xqpS9OECFOjgnC0dCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402122; c=relaxed/simple;
	bh=1XF6AD6FgX0EcIAUnElpYVEtbVhqX7lj3lEZC9H5FOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQHQc/613sYxoH+bKRNX/jl6j6FKcmmgmErhnTnvh4u7pPFQ5GpLR9U4rK3BzIp4rCnZpej8mt9unc31kri3DOdmbe9lWMU7g6C/Q2foVpaG3xwb708F4fHM0zWmekeUxeP1wjvlBxDc9gicRYd9pAGtBFh4WIvFLzQMgu56Ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CSN6sTDL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5EBFD40E0252;
	Wed, 14 Jan 2026 14:48:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vomhRxTro08s; Wed, 14 Jan 2026 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768402114; bh=zTu4sFRT4VAp8L8ZbQvDMDBAt0Mhc0440iOQtKu9gI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSN6sTDLcj8d+S7ATpYiFB+mwOouy5xSUPO+f7Un090vUtXe7V1K5wfMjas8omlhH
	 uf9eIbbSe297rDiok/DOsgTK2n/SFZet9zY92kRtfPAk3qCtXUvq0ROHB0aUk+ATRD
	 ybA5yWL3ILehUcaW/076IcNLNU0p7WgEvilEmdR0lmgInsIqlBsNqbAGj4OsnlO1cW
	 zK9mhzWykLrJS38LQGlD+wfx4wTnyDHA2VS7P7/TuNrVkqBxH4G5y8A7W4YEasF0WC
	 gCCkIRi1PlXmc4lIbZt4oNv/mVdECjzOi3YUTwe5qqSdHgwx/F0Ch6TPIFPVeEH1b4
	 f6/Tsw9x3Ufmxeoc89epn5UfvHM1+DMjwzNyrSoaC1n61uBL7PeU+IHQszLllj4bWX
	 DDQ4E2i2i0EYdBbgDDUX22w2xaTi3KCl+Ktzatdc6YWvo5ueoFy2j52pnIKn/yfbbj
	 +lqs7If9aStc3pa7HKjld4TPZrhFoniTkMtko+HHcnR2oxASfBRu3XnjeqsbDY8w7j
	 WuBg6xC4lk/u90ScjnGfJEBqdU57TjhqhTtyqNJ4mzwSwDE5aWkfdzMVo+u2Qwxn6N
	 0cZXdhxRCpG+/Bmjkv+Ojs4g4GJEkG8M77SNkDOeK542pVNZd4HQ5/VmAQ/8A3651/
	 nwSgXv+SEOlNN9gJrLtOopoo=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D982440E0028;
	Wed, 14 Jan 2026 14:48:20 +0000 (UTC)
Date: Wed, 14 Jan 2026 15:48:13 +0100
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
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <20260114144813.GCaWesrQ7zdEftdV87@fat_crate.local>
References: <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>

Ok,

I can repro in a guest here too:

[  316.791005] mce: [Hardware Error]: Machine check events logged
[  316.793836] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[  316.797398] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[  316.800013] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1768404431 SOCKET 0 APIC 0 microcode 800820d
[  628.086857] mce: [Hardware Error]: Machine check events logged
[  628.089625] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[  628.093156] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[  628.095739] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1768404743 SOCKET 0 APIC 0 microcode 800820d
[  939.382727] mce: [Hardware Error]: Machine check events logged
[  939.385593] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[  939.389194] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[  939.391690] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1768405054 SOCKET 0 APIC 0 microcode 800820d
[ 1250.678672] mce: [Hardware Error]: Machine check events logged
[ 1250.681584] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1250.685221] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1250.687786] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1768405365 SOCKET 0 APIC 0 microcode 800820d

Timestamps are consistent with the observation.

Now on to find what causes this. Even if we can't find the proper commit,
I guess testing 6.18 and 6.12 - the LTS kernels - should be good enough as to
backport a fix there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

