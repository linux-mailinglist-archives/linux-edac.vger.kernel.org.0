Return-Path: <linux-edac+bounces-4023-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12351AC6F02
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 19:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3405A41814
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E228DEEC;
	Wed, 28 May 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3T7MrWM1"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367F1EE033
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452558; cv=fail; b=CrHrMjqHpfi/tVKMeRlNJc+WmDetpX6AD494wYxFHnZIM0XjURN9k19bxq0Vbi3jXrYyqgOsdWc/yTN3HOd10sW19PATrjoSm5E/mOdyvlD2GXBifdp+o07O8v45GKTwb2LBIs9TEJRXI1kzoQ/RCiqrsWqHCWdp7FGkiDGhac8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452558; c=relaxed/simple;
	bh=w4keS/YOHDOP9XE+3bZWzOb8yYKlBIIDEpzQum+kGIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwAH/Subf26MF1tVhUIKImzmegA4GdXyGVOvvCX8fnWw2ch6iPgF8rVrY04l6WOo12tsInb9oH9a5tSxhWbh9fPuJDBSEmel2IzFoleb6xUAGkcYbgMGt1QLsI/sj+dF19OzpoxpQZY9ZGGvG+FUxg1SxmxlawPsnZqDkPUrU7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3T7MrWM1; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pytdmiqsRj3FCJP86g1zjJbZFr4HY5Jn2H0turJEnsRDvC2n6mgudTsclRJrJCox6TpowSKvE3/W9qV+dLyEOioraFNb7FqwxSx/6c1hlyUdVXmsdKootMn1OR1QJV/6alKeuKO3NJC3onE40SB7CWMbBqseAXncMQ5QYk+SPOpqKD0pmKKDXP4abOLK81QPEHVQjWSOeVeLnDc6aPFoe6fSK7e8Xgbq2Iz50Ilhyw3XeARkVqgusOnp0EROBDLMrzah1m9qtYAF7VpGzvN2fr5ouFcwPU0ugqG+OpmFN+WAL+HkgHClc+CFfgM9CIJ1CpuuN0GOItYyJxF3ZP9n2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDXpNpiObB9ab5mzGJ9BLzpQRA/rpPYAH68pNIXlx7A=;
 b=gTJLM+61onCbqUCzKLb6+AcTbC1B3mzmbrm8b/ObvYcc+oSctshgnXAnOUXQcufb+85pjT1sSIObewAvyGmAdiPQJ1g0p+OPfctsYK0Hd/PGSmWg33pDI7MUs/L3VG/iJsGGE5A1L9f0dCJ/BZnDmHvURmRoqRlArB3RPgIxYNXn4LJnedJxQT3Yh202NqQjpc9+XqYwrEHahv0TQ3m7sKJR8I0kR9yGDSN5bwuaKlzZIPj3VBDDq3BwL9emZPuiyHJu2JH5h/ywunVuWkkwAOdAN1nd0Gt33XhMcBZuTB4FtK1Dme/7lADOueutAhqG6wLmDZpiv6UuVvedvauCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDXpNpiObB9ab5mzGJ9BLzpQRA/rpPYAH68pNIXlx7A=;
 b=3T7MrWM1UgSA64HDtQMgtvq7cCyNK3AlXwcC65imW8D9FgEFIcYA64cmMwE7kzOpTc4D//Vg4mu3T6LKiTy5LFGW3chABwHjg9+lFmxkuV9zmr64zrycFzr1PcpX86IO1GMIza9IGDiqGkKDgiGl6UOaBHsFTV88FlJxLm/0X3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 17:15:53 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:15:52 +0000
Message-ID: <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com>
Date: Wed, 28 May 2025 12:15:50 -0500
User-Agent: Mozilla Thunderbird
Subject: amd64_edac fails to detect DIMM with only one ECC UDIMM installed
 (works with two)
