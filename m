Return-Path: <linux-edac+bounces-4788-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084EFB51D17
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 18:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AAA7A1D29
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392A3375C0;
	Wed, 10 Sep 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDnAgHjT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC91335BBF;
	Wed, 10 Sep 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520544; cv=fail; b=JrqYRm1lwS3mOAcHn7cjUTPsrnYhCir1ejkY5MAXHGnAUX4Hu9GblGdzNjmS+oyhg7vPNVlfTOKQ3ceE04NKzGSXEJqri2SmORuhoxctQw93Isw6f6C8uG6urUL/jO24wE2S9XXOmon6kgr+u0E9vM4fjgBeRx5HM2QLMyV4ZSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520544; c=relaxed/simple;
	bh=2UEwwM95cPxpA3L/ImZyOg0+aZRyp5YCuPnFUAtXPNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kh9xMzgQdggQ8czZSoylVMrhamXaITSWWhc7jQRLyj5HJ+t9gdik4dwE7yhqRZPe0S7Voci5LSWU7bMBqjw2Y0ybL/NRcVcGP810vpln3MvJahpF2HdVdqdZG3fJq0LGIeLlyRom4j/Jz+mPnmVUP1M7yFOOfWZ4hwGTOWzdGZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDnAgHjT; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAXAAdXhdBiSUbHLWkEtGHOXwlpkwp49Gsm3AVUX2ObX+vX3WgCzcrufFLJ1zw7LZ/gy2imj8i8FdoBBI/0m0AROQkIIgn89eIEgS/dB+jm7J1bQSn5L7LWTijoc6d/N/Y4SP2BPng5RgZmtHVXr973BT8tp4HwDzMTosueG66PRZsm2o96Cqtcmh0EqTebmuaLoDSNXpBMkmzpzwzF9ydae+V26IByn/LcTCf4u8fCWweD8FxlZTxIPwl4gG7cFKIwJtjn3/hL1Bxi7f4a7x7X7FKiWljXGwwEGXesQuI2v+1Y9hQH6ZJ1ZC52bP8OqtoCSAvc9YOBXpvPpR4tziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miugUqjMVhaJ12GC3HEpXS597xLOb1AuSS0qamL3dyo=;
 b=QPyUIYZKshAva2uhRjhOUyCpRLSn2YcIIXQujh9AtAhfG6CXn5sq1SrZTvCKUiKyLrWN9gj5YjLKn64E5l0CUHFxa0Fb67xgtonarSR03E8lQhAEhJhh7xZUYaiRu6FbHoF3oO3+dhoXMrc4ej8VITt2IAzvNrsT3V5FJKOOJce/Y5Z9ii49lzBRRFHAS16fB1fyQiqtstkwitYErpPRdKNUaFfRQHl4BWcGmTpNNDRYYtAnI8FErNpfCSRuff1NU05jJDkGSks8IXqAhlMLZFg5IW8Qp93jj33//4ZgnNOVB1FQzKgJROqJ7/JqkjdfkGbz34M1vklvcpR0VRUT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miugUqjMVhaJ12GC3HEpXS597xLOb1AuSS0qamL3dyo=;
 b=PDnAgHjT9+38YNtKPBT5f9qVyz+mAQAxsJyF9deGZz18D2tKh8FfeTBuID3ADMfuSZ2Y/H+JWADK5hQcPc9zbGZPCGalo5B+FBqN8l5QfPD9tqD3EF5G5oM0a1UuXMJ7gzunz8maLi/AM9YXC/S2GHGxIKKtsqxc1zE9YmmKFOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:09:00 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:08:59 +0000
