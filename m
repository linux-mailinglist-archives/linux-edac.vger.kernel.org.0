Return-Path: <linux-edac+bounces-4446-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAEB1221C
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jul 2025 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2FA5A047E
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jul 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EB2EF655;
	Fri, 25 Jul 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="I97inzlD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D032EE975;
	Fri, 25 Jul 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461390; cv=fail; b=l/wEYTmgPNHxBmcb4+bJIglYysC+kWTIhpUmeTMqwJE1Y9jqB7fqblK4M5ArcGokDc9k5ltBz2ihxMgqJzAIs+QTGGvOmsgqyLG9Qz0iyPIl2RNuaYkpuftgDZ1Wt5Lmrb9L+jMx85lQo41VfUQhoSI/4EUvox6KKLmaiZD+gv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461390; c=relaxed/simple;
	bh=U1Hb5mrf9C0bpP4eIMNF8RXLEMv4ybVrXwTLXzX6sX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CevzCNRTG6B8a5W/dwuPZTbT4hO6G4Ck+RRI8jfMBXnBmhVPA6p6m2Na+hdUKt2cr1JaoQJE645u/yyCLYi8XFQnBTlHLzDMugOK/TRnJmwa6WGua6OhzJPhUVSg8fY5neaEgCRqOLBJWQp76DVzCsxJul8cRYTC5ZKhPo1V2/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=I97inzlD; arc=fail smtp.client-ip=40.107.220.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOnNgj6FZQD8agSXL31TNHhjOmlAM265gakfwR0FFst3yQxFwX8/wK7+DZNW02PRPghcSjz0cgI46krfVS6Ux4PVuOPOr+TlYBUI4vuWLeW5tiIOrGFrbAs0cHgjDguErm4MeB/1DUx/YIwf0Typ9/MoaqYo/mUhAGPTIRLrqx0b1b3fSzLURt4Wd1qWwsg0JtQvPgE3ttVyu/cjo5VUqlZ5G7F6pe3WaB0C0wZ95W3rTEEEYDIgry5jLd1tK0qkGaPMYRTHliZCeIkZgXRX6k0u4pFZzujpgd8n3yTZ0jZxa1pqtOx0pVhGUqcr8mlfbYiCKPFGNy++at6yPlAbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moaYw1ymJHKYjs1PqoNE8VVev6FJWZ0jiweSMfF+zr0=;
 b=wZrAR5uIj3xyBgaEe7dnpT5DS37zwt4fit0loh37KpjYnxHYRL62K3WL1P+sdV/qw31/x2XtoeJ77vDnY4eszjynJdXy3r63mCJpv82FSOE3Ia0BlbwlZNLU5L2vCf90X1MbJgLA33JGpBL9bH/6wcEXKbkAY9HRye3JnfZHDLxvuN7kNdaVBPXZ3xmojCgn/5TxkbLV1SHDtmossWCGYLXmh7lL92MKDMPqk/wQ13Hk5LPm0RrdNVCADn6KIhdh8STTVRvou35tQEqcgQglbmoDLYIJ7SRlahb5l+N2wvmkRwRc3Aa6cG0CTQgjxxwUQg6gkC0NExxKuTRv1Ed9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moaYw1ymJHKYjs1PqoNE8VVev6FJWZ0jiweSMfF+zr0=;
 b=I97inzlDyrDqS2Ro44Ujgxpf2f/s3Bp1tVZGbPUK7S0qOs8xb+2pBd9I/Wxi+Wp5neGppH1+yZ7QAGtMSplzyAci8u1hlCZ8e+4PvOWetxX029s9BRPupkuubrMeOi7jFXOQFobWUwQSFYIA5woe/1V5uitcRf71mmptocUX6ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 PH0PR01MB6167.prod.exchangelabs.com (2603:10b6:510:14::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 16:36:23 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 16:36:23 +0000
Message-ID: <547ed8fb-d6b7-4b6b-a38b-bf13223971b1@os.amperecomputing.com>
Date: Fri, 25 Jul 2025 09:36:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] ras: mem: Add memory ACPI RAS2 driver
To: shiju.jose@huawei.com, rafael@kernel.org, linux-edac@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, mchehab@kernel.org
Cc: jonathan.cameron@huawei.com, linux-mm@kvack.org, linuxarm@huawei.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
 vanshikonda@os.amperecomputing.com
