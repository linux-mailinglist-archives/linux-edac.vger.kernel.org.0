Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737FE4C1E41
	for <lists+linux-edac@lfdr.de>; Wed, 23 Feb 2022 23:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiBWWM2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 17:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbiBWWM2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 17:12:28 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841A3E0D8;
        Wed, 23 Feb 2022 14:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExkjnCTkUwxmc15YtM0ToZRXk7oSl4ABkjw04FeLY3yN4GTHM14InNls30Yr55h8JsFvFuheJdcVgtiF8Y6SxHruR47xDFl6tVgFe4OGfuAHBEMxqC7JK4kmgeBTLl0yPTaqdBS42db0QQQcbyi0OMAn49kgcH9RGI+B26ENivdJsGiC09tWBCQfEholq3SeCp4oe7/hEJH4eKYZ7mzr3x85ZdklyezNA46iYD+faIGjM6kl14nCk+FUMDAlMPZdUfUho0k7gm6Gj24/SYmjLSGvOspv9uugB9vGieWCCDZ6wtRIDOVUipHPqWtuMLH+uw2Z9gh0ERcGgjzYY46B2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ+e12gopt0eVkfdn6qfxYLwebaFAS7Mt5JNt67A/kw=;
 b=P7ZX0gACmgFBAr63usIHD3IfwOUGgnKhzD8cKAQsWiyu6CA9HhBIo+4RMsZzmvX+Xeva9xx6IFQfY8Vpudjc4RxkKbUTeRMFyztWjK7Jl7Rj+wIbspXLgBdhzTlRMBIaX3fG3BLzRKkCk7qeOMKFDH9M0/6//PwqaJmSx3Ii5NwjwTGx2WW1WyIkWsAaroFvbZCf5N5GJdc6p4BQfjoEMplgOXuFViaD/UQksmhlo2qQvJnjHWfXfTIFf7ARO7mnmgyoIi2+wxO4p1OIdides8dQuWlD8fD+uVrECGP9qecQlxwpyXszd8/NbW+cLXCxzRZkLdCMDM5NEVwg7KLpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ+e12gopt0eVkfdn6qfxYLwebaFAS7Mt5JNt67A/kw=;
 b=rHtp+NCvh4axWk7LZvQxMTrwzR0qN4YsEZzmaBSoWF3im5mIyHhXPPTSqR6vVBw8Sd67DseRio2gjTzqhlNI+1XpKCNF1N6/y0bNocJmGcrV+uFlfvj4k/DHbsQ4V/MtgJ3s2gMaEMatRM1XMARpVx7NPKf5EN9dsgpf3gz0z8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Wed, 23 Feb
 2022 22:11:53 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a%5]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 22:11:53 +0000
