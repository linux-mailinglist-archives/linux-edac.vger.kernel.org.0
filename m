Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3003473BC1F
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjFWPyn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFWPym (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 11:54:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8672129;
        Fri, 23 Jun 2023 08:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDZRxhxAgRQykwB0tj9z1adTsbub4B08DmEnJLYIlOcEhRr8MKFNoeNQiMdZUnyANpov9x+cR+zaJLUEegcWt2q2MJfQNepq0V3GKFXWVAK+0D3bFw64VVVQpdcZu/cmlVdONm5yVODSJrhu/w8imY8kEufzBlwtiKJY7o1MlAdqdMWTEOnQFGADDsh1ChLaY9DhMddwBd+n7U0R8wZ0lNamfB8ZLR4xViqIWxiWnLae1usgafrIojMej28cUgZQyZlhidNqDswIGUMbkeUygPmasuTzfD3OpUk4sao87pl8rZOm9/BjuhT7rFAg1gxrqCpKTaGBRKgWIsOoBbl1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL+1cZoKc/CMS2pTa5Ll/oxj6AO9DAH+Fjy1Bpajsio=;
 b=ILt+wixt5zZwOp3SpWtqiCx7A2fQ6kc+8TspQrhi0DHhDSMY2oHyT9Rbi6v44v1xr9Uai9yVoyK2lkCv7Ke69kZHJzaLLRQqLNP4xrdqIVjer5Kw/ChkiqydL5HhvD5uot45ZmhWtyFjx4fywXunXZbCBtIfXoOAcTsU89eJCTMSmukRGbgyFxoKz6J0zLO3dJUPH1ZsBej5a5oIvZAr7ksl32XyCF7G4ADt+84uFeT1nwq/DMlj3cWvolGSxJg13gm2vLnhBDlegLizMh7KWrftMJkyjSPa1cMxLKNqhv3YWTxFEr4qnHmxc54tKsT5T8OxqIwGYDUdhmE+1YzRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL+1cZoKc/CMS2pTa5Ll/oxj6AO9DAH+Fjy1Bpajsio=;
 b=gBOgtQFDEe4gXr7Ung7PFdZdRPjqtP7BS17YoVKTnhF4NCiPGQuy1mICz3jw+A+38MZKH67a2wH2nzWt73ldiZ7BZbTj3xS3kFJ2obo8ADo8tmmHYkhmw/5QOy2m5jYXZT0KD/cnLDAMGemzXomDiLzPq9SRgxsYBqR4KfwX7tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 15:54:39 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 15:54:38 +0000
Message-ID: <04c921ad-e651-e1fc-a3bd-8c40a77a4ea8@amd.com>
Date:   Fri, 23 Jun 2023 11:54:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, Tony Luck <tony.luck@intel.com>,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 3/4] x86/mce: Handle AMD threshold interrupt storms
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
 <20230616182744.17632-4-tony.luck@intel.com>
 <20230623144542.GBZJWwFvA+1uXC1A1g@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230623144542.GBZJWwFvA+1uXC1A1g@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e94b71-977c-4b4f-48e6-08db74022658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJaNIoYqC314aJYR7VV/D0QsMHZYPW3qqsnwP6JkBZXvVQbHJscxSeOTM7POSYqIA8gFcgvm7l9LqTS+2/DZHHUmlgo79ufqivQR0yV7xnyBsBrKNnMAX56fe2QdTeBsHpM1KWqhpMcP4nVv9YDcH7RqJvWMAhB7PFMNl6gF3T9+86UBRnkcoYZ6U3LHSaxhhj6kqJDLtvlaapUSBz9LTntOwYPqrD6aESXRLpHTC4Ucx1D2PxAECEKDrYtC4KRWOouSnPn/H6SmqcHCx9Ere0sbbypSlcg6HskRDp7QvLTowZvjZtXsyCwm+TN0Igl5S+9Uw1zW/H4JzKWMWMDQEyft9JtCbLL7TnNIVVS6t0m/bjOiMlBA7gfjdnhAkOcapuXdDJ/cLkkW5G4lEAeStVvpbeiGpijnn4x4fmTb+E8UxnSVRWdcnaqWE2RzB55xKbdDOhuv7GqRmGWP2z3krX0/qySNbL3q3yzXlc/YszXrfXRWaTz6uXALhNKlVNgYh8KuBxBrFVHUZWmF5C9Z2PkppnM8BGeZA4xzx16nR54tYG+9ZSTxRhAAXqAOrw10o/0QuAhRlbOaVLTbhJp8HVegBWc31BkPSTcPrV9jslfKw9wJ1oOtlJoGveqvgqjIp5nKTahYrpR+ol6Ncd1MfWm51RYx+NpW4ZX1WHFB3j9BKZXkTv7jHxfru7/nWh6/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(44832011)(5660300002)(36756003)(8676002)(38100700002)(2906002)(478600001)(186003)(6486002)(6666004)(31696002)(86362001)(2616005)(83380400001)(53546011)(31686004)(26005)(66476007)(66946007)(6512007)(6506007)(66556008)(316002)(4326008)(41300700001)(6636002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzN1dTdHUlVIb3EySXZ5aWxucTBraDdFeDJWaFRsTjAvM2RoOE9HY0o0WVdq?=
 =?utf-8?B?bENxQ2ZSUE50QnJ2UmVqaWRsTmtWUkJMbmFsZEtBcTB0dTBtclFTZEFZRTB1?=
 =?utf-8?B?a0xRWWIxOWxNa2hBRHdZL212TS9VSm81UHZaclZPMTRJTFlKblBRbGpmSWNh?=
 =?utf-8?B?a2gwUUFUc0EvVlB2cGoxTkJNVUJiOXlvUzJsQVZQd0dWZEh3NmRsNHUrTnl6?=
 =?utf-8?B?em5peCsyMlpnZTUrTVNQclp5U2xyRHRNQ1JKL05wR05McjUwMC90TThnT2xS?=
 =?utf-8?B?M3IzQU8waGN0dnpXZm1VeGhuSjUyRnpQS0FBSWo3QmlXMEM1QjlGcWtRM0lq?=
 =?utf-8?B?d2ViS0w2NUZFb05CK2Fpb282eVBwc2xBeXFOallJNWcxUmV6RlZIa3JCM1A3?=
 =?utf-8?B?ck1DVitLcVRzVi9WVjVpaGIwZXRlZmVPOHM3bWNuNTYvek1xaVY0SDZhSW13?=
 =?utf-8?B?d2NBMTNON1dZcDVUYzVxcW5JMHVRbktqWHRtdkhscFFURytCaHdId1c0VlRm?=
 =?utf-8?B?ZXVHZ3dYc20rU1crK2hDSW5KRC91a25CTFZLR3lneXJHWUJ4UGQwZmdBTUZP?=
 =?utf-8?B?WjZ3RkxKMzZsM2g1UVlvNkVCczM3MG84T0dBdEFzOTRlYm5SSDNzLzNwbFVE?=
 =?utf-8?B?U0ZzNm5WMXNkTmJObEpwVmtGR012cTR4dWRoRTdZbG91VElvbFNJeUEwVG9s?=
 =?utf-8?B?L1hIbFY0dVJvMzNiRk5GaWJCb2pSVE53TDF2TEkwR2J5OFZSa1dleEl0aDRY?=
 =?utf-8?B?c0hCVnpyaUhreDY2VjMvZGNQaGNsemh0NWlGaW9XZ3NLaHFvWGhVdlZ3YS9m?=
 =?utf-8?B?OHg3RjNXUEduOHRXYVZoeUFnb0FsVTJPUFduQy9uQlFBZ3NMUlU4ZVEvRm1w?=
 =?utf-8?B?RE9ZdEZnRnRhK0YyZFoxcFppVVpNU0lhUUk3RzN2WUxwUjBVeW56YTZEcUc0?=
 =?utf-8?B?ZlZqL1ZtNXpNNlhXZ2ZDL2VCZHNvTUNXUk1nbTFDQTJIL0hvTDhjb3lGYVhC?=
 =?utf-8?B?ajhiNkpQUGNiOWpkVWQ1QjdTc1lXY1cxdVRkMTlNNU4yK3V3UlhRQ08rbmsz?=
 =?utf-8?B?dHFLVmFobjlvR0Q4c3BKWk5PVGdFcW9QS1p1bGtPSDFLRzZNbERLWittQ0lk?=
 =?utf-8?B?NnBCc3lNbHZMS1dFMFNjMG94NS9PUFpqeGFlYTJTK21HelRUQk0xZ3ZMbXdv?=
 =?utf-8?B?ekI5OUpPbDNjZTZna2VXQ1lVUEtEdmdJYnpPeUt6QTNWVDNsUEQxM3FaaklT?=
 =?utf-8?B?WjNjb1lqSGZYbVhXVUFUZFV4TnJ2eS9rTXdVZ0ROSE5lVFpQUzNPYmxpL3Bl?=
 =?utf-8?B?aTNUREVDUGVTSU40cGJScUJiYVJ1MkRQY1hWaHorelVtcDJpNnpvcDU3Rk94?=
 =?utf-8?B?WkJQMStjb3FMT0VJMjhyNkpnd0JRNmRWOC9KQXN6UUttM2pjMEJXNy9ncWpw?=
 =?utf-8?B?bU9zLzBOV3Z2aityamtyczNnYTIwdVJxUzdPdHcxZGY5K0sxZzl0aFltRlFU?=
 =?utf-8?B?QmlHYThmejZCd25NNXhVa2JZdmcrM3NPbUV3VVlQSnp3SU9CRnFRcHRoMG5I?=
 =?utf-8?B?RzU1amVMR3NaWEFwQTJlZ2NyS0pBNUdVanNLMDdTdGc4RmZJempJckFnUWVF?=
 =?utf-8?B?ek1yTVlDSFZHTnJQazJ3SU44V2w2enlBVXJRdlJGN2h6Z2JzTTMwQjEvRGhR?=
 =?utf-8?B?YnRaU2xKNmswTnRQSlI4NW12ZU1VQ0o3UTVpYWhHdXUyRWt2UFoxaWszYUVB?=
 =?utf-8?B?VFpFM1pqWWR4dUFQbXdUT1haOWNQeFVlUmgzd0ZyY2pHQ0l3UE1SZDZCaVhn?=
 =?utf-8?B?S21HUXlZQ2lKMFppT0VCVG1CMGw5VC8weXgwTTJJYytreWkwT3pIV0xRSWxY?=
 =?utf-8?B?S2VPWW9oSkppV0cvRGZQZmxJRHFuelMveUxGenNpWDRKSmJuWVB0MTNKQlRE?=
 =?utf-8?B?TVB5MllpcVBoV3BHQm5vT043RS9ESGJ0MTRZTEpORVg3UHRYQ1A1NmNhT0tD?=
 =?utf-8?B?WmhaRWVsM2MxZVhxbDMxb095UGFkSXhSNHJHeXBjSHprM1k2bUxvNTJoYm04?=
 =?utf-8?B?Tko2cnFaa2dIeXY5VTBCd2V3K3NLampMWmcyaWxYVjRCS0JLNnlGMWhPSVlu?=
 =?utf-8?Q?UJBkGeEbf6rZhUVtTwOwc8lg4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e94b71-977c-4b4f-48e6-08db74022658
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 15:54:38.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5OPTDc8qyXBfqaULvqe8rkBUIlqLTqYw8Oknn9qxSFor/FipGVNOjfzZMqgMlsU2KocY7fUnw7erFla8arsCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

On 6/23/2023 10:45 AM, Borislav Petkov wrote:
> On Fri, Jun 16, 2023 at 11:27:43AM -0700, Tony Luck wrote:
>> +static void _reset_block(struct threshold_block *block)
>> +{
>> +	struct thresh_restart tr;
>> +
>> +	memset(&tr, 0, sizeof(tr));
>> +	tr.b = block;
>> +	threshold_restart_bank(&tr);
>> +}
> 
>> +
>> +static void toggle_interrupt_reset_block(struct threshold_block *block, bool on)
>> +{
>> +	if (!block)
>> +		return;
>> +
>> +	block->interrupt_enable = !!on;
>> +	_reset_block(block);
>> +}
>> +
>> +void mce_amd_handle_storm(int bank, bool on)
>> +{
>> +	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
>> +	struct threshold_bank **bp = this_cpu_read(threshold_banks);
>> +	unsigned long flags;
>> +
>> +	if (!bp)
>> +		return;
>> +
>> +	local_irq_save(flags);
>> +
>> +	first_block = bp[bank]->blocks;
>> +	if (!first_block)
>> +		goto end;
>> +
>> +	toggle_interrupt_reset_block(first_block, on);
>> +
>> +	list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
>> +		toggle_interrupt_reset_block(block, on);
>> +end:
>> +	local_irq_restore(flags);
>> +}
> 
> There's already other code which does this threshold block control. Pls
> refactor and unify it instead of adding almost redundant similar functions.
>

Okay, will do.

>>   static void mce_threshold_block_init(struct threshold_block *b, int offset)
>>   {
>>   	struct thresh_restart tr = {
>> @@ -868,6 +909,7 @@ static void amd_threshold_interrupt(void)
>>   	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
>>   	struct threshold_bank **bp = this_cpu_read(threshold_banks);
>>   	unsigned int bank, cpu = smp_processor_id();
>> +	u64 status;
>>   
>>   	/*
>>   	 * Validate that the threshold bank has been initialized already. The
>> @@ -881,6 +923,13 @@ static void amd_threshold_interrupt(void)
>>   		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
>>   			continue;
>>   
>> +		rdmsrl(mca_msr_reg(bank, MCA_STATUS), status);
>> +		track_cmci_storm(bank, status);
> 
> So this is called from interrupt context.
> 
> There's another track_cmci_storm() from machine_check_poll() which can
> happen in process context.
> 
> And there's no sync (locking) between the two. Not good.
> 
> Why are even two calls needed on AMD?
> 

I think because the AMD interrupt handlers don't call 
machine_check_poll(). This is a good opportunity to unify the AMD 
thresholding and deferred error interrupt handlers with 
machine_check_poll().

Tony,
Please leave out this AMD patch for now. I'll work on refactoring it.

Thanks,
Yazen

