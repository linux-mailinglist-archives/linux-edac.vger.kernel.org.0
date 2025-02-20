Return-Path: <linux-edac+bounces-3169-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6AA3D87C
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 12:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9BA19C2BC5
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1F1F754C;
	Thu, 20 Feb 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V63tGo/W"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5E1F5420;
	Thu, 20 Feb 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050374; cv=none; b=CvQLia7Zpbyuoylmr0HBkUCXg1XNbgsndgEZAVI/k4Bpq0x46OAzI0ZZ0OsjYGll4MaHaqtGrErICZVzajsTk3PhePq7JQmlde40v4syXXJefGuvjUNpIUpssyL1eGI7rlmAdoJdvmFAklzVwzpl169KSCUwt+zkfrLT01knDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050374; c=relaxed/simple;
	bh=SKI57SFGIBpAzjwlBLSaZnpr4/XQhu5ZCNj+pgNqStM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EviaLE/2tL690MN0ge1DaGQDjzF+p/n93Nsis7TBtkwYJ6uO03OHAr9sxIJY+JU66DgACBsNfO4lUzgNPchgVM6svtjG5kIehx69DHCUNwaqceipOCEGp2EyZZMImQP1rK0c+ZRXndM7yiaU+l7ZVmnAM3hMrccc4HmDWHx37io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V63tGo/W; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 92A6140E0177;
	Thu, 20 Feb 2025 11:19:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bcZMN1EI5MuF; Thu, 20 Feb 2025 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740050365; bh=oDN5WUS3A7D2IMAxJ5mGAyDsc5KuNgF5Rt5+F6hzIE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V63tGo/WIO8oyP5lcHu/Lr6YRBigqKI9sffiBGW0bu3QvI2bL9CuKwfK9fgrw2KFM
	 UkPn/wU2v3PB6PJKkvQKn9dHJEHe0UIoCm0KMEa24mmHo1dcxhHb8ya5uIV43ZXqrQ
	 +4nRPsNv09gYhuVExneeg+NmnvQfGKjZl9hqmFMPrWvuhh6HgCC4KWLHIEm0fuXjwH
	 EadCpw46Kf775EQiPVhmndleG/Nxakr1idzT0EMHQfxxDmC9Lk+VXXjz9KD1S47fVi
	 XuzDMCUGBzTgqzjHP4p66FvMuf13m1eX+3yXQppgBrqKw3Eg4+ZCgyx6ZZ0CpBPji3
	 J3VTLhKK5yH4PRhxF0NimWrdO0RkIJYInb/OEue7bOlzuut0xbXxpps7JhzbmBLDdZ
	 9197w7bq9ahTFRzc8D0BvlI0OQqS1f6UprZpnSd3Kss2iGdYZNv+KxI5/1tm4sxl+D
	 p7T1mAnVwHqzXPk+m/7JddB2GIkmwhLN6amYTVj2EuSZqq0sBniaBIRE38hQ4en+wc
	 aZB1LnQH9comphR3c+FSS/J1SK6ryXyl7PZ2amSQxI4W4diQTlP5VuPvjSBDJQEwAs
	 pTSK8cpnY2ZJ57QmjHqtijK6p/NaZ23+c4VrtVtuCPYsSt40qoA8d4oMUCiXbxO/z3
	 P6gviHsb06gI5JT7Tx9xI3Dc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA0640E01A1;
	Thu, 20 Feb 2025 11:19:08 +0000 (UTC)
Date: Thu, 20 Feb 2025 12:19:03 +0100
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
Message-ID: <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Wed, Feb 19, 2025 at 05:11:00PM +0000, Luck, Tony wrote:
> We could, but I don't like it much. By taking the page offline from the relatively
> kind environment of a regular interrupt, we often avoid taking a machine check
> (which is an unfriendly environment for software).

Right.

> We could make the action in uc_decode_notifier() configurable. Default=off
> but with a command line option to enable for systems that are stuck with
> broadcast machine checks.

So we can figure that out during boot - no need for yet another cmdline
option.

It still doesn't fix the race and I'd like to fix that instead, in the optimal
case.

But looking at Shuai's patch, I guess fixing the reporting is fine too - we
need to fix the commit message to explain why this thing even happens.

I.e., basically what you wrote and Shuai could use that explanation to write
a commit message explaining what the situation is along with the background so
that when we go back to this later, we will actually know what is going on.

But looking at

  046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")

That thing was trying to fix the same reporting fail. Why didn't it do that?

Ooooh, now I see what the issue is. He doesn't want to kill the process which
gets the wrong SIGBUS. Maybe the commit title should've said that:

  mm/hwpoison: Do not send SIGBUS to processes with recovered clean pages

or so.

But how/why is that ok?

Are we confident that

+        * ret = 0 when poison page is a clean page and it's dropped, no
+        * SIGBUS is needed.

can *always* and *only* happen when there's a CMCI *and* a #MC race and the
CMCI has won the race?

Can memory poison return 0 there too, for another reason and we end up *not
killing* a process which we should have?

Hmmm.

> On Intel that would mean not registering the notifier at all. What about AMD?
> Do you have similar races for MCE_DEFERRED_SEVERITY errors?

Probably. Lemme ask around.

> [1] Some OEMs still do not enable LMCE in their BIOS.

Oh, ofc. Gotta love BIOS. They'll get the message when LMCE becomes obsolete,
trust me.

Are we force-enabling LMCE in this case when booting?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