Subject: Re: [PATCH 2/2] x86/mce: Add per-bank CMCI storm mitigation
To:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <Yg6Hst4Ocg7UNNG9@agluck-desk3.sc.intel.com>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <16de01ad-bdfa-d5a0-7a3b-e03c3785a539@amd.com>
Date:   Wed, 23 Feb 2022 16:11:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <Yg6Hst4Ocg7UNNG9@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 342abbaa-6885-456c-caeb-08d9f7197f4d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4158:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41587652E8A216EA1837550C903C9@MN2PR12MB4158.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrsm6y44mgfQjVKfimgcbBOOTRPIRN+IvyK6btQpyRey3wwYUGhiplar9QHvNLY0PfzWTdVPejoX7kaK5F3cr9qJY79Vv8FLh2BnKSEb2uCqB5SZgwhgzP7YqtXdShaIXO043fPeFNwuqlkLbOPnN1hNiudnW2IGhv+3O5Qt+zArkO/U9MorU/6LU12S58jH6M58q78wp6xoUmQcaLj5ilYgFN5x41PwZ+Avd6YXR7uQawTCMiuWFKe72j5nzTvbyyrCfmMxJb4CcDl13eP+62vlYYnvNws4DLLCww5Bq55FlzbgV4q0qoq828cf89fDMnqLPoin1Y2MZr6p1MIruU4dvC4WTDZ8DZ1/NC3JbYz4cKhWE5FMxuhsjLKmH+Uy8FU5706TGh99MDVdMvOt+1Zg6FBUH01XwmdBaN5D+V65UJZe6vT538eQNPFLwQFo76M3xf6RQOhit0FLUQSHyp8mjP1JEbmVMSUnS3Uu+LDGAFXYGrRuHNsIQGz3MY6eOynBJK/FH/UxCXeUu/ipk3Gr6XYRB8gz+jLxOgHVwtUgIkU4XsNQhQaqW8RJVGpdvhfS/v/E/DuqzwhhWo6Wn8U3dXwOpW1InzdGPQjV34CbEX5ccXI8uP4QPTIV17jpm/ksuhkddtWIp+2+F5L401wmGHHf6L5wQvd5M3mkps9w7CPJ+7C9zk+eQkOfbsNRhYTfsleRAJQiWkZ3qe40I9PEgfrBmsmCX02YreGZIMRIQU3X2vqfkDqUCjTxnuahIDNnygdMN6zXpJsPTUhG+7HcljC6N7Seod+EyL8AeJYUEQauWIeKOQfMsDXrU6kh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(38100700002)(316002)(31696002)(2616005)(8676002)(66476007)(4326008)(66556008)(6512007)(66946007)(6506007)(53546011)(508600001)(31686004)(6636002)(110136005)(186003)(966005)(5660300002)(6486002)(2906002)(15650500001)(30864003)(8936002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWQxNTBWeVBjT1FJQUtBczA4ZTVlZ0xWd1FhM3V3alJOYThIZUh6SjFkOEUr?=
 =?utf-8?B?cllxYnZjNnZNTFlUTmZsc2ViUmNnODZrY1grYUc2b1ljV1grU2pXVENadFYy?=
 =?utf-8?B?QUFlZzdrenpJb0pYWk9xMGo3RFZzdVQ5RUJpMUw0MW9tOWYvODFONi9mQ0NO?=
 =?utf-8?B?WmNFU2tDQlY5WHl0TTV6blg3Z1c2a1NUdDV5cGN3ZEcvSUZadjkvOGtLd2RL?=
 =?utf-8?B?R3V5TTNwWjdCdVQ1bGVBcTY0Rmp2R1FPcGNxczFzVWFlU3BVTVNyeU5ydG0z?=
 =?utf-8?B?V1EzU1dCNmpaV3BRZ3BUbU41ZGpLaStJYTl4QTlNc1ZKZnpLbFQxRTUxN2Zx?=
 =?utf-8?B?cVlVT3NqY3ZhYnM5OWxSUy8rbVR2bVIyKzBQS0svM2l4WEh2ZHEzY1NsM0RI?=
 =?utf-8?B?clRaTWhKWnVYRFo2cTAzTWRCSnZkeG1kcENaRDJSRVdISVo0bXJOWHRWaXdY?=
 =?utf-8?B?Vmx2bFQ3Q2l6Z0JrVjdvMlNNL0czNm9lQ2hiWXNIbllFdXAzak13WDl6VHFy?=
 =?utf-8?B?Y1hpQ1ZIODlqMGdEMHQ3RzF0SUxSRFVZRlV0WFhnaVdDblFuR0k5eTFrY21D?=
 =?utf-8?B?ekVGVm9XQnptVGZzZU4wa01mOVJzR1FlK3ZRa2VEVGtmS3BPcCsxdlAwaXBx?=
 =?utf-8?B?SUJOWm96RTdGRUFRK1czZnhVUXBiZnlET3lWSVY2VlBKOFM5WDVqUDJnUmZD?=
 =?utf-8?B?U0k1Wk43VzIzVCsxMzdpSEZkdUFwTDBLcm9jUDNlUnVQV0xRS3ZmalFYSkEy?=
 =?utf-8?B?YnNldTVvVnplSFRLUlFNQzRnQ2E5c0toZzlkR3lnZjE5cCtTWG1aVFZSYXc5?=
 =?utf-8?B?NlhyNEx4RzRxRjczNmRabHFjQkgxMVA3QjU0SC80UDVINlBubWxJa3FXdThP?=
 =?utf-8?B?Skg3MmlUeTk4QlhWcVVOMm1vdWxLeS92Z0FCb1B4Q1BQOEo0SWVvcUV5SHBy?=
 =?utf-8?B?NHhQL01YQjhsTUIyWXo0TkVuL3RCZWxxK0plMmZMMmxmYjNHRmFDV2hZdGpK?=
 =?utf-8?B?bmk4dUZRb0RlY1hZWVltUTdaOGlqUHoxSmN3WU1qbHk1R25xOVdqVTQ5bHQ2?=
 =?utf-8?B?VFlHM1NtTmhKdTZqOExLNXFqbFd1K09LOTRYNGtwaXRRVGVEMHRSdUY0M1Va?=
 =?utf-8?B?L2lrU0lvd2VSU2ZLcmhiRnQzeU1VbDhNNXJTcE1KWUZyeWlULyt4UkZoWkRX?=
 =?utf-8?B?RXhya3pjWmcxTlJ5ME5hWXlQNTZGMGlvbEozM0Rwdnc3MEQ2R0ZYOFB1VGdC?=
 =?utf-8?B?V3lGZERtZUNHalNKZXlOY1I1T1VlVkIyQ09WNE1lUmJySVFnTUpxY0JjUjRn?=
 =?utf-8?B?eGZxWUpMVytOZG9zY3Nsa1didXdmNTdOUHJqN0ZONHVTMkxoa0FYL3RvSVNE?=
 =?utf-8?B?K3JVbDNrMUVMdE85dEFZbGxKamVwcm5ZT2RMUUFoOXJzazI2eVo5di9weXIy?=
 =?utf-8?B?N1Jmb09lSVpOZTNwTXJzd21jdktOYktvdCszYlZhdXNnUUdhMUlVY1pkUCtK?=
 =?utf-8?B?TXM1WWY5YkNLbitaQzN6eHJvcXJrUTNuL2FvRCtsK0pOZkZLTER5S2hpOVJR?=
 =?utf-8?B?SXVWU09aK1orWEJRNkpHN3VGSTNrRFJPZDVidGo0RG5tYXlCcVgyT3RZeXNU?=
 =?utf-8?B?a0JOdzduazdwNm11UXJubEJVdUV2Q0lWS0hNKytyazIwaVh4d3hWTjlhT1M3?=
 =?utf-8?B?TFluMDdiV3JHWDg4aitKb2FkWjA5cEhaOWRVU3cvMWdPWDZZMTZUWHU5T0Rv?=
 =?utf-8?B?SUxjNlcxVk0wTlNJZEN2RG13bjkrMWJxL3p1T3VJeE1KdS9QVmkrSy9SdElR?=
 =?utf-8?B?V040eHBFeDZrOUVFcDJNTGFKcFY5ZmdEMnBsSlZFVytLN0l6cVBtT2N4U250?=
 =?utf-8?B?QzdCcmJ6STRZSXRsdDk5MkRxTGZiY3ozTmgrWW9QdzMrLzRsekx1dHp4WDlV?=
 =?utf-8?B?RlRQMFdnbGovdVFTR1k1d3JBTFNDeWpYSUhSNnB2N1AzSEx0NU5nTGV1Y0hK?=
 =?utf-8?B?T1k5bi8vV0MrMURKN0lJZDJoSjdsczVMRkZBak82QzlwR0x2NFROYmtpR3V4?=
 =?utf-8?B?N09TUks2VDhHSCtwNnFaVFpxcmE2d0QwMnk3WndtbE1McTkxWlU2cnpXQUJs?=
 =?utf-8?B?UWtpVUtxQVpFZjVzaE1sMi9DNVd3M3RXYk1vRmdNMSt6Zm5uczdrQXVSclkw?=
 =?utf-8?B?eUdUbUV3eW5BNnBHdlowQUM2VW1aZTFzVGl6QjNoakVZeVFKYkErSnpjQ0pj?=
 =?utf-8?Q?VOkQz6AiJcwMnynwi8Tp3yi70iPGAcFALs8eV18Z3c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342abbaa-6885-456c-caeb-08d9f7197f4d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 22:11:53.3402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL5n80VlXZ+Rl1PkiKOBA744pqvnoH83sErz0viYGeNDJBVoBlYSBxraWG1rePuP2Mq/cb0T05QRfEwqNlpUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

After reviewing Intel's new implementation to handle storms and
comparing it against the patch here:
https://lore.kernel.org/all/20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com/  <https://lore.kernel.org/all/20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com/>

AMD's current implementation, already does per CPU disabling of
interrupts and the storm handling is done for corrected errors only.

However, we are not doing per bank approach to handle storms. So,
its a good idea to incorporate this in our code too.

It looked to me that most of the Intel's current implementation can
be shared except in few places where we use different registers
(MCx_MISC) for setting threshold limits to fire interrupts.

Other questions/comments below..

On 2/17/22 11:36 AM, Luck, Tony wrote:

> Add a hook into machine_check_poll() to keep track of per-CPU, per-bank
> corrected error logs.
>
> Maintain a bitmap history for each bank showing whether the bank
> logged an corrected error or not each time it is polled.
>
> In normal operation the interval between polls of this banks
> determines how far to shift the history. The 64 bit width corresponds
> to about one second.

I did not quite get this paragraph and the associated sentence below
..."Thus the history covers just over a minute".

I'm thinking these timing calculations relate to the statements above?

+	delta = now - this_cpu_read(bank_time_stamp[bank]);
+	shift = this_cpu_read(bank_storm[bank]) ? 1 : (delta + HZBITS) / HZBITS;
+	history = (shift < 64) ? this_cpu_read(bank_history[bank]) << shift : 0;
+	this_cpu_write(bank_time_stamp[bank], now);

Can you please elaborate?

>
> When a storm is observed the Rate of interrupts is reduced by setting
> a large threshold value for this bank in IA32_MCi_CTL2. This bank is
> added to the bitmap of banks for this CPU to poll. The polling rate
> is increased to once per second.
> During a storm each bit in the history indicates the status of the
> bank each time it is polled. Thus the history covers just over a minute.
>
> Declare a storm for that bank if the number of corrected interrupts
> seen in that history is above some threshold (5 in this RFC code for
> ease of testing, likely move to 15 for compatibility with previous
> storm detection).
>
> A storm on a bank ends if enough consecutive polls of the bank show
> no corrected errors (currently 30, may also change). That resets the
> threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap
> for polling, and changes the polling rate back to the default.
>
> If a CPU with banks in storm mode is taken offline, the new CPU
> that inherits ownership of those banks takes over management of
> storm(s) in the inherited bank(s).
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/kernel/cpu/mce/core.c     |  26 ++++--
>   arch/x86/kernel/cpu/mce/intel.c    | 124 ++++++++++++++++++++++++++++-
>   arch/x86/kernel/cpu/mce/internal.h |   4 +-
>   3 files changed, 143 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4f9abb66520d..1f3e7c074182 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -714,6 +714,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>   		barrier();
>   		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
>   
> +		mce_intel_storm_tracker(i, m.status);
> +
>   		/* If this entry is not valid, ignore it */
>   		if (!(m.status & MCI_STATUS_VAL))
>   			continue;
> @@ -1509,6 +1511,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
>   
>   static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
>   static DEFINE_PER_CPU(struct timer_list, mce_timer);
> +static DEFINE_PER_CPU(bool, storm_poll_mode);
>   
>   static void __start_timer(struct timer_list *t, unsigned long interval)
>   {
> @@ -1544,22 +1547,29 @@ static void mce_timer_fn(struct timer_list *t)
>   	else
>   		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
>   
> -	__this_cpu_write(mce_next_interval, iv);
> -	__start_timer(t, iv);
> +	if (__this_cpu_read(storm_poll_mode)) {
> +		__start_timer(t, HZ);

So, this is where the timer is fired to poll once per second on
a storm?

> +	} else {
> +		__this_cpu_write(mce_next_interval, iv);
> +		__start_timer(t, iv);
> +	}
>   }
>   
>   /*
> - * Ensure that the timer is firing in @interval from now.
> + * When a storm starts on any bank on this CPU, switch to polling
> + * once per second. When the storm ends, revert to the default
> + * polling interval.
>    */
> -void mce_timer_kick(unsigned long interval)
> +void mce_timer_kick(bool storm)
>   {
>   	struct timer_list *t = this_cpu_ptr(&mce_timer);
> -	unsigned long iv = __this_cpu_read(mce_next_interval);
>   
> -	__start_timer(t, interval);
> +	__this_cpu_write(storm_poll_mode, storm);
>   
> -	if (interval < iv)
> -		__this_cpu_write(mce_next_interval, interval);
> +	if (storm)
> +		__start_timer(t, HZ);

.. and here?

> +	else
> +		__this_cpu_write(mce_next_interval, check_interval * HZ);
>   }
>   
>   /* Must not be called in IRQ context where del_timer_sync() can deadlock */
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index cee9d989f791..2ed5634ec277 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -47,8 +47,48 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
>    */
>   static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
>   
> +/*
> + * CMCI storm tracking state
> + */
> +static DEFINE_PER_CPU(int, stormy_bank_count);
> +static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
> +static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);

