Return-Path: <linux-edac+bounces-4457-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76B4B13D66
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 16:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BFF7A72F9
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BD263F5F;
	Mon, 28 Jul 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tnyHbBdy"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4D16DEB1;
	Mon, 28 Jul 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713650; cv=fail; b=dJJhOWSR/zXm/n5Xc+bxR6yUTAe1IdEM31MhggC62SdI4RYdeojeaAsIJYq0ZQAD20G7vRdmbQRjLjr1mZeozweccwptMAAXfoqNnoeYuIupZaXdmix4nB/1K4Z9sNLdWSsSZShM7p53EWxKCBqpQU8xAMebHBjfNLLOS/iQvp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713650; c=relaxed/simple;
	bh=4eNhlFOXH36tgKsVYyLlGyi3iOsGCHXU6xoG5rGEU04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCyLa7PS3e0DlFgd9S7Ui2v2EO4jYI2aBa3MH3MLNxWdHmbBQFDa/cPMszV32y7eKH1gHO9llGo8jP7BsCfNIRveTYvO7ZTYEbK2352PEulHgTid99s6vq0GyA4B/qGYzZAL5LhJp4Io6utN7ftTqSI09RTOpuKRFf188L2fCKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tnyHbBdy; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a17MqSMwJQo0hSBrt7BE8u5Zmyrfuf5/yBRMRoMh3mReID1l5eL+m/iwdbM1NCCzOvurtA+yM+KPek+xC/ZJ7wCmXWwYO4+AYmDS9lou3TqSeoVJodHDipW9NmTeqKhP34SlnaMWX7/sMq1vv/wWvcblYzfDr/R1PaZVEGYULuRfRut8ZIPAGxr6y0L/c6ovq3sRM//Aof1DzkcfiPw/FuZpjPwQnnagzKNiJOnQ9HBmc1QMcEAtygYczaWlrjAH00C8KZ5SSd/eDC+6S4mZSV1dpvCa8DyUZ1gYR8KGwK9akMXw9PoJ0eE6PaagDMkUi1ilYNn8UgoLdQXKsQbB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3r/HCyvjYo0mQpHP07hSZGrlrR9OmjlWwzGa8Y4+TQ=;
 b=L+qyxvFbO9IqZs/fyht7SUmbzpfJ7Y2WFb+BqfysvIjzxXgIRuIVXE+2BHiaHVVPsS2BGTUM/SDZDX+0p3RDKL1mfocJIqbREfDxed36IDvfBM0MoIcGbpXDahT7yuBStMHc+iXMMU68E26llIlT31ny1jv7/E/oXTzDf+SiAd5tQ7GwnIWW5RtYeqRJmofBc7JEXIlPTc0l4ygfU2u9jamlDXnvEphq650QGOJreEdfR13R6XjcftVPvoPWdCErqfFL12rUqd+dSUHoNKNHJeZOBYTcdoys6Rc1/2Rs8ApWv9sMY1t+o1pl0bx4dMfIQszNVbVadW6H0bDGbd8q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3r/HCyvjYo0mQpHP07hSZGrlrR9OmjlWwzGa8Y4+TQ=;
 b=tnyHbBdybXCwrQQxULKlgaBuUyTHBSjCgHFM4v4q7KKKRFaaPBkBXo/Dc2Zua/DIOxaVQoIU9bvh7F76kIFIPtEnvhyQ58BkWCqizE+KhaUBZVxLP6d9sVABQ+ro1adxoJ9mQef9QXYuxbGn5+J3rEnK44ub3M4tL2/5lvCbr7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 14:40:45 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:40:45 +0000
Date: Mon, 28 Jul 2025 10:40:31 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, john.allen@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RAS/AMD/ATL: Translate UMC normalized address to
 DRAM address using PRM
