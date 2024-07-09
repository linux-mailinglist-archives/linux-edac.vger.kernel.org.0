Return-Path: <linux-edac+bounces-1467-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7E92B011
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 08:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA0F1F22B67
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 06:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B481386B4;
	Tue,  9 Jul 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miDyuQn7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330217D07F;
	Tue,  9 Jul 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506455; cv=fail; b=JT5MQIcNIb+LimZ4RcPQIO/M6Gxv4R1/7i1uXGZOGLgiMeJf8nop6TL4haTiIZIbwJPW1E18eETLKujbyqM3zmceDwuXWKXM1Pq9QVdFKNIciOCnHKjcArceowFn8QgWco6C9oJ2Y5MZOe12XhsqIhNvXg5D0Kna85w9hYOnQ44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506455; c=relaxed/simple;
	bh=VXChbCMvIcclDwcbr0gZWmjPMc1biLbFsfN/Z9e/G1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFl4rQ/hq8sbnTS28rTvWZxWE1DMArUnqsxyhKvb7nixjZxP4CDs+ajAj9Ll3M+I0YLPE26mINEssQhqp0gsWfgoC2u7EKrhpirImbchKrKbz11lrCPhmob9C/Cesr5Ee4BselQqZZuQMX54YanbUimlsGUmTFCBQPKg6cQa1FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=miDyuQn7; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0LsM6frDqeSfl+oHqDtzQEI4jcUsBnhdj8bCefPB9Cf2YUOb5ZGRkX7tuJ/X+NkBjlqRUgxxKRAZl9DSQa71gih0G+9EhiRxaNaRCIKMYZ7o3iXjz6r7QVXjt2ZAsqVRU07zgzezHsJ3K8NTGeIQUkdH3MbADKlM3bJeN08uDly0ZYY/NjuYKxgJ4oZ6jKpJwaxjJBtmb+Mx0xsKZXl5gOHmuyhemJtwdmltNg804mUDF1YgBJcyjVVbeJtNkh/ODHhWnW8xgiMKI4rhecqPCQJhUG0/+irohoILQ0j4bj2QixNK6CvEw1eZXmqlIokfhukkyf4fvAkOo92QYcVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KzTwmoJZSM1YtC/338CPmnjU4m7BY4I26+ivN2wq9E=;
 b=dbKgc76iZ9Kv2ypxNapsZWkMmuxb2/vW87fmZdkCtMAiwg2tZUyiHbeDUQ05ruQ29kiFx6nWwXA4srLkaZgyznKZ5FVnWJqTDplmwTF7VBOGnafJ9TAonHeAeNt88UXblQ2o3kblORp0DqEj3lbgqpycYXEHqXEZy0WIsRgVwyIDY/lyR8nC+Z81MpW/iEqAXthYH2vC/0fdhhzn1xRRkFjXzamCPiV64zeaF3QjYTp56xE+jZNyCO0uFeFqfsIXJi3NqkL6paknqb/38sFDsI2O11U0FwJXtLul2c21M1TYttxrnvuf8dzQ3aWbZUxOEs9F5L8mVVaq/86MlqikZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KzTwmoJZSM1YtC/338CPmnjU4m7BY4I26+ivN2wq9E=;
 b=miDyuQn7UtusKuEFMnZ/08jNGyBsNX4brQRoN+haioZUz19RvLUk/1GDFtNZYHVm+4zWM+QYof0qviFCa1kfc5vEX5bfVnOsMAN96VIyrcpqklUNXoOIPZcSLaLyEgKBsmbzB/RfgyWHYJAFCHg2ovOa3/aTXlr9ylqHGnkiB1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Tue, 9 Jul
 2024 06:27:30 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:27:30 +0000
