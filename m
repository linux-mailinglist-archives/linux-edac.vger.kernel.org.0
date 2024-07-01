Return-Path: <linux-edac+bounces-1442-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16091E53C
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C81C21745
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 16:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84116D9CA;
	Mon,  1 Jul 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o3SO7Yee"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5831EB2A;
	Mon,  1 Jul 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851029; cv=fail; b=SKlgTXn32L7xuQYHHzVRtL0nYAgV/MaXBYQYn5qjtuPR50cUAggA/dPMNDURtyQiKh8qfOHBqJapUGovxnkvvXEdmKq9zaPrR8h6EzqEKsqXJRX6Ld54GswkVqFkoZ+FH6g/x4hk22DhkJm3F9/281k4JDO6gjgMz7M11ilEq2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851029; c=relaxed/simple;
	bh=yQBUi7w//0xuo5tcp9hWz6Ee6EzJLk+HHqPpVLqyAQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SYSm2CCIhDUTdfLMgbuTRL0bwjQIj4iGDc6Siwt5Ivpu1g5Ts5V1VbqDFzjt0afa5iy9ega0IHk6GhxpFBfY4JB2RBOs1uxMI+PqrRTtk7721qle/LMAbuvlEnpBv+OHB98nt6I00G6lVHJfDKYuGnYdePIzzMu59af7yC0ajjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o3SO7Yee; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpdOhjBlVncACzUDX/vRivLtyGjopBpbXPt0iL3arnb/+Ur1KQCeB4Od9tFVj6akNhCtbJ5b63bFw2QNeyCCA83EUmr26qj//lX2/LMaWRAirqCnxAr6DPkSrVyuZdRdzrlZc8NItAnOl3YH+Mf8gZ9mp3gqprxXQ9/4I16RzZUij24MLyKh3sUw7p/CRnQ1O3ib0q1BfTz6pA9mzReJDU0fLG9iHpiqxl0L8TsQyCC0KatV5mK3X/OUxpoFXIyJQfcR2U0ponC2LtuV0EM5GwNy6qBItbO7Z6DiN+qcBCJzT0CEepCGWQr4sBMyCCXCQhJ8eucvxgsWsCeTYkI+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9fh0uwJeVvvW9ITCQc0AXDKXhNYRZFyN0cCCiCpQ2s=;
 b=g4mzili3EyWVT7EH0//P2SXMBJeDFhFcQfUDJ9nXhXz3DfKHVlfoNIxRJ1mln9ixxaGaFb5Hv2lPoLv+AfWWdWd7mSC8uuBZMbV2OVMNnwt6X/KEzYZ3FppC/SlFL5NZHFMwY9s24hyl2VQ6m6PlNZSNG4+oUAloQOdlSLLBjS44Kqao+ey4IMjM/4Nu6rbbhaqYYuBLjwJa0X4wx1aOon1fbfh5Yml7dlxDpsT4WHTyx6GHSKFLwxsvM65uzswP0QB+vYccULtDNHpjJf5vbydMv6/OxXWq2IB4qV5ouTmgO3N/xVuqqe/3p9NXnw7NvOuWlXiS3ufxugFixKQjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9fh0uwJeVvvW9ITCQc0AXDKXhNYRZFyN0cCCiCpQ2s=;
 b=o3SO7Yee3H30DeFZoa2jwaOG7Pf1D2tYRWOlkh59oRwBwRLk58S0nZbopL5wT9EBJXJ+wRKP1r8BABujD5P7lZvol8AP2pp5mE4yvwH8comumbweNqZLKuG9uqYZHBG9/2/R1ly2mPusiO6el22hSe65m2F93gZdpz1WOAQjiEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 16:23:43 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 16:23:43 +0000
