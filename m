Return-Path: <linux-edac+bounces-2741-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F119F6A60
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 16:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC28B188D0C4
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7DC1C5CD5;
	Wed, 18 Dec 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h+0bm0gK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10F1591EA;
	Wed, 18 Dec 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536929; cv=fail; b=Vz4xtSvUdUPHtXxNWvgZLrwh3PBuLVUIRNWaQ3KWFiP0TMGeFyfnmQ6LoKKOT0CU6ZSeLwSOIzasrevt9Yyht2EPFHthmf/2cOGFEomafS3xZrj0e6cKwu005O7uXNVb9E65BqyQuAu0MbQ+KrZEk0eicPgaOihFEt1UUXK1HX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536929; c=relaxed/simple;
	bh=xu3gjU+g86dy6NHpfa0KUZkS9Y0rfGAPjaMRzvCTg6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mqnxlE4yZUmoc6D37UZi04WdQ69bSjFCjrGPaJlyEExU3x0GTilK5hTJy1uSD41MUA4WJ/hzM2Li3HtA+/G7qsu29LV6W8mqInnlBIBsDBicXR5bFcIOtGSMeAtBJ9ORIXWBSqO61dNC9KaGOgkKGNGiihdOGx/mldVm2slVcCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h+0bm0gK; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W37IqnbNNB7CWEGrd33AQrRikHi/lyIZEHJNVvyUs58t1mfzNw86HQeCZGVSXC1DLaImFhfDR0BPQQxr9vx/cDb0tCJlnk0+OY+NEBp8+pp9rYqA/ExXDhLjt+Qx4JDhAXeJXLdyadJLrSs/qDw5KTOS5JZji5OtRVvieZ2gu70fz8qMHkxkEkgfgA/srxQZGbgBK+RvJQyc5pmNf2XmqsLBCW8rsZxfaqUfKWJuFpdlbZrOc5BNHJWdh5OvNPWk0rzecvT0fXJDJ911qHqvXcXec5pGxB8YNEZwaZREyL3WjGgAzDV9A0CuIvpcCEeH+ATeDF1x6gLB0ufesmeFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCNKQrd9zRpEsWyltyXRMvQ9EMRY+2X6HfnmMLJtShI=;
 b=jfuX/UsUCbj5GgR2+2Q/dpQrYPrpnpQKs6topO7hI3Q9vO0Q6tzLhfCQiMOA9Snopyb40g31DpnzfYl9TSJlb8teoNM1SFKCQQpIFUCPrCsLayT4P1+ljtlR6ucB8oKX0Zfg5BvbIsSFCFrvc1jeBDSwwxt5HJJMqIogfeajwpCgAclKb3Ut6FnKDOvJo+A53RW7vcNXn7HpFYe1uTusvoi6CitVvZ+/HHcUUGGU3RE+jIOjUpnb6F8ppquFPFTJXKFYAG3TdFlSpGIkO9txZ+06tcwucgyQEQGW4V3z4IrxfLlUKXNrF9XjJVU+7kysE6ShD0LhSR7DGOVv00IfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCNKQrd9zRpEsWyltyXRMvQ9EMRY+2X6HfnmMLJtShI=;
 b=h+0bm0gKq0Q+BJCypViiESOFgEjYQUml1UM8nPm6PQzztLJnQY3SyiU9j3q7JoD7z5iuSLXm7lvF7FFI9nyFOSjEWQEhRxbP9NR7IwZ41WTuwZGQjhlqydsuJKrAhVD+b78kOCMJMt38uVd69aD0YfWPr5+IaGH+VQr2F/sA77I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Wed, 18 Dec 2024 15:48:45 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:48:45 +0000
