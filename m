Return-Path: <linux-edac+bounces-2284-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B99B04C2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889591C20E70
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B420103C;
	Fri, 25 Oct 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jnK+725G"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C51FB886;
	Fri, 25 Oct 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864585; cv=fail; b=G8x6OnBX2eTps6/kO9UitChjJyUuHQhLf5h2mGDDa6GE7jKka8FaOh00P/Sx12s5tZMjw2RqsLsPRblN6c/EkuPL+8jI2TorJut/HC5CAS5q7yCCBW7Qu19fPCmCazCIaF1D1VcwFcY5U9P8XwL9FTt4NsDTbqZdZuSU77+JUO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864585; c=relaxed/simple;
	bh=geMda866BnS5Ue13GJ7eD5lQEFOAakoIIM7KYgqf1As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FdDxRD07dYEQOzJS2JkcpCkalfsLadMhG9HLJujrXFi3a0XLV0tR4L3EStHVQ/6qYk6xOxZKhkCXKhYfp0iIQMrz1KAhgtIDezCHoZzkl90592bGI5QcOdxicmPR1oaZuUb+jqfvrlWwG9yXsb6G9dTz1NoXMMK6BWkWsT/tLXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jnK+725G; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKl0JW6PXmhSl7vgJMx8gBVHGts4YIGXMg4Rct67xtvOEVw8JqDNurf4VdTysUp/tBv/Fc9CG0sy5x5NLycHOEepIPXAt4eUv/RBYusOHqw+mGN+Cs/QTcvM6bFfSLS/LpMkpeiO067WNpqprmoLGhvz8OT8bGSXb0imk38IfZJBZsL51fcSf3oZSykcJ2GzmdjexYdvilKkUaM48/Iaf20cGqpPEpmaTUVIgfzqjJksRZLTFn7g0ktco8cwrxCEhT+w6piMFlFaK0codsCwV0bykM94gSYnLNiSMK0Fngi/A9zKH5K8pb1QFG1edlYc6EPANBDHl6Su/E1rDaruVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQKAqtvl3HeRwcp5xQytBxV5ThNic30WnE7kginhiIE=;
 b=cfotV9Z4V/5YtAknFxjk75INkk6A49z6xl4LXZ6TtsW+Qa3Wppab40iq0uUontXDS6sY7JfYK7r9lI6H0pY6Iu//IXUsA1npqnQnqfhr4aPfMoYpHbnS1hWdVo4Jk75WLAFZdhETpt2SGug5cNXHv+B+hvw3nZplNe+ORW12RZ8annvRle3S6keicPc1SI2MyDiJd8NX2urR6XEDtI++KZC/Zi/qYSGO3zqSfdDrB429tKibismf41S/UdpJTh2UgRnmkUCCl0tdJTsPRtYJ0YBjIM6OplJSh+/on1Yb4KscZ+0thauv95qsNqThpBGghT32HjmMWYnpHRz8UxVcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQKAqtvl3HeRwcp5xQytBxV5ThNic30WnE7kginhiIE=;
 b=jnK+725Gd66fJmtUXVors+hYXZgy+m3Ye9D03kNiUfj2fMiNZrMyo+CWDU9l23jffLK736ilJg9M2uDlb2saGOymuJq3GN5YiiQfLd9xYEFjDV+Q9EuC40oGblchmfLjr9nOGqE48Aa4vIu3kuf1gpx+3Ryr694yq6ZhKG5ea3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Fri, 25 Oct 2024 13:56:21 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:56:20 +0000
