Return-Path: <linux-edac+bounces-5049-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E303DBDB068
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 21:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4EC64E50DE
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D221B9E0;
	Tue, 14 Oct 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GVGhEgOI"
X-Original-To: linux-edac@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C33139D0A;
	Tue, 14 Oct 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469346; cv=fail; b=CUHo4VSp1a+md1k56gdcGskTClHGm7T5Zlz+htXmYK9j9g0wnehHPywjPdxth1TuIjh1/dh7eZ03JLDzhPVUMzE2qGkNBz8arPT8I+S6ZNvHX612+E1nHYxGS5iYZZIGQjaUTOiv0o+IYbqzpSla4Y6/qC2O9K0zfl7OgfOHeXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469346; c=relaxed/simple;
	bh=K3ZyjcMugRucyMizOMSZYzyqfU0nzGsylR8RxoC4M/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RCmxEm9JiqZmYZzXlzsDvP5TOfmJg8T1XR+wUbjwwt+lo50p1FY7KlbLWcAYW3eD9DOa6YtALQmDKjcch4iQ0VTY+8VBRZ1d6GIT4CXAsINUES2DezUCYzSj3CAuV4UdqgNPTtddPT/lA3W9DO3ymJL3pExtiQHeWXQYGwVRUEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GVGhEgOI; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tna/SFHa91O09kLR4vULFSak/4hYxC5QM5kIRGISC2Z+q6macAmreBCXWaHjPfaYkAJr+ikR1Uf0GKavqV4bwru7aTb2IeJDD1/u1rOG6uurP9Dv4zvEcTE5h0MMKkB9tjLtSNKG/X+eZfUMnoPWWuOwgsuTih+T5mzBoY0cQAjcTo0pCXDhA6s4H3wCv1IKUSv3EkHZaHnXFq7oi+ATpXn65OJGTQNlxMh2ANF2FLzOWfefxL8rV0Qrb4VupWcBhKmKKflEtEceoVmuvEdPtA6fJOEQdZKYnOTFKOtl29WPJIJjB8T03RsMnKf9NCF0RqFwM8OLsPM1L1uQy68diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD3on4oTHC432/YWAIlLOiG3JJ2eTP+/w6RX/SSAjqM=;
 b=JyZIHKQsINJvmpaT4eUZuFU9Bn5ceGq5qR1W0kycf617enyLlcDphO7j+fKMIQKmKUCrOWV6yMOFW9/FgOBnuht+cAxg9xZhKaRYkb2eq5ugelL/jTfCqAGcoPD6s52lTngbJZpOO5+H9IMpouWeu6Z9PpZFCJgGe85uw1pylt3S3NwLrDbKHEyqqTDYX4cdiSABtyfUseFwwtSr2t4MIOuNfnvwrw3qoBN59jFMA6ttDsDuvSdpVwpSD3IF6lufz1JgQNlAxOmfrLp5F9+kMDI/7KUPtd+ObLq50yoyi/kB1OIx1IwTuBSERFEZnCkSqkC4Cx6ns4C3PJ8lAOBUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD3on4oTHC432/YWAIlLOiG3JJ2eTP+/w6RX/SSAjqM=;
 b=GVGhEgOIr18nd858NIumeXVCeW9s8j00uSP6Qfr+hMWofeZyr0K82CbtcSS/1JE8cevWZVJctgnIeBYxZhCBcqHrigEVG43eUQF/Xo0gXrrAwAQfJSgu1/tDC+Mu7TOmGugMIiY0uYF4nDukOLloOoZXVpyI+7tpayLnS+ylHsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:15:42 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 19:15:41 +0000