References: <20250617161417.1681-1-shiju.jose@huawei.com>
 <20250617161417.1681-3-shiju.jose@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250617161417.1681-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|PH0PR01MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: ed056b2f-ab79-45b3-400c-08ddcb996480
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXdrUlF6Mm9ZcWQzd0Nva2NGTGxtN0VmUDJlN3pvMFZMYmVVZ2tRc05FaFlK?=
 =?utf-8?B?R3dsczc2Ymw1MHhXYllhQXNoQXRZMmRrOFJLaGVIS3FpL3daQ2tZak9UODU3?=
 =?utf-8?B?a05uVEszYUlqUHJpQWx0UTUzSXN1T1lpaVdDb0krVnlteGdVRk5SbHV3eTZn?=
 =?utf-8?B?Q1BpVy9HemovQW9Fcnp1UHVtVWFhdzZNYmIzVXBqVzA4bHBLcC96MkZ4SDd5?=
 =?utf-8?B?UGZNSWpRbG5GOUg1bUhpbXJRNWpCSjRVTEZwV3JCNHpKdDB1UFZtb0hHSFF2?=
 =?utf-8?B?MzlITk4zbzJTT1ZhUnVZMnFQaDFzMU1SdUVlaDJ3VkFXZ1JHL3pXWHA2TW5a?=
 =?utf-8?B?UitjN2c5L012dFlubTZEVUx3NGtXSS9aN0lyelJnM3pMbkpSb2hNZXFoc0to?=
 =?utf-8?B?dmpTV1RNZ0ppM1haalhrZnc1NURqT0Z6TnVsY2RXNm5YOTZ2Q3ZPUzBqaXFa?=
 =?utf-8?B?M2pzblBwaXhXMDVtZ1JUbUcrYjJmc0ViQ0Q5dXlQM0tkeGZqcit2OTRNZXF1?=
 =?utf-8?B?WnNRemlFMXE5MlozR05ndU40MTluMTFvZFRWa3U5L2grUU00TjRoUCt0cjR6?=
 =?utf-8?B?WU9DbGpnanFxbTRDZTg4WWI5MmtpS3N6VVE4UkJpK1JySmtsbWFEV0FCUHBM?=
 =?utf-8?B?ZHJVQnhJNjlYREhOVncrdFJuTmVyQit2L1lJNUVTL2R4ckJKV2ludzRUZzZN?=
 =?utf-8?B?ZEdhaUZKaDFRQ1h0M2RHWjB1bzdUNk1FdTA5Smd3Z0s2VWxsZklBeVN0UVYz?=
 =?utf-8?B?clhDTlk1cyt0N2E5Ly9mR0c3WXJEMm1oVEZwUnRSSS9oWVBCL3V3dHI1TUdh?=
 =?utf-8?B?TXhReTNPRnFFT2NLRFZlZDh5ZEJqdE5xOElPb3V4YzVWSXI2emFtU3l2VXdI?=
 =?utf-8?B?WnZhcTNlRUw2ZXBSempaZGlFNG9ncFBrdWFYbitwc1NBNTNYTjV2N0lRQ09B?=
 =?utf-8?B?cWE2S1dHL1VwdzlIdDhLNjhHcnlKSVhZSkk5c1VoajVaemtMMEJYU29QSGZY?=
 =?utf-8?B?QXFBRTd6L1JOaTFEYi9IU1V6LzlFUlZpbGk0c2k2NWltZ00xc2VHSXBWRFhw?=
 =?utf-8?B?alRxaHlZaS9LOENsdlYxS051U0cvUWxPWGFLakF3ZmdHVldhTjg5ckZYekYr?=
 =?utf-8?B?eWR3cTg0cnI2bDFLLytlOElOenVRLzFQTUs1ejZaUFNTN1BUNnYwbWd2ODdp?=
 =?utf-8?B?RUNJa1V1Q3hud3ZFMzJEd01Fck1jRGF2SGowRnNscm95bEVQSTlodjBZQVEv?=
 =?utf-8?B?cTM2ODZPQ051S21FTUZjV05kN2ZlT2xYVmJPWmc4OGc3QUVLU3I2OEpuY3RQ?=
 =?utf-8?B?UjNaWlhlVlZ0NjhDbHA0ZXh0c1dHN3ZlTndST1NJWXJzaUQ3dzJ2bkY5R0pq?=
 =?utf-8?B?NThrd0Y3YkVyS1J2bFNBYTU1d2tmazZZTHpRSXdwWGVlemZCOXhNdXRrUTg1?=
 =?utf-8?B?UXpFcDRRNTB3RUlMaVpkREx5Vngvang0dUFXbm90WmdlV3dWMjl4WjRWRkFv?=
 =?utf-8?B?WUQzRnM5Z1E0V1U4OXgwZ1pJRFZRQ00yZlVYSTMzWHNuK1hld3d1RCtuaGsz?=
 =?utf-8?B?SnJ1UStRWGtmbmNVaTFDdlVnMEFqeWl0dkxoa24rdHdJNWJxMm5VMU5JZXdz?=
 =?utf-8?B?VzZ3VE83d1RHSnZsN08waVJSUnoyVWRIZ2VOcmhqSDdRYmFhUGhncDBkOEpy?=
 =?utf-8?B?cXZPQnQxZXFoaUFtYnVkeWc4emEwbGltR2Q1YXBMV203Z0pwaFlCNFNyZTFG?=
 =?utf-8?B?ZzJzV3VFU0JzNVpiaTN0VUxjR3pVbXRWUitOUkp5UCt0RWNHK1lyamtsczM0?=
 =?utf-8?B?YzFIWk8vbGdMb2d1UGhua3R4ZnFCU253Q1hUQ201WmZEVW9yM2RQRmZIZi9t?=
 =?utf-8?B?YkpoWmNhYVdJMStXeWlXZDFKQTlxbjRyZWw0VjFrWmRoTDRDR29KU3ZYN2Vt?=
 =?utf-8?B?UWRMYXFMeTlIZ1BmdGhTUzNZcVd5c2pmdzhKa0F1Wi9qK1l1RE83eUZ4MzBG?=
 =?utf-8?Q?eUzN2pAwTn1socb8uE8O+hUt+upWGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aktXa3BGMy9COS9NQy94S0ExeTNML3RDTE5SSW5HMVBKT0pHendOSldSSmhE?=
 =?utf-8?B?MHAxbTVYZmF2bU5zbkhEOHBjZ1gzQnFwQWVGM3lqVnVFL3RUbFpFa2hlV1Jy?=
 =?utf-8?B?VkdKQmt3Y1BrTm16ckRNcWRvWnp6Qkk0dU5vNmpCUEpUcnU2NzcrSXk5RVht?=
 =?utf-8?B?MWJvN1gzanVGeDRSOWl1YXRyY05BV0tSL3BBeTc3cDVkbHJuOWtrQTVnOWdk?=
 =?utf-8?B?RVlTdG5ZaVVJelFQRlc3eVhYRDZEaXArcy9aY1RiYkcwd3FLcHM3M0wveWhB?=
 =?utf-8?B?czRoc0ZKWEk5bExHR0w0T2RYSzFCZmkwOXRjSjNOT1gwck50STVMSlZyVjRZ?=
 =?utf-8?B?WW5HSFVsQldpMW04YUlrZlF5Sm9Wazdzckh0S2ZXc3BueWlvNURzNUFIV0tw?=
 =?utf-8?B?L3hPMDYxaDlmbTdTV1NhaVJtRktlWjRsK2VjMGQwUkl3bmtDQnBhYlUzY2Zu?=
 =?utf-8?B?TDU4UGVOUk14OFNIV0FmLzJjdU05RFpuU1N2QXdMWU1wb0NCRHpLTGpSN3B4?=
 =?utf-8?B?WU9yQ1dTN0gvM2J0eGFXZ2JiaCtoaWI1QzlMNHRHcnVzNGx1VnZiY24vdkgr?=
 =?utf-8?B?VjBzVldNTUJadkphOWFsOVVZMjRxcXBRdjZsYlZreXZBeTZJUW5iQ2pYVjNa?=
 =?utf-8?B?S21PVVRWOUpCckJNMzUxQ2syRitPTExNVTNYekwzcG1pVExWUEdxM05ZakF2?=
 =?utf-8?B?UFFrVFVrNkx0eitEUEhYckIxL1Izc0VNOXlyRVZsWlQra3NGSTYySXhvRHcz?=
 =?utf-8?B?akg3QkxCRUtRRVFhT05LZ3RjVWdCQmhETzUwRVN5OUd5UkwzdWQ3T3VtT1N2?=
 =?utf-8?B?RVBya1RHQWpUMHFESU1POHlybktFWENONkdUNSthbURwbmQ2RzhQQjFobTln?=
 =?utf-8?B?VUczdUZyNHg2WXB3Z05YVWdmQ0hNQjBRNk1QUW5aOCs5c0V2TVJLV0EwY3Nh?=
 =?utf-8?B?M2Z0UVV2T09VaTRoYW9YVkFJL0FJS2ZvTTQ1bTQ4cnJkdHFEd091Tzg4bkdX?=
 =?utf-8?B?TkJzTVQvTzdYaUROTE5RWStyaDNGbVRvTkRZT2ZJSk9JMjhQbHJYTHlqanFS?=
 =?utf-8?B?RjdMSExjbTVKcmk5QVlBQTdIMWJXRlhlSWVYekp2Z2hnZ2ZTTzFnekhDaTlT?=
 =?utf-8?B?NVJ5cHFMOFNxVUgybXVZTUNwWm93bVJuaUV0M2dVVGI3N2xZTDlvYmtEWk9T?=
 =?utf-8?B?bGw3bHhjRS9rZkdDUzNrVERhOWxkTmhRRnNQS1dYRDd4MXhpRTQzOEdwVkNI?=
 =?utf-8?B?aW1PSTdyZ1FydzBja0N2WkI0RHhadnN0ZVlkRHdJa3lDc29nbncrSHY3VTk4?=
 =?utf-8?B?V2llanVXaDA2MVRSMSs5Q2lPWnh0bUxYUVJXTFlidEduZU5URlc4WmdtTTU0?=
 =?utf-8?B?UTQxWS82eDFLcGFVZmhIdmdKR3RNYWVIUjU0OGdEMGFGc1Vtd3NheThBR3hC?=
 =?utf-8?B?ZnpiMGZERVhjZityVUk5S3BlMzRocUJlUFVZYy8xalgyQk5LZUdteUkxSGVt?=
 =?utf-8?B?WEM0OTBNZ1JhU1c4S2RGMVpTOGtpZzRXbFNlUjBqVW1nYno0d1J4WTlsclBD?=
 =?utf-8?B?S1NzbWJmeUdWQ256WVBUNnBNdDVucW9xUjR5SDRsSWh5WHZrZlRqbFFIcTlw?=
 =?utf-8?B?djFGMnZJbUk3c2x6cExqQjlZWFZ0TW9lVENaNlRpZm4rV0t6Y1ltMTMzZHhO?=
 =?utf-8?B?MFZYMG5FYUVRM2kycUt5cmU5WmVxUGlMNm8zQ1NLWEpKWllsekNUZnVNb04y?=
 =?utf-8?B?ZFN4WGJ1akpweU5aVkhMaUF0Ni9vb29CWDcveVM3b3JTYktXcTZJMURycGxO?=
 =?utf-8?B?ODM4bXhLUDZ0WlBPdDZYM2VoaXlab0JxVWFUUVNkdmh3cXV6NU1HalhNNGVn?=
 =?utf-8?B?RUh6bmNMTUptcU9aT1hHNUtkZHdjV0w1M2dGenl1L2lwWktYaEJpODRGclpx?=
 =?utf-8?B?K1hCTzc5dDU0V0xrM29MeVFBU1RlYnlZNmtvQk4vd3ZPQmNrd0F0RnF0ajV6?=
 =?utf-8?B?VGpEWFVoQmVrUjd5Z2Zzd0REc3VVK25TYTQ5eGk0bEdmKzc3b3piNnJWTE9V?=
 =?utf-8?B?WlYrcjlUT1ZaVW1tL3JJcVoyTEZISHVFN1BiVEEwUnJBYS9FUnpMeUthZmlX?=
 =?utf-8?B?c1lyL3lHa3RUeEtpMHcxSUpBcXR4am13UE5FMVRVR092bkgwbzdaU1NtSnhm?=
 =?utf-8?Q?zbjawz/NM3VbhgdI6vB6dwE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed056b2f-ab79-45b3-400c-08ddcb996480
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:36:23.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6VcqH29JmfhbPkBqLNxBo9Yxo42Tkv7R7BxHwc+WPVHqNvxp8q7+rUi9tlo4UC6AcLdeUAiASZQ9EmT3ffiw5eYV0KgmmDTr9Z9B2SFt5ZX8VH8u8rpnEHy2NRIk53Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6167


