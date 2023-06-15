Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E553731C40
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjFOPQD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbjFOPP5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 11:15:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE011FD5;
        Thu, 15 Jun 2023 08:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPJnrdeA3fZ0luv29SpiU7Ry548YYsTx/L1FXEVenJpQRyhOoh3KyOQvGH2p7HAsvdetOyAj5Uq2jUlAxGNEautHzVOfyQ8Kn/GOIwczTc14sU+IMmyuS+8kKg48DnoBTjfBK6Le4esX6u8/6DqYGhbGCibDoAo6kxf5qYPEvXjz3iMZKlYAfjE8XcVP3R5YO1HUjTR2YyVk468c4H+haLkMK84tqh1iIu3jNh6kZeCgjS4An75+A+a3VFz3CccvV542CTkWrRPo2AhKr3vDijHGJMWTbtvs53DsL0dXVaHBYXSg8ykQl/QMwlOr3NQcWDGUWm6kizOAkA6hwQcFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgljB7D3+GND17t04wScSMnCamjsthczSdt9qUyqwNg=;
 b=C/CXfXpEBeBxG6UqFBm3Ud89yPP5WF+AjtG29qiBF3eRHUZrk19K7ZhhxUjbxVR6yYwN9+qm3N/wafpf0XDdopLx3d0hdIa8pjEKmExLZAjMvNqqEwJ5bVikrCITLRX2RpNRmK4xEB1VH96QU12oCS6pLKIBPwEORyPzQ8I880x5hVFcRlRKfKzHfEEoh3JTVi5PmMuIgURAnCpkK5IqFs1rsleCmC0lobAvyxKgxjwI8CziUmLa/FoXx/UTFD60571qspn0My8zIr7ON+KagY7Q+mTUbLBiP9amxz0Bqqf6awbuKlvZR+J7fiLkJBEGyv1yFQdjav5ksYtwUmNZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgljB7D3+GND17t04wScSMnCamjsthczSdt9qUyqwNg=;
 b=pMESWrhvHy6QtauVGCuspXwGJcFG91K4ftp+5N6zpWkQAbVZFlzwTXOSWZrSTeQWfOVXrYkIJI8KWbnI7ISbnVWQxBCKELetOJ/1yNO6loLEjwPUzo2xmaJm14hTNw5L7DmzYhigR01LUodFyrxO/Cq21tqwuY1Qp3J/lUfT8O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 15 Jun
 2023 15:15:51 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Thu, 15 Jun 2023
 15:15:51 +0000
