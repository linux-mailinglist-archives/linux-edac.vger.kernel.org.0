Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DBA73B921
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 15:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFWNwA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFWNv7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 09:51:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566D1B3;
        Fri, 23 Jun 2023 06:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O45H30Slh1H5t8S2wR9tdHhqkKT0XyLaoHo949OvvbCrL5gNEMpLowQIgyeZX+Xfs0/VA633eQcGcC1gTs/ap9mJKzcslELDPKKewmhyNfv8r5MUh7wG2EdEPLkCzl6NocVvUTad20sPRmt+6Rmpay7gzKh1xIE0xsiXaY/GYwzZnQMKkDeSWEFUIN+FmHGdpWl7e+CXurke+oyJO1tfJNdEtbpuEH3R9OPuggwCtGGRZX6BTuOaa/l848UMR/RcGYaolWI77sb+tjoN6wDyJJuPY+sbwcFjumNf7eYwnphJX4dqb5HBsJEOHrhnThwq5WK0N5+bh9kTYXNypjsfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/29+WFd4D6M0IFqIlxQVxsw6Go8ZZGs6Q/BvrUCPXxw=;
 b=UNRPpSgzTTYaoqPVZMmi81VfTl6vd++4HfCmpH6k5PYx3yqo1SEVtIB7vSE3hRPmQ+hg9IpeT0ZwxN6SoWIZQkUzmMlwHgeYlo6q2Pta7N109G410WQTLVXINFTVw6VwAUVDYQyYxNKyYjfelsyI/1DCjJqXVwhAGBjYAtb9d5RQ9u0Xr8oB6T6PFQdI3kA9DL1u9WfWe4P8ejJiqzo6AgYsyL58yJhd76s9FkO+QeGErPWXBdo1va8BFY2caeBunN6lSE/v4S8P/aegKJAvlkZs4vixAJuAl3NQvuR0gXn2j9J7ne6DAZBFutb41PCVlCTk6IGCHK1E+ryQoZHA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/29+WFd4D6M0IFqIlxQVxsw6Go8ZZGs6Q/BvrUCPXxw=;
 b=HrJwQnc4mldeaIV8zV5mrQqVfZ0b//eK8wxKzCzJRNr6tV2F2VD45p3C1SFh61+6G+zfzXwT/EhhY+SUpHd7uL3466/EUkFI5zBXMTzveU+hQSy/ZdyFId52/RmTr1TCm2jNsBUnlJTFRZyIhffci7UKzJcOhDruas4vgBWy258=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 13:51:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 13:51:50 +0000
