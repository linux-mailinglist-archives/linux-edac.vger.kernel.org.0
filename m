Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B84780A3
	for <lists+linux-edac@lfdr.de>; Fri, 17 Dec 2021 00:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhLPXdT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 18:33:19 -0500
Received: from mail-bn1nam07on2104.outbound.protection.outlook.com ([40.107.212.104]:17383
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhLPXdS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5aTp5oPfqEDzjC3pvVFm6nBIBdSceoxzYzFnVSlDT4aCADxSDayEUBIVphxRWxpxL7+QHDURxGh3VRRb7kYsv0GiTM4wxZVUQt0MuEw8AZW9jSse9Y7BFtIsUlGxBzp4F5v5pn0cbERMCkWsdki1AxZLOZDuTqO3SWvq8AgFfnZ7iCqW1/w+fwJjfUDqmH++cweqF/mcT6i4NoykIJa1yEveEuvyXEnxWBSn21yOA/Ozd3x7Vkc2205wNJd21XyZH9HfBrMVhlTKp5Sk4f31b58sXhjXsgNk6FinQ5KRqf25L2nHzk5mTe3hcVTNyeaz78+3dvs17Iz4Z6A/0+BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibAQDggaQVso1YbpDoD8grnwzd+2xLbMe/l0oh+qJ0Q=;
 b=On0ff5G/zevPWvEYClZjuL+LWcmwAUHF4Z95/Q09wZ0xN1lO4j+XiGSm2+2T7b6j88aM31l92pcvaipNeFi7UIHaUuaqytvdn54NYcldq/xf5D/dLylazAdRdGBJRwhVU/UFoLk0oorgfXrDVZz5Edtvi17DcgJjAO8CUmHCnL4IAqiAmri4LRo1SsgCkH6tG645F8Cm+uS9kCiIoWjYdV6H8lPQBI8rNbuMIZZ4vSNZh7wXLnubNMofqwgj1CsINIVYHWcP4xojTqS9oRajou2fnQy11zejRWsKB4l2eKBJhm15Bf71K52Brj1R6wQPp6w0SkEIfu5UexLEUtTsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibAQDggaQVso1YbpDoD8grnwzd+2xLbMe/l0oh+qJ0Q=;
 b=HhhYUx9DSnXvpGkhWCYp3vmfgSlOJ57Jw5hMIfTWGVYKq9jMqkKRjQbPI4jNVmM1viTUnzSxd/2DFL86JGM4clYkmA2TXke5dP3GgU+oPIV8c/w2sBFH+WFmTHrniY4+rSJD7ZFdiUhtmUJK2Sfwlus3ET1aLQI0QjAzkEk4W2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) by
 CH0PR01MB6889.prod.exchangelabs.com (2603:10b6:610:102::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Thu, 16 Dec 2021 23:33:16 +0000
Received: from CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::c8fb:e830:d7e5:bdf7]) by CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::c8fb:e830:d7e5:bdf7%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 23:33:16 +0000
Message-ID: <9330bbfb-d016-0283-a5ed-e2f4d5446759@amperemail.onmicrosoft.com>
Date:   Thu, 16 Dec 2021 18:33:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Content-Language: en-US
To:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>,
        'Tyler Baicar' <baicar@os.amperecomputing.com>,
        "patches@amperecomputing.com" <patches@amperecomputing.com>,
        "abdulhamid@os.amperecomputing.com" 
        <abdulhamid@os.amperecomputing.com>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "tabba@google.com" <tabba@google.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jthierry@redhat.com" <jthierry@redhat.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Vineeth.Pillai@microsoft.com" <Vineeth.Pillai@microsoft.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
