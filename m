Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6050A8D0
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391811AbiDUTNQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 15:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391814AbiDUTND (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 15:13:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500DBC81;
        Thu, 21 Apr 2022 12:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAwtYEAko/qI2RvxF52twdp9vUcTCOHzRN8NQGJa+47Zv2ecgETeMh3bAoUpI8lLwJ3DTHE58idu1S4U0QRus+0iZL3XKvkCeRAkRzKhn4fzqlSB8knCwPflho4Ya+nESep233ZEmkjAkvZ3djtSFanjxNOWwmn8aB5me9v4wTGmBh6dsXJbVy4Q8hqlZIItY/0/izZbdJGQE3iF+8C7Flnncr4+HMpvZCo/DHSg3vepsMf6cBtYDuUvlvXsL6UJDjSCoI3/zh5u3/Cwy1/j6hWfxXBIOFZa3BSpmn4irhznd94jhO8IMWioFDm59x+k8doNdji078H1Lh4NzhhlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxiclIPNrWnzBCQ/t3ZsAyX7xSObTph6aATm7iQOmyU=;
 b=kU1dmEIH/LZCLe4FBFlcEiv6GqYRabOlYoTptLr2NtnrG6Yi/sbz+VycqDCdScd9jr4i7S877nA1KF2jj0qf7nnaFzf24hag4uCBSq9Az3blP6fPrUL0IUcnUXdp0Xcjh0zvQtxJtH9XdKPyfAEj3/EuAAY95iqrOmt8cR2vNaGQaAE2nCxSS5WECtJ2YBF+Bs0CFpStwMeCmsV6s4UCMglrk2Hrxl3Ius4VJL/Vyxo2xuNThRq+8ke/rF+EPryIoPR4BCTyHqwFSIYN1Rh3Xv1Q1gDmAPf3ffAgJHdy0JmKAVNBnTna909ez2QYX6M2p3AGIWIkkgSOqkEhbUxMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxiclIPNrWnzBCQ/t3ZsAyX7xSObTph6aATm7iQOmyU=;
 b=IbDGDyi1hV8EaQS06NRE6F4fkoUgbvVHUCaYQkr8Menrs2HCkoJV9t1Fz4H0MYoKsac+oSyKXKju9pxV5kKkGLNvFdWEVHUI907ciejk3spZV3H/l97aco7WiSTENshoYVEuuJi2xxoQePbmj2IZhf60yuQ5q/TP53P0gWtsxNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BN6PR12MB1588.namprd12.prod.outlook.com (2603:10b6:405:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 19:10:09 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4%7]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 19:10:09 +0000
Message-ID: <5512261e-085b-65fa-605b-38692769f89c@amd.com>
Date:   Thu, 21 Apr 2022 12:10:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic> <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
 <Yl/PupT3bAfc4IBW@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <Yl/PupT3bAfc4IBW@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7172998d-e79a-4e56-3f28-08da23ca8d5c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1588:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1588440C27061EE90B9141CD90F49@BN6PR12MB1588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMwjA3fLV/eYkn11P0nzO5SHpOrude+QEkSEXHmsMD/kqEKV3Uy7GmUdmBs8pj9pY+ocZQgcCA9d3D1qsWDR/fjv/SrXxeEtChdMFFX2OUHN47+HZVI2XUamzq3YnNO4EGi7zBTL85XKbPGt5iMoRZLHdTVzlZqFCAX+R+E0BVVF9Z+rvXgaw3GC2lV22fNZBwr4eqzt6cNQ6P3IhwrNXgIrQk6AsoY/CYHXWG/wrG+2OujiCmwc3x7Dw8xtQwD8jLmwzZV7G+OoMwqAYI9yAVKDJeR53pgHzErLrrEiVgmW2puDqks0/LnL1vfh369g50WZAihRbb3IvKQjQXIEFBx6sOXW9jUA8Kcmg7rDZEd5EZvGb8UhAjjmk/uAO/8yAPVXryuvdJwI/p0HqV+XRKfelV4e5YfzoeIQzZu3kLBvOw5EK+KrYQSLMCZBs0sJrPWB5z3zuBvzuzdRxh8FsEB+QICShYMsZRlX9PgdgxvnxnVsDZMxqgz2ZSTTggV0JkLIczx+PpjENFio5ZV5HksegMU9GLdr25LJrGrlPibzneQDC82jAEM7lxRCSflvB3IS5xwpDNg69MWzZVx0uki+ylU9dCAs5N2sJc8Ua5Q6SM+nV23W4CIk5UlvYagVJujvanHoNYCSWvhtf5crRwkKh63LJ4FaXPSb6Mee1iBnfTirdmHjYHS9iyPJtsMvY4IlhaaKPtYHaBUSRmSxvV0IqDqEaWO+WiLxG3CzdxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6916009)(54906003)(26005)(38100700002)(316002)(86362001)(31696002)(66556008)(66476007)(66946007)(5660300002)(36756003)(508600001)(6512007)(8936002)(4326008)(8676002)(6506007)(53546011)(83380400001)(31686004)(6486002)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhRZE5aYzExZ1I2UEFNL3RySHlzSEVXMnU4MGwzQUkzK1RweGpoUVcvYmlx?=
 =?utf-8?B?RXdEdWJrdFhtbjF5c28zYzlXckFxNDU3bm5wWUFndlRzSm5wKzI3SE5CbXhG?=
 =?utf-8?B?Mm5GU3FIaHNWVEtqU3ZFU21FaTIyK3ozQmdaR2VjR1hCMitGQ1RIQjVpbUts?=
 =?utf-8?B?MWpPSmF5TkNaTnBuSUxtak9leWQ1Q1lQaTFCRnc4N0RBK0ZQZW11Zlp4VnUw?=
 =?utf-8?B?MjdvMkFqdElvMWRrVit2MGU2eERLbjNieGR6SUhWTUNKU0tjaktqc0hsNVdr?=
 =?utf-8?B?endoS2R6OElzWnRtVUNHSWd2eEJSTTJpUGRPTWg4ck5yb090NWV1MUdCYllt?=
 =?utf-8?B?SXcxcTlsaUV3d1NxVDYvSG5GVmdsaFE2YVZUTFhhR1g2UHlYWSs5UkdUcmxj?=
 =?utf-8?B?R0ZFMXFkQmhYTE1xUkVCV0FlK0NvcHNRdlRMQkpDQzk3YlRzVTNmWGVHT1hk?=
 =?utf-8?B?eUoyNTY0UmUrakQ0RlpkNCs3V1lqSk1lTzA2VUtJNUlSemVHTVlWY0tZaHRS?=
 =?utf-8?B?WmlCMjMycmhoTnZKUUMrNlBhVnh0bkdYME1vWmtGdmQreStBeXozZWtoanE2?=
 =?utf-8?B?Q01wUWFSUS9ic2swQjZjVjdGZEJCMjVVRTM3aGdSbWU2Rkc5SkdRT08xYUE2?=
 =?utf-8?B?ZUh6aTAxY0QvUEJLdFRFV3FOUjBwbnBwaUgwZGl1dlJTV3VwSHVnVHF3dVpq?=
 =?utf-8?B?MHJ4T0FoMGxyakpUQjFWQ1FMOFJpMlhaaXg0dTJtOUJheUZhUkozTGFxL2Y0?=
 =?utf-8?B?OER1Qi9wL0hicHhCYUlOMXJhS2hqeVBoRys4a3FWOHJrZzNiaStFbEgwKzBJ?=
 =?utf-8?B?Uk0xdDUwTTY5cm5waGFUZXBKS3R1eHBKNC9uNURKcXRGdUw0NjNmRDBWT2s2?=
 =?utf-8?B?Z2dhUFVNdk1oSXVveW96R3BwSnVjRDBDQTBCeGJmTzBRN1dibTA3WTBjdSsx?=
 =?utf-8?B?UlpRY0ZRQ3ZQeEpwMHBoNEJHdXhVZmpBdXZGd2tVNjQyVmdqVE84ZjJQQUV0?=
 =?utf-8?B?dTMxOUhURE5zV3drMXJHaWZnUVZRM0RDUmIrQmxUUmw1aGt5dGpGWW05L0J4?=
 =?utf-8?B?VTVZZ3hRbGZyeVAybDd2SDhwKytQNlhBUlhQa1Z0SXZOZXlZNVRma1N3Zzhn?=
 =?utf-8?B?V1pSL0NMcS9CK0RPQkdTdzF1OEdFRW1ML0cybkk1QmpRVldzMzMxcFVLajRj?=
 =?utf-8?B?NGtpOWp0SFdhajhtajRCWHlUT2N1Z25WcTdxKysvM0tTYmYyQXQ1a05qOXFH?=
 =?utf-8?B?Q0ZoYkNWaWkyT2JkN0duTGpEcjA5cjVDd0FBbisrcVRhc29xRUVCb3YxVVF0?=
 =?utf-8?B?Vit5R2lVS3Fpd0dKWnd1YlZLY1BpWVFoMDBLMVlrOG85QUpqRGI1Y0NaK250?=
 =?utf-8?B?VFVmN1o0QkE5bkQySFNLTnF2K1doS3lWN21NV1hBbDQzUkxCc1ViQVgydEhi?=
 =?utf-8?B?dG1IZlhKRncyR2VnbUx6Z3NEQmFiMWYvSmxFOGVNRnVYc2x3S1JsRTNERi8z?=
 =?utf-8?B?cEVvTjBHSklRY2JpWlhIaDdFSXZtNElXYk9idFhhRDdFcVg5TzRtbUR1RS8x?=
 =?utf-8?B?bk8wcUU4ckpVN2pxdkVoYXIvc2JPQ1F6eGFqbzFlNGVBYzdqb2M4MEswTTlI?=
 =?utf-8?B?RjM3OWg0TTd4RUI5a004K1N5UWdLOVNUbjhmZWlORkltWWFzajdackNXWUFN?=
 =?utf-8?B?cU5mS1JsempockFZR3VRK1h4RlAwVlh3cXQ2RmF6eGlKb25WdnhIdWcwNzNV?=
 =?utf-8?B?Y1AzNlc1YWZLUzBpdldlMkg0MVFZOWpwSmVlRFlDcndYd3JWdjFucW9vYUxT?=
 =?utf-8?B?ZnV3Ny90cVR3Nk44MDJ0dUtqWEI4aWZUck5yaThtQjNPQ082QlNwdFIwWUV1?=
 =?utf-8?B?WWw3QkxxcFZuNkQ2YWdBa1JQeGNnR2ZLMFJReDY0YTJBZUcyN29oTTQ4alBZ?=
 =?utf-8?B?V1JlY3FYN1I4UzF3THZ0MGw0eW1nQit0VHhtS2Z0RDlRbDFabVIxbWNlZmJq?=
 =?utf-8?B?TGpIYkNmY1NOWXk2ZnFqVTEvWHZCa3ZmbjcraWhLMmRodUJyUkg1WVdDVEVE?=
 =?utf-8?B?QTBFeS9paU1ZY1BRcFpMTXBXTG1WYm1jLzQ5WjFQSWhzL2xZUUgwMHVuSzEv?=
 =?utf-8?B?TmdRZ0FIUzJHZmw2RGhteGcwWURMR204c21QYkxtQUJnZG0xSXdJVWo3elJx?=
 =?utf-8?B?bmZOYldyOWY5ZVJFazlkN3kyc3EzMzBoa0xMcVQ5N2Z4YlU0Y1ZqSkZlYUFG?=
 =?utf-8?B?dUIzZ2VHUThZNjNOQldOQVpjZHJ1bVJZQlJrOTBiaWxTRVBlTUs3SnViNDFY?=
 =?utf-8?B?ZC8rdEFTQ0VWZStVaWc5ejQzeWt0Mm9kS3F0QnQ2dGN2a1hwc0V4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7172998d-e79a-4e56-3f28-08da23ca8d5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 19:10:09.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Uqz84Pq7MashTJRa50iCCa8wfPMaqf8vprCxXs85ke2qSDRyRHppmT+l9WT5MlB6KNEFR9XiahfC2qC3BwaVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1588
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/20/2022 2:17 AM, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 08:24:35PM -0700, Smita Koralahalli wrote:
>> Why are we checking this here? This flag (hw_injection_possible)
>> is set to false inside prepare_msrs() called from
>> smp_call_function_single().
>> Should this check be done after the call to smp_call_function_single()?
> Why would you do that then?
>
> Is any of the code after
>
>          if (inj_type == SW_INJ) {
>                  mce_log(m);
>                  return 0;
>          }
>
> worth running if hardware injection is not possible?

Okay I got the gist of this now. This will be mainly useful for subsequent
hardware error injections.

Also, should we move this slightly before? In inj_bank_set() after we check
for sw injection and before reading IPID value?

>
>> Also, we already have inj_desc.err which returns error code to userspace
>> when WRIG in status registers. Why is this flag needed?
> To not do unnecessary work when you *know* hardware injection won't
> work.
>
> :-)

Okay.

>
> Btw, please trim your mails when you reply, just like I did.

I'm sorry. Noted for my next replies!

Thanks,
Smita
>
> Thx.
>

