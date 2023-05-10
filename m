Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D396FD3C7
	for <lists+linux-edac@lfdr.de>; Wed, 10 May 2023 04:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEJCR2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 May 2023 22:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEJCR1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 May 2023 22:17:27 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E10123;
        Tue,  9 May 2023 19:17:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ViDWdbf_1683685041;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0ViDWdbf_1683685041)
          by smtp.aliyun-inc.com;
          Wed, 10 May 2023 10:17:23 +0800
Message-ID: <b384d621-6b2d-7aab-adbf-7045f23f4af9@linux.alibaba.com>
Date:   Wed, 10 May 2023 10:17:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/mce/amd: init mce severity to handle deferred memory
 failure
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de,
        tony.luck@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, baolin.wang@linux.alibaba.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230425121829.61755-1-xueshuai@linux.alibaba.com>
 <f629820c-50cf-7366-975e-68215b3f2bc5@amd.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <f629820c-50cf-7366-975e-68215b3f2bc5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2023/5/9 22:25, Yazen Ghannam wrote:
> On 4/25/23 8:18 AM, Shuai Xue wrote:
>> When a deferred UE error is detected, e.g by background patrol scruber, it
>> will be handled in APIC interrupt handler amd_deferred_error_interrupt().
>> The handler will collect MCA banks, init mce struct and process it by
>> nofitying the registered MCE decode chain.
>>
>> The uc_decode_notifier, one of MCE decode chain, will process memory
>> failure but only limit to MCE_AO_SEVERITY and MCE_DEFERRED_SEVERITY.
>> However, APIC interrupt handler does not init mce severity and the
>> uninitialized severity is 0 (MCE_NO_SEVERITY).
>>
>> To handle the deferred memory failure case, init mce severity when logging
>> MCA banks.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>
> 
> Hi Shuai Xue,
> 
> I think this patch is fair to do. But it won't have the intended effect
> in practice.
> 
> The value in MCA_ADDR for DRAM ECC errors will be a memory controller
> "normalized address". This is not a system physical address that the OS
> can use to take action.
> 
> The mce_usable_address() function needs to be updated to handle this.
> I'll send a patchset this week to do so. Afterwards, the
> uc_decode_notifier will not attempt to handle these errors.

From the experience of other platforms (e.g. ARM64 RAS and Intel MCA),
uc_decode_notifier should handle these error to hard offline the corrupted
page. If the corrupted page is a free buddy page, we can isolate it and avoid
using the page in the future.

In my test case, the error is detected by patrol scrubber in memory controller.
The scrubber may lack of system address space perspective, and only reports
"normalized address". But we can decode the "normalized address" to system address
by EDAC (umc_normaddr_to_sysaddr), right?

(I am not quite familiar with AMD RAS, please correct me if I am wrong)

> 
> Thanks,
> Yazen

Thank you.

Best Regards,
Shuai
