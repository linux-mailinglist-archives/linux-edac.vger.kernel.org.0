Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530406DDD44
	for <lists+linux-edac@lfdr.de>; Tue, 11 Apr 2023 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjDKOHe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Apr 2023 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDKOHc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Apr 2023 10:07:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064F1FE4;
        Tue, 11 Apr 2023 07:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS4FPHYwmwdvJpKLvSfyY99ywWsxEKSdjQ8KI30Idot4Ac1sYH6Mvl/iqJufD92+CkTLA2QMDnR9jQPdv4uqhq0/pKRI8wJJYLiO7IXb8D9NLnulVRlivIqVikCXcT2wr8wxLkCb2Wa2kKgKrf2licclnxVk0eLIziC+mbjHdqjjqs2kLnNWUNSKRoB/cP2CyP0s4Gp30SlMj6ojF0L/ExUzcTCbiQnuWxK5k8rqZPUhjeAZmxNkuXw4PHvLyy2193HZppx/+AFE/sxsadKafnTgPK0BPY1YWRfByJf2/UZjB7hc4GHbzDlvyxTo9CI7h2WjYKdQGdB7x2VTg/hlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZiMDV3U+28cXFumHjk5auBQu8UAOBqB3UdcIdLKZ+g=;
 b=mu1bIEsozoojf9mDrlUxbRWutxiyOElctWfYgAeNa4StNe3uOOf5ceHw3j3xfybibeedczWt6n2iLYl0dTdWfCPxBWt7tAW5gpwn29jNFa6pxtWbm3vzv/pY9DDRMNBdiO+p3uq675mBSji3u2+fFPoXfaDdfRftGVyVtYDyVEDzDHjmB7JO2TKyC/w9CMnRJ2cFm4kdJlI589YqK3eyAIIUq9QhBAVH7n6pQ4bYLsrlifZX0Ior13hfYmz4yZ+wpPVGPCzLHXW5399rXpWmdycpFqutLhdrjO1Wi3orF7KoKEtQCbkIg30qrLGBgxefmBKOZwIXPiKnel26Qa1I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZiMDV3U+28cXFumHjk5auBQu8UAOBqB3UdcIdLKZ+g=;
 b=f4Y1rd8j4OYnhcZG+QPVR20iVOWJkVcSY4pn5uKp4tz3zsGTeXtkx/uVEjfILIfjvThGUklaQDCxNYbOs+03NM7pU7Az8DDfnJtrNGcLWmxN9SP7sQX3v7xZl30/vybNX3mWU0kGKc4eNQSbZpkbugOgeIZcHgJXUtHrhbunUIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 11 Apr
 2023 14:07:28 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 14:07:28 +0000
