Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01273A8F4
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFVTYR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVTYQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 15:24:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBBB26A1;
        Thu, 22 Jun 2023 12:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C39Lq945OIQ0jhqDOG6EuGoFPhOX83rDBJ+X9C2p44ByJ1x+75FCyiWZ7JOuov47/3kuVOBZ7zbfAx5BxKjgLdUSClvATliLNBn6BWBf32XU8ND4TgSjzy5sKU6VTs1gHe6ZB18G+a7vWPZEu3IFLABCu+/U3cpyKcN8mQ2cWFsQZk2CZdb7McGfANPcQLiK8NCaR6dpnh/9KG58ZCnM7Iz0CNfEQ4YuYqqbwCqGbPKL7pzfn88bFkEoFIrcePbsAiFDbAISerQi92RrYm0NHAz5Ikc9yVRy+/Ovwt079/M/3AJ3WpUngLynBOo9ycr2pIX0lEjRWA0jo721/P+/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJdoPLwTR1TXYaN66s/glS1mw9jRGf46wfpIunsd47E=;
 b=GLIX7kDi8AEeJgLneWTFOc7DU5VCoKawy1WVKB5s4lEJOlRhNJYWQ0upNhHlzQ5R255QfVUqS6k3qavnNfDuRqpa4xl7bNvh02ztwic3pq6Sbvt+fzO0xU0u7CxtQvb2qwBWzWwGHlvf1g3Ds5ec1dSc06Y3mvsTzm5QwmGK+clkI5bHq00C7oQ0uJnY2j/zJD51783XPy7LNFEkSilJb/UZPgwNFa3lEX38YYD1VQNvb3MccYcvRwPIZwM7q1qhyJdcXA1f/EmyOyaDKk2pUaUoKytBNksTasHWdNvDZLA1e9tex9y++/iSpM3lhly2fqMio+E1ylkkOxhm082I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJdoPLwTR1TXYaN66s/glS1mw9jRGf46wfpIunsd47E=;
 b=KCH6e9SGOqqvUMU0QhALoRrkG+SW1Es8bqy6AYwXX7p7NxsggRKYgzaWwXAFFqHhLQnMUpUFCOD7fDZq6bEPavHRkkdrwmVL71WejXL508bK4odjL0SUwCUZK0biSvXbGTRCO63dctWjZWpdhqu87ZdmquQMQhGcxRDos+iK7ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 19:23:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 19:23:51 +0000
