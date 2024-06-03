Return-Path: <linux-edac+bounces-1173-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE398D8B33
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D150DB25EA7
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551D8526A;
	Mon,  3 Jun 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cd0TQvH1"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1C85656;
	Mon,  3 Jun 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448498; cv=fail; b=pyhW0pI1Ssm/6Tkba+BenpkSBeQb08afj7m7H0JQ9OlULCXeIbBZYpkx8pGBy2+TyKdrJFO6afLQXAUFuJnCOXGWDR/9Al56Td27Ggl/5xeD47yWfshzTzJhzpXRf7EsWteGnxXegiVm3WnNJyzOfgma9CQTs0vRReRb5TbSXpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448498; c=relaxed/simple;
	bh=NTUSHK5eg7Zh9Ddv42v3ENJu4Lzp3Cb9ioIXFKYtBaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Th2JsoTeVX1lCzq2BOY6qXXduuWg9CJS9HysWNbsmIMm5rFKXB6BltUxgrerPGtiSBu3q2a1aL0vKy3Md4lyzifdQmj2Hc22RPBvE99rn0guX0EaiLmUlJJgZi6DWjp44LxgoYZGVcU2g/I9wuWBRL9otazW3gk1mhPV8SCtcUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cd0TQvH1; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmuyaH9kfPlXBKAP7hDhnGs7YR+b3x7lBqaf2KSgQq1j9Ngi0veU3r98uFzNQ6zuEm8Cu7s1rrKqCrIQ8omDaTLvzu+A6ZSaTQrDAc1njKaEkw+AdUMbpiFdSxPMJfIMGgRexxE0ww2Mw7sNsxu5AOgsCFbS6L2cH7RekLjWI2yhRyc2loy83Tx8pem4ELbzQBO6PHAe8OdPmURYNAxgL5F/JruUs5DWR5eHS6MjmBCy05oRNAtOy6qeUv5WfhMG5RA/n2JXZEPR1UAXzyk7TA1pdj/6sPNQNpwv7jI0lqK5RY0lhPlQ8/EbZ1k8CquBzHWa3Od1X7j8TLZmKHQmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRopjSqlDGfy6wqz4Ng8OCzniUee8eo0h1lamDMbwe8=;
 b=Et0PPO7uTRdDHCELWbj/nNftKfMQxZSbWJxoKePRS9KWiD1/ci2Bk0w4X3qXNArhGrU22ufgTT5iQdyiJBk1F3Il+lrQbTB8heGNLJoGnCL3MoDRYNraKlGLJXk0uCkaS50TKkfvv2iYa5etz6A1LbaDmVf/qeUax8vAaBZadx1POc+IpgouSVeb4gSOoEfvXjnQR5Xk5/yCHUHhI+PIDmasrpUpwCEl0EsWb4g8H6zCJP8Jsw6O5R9rypkHh9AQ70uOrLsq2LkUKQJD1lBUYpJDS5s3EL2foNPQKshlR/3xxcAXCVLNgl+yboC+TheAOPkuQV05b/UG4vnbsha/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRopjSqlDGfy6wqz4Ng8OCzniUee8eo0h1lamDMbwe8=;
 b=Cd0TQvH1iM5O7B4wVRyRcax2NOaOgjwVeRQ8Soc4H55vaJ37k8M1Q+NG97zWHoC7BZLZoIbLUgssDOCS6GCNhWiFXyYM1lyDVz6SjxJPAqtzVUj6JxkAmg8xLTrsT46SN+qgHRX/NkQetJjup3c7kqtYkvbEyEteYVu5o5DOirk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 21:01:31 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%4]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 21:01:27 +0000
