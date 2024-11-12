Return-Path: <linux-edac+bounces-2516-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F39C5C2A
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 16:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81ABA1F233F5
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C82022C8;
	Tue, 12 Nov 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tamKKcWN"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA5200C8E;
	Tue, 12 Nov 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426227; cv=fail; b=T1JpDwpslP2Z0xmGtCR4YA+5OB5rsRhfTghh+RUKSYF3SDKh1leFuyQd8JHuE7ATdligbZqsq/Vd72A7bJ2912//Cmlr3dDZdGqk9GJKtYL3eCOdidTF2S8UeIYyjVyf4AaBEjmHOosbyZH9r83pDvKTvXlMbwUh4r7aWU0PZIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426227; c=relaxed/simple;
	bh=D6S+5dgbrenMZP0h1RU6jhVskpKKkfx/pWx4TOYCbIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hitnXgrQtON/IwUUNGfvMBuAUSklehFYlMGm1vDTdqLscYG6ObcC8AsshH0xTYowDZ+GfnYbBXWkNuU+hQpQhzHrhUsnnF4F0qM2lAb64NHg95+o320J72tBYVaB5KNdQ3/wL6uRotvPXtiMW54pC5ci85Q4DlO/Fdbm+3t2aVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tamKKcWN; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNjTd3W5EHh3rsIyzfUlXeo84Ipir2QMDsTfjMz2oDh4z1Fk5/X47X60Mvt9bxogK7jr3lUxdKTkOpluabU8jJqPvy74UsjvZ97WX22XoWOBkzoY3zNwa7ssgbAN7tMWdy6je3uZkFWXZnYcSj+ZtejVwil+H025b8C87N3L19pk6+LswnYwJClN9Fr6vEGV3nP5RjaPWRcomndORsPzqUjQwm/1a8wLJQso/4RbOZtL+0nkOmWvK1ow8JQUGmvksiEuCUixwTAelFTr4pAdb+FP1KNO0gpK++/cL9bWAM4QjuppGI1AtM2twEjiUIOQoxnruPASx4uLR2Y7ZMmU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+tQzDknX7DQrU8vnPRrmooIoVv1d+RBO/Q2Xkht64A=;
 b=hIvUElHWyoRqedIBqrx3cbZvDyIY7GaR6V9oMsPOzs/jwJg2jACAk65bYGUoqNdOa8QM7cx5meoJc6p+fbwHBLoSNLxXRgd/u6LtRmjkT2AVecnVW7fMIjQgDCpmHmVQBsYacEvFn2xfRykmiHC2HfKSAii/FRXqH+bWZu/bSZynfI6KrC150brqo4dgoqyXbfkab0E2/69ev3cSEs1qYgSXviMZm3zJZTy/ZYTmPQechzNES5q9LGg1OVgQ0o996M80gRpV6U6G8TPOY6/cWY7PIjEvkA5cRkjg6dPMNbVR90KHKRwPZ0fD+LwEb43xsIj3Ap3MuyvxEO9575CS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+tQzDknX7DQrU8vnPRrmooIoVv1d+RBO/Q2Xkht64A=;
 b=tamKKcWN5ZZVrxePKDEybR4YzeNxWgZYQtzbdd/NuBTJAN2KViM5Xh9Ge0SXM4gDKonFZBjtudnyXcf9YnMLeXVldJooOjqEKsZ8HkaDfjOQjojw35eIObn5oD7HNLhdyk85dTjO3jU5lzjco89AaoFjGOqjr6rAXjn/vvh6Joc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Tue, 12 Nov 2024 15:43:39 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:43:39 +0000
