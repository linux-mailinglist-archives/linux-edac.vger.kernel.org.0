Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78434D51D3
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 20:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiCJSZS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbiCJSZR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 13:25:17 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8A615E;
        Thu, 10 Mar 2022 10:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRjoTbepPy7iy0eCtO9ah1iNtaMe8StedSBR5J2Xljp7Y3GYAB80Ax6h1MsLNh9cAeOVbt+Yh3lEmLavg/vuvhliwfrAa1XEPWmk6jY8FUR8CEgjYBMQzJIIucPAc0jWa5BmjwcgETT1Jzp4+UEXTM6mdJSL77Wg0fPtsrc4al7jiLMmIDohCQlW2+0lepNNhcDWcFJ7BmOTWYTwGRa1xCGzTCLkJT+Pz04JJsqpLlsry945LQ1xhVsaXGGCMwV8k0CH4P5WO3VwMiEjozYi65xpY+V6OP3vBbfa/NBCFWDY2Bywcx5Ps2gW57xtb63ctv7EqmaDe3//xTKV6FHgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJKkJ9qHZMpNx3e7wNIQRu2nWtssvgmX31byrMdYDr0=;
 b=Pda1s0DB//p4xulpWk/P2RY69KiQgqv8pC+w3A1EhxDO/A8LklNkEt2sKejBx98ENdeaQUTjTF1mJsT2f4RSOGVYj4t1Bjc3dyehKYZnxFW6DNtimMHnqUmMXcrE7T3HKj09h+rqOow1wWMAlSF0vXHNv4OOiR5/D3cKHUU9HiM6dL+qKUEsoVu34vDAtsf+9YB+tyb2gzzsOxGMM1hIXfJcBog3pK0EXvUMCeRgKLfF/ZidSNbLfiCGREm4hTWyDvxO/6DHzVo74W9FO88JbZxxXAL/twvznd93cPD7CZNAPITL7ii6O8aDwkl2r7imXI0iRE46SRn4jP7AnoLDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJKkJ9qHZMpNx3e7wNIQRu2nWtssvgmX31byrMdYDr0=;
 b=eXuXdC1SFjXZtL8OOLYqnMJYgHpxhWi3cJXAopt7pMFoS5OGUCut68kKRt0q/OPDUrIeZ0ESU5HT1qPHfKCHO+cXzz0uUaMY6fEaju3YTgh4ZeI13Rxm5GKxM7Us2mF+5DaWMzwpbJH6MwSDNV1hNAExfqitY8aj3Ad4w3j/xQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN8PR12MB3169.namprd12.prod.outlook.com (2603:10b6:408:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 18:24:13 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8940:cfde:90ac:b008]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8940:cfde:90ac:b008%6]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 18:24:11 +0000
