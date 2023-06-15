Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A061F731CC9
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjFOPea (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjFOPe3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 11:34:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A82295D;
        Thu, 15 Jun 2023 08:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoGxm9+4Ki6wejoNSdpk8Kx5SkOO3VNsgtwmdL6d4pMkdN1K4CO00AbYOdD9o26gGY6ry7rGoLjUuruy8ngns+kMl0Ib4yA/XhagnNojJELDb8vO6Fwm4N9xrPMD+IyEwhW0o9kqV0qELPRktEF1NMph/CgwgabJ6T172UUINhOnhVwocsEq/aW+cQe9m1oQkhQs/23YKdu0Yr5zQODQ5b6utDd8oDuaFaiBXeKGXlM2uGuH290rI26zIJn0OeI4iv6IlXDyOAIgdq1yn3sd/YCf+vP0rrE1Wa6AFN7u7JQdaGCNVw2x6i/Z/7e8sBe7cP49SmRNZxOiEq+/89sMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3Vs9V/ysDQuYU1jGh+QBnK+RaTWWAtblAJeU9u+xpc=;
 b=Z4FlhbA7NB3aZmD/IoxhOjLh1oUBKTsim1IsleTfV4IYo9g74ZzHUdUYk5sYxPMLSBGqM0IUr0kt5nNLCWtrNUjx+JmErSTRQAcq9PtA2ChIYCS8kyBSR3LfT74D2gAOHpYSqy5biEQTozmM7SLIB4d9NJ0pqrFe53TVlykTy8UmW8Xc9uSAp9bZng9rQYz1D9mrlksmRFdG7hjynt4XRL57lCrBzdl1SaRS/Wv3hNyXVxn/n+e+MZ1Vn0Mjqku0aVnZ8UqCAI5mnGxoKzeO6jnn5FLyWcDPce0NuLshvFVdFZbB+rmdwpv5tzjTRf6ggu30z4SPSN/Cx0kivHr1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3Vs9V/ysDQuYU1jGh+QBnK+RaTWWAtblAJeU9u+xpc=;
 b=NWfiP1DPsCYBJvL1ZfRWsoVH5GMEFgX16ncvZoE6IMBq/ZqwSkDIqRDElE8+4iHgtZeympWmaJyoV12IXKVG6mcDGS0os7/aOaaxRL4/NPswL35zAYzHaSJ3DCYd5952zMwDCJ5Nx62BwNy1o6Hg/Iw5AA23VmFzCeenhKbm6qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Thu, 15 Jun
 2023 15:34:24 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Thu, 15 Jun 2023
 15:34:24 +0000
Message-ID: <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
Date:   Thu, 15 Jun 2023 11:34:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
To:     Borislav Petkov <bp@alien8.de>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:408:d4::25) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: e106e636-3e88-4be7-174c-08db6db5ff64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eORM913KUEsl4X+GSP7cfhy1w4f1vhwHEFOzsQUe/JK/QGcNuwdgKZwXsKJqhpxO6cNEgQmA+pfXvu1wV48bd8ZreoOp8UNKmVVOJ9fxif+UKSKGpOEpxaXnhcHSTK7+AdS+DwYbI54Po8PUdQV4dtcxs8FVdrqUGFZjTre/vI2CtagkG2YEdRrV59vW/8VfhQgCGCv5j6gG9mpj0CJwdsJNg3/jx43KWRSJQEOx8eYnNZM+aLW2MMzcw1Mttq/Kf7XK9xHx3NMMrW11EaAWPb9CwWGVSO1meiu6TYzQF+gu4JaNxO8jlbopYXUOr70mDV/P21pl5/i/NBLMrOQGSECiBTFxyiNo9ZQfUHDr+zUY1QpzbnbdJ5rcW7GP8R6qzggrR3jugbPoec2CAvMpcSKA8MSfpATiy1aKTBD8jP54TVxJQzm1sSLsE9Fh16Nr1EvzrGSJpjHRoyl9Y4pfd6v+P8iuW9FhlP4L59/j2xOTnIU7QgsDg937MaQclG1C28C/vPvkd+jh8rYLgrx/Y8sDsSWSyO41ylslzEdBn1X1L19HytQeGCV0Vnv+IVRjF08RXd60wpnueVOofXd9BxywNjlnKDY/WpiVk9CYwQ8Qx4bNmhs912oIZntGfvQ3v8rIbaRtjSmDbpcE8dZCMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(2616005)(83380400001)(86362001)(36756003)(31696002)(38100700002)(478600001)(41300700001)(44832011)(4326008)(6666004)(6486002)(8936002)(2906002)(8676002)(5660300002)(66556008)(66476007)(66946007)(31686004)(6916009)(316002)(53546011)(186003)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9nSDBRMTd4aXFaOWcxQVBBeXpJRWN2cmJwUjVGNXEzeldLRHFzRTEzNXg5?=
 =?utf-8?B?Qlk4b09obHdEQ2ppZUI1SSt1eWhLQk43QThDdm01UVY4TnpjUGlrajllcDkv?=
 =?utf-8?B?OFhySmFCYjMzcCtxQzZuRzRnNGJ2YVBJeWo0cGgrdVdQYkFTS2cxS3hodHoz?=
 =?utf-8?B?RmVVN0pZTGswR21nVzZTMUFVSlhTMkEzNmZLSXo2SGd6S2lrQ2ZGSVJCRXk2?=
 =?utf-8?B?VUVQUDJCSGYvZlBHK2l3QjVaYVBlazBocnRUY0NweHFzWEwxRHpwTWE4SG9E?=
 =?utf-8?B?ek01QmdlVUJaUlNUeHRQc3NDNlZUZW1HN0M4MUN1WWVhcjdhejdLUnB6dk9M?=
 =?utf-8?B?Q3ZyakxhbGp6V1hlZ1lxaHVnejlPYytPWG9ibHVJUk0vRlRoNk14ZFh0Qy9J?=
 =?utf-8?B?cWxuc0ZIeUdGa3lkcGJtUEtDckZCU2FLQ1h5YVRnUVlpazJqUDVmdFN0cnlG?=
 =?utf-8?B?dVd4RERmbGVmbWRHYlp3ckUrUEtIdDBHUmd6OVJHZTVadFVDcjZCbkErRklR?=
 =?utf-8?B?bllpdzUzSXNIQ1E4azFaRGVqWWJyajJaMm56USt5UE5sSHRwTUpVNk0rTklO?=
 =?utf-8?B?czlleFN2emtUakRwNUVPU0FvOFhUT0N0NnVMR0YzQnpULzJzdWdXcEJjOWpx?=
 =?utf-8?B?Rkd4VExLa3NibWpubWF2MFg3WGNYalVUbmx1VzRNdS9vbHNlREhSeU1uVUlz?=
 =?utf-8?B?dysxTUxzNlpKUlBEcHVKZlNBcHBnalVSQjZEU0RSRS81S21nTTdaV2krMGkr?=
 =?utf-8?B?QnpRdFZEZ1BhRmZ0V3V5OGpzb0J5bGprY2tJaVcxNVdGOG1IOXYxYW1rQXo3?=
 =?utf-8?B?R0xreHk3K1NsTDd2Slo1T0tkWis0MXN6VDBnTFpleXNNMWlyL2c5ZFFYdU1P?=
 =?utf-8?B?UEUrVzFMcGcyQUpYRFpDTGpPaWlMUCtmeHo2M2hmV093UmRZSEdMelg1T3Fv?=
 =?utf-8?B?bjUxU2FjQjcrS3JWTmVvMFhwWjJ4SkF3bFk3WE54MWU1SVRFN0pEUDYxR0Rn?=
 =?utf-8?B?c2lqQWZ0dWg5T1hTWmhLY1JLYzdtd01ZM0NvMklDeDRmbGYzdE9KMGxPRjJC?=
 =?utf-8?B?UVI2ZHZGcUVqSVVYdDNYcmRDUFNLdUNPQ3VWck1xa2w2d0d5Q1ppSExJU1hX?=
 =?utf-8?B?WVF1SkUvVHR5cGtZT2NJSlpIeGNsNkRvYklIVGgyalZFZmRJa2FBT0JNblFG?=
 =?utf-8?B?aE9YMGNTbUkvOVdFUHlMM3gzYkF1cjBqNmhwc0o5K0lhTVFwUHgzS2dFTUlk?=
 =?utf-8?B?akp4OHJrU0dCdXNGKzVCNFplYTJJazJrdzJobmZ4OWZsQ2FOT2V5cytKbTk0?=
 =?utf-8?B?dUVFVEhIVmN2d20xYmpnUit1TlJXU2xMUHFzQnc2dHIxNHdaT2ovMVlIMzln?=
 =?utf-8?B?ZCt6Y0hDeVQ5TllJZHh4VGJYcEJGMVBYTGdQeHdsbG5JbVM1cm1DdHY4YnRz?=
 =?utf-8?B?a0JydDJpanp1WGdoUjdKSFVJRzZ3T1dpK3o4bzVDM0tXOHpROWpnSGtvOHJa?=
 =?utf-8?B?L20xMW9MZ0wveW9lbU1Vc0ZTaldJYjZjTHc5RUNlMUk1cXhLSDNscUs5Q2hO?=
 =?utf-8?B?WEp2UnpuSVgwN0Nhd01IcDZOeVE2L1lqMmFmWHljLy9xais1R3lYV2tIZVFB?=
 =?utf-8?B?TndNcUZseGRYdDk0WDk5Tkh2TjU2Y1pnNzhjMmZkc2t6RmM4Y0gzTnV1TVg3?=
 =?utf-8?B?VFJJSmg5OUpiaHJmcWdEREl2RVRBZ2VVYjZ4UE55SXRTc0ZPR2xsTFVibVZY?=
 =?utf-8?B?THhjTFFIWllrNVBXaHR1dFQ2NXdvTThQMFhJaEFTaklGeFp0bzVnVmJ3TlJO?=
 =?utf-8?B?TDd4a3krdEo1YzVsSWVFUXFmbXlJRlQ1aTdTTmZSbkxYREZXSVM0U1NCc2lV?=
 =?utf-8?B?TUF5cUhsVFFkVitvellsQjB6bkRROXAvdms1dGFzZ2QycVRPLzRVYXI5LzZQ?=
 =?utf-8?B?ZmxVaVptV1p6Vm5PV1hqRFFhc2pXOXFjeXZLRlMxN3lpTGlBMGJZekZyZWw1?=
 =?utf-8?B?OHhuYTBRblNHTjA2NC8xOFZ6MGNjU1JEeVVDbWlES0xvNVdOei9aRUV4UXNE?=
 =?utf-8?B?K281bVk2SFhoM2JhV00xNHVEVGZYeVFWK1AxKzJKOUl3Y28xZWFKaVg4VWRh?=
 =?utf-8?Q?sxuWSrb4rVTQwjjDYak5mvKwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e106e636-3e88-4be7-174c-08db6db5ff64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 15:34:24.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj9iWeS6wHOxRJCDZl49m3jLMO7kFHpWKOFjQ4+dzP3EzV4CJLaYfERkhOcMpfYdXeDVcv9m2/257EA4X9PAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/2023 11:20 AM, Borislav Petkov wrote:
> On Mon, Apr 17, 2023 at 04:20:06PM +0000, Yazen Ghannam wrote:
>> @@ -97,20 +102,13 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>>   	if (ctx_info->reg_arr_size < 48)
>>   		return -EINVAL;
>>   
>> -	mce_setup(&m);
>> -
>> -	m.extcpu = -1;
>> -	m.socketid = -1;
>> -
>> -	for_each_possible_cpu(cpu) {
>> -		if (cpu_data(cpu).initial_apicid == lapic_id) {
>> -			m.extcpu = cpu;
>> -			m.socketid = cpu_data(m.extcpu).phys_proc_id;
>> +	for_each_possible_cpu(cpu)
>> +		if (cpu_data(cpu).initial_apicid == lapic_id)
>>   			break;
>> -		}
>> -	}
>>   
>> -	m.apicid = lapic_id;
>> +	if (smp_call_function_single(cpu, __mce_setup, &m, 1))
> 
> I can see the following call-chain from NMI context which is a no-no:
> 
> ghes_notify_nmi
> |-> ghes_in_nmi_spool_from_list
>      |-> ghes_in_nmi_queue_one_entry
>          |-> __ghes_panic
> 	    |-> __ghes_print_estatus
> 	        |-> cper_estatus_print
> 		    |-> cper_estatus_print_section
> 		        |-> cper_print_proc_ia
> 			    |-> arch_apei_report_x86_error
> 			        |-> apei_smca_report_x86_error
> 				    |-> smp_call_function_single
> 
> 

Right, but in practice SMCA errors are not reported through GHES at 
runtime. They will only come in through BERT at boot time. There aren't 
any plans to change this, so the NMI issue won't be encountered.

I can include this info in the commit message and/or code comments. Is 
this okay?

We can solve the NMI issue if it ever comes up in the future. Unless 
there's an obvious change to avoid this now. Any suggestions?

Thanks,
Yazen

