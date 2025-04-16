Return-Path: <linux-edac+bounces-3567-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B7A909F8
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF551882235
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A121577A;
	Wed, 16 Apr 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OrOJ+Fuc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F721B424F;
	Wed, 16 Apr 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824422; cv=fail; b=V8CTH8MGHrYBv8qsjN3PyJidDurQbtbV9QqtDldjhGfM1DDxXl7AIc40Z3J6dhNsNQ6ilMkooD+fdTmW1Wj/6zxAzunpUYiveJIO9LDWVxFqnwxYC/ZnSqS7XHnGcJCnY0caBwh0ymXLau1tZRXv499k0/6HSn77WvwDR2SPLfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824422; c=relaxed/simple;
	bh=1W2WV181J2Vhs7wBLerh7bR0VOV5FLGpA/omdfnciL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yaft7sdrDeiGXchtPoznJw6tFXtjoZdGG8op5CDq9qu5h+FAOwoHmYgv3JSfYS1ahy9YR0yVHT9lwfg2Brt8TZV/olp2fQvpEBSTl/b5q0vfEOAdA2OT2gvZDdC/uEaYrocufZZNF6b32BkD3bPg1ua1dv+PDlQID5p6ZbgI1Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OrOJ+Fuc; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oObhaNN8UGEtMADckXA2ZpE+D0z8CfpaY7Onpj8PH8t+h3JmOK7IVBBQ1jmWMQA1Z8iIK/ennbtuSvRnyzK91cZIV8eBg2g9zhkjMA6ttWunlmen0tt4ItBemQ1/H7XUdnfW5T1iWvIWlF0OiKlNc8xO5LhBX4k78aqKc38fNrapQ/HPL6UICU11R0CFK594CgnyZUvfYvAcBVKyAxN33WAmddYh8wdyrh57EwCq0h5Vmm85TNkfelX4hu6QMvzlLhiFh5Jz0smRzSqigR2a5el03+zQuPDTiV2NvV6SNXlh0MzYA+3B9HLJuQXkaNdxg4JHoJC5AUvK6S4RVN2rGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XpeSJMx4tYYlZhpZv13G3bQG6KC4n55RYKpJlQIk5s=;
 b=Lje/K2sSOCHAD/1SZf8zYHofHycip4J5ROL4Ww4bS5krztp+aUKlu1zKZvwl+eizQry1uBjytei3hV9k0rKs4o7+IULiEsa/d5zdC4ec2As2/IIy/6FnVHZz/hMvQDziotK+yhCSO8SpIax/DfD7+DXanH9C7L6Wrn8b6eN7hVEeEe5Opv6/5FgrYO4U/YDcPZA3bZp8HDIker64PAmI2JcqXQItDg735PCk5oGhE0heJ1iKPSptQ+V073aJpSSzRRp8SCB9SRHcVsgOIppqAsUQI38ZryuAOTxmod+DczZgVBrc3vrnlWpaUs2n/8i6qmBtnsezxayMPn9Nk7o7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XpeSJMx4tYYlZhpZv13G3bQG6KC4n55RYKpJlQIk5s=;
 b=OrOJ+Fucr3nmc5v04gHmtp6J30KROQ/CVrQCmJ7yvJYRA+2u0X1oCYWZMy4wjbwjn+2iomjCbw34IP/cRMz/zJmbXydHERKEfn7M/PFDx3CG6bk4pjuZclZO+8TG6TiRoOilE/UgaXPcVJFoXdl6jY6z7d9DYkljyFof6UjpktU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 17:26:56 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%4]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 17:26:56 +0000
