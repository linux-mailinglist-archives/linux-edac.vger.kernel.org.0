Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9424F5413
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiDFEHs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572955AbiDER0f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 13:26:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AEF1836B;
        Tue,  5 Apr 2022 10:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLsXPd6y8WlOXmyFuZNVBrFYJAZiO0hg3ChTui3tWSKFuW+BZHJNiUEeNXLktOtRyuiXuJArbAUTxpZdPVt1ZPQva4pU9ax/QuKbE4xr7Vu2bX8Y1kJtNBuYuIlRP9A3osRA1ib03ga1l8CnxoVhTohdQNH6zqcaAd4Uo08nJzMdrtkUkeLcmoYgyWEpJ8VqwhVF6fL3wLTaq/iZrggKcYq0dTllM2dmmjA0AbhVW2boFcJ55kcVbez5z0pEAmvSL01zS8/V2RIIyCafeNEE8IZ6zjvZTUoTHKXSDxQGjvHs3XTpoIIYmtBZ+ULzvlJm82RHX6Uexk5jB+dI0scsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP1Ba7GxvkPuk/p/miwdq/0KcGTmiF9Z7XIl3LyAozs=;
 b=WJLOv9pqTP/zycjt2Tz1k7ktcB5ywBW/4DuG/WdXD1qE4MFJp4slSbfA2iw0t5HgCjLG+A1xM26xX618u6H6O6IQ+EQ4lk8Q6hqHVtF6rk8z5DD9ziQR+BsKLcezXSMwhVlEPVhnXeVXJrv325NzZdsbmXkpMua2oj7tlGH2UBVEM405Fvz/kFJdlZ6NsO8PLpg61F6KYNBrsUAwwjclE/u5Ag2ZzgG0CoZAIS/7/mVKUvrkFfeJk7dW0+JjLlPpjfJpMOHtQ/iOgEvnrRv0k59XnopzyaqeYnAdOOez2zl/bXHe8E+YhYuL4syBanOcommzHUe/fB3rPl6YFyCvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP1Ba7GxvkPuk/p/miwdq/0KcGTmiF9Z7XIl3LyAozs=;
 b=WzVaSQaizisz5pJuUYhG4Ao9pD6UnzgtK59UXRw0BOS5b5a++J70Ronm1PDzxYBUUHXjFdJ+cgpxkv48pV9pwYMtCKo23hr6rvwzopJp1rEbQCpCAQ0bSFdYDEODmTimfWI1HQ8jykQBLESLrPS1+bTjTCWzNcz/fJ1wZjkgKVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:24:33 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::981c:a9e4:48c:e82f%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:24:33 +0000