So, we maintain two bitmaps.
bank_history: per bank bitmap which contains history of whether
the bank logged corrected error or not each time it is polled.

bank_storm: bitmap of banks in a storm.
Am I right?
  

> +static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
> +static int cmci_threshold[MAX_NR_BANKS];
> +
>   #define CMCI_THRESHOLD		1
>   
> +/*
> + * High threshold to limit CMCI rate during storms. Max supported is
> + * 0x7FFF. Use this slightly smaller value so it has a distinctive
> + * signature when some asks "Why am I not seeing all corrected errors?"
> + */
> +#define CMCI_STORM_THRESHOLD	0x7FED
> +
> +/*
> + * How many errors within the history buffer mark the start of a storm
> + */
> +#define STORM_BEGIN	5
> +
> +/*
> + * How many polls of machine check bank without an error before declaring
> + * the storm is over
> + */
> +#define STORM_END	30
> +
> +/*
> + * If there is no poll data for a bank for this amount of time, just
> + * discard the history.
> + */
> +#define STORM_INTERVAL (1 * HZ)

Looks like STORM_INTERVAL isn't been used anywhere..

> +
> +/*
> + * When there is no storm each "bit" in the history represents
> + * this many jiffies. When there is a storm every poll() takes
> + * one history bit.
> + */
> +#define HZBITS (HZ / 64)
> +
>   static int cmci_supported(int *banks)
>   {
>   	u64 cap;
> @@ -103,6 +143,70 @@ static bool lmce_supported(void)
>   	return tmp & FEAT_CTL_LMCE_ENABLED;
>   }
>   
> +/*
> + * Set a new CMCI threshold value. Preserve the state of the
> + * MCI_CTL2_CMCI_EN bit in case this happens during a
> + * cmci_rediscover() operation.
> + */
> +static void cmci_set_threshold(int bank, int thresh)
> +{
> +	unsigned long flags;
> +	u64 val;
> +
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);