Message-ID: <8e7e84c2-e035-49f2-b277-7639919213b7@amd.com>
Date: Wed, 16 Apr 2025 12:26:53 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20250415213150.755255-1-avadhut.naik@amd.com>
 <20250416141033.GB918127@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250416141033.GB918127@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:806:d1::17) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b01445-3567-4cd4-e5fd-08dd7d0be23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWF0UEM5dW9rN0FzekVhdjNnU3ZRejJkWkI3RWxiK1pMYUhkNHU1bmwyM2Rp?=
 =?utf-8?B?Wmg5ZFZlZ3JrUktLcVY1ajB0T2laTHdWdG1naE5teStOWk4zeUJlbnBMMnJq?=
 =?utf-8?B?dUtUY1NJaVVaZFJaSU5XZU51MUJpRWF3K2YxMCtrS3hrVE1jeDdjamxlU0d5?=
 =?utf-8?B?K1VxUVNzVE02clhvMUl4SSsveG1MSjh5eDdhYUxSRWl1S01aZmVKVEZXUEZ0?=
 =?utf-8?B?eVBxb3JUWHpRK0lTS2JId2tqbUNxcUtJUHBHZ1l4LzRsUmN4NlFlS2tpbzh5?=
 =?utf-8?B?b3pwZVpYb2RndDNwNFFGcU1TbndHOTZQWDllTHVlQ2VGaVVaaDZIbjk1alU2?=
 =?utf-8?B?QlFnNUthbnY3ZmV0am9CQVlsNmRlRXhSYkRGVkFZK3crZHlvdDZyUzUyNmRa?=
 =?utf-8?B?dXB0MUkrQldIdzNpUWNTRmlQVExrdEg5RWdlN2lrcXk1YTlVZzJJZ3FwWXBR?=
 =?utf-8?B?V0NKdXZ1aTJMc2Nvbm5WMXR3cTZJeW9VTVpjVjNOeWExRXgrNFRCVFRoTlRo?=
 =?utf-8?B?T0poMjl6ejZoYkJsY1hGU3d4MVBuMDlwSDdEYWF0WUhYNURmNEJpNHZhS3F1?=
 =?utf-8?B?WVppaFZKbjQ0SU1lME9xNjVtWjYzS0liVXNOQzM4bFhKYmRVeERzZTdkZjB2?=
 =?utf-8?B?dkZPTlVYVFFVYkcrRTFsdHZpTFkrK2JTNU1DTEp0OXZDa2ZiQlRsYk5wLzZK?=
 =?utf-8?B?MWxLb3FPQk5NVGlKVnJxdmc4L2ZTV0VDcnhhb3hjN1EvM0JObEFCc1h1UUlY?=
 =?utf-8?B?KzMxTjNzc3hISTJ0UGxBb2MxM1J2N05kckFOYjNVTU5WQVRDaWRBVUtwQ2RI?=
 =?utf-8?B?aGlaYldNYVRrS1hBVStNakg5VWM2QnI5Vm9lNzlBNG1EaW9HdDVTTVh2TW5S?=
 =?utf-8?B?RHVYWndaYzAwNDNLbVVLZlVRYThVdnUzN3RqNVBPTG9rL2hCNFBtNjd1SHRC?=
 =?utf-8?B?Y1g5cVVNZEZEa2xEZExjQWltNlBIb1lPR3JKUjl1eUkvQ3hHMXJpYXNlWVhX?=
 =?utf-8?B?UVhtWjN4YnpPR1lUaGFUcURPQzdGNnplKzBGZE9PZ1M2RTAzM1phVVhSWDBP?=
 =?utf-8?B?TzEyblpBVlhKVG1xMFcvQ2daNnJ6bXVPajY5aStCbGRFdUtGd2VkeVVCYmhL?=
 =?utf-8?B?OEFwT3VDTkFRS09nVVVMTUNhai96eVZYQS9UbUh5QkE0TE9KVEl5OXpBYTN6?=
 =?utf-8?B?THZGMktmMkZhcEsxcHBQeGxTV0xrcVFDVnA0SVBNa1pkMHNMMU5PKy9QTGtr?=
 =?utf-8?B?QVVQd1JiUnZSejdXamdiUGJvT0JVaHc2UXJpVVo1bGJScXZEMExpaDMzYnBv?=
 =?utf-8?B?VnhLeDFWSS9LRXZoQTFTWERzZWVpdTVmR1k0NXFnbWVGYVJhaGtXMUxvcytk?=
 =?utf-8?B?S2k3Ty9OSVlGS0w0YVExb1FxQzV3aGhWYVhGTER1VVdJVEhGVmhUdUZ0bHFZ?=
 =?utf-8?B?dE12aWVpL2tPK2wrLzFnODc0THNULzR1MzlZSHhZZzZiTXltb2MzcTFoK1Ny?=
 =?utf-8?B?TC8ybEViRkEwMzBQMGEvOTR4dG5vY3pPeFEwbmsyRk1ObXY0aktlNDNSWjUr?=
 =?utf-8?B?dVBkbFkyR2hPUXpTM0pJUkxWVE8yMWd1VlphY3B6QTlHZStOMEQ0eFFVL3Bj?=
 =?utf-8?B?bWlyTmlJWXBOVlltcytaTUtEZFJvdEdIbDBhMzhzNGQrd0x2S1hRNHhmRWlJ?=
 =?utf-8?B?TVU2RFlOZGQ3eldPdTNBSFZ4S01VZ1VKdTMxZDh3bnkzK2ZMa3BwelNzL2Vy?=
 =?utf-8?B?ZXlaK1FrRHh4TTIyMUpWNVdYTmRZSlBHQUN1UHFwOWErTkdRS0x5RDZWdWJj?=
 =?utf-8?Q?kw0ViHZfjODaBo8K1Afc9p8GrI/S0Pbjff4eg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1M4eVhpQnpISmJ2N3lrYkE1TGZiSk03S0ttT2drZDlVSkhsQzkvdkwzbG1i?=
 =?utf-8?B?aWR2R3JVc0lzQ3Uxa3lQR1dyVnlSUm9sYzVUNlJxZm1UV1JRbGJvVUJKSmxI?=
 =?utf-8?B?c1dldzM3UWxKRFFBK2dKNGdMb2pCd1Z1WWdmNDRyYVhCcEMxNTdRWUJyZ3dv?=
 =?utf-8?B?L0ZWRjY5UHkwL2txb1ExVkk5YzVnd1pKbzJHWHhGOTBSYWNtUmRTZEprMkJn?=
 =?utf-8?B?S1lhTW1kQndJcm9CR3FYK0hhdUpZM1FGQ28rY0NoV0VMTkVpbUM1NTgzUEMv?=
 =?utf-8?B?QTVsOC9XZVBJUkZuMkhUWEY5ajRFNG1NQnRCZUlPYUQ1Ymo4Qi9NcXZkYmJh?=
 =?utf-8?B?Q04yNU5uQW80aFpjajJzWERqWnhlN3BYVmRnTkJOeFRDWS9JbyszbWJSWndL?=
 =?utf-8?B?SG0rT1ZyRFNYWGpIWklpT2FXclJ5RVEzejFhNjV6YWNjNWZlZHdsVGhlMGU2?=
 =?utf-8?B?K2d0NkFBOTQ4TFNkSlJJS2h2UFljbmpoOUFxUWJIQ3h1Ym1wek1DM3A5ZThj?=
 =?utf-8?B?Q2xPL2hEQjcralFITWYxUWtFWXNrVEhid2xKYXViL0lzK1RiaFVKNENvZVFW?=
 =?utf-8?B?V2dGdjhmS3h2NXp4RGVkT3JqZW5TUDJEenRmMWxqYW4wV29kY0FiR1pvTDQv?=
 =?utf-8?B?TDAvR29QVkQ1OUZWYzN2cytKU3lUSWcyTUg2MUV4UTVYeUhHcXV3OTlTR1pn?=
 =?utf-8?B?TS9BYnY5ODA1ZE51L3plQjUwYUtJWVZjQ0pUbXRmODQxWUVZMURWTmd0YUM4?=
 =?utf-8?B?Unp3WTNXcVc4Mk9hNkFySHhFSTcwYS9Jb1R4V29HYW0rcGxMN1k1UE5tcWhB?=
 =?utf-8?B?TlFmSHNlRCtPOE1uc1FoRVdXK1VDQTM0NS93YmxmQmF4YUJIdjFuNmFQZWgy?=
 =?utf-8?B?NkRqcEY3YSt0MVhmTk55UFJGNDZkT2p1WTU5OXVMWVRvaHpaaDVRRVlkYjR2?=
 =?utf-8?B?bS95ajVnZlZsandKT1ZsK3YweEJFT3Ixc0VDRks5TFQrclpjMkJ4Mjl2NTRG?=
 =?utf-8?B?WEJPUFgyVHFtUFQvdy9xUXgvTVRpcjZsQWdGWFBGMlNzc0dCamJqUEFhU3V3?=
 =?utf-8?B?Y2w2dTc3enIyUUgzZVpUUkpvZEdyN2lOM3VkQVBtM2duWEczY21QYVRmeTJu?=
 =?utf-8?B?OWtrM2JTQzRhWlhpUEZZMFk2ZE1jV3JVRytLVTNWcWx0Z0ppL1B5dWhTN2tj?=
 =?utf-8?B?clcvVWZrVkNBUjIvMVl5czQxbmx1eTN4VzU3K0tKYlo4Nk16a1IyMm9iNzFV?=
 =?utf-8?B?WlNtUTNHWVJuMElpelpXek5MSnhWRzlWUDAzdmpjekJoY01maC9MWUxmREp1?=
 =?utf-8?B?TE8veHMxRytzTkVhLzZjbktQVTVrMGFDYXVxSDYzN1Jna2xVYkZhV1FYd1hN?=
 =?utf-8?B?R3lsZ251MzNKb2VNb3d1OTJFcXJlZTVhaExIUFlLMFJwWHRIY1E4bHZNR1U0?=
 =?utf-8?B?NHVrWkZmOUNXVCt1S1gvWFp5Y283eWRuTWJKQmN5akRNL1NiMWhUdkJWWjli?=
 =?utf-8?B?MUFjQ1ZXRVB3MDJPcWpUYXNnZkVMYjZPbVFvSHh1eDlVWVVXeGdyT0ZvcXdO?=
 =?utf-8?B?T0RFbjZpK3NldHJrZlZPamw0Q2QzZXhiNnJ3c0RKWDZNVDlsZ3NFZVJNb0pD?=
 =?utf-8?B?TVJjTjZ1RVhjWExQRk01a2VSMmJ5YkVsYmVRaHZmRU5HSUpwaGYzK0pSbzhY?=
 =?utf-8?B?TmsrTkVETTNIVXAxU1Q4M0dYcms5b1ZlOUhEcjQ0V3U0SFMzYjlYRXF1eFky?=
 =?utf-8?B?Z0huRmtNc2dKWmlyMDlDMFNGc2xwSTNrdUZaQTRnekhpMnhJUXlnb3phZTZa?=
 =?utf-8?B?Z29PRmpyYWZ2S1gwNlgzY2xlYnU5REFWcTZlakg0alFhYmZNajh4VU82Wi80?=
 =?utf-8?B?NTVlci85RjBzaElIWTVVQ01BVTRGcnZLLzVjNFZYYTZXWmVHbFBJbC9HNEVy?=
 =?utf-8?B?SlVjbmVISUptUWIzangxSGlCQURCcDV3eUJmYm5IMjBERGF2RWlYQkRYckVH?=
 =?utf-8?B?T1ZGT20vVDhndm1sRkRQZU9ZbUZ4SGwzNmYzaXR1UTNoYUNrYjRyVlRKeEY1?=
 =?utf-8?B?eVU3eDJpVXdsZnJ2WjVHb1I5RkI1YkxMR1lTTDRubUFqdFZOZjZwbWNKS0NX?=
 =?utf-8?Q?azpfoqjPJPlDUuGkIaT0Q582F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b01445-3567-4cd4-e5fd-08dd7d0be23e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 17:26:55.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k68sBwKYBogCoi3rr6iBFRjvV1uI36s0Asg/PHh8k2F50AURwlk7yJNMnU7M7VJZ33/W1KGu01ENi9UodBmgCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155



