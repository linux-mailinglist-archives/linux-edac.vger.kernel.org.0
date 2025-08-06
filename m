Return-Path: <linux-edac+bounces-4528-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D0B1CBDC
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1677117A83B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB2F207A18;
	Wed,  6 Aug 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HX9Cq0Ho"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B51A0BFD;
	Wed,  6 Aug 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504519; cv=fail; b=XwyuhRyRATrVDey7Lm2NFgYmNsm74UVwBuxlD75KLuXxdvbUXQ8TLYzL0qlKczvuz3JD+7t3XBLj3C2nbD+VJtfpxKhPXS9p5R94M+/iG1h6joT6StNYruTQ+qP3AxvBp4Z9wBAG+3M3EdacGwitN9CpgaYChT9XZULge1lr2GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504519; c=relaxed/simple;
	bh=zAygHD6nmtpG5PSub8supiSbwx1huTLoeLkinrJ9HjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugwipWWRF4r2Fph0voL+FBmQQvoxIM3fsNvY64wo32FtkdwfCAZBe2uXhlLI213ZbRxeQ9rL0o90BL+XHBbjw+6I2mrFYZQewSjU0PFNXA3hsG/haB1ZN77wchmbqdNzTfyvzSxcdqjHGQ3wfmKnelVyaSOkw/mCY5JXds47Vto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HX9Cq0Ho; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgYtfnglvnDjnLFZ/BiibGFYgx6bYgyHCr1dv3JUxiTb8nd3pPzBHARekPZoK4+1Y/sqc3AC+CNjr9gjXp1XEJrcfuXkzuufuKZYPlJv1qp60My+sUE+/4ehGNRGs9TnnUi+kOlQYnz3EbV1fAwxQkyyjynUf5KZXczsGBY692QpPnWLQPXN19vTrlUgVIeQRamBHV57B+BsrOYvJElSdG3uoHwaziJWDQumEkNuZ466G8T2+pMqBVFA9fYIfTTd6Sl+8pQ9vr17ZQmPh3JADLM2TeC0m+MUWF5x7SdsBZVkZqZCwQ5h6waeuuOgofdZD9lVUEGQPRrI23KGvMFvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFQM1GOytiTEtbn1GxiiYFbgcOewAS9Yb/wm/6TseSA=;
 b=hveyNabKbfOyfRefEP/w2mBCcmusROV9HEYD35+lv9nlMPv34+RGAWMu+Wc+sb4vUTKhsbfkcZovJFhT+5I2PQcHYuxnxSVnqM0NfsOd1J2LutspK1NBcB6fdbl8nuumKCG8QEfdp0X/FYD6Fu3NtEGyzu0PRdC1UqSOdlPPs2BZ/JivFiYPE6GGnOB+ufUG5y+cgQlgRNZ2WEZjvfEjs+ZgoWaAwQ+AdM0zbbqLU2f7Q/FnyLUewUW3IQyX28aWatrqS3lhv4l06UMuOJIuUUZCyIqj+snbTIDcoY+T/XVZM23rMFoyVjiPqLNVcFYhnGqqUzaPdZn1YY0DVciV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFQM1GOytiTEtbn1GxiiYFbgcOewAS9Yb/wm/6TseSA=;
 b=HX9Cq0HoNX7XtHoSyUITI466pLchEnOCADJZK89vcfeX4HGU98DiI1gZQFB/wsJUi62PzlCcAd+Rld8csUgx+WST1WwkMUnvw/hqn5plqGxxXu6f7wXXSEKbm0yhrUAlQfFN7MOCHMBQ/vyA3m+/mCPpjfMDqUZBbhHINWC9MS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 18:21:52 +0000
Received: from BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135]) by BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135%5]) with mapi id 15.20.8989.015; Wed, 6 Aug 2025
 18:21:52 +0000
