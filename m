Return-Path: <linux-edac+bounces-3248-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8DEA4B052
	for <lists+linux-edac@lfdr.de>; Sun,  2 Mar 2025 08:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26449188DB54
	for <lists+linux-edac@lfdr.de>; Sun,  2 Mar 2025 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22831C07F6;
	Sun,  2 Mar 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A5ubEaUT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B319E975;
	Sun,  2 Mar 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740901062; cv=none; b=cF26gu3x5la5GKQGFB+8zJb5QvykNGA2Sj0yvO9cEe+Sl8M7kNJKWvielMOsGRjMwAlmxsz1tBD/J1igHiFjP1XFFS09Y6MGZurtT5CUF7knteK8AxG3H1S0e4Xtn7ghZxrZjMfnUApm7de1yQVWxaCpPF0Xug/k50Df9n8E9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740901062; c=relaxed/simple;
	bh=92MGtq4af+2oJ4h5iacLvgrg799a/yE6xZR1BWi7nIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaPrkkelOzxLVTjjSTi/uD2Yf6aVakgi/XzpPo7/cbfsVcrKV0E88hKnKxiXNuHGwdYa9WDr/mZ+rRU2KB17EUzndo1JK0H6JWw+1AWVbqYT0mz/5XCfUwWa+3HDHiBviwslPZqmbvPaSiPZzTWmBUHBXRuqip3gDSlVKthgQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A5ubEaUT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE5C840E0028;
	Sun,  2 Mar 2025 07:37:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K7qtjfjV_nbV; Sun,  2 Mar 2025 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740901053; bh=3RRSAwyZWiDNNLw652ghqQMd9qWVbqbg8VXb/XS0Es8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5ubEaUT1g9knPBjpX6GySLnLJthV7JvPUU2C70Pe1yOrpi7RfvNwIxVofcCmmRmR
	 68ekAAFo0OaIY5q+3RrkFMsvgJ1f2t7N1dgzpKFocJNzoiRTTmxNQkX+QMixJ0MlDT
	 QEvbBrA01viQfLed51Bc+teilQAwmbfCRt8yEI4/22kv8P+mYA/bRWCxTQT9FlfJ4N
	 0qenyj9KZMy7rbLo+L6VNtab+Kx/rkq8xvCLDeivxkErUE+LMCH9utUS/DYGX+BmKP
	 cpACSlP+HrdiJqOoj/KAUigrUgf5Xt4JMNV88iWoiy1FJ+LHgo2/5FCLguWVtTamEN
	 nQetzKuuTQFAPfbZ9Yco8Y34ZNqLuOrV6tIP0loiRVEhqLbqckCgIJ189tp3NuuMw2
	 5MGxXCoVonFlbcL9SD1RZ1kGeJMLxnQWsgZnmayW/ST/RgDRYdNuUP2ZZMm7VwU2+V
	 0kl9MHWp7cZeqLEIrWhoyh4g+XZQx8FfbHxnK/3AZFq2KVku48BUfsrwDOSZi5lAEo
	 qKjuWTiYlh94b30h1V7TGo8qLrxhhe0QW1Gcut89CfJt4AOSbjI4Umy2Bn0okr+ZTB
	 0OFuvjQ9EgDiA4ZyL1GIPnsjsDAOAZZiuGXrqNC9j2+EgYW2IZTBpQkjsypKDCvJ97
	 ItjZY6z1ASSHIZu2j4psmzOM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5795640E015F;
	Sun,  2 Mar 2025 07:37:16 +0000 (UTC)
Date: Sun, 2 Mar 2025 08:37:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, nao.horiguchi@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linmiaohe@huawei.com,
	akpm@linux-foundation.org, peterz@infradead.org,
	jpoimboe@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
Message-ID: <20250302073711.GBZ8QKp1QstGaVGqBR@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
 <7eddced6-bf45-44c8-abbf-7d0d541511ab@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7eddced6-bf45-44c8-abbf-7d0d541511ab@linux.alibaba.com>

On Sun, Mar 02, 2025 at 03:14:52PM +0800, Shuai Xue wrote:
> > >      "mce: Uncorrected hardware memory error in user-access at 3b116c400"
> 
> It is the current message in kill_me_maybe(), not added by me.

Doesn't change the fact that it is not really helpful when it comes to logging
all errors properly.

  [ Properly means using a structured log format with the tracepoint and not
    dumping it into dmesg. ]

And figuring out what hw is failing so that it can be replaced. No one has
come with a real need for making it better, more useful.

You're coming with what I think is such a need and I'm trying to explain to
you what needs to be done. But you want to feed your AI with dmesg and solve
it this way.

If you wanna do it right, we can talk. Otherwise, have fun.

> 3. We need to identify and implement potential improvements.
> 
> "mce: Uncorrected hardware memory error in user-access at 3b116c400"
> 
> is *nothing* but
> 
> "mce: Action required: data load in error recoverable area of kernel"
> 
> helps.

I don't think you've read what I wrote but that's ok. If you think it helps,
you can keep it in your kernels.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

