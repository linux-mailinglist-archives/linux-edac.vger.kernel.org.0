Return-Path: <linux-edac+bounces-4813-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCFB59D0A
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEFA74E17BF
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B629D29C;
	Tue, 16 Sep 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GYkFgj7z"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04627E074;
	Tue, 16 Sep 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039003; cv=fail; b=MSWd8J9fQXdA375QLHOgamD+Zox6UwjYqG7rq6rXxmOhDp44gtL1hBvQmHFW1hsdf2mRYS5T37coW7D2nzwjBrk2xLH3Aws4/oEr3AYHBAi4VQO1D4Ty/4nuck3y7brdJa0qoxvJIKzzVRxTqdhfviyb5FbCaE2N/glFXC3y+lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039003; c=relaxed/simple;
	bh=ufxVHXc7KlLQtyjw8i06reybTSZfB+5oI8vmjuKlWlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nvaf+t1rRJF4ghMZCkxgfqCqLCm7aKbyWz586yvn89lJSWDKJ/4m+lYSU9NGgDdEUrW8g2P1YlQH8TPzVljKrvM29AdVOTDMEa+Bzz8KWFdoB9ABoubDZKZZAqgwi8AKDBwWVFMBvUZT2SkR3ZAHXJHwkpSGPOxBd4bsnI9XLdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GYkFgj7z; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBsmWuz4E/cEhM5QnCfK7HQlL+2AaVmqQkW0EqA6i70ePIcCr5fl4WYPXsN0Vt4gTEJZbAVUeRP9NIH+sxhp/Mox/SZiREiK2TRM2QqdgfAgTWZYJYPm0ec3H0Oujm/vJr14qdSFQ2WktbA/pFi5b72FK0zJ6aEY3OGWRv4Zj2YPOvL3BQR1yNb1uIochjap/FMkxWS6CUQ+ZBIegV3yHDZ/MQfrLKVnjIm55PYGJz9gNBkes7cmDf4wUVWP31vvuAHB2J+j4NiirZPSyhYy+XCFm7qo6VMy2hKyydoSk1KhC+IfmRbtGmDmw4wfZh9ZHEokuWIAZJ7O45oxJ3lmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnWvtGcZ4LqQ50WSQqQb+y5d5j3F/sqxnaYpSRG1sGc=;
 b=s8Es1pE2R8vJqOv5bDPAFpmIlWoeUlRMen4C4E6HsfzZt3H32/nCyKxHvZONkmnis71/6LLWThNZLBG2zANu2aQzrnG8PAyXmnXOgUzyaSnDxple9qGeChlm1ORARJLgVXbtjHDrM5Jr6eHxGZRAiz2NHjS8gFsWQOPX+4xKJWwBZ8KPxqqxsil5ffaK7/qmeXU/kCORxPTiUyOi46HcfgFFFomlT04ph9icPr2a1rw6F9uvTNZDiwpWn8VBgK56oQ7Ysipd6OvC8zLfUoiaSS36/dPa6wRk2/vZkuS3dLyA7WOZUEB6oz6FT2Xcd5uZa0nMOkUwhb+P2gWMjXBlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnWvtGcZ4LqQ50WSQqQb+y5d5j3F/sqxnaYpSRG1sGc=;
 b=GYkFgj7zidaciW4rs/n58DgclQcl7Y+LcgH61TC/Lb9skAJ0p+sQDh+kcYNvZBY4DgXhYxsoiKgVqhbrBQT+g6g12XRmlb0/3UYKOIwRsSDxCzASWDZIPoaCNWBnhJuwmNJsJ10H0XS/+DA+IAkrPnGoELtFfGXTP35bLnTJ3oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 16:09:57 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 16:09:57 +0000
