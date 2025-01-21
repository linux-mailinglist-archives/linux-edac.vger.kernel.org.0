Return-Path: <linux-edac+bounces-2937-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E73A18815
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 00:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A11A1886123
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF2C1F76AB;
	Tue, 21 Jan 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nCG4Er41"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020129.outbound.protection.outlook.com [52.101.85.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4681714A5;
	Tue, 21 Jan 2025 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500497; cv=fail; b=UkFP8fBL4zILqb7B1niJXF3tKvH0GFwzZcxRF0yDE2WWHxJNzmE1uP+zC3j9UsW6EOlIwiXw9HbOeAft+zveD5M88A30f/SITSC/EK38xrjgWf9yFq1L+ZpNIvfTsyZs0g8N7NsMbjEar0wGC3UH4UMUXD1ObPxMgoDcF1M2Ysk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500497; c=relaxed/simple;
	bh=hF/wZ6EnzfuvjkiQSxZHqAlo4iZRixrHcUAwNWHKaJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZH+8tGpBM6wlsN41hfSF0mPgFbJG9m93u5TZ7FWtcM0+xdRxKmm/0McRpP0rA2gysLm3AR4Oswndc8u1cUv53s7pTDg/WRx4OCqKI75Ow+pcmGtUo2R5wCUl+rzhO7KlisSQWwc0SrhZWnVkytjXLIj59D4Z4IACvM59AoPhto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nCG4Er41; arc=fail smtp.client-ip=52.101.85.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZlpiBTdSY6vqYVTWe/GwZnx9/Ms2vKzwScEVGQU6OYZch/wdjwFtJyjWiO3XwZ7ZiF4s21mG00qvl490fKxnlo38KhYBj8PGpbr6F6ttbDxPoeeNq3rKwMjgtpd3oY5nHz7e9fH1gmfNN6CdBb2wPreqwJCDhXOqyZPH7Fpu6ygmMUzO4ZQxatvLV1JGCexwSsMjfKnVKWs/rFM+UB7dDlV5GsNrYswQMdWMXpPNenfnLVfF7D5WJoLZsE1sa+x32WJi2yAk8IamqM59M7aOWlzkelpzP08EG8O+/asv1J/x/BUfGJgxRZAAskvxUCUzU0bJzR4saLcgBstIf5j2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhX/vzLQuwrvZPY9lcTUO5OpizlZJcWnugEpPTzxxVQ=;
 b=qF5D+pEAa1LC+IVWHmz+M54GvMPzC9r5kIlcCRD1UMyUVf1HvM5uoRPIWtXBqfBESKkduAmiyBnOBXVxIlCyL17TWhlwGRXGsWNdDP8gUwr+dDgMo216UgHVXdLaAOfDLKXbZhfDtucxMKSyjmbJdJzuXGiZ2m6Cd8E0jxmhFvED0K1nm7EZZHeWL58rnI3ZaJF/hY5n3ctOOuRuNwbfnXluv8diTIM8NNc2wM+Yya9slOYGyyjnoA8+nPVJ/46bEdKyYWjp93VsbLk2fVJihfGWQ/MKeht2qdkhBxREcFHYmDg479CQ+O6U40GQcg9LWjY5SU2QG4wlRymJl72IYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhX/vzLQuwrvZPY9lcTUO5OpizlZJcWnugEpPTzxxVQ=;
 b=nCG4Er41GBMHXcY38BEt5ttjXJjBm7oH8Vjo6NDgu8elX0e3Gv+M8Ls7HqJkxkHqrYoXPeKAQUiu6MPhsjPGTT5/FyKNDXuNQwsjAYnzVttRCwkWuL7jA6SkKAByfQk3xVF/WagH87qWe+o+7H8KIlu45n5Wp7zrTj7XVyS0oY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 CH2PR01MB9134.prod.exchangelabs.com (2603:10b6:610:27f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.11; Tue, 21 Jan 2025 23:01:33 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%3]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 23:01:33 +0000
