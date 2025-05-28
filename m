Return-Path: <linux-edac+bounces-4026-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD45AC7190
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 21:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71D44E0602
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1521FF3B;
	Wed, 28 May 2025 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lCjTB9un"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97B21CC46;
	Wed, 28 May 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461133; cv=fail; b=F3fzR3WGJkVBXyslT5KXApyfYDj0dBirlbyr1f4NNZkdQc6iyT6Us0Vnbb87Fqbfd3cm9jnQ7D0riGBnTQZnEQxolNq9Bjj7uWAnygaUH0ZiSJm2g02iNV56GjCqe6pRCA/2YC7kn/8ak4wn9gFnyumXd4QMkivYUUKnTDcRxnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461133; c=relaxed/simple;
	bh=6Zj0ytnkJpL/MX0qYLjEHFvufQlP39WCJVfi6fI2f+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cfg06uYz0ydeucWeWNtYdMYFX/7DFwg/le9ggIRM/n02535GUms3NpzYX5D45GDcZTBVGXnSg+/+l+xH/HXfNyyK6PtvyF7ioBQml2s1fxvZfaazovx1x7Cn+kTtJ7dBnSdaJRG0nnHft/QvK0ltQa5+cjpseADqewRJh3Kqu78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lCjTB9un; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seEZ/LLlPIWjNWWmB1BdfWf2wurhqfXeAYrXmh7nc0uT9VC1pEMKFFGwRaJBNFMlWEBinQobrmiyT4a73bXAOJ9J71QziDn/yDts3cyGeuk87Iv2GX4VICoX9EDs7Dy/l9XbcAgI675Xi/jtWu8R/w4RDXmCvkDP36LX9oUe6NCMY/80EydV5OFQIP3iVaQzkucF87lGoAFEDXyfcYJ4QerBh7b/BAFW4WzW/Uh9Qqf8gE5Gk+QCGc8qNaXpDJkzmYRijmAw058Pn6moH8IJP+l1CjJo4/V535pyAItq21+VIQl4WdJeL+XOFj9p9CHwSXkjbv6HDGNL1ijcrMz3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWZhumWwY+eGATJ/a5zYPHbh121l+H8GRBayHHxdE9I=;
 b=JHxRe/2eE+J19tsNmSO6y1C76D/viIzmfktFVyddcwvREA631yxap+K75LTpE7tSE9AoRNcJrz1uQ5hG73NvAX2vxI1+qu/cpb8wTK+M1nshiRFIqUpoKqmhl0cdc4qN8Y4G4WYHRCY3nkvNFd6Veys8QaTj8p17Jy4BChdhONQcM0uvK4hCZF3+DxpUCcR/aSYGLwE974OsdBt7oFgD/WXxSIFJ6Sv0ATjPVIGlzRIwFunktB36GpP+Cnql4bWW6dFy9B5sHBou9fiGMHZU0vm/7N5/Qlfd2wiPhN0jmy4Qbdj/VmyDmUWYpN4qiA+IS8WPfaY4MIl0s3mj8BjsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWZhumWwY+eGATJ/a5zYPHbh121l+H8GRBayHHxdE9I=;
 b=lCjTB9uny84ZEahOkoGpMLyoA+e1FHFVHzzmTB7oIcXqimPPdCUHDVo+Vado2gPRN3Y4ZAON1i1imifGYZ+XVYsAYMppfdfqzdoNpHhm76vQeKQr53J3p50xoSBjus8n2bScLjexio/nKNEJh0JxxssAHH7SDicBbsGBfhpSTTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 19:38:44 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 19:38:44 +0000
