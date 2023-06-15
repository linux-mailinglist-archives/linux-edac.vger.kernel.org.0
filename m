Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D142730D00
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 04:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFOCDK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 22:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbjFOCDJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 22:03:09 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D21BD4;
        Wed, 14 Jun 2023 19:03:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vl8U56V_1686794582;
Received: from 30.240.112.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vl8U56V_1686794582)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 10:03:03 +0800
Message-ID: <fcb4a4a9-b266-6135-48f1-c00957ca4dc2@linux.alibaba.com>
Date:   Thu, 15 Jun 2023 10:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Split amd_mce_is_memory_error()
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        muralidhara.mk@amd.com, joao.m.martins@oracle.com,
        william.roche@oracle.com, boris.ostrovsky@oracle.com,
        john.allen@amd.com, baolin.wang@linux.alibaba.com
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-2-yazen.ghannam@amd.com>
 <9d0adc21-5b71-a949-fc6d-95dd7ef6f0a7@linux.alibaba.com>
 <cd4fc492-074f-290f-81ac-cb65715c51b0@amd.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <cd4fc492-074f-290f-81ac-cb65715c51b0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2023/6/14 23:06, Yazen Ghannam wrote:
> On 6/13/2023 10:06 PM, Shuai Xue wrote:
>>
>>
>> On 2023/6/13 22:11, Yazen Ghannam wrote:
>>> Define helper functions for legacy and SMCA systems in order to reuse
>>> individual checks in later changes.
>>>
>>> Describe what each function is checking for, and correct the XEC bitmask
>>> for SMCA.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>> ---
>>>   arch/x86/kernel/cpu/mce/amd.c | 30 +++++++++++++++++++++++++-----
>>>   1 file changed, 25 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>>> index 5e74610b39e7..1ccfb0c9257f 100644
>>> --- a/arch/x86/kernel/cpu/mce/amd.c
>>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>>> @@ -713,17 +713,37 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>>>           deferred_error_interrupt_enable(c);
>>>   }
>>>   -bool amd_mce_is_memory_error(struct mce *m)
>>> +/*
>>> + * DRAM ECC errors are reported in the Northbridge (bank 4) with
>>> + * Extended Error Code 8.
>>> + */
>>> +static bool legacy_mce_is_memory_error(struct mce *m)
>>> +{
>>> +    return m->bank == 4 && XEC(m->status, 0x1f) == 8;
>>> +}
>>> +
>>> +/*
>>> + * DRAM ECC errors are reported in Unified Memory Controllers with
>>> + * Extended Error Code 0.
>>> + */
>>> +static bool smca_mce_is_memory_error(struct mce *m)
>>>   {
>>>       enum smca_bank_types bank_type;
>>> -    /* ErrCodeExt[20:16] */
>>> -    u8 xec = (m->status >> 16) & 0x1f;
>>> +
>>> +    if (XEC(m->status, 0x3f))
>>> +        return false;
>>>         bank_type = smca_get_bank_type(m->extcpu, m->bank);
>>> +
>>> +    return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
>>> +}
>>> +
>>> +bool amd_mce_is_memory_error(struct mce *m)
>>> +{
>>>       if (mce_flags.smca)
>>> -        return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
>>> +        return smca_mce_is_memory_error(m);
>>>   -    return m->bank == 4 && xec == 0x8;
>>> +    return legacy_mce_is_memory_error(m);
>>>   }
>>>     static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>>
>> Hi, Yazen,
>>
>> Which tree are you working on? This patch can not be applied to Linus master ?
>> (commit b6dad5178ceaf23f369c3711062ce1f2afc33644)
>>
> 
> Hi Shuai,
> 
> I'm using tip/master as the base.
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/
> 
> Sorry, I forgot to mention this in the cover letter.

Ok. This patch itself looks good to me.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
