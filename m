Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ECF2A96E7
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgKFNUt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 08:20:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7153 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgKFNUt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Nov 2020 08:20:49 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CSLc545N1z15PQ5;
        Fri,  6 Nov 2020 21:20:37 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.230) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 21:20:39 +0800
Subject: Re: [PATCH 1/1] x86/mce: remove unused WARN_ON() in
 mce_register_decode_chain()
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201106084340.2009-1-thunder.leizhen@huawei.com>
 <20201106111220.GA14914@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a4069f9f-adff-3be0-bc16-6ad7354506c2@huawei.com>
Date:   Fri, 6 Nov 2020 21:20:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201106111220.GA14914@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.230]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2020/11/6 19:12, Borislav Petkov wrote:
> On Fri, Nov 06, 2020 at 04:43:40PM +0800, Zhen Lei wrote:
>> enum mce_notifier_prios {
>>         MCE_PRIO_LOWEST,
>>         MCE_PRIO_MCELOG,
>>         MCE_PRIO_EDAC,
>>
>> After commit c9c6d216ed28 ("x86/mce: Rename "first" function as "early""),
>> there is no other integer between MCE_PRIO_MCELOG and MCE_PRIO_EDAC.
>> Therefore, the WARN_ON() will never be triggered, just delete it.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/x86/kernel/cpu/mce/core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 4102b866e7c0..914f9f102995 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -162,9 +162,6 @@ EXPORT_SYMBOL_GPL(mce_log);
>>  
>>  void mce_register_decode_chain(struct notifier_block *nb)
>>  {
>> -	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
>> -		return;
> 
> No, you don't want to remove it - you want to update it so that it
> catches wrong priorities...

Oh, Yes, You're right. I will send v2.


> 
> Thx.
> 

