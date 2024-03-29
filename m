Return-Path: <linux-edac+bounces-855-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA5789218C
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 17:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FCD1F2510E
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C88593D;
	Fri, 29 Mar 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2XYJYlE+"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDD2E84F;
	Fri, 29 Mar 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729362; cv=fail; b=MmqGobdLtTwSJqjQFApqcAxh3y5j3Ds0TJ8RDPcLEPkFoeR4oJTGTU6PTjRfReiSxRCcWRv264UbZbGI1dZWwINb9pGUwpSF8TIrB6muwaCdHPItVanh6/HgJLg0chg37TAQMQ9x+oU9bXvHJfkJMSEfaJMhNT633cB7S9Kkkck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729362; c=relaxed/simple;
	bh=vHUcrX5KwqN3PwNPkf2rZycNq+z7xzeMB6ESEp9gP5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tIcG9vfmJbP6injYQKL3G3Gp0qr4ur6soHw/veB9ZLnSOX9Y1GmDH36Bt1CFgeESsHLHdWcafpK6Gtz07GIczWke01E3mKVZj4IsFX1ngjd3jlg2wQe2TClvtoWkqlrz9gYNyBi0g0RhS1CoX6hXSn/5qFKiATf/GV6CxhayNS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2XYJYlE+; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn2a58awzdzcC+eHHjcAjNQ4d5FWnMl5yIdhWbjB43JpxLlnzgoqz7/C7fcuJyTLeQxCT5iWZOoSj7GK20X+F8FsCRbXtuuz9RhWUS+uRQYSi36wPpIk4rWmtcFK9JKL0RvuEdpc+fZcVacIqHJLs4vK/eDn2mZxGqykWDd54vObw9xs2NU3FdRB4KVAiCw86FXJxeNpkdREkVx/leSisKzx1fGTMM6sd/n1R1Z3Coe9udc6lgFzwNZF9Y+OJ/rPgPLLC5I9WbWzeGKIg8zLaAW1GjBW688ufHUa7+i66XVo7RjxaOhPhHYJ62wGlfuZXvJvBmlfWSspEqp7PxIo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mZPBrMXJl7093Scj9dwANyMPhxd9+rCRuj7oNe20GE=;
 b=PWb9MFJAlHuHxhnuv4C8KudGrG98Xjv8Hb9LKJKjWpO9FZAevqbHuQ7uS71fW8rbd/NkwuZ/3dXA4JJXcV7RI8lx3LMpk6gP1BpnkEdkSxOvqiwjip7hGxifP2uf5JsN9JrU+OB4W9qDR7wtmsppjEp5g1diRd4avIT1Unpt85KeaclL/Zt0MIqgT8o9o+IjWsNIcOK6xvDToMeMrG51oVxCq5YsN1WQZdLVuXVzb3ovq/evv6ZOEKasuWTgMQgPTIPscJ20cKPdNncOFa1wedR+GxejOgVAPSqmHbSHa6TQAFma6JjrucXI6Iu+bwDN64YEez9+TKoKcxvo9TRnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mZPBrMXJl7093Scj9dwANyMPhxd9+rCRuj7oNe20GE=;
 b=2XYJYlE+DbSxlgARgTMxolILKir4P3ToseRTTaZB7LJt6Z+aq68+ZDUsCgYPCBPvBqq9kLFqPIn40Su87zpYK8wnyO5wvNzXekCw9FHUKvWgvRYgF4CN1f80Rq3cU6RReE4/vYGrFCG10sdUiNmbp3dexahQz8KlAUjft9CA3y0=
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 16:22:37 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 16:22:37 +0000
Message-ID: <93895d82-ae81-4fa3-8d58-9958d7130dcd@amd.com>
Date: Fri, 29 Mar 2024 11:22:35 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] x86/mce: Clean up TP_printk() output line of the mce_record
 tracepoint
To: Ingo Molnar <mingo@kernel.org>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 rostedt@goodmis.org, tony.luck@intel.com, bp@alien8.de, x86@kernel.org,
 sohil.mehta@intel.com, yazen.ghannam@amd.com
