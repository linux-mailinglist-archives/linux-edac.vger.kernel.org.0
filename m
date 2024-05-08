Return-Path: <linux-edac+bounces-1014-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7548C016B
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815772848ED
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235E127E22;
	Wed,  8 May 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ccW42Khi"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C391A2C05;
	Wed,  8 May 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183470; cv=fail; b=gibpzHqMHO+gXVmV7g0m9DCuMqdHQJz6Ftm7cCXhXt1cDkGNAUeZZeDLU4BLMbf0khfDp4/4xld58kfd9FvPJFoi9UJ43iDniu109g5vFwbH7yU454XYQsc9KDtqS1XwWqkiXcmvtXja9XVRqx1xjotqZBOBB/jbcE1a0V+HkX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183470; c=relaxed/simple;
	bh=6xMOs16IT6s6C/xQKjd+njsT0A2q8ICKUnN5to4gYzY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igyJUAct+DHWLb5QN8kZyZqrrihSaEy80yuvTgOzdcJtk4iBnqVQa7V10C5uh+Tv4UUoERT0IX1VrR4f3QDOKDbBUQR7ovCBsGi9eAD9Y4NfcPIWN3sdNHuO9qAo8MTbi+dJT9EJvAi6mN6LT9KAPo0I2s84rBMSQ8m464qPMRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ccW42Khi; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV6KeC4+5WY8nbhWJGVAKk021POji6ysx7Q/UGeI0Yt6NFzrUn2wfvJGVW86ScihiFLkRzj1ko28gABolrE8iFscqILoBOumaCZkKKcSE7b76tqCjZP1Ks/XuJJMIfQQtsU7cgfgGue88qW5F5CoVMBns/BgRYazKZSnSQ3XXeMcL9AGjrbjaIWWmE/Uh4QI4BR9lMCeH2mxc7vjYKzt0Hej34PeWfiF/yGeNaGgWeRBNrEO9UroQbIqmhasU9y0U1NXRp7Ye/xxuj9jwN8CjI0t5Ba6rp29qQu2LjaNkKE4x+9TTQbcdKmH6fjrF+bHsa4NV5A9Bi3DycJIMBtESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwrMJRWNgXhAeSa16xUXt4lSsx2P15o3V2GvFH77SKY=;
 b=SuCs+DOoi8ymz122ZWwNRPwLtXw/kb2/PIw+kN4VBLn0nD7n6ZU0z4L3uzUVdpmIbmyDLa/RNDQaL8qPsvpt1KEajtjQ1Qy8fhDulLKfjy+norNWHPpw5jkW2HZoxuiIxME502yEgt22lKpAmT6P1PeIvOWrgWlIze13MkIZtysVqvcNV1wakMlyWsc6Vi4mBFliYZCWy3+mW7Obg7QK7coXhlDnXRu6OrHXBA242rkWUIw2KkUJJmzCjy9gNCQ4l3UZ+nqtDy/MRNb+cRqI57AuUza4bL8Qgu25JdmOeAVFexYqR3eLMdhCYudleqL6kgvLYsLaSlvjQH1oUSNluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwrMJRWNgXhAeSa16xUXt4lSsx2P15o3V2GvFH77SKY=;
 b=ccW42KhiD7ZvkvP4RlHGBGCjX7cnSYEjU/4a9b0IjzuG/8q9eWg0A+VXtStzQGHYUCDlx1njl2Zq3CPoZxMc4in4qs/rCSNrJWVhAmO52zAzsJcfPYAJ3uFGZkaH8Qq4bL9bvc0f30l6fI2DIGljVswG03ydQCFzmNQPpUIsyq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 15:51:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:51:05 +0000