Message-ID: <ec7dc7e7-5808-58f8-cbe9-d8fdd2de4c35@amd.com>
Date:   Tue, 5 Apr 2022 12:24:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] x86/mce: Extend AMD severity grading function with
 new types of errors
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
 <20220331163849.6850-2-carlos.bilbao@amd.com> <Ykx59WvoWKi2y23x@yaz-ubuntu>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Ykx59WvoWKi2y23x@yaz-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6fe84eb-c113-4a49-1fff-08da17292647
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4240BF016837B89FE3BB112AF8E49@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcEP0UkuacG8jv2TXCG6XF8hgsw94qM4szMisqWLMCifHcnfZUWj8tRQqoUSHzGzEy/2+9K8O5kJi6L4iCFBJeiPmT7U+FBIgDZbpc0fbZ2SNukIcsHcNOrlLfhp5y28IThgYOCnQhQ5PRmoynmBJK2UG2xO6ZIRQ3TH42WWhgJ386AYcwDP2qSib2nwLHGO0r68vEeTOtuBOPTo8tQradqo8+a6bWzryyhnpXVLQ8rUQ4mSobspff93O1asnf0UkDY6q80jc6MOn/iLdbOPKrMql63a2qVaWTxxZFiKX8lo9fKVfvFIFWPgNpA0CHX0N2a40GsVrzidXdfHyhbMiJtRXbf4CsvJ8Ah/mHZgSVL6z2+KB9hIoVklirXNLZ41zqZoLaYS7CyNU+tijTOiEkEPPQgFo07J5oVBeK5PqmATdzn5vwQ1jQf7yvT+5+vRPnwPBpuNXZncb+X7UVG+5Dtsw3GkZ9IGCqHULmKiFo5BOQbI34G8wce5NRE0lVgvxVFXmFyvBKMWZ8GgpckVg4IH5To0WYoQaNOMP5H5MSYBNOg0KPOfouI4pq0waHrt5b4oLiLIMr9b/lMY+7iEJ2o4yotQHxFym1UZcxEBe/9S88QlaAZiJxJpKt/ZbEDWFNWlI5qTCzWie6Uw+gH3i++HjM8/9jPMToJsvQMrfebOiAzXM/hvpMe/aUel+md96H5T7h75L+TDBQQCs+G7YZVlELD3s1HWACx9oNoh4TKFP526nik+GUUApTA6BlaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(44832011)(6506007)(53546011)(5660300002)(6486002)(2906002)(37006003)(6636002)(508600001)(31696002)(6512007)(316002)(2616005)(31686004)(66556008)(8676002)(6862004)(66476007)(86362001)(83380400001)(66946007)(36756003)(186003)(4326008)(26005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVFWNS8wNUtLdGNkOUN6R1pKL2JZYXBTWit0akNISWpjUTdFVHBYMEQvODAy?=
 =?utf-8?B?aUpJT0p1bU9FeXBvblJ1aHlKUDNKcm96ZjRzTE5sN0hRdmppeVV5SklSL21s?=
 =?utf-8?B?TlpHa29DQTFCRGVhQnBZR3ZJODZZM2NQUy9Cb0RHMXk5NFVGWnJ0S28yZ0g1?=
 =?utf-8?B?MDluQjVmQ096aEVxTFdTWlJnRkJLWTFJOG1GczNnSStxZjdCV3lQWExCSG8z?=
 =?utf-8?B?MnRRT3NZQlpFRVlRejdaWXhDKys2R2wybVpqbSs4R0RsL0N5aDh4SzBNcnQ5?=
 =?utf-8?B?d0JjRDhBbUluTGlKMWI5WW5Gd0VLcW0yNGdxVlphVEpjTHc5RUREaEZlQWpn?=
 =?utf-8?B?dXo4d2V6TUNFZVBzZ1gxd0Z4Z0t4N1g4bTk3OWpOUUtuZThSQ3dXWXBiNW41?=
 =?utf-8?B?OUdCUnVaMnZablB4bmRVT2lYRG4xL01rUFdydCtKcWdsVGxqMkdjV3diZmdC?=
 =?utf-8?B?Q0FoQjFFMU1GZW9vam9sY0Z2VzFRMzlqQU1OTTRBU2xEWVNTRDB5T0xteng4?=
 =?utf-8?B?emRQcThnZmNQdGgvL2d1anNCY0pLTjRHaGExQ0pPNlFtY3ZkN241eDJLRHV1?=
 =?utf-8?B?dmlRdWtHT002MytSdWdUL1oxa3ZOMG5CSTIzcVhzMUdhakU2YmI4eDJBa1Y3?=
 =?utf-8?B?aFVWMEZQS3RGcUpXNE11NjUwZTlXN25idXpnbFhqRTVvU3V6UzhlNHdRamw4?=
 =?utf-8?B?Q2VyNXRQZVl0dWVzWE9OQkh2OVpwRllQMWVpa2c1L3ArV0xvSXp2UW9uVGho?=
 =?utf-8?B?QitIVCtrZ0g5QVgvQkxyajhDV2VET0FJeWkrbEFuV2MwVnYyTmxwVGorRldD?=
 =?utf-8?B?QUZiUDIwemRkUkNEQkc2OUhVSHJnaHVsYlB6elBVV1A1WmRsL0FuNDlDbFln?=
 =?utf-8?B?RVlidXo4Q3RrbjAvcmhFSWhyL1ZsOTNETzNmdUZPRnFRWG5IZkF1bjFQeGxu?=
 =?utf-8?B?ZHZRTk9waGdWVjh3MG5lODdVRTdEcHptU2tYcURtekw4czVFeFBsK0hZaDVB?=
 =?utf-8?B?NFFvb2ZxS1ZtaEIySHRNTHZtQ0dxNE9HcEZwUlAyRUdJYmJGWnB0VUw0OHVY?=
 =?utf-8?B?RnE2SDFkK2JyUEV6S0gvOWsvK09ocTZhREs2U1I1Ly94UVdhQTAwVTFpWEg1?=
 =?utf-8?B?NkdvN2JuNUIxVjJZUFpBUGZiTHpwYUQ4dTA0YlJzYzdUem9Sc3gyRVVzUGJO?=
 =?utf-8?B?cy81L0RGS0ZHMHVwd1ZKNy95d203M1NuYisvY0NiYTRmK3lZb2F1dTJoakIr?=
 =?utf-8?B?WVdLSVhhV21WVStzZ0pZOGIxWE1GVUQ0Q2w0S0RKL29ORjhTZnZTTVFjMmF1?=
 =?utf-8?B?V3FpMmtwaE5HUWZTT2tocjlua25LYmZSMVBYTDFpQ3R3Y0FHMWFRcUoxMHZo?=
 =?utf-8?B?ZnY1UlB3UlFTS0VETGt1azRZTzhONy9tdU0vUXcvbWJxdTMwdVBoS05RVC9j?=
 =?utf-8?B?ODcxSDBJenBoS1AxZmZKNlFrL3VEaEp1STBrRGZ0aUVvRndhWlBLaTVuQ3g2?=
 =?utf-8?B?OEwvVVN2RHUvZW5BUUMyMUsrd0kwNVRGOEFySmxEdkw0a2t2S0ZNdmdoL1hT?=
 =?utf-8?B?N25LQWJ3L2Z6OU5CdzRtQ1NZZkZPcTFST0NWUFNHOExyd2I3Zy9DQkhPUTFm?=
 =?utf-8?B?VnB3TmJDNXQ5ZGY4NlgyamtlQktpZXprdG9sMmFDbTVEMzI4RXBQKytZVVFz?=
 =?utf-8?B?aDFQanM4V1dUNmdSeWRCQ2Q1NVF2Q29TS0JJWWNjRjZLUWpLWjd3Q2RZTXBz?=
 =?utf-8?B?b0s3THlURVUyQUh4N1MxVTZkc2poU0h6SWNFTFN3WHM3aUtPK3lCWGhyK3NI?=
 =?utf-8?B?Wm45TkFoODFzN3FZQUUvdFFGL0xaTGNPV2M2MEVTQjB3RERod3VSS0F1ODVJ?=
 =?utf-8?B?MHU0T0w2SGNac0VSbmJMZ3NIMDBoa1ZZQmZoNUZWSkhiTTJGbEZHdGhIZ1Jn?=
 =?utf-8?B?dzlJditmVkJoT0ZPeVpRc3RvWHhCQWhHV05GRXRYV0VlYXFwMWlHK3pOWEdJ?=
 =?utf-8?B?R2g4cGt2Z1cvbU53b2FBeDNlaHl2REJqaDBFVUhIYlJISjJNYWRGYnV2QWNj?=
 =?utf-8?B?NHJzT05kRENTNHU3ZlROMklzbExYempmdVRINWVCMU5KTFdXZXJrYmRWVkVt?=
 =?utf-8?B?T2drYVIwNHQxeEVJbDBadEVOK2hmSGF3eWtJcmxDU0R1RkIrOXp0dUsvanBh?=
 =?utf-8?B?a2J5RVQ3VmQ1UHlyb1hsYU5uTnZiS0JuSjhzeUxwejFLbWttaEluclNvZksz?=
 =?utf-8?B?dWozN2V0Sm1JMzVLNlZTOVlVYW0zR245RjJzR0dyaUhxdDJaU0lYQzZ4eC9X?=
 =?utf-8?B?ZjdhbWwwdjFrWmt4WXVVUDltRk9MQ0tOa3lmeDR3amk0eEgzZFJoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fe84eb-c113-4a49-1fff-08da17292647
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:24:33.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Bf6WTjw34DIkmgM9mPFoUtlMP3adbtIzOrNn1/Z+YXFyV/PZM84OxWtZOd5HBUX//3wnX97LCUo5KH/jMW5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/5/2022 12:18 PM, Yazen Ghannam wrote:
> On Thu, Mar 31, 2022 at 11:38:49AM -0500, Carlos Bilbao wrote:
>> The MCE handler needs to understand the severity of the machine errors to
>> act accordingly. In the case of AMD, very few errors are covered in the
>> grading logic.
>>
>> Extend the MCEs severity grading of AMD to cover new types of machine
>> errors.
>>
> 
> This patch does not add new types of machine errors. Please update the commit
> message (and cover letter) to be consistent with changes made between patch
> revisions.
>  

I'm thinking "cover error cases not previously considered".

>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  arch/x86/kernel/cpu/mce/severity.c | 104 ++++++++++-------------------
>>  1 file changed, 37 insertions(+), 67 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index 1add86935349..4d52eef21230 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -301,85 +301,55 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>  	}
>>  }
>>  
>> -static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
>> -{
>> -	u64 mcx_cfg;
>> -
>> -	/*
>> -	 * We need to look at the following bits:
>> -	 * - "succor" bit (data poisoning support), and
>> -	 * - TCC bit (Task Context Corrupt)
>> -	 * in MCi_STATUS to determine error severity.
>> -	 */
>> -	if (!mce_flags.succor)
>> -		return MCE_PANIC_SEVERITY;
>> -
>> -	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
>> -
>> -	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
>> -	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
>> -	    (m->status & MCI_STATUS_TCC) &&
>> -	    (err_ctx == IN_KERNEL))
>> -		return MCE_PANIC_SEVERITY;
>> -
>> -	 /* ...otherwise invoke hwpoison handler. */
>> -	return MCE_AR_SEVERITY;
>> -}
>> -
>>  /*
>> - * See AMD Error Scope Hierarchy table in a newer BKDG. For example
>> - * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
>> + * See AMD PPR(s) section 3.1 Machine Check Architecture
> 
> I don't know that section numbers will be consistent between different PPR
> versions, so having the section name is a good idea. The "Machine Check Error
> Handling" section is what the severity grading function is based on.
> 

Ack

>>   */
>>  static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
>>  {
>> -	enum context ctx = error_context(m, regs);
>> +	int ret;
>> +
>> +	/*
>> +	 * Default return value: Action required, the error must be handled
>> +	 * immediately.
>> +	 */
>> +	ret = MCE_AR_SEVERITY;
>>  
>>  	/* Processor Context Corrupt, no need to fumble too much, die! */
>> -	if (m->status & MCI_STATUS_PCC)
>> -		return MCE_PANIC_SEVERITY;
>> +	if (m->status & MCI_STATUS_PCC) {
>> +		ret = MCE_PANIC_SEVERITY;
>> +		goto amd_severity;
>> +	}
>>  
>> -	if (m->status & MCI_STATUS_UC) {
>> +	/*
>> +	 * Evaluate the severity of deferred errors for AMD systems, for which only
>> +	 * scrub error is interesting to notify an action requirement. The poll
>> +	 * handler catches deferred errors and adds to mce_ring so memorty-failure
>> +	 * can take recovery actions.
>> +	 */
> 
> I think this whole comment can be dropped. The "scrub error" part is not
> correct. The polling function may find deferred errors, but they are most
> likely to be see by the deferred error interrupt handler on modern AMD
> systems. The "mce_ring" was removed a long time ago (in v4.3).
> 

Ack

>> +	if (m->status & MCI_STATUS_DEFERRED) {
>> +		ret = MCE_DEFERRED_SEVERITY;
>> +		goto amd_severity;
>> +	}
>>  
>> -		if (ctx == IN_KERNEL)
>> -			return MCE_PANIC_SEVERITY;
>> +	/* If the UC bit is not set, the error has been corrected */
> 
> This comment is not true. Deferred errors are an example of an uncorrectable
> error where UC is not set.
> 

Ack

>> +	if (!(m->status & MCI_STATUS_UC)) {
>> +		ret = MCE_KEEP_SEVERITY;
>> +		goto amd_severity;
>> +	}
>>  
>> -		/*
>> -		 * On older systems where overflow_recov flag is not present, we
>> -		 * should simply panic if an error overflow occurs. If
>> -		 * overflow_recov flag is present and set, then software can try
>> -		 * to at least kill process to prolong system operation.
>> -		 */
>> -		if (mce_flags.overflow_recov) {
>> -			if (mce_flags.smca)
>> -				return mce_severity_amd_smca(m, ctx);
>> -
>> -			/* kill current process */
>> -			return MCE_AR_SEVERITY;
>> -		} else {
>> -			/* at least one error was not logged */
>> -			if (m->status & MCI_STATUS_OVER)
>> -				return MCE_PANIC_SEVERITY;
>> -		}
>> -
>> -		/*
>> -		 * For any other case, return MCE_UC_SEVERITY so that we log the
>> -		 * error and exit #MC handler.
>> -		 */
>> -		return MCE_UC_SEVERITY;
>> +	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
>> +	     || !mce_flags.succor) {
> 
> I appreciate merged two cases together that have the same result. But I feel
> keeping them separate may be easier to follow. They can also each have their
> own code comments. Or keep them together and explain each within the same
> comment block.
> 

I will divide these two cases.

> Also, there's a checkpatch "CHECK" here. You'll see it when using the
> "--strict" flag with checkpatch.
> 
>> +		ret = MCE_PANIC_SEVERITY;
>> +		goto amd_severity;
>>  	}
>>  
>> -	/*
>> -	 * deferred error: poll handler catches these and adds to mce_ring so
>> -	 * memory-failure can take recovery actions.
>> -	 */
>> -	if (m->status & MCI_STATUS_DEFERRED)
>> -		return MCE_DEFERRED_SEVERITY;
>> +	if (error_context(m, regs) == IN_KERNEL) {
>> +		ret = MCE_PANIC_SEVERITY;
>> +	}
> 
> Braces aren't needed here. The previous comment about braces was for when
> there's a block of "if/else-if/else" statements. A single "if" statement with
> a single line doesn't need braces.
> 

Ack

>>  
>> -	/*
>> -	 * corrected error: poll handler catches these and passes responsibility
>> -	 * of decoding the error to EDAC
>> -	 */
>> -	return MCE_KEEP_SEVERITY;
>> +amd_severity:
> 
> This label doesn't look right to me. Maybe I'm too used to seeing "out" and
> "err" labels.
> 
> Please see "Documentation/process/coding-style.rst" section (7) "Centralized
> exiting of functions".
> 
> Maybe something like "out_ret_severity" to indicate the code is going to exit
> and return the severity. Or maybe just use "out"? Maybe others have thoughts
> on this.
> 

"out_amd_severity" sounds good to me.

> Thanks,
> Yazen

Will send updated pachset. 

Thanks,
Carlos