Message-ID: <17bba31a-9bb0-40e5-be7e-96ac6d421066@amd.com>
Date: Tue, 9 Jul 2024 01:27:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-3-avadhut.naik@amd.com>
 <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
 <6c318161-9ae4-4965-b8f3-e38bf1393628@amd.com>
 <20240626181805.GDZnxbXRJlCecNeDGW@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240626181805.GDZnxbXRJlCecNeDGW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0153.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::8) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 233be717-df70-4d61-f759-08dc9fe0355e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzVqUEFicDdTcmdIWS9keWpkQWJ0dG1Edy8vTWRlb1JCNCtjdjF3b1JOOE9C?=
 =?utf-8?B?Y3Q4L2dXZHVhYkpFYnVjd1JVRDBOQk05bnE5N20yNjAwcVBsM1Bwc1BKeEVE?=
 =?utf-8?B?ZDNEQTNucUl2a2RLSlJyWkdBNFdaS1UweUw4YVJ6N3F0cjJSVkpRSm45ZXhM?=
 =?utf-8?B?RGFib1pQSmFaMGU0Z0JXSCsxRDgxWjh5SUk1Z3ZwTm5VaE8wVW5XeWxyU3Z4?=
 =?utf-8?B?bzU5NlpIK2MwSzRnZ1Z3WDRqdDJ2RE9wRGtpZ0Q1L2xWMTgydzUzQklheFdm?=
 =?utf-8?B?QTRyeGtDaURWdGM2Nk5DcG82U3ZFYVNXYlIwZ0dhbVVKK2FxazhGN2Y0RC8r?=
 =?utf-8?B?YUFDenh0RkZBMlNqOE1iZzBMcllkdXFuMldNWVNMakw2dUx2ZmIzK2NQaWpm?=
 =?utf-8?B?WVIza0tLbHpDb1k5VXlXRGlXNUlHQTBGbDFkNDQ2cXFPaEg2dDVpSVpQTmY2?=
 =?utf-8?B?QVNDVzVRaS94MEpOYWxPWmlaTnRyR2h3TTBoL2F0WisrVk1GUWVweWZTaUM4?=
 =?utf-8?B?RWN6VlAzRk1UN0IyQTJLL3VhMjVJcmFIa2g0MFZHTTVsMDFoUWhYd0JqSjMw?=
 =?utf-8?B?NVNXcGZscmQxaWRLNnJYbldnekQ2UUJNaFl2a3h0elRHQ1lEZUxlalF0NFBK?=
 =?utf-8?B?dk82WEJGVWtBc0lRMy84Y2RMWnY0czN2cGtDM1poazJvYnFic3NxbDVEOGdG?=
 =?utf-8?B?UG9pbXNnaGkvKzlYVm1lMGJWMW5pN01sQVBJUjBXUXZaUVRiSmxaeUxmR1pI?=
 =?utf-8?B?QnE0WEEybW53NTQ2aDhQa3BrTjF1Z0lybE1kbmtPRC82Ni9JN0JITDFVcnJq?=
 =?utf-8?B?UE95UHdjMkdwOWtzeHNpOVp3NzdyMGFHTElxekVpdjg1TkRXUHhmTElzVmUz?=
 =?utf-8?B?Skt1Ync5dGRqN1IxRmJwY3YvMHEwajlqWUxXS3ZzNUd6Yndtdis3QUpkL0Vq?=
 =?utf-8?B?T3FxNlpsK2U2d25xOW12ZnlBYzFnV2Z1S1UyNzZqaXk2WWZYcEU0ZHJDMnA2?=
 =?utf-8?B?R0FHenJWcUNEQ2p0TTVRSnNiU09LSWhsQkpycXRKaFVValpWOWp3L3UrRWZ2?=
 =?utf-8?B?OUowZWRIZnptMkk5eFNpclBYb3h3MXhJb2ZKL240ZnVDZ001UWNNckcxYkF4?=
 =?utf-8?B?aXZXZ1ZtZUVkamZNT2VsRHVvdjdObFRod1BncHhIQ0xTYWY1Q2JWTktTRk5r?=
 =?utf-8?B?WVgzdzBLd3lObExzWXpoaExxQjNxY3BaRDNtek9sMTNkejE1YXM5bitZVlBX?=
 =?utf-8?B?bWd4TEZNYlhrT3JDekZWdjZ6SnFaamQrUTBKejZZT0ZFbHV3d2RESGVrSjIw?=
 =?utf-8?B?MEJORFFyNWpPRjdpSVVGazUrdVZlWFlwWnRLN2dGOFFzNTZBYlAzaS9weUMz?=
 =?utf-8?B?cGJzb0drZFFaclJ0MG1GYjFhNEYzZlFSNlErQlZNcnE2S0NocXN4eDhhUlY5?=
 =?utf-8?B?WWRBTmNOQXRnVTFteDFoZVRSMUtkYnRORGNxTmYveEIveUd0UzNiQ1ArSmpk?=
 =?utf-8?B?MzV4U0orS05Sekh4QWxPMlJUOG5hTUJodTc0ZFZJMGJlSDNTeVFsdXgrY3I4?=
 =?utf-8?B?Y3FGQjZDcE5GYUlDZnZld0dmeGVhdDZXbEdXa3hmWUkrS0NpSndoVktVdWJ6?=
 =?utf-8?B?QVIxM1MrTWtFQU9lTUhwT0Nsb2VIN2RjbVM1TUtRMnNuYXBuR1VaamVpcjl0?=
 =?utf-8?B?WjhER0pIK1hQcTNDVHArVGU4azYwd0xrMWFEbHFpcURRTzh0OFpGSlBuQ2V4?=
 =?utf-8?Q?7dLjMrJJLvTcdk7z3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDhscC85UUlrbjg4cTZBWlJUb1FvOVEyOE5iZlozVktiMnhZRHN0NjN0Q010?=
 =?utf-8?B?c0pYWVd4d0cxWENnYTdheU9XV1o2NEdaK0hRaFo4Q2FPWXd5dFVwcXBzemd6?=
 =?utf-8?B?c0kvbms1ZFp2dWhYMTZScVhucTNBMEVNbjB1VWUzc3JxRVVWRmxvNjVJV3Jn?=
 =?utf-8?B?MXRJcVYrSU1OaG44dm9vVkF6TWtlM3RJVE1xMUdTVlcvSnI1L01wTGpDUk1E?=
 =?utf-8?B?NXVSSkVUVFJOQURsWXNoZjRWdlM1WlFrdGdoejllcGdacFZmWXVaSlZjdDJL?=
 =?utf-8?B?UExIbmdzd0ZlWFdxcWliOGM2TDNpZ2VYNVViVW5xOXJteEtMcWNrcVBHN1pH?=
 =?utf-8?B?VTFyalI4NERTN2dxeGFIa2pTSFYxSk03VlYyb0JXL3dnY21qeERoVGFIT2xo?=
 =?utf-8?B?a1NFWkVoOE84UGNYcDU4c3hlN2hBV041ZjdaeGQ2K0FQM2VqRUVOM2VmUjRK?=
 =?utf-8?B?THFydksyemQ2QzdmVGNrNy9jdkE3SzNxZk9Lb2l5S2JZYlpLWlVVUEJZWXEr?=
 =?utf-8?B?MUI5V3kyaUJyOHJJQVQvc1RBZGlDWHhSUmlXSjJmZU9ieDkyNStHQVo5OURk?=
 =?utf-8?B?UUVZcmZFR0VMY3dFOUtXWWR0ZTZZcHVMa1dzQ25zQUNobWZtN1NNOEQxWWNT?=
 =?utf-8?B?VnI0S0RybG5qQ3NZYnRFdnNQdEZ1ZS9NdXZKT3FMWlhaU2N3MkJwNFhjbTZp?=
 =?utf-8?B?V0duWWNYczlEY0xjdXh6dy8rZHlCRjlZOHVYTVRBa0lhU244dkFNRXRFaFNk?=
 =?utf-8?B?Sm11R2VCUFlxVmV2NWc3VlErNGRpTWUyKytMWTBISUVudjNPTlRjUzl3RklU?=
 =?utf-8?B?d0JQUjVreFFuc3diYk16WFhMTFFkeGlUZjM4WXZFWGJhc2w4ZUowZnZMdTVq?=
 =?utf-8?B?OVJXK3pUQjhOQWtKYmJoNUcrZis3VXVDMGZlVXlOZHpNb3RFNHFSUlhMS1hj?=
 =?utf-8?B?UHc1ZVRGOStzd3ZycEZMVStYRldpS0MyYVIwN1l4OXFiZXkyQmR4QW9wMUZQ?=
 =?utf-8?B?R0lSNEJFdC81dHRsaEEwVXJxYlk2dnM4WHlBdHVlWUxEc21EcnFMT1Z2TGtX?=
 =?utf-8?B?eU1WMlNEa3Uxd0xyQkhyc0J1UmJWOU9WUDJlVVZBSE50YU5zeUhYeXROVngz?=
 =?utf-8?B?OGprSm5uRHo5OGs1L3FiaVNyN0RkRVJ6NEJ4MjNVRWhCQ3YvZVpRNGZCSEx6?=
 =?utf-8?B?d2tBckd5TnpjNFRIRGJlRzZaZnRNeG1RVU9Vd25LTkE3QjgxaVZ3azd0YlhD?=
 =?utf-8?B?eURuZjMxblcrR1hiYld1d1d4YWxGUlRmcUtPNlBOckkxZVhxQ0NXOVVFemhr?=
 =?utf-8?B?bW16NEZWbzhBcEVOa2RPSmh0clp4UHg1cXp6dVhCSmR2cU5zRXJmS0ljdUd0?=
 =?utf-8?B?dFhiNTM3OEovaFVSQkN1dUw1cXp1ODZMcTg1TytzZFl6Slp4YWdJbVJpNWtN?=
 =?utf-8?B?d0FreGRNU01zeC8veXdvQ2xKWHovbVZtMTJuc1NXZldzZEZHKzFPa1dkdE5X?=
 =?utf-8?B?TDIvbXFKOEh3ZnZzZ240OEVMcnV0VllHY3JCeGFhWEFzc3ZnTDdDR3l0Qk96?=
 =?utf-8?B?VWorNXNjdEhKWjBSZ2FXWmtIZW9XMlVhSW43b3dPQTlhNS82UkdUVENQb0s0?=
 =?utf-8?B?OCsvUEh6TkNzMWhiaXpvVW8vNjJBV0JIOXZkeDJSM0VxNmU5YU1uSmdyNlFW?=
 =?utf-8?B?ZkNWeWlRcndNT3hBKzhQbm4xV21SUEJ1Z1NJdFJzY0VJdkRsQk5mWjRHSGxs?=
 =?utf-8?B?T0NSV0EzTDFicHFqdXI1QmJyTk1XK2ptUmwzaE1kZVNBMFBYM21FR0xtZ0NN?=
 =?utf-8?B?SW1BRklsbExmcm5PYWtVOWM3K1FCSmRUQ3FBTWoxK1QwbFdGUytZS3NNUHc4?=
 =?utf-8?B?aUZKU0hCY0M2b3R4VnlkcWJVdUM3am1lNTVZZURuS05qbXlTaFM0MlFPYnFR?=
 =?utf-8?B?ME16Nk5kZ2ltQ2RCbHE1V0tESkphMVhRdXZuYVo3aW9YbjdrdGZWOWtJa3NG?=
 =?utf-8?B?blRYaHhCdENEMVZMeHJ2Y2djU1pDdFRxWXlUZHd4Y2g0WkZUNUNlQWFQdlF6?=
 =?utf-8?B?OUNlV3l5YzNoTkJuVjZsY0pVSllnZ2g3TmhuY3duSzZMbUlnWHc3eFlReVkv?=
 =?utf-8?Q?s26t1iYywMp0GIcbtaiBD5N6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233be717-df70-4d61-f759-08dc9fe0355e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:27:29.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6EqtXNzlUtN1kewQyvpIaWJRaxjwWYPncpH8jxd5smzqw5fGN1c8P9+hOjJgR3xoxlbmPvRw77IqKQFIh0kTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753



