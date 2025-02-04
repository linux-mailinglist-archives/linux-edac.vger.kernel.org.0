Return-Path: <linux-edac+bounces-2965-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F3A2779D
	for <lists+linux-edac@lfdr.de>; Tue,  4 Feb 2025 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124DE1881980
	for <lists+linux-edac@lfdr.de>; Tue,  4 Feb 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D8215777;
	Tue,  4 Feb 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnGT/v6L"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C22153FB;
	Tue,  4 Feb 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688049; cv=fail; b=lrju1dU+8S3FAOUM3OjcDXBhRTlfvfsAktMZoOmUKr+qIRkuvcnikMNHXUs3LZmL+YV/EYpvorKb3izdCL05oLt6ePwK6kWlvjZsKIIHpOP6U+9p4kOav/EkPyUjQSVU4Vz4uD1Tx+9v62XemLRCjiDRV0D6Y3Wwnl4VrllVB94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688049; c=relaxed/simple;
	bh=6zi0WrJsPt5edkImngTxkdNPlsHiixkPmYB7ncfcQz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pveWKIyb9F6RvcElRYjNE5UYgz8JD4Vbjuy7mRVDuMns15G8SQtrNzuznqRxl4MQvZaDdx4vCqmqmiMpMykKpOjzRW0zNqD9uHB8XEtlhvSas79+koQbpj7O0LriKI0unamMZjpErNT7Ce6xoVY1AN1dlR24EB9wR13DpG/TGt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnGT/v6L; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twyj3VoapgheswjJ+HvQXDiiNZyMqDbLtWD7xBpMyj+alB9i/EAaDO47TdxDi+FUWWFSJg8cbIXjbjDXIkPU5liFPcf2mRnielw4QJFtbGWB4E0S0lCWbycwwhig0ayT+ihfMO4n48D3mXD929Wf74sungeBTsj8U3HqPB7J708se2wWKJRWFCg9K1/SDM8EbLJGdXRVJRAPmtP02EaAr35+6slA3c2vyx9qrSmcbXPmjHvB+hGfSi4DLSA7ngWifK8Wpz9DP1p/VA491dx5ZmJKfL5ThvGOv8auyE9f66c5IBELLCFXJPD0toa/JUw2BGt4BNALFfVWMxtfSCK4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TLmlzks+jA5Y5h6PLw7LR5C0MBj72ztqulI/RjBAp8=;
 b=yULnpEjjJ/dwgraq3l+RF8KasJ3l2uWm3PnAJUbs8RifGlCSBKGYpY7MMIm3LeuypQwxkX4dVoxtt6nJsfVDoZ3d8qh6kaNxTcoSobFytdhAUDBs3ZL0YXs+qP0cxPCRSIymtFd9SGn0vbIabhfKV5fOOaTJap6EcSGMgU7aZHPMZ67JzCrP4EIblVFxpLWMIofMmxi4KhWjJyxub6YolJUZdkH0qI5CYuHFjHEsyxAPmPRhfm/gBXqGlZpfKwlks3TEJJlS1kl49FKMS4f87+KI0Ad6bhsXgFI66xJq5G70hZRFfQlSZCpjBteSjvkpWpwQ8C5cAcocgU3GnmIn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TLmlzks+jA5Y5h6PLw7LR5C0MBj72ztqulI/RjBAp8=;
 b=rnGT/v6LJ8yI1DQffWYBOZiweIUF43/CiEetar5zgYMY6p4K/rlpF8Ocd2SBatSeveRcRt5ubknFlh/sSjaiNFI4mxjbXqwWMkKFZfwQvazRZJVGWhngy0APHW0PrS4MkRDQEnt4IdJ8vZHhT9v+jBTdDo0sTXyQBFIcc6Yc6YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 16:54:03 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8398.020; Tue, 4 Feb 2025
 16:54:02 +0000
