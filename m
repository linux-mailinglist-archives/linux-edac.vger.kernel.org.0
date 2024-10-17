Return-Path: <linux-edac+bounces-2132-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EFE9A3179
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 01:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326B91C230ED
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EA20E318;
	Thu, 17 Oct 2024 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GSM+OHL2"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237220E311;
	Thu, 17 Oct 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208611; cv=none; b=qqHlgUL4qEFf2MWmyBaNbXxTx5IAd5KiF6Qqjxnu06Ty54/JlQojvGJ2pu6r4HqihKzFZ8HijpHfvHPYE4hqHLllyjhkGk+Dnzi3tQcKlNDVSFIkaQyNKXfA6/1t73GDX9mzwlu4ZDVawYppqUMRE3i63LSuIYTMIdXxpuiJx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208611; c=relaxed/simple;
	bh=1X9PC7KoiVBI/mKYBP5pNpvUQKGfJI+roeb2GbxIyhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBUK16kYH37zaQLwGY15JV7XE1KQkmT/JF3Ru1mFLyBc9GUdhXzyNwvbXy/jPT7aHQ24g6OfXkmCuzgi0SAzORJgxh2VLuyzOFuXTe2604YpqUlomzckebPIyzBjrRbQHsNCmXcRxOPgvSPLvrR8to8O9oELABZdyeLyTshaJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GSM+OHL2; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729208607; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RDj4nTr6XNbe5Did2q3jGXNNdj/6CTLt9n7Mq4fQxEQ=;
	b=GSM+OHL2S290XmoALP8KprFxJRgSmtM4DLWIDIvlRKub5eLg12cy1Lj1gpLkOayTK/vUGwbFnrXAor7gmswCQevjc0DC1mDrbpmRf4QJ8Fz/THt8j5xXKCZ4IgRaiEVhlXVYz8GDnhEvlm21e2K4H1bGj0t7YcgSHXVhGYWYtf0=
Received: from 30.246.161.56(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WHLxoXR_1729208603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 07:43:25 +0800
Message-ID: <9a66303e-f8fb-4c66-a7ab-d28e03982f32@linux.alibaba.com>
Date: Fri, 18 Oct 2024 07:43:23 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/3] mm: memory-failure: move return value
 documentation to function declaration
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, bp@alien8.de, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241014084240.18614-3-xueshuai@linux.alibaba.com>
 <20241017104156.00000f83@Huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241017104156.00000f83@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/17 17:41, Jonathan Cameron 写道:
> On Mon, 14 Oct 2024 16:42:39 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Part of return value comments for memory_failure() were originally
>> documented at the call site. Move those comments to the function
>> declaration to improve code readability and to provide developers with
>> immediate access to function usage and return information.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Seems sensible.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks.

Best Regards,
Shuai