Message-ID: <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
Date:   Fri, 23 Jun 2023 09:51:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
 <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0846.namprd03.prod.outlook.com
 (2603:10b6:408:13d::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: f015e6a2-e743-4327-d786-08db73f0fe59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w76rwcojSWGTVHSqyD3G5jmMuqm2XdJuyuxj15vax6hbdsYwjB2bbwJX1fS74BdAMyYCa4bk88L+V04R8FUrVYmhpNxlfgdadOukLdL2MlMl8UXuYS3PkpmrKlDQokhW5chaJl9/9L2KKDkvgTQgZLl+lc12maqOzDVC6CLlaElNfF/QNkyP0TyAFGySeagqHWS6L6eUXuQA5wVB14WICrwcD8i9uPkMD6zQGPYnO9PJLP03V5r4fnKzWOFkVnnol31CqtdU4bFmG1ALQ1yEwXDuimLFCdGwe1z42EdNnGyDkBzDAB/rRCmX2DOxw5ghFz9LQ4niYuig5Cw/0QAJHU23cOBW9GAGWrfgkrhZ8I5o1XWm44FmFim5wumeM6kHoQffOpKgoL/Iy2YfL5VUSqIMOWFplaSweDT+FwShqZYIZF/xVrcMECFSKu1Woa3PLWVT8S4Jg+mwX+ubQixFGOeVSpiuummzzg1y36IPwmpOib+CV7fSvwBb7eLG5gN2LT7IQ4qloQp8GMM1ZZRHFDscjswYmDZWzjhoKOa7rthKfQ6uPF8QvXfr+0vmq/eoS2hzu5mZZioGRWpIzpy4gfcZXA23s4Tk/gI5C4uentjFjFm21Qrr56lVQ7Ko4f/puGOXaRS0JQNN97kOb1+lDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(54906003)(110136005)(478600001)(26005)(6506007)(53546011)(6512007)(6666004)(6486002)(44832011)(5660300002)(2906002)(36756003)(66476007)(66946007)(66556008)(4326008)(31696002)(86362001)(8936002)(41300700001)(8676002)(83380400001)(316002)(31686004)(38100700002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmdub25PTUh1NTRyUFh5emN2YnB2UzVDd25RWTVHckxOU1ZSdllTYXErd2Zs?=
 =?utf-8?B?c0lmMVM3MTgxL0FrMXpPRUhpdzdudlJuMHRKUzcxcFY3U010WFd0MjVveFVO?=
 =?utf-8?B?ZTV4aEoyMSt2SHVGLzBUMTJkSDhrekQva1BKL0pXUkoyUVRyTnRyV2xSMGY2?=
 =?utf-8?B?OUxsTE9HaEp3YzEySzJDcGpIQ2lwc2ZlTE9Edm1DNzIycjBmRENCakNpblRs?=
 =?utf-8?B?Q1ZqYUQ4YkRFaERzckVQUnVqbEt0cWZRVVJybng4b0huakJoUkJFS1lWVUVy?=
 =?utf-8?B?cHdvN1IvOFRTdXEvdzhhN1Nmei8xakwrM0tPeS9ncE1rMG1YUFlQSGdSYmVT?=
 =?utf-8?B?dGdiLzc3Wm9iOXJjNTFoYm0vWmJPSEtTczVxM1lISUhFcXZFV2F6M0ZPOEVt?=
 =?utf-8?B?VlFHSmpuUEg3bTlLbFIzK01hRCtKYzQ5aEFvTGc3Szg2QXhaRmpESkFxbkpx?=
 =?utf-8?B?QmlPREdvT2ZmNGpibGp4VDR0Q1A0dmJlWUtmbzJBaVZkSEQrb09qMnM5cm1V?=
 =?utf-8?B?Tkh2cmpZRkVvSmI1UytnTHJIYkthNzZVTVp6NEcyRGtpckorYTZkOTRjcldt?=
 =?utf-8?B?NmhqYjRzVzlrZ2lvQ3JxK2ZwYXBJL2NqbGtWb0tmQVBLVGxJOHlIaTZVdFZx?=
 =?utf-8?B?WFlHYkhUWTlmZVVSZXVjYlBreFVnWmhlYTNYVzBqeVErY2RZL3dUUitmN3FJ?=
 =?utf-8?B?dFdVOGtHSjIzWldtNHFRRmZZZ3YyNEp4N0lvaTBBdFlBQzVkb3ZkK1JrMkRi?=
 =?utf-8?B?YzRnd2JEUjZvN25uMWpmSEhFajI2OTNFTWlhY2FqL3BuN3RXaXpVTWM0UnZI?=
 =?utf-8?B?WHNBcE5wSy9QdXFEZXJqUWMrVWdkREQ4OHJEaE12NjVwZ01VQlV0ZU5DaU4r?=
 =?utf-8?B?VmFNdWwvRG52S0dMbzRvWllUZ0dQYjJaOVlQekRkVmxVNFhUbjJPZnNzZ01q?=
 =?utf-8?B?dW5xTjFXNTdBbHJMMHpyZFNlTHpvbW0xZkY1dklpNVpHWU93dE5ScjdaNloy?=
 =?utf-8?B?TWJ6aVppUkNzL1lvdk01My9TTGh0bzZKdDVBVDN3RTlkOU1IckpvUnJTUWFQ?=
 =?utf-8?B?aWVpUHJPSUNpYmc4NkEyL3A3Yk1uZjJHb0dGMWI5eHlTeWlJWXFka0Z0NXdD?=
 =?utf-8?B?dmFad3dkL0ZrM3l2czI5QlUyVEtxMzJaWVZ3cWxLbkliRHp1c1g2cm9mdlVo?=
 =?utf-8?B?MjZEdGRTWE9Tc1crN0R4dG1rT1Y1dUdmS3JrRm1lekdybXdIYTNZYk9DL2V2?=
 =?utf-8?B?a0hZWm10TkgvcXBud0l1dVR0SWJ6b2xVWEhVTUZtYnNMOG5KV0VMMGZkdlZx?=
 =?utf-8?B?dWd5b3NBbXJoWGw4eXBlZTlyUkhVNUViVVFxK0hidStnQmVmVjFTUXFXSjc1?=
 =?utf-8?B?SUpiRkF2L3QyYUdiZ0hyRldIRFBLdkxIb2tTOHhWWEhINU4rMWVrWWpVYkdG?=
 =?utf-8?B?Smhtb1dOVEIwRjlYWDVsYU04MzBSMnkxVXFYZGZSaTFOQVM1VGQ2OUtBb3Iv?=
 =?utf-8?B?QzF4M0hoM0dTQm5IVzZISjdHMW53ak1oY2FWYXlETmplcHhudzc2dUJRUUZU?=
 =?utf-8?B?bGM1TlQ2TzdXcUVTbjFqTldtbG13eTFQaktkVlY4cVAwSC9JV2VvSEIyNkpT?=
 =?utf-8?B?YVpBL05DeDVjR0N1dFR1d1RNYURXSmROQ1FvTzI5eU5ENm9TYVZRSEgvcUVG?=
 =?utf-8?B?aG9ENS9xb2h1UFpZZ2M2bm4wUWFKQnVrRjNMVDFVODczSlZhOE9iSkpqdnBw?=
 =?utf-8?B?V0w3Q29Pc3JjeUZsQStQWUc3SjZOb1RvMXVUb3B5Yk83UUZ1VlNuZ1V3UW5O?=
 =?utf-8?B?Zml5bDZnOVhNdVpxZWF0UGg4QzVPMnNhNVRFTTRyTU1oa1lrUFFSVWgwdDNx?=
 =?utf-8?B?NlNCWk9QcXNrREdOamkrRG1NYU5QWkNGVjlKMHREWXVtbDFPK1JDU0dsRzdJ?=
 =?utf-8?B?ZFpsMURRTE5HZnQ3UnljVGYyMWJTckFTUTdTZlNiY0pKTGp2NExSbGdmakZu?=
 =?utf-8?B?TzRQcmVjUHZvRW9OWGZSQjIxbUhkQ3JJMXlIZzVjVFBmVTFVNTNvSlFQU1BP?=
 =?utf-8?B?SFpkRWx1MFM4R0VodWptR2VOT0djM0ZiQk1HV3krY2tUU3JxanFHb0c1TWpy?=
 =?utf-8?Q?PVGEQNmkN8FhGcMaBYXlgeKSB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f015e6a2-e743-4327-d786-08db73f0fe59
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:51:50.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ABB2fzzUdJJVF1biId1EU3Lkp46GwFmC3i7c6lLdwhBu2qfQGWoF75bBc3kGhjtEfv3YZsA+dUqm8F8jIFh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/22/2023 3:42 PM, Luck, Tony wrote:
>> 2) Split mce_setup() into global and per_cpu parts. The memset(), cpuid,
>> etc. would be global, and the cpu_data()* and rdmsr() would be per_cpu.
> 
> That sounds good. So global is:
> 
>          memset(m, 0, sizeof(struct mce));
>          /* need the internal __ version to avoid deadlocks */
>          m->time = __ktime_get_real_seconds();
>          m->cpuvendor = boot_cpu_data.x86_vendor;
>          m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);

MCG_CAP would be per_cpu, because the bank count can vary. But I don't 
think this matters in practice. So leaving it global is okay, I think.

>          m->microcode = boot_cpu_data.microcode;
>          m->cpuid = cpuid_eax(1);
> 
> Though that last one is perhaps per-cpu if you want to allow for mixed-stepping systems.
> Perhaps m->time also? Questionable whether it is useful to log time this record
> was created, when it refers to something much earlier in the BERT case.
>

I agree about m->time. It doesn't seem useful in this case.

But I don't know about m->cpuid. Mixing processor revisions is not 
allowed on AMD systems, and I don't know about other vendors. So I'd 
leave m->cpuid as global unless there's a strong case otherwise.

> and per-cpu is:
> 
>          m->cpu = m->extcpu = smp_processor_id();
>          m->socketid = cpu_data(m->extcpu).phys_proc_id;
>          m->apicid = cpu_data(m->extcpu).initial_apicid;
>          m->ppin = cpu_data(m->extcpu).ppin;
> 
>> Option #2 can also be used in apei_mce_report_mem_error(), I think.
> 
> Agreed.
> 

Okay, I'll update that too.

Thanks,
Yazen

