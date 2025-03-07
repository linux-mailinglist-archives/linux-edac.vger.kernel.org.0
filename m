Return-Path: <linux-edac+bounces-3295-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93748A55D38
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 02:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE2C16B0E7
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F111519BC;
	Fri,  7 Mar 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oguZAHI3"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B2DDA9;
	Fri,  7 Mar 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311616; cv=none; b=BkoDe2NA1uwsCMvB/iSVm/17bWlTjg8pNVrIOvU2G7nMaREYzeswk5UTc7y9u2ypUBDqRWI9FjRDiRAK9Ckw31ZrxUQI+3YyzifpewDvbDIQkisouplqX9WbRPerNtljX47Q1BTQUnj/fhHhGaE7c85FenYzTq8NbCT5V3oYYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311616; c=relaxed/simple;
	bh=y36FJMllzPHXVH87NJBvFRtsjZK0vo1zm3bkJc35+vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdWi2wq21aLqWghMEklO2zAKJlflh8RtMeeRuYNVMevVW0rjpEox37xLR5WphtSJNVHiahdeOpkhLoEKGIJp5N4n80WhQ7ncKKdmFLyQSFPK8xrbxHOJZEqfivGk/TAlQMFr1VcQxQkEBpcjCyewJkrHrkpSARJqrdN1+mmlnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oguZAHI3; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741311605; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ix4lqrkyEpnvZGnEEPwSx3FIhCD7BBaHH6lxvs2plWE=;
	b=oguZAHI3dAr3bBtSbFYFgXlg3u+JH3LBlYMYlTgy29zxQTzKlfvwqioG+8WKaHY2C98eoPL9/wrPAEd5ZjH/NRUG20kX+FSKus8EImiVdU9qyoaYpWHsfiSt4mSTQiIaNqINvGpswjqLYAp4x9bpNIcQ57hBxXgwdU9+FSnSkMA=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQqOCEh_1741311602 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 09:40:03 +0800
Message-ID: <9556c686-d502-4b30-83e1-860154c84cc2@linux.alibaba.com>
Date: Fri, 7 Mar 2025 09:40:01 +0800
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

Sorry, I forgot to format a new patch and send a old version.
The corrected one:

---
  arch/x86/kernel/cpu/mce/severity.c | 11 +++++------
  1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..2235a7477436 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
  	copy_user  = is_copy_from_user(regs);
  	instrumentation_end();
  
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
+	if (copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
  
+	switch (fixup_type) {
  	case EX_TYPE_FAULT_MCE_SAFE:
  	case EX_TYPE_DEFAULT_MCE_SAFE:
  		m->kflags |= MCE_IN_KERNEL_RECOV;

Will fix it in next version.


Thanks.
Shuai


