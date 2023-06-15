Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C103731E9C
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjFORC2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjFORC0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 13:02:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEB123;
        Thu, 15 Jun 2023 10:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoX/P7QMvM5qBsa0RqNprGhgZNQb47qD676DU8XOMlMlOEaCuWoUMXoaQ1pvIwoOmMEBpQy8uzpaB5YR9GW/flmbk7zznvN7iIMc0cO24/sfrYGFEZcguU72H/2MrvKZ/EuYD+R6ldsbtfKjvLA/6973lRkIgrCLdIUBN2XJ7W3JHT18xYbcpXZnYQxljCg6EVEp93w2tZYfAvn0F4FfmvRQh7Rcg0jDOlplNsiqyMADUGiGTaOrvdVohkjsBybfipjRqQsKLa+LeL6ZswGSnNwVuJ+nlT+8ejNVwf3SpylHa84N0HpUwhyDvXEhkBpNLC++jC7IdxCuPLC5pn4oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MycOwq+1VtjMiv710xsDaz3AwkIkPqcKdodoLWuK/f8=;
 b=RrCwzewj8KK9swGO3uhGLfLKJJc/nu6x3Taavb0kCxZE+uqKRjLEmiEZKCE4K/9UQNfYi9LAgAHAgS2FJ6LLrzGYUZlY+Sww8adcRKQkuaoUxf3exMD4AFb5GtOe011esZbh4k10dL4LucGJd+6KDBPydIrNVataWhk5SANNq6fS8XM0d5pHiBt2hXqCm9xDaaWQAjNdj348YSr39/kNiV7VArEi4+3q83QqTll/mDw2PDelCuIStwwKHKy8yOtp27rl9EBvoY7fbTJLDMxKpIinBzctOvHjUVWeaQWFOObZ/XeeBWTGa+vORyNAYUbZvh4emIYkQQpF0uU9x355cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MycOwq+1VtjMiv710xsDaz3AwkIkPqcKdodoLWuK/f8=;
 b=M711QCZ4+rURIZ9MmSvQ70K73SNx4Y9ymBYhOARZ3PbIxfBRG4GjNqGzy6J7iN2/+i1Ip1Rv8hO/IsqeYDJBWjfAc2mSdqwzobKDByO304eJX9uliyRY56K0sQDH7Y5V4xK9acDhUKIoCoKRsdw6UHbGzUMU2gyvM9kxwO1gpz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 17:02:22 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Thu, 15 Jun 2023
 17:02:22 +0000
