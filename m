Return-Path: <linux-edac+bounces-4426-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D83B10B4F
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 15:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C257A7DDD
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD12D663E;
	Thu, 24 Jul 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l51WwWf/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F32D641C;
	Thu, 24 Jul 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363484; cv=fail; b=fFNbQdp19kIh/Xd3DpkIvEDOr1Av+PXcUQ8P8pTh64MABbwMc/Q1+dmtbHi9//3UneUbYTmNNVRwN3rZIH/P8KHx/nU5Pn2pI+G2YRcpufLhtnO+7a2LdbqM2lcDbjGml7Qv0XnhL1ROi2NWG8pVLgoU+TGGaopIdiVkAPQZynU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363484; c=relaxed/simple;
	bh=/K/18XjNwFzkmH8ZRsu48SjbEBGu4X2CzHWdPn25GaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AN4H27jfF3JTf3wYGwQNMgfE4LFi7vbrC4hM0VL4FVQvEyNzrWGHeNahEfJghN8Dvjk4lXJITszWu1UmhjanbJ4dC8Cu/FMSm9eS7FgJ2HzL0MPzk3mhXxIftJV9SxzG8Okg19jwdfjp29qn3KpU0PjqwwjwLjkcqHEEB/55NN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l51WwWf/; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASj9TwfgKK2UltoiwbRejuLuuM4R9okAtPeuolGeGqH8urnF8WF4gkY8X91xxOMyMfl8IJ7jIpeMAa1Sz3ESUxLfDuUIhA0upManjeXcBPEkOKEg5SyUUUgHPXKgNcV6bEReitE7WtMz2om7Jl6fdfP5bppnFAJdixueU9nbGiBeV+Vx4E+AMg4MDoLI75wj7gdRGRglb22/JhAmGFGOR1QEs1goe3gkWo1yz0Sv13d6vUVwYJE4YsFWFdDZqoh6mvDnut6go8w1ldFIIai/5OLiBvouqKi1qHLtc9pOqO6HwZC43agE6cGC8ePRtF3zLnjlxWmtHgf+Xv639FtVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfxRtERmxhyfLSn5QHfEX1dU5Iz47PhRUSg5AqmNyW0=;
 b=rh2PVOl8G3sWxAZyXnsUud72e0Qin77SOjD0wWn3JSJWwSNAKUwehyluWlD8wlE1TsPAA3wmtkqyPzBxynqLCFalVZLhC1gsU5d5Dpo4aWbVk80QgaVk29n/KRb2xizDkHkv9ShTvI91P0oZyDysamrrZTRRSnSu9AJJ2e1kIukCsC7bM7C37y6AXliBx7F/p0ExlmCgP2TsEa9pz3QO01OQQlCQzYoSeJ/Q4+Fc+bzlhOLQFdK8cJACeYcAkQ1Ixyd8ILA8RMf1xBowhK3yxvKERwNuc7ctT7wIoHisteniZKrJvPrmkSlLyE87jAb0pUDp+DcO0h8WbGBL9v8sBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfxRtERmxhyfLSn5QHfEX1dU5Iz47PhRUSg5AqmNyW0=;
 b=l51WwWf/gDdS/482AhLOPNYzwFDLBMHznzUDsERd2peGAtQzqeDAYt1vJLtFwjV73ZJHbMSLdV+WjBYx1bnTOJr/4gsaUgZ8Q/TMDCsMmg7ztlTe7mTczC+4/AMnF5cBEchvxKd34AdIPSZSCBJDjDnRNitzJtUfCuOxl5BUJko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Thu, 24 Jul 2025 13:24:40 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 13:24:40 +0000
Date: Thu, 24 Jul 2025 09:24:30 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
	avadnaik@amd.com
Subject: Re: [PATCH] EDAC/amd64: Add support for AMD family 1Ah-based newer
 models
