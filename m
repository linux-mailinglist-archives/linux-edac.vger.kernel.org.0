Return-Path: <linux-edac+bounces-4458-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441BB13DFC
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FD5189F9AC
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64AB270ED5;
	Mon, 28 Jul 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XqKxQW23"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67327057B;
	Mon, 28 Jul 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715694; cv=fail; b=Tr53/1JQzuetA8DpwbZe5FGRG1ZGdi0PCmAhAhwPOCZSQzjRBO6aDR8eyzPvGfDKuOqO/X4ZdOuSUuDjJFp5G+2egviP/EWHQ4erlvzMKbDtppZndPyHqu6RxALGdRwH1Z35bOfLRYwgNzxq9nPCu8tEOWP2gZ0zwIXKa0zlxyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715694; c=relaxed/simple;
	bh=hXn9ABqj9gICajmmuOfZXb/rNrZPw1YjUSJfrctBJwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fBBhTF+VALBsSajtXbvBB1VZ/wqzlL27mn17zvF1YJliLzltxwG+vmL6YI81GboFhz000K9nkgS2Pw25sk3w0CGMsXYv2w12SdBroa9n9oDSEg9Hr5cCr9yTEHc7L2Kbg5iYjRtZQt2XsfR1HbaTBUBokYsTio1pqF1EXsw5uRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XqKxQW23; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cITaZNs8GOoi5PC0einzu9P14Ngec4mdKhAwmyhrFE9U/TR4rgrkoLB0WiNKgagkdTZdXjNTWmqyhYOWlx8/dONUDFPkvmYuJYwj6Wq6LNV0gemsukiWNgb07e4HjoVfzr5El48AHcuegLRYkPxw6iIQiGqlgM1uMm0ZYHHgldUfUqEMSmfvsqTgrEzqReKNJ9vDsU0Tx+o9sUgHAZGuSdbxtrtc3n19HSf1KyWO2HKZdxT7sCbdI5jdavp5BQwyWbshreE3MCHaIF6hRJX3roM5Wz6/2lUFGbNhhZtMgJQNOeVoOkMDJBeb+eYh6bvSXS8rvRMyAcjF/79NjxR2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHr9IdV2Fbm56uRCFV3FNIPwHTknjLYDX36my8LNnSI=;
 b=wXbhPWipld7KoUvhv5cRWoO1YWxnydHhNsNdIei4cCCKAOMSOvhuqjbHinqfHE5mCbdjFmYXIG9w/dlkhDQdbVtPWbgNX05UoF6dLdBJ6ExaF1k7bACWTv3Bm2ITYLBw+6bdSYpyyQZ0oXow6ngJA0mnvE6Ndx98JZmtK8sAUZw8S/pBiC4EwTQTRg7nB0IhEfDzQ9vDFkKn+pgnKeTBhXpT4Dkj9Bl9flzJicmYxAIdy0yb3Tuhy9cCI5msLe7H0x4qkTEG66rt1C/oOyCnL7KsmsCnkkn1JCqbW1duaiLatkY76MpOhRoD2r4lVZ/tUUMGAqDvKwp+Epdzud0WUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHr9IdV2Fbm56uRCFV3FNIPwHTknjLYDX36my8LNnSI=;
 b=XqKxQW23olb42tUy1i/Aux+cpgyxKqjtEft7sa6oEPTp73gBkwNHzoTrGQmlXSIV674sN0tu41PGZ6Krk5wB3F6FELDAg97EdJp3yo7hwqty+JyASXv4e033ZewpgBN7S9QjPZKGrI3y+wWM2P/UbY/hnmxjWKlo9XiJsVIrOlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Mon, 28 Jul
 2025 15:14:49 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 15:14:49 +0000
