Return-Path: <linux-edac+bounces-1959-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63298E0F3
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA85C1F2353D
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B21D0BAE;
	Wed,  2 Oct 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lhwb1CGJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B31CFEA3;
	Wed,  2 Oct 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886924; cv=fail; b=N9m3Xy+YZz38k3YGkE3VIyyw3xIzPXddfoSkrJPABM0ah1kvcwTk8AY9OTx6tSzfmO7m0sypwoIzERY8cChZX2tBhCdYrx8GrdBzChOvgr4xtnuq7PzadJM4xqC1YIztSnLtYXfDBfzjPYSF+ATOVq79oWkslmVSbd6hMvVKld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886924; c=relaxed/simple;
	bh=saIwAPf6j/40I9a6x7db5svLfSbsWOZE/UYDvYdIHKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6B4cj5zbEDkbln2IUC0ZYZ/j803BRUP/IMHXO/anji5iuCWwn84KdqG+2YGyL3TC1acehuADZzNbyjlA8h8/GpvlUxbZI28wqU4TYHBptdnan/AP+gEpoRYzedJBAF4qVrNx5EvnxPGBX0YFWo4WDVGvkjGgtJzokcHK73YUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lhwb1CGJ; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDxOjxGn4+lhGmuUB1l/BfBy8py27/uxPCaCEgxALtqqLhWZ+S5BN63lkhOCkSGiuYihkKmguYUEe/Iwhfv8sza/sHJQ7pdpJb1xt0XWX0w4pKjc4FHmb89Ed18ISPNwfmyMSAp45MxaikG+7mjaDNT5+TA9H/9V6Ip1C/DBOOSe25WcW71ATxVEwtamVg7xD0ubaXIDGbZhD+9fQgwBgau3tTfYPrNumdXFRz8oFrsVGIPn7Exd6PbBEpZIrIlYcAd1yyGwzGYLbfeJi1RP0S03WZcEj49mvn/yyTZX9Lp9lJQLpqha0LBd4K561R1iOcjIxOc4wBZM1QDS8SLOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atl8pZhb1k6vrgfuaTPwTd+YR0wir6GpqewyhHD5SgQ=;
 b=idD3yPineBsninwNeqUtYpMuQi7UKwa4NYaolHQMp2iJopdPDYY5TRbnrFZLoqBFLwNgWyhSMW7wmgbG6A7Abr0fwULR7+8+QFlnqMm5VIRKCRprNAASaU5gOHKWaDHLTD4LEBO94sm2HMoTRZSlNBh4mbGjyBbhLG8Pj2SvVzs1hQ403a29v/kpiyBEDh6FDLbd4+KoWyx/uoSffzIiskjRHP4kCMnEozS3XbroCUq5c6VwU+mj7iYS7JnwqGIHfL4eySOMMExm+syekOmnoHZY8lzyxSjbCemzgYAs20Z7aAWPZh3MoTMpIszdkOSndES7Eq/LMrF2eEK11DcTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atl8pZhb1k6vrgfuaTPwTd+YR0wir6GpqewyhHD5SgQ=;
 b=lhwb1CGJfYYnitDnMaAcOV2uIUiD5Ny0X7lGxRgIE4jBX/Srg/Hoa0AXtT/kL121egbKdXc4mmgEau+A6wiccYEF3rSURY6ZG3tJ6uEC4Q2XJvYrT9D+BzcZ42CmcqWHvKTRswjDUDyAerQEynPeuBRLUVrEjD3QP2dkEnZyXUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Wed, 2 Oct
 2024 16:35:20 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 16:35:19 +0000
Message-ID: <bb69e3a6-6cbe-4e94-936d-5ad0e5b19f19@amd.com>
Date: Wed, 2 Oct 2024 11:35:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] tracing: Add __print_dynamic_array() helper
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
 rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com
