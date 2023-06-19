Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ADB734A58
	for <lists+linux-edac@lfdr.de>; Mon, 19 Jun 2023 04:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjFSCn1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 18 Jun 2023 22:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSCn0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 18 Jun 2023 22:43:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD91B5;
        Sun, 18 Jun 2023 19:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBlcmCy45oeLF8+4pxyWi9ymgQ+v/pW+zi17lRd8ATs9pkpCFJ7ouWoiQThsVvFwjJv1ln+HqBG2WMB1cAC4GzBEIR/Ufn2xBi333iYv5G2Ln89DSt1++CxRj1R4ilBE3SpFm4NZUmwbk4tbVRDRDy8/W0wo/AuTxv9/L7lSYNqfkMGYJd/6UWH9u7CuyhgPK2VbCP7DFMwTgHVlbzPsBGrp2OUoSfAbbpuLpYFQKSrUCIBwphnEBJyRIALoKeRlFGvmpBL3GaqvGzGM6il2ooTqMfdYIU7mDl/VC2mfXwU33hTlnmmGC2n5DxwEVnVWHZZ+yxy8h2cMOCY9o1EXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIE62OWP9v5M5+t9vBpgkPzTM/1K8VKJIA/foO6jaZI=;
 b=aoFgMKW0txvvLWlQHxjlv0oThBbMhFKtwz6yScVssHkL6daSs+exGY7bQ9ptrJdbDDELFVt8ek3fq8y7n73mwmvuh8hN5f1xR7Huijz/9fOCRv2EXZzK/YZ6tvKtNNnlpU24AQzBrZh4xxZ7RjAGmki2u4zS+Zr5K2xLDkcJ3w3d6HSkOMteYDI5Btvg5u7tLtfYb0s+s4r8GhOZ1cLk3g8IDi9ugwlTmQOF6HV9oRdYGVKiK8VZbcls8V3pqjlnV0rrKCqIkZE7IeyMZK2zSP7l3NyxW9a4Y578K5Eseyv7ybH8X7XFkDh1gv0SDipRcSKHZtJHfotPtZ0eyMYH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIE62OWP9v5M5+t9vBpgkPzTM/1K8VKJIA/foO6jaZI=;
 b=qtCmLCK5MUoc9IHDtfqXnWlJ5PFMAhk/+8uGjqhiK+0GliPEFOpd6KYu5RlaE3DEKDEpO2deEoDLeqGH2ztyhE2LRtBU9mIsmEzq9T2xpFr6+xOiJ50mPJiQrXzr3EEpYRdNmMnhgl3hMEKazt/2Y9bRaHgTTpF1/UvE3nKMYXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.32; Mon, 19 Jun
 2023 02:42:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 02:42:21 +0000
Message-ID: <eddd118b-a10b-7208-7e96-df909d038233@amd.com>
Date:   Sun, 18 Jun 2023 21:42:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 0/6] Enhance AMD SMN Error Checking
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        markgross@kernel.org, hdegoede@redhat.com,
        Shyam-sundar.S-k@amd.com, linux-edac@vger.kernel.org,
        clemens@ladisch.de, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, babu.moger@amd.com