Why not local_irq_save(flags) instead?

> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> +	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
> +}
> +
> +static void cmci_storm_begin(int bank)
> +{
> +	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	this_cpu_write(bank_storm[bank], true);
> +	if (this_cpu_inc_return(stormy_bank_count) == 1)

What is the significance of stormy_bank_count?

> +		mce_timer_kick(true);
> +}
> +
> +static void cmci_storm_end(int bank)
> +{
> +	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	this_cpu_write(bank_history[bank], 0ull);
> +	this_cpu_write(bank_storm[bank], false);
> +	if (this_cpu_dec_return(stormy_bank_count) == 0)
> +		mce_timer_kick(false);
> +}
> +
> +void mce_intel_storm_tracker(int bank, u64 status)
> +{
> +	unsigned long now = jiffies, delta;
> +	unsigned int shift;
> +	u64 history;
> +
> +	delta = now - this_cpu_read(bank_time_stamp[bank]);
> +	shift = this_cpu_read(bank_storm[bank]) ? 1 : (delta + HZBITS) / HZBITS;
> +	history = (shift < 64) ? this_cpu_read(bank_history[bank]) << shift : 0;
> +	this_cpu_write(bank_time_stamp[bank], now);
> +
> +	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
> +		history |= 1;
> +	this_cpu_write(bank_history[bank], history);
> +
> +	if (this_cpu_read(bank_storm[bank])) {
> +		if (history & GENMASK_ULL(STORM_END - 1, 0))
> +			return;
> +		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> +		cmci_set_threshold(bank, cmci_threshold[bank]);
> +		cmci_storm_end(bank);
> +	} else {
> +		if (hweight64(history) < STORM_BEGIN)
> +			return;
> +		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
> +		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> +		cmci_storm_begin(bank);
> +	}
> +}
> +
>   /*
>    * The interrupt handler. This is called on every event.
>    * Just call the poller directly to log any events.
> @@ -147,6 +251,9 @@ static void cmci_discover(int banks)
>   			continue;
>   		}
>   
> +		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
> +			goto storm;
> +
>   		if (!mca_cfg.bios_cmci_threshold) {
>   			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
>   			val |= CMCI_THRESHOLD;
> @@ -159,7 +266,7 @@ static void cmci_discover(int banks)
>   			bios_zero_thresh = 1;
>   			val |= CMCI_THRESHOLD;
>   		}
> -
> +storm:
>   		val |= MCI_CTL2_CMCI_EN;
>   		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
>   		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
> @@ -167,7 +274,14 @@ static void cmci_discover(int banks)
>   		/* Did the enable bit stick? -- the bank supports CMCI */
>   		if (val & MCI_CTL2_CMCI_EN) {
>   			set_bit(i, owned);
> -			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
> +			if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {

Why val is checked twice? Before goto storm and after?

> +				pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), i);
> +				this_cpu_write(bank_history[i], ~0ull);
> +				this_cpu_write(bank_time_stamp[i], jiffies);
> +				cmci_storm_begin(i);
> +			} else {
> +				__clear_bit(i, this_cpu_ptr(mce_poll_banks));
> +			}
>   			/*
>   			 * We are able to set thresholds for some banks that
>   			 * had a threshold of 0. This means the BIOS has not
> @@ -177,6 +291,10 @@ static void cmci_discover(int banks)
>   			if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
>   					(val & MCI_CTL2_CMCI_THRESHOLD_MASK))
>   				bios_wrong_thresh = 1;
> +
> +			/* Save default threshold for each bank */
> +			if (cmci_threshold[i] == 0)
> +				cmci_threshold[i] = val & MCI_CTL2_CMCI_THRESHOLD_MASK;

