Return-Path: <linux-edac+bounces-4778-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C50B51ABE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1111C225D3
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242B8327A21;
	Wed, 10 Sep 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5OEwlGiC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E62638AF;
	Wed, 10 Sep 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515885; cv=fail; b=jz2gKhANMYMh+shsgOgiO6r0WvTRuWOTSFD1WhQGjB2Nm14bY1FJ1E2l2DoebetJOGpe2p6ww5A93gvGupB/kVG9S8KBBSFiM62UrhsiioHX5O5pGxyDCrXTY+/DROHJg4lif/K0g0pMvyBn+OEYrn0mwhL5ibgX9HFxYv/u0Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515885; c=relaxed/simple;
	bh=icZHbojhGFDqqZaOIQE1hPbckx7UUMgSxZpzbm45R4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6x8AFYHiqwl0DbkFCzu4AuFvOHSZRK5ZAQy70kZqYtqvPojoIooodPXLsMGUtFjdwMLnMmpaBHJuuvXNfugUI9R7njv3HrkdH/8fUskcyGz8VANh5bn5FIDf3KJ6G+DcPd/Hmfwa0iNy4M4CC0D+x38JB9QK7v1aen4b5TFaeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5OEwlGiC; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXaKPxYw3rLGp9Ac9YMsm3o/jRZrTxGFyWU+dSoqWETa8qod/DhtlSxgX1gTl8VZOP+E0zA4c6eHLvhRp0/5u6PmOmOeNzIMPLP/Kr5uqkXOoJAt7TDlbLf5hKfLwdSAVYvjyaCSNouUU986DSMyLIArOVbrHBX52rvJTvBJ64tk+cGmBMouSU3sdjIQtkZ5rZuumBPZMQ5QVAPrSs1C4Hpaqic/TPa+Hlh2vW5mWYjU0AeWGVULlmTTET12vuAdErlUbIrm/oGgtmg2P8JivI0jLGQIah/eBN/QHlArkJPgvoazqj5JEPat1BeuFngHwMSstDNFZMqlLB//DNHJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2SOr3NKWDK0o+VuaTHpIqeFwfva3iVd6fqfKbs84R8=;
 b=YvU952xye01JcDwqxjus4wPA+jG2b/f+C9MW4zlOPViG7q+ez2YHPK1yqKoJ9liYwTztjLRP4trUU+Li55vp/Up/bFbdnN5RVM0WjSekRh33SkIKJ3TEfOn+OLmefvyhKzC6IPbm7kAQqwl3e+KeAVtXi8ih1JGSceQ5S2yKrhK6uFqDW/LiWDL06V4qZqoyAeWme2yqjMqqJ0AfbsV1NToyxyApgYwXxaq20MLT4XKJ7IF+1Rur9v4a6oZgVtNE9cyO6uJYBbpojEOIM26nYDWKDznE3pPuv87jl67Sb0DSoJIgAZYzIig3w7ETRTX5cbXgU9QDk49x5yniA+E3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2SOr3NKWDK0o+VuaTHpIqeFwfva3iVd6fqfKbs84R8=;
 b=5OEwlGiCpdgmO8GNUBAMEAWwSpHhzTFs0AGT/EYBdXEMebcapWdPMbpH+LY8C22j3+D/SlYXyWj5/hbyKHb24iragAavU5O4CNsArqXd6hzGjYxOizCazmO11nJzd9fyqR/wfjulr7dJFlHJ90e4fMxR+EVXWzqYifDxtAlTwKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:51:20 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:51:20 +0000
