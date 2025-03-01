Return-Path: <linux-edac+bounces-3243-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9DBA4A93B
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 07:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF11E168DA0
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74A1B2194;
	Sat,  1 Mar 2025 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ODYF0Iw1"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A5BA3D;
	Sat,  1 Mar 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740809786; cv=none; b=ZE32iExKKtd/o8wjpCaac1BmRhmcsBcb3n/udwfUWOYrmKfeQfQWFkn/CKTaBVJ6e5QtsEDFDpm2XtIV2tLIH4rSBCOau4n0MkA+wM0lSXPuS2zSIv+PkhAFyN3mKg/YZFaTLoEkcIhWtwLjziArXJoQCjFZNSHTjDSdCsWNM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740809786; c=relaxed/simple;
	bh=vsxYsFwcXFLXg8RBO9QINa3cWJfwOlTiGobTU6K3gWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaN6bOMSYodsCsDaj7KGvx+vecH6cnzRcLmxlYJ+n2puggai2LYyDD2FI2AnyY0qkpoDRx3Za3IrLbLLvaEIGUkf40Y3BrjT2+9Tzz4FUbYAv5TLvg1WNiiB7Y1aRHxhCkf/l7Bix2piJKc6TA6oSQq8A6qd+F73YVUpbE4Veq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ODYF0Iw1; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740809775; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9gxKBBIPgnf181UkMSVqiGrbZyuPBxiu7i13obHKvoI=;
	b=ODYF0Iw1OgT7xCBEQUMtDej9Q/eZvrOucu0GdAKA0jFa0Es2kl9pHd3Lyo0YYYmxal+iMU1sbDZEdWLP5FDfqrqRE29lXBaLexgb+ZPFv3O9mRiQy/emVt6/S2Gg3EI/bVcXP3JqJgdsmHXqve9w6XsWOfEc4SWjUzAcKR2AsS8=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQRgOvG_1740809772 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 14:16:13 +0800
Message-ID: <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
Date: Sat, 1 Mar 2025 14:16:12 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
 peterz@infradead.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/28 20:37, Borislav Petkov 写道:
> On Mon, Feb 17, 2025 at 02:33:32PM +0800, Shuai Xue wrote:
>> The message in severities is useful for identifying the type of MCE that
>> has occurred; dump it if it is valid.
> 
> Needs more explanation as to what "useful" means. We already log and report
> MCEs in gazillion ways.
> 

You are right.

While MCE information is indeed decoded by the EDAC and APEI drivers,
the decoding is limited to the interpretation of hardware registers
and lacks the contextual details of the error.
  
For instance, it does not specify whether the error occurred in the
context of IN_KERNEL or IN_KERNEL_RECOV, which are crucial for
understanding the error's circumstances.

For the regression cases (copy from user) in Patch 3, an error message

     "mce: Action required: data load in error recoverable area of kernel"

will be added if this patch is applied.

I could add more explanations in next version if you have no objection.

Thanks.
Shuai

