Return-Path: <linux-edac+bounces-3031-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA5A31B9C
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 02:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA783A6C4B
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E8878F5E;
	Wed, 12 Feb 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LJ/fBHlk"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544011CA9C;
	Wed, 12 Feb 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325446; cv=none; b=W/GlNPREnUgymH0k+mhwRyEP8iB/zGj+ZOLYPm1ruF2ZuGgQ5Byd6mTohBHwybRMcJ6lnbVlI6Sk1KaCu33J7JO+IMdPVaQ5oqjJPK2wqhH6bulXN7mKWKy14wEVTzb83n5FivEvFFuBQ5cfywtdrJNd3SGtL/nuiUaSIQ1TJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325446; c=relaxed/simple;
	bh=0Cgv83jQe5AAi1xEAIuRjZtijRb+djvDZM1d5+6Lo/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9+/q9c1pllcwc4rhpH4/lfHVDWhkUr10MkUenYIO8bnReqR1/1pJE5iD7ieQEsLKnf1D431TS4We0liCGgag6w6VYBoylsX6CjsireWwiIYtViuWYCCoRD3+9MzklX0+SpmO/aKM/at/Ftn0I+wblBx46YoLObfusGqM3ClFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LJ/fBHlk; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739325441; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KwxKW1SDDYgfgG2N6v3DrfWr2V+f8zrDXRD4+gXBJvU=;
	b=LJ/fBHlkL8dyqUqnMjZJipW/DzTIdinFpW/XBuZEqXOaU2spsMEK54hCIDFe+b49FSyrHC+lYNYyWEAeym70dGssBRA2+AjJerNmZUVjIARIY+tcWTDto5mcWneHZfBQzWn/R7gxChL1KRgiLKtHJiX9FcOpCe+VRUxRyoC5icc=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPI8Bo9_1739325121 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 09:52:02 +0800
Message-ID: <5fb57072-96a6-4ce9-8636-f1746693cfff@linux.alibaba.com>
Date: Wed, 12 Feb 2025 09:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] x86/mce: Collect error message for severities
 below MCE_PANIC_SEVERITY
To: "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-2-xueshuai@linux.alibaba.com>
 <SJ1PR11MB6083B1BEED49F2A622F8AA4AFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083B1BEED49F2A622F8AA4AFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/12 00:51, Luck, Tony 写道:
>> +	char *tmp = *msg, cur_sev = MCE_NO_SEVERITY, sev;
> 
> Should cur_sev and sev be of type "int" (since that's the type returned by mce_severity())?
> 
> It doesn't matter today since the list of return value does fit into "char", but it is setting up
> to fail if that should ever change.
> 
> -Tony

You are right, I previously only focused on the fact that the field 'sev' of
struct severity is an unsigned char.

Will fix it in next version.

Thanks.
Shuai