On 6/26/2024 13:18, Borislav Petkov wrote:
> On Wed, Jun 26, 2024 at 12:24:20PM -0500, Naik, Avadhut wrote:
>>
>>
>> On 6/26/2024 06:10, Borislav Petkov wrote:
>>> On Tue, Jun 25, 2024 at 02:56:22PM -0500, Avadhut Naik wrote:
>>>> AMD's Scalable MCA systems viz. Genoa will include two new registers:
>>>
>>> "viz."?
>>>
>> Right. Will mention Zen4 instead of Genoa.
> 
> I still don't know what "viz." means...
> 
IIUC, its an abbreviation of a Latin word and is used as a synonym for "namely"
or "that is to say".
Might not be the best choice in this case. Will change it.

>> Yes, I catch your drift. Will reword the commit message to explain that the
>> new syndrome registers are going to be exported through the tracepoint
>> in a dynamic array, as they are vendor-specific, so that usersapce error
>> decoding tools can retrieve the supplemental error information within them.
> 
> Again, why?
> 
> Why is it important to have them in the tracepoint?
> 
Userspace error decoding tools like the rasdaemon gather related hardware error
information through the tracepoints. As such, its important to have these two
registers in the tracepoint so that the tools like rasdaemon can parse them
and output the supplemental error information like FRU Text contained in them.
Yes, the registers are also being outputted thorough the dmesg but printk messages
are not an ABI.
The proper way to export these registers is through the tracepoint.

