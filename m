Return-Path: <linux-edac+bounces-3472-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B31A7C727
	for <lists+linux-edac@lfdr.de>; Sat,  5 Apr 2025 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D7B16862C
	for <lists+linux-edac@lfdr.de>; Sat,  5 Apr 2025 00:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EEB748F;
	Sat,  5 Apr 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQhXtPuM"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C4EEBD;
	Sat,  5 Apr 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743814728; cv=fail; b=m8TIeuv4bwjzD9p1ORdzzEd41MAbYP3XxnTzk5rPSR+RtfSPdLAq+xRXifeF3K10TXusRF4/Fcq6bUHC02fhmokHCi+vn9AeUwiSJto3tOSgI+E2uVluQBDgZMw0omj3+n1mUow3TC+Wd1IYNw567v6dqy91xVciP02kOWoebGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743814728; c=relaxed/simple;
	bh=bU2vZZ5If5dZ4VP3Nbeov3XTECVGYMRnwczAUD20QKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKZQpI2TLKqfJUeTuzWXx08W0JijHy8DxoEUWQOszuB+p3CZ4yo/+ZgW5SwikWKTXY5ksfa3IRji4OjJVhqBvl0S852H50q1IJpDRmETjQ2rXZrb0mfBpVNP25O3NJ40fo+89fuACXklB6mK1/GVm8jDBvOx7c3l0QTGcu1Z7gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQhXtPuM; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYgb2sgSEc5xnOCJn/S9nyayh7xb1UUBChBEbNw9B8vzWRVi+SpUtIPtK4envBZm0CN7s/6ljehtQYCpKF6h5U5pmCpyTxmzp2f3Oxg6UJU4axzLycEN4sTc5xGBcuH+aoWkBXF7xu3KHzVAjNMhBjt6etZXsiXXXose/X/5qno3l7bd+r2EjW5LUhrtUrp3CFfubHmND17d7Qf8qugxZkI2q8ZRRbFKuiiMLBlooQoiHj0LGR0UbMqMrrNUtx8I0f+rCv2QejX60jGGXV9wL3L4ss0JU0EjrI7/zmHP8bPYr9KGlCgBBeczqIFv1TtNS8HnVMS+M2ndWOc5bxiA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnXOsWpKMwK5/MdyMnwo2CMMpXR3zjoIrfV79p4aAXA=;
 b=C5J7QtZD50V1Z0mJO+GqZy0vErRV6JjJuJM9DVnr4H+hXyEd6j3L6utitDFE7nIJfbSZ5szy1eT62HoXrIHroJJ/GQ6Cias/NvRyJxaaUxno48JWNniRbTNmB7fJMmuKr+7AACx/mByH286kRAGG6DLANnsfChe+7ZWm/PKLt7IYbDU5uIaZVmGa+HIFVYJXdQJn1lwi7M7i1qLoGyOWWN7xgQsS1ab19h6IvLgdEU2YVkve2joxEvFUvBVaFa1MrIGHoBEs+7sy/QVsrLVfPtyOnPQ3SJ7rNRauQ1uo7+ts2FPtlaKQSMfGXMuVTn5LoJe+R6du5CwDJionqbkwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnXOsWpKMwK5/MdyMnwo2CMMpXR3zjoIrfV79p4aAXA=;
 b=lQhXtPuMttPwVRXy4qndXLG/4B90vCDjKhYh9B+a1LopjwsSn3vzebmlUDTL/dzKou1ksIrDD50wHVbL2HVp7G9aMgGGv389AekDVbZ5n+8zbYoJvZA9Z8JC6Xlt/KF6NqGd04PHZjUXTg930TDctNF/cFvwiy7e/M1NR5gASgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sat, 5 Apr
 2025 00:58:40 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8583.043; Sat, 5 Apr 2025
 00:58:40 +0000
