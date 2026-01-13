Return-Path: <linux-edac+bounces-5620-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF2D17BB6
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 10:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28543300E431
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEC0378D96;
	Tue, 13 Jan 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X+tPcfdi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9232E6BE;
	Tue, 13 Jan 2026 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297364; cv=none; b=uBlqKawVmKjKJ9pWpRFzKHPEwbEvvZ6zG5PjjHl3ubg+y0oZgOtP0I0G8hhMcdkw3tWCVmtStv4Ih6DHtWgSMED3rJS9WHCdxPNNBBZjAn7LWN9dgDvcAsDNVMsS0ejeJ1KBIez056n2N4VN2bUhRJQs3lKNCJ5LUwKfQn7b8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297364; c=relaxed/simple;
	bh=kXlHIa5MB7Z9vZDduzjFwJUxyOQuJOgWQIhFHUoTXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZZzZV1qRbdNQCKym4XVm0/m9z4HE8nvWyL3YdIc1RXjztBi11DtuTd9ecYqoKO2Jg/uf3lznC9bnMTzVUrh0Wyx3Y/b2aJCeWqv47CdPhZlWL7EXfxatMxSTBeixvKMt0dvP43XcYEIGAsdmJT6cTpvI9Ch2nypzjJ1W49Hvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X+tPcfdi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4492C40E0028;
	Tue, 13 Jan 2026 09:42:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1WBtjryyNfLT; Tue, 13 Jan 2026 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768297352; bh=qXnkmMg2/oAZnCbNIiqow5nAIHLg3mz3Z2alr4+kgjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+tPcfdi8SlgWzUBumbgcHC+XGGU/e/u6BRcvik/G6x+zRHm8kciPgsZ46Q9aBZn+
	 7oI+BJNxA6Fr9vUVFtuho0N1WAQWsuebDB7c4QbdLh9mc9INqXv0zdXZv7LWBPTwZz
	 KcdJKo5l79MO71Q+kktxdJgfmCpQ3+havlLC0/P9c9TP1mwjddKsHN0djndoezW5Q6
	 q5VsNOHVaeIfN0C1sYhMG7XllJwXsN6BSiUTdhj/q0V56VNw+Du33ChbbmppKZBuFV
	 DKKuSKTVPgPi+Yy/YiSXJR6Wpub+Tz0hGTLQriLmrlVcCffclU72MXGQ48x2xQeLWz
	 UTcuZ06rr/dVIMKoWB7lLTJGpnjZMTegPIhhd34SkQ/+q71CshIjnXW2uEx/mIvwB9
	 iOuQyEfpfLqrAX334JyfyzGsHicQ1tgLtKpatzU120rymSQibs5e2653+9FOh40Afa
	 6r0lr0d5Zaf9sPBpHaV04Nmdzfqvs8MegB4D1ghPxCgwUWzADlz3f4q9fhE5zSHFy1
	 gz92Rg9U32PtH5Zf6Kj3gwIwyRNSDRSyatkOURjAq8aTsy8rrgjuLpPpjVQFwKlKuB
	 +UhG6Subb7EVbop17MXvFvtoqXGW+CKT0yCMaamnNmuEKqIhYCYhwIQFdI7SRtfiO+
	 rcD4o1ZgfNE1SLPkP6lncAHs=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 37DF140E0194;
	Tue, 13 Jan 2026 09:41:56 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:41:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v14 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20260113094149.GAaWYTXf6qH4zleOOQ@fat_crate.local>
References: <20251209145742.297-1-shiju.jose@huawei.com>
 <20251209145742.297-2-shiju.jose@huawei.com>
 <20260112150552.GGaWUN0Ex8KgfqEEi5@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112150552.GGaWUN0Ex8KgfqEEi5@fat_crate.local>

On Mon, Jan 12, 2026 at 04:05:52PM +0100, Borislav Petkov wrote:
> Please go over all my review comments from here:
> 
> https://lore.kernel.org/r/20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local
> 
> and either incorporate them or say why you don't agree.
> 
> Ignoring them is NOT something you should do because this goes both ways.
> 
> Ignoring this submission now.

I take that back - I forgot that there was an in-flight review when you sent
your v14. Sorry.

So please incorporate *all* feedback and send a new version so that I can take
a look.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