Date: Tue, 4 Feb 2025 11:53:57 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Simplify return statement in dct_ecc_enabled()
Message-ID: <20250204165357.GA277200@yaz-khff2.amd.com>
References: <20250201130953.1377-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201130953.1377-2-thorsten.blum@linux.dev>
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ceb6bf-5f60-4d80-0c20-08dd453c8738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R9gq+F50QzvUqOLlStZeFzd783j7KapOQcy+gyU+/8WITOfv3mzZIgFCWaHp?=
 =?us-ascii?Q?UMiZYPGiqywTM6O/TKofodyLT6cppuF2SZbrlQ2OSFI4TzifboiWK5Zs5ehc?=
 =?us-ascii?Q?nGT52kFJtFDtG5ezGnXXvapdhQW6/+wE5x22T+tYxfBbqzZ0gGQxjFLwB1i8?=
 =?us-ascii?Q?DJ0Wi2SRaz23zxYV6xzD5VpQ18VymOdGCHxXZQkhZbrqulcFjFfZVVZmgTxb?=
 =?us-ascii?Q?LMyy/89ndnDVizfazNJ3VngBR4DjDZAlYNgHMeMJo2vD/Qk0OteCLnRvWinu?=
 =?us-ascii?Q?j6eye94iZdZMQkFIRS4hbHoJId7x7LU5QtCeMaJQphUD5HBt/GbDb0FC9vAI?=
 =?us-ascii?Q?VvaPQXPGu4ZQIzSCBZTIiaUoDIQpW7UV5G3BJ7G9QKo1K97OeDn3PTCxEaYc?=
 =?us-ascii?Q?LYFoFueVVz7Y8WdJqDmhMkK6vOiAtPnxwUkyzpRmnmOS7Ewmuap7CwlYYRf9?=
 =?us-ascii?Q?lNp9rD2Z+0XLZhBgPUfZZPvmY2zKgJptWUUAR0SAa8vMtZWe9aMkLuW1fFFI?=
 =?us-ascii?Q?WalEZiXA7K3kpfEZl7RKo7Su1vMH6ds/kXvBMbaaO95GaSAiflU7e6ZD/AuN?=
 =?us-ascii?Q?l76tiCGubgcsmVPu6+CnsNS5wgwVAl64GOyXmoTQF5m+IEfkWdZ6PHETgXz8?=
 =?us-ascii?Q?l6CleiW7J/LSFgf0qRn6/SF5i7c5OPfPcwRfv7749/LpDAaS20bd7S/+Yr7w?=
 =?us-ascii?Q?iGFLdUqtnmt16bqLgUtjURB7zhR/n4o3MpRYWhst4Dw1iZzrWt9RHfLq8dhW?=
 =?us-ascii?Q?2N44LH7slkm+yZGdgMPx5tN4xi3S8/vdXawuXgbuYuEatRDwJLW9mqatDORh?=
 =?us-ascii?Q?S4P9JP5qnvFB+Kat9WQRDo2Jn5cO0ESpD42raZy1k1DzQPsB97U8h1pi5vra?=
 =?us-ascii?Q?lEMcjiTMTtxDgB8qBuOKAhUqPjXZNQIWVE42RCm/AY8gnk5INTs+6k4Q+TjO?=
 =?us-ascii?Q?zgLYhkzS+HI9XuS/aWYdOjI6BWg2oQQuc8XwXxjbI7UMD5IjAqDuj13OBNml?=
 =?us-ascii?Q?U8qqvrFz2qNf8zp0F/dFRdwkyqPRASo61n1OiYj5Xcsijeh60UsGeEjCJHay?=
 =?us-ascii?Q?5f2WrnQUGAiJ9amyg+hecDjixBu5xaY7Z7iH1QsQ4gEzmkS7KAFNoCy4NtjK?=
 =?us-ascii?Q?r2fmj+v1PKgU+9QC3OOlk2jStaZl/l/khJRplGWA+ZwNFY8vgU/WCbGkCVre?=
 =?us-ascii?Q?ZsC68seG1kASSxjZnf5Id+Nv+aJE3pqvOcgtTbtfRcESg53d94iFYTKQlfxH?=
 =?us-ascii?Q?74yaT9XvY50gfejZrG8iecjXNIdBOLCtvVkGhVhu14vYSF1bLuib4zF8q201?=
 =?us-ascii?Q?Kr8yzUjgRHQW21laMyKgQGjAgW7kptVg95T+KO0ypSMNg4Yb60obW16ZU1iX?=
 =?us-ascii?Q?bCZG4321vWh4AOfLb2SsaZ7mt7VC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1lRPnGwqncvtso1MnJYWNfyyHNDx1bfu/WVBAzJEEdN7V64O4N23ZiyzfyG?=
 =?us-ascii?Q?t85SSrONaWH8LNSSBrDA7Q9yBuT97ohj2RtmYXkzz75hiw+Y1bCHSQGmhtqj?=
 =?us-ascii?Q?Ewp+otjCIrAZQD0YoEZGCRY4Hyad6U6DeEXShnqJFHY0PQU+P5lrABSPcT0A?=
 =?us-ascii?Q?ikwklHQvaFGrvqElwhAe1ff2TcpLU8c9Grh+NmdmGSDfHYzU2/I78GlExMAx?=
 =?us-ascii?Q?ANwnK4pz/VQU+/ZaBqw8URbGiLaXQVLyB1wLDPoNGWDMPzrI6lErDjmp2fmi?=
 =?us-ascii?Q?BBZWHJHiaS2opd1ZCrRBnw/fQOVcbUAOqu4hLzqjA15DPwAEj/ZMgTbZXRYX?=
 =?us-ascii?Q?rAOPXU8VElzeFB1C2QQ/qlbyx6V2uF9iBPL/Xb7BSCvcLWXNqf84ebiyn0M9?=
 =?us-ascii?Q?eJod+qosif1kCfN3Y2cjeyWT09aLGsJ87in1Bqm2DMwRr/6H26nM7L/iO4Uu?=
 =?us-ascii?Q?FwdMSjywNKZccFxvkpo2t/Jf2VDkG2xNN3NyiG0/EzZCx2zQ72NY2qDZeoUK?=
 =?us-ascii?Q?rCKxroCp/WUiPrMDLhRuOj1ha4M5tIcikzek/+enXs3tdmk7oBJB/BxT3Yec?=
 =?us-ascii?Q?hPTS+cmgozjIK4qfw47pEvCniS4hdi7QTVF/oAMimo/3Hr2MviNdanI5TwQf?=
 =?us-ascii?Q?hJu8CkB8yYHa90eyUVk30he3ndVQoMDyGJqygXHUVuM5sbw0V1MWbSO/4eBN?=
 =?us-ascii?Q?qhII7WU7uT1157BgcuXGWRHVFacHb6M96eOosZUJKGLhdCdJGx+MTg0hkfoH?=
 =?us-ascii?Q?x9xEa4cNY1VlGupW04f8iyf7zFrfHW19iAV3f30AxXFy/E9X8W9Dg/Wj8s9z?=
 =?us-ascii?Q?+h+U8CaK4adaOp3uRh2thnWRBBHuVN9azufNLJQwwRo2jzZJoNPzUXmjZpa0?=
 =?us-ascii?Q?0m/z+vN6dnllke02bTEOprZo7sl4ydVvLt5xfvv6CzZagNbLQ6+i6pw8gYUD?=
 =?us-ascii?Q?KYzpmFFywimUgomxAqZ8hTKME+Djcf38Shr838DGTqqk6J7sD7Zkrnqp/RJK?=
 =?us-ascii?Q?na+bQNGaTzWPZEXh6HtgduW2fm3XgcWV5Ke3h1i8uyt7GNXgQMD6aPLjmC+4?=
 =?us-ascii?Q?bscSUfKm/ESjoPlo3eUpPys2El+iThBW10MPhZzsDrRy7DwDhns0jhXK237f?=
 =?us-ascii?Q?WkY80wbmDkXcfffFyBj9noeEMqOnbcDqwfYiqIiYp+lgm1nh0KABWU5rmrfw?=
 =?us-ascii?Q?/z5oeFtbBCaiLIkKwBwd8SGm3tOxmEWhuvIig2O2Fmmc5Sp57bEjem/KAswS?=
 =?us-ascii?Q?wDd3wXta52V6aTzdEXMz8yNMHALAlNOAb/bHVGlGpdSoUMw2UmZJxnw7UUKw?=
 =?us-ascii?Q?drhJmfa29XkBNSJGhsIvNXqeVDq/jEB9/IXNoXa0n8ooFJ4mkf/wSl0SqfoK?=
 =?us-ascii?Q?PLtWIhf6YTFdwqGaCj1SoJxG/RvP1fsZfMelds8tillXJBfvT6/PniL5fpOr?=
 =?us-ascii?Q?5ZO4z3CupATuru7t4BM5OJ3hFqtkQbPluQxT5kKzv+gUH6z0r5El4W9o6/kA?=
 =?us-ascii?Q?N6NJcd2+8/jqifCm65mDxyj2D52kBNBB4CJOTv9iDwuvLsmBwcVS7E1c3/sf?=
 =?us-ascii?Q?/+0ID6ROIBXbC14+kGw4iRcUnBha0VIIvVKPXewD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ceb6bf-5f60-4d80-0c20-08dd453c8738
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:54:02.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1klAmWzMHw3AQ08sL4CfXcsdch4ydT/zJbgGGBaCh5/vHdgNyKjlCmMtqRChVyl84MMNoFqMgDz4XoJ4j7VRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

On Sat, Feb 01, 2025 at 02:09:54PM +0100, Thorsten Blum wrote:
> Simplify the return statement to improve the code's readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/edac/amd64_edac.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 8414ceb43e4a..1f106b4fafdf 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3355,10 +3355,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
>  
>  	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
>  
> -	if (!ecc_en || !nb_mce_en)
> -		return false;
> -	else
> -		return true;
> +	return ecc_en && nb_mce_en;
>  }
>  
>  static bool umc_ecc_enabled(struct amd64_pvt *pvt)
> -- 

Looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

