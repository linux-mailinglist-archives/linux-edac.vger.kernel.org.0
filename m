Return-Path: <linux-edac+bounces-4779-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33DB51AFE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825931886F02
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71D242D7F;
	Wed, 10 Sep 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/PLYmMZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7123DEB6;
	Wed, 10 Sep 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516742; cv=fail; b=lPt9JSu+vznS4mN7X2ES7sPKo7rZaNchTZSLjIkLMgFOLnoHOw4JKOzSgGbdLs77tpj6OXU+QwLyktu5i7Ifxob0MEJ67NgbdHUXceRUG3wkB9XVIctAma7NnmztivWvoJjYv350aPuQoPPYZ9PgxMcYXzp6UkqWuSjSpr1ldo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516742; c=relaxed/simple;
	bh=2gBgaflenxeYWIdb2wLMpIGUu1SI8GjuWcK0YmRr4KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qla2ITGlp4I51WHu2LxHXy4Fy//l2Pi23VqQJqAql5f5POZYzI97CPVS9vdb2QeWSlWPq7/1WsVqrqj2LhvrcLvnJg4YAYXY5sga3hh4MJmHn4gUIivA97wNiy++3IVMC5tVEB2vROQdpflQqmchQTRB1Q6AF4mEGQ8eswhyjxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/PLYmMZ; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leFlI/aJU8A3Ts+fXvxv1/Ur5vs8KgbABS0xMIkbwtXd1pPYnjiqAs3Va8ocH/sxyO8b9KoBnp2fOelDGoOO58PtSC8M4uLmrYQRAMcSEjQcOD1m2H7HfybKab0GVkeZOVWEXyo5GIy4EtgAoDxxS9n0wd6oYw4sD90JN13qiK9ZJGhxPSdHLypRbYtN2IOkNYMg7mR2zKsSa1Vq56IafJwKBLEHA53qmWA71YP3KxNWwHSzhgi2kKa9S88lCCAtYIlPyoVnc0hwe0J9SX/AgZtgLmpfenJcnT3pgk1S7UDgarUWN/JuYp97ctGuXjdeqeHFz9xK50BBmwI/sWo7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72LoLQurnQTbpPBOp6zimiFxDL20pReRwFj+yCXaWVA=;
 b=xDT/VAvqbxY/w47U4xyW3nfrIiXvPzre8re9s52ZCJTJQF2nicVqK1shQzXXSgfj5qUlMuNcqW3B2h2MTp+GLrY0l1zuUPoGJa1YG4fgTnl/rYa+933fxSBoXtoZ2AGmLbpzry1pJQ8+MgVmnTjL3XoKfHjbAJj8qE/1UIgu779gP9ize6fctNuMqpW4rMrINDS50cKAzT2DjsnY6YkJ+siFbvHmVTY58ua4Hdit4NDXzGjVXJojlhZTid96Cg26tnJoePI8Lg3ejV5HyFtFkKFDycPN6wGXevOaZQOmI++q23IqLNRFFigKG3yDug+MlWGyz7NDy+3ul8O1dU2k+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72LoLQurnQTbpPBOp6zimiFxDL20pReRwFj+yCXaWVA=;
 b=b/PLYmMZRfO0FOB3sw5DsD29J65w5KaF5J+DWfunFTCOcdTnLjoLCwcY8IkWsatYwk5zzltbfgEUj6roIq2D2GeEw9dTH3LTPJfFfU8r2PTtvupYGd5CjG5pjLBxRgo33aC60wBV7gBZoYMcEl5RC5aUNdRsKuwdaqd023uK0VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 10 Sep
 2025 15:05:37 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:05:35 +0000
