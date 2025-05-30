Return-Path: <linux-edac+bounces-4049-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB89AC9146
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087977B0F83
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE5227E8F;
	Fri, 30 May 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OUuIUTWQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464B219A70;
	Fri, 30 May 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614377; cv=fail; b=LAT5b6uFkLMmm3jnnwPQXPJJG2aFDfEs0TpcajRUS2qICqNp6zQfB6AviYcRdzo6YcPhdkXHQ067jTgkYkLsnf19G+Cr9nRLLLSET42YWdB5RLAUKQ6awaXo+FB7d6eei6tOugvB3no7Eatx+TXCT8vXCSaIP2xWQLuIC8TZTnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614377; c=relaxed/simple;
	bh=RFD2nmAlbNmsuJdlzmDdX1JkJxl9UtVj9JO+L4wa6Uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tu5lvE/X8hVL5Il0yZWMNHnZUkK91+3eVBdQ/E5AUJE7bZuoe8aaPV8wvYjiKRTxk/x1ExDH3AhDUgPcuaUGNZ/5Eh13lRAadmNfByV22Qt8PB+eMgKPccdVJSxcT7qbz2IMLgQNBcqIQ38IcEkaCWyLvBEjkTgA4BtacOxLM3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OUuIUTWQ; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO0vgeXt4HP9E8m2/i+JgUtzzCjPFBTdyyPe3FFzhPETCKRfpAwrBYwoz7rJoRIX8zUAXKDLFNSyaateE4ihg6dQ+IGoMHJO2U8pJ3uUYQfvWz9Uz9PrqdPmuHKYRhY3a84dqrcwQ0K9s5tpgOT5IUJPEnCRryTYtwETYLujYIKLQqBD3BHG3s+Hcu9cqddvB50Serlg7QNm48gS/BFZUql4xo7Jpnhzj8iEYiZnBc3iHxG4U0jJ2S1A3b2/5gFh4feqiYcf7nEe7z4PHYIe7OhE4U5I+hq2RsJZ5zI/CF1PDKKjaF6yXzYg/y1RRI203qi8QTxNAesn0rKKTHQuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIqp/M/O6zFq6trpkIgoEuzAgLqu7pweZfOU04kHigE=;
 b=bUEATfMbFRdksJtmFGBTGSPpY2sgYU99EDRqwY2JjXtjaPoADzfQbgfdnrsHjHVxHupgdAUoszTdBng3ZK2XFKBE03spa0BWM7vh3iTWGe93xeA/3tOTiB5anQIWd2RPrrMTurspn9r8CA9hcdBuW/ppzHN0c1NAmsskClA6OZXaMEWPwCra3FWZpnEMPqWK7/reeh5Mnp4o+KACTwKDgqmCACiznuXJci760k6cWbfTO2FBK6HcLFwGlZ+bcAUhWW35fUf7gs71bHSA03i6Gpwd26Kt8tQCUxAFDryz1y0UHDQPer74BcUQCf53chnun92Sws1x0l4PyVu5JDqyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIqp/M/O6zFq6trpkIgoEuzAgLqu7pweZfOU04kHigE=;
 b=OUuIUTWQcW5o1ZJX9fr2HQqnUF7pezF0tV58RXxzCQpXi4UFxPnRUhwF9RmcwvSQ/1IS/vBs+j8zMPX3yfFYi7qu8ZXRfcXTTfBk6cb7sHZWCudkFNl4etVa3VJCe3M6geU8YOIu+I6PAUXUdxL/C65htfBBvV6dj68n7tPXrrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 14:12:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 14:12:47 +0000