From:   Tyler Baicar <baicar@amperemail.onmicrosoft.com>
In-Reply-To: <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To CH0PR01MB7033.prod.exchangelabs.com
 (2603:10b6:610:107::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48bdbc92-aff1-4976-15ac-08d9c0ec6eff
X-MS-TrafficTypeDiagnostic: CH0PR01MB6889:EE_
X-Microsoft-Antispam-PRVS: <CH0PR01MB688961AB48AB9A38CCC1FEACE3779@CH0PR01MB6889.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAkvjVMQO7xkxa6wkLFzQNbV5wSdO0AAypyrL14/wBAUWHP/SU1QPwG0afUH8Zmga4/5PGyzI64fnUMICROFU1Jm6FP58katyDh+BeY8xE3/jfU3+QxIuU5iLMWZEKmEL875UgjbfIAlZJWdujbW/BXTANqdJNjY5vv3xvjj2z8rewkTYbkAG2ueCi9Cj48AH+4CuAUX5xN8f1kfOW7xqVgraWRdaXROxhLN1lnrCiKHXJZsWJ3uhZFDvGk+2bA/PlBxYEbEdldaWjZpZ7rBHs3L4rwtrs3rmiXThOtvyh6YWc83yIElbpuFWmTHfIRIeT6f5zBhtKCp5v64tiQ8mqJKqvtjp2aammLnKjNOwLVTETaCNhjKmjkCTCV4CfugtoaLIY6d5PVeiSdYkiDVZkXw0+28mvF9ECajE3WYOsy9t2Olb4h+fw5IOYyWCkP0MY7S9gEygdgeG9pD0C5kdSP0Wceb4a9K/gu77Nu8A1Ap7CIPrX86dsw8QmQX2j1QwO5bqtu0kXyp7JzKKdiTi2LqjtZiHzT4ld+Zh8GADuAxMQ23VTevJdp1PjghWCgk6Y4b/aho0FwXp21tDAlyXreXxFCuyVyQ7nuBvNW7bPtYrfCtkTvVCN/IfoMdwe6qUr4KiWHgdjreenrwxJFKVuINwL+xYDkWc8rHj+WOufYo4M731wkMu+JkPuXyByh6EkOhI0YFc4DQgS7QzgrM1Pcd6zJpDEEc4NxO5lN+T2Qb0rPD6rkrjNaJa2VIZxeP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7033.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(2616005)(26005)(38100700002)(83380400001)(66946007)(6506007)(921005)(6512007)(38350700002)(53546011)(6486002)(83170400001)(110136005)(31686004)(66476007)(2906002)(316002)(8936002)(6666004)(8676002)(52116002)(7416002)(186003)(31696002)(508600001)(42882007)(7406005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHphYXRmdjdPYTBGVWw2c1dwdFJkWlBhc3JiSGFnYWxrRDVSdlhVVGtmSk1h?=
 =?utf-8?B?MTlHWnVyQUJkcys3bjJKenZuS0NNNlhzSVFKWEZGVmdma1lIOGViM1VMWkpM?=
 =?utf-8?B?c3oyY1E0Qk5YR3pRZi9kRFpSM1UvcnRJaitCeGdLZC83enl1MkV0bmc1azkx?=
 =?utf-8?B?b0k4UGFpaHNHeHkzQUpzSkdOWFpGOUZVVm9WemlhZXJhaVdkK3JRcFJmOEJv?=
 =?utf-8?B?ZkhVU3E1cXFHbHpTaERUS2VtczFROVlXZDVyaVg4Z2RJeEFmQWVVcDV4TEND?=
 =?utf-8?B?SFl4bVgybldaZW9HZjMwVit4ZENjM1Rpcy84bDVSbmxEODQ0K1pjZml5dVc2?=
 =?utf-8?B?MkFRN2dqdnUyaWhQRkhJaFY0RHJsdzF0cUdtNFRvOWU0aFh1SDJ2WFNXV0tL?=
 =?utf-8?B?cDR2dVV1Qk9Dc1Ztdy9vMVNFWE1hVmFoYVkxMlNwTU1Hb1ZDS1JUSXpZU3Fa?=
 =?utf-8?B?WjRVVjBVbVRnbEQ5TTJuNFFldC9EZkoxVHYrWDNYanA1eklvVjk5WU1RUHFw?=
 =?utf-8?B?emE1aEFYb2Uxc3h2SlNxcUcycFpnd3hVdkVrdWxIcmlUNU0rM042bndoajc5?=
 =?utf-8?B?N0FOK1U4TGVici8vSDR2MmNiRmh1NlRqN09PaTduV0ZRSDlhNU95b1hTdHIx?=
 =?utf-8?B?WlUwT3ZQL1VhYjIxVW84Um5iZWRSWVk4SkllNlVJd0xsaG9jeEc3dStLc2dG?=
 =?utf-8?B?ZUU0R1o4UGgreXZha2FrMWlzZ01ndytjeDdDRFgzU0ZLOXZHL0VscXRnTzRM?=
 =?utf-8?B?b3FValRNcDJoZ0lNbnhsSGhtcFpZaHpIMCtadkdJTHdFZHozbzc1Y0kxNTVx?=
 =?utf-8?B?VjUzOEFWNlJNRVE4UFBuQ0hyd0h0ZWZLSGhSRmZJNlNqSkJGSml5NmxOV3FO?=
 =?utf-8?B?eWQ3cjVzV2VnYVpVQjZMMGx6VnVmSEJnL1RLUXQxNGNyeEk5dS93RnBJYzlK?=
 =?utf-8?B?YW81cFFQSGpNUjBPTTBlWVJHUHFwUlIvWk1pWHNUYjFUQyt2djdLUmE5NWtw?=
 =?utf-8?B?OFJNL3RNeGhGUXp4cm85Y3NVVTJNUDBIeHp3YzdqdUltOTNPb1ZXZWptM1Bz?=
 =?utf-8?B?dHUzL0RNS1Z6bEF6QjJBRTdvb0drSnlpMnYwNjNCVWUzb1JOUEg1ajlEZjRp?=
 =?utf-8?B?RW1tOGpNN05va09pUG5OZ3ZGU3BTV3RSMjJrWlpENTI0S0ZVWmdRZ210dWVL?=
 =?utf-8?B?alI4dU1CdG1RMmJ2cUFZeDN4eW5Tb1Z5TU5STzJLUHdsc3pmNndDZllrV0Jv?=
 =?utf-8?B?dXNnYzFZUTFBN3pLZFlJWXROSnFLWVZhNGp2dDR1SDk0QnA4djcvcGE0d1Rv?=
 =?utf-8?B?NWtKMVpNb1RyMmcwUmUza0hQaXE3VDZVK0JqYmlvZzlFUkxxVkJDVXg5Qnds?=
 =?utf-8?B?WnhuZnNFTnUrdWNFVWdCNStXV1I5elVFQkRUb3hnQXVnbHdnbFN0U0ZYaExN?=
 =?utf-8?B?R09KR1dQVnpabld2WW41WWlzNmVIclZZcDgvMkdoOVJpRDQ5U21BckN1bTN1?=
 =?utf-8?B?cEZWaHZTeDJpUWVtUkt1cXQ5RVJoZDFIV0dEZGhVSWswQlJOM21YWm1HQ3VH?=
 =?utf-8?B?LzhId1F0a2FxZzlsTlJ5TlFEb2VFYWI2N1ZkYmk3Z2tnOWJqRWxSckJGVmt0?=
 =?utf-8?B?VnkwN0VTMDhNdFR3cmkzUW9ISzhCLzNwREE2Zi9GWVp1VFBYSnRidjFEVW12?=
 =?utf-8?B?NnBzYWpsWVE0RFNWMUJyMTZPVE9RbnFySVYwVTlxTDNseEM5Y2lJa0hUOFBY?=
 =?utf-8?B?cXJLeCtJQk5KTHI0MTlldHRCK2JkYWtPK0M4Y3BUYlhWMEI4ZXdkY2g4U0No?=
 =?utf-8?B?b0dGKzcrME1hamxURUJtS2g5azgwMExNRWZ0aW1uWnpad3R1VkVUVGRWL0My?=
 =?utf-8?B?M1pVdFg0d2ZGajREclRzME1ZQThTU2RpMElhQ3diSUh6WDBwQzg3VUlmeWRt?=
 =?utf-8?B?Y1NSZWdhb2dUbkEzTCtxZXQwNVFvVW82YjE0eG43ZVpzOTkxKzBwUmtFbVdh?=
 =?utf-8?B?YUo2TnlsVElXb2hsT0U1RGx0VTNUZlRucUFkOHJMb0wrbFN5TzNabUVlTGZC?=
 =?utf-8?B?TndxYTdwMFkzTDhxcVBiTlVqbWNPNGhQa20yV0g2UGU3UzZJd1hEZURZNTht?=
 =?utf-8?B?aEJkWlBVMW1IZzVmSndTdC83dVl6UVk5RHA4TjlVTW5KVjN5aTVoQURXa3J4?=
 =?utf-8?B?ZUllVGJKcFBuQWdubHBsLzRYeVBjbGFOOE13VUtaNWVVTXYycEpPUVh3Z2Ex?=
 =?utf-8?B?dXh1WEg1V3hmNjduS09OSSt4MVFwZ3VlQTRMcVdqRFZqRWlDRE4xWGtoQThL?=
 =?utf-8?B?SWwvMitnMzBRYnM2WmpHc2I2UFBDVXYvdGpkbElndHB3SlVKMXhGZz09?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bdbc92-aff1-4976-15ac-08d9c0ec6eff
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7033.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 23:33:15.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rD4Rtnw0ekXcbHIh4lAeDZzJf5YUtgw8bbeHn2t0EupLtfHrLDf8x6/TmxGojWeQ7GvS7FC9VwFBgJ4uJIPRORlJECsow4RQhD/TNrF6kliJaw90SjcUMrCqxvEFHN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6889
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shuuichirou,

Thank you for your feedback!

On 12/9/2021 3:10 AM, ishii.shuuichir@fujitsu.com wrote:
> Hi, Tyler.
>
> We would like to make a few comments.
>
>> -----Original Message-----
>> From: Tyler Baicar <baicar@os.amperecomputing.com>
>> Sent: Thursday, November 25, 2021 2:07 AM
>> To: patches@amperecomputing.com; abdulhamid@os.amperecomputing.com;
>> darren@os.amperecomputing.com; catalin.marinas@arm.com; will@kernel.org;
>> maz@kernel.org; james.morse@arm.com; alexandru.elisei@arm.com;
>> suzuki.poulose@arm.com; lorenzo.pieralisi@arm.com; guohanjun@huawei.com;
>> sudeep.holla@arm.com; rafael@kernel.org; lenb@kernel.org;
>> tony.luck@intel.com; bp@alien8.de; mark.rutland@arm.com;
>> anshuman.khandual@arm.com; vincenzo.frascino@arm.com;
>> tabba@google.com; marcan@marcan.st; keescook@chromium.org;
>> jthierry@redhat.com; masahiroy@kernel.org; samitolvanen@google.com;
>> john.garry@huawei.com; daniel.lezcano@linaro.org; gor@linux.ibm.com;
>> zhangshaokun@hisilicon.com; tmricht@linux.ibm.com; dchinner@redhat.com;
>> tglx@linutronix.de; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
>> linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org; Ishii, Shuuichirou/石井
>> 周一郎 <ishii.shuuichir@fujitsu.com>; Vineeth.Pillai@microsoft.com
>> Cc: Tyler Baicar <baicar@os.amperecomputing.com>
>> Subject: [PATCH 1/2] ACPI/AEST: Initial AEST driver
>>
>> Add support for parsing the ARM Error Source Table and basic handling of
>> errors reported through both memory mapped and system register interfaces.
>>
>> Assume system register interfaces are only registered with private
>> peripheral interrupts (PPIs); otherwise there is no guarantee the
>> core handling the error is the core which took the error and has the
>> syndrome info in its system registers.
>>
>> Add logging for all detected errors and trigger a kernel panic if there is
>> any uncorrected error present.
>>
>> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
>> ---
> [...]
>
>> +static int __init aest_init_node(struct acpi_aest_hdr *node)
>> +{
>> +	union acpi_aest_processor_data *proc_data;
>> +	union aest_node_spec *node_spec;
>> +	struct aest_node_data *data;
>> +	int ret;
>> +
>> +	data = kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->node_type = node->type;
>> +
>> +	node_spec = ACPI_ADD_PTR(union aest_node_spec, node,
>> node->node_specific_offset);
>> +
>> +	switch (node->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		memcpy(&data->data, node_spec, sizeof(struct
>> acpi_aest_processor));
>> +		break;
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +		memcpy(&data->data, node_spec, sizeof(struct
>> acpi_aest_memory));
>> +		break;
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +		memcpy(&data->data, node_spec, sizeof(struct
>> acpi_aest_smmu));
>> +		break;
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +		memcpy(&data->data, node_spec, sizeof(struct
>> acpi_aest_vendor));
>> +		break;
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +		memcpy(&data->data, node_spec, sizeof(struct
>> acpi_aest_gic));
>> +		break;
>> +	default:
>> +		kfree(data);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
>> +		proc_data = ACPI_ADD_PTR(union acpi_aest_processor_data,
>> node_spec,
>> +					 sizeof(acpi_aest_processor));
>> +
>> +		switch (data->data.processor.resource_type) {
>> +		case ACPI_AEST_CACHE_RESOURCE:
>> +			memcpy(&data->proc_data, proc_data,
>> +			       sizeof(struct acpi_aest_processor_cache));
>> +			break;
>> +		case ACPI_AEST_TLB_RESOURCE:
>> +			memcpy(&data->proc_data, proc_data,
>> +			       sizeof(struct acpi_aest_processor_tlb));
>> +			break;
>> +		case ACPI_AEST_GENERIC_RESOURCE:
>> +			memcpy(&data->proc_data, proc_data,
>> +			       sizeof(struct acpi_aest_processor_generic));
>> +			break;
>> +		}
>> +	}
>> +
>> +	ret = aest_init_interface(node, data);
>> +	if (ret) {
>> +		kfree(data);
>> +		return ret;
>> +	}
>> +
>> +	return aest_init_interrupts(node, data);
> If aest_init_interrupts() failed, is it necessary to release
> the data pointer acquired by kzalloc?
aest_init_interrupts() returns an error if any of the interrupts in the 
interrupt list fails, but it's possible that some interrupts in the list 
registered successfully. So we attempt to keep chugging along in that 
scenario because some interrupts may be enabled and registered with the 
interface successfully. If any interrupt registration fails, there will 
be a print notifying that there was a failure when initializing that node.
>> +}
>> +
>> +static void aest_count_ppi(struct acpi_aest_hdr *node)
>> +{
>> +	struct acpi_aest_node_interrupt *interrupt;
>> +	int i;
>> +
>> +	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, node,
>> +				 node->node_interrupt_offset);
>> +
>> +	for (i = 0; i < node->node_interrupt_count; i++, interrupt++) {
>> +		if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
>> +			num_ppi++;
>> +	}
>> +}
>> +
>> +static int aest_starting_cpu(unsigned int cpu)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < num_ppi; i++)
>> +		enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int aest_dying_cpu(unsigned int cpu)
>> +{
> Wouldn't it be better to execute disable_percpu_irq(), which is paired
> with enable_percpu_irq(), in aest_dying_cpu()?

Good point. I will add that in the next version.

Thanks,

Tyler