Date: Mon, 28 Jul 2025 11:14:40 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, john.allen@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
Message-ID: <20250728151440.GB33292@yaz-khff2.amd.com>
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-3-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717165622.1162091-3-avadhut.naik@amd.com>
X-ClientProxiedBy: BN0PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:408:142::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b70a09-b2b7-4fbc-7e79-08ddcde97e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kaOKYJWdFOoaTMUo6AcppF9yhW/ptPaaAhBY35uIX09SBzXDWum/W2wDYUf+?=
 =?us-ascii?Q?Cu0WLF6GduVO0mUquC5z/rw1m0d2axPiMb6pN9VUq52hgrPCO6hPKC3S1DUT?=
 =?us-ascii?Q?A1BYQzarn1VUJYaLpen5mtkUwO8DBGxNLAGyNlfM3te9h/YGjQSSJhq4yIhY?=
 =?us-ascii?Q?iA3eImLvfkT08L0khtBa6C+/Dj4RSd+/ft7v3RocGJQ+qusQtUmc8YO9CSCi?=
 =?us-ascii?Q?5HfUuCzFjgTGfqXt9cRI6Wdf+Q3vtLxHq9L+hElC8ds0saxnKrS5352/eCFu?=
 =?us-ascii?Q?gtufsc3hb4FIVewbG/dYxm54VLQJrK/b45B7VrhnF5Oa6i86m3Hv74tjLJ+F?=
 =?us-ascii?Q?wVMcjzOcL14xCiSvq3qcvdxnR3ZnYbVFcGYIkf/zO96cYpcGrnRW+ggHaYnH?=
 =?us-ascii?Q?pYaXz8wM/jEmOzBKyUw2ob8cfJLH/aT9PoNWXJ860wsWLLdG6E2CmbRbBDbG?=
 =?us-ascii?Q?h12+/z9x8aBrIYRp5xEX3RUeKgPI4KcxgIPfqVp44fDfE5gDriDfLz6RIfMP?=
 =?us-ascii?Q?IQ5LVmpwhQ4t6aOE8LV6PMeP5T+78tJOBU1n+6AqitVuzEa6JiW9NoijPZej?=
 =?us-ascii?Q?Aq4jl3f0zQ3AJxbO5z5SvKTesl5doHwE/OhXgF0ZXzqFr86EYxEzBuyUpYxM?=
 =?us-ascii?Q?Fdpf7RV91wXzkkiTt+AJ2vU2O011Fa2hAkQw8ZBnbOY0T8h7mcpHchLoLRAf?=
 =?us-ascii?Q?dK8sRa7ieHO0HAq9h8u2C4buMXe2inwiT6c5r3HN5Gew9OWfYm6x11WNYw+o?=
 =?us-ascii?Q?zKR9FrX/wyIuqH/llKpEzuoW3+TFz5pe5iGgJn8Fq6lORO4UrGsppr61M3eT?=
 =?us-ascii?Q?f4uzYJIM6ve231jOjNDkRfy2TDV2GE1LSC2Z7UyZm6oWMFkrvASVdEnMaYUv?=
 =?us-ascii?Q?/7c9NB4/SYPK4ZEYXH/IJ2cCIz5Shd6HmCCdMDalYZCWSn61DTc9zVqxZUaP?=
 =?us-ascii?Q?bmlh+VHziIJzQhwmix29JEMn9EmKDUMumeozS3Teso6hC3lMCNCD1PweNhot?=
 =?us-ascii?Q?Zpp9M49D8pDDcR6Ra/SdaYkH9RROvQy1abBuL/dejmnicTeZzLBPBB9RplgH?=
 =?us-ascii?Q?baOVCZ8/L2+bhMzHO15npvuk3PFWiUXVCmfVFqOCS9BNxdAUjQVp1sWiUQeZ?=
 =?us-ascii?Q?Lisjr93+jkjBQHP31wQ4CMfk4Hm8UWc5gnkSdAeFgPilw0+O24Qabadhqj1n?=
 =?us-ascii?Q?eV1IdZlM4/65+WMnCW2kiHVom9ayyznGQlXNaYe9hqTpHEft4tSCGzxiUeVw?=
 =?us-ascii?Q?vfDT3lkGfbqx8WVRDpULz0uAU0YjeHTqkoF3S26B1bg4XfP1P2/7Y6tGlI9/?=
 =?us-ascii?Q?OS02XHq8YRBPz8san+KQPJIgSTZf/DyZyEt1zABYZY56llTkZnt28XzeRENx?=
 =?us-ascii?Q?KS5JJDDeO+BUjU8B5BOeLqDUabuQwEFwDM+GQgjn7biIzscTVMOLdQwbM3ep?=
 =?us-ascii?Q?+6ct7VOviJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqikBcW+mezFubqovoyr2Tqw5CDQx8hpVxC+Q9Nw8fByI5d9d32gdomeaXZO?=
 =?us-ascii?Q?AGWgLKXLgpqAw12/Znb2C1q5JSk0txYjNSXjd1b/sp9Uk9qpxZ/JTp828o/N?=
 =?us-ascii?Q?KpfZpIJFE34PEs4ZJPP2did58TWcTMkxfstKQ/Z9rhamMwVfLIEKcAuzbjtF?=
 =?us-ascii?Q?JlQVETn+7tLSIjhVHy3GYe3bfKOk1Oa1i5gwDF1k5YAw/rXKgUPC9/JqDaRs?=
 =?us-ascii?Q?94GbZ0UEcDg1iuHEm/CFTVYD4kb9AtHm+yyWy7iE+zcCKPlQhM6r9tWMh088?=
 =?us-ascii?Q?LRtV8ONfpBVVapM/QFqwgKFbTvk4/MsRwnD4C3ltPbL6RCkCI9hng9cdOEcd?=
 =?us-ascii?Q?DWvBXiH5baTMGi1MVpCt7xmtS+QygjAK+ItRKgclo0jdAJ9x0Tp7VN1Uv3z0?=
 =?us-ascii?Q?ZQxRs7gfl+cnYAabSkZtCgxKQjs1QOuQfuuljJrcUP33jG43QRX9kOP44Gz+?=
 =?us-ascii?Q?HyiVIqHU8eA1/cAapDtVnrQSVtRiPrK7ql0ufXWEWnaexhKcW7e0TyQOCLu2?=
 =?us-ascii?Q?SYeH2CU6xX5YIuW0Wbm5KrqnOV3ewYUKDAyCUlpvesQ61bgcsCC8rUqS4IUu?=
 =?us-ascii?Q?l+/SERDDYkIEv9LbeCT0GYTP0wfxFvKsAdphjJ1O4bFS544dL+cZR3Kp4sSa?=
 =?us-ascii?Q?06QpOuDOYFAIeEZ6gJpZYoyW8CtQBd6r11MD7pAqJso9EmzuJEEWYkC1A7Po?=
 =?us-ascii?Q?eA5ogwZezTynokrqdM6ebfXMCSzC4gLzhMXdIP3SnNL6bbOpnQpotplCvtz3?=
 =?us-ascii?Q?iZfnAhn+o75h+zAASFG4odmH+OB4lvb+MAXm8amK6BTKqcnmQJ7Qft/0yEkn?=
 =?us-ascii?Q?5HwVilErRqYGil0FhGGaiYZ34se9PgT0VYnB4YRggqyQlbJPTrVuWtqIcXoU?=
 =?us-ascii?Q?SBmb7EacgoDHy8U2GyUyRjFJxJ4HJqraEXHf6vhRw0XGMqW1xtYRi3BMvIw1?=
 =?us-ascii?Q?48NUvDhspr6zNmcSVCjjP8L583/UNaZ7r5J6NAot7S0NIvope4pTi5FNaB7j?=
 =?us-ascii?Q?hUpgCAXspLDcYZb2UZaExQFiHrVfCfsxMa88A5r3Xh3Ip7buUohR9EicZ3j5?=
 =?us-ascii?Q?TbXvJCPG3y+GkFzq1AneczjGJZTf+8Svbx4vmyr7q5oPQ+cQN7Jq/zVdzNWM?=
 =?us-ascii?Q?mCa8pQbeYWv1a8uzc3vA8OycJa1GXTVB1PZatrWH8R1ZcKqJ/JoQynzCz8/s?=
 =?us-ascii?Q?+faywy8pDXVVbqoU0H9KiTFdqY+P2TLF23hzIqm7RIU/wzMcGwGMoKb2+ZnD?=
 =?us-ascii?Q?I132gdiqyGHADycLVZTv7Cq3u4n25Pl7jkA5xGQeRScjjaSs1kVDAYJ3FlMg?=
 =?us-ascii?Q?urYGf/xTc2CiXM4TIEHtO+1soYxq2Kd7v0UzoiqaWhYG6UoF4TONKAWa+XbX?=
 =?us-ascii?Q?e9go9ljd46O2IAUI9SRFJcDeAyST2gSJTc3Z4CxuItrmqtXo3qgvLPfXVPej?=
 =?us-ascii?Q?XNC0JVAMEUWY6I+3oDqo5bpDIZCFMc/km9jmV3H2RgpExp3s1+/0MyMk1oko?=
 =?us-ascii?Q?CubvhbR3FBFLC0oFIZAmk27WsNkU5Wm6v6ATEYtA17ot4OTJnjFW1FWFnQFK?=
 =?us-ascii?Q?5WuoLrLg8EgrtWIngAq7DSl1ecYM/GDOHI4DHCAd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b70a09-b2b7-4fbc-7e79-08ddcde97e51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:14:49.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZD0QWMz2LD2QDuuOopPrjEgSP9dSKbMrqsRuWCBhqR2IwSu7l6KK8AwkUoY6JuQHGosgZMNnjRUSrqG1DoblXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