Date: Fri, 4 Apr 2025 20:58:32 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
Message-ID: <20250405005832.GA1625290@yaz-khff2.amd.com>
References: <20250327210718.1640762-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327210718.1640762-1-avadhut.naik@amd.com>
X-ClientProxiedBy: BN7PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:408:20::45) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e0b5d1-a33c-4054-6b8b-08dd73dd0114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJRdTwerMgxUwsDhYH3ZqwiF7Y8SjL5H2hUOLe6CSmGYm8UbEPmHrO+QnWQA?=
 =?us-ascii?Q?IeVRBtOCH7DORGALhgG3D9Mm/3B3WFnpyQS1lEAJ6IQDSw5+9eGliVl3F2Mg?=
 =?us-ascii?Q?BpiM34VoAscGpHHUH10M6ByH+FJv7CJNQM41XA1AMqpNMM5uCzdcKU2UOot1?=
 =?us-ascii?Q?t3Mh6snp35mkYtgbbBYODeZdYixdqcpn8LCZmlYSeHSJjrBLcAZZoYf5QW33?=
 =?us-ascii?Q?lLCLkzaGCTGzK2yDE1B3klZiz6gCnBwaZs6aS943iCIeJBh0VaGfW7Byyb1M?=
 =?us-ascii?Q?dgLIxQ+Nt2+ow49PGdjg3fcwbo1t2QrxwRK7go0TkTtxXNMKTJP/TnUhXIkW?=
 =?us-ascii?Q?tgkLRKMb++zbSivB08IPWOaxNERr+d7bynNl9SQk8uNJUOiWVkebesDgi6jE?=
 =?us-ascii?Q?MMzK28f0tLKtkNIUzMmtoWSpbFEWhn/ii+ZXwG2j+Pe+bAEBUTImfGpwz9dc?=
 =?us-ascii?Q?yRCSJKgGpObCi9r8OBeqXsUk9zePmcp5ufLJvLpqKA4ltaaPPPlSQyz7Ge1/?=
 =?us-ascii?Q?IXx/3dwEYIywNvf4b7Tcvu2WuZWC22l5IcmHVWG1YhBhL0b11LKAgRdR918z?=
 =?us-ascii?Q?KsXeQUr1bhskuGFF+46mOTsXoKUpTyY+AZPXyEZhcSzQLmbShAg6FzsFy1JL?=
 =?us-ascii?Q?tFtCJwmZHXqtQIuq6YC0Hoa28uqCCX8kNDYfv0Pgm96F5R5bR51hl7RhPeTu?=
 =?us-ascii?Q?vxkXAx4bYqa0b4EyPTYFBgW4SUY98YYFamVQKIHevwljHKa5oh/7WbdZ3v4P?=
 =?us-ascii?Q?vUJ8Ouso1Hb1gTwTZ/hbmsnMm9wZO0IAxmtOvOayP+SXbARGa4jc8ni+bJff?=
 =?us-ascii?Q?8x8D2UpcbYtaVWs2BnH4tJ8gM1ByiWAjDrS7cv1JwvILqzC28NJCCF3ikK9L?=
 =?us-ascii?Q?4J6TgWkslR2NVzO+kNjxKOuJjvDjWJ6EJQ0jqxv9WaKHPPqflzw+ceguBdKD?=
 =?us-ascii?Q?exd2pz9i0QzJK4/KqkAAvBpjYR5A7l0ydt9AetHvssvBANEUYQLdsmdbWb+G?=
 =?us-ascii?Q?QtC5LpUp+aPKJIifGr0nQCxhLpXiLVcc2wDflj+0qVDhTG/26f5OhLNujPpt?=
 =?us-ascii?Q?394WZI1bS68Ct3VB/yAn09AM9Fz9+o5I8VaPpiPVuP+HNXAL3d3lTAMphR4M?=
 =?us-ascii?Q?sx4sxNrTTvzNHq00Pk3ss9F3gQh8izYxDx9qYsegr0vpORH7qWoX7YfuIEaU?=
 =?us-ascii?Q?Xa+rsQIG9ZT04XlO4JllrQ5uWH756Wy584vBUT9Rfm910dgbF4P6eXnfi2hS?=
 =?us-ascii?Q?iaWe0O+RPMEsn+ZQaOcwXDew8Mcrjqhb6IaRoFVm+iQ5vkh/Gd32Gz8d2uVL?=
 =?us-ascii?Q?uLZZaUvVkNhahJzXlzuv2t8Qd8X8BizfgH2ZKCTJnbl8FR4JNi2jAxICoSFL?=
 =?us-ascii?Q?OhtWB/68BBHfBnCU4PLpfM5XuSja?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Swn8fBFR+tWt4lNpxD/w+Cnc3IZatoWxjT6dJxD1DIMQlUIFfxYxeyGLzwpT?=
 =?us-ascii?Q?CfyDx0rD2iVALaOoEsHZetqPckoqvuHifWHdA9oz989O2GgEMFljCgrLypKp?=
 =?us-ascii?Q?ealkJcGqlEGm8O7sWjLHUoZTuxFCzwiH5T9e6C7B6gZ2AlPGlPUEWt+rj6ZX?=
 =?us-ascii?Q?MANWs/Sd/3LXGjElz4g+U4k07T3Pl8enP/lfzgbXVkgB8xDmS+vaLgG5AWh9?=
 =?us-ascii?Q?MQKT2c2US984mExdHjwRFqgr10UBCjCnvxF2iMKB1MDxtqvsEbUTmb4ClOkD?=
 =?us-ascii?Q?zfRY/H5D/p4OYjBxQgLYy+5+K9HKfGcL5i/QSAfqtvG1N6avohax/8nvundM?=
 =?us-ascii?Q?zHR2pqVrXlzpk55ArqOnYxfpKoAAglxH94VQVbrVMy/SJj1UZKr4xxMJLLpv?=
 =?us-ascii?Q?/p/NuibB8ZeINfvX/3uhectUH3R1lgszBKHHGQfKGzw5Dc6gNpgeoSvgv0ty?=
 =?us-ascii?Q?S6FD7mFrgv3mMcB+sGR6c7eudz4qpSUI4xGUt9DWYRNyj3C9dfwh2w04Vq24?=
 =?us-ascii?Q?4j9l+tQaIAf2+9VTE4PgQz4NtFBbjGM+z8fN+3ABnkID6YJzA8nBhtpecpD6?=
 =?us-ascii?Q?Ye1QnrN3PFah6nQRO3zCWX5aFHVlbJWokFPNr8IhcwehOueTuSCh7VdpadwT?=
 =?us-ascii?Q?wGpduSwg8j2X8rEjxtMDqGOmWYqV0RTveEE0jSASPPGxz66UOBT/a1uztF0h?=
 =?us-ascii?Q?gGRbjU198oQpptDEFZi3fWI4uyifGlyOvn7X2fsy1TYQXwn+wnMc2/+f+c/K?=
 =?us-ascii?Q?0bdWv3undutmpiPMV4HDV2tATQ1rWlPkamoaCC6SsIefc7HlyU5lVKAuSFOT?=
 =?us-ascii?Q?4RU3zECobxX9QOlXrgYBuWqyx/KCb8N63ajyHzFX1B7bH6D+gm7lynux5gYs?=
 =?us-ascii?Q?eoRd4T3bTTO+QExXQc+Tox6FuG6LcnebTPIfMCZLd5goOJCLqsjeOlYJqgDR?=
 =?us-ascii?Q?KyOpUGCz9+D4tG9IHiFpd5grLa30ncNbCfvBQxhvMUoDXv3qlPwpCWqVNe8x?=
 =?us-ascii?Q?TBowd6R8P/ItRQe1sopKIRclp4mqUl19ZniTbK0rPTtb1kpwP7311Uams4sl?=
 =?us-ascii?Q?pobuA+Caq/1Um8nIcUfeGzdkRD7A9Fc6qW0TRL6yAhNdO5Msem6trSQa6naz?=
 =?us-ascii?Q?1Tf5naa8vTmIPeldMKvHPwRitjsB7/foQY5wz9tVx4BhTlba/7egAN3fl290?=
 =?us-ascii?Q?jukj60k8hbAWapPc5nh31xWDmDQwv/xwmkvdabSnRFUMFZQgtirqGBCEPJqM?=
 =?us-ascii?Q?6Jn3uvHpLP7OxDh1UaGCH2C4mhHwCOAMWpRDauo5PQ5YCmF/NuQe2pZPF9Q6?=
 =?us-ascii?Q?5RIfqzMrO6ZpI0/vUy6L4pGBpUDGcjZAEWsrQ6Ar4yU5c1VIjEj2S1N1NDLz?=
 =?us-ascii?Q?Wf2AUzs+tOhEFHiRtQHr1RRgWRFPPqAfYB3PghDCN3vAQJ60byoDAa9G2w1I?=
 =?us-ascii?Q?hpJPgm2e6Aty9oBka1eqmMyTj3B8VhuFE4iKNznPuhbwnzcl1bkisvbZBnC6?=
 =?us-ascii?Q?nhi1Btm/OkmH/vaRqOq6yteaz/99iGO5PYNGRO78wZIZ/B0uGleEeCFhuBIe?=
 =?us-ascii?Q?AptonDFus8ELe9llwASblc9kFkZY+Uy2x7Owymzj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e0b5d1-a33c-4054-6b8b-08dd73dd0114
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 00:58:40.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9uEYzpgI+cM5CQhBJuIat729YNdZH9uTk2jL1nTHK6lXL0xvWWACEGUCr+6A7Y/DjFBwb3OeX0x0onkhZid9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

