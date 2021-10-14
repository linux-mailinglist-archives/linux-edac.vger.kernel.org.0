Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336F742E2BB
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJNU2X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 16:28:23 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:29281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhJNU2X (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 16:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCQFtKhdDKVG2yIcrahGL57Gc4xMgBF6tQc7G+emukSayHSeDuPRpx5sbo4aw6XgoJMAuNPbEa05pJ+bR+Voaw/EnAXPyKAT1D+VoKbukTHaDE22WMe4W2L+E8EMeUJWjrVcLCpUjJjNuFgoxOkXx2lRsvElyUL7n3y2zlrirTfOgiLydpkq+6xk8kLxapfREP8HbI1b2E0qj++MuR1y49ORJOgB0/+jOBKs4a7LcEsEuKUQQcg79PEOjT0qapZfU1Wrwr3hC6itokZZU5tPA9VibDknpcyzQ32MB1VAFQCzLtPUp5XHGWhbPYEf0fRwcnALEkLd+/2EPrO2L0jIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58MVwMHibzj+BN5n5w6wBuUv2kXaztj+qMQL8/BhdDs=;
 b=BqbpIaNEWAt5CiH/BSguGpTwGc+8i5pT9RDELPF+RfARYfBy1hd+EVj8+Quk6pzFMhgVUbU970uLWso16ymY/UvA+ssIErVWhRO9MAH8JobWs8K7mbGxC9RzNeQpfVNyvpDWN4br/LlzkViqFz93WglBz4SkdAUUeRtpvAVLhCVdKhe8AeP/2VyUX6umuIbompZrkEqoDGhi4DELYYU9vsar/eACYrkL4+n1mkn4YGEQHZjiFPn5YI+QcL+muqFb0kGk2HRtiU7B9bqzBkBVNxpA5ozW2p0YQxHcwgTmonDWmHhPrdJW+jGOwbCoMJynj+70U1LY329RMoQOnGjshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58MVwMHibzj+BN5n5w6wBuUv2kXaztj+qMQL8/BhdDs=;
 b=zuKjdBKg1DQlAK97zZwMO5HpdummYDJiid+wyTeCKi4/aajzbb8EnwJUJibrErIfeblDBWFqsXac/MxFpjKsp4yslvpWGljSUuVH0sJoIsviEO8WBlTQn2CS0d9KmL2gvp8IMzgm/Q8Zw4myss/auz++ZTD/ptyqjewEXbE81HI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB4792.namprd12.prod.outlook.com (2603:10b6:a03:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 20:26:16 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4608.017; Thu, 14 Oct 2021
 20:26:15 +0000
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated before
 error simulation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic> <78bec0e8-a64a-466c-4245-2386de7db5c9@amd.com>
 <YWh1bc6Lol65f0RH@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <f6b6b66d-0e6b-e64a-9c97-4e067610a3da@amd.com>
Date:   Thu, 14 Oct 2021 15:26:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YWh1bc6Lol65f0RH@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:b0c5:2a88:fcfb:f402] (2601:647:5f00:2790:b0c5:2a88:fcfb:f402) by SJ0PR13CA0098.namprd13.prod.outlook.com (2603:10b6:a03:2c5::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Thu, 14 Oct 2021 20:26:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c96abb-0b1d-4920-9daa-08d98f50df3f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4792FA49FF110AB8072F5DC190B89@BYAPR12MB4792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gTFtMYgYjXqEpyPzfW1AhNuWzaSQPO9j9qxy2K/c7ReXufo2rUzHQl8jlxEwYyT6hPMUGKWQzznLPI6CvkhSKrvBeYTzsZJCVrlzTkmKMJObGqTGlApZa8EWjOHItlW7b9ETqfo9kAqusLB2HyeH67XxWfHJ1wECyUrf+7BzYsDTabxsxQD/jvw05ZNfGPMtQTWfFaEXS79K6NR7UFiPsGJEQ5inFHji2UFTBXATPtjRGf2t/zzpTr5+V+9AYmNHU8FmeTuBzvT9L6C1uVzUjrjkLzSFyXezh2QIvXjXhya5NLhrMJZ/U0VfDMhXCV1Xg7Ty+Vr4E/XE/YPkmOecnSdsP9Qh4TfL09lJRGP4d24uZCpy9HBQtP3eSE45r5FiZFEAIZAa2mWMjIt9Z2TF95TAGYbZ41PB6IHyo7Ld19UpCutj1uhMD357YwyozdEIditMioRX4dkyXMLsovfg6oiz/jlQbgSomct6CN2SpXo06WZOuz69HB6eBWyfZYBuOPxDbsd5pdbtWk875TRpd5kcL7UslfrLe2MO1EQXM0opQrzf4Z9rysVi2isCvSeWHeQ0ui+a5/y/N8nAkSKl+0eBCptWoaiQbFTmJO7sU5zerPjydnzWjthW9+jy7mbduE0aaYXpLxQggDkJKlZs4b5dtoTJN2OVW9yyATfPwKHvnqcigRXXazBSkb4W7VfIhu1QHmPLi02qnhZdwnFVGuhnkzWxYwgw6xliQcGd8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(186003)(2906002)(15650500001)(316002)(6916009)(508600001)(31686004)(6486002)(5660300002)(66556008)(83380400001)(31696002)(8676002)(66476007)(36756003)(66946007)(4326008)(38100700002)(53546011)(8936002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZPL21XZHBxeG12dkxwVnpnclhnTEZwQ202K0t3bzhONUh2RnFHYnVVTi8z?=
 =?utf-8?B?RGhVNkhwam9wNTVkS1B1YUx0UklKTHpXM2FaTEFmeGxNcnROUG9tYXBDMnZy?=
 =?utf-8?B?N0krd0xUV01xNkpWV0pMVXdacUoyVm8va1FrdHZET2MvZVkrRzhneWQ2cGVz?=
 =?utf-8?B?OVZQeEtzZkovNkF5UTNFclByY2tVL2ZqUlFSOEFTbDhvS2hOVlJIYXJlQ2lW?=
 =?utf-8?B?L0E3bXc2bTgvV1BPbDQxVXphNWFXUStZUHd5TmtqdFpCVldzcEUzYnJJeGNB?=
 =?utf-8?B?REdvL0JiVmVBL3Y0NmZLTnhNdlE0aFY4YjhGS25IbFJpa2diUk5LTi9pSXF3?=
 =?utf-8?B?UlhBZzQ5U0I4cTBFZVcxZGNtbDBHYzJ3bVRxQTJzTC9QYUVDeklEVmdwdk5P?=
 =?utf-8?B?UGpleFp5bXR5dkovcE91U01UYzN4Z1RyeXBoU0ZpQlYraWtoOFowQ0J2L2pu?=
 =?utf-8?B?SWsxYit4V0o2WndCNWN4a2ZiM0R4SlpWaE1lMmxxVE85NFBiaUNwRTd0Wnhh?=
 =?utf-8?B?SitLdENNME0xVEJ3T1Vab3RWczVkR0E5RjJMbGl3cjlZa05oRXpYL3dSdXRy?=
 =?utf-8?B?NDdBaHdVdWF3SkhpUG1LaXg2SlIwWExmaUVTWTgvaG9MSGlNRXVNRUYrRlpl?=
 =?utf-8?B?V1pGcjUzSHd1SVFsSGN3R0MzZ0FaNGdXUjFyYmE3dkpCWW1ycXBJY3lDWTMx?=
 =?utf-8?B?U1BtdDFoMmlrNVhEeGdzeklDS3hrM20yZVNQYTJzRitVeGtkYjRKREVScXBu?=
 =?utf-8?B?NjVYTThOdlNQT0pGMkVDbzF1ZUREaGhGS0FJUGkrbnZzc1BIeDJnWGxmVU5x?=
 =?utf-8?B?cDlaeFN0TWZ2VjFSS1VLWGhSZG1BcFpaV1F6TDgrYVNPV1FiZTZMWVNCbmdR?=
 =?utf-8?B?QTdsN0FsZWdPTWc3QThLd3FHdXJzSi9EamEvem56YTh1V051NE93SVVKSm5q?=
 =?utf-8?B?eWoyT1Q3eFFiOHBBa1J5dFF3empMMStUM2hVRHk2bGU0T1ZOUzNVcEV1TUNT?=
 =?utf-8?B?UjZjMjZHRkNOODJkcHU0NE5NZmVxb2tycm42c2tFQmN0ZE1LZ0Zpclllc3dq?=
 =?utf-8?B?bVQwZGZsZkdoV0UvbTQ5bkZlT2k5ZkJ2d25EZ1B2UTg5bGZzY3dicUx2dldO?=
 =?utf-8?B?cmYrUGFGYnQ4U0xFZEt4R1lPN1lUNnAvUGdveDZ4V2Q1R2FpVGFwWCtmK0FI?=
 =?utf-8?B?elN0djNYNHhSWjBIeGVBa2p4VXE2ZitFTWhVWDRUTkhpbjQ3enRHcDhQUHpm?=
 =?utf-8?B?SGlkKzI5OHM0SnZBSFBNUFB4VmNvUVVtMklRb0hVNURZQkg4c2NrS0UwakJu?=
 =?utf-8?B?RlR2TmFjSnhYZm5QNzdtQWNhQlJBWGtWOVdKRHl2S2JzbGhwU2U1WUlVeVV1?=
 =?utf-8?B?QVRMZzg0REIzVHZTN0R1V3RoZWdPSmhoNHBIcllLNnhpeldIUXE2WkRGR25R?=
 =?utf-8?B?T0tvYWxOci85WEY0TXhqWDl1allFMnByRzZWSW1rMUJlUzR6WnFOMXFBS3J5?=
 =?utf-8?B?S0RDT3U1VGtYS2xFanMvRnk0cUpuMi9NeDk0TDJtRjNtRHdCcU8wc1ZDczdT?=
 =?utf-8?B?WVhuQWY3Qi9ZMDVkWWlDRGJBS3FjbWVlbTcwTENqaFVpNlVKbGVvYXlocm1k?=
 =?utf-8?B?ZWZiTkVGVTR1WkxoOXF6N1VmbnA3YzhGbDhzSjdFbUtSeitsQXVUQ1ZjemIr?=
 =?utf-8?B?NHhuVFdIaVBMbjFrY2gxTms0SVNFL3M1QXVPRXpSWkNUaGZ3d0VaNE95MlNQ?=
 =?utf-8?B?SlJsT3phSUtvQ0tla0cza3JNN0FEUUxSVHNsTWMzMFdYU3Q0VU9vU3pzWUNP?=
 =?utf-8?B?S3FrZ1l3K1dPZjVGL0lHOG1sMVA4VUtWOFFKOXFnampUaTJweGErdDV5WlVW?=
 =?utf-8?Q?+0D2RnOTbNnh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c96abb-0b1d-4920-9daa-08d98f50df3f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 20:26:15.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/GmsZinSjVgtXZIBoAnUqYx9cEYtVAa12JqX6QnQDoHKDDjB3PEr73W2wd6M7+3HUV3HqrLNoV19cqdC48XMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4792
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/14/21 1:22 PM, Borislav Petkov wrote:

> On Mon, Oct 11, 2021 at 04:12:14PM -0500, Koralahalli Channabasappa, Smita wrote:
>> I do not have the bank number in order to look up the IPID for that bank.
>> I couldn't know the bank number because mce-inject files are synchronized
>> in a way that once the bank number is written the injection starts.
>> Can you please suggest what needs to be done here?
>>
>> Also, the IPID register is read only from the OS, hence the user provided
>> IPID values could be useful for "sw" error injection types. For "hw" error
>> injection types we need to read from the registers to determine the IPID
>> value.
>>
>> Should there be two cases where on a "sw" injection use the user provided
>> IPID value whereas on "hw" injection read from registers?
> Right, that's a good point. So the way I see it is, we need to decide
> what is allowed for sw injection and what for hw injection, wrt to IPID
> value.
>
> I think for sw injection, we probably should say that since this is
> sw only and its purpose is to test the code only, there should not be
> any limitations imposed by the underlying machine. Like using the bank
> number, for example.
>
> So what you do now for sw injection:
>
> 		if (val && inj_type == SW_INJ)
> 			m->ipid = val;
>
> should be good enough. User simply sets some IPID value and that value
> will be used for the bank which is written when injecting.
>
> Now, for hw injection, you have two cases:
>
> 1. The bank is unpopulated so setting the IPID there doesn't make any sense.
>
> 2. The bank *is* populated and the respective IPID MSR has a value
> describing what that bank is.
>
> And in that case, does it even make sense to set the IPID? I don't think
> so because that IP block's type - aka IPID - has been set already by
> hardware/firmware.
>
> So the way I see it, it makes no sense whatsoever to set the IPID of a
> bank during hw injection.
>
> Right?

Yes, I agree. inj_ipid_set() can be used to serve the purpose of setting
user provided IPID on a sw injection only.

My concern was, we need to determine whether the bank is unpopulated or
populated before trying to inject the errors on a hw injection, for which
we need to read the IPID MSR of that bank.

We cannot do that inside inj_ipid_set() as we do not know the bank number
until inj_bank_set() executes which is called after inj_ipid_set().
mce-inject files are synchronized in a way that once the bank number is
written in inj_bank_set(), injection starts.

So this snippet of code:

if (inj_type != SW_INJ) {
	rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val),&m->ipid);
	if (!m->ipid) {
		pr_err("Error injection not possible - bank %d unpopulated\n");
		return -ENODEV;
	}
}

should be retained inside inj_bank_set() ?

And inj_ipid_set() should just set m->ipid = val on a SW_INJ as you mentioned
above?

Thanks,