Message-ID: <d8c5bc59-5516-4a22-8c74-a266cbb9c59d@amd.com>
Date: Wed, 28 May 2025 14:38:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <20250513192221.784445-1-avadhut.naik@amd.com>
 <20250528092250.GAaDbV6oEqvE3279dJ@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250528092250.GAaDbV6oEqvE3279dJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0146.namprd02.prod.outlook.com
 (2603:10b6:5:332::13) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e12630-fcff-42a2-47be-08dd9e1f41c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU1tQ0lDOXBaYVE3VWJ4MzBTVStEMFovOHJHa1NGbTRRcFNpQ01BVXlIZzdq?=
 =?utf-8?B?eGZzaE9MYTV0NDd2YWNabVlwRnltNXUwUE5ZbytnOTg1bmt6dFI3MnBVRFhp?=
 =?utf-8?B?N1FJS2tDVENlNEdwUU1EY0EybEc4ZmxTNk9yNitlRWxrVHU4K2tuZFo2VytO?=
 =?utf-8?B?ZWw1ckM3QmVUNDgrSEFIMG5vd0xOa2tiT1FSdk52Y2x0cmZvVk5NNUR3SUQ0?=
 =?utf-8?B?Tkx2aGVpdjcrWElYdkVpTE83ZGdMdzd0bTVpRjZRdDI1OStOMFRtR2R1QVMw?=
 =?utf-8?B?YjBkWWxId2dGZzFqOHlnMXduakhiSDJGNm9LM2Q5SjE4OHBuMC9HaGljcmQv?=
 =?utf-8?B?Q1VTNWFCSjBaMnJPM1l2RVFaU3d3ak1BRzRvRjRYTGkxODlMWnN0Q3pBam1E?=
 =?utf-8?B?UFdOa1VCeWpZbGd2QzV1amFvY3dlKzcwM2p2UzdMYkRnOTFjcVhBd0IzN2ZZ?=
 =?utf-8?B?cUhNTFZ1Zmt5cXJPdXYrWmR4OFNaaVNUZlUwa3c3MTJTMThtUk9UWFJPWUdP?=
 =?utf-8?B?dWk0cEgvSUpybDhlUWZHb0w0OWcyUWJtRytVZ214eDBqQTdJWHdlWnJyNlA5?=
 =?utf-8?B?VlJYSER0Y0RqUzUvRkhXRVpZRXYvVmNhaldHNm5VWm1LbmF2MGNQZEEvNW42?=
 =?utf-8?B?RGw0MGNINnlUSWIxZ1lPMDRlREY1Y2h5MjVTSHo5SDRKTlUxaVhSM3Y3NWx4?=
 =?utf-8?B?Mm8zNkdxZ1F1eVBLNTF5NnZWSWdTd01EOWpHS0UrdGwrdjd1ZEpjYmpNV01D?=
 =?utf-8?B?ZFc0UnUzSFJIWUNmMHRsWjdIeEdmbyt1Wjd6bmlWTDFvaHI5MEcrUEJKN1Jl?=
 =?utf-8?B?U2xQVDdENW9kVXVJUGJNTU5HNVNvTVo4eG1QL3VjOFVqUmlRcnRzU0xuNnVP?=
 =?utf-8?B?cGtnay8rQWFSU29uaXRPbzkvMnN1SWhPTWVaRE80NHBwZWwvT2Z1L3NDU0wv?=
 =?utf-8?B?Sjlia0VtQnQ5YWwvQkJoUGFHamxGdGIwTW9UNUNHeC9QMEhRaUJ4OUM2ZjBa?=
 =?utf-8?B?TnZxTHFpTi9PdHhuSGJvZ1JqR1FBYXJTTUhTSElvNlJvaFJ5bEx4cG52anhO?=
 =?utf-8?B?QnBDWHRXRC8xVW5ycWlreFgrU1pKNWNWQVpJaFhmY3NkN3paUjg2Nm1jeWly?=
 =?utf-8?B?amhXU2VRNXNLQlJXaTlQa1AwUHRjcXB6aUd4Z0psa3UyTDJxeFhlenNIWTFn?=
 =?utf-8?B?V1Q0OU9ON1FVb3JDZGhtS1hmWmFKZGdaVHdLcDIvRXozQ2hsYUlnWjBZUGpU?=
 =?utf-8?B?V3QzMFNZV1BoYURzbm80RHgxbS9pNnZmSm84UmlOR0hLVGJESFhKTXNweUVL?=
 =?utf-8?B?NlhQZ0x0Rk5YWTJhb0lIN0ZOWUd6OExlcVN3QUdHUGZsUitGSEY5NnVGeFJp?=
 =?utf-8?B?LzRpc2swVDF1SmtsTzFLQjZvSDhldHVCbCtiSDVkNXNpcTdLWjhMdzgyTnFo?=
 =?utf-8?B?S1F5eHJJOXh6aUxRNzd4NER0UG1XTURkMzZVWFJ5UDNGZnlGdXkzc2J0cERr?=
 =?utf-8?B?MnpRN21ZNGR5UTRRbENUNS9EaW1KcmZ6Y0FOanluSEc5aHE5b29KVXg3Q0VP?=
 =?utf-8?B?Y3ZqWWVPNFd2Z2RwRWZwcE80L1BvOUcwRmhqS1piQkhiWTZ1N0NWZTFUSVdE?=
 =?utf-8?B?OFF0TWhaSFYvRDBiVm9pNm1GTXdhOUo2QUtxRE9XQzliTDNCUUhtNm11Mjhx?=
 =?utf-8?B?dEdCMk9mMjk2cjUzVDgrcnFhSlZhTzZpdElRdmR4SUhKaWhNYTd2bHorSDk0?=
 =?utf-8?B?TGlGTXZCZGp2QllUdW5yOUFoa21VbE9mdDF3QnJMOUMrT2JEd21DK04zRitP?=
 =?utf-8?B?RnIyT1ZKamd3WkZNQVN0Q3NncVdVZmZ3T1FPeG9QYit0TEVBYWVTcTgzaGgz?=
 =?utf-8?B?U2VGK3daVjFmLzFUenJyVGRzS3FubXpvYkVhZ0UvNm4wdGpLbzhyNFVqRmpy?=
 =?utf-8?Q?e3UVLfeQhVTc73nhKZrEz4y5r2qzgqY+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBCelhkNm1ZeElYWjY3bWxyNXN3TmF5MWkwNFBVKzlodWhCKzFUb1lGME55?=
 =?utf-8?B?eHNqMUNyUEpQUWVNWEozL1dWN09tL253ZEZWUU1SbVdjZDcwKzRsQkdZbWZx?=
 =?utf-8?B?NlkvZ3BwKzd5V3VkZ3pwVGpQYWIxZ2dFZWhsWGtGckp4QWR2OXZKMWRBRzVI?=
 =?utf-8?B?Wi9PK1hnbUl1aFh5ZmdjbjNON2pUb2xFTzZQVXl6RVdTcE14RGpsRjg5aFZV?=
 =?utf-8?B?V2ZDMVJhMERHcytQWGxPR1gzaXlCeWh6K0doY1hZTUorSlk1RmNYbFIyRXhS?=
 =?utf-8?B?WEhPMjUybWx2eCtEdk1Mc0c3OFRkTktiNC9QeTM2R1JLMWcvajBpRU1aN1ZF?=
 =?utf-8?B?bDBKVUJtT3U1d2pRcTNDNjRibmZlYjQ5amRiK25oNzNQbnpLZWhXMTdGRC90?=
 =?utf-8?B?WFNydEtxYWJvQmFKMjRFckt3dG5FOGRmOVVPcjYwNUZUMmhhWlQyemF5NWpy?=
 =?utf-8?B?UDlrRjRrOG5BTjBQTUNYUzRwS1R6azZpSFZSUWprSFJiVEp3Z0hCUm0zNW5y?=
 =?utf-8?B?V3ZCaTgzSStMY2RtR0lJbXFiamtMZExLRU1oakh3SkRvSXg3RGRIcFdESmsw?=
 =?utf-8?B?Z3lXeENkYTZlZ1dxcHJCRnphK1hJSTJWUi9Qbnp6b1JoM05KMG9iVlM4eG9J?=
 =?utf-8?B?eDhycWovTVd1cGp5WWc2WC9icXc4aEcrQlV5emdEVDEzNFpYdkFsdE9KUDBI?=
 =?utf-8?B?RXBqSVpWZW0vTm1DaCsrV1BDWXBQaWZrd3JJZTlZMFAvcDNubUVXZ05SSHZV?=
 =?utf-8?B?ZXhOL2ptUXBKMllaaTVWclZaTUR3VTluMGRvLy8rZFhEWUg4ODBRL2dJeTBw?=
 =?utf-8?B?Q2N3bUQzYzF5QytEUzZ2alR0NkpMWkN1MTBYRXpXaWpiRGFmcXRWMDFtZ3Vn?=
 =?utf-8?B?ZnlZbjVUZzFSSDI3bncxY000T282MXJUSXFBa1prQlIzQjh4R09hUUE1bWdu?=
 =?utf-8?B?dEgzS2Z1Y1pYUXEzcWlqaHhkM0JubVAyMXVlWURkcG9TMGg1TS9OTVVPR0d3?=
 =?utf-8?B?bFhUTks2amNybmFXK2NORWlTZGR1T0xCZkNJdjFDakRMdnpTSXF0cVNqdk5Q?=
 =?utf-8?B?LzNtdVRoN2QzR1M0ZmRPbjF4Vk1mcWpvLzJXeVQ2eDlpV1pCdSt1aHBFanh4?=
 =?utf-8?B?YlN5UmZvUGd1bk4vOHoyeUJTcjFrZnY4akpFbFpaMkhxNG9aRTFmYlloMVg4?=
 =?utf-8?B?U2JOWCtjTTU1VnFkbGZWQWVOOG10cHlrRkNHZVJMUzdhdjMrV3FWWVJETkc2?=
 =?utf-8?B?YW9SaUV6SjJONWpLdFBoQU13UlFBTjVaT2hya0QyOW9KeEhCNGFjeEVpTFU2?=
 =?utf-8?B?eC9oMDgzdFBzN3dLRjhoWE4wVUptZTl3QWcwdE01NGxuWkFuc1dEa3NEdFZu?=
 =?utf-8?B?cm5EVTY3T2c2TmJxby94RTRrZTUybm1FSDlPS1RIWTZVS0oxTXlQNjJJdnBt?=
 =?utf-8?B?V3d1Mk5qUVFucnBFdWpKTU9sdWxMNHhFTHFTdEd1T0tUeVN2Mm5xQ0xuL1dT?=
 =?utf-8?B?RHNSekJidm5XVkdGa1JpZWdsUkcrb2U1MmFlZDE2MDRXVVZOcEF6R1hHK0lG?=
 =?utf-8?B?K0VNMHk2aWZjd1kzSE05Z0lLTGYxUU9EL2ZPL1ZWbXRyRjRMUlJqR242aDNW?=
 =?utf-8?B?VlZEZ1gwT1pRbXZSdEh1WlF4UTBINFZoTkZNWnZVS1ExYi9nZ2xoc0MrVjFo?=
 =?utf-8?B?MU1xMWtsU2t2Y2NjanZoc1dHNEIvNzI1b2VGRVo2VGphSUppQ3JHTy9LUjMy?=
 =?utf-8?B?Zyt0SGUxZnlVMVU5U015aFhESG84REhZWTFpbCszdGpxWVdMZ2dmK29BZnpa?=
 =?utf-8?B?R2YxZ2w2U3pGaXJZMDJnUmFXQXBxb2xhb2xZR2FNU3V4VnRPamhOdkNtbUtY?=
 =?utf-8?B?UUN5SG5IV21sdzhMSDdaZE1ueS9xMjdYZkFXWkNxNXYxVTFBdjY2YVdxNUpR?=
 =?utf-8?B?c3BRNVhVdGo0bldOVmRRV1R0aVlnZ1VBcHpOczVpS1d1UTIvTlhBRWNTV2x0?=
 =?utf-8?B?d0dNWGUrdmFkbWtoMnVkSlRqVSs2QUlEcW91Sm5KUWlKS0hpMysybWluZVhh?=
 =?utf-8?B?NDNmNHk0RmZURnl0Nmt2YXNjTVZXV28wK2NlK1RTS2doU1JISkVKdVliZW10?=
 =?utf-8?Q?g8xoPnvelEdStSmhuhfFlRFbD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e12630-fcff-42a2-47be-08dd9e1f41c8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 19:38:44.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rLDlUKxREZ2fGR9zp/cLUjrEXNucLxyzRE72WZs3huHDlhewRZK6dFnhzxX3xZqXPh08uSVpT/1skdg5803RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923

