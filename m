Return-Path: <linux-edac+bounces-3397-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF6A6CFF5
	for <lists+linux-edac@lfdr.de>; Sun, 23 Mar 2025 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7223AB9DA
	for <lists+linux-edac@lfdr.de>; Sun, 23 Mar 2025 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4EF13633F;
	Sun, 23 Mar 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TWny8waM"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3C2E338A;
	Sun, 23 Mar 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742746438; cv=fail; b=TxrP3nfA/0jW5LXQgoccWcO04JSahhHHne7KxWYOMwEhvYBt7ie6hq6GRHWfGIVjTzc4kzOC3n4ggSC9FRZW6S377TxukwraOzdgds4GCAW3QRooiTnmnAL6OmRYSjc9znQQqVpkg2oR68UboJ7pVZ7mTG//TI/KadyntVfPHWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742746438; c=relaxed/simple;
	bh=hzTuxvZu1XXIDg7und5+fVqHDGZLvfs2S8eLNJ1sgVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrualQV3ImXXIf+uR98AcoYsOvgc9WjzC7E+yLL/Dt7H/Xwx22ZNSlYFoYIqKdLbAvqfvOISS1YUJ9dcdIJrpp4Dnn+K94lqBuHqNNp1NcCpZUE/HzFxL63Cfke2Qhwn8Y7DS1mXk86b0qs5r7y91oytbMSMBy6kSOyb33paRCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TWny8waM; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqGVqPOlvK4cpUyO5ilMbeTEB8VHdAgwWsC000ZoblSChXRR0nGin01LBdO+mxlk6Cz1zbTB7NTSvCDRUAdK/b/B8k1szHLpQfDHYfwn0n6sfpiEmHHrYVROb2ytHg6y7+FxAWpTeRQH4TTutD15zmJwiy1RgezwIavjvPJ0P5i9Zlln64C0BpYfacLodeDH3uEvDmtw4hjgDTV9UqxUnlsO6o706x3AhPwRmRAv3acoXZxSaquVAfpWpVTRhBblk9kJOnTgaRn95Y/DPTdC8DQXzxrp2RaRguulG0jAwWZG5uU0NOCiR53U00/kN5OCoctEoXZy6NAiNgDmkHWqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwgBY7yCi3DJPmkd0oUGlfDh5Zumee7Kbyn0V+QQjlA=;
 b=HNQDuNeBx/XjMyczLTwfrthEuJzdZ4dnPFb0/SOa31IOnsQfDD9ySFT9vi3SdF6WRT7XXnKqjG+a8zIcJ4w0HYR9/2f0sB+GwNpVce3mkx50RpB0iSuqFU9T+IHrFrnP2wgKidSH6tNLy3ix0OA2U5aeMnuBa5nlMCvLrmoBDgpy0y0Gpg9NEkKz5K13mzJL7SpZQx1SUwg2dzQKkEK6l5wfReUTXYIQdDGt5FlRQ/pf9d/d718GeTiSKoekExHkPS70zkn+iCoaO2GYhqwX40rnv22lbRO6tr8WzB+CI3PrM0nHejZmmfpUM2BVi0JVXCzsVpdCGYBsI+nNFb/Gtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwgBY7yCi3DJPmkd0oUGlfDh5Zumee7Kbyn0V+QQjlA=;
 b=TWny8waM8OXDt4fC6F9TuBnKdNR15v9xiMxEwCJQGBHEy9+dwOVjf9yIVQxgsMACyASFOcePSnjLZy/y0/2bbyKazYmzbjcywMRRnmm71RaKOCK03B8Umns0DyA1JcfaLZuYFH5XuOkQ/yDCHjPAknGFvQD9q1jOLGeY9+aBnh7p4pfEhullTs675fkTlNsehx9JGyadjTcoOt6x7n1Ea+GeOOpAacQsUNjOQ1tEPKrDD9tABKbwvQc7g43qkLYaKtYINAOVbMPCpoeTNAQ59rAorjHb6xo4eDmNsXv8w1OdSIZXoJqRXQOWNrr00qGLrk3x06CYOJhLFtWnucWVZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ2PR03MB7449.namprd03.prod.outlook.com (2603:10b6:a03:558::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 16:13:53 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 16:13:53 +0000
Message-ID: <32304141-5025-4955-97d3-392b5035c4dc@altera.com>
Date: Sun, 23 Mar 2025 09:13:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] EDAC, altera: update driver to reflect hw/yaml
To: Borislav Petkov <bp@alien8.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-3-matthew.gerlach@altera.com>
 <20250321211203.GEZ93WI8tLaTJTxHmF@fat_crate.local>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20250321211203.GEZ93WI8tLaTJTxHmF@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ2PR03MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc78b37-8466-46ca-a544-08dd6a25b4a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3ZsU0Q1aHhXd3RSWEI1K3VvWURMU2MrV1d6K09BV0ozbjhyc1lSMUFKeFA2?=
 =?utf-8?B?SXpyci9PZ0RwUEk1OFFvSFpUanhVTEx6alJuY2RjYmRYZnVJL1NaUDlFYUZS?=
 =?utf-8?B?M3doVURNWTkzWGFOZFJlLzFtRDZ2eFdvUW1hU3VXeHFGcVQ4M1owSE56U3lZ?=
 =?utf-8?B?Qk1VcHZ6Mk1VM0RFQW5vVDJiSS9BRFhlWFhQWnNMY2ZkNmNiYnZZVXJvbUhY?=
 =?utf-8?B?d0lpWVdvR1hOcFBmODkwcXAwdmZEV1pYQU5mdWlIalZyTjJLT2dPRTFjOHM4?=
 =?utf-8?B?MDZrVG9NS2MyOWxoZ0JHYnREaFdnK1IyUHpPNnVUWmlITC81TTlCQ3IwYVdH?=
 =?utf-8?B?ZkRBc01kMUFTbXRjSjNJcFdJbGdzU29oZFZzemtCREwrNk4xdVBnQzh5M0J0?=
 =?utf-8?B?dVVONWd3S0RhbDV3L3V5UGh4Y25EVmJuK21lUEJBK002eHBCb2pROWd1eEoz?=
 =?utf-8?B?LzdpVnhITFVocmFMTVVIb3RUbkJEeDRFYnYrdzdjZTFIWTRoL1dadXJkMmE3?=
 =?utf-8?B?b0VMZ2RRRWFBU2YzL3BvMlBTZ3N2UDY2TFQ3Um13TzQ4RWdic2VnakZIcTdJ?=
 =?utf-8?B?VFdGME5kK1BsbjVWM3RzUC9ENjY2ZitpODcvYkNnajJDcDQ2WFhEY1JGYTRz?=
 =?utf-8?B?dlhqcHRlSTFLazZ5WEkxY1NMWTBhazlvbFZKWHJtUEVySW13c3M5NGZDVlMw?=
 =?utf-8?B?QjI0SWZQYk9HUnF6bGtnSXVYb0NvMVRuU2FxQ2JKUVd4QWN5dHlmNXNJSWkx?=
 =?utf-8?B?YkRWNTlROWNTVmVaaDRzWHhXVThXNjhTbW9MbnBkVjB0bVdwL3dmOTBFUmRt?=
 =?utf-8?B?anJFTXlTMFR2UHNQQTNuRzZ2dzlQSUJYTUYxN1gwN0FHSm1XTE1kUnFEbTFX?=
 =?utf-8?B?eVU3Si9JZ3NIbzlTa2xiWnFCOGpvUjJ6M1dFTDgvNVpxQk5uTVNZeHNENFVK?=
 =?utf-8?B?Y2NCOWFDZzJIUFdUK3BiYUNhTVcwTm9MaUNvR1lUdGhRZk41T3JWL0dFekRL?=
 =?utf-8?B?cTVTQUlzc3ZFY1NtOVdnYTNEdzgvYnFaUU9sM0k4eDY5d0RsaXB2NjRTRHJP?=
 =?utf-8?B?MW9NQnZkRFF5d3NwY3BYZFpNRE9nQmd1dVoxcElYMm5pbFZ5QTgwK29VWW9C?=
 =?utf-8?B?czZhODUzTzMwYnFTN3plcGdZQW5HU3d6WmV2T3doWm9paHRoVnZ1a2RYNkU4?=
 =?utf-8?B?QTFnelM2T1FHOTZqZmEzd1B1QUJNM0d5RkJFTkk2b3phQjJPcURWZzJjUExn?=
 =?utf-8?B?Wno2UmloNGhIbVdSSG91Mjl1RTVDZUE2YmthOU56VGQ1Qm9oeGNNYzI2eWRE?=
 =?utf-8?B?bVNzSWRTaExPQXB0N2t1b1l5Rmd3dzUwbzA4MGJWKytlQU9NUEF4NVIzUTZm?=
 =?utf-8?B?Zld1UlRjMS9ZVVoxTEJRRXVldllCeW5qcm0weEwvNmY1cnNlNEkxNkhnckZa?=
 =?utf-8?B?emJKZVFLUE5IdkxOSEFyZXpzS2ZoNHFibmR4WDFMaEJ0eUI5cXgxYzBzUHVV?=
 =?utf-8?B?bFB3cXo4Mk1kb3FoWE1jd3RjbzJ3VWNNanU5WTZQMjlkRnQ3V3FDRGdvcEE0?=
 =?utf-8?B?REdES2NVZTdXT1hCcEZRcUVIRUJxQmVITm1Hc1IrdlZidW4vMlFyek5ZcitJ?=
 =?utf-8?B?UUdXZ1JYQ252SnpwL0Fnd1RlMVV0ZmhXSXduRXRNQWdYVEZzeFZ6elFQK2E1?=
 =?utf-8?B?ZlJwTEYwYWhJT0xRcVRsTVBrUWMyaWFFMGR6SzlWa2s5Vkt5dW54cER4VlhN?=
 =?utf-8?B?NndKZG9lVUI2TWUyWU9BMGRwMUJzaWNYK280K0l2WmNCeU5rZ3FDbm50UVlW?=
 =?utf-8?B?d3VCOUpyUVVYMkZ2TXdKazV1M01mZDVMTHdmUDNqOWhrYytndHRHR3pkSDJu?=
 =?utf-8?Q?s8aZrbklbKWXA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWkzSy9DVTBhdzNwK1JkcnVsRmZzdE5NRXcxREdwRE4vN1M1TFUxYVNUZkF2?=
 =?utf-8?B?eXJiZ0xkQmpZS2I4Nk9NaFZrbmhDeVg3elZwY015eVg2dHZFUms2cXNPWk8w?=
 =?utf-8?B?T3BXV3VCMVdnRlM3MmR3cnM2TkRKOG9LS1VydGg5b2swVjB0R3phdHhLQnFJ?=
 =?utf-8?B?ZytvakhOdVRhWDc1SEpOZWFKUkJoR3RrZzY3amxVNjd0c3RkWnZac2JlaHpk?=
 =?utf-8?B?eWFCMWdsRUUrME84MEFOQkJzTnpUZVR6TzU1OHVZVDhIUWNoQ3FPbC9RNTFo?=
 =?utf-8?B?SjN6VUZqZnlPRTEySVNoMDAyRHFGY080UjF2Ry81RWZrdmdMVGFUYysrOE41?=
 =?utf-8?B?RVN4MmVYTGRpUDdUcDQyaVJnaGFRaWtraEtRaFZxTUxVUlp6U3pvRjE2SktL?=
 =?utf-8?B?ZTJFQ2hwRWpHV0k4MFN4S096citUQjhIWm9FWkI3dFI1WFhhT0w0TEVhSkxt?=
 =?utf-8?B?TUVPbCs2b0dBY2Jyc04wQWwrRkdzTndabndOYUh5NExvN2xiVlpUSUV4WUtm?=
 =?utf-8?B?M3FIWnY5TzNJWk8zdTZFcXlJQWt5Zk00K0UzK0hST1NoUTJzSlBxMnF2cWVv?=
 =?utf-8?B?V0FWTWd6Yi85dy9RSGRvOFJiMXRpVWY3OE5KK0NPLzBGSTdydEx4UC9PMC93?=
 =?utf-8?B?OWlpNHdNMVZQM00xVDl5emFqeFRoMUlKdTVmbzgrblpiU2wxYjJtdTJKWUc5?=
 =?utf-8?B?QWxzaHp2amdHUWJDMGtBWUIzcVF1SzZtRnBML3RmZ0JTaWhOMXlua0tmMEVG?=
 =?utf-8?B?UmUxV0s4V3JkNzE1ZVVoMDhlMXIxaXRlTjZoYXVOYVlRbUdrWTZmZldMMmJY?=
 =?utf-8?B?aVkwajNQSmRxNnlGSFZONXRxcUVpckJJUkUyUmFzMTJGSmlCcXQ4d3NMbWp1?=
 =?utf-8?B?SUkza1BrY09Mc21ES1ZGT3ZkY1h6c0VNUE9BYnFiN21wSks0YnhtQzFJbGFs?=
 =?utf-8?B?YmVjWElZYjdMN2xiNUl1UzBiTjgwa2xGNlNPaU5sV3pnMFRNTmtOd2I5U1h6?=
 =?utf-8?B?Y1IxcHlrWXQvNTBrOTJ3VHhybU40TTBQUng1WG5YZ21jaHFVQnNrZHhOSHZ1?=
 =?utf-8?B?Rkk1VlpKcDk2UUFJQVVQT0VrL1B2aUhVVGVnOGJSSDBMZk1SdHJTMFhzUG1u?=
 =?utf-8?B?SFpFbU45UXlhbk9MUTdsWVU5aDV6bW1wd0VlM1UwWEZKNFRYajZWVXExa0dP?=
 =?utf-8?B?bUw4YzZ1R3BDdGxBZS83bGRVcHg1L1VWUzB3V0ZTMVJscXhCV0FlVWxNcVFv?=
 =?utf-8?B?d0FlZVRQU3hGQ0RUQW9SQkl1RG5DU3FyTkVLTnBDZ094bGJTOWEzejN4SVBp?=
 =?utf-8?B?c2F1TFNJVmtqNnlFclNLZUVJaVBWMGJ5VG9hWUJmZmFlVFVOSTBRRFpMSlJw?=
 =?utf-8?B?T0l6dC8rcEs2Nm1EOXV2RXl4cmwybGN2Mmh3UlhXdm5JVlZMSWNqNWRBWW1I?=
 =?utf-8?B?V25XVjZJbExqSGlxMVpBV1pWME9mNFZPaUR5bytXVjUrZi9NLzFzc1d5aTMw?=
 =?utf-8?B?aU1KclVnN2lNbVlndW8xSDMvSFR0ckg4VVJsZHVlSWxhRTZJOFVIczN0aVhl?=
 =?utf-8?B?akRrTHNsbEhDcFlHY1VndTJxYjFFYjRwcnlldThIbU5IMTBCQzFpV0lSNk5O?=
 =?utf-8?B?WnA3SkhMTGhIRVZwS01jN0ZjUklRNVkxTmVvejZIUDZIWUV3SXNSb3pNSU9D?=
 =?utf-8?B?YTRSaHNpbHF0VkdHWG5Db2RCVW9VdnYwZjdjVkI2dEQ3WGs3UmtIOHZmR1ZQ?=
 =?utf-8?B?WklvREs0UCt1RCtyQlp6QzBLRVUzTWQ2RkZUcnc3dzV3RGkzalRPZkNjUGZJ?=
 =?utf-8?B?eTdwN2Z2blJnUWNDaE5jMTJTd1FBbHJUZ1Y2eGhHSSsxSmMwTnZrVlN1L1ht?=
 =?utf-8?B?VTlCU0tqM2lPMVU0WnBJMEltZUdVdWlUU293WHdRdDNGc3hBeUlDdGNoTnY1?=
 =?utf-8?B?K1AwMlJ3UVVKSUZMR1Q3cjJ1SE1oOGVwRWsxeG9jdSs5cENXeGJWMWZkTkxm?=
 =?utf-8?B?dklWSmIrdDFQTlBmMUt3RnZVWUdCNnlpc1lVVG5NQ1BBWnpQcFlwSHhMd1c1?=
 =?utf-8?B?OG9OalpOc2c5K0xmNGpRelZhb3RwbW9DdW5maEhxblFuWlNQc1lHQUVwU25D?=
 =?utf-8?B?WHZxa3VoYTE2MVpEQ2dxUENNVEdUZ0RsY0MyYzRCM2QrVGs4UEVuMXF0VGZ4?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc78b37-8466-46ca-a544-08dd6a25b4a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 16:13:53.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hs3ahK7rUivAyNB15kfwMCQGApYs+Rezb5Sf2zhSIzYI/ZHU9hPffdtYoUJCo5koRuXxvkIQtwuzrkIqF9/0glLNHgu9uGlxX/yb5a8TtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7449


