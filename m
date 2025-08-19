Return-Path: <linux-edac+bounces-4603-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615E9B2BD9D
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4096B1664A1
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4BA319877;
	Tue, 19 Aug 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8KgbZco"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A4270EC5
	for <linux-edac@vger.kernel.org>; Tue, 19 Aug 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596397; cv=fail; b=LKE7Dgi0LnOyHCATRYrTCurbvR9/K7BEw0hCButrwlJiGsQ10usCWA/YU4FY76d+v2TG+1pFjWI9QTzO0PaomtXOJLEmh2SQ0H+QAHi0N1fMaOFcE963WdtuZxd9eEmuRjYSkns7xGzvAVU3GqOyM8jQUXBEh0RNXtd9avaua3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596397; c=relaxed/simple;
	bh=4Swxh5UmApFX/YLhlpyY5tyUviNF3aE0arrcG8/MRsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d21IkkROJ5I6GO0ZibjFPATEi0TtPsL8qjTZmSYwlJpq6mNELtBI+B1uaPCDNaQEpWinShr0GZQmHC+Iw7CKm2ta3aIdtMXE2y6ylAzpCvGnDUXHRcvTQ/lVNycAlwMk5G1MKL/vw/qWAF68SBiNTC/yQ6ZDm+7aza2MhLgP908=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H8KgbZco; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWO/T6RUo5ds5xcnAgF5x9a6r+5yJjK1JMEVoU+O0Z0rGcZ0Syxylwf40d2PAyFoqmE4ZJ1y211mDAz0PTinUNcAjFDTYVoCtMFCIx7LW4Hp6FV31xUrDRguK97tVVvDXroogbHGXH2cVVWR8mrziFWD5gczkfRFpHlf7DTLFXuT/XotQxhOmybPbhZ/r4vK1u+B9viCmWAdGGjdzvioDnJdDBNclROfQQYsLhiIAnhLR568hkpaatxYHhpdMsjWBVK4qOV9p9Ef6qaORO1sQ4xbXXTKWOnE20lZigieX7RtJpVFqrew9efbhd9jDke42nWmJLKWaBexTe2a0k0ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Swxh5UmApFX/YLhlpyY5tyUviNF3aE0arrcG8/MRsg=;
 b=v7g0nKjRet0rMieKMnVOV6rijH1SvA9jyRutx2LCqUvC157C4tWPdw/pWW6zQN8vKIm6BB2ZhkMsjHuKcSUC1D7rfFUzotKRa2cJN7/GJeYUiD3ixbc/QJbhQFgQdI0ct6hY2QZ/tYBp7ZjgNkHlMHHDz9TEtr78KbVTKdwz4GTIOHnTzbXAUlJihkeIxPIdl2EDnpwsdlO5JzQ3HlPZNgOmRcgAODJo8xIJ/cAcz9p+ZyB4xm5w4iMQxWlyzd3aa0dTeS4qbztmhjbDe+V1qPcaSOGu1xdzb99qm2a2aK6oq2HGoRP0POLMIVh7AD4HSNRpayRU4hV1kDCnDASG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Swxh5UmApFX/YLhlpyY5tyUviNF3aE0arrcG8/MRsg=;
 b=H8KgbZcobxvAOfOESjeWun90DZcj03IDb0AiDRdpK/ZEYkYlCtme9mp65CD5C8P6BIy3I2p4fhwKiN52Jt1dYM1XOIpignD1gMhzcTibXq4/apgcS+vrMX0JH3SlDIN3QemlXX4zCm6en/YSicW81E4nFsB4I/OVJWif3ZMRrUU=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:39:53 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::da9c:134a:e7fc:497f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::da9c:134a:e7fc:497f%3]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 09:39:53 +0000
