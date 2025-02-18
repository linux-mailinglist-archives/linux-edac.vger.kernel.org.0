Return-Path: <linux-edac+bounces-3126-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC85A39743
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4A188C668
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DC22FE03;
	Tue, 18 Feb 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WaM9iNYH"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E51FF7C0;
	Tue, 18 Feb 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871588; cv=none; b=dYA1rCV4caNsRPz0YeMZdLzmGFomPxA5BOi1CGpMXn1F+tCqyn0TP8n+Pje5GQoot4wSkPPChVFFrIuYwMmrTYXWHZySGeVyG6CB9AyTDQ7oGNwihg4ZBpP57xE4vqC8pGdvR1XZaHowK9f9ICJrQ2gQv+wiUMW4yONUJ2IcCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871588; c=relaxed/simple;
	bh=5pKTmta1DNUz4ejshTl1BlQ55G94WwIMEZUwsdeDFs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf6GO/hcTvjlH2H+L4SBbS/5jJJ2EvnOupJ7nr3C4LYxm03YSpa8pUtwmPJEhVVO2iHVaUaiOr1nCxapXzN43qd2Ru3UOqJt/RLLuC6xZCoGE3Oc33DBG3LDqCD+TAmUKG3dXmH+0LDwWKiHo5lXHcxQYK4gzO+YCJrMepAm0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WaM9iNYH; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739871577; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AOdAb3d6o80BSYahe52Vce3OcGOdM1bmfBBl7TGBGRg=;
	b=WaM9iNYH65UB/gg4qMdk7MOk74YqeZWOmn0eXBmMjyZ82xifBr/7XEnj+vetD/MWdKcWRzJaTiDQMFABlwgR+RdJXf1MYQgqh1eaTlcy8WPsuwBxyF7fIc+IID3Ut7jrTQHntp8AO1yCvbgtOqA/+UvZkRwAHvyj0jNBZhuEp2Y=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPlNMQZ_1739871574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 17:39:35 +0800
Message-ID: <b3c12f1f-f27a-44f0-b32c-32b58e6e926c@linux.alibaba.com>
Date: Tue, 18 Feb 2025 17:39:33 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] x86/mce: Collect error message for severities
 below MCE_PANIC_SEVERITY
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
 peterz@infradead.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-2-xueshuai@linux.alibaba.com>
 <20250218075858.GAZ7Q9wp_WQUsjq2AW@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218075858.GAZ7Q9wp_WQUsjq2AW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 15:58, Borislav Petkov 写道:
> On Mon, Feb 17, 2025 at 02:33:31PM +0800, Shuai Xue wrote:
>> Currently, mce_no_way_out() only collects error messages when the error
>> severity is equal to `MCE_PANIC_SEVERITY`. To improve diagnostics,
>> modify the behavior to also collect error messages when the severity is
>> less than `MCE_PANIC_SEVERITY`.
> 
> That function is literally called "no way out" as in, is the error severe
> enough so that there is no way out.
> 
> Now you went and stomped all over that to "improve diagnostics". What
> diagnostsics? Your commit messages need to explain in detail why exactly
> a patch exists.
> 
> So nope.
> 

Hi, Borislav,

Thank you for reply.

The msg in predefined `severities`, e.g.

	MCESEV(
		AO, "Action optional: last level cache writeback error",
		SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
		),

is helpful for users to know what kind of MCE is happened. For a fatal machine
check, kernel panic use the message and I want to extend to collect the message
and print it out for non-fatal one.

If you don't object, let's go on to discuss how to implement it.
Otherwise, you can ignore the following response.

Yes, mce_no_way_out() means "no way out" literally. It only collects message
for MCE_PANIC_SEVERITY but use in common path. So I used this function to
extend it to non-fatal, assuming it was obvious.
  
Is __mc_scan_banks() a proper function to extend?

Thanks.
Shuai

