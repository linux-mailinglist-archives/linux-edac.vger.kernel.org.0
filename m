Return-Path: <linux-edac+bounces-5626-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5FD1AF82
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81560300B37A
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348A35C1B0;
	Tue, 13 Jan 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j3GIliOW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC435CB66;
	Tue, 13 Jan 2026 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331454; cv=none; b=SljruZFjKDoxsVNHR/GEMmOZYPYCgH0dgE6suFI+U0a3ojWlbNFvKRtv8/xAuiYNRTDITQCCTBiUSc9x/uqz3F/TXv+nDiCv1vvusEpvhuURmDFFMSJVR89Vyij2suH6sLIjZLeOOzvOIo+JHSkg6pSCv32j4RnyFuWOHx6NAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331454; c=relaxed/simple;
	bh=rfvaZsXoJkg9GhCEsRmF9PSzASaYS4WeKx4Ojq0Zsxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRLkXHaV8+nR3P9IQEF0w9rmCHStm18Cp6TnwiKKaUYDlkCpNHMcDoQsdATbYazsoU0tvJwizJi+4xrKBOQFGaZFGpKVJjTobltUg3eho68VXl8vybR59KxN2Rn4ogJkvMrNpVWsUoghiK6KUj4wcdteNod6i8+zCXlZSUjhR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j3GIliOW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5619F40E0252;
	Tue, 13 Jan 2026 19:10:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ucuKv19c5JDd; Tue, 13 Jan 2026 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768331446; bh=DWMABmtpRva1pIglOzVwP8nJrIR/VG7r84z1m2aNKuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3GIliOW/KKAxJOoignLczSXH8xTIQxfb+c0GcdT52m2FBJfSEs/cr4Maf9l2o/sV
	 doLuMYSwRxvScM2XKu3X8+A/UTyqXTHsDuZS7PhKAGOWX4ytu3GdTma7+EsqfOU0r3
	 pt02zRLzFzU9rhFSw0xeg4g8ZzamsD7UJmuuh96u6A/y+e1fDZdfTmj6AFOaoDDNEo
	 NIu0rhMlN5FsI2F0xibOocuNf0A5bLj1gZCmrUDnI8sgLQx1+uX00vIa4XMCR8wpi7
	 EdJYC9jPUZbGlVJTAOkrvVTf/H2z71458nCWgf79vTBIUWLs4SDKWnAhUkFW9DZ26e
	 SpKX0vuhqNP9LSi67uc5ndTE91H7lKwwYnYESfB9olNhUMH7lrFnAQIQJkJI0iYMsm
	 mmZCRv2QeWZ4WupMpJw+0gNcHuMTJh8Mbw6JbPeCIcV06EeDsID6JnliFd4mWwLfzM
	 A+3yhlE52Ari/sFuvxtkNtUsWB4I18S6ARGVURxij2hMA5l/15yg/IZHWWNWnA4uyS
	 a8WDTK4By8EeO+M8sNSFhu4pmt9ezwnPOchR6mQL5YDviT5b+RKSSO1MBTQcJn90Pe
	 vjgMZXU9/R0bkLjkQmDnWysKd2EUCp5PCGTVLSfJI2/0SGCucYeOevLDOiYQ3rLq1D
	 9PSsGINiRvyAyQ4rk+oIdDag=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B785C40E0028;
	Tue, 13 Jan 2026 19:10:33 +0000 (UTC)
Date: Tue, 13 Jan 2026 20:10:27 +0100
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
Message-ID: <20260113191027.GPaWaYo1CY0aMccJCI@fat_crate.local>
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
> Once upon a time the polling interval started out at 5 minutes, but the
> interval was halved each time an error was found (so interval went
> 150s, 75s, 37s, ... down to 1s). If no error was found, then the interval
> was doubled (going back up to 300s).
> 
> This is described in the comment:
> 
>         /*
>          * Alert userspace if needed. If we logged an MCE, reduce the polling
>          * interval, otherwise increase the polling interval.
>          */
> 
> It seems that the kernel isn't doing that today.

So the halving is not happening anymore because mce_notify_irq() is not
returning true.

I guess we botched that somewhere along the way...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

