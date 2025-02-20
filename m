Return-Path: <linux-edac+bounces-3165-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CE6A3CE80
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 02:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B748A18975D5
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16620326;
	Thu, 20 Feb 2025 01:16:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B0286291;
	Thu, 20 Feb 2025 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014212; cv=none; b=aKr+8dNvbM1jMSpXICAUYcCcu79OGHgFvMcfkQNF+8HZtF/U/gctRUN8QEHTFAwKJlKaU0+hVGB3YCx0iJ/Xo1d94FdLCO+OQ+18i99x5mKD9zKZWqVPxm+gwuaxQ6CNK1fmJaYFLb4vBeE9zB06yY5OqZeHvOaJuEjmVu86OE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014212; c=relaxed/simple;
	bh=joOefoIDpUy08gJkWWq95ZUEHUHdFdw9h4K/FOWfAKs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ICztJQMYAoOvfswAG3UDXl6JhixU6nXpHfTuUX/gTiYDsKO1cvTvow+rIRBB0ueOaPE3SnJpzHg0HDEpd2mrb2o9aHH8Yn0wqng3/hNztAkg22d0EbpB/IWxCwjLZiSv26TU+c1qXECfMo/58fwFqNzHzBZwytarrXJ9z/nmiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YywJ95WGvzHr9Z;
	Thu, 20 Feb 2025 09:13:45 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 062FF140203;
	Thu, 20 Feb 2025 09:16:47 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 09:16:45 +0800
Subject: Re: [PATCH v2 4/5] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
To: "Luck, Tony" <tony.luck@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>,
	"bp@alien8.de" <bp@alien8.de>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-5-xueshuai@linux.alibaba.com>
 <ddd769c2-a17d-9e34-822d-66f72bd654ac@huawei.com>
 <be78641b-becc-4cdb-a90e-574734638869@linux.alibaba.com>
 <SJ1PR11MB608384612B78AF0D65ECC545FCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7cb06f0b-dd90-506e-64f6-d3bbcae8c95f@huawei.com>
Date: Thu, 20 Feb 2025 09:16:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <SJ1PR11MB608384612B78AF0D65ECC545FCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/20 1:15, Luck, Tony wrote:
>>> The caller kill_me_maybe will do set_mce_nospec + sync_core again.
>>>
>>> static void kill_me_maybe(struct callback_head *cb)
>>> {
>>>     struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
>>>     int flags = MF_ACTION_REQUIRED;
>>>     ...
>>>     ret = memory_failure(pfn, flags);
>>>     if (!ret) {
>>>             set_mce_nospec(pfn);
>>>             sync_core();
>>>             return;
>>>     }
>>>
>>> Is this expected?
>>>
>>
>> the second set_mce_nospec do nothing and have no side affect.
>>
>> sync_core() is introduced by Tony [1]:
>>
>> Also moved sync_core(). The comments for this function say that it should
>> only be called when instructions have been changed/re-mapped. Recovery for
>> an instruction fetch may change the physical address. But that doesn't happen
>> until the scheduled work runs (which could be on another CPU).
>>
>> [1]https://lore.kernel.org/all/20200824221237.5397-1-tony.luck@intel.com/T/#u
>>
>> IMHO, I think it also has no side affect.
>>
>> @Tony, could you help to confirm this?
> 
> Correct. Re-runing these calls is harmless.

Got it. Thanks both.

> 
> -Tony
> 