> +static int ras2_hw_scrub_write_addr(struct device *dev, void *drv_data, u64 base)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
> +		TO_ACPI_RAS2_PS_SHMEM(ras2_ctx->comm_addr);
> +	bool running;
> +	int ret;
> +
> +	if (ras2_ctx->bg_scrub)
> +		return -EBUSY;
> +
> +	guard(mutex)(ras2_ctx->pcc_lock);
> +	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +
> +	if (!ras2_ctx->size) {
> +		dev_warn(ras2_ctx->dev,
> +			 "%s: Invalid address range, base=0x%llx size=0x%llx\n",
> +			 __func__, base, ras2_ctx->size);
> +		return -ERANGE;
> +	}
> +
> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
> +	if (ret)
> +		return ret;
> +
> +	if (running)
> +		return -EBUSY;
> +
> +	ras2_ctx->base = base;
> +	ps_sm->params.scrub_params_in &= ~RAS2_PS_SC_HRS_IN_MASK;
> +	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PS_SC_HRS_IN_MASK,
> +						    ras2_ctx->scrub_cycle_hrs);
> +	ps_sm->params.req_addr_range[0] = ras2_ctx->base;
> +	ps_sm->params.req_addr_range[1] = ras2_ctx->size;
> +	ps_sm->params.scrub_params_in &= ~RAS2_PS_EN_BACKGROUND;
> +	ps_sm->params.command = RAS2_START_PATROL_SCRUBBER;
> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "Failed to start demand scrubbing rc(%d)\n", ret);
> +		if (ret != -EBUSY) {
> +			ps_sm->params.req_addr_range[0] = 0;
> +			ps_sm->params.req_addr_range[1] = 0;
> +			ras2_ctx->base = 0;
> +			ras2_ctx->size = 0;
> +			ras2_ctx->od_scrub_sts = OD_SCRUB_STS_IDLE;
> +		}
> +		return ret;
> +	}
> +	ras2_ctx->od_scrub_sts = OD_SCRUB_STS_ACTIVE;
> +
> +	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +}

