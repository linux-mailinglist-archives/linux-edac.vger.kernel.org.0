Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F29730D08
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 04:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFOCMt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 22:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFOCMt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 22:12:49 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD381BE8;
        Wed, 14 Jun 2023 19:12:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vl8Sk2z_1686795162;
Received: from 30.240.112.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vl8Sk2z_1686795162)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 10:12:44 +0800
Message-ID: <31816165-e3fc-5bb2-71ad-6fe77ecd64a7@linux.alibaba.com>
Date:   Thu, 15 Jun 2023 10:12:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 2/3] x86/mce: Define amd_mce_usable_address()
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        muralidhara.mk@amd.com, joao.m.martins@oracle.com,
        william.roche@oracle.com, boris.ostrovsky@oracle.com,
        john.allen@amd.com, baolin.wang@linux.alibaba.com
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-3-yazen.ghannam@amd.com>
 <31fdaacc-cc2b-5ea5-8a0e-e5ccfe674834@linux.alibaba.com>
 <1e9b1a0c-564d-6a3c-c253-1b1da1773ecc@amd.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1e9b1a0c-564d-6a3c-c253-1b1da1773ecc@amd.com>
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



On 2023/6/14 23:09, Yazen Ghannam wrote:
> On 6/13/2023 10:19 PM, Shuai Xue wrote:
>>
>>
>> On 2023/6/13 22:11, Yazen Ghannam wrote:
>>> Currently, all valid MCA_ADDR values are assumed to be usable on AMD
>>> systems. However, this is not correct in most cases. Notifiers expecting
>>> usable addresses may then operate on inappropriate values.
>>>
>>> Define a helper function to do AMD-specific checks for a usable memory
>>> address. List out all known cases.
>>>
>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>> ---
>>>   arch/x86/kernel/cpu/mce/amd.c      | 38 ++++++++++++++++++++++++++++++
>>>   arch/x86/kernel/cpu/mce/core.c     |  3 +++
>>>   arch/x86/kernel/cpu/mce/internal.h |  2 ++
>>>   3 files changed, 43 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>>> index 1ccfb0c9257f..ca79fa10b844 100644
>>> --- a/arch/x86/kernel/cpu/mce/amd.c
>>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>>> @@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
>>>       return legacy_mce_is_memory_error(m);
>>>   }
>>>   +/*
>>> + * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
>>> + * a system physical address. Therefore individual cases need to be detected.
>>> + * Future cases and checks will be added as needed.
>>> + *
>>> + * 1) General case
>>> + *    a) Assume address is not usable.
>>> + * 2) "Poison" errors
>>> + *    a) Indicated by MCA_STATUS[43]: POISON. Defined for all banks except legacy
>>> + *       Northbridge (bank 4).
>>> + *    b) Refers to poison consumption in the Core. Does not include "no action",
>>> + *       "action optional", or "deferred" error severities.
>>> + *    c) Will include a usuable address so that immediate action can be taken.
>>> + * 3) Northbridge DRAM ECC errors
>>> + *    a) Reported in legacy bank 4 with XEC 8.
>>> + *    b) MCA_STATUS[43] is *not* defined as POISON in legacy bank 4. Therefore,
>>> + *       this bit should not be checked.
>> [nit]
>>
>>> + *
>>> + * NOTE: SMCA UMC memory errors fall into case #1.
>>
>> hi, Yazen
>>
>> The address for SMCA UMC memory error is not system physical address, it make sense
>> to be not usable. But how we deal with the SMCA address? The MCE chain like
>> uc_decode_notifier will do a sanity check with mce_usable_address and it will not
>> handle SMCA address.
>>
> 
> Hi Shuai,
> 
> That's correct.
> 
> There isn't a good solution today. This will be handled in future changes.

Hi, Yazen,

Do you have plan to address it? If not, I can help. We meet this problem in our products.

Thanks
Shuai