Date: Wed, 18 Dec 2024 10:48:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] x86/mce: Make four functions return bool
Message-ID: <20241218154837.GC1155365@yaz-khff2.amd.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-4-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140103.66964-4-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BL0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:91::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 243850da-08c2-420c-f7d6-08dd1f7b7469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZyzQHscbULfSvVDGe5cx6ZsxSElcfhESetFF7HX31Ce7GhiQuCFQLUhBMEd?=
 =?us-ascii?Q?vON36MhivwjWS/OjAnu8nT6/jNd4e5VakzZdsLbg2tyXrv+4aSZmi90/GQj0?=
 =?us-ascii?Q?OKhwEuJJV1COa+kox8emeS1tyQPLGxHQxo8BAElePQO0ZHUtfNoj4rcMhWut?=
 =?us-ascii?Q?9Hb4y0DR2KWb9GTpTG55VfOKn6EWsQOHlbHYA2cNZ/+9I4yyYKwrgLrr35Ev?=
 =?us-ascii?Q?rXocYOl7yrnKPlHbYlkv9Zs29dJ80/61OLDelxahiXqX4EHdOU7a9NNRx++O?=
 =?us-ascii?Q?uwbvPDoeO1E03JU963i7XEL/w7kaXju6uBCXPxzcsjmic02xpeWvSv4542Qm?=
 =?us-ascii?Q?2g2ywUS/RVXhmn3c47Jho9kDxXbC7YS6pUmkd0XeMBybjZRbIL3XuqrG/5Ae?=
 =?us-ascii?Q?za26C2iBE1MpH5zsBveSLOwkwftj4s7dcQpkjcleNuwtwql/SA8eKbSdGmtP?=
 =?us-ascii?Q?/xDqf4IV2Oduf2w26LkdPpfNOOe2NEkhNV55WhyhHsoOfgIGr2IQRTnUxEM+?=
 =?us-ascii?Q?lExWXV7Dfqg0XsZ3+jfdBScufOqX7qVOdarWZ3puDT2vOWflzCk/SodKTaJ6?=
 =?us-ascii?Q?UNA1ohm5ly6xtFIpSJ44YJUuzUhaFq8P8t9JAO0xdASVARdnV5NIamqs3xz7?=
 =?us-ascii?Q?lzjS18lyie8+jaccBTPwAF2lhdIRtbI3ahqwkN+2YfSdNPIA4Sxr3XoTtm15?=
 =?us-ascii?Q?Sl0NnV6BuGRKjckZSLQiFEbBB3yIJmWsOr+7tpH1cJgmL4TXFBDHewDKcfgM?=
 =?us-ascii?Q?faCM12LIOl2t7oodqiLG9ad3ZVXmbjtfRdEBshUkjXcyo+k0QDn7pZgMBfoQ?=
 =?us-ascii?Q?IRntrOA7vnGb4ggKcAASHtKrva2F4WULge+GHGNto/txnL+wZu6Gx71+lMwn?=
 =?us-ascii?Q?QgpXVBlbpUp3ZZ2la88CurQZwIgG59gUZvpN4E8Kcfbm/jSABljhv5chz3QE?=
 =?us-ascii?Q?CvhckqGZuLieBXKdOZC9b3S/sp7IF51uPTox9SloE/iAWNFn+1n972eFqXOz?=
 =?us-ascii?Q?KShkZJuVssQeCx2xr3z21qPWe7W34IYCYRTSfl3xOmCo4M9xttAbcMbmmk9f?=
 =?us-ascii?Q?5nFl7y0dsQ435Fw9uc9kPOXCfVglkIlQ1PjlXqbF2rCXcXxg0zhZrKfOxE1H?=
 =?us-ascii?Q?gb9sh0UVmFb51Ncw4Zjcsel9bRxEPjouE4PBaisVLs+XVWl7DexTxfsX9uJB?=
 =?us-ascii?Q?lxIVplf7c+zH1WcXc/7eDaV7V7WMqu/8ul+JFYW0onPONuBPge9H1MMfzLE6?=
 =?us-ascii?Q?jMxHREDg+p8OtsKI+PLUsWfxiW9AxMH9ou+4/rR8he0kdsm+UEOlvYyGhOjX?=
 =?us-ascii?Q?0cdRrnsl6nGby7krfA3VFe71DXzfTQQgfjwQECJSTZ6j9fdlHQi83ioVaUXE?=
 =?us-ascii?Q?xTJrDnGAkjJeC/n1ud20aYmmW/y4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMA4hiPo1G9NOzL5Db+PSAP1rzy5/EdRa70sqE5mYKGOkbR8a9ZzA736teps?=
 =?us-ascii?Q?I02BaVnPLn49P4xSIgRK8KdjvFl6DqyVaIuOhjqdxePqm+5GbhWokMwy1YE+?=
 =?us-ascii?Q?TlvhRRNt2dci6J9sEaXh0IkUBz44mdGqF2MpEp7rJodgIORdNF3NsqqBhOjy?=
 =?us-ascii?Q?fWQ1bx6RrxxsJXhimJKiFa1nYXPVJvgmGIshUBWV9Gp9S2FRDPf+xuaw3sLQ?=
 =?us-ascii?Q?XJKzo/vgM2VW8zFp3Qp+RXkKhnj9Jm2DoZe+y4bkHmZOyWwTqfJZpspDRD8Q?=
 =?us-ascii?Q?P4pcHEiTmgjmuApXFSwhrMisW1qulmhAUY2KcyM0Al1EoRaqcgfbc2r4qrdN?=
 =?us-ascii?Q?DPbyqKZrpWbrquO7EE8L6THFyHzYF2pzDcJZLL7kmM2/qAKeNtHmW2yjBXeL?=
 =?us-ascii?Q?+nfxHPBJQmm++43x9IfK2xQJ9KYBWfjRY7O4Rtie+LgQWaGo4kOtEZxzohad?=
 =?us-ascii?Q?FBc7KFegTjoms9XGZk1DBpSEXCBfA6HXQgHYhYHh3yIr/uLw0tCWX6XAaUff?=
 =?us-ascii?Q?QH0TvaE/E8iql993MdQs+k6B77M8ywPIVJODS73sf476LyrrTzPLzOI2eRJ7?=
 =?us-ascii?Q?fPbTUWp8rJ4TLpzjdhqnrnpHjykb+bdeina+pGO3eDEVtZ83CM/bTwgq0jre?=
 =?us-ascii?Q?7WlWacRWewfQQWwsE2fpMlEc1SDNlJ2wqULE7bZCu2IuNYSKjNuGDgBxjJ1D?=
 =?us-ascii?Q?2tPfpsW/4NZLJDmQRldZ+jagjOTFDSwt964lw5eSmNdV1YX6dgLmuRnXn+ON?=
 =?us-ascii?Q?WVhIR6MRUoHQ+xElyx01bqVZE3tv3DFH3VpdQVCNbE5nDtbuNMb+TljsS5kq?=
 =?us-ascii?Q?n+TChqxS8s/KGiILzdphts9Fnlzw6OHdDpuuAahjueZoaD+eB3NnupBcWL70?=
 =?us-ascii?Q?AFxLzRfB24mmpegfrNn6VMvee+5hMD8EqZ70txzlSMLrwVcEaBpdruBLZrHj?=
 =?us-ascii?Q?Tv4dKew9mF2WZUkcei2UO6tY5N7vFGiUqwsAIoqAOd/GwCX69U3IJDPGEtdw?=
 =?us-ascii?Q?iGKlS+s78942xNgux2/kKb2EMwJH4Pg/+wP6dvS/yb53KY6+3ygAPmnCTwK0?=
 =?us-ascii?Q?g/LkouJKuQmosjQY7K2J0EC4bY1506/D3tNnVBiYCpaIQ+ow0g6J/GBdUckq?=
 =?us-ascii?Q?eAUmp2byjQbtYItw95wZDkcCJ5n+6rczuVUV6uVLu2fnC3K5sJz+2XKWsRiC?=
 =?us-ascii?Q?FFi5vs1sqfs4L3GqMtv6BNPWQiAgKAujZu+5htF3PEBGS4iHPdyyO6R0PPNa?=
 =?us-ascii?Q?17xLa9unAO+gNoE3EJ4kL0KjkSCw08FemN4Tbj58Ix5EutyN6bUiOy+dScs/?=
 =?us-ascii?Q?ABHCEV7ezxqjJF7gE6CIr1rxMFhGNCoyf+etx/rqxtzfQMI/U2ftI+hYIlFj?=
 =?us-ascii?Q?w3ltYHpc5qIm2RnOTOeLUT2BwX6f2uBMVC1hzxKvuB4qG48QOdeYzQrIhSZz?=
 =?us-ascii?Q?4Ii5yXPI2SSe3Gos0XK2ioJO8mkFhnT7D5UjlVVmlbHY+C9r/Eh7s/vedrUl?=
 =?us-ascii?Q?hdb2PJPhtB9fADm/Ak3lDn/AeEYqopfiFBu7WnDAgcBMR6RsWzJXbC8Ewo8r?=
 =?us-ascii?Q?MAhb69NMmYaP53PLgpGWNGn2ctL3+DfcJyF+yLzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243850da-08c2-420c-f7d6-08dd1f7b7469
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:48:45.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AySPon8Va54qXFCXxJNdZAfPVfNhmj3ELP8EJLdv3ulu/fpd+KkHHtDSftyGV1fT6XPnV0lr3d0bOQjazrrteg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

