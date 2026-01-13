Return-Path: <linux-edac+bounces-5630-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C95D1B10F
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49518300287D
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C8361DAD;
	Tue, 13 Jan 2026 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ehS539lx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0209344036;
	Tue, 13 Jan 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332834; cv=none; b=gw26OwLWKekn9GHoF6eMY3XSY3BhZWsdmbmlWg8FUvzOgW6AfzfoC+fYXEz3sfeawSvQfHJlCk+5KoiT6wBZo7qFOy7CwDhHEA2LR//SsJaXAgHgsx4s996rYZNDTZIqXVBj33iDGHC6zZ26WhRbiciBg8nqcJeroE4uYlMpO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332834; c=relaxed/simple;
	bh=+suhEQmK+mNNZpQ159/qVc5TzsaCAcqMrNGLo7BTP5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbnqdQ4EJMtTWAuhBsmzmY5GD78QwByxh3WUlgCrjPTIwhXF56N0klVJg579iEyb9cnQYjp2C6FSNc2/q676oeGvbCvxCyMYCpGjG6/wacdrnFUFqpaOil0chGJCP1ge+HhjRkxmVGoGI9bCkLoRYJdJzPiVZ+QUkTBqVoUMaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ehS539lx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B39140E0252;
	Tue, 13 Jan 2026 19:33:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Cax_qcRjiY7j; Tue, 13 Jan 2026 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768332826; bh=HMdIkQWA5KMLKKyFH46EfzB1r1MyTeejgEDFo6ctSCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehS539lxCYTaLxmlQrCkij/kZGbeGONiC4Sf6TivEukjo6bjwOx2esfYhoq+6aqTD
	 Kkt++qGE1/7heNI3ABCeCEg4CwqH2RUbAVfNvunyMos5NN4HYwhd8bugt/4I5RWKaO
	 Op0C+RiCGCNAAvPPysCe6GR4y29C/Q4ycjOXa/2CCZIX1GoJhpEDZrlemmDuk5lEjn
	 23pqzb/1D2kk/Qz5gt2N801/Byr5OxqpxHquzX+fQJ++KgMsgcC8YuB/dvKc61vQmh
	 yiGIYsnCrQ5NCRb+y1St1OobMoo1a3tCw6J9ybtLNLRprrJeVhudGCW1mQs4tr0NAp
	 JHHiyMMW/zETA1jGw0lXuNRDZk8SwChK8bT2fkraPdmRmbfHzkHNtcW3dE8gcJdxs3
	 4l5Z38L3mmH+5HaflK4LHkCx0ltkdDhzUoPSlEYbdSCrijJyP3+LjI3sKh9WGNPIEP
	 +C6GG4poUogFcpGX726YzuR8OS+Mv0r04jUXbZj9UIvyQcNfUiUzu127PHVpb36icC
	 2HXFD/06K62vNdbAsrOR31iTcPk1y7pF8sOY0lNXvf+XKYkwtEQhgeVsmj9lIH8fB9
	 fFE1iR8vTraZz4BgIfd4KJDMNBWc4EDz2W5zGqXQGVdpIewSSv4SQPDKUrvv67ON/R
	 PkqernV7i4Fm1Rme0yVgQnOM=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B697240E0028;
	Tue, 13 Jan 2026 19:33:33 +0000 (UTC)
Date: Tue, 13 Jan 2026 20:33:27 +0100
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
Message-ID: <20260113193327.GCaWaeB1rp7HCFJBHV@fat_crate.local>
References: <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
 <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
 <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>

On Tue, Jan 13, 2026 at 09:25:19PM +0200, Nikolay Borisov wrote:
> mce_need_notify even now works just in the early notifier because it's set
> in mce_early_notifier() and subsequently reset in mce_notify_irq() which is
> called immediately after the set.

You still need to call something in mce_timer_fn() to know whether to halve
the interval or not.

I wonder if it would be better/cleaner if mce_early_notifier() halves the
interval and mce_timer_fn() just reads only the current interval value...
maybe that'll be less logic spread around...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