Message-ID: <6b6e53c5-8562-8ea0-befa-88c8b38663d6@amd.com>
Date:   Tue, 11 Apr 2023 10:06:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 2/5] x86/mce: Add per-bank CMCI storm mitigation
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
References: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
 <20230403210716.347773-1-tony.luck@intel.com>
 <20230403210716.347773-3-tony.luck@intel.com>
 <20230411123234.GGZDVTYppLWRN5t0jX@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230411123234.GGZDVTYppLWRN5t0jX@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0776.namprd03.prod.outlook.com
 (2603:10b6:408:13a::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af4f50d-8c31-4852-cd56-08db3a96153f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETVE/uEPrb1Hzih/klHlUDWStIgbLJgeJUUoIW+tu3yZeXV0gG4W6qlbCp02/91Q7ZC5AAGoz6kNMSO3sErUoolSuBNe1gzkX9t2Ztk5ACvaS4nw7liCQggR1kGyKRYLSzT+hg8cC24KGROkBNwnT/OOlf5ln6HFzJ3/+CFpNbn4g6R7GKaYagffgBQvhTTHalt368xrbFLamVwPmJ7TqFGFtbMrIaxx5Mytfkb0b5nYWRVUBf8+K6WfTxDbWECMRT00mb8oCuQdFJ18JlR30qzdPOu8am4CjXiX4gY0B8sT40a31gHwBUlVfNT5jkG5wp1W9NxdcM9B/nhv4qcPyyUbjk3ynhXKVWq4OoZjJnlCwj95GZG7jvmiu+uW+cAfJRCXC5U4u5Vr3eNduzr6f169EDmVS26N4Xua8HIK7wxiHzlqQ7AW7dtBSDWE4A1ADxr4VqQ8XN13edKHVDIsagey2Kqh84WfYB5LRu90paK08VCcfWRU6hS0F48HDeu7+rfH+9Evl9DtnXxjBJD51t8IImSyC6S8pBRA0E1Xi/NU2y6XrKzc6Rc6RExXolFyi6wR7agXOIrtzwsYBEvWR1/P57sRetv1x0fvacOZuokCivxdwhp9cIHlp2qmRSJSZIGZO67r9bp19xUB4sMYcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(41300700001)(5660300002)(2616005)(8676002)(478600001)(8936002)(38100700002)(31696002)(83380400001)(44832011)(2906002)(15650500001)(31686004)(186003)(53546011)(6506007)(86362001)(6512007)(66476007)(66556008)(66946007)(4326008)(26005)(316002)(110136005)(6486002)(36756003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlY5MEpIWWJiVWRwVkYzQTZWMG1VQ2NwQW8wQTBmZzVac2dYV1BjWjl6SlNU?=
 =?utf-8?B?SjZnVFZvUURtR1BBWklnSFgzeTR2SGg4M1B4VTNJdzMxTkl3Ny9uYmI3YUt4?=
 =?utf-8?B?Uks3bS9JTENoaERnaStCZlhGaEV5amdLejU0bUtpRjhsVGF5dmdBZk13RUpx?=
 =?utf-8?B?RUMwVmFOUS9Pc0NOVUw0NE9lSHB1MjcyN3ZVWWQwODBTbTgwSkx1MVRvNHEr?=
 =?utf-8?B?ZmJpVWsxOXRLWVV0bG1LWXljQlRUT3M0c2ZwR20yVU9FeDcraS9RVUZTT2NG?=
 =?utf-8?B?SjlHVklJYnV0bTNoWkJUckY2ejlWaVFHRjlobEhXNnE4SityQ0ZaSjJyL0JP?=
 =?utf-8?B?QWtFbi9uR3Fud2p4NHJrSzBrejEzelRidXZjYnJKSUxScUNWQ1FZalBzSnE3?=
 =?utf-8?B?bE5abkFQRDg4Uy9SS082RjloaDVvZlhsazM3Z2FuSGNoeTlMaGtOVnlsM2VI?=
 =?utf-8?B?WkJ1akRnR2RlYTl6TWo3Yyt3blBzSHBCYnRuNUxkejV4OXlVbDFOeXFFVGJO?=
 =?utf-8?B?Q3Q1ZGpsTTFiR1ltYU9pNGp3K1MyRE9GaGdwNjRqUHAxTGZXSHpQQ2tNZVYx?=
 =?utf-8?B?Q0hxWUxFcUc1QXhEWDZJc3k2SEhpZ2FFMytzcVRaZjVSL1FMQVFrTnM2eXFQ?=
 =?utf-8?B?VFFaS1UzYTRZSmF4WTI5dSs0STdIQ2dMVzhnekg2eVl0MnY4emxnaTlIc0w1?=
 =?utf-8?B?bXV5RWZIM3I3bmlnL3hlRnM3em5yTUs1Q00vRDBBR3F1VmtoV1FjV1J2em42?=
 =?utf-8?B?QTUydWZhK0FjTkQzUm5TOWxwQ2tPTVpuRnQ4ejkxcndlVWJjSTdNZFc2K3RV?=
 =?utf-8?B?MDRlcEhWM3d6QmNpUTBHdC9DaGtIZVc4Vno4NE5RaFk5em8xRGY0UDNJUzhy?=
 =?utf-8?B?eFpMZzh5R0UwQUtrOEFHekM4RDQ4dHJ0VS9rTXVycXpGZzZTQm5XQ1JwMlYx?=
 =?utf-8?B?eWR6RmwxVEROVUtyclA5NGRvUkRDbzZJeWdGMXRraHBjcDIvRy92U2lTdzQv?=
 =?utf-8?B?SW5ob29mUlkyRFFwNlN6U2NDRWZINzJqUXd1MlRqN0VsMUdJRnQ3eGxhQk9p?=
 =?utf-8?B?UXd6UDVqYzZBcFZQUWZxa3JhdnNyN1ZlU08xVU9vSlFMRTYxMEJXWUVuWHZP?=
 =?utf-8?B?Z0NzbkNpQXN0b2ljbzdWQ3JtNjVJbjUxUklqTWt1WktPYm8zV0QraGpSUlc5?=
 =?utf-8?B?aStvdTVIZkVNdW5MdXVQMTBVMmFFSm9hdHJQc3pmSThoY1BnV1M0OC9XSEtD?=
 =?utf-8?B?S05VRU1Kb3h6MldnRytpSFU4SnpKZVVFK01zaUNacGN3VEhmZXYzY3c4UkYy?=
 =?utf-8?B?eDV5elBJakRvZUZRY2ZtT1FWSzFSclhPMVJsU1pxa0hzUjFybEdJMzJIN3hw?=
 =?utf-8?B?dlJ1czRhc1h2aG5CbXBqQmc2RjNIejhtVDNrZlNDK1BuOVBZeDBTZXN1ajh0?=
 =?utf-8?B?dWJKeWF2cTNRVHhwWExmZmxmZXkrQWRCTW55QVpLUnZVcDJzMGl2MkVCa1k0?=
 =?utf-8?B?RGVITFFIWjM0b0RjZWI0TStGU3VCUVB2RWpMUkh4K1hZMGVGVTRVeThKeTFo?=
 =?utf-8?B?UzVGMVZJdlZiM01RaUtyTkhOVFQ5RzVSZzltZ2VpcDhZeS9CU3FXV1AvYVd6?=
 =?utf-8?B?UjdQbksxSmRJOENjN29UMklmdnBnSElkSXJwQitNNmg4UUdwRERjMHdRNkNv?=
 =?utf-8?B?NFhIS1VUTEx1QXlHWE95ak9INDNqaFFHSkRvbkVxSGJtYnl5ZmEvaTRtb1Y0?=
 =?utf-8?B?ajhmQjB0cTF5cHhvcWNXS29NMUE0K3ovWnJ6VzRJbG9yTm5iR05JVXdvekp6?=
 =?utf-8?B?SngvYXhTSktwNjh4RUllTzFIZTk3Q2JNcE9rUW5vZDlkWnZycEhxcmIvSnBt?=
 =?utf-8?B?aUVJR0JFc1F5VkNyRVMzRU4rUDhoNThLaXQvNHRvNGRYU1JjVmdyZGw4YWIy?=
 =?utf-8?B?QW13eUwrbG95Qktoc3Y1L2ZMU0ZxUVdiQTNvYkk5UWtJeUEvd3hwZGdIVXFW?=
 =?utf-8?B?MEFwcGJqOWQ4UjJLL3ROL1JlZFozNUdYQUZaMGw0Um5zV01jNjFMYm80U1V2?=
 =?utf-8?B?K2pRQW5xSzF1QnVmRWQyOHFtYTNzUjBMaVkvOTg2akxZWUFQYXZkZ0hFUG9z?=
 =?utf-8?Q?v/nSmVzrGDHDferj01Zn1Cq1V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af4f50d-8c31-4852-cd56-08db3a96153f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 14:07:28.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuUKDIJDdncaKB3byAKgjH4GIWJ5jHr3pvFGylLGmR2Y5238uDgh8Nlf+NfHIaqyDNmtsP7DacC29ZvarNAIOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/11/23 08:32, Borislav Petkov wrote:
> On Mon, Apr 03, 2023 at 02:07:13PM -0700, Tony Luck wrote:
>> Add a hook into machine_check_poll() to keep track of per-CPU, per-bank
>> corrected error logs.
>>
>> Maintain a bitmap history for each bank showing whether the bank
>> logged an corrected error or not each time it is polled.
>>
>> In normal operation the interval between polls of this banks
>> determines how far to shift the history. The 64 bit width corresponds
>> to about one second.
>>
>> When a storm is observed the Rate of interrupts is reduced by setting
>> a large threshold value for this bank in IA32_MCi_CTL2. This bank is
>> added to the bitmap of banks for this CPU to poll. The polling rate
>> is increased to once per second.
>> During a storm each bit in the history indicates the status of the
>> bank each time it is polled. Thus the history covers just over a minute.
>>
>> Declare a storm for that bank if the number of corrected interrupts
>> seen in that history is above some threshold (5 in this RFC code for
>> ease of testing, likely move to 15 for compatibility with previous
>> storm detection).
>>
>> A storm on a bank ends if enough consecutive polls of the bank show
>> no corrected errors (currently 30, may also change). That resets the
>> threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap
>> for polling, and changes the polling rate back to the default.
>>
>> If a CPU with banks in storm mode is taken offline, the new CPU
>> that inherits ownership of those banks takes over management of
>> storm(s) in the inherited bank(s).
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>  arch/x86/kernel/cpu/mce/internal.h |   4 +-
>>  arch/x86/kernel/cpu/mce/core.c     |  26 ++++--
>>  arch/x86/kernel/cpu/mce/intel.c    | 139 ++++++++++++++++++++++++++++-
>>  3 files changed, 158 insertions(+), 11 deletions(-)
> 
> ld: vmlinux.o: in function `machine_check_poll':
> /home/boris/kernel/2nd/linux/arch/x86/kernel/cpu/mce/core.c:683: undefined reference to `track_cmci_storm'
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make: *** [Makefile:1249: vmlinux] Error 2
> make: *** Waiting for unfinished jobs....
> 

Ah, this is with CONFIG_MCE_INTEL=n and everything =y. Is there an automated
way to test every config, not just random, combination in a subsystem?

I'll try to add something like this to my flow. It seems allnoconfig,
defconfig, etc. aren't enough. And it's too easy to overlook during code review.

Thanks,
Yazen
