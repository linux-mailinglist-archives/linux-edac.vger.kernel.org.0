Return-Path: <linux-edac+bounces-2360-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE89B698E
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F701F21FB9
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD19215024;
	Wed, 30 Oct 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dyTW5bDn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307B2144A4;
	Wed, 30 Oct 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307035; cv=fail; b=ERGLRGTU3VEgRfpFvLDtUrzBogOYw8i9afNQPJJAH+YH+i8l2mOAEyswoGNSjbELWPinE3+XHr8g6T+JN0MsclJ7JyZtGgMe0Lh0hlSIEjtH3t5B9yI4x81wrVXagY8gjJWJeIugXqwKZKvNchB2pD2Hu1kg4jENWlVUQP1th08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307035; c=relaxed/simple;
	bh=du0IhCc/CUdd3lei0G+rFuUCCc7eIdOG9EzpsBLWkYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rMPunbhzs9KSvMqTdyo93ueAl2zg1S4fLTdww7JC95awvl0agzkOD+9tKd7VNUU9EIbstxCygfQdDx28PyuPmrB9TEznKvBf1x+obXZ0UljK8YbgnIxG32WorPyS7g6H332iQUFp/Aqi/cCBHSY5MPIQsq6DiW5tqNdtS8VbLHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dyTW5bDn; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxXVBsoaWEcsziUT+WiV+Pav4xV5Ky3KMlcANLp3+h6EF6RvTNPBnCzYhe5VxLENrz4cPhEiriN2n78FrRLnAzF9kF9TrUs61GPOcb4PqVV5lpXtFFrloZOpLNmC5j3N0vNfStlygU0IQzPaiHoM2k2t7gVj/h0P4HDkBD/TVrf5sufNtvvyJnhySxM87CFLQXf+c7AXUPqWPRSzZsmkCNSCixtTNbzNehmsDGqzTkfK5ZtRalS1+woHEzBtsuDr4BZ1C0nuesxR87P9nlKqemP7U0m50hwL/RNWsdOY+dmc1DPLPvzTVzSloS/ud1Im2QsENp6n9OztXTQ5L0n5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu2KGdNmpf+fNcaqmNEt1xQDZ7zf7LNN1ooxCSSzS0U=;
 b=vSYJKYKderygI3VW+POj/TP2HYUM5Wt6QM+MpbsvdW09Uot9VX1qjSYXmg/SdGBamzjJ+0NDm0uc4YpI8II1djmOKpll58czy16dUWIrTF67SnngGoa2QvvW7117haQEHAUSoSHbyd0VfPoydWP++wFCGIStPB45mZIIR7tiowWtQBOm6wik7KEVuqJfYDqL07uyfb28hA24TcpBYzumngJNi/QORsF7vQvymX6SeggOIMVsr2WyJ8cYQIyxjanrFGp8/FlI+Um4ZA87LeV7x47N6RXX1jo56+NYehP8TfVnmY7kMFgUwKRrp/Qmq6+eNKvIeghmhpwggZSm+BfCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu2KGdNmpf+fNcaqmNEt1xQDZ7zf7LNN1ooxCSSzS0U=;
 b=dyTW5bDnzmp4s9p7pPln0PUJCyPk98LM8EgRw/qp+npIcrk1OhKjy0nFmATUQ95CcCSWZNVdPIgaOrkYSGKi3SkdwoBx/KBo/9IawdgMyNC6yIyh1PrG264qzOATY7HgumqFslmwKOtZEpfzeN3IL6A1biOdPrF0lQ7GCMQhmkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Wed, 30 Oct
 2024 16:50:30 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 16:50:30 +0000