References: <20230615160328.419610-1-yazen.ghannam@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230615160328.419610-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:5:335::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0879cc-89f1-4bc4-128c-08db706ece47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgsUESVcguhofxkurK2OkwDiSW9fE9ISXWHW9oSXscjSRWajB9AHdO9yWdaZWNvyj881JKLMFyJvYDNkwWJruH83n74mxgRBg1SwUaOxUKJ98tGJwHgXU3hydZazTgEDL7qLb3SF07fB4XD+lDn0mnuPfKQDDhBmGHQPvR7dtcSsp7826CnFRee+wR15AGX3qMQGLq1CaASwnSMWGyL+9tighpefsg5jryfYBaViHI/owGZ4+FXigdFrGaHlT77HATXw2wBfS9neqP49fGttiMa7UNK0Q3DdMoQbvflbuIvsGUPvtjblHIjpWL3Iveyl+DyboAjSIL8sBxH3cLjsRMOqp61EZLKSS+c590CQiyn6PnmUBxBezw/yYOt01tflpYydef62nolwCRuiXuQUSrofy1N6GJkGAB9ZeyAo0xX9dj54TZk8VlWXbRTetJiw4+z5svGjtIhw0m0MHMzcVOA+oBz//enuvPpnbT83p5uvB+tGCdebQrHAPS3Vf84Qh45GYGUj0nBxPmIVR1jWMJIXXxhYURtgVUSLnTU2vVzQAyEGzbbT7UT1Bik+KZBHhG57cvsVqXlPMZZN+meqBHpymiAdchATJEI+fMczBCXUwIYALM+7gfnLm5A80xzW2+22BLIf5C3OrfP9JWEpPSXfzpMzE1y9JVxSWmNpWGziTKecNaX1e4aw74EC9Nph
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(66946007)(66556008)(66476007)(316002)(4326008)(186003)(2616005)(38100700002)(86362001)(31696002)(53546011)(6506007)(83380400001)(6512007)(478600001)(966005)(6666004)(6486002)(36756003)(2906002)(5660300002)(8936002)(8676002)(7416002)(41300700001)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhVeHR4bHhtMzVic2w0OWVUcjFkbXovYVgyelVEei91TmYrMlRpRlV2UGkr?=
 =?utf-8?B?T0F0Z0dDKzNzV3JwMmNuSldzNTVSS2JvK2QwWEtCdzdtMDVUblcxMnZORUdo?=
 =?utf-8?B?Y1l4ZHlXRG9INFFkMjYvTDdDaExFVEFwci9BdDg4Q2dFblVjWVllbTUrcFBy?=
 =?utf-8?B?ZGVCbTZ1Z1N6WXdvdzZRNmU1Qk5GbkpsYS9odVBzQzVBd3pmTXhzbEZSRFY3?=
 =?utf-8?B?aVhKSzcrc0tYTCt5SlNUU0ZVb3p3RjZackxlYWFtYlhtVFBna2poenkxMlcx?=
 =?utf-8?B?NFE5VWQzc2dkV0t6Q2xtYkdNdjFrQi9tUHcxZmhjb2FocHVDbm1kdkVrWGVS?=
 =?utf-8?B?VUN0N1hNYUcxYWNUOHRrZmN0bHE3Q2VsaCtpeTk5akxHQVc4VTBHNXd2bDMw?=
 =?utf-8?B?UExKSHBFeDgxRkZEejFrY2RPRHRzMjZPN201VlhENnBUamlaTjhJQ1BNU1NI?=
 =?utf-8?B?SVJ2OG5KZVVHUFljQmM5UFBmM1RBSVV2Yi9PMXlnOHdaUGJyMGVJdmdOSGtX?=
 =?utf-8?B?eUZrMncxVnAvNmRrUlJ3RHFUTnFYcHFIaXRXWkJ6YUlsMU16d1ZYamZxd3gy?=
 =?utf-8?B?cUJSV0tmRGdLMGJzRGI0NFoxQU90amdzNmRadk1obkdUZUhTQUFid1RKYWJI?=
 =?utf-8?B?clluSWxpOHc2SjVrNHNKMHFGWnZ5clk2ZkZrMjVyYmVyYytHTm11R1Z1MTlF?=
 =?utf-8?B?R3ZvMUlHdEk2ME1pLzZHQStkNXZhQjRyTzFMdkE5cFpHTHgvY1hWcTI2TVJa?=
 =?utf-8?B?Vkp1Q3B5RkR5emVzRndtbUZDeUx0TE1SYlhPSzZxbTVoTFpKZ1NIOUpWbEIy?=
 =?utf-8?B?aGZ0WHdOSnIvVWl2V05zajJtd3laZGp2MnZlLy9jM0ZOaEI0K3VYOE1telpi?=
 =?utf-8?B?cklKaS9CcEVTRjQrbWFFb0ZwOU9zQThuWEhEZlBJbm1nd0ZQdHdQUHJWTFds?=
 =?utf-8?B?a0p4MkhxU1BqVkxZaUZpZXlGZm9iZlZ0K2orTHRYcTZPK3BhenNndlJUaWd3?=
 =?utf-8?B?ckRhKzV6bXMvaGNCTWY0TnUyMS9kV1hjMXlFeU9NNDFHWmNDdld0TE53VlAz?=
 =?utf-8?B?VUFkM0k1L2tFdXc0TldlbVNrZENwYUFFM3F0MTlXZEJVU1BKTFdHSndxQ3h4?=
 =?utf-8?B?VjhETXZMT2NLbU44cHhQRWpIQmVpMWNBTUovYXVxWGVLc0FuYW5xY2F3bWlL?=
 =?utf-8?B?bWxLSTNVeHc1L1Y3bERWK1E0MnhOQkRYMVZnQjNEbXF4Qjc1NDlFZ2l5VmpX?=
 =?utf-8?B?TzJIdnJja3Z5WUhhRHhMNXFuZEI5b0V4N003TWZSRVd3c1crSklCQy9wYmE1?=
 =?utf-8?B?M1c4STBuQVRHNm9hd0ZEb2Y3SzdrOFRISnpYSTJkVHNNUjcyTGU3cXhCeUg4?=
 =?utf-8?B?dzdZcFpOWjVlR1dCdmV1b3RoOXlHWHdRREZrNEIxODdLdnd0MGR3bnhOTkx0?=
 =?utf-8?B?S0xWVmgyWHJya3JNLzNWSkJnWjU5Ni9hdzNlcDNlUkh3QnVybFRyZkN4Wndl?=
 =?utf-8?B?UkM5Y3MrZU9hNWJ4RFY2QXdTcG5SdTR4RHNmTDNUWDJ0NTBrOVVYOW5SME1R?=
 =?utf-8?B?c2l1SUpGejE4Y2xBZzNiYkd2clFTRTBqdXhHYXZNT2dOOGxxQ3JsQWdZSERn?=
 =?utf-8?B?eG03SWQ0T3Q2QlY0VHlKL2VwUFRIVFJkUkVDdEtKaWRBTWtNYi9Sc2JnZEtk?=
 =?utf-8?B?bUk4T2dPRkFTVGdXY2w5VzVMQU8rSDNtZ0FtdWZMdGFCRjF0RVI1WUVVWnRX?=
 =?utf-8?B?dHBDQ0Zub2daeVZlYlRUOWtMWGRha3ppZjR0eFdBMVBXd01xVExWR29nTUps?=
 =?utf-8?B?US9JWmZGVkpmSEZlVmFFeTl6YU1iTy80M2ZDenc4cmdZVW13aHVHT2NJNjE0?=
 =?utf-8?B?V01MdUE3KzhLMk1pZE03L3hhdHVmcC9GUkphTVI5VFpZWHIzd1lQbGJJZUhz?=
 =?utf-8?B?S1VYYk9nV2Y5Y3JPZzhLU0JHeW1BZktkYlFnd2Q2bWZhVldnL0ova29LUlRU?=
 =?utf-8?B?Yzc5dDFkQTByVmIybXBaZllHS2VMUjNFQXV0TjNrNEgwWkhqYXhHcXFSNDFD?=
 =?utf-8?B?RkwrVi9KZDJXenNzNnFwYzE2TWVOR0ptQ1FUTjQweGpPKzBFT3UvZkJmQmI1?=
 =?utf-8?B?NzBzNDBvZDhIazVJQXgxOWtmUTNwNmZ4cXhLdE1LK1NyWVBOaVlnYzhnbGRV?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0879cc-89f1-4bc4-128c-08db706ece47
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 02:42:21.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q3jBY+XKJgNS3H/kADbZ4JdEGg7o2Yrv0C4q94I9K89c0e6h0krAt8BXSnI+wguDHvcSxUKG6g0celB4PP4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/23 11:03, Yazen Ghannam wrote:
> Hi all,
> 
> This set implements more robust error checking for AMD System Management
> Network (SMN) accesses.
> 
> This set is a follow up to this discussion:
> https://lore.kernel.org/lkml/20230403164244.471141-1-yazen.ghannam@amd.com/
> 
> Patches 1-3:
> 	- Pre-patches in AMD64 EDAC and K10Temp modules.
> 	- Required in order to avoid build warnings with the
> 	  introduction of the __must_check attribute in patch 4.
> Patch 4:
> 	- Introduces __must_check attribute for SMN access functions.
> 	- Handles "PCI Error Response" behavior for SMN reads.
> Patches 5-6:
> 	- Optional cleanup patches in k10temp.
> 	- Not required for the SMN access issue, but I thought they may
> 	  be good to do.
> 

