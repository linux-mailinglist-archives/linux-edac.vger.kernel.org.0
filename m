Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40514E9D5F
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbiC1RXL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiC1RXJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 13:23:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB760CD1;
        Mon, 28 Mar 2022 10:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3kCu/ZpSatZQz0yJyAyRQLg3fDkpp1r6tY9lFkxHjEDvrW0tFqYEpQCeYvrU/CmTb176qlvSPKYMngLlJPf9MM0oHMiPKcaDHb86AQMOzDq1r4xlqBoQDgPW/q3pe6sBvB3en5iZs5edKBo76WE7cqCDOJIUVCJk7XBzIXsECoSWfBoqIvgw/RabxIAH8xI+025v7ZlIkcv6Y86sbw070b32mkDeiRmSV+72fs91tKk2W58fK5ew9te24xRvCdTOgcQQFdjaJXXKdq9sRI6ol7kj9OSdofoxvIJZQC4iFaaK31IWYuqUi4DxKptgzunsfWlF1DNIxTrkU7eQLjOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TwfYpQftb5Z+ql+l+BnRH1B01AxN32bpLeXOPwrk/k=;
 b=jyn/zu5bswrbGFz9dgDOZfmB8yQqGpBTGw6cCn+KqZ+tN3pNJRltz+s2l6j4k0H6ieMYv6sqHe+H7fKu19Vf6RN5GX9a6M3C0gQneAkKlSAhsgIZyZ5TIS/RBSIV/LQfxKB2EDz7f7oTr+aATxx6YLSEIMF/RYEWW75xpjlcpyo9kylZl+KJzyl6cgMfQasUNhfzm2ihWDNDApBvEy+/+1LT3uubai7/3pr0yJvIMzkiAhU459zI4CB/BB+m5a6LIHx+zLQNADuSYsJcEBSZcjEfVHp6et7IvkA4a38THhptw+RSp7eLUEtTj1agr8QTTRwGLrpgk8AXO4UF/WSfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TwfYpQftb5Z+ql+l+BnRH1B01AxN32bpLeXOPwrk/k=;
 b=ofLVacwkbjogG+3dueIYYOf+zK7CwUx/8LOtZYKMjBe0/B+F6LZCohnFSW5m1gh53EpKGBtCl73g6MVS5WlCBskUKioF6AZRFb3HK6M/6iQsgbb+Iq5AzKRlQZELWsb62eGotaCnK6YU26d4LlY948y/fgT0naDl+RNnxYfzrA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by MW2PR12MB4668.namprd12.prod.outlook.com (2603:10b6:302:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 17:21:25 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::c47b:31f3:4280:8cd%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 17:21:24 +0000
Message-ID: <b7652beb-470d-fa46-fa5e-996d45b38fad@amd.com>
Date:   Mon, 28 Mar 2022 22:51:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] x86/amd_nb: unexport amd_cache_northbridges()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>,
        David Airlie <airlied@linux.ie>
References: <20220324122729.221765-1-nchatrad@amd.com>
 <YjzCMYxgraTI7wrY@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YjzCMYxgraTI7wrY@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::12) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd5e5467-6c24-40c6-85b2-08da10df6283