Message-ID: <d1f2e31c-1656-4b51-b52e-43404cfedb65@amd.com>
Date: Wed, 10 Sep 2025 11:08:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] EDAC/amd64: Add support for AMD family 1Ah-based
 newer models
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-4-avadhut.naik@amd.com>
 <20250910151333.GF11602@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250910151333.GF11602@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: d0482cb7-3460-4661-b4f4-08ddf0845a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTdLK20wQUx3a2Nma096Y3g0MjdLMHRwbmRPZ3VuYVhpZ1EvKzZYbTd0WkZi?=
 =?utf-8?B?bzl4Ui9NQ3o4c01xc3ozWk1GNXpEMlhkajJSSkt4ZUR5S09KU2dndTl4NFV3?=
 =?utf-8?B?ZkVuZEZTVEhtazRtM3I1WGMrcEgvMGpmRFlFM1B2cDB1ekVwektTOVdWOXVa?=
 =?utf-8?B?cHg3VjZiSGdGU3c0SDYvbGtjdGRmeTRYeWFQS2c1WnBvOGFHU0x6MUsxajNB?=
 =?utf-8?B?MWZ3T1dVbzZucHg5R3lSRHZpdlFVNjVqbkw0cEhXMEh3UVl2aFhCOFVTeEVo?=
 =?utf-8?B?cVFaR0xHa0w0VVp0RFk2ckZ5TjhPbWhTWXBodVVyQW5EVEhQSk5EalpsOXVO?=
 =?utf-8?B?QVZocWgrb2pwM2gvRWYzQ1YvVm5xNzhPSnplSHk2c1NPWVM1Q2pKNS9qLzdC?=
 =?utf-8?B?eWNTV1lYMzBDMVg4YkhpZmJWSzNNcmcveXpCS2t4bEdFNE1vdHpNR0lkTHFK?=
 =?utf-8?B?QW1MQy9VU2tqbVUyd1NNYkpnblljdnorcXE1UENoT1IyUWxjbm40UE1ydFFI?=
 =?utf-8?B?Sjlqd1hoN3FwQUJKOS9zY0M5WUZvYmVWSjBpZ0w3YnI5azlZaDJaY2hDaHRr?=
 =?utf-8?B?aFFpVk54L3JLemhQSjVGYndOOEZ5b0dvcEZ0b1poM051aGVjcy83WGR4ZHdJ?=
 =?utf-8?B?aFFUSjFNYUR1N0FDREtnQmZIcUpSK2VZWUJ3THkyd1MwdkNMaEd1SUM2djdk?=
 =?utf-8?B?MmdhcmlQcGdDUHBRREVMY3kvbWpXbk9Say9uaEVDa1VyWmFFZ01lcWg2Uldh?=
 =?utf-8?B?YlB3TEVDa09Oa0hUcGtPakRtVWtha3pkeEJaOTYrUGNoakU3RGppdnpWT3JH?=
 =?utf-8?B?WmFzb3M1bk5aZ0g0ajlyckg4c1p0THNyWVNwNHVLRDBwUG5PSWM5VW5sRzYy?=
 =?utf-8?B?V0lsTGE5TVpBdVhlM1NEbkx2Z2lTVHBZWVViZFNoU2NRYWJOOGo5N2FPVWRr?=
 =?utf-8?B?QWY1OGRQYTFzT3hvaURSb1Y0V2dramlHMXhIT1pMbE9VK2NoNC9iVzRONVJz?=
 =?utf-8?B?UFo4ZVhpS0dxME1TUXJndlBVS3cxK3V0T3B6VkVXT0E5RU1Kdjk2K3NmbW9H?=
 =?utf-8?B?Q1QwWXJGK3B4dklvTGF5akpmU0ZoNTk1b091YUpZblo3cmpLLy9vWjVqcEhk?=
 =?utf-8?B?Zm1NOVB5R3BBdUNHTk1ZaDhXMXlSMGx0TlFZK2hQd2M1ZC9RcWZJRVFhN29t?=
 =?utf-8?B?Yit5OWR0bTBOSVJRZkJjRFJobjFCc1grR3BaYmtadGxvdktaTHFFTWMxcW9q?=
 =?utf-8?B?WktsejU0NGxxYThYVkluTnBUcmd0eVZ6Z3dNRVVNU3BpeDI4TzltRVZnMEtO?=
 =?utf-8?B?SENUN2tTaFFadlArUENWaSttRmhNQWphWEFIcGZidWZYeXphNVlqLzBGbkdp?=
 =?utf-8?B?K1hnN2kyU2szMVZ3QmN2c0JRNHRDY2NIMUdidVhHRTZJdHprQ2cveDJFL3dP?=
 =?utf-8?B?L3dCTmRITEdxczRiUzJ5YjRJT2x0dGxiWEEreWRCR1huYjdSVzF2TTFaaGtW?=
 =?utf-8?B?Vzhmb0RLaU9wMmFldzVvV0xDc0VKZnJGSHN0Q3BCNHNUWUVRTnB5djV3VmFo?=
 =?utf-8?B?Rlp4ckx1TWs5QkpxL3hjdkdZdlk0R3E5SDJtWGVFdHBsWGRNcFl3d3dyT0Zq?=
 =?utf-8?B?bUhVUnBac21Jam9zdFhHWjdtZXVGdzA5TzNRbTM4NmIrMXRGZjUzbXI1VkVs?=
 =?utf-8?B?Rko2dllzWkxOanJOTFlCZkJsWXErNzR0am5VSVFGM3Zkcm56WXd5aFBiWlgx?=
 =?utf-8?B?Z3R5ZEo2aG5tWnJ3YmNheS9meUwwUTlEcmtwbUNSTnNYd2NELzd4bE92Qmtn?=
 =?utf-8?B?SzN4WDBzbjZzUU90M1ptc1Y0SEZsNktPbFBTeUJ3UVdrWkVDbjZucTFVS0dE?=
 =?utf-8?B?Sm1XUWpzSm1TS3pmYUtXS3RiTjhEcE1xUEMrM0ZHTmxaU3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC9RdFVUQ3pkQjgxY00vdTBOajRmalFTZFVhSGE5ZDNIRWo3UUpPTFZwMHo0?=
 =?utf-8?B?aWYrSVZQMTdmUzdobDlWaElHTmxhWU9yN0hyNi9WbTNnVjExUndXZ3pJdTJ6?=
 =?utf-8?B?V1k1cGozWUFzK2F6U3krb1lpY3dkSS90dXBuK01QU3BOOElYb29VdGtrS20y?=
 =?utf-8?B?ZlJ0N0lRZEdpSzM0SDgzK3dBQUNtenNRREVwRnUvOHduRnlNL3Z4SVBsL0Fs?=
 =?utf-8?B?dERPdlVWTHlnY1o5Rk1BN1R4WmFJd0NOZTlyZnhKb285TXlZT0Qza0hhSUVu?=
 =?utf-8?B?V1JMaWFYZlZRYTNIRWhzUWlwTTBuM284ai8wQnY2NWZuUFhmalUwK29RblFI?=
 =?utf-8?B?SFZNVFl4b0R5Q2xjREI3emJIbVRLejZOS1NjR1J6bi8zSHVJTmRyS1ZYQTlL?=
 =?utf-8?B?T2d1VWczQ1d5eFRJdXQ2RW8vekpLcU0vcVJWU0U0d2dwa0FWK2dEcVpxYjN6?=
 =?utf-8?B?ak9zcXVLb1ZwQjJraUFoZTVMYzZQVXlSdEw0a1JLWHcrajJiWElMS0JPNnBj?=
 =?utf-8?B?dFM5UGpUUVpqM3ZIY2Q2S21EbE9VdGlYT2dnS2NucjdEN0M2Nm92cHpmQkta?=
 =?utf-8?B?d2hpSFE1dG9qSGY0WGFJcDhBb0JQK2xpUWErQ25XQ1czb2JPRzdFMXd2L0xr?=
 =?utf-8?B?YVpaTGEyanpDL2ZOVHNYYXRVNEhHTXA3USt0dUVDWk5JL0RZanhKdmxkMklW?=
 =?utf-8?B?WXBsZkRzVFJxN0FsOGh3V1Mzd2NwRVVIUmxrNHRrWEFBZ2ZxVTQxSm5BdTMw?=
 =?utf-8?B?T1ZOUzdUU0xLc0QwRlBvUU1jQkRIVjJld3R6cUVVOUp0WWwrSktuNUUrZ1dR?=
 =?utf-8?B?RER0Q3EwMHdIZURLeUNTVjE5aVdtWGtMUGtlaS9BUmJXUWNNaFMrUCtxMWVl?=
 =?utf-8?B?dGRDUDFHUzAwaC9LWk9OSjdQYmd3cEhRM2M1dUN0cHhxdlZ3OE9JKzRaZHFp?=
 =?utf-8?B?OFlkYlo1OGlOd1ZhN3ZXdHNXUU5kclB5eE8vRUoxL21LNDRmOGljUVdxaFE0?=
 =?utf-8?B?emtGb3JoRVBwYWJQU01YWjVNMy9QRHRXMURZY3Nqai9ja2tVL0V4SzA5c1N6?=
 =?utf-8?B?Y1IweHg4WFFJNjFGMzZyOTdDQlcrVUJPcVVwMXBBVW5iaUVwTkNWNnZlR3Bu?=
 =?utf-8?B?d0RIOVJ6ays5R1pUZDlwQzdGSUovcCswYTNPMERhYm5zRmlaSDlXakVDY0Qw?=
 =?utf-8?B?bVFzT2kzcTZ1MnZrV0d0a0Rta20wVktHeFpITFFlVW55SjVUYVZkcHhlTmlt?=
 =?utf-8?B?YWNuWjVid3NjZmhRN1pCL3owYTREQmZvOEJpelIraEpKOGhjdjlmeERJb2Ix?=
 =?utf-8?B?UzlmTnpMWlBhYjlNRGNkT2RNTDFvMWdaeVE0ZDIwT1h4bUpmZlZuOUo1ZnV2?=
 =?utf-8?B?aTMwT0s1U1BxMFRuc1FaOTFxZkpOa082ZkJXQXVVYmJWLzZPMk9uS0MwM0tl?=
 =?utf-8?B?T3d0cjFYMk1FQk5XeTludWppNXVsQnk4RzhXLzJhUDVEVEliQlgwd1c4Zm9B?=
 =?utf-8?B?Y1RiOUZzUmZVV3Fia1Irb0Z3N3NwUzdVek42UHRhVFhuanJjZm9yMUFTWlNN?=
 =?utf-8?B?NExXN1VPMGlXUitFOVNtQVNaS0ZraEVCSEQ4QmZPVi82aDFPNGpmeGRpZmh0?=
 =?utf-8?B?ODEweEQvSkgxOWd5REplTWpqak5xM1JnOGxiTkFzeWdzZFh4My9ndkl6cWlx?=
 =?utf-8?B?VmEyT2Q3ejF5VitxYmZnZE1iOWRObWd2ZmNaa2Q5RzFicm5aTkNBZ3ZPMGRS?=
 =?utf-8?B?Qk9lQmk5U2JMaDYzelNTYy9UQlcyc2JsMjdqckNkdVUwZVhUNytuYVFoRFkv?=
 =?utf-8?B?cUJwdWFYaE1uYU9jajNXNGUvTjJIWlA2NjQwQlo4MzNrWHFrUDVIT2lDSmRF?=
 =?utf-8?B?L0F2WTNNOTBabVdNS3Q5L29pQk4rYlplb1FHSEd3V3l0Y215bk5zdFVvS0tG?=
 =?utf-8?B?SmI4OHhZS0ZKTVAyNlIyL0pWYlAzR3JmdnhYU1VoSWhSVWg1bUVob3J4YXlN?=
 =?utf-8?B?R3NoUDhha0tIalAyYk5mV1NPS0dUTTFsMW00aXQ0MFFRNXBvL3krOG1xMzJB?=
 =?utf-8?B?UGcyMzl2SmNka2RsbjIwbFhLQmFlUnkrd0VrRXE1aGZ2UlRLbVlwNGR4cjdt?=
 =?utf-8?Q?FOOKbO+vVNmfy64ovgHa7Ku8k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0482cb7-3460-4661-b4f4-08ddf0845a3c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:08:59.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUB1rhE7X8TV9goDfDGa8XBnqriPgtLhY43u/xMFezsI42UexLLGw9ZaQAMpUYzxVyQErFAvcy4zv/B+LjLKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478