Date: Wed, 10 Sep 2025 10:51:08 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] EDAC/amd64: Generate ctl_name string at runtime
Message-ID: <20250910145108.GD11602@yaz-khff2.amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-2-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909185748.1621098-2-avadhut.naik@amd.com>
X-ClientProxiedBy: BN0PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:408:ec::32) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3bd03e-b460-4944-714e-08ddf0798002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aOUQ+jZ7Kc7FEYT5Z7WyIET8lXFzFV5iHnUG+m8IGdHCrFEQSgv5MBZYf/TZ?=
 =?us-ascii?Q?4LVgCKAXmwH1oOafYYfVjop6krXcWwtsp4ONgv/hQ86RsKsDzrs0rPOa5gNM?=
 =?us-ascii?Q?opjLbRZHrVmL5x5fDMgZS92zOjBT91ePW6C7OhIAQdelBs6v3BXUXciwhyTz?=
 =?us-ascii?Q?1jset5zTzNl9g9ZIhFEIqzlgox+ChZ1/OuOMqg0O61tWevhWe2wSEaBNrLZX?=
 =?us-ascii?Q?sUGhMBpk3rcHuZApovwo6yEYfE7BTGzVoLqi4Wksvmv7Jdvx8ep5gwdgHiXV?=
 =?us-ascii?Q?87kdBUEfSPQDjXCu/1UKSzIi0bHrl5CebWoZ97QPviiCD7nVq/37WzbWExkl?=
 =?us-ascii?Q?qVA26I8AXJizvBuJuUii4Q39nip1Yof+1n44Ot+MWPNorbp5Bt4d4ozKsmWZ?=
 =?us-ascii?Q?cwNsvGXg2B42lKikP9V0WFo3y6J7wWAslbmssVs+CVAlvZNWOrhW5ZB7oNNN?=
 =?us-ascii?Q?QTiSqSQobO89XFap+/SxN9gOx6ZEAjDC5wN8kOJAJVNtUYmaFZHEVOeeJFwr?=
 =?us-ascii?Q?wXxkywRy14vQM2p91zrHc7c2q1OJ9m29T8wzMqODFAgBU/o4VQQ8FyALwzrm?=
 =?us-ascii?Q?b248ogdfEV2Hg27nxB+GcDYcp7vrG5lTVViCvucKjeNKjnExKhqo2W6lwzfP?=
 =?us-ascii?Q?WzNbEKrLv0VJ1bkhBNiRZgtk2CFqU4EO5ipfaFXpQXP2p53Ms4JYkVI2mIFz?=
 =?us-ascii?Q?AwYVk81hbcY1CiEMAVFgxdEajwCdbv3qxJixidAHGLn86FiJydZCah/omtK9?=
 =?us-ascii?Q?GMg/5RYtEYUnnA1JchtkZv9BHsuFMbreS+EamLs+OG5FlL4FfnTrG3JKPTpd?=
 =?us-ascii?Q?wuKtC1qA3T3p2c5ONIv/zmmNfDO4xK53Wporo1NZyE/OQkWkR97wfUNoVtsj?=
 =?us-ascii?Q?IF3ZJ/5n5czfBggfySMTiHTNULjWnXJG+ly7Ae94weYOM8766yBX8b7/L5OC?=
 =?us-ascii?Q?Qmx4/7SIozai+R8YBUAGg+yxSHi4e43alr1vkFemtQHCzMIyozLjKAsPMiDO?=
 =?us-ascii?Q?aVRlY9VW081ta5pDWkA2P/kCvm2VkM/3AowybwHvJUoKx0nGNtutpIfu7a/k?=
 =?us-ascii?Q?rfziwbxLp/uIXZ4lZ7MnykhNJQ445gypbxV3aoOweFeSDNGwk98ez87ZKR2d?=
 =?us-ascii?Q?ZgERqunZBqeNP5difXW2VjqfdYnDZXNlOu81WtBV74yD2Oab0kb7mRU2yT82?=
 =?us-ascii?Q?KHhZ4Vqc11KZWGRP/cnyDZMyI4HkPcZp7FNX3RSX8h+zVMPxQZw27QBnbLPJ?=
 =?us-ascii?Q?+a/noUCey9kD5EJLt4rWvjag384QwiDFGeWTuM08eBuwl+dohku+y/87E3/q?=
 =?us-ascii?Q?5neTb3B4DnGcjYHLYM/C0BzuW8e8+oXvAS7pMqAuHQP3d/DWhSIFzJPd2Ru6?=
 =?us-ascii?Q?UXovCaLvwE/AXl/ITNjicmNK1C3cQa0P54+bNjmjQOmK4YDqRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pHIGeBfPVlJt31UcU0Xbv0ERtOe7eHpgQ4PYX0TyH6HxuXJYS6YlP24Fj9d5?=
 =?us-ascii?Q?UG3e1Hdrv34F2AMHkAZhDkQfrS5XkZBS2KFYTWuOZpOq/Qa07rMaxamrKH7z?=
 =?us-ascii?Q?bTHNabyGwhpQ0JcNGERI7tM3wBjF6qovbE71cFZdW9UhYPe8Q3ADHQ3B0Jl4?=
 =?us-ascii?Q?i/rrOh1PYbZh7kb7tNI+EDXpu0w1R7okXVQuQNEO8sk87A5ejzcByatidJ/Y?=
 =?us-ascii?Q?jw0ZFDH/lI1Dlw+jl9dZS4+0isE7Vv9iHGUnEPUpqk77e9bQ+GAgG98t6r/u?=
 =?us-ascii?Q?g3N87EXDi80j40OfpU7TAJ6SMGc+HBlXklJsd65kts/fEeuwTeuT1Re9TXzH?=
 =?us-ascii?Q?CCKOihzt7B1hBREnOWdpqSB0kkOJCgexhNWYPZbpV/1Y6VC6hH80uD7uT6in?=
 =?us-ascii?Q?ztfkW9eO8EPir4xMZl2Mrl7KZsDlV5m8SR23HSn5NSF2cGzEDVn0CuuUmnyr?=
 =?us-ascii?Q?59c+SOog498VQ//ddc5KL3P5vntYqlTd76EA8oYIKH+WqqRX2ikbckY7ZCsK?=
 =?us-ascii?Q?+wSbaGKxCfxsRq28RqrJ2dGOVTt7n80O7Af+eVien4IYVXcYVM3K/FbW4QPN?=
 =?us-ascii?Q?Q8kjYmBc//X8JEU8CAD5yhHTVpSfSOqrIp9ICm0blR1/so2eZMeeFEZSGF6a?=
 =?us-ascii?Q?Z99sPHaBZbhejCkYufPjmjZ9Lw4ouOT78z5A6QzvCIrkIstZvpI61V1YOM0D?=
 =?us-ascii?Q?RlJ8bBEk84/2rFSris/baHAYidr9ZQ625Oi1nyuX2HDxuzo7+ezmFnwDs2JH?=
 =?us-ascii?Q?w+LeemcPRTkCSXvTjttBFirLJ4r2z9q1lwqCxueEwuQ0LrX2zc+V2f7cRt43?=
 =?us-ascii?Q?7tWG/8BPeGtHCZsafnZWF2+5yAFM+bEtjy4qgIjBMl1E4AYj+fAsiUBSqt9s?=
 =?us-ascii?Q?oeEJ/lWZB+esU6DeN/xIHtFlNsla6mwtWEb/SBrznGLtfn+4K/wNuaq6u6a7?=
 =?us-ascii?Q?eMTSzlLl6U0rfRZt06S0m5UA/uQgIjfzHjOyF0cO85KA5f4xv2gpt0AFu8zC?=
 =?us-ascii?Q?KzWIPKdbjyABsfVVuWQ2/uMRG0QKjK0wivfKmzrS0kRUc/4XzfMUaXyXPAXM?=
 =?us-ascii?Q?P0dJNYl26Cv5U93gTTw5dktSgU28H0xMMMYtycmAVBk7mBcUZaHPlUKR+LC4?=
 =?us-ascii?Q?AlM5pu7isRqnJzAYs3p2xW56qygvThFm27UNnQqNGZ1b51P3aCvC9RByK9HG?=
 =?us-ascii?Q?0uu0dXdw/sgPWm3jKjpf74kPp9IY2Eh428OG5edhnshmfVIc8fFvNhoQbynf?=
 =?us-ascii?Q?I7gRzwF8GLOb/Op0ud/LUGLr/Xyjq7QznmFYtVLQcZcdIwHcC4brRfiWSC7N?=
 =?us-ascii?Q?Aq8QInT9eWzKtIPC3hKq8KL5jc0ETp17aECencDKKRRv0qtOyV/2rMapQq1v?=
 =?us-ascii?Q?mpnw1g39OgmqTxsBu5i0p8BhS0DiNyPHfrsPfR0BMjUiXbZqnndHRpVGRQMD?=
 =?us-ascii?Q?lhiF4L3djWLvidDO6ieURajPVlYAuwKlbEh1CwyHzdxHmDItZDEbOYub8QTC?=
 =?us-ascii?Q?RDgJsqOZLU5/4YF0RzTJrZMsv4q0vAMQ0/z4eW/nWUnOUBHPKHaAXH0ntW2X?=
 =?us-ascii?Q?Tb8qhWX+B/LDLyx9J5Pq+/1486VL99pLaMtdO1J4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3bd03e-b460-4944-714e-08ddf0798002
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:51:20.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6op/EyTbzi913OSDWFwF5L2lQ4mIcNYPuptSu6HRlBBIi75Nj8B0PdOP78V5Dggpjjqc6K931IWK5/p6bqnrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

