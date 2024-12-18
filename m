Return-Path: <linux-edac+bounces-2742-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3897E9F6A86
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A497169ACF
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C71C5CA0;
	Wed, 18 Dec 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4WeC++2b"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC601591EA;
	Wed, 18 Dec 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537303; cv=fail; b=QSrqGp3oQwp5iRZscyKjG8/EWEjZbCvl4r1rm54XWzN1g+ak/l91KN8zpLTgiPChLeyiFG1I2IS8uDwAh27iRb+KoPHANDFc3nbdtVwwpAfK+HVsrf2Qcf5QIWPt0ZdrXvkyOQhviBgHuuJX2atQYoPqYxAZToej5GYTzM4wV88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537303; c=relaxed/simple;
	bh=qp5KE+I2Pm8Q3p8UpWOnLz33LRlWJqTJXOYpIGCPhvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLvPKbFF9qQ71zUBC4W/yI1vjoge72vHT4DLNhBF8NQ+eDlDd2QA9HbRJfJHwY8y9ZzpYsnHLPZ8MXA0kWIjW16d31dK2piavSkRdDchmbbIDv3x6jrQ4g5yKQJrAg8qW7Iul/FCFM5TwiJ1QaLVaKmEBRxIXFvZzqThGpknAYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4WeC++2b; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqx5DxMrk5lo6UXPNvFU5e/vs6H3eA6B4bNXhskBC0wrw3nUu9UKrAZKIpZbiDgItzAloqQQygDJhNPh0q3aqifl0BnpE/B9Fb/MW+OtPJRyHgpA1+8XNI3VWuhfQAbN39WVp9gEkWtTpX5Q1D1gBVKd6oexGYZVFP8IYh36wG3zUne+OAvZScjJOZkcPZoqot3VOrx8nMYJr0mKHj1O1f0OGZ+5E26bNdkjSHsYvZK6o0uBVQRhUXTYThZrMBfdrE8ysTZiogszQwAKPfTz98xGWWAe5dT5yIuuKfgk56bmc7ZpN6KSCooFuK6LC8YZPpw+GfA7yPdduXqQ3lbs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pW3X2N0oIvZNIlQ+madCct2+nUYsQAmNYXjtBIQIw4=;
 b=hviOeEhyope7EZPKR6wN5/AjODc3TK53t7riife14sWciR30gzgmSfnDf5ayd0qClG+CrzxN28X20AIYg69YXyns2YoUiOkWfXccssRFURlxGTyLDqKYwgbOFMxKt+M30oHPIE0JbWsekmodwCOv1/Ajjd8CTui7AOPV9TbVp7MRLV2yb8qjA6B6FPTB7Tb4rUIicQOjVBkGdb0PZ+FGM8APBppG9NMFcKXbO8qUT2PI81E4ArxtW/E3gL0RxqmLdTpehQUPrWY0dNi98xTAiDB0ffBX8vpcrkz11HloLnyUq0Gek8bd3/KJiqrN3f3XpVafNVoyywZ0LRPJ4f5jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pW3X2N0oIvZNIlQ+madCct2+nUYsQAmNYXjtBIQIw4=;
 b=4WeC++2bJIgdzrVaHywvinxfFiU+iPMA/EfAid5uzf1eALvqmLLR9+AujyYPo5c2EuIcEycko9koTe26mGO+eVQH4R+pIERCO6ECvWKf+gxLSlE5g0YE4mytgxojHT5llSP8bGxwnw8/AQTcIpyFCpcKGHVqJNGF3kLzy0sd2z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:54:58 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:54:58 +0000