On 3/21/2025 2:12 PM, Borislav Petkov wrote:
> On Thu, Mar 20, 2025 at 09:46:20AM -0700, Matthew Gerlach wrote:
> > The device tree subnodes, and hardware, for the eccmgr are
> > the same for Arria10, Stratix10, and Agilex. Update driver
> > to allow the subnodes to be allowed for "altr,socfpga-s10-ecc-manager".
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  drivers/edac/altera_edac.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> > index 3e971f902363..895a5beb700f 100644
> > --- a/drivers/edac/altera_edac.c
> > +++ b/drivers/edac/altera_edac.c
> > @@ -1030,6 +1030,9 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
> >  
> >  	np = of_find_compatible_node(NULL, NULL,
> >  				     "altr,socfpga-a10-ecc-manager");
> > +	if (!np)
> > +		np = of_find_compatible_node(NULL, NULL,
> > +					     "altr,socfpga-s10-ecc-manager");
>
> Please slap a comment above this here - one can see the difference between the
> two calls only after staring at them for a couple of minutes and wonder
> where's Waldo.

Adding a comment is a very good suggestion. On the other hand, Rob 
Herring and Krzysztof Kozlowski pointed out that this change represents 
a change in the ABI which should be avoided. This change won't be part 
of v2.

>
> :-P
>
> Thx.


Thanks for the feedback,

Matthew Gerlach


