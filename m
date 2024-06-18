Return-Path: <linux-edac+bounces-1304-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7A90D6D6
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 17:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284741C254DF
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B191E895;
	Tue, 18 Jun 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dOkn4a7z"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE71EB2C;
	Tue, 18 Jun 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723524; cv=fail; b=NvBHtx41wGguaw6EbWQh7xN142uobi5AC7Ujo3yxpEOu0bXJKeNkglpE2qPjvkSwmzq/thizkNb7FRA8+daWXQkWQC9uhAnsOxr5vMg2Yak6ZEGdZPfd2IM63ERbqR9+w86veeUO+YQ4QHorR0Ha2xtkOdW8FTGoRZBOEkMrW2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723524; c=relaxed/simple;
	bh=+vyLdU4OJVa+L6OPc5tEhMvtPGCTTMIv9K69wczFsos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDbVf6njUL9t8vleASHj76Y/BMMWBXBNOEsYlmm+Q6Lgf0T9xMaiOEPJvoL+B7frfERR59xOI37EMnxxhmDw8K6/Jem811flLtFOQfnUisIth7oB14Kltb0VJSQrE9uTmIHc7A4WFkmognbssLD7HZhWAaoQq4bSqXkEK9DrmKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dOkn4a7z; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCO4tWIIfgSt/hSRCjGp0XSpiB+EMoA0B2JiK4DgSh1edWgl5/351LfThvAXisfFv1QJZH7PNTgtus4lbCACObuPRVEk35wCOD6ZoZrngJjHS8UOfGALX1MOySb2SowQ7kIKRGwy6QyQHB7ZS4l0GBD7Yz9nv0qPsHHG9lZ1Oi3PaZjdGthpZnX7hBpn+JYqf2z39882N1wnzw3bnCTVoIs/f1N1ktJB4Bn4/2HldBFYfnKZtKuP7EEWt1mVSniAVN31o5XAL6NAlqvDsQpKrQEdys+OQy+qEFyq7SQ6IXFKrRxroZP0hb0eYlVw8x6PPaOVcKXfImaJeCPfunpDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAvJCTOilyWVW/VS4O7JcuRn8jElR57YuD3c+OqSqwI=;
 b=dXZq5Cr4WobNV7AHhZO3A9edVu1n7BqxWH8VB9CO/Ds2QhujXZJ34zPBa7ZmecXKfWxVuDRDcd8BM4KVTyVFT/44IvaEp8Py0ei8WJHcmhAq2et6pQZH0eVJsiMwTLMT42XC4utHoabP2XNzna+7I/WHGe9krTW5yrJb/E9Pg5OzQ/JLM/ir1Hipbr7FACg1Pv/GIbLGS9LV5g/7Bf1Iuvp7H2D6YbGMwJPDsUIUtMMZxpaD+YqV7QhSB0eExJPR3KbeHX0LgXBB6EL16PuQfMnyTtJdEM/pEyNrOjdxPMgc0x2QIo10TZBT4NMX8jMiGBIXhUlZ3l9MMmZrGNPV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAvJCTOilyWVW/VS4O7JcuRn8jElR57YuD3c+OqSqwI=;
 b=dOkn4a7zW/8fTnF79R0eaoaNR5DQQvfGiq5zDS7dIagna/jMCt8W9+pCxISCoHIfQ+Antf52XFb/wKZt8B/d6cBh67RoOvTUYS4qL5YtAIm0ZudCK52PEmylqW7dss/gEIhCvui5ukeUt6Egb0+tJGSPWeQwIxHMb4gQv5/6S/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:11:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:11:59 +0000
