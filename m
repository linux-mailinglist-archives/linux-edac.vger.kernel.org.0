Return-Path: <linux-edac+bounces-5634-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EDED1B348
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B01E53004EE0
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A42356BA;
	Tue, 13 Jan 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOvZXnEU"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF19157480;
	Tue, 13 Jan 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336205; cv=none; b=f8IaMakxaF+AI5nX7lXMiBQuG5sEMYIaX966et8CzFrAIg7ak15VKjYA9O3ldxjFNLi6BMfuKrLRGylHbFmYeviDgokVIdqKoSks+iB9/8tfNDXE01S7VW39x3Kc3q9wu0665mQ2m2d+EViva8adRM/iETu/4RXG8wB9RfeUVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336205; c=relaxed/simple;
	bh=MJmmoxGk0duErInLSAr9B5ZHz/s+174CayW6U6VdE2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=um4eKT4vXeTnY9xUR/hP3L/ykvH51NEgvwdZr4OQDwFHDZ2c21J2LrExSateLoDA4fpFxwpYILXNSX7fE/jh61nNEMvoq1bvATG8PfczmJtk4Pe8wQo09tfuG90mCHHsBKAjMNK1Ip84OWyirHzTtVUandiePd0cu6wAHaNEgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOvZXnEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48CFC116C6;
	Tue, 13 Jan 2026 20:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768336205;
	bh=MJmmoxGk0duErInLSAr9B5ZHz/s+174CayW6U6VdE2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZOvZXnEUmRKWD9IiGrp88I2UCPF06CB7RYxdUpP2MC3gwBiN6XZkfCTbxUbn39rhB
	 KYQX5srBsymHREL2hMotDrlqP4KLyrN6BV/yNQ2HerLL7a8w9ECwUSVa8osKMoYmAD
	 6teWxASlhbCKMhbfYjKw/JZxB1+4Fi0ChQLWDRzy/XnuUsULJeYzBGCfWW8wcXnOjc
	 OCeXliKY4n2K1laHFWHQTi+E7vKHmq9leGvqj/0VmEiD2K9HE02+fQb09ZTtdIAJQN
	 xPjTPCeYmFGyEvFbi54B3Uzck30HXz49REAVPmFKKAh/6OzSJD8vjTBl0C/8EvFWfU
	 pXaoiWxmB9hTw==
From: Thomas Gleixner <tglx@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Li,
 Rongqing" <lirongqing@baidu.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Yazen
 Ghannam <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>
Subject: RE: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW+WklumDqOmCrg==?=
 =?utf-8?B?5Lu2XQ==?= Re: [PATCH] x86/mce: Fix timer interval
 adjustment after logging a MCE event
In-Reply-To: <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Date: Tue, 13 Jan 2026 21:30:01 +0100
Message-ID: <87ms2hi7cm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13 2026 at 18:53, Tony Luck wrote:
>> > The comment in mce_timer_fn says to adjust the polling interval, but
>> > I notice the kernel log always shows an MCE log every 5 minutes. Is this
>> > normal?
>>
>> Use git annotate to figure out which patch added this comment and in context
>> of what and that'll tell you why.
>>
>> As to the 5 minutes, look at how the check interval gets established.
>
> Once upon a time the polling interval started out at 5 minutes, but the
> interval was halved each time an error was found (so interval went
> 150s, 75s, 37s, ... down to 1s). If no error was found, then the interval
> was doubled (going back up to 300s).
>
> This is described in the comment:
>
>         /*
>          * Alert userspace if needed. If we logged an MCE, reduce the polling
>          * interval, otherwise increase the polling interval.
>          */
>
> It seems that the kernel isn't doing that today. Polling at a fixed 300 seconds
> event though errors are being found and logged.

How did we lose that?

> Interesting that the timestamps are 327.68 seconds apart, rather than
> 300 and change. So there is some strange stuff going on.

Nothing strange. That's the batching inaccuracy, aka. granularity of the
timer wheel. See the big fat comment on top of kernel/time/timer.c

So looking at that table, I'm sure you have HZ=250. But that granularity
does not explain why that interval magic is not longer working....

Thanks,

        tglx