Date: Mon, 3 Jun 2024 16:01:22 -0500
From: John Allen <john.allen@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 4/4] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
Message-ID: <Zl4vIkNNzP+cKSYF@AUS-L1-JOHALLEN.amd.com>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-5-john.allen@amd.com>
 <20240528102344.GGZlWwsJzibnQfuNYW@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528102344.GGZlWwsJzibnQfuNYW@fat_crate.local>
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e4e40d-abf4-42ac-ce55-08dc84105549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHV5FOWeNtc03mJGul0JBsEggHO1jMnGpSCg/Xp4syqGSLGkOmtLDRpAZdOx?=
 =?us-ascii?Q?mMJlotW3xRfRDFY0O/x5me3KBdjZhadBgo2Ey9/pXQDObj4BcYKruObfUmOe?=
 =?us-ascii?Q?oj0EAiZh8cz+ep6WlAND8JeU1V6USrWKKU+H1fQX/boN9BT7XK1WHpL8fK47?=
 =?us-ascii?Q?ZicZmfrDiZvdN3FYE8nk0e2dkywq8nFDlqe9KWoDj8764NYZxNC4VrEy3nSk?=
 =?us-ascii?Q?hb05xINGK9miX7RavTcXu8LyqXVYrGumyAuXWVZ3XJyf+LL/l6TuSJUtrn8P?=
 =?us-ascii?Q?i5xDrEJz4llso6EeIUaFzJvVEuTmJZnjMIGO3i7SbW/dLnuNFH0c4N1NLmpG?=
 =?us-ascii?Q?nIevvZ+5mDy+mCmsF2Doh326MV16TwFwDgmMdG9ddehCRLtYgFrXm6x1/umI?=
 =?us-ascii?Q?dBYwtzCg4vyX7U8xTymAYhwzj6xirHATVMlDD/0lAncnEq2TWweNx7GKw9Sm?=
 =?us-ascii?Q?3Kdb7fZaz31RDS7IjaAXdupQAhPGHQUum4r83JMtPYCwM6NveSf690s9ZchH?=
 =?us-ascii?Q?u/iaateK3UCYUTQ7EUO2sU2ty2Av+qcmOsMsfEVfABE5fXt5q+OGb4z3A14n?=
 =?us-ascii?Q?sRNrNj5n3dXbFVpGbdDbpDzmGFk0YchubqZjYiIrK4VNdnEE02+iYrlw9/0x?=
 =?us-ascii?Q?uIA6qfligXCz53cILTYjc05S8y+JRqV3XgBvjWsflVqZzyC5XxxkAc9pFP3G?=
 =?us-ascii?Q?cHlGmVqHmMZ/atrzNJJUYejFuHGJgwNyCk6Ul4kib7cOjHpe1/093hZgKQ5h?=
 =?us-ascii?Q?j017m3v6J5LAYHAhWZk7r+Lvhed7nADpxuKO+ex65xlvLrC/zfwBBhFXLk+1?=
 =?us-ascii?Q?uDyQpa1lwa4jgDFsFJhn0y4bk8NGgLo57aFigkXYiQjEFhZLv0qLaVZLRgui?=
 =?us-ascii?Q?ZylL4/HoqsHC93jXOKYt6G+31DFUOsDoXkGtpQ7ZW5goGyk4PsFI/UZhoMc0?=
 =?us-ascii?Q?yEQewLaoo8X79GX5dJ/u8unYN9ZqP8UwE8pn1o7EAZ1HWJZFaB5R23ksPXKK?=
 =?us-ascii?Q?xVx5kUiQ4ZQYbN29MFhA+T6WxhVTuehjaVfVQiDBEqmXJdn/vB41lr/MfkHF?=
 =?us-ascii?Q?7g+/ZJY7u9HNOVl2DER2Qv6pxrbdAGIzVaHh6daK8Sla8pjt/PWuo3SHhgHZ?=
 =?us-ascii?Q?Iydyx0+/dHorZjZjFemOzSAIpMR7ZXv2DfWSPUPQVDwoBf6iV7mLK5YThpMp?=
 =?us-ascii?Q?44XQFI5mkX7hyvcIUR2fJ71gWq1GZf6/4Vk8ZLaXuNni3WG/Ui7rxonBFosR?=
 =?us-ascii?Q?NIH2c7HF1bmpLqcC2vd5hNveKfvX1a3kU/qKu+UwTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXTkJNXvrWpnOtA6HJBOePe+vcirlDSpbfIBhJkmx43+/4cZ4KWVmcfma7CH?=
 =?us-ascii?Q?R2U5BH2shS0wbq3DkVyxGubi5fhOgOQKRw0d8585YWf6jJyIClY0B/7YuqxA?=
 =?us-ascii?Q?ltrJyhHksn5QRIMhPLODfh+Y3al1xLg+BBrcJxjwdzTgKgyp50diDm+1gojW?=
 =?us-ascii?Q?/3lezSieeVlOOf7qootethqLTSDbF4V7TZlgqDUNzY1v+ja2kKM5eL12Imo9?=
 =?us-ascii?Q?JWwg8ZfC9lEvtKCI+mP5auj6WB7H0l0Mkes6l6/VVPvxdJlw5P5pqtS+jpaE?=
 =?us-ascii?Q?TadMS4o/cmwwlVIDcnxiRxDXvE+G8RRrKLusJjm6c7wbT8OPDcLlcOvUlvQc?=
 =?us-ascii?Q?RKnEukclx95PNj5UqslNXfQjvrkSeUp/fM4pfJ+9Tx3FrOy7VCPJr+YNsG24?=
 =?us-ascii?Q?CSAKVoSJigKXxpow74p5nMaAfaMTnUHRew8KLjmNe053juMjPqLKnZIFPgf9?=
 =?us-ascii?Q?V/shMwc4b0UR3Yw0xIpEApuPeB/sCOWozNAUKOMSHUEA17JuX+1zfJoesQqy?=
 =?us-ascii?Q?igIksKofdaEaw5PXqK31ophcTW2StcB5vuj9hmqUGobD/NxuAfgOh5wRxzcs?=
 =?us-ascii?Q?bDOM5UfncInw/7cpPMIlg62cM0W/NEhWE++nfTDGPGC9WEq36tuOEaYuDlR5?=
 =?us-ascii?Q?3mmTttLn1Too1XSgkQr6dkQOYRTtycSDlhEdrzI0QXnxx+O7O+jskUZuf61/?=
 =?us-ascii?Q?fen10QBgT8yttEoyYNkNxMYIzPeAtOSHn94pU7VhQQkV3yJU17JjuKV6x4jL?=
 =?us-ascii?Q?mJoZ1awpWpep7EeSv8yVxh0GaK57yFuz9P5WjDo5BwBr5R5LpJzBA8O7no63?=
 =?us-ascii?Q?8wOPVYXJ13AfyV1fTvPk75sZcAnXHMvifKfRjbcvKJdr8b9kmD3nfLznYCAS?=
 =?us-ascii?Q?12Ik1WfS952DZ+VK7UspTYy4AFyn680bVtvxSgR/hsZ6RdoY5p49cOtRvB1t?=
 =?us-ascii?Q?iOVz/iCF1gSYhPxg5rEA+RcCEus6mJaq6mV7sO3a7ow8RFY6+J16nRaYMu3g?=
 =?us-ascii?Q?kIr8Aayf2+E9OMC2Q4WMcT1oKK+IqKBve47sQBDmZbCQVlXnciuppUPH76yJ?=
 =?us-ascii?Q?hu/q54OrWTrY2q3TAKbEtPhjnrBfApjwMYjqnJRaRulCo/ZM9UIFSUWTrREp?=
 =?us-ascii?Q?YZ3N+uR9o3vewLNKHQW0j9GzOMnDwsYb9xI7cYpT6PxMXQEnw5Pl/0tRCh69?=
 =?us-ascii?Q?tO/4YkkPMFJ0GzB78HNxMX+ZZnE41+lx/hA7ggo9RGLAAVrTk99dZbEyIrHp?=
 =?us-ascii?Q?NjKPGxMEW6KvBflHGnkeuwxJ8cgvzKTImIYAxEn3t/LpXhEz8yQqNjv3fDWP?=
 =?us-ascii?Q?Rq83Yw59Wd0Og1+/xyez5tpK2GT8dm28/nNffao9d3yL9S5of+c0/V+pDbah?=
 =?us-ascii?Q?YtxhPn2CEj48YQB52l71UjqxWh8PeMalt1XYUbQW+r9y3bxWR4ezf1iePO9U?=
 =?us-ascii?Q?DAGauGvED3ZRk4d9QAWUaVBVGYKnAtZJHPr7LCZdSqTyxsyXUeGtktgrWMst?=
 =?us-ascii?Q?hH0dk0TdFftUT4bXaj8uCTu/XhCrU79kquoZ6Uigvpf0PvKLB0xEJuZMJK0R?=
 =?us-ascii?Q?3d3mWzHlPMkXuVpqkIbY+okWLyBYw5nHY0mG/hFi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e4e40d-abf4-42ac-ce55-08dc84105549
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:01:27.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgbk6fSrhdGiEMZcdriMmUxwR1kt00qIdjtkgfcoL5LI9fAUcfYimdcQ72/L/ri/NCoU5w2uXFHNZitsKAmLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