Message-ID: <20250724132430.GA985@yaz-khff2.amd.com>
References: <20250722192855.3108575-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722192855.3108575-1-avadhut.naik@amd.com>
X-ClientProxiedBy: BN9PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:408:fb::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6fe384-8314-40ab-dc40-08ddcab57174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZkASCWt6VhK1Le8x+7IymKjqI4dzvykO79l81H9u3tFKp72Szr8ZYhSPb3T?=
 =?us-ascii?Q?LwUwCZiE9ZgsRzd+UUpJXGl2I1r2yDSm/UvrsJYrWqqP4YZCK9g3U1GTZqs6?=
 =?us-ascii?Q?qlqy9adZDNWCa8B/lk//gYboJFA5JNeFLzNSjY9zFkKDU+Qfw3vmh0AqSOz+?=
 =?us-ascii?Q?kV0X/uP051OwGGbj+14F5hfvJcdkO8Rxnu4UtfQ1ngaxaKNWqRuaZf/erjd2?=
 =?us-ascii?Q?JoWSAHyudR6CRZt9pilq/YyxacUCcA4DE0HW3PxGPARkVYrRRMnpW55o+WnR?=
 =?us-ascii?Q?UUbS6GuLgBol6cDorWrTm5IGpF890pvQHVsp+ZfNi/opV6/yEbfmfJ6PeTS5?=
 =?us-ascii?Q?4PcjxiBTpR5ksBX6ncSYAfkfoho0baFHLpLFJs+j5LnWftUPxjcT5gGyA5O8?=
 =?us-ascii?Q?85sK6xCLh8KUf/u7YeaIQAL0vkYs7WRfUcbcjpXw9AdvE20eXxnpER0eafhb?=
 =?us-ascii?Q?nLJJd2TmAT75Fwy5e0LtMWPQ+za5RnuJygA+UMusPTuP/8wuZGVUYn2/VpYv?=
 =?us-ascii?Q?5aSWKPJ223HJJ2h3t41WhrhFqgF9zUJx9ElGfM3opoigvMnsg1idqoTdMxIP?=
 =?us-ascii?Q?vFKsOJEqPjFFsh3zY4Vpx7uMKH9FCUcIf1iZGOuzl8P2C/zGolcKJI4Ov2sa?=
 =?us-ascii?Q?jYSI6qND7LwxHHUovTVS4XOVFNmW/JvS+WNjc1lJRt5NSge35zqmqtYws2MM?=
 =?us-ascii?Q?fED8pu4FREFkXDyRLPhFpx316ZdbT+XuewGosmuo2BYgS5Au7plOJ1q0/lYl?=
 =?us-ascii?Q?WOlFIyB/VnI7gc6rxqSy3oTE0a5qf22Hhk8y5LA1LyXXJXop0QEdhQv5j4k5?=
 =?us-ascii?Q?JoO/0UK3LTrWc1reWUIwX/UW1XN6bdFfIa6h+0n2mLWaWP4EdTY+/iCf/UAl?=
 =?us-ascii?Q?TsKDOSgNvGDYKKBiLtGs4SVczQBH73U4ClARlajHgaJ76LGssLUOymfsUAxo?=
 =?us-ascii?Q?K7myHxIMRrEKNxhzXQsb61zn8ZAcFZ1MDxp0sA3WCG6WDDekRq8ZXwfR2I/X?=
 =?us-ascii?Q?cZlzgMIiPaNaDAY5YYt0gHo4yTYkMiKWzXBLR8LrITS+Ggh/RCJNxDAUAPqB?=
 =?us-ascii?Q?4eYaqeMTBR3SRX83naweeLejV5mCiKflKXzc82/qVndBfkin1XCflIUgvElX?=
 =?us-ascii?Q?B16fWqbWBPN70oZJ3izaamv5upb8X9eE3Zr/+7Ga23cjDxszhwFgSm4fJISK?=
 =?us-ascii?Q?P51DKtEn4W2PpLg8m1a/vKn+AsM6XIulBMTfLaIoNuF00KoRDYkVB9SSoFpG?=
 =?us-ascii?Q?Tfg8HRaFuG+wgIqeACtKJEqTF8vnR2ubloaCyt6n2Zcf1zdkoKVG4JvguMVd?=
 =?us-ascii?Q?/+wsuUYwmWoHB3U3hxKdx1LBjiqSsV8DZK5NioHmaacGdd7mH7G3dA5j3Yn5?=
 =?us-ascii?Q?EYFUI9vqg0u2IVKQ1n171DFZveeNcXvHK18+kE3olpksDbi2zbjFE/3K6deP?=
 =?us-ascii?Q?0G8LR+T6JwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7f9AsnnXZteS5OBdlcJDdyfE5jE9rnvaBsYhIfZZliPVkYGDP0A/7DJtGL0K?=
 =?us-ascii?Q?IXS1DcuMukmiV6AW8sLPIil0pX36ZBVYgYhcuv6pE3nl+ZyqsJFwLCp+zIrL?=
 =?us-ascii?Q?NHnt6BZRXNe8jrDiLtIWv2FbBLYan5Cb7qnPjt/bdhMyOQV+4pszu2lwdxqf?=
 =?us-ascii?Q?aYxdRbO47e5pXFlRxHkPzCWt1x63qq/cIiO6pEBjYGEU7XO1X4gOzTWbBT/W?=
 =?us-ascii?Q?nbzpNLRuNFn+jETVwfE8rqRkYmwj+jXfwsC2ldici/CcUlmOFJ3mmXYpvE4R?=
 =?us-ascii?Q?eXSyuuspPd53xkadhP+qdyTOakQyd6dGpAyc6n5tOG5p0s+k/FVOtLbDEsyI?=
 =?us-ascii?Q?S6oHOgDnXLyzvjSZ+MdAzUlKXekmpvDFywyDCpWqeeiUGZB0vf2dLrcmKdu1?=
 =?us-ascii?Q?TaCNTe9B5fQil5aOY2mbKcPYu5bJ2Y1rugAcBik9fiN8EX5DcSotv676Iffr?=
 =?us-ascii?Q?XHuWVZVfJhzuINwLlQZSDgRDJ9+rgWfz7pr5qO4ZoL2JCco9IBFuO/whtDUh?=
 =?us-ascii?Q?kTo5Lue58AhmvwJ3c/KNQqvgmPYiz1RKa/ExRCYWcyT4sEBN0bS36G0PH+2k?=
 =?us-ascii?Q?gLMBxAmUDN0C9M89atytEl0CZUtHL0+BZbN1kEngPAR3RS1+GxjzsCRZNu/T?=
 =?us-ascii?Q?w6OZ6FJbyB6rWB3w+VWO5ePUckOxoLwyD8pE/tYZ1eZTosNveGv0LPzPvKyT?=
 =?us-ascii?Q?oY12KHlzlts2fajJ6Wp/UlK9mLtNsUE4GeLidxQ13K5fHbHH7SkvmHwH7bbK?=
 =?us-ascii?Q?D4MbG6E035x66XKno6ToP+ZnCvp0LyXAl6wuH7Yhp9165pxcOdbax1TGScxZ?=
 =?us-ascii?Q?qFwQb+yPHv2NAiFYGfBgfzyP5SlhVgh/BOJFrIi9NX9qKC79H2o6uTfWurH8?=
 =?us-ascii?Q?vhB0hkbhDOWlTj4utYb5h9SFPMOjekqKY54yJF1IbgDUfKTXSHAuJldJcaL7?=
 =?us-ascii?Q?jaitzsu0Y8teze8d+8JmQLyh5wMsog5eMtlXCsNM0JR2NgqY4qtrDVOKDett?=
 =?us-ascii?Q?6QaeIfiv3EuPzbqVm4/KR2bZGkNJmlY5I3fjLq8Vo+0KpBBZGA9zz7uFFTmD?=
 =?us-ascii?Q?9Jc3IooYyHrE/atvhYpO32E3NeygtEuKIzfGnEiCdsWw17noOgi4eWAldNin?=
 =?us-ascii?Q?K1R3zCrd7U0Viwq5XoRxijbze1bAiicCOVt35Moz7Or9x1bu82PkyXbh2L5d?=
 =?us-ascii?Q?NS+Cnr3YRxspbXJ3wk58g4SHm9jfWujZ8YxYXeigPq+cQEnCifFOWO5NkVDE?=
 =?us-ascii?Q?GydO0OCg91RyP9zEgsZGolB/ok96flQvw+GawU+Uw9uNM7Xa6BYRRDwb7fK2?=
 =?us-ascii?Q?Dha2HBWSVPPL+pK7usDh86/IIy3A/zM+i85EWpoy6udpNC6RrPfFmuKos6qF?=
 =?us-ascii?Q?Z7PVKoJFb+TS0aezZUvFBBFio+Ckj4Fpit3Z4HJJSeNAjTiC4wwlXMFmQxwt?=
 =?us-ascii?Q?/gMLMlMnalvyh2g/9lAj2ygCQY76zdJCylsnVw3pxIj2p5BAtuCYdCoyfYeP?=
 =?us-ascii?Q?U5b5pMozE9B0kjwI/q/Roa7QAS7nITqgtSZJab8Y30RiUzTbQR1hXX2EwffX?=
 =?us-ascii?Q?J8edajZfN5/eBFA2apB8GvqJ2uf10tiWDr+NQyie?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6fe384-8314-40ab-dc40-08ddcab57174
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:24:40.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgC/opIDaFt7imuiphL1jykXHIoFiqkYzbGfDv7vlBBxNfRM462jrx6TQG6mSwF8uUWBB4Ubbp+V5gFlPERMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

