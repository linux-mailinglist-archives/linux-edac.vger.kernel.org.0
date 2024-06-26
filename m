Return-Path: <linux-edac+bounces-1384-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81024918A05
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 19:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101831F226DB
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEE18FDBD;
	Wed, 26 Jun 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UnCGYAfj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A118EFC7;
	Wed, 26 Jun 2024 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422669; cv=fail; b=KgUww6MEwPkYsdbyBle24iBMdUpkrkQGakX6NfVo49OW2ukyFSOMw5wGCoiKOEBZxVaSHfqucoyShm0MDNb06CWjsmFAMMprW2jQBshMa+pbwS824jD+VKAHseLvavDcO8BRmgnmPYyKWiuvZ9+pbO1M8Gau/JRNRdaijKBJmEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422669; c=relaxed/simple;
	bh=Id0/sY+80wgEoUT0a39B3zjpzqeshfU94hgiKaXyRrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=agaMREglD4oPJ8FUu9/A9lzATwex/H3bI3swDWn7tlJukw/FzoDKCxSZSyVQM7IJapU6YLJ2BRZWigx7J1TA6pyYw5L7OM0XOypIvrOQjnI6LGQxZdl4EbzGaH3awbT4Mz+cS58PyceuYL8W3MA4wgSC6pYwOJY08Yt0vhvn22g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UnCGYAfj; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go52tBVJWJk7pitg1/3uHQ59bLWOmjW4tFtyPVn58/pGFuHZIo9Sqc87HuoM5cxzugKHn/yXTt36jrVpXqVD4SHv4icPoIdHo0JoVxTqvpcWRjzCaGxVJEmBJYBax7g3MGAH263SZeeSW8D/It56UaCQfQRRglvxleNR3zFPvmjNXwyTG05apvJfMsND+uW23/c8uZ6awcqU3zqV+ovapZSO1S9CB+WA3b1VPx0On658td8pdZ61Pnab2kNfEe9msbn1Gvmm0nz+2wnqruz+KiffjtBPKvyq4QtJ0nebY7XrSszTp6pY2SY4Md1cRgvpujuMai1wbeukHV0kJO7E9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N81XFccjqAf3Z6bYSeVX5yrFaaQT2L3mK/2sHNVIjqs=;
 b=JuDBa7+RsAHsKE1pktls5mADaX88vgxyKM3JJUnMxx+jZRiJFTXvFx40hLddzL3r61WVkWXGtpleBYwpWFIlqfdkpNEVkymRbwXLatltbMl9vaG0JL+ITsUQOC6H6UQYx1S8SDJLEoXrK/GhR01F+5LkjYoEqIX0C3/mBTaM9gSx1jEtMbVSaYkrSykzRJYxQ/h0uplC4Gr+XcpOQo2hyuNln74e4MDXgdFTNELLJr2MOIxhh6oGf6ab6vZW7iNiT0/8vneQLzGreSvQePRSlKqYK6hOXwEg5Z+OWP0kIj/bI8mzamfNgkj1wBJv3ibN+l8CJ/Bs0KQ9KYISBaHmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N81XFccjqAf3Z6bYSeVX5yrFaaQT2L3mK/2sHNVIjqs=;
 b=UnCGYAfj9Kssq/otBvNwZtFoNGkdtmJK9z3ASTv2tLxTcBvKyjn2x1dD9+vhhEhCiLRaZ2q8HG8RATKyJ9VcD5IqR/xoZLJbTAnA1tUCoEI2oSIFs8OVRCX6dCpzqSsmHf7NzZYxL3I0iLzUGVGrNh4bXu7maZfO9/WwIP9tkZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 17:24:24 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:24:23 +0000
