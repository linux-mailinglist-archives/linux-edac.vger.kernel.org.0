Return-Path: <linux-edac+bounces-5762-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKfMLe+3pWkiFQAAu9opvQ
	(envelope-from <linux-edac+bounces-5762-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 02 Mar 2026 17:16:47 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7BD1DC8C0
	for <lists+linux-edac@lfdr.de>; Mon, 02 Mar 2026 17:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5FDA3011CB6
	for <lists+linux-edac@lfdr.de>; Mon,  2 Mar 2026 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1B2D8393;
	Mon,  2 Mar 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="boesxUvL"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5F2D837C;
	Mon,  2 Mar 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468205; cv=fail; b=FIMe8SJAtLAcnHpNAroUWumqdv+KTIRYeQo8MVAu0QnOyisiIL+JTPchBpRdz4w4pgP7FCzbop4wtF7WSJxEA8J/bo2PfAcawblObcKyzlONinusDVEugpmlK0JGlIWs/9ICfVRpdjLbepeQAXI3rx0slUFQ82tXCOu+FBLFY+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468205; c=relaxed/simple;
	bh=hpEmc7mCtRGx0ANW+p0dXIn0Nr6y6zNy4ifChnMIc7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fkpd/37ZCk3AE5qzsPk+JR88hst9JFFiSc+pVtUI3C4ZrRz9M3C3R7v27EshQUJiIDoin5IZF8hH3N8F7DUx4KBQP+Tp24ijKwJYKvfYoAGzzQrZu0RrLfP8UO+zZCJxcHw3sVWyH+gjcCIwHIZ8wQ8urACD1kPwD0DeF/cThkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=boesxUvL; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhHTFGbfr1Og1dEh8yimhVbFIPgnnauydU9M0IqAhbtVEniFcxTUb/clmkcyY6BFbN6Jqg7nbhVh674AyIGAby96/gw43z7uA9I6TzWGabCPgBEIQ2E4JMyMZH1NiaLrY4OPOveYEUQDyuj9e4Dx6c6IEC2Acc4uHhsvfd2H88t2HPOLwZf0ojMxgXVM/mDjyO9KfzOfyElvoGKfFxLLcw5bXdTYS6AMmxpvmh+fXWKc82rNytjA+IuetdzvqZrRR3e6v5n1451XlshT1+Ys3Vnr+XrLMmG/ZU8qurrmnYxJrHQiME2rCeI6Hm+DCVnmIUEYMpKgB0lSvzMI1crHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyRTvC8P10I5Gw/SiFa7Xy9+OWwKpSeZvgmYfzxtM60=;
 b=vbLu3QK3I4jjQI0k/cQz46SoXgKT9dD3eImZ8LctUxMBr+qmHhWeYc+++GrUhBTNX4+Pcmg9QNt1Odu4A6E98q432s85mHiR5wexSnqqxLWNY96K8DhT1lPBZL4nFlYFlHt+AFYgcai7FG/klDv+WlS9166Wr+AMoN73lbmYj4Y5+D4rXHX/iPibzQyasysD5OsEtxkV0ONcNRyL0dNz2e5jAlf//jOl6HmoP0gxotxubRmXFtJHon49wYTV9ojPsO0ZhFgilQNBHh/U93CQRazCS+PjgykMoXAe5EDJdPgWd0W811vkEMHgWaXpOvkDyTtZVU0U3Gn15JHl8XZkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyRTvC8P10I5Gw/SiFa7Xy9+OWwKpSeZvgmYfzxtM60=;
 b=boesxUvLbRgp35V9lj7E22/KmGnENsnuqC4WJAmUsZwm5+aos0v8akmKIVKNiyPiKeEf4KDMchFAj/Z9/hdVl8c3t2ZjONdjCrWOCHntECJd31lyjbzHwM9KP8FkDm8Wbyg5JFnxV7gTT1RidHVhWJNqo7zXkNcJCCcHd8lyd0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 16:16:34 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:16:34 +0000
Message-ID: <ab7c5c4c-1477-454c-a47d-8adf32d6d738@amd.com>
Date: Mon, 2 Mar 2026 10:16:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce/amd: Filter bogus L3 deferred errors on CZN A0
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Bert Karwatzki <spasswolf@web.de>
References: <20260228140814.76375-1-yazen.ghannam@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260228140814.76375-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b87505-91f6-4388-05ad-08de787712dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	Xtn8cZ4eWVe4hjbja0qZl8eBTAsaQl5LQjlG33NoWS15gAcvPTlgKNEqeO4kHu39x+woYi5cEinLoD1IIL2RvKv1fCaovOhoFz5otpnhRM0Q0cg+ccxrntYZIKb/FIaNyfdjyqjXKQjQSZ3DyvGuIoy8O3qp0Jb1ugTpIlSRjak91KwjSQ5PYkH/7zIj8PaMJo2wlTF3dztjki2HJLDUy+ynRqphhNATi5X6o1tsPgErnRApNb6M7/UWqpuhn+JBhT6Ihi4mBlySX4wZq3CAauJ2wmrLvJf2yRV07Kx1Y7IhW5da3yZcYJCEN6YnP+P4K2vmeQ/J4dWTMkluzMNP3Dfe10Xohp7Vv6yTMFur+nga1s5D6WwJIFnz9Ztnc39pXRJN8bXsuJ8CWy1YPy46z9mYokJ1i5K5FzUny3lOplMqAbMQbeuz1JRSbBQj33piAue62t8wlIcR6E6M1IzzFuj4ve4HU1B+or1OcmbiNGGbsuVRSQcuiTmMWyTnp7qn5/tm4/XqQ5l8SSuVQPhD/yW4aMyN12ASWl1hYNktKUqXawCs9VECr3XozJ04khwEosM32QIeQfm6+p+6Aha6baQv3tciBR0mdIEj7M6rYOH+vMeddMWlt7DE+dShSQ8x837rOUa08ATZvmY4sF8iqd1R/zk5Yv6kJjRjmHusiEqdp7od5NSQgVcGTihChRtp0gGUZm7EN88w+em8uDvSeH/Ol+zorcvtKY0cUkp9yqevLx6PwJETNExxSYqiUOMK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTZOakdzYXA1aXBsNVJPQXhVNStYTTNYb0pQanc1TWVxbktIb2NFTWs3TjRC?=
 =?utf-8?B?OFNvS3ZQR3JBMy95U3lPWWhYckpaNUh3RW03YXROUU1jV0NVejk2YWYrZ25Q?=
 =?utf-8?B?OXpqU2RHWFlrc3JsNk9GcTd0SHFaUHRjTENYeC9NSVVuNVdLVWtHdE1uS3FC?=
 =?utf-8?B?Zk1rV2tENitwaW1qYjZYRUpQWXdpWlk3c3d5dXZwTEFVTlpjNURNQjVXVVJ2?=
 =?utf-8?B?bDB3VFJCQmZKZ2tpV1lzaHRUZTZoTDlkbW9iMmFBTlJZTzJ1NU9OcGFzamNS?=
 =?utf-8?B?ZE5GbDVYZFNaS3l3azNZTmVQUXhmeU9yZll3U2tsT01zSWRtV2lnUkRkNVkw?=
 =?utf-8?B?M09tTW4vUlIxL1ZtYWdPbUswMWlNTlBveHZYVWJvajAwUTJ6aW16cTlWWXdW?=
 =?utf-8?B?aitnckNvUmtKaHRjZTRNalZXa0s4WFp1Z0R2SFZFa2tYYjZXR0NlS21nTnZJ?=
 =?utf-8?B?SUV0Smdtc0ZBa0xoZVkyTkt6ZEQ5QWg1cmZMSGJ1aFJmbXlaaEY3ckJERDFo?=
 =?utf-8?B?YlNLL3d6cGZjdTFKYlcxd1JjbU1PclJsSVdkZ2xjZ3FEQXhFakNLMTBUeWhs?=
 =?utf-8?B?VitPQnV4UGNncVpUaVIrWEVEYW8vOU9XRzUyaExtdG9zQkhnYlZLUjduQmtr?=
 =?utf-8?B?a2FjUDI1aEJoVEUwakpvMUxoUUZPMTRzaHZzRnd1UnRWNjZxZkZWOUFjZy9s?=
 =?utf-8?B?UXgxbmIzbE83c3JYWEhETGZHb245NkdseHIvK2ZkZWJ3RHdlbmJuTmFMWXMv?=
 =?utf-8?B?NXp4ZVFnSHJLK1hIbGQvdDlsTVNVRWhGdW1LRGpqajhBWE1PNTF0Q1p1VWRj?=
 =?utf-8?B?OXcrOWJYZHc5UnhsdmlUdFZDbHVRL3NOZURDbEpPSVB3VGo5QmNBZ1BySjVQ?=
 =?utf-8?B?L2ZUK0tqSmp2WUV0NXlpZ2ZFTFM4Yk1Bc1d5VGxqU0NDcFExeGF0cy9DSjVu?=
 =?utf-8?B?Zm9ZbEUzalp3QlNnUVFvNVByRzE0NjQ4TmZMaTlDUFl2TzNqeHA4TnN4VS9D?=
 =?utf-8?B?OTBrL25KczVSazVLK0pCTkRwMER1NzNiOGhCdG44b0o1MFY5NzcxOGdiNWJv?=
 =?utf-8?B?WDNkZE1iRTVHSmdpZ2dJcHc4M0VLMW5MVlJUTGVXcC9LRjhXQUZsa2lrQTVs?=
 =?utf-8?B?VXQwYTBNQ1d1SDcrVTV0cTdjNzQxdFVreU9jQlRhM2l3ZVN0dFFFdmxzNE5Q?=
 =?utf-8?B?N2wwSDdFTTU3QXhhbFZ2TjBzNFk2NFhrVFdRNERQWmhyelZKMC8ya2R2NHpP?=
 =?utf-8?B?eWxyOXNVd1ZuZk1RNm1WamNaNlZKU1hxeUs3WldDWDl2OXE0dzBkUDVvZjBB?=
 =?utf-8?B?ajkrUmgxTGFhY2JZU2NEN1VCZzl1b3VZR2J2ZkJhcXhxWEJ6TzVhZ0gwd1lS?=
 =?utf-8?B?eVpkN3h6Wm5pOGRpYXY2cENFTHRka1Y1OXJTV2lFb0hjL3pIRFE4SWY4TVZq?=
 =?utf-8?B?SUd5ejFheU1ZaXF1R2RNc3V2UVV3NGtFRGlWTGJrWnFjS1JmVnd1NHRJSlk1?=
 =?utf-8?B?NDQ5NkR1QlBaN1NtKzM1UVQxNnJteE53MGR2cUdtVU9DczBQWnduWFBkcC9T?=
 =?utf-8?B?UDJ6Q0RXRHdFWDVsZ21qMFRLVm9VcWUydjZsdURMTzg4eGVkeDRORlpEVEow?=
 =?utf-8?B?Qkh6NlZncSt2T3BjTlNxZzZwRWpoME9UUk5KWkJEbDNzSGpuOXdKMTNzMjNW?=
 =?utf-8?B?Um9Dd0poaW8yL3JLMGZ5OEdFb2pMbzdqa0tUZzdyNElra0JGajBXNXdmUVNS?=
 =?utf-8?B?MWJVd091T3RTSUVVeEx6bmoxZytvdFZkUTBOd1FoM1A3Sm94WEl4OTJLUEw5?=
 =?utf-8?B?UzBHaW1hNHV4akNOaEx0NUlwcEJXNkYxSG1PNjBsT2JQTmRFYXY4Zkk1ZVFM?=
 =?utf-8?B?RHpSN3JxS2lyS2Z5OEtUVDhvdmViZWFLV0toN3ZpdkVHeTQ4anZHTGkvTWd5?=
 =?utf-8?B?eE0xOGdaanppTmYwbThqM05yQ0ZvWjNOaTNDNDM3K1Y4K0J2TmlnZmVVVnJL?=
 =?utf-8?B?dTdFSXd6QWdoRE9NamQwYVhtOE5hOUJpMW15bndUa1IrSkg5d1JpQUhlWTZB?=
 =?utf-8?B?TldGSllETGJSOEZVT2FBL3lkRW1FT3psYmM4V2FiYmN2L2IzajhRcS9OUFEw?=
 =?utf-8?B?SEovTTYrcUJ2QVdValZvZjB3ZkR0bzhtUEpqOWg3VU5nNUpSZ08yOGJxVkpn?=
 =?utf-8?B?MXAvN21RQjYzNEt0Y0VVSk51Q0VTSThhS3UxbUVLWHVBOUhQL1p5ZDlKWVZN?=
 =?utf-8?B?ODN6Y3dFRjhBWEZCUG9nQWdsd1BPK3YvQXJiVzZLYjNNblFKNjlaa29rWGpD?=
 =?utf-8?Q?RCITKmF8kzpWJ+Lw9J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b87505-91f6-4388-05ad-08de787712dc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:16:34.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkW4779zdO14Wy8ICoOwvU4uwsnnB3rrG/C8C4Cira0f/neoIjg976JO0QjaPIUZMlKLU2LCpEPwKGd60TPoOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
X-Rspamd-Queue-Id: 5B7BD1DC8C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-5762-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,web.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/28/26 8:08 AM, Yazen Ghannam wrote:
> User has observed multiple L3 cache deferred errors logs after recent
> kernel rework of deferred error handling. [1]
> 
> Upon inspection, the errors are determined to be bogus due to
> inconsistent status values. Also, user verified that bogus MCA_DESTAT
> values are present on the system even with an older kernel. [2] The
> errors seem to be garbage values present in the MCA_DESTAT of some L3
> cache banks. These were implicitly ignored before the recent kernel
> rework because these do not generate a deferred error interrupt.
> 
> A later revision of the rework patch was merged for v6.19. This
> naturally filtered out most of the bogus error logs. However, a few
> signatures still remain. [3]
> 
> Add the remaining bogus signatures to the MCE filter function. Minimize
> the scope of the filter to the reported CPU family/model/stepping so
> that similar issues are not implicitly masked on other systems.
> 
> Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de                # [1]
> Link: https://lore.kernel.org/6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de # [2]
> Link: https://lore.kernel.org/21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de # [3]
> ---
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   arch/x86/kernel/cpu/mce/amd.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index da13c1e37f87..7a94492aa50f 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -604,6 +604,18 @@ bool amd_filter_mce(struct mce *m)
>   	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
>   	struct cpuinfo_x86 *c = &boot_cpu_data;
>   
> +	/*
> +	 * Bogus L3 cache deferred errors on Cezanne A0.
> +	 *
> +	 * Case #1: PCC bit set. This is not valid for deferred errors.
> +	 * Case #2: XEC 29. This is not a valid error code.
> +	 */
> +	if (c->x86 == 0x19 && c->x86_model == 0x50 && c->x86_stepping == 0x0 &&
> +	    bank_type == SMCA_L3_CACHE && (m->status & MCI_STATUS_DEFERRED)) {
> +		if ((m->status & MCI_STATUS_PCC) || XEC(m->status, 0x3f) == 29)
> +			return true;
> +	}
> +
>   	/* See Family 17h Models 10h-2Fh Erratum #1114. */
>   	if (c->x86 == 0x17 &&
>   	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&