Message-ID: <4c292a95-dec7-4407-98a2-194c73e19a2b@os.amperecomputing.com>
Date: Tue, 21 Jan 2025 15:01:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 06/19] ras: mem: Add memory ACPI RAS2 driver
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-7-shiju.jose@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250106121017.1620-7-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|CH2PR01MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: e00d3b2d-c057-4dd1-735f-08dd3a6f8c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVg1RDBtNFBhOVNla2RqUExiNXpJNjdyU2ZueUgrZzJGZE9HVFF1SENnbzlx?=
 =?utf-8?B?Q2JrVzMxbW5vZ0x0MkIrM1VZN205WG81L3JJTzQzN2E2aW1ubXFZejhCVk00?=
 =?utf-8?B?d0NDZU5xajV4WlppOUR5NnRveGo0UTZCWkpPalk3eWJNMnlHZ0QxUGhUeEMv?=
 =?utf-8?B?VzNTaXlVM1RTbTNqN09YRHM0WlZzL016VzlYcW5BZmhBNC9jd0R5S0VQVTVz?=
 =?utf-8?B?bkFlNUZNaUx5YU5TRllLaU9oYTFkdkd1dzN6OW1CNVdiUkNPWHk5QjVWV0xu?=
 =?utf-8?B?WTExOUFwM3p5NlJwWkl0azc5YnBTN0pTaXhEVmVtQ2RnaUZzVUtWTk9CVjlM?=
 =?utf-8?B?NEpsMlFEN2w3eFhnT2o5cFRPSUFMRkxXN0tXZmdISkZPbitXNWplckFJZExZ?=
 =?utf-8?B?Q1NWNENSNlM4NVFUSEIwKzF4K0ZCWUVTVTlUUUlsV2RNOUVGb3F3dFBRME9V?=
 =?utf-8?B?OUFocFRJZUt3cVEvK2EvTnBwWlVhTmFTME1QajU2NEQ5VVpvK29SQitKV01l?=
 =?utf-8?B?TkxnWjRHeDdvRjBCUGJpRU0xL0IvSHc5U1NGZUNFcUZjNE40QUxOdzliOWYv?=
 =?utf-8?B?bUdHZGtwMUN0WmlJSWpvcngyeXVteURKU2ZLa3AwVWZNNHlHZkFWYzMyV3JX?=
 =?utf-8?B?Y2dnYnpsb3pQOUZiek8ybGpuK0YwNWlJTUdtSkVQdlhFU0w3Y08rQitmVkxv?=
 =?utf-8?B?REJEeEZmTDVGUVFiUUt4ZHVDMlkzUHgwdW5KeTBlQVRDclpCeHBoRGFGYmVF?=
 =?utf-8?B?YlBINzhReVFqU3ppMG0xblFWQnNxcTlaeGRwdHpmdUp2cW9hM3N5NytPQ3My?=
 =?utf-8?B?emtBeTdMVmpNRDRDQXNxQnVsaGR6UkdhT1dGa0NMdGUzb0FpZkhLUjRXYTFL?=
 =?utf-8?B?OHY3aEZrRFhNSDJ1MzVSWi9wUi9vY01JR2RkN01qc2JLa0dCb1VaZlk3ME4y?=
 =?utf-8?B?VkxTdmFSZGh6TGVvbm90R2JFcE80YUdNSlVWUFdabnRXSUpCSFFwaUlIM2to?=
 =?utf-8?B?UmtyZWN6aEd5SUZNZjlINlVrYzFVb2VlYkExbDZYUWQxUW4vcGRwbmQwamd1?=
 =?utf-8?B?QXQ2S3FvbmZJSlZBTHhWZ3NlRHI1ZFlGaUJXU29Tc1RlYmhObndVcDhhZHdY?=
 =?utf-8?B?R3pDUlpZU09LaEV2R2FIdFNWelBVM1d4RHRzd1VXenRSdWxVcjlIcTE4L3JR?=
 =?utf-8?B?VnFxaUlweGdOangrNDBqTWZOU2tLTk1zTERXSjQzTnpQczdTMmR1UzgwYWVG?=
 =?utf-8?B?Y2hjdENvMHJMQ0F5aEtKd2U4N3NFSUo2eG5NdVloemE2R2hJTkEzejhPR0Fz?=
 =?utf-8?B?ZnpabjdCR1lVeGtoRnJrMkYzL3hQbjU0enRVY3hScE5teG8wVXZIdWZ4Z29w?=
 =?utf-8?B?UFU5RXg4Q0xQVUlJK01lTisyTWtJVElHc1ZEOFhPNGdLVklPbElNZ0F3UWFr?=
 =?utf-8?B?eGNBc2Y3eGI0dnZDZkUrcmM1U282YjUwb0g5K2hDN0pUandEbkdYUjVzOFYy?=
 =?utf-8?B?SysxcVFrbk5sUHZFL3V2NW56WjZ4SUtJWkNCd2Zua1Z2Yys4Yy84VnZDd2NV?=
 =?utf-8?B?RnZISkU4STZZK1B6VzNLMExZWXh1Vk9lbDBRWHVtV1hhZCs2dkp4djBtOEhy?=
 =?utf-8?B?eGVCQVJUbGF3R203NDFIMW5td0dheFlxcFY1VFFDUHdWbWJ5NGtVYWNqT0V3?=
 =?utf-8?B?T3U4SjdrUlF6R3EwdFcvRTZjSm9OWUV0b05CUWsvNWF5Si9IaXVyQXplcG5h?=
 =?utf-8?B?eGV6L1B0RTlxYmIyL1BYNEtOMnFVTGdUdFJqQVNzZzY5UEorSVI4NHlrbDQz?=
 =?utf-8?B?MEU2SytIU0gwRk9UQUhjbkErTGJxUTFDTHduNUxXZjhyZlNDYTRiZ29rMDlO?=
 =?utf-8?B?ZkVxZFhiekM0dnZKamVtc3RNWFNydHRiWW1nbi9ySFJ1WG55VDFEZ2pNY2NZ?=
 =?utf-8?Q?gXP6cjlKXuqfmhTm6QUX3gAPeN9+eVbB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVdXUzVvRmd2ekdDakFEcEFZck9uaktvOUk2dVpvbUpLMitreU8rcGh1NEJN?=
 =?utf-8?B?VU1tM2hxMTV0OS8rRWJpOUxFYXg4K08raWxsWW5kcHYydndhRThQTEliYnNQ?=
 =?utf-8?B?VXVJOE1sQXRZb3NYWGszd2JVQ3l1T3l4b3ljYnlFQWM1eTlBejlHcVZjR0s2?=
 =?utf-8?B?NnJXTEJyb1pQanFJQ1VzV2c3dGo4S2UxTk5JaE1mNkRqV3VrQ2NSbk1LVnA1?=
 =?utf-8?B?Qzgzd0ZkWlF1WHRlQk5kdk5XWG1ZSUJPNmo1NGY5SXR2eXljaXZnM29qZEFj?=
 =?utf-8?B?UnBEc3dYK2JKa3RGbkJqemJOekRWcUFkWHIrVm5HaUJkZGhBSHMzb09aZHdw?=
 =?utf-8?B?akZzdjJ0MkE2Uy9QMU9VRWt0WmN2WkFOSndKenI0bmY5N1J6WC9wTmZFTk5V?=
 =?utf-8?B?UFlRYTdUb1ZpZEZUSndDcFVyb2VycUNtNkgvNjVPZlhOWGh2eE9yV3FsRy9M?=
 =?utf-8?B?d1laekNtbFVrUWZKY3BIQ3RLd0Q2VUc0ODFyYlJJZGFWMUtremF4cEEvQkJ3?=
 =?utf-8?B?YVFNOXZkOEdUZUZJaE1rc3VmcnlCYmxSTGt6aGFYZHF2UGFhckdzdEg2VHFX?=
 =?utf-8?B?b1QyTEFxR1lFdm9LVE1JRURWTzdjRTVpc2crT0VuM1U0RURYaDVGZXQveTJT?=
 =?utf-8?B?L3VBRXU5ZXZ3dzNxS0tENjg0SnVFRDJVWXEra2tqb0MvcVNCTmFlZ3dNdnc2?=
 =?utf-8?B?dHJxQkY4RkpwWk45eWhieXFWbFZrU1EvdU1NeGJ1S0s3bE4wdTA3MUVuYUJs?=
 =?utf-8?B?Vm1qcVVFL3dtSVZNeFZXa3VNeS9UR0lxNjRhOHhSa0Zmdm9US1FoOC9LZTJt?=
 =?utf-8?B?T29IbDFzU0pvamhWYllrd2ZZa1pXRHFnZHFZdERlNG5BWkdSWjFVRXpzeXJw?=
 =?utf-8?B?a0dvOUFEZXV3ekE4YjB6SkpMTFVhUjIwa1NGdTdUelpyaUd6eCszNFBmeUhl?=
 =?utf-8?B?WnZtdm5RZlZ0UituLzRvekxyRjQxMlFiTDFRLysrZjMvRXJBMXJmRGpwWUdN?=
 =?utf-8?B?M1dZUllZSXExMHozN1d6bEJaOHZoQmJqVEV4V0hKQlVaS21TVlNXTXNKTGlE?=
 =?utf-8?B?emVsZ1llVGxkZkF2S2N3M0JuTXZsWkp4Y2ZuYzMrbS84cXRxd1JlOUtleC83?=
 =?utf-8?B?TGZtb29iaERZZHhDUldwTDNxTzduNG81dVYzWFdtOU84WWIxdTNiUTlENkkv?=
 =?utf-8?B?Y29KNVZHQUVyZnVBdUZGcmltQW5Na2luNWtjZDBCa3duaG9LdTkyMUFwRTdK?=
 =?utf-8?B?dEVJSVVPeU54cks5ZEdaQXNxaXdsMWJaSGdQaHYvNms0VWNwTGNCZHFtRmNi?=
 =?utf-8?B?L0w2Y1c5djJ3Z1pUNnVVVW4rMXpSbGhmTmVRM3Y2RzBDcjhCZUZBd1RoaXgw?=
 =?utf-8?B?Q3FGbHB2bmpnWWRZNXJ6cEtvZEhGUmxsSlZFSkdIY1pCbFpQR1pEN0FIY2RQ?=
 =?utf-8?B?VGx0OUN1Zm9hNHQ2QTlLS1RWVHA4QWp3NG1UUGxqenBLOURTejJ0aldsR2d3?=
 =?utf-8?B?Z0J5YkM4emNjbmttYlJYWXhlbi8xZ1ZxMzYzMVAwTVhxNUFYNW9pNEZWN3hQ?=
 =?utf-8?B?ZGQvREFqQmYrVDRFUUo3YTdyWTFzaWRZZm1iaThOeWhCdHBmOE9kczVkdWQ2?=
 =?utf-8?B?OTZBS3ZmS0t5N0xHeVY0d2ZtNXNjeGFxSG1KQWJMK3U5blFxc1prVGNjNTdi?=
 =?utf-8?B?UDBrK21QR2lGRjJ3Mk9UVzdhVDZsYXdOaFJjTnlyb3JZSkxuMnF3RVF0WHF3?=
 =?utf-8?B?YUhOckZkRmh0bHc3TTZ3WHVZSDlmaFBUN2praGdKc3h6RnZCb0praEQwb2Vr?=
 =?utf-8?B?dUNMczFNSjEyczdqdFdFNUwvQ1VBemVvYzd1ZEVEeXlCM2plVmsrR29DYll3?=
 =?utf-8?B?QmJzc0tVSTlybVBGOGVlWUd4S1BMTmRMM2swbWtiTmw4T0JGQ0VnQ1BJNGQv?=
 =?utf-8?B?c2dDejlRVS8wMHFDN0llNDY5ZVFHNzB4cDFjS3JyTzQ2dGhiUmRwdFgzRE1H?=
 =?utf-8?B?M2h3bDBnOElHS09iazM3ZEJHWERhZEVFQkhHWW5UNmxrSnBkK0xxWmYrYmlx?=
 =?utf-8?B?clM4SWFNbldFVFFkRUp4cWgzaTBjWGNXR0lWeHdDcjBQQi9FdUhhU0c4ZWRZ?=
 =?utf-8?B?a1l6SFREWmVVYUsrOFgrWlh0Z1dGVHhVZUNubVordkVrYWpkZmovQ3ZHTmV4?=
 =?utf-8?Q?E/cO+KJrD6IPBX1URBmYWos=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00d3b2d-c057-4dd1-735f-08dd3a6f8c98
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:01:33.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyo0C23ra+75YfGr+NXheYbRKL/XaPjzE01kcVgL+fxz1gzVRT2TqBN1kiZgiE9yZX9kbRt9jujBK4AxxWhoYhaU5Vl9/5d3N7We3n/Cyz+yH+Utod12DQkU2VMh/fzu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB9134