Message-ID: <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
Date:   Thu, 22 Jun 2023 15:23:49 -0400
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
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e2187c-2aa7-4eeb-a914-08db735635f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPyPaTtSydAVXZGmIQ/cSmOMok2mMGq2enHy0a9+2WlFTCzqEbAIIg2Her2ao4iicXcDXwMJDJ6mbd05AUigmTwrTBzmxGb/yIP/kpgFS2U9dkKxBFsz3o7Na2qiRLIGyRWqzCoeipzMVTBDRpyuYU9Qrl4OcOEVPwwWgJVZ2wOtVFNaQaQrsCveQhZJM+x+4bAM+aGLfmoxjrD10f34UPKpf0WyXyjQg/ELyuuoxW1sPTUCqsMGckr/lthHUfJDQMrWuGrLgtnF0J1+2l/UQKPYV5YubYZtn0tbDE8ijerYAioIwFoN0ebb5pq/TVfdgWgKZB4oVSmv+DGyYSxS/MQdfmb9/JfbaVHzLAOnMdJf9K7rcqf2mMtjAwOqlPUE5ApUFYn2xwrp9NBkm6KjvPlAwCbfF1736wtemYiHAnxB2wZzuQdO6rNBZwy43iwaIyr+PgZeX3SJsaMqFiSAgTOudgg3gJZCsX1vp3ow2hUaBkIl4qmNK4Q/NLYHQ1tYbkWppLyCrBisuWWYps6yw8QWqkoldjC3nhpDzVCE+QTTEVGoYiL/IM4suCO9/hMpzjjnQYv9+qnuQcs+BIE21bL/1MhR3m/+VH8BQM24W2WmMIHSyzW0nyLK3zdeK8u+JZ2619YFGUKlmsKGyL3ppg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(41300700001)(5660300002)(44832011)(2906002)(8676002)(8936002)(4326008)(83380400001)(31696002)(36756003)(86362001)(38100700002)(31686004)(186003)(54906003)(66476007)(478600001)(6486002)(66556008)(66946007)(2616005)(26005)(6512007)(316002)(6506007)(53546011)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHptY1U5WnZ3UWMzRElNWXJqWWdkRmZvRHpyditRKzN0OHVjMGl0a0J6N2Ey?=
 =?utf-8?B?d3g5ekxTNFdVYytOdUtNYzVkdVBaWG5SNzlVbVd3dlBBcE10NkNGdDcrMG90?=
 =?utf-8?B?RlY1Y2kySHNoTGJERUpjQ09xNWo1c2JxTW5YYjM5NTRqbEQ5a3JraFFRNmkv?=
 =?utf-8?B?RUdBaUgxS2lkSm9VUDJXeXZzbFJQVUIvd2YzWTNpNzJ1TWZpSm5IaDRKcktQ?=
 =?utf-8?B?ZlJoTlB3a2JXb0FRdzhQNUdWMTA0ZXV4NWlQcUhaV3ErTGRHTE4ydUxBUUVN?=
 =?utf-8?B?MEVBd3BKQ1lWdHk3V1dtcFdNelpLcklCMS9QL1FHSXMxcEFFL0NHYlJaY0J4?=
 =?utf-8?B?aFV2ZTdGeXc2Qnlaek9GM29pRVp3QWI4QzlWM2pORE5XSUtWYk5nT0o3SGpJ?=
 =?utf-8?B?ckNkVjV5bFRHTkxGazh1VGRsdjFUcjB3bExYbStXTStNYmswcDdHVHdNd0dR?=
 =?utf-8?B?MDJyRWIvNjVINzIxWEltYURaK2F0YVlvVmRMQU1yS25PdWY5WEQyTStGZ3Bq?=
 =?utf-8?B?UnB0RWhrSFpZTkpvNnh3a0JCUFV0RFhqMmNvYktHbVFtcG92ay8wR1JtaEdq?=
 =?utf-8?B?TVMzWWVxQi9PZFk4TVUydGViNmZ1RDFjeWZFZTNLRVJ3WFBJc1M1eTRlbzQ5?=
 =?utf-8?B?elRRVzB5OTZmb0kxbFJ3ekRzMjVodVFFRGE2YWdwWEZyeFFnWGtXUjdneHlC?=
 =?utf-8?B?ckVaei9LdUN6ejIvUlVka0s4d0lMUGRjVU43ZCthNFk4TVlIRnA5NEtyOXFp?=
 =?utf-8?B?T1g1aGFsRjMrZXJkeDR1VWd0dDRNUG5FODVIeWUzeHN3eTJRVHlKa01XeHl0?=
 =?utf-8?B?TnlMVzdMVk51bVVLenlWeVBXRXRVNktmOEJ0b0lXK0ovbU1uM3NHNU15U0NZ?=
 =?utf-8?B?YnNTa1NNRUxldlRTUDlWcHN5S1NPdUluK01wbFlLa2lpbDVtTys5cFp5bTZn?=
 =?utf-8?B?d2FFYURNRXM3ankzKy8yZTFuTWVtekp6Y2ZsV1NhWTVWU3RQNXl0aGU0enJU?=
 =?utf-8?B?R2RoUXdDeTdKREN0SWhKSkdvMkQvcFliWGVOV0pQRTBRL25BaURnWkJPcVhk?=
 =?utf-8?B?RHQ0cTZESWQ3UERvTGZZQlZsRkpOMVgzaVdmbkFsVk8xMXJOWWRLVlhJR1BU?=
 =?utf-8?B?SHRHRHltT2RRbC82c3JmUXVzdEZLU0xBMjJuaHBOWDAxQkxmc0J3UmxkamV5?=
 =?utf-8?B?RkwwRysxNDdMY3ZNMlRVQlkwMTNKY29WUS84NGVDdlg1TzIrT292TmVmNTdv?=
 =?utf-8?B?cVVDQlczMGVjQ05MREVnQ3hCMFYvNWhyTHdDNnZYRTUzZUN1b3l2aWgwUUZZ?=
 =?utf-8?B?L2lsQlMzV0Y1VXkrUDVRd2xCZzJCaFhpTnRoNDN2Nk9pTWYwS1FiV0JhRkFr?=
 =?utf-8?B?V2RtdURUMFBCOGR2eGNUUTNBbDBXVkR2UmhkRDNVOGdpb09mTk1JbDVkOGh4?=
 =?utf-8?B?cTJjN2czaElXZGJOTDRwMDFmOVlYRUY4S0lFOEl3VDhrMmVYY2hxb0hNWXor?=
 =?utf-8?B?dWoxVlNTOUpoMmhicXlqN0JBeFAvV25MdXdnOHRvbVk3eThuWFZtdjhmYmNZ?=
 =?utf-8?B?NlVmQW1nVElhd2Q0cEhDTEdCY1VPWldVRzNvanF6cDROMVlIL25scHcwaUdw?=
 =?utf-8?B?UnExL3N2QXdSd2xPUjVna1N2Z25GdlUzSHB5ZDhadjVkeDRrMG1tbEt3VVFI?=
 =?utf-8?B?MU9VQzRhYVZVZlJrWXlEblhHTzRBekNDRk1yWGc1WUk2MWw1UllXY3N2OXcx?=
 =?utf-8?B?bE95bUROZVJ0dzkwb09YSHJEdzJyakQwNzNqRHMvdHN3VEEzZnBIYlNKOThz?=
 =?utf-8?B?RFBOMU05WmtRM29jNDE5L0dSNTJZR3ZwM0dreU93Y1l4dW1VcXk3akZZck0w?=
 =?utf-8?B?OE1XR2NRQno3S2lEcCtqbkxlRWFRaXo5OG9xOEppNFROTEpWKzV1aHZRaXE5?=
 =?utf-8?B?SkNhcURmTEJNaTlOTXBhT1NSSTJvQkNXRGltTGZTOGtobmdpSFg0Qk5HdlFB?=
 =?utf-8?B?bHU0RVJnbVVrSXBJemhMZWpjMUlpcDFpNjNqVW85WTFHRmRkRVRLdUFsQVk3?=
 =?utf-8?B?K211MWtrcFlybXRkZGNXdHphbjZGQjA3LzBRaGRFNGxIa0lXQk1DV0xIM3hu?=
 =?utf-8?Q?oxIF2wkxGsvFM7uxifh5V8S18?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e2187c-2aa7-4eeb-a914-08db735635f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 19:23:51.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Gn1L8ltRjVB9gEk0zt3Y1DZ6+rhBwSKlNu8wrCXcWi7zaD0nXshKv91vm/SNE0BjtMaVLQ5nV4a8RDRwqMbfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/22/2023 1:05 PM, Luck, Tony wrote:
>> This is the reason we search for the logical CPU number using the Local
>> APIC ID provided in the CPER. And fill in relevant data using that CPU
>> number.
> 
> So you don't care which CPU number mce_setup() used because you are
> going to update it with the right one from CPER?
>

That's right.

> Then maybe the fix for part 1 is just to use raw_smp_processor_id() instead of
> smp_processor_id() to avoid the warning for calling with pre-emption enabled,
> instead of disabling premption with the get_cpu() ... put_cpu() wrap around the
> call to mce_setup()?

You mean use raw_smp_processor_id() in mce_setup()? I thought about 
that, but decided against it. I figure the preemption warning is helpful 
to catch issues when mce_setup() *is* supposed to run on the current CPU 
but doesn't.

This BERT decoding path is the only exception AFAIK. So I didn't want to 
change the common code for a single exception.

I just noticed a similar potential issue with mce_setup() in 
apei_mce_report_mem_error(). How is the CPU number decided there? Is it 
always "don't care", since the mce record is "fake"?

Here are another couple of solutions for the preemption issue.
1) Don't use mce_setup() at all. Instead, do the memset(), etc. in the 
local function. This would result in some code duplication.
2) Split mce_setup() into global and per_cpu parts. The memset(), cpuid, 
etc. would be global, and the cpu_data()* and rdmsr() would be per_cpu.

Option #2 can also be used in apei_mce_report_mem_error(), I think.

Thanks,
Yazen