Message-ID: <6c318161-9ae4-4965-b8f3-e38bf1393628@amd.com>
Date: Wed, 26 Jun 2024 12:24:20 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-3-avadhut.naik@amd.com>
 <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::24) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 668633e0-c547-4bd0-8fc3-08dc9604d275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWduMXlXKys5UG9rZVdBMTJSUjRCTkxENlhiZStxY3cyaXBWbVdIU3cxOW9D?=
 =?utf-8?B?ZHJtSXAyOElVdmdzNjg0TW1WYzh4dy9uSkZ4QVFBNDBvOXN0TkxJUTVGYUUx?=
 =?utf-8?B?Q2d5eTk2VGpUV0hac24vb2w3ak9seE1uSzZKK205R0ttU25la3hpa0lQdkJD?=
 =?utf-8?B?bE53L0Z4MnB2VFNhWUw2VUZRd3lxMmFtMm91UnNYeWZFdUJoSC9kTldHVTV1?=
 =?utf-8?B?aE1qaStpSkYvWjEzTWg3RWRtdytmR3R6TUNPaERNbklYRUx4b2xaUG15aU1Y?=
 =?utf-8?B?REtCVjBiajVZVDk2cHpTMHJlN09zK3BnMHlZNWVZcmx2Qmg3U3Zvc3VUbVJS?=
 =?utf-8?B?NTBFV2Q4MlVaV1gzWmVaeHUrY2dnWFNUSkNhZ1dLMjU5c01EcG5Sa0t3RGhO?=
 =?utf-8?B?a083WFVLVU93UUhQdkdhZUJYT1lGUVV0ZHlqcGVRZll6THFlM0haWHRHYUVV?=
 =?utf-8?B?VHRJeENUUHBKNzNoQzg5eFdETC9ZNlBHd0tQdTVmeUtjczJ1UGhxbmNTR0Ns?=
 =?utf-8?B?YmMyZ2NOZkhpbXVaeklKRVZYbUhKVmN1SndTd3JMZ0Vza2l5N25UUGt5WUhZ?=
 =?utf-8?B?NVNWRTFjOTQ2NDY0UDJrbjNLYUJIZ015MHdhTU8xaTdvWTFKa3J0clJyR3Zl?=
 =?utf-8?B?anhacGpHQUh2a1NHMnhZMXJ5UWRpZDRWaHFiaXg4aE1mdHBFKy91NHYyVVRz?=
 =?utf-8?B?UFR3cWRKL3dwT0dVRXZReVlxVzJyNXhCYUlyL2xsK1N0Y1ZzT1ZkWDliNzJB?=
 =?utf-8?B?ZjE5RXJsMXhEakNyazB1QVJQUlg2bGd5NmFMRUpDL05vMmhOdWRWaVBLY2ZK?=
 =?utf-8?B?Sm1jRHdRc1pKMDZKVHpmbzNqbUhPakpiL1ZJcFJUZHcybkxFcjM1VTg0Sy80?=
 =?utf-8?B?MlRhVlorVUZETG5xbmY0TlhDK1J1NEFaN1M4djN4cDhEdjMyanZ1VElBbXpn?=
 =?utf-8?B?OWJ4ZlNueE5UdnBWeHpFdTVjUHYyM1doajNwamlyU1NodDRrVFNtVG4rNGk4?=
 =?utf-8?B?OEs0cVhhelFxbStVWndkNFdKbUdxRHRHeDBjdmRyaHQzMHI2aCtRcS8ySi9a?=
 =?utf-8?B?b0RRNkRwU3VjR0Q0MlJpUkNTdGxZYi9Ob1ZLcnB1WUtoV0MzRjFzVEx1VlVn?=
 =?utf-8?B?YU9wTEJpR1ViSGMyRnNYcVF1M2VRVU50dHZlMFVRckw5WWsvOEZtRzhKd05C?=
 =?utf-8?B?bmkrTENkdy9yZzZvb0hGMFUxMlJuZml3dHBtVnZTVzJqajZ6c29qdmVraFNP?=
 =?utf-8?B?cFhKUU52TnE3RnpzVzZFNUtwV25uYU11N2JwWGRqeVkxTjJwWDQwejlmR1Zs?=
 =?utf-8?B?MG1zMjV2Z0VGc0NNMk5VRCtqVmtJRlFoTXZ2WnN2KzNhbHRzaFVwaWNhZThv?=
 =?utf-8?B?eEUvZEoxbU9CSitwZy9RY1FjbjdvbFVicTE5WWRNS2IwVkEzenpaRER4ZEJK?=
 =?utf-8?B?RHdrWlRlN1BvWUZhTXVJNXB5ME50T3BNUDBQamJiRUQ2LzRLZFhnN1BtMkVp?=
 =?utf-8?B?SDY5Q2Q4TlJFL3pGUncrVEZaREJOS2ZYZk03ZmJ4UU9KbnZtQS9ScllpSjNT?=
 =?utf-8?B?SE5VSUY3NUVDVEI5U3FaOEZ4alB1TlBvSDMxNjJtTkVzY2lDS2I5dlpuQjlY?=
 =?utf-8?B?M2FKUHUzSW9qeHZMYngvSTZUOVZpaGxUcHZTMFJLUXVWMDJYVDhkOTdTZjYy?=
 =?utf-8?Q?BpyddRJOC4T/g3blGen8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdRVFBkRXd1TXRtVTd4ekN6dFpTU3NQQ2FZYXphbjk1ZC9OUUhoSFVjdWU1?=
 =?utf-8?B?dDNxRHVwUFhKRkVrQllDTDROL0l0WmM1bHZiQmZSOWFaWTFvMkVBVXBmOU9K?=
 =?utf-8?B?Mlk2Q0llL2xvYnJYOTZpajV6K3dBRHRRSkt2amNmck03VmpjaDVTcGF4M0Jv?=
 =?utf-8?B?S3p6S0RuUm1sVkVlZDkyMTdpbEl2NmE2SXNET256M1Q1dmI2UXo4WndSOWxo?=
 =?utf-8?B?SmZIU1dVMjNEQ3A5Y0ptSFd2bEF4Zzg2WnNWNFZucjJsNU5wRmJuSnBPZ0VW?=
 =?utf-8?B?Ukd0ZVVHaTVMdTBLd3VzNUoxenZac2U4c2hzVFV1elZqZmRzZ0VCVUErdEVC?=
 =?utf-8?B?UDB1aUVFT0ZGNW50MEZtZlRaM1JxQmZnTTk2aVhmZDJYQ1dxWmREak9YMDFu?=
 =?utf-8?B?WmJMMjJRK0x4RVU4cmZuVHFTSzNRWjZYUnJ2bG1EcTJDWDczbzhsd2hyUmtI?=
 =?utf-8?B?ejBxZ2tZZy8wb0wwZ1l1cldsdnZtTE5UVDRyc293dFlDQ1NQR0NKY0YwbEJI?=
 =?utf-8?B?TysyZDNuWTFqcmZ5Rk5KWi9tMWVlZWhtcEIxTGtZNmc3TUZrTXpxQnJSSGlw?=
 =?utf-8?B?REdab0RWYjg3MGI0T2wyQTVXWUFHYnE5b00rdEJnV05EdHBJRXh5M1h2MTBa?=
 =?utf-8?B?eEhjdFBaSmJheTl0RnF5cStjY2xWUWVxLzhuVjN6SS9KRzJ1ek1ROVh5Slh1?=
 =?utf-8?B?MmM2aE5GQUNpb2dDek5jSVcwY2ZPRXBGbG9odlZ2enpKU2JrSGpvbDczMGFj?=
 =?utf-8?B?WVFZMGYrbDRVRjJ3VlhQL1BLVWhyTml4TTkxVVlSZi9ZS3VnMzU4YU9wNHhv?=
 =?utf-8?B?amdYM21Yc29KeGNoUjhKL1lhZHh6aGl2Mm5MM1JEVjcrVDhpSmdna1MyVzNL?=
 =?utf-8?B?WVpYbmdyS2JPNFMxdlp5WGFYeDhJNERkeFo1WjBzQmpvcFBXQVlWTTcyQXdX?=
 =?utf-8?B?TzlPN0htK3Jjc1VnaU5wbDlkR2RRTElCWmVDbGF3TTFHVWk4YWpIenNKcTVG?=
 =?utf-8?B?SjArK0pBMG8vUXVxdDFrdFN5aUNmK1RmNk1XVXpGRVZpT2dobll4WE1YTWZM?=
 =?utf-8?B?SExFa3FhTTEyRldWVzhqT0QzaTB2OGxuNXZ3cDY0R3FzODIyWExacDVuS0Fq?=
 =?utf-8?B?OU5RYTFSS2lFUS9wck9ob1ByTnlVSHJ0MXo5bGE4QVp0QkFMd1hOSVBhMExy?=
 =?utf-8?B?WXZvc2JlMkVhYUhwRDZQTDJkbE1JWTlQRk9hQmlReURMeFEyUWw0NnRiRnRj?=
 =?utf-8?B?Z0VPRVlucTN5TktkaWltbExjWUQveEtuaXdDYm4rU0JIaXdsSC9DQTV6VGZL?=
 =?utf-8?B?cFc4WHRyNFQ3K1lhNVp6SG5iRXY2S21HeHNnQVE4RHZRWkVVUnZFSGVPUkVQ?=
 =?utf-8?B?ZkRhdjdVOVZhYlNlQmY2VTJLcjBvYW1iRWJkaFhIUndtNUk5Y0IzRWM5RkJq?=
 =?utf-8?B?YnhuUWxHUE1VaVozRUpkdmtmZHkxWU5xeXVGMkg3Njk2TE1tcG5ZOVFoMDQ3?=
 =?utf-8?B?N1k1ajBudlN2ckhLdlp0blZhZ0ZHTGYzeFFqd2F6L2hDOXZvVzE1Tm4vb1lN?=
 =?utf-8?B?UE4rTFlXWGcxOVZhSU1hZm5KZDQ1YmpKaXZWYnpqeFlENGhGaklocmhsbTB4?=
 =?utf-8?B?eGpIa2Y4OVF0dXRXdVd3aGZSWWtlYm1hTmZFUTN3SkM5SFpPVkhFY1hzTTVG?=
 =?utf-8?B?cnBXODY3Q0RsZmZlSkVKa3orTVdnL01JZGhUc0Q3bndqazgzb1NTVlVmYjhM?=
 =?utf-8?B?UVdabUh6MjlXTXI3azFsVWI4YmliWTNNYUhyOTZiVHp4V04wNmE5U3hjd1Zz?=
 =?utf-8?B?WTBGVm84Rm5zSUMxU3c0dGtmWHEvT0c0UWUrcktqVmNDN3VocFdxVU92eDR4?=
 =?utf-8?B?R2ozQmp1Nm1qU3NhZkxtZHBJNGp6YlZvWlloSERqSW8zSjFmbzhoMEFqdTFY?=
 =?utf-8?B?bWVNUDJydjczWFRLRE1hbHU0SDhySGdBVStTMmpNQWRtOHFZOTdENC9MTzZm?=
 =?utf-8?B?dDlnS1dMVnYzblBob1ZiN1R6VWthM2FGZEYrYyt0MUZwR1MyVEQ0QmlhUUZ4?=
 =?utf-8?B?UDBEbUVrR2wvanBydHlzTWJLVXJ4VzZ6emcvTWZxQm45RHFKN2dlWE1uTmwr?=
 =?utf-8?Q?SPRizEO8bf93wgcbsuA7EWWnW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668633e0-c547-4bd0-8fc3-08dc9604d275
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:24:23.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcHZ+VCj0NA/dCJeMdTkz014XyowjXffQEYgj3v4gFZxSNWQQkddOw6PAHrazVFhLGOuyyG/HNxZNHDPmMdXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194