Message-ID: <4a345de2-6a2c-fe26-c55c-34ce6ea431d4@amd.com>
Date:   Thu, 10 Mar 2022 12:24:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] x86/mce: Cover grading of AMD machine error checks
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220309174107.6113-1-carlos.bilbao@amd.com>
 <Yijz7dA1U0AMcYPZ@zn.tnic>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Yijz7dA1U0AMcYPZ@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:610:58::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc75723d-3117-481d-8f2b-08da02c32c3f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3169:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3169794A6D5623D2277E51EBF80B9@BN8PR12MB3169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8VV2DOEiD2X9zcNsREJBOP3Q5bN8Jsjo2mo/1e81efkWDJtYGC354THt6DUgkV0UZqBFoFaN6CU1UKeUE1uqatyYVUgZIwdiCxjIxGRhA9eMhLyJF2/2murmugOxrqxoLj+h2G98vluFCLoIACeUi9NGbRx0ZIxNlokGsah3mWwDWRs1fVJADPzt6DxWRG1Fd6LR5v4wZiWYij7ep/3vHpFUtL9FXdfmUBlUTQFRst6emOA8SR6caYV8lKp+I8mb9YzhDk0/ZFtxbYuKhtNtKjfBgM3dR5p09O7/m519LscoDglPOjLiZ6+WrcuT82qionuXFeYD0wphnGdTMVNr8z1iAlUvw/VkAIyThFYehTdGioId7mpLhcqe6dd6h65eTIGSwEmciyAB94NKtUf7A8vPgDPDTYC0NeIxhdcq8kJlF66k3ctAfRQPq8QH7S7O1CgyK3EXPuDXaP7L2Y9W9ekw9Lz/J9zPwDTw2qEij90pG/1Sni0Y8vD4feFsQWTgKOSkDGcU7RhAKPq+JwdDn02s/CWVba7cazzlavGti7tV3tB5hZSiDtYUllPIxhMX4vEnqsVk3VyHVpsG+RQ73Q8wOSeALXvuxn+rH/Tlq01AaoUZO5PjxXEaG+uLtVOShe2IH7HfOSulHJZn8dhbKmrDgdk6VyFV7VObdX4uEaz56N9yr+GB1CZMtSANw3DM3S6obAUzF39M8CjrVfzo21zsX8bnNvwcEi9YsnK1gA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(186003)(26005)(5660300002)(53546011)(66476007)(66556008)(4326008)(8676002)(38100700002)(8936002)(31696002)(66946007)(2616005)(44832011)(31686004)(2906002)(36756003)(6916009)(508600001)(6512007)(316002)(83380400001)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y28zMFVHdE45eUc5ODQzNm02VzBVNXNlN0ljZERXeWdNNHFZZ1pxL2luMWJ4?=
 =?utf-8?B?OHRjTzA1YzRvNXB6UVdKRWlSUWJXQ2laVEl1T204eUV5Mi8rVHV6eVRNY2Fo?=
 =?utf-8?B?TkpsSXdQdTBMNUJvOW8wM3hoQ2NMVU5tS3d0dStMV1dXb2tiR3RTTzRQM2Uz?=
 =?utf-8?B?TkVNcy9uaXRCenVHWXBySmEycGltTFZraDJQWmY3S0x3dUd6Z1ZtV2prRDNm?=
 =?utf-8?B?ZGVDNzJobytpeVZoeWNBZ3hxY1pMVi9Cb0x4V2g2Y2p3d1AvbmRWdjVIeFVC?=
 =?utf-8?B?cE1jUVdCTzRnelVNMHdzSDBtbEJXditrL2NBY1lmcVlnWk4vc1ZnRysycGxC?=
 =?utf-8?B?bGtiZGt3K2hVdlFzRTV5emgwaFV0b2Zic3pUWjJ0K3dLWnlHWkF5VzBoZGpK?=
 =?utf-8?B?eW5FS0I4UnV4ay9WNGw1Q251MFEyZGxMekZrbzEzYitaaGFIUkZwUDZUQXRi?=
 =?utf-8?B?R05NaWJITldrRytjakM1a0k0aGFQbm5BWVNmb0hxNFRTaG5wTXU0RTFac3kw?=
 =?utf-8?B?cEhCV2wzT0FpMkFPcHBLZ2tXY0VHT29YNHptMk1JeTRmRDRhcnBLQ0VZM2xS?=
 =?utf-8?B?ejRKNXJoSWY4TTVWWnE5Z1A4dU9OYnpydGxXTkp4dVFJMXBmOWVDQWtSWGth?=
 =?utf-8?B?WkdueGFid1FuQ282bC93emlpeVdrVXZXUmNGRW9CbGp2dkZoWGMweUEwMFhT?=
 =?utf-8?B?bGp3RDJtck1ZN3BSMEZsaUpoZWdYZ0ZxdlFVbGdlNTk1cGdXSTZYcWZLenQ1?=
 =?utf-8?B?SVVFc05SWUp6QnloclU4OWpydGFZRUVIL29ja2tGTWo1T2EyS0VRM0FRNWQv?=
 =?utf-8?B?QW44QVBsVkhIVEhPSVErcnVqOXZaWXlDeWF4eGhnUnkxK2ZRdHNPaWphNjZD?=
 =?utf-8?B?bVo0ZlorN1FPNjlnSWtUK2kvU2Ewek5KWlU5dklqYnF0YUxhNXo3RWRTWERW?=
 =?utf-8?B?N2NsaWExampNSW55Y1ZWVCtXeUN6QnQxbzZtWnBud3lXVW9PMHVjMTI1anNt?=
 =?utf-8?B?ZXozMWxod0xEZ2U2WDJPa3p6VUl4Yy9QaG5rT3VWUnV5OXZmaGpsZCtKbklj?=
 =?utf-8?B?TXQva2hvbnRkSkhDV3ZPQU51YzhqcW5qZExXbWNXbGQ1K3Y2T3dhd3MzeVlW?=
 =?utf-8?B?bDNwK04yUVdDRndvbWg0ZmRTdUY0USsweU4xVXo5TEhuS1ZoVjVtZ1ZZTXVq?=
 =?utf-8?B?b1ZKR2hYanpObmZjWDZTbHMyQ0ZWbnMvdXR5WWlySTMwRHY1cm1neTFkZ2Z3?=
 =?utf-8?B?eG1GOVREVUEwd3k0MDUveHhXZERIN0I2OU5seHg4VGdZWHBiRmxETG1iMXJI?=
 =?utf-8?B?RVRjTFR6ZDJLTHRXWGZQS1ZERTlWRTFmdWpLTklOM1pSV3UwcWxoenQ3Wnp3?=
 =?utf-8?B?VHcwK3B5S0dCd3oxdk9TQ2d0VjhvZW14YTFVTWpta0FueFhtQnFlaXVoQ1JX?=
 =?utf-8?B?ZFA5UllWbXNBVTltU2FQZkJZWVRoSjhSNG5HSytRV05jOEh5UkVmTzJlTExQ?=
 =?utf-8?B?c3NDbHdqSHZXdUNyeDJlbGdsNjAxbVZ2V0xOZldGVXZTdmh2ZlRWV2xTand6?=
 =?utf-8?B?SHZFdUlxWEhGWnJhS2dsUkJ2dkJUUEJTQjJQcHZTT3F3UFVzRnR4Z0VnSnNP?=
 =?utf-8?B?dEpWL0tBWG1xa2dzYUdjUUVNTERxSXlnWmgwcHFoUHcvWUg5VUJQWEpYVS9k?=
 =?utf-8?B?QVhrcTNYdUI4S2tKQ0M0TVVpWDFyRE52OG5EOXFMajg1d0l4V1crVG5wdmMv?=
 =?utf-8?B?Sml4ZGd1YkswMmd4WjBrQlZMUzlNbWpUWXlSRk5odUdvT21Wa1ArbXVDUzRU?=
 =?utf-8?B?dHdMeTFCaWxwMmR3b3ZlejFHTTJjUzgrRmRHZm9jcTdVZTdEclpyTHRZaUJL?=
 =?utf-8?B?WUJRamY4REJLeGY4RTlkYWtzUVdPK3JhNW1BL1N2a1preW5VNTFYQXpERnZt?=
 =?utf-8?B?YkUxQWlJcUVXSTBpVHF1V3RBU3NDdVVUYUdabTR1dHlzQmdRN0VqaWdHLzIv?=
 =?utf-8?B?djFneGdGclptaEZwRDZZOEM0ckN4ekRqbElVOFM4enhFNGVjQ3N3SDJJYzVZ?=
 =?utf-8?B?RU1VSWtXbGlpUFRKZXRLVWlIbUZkeXRmbjFlS3YzanNQRkRwU2NCZ3JsR1p4?=
 =?utf-8?B?VkcrbnZEbGFMRzMyMnVvaHJCRk1zK0ZrTldHTE5oNzV0MjU2Rk9oY3VEalYw?=
 =?utf-8?Q?jgm6ibj7eggRCOx03JxCZ84=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc75723d-3117-481d-8f2b-08da02c32c3f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:24:11.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3OILAjF4LVUoSf33Rh2zZJwbzrbjRSEmK627H8bAM7UgFfLUNivDx9jnSRYV7JE5x9cXkp8ayPYH28m7jYuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/9/2022 12:37 PM, Borislav Petkov wrote:
> Definitely a step in the right direction.
>
> Now...
>
> On Wed, Mar 09, 2022 at 11:41:07AM -0600, Carlos Bilbao wrote:
>> AMD's severity grading covers very few machine errors. In the graded cases
>> there are no user-readable messages, complicating debugging of critical
>> hardware errors.
>
> That's too generic. What is the actual use case here you're spending all
> this time for?
>

We will cover grading of MCEs like deferred memory scrub errors, attempts 
to access poisonous data, etc. I could list all new covered cases in the 
commit message if you think that'd be positive.

>> Fix the above issues extending the current grading logic for AMD with cases
>> not previously considered and their corresponding messages.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  arch/x86/include/asm/mce.h         |   6 +
>>  arch/x86/kernel/cpu/mce/severity.c | 232 +++++++++++++++++++++++++----
>>  2 files changed, 205 insertions(+), 33 deletions(-)
>
> Now, looking at the whole thing, AFAICT all you're interested in is
> getting some strings out from those error types. But but, we already
> have something like that. That's even mentioned in the patch:
>
>> +	 * Default return values. The poll handler catches these and passes
>> +	 * responsibility of decoding them to EDAC
>
> So there's a big fat module mce_amd.c which does convert MCEs to
> strings. So why can't that be used and extended instead of adding more
> strings to more places in the kernel?
>
> Thx.
>

The severity grading logic has a double functionality: (1) Grade the 
machine errors and (2) Assign them a severity message. The first task is
arguably more important because depending on the severity we assign, the
MCE handler do_machine_check() will do things differently. 

The part of this patch that grades new errors is needed for (1). But -as 
you mention- why do we need these new strings if we have the EDAC driver?

If we grade the error as a PANIC, the handler will not notify EDAC, and the
kernel will use our new severity messages when displaying the error with
mce_panic().

If the machine error is not graded as PANIC, the notification chain will
come into play, and EDAC will eventually decode the machine errors without 
using the severity message. Hence, you have a good point, these new strings
will be unnecessary -We should send a new version of the patch that only 
includes msgs for PANIC cases. We probably won't need helper functions by
then. I'll also take some time to think of any other error cases we might
not be covering yet.

Hope that helps clarify,
Carlos

