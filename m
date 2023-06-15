Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA50731F64
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjFORkB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbjFORjt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 13:39:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A81BDB;
        Thu, 15 Jun 2023 10:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le02WKGIDAuiSNCRSAgLiPskd6c8geo4nYW+82wEZhZqmPPoR/ehwOxSXckDv1GNJjmVCdGWuc9tU/mKA0Hd81+p5Tsgl76j07OQ+Wh+tH2QPXO9/2WFqKWT5VPNIGvAl5zpnfnZ+xqAsqxKuvuAgjzlJvWCoOC4fHGnFAv14rjjBDTBEFFXyFAmnsH2vFR4iCkCWnbSWrC32JoEgRqplcJuIFTpRDYwv+I3qOGEtzXgUn08AAgtIyK8Fs39Rspv0KJa3BE6SaINuvzU2aIbUCW8xZEh0Y5FWqIKfyfwsg9viGDPT701KgqRZ9GCUswujS/iC2CfL5Eq9FV8qz1+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQQF8hbvLJUubDofMMkvw6ag+8JQDso1PDN0jmu1Q44=;
 b=B+XU9q3P8aknX2M25K/hGJHXVgglOQ7zdN/wlgVac9l44ixODhlsayPaW/3Qav+G0HdjZJsp4pbcUyGyUF6b1zs/wvJelLSCmbTL+B6TGG2/WfBxCW1JLe2+eXq3aVEsViiX1RBXeD5AFKNXg7q10QwOear51nbPSJxh2yoZ0VF6pIItnuBVsKVN/nNMiRAji8ppfsjG0BA277DHBdW9MYa97Hw9Y/lyUXuPKDh4t9S2Sj3Dsvlb8a2Uud1m5nj6y3lRvimToGrNBcFWf8TOapdOJ4m/Zn0X4Zb3jf4KySjqu4XiahhoeoFQB8MPhXmgWS34t/qxsdNgPwmLPyvNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQQF8hbvLJUubDofMMkvw6ag+8JQDso1PDN0jmu1Q44=;
 b=U/aw6WCJKeSuFVNJ/ae2WfQjgeFtLrgl6XW7+A8eQcL5HkgaiX65lHbJGdmtLqHEQErJGLdYXcN+aE3M+X6IID7Ryq0LdbMkwW4B03TLMCT3G3YBTsRgpMP8BS55cg4OPPMrHP4v+rwgEThpEqkZODHxrWatH1t9+C3wdakYFes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 17:39:45 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Thu, 15 Jun 2023
 17:39:45 +0000
