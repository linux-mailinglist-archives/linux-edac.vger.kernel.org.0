Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFA7302FB
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbjFNPJi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbjFNPJf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 11:09:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55FE1FEB;
        Wed, 14 Jun 2023 08:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/wNYU6cALCaLXoWdXIGsDy5fA6U6lF0Pcuv6Mkh45cvyr3XKtkZolK+ff1jwWXro/w7gGqCmCwqBWtYrxEpZJw+6EP3sNzePgCWvtvtZljDIsN0AaBP2vLOTy++Q4bqeu3ZFjul99CvcaS280/PwzW7Fgjv0oMxSVB4DmSDGPSa3P5v/EMKPBkJIFiRDdvtQcNyE/oUqpLBDc3ewpOukuIs0W3L/3oEPDlmS3o2BNq7nUM00HiX/u4eCtlxTFrM6iX6nHM2nBU8mtLsdK2AvqrWpAF73BONP453w2tqUXb0odttrubeKx4fMiTMwTXCBKFN3La8qSCu/PjfYbyEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOILRrAeLSwYJQk05MEZJHYICd+7P2lmWv7nL3teK5w=;
 b=RugIGdhCZS8F7hsqYiUmCKC39hKLwvXOOHFBI94431w4IMrzVR/FtRKPXrzn6h/sLX99uGH/9gbjXZxhtYwzFWE3US9yrWO34M40lEfZjEHekAJCzh6gnQ50Bt507AGOvvMKDCLZjuFYWS4wSAmlXAUXzta2R0ymHHCWqtLpBoKAxobf0rg342BnCybQNwfpeROZdWyxNujB6hFDqXv6caNnF2jRIefZgYK/8zy1AY/VzlWEVGxq5WZ8YsfOx72Icg4S3zfu4kKWcERzb7G1gzJRE7/lukuqgDE5XUr45M94c/pYey5XL7/bjmZa724DeHu2zCtFaNIudHdouhoWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOILRrAeLSwYJQk05MEZJHYICd+7P2lmWv7nL3teK5w=;
 b=YjV5l8NtZ3NBfvG30CDYAVrktife5YUHG7cIwj9Kolzb2nL5Szg3iANpVAgaz+PH94ZgXfgLjSojjOlfm6YbZsRkQ+INMxG6K3gMWdNsKaDPp4+hwQH4aWff4vP8dJF318rUDyhv1rKzCeMCYIawYiJKI4NUa4AwAyF+z9BK7DQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 15:09:14 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Wed, 14 Jun 2023
 15:09:14 +0000
Message-ID: <1e9b1a0c-564d-6a3c-c253-1b1da1773ecc@amd.com>
Date:   Wed, 14 Jun 2023 11:09:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, muralidhara.mk@amd.com,
        joao.m.martins@oracle.com, william.roche@oracle.com,
        boris.ostrovsky@oracle.com, john.allen@amd.com,
        baolin.wang@linux.alibaba.com
