Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998C8731C2C
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbjFOPK1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbjFOPKF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 11:10:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46826A2;
        Thu, 15 Jun 2023 08:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af++7OXA95c6Yj9+px9Hlm7QinMvNYgGK2wFFc1RSaJTkv5I0rlVi8+8BJgh3g56iv80yIf1V4wAIPEm7rvZAZj9mln+zLbFH6ZPP8Ik3WEfrTvjBtjh3kRlvoyFvuUBaPBsOKGL1OkMr/7BbihplX5DVjRTnD5Z47ZG51sl+ypSPIYT6qCM79WzurkALrSy9DtylDzQp8CDQy+gxjj4731ztqlBZgD0IHQKW9uflHARnPj8cb2JwhDWL8geWNxKK5Ed+3NJGui6ZNs25PhrBoS33KMojZcnPqmyYc2ERFto1PczpmYZYuMUoMmw0ETf+ZXNaw1Syzn+4Omz5WJG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSHeE9wvZiZ/437BP/b1w7RfFz0MWTYNB5ABzGdK3LE=;
 b=FYMosXTyWPY2GOPsA7RWTyZG5uyfk0ubhjMFnHSXmoAOYplLyIfOlbhvlUVa0SMJeYgjE4fN8IYnOR1+7KgLnq7OFeKSSVcutD4Oa1PCJvH3Riey4DrebaPek/5RTB6fChMRIaBLBTQI0tI145Pn+oJFVcXTsI4I0mh4PZjgd/wvJm/ujVaEhR8ypLX3zYJH5BTeolTB2NdeI2u1oCKYLXsv9h1hrdF8XHUVoEc14nPQ8po0BTAmjaX+FGbsoqW39s+w8MZeWCbl65YCCUxknEM/+8xoB1LYxfekjUwbdEcDfsle26xDwsr3oiIlR2++O9tq7k4RK0UXhK01rDDqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSHeE9wvZiZ/437BP/b1w7RfFz0MWTYNB5ABzGdK3LE=;
 b=5X3fGYtdhsZxoEowzZjKycd1t+Oz2E/N1FszOtxCwHdEZdosnSCehMB0ibUamMR+IEgQyoxge0Y3Rc98yiN9w4QUVJAExPvjOHp3yFAPRUldyDOfA68ZNMZztXAnyPI2AloA0cLU1wuAysnCyFmTQsxcPMsaht+Jb3V0WPhG5Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 15 Jun
 2023 15:10:00 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Thu, 15 Jun 2023
 15:09:59 +0000