References: <20240328180435.435076-1-avadhut.naik@amd.com>
 <20240328180435.435076-2-avadhut.naik@amd.com> <ZgZpn/zbCJWYdL5y@gmail.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <ZgZpn/zbCJWYdL5y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|IA1PR12MB9031:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E9hxufn1/sQMgBj74AOCKCt2+TkscEuK4e4t1+l9F/Nc7WQxPIZCmfK4Gl+LcasD/LVU6XJQiFlAn0yS/EOwJ5XRX1bQJs2IgGR68BJPmIf5aybv4ez6AAOGIQnm5T9wqj9QA5SUNByZcQjIfv3cdj9bKxSubMFJHEleE6qQf/CX2rn6/mkn6Y+SBzDcRb0GiyjV0wKtIpZmzuBfCRrbrySeR77LmQcEN51Flxifeh1k0XHbDC/ID/kBLRjaqga2L9twdEyZb/paHUQN99ic+l42h8a1cmBCi6XNhZlsLYxgIr8d9TAV27u1sInD3opjdSinm/t+KSfHfUnkbnw0AFzscbjgj3k1fsuiiwm/Jve/CctjxKlMzAR3Q6vFtoiZuYDCFqfcm8CCc753o3TtiCVAwKnfNcLpN/rrhdF1kpHv7ZTOaugwdGZoDHwunwR7QyWZRlgvNPtVJlWWQFZo9XXbm+0v5kdH9EwBg+NS8BFnrnxtsegnipSSxXhWP/nYkVZKDDMR892/qZ3TQqaLZ+BslvaBGJv4yfjwpWQEBlRbnHVN14rDkCvtdOGntz03R+RWghkl6jhPja23RKI5EhY1qXQJTAAQZmTrvk4VxIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVFjcjN4Sk9ZdkxVa1JiUm1EeXM5eE5BQ0F0S0MxRHJ2RS9JcWQzcEtVZFFZ?=
 =?utf-8?B?eGxiM3FOUzJnd1h0b2I1WUI1ZE8yZmNBeG0vaG40a1FMa3AzTTBaaGFaVmtp?=
 =?utf-8?B?ZUJYNklJbTh5TVVIV2VUS2hnbTNveW1hK0t1OGtoUmZKcUtRVVI3WFdoeWVR?=
 =?utf-8?B?dnZSKy9wRzQ2bnkrbkYrc1hFU2JXS29zd1RHRjJKMEtEcTVIVm13YmN1RGRN?=
 =?utf-8?B?ZS81a3B2bjcxM3grZFFzMllKaXZuMEpobkVSSUZka0RjSUxkN2VHWVU0Y0Zq?=
 =?utf-8?B?Vk1jTDBaa052SVlYcFUxOE1uUjdWQ0ZpVmUzRHVDVUJlUmIvbCt5M0VtQTd2?=
 =?utf-8?B?T2lrSlNPS3pZSmFsNTVsWGtOWlRCaU1xQ0ZrSC94OUVHbTFQSUVuQ2V5U2k3?=
 =?utf-8?B?L09jZDhJelFVZ3FKVGJYR2pqd2ZKMlMrUUxzWEN1YXZjNnFkTVlvVjRUdUpC?=
 =?utf-8?B?SGNiRk8wSVN2Tythamx3Y0g0d0NTa2lDWkE2TXdtMUpxWlZNWmFKTmZpV05V?=
 =?utf-8?B?UEZ5ZXBCUkNLM2dVTlh1c28wWkgvbkRuRHI5a3lCN3NQdWpQV2dtQk1DdXIw?=
 =?utf-8?B?R0Fwb044OEw1dlhEai9WWTBBM01pQXo0UC9VQjJlZUNvK3FndmhObHg3Yjcz?=
 =?utf-8?B?UERYM2NLR0gycDdNejR4TWRDOXZ0OWhJWmlBbllzVFZET0JaMWszUjJPeUhQ?=
 =?utf-8?B?bzBZRVYvdFBDd1M2NkoveWllMG50ejUzK1oxVHFzSzhraDgwNjVIY1dEQTFy?=
 =?utf-8?B?TUFmVUdKZHlJcktGamZVc1JuOHdNd0hBYVY4SmlCK25URUJxcjhEdWQ2Z0Js?=
 =?utf-8?B?MkhkUTd3TDF1d3cvM09UTmlwU2F0VVgvNlhZRm9WZEs2cm1hdWZ0K0plcGo3?=
 =?utf-8?B?UTV3T2hrVjNvNlpCQmNoV2d0d0RlVXpLV2ZZT1huV0dtRGdpeEQrVFBNbDNL?=
 =?utf-8?B?TlNwM1FHSFJYNWJNNGtndVJ0ckpLTTZzSnQ0SnJUVVRObFlBNTgzOTNyeGY5?=
 =?utf-8?B?WTNleXNSalgzK1dJUWR6RHREWnN5c0N4YURJcU83dDVuY2djbDVmWTJPUG1V?=
 =?utf-8?B?MGhDZE4valdQcGE1MldEbjBhU2NsKzY0VUxNNWxPeHoxTDRMNGt0S1lLK3RR?=
 =?utf-8?B?NkpwNXZWRnVTWkpLNlZ1VGMvc29TTnRCNzJwc2Fmdm1MR0pUZW5IbUVGUjFG?=
 =?utf-8?B?S0RpdnAyWjc0cnRtY1llUlk5elpQQjdmWmg3TzE2RlYzQWVQSTQ2aGRpamIx?=
 =?utf-8?B?RkgwTXBVQWtlTk1rQk9FV2pGSjlqd2I5cVFwYW5ORGw5TUlWbHEzYkZST3gx?=
 =?utf-8?B?RWJwWTFwTFkveE5MQUhZYlgxVDBkU1hxVXYxdkNOMll4TDZidnRmOGhzSitO?=
 =?utf-8?B?bno1SEJPMkVPSExOUkJSeFJaZVdjcUhVc2QySkZ5dlVGTHdRRDZDQm9MRFlo?=
 =?utf-8?B?OC8wWkhWb3Vha0JFWkMxR3hDK2ZVTnZXOUlDZktWNnVmVHowRi8vYXUyNU15?=
 =?utf-8?B?bHJ3R0NJbEw0cjR5WHg0WFpEMTdrcktBUHhhdzNjV1lVMXFvdHhpZXVZcDdW?=
 =?utf-8?B?K05IbzE2a0tPeVVSbDNONFZ5TFVJWldPSUtLQzR3OE1nTHNwb2JLSHBlMUEv?=
 =?utf-8?B?ajFNMjdheU5WM1N2K0g1eGN3MWdpbzRTYTRKQlRRK2VnM2dmT2JCVzViTGp6?=
 =?utf-8?B?NCthbURpeUZzZjRPSXY1SXFiUnZrR0p2WWJOMHRaQy9qYm1uSGNMVXBpMGFC?=
 =?utf-8?B?QmtXbGpvdEphay9wbUNFZjZ5cUpvL3l0TUZIYTBYUEpDZGg4UWdtR2dzSVNr?=
 =?utf-8?B?aksxS2pTNDNTYzUzNEtoL2gxSWV4aFJ3Vi8zRG9YVmxYTXlvNUxDSlJVUXRE?=
 =?utf-8?B?Vk5DdFNxbUg5THlFU2JGalZQanFmQW5YMXNmcklUd3VveXRTc3gwT3AweitL?=
 =?utf-8?B?R0UzRml4Z3JCTGg0eXF5aDlsNFZTMVUrNnpIRGlQUnNWOVc1d2hlWTQ1eldw?=
 =?utf-8?B?cCtpNHFSR1lMcVJVUHhsMUlXa2ppYUlTaHpaM3BsRlRPSVE1bG5VU1laVUc4?=
 =?utf-8?B?RDhWbHF5dGMwQ011dnBHdFBkeUYwTzl2TkR0S2gxSWd4cEdZVCtxSThNSDNp?=
 =?utf-8?Q?pIH10DBH7y32OBP428XR7gXZy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168c6561-5890-48e2-e626-08dc500c72c9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:22:37.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gozGYdj06Bl95rr0edEJPuN2CqFrfu99XKa5S3D9HCUt0aozoN4SOsEQpQr5BTN+pXojE13iVHtJP2grWIkxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031



