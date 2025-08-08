Return-Path: <linux-edac+bounces-4541-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4BB1ED1B
	for <lists+linux-edac@lfdr.de>; Fri,  8 Aug 2025 18:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848FC7AE9F1
	for <lists+linux-edac@lfdr.de>; Fri,  8 Aug 2025 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC162874FB;
	Fri,  8 Aug 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="D5vyp/EK"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023093.outbound.protection.outlook.com [40.93.201.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B12820A3;
	Fri,  8 Aug 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671178; cv=fail; b=MddNuQWgb173KZKpCsf6eiKCu0QPGJY3Dp1nYUAmvZUFOTNtCckrP9SSQrWSa8+rSVaMBCnf9kQXjmwJl5BWi4l2zzA3+FUXqRvsj1rDlqWNHczEmWnrgaUpuvZOe/krTfOHBo9OAFRR57AREaZElPw1FjnXVpYslhGUhvm7BR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671178; c=relaxed/simple;
	bh=q7ooM5mDSR+uG+3xSaweZpugMztVDwrxkcg9KD6uROE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eMrSb9cMJLJuD1aW6mRYI/h4OTwWi/FMYo3zMtObLb7urrGqKOm+SEwSPiyBn0gCgGRK7GJ6Ik0uhCygWFTO3VtvIW/e89LcwcbtEzuFoWNyhgCWKP5NKwdWJ0cxSn07qNzlvJZNMBpQKAFKAfFbNMvMPPPI72r9eDphOrYg4+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=D5vyp/EK; arc=fail smtp.client-ip=40.93.201.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcJhCVjW6DW9qob8XdxU0EziyhZqsJggZ0SGuFOCiUrLa73JU5csfxfbc7c0fSmurAhYYlkvEf/ahhuAIMpW39donb0FYd6YgGytQ1X9BMl7Br5LMZmxMvQUsx9Mll9RyTECYoe4/vYrkXKmvUxUGa+qt0l8c5PUbEC9PwlbmMTQP/GWwHue5RkfnHE6N/gMxFRZnCZPLBtYpZV2rXFUE/LvKuU4P8N/NyCVtpmN90wQ+QbY2Ql8PSUg25OCB5VFiyIGKyoER3WqbZbStkmlVG/MWfZEg00dDdg6FJ2mxTpKpOrOv+dB8PUPT2rMtfk+G+febO01v2lucqSaj1OGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d279khdE/zWZahOMhe44zD4NA2hyGTCnYw8wAHjLDdk=;
 b=pTPKjKoDl4gKWqzCC8L3A8DGZ1Ql04MtZUmdZLhKNJmURh0NYtqDfKIOTyS1fYIT/SgQEz6MiqZQkYYrVGCdAOQiShDUuqtDSx6fzFj3g0LvAhThBwg9/nzj1gb11TIjpuQC+6Ftxz/n8aEXLsUGm21JzHlWOQUBcyvrF4cbb97/fBcPvtqtjYUopCcKdqGkqLRQebiOyl1PFdeRS09AZWI3yTfpRaBL3SZyqu4Pb0B7H/cOf69fHZ6IeIOxP97V84VZMRdCvBLztjlZcI8N+3Q0eRmEEZd3+HU8CwMpUqxiBGgOR51UzzezPc4Hkg2u0LZAQZvAWSjpf6jWiDXU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d279khdE/zWZahOMhe44zD4NA2hyGTCnYw8wAHjLDdk=;
 b=D5vyp/EKEq3srrJc40Y/RvHrlgHeil49QbNg29t87vpTaVy3WjZR3AOqChclMoxsk1bFCiU4TyVImC4xRCx21j0V7f8Vdo4r6ajHnBUDLuB4+Vx/iQ2L1A3z3pxv8mkjwLETSlULdf3HNjmAolSDYOq92SDwvEOp1DF9UICH5+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 CH5PR01MB8837.prod.exchangelabs.com (2603:10b6:610:20f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.17; Fri, 8 Aug 2025 16:39:33 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 16:39:32 +0000
Message-ID: <f5b28977-0b80-4c39-929b-cf02ab1efb97@os.amperecomputing.com>
Date: Fri, 8 Aug 2025 09:39:28 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v10 0/3] ACPI: Add support for ACPI RAS2 feature table
To: shiju.jose@huawei.com, rafael@kernel.org, bp@alien8.de,
 akpm@linux-foundation.org, rppt@kernel.org, dferguson@amperecomputing.com,
 linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org
Cc: jonathan.cameron@huawei.com, linuxarm@huawei.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250801172040.2175-1-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250801172040.2175-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|CH5PR01MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fef074a-3f1d-4df7-782e-08ddd69a26fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|52116014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjVFbU9nVUE0T3g5ZmhrdS9tUlN1UDFuSWZqckx2SWJsQ284ODR4aXRXWHFN?=
 =?utf-8?B?M2lZdC9zcG82bDRlaEVYLytWSU1FUkpXMDdCSUxiSlZGd1dRWVVkUmhydTNj?=
 =?utf-8?B?Ump0UzYwWWF1bC9GS2laL0NKczRHVTdCcWFnMG9zczh3YlZZekFDYm9DNE9n?=
 =?utf-8?B?Nm84VEpHRXNIWXNxaGU4KzJEQnQ3SGREOWJ5UXg2SXVPSUFodkljcVFyaW1U?=
 =?utf-8?B?anMvRnpqY25qcGlFWnpZUXgyNlFML1hIUEdrb2N5RGNjUkdmeGFoUnNxRnRy?=
 =?utf-8?B?ck1MZk1qSVRSZCtjcGZxbGpla25nQmZBV3lIMmdmLzltSmo2Tlo5a3c3WXFv?=
 =?utf-8?B?NnVsN3BaRHU5bmlScmhYUUxwcWl5WEY1ZVRnWExrOU45eHYzOVI4cHJqWlpq?=
 =?utf-8?B?aFVXZnFzQ3o3QmZzckpoK3dZaEJkYVF2bDZ2ZDFFUjVHV3VaaGNaNHd5MEhl?=
 =?utf-8?B?QjVzbUdEaWtQN041TG8yKzBUWUZBQmlHeE03bWlPU3drL0JQMmhCVGVCZnNt?=
 =?utf-8?B?S0lmOHkzZ3pISUN3a2pkL2NSaDBqcVRSc2NwazkrR0NUTjBwZkxyQW5RdXVQ?=
 =?utf-8?B?MHVrTXB2Zzk5ZE9teUhNY003eTFnMGMvSCtneG9oTVVzaEFjNkxqRG5Cdm1I?=
 =?utf-8?B?aU83NGpLbEpoMGh2aTRUVmM0aC8vL3FROGZ5TndOVnZUS0JRZ3J5eGtyZG1B?=
 =?utf-8?B?eE1TWG1DRUg2QUE4SjRjOUtiMmd5RHIvUnJ2WlZqOUl0R3pYTlJoek9HOURM?=
 =?utf-8?B?ZHBjd3Q3Yjhqa3VWTWQ2UFNEdnFtMjRGUnFKWno2OUFDY2hRallabnJVVUd6?=
 =?utf-8?B?MzBOaEQ5RlBwaW9ackRKVThTMjBNSFUzS2NOY1ZNSVpKUW5GMnZnNTMvMTZ1?=
 =?utf-8?B?TGZWNHZRRUVEd1J1M3RUVitHcHlZclZiZzlyQWZyZTE4M1VmWTFEc2tSY2RF?=
 =?utf-8?B?cFdEUW10a00rTG9uV2dScWs0TkZqNEJIZ09vQTdrYldIcXpvMXZLQ1doSnlX?=
 =?utf-8?B?RGxINXhCMWFRWEFNY3BQUlI5c1BVVE5XWFQ5L0JnNnh4S0htNjFoaExLMkdP?=
 =?utf-8?B?VEZKczZlYkNRMnlqVkFNUnkxcm9rNVVLblZlUXFvdDNlMEJDUmV4RCsyQkZx?=
 =?utf-8?B?TEVBQ3FjR2hHQ0tsV0ZFd05YZ2JiK3IvYzRDUTBFUGRjWkVTNlk1Zm9Ib3hV?=
 =?utf-8?B?SytqNHFtM2cvWTVhNEhrdXQ0WVJFK1JoZEtDdEdqS0JKVTczOHprOVdIZ3Mw?=
 =?utf-8?B?WmNrOHF4K3RIdzVLZXpwbUF6b010Q2ZUYm15T1lhOTM4c1V0c3d2QU52a0Rh?=
 =?utf-8?B?TGlRekRBMDZUSHk4VU9IekhiekdhOVFzeFpQTVhjdis0WmFmWHM4aDlwRVQ5?=
 =?utf-8?B?dWFiK1hpam44ZHdobFE1WkQzUEYwWFFOZHZodTRsMUczRkJXSWNVTkdvWll2?=
 =?utf-8?B?L29QNm5WQk5sbUhueWZ0VEpaOXFJSWR6a2lSQlNzWFlibmI0ckExaEdDeXFF?=
 =?utf-8?B?amh4QlMvNVNtUU8zOTViSzczZkRDOStHTlV4MDV4SFJmZkMyMmE3RXJrUnN3?=
 =?utf-8?B?RGVPMWdVWDl1dXdET0tBU29EdEhLVjQ5S050eWZ5KytCU0dyZENUWjFtMFM4?=
 =?utf-8?B?ZWljdjVrZTFBUFBpc1hSWDFzK0pNK2hGM09Pb3NzSEc4M2I3QXpHbXZubC9J?=
 =?utf-8?B?R1lYd0hVclBYMWpUTDA5VEtja1lIYXB3VC9Zd09SR1VMUGxXTFF0ZEt3eGFh?=
 =?utf-8?B?RkpKTGxpMk5VdWdUdExTT3UzcVhDUXMyWDdVTmdVMkFPeGpSK0lCOGhWWW5z?=
 =?utf-8?B?YkJTcTByV1pDR2JidlVPVmRXSm5DVmtUZnJyRmo5VU9mYVgxQ0FTQlgzemlR?=
 =?utf-8?B?c1k1T1RPQXFFOVNQOWthZWNCaGhYS05HdlZkeWlpa2JHcFl5UGxKVjUvUkRR?=
 =?utf-8?B?RzBTMURPQzR3NVBGUnhPYVpIVGt5Z1k3Z1dUZzhRZmd3UEdlUktYajZkWkxr?=
 =?utf-8?B?SS8rSWR2V1dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(52116014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUQ0SXNZTFAyTnV2VnBwN1FBbVNNRUcxeU1DS0NQa3RrZS9Eek4rQXp2aE5X?=
 =?utf-8?B?SjJib2JQT0tCTmU0UW41cXBubHJwcEcyK25Bc2Z0VW16TTVYaVhINkd4ZHN0?=
 =?utf-8?B?VklwK3AwWDdVektVMjZqVm5QZnlpSU50aUE0ODA0VExyNWM3MTM0a0h4L1l3?=
 =?utf-8?B?NlowM2NOVWVmQS9ZajYyQzE5emZKNjVlUWU2UFV6YWNaZDlOcHZDc1hieEV6?=
 =?utf-8?B?OVk1bDVGaEFyUWVyTmJhTmRiV21ZTFZuSjU4dzdMVEFIeDZSQmk4NkZlY2Fk?=
 =?utf-8?B?dUJEOUFkSWhhblMvTURlTE9BT3UvZC80eUlnKzl0N2syNCtsb0xHNzd2VXhX?=
 =?utf-8?B?L0pNSHVVVXpsMkp5VFp5R0hMZGFNRVFLR21CMnA5eEZRMTRQSFEvUnBaU3Rz?=
 =?utf-8?B?Q3Vydk1Mb3BxaTg1eWdOOHRJM2RXSzl4ZmpDOVozTDJHamhUejJablFxcFJo?=
 =?utf-8?B?QjFpRlZHckJLR3hqRnZKZzB0MVl5Um10SWZSWnpXS256RkNnUDlGVDQyTlJk?=
 =?utf-8?B?K3dYY2ZFYUNtbm1ZbHdXRHVnT0prM3MybmQydUFxQ1ZDcjlPMEZ1YWRSYmto?=
 =?utf-8?B?ekt2aEx1b3FUTkpGV3JkSENBTkhsQ2hNRzNaamRKZ2h5WjljdWwwOGkxREQw?=
 =?utf-8?B?dk1BMmFrQm1HY3NiUWc3dkMvWndRVVFTaVlneSswcUVaU25IeHRMa3hIcCtR?=
 =?utf-8?B?WnFjR3Bpalc2UHRFSWt3Ui9aYnNDV3BUdEF2Y0Ixc21PLzRSVXBHRmlDRVd4?=
 =?utf-8?B?ZktIekJlaTJzSlpjWEFLcEVUeDNOUC9vamxpcnRsRW1jTm82Vk1WWmcveGNv?=
 =?utf-8?B?V0d0VVo3eWFPZTFYdUFEM3hrQTFRcmR5Um14RVlOanZ0MlRwYk1yaGlvd3JO?=
 =?utf-8?B?SzlXOU9sNlVYQzBvNWhpa3dQclFNdjlpd2dlMkZSbnZkT1ZOUVQzS2dRVVp5?=
 =?utf-8?B?S1Y5QTlQV09wQlEwcmg4djFRK1NUNW1Gdm5haUdaNzN2aW4xVlhzMnJpQjFm?=
 =?utf-8?B?V3RVUXQ3MWJJeEJhT1VqZFJkTSs5RVM5OGc5K3FvYjhxU1JlRENXczNlUHN1?=
 =?utf-8?B?RzJvVHNidzQrV1BsQWpkYy85UVF1bHJTUEZrd3lNeWhPbytOaXIxeFh2VDV6?=
 =?utf-8?B?RzArS3hLMHNaaytEVURKSHM0SEtDNHNwWGhyblNPQ3ZtbjZ3Q3BDRUhYQkpZ?=
 =?utf-8?B?c2orS2VIYkVuenVZNitpbnlhOU5XcHExTzEwR25rUEQxd3l1bUYvQmd2aWFD?=
 =?utf-8?B?S01Kcm9yZi9UVjNhMVlIZkZteFlFb0hwOGVQb05WdG0xS3lQZm1MQ2pQek1n?=
 =?utf-8?B?K2drREhwbk1DTldlcENrQnRFYkhHanNUcmFoZnRHalp6bEpzNXU1YkZsWWJz?=
 =?utf-8?B?KzFaQXRmbjJUSWl2MVNlUmtmRE1VdXgyWUE2WUVhQW5lajd3TGt2Umx2RWhU?=
 =?utf-8?B?d2paSzdreWhnbEhRcUdIeXhqMkQvZm9xcGgrUk1kZHg4cU8xbDRLRUdjTEdI?=
 =?utf-8?B?UGlkdkpBcG1SNithUzArQWp3a0N6T3RQWk95VXRYQ2tBZytOc2xTM3Vjalpq?=
 =?utf-8?B?Q0JJMnFwYlRZY051QmVNNUw3UkpJcjVJWWpwcUsyTUxsYi9oNFVkUmNCcmtl?=
 =?utf-8?B?ejA3enJEWm9rMnRoTFczaXU4c1ZMcXJRaVZyZ21uU2llNEE4VGxqZ1Y5Z29H?=
 =?utf-8?B?bzI5SkZmd3FzK05JdW41WVZLRlByU2VrMXNBaWExWDZjbW04K0Jtc3R1SU9X?=
 =?utf-8?B?d0RpOWdhMEFaS29qQTc2aEcrNVJ6VmxGbDc5TDdwRGpBMG5UQXpzb0VTZjJY?=
 =?utf-8?B?NHk1b3VRamYyckNKaWkvK2pVVUo2bEdUWE5BeHlLVzlKNmZkcDJ4MzMxSG9G?=
 =?utf-8?B?eWhMUUNVNFFlYU1vR0pRS0RlaW16VFNCL2o1OXVWbktXbnNiSWEwM3JjdW9q?=
 =?utf-8?B?WjIxSlAyNWVJNHFnSGplS1pPajFiZFJQbVhwcGhMbElCOWU0anVrZGJiUHpN?=
 =?utf-8?B?dnA4QVZBWEF1MkpYb2Zrei95MkZiLzJxOFJMbk4ydDd5dDJ6eElNcWwwZTQ1?=
 =?utf-8?B?TjRmd0FEd3BwbnZoOWNhUXFxWDJGV3hMaUZTeWRZbnVTWW1HQWRrbTlGNnFx?=
 =?utf-8?B?YzE0d2dZUUt1RFQySzNEYzBkN2YrbXBOZGlhL2ttZTEwMGtVVWxCemRiZEtU?=
 =?utf-8?B?WXkyZ1hXWjBTMmFOVy9hbThsbDVmLzNZSXJGQkRmUkdDd01sUno5dWZDeFhy?=
 =?utf-8?Q?XL4BerFdbNGjGz1U7urrRIeBkJsBTiTX2ACGDkep1k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fef074a-3f1d-4df7-782e-08ddd69a26fd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 16:39:32.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qb8YNeqHjLHT7/BVn+Hm0WRgldDPl23y6wtdPXhSQqH0NPZsmfH7fz/U0PEtUTT66S/3oyI3tuJvgBdKO3w1aW3pWprj7nSC652GBmdLq/gYzAlyByKlZWgeBdC2N74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8837

> Changes
> =======
> v9 -> v10:
> 1. Use pcc_chan->shmem instead of 
>    acpi_os_ioremap(pcc_chan->shmem_base_addr,...) as it was
>    acpi_os_ioremap internally by the PCC driver to pcc_chan->shmem.
>    
> 2. Changes required for the Ampere Computing system where uses a single
>    PCC channel for RAS2 memory features across all NUMA domains. Based on the
>    requirements from by Daniel on V9
>    https://lore.kernel.org/all/547ed8fb-d6b7-4b6b-a38b-bf13223971b1@os.amperecomputing.com/
>    and discussion with Jonathan.
> 2.1 Add node_to_range lookup facility to numa_memblks. This is to retrieve the lowest
>     physical continuous memory range of the memory associated with a NUMA domain.
> 2.2. Set requested addr range to the memory region's base addr and size
>    while send RAS2 cmd GET_PATROL_PARAMETER 
>    in functions ras2_update_patrol_scrub_params_cache() &
>    ras2_get_patrol_scrub_running().
> 2.3. Split struct ras2_mem_ctx into struct ras2_mem_ctx_hdr and struct ras2_pxm_domain
>    to support cases, uses a single PCC channel for RAS2 scrubbers across all NUMA
>    domains and PCC channel per RAS2 scrub instance. Provided ACPI spec define single
>    memory scrub per NUMA domain.
> 2.4. EDAC feature sysfs folder for RAS2 changed from "acpi_ras_memX" to  "acpi_ras_mem_idX"
>    because memory scrub instances across all NUMA domains would present under
>    "acpi_ras_mem_id0" when a system uses a single PCC channel for RAS2 scrubbers across
>    all NUMA domains etc.
> 2.5. Removed Acked-by: Rafael from patch [2], because of the several above changes from v9.

A) We have tested the changes you have made, and they work. Thank you.

B) In the early days of this patch series, as we began developing our firmware
to keep pace with your development of this driver, we indeed only had one PCC
channel shared across all proximity domains. Since then, we have evolved our
firmware to have a PCC channel per proximity domain. It didn't seem important to
mention this to you since the supporting code was minimal. However, with this
latest update (v10), it has become apparent that you have taken extra efforts to
preserve this accommodation. So, now I'm obliged to say that we no longer need
this accommodation. If it would help make things cleaner, and require less
explanation, we support the removal of this legacy, non-compliant accommodation.

Respectfully,
~Daniel