On Tue, Jul 22, 2025 at 07:27:31PM +0000, Avadhut Naik wrote:
> Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
> C0h-C7h.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 20 ++++++++++++++++++++
>  drivers/edac/amd64_edac.h |  2 +-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 07f1e9dc1ca7..06ae6750ca14 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3923,6 +3923,26 @@ static int per_family_init(struct amd64_pvt *pvt)
>  			pvt->ctl_name           = "F1Ah_M40h";
>  			pvt->flags.zn_regs_v2   = 1;
>  			break;
> +		case 0x50 ... 0x57:
> +			pvt->ctl_name           = "F1Ah_M50h";
> +			pvt->max_mcs            = 16;
> +			pvt->flags.zn_regs_v2   = 1;
> +			break;
> +		case 0x90 ... 0x9f:
> +			pvt->ctl_name			= "F1Ah_M90h";
> +			pvt->max_mcs			= 8;
> +			pvt->flags.zn_regs_v2	= 1;
> +			break;
> +		case 0xa0 ... 0xaf:
> +			pvt->ctl_name			= "F1Ah_MA0h";
> +			pvt->max_mcs			= 8;
> +			pvt->flags.zn_regs_v2	= 1;
> +			break;
> +		case 0xc0 ... 0xc7:
> +			pvt->ctl_name			= "F1Ah_MC0h";
> +			pvt->max_mcs			= 16;

These last three groups have extra tabs. Please align them with the
other lines.

> +			pvt->flags.zn_regs_v2	= 1;
> +			break;
>  		}
>  		break;
>  
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 17228d07de4c..d70b8a8d0b09 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -96,7 +96,7 @@
>  /* Hardware limit on ChipSelect rows per MC and processors per system */
>  #define NUM_CHIPSELECTS			8
>  #define DRAM_RANGES			8
> -#define NUM_CONTROLLERS			12
> +#define NUM_CONTROLLERS			16

The "legacy sysfs interface" needs an update too. I don't know if folks
still actively use it, but it hasn't been totally removed yet.

See this commit as an example:
25836ce1df82 ("EDAC/mc_sysfs: Increase legacy channel support to 12")

Thanks,
Yazen