On 3/29/2024 02:11, Ingo Molnar wrote:
> 
> Please split out the other (capitalization) changes to the output into 
> a separate patch.
> 
Okay. Will put the capitalization changes into a separate patch.

> - While at it, don't forget to:
> 
>    s/ADDR/MISC/SYND
>     /addr/misc/synd
>
These are actually acronyms for Address, Miscellaneous and Syndrome registers.

It was recommended to keep the acronyms in ALL CAPS. Hence, didn't change them.

https://lore.kernel.org/linux-edac/20240327205435.3667588-1-avadhut.naik@amd.com/T/#m0c04f1c0deaa0347af66653a5950aad5f6b320e7
 
> - Also, it's a bit weird that we have 'CPU' but also 'processor' 
>   fields, why isn't it 'vendor' and 'CPUID'?
> 
Think it has been this way since the tracepoint was created back
in 2009. Will modify the field per your suggestion.

> - Finally, why are some fields 'merged' as per ADDR/MISC/SYND, while 
>   others are listed separately? All that have separate names should be 
>   listed separately.
> 
Will separate the fields so that each is listed individually.
> Ie. something like the patch below?
> 
> Thanks,
> 
> 	Ingo
> 
> ============>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Fri, 29 Mar 2024 08:09:23 +0100
> Subject: [PATCH] x86/mce: Clean up TP_printk() output line of the mce_record tracepoint
> 
>  - Only capitalize entries where that makes sense
>  - Print separate values separately
>  - Rename 'PROCESSOR' to vendor & CPUID
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/trace/events/mce.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 1391ada0da3b..c5b0523f25ee 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -55,15 +55,18 @@ TRACE_EVENT(mce_record,
>  		__entry->cpuvendor	= m->cpuvendor;
>  	),
>  
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, addr: %016Lx, misc: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
>  		__entry->cpu,
>  		__entry->mcgcap, __entry->mcgstatus,
>  		__entry->bank, __entry->status,
>  		__entry->ipid,
> -		__entry->addr, __entry->misc, __entry->synd,
> +		__entry->addr,
> +		__entry->misc,
> +		__entry->synd,
>  		__entry->cs, __entry->ip,
>  		__entry->tsc,
> -		__entry->cpuvendor, __entry->cpuid,
> +		__entry->cpuvendor,
> +		__entry->cpuid,
>  		__entry->walltime,
>  		__entry->socketid,
>  		__entry->apicid)

-- 
Thanks,
Avadhut Naik