On 9/10/2025 10:13, Yazen Ghannam wrote:
> On Tue, Sep 09, 2025 at 06:53:12PM +0000, Avadhut Naik wrote:
>> Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
>> C0h-C7h.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>> Changes in v2:
>> 1. Remove extra tabs
>>
>> Changes in v3:
>> 1. Since ctl_name string is now assigned at runtime, group similar models
>> together.
>> ---
>>  drivers/edac/amd64_edac.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 0fade110c3fb..804d3c4c3f14 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -3895,6 +3895,16 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  		case 0x40 ... 0x4f:
>>  			pvt->flags.zn_regs_v2   = 1;
>>  			break;
>> +		case 0x50 ... 0x57:
>> +		case 0xc0 ... 0xc7:
>> +			pvt->max_mcs            = 16;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>> +		case 0x90 ... 0x9f:
>> +		case 0xa0 ... 0xaf:
>> +			pvt->max_mcs            = 8;
>> +			pvt->flags.zn_regs_v2   = 1;
> 
> All of Family 1Ah uses 'zn_regs_v2', so this can go before the models
> cases.
> 
> The register changes happened in Family 19h, so there are a mix of
> models there.
> 
> We could be so bold to say 'zn_regs_v2 = (family >= 0x1A)' up top.
> 
> Family 19h would not set this, but then the individual model cases can
> fix it up.
> 
Okay. Will set zn_regs_v2 at the top of per_family_init() for Family 1Ah.
Will remove its existing usage too.
Will make this a separate patch.

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


