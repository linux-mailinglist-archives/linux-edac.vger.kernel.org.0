Return-Path: <linux-edac+bounces-3486-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5829A7FB81
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 12:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF05A7A8C25
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8470267F49;
	Tue,  8 Apr 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PB+ziLz/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F7267F42;
	Tue,  8 Apr 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107277; cv=none; b=LinOkb2mYcubJWRKzf8kf+lntc2B2IUcBDdCRqy+/DPVxIlmyV2nZXrY+ybRlc66yAUeQ7REmMx7094D1+9qM5Wuzs7V3GgH+JbSwMPkK+gGVrg0JBQN59s9WrODcoJMblXWCyjXeECue2m4essuf9QQe+q809ObfhvkcLPg5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107277; c=relaxed/simple;
	bh=EE2UF08zeRk/Ooejon+VKCADk+3/i7Miu04z6sztAV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SthemAP7MOh1xnPMPLDaoNU2wFEgM4F+dvS9JeSvb1RIymncpmAaNZ6ABoXSH3lym2xchBDk1qpnywC320TQYUuw9dLEGNXB2w77uuwFxLzwRr3FTblKJfHAI/zDiQan6VDtGaFX6NJG72cPd3JbFGq4UeeKbRS7J5vICT3FyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PB+ziLz/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6592840E01A3;
	Tue,  8 Apr 2025 10:14:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GUgZhjc-BlNi; Tue,  8 Apr 2025 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744107266; bh=C/J1EjJ7A2FdZlT0Q97w7fOk3eqcu450z0d9UrY4baA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PB+ziLz/o5sQuzHWF5wcG7GJ3qOspUR0YFto//2KPG5kJ2V8W6aYJKpwoK8dB1s/D
	 gIynbVNJuH4D2gD3RkFIQupr6KrnWZfGpWduSy5Sk6hLkc+VyM2yNjUixJpJ0a/nzK
	 dAqvUXt00LUzwKlNq5yLI4yhVEkG2/b/DdDdwZfn8k4DEqiKogC9Xwq9jEqXUYHKKB
	 7fil83Wj1tQtl8VNf1mccdsf/k1Qn/2z1qYZdzoezk9BDXCFK30Yc60N+65mQMq7X2
	 AxlsolpE/l0zIzRJ6cm7f2pmCCBov9IPR+ajsc49RD9bGfpHAPc5A5YvtUXTYjGvoI
	 gk0Ucs0am2ooXQTs6PxANZ2bGJwKO1wuR88I0f44Cmy26gzTqQn217516MeGzKN8Xz
	 zIA/1V9KXFIbQTlXnNDUO+/mi4OdVBGGayq32kpPzuFaY25Vm7zcgOidv7QqB+Fmeo
	 imWXV5Sit10H4vHoEu56Kud74Xk50JhyY4khsPpcIr7+lQnL3Tjmcm7EKBh8QvPVqS
	 Ns8VWnz9/LrxLmOUtjgcjDuH1Jm/Ga+iyuwQ6C1c/R+feOzwN5/+n/Z5StBOfvYJYe
	 i2zqDWX1sO6ATAGuWE9TxlsQz4rz/NqzEO8zCXZCz+hcwRvuqVNczHwhnEbNVcCBRW
	 2L6jecd+dt3qpVfJf2FGuFd0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B41A640E019F;
	Tue,  8 Apr 2025 10:14:21 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:14:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Message-ID: <20250408101415.GEZ_T29wiuh-_sExlk@fat_crate.local>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
 <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
 <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
 <20250407151657.GA1948540@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407151657.GA1948540@yaz-khff2.amd.com>

On Mon, Apr 07, 2025 at 11:16:57AM -0400, Yazen Ghannam wrote:
> Okay, will do.

Yah, except that df_cfg crap needs an export now:

ERROR: modpost: "df_cfg" [drivers/ras/amd/fmpm.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1956: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Looking at the call chain how we land in that fpds_equal() in fmpm, can we
read out from the error records themselves that those are from MI300 and not
need df_cfg at all?

There's a struct mce here:

static void update_fru_record(struct fru_rec *rec, struct mce *m)

which has CPUID for example.

Otherwise we'll have to go back to your original thing if we're going to have
to export *something*...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