>>>> Note: Checkpatch warnings/errors are ignored to maintain coding style.
>>>
>>> This goes...
>>>
>>>>
>>>> [Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]
>>>
>>> Yes, you did but now your SOB chain is wrong:
>>>
>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>
>>> This tells me Avadhut is the author, Yazen handled it and he's sending it to
>>> me. But nope, he isn't. So it needs another Avadhut SOB underneath.
>>>
>>> Audit all patches pls.
>>>
>> Wasn't aware of this chronology. Thanks for this information!
> 
> Well, there's documentation for that which you should've read already, before
> sending patches:
> 
> https://kernel.org/doc/html/latest/process/development-process.html
> 
> and
> 
> https://kernel.org/doc/html/latest/process/submitting-patches.html
> 
> especially.
> 
>> So, IIUC, the sequence for this patch should be as follows?
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> 
> Yes, now I leave it to you to explain why. Hint: it is in those docs above.
> 
Got it. The first SoB entry is of the primary author. The successive SoB's are
from the people handling and transporting the patch.
IOW, the route taken by a patch, as its propagated, to maintainers and eventually
to Linus, should be evident from the SoB chain.

>>
>>>> ---
>>>
>>> ... right under those three "---" as such notes do not belong in the commit
>>> message. Remember that for the future.
>>>
>> Okay. Will move the note here.
> 
> Or remove it completely. checkpatch is crap - I know. No need to have it in
> every patch.
> 
Okay. Will remove the note altogether.
It's also present in the commit descriptions of other patches in this set.
Will remove from there as well.

