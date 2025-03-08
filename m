Return-Path: <linux-edac+bounces-3321-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951FA57A04
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D0189017C
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D621A238B;
	Sat,  8 Mar 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RGy9GxWo"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAD219E8;
	Sat,  8 Mar 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741433786; cv=none; b=Fmeul6fqgDMrfbehFpuqbt1ZruKJ1TOjfoORLgcpWWoQiY/tJX0m4KCJazam7ZRIM19BdaIzWGTHAcJr7rJHENWnPPmkkp/ktuHnQA28uHR+gAzF+cxbhQvExoyg7BX4/fvqX7dyZuPAi+fAdGkxb7sYTBsVgL8oh2/RhtgMspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741433786; c=relaxed/simple;
	bh=NOzqqdmY2eaOAkTeSuCwpzClq0A+3fNkOPxY1TiG4bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aibgbJTp6DPHt/FSTSQwynTfWnrD3fPws/VF8lf7VgZoLWlTfIih2TwZEO/LjnOCACBVQLpEHw54Zqp8SgyM8qpNJRuK8B/WwvRBeafj3Hs1y4VRZ+ubfGmMAYf3+SpUbC4GqQFo31dArSY+0bsQMTHpo0Ilv2RtTnlZoiRttDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RGy9GxWo; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741433775; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dWe9gzux1j97nsz01TznH5atc0a228qEauEvpvfcPq0=;
	b=RGy9GxWoS8FtUHAZAEuEvbMx09D7Yly/ZNtXvBv3gO3Xuzxvp6XqtatqEU4DIbmi0ogD6d7Gh2ooTqs0CU67ZsDpKxzqebAFnFPtYz2oRLWKX0AftwNfrFEs7rxVypTYzwbfY/XcOvXao6cXlWNzk5b9om7O0KjBzEATJO41HM8=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQuksZs_1741433772 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Mar 2025 19:36:13 +0800
Message-ID: <f3d7f5ad-31c2-4221-83ab-2b55e1d2c662@linux.alibaba.com>
Date: Sat, 8 Mar 2025 19:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] mm/hwpoison: Fix regressions in memory failure
 handling
To: "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB6083F2BA604819CD44AB5F26FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083F2BA604819CD44AB5F26FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/8 01:20, Luck, Tony 写道:
>> ## 1. What am I trying to do:
>>
>> This patch resolves two critical regressions related to memory failure
>> handling that have appeared in the upstream kernel since version 5.17, as
>> compared to 5.10 LTS.
>>
>>      - copyin case: poison found in user page while kernel copying from user space
>>      - instr case: poison found while instruction fetching in user space
> 
> Tested the instruction, copyin, and futex cases. They all pass now.
> 
> Thanks!
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> 
> -Tony

Thanks for your help.

Best Regards,
Shuai

