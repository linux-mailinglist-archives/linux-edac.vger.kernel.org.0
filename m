Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418DB4291B8
	for <lists+linux-edac@lfdr.de>; Mon, 11 Oct 2021 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhJKO2y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Oct 2021 10:28:54 -0400
Received: from mail-bn1nam07on2054.outbound.protection.outlook.com ([40.107.212.54]:12344
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240596AbhJKO2r (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Oct 2021 10:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGS57pUwjf0vZWUu4XL6DC078CKeeTv1bJQdHu6tVw1hns5MPEtmAfAKzWeT9fLjj5ON7ounHG9o4cf3swBRneHYpFwbEUCRhVYUTBYfQmFUr/QhN1bPeu1eIpzC2Qc1HdXCK+pAjneXWT4C1iUkarYBjIVCxdIEmeUaWtAge/5/v8dy9Dn2TBFHOJpF8yYfbxygbGABaKxJbY9cKXO9yyJX+0WN5XotFl0awtPSrgUNlLYXpvn0ObLNhG3BzTUcgl76taZxLSqBUm3l7QcqIojOPhGSgEkqHJch96QuipBMUoJRzqgiTCgL11L6VPEpJlL6ImmzDGG03vrhL70k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrO0zb1gu3WVRxgHMFDhzjP6uM1pC0W7WJbakIjz27g=;
 b=GYyONOg6cKB7YYQQaLJFQg4K7s6dETLdjQTXfQIHwoSYC/3TuK9M70TyGyRpEGZhtoz/RPBi1YZSdRROzimQ2xS/9WTQqZknV9ZZ2dSmrI8uGhVqxMzWXQalIM1PbCF0IyLM6yV5ZUi+iMT4fBeBEM7nqVtG9OQ+Hk5jHdJCkJAuu5coGxBd52/Z+Gw4/7Sp2ZYES8AYuecFTMX+agNobAxJFtFUaoZYFaGu5TysTVmIbl/IWkoYqBpisLJCgL6oG/xJcM/TCa0GMacvgHRO1hLRPRSU5nyghcPnqF+DlqHTL7rMlS0lxeAcVhUOdSQnTNfGPnbbSdzNhlDgMIMIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrO0zb1gu3WVRxgHMFDhzjP6uM1pC0W7WJbakIjz27g=;
 b=1STXa1lkXm3U+Kao6k6He7FJxbIXYDGyuwWB6krHb933kjHMqtp6ILxyTh1LYpKCRwPderZCm69OTjJIlSKmWnsfl8InmzcnB3oiD88/5VcEDfAZL24gsxcZrX1K/mRD5Q4PTX6zoo1hfEfd8hBP2s32Yeq/vHDCg8hn22gAHFk=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 14:26:44 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8c60:1040:31ba:22f0]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8c60:1040:31ba:22f0%7]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 14:26:44 +0000