Message-ID: <8504c5e0-cddd-4a1a-4b61-627bcdfad434@amd.com>
Date:   Thu, 15 Jun 2023 11:09:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, muralidhara.mk@amd.com,
        joao.m.martins@oracle.com, william.roche@oracle.com,
        boris.ostrovsky@oracle.com, john.allen@amd.com,
        baolin.wang@linux.alibaba.com
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Split amd_mce_is_memory_error()
To:     Shuai Xue <xueshuai@linux.alibaba.com>, linux-edac@vger.kernel.org
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-2-yazen.ghannam@amd.com>
 <9d0adc21-5b71-a949-fc6d-95dd7ef6f0a7@linux.alibaba.com>
 <cd4fc492-074f-290f-81ac-cb65715c51b0@amd.com>
 <fcb4a4a9-b266-6135-48f1-c00957ca4dc2@linux.alibaba.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <fcb4a4a9-b266-6135-48f1-c00957ca4dc2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:408:d4::36) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e685ea-d4ec-4662-60ea-08db6db29645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dstzz7bnQ0xQdTb8Q0POOwQ8cupY+BPDVpuao+vzc9ovFvZdf3cpUv0iYxiqn/iQNU1ro42SpYXh4LoKaxPOaYVqx+SQENs+JgPV8x/bNDCz6/cK47VEFRKshgoRCCG8QwQBVSnuCA0hhU+uYocHyL6M6Dwnb44+nCuog/lpJleP7ETTUqYuTK1lw4ksUVL3HnWvlB7HppMKzkZIhYpmnB26j3HWg2kNWxRfU/bDZ/FhUACGwKWjmeANu7TRiMvAoE7lcaqx5+EmvK3AsdmLJahZ4F6tJ/FqSW7B1YMPcsI4ij2HYwSN+r4zLf9IooIqoy7gXUDB7e9DIR782YfyuuMNqlJdYXbVTYA+8ILUFiVbEDOXcDAebtRL2s/gCk9VgjjvBPTNILj/B2tHqqQEuB/UeJYtsgvmjc6QIjn2Cgr/qwo+K12VN5RiBqbU0bxOhBZnSXnAkrOKC3O59DjufaacLfZrF4IoAKqAze2ve1H/Pr1eX/cOkLeXAhJZwnKLQ9+tANpnvMFe5SJ+FHANrS6KaTWO8XlRLSAeJRordi7uhpaAm0pNxywLggfGNDNu2y+tj6bCNTZ7i5rRxt68oPEYVjmSkrG6ZInfASmd4Sam86SryHJigVY7cCX6M/T/xjMrO4lF9sb1VzYwSGrAKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(41300700001)(31686004)(6666004)(966005)(36756003)(8936002)(8676002)(5660300002)(316002)(44832011)(66476007)(66556008)(4326008)(66946007)(83380400001)(478600001)(2906002)(38100700002)(6486002)(186003)(6512007)(31696002)(26005)(6506007)(2616005)(53546011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktlSHhWMzFwcGx5Qmd1d2NVUG12c21xa241bTZKZWRHMUlBRmphVlpEWXlo?=
 =?utf-8?B?ei9YNk5aYksvZVRjclBWekUvZVdrWDZtMkVKMFlNRWI2TW1TUDZFbldNOXFs?=
 =?utf-8?B?SHpieWpETkZ4SU9UeUhMNTZqTlc3RUd4V0ZkNnJuQithT1FMeFFMM0RxTUhC?=
 =?utf-8?B?N1d6YVk0ZG0vWEdybFBSdHhtRElIb1hRRjlCby9yVXU0em9CMExVZTQwdDYx?=
 =?utf-8?B?eFhhbXBwVDV4QnVlOWNJenc4Vi9CaFRuVG5oYzRtcHZCTFhFSG9QNWJLR2sw?=
 =?utf-8?B?M2s5VEcyalFZOG1OUCt4TXl4aThrZXpJNWs0U09HdHFRQnhxNHgxTVkyLzZU?=
 =?utf-8?B?cW4wSElzSlNTWEZ2WnZvZ3BPemhvS1lOMG55elhHSmQwTElYNlBXVlVEc1hW?=
 =?utf-8?B?V1R3WExaNmNzQ3FNOTdFU0luR3RheFh4SnMzR0piOHoxNGoyT3cvcUVuLzJD?=
 =?utf-8?B?ZW85K0YybVhHL0w2M0N0QnRqWXo4UzYzbnRBZnRVVWxDdVJZMWZzVjdQcmov?=
 =?utf-8?B?YzllU3k5YVVMVXJabkZlV1plUVRXZk9DaUJ1OWZaSVNQSHZrZy9yUWFsKzNh?=
 =?utf-8?B?dG8xa3JHWU5ta3dzWFl1cmljWDZHT05oMHNqbzVJdXpPMXN3VWhSa29VZmE3?=
 =?utf-8?B?STFES0ovS2VnMFVDaGR6bE9wSkFQQlhOcEdBd3ZvMk1tenZ4NWtrK2NMdVZi?=
 =?utf-8?B?YVg4OEVGVnVKbk9mbjIyVXdZM0VhSVpyTVpQUFVtSlFTSVlPenVkalZpTGY2?=
 =?utf-8?B?cXVMcU56RWsycndyWTlKbTkvSmZqNytyazFwSjB3K1FkSnlBcnQ3YXVWTFhQ?=
 =?utf-8?B?YkNUZU9CL2tsbG8wUUt6aTRFTlJHem4xSWZoV2tJdzBmZ3d0dExDNGp1UWIr?=
 =?utf-8?B?eXlvR2pOeDFySHR1c2FaUTNwV0ZyNUlUbEUyMXkrVTY5bDNaS3dTYVJCZFMw?=
 =?utf-8?B?Q2FjLzVtc3FVQ1QzZm1kcHNmVllxREhYRU5jc0NQNDU2eVMwd05oenhTdFRD?=
 =?utf-8?B?OGR5RWgwTzZxc0xHdmNMQXc3UTQ0SHlzSGlPTkVwTnZlS1pkWlRHUHpEYy9Z?=
 =?utf-8?B?NGFROXBXS1FkYjJhdThudy9xaEhmeDJwbzBBOG5Nay9ySjlEeTkyMDVaVU5W?=
 =?utf-8?B?bGZIV3dsd2VpVUJtdVdkZTlHRzRtOW04Z2x2VURjSDN5WER2dk4wQVIvb3RB?=
 =?utf-8?B?US9zSEZiQ24xTGNKalJOUDVSOExBM1FwdndDUlNoSisyUGxkS1p6SEpuSENY?=
 =?utf-8?B?cVhseWRCdGNJZmJIUnlCV3ZDUDRXTm1xMmNOUTVFKytWWm53TG84cHkweTB5?=
 =?utf-8?B?VWNYR0xmQzBwcm9qZ3UvV3FXM1J5V3JHU2tRc0lZSHRsL1N1aTZzVS9DaFo1?=
 =?utf-8?B?cE04cGU5OVRuaXIwT25DS09qQWxjODMzTlJ4MDBWc3JvYXlHakdFTmtYUE9W?=
 =?utf-8?B?alEvMlVyQTFiL0QzTU9TT0tGNVVjVjVtK2NCSy9RMWZKYzhLUHNOVi9ubUpC?=
 =?utf-8?B?Z3pmbFZldEJWL1czTmFtL2VuRGpnUFcvNGF6WlY2YWc5SFo3b1JpemY5RU1j?=
 =?utf-8?B?ak1PRjFHUTlmSEdlUG9NdmtwZ1Z0b2cwVWpiMmFEWVA5ZE9HVXNOWHdDa212?=
 =?utf-8?B?cVBWcm5oa0V6WFBodVRacEh3QzBYOHlhQ3l1WVVXK1BNbGFVbldOUDBVZWRW?=
 =?utf-8?B?MGFEUGNwbUNVblJ4OW9Ka2xvSFBJSElTMmxXTlkxeHc1bytTeXd6MHNpMmly?=
 =?utf-8?B?em1lZzBrcGY3TkNlVVpnK0R5Y2tDQXN1ZVByZFNKZjhpNkxtY1NpZ0t1WGRz?=
 =?utf-8?B?bVNYQjNSSkxkNmliaUFrSE5OVUd6SDdyalVnbHZoVEphL1NmTmdyK0ZHMmh5?=
 =?utf-8?B?dlIvWU5BckNnRUpnbEhUVklhRkZiYTUxY3daK0JxTHlEcjVSUFdYTCtqUllE?=
 =?utf-8?B?OXhCOXE1dEk1QnRFblkvcjlQM2VodlFSVjJMNm1KQUZnd2VYclB4RXFuV1dl?=
 =?utf-8?B?SmVzTlBoU05xazlGVCt0czlyTTVzeWNBSExOSXNMbTh0NEJyd2FUWDlJV2Z1?=
 =?utf-8?B?dFg3Sm1yZWp5ZFovb3dzaEJTVm9PZjZmQTNEOWlQWC9DMVRWQ2JTQzZhRkVw?=
 =?utf-8?Q?e7Y2Hj8cbr41cXiNCZ9G/P1Df?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e685ea-d4ec-4662-60ea-08db6db29645
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 15:09:59.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoitwXhigtC+TAfB8U0iW9HKXKflOHO//LAte9q+29MYDvR5Hcv/rJgDrDHhFCoI0JhMgL2tYoIP00gTs6uJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/14/2023 10:03 PM, Shuai Xue wrote:
> 
> 
> On 2023/6/14 23:06, Yazen Ghannam wrote:
>> On 6/13/2023 10:06 PM, Shuai Xue wrote:
>>>
>>>
>>> On 2023/6/13 22:11, Yazen Ghannam wrote:
>>>> Define helper functions for legacy and SMCA systems in order to reuse
>>>> individual checks in later changes.
>>>>
>>>> Describe what each function is checking for, and correct the XEC bitmask
>>>> for SMCA.
>>>>
>>>> No functional change intended.
>>>>
>>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>> ---
>>>>    arch/x86/kernel/cpu/mce/amd.c | 30 +++++++++++++++++++++++++-----
>>>>    1 file changed, 25 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>>>> index 5e74610b39e7..1ccfb0c9257f 100644
>>>> --- a/arch/x86/kernel/cpu/mce/amd.c
>>>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>>>> @@ -713,17 +713,37 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>>>>            deferred_error_interrupt_enable(c);
>>>>    }
>>>>    -bool amd_mce_is_memory_error(struct mce *m)
>>>> +/*
>>>> + * DRAM ECC errors are reported in the Northbridge (bank 4) with
>>>> + * Extended Error Code 8.
>>>> + */
>>>> +static bool legacy_mce_is_memory_error(struct mce *m)
>>>> +{
>>>> +    return m->bank == 4 && XEC(m->status, 0x1f) == 8;
>>>> +}
>>>> +
>>>> +/*
>>>> + * DRAM ECC errors are reported in Unified Memory Controllers with
>>>> + * Extended Error Code 0.
>>>> + */
>>>> +static bool smca_mce_is_memory_error(struct mce *m)
>>>>    {
>>>>        enum smca_bank_types bank_type;
>>>> -    /* ErrCodeExt[20:16] */
>>>> -    u8 xec = (m->status >> 16) & 0x1f;
>>>> +
>>>> +    if (XEC(m->status, 0x3f))
>>>> +        return false;
>>>>          bank_type = smca_get_bank_type(m->extcpu, m->bank);
>>>> +
>>>> +    return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
>>>> +}
>>>> +
>>>> +bool amd_mce_is_memory_error(struct mce *m)
>>>> +{
>>>>        if (mce_flags.smca)
>>>> -        return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
>>>> +        return smca_mce_is_memory_error(m);
>>>>    -    return m->bank == 4 && xec == 0x8;
>>>> +    return legacy_mce_is_memory_error(m);
>>>>    }
>>>>      static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>>>
>>> Hi, Yazen,
>>>
>>> Which tree are you working on? This patch can not be applied to Linus master ?
>>> (commit b6dad5178ceaf23f369c3711062ce1f2afc33644)
>>>
>>
>> Hi Shuai,
>>
>> I'm using tip/master as the base.
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/
>>
>> Sorry, I forgot to mention this in the cover letter.
> 
> Ok. This patch itself looks good to me.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 

Thank you!

-Yazen