Message-ID: <4406491a-d14c-4796-9a8a-7a4a3f99104d@amd.com>
Date: Wed, 6 Aug 2025 13:21:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RAS/AMD/ATL: Translate UMC normalized address to DRAM
 address using PRM
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, john.allen@amd.com,
 linux-kernel@vger.kernel.org
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-2-avadhut.naik@amd.com>
 <20250728144031.GA33292@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250728144031.GA33292@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::6) To BL1PR12MB5378.namprd12.prod.outlook.com
 (2603:10b6:208:31d::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9596006b-caa2-4870-166a-08ddd5161d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlFnRFV5TkVOdlJzNWJWZmdYbWN6dUlySFl1b1M0TTYyQTBBZ21DYml1WEdR?=
 =?utf-8?B?L2RnT2hjZWxSbFZHUHNxWTh6VkprMEJjZjUzWUFuT1gydFVaZzR1cHYrZ1BL?=
 =?utf-8?B?U1ZxWUhiNEt5NnlrVmE2NVd2MlhnYndMRUJkNVBtTXQ5RjM5eHFBOUYxc1NG?=
 =?utf-8?B?ZXE0aVptUWNUTFk0cEZWcGJCN2xaRFJVR3YydndDcEFKbzBCZFNDYko4S2dZ?=
 =?utf-8?B?ZldoWjVVWWtOZ3NNaTZPbktrTGJaK2dxbUhjMERvcUk4SzVtaFpEcjRCSHY0?=
 =?utf-8?B?Tk5jSjcxZUF1VEViK0tzRHlNSEJaWWZJMElCR1l6TUJoaFBEaVgwRzdFeFRH?=
 =?utf-8?B?UFltYXhLc2JxVVowUDFSTU0xN0NQa3Q0YzdROVIzZGpmbUowWVBtMERvZmhl?=
 =?utf-8?B?NGtPNDFWaVpWeDNPZklzbFVUS0cxbU4vd2pERkNhMzRhK1R6ODlDSFNQaDBL?=
 =?utf-8?B?dmtMSzJ6Y05UbTM2bVFWbmJSei9jeEgvZENTNkxsM3F3U01uRHN5SmdZcURU?=
 =?utf-8?B?b01NMm1ldlJmOEVUTFMxOWYvcklBak1BZ09uODd6VzVlNzNoUHJJS1BaeFds?=
 =?utf-8?B?ajNPVGRDaTJuTDBJRGc5Ky9uNS9NQ1JUQ1ZOY0g2N1RLTzhtNnlCQ2JiY2Vk?=
 =?utf-8?B?NkRaMU84eWdwSlBTd1M2UXlmeWdSb1ZtclNoRGhtdytEdWJ3Wm1lb1hkNlpx?=
 =?utf-8?B?ZGhmbFp2V0NxaXl3UDdnZU81Z1ErZlBKNkJid0pQbkVQWG5ZYURzZlhqZUFS?=
 =?utf-8?B?THJzbFJ5dEdidW83Sit2VjNBM0ZTVXV2NU10c1V5SzRSVHZhU2E1UzR4ZkF6?=
 =?utf-8?B?N1N5VHFOeTFQdWJCcnNQRm55SWZtekpacHNtcmZIWVVqV0NFeDYwU2lISGlK?=
 =?utf-8?B?SUFnenlkU3kwSE1sMkFNYXJWUGMwRldJa2twc1dCZXVUYU9BSk9xaTJneFBE?=
 =?utf-8?B?d2xYRWNnb0NMWFFCdFdDdFBFQVIxMXQvSWZYc0pQOVRVMmR1L1lFUEQrODY1?=
 =?utf-8?B?RHl3Y0V2cGNva3BCRWdzcDM4Z2YveHF2RUlEQXBFRjB4ZU0zWHV4TVBDRUZj?=
 =?utf-8?B?Y1p4bVlKVXF3c0h4bFUwL3VvQjZUdG95c3drNWZjK1lqL1N6U3hrT2NFZG1m?=
 =?utf-8?B?alRQVzUzbk5SQWhXdCtGSHRCWks1amQ2WnlKZDFCS29pdEd2MU1NU0lLcjVM?=
 =?utf-8?B?cWpUUThjRG53bjQvUXBweDByTzlmOFlFcHA3NTU5aCtMc2t1VTJRbnpGcDdr?=
 =?utf-8?B?ZHNGbVhGanFFMGU1Mi92NnVKblJRaFdabG1ZR2l0NW41R0RvYVR4Z3lSdUZY?=
 =?utf-8?B?K2Y2dDJGcml2dkhyVUNWbGxxeHRKMDFYclZmWFBnMHJ4MkRZVzgwdWxtaXJx?=
 =?utf-8?B?UUUvaVAyMTFCdG8wNTdhc2tPZGticTN5Qi9PTUhTVUhKZWFjSHNmRXpEb1pS?=
 =?utf-8?B?RHBtdHpMR09ud1ljVjRGK2lxSmh2N2Y1cnJ3S0NyMk1yZ3kzSUtJNGZVN3ZW?=
 =?utf-8?B?Y3pObHBOWS9RcU9LeG9pTFFKdnN4dm5qeTRHNWFydGNWK2o2R2xDa1Q0MzRQ?=
 =?utf-8?B?YURMckppcVFOQjQxNCtrSWp1ZGN2a2R2bFFrSGJrMWpjYk1iM3h1eFFIdG5x?=
 =?utf-8?B?OXBWdStIMVVkdHhUMkxDMUZyNmdFUFZDQlZGZ2hoQ09sdXRNTk1ZY0VyLzBG?=
 =?utf-8?B?NnRRbk51aFVDRk9jVVU0SzdNS2dzaXhEVHkwZ3p6cTNlMDNhVHRyUTlPVUpw?=
 =?utf-8?B?V1o2ZnBpMUhqQlNzTzUwUkhuRG41NHoxWjNrZkdadkFRVEt0b3VNRjNkbzBN?=
 =?utf-8?B?TEk1MUVxNWFISHlKRU9ES2hDa2ViVjdZYXlHQnQ2SjE2NmFubVhsajB4aTB0?=
 =?utf-8?B?Y0lEbGhiK3hkQktTMFc0U0RtTXgwZTNYWFpoTG53V0NQM3dxd3hVanJQUzVS?=
 =?utf-8?Q?/zh9K8wJ6GA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5378.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0pJVnQxU3pBOXdyZXNyWEtlZVdkVDBBQ00ybGc5ZW1veHVMd3B3ak05VWRk?=
 =?utf-8?B?eEJqYXE4WTRiL0xMTFQ0Tkp2TU5CSUh6Sm5FNjA1MXN6dTB0WXlveENIaW16?=
 =?utf-8?B?UndiUDl6MXFwdzRmcm1jKzB2TW81UmhZMFlRY0UzZlBzMmdFRmcySnpJZ280?=
 =?utf-8?B?TmpESW5VcFlkbjU5Tzl0WkRFNkpFWU9aSzF3Mld4RHJUWVk3SDlYTXlHazhR?=
 =?utf-8?B?bzRtNjAvc09hUmNmMTRaeHJGd2daNjcrRkhsZFNWN2tjditaalpBSFhKd1FJ?=
 =?utf-8?B?VVI4SUJpTTNjR2szWEtmdjdpMExYNnArc3phaEFvRUVacVhKb0Zwd3NqdkN0?=
 =?utf-8?B?eHFrNG5CYjJvUjBlcEhpcXVTWEtxZTlzcEx4M3dIdWN4bC9vY0dDWUFqSGhy?=
 =?utf-8?B?K3NmRmh2eHRWZWZ5dGxrcmJCcWx0eEEwZzYrM2U4MFpCZVNPL0V3VldNRG8y?=
 =?utf-8?B?R2xacUlhZE5JSHNFQ2ltWDBqdnZTVkJ6TnRyKzRKZ3pNMUNDT0RDRzM2S2Vh?=
 =?utf-8?B?akRXWCt0UmlaOTNoWW1zb2d6M200RUNYdjMyREtYbWU4YzAwdDZ1UUlSTzA0?=
 =?utf-8?B?UVFVN0RqR0VEU2dDZlp1RDVsZW53SWc5N3FWV1N6cnF4N2JzZGRLQjJMVzJI?=
 =?utf-8?B?a2VWWjF4eHRvQzRlTksvVGo3dDNibVdqTGplNjAxM21IWnFpWkVsRHZtNmJP?=
 =?utf-8?B?NS82YUxtd2ltT20vZTJRa2RsWEowMG9yRTFsYlBid0lDNXA5aUd5d21vNnV6?=
 =?utf-8?B?enM4ZjV3Z21ESWpIaHU4Rnh6NFVBZ2JYUS9kU0JrVlhUakV6eXM0KzZvNkw0?=
 =?utf-8?B?cWxGdnpLL0FPb2UvTmdMN1hyMkdXeEpTclN5R2JlLzlNRWQ1aDNCckZtT3Yr?=
 =?utf-8?B?a0dDZndmdFdOYmxLWGYrckZWQlBra2NCbGZTK2M5WWxSVFZCYWdDakNDekZr?=
 =?utf-8?B?bEl2SmZlWTZXczFDNUhoVW1RNEZhbGVubXZDN2N5WnhrVGh5bjBUNFdTazVH?=
 =?utf-8?B?MnowelNtWFlrRkNTOHJYdW5pZk9pSlhxU3puWndBRWtFbHpUNXFWNWJvWFo1?=
 =?utf-8?B?SXk1OFllMnYzeWJETkY0NjhQZDlqSjFvM0xUWUVrd3JRVzZEUDcvcFRqcHl5?=
 =?utf-8?B?Y2taY0JPOHdHaWxESVMyOHMzcm1BRFdjcGxGSVlEcXFQdXVUSUV4U2pjQmpW?=
 =?utf-8?B?ancyY2gvNmFtdkovMWhxbHY5Ym5IcEVXeFJkTVhUUmxqRWFML0ZWVXRmVU83?=
 =?utf-8?B?YVNIa1VaOUYyaUdhUDZIdmFwSk1lMnBra2d6SkZXM1lvNjZsSFVWSVo1ajQv?=
 =?utf-8?B?eWlyMzlYTFV2bGJ5RTdtdHYyQkhIOS9RZjd4RHQ2RWFzMkNVam03TFU5Y0tI?=
 =?utf-8?B?QkJ4d1lRWWhjZlBUU3lqc2VtMnVCL0c4Wk1YV1pnZ0lMWS81SUtXejlpQW14?=
 =?utf-8?B?YVBBMDhLbk0walk0TUQ1K0lMU09IYW52ZW16YUFDQ2hqMlQyWm1DMU1LaFdU?=
 =?utf-8?B?TkZJZDJYV1VLdjg1YS8zR3ZOeWN3Qzd5RU1xeVg4ZVY0b28yQUh0cDlibTBI?=
 =?utf-8?B?dXFuR2FhYjFvR2ROMDNSRXhsRS8wcnFSOHN5SEdmMld6WVFjV01uYVpsejhG?=
 =?utf-8?B?UDRyMVpkbzJXRkZNVlJXL3FxMGpkb2p4RVBMTm53T1ArQlBRbDlBNGl6Zklr?=
 =?utf-8?B?aWQrSlowR3pPZVBrMXFVZlVOSmZPVWwwN0Vidyt3NmJLTkdUU1lHLzRmTXBK?=
 =?utf-8?B?bDFldnErMWZLSExQelI2OEt3M1pod2IwUnVCNjV2SFhTRXN3ZHFFVE9sNjRr?=
 =?utf-8?B?aUxQcmYwOHlidlFKMEVaeGg3R1l5ekkrUG5OUitVSTE1Tzd1aUp0cnFCVWx1?=
 =?utf-8?B?b0k1QTByVmtXa2ZGTFVxeklKVlBqM3JwODJqNmljWndCTS9hUnozSVRkNkM5?=
 =?utf-8?B?ZGlkelk2bWxkVzZLZkYrMUZ2akIxVE1qMnlReElUNHhFZEJxbWxZRHpnWEVY?=
 =?utf-8?B?azI2Sk51RE1VSm9nU0dmYk1PZmszbnpkWlRRWEwxa2ZyVUJFZDlMc0lnVHdy?=
 =?utf-8?B?dDV3c2FaUFdDdVZkYUVwZS9lRURKaTFaUVlCN1lRcjRMY0syWHVrcUdEM1ZR?=
 =?utf-8?Q?ccYbDcPW1YOhOakz+rJs952W5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9596006b-caa2-4870-166a-08ddd5161d78
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5378.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:21:51.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT9gDrhDPWlcWbSZLcn+zeVjsGGumb1wJrQ0hCxT+7xCnxfeNxnA1q1K8lVuohdFZmS8iRh8YeIVM6ved6hZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Hi,

On 7/28/2025 09:40, Yazen Ghannam wrote:
> On Thu, Jul 17, 2025 at 04:48:42PM +0000, Avadhut Naik wrote:
>> Modern AMD SOCs like Zen5 provide UEFI PRM module that implements various
> 
> Minor nit: Zen5 is a core revision and doesn't represent an SoC.
> 
> You could say "Recent AMD systems...". A platform (FW/OS) interface like
> PRM doesn't depend on hardware revisions.
> 
Will do!

>> address translation PRM handlers.[1] These handlers can be invoked by the
>> OS or hypervisor at runtime to perform address translations.
>>
>> On AMD's Zen-based SOCs, Unified Memory Controller (UMC) relative
>> "normalized" address is reported through MCA_ADDR of UMC SMCA bank type
>> on occurrence of a DRAM ECC error. This address must be converted into
>> system physical address and DRAM address to export additional information
>> about the error.
>>
>> Add support to convert normalized address into DRAM address through the
>> appropriate PRM handler. Support for obtaining the system physical address
> 
> It's not necessary to mention that the SPA translation already exists.
>
Okay!
 
>> already exists. Instead of logging the translated DRAM address locally,
>> register the translating function when the Address Translation library is
>> initialized. Modules like amd64_edac can then invoke the PRM handler to
>> add the DRAM address to their error records. Additionally, it can also be
>> exported through the RAS tracepont.
>>
>> [1] AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide, Chapter 22
> 
> Could this be a link?
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#links-to-documentation
> 
Will take a look.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/ras/amd/atl/core.c     |  3 ++-
>>  drivers/ras/amd/atl/internal.h |  9 +++++++++
>>  drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
>>  drivers/ras/amd/atl/umc.c      | 12 ++++++++++++
>>  drivers/ras/ras.c              | 18 +++++++++++++++--
>>  include/linux/ras.h            | 19 +++++++++++++++++-
>>  6 files changed, 89 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
>> index 4197e10993ac..ca1646d030ca 100644
>> --- a/drivers/ras/amd/atl/core.c
>> +++ b/drivers/ras/amd/atl/core.c
>> @@ -207,7 +207,8 @@ static int __init amd_atl_init(void)
>>  
>>  	/* Increment this module's recount so that it can't be easily unloaded. */
>>  	__module_get(THIS_MODULE);
>> -	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
>> +	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr,
>> +				 convert_umc_mca_addr_to_dram_addr);
>>  
>>  	pr_info("AMD Address Translation Library initialized\n");
>>  	return 0;
>> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
>> index 2b6279d32774..53095310438c 100644
>> --- a/drivers/ras/amd/atl/internal.h
>> +++ b/drivers/ras/amd/atl/internal.h
>> @@ -279,18 +279,27 @@ int dehash_address(struct addr_ctx *ctx);
>>  
>>  unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
>>  unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>> +int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr);
>>  
>>  u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
>>  u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
>>  
>>  #ifdef CONFIG_AMD_ATL_PRM
>>  unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
>> +int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
>> +			      unsigned long addr, struct dram_addr *dram_addr);
>>  #else
>>  static inline unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id,
>>  						     unsigned long addr)
>>  {
>>         return -ENODEV;
>>  }
>> +
>> +static inline int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
>> +					    unsigned long addr, struct dram_addr *dram_addr)
>> +{
>> +	return -ENODEV;
>> +}
>>  #endif
>>  
>>  /*
>> diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
>> index 0931a20d213b..9bbaf8c85da0 100644
>> --- a/drivers/ras/amd/atl/prm.c
>> +++ b/drivers/ras/amd/atl/prm.c
>> @@ -19,10 +19,11 @@
>>  #include <linux/prmt.h>
>>  
>>  /*
>> - * PRM parameter buffer - normalized to system physical address, as described
>> - * in the "PRM Parameter Buffer" section of the AMD ACPI Porting Guide.
>> + * PRM parameter buffer - normalized to system physical address and normalized
>> + * to DRAM address, as described in the "PRM Parameter Buffer" section of the
>> + * AMD ACPI Porting Guide.
>>   */
>> -struct norm_to_sys_param_buf {
>> +struct prm_parameter_buffer {
>>  	u64 norm_addr;
>>  	u8 socket;
>>  	u64 bank_id;
>> @@ -33,9 +34,13 @@ static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
>>  						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
>>  						 0x2B, 0xEB, 0xA6);
>>  
>> +static const guid_t norm_to_dram_guid = GUID_INIT(0x7626C6AE, 0xF973, 0x429C,
>> +						 0xA9, 0x1C, 0x10, 0x7D, 0x7B,
>> +						 0xE2, 0x98, 0xB0);
>> +
>>  unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
>>  {
>> -	struct norm_to_sys_param_buf p_buf;
>> +	struct prm_parameter_buffer p_buf;
>>  	unsigned long ret_addr;
>>  	int ret;
>>  
>> @@ -55,3 +60,26 @@ unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long
>>  
>>  	return ret;
>>  }
>> +
>> +int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
>> +			      unsigned long addr, struct dram_addr *dram_addr)
>> +{
>> +	struct prm_parameter_buffer p_buf;
>> +	int ret;
>> +
>> +	p_buf.norm_addr	= addr;
>> +	p_buf.socket	= socket_id;
>> +	p_buf.bank_id	= bank_id;
>> +	p_buf.out_buf	= dram_addr;
>> +
>> +	ret = acpi_call_prm_handler(norm_to_dram_guid, &p_buf);
>> +	if (!ret)
>> +		return ret;
>> +
>> +	if (ret == -ENODEV)
>> +		pr_debug("PRM module/handler not available.\n");
>> +	else
>> +		pr_notice_once("PRM DRAM Address Translation failed.\n");
>> +
>> +	return ret;
>> +}
>> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
>> index 6e072b7667e9..df6accae8929 100644
>> --- a/drivers/ras/amd/atl/umc.c
>> +++ b/drivers/ras/amd/atl/umc.c
>> @@ -427,3 +427,15 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>>  
>>  	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
>>  }
>> +
>> +int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr)
>> +{
>> +	u8 socket_id = topology_physical_package_id(err->cpu);
>> +	unsigned long addr = get_addr(err->addr);
>> +	u64 bank_id = err->ipid;
>> +	int ret;
>> +
>> +	ret = prm_umc_norm_to_dram_addr(socket_id, bank_id, addr, dram_addr);
>> +
>> +	return ret;
> 
> The 'ret' variable is not necessary. Just return the function call.
> 
> You can go even further and not use any new variables. Not sure how
> it'll be aesthetically, but that was my first thought.
> 
It may not look good aesthetically if we remove all variables.
Will remove ret though.

>> +}
>> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
>> index a6e4792a1b2e..cae6388d41be 100644
>> --- a/drivers/ras/ras.c
>> +++ b/drivers/ras/ras.c
>> @@ -19,15 +19,20 @@
>>   */
>>  static unsigned long (*amd_atl_umc_na_to_spa)(struct atl_err *err);
>>  
>> -void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *))
>> +static int (*amd_atl_umc_na_to_dram_addr)(struct atl_err *err, struct dram_addr *dram_addr);
>> +
>> +void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
>> +			      int (*f2)(struct atl_err *, struct dram_addr *))
>>  {
>> -	amd_atl_umc_na_to_spa = f;
>> +	amd_atl_umc_na_to_spa = f1;
>> +	amd_atl_umc_na_to_dram_addr = f2;
>>  }
>>  EXPORT_SYMBOL_GPL(amd_atl_register_decoder);
>>  
>>  void amd_atl_unregister_decoder(void)
>>  {
>>  	amd_atl_umc_na_to_spa = NULL;
>> +	amd_atl_umc_na_to_dram_addr = NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(amd_atl_unregister_decoder);
>>  
>> @@ -39,6 +44,15 @@ unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>>  	return amd_atl_umc_na_to_spa(err);
>>  }
>>  EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
>> +
>> +int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr)
>> +{
>> +	if (!amd_atl_umc_na_to_dram_addr)
>> +		return -EINVAL;
>> +
>> +	return amd_atl_umc_na_to_dram_addr(err, dram_addr);
>> +}
>> +EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_dram_addr);
>>  #endif /* CONFIG_AMD_ATL */
>>  
>>  #define CREATE_TRACE_POINTS
>> diff --git a/include/linux/ras.h b/include/linux/ras.h
>> index a64182bc72ad..feb53f8470b0 100644
>> --- a/include/linux/ras.h
>> +++ b/include/linux/ras.h
>> @@ -42,15 +42,32 @@ struct atl_err {
>>  	u32 cpu;
>>  };
>>  
>> +struct dram_addr {
> 
> There's another struct in the kernel called 'dram_addr'.
> 
> It may help to make this more unique with a prefix: atl_dram_addr.
> 
Will change this.
>> +	u8 chip_select;
>> +	u8 bank_group;
>> +	u8 bank_addr;
>> +	u32 row_addr;
>> +	u16 col_addr;
>> +	u8 rank_mul;
>> +	u8 sub_ch;
>> +} __packed;
>> +
>>  #if IS_ENABLED(CONFIG_AMD_ATL)
>> -void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
>> +void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
>> +			      int (*f2)(struct atl_err *, struct dram_addr *));
>>  void amd_atl_unregister_decoder(void);
>>  void amd_retire_dram_row(struct atl_err *err);
>>  unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>> +int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr);
>>  #else
>>  static inline void amd_retire_dram_row(struct atl_err *err) { }
>>  static inline unsigned long
>>  amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
>> +static inline int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err,
>> +							struct dram_addr *dram_addr)
>> +{
>> +	return -EINVAL;
>> +}
>>  #endif /* CONFIG_AMD_ATL */
>>  
>>  #endif /* __RAS_H__ */
>> -- 
> 
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