On Thu, Jul 17, 2025 at 04:48:43PM +0000, Avadhut Naik wrote:
> Currently, the amd64_edac module only provides UMC normalized and system

The amd64_edac module provides data for the EDAC interface. This is only
the system physical address (PFN + offset). The UMC normalized address
comes from MCA error decoding.

> physical address when a DRAM ECC error occurs. DRAM Address on which the
> error has occurred is not provided since the support required to translate
> the normalized address into DRAM address has not yet been implemented.

I don't think this last sentence is necessary.

> 
> This support however, has now been implemented through an earlier patch
> (RAS/AMD/ATL: Translate UMC normalized address to DRAM address using PRM)
> and DRAM address, which provides additional debugging information relating
> to the error received, can now be logged by the module.
> 
> Add the required support to log DRAM address on which the error has been
> received in dmesg and through the RAS tracepoint.

These last two paragraphs could be something like this:

"Use the new PRM call in the AMD Address Translation Library to gather the
DRAM address of an error. Include this data in the EDAC 'string' so it
is available in the kernel messages and EDAC trace event." 

> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 23 +++++++++++++++++++++++
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 07f1e9dc1ca7..36b46cd81bb2 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2724,6 +2724,22 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
>  	switch (err->err_code) {
>  	case DECODE_OK:
>  		string = "";
> +		if (err->dram_addr) {
> +			char s[100];
> +
> +			memset(s, 0, 100);
> +			sprintf(s, "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x"
> +					   " Row: 0x%x Column: 0x%x"
> +					   " RankMul: 0x%x SubChannel: 0x%x",

There's a checkpatch warning here about splitting user-visible strings.

Why not use scnprintf() or the like?

> +					   err->dram_addr->chip_select,
> +					   err->dram_addr->bank_group,
> +					   err->dram_addr->bank_addr,
> +					   err->dram_addr->row_addr,
> +					   err->dram_addr->col_addr,
> +					   err->dram_addr->rank_mul,
> +					   err->dram_addr->sub_ch);
> +			string = s;

Looking at the description for 'edac_mc_handle_error()', it seems that
"other_detail" would be more appropriate for this info.

I do think we should consider updating the EDAC interface if multiple
vendors are gathering this data.

> +		}
>  		break;
>  	case ERR_NODE:
>  		string = "Failed to map error addr to a node";
> @@ -2808,11 +2824,13 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
>  static void decode_umc_error(int node_id, struct mce *m)
>  {
>  	u8 ecc_type = (m->status >> 45) & 0x3;
> +	struct dram_addr dram_addr;
>  	struct mem_ctl_info *mci;
>  	unsigned long sys_addr;
>  	struct amd64_pvt *pvt;
>  	struct atl_err a_err;
>  	struct err_info err;
> +	int ret;
>  
>  	node_id = fixup_node_id(node_id, m);
>  
> @@ -2822,6 +2840,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  
>  	pvt = mci->pvt_info;
>  
> +	memset(&dram_addr, 0, sizeof(dram_addr));
>  	memset(&err, 0, sizeof(err));
>  
>  	if (m->status & MCI_STATUS_DEFERRED)
> @@ -2853,6 +2872,10 @@ static void decode_umc_error(int node_id, struct mce *m)
>  		goto log_error;
>  	}
>  
> +	ret = amd_convert_umc_mca_addr_to_dram_addr(&a_err, &dram_addr);
> +	if (!ret)
> +		err.dram_addr = &dram_addr;

I feel like it is not necessary to pass a second struct if it is already
contained in another.

You could just clear (or not set) that field if an error occurs.

> +
>  	error_address_to_page_and_offset(sys_addr, &err);
>  
>  log_error:
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 17228d07de4c..88b0b8425ab3 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -399,6 +399,7 @@ struct err_info {
>  	u16 syndrome;
>  	u32 page;
>  	u32 offset;
> +	struct dram_addr *dram_addr;
>  };
>  
>  static inline u32 get_umc_base(u8 channel)
> -- 

Thanks,
Yazen