Each of the patches in the series looks good to me.
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> I've included x86 platform driver folks for awareness, since there are
> some AMD SMN users there.

These uses seem to be handled fine by the existing error checking to me.
There is also a consumer of amd_smn_read/amd_smn_write in 
arch/x86/pci/fixup.c that I think looks fine still.

> 
> Thanks,
> Yazen
> 
> Link:
> https://lore.kernel.org/r/20230516202430.4157216-1-yazen.ghannam@amd.com
> 
> v1->v2:
> * Rebase on tip/master.
> * Address comments from Guenter.
> 
> Yazen Ghannam (6):
>    EDAC/amd64: Remove unused register accesses
>    EDAC/amd64: Check return value of amd_smn_read()
>    hwmon: (k10temp) Check return value of amd_smn_read()
>    x86/amd_nb: Enhance SMN access error checking
>    hwmon: (k10temp) Define helper function to read CCD temp
>    hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters
> 
>   arch/x86/include/asm/amd_nb.h |  4 +--
>   arch/x86/kernel/amd_nb.c      | 46 ++++++++++++++++++++----
>   drivers/edac/amd64_edac.c     | 68 +++++++++++++++++++----------------
>   drivers/edac/amd64_edac.h     |  4 ---
>   drivers/hwmon/k10temp.c       | 57 +++++++++++++++++++----------
>   5 files changed, 119 insertions(+), 60 deletions(-)
> 