From: "Veggalam, Rama Devi" <rama.devi.veggalam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: RE: Re: [PATCH 0/6] Add support for Versal Xilsem edac
Thread-Topic: Re: [PATCH 0/6] Add support for Versal Xilsem edac
Thread-Index: AQHbs6L51LuFTsKa4kiAcNvdFZfrHrOv7Z2AgLKrg7CAAAwjgIAHzWZQ
Date: Tue, 19 Aug 2025 09:39:52 +0000
Message-ID:
 <DM6PR12MB4250901726B5F460AA12426CCE30A@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20250422171737.GAaAfPMbFtNKN6paJT@renoirsky.local>
 <MN2PR12MB42539E64E1CF2BFD2058DC50CE35A@MN2PR12MB4253.namprd12.prod.outlook.com>
 <20250814102909.GBaJ26dZzvSs9usTKm@fat_crate.local>
In-Reply-To: <20250814102909.GBaJ26dZzvSs9usTKm@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T09:38:06.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4250:EE_|LV8PR12MB9451:EE_
x-ms-office365-filtering-correlation-id: d7924aa9-cb68-4ca2-484f-08dddf045974
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjBVSTMzNlZXWTlFNlVwV1R4SzM5ak9qdCttSFVRNC8xZlpEQVpzaFlqU1hk?=
 =?utf-8?B?ZzZ2YkFMU25VbXlSTnl6SE12c3V4Tzdac3d3V3F5ZzRwRHp5Y01ZNTBFV0R3?=
 =?utf-8?B?d1NQclBqVUREaCtBRG9yUEVLZkw5SlN6QVByMWxTaU50bTdCcjcrZmlrT0JF?=
 =?utf-8?B?VG43WmZocDJuRy9GNG1mOWlITG9tTGpqREJkckdFNVNreWZzWkE3OHArbXRK?=
 =?utf-8?B?bGlNOUZIbmQzWW8rYTQwWmVyNjVLRWVyTFN0bnpWdXI2ZjRMYzFvOVhPUXYy?=
 =?utf-8?B?OFJnZWIzUW1MQlRrWkhNaXJLQ2VET25TQTgyak55cGJzckFTZEJuL3RzdHhm?=
 =?utf-8?B?WUNDY3ZCcXpEd1ZWNDhCMXRWRFRHdU1KM2tWRTNZMGU0UjJ0WFY5ZEdwVEtC?=
 =?utf-8?B?dVF4alA3ZkZBdnU1R05raGl6elNrTnRUYitsT29KL09scTFRWFk0SlhURDN4?=
 =?utf-8?B?T0pMdkJOTmNNV3p0ZkszeFJ2aXFjL0RxZjVDM0s5ZUZDMmZaakRaYmJBL2xr?=
 =?utf-8?B?UzBOcHVCdC93QXdZUVJTSDNRcW4xMVZMcW1QTUpaU0J5VlB5Vk13MDNTaGJH?=
 =?utf-8?B?cHZnZHdsYmlBRDlyQnhBanlUSWxGYzJINGNxaU1pajZidWdpYWZIaHFOWkNa?=
 =?utf-8?B?R2FGNms0UGVDRCtPViswUlh3Y1hGcHhzV1REektib0VtaEhDN2RqU3ErMVRQ?=
 =?utf-8?B?RWw3a3lHcmtsWUQ4NE9pTGNnZnJTKzJSZFpkelJrR2JRZHdiaEN0VVE4bE1F?=
 =?utf-8?B?M1hLVGJDVkg2NmdGM1BnTTA4bnlzOHpVL09TMDU4Qm1DWjM4QmVqSG54cjFS?=
 =?utf-8?B?LzNtMk1nWVRDbGlaRk9RZk13QXM4QVYzdytWTk10SHNmNSt4SzB3eEdFbkxS?=
 =?utf-8?B?ZkZOWUtVMXF1SWdkUTRXc0g5S1I2cXAyNndZV3ArcHFFN1pjRzI2MityQ2Zy?=
 =?utf-8?B?QUZTeW8vRUgxbkJjcmtZS1lPcVNSZGZCWVZWVjFhYXRKTXdhWmZvZEtDS3lz?=
 =?utf-8?B?L01qM3dBOElvTW5TSS9hYUdpK0FSNythcTZCZmZHUzRibTNLcnVUZGNQME90?=
 =?utf-8?B?a2Z2TzdRSGNjcFdJSEZBdUhZblRkcExBVVZIL2FrZXhUejNPVEw1cFA4Q0Ju?=
 =?utf-8?B?Y3JjWGZqK0xobGNFL0JERDNzcW5GTkpUbjBJN0o1aWJvV09PWVRrT1A5L0p6?=
 =?utf-8?B?cFBwNzR5dnlSMWtHNFFvQ2FGRi8wSWI0MVV5bkdVckV4dWtwOURDc2dwZ3ZZ?=
 =?utf-8?B?MFRCMzEwU3NZRGRqQXhiOGhIYUQ3YTUvYktPdDNnZEp4eU40bjNIbWdzUkJm?=
 =?utf-8?B?L1B6cjBQVE1Mekg1VmdMcjBqUDBNbmYrUU1FS2tVN3VBY3dkSVp2SlpKb2F4?=
 =?utf-8?B?NDdaVksyWnIvTW9IOFQ4VU1weFR2ZTE1VmszcTF1ampHR3F5OTJ0RGVFcWJM?=
 =?utf-8?B?eWdlYVA2QlUyOCtVNHpocWV1c0xNeTFMaEw2T09Kd21ubzlNYUNaemJZYVRO?=
 =?utf-8?B?QzBWWm1MQVFHZzNIR0wxOXNzTHpNOXRMZEVrdTBNaGM0S2hQZWpsa0p2c2d3?=
 =?utf-8?B?L0lxV0tYQWVNY3Nwem9WbjJ6NFhjVG9iVHArdlRrV0R1b0QzYWFUdjl1dmpW?=
 =?utf-8?B?SEEvNmFJYlVQM3pMVTVMKzlzYzJ4Vkh5MlRDWFN2bm1FV3lCNFJhdHZtMWpW?=
 =?utf-8?B?bitrcXBJS1c3b3g1Mkt6TWtia3pqVFpvUEhIa1ZpSXdadWVqQ2FFWDlQQWF1?=
 =?utf-8?B?alpBN1dPdktFUHNhMlg3ZWdIcnU2TEtCNjFPeEsxaEZwT0RGR3R6dW1zMkJi?=
 =?utf-8?B?TG14aVRSL1IvVG96SUs5TnRqNlVNalc0K210QVNDMGZDMVJkeGY5bWVQNTl0?=
 =?utf-8?B?dUo4NjBMRXN1bFZzdFA3a09LSmc4ZGZBcU9YdmwxeDIyMTR2eTd1ZndMdThi?=
 =?utf-8?Q?V2Jc9zWGcQI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXlTbW84VUhmdXFDRkJoSVBWMFAxek1mWWdCWURIaFFqT1lKd3puaXFyOHV1?=
 =?utf-8?B?bWUyU2JPTytQSzBSdmJReENSeUJWMzFDN3VKaTlPbWlNcXZPY2ZmNG5lQWtV?=
 =?utf-8?B?N1FhVHoyckNOS2g0NVhIUCtZY1VYY1ZwMkdUS0NuR3d6ZDdRRVgzSTJ0bDJE?=
 =?utf-8?B?czJDbVF5V3ZOdDJFM1Z3TTBZc0xZZFFjbStwNm5NdHNLKzVtVllCYnFkUVRT?=
 =?utf-8?B?QzEwY3JWY1k3a0RwOUZpV3NUUFJwWnp1c3JTY1ZpNzljU1QxSmZCUXRQcFZs?=
 =?utf-8?B?Q0dUN0lQaWgwZlZsMEF6SkExZDBQQ3VUaHFMTWJQa1Z3SXZYbWExOVc4dHFN?=
 =?utf-8?B?Y2Z6ZnZGdStTWFJiSGpIVThya1hJQVJHZk45amFSVklJZjNZdmZCUSt4Y0Nz?=
 =?utf-8?B?dkJpcmtIK1ZaQzFKWExvNHJ6SlJIdjIyZ3lCWUwwTFJObGhGWm1MeDBYaDdR?=
 =?utf-8?B?RE5laWdkS0thTHlTVVArdDhxZHJEWFNCSnBVRDFGVlNvcHJvVHhjUVpXR3cw?=
 =?utf-8?B?MUlvaXRiYWpoVzJBVGtUdjRvY1gxK044SjJjNk1RWm9qZlpYRzRNYXJpdTVW?=
 =?utf-8?B?MXltdU1qZWdNcDFqQ0wvTWJDUlIzUmNMdGhVWUhIRUdTL0laaWxSbmVPdGFG?=
 =?utf-8?B?V3B2dTc4T1Y4SnBIY3N1dVpBZXlZZWRFSit2SU1tbkhvOCtLYyswV251VnY1?=
 =?utf-8?B?V2dPNDAydTdYb3ljQkRVdXhuMjVwNThwNHpiWnY2RElzTzlSa1prc3NuSkV5?=
 =?utf-8?B?YmpnTEV6eFlEclBNbkQ5cnFhOTkzL3o3TkdNNXQ0TGRWajBvMVBSelJwRTBK?=
 =?utf-8?B?Z2l0aVFVWUtaY3pSeDlNWlFERVFVS2lrWVZCL1NRdDUxNlZURFluK0g2U0tT?=
 =?utf-8?B?RHoxRjVCZk9Qcm9MSDBxTjczcjY1cnRJWklMSmpFdWNabU5YZUJibFB6VFp3?=
 =?utf-8?B?S0JwUGM1MnZtQ2R0bjdPVklOOS9ienZZQWczNmF1SGJUOEdZSWlYb3VoVFoy?=
 =?utf-8?B?WHM5SmRmc1JTRXQ4eHc2dm1rV0VtUWVOOFlsVCs1cmUzR0duSWlxaGpKSVhV?=
 =?utf-8?B?dWVsbnlqeXNUbWNLL2dVcDlwdCtNUVZqZEVOZDZUQnZYQk1ranhnZng4ZmJs?=
 =?utf-8?B?MGZuNGREdSt0SzBRaDNLZVUrZGRMTUNNYXZTOGVxZS9XKzRrQlVOY0lhbExP?=
 =?utf-8?B?Wjd5dXdSUG5nT2dGRUNuaFZIR0FEQzYxMnlFQWJFOEp5S0xld282SnpzVVM0?=
 =?utf-8?B?QVp6cUtSODVYenJ0b2gwdEUwQjVaUGFQSjR0NEEvL01LMEtWU0hOc3dnY0lL?=
 =?utf-8?B?SmxsVkE4QjM1MTRIajV6eFZoWUJSZzNIN2NLL2xoTTBvMWxXNjJlSUllSzd0?=
 =?utf-8?B?bEkrTkhFOUR6OWYzc0h4N1Q1NncxSUY0VmhqSGMybTREK1ZtYVhOa3RkNUJz?=
 =?utf-8?B?YmFCTmZLK25ZRDRQa0lYTFJRS0JZd0YwQzRJWC9rb2VGOTZ3amMweTZYZ2R3?=
 =?utf-8?B?aVBCWFM3bkhzSXM5NHJMUytnSEZscHZrT0JJenZHNi9nRlZpdmVuNDF2ZlBn?=
 =?utf-8?B?RFFrY1N6YTN5cktPdHlkczhHRUNZeGVTMmdEbnlLNGhCdEZFL3R3VU9YblBo?=
 =?utf-8?B?c3NqZHZlaXpBMWJLMndBVzVJVHJYYXZEYXBJZ2dvdXJodWpHbGFkd1NTVU5K?=
 =?utf-8?B?dFlRNmlyNGNKL0w4TUFMamszT2huRk1XVEowWU1lcVhxMUtNWVZPRTZaQ0lO?=
 =?utf-8?B?RElUb1lSbVB3bU1ndU4vbVdKNHlEa25SSHVSU09jekwwYjVEYWR1MTlGbklS?=
 =?utf-8?B?Tkd6SnNIb2hQdndKREJZYXFsMXhLT3NYNVpZcklPT2lDamJ2dzY0S3hxYzFl?=
 =?utf-8?B?R0NnSjlpaVRhd1RJNGZhMlViK3RqR0owb0xqa0ZsMmh6ejA4c2pUUkZ1SUdL?=
 =?utf-8?B?aGV2ZUhLa1JoK2llQnpUY3AxOW9Kc2UyZTZBSFVWZEpCNXdDbWk3Yjh0ejgr?=
 =?utf-8?B?M3lRVWFMTjIyN2k2RitvWW1maEw1cHAxcVhscmRCeWY1cU9rREJxYXNJWjJv?=
 =?utf-8?B?cW5FdXJiRi9YYkg1VXBvS2FqQU1pRDgxOHRZUDhjUmZJUmF2NnZGVXdKWW5h?=
 =?utf-8?Q?PZe4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7924aa9-cb68-4ca2-484f-08dddf045974
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 09:39:52.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjDGq4FYgC9QysfPyfN3e0VUTXor2SYTiW3fQSlf8RNsmg+BzBuvTACyT9FrafxWfl+xYZZjoJqxm3EtX5oIYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQm9yaXMsDQoNClllcywgWGlsU0VNIGlzIGZvciBWZXJzYWwgZGV2aWNlcy4NCkkgd2ls
bCBhZGQgdGhlIFhpbFNFTSBzdHVmZiB0byBWZXJzYWxfZWRhYyBhbmQgcmVsZWFzZSBuZXh0IHZl
cnNpb24gb2YgcGF0Y2guDQoNClRoYW5rcywNClJhbWENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDog
VGh1cnNkYXksIEF1Z3VzdCAxNCwgMjAyNSAzOjU5IFBNDQo+IFRvOiBWZWdnYWxhbSwgUmFtYSBE
ZXZpIDxyYW1hLmRldmkudmVnZ2FsYW1AYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5r
ZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IFBhbmRl
eSwgUmFkaGV5IFNoeWFtIDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+OyBnaXQgKEFNRC1Y
aWxpbngpDQo+IDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFJlOiBbUEFUQ0ggMC82XSBB
ZGQgc3VwcG9ydCBmb3IgVmVyc2FsIFhpbHNlbSBlZGFjDQo+DQo+IENhdXRpb246IFRoaXMgbWVz
c2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRp
b24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9u
ZGluZy4NCj4NCj4NCj4gT24gVGh1LCBBdWcgMTQsIDIwMjUgYXQgMDk6NDU6NDRBTSArMDAwMCwg
VmVnZ2FsYW0sIFJhbWEgRGV2aSB3cm90ZToNCj4gPiBbUmFtYV06ICBWZXJzYWwgRURBQyBpcyBm
b3IgVmVyc2FsIEREUiBtZW1vcnkgY29udHJvbGxlci4gIFhpbFNFTSBFREFDDQo+ID4gaXMgZm9y
IENvbmZpZ3VyYXRpb24gUkFNIGluIFByb2dyYW1tYWJsZSBsb2dpYyAoUEwpIGFuZCBOUEkgUmVn
aXN0ZXJzIHNjYW4uDQo+ID4gQm90aCBhcmUgZnVuY3Rpb25hbGx5IGRpZmZlcmVudC4gU28sIHdl
IGhhdmUgY3JlYXRlZCBzZXBhcmF0ZWx5LiAgLg0KPg0KPiBFREFDIGRyaXZlcnMgaGF2ZSBzdXBw
b3J0IGZvciBtdWx0aXBsZSBodyBSQVMgY29tcG9uZW50cyBpbiBhIHNpbmdsZSBkcml2ZXIuDQo+
DQo+IFRoZSBzdHVmZiB5b3Ugd2FubmEgZHJpdmUgaXMgc3RpbGwgcGFydCBvZiBWZXJzYWwsIHJp
Z2h0Pw0KPg0KPiBTbyB3aGF0J3MgdGhlIHByb2JsZW0gd2l0aCBhZGRpbmcgaXQgdG8gdmVyc2Fs
X2VkYWM/DQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0
cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==

