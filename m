Return-Path: <linux-edac+bounces-3934-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFBABA360
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D59A052C7
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61827FB23;
	Fri, 16 May 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vQDlKxeM"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021130.outbound.protection.outlook.com [52.101.57.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506427A106;
	Fri, 16 May 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422306; cv=fail; b=o/YlOKS/65yctMCa7trNwfsn1D2UEqgW+cM8rrNXgy92NANZCMMIqpjuhepPvPuzuRlMQRLN5sW57t/IZIy/S7WMa4t2QWUCDf0QiJkSfHYXJ1LyhqBP+YxO0o9q6Zap86KPiVh9/tyZZmWEZU1zJlfB0BJxL3k3WNTSlsnBVpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422306; c=relaxed/simple;
	bh=XlRdfTD14o1gI7a4BZW1u/w1rn3GYbP4DuqIb5Vz5w4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gV3QF1dnlwj1sgBCSJxeWboccB3i238epCFhsiyzrnXoI2ONIyRWkgW+HiNY2C39lB/sKAQG/9NBJqzdM/Sz/1met+BxHGHurqhttodzQdFaD9K912kEpmzZ9Yjccqv5Ba5ZDwpmoMIafsJCS5M1+si24TtbSx25fBOQt1R8sLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vQDlKxeM; arc=fail smtp.client-ip=52.101.57.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7KmfWHrpUvBda8DKM/3D00Nu0fVJoSUoERDeRPfbWOP9XOXmpDdEVacCBipQu3zGwoNX+ciLUMoXaOWmeKmcMkfyhAxIS3IoHWHRzABZD7uGbzalykENEvMO1ZSHDeDuDws5aON+FpTaUVbUqLhEQon3xOeLsKQNt8FSOOKdgQ8IMNF6f8U1+h7WTxLmGg4izxWSnzRBmbkF2HXi6e6sLQTrG2uKk9xXa74bXzEPY8Vi06GNB519g7rg1icUXbhUEm68lT3eqmHgmrWhCNbn0JNmQCq2+9RqO9bWn36rEHdDcXQDuM5aIV10qY4kX1FOwXaTX+k9TCCYuMgukkCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqXOhxDUNIPsXuuDtL8UaMKtnNst7PktPYrR6qx25Xo=;
 b=NTOPvKXO5b5uFEvGOz0oqLPSjZCcpowEBVChI4g4H5Z059FtbRBSKAnclYGH0fvWc6kss9LaV7bJuVXYeNSu3RsfOzD6HV+UqUT1zf9ch4E2cPgiZSZlWEIPwlnNOdsdfPCwpZr9QxS//RyJniHWhENmz4jWQn0bM9bg1JucZP9yr1W6PDO+bXphoWr9ng+VHghpZFXTVNOHHvacdHK43anCQa9BgaLACGKCFTW1mKi/EevPVPOVQ0cmuPdEfscNLZ/KKo6Dd12XIPKNcL3zEXSXxQGmmpYudS/8sGn0Itv+xAQ14HQaCFKa4T3f2g6r4toDoFZSJlyYzY3dAduJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqXOhxDUNIPsXuuDtL8UaMKtnNst7PktPYrR6qx25Xo=;
 b=vQDlKxeMMfcePXPr4oQLKe4CxHr7NLEwuCh08qPdsaEUYxivVmMzB70/DftvriPMFCdI1ub8SNcKs/YaKk9FpxpIz+Xd5VhB2OpruSsGP+Sbi6Oz4U4ZLw3AoKYElSRki5qemVaIXqNyH+gne8EmnWeXQP8cPQJQ2OMS4y1u86s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 SJ2PR01MB8619.prod.exchangelabs.com (2603:10b6:a03:53e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Fri, 16 May 2025 19:05:00 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 19:05:00 +0000
Message-ID: <51bcb52c-4132-4daf-8903-29b121c485a1@os.amperecomputing.com>
Date: Fri, 16 May 2025 12:04:55 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v6 1/2] ACPI:RAS2: Add ACPI RAS2 driver
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
Cc: bp@alien8.de, rafael@kernel.org, tony.luck@intel.com, lenb@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
 jonathan.cameron@huawei.com, linux-mm@kvack.org, linuxarm@huawei.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250516132205.789-1-shiju.jose@huawei.com>
 <20250516132205.789-2-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250516132205.789-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|SJ2PR01MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: b6059e28-3a20-47ad-716d-08dd94ac8e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkJqcTMzbFBPaDQ5bE1JWGpvV2lxQkxTeGJFNlNPUHJkb0V4S2dNWWkvcHY2?=
 =?utf-8?B?clZ3MWtSeXpyeWRUS0pBSWJjZjlBQ2QrV0s5UDZDNHJpZ1FacUM4TklEQWhn?=
 =?utf-8?B?OVdTTytIRlMxQ0phTGtQL1dZTXFMa1BCR0RUVFRnek9vZk11ZTNQZ3NwMGRT?=
 =?utf-8?B?QXlJWC9DcERxbkMxQzNXczFOWEtVQTRsYmJGWVlFZ25nNkRSTmNGaWsvdEV2?=
 =?utf-8?B?VUEvQU0rcExyVWp4a0JCMXg2RVMvVlVyWnZ3VWZKU2hMQVlmQi9NNlFwM0NU?=
 =?utf-8?B?OTZaYXg4bDlQY0hiOEluOExsbDJJU21UUGNMSG1XTU1obVZMWkJWclp4YXE3?=
 =?utf-8?B?azBRUjhrY2diT21TQXZ3Mmxhek9abnc3VTB0TmQxQ1BwY2F5Vm4way9aNmF2?=
 =?utf-8?B?bkQ1NkhyQzBqR0ZhSzlTSjZEMzljR0FlN0h3N21tM1htVlEyb0VaNmpGOHBL?=
 =?utf-8?B?c3B1ckNaWG9TLzIxZnd4ZVNCaFBGZ1M4MjZvVlNONmNKc3RHUUFKVWh1N0tI?=
 =?utf-8?B?OVk1eVpiUE1ydG9oODRSN0tXeVRYMkNHQ2NDUDRrN2VWSUFMcWlUSXh5dHk3?=
 =?utf-8?B?dHA0dDNqSXdTSGxLMjVXaUE2SGFIKzIrTFFPcXBDTmM2NWxyeXI4QThoUkta?=
 =?utf-8?B?QzFuWEt1dmNVTkhpRzJBRk4rZFFoTjYzY29mMGpMODhXTnFOUVNORzNiZHF6?=
 =?utf-8?B?TC9pT2dERHNYQlNlSDA1VE9KMHJTMzN0aUgxOFE5L2tOUW1obk1WVGVkL2V0?=
 =?utf-8?B?Nm0wSTZKSnJVZ25KSXZFUU11SmorZjdub3BiZUxPTXovSmFlbGRsd3Q5UHNi?=
 =?utf-8?B?d3RoM2JyUUJoaU1pcS85Sm5IOGoyNTdBRXp3elBZSkIvTlhHdmJGUk9qaFhx?=
 =?utf-8?B?VE9aREtwd1FSZmJxSWs3KzZ6UG5HZmd3aEdBUzZTZ1lYVnQ2THRnbThEMWVj?=
 =?utf-8?B?d2JCSUFJQ1lsaUxqT0FsNTF0QnBlNnRoTEFWU3M5WU1SVUF1SXgvM0RLWk1P?=
 =?utf-8?B?NTJ0V1NMSE5tNFZGK0dQS0gwOFBVVEpOYTRWTlAwZ0VmclpsdFp0THJNR0Ey?=
 =?utf-8?B?Q3JDNUJ0RGlWWWMzMWVnUGg1ZW1MVnVyOWEyV1JCT01ET1BwbzN5cGxlaFV5?=
 =?utf-8?B?NHVCUExNZUJuaTR6NHVRUDB6NXc3VVJnNWdlb0NBMWdWWEtxUHREZHRpY2RO?=
 =?utf-8?B?aFZjbFkrL0V1ckZha1MvYkR2R0pLZWprY3dReDJ4cjF3aVo1Wk93ZmFTcVhH?=
 =?utf-8?B?bzJpcVJ6SEplT1NlaFFqdVVKYm1VaEl1R0RzQ09HTXVxb2t4NkYvL3ZteWVJ?=
 =?utf-8?B?Z0JuUCs0Q3RwMUNJN3BXWElSeWtmN2lOU2RLUzVkSlVwMjZMaUJmNW1zSTVq?=
 =?utf-8?B?aHZQME1tTzFoMERiY1pLT1pYcU1GMU9TKzNwVE81bnRKcXRERHh5V1dMclNv?=
 =?utf-8?B?MEw2ckE2SkFSNUJUcHZURXI5L1pYV1NuQkNuWXpzYlg1S3FCbmRaMjNwZDdG?=
 =?utf-8?B?cUNoeWJjUk5SMTlXN0N1NHBqV2UvaHUwdHVTdEdtcGY5TXdzY1ROUHlreHcr?=
 =?utf-8?B?WHBiVS9oVzc3emRUUEIwcHRBQ25MK01OekErZlRuR1dpWkp4TmpXN3hTRXVp?=
 =?utf-8?B?UU5ialdyVS8rVjZPUzJoSXhrTEhQYVhMUU9mRnBaWUpiNmV1T1F0OGYvbE1W?=
 =?utf-8?B?NzBYNmVaVXhMQnB5WitVU08zU01tb2VUU285cFF4RzJPLzVlckZGdW91QkRK?=
 =?utf-8?B?RHh0dGtMN3VsZHpqMDVVbHJvTk5LWkYxZkJwZlRvMGh2b1FhY2V1QkNtNm1J?=
 =?utf-8?B?Z2loMUZ0T253cFNCWFBWSkNhT25LVkpRbFNLUUQ4eXNpSGN2VjE0bzFZWkxO?=
 =?utf-8?B?Vk5Ic21vTWxzd1NMRko3VUVUbHJDN01iVVArcmozSXRGNEMvYUdITG9JVkxw?=
 =?utf-8?B?dEpOaW9vRWszY2NGcVVjSktWcFh1QTBERWF1dzVFSzVUOXJ6UFhXU0lqMllt?=
 =?utf-8?B?elVvUlBRMWJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czQwN3pjQnB1TUNOanZOTEhLd2FCY25LZDAwMzR0VUM1MDNSckFBTWZwRThL?=
 =?utf-8?B?ZmRpbmRYY214UTZWUTQ3Z0JqS0JnZXhqTkhzWEhPcmc4d3RQT3g3bmdtbW4r?=
 =?utf-8?B?YXU3d1k2alVIUTZQZHRaeUpYWUJhNFBhRit0WlhRWHpqTGthZlorVCtseGd6?=
 =?utf-8?B?YjJlN3NzZU1uVUMyc3VGQVFzci9sM2JtaGE4OXZWaTF0Ry80b01NalFsNlE2?=
 =?utf-8?B?VlNFRUwwQ2JMb3RwMkJmV0I0NitMQWV4VjJpYWxXYkdJUmpFaGpHUTNtM3pa?=
 =?utf-8?B?MXVxZXRVOFFnT3BTYTJ2TXNaWFNoVk1nN25Lc1JQcC9HOVhKU21KWGlzNUY4?=
 =?utf-8?B?R2UzWGJRSUpzSVJjMHJybTd0M2JSK1NNZEY5YW4rNzVDNWlNV1BaTy9pZUpK?=
 =?utf-8?B?ZGRDdDB1UGt5QWdqU2FVTndhQlRkQVZjcTNUNm5ZZGlrYlpCQXcvdFU5aUV4?=
 =?utf-8?B?WHBzL3J6aEpCWGJTWXdwdERKUDRTaklWeEc5YktOQ2V5eUQ0UnFJcWtNOVdp?=
 =?utf-8?B?b1FXL1Q0RjhIVXFwTVBIdmpibldXYnhKbEFWUi82d0pudlU2UWp4M3RmNkNa?=
 =?utf-8?B?bzR0K3FQcWpKN3RNVkdUc1dsZWY1VVhNb0ozem14RlhNaE1QdEJsWURJa29C?=
 =?utf-8?B?ZWxjYmtQU3VYWWxpUGhjb1dJQ0dPSlpvZkUvTkVnSWZRenZHbUkyd21DSTZa?=
 =?utf-8?B?T2J3Yzd3YWYrSlBqdWVzVEgvS3dYV21RaWVvRFRvNzRzVGl1NWNTcGlOSHdp?=
 =?utf-8?B?aFNqbzV3ZkE5UXFFbVU1bDB4dUJnK3ZWYTFqQUZPY3BTaVdXL0Z2d2lkVjBr?=
 =?utf-8?B?dzk3c0xWOXd2WFdzTHhpdkVMVmVENUxQWFc1akVZVTJqNXdmcGxQRkJTY0NB?=
 =?utf-8?B?dE56citSam5UbDRHNVZmTnd4QW9jbHZHaUVGVnAzVWlmUFg0NEU1YWV5WFNw?=
 =?utf-8?B?aUFuMjQ3dTRXMEZaRC8wY0hxQzAvK1BZcENlZlgxVzk5ajNqMUZ0QTNCZmFr?=
 =?utf-8?B?bW5ic0pxenJabmxEUTZPT1JrbWNRT0RvYXVIcjM1enl6aHV1aGFjcUpqM2lX?=
 =?utf-8?B?WE9xbDlGWWRnR3JQWlB0K2pXYXpzRjAybENJS2hjWmFlampWZmVucDExOVdX?=
 =?utf-8?B?YlQ5YVJJV0ZRTVNET3VBamFLSEZVZWMzTXZQc2FxZUZEaFQxaDk4U0l4SWVp?=
 =?utf-8?B?UmRENGxxRmk4QlJWMXcxZnpmelpqN0Vta3JuaUdrUWRBakRjVHdyWTVHNUk0?=
 =?utf-8?B?SDRpbnF4K1F2WE9vTkIzU3doRTJtWDJsTG5PUzdjM0dNcytIZGloZTF3NnhT?=
 =?utf-8?B?WDE1eWlwdEs1OTVibG0zUXBrSnhkN2tLL0lQTndGYWE3VEVwOXV1dWFJOE9P?=
 =?utf-8?B?UG1NVEJyNFc5YXRZa3NVeHNQdWJZV2NJRW0yMHZDWmZnOEFzdkpyWVBQT09F?=
 =?utf-8?B?QVFYcHVjWVc0SzZPMm0rVDZyUGh0VjVIY3F3aXowOUp1RTBTMVlGL2RqeVpE?=
 =?utf-8?B?WWQreVBDMlRKUlBmT0M4OTlVencxNS9WdGxiTDJmaVRQb1IvdjdjRWMvRmUx?=
 =?utf-8?B?NWUyM1FXVTVUb203MHZUN1dVbXJvS1IzdFZnY1ptM1VRYXAybjA1Rkt5aTlo?=
 =?utf-8?B?Y0hSSVFvcFJVVjlwQ2xhTVRQb3ZubkQwd0RpWGpuSDVmUStQRE0vdEZsZ3pi?=
 =?utf-8?B?V1F6eUpZbDNJQzhHaWpidHRPQ2IvZ0R6aFBwdFVXd3lIelNWT0I3b2lwTXVP?=
 =?utf-8?B?TmxpcWQ3RjlJS2tSN3VVZ0lGSzhNZFMrSzJwZnNqYnVaSGh5Wnhib2R5cDJy?=
 =?utf-8?B?aUVjbW5RR3REc2JJY0M2YVIrTHg5NVYyV3hJbTAyT1VZVDJzeFlpT3VEY3JQ?=
 =?utf-8?B?eFlZKzVXeUxxbFMxSEJ2MC9teDdyOFdobjcrL0tDVkQzMDhMdEpCVkxaUjF3?=
 =?utf-8?B?Uno4c2UwVXU1aURHYmRabTlQZkVVeVM1a2NUU1YzTDdvUmI1aEc3UlZiVHU0?=
 =?utf-8?B?M2d4OGc3WWRrcm9PZTJrQmxQQ2NmMEFKbG9yRzRiNWc2OHZJSEJ5Q3l4WDNH?=
 =?utf-8?B?NHJCN0l3VDNkOFFHYjYySzF4aUpvenJDcXN0b25hb001MExvYWJRWkg0RUJG?=
 =?utf-8?B?Z1A3Ti8vOEFFWWwzUXJMem1QdXlhenp0MGFkZFhWRFNZVDRVZHJFamJYcEFy?=
 =?utf-8?Q?WB7VfMK1JG2iiasBzhVc1lg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6059e28-3a20-47ad-716d-08dd94ac8e48
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:05:00.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff18I6i26xGtQxCoV81blGTl6UyekgnbYkcfKn2E8xGS69d5pZvaMfw5h2KfsWh8eoJDb/VJzDZhPZyRwLjgRkpjEpPNijggg2UdB649/PZyz2p5I4bhL9Yn+OnYakW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8619

> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
> +	u32 cap_status;
> +	u16 status;
> +	u32 rc;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM.
> +	 *
> +	 * Poll PCC status register every 3us(delay_us) for maximum of
> +	 * deadline_us(timeout_us) until PCC command complete bit is set(cond).
> +	 */
> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE, 3,
> +					pcc_subspace->deadline_us);
> +	if (rc) {
> +		pr_warn("PCC check channel failed for : %d rc=%d\n",
> +			pcc_subspace->pcc_id, rc);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
> +		rc = ras2_report_cap_error(cap_status);
> +
> +		status &= ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_CMD_COMPLETE)
> +		return 0;
> +
> +	return -EIO;
> +}

Hi, I'm terribly sorry for the late churn

It is our current belief that checking the set_caps_status is not dependent on
if the PCC_STATUS_ERROR bit is set. It seems to us, that the PCC_STATUS_ERROR
bit should only be set if there is a problem with the PCC protocol. We've
interpreted the set_caps_status as a capability specific error reporting
mechanism. We have tested the following amendment to this flow, and urge you to
consider this change, or a functionally equivalent one:

diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
index 6bbb0091b4b3..3f73c9ff33a3 100644
--- a/drivers/acpi/ras2.c
+++ b/drivers/acpi/ras2.c
@@ -116,18 +116,20 @@ static int ras2_check_pcc_chan(struct ras2_pcc_subspace
*pcc_subspace)
        }

        if (status & PCC_STATUS_ERROR) {
-               cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
-               rc = ras2_report_cap_error(cap_status);
-
                status &= ~PCC_STATUS_ERROR;
                writew_relaxed(status, &gen_comm_base->status);
-               return rc;
+               return -EIO;
        }

-       if (status & PCC_STATUS_CMD_COMPLETE)
-               return 0;

-       return -EIO;
+       if (!(status & PCC_STATUS_CMD_COMPLETE))
+               return -EIO;
+
+       // Cache, Clear, and Report feature specific status
+       cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
+       writew_relaxed(0x0, &gen_comm_base->set_caps_status);
+       rc = ras2_report_cap_error(cap_status);
+       return rc;
 }

Thanks again,
~Daniel