On Thu, Mar 27, 2025 at 09:03:50PM +0000, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD EPYC
> SOCs has an Address Mask and a Secondary Address Mask register associated
> with it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS
> granularity during init using these two registers.
> 
> Currently, the module primarily considers only the Address Mask register
> for computing DIMM sizes. The Secondary Address Mask register is only
> considered for odd CS. Additionally, if it has been considered, the
> Address Mask register is ignored altogether for that CS. For
> power-of-two DIMMs, this is not an issue since only the Address Mask
> register is used.
> 
> For non-power-of-two DIMMs, however, the Secondary Address Mask register
> is used in conjunction with the Address Mask register. However, since the
> module only considers either of the two registers for a CS, the size
> computed by the module is incorrect. The Secondary Address Mask register
> is not considered for even CS, and the Address Mask register is not
> considered for odd CS.
> 

Missing an imperative statement for the major change.

"Include Secondary Address Mask register in calculation..." or similar.

> Furthermore, also rename some variables for greater clarity.
> 
> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Cc: stable@vger.kernel.org

JFYI, the TIP maintainer's guide recommends *not* actually sending the
patch to the stable list. Though I recall some stable maintainers are
fine with, or prefer, this.

> ---
>  drivers/edac/amd64_edac.c | 56 ++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 90f0eb7cc5b9..16117fda727f 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1209,7 +1209,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>  	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
>  		cs_mode |= CS_ODD_PRIMARY;
>  
> -	/* Asymmetric dual-rank DIMM support. */
> +	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
> +		cs_mode |= CS_EVEN_SECONDARY;
> +
>  	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
>  		cs_mode |= CS_ODD_SECONDARY;
>  
> @@ -1230,12 +1232,10 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>  	return cs_mode;
>  }
>  
> -static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
> -				  int csrow_nr, int dimm)
> +static int calculate_cs_size(u32 mask, unsigned int cs_mode)
>  {
> -	u32 msb, weight, num_zero_bits;
> -	u32 addr_mask_deinterleaved;
> -	int size = 0;
> +	int msb, weight, num_zero_bits;
> +	u32 deinterleaved_mask = 0;

Don't need to initialize if it is set before first use below.

It doesn't hurt, but we might get patches to change this. I forget the
exact reason; maybe saving an instruction here and there adds up
throughout the kernel.

>  
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
> @@ -1248,19 +1248,32 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>  	 * without swapping with the most significant bit. This can be handled
>  	 * by keeping the MSB where it is and ignoring the single zero bit.
>  	 */
> -	msb = fls(addr_mask_orig) - 1;
> -	weight = hweight_long(addr_mask_orig);
> +	msb = fls(mask) - 1;
> +	weight = hweight_long(mask);
>  	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
>  
>  	/* Take the number of zero bits off from the top of the mask. */
> -	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
> +	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);