Message-ID: <73aac6dc-6826-4558-a612-c571577a2e1d@amd.com>
Date: Fri, 30 May 2025 16:12:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] EDAC/Versal NET: Add support for error
 notification
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-edac@vger.kernel.org
Cc: git@amd.com, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4d7e1b-bf7a-4955-1d11-08dd9f840d77
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVp2SkNBd1BTZTQyeTVCdUJqaktEdXh1R1NNZVQ4S1Q4YWRPS1JlZzUzek44?=
 =?utf-8?B?ZCttekpPTEFFaFRTcVdPbHAzbmJHZlA0di9ncEl5d3FhRTRHWnEzcnNaM1hP?=
 =?utf-8?B?WGtmdW1UTDF1Z0g2UjVuYTRnSlJoaFluUlZ1ekkwOVdCRitNV0ZLR2dOT2pX?=
 =?utf-8?B?T0lud3hZaTd5MWNBQ3NBRGY1d1p3TGJCY0NxQm1qbFNvOVlTRW1yU1F3S09i?=
 =?utf-8?B?N3F5MEZYeXlmam9ndUpoMm4yTXBpdm9HREVSRC9XbzdkMU1ZWWJ1Wm55RTdx?=
 =?utf-8?B?OWxvc0MyVXRvU3RBR0tSN0pRUWEvWlRRRmxnU0lwMmJ3d1A0UHkwVlptL3or?=
 =?utf-8?B?UUx4SWNONzJKRm9odkF1a1FvM0loR0tOZXRUT1kxaks2RXRGVlluYzN6a2pr?=
 =?utf-8?B?MldhSjk0a1BTRis1c1VkajFnZWNQemlqL0tpSDFwQ1RiMjUxMGZCLzErS05q?=
 =?utf-8?B?emNOSFFzYmhVT3RKUmxmL0xoODFtcTJheDc0WlJIOWdzUnhST2RweGtLUmNL?=
 =?utf-8?B?aE5EZGoyd3JtZVRZbHNpcXpqRlJ2VzBQbWwybWpuQXAxU3BYblFlNlVublBV?=
 =?utf-8?B?eEJjTTV6S09RNTJkeDJ6ZFdwUHIzbFQ4cnRPZG9LVFFQWDZCZExEUlpkYmZ5?=
 =?utf-8?B?YXpBcElIdUlQMlBKK1BsNXpCSTBCVWxocFUrelJJSGRZSDdNMnhEZFJ3a3ps?=
 =?utf-8?B?WmMzMFF1dXRJUU1WSlVrbkJTK1F2TDcxeDUvMzdsaE5JSUU1U2NnSHIrbWx6?=
 =?utf-8?B?VXNuTzllek1NdW9iTE1qYjVwRTRYbjFQcGU3aEgxZmtUME05MlVsYmhDVnR0?=
 =?utf-8?B?bXJXTCs3SnFJNlhpL1VpczlPbmlNLzU3aUhPQjE1SERuN2Zkc0k4N2I4a2oz?=
 =?utf-8?B?amZiSi81ZUxHaVpIWlJVa29BdGt3NUFlaFZIdXhDanZWK2NjdTNiY1NUeWEz?=
 =?utf-8?B?QllraEYvbS9TbnRrS2puQjVQeFdmeDkxUGRvMU1CNjI1eXRsZlV6YXBwaDJH?=
 =?utf-8?B?b0l6VFVvM05vZDlEUlZNVDNMOWYyaDNPVjhCY3ltL2ZSMDNQZ2dsbmFyaktj?=
 =?utf-8?B?TXFVeGpoUTdqQnUxMHlhZHdiSTNIbmZHZW9HcVZTK2I3bGVwTUI3ZlF5c2tp?=
 =?utf-8?B?Qk1iS0VZTHBETHdOTi9MNmFIRlRham80WGRNLytLbjN0NHdYWERRZ1h1cnFn?=
 =?utf-8?B?UzFsU2c4QWRvbnU4K2tiRHlydjQ2Vlp6SVVkTzlTa282emZXeWhCUFVyTnZY?=
 =?utf-8?B?V2I2SW1LTUI2M2dFWVcvTGswdHJ2TDloMzF0azJXdm1sTGNjL1JrR0RNZ3FC?=
 =?utf-8?B?ZU4xelptUTJQdmVTMU1mdHBLY2plb2llRFdRQTVNWU1qL1pjQmxZd0Ixem5n?=
 =?utf-8?B?ZkhoaVlRUVN4WU14WU5ON2lxRlQ0b2JEREZKSWxWYzZCcDdwb2FaeU8wWGlw?=
 =?utf-8?B?TUE5NHp0bGZpSUhFNDFsTlRJQXJBYTJoaHhHNkIreG9pRS9FaDltRkRkZVJj?=
 =?utf-8?B?M0w4Rk1ZVWpBTXphZkFFQ3lxMkNIOGJKWnpZSnl4ZXdNNzdERWtTN3RqcE1F?=
 =?utf-8?B?dW50NWc2RTZNbCtnM0owVW1yQUpPclRpeTMzNitzYkFpbmRMWUY3eWhGRFZ3?=
 =?utf-8?B?dW9CaXFqanJrMUl0UE81d1ZvaDNXREVZdkw3eGVoRjVjY1F2ampvWXBpTnRs?=
 =?utf-8?B?c3did0FISk14dFRZMjJGTlJiUGRybHJlc0c1WHZKNE9SRlcxRzlmQjZLMkZa?=
 =?utf-8?B?Ync3aFE5QzcrZGVta1hsdEMvRmxqdEM5NDR2QjNzSUlKMEVYaDQ3MHFyZkp1?=
 =?utf-8?B?b3Q0ZE54VVh4Sm1XMDZ4ajdrK0gzcVFHcFo2UDA0alF3cmtKOFNneHlpVmd1?=
 =?utf-8?B?ZUVFNG5VbVZDVGxNenlXTVFmUlZnNmszWmdtSjVVZVhGdHJnLzlHQnlENmVW?=
 =?utf-8?Q?7RC+C4l84mk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEpWSzc0TWdpLzVLME5vYnNaMVlaUkR0SzJWQVg3dllHbzZ0UUFsZ00wWWRL?=
 =?utf-8?B?c2U4aHVxdThETHlPY0lTZlRIZDdqUXJpTlFzMmhoMFh1SGZHYy9Pd2FBWTMy?=
 =?utf-8?B?QjZQd1NoeVJmZytsczJjVUhqeERrTTBiRkwyclpxRzNjN041WFNoWTRleVlP?=
 =?utf-8?B?eERrV0JZeVowV21jckNhMGZWbll1WVRUNGVScDFoM1d4UkwrYk1nVHRsSnoz?=
 =?utf-8?B?OU0xTkFBVkZDNUVZOXoxc1hjc2lFVnpZQjhld25ZZW9LcmU1L0FtckRNVUhU?=
 =?utf-8?B?dVBEMDcvTG1YWUJsZG9pcmE4RkVIbmZmTjVoanZGV1NRQW5jNXVZY2IxbkNx?=
 =?utf-8?B?azkxYTlkM2dXemV5RVZvYUZGWXAraEk4OEdmU0YvOXpzTmVIUWJiNDJhM2ww?=
 =?utf-8?B?R0szOGpQS1JIRGdWQmRmdnVEVnBrb2N1cHhSVUdON2h4OTBLbkM4NHphRVJh?=
 =?utf-8?B?ZHBQK1FPUGUxL0x2RlB5ZGZJV2ZvaXowNXhxTVo0UStyRVZmZ0ZhYUorWjV3?=
 =?utf-8?B?QnJHMk9XQWhVSm1iVDl1a3E5ZFZRbzNFTnA3RDhpQmtzeE5zMjllVklJVG9H?=
 =?utf-8?B?VFVFQncxRGxiaHNQTFlWWHBCakVnYVN2QVdBS3lhSWo0Z0JBR1pvSUZjWFNt?=
 =?utf-8?B?alEyeTQwamRpVW9iNTBNN2d1b0YxcThjNlB6Mm5XcGptQnhYU0c1aHgvMjJ0?=
 =?utf-8?B?b1NjV21qYjBoYlErSm44OTgwK0MzdHJ1VnplT01DY0QzcXlVbHoydytsa242?=
 =?utf-8?B?QTkyNHNFR05NRnJMRTR3WlJCdFl0cGlvZE1BcDNUMmIzeDgzblRvSU9JL01D?=
 =?utf-8?B?d3ppeFFHb2VqcllQRVJHdVUyaWFUU1MyTXNkMjZ3amlucW8wbTQzTXRUSUZX?=
 =?utf-8?B?NHY3WUJ0KzJ4d1k5WU51MnlWMU1ZWHoyb0pXaGtBSy9IT202WlEwWmgxNk9t?=
 =?utf-8?B?Wlgyb045bUM5ZzA2bHg5empldUpTS0NBRGVUTHM0S05Qc09wVGRUeUxEZkg0?=
 =?utf-8?B?YnN6K2FSdDZ6VnBueHVrd0tlN29lT042eFVYR2dhZ2ZwVlE3ZmxIYS9lQkxp?=
 =?utf-8?B?MTY1VmI0TlRJei8zU3VOM3RjZG1LSEdkV0owM3RBM2dEeGRLdHF2d2prWUtk?=
 =?utf-8?B?UXZlQ3hYVVdvckU1YWJsbm5iZ2piSWxoUEJmZ05nSWt6ZGQwT2VSMWRhRXVr?=
 =?utf-8?B?dGNqYWpZRWFoMTBrQzMraXlwaGx1MlV3blZsaFU3ZG11L0JYRVFsRDRsazNn?=
 =?utf-8?B?MTlubll5ZWtNem9keDVMcWtUazBpREhrZVlYbis2c0dpUkEzeCtFYlQxU2la?=
 =?utf-8?B?L2hxek5uQnkvcFk0R0VDL0ZQVnpZR1BiVjlQbEFHakdrR01XQ2FSUWorYkIv?=
 =?utf-8?B?cUtub1JMSi9ibnhLWjNPZE5NZWxqcGZBRE1aV2dMWGFmSGJZTnNkT2huQm9j?=
 =?utf-8?B?clVtZlNIcUM2L0RDVDVqdEdPVVJzOWlMWHRLUXQ1UnNqSUkvNzBSdVBpRXJH?=
 =?utf-8?B?blQ4Q05PZXptdFlFN1JZWGhPOGJlT0dUOEY1aEVpSU1UZ0Jrbm5uNERQbkhQ?=
 =?utf-8?B?RzZwc3Z3ZkVIUjd3Wmw2bVFiWlFkMEc1eWZhTUpSSXlVbkE0RVB1UTJ3UFRo?=
 =?utf-8?B?Vm5tZnJqaTFDN2xhU0lQN3g3SUpBaHJkc0Jpb3lLaXAzenJSMHhIYjVoWkI3?=
 =?utf-8?B?R3JQcFp3dUpNODMvcnc3OStiYTFVOW50c0pCMEYrTlpOaFlWeVVUY0svM0Ro?=
 =?utf-8?B?VURFNGhEdkZZeXR4N2NLVm1DSnJTeHZQVTVDV2J5NGl4b2l1WXlQQThXRUR6?=
 =?utf-8?B?azVhb2dTcFBZMDBvMHE0a2wvbVo2Ti9PMmtsSit6M2hwZzhQaXNHNzc0QVZT?=
 =?utf-8?B?MDlrSEI2cUk3VHYxVDR0amNZc1ZEczVadkpoR1NZR1pRNU9lNElXVVByYWNz?=
 =?utf-8?B?T1RFWTdCcEIzL3pxRzAwaWRDRXRrVWw5MEFFdUlSQTduQkR2WFM1dEE3elVH?=
 =?utf-8?B?aWlhWGxqdXNOdXpIMzdIdEVOd2drSXRuNWI1U2owQzNLRDhCbUh2L0U0WW84?=
 =?utf-8?B?WWJ2cUE5MWJ0ZHIvbDRCeWUvMjlqOE9rcWt4eFNLTmMwaVExMGYrMnhqU0NI?=
 =?utf-8?Q?TgB05ldZS//i/QD8CvXmaL//w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4d7e1b-bf7a-4955-1d11-08dd9f840d77
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:12:47.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BG1dG/otb35UrS0+tYRacjUiNt+DNfrNxMtC1coWZrecuBTdKDGP5nUaOrgxv+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247



