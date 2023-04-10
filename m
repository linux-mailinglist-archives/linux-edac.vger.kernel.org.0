Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C86DCC61
	for <lists+linux-edac@lfdr.de>; Mon, 10 Apr 2023 22:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDJUyY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Apr 2023 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDJUyT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Apr 2023 16:54:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA132680;
        Mon, 10 Apr 2023 13:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDZxffEutFM15iTnNWUdoT5loJ5z3noXbnsdKzHaKLdaceHjINXA9xZj/yKqS7RRrQUWpn9BDv/tKoHcVNrkbxmSlmAEdEJymSZv+1Ii1i5ctzXiBNers+007iSNGsHaliSIsy7By2eprEsyKLDJ8QeaFdUJcQ+AD+QfrjzcbtGvmYTGXzCMe814uTcO0gRnnNQHZPlLDpRb41oOXDP5ysfEtGH53kkbTb7x/OlWzuPjbatAAwxzf3XuH8mZRYAEOHWAHk4oJ4EgIGjinyaD5VbEt3sRzupHyt30GpeBaUPjXKKNUN2AKECKu1VEk2TR9AgR9vfg8OPBfGsli/Q/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msVgBxcgx8Dq5BITVJHGU8e+f0F+nSBEgJJYgcqaUuQ=;
 b=DdjubLwcWDQfAale5CeEPmiflsvrfoRszcVzSsLNdBzmN2qJEqDFnj+dKgATPdqxzu5T5SH/sprrwdpouZkokAOOuwHNY3RxEwPaJR37NqGTtWsGkEeKLudx/yYD0ii67v+DVgA6o6z1TWkgC3Yvyadm1PxHOER0kudcMZxX5rf4FrxPX+SOGNqxturiI5hTmh89kzYvMs8jD9Ljm6324lh7rbH+BKf23jFh+AWQLi6CKs21Uc3cuE+7DCglQCqVvJYOpoVOADDhBPlMly69Wdp70wSiaZYV9kHgcGhxwo6VB3Sj1kCW4y7cGbWKlQ51jU3uWLN/86JnLbK6k0O7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msVgBxcgx8Dq5BITVJHGU8e+f0F+nSBEgJJYgcqaUuQ=;
 b=tM0FENkg+gOc7GZlxj2GfDDQIS7D5FvQ1cHgNX00jD2x3PgigjKFExLFp07T3EQmXA0M+GYKJa2lSoBfGcKCd05/XrRGXaCV/i18YDcPJRj1Vjtdcn+7QwA8w6BaxqPS+sq6142pMCxepE7Bf00YXrX6eVZZvfZRamg1aghYrF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 20:53:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 20:53:52 +0000
