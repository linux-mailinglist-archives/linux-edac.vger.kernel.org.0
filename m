Return-Path: <linux-edac+bounces-2355-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C69B6942
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAD81C218FB
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E065E2144B2;
	Wed, 30 Oct 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4n9Tq6Y4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38F26296;
	Wed, 30 Oct 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306125; cv=fail; b=Fz6PevPQy8KiQFLpdPIxKhnpAI9tAaX2/+Jj2Fe6ax2Ix5hNaPNNAD3y1K8RFSgyuxrYshBlj+OIwmfKk/GS3AfYIYXDcu9eUl8qQGK4xYs1y7GuEu6aVFxCKlXjaC66rX/w8XoShCD+3YaDb5/tcMorSr7WRnJK95E9rYGeKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306125; c=relaxed/simple;
	bh=rSaI0Ou/mUEUhetKrwfKlr78swkTXiDXIY6uJUOJbUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UccI0aq05carUlLYQoRR3lBsOVVhIU94QhXEM/iYzlZxN7ozmM7C8+dQRzf+b2e06vU0cD0j4RH+RxRAhs84h5ohYAbjAzl9hfnAbYnJCjTkC0yINzVdlQWJnyIKvu9xqkdx/c9ReUsJa/NRtRvbdWuSN2vXZPQ3n6wccOJ7V2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4n9Tq6Y4; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpO0WvBmMXmat6CAFl3wiVfzGEGjCv5sNGK3706pjUIi++DfdKmI6ImaAgcAw8C9JfNGzXIzerjIdJS1FUt3W8n66/xyvqrNtFxB/dduFmUQu7RO6rlzdYvml746DuAb6Zz5g8UMoFrWIaLhDnsfPhBqCGSLPc7d4mP4ciuY0tHXiCY/x2DDXJDgKF4jb7EMtxQolmfRtDLTIEdNfQ4bUVgm8L/1YIi7/FapJSBa4+7rv/799I+jvm0OkcxM4mrzPsqWRfzimdD/c5zANUkjrAqUJPMOCBZfhSnXkhQERVt+FKz94qDelTgOFsjmgDgq9Um5dQhFDqLtsAKEGUGR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j5EJ+4b6qZ+xVwAsIhJPAZwQU2HoC+mb3Na9BWA8bk=;
 b=Akvap8tP0DqLam8Nn4GHNtiiuSQHHwnUF26MyoAiHhzxjx1PLqxCGC2x4gI5zNpy3L+MNnEpLQ2k8ABcOetHkhh+9s/hNZ6CfxkLfdQ8i8oaaupUoQmVDbpG+Iv46Fm3D1VoN7ETZ+WfZmx4yo50CuaylLGduPCswcpCnrBixdE/iiN09UMV8MKb/js7wgTvzNMaq4SgarJdap5AERE1aEcKELNdb5CY0nn8rtGyO7tvBrOt4WqRjI2kN+EZEVqkqr5nOmU4adrNcPJnifZ2e/p7P7fVUkSfFoVGCGKNJcOksmlZ5LZ3wqCQv/JWdzw3Z0B6d1tOZoghKpAqdNyGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j5EJ+4b6qZ+xVwAsIhJPAZwQU2HoC+mb3Na9BWA8bk=;
 b=4n9Tq6Y45HO/wga0NT6FXR6rj79RBz+UPnfuhubL0FauVWuu8aLhSFHCLlCNpQAgrTQyNp/GmBsg/U3YcnhgLFItJpn2M4FasbMmxftVw6bSgjeiy/0vP2RRtKnxuwsg3zQ8fgi78vpq/TKxZ7vG6AkPxPPQsEWaArACxRdFx1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 16:35:20 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 16:35:19 +0000