X-MS-TrafficTypeDiagnostic: MW2PR12MB4668:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB466810FC01BA100F7160C3CBE81D9@MW2PR12MB4668.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mVCUz36RSsgelQi2Ilpbypoj7bBg1w+QD2cFAg/ukDObWjZcrrFesRj0IBdFWhUCEymoS7z1BTZ8sJFZObl9p1GTgi7vWJGvhJLyF1H5ueog5HY0UuqlljdICZdGj971zwl38F3UE8qhF7gGlGZ/ceICWiYY2ZLI9PXusraHhrwsKOMqtsy7lteOpjvmDE3mX6mqf+OTNWVQu591ruttquSkKKc3qsylasTuvHw+M5L8icii/YCF7aQMjT+8i1kyP/LNhaVgP0Lb1eYBgTkaBZ/l4EP5dwvHHR5EHGAhCZo5HUCq3PifYnfpe7W1FCtF1K1SvV4/VXvIAqnSayK0yyRoOLyM7VG/reH79ySudAX0+WO2ZyBoGgqshCcUtJ0MIDHvgKBrVyZsOFJ78gph5O7gCyLQqf1AzU0gUYFSKpf9WBVTfAkhifrPFRuTiIQY6XgiYFpJ2XnmwnZrDo1QJB5pys8jg7UJe4jz5LUpeAvK8wfB+XOJMhtxLq1T3GrUqDxc6MwjriJcVlzIiiY+bJ0TmdDa/4GsoMLdZ5YLcwgrlsIbAMfpWSaGOkoMiSe2kWy0uYpwQj4JdEz9X1bTU6ufz+oHJLrCUrGu8OcwxhDwEpYiIcqzqCI0d4jGqYH/Sc/nft3b3Y54fiuvLO5JPqTZFYhYzGri760e+aj6ATx2Yz8hZlPcz+5GffJJEHE2/+ki4Wnuoy7w9012hef35fSX0hrAG6dlEdiuly8xU8PVb0bIxrKnqzQiHEU5HPNTyA24cH6YCnQc24SHL4f9pYYxTEmeJh50IKMJZcEmepInn2oC9zwsTiypOW7mcyj7nQxehTTrS7bAS2YvMwkEIccxQUzdfw/OhcEM12rscY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6486002)(966005)(5660300002)(26005)(53546011)(2906002)(8936002)(31686004)(6666004)(4326008)(31696002)(38100700002)(66476007)(316002)(66556008)(186003)(8676002)(6916009)(54906003)(66946007)(36756003)(45080400002)(6512007)(508600001)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGhEaUQrTG5DSjcrUEduZHM4RFlzQmdkaGRyYzF1YlBWOUhSNERFYUJtQTdn?=
 =?utf-8?B?U0tzZElBU015cnRtNzM2YzM2UE13UzdOSEErMFVTUUkvVVRHSHowcENkV2VO?=
 =?utf-8?B?cWVOVDlkc1hTZUx3eWU4Q3pDVEpXbXRHMWpkckgxNnNJcEJMeG1jcThpN2Qv?=
 =?utf-8?B?MmQ5dXU2LzNnY3pSZEZEOHJGdHJPTkhIZThHQkV2cUdEKzRPRTllajhwZU5M?=
 =?utf-8?B?SzFwcFYreWg1UGZEWnAvcE1scndWTzJ6c0VYWTA4dll4ZGhhZ204QlphUlVN?=
 =?utf-8?B?NnBOVGFIVlFaeHdQaFFtWTlqV243aS9aRVNJS2tyMnFYYjU4amlJaU56T3Ez?=
 =?utf-8?B?Uk5QdlQvaitTdTkzcDR5TC9ocitqdlh3aGxVbTdxWWs1T01aYWNlcUNHS0Fk?=
 =?utf-8?B?L1d4VHF0NDVZbFY4bjNMcW11ZGgzbEpsZ2JMVDNMRkU5VTBuODRwQ1BuSXdX?=
 =?utf-8?B?eFFvRGhLMkMwR1VHcHgrOGdjUVZxMFRlZmNHRHJhTy9tTFE5N25mRlJ0Q2xY?=
 =?utf-8?B?N2YzdnBxSmlKYmZ0L21jOURSQUI5T0tHMmRjdHREaWZyazY4ODVxZjNLSE9S?=
 =?utf-8?B?UVZxSk9LVkErV2d1bzB2UU5nbi9YMXNaMG8yOWwzZlVxeVZWYzVWRUg2NVRl?=
 =?utf-8?B?cTdPZFIyZkZYZG5VVFhaeHdnd2ZsV0FuUGY4MHhtdmZDQzdFK3J3aWR6SWkz?=
 =?utf-8?B?K3VzVWhUa3I5TUJFWklWeWdNL2RDOHpVMDlHL21LNUdnckZHSnl5d0wwemFu?=
 =?utf-8?B?MS8wdVN6anZUdFMrRW1LQ3NhZnNzaUJveEcvVU9ndHJxN0ExRVRMZEUzb0pN?=
 =?utf-8?B?NHJsejVjYWNJQ0R0czErbk9uTnVCNzl5Z1Q5TEFQNk1uSll6OFFqVFNSYTlN?=
 =?utf-8?B?QW5IQTd3WUNReGs3NStST3BCT0E0NUJnWkx6VVpPWnhYY1RhNlFtUlVLQnRX?=
 =?utf-8?B?UER2OFlzZDNzWnpZR0dHQnA2S1c2STV5QkFzWXZPSjdFNXhHSzR3ZmxidGo0?=
 =?utf-8?B?dURmVXY3MHBZLzFWWWo2ZHdOaDkzdjdFSVFBNGFTbUJDclVTejI4R2tFRnl0?=
 =?utf-8?B?NU50WFREVFcrZlY4Z0JZQzlQeUZMbkIyWUlOL3AzTjZpNDlEU0dRaFFmdUxF?=
 =?utf-8?B?L2twaTVrR3orYnlTcjNzSlZ3TXZRa1pMcS9UM2d1Rng3R3NjYmR0ajBqcmEv?=
 =?utf-8?B?S1ExWHR1VC8xSURnRHNuTDFTc1JHc2YzMTNtTXBXdkJteEdQZ0FHVzJ1WjZ6?=
 =?utf-8?B?eVpIenZsNFJRY2ptdGhjUzNLL0F0dmplVVAyMGpNT2xlNzVvN1Z3WndERHhB?=
 =?utf-8?B?NzQ4ampUVitBYnM1V1BucHNwQVM3VUFQT3NjZnVwaS9USWxMeml2K1V0RUYv?=
 =?utf-8?B?aUJXRm52VmpOam53UlJxbDZ2dnlQVVJneFkrM0VPbm1IVWRLZGRGbUNYTnRv?=
 =?utf-8?B?MFlpZWhMVGYrbms1a1lnendYUnVxR1g0cFMzK2xSMy8xTDF0MmI3TUt1ckps?=
 =?utf-8?B?UEpXQUNVTTlwSGJRdDliWTBvRXlmQitFMENIaWVWZUh2Wm9EWFppbjlPTXk3?=
 =?utf-8?B?TnBoaURxemVRc3dTNVpFRWptQlVvNm5WNS9PRWNHYjBVYXRyc282eG0xVjRI?=
 =?utf-8?B?RCszWXdRVEZmTmVoaCt6djgvSzdKNnJybDlGamF6QzNaakF4K0k4WldMWTR3?=
 =?utf-8?B?MzFLdHMreUVpck4raStya3lmeStRc2sxZm9vMjRKWGRHN3N4aTlGSnE0QVB0?=
 =?utf-8?B?U1dGblU3RUpIS3JzY1hvbGVGdkhON1ZhZEhnS1RKNzlCYkp2UnU2RVFjZlFn?=
 =?utf-8?B?UThXemd0clBuMUhrOUhtTXJGV3hUNy9PQUZ1SXpHM2lkT3J6ZFVVMGV3aWE3?=
 =?utf-8?B?dDhKTThkV2lsUWY5TE5NRDd6T0hVdURSWHVhWDRqeDhxVGFQZ29WT1F1WjdJ?=
 =?utf-8?B?eHZDcDIwNlZNM3owWG1RVVRESFZwdCsySTIxdHhqNmJSVzVNbXd4Q3JEUU83?=
 =?utf-8?B?YkZWTUFCbkRGQnFFeFpMaHdSUHp4UU9NRytZT3U5TTVPazN5dGtPOTBQUzlY?=
 =?utf-8?B?YkdFNldBZ3Z4Uytqd1J2MGd0bWJlNUt2VU81YUNDNFREK1JxTWpSRll3VitT?=
 =?utf-8?B?NlJQdHB6REJlMFMyTVhYSTVZSkFTVE43MVFTblNkcnVTbnRhem1uU21hak5K?=
 =?utf-8?B?OTRyT1RYVjJqME0zYWF5SjdjVlJWcmxsMkNCbjBKd2N1K3dBeXVCSjVBN05k?=
 =?utf-8?B?cEpjMGpmZ3ByRUtHeVZYNkZSSThLVGVlS21sdzRKUE9DNmZVSXVFNGlLazFU?=
 =?utf-8?B?VEdjcnh2b2ZIWWhwRWo3RFk4bWVDWTdGZEtTaWE3cm5PdFkrMktZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e5467-6c24-40c6-85b2-08da10df6283
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:21:24.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z53RUFqt6ez2Oezwo+qChHJCi5h1HRD2YHRPiZMjqR2jdR7cdyoyDISs/e+YdzKKcZVb47BMpGGdB8RiZ1XeTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 3/25/2022 12:40 AM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Mar 24, 2022 at 05:57:29PM +0530, Naveen Krishna Chatradhi wrote:
>> From: Muralidhara M K <muralimk@amd.com>
>>
>> amd_cache_northbridges() is exported by amd_nb.c and is used by
>> amd64-agp.c and amd64_edac.c modules.
>>
>> init_amd_nbs() already calls amd_cache_northbridges() unconditionally,
>> during fs_initcall() phase, which happens before the device_initcall().
> No, that's not even trying. I went and did your work for you. Please
> try harder in the future to really really explain why you're doing what
> you're doing so that a reader of your commit message can easily follow
> your logic and not have to do research just to figure out why your
> change is ok.