Date: Wed, 10 Sep 2025 11:05:25 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] EDAC/amd64: Remove NUM_CONTROLLERS macro
Message-ID: <20250910150525.GE11602@yaz-khff2.amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-3-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909185748.1621098-3-avadhut.naik@amd.com>
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: c50f7ee0-8c70-4789-3bec-08ddf07b7e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MG9mIoBh8+KW1mJaNYSk3IK9dRoIhsvYdGaltIFDlSUPkg5LZlCqukwJgbmo?=
 =?us-ascii?Q?VDSZaBs/WMC/de0xbqM0aDWhypjdLkmLqgmVgl7ntERmfM/O6tpfOU4aNpKQ?=
 =?us-ascii?Q?5XwDxx2SMkOvfFufWzGp3gM+8G+FNXhU8EXjVqxgjcYomT2MTqjwoo2JNWhx?=
 =?us-ascii?Q?kcYFaGZPpPlSBXeczcclzUXKTvXfeut+lyseIj5y2gOsuSS6BTQDz9j7FKLi?=
 =?us-ascii?Q?gdRD0UV4QpZ0ki/cG8slUJgbWOM+4f7rpfkD+EQ0kf1Jak5RerUZcpOEQG4n?=
 =?us-ascii?Q?QFZOzeFIQzGsPbK3TT8Kc/IDCJROK/M6OmJ2TEb7AAOfLY9b3c9sznJQUUmP?=
 =?us-ascii?Q?YqF0U5iQ8p2U/NgqPuPOunq5yb+ofzxymphKurfOnfzNUVo2+4kIbCLXM0no?=
 =?us-ascii?Q?suYSKzxiq/+/by2kfVDterAwHrdPwtZ8gUpl5MGKjAAdhC67DrD9wEbPcOvp?=
 =?us-ascii?Q?ljbv5i9KUAWNksVlH7BqLiNvR1OkMOKMroAoD21N5kR7H/saJvXM/5rHEnj0?=
 =?us-ascii?Q?PJL4Q/07GKKPwWAuNObb40n+ZT6DZHJ3FGAe4FYvN9Y8RAP7noLYO3dYtKI6?=
 =?us-ascii?Q?gABkuo5wdP/WEdi1XyKubwLywHivq+ymvZK05oVcAWuVGlMPH0fg6U9iX07i?=
 =?us-ascii?Q?QnBxvJGD+K0WqV0rsTWWcVVd0d/bEcZxH1m3yCcFc+50sR9/aq1J2//XaVXH?=
 =?us-ascii?Q?zJtwcYbX4ZgZkmeisyDjwVKeJsqqK9mYmgMVqC2QtNQOKTfTKoh+EY00v6a8?=
 =?us-ascii?Q?nyEnPuoAK/ep7nR3q7l5mbDQfcpKGGP9qbNZtHBtfoLv7NRV4umfrkAZFXzc?=
 =?us-ascii?Q?kyvKxp0XhfS502j90nnVzJdeFLA8hjnC8B9h4b8BbuogHXYTBeN+kBAvMx5h?=
 =?us-ascii?Q?NUEeVJ3dshx4ahdGd3r3v6k6DAwM27ibei4/taXUwUOz3LVu6p7zholtaetQ?=
 =?us-ascii?Q?vGRORMITM1I531hJVTH+qJcnQCcj1VyN1cW5dEuEoCAYvO8KTusINHjIScS0?=
 =?us-ascii?Q?keDZ17CbmrmaXkBC3xj84obacUlP3GTGhbPIQ4VjUj2ubR5LNcTRq+cnlBRD?=
 =?us-ascii?Q?8/Vuf/vOMV8wL23/9v6g5OPhcGIxL4V3WwVX/7I2CaLhgmYblrYT8IjH/5oi?=
 =?us-ascii?Q?ZJ64N/1p4GOLg29hyZCQbnt0R+X7qlwX9O9UQT/EZp/oRE8Z+/5AmRun+X86?=
 =?us-ascii?Q?Cdf2Y2PBSiQTDibY9Yyl+MRif5nLS3YDptO2ecOd+fdSMJkDxpl4aUc3Ig9d?=
 =?us-ascii?Q?PpZ6UzFwz9qf5zNZ6YeP4ASYDG78JHcxFVH8TCLoJItlas0VL/zgvhbn1xvX?=
 =?us-ascii?Q?IBSiIeHnwPrvnPcaEtTqeeKlnLEGbByyqJxKKG5yP4aaMHsKzQvmNLc2qX5y?=
 =?us-ascii?Q?4LkgTjrT8QuKMjVRl3M981aXRdTUvzaKqghV9/k98Gz0oRseV+0M9rXqQPil?=
 =?us-ascii?Q?EkKzEH8FJM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORtxnrtXa/I/3I3oy5z8of3AK32fBqEK4kCow43M5ntMRsWKnSKF5c4R+EA+?=
 =?us-ascii?Q?zBQceCfVL+51DX9iC0nWNPdz5HK5UO1v6NhqxLrEIa3lea9ACvSGCyLgYMkN?=
 =?us-ascii?Q?LY+KJC9pX30NaU7xJ7vUoryb9CALmsvGP6UgoN89yze/8nuEiqoPBx2xkFyr?=
 =?us-ascii?Q?+qMcyqqS++nUrCgfdJw1qkrhqNwc0NCEvA0Za6osAKs5GxiEnZ6ICvidVKBJ?=
 =?us-ascii?Q?PcDAp/BYgebxCdoJQPnPswrIT3kiHP46If/FbZ3mqEACNkHlDyxyi4eWquvO?=
 =?us-ascii?Q?ublES2/62TiyYaITyGGb4mJg0mRVROQxxnDI1wCaVg7OUzOjGCq+JDKONGUG?=
 =?us-ascii?Q?eK54Qkq0qsP0c52YjNLOrnKta8UntJKed3aA3sn2fAxPQDpyr0qiFSGJ7+kn?=
 =?us-ascii?Q?6/DI5eq0AXIf8ORCBVy4sZbVDCwUkN28DAFDYQ+wq1M/6OBMJpsgTkw1dL7N?=
 =?us-ascii?Q?yj1VsVKqHMFgrxTW7EPU3L9wQ8OCMiiHyFAgNkog5GcGWkqXh4is2u3zHT27?=
 =?us-ascii?Q?/eWjqBBV63OD48hSBHpeFBDuA6KLARONvw8qOhAXGQPfznt/tkHI/XkrhOou?=
 =?us-ascii?Q?wbYA2FQrJljemy5Zk4avMg4GaBCn+eNgdsFMu9lZfGYogVh97U8sUNs1u0K1?=
 =?us-ascii?Q?wkG5Xbr7od+bSpHamUjNeU+3BGR2RCX3cJ33GjuTHqRdA0+fQLmcsQETLcp8?=
 =?us-ascii?Q?4cmT0kFLOM8PSgmvubC2i4EtjR6Tkv6yxanlSn8jetwcQcLaeo6MMepF9vIp?=
 =?us-ascii?Q?B+phOQe+fqBuS7VkCKFpBaoFgqa531HknC4ZO1BzXysYbUbfho6++vPOiM6Y?=
 =?us-ascii?Q?qp9XcBBjb2cHB8ZItkQtwkIdt5BcZRayDrg/EzrHBnSOmE1H8/3439H6GUst?=
 =?us-ascii?Q?JMv3FM/KNUuQE5YgCFZiTwBFcM1quVehW9/cA/MPC6EnTlhnatREq52Erp03?=
 =?us-ascii?Q?KOl0jZUV/ctImJd2IVZTJiyYmwb0r0thjstKG4gjHzljvVX8w5E5uvi1AOgv?=
 =?us-ascii?Q?FlcnkVYcF5WnWVOwwMjJUOnH574HkgRVyNdNbtAcyz2Pj+MYs6k2zfQuhCCf?=
 =?us-ascii?Q?XEyJbZUGPlxsO/PBtjfQr8Rg+u5rJyZx5vJvqUjGuQlLrWUgDp7PAjdoYdwS?=
 =?us-ascii?Q?MH1kSxDe0PFgOYSeU5lcHXhRbQiMUqFaMAxz8UNbbLn+a9dEAK3cK/K8qGqw?=
 =?us-ascii?Q?wEAAR5SWN/FzLWhXANCoSWy9gbKJDUwCAsG4hFha1rbIdqXMEiGm0TBW/4Ak?=
 =?us-ascii?Q?OLlCpMcnSVlBiFpFQhpxYCd8zKTcIx9LPvaN8X22QNGwPr5Mh/wHooUt9EZW?=
 =?us-ascii?Q?nTtPnJWvr2OwIwrPrW/xUUrbBGo3czM6mnmbcgl10K/97YwMD3BxfRdItJ3U?=
 =?us-ascii?Q?q9tHSi/PYZjgYSUrYbaXyu1DiAnIiuDjLFNFFKdmUNwmAIdt9tTCVZn+YqB+?=
 =?us-ascii?Q?LfxMNBC20rDix6HJpwlHd2OkKmWmSZxCbWqHrcPGkpotc2wiZK7vGxZaDNQz?=
 =?us-ascii?Q?x1asWFBauLmjp+AR3vM5OhMvQaIV+AOwL0uHF1ZBhUsQV76QrcuZ+SmvelW/?=
 =?us-ascii?Q?XpoTFmZE2uq3sJxixz7GAhJfChaciADj9JNVh1qg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50f7ee0-8c70-4789-3bec-08ddf07b7e58
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:05:34.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrmgBUbVxHoS/j/8K52Ztyhkon2uGycGMNVULV78hN0C3xgY9aGmtMuX1/OVTp0ki11AHxDvBXD1WjcXkEzC/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113