Message-ID: <dcc7c537-0370-d190-9ca7-ce60fa29d68c@amd.com>
Date:   Mon, 11 Oct 2021 19:56:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Yazen.Ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com> <YSYeo6S2OSZbBpb4@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YSYeo6S2OSZbBpb4@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15)
 To BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 14:26:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1cd93c-54d6-49b2-1e11-08d98cc32682
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50610A7D08EF7A38FACBB7E1E8B59@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ734f3PcKqeKfU6SBxK1o/ShhADKcCfTqdDO0uHeUZiLa8/+W+9nh1akKjM5/MKHtRJQkPnx3gv1Pq+iPyZEfkkYZzUHncy/xjp7ePHp4R3/E0lDLOKvyStS7D/K4S+EZ9bhS8Fv3UILH/0ZRhTArHqF4tsjehlUFRQRAUDvEgK4IxyCPkm0Yn1njrlcR3CR442C1rFyjf2UeGS/geqCPmUSAEWct0c/kz9DCxXRZ/UGKaNN7TZTUr6av2WmbB+Zod1TMyXvhD0N93G4Ir2YKbbL4zyrGrFXEe7RDvfle4AQ1B9ERUB26EJtVXMlyzKxVY7WxfajraGIaCoqZupDiNT3hAV9UsuZEn3o4WQartwsxrARCht1S9C6UHYd+t5itNGuWn7u6LJnVdPJHmhImKpVTcH8b4YEx0SsIxmvCjIcSavhQXFUVMlLqLgmhs1+09puMSsQzGCt1RhhFnoAd0dn5Phu65TnzDZQRHD00mXFnjEAxnJFuoZXwcCIHPn0YzuBrqTsg2C8EeodApKViZ2ITKUJAZwBZOdvpCV6eqWM3qOAYNi+8aiCDctTV/m2CZb4qtkOr+r1rkWzAp09MB3u3rhfNhoGORhNOR/1rNnaC2EIbW4gZ7PJiEK2sQweQeE92rnUCvxcGfkW1S3HDgRD7au68crGcEwt7ZPL0XN2w2fPFxk8RnncygoZe9LHc66F+ZHj4QG6KQFL1aoxnvwkucI90zXVJ/vTAgIN6OPoWmsDYK1+v3Z3I9f1W2OGuxz4jXo0SPdfvYEh1ZSRQ+EQvMT7xc96MRV28TlcpoZc4J/w918ue5oEhMTsj4XMB1ShVAsjR9/xp1sk4WMil3/dA6G8evYhib0GaJ7+Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(316002)(83380400001)(6486002)(8936002)(6666004)(26005)(186003)(53546011)(30864003)(5660300002)(31686004)(966005)(66946007)(66556008)(66476007)(2906002)(2616005)(956004)(8676002)(31696002)(508600001)(4326008)(38100700002)(6916009)(45080400002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTB6WTNuZEl5WEpKZTlXR1d4NXlVRjdhTlZKTk9PVTNpaktiaXpSaFlrT0JM?=
 =?utf-8?B?L002a0loWlZsOGZEUS8xejBIdDBvYmNyNHQvckZZRlVob0NIQ0VJRGRwa3Mz?=
 =?utf-8?B?MjhpL3ZzamM0T3dnWE1ON0FkQytoaVpONzVUWUFFc2dTdk1GZUJSaVRUd3Y0?=
 =?utf-8?B?YnppcHVhY1o4MmhUWWZQTWl3dnlqc1NFMHZ1Vk9WZ0lvZ2Vuc1VGb2tNYWh5?=
 =?utf-8?B?WTVmNWVtdmwyOVhPU0huZmdGWTdUUHlxNERKb015TVJwZFgyQ3Vha21BOVJh?=
 =?utf-8?B?K1ZsU0xZL0c1QXdvVnVvdTRFWTdRTEU5S2N3WmpCUGtYeXdZMFhFc0ZkTjQr?=
 =?utf-8?B?dXJrSWJtN1BXSWZJc0tGdnJtd3JIeTdsaml4anE5WUdZL0FQZ01zVUhPQjJ2?=
 =?utf-8?B?OFE2dVVXaDRXWVFIVEFOYWRZeS9GS2xiRXpVUVlyWnRzN0dnQ0txM1NJSDVS?=
 =?utf-8?B?cjNGSnpxUkszb3NpTGNUS1pIOS9URjVVdTNIVzQ0akVyNmppaW5FK1Y0WHNt?=
 =?utf-8?B?MHIrdm5kQWtFN0l5dnVKa2ViUHRvZTFPVS9rQW1VeWVoOFkrMG5WcjFiOXpz?=
 =?utf-8?B?eEIrUytOU1Fna0hBTUJDdDFhSlhwUGUxTnNsT1dnWlU5YlBkUmlXekFOZmZy?=
 =?utf-8?B?RDlGWklzY1dsNWVpWWdZRUF0cENNWHJqSUkybVFpa2Y0Z1dpWFRpR1hNbUFM?=
 =?utf-8?B?NjM4cWpBVDN6RFZJOEJnRUxhTTdCSU1QbU1OQ3Q2QjJrSzZGeVlKaE8rY3Fm?=
 =?utf-8?B?RWREU0IzcUU4OFRSd2ZQaEs5aCtja3JFay9iakVuTDFCKzNoTWRrODR5TWZa?=
 =?utf-8?B?enduWUsxUHFlOUZaOXJXakZWUU5TK0ZPdHdjekxvUVo2cTJ6cVJhR0JEYnBk?=
 =?utf-8?B?TDNkejhtZGtPNmw0aDhCYm5RZGI3eERPSEVoZjNMSlBuREVwNmJsZEo0TVpX?=
 =?utf-8?B?eUNVa2FCNWFuUWM0dVJBeExyMzFjaHI5SHFUZndxaFRuN2tsZWU1VFFJN1ZW?=
 =?utf-8?B?c25YQ3VGUkV5VWEySzZNQjE1c09RM1RxTzI3dm9YcHhwd2pTWDl2V0FjNXBh?=
 =?utf-8?B?U2ZETHdBVmJ0bW50S2lIcmJhNUFjUGV1Qk9TS2k3dXQ1NGdiSFlkNHhsT1g5?=
 =?utf-8?B?N0dWRTZINGgvdkpiZ2pJdDlQN1dHL3U5WmlKc0ZYMmo4Q2pLcm1wenFJaGtP?=
 =?utf-8?B?MnQzSE1SSkxDM2VCQzFlODE2N0YwZXdVcDkvS05qenlBeDk3WDRkbVpzM3g0?=
 =?utf-8?B?UUFCWkgwSlRhMkRqV0hqeUVqbW50dGpxNExSRUNVMjI0KzJ2NVRRTmc0Rkl6?=
 =?utf-8?B?VjJRWFUxbDUxVkZEK0FIYTdra3oydjB4VG1QTTh0Q1RNUHh1M0xJdWVpS3B5?=
 =?utf-8?B?ZUFKeEQwRFlRKy9nZDFtMGxMZDl4WTljOXBRM2FHMWN6MzdxclFHaDlaMElm?=
 =?utf-8?B?OUlCR0ZTNUlXT25ib3R6bVVHTmNzZnJaV3FBREkrc2s3bEF5QWV6c3BKZlN1?=
 =?utf-8?B?QzJJZkYxUlJidjBHZXRiRVlFOTNoc2ZhOWFEazduQmNtNGRYMmNRaXhFSUlU?=
 =?utf-8?B?VU14cnVBL1lHd2FNL3IxK2hYemNQK3BITkQ4cGNxV25oemdSYU5RcFpraFRB?=
 =?utf-8?B?Q3ZJM2lURnZKMitKMmE2QXhSL3p0aENPU2Z0V2oza1o4SThZMlZqUmU0Wm5x?=
 =?utf-8?B?aHdVQm1EUkNMbVc5UVpzYTE4bUc2emduU29Oc0E3d2FJTG9jQXAyenZtOEVx?=
 =?utf-8?Q?q2hYGKN4AIvwbS3iRsFjUtvvUtogFsjt6Vor9tW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1cd93c-54d6-49b2-1e11-08d98cc32682
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 14:26:44.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58dbhsdLOPRrSlAlkpczGSiv0PvmrEXvqNdkDG1slaH8WVNxyRIgLyZlpuGYV5dvwuaU8nHobD34VIpVf7VY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

Apologies for the late reply. We were modifying the code based on the 
conversation between yourself and Yazen.

I would like to answer some of your questions before submitting the next 
version of the patch-set.

On 8/25/2021 4:12 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Tue, Aug 24, 2021 at 12:24:35AM +0530, Naveen Krishna Chatradhi wrote:
>> From: Muralidhara M K <muralimk@amd.com>
>>
>> On newer systems the CPUs manage MCA errors reported from the GPUs.
>> Enumerate the GPU nodes with the AMD NB framework to support EDAC.
>>
>> This patch adds necessary code to manage the Aldebaran nodes along with
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
Sure thanks
>
> Also, what are the "Aldebaran nodes"?
>
> Something on a star which is 65 light years away?

Aldebaran is an AMD GPU name, code submitted [PATCH 000/159] Aldebaran 
support (lists.freedesktop.org) 
<https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html> 
is a part of the DRM framework

>
>> the CPU nodes.
>>
>> The GPU nodes are enumerated in sequential order based on the
>> PCI hierarchy, and the first GPU node is assumed to have an "AMD Node
>> ID" value of 8 (the second GPU node has 9, etc.).
> What does that mean? The GPU nodes are simply numerically after the CPU
> nodes or how am I to understand this nomenclature?
>
>> Each Aldebaran GPU
>> package has 2 Data Fabrics, which are enumerated as 2 nodes.
>> With this implementation detail, the Data Fabric on the GPU nodes can be
>> accessed the same way as the Data Fabric on CPU nodes.
>>
>> Signed-off-by: Muralidhara M K <muralimk@amd.com>
>> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>> Changes since v2: Added Reviewed-by Yazen Ghannam
>>
>>   arch/x86/include/asm/amd_nb.h | 10 ++++++
>>   arch/x86/kernel/amd_nb.c      | 63 ++++++++++++++++++++++++++++++++---
>>   include/linux/pci_ids.h       |  1 +
>>   3 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
>> index 455066a06f60..09905f6c7218 100644
>> --- a/arch/x86/include/asm/amd_nb.h
>> +++ b/arch/x86/include/asm/amd_nb.h
>> @@ -80,6 +80,16 @@ struct amd_northbridge_info {
>>
>>   #ifdef CONFIG_AMD_NB
>>
>> +/*
>> + * On newer heterogeneous systems the data fabrics of the CPUs and GPUs
>> + * are connected directly via a custom links, like is done with
> s/ a //
>
>> + * 2 socket CPU systems and also within a socket for Multi-chip Module
>> + * (MCM) CPUs like Naples.
>> + * The first GPU node(non cpu) is assumed to have an "AMD Node ID" value
> In all your text:
>
> s/cpu/CPU/g
>
>> + * of 8 (the second GPU node has 9, etc.).
>> + */
>> +#define NONCPU_NODE_INDEX    8
> Why is this assumed? Can it instead be read from the hardware somewhere?
> Or there simply won't be more than 8 CPU nodes anyway? Not at least in
> the near future?
>
> I'd prefer stuff to be read out directly from the hardware so that when
> the hardware changes, the code just works instead of doing assumptions
> which get invalidated later.
>
>> +
>>   u16 amd_nb_num(void);
>>   bool amd_nb_has_feature(unsigned int feature);
>>   struct amd_northbridge *node_to_amd_nb(int node);
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 23dda362dc0f..6ad5664a18aa 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -26,6 +26,8 @@
>>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>>   #define PCI_DEVICE_ID_AMD_19H_DF_F4  0x1654
>>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT     0x14bb
>> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4    0x14d4
> You see how those defines are aligned vertically, right?
>
> If your new defines don't fit, you realign them all vertically too - you
> don't just slap them there.
>
> And if it wasn't clear above, that Aldebaran GPU chip name means
> something only to AMD folks. If this is correct
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FVideo_Core_Next&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Ce18fc8abf0da4da621b908d967b4ff31%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654849356966973%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Ge%2Fh%2FA2YmlKA7IF8XjuwM%2F4eygYYfybMOJs4jLX3g3I%3D&amp;reserved=0
>
> then that Aldebaran thing is VCN 2.6 although this is only the video
> encoding stuff and GPU I guess is more than that.
>
> IOW, what I'm trying to say is, just like we name the CPUs using their
> families, you should name the GPUs nomenclature with GPU families (I
> guess there's stuff like that) and not use the marketing crap.

Aldebaran GPU might be a later variant of gfx9 and are connected to the 
CPU sockets via custom xGMI links.

I could not find any family number associated with the GPUs. The DRM 
driver code uses it as follows and

does not expose the value to other frameworks in Linux.

+#define CHIP_ALDEBARAN 25

in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm

> If you need an example, here's how we did it for the Intel marketing
> pile of bullsh*t:
>
> arch/x86/include/asm/intel-family.h
>
> Please provide a similar way of referring to the GPU chips.
>
>>   /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>>   static DEFINE_MUTEX(smn_mutex);
>> @@ -94,6 +96,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
>>        {}
>>   };
>>
>> +static const struct pci_device_id amd_noncpu_root_ids[] = {
> Why is that "noncpu" thing everywhere? Is this thing going to be
> anything else besides a GPU?
>
> If not, you can simply call it
>
>          amd_gpu_root_ids
>
> to mean *exactly* what they are. PCI IDs on the GPU.
>
>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
>> +     {}
>> +};
>> +
>> +static const struct pci_device_id amd_noncpu_nb_misc_ids[] = {
>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
>> +     {}
>> +};
>> +
>> +static const struct pci_device_id amd_noncpu_nb_link_ids[] = {
>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
>> +     {}
>> +};
>> +
>>   const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
>>        { 0x00, 0x18, 0x20 },
>>        { 0xff, 0x00, 0x20 },
>> @@ -230,11 +247,16 @@ int amd_cache_northbridges(void)
>>        const struct pci_device_id *misc_ids = amd_nb_misc_ids;
>>        const struct pci_device_id *link_ids = amd_nb_link_ids;
>>        const struct pci_device_id *root_ids = amd_root_ids;
>> +
>> +     const struct pci_device_id *noncpu_misc_ids = amd_noncpu_nb_misc_ids;
>> +     const struct pci_device_id *noncpu_link_ids = amd_noncpu_nb_link_ids;
>> +     const struct pci_device_id *noncpu_root_ids = amd_noncpu_root_ids;
>> +
>>        struct pci_dev *root, *misc, *link;
>>        struct amd_northbridge *nb;
>>        u16 roots_per_misc = 0;
>> -     u16 misc_count = 0;
>> -     u16 root_count = 0;
>> +     u16 misc_count = 0, misc_count_noncpu = 0;
>> +     u16 root_count = 0, root_count_noncpu = 0;
>>        u16 i, j;
>>
>>        if (amd_northbridges.num)
>> @@ -253,10 +275,16 @@ int amd_cache_northbridges(void)
>>        if (!misc_count)
>>                return -ENODEV;
>>
>> +     while ((misc = next_northbridge(misc, noncpu_misc_ids)) != NULL)
>> +             misc_count_noncpu++;
>> +
>>        root = NULL;
>>        while ((root = next_northbridge(root, root_ids)) != NULL)
>>                root_count++;
>>
>> +     while ((root = next_northbridge(root, noncpu_root_ids)) != NULL)
>> +             root_count_noncpu++;
>> +
>>        if (root_count) {
>>                roots_per_misc = root_count / misc_count;
>>
>> @@ -270,15 +298,28 @@ int amd_cache_northbridges(void)
>>                }
>>        }
>>
>> -     nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
>> +     if (misc_count_noncpu) {
>> +             /*
>> +              * The first non-CPU Node ID starts at 8 even if there are fewer
>> +              * than 8 CPU nodes. To maintain the AMD Node ID to Linux amd_nb
>> +              * indexing scheme, allocate the number of GPU nodes plus 8.
>> +              * Some allocated amd_northbridge structures will go unused when
>> +              * the number of CPU nodes is less than 8, but this tradeoff is to
>> +              * keep things relatively simple.
> Why simple?
>
> What's wrong with having
>
> [node IDs][GPU node IDs]
>
> i.e., the usual nodes come first and the GPU ones after it.
>
> You enumerate everything properly here so you can control what goes
> where. Which means, you don't need this NONCPU_NODE_INDEX non-sense at
> all.
>
> Hmmm?
>
>> +              */
>> +             amd_northbridges.num = NONCPU_NODE_INDEX + misc_count_noncpu;
>> +     } else {
>> +             amd_northbridges.num = misc_count;
>> +     }
>> +
>> +     nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
>>        if (!nb)
>>                return -ENOMEM;
>>
>>        amd_northbridges.nb = nb;
>> -     amd_northbridges.num = misc_count;
>>
>>        link = misc = root = NULL;
>> -     for (i = 0; i < amd_northbridges.num; i++) {
>> +     for (i = 0; i < misc_count; i++) {
>>                node_to_amd_nb(i)->root = root =
>>                        next_northbridge(root, root_ids);
>>                node_to_amd_nb(i)->misc = misc =
>> @@ -299,6 +340,18 @@ int amd_cache_northbridges(void)
>>                        root = next_northbridge(root, root_ids);
>>        }
>>
>> +     if (misc_count_noncpu) {
>> +             link = misc = root = NULL;
>> +             for (i = NONCPU_NODE_INDEX; i < NONCPU_NODE_INDEX + misc_count_noncpu; i++) {
> So this is not keeping things relatively simple - this is making you
> jump to the GPU nodes to prepare them too which is making them special.
>
>> +                     node_to_amd_nb(i)->root = root =
>> +                             next_northbridge(root, noncpu_root_ids);
>> +                     node_to_amd_nb(i)->misc = misc =
>> +                             next_northbridge(misc, noncpu_misc_ids);
>> +                     node_to_amd_nb(i)->link = link =
>> +                             next_northbridge(link, noncpu_link_ids);
> And seeing how you put those pointers in ->root, ->misc and ->link,
> you can just as well drop those noncpu_*_ids and put the aldebaran
> PCI IDs simply in amd_root_ids, amd_nb_misc_ids and amd_nb_link_ids
> respectively.
>
> Because to this code, the RAS functionality is no different than any
> other CPU because, well, the interface is those PCI devices. So the
> thing doesn't care if it is GPU or not.
>
> So you don't need any of that separation between GPU and CPU nodes when
> it comes to the RAS code.

The roots_per_misc count is different for the CPU nodes and GPU nodes. 
We tried to address

your comment without introducing pci_dev_id arrays for GPU roots, misc 
and links. But, introducing

GPU ID arrays looks cleaner, let me submit the revised code and we can 
revisit this point.

>
> Makes sense?
>
> --
> Regards/Gruss,
>      Boris.

Regards,

Naveen

>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7Ce18fc8abf0da4da621b908d967b4ff31%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654849356966973%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Y5j%2BNctWbWjlpOkQ5DYvDtroWv8MplSBTPgopewm38E%3D&amp;reserved=0
