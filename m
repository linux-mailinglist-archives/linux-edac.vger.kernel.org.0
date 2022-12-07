Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C77645382
	for <lists+linux-edac@lfdr.de>; Wed,  7 Dec 2022 06:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLGFpB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Dec 2022 00:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGFou (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Dec 2022 00:44:50 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E657B74;
        Tue,  6 Dec 2022 21:44:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianruidong@linux.alibaba.com;NM=0;PH=DS;RN=43;SR=0;TI=SMTPD_---0VWkBjQs_1670391876;
Received: from 30.221.133.176(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VWkBjQs_1670391876)
          by smtp.aliyun-inc.com;
          Wed, 07 Dec 2022 13:44:38 +0800
Message-ID: <b365db02-b28c-1b22-2e87-c011cef848e2@linux.alibaba.com>
Date:   Wed, 7 Dec 2022 13:44:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
To:     Tyler Baicar <baicar@amperemail.onmicrosoft.com>,
        "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>,
        'Tyler Baicar' <baicar@os.amperecomputing.com>,
        "patches@amperecomputing.com" <patches@amperecomputing.com>,
        "abdulhamid@os.amperecomputing.com" 
        <abdulhamid@os.amperecomputing.com>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "tabba@google.com" <tabba@google.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jthierry@redhat.com" <jthierry@redhat.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Vineeth.Pillai@microsoft.com" <Vineeth.Pillai@microsoft.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <9330bbfb-d016-0283-a5ed-e2f4d5446759@amperemail.onmicrosoft.com>
 <TYCPR01MB616007723D2C8BA08F5337D2E9F59@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <7413d707-93a5-3681-e338-adebef198ec5@amperemail.onmicrosoft.com>
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com
In-Reply-To: <7413d707-93a5-3681-e338-adebef198ec5@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URI_DOTEDU,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, Tyler.

I am very interested in your work about AEST.
When do you plan to update the v2 patch series?

Best regards.

在 2022/5/9 21:37, Tyler Baicar 写道:
> Hi Shuuichirou,
>
> I should be able to get a v2 patch series out by the end of the month.
>
> Thanks,
> Tyler
>
> On 4/20/2022 3:54 AM, ishii.shuuichir@fujitsu.com wrote:
>> Hi, Tyler.
>>
>> When do you plan to post the v2 patch series?
>> Please let me know if you don't mind.
>>
>> Best regards.
>>
>>> -----Original Message-----
>>> From: Tyler Baicar <baicar@amperemail.onmicrosoft.com>
>>> Sent: Friday, December 17, 2021 8:33 AM
>>> To: Ishii, Shuuichirou/石井 周一郎 <ishii.shuuichir@fujitsu.com>; 'Tyler 
>>> Baicar'
>>> <baicar@os.amperecomputing.com>; patches@amperecomputing.com;
>>> abdulhamid@os.amperecomputing.com; darren@os.amperecomputing.com;
>>> catalin.marinas@arm.com; will@kernel.org; maz@kernel.org;
>>> james.morse@arm.com; alexandru.elisei@arm.com; suzuki.poulose@arm.com;
>>> lorenzo.pieralisi@arm.com; guohanjun@huawei.com; sudeep.holla@arm.com;
>>> rafael@kernel.org; lenb@kernel.org; tony.luck@intel.com; bp@alien8.de;
>>> mark.rutland@arm.com; anshuman.khandual@arm.com;
>>> vincenzo.frascino@arm.com; tabba@google.com; marcan@marcan.st;
>>> keescook@chromium.org; jthierry@redhat.com; masahiroy@kernel.org;
>>> samitolvanen@google.com; john.garry@huawei.com; 
>>> daniel.lezcano@linaro.org;
>>> gor@linux.ibm.com; zhangshaokun@hisilicon.com; tmricht@linux.ibm.com;
>>> dchinner@redhat.com; tglx@linutronix.de; linux-kernel@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
>>> linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org;
>>> Vineeth.Pillai@microsoft.com
>>> Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
>>>
>>> Hi Shuuichirou,
>>>
>>> Thank you for your feedback!
>>>
>>> On 12/9/2021 3:10 AM, ishii.shuuichir@fujitsu.com wrote:
>>>> Hi, Tyler.
>>>>
>>>> We would like to make a few comments.
>>>>
>>>>> -----Original Message-----
>>>>> From: Tyler Baicar <baicar@os.amperecomputing.com>
>>>>> Sent: Thursday, November 25, 2021 2:07 AM
>>>>> To: patches@amperecomputing.com; abdulhamid@os.amperecomputing.com;
>>>>> darren@os.amperecomputing.com; catalin.marinas@arm.com;
>>>>> will@kernel.org; maz@kernel.org; james.morse@arm.com;
>>>>> alexandru.elisei@arm.com; suzuki.poulose@arm.com;
>>>>> lorenzo.pieralisi@arm.com; guohanjun@huawei.com;
>>>>> sudeep.holla@arm.com; rafael@kernel.org; lenb@kernel.org;
>>>>> tony.luck@intel.com; bp@alien8.de; mark.rutland@arm.com;
>>>>> anshuman.khandual@arm.com; vincenzo.frascino@arm.com;
>>>>> tabba@google.com; marcan@marcan.st; keescook@chromium.org;
>>>>> jthierry@redhat.com; masahiroy@kernel.org; samitolvanen@google.com;
>>>>> john.garry@huawei.com; daniel.lezcano@linaro.org; gor@linux.ibm.com;
>>>>> zhangshaokun@hisilicon.com; tmricht@linux.ibm.com;
>>>>> dchinner@redhat.com; tglx@linutronix.de;
>>>>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>> kvmarm@lists.cs.columbia.edu; linux-acpi@vger.kernel.org;
>>>>> linux-edac@vger.kernel.org; Ishii, Shuuichirou/石井
>>>>> 周一郎 <ishii.shuuichir@fujitsu.com>; Vineeth.Pillai@microsoft.com
>>>>> Cc: Tyler Baicar <baicar@os.amperecomputing.com>
>>>>> Subject: [PATCH 1/2] ACPI/AEST: Initial AEST driver
>>>>>
>>>>> Add support for parsing the ARM Error Source Table and basic handling
>>>>> of errors reported through both memory mapped and system register
>>> interfaces.
>>>>>
>>>>> Assume system register interfaces are only registered with private
>>>>> peripheral interrupts (PPIs); otherwise there is no guarantee the
>>>>> core handling the error is the core which took the error and has the
>>>>> syndrome info in its system registers.
>>>>>
>>>>> Add logging for all detected errors and trigger a kernel panic if
>>>>> there is any uncorrected error present.
>>>>>
>>>>> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
>>>>> ---
>>>> [...]
>>>>
>>>>> +static int __init aest_init_node(struct acpi_aest_hdr *node) {
>>>>> +    union acpi_aest_processor_data *proc_data;
>>>>> +    union aest_node_spec *node_spec;
>>>>> +    struct aest_node_data *data;
>>>>> +    int ret;
>>>>> +
>>>>> +    data = kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
>>>>> +    if (!data)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    data->node_type = node->type;
>>>>> +
>>>>> +    node_spec = ACPI_ADD_PTR(union aest_node_spec, node,
>>>>> node->node_specific_offset);
>>>>> +
>>>>> +    switch (node->type) {
>>>>> +    case ACPI_AEST_PROCESSOR_ERROR_NODE:
>>>>> +        memcpy(&data->data, node_spec, sizeof(struct
>>>>> acpi_aest_processor));
>>>>> +        break;
>>>>> +    case ACPI_AEST_MEMORY_ERROR_NODE:
>>>>> +        memcpy(&data->data, node_spec, sizeof(struct
>>>>> acpi_aest_memory));
>>>>> +        break;
>>>>> +    case ACPI_AEST_SMMU_ERROR_NODE:
>>>>> +        memcpy(&data->data, node_spec, sizeof(struct
>>>>> acpi_aest_smmu));
>>>>> +        break;
>>>>> +    case ACPI_AEST_VENDOR_ERROR_NODE:
>>>>> +        memcpy(&data->data, node_spec, sizeof(struct
>>>>> acpi_aest_vendor));
>>>>> +        break;
>>>>> +    case ACPI_AEST_GIC_ERROR_NODE:
>>>>> +        memcpy(&data->data, node_spec, sizeof(struct
>>>>> acpi_aest_gic));
>>>>> +        break;
>>>>> +    default:
>>>>> +        kfree(data);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
>>>>> +        proc_data = ACPI_ADD_PTR(union acpi_aest_processor_data,
>>>>> node_spec,
>>>>> +                     sizeof(acpi_aest_processor));
>>>>> +
>>>>> +        switch (data->data.processor.resource_type) {
>>>>> +        case ACPI_AEST_CACHE_RESOURCE:
>>>>> +            memcpy(&data->proc_data, proc_data,
>>>>> +                   sizeof(struct acpi_aest_processor_cache));
>>>>> +            break;
>>>>> +        case ACPI_AEST_TLB_RESOURCE:
>>>>> +            memcpy(&data->proc_data, proc_data,
>>>>> +                   sizeof(struct acpi_aest_processor_tlb));
>>>>> +            break;
>>>>> +        case ACPI_AEST_GENERIC_RESOURCE:
>>>>> +            memcpy(&data->proc_data, proc_data,
>>>>> +                   sizeof(struct acpi_aest_processor_generic));
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    ret = aest_init_interface(node, data);
>>>>> +    if (ret) {
>>>>> +        kfree(data);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    return aest_init_interrupts(node, data);
>>>> If aest_init_interrupts() failed, is it necessary to release the data
>>>> pointer acquired by kzalloc?
>>> aest_init_interrupts() returns an error if any of the interrupts in 
>>> the interrupt list
>>> fails, but it's possible that some interrupts in the list registered 
>>> successfully. So
>>> we attempt to keep chugging along in that scenario because some 
>>> interrupts may
>>> be enabled and registered with the interface successfully. If any 
>>> interrupt
>>> registration fails, there will be a print notifying that there was a 
>>> failure when
>>> initializing that node.
>>>>> +}
>>>>> +
>>>>> +static void aest_count_ppi(struct acpi_aest_hdr *node)
>>>>> +{
>>>>> +    struct acpi_aest_node_interrupt *interrupt;
>>>>> +    int i;
>>>>> +
>>>>> +    interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, node,
>>>>> +                 node->node_interrupt_offset);
>>>>> +
>>>>> +    for (i = 0; i < node->node_interrupt_count; i++, interrupt++) {
>>>>> +        if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
>>>>> +            num_ppi++;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static int aest_starting_cpu(unsigned int cpu)
>>>>> +{
>>>>> +    int i;
>>>>> +
>>>>> +    for (i = 0; i < num_ppi; i++)
>>>>> +        enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int aest_dying_cpu(unsigned int cpu)
>>>>> +{
>>>> Wouldn't it be better to execute disable_percpu_irq(), which is paired
>>>> with enable_percpu_irq(), in aest_dying_cpu()?
>>>
>>> Good point. I will add that in the next version.
>>>
>>> Thanks,
>>>
>>> Tyler
>>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
