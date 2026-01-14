Return-Path: <linux-edac+bounces-5643-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F44D1F34B
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C1D3008169
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B35273D66;
	Wed, 14 Jan 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DW49NZUs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8726ED45;
	Wed, 14 Jan 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398786; cv=none; b=eyjKA/6rOkC9beHFX+JhUXGuD0QkMr57xegvmpy3J7HOOBQ52sD5PDQjbIHEYhb7QxDO/u+YVQ3mnmb5Z717UYQLe6ySN+3+V+rXNYOyd5qp/82mvz0ro8dZPzCBHxHi2R9QzJT5YiIoc1oucOnrBh8ucJtUVWcpR1B1cY9pdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398786; c=relaxed/simple;
	bh=rx948T5Jz+TVd+cSxOjdAplVhAONiWlk6YRwlW1gpdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DteDeQ6qaUeOYN/KucS7YPuCI7DmPldE3B3Z4OKHD57i1FkhkzMi+m9+njIcHzpel3/bNuJYxUAbhL2HXsR2KmFd1gF3pZn9lfIsqHKqL2D1dF3y2rsSs2w5PZ0JL/J46UWNKm7ZradwH5T6PaWH+Wnd5hPcy42YKu36+TUTZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DW49NZUs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 74D0940E0252;
	Wed, 14 Jan 2026 13:53:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ketPsXLPb6C1; Wed, 14 Jan 2026 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768398778; bh=ck+RrjSbt/12Eho/ns9ep46kEJDpgXOyIIGXP+HmfTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DW49NZUsR5mh3Sz6vn7ADoE+HIGxX6iQorlhWS2lGhzRlnxHwvKGvCUfspnItbIim
	 JPTo4wGOExDqPGh154QFVxUwWyDfbd6bD/ZrBIuLCUPMGiZ1qlKZ4LjFASOS6FJGsm
	 VpXz+2+JlzXiUfGxOmWXeG4o1so3eoIzH/synpWCdHMvK24qALmZ5Xt+BWWG6DmSPA
	 hCVPPsadZQ9aS67KmGFt35z5JmasL7kqmJ+25JYHhOszbkISdufKftW3NIa7qzdHv7
	 KSQ+0nahFX927gBvtVo8fPBgxX4/KTWUncaUoOjPjlvFgNw/cm37d2BxtTr6CTBXHq
	 mClOOzZ0yuVovO2n0pb6H3Wq8mtFCBs8dZ5HGYuL+i9W5BL9EXkjIzxrbt0uthEjVE
	 oV9wLNOsY0PhG8fyb83HyKN7JJJQ3oP0RCcFtzaLE0P3fF8VBEWS16I5HCBXX/0Y5b
	 KGrcx08NcLCmOhNKFbEwDRHPM6+XV/Hr8DpMhddXkEj//qTDyWKYMxC0l09uropc95
	 AT6GE3oDS4x8Jx0UamNI9coYG7IdZTAqHLtLw6PD/0FnK4mVaG4bCkkzDxHJR6kn5A
	 NuUFR0JwE57Zx2h+EhxxG9sjvHYlIBRO6aN+ovRiqsuTbv6VpY37dzc70VkGmABGqY
	 NcLLb0ygJeDyRQ3rYnonuF58=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 292EF40E016A;
	Wed, 14 Jan 2026 13:52:45 +0000 (UTC)
Date: Wed, 14 Jan 2026 14:52:44 +0100
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
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <20260114135244.GBaWefrBAUkp0e4RAT@fat_crate.local>
References: <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <d2378cc7-d97e-4e8d-b1e7-af5ce3265d2e@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2378cc7-d97e-4e8d-b1e7-af5ce3265d2e@suse.com>

On Wed, Jan 14, 2026 at 08:17:50AM +0200, Nikolay Borisov wrote:
> so now mce_notify_irq() is not being called from the early notifier, i.e the
> callchain mc_poll_banks -> machine_check_poll -> mce_log no longer call
> mce_notify_irq() in the early notifier chain.

... which was the result of us moving this back'n'forth and refactoring it as
part of normal development. The thing is, that notification mechanism is
perhaps not needed there anymore, in favor of simply querying the gen pool.

But we'll see - needs more staring and injection.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