Date: Wed, 18 Dec 2024 10:54:54 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] x86/mce: Break up __mcheck_cpu_apply_quirks()
Message-ID: <20241218155454.GD1155365@yaz-khff2.amd.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-5-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140103.66964-5-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: MN0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:52d::7) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6971954f-d2ae-45cb-9158-08dd1f7c52cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?37SECf34B6cu8W6J2avzasX8A8Z2XGsGKdTQM0xy6H8kSRgkbxlTEJ86tEzz?=
 =?us-ascii?Q?kF6qZCYhoGt06q2fyol/v50B3DBPPBAlDghclAf9rmqMRobz1/gV0Loal4o9?=
 =?us-ascii?Q?JdpzNMfjo4y0Bw+DV+/wrya6VVbrNzSBRAC/POX2vJA7V80Q/K4mlFI9ky3w?=
 =?us-ascii?Q?WrmiHL6evQHu2/pOQToILTD4WlG9W5N8tDgOgoyyroofK8JRzWZ8eHEltYB1?=
 =?us-ascii?Q?TlD0wfyNqxlfsNlkpjpGATSTF/V0XTauI+ZAzKMnIN2O5Y77OMqb3lpKUB2p?=
 =?us-ascii?Q?Ux13mXObBpODoQiNHi69qsPuEyNLIyQyQFdmA4C0aRkzDTwMTqMfIE7Rgt+G?=
 =?us-ascii?Q?MM1pGCwBWPiWtSmRg8GsfPzSjIPKPQe2KDNTW2hZU5OqnFf05/fQ+OpKkElo?=
 =?us-ascii?Q?Ihy0cpR459gT9i03iW+QFpLlFYPmr7YYF9w25EisJKPTKDSHKLLIm8E3Ppfc?=
 =?us-ascii?Q?Lc0QW9IxBqGKLA8ylFcV6KHbxGPw8h+fBWU88F1AUU2Ef0iwY97jvn+6g5Zv?=
 =?us-ascii?Q?tAQgtRir5jp/TaORE8l/43q7/p0JZLLOvassZTTvHSf6UJR0FqcfdZzDRTW3?=
 =?us-ascii?Q?l7bCauE0B54eeSSIZ45Oq85dgi/lw4rD+/vtr0X646zIeSKRF5+QMDn4efEu?=
 =?us-ascii?Q?cubxIeZ/1O1Ziuir4nIEalcN46MY5ajU90H4kw+mUmZNXc9jbxLFonKX6At9?=
 =?us-ascii?Q?iNpceDXw8PlKfA9yZoow5MBEb1LQ3zVrVt8+HfUFZ//PHha/KedJdF+TfCV0?=
 =?us-ascii?Q?ZFk8Ev1hDt/rR6Utk129dM93NpZC/g1g59OENop4jYN+7XRdRLqjziBqgJfY?=
 =?us-ascii?Q?rEvkuyBZ+HTi+puK/6z7IOUTYFeI2XNi0d0WWVsOMgnOMX6wut9QeD1Y1wWc?=
 =?us-ascii?Q?aX65cbYKVEYWQmJqmQ5Zb7QB0bgdW6o+TR1wTkHp3//DyG55CBbmPIJVmebA?=
 =?us-ascii?Q?3qVVIRMYdTWyj31GmoDIPWnHnbGbkV+i/VSxWsv1qDiqzPS0S1xaXAUw13GT?=
 =?us-ascii?Q?1gre0ZYfNEY1iSJqFpWSAZBx9sO5BuYnhbmsLRCcM3kk+l91BKJLupZAGpyl?=
 =?us-ascii?Q?bmDg1ilOepRD+a/gopTUeoVg10zPgyWyAD15qCwdTSkhpspZrPJ9np2BkQOO?=
 =?us-ascii?Q?xRDOrb4UbbJyCSZiC/QGCcwmqmE1WrZtKkZdNdTp2pytSi9GAiLOw0iFP2L7?=
 =?us-ascii?Q?QTzyUXEaBW/sjTxMqsDVXVdhRDHw8pd9Dvy7COmcX54/x//iNu1cgTM0J+da?=
 =?us-ascii?Q?SR5a4uMfig6lbiO+4/Hymcb2FjUW1rhHCT9if18gIegqH00gq0BVVtQxWf+B?=
 =?us-ascii?Q?CnOP4j025SpfpCs/EfLxuxLIzJ5vFyKo5vBNvgObyohqyy8/aFR41s3X3Tl1?=
 =?us-ascii?Q?3M0tsRevVPPN69d1tEHZ1Ova2OuP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fXK1glXCtCfzvSEAP7MBzjDinSpwIz5HKuQKZHFGblEG4Wr4yAnz2VST0gMo?=
 =?us-ascii?Q?nlQNSUwGb/jbrxjkm1ce2UVFIF8bJxdtF2+UA5/PcCrTh2qLpSFl/xYPCI2/?=
 =?us-ascii?Q?stEAfSvmAVs5vnCAiKUjHKqn0d/X+JLfdZ4lQvtfESqbWvlxlDcSGjneOuYh?=
 =?us-ascii?Q?hcfXTB3q5tWzmropKOyVxIRtXPwZ8ilWXCznEFRus8Cvn5zdaaEfhNh3b3ld?=
 =?us-ascii?Q?TxIIKZW5gv3H+TAS+DWBqhPJD/Nc5jlKpLS5tNCbhNlCMpx8K1k6TKSxQ6bX?=
 =?us-ascii?Q?siYFgMfYURrNB7bt9TSEfy3AKo/VE7VH+jsCaDUMTXs2R1HMyB/KiC3DxXoB?=
 =?us-ascii?Q?ISU8YSwVMcXp6b+52qs3U9IncVK0XX27bq3aEIxhBFdzLFCJN3pfIuPsEUrS?=
 =?us-ascii?Q?rqb8ANJRBa+2sa5kl+Dni6+XG5sZmlcMx1PnmWOdn+CrD+br3Y2ZQOvazCkP?=
 =?us-ascii?Q?3b58BUyjQ20TvI0RNofNWRpbWY9sKPze6Sb/uDq9Rv2VZDxUJfD26+h8I5Vs?=
 =?us-ascii?Q?tAz2LsSwJrMYr1/Lbfl2ae0dbqR5rXOsiTV/k6SFSgyXsIw9AkyOdI9LZH6F?=
 =?us-ascii?Q?uC1XMI0Gpg3goRwF7qj0YY6q+Aa9WznKxACFOqB/+/QgC98+wRr85axiLs4/?=
 =?us-ascii?Q?GXXW+Blm2bNlJiZDKTcQRIKN8IZ4SlLLE+n++4pFatQBU9wrM4NsKEpetYbf?=
 =?us-ascii?Q?ly3o5c8LEaqfzg0Gpy+DPO3m6R9bzJN4tM9SfpmRsxyTdBmQBJjB6eMDLBVe?=
 =?us-ascii?Q?Ijhh8ODnE6qsErr3KdeCL1dOpFdmNmV6ovTWKJ4WsLESIgneTmn669z8iW11?=
 =?us-ascii?Q?H6yH89Ur0Fdpt39SDNA5U7zZdTdTWBCIIcnBD7D3TmTlRl0lG93jjZX4VjRK?=
 =?us-ascii?Q?QTashVsqZYHrGNYsBMNFKBlwFJltZzPXOccLq3QAE9g5uVRbBQh9QobMp8zP?=
 =?us-ascii?Q?sg8U2uWJEaTHP7Xc7wx17QBXFbt2QGVU67NXtqDqLT5OrooVHtW8pk2hOiax?=
 =?us-ascii?Q?kNFRRRmC9o6txph4HfqopZga5Tk+vQMY3AIqax6wbXhgSeA5RfIBmiPh/XRV?=
 =?us-ascii?Q?2KSLAcABm8wfEUJ+QxX/a+72dXGb9JisU0HmYvKqcJg0yVADZQoxvpQ2hIhy?=
 =?us-ascii?Q?4BpC8mfWmzqiFWLJzoPAlnFN8yH/koVUKRTDMBuxqsDqBJ0pOaTDIxPNg4bk?=
 =?us-ascii?Q?jxNimm1MkW1D3xI5hXQLTUs2hHhsJITUDtX+7gzHZ7kMHZWwltZyT+HR/4Ww?=
 =?us-ascii?Q?ZXCwu7XfoQFLFXtNhCIxxd7JRlDbbjyOAVOAP9beKBVL49CtohnnBtcutjOk?=
 =?us-ascii?Q?t73li0E8NQc02Spi3w3sfEb/RZD+8mF+/uWP7eoVhUSb63B26Df74LXfxNYj?=
 =?us-ascii?Q?O/dCoFbERMheAD3SS5M53JUPvzAFTnLbvnEfXIIYdR3IappFvLKc/nIzFhco?=
 =?us-ascii?Q?CVeDmflvrWLEyGGy5OHM/x/nSlgYzGYD6Nc2MVtAzgyDAboTMiT4k1rkMlN1?=
 =?us-ascii?Q?LzY1ULVen9OqHSk2/IBqczJAYVBV6TbE9cMpcJ6nGqjrljaQG+oqs2j1M/vN?=
 =?us-ascii?Q?wUwJiainC5vGU8CCZCJhqNOa/290g1OEm35V15x2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6971954f-d2ae-45cb-9158-08dd1f7c52cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:54:58.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UakbNInWscSFWZoyE+jfGccbpDMXr9SNDlQCm1Afer1SU91xF3AAIQpxmzqu/6yiZ0h+lKPq3we2E03IhVPhoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

On Thu, Dec 12, 2024 at 10:01:00PM +0800, Qiuxu Zhuo wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> Split each vendor specific part into its own helper function.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

