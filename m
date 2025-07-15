Return-Path: <linux-edac+bounces-4362-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D3B04DF5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 04:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE6A3A87B4
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EF2D0275;
	Tue, 15 Jul 2025 02:46:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32725A651;
	Tue, 15 Jul 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547595; cv=none; b=Fp0I7ppyWXkHlkR9A/HgYxm5I8oap2I+b7z71DbLESvco2XObm8EJbfNPPWBVL6ha8yiZ/FXsTKcTJGLSTqsNkyxPraRVQE22AD5rKa4Ddev3GdoktAcMg0NcaDBBDzoC2GctJ3+ZFZ0Ullqg8aPLg+ZODU7FuBbMPx59PMowAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547595; c=relaxed/simple;
	bh=pKUSNer9kB1rFcvKfygUN7XQqkLKWyZGNl4PNvl8iBw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Le7RBaUsDxZq+1AZxW5Cq1PNJ6G4igh37DAk7CCQzQv+iRbgIW+7QqxsWgsND0OziqSfe6YxxEXZJ2ola4pqP/0GRORX+vMkB2izBoQS2JGa2NM5a4UqWMUXqWt9Uzg314uC6zZmpnrjZpnPkhlG6GL8vYyqTPJoQ2ZDcWg0DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bh3Qr2ddqz29drF;
	Tue, 15 Jul 2025 10:43:32 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 24EF31400CB;
	Tue, 15 Jul 2025 10:46:09 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 10:46:06 +0800
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: "Rafael J. Wysocki" <rafael@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@linux.alibaba.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>, <sudeep.holla@arm.com>,
	<lpieralisi@kernel.org>, <linux-acpi@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
	<robin.murphy@arm.com>, <Jonathan.Cameron@huawei.com>, <bp@alien8.de>,
	<linux-arm-kernel@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
	<tanxiaofei@huawei.com>, <mawupeng1@huawei.com>, <linmiaohe@huawei.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
	<gregkh@linuxfoundation.org>, <jarkko@kernel.org>
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
 <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
 <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
 <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
 <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
 <de5d2417-dc92-b276-1125-4feb5151de7f@huawei.com>
 <f60f1128-0d42-48e5-9a06-6ed7ca10767f@linux.alibaba.com>
 <20250428152350.GA23615@willie-the-truck>
 <6671c3cc-5119-4544-bcb5-17e8cc2d7057@linux.alibaba.com>
 <CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
 <3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com>
 <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9457d09d-20da-e645-3f3a-2be0c0101c71@huawei.com>
Date: Tue, 15 Jul 2025 10:46:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/15 1:30, Rafael J. Wysocki wrote:
>>> For APEI changes, you need an ACK from one of the reviewers listed in
>>> the MAINTAINERS entry for APEI.
>>>
>>> Thanks!
>> Hi, Rafael
>>
>> Sorry, I missed your email which goes in span (:
>>
>> ARM maintain @Catalin points that:
>>
>>   > James Morse is listed as reviewer of the ACPI APEI code but he's busy
>>   > with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
>>   > maintainers, hopefully they can help.
>>
>> And Hanjun explictly gived his Reviewed-by tag in this thread, is that
>> happy for you for merge?
> Not really.
> 
> I need an ACK or R-by from a reviewer listed in the APEI entry in MAINTAINERS.
> 
> If James Morse is not able to fill that role (and AFAICS he's not been
> for quite some time now), I'd expect someone else to step up.

Please count me in. I have been working in ACPI for years, and RAS 
feature development for both x86 and arm64 architectures.

I'm pretty familiar with ACPI spec including APEI, it will help me
to do the review work.

Thanks
Hanjun