On 6/26/2024 06:10, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 02:56:22PM -0500, Avadhut Naik wrote:
>> AMD's Scalable MCA systems viz. Genoa will include two new registers:
> 
> "viz."?
> 
Right. Will mention Zen4 instead of Genoa.

> Not a lot of people outside of AMD know what Genoa is. Zen4 is probably a lot
> more widespread.
> 
>> MCA_SYND1 and MCA_SYND2.
>>
>> These registers will include supplemental error information in addition
>> to the existing MCA_SYND register. The data within the registers is
>> considered valid if MCA_STATUS[SyndV] is set.
> 
> From here...
> 
>> Add fields for these registers as vendor-specific error information
>> in struct mce_hw_err. Save and print these registers wherever
>> MCA_STATUS[SyndV]/MCA_SYND is currently used.
>>
>> Also, modify the mce_record tracepoint to export these new registers
>> through __dynamic_array. While the sizeof() operator has been used to
>> determine the size of this __dynamic_array, the same, if needed in the
>> future can be substituted by caching the size of vendor-specific error
>> information as part of struct mce_hw_err.
> 
> ... to here this text explains what the patch does. I guess it is time for my
> boilerplate text again:
> 
> Do not talk about *what* the patch is doing in the commit message - that
> should be obvious from the diff itself. Rather, concentrate on the *why*
> it needs to be done.
> 
> Imagine one fine day you're doing git archeology, you find the place in
> the code about which you want to find out why it was changed the way it 
> is now.
> 
> You do git annotate <filename> ... find the line, see the commit id and
> you do:
> 
> git show <commit id>
> 
> You read the commit message and there's just gibberish and nothing's
> explaining *why* that change was done. And you start scratching your
> head, trying to figure out why. Because the damn commit message is worth
> sh*t.
> 
> This happens to us maintainers at least once a week. Well, I don't want
> that to happen in my tree anymore.
> 
> You catch my drift? :)
> 
> So, now, how are those new syndromes going to be used in the tracepoint and
> why do we want them there?
> 
Yes, I catch your drift. Will reword the commit message to explain that the
new syndrome registers are going to be exported through the tracepoint
in a dynamic array, as they are vendor-specific, so that usersapce error
decoding tools can retrieve the supplemental error information within them.

