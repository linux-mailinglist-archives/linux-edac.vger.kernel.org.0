Return-Path: <linux-edac+bounces-1613-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6246945CAA
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF95B20C03
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C81DB44D;
	Fri,  2 Aug 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OS6hnlJQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115514AD38
	for <linux-edac@vger.kernel.org>; Fri,  2 Aug 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596284; cv=none; b=qkKkkWN3gnwIWRUeL2k8lzyU2r+IcqCvOBNdZPPOgxkNMbsAd2Gww7FIGnN4dHBdY5dfk8o7EU/LqSYGGF/74Iifwcv5o66YOw3ZHrWlZfaL6c5SShAir/P7BAmR0P+2aqEUG0YTJEKUJFWGFcUIem0q8WJg7c8Qrj+8e4wIK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596284; c=relaxed/simple;
	bh=ehPFeR3Cxg8YVt1lNntzKHWRLttKI4N5bexRVbXw43g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmCfTQ3pvo6uY6A2hF6HsKobo3RhqpPpD0l3lHaT7JSPQ7Yxhmcixtwy+U3KQoyNv4yK5EoBQr2dfs6CyfT97IsS3luJvw6tt+xWcSCmuXuLFWmKFx62Qs6objtIgU/NfoClsO4ji00i5ol5ZWBSj9G2EdNcIuU3fgMx90BuyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OS6hnlJQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3488840E01A2;
	Fri,  2 Aug 2024 10:57:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cQVyhS0miud8; Fri,  2 Aug 2024 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722596273; bh=j6LbGY+B4CXd5yUN7m9ynKkRzNAUoGkCjjnhvm9YR3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OS6hnlJQ6IFiLm9IsUhQ0GlQ4JOsD+OWGLWv1jITsUZETyDKLYqJyJz2kfx28ljls
	 NFVIrEvaVW73RfI/hrDit+Ct1lgl8z0iTyhH8dltmRSg4Y1OTcLZh8LwkN+hSbJR8x
	 Z01/vcjg4v2OwHip3AuKQO6zoxFcgfUhRwm2V+WTXWf63IUv+yBL1mmZAGiMhNba/P
	 Isa6C0ChhfIxnWQ5UmsRtlIlcbjCamRXjNJ093lT4tPu0eNnQtDKtDbgRrxqs6RUfR
	 n+yv6eO4eoImZmDuafL8+VEbgzaXufbpaHyRRImngHXLM1EGXZv3PY+QkR3EFTniwf
	 XemtfBXKbZcYQiZatxeY1p5L25loD0hU1wEuOMRkuejMaIJtXPGbBRqxFd2jYh5c7x
	 g4y8188fpiLoiltu97gjgqvoxrnAEEYK54l9ClekX6pZnVwMQGwYD9AtlaQEwcMH7j
	 QiOK0b09UH0E2LSzQ4uZL9jicncFVcJSYO5BFIvaISp1GdMef8U9azMy7IF7TsIduX
	 O0JiQsetRHaDFZCyx89mWhHEtevR8lp5qkxk9RoIbki7YxfXyGeTLfeY5FwvcfT0HT
	 bg1Yeojaj+vHNtHqd6gqv0InAV78C3w0qcfcamBr/CJIW2v1Thh1Gj3RWujoMUPufl
	 DrQlYNJKDrHJPGVgBXIOX8F4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0B9040E0169;
	Fri,  2 Aug 2024 10:57:47 +0000 (UTC)
Date: Fri, 2 Aug 2024 12:57:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Andres Valloud <ten@smallinteger.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: Re: Unrecognized MSR report
Message-ID: <20240802105742.GAZqy7ptiSmi7H8VHk@fat_crate.local>
References: <f5fab0e1-a6f3-4e53-a605-0aaf6d26ee3e@smallinteger.com>
 <20240726124232.GBZqOZuM0yue1Oak-A@fat_crate.local>
 <CY8PR11MB71343FB88D7F84EAD9D189E389B32@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71343FB88D7F84EAD9D189E389B32@CY8PR11MB7134.namprd11.prod.outlook.com>

On Fri, Aug 02, 2024 at 08:31:59AM +0000, Zhuo, Qiuxu wrote:
> I reproduced the kernel warning message above on an Intel SandyBridge,
> This was because of the default sys-node:
> 
>     /sys/module/msr/parameters/allow_writes == "default"
> 
> If I set this sys-node to
> 
>    /sys/module/msr/parameters/allow_writes = "on"
> 
> Then there was no such warning kernel message. 

Because poking at MSRs from userspace is a bad idea.

> Just a small concern: 
> 
> The commit 68299a42f842 was merged to kernel v5.11. 
> For kernels < v5.11 and w/o backporting this commit may still need the rasdaemon to
> wrmsr 0x17f to enable the additional error logging for these certain Intel CPUs.

What user runs an old kernel (< 5.11) with a new rasdaemon?

If there's a valid use case and they've backported stuff, then they can
backport the above commit too.

>  If get the rasdameon to write the sys-node as below before doing wrmsr 0x17f for these CPUs
>    
>       /sys/module/msr/parameters/allow_writes = "on"
> 
> Then there will be no such kernel warning message: 
> 
>        msr: Write to unrecognized MSR 0x17f by rasdaemon (pid: 24480).
> 
> @Borislav Petkov, if you think the fix above to the rasdaemon is acceptable, 
> I'll proceed to make a fix for rasdaemon. 

The goal is to stop poking at MSRs from userspace. And I've sent a patch
already.

What fix are you going to proceed with?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

