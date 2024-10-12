Return-Path: <linux-edac+bounces-2020-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240699B27F
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD6C1C20F23
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D772148FF9;
	Sat, 12 Oct 2024 09:23:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9F17BA5
	for <linux-edac@vger.kernel.org>; Sat, 12 Oct 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728724980; cv=none; b=BwxaDiK+cECPMcQMxPs46H2ysFO9zvel5QScDM592cwc1bUIiRh91KvSyN+dGgjHZh/JBs9iBGcdd0HoMor3JSQBg7asblcGChpAdOyHZzoRlby4AHxYDpXTiI/ORYZBAFqay8lw7k/os7uk6l6XoVGfKVeosSLzLl82qzC2Ggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728724980; c=relaxed/simple;
	bh=Sx6u/m7aphAvEiIiucMCVRn6jVEfYN879oj/pKFgaS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TbEmGQibGimYy0wlS4PoEi7b3MZnBZ1ojjuKao14ExNSG6kOmXDi0lJcxMttmRz44RPAyrGjcgfAnKo+u0tAMAtOLjhLwUFLLx26PmfYna1gNHs9qAT9WdQBhQeJR6wSXjySIqsqrPB5lQReSBWsgmvyx8ByGYwxog+fUFbKpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1728724959-086e23455a013f0001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id h7U60LTCMJq9TWmA (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 12 Oct 2024 17:22:39 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 12 Oct
 2024 17:22:38 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Sat, 12 Oct 2024 17:22:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.65.156] (10.32.65.156) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 12 Oct
 2024 17:06:30 +0800
Message-ID: <830f88fd-4f05-478e-aace-e6ca20413133@zhaoxin.com>
Date: Sat, 12 Oct 2024 17:06:15 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v4 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-4-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB7134431FEEF5A9EA6A7CD3E7897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <CY8PR11MB7134431FEEF5A9EA6A7CD3E7897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 10/12/2024 5:22:37 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1728724959
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2795
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131702
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/10/12 14:41, Zhuo, Qiuxu wrote:
> 
> 
>> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> [...]
>> +config X86_MCE_ZHAOXIN
>> +     def_bool y
>> +     prompt "Zhaoxin MCE features"
>> +     depends on X86_MCE_INTEL
>> +     help
>> +       Additional support for zhaoxin specific MCE features such as
> 
> s/zhaoxin/Zhaoxin
> 
>> +       the corrected machine check interrupt.
>> +
>>   config X86_MCE_AMD
>>        def_bool y
>>        prompt "AMD MCE features"
>> diff --git a/arch/x86/kernel/cpu/mce/Makefile
>> b/arch/x86/kernel/cpu/mce/Makefile
>> index 015856abd..2e863e78d 100644
>> --- a/arch/x86/kernel/cpu/mce/Makefile
>> +++ b/arch/x86/kernel/cpu/mce/Makefile
>> @@ -5,7 +5,7 @@ obj-$(CONFIG_X86_ANCIENT_MCE) += winchip.o p5.o
>>   obj-$(CONFIG_X86_MCE_INTEL)  += intel.o
>>   obj-$(CONFIG_X86_MCE_AMD)    += amd.o
>>   obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
>> -
>> +obj-$(CONFIG_X86_MCE_ZHAOXIN)   += zhaoxin.o
> 
> Move this newly added item just after AMD's, so they're sorted in vendors.
> And keep a blank line here as it was.
> 
>>   mce-inject-y                 := inject.o
>>   obj-$(CONFIG_X86_MCE_INJECT) += mce-inject.o
>>
>> [...]
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Zhaoxin specific MCE features
>> + * Author: Lyle Li
>> + */
>> +#include <asm/msr.h>
>> +#include "internal.h"
>> +
>> +static void mce_zhaoxin_apply_mce_broadcast(struct cpuinfo_x86 *c) {
>> +     struct mca_config *cfg = &mca_cfg;
>> +
>> +     /* Older CPUs do not do MCE broadcast */
> 
> s/MCE broadcast/MCE broadcast:/
> 
>> +     if (c->x86 < 6)
>> +             return;
>> +     /*
>> +      * All newer Zhaoxin and Centaur CPUs support MCE broadcasting.
>> Enable
>> +      * synchronization with a one second timeout.
>> +      */
> 
> 
> Instead of copying and pasting the redundant comments, could you use Dave's concise comments as suggested in:
> 
>     https://lore.kernel.org/all/a25f878e-83d9-440a-9741-4cf86db4a716@intel.com/
> 
> /* All newer ones do: */
>> +     if (c->x86 > 6)
>> +             goto mce_broadcast;
>> +
> 
> /* Family 6 is mixed: */
>> +     if (c->x86_vendor == X86_VENDOR_CENTAUR) {
>> +             if (c->x86_model == 0xf && c->x86_stepping >= 0xe)
>> +                     goto mce_broadcast;
>> +     } else if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
>> +             if (c->x86_model == 0x19 || c->x86_model == 0x1f)
>> +                     goto mce_broadcast;
>> +     }
>> +
>> +     return;
>> [...]

Thank you for your review.
Should I add the tag for this patch:
     Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Sincerely
TonyWWang-oc

