Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780AFEC3D4
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfKANj0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 09:39:26 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:51210 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbfKANj0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 1 Nov 2019 09:39:26 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5860A2E155F;
        Fri,  1 Nov 2019 16:39:22 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id EhlYfs7DX0-dJ0eLnKR;
        Fri, 01 Nov 2019 16:39:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572615562; bh=b+U9G81+nIuUfLnTbf5g4AsIvZj1ryKOtGI4+RzRof4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=xRD+5G1OOXaMXP3BhUHEeEC081zYL4UPDBVk/bj3BK2Q20430vaadbFydx3/vyCqt
         aJcOvOF95ry6L/j+PoVRkNOyMeu3SG2DGz3V711KMI3jg82BvCPN8GpqXYde3zRXQC
         LiSq5R0i+WY6ftnJhMM1aMqCOyJfFoQC//V1d5po=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:9508::1:e])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id qT5bQKrq9n-dJVCBFfB;
        Fri, 01 Nov 2019 16:39:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early
 boot
To:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, x86@kernel.org
References: <157252708836.3876.4604398213417262402.stgit@buzz>
 <20191031142955.GA23693@nazgul.tnic>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ad7a25d9-1ca5-0791-ae0a-63c524040bcb@yandex-team.ru>
Date:   Fri, 1 Nov 2019 16:39:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031142955.GA23693@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 31/10/2019 17.29, Borislav Petkov wrote:
> On Thu, Oct 31, 2019 at 04:04:48PM +0300, Konstantin Khlebnikov wrote:
>> Function smca_configure() is called only for current cpu thus
>> rdmsr_safe_on_cpu() could be replaced with atomic rdmsr_safe().
>>
>>   BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
>>   in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
>>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.79-16 #1
> 					     ^^^^^^^^^^
> 
> I'm assuming you hit this on latest upstream too?

I tried 5.4 once but there was no warning.
Code in 4.19 and in mainline almost the same.

Probably hardware needs full power cycle to reset state or something else.

> 
>>   Hardware name: GIGABYTE R181-Z90-00/MZ91-FS0-00, BIOS R11 10/25/2019
>>   Call Trace:
>>    dump_stack+0x5c/0x7b
>>    ___might_sleep+0xec/0x110
>>    wait_for_completion+0x39/0x160
>>    ? __rdmsr_safe_on_cpu+0x45/0x60
>>    rdmsr_safe_on_cpu+0xae/0xf0
>>    ? wrmsr_on_cpus+0x20/0x20
>>    ? machine_check_poll+0xfd/0x1f0
>>    ? mce_amd_feature_init+0x190/0x2d0
>>    mce_amd_feature_init+0x190/0x2d0
>>    mcheck_cpu_init+0x11a/0x460
>>    identify_cpu+0x3e2/0x560
>>    identify_secondary_cpu+0x13/0x80
>>    smp_store_cpu_info+0x45/0x50
>>    start_secondary+0xaa/0x200
>>    secondary_startup_64+0xa4/0xb0
>>
>> Except warning in kernel log everything works fine.
>>
>> Fixes: 5896820e0aa3 ("x86/mce/AMD, EDAC/mce_amd: Define and use tables for known SMCA IP types")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   arch/x86/kernel/cpu/mce/amd.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 6ea7fdc82f3c..c7ab0d38af79 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -269,7 +269,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>>   	if (smca_banks[bank].hwid)
>>   		return;
>>   
>> -	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
>> +	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
> 
> Yazen, any objections?
> 