Message-ID: <b33562a9-e143-485d-b1cc-94a79a2cf6a9@amd.com>
Date: Tue, 16 Sep 2025 11:09:55 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 5/5] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
 bp@alien8.de, linux-kernel@vger.kernel.org
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-6-avadhut.naik@amd.com>
 <20250910152427.GH11602@yaz-khff2.amd.com>
 <ba326dbd-5216-4294-b645-c4ff2a2f6578@amd.com>
 <20250915170420.GA850348@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250915170420.GA850348@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:4:ae::35) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 09435664-b5c9-49fb-b2cd-08ddf53b7aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1dyTWxwTG0yVzNneGl1Szl6K21vaDJ1V3dweTdxNVkwWCtDcWw1VExXY3Ew?=
 =?utf-8?B?TUlyMmJOUEFPZ0dFd0VYcUo1cTR3dythckdudm9UQjF3Mitpak1ROTQ4bXBJ?=
 =?utf-8?B?eCthYjVSaGlNVjhpS2NhOCs1TVJGeW5tbW13NjRra1ZIc2ZENmhRTzhYeHhY?=
 =?utf-8?B?MkRhMWhybDJjczdlSC94WUtXMFQ0ZnErOG9YVUw5Mk9jUkwwMmorYkdDWmJV?=
 =?utf-8?B?Ym5uYW1nVVJGSldjK3N0UWxQRVBJWHhicVpPaVhVMG1jNlZOOHBJRldvbFlY?=
 =?utf-8?B?MjdJa0lJUTZPUmxHYVlSRGoyczNOa0VLQWRsQ0FyR2gxNlFtZ05PdCtVcEg3?=
 =?utf-8?B?cWtaeXZrQmhXdGFoQm40emsycFVVeVBJVUkzVVQxa0JGYW1SV2VqSm1ZalBq?=
 =?utf-8?B?OXJ2Nk9ITHdKbXRYZCtwSjdvdEFSS0hNS0N3ekZYS1c0ZnNOVk91MlpBNXph?=
 =?utf-8?B?TUdLOEtVbXZJVlpwUzR3ZlU3cW00dXd1N2c3bXRRUk5pTmx6RHdWV1hEYVNM?=
 =?utf-8?B?cDFWNVFxTHRNODhrcVZWUGdWMTVjNkIyY004S3ZQZU9RQk12OHhUU283dDgr?=
 =?utf-8?B?SkJxTlFhNTNRWkhCNGdBOU1hSEFMT0duZytsUzhkRytEZWErN3lNSGQ2QzBO?=
 =?utf-8?B?UXRlY1orVC9heFFnRlUza2VqaDB0NnRMUnhTVzVLVlllbElYczV2U0pxM1R0?=
 =?utf-8?B?eVZ4aDRwZTBRL1kvL2pQaE02UzdMOTFLWFJEZlFtN3d0U0RvWlg4ZVBwUVpx?=
 =?utf-8?B?NHhZUnlNcEwvTXUwdkRCaUVaRzFNNEhIcUVKWVNqZHU1RXQ2QjRYQ0IwZ01S?=
 =?utf-8?B?Q1J4MzlpZ3RQVDE2WjBNVDVRL2FkRXlWNmpMY0ZDcDFWSlpacUhZdTlRRE1T?=
 =?utf-8?B?YmhvMzVnMVN0ZjU5UHF0Vk1jTTFtY0pvZUlsMGpULzdOUnhNYWY2cElaN2VM?=
 =?utf-8?B?LzJIVjRWNk1KTHdMbHJWWk5XcTc3MDhLS1J1aSt5YWxjT3lxeEx0QnFUNVV2?=
 =?utf-8?B?MTk1cThjM0JPZXR2bFpPbWNEVFVKUTgxVHdOTG9GSkRVWmJNdzFFajMvbHlD?=
 =?utf-8?B?SUw5blo5NjBMQjVUZ2NmMjRFSWxGMU5BdDFJRHJjVldwallya1JXUzE3d3FI?=
 =?utf-8?B?MXI3RUZaRUU3VjROa0FzaTUzc3RYTzFPUlpVSUk0UVk5ZFB3K0FNVVByaGdU?=
 =?utf-8?B?U3QwSnpEeEszS2YrOG45YlFvQnJCeGhVdlplRzdsOHIrb1RWdEU0cWJ3QlRR?=
 =?utf-8?B?UFFyWm0yajVESkEreXYybmZDMVlhNTI2TkR5NVArZFFBbktnMjZJOXJuVXh6?=
 =?utf-8?B?clRBY0JDbmtzM08raWNOeDJWNy9VUFlTMkNYdk81VTB5NGRaOHcvRWtaNi93?=
 =?utf-8?B?MWpMb09wMVVLQXJSNG40Wm1HeVdDeVJnZHhTR3VDV0hYUGpwdzJHWlNSL3FM?=
 =?utf-8?B?NHNSWEVtU0ZTLzA0cXh5bnBVd3hXaXlDM0ZZRWlGcm00cGtNbW5uYUtYdXhZ?=
 =?utf-8?B?UWxGT2hKVEp3a1VOT3kwejN2ZzNsTkxhWi9qWUNCL0t0SGliZTNNSm05dzA5?=
 =?utf-8?B?ZHQwc3ZGY2FFdzY3S0FWNHF4MllleE4xVWJvNW1Wb0JWeWFKRUl3UGNQLzE5?=
 =?utf-8?B?S3ZyS3JxRks2dzZ4ZUNCM0NSMHRCSit5Q0lSRkNockEzUHg4cG50U0MyZWhm?=
 =?utf-8?B?cU1YRTUzTXc5VWNvVDhqSDNOSkVCT2YwMmt5LzJiQ20zc2ZRcjQ5RnJQQS9x?=
 =?utf-8?B?UllhSG5RZFJ3T0ZKcmViT01yc3J4Ly9wdWYvMG5XM0pjaE81SzZDOFZrTWc0?=
 =?utf-8?B?aU1FM1RtN0ZVR2gzamZBbm5yWmxRbW9qWTJlNE5yNTdxVUorelZTZENYRXBF?=
 =?utf-8?B?WUhOSXlSa2t3dnZFOHZEQkdyaUpzdjY3dU9LVGJVV0s4ZnU2QjBVTWc0MldU?=
 =?utf-8?Q?kZKzOdX0S3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXpZNTNXcmNvUzZiSmdxdVRYelJqellVTVlVMG5PNW1XZnVSL0MvSU5XVmZx?=
 =?utf-8?B?MkI5NmFhYVgxbmpPNFRWakdXVXAwaGxRcnRITzBXNzZOMmxrdjZjWGovSXEx?=
 =?utf-8?B?MHJlRWV3ZjcxelR5VnlFa0I2VWUvcndYdGRYSk0xZ243M2ZERDRsK2JSUEtS?=
 =?utf-8?B?L2pBR0krVFE5akNmTy9wVHgyWkI2OGdVVFdjUHk4VmN4aDBRUjEwOEc4bmw1?=
 =?utf-8?B?aVFrTHFtc2JjbXJCMThYVkc2ZzY4ZC9kR2lzRXkveFJqeUl2NUNlSFVGb25N?=
 =?utf-8?B?VWdxeWNvTXMybFpVMGw3ZjVheWc2cDRNQUxQa2VkQ0daUnBjVHlWVk5YaENB?=
 =?utf-8?B?RjZQNW9YRml4NHRyWXJkaTVMSERBU1JyckMyRXFKTUlyckFCOEJzRC80cFVM?=
 =?utf-8?B?bzNTWHVBTlVZMnVQL2ZjcEMveEk1MC9sSUZ4cytJb1oybDdEUDJ0MnE0MGd0?=
 =?utf-8?B?M0UzT09uTmhLam5kU3lHNmh4MlMyTm9QQm50R2tFbHNmYkNiai9HUWg2NXk2?=
 =?utf-8?B?b0pZRUFlWEdET3BqSjVTcjNoNzRGNFNwUjQ2aTREOUVrQmFtdlE2ZUZuYkFt?=
 =?utf-8?B?SDJPREpickp6YlNFWUdJQkxWckVqKzEwTkVUOHBiYVllUTlKSzFST0IySWxn?=
 =?utf-8?B?Z2VUSzNMZThFdWFaQXJub2pudmZnZWtvNTJIUnQ0WEJHRU01UzlKRzhKODMw?=
 =?utf-8?B?UDhkMlFlZ0ZVdFRSWU40YXV4OGpNVGZLcldjRWRMMEg3S2NrUFJ0M0VVbVdt?=
 =?utf-8?B?QTR2aWVXNEpMYysxMEkrcHlUcnc4bzRadzFPbk1DeVg5akE1N2V2SnhYVVpp?=
 =?utf-8?B?YklnVGUyU3JES29mQWxETlV3SThwSHpVam90ck4yQjFRRXFKU3lCa2dNSHcr?=
 =?utf-8?B?VXRoL2pMRHdpWER6SmI5bFg0NFBuN3FlUk8vTkRyMHkxbzlrTHZ3UjRWMEpS?=
 =?utf-8?B?TmpPeHRMamxIeTRDTE5TcGZTZVZWQVlhYkRaVlU2UHpOdXpTUStrWGxjUWsy?=
 =?utf-8?B?MHpzcGdsMXhMU2JXQmJLRzRxbmtjdFNkcWNqOExkZUltQXMwellwL1VKT281?=
 =?utf-8?B?bW5GVUZIUmNiTFpmNTNDZGJDemJiRFlSdkltQWFSUmRQM0VML0w4MnJlSDY2?=
 =?utf-8?B?d1JKbDRGYzh4T2gvYlRGY3ZSMFErWXphU2lQcUxnTjBaVUdkeVBuTnVQVkdv?=
 =?utf-8?B?QUU2bHlCRFgxcElTOXc4TXNHd1JrWUtQWWFrRnNaWEtWM2RSWFBmZDRUMTls?=
 =?utf-8?B?Zjc1VHUxNGlHUVJTekV2WnBHRHphNmlNc2hYVzhQOG56SlhSd1Q1NW4wU2pz?=
 =?utf-8?B?Q1VJbW1FUlZ2RmgzZm1tNmZONzd5SGtnUE84ejlac3I0WU56empVejRBNDZk?=
 =?utf-8?B?elpuZWZYbUh0eWJydXoyTGdLaDZZeXRhU3JyNHgvYmNVNFlHdHJNZlorVy9o?=
 =?utf-8?B?aDZHOGNJWHkrTlNBOWkwRlVLUW1rYVVrTzU4a1pWOEpXV3k5cU9HQWNlZnhM?=
 =?utf-8?B?QVpZSzc4SXhaRXRtMGg5dDM1UVJEUzhOclBLbDA4SGhqUE95YnJHNGdROXA3?=
 =?utf-8?B?NzhzRHEvWWlXVXBxQmI1ZnVSdWZDc1JKb1lPQytKZnE3Y2M2V0F5OGpsdHEw?=
 =?utf-8?B?SmZhaFFROWVvN1Z1N1FiNDJsTG1hR3Z4andURy93MVg4WDF1ejlTankycjdn?=
 =?utf-8?B?TXJScjVPZS85UFp6bER2MElxdTNkR28xZlg0ZHVRUklzQjBZYUtDMGpsOWxI?=
 =?utf-8?B?TnIxQXBTOXRXZXhwcDlJcVlpM01VVHZVQ28wMng5bjkyTXRVZnppeFBZelR2?=
 =?utf-8?B?UnJFVEVBQSs4aEFwZ3BDOFFST3hHR0tuQXZsYmtUTS91Vm9rMGNwaXNiSFlR?=
 =?utf-8?B?M0FDaXdIZzlWblBlVjgwblArUXEyWlgreTdDbnRmRERVMjZMRVlxZ0hHSzE0?=
 =?utf-8?B?ZExmL3VQRHVnSTVtOWxZMWJkK3pCR0dpak1WVWpJeHhWdGorR1lIY2tua24r?=
 =?utf-8?B?eFB2SjJzTFhnYzYrYVJIY1BqWEJvcUFaS3hKS01OOHMxcTJUbEFMblBVT29k?=
 =?utf-8?B?NjlhRXVRelRYRXFCMG5HZ0YyUms3Sks4dXQvenBUU0Y3enV6WkJoL2h0REJm?=
 =?utf-8?Q?hlHHnIo3iakFIyohW5ZBoZoyc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09435664-b5c9-49fb-b2cd-08ddf53b7aac
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:09:56.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUYaLjBdqQC/PeN0/RQL082zexsIpK2bfG1a9nLbi3kluJSWEH0E8RcG2c0y99EBy38eESChnaehUhzKlnVqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188



On 9/15/2025 12:04, Yazen Ghannam wrote:
> On Wed, Sep 10, 2025 at 12:38:44PM -0500, Naik, Avadhut wrote:
> 
> [...]
>>> And maybe the warning can go in an short inline function? Sorry, I
>>> forgot if this came up already.
>>>
>>> Also, "two future releases" is vague. And it may be confusing if this is
>>> backported.
>>>
>>> Does anyone have a better suggestion, or is this good as-is?
>>>
>>
>> How about explicitly stating a release?
>> 6.20, for example.
>>  
> 
> I think that may be okay, but I'm not sure.
> 
> Boris, what do you think?
> 
> Thanks,
> Yazen

Another alternative could be doing something like this:

[ 1340.644001] NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030

Mention the year instead of release!

-- 
Thanks,
Avadhut Naik