Message-ID: <1171078d-fec3-297e-05f3-dc2e58bf2886@amd.com>
Date:   Thu, 15 Jun 2023 11:15:47 -0400
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
 <1e9b1a0c-564d-6a3c-c253-1b1da1773ecc@amd.com>
 <31816165-e3fc-5bb2-71ad-6fe77ecd64a7@linux.alibaba.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <31816165-e3fc-5bb2-71ad-6fe77ecd64a7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:408:ec::30) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daa1857-18e3-41d7-352e-08db6db367c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edeIB1ZjVcz/AaAeXZUSO2qeLvieaEa5lIk8LtCbrGkXxgSxhDtYjdIkLYE1feKoJXdzPlnUG7hg4XToTCElABGh70p55/BBhOCdVVNp/M9C/ZODU7uLkhzZNvBpSEKM6uuTVatxaoun1t2HYLqzs5FA3i1SVBIhZOdhS93hS3PuOoWIdGRaPKSZ2CuN/Kg9BoMVHPqHejRCRJN+NRG3p/KnktXifYV09gvtUriI0rFUW8IyEQ2H3benwstBguXeYUKklQk6bFruj7jzaSvUvxULXw1BL1Gidh66sogfVcZir9QTkrkw6idQS6oGx5fcGFOpwQGGaHFAx8nU5FxxxLX2sKmkVcMybDOxDfnNPqCQsVnykjjhJ7YMhDzcqiNID4ZYc55Dwn3CKQn2Vfjz4cHTRmoZsNeVMxnmWP3gYNHmTwqr013p2RcfDj4ZfQojXpN+4YrS5edMRUgz5Oa2K9V6KhvqvxoKqseoc9MXnjbgcfsGI5daVmaCN3H3F+NxqBTGt+BnXiuC8r/W9cSx5hhBsaXvOObMBfGbUMCzkOmOZxny55JDX7HQzHGDyxYdTQH76MD6qV15bUujmuB4erNKhEgfrfMY8+03q0N+1RJd+DWGDruYz0x7hIpvrzuqcnqrLcIwpq64+hR/5taO0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(41300700001)(31686004)(6666004)(36756003)(8936002)(8676002)(5660300002)(66899021)(316002)(44832011)(66476007)(66556008)(4326008)(66946007)(83380400001)(478600001)(2906002)(38100700002)(6486002)(186003)(6512007)(31696002)(26005)(6506007)(2616005)(53546011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VRUnIxRTdXcmtoMDRtb01aZFMzV0tDT2Z4czZKYlNYUGhDQXUzc0RROGZu?=
 =?utf-8?B?QXhqMTF0WXQ3VU4rOUlQNXNWVTVyRUxyRHlsVWEvZDVnOXdVWW1EbVgwZW1V?=
 =?utf-8?B?K255UUs2NjFYQ2s1UTBqTVdoT3BmUi9jWS9hTVFFb0laSUxGb1BIL0NWUGdj?=
 =?utf-8?B?R3czNDRpOFMyeWovUlhDdkJqNDZpbTZvZ2ludmMyaHkxelFtRXllVS9ocXZ5?=
 =?utf-8?B?L3RickNSQjVJOXZJYTRUMkZ5Y0RGLzQ5Zkd1eENKYmZGRncwVndOMjgxMnBp?=
 =?utf-8?B?OEJEZjR4TElzd1lXWkNENGkzNmhtYW53dGlieTk3S2tuaDQzaEtnTk5YYk5s?=
 =?utf-8?B?MzJMWGZxdlNxRUxQM0JVZHQ4MHNmelQ0Tk5HT2IxSGhRQURTRzlSOFlGYjZs?=
 =?utf-8?B?MDEwRm5PcVo0blpKYzYrTUdRU1pTMmJJWW16MFN3ejdUcEo0N1d0U2tiZlRI?=
 =?utf-8?B?T3YvTzVOdmhQNnN0cDUxcCtlMUZCeGkvQ2pZSXoyM1E1c0hveVFydFFvUlI4?=
 =?utf-8?B?RnJBckJjaW1YMEN0bitZN3VkVWltcmIvMHZUL293U1pLUjk1cCsybjBlWHBp?=
 =?utf-8?B?UXg5aEdjT21yWEN2Q2lzOVhZVGM1YTgxU3krbGtFQkRWTUZZZnpkbHVwemYy?=
 =?utf-8?B?ZlNLNnNwTldZMlhsV2VYRXhabjRHVnpHRUt2TW9aQ3kxaDR4Qy9BT1RvUlpa?=
 =?utf-8?B?bHF1Z2cxYk9RVndqNU1UVGhOY2I3ZVRWNENJZ2t3R0hibzJ2L3puRG5Fa0x4?=
 =?utf-8?B?dGIvZHErdWdoQ1FOOUpiaHZSOWpXUGxOVldlQnE5bnZ4SUlaRmZ2cmtPNHp2?=
 =?utf-8?B?N3dPOVgvQnE4bWxvUzVwc2NSK3ZBcDhWQkVTL3V0U3R2VWdNa2JjYm1sL2I0?=
 =?utf-8?B?WmUvMEh3SWdBb1J5SG4ydWdIVTlzOEV6KzFHMGdPWXpwRkJ4eGFlR2JyMy9j?=
 =?utf-8?B?dks0bnVyZXUyUGtNVlkwWWpzU3pJeHNoNXR1NDBKVFRmdEdobWNPTGNFODFT?=
 =?utf-8?B?QW02MXlsUUVaaUtvcCtjTWRwOWJta0FOa3dZdVFEcUV1RWpzMTkwb2Mxc0tq?=
 =?utf-8?B?amtrblNaTnBhQ3lkSlE0VXRnVXBBSVlqN1dXTWhjNFUvWW81ZkdMKzhqcEJz?=
 =?utf-8?B?UmlTbnhpWXlnSTkwZ2hoaVJHckJBdnFPNTlMdnRubmM5VWFSamUzR3h1amtp?=
 =?utf-8?B?Q1QzRDR6RldmWjJOMkE0d0lML0RxMUNGR1J3SzVlUlNrZE4rWG5CL3h6S0pM?=
 =?utf-8?B?UXB0MCtzVWcvbGNoYWd4RmN2Q0dRQ2RqVmhJcnFubkpvRWhub1ltMEEzcHBG?=
 =?utf-8?B?Z0hmZVFwaXlBdXZLTC9NaUl2c0NrV3Fna01FSHJZNGdMVENudWNXNFo2VUdP?=
 =?utf-8?B?MlZZMmR6QWgxMW4rWjBkZFFmcGR3WS90UE1qN2p5andmWExoRVN2ZmxUSnpX?=
 =?utf-8?B?aWs5OGtMR1RQeWtZZVFTUjUya3pPYmpJUzh0UFdiMHdVREtLV01DMEptL09I?=
 =?utf-8?B?ODZ4VTJMLzczaWIvcFQwcEsrRGg4MGM3elVhTFUxM3V1aUZmOFRabGl2UmV2?=
 =?utf-8?B?OEVIWWxPb3ZWR3lQZUUrbU8ySkJ0RmN6cGtWTG1lM0NHU3BvV25kc1VsWUVG?=
 =?utf-8?B?ZFNqN0ZtMElKVEhSQUdOaXNrb3YyOG1RNmJQajd2cTdkRVl4MFRUOEQ0dnVZ?=
 =?utf-8?B?b05Xd1ZyNUIvZlJGa0MxdlJVN1NnS1Zqd1E4TkxVSWFOdTAyaXY5MHUyL2tr?=
 =?utf-8?B?YjUramZoaVNWME8zTDQ1ZEVHT2o5OXdkbmNsZEhFTXJlWGZjcHFWR2NIN1M2?=
 =?utf-8?B?UUNVdEpwdUI2ZzZQcHZaN01uWndnZkxBTmxDMVFSOW5nbGxKR2ZYUEtnaGNM?=
 =?utf-8?B?TGFabUdmcHA4WU5ZNEpVTlQ3Q0tINjVjaW5XVXlLOGJ6eDd2dHdpeVBTM0pK?=
 =?utf-8?B?ZlVoV0RkQ2FZbFkwQllGU2dqYVNsdGVhakg3MmxXWm1UMHZTQWJwT3NHZFhw?=
 =?utf-8?B?Q1JKbEQ4QkhSYTFVQUYweGFVMjVFNEJxcGpYTDJRSkdVNlA2d2pPZW9LMkhW?=
 =?utf-8?B?UGxtMzB2L3A1R2IwUlg5U3NBSFJUSHFrRFpWRmNOaUlvdWhUeW1vZEJlamQ0?=
 =?utf-8?Q?GecXkB++4rq7GDp9wl/xyypFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daa1857-18e3-41d7-352e-08db6db367c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 15:15:51.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbmVIJ1j2FrsrXCQ9JER4qAoojKWHsrmtbYkLrcrjLAmG5qTY0quOMN40pTrRMxpCExYWUG44ff4Dcdyj/daBA==
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

On 6/14/2023 10:12 PM, Shuai Xue wrote:
> 
> 
> On 2023/6/14 23:09, Yazen Ghannam wrote:
>> On 6/13/2023 10:19 PM, Shuai Xue wrote:
>>>
>>>
>>> On 2023/6/13 22:11, Yazen Ghannam wrote:
>>>> Currently, all valid MCA_ADDR values are assumed to be usable on AMD
>>>> systems. However, this is not correct in most cases. Notifiers expecting
>>>> usable addresses may then operate on inappropriate values.
>>>>
>>>> Define a helper function to do AMD-specific checks for a usable memory
>>>> address. List out all known cases.
>>>>
>>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>> ---
>>>>    arch/x86/kernel/cpu/mce/amd.c      | 38 ++++++++++++++++++++++++++++++
>>>>    arch/x86/kernel/cpu/mce/core.c     |  3 +++
>>>>    arch/x86/kernel/cpu/mce/internal.h |  2 ++
>>>>    3 files changed, 43 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>>>> index 1ccfb0c9257f..ca79fa10b844 100644
>>>> --- a/arch/x86/kernel/cpu/mce/amd.c
>>>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>>>> @@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
>>>>        return legacy_mce_is_memory_error(m);
>>>>    }
>>>>    +/*
>>>> + * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
>>>> + * a system physical address. Therefore individual cases need to be detected.
>>>> + * Future cases and checks will be added as needed.
>>>> + *
>>>> + * 1) General case
>>>> + *    a) Assume address is not usable.
>>>> + * 2) "Poison" errors
>>>> + *    a) Indicated by MCA_STATUS[43]: POISON. Defined for all banks except legacy
>>>> + *       Northbridge (bank 4).
>>>> + *    b) Refers to poison consumption in the Core. Does not include "no action",
>>>> + *       "action optional", or "deferred" error severities.
>>>> + *    c) Will include a usuable address so that immediate action can be taken.
>>>> + * 3) Northbridge DRAM ECC errors
>>>> + *    a) Reported in legacy bank 4 with XEC 8.
>>>> + *    b) MCA_STATUS[43] is *not* defined as POISON in legacy bank 4. Therefore,
>>>> + *       this bit should not be checked.
>>> [nit]
>>>
>>>> + *
>>>> + * NOTE: SMCA UMC memory errors fall into case #1.
>>>
>>> hi, Yazen
>>>
>>> The address for SMCA UMC memory error is not system physical address, it make sense
>>> to be not usable. But how we deal with the SMCA address? The MCE chain like
>>> uc_decode_notifier will do a sanity check with mce_usable_address and it will not
>>> handle SMCA address.
>>>
>>
>> Hi Shuai,
>>
>> That's correct.
>>
>> There isn't a good solution today. This will be handled in future changes.
> 
> Hi, Yazen,
> 
> Do you have plan to address it? If not, I can help. We meet this problem in our products.
> 

Yes, definitely. The first step is to update the address translation 
code; this is progress. Afterwards, we can find a way to leverage this 
in the MCE notifier flows.

Just curious, how big is the benefit of this preemptive page offline in 
your use cases? That is, compared to page offline as part of poison data 
consumption.

Thanks,
Yazen