On 1/6/2025 4:10 AM, shiju.jose@huawei.com wrote:
> +#define pr_fmt(fmt)	"MEMORY ACPI RAS2: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/edac.h>
> +#include <linux/platform_device.h>
> +#include <acpi/ras2_acpi.h>
> +
> +#define RAS2_DEV_NUM_RAS_FEATURES	1
> +
> +#define RAS2_SUPPORT_HW_PARTOL_SCRUB	BIT(0)
> +#define RAS2_TYPE_PATROL_SCRUB	0x0000
> +
> +#define RAS2_GET_PATROL_PARAMETERS	0x01
> +#define	RAS2_START_PATROL_SCRUBBER	0x02
> +#define	RAS2_STOP_PATROL_SCRUBBER	0x03
> +
> +#define RAS2_PATROL_SCRUB_SCHRS_IN_MASK	GENMASK(15, 8)
> +#define RAS2_PATROL_SCRUB_EN_BACKGROUND	BIT(0)
> +#define RAS2_PATROL_SCRUB_SCHRS_OUT_MASK	GENMASK(7, 0)
> +#define RAS2_PATROL_SCRUB_MIN_SCHRS_OUT_MASK	GENMASK(15, 8)
> +#define RAS2_PATROL_SCRUB_MAX_SCHRS_OUT_MASK	GENMASK(23, 16)
> +#define RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING	BIT(0)
> +
> +#define RAS2_SCRUB_NAME_LEN      128
> +#define RAS2_HOUR_IN_SECS    3600
> +
> +struct acpi_ras2_ps_shared_mem {
> +	struct acpi_ras2_shared_memory common;
> +	struct acpi_ras2_patrol_scrub_parameter params;
> +};
> +