On 4/16/2025 09:10, Yazen Ghannam wrote:
> On Tue, Apr 15, 2025 at 09:25:58PM +0000, Avadhut Naik wrote:
>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD EPYC
> 
> This affects Zen-based systems in general, not just the EPYC line.
> 
Will change this to something like:

Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
register associated with it.

>> SOCs has an Address Mask and a Secondary Address Mask register associated
>> with it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS
>> granularity during init using these two registers.
>>
>> Currently, the module primarily considers only the Address Mask register
>> for computing DIMM sizes. The Secondary Address Mask register is only
>> considered for odd CS. Additionally, if it has been considered, the
>> Address Mask register is ignored altogether for that CS. For
>> power-of-two DIMMs, this is not an issue since only the Address Mask
>> register is used.
>>
>> For non-power-of-two DIMMs, however, the Secondary Address Mask register
>> is used in conjunction with the Address Mask register. However, since the
>> module only considers either of the two registers for a CS, the size
>> computed by the module is incorrect. The Secondary Address Mask register
>> is not considered for even CS, and the Address Mask register is not
>> considered for odd CS.
>>
>> Introduce a new helper function so that both Address Mask and Secondary
>> Address Mask registers are considered, when valid, for computing DIMM
>> sizes. Furthermore, also rename some variables for greater clarity.
>>
>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
>> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> 
> Checkpatch says this should also have a 'Closes' tag. I never thought
> about this before, but it is mentioned in 'Documentation'. 
> 
> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
> 
Will add this.

>> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> 
> Minor nit: TIP tree handbook say 'Tested-by' goes after your SoB. I
> should check my submissions too.
> 
Had noticed that in some recent commits Tested-by immediately follows
Reported-by. And, SoB follows Tested-by.
Nonetheless, thanks for pointing this out. Will follow the tip handbook.

>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Cc: stable@vger.kernel.org
>> ```
>> Changes in v2:
>> 1. Avoid unnecessary variable initialization.
>> 2. Modify commit message to accurately reflect the changes.
>> 3. Move check for non-zero Address Mask register into the new helper.
>>
>> Links:
>> v1: https://lore.kernel.org/linux-edac/9a33b6ff-9ce8-4abd-8629-3c9f6a546514@amd.com/T/#mc0b1101055f12ccb06e5a251d16f186597ed4133
> 
> Use a 'permalink' rather than this threaded link. Search for
> 'permalink' on the web page.
> 
> Better option is to use this format:
>   https://lore.kernel.org/<Message-ID>
> 
> As shown in 'Documentation/process/submitting-patches.rst'
> 
> Ex:
>   https://lore.kernel.org/20250327210718.1640762-1-avadhut.naik@amd.com
> 
> Side note: I've been adding 'r/' between lore and Message-ID out of
> habit. But it seems that this is no longer needed.
> 
Will use this henceforth. Thanks!

>> ---
>>  drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
>>  1 file changed, 36 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 58b1482a0fbb..91d22e63bdb1 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -1209,7 +1209,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>>  	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
>>  		cs_mode |= CS_ODD_PRIMARY;
>>  
>> -	/* Asymmetric dual-rank DIMM support. */
>> +	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
>> +		cs_mode |= CS_EVEN_SECONDARY;
>> +
>>  	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
>>  		cs_mode |= CS_ODD_SECONDARY;
>>  
>> @@ -1230,12 +1232,13 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>>  	return cs_mode;
>>  }
>>  
>> -static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>> -				  int csrow_nr, int dimm)
>> +static int calculate_cs_size(u32 mask, unsigned int cs_mode)
>>  {
>> -	u32 msb, weight, num_zero_bits;
>> -	u32 addr_mask_deinterleaved;
>> -	int size = 0;
>> +	int msb, weight, num_zero_bits;
>> +	u32 deinterleaved_mask;
>> +
>> +	if (!mask)
>> +		return 0;
>>  
>>  	/*
>>  	 * The number of zero bits in the mask is equal to the number of bits
>> @@ -1248,19 +1251,30 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>>  	 * without swapping with the most significant bit. This can be handled
>>  	 * by keeping the MSB where it is and ignoring the single zero bit.
>>  	 */
>> -	msb = fls(addr_mask_orig) - 1;
>> -	weight = hweight_long(addr_mask_orig);
>> +	msb = fls(mask) - 1;
>> +	weight = hweight_long(mask);
>>  	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
>>  
>>  	/* Take the number of zero bits off from the top of the mask. */
>> -	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
>> +	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);
>> +	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
>> +
>> +	return (deinterleaved_mask >> 2) + 1;
>> +}
>> +
>> +static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
>> +				  unsigned int cs_mode, int csrow_nr, int dimm)
>> +{
>> +	int size;
>>  
>>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
>> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
>> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
>> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
>>  
>>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
>> -	size = (addr_mask_deinterleaved >> 2) + 1;
>> +	size = calculate_cs_size(addr_mask, cs_mode);
>> +
>> +	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
>> +	size += calculate_cs_size(addr_mask_sec, cs_mode);
>>  
>>  	/* Return size in MBs. */
>>  	return size >> 10;
>> @@ -1270,7 +1284,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  				    unsigned int cs_mode, int csrow_nr)
>>  {
>>  	int cs_mask_nr = csrow_nr;
>> -	u32 addr_mask_orig;
>> +	u32 addr_mask = 0, addr_mask_sec = 0;
>>  	int dimm, size = 0;
>>  
>>  	/* No Chip Selects are enabled. */
>> @@ -1308,13 +1322,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  	if (!pvt->flags.zn_regs_v2)
>>  		cs_mask_nr >>= 1;
>>  
>> -	/* Asymmetric dual-rank DIMM support. */
>> -	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
>> -		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>> -	else
>> -		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
>> +	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
>> +		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
>> +
>> +	if (cs_mode & (CS_EVEN_SECONDARY | CS_ODD_SECONDARY))
>> +		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>>  
>> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
>> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
>>  }
>>  
>>  static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>> @@ -3512,9 +3526,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
>>  static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  				    unsigned int cs_mode, int csrow_nr)
>>  {
>> -	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
>> +	u32 addr_mask		= pvt->csels[umc].csmasks[csrow_nr];
>> +	u32 addr_mask_sec	= pvt->csels[umc].csmasks_sec[csrow_nr];
>>  
>> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
>> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
>>  }
>>  
>>  static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>>
>> base-commit: b4d2bada09b17fcd68a0f00811ca7f900ec988e6
> 
> This is a tip branch/commit. However, you should use a 'ras' tree branch,
> since this patch is totally within EDAC.
> 
> Repo:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> Branch: edac-for-next
> 
Had initially encountered this on tip kernel and stuck with it.
Will rebase though.

> Besides the process notes, the patch looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