Message-ID: <046082f5-0d6a-4df3-b0c7-49938bcd872d@amd.com>
Date: Wed, 8 May 2024 11:51:02 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 0/4] RAS: ATL: DF 4.5 NP2 Denormalization
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240506154605.71814-1-john.allen@amd.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240506154605.71814-1-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0634.namprd03.prod.outlook.com
 (2603:10b6:408:13b::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f7ed5f-6dc5-4279-ae52-08dc6f76ab5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXNHNURZN003cWEvSjY2c1dwY0RLOGY3a3QyS2I2czMvOVM2S3pUNk1QSDRs?=
 =?utf-8?B?MzhaTDJtMUl4WkxHMzRNMEdFR1p1OGp6QU1UWGhmNEFzZFhFOHBVcDVIbDh2?=
 =?utf-8?B?N3dhRW5qK3duVWZBYS9mN0M5Y0FFTkhCZTdwNnNYRDE0YjVpSVBUZWIvQ0Jy?=
 =?utf-8?B?ajF4dFloK1VoYmw5eUg4dEl1R3NNWU05R0s0YmF0ajI0YW9BNFA3TDMwVmZ1?=
 =?utf-8?B?VEpBOTMzbE1xcExBV01kYndjTWlIcEJLYmxUVnNBelhQK2o0Ym00bDI5SElF?=
 =?utf-8?B?Y25qUDN6cGh5Z0YvSTNtMDJKWjB4N203K1ZjZ0lPeUZIV0RNeWZ0VHRJWll3?=
 =?utf-8?B?MHpyNVhXMG5saE1EaDB3R2pkUTNONmhqcHRoQkZhazJGVTJCV3crL01jcWJE?=
 =?utf-8?B?RVpSVHVodDFZcUI2TVJUdVpMNWJRZFZ1Y28rVitLQmI5dlBkUkJySmtmcjRW?=
 =?utf-8?B?RVFCNEtIVTNEWEpnMW90QjRFUktyV2FOb0s1V291UXNkQWd0RkpQeXVkajB2?=
 =?utf-8?B?dnpkalp3ZlpIZHBUdFN4OEZ5ZVdTL2IralZibDZrQ3k4WmQwN3dJS0pVUGRk?=
 =?utf-8?B?cFhpSU01RlY0Y2dVbjh5MnBJVElHQ0h4NnhLOTh3TEh1MUE5S1dhYlpVK21u?=
 =?utf-8?B?RWZTY2hSTzJCMVd1STRPZFR3NzVDU1JNWjZUTGlrSnluRHU3eXE0T0I1NTB1?=
 =?utf-8?B?ZGY0ck0xNzJXdnRGRVpBVTJTUVVIcmdNd3J5dGJocTVKSVBRdm1EbVRmdnh5?=
 =?utf-8?B?Z0pSbENyNmVZQzFNTWk3b0MzUnIxcnFEb050cGE3VWJ1czlQRTdpRS9jZkJZ?=
 =?utf-8?B?bjNHM0pKY0QwQzdhVFpzVnZoc1E3andSVnZ6dWRoWDBJU0QrVzB4N0Z5dVFT?=
 =?utf-8?B?VEc3NzNXT0phN0p5YUdtTms4WlBNMmtRYy8vbUpsUFdsMGRwTTBjcGJMY3Mz?=
 =?utf-8?B?VlFtelovNmRja3gwZFUxdGhPRzJnaWN6cG1VU0o1ZDdHY3NhSG9vK0NXelJp?=
 =?utf-8?B?UVhONFRGWXp2d2lieE1YSG91enI0MnNOUXgrMys3VmpJYXlUOG13cyt3S0Ft?=
 =?utf-8?B?eGNoWm9INXpmWXZxUThIc0lVU1R1MVNadmZDU0dTSHhsa3RRNzlzVmtTZ290?=
 =?utf-8?B?S1VBZWo1MlpseWJ2endzRWZaNThKaVN6ZXc3ZDNKRXIvTGl3dm9mUmV3OHRi?=
 =?utf-8?B?dXJaT3pKT1pXa2hFdVB4SGZESldNSVJXUno2SnhHTzN1UzhVV3Y2QjBnTjdT?=
 =?utf-8?B?aU5EbWtDVlRScjUzSzBzeVZYbGl3VUk5dElMWnU4ZDJ2OEdPNmxoSC9UWExx?=
 =?utf-8?B?MUVneUpvRFNvUkJkTFRNZHN2dmJ1OVJUcGlPTTRrMHgreXAzNG11MG9yaHp0?=
 =?utf-8?B?cm0wc1JJeHJRdExUSUowS3RiaXdTUkU2c25EZUJGZHdkdDRnV096eEs1S0hG?=
 =?utf-8?B?VFN3UVlTYlk3aXEzNW93ZCs1Mm12WHhrN0ZMa1h1MkRuU1NQRE5wMm9mbjVQ?=
 =?utf-8?B?RWZJRWtjanBJc3hhR3lubG1qMUFGeHpQOHpJMUt2NWRQY2JmMFZ2TlhFb0l4?=
 =?utf-8?B?OG1qZ0E4T21pN2hXUHU3WFVYc3dsNHd6OXFja2tGampvay95U1lOdlFRWDBC?=
 =?utf-8?B?emRWN1ROWVd5ZDE2TVhNOEtQN2s0cFNFM295NVN6bDBuYkFVYlo2UlRacFFy?=
 =?utf-8?B?QXJGRnBQaDh0Y1NOZDIvVnI4TUcremNNUld0T0pZTUtMT1M0SjBkMnl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCtVZ29LRjM4NEpMZmRhUlJCN1F4K25vdnM4Y1ZpZEozSVJJZXM2ampyY1pV?=
 =?utf-8?B?RVJPVzB6OTU0dlRLYWw0aG03NXRUcTJTK3RPa2RtMHM2RDNDN05WRUJqWC9I?=
 =?utf-8?B?MWJnK1hFS3ZvNHFmalZoS2tIZVVBMDFsaDI4eXZDVzRUUDZLd290ZnE0ZmNW?=
 =?utf-8?B?V3BPRUloTEozWmxOZUNzaVB0bDVZNTFZaFRIaFo3WU1LRDI4ZU9ESnRTcWtk?=
 =?utf-8?B?MnR4SXdhcmkxSHBGMkxYK21JOFFRQ2FpdldYUUFZSmF6UW1WL2pnb2lmZU42?=
 =?utf-8?B?RWdDSXpJa2FGOXltdGtCaWhxMnFLZmJmWXZ5TFF6WldSd1Z5bmZ2elNlOVA5?=
 =?utf-8?B?OWhQMFRkWGtXamhxRXdxcHI5ZndQZG5MeUZJMUwxOUNvZVBMTU5XSmU3aDZY?=
 =?utf-8?B?ZXNWT21ybXE4SkhrTjJlYXllSnVieUVRKzNsYU96bXEzRVIzbllGUHFuQ0k0?=
 =?utf-8?B?bUtyWlZvMjZsRmdQK245alU3bExTWG92bkdpRzYxeHFENG56d09MaVduRjJN?=
 =?utf-8?B?cllSL1BBaGk5a2N5eXE4blNrSXB3WFhHSXRNSzBCckFoMG9TbUpCNzB1Ny9H?=
 =?utf-8?B?SGd3ZlZWN1JoWC9CRVFEU3V0NTRPYkVNVC92NW80UnhuUkR3TE15YzZ4dXcx?=
 =?utf-8?B?Q3U2SVFTc2tkTGt5TEhYS1JDU3pXeHYrVDQ5WjkxVFF0QVA1aHpnMndOdmdq?=
 =?utf-8?B?Vm03dDAwNU9TNHBHNU1jRmVQZkFjQlprNEpSVXBPNy96WE5zQ2YrK0JyTXdC?=
 =?utf-8?B?UkVKMlRUK3ZDOEtzL1prcC96TjFtZGxzYm5WUTZkWUZRNXVmYW80UkVZV0Ex?=
 =?utf-8?B?VFdQK2h2RU9qMm5JTE9IWG82MFRIRXJUaDlibGFGZ3RHMWg2RFZiSXd4akdS?=
 =?utf-8?B?dEg4Z0g1MThDQ21hNmdyODMxclZQb3pUQittdlVVc0NCMHRSanZwRFhsVTQr?=
 =?utf-8?B?anZjQmlrMElNanpDZXJLLzNFRXZsT1NES0tnWmx1UUFMb3ByVHEzRExvc29a?=
 =?utf-8?B?Q2JxcU9VYzFac2ZhWEhZb0ExT3UzSGZJNnhLRW4zTTZvZ1E0dzRVYmFCOEIz?=
 =?utf-8?B?eDVFbzdYRjBKeGlDaWxFZHBMeEN3TnFTQ3c5ck1KVFdId09IRUNSTnhscnY1?=
 =?utf-8?B?TDBobUFydzhGcFZWUytiKzlyN2dhNDk5dHo2dU9HTW56VzZkY2t0cGw5QzU4?=
 =?utf-8?B?QUFmckNSZU1oQXlnWnBoUTRleWVweFRySnF2SWJvQ3AyWW1Hc3RaQXlCWEYv?=
 =?utf-8?B?eW1aTm5mWkJmWmcxRjF0S2dhUGVWQ2VSMy83ZnppVTVTTXVRWnNNdVZKSFB4?=
 =?utf-8?B?Z2ttOXUzSUsyL3hCNmE0OHJqSUNKSDZHNE00TlJSU29ScG1lK1BYQk1vR1E4?=
 =?utf-8?B?L3pkb3NlTWx0SEV0QWFYQ2IwTHVoUEQzam56MGRBeXppYWlJejcwRHZzdG95?=
 =?utf-8?B?Z2xuT1dBbE10cEVWR0Z2TEpYaEk2dHNOM3VSWTM1c21NN0VxUG1ndHNXUDUx?=
 =?utf-8?B?dUY2MEMwNlQ5SWxjdWtVeGJTV1Vhbm5HazdlOHJIeDA3cXZGUkFPUUwwZmk3?=
 =?utf-8?B?QVZsZTdBdVJKVTF2NElmbmhseWRKUmNMN1F2NzUySTdoMTNsMmcxQ010Y1BN?=
 =?utf-8?B?MDBXMThZZVdHNEsrQiszekE1TFcrQ1JzRGJIUHptNHhBc0c5OGN2T0pmQ3Mv?=
 =?utf-8?B?YjN0UzFxaG93dG1JNUFyUk41U0R5OEhMaldjaThWT0ltbXJXc2NESW85WTVN?=
 =?utf-8?B?dDhlRzZRVGRTL0RrdUlwalM1cGtkNGFkS2xPUVViUERKZERDRGlsWXR5S1Qr?=
 =?utf-8?B?b0JEWXFlZ0ttbitwVkVRMkFvY2FSQnZtTVM5VmtRVU9OamNod2c1QzRsZVNB?=
 =?utf-8?B?MkNGVCtHSnZwb1NqaEcxYXRvUnArM3l2Y0pkcnF0WldJajRVdXlWNFlna1Jh?=
 =?utf-8?B?MWtneFNHcFpmR09MWkp2Q1BSdTBxWHBFNW1jRTFpanMwQXEwSmFtUitRcmZ0?=
 =?utf-8?B?K0p0aUVtR2VsQ1B3Zy9TaDkzVS9rL2pxb08rWGM3WVU2bjg4SXRQUWRPVmYz?=
 =?utf-8?B?WE9vR25QZVJtTjYrYytoc1pVT3YvdzJDcEtBSUZUZEhDK1BoaU9saDk1ZjlI?=
 =?utf-8?Q?jjgO7kSRJAvXBYJlWnRCBlTZm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f7ed5f-6dc5-4279-ae52-08dc6f76ab5a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:51:05.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tOiRCxWeA4Z1F9+L2uiXCHm+8y7fMLiEgNiOkdcn1uwdqlDw7zagZHs36aDqJEq8inDjInrO/E2TFtSQVn00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821

On 5/6/24 11:46 AM, John Allen wrote:
> Implement non-power-of-two denormalization for Data Fabric 4.5 in the
> AMD address translation library.
> 
> Tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> Base commit:
> bd17b7c34fadef645becde1245b9394f69f31702
> (origin/edac-amd-atl)
> 
> v2:
>   - Fix compilation error.
>   - Make remove_base_and_hole the inverse of add_base_and_hole.
>   - Move all map validation checks to validate_address_map at the
>     beginning of translation
> v3:
>   - Fix bug where the legacy hole was not getting removed properly.
>   - Minor rework of functions for matching the normalized address and
>     logical cs fabric id.
> v4:
>   - Merge common cases in map validation function.
>   - Fix map validation for cases that don't have explicit checks.
> 
> John Allen (4):
>   RAS/AMD/ATL: Read DRAM hole base early
>   RAS/AMD/ATL: Expand helpers for adding and removing base and hole
>   RAS/AMD/ATL: Validate address map when information is gathered
>   RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
> 
>  drivers/ras/amd/atl/core.c        |  48 +--
>  drivers/ras/amd/atl/dehash.c      |  43 ---
>  drivers/ras/amd/atl/denormalize.c | 523 ++++++++++++++++++++++++++++++
>  drivers/ras/amd/atl/internal.h    |  45 +++
>  drivers/ras/amd/atl/map.c         |  97 ++++++
>  drivers/ras/amd/atl/system.c      |  21 ++
>  6 files changed, 711 insertions(+), 66 deletions(-)
>

This set looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

