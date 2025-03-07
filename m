Return-Path: <linux-edac+bounces-3312-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0EA5751A
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 23:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687F01896038
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 22:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8220CCCD;
	Fri,  7 Mar 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZybLeiGE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4018BC36;
	Fri,  7 Mar 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387641; cv=none; b=oNlQ4p+VRU53p+JCMGQATBsaaeD8zThxmHyhIFzzXsKTFj1I6yEs+/rORyCou1vjNXb7NT2vYIdMSws81z++wHwTb29UAT0/IGx4R4PuVrgJtVsHo71aEMF5/OANJJ0YlrLjJJsvc2U7W7pAmoeHJclp+BVk6YAEz4j5Ti+HeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387641; c=relaxed/simple;
	bh=z8yn6Neur/a8yMrAIf57LnMCYQzLcigU3C4z5s6El+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYxKU9J8Rw1LbVTscl3YzdK7UWfDu3ymRokTw1Qj5sytq0wsmv5KfUwcs1zYsmG77HP5KHnYQEHS34gHZETiZsLrUq7wfeVVsgg7+9Xz44s5XE4JIige0MpdGlCfaCpvRfnuXrT/zpFYkc53NK3FzbbWwhpCsBPNjbvOJPJDqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZybLeiGE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7928940E0214;
	Fri,  7 Mar 2025 22:47:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eNGvWaWz9nat; Fri,  7 Mar 2025 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741387631; bh=hUu5/rpMox0T3Vcm+1lPtdALgmUeb93/9iSEx9fEkY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZybLeiGEw0Hb+BRvk7jZ3m46EniCvZMNqQNelPB+hkkKltOCz3zBNy2WTYwR7eO6l
	 ufCAb22jgVbfC/9x31DbnQaCELgtqGGlZMEkP2soiyOyZsgHiEGgPJNH42zCTMT3zv
	 nsoVMC1KdL9KCjvDuGwpR+NnVQpjZCuWAFL1cxpKCkqKTy6Rt39/o/UiqoD1IxHSVF
	 H/HdyyVrw1u04MRYiDzIuHEZa0BFzraIrxQD5c4ayWPD2/mR992ChWziYuqo/ZuG88
	 xHiATgb9w3hKIy8Ibdov5MBuYtTjU0GuiW/cdHtXQwLwNou/25vLlmJlOSMgBugmzV
	 Fje5aIQnw8JZ3K4p51IcZqtq5cAadjvwfUwmmkzUW93G1uNpfPs0xP5e0M7w4xfFwU
	 hK912nyLouM8pgPTihrtN0JsV8ut0kTTCmiJxi9Aj+Tq+GR31asnuEEdshZOSy1uk8
	 muVZiVkZprEH4bkWPVm1hAM9d9pHi/OHcAGxZXfbCiV3a8l4cR9i2FrkX+HSslSwS7
	 ZlwFFPDhTILTT+jwlzlatf7tm1jjleV+n+7I62kEOo8Yl7LMlM11zrQ59IvyaElMUy
	 RG/q4vbLFSudiwuDmHlNu7Nh1FJqMcp7JuAgxIQA+6tl39KNNSzNMVWqOZ1YXVCS59
	 0VnqeOLkhuxQqFn3+diETrDc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A552540E015D;
	Fri,  7 Mar 2025 22:46:51 +0000 (UTC)
Date: Fri, 7 Mar 2025 23:46:45 +0100
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
Message-ID: <20250307224645.GKZ8t3VX5a5FhqNyZG@fat_crate.local>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
 <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
 <SJ1PR11MB6083654405F2721E5AA0C1F2FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083654405F2721E5AA0C1F2FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Mar 07, 2025 at 10:05:12PM +0000, Luck, Tony wrote:
> is_copy_from_user() decodes the instruction that took the trap. It looks for
> MOV, MOVZ and MOVS instructions to find the source address, and then
> checks whether that's user (< TASK_SIZE_MAX) or kernel.

You mean there's absolutely nothing else like, say, some epbf or some other
hackery we tend to do in the kernel (or we will do in the future) which won't
create the exact same two conditions:

- one of the three insns
- user mem read

and it would cause a recovery action.

Perhaps it still might be the proper thing to do even then but it does sound
fishy and unclean to me.

Nothing beats the explicit markup we had until recently...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