On Tue, Sep 09, 2025 at 06:53:11PM +0000, Avadhut Naik wrote:
> Currently, the NUM_CONTROLLERS macro is only used to statically allocate
> the csels array of struct chip_select in struct amd64_pvt.
> 
> The size of this array, however, will never exceed the number of UMCs on
> the SOC. Since, max_mcs variable in struct amd64_pvt already stores the
> number of UMCs on the SOC, the macro can be removed and the static array
> can be dynamically allocated instead.

You should note that max_mcs and the csels array are also used in legacy
systems with 'DCTs'.

Those had a max of 2 controllers which we already set in
per_family_init() as the global default. So the legacy systems are
covered by this change too.

Without noting this, it seems like that case may be overlooked.

> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v3:
> Patch introduced.
> ---
>  drivers/edac/amd64_edac.c | 19 +++++++++++++------
>  drivers/edac/amd64_edac.h |  5 ++---
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 3989794e4f29..0fade110c3fb 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -4000,30 +4000,34 @@ static int probe_one_instance(unsigned int nid)
>  	if (ret < 0)
>  		goto err_enable;
>  
> +	pvt->csels = kcalloc(pvt->max_mcs, sizeof(*pvt->csels), GFP_KERNEL);
> +	if (!pvt->csels)
> +		goto err_enable;
> +

