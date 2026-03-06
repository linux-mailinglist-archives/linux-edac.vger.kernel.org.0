Return-Path: <linux-edac+bounces-5775-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCACKNvtqmmOYAEAu9opvQ
	(envelope-from <linux-edac+bounces-5775-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 16:08:11 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6B2237CE
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 16:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BB56306D8E4
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723B3AE6F9;
	Fri,  6 Mar 2026 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4fB2Nym2"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4603AE1A5
	for <linux-edac@vger.kernel.org>; Fri,  6 Mar 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809439; cv=fail; b=gTkNRWIwMgg9ozvIX02WCyTiaEaWi/2ByZ1VhnHj54SmF+u9PlGRVaDX6uyOSOZy7jSXedbIrGp4RSdUkhFrMo4z9jWjzDjULEKFlYkv8ZErUFpG/Rx/TipLe2RgsVFsaAtfDSTSNWjTl/ZyoOhkmPtR0xgZg+qmN+YM4sLpuyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809439; c=relaxed/simple;
	bh=OvLYHHz8bJIi4xhZt5U/o4mfwto9bIkOb/dVFuc3qUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oIX4MiL3rDs6v7A2WmG+ntzMBq8xdLNEHRbjk82Gu4bzgluVu0C1z1ezFLypwajKWwMOfmDnMRjKgBYBrbNQYnJedZQ+FVqopwTkMnGwaOEr//3wyDdJq2EN/fhTmPmwC6+2nmsODUztkbJqlJz0j1hfiLNAxKkC1ss2g65beeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4fB2Nym2; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgMdZRanlBq7u1HXHJZk6rFq+d35FdPMsfnxG0cI6qgd1RNZ57yEvr8RXKUJ679gZtmuIllu/yqBnkIfQtHao/zbNdgMSxo0d0UrbWu9AMER1C6B+CuIjp41JBp169bHeTNg3wT8grHfy2fCuzsfhD9L+EpEApQYXPQLFbvie29z3X9E8Ysc1zRGjHeeryAsla4CkKrSupRYbg+0GamGnCmcLcJJsPyBWM3DFa0hsK0kojslJ22ATdkMqY+y+UO3V5kx/e68G2gl+7qlG8uxw10abJALnrHwzaafk4SYdQQSIWvNbRKbwmC+gnAzY9yP0/Ln7F93+i1B8Q3RwXQtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvM+Ask5PQvdqCDJkU4E9yh5d9aAE8O4X4jSV5DRNaE=;
 b=jAbcWebAqde0PWbSwleukkBDMPQUtLQSgE64uFzlSzE5mjl1p8HH4huE6ITnkY7teYoYtc5sEGZiOP6IKbL88xTVb48PqS2lKH/f9X+b9Cq5XoSAUS7D+WhCpX3U+RvBh3n/OYyGMzJOSmox0AcviSxwrm8p5HXwE28hjU50/YYBTg7Ysc2KCn1vnasOhLK3LDrys8fEL/fW9Ou3tIKuDrllNI3ozdyfOhkWSTYNqpGhBjzi5mo9M1WRFocVtdxJDNobihtRY4t8/OV/mgSuAMJAnlygMyIR0zGFqJmgYS6V1TWF5G3TIc26JqtN74SvZBydwqZ1088Us5cxMshD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvM+Ask5PQvdqCDJkU4E9yh5d9aAE8O4X4jSV5DRNaE=;
 b=4fB2Nym2siMGEnYm9tyeuOEE8MEWUTXUZ5WalVPufDglo0GKPioKssgdPWDq112MpNtlx2NlFwPy3AvWbFtvDD+nbxJW+nS3LupzuQY8DwiEFPriaJi6vQZqNPd5vmuSuDEVHODSDkmYePC6vP8m05uVI8NqcaOviZwfCxTSGJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:03:53 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 15:03:52 +0000
Message-ID: <a9a4aeb8-a044-476d-845d-0368f90624f2@amd.com>
Date: Fri, 6 Mar 2026 09:03:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision
 to debug
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen.Ghannam@amd.com, Tony Luck <tony.luck@intel.com>,
 superm1@kernel.org, linux-edac@vger.kernel.org
References: <20260305154528.1171999-1-mario.limonciello@amd.com>
 <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::24) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7f4cae-cac4-4e01-da3c-08de7b919486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	B6gpedU0Ko4yw/IEu+UXP2Ta/WTFwk2Fh6elkLzqs4hoEo/QSsG3Ea2Np4oqzCloyRZ0UWt5Pfmh8KFmxADTxtt10fgzSErpbSKoiElGQHaadXL4YVGycteRVxD9t/qfhu6RJ/l/2O6l8/ZrHhwb4S6UsITvZ5j+PGsil3wrT4K9HkeyNgptZ5VeJtq8bO2IqRmr+SlFT6mr7SRmSMH0J7wqdpTcyDMP2PQnOLa4HD84hm06F4aj+4DPd+clTIee5DzaZVJoYKC0rCUhfGUQ80GipPFXPib/e7gihZOEp3XrDU88fCxVOc9WvEnowweN30DNoOm18kDmh1uWtuLAtBG6a5oRmHcaDpvFj/zAYRk74XDz9JPxA3zsee07XKUkYy8R2hv3O7bCoDzQsEQTLWRDOUHuv0VmZtUhYjAKo9d4SgZ83T5JESmJ5ANqo995lGUBTVTthP3rJB4aFBBkkCaozx85vxsM/OnJHWKrYzwEDPjeEsPBzF1Zcz5gyg0ACNEZThgJ5oC683sm1IIqp8ZmLcQml4n+NNrt3oOpORXqEEPpf34GTUzqncays0cIb11yar4QhSsO6pndvOBdg3VfQM5EdLXTnkjBdVh/PMVDelA83wMA+i+FBUmArX67JbkYImyPu/1iSVdc3GiQLnF9wJDwd6CbiGgpPtetiLFgBiDt17SpUPTK5egDGnjSJlsCRyAXRRciBIUmuHA/QBE1hDn2VCzdF9JTrs3Y75Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eisxNG15Z0RRTnQ3TFFCOUZ0aG1aRDNjOXpuQkZPRlY2MDhPb1hRSHdGNFhw?=
 =?utf-8?B?TjkvMzg3OGdkaFRtY1VYamZ3Y0R5VWt3N045UzBaclFzNHNTcFkydE9mVUZO?=
 =?utf-8?B?dDBGSWIzbWZRNVJhaXZYOVFKaGo0cHg0VUJRdXlDa3FTekUyU2hYZ0Q1amcz?=
 =?utf-8?B?L292TTFhRDk0anFnTnY2K09NemJ4MlFrWGxqNHd6dFhWelg2L0cyeVlObnVZ?=
 =?utf-8?B?cStPeGIxOVRnRUtEbjRZSTlkTDRENTRxeFlsZ1dEN3QzMHlEOTZ2TFdYWFNG?=
 =?utf-8?B?VjIyMkZIL0dXQjBsTlNyMDVzMXJJUW8yVlFtMTNEaFBmSEV5VE1VWnhBWUYv?=
 =?utf-8?B?QXZSa2RIaWZUWHhNcE93M0hQUjBHcEppRnd3b0pqb2V2VzFYNTFhQjIvWmxz?=
 =?utf-8?B?dUZjdVNFN1Z3QU44VDBvSXFZNDIvU0g3MHBsUVV0WFl1eTN1L1JXRG5nV3pr?=
 =?utf-8?B?djhwM3g3NXRrbFEyTTRjY1FYaWx0NWFWSXp6U1k0b255R3FHVy8vZEJPbEpl?=
 =?utf-8?B?Y2VINU12bWxqOFg5cFJxS3lGcmdjdEprTEprcnZzUWg3WEQyZjdOSXU4cG4z?=
 =?utf-8?B?MDlaWGlpU09yaEdWY3VXYURzN2JMWTNmVnZ1UWNhVE1LYks3c0RtRTdWZlVY?=
 =?utf-8?B?Y1IzZW5FeEkzd1hqYTZyVk5kWjR2b0Zqc3lnbkJpNW5jenhkZURlbTNqNnY2?=
 =?utf-8?B?Z2dyV1A3ZVU1UDVuSTFVcFF2a2xDTVRldXFTSmg0MVlwaHFTTnFaYS9wUlo0?=
 =?utf-8?B?dWJKYmp4MDNhZkcraDR4anZxQ09qMVNWQTk0em0xenIrWW5Ic2FaV2t1Q2I0?=
 =?utf-8?B?eDUxSzV2K3JvWGpBa29nM3oybHRWYkpwNUxTclNUdVZkTFY1R0QyTWZRZEhq?=
 =?utf-8?B?MWFHaHRvaElEOVV6eG5wcjN1MkVhRyt1c1M2WFFvdldiRnNzQmxkUVhYcFND?=
 =?utf-8?B?MDIzVHBMZVZFMXJxWE9tTFBJQzk5U0xJTmU3dHlHWTMzSk9Fb3k3SUVHSjhl?=
 =?utf-8?B?ZnZ1YTVrRmRnUVd6Y1g0K3BFTHVuMWwybHB0MXJSa1FzNmtsYjlVVlA3eWJM?=
 =?utf-8?B?aWpaTjgzSEZ4bGFBREZZRmVMTzRIb0xHSXFGOWo3WlpidGxmL0FnSmF3Z29R?=
 =?utf-8?B?Wm1JNDhJVDdLZnd0V3dUeTMvaEt1NG5wZmxVSkExM3hVZlM4ZU9SSkJnUDMw?=
 =?utf-8?B?NTlaa1pldGhjbjVjRFhEY2dwclpucUM1WURDVnhPVGF0b0RvNm9kN0J0YUpO?=
 =?utf-8?B?UFBYZUp0Y0RRQk1OMGlBWXI4MmRuSjJMWFRKaUIzNitjbmJoUlBMVHp6SnA4?=
 =?utf-8?B?TDNnd1pscUNZQ28renJtT2hKd09WTVh6amFsMjlDUkhMWVppaGE2Y1dDNmlO?=
 =?utf-8?B?aWNzRmZnSHVUcnhqcFJ4bU1tY1pnem1FbU5wUlh1clNqaGNlQ2lmdGxpZWtF?=
 =?utf-8?B?aGtvVmxzZFd5UzZYSEVMZkR1ZSt3WjdwTSs2eFZvV0l1WVUyUGJDbis5eXlO?=
 =?utf-8?B?aXRmdzFhYzhZRUdwU0lFd3NSM2o3TTlrdHZWd3cvTVB0U3BQM25TYUQzTE5w?=
 =?utf-8?B?Y29JdGRTSHh4ZUtPRWJQSTFkbzFjWEFtNlphekpML0ZuMnVtdlo3MzlMaXpz?=
 =?utf-8?B?K0w5ejNReXQ1Q0NhSk1QMmdPWGRaeVQrK3lmdElwVnhRYVN6ejVBckNhdjJo?=
 =?utf-8?B?NUk1TUM3MWU0S0NvNmFvdHJGd1g3SEN1MkRCTGYxZ3pKVDlyWElzUEhITFhi?=
 =?utf-8?B?ZThqSm0rdTFpbHF3Rk4xRjBBOHZJU292WlNhcHNqVGQyQm5ONUJCbnNqM09p?=
 =?utf-8?B?YWF3dUVxZFBUVlVZMTNaOXFiK2lxODhGSVRLL2xFczZhRTlaSDQrZjBXMlYz?=
 =?utf-8?B?bTY2RW5aNW5pZjFRaVBNa3RWYjZPeTVTUDZaRVFoMlpIRVRnNmVISHpZcStZ?=
 =?utf-8?B?cGVwNk81RkQxLzJqNm5BbGpMU3l3dlF5bW5KNlBSelZtWFpTWEhtZVJPUVFO?=
 =?utf-8?B?UTN1VmU5NUkxck4vZ0tvaEhtbEY4QlBXV29namRhYVZ3UHJoWERVMGdnWWZH?=
 =?utf-8?B?MGNPV25hL0pFMzJTN1pPSnJTb0tQUjdhZDhCM2pza2s1YlViVmhoZkwrR20w?=
 =?utf-8?B?bFVHNFpkSlJuSVJEV3pZanVPRkFTa2t2WFlOcFBIbGFxMEtrdWc0SWg4bWRW?=
 =?utf-8?B?SkU5ZVlaTE9ueUdGMVgwYXI4Q1ZyZ3VPaDZTMUxYcU9SSW8weFBnSnk2RGRq?=
 =?utf-8?B?WExqeHkzWUhReWNxdTF1cjA5QW04eGJuUGhRZFd6Umd2ZEdkdWpqMmkvL0ly?=
 =?utf-8?B?NDczU3RLTmN4TjJaTkFQc0VlN0ZadkMvdkR5cGI2ekkxckFhL1Nndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7f4cae-cac4-4e01-da3c-08de7b919486
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:03:52.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTW/dtH9pBGxg/fsFsOVOsepL/bCxoyrE7eIUtiYwlMWWDj1BhD3nwzCEKWDwp8zvCrVClrWFNSV787mq1OXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
X-Rspamd-Queue-Id: 1FC6B2237CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5775-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action

