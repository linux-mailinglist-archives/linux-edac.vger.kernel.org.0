Return-Path: <linux-edac+bounces-5450-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0ACC62103
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 386654E5031
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04D1E86E;
	Mon, 17 Nov 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GqKMFn4h"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E623BCF5;
	Mon, 17 Nov 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345414; cv=none; b=ILuh/H/X3u8q45ifa+eryBipmjyb18g5H4JDxFN4nldXlNuPnWsEwHR0IdIWTPUcHHvoiFU83i635yS1KW0pp2cbUX/39AfliHRTpFCxzz3rZBGUme47PB5p4Bf0S6RSB21/8yWULJaJocT3Xuhl+ukCtPj/lgN9cROSenapgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345414; c=relaxed/simple;
	bh=X7Y6XYREVDrTlIKlXW2v3xJEZxi1M/dJuCWaFDLWagU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTuDQ8aTr6txpRJkbw2g7YT+3jECxvWoCwJwz9pkHijniw4qSmb8vlPHP0ODRhBH7gOlG2ifLxY6/tlL7WSsbYIBK/GhZ3MqtNqa/jWth3d73yqytcOS1d+YYlesAw6SgtNh0qGAGB/l3ZyXnYY16UBoWa4g2mjwQC7ZADLEnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GqKMFn4h; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X7Y6XYREVDrTlIKlXW2v3xJEZxi1M/dJuCWaFDLWagU=;
	b=GqKMFn4hrgz/7+a7VlTwkZ7LAy/YashcLHAR6DihClhzZs1HJ2ZGohFBRhsAFDJqzNF9xvzfj
	nMqGwtPGA9Eed26rzkAheMWNngjxm2ubWY2xV9cn5D4jW6FIF2KZje8k8hnm7GhUvjlRFrXaLZ+
	5kbvK/uBPS9UEVbAv48nNoY=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8rkn5F8pznTW3;
	Mon, 17 Nov 2025 10:08:33 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 86224140296;
	Mon, 17 Nov 2025 10:10:02 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 10:10:01 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <xieyuanbin1@huawei.com>, <david@kernel.org>, <dave.hansen@intel.com>,
	<david@redhat.com>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linmiaohe@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <luto@kernel.org>, <mhocko@suse.com>,
	<mingo@redhat.com>, <nao.horiguchi@gmail.com>, <peterz@infradead.org>,
	<rppt@kernel.org>, <surenb@google.com>, <tglx@linutronix.de>,
	<tony.luck@intel.com>, <vbabka@suse.cz>, <will@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Mon, 17 Nov 2025 10:09:56 +0800
Message-ID: <20251117020956.7071-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105090536.11676-1-xieyuanbin1@huawei.com>
References: <20251105090536.11676-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Wed, 5 Nov 2025 17:05:36 +0800, Xie Yuanbin wrote:
> On Wed, 5 Nov 2025 09:12:04 +0100, Dave Hansen wrote:
>> Let me clarify what we need to know:
>>
>> Will you (or your employer) be running such updated 32bit kernels on
>> hardware that supports MCEs.
>>
>> In other words: is this change driver by *real demand*
>
> Thanks! Asking like this, I completely understand now.
>
> We won't directly upgrade the kernel to 6.18.x (or later versions) to use
> this feature, but if Linux community approves these patches, we will
> backport it to 5.10.x and use it. I know that the page-flags in 5.10.x
> have been exhausted, but we can work around them by adjusting
> SECTION_SIZE_BITS/MAX_PHYSMEM_BITS to free up a page flag.
> Another patch I submitted for arm32:
> Link: https://lore.kernel.org/20250922021453.3939-1-xieyuanbin1@huawei.com
> , follows the same logic.
>
> Currently, there is a clear demand for ARM32, while the demand for x86 is
> still under discussion.
>
>> or just by "oh
>> look, we can enable that now, I can come up with a theoretical use case
>> but I don't know if anybody would actually care"?
>
> It can also be said that way. In fact, when developing the demand
> "support MEMORY_FAILURE for 32-bit OS" in version 5.10.x, I found that the
> latest version already supported this feature, so I submitted these
> patches, and hope others can benefit from it as well.

Hello, David Hildenbrand and Dave Hansen!

Do you have any other comments on this patch? If you think that
supporting memory-failure on x86_32 is meaningless, I will only submit
patch 2 in the v3 patches.

Thank you very much!

Xie Yuanbin