>> Had considered this. But struct mce_hw_err *err wouldn't really be used in
>> mce_read_aux() in patch 1. Only struct mce m, which is already available, will
>> be used.
> 
> So?
> 
>> Hence, deferred the change to this patch where usage of struct mce_hw_err *err
>> is actually introduced in mce_read_aux().
>>
>> Do you prefer having this change in patch 1 instead?
> 
> I prefer a patch to contain one logical and complete change only. Because this
> makes review easier. You should try reviewing patches sometimes too and you'll
> know.
> 
Understood. Will move this to patch1.

>>> So that vendor data layout - is that ABI too? Or are we free to shuffle the
>>> fields around in the future or even remove some?
>>>
>>> This all needs to be specified somewhere explicitly so that nothing relies on
>>> that layout.
>>>
>>> And I'm not sure that that's enough because when userspace tools start using
>>> them, then they're practically an ABI so you can't change them even if you
>>> wanted to.
>>>
>>> So is libtraceevent or all the other libraries going to parse this as a blob
>>> and it is always going to remain such?
>>>
>>> But then the tools which interpret it need to know its layout and if it
>>> changes, perhaps check kernel version which then becomes RealUgly(tm).
>>>
>>> So you might just as well dump the separate fields one by one, without
>>> a dynamic array.
>>>
>>> Or do a dynamic array but specify that their layout in struct
>>> mce_hw_er.vendor.amd are cast in stone so that we're all clear on what goes
>>> where.
>>>
>>> Questions over questions...
>>>
>> Should we document this where struct mce_hw_err is defined, in
>> arch/x86/include/asm/mce.h? Or do you have any other recommendations?
> 
> I don't know. If I knew I wouldn't have questions which you can read again and
> try to answer.
> 
IIUC, at least for now, the libtraceevent library parses the entire vendor data
array as a blob. Rather, a pointer to the array in the raw tracepoint record along
with its length is returned by the library's tep_get_field_raw() API.

This very API has been used for implementing support for these registers and FRU
Text in the rasdaemon.

https://github.com/mchehab/rasdaemon/pull/122

Thus, the position of the array within the tracepoint and its length can be changed
in the future.

Its layout however, is a completely different matter. At least for AMD, it shouldn't
be changed. New fields, if any, should be added at the end.

The underlying reason for this is the FRU text feature.

With this set, the first two elements of the vendor data dynamic array are SYND 1/2
registers while the third element is MCA_CONFIG (added through patch 4 of the set).
Now, in rasdaemon, SYND1/2 register contents (i.e. first two fields) are interpreted
as FRU Text only if BIT(9) of MCA_CONFIG (third field) is set.

Thus, we depend on array's layout for accurate FRU Text decoding in the rasdaemon.

Hope this answers some of your questions!

-- 
Thanks,
Avadhut Naik

