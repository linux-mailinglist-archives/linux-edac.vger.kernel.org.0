Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC1477FCD
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhLPWF1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 17:05:27 -0500
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com ([40.107.237.109]:8320
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236958AbhLPWF0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 17:05:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGH9dtRjbOxsC2JFrjE9o1oP2S0aSmwuCtcGM1BQXk8wCcZaRbZtay0LuwX0BP1znPyM/hfPhbtE0Z6oztbNWlP3YoF70GZXw80svDo3+T7D/ZUWaD6pkiJOoAN4zVg6qjnBx8SUjlLaUIQjTPtQYUtRgau4/FYU1InIltzKMcKIG/etpwypDqbWT0VRV1/SvYFOJhSeMIFLhCcqGzK/G6gIyW5EufHlgWBm1oPk+Af3EMadPrm7BkyVldZcYlkdyZyWxPaKWAPw6BH1y6i5doXf310Ro6zcok+L/kI2cKPG0cOVSdFTyucl0yPq1BBFwOGwspWklhO1xerPGjgyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWS6uHSJXacYRHNgeCP5729XcNNQ730ntu/Zo5Lw9t4=;
 b=OMBnGDtsitDCR8/y/MYmbCRR5B0dozKoKD1ip/hIe0sc1jck2m23EpkjVyvj+444pSQ76EaoPxWEd2uQcaWZFIvyggVnALMH1YE1Gk+b3b6GLOirnIAC74g82ZjN9CzuDSjjvIeNngdo1Z/RL1ht2dm6B5L6e0XpzBPIB+/4c6daQfBlxQtgTE1T3VqRHsqHPnVePuleWcJSjnXISP1QGDWWAE02T6KEYYJLuqfCEbOLzWZtBqX0fDWO106piOCrYV3N7142ic6bImO6Yyoeji39AKHyuPW43BdikcELBLsFxwP0qzSBefojRUaqzA8ABziWzCBBITwaQPFmL/7nCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWS6uHSJXacYRHNgeCP5729XcNNQ730ntu/Zo5Lw9t4=;
 b=uPpJWmjTCbPI1henuPUSvp4s4HFYTmPH4arN/ogzS6/7r/+bz2LEg59tgFTFFbHAZ3QgOqmCm7sJV44KRRwPV2Qkv/qjcrhxJ5TppXg5Oh/d6sg6jNOGH3KpZ2L8orXWLjxTZ93GPfMhcDrK91I8TlkHixNSjrn42SFVSTujEGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) by
 CH2PR01MB6039.prod.exchangelabs.com (2603:10b6:610:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Thu, 16 Dec 2021 22:05:21 +0000
Received: from CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::c8fb:e830:d7e5:bdf7]) by CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::c8fb:e830:d7e5:bdf7%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 22:05:21 +0000
Message-ID: <addaf134-d5c0-65de-62ca-76950d6460ab@amperemail.onmicrosoft.com>
Date:   Thu, 16 Dec 2021 17:05:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Content-Language: en-US
To:     Darren Hart <darren@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Cc:     Tyler Baicar <baicar@os.amperecomputing.com>,
        patches@amperecomputing.com, abdulhamid@os.amperecomputing.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, mark.rutland@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, tabba@google.com, marcan@marcan.st,
        keescook@chromium.org, masahiroy@kernel.org,
        samitolvanen@google.com, john.garry@huawei.com,
        daniel.lezcano@linaro.org, gor@linux.ibm.com,
        zhangshaokun@hisilicon.com, tmricht@linux.ibm.com,
        dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <87czmpcto5.wl-maz@kernel.org> <YaU6eyGM+bX/bEhG@fedora>
 <87h7bum0xh.wl-maz@kernel.org> <YaZUL+cftvNYgx1j@fedora>
