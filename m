Return-Path: <linux-edac+bounces-3309-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC6A57406
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 22:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8A53AF74E
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88117202C44;
	Fri,  7 Mar 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="l4NmQ/D1"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022111.outbound.protection.outlook.com [40.93.200.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34081DE3BD;
	Fri,  7 Mar 2025 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384312; cv=fail; b=Gh7KRwA7HXfp67dRTghLzQCWlJ2WUxa4dkqu5t2G+HvtH7+R65RVFU/NJMWIy7wSodKuLkgUoj86tc6IK2jXhfNA6yJr6xcTcQ2V9kvtU5UEYJy7pIqVVycVcSjPlHY2IJRhFL60W106Hsf3ycOjjFdeLsViKGLCehFBVF8vfgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384312; c=relaxed/simple;
	bh=15hrDKT8UVQtYIlUSqQ1qX/RG5Gj+jyJaz2EIp5sg5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZJWrofrzt72BKX9TyxZ+KeWi7NDnfAJ1sx88mDs7u7iX3wGiitLaPe46yYXc64emtol6S0JJIP2z+/vcAE9BP+V1+tyGiZnAdiMRYxqkHRLpoeB8cJtXZtCOjdlXAb8gq1qoQoMzh0ogOTL9etR9xs0X0Nu4sMnjZMW6bwFLso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=l4NmQ/D1; arc=fail smtp.client-ip=40.93.200.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bySYE9x31IIjC0Wu/3rkx94M+TVR0WmsUCQpwqRrot5UKC6jWBUjV6ov4rrsqEiTPtyZ+MgjIb7Ff+wDs6xklqao2a6e+YhLuq6I7RAmhFnsI68vohSbHPscnRcxiZ11Io+wd2T8sM4XVgftYs1GOMjPuVmdhoPwpcKP3euwr/oaeMz0+/JB3LCwO6Y0Jsbkh51ZuwY+oPWNXtM3HBJqnTv7PFUx4Pri+FzZwtQuqMyEl5nrTfGbKUvu6Lqzid/1UuNS6i5HDwCrzcM0FYmKE+bQWRCP1ic7z2KSFUUvx/NEyNIUoOz6wDZTvzErMwzQBRv1ioKKX/7hzj96abzfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8/KYLYfHa1BxvRp0GwBv4NdTKU6mNh9hB9RPfMn0RA=;
 b=pk0fLe8Y80LBzm/OJJfNf5CzJ0lIL6lLaJ8Z1/tQ2tNYZSSfXiVdAFe3F/2usERWlikIhhqinraRM5VGeGM57koXRvPCQS/hr6JUz7cy+RzJA8TPl1Dhrj4nypmjukzs+q/aSL5MQ1s/wWRR540/6kGU1mWxGzDMEij5qQASovsZ4+COSJuSRF70CV6zyUPLlU+dB21EbIIrDHv7UB0MC6Zy+kezqz2zlCFC6837GM6wX4qY+PdCEQfuVWUZRVyNnEGq5IQF7oGOvdeFtrErDLQ+NK8waOcR1QJBt0uhj6gqCp/UXr5cRT/dceq+pfJUdZ30mg2kWRnwoqMylKcT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8/KYLYfHa1BxvRp0GwBv4NdTKU6mNh9hB9RPfMn0RA=;
 b=l4NmQ/D15wBqNsmuVCBj4Yn174kilmUshF3IKulHzQlDhQrQF+VjsS6TEMCHlAw3DQCbKy8XS9Dotno0SUt06Aoa3nzXPOlzlel4O/RIdj/yrcGLnffP4XRk7JiV5/qRBUFxqaA1CVvNCjRXF/IQ6L0Mp/AMd3zd1evNe3FdmnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW6PR01MB8274.prod.exchangelabs.com (2603:10b6:303:23b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.22; Fri, 7 Mar 2025 21:51:47 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 21:51:46 +0000
Message-ID: <0d9066de-769a-44d0-bece-26f1313ce006@os.amperecomputing.com>
Date: Fri, 7 Mar 2025 13:51:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-acpi@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
 rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org, leo.duran@amd.com,
 Yazen.Ghannam@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250305180225.1226-1-shiju.jose@huawei.com>
 <20250305180225.1226-4-shiju.jose@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250305180225.1226-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW6PR01MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 175a80b7-e9f9-4f69-3f2f-08dd5dc241ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTRDOVFVQXkxYnQrdm9wK09YcHNaa3hpNnU5QjArc1U3K05WUXpnSVpablho?=
 =?utf-8?B?ZTMySUxWR01UN1ZYRlZmVExmSllSRjRXS2w5UGl3bmh3bkliZDNoY1JML09B?=
 =?utf-8?B?ejNkT3dxTUdYUHlwQndUR01yMmxRMys0aC9wMHVtMUZxVHo1MFQxOUJBODQr?=
 =?utf-8?B?cC93Q05IcCtGY3BHMXNEVWMrcVRMSDRySldCU3V3RVRtK0EyS0VVNVgyeGp1?=
 =?utf-8?B?ZXpiRURpeGZkRzJZVTVrSHE3NkhPY3RITTJXYnZCZUNwaFJHMU5EWjdycngy?=
 =?utf-8?B?b1ZGYm9tekE1MGhVaTI0bUdsSWwwRU1NUHZsRCtQRFZteGZGUVlGY1ZhaTZO?=
 =?utf-8?B?TVVYamF0WTRTRDJad0htVG9ZRGZqeHI3SWs1YXFnM0QySGc3eWdhWXJXc3Fq?=
 =?utf-8?B?ZlRYR0NuTG1panRjc1dZUlRaZEpGeEE2czFDaEdLQ1N5aEhLTXFmL2FpYVd0?=
 =?utf-8?B?MElxMG5DbzBxY3VKMEZHVWpieTZFSXcxdmpHTHphOWpHdWMzbjZYUjM0NU9J?=
 =?utf-8?B?OXdGMVJWeExPdExBRFlOV0p1alBubkF5ZFhxbUhQb0tTQmJlOXpyaXpxR1pR?=
 =?utf-8?B?WlMxVzYvWTRuN3czOFFseDRiSEtDOVJyUTBLT1ZTY3htbU1HeG1HcU5zem44?=
 =?utf-8?B?NHFDMVBzMTBseU5pcEdramprVDlDcWFEZ1VyWkVzRzF4WnhjU1RIUlJabk8w?=
 =?utf-8?B?WVRTcGowWTZvWDQvZSttVlJOVk5iV2duN3lERW9zVkRFZW5KVjRFWkkyaHFu?=
 =?utf-8?B?UFZ6eEFXaVhaT1cvSzhEWE5aNkpUc2x4Q1c3bTlESGw5MmswR0NPYmxuemJZ?=
 =?utf-8?B?ZjM0MFNFTndYUzNPUDNxYnZrZlJzUlE0SEtoZFc3ZU94Skx2Ti96cG9ZSE80?=
 =?utf-8?B?MGk1cU5FYnVKK1pzQWt5alB0UlF0U0M4c1kvS1ZzUnJjNEVzaDIxUG5NdnJR?=
 =?utf-8?B?QTlnbWhRNFJINHlUOGhSa3VhK3R0c0ZvWHVwdDlFYjdqRUFaTm02UXIveDRp?=
 =?utf-8?B?WmxKZ0dNa0I1VmxrRm9xcUU2QTJ0aDNDTzlHYjg4Ui9lVC9qVEIvaU9SeE9I?=
 =?utf-8?B?Q2FydUQvb0hOV3NJV2hlUk45bkxpN3AxeEZOWXZnMUhxY1lPRndML3pmMWZ3?=
 =?utf-8?B?V2pDRWhHSkFIR29YWElEZnVxMUJ3TzNOYUpDajluWi9QN3o5K05HSEdiS3Jt?=
 =?utf-8?B?U1M0UXdBdU1qWDlqUUJvU0F2a1JQdWllRExlVFhvOHZpN1BIeHprZnVYdHN3?=
 =?utf-8?B?OUZXOFBPRERacWhJL0lkUzhRWFpxdDMvR1BMZ1gzZDNLV0Q1VVFxRGhNV2Ex?=
 =?utf-8?B?ejNmS0hxRmppaDdQMUhYUjAvbUVkZnhSOGYyamdocTRUL0dKTHo1dDRyMi9U?=
 =?utf-8?B?ZUszMmtMc1NhWXVqVStiZUpHdmtLUkp0SnNKUExKM3ZTYThmU0tmU3g4K0xu?=
 =?utf-8?B?RWVTRkEvelk5QWkxcG1WUzRkdnFheWdyRE51dXAxOHJKa3YvQllVUmJTQWZt?=
 =?utf-8?B?dXQ1RUVoT2RKTXZLd1ZyMnlBc0l5MGhTNnlubWxOdUdxQ0ZLUTBFMHZSN25Q?=
 =?utf-8?B?ZXpCVlViK3Y1SmVaN3hYckQ4aTltSjVLMWZGamhxOFFBWEMxVHBKcXJ6Znpp?=
 =?utf-8?B?a0pKUmhBWHZsQ05waEt6V3pxU3ZsWFZCTm9FdWJIY1U3TWdvZ3BIMmlGNE00?=
 =?utf-8?B?MXJlQlhMSjYvQ1RFaDlOSVYwWm9NTGhpTjdvVmtPZGROeFUzdmJwUm51Rlhm?=
 =?utf-8?B?OUlRV0p1WGZwSUZzK0hrV1RYaGtlSXBSeW1RbHRrU2d0OWJzQ0VHb2FuZXIr?=
 =?utf-8?B?WjJ3Q3QyT1REMTZvYnp5d3BKTE8zU3dTU0xEa2l5Y3ByVEplQk1OY0NwVUJx?=
 =?utf-8?B?MURjRGU3UkVVU0lleHhTNVlsMU1tM1RmV0s4ZmdjSVNEWGtlSlkzWUZJUkxZ?=
 =?utf-8?B?L0g3WWxVTGdiYzk1KzBJMVhPSHdXOTdPVXdSRCs5SmZjQzIwZzg2blh4eXU0?=
 =?utf-8?B?T3lSQWVhQkV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm5Hb1RjTmd6dUhEMXdqODl2aUFSNzR2SXVDb040NkpqeHpaRHlVNFljbTRN?=
 =?utf-8?B?bUlqcnNXRWNYNkVsQ0J6aUhZT1hjVUxHOWg3cWNiWEgrTzVQcHJFRnhnVndv?=
 =?utf-8?B?ME1COTV1VkMxeG1qL05WMGdLd3kycFJUWGVISVdYVVZQR0Nwb2grZXphM2JR?=
 =?utf-8?B?VEs3QjRWeFAzK1NSSmdab0dQTGRIRGNHdXltVFh3ZXgrSFptR3ZVdnpaM2ZT?=
 =?utf-8?B?OGFrV2tOOE5FdmVtQWRDMjNIV0czaGY0L29McXQzbDlPUmNGL1hITCtVYlMv?=
 =?utf-8?B?WVRhQ2RhT3IvS1grSWRycHhFQ1NxZ1pxNHV0Ui9VTW9rUktmeHJZSDhhaURI?=
 =?utf-8?B?YkdZR0c0VGE4eEQxYjRIeEw1THZJUXVzV2x6bURtVlhFeFptNjRhTDVTb1NP?=
 =?utf-8?B?WXFGaVJxMVk1OUVnaGQ3aGRXNkpIanNRVkljY3RIZXVJWWtGaUVkVEk1ZFpq?=
 =?utf-8?B?NkU0QkNONnc3SGYwL09YQkRoaTdobVVIOVNlSU5ZMTdKb0tmclk0YkZPNTU5?=
 =?utf-8?B?aEhLZUEweEQwS2xUemZEWWl2dzdrTzVvejMrNnpaV2V5VGIrUEVHR2NCRGpk?=
 =?utf-8?B?MlFLSHlMZjg5YVdLV1hZelAwKzVod2VYU0RxaWNBNTErSkJjbzY5YTE0Zysx?=
 =?utf-8?B?bmFtZkNJZzZ4SWRqUmxxOFBPWk9oRGpJY0tlMUVzS3ZmWVQxdm1wUm56MUhI?=
 =?utf-8?B?eTgrbXFacFA0QWQ3ZHVkcGlEd3BZYXo0Smh6bHFwNlNqL0VSaDdRdGxlMFdz?=
 =?utf-8?B?ZmxCekNPZHpkcFFtdXQzZStoQjFJVnpoUGhlbEdBZ1FFdVZaMkZYQm8yOWw5?=
 =?utf-8?B?ZlV0WHRiRTZKR05UTzBaTWI4VFdZUDdaaDdJWFRvSHdLOUs0WDFkcGRMeGVV?=
 =?utf-8?B?TDhybEovUkFtcW04TVhrckNhMGRmeVJWOVNMdktYZ1hHV2NLQUdpRHRJT253?=
 =?utf-8?B?TTQybEVWQzNVQWtWclp1cEV1Q0Q5Q1A4Znl0bkk1M2FqUENGQXo1WVVXRnRZ?=
 =?utf-8?B?bkcvdy9waVkvWWJYV3JkYXBTdGcyRGhQSUk2aEo4MFUwQUcxckN0Z1p2SitV?=
 =?utf-8?B?dVN4cld0aG9uR2RMR05uRFoyQS9sVWtla3JRdFNSZ29NNzFGRzhvaHpvby9z?=
 =?utf-8?B?S2RCS29QMlJycllmZ2R2c1pCUHZEM3hnazdFNEEybWszUjZCbjBVdHN6ak5r?=
 =?utf-8?B?bm0wUm96OUZwOHVWWFV1L21kTEFDNmtsbS91MmZCVnNmdWtkUTBScEpoZHZ3?=
 =?utf-8?B?M1F0UVhIWERhNjVrd3FuUzcwK0hHY21vdmJaUkZ6WjluNjEzTnlyeTVNM3pL?=
 =?utf-8?B?QnVhYkpBZVlrSkdUbGg0MXJIZHZmSEhsaCtrbjR3TEIrS3RLb0o0NXJxbVVh?=
 =?utf-8?B?NnhNNGtkNnR2NzNjczlCenlsZnFORE9ocnQwN0ZQcFZhUHFvczVvZSt5VXBa?=
 =?utf-8?B?Qy9maHV6dzYvWUpFSG50eEk2Y0pYdHlCSG82WjlDSXpaaTgrSEN6SnFXeVBL?=
 =?utf-8?B?YnZFZ1M2Yk9GVVphNTcyNUUzRk9sKzdUQTk1ZWRhZDJpOGJJelNuRElrc3dW?=
 =?utf-8?B?UzFId0dJSXhKdTZVSG5QY0JxUVVDc0R1VEw3VktaTEJBRFdNVlZxbGtSRC9B?=
 =?utf-8?B?NDhmd250WG5xUTZOZzNEZ2x4SUdrUnBzWVd4WFZ1clJHTlJmeTFLdEJqQU50?=
 =?utf-8?B?bitrVEFoak1GSTFmVmVXSHFxYlQxeXNXWndxMEFES3R3czNkaHpYVXhmSmxH?=
 =?utf-8?B?Z2FManNoQi93VFFSOGcrb21FeEkrcXZjMEFwNnNiOWVVK3FRL1hJcktGSkFi?=
 =?utf-8?B?bHV3a0NFUkRXOGhSUGdIN01oNVJGbFphL1o2TE9XRW1yWWVxaEJsclNqZTN6?=
 =?utf-8?B?OHZzQ1NUMXZwQnMvNlNMTEFOZVNVUkozbUpxVnpSbUsvYlRSL0NvUXFxVUE2?=
 =?utf-8?B?NjVCdUM4QmdHN2JVVHd4dExpa0toRmxXWDF1WW1rcUZjaklPVkJsb1hJa2l4?=
 =?utf-8?B?OXU0ZHFHcUdoSzZseDZ3bklKVTM5c01Nc2t4WUpKWGJCaW91V1h6ZWtGeGor?=
 =?utf-8?B?VFZsTmZYTFg3VzFmWlZzT2ptTlB5VG5NMmZPNXd0NjlmUk5zNEowOS9maUVW?=
 =?utf-8?B?SlBjN21SMXZZZlRmZkdYMVdYdS85eWUxbmc1bUV0NWYvbkozcUdya0w2dlJE?=
 =?utf-8?Q?PeB+CvCYTxuNRB1rqjT2qVY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175a80b7-e9f9-4f69-3f2f-08dd5dc241ba
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:51:46.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNGPOyCebJOO5Haij8h95FJn8H2QRG8QWYatIsUS7GOYVtbqip+jB7E2u8ych8w7mqJgNmWar3jGHY6Op788GwyLLEvLO/yHcDyjJFjCbvm/Vnp8oc47hRd2IJHkU80O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8274


> +static int ras2_hw_scrub_read_size(struct device *dev, void *drv_data, u64 *size)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	int ret;
> +
> +	if (ras2_ctx->bg_scrub)
> +		return -EBUSY;
> +
> +	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +	if (ret)
> +		return ret;
> +
> +	*size = ras2_ctx->size;
> +
> +	return 0;
> +}

Calling ras2_update_patrol_scrub_params_cache here is problematic.

Imagine:
  echo 0x1000 > size
  cat size
  echo 0x2000000000 > addr

What happens here? What happens is the scrub range is not what you expect it to
be.  Once you cat size, you reset the size from what you initially set it to.
I don't think that is what anyone will expect. It certainly caused us to stumble
while testing.

Regards,
~Daniel

