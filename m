Return-Path: <linux-edac+bounces-5627-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC76D1B007
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E7F307C4EC
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77B35EDD1;
	Tue, 13 Jan 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gmcuF6wC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765C35EDB3;
	Tue, 13 Jan 2026 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331652; cv=none; b=uGb92l6S5nb581vxo68lxMoYRQMizP+4TMkkQ4tyQtLQqqITnMYN9en7jPXljleIJMy/4g5MJPzcW0ZT2t5us0wzg6TZRUEGGsjKaJbeiNLx3ecwliW4QHCetozQxhMqtdeDxKcoYrtU+s6vC43RslTVrh9I6niwgWc+wU9T+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331652; c=relaxed/simple;
	bh=KR/2RFsoCaqXbnIhaRPNNIOdUW5NrKUQnHDDrfUgmyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtF2/soLkMGhmiUUXPvJTObjRBFIk3JgEFnO1CAzRRuMYeMXMgoaQgIsvrj3Mr+lYQtpn1035jcHK6WUWBoCVSUs+FUk4Z782G/TEWVf0zstYGbglww1ui1eDFxkQ1zPZuGKn/HClJU7OltCoNaw+HoZytSzWx4ohfxwga/X+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gmcuF6wC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB47340E00DA;
	Tue, 13 Jan 2026 19:14:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZKENDVnTJYPE; Tue, 13 Jan 2026 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768331645; bh=4m4mkC6zKzNu4oBsPYpsDhGTyg5r3br5+5pd7JT1W1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmcuF6wCnGtCqGI7tZVUCcN1rujcpT38eOLddyegNlk2SKz0gUhicL7pQI0L643Ko
	 mMuyVc9Op5zLGEV7Yl4JX3RHTDKrZpGhfVzVeS3XH4vPibLGlhcY7wISvfFKuBNax6
	 aBGze/S/ra2JfXAmfHWELcXYmujrtz1V0PkqNy2npZMeOJmf+dWcJrnHCnFLNkX1Yx
	 OUKQOeDR1LDmQ7E/mummSLYs72pBLSv2aVC+hlLoqgCd/Rtxug2U198bPnK/PuZkrN
	 RL6v5v5ODYA+NV2/1GEE3NSKDrNftJZ7+tjk6pBME2Gu6Wls5bp67rdg2Wb3FeAn/o
	 Z/Ad1B+75taJ323DF8hH+9DUfBu2Ul3eLkkqWLQQzjIVNG9S6qjICdnyDBsbqRis7q
	 thcqXiWqRcLdEK+Ja8BlY5oYmsX6IX070yYTZiDYdTpC5mqgwJWhTLCksnkFYlpqXS
	 1diEikjPeZGC0Ar546kzyVedbVgkq/NaAEcwgTN9s1mk7mgYoXgaxtRFdr77Efz+U9
	 l6TAa4YkxeoV9TzzLVJFbAlA33ttUV/xCtn6e87QLOEiiZVaPTlO+Vgfub1sf9r2WC
	 89aNsZkeiZnwJYF1CpK8Un00mugtVXKDt2yWkvIfNEnhcLZzt4bb7vc6Y9SfQYp6Mv
	 3AH2EVl6DGZkwrmtF4EfoPSQ=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 756B440E0194;
	Tue, 13 Jan 2026 19:13:52 +0000 (UTC)
Date: Tue, 13 Jan 2026 20:13:51 +0100
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
Message-ID: <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>

On Tue, Jan 13, 2026 at 08:55:08PM +0200, Nikolay Borisov wrote:
> tomorrow) I will send a patch that simply eliminates mce_notify_irq's call
> in mce_timer_fn. I.e that function should be called only from the early
> notifier.

You still need to know whether to halve the timeout or not. And that's that
mce_need_notify thing. And that gets called in the early notifier so it should
work.

However, it would be good to be able to bisect this and find a minimal fix to
backport...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