To: James Blake <jamesedblake@protonmail.ch>
Cc: "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Borislav Petkov <bp@alien8.de>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
 <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:5:334::31) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: c29c9224-c870-415d-aeaf-08dd9e0b4c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzNReDdMUEVJQ0VselBmOVpiT0g1RVNhYVgyT3VPTnVrSTk2WTZzOUtsQ0p1?=
 =?utf-8?B?WWlFTEFLbXBjbUFveVB2LzFodjFLN0E5SS9GOWZaeWZmcEZ3ckNER1EydmRn?=
 =?utf-8?B?RGsxZjVXSGxyNkZMWFV4azJORGJUZEJ6QUJOZTY1cEx0YXhVbmlrYUIxd0M4?=
 =?utf-8?B?L1pWZHBLdnRBVlhKazFRRHl4MU13THpsMmRrYkxJTDBKdkFpZjFyci9MK0Mz?=
 =?utf-8?B?alRFRVVvUTdOV3lEZEZoZE5iRE9MemZBOUNBTUZYVEFWZTUwcnpxSnVuakRn?=
 =?utf-8?B?VE1yYXEwRmtLdWQ3akRCaUx5dmJKYXp3ZlZFdThUbDJodVRIRmY0bXJPc25C?=
 =?utf-8?B?OUpnc3JoSUowSWVCTjRJZzdHMGppQXQ4VG9ZNjVXY0ZLUGtOSEtzOVk3VFdq?=
 =?utf-8?B?cHd5cERLYmNxZVRNY1Vkd1V5bUZIbmtqZzF6TkVheDhxc2U1U2ZZMkxTZHdO?=
 =?utf-8?B?aDBpd2tsejN6Y0x0VVVudXlMbWJxTVVRamZ0UUI5clhXYmU4enlVclRFY2Za?=
 =?utf-8?B?b250SmVZNVlYa0d1NXZFWHAwaFdVcFRDMGEwTGQ0WThoMk5ISEc0M2NPZWQy?=
 =?utf-8?B?SnhQRUxTRnV2eFY1Nk1VdEEwc2ROYk9hNUV0TmZCMVUyOU5GY1FDbGp3S3ly?=
 =?utf-8?B?Vzg1b3V3ZTQzWUg1S0tyOUY3SDkrMlJSWEg3amN3WFcrQnZTWENpTjhjenR2?=
 =?utf-8?B?TVYwSkFEMkU3VmovKzRqL3AzVXprWkczT2Y2SXIrajRRRm5lVitFN2w4elFv?=
 =?utf-8?B?a3BOa2dmRlZDTnpjVFNTUW5TSVI0Q2QzM2h3WWFvbHluQ01lMjVnTlJCWm9w?=
 =?utf-8?B?eFZZSFIyQ08vVWJhazBmWlNtN1pyN1l3dTlsdDZUbEN1MDArNlJQTVhXQjRp?=
 =?utf-8?B?bkpJcDQvS2MxRERKNURRczBOV2RRZjZ2VHdGbSt1bmxHRXRCL0JFbGhsSnl3?=
 =?utf-8?B?TTg5cmVYZjFhRmx5ZW9HMXkyZklnYUgrY3EybkNvamFac21WVWZnSERZdWZR?=
 =?utf-8?B?M3NGVSsyMVZoTlpReEJOTXp4dGR3OE5EY1hUeDl0MlNpdTE4dm9nWTNib3BN?=
 =?utf-8?B?UDFtY0VZQXFQbTdzVWFPak9hMjU0WUtPcml2dC9wYzAzemdJaGNac29sbm13?=
 =?utf-8?B?ZEw0THpGRzgrVkFBNndWWDk5L1NqWWtkRTY2MHkzcG5qbE9sK1FPUkE1akp4?=
 =?utf-8?B?VVB2REdvUm1RZ2V1YTUzYlF1eHVBR2k3Zk5YM3R0aDgyR2ZxWExZM2t1aFFu?=
 =?utf-8?B?UEVlSVAvYXR3a2JLd1YxZmZwMTMwd2NsSXVsZXRYdUFlVit6dUNjY05HL2Zh?=
 =?utf-8?B?enBiTTVlWHQ1T0J2UStWQXNoTUZRR0RiOGROQ3FtdEdhakRya2xoNXdOTnlO?=
 =?utf-8?B?ampuS3A1akkyd2tGMUJzbEVCcUtJZ0RtaXBvcGpqOC9VQWRoNkhuS2t2VzRX?=
 =?utf-8?B?NlE3eUl5WW5EREE0VFZJUGNidEFCZFdkNnlMTFpWb2FmeWdOeC9jUHlPOHFM?=
 =?utf-8?B?RHlDSGt5QXJJWnQ5S0w3Wk00ZEVJREN1MTQvN3VhMjJycEZiRXlBcEZ3Vy9P?=
 =?utf-8?B?YWdnaW5rc3VXejBrKzc1NzBXcnJCOHpQZlBsK2dENGZ3UEo2S2Z0czB4WTNv?=
 =?utf-8?B?MVNKMGVWWkNUWU5NUEtFQllRVkl1U0ZTcG8wUnVqRWtFQkJSNmdsWDJrT1Zj?=
 =?utf-8?B?ZG1NM1JHbzNnMlljQlhsUU00MlZVL2g3QnNXWjVlczMzZEZwaFUyaXR2TzNJ?=
 =?utf-8?B?bDE0cW9VVzFpSEFycE1QVmVicjJNSWhSL2hVQm1tRDlIODh0dHc2a0dNZjJU?=
 =?utf-8?B?WkhBdjEramZuQmMwVkhNSFFpSFdLR2VQeHNhK0V2SzNJd05HeUFyMklMWjA1?=
 =?utf-8?B?Z0gzOHVqWXpiWnZGWm12V2EyTFdtVGIrcm44L1duL2h0VDBsVHJIeDg5ZnZN?=
 =?utf-8?Q?ArDXF2uTug0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkM1VWE1TXkyZ2FpRnFiMXFiYXVoT3JqMlE1bEZaQnNMU0NDY2J2WitBRFNl?=
 =?utf-8?B?WkprQVdnZWtuQTdZSGYvNEpEbTVsQktBSTBrcFd6WlpxT3ZrcUw4ekVtNnJO?=
 =?utf-8?B?clhyZlJ6NUtONVJWcG01dWtuTTZBRmZIMjRieWdPYzhHZnpVcHN6RHdIY0lZ?=
 =?utf-8?B?Q1hpMGVTNjRuS1gxMmFkckVKR3BHT3dBdkdLWDhpaHQ4dkN2NGRnR3VDcDZq?=
 =?utf-8?B?MVN5YlFOWm9yUExJSXhvYUd5My8rSGJSSUM0OEpKSC9WSkhRVTkzVisxNFpm?=
 =?utf-8?B?cHZiU0pHczN0bnZzMWtSYnE5RC9zbTFYWWxWckt0N1NvUllEcXBxYWUrK0gr?=
 =?utf-8?B?OTZoS3p2aTJHSk54MnYxK2lFQWRaWVRuczJMMm9VSjlQYmUyOHBYc0NQNHM0?=
 =?utf-8?B?MDdLa3d6NjNhL0h3UzczQjJVcXZmNmJqdk5vb1BEYlVZd3BvaFZobFdUVXNP?=
 =?utf-8?B?elJzdXBQM0lLMXIwek1walo0UTVWSUVVRVhKcXR4SnRkM2dVS2xHQ044b3pE?=
 =?utf-8?B?ZEdIL2tzZHJIY0YwQThrdTN3cUtieUR3UFB0bU1uNjFaY2pMZmEwQnducU1y?=
 =?utf-8?B?WWVnQjJFM1R1MW1nZWx4dnNLSXlLSUFTbW9hM0dWK1R6VDJZUjFJM3lZeC8z?=
 =?utf-8?B?ajRxZXRsZnQ4UkxnVmlPaDk0SklqZ2swTHoyZ0xXZGUzWTkxTnY3YVptTUww?=
 =?utf-8?B?VisrZlVFbTVrV3VQekUzendZR0l0VXhGWlN5YUZBZDhjcmdpaVpVbkdLWWZO?=
 =?utf-8?B?WVVQcjBCVmNlZ2xrdHlVYzZlRHppVEJyTk40ZFZwcWRrRG5mbmU2SnJEMytj?=
 =?utf-8?B?ai9QNGN2THFaSGlLVGtBekRGaHF3czJmb0o1eU1wUjZ6eVM5MFpSbmU4d0Fz?=
 =?utf-8?B?M1liNmlGRzRzbEhTQ1piVFUwYmQ3dyszOFlMZmgrRFgrS1VKTm4vK0puRWRv?=
 =?utf-8?B?OW5nOS9oaERjMkdoWWRpV0w1U29RNStXZTgzS3o2eGtJQVg3SWZQbGVHSDdP?=
 =?utf-8?B?T2U3UnphUEZ1QktxdHErSUtFbE5qb2F1bFBvUlRqYm9ub3NvTlowdUhldzgv?=
 =?utf-8?B?c2JxRU9lR0U5RjNtT1JsczNzUkV3c3R5cmkwSmFxcE5sVEZHOHViSXR1a29R?=
 =?utf-8?B?TXM2STJVVlRRWEM3aXUyMThUaFhVK2RBaC8vWDBTSVFNV0JBSVRmMDJRSmNT?=
 =?utf-8?B?WVBMb1ErU3NxdUF0WnBQbFhrRnJWNGpGMXRjZi9OM1pzQWJsbEprcXZab3Rq?=
 =?utf-8?B?ZXhGV1crbm5qWjhKanFrdWVTODRMYVEvZmc3SEsydE8ycVgrTmpuYThIZUxy?=
 =?utf-8?B?MXU0QjBGeUN1T1ZrdDNWOHVSUVdjOHRMNE5PMTVFR2dkb1BjK3VKcHRwQlpD?=
 =?utf-8?B?TTNwcnd2WUZwWDdxVjNIcXo5RE9xVWRJNWRQRWhjTXJDUVR6ajl4aEZQL0k2?=
 =?utf-8?B?RkY4K2haa3k2c2J3L0hWU0JhTVF2TW5iR01LMkF3NEhxVUFteVY4aDhnVm1k?=
 =?utf-8?B?MmQ0NGNRRy85MksvTjN4UEYzU3doZ0tPRkV3eGZOKzBJT3NKbm4wUDk3TjVv?=
 =?utf-8?B?UlFkSE9VeVdJUkxkcFV3RlFEU0NSWmEzdXowWkFvTFkvcTIybk5aYlZleUlI?=
 =?utf-8?B?OEtycjBzRjErekRXVS9XcW9aTDIrVUJ3NFVNK244OThGcm1udTREaDE1SzNS?=
 =?utf-8?B?N2J1ZnFJYXRqd0prTGlqWStDUzl6Vk5Fb1NpR01jcHFtZDdGVmhkSng2MS9M?=
 =?utf-8?B?WHozN0xKTm1saWluTCsrMW12djZ3VVp1enk2eU1YVjFjUTRid1Fib3lZMWZm?=
 =?utf-8?B?U2IvbVdydldjMVFwZUtwL0pIT2F2b3ZRem0xeDh5VzhWMzJydGJuQjNIQmxL?=
 =?utf-8?B?dzB2V1dHckxEZWVFTnZlS0V1dytwaTA3MUgzdTd3M3dyZmxYRFU2am80R3Q4?=
 =?utf-8?B?UnpuTTVnWXN1MXY4YVpSYkpRMDFuNUl6Z1ZqblNIcmlOSS9NeG0rTlFpMjlL?=
 =?utf-8?B?bFBscEpxZWh5VElKaTFhTi8yS2xCYzBhNU1Xd3hNRWFDaGgrZHRJVjNKK3ox?=
 =?utf-8?B?ZW9aZEVsU3E0UUpCQ1RuUExOY3lsempST2IrcWI3ZU5Da1YySURzWDZxNmtY?=
 =?utf-8?Q?IKTRwQJbFEizhhenNVOP0PtZ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29c9224-c870-415d-aeaf-08dd9e0b4c92
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:15:52.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDsh0q+uKUCtfADgNhx7axwQdGixm5TZL+ixkSFsKcShvRtFke8f/tWF2S4pEHIwTt1iE/G5dbkM9AlaBBdKcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

+ Mario

If the patch below does not resolve your issue, please note that
we have also been made aware of another issue on Phoenix and
Phoenix2 systems, where the memory details provided by the module
are incorrect.

We are currently seeking approvals to upstream the fix.

Just to be sure that you are hitting either of these two issues,
can you please provide the dmesg output with 1 and 2 DIMMs
connected?

On 5/28/2025 11:44, Borislav Petkov wrote:
> On Wed, May 28, 2025 at 04:11:27PM +0000, James Blake wrote:
>> Hi all,
>>
>> I'm seeing an issue with the amd64_edac driver on a system with a
>> Ryzen 7 PRO 8700G and ECC DDR5 UDIMMs.
>>
>> When a single ECC DIMM is installed, the driver fails to detect it and
>> reports:
>>
>>     EDAC amd64: Node 0: No DIMMs detected.
> 
> Does this help?
> 
> https://lore.kernel.org/r/20250513192221.784445-1-avadhut.naik@amd.com
> 
> 

-- 
Thanks,
Avadhut Naik