Message-ID: <a285c8f8-3276-4628-88b1-a0bc18da5049@amd.com>
Date: Tue, 14 Oct 2025 14:15:40 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/2] Incorporate DRAM address in EDAC messages
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
 john.allen@amd.com, linux-kernel@vger.kernel.org,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
 <20251013220019.GFaO12cwSvbedQwGr6@fat_crate.local>
 <20251014135206.GA361227@yaz-khff2.amd.com>
 <e78b6556-24c0-469b-81d5-98380aee1f6b@amd.com>
 <20251014175238.GIaO6N5sWpG7EReE5P@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251014175238.GIaO6N5sWpG7EReE5P@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:5:190::18) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d91f20-a762-4456-e151-08de0b561101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWpxSzVKRmhrVmxTazU1UEJpUjBZcy9hQjVremtOSHVrbElxTGI0RVZLVWRH?=
 =?utf-8?B?eXJ4ODB1cTdzcU9JWmFYbUdhWHd1MnlOTzloQzZWWWhud3VaUDV0Y0VHZkFv?=
 =?utf-8?B?N2R6T29GTlRYeEZCRkpNTzNqNUIrOFhNN3I1WmUvbmg5QmFnNkRoYnBiQy9z?=
 =?utf-8?B?eHVQaWpVWDlJK1I5eStDK2FodjhqV0l3eHl2Rm1TVFJPaGNZMElSMTJPZWx2?=
 =?utf-8?B?UENXY1lOaGc1cTI3MitwK0krWTg1dGtkbHZZamFtQld1MmhZd2QwYlhFWmhj?=
 =?utf-8?B?cnFQNnZxQi9BWFJHbXk3TmpGaVBHaFE1NnlNR0RvUW9mcmdLdEVEVFBmaFdZ?=
 =?utf-8?B?SlF6aWZHbjIrYjV5K2ljZXhhbEFVbEQwQmJHbW1NZWV5ckcremlIWngxWDZQ?=
 =?utf-8?B?TGNPOWMzUGp4c3F3QVlQeUVkeFFLVTV0M0FNVWxTL0txWElnanc5alhKZWdq?=
 =?utf-8?B?SUlzZGdiOFcwcFVjOE9pSEpMZk1FTnVibHVIRXh3NXZMZ2tLdGVkR2dNK3Bn?=
 =?utf-8?B?NVIvYVpPTDdPZk9CaXIrVGdFNVlkcjFBMTcwMWR4K1ZoQmd4VEJHKzVqb0hz?=
 =?utf-8?B?aFAzTDFNNGMybHBnbE9pTE5wVElRN1VmUzlUWkdhTUpLMkhyOUMrcGs2K3lp?=
 =?utf-8?B?WjFHZVZzaWpUR2VGaVV0VWVFVTdGc3dKOFIzMkdpNlRnTDdCMzNHTFVZM0pL?=
 =?utf-8?B?ZURXYXJtUlVOa3g0K0JzK21uakpIY3p0eE5icTc4bU15aDhwTzdxL1Z6Wmg1?=
 =?utf-8?B?MFNSNE5LTkI3T08zeTk0NXZLVWgza29JeEJjRXE4aVpoUjloS3pvOTF3RUM3?=
 =?utf-8?B?d0VLWEoxRm4yYUp4eVppbW9vblZubXdSUThMSXcyQWZUQ3hKTlBMOTBjNHM2?=
 =?utf-8?B?Wmh3NzZYOFN3MXEyVW9rMVFQRkpzTlpHcFJNSlUwQ2NwRXdFSHN2S24xbjhy?=
 =?utf-8?B?UDd1eEJYalVwanhJdWgyb20yNU5TT3UxUGJsbXhVaHN2T1JmVDloS1B1Nkt0?=
 =?utf-8?B?TzhycVpGUUpNVE9QRHRNNHVYQ25XMlVuUzc1S2htNkhaeWQyTCtoYk9DdFMy?=
 =?utf-8?B?MDlKS2RZOE52WFVWT1JPVXd0K1prQVU5MWhTWnR5YU1PMG45MnY1NFRCZ0ZD?=
 =?utf-8?B?N2FBZTRzaVVPbS8zMlRqVExSNzVacWtCSUNSaUNTNFliZVhsMWVjQnNXWWF3?=
 =?utf-8?B?MFI2THlzR0NDTGgrM1pveWN2Y3VCb1BPSTVFbVpzeEZyQWhQY2E5OFRBNVo2?=
 =?utf-8?B?cGo0RlV1eDZvOG43b3Y5QkdNTWkyU1hiWEtGcldLS2FLT29BNUZab2JkalhE?=
 =?utf-8?B?YTBEc2ZQUU9IYUpOYjlLaE14Wm9idkhNZFpoaEh3SHF4azI1SjNyTEtBZDJJ?=
 =?utf-8?B?QTgvNUNlMzdnVUg2NFI4N1N3MFJHQ214cGRTQkN0clp6TVRYNmtPVkt2RVNV?=
 =?utf-8?B?ZUhJUkprWmNnL2JrWE5hL3V4SDkxdGQxOXkxcmh3NEtnMHhGczQ4Nlo3UTY1?=
 =?utf-8?B?dDVIbWJzWnBCM1NoNDVXSTY1SStGVVhadzl3TjFhWi9zTkUrcGN1d3RoZXU1?=
 =?utf-8?B?cElmTFNJcnVVcFVTSVVHUDVzSGNKV3dkdEs4S2FtTVNmUXV5bjh3T3dtdmFv?=
 =?utf-8?B?TkNWNFBKZ2NQZndCL0F5NWJqUDFYTGRIWTVPMjFuQ3gxRHJMR2RPYmFQOEFU?=
 =?utf-8?B?Sm1saXhzUHowYmUrUDVqSlphM2V5Rmt4YlltaXhTUmN2cVRjdHpudTRINU56?=
 =?utf-8?B?Ly9jQ2Y5dnBUSytHeFpWeFNud255ZFBQYmZuankrYmtCTVF1NDdNOHlpRDVO?=
 =?utf-8?B?cm1ydHo4OHl3dDFXKzl6TWxCNFhFbzA2RTMxdDJSemFYdkRtenBTUXZkTUYy?=
 =?utf-8?B?ZjNib3R3WVFHdEtNQ1hvZk15NjlWc0xRY28yV3ZrazVJY3hWMjhGckR5Nngx?=
 =?utf-8?Q?A6J0iYnySixJdosmuy+CLMxq2oFmTmww?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzR2dm4vZThMNSsycVB5WUlZK3lVQXYvRjhveXd3SmhRRzljUHNORWRKSVBU?=
 =?utf-8?B?TGp4ckRTSEROSUlyYjN0N2YwMm95NzYwOXRkRW9UWFFpTXFISDUzQm52aUlv?=
 =?utf-8?B?SkxSOEJORXgydXlzR2JQeXVGMkJDWnF1V3FQTE56TUxaQUVzVWVDU2UvdVow?=
 =?utf-8?B?QzROc3M3OUF1bFZWWFFLeTdIeGVPYjlHemlnU29RWTU5UTRyck9nSG42R09D?=
 =?utf-8?B?TEg5ZU16ZE54eG9VYTliQnpLYjQwdUZUZHZsdmNQMVhqZ3ZENUM3b09LeCtE?=
 =?utf-8?B?dkszOUM5QTVIYm0wOTJoVG9TNVh5OXlmUG8xZXNCdDAvc05SQUJjT1FIU3k2?=
 =?utf-8?B?RER4MmZhaFdOR1NUWHROdm10dkRIdkYrcVZtaXFjeUJVMEczcmdLN3hjWCtP?=
 =?utf-8?B?U0IvRTlIZS9qUW9zeDMwS2F6Q29MS3BmTWVNd2JXclp6U05sVzBNcy82UEhs?=
 =?utf-8?B?ZzRFTjVnWU9IaTVWK2dNeXVsYXdWa0JxbE9HVldDM3RRaENmR3YrR2ovc25x?=
 =?utf-8?B?QnRnMVRURjFwR29zK2pNVE9scXNHVEdlTWd5L0VpR0VqL05OM1ZBSFp3bWU0?=
 =?utf-8?B?R0Q0bmoycUVaaFBDQ2R3dmpJamlsWjUyNkg2SS9NVTBHbGdDZGpzc3pZb3BC?=
 =?utf-8?B?R2J2cVlpRFZSaTZpVDJuQ3E1UWVuYWkydDgzQ1pMQnhSeFEwTUdZL1J1OS9v?=
 =?utf-8?B?RHQ4UStrLzBqSys4MTdGR2N3SCtKdXVvdzdvSUorZEExVDhzU3gvL2NKQWRW?=
 =?utf-8?B?Z3p6NFlCMUFEUnpYQjRqMTlBSEY5MCtVTjkxNVdIMlRTY0c0Y2xVMWtUbXow?=
 =?utf-8?B?bXdlT2RSTmFQV1lrUUhXNTNBMklyZWRWZkNrcW9wcWd6Y0xZTTh3Z0lrbUk5?=
 =?utf-8?B?YS8yS3NkcUJUV3pUZ0FzaEdTVzZRVTVvaVRGb3lTYnBBK2Z0dm9LMkhPK1Q1?=
 =?utf-8?B?eUNHc1VxTUlueFhnaVY5RnlOdU5TMTE5OEw1YjRhY25Wd3ZvNmN4SXhUMmpo?=
 =?utf-8?B?YjdYcTZQZWZvU3JNQmNlWWdtMnNOSVJWRDBSVHFRWGJGUjZRdlRuZGFmSEV3?=
 =?utf-8?B?bmlTNnZBTEtCcVpYbkpvM2N3cGt1Tml2c1Bmc2xDUFhlMU5kbjM3VjlKdXZO?=
 =?utf-8?B?UWJWY3FWcC9SZjAzYks2MGVIT0g5blR3MHgxRWQrRVh5UUZNTW8xWlAxMExh?=
 =?utf-8?B?VlpnSGp0ZnArMDVBeGVRSWFzRXhZSk1sR04vdDVZK2l2bWNOZnBhSnBNdlcr?=
 =?utf-8?B?MUJRNnBHeTJpMURvRlAzYlJoeXlpRm8xMndBc1RQLzhXSE1Hc3dpc2p3b3hU?=
 =?utf-8?B?NFBHK1FSUTFtZE9oV1FvbTlsUGtxbzZIblhOckFDQXRUbXU5Um1zbXQwT2dY?=
 =?utf-8?B?YWNjay9KS01hSEd0dENCTVRMVmJFKzB4bElUTy9hc1dhVkFkaGs3aFVpcjlQ?=
 =?utf-8?B?bTh0RUlFaDM4a2VkT0kxQXB5a21YZEVFK0dBQ2NTeWxUUmQ1bDFuUXVOYnZu?=
 =?utf-8?B?eW1jekxDMXZSTjNncmFHSFNkenFPd3lCbnAycXc4RjJLSnI1Nktha3ppck5v?=
 =?utf-8?B?V2ovOUE1bG9LQ041TUJaaVVJdVFoWUZCeVJqcmkwcXQ3Zmxaa3ZmNldGeEdi?=
 =?utf-8?B?UUZVTE5FbFBFMFduYm4wK3o4c2cwUnQwTW5XQjhmS3Y0KytSTTR2VU5DWTFn?=
 =?utf-8?B?TDhYa1k3eHM2TCt3N2h5cjc0ejYwNFg1OG9rdG55MURqVHVkMUJuY0JvbG1I?=
 =?utf-8?B?ZXhGV2JOenZLZUtWVHkzTXNZNmwxZ2V6d0JIMlN3ZVVQdUdKdUNMN0xZMFlx?=
 =?utf-8?B?RkloZmZ2eUxlNFhZbXJrdWpNekNhOE9pV21sZ0pISkt5cUN4dkYybzRLeWpu?=
 =?utf-8?B?VUxPaVZ2dGFUeVExRFZFTVViNnFQVDI5MG1YR29YTXZyV25wdTBMVzkxdnc4?=
 =?utf-8?B?UmxqOWx3L0VPVlJVUE1ZVnVuT0hQMU1HU1dWU0hjUytTakl4anR6U3dCa09M?=
 =?utf-8?B?c1lwcUU0WGQwd0hiUk5GbTlybW1oYStPL3QrRzdnNzVWQnBjZHhZcmlPdkhj?=
 =?utf-8?B?eWNjNkNqYUdCNklqV0htR0Q3aFRlTTloTGRZaU5MOGwycllxZXBZOTdCUWty?=
 =?utf-8?Q?0sQN9JBp5cU45b7zWtG9u9zXr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d91f20-a762-4456-e151-08de0b561101
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:15:41.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxEldKf0XtCaKpq1vbsusGjwKjHWHNcB9/cZJGwLZE0g1RpHQ+UVJpGUq8bO04eBABMCjFCXCYmX3/fUv+vvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302