Date: Mon, 1 Jul 2024 11:23:36 -0500
From: John Allen <john.allen@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <ZoLYCJVfoRLJbGtW@AUS-L1-JOHALLEN.amd.com>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
 <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 515283b3-63a2-4016-6399-08dc99ea2cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2o4bEJFbGtXSi9nWnRzMnFod0R0dFljNlVjYy9TaGQ2TnJxK0pCRUdOZy9u?=
 =?utf-8?B?ZzF5NmRBV2I3SlNwN3JWQVN2eWJiWndVKzcxNkIza2JOTlBJby9kRjZnYWZD?=
 =?utf-8?B?TUtQN1BjbXlhaTRKV29GMHd4TElHZUl5Qlg5MWFlTXNCNmJhNzJERFI0YkFM?=
 =?utf-8?B?QTk4TlBvZ2pha2wxc0laVDNxdDkrOWhmcEZKcFpWcjB1ZzJCMm94eDByWUpL?=
 =?utf-8?B?V3hMcSthU0dmYmVBZW9HendYWG1NVFdadW5BamxUMTdHdzBMWHlDUjdRSndU?=
 =?utf-8?B?aGxqM3FHNjZ0WFRkS0NxaU92M3RHc29td2ora2d1anE3MTFWZzY1T2x3My83?=
 =?utf-8?B?dWsya0VJUnA0VkdhNyttcjZIWWl0UHNMMzFOeFRlK3huZUYzYjlVMnFsSWhh?=
 =?utf-8?B?WnNVZ0docGh2eEVhK29Rai8yWkZIU1hDUEVKZ003b3BjWCtOaTdNSUQ0WURy?=
 =?utf-8?B?Q21QUExsK1JEWjJIVmtYejQwMGZvRkVCbkwvSmNZNmxDOUtiY01sc0p5SXhw?=
 =?utf-8?B?cjhWdlB0dFRvWjFKM0FwdkZvc1VaR0UvSmVyVllZQTFJSWVyM2NqR1NJVFlG?=
 =?utf-8?B?WHRORUthbnM5cnA3V2dlR2lyK2JlYm5nMEVGL1BzQ1orc09jeXRMTkl1MWY3?=
 =?utf-8?B?N0FOWlJHeUo1ME1wVktIeGpQa3FscVB2Z1VnTmpnQjlCRlNDMk9jMTJGenZj?=
 =?utf-8?B?QnRxeDczNS9tUUlZWDlkREI3TzJnb3JzRTgyVGJlbSsxVlFpVjFodzlFOGhI?=
 =?utf-8?B?U1RCdjJEVS9sZzF6eXFLRW1YZjRtS3k0SFI1bk41NjRBRFRHL2hUSHFuVTVY?=
 =?utf-8?B?SUZoeFNUNGgvSjVCemRwcGtMY2Z1citKZ1R0SUdJWEY4SmlSMUZWeWdkdzdN?=
 =?utf-8?B?YmxLN215U0dvclMyejRYMmNLSjRrT3VvWlcrcDRSN09lSXRsTWVtRDRkbEZE?=
 =?utf-8?B?V3cyTHN0SFVYeVN3dThoZGx3aHJxbDEyWXR4RHQrNFowUXY0b2VqWHhUQitq?=
 =?utf-8?B?cnZnL1V2d1dQcFFnbGZIc0V0dDJjZEszL0dqTFptaDBNamtYS1BabnBqakIx?=
 =?utf-8?B?aVhlSUtYdVo5RFVBS21yWkJ5RnYrd0wvYmU4MWJGeFRXVHMxMEVubzZEdDB5?=
 =?utf-8?B?Rk5UcVlXWlBVV2p5dmdhTXZyWjA2SkFLL1cvOEtPakNWOU5PQWhUUTIrNWJt?=
 =?utf-8?B?Z2pSbHhKbUNEcnUwMFRJZUJEMTFxT1NDMnA1cEh3VGYrNlpMMTA3S3VEOUxj?=
 =?utf-8?B?Z3c1YTdQY0xLTHAvTUF3cEpYZUtLYTE2d3RzVk5kcG50djQ5clhSOFgxVkhl?=
 =?utf-8?B?WWhxOGVMMlIwRXg0Nm4vcVpKaXdIZS9aUE1UUjBZeW1iTWZqdkxNczlTdjh5?=
 =?utf-8?B?QWlZVk5wczBMRFgxYTRJaEJGeklwTnR5WlhLMWxHdFhoNVMxOG9LUFNZY1Ni?=
 =?utf-8?B?UzljaklkK0VNUnVjZktQRkl6MW5wVk5BZ2tydzhsUXZTQS8yejcxbGRWSEZr?=
 =?utf-8?B?SWF1dk52Mnd4NzJnMDZxZjdyVFowVGtnaDdJMERrc1NiMzA0VXdBbUVwS1Ay?=
 =?utf-8?B?QU1memFZYWtSZmc1SWRkcCtpZ2JKS2tyQm5SVkJkdWwzTlhSL25qL0dCZG1R?=
 =?utf-8?B?bG04Tjd0NEtMR3dMdTk4RUV1SUxldSt5enUwaTl0Zys5UDNLVjZra0FTMWdq?=
 =?utf-8?B?aHVhZ0hXSVhSWFZJcENSajJvS20wcThhOEVweXBVcmplL1BUc0ZXRUhxS0J5?=
 =?utf-8?Q?nqZy4mh9mJU/XHelv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJRWnJWYVBrUG43VW1nWkFSbG96K1Zsd0xIakZUa0lOd21ocDBra3JFWWZO?=
 =?utf-8?B?MVZnQ2pHRDZNbEgwRUtUVUp3VFU4OGlLNDg1S204dSsvQnQvMHl0MUIvb2lj?=
 =?utf-8?B?K2NnbFJqRjN1SkNMbE1vZTJWU2FZUWUycmdKRzZ3VEQ0eWFrWjZLUmFWdjlj?=
 =?utf-8?B?M3FXck45UkpPUGQ3ZjVhTUo0emRGdGpCL3FlYXo0Q1B6UTdvaXBib2pqdFRO?=
 =?utf-8?B?Wm9EQms4VHpoN1hqYkNTc3dLckIvQVdLUnJTMVBIWEpvTE1zaUtjZzdJRWZt?=
 =?utf-8?B?SFNZZGM3cTd2N1RIRkRscGpJYXJxYkc0V3FmNEovMDBoaFdQSTd6Um91L0Rv?=
 =?utf-8?B?bHUwSW9aWFVLanlvNDVDMXdJNFl5VkhjMVI4aFM0TmxqeC85Sk9qNW1FVkRk?=
 =?utf-8?B?cFR3cjZaSFNjK2dKaUh5dG5jc2p4L0J0b2FqY04vQ2YwL1h2NjlRYVN0bzlI?=
 =?utf-8?B?c1huUTlMWHZ5NTZ2aGhOL2VDQzFBRmYvK2dxZjlERFE2cGNRa0dxRnA0eVE5?=
 =?utf-8?B?L0JucjIzWE5WQTZEcWtud2RRTUUxekhRdFN1OTM4bzBRcmprc3NnSmZESE11?=
 =?utf-8?B?a3U3dmJMZ2N5eGJaUytCZWxxWlFHVmJ4ZCtVYXk0K1FEZGc4N25UTUZVVDA5?=
 =?utf-8?B?Y2wrMGdkLzhlRTl1dnZxSmhrcnFHZERSeXBKaklFeDZ5a0pTY2s5Tml0R0tk?=
 =?utf-8?B?NEhoSmlOazg5UmVtSkpESHNhS1h5dlY1S0c5RVhkWUZNUEVXTjJIQnRnRGFW?=
 =?utf-8?B?Tm5iQ3pBRU44Q3RXTUJDTFl5ODV6NXdoREJXU0VjWHIwN0YvTnRzeWttS3Q2?=
 =?utf-8?B?TnBKRXhQS240aVNPMUlDV0FUSHJVcE9rOGNlNk9MeUJ2ZW1mNnRIbmxmY2M4?=
 =?utf-8?B?T3ZyZHFPZVQ4SUU0MDF6MStJekxlK1lsM2pRUXJQWGVpMkg3WFMxTFBsa29C?=
 =?utf-8?B?Q25hWlBOVjdRL1o2K0ljOHN3ZHJiU2pwWGthaFQzWjJzdEdXQURVUkIweE0x?=
 =?utf-8?B?bU9QOU5UcFVSWUVYek1oaGlzQ21kU1RkeEJZNEFNOGdLbUtDRkYveS9xNndL?=
 =?utf-8?B?Vy9yMzZHbzVsUHBCYUYzRU4wZ0Q3RWk3QU81cFAvekFkL3FSSHNjU2lML2hB?=
 =?utf-8?B?Z1d6RmdhMFNXL3QzNlBqQW5sVllvQ0p4eUNVTWpnZ2lBUXAxNVJoT21mN1Iz?=
 =?utf-8?B?Z0QwUUVBc1Z2UFhVYnB3RUJGU2hxTHBOb3JUaldXdkFNUzdneWZENW9MMEUv?=
 =?utf-8?B?S2RPNHE0R3RRRW9aQVdPeG9aTDh0MWRybjdIZ1hGS0dlQ0ZabXZzV1dZWFhL?=
 =?utf-8?B?Sm9KT2VJSWl1V0RhSzJEckpsN3RTNCttZ3hSOWFmbzgrbFc1clc2K3p3bmx1?=
 =?utf-8?B?YUswOXRpemZhck5YUWNEKzRaOXVYclBJTVgrN1BhOXFtQ3lZZnY5MHNKZTFj?=
 =?utf-8?B?VUJ3RnBtVlVuL2VVLzMrVEVIOTBid0U0YVo0THllZ2tiZElQY2Q5SnAyc05G?=
 =?utf-8?B?V3owWGRHSDczSjdxZHZYcHhRL1FQeFFtQTc3cGdnT1hGakhxQ1VzUnVjUGZX?=
 =?utf-8?B?MER6c3dWQnhJd1hYczE0Tkc1cUo1UExJL2VYMzhOSEdkZTFIK1FCVHc1MURm?=
 =?utf-8?B?YjNWWU52VThOOHRQcmI3NnMveTloVm53NEZmY0RqbDk2ai9makJ4ZEFENDFC?=
 =?utf-8?B?Wjl0NjNRVk1qNnV5ZDBOU0h2MHZVc2J3REVZdjJESVZFQUdSdDBmSVJWNVFS?=
 =?utf-8?B?Nk5iSE9BZzNyd1piSm1lRWFSS201Tko3OFpOYTFvNi8wV01aaFNGU0RybWhm?=
 =?utf-8?B?b016SlZsVzNvK3ljZWd3a1NEdko1OHoxeXRHZlVIY0hOQTVKWU1pQlV5a0s0?=
 =?utf-8?B?UlpYZzB4RmpQbU94dS9rd3JKdjhLTzNLdy91T1A1ZUdlY2k2T3NJNTNvZi9G?=
 =?utf-8?B?R29vNmFXbXJpWUFJU1d6My9WUHRvMFNSTjJzcG56MUNzZzFteStYQXhSN0c5?=
 =?utf-8?B?SkcvcUpVWW56NjQxQ1dCS3FHNGRxbXJ3M2FDZlRHdWRrRVhFWUtvb09EMmcx?=
 =?utf-8?B?SXUzNFRDeWhtcVdlRlkrWG5tNVlhV2Zyd1dBNjNycUFrQnRFSGo2NFJzQ0I0?=
 =?utf-8?Q?wiD2jfdsB3MQJW59EbfNtBRqK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515283b3-63a2-4016-6399-08dc99ea2cd9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:23:43.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcvaTi1wF6SYC4Ho5Bnp/dZxH6qa4UOlo8kUQhb+iqJJ6bZEahoZpKojMiAvX6IOykl2RsZiQ8bWur1equtKzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