So, this is the default threshold value for interrupts to fire after storm
subsides?

Is this defaulted to 1? As the commit message reads..
.."That resets the threshold in IA32_MCi_CTL2 back to 1"..

>   		} else {
>   			WARN_ON(!test_bit(i, this_cpu_ptr(mce_poll_banks)));
>   		}
> @@ -218,6 +336,8 @@ static void __cmci_disable_bank(int bank)
>   	val &= ~MCI_CTL2_CMCI_EN;
>   	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
>   	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
> +	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
> +		cmci_storm_end(bank);
>   }
>   
>   /*
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index f01d6cbeb809..6c7480bce977 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -41,12 +41,14 @@ struct dentry *mce_get_debugfs_dir(void);
>   extern mce_banks_t mce_banks_ce_disabled;
>   
>   #ifdef CONFIG_X86_MCE_INTEL
> +void mce_intel_storm_tracker(int bank, u64 status);
>   void cmci_disable_bank(int bank);
>   void intel_init_cmci(void);
>   void intel_init_lmce(void);
>   void intel_clear_lmce(void);
>   bool intel_filter_mce(struct mce *m);
>   #else
> +static inline void mce_intel_storm_tracker(int bank, u64 status) { }
>   static inline void cmci_disable_bank(int bank) { }
>   static inline void intel_init_cmci(void) { }
>   static inline void intel_init_lmce(void) { }
> @@ -54,7 +56,7 @@ static inline void intel_clear_lmce(void) { }
>   static inline bool intel_filter_mce(struct mce *m) { return false; }
>   #endif
>   
> -void mce_timer_kick(unsigned long interval);
> +void mce_timer_kick(bool storm);
>   
>   #ifdef CONFIG_ACPI_APEI
>   int apei_write_mce(struct mce *m);

Seems to me that most of the code can be shared except in few places.

Should I come up with a shared code by keeping Tony's patch as reference
and incorporating AMD's changes in them?

Thanks,
Smita


