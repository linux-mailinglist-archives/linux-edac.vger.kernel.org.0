Return-Path: <linux-edac+bounces-3087-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EBBA35A5D
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 10:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90440188F6B7
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3423A98D;
	Fri, 14 Feb 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pdaduCTi"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC0230D0A;
	Fri, 14 Feb 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525369; cv=none; b=RSUH8pH7oihU91NtwNnozOj5w9e+5r6Q9S7b25xhJupi9GsUnhnxCeeKaOxzpVXo1ZVTjsbY1n5OoD6e+PIplWUkFAaWqFH3VS6JHFPBcLV7bIDzz1U5Kol6yN5bCP/Xk85bnBO0XuKmEJPg/r+4rstAIxxwZIAzrlfc9ZPqbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525369; c=relaxed/simple;
	bh=Unj9+KUmPhmjiIcXv9PQ38TPGgztU1T0Q8tpkwODRf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qANlYOZmzAec+TBKuWnmJyVKO2U7Rv15bEI03SrAdFdeUkZIFlSOkZtG+02PLfjGAWEW1lfpvYRBP1B/gPb4BVzapUtq8hQiu+yGGYuwXkWsCn8xY4COLh5Z3+wXNdZm4B/i258HrHxIBof8GmWHJtKR3obcJqrLpX5zKSqWbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pdaduCTi; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739525363; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=b6mdXYOfZ9pTQzmmFy++yT48ZTyBGn00CrwkhOAHtZ4=;
	b=pdaduCTio49Caiuk75ArWg9RcMmH7nrE1dk1qdwuQDqeEd1/NOT2ST1kjUoOsxYA+tI4L/r6m2DO/fCUEhZFN4BJbuXJkYag+cxPXKxLlPTJeuEglbBvoeQagceR3wX27Te880oj+keTnoIpIEwJFnPYiTYTn5wu8PcQTjyCDAc=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPQRTw-_1739525360 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 17:29:21 +0800
Message-ID: <dceb65c1-9d8a-4675-9354-574deaf141be@linux.alibaba.com>
Date: Fri, 14 Feb 2025 17:29:19 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] x86/mce: dump error msg from severities
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
 <20250211060200.33845-3-xueshuai@linux.alibaba.com>
 <SJ1PR11MB6083F8EDC173234D31D6708DFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083F8EDC173234D31D6708DFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/12 00:44, Luck, Tony 写道:
>> The message in severities is useful for identifying the type of MCE that
>> has occurred; dump it if it is valid.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 2919a077cd66..c1319db45b0a 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1456,6 +1456,8 @@ static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(stru
>>        if (count > 1)
>>                return;
>>
>> +     if (msg)
>> +             pr_err("%s\n", msg);
>>        task_work_add(current, &current->mce_kill_me, TWA_RESUME);
>>   }
> 
> This is called from the #MC handler. Is that a safe context to print a console
> message? It wasn't in the past, but maybe changes to how console messages
> are handled have changed this.
> 
> -Tony

#MC is a kind of NMI context, as far as I know, since

commit 42a0bb3f71383b457a7db362f1c69e7afb96732b
printk/nmi: generic solution for safe printk in NMI

print a console message is safe.

Please correct me if I missed anything.

Thanks.
Shuai

