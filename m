Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F76729F7F
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbjFIQBE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbjFIQBC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 12:01:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD435A2
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 09:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9x7DRMxfWmLDHMOHssCAufdx6Dil2mRuMw+jPc8++MB3vFAAw8++8SvNZSOlIQ7wrmOj16ljP3Ki1zJnzairoony+Yy1qy8UQC0LQoZcoe2yABzmZaPZXernAdfjIBryXUR42/SBRgxr4BjHIOs/mUYqtFEE+eWAgMDsy+Lm3+kgFDFz0+6om8g/3MvJ43TMk9s8KFupLpMzJXtXvSlXtFFogqbC3IGJuTTX/DYWykipwPpTgK7nb/5N+qqoZ8ZaEdZOEQ7AH1SQxN4nn/uCVY2pwify8HUToIsR6aJrdwgIfUzDkFVN2+yyRXJPyvXN415kX97oj0qoEwog9sjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+DMYk8xsdVXibptTOW+LmfXhSTnIdP/8qUTef9+xJI=;
 b=el1TTUa0wcbEr3V/lXyJkF6XgETuGJPl3FTDv9THxP/eXVCzptw2+6LutwSmRRdgMQHW7wNLl/v8PW8kP/qtvv8Fyjdb4W/D4pXzbhVjBh/TizW2OzK5eevtWN3i162EEx2Smv0Cbj1g5moreYpdWCy7lrDxf0iiSlaE8JvQC+0BODs8gkwkXq7gVDbHBNRkWKiY5z9KGaHbbXkKtO5NyhlSSIWi2Z1YGp3vqFZ7I1C3UHIxkElVp+pzGIDboI5fTG8CX2w5sqlTUfiSiD9gIQTzLA+i+wspVfymjq37NpXWalvhrVMaPSuXsRaz18jZ/njZeJM0O3rDnFYv/XbiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+DMYk8xsdVXibptTOW+LmfXhSTnIdP/8qUTef9+xJI=;
 b=huDFpKnVH9AkZEdKc9/k8V7dBQZI/Ple/ggtkbhrNrZpmCL4IkvWIi97fbTwOS21v6kaK4IrdCm6/9B7+XZxDNUBUqLUcSvoPBd+kGUoTyqAALwzlQWsAtSBKrBiFoQQpulJT+D2by40VTg5RyXM4fdaAZ3fLCYKYHMs/AegjEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 16:00:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb%3]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 16:00:56 +0000