If the ACPI change here [1] comes to fruition, then checking for errors
will/may have to be done by each individual feature. To show how that
may look, I've included a possible implementation to illustrate what I'm
trying to convey.

static int ras2_scrub_map_status_to_error(u32 cap_status)
{
	switch (cap_status) {
	case ACPI_RAS2_NOT_VALID:
	case ACPI_RAS2_NOT_SUPPORTED:
		return -EPERM;
	case ACPI_RAS2_BUSY:
		return -EBUSY;
	case ACPI_RAS2_FAILED:
	case ACPI_RAS2_ABORTED:
	case ACPI_RAS2_INVALID_DATA:
		return -EINVAL;
	default: /* 0 or other, Success */
		return 0;
	}
}

[1] https://github.com/tianocore/edk2/issues/10540

> +static int ras2_is_patrol_scrub_support(struct ras2_mem_ctx *ras2_ctx)
> +{
> +	struct acpi_ras2_shared_memory __iomem *common = (void *)
> +						ras2_ctx->pcc_comm_addr;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	common->set_capabilities[0] = 0;
> +
> +	return common->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +}
> +
> +static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2_ctx)
> +{
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +						ras2_ctx->pcc_comm_addr;
> +	int ret;
> +
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "failed to read parameters\n");
> +		return ret;
> +	}