On Fri, Jun 28, 2024 at 09:45:22AM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 05:47:21PM +0000, John Allen wrote:
> > Future AMD platforms will provide a UEFI PRM module that implements a
> > number of address translation PRM handlers. This will provide an
> > interface for the OS to call platform specific code without requiring
> > the use of SMM or other heavy firmware operations.
> > 
> > AMD Zen-based systems report memory error addresses through Machine
> > Check banks representing Unified Memory Controllers (UMCs) in the form
> > of UMC relative "normalized" addresses. A normalized address must be
> > converted to a system physical address to be usable by the OS.
> 
> This should be your first paragraph.
> 
> > Add support for the normalized to system physical address translation
> > PRM handler in the AMD Address Translation Library and prefer it over
> > native code if available. The GUID and parameter buffer structure are
> > specific to the normalized to system physical address handler provided
> > by the address translation PRM module included in future AMD systems.
> > 
> > The address translation PRM module is documented in chapter 22 of the
> > publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> > ACPI v6.5 Porting Guide":
> > https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf
> 
> Those URLs are flaky and become invalid over time. When you quote
> a document, quote it in such a way so that searching for it on the web,
> can find it. The name above works for me so that's good.
> 
> > +#include "internal.h"
> > +
> > +#if defined(CONFIG_ACPI_PRMT)
> 
> Instead of that ifdeffery you could do:
> 
> config AMD_ATL_PRM
> 	depends on AMD_ATL && ACPI_PRMT
> 
> and it'll get enabled automatically and then you don't need the empty
> stub either.
> 
> > +#include <linux/prmt.h>
> > +
> > +struct prm_umc_param_buffer_norm {
> 
> What's a prm_umc_param_buffer_norm?

This is the param buffer struct used for norm -> X tranlations. I can
shorten and clarify this along with the others you pointed out. Maybe
"param_buffer_norm" instead and a comment explaining the purpose?

Thanks,
John

> 
> > +	u64 norm_addr;
> > +	u8 socket;
> > +	u64 umc_bank_inst_id;
> > +	void *output_buffer;
> 
> Use the usual short versions for such standard names: "out_buf"
> 
> > +} __packed;
> > +
> > +static const guid_t norm_to_sys_prm_handler_guid = GUID_INIT(0xE7180659, 0xA65D,
> > +							     0x451D, 0x92, 0xCD,
> > +							     0x2B, 0x56, 0xF1, 0x2B,
> > +							     0xEB, 0xA6);
> 
> When you define such long variable names, your lines stick out
> unnecessarily. Shorten pls.
> 
> > +unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
> 
> bank_id is fine.
> 
> > +{
> > +	struct prm_umc_param_buffer_norm param_buffer;
> 
> ... p_buf;
> 
> > +	unsigned long ret_addr;
> > +	int ret;
> > +
> > +	param_buffer.norm_addr        = addr;
> > +	param_buffer.socket           = socket_id;
> > +	param_buffer.umc_bank_inst_id = umc_bank_inst_id;
> > +	param_buffer.output_buffer    = &ret_addr;
> > +
> > +	ret = acpi_call_prm_handler(norm_to_sys_prm_handler_guid, &param_buffer);
> > +	if (!ret)
> > +		return ret_addr;
> > +
> > +	if (ret == -ENODEV)
> > +		pr_debug("PRM module/handler not available\n");
> > +	else
> > +		pr_notice_once("PRM address translation failed\n");
> > +
> > +	return ret;
> > +}
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

