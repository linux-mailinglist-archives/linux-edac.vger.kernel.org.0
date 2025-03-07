Return-Path: <linux-edac+bounces-3303-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE1A56039
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 06:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47637A53AB
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 05:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D31917F9;
	Fri,  7 Mar 2025 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fV3dDslj"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B54A21;
	Fri,  7 Mar 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326472; cv=none; b=JAxPbmxo8L/4OHYBNb5uQDxPWjbf3kq/XGx8i7O1dACJRehSBSMs4EAy2+oAUMdsG56KaPA+GsaiRFPeiNr8Z1zElMlh0xmJI79BUlawpqkDEytzT8C7pBI04kMhe+1KCOUE9UIf4L0FREhelLaqYvZzPD5Cv0zirVuL/+k3Od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326472; c=relaxed/simple;
	bh=cSgU8cHvWbc37Lebk+pboqkr3rsJ4iGhMVkicICKTH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIK0iipSVxgxCapfybU7NbkJTRykqHnnyvY2Ejq7qiDKZxIF28YNztVD97gNzs0yEiXFIw0hFaKrdjeBJVqeSn7JMBTVFZOpb2TclU/VZN3QMCEuHx+x+UAtrD5ls+g568wm1pcKF6voHBvnAMNsFbfwsBjv1SX7y+FtCun8tWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fV3dDslj; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741326462; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i8hBVXXenNjxx3BHyz1WHioxLNd57++2diGf/KDJPqY=;
	b=fV3dDsljtwze2lM5gpPGfuuXq2fZEPi81Zwg8VOSwFAGBkz6H7jo2X3fawTTfP/kG0sNKhIxwYIqnmmRkFUgBzLGrpfNiK8hLI66Rcj1J8fNdhRa3KOnKLUL6YDMQkg1IhoyP+8aFx8oCgpriyUkJeFEqAXWS8BkGAtGeho6d+E=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQqyKli_1741326459 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 13:47:40 +0800
Message-ID: <e29fa433-99c0-4dce-bade-cbe7b5638bc7@linux.alibaba.com>
Date: Fri, 7 Mar 2025 13:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
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
References: <20250306021031.5538-1-xueshuai@linux.alibaba.com>
 <20250306021031.5538-2-xueshuai@linux.alibaba.com>
 <SJ1PR11MB60837DE67D37F45B0D106C9CFCCA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB60837DE67D37F45B0D106C9CFCCA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/7 02:15, Luck, Tony 写道:
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index dac4d64dfb2a..cb021058165f 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>        copy_user  = is_copy_from_user(regs);
>>        instrumentation_end();
>>
>> -     switch (fixup_type) {
>> -     case EX_TYPE_UACCESS:
>> -             if (!copy_user)
>> -                     return IN_KERNEL;
>> -             m->kflags |= MCE_IN_KERNEL_COPYIN;
>> -             fallthrough;
>> +     if (copy_user) {
>> +             m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
> 
> You have " MCE_IN_KERNEL_COPYIN" twice here.

Sorry for this noise, please ignore this version,
I resend a new ready version, please see:
https://lore.kernel.org/linux-mm/20250307054404.73877-1-xueshuai@linux.alibaba.com/

Thanks
Shuai