Understood, will try and explain better for future patches.

Thank you

>
> ---
>  From f5e82ad4c749afb63cdebba6729452e516bc1fa9 Mon Sep 17 00:00:00 2001
> From: Muralidhara M K <muralimk@amd.com>
> Date: Thu, 24 Mar 2022 17:57:29 +0530
> Subject: [PATCH] x86/amd_nb: Unexport amd_cache_northbridges()
>
> amd_cache_northbridges() is exported by amd_nb.c and is called by
> amd64-agp.c and amd64_edac.c modules at module_init() time so that NB
> descriptors are properly cached before those drivers can use them.
>
> However, the init_amd_nbs() initcall already does call
> amd_cache_northbridges() unconditionally and thus makes sure the NB
> descriptors are enumerated.
>
> That initcall is a fs_initcall type which is on the 5th group (starting
> from 0) of initcalls that gets run in increasing numerical order by the
> init code.
>
> The module_init() call is turned into an __initcall() in the MODULE=n
> case and those are device-level initcalls, i.e., group 6.
>
> Therefore, the northbridges caching is already finished by the time
> module initialization starts and thus the correct initialization order
> is retained.
>
> Unexport amd_cache_northbridges(), update dependent modules to
> call amd_nb_num() instead. While at it, simplify the checks in
> amd_cache_northbridges().
>
>    [ bp: Heavily massage and *actually* explain why the change is ok. ]
>
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20220324122729.221765-1-nchatrad%40amd.com&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cad77d5aa72554663e79d08da0dca506b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637837460434170931%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=MsZNFF0%2F5x%2BJkuOPtL%2BNFZRxtBe548sVkEbyHOUcTcQ%3D&amp;reserved=0
> ---
>   arch/x86/include/asm/amd_nb.h | 1 -
>   arch/x86/kernel/amd_nb.c      | 7 +++----
>   drivers/char/agp/amd64-agp.c  | 2 +-
>   drivers/edac/amd64_edac.c     | 2 +-
>   4 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 00d1a400b7a1..ed0eaf65c437 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -16,7 +16,6 @@ extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
>
>   extern bool early_is_amd_nb(u32 value);
>   extern struct resource *amd_get_mmconfig_range(struct resource *res);
> -extern int amd_cache_northbridges(void);
>   extern void amd_flush_garts(void);
>   extern int amd_numa_init(void);
>   extern int amd_get_subcaches(int);
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 020c906f7934..190e0f763375 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -188,7 +188,7 @@ int amd_smn_write(u16 node, u32 address, u32 value)
>   EXPORT_SYMBOL_GPL(amd_smn_write);
>
>
> -int amd_cache_northbridges(void)
> +static int amd_cache_northbridges(void)
>   {
>          const struct pci_device_id *misc_ids = amd_nb_misc_ids;
>          const struct pci_device_id *link_ids = amd_nb_link_ids;
> @@ -210,14 +210,14 @@ int amd_cache_northbridges(void)
>          }
>
>          misc = NULL;
> -       while ((misc = next_northbridge(misc, misc_ids)) != NULL)
> +       while ((misc = next_northbridge(misc, misc_ids)))
>                  misc_count++;
>
>          if (!misc_count)
>                  return -ENODEV;
>
>          root = NULL;
> -       while ((root = next_northbridge(root, root_ids)) != NULL)
> +       while ((root = next_northbridge(root, root_ids)))
>                  root_count++;
>
>          if (root_count) {
> @@ -290,7 +290,6 @@ int amd_cache_northbridges(void)
>
>          return 0;
>   }
> -EXPORT_SYMBOL_GPL(amd_cache_northbridges);
>
>   /*
>    * Ignores subdevice/subvendor but as far as I can figure out
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index dc78a4fb879e..84a4aa9312cf 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -327,7 +327,7 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
>   {
>          int i;
>
> -       if (amd_cache_northbridges() < 0)
> +       if (!amd_nb_num())
>                  return -ENODEV;
>
>          if (!amd_nb_has_feature(AMD_NB_GART))
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index fba609ada0e6..af2c578f8ab3 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -4269,7 +4269,7 @@ static int __init amd64_edac_init(void)
>          if (!x86_match_cpu(amd64_cpuids))
>                  return -ENODEV;
>
> -       if (amd_cache_northbridges() < 0)
> +       if (!amd_nb_num())
>                  return -ENODEV;
>
>          opstate_init();
> --
> 2.35.1
>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Cad77d5aa72554663e79d08da0dca506b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637837460434170931%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=JAgdd9bpTtNaF2UG9seKB%2FLI3pF5wrWk4Sj1JurN860%3D&amp;reserved=0