Message-ID: <685c039c-06a5-4876-a918-bd1c810397a9@amd.com>
Date: Wed, 30 Oct 2024 11:35:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, qiuxu.zhuo@intel.com, tglx@linutronix.de,
 mingo@redhat.com, rostedt@goodmis.org, mchehab@kernel.org,
 yazen.ghannam@amd.com, john.allen@amd.com
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-2-avadhut.naik@amd.com>
 <20241030133227.GDZyI1a5rheucn86qc@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241030133227.GDZyI1a5rheucn86qc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: af0fec04-6405-49dd-98a2-08dcf900d7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm5xK3pDUmtPVmtnbUJxcTlCMCtaQXQzSWVKd0dlenRKZ3ZGSGRSV3Vjazlq?=
 =?utf-8?B?dUhZWkgvdVovOXJBZHFRMi9EOTFkRFNHbitLaWhMSFN3cVF6cFlEMEpKdHo3?=
 =?utf-8?B?S0QrV1FTSWlkWmM5K3J2UWNkeW5IMEdUT0E5Nkd4cFJPcSs2Qkx0YmY3MjZL?=
 =?utf-8?B?aUdrUnV1Rng5THNlOUtZUjBFUUJ3LzVkcnJKVVIxOXRFZ0RlYzRaSFIxV1Zi?=
 =?utf-8?B?U3haK0huVnhCamFta1hHSjlhVjFBTk43dHdicTduaWk5KzNpVWtSSjkvd0xJ?=
 =?utf-8?B?cU9keTcxMStOcFNYVWROeXkra0Yrajh0bDVQbEVIZkl6dlZJZ1hUNnBmb3Z4?=
 =?utf-8?B?cjF0QTNObTU3dFk4MXh5U1A2VW1DUjUzMVdKeWpyYklaZ1c2VEVKbTlhNHUv?=
 =?utf-8?B?c3U0aGlvTW0za3pxQ2tEWmFSaVVIYlhLdGc2TzVJeG5Yd21HblBOWW9qNjJ1?=
 =?utf-8?B?TjQ4RXpjYWFJaXAydU5EU3FQT3FybWZyUmZSZ3dwN1pVTEpMbk4wR1R4Q0hs?=
 =?utf-8?B?eGVMa05xd2YwZG5KcUxjbit3ejhnUzM0VFpaaUd1cGlzRk9JbXBIMkllUFc3?=
 =?utf-8?B?bmJhUUNiRTVLaG10QVR2U2l1Y2VmVitlcmlCZDZUVHdNbUJqeW14SXp3OHdj?=
 =?utf-8?B?dGtYQ1hJVTl5TFl4UnM4YVFZaVd3a25Oc3hXTUJ4RnNvVUlJL3hWTHhwL01w?=
 =?utf-8?B?cElkRFFuSDBHUWZsNFJ6Q2tjd0sxaW56RFpQSjlJeWo0ZkI1WmtLeERvTXhz?=
 =?utf-8?B?ZDFXbU05S1FNK2lMczMwSmUrekpMSnVORzExcDBFLy9JT2tXWjRmdnphM0pI?=
 =?utf-8?B?L1Z5QVE2UDVBTkxiZ3ZzVS9sbUkvVXQwZXNiVnRWMGxjWnB5ZWF3eVBUQ2pp?=
 =?utf-8?B?Z0E4dEgzdmk5ZmVib2R5QW90MTh4OVBGM2V0RElqMEpvODByRy8xV2E5RXpR?=
 =?utf-8?B?NVdsYnB1TTFrWmwzT3c5eHR5MzFpbGN6QTZRdkh6d05CU2I0cTdyd0xQVmZJ?=
 =?utf-8?B?enQ3c0lmemVzTzB6Q3A4eWlDeU0vVDFEdWZqTDFCNFZqYTcyVGg2bGxZNEtp?=
 =?utf-8?B?aC8zNUNpNEgzdmZKVGxuUFAzTFBXQ1QzRTdsUWtlR2pSOUlZdTBTTFZRTHRz?=
 =?utf-8?B?c2lyY0R2UzBRQ1Z3ZWh0RUVpOHp5ZG5Wbys4cmtwOUluOWFCYUswbWVzOEU2?=
 =?utf-8?B?Vm9mRjREN0lKMXM2NHA0TmR2NXpzUW83RFA2aWVIbEhpUEdFR0hHS3VNdlNM?=
 =?utf-8?B?cHZwUXhQcWtrVXlxSDZ2ZGovZ0x4eGk3dTRnbnc4ZGcrK0NFUjRvY2xWNm5l?=
 =?utf-8?B?T1N3UFQ2dWQzbG1tRjM5aExINGFPWDBNVDFFa1FBc0lHbFpvS25YNEcrckk2?=
 =?utf-8?B?cjl3MGc3TnI4NEhBZ3dxZjVGZ0NSMnFUYTJFaW1JSmRLUk8vSGlDZkJBdnNI?=
 =?utf-8?B?NUQ1ZGlsbjJvVEtzR3grS0w5Y093V3l3Vjk0Q3hrYXk2QXVpVVpLc0RYREZL?=
 =?utf-8?B?WlpQN29VSHVibDRHcEZqbFJMOEVCY2E5T2FqWEY1bTcyZ0ZLY0psc04xZzF1?=
 =?utf-8?B?YnllT2hBZEZBUEJORnhQT0hER1ZqUWZINHdPSDR6eWhQSDRjTlJEY2RrZkhY?=
 =?utf-8?B?Y1pKWWFhNHNyeFRvVlB2NUpCUGdTeVg4cFdmTFh2Q3hlUGlkVWt1VXQvRnp4?=
 =?utf-8?B?YUNnL215bEo3ZXFleU5Udmthd00wUmxkaTJJalFMQjlJNTRhdEhGYUpnOE8z?=
 =?utf-8?Q?uhXujMlirH5cZ8NzwFKq0qM2iMieiU6zAh4oLc2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjVzVDJaeUYrRVdWaXV2SnBKY3R2dEdZSUFuUUFFYm1YeVVqekY2dkVIU3hp?=
 =?utf-8?B?MGV0RTlJZXdQTDBTYmtlclhGRW5HY3R3RkZZT1loWXRHK3RJanRIK3dJVVBj?=
 =?utf-8?B?NmRldlpQVUhFbFh2Q2szVU5DVUxBRC9TeDJzZkU0Zk8xTHZ0UER5L2R2UGxU?=
 =?utf-8?B?QWl6ckhWSE9uOC9hbE5jd2hpS00zZzdmOEIxOHF0MG5aSkVXYWpEd1JtUE9J?=
 =?utf-8?B?T3BLV2hyTmNVY05BR2RvbFh4bFk0dFRFMy84bnlPcVlYeDV2dkJKMjZlcWxY?=
 =?utf-8?B?anlFRWtIRGU2ZWcwczJJQ09lVk1kT3BrUkp1ZFp5ZWdLUUtycGNzVEZHRS9t?=
 =?utf-8?B?VUdHdm5VTkxpb0NXRkZyam5ONHM0TWdFMitXTXcyTFcrMHpEY05FOUppOUlv?=
 =?utf-8?B?bnYwVHJsQXVOR2RiM3U5YVNwVS9XQVNoeVNCT3QvdmxENHBnNTRPZnU2N3BE?=
 =?utf-8?B?NzJQSmcwQTlzNmZyKzNnaGhrTktDTHAxbWY0S3VvMHhMN2xCeU5qYjdOc1Y4?=
 =?utf-8?B?L0xrYTUxMU5ydFNHTGZzUmNTcEs1VEtIMkNhalo1aU12SE5haE56QkRjcFV0?=
 =?utf-8?B?azQvUFlBQWoydFc4ZmtwdFcvenhoY0YyYktmMy9jWlVMcExUVXlnZ2QyQnBl?=
 =?utf-8?B?TWhwZnJSV1l3OUpNd0JrRFZnQnJkSUloVzk0SkFLbWNGY21hd1NldTBQVVdh?=
 =?utf-8?B?UWNlRk44MzQ1QVhpZ2ZDRFZ5dmdMY1p6UEdBbjBOdklqZml6UHg4NmVDZFJ6?=
 =?utf-8?B?UDAzL1RwTVJ2alpZL2RxUGxVRGV1L0U5YnpnMDBKd0U1VG13aUo0ZHlnTzlE?=
 =?utf-8?B?SDZCU2Z0YXRtUU5vTmtZRCtleVl3Y2dteDZwNk90TmdIR3VGYmZjWVIyZDZK?=
 =?utf-8?B?WEhScUZQTFVZMTlaazJXUUloQjRqRkd3eDhHa0Ivd0gyWndsVmtjTXVzMExt?=
 =?utf-8?B?Mkl5QWJNVXBFSVhoODlVdW5Eai85OWhHTUxLOGxsbmJneHNlY3NpR2duY0h1?=
 =?utf-8?B?azBrWDhPV3g3YkVXQyt6SVhuSitnOFo2RXRhR2pSNVQ3N3RNUVVQbU9BSGZ3?=
 =?utf-8?B?SEtxOGVmdzM1MGU4SzI4SUF2NWxDeFVrWm9kZnpaMUtXbUNqeGJEbkpUS3BJ?=
 =?utf-8?B?U2dLRHpQcjYrc2JXSVpUemFZRU1zZEpoOVRJSDY2OExUNU5TSzUzT2ZpN0hk?=
 =?utf-8?B?aG5hUnNvZEJVTVgxWW1WM1o0SGVPMzViU3d4MUJIajEzTWZZZC9LYXRxaEta?=
 =?utf-8?B?U2xOTUllelR6RGIvZFRkUHdrQ3dXTTB6NzIwWE5NZmRTYUwwSXQvVlZrWURk?=
 =?utf-8?B?eGNHSE1LcHhKVXF3U1p1MUxLYnY2c3VQaDhGRis4cHh0QnUwTzI3Tndac3BP?=
 =?utf-8?B?VG1URURSd1FpeHdKbkFUeGErdUVLVmJIUzduS2NlWS9iYW55cytqMTJXS2hM?=
 =?utf-8?B?R1RCSHFiOXp0YzQrQVpWa2t6VGNFU2lpbDhuU1pXQkFObEFWWGl2MUpiN0J6?=
 =?utf-8?B?UmRwZHIvcDBuWjFicmV3YTNOaDVHUjY2ZDBheDNRbjluOEczVFpUM2NxMWYz?=
 =?utf-8?B?eEo2NXd3VnpVSEFBRm5rT3gzQ1oxMGdrRk5udzk5a2dzMlNQRlQrVFZ3cHVN?=
 =?utf-8?B?UjdRUmRMZWJ6ZkM2Slo5c1ZMVWJLVngzTHNoNk1EUTZxV2RsWDVpVk1ydldX?=
 =?utf-8?B?aVFqcGJtamtCQkMxSUpMK3FKQjIwQUtZWFlQQmNHM2dGZHphMmZ0L1lCelMw?=
 =?utf-8?B?eHBFb1hsQnlNaFFFSWRLYUNXYU9vYk5vcTEvZU5FcVh1UmRoczkxRVNpTkRu?=
 =?utf-8?B?Uk9wZW1NeVE5Q1Q3MTBlZzUxM0F2U3QzYVg1SmlZQmlKcVcwR1hybXh0R2Zn?=
 =?utf-8?B?MkJncjFPS1QxN0ZBSFdrajMzTWs1VmZ6dXU4NGxTVUh4TnBiK0hhcThwV3hJ?=
 =?utf-8?B?cCtCUWlaVG53d2Z4QWhkTnF6UElnUU9BbkhwYWdDOEo2QW0zTUdXRmtUVjMv?=
 =?utf-8?B?SUhCNG9nTUg0TnRlMFlHN1B6cTN3cHoyZGlVbjhzcGNtcVhNRW5uUDQ3YytH?=
 =?utf-8?B?Q2FaN1RpT1Z5c1FITzRBd0RMaGMvYW4zeDlkM0pDeXRFYlJ4NUsrbHh6T3VT?=
 =?utf-8?Q?86CHYgQsr0fgckT5C6IztE8IK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0fec04-6405-49dd-98a2-08dcf900d7da
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:35:19.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KWGf9oATOdXJt9HH8l+7mxvJ04KZ6y22PFWo7AwF3mSPsojWWbiQ6TzNOz8SNt7p03TQW/qaWJPmjP3QMcYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804