References: <20241001181617.604573-1-avadhut.naik@amd.com>
 <20241001181617.604573-3-avadhut.naik@amd.com>
 <20241002110641.3575c632@gandalf.local.home>
 <20241002122903.24e591bd@gandalf.local.home>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241002122903.24e591bd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:805:66::44) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 391e09a0-bf62-4b51-8807-08dce30033f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnFxT0NvNWpQcWpJL2o0L1MvZTlEZHBwMUpmNkh5eXFMSk5OdWRMc0k4NnZW?=
 =?utf-8?B?UWhRTmFjNkRWeFNrcE1PUCt2M1BzaDdnTXN2K09VcXozcFMwS2ZMVndKa0FU?=
 =?utf-8?B?R0UxeG8yazFPM2lTY0J0YStueDUvZGR3OVlsTHNUMmVEa0NpbWxqUHp1TCs5?=
 =?utf-8?B?eTFhaWtYUjIzY1dUZC9Na00wbElxSFE4aDVDRUEvOFh0WUY1dG1yQXlIUFAx?=
 =?utf-8?B?MUpEcld4NisxTjg3T0RLS1BsalB6QjZiOFpPSVdDKzZudVdrcEh2NU5Ccmt4?=
 =?utf-8?B?NExPbGtZcDhEWEZzVk1qc3ZDYXBTZmwyQnppcFFIeUhDWW9YejNVZzMvQ1Jj?=
 =?utf-8?B?ck05OTdocDlGMUpEcE5MaXNxY2dERS94V0hOVWh1ZWR1dFVobXZNckgzdkhp?=
 =?utf-8?B?d0krSHgycGRsRDdIczVFSUtZK2hoV1NTT3VlWGpsejc4a3pGNkdjYmlSeE1T?=
 =?utf-8?B?MzcwSUJsNzJtZkx0MWtCWXVWMVcweElqaFBuUWcxRzdsQW1KT0JFL1Aza0ti?=
 =?utf-8?B?WEtVcm9qTmxNamxsc1JtWGpUMlByZFNuVWdIdlRqUWl6MjIxV1l1YVFnMUxP?=
 =?utf-8?B?UmxHVC9mSHdBWTgreHZHK2djVDR4THdWbFoxbkZmZU0rYVAyQ2VVNkVBWEhh?=
 =?utf-8?B?QUhPZmRPd2hEWldoTExDN1BuYUx4TlhFM2diRnU5ZXF0ZllYRHlYVlc1VkJD?=
 =?utf-8?B?UXQyRmp3allvSUVvUEFWRnVFUzRjYVZ1N3dwRVlwdWQzNXQvOC8yZlNuVmJW?=
 =?utf-8?B?b1hscmw2dGxkNmZqOTFCVFNFRkpJODZFTnl1YXBlalM0aHlvWU5VeGNxUjFB?=
 =?utf-8?B?N3IwQmtMMEtaRDl6d0RGbjNlTDJzekVHOWZKd2xrRHlmTkNKOElZTWFpRVF3?=
 =?utf-8?B?WkhvK1J6RUNQMGw2T0QxUXB5V3EzbURxSG1zRVBNTGlOZGRrUkF4ZExOYnBX?=
 =?utf-8?B?NlVSM0pqeFhkd1hwbkxXVGxNS1pSM243RUVqSXBUbWtFTWlRbzROY3lJRVVY?=
 =?utf-8?B?UUIrRVJLNHNHTjVyV0ZwWWhKRlFjeWlFZVJja0dtWkRWSmVybDJnR1hLOU50?=
 =?utf-8?B?N0hHTVBQTzVaMWdiNFBhc0lGZEVyaHdHRURpY0dzVGpCdmVBWjkzSmpkWDdF?=
 =?utf-8?B?ZjhwUEJyTUI1bENLbHEzc0hqVFJ2R3hJVitPWWg1eEx4akdiejhxT2NrSERa?=
 =?utf-8?B?VU5iYlV6d2FDVTlLRkJwcWlXYWd5SE1EVmdYN1RPRzJReVQ0SEFBMVIvckdE?=
 =?utf-8?B?ZlluS0djM003Q2xSeW9TalpKc05pQjF1WnFHcVErMzJKKzR0QXFJNFVZK0VD?=
 =?utf-8?B?ajAxcC9oZE02VjUrRjB5MUxVZjNhMUZFRXVxMkZBSHlGVXY5TGJ1SGd0UWo3?=
 =?utf-8?B?VVZ2L2VuWjdGdXRFcGJwTnNEbnJTNDBFYjNuTXQ0NkRiaEs2QlVRaHZ1T0hr?=
 =?utf-8?B?cFNmbHAxQWZUU1hlaVpZcjJIYkRhcG92SllmRVhCM2xRSmxsZzdKQnNGdkYv?=
 =?utf-8?B?UHRlaXByRC9UOHBRbjREemJFVWU2UnNFSUo0WU5sakpyZVM3dWZIaFdzR0Zh?=
 =?utf-8?B?Tlplbi92Mm1LaUlXY2Rxamt4ekt1OXNKZmo3RW8vUUM1YTIrQUh4bEQ0bTJz?=
 =?utf-8?B?MmZtYVNIYTQrUFhkTGJiMllxeUZyYXpGa3hkZUExTnMwSjQyNmxKSTBtRTRN?=
 =?utf-8?B?N2tKM3hxWVdjM244Y0QrNnQzeHR0d1p5MnBiYUx3UUd5V3dxeEpLSXFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1lXcW43ZFJnUG9kMHFUbUZFcEVzVnozSUI2MFhxdDJiU3lxUkFDZytCaUYx?=
 =?utf-8?B?ZDA1cWUrNHVVV3JmSHFJNS9nM2pKbExuWDZKenF2SG9RZ05sTVIxUk4rNjJh?=
 =?utf-8?B?RjZtMHdITmNEeGhISWRtSmxubnR0bG80N2V1U3Y2UHdYS0xBcXFoLzR4WVRx?=
 =?utf-8?B?ZEVLbCtGbGRrdmJxdFhjYTI4QWFmdFVWeDhLMU5keUg5OW16SWdLMmFvb21s?=
 =?utf-8?B?KzNvQnl1Zk9mekNycjd1cEcwdWllaU1yanJEbGJ4bXkza01iMjNJOFdadmRp?=
 =?utf-8?B?WkFQdXFRdGxlbTFUM04zL0NvVUNnTDJWb3J5RGxsc05hUUQ0c3BIejBXQi9S?=
 =?utf-8?B?aCtleXcrSlZwajhMTUxrWnpUdHE3ZTJEREg0bElsOE9MYkROdVN2QXhzMURI?=
 =?utf-8?B?UWIrSG9RV21xTXVyRklMY2lwdlkzRWdvS1RMVTFLN0NlVzdUYWZjMUxveEFQ?=
 =?utf-8?B?amNWV2tjMTdJaSttZktSdUl6U1RRRVJvRVV4cGlYRERPQTd0MFpVUThqL1Vn?=
 =?utf-8?B?NmVhZmZsSFUxbXZZR1FReEZyOUdBUHl1Y2Ntc25tcWJETDNCL0hLWllEM2FX?=
 =?utf-8?B?UHk0eTR3d0hsRzdRcjFGMVlON1QrMjIxRmFENjJXeElKVWRGZ1FKRXFTaDRo?=
 =?utf-8?B?ZVRDN0s0dUlhYjZQL21SbTNWWm9DUUZOaml0WW91b2NRbE9GN2lxSU9nVnR6?=
 =?utf-8?B?ek00ekJEbHU5NU1JTjNTNmxBLzN1TXk3RnFLWERnNXdoL0VKbHZsNmRBdzY1?=
 =?utf-8?B?Rkk0Ris0Ny9qVUtoYlJST1lLQW9yTXRSanl5bHV0RW5OKzNnNURyVW9SNTdI?=
 =?utf-8?B?SWk5Yno5Um1KcURLb0R4NVdhODIrN2xvbE1IVXpPaWZHM1U5Mk1xZFhaR0pP?=
 =?utf-8?B?SFREVDIra0dnMDNFQUZNUFpoT3ZYUytsSFVkUzBZZXhvMzQyTGp3MDJXMkRo?=
 =?utf-8?B?VHU1dTFoclFKaDdrTVBiZzhaT25udG1wdkZ2Tng5MzF2bGk3aGQ0NE9vVWNR?=
 =?utf-8?B?N05nKzFWZHVna0tBbGw1VURGWHJnUVZTbVNHanI0cVhEVEdFbm9xZThLOThS?=
 =?utf-8?B?QitnSWNIcjl5emxjRXIrbUJnemdoOERtNW5LamRqOC9xVEJxK2ZxTzA4cjl0?=
 =?utf-8?B?RlFrQTZmZjJ3Zmc0VTMvV2xTSTd4bmNjQW04YVhHYStEaTRDUVVmVnpPaUU0?=
 =?utf-8?B?WTBiUzBTZTluMUloSzg0ZksvSUdJdHpURTZwTkQvTklqVncrQUR0VXhZYmFm?=
 =?utf-8?B?UDBOOFMxWG5zRjBtZlBnd0tKWkxuZjBjQTRIZGRYenFibE9uQmZXNk1malN3?=
 =?utf-8?B?Y2V3OFlFY1RHTmJpdVBHY0hzR1dDeXc3dTluZDBFOTRaV3c0MXJzOC9MR0Rs?=
 =?utf-8?B?TUlQa0JCbGtKeGNmeDNkdTJkdUZoazlBWEtZUXlpZ0RzM3lTRTRwOVQrQWxY?=
 =?utf-8?B?STFpdjh6a1FjbWJyS1FvR0szRzBuQ1RGemlweEFiNm5HdkdhNzVrV0ZIOXVX?=
 =?utf-8?B?QUxHdGxiL2dUT1dnVC9lQXlZYzFxVDNROXFHekthZ2NUNzJVcFJxMldSTlRU?=
 =?utf-8?B?NlAwZ3M2S1ptZExFR3A5cHpzdUZ6OHNoOEk3bDVIa29GYXRMeUVsYi8rZFJw?=
 =?utf-8?B?UXA4NngrR1BmSUdBZU53VzRoaUtTWnhJTkQreWlBZHRzQ0E0MlZ3V3N6d2Jh?=
 =?utf-8?B?Sk5TVHYzR0Y0aVpOV1prV2h0ZkI1aUtnVko4b3krL0hOMEQ5clF0RkZrK21O?=
 =?utf-8?B?NFNRK0gyenRVR2p3SUtKMHhGdEZwaEM4cnczcWRHQ3dyNCs2c0tCT2pMNFk2?=
 =?utf-8?B?SzhueDVtM3lOZHk4Vk1lS0xlT21Ha1dZejlhOGU5MmdUeldraWd0UFBtNkFW?=
 =?utf-8?B?cXJYaWN0bmJjZkZiK2FENW4zNzNuaE5lbjd1UUpxNHR5Zit6Tmp4Vi9FM0s0?=
 =?utf-8?B?Zlg5SGVnSUIrSThUVElIelhkbHVuVW5GQWNHcld5V3pWWUZmMzcrSDhiMDRq?=
 =?utf-8?B?T2tKYmVSbHhJRzNvL3NOTkMrbmZreU55WkRmZndzZSs1SktqRzk5L3JBVmp0?=
 =?utf-8?B?N2k2elFWVko3ZS82RnN2cXc3cWhSRE5vbHl2anpHK0wvMUl6NjBsVG01K05w?=
 =?utf-8?Q?hNG7J7ukpIoruUVX901UDOFvi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391e09a0-bf62-4b51-8807-08dce30033f0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 16:35:19.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrJVZfDe07mUN+ogZz/O20mTXWdrX+tdWWeG7aGHP2v8tqYTqtci1kc0lIKAqdKQds+diH0mPGAeQE29uw6fXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960



On 10/2/2024 11:29, Steven Rostedt wrote:
> On Wed, 2 Oct 2024 11:06:41 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> I'm currently adding code where I need this patch too ;-)
>>
>> I can make a branch that only has this patch based off of v6.12-rc1 where
>> we can both use it. Can we do that?
> 
> I take this back. I'm doing something a little different (updating ftrace
> specific events, which has their own macros).
> 
> Feel free to keep using it and pulling it into your tree.
> 
Okay, thanks!
> -- Steve

-- 
Thanks,
Avadhut Naik