Subject: Re: [PATCH 2/3] x86/mce: Define amd_mce_usable_address()
Content-Language: en-US
To:     Shuai Xue <xueshuai@linux.alibaba.com>, linux-edac@vger.kernel.org
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-3-yazen.ghannam@amd.com>
 <31fdaacc-cc2b-5ea5-8a0e-e5ccfe674834@linux.alibaba.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <31fdaacc-cc2b-5ea5-8a0e-e5ccfe674834@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0542.namprd03.prod.outlook.com
 (2603:10b6:408:138::7) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f11f40d-5627-46ed-ddea-08db6ce9510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bopNhmNCx4M3gq+F0yi+JxRZihtbXs1soVabc09NY3Qi/yCIh4ebKoK9bNNuPL9XtmYyStPFc59ful1U16yuKLFr1FAOSYzAbGmIxVP8T3ku3svNguG4Qs/xA5oyeS/SdxZfs4DOK3xWWKgPg31SoW6Te2p/Fy+E98CvASvtSg5JndJFk7Q40gC/nt60P2pWkoGRiUJqmv8fvf6EDMfBgIMyrUfYBasXQMy0Xc6vwEFK8tjAx1+rlJewr/bb8hR4rKHO0x9YrNFrE1VgLa06y9iUuLB+Vbu8iZ/O44uIPwhNf47P0U/Di3fwuSgrNYK6VbqnwAfNLNftbCBaOcYLCirupa26ZT/w5+z7UryAVOhrxkCqCCXbxaE7lLVbF2q9nvbqCa0TlsPzzgP7gX+m6CHmwh/XdmDx6D6T2SyEjWqCy51/3ubGxcI0Z0JqUa857XtbFcEvzn94gLfti+52w7hi6PLx9xpLpxkRXgYY5kHD5ZM/zzIR8OHhIcKIG5VbZRWcp3uQ9PipJ6IVHzrkYGxdO4dF5AFnuWyePSddmmAtzk9PZXKl6p/lrkdlPhw6WK5g2Ko4FE+m8+7vOn3YRt4nG9uAiWVIIdy+rXF5UupnO8zt3pTyeYNG4aEvsLMskbmKblU297Ij58+K7Wl+Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(26005)(6506007)(6666004)(186003)(478600001)(53546011)(6512007)(44832011)(86362001)(31696002)(6486002)(4326008)(31686004)(66476007)(66556008)(66946007)(316002)(38100700002)(2906002)(8936002)(8676002)(5660300002)(41300700001)(2616005)(66899021)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm55OXN5U3N5bnEzNTNpSjBPZmk1T0Z0WmlJNlBTMTFJYXh5SC9rSWNiVXNO?=
 =?utf-8?B?Y0pBSWFYMjYzdEoveDZDU0VVNm90YTV3cXkwWkhmK1V4OVpxbkJjUWZ5NXh3?=
 =?utf-8?B?WDEzSGNVVXVTbUZIUVhObmgzOFlESDQzdTdJbDhUa1k3TXlwSWE3K09xK1Ew?=
 =?utf-8?B?TkQ2dnBId0U5MEsrb1lBRjRiaWgvY1dHQzVOVElsaitvMzBFOUtjWk9Nb29C?=
 =?utf-8?B?QTZxbkZ4SHFLbTlSSElIeXJkcGZHVnZXUldkYlQ4RWVjZ3h5M2lJNyt0MVU4?=
 =?utf-8?B?UWpTZm5HU3hsTXAzTXhhM0tFSTl1TVlHUWpUU1V2ejRaeXhhR0p5bndYMmVa?=
 =?utf-8?B?Nkg5UkZ6QUFiaDJ2eTFvUk1kNjQ3SWVuM2ZqRG5rTFFDTDdQR21SSlphTnZ0?=
 =?utf-8?B?Z2ZSNG5iY0ppWWhMZG90dis3WXZqQVZmRDdvMDBBVjR4L3ZEMHdJaXdxNzBS?=
 =?utf-8?B?SGZWTGhMVHFlVGxJTWtERzBpcThCNVNIV3dORlJabHkyS0Y3RVM1MDF0c3lK?=
 =?utf-8?B?SUw1SC9wNEUxeGlDOWtCOUV1a2hFNndZbWw3VE1MK1YwTDIyU1lyVVVuUkFv?=
 =?utf-8?B?TCt0UzFYeGpydlRJVXVaNGxIUVJVTzVpY1p3LzdGQjdGanpaNzJsc3JBOW5n?=
 =?utf-8?B?WkZlMmZaNlozOStaOFVTYWJyOVVQUVdtRHV4L0FaQmdZSk0vWGh6OSsxTVUw?=
 =?utf-8?B?RVRrZ05QOUkxNTJQN1V3NDJmcUxLdGhONWUvd0M3aUlMMSsxMnFkUzhqVDBk?=
 =?utf-8?B?WTU1Ykd6K3Q3ZGNVRVhSRjMva2J3TmxLcnNFdjF1dTZtT01uNFZHdjRyZm5t?=
 =?utf-8?B?L2ZEOEpDU2JZREk4L3lCSmFRazZtdjg1Q0tKUm5YTlZYZHRUdXBSZGwxSEF4?=
 =?utf-8?B?ekkwbTBrcW9wS2VscklqcGRWQ3ZoOGNlZFNqcitla2R0ckZyenp5R0k0NXBi?=
 =?utf-8?B?WnJ4cUFGTGVZWkladWIxTmVOTkx5R3l0THlyS0FHNGxKZnVybTd0cnl4c0R0?=
 =?utf-8?B?YTZzQVBSdXUzKzhadmdtbGxXMGpvU1dLakc0MkhkaTEyd0JuczFjdWVyZVVm?=
 =?utf-8?B?dlc1bkdZTFdWVlprcXdTUnBjZ2VoN2JUVDZPUnJUMDAxWkRJQVFacHlUS1Mx?=
 =?utf-8?B?ZnNJVVpUTmF1dXJ0elpWUnpEL29vMHdBeGxOU2tQaVM4a2pxQ1R2V3RhUGxh?=
 =?utf-8?B?a3FKR2xVbWl5OXFWdllLa1pyOVZRQUt1ZGdHc240ck9Rdjl3RkRVejJDdU03?=
 =?utf-8?B?N0RhRzdkMzh0VFVIVHhsaGtaOEw0c3g3WEZ0eGF1YmZET0h4ZlhHRmx1SlZr?=
 =?utf-8?B?MlJrSkVLMVpyQkJQN0JVaWJxK0N2ME16WDAwclp5aWwvNkVLellFQlJwWXBs?=
 =?utf-8?B?SjREbXIyRGt5ZXhIRDhqQVBKOWxFMUZMVk9SampOTi9WS0hQU3dGcCsrNy9J?=
 =?utf-8?B?aTBMRy9HS0h4N2Ywa3RuSUFQeVZvNUZYKzFxcnV1dE9YK1RrZUFjam95b21F?=
 =?utf-8?B?SGdJMDlrRU5GbVdRbm9HNWwxcXdDSlNybTFMVlFERHRuZ2pubHRPcnVqbVRa?=
 =?utf-8?B?K2xIL1JaNEx1VWMxUzNHMjhPNjNpN1pOMDVsVDNNQzhRajhtQkNQNm00Z0E3?=
 =?utf-8?B?Z3lkV1ZzWGx3UUxLL2IxcVpHQVh3OXBpSVJkeVFQUUROaTExQ09WN0FYUUF4?=
 =?utf-8?B?bVRsWURBRk9QbzR0UGRNdVU0RWdwVElaZUhzd0IyQ0FEV3NCRFZSWXRDTHg0?=
 =?utf-8?B?YTRXd1JocVFvZWdYY2EwdkJzUjc2UUw1NEF2dXNaVTJtV3QrVGdMQWEvVVpj?=
 =?utf-8?B?b2dtcjVJazYzeHlKVThKNGhkbXF3anVPTEJyZkJGTThOU3ljc2NQcjdUSnpr?=
 =?utf-8?B?dUI0T1ZlMTlsTEE0bXhkaEd0WW5ZQ1A0Zy9qZ3NKMjkwNFlzVTA1cXhNSk13?=
 =?utf-8?B?aW5mVElWeDNBQzIzT1FOdFlsZFAzVlJ1d1grOHkvZS9iaUtxN1JJd2Zrbmdq?=
 =?utf-8?B?R0FGd1k2eENDeEQwSjQ0d09kUHE1V3J4eGJKK2hyRXVhLzFJZG1BbjBWNUNu?=
 =?utf-8?B?ZHIwcDN2YlJhdmh6UVFwOE1OQ09iSmEvZlY5TDhqZ1dCMWhVdk03OEdYL09n?=
 =?utf-8?Q?AjsTFdKC1oevypRis5P49hcfB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f11f40d-5627-46ed-ddea-08db6ce9510a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:09:14.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fhOQV3hSQ6HTA+ZfM9NP1SNYMc3RfflvwdIAaoin5S5tcYjRAcqxgzBjX3lrcrdTw0t94aEjMd9x64oCo2XLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