On 5/29/25 09:00, Shubhrajyoti Datta wrote:
> Adds support for the error notification for the Versal NET EDAC driver.
> The driver receives error events via RPMsg instead of directly accessing
> hardware registers. The NMC((Network management controller), which has
> secure access to DDRMC registers, gathers the necessary information and
> transmits it through RPMsg.
> 
> During probe, the driver registers with RPMsg and retrieves DDR
> configuration by scheduling a work item from the NMC.
> Once this is completed, it registers the EDAC controller.
> When an error occurs, the NMC sends an RPMsg, notifying the driver.
> The EDAC driver handles error reporting for all events.
> Also we register the EDAC once and it reports the errors for all the
> events including the 8 DDRMC controllers. So while registering we give
> the particulars of the 1st controller.
> 
> Currently 20 errors has been tested.
> 
> 
> Changes in v7:
> - add a minimal header instead moving them
> - Add the kernel doc description
> - Add the prototype from first patch to export patch
> - Add the reviewed by tag
> - Update the header paths
> - merge edac_cdx_pcol.h
> 
> Changes in v6:
>   - Patch added
> - Update commit description
> - Update the commit message.
> - update to the chip name as xlnx,versal-net
> - Correct indentation
> - Update to xlnx,versal-net-ddrmc5
> - Update the kconfig message
> - Make the messages uniform
> - Add some more supported events
> - rename regval to reglo
> - combine/ reformat functions
> - remove trailing comments
> - Remove unneeded comments
> - make the amd_mcdi function void
> - rename versalnet_rpmsg_edac to versalnet_edac
> - Remove the column bit and use them directly
> - Update the comments
> - Update the mod_name to versalnet_edac
> - remove the global priv col and rows
> - rename edac_priv to mc_priv
> - Update the comment description for dwidth
> - Remove error_id enum
> - rename the variable par to parity
> - make get_ddr_config void
> - Fix memory leak of the mcdi structure
> - Update the spelling
> - Remove the workqueue
> 
> Changes in v5:
> - Update the binding
> - Update the compatible
> - Update the handle_error documentation
> 
> Changes in v4:
> - Update the compatible
> - align the example
> - Enhance the description for rproc
> - Update the compatible
> 
> Changes in v3:
> - make remove void
> 
> Changes in v2:
> - Export the symbols for module compilation
> - New patch addition
> - rename EDAC to memory controller
> - update the compatible name
> - Add remote proc handle
> - Read the data width from the registers
> - Remove the dwidth, rank and channel number the same is
> read from the RpMsg.
> - remove reset
> - Add the remote proc requests
> - remove probe_once
> - reorder the rpmsg registration
> - the data width , rank and number of channel is read from message.
> 
> Shubhrajyoti Datta (5):
>    cdx: add the headers to include/linux
>    cdx: Export Symbols for MCDI RPC and Initialization
>    ras: Export log_non_standard_event for External Usage
>    dt-bindings: memory-controllers: Add support for Versal NET EDAC
>    EDAC/VersalNET: Add support for error notification
> 
>   .../xlnx,versal-net-ddrmc5.yaml               |   41 +
>   drivers/cdx/controller/mcdi.c                 |   29 +
>   drivers/edac/Kconfig                          |   11 +
>   drivers/edac/Makefile                         |    1 +
>   drivers/edac/versalnet_edac.c                 | 1108 +++++++++++++++++
>   drivers/ras/ras.c                             |    1 +
>   include/linux/cdx/bitfield.h                  |   78 ++
>   include/linux/cdx/edac_cdx_pcol.h             |   28 +
>   include/linux/cdx/mcdi.h                      |  198 +++
>   9 files changed, 1495 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
>   create mode 100644 drivers/edac/versalnet_edac.c
>   create mode 100644 include/linux/cdx/bitfield.h
>   create mode 100644 include/linux/cdx/edac_cdx_pcol.h
>   create mode 100644 include/linux/cdx/mcdi.h
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal



