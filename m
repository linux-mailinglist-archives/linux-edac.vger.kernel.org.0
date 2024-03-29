Return-Path: <linux-edac+bounces-857-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EEC892343
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9521F23054
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C6130A5C;
	Fri, 29 Mar 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3yOuoEw0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074A2BB0D;
	Fri, 29 Mar 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736637; cv=fail; b=stAFfSODPVR0mVYzotUqUeJMkBahnIYcIpKvbw6dkEuJYSDnQ7eTM1Mgr/71/QHb0QxG5M6wOIOjw8chgNByULXW2feRltwR+yzMyiGalFEPQnsvVtzIrsp/lR2D688lLzXcFwkfU1IiWUrJ0L3rMRYxt9kPN4cnA38rK8XSEhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736637; c=relaxed/simple;
	bh=Rvox/OH1RXGYbrJ/44u+v3kb/nDzn/3bweryZ1WbZPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxS20nGCH31ov5Hz1TmY1mtrMG3sfXpgSZw/zSGhZH+zxSKXfMWR+CexPL1teH/n2BgfZELlboKwMxLG97TPFliderkXYbPEN1HtW104jYy/I4L0CCsz1bxpcGfpFWlgaWvQBGpTFl9mLMq4tYe3Eqe6woxH+0b8AGfI5JmKqac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3yOuoEw0; arc=fail smtp.client-ip=40.107.223.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBKgS9LJQhzSRJIcH8f4ebUrxEs30cthROou4nXQyIK75fWvwsoOzeyQCqxuzmGpbXHATgW+9/adzvH1W0bCore9yAa1bUw0gWjCtZL19XPe2DPc9aYviOKmSxVAEaIioVvOhGJMwNw8rCTp6VbL4YCgtOiHIR2Goa4j13SHPG31g46JeMy/rk8SSnzsuqozxWYXku7W3ZygjQXyJPsUbuO+qYaVHOuXjfq9ceaq2KA23n6bR7GAoL9rolSChnHzptMSWLqEYm4quSLhp50FkIk5i+2giEdylnxFRTOy2OGWYPILlKSRkwsIkaJyqmbKL2ydoN7KXK0j4AwftYWVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMXavnfyfuuW6S+BIi7oguFP4QkHplHLQWxtE+2Scwg=;
 b=V7TTGk9EPyLeq4P0zvaxL2KTWggbLtD/Rl/RHXNs5zJqyyHzwmCGYyJGGgqbq+vJF/6e8PjporfGzM/PUX2s1wWrmoIRu8FrKzTyiSG1KOcdmuJ6GCLuHaAqCC2J6uaV4cMNGiMHy8R1m/fdMVfFwx83g8GTETaN2oak8+9qtA27GAl17UEhC+2B8iC2BCyg3tKC1UNT+P0DY3+KY4XO5mYEcQoz1r+lwWNsUZ01rkRyYEvJgK1svGTgNYERxazSViQImooSjn1PqdlCI3MGUXSguFr9dmRXvjbvim9rxqzMdjtog5TM1A1RYKwcLixUIE3g97D8wHg9w6X8L4e7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMXavnfyfuuW6S+BIi7oguFP4QkHplHLQWxtE+2Scwg=;
 b=3yOuoEw0pPumzOybTT8uTuHH6s6NY293XWbg4HI8bQ7t9f/paS4qxBPR1w7HVVOigJTgYVuN9sNF+Oeer2Xt1C6dpo9xrH4jEJw75Elz5akJmyD6fDcTYh+xx1wrAxmG1bYyU/eiDukFl9WZBA5MoUuHGquy8X7P5SuKR4mqMVo=
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 18:23:51 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 18:23:51 +0000
Message-ID: <76de83cb-af54-4455-ac37-5a0fee7f4af1@amd.com>
Date: Fri, 29 Mar 2024 13:23:48 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] x86/mce: Clean up TP_printk() output line of the mce_record
 tracepoint
To: "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>
Cc: "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
 <20240328180435.435076-2-avadhut.naik@amd.com> <ZgZpn/zbCJWYdL5y@gmail.com>
 <93895d82-ae81-4fa3-8d58-9958d7130dcd@amd.com>
 <SJ1PR11MB6083DA954AD9C56DCB68B357FC3A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083DA954AD9C56DCB68B357FC3A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::10) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY8PR12MB7243:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJCJAdP80LeN0QIsSnEhWMkaZLyLS/ot/D8mAX8jtgIxcdLtIDO4+3pzNVVOZQbyGUTOTlRIqbYJSvjFjiBSVo/8+82/GMU5iLxeM0OIwa/t1ehYbJnUswGgU4KVGJXaMbW2ORik1UtRC99q4I4Azu2JLaXlbhcMud/TFk8y0CWN2NzCsnEEnZsAW9X0VzLcyGML4F+9EpDHQ9ZUiidy+zSwLA9IVkSVZBQyZEAJu1KLLIPafQz2qtuCnVGI0cbcs5tzpFqQg5jmI706ONy8lGWKqe13Dv5+k5zTmSZYoT7WQq/Z/gSGIK0MKdm6TYobvIHohbathR8aFesj2rol7YRqRjmyKC0naO1GDY1Ygaq9UARYCUSX4ZUIB+zpO3i++UldAeP/ixy9bcHQMvoecptJkBFuHM3K9Juz0dsBrsGHZzZMJFzWXKYN7SYpCyp1rYJe5XcwbfIPRunxKN6VDzSJweE97bQY6+st5tsY62M57116lYnQB/w8LKBMwYV9dC+3uDkidiaiolj0ldVl+jojvU9vqD4KwUzUzSDFGcR50xlcHjvsEV7nO9IIsfcJiCTkRVMXyCIuODOlSxG+91fjR1LjWvw7z2leqzSQ0xzmYNRBfNpsmYx6tLM0CTPPmexQTBOtR1EqYDrc66weK63OjjvOFhySlDl3k+GcrsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEU0eXhZbG5UZVJFd0YwRWFvZzh1ZlpHaVJFcXZ1dkx6SkJJSkthdEV3anZH?=
 =?utf-8?B?VU96L3QwVWRmd0xYN3l4MDJCL3JPanZRRDhXYnZ0S2R3QjJqSVUrOCthVUY0?=
 =?utf-8?B?Vm1PTEltV1pCWEZ5a2tpeXJjMXM4WVhWL1JwdnZYS21pMXhLT1FTay9vZEQx?=
 =?utf-8?B?Z01GcytPRFB5cjMxQ3NmSDhiR1djc0RWOThSRG9JQ0pwTmNmVkk5dHNjTmJK?=
 =?utf-8?B?T0IvTGFybCtDeGRXQlBhaGE3MllPSXVsV0lCdytMQkpheTZCN0xDOUNBZjNk?=
 =?utf-8?B?TUVHQXVGc1p5bERaQTNmV2RHUnltbkFKbnUvQW1ZSXlWdk4zTFZZRVR3OGor?=
 =?utf-8?B?aE04WWRrSzluUmhNa2FBRi8ydDN0eDdWTWZrYkJZY3MzUXRzNVY2a095eVhR?=
 =?utf-8?B?WmIrTVZmMzdoZmdpWkU1TXlBTWo4dUdMOURoVE8zZ2ppSG56YUZJR2pQN3lP?=
 =?utf-8?B?dUZBWC8xOGpVM0hhQ0RoQVBKMkdlY1ZreGhGSDNWZmVJWGg3RUJMUFhyN0Er?=
 =?utf-8?B?UXkybXJyWkp4M1JNemEyWlBaNFRiZUY2T1MzSjRyMHl2YldybXA0eWNja2FM?=
 =?utf-8?B?eFo1cmF0eDVTanpTdUVuajhISisyOTRRZWgvdzFnOHJIUUViQTBNYTNjWXhw?=
 =?utf-8?B?bER6Tlc1K0Z0bCtqdW9yc25iZ1FHTkNxL1l4NWhlQldoS0VqS1FaY0hLT0pr?=
 =?utf-8?B?aXlWM3VZRUduWGdYV3ZiSXhpRzgwcFJETWZyRk1wY0tmT2tZeC93b1MxZ3RQ?=
 =?utf-8?B?NEs1NzFTQ3ZrM3JHTEppZFlJK0U5amg5KzVBeENDRURnYTdkc2dwK0JUTCtZ?=
 =?utf-8?B?R3d0N3FoaXUzczBEY0xPL0RTWC9MVWoyVE0xcHBvUiswdUxMckh1aGN5WHE4?=
 =?utf-8?B?c0ZLUVJWTjNmaUNnLzRMdFg3c3VRMTc4MEh4Q2l2NUhING93OWhSOFRMMDY3?=
 =?utf-8?B?elVHeWNtVWtKaVdOZzlEcmJUTmlxRVl3OUNrSFpzSXNhaU01YWNTU1VZWW5j?=
 =?utf-8?B?cEhLU1hIcy8rZ3VvclVFb1NpSDdpd0RJYTdYOW1FT1BYMVphYU5BekxZMDRF?=
 =?utf-8?B?QW0xdWpBdEtXODhyQ3o5RGpOV1ZQV3JzeC9teEJTS2F1aUhvQlNNbXdRUUZE?=
 =?utf-8?B?QlNOYUplbkQwQXE0a1c1MWtKK2FVV0NjRjYzZWZFKzZZSCsxL0VPKzNaTzNK?=
 =?utf-8?B?Z0hieGFXMUFVRTdxZk12OXZoN2pwWi9WNGpLbVlla083eEdheExoVFo1Sm92?=
 =?utf-8?B?ZTNISTIxRytrcjk3alFUQUE2WkxZTTJIVWJOYmd1WjVSUlcrVFNyK09Zd1VC?=
 =?utf-8?B?YmpOSEsxV3lOYUJBNFNmUXZ6Sm5DN0p3ZEdicjVLTUxFWTJRWDAzZ3loaWhJ?=
 =?utf-8?B?TTYzZGZIL0tuQ3NiNm9rYnYwMDNUblh5Nkx4MFV6YmVwZWppWW9qVmY3Q1VZ?=
 =?utf-8?B?ZDNIOHlhbkEzTjcrWHBGNk5tNjdZNzNLMUE4aklDOWoyUGhQNFBEdWZlNVpB?=
 =?utf-8?B?K0Q0ejRXTlBlK3pMYnlmTVhEbC9ZVTczMlR0SlNiaU0zcTJySmd5MUFmRkpu?=
 =?utf-8?B?QWhmek01T2IvaWdMSEZvRjN1S3dtS05jL1M2WGZGekZkN2c2WTF0MHVmRHpw?=
 =?utf-8?B?cmlJL2RoYy9ka3ZpSDVwY2dNMGpNaHZOOS9obGFKUHpMNy9SOFRVdUhVU0Ix?=
 =?utf-8?B?USt3RlJLaW50aitYMWFwenpxVUhzcXFYK3dicmJzcGhRY3hTTWFqdUVKV01P?=
 =?utf-8?B?V0tNdGlFTktrTVdxbDhoMGZnYmV1QVNYUk1vMndaRzRYYlFCRGJJVThWS1E2?=
 =?utf-8?B?L2l0WitBbENzaUpVdVp1T1pXS3dlb2xTKzA2WCtEQkt5VDZxMUZHUitQOEti?=
 =?utf-8?B?b1ppZENOZmpRSldkTWhMc01KT3Q0VkVXZTFCNWJhK2xOd05WbG5tZndaVmRq?=
 =?utf-8?B?a3YwTEc4aVV6ZWtBNDhzenJGbWtQV1FZY0JlOGE1RXJKZE5hMVNiVGx3d3JZ?=
 =?utf-8?B?SUx6VWNWbmpUS001WTJsWDJrbkovMjNSZjVXTWVLNEc2QUQ4S2ZvV1pzOVNE?=
 =?utf-8?B?L1I4bE02bHBTQ1pnMkhsM3FCM2ZSK1R4TytHYjMzY3J5TnZpbTRZS01hYkdX?=
 =?utf-8?Q?99498RYAUjy/eoBKlUQ/bGdRe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853570e6-318e-4855-c063-08dc501d6257
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 18:23:51.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE1rvuDFmbMRUDxHoxvBguCjqmtJPiVvjYd7egSHdxHA3evdgrhzDzwuW7nUhpzQnDIpOPQuLxhhQ9+tiW39tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243



On 3/29/2024 11:50, Luck, Tony wrote:
>>> - While at it, don't forget to:
>>>
>>>    s/ADDR/MISC/SYND
>>>     /addr/misc/synd
>>>
>> These are actually acronyms for Address, Miscellaneous and Syndrome registers.
> 
> They look like abbreviations, not acronyms to me.
> 
> -Tony

Yes, they are actually abbreviations. Wrong choice of words on my part.
Was under the impression that Boris' recommendation also applied to
abbreviations. Will change them though and resubmit.

-- 
Thanks,
Avadhut Naik