Message-ID: <962a15c4-d7e8-4d58-bbe4-8045dd341db9@amd.com>
Date: Wed, 30 Oct 2024 11:50:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, qiuxu.zhuo@intel.com,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org,
 mchehab@kernel.org, yazen.ghannam@amd.com, john.allen@amd.com
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-2-avadhut.naik@amd.com>
 <20241030133227.GDZyI1a5rheucn86qc@fat_crate.local>
 <685c039c-06a5-4876-a918-bd1c810397a9@amd.com>
 <20241030164811.GEZyJjS9KJDgMYRdib@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241030164811.GEZyJjS9KJDgMYRdib@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0052.namprd05.prod.outlook.com
 (2603:10b6:803:41::29) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaa955d-3fd0-4e2e-20d2-08dcf902f6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm5KbFk4RzBra1h1KzVVelJwSEFWMnJsQ2hHUkRXQ25FYlQxUEJneGxKRjhG?=
 =?utf-8?B?eEg0V3NLSTN6ajFZVDJoNnJ1UFM2bnUrUmEyckdSdkpNYXBTUTY2RDJxMCts?=
 =?utf-8?B?Z2xrZDRFSmRLTFkzQnlDNkFFTHgvdXFZMXZzbEpDL0QxQmhFR3o4MFpRRzZU?=
 =?utf-8?B?S1NwTGw1M0pPRTc1Ty9sZkpnUnBOV2cvSjZweXUyK3dYVEp4U2R5QjlCTWFn?=
 =?utf-8?B?TXVRRU1yTnp1a3ZRVVpvTTB6cTYrSDk2K041bWl0R0dqZ1dFSGloeWVQYnBy?=
 =?utf-8?B?cHl0Ry9GRklWNUE1SUZybVQrMlA5Rnh0dktQYzR1S04yOGo3a243M2lkZUI3?=
 =?utf-8?B?dTY1M0JXRlBBazBVY28yaTkrUURhaG5ZeGpWdjB5Ukc2NTVPL3luT2d0YVAw?=
 =?utf-8?B?aWR6Sm1STndIVkh4VFV3Y05xa1V1a3lrN0Z4TWN3UUxaTUcrcmkrZTB5Z1Ar?=
 =?utf-8?B?ODd5a0psUExsRThuaUJZNktlVmVTZjQ5Q2JkVXp3R29MZkhHbm1Td2RyRkh6?=
 =?utf-8?B?NUFHQXd6ZFNRYm1ZRkwwMWxyTEgrNWZlcm4zdllPZmdGN3lGSWhGZzRhY0Rp?=
 =?utf-8?B?b3llYzF0U3Z1Vmxsd1Njc21hdTUwWnA2QmlWMXY1UG5FVnVGc3ZDaXMxWXly?=
 =?utf-8?B?SWJQSkVCYVRlU2tyQVhJcFZ1Y0d5RUp6UXJBR3oxaW5PRll5QVhJZ1RidFJN?=
 =?utf-8?B?NHZEY2JPaExHejR4ZEI4Qk5ZRHgyWnhXelJMTGhibktOMmlQdTJ6WnFSeWhz?=
 =?utf-8?B?NTgweGlmZUNOOUxVSndweVg3eUl2WU1sRTN1SFl3SUg1eWFuVG1RZkNqUGg0?=
 =?utf-8?B?Z3RjUnFrdlJ6Um5QYWVaK1BlZWk5Yld1Njd1U3Q5L3VGTlhjNzNRN1k0NUFV?=
 =?utf-8?B?aUZudXVFLy9KVWY3TW54RzZNMlprUHhaQmxBbkdUa0wzUXVra0tESURmT1JZ?=
 =?utf-8?B?NFprYnlQSlhXbjY4S0JsM1FEQWZHeUY5Si9UNmwyRHI4VzZORjBMNHdaYmJK?=
 =?utf-8?B?amgyc1dCbHJvazkvUkUwZTJuS1A5ZUFsOGI0dnQ3cjBxOVVZNGhFSEUvejFj?=
 =?utf-8?B?emlhRTNPOWpMaUZIQ1JJOFc5aW1vbVlNZ0JMNGljeDhaYkI1bk9SNGNERGVV?=
 =?utf-8?B?UHZVQWdpbDlmOHhQNzloQlhVNWtHWlFCR1pyR2NMUEdXK2c2Qi8wb1hxYkU5?=
 =?utf-8?B?bWJWNVRoU2tWZVRpc2NEMU9tQmc1ZlZOMWt3VFRmLzlwaW1Wd1dkNFNpLzh0?=
 =?utf-8?B?cG0wRHA2MCtQSUpYN3oyNGNNV2xxM0pwd2NSUjlXWTVLVXJxSnRvMzdNUE15?=
 =?utf-8?B?aWVlZ0JmTXdBN0pvM2dJSzgxdGg1WGhwcnRpRFcrWFhXdmx1TGZVejVrbERQ?=
 =?utf-8?B?ZGpmUHlaaGRLa2VxdnAyd3h6TDI5enRVMmFEd3NKaTNRNTFHMk9IU0tnZFVz?=
 =?utf-8?B?aEZacDMzRnlkT01LZnRlQktvTmVCOGhuMGdWWFdGbzIxRDM3NytOYWZDbnVs?=
 =?utf-8?B?cXNyWUdjMU1DdnBsQnhhVUhLY3NENkkyNFlCbFVNQ01la1k0M3RnTENySTE3?=
 =?utf-8?B?OXM0ZDJ1Z1FWQ0tZMzZhbEVJTVVSeXBiWTMybEgyYjVjSjVIYVQxSXdxejNQ?=
 =?utf-8?B?NVdkaWtTZWwzTHlENUluUXdGOXVFWWE1SDE1OGdna05ic2ZQaWgzWkJzOE9i?=
 =?utf-8?B?WWp6UmtGVFJUMTgwdmdMZnpRTUxJVFdkdG5JZVc0Snphc3VWVldXQ2l6OTBm?=
 =?utf-8?Q?cFfsw973BKg+5ojycY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGlRZWJ2cUdTZjF2TGdsMXBhZTMzNUkxaTRyZDdrLzZVVU9PZ2hEdnpmME43?=
 =?utf-8?B?YjVNSkN1SW5sVzBTTUVtZFl5Yk45Z0kxd3lraFNmRi9PdEZweFVBd1YzbmlU?=
 =?utf-8?B?RUhkMHltb0VsMXliSHUvdklUeit3L1E2SmVJWTBpQ0xiK1dEWC8wS0NOei92?=
 =?utf-8?B?amwwWnFhRGczYTBoR1A1T1FDUUhudlVQRzFLbWhrQmpxV21ySUVIcGpNcUlv?=
 =?utf-8?B?OHJKSlp5VnZFdXgxdy9EVW9rVGdDVVpVSE9jdXNsSUJXL1hqblNyUCtLa2th?=
 =?utf-8?B?ZXpUUDYwdFZPSERVT2I3THlQUktMUTIxMEJHWU5RbGVZamdkWE1sYlVTN1h0?=
 =?utf-8?B?ZG9KaGkvalQyc1M2N04ySENsSmhaSXZaa2ErZWFnR1RqSU9mc3pVcG5KK1R6?=
 =?utf-8?B?bk8vREh6bWtFdzRwSitWNlVINGlBRmkzc2J6YTRlVXVXSWZUaS92RGdMRWJv?=
 =?utf-8?B?UlR6YmUveGQ2emJpT0E1aHI0YWxUZkJNdDhoK0QxNDBoUzdDTG02eDNTTlFG?=
 =?utf-8?B?QUY0YUp5Q290US9HR1FvNkNVQXRtM2s0Tm5QaFpvQ2pnNkJOT0lVc1l1bDdQ?=
 =?utf-8?B?MXMrWkEzWE9nd2hQQjRVc1loU3FlOHJNcWkrWWRkb1hRL1BSOGloUXhCZ1RW?=
 =?utf-8?B?VzVJcER1L1pXc0U5RDV1T2p6UlcvZHNpL0plQ1hVVFVGUUMvbUIzT1ByTkx1?=
 =?utf-8?B?OU8wK2xWSXl0aFh6M2NyMWtKcGJ5YUNtdExmZjFmMVVOclFwM1ZSdGlaR0lm?=
 =?utf-8?B?Z05nWW1sMTVvY0FWK3o4eE5xTUlMSnB1MEpQQ2xvRld1a3k1eGgwYUpLcThq?=
 =?utf-8?B?UzgrTkN2aGNoRHgyVDBSZUg1SDllT1FPL1Iva2ZhdmlNakxCSTloSEVQUnls?=
 =?utf-8?B?ZkpQYTJpd0xVbDhLRHA0SEIyUmdhNmI4RUFNby9pakFSY2VIeVUwVkhmQzU1?=
 =?utf-8?B?QzU4WVNTMTdKSE1nOEN0d0xNZHRGcjYrb3I0T0VCcUROMWthdnN1czVlQkY2?=
 =?utf-8?B?c1djZHlUSE5oTUlOWkpVUHFiM2RhTitKSWY4UXQzMEM4Sk9QVkYyVDF1Y2Nu?=
 =?utf-8?B?ZXBiK081MmFzR1lqMk9MZ2hidGg4cU5sZHlHMmtGMjNVTXozUFF3MS9rdUdJ?=
 =?utf-8?B?c3BmUTBKbEFibmNtc0RGOUY4eXZlOENyNUFVbFYwOVQzcUhNY21aV2w1Tmo0?=
 =?utf-8?B?SDVadVdYdTlHclA4dUtLdnpNRkxyRkVBODlpOHRsTGNTRDB6WXhQM25qT3Y3?=
 =?utf-8?B?SGJrVVVQRVl5a1ZERi80RFM1Nk80RlFZN25WdWxZQmpIQnI5QXpDOUI4elhn?=
 =?utf-8?B?UnZsK3p5YUNMVkhPNFB5Q3lRWGNiZmZEN1ZsTkVHazlZTjIvcjBpTlpwNlM5?=
 =?utf-8?B?S2tKNHVJSStQTFJNS1VDWVN5eEozUTBYZlNQcHAxZ0ZKY0w0UmNMaEtsNTU4?=
 =?utf-8?B?aXVSQ1lSbmpVT0dZUk5MSUYzd3VldlFsclBycFZvdTlHOGdXY013VlNTaGt2?=
 =?utf-8?B?bjllcC82UE1DUld5MEdmNHZJdnNiM3pScmVaZG0xK2Q1bDA5bTlhQlN0RDEz?=
 =?utf-8?B?OHhXelg5WkdLOE10bWl4Zmw5Y25JeFRVaG9DUlppV1J6SFMzcGdSODduNFdj?=
 =?utf-8?B?cVBPaHRIWk9rcGI3YTV2VVUwZHNhV2hKTVg2eFJva081a3h5eHdTVmo2WGhy?=
 =?utf-8?B?RHl5ZGVtZ2tRdERYYVEvd1ZFdGhSOSsyZGJHUE9UTktmaDJKMXMvbGQzV0RG?=
 =?utf-8?B?MWVvRGRXTCtYdU1jVlZkZytPZTlHQmRQOFB0bWpjVlRENHUvNzJZbCt0QmFx?=
 =?utf-8?B?bmlaOFh5a24zek1jUlNKWDdwRlpnQ2doWmNnU1BQOUR2Y25CV1p6T0Q4ZlU4?=
 =?utf-8?B?MEg3SU1NUWxPaTBENjRDaUM2UWNLRmt2UWxoM1JEM2prUjVhMFJRUzgvbWFi?=
 =?utf-8?B?S3lXcUI2VkdNcHNNd1AvU2ZwNGNzRkNjMTFvQmU4Nzk0OEFPRlJlVWRtMjRq?=
 =?utf-8?B?NFR0ZmoxYlJxRndlcmpGZm1kQVQzOVVjakFDbE95Q2J2Y1ptWnprR211OVRa?=
 =?utf-8?B?THlZNE02aG9YWDFxNnJYRW11S0Q4dG9kRWpIU2VJalUvVVUwbm8xdFdta0FS?=
 =?utf-8?Q?zOM2MScIMkt7oodIGtfm0DC38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa955d-3fd0-4e2e-20d2-08dcf902f6a1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:50:30.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtq6GnOGmKqpS5nWkEIr8Newehusetl32G00I/EN6EjR9tDIKCQd3iiBk7Fbq3bVAh0qeGSG4Lt1vuVUL0Kgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995



On 10/30/2024 11:48, Borislav Petkov wrote:
> On Wed, Oct 30, 2024 at 11:35:17AM -0500, Naik, Avadhut wrote:
>> Will fix this.
> 
> You don't have to - I'll fix up while applying.
> 
> This was just for your future info.
> 
Okay! Thank you!
> Thx.
> 

-- 
Thanks,
Avadhut Naik

