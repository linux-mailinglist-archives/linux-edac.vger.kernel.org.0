Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71FE4E98CC
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbiC1N6w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiC1N6w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 09:58:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD55D678;
        Mon, 28 Mar 2022 06:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkUfBiXs8TMoreEb2usYhdeGAEAyXw/EvMse+Q3+bk8ckBsfBdl9hsgUZEJzJZ8zOBACd2BYntH2L9ueTDLTKjl7vHm6HmP6kfrDKBTaK4mbAo/ESdbFhCNb1IPJ0mjtTAOzPl8yrSf3+AJRlp/21styD5+baQNxJfobD+TJNgBBdcqkTEBnuZ/Syv8uU1nTfQJH28qbsMI9NdrM1qU3K84Av+bWo6paK1kDK2+FQVVNZBTcu9gej5i8i9OzmvJxMTjiVFZ0RQtuA401lqkSv/40DAtNv0inNvQtABurNmn0xHENKF4tqvqbvQnYSfSzR4g+hjnGRXY4fSTchoTe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLmS5dy+0H1+X6RIilooNHV9HFuH4rTt1EZ715VC4+s=;
 b=aYAZ9Weh9yM0AOYhqrinQrIf/KcHvHiAIw7tVloLb4bKyTtYCtP647QIS05H58PQeQYN582kXC084BTkMFheJSuLMAoQG5EIRxkUstdFYg59wMZef1aUsXnVGi6naZ3ABFCOW/tuWP2+UuLY+N8nN4xU5mzK9tZeVf3ywmuGgXIohdxPN0W9Sc4TCzxqO/bS8wKvYxhW7p3Z49HndaGSt4QvxpnRoLpY2AFI/d2Ak6UghBDdamiIJxatVzveyVxvZfM6Zzst5h/3cS4++FdgFGk8a4fqo64o3YVdnVM+RqP6h1JkoJG26UIuPoYezfDTyK9nQZP7XknQWizFvoGpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLmS5dy+0H1+X6RIilooNHV9HFuH4rTt1EZ715VC4+s=;
 b=oBWz+ZAg772ro2dREgpFMPBotJ0LItgZdyDzeJMISWkETUQ3p6vNs2eTpQBSTnVizE6wn1hO0ZRdahbDaEoK9LsiQVD8VfY9HHxk4bQ1mecqfgIK9LHmJPqNfCu1a09XRVOs/eQ28i0H3OKGZnVNzM4mLF2CF5o84WLT9FvlVKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4846.namprd12.prod.outlook.com (2603:10b6:208:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:57:09 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 13:57:07 +0000
Message-ID: <299368f0-a3f3-c252-ab98-7dd324dbd3c5@amd.com>
Date:   Mon, 28 Mar 2022 08:57:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and
 include messages for panic cases
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
 <YkG+SFCYMoAXrqJ3@zn.tnic>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YkG+SFCYMoAXrqJ3@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0442.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ab6c60c-bd9c-438e-d82d-08da10c2d87d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4846:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4846B3BC6C5D9C8A333CBC51F81D9@MN2PR12MB4846.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRVaHWp/faOt0pFwjX2Tm8TGc4CZtvQs57GVWl4UFj0jyusWphsq0E6e9R1C+YLyvgjn0xcMIHUWr6e/CQ8FtrhXEm+Cwf/D20LEKTX0liwprDeI1Y2ZQpvMhRjuTyKafidpd747BtjS9ZuCLjIxfg/7xrAi5qWmbQNVISsb2BxJ3OWZvd/lqz/WNDH/tRgfqVZTkCOkdDCNLgaKnCfNrlP7bA1NR4jWD42Ybb7n8/ORh7J3b39IIxmLhmaYQIAG6+FFMbsDS6EDN/nP/zVr2QLShWVmdPtFbX3w+JoHmapRqgk442OOxRXtUfWJZjDv//c97V/23BuhVoM1w4Bc6L4l1bhkxAJdbFX57iksZ9axVMeXUsqHuXO+pANIsqUt1tdDDC01LcGS9yXO1lY2hdBLqTZKr6SGWlS0gL/S56u2JIzQIN9K4TPsXNxuWdEos0Ph9Y+g3cqsq3iAnoUR4SppIoQf0E+MXxbJMKA+PcRmA99JqLrDH3R2qoVCR9fGbun+hH4bwGQNp5LHCg5Wr+E6h1Q7iRPbPhAVFqfmpL4voJ4/1qfqkb4OeTnJ0kUxdS3IGDzbVfY/I93+iU88mC2qnwEfIafbFk3nM1qNd2Os+S/tsLdZIrD446HZcqitbHir3EWITsb45/k+K50waMPPphGdOtYKQ+qrJftsd5xEGWOKuK06ohkqQY1aN8nkXhurxFntlzOH3X6y+m5lNnAipMpIXqF7H0ihqPnFZ1ygJHJQ/KoN106Ka/0Ey0jbOATQfAZZeZLoAiu6+0uAWtNeaVFd9q5VXiYqctngdi8RqTB1N5hGRCqAR9oXOfWAAEpppLVyrzit2uehHvo2wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(26005)(15650500001)(2616005)(186003)(2906002)(38100700002)(66946007)(5660300002)(316002)(6666004)(31696002)(6512007)(6506007)(508600001)(8936002)(4326008)(66476007)(66556008)(44832011)(53546011)(8676002)(6916009)(86362001)(6486002)(36756003)(966005)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW4ydEVDK2g2czNKaXdCeG9hWkpWZ1lLQmRpNjRGaTNFSGlZSk5FS0lmbk9k?=
 =?utf-8?B?eS9wajE0dzlXNWZJeDgzS29uSDhVQzJtQXQ0dmRySFZPU04vWVpjTEFLVmhT?=
 =?utf-8?B?dndVMjFQK3VDVXA3K3RGekptK1NLWG1xUnByOE9jTTJGc2lXT3ljMFFYZDlD?=
 =?utf-8?B?dlJjTHV6MHM5ZzVldC8yTE5zekc1enM5K1lST0l2OSs4ZitNYklJMWR6MFJZ?=
 =?utf-8?B?TzFvKzIyMlZLdXRieUQ5Y1o3OE5keE8rVXp5TUhycy9xS1ZjL0xlL09tQjJ4?=
 =?utf-8?B?UUhRK0Q1S2ppSGF3ZU15NGV3UXBTQW92eGFnQmRaY3FUeDVYZk4rUG9JRWIw?=
 =?utf-8?B?OE1nejRHWnJJYmdObU5zRldMMitVS2JKZmVLRjBCL2s1SGVDak5xQVVWTVQy?=
 =?utf-8?B?T3NVRzg5eTdTcEdFdzBnQXBBaStUMlJiU1h2Ny9KREJDWUdwV01yOU5qU0dV?=
 =?utf-8?B?eDMrbjBXUHZJQnRpZThpdjI2d2tjZnM5OXBwTkZZK2p3TFgxZEVuN0FlU3I5?=
 =?utf-8?B?OG93aXZha1pQemNlYk8vNlppS0FVVkNyT2NJTlRDbWlReHB6VFM1WVpERWhF?=
 =?utf-8?B?eGlmRk1SUlozMkY1dE1MQWwwVituZTE3Sm9naGdtaUw5OGZ3UjRueElPOTh0?=
 =?utf-8?B?TG5WbUZlVnVPWHFrTC9TM21ncmlReGtNQW5aQnJEUHZaM3I5d2NTSnZ6a201?=
 =?utf-8?B?Tng3Y0lRN293MkhtTThrRUNZRGZjWFBSQWo0ZW9NQWhjcVh2ZDFrQ3NLLzdF?=
 =?utf-8?B?QWZUVkhkQXZtalBLTGx0SzhPZGtMVEF3RklUYlRnR0lTVm4yenVIb3JHMjFG?=
 =?utf-8?B?ekFjWktTNmdhdVlVWk9oYUZzeU03d1oxcUJqcmJPakNBcklDUmNEUFVqY0w5?=
 =?utf-8?B?R29aRVRoYTYrTHIxdjM1THpnU3lINVdveEFRSEFpOWRLRnEybDMrb3EvYi9E?=
 =?utf-8?B?L3dWeklDT3hFenpiVEF4MWg3REduelFQU1ByQUxEMlhtNEUvdVUrdnlHd3Er?=
 =?utf-8?B?VE1pWlNvdG5iYmp3NkY4Z21OakN3ZlBSaXAyOEZqbk9GZVBNQ20rR1J0SnB6?=
 =?utf-8?B?SERhSWpMT3V4cDVvTG9aWnY5ZnZpOGNNZ3R6dU1hYjRxT2FScGlkWTFZWmJr?=
 =?utf-8?B?dXU5amQrblhrbnhRZStyQ0srSVliV2ZCdFdHYmpZcmpLK3NyT1Q4Qlo0S25S?=
 =?utf-8?B?dkFUUFdnNllxYUFBOEU1UXlnZFFCdG0rZVZ0SzNXQTFkVGF1cmRnSGwzdmE3?=
 =?utf-8?B?NVl5cC9WZ3lhYTdkQVkvMUwzREtaVldNK1NBMGYzckNiazBFU2RJbjhYS0ZK?=
 =?utf-8?B?U3NyanJIZ0RuV1FMKzk3SFFZYUVuOTNLYjFzd08xcjZJWk81a3UzTWp4MHVL?=
 =?utf-8?B?M2hjZzlzVHpuM2xrRGhTSDc1c21iYkdMQzNJSjRWZUxodHBJdVU4TWdXNkFT?=
 =?utf-8?B?bHY0dEh3MFFFNmpJbjBYSmh1TzdJcmxJRGovNk1sclA5d0UwODAzQ3c1U3Nv?=
 =?utf-8?B?Q0tpcWtHWnkrS010dUhvM0FTRTNNVEpLcW4rR3JobHU3Sk95STBMTGtPU01T?=
 =?utf-8?B?Z2ljRThIRUpsajRpU2N6R0JobkdlTjIydXQrRzBUK2E3Z091UXpWVTJkcEg1?=
 =?utf-8?B?V0haT2kyQnJiUDBlcWJLaGk0RFdkMEE4WHBVc29PV2dVd2x6NDJOOUhPK21r?=
 =?utf-8?B?eHJRVCtEOXZGVys2Z1hUV1QzbUROUTRxWDZISU5Ua3gwZThlOUFwMkJmTDJQ?=
 =?utf-8?B?S25Hd2JSUnRTY0NxRzRVVHlzUFdvLzYrK2pRT2dwWmhwYmZ2UFNzWWxUZFcy?=
 =?utf-8?B?UGMrOTNVZUNvL3FEQnl4M2VuUkNSMVhSTEJkY2cwS2xiOTM1MTd6TnNkUXhp?=
 =?utf-8?B?ejYySVJ5eGRFSWJOeXV5NUhXQ0lQeC9kU0g4OTNtd1NGRE9Md2QycDB3L001?=
 =?utf-8?B?aUVCV3E0eTVxbE1wcWNwUElZbU4yUUFOZFdtcGNKZlZGSVQ0YkpYVVdDWnZD?=
 =?utf-8?B?WEVqNmFpRm9PbjZWMjQ4K2Rhek8vYm9pbm4wSDh4RGcvcHNIY3VsdUFVZUg3?=
 =?utf-8?B?T2YxV3E5RklyZUdBUFY4M2k0LzJqd0o1Rm8wMGlTcnhTYTJTYnh0Vm9ieGFL?=
 =?utf-8?B?bWRUWFRLbXhtaThqVjlvTG5YNU5xLzd3eVRDWmw0YWI1bi8zeDZ4T242Ulhj?=
 =?utf-8?B?dkpQd09GN1F4Zi9XQjd6Ly9CSDd0QnFTb2pLNU1obW5TakJRUFRubmFlWFgx?=
 =?utf-8?B?dTF1TG5RTjU0SEdmOWZLMnIvUmtISjVUVk9nUUttVkxORmNWWUczQ0lhVTNh?=
 =?utf-8?B?dk8ydnJsTXgwdXZiUnJtaXdIeTJxckVoU0lJSHUvUUlOU3llb3FUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab6c60c-bd9c-438e-d82d-08da10c2d87d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:57:06.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL+mdPUHItvSbwP3gNgSBolyl/H/FVLtsQPTt081tx21WKlm04sCd3WMaWn0X6a+Sl7ZEmf9o1/CVGx2kx52vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/28/2022 8:55 AM, Borislav Petkov wrote:
> On Mon, Mar 28, 2022 at 08:41:30AM -0500, Carlos Bilbao wrote:
>> This patchset includes grading of new types of machine errors on AMD's MCE
>> grading logic mce_severity_amd(), which helps the MCE handler determine
>> what actions to take. If the error is graded as a PANIC, the EDAC driver
>> will not decode; so we also include new error messages to describe the MCE
>> and help debugging critical errors.
>>
>> Carlos Bilbao (2):
>>   x86/mce: Extend AMD severity grading function with new types of errors
>>   x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
>>  
>>  arch/x86/include/asm/mce.h         |   6 +
>>  arch/x86/kernel/cpu/mce/severity.c | 203 ++++++++++++++++++++++++-----
>>  2 files changed, 174 insertions(+), 35 deletions(-)
> 
> How is this submission different from
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20220311165114.482074-1-carlos.bilbao%40amd.com&amp;data=04%7C01%7Ccarlos.bilbao%40amd.com%7C7355a7de9b224557d6cf08da10c29e56%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637840725342715892%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=A809HxzZHYiZQ6Arlje0o9KAFt4c77I2Q4vOfCl9%2Fis%3D&amp;reserved=0
> 
> ?

Just fixed a typo in the first patch -I should have included a change log.

Thanks,
Carlos

> 