On Tue, Sep 09, 2025 at 06:53:10PM +0000, Avadhut Naik wrote:
> Currently, the ctl_name string is statically assigned based on the family
> and model of the SOC when the amd64_edac module is loaded.
> 
> The same, however, is not exactly needed as the string can be generated
> and assigned at runtime through scnprintf().
> 
> Remove all static assignments and generate the string at runtime. Also,
> cleanup the switch cases which now become defunct.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v3:
> Patch introduced.
> ---
>  drivers/edac/amd64_edac.c | 44 +++++++--------------------------------
>  drivers/edac/amd64_edac.h |  4 +++-
>  2 files changed, 11 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 07f1e9dc1ca7..3989794e4f29 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3767,6 +3767,8 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	pvt->model	= boot_cpu_data.x86_model;
>  	pvt->fam	= boot_cpu_data.x86;
>  	pvt->max_mcs	= 2;

Newline here, please.

> +	scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
> +		  pvt->fam, pvt->model);

There are a couple of special cases below.

So I think it may be better to move this part to the end...

>  
>  	/*
>  	 * Decide on which ops group to use here and do any family/model
> @@ -3779,8 +3781,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>  
>  	switch (pvt->fam) {
>  	case 0xf:
> -		pvt->ctl_name				= (pvt->ext_model >= K8_REV_F) ?
> -							  "K8 revF or later" : "K8 revE or earlier";
> +		if (pvt->ext_model >= K8_REV_F)
> +			strscpy(pvt->ctl_name, "K8 revF or later", sizeof(pvt->ctl_name));
> +		else
> +			strscpy(pvt->ctl_name, "K8 revE or earlier", sizeof(pvt->ctl_name));

Maybe save this special case to a temporary "char *name".

>  		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
>  		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
>  		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
> @@ -3788,7 +3792,6 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		break;
>  
>  	case 0x10:
> -		pvt->ctl_name				= "F10h";
>  		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
>  		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
>  		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
> @@ -3797,12 +3800,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	case 0x15:
>  		switch (pvt->model) {
>  		case 0x30:
> -			pvt->ctl_name			= "F15h_M30h";
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
>  			break;
>  		case 0x60:
> -			pvt->ctl_name			= "F15h_M60h";
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
>  			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
> @@ -3811,7 +3812,6 @@ static int per_family_init(struct amd64_pvt *pvt)
>  			/* Richland is only client */
>  			return -ENODEV;
>  		default:
> -			pvt->ctl_name			= "F15h";
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
>  			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
> @@ -3822,12 +3822,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	case 0x16:
>  		switch (pvt->model) {
>  		case 0x30:
> -			pvt->ctl_name			= "F16h_M30h";
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
>  			break;
>  		default:
> -			pvt->ctl_name			= "F16h";
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
>  			break;
> @@ -3836,76 +3834,52 @@ static int per_family_init(struct amd64_pvt *pvt)
>  
>  	case 0x17:
>  		switch (pvt->model) {
> -		case 0x10 ... 0x2f:
> -			pvt->ctl_name			= "F17h_M10h";
> -			break;
>  		case 0x30 ... 0x3f:
> -			pvt->ctl_name			= "F17h_M30h";
>  			pvt->max_mcs			= 8;
>  			break;
> -		case 0x60 ... 0x6f:
> -			pvt->ctl_name			= "F17h_M60h";
> -			break;
> -		case 0x70 ... 0x7f:
> -			pvt->ctl_name			= "F17h_M70h";
> -			break;
>  		default:
> -			pvt->ctl_name			= "F17h";
>  			break;
>  		}
>  		break;
>  
>  	case 0x18:
> -		pvt->ctl_name				= "F18h";
>  		break;
>  
>  	case 0x19:
>  		switch (pvt->model) {
>  		case 0x00 ... 0x0f:
> -			pvt->ctl_name			= "F19h";
>  			pvt->max_mcs			= 8;
>  			break;
>  		case 0x10 ... 0x1f:
> -			pvt->ctl_name			= "F19h_M10h";
>  			pvt->max_mcs			= 12;
>  			pvt->flags.zn_regs_v2		= 1;
>  			break;
> -		case 0x20 ... 0x2f:
> -			pvt->ctl_name			= "F19h_M20h";
> -			break;
>  		case 0x30 ... 0x3f:
>  			if (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) {
> -				pvt->ctl_name		= "MI200";
> +				memset(pvt->ctl_name, 0, sizeof(pvt->ctl_name));
> +				strscpy(pvt->ctl_name, "MI200", sizeof(pvt->ctl_name));

And this to a temp name too.

>  				pvt->max_mcs		= 4;
>  				pvt->dram_type		= MEM_HBM2;
>  				pvt->gpu_umc_base	= 0x50000;
>  				pvt->ops		= &gpu_ops;
>  			} else {
> -				pvt->ctl_name		= "F19h_M30h";
>  				pvt->max_mcs		= 8;
>  			}
>  			break;
> -		case 0x50 ... 0x5f:
> -			pvt->ctl_name			= "F19h_M50h";
> -			break;
>  		case 0x60 ... 0x6f:
> -			pvt->ctl_name			= "F19h_M60h";
>  			pvt->flags.zn_regs_v2		= 1;
>  			break;
>  		case 0x70 ... 0x7f:
> -			pvt->ctl_name			= "F19h_M70h";
>  			pvt->max_mcs			= 4;
>  			pvt->flags.zn_regs_v2		= 1;
>  			break;
>  		case 0x90 ... 0x9f:
> -			pvt->ctl_name			= "F19h_M90h";
>  			pvt->max_mcs			= 4;
>  			pvt->dram_type			= MEM_HBM3;
>  			pvt->gpu_umc_base		= 0x90000;
>  			pvt->ops			= &gpu_ops;
>  			break;
>  		case 0xa0 ... 0xaf:
> -			pvt->ctl_name			= "F19h_MA0h";
>  			pvt->max_mcs			= 12;
>  			pvt->flags.zn_regs_v2		= 1;
>  			break;
> @@ -3915,12 +3889,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	case 0x1A:
>  		switch (pvt->model) {
>  		case 0x00 ... 0x1f:
> -			pvt->ctl_name           = "F1Ah";
>  			pvt->max_mcs            = 12;
>  			pvt->flags.zn_regs_v2   = 1;
>  			break;
>  		case 0x40 ... 0x4f:
> -			pvt->ctl_name           = "F1Ah_M40h";
>  			pvt->flags.zn_regs_v2   = 1;
>  			break;
>  		}

...here.

Then check if the name was set already (by the special cases). If not,
then set the generic family/model name.

For example:
	char *tmp_name = NULL;

	if K8:
		if F:
			tmp_name = "K8 F";
		else:
			tmp_name = "K8 E";
	if MI200:
		tmp_name = "MI200";

	if (tmp_name)
		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
	else
		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
			  pvt->fam, pvt->model);

> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 17228d07de4c..56999ed3ae56 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -101,6 +101,8 @@
>  #define ON true
>  #define OFF false
>  
> +#define MAX_CTL_NAMELEN 20
> +
>  /*
>   * PCI-defined configuration space registers
>   */
> @@ -362,7 +364,7 @@ struct amd64_pvt {
>  	/* x4, x8, or x16 syndromes in use */
>  	u8 ecc_sym_sz;
>  
> -	const char *ctl_name;
> +	char ctl_name[MAX_CTL_NAMELEN];
>  	u16 f1_id, f2_id;
>  	/* Maximum number of memory controllers per die/node. */
>  	u8 max_mcs;
> -- 

Thanks,
Yazen

