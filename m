Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215436E6B6E
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 19:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjDRRvp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 13:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjDRRvo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 13:51:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7123198E;
        Tue, 18 Apr 2023 10:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYqbqKmJOHYhWkFXBXKg7FYOdamb5whVKubPabeYVqd6wch06x+lODUw6Ni72nmfD87RDWxg+6C4FVTsTO1Ihb9uUFcuJfzCkxVAAnAJfsk0arkww5LCXub6QbFZDzzUlkHmuK+dS4tU7882bJ/NwIcO0zV1xpIfa6JzSLwNJweSP3i/2/LhFLvip7M+eNWyyxjUjWMx9+kyqunS2CSftyFWdoauSkveTO4JQr7x24Qyc7nD16marTMWjUdHO5tv3/2A7JQ3EhQ8R8peXUrL6J+R8Ig7pABPKJWBGrGGYbGzccbE3WMlEfxV9Qifva5Al0ErRZxnlkuHClU8pE5z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/O+a508EfRfMyABvZdHGFdKmhGhBLXf1HuE03gtXVE=;
 b=Jk5t9sybJCJK4bUSU7cpFipIQdcfa88ZRUPaROMAoqkW/T0sfRcOCaAfzSE/UgOZidSKqo05dwnvfuTwgLvqcMywMNlBQ/413urYBNbgVpQ72FIyWm4z2y7VWvZZQ+aCHFeNDVSo8VO88T0BY8OcRR5mflvFUZmQIOHD0nJvDDW3qbwRU2w8vdcio77NxiNnsOLNX971Hvy1B453GO9PWOM/b3+/uMdkw/Gb0ASSfQHhPdZN/wQNm8IieBFhXy0N1q35ueKupnefQ9lEvxpjL1DPNCz4bR2I6qY/uZdDH4exzxizp1W7heC1WGnuvo4FLVKl2zF6H/4lLGR3kPYWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/O+a508EfRfMyABvZdHGFdKmhGhBLXf1HuE03gtXVE=;
 b=g6kvGw8siLBtALEQeQh77ewQ2gpwD9lkd+eisuvbztS6vg6BN61qxtP5ZfXzU9xnA6irZ7TOjQW1uMh3yO4D8NKoJlc5MyaH0li5eR5jA20sNnX/Efara1iQ32S+W5uOzBP+ammQhrAfCsEh5CLFLcqiTF83oFmk2cGBRrQYsDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:51:40 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 17:51:40 +0000
Message-ID: <5f833d37-e961-73c4-3629-74884e8b6c59@amd.com>
Date:   Tue, 18 Apr 2023 13:51:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Check that memory address is usable for recovery
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
References: <20230322005131.174499-1-tony.luck@intel.com>
 <a5d0c575-ba4f-1120-c7ee-bc37e8d40402@amd.com>
 <ZD7TBZex278dSYmc@agluck-desk3.sc.intel.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <ZD7TBZex278dSYmc@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:408:e0::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MN2PR12MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: e38dfaec-3fcc-4c04-899b-08db4035900b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dom13UBYKnnGYCKw8r5SFsHrmMcHr4VU+WIjBgli917oewsJ92coW0abip5W90Jb/MZlRhIBQKyvg+Q+NU2W0IDXkC6t/uKVrUY2Yfe40W5LqVv8BFSxzpAyUxDpS3kbsMHQp9Vt1ffMpqexIEXQfklBaQmaGTHaNd4YnBI0RtHifNQ6PBL13GZjXNt3pH0Z8i8uQDSqtxkRyJ+BHD7J6GbMjRwrjTTzBDFZZhaSny5o3RuYDs6zis1hvUIt+/bR9T5N+telCMl6Np3jonBCl3z1Gp1EJ+6/7B4RBx4+XK14pI/AmI/QeKp6K3RXM25aZ/D++kn7eFJR09ydGOqbSiDTlIZbg/Oefh4cNSuIPkbRhrJp3fO6olrKJR/QHRETAOlSmQm0aSK1bwW9TpTGGlqS4pxB/wnNGfratT4itTUHBlI0wTke5Ix/eMej2an/c6MsVOJimuG2AcNnc0OSPBAktkEOTiesseeD+VUcD5VZia/YK3IJztEWykMI6gBhdcgmPPDUlfXyNQcbefUvYVd+cTdI2o/oSIj88C+wcY1qQzO0uGmkYnGjMKUhtp+BX5a4KxI5CEVvkpGJ/WtWCzCY7xgUUuZ7Ui378gdZmY6ASn9//rxGf0lTITgDjcCKohvAlpVHre4qfqF/sFfrcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(31686004)(6666004)(478600001)(6486002)(83380400001)(6916009)(316002)(4326008)(66556008)(41300700001)(966005)(2616005)(186003)(6512007)(26005)(6506007)(53546011)(66946007)(66476007)(5660300002)(44832011)(2906002)(8676002)(36756003)(8936002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkJRTm9PNFQxbk8vTDNST2pjUmt2bXY4STNLOXBNbEdiRXk3QW1jMjJxRDI1?=
 =?utf-8?B?akZwU1pYMHYxYlNadzVUbHlkZmpRaDFmOXkvbVRJdTlkOTFKeFU4UEVYcWds?=
 =?utf-8?B?TEdBVWk4Z1VUMW55NVRXUWtSRGRsQ24rdjhRMFRwVnVkaFBXRW9ZSVI1akEr?=
 =?utf-8?B?OXZkcW85NG05T2kxY0s0MjVyOHJoc3h0MWJOMWFoUHB1a0FKN2YzTWY2em43?=
 =?utf-8?B?UHdWN3Arb1MxaUFOOFRRdndXRUJOR3RzVlRmN0kwSHNoQmhDanc0dHA0cmJM?=
 =?utf-8?B?U1AxYnhWT3FsYXVxVEtKOHNnODNoOEIrQjNSbURmMXJJei9aMkpXL0V3RG1q?=
 =?utf-8?B?cjNacFBPdmRCY1B0cXd0THM1cGNvVGZDbWNtSHNxRi9mWjc2S0RtWjg1MitQ?=
 =?utf-8?B?NElUOG5vRkNreGp0Vm52ZDcxaUJ1UTJPdjNOVjk1by85c1Y4L2lUMkI0ZVlY?=
 =?utf-8?B?ZzVhbzRMOE9ZcXlUbkV3M0hxSmEwWisvSUVUOXBKQWYxU28yd2RHS3hoS2tT?=
 =?utf-8?B?SEp2WEdKb3AyZ2tBbWRYQXBuSS9VZjd6bHFFNHpDczFoV0ZVVFpqbWdjMis0?=
 =?utf-8?B?eVBsd0JmRGRGVWwrdjNQdkN5M3c5cUdaWS9sbldxTVdqSngza3pHT21YdU1a?=
 =?utf-8?B?aDMyME1DNUxuQXBGQ2EwcSs2R1l3ZVRmRmdqWCtvTjFVb2lQblRkN3NSY21m?=
 =?utf-8?B?aFkxQXJWVW8vRXc0d2lzNnd5NEs0M2ZDYlpUUjlyNHF3LzBWcE5hZStIRHVX?=
 =?utf-8?B?QTVxYnpnY1JyakU5N2k1QTZneDZkTmNzcEJ6Uk1PRk1sbG14dzVlcWRaeTBk?=
 =?utf-8?B?WjZONnZ3bFlpNC9vSXZ2ckpIdDcvVzEwbFE1eWEwb0JZNk9YMTZQUCsreHZN?=
 =?utf-8?B?QlFRNkt5NnJBWWNxTlhWalVlcHMxMTk4TXdpcitFNkZOZUhaQ0NUMlNTY25N?=
 =?utf-8?B?M1ZPVndnM0xhMWdiNlliMGR3RmlKUm51Z1RUODhsaTUvSmZCVXNONXZjSW1J?=
 =?utf-8?B?eThwTVpDRFZ5S2NsL1VWMXhvRXZLWEkrcmpGZXQxS0RsYXBCR1A5cEltRGh6?=
 =?utf-8?B?UDJkc2FneFI3QUdxVXNaOExHdGFDRk8vNHdidGlWSW12ejU4REUyV2JhMEVG?=
 =?utf-8?B?WExSbHJlNEFrcFFUbDdNUEpzczZLZ0cyTktyZHd3MjBZdkpEd0VySlRueFdy?=
 =?utf-8?B?eWJncGZ5WUJHZlkyKzU3VnBjTERrZ0VrNGx6QlBNQU9aZmJBNG5DbmRTcExD?=
 =?utf-8?B?TWltWGVaQS81UFZjWkNTanZ4KzB5VFVBdVN4U3Ric2ZtY3dCODdXM25QLy9v?=
 =?utf-8?B?d2RGZ0ZEYTk1N1ZlY29GRkU0dDZCVWp1d3ljNGZoWitpbytkY0JiUkJzNDNV?=
 =?utf-8?B?NktQKzdzZ3A4N3pLMlZOcjZRaWw5clR2ckJuKyt2SlM5V1IvT3JDK0ZyYW1n?=
 =?utf-8?B?VFp1SlN4Q3c2UU9rdDVKWEQ1a1NMSEV4WUQ2SG5iWDJhV05MK0hBR0FKUm5i?=
 =?utf-8?B?VVhLYm1VVGNqN0kzUnkyQmNqKzg5R29LRTNUSnYrSHl2bVhyR0VLMkg5N2Q1?=
 =?utf-8?B?L3lmclBrakVTczVLWEJiZXBRb0tzVGExODI4NU9wU0tSaDdnLzROVk1QY3Bw?=
 =?utf-8?B?Q0FYQWFIQ0tYUmozcHgyMlppbm0wUzZ0L0l0UTBzUGlMNUd3blA5MXhSOS8w?=
 =?utf-8?B?WTFwaDJGc09HcDFZZitHMlFtK3VWcDZRQWVwRW5YWEt6ckZEbFBQY3RzK1k0?=
 =?utf-8?B?a3hTYThISEl6aEY4OUV6RHhTMlJsYUcxdVBFcXpYMVJrN01lekZYSTAvKzlO?=
 =?utf-8?B?all6ZmlHUVROak1ORUR1cW10NEhLSEhZZVZETTN5K2UwMFJacWxQVVFZQkY1?=
 =?utf-8?B?c0JzRG82SUhUZUdjT0o2ZjVINFNGYkFHeHlyRGU0eXFqNFpkOEJRUS9EU0tm?=
 =?utf-8?B?ODc1L1piY3ZLSEg4V0tBNjE3R3lDSG1yQUxKekJKTWJUN3Uvc1JrcW84QUNC?=
 =?utf-8?B?bzFWWURXcHl2cE5mc1NaUEVIWE5aR0lNemo1YWNjSy9qTG95U3hrWi9Nb1gv?=
 =?utf-8?B?MSt4c2NYbEswakdzaGE3YWZYRzlVSEN4WWFqOVBwbVpSTEozMk1SV1A0VDEw?=
 =?utf-8?Q?7hMsS7tFvAFSHv3PeiVPHqVwk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38dfaec-3fcc-4c04-899b-08db4035900b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:51:39.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7y9LByn8/kHdVo7mR7Y6TpjMRfZjh1VXq1eVMrRqL5xfY8lcRRUCZmm5gwjyMxfXr1LfKTlH0iZbQAivJjEoOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/18/23 13:27, Tony Luck wrote:
> On Tue, Apr 18, 2023 at 12:41:17PM -0400, Yazen Ghannam wrote:
>> On 3/21/23 20:51, Tony Luck wrote:
>>> uc_decode_notifier() includes a check that "struct mce"
>>> contains a valid address for recovery. But the machine
>>> check recovery code does not include a similar check.
>>>
>>> Use mce_usable_address() to check that there is a valid
>>> address.
>>>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>> ---
>>>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>>> index 2eec60f50057..fa28b3f7d945 100644
>>> --- a/arch/x86/kernel/cpu/mce/core.c
>>> +++ b/arch/x86/kernel/cpu/mce/core.c
>>> @@ -1533,7 +1533,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>>>  		/* If this triggers there is no way to recover. Die hard. */
>>>  		BUG_ON(!on_thread_stack() || !user_mode(regs));
>>>  
>>> -		if (kill_current_task)
>>> +		if (kill_current_task || !mce_usable_address(&m))
>>>  			queue_task_work(&m, msg, kill_me_now);
>>>  		else
>>>  			queue_task_work(&m, msg, kill_me_maybe);
>>
>> I think it should be like this:
>>
>> 	if (mce_usable_address(&m))
>> 		queue_task_work(&m, msg, kill_me_maybe);
>> 	else
>> 		queue_task_work(&m, msg, kill_me_now);
>>
>> A usable address should always go through memory_failure() so that the page is
>> marked as poison. If !RIPV, then memory_failure() will get the MF_MUST_KILL
>> flag and try to kill all processes after the page is poisoned.
>>
>> I had a similar patch a while back:
>> https://lore.kernel.org/linux-edac/20210504174712.27675-3-Yazen.Ghannam@amd.com/
>>
>> We could also get rid of kill_me_now() like you had suggested.
> 
> Can we also get rid of "kill_current_task"? It is only set when there is
> no valid return address:
> 
>         if (!(m.mcgstatus & MCG_STATUS_RIPV))
>                 kill_current_task = 1;
> 
> kill_me_maybe() does an equivalent check:
> 
> 	if (!p->mce_ripv)
>                 flags |= MF_MUST_KILL;
> 
> Which only leaves this check to resolve in some way:
> 
>         if (worst != MCE_AR_SEVERITY && !kill_current_task)
>                 goto out;
> 

I agree. And I think all these checks should be baked into the severity.
We'll need additional, fine-grained severity levels though.

The "m.cs" and "m.kflags" checks could also be baked in.

Instead of just one AR severity:
	...
	MCE_AR_SEVERITY,
	MCE_PANIC_SEVERITY,

replace it with specific cases:
	...
	MCE_AR_USER_RECOV,
	MCE_AR_USER_KILL,
	MCE_AR_KERNEL_COPYIN,
	MCE_AR_KERNEL_RECOV,
	MCE_PANIC_SEVERITY,

Then the #MC handler can look like this:

	if (worst < MCE_AR_USER_RECOV)
		goto out;

	if (severity == MCE_AR_USER_RECOV)
		queue_task_work(&m, msg, kill_me_maybe);

	if (severity == MCE_AR_USER_KILL)
		force_sig(SIGBUS);

	if (severity == MCE_AR_KERNEL_COPYIN)
		queue_task_work(&m, msg, kill_me_never);
	
	if (severity == MCE_AR_KERNEL_RECOV) {
		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
			mce_panic("Failed kernel mode recovery");
	}

I can take a shot at this if it seems reasonable.

What do you think?

Thanks,
Yazen