This change makes sense to me. But it would be good to mention it in the
commit message. This is more than just renaming variables for clarity.

> +	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
> +
> +	return (deinterleaved_mask >> 2) + 1;

Also, 'introducing a new helper function' should be highlighted in the
commit message. It doesn't need to be a long description.

> +}
> +
> +static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
> +				  unsigned int cs_mode, int csrow_nr, int dimm)
> +{
> +	int size = 0;

You don't need to initialize this since it is immediately set below.

Or you can just call the function here.

>  
>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
>  
>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
> -	size = (addr_mask_deinterleaved >> 2) + 1;
> +	size = calculate_cs_size(addr_mask, cs_mode);
> +
> +	if (addr_mask_sec) {

I think we can skip this check.

For debug messages, it doesn't hurt to be more explicit. So printing a
'mask: 0x0' message is more helpful/reassuring than 'no message'.

> +		edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask);

addr_mask -> addr_mask_sec

> +		size += calculate_cs_size(addr_mask_sec, cs_mode);

Maybe add a "!mask" check to return early if you want to save some
cycles in this helper function.

> +	}
>  
>  	/* Return size in MBs. */
>  	return size >> 10;
> @@ -1270,7 +1283,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
>  	int cs_mask_nr = csrow_nr;
> -	u32 addr_mask_orig;
> +	u32 addr_mask = 0, addr_mask_sec = 0;
>  	int dimm, size = 0;
>  
>  	/* No Chip Selects are enabled. */
> @@ -1308,13 +1321,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	if (!pvt->flags.zn_regs_v2)
>  		cs_mask_nr >>= 1;
>  
> -	/* Asymmetric dual-rank DIMM support. */
> -	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> -		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
> -	else
> -		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
> +	if (cs_mode & CS_EVEN_PRIMARY || cs_mode & CS_ODD_PRIMARY)

Another common way to do this kind of check:

	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))

> +		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
> +
> +	if (cs_mode & CS_EVEN_SECONDARY || cs_mode & CS_ODD_SECONDARY)
> +		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>  
> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
>  }
>  
>  static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
> @@ -3512,9 +3525,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
>  static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
> -	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
> +	u32 addr_mask = pvt->csels[umc].csmasks[csrow_nr];
> +	u32 addr_mask_sec = pvt->csels[umc].csmasks_sec[csrow_nr];

Please align on the '='.

>  
> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
>  }
>  
>  static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
> 
> base-commit: f1861fb575b028e35e6233295441d535f2e3f240

Thanks,
Yazen

