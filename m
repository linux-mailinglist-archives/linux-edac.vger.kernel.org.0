Return-Path: <linux-edac+bounces-2346-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229629B6543
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 15:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463191C2091B
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724B1EBFFD;
	Wed, 30 Oct 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vgaX79LA"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DB1E8852;
	Wed, 30 Oct 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297298; cv=fail; b=GAavtmoF4Zx3yHVIhtJ3YDpcf57PIZzUWD9k8o9xFQj3oqvOxYIRgpy7d/3CHaWvRBPXNVtsSBKcuhBtetYXnxTycmPpUAiwcV7kwXTb+uuZqX3JG1glO2YI0vmy1SYD9IisiOb+OMxmo/jINv2p3ay4YZpRIhK0g+zRe855VYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297298; c=relaxed/simple;
	bh=fKDT8m0Tpwde3XwQ9ai0smhInczbHkFSRalDiuKqWJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZfB5sUbNSSt2LJ5W8N/Gsdm3ak5DEfyYcA1xUXSa7b8lRzMjN/cgZZOJoiXdhgvWSsxPjI+pwV5IFh7M50pVdRia8jamXfXpEZqSiO+dIAvXWFa1CA60NAKDFr3wfe1Z+TUWHxnPe2x8a28iWZr/gKGd4RnEqU4/t4O/VVAMXwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vgaX79LA; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toZ2zyhbm+HTURdR799zx0vicCt3iXQg0iaWtQzZBBIdkxsxqkW56fthavy4UDfvW8V+OqZXwOQ1RyFiZ2veGy48Llrohyn12SIg7UqeJVlRsCF3aeWKtjYgvwRGqIjq+N6UxHypO0kgTIYGrD3T8ss+oEKTwsoVh+eLi3FUixX+BksYglyrjMjynmhzXHvxymGKRtghKmt5SfEA75sUroPNP1qOUtXsKJKOzDAZ3pclrGqUDaF/SkWOLzS+GHmKAqhwjIyRG+qIcFl1/k0+OlwaLlWo7wqrc6kErMDSRBOJhwTHBQq8rkO5s/NsRENCCCCoK7DRdTwb3bRxjDjejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1VGAIjtyOZj3l+Nm8c9yBiAlT/A1tIaKvR70BfaEoc=;
 b=A8rGwcKh3kp+tXMslUiS8kSrmWPmB7u0JYPQEjEYLbNyttlOAebgyC0OSTLVCYKM5lLmrFrPeKnAoeDkbWkTqzMGu9ABD6j0pIjOZPbCpdBMJH60y0NDGTziK46816F+pIU1u2jgO6E9Tags9yBQjxqUZWHbzJ3d9CxiOXSmK3/+rjliJAEGsvpgTw2OVO0PzQdmVJHBLOGqFlxTJk98krG0vCQRAT8F4X6fj9+tWeu3blxRbjdaaZhwoCSjU/WbpMrwxHDLVyEgJJV6FTM5sM/kU/PpDYXfFrnP967jDCUAmvmhqbXsJ9sooYKt0ys6mqxUPHd+Tes+1R+KEA2mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1VGAIjtyOZj3l+Nm8c9yBiAlT/A1tIaKvR70BfaEoc=;
 b=vgaX79LA96KzWX7zeND6mA2vFte/dd/Q88rKEo3lYQhRgYWbigIs0uaNOKQbkD4dWdK3czngXx6Pfdl11Yg12jbnKRq74wuDIbDBbLUgWhez9MpyIU9J8i2wbg9MyvxiN/LHH/rOFQvDGCDA03WRFuRCDI0ClH4vXA9snVpD+9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 14:08:11 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 14:08:11 +0000
