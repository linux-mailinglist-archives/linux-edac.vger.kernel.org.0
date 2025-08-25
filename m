Return-Path: <linux-edac+bounces-4679-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39FB34B2C
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 21:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F905E0EB8
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75546286422;
	Mon, 25 Aug 2025 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OD+1Qgh5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59542AA6;
	Mon, 25 Aug 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151657; cv=fail; b=eJvYt54lzlNYmUSLP1k20IPnfW4LyLNHpX7IOkgSfAsQN6/MIwhUAeUIurMxUbU7tKERkWRb4FErxRaRPrW1HkwC2aqhVovlo60h+1FZ8fg6cgV13zeb8CrZYIKYfg+XbOuFBmwlJGYUxh5HAJmPmMMtAhEjrPR0LLHiCQesSK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151657; c=relaxed/simple;
	bh=APyDZt6Y7L2gxMiIr55aHEsxjZGKQxquPVSt9UP/YxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EpkkhaZjVIqfp1qnuHrVSESDVkUeisg5FU5v9R7mGsF7cRELXuVJKK+2wtgq/sZwxx5egkbwssrDONzJ0pLjSM2n2ak/15sB718LlM+A1FFo9E2NAeXvoD/hh1Puodetu0MiwO3xypMnJVwGbA3EVuvMSqSZRvDqtHiCpPgBNkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OD+1Qgh5; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilrhIWLE+Do5yX6yvlk4wT7oU/9AsgmZbZByTO7yXGDTufr/RF6Ef2a8MmtfccF1qlVAU1DkTsLr0UQ2OL44zzZINLKGPlF3qeFxW2swUNw0GRltxf2HleE3Aw7DVH3cPpJLjpDO614jbyHNEZWaZ2guDdBzMCHqR4v/I52ABYSDKXYWzpJl2gvdC2DkoUckc/vfSDwrCgq4BLNmu2YYUgQKB3wLOs1/FNda3nZl32jwk8ainD7u7zQEU/ZT5BRCGR5LiDg3wFoo/OL/bPrUqieFdJpOcwReouKyj+R9Jh+0Ok7NBgeHPsGGACttTp6aXKew3snEXdV9wYx3R7zgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtIBo7TS5sCx+bt8Hr+uTOA8Bk0QpbM4e7Qv66EhjbQ=;
 b=gPPtwrKCAAmURwKCM82QKiwCgqgylglLl5TLlYBPiefxGmsndq/hjS5KL55JvZvvs9Dv84mNQ+rP5urSkjeM7JKV0KlOw62mqCkjiKesSpXsrwaUk3Y+7lSND7jrNxZMx4Ox3W2tJ8PO4RGrrfHwavYO3jstK5xus4NV/RhSqiKfZLNxjunii/ayYciqsswCaofJ3cyaXCGwO9fuTPUi7EIeVYIb7QtfctE4OsHhUKcpK9aMQHDV2QJSKHPpdHcldZA1+hiYzGTot4jmzqkhLX6ufr9LmlZdVY6WMzJtNcfqovGQOd5EhP1F3JiAgyY8zMaIF33Tho7Ghqa8QZYMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtIBo7TS5sCx+bt8Hr+uTOA8Bk0QpbM4e7Qv66EhjbQ=;
 b=OD+1Qgh5yOuPl0lgt2CZ4DDub/ISZ4sY33q2HT4eJT5C9YOwwkcK1l8iYjyXXQvihNpgL+HWAhfBIuwjMkOIM/t1Mz3NRZ7icsZTc3Ps9MPgIcqwPFAH4PfxVYzVCYLrK7SYAuno8A6iUYCqLiYEEQzxqU5GFHrhbmFJIkWCXP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 19:54:11 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 19:54:11 +0000