On 10/14/2025 12:52, Borislav Petkov wrote:
> On Tue, Oct 14, 2025 at 12:13:36PM -0500, Naik, Avadhut wrote:
>>> The "DRAM address" helps memory vendors analyze failures. System
>>> builders want to collect this data and pass it along to the memory
>>> vendors.
> 
> How real is such a use case? It sounds to me like wishful thinking and that no
> one is going to use it in the end and we'll end up warming up the universe
> with electrons needlessly...
> 
>>> The DRAM address is not contained in architectural data like
>>> MCA info, and getting the address from MCA requires using additional
>>> system-specific hardware info. It's much more reliable to get the DRAM
>>> address from the system with the error rather than try to post-process
>>> it later.
> 
> Ok, a bit better.
> 
> Now, why isn't that address part of the tracepoint so that system builders can
> consume structured data instead of parsing scnprintf()-ed strings and trying
> to guess what's there?
> 
> Also, some of the fields of TRACE_EVENT(mce_record already contain the fields
> this set is adding - CS or so, for example. So there's redundancy already.
> 

Currently, it is being exported through the RAS tracepoint along with the physical
address. Example snippet below:

     kworker/4:1-3950    [004] ..... 84373.064068: mc_event: 1 Corrected error: on mc#0csrow#0channel#9 (mc:0 location:0:9:-1 address:0x9ffff000 grain:64 syndrome:0x00000001 Cs: 0x0 Bank Grp: 0x0 Bank Addr: 0x1f Row: 0x27f Column: 0x7e0 RankMul: 0x0 SubChannel: 0x0)

Would you rather have it exported through the mce_record tracepoint?

>> If yes, will add this information to commit messages and resend.
> 
> When that happens, remove all text gunk which talks about what a patch does
> - that should be visible from the diff.
> 
> And this is not the first time I'm saying this: folks, please stop explaining
> the code.
> 
Will do.
> Thx.
> 

-- 
Thanks,
Avadhut Naik