Date: Wed, 30 Oct 2024 10:08:00 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
	robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
	rafael@kernel.org, wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
	tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
	jarkko@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v15 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20241030140800.GA1288714@yaz-khff2.amd.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241028081142.66028-2-xueshuai@linux.alibaba.com>
 <20241029204848.GA1229628@yaz-khff2.amd.com>
 <d62d775e-08e3-4a2d-88a8-437a4c04ebd3@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d62d775e-08e3-4a2d-88a8-437a4c04ebd3@linux.alibaba.com>
X-ClientProxiedBy: MN2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:208:239::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0abb20-2aea-46de-1f2a-08dcf8ec49b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0hyeVpreFpxZkV4YnI4ZVdIdlBoVjE5dWNVUUd4UFhUYmlYcGNtMWtjOXBu?=
 =?utf-8?B?QlZLTU5zWnlscmYwNlA0a3RzbG9PcEpxcGtzYldITVhUSklQTHpvdGcvNXRD?=
 =?utf-8?B?Rm5WOFJKZm1vWDJLQS92S0ZIeUMwN1Y4ZXNMVXhWZW9xMnhFakRpTDY4VWsz?=
 =?utf-8?B?UFEwR2s1SmhuL3hWSWc0VzdFMlR0WXNYUUZ4ZnRLY0ZoS0pqcFJ1eENGZGM4?=
 =?utf-8?B?eVBDaVp2cXN6OWJCVnptRUpkdVRUNFZzNHZ5TnR0MmhQaTZRUkprVmpSVG16?=
 =?utf-8?B?UDNlWUM1UW1ZYjRNS1N4aW9NZjdiMmxKWERrVVJiSWY1MXczUENMZGUzWURX?=
 =?utf-8?B?cnlCbzg4eEM5TGNGUDlkU2V5ekNjRHFtdHdXMlYrd2lqdE9tTWJZNTlxUmJ4?=
 =?utf-8?B?K0V3NGtZYjExbGpzaTNGc2JHMmluVnRNeTJDb1dpVW9uUnIvKzZQdHBHUDlN?=
 =?utf-8?B?YjFQRnFaeUdSTm1ZZlhKMDVLMHdjYURoaTZyeDRGYml1c3hDUjVYbG11NHg0?=
 =?utf-8?B?aXVhRnlyTjI0TllxNS9CWXAwQ3U3a1daMXFOeXk2TStYNUg1d0NpNTFQQS9S?=
 =?utf-8?B?bUlLVkc0bXRkdTI3TUJZL1ZNcW1OKzdJY3JvZlQxVDMrd3Q2dHdQeGZjZUMy?=
 =?utf-8?B?VUxMdW1VWjk5K2hOdklta1pIZkk2eHE0enViSnhHRk4xNFhOMERDcHMzSm80?=
 =?utf-8?B?S0VndGlzWVdEVjNFUWZZcmZ0bUFiaW5iSS9yZVRGaFc3R3Q1emRkUUVvWk5U?=
 =?utf-8?B?TngwenhDV0M3UU1lUVM4bHhRSlFQV09CbmRLU1o0RjhFNW54cGxxejM1cG45?=
 =?utf-8?B?STJ5VWtQeUJrbHpaR0FrUXJlaXdvRnA4Zzd5TEtZK0xydll1ZkM2eVdtbXZv?=
 =?utf-8?B?R0UxOGk5UGVlaFBJQzFtOUdLdUJCSysrS1BtRkMwT01tOEJZanNwMjlQZENW?=
 =?utf-8?B?QU1YSzVRTGYzQkNwalJ4NkIxenlTYnhLUFdpcnQrMXk3ZWFhS25za2dZbkFN?=
 =?utf-8?B?ZGhuTHRyWkJ1bGdWeXhnZ1lYRmpEWWFLVytQUXpnbDBiMWQzV2lmRnhnUlJ0?=
 =?utf-8?B?Y0Y2SkZ2djE3NW1OdnJuVHRsNDB0Vmk0WjJtRkt1TlJEM1FLdjRZVXZ5cFlT?=
 =?utf-8?B?Zk9ZZ3RDeE9WV2VlWU9VRktxYTYvK2xuak9GcjM3RWtORmloRFprQnovWVVX?=
 =?utf-8?B?RllqaENtMnd0TUYrTDdqUFpIaWFaYTRWZVZZVGlKeGIxc0hMRkt1YmtmWCsw?=
 =?utf-8?B?YUgxdzFmaVY4SUFzOVVxbkdheno4Z2g4Wng1T0hSN0V5L3cxb3RtWXNzQU9G?=
 =?utf-8?B?RWJVbVRCTUhQNXpnQnRHY1dPcllWU0ZralNkQ3oxTlZ6WEd5YW1wRzI5bVNH?=
 =?utf-8?B?K1JsNkdRYmVYS1dXWXFzOU1tSlFyRFk3ejdRVVdrUlZzVjV0dnVBZUt1NGtN?=
 =?utf-8?B?N2g1NHBER3EvQUM1MGRoeC9IajVwdXFTS05CYXp5eFRNUndtbDdYVDUrdGFD?=
 =?utf-8?B?RitTcVloYkVVeDBxclZFRlV2czlVWnAzRDlvcStrcWdQb2ZvYzFzbFc0WEFU?=
 =?utf-8?B?QWRsaVhWcjNUWC9tcS9mQmZjd0lVWjl0VEwzYjZvdXhkcXY1aEVSMWtPdWow?=
 =?utf-8?B?RUNBWDRYM0FFN3I5eUYvSUdoTFFpanFLc2lpZ3UxcUJSZlBvWThoTXVjdnZG?=
 =?utf-8?B?a01mSGRuV28yV1BLUXdGaGJCOE83RkNrTVV2NzdrNTNaVlV2b3FJMFBraEo5?=
 =?utf-8?Q?ryPLrBnCm5gtuDVrj9iUxBoNp8B3D+twMKE+N6G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckxCeEhmM2FVOWZyTk9Kc1I5ek9hK0E0ZHB2V1p5cytmYkJCaDlFMUpzT3ZE?=
 =?utf-8?B?MEgzSmY4Yk4xei96OFpKSzlud1F0UTJJZG5lUEo3Vmx5a2czVWtjbitDV25U?=
 =?utf-8?B?UTNsS09ZR3pLWktweUUrQUJvRzBtWkx1YWlRazJEcXdodEtWdEZLNFlha1ZE?=
 =?utf-8?B?Y0RRSWE0U1NuSGdFb3dSYitOUU1selB2MHBtclpjNTlOem1mcjY2U3k0d1VN?=
 =?utf-8?B?WmpHUlVrTVZ4RTZhRjR0c0cxdThndzJ4elZzRmlsYlRva29SMEtLSG82b2lo?=
 =?utf-8?B?WmpNYVJoU2VqNUd2R3JteFNRdFpxWFdmQmY1d0FXUWU2a3pNektjTVFzbEhy?=
 =?utf-8?B?dmdORE1XS3laL25tT2tXL0pnekNLSFFFM0wvZUEzaXlxZ2E1cGhQN3dkcDlZ?=
 =?utf-8?B?OWVmcFpXRTRabVZOeVlEUXFwVVVIZTVtWG1zY0lhaW5DQVNsc0RhalVuN2Zj?=
 =?utf-8?B?d2YrQys5Nkx1L1VPd3hSQTlvc2pqODA5TGNZWk9FcElxZ3pKSzFnWGpKTzRH?=
 =?utf-8?B?WDFnK09zZzJIT3RFZ1ZFSjh1QmNhTDJhZ25zcjRVUjFMOFZYOTgva3JBK1ht?=
 =?utf-8?B?d0lybWdJOGsvend3UnNKcVkrdk5LZlkyT0JaVmVsbDNtODdzN3JSd1QyR1h3?=
 =?utf-8?B?WVd2UTBnN1lXcGJGQWFhR0xIS2tGMmV4aHp1ZkZqZkZESVhiYkQ1eklKaFJX?=
 =?utf-8?B?Ulc0OWVWV0ZPbVI3VWFWaGtGdExEN21LTWczQ3k4ZVd3NTFMTEtnc3ZNdzVM?=
 =?utf-8?B?eXFaRzZmdUNoWjMzeVo4MGJLRm56T3ZacVBYQm4rM0NHRGVpb2Vhb2FucWtS?=
 =?utf-8?B?bkpaWVNYMnpzbG1EQzRVb0tMYWVxODQ2ZVJtWkE2eXZtaWRxcmg1MmhlejhX?=
 =?utf-8?B?c2hyQVBnSFdSZE8ySUZ5cHNVVVZSellJcGlYcDRPZzFyZU40dWpmVm9LS1ZL?=
 =?utf-8?B?bWpPc2xjVmxlbUFweFgxWHp4RUZpQkxVUlJOc0llelFOZzNoczJUTjFnUUwv?=
 =?utf-8?B?YXpCWFFWWE55bWpTMHo2VWd2QXBySXpTNlBCTmtoWGVBbnJhKzZ0RkJMNXRE?=
 =?utf-8?B?bUczNGRaTGJERGJLVW5UQzZaOUQ4VVJKQ1lueURGZzhrL1JCandVcnJPTExE?=
 =?utf-8?B?OENxcHdCMURIMFpPN3R2dUJuWUplZk0vM3cvUUthbDcyNUEvcldYbE1hQmYz?=
 =?utf-8?B?cysycFgwZTVwUWxxSkFHdDJ0SzFuWGszRzA4THpySitXT1p5VFlJc05FZWgx?=
 =?utf-8?B?bC9XRHA5QWN0ZnpzcDlya1A1K3dMZmFzbmRtME9LYVl1NFEyUDRYZkducm5z?=
 =?utf-8?B?ZEswWGNOTnNTT25oYk5RZlE2RHk1QjBJcVc1aFlMQlN0Yk93d0ZWajJ6T3Nn?=
 =?utf-8?B?TDlzVFlzZUJzV2JETE03VURNWm5nT05sQjQzYVV4NTUzSXJrYzgxTUxrVG9U?=
 =?utf-8?B?REVtRXJWWExUdEEwelJRUzE0Mm5PWHVwUmdNWXhjUHFISUJGVjFzYnR3UzZk?=
 =?utf-8?B?MVVxUnZjWXQrTEFQQzg4UGVxU3JGWU04WGtVQkh6WWtWdDBVanpQZ3dxOXV6?=
 =?utf-8?B?WkxxcXlmM282S1lMWHF2ZlV6Nk9BeVVSYWNGN3U2UmM3S1FHb3B3ZlA4UzZy?=
 =?utf-8?B?WkV1Ynp6WkJwV04xOEJUOHhBZHNUYzFFWStHSnZOKzBnMjYvdGdZZUZzWjNp?=
 =?utf-8?B?c3VZZnlYS0YyYk9SVWJxWTlOZFhXWmVtQnN2UUQ1dnNYOVQrUTQ3TjM2S0xo?=
 =?utf-8?B?c2w3R0VHS2xWUWIxYTFHZ1JwY1ZNT0ZHRHd0MTM2cFJscnNEVitKYmJIeHBJ?=
 =?utf-8?B?UmRJQlIwbjI0RHVwUEJUY1hBYkdnT3JsK1BVVFgzek5ibHBpSVI1MTlxcUtx?=
 =?utf-8?B?RUxCWjdWbkF5Nm52NzRPdnllbzk2WnJLMG1yaXhFekU4dFhGSnBnWXJ6VDZr?=
 =?utf-8?B?ZTc3dWJtd0dTQVVvcElvT01oMzBFc3luOW1oSGhFM3I3dTBBSjhLYUdGd2ln?=
 =?utf-8?B?Y0Q4N0NqdDVJWkMwdXNZczlkUlNuQW9DWHFwWU9GaGlIcElza0Y1ZHZPR1FR?=
 =?utf-8?B?UkxBQTA3TFcyZTJkRWhJV3dlcitkeDNKTElNTHZEQndBcXJQcnFWUi8xQmFD?=
 =?utf-8?Q?5i1poYGyveHeesXm1IkwQ4E82?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0abb20-2aea-46de-1f2a-08dcf8ec49b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:08:11.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZp+NSdVs/GedZXTDi98F1PKZFSV08S2HFI0vJ3Eu6lno+K8KNB78WfiVjx6U+VccaBqEdYwY05X0+YlikEOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816