On Tue, May 28, 2024 at 12:23:44PM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 03:46:05PM +0000, John Allen wrote:
> > +	switch (ctx->map.intlv_mode) {
> > +	case DF4p5_NPS0_24CHAN_1K_HASH:
> > +		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
> > +		cs_id %= denorm_ctx->mod_value;
> > +		cs_id <<= 2;
> > +		cs_id |= (hash_pa9 | (hash_pa12 << 1));
> > +		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
> > +		break;
> 
> Newlines after those "break"s pls.
> 
> > +	case DF4p5_NPS0_24CHAN_2K_HASH:
> > +		cs_id = FIELD_GET(GENMASK_ULL(63, 14), denorm_ctx->current_spa) << 4;
> > +		cs_id %= denorm_ctx->mod_value;
> > +		cs_id <<= 2;
> > +		cs_id |= (hash_pa12 | (hash_pa13 << 1));
> > +		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
> > +		break;
> 
> ...
> 
> > +static u64 normalize_addr_df4p5_np2(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx,
> > +				    u64 addr)
> > +{
> > +	u64 temp_addr_a = 0, temp_addr_b = 0;
> > +
> > +	switch (ctx->map.intlv_mode) {
> > +	case DF4p5_NPS0_24CHAN_1K_HASH:
> > +	case DF4p5_NPS1_12CHAN_1K_HASH:
> > +	case DF4p5_NPS2_6CHAN_1K_HASH:
> > +	case DF4p5_NPS4_3CHAN_1K_HASH:
> > +	case DF4p5_NPS1_10CHAN_1K_HASH:
> > +	case DF4p5_NPS2_5CHAN_1K_HASH:
> > +		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 10), addr) << 8;
> > +		break;
> 
> Also linebreaks pls.
> 
> Please change this in all your patches.
> 
> > diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> > index 05b870fcb24e..946e36c053c5 100644
> > --- a/drivers/ras/amd/atl/internal.h
> > +++ b/drivers/ras/amd/atl/internal.h
> > @@ -34,6 +34,8 @@
> >  #define DF_DRAM_BASE_LIMIT_LSB		28
> >  #define MI300_DRAM_LIMIT_LSB		20
> >  
> > +#define INVALID_SPA ~0ULL
> 
> No lazy definitions pls:
> 
> drivers/ras/amd/atl/internal.h:37:#define INVALID_SPA ~0ULL
> drivers/ras/amd/fmpm.c:119:#define INVALID_SPA  ~0ULL
> 
> Unify them.

Is there a particular existing header that you suggest we pull this into
or just create a new one under drivers/ras/amd?

Thanks,
John

> 
> > +
> >  enum df_revisions {
> >  	UNKNOWN,
> >  	DF2,
> > @@ -90,6 +92,44 @@ enum intlv_modes {
> >  	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
> >  };
> >  
> > +struct df4p5_denorm_ctx {
> > +	/* perm_shift: Indicates the number of "lost" bits. This will be 1, 2, or 3. */
> 
> No need to repeat the variable name in the comment.
> 
> ...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

