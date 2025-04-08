Return-Path: <linux-edac+bounces-3485-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E0A7F2B5
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 04:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCFA3AEC98
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76E20A5EE;
	Tue,  8 Apr 2025 02:34:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2A1A5BBB;
	Tue,  8 Apr 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079678; cv=none; b=Ybf/pGqXo7NEEvaa2vLVjX14WaOMEwglqomIbWnTMgJRxfGzzHDie5pwSlVvHvu/CPbOxPHYq+C5rJb7v6dMGyDdo0CYUCtZGC5fcLINgw0CRN35pyrstloTGJj6C2nhdo0Avyik1pcHbXZ5cx5WYkxouiiwZr9RIPe2cWPfWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079678; c=relaxed/simple;
	bh=f743pXy24fP4ZQGtc5Gp/38982Ecmd2qj65y1f/2EG0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nBRpg2VgtBvdNVTSVOoWo7CZf7Lo+7llUmVsn6MTVsUgJqhouHU6Lp9C9XZ/4VjjcQ9SRLoFutyMNDC4a+e3SdlapotKFzJOYxo7MNEMmHdJJFK7u0hiwx94zermAOnjhYY6XXUCUKBWtXzgGnxJ20ap5doOXz9taDlMzeAAi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZWqr46dS8ztRtx;
	Tue,  8 Apr 2025 10:33:08 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EDC361401E9;
	Tue,  8 Apr 2025 10:34:32 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 10:34:31 +0800
Subject: Re: [RESEND PATCH v18 0/2] ACPI: APEI: handle synchronous errors in
 task work
To: Shuai Xue <xueshuai@linux.alibaba.com>, <catalin.marinas@arm.com>,
	<sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
	<linux-acpi@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<mark.rutland@arm.com>, <mingo@redhat.com>, <robin.murphy@arm.com>,
	<Jonathan.Cameron@Huawei.com>, <bp@alien8.de>, <rafael@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
	<tanxiaofei@huawei.com>, <mawupeng1@huawei.com>, <tony.luck@intel.com>,
	<linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>, <james.morse@arm.com>,
	<tongtiangen@huawei.com>, <gregkh@linuxfoundation.org>, <will@kernel.org>,
	<jarkko@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-edac@vger.kernel.org>, <x86@kernel.org>,
	<justin.he@arm.com>, <ardb@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ashish.kalra@amd.com>, <baolin.wang@linux.alibaba.com>,
	<tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <lenb@kernel.org>,
	<hpa@zytor.com>, <robert.moore@intel.com>, <lvying6@huawei.com>,
	<xiexiuqi@huawei.com>, <zhuo.song@linux.alibaba.com>
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <38b80839-cd47-cbf6-cd79-44e967ad8cb3@huawei.com>
Date: Tue, 8 Apr 2025 10:34:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Shuai Xue,

On 2025/4/4 19:20, Shuai Xue wrote:
>>From Catalin:
> 
>> James Morse is listed as reviewer of the ACPI APEI code but he's busy
>> with resctrl/MPAM.
> 
> These two patches have undergone 18 iterations of review and have received
> 11 'Reviewed-by' tags in total, but they have not yet been merged into the
> mainline. I am requesting further review and ack from the arm64
> ACPI maintainers: Lorenzo, Sudeep, and Hanjun. Thank you for your attention
> and assistance.

I will take a detail review this week.

Thanks
Hanjun

