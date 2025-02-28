Return-Path: <linux-edac+bounces-3239-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A799A49974
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 13:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1236D17262A
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299426D5B8;
	Fri, 28 Feb 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pgtwn2pA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAE26B2C7;
	Fri, 28 Feb 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746184; cv=none; b=euKnYNNUN9Ddz87hygiCIYau4GIkxKUw9DuSXBVG8FxkMnh0kf4+QEoBqw9y8DLkanYJg4s2/xrc5Zs1nS0abLquyHcLocKEuDD2LJeyvsozYW8vBzimirs31W2XYoihuVtXSJArB1M7ChuIKsdCcQlpejTY/OFIuW8tWfcUqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746184; c=relaxed/simple;
	bh=vqeog+EN2bX2aiWpmGWUlXtzaHOGY/1W8MBz3Y+xE9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+dzytBGNalIP90g2pBd8Z3zqSGYvQLSAewaUzg7xmNzsQLtCJs+cP8C571vCozR6MykbT5Y7nySGCwKuUjS89QY8ga56aYcTm7jBuIlJXuGB7EFY5b6/OgEMmgPrQhv3J2MAsZXG0CNV/6hLATEX0hYpsQjwlvkp73vzK+jfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pgtwn2pA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BF5240E019C;
	Fri, 28 Feb 2025 12:36:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uOzTg9OTRRke; Fri, 28 Feb 2025 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740746172; bh=d+7iCbD0MH0JfF7vpzIrnQ9Kowm4mXHLEaQ+b3Y1JW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pgtwn2pATXop2a1wTMZOHoaew/0IWEdw+UF3Gi3IU1DIikK1PEEwf5hVO4oeipGg7
	 XmNGGY+i2vFCZv9If6kr95/s7kla8sK1iUuq4EsirI0ILx0M2PLf9t8Qg73NRAthVX
	 uLSK3im8fc+b0n/opXcTomYpm4Fb0FYZpaSXsYqYg2sybySSDlh+cgpUfACH1c8Qnd
	 JFOW4bFkNgHFHtWDbBlT1Vq2NmW8G6fYco+XDegjUGgW7pxXHooV3SPEy5y7X+wJmb
	 GHOesh+t3ouh0hbXb45PmwfGPQH/qSQZIQ0S9LRv5u2gYgx2mNzbhFGGvCCIC+ac8e
	 R9NbR+KxQSHZAbcpVBbwZXKadgzE2NYn4iR02ii7gd1c0EArqUSn6S07dLEeX23cF0
	 eehBexVXcfiqiPiXdJoRoDVluaKPTlReGO8HYLh9ZrWSLqCM4z2WJrMPQa07qIcBC7
	 8d6lrC65MoFZGTSCocHXQfHA3PxhpzKCfA8dm3TaeaplRRHXOQEOgMByvgeUWqjQlQ
	 EueZDnaqpF9feZR50wMCZ6Vrhib7nVVvN9UXSlqCFrcx/bWz9uFz11BAZY0j7WDxdd
	 kmEQBj7WGnXyL+ecGs1gqKi+brXm/U/XEm/49yfaZeqP6bUCCc3iwBBVYCkUsb8sxm
	 WZBTA8XXkjWauC1sLzFvRvlQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B73F440E0173;
	Fri, 28 Feb 2025 12:35:54 +0000 (UTC)
Date: Fri, 28 Feb 2025 13:35:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250228123553.GCZ8GtqbSq9kaYOaCi@fat_crate.local>
References: <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
 <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4e13bef2-7402-4f75-8f0c-4a3cc210c5a6@linux.alibaba.com>
 <20250224220146.GBZ7zsSnXLftyqWzW_@fat_crate.local>
 <6f34c17c-4113-46d9-aa66-53ff5a1feed5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f34c17c-4113-46d9-aa66-53ff5a1feed5@linux.alibaba.com>

On Tue, Feb 25, 2025 at 09:51:25AM +0800, Shuai Xue wrote:
> It depends on the forked process which trying to read the poison.

And? Can you try creating more processes and see what happens then?

> IMHO, we should send a SIGBUS signal to the processes running on the CPUs that
> detect a memory error for dirty page, which is the current behavior in the
> memory_failure.

And for all those other processes which do get to see the already
poisoned/clean page, they should continue on their merry way instead of
getting killed by a SIGBUS?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

