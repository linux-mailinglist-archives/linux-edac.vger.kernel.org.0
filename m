Return-Path: <linux-edac+bounces-5621-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1678D17C5F
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 329DC3011011
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9CB387356;
	Tue, 13 Jan 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F9ZAAyHv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493130E0D1;
	Tue, 13 Jan 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297894; cv=none; b=mkRkWEFy33qTMTC4fV9a0+jo2qDKe498Q5YKup4SmBl/0biO3zYvk7AMgdGFL9YBD0ziNh09MqVqVzNTw4kLbTJjXWL3grvYeyB5CkGVfHEwbJFW6RwPoekaXcXP6e4hfBNryJIBSV8By1rQ+2X7fn64V6fO8QB98GSm6SYWOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297894; c=relaxed/simple;
	bh=y6i3joXJc+f68e9VBDttMO6i/uucDhpUK4oN3fo0Di8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM0CoKj9nYaMW+1Xe8r8g4GvnDccPSds1L2TM6j6kqg82faJdEqDdwsQK5f0VSxxVKE1GOaf891ZTPA4P8zi1QW0MkV796ZbeZIlWPdTIVBF87Wmab39dLt1w+P6N3ScadaV5Et1IQ8AbG9uyXam37t+G/Jzr9OYpF9+IVPkTCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F9ZAAyHv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 10C2240E01A9;
	Tue, 13 Jan 2026 09:51:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WqHwiCvCb9Gg; Tue, 13 Jan 2026 09:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768297885; bh=NYEQxSYs01Tp/7q3Ct7z0XjqVho4lr0UvnvdU79s9Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9ZAAyHv+IsRVCJDV3ox/6bYpxiaMTpoWmMohSWY9OuR2tQSwPyuB+OkFBvZq6jcR
	 bwHIvlQYuw9sCAurPnpDdpd4hwkIyZ4tPsXs+OekYn84Cy8LF0e5nNlyZLPSKnEJiR
	 aEds9+ohTaXrndLFSA1yQ9m93FQRIxNqVJiC/UsgaLGX/2ABqedgK7cyxjWT45xSS9
	 BRRJYAp9c/OOyu6uiK0UdwHevRVFaDEY66bo46jmSus+ly8ySxDafK/52bYRDfDazJ
	 yOFXelZDarLo9YT+BtJ+sKc6yKKvwO+8zC0baWXto6FOFikG1rxW5OpmQPY+XNyTZY
	 RHdz0yQbkpvjNAkzBsl9YZj3eFpQPBwv3lhUaZnVVoj5p9EbG+SYfVrBX0miIfPIES
	 eLXY+Aq90JmLasXapGL5R/nkmkdNPqAEUmmpbqvafYfyidQ0mSG0xaeqPSYUgLxqNk
	 oBF7xTWH8PkrrZNDGFyQWq7a4apDxjtCaLwMlPbJx0SgFqfXNz537qib0jSzyIcikP
	 oqDIB1OW7pxDNLV28KuDO0hQqFnvA1j+MWw3EZ3FKpn3irKqG1iivUznYtXr5Ig3op
	 KRy9MtNGBVEPU6MujLKjQ7aizEIC22mjVYBf1lhZCmZ+xvbXpd2q7wubv2RUU+V2YN
	 StUXcZs88mIJfVa/bbuD84S4=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8D2A540E0028;
	Tue, 13 Jan 2026 09:51:12 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:51:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFvlpJY=?=
 =?utf-8?B?6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNl?= =?utf-8?Q?=3A?= Fix
 timer interval adjustment after logging a MCE event
Message-ID: <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <268e2f0512db435685af987a2ba6893c@baidu.com>

On Mon, Jan 12, 2026 at 10:24:11AM +0000, Li,Rongqing wrote:
>     Since commit 011d82611172 ("RAS: Add a Corrected Errors Collector"),
>     mce_timer_fn() has incorrectly determined whether to adjust the
>     timer interval. The issue arises because mce_notify_irq() now always
>     returns false when called from the timer path, since the polling code
>     never sets bit 0 of mce_need_notify. This prevents proper adjustment of
>     the timer interval based on whether MCE events were logged.

That's because you missed the main point of the error collector:

    "The error decoding is done with the decoding chain now and
    mce_first_notifier() gets to see the error first and the CEC decides
    whether to log it and then the rest of the chain doesn't hear about it -
    						     ^^^^^^^^^^^^^^^^^^^^^^

    basically the main reason for the CE collector - or to continue running
    the notifiers."

So lemme ask you again: what are you really fixing?!

What is the actual problem you're trying to fix?

And do not send me another revised commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