Date: Fri, 25 Oct 2024 09:56:16 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/FMPM: Remove some dead code
Message-ID: <20241025135616.GA407109@yaz-khff2.amd.com>
References: <6b914abf-b3ce-4baa-b4d7-f8da9a840a3f@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b914abf-b3ce-4baa-b4d7-f8da9a840a3f@stanley.mountain>
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: d30b894f-0ee0-46de-d4e4-08dcf4fcce01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4JzKHZHoTRK4gQDdt2owh1ztd1FTq8tLBGAi4rfVTJoeqTI3mRZHJh6SGMI?=
 =?us-ascii?Q?pxKCzKGBMIbUIJw5req1Rvs7Gxh19VmUJlYu3cVUrdkR5kdA4SmmecD1fCO4?=
 =?us-ascii?Q?tE0dpmGJlqP+/7OEJBbfAnK734GoLkaSX6fxlF8YBPPTFqoc+8pbuoeKhxby?=
 =?us-ascii?Q?1wJ7167JfbmQSNYvs0Rh68hNpzIvDGDuGlkgBeN+MfHxFH6JTqPp/jWzqw0X?=
 =?us-ascii?Q?RnHcosTIkQ7C9ZmgUGyHmA0U4ziuXZRlSyeIJp5aSaK62qHkqnjqEFS//htP?=
 =?us-ascii?Q?KUOec1jzTNcIG7ZefElhb7t+9OVMc7DKpqK4jaYEilFgVkKKM9X5sVOO1dkV?=
 =?us-ascii?Q?uPm4GDOrk9jHQkx+OF79IMzwj+O0UCrbLRvHxpQdxZZsOtLxu65Q9jR7kT6x?=
 =?us-ascii?Q?ucwY4SeqEZlhNBXc+DLCdKXvl7/Pwtf8yr/Au3XWVuJZ5h2+7XasuCo4n5EG?=
 =?us-ascii?Q?ZolwlB+n5ppaEupn3YPiMQZC9h+eRINbIr2Y4DVnm5feSIqDCCancahEBeY1?=
 =?us-ascii?Q?uF/XsTcHQHbVuIL6F14rmKmzeZ1p6PYsIaZU5lHwR2KnqSQUKGoXR+JCFsoP?=
 =?us-ascii?Q?SM7eGwSFy90Cfr7BCQdoo98gKLqkL/slosxJ9aB20ikPO8/Q+qToof0OzSWZ?=
 =?us-ascii?Q?I/x6VoPg9NGLZcbWe0J3k65koSHHS0HOUjURMJIhJ8a2k4mJbf6/wGR4OxHC?=
 =?us-ascii?Q?7a2nrQPONZM7sNpA60JPPMZm3DWVO9yBu0m3p0npxKKqP04Q6GtGer+QFPxT?=
 =?us-ascii?Q?bdJ3IGAsyGDu551PCMYnK6a+6xq63Duk/vNkLTWg2uA9nRvfU48XMv+GDWcI?=
 =?us-ascii?Q?d1q0aMqykE3NGhrn8qnKBgbrYd7HMrbl6djBgS3gMDkrRD8qFf/MYdijbL2Y?=
 =?us-ascii?Q?hpUjyA0k79hR/veLHt0q4iz4YRJpUlyJeqykpP28QMjGAOdKvPgEaass5lN2?=
 =?us-ascii?Q?kkww3DGbD1INtCm+SaDkoOF0R2VvxS9BKehkvg0bJG66ePwFAFRcSm8//kiX?=
 =?us-ascii?Q?BynqpZpEJgU2XC65/XrZkdqeU8cnTYpDG0Ye2sBwBLB9gfJEhhM1TYFTF1zu?=
 =?us-ascii?Q?W49NfQDYx/zkARZSJT1IVSnHPrWrzcraXBBDma6binJLd8mCDO7s+aDNNU2A?=
 =?us-ascii?Q?OVtr9bdQfA2cVz4EX/u4o454UUhPKBLlmPmuaEUzpyNSSWZy2smHHvgT2C3x?=
 =?us-ascii?Q?gtEFi2EKyP3eFFqEY2qafu88SHCtmvyOOtS13njZUYvJarSpBmsOCnObmJ+l?=
 =?us-ascii?Q?x3dmfcFk5RO6Pl9/THyV+OVjnYhVw9g1t7nVOPvg4VOYxLqJfYBcpQ/1iFFZ?=
 =?us-ascii?Q?VVJ5ufEAzvWmuHxIMiHaDtlg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1guw+0QVcT63xUdKUc1Ci8p7cqKbmksZncng45XfvRolSqCTFqwsBbPORWs?=
 =?us-ascii?Q?vZIknd07EuanlBkY4EBEE+qyNCv7ckwRyzsseGjx9xxUQ/N5pgZO+taGQSKA?=
 =?us-ascii?Q?jlwbC9ZVgC25kiBd++3CYlW5Lu6wJ3Ta6Ghmym6s72+3qIo4IBcMqmFsmBfU?=
 =?us-ascii?Q?ii6bpCPpqaARmKTT0mT4OSAF0EHF/9laKRjyvozPWdlh57y4AzZ88tfPTLWK?=
 =?us-ascii?Q?Cwx1paSbdpbCdF+Ef1KXxkUOOxgKAX/PHbQouRzoN7tA926R58EdIRIY91OY?=
 =?us-ascii?Q?66s1utA/5cspSSU3RENGgRjbE7QAXe53nkmHcBKSzr20YM7Y6avYEQMqkeSl?=
 =?us-ascii?Q?G+37JCfBGz8nAdF9qLst/E3qcvN7xpPpSyRk7arwtRLHzMgfemwi0Q+D5zcy?=
 =?us-ascii?Q?JaT3oSBrHqx9Cu/B6D6PWRQFVQloO3x1diMcfuqI9qseklabAwlC3xtW+ZOi?=
 =?us-ascii?Q?YZL94n4FWgBVOO0qyEdFesGhgOgLs+S37w+FekDP3nWLQNVOkmglvGzPFvcr?=
 =?us-ascii?Q?3OB69mWMf1GiV4ycEMz31VZYj8UXiBHOgepFlytCqEAd4GUZqJdSKxb6GH4R?=
 =?us-ascii?Q?iRc0BVYLX1ofGcJjWCY/F2yWcyF92rgsJINbJ3km60jVkgA9rta3MpA198Z6?=
 =?us-ascii?Q?DOyp/TiLlJgUTRnpNqZnFOQbFqsDVjAGGydGX+52jL8jk1B2QiqF+1N39vTa?=
 =?us-ascii?Q?S4yHKA5rsDf1Kkm6jxaBQsu5TLACso2wCOspNXJt15MfWmULncg+AM+LQSdj?=
 =?us-ascii?Q?OHS2kGHBn0sQTCWb/1u4tjfB/Im0hZKDo60NBMX6TzBg+TtMB3wYR6tva/ZA?=
 =?us-ascii?Q?L9c0jrnwHnscefbtbGr0Gy+8bgQ+hsvkw/v/vxDZcsfX30FMhS4Q09veIqdh?=
 =?us-ascii?Q?YWMqHPVwN7ueG97XaJrolGeZY0dr9lgNsdqcE2uM17IqgGgsuhQyphRhfDOM?=
 =?us-ascii?Q?Abk4NTHkIlCwMsGSFK2T+ZscpM+g1K1+CqviErDbYy/YEs7JQkg9x/itYm+N?=
 =?us-ascii?Q?BRsexQhxH/3Dl3NKct9xbH/Oi3fzauRaR6AfWqKFDE104aLDPVh8PeNR0Pa2?=
 =?us-ascii?Q?4V3saH2RqEZpfpskaje0aBw011PmVfg4UbrPA+4R/U0I4nzWG8PnNvB2woCS?=
 =?us-ascii?Q?5QZpHlkinLKXvC9v6gftz/p7ddPenfhh5UMSotKmnfvPgEv+TG704AT7oWWZ?=
 =?us-ascii?Q?y4y2iYa/fBaQHvI342DLphmKrhgjFjzfYSJpGboJIB+/vtPaGQvqYWV32R3n?=
 =?us-ascii?Q?vutrTUO4/njgB4MlprVK0XhIjBGysvaL/N+17fEYR8EcMLN1TLSJUqPHjPTX?=
 =?us-ascii?Q?BeXG8Yb+sXD2bUXEfMgn+X4E9AFbdP+pb/ocKGvnD4UB6EBqewyINEpsHVF2?=
 =?us-ascii?Q?p9u9Bx8GtcZWaLS+9J/v6Vgney/9P9/OIFFhyvRdOfuToNnvQdNJPD1/ZZmd?=
 =?us-ascii?Q?9ww/Mz7OG7tw9OKiJ2HjWLsxAJWnpInxJEu/PfkCdvn2Lb94ZwxGClH2hAIT?=
 =?us-ascii?Q?hIrjKrSWbekC+L334juCbbwuaD6ehQbekD+2g7X/+XFojeNs7c4P3V4Hdl3A?=
 =?us-ascii?Q?csmn/5opvIbpOTTrZXc3GvZeU7Hvvui3xKKxDFJY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b894f-0ee0-46de-d4e4-08dcf4fcce01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:56:20.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfzCYqvgWJQ9yJ+lBoEBOxhYG8TMWqqFZ3F0ZLlnXufjb/RVj92BQhiWQCXS5Lb9NQhUycWcLtk3f3csLi6/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

On Fri, Oct 25, 2024 at 10:08:34AM +0300, Dan Carpenter wrote:
> Debugfs functions don't return NULL, they return error pointers.  Debugfs
> functions are slightly unusual because they're not supposed to be checked
> for errors in the normal case.  Delete these checks.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/ras/amd/fmpm.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 90de737fbc90..3cde1fe17a7a 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -956,12 +956,7 @@ static void setup_debugfs(void)
>  		return;
>  
>  	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
> -	if (!fmpm_dfs_dir)
> -		return;
> -
>  	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
> -	if (!fmpm_dfs_entries)
> -		debugfs_remove(fmpm_dfs_dir);
>  }
>  
>  static const struct x86_cpu_id fmpm_cpuids[] = {
> -- 

Seems like we had the same idea. :)

https://lore.kernel.org/r/20241024155503.GA965@yaz-khff2.amd.com

Thanks,
Yazen

