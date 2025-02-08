Return-Path: <linux-edac+bounces-2996-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E88A2D2E4
	for <lists+linux-edac@lfdr.de>; Sat,  8 Feb 2025 03:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D0918857CE
	for <lists+linux-edac@lfdr.de>; Sat,  8 Feb 2025 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2614900F;
	Sat,  8 Feb 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q6ZTOzSu"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BC13BAE3;
	Sat,  8 Feb 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980324; cv=none; b=OQQ3G7h8HUNaTBM4uvNG/zutyuo4gnowka2UpUfetodYVWADiC8BGuMF5ttyf+jAW+YY0tbsxWo6KP1drL/9XnBXctsC26V0+cEh5k5FXiGhtdGI/EAfJwJSFlBRYNympeORr18yj1G44hRDwyqXh+2fMf4PxlzqiAxXq+dpM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980324; c=relaxed/simple;
	bh=58t8IpyQGcJKNeTsLlLndRjaNSzrG9xb2nYxYwXkYV0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cwRifeZRyJNirRF4vYglY4eRHgYzpiR4c6XfLl8CNSu1oURtSEdZtUPolyQppIzV/ngAxyt5ZnnvKgF1lDQ8EPA64DeRYdtxo49nPmBxXBFAfQBsrk3mlsNrPx3DcCq7iZRTfxLC4JQ1RgVwNYvq3KFlTQ+0SZAbfclbxayKJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q6ZTOzSu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738980317; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=PnO79n/yAvE5EfQyNJ74YN4HFwQURsznW0Z0JEn8xXo=;
	b=Q6ZTOzSuhtm9UwcubY8NggqA18aZuEoO1A0CzKUHFUpMFW8k9amwi8zYgakttT9Eta3tyxjTaP7SmYYiVKTvKHGBfJEK0xAka1mi6eKckdxkUX3muF8dmGILBwKeGyL/oj7eQWQZqkbK/R14fexMDoaSY7N/q6rvO6CJMFg6KQY=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WP-xQ4J_1738980312 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Feb 2025 10:05:14 +0800
Message-ID: <63720413-be3d-4ae3-aec7-3c62662116a9@linux.alibaba.com>
Date: Sat, 8 Feb 2025 10:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/3] ACPI: APEI: handle synchronous errors in task
 work
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: yazen.ghannam@amd.com, mark.rutland@arm.com, catalin.marinas@arm.com,
 mingo@redhat.com, robin.murphy@arm.com, Jonathan.Cameron@Huawei.com,
 bp@alien8.de, rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20250107081735.16159-1-xueshuai@linux.alibaba.com>
 <8775a7d1-b4c5-467b-942c-3041e2994735@linux.alibaba.com>
In-Reply-To: <8775a7d1-b4c5-467b-942c-3041e2994735@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/22 13:36, Shuai Xue 写道:
> Hi, Rafael,
> 
> Gentle ping.
> 
> Thanks.
> 
> Best Regards,
> Shuai
> 
> 在 2025/1/7 16:17, Shuai Xue 写道:
>> changes singce v17:
>> - rebase to Linux 6.13-rc7 with no functional changes
>> - add reviewed-by tag for patch 1-3 from Jane Chu
>> - add reviewed-by tag for patch 3 from Yazen
>>
>> changes singce v16:
>> - add reviewed-by tag for patch 1 and patch 2 from Yazen
>> - rewrite warning message for force kill (per Yazen)
>> - warn with dev_err in ghes (per Jarkko)
>> - add return value -ENXIO in memory_failure comments  (per Yazen)
>> - Link: https://lore.kernel.org/lkml/20241104015430.98599-1-xueshuai@linux.alibaba.com/
>>
>> changes singce v15:
>> - add HW_ERR and GHES_PFX prefix per Yazen
>>
>> changes since v14:
>> - add reviewed-by tags from Jarkko and Jonathan
>> - remove local variable and use twcb->pfn
>>

Hi, all,

Gentle ping.

Thanks.
Shuai


