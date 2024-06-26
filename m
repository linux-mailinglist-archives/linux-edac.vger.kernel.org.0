Return-Path: <linux-edac+bounces-1388-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7D918E1F
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 20:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B331C21AFE
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C319007A;
	Wed, 26 Jun 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j5o1QJIw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA414A0B8;
	Wed, 26 Jun 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425915; cv=none; b=WCxHmdV3tNNhlXQeytU3amtMjxO5n6Dr6WDT3M6IPlMPGdx851225Zj/Sfi8MIMCbtJQaMG+j91aZxnOAw6MEyIIys2uRAVyz+7SEKJuGN8xrN4vtCuRErlkfDhcyQ1T2ohX+C1n4/IDudTbhxUOtkJjy6/UABlPXoEy7Hw4+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425915; c=relaxed/simple;
	bh=WGeoyyLVhK3cLhQ7DcCKMD+Kd77iU04WzDA7AjlBRAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHpf5oU4MpSYkGAT94q5jmKd3swyVJEZsF7klBJq/xc31186AnDiBETFb9m6ukysbqpQFY/G8Qd2KFQl2W0xgrAQ131V3zymwQ8T4cSpz5HmMaSZh/ako7q/wdpoka9IveEzU3GEDMbyv2Qiok2wFX6+W6UWVU+VmkG9hpVm/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j5o1QJIw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 90DC140E021E;
	Wed, 26 Jun 2024 18:18:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Txi98T6lQtmU; Wed, 26 Jun 2024 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719425904; bh=lYNYfiKZ02/BE03DsGOOWO9xzev2BP8d1KQA4kQbUwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5o1QJIwGo6fp8AqB3Pb/PDZIgNgWLF1406cZ7DbW1QFovRhnpHMioo/r9O+MkUOh
	 nSTe0IrK+tccDUOJPN4odL16/b5UMwvJKH6TYuTcOF1Si9AnS+Ydj8wrP5mPjchU7p
	 6tyFbNuOWEVM7mI+WOUO+KImS1+hviz3TOwRJ2wBxdxcrpV+/i5EACB+isyJQdzzUA
	 iDXU8UMqMNlI+6aYb/FExqYczw4rYGQjq069dpzDVMSCYkegSUlhgw6w3novNNxERp
	 dKD9RmYvlAPpe2TvQWjq7AcmhhwgmyNWJUyPtfRWNf4CoCsABxgUfuMKzRGcTj9fDo
	 EzEC+jBPfIHL6POkgQaTHpNCTzqLCqoO13hs/krxSq/qQJiKx8UC6rEkH0AB0Whv4a
	 Caqdt0jqR5e8ziz+GAc2oW0uNzP5FUMivbrrSTfL8hCh2mRNcda1UtScbvoEuz/7CZ
	 d7mSYQihaMqWmyXo9VAHwK5DQ/q3H4h9lGu6q8O40aSy/Cipm9qVc2CU3R7XhkOFd/
	 GykmyN/mKVHwkCDIey1CSzurFLa3VVwYI1BhLOxmoBDXUmc+yS5bR21celA/SO5pb0
	 uk7LO2VC6/GTJJlUdZlk8EMgQJTB78Wk6ZFpvemjaVWGZ966PsdDoWRaOQqWjQ1S2m
	 KNtG7JbsujFapOzCiLlrErZM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 277E640E01D6;
	Wed, 26 Jun 2024 18:18:06 +0000 (UTC)
Date: Wed, 26 Jun 2024 20:18:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <20240626181805.GDZnxbXRJlCecNeDGW@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-3-avadhut.naik@amd.com>
 <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
 <6c318161-9ae4-4965-b8f3-e38bf1393628@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c318161-9ae4-4965-b8f3-e38bf1393628@amd.com>

On Wed, Jun 26, 2024 at 12:24:20PM -0500, Naik, Avadhut wrote:
> 
> 
> On 6/26/2024 06:10, Borislav Petkov wrote:
> > On Tue, Jun 25, 2024 at 02:56:22PM -0500, Avadhut Naik wrote:
> >> AMD's Scalable MCA systems viz. Genoa will include two new registers:
> > 
> > "viz."?
> > 
> Right. Will mention Zen4 instead of Genoa.

I still don't know what "viz." means...

> Yes, I catch your drift. Will reword the commit message to explain that the
> new syndrome registers are going to be exported through the tracepoint
> in a dynamic array, as they are vendor-specific, so that usersapce error
> decoding tools can retrieve the supplemental error information within them.

Again, why?

Why is it important to have them in the tracepoint?

> >> Note: Checkpatch warnings/errors are ignored to maintain coding style.
> > 
> > This goes...
> > 
> >>
> >> [Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]
> > 
> > Yes, you did but now your SOB chain is wrong:
> > 
> >> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > This tells me Avadhut is the author, Yazen handled it and he's sending it to
> > me. But nope, he isn't. So it needs another Avadhut SOB underneath.
> > 
> > Audit all patches pls.
> > 
> Wasn't aware of this chronology. Thanks for this information!

Well, there's documentation for that which you should've read already, before
sending patches:

https://kernel.org/doc/html/latest/process/development-process.html

and

https://kernel.org/doc/html/latest/process/submitting-patches.html

especially.

> So, IIUC, the sequence for this patch should be as follows?
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

Yes, now I leave it to you to explain why. Hint: it is in those docs above.

> 
> >> ---
> > 
> > ... right under those three "---" as such notes do not belong in the commit
> > message. Remember that for the future.
> > 
> Okay. Will move the note here.

Or remove it completely. checkpatch is crap - I know. No need to have it in
every patch.

> Had considered this. But struct mce_hw_err *err wouldn't really be used in
> mce_read_aux() in patch 1. Only struct mce m, which is already available, will
> be used.

So?

> Hence, deferred the change to this patch where usage of struct mce_hw_err *err
> is actually introduced in mce_read_aux().
> 
> Do you prefer having this change in patch 1 instead?

I prefer a patch to contain one logical and complete change only. Because this
makes review easier. You should try reviewing patches sometimes too and you'll
know.

> > So that vendor data layout - is that ABI too? Or are we free to shuffle the
> > fields around in the future or even remove some?
> > 
> > This all needs to be specified somewhere explicitly so that nothing relies on
> > that layout.
> > 
> > And I'm not sure that that's enough because when userspace tools start using
> > them, then they're practically an ABI so you can't change them even if you
> > wanted to.
> > 
> > So is libtraceevent or all the other libraries going to parse this as a blob
> > and it is always going to remain such?
> > 
> > But then the tools which interpret it need to know its layout and if it
> > changes, perhaps check kernel version which then becomes RealUgly(tm).
> > 
> > So you might just as well dump the separate fields one by one, without
> > a dynamic array.
> > 
> > Or do a dynamic array but specify that their layout in struct
> > mce_hw_er.vendor.amd are cast in stone so that we're all clear on what goes
> > where.
> > 
> > Questions over questions...
> > 
> Should we document this where struct mce_hw_err is defined, in
> arch/x86/include/asm/mce.h? Or do you have any other recommendations?

I don't know. If I knew I wouldn't have questions which you can read again and
try to answer.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