You can move this allocation to the end of per_family_init(). That's
where we determine 'max_mcs'.

If you do so, then the 'goto' changes below are not needed.

Another option is to put it in hw_info_get() like we do for UMCs. But
that means adding the allocation to three different helper functions
rather than just the one with per_family_init().

>  	ret = pvt->ops->hw_info_get(pvt);
>  	if (ret < 0)
> -		goto err_enable;
> +		goto err_csels;
>  
>  	ret = 0;
>  	if (!instance_has_memory(pvt)) {
>  		amd64_info("Node %d: No DIMMs detected.\n", nid);
> -		goto err_enable;
> +		goto err_csels;
>  	}
>  
>  	if (!pvt->ops->ecc_enabled(pvt)) {
>  		ret = -ENODEV;
>  
>  		if (!ecc_enable_override)
> -			goto err_enable;
> +			goto err_csels;
>  
>  		if (boot_cpu_data.x86 >= 0x17) {
>  			amd64_warn("Forcing ECC on is not recommended on newer systems. Please enable ECC in BIOS.");
> -			goto err_enable;
> +			goto err_csels;
>  		} else
>  			amd64_warn("Forcing ECC on!\n");
>  
>  		if (!enable_ecc_error_reporting(s, nid, F3))
> -			goto err_enable;
> +			goto err_csels;
>  	}
>  
>  	ret = init_one_instance(pvt);
> @@ -4033,7 +4037,7 @@ static int probe_one_instance(unsigned int nid)
>  		if (boot_cpu_data.x86 < 0x17)
>  			restore_ecc_error_reporting(s, nid, F3);
>  
> -		goto err_enable;
> +		goto err_csels;
>  	}
>  
>  	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
> @@ -4043,6 +4047,8 @@ static int probe_one_instance(unsigned int nid)
>  
>  	return ret;
>  
> +err_csels:
> +	kfree(pvt->csels);

This can go in hw_info_put(). We have kfree(pvt->umc) there already.

>  err_enable:
>  	hw_info_put(pvt);
>  	kfree(pvt);
> @@ -4077,6 +4083,7 @@ static void remove_one_instance(unsigned int nid)
>  	/* Free the EDAC CORE resources */
>  	mci->pvt_info = NULL;
>  
> +	kfree(pvt->csels);
>  	hw_info_put(pvt);
>  	kfree(pvt);
>  	edac_mc_free(mci);
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 56999ed3ae56..39d30255c767 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -96,7 +96,6 @@
>  /* Hardware limit on ChipSelect rows per MC and processors per system */
>  #define NUM_CHIPSELECTS			8
>  #define DRAM_RANGES			8
> -#define NUM_CONTROLLERS			12
>  
>  #define ON true
>  #define OFF false
> @@ -347,8 +346,8 @@ struct amd64_pvt {
>  	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
>  	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
>  
> -	/* one for each DCT/UMC */
> -	struct chip_select csels[NUM_CONTROLLERS];
> +	/* Allocate one for each DCT/UMC */
> +	struct chip_select *csels;
>  
>  	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
>  	struct dram_range ranges[DRAM_RANGES];
> -- 

Thanks,
Yazen