Message-ID: <facb48e2-73a0-e780-4fda-2ecbdfd3b48b@amd.com>
Date:   Fri, 9 Jun 2023 12:00:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
 <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
 <SJ1PR11MB6083807C3144C28B3E30840DFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230609101757.GAZIL8VaLwAckejYZt@fat_crate.local>
 <f84cc078-6cd9-f011-3c9b-8ade98c814f3@amd.com>
 <SJ1PR11MB60831A82C6BACEBCCC50E397FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB60831A82C6BACEBCCC50E397FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:408:e5::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 482050ad-ccd2-49e3-240b-08db6902b596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNl1afJyqA68NISKpNHjoAi2NeNzrb5DezpwfqUZiigSxbGg1F/F+IBGEIARIDJo6fblzjq6Qd+Db8iWypX8DzecYDdDC9RtIWoxupm9ZEAIlSrbLkZq6qH6OY/K9ouNrTgK39Rj2staQ5lRR3U8Ke5GL+xdr398LJqdR1i5ac6wNNSy+hzxzNVD+M3ntsPgA/DpIRBZegQdxoybse7dEDHkOPJB9btO+O1kt9VCifLhS6H5sqny8eWHl5SxMvK5R4x3weReB29+eQlSpumYWGUDSOLef1Lq9TwOS/oMvm5ZM3TMoDWLBjHCoNDt2XSL87t76iWOOPunzTm9vN2n88JmzrQUJpLBw02QyuCkkvRLXW1mMqDB8wtU1bCtW1K5uap4AUsECeh3fkGTuekBS4qQHtL30Qbv7u0UafoNN7UAGLZ/Pn2drfqNk053LxYRjde0Ep1N3Cd3/ScoODkUJ0svUWLGzRDPrzqtqp5jGCeH9Dy8uVP0yP4X0NYT/KyIzYSZh/lRMQ2jG8UeK5eEMGdIUmIrDp6dsg7qG/e3CMxosVRxW15cvixuSPcC8T6lKp7Xy2jNK0DsPXeb2X20AR58BNN+zizdqcTLPzgRD3lELDajbw1lYSnW6VFsfySNuGYd030D047wjk1ZXDrv1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(110136005)(54906003)(478600001)(66476007)(44832011)(8936002)(8676002)(66556008)(36756003)(31696002)(2906002)(5660300002)(86362001)(4326008)(66946007)(316002)(38100700002)(6506007)(41300700001)(2616005)(6512007)(53546011)(26005)(186003)(83380400001)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXVJOTVOKysxZEU5SDhyNHNXSXFteXNyS3pXcjNiQkI5cDFNeTRwU1dkWlpC?=
 =?utf-8?B?MHptQ2NxNEo0OXd1NmQ3dkE2MzJ6OUNCVmNLL25zSkNwTXZLTXFrY3A2WjB6?=
 =?utf-8?B?TlFuVEp2UytkU0FVUTR4Tnl4NDRwSW8ybGpHQTJsbHhQd012MllHUjRySXU2?=
 =?utf-8?B?YVd5YmYwQVdTd3VwZ0RWbGhYam1tSzJ0L3l1MzJ2Rkc1NzROWTFONExtVWkv?=
 =?utf-8?B?eGRKS1FuSDZvR3Vnb0h6Y0EyeDVsUWtkM21BTCtYMFIzTi83eWxBTXdHRmpp?=
 =?utf-8?B?RmMweUp5bkZLajRqcVdlUTVuSmt1S0RvM0ZQV1JoQ2NxQ0JYeFlHN2MwNFlC?=
 =?utf-8?B?UzFEVWJmMTZzWFNub0lQWTJxSWtTSWUvanJiWUMrbjNwdnR4T1Nqc3k0SkZZ?=
 =?utf-8?B?YTQ3VGt1WnRoOXd1ZVRXL091L3dqak9PKzhrM0lzSDhqK0s0SHh5V2lHK3gy?=
 =?utf-8?B?dGtoMkNpY29RZ0RKRytFSFF3eDFUOE0yZDVwTFJWZngycjhwVU1pVEpFS3Jq?=
 =?utf-8?B?WUpJL3gxUFRoTjhMbE84c2hYUGd2Mi9OTURBUGZsMjcrSlcvWngzeW0xNGg5?=
 =?utf-8?B?anFhQ2JFUFJ3RFprY2pudkRMVkZyRkVxczRzWmpKUnRzT3VKWVFRbnVTVlRm?=
 =?utf-8?B?Skl6Y0lCMVRGWFB1K1hWRlVqWXBLY25XZWlvWmpteUMrS0NzUDhCbEcwancz?=
 =?utf-8?B?YUVIdWhwdVozMytpN0Yva0VQMlF3YmI0WXRxd3krYzV5Z0RiSTFjKzNaTW5N?=
 =?utf-8?B?a2hQMEFpalo3V2RCek45MWxuc0ZLK0dZQkR5bnZnK2ZtVUpGRDUxMU1JQjk3?=
 =?utf-8?B?bVBta0xib3QrV0JTWk9mSVdTZTN2V3pxTWpaMURremRxamVXbitJZHZYS2Ny?=
 =?utf-8?B?Sk9LV0R1V3R5Rm0yM2pselhDVm5PU2FUUzdHWXFIT1NLbnhha3hMTjhETFVv?=
 =?utf-8?B?cmxHd3FCTVZXOTc3dGt5ckVNdzJGWlh0MnJOUHZVZGRjOXd5bU1jZjU5L3dM?=
 =?utf-8?B?WmN0N3ZuVFVtWkFwT2o1RThRSjQvQUdzQ3ZQSFdRR1BhOTdDQ0tEUmtmTDRK?=
 =?utf-8?B?WUF3NzhsWXRGNC9tT25mR01iQzhRVkdYbnNoVTQ1d3RwenJVM0RBMjVLeWdV?=
 =?utf-8?B?NWY2V3k4TVJSZ2gxc0VlNEE2Uk9SYzIwTkhiWUQ0Y1ZLUUxkaUlzdTlCS0xB?=
 =?utf-8?B?R2xQQU1ldTVZUFhIYkZ3RnFhekp2bUdOWUNSYWpQWElHeFB1WEVRKy9yZzQ0?=
 =?utf-8?B?bU91WlBYRE5mUEh6cWRnMUQwZDNOc3pzT0syWjRoaThpL3RORC94c3RzYUhN?=
 =?utf-8?B?K1Y4ZnIwdjJjNzVLOGJFZ3BPZUVTc0RuelhSVC93WUhzb2hFMTFqbWZialVT?=
 =?utf-8?B?SE42eUptY2VleHlFQVd5cE5ydk9hSHBjWDJpbTZsVkFaWWNTWElPd2E4L0Js?=
 =?utf-8?B?U1pzZnl3bTFxblA1dTFjY0h6NFhCb2Q1bllhS1M3SmV0MVk4NFB1eHlQemRp?=
 =?utf-8?B?ZDRzVHI3UXNsSHFEZTY0Nnc3c0VvWkdkYVN0WlQvbnRCaDhHanZJL1pzUE5s?=
 =?utf-8?B?THlCUWxUdnh3QitnbWttSmwrczE2R0FWU3kwNHlsdUFlUHg5emttNXVwc0hF?=
 =?utf-8?B?VmRXSWhpV2JzRmNNeUhqTGowcS9iOElOTk9uM1BvdzliQlZSU25hSnZ1WU9N?=
 =?utf-8?B?NnZ0eit2Z1E2WkFDZ1N6RjFmTWpTakdwRjQvMGxmNXhkL0pzbGhFWTk1S1Jn?=
 =?utf-8?B?U0dpNS9EeHBrc1A5eWJLUEJxYjlZaUpZYlRmVzd6emMzSEJWTCtwckVkMWV5?=
 =?utf-8?B?Q3VURnhZVDc5NWZybkpTS2FlaE0vU0xnYWhiQVVMTEdobDl2ZjBiTWFEYWRi?=
 =?utf-8?B?TmxTaG14VmQzNlA2ZjVKdzg1dzlXd0VsUHNRdU01cG91RzRpZG5DK202Rzl2?=
 =?utf-8?B?d251WlJaaGlFQVpmcG1YM2NBMDVTNEcyNzV2WWk5Y3NDaWhBQVMvZmVtMEJt?=
 =?utf-8?B?L3BDMnFDZlR2cm1nNXZ4c1RWak9zNmNXa0U5a1lGUURKdUp6RXdxdlZ4MWkx?=
 =?utf-8?B?NzhwNTkxUmZ0TWw3V2JXNjRrT0ZxblYwb2ltMkZ0eXhQOFhXVXZRVEZrN3Mr?=
 =?utf-8?Q?fHmPYJ1OqgQiZylaxeEp7l2LR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482050ad-ccd2-49e3-240b-08db6902b596
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:00:56.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogZQD1yeMZ9G6Eu1Zr+8xTZ2c4QzOY6NWiOfmgzBh+HvYjFJyUTks3VYNMCeLn4zmcVwx59SoMr0480mFz3R0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