Hi,

On 5/28/2025 04:22, Borislav Petkov wrote:
> On Tue, May 13, 2025 at 07:20:11PM +0000, Avadhut Naik wrote:
>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
>> modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
>> register associated with it. The amd64_edac module logs DIMM sizes on a
>> per-UMC per-CS granularity during init using these two registers.
>>
>> Currently, the module primarily considers only the Address Mask register
>> for computing DIMM sizes. The Secondary Address Mask register is only
>> considered for odd CS. Additionally, if it has been considered, the
>> Address Mask register is ignored altogether for that CS. For
>> power-of-two DIMMs, this is not an issue since only the Address Mask
> 
> What are power-of-two DIMMs?
> 
> The number of DIMMs on the system is a 2^x?
> 
> Their ranks are a power of two?
> 
> Their combined size is not power of two?
> 
> One can only guess...
> 
By power-of-two DIMMs, I mean the DIMMs whose combined i.e .total size
is a power of two. Example: 16 GB, 32 GB or 64 GB DIMMs.
Will mention that explicitly in the commit message.
>> register is used.
>>
>> For non-power-of-two DIMMs, however, the Secondary Address Mask register
>> is used in conjunction with the Address Mask register. However, since the
>> module only considers either of the two registers for a CS, the size
>> computed by the module is incorrect.
> 
> Yah, it must be something about the size...
> 
>> The Secondary Address Mask register
>> is not considered for even CS, and the Address Mask register is not
>> considered for odd CS.
>>
>> Introduce a new helper function so that both Address Mask and Secondary
>> Address Mask registers are considered, when valid, for computing DIMM
>> sizes. Furthermore, also rename some variables for greater clarity.
> 
> So it is non-power-of-two sized DIMMs?
> 
> IOW, DIMMs whose size is not a power of two?
> 
Yes, non-power-of-2 DIMMs are those DIMMs whose combined i.e. total size
is not a power of two. Example: 24 GB, 48 GB or 96 GB DIMMs.

