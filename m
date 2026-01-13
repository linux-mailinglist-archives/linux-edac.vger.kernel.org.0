Return-Path: <linux-edac+bounces-5623-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD26D18FAA
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 13:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4B253000931
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72538F24F;
	Tue, 13 Jan 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S7lONlaE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270538F235;
	Tue, 13 Jan 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308544; cv=none; b=cDlhidsq++mpAwZlHump2IlyiGOsvWTWO9bGOPSt4IkKgsmwtnl534XJ/Rs52JDgyopt7vilGhQ195mb55IPQKuE7blThITkKK3Uitk+eShfMds0LstDgpY3OW9H4JRlq/zUjEScWBEW0T0eAAlLqmsFSfJUZxz2Mi6Y5t6wcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308544; c=relaxed/simple;
	bh=W9EYSMaWf3P7R7jwGNtnxDK/wvtmWC5ZPPu8E8Gg5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPcKxOk/+37QSvd57dGyh9z/w0XqgrFLGrotUOEqWOnB6/Q2ak7R87AyRU2EuZdODjZ91yY8YMmPOszLsJimiPEWtJ3mJY2TKWvvKoXY7Eet/XGKNVbpJc6dUVPFMmpJtnL/XqMqb+4AjSdEqmbbNe0vGUG1lckwLPzYKsAfDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S7lONlaE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 19C1140E0028;
	Tue, 13 Jan 2026 12:49:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IbkckdSRuIwt; Tue, 13 Jan 2026 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768308536; bh=DSQImvFF2bXni4juahaD+IhH1AipC3jgWAa7nC5dzOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7lONlaEJBXHIYUP59I5stPybnyjrWLTgPBNnjgMLzL5dRwpQfjEuf6gnBri1rFze
	 r/LiB/clqnHvptslamj/z7vSfYz0cVPipIv2a8dj+/8HLMxRGCmUFevDKHBoptPUo/
	 EL6UZrlfrSJmmRJ/M0bE9q27FYNJ4tNi1++wc2PdIEqMjM93k03OArzA5Bptev3yhs
	 qQzd8as7saN15j8ldAfIiOPPWeF0YJj0hcdLt6GTPGgPfEpGXvzJV9b/pCUpIsFlmA
	 QoNfLoWeOF9G5PQ0nZBFZKaxGzs885d2N4ZIWkY9LTAOdgtU/DXPBIfsWLUDmQ5tA8
	 eDsIPqQpS7ib/hjioswNPV2SoFSwEvYqSB/Vr3GTAzz04EL2FttusAwryCZhtd0l19
	 Gyad3iQnRjnbW+Hl5zsaqlloJ+H3EEncBMYixBT8FI2htdnEF4oxLO+QYxWeBXGHRD
	 LQ4eLQE7KK3y9yM0pZwgUILQwMwH2s8xguviyM3ejYOEdU752itRGD9F8a67XklQal
	 wGQ046OdmnoxqRulYpx9nBcBWVRk9oTG5zLODPKCMKM+BsZqaEGavKbXu3PYT8izeR
	 9pSuA1dJ3iBNl4kEgAbjhm5VSanbW4WGtIP7TJ/GC18CZdLPBh3tKCoTMX2C8Ok8z0
	 reUg6ZBhorcpEX2mx6eGds4w=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id ABA5B40E01A9;
	Tue, 13 Jan 2026 12:48:43 +0000 (UTC)
Date: Tue, 13 Jan 2026 13:48:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNl?=
 =?utf-8?Q?=3A?= Fix timer interval adjustment after logging a MCE event
Message-ID: <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>

On Tue, Jan 13, 2026 at 12:37:02PM +0000, Li,Rongqing wrote:
> The comment in mce_timer_fn says to adjust the polling interval, but
> I notice the kernel log always shows an MCE log every 5 minutes. Is this
> normal?

Use git annotate to figure out which patch added this comment and in context
of what and that'll tell you why.

As to the 5 minutes, look at how the check interval gets established.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