Date: Tue, 12 Nov 2024 10:43:35 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Message-ID: <20241112154335.GD3017802@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-7-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111060428.44258-7-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BN9PR03CA0780.namprd03.prod.outlook.com
 (2603:10b6:408:13a::35) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 637d223e-78e9-4471-199b-08dd0330c71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZuyUifInu4ruJttwkm3WaS50rvVsXvSFBLN/XgDIxlBXoN6BSYFZT8KW+y3?=
 =?us-ascii?Q?Ym6P5jdA7QV1dz5jwr+2SFRx42IxCHzSHeulgDARcjsc7C1F7xBlrBS264GP?=
 =?us-ascii?Q?cb5ix2R93BEIScUwfsxeJ11eMVQqW9pg+v4KqUfxFwS0EslOTBHS2zSqUOzp?=
 =?us-ascii?Q?wlE1uwoNetxI+edjc8fAWtCuR3n+sIqMl91okZgY/oF764kjYn8GSPIsw/wl?=
 =?us-ascii?Q?YEUPsLZxZDSO3cVzAqez8qvU1mlG6Zo5GPM1tJKCjPFZU/ujy0vOk26/pOFB?=
 =?us-ascii?Q?BMVGuLT9iojWC6BMmu4VhR6kyQiXDxnGd7Z6KnZybuUujsCxiUHGcBciW30H?=
 =?us-ascii?Q?mxGQvxaX1xcarmh13vXImq1flozJ7T+iFFqx8ZuY2oKMqV9H6FpiVi+TTZrQ?=
 =?us-ascii?Q?VHM3kXK+shJRHRO1jiGWCF8m0ZAEPkgz6Y1nPoDDMdxV92o/oKLyQw9+gzmo?=
 =?us-ascii?Q?JMyGB0Pqao+IawUO5qy+7a+1GQ23Apo/UwVvoynjrOF0BTs6bRhMrAvg8TyD?=
 =?us-ascii?Q?T4zzht4c1qK5YEFz/2J8uOfNVyTQMEiDPOP1y5lmxnI7MaRLnuyEnHgtmQnH?=
 =?us-ascii?Q?ED4Y/EOGvXHg/64Gz/53YfWsLZUIj6vKYz/16GQ9Fa6qzqh/lCwZ1UqqBQNG?=
 =?us-ascii?Q?IINmZ9v6wBW+z7K9tm5ndMx6quI7Wymxdm5y6r/Q0Sq/iGG4m/gevFd+txQF?=
 =?us-ascii?Q?vL83CmuNY/gdzhehQ8hOElxhmVpzCMU73ScuuuJ3slL0rXRyhaTQUbbKdUxa?=
 =?us-ascii?Q?mZw+jFIHEPBefaFXOkmeKkYZdzmlaO8kTf+m468bjVS4yBGbydnuPI4O9gl0?=
 =?us-ascii?Q?7ZU4i3U8lgKD4k4RmqJEYqcK9alNK0lEKOAeS12WOnvPnjiY1f3UIZth0pyv?=
 =?us-ascii?Q?O7UInRqnKOIh/I7jPVPSvhyN1fMS2d19KN9zVwteNyQrctkjI8+WiY3zPvEG?=
 =?us-ascii?Q?bZnBC+nl6zgkDT0K/3PQkceOyZ6lp0j2idfRvWz1F116ojYJuuqrpzH7Fbwy?=
 =?us-ascii?Q?LXioKx3+8O8fXLVmBEWPKE9d/O+i9bt0di2l5+b71+oKHBH85YluXETduDdB?=
 =?us-ascii?Q?SOwtSetNAhjgS4InqTgOy8kg/FOhRV/FedJ2BWX4+o2jngZvE63BG/trY0Ed?=
 =?us-ascii?Q?Biph40fgFG7Zjj+he7zp/96LnpqddrjdvZPwcFDjh+BHbNXDMe3zB2qS0B6L?=
 =?us-ascii?Q?1YUix2KyFsd2ef9IYvYqdZK/y6NqoInqQ3mA8X13V58gQAJD0t2UaKJYZQHh?=
 =?us-ascii?Q?fisbFkZD325fKpPbMw+PfPOuBodTiyT5mq3xLXK9srwvH9Y3z4zdrvcVlYp+?=
 =?us-ascii?Q?XwNwiv9PA+96pechJoWdIPFY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MSlRFgSrryQ3mW7sZYdnRewZ0redlLiG6iGWvrgVHzFZC/XvDFVaJQ/iz/BF?=
 =?us-ascii?Q?0oi9eR2WqWg3Gi+6U4CMyuEnxjTVtH4AsdyNcB/9QPp/jkZmvJ2MRTyxNyxR?=
 =?us-ascii?Q?XWDIhRKpJ1+qQN9/m7ph+sOaz0VqF2HVqTTiIZrVJE4A20bjzdz5rSWDK4Br?=
 =?us-ascii?Q?5/HNlUCSXlDhIVlPcUbDStEXSN+UPR3QKKBeC8IWECTrpC5y+N+BypTBo6Sv?=
 =?us-ascii?Q?DevE1bsTp05RHkTSb3kq8SD0oGzKl7eo3kfjcJCFbyVoUODLI6XszfuTzNX1?=
 =?us-ascii?Q?i+hfPVg9yHeBsrrfuiuX3ghKSTP9hqOYjg0koMmnmhVhw9hW8UrRmxqyIshS?=
 =?us-ascii?Q?4IEB1CHjbWuEp0jxiMchjgPSyCvemmz3YZstlimcSZZGBovwzzE/CRd8bgCm?=
 =?us-ascii?Q?a+ohAPpHMJ0A3WppbF9bIU3G3grCRfKrwiL7aUYbfAXCykmTEoFIAZX8ANil?=
 =?us-ascii?Q?pE9hqOD1ms72rIdEvIwgiHYmenSFUH4wUScnw191VjPOH6uANmN4zaJY1lFY?=
 =?us-ascii?Q?7gyDST10YmVg1kjnSGB13vj8xVak8ivrLbyzHCjIxXUC2P4cQla134r4P5uT?=
 =?us-ascii?Q?O77vzmZwtfZuq69bBVQAFN2ddkHUYqjPicLrIx9wLbBKG496q1NCzsSFIbgw?=
 =?us-ascii?Q?yoEIE7MtkUX+uduFVXIE4XLbazxKTljvr/nn+JTuLBAFCo6vnNMU7BIGAE52?=
 =?us-ascii?Q?D0wl0nMI7uZkMVehbUjlUu78Iw9EZGaeDo4HRkH1TEkmtaJXAZzRppsY7fa3?=
 =?us-ascii?Q?9yCrjwD3GKWGHJ31okd/xJQbNhSHtCbU8vFMro+T6Z5u6d8wVY1SCKRREkph?=
 =?us-ascii?Q?uNLwAZX0NeKwpPep7nIjtf13EO6JqDnBwe8SPPb+TXJaoxy5slNyrTXNZP2Z?=
 =?us-ascii?Q?tWZvUETQGkHVpylfUGrZJBJ+zKa6n71dxVTYG1rmC1r0o046vs79NnWivAIt?=
 =?us-ascii?Q?rXp5JpFTWnowjrnUpxQQj/N4S/4A0W3X4pLwP07p5jMQGanzPjE+/2pp9qei?=
 =?us-ascii?Q?tfiiur3k9YpuWplXqAX9CqHRR4c6kuGazAo6M4VG0vf4rYY0YInlBkEAWBbk?=
 =?us-ascii?Q?GkOOakDMlYIqMNlafN2OaEjzxA/tCw8Fyq62+l4/Pi16EyxwGxjPxVtAgcyM?=
 =?us-ascii?Q?HKY7A9ip1nH2B7PeQiLS7zOpBBnqgkicBBWiis6jgvpx6FyLrnIFpqHjZ6s7?=
 =?us-ascii?Q?rrnzc67HGqA8Qvg85w+H54H0umpRpwYQLIkMFYN/0FYN+YwJd4wiaTroNCrl?=
 =?us-ascii?Q?scG7HEZiuvLVpV2JxQkgbMLlokC/VzdutaqP2rvoKdj2kQYmgdcjGBP4tI89?=
 =?us-ascii?Q?pTFOgAkA14cJorlqoBtGr4v/EX/nCyUu1KG+9xC4Z3vOQ50lKPKmddbJy1ho?=
 =?us-ascii?Q?hfJytC9LvOigQkCXMcngmVAy1dUldHQ/KCuMul99zBRgvSjYEXxN6hoo1SqE?=
 =?us-ascii?Q?ktvgxxqz4ZhNIiQ6FhTr4krUJC/Xo34B9P+0Y4XOIhGnWNnWeKMMd9vhSOmr?=
 =?us-ascii?Q?TQD5ObY7qS2Y3KkyAjS5rrhSYiDcU4neYi9PBTyLTTiUH1lUE381yBiTXDNZ?=
 =?us-ascii?Q?4C3zZhVk4MjVs3sSL4a/JjdcnQNN6pfBFBx3898j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637d223e-78e9-4471-199b-08dd0330c71d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:43:39.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFpX1EOkPduFJ+4+aAZiVtxea4FdCmOFV8n+7c6szn9HZQ2BncsRq0sDCXNsUye0IQ0wHsJOHczRdy51OK6yDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057

On Mon, Nov 11, 2024 at 02:04:26PM +0800, Qiuxu Zhuo wrote:
> Remove the unnecessary {} from the case statement.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

But please see note below.

> ---
> Changes in v4:
>   - No changes.
> 
> Changes in v3:
>   - Collect "Reviewed-by:" from Nikolay & Sohil.
> 
> Changes in v2:
>   - Collect "Reviewed-by:" from Tony.
> 
>  arch/x86/kernel/cpu/mce/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index d288cc7390f6..0f0c6e9d9183 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2118,10 +2118,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  		mce_intel_feature_init(c);
>  		break;
>  
> -	case X86_VENDOR_AMD: {
> +	case X86_VENDOR_AMD:
>  		mce_amd_feature_init(c);
>  		break;
> -		}
>  
>  	case X86_VENDOR_HYGON:
>  		mce_hygon_feature_init(c);
> --

I think this could be a bit more substantive if you also combine the AMD
and HYGON cases. And remove mce_hygon_feature_init() which just calls
mce_amd_feature_init() anyway.

Thanks,
Yazen