On 10/30/2024 08:32, Borislav Petkov wrote:
> On Tue, Oct 22, 2024 at 07:36:27PM +0000, Avadhut Naik wrote:
>> Currently, exporting new additional machine check error information
>> involves adding new fields for the same at the end of the struct mce.
>> This additional information can then be consumed through mcelog or
>> tracepoint.
>>
>> However, as new MSRs are being added (and will be added in the future)
>> by CPU vendors on their newer CPUs with additional machine check error
>> information to be exported, the size of struct mce will balloon on some
>> CPUs, unnecessarily, since those fields are vendor-specific. Moreover,
>> different CPU vendors may export the additional information in varying
>> sizes.
>>
>> The problem particularly intensifies since struct mce is exposed to
>> userspace as part of UAPI. It's bloating through vendor-specific data
>> should be avoided to limit the information being sent out to userspace.
>>
>> Add a new structure mce_hw_err to wrap the existing struct mce. The same
>> will prevent its ballooning since vendor-specifc data, if any, can now be
> 
> Unknown word [vendor-specifc] in commit message.
> 
> Please introduce a spellchecker into your patch creation workflow.
> 
Will fix this.

> Also:
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
> diff ontop of yours:
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 3611366d56b7..28e28b69d84d 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1030,11 +1030,11 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
>   */
>  static void mce_reign(void)
>  {
> -	int cpu;
>  	struct mce_hw_err *err = NULL;
>  	struct mce *m = NULL;
>  	int global_worst = 0;
>  	char *msg = NULL;
> +	int cpu;
>  
>  	/*
>  	 * This CPU is the Monarch and the other CPUs have run
> @@ -1291,8 +1291,8 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs,
>  {
>  	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
>  	struct mca_config *cfg = &mca_cfg;
> -	struct mce *m = &err->m;
>  	int severity, i, taint = 0;
> +	struct mce *m = &err->m;
>  
>  	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>  		arch___clear_bit(i, toclear);
> @@ -1419,8 +1419,8 @@ static void kill_me_never(struct callback_head *cb)
>  
>  static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(struct callback_head *))
>  {
> -	struct mce *m = &err->m;
>  	int count = ++current->mce_count;
> +	struct mce *m = &err->m;
>  
>  	/* First call, save all the details */
>  	if (count == 1) {
> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index 504d89724ecd..d0be6dda0c14 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -73,9 +73,9 @@ struct llist_node *mce_gen_pool_prepare_records(void)
>  
>  void mce_gen_pool_process(struct work_struct *__unused)
>  {
> -	struct mce *mce;
> -	struct llist_node *head;
>  	struct mce_evt_llist *node, *tmp;
> +	struct llist_node *head;
> +	struct mce *mce;
>  
>  	head = llist_del_all(&mce_event_llist);
>  	if (!head)
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index c65a5c4e2f22..313fe682db33 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -502,9 +502,9 @@ static void prepare_msrs(void *info)
>  
>  static void do_inject(void)
>  {
> +	unsigned int cpu = i_mce.extcpu;
>  	struct mce_hw_err err;
>  	u64 mcg_status = 0;
> -	unsigned int cpu = i_mce.extcpu;
>  	u8 b = i_mce.bank;
>  
>  	i_mce.tsc = rdtsc_ordered();
> 

Ack for the suggestions.

-- 
Thanks,
Avadhut Naik