>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
>> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Cc: stable@vger.kernel.org
> 
> All that changelog stuff...
> 
>> ```
>> Changes in v2:
>> 1. Avoid unnecessary variable initialization.
>> 2. Modify commit message to accurately reflect the changes.
>> 3. Move check for non-zero Address Mask register into the new helper.
>>
>> Changes in v3:
>> 1. Add the missing Closes tag and rearrange tags per tip tree handbook.
>> 3. Slightly modify commit message to properly reflect the SOCs that may
>> encounter this issue.
>> 4. Rebase on top of edac-for-next.
>>
>> Changes in v4:
>> 1. Rebase on top of edac-for-next.
>>
>> Links:
>> v1: https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
>> v2: https://lore.kernel.org/all/20250415213150.755255-1-avadhut.naik@amd.com/
>> v3: https://lore.kernel.org/all/20250416222552.1686475-1-avadhut.naik@amd.com/
>> ---
> 
> <--- ... goes here, under the --- line so that patch handling tools can ignore
> it.
> 
This is an OOPS!
Thanks for catching this! Will fix it.

>>  drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
>>  1 file changed, 36 insertions(+), 21 deletions(-)
> 
> ...
> 
>> +static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
>> +				  unsigned int cs_mode, int csrow_nr, int dimm)
>> +{
>> +	int size;
>>  
>>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
>> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
>> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
>> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
>>  
>>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
>> -	size = (addr_mask_deinterleaved >> 2) + 1;
>> +	size = calculate_cs_size(addr_mask, cs_mode);
>> +
>> +	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
>> +	size += calculate_cs_size(addr_mask_sec, cs_mode);
>>  
>>  	/* Return size in MBs. */
>>  	return size >> 10;
>> @@ -1270,7 +1284,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  				    unsigned int cs_mode, int csrow_nr)
>>  {
>>  	int cs_mask_nr = csrow_nr;
>> -	u32 addr_mask_orig;
>> +	u32 addr_mask = 0, addr_mask_sec = 0;
>>  	int dimm, size = 0;
> 
> The EDAC tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
Will change them to reverse fir tree order.

Thank you for the feedback!

-- 
Thanks,
Avadhut Naik