On Wed, Oct 30, 2024 at 09:54:00AM +0800, Shuai Xue wrote:
> 
> 
> 在 2024/10/30 04:48, Yazen Ghannam 写道:
> > On Mon, Oct 28, 2024 at 04:11:40PM +0800, Shuai Xue wrote:
> > > Synchronous error was detected as a result of user-space process accessing
> > > a 2-bit uncorrected error. The CPU will take a synchronous error exception
> > > such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> > > memory_failure() work which poisons the related page, unmaps the page, and
> > > then sends a SIGBUS to the process, so that a system wide panic can be
> > > avoided.
> > > 
> > > However, no memory_failure() work will be queued when abnormal synchronous
> > > errors occur. These errors can include situations such as invalid PA,
> > > unexpected severity, no memory failure config support, invalid GUID
> > > section, etc. In such case, the user-space process will trigger SEA again.
> > > This loop can potentially exceed the platform firmware threshold or even
> > > trigger a kernel hard lockup, leading to a system reboot.
> > > 
> > > Fix it by performing a force kill if no memory_failure() work is queued
> > > for synchronous errors.
> > > 
> > > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   drivers/acpi/apei/ghes.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > index ada93cfde9ba..f2ee28c44d7a 100644
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
> > >   		}
> > >   	}
> > > +	/*
> > > +	 * If no memory failure work is queued for abnormal synchronous
> > > +	 * errors, do a force kill.
> > > +	 */
> > > +	if (sync && !queued) {
> > > +		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
> > > +			current->comm, task_pid_nr(current));
> > 
> > I think it would help to include the GHES_PFX to indicate where this
> > message is coming from. The pr_fmt() macro could also be introduced
> > instead.
> 
> Yes, GHES_PFX is a effective prefix and will be consistent to other message
> in GHES driver. Will add it in next version.
> 
> What do you mean about pr_fmt()?

This can be used to set a prefix for an entire section of code. The
pr_*() macros will pick it up without needing to include a prefix for
each call.

This is described in "Documentation/core-api/printk-basics.rst".

> 
> > 
> > Also, you may want to include the HW_ERR prefix. Not all kernel messages
> > related to hardware errors have this prefix today. But maybe that should
> > be changed so there is more consistent messaging.
> > 
> 
> Do we really need a HW_ERR prefix? The other case which use HW_ERR prefix
> are for hardware registers. The messages which send SIGBUS does
> not include HW_ERR, e.g. in kill_proc(), kill_procs().
> 
>     pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory
> corruption\n",...
>     pr_err("%#lx: forcibly killing %s:%d because of failure to unmap
> corrupted page\n",...
> 
>

Correct, HW_ERR isn't used there. My interpretation is that it can be
used whenever an event is due to a hardware error (real or simulated).
This is a very clear message to a user.

It may be redundant in some cases (like here where the message already
says "hardware memory corruption"). But I think it would be go to use it
anyway for consistency.

I think other relevant places in the kernel should also be updated. But
that is beyond this patch, and I don't expect it to be done here and
now.

Thanks,
Yazen