Date: Mon, 25 Aug 2025 15:54:03 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 03/20] x86/mce/amd: Remove smca_banks_map
Message-ID: <20250825195403.GA300213@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-3-865768a2eef8@amd.com>
 <20250825181938.GEaKypOt7t1p8G-YkI@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825181938.GEaKypOt7t1p8G-YkI@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d2ce1f-3da3-4a8d-2576-08dde4112907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNoLj9RsJ/YjUR4KOsyIYI5t414SGxWMPsLCJQbbbiNK6NP1kQpp2/BAm3gV?=
 =?us-ascii?Q?1siJ5bQupNmoD80qZFjjUgwLHPZj8UiGcUTyNPL3PlkR8Z7z0kxxXCa3U3x2?=
 =?us-ascii?Q?E+brzmATCzNKR0meYWNR6duOpxzLwXMafuqUNNgT7WKtwHHhpo0V0z7vW5gG?=
 =?us-ascii?Q?6qW1BkcmLv+wrspdMECXWCPpnmgJcbl2AQjz4JAH5Wtcq+mfD+SGgjGbqzP2?=
 =?us-ascii?Q?S1h4BT+e15ctoM553Q6MsaSEe2nG4nzt0tnkveDUwMzC3yrtJ91RuWQnTvV5?=
 =?us-ascii?Q?OTPYxuqFA8QGjv1ksSqfmv4xdWtyIDV6icqKs9QLpKrbXFoHLzpWwoO4LvJU?=
 =?us-ascii?Q?8G6L0YHlPsqc4Gm8CmnwT9+Dsz+EBsKRK7y1yNxPJcLI0LMXQByLRvi2GUCt?=
 =?us-ascii?Q?5RwOMaXLksKuJ2i2XHMGwCj2NGOftg0JYYnQX6+TSFUpBOU0n0O0g0bGmXb3?=
 =?us-ascii?Q?A/uIPNpW0RKP0HT9zSa6OgOkjHn6dpIEGK+BDFE3dFtU8ml7MRb7qt9+vytL?=
 =?us-ascii?Q?+8V5jMAvXtIM5yrQAfKX00shrSKH7pTprVLqbfm5FWQHsY7piF8G4Zve6zkk?=
 =?us-ascii?Q?KVf/+LO7JRL19nPxeMJRXPMnp0gj8giiXWvX6CuP/PSJ/JXCc8d9HWlZms3O?=
 =?us-ascii?Q?noB+QgBXqlV6obAos+gPKa5XpshgrqNbe6KYbF3mpayWtkGJA1eUJW8nZ6Ct?=
 =?us-ascii?Q?wB6x+oRJXGutiaMbGRqhALrRD4Nlp1zyKFVFlw640tmEfiqlI1nUOTxswu1r?=
 =?us-ascii?Q?sTTIgeuo3AspcFL1rVZynyia3WIVt8d3s1B6OoxTrX8DZzlj+gFmmmzkY3FF?=
 =?us-ascii?Q?CZK6gZqp1UpnPY+s6OEL+hWruNcOPdeSDLBgQB5I6lYng2aMSsqFcAiO7Uun?=
 =?us-ascii?Q?J8IG2wTDGbzAgWPZJbIWkxaOYOHB+2kNUpMy9t9vK4njM/oMXURbgBhCgcDd?=
 =?us-ascii?Q?1RSYthhUce34n/nMvwZPov4HR2VGd+HNsaqdWXUGUkzdcazvmEeJ12BQt9PH?=
 =?us-ascii?Q?ybV/8BNbBEdbbN6ag9lO9ZvkIaoB5i6jKdNBjyR4jRsipxSF7f2mS4CXtHsP?=
 =?us-ascii?Q?oM/YPPU1YQDrnaW4t8BoJADWBcalyGFeVq/hMiNelHdxcIOqBLr38ugo0GvK?=
 =?us-ascii?Q?U5JWgBW8fAt9c50Lqm7LVqp33Q5Ej5JOcz3N3Zd/ZxC+lXHyU+iLPDkEXw5s?=
 =?us-ascii?Q?YSA2IEY1Lg40aZHMeyqxSSWFZrmJnuOndl//XrB3gZ4XPsEJRY44BfzbhpuP?=
 =?us-ascii?Q?82UupSIHSoXrQZWeWjZWlQ3VAQsc2/Ky9WhA88/3sHKLuaC44JmIKY5mVHfU?=
 =?us-ascii?Q?dAp1aPoVjsIMSbKj7vTRPJLQfiJcQzxS7okAiCXdVQni7OkpRhPERJ+Ej95m?=
 =?us-ascii?Q?0hmxgB1VX/YKgAdTeJcoFzpvioHFS8gIAgbDE/Jh+GTfYEbJY4dQVJN6p/W1?=
 =?us-ascii?Q?y69F+ETUFbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZlI7Ka7K/R0RbDnE11DgWUl5b8OXLu7UjmuBVWlXlKDE4ParYwZvuPyNCvq?=
 =?us-ascii?Q?m1OBwCtuLHHnQi1OJfGbr0OhJd6KiUjtsoVHQUXHQAcDP21XzHq7RvhexJR4?=
 =?us-ascii?Q?2049RfBxXkrtvKFSV26NNly6mSKibgXglnHQNvVyjylsB6vqRLgLwpk2PeoA?=
 =?us-ascii?Q?wHimkoWI51GiXJkOHkJE6JHiUaAweb8+NDhlwqpLis4EQ6J6y39cWk/fsa1g?=
 =?us-ascii?Q?wu3ej5kAOORDZow54JG+NLtwNS2dYcbttSRQHb0amkWx5Hbm3a2U4GJE7e9W?=
 =?us-ascii?Q?eEUdpYgODqYTEaeumhWcRaLNXxqS5ez+JWPNvwlouW7Cn6oV105ktUOUCCVE?=
 =?us-ascii?Q?+QLv2VFR+u5Nc5Q2r4xog8qMP3tRDXgae55USED+jc84GrmtpR6hs6iz1yh6?=
 =?us-ascii?Q?Q99BYsf3w888M3FMN35eEksUjuzKx+Zs1zSpZjmbxk2FqFXhbcCXod3uWkql?=
 =?us-ascii?Q?OcKMh5FIiCxHFOkXgBpjr/qMINOgk5nqhgRknCvPq08jVTHUZf1Pcd1WZMmP?=
 =?us-ascii?Q?8ozGtJNtUxAcAM1X4kkvwSWLNbX2pu0a0eg5Emf8GgJCOP5+SwND9k/RovhP?=
 =?us-ascii?Q?VtWzQiOZza39TmSbhKi0h5YlzF7oZOawHnOP/JN/vbTJoUbUL/vM1IOOtVzG?=
 =?us-ascii?Q?2nmHomnFbsz6fQQhuBkevbCYs9ajdpKkpimgTA+1ErLKRBcX4aw9ODJbMFgq?=
 =?us-ascii?Q?pk5zgQggggVagTkyV6ulcpLpShMfEo6sS6KgERoTieRdpRGbXO1qQImbXeaR?=
 =?us-ascii?Q?n1MWHTtLAYgotk0bnDGADLUNyqvex8fnXVm7ARSPmhLQpnzvqSERWIB5Gwx9?=
 =?us-ascii?Q?Na8RxdJ+Kzn/OGY4eDbsPiqfaYClVTGSFSOUccujI+/Rq/0E6MTRddZZ/1r1?=
 =?us-ascii?Q?yJLbMN499ooRGmRjs1AE1smPvkfM6t26TE1KD6UVC8EbfbVUdcTguziH3PzI?=
 =?us-ascii?Q?wQf078gP5uVNVqnsj2H33vI+xCnADUmucxAxbV/kqukHbzYEQ3YiCjszZuHZ?=
 =?us-ascii?Q?0vfWa43JRfecD3VkwuWvff6C0B3DHOHhfuJ11INiJeNKWlH+20pVsvzUnXI5?=
 =?us-ascii?Q?bUDF5J9W28oq1r6yjE/aAHQaLY8fv2PWbX3BFJswE+xP5VCblruLVqe5Fksb?=
 =?us-ascii?Q?5J1c7wuKEuJIOneOHI7ABZ5//RKr7EqDQWEb50OFkNeDTjpKcPVsTaDR3fNv?=
 =?us-ascii?Q?sXcs0XFNdFxrp+h9Iv+9Se5gJnDDOKPMkkpyVFd6HSXyyVQ02N+ubzxCtZee?=
 =?us-ascii?Q?+YWsOVAWKEM2zmYiOIuDxTBFXxVXxIXT1efJCymQU8z73WKj8WlhO8yGb5II?=
 =?us-ascii?Q?FGF1iem22rp0lgqD/IGR5Clt9LxG7Fnv4lp6heYIdbAX3lCvUYR4e+WlCX+d?=
 =?us-ascii?Q?zAMhF2q8WFltC9DF2P7Zrt6JpRc4Y4hkdn+SbMvgfjRyz2woTVv6g/5ZDtJm?=
 =?us-ascii?Q?DhsS0QSoRyTmNh7f8YU5YzaQf5CYblHMmyMdHHWq5EaUxhGCGIIO9CEv26dS?=
 =?us-ascii?Q?e/QnzzRv2Tc+bviT02sd8hQ3wQWvn/VDRmw+rEKSjyAG6ozsfgIfOX8Nmi4L?=
 =?us-ascii?Q?9+kl1p4Krc6OgwKhE1KFnaiTc7JETv8cbuHJ5nSe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d2ce1f-3da3-4a8d-2576-08dde4112907
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:54:11.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqApRbxyHfMZ2u9fG5Kpiu4/M9g8iFt1iX2lftRI90W2xZzhUDPXiEdPhlteo5yjw2T9f/7mJQUbZEzu3VCPKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410