On 6/13/2023 10:19 PM, Shuai Xue wrote:
> 
> 
> On 2023/6/13 22:11, Yazen Ghannam wrote:
>> Currently, all valid MCA_ADDR values are assumed to be usable on AMD
>> systems. However, this is not correct in most cases. Notifiers expecting
>> usable addresses may then operate on inappropriate values.
>>
>> Define a helper function to do AMD-specific checks for a usable memory
>> address. List out all known cases.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   arch/x86/kernel/cpu/mce/amd.c      | 38 ++++++++++++++++++++++++++++++
>>   arch/x86/kernel/cpu/mce/core.c     |  3 +++
>>   arch/x86/kernel/cpu/mce/internal.h |  2 ++
>>   3 files changed, 43 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 1ccfb0c9257f..ca79fa10b844 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
>>   	return legacy_mce_is_memory_error(m);
>>   }
>>   
>> +/*
>> + * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
>> + * a system physical address. Therefore individual cases need to be detected.
>> + * Future cases and checks will be added as needed.
>> + *
>> + * 1) General case
>> + *	a) Assume address is not usable.
>> + * 2) "Poison" errors
>> + *	a) Indicated by MCA_STATUS[43]: POISON. Defined for all banks except legacy
>> + *	   Northbridge (bank 4).
>> + *	b) Refers to poison consumption in the Core. Does not include "no action",
>> + *	   "action optional", or "deferred" error severities.
>> + *	c) Will include a usuable address so that immediate action can be taken.
>> + * 3) Northbridge DRAM ECC errors
>> + *	a) Reported in legacy bank 4 with XEC 8.
>> + *	b) MCA_STATUS[43] is *not* defined as POISON in legacy bank 4. Therefore,
>> + *	   this bit should not be checked.
> [nit]
> 
>> + *
>> + * NOTE: SMCA UMC memory errors fall into case #1.
> 
> hi, Yazen
> 
> The address for SMCA UMC memory error is not system physical address, it make sense
> to be not usable. But how we deal with the SMCA address? The MCE chain like
> uc_decode_notifier will do a sanity check with mce_usable_address and it will not
> handle SMCA address.
>

Hi Shuai,

That's correct.

There isn't a good solution today. This will be handled in future changes.

Thanks,
Yazen