On Thu, Dec 12, 2024 at 10:00:59PM +0800, Qiuxu Zhuo wrote:
> Make those functions whose callers only care about success or failure
> return a boolean value for better readability. Also, update the call
> sites accordingly as the polarities of all the return values have been
> flipped.
> 
> No functional changes.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

But one thought below...

[...]

> -static int mce_gen_pool_create(void)
> +static bool mce_gen_pool_create(void)
>  {
>  	int mce_numrecords, mce_poolsz, order;
>  	struct gen_pool *gpool;
> -	int ret = -ENOMEM;
>  	void *mce_pool;
>  
>  	order = order_base_2(sizeof(struct mce_evt_llist));
>  	gpool = gen_pool_create(order, -1);
>  	if (!gpool)
> -		return ret;
> +		return false;
>  
>  	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
>  	mce_poolsz = mce_numrecords * (1 << order);
>  	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
>  	if (!mce_pool) {
>  		gen_pool_destroy(gpool);
> -		return ret;
> +		return false;
>  	}
> -	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
> -	if (ret) {
> +
> +	if (gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1)) {
>  		gen_pool_destroy(gpool);
>  		kfree(mce_pool);
> -		return ret;
> +		return false;
>  	}
>  
>  	mce_evt_pool = gpool;
>  
> -	return ret;
> +	return true;
>  }
>  

It seems like this segment could make use of the helpers in
<linux/cleanup.h> (maybe as future work).

Thanks,
Yazen