After a lot more discussion within Ampere, I've come to believe that using
base==0 && size==0 as a special case, when invoking GET_PATROL_PARAMETERS after
an error, is not a good idea.

There are three problems with the current solution.

1) This is undefined behavior and will likely behave differently on different
implementations. For example, 0 is an invalid physical address of the Ampere
systems, could be a valid address on some systems, or could be device memory on
another. In case it is a valid DDR address, the firmware can fill in the Scrub
Parameters, Extended Data Region (ACPI 6.6) with proper information. But in case
it is an invalid address, or device memory, the firmware has to indicate an
error to prevent the OS from consuming bad data reported through these output
parameters.

2) Pretend you are using acpi_ras2_mem0/scrub1, which corresponds to the 2nd
NUMA node in the system. If we use the current OS driver implementation as-is
and zero out base and size after an error, then when we issue the next
GET_PATROL_PARAMETERS we will have retrieved the parameters corresponding to the
wrong NUMA node. The driver will have fetched the parameters for NUMA node 1,
even though we are interacting with the scrubber corresponding to NUMA node 2.
This could be problematic in a situation where patrol parameters differ across
different NUMA nodes. Additionally, and perhaps most importantly, using the
GET_PATROL_PARAMETERS to determine if a Scrubber is running require the correct
address range. The current implementation is not getting the running status of
the correct range.

3) This is a special case of #2. During driver load, ras2_probe issues a
GET_PATROL_PARAMETERS using a base and size equal to 0. The base and size are
zero because requested_address_range is allocated with kzalloc. In this case, we
may not be getting the initial values from the correct range.

Proposed Solution:
What we propose, is to instead of zeroing out the base and size after an error,
use the full range of the current NUMA node. We believe that a superset of a
currently active scrub range can properly report all the relevant and correct
information.
To be compliant with the specification, FW should set "Flags" field if there is
any on-demand scrub in progress on any memory range in the NUMA node. Again,
this solution assumes that the driver does not allow more than one scrubber to
run within a single NUMA node. All three problems can be solved in the same way.

What do you think?

Regards,
~Daniel

