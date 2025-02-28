Return-Path: <linux-edac+bounces-3234-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B1A4992E
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 13:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE57C3BD431
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81226AABB;
	Fri, 28 Feb 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dv9DAwvK"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C326AAB3;
	Fri, 28 Feb 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745584; cv=none; b=MA8aWra3bWXCYPnj3xUrUvDaobbdtvYUefZAPZ9pNH/dHgXbw1S1qaf7tQHnFrVdBQpscl+d1WEkgEhSiy8AfI4Oy+niqCtu3hrZONEi+FZySpS4n3q+xIRjFvdaZz9CCyv56be7KG+OuKwLKHM8jRRCzf6e1k+n+TSadVKSivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745584; c=relaxed/simple;
	bh=Bxj7UD95ByfwwSHEGmfNRZslP74Q3NZ4pyKDRwU7jrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MacsWa6CclP7xomNpFzItuIeWrX++5tJATIXW7DC0mVmeJa3kKVF1ME9z84EfcJaR69kLpxJ1Pu2SAuRK39q8rMVKtcHkaDM1mMG8D0bueBiv1+tb2g5zQyenzB07jaPX7eQXM7OxuyoYBspuJUMsxCTg/h359IusNsXdNlIYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dv9DAwvK; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740745572; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C6MJUKJ8ivAcDg8zvEnS4P7480VlBNsvsYgvIkxghDI=;
	b=dv9DAwvK0Yh2GcsaqR2uARQLJbm9LVrMdvtBul/qe0GOxGzGGlFC73Phhpg61O+jVCAARavBn8xwsqDxP8kQqxzAcLFCKgCjEc39qrkIhBTq7f0kwOrj/jO/UcO0tk3omvx1n0ApzfXRFhCzN0b0EvHDpnQeYzR3nHUv4hk9hLQ=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQPe85r_1740745568 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 20:26:10 +0800
Message-ID: <73087b1d-b43a-4fa3-b775-c8797460f01a@linux.alibaba.com>
Date: Fri, 28 Feb 2025 20:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/3] mm: memory-failure: move return value
 documentation to function declaration
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
 rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com, lpieralisi@kernel.org, guohanjun@huawei.com,
 sudeep.holla@arm.com
References: <20250107081735.16159-1-xueshuai@linux.alibaba.com>
 <20250107081735.16159-3-xueshuai@linux.alibaba.com>
 <Z8BbFRupgknBTvH8@arm.com>
 <0c93542f-4521-41bc-a030-5b2d8621aa6a@linux.alibaba.com>
 <Z8GeBJ9tTayTm9s9@arm.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Z8GeBJ9tTayTm9s9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/28 19:29, Catalin Marinas 写道:
> On Fri, Feb 28, 2025 at 09:46:30AM +0800, Shuai Xue wrote:
> [...]
>>> On Tue, Jan 07, 2025 at 04:17:34PM +0800, Shuai Xue wrote:
>>>> Part of return value comments for memory_failure() were originally
>>>> documented at the call site. Move those comments to the function
>>>> declaration to improve code readability and to provide developers with
> [...]
>> By the way, could arm maintainers help to ack patch 1 and 3 if there
>> is no objection?
> 
> James Morse is listed as reviewer of the ACPI APEI code but he's busy
> with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
> maintainers, hopefully they can help. Here's the full series:
> 
> https://lore.kernel.org/r/20250107081735.16159-1-xueshuai@linux.alibaba.com/
> 

Thank you for your assistance.
Looking forward to any updates.

Best regards,
Shuai