On 6/9/23 11:24 AM, Luck, Tony wrote:
>> So "UCNA" is like the AMD "Deferred" severity it seems. How is this
>> different from "Action Optional"? I've been equating DFR and AO.
>

Thanks Tony.

> Categories of uncorrected errors memory errors on Intel
> 
> 1) "UCNA" ... these are logged by memory controllers when ECC says that a memory read cannot
> supply correct data. If CMCI is enabled, signaled with CMCI. Note that these will occur on prefetch
> or speculative reads as well as "regular" reads. The data might never be consumed.
>

Yes, this is like AMD.

Key differences:
	* Logged using "Deferred" severity. However, deferred errors
	  aren't always from the memory controller. So there still needs
	  to be an error code check in addition to severity.
	* Signalled with a Deferred error APIC interrupt. This way UC
	  errors can be signalled independently of CEs.

> 2) "SRAO". This is now legacy. Pre-Icelake systems log these for uncorrected errors found by
> the patrol scrubber, and for evictions of poison from L3 cache (if that poison was due to an ECC
> failure in the cache itself, not for poison created elsewhere and currently resident in the cache).
> Signaled with a broadcast machine check. Icelake and newer systems use UCNA for these.
>

Yes, this mostly fails within the Deferred/UCNA case for AMD also.

> 3) "SRAR". Attempt to consume poison (either data read or instruction fetch). Signaled with
> machine check. Pre-Skylake this was broadcast. Skylake and newer have an opt-in mechanism
> to request #MC delivery to just the logical CPU trying to consume (Linux always opts-in).
> 
> 
> UCNA = Uncorrected No Action required. But Linux does take action to try to offline the page.
>

That's right. So we'll use this for the Deferred memory error case. But
there will need to be updates for these to be actionable on AMD systems.

> SRAO = Software Recoverable Action Optional. As with UCNA Linux tries to offline the page.
>

Okay, so ignore these going forward.

> SRAR = Software Recoverable Action Required. Linux will replace a clean page with a new copy
> if it can (think read-only text pages mapped from ELF executable). If not it sends SIGBUS to the
> application. Some SRAR in the kernel are recoverable ... see the copy_mc*() functions.
>

Yep, this mostly works. There's still an AMD IF Unit quirk that needs to
be handled. And the kernel recovery cases needs to be tested.

Thanks again!

-Yazen
