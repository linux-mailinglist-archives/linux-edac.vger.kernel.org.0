Return-Path: <linux-edac+bounces-3195-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8810AA42F7D
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 22:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0F53B1EC5
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4D1DC9AA;
	Mon, 24 Feb 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IMYdPg76"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F461A2397;
	Mon, 24 Feb 2025 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433850; cv=none; b=HGNro5xLifZNQW43nDo5t+Ypm/uAJIEiR0hEVPEARrKNjheoNz9wUPdpZ/nekmh7oTRl+yDJyx6CVaGpxhx0+03zY3HN7osGK6Ein9bBaPBTQuQHUKEZZxHozg0vdPawapBFfqxUUhel1soBW7LbQuqUPn9DEvC4qdrgpxh8PT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433850; c=relaxed/simple;
	bh=Ma5pem/WzRHMmsu6qCQCUtXRlhLJJoLkXEfU9B0y+pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgOow68JUeQngq5WYXznhvQa0jNWEg1cWa3su8KPTschseS5D7h6ILuOTV69ON20YJEvYbkYnKC1yPOj7mTWZT/K8eKL83SpVBH7n8BpwfhQZcls1u9PmiMiMHgdYovaYUsTLZPkPJwhjPr/wLbAlBu46xiqcVHRfgv4pJo1Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IMYdPg76; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78E4E40E01B2;
	Mon, 24 Feb 2025 21:50:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0UtbYBCWaCP1; Mon, 24 Feb 2025 21:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740433836; bh=IBiSY8I0yRdORrcUhePsGnU14FqUW8tYtf0UXHbwTEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMYdPg76FPfiBY4mH52UhP63MaNp7Df/NIHmZlHpBdeuynYoF628p13zS9YBjnBwn
	 PNmGWF+0QxCY+QnxjV12BjnMI88RHY9oMwjsuVbEvnjUe/aHW5JE7Bmf/GE2n85DRs
	 faXTXHVhZfOVREqxRGDOFSM9z5D7iGmAI85iKXsfNSN85/bb8dPCLZiWRHHT64+DBr
	 eELaWVwPLyxHNv5rtjJ8h4wn5VRakJBwU46+kBpnezgbmk+q2JoiRzFfYaQC5SYi7e
	 /3kYy6uAc9oL8cp4SVMqWQr5GKlU2Y0146YKq2Ybk1eEySQaHQHeb8gEjbIgYOq7Rn
	 qq9PPpfdVyWRAWdIfNZF1n7L62whbU5k2vqnWdkxJc4zHOI+4+VvxJsaWFoe1IWQ0C
	 M2ndc/FouxTxqfYnBo/gk5eH1X/szMxmARANyrCeZjhXHtL/cJiT/JxSmDcBnUwvTW
	 EDQHdWwGlYafi5gsWVCHFaETBLJPF8Sjx8pvPaPjW33XOmUoQN1IpURKOPN+TlR1pv
	 2yElDZncrrC2IkDuPv8C8RZn5+bLVkslYbvHOATrh80QNFua3iysQ6rZWazKyZJ3ur
	 O6es0U+aCbpfu5uZq2zxUo6bcK2A6z4UzsLiroo+5+k1dOBowoYInWGH8Ka88H+kgK
	 b1FbOe1/DUoytlbc3w2aqPYI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5369A40E015F;
	Mon, 24 Feb 2025 21:50:19 +0000 (UTC)
Date: Mon, 24 Feb 2025 22:50:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
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
Message-ID: <20250224215013.GAZ7zplS6XmgL9h9w0@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
 <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Feb 20, 2025 at 05:50:14PM +0000, Luck, Tony wrote:
> Agreed. Shaui needs to harvest this thread to fill out the details in the commit
> messages.

Yap.

> There are probably other races. Two CPUs both take local #MC on the same page
> (maybe not all that rare in threaded processes ... or even with some hot code in 
> a shared library).

Yap, exactly. And I think there's nothing we can do - the hw is out there so
the sw needs to handle them cases correctly.

> Hmmm indeed. Needs some thought. Though failing to kill a process likely means
> it retries the access and comes right back to try again (without the race this time).

What happens if it fails to kill the process? It'll return to it, it'll try to
touch the faulty memory and raise another #MC? Right, I think so.


> > > On Intel that would mean not registering the notifier at all. What about AMD?
> > > Do you have similar races for MCE_DEFERRED_SEVERITY errors?
> >
> > Probably. Lemme ask around.

After talking to folks internally, yeah, I think we'll probably have a similar
thing. Haven't seen it happen yet.

> Linux tries to enable if LMCE is supported, but BIOS has veto power.
> See the bit in lmce_supported() that checks MSR_IA32_FEAT_CTL

I'm trying to educate our hw folks to not rely on OEM BIOS if possible. For
every chance I get. Otherwise you get crap like that and this is never getting
better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