Date: Tue, 18 Jun 2024 11:11:51 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Message-ID: <20240618151151.GA1153@yaz-khff2.amd.com>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
 <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
 <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>
 <20240603165530.GFZl31gtuABwpe1svP@fat_crate.local>
 <20240614214736.GA726880@yaz-khff2.amd.com>
 <20240614224420.GGZmzHxDEH2D2TLpjN@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614224420.GGZmzHxDEH2D2TLpjN@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:408:112::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f7eaf7-87ed-48e6-975a-08dc8fa8ffd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TdYbKygGX9vOQdXh7wOL8HAgNrzy7J3M5JT8t09krOXQ0Cv7thkiS3tVqayG?=
 =?us-ascii?Q?Y8wfIFEkaDdBkc4z3xmXQugFFxPNcf8mZzOLWKdUGXM2kefGcwOAbcY8/9Vk?=
 =?us-ascii?Q?q24y/948sBiQNKNrr2x5aJYsizJuYFjbm8/tKasmm5RjGyWX7UqtwDkYAXtL?=
 =?us-ascii?Q?QnIvjiOpJqDUugeNQxXTQxGCAr7UoPJh5+qsGGRW8CH/E3L/w3BLhY0jQ50H?=
 =?us-ascii?Q?fAYKfP2cNKyR70w5zkMIWmrxoy+Ep1+v7VtBIglxZvB0JybZA4w92Wqyy6BN?=
 =?us-ascii?Q?gukYoat6OUAMvKwukGhI4HElFhHPGMff49419/SZNZKWX0yChR7S7niWxmnH?=
 =?us-ascii?Q?UZl/xxWCyxvQoxWTAcMloV0XMii2Z2I63HyVQKwSDqr3rjRmRhPc3zpbjqzR?=
 =?us-ascii?Q?weg+5mt4sL42dTwDMKTSazgJrHmEyVqE9zWK6Ld9eeKckvrsha0RwQWQVvB1?=
 =?us-ascii?Q?R2F2BlGlAaWN4+H3mkPRvEIVWFnAHnGkoRnT656dsld7bFtsri1DY2/++Zn7?=
 =?us-ascii?Q?BZWDLxN7xmfGdhMfIVSlpmctKX4mWdSj2TmzxQ50bjTaNK0TFxZONSVYyVIx?=
 =?us-ascii?Q?re/h07ycbP9Y1yP9Pp/p9aPPDyEvaheJWSFVFVamEqhZnoxOBGH1CGVkJjgW?=
 =?us-ascii?Q?IF5ryOgpJneKZO1WHvd2whvD90aEOg5VCk+10GoGGirPOG7OjKjsBqPAoMU5?=
 =?us-ascii?Q?YvcP0qEaNt7aZ6qBHCLhGrs6C1mPVu1Q0jC5ZdelC7ToUbxAn/LF33DZvPCR?=
 =?us-ascii?Q?dVIvoDDv0MZMwuqa8oGwZcfv4UJDtg40SgsIWzNJYusxB7D+ALNJmPUtnvtt?=
 =?us-ascii?Q?aZfcAZhc45M5OUv39EVJ/ffKFE4nb+FdHf1Q7C3sLtsPyJpSC3a7/D9IAobE?=
 =?us-ascii?Q?7H79xaDnWS2QUHAMhp5G+Us6dqYKQzkC6wGyWthbRsZUjORjOJKtno7jSxb8?=
 =?us-ascii?Q?mJVDHccA07McVpnFukoOdnUVKFsqn/+mIZ8pd8LaXrjJXQ7KBW5w42PC0Xgi?=
 =?us-ascii?Q?sDjQ5OjedTbrxcq/1inEk0R6nOEfaVgti4yn/uuX3vJ9vndryOfCvYoB+Nne?=
 =?us-ascii?Q?wezHSH4RXfhi8++itgr0U9z9HEUjwmV1f3bFXeCWT1rYpbIy5sz34ChgA/zE?=
 =?us-ascii?Q?I/sD1+PbPqjZbW29WEnlucpeoqStXZhRNPWjbSv2eWaRRDlkKKUUXR+J5/FJ?=
 =?us-ascii?Q?SJy5qmF+g4aP/r/gt8lo8ssSqtilFbJzZeUp4aX5Gu6meYfcbvBqPpXCbiSY?=
 =?us-ascii?Q?VHKrFOb/fzY3KmpZPfHUWlsK0uT9HxGnuyLa66VQnNSvOGOPzJkG2GnJbrr3?=
 =?us-ascii?Q?kR20VPMXafQfuF91xCRHeo/H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6rPahO5KTAwcU5EXNzrA2X+fCm7M/BEU8wS5ON28oUCYycZHajgxgTtQIev?=
 =?us-ascii?Q?wH3WHpUDAPwvAeRcZuIso7QKl/XtlBqdeLVx6iLvYnOh0MnsdoGgDbopIpRo?=
 =?us-ascii?Q?KljzjZTvz8LdzNgPbpcwX4uTFaIm1r5JY2PPtcn3mwXFDYM8KubwAwrcY/yj?=
 =?us-ascii?Q?HDlRhiwFBv7/bY6WAJho3Oo12tBFB8gTYpnvmbHYgKOEsRgYkcsFom4Ac4/S?=
 =?us-ascii?Q?FxHN1jsXtmTEYpW+xC6lZnaBXDkd73/Gj0CvXyPX9HL1h96t7urKDrME6GnL?=
 =?us-ascii?Q?8SQTZnoxQClORz5WiwT33TujHF/mRkYHSfqhdvq2WaNwo+OrC68AYp4paQGA?=
 =?us-ascii?Q?nCSZOrYT9+6LsFnzf7m3qS+qA+s4rUgMwK9sNkLo0zpf3QnxD9l+l8sQ2Nyv?=
 =?us-ascii?Q?BoaNUqqpwbQyqsX8sR32hgXSclu0EWCiWU0+HYFO8KzWgQAONBXJuLq5zT9w?=
 =?us-ascii?Q?OqCedaUefIrKwU2gmy+aK0baw1mASGCdfL1SzRH8X+3Kw6neN4Izgk2oEkZu?=
 =?us-ascii?Q?5kh7yXNRN1YLI3lm9S59/bdLkfGNwBjmnW4ylEZUje4j/f31tO7TUQAlCvAv?=
 =?us-ascii?Q?6RoKbo5t5AMR0MelCPGBovYgBQRjpvHPAMb667I2BcOvgzxKElr9BvTHrHX4?=
 =?us-ascii?Q?0GEewCNYV2V5R1vQxzFQc5Wl5dUuhjCO/kwBBSu9Ms7RNVgwdXdS6088t/Rl?=
 =?us-ascii?Q?okGZ9hpKTdbQspXqPxAferwSdwDafPoAByaAqlzOD5JZ2FfwT39cpeSkt5RB?=
 =?us-ascii?Q?IbbBzFMUlA6C7xVaGuHI5zbRtTpBtbuH5Hj5P90jEs7MAm5iGGVwiPpM4snS?=
 =?us-ascii?Q?h8+w3gOuX+BKKiXwfXrQPxTAkB5q4gQifPlqOMJZvuKxlExSvrmq2LcpAfOg?=
 =?us-ascii?Q?VZBJgB5uqYzAKMI7pfLf06ar62/DzQGylFF26kkQbfZ9TJiRlolAFGe19xa8?=
 =?us-ascii?Q?DUeBstCNoWINfXcdKhQNmaURc69ueoAN7Od1ntBLl2B+MaK6Y7vAHXd/++TT?=
 =?us-ascii?Q?mbxPGoSxmaYoY4Muv8u0uRVyabWeeWVMm3LWU6tx/NoSGUPKbv3bGGkLV2Uz?=
 =?us-ascii?Q?wyNkWL5bf8A/ecdl7tOTnu8+4VW/FuyQIrKzBKcftmhbyGVKGP0/i2fUxSQG?=
 =?us-ascii?Q?sw0E5k0CGt5SnBbGYF1O8JNQCJaTaTlGW1DPjG4xwTybzIp5jbGYO+DpVnBb?=
 =?us-ascii?Q?SwGcse0IlpHZdrBMhxDqntBsNKelSQB0KxPptikodlNk8J+DJpOQ6toWpfto?=
 =?us-ascii?Q?LbO9hFqDSaDr4gJ1oorxmwqBHVovMZedT/l1YIkExX0JV7LHW/8RGVl8DKcA?=
 =?us-ascii?Q?PxwgJvSbReV3kzaNNdriz3yDiYX0i/sY0skMmyfjaDTNARBzGsJ0doulJg3y?=
 =?us-ascii?Q?31Z8+ty3SgWi/ugupC2Nvdu/2C8ftyMeGxqqdm0xkC7geIlXxMwOGkPxh82K?=
 =?us-ascii?Q?f+ZmcgYdic2o/Psn+Pwb0Gh19UBxJz4UyAY2nVMf3ekem7GAbOb0zIe+HCfB?=
 =?us-ascii?Q?OFbicNtc/G4wY7qJKjv1VrGIVSgl/Ao11u5hRqFwYrzDc395xvUnVfmOjvMu?=
 =?us-ascii?Q?NDbqIrB46ZGvIO84iVs4zeLuJ+HWg7oi9GcP1eYa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f7eaf7-87ed-48e6-975a-08dc8fa8ffd0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:11:59.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmoKngHOO8QokzwTD1SxUhnCT3eWjHt1hobBBUUP/Rae2Vi0W6hz9+y0H1X5S6l2StmyhObulNakFAir2cP2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

