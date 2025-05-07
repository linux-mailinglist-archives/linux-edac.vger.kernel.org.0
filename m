Return-Path: <linux-edac+bounces-3857-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C8AAEC3E
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0991E4A7B9F
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE728E58A;
	Wed,  7 May 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KC6LJOcf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CE28E570;
	Wed,  7 May 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646565; cv=none; b=Z+jNKD3MBOVbzkwIk6nYFPRPJDIcucyg/d8s+4oDMVGyAYkUDAQ4ZPLkWi0RBXyGTY/k2ZNw/KBiWxCWkwGMff1ypTq6WBQdVUo3AxXmsocxbgX6WAVwENOUb45aTG8tDcoLcWDwUMaIQUscMlEEz1Tm/wVsv3MBclf1Do7sDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646565; c=relaxed/simple;
	bh=iGvi/yqa0wbn0CkanjM0OCae1/tSLVv3/DLoooCpJUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp3DSdIJhxVRv+RNgJm1O1tKfIcYg08RNbO+ZcNS4dNfDhD67ikqyLsyWSaVg1Co6V71/cFz3adPkeq+DV65lAk1WnU10Oxb1dKGW7grLucUZe6UF7tojyb8D/g7P3XVfxYTdUxqSbt3zo136X/vZujoaO0dHYEbM7ciBl981nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KC6LJOcf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C71440E01FA;
	Wed,  7 May 2025 19:35:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dcXQVQhjsy8q; Wed,  7 May 2025 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746646554; bh=Mr4i9nDPNN2ozb4bNdmXhguhPiB4LmuNAw2Fv4Z0jHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KC6LJOcf+XT1CL4Ubts4m2wTVfr5/cHmkGNIfBKMBuaWZgwq2/rgPJR5laenWjWfz
	 NDnG6tvEtss9We5IGPtkcKzsgsNyv8+MsLmQ8cz3TqRHScjBUqwaO/lGvC1oCxG4uM
	 Xsc9wR+rAQh2Eleu6jSGjLpKUi94AIIpMzYrXGJFN38mKgOKKR6HkBjAuBNIJkj3y7
	 pKiIZaRPAnaZVL4uK3zodX5BXYAeDdYDhUCt1pyY09CsnkZgOYVLhKkczibAXzPmsP
	 2h23SlP/1BKP5yU4ZDTkVw7W+adWlsO8fVSVchPc11WfpZ0xdbdAXaPtCOrrcEtA8l
	 uEiMh9vzDMp4n1HuP9yMwlgUbRw0O5nT6Vmx3MI9ababD+pBhftfYEitqGc1pLW+YF
	 IHPRHCuSmai2SvpSith9lND1OJMuWCFO6EUCGErkmH3aWkatHcXYgWnt0nRoa8UC5x
	 w59Kuhb+k45JQcFVe9oGBFTRciFQXGL+2Ns77g3DsOXNc8W0yhXkmrXi+WIdP46W77
	 k1xuK5WHjUhOK5S+lyj2OH+mEB/N1Yy46BOkaXxlfemCVeWS+8TSghBwHDEzb+G7KK
	 vL3BcHKQSbzuEX6LFxXUsSNsgrO91+q8BJ9FTIsxoP2b87rTCUj44sSeenovpf+Lpn
	 7Ru2aPiKaQJSTu0K2+Dmp29Q=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BC9B40E01ED;
	Wed,  7 May 2025 19:35:47 +0000 (UTC)
Date: Wed, 7 May 2025 21:35:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 14/17] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250507193539.GPaBu2C_Gt7ksvRHoc@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:09PM +0000, Yazen Ghannam wrote:
> -static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
> -{
> -	u32 low = 0, high = 0;
> -	int def_offset = -1, def_new;
> -
> -	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
> -		return;
> -
> -	def_new = (low & MASK_DEF_LVTOFF) >> 4;
> -	if (!(low & MASK_DEF_LVTOFF)) {
> -		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");

I'm not sure why it is ok to remove that one.

/me goes and digs into lore...

Here's why we did it back then:

https://lore.kernel.org/all/5547906E.3060701@amd.com/

and apparently that was for some bulldozer BIOS.

How can we trust Zen BIOS all of a sudden?

;-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