Message-ID: <d1333fa6-34e1-8b2a-b772-369776428eae@amd.com>
Date:   Thu, 15 Jun 2023 13:02:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
To:     Borislav Petkov <bp@alien8.de>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
 <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
 <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0614.namprd03.prod.outlook.com
 (2603:10b6:408:106::19) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: f44f1b92-9cc4-4ca7-4429-08db6dc248f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHZX9euJS8FkTgRyl7oeaiBBch64oXS2nUkVLkFH8mXHnMx4zp6NsgFJe0lwrC6LtZ8AhXykLcE9U9JpzEKAhknTinWU8cQBfhky0jrELMrx8tnhS6DanxXxyy4GiIkaHG24Pttg86OzLMfXXU87XStyKuVCs7fzmMiFCCQC5IvCG+CEuLtBV3/jNwHpqwy8lvFFQj9zH3g+ZGzomwtcFETsL9S6MMJRTyC8WoBRxUhp6FwsdrogpXI3saBj4Yd0p+stiN6SqgLDXfg0CofD2R6tm8e4R3pT7iMhqZtc4upg4J8wGSGgdOwwJRmADz1PV7/GWWaPGBOdWu4gIobnTAaKJitSsiaLmcZjNL5I5gxdV49rNAFo/Ofg91pBZRsuFWDAA7i3R5EgS5MxrGFwbj1Rtngy+ANyu+1xazJSkrDhT0Jip/5ugvv1NGMxVJfpEILY20J5D+HhdjL+nPnxNWZFeeV4zKi9rMv2+J4TsbtVm+oajC4JZlGbqJA0O96Pjbjlbz5vf7eki7eMcRLKEvS4w2CYK1/zHxAIKBx2p1eRslD+hckO5zB55cjMyh1WINqLhwwCO7gTfs9u0UBil46s3t43MfwoIIeC+naK7OwHH8P7c1h8lK2vu7FCe/4c0t6ocW6VNXau0K1Mb+WXmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(5660300002)(186003)(6506007)(44832011)(2906002)(31686004)(4744005)(2616005)(6512007)(41300700001)(8936002)(26005)(8676002)(6486002)(31696002)(316002)(53546011)(6666004)(36756003)(478600001)(66556008)(4326008)(86362001)(66946007)(66476007)(38100700002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGV3SU5yV2xUTW50ekxMYjBzRnFNT0ZqWE1MK2pUakVyS3NueDNxU0FUL2NW?=
 =?utf-8?B?YWU3cFRSREdZNzdoWjhFNFdMYVVOWWE4TlNadjhndm1DQk9OZzVITVczVjdM?=
 =?utf-8?B?WW95anhtUUs2TnRZRm5nbUp4MHRLWEd0SWRheDZOSWpIUTJkV3IvbVFVeGZi?=
 =?utf-8?B?WjhBN2VrcEx0L2t2LzgzYXVSQk9YeUowYXdHTG9mNnErTDJvNWw3bzVCMUpK?=
 =?utf-8?B?WlRwcFY5bzhLOUxRV0FqL0pqUy9zQmRDNnRvUnc5QmkvQkowOTBjZXk2U3hw?=
 =?utf-8?B?QzdrNlNGdytxN0JFa1BURkJoYUNlVElIaGNQWlNhVXZ2ZkRHTnYxdkY4K2lP?=
 =?utf-8?B?RFNGNGpudmFST3VNRTNGSGdFTDhJbW9QUzI4TW5TSFpmWmRYN1FzVEZyRmJK?=
 =?utf-8?B?WWZ3ekZUMVZrNWVjT1VtMzBqSWJBUXprNmw2ZUhQNURGbVQzbDZHSFZMbTNk?=
 =?utf-8?B?b3ZWYUVaYTF4cFlzYXNmdkpoYnZ3aDA0dnh2NWQrMHV0bmxtK2hDTEhuVUlT?=
 =?utf-8?B?MStpSUcvckJhVEZqWHpJZWFvLzlhK001eEw3NmdIUVJ0TEhaWFUyS09mYjdJ?=
 =?utf-8?B?YlYwenhLck5rTSswM3A3TWVEYWNZeUVBYWFsakVaKzAybjkwVUVPU1BhcUFs?=
 =?utf-8?B?bU1lb2Zab3RuVkNwcFhyTk1zUkxNVWZzejhiU3BCSDk5cEdnOC9VV2IySnFD?=
 =?utf-8?B?cUN4TFdQK2x2a2hYK21Ka1Rjd1FPRHhLZWpnSnh5eWVmNEZJS1Zqd0kvUEVD?=
 =?utf-8?B?Wm9MT25zczRHNTdBQ2tmOXRkTklJUTQ5R1ozNGlhQnFGZE9EakNXVlo1cThm?=
 =?utf-8?B?V09XRWl2b2pESTUvcU1sNVRHWFp0S3JUTHZ0N21xZkxDcDE0YUwxWVZrSk9Z?=
 =?utf-8?B?ZFBEV0NnSG0rVlJ0VG9lNDJPUkRFbXY5R3krcW5jNHBDYllNSXI5SHliRDF2?=
 =?utf-8?B?WEoxc000QnU1S0JTd1AyNmYzejVEamtNVXhneVQ0VDRxN3piRHdtNmFYZ1VU?=
 =?utf-8?B?KzZvZ2dGbXVvcTJCM014VElFQVI4ZlpmbC9BTUhMZkNxamZsaHoxTlJ2SElD?=
 =?utf-8?B?cnhPZTdiRmxEazV6UzJCeXVweXJtUlhvbWtKcHU1VGZhVzFsSVdXSnBEQ2Uv?=
 =?utf-8?B?ZlJmT3RNUWh4ZHgzckFvQm80S2hGaCtEc3ZGQUg1cndobG01ajA2ODZPa2du?=
 =?utf-8?B?amZ2SzduSy8yNUhlL2NhWHkzQWN0U2YyaHdhRDFHTGk5M3pqeUZINDFKd2RL?=
 =?utf-8?B?LytyUFRPT3BwQklteE9jUG84TVpSL1g4U3FLZHBLR2VXLzRUbmROMmVmeXN5?=
 =?utf-8?B?MDRsckVKMDgyZTFENXBIeHBBR3VFTW93TGYvaW95Y3pEWTNZaWNCWmpyZzU3?=
 =?utf-8?B?Sng4dVZQOTkrOVYwaGxheGZtRTIvVFI2TloxblV2VnhiQ25wZnVHNS9TcXI5?=
 =?utf-8?B?TVpOWEEyd1FrRFJOSXE5TmIyZzJNa01oWjZyWFNBakxiSjUrd1pJUDEyb2Jh?=
 =?utf-8?B?OENZNkNBK0NmWXBxQ1JLelpwMm5ORDROVW1xbzlRVmZDMUVIdUxRTXhNZGp5?=
 =?utf-8?B?WHl2QXVqR3ZaSkFHZ1pQdk15c0I0WjVvakQzY3RSc2pMY0hVZEZoZVd5eXpN?=
 =?utf-8?B?d2pMN0Vqd2NUVXF2azhDVHVBY1FqRzJZUmwzK3hCN25Cb3p5YWxzemEvUEgz?=
 =?utf-8?B?cWVqN2xNZ2d2Z1c4RFFiSFNqcUNzd2NwVlAvUUo1eEFuUzhwWUJJSjU1ZHRP?=
 =?utf-8?B?Rlh2ellseGk0T1FPSWpDdjNZUU9za2UrQmJUSUhuOHZtU0g4ZzlUK2VQankw?=
 =?utf-8?B?Skx5SkE3UWtFczk5UHFkaDNkUUdvUjdKVWErWkNGT3dvTC9KQnZsbGZ2eXFo?=
 =?utf-8?B?YUFGZWk5bGdpUExucWJQYjFZWkhETFdaZ042alpIbGxYQ1VuRnVLWUU3TnJW?=
 =?utf-8?B?TUkvcEhMdzVDM1A4R0FLWEd5S0E2RHpzNmwwRnVMY2RndnVsZHJlWjhVVXcw?=
 =?utf-8?B?QTZxb3dVMndSSzZQdzV2MmZaZURQUms5WTZlTVRxajhhVzFnVXkyWDllb0NJ?=
 =?utf-8?B?VElENDJTYzR0ektRNy9Md3RUL3BxNXQzMkFxS0lDV1psbWk5Um5iQzFSSGQr?=
 =?utf-8?Q?P0pFL33rn2yXB7Y4jprOag6vL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44f1b92-9cc4-4ca7-4429-08db6dc248f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:02:22.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8n6JjXoHt/w/B0KyCdg2Vet+RPp8X8J3NFeSv1KDGmM3/qd7V3yCIi0ASMP2dgH2YBK0ujGLGggMEmX0FC0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/2023 12:20 PM, Borislav Petkov wrote:
> On Thu, Jun 15, 2023 at 11:34:21AM -0400, Yazen Ghannam wrote:
>> We can solve the NMI issue if it ever comes up in the future. Unless there's
>> an obvious change to avoid this now. Any suggestions?
> 
> Yes, solve it right from the get-go. "It cannot happen now" is not good
> enough. It should not be even technically possible.
>

Okay, understood.

> Just report what's logged into BERT - nothing more. Whoever needs the
> remaining info, can dump it from the machine.
> 

Will do.

Thanks,
Yazen