Message-ID: <9549e422-e5b2-ccf6-3c8d-ac61436e7fa6@amd.com>
Date:   Mon, 10 Apr 2023 16:53:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, avadhut.naik@amd.com
Subject: Re: [PATCH] EDAC/mce_amd: Decode Cache Level "L0" Error Code
To:     Borislav Petkov <bp@alien8.de>
References: <20230410203357.17704-1-yazen.ghannam@amd.com>
 <20230410204710.GBZDR1ziKdqr4ihJZh@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230410204710.GBZDR1ziKdqr4ihJZh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:408:f4::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: f7870f3c-2915-48f4-9145-08db3a05b0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAG037C1gyOagmK/Yqoj33k1BpKy6k/igTycaJ7dQe2CHHyRoBksQy75ohgBxKb3wienECLsyOGY7sjn2c0ldYqRClchTm1sxCNYZzMkUB904v0U+o9P0VgNmoPKwKEnnlXNIYOmem8fCHHC364DSBuPqb+WzC/aZWtydoumop8ET6gMW3P+5shyZl8GwfmpJ3u38AIFQs7aLR5/Ntygic/b1Q0GTXjm1Z/Dl/wkhLm2szgKo13XtAxDaImSPoUtpKg3n8fjYQsARRFmhajOBN6s8hWV8AHqkpSM406QUj+lqJSOCaOHzRycr9bbYEgcqFEs8XKscNY/IWaCL40H+vB9N0E7H8mhUiEMwMiQkLzGs5X7mnxhBQ3MoswdTGD356QEyMq4WFfdckVeH6pcA3dsesOJARH7FkpFkRmCgHL+YI0yIY9P4e+i+HEt6kN7PusXqGyFQ7OpGpd/WAlP7H0x6qj/qMepxm9x7CrsGo/h+twkSHb+b1cpTDwRLnLC5l0BJVu0c18eDGiyL9gj1VXFr2NyHZuQSqFgqav6BILglaKtIyGF8oOSKeTTY4hp2LIWiTNeGTZX5ZmkMMRE/bMNExhsR3AFy5rMr7/6FBNu2/8C6MZSLpuL/o7I+U5BzYIAdO19//3KkI6HHWN+iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(8936002)(44832011)(6486002)(5660300002)(31696002)(86362001)(8676002)(66556008)(66476007)(66946007)(6916009)(4326008)(478600001)(38100700002)(316002)(31686004)(53546011)(83380400001)(2906002)(6506007)(6512007)(2616005)(186003)(41300700001)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHp4SVd3T3k1d01vOFVTREhkSHNtRzhmc1lDK1ZGVGZBUFg1QXNIZXM0THoz?=
 =?utf-8?B?MU10YkUwWXhweEIxSVhQaFlNazFhNmo0cjQxUjJQQ3pRbGZrYUQ4LzFMOGRM?=
 =?utf-8?B?YzlqSzEvWGlSYVNPemNFaGNZZEJZZkNwSGpBQ2FLc3BGbytqT3lzYnRZRW5q?=
 =?utf-8?B?cTNCYlEyZERubTlsdU9rZElyWkMzZ0U2dDFuN0RRT0YyVVd2SWoxcSt3aWhE?=
 =?utf-8?B?dW5RbGNYQkRmYVhOdmlIVnA2bkMxdzQ0L0k0bWtsODd2SmNWcndPNnFMUHI4?=
 =?utf-8?B?RWV1eFF0aWlCTU93V1RNQlJPUHl2ZmdwVysxMUc0em1FV0VIbFBianJnTVBE?=
 =?utf-8?B?dEdLa0lFeWpNUTQ4UnNudVBDVEw3S2h5U0J4a3RnaWZ1T01iN0NtbHZWQ3lq?=
 =?utf-8?B?OEZQSXdsWS84YzkvRXFkYW1Wb1Vwa2VRZnlKNitvMDl0cmRYeEF2SXVleTR0?=
 =?utf-8?B?SERGa1ZJMzhxdlVGd2FPeHlzZnBzMnVvWjd1T2NZZE1xcEx5OWdHbnBpNXlP?=
 =?utf-8?B?Q1V4V1ZUVXUvWmZmTFRnNzM1enBoYlo2bzdZYXlmL0p1eTZVaXBUM2pCSTlS?=
 =?utf-8?B?SE1haUdoWVhpb0orZGppaFRjRld3ZDBzV0xrQ3pUVkpPNUtCenlSWWxXZ2ZG?=
 =?utf-8?B?L1p1ME05a2p6QzhxTU1MSDFTZml3VnBUSjVzQXlxOGZ5eTJtbG1SVStSZ2Rs?=
 =?utf-8?B?ZERZR0RuRHh2bDh3ZUswanRRYm5rOXIvMHM4TDBnQ28rZWlleGQxTS9GWHpn?=
 =?utf-8?B?bnNnbXpraTM5TnAzbW51MlR5RmRMY3VJcG9FWTBRbkgrdXVxdGIrdEZFTDZs?=
 =?utf-8?B?QUxWdGtFZk1GMWxrTW1RWjJnampRLy9GSDNnTkg1MWNLbnA5aUtqbk0rUC90?=
 =?utf-8?B?QzEwVktyeGY5ZzRNMjdHUGc2QkVxT25nVFg5YWJjZWRZUWZDVFdmT0UzOE5t?=
 =?utf-8?B?R05DUDV1aldGRjYySE5vR1pnNUphcTEzMnRoMzZobmpRKzJVMzN4QVBQbzhp?=
 =?utf-8?B?RGxHTGIrOVJCRysybXNaaUs5Zk5BVXIwcTJsWjFYRTJkUXZCWWFJUGNjOTNv?=
 =?utf-8?B?a3NLZ0NpOUNDdXdzcHNuYldGemJFNCtVVXFPRUJrUUV2VmVYNWlUd1dIa3k2?=
 =?utf-8?B?RUd6SXBwNE9mWTZRaWV5ZlRpS1grMEVHb0t5cVRKWDA3VVV6UWd4dUI4NFQ1?=
 =?utf-8?B?S1YvekZhQVhOL25pSHJkSHhEWnhleFEyZ1dscGxSb2tDalJudUxtcktRd0E5?=
 =?utf-8?B?YjRuQlNWSnJzNEdsSjArNnRFQkpNNC96NGRzZ3RjYVo2Y3NlT1J2UndQcVpR?=
 =?utf-8?B?TDR6MVVsVkVTSU5Db25zT1BKWDUyQ3IvQUJNQktBeXJja2ZoMWZyTTNWVVIr?=
 =?utf-8?B?RWhHaEdIL24yRmxnU3JCWjlqYWFkSkUxK1kvZkV2NkpnZGYvODFIYUVVOFVi?=
 =?utf-8?B?dk9Sc29sWWF1SkRIQ3kzeEtWOTh0MGF1N1VnRy9iOGtRVmZDZVVFdjdWcmxv?=
 =?utf-8?B?Y245QytITFNUbEVoa2FRRlQ0WitETGlMWU93amZRV2NjbDNVeExwTWk2MDNn?=
 =?utf-8?B?VTFNZXNsMmowaEg3T0xYQzE0RDJVY0RWbUlzWi9EcXJINjRnWjI3U0cwYmNX?=
 =?utf-8?B?M0tDV3FOWEtJYjhxUHo2czVzZjFMRWNFUGFwS0R2cXNCbGYrTDVjZkN5R2ti?=
 =?utf-8?B?SUpUKzJUWkx1YVJja2daQlI2L3dtSll5ci9OM3g0Wi9DUy80RFYvQ01oRlhy?=
 =?utf-8?B?VVluM1lXRjJKR2c1UkgzUDdhM1ZSZnYwYjBCakR5MWpMMDQxNnM3QThIcTBl?=
 =?utf-8?B?V0tKM0NVWkpNQWt5U3RsNHlvSFc3SkwyNi9nSGR0TU0xVC9jYm9HWUZISXI1?=
 =?utf-8?B?M3ZDR1hkM3NCOGdVL1BMN1J6dm5sYnFqVWNrdDFmMFpWUGRkUFdtOU5hQW5w?=
 =?utf-8?B?THZDYXk0UHJmMHRQaExZd1lVSk9vd2R6WUxRVDRxOCsyM2k0QWgwRkpMbzlL?=
 =?utf-8?B?TmpaeG9wYTZ3c1BRR2YvZkZCcWlTRUlkcEg3U2VNcmxrc2hCakFXU1FlT0Fm?=
 =?utf-8?B?VzYzTzA5dnlrZVhMQU9BSEJiamVFMnlmSGlraXl0cFF1cG5jbUhSV1pQanl6?=
 =?utf-8?Q?CiW4GcGFiDEaW+w9mMZ6fyUiN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7870f3c-2915-48f4-9145-08db3a05b0c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:53:51.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/61NyONtEN105DH+mHFbSujDlTL4gT+kcA4fJ4umeFMdGviwNTBn99bErESlXsWHnrVD0helia/g0RIq/h6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/10/23 16:47, Borislav Petkov wrote:
> On Mon, Apr 10, 2023 at 03:33:57PM -0500, Yazen Ghannam wrote:
>> The "L0" cache level is listed as "reserved" in legacy documentation.
>> This has now been defined as "Core" in current documentation for
>> Zen-based systems.
>>
>> Update the cache level strings to include this new definition.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>  drivers/edac/mce_amd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index cc5c63feb26a..1d1b9da3b9bd 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(amd_unregister_ecc_decoder);
>>  static const char * const tt_msgs[] = { "INSN", "DATA", "GEN", "RESV" };
>>  
>>  /* cache level */
>> -static const char * const ll_msgs[] = { "RESV", "L1", "L2", "L3/GEN" };
>> +static const char * const ll_msgs[] = { "CORE", "L1", "L2", "L3/GEN" };
> 
> Still used on legacy machines. I thought we agreed we'll move all the
> decoding to luserspace, for newer Zens...
> 

I was thinking about that for the Extended Error Code descriptions. But good
point, please disregard this patch.

Thanks,
Yazen


