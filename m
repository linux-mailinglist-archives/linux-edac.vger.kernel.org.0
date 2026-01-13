Return-Path: <linux-edac+bounces-5635-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F54D1B3B7
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 21:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D357C3029C50
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D9296BBC;
	Tue, 13 Jan 2026 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XyAphBzm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9225487C;
	Tue, 13 Jan 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336464; cv=none; b=Eb+lzSyiZXjaBsKFS6f7daGTKwbQToU4dbzsUdVLYInhJ7DxTpCgMCRvx1beXzxKwpThfWRlPQ4fxOhy9jckjc138HzguaJ9xkscT36+x5YiMUwkiwn52CRGZO/TuxIl+qXf75f3Cy7SxZUPwIYe+kaCIzwXJPK048HNe2bsDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336464; c=relaxed/simple;
	bh=uM7lb1Lhg2xsGpuzv2gh3i8yAy1Fts8PwzduksYmGR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvBGjdL/Wd4oYTtLljp4zJSkTRAETdCqGhMMtD12xKGGzYE3xdoCWUmqtZ/EoVUsIzicbD++akiyZG9GboQpSOnnWsuyAVoNXO0URSlZalqjXOt76e8wWsq1CzJCaIThn3bW4OLLpZWKAe2/Xk1Zt4Wx4DsjvfguS6yKBZgprXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XyAphBzm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D890040E01A9;
	Tue, 13 Jan 2026 20:34:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4HKZ81ApE-p0; Tue, 13 Jan 2026 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768336456; bh=9hnWAZpBPtmJiZ0JqDBGcs/eGI86/EXb4KkWV8JsgIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyAphBzm4mHPgjeyn/Sn6BxRd67vPmjQCvT/E+Jl7DZVG9L6pT7/YkG1GRYx6P7L0
	 wHlTlEbuuwd7R3wdHcuHbs3JpBjqsBpplNBdTYDyQaM0qLIdUKtwrfgphlCazu1Ocn
	 sEM7VcQVz0/jKMO/OB+U3yEuOnGr+k1t2XbKxVRTgdDEqKRL+EXeLyHfWazWhLU3xE
	 RrC2k/a9zqzl45eY7zJ1RoWWz+jw3E279kZkT1RRTYsXMM5QZPXsvX8u48sdn4Hekw
	 VVHhsPlI+kVw0jQB/AbPNSzQyJjg/EbT6w9r+qxFpYtOtL5DMfE3PDoeXY61qucUhP
	 +mdyKFQPg82K7RbljDRVd2pUMqLy98VxB9cCn9upF0Y1BGF21rAx3xtj0150sXbwoo
	 iVAltlKuaUKuepvJhdICmwLT1FDghdYzsLdTmaIlH0Ct2Z8qeenq6A1rLLVjqOAN1x
	 KvK2co43LC3DW0sTRwSORPVViwY3Kn6alAVlIke5lqI2ZpeGhO2WVyIxPHlT4lKDAX
	 fmNAcnYTxSSgFRy+LsbVV6Bu23XMy67cOLAFtmkJ4cOvLPTtrHawwVPrjxNv8/7srZ
	 nChbTA75CfYuYsQTOAeOmj28whmUEKUDyqQ7HYAkr/HdkkbGVYVr5nNlrF4E4r9ivA
	 C9BdvzRrXEVw5caioR/p5JwY=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BA5ED40E00DA;
	Tue, 13 Jan 2026 20:34:02 +0000 (UTC)
Date: Tue, 13 Jan 2026 21:33:56 +0100
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
Message-ID: <20260113203356.GSaWasNAQZ7sN9vMbt@fat_crate.local>
References: <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
 <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
 <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>
 <20260113193327.GCaWaeB1rp7HCFJBHV@fat_crate.local>
 <c425bc04-2b01-4616-a244-01c896367f7a@suse.com>
 <20260113194438.GRaWagpmRGD0qGx9az@fat_crate.local>
 <dd23220f-d023-4e95-a1b4-d8e67ed6b777@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd23220f-d023-4e95-a1b4-d8e67ed6b777@suse.com>

On Tue, Jan 13, 2026 at 09:51:48PM +0200, Nikolay Borisov wrote:
> grepping around points to your 011d82611172 ("RAS: Add a Corrected Errors
> Collector"). Because looking at the commit log of my 6447828875b7
> ("x86/mce/inject: Remove call to mce_notify_irq()") I mention that
> mce_need_notify got introduced in your commit and it was called
> "notify_user" before that. Before your commit in mce_log there was an
> explicit set_bit(mce_need_notify) call .

It was removed there so that it doesn't issue the

	"Machine check events logged\n"

thing because that's the main point of the error collector - to collect errors
in the background and not upset users.

Also, there's an explicit set_bit(mce_need_notify) call in the early notifier.
So it'll get set a bit later, when the notifier chain goes.

But that same notifier does:

        set_bit(0, &mce_need_notify);
	mce_notify_irq();

so it'll clear that bit immediately.

Which means, the timer would probably never see the need_notify thing and thus
won't halve.

Which begs the question: is the timer even supposed to halve when you have the
error collector?

I guess so - we need it to log errors faster because the assumption is that
you'll be getting more errors so you need to read them out faster.

I need to think about it tomorrow on a clear head...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