Message-ID: <da1f680b-f601-0e64-bdb4-1aa5b6fc6175@amd.com>
Date:   Thu, 15 Jun 2023 13:39:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
 <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
 <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
 <d1333fa6-34e1-8b2a-b772-369776428eae@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <d1333fa6-34e1-8b2a-b772-369776428eae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:408:141::7) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d916cc9-890b-479e-01ea-08db6dc78253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUjmcl/oMKxNQfHuxjEwvEsLV1SpZiTxGhUlVnHV/QLrOBK/bf7NorIVPod+t78QIfLBbqNlHYEt6JX8H+djlTZ69w204bk69ONynVu/l4UHfepkdYjoLaN4M4rzzN6V8gnoJi0IFvr27CbMeIP4nEz7fZ0a9WJJrJkTnVnvXNgAvL5wyWUyhiNPBPp2ob06N37jPPC2i/Ofi99fNnxqJiu7m3XDkUbQCSSXCEqKp1MZSCPKRlGYx5aSTvzeeMzDf0kYLd0GF4EAHLAofCr7jnZPoiRHJe+hZ40DYBnzkzBzJ63E2aBLyOjCqjAA0LQhluDtBiZgsMix2VEEztfN5XXNxLhkg53/oHGVLMmG+gZbil4K69YYExfL/cRr7qzGvTmjYazPuVb8GSicpJoLJpaznZUSPusEHlRHubjZe7+6/nPXZSucN1Kh2oR/mA3h0YjX/rkJwK9lJLvsE//rff9Go7hpAHdo+uTfRGyvNSys9OlX0nHfSlx1x7Tb+z2k6oexkOFhQLrfWM+iBST1ywfTe89tc+XQjCMD1/GO0YQDeORVuhjNTzP2MIfJGtaLS88WZ9hfM7OzitjyQKOCV64h0FRojTu8wACe9dBpBsWN4lJj8CCUoHJ55Pzfr2xHEH/dsYAr5Y4TPaQPP8ZsKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(6512007)(186003)(26005)(6506007)(53546011)(66556008)(4326008)(66946007)(2906002)(66476007)(6916009)(31686004)(31696002)(2616005)(86362001)(36756003)(6486002)(41300700001)(5660300002)(8936002)(8676002)(44832011)(316002)(38100700002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXEzTXV6NDVUOTVLM0ZQY3g0Nks3VlJPVnBLY2x0M2svT1czcjBCS0hJbHJa?=
 =?utf-8?B?U29VY2pmWFc0YnhqYmNEakZRMTZESXl4UmM3cGE5MTdqdnF5dWppK055d2hz?=
 =?utf-8?B?eXI4RWxmaUpaNHVRQ3pXNVFYVFhrK1pPNk5Fb0d5TFJNUUZQRE4vYWNjR2t2?=
 =?utf-8?B?MDc5ZktORU5kYzZtTmNhVjNqTnJHRGVGOXg3eDAzd2VhQjhJS1h1Z3V0UFZq?=
 =?utf-8?B?REhENTVPRi85MG1ZL0Npb2NuTVVuWDEzZ1Z0TnAzbEZEejFDL3d2bWJqSnc4?=
 =?utf-8?B?cFVKS1FGa1UwY285WWhiaC9rU2pzU00rL2RxekhpOHllMk1OZFRkeWc3ckVR?=
 =?utf-8?B?czZwRFhHYU5qUm9qakdHZUhLNWNYTmVPOCs2RTI5ZVlvbmxldFNKcWpSY3Fy?=
 =?utf-8?B?Si9mVTFTd1l6bnllVVZ3QkZ3K3VqZGU2QjRNY1NIMmVMdFdtOHBuSStSTWlL?=
 =?utf-8?B?bFJLVTNrTjhzUVFsdm4vdWpYUDVIWUdUZVdkV2NTR3BlOElOVHRsbko1WGZy?=
 =?utf-8?B?Z0Q0S1pjSWVGQWtCV1JBaXZqQVc3MW9LeE1EZWJEQ0xDMkZpSFZMdHZxSmVy?=
 =?utf-8?B?OVc4SUM1VCtnMnNtS2NlaFdoQ21JWjViRlNBNllvQlFPaTRNNUU1cEl4ZEps?=
 =?utf-8?B?WmptMFkyL3hKaEJYeVBUY0ZIQjdtR2VicDh1eG16Slc2LzJrYnpEZ0lWczdT?=
 =?utf-8?B?Q081UWJQVEVRL05tSlAvbGV3WDFjMWRWenl3NkVrM1lXRVNNdnlIQ2dUSzRp?=
 =?utf-8?B?a1lweXhhZEF3ZDgzeUFLTTBKcVJwcGVBa2xEVzM5aTVWMXp2SUdhSndiL3Nj?=
 =?utf-8?B?cGVKWmxFdGw0aXhYMDAzaVVCb1JEMzVCSmlTemwrQ2t3NkxDQys1U3cvNkxI?=
 =?utf-8?B?WUxqUUpiZmYwQTVvT1A4MG1BNDZ2Q2tra1VkMWlLRDRzeHZjWEVQTUM5clhz?=
 =?utf-8?B?eC83eXc0NjVsaHIycHg1dDVFajRMblc0cCtLRUJOYlZYQ2w1amZ0cmVMVVJk?=
 =?utf-8?B?UUZtZnRHV1QwTHFydStlTVdKdVJQOStldVBxakJjTDJ6ZytOZi9FeG90SHht?=
 =?utf-8?B?WEM0S250OHZEQldJV3Rxazd0QkVOWlRsOVhqRlJ1YTJBMGpYbGJ5NGRYbkor?=
 =?utf-8?B?QzdKRFNyWGFsSGEraGozZnlReG9wTEZzSlFlT3BLYUR6N0VMMWZUU01rdTJM?=
 =?utf-8?B?eDlMY05FYmRnYzJnK3MzUzFWMEJsSDhKU3E1aWhjaXFlaVRNWE5iNGxjS0xl?=
 =?utf-8?B?UHdSOW9zL3ZGdUdwd3h1UmJ0Zm55OExWNXgwVmo2VVg5c0FxY3c0WCszSHVH?=
 =?utf-8?B?d2Q5SjlEREswcnRFR2R5TittMWM3MTBqSXVjU3djWEhsZFF6RGFLQ2VtbVBs?=
 =?utf-8?B?Y2tCajZkbExxbXd6ZHVwMFVXREJNNnBCaWhydmJHc0tlTFlUdXVoUDRoTk56?=
 =?utf-8?B?Y0VaN3JvTXI0UUFyR2dsOXB6eW4xNFBsQ0g4NXZuNjhiMWJRczFhQmpPaE5n?=
 =?utf-8?B?SjQ0dVQ2Z1pXME5wTU51ZkJlckxab3R1dGhtNXhlSXZDdmkyd1VkTHZiZHZB?=
 =?utf-8?B?dkVkRFM5SU9ISzBCNWltWlg2OTJiRHUyV1lpYUU4b0gvbnBMQmRtZU9ad3ZD?=
 =?utf-8?B?aWtFL2ZneWFJMXQ2YnoxdkZ0aWNqa1F4eVdjN2ZjMExCVVo3YkFBdkpSekFn?=
 =?utf-8?B?TzRUTVBRRExlQWJLeS9XMVdOOHJacnAwUUF4b0hiWkMvQ0tpaHk1enZub01i?=
 =?utf-8?B?cDRCMW80S05iRjZoNDFmamF5cWhNdlZkRjNXN2Y3a0dYcWZjdGVHd0tRL3Ri?=
 =?utf-8?B?L1Avell1SW1VbnpRQXRvbkJkR0JWUFIxY0YyL0g4ZXJ2VG81eDRyUlVIYlNP?=
 =?utf-8?B?bWJOUW1EWnk2Nyt4TzFuNXBxUGx5M1gwY3dYTW9qaDN0eGlaUnhqYSt3azNp?=
 =?utf-8?B?dW1xbDR5aFZFZi9QMk11MDQvTGdaYW50YitQV29LamEwdjUwOC9qdEhyUk1j?=
 =?utf-8?B?MzFXenoyZUcvWVZONTJZZ0svTW9DanJDRkp1MHFVTzZqYjJEbjVYUHBhY016?=
 =?utf-8?B?NklidmhERzZWMklEbTRobnBJRFMrOU5xbHV6ZFdtbUU2V3NiVlpmQmYvY2ZN?=
 =?utf-8?Q?Lrz25bvCt+J93cEGC+nFXJ6py?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d916cc9-890b-479e-01ea-08db6dc78253
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:39:45.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAdScUs4kpZgX+4KxYsvglkXBabT+19kvkudb3K3R3DixJLhjsViMSj0xUw9Q4EELqSPI95btS0wOdShZMCUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/2023 1:02 PM, Yazen Ghannam wrote:
> On 6/15/2023 12:20 PM, Borislav Petkov wrote:
>> On Thu, Jun 15, 2023 at 11:34:21AM -0400, Yazen Ghannam wrote:
>>> We can solve the NMI issue if it ever comes up in the future. Unless 
>>> there's
>>> an obvious change to avoid this now. Any suggestions?
>>
>> Yes, solve it right from the get-go. "It cannot happen now" is not good
>> enough. It should not be even technically possible.
>>
> 
> Okay, understood.
> 
>> Just report what's logged into BERT - nothing more. Whoever needs the
>> remaining info, can dump it from the machine.
>>
> 
> Will do.
> 

How about these changes? I can split this into separate preemption and 
PPIN patches.

The PPIN isn't coming directly from BERT. But it seems we can use the 
per_cpu value which is set up during CPU init.

Thanks,
Yazen

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8ed341714686..db16dc3c7b03 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -97,15 +97,19 @@ int apei_smca_report_x86_error(struct 
cper_ia_proc_ctx *ctx_info, u64 lapic_id)
         if (ctx_info->reg_arr_size < 48)
                 return -EINVAL;

+       get_cpu();
         mce_setup(&m);
+       put_cpu();

         m.extcpu = -1;
         m.socketid = -1;
+       m.ppin = 0;

         for_each_possible_cpu(cpu) {
                 if (cpu_data(cpu).initial_apicid == lapic_id) {
                         m.extcpu = cpu;
                         m.socketid = cpu_data(m.extcpu).phys_proc_id;
+                       m.ppin = cpu_data(m.extcpu).ppin;
                         break;
                 }
         }