On 3/6/26 8:50 AM, Borislav Petkov wrote:
> On Thu, Mar 05, 2026 at 09:45:27AM -0600, Mario Limonciello wrote:
>> commit 187d1b27a1e43 ("RAS/AMD/ATL: Require PRM support for future
>> systems") made PRM mandatory for future systems; but this is only a
>> datacenter centric point of view.  PRM is implemented on a case by
>> case basis on other products and thus it will be expected that the
>> DF revision can't be detected on some systems.
>>
>> Decrease the applicable messaging to debug.
>>
>> Fixes: 187d1b27a1e43 ("RAS/AMD/ATL: Require PRM support for future systems")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/ras/amd/atl/system.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
>> index 812a30e21d3ad..a9bf05be5c3fc 100644
>> --- a/drivers/ras/amd/atl/system.c
>> +++ b/drivers/ras/amd/atl/system.c
>> @@ -300,7 +300,7 @@ int get_df_system_info(void)
>>   
>>   	ret = determine_df_rev();
>>   	if (ret) {
>> -		pr_warn("Failed to determine DF Revision");
>> +		pr_debug("Failed to determine DF Revision");
>>   		df_cfg.rev = UNKNOWN;
>>   		return ret;
>>   	}
> 
> Well, this doesn't look like the right fix to me.
> 
> If the platform has PRM, then it shouldn't warn about not being able to
> determine a DF revision because it doesn't need to...
> 
> No?
> 

Well in this case the platform /doesn't/ have PRM.  The implication is 
we're not going to have DF support either if the system doesn't have PRM.

We pass the error codes up so the caller of amd_atl_init() will fail 
init and thus the UMC decoder won't work.

That's all the intended behavior for such systems.