ret = ras2_scrub_map_status_to_error(ps_sm->scrub_params.status);
if (ret != 0)
	return ret;

> +
> +	ras2_ctx->min_scrub_cycle = FIELD_GET(RAS2_PATROL_SCRUB_MIN_SCHRS_OUT_MASK,
> +					      ps_sm->params.scrub_params_out);
> +	ras2_ctx->max_scrub_cycle = FIELD_GET(RAS2_PATROL_SCRUB_MAX_SCHRS_OUT_MASK,
> +					      ps_sm->params.scrub_params_out);
> +	if (!ras2_ctx->bg) {
> +		ras2_ctx->base = ps_sm->params.actual_address_range[0];
> +		ras2_ctx->size = ps_sm->params.actual_address_range[1];
> +	}
> +	ras2_ctx->scrub_cycle_hrs = FIELD_GET(RAS2_PATROL_SCRUB_SCHRS_OUT_MASK,
> +					      ps_sm->params.scrub_params_out);
> +
> +	return 0;
> +}
> +
> +/* Context - lock must be held */
> +static int ras2_get_patrol_scrub_running(struct ras2_mem_ctx *ras2_ctx,
> +					 bool *running)
> +{
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +						ras2_ctx->pcc_comm_addr;
> +	int ret;
> +
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "failed to read parameters\n");
> +		return ret;
> +	}

ret = ras2_scrub_map_status_to_error(ps_sm->scrub_params.status);
if (ret != 0)
	return ret;