From:   Tyler Baicar <baicar@amperemail.onmicrosoft.com>
In-Reply-To: <YaZUL+cftvNYgx1j@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To CH0PR01MB7033.prod.exchangelabs.com
 (2603:10b6:610:107::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac015fab-da78-4097-a25f-08d9c0e02750
X-MS-TrafficTypeDiagnostic: CH2PR01MB6039:EE_
X-Microsoft-Antispam-PRVS: <CH2PR01MB603987CFC4F118063D4FEE55E3779@CH2PR01MB6039.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OCWa3xx8gONdgywxLHhei2ncrDm+Mw9KxHsYCq5KaibRSAZzRs5XUy1N4NW9RbCGan8wQ0vsk7qfqo01GVGRGz4P1Be6sscRvSpbqaBs0XWq8e3vkybiZyZ3fMtMxAPA9OOD1VKpCKLDbQJes+wdE4MenPu/tstjHcaptruige4vv5mUZ9DZOgZvV+ZL80OJFy8UqhefwcBeV4Ih4TurrPm9V1y3jY6BTtGIH6DyyVDZ2zVkP97tKHsdiSqUkaWg5dsrzUQwK4Okc7T/WGEwFK6lxIxEB5wDklJ+kClresi3Ylz/SrLTy5hhYpVnzVDV5y4fDsueN3Cu88Vpj2r8s0llmWKZdZp72ZlDbjJGVK/a3P47cNZ4mdezo0spmuZJvXbB/46YByR5wsrerI1ajoigpQZml0id7Wuuscq2jFl0bEuhBcTQnuPIWSIow8wC/F/ooWDmvaKD8bcgmJl9940ZUP6OKBbTwRwXcOr9b+9K9XGkI6KkD23M4gkOCdgojLtF41GzpqC+zSqmZ6bZkWe8COtygIoAWnry93AM0F4A32MiUuAVJbv+sXzG54T91ycto88+26tpUQ40CfuExJ+vPdWH/Hz7ZRWrILQDFoSnOBY1BQ+tPW4akJc/oGY5Jag0wIqiY1Iul0vs5LlpjcsryptkvUUdFb0f5QWwqh4G1yqYBaKcAgKE5+fDjcSOevyNy4PbmCK6Hm60WtghU/eE/ydIt28KLzsS52Y1Ir9kmFDAU9eU0z3wt5ZToTQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7033.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66476007)(4326008)(6666004)(38350700002)(186003)(6512007)(2616005)(52116002)(8676002)(6506007)(26005)(8936002)(31686004)(53546011)(508600001)(38100700002)(83170400001)(7406005)(31696002)(2906002)(66556008)(7416002)(6486002)(5660300002)(316002)(42882007)(66946007)(110136005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzlxamdqWlhPSnJwUGswRFZHL0l6TU5CYTFSRW11Z1ZYNlVwTjlQSGt3N0Nh?=
 =?utf-8?B?ZE1LZlNlaG8rV3ZuUVRJZUNrZnBVUTVCZlFvRzQzNVB1NG54VTdmZHZvemwy?=
 =?utf-8?B?RThuaVdjR2xIdndBZEN1N0lIU2NYV3Mvb2VVVEZ1bWtVZU13MkttNlhOSTlJ?=
 =?utf-8?B?Qlh0cnBEYlFIeVdwMlhuVWJ2RjFFcGlReFJucGNTYjRlQ3AzaTBwaDB2cTIx?=
 =?utf-8?B?ZG1pNjdDSnFLdHY2UnE0czBDQ2hnV0JFaFcvWE9Zdi9CK0duOVk5Z1FRMTJ5?=
 =?utf-8?B?T3RPcnBaQlJpb2pTUVlVdWNNTVpnNUc4eko5SDB0LzBVcEtJeEg5WEhYUVZ3?=
 =?utf-8?B?V0Z0c3BOU2drbnlreG01V05RSVZtb0NlZXVtS3hHVEtBN00zZ2JYa2xsVU5Z?=
 =?utf-8?B?aThZMVJRTEVsa0t5T0pHdFhpQTBvYldyRFhzWmh6c3p3U3VhdVA0N2tmcExo?=
 =?utf-8?B?K0p4aGtEdHl5WTllazdER2lRbEZQUnVPcnU2M0I5akhwcHNhSjVtOUNFbVor?=
 =?utf-8?B?N3ZBVzZGMXlhcHdycVI2NHBWZUlXcGRRUDRTM2VRcDVpUHVXZW0rN3A3VWxn?=
 =?utf-8?B?N2VybUNwM0JmN2JaQWNDV0JqQ0xPb05Hb1Y3aGVJUGNUL0FBTWZlay9TaVJp?=
 =?utf-8?B?dnI5VVZUTjJaSWRkUlVNUWFpNUhrVjFoQmh4bkhMRGxoQ0ZsUHBuU1NDZzhX?=
 =?utf-8?B?Ykdxd0RXSW9JTC9vd3ZxT2VmNmlTTmRCZzJPRVNEeHgrM215bkFIK3EzUGdw?=
 =?utf-8?B?aCtCOXdQOVZPV2V2bVFmTExpSzlmd0hRMVFKQUhOdEloaHIwYWdqVUtSejZ5?=
 =?utf-8?B?blp0bkVkSnROc2EvdDB2MCs3bjNZUEEyREpWR0hPb2VGdW9jZHhYcUlvWHNQ?=
 =?utf-8?B?WUwwUnNYVWprSldCdU9pV3YrYzdLTlp5TzV2QUUxL0x1SkFxL3U3dUNmeU9x?=
 =?utf-8?B?MUhLRmVuZFpqZU1DY2g1bVhmVXlaZUI5ZDdUT1JqRmt4bnV1eUFmR01VRGtl?=
 =?utf-8?B?eklzTGdWTUg3V0VUNW9XU3U1WFBXM203WHNkUWpsU0pLOUozcjVyS084RldZ?=
 =?utf-8?B?cXlTdU44NkZrR1JZK1FrK0c1c21yZWxzQmE3RU42L3VXQ05tV0hKSWlWVVBP?=
 =?utf-8?B?eDQ5M2doMmF4ejcxNTgrQ3M0bTlETHhMV2xEQkpEU0VWOERZYWEzeHIrYlVJ?=
 =?utf-8?B?aVJWdlJUeHNxWHhoOWpVYy95eE1LcXRlYWlhUTZ3TWk2M0UyTElnN1FUd0dy?=
 =?utf-8?B?Z1JuRmsvbnZMTGZvTDJnWlJMM0VOa3R4eGRVUFhETDM0dGVlMi8vUDdjWGIw?=
 =?utf-8?B?cEhyRmI5ZzNHcFVtWVNsSStyUEVOT3dKT0s4UWE0eFhoSXg4K3NaSjc2OUFQ?=
 =?utf-8?B?TE9GZ29DaG9lYjFIdWFQalBDeno0TmdXb2lKaHd6Tmc1d1dkTzM4SU56ZExQ?=
 =?utf-8?B?cHNIWVNXa01qeXh1MUpXcVVlNUVOS0VPRHFadWlxZ0pMT0swYnBsL00xN3Vi?=
 =?utf-8?B?aHV4UmRhd3BRbXk3U085U1hrVXFnZ2Ivb0VlYy84ZXg2ZWdRd2d2M2VLQ1dm?=
 =?utf-8?B?NnhxK2VTWFlsemlBTUtxS28xMTE5cEovRlU2Z2I2UXJ1ZVlNUjRXajRIYjh2?=
 =?utf-8?B?ZmNFSFFzQXlLSWJxQ1FlZ3N2YzBXMzgzTGNDVlJFQWtvYldDa29zelo0NGJ5?=
 =?utf-8?B?STYzMWl2MTh3aVRRTVJmTTdIRnRWeU9wUjB1UzVuYjQ5WW1MU2ZIbGgzV0pH?=
 =?utf-8?B?TmFEWUozblRsZ01UdXg2eVRxcGY2Qkk1QkR1SUkwSTFpTFRmcDlJbGRqaXdF?=
 =?utf-8?B?d0V2YjJ5ZjUydW5BMGlBY1hVME5FdUIyai90cHdWUzF6c2MzRGl5SHZqTy8y?=
 =?utf-8?B?NGRSSDM2MlVMR2ZkOVJYcGRCQmR2cFhnenJyTHRYZ1pXMDVnYWJET1V0V1hE?=
 =?utf-8?B?THgwSWFHSWpxcFlRdVlEKzA1bDlRcDZJU1lQdUdGWGxKNnovYVZkNHdQRFZi?=
 =?utf-8?B?empmSXZxL2dmbjZ1bUx3L045dWNsRExSZ0p4dzk3WlZjTFNUTUpFaFd3Zlkx?=
 =?utf-8?B?NVlBQU0vNE5GdTlZdmtPMXM1UFk3Ly94Q0JYUHdBNE05ZXUwaE1VM01OMEhS?=
 =?utf-8?B?QUlzWFN0Q29UWWRTc1NndFlXRDVVeHhmUkl4aVg3NG1RcW5FdXkydE5EcEtE?=
 =?utf-8?B?U2lOUWZ6cDlHdGVHam9LVXY0b2E5dVhrUVkxcUhaWm95djVYY3hMT2FDSDZy?=
 =?utf-8?B?d2lGOEFzcnNxMXYxZjVzQ0VCSlowZnpCT0VqdHFGODlPcjEvczJ2ZjlGK09O?=
 =?utf-8?B?dkxTaldYTzFsYXFDY0NycWlSRVJBczdBblg3RlpSaVB3Zkhtb0xsUT09?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac015fab-da78-4097-a25f-08d9c0e02750
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7033.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 22:05:21.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i7FfdJfryjmneEQpSuZMaEBYxYixbtcKimg9v6lPSCnD+A+9yu4uso9wFzo6216VhT4lMz4Sxt2EXGAI7keA/IcINQsb+azh7+9H1btFWc08vd41FVkUGW7elP0ELsg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6039
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

-Moved ACPI for ARM64 maintainers to "to:"

Hi Marc, Darren,

On 11/30/2021 11:41 AM, Darren Hart wrote:
> On Tue, Nov 30, 2021 at 09:45:46AM +0000, Marc Zyngier wrote:
>> Hi Darren,
>>
>> On Mon, 29 Nov 2021 20:39:23 +0000,
>> Darren Hart <darren@os.amperecomputing.com> wrote:
>>> On Wed, Nov 24, 2021 at 06:09:14PM +0000, Marc Zyngier wrote:
>>>> On Wed, 24 Nov 2021 17:07:07 +0000,
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 5250298d2817..aa0483726606 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -382,6 +382,7 @@ ACPI FOR ARM64 (ACPI/arm64)
>>>>>   M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>   M:	Hanjun Guo <guohanjun@huawei.com>
>>>>>   M:	Sudeep Holla <sudeep.holla@arm.com>
>>>>> +R:	Tyler Baicar <baicar@os.amperecomputing.com>
>>>>>   L:	linux-acpi@vger.kernel.org
>>>>>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>>>>   S:	Maintained
>>>> Isn't this a bit premature? This isn't even mentioned in the commit
>>>> message, only in passing in the cover letter.
>>>>
>>> Hi Marc,
>>>
>>> This was something I encouraged Tyler to add during internal review,
>>> both in response to the checkpatch.pl warning about adding new drivers
>>> as well as our interest in reviewing any future changes to the aest
>>> driver. Since refactoring is common, this level made sense to me - but
>>> would it be preferable to add a new entry for just the new driver Tyler
>>> added?
>> Adding someone as the co-maintainer/co-reviewer of a whole subsystem
>> (ACPI/arm64 in this case) comes, IMO, with a number of pre-requisites:
>> has the proposed co-{maintainer,reviewer} contributed and/or reviewed
>> a significant number of patches to that subsystem and/or actively
>> participated in the public discussions on the design and the
>> maintenance of the subsystem, so that their reviewing is authoritative
>> enough? I won't be judge of this, but it is definitely something to
>> consider.
> Hi Marc,
>
> Agreed. I applied similar criteria when considering sub maintainers for
> the platform/x86 subsystem while I maintained it.
>
>> I don't think preemptively adding someone to the MAINTAINERS entry to
>> indicate an interest in a whole subsystem is the right way to do it.
>> One could argue that this is what a mailing list is for! ;-) On the
>> other hand, an active participation to the review process is the
>> perfect way to engage with fellow developers and to grow a profile. It
>> is at this stage that adding oneself as an upstream reviewer makes a
>> lot of sense.
> Also generally agree. In this specific case, our interest was in the
> driver itself, and we had to decide between the whole subsystem or
> adding another F: entry in MAINTAINERS for the specific driver. Since
> drivers/acpi/arm64 only has 3 .c files in it, adding another entry
> seemed premature and overly granular. Certainly a subjective thing and
> we have no objection to adding the extra line if that's preferred. This
> should have been noted in the commit message.

Thank you for the feedback here, I will make sure to add this to the 
commit message and cover letter in the next version.

Hi Lorenzo, Hanjun, Sudeep,

As for adding myself as a reviewer under ACPI for ARM64 or adding 
another F: entry, do you have a preference or guidance on what I should 
do here?

Thanks,

Tyler

>> Alternatively, adding a MAINTAINERS entry for a specific driver is
>> definitely helpful and will certainly result in the listed maintainer
>> to be Cc'd on changes affecting it. But I would really like this
>> maintainer to actively engage with upstream, rather than simply be on
>> the receiving end of a stream of changes.
> Agree for subsystems. For individual drivers, I think having the author
> as a reviewer is appropriate and should result in more patch reviews,
> which moves us in the direction of more community participation which we
> all want to see.
>
> Thanks,

