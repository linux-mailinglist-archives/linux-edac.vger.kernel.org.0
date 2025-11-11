Return-Path: <linux-edac+bounces-5428-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F1C4C174
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471DC18C106C
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092EE30E0F1;
	Tue, 11 Nov 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jATdLLCL"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEE204F93;
	Tue, 11 Nov 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845205; cv=fail; b=L+l0fTwtb7rPBljW6a+Ih1ljwPjDlmIXP00FSp2QE5gLFvXAZtU0CGD512jTpXA6xGJJ0vbDnGFINT6RpZb3CzxRLIs7KADd1LTMMhq/rY0TF5aeK7SLgwj590YHFCxH4UimayQ2vCo9wXrz46FvB1HtU6lQ8ZW48EP4BvmLpRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845205; c=relaxed/simple;
	bh=inxrKINTIHRgYbdezVgmuwwrW7EU89vkpwt8qO5wU1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DBub1s3+9blBRHjYsveZwls/agB9DiOwC1L/TOG2/IEjI8tfm3JAzGknqSsZUiOrHPQU7B6RpDbWMbNBDh3jHB3i9qBKj3GQ7GFXpSdcixF7Fzc3nQjhO7P1whbP1OVG/L1xHvCoVc0kqua0vUJSePcnNhMXY2bnYugXND9XXO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jATdLLCL; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kk70rwO7+uenupAQ4wA4RBPlRN9y9PJnsfYVQKz3qJA1Oohe6Qv6Wvtv8Lm+GzLTzwYHgIoniLjwlz+n/qhwTTGiH0z4rVa6ckOGjXkwPB6jQ3hJv2qxUAHUwYSQIlJzXRwyGeJWBz0w6haDDSKV0nunK7YPjXkSiOyWdzsUDsdo3Uv7nHpIF93YLB1D5OQkR9B6l9CRItC2+gug9ubfwVFSozHxHEnUrEvmw/r0wdRLBWWc/vRPreygXI+P7TLw+PixP3lAFyTmHn5mj9cCZwudE5/VG2oR6EzUl2i+Xe2sxbBgnJwPoWX1t7R9Db7q8FxzRlbOT86SUaGZWGFcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN4FBr5KqyjjeEqkkYILjEyWdjR8s76ObAGWs8VX/ww=;
 b=nvwkV4c1Y/5kfjWwnxvBCEFkZ47Yzd6FYmQwORxPqaJ4WCo+Z0eTBufuADOB9la4k6cpEaqBJJIdcSJJhjT0Es1ajUTHvAEWnikGRpRmyey5WieOdFN5DoaaWEcHgiT18N7XZv678q65emKRWlm5JcnIDmRUzItyS47AKRQl+0sWFdM4/BQjyJ6VGVb529oH0HnNdoNoiLBVOunKbnDGRLDCBcvv9DFAseS4TiCJLs+ZZT14/DTtHI6+mk7BXy4mNkUECxPNiuFqrynMovuOniYvld1ZMy+NdxUmXF8K7K6ne5pLAbTzMWK5wJINtx7Z4jJLY4SPF/Tz2mKiTSh6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN4FBr5KqyjjeEqkkYILjEyWdjR8s76ObAGWs8VX/ww=;
 b=jATdLLCLIhKa/tinag2FUXvU9eSKZ2Z1aub0KGidwYDD0Xl9zqwLGYN7AweGNoNocdNi4a2YlchEIYo6xv0qE4Z2jB7cMmpeTtGN8VJNQJVIXFC8iK0jqoR2UGVuF+Lj92UauuTZfK6XvvmRJRSVogv+vq+Qc/UO7VcHWjCHqHOog0rM1vhrMd3WJqtg811R8/oDmUScm7Qdhg9fBRPbukZ3svbpfJxdO+9LuFEWR4N0iiNCMrmjKMK0wcYK2NTsyrYaM0t1spF1m5BH8PE6bzF6VY9Kl3GexZd6/mJCW3ijjPqe8oexrXfINFTcylbFIhkJ6yV0yqr5QWbGmkOm1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by DS7PR03MB5623.namprd03.prod.outlook.com (2603:10b6:5:2cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:13:21 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:13:21 +0000
Message-ID: <868dbfce-fae7-4231-bd91-4924989d61bd@altera.com>
Date: Tue, 11 Nov 2025 15:13:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Handle OCRAM ECC enable after warm reset
To: Borislav Petkov <bp@alien8.de>
Cc: dinguyen@kernel.org, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com>
 <20251109185717.GBaRDkDUVYCHa_M7aP@fat_crate.local>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <20251109185717.GBaRDkDUVYCHa_M7aP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|DS7PR03MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e64578-5c9f-444b-07ed-08de20f1cbab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1Vqa3RyRXZzT2xBSFlLbnBpSjhEdmM2NVAxamwxSy8wOWQ0cHJsUWV5K01U?=
 =?utf-8?B?T3oyamhyU3JiZmhHajV4NDdwWlBqd3d1WlFUcDJrMS9Eb2wvV0p0SGoydUNq?=
 =?utf-8?B?RU1WWmVSNStBSWpvc0pyTlVMc3BidGlzbFV2eFYveC9zcVJUZUE1UXdWbmtK?=
 =?utf-8?B?aFd0R2xESTZzT1F3eHdubDVyYmxmRU1UNWFtNjdrRjhHc3hpU0pxQUl2R0tu?=
 =?utf-8?B?M2RIRnNNTjhoeUJpZWYxa3Y4c2ordFdTZFZuTzEzeU9LaEdIR0dtN3BoaFcw?=
 =?utf-8?B?TW1DWHUzQ2RjcVpnVDkvMjFuaU5tbHVHckRrSlZpWEc4ekpUanFxcGFzemNI?=
 =?utf-8?B?WmhFRWcrNStySHFxTlJmSU50OHdseVRieWxJVkV4VS9GMTJFSktjejVJWmlI?=
 =?utf-8?B?Wjd6aUtwMVlqaU5kMGcvYjJlaTErZ0ZaVDRoWlBuN1FRTWxRT3VORks4d09Z?=
 =?utf-8?B?UTF2bFgxVXZaTWdyaXZQRHlwbjY0R0tVUEZkZnFqK1NROWJlZkZocVJsMy9h?=
 =?utf-8?B?SENuTDNtb08vYjZmKzl4N0NnVDhuU29GbzFuQU9vVVhNdklucklqYmkxRlA4?=
 =?utf-8?B?a2kwdmtCWkVpTytNeS8xOTNHaEJoQXpyTCtVTk5LR0JXS0NnQVhlSWRSUHBR?=
 =?utf-8?B?OXVvay9MY3paZDVaME84Smp2ZFpicW1GK05uTW1BdW5vbU5VbUFwLzFFaUpi?=
 =?utf-8?B?RWNoUzF3VHQybnMrV2tzMk45czlBVGxiWmJ2bDBkbVVTRllYbDVLSEVoekRO?=
 =?utf-8?B?Zk8rUElkd0V3VW9kd3FMTkR5cnl3Z1lESUlIdHlWcmdsYk1oa29kREhCTXNK?=
 =?utf-8?B?K0hyNmZudjBjdHdDRlp0aHEyK2pUT01qU1dCR3FZSlBQZ1EvRUJ1WHR5bnc0?=
 =?utf-8?B?d1QvRW04OFdRSExGbnRoNDFrWG1kYTFRY21Nd214eHdjZnJOZVdCbkgzMDM0?=
 =?utf-8?B?UG5Ib3BvMTZEeEFRR2V5cnlnK2xxVFRLbTNWTEtIWkhpbVBHZnNNQ1BwNDBK?=
 =?utf-8?B?bjFoL3BGUExiOUFTSjFNZGxZQXAvMm40aFNTMFgvRHhEZWVha0JSMk5kc2Jw?=
 =?utf-8?B?UmQrYVhiSDQ2dlJEU3YzeFo5bEQwNDNQa2NsdlkwaU5JNHdpWTRVVUlmWnQ5?=
 =?utf-8?B?Y3I1M2lTbkExTldtUzI4KzdoK3U2dUswWXZEdlN5RzdMTHg1OXJmMFZoNEE2?=
 =?utf-8?B?eDBHcFZBUmx4VFNrNjREK3pFZUZnQWlmVzVCemVudVN1VkVkUy84QitpUGVL?=
 =?utf-8?B?OUlQVHhrTHdBb3QyK0tNMi9mOTF1Q0hvbG1IZ1pRUXc1M21wYnlyT1pxeXVx?=
 =?utf-8?B?eWUyRkdJME9VaUZlRlJiSFZzcnZQTFJTL1UxK3A3eGlteitKMjc4cTVvZFFS?=
 =?utf-8?B?RFJqME5MOS9xVzNZMFdOV0g0NVNTbC83MGpUaTIyKzNadVROVG1ZUzZRZERy?=
 =?utf-8?B?NDY4aFExdTcrM1FFYTZEeGh3K0FuclVFQTFxcW8ybnFGbmMvZFNFV0Qrd0d1?=
 =?utf-8?B?YW1DM3c3NGprYmJYV3U5cGxpM1ZhVjNjRG1BMjFLdTBuMFdFK2JCQ3NONG9C?=
 =?utf-8?B?dWV0RXFoMGlZVkhFcGlpdEQ0WkE5RUtKazVHUWJaRkdLeWMwKzRaMGk1UFJl?=
 =?utf-8?B?a0FWWGFyclprcTFPNzc2eVZxdlFyNm1qRnNXRnZCU1NVQ3Bic0QrUG5yRnYv?=
 =?utf-8?B?ajNaT0U0YmJPUTBHSTEyMjMzZE5vTnpxUXcyY2hrd21ZZ2RSWkZYeXBJSVF5?=
 =?utf-8?B?VStqdDNRVUo1V3dnSVEvLzdBbFRjS3l2NnM4V1FsSVVZK1p6S2llN1c5Tkxl?=
 =?utf-8?B?dG9QYjVFbDdITmxZMTAwRVFTbEswRDRjanZHWkVjcVdPR0todklNOWR5OXo3?=
 =?utf-8?B?clZGcmJVQ0NtN3lkNldpYXIvQ3JocXZKTjBlemg3UzE5WXl5QjBpN2F0M01x?=
 =?utf-8?Q?cb4i8BGqDfK79YLY7HkN7WlMOAUr/VmW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNLZ1V0d3labHRBS2prcjVFVjExcmM5akxWTDNNa1ZMaTIxa1pSSGtrVEdy?=
 =?utf-8?B?T3lDNGRNc0ZsQ1VLMndFNzBUOVRBbDFXWWdneTNTbzJZSDZPOFhZNVZ6SGs5?=
 =?utf-8?B?S3o1TnNTWWRnVEJxREwyNExQdHBZakMzczJySG1Tdm1QTHZ4SlQ3T2VEVjFI?=
 =?utf-8?B?OC9ZY0VWWGdWaDM4a1Y2Q0NVaDdmNDFlZE8yTDNITHh6QW5ES0tYRlNJSzkr?=
 =?utf-8?B?Z1FrbitiWEhrbEdkbC9FNCs3VXRycm5hUjNRNHFVNFovN2w4anRpZXdXNzht?=
 =?utf-8?B?VnM5bVpGN0ZiYWQ2UjBtSjNPb2RJLy9LandNMU9oaXh3ZHdoM1ZXTnI3R1F3?=
 =?utf-8?B?Z1FQdzVVTmhBVGd4N1gycEkvTUJLWnJ0MFdQSUxtendhVHg1U1NCUVBCekl3?=
 =?utf-8?B?VDZBUlF1cFRCWXZ0bG9qRmp5QzRzNGthbXNjMW5XM1ZPUzRtanRjUW1zTTZi?=
 =?utf-8?B?WlZaVlgzbFRVOCtYaTk3YytVZGNQZWVTMDBWam5VQWV3amtOL0N1SlRjR1Yx?=
 =?utf-8?B?c1Fna0p5djkvUzhGSmdVUmROUGdUQ29XeU8zOFI3UVlqeTNVNVpaT1paalNT?=
 =?utf-8?B?MjVjS2hFdGJRU1pFYnZJZzAwdjdlVENjRjE5RmpycEpxcEFudDZLRzFjMkJT?=
 =?utf-8?B?UjRJaGJhMXdJRVdISXBUS21EalV1OUVYN2tWd1I4WW1NbHREU2k5N1Y4emdM?=
 =?utf-8?B?U1JWS0d5aVVxM3JqMUNwQVE2eXdjR1lGQ2UxRlNDc1gweVRGZlM5QkdhVzh3?=
 =?utf-8?B?QVd5ZnBnRzVHcm9RSythU1FZSUpCTWdPSVUvUnRvTFI4MWU1NXQ5cjlOamU5?=
 =?utf-8?B?cGUySy9tOE1ocS91RDRIY2k3bGtON0UrT3JFRmsxV0hXb1g3a01LOU4zOFRi?=
 =?utf-8?B?NmYrNHFQUjdhYS9CNjNyL0Z5dTMvZktTdlhvMUN0bERPeFpXRk84VTZKSy9h?=
 =?utf-8?B?OW5yOHRRZjgxakRUc1JIejZSZHFodTEzd3IvWXYxSFRaT2RqWTJrMGp2V2lC?=
 =?utf-8?B?SG5vTnE0NXFJRkVnYUNwdU1nbWVHbVFxaSt3K0JyUTZybkRLQy84by9rM0dp?=
 =?utf-8?B?TUhhNmJpSXdrNGgxY2l6dThvUXZabTE4eFdVU1VuL1ZsNTlXS2dQMmJBendI?=
 =?utf-8?B?QkRxbExMcWJBRFR5dVZzdVlyRkFpbDZ4OGpWOFNiaE9HOUdDc1d0b3A2Undq?=
 =?utf-8?B?UUo3UjcrVjNCQUVlZDNEZitNSURzMEtka3hEMTdVdlpWZ3lPN0ttQm1VOWMz?=
 =?utf-8?B?OEUvYVJlYUhhYzJ1bkxITkFlZUNjdkk4b1F6d2hJSTBNaVNweENMRWNXcVlT?=
 =?utf-8?B?cGFCbVJIckFaWCtTaWJRTXJyMncrT3kydTI3eUJTYlppeEZpS2xnSkp1MTJy?=
 =?utf-8?B?eE9DSGNHNUcvVk12QXRDc2ExeGlTeXhQV3VkZ09OQ1IzNjZXZmFNWTdXSGxy?=
 =?utf-8?B?QkE5NGFJRFN6b2diajdSczhDNXJYMmFtbndYTUdXNGVHQ045Q056dDZjdWtI?=
 =?utf-8?B?aFQ0SkJwNHhGdEEvV3J1Zk5hcEFmWExVQUdMSkQ4b29Ecmlkdnh4YlR4eW4y?=
 =?utf-8?B?eGR3cC9YYTh5NXlpUHYvdnFSSTJMQ3MzMkd3aE5DRmN0MDlpSlRFeXk1bzdi?=
 =?utf-8?B?QmhaYUlvc0xuTzEwd052cERFSC9nSUc0UG9pSWNQVFB6R3ViS3BzVC9OUmI3?=
 =?utf-8?B?WWF3bTlsV3ZPMFZxNERQUmUvdFNmdThQelcxa2dtcnJ4Q3BTUGk4TmxGc2JM?=
 =?utf-8?B?NkpaOUVUcjdvTHlManE3Y2dLRGVmLzdFQy9pYkRjQjh5SWdZdzN6NWVXQjY0?=
 =?utf-8?B?bFh0Q0hmdyt2Z3Z1RjRtZVJWZUZMVFR3dzJwVi9rMnVsVlN4Mm5sTk4xZXZD?=
 =?utf-8?B?cndjRDhMYWJCdGlVVlYwVEhvNG9OWTUwWGtBK3hkLy9aRXdOSlFyWE55dkM3?=
 =?utf-8?B?WUt2M2FIQmptNVF6TjBmY3RlSUhaSmd3MXRrdUJDRk5od09oN0dJc3M1aEVL?=
 =?utf-8?B?bHFYWCswZXBUWnZQWVVIaXJ0SytmSlgvQTRqOVpOYlVhQUkrZzg2U1VxcnRU?=
 =?utf-8?B?NTdkUm1uQzZKTzdtcnFKbXk5UUNhZDhtbkhYYTV5T29BSy9MVytqa1hGK2Zo?=
 =?utf-8?B?QUoxMGROcWNQUWgxTkhiMUJva2JlNUcwUXFUUnc0amhVZDByUlppUDh5cVBv?=
 =?utf-8?Q?CiO3QqqLDcMEj3FgtRAjTi0sgZ+9uYW9nqQzqMqWpPUY?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e64578-5c9f-444b-07ed-08de20f1cbab
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:13:21.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUy16+7087edUHJnXcHlB3qqMde2rHNqqg81V6aVQsKNXTdwQ1WszYKxQnafFa4++qRG9vLDSmjTylchB/Zek+bVDFdnGUeJ9L8GPK8eUYjEpm5503ZfNG/1I1Tv5tND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5623



On 10/11/2025 2:57 am, Borislav Petkov wrote:
> On Mon, Nov 03, 2025 at 10:09:20PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> The OCRAM ECC is always enabled either by the BootROM or by the Secure
>> Device Manager (SDM) during a power-on reset on SoCFPGA.
>>
>> However, during a warm reset, the OCRAM content is retained to preserve
>> data, while the control and status registers are reset to their default
>> values. As a result, ECC must be explicitly re-enabled after a warm reset.
>>
>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>> ---
>>   drivers/edac/altera_edac.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> Does this need to go stable?
> 
> Fixes: tag?
> 

Yes, I missed it.
Will send v2 patch with the Fixes and CC tags.

Thanks,
Nirav

