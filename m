Return-Path: <linux-edac+bounces-3314-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D23A575F5
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 00:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C255189B398
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 23:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510F259CB4;
	Fri,  7 Mar 2025 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tu8aooUW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DD259C8D;
	Fri,  7 Mar 2025 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389786; cv=none; b=rJeVz2ngoFqqoKVAczJF4a2t68vgp+CTPz39dGK6VtYTHgw2tWg1ZjmHOHlpV8mbGFYuaEcPoq/VkIIr15CNpv6Dpy8MW/hSq5fxOqMwGxMcHmzeTp9lXEVJpBu3XNdF0aUpYy33csu0N9CxDQNW5NsLcOdclJXgkB+QxRaBGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389786; c=relaxed/simple;
	bh=7/gQ3HbuSuqtN6i8h3mG5ZDs7jaLScWhYY45wy09/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5+2Q9gpMUzsSML4j8DP5tjUIO2FIV6xx8FSvscxhv7c1JS5O6g0OS0oR+3lZVOgxa69gfSVGr4jcp+yyk32fvS0Jakpqq6JqQ5+3tSQmTPhJ2hIbKdmg7W822aiVOB26MYZbuim9gDrxiTv5kXUnuSX6z1TE4mj1Y7AEZyAzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Tu8aooUW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AAD5440E0214;
	Fri,  7 Mar 2025 23:23:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h6sG7pYvhxPJ; Fri,  7 Mar 2025 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741389775; bh=wGVPAUm3Qc/F7uwCHOkqJSNfQnzu0aCNZGr8H8HENwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu8aooUW9vK0UyLhWBbazvOuzUyemT2UWN0TvRam0qdEfDDmGxQ4dSmND5fsqRqSM
	 H9/6Eh/MThLEDfkO5MLPPhYS5iosM1OYoBu4SqdlWkBvzNlOnQqyCaQi2a/Wh+xXGA
	 ZNRBLnu1Vnakh5m0/4GIYCP9arX0BUKpRfCR+j6o6oduGWioXwRx0641br4JRfLMbH
	 RnUQ7i4U6BLKAB/3SrNHsdaG5LtA1kqRS38rpqM79JferqtTAqE0txJlPzYBuDg9gR
	 BAslESc6lz67x2V4RcziroNi8WFIjczvbUz9k674g/KFvfxxO9gD37We7zPdlGuEcB
	 llw1/OGGzbK95suyJ1VFKZPGx8Xf9JMn8snmdGVKjirWX11ysvr7ukNoefBLexEiye
	 dIzRSVNsCcDDFLK5quhAx0oZUcoog1dqosnrYzK/ceGbEsgH0Q6BmrLaULe3BP6CJa
	 0pLPv5JsCoL4Zjy1yYiQbFUhVsDC+tYaQapEuGawLnmkeZoycfcXxrx+suQ6QstCbT
	 Mz/SvIUplte6GMl3eeoRVZKX7H1NQ18/ynFANVEhLF1Memwn3UgJhUH4PX0glBArbX
	 Tea/7Ogy7dJ4PkmqNzNWxSuhuVHYbcUILv0XIJCdCLKLwHPaiZyePHOJ8/yFT8jWJ4
	 R++D1jBK7l7Jfkql26Llqf5w=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4BC9B40E016E;
	Fri,  7 Mar 2025 23:22:36 +0000 (UTC)
Date: Sat, 8 Mar 2025 00:22:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Message-ID: <20250307232230.GMZ8t_tja324AQqYME@fat_crate.local>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
 <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
 <SJ1PR11MB6083654405F2721E5AA0C1F2FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250307224645.GKZ8t3VX5a5FhqNyZG@fat_crate.local>
 <SJ1PR11MB6083223A3175F7A84EC4DDDFFCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083223A3175F7A84EC4DDDFFCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Mar 07, 2025 at 11:11:26PM +0000, Luck, Tony wrote:
> As for "explicit markup" I don't think it would be better to decorate
> every get_user() and copy_from_user() with some "this one can
> recover from #MC" 

I don't mean every function - I mean what we had there with EX_TYPE_UACCESS.
That is explicit and unambiguous. Proving that is_copy_from_user() is always
correct is a lot harder.

> Note also that "what we had recently" was fragile, broke, and resulted
> in this regression.

Because those exception types got renamed? Oh well, that should've been
reverted actually but no one involved realized that MCE is using those.

And I'm not saying this is the only way to solve this. We could do something
like collecting all addresses on which an MCE can be recoverable, for example.
We haven't considered it that important... yet.

Looks like we're going to try this new is_copy_from_user() thing now and then
see where it gets us.

So, after the commit message has been fixed:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

I'm presuming, this is going through akpm...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