>> Note: Checkpatch warnings/errors are ignored to maintain coding style.
> 
> This goes...
> 
>>
>> [Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]
> 
> Yes, you did but now your SOB chain is wrong:
> 
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> This tells me Avadhut is the author, Yazen handled it and he's sending it to
> me. But nope, he isn't. So it needs another Avadhut SOB underneath.
> 
> Audit all patches pls.
> 
Wasn't aware of this chronology. Thanks for this information!
So, IIUC, the sequence for this patch should be as follows?

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

>> ---
> 
> ... right under those three "---" as such notes do not belong in the commit
> message. Remember that for the future.
> 
Okay. Will move the note here.

>>  arch/x86/include/asm/mce.h     | 12 ++++++++++++
>>  arch/x86/kernel/cpu/mce/amd.c  |  5 ++++-
>>  arch/x86/kernel/cpu/mce/core.c | 24 +++++++++++++++++-------
>>  drivers/edac/mce_amd.c         | 10 +++++++---
>>  include/trace/events/mce.h     |  9 +++++++--
>>  5 files changed, 47 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index e955edb22897..2b43ba37bbda 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -122,6 +122,9 @@
>>  #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
>>  #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
>>  #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
>> +/* Registers MISC2 to MISC4 are at offsets B to D. */
>> +#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
>> +#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
>>  #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
>>  #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
>>  #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
>> @@ -132,6 +135,8 @@
>>  #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
>>  #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
>>  #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
>> +#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
>> +#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
>>  
>>  #define XEC(x, mask)			(((x) >> 16) & mask)
>>  
>> @@ -189,6 +194,13 @@ enum mce_notifier_prios {
>>  
>>  struct mce_hw_err {
>>  	struct mce m;
>> +
>> +	union vendor_info {
>> +		struct {
>> +			u64 synd1;
>> +			u64 synd2;
>> +		} amd;
> 
> I presume the intent here is for Intel or other vendors to add their
> vendor-specific stuff here too?
> 
> I'm also expecting that shared fields will be promoted up to the common struct
> namespace. Pls add a short comment explaining what the goal with that struct
> is.
> 
Yes, other vendors can export their vendor-specific data through thier own
structure within the union. Yes, shared fields can be promoted to the common
structure. Will add a comment to explain the endgoal.

>> +	} vi;
> 
> Call that "vendor" so that in the code you can have
> 
> 	err.vendor.amd.
> 
> or
> 
> 	err.vendor.intel.
> 
> and so on so that it is perfectly clear what this is.
> 
Will do.
>>  };
>>  
>>  struct notifier_block;
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index cb7dc0b1aa50..fc69d244ca7f 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -799,8 +799,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>>  	if (mce_flags.smca) {
>>  		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
>>  
>> -		if (m->status & MCI_STATUS_SYNDV)
>> +		if (m->status & MCI_STATUS_SYNDV) {
>>  			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
>> +			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vi.amd.synd1);
>> +			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vi.amd.synd2);
>> +		}
>>  	}
>>  
>>  	mce_log(&err);
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 6225143b9b14..3bb0f8b39f97 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -189,6 +189,10 @@ static void __print_mce(struct mce_hw_err *err)
>>  	if (mce_flags.smca) {
>>  		if (m->synd)
>>  			pr_cont("SYND %llx ", m->synd);
>> +		if (err->vi.amd.synd1)
>> +			pr_cont("SYND1 %llx ", err->vi.amd.synd1);
>> +		if (err->vi.amd.synd2)
>> +			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
>>  		if (m->ipid)
>>  			pr_cont("IPID %llx ", m->ipid);
>>  	}
>> @@ -639,8 +643,10 @@ static struct notifier_block mce_default_nb = {
>>  /*
>>   * Read ADDR and MISC registers.
>>   */
>> -static noinstr void mce_read_aux(struct mce *m, int i)
>> +static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
> 
> This whole conversion to struct mce_hw_err here belongs logically into patch
> 1.
> 
Had considered this. But struct mce_hw_err *err wouldn't really be used in
mce_read_aux() in patch 1. Only struct mce m, which is already available, will
be used.
Hence, deferred the change to this patch where usage of struct mce_hw_err *err
is actually introduced in mce_read_aux().

Do you prefer having this change in patch 1 instead?

>>  {
>> +	struct mce *m = &err->m;
>> +
>>  	if (m->status & MCI_STATUS_MISCV)
>>  		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
>>  
>> @@ -662,8 +668,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
>>  	if (mce_flags.smca) {
>>  		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
>>  
>> -		if (m->status & MCI_STATUS_SYNDV)
>> +		if (m->status & MCI_STATUS_SYNDV) {
>>  			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
>> +			err->vi.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
>> +			err->vi.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
>> +		}
>>  	}
>>  }
>>  
>> @@ -766,7 +775,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>>  		if (flags & MCP_DONTLOG)
>>  			goto clear_it;
>>  
>> -		mce_read_aux(m, i);
>> +		mce_read_aux(&err, i);
>>  		m->severity = mce_severity(m, NULL, NULL, false);
>>  		/*
>>  		 * Don't get the IP here because it's unlikely to
>> @@ -903,9 +912,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
>>   * Do a quick check if any of the events requires a panic.
>>   * This decides if we keep the events around or clear them.
>>   */
>> -static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
>> +static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, unsigned long *validp,
>>  					  struct pt_regs *regs)
>>  {
>> +	struct mce *m = &err->m;
>>  	char *tmp = *msg;
>>  	int i;
>>  
>> @@ -923,7 +933,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
>>  
>>  		m->bank = i;
>>  		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
>> -			mce_read_aux(m, i);
>> +			mce_read_aux(err, i);
>>  			*msg = tmp;
>>  			return 1;
>>  		}
>> @@ -1321,7 +1331,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
>>  		if (severity == MCE_NO_SEVERITY)
>>  			continue;
>>  
>> -		mce_read_aux(m, i);
>> +		mce_read_aux(err, i);
>>  
>>  		/* assuming valid severity level != 0 */
>>  		m->severity = severity;
>> @@ -1522,7 +1532,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>>  	final = this_cpu_ptr(&hw_errs_seen);
>>  	final->m = *m;
>>  
>> -	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
>> +	no_way_out = mce_no_way_out(&err, &msg, valid_banks, regs);
>>  
>>  	barrier();
>>  
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index c5fae99de781..69e12cb2f0de 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -792,7 +792,8 @@ static const char *decode_error_status(struct mce *m)
>>  static int
>>  amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>>  {
>> -	struct mce *m = &((struct mce_hw_err *)data)->m;
>> +	struct mce_hw_err *err = (struct mce_hw_err *)data;
>> +	struct mce *m = &err->m;
>>  	unsigned int fam = x86_family(m->cpuid);
>>  	int ecc;
>>  
>> @@ -850,8 +851,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
>>  		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
>>  
>> -		if (m->status & MCI_STATUS_SYNDV)
>> -			pr_cont(", Syndrome: 0x%016llx", m->synd);
>> +		if (m->status & MCI_STATUS_SYNDV) {
>> +			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
>> +			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
>> +				 err->vi.amd.synd1, err->vi.amd.synd2);
>> +		}
>>  
>>  		pr_cont("\n");
>>  
>> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
>> index 65aba1afcd07..9e7211eddbca 100644
>> --- a/include/trace/events/mce.h
>> +++ b/include/trace/events/mce.h
>> @@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
>>  		__field(	u8,		bank		)
>>  		__field(	u8,		cpuvendor	)
>>  		__field(	u32,		microcode	)
>> +		__field(	u8,		len	)
>> +		__dynamic_array(u8, v_data, sizeof(err->vi))
>>  	),
>>  
>>  	TP_fast_assign(
>> @@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
>>  		__entry->bank		= err->m.bank;
>>  		__entry->cpuvendor	= err->m.cpuvendor;
>>  		__entry->microcode	= err->m.microcode;
>> +		__entry->len		= sizeof(err->vi);
>> +		memcpy(__get_dynamic_array(v_data), &err->vi, sizeof(err->vi));
> 
> So that vendor data layout - is that ABI too? Or are we free to shuffle the
> fields around in the future or even remove some?
> 
> This all needs to be specified somewhere explicitly so that nothing relies on
> that layout.
> 
> And I'm not sure that that's enough because when userspace tools start using
> them, then they're practically an ABI so you can't change them even if you
> wanted to.
> 
> So is libtraceevent or all the other libraries going to parse this as a blob
> and it is always going to remain such?
> 
> But then the tools which interpret it need to know its layout and if it
> changes, perhaps check kernel version which then becomes RealUgly(tm).
> 
> So you might just as well dump the separate fields one by one, without
> a dynamic array.
> 
> Or do a dynamic array but specify that their layout in struct
> mce_hw_er.vendor.amd are cast in stone so that we're all clear on what goes
> where.
> 
> Questions over questions...
> 
Should we document this where struct mce_hw_err is defined, in
arch/x86/include/asm/mce.h? Or do you have any other recommendations?

IIUC, the libtraceevent library relies on tracepoint's format in tracefs. Below
is the format with this patchset incorporated.

[root avadnaik]# cat /sys/kernel/debug/tracing/events/mce/mce_record/format 
name: mce_record
ID: 113
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:u64 mcgcap;       offset:8;       size:8; signed:0;
        field:u64 mcgstatus;    offset:16;      size:8; signed:0;
        field:u64 status;       offset:24;      size:8; signed:0;
        field:u64 addr; offset:32;      size:8; signed:0;
        field:u64 misc; offset:40;      size:8; signed:0;
        field:u64 synd; offset:48;      size:8; signed:0;
        field:u64 ipid; offset:56;      size:8; signed:0;
        field:u64 ip;   offset:64;      size:8; signed:0;
        field:u64 tsc;  offset:72;      size:8; signed:0;
        field:u64 ppin; offset:80;      size:8; signed:0;
        field:u64 walltime;     offset:88;      size:8; signed:0;
        field:u32 cpu;  offset:96;      size:4; signed:0;
        field:u32 cpuid;        offset:100;     size:4; signed:0;
        field:u32 apicid;       offset:104;     size:4; signed:0;
        field:u32 socketid;     offset:108;     size:4; signed:0;
        field:u8 cs;    offset:112;     size:1; signed:0;
        field:u8 bank;  offset:113;     size:1; signed:0;
        field:u8 cpuvendor;     offset:114;     size:1; signed:0;
        field:u32 microcode;    offset:116;     size:4; signed:0;
        field:u8 len;   offset:120;     size:1; signed:0;
        field:__data_loc u8[] v_data;   offset:124;     size:4; signed:0;

print fmt: "CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s", REC->cpu, REC->mcgcap, REC->mcgstatus, REC->bank, REC->status, REC->ipid, REC->addr, REC->misc, REC->synd, REC->cs, REC->ip, REC->tsc, REC->ppin, REC->cpuvendor, REC->cpuid, REC->walltime, REC->socketid, REC->apicid, REC->microcode, __print_array(__get_dynamic_array(v_data), REC->len / 8, 8)

So, yes, the tools which interpret the vendor data need to aware of its layout
if things like FRUTEXT are to be decoded from the data.

Just FYI, patch adding support for this in rasdaemon, has already been merged in.
https://github.com/mchehab/rasdaemon/pull/122/commits/926c2b39c6386d0a1bf4232977f9fd7e37850361

> Thx.
> 

-- 
Thanks,
Avadhut Naik