On Mon, Aug 25, 2025 at 08:19:38PM +0200, Borislav Petkov wrote:
> On Mon, Aug 25, 2025 at 05:33:00PM +0000, Yazen Ghannam wrote:
> > The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a
> > register offset for the next MCx_MISC* register. In this way, an
> > implementation-specific number of registers can be discovered at
> > runtime.
> > 
> > The MCAX/SMCA register space simplifies this by always including
> > the MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to
> > indicate (true/false) whether any MCx_MISC[1-4] registers are present.
> > 
> > Currently, MCx_MISC0[BlkPtr] is checked early and cached to be used
> > during sysfs init later. This is unnecessary as the MCx_MISC0 register
> > is read again later anyway.
> > 
> > Remove the smca_banks_map variable as it is effectively redundant, and
> > use a direct register/bit check instead.
> > 
> > Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > 
> > Notes:
> >     Link:
> >     https://lore.kernel.org/r/20250624-wip-mca-updates-v4-7-236dd74f645f@amd.com
> >     
> >     v4->v5:
> >     * Keep MCx_MISC0[BlkPtr] check to be compliant with uarch.
> 
> I'm not sure I understand what that means...?

I completely removed the check below in previous revisions. But I put
it back to make sure we follow the microarchitecture guidelines, i.e.
the procedure(s) in documentation (APM, PPR, etc.).

	if (!(low & MASK_BLKPTR_LO))
		return 0;