> +
> +	*running = ps_sm->params.flags & RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_min_scrub_cycle(struct device *dev, void *drv_data,
> +					      u32 *min)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +
> +	*min = ras2_ctx->min_scrub_cycle * RAS2_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
> +					      u32 *max)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +
> +	*max = ras2_ctx->max_scrub_cycle * RAS2_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_cycle_read(struct device *dev, void *drv_data,
> +				    u32 *scrub_cycle_secs)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +
> +	*scrub_cycle_secs = ras2_ctx->scrub_cycle_hrs * RAS2_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_cycle_write(struct device *dev, void *drv_data,
> +				     u32 scrub_cycle_secs)
> +{
> +	u8 scrub_cycle_hrs = scrub_cycle_secs / RAS2_HOUR_IN_SECS;
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	bool running;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
> +	if (ret)
> +		return ret;
> +
> +	if (running)
> +		return -EBUSY;
> +
> +	if (scrub_cycle_hrs < ras2_ctx->min_scrub_cycle ||
> +	    scrub_cycle_hrs > ras2_ctx->max_scrub_cycle)
> +		return -EINVAL;
> +
> +	ras2_ctx->scrub_cycle_hrs = scrub_cycle_hrs;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_addr(struct device *dev, void *drv_data, u64 *base)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	int ret;
> +
> +	/*
> +	 * When BG scrubbing is enabled the actual address range is not valid.
> +	 * Return -EBUSY now unless find out a method to retrieve actual full PA range.
> +	 */
> +	if (ras2_ctx->bg)
> +		return -EBUSY;
> +
> +	/*
> +	 * When demand scrubbing is finished firmware must reset actual
> +	 * address range to 0. Otherwise userspace assumes demand scrubbing
> +	 * is in progress.
> +	 */
> +	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +	if (ret)
> +		return ret;
> +	*base = ras2_ctx->base;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_size(struct device *dev, void *drv_data, u64 *size)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	int ret;
> +
> +	if (ras2_ctx->bg)
> +		return -EBUSY;
> +
> +	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +	if (ret)
> +		return ret;
> +	*size = ras2_ctx->size;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_write_addr(struct device *dev, void *drv_data, u64 base)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +						ras2_ctx->pcc_comm_addr;
> +	bool running;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	if (ras2_ctx->bg)
> +		return -EBUSY;
> +
> +	if (!base || !ras2_ctx->size) {
> +		dev_warn(ras2_ctx->dev,
> +			 "%s: Invalid address range, base=0x%llx "
> +			 "size=0x%llx\n", __func__,
> +			 base, ras2_ctx->size);
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
> +	ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_SCHRS_IN_MASK;
> +	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_SCHRS_IN_MASK,
> +						    ras2_ctx->scrub_cycle_hrs);
> +	ps_sm->params.requested_address_range[0] = base;
> +	ps_sm->params.requested_address_range[1] = ras2_ctx->size;
> +	ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
> +	ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "Failed to start demand scrubbing\n");
> +		return ret;
> +	}
ret = ras2_scrub_map_status_to_error(ps_sm->scrub_params.status);
if (ret != 0)
	return ret;

> +
> +	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +}
> +
> +static int ras2_hw_scrub_write_size(struct device *dev, void *drv_data, u64 size)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	bool running;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
> +	if (ret)
> +		return ret;
> +
> +	if (running)
> +		return -EBUSY;
> +
> +	if (!size) {
> +		dev_warn(dev, "%s: Invalid address range size=0x%llx\n",
> +			 __func__, size);
> +		return -EINVAL;
> +	}
> +
> +	ras2_ctx->size = size;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +						ras2_ctx->pcc_comm_addr;
> +	bool running;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
> +	if (ret)
> +		return ret;
> +	if (enable) {
> +		if (ras2_ctx->bg || running)
> +			return -EBUSY;
> +		ps_sm->params.requested_address_range[0] = 0;
> +		ps_sm->params.requested_address_range[1] = 0;
> +		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_SCHRS_IN_MASK;
> +		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_SCHRS_IN_MASK,
> +							    ras2_ctx->scrub_cycle_hrs);
> +		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
> +	} else {
> +		if (!ras2_ctx->bg)
> +			return -EPERM;
> +		if (!ras2_ctx->bg && running)
> +			return -EBUSY;
> +		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
> +	}
> +	ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
> +	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
> +						    enable);
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "Failed to %s background scrubbing\n",
> +			enable ? "enable" : "disable");
> +		return ret;
> +	}
ret = ras2_scrub_map_status_to_error(ps_sm->scrub_params.status);
if (ret != 0)
	return ret;

> +	if (enable) {
> +		ras2_ctx->bg = true;
> +		/* Update the cache to account for rounding of supplied parameters and similar */
> +		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +	} else {
> +		ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +		ras2_ctx->bg = false;
> +	}
> +
> +	return ret;
> +}