On Sat, Jun 15, 2024 at 12:44:20AM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2024 at 05:47:36PM -0400, Yazen Ghannam wrote:
> > I don't see why it won't work. If there is no break, then the iterator
> > ends by setting the variable past the last valid value.
> > 
> > For example, I ran this on a system with 512 CPUs:
> > 
> >         unsigned int cpu;
> > 
> > 	/* Loops over CPUs 0-511. */
> >         for_each_possible_cpu(cpu)
> >                 pr_info("loop: cpu=%d\n", cpu);
> > 
> > 	/* CPU is now set to 512. */
> >         pr_info("final: cpu=%d\n", cpu);
> > 
> > 	/* CPU 512 is not possible. */
> >         pr_info("CPU %d is %s possible\n", cpu, cpu_possible(cpu) ? "" : "not");
> > 
> > But...I like your suggestion as it is much more explicit. And I might be
> > missing something. :/
> 
> I can think of at least three:
> 
> * CPU topology and the initial_apicid sometimes can get programmed wrong by the
> * FW. Nothing new.
> 
> * nr_cpus= - you can enable less CPUs than actually physically present so an MCE
> on a CPU which is not enabled by Linux will be -EINVAL
> 
> * possible_cpus= - pretty much the same thing
> 
> But I haven't actually tried them - am just looking at the code.
> 
> And yes, with the apicid_found boolean it is perfectly clear what's going on.
> 
> And looking at
> 
>   convert_apicid_to_cpu()
> 
> which already does that loop, we probably should talk to tglx whether we can
> simply export that helper.
> 
> And better yet if he's done some more helpful caching of the reverse mapping:
> apicid to CPU number. As part of the topology rewrite. Because then we don't
> need the loop at all.
>

Agreed. Here's another option: topo_lookup_cpuid()

Thanks,
Yazen