> 
> Anyway, some more cleanup ontop:
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 580682af432d..7e36bc0d0e6c 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -498,17 +498,6 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
>  	wrmsr(MSR_CU_DEF_ERR, low, high);
>  }
>  
> -static u32 smca_get_block_address(unsigned int bank, unsigned int block, u32 low)
> -{
> -	if (!block)
> -		return MSR_AMD64_SMCA_MCx_MISC(bank);
> -
> -	if (!(low & MASK_BLKPTR_LO))
> -		return 0;
> -
> -	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
> -}
> -
>  static u32 get_block_address(u32 current_addr, u32 low, u32 high,
>  			     unsigned int bank, unsigned int block,
>  			     unsigned int cpu)
> @@ -518,8 +507,15 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
>  	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
>  		return addr;
>  
> -	if (mce_flags.smca)
> -		return smca_get_block_address(bank, block, low);
> +	if (mce_flags.smca) {
> +		if (!block)
> +			return MSR_AMD64_SMCA_MCx_MISC(bank);
> +
> +		if (!(low & MASK_BLKPTR_LO))
> +			return 0;
> +
> +		return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
> +	}
>  
>  	/* Fall back to method we used for older processors: */
>  	switch (block) {
> 
> 
> -- 

Looks good to me.

Thanks,
Yazen