Message-ID: <20250728144031.GA33292@yaz-khff2.amd.com>
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-2-avadhut.naik@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717165622.1162091-2-avadhut.naik@amd.com>
X-ClientProxiedBy: BN9PR03CA0978.namprd03.prod.outlook.com
 (2603:10b6:408:109::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: f11e8b8d-f325-4150-dc29-08ddcde4bc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzVuZmVLcjZBQ2pDaTVUUUdQTmZEaWxYMUgyVjY2MFFyUWJWeWVUNnBxZjNl?=
 =?utf-8?B?d0t3OE56NzY2a3hNby81Umc4bW8rVStzYUFuVFpISGtPTU1rWTQ5WFJrMXFF?=
 =?utf-8?B?ZGdwMkVZaENjeEd0blVOekZvTFZZYU0za21OVTkvU2ppOGxhaTlld1FOeVFT?=
 =?utf-8?B?NWNEZ09EajdMTWFRWnUrdjl3VmpqOHRxL2hWaEFkY3RhZzllRmFLVFowWWRa?=
 =?utf-8?B?dlV4NGgyeWp0Q2I0a1d5K0o5dEFleVdMczk2dGQwbUR6UWVVdTZNN1Fqc2My?=
 =?utf-8?B?SE5mbHFZTnRwRjR2ZVNBUjFZVDNBeEt5d25saVBXdStIcStSWUtDSDZ5T2Jr?=
 =?utf-8?B?MWt1STlGZjVHL2k3STRoaEppUys2cFd5VE5aUmJkbzhrL0FKaXk3WTFHQm9x?=
 =?utf-8?B?czVVY0dOeTBxRFhPM0cwWVlMTzlHREdSRFJYbU1OQmVVM2ppdEJvd0JCSHNo?=
 =?utf-8?B?VXpnZ1Z6d202ekN0ekFrTGVTSEFEdFBtaDNuMjJhRzA3ZjRsVERtNUR4bnpk?=
 =?utf-8?B?RGJjb3BKZTlEWDBlbmtQS3VFaFNNMC80UHU1MGtsNzlKY09Bd2VrdW56ZC9C?=
 =?utf-8?B?czljaG8yeGZ1SzM5cXd2U3RGSzBURkdiZytOQTZVNDJuZmtZTVVWejRBeTc2?=
 =?utf-8?B?N0pnbUtOTUVic3FFRXcrOGQvQjB6b09FTXFEZ0xwMmJzb3NjUWtZTkNadXUz?=
 =?utf-8?B?YzdtQVpoWGFwOG9iK1dHVEk1WXY3QUlHZXY5c3BiN1hnV3p1cVFieUpQakxJ?=
 =?utf-8?B?d1ZtbDZFL1k4ZWpPczNwc01TRDBxRi9PdVM3RjczOEpJVnpuQVJ1S1RkbTlU?=
 =?utf-8?B?MTQ3cDcvVHUxeXI1Q2RSd1hZNXViSkUwbnJuYXNaUy9YMVBUT1RPekZNQndF?=
 =?utf-8?B?eTlZSSthZzZLOU1iYzRGYTZCWmV3dkF1Uko5R3N5WE5yanRMRDhVMDVBVG1I?=
 =?utf-8?B?cWRsSGJKMXpWUjk1VVJNZUVPeEIzRFMwUXltdUR6ZmVKdkx5TDJrejgzRVhH?=
 =?utf-8?B?bjcvallsNmpKMVdNeUtqZlpYMkdzZElhU0hpYjRWczJETDFEZXR5MUc0L2Qx?=
 =?utf-8?B?Smt4UlgxTDc0U3BZUm5pa0xzTFRJS0dyeHdnV0NBMFJxNWdrS2ZBNTdrVkE4?=
 =?utf-8?B?a09NZ2Y5VkVWWW1aYW1IQzhSOVhHSU45TlpmSVFGUStMVFhGMElqWGwwdUhl?=
 =?utf-8?B?Nk5VazJXQVdjMkZJano5b3pBTUd5VUh0ckQ1a0E5dXJpTUhxSzUxYnZLdUpW?=
 =?utf-8?B?RUpVS2dYbi9hU3dBMXo2bi9lelZ2TW90aE1ibzhDakwyVW5SVHYzL0diU1FT?=
 =?utf-8?B?SjRHbnZWczcxdnFLNGVncHBBTEoweDgyVG1xdUtwNUoyaVdLN1pqaDlRV0VF?=
 =?utf-8?B?Wlg5NXRWRStmZkxYODFDVFQ0VW5SZlJqd3pYazV3YWdCeDFSVWlDWnZ5UlpM?=
 =?utf-8?B?eW1lQ3ZNZXBiclJWWnk1TktnVXl2c2dWbDFIdEZkMWJRSlhJNnMxcXFUR1Js?=
 =?utf-8?B?NU9TNmp6WnJrQ2JqZTlYbDh2TlNEck1vdU1DVy90c2t3dkpPV1l4aW43cTBO?=
 =?utf-8?B?VFFmZlF4dVJlb1JwSHkzRzNFOW1EeG45S3FTWit1WUhabVNkcFFRRkwvUGM4?=
 =?utf-8?B?TjdEMGwyYmdreWhZam42UHBIOXBUM2hRSWFJenAxT1VHVGdBZnRtRlk5S2hu?=
 =?utf-8?B?akoranpxaXgvVU9CU1E3eTMvOE84UVIvZ2NsSVh3dHVaUGs4SVBkV1g0Tlhu?=
 =?utf-8?B?akRUemlEMlp2VVpEOXQwL3RHdllvZzZZbEt6a3JMU0p3T3JUeVJwVjlMaUlC?=
 =?utf-8?B?b3NINjU5Q1RrTldNYVpYRmxzRGtGVnJDOEhhVFZNK3c1TVVmRjNCcnhoMnBF?=
 =?utf-8?B?SjliTXlkMUJOakdNTjNNcy9pNEFXQWxHTm9GWFhOOURwbXphbVhrVzZnZXlI?=
 =?utf-8?Q?++n5864JZkw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNrRno5WHh0RTlhb0tSc2grWnhSVTBzWUo1VE93akMxbjFIWkxtd1JDVHRa?=
 =?utf-8?B?c09XSnU2MkoxNUpxQUgyaTY3V3d2UjVJR3B2OHFsWDdhRjR6emQvZVRuREI5?=
 =?utf-8?B?cXdaMEV1M1MyZXFwNGI3d3JOdC9YdHZFZ1lxYlcrSzdwd1V4bUhpY3NOS016?=
 =?utf-8?B?YUhsQnBHcVBMZDJEUndaa0luc3ZMMmNpWTBGTURBVWk2WlVuV2NnTzJObkhI?=
 =?utf-8?B?RzNWRmYrUnlJVkRTRFY5TWs4c29WcDQ1eTBBeXByQUV5QjQ3cGJ0WE1QZ0Nt?=
 =?utf-8?B?R3Z4YzZWQjZVRnFQbU8wOEhXVUwzUTE0cEY1N21PcVJzcEZuYkpId0s2MEps?=
 =?utf-8?B?Zi9iTEpsQzJEUC9mV3VRNFBkdXlDUGFTRFJYYVowaHRCaXl1YkVpVWQrV3pI?=
 =?utf-8?B?czZGSXFmYThpLzNEV0RsTkFneE1BUVZtZEdmbkcxVURpMHlJNDlLMnJoT3Ra?=
 =?utf-8?B?azEvRW1Xazk1L2RvQjl1MGZkcENjQSsvRFdlb1NrTmhjdlVRdGlWMFh4SFZJ?=
 =?utf-8?B?V2hncWdqOGxVOTVxaytzTHhHQmFiNjZ2ZjB0YUtnK2Fjb0VvZ2RBU3drSCt4?=
 =?utf-8?B?b3JUeXUyNFNuVU9lT2JueWRZekx0UjB5cDlUUlcxVWJFdWQ3T1dQZGJXZVAw?=
 =?utf-8?B?R0xMMEg3SWdIUFJyZVpDNjdRbkpJQ0IrOFpqVlc1SWRaQ3o3ZlNhUFNBOEUr?=
 =?utf-8?B?cU5RWVluSk5icDBiL2VOUDNKcHA4RHNTYzZUNCtKQkVLN3NSbTBKYnRIZ2Zl?=
 =?utf-8?B?REZDZXA0dDhUTjB5bXRwd3NEaEF0T1RRSFdzN25KTzdXVFdhU0RWUGw5QkUw?=
 =?utf-8?B?UDgyRXNlZlF0OXhZaGZTbHR5NmJmZFFFSmFxOXc1ZW52OG1CTHNTdHpiUVVQ?=
 =?utf-8?B?MW4wMktGc0kxelFONjZlMVQ5dTFnV0Z6LysyMzBldEZDYVFydm1pdkROSnpu?=
 =?utf-8?B?MFdqRlc4TVJKblAyMGZXWm1ubUlvRWp1MjdQNmFJbEJYNW5mdGprckRaeFAz?=
 =?utf-8?B?TWk1OTFTSWVycHhvc0FCaFZNSE8xaVhFSU1JOE9jRnVlQ0NjMm5Qa2VJL21F?=
 =?utf-8?B?RG1jZUFJcHlLMXNoVVVteGE2dzREb2ZuLzh3anFnMGhyZEM4bzhJbkJpOWdv?=
 =?utf-8?B?c3VtRk94MXJLUFY2YlE5UTNwREtrcDdEU0M5WVB6eXhLSGZSbWlFdERVZjdi?=
 =?utf-8?B?cFFnWFZvK0dOSXVsMy9XYjhYZ0hXNnJvWUZQZ01mWEJ4Tm5yRlFpaU9KOU5H?=
 =?utf-8?B?S1FKdVk4M2dIZ2lwMlhtVTFNZThyd1lWUVBtUktsNzY0M2l5VUJnZ1FnMUda?=
 =?utf-8?B?dDg4MU1ES21WS0IvRjNSSUYwRE5KeHZFdzFsR0ExNUZiVzAzYUQxU2drZWZG?=
 =?utf-8?B?NzhJSEFJclJUQ1VKOENJRUZBVzV4Mm5lREJhT3h6VXMvUHpCdXpvYjFUMHlq?=
 =?utf-8?B?aDJsaXNVZXNTeU1qR2poSjNYb2pBN21aaS82MCtMVi9wQzNNQWpPM0VIc0ov?=
 =?utf-8?B?aDc0MkI0eElHQUk2U0txQ1VSQXZ0dHBHaHhySHBPU2EzaXFlT3ZCeU5WcDc2?=
 =?utf-8?B?TS81M0wyK2hXWDJuS3JLck9RSEdUeklJbkdETTZBM0VjZnNHYiszS1l4dDNF?=
 =?utf-8?B?K2RCVHVmUEdUOUt3RXJXSkcxNU1jOW5pT3dXZzFmS1BNNU9rRG80V0lHcE5T?=
 =?utf-8?B?S3BIS3ROZVFxeTJ4OFo1MmUrU2kvK29PZlF5cmVKcnV2cjRVUXA3b1dhTExJ?=
 =?utf-8?B?ZkliQ2svL0dGYXN4amNxQmYwdnNZemk5SkhoSUtndlpEMHpDZlJmY0RTVmRi?=
 =?utf-8?B?ZVorRGltNWlpT3hNN1h6cDIxdUZ5TjJ4bmorUmhsZHN1SW1lSG50TG9HcFNC?=
 =?utf-8?B?Rnlwdm1odUJOdVdnOS9CN1dUQW9HUTZQcW1DOXFLOTJXWUZoTjJxVmU3RGZE?=
 =?utf-8?B?WEhQOEE5WlB3OElEbUhoRVJoRUFhbGNTVWRBNGlPcWNrTS9LcWtSYjh6elVE?=
 =?utf-8?B?YTJJWTlVNzdVUERjUTNFSU51YmFONy9pSERJaHIvY0lZR1MxSVJ2Q3JGeCsx?=
 =?utf-8?B?T3JLRGpNeVZheTcvcHRnTW5zRm5LeGYzaSsvS0pjbGFGR0hNeHdyN1RSaXNO?=
 =?utf-8?Q?3X/p28Ohxofe0DCT6j+JU22ij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11e8b8d-f325-4150-dc29-08ddcde4bc4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:40:45.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQBk3kd4SjD3EYgGixQoL/1gWoXtbA8Wy16cNacanFLqGQWJUqn09RhmAajWNksip/jCgNxCO6ljKC0b41Ik4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

On Thu, Jul 17, 2025 at 04:48:42PM +0000, Avadhut Naik wrote:
> Modern AMD SOCs like Zen5 provide UEFI PRM module that implements various

Minor nit: Zen5 is a core revision and doesn't represent an SoC.

You could say "Recent AMD systems...". A platform (FW/OS) interface like
PRM doesn't depend on hardware revisions.

> address translation PRM handlers.[1] These handlers can be invoked by the
> OS or hypervisor at runtime to perform address translations.
> 
> On AMD's Zen-based SOCs, Unified Memory Controller (UMC) relative
> "normalized" address is reported through MCA_ADDR of UMC SMCA bank type
> on occurrence of a DRAM ECC error. This address must be converted into
> system physical address and DRAM address to export additional information
> about the error.
> 
> Add support to convert normalized address into DRAM address through the
> appropriate PRM handler. Support for obtaining the system physical address

It's not necessary to mention that the SPA translation already exists.

> already exists. Instead of logging the translated DRAM address locally,
> register the translating function when the Address Translation library is
> initialized. Modules like amd64_edac can then invoke the PRM handler to
> add the DRAM address to their error records. Additionally, it can also be
> exported through the RAS tracepont.
> 
> [1] AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide, Chapter 22

Could this be a link?
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#links-to-documentation

> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/ras/amd/atl/core.c     |  3 ++-
>  drivers/ras/amd/atl/internal.h |  9 +++++++++
>  drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
>  drivers/ras/amd/atl/umc.c      | 12 ++++++++++++
>  drivers/ras/ras.c              | 18 +++++++++++++++--
>  include/linux/ras.h            | 19 +++++++++++++++++-
>  6 files changed, 89 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index 4197e10993ac..ca1646d030ca 100644
> --- a/drivers/ras/amd/atl/core.c
> +++ b/drivers/ras/amd/atl/core.c
> @@ -207,7 +207,8 @@ static int __init amd_atl_init(void)
>  
>  	/* Increment this module's recount so that it can't be easily unloaded. */
>  	__module_get(THIS_MODULE);
> -	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
> +	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr,
> +				 convert_umc_mca_addr_to_dram_addr);
>  
>  	pr_info("AMD Address Translation Library initialized\n");
>  	return 0;
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 2b6279d32774..53095310438c 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -279,18 +279,27 @@ int dehash_address(struct addr_ctx *ctx);
>  
>  unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
>  unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
> +int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr);
>  
>  u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
>  u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
>  
>  #ifdef CONFIG_AMD_ATL_PRM
>  unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
> +int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
> +			      unsigned long addr, struct dram_addr *dram_addr);
>  #else
>  static inline unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id,
>  						     unsigned long addr)
>  {
>         return -ENODEV;
>  }
> +
> +static inline int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
> +					    unsigned long addr, struct dram_addr *dram_addr)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  /*
> diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
> index 0931a20d213b..9bbaf8c85da0 100644
> --- a/drivers/ras/amd/atl/prm.c
> +++ b/drivers/ras/amd/atl/prm.c
> @@ -19,10 +19,11 @@
>  #include <linux/prmt.h>
>  
>  /*
> - * PRM parameter buffer - normalized to system physical address, as described
> - * in the "PRM Parameter Buffer" section of the AMD ACPI Porting Guide.
> + * PRM parameter buffer - normalized to system physical address and normalized
> + * to DRAM address, as described in the "PRM Parameter Buffer" section of the
> + * AMD ACPI Porting Guide.
>   */
> -struct norm_to_sys_param_buf {
> +struct prm_parameter_buffer {
>  	u64 norm_addr;
>  	u8 socket;
>  	u64 bank_id;
> @@ -33,9 +34,13 @@ static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
>  						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
>  						 0x2B, 0xEB, 0xA6);
>  
> +static const guid_t norm_to_dram_guid = GUID_INIT(0x7626C6AE, 0xF973, 0x429C,
> +						 0xA9, 0x1C, 0x10, 0x7D, 0x7B,
> +						 0xE2, 0x98, 0xB0);
> +
>  unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
>  {
> -	struct norm_to_sys_param_buf p_buf;
> +	struct prm_parameter_buffer p_buf;
>  	unsigned long ret_addr;
>  	int ret;
>  
> @@ -55,3 +60,26 @@ unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long
>  
>  	return ret;
>  }
> +
> +int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
> +			      unsigned long addr, struct dram_addr *dram_addr)
> +{
> +	struct prm_parameter_buffer p_buf;
> +	int ret;
> +
> +	p_buf.norm_addr	= addr;
> +	p_buf.socket	= socket_id;
> +	p_buf.bank_id	= bank_id;
> +	p_buf.out_buf	= dram_addr;
> +
> +	ret = acpi_call_prm_handler(norm_to_dram_guid, &p_buf);
> +	if (!ret)
> +		return ret;
> +
> +	if (ret == -ENODEV)
> +		pr_debug("PRM module/handler not available.\n");
> +	else
> +		pr_notice_once("PRM DRAM Address Translation failed.\n");
> +
> +	return ret;
> +}
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 6e072b7667e9..df6accae8929 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -427,3 +427,15 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>  
>  	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
>  }
> +
> +int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr)
> +{
> +	u8 socket_id = topology_physical_package_id(err->cpu);
> +	unsigned long addr = get_addr(err->addr);
> +	u64 bank_id = err->ipid;
> +	int ret;
> +
> +	ret = prm_umc_norm_to_dram_addr(socket_id, bank_id, addr, dram_addr);
> +
> +	return ret;

The 'ret' variable is not necessary. Just return the function call.

You can go even further and not use any new variables. Not sure how
it'll be aesthetically, but that was my first thought.

> +}
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index a6e4792a1b2e..cae6388d41be 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -19,15 +19,20 @@
>   */
>  static unsigned long (*amd_atl_umc_na_to_spa)(struct atl_err *err);
>  
> -void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *))
> +static int (*amd_atl_umc_na_to_dram_addr)(struct atl_err *err, struct dram_addr *dram_addr);
> +
> +void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
> +			      int (*f2)(struct atl_err *, struct dram_addr *))
>  {
> -	amd_atl_umc_na_to_spa = f;
> +	amd_atl_umc_na_to_spa = f1;
> +	amd_atl_umc_na_to_dram_addr = f2;
>  }
>  EXPORT_SYMBOL_GPL(amd_atl_register_decoder);
>  
>  void amd_atl_unregister_decoder(void)
>  {
>  	amd_atl_umc_na_to_spa = NULL;
> +	amd_atl_umc_na_to_dram_addr = NULL;
>  }
>  EXPORT_SYMBOL_GPL(amd_atl_unregister_decoder);
>  
> @@ -39,6 +44,15 @@ unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>  	return amd_atl_umc_na_to_spa(err);
>  }
>  EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
> +
> +int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr)
> +{
> +	if (!amd_atl_umc_na_to_dram_addr)
> +		return -EINVAL;
> +
> +	return amd_atl_umc_na_to_dram_addr(err, dram_addr);
> +}
> +EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_dram_addr);
>  #endif /* CONFIG_AMD_ATL */
>  
>  #define CREATE_TRACE_POINTS
> diff --git a/include/linux/ras.h b/include/linux/ras.h
> index a64182bc72ad..feb53f8470b0 100644
> --- a/include/linux/ras.h
> +++ b/include/linux/ras.h
> @@ -42,15 +42,32 @@ struct atl_err {
>  	u32 cpu;
>  };
>  
> +struct dram_addr {

There's another struct in the kernel called 'dram_addr'.

It may help to make this more unique with a prefix: atl_dram_addr.

> +	u8 chip_select;
> +	u8 bank_group;
> +	u8 bank_addr;
> +	u32 row_addr;
> +	u16 col_addr;
> +	u8 rank_mul;
> +	u8 sub_ch;
> +} __packed;
> +
>  #if IS_ENABLED(CONFIG_AMD_ATL)
> -void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
> +void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
> +			      int (*f2)(struct atl_err *, struct dram_addr *));
>  void amd_atl_unregister_decoder(void);
>  void amd_retire_dram_row(struct atl_err *err);
>  unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
> +int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr);
>  #else
>  static inline void amd_retire_dram_row(struct atl_err *err) { }
>  static inline unsigned long
>  amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
> +static inline int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err,
> +							struct dram_addr *dram_addr)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_AMD_ATL */
>  
>  #endif /* __RAS_H__ */
> -- 

Thanks,
Yazen

