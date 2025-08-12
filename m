Return-Path: <linux-edac+bounces-4564-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09836B22B54
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AAF3A59BE
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A952ED141;
	Tue, 12 Aug 2025 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QmWWycs9"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0375184;
	Tue, 12 Aug 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010612; cv=fail; b=VkWgfnk6zmPn/+igWHypr5UhfPlXh3rsw1zOSr37xbxrJjZsHNQRjh48IxoPC0aMw+07beVG9+LLkG9ozLH4r8a2lN2B6QEWiLCHxYuwFHGFu69C/TJ1HdcJhVr+VTekZarlWVSIPby/LQLUs6eCv0iM6hZvV/Um1Z/qVPozkLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010612; c=relaxed/simple;
	bh=Z8cT9Jygwa2RxKTi5hdDHGeVDNsU1tl8M2N74GgoGNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FfwpjrX78Qm0hFBwsMGBUzZl8m+4WpRTblS1ZDO4GAXuBdGDP5yMIgLkgAQAPO1ar2wRH8v3XgMTlX088nPsWhGWAd6YGMOVJSVH+WId5KCe0BzY8jzUQtR+3sd2+/orff1UfipVOUcClg8GGigP0mQyKh9X3IW5+tn7ZCrMF5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QmWWycs9; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/i+h51aJftm+9+C7ihcOwDfq4aYB/ECVCgzmJonZPic7I3YdnRhwA7idMQgGDl68mSGz7s14DI0/955PEI8G5wf0qN/KzQNkptX0EZw16XYo9d7dpKibpHHMNneRGCPYHpp62yWqZWWHFiEE5t3HbRaMtMlqRATrPupZCZrUKH6m8gVmMLhbUiM68F6dcupcXX0GcUJ9QbpJxOoSX2mx4M6XL5hDbe/xAHo/79F3oGX/ZtWPL2jpTyzwaiBI6hA2fB9bDo4+2a5AKv6PbkldD1ljwpTL4hfDL9IAKj4S+HWu7s2ZnzdH73IWm9k0Ku9Uahq1KDBNTPzMkSc2UasaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0IEKyQUuTmmwT6H9QdibFqis9RO/ApJQe9gSKcD/X0=;
 b=GX+EpNSP9RPha3zNEmy0xeSBLweBzOJk1FERNzVTh/FTSxsYFemWyT3GVhn7o0YCWWcSAlAudfk6wbgxmSKzha0Xq1+Wm91CQYl3QVxSJkWVz7/uG6gw22ON2AD9vHooXzfvq4UKxhiddqFkXq0IQY48f5zVTkfl8LL1D9gmaZmJ5E1+mDYPrENiWJV4A45mvFnvQO8rz5zSTPMbizzj8sAFZIvGZ/8wwgeHq/rum798vV0B9ORvNpkoLHuuyMBbWYtx6rjgZEUjtw4ZeYGW30mNhOJoQ5nbrs5k89pwcX+ZN9mxYDKs6DoQfB+Fi1SpHz1W32My52k2Kpsf55/DyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0IEKyQUuTmmwT6H9QdibFqis9RO/ApJQe9gSKcD/X0=;
 b=QmWWycs9vJUKY7pki75FihUdWhPiF18bAEV809eygWwUst17LvRonHWlTOFt65mcpr5SoFbDUTlMF/MgP7Lex20IZvbCvH5XvDV19a6NSfVi1tuOk6pWkLT3FTjj4tpdw/SE4z5SLrEPWmfTsCkHgv+vNffwp5c4sCNSamf8oqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.13; Tue, 12 Aug 2025 14:56:47 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 14:56:47 +0000
Date: Tue, 12 Aug 2025 10:56:38 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Use ZENx features for Zen IF quirk
Message-ID: <20250812145638.GA383670@yaz-khff2.amd.com>
References: <20250811-wip-mca-reduce-if-quirk-v1-1-4e0f24d94872@amd.com>
 <20250811205529.GBaJpYwcmMfEFqEicm@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811205529.GBaJpYwcmMfEFqEicm@fat_crate.local>
X-ClientProxiedBy: BN0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:408:ea::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cb846a-e173-4427-4a45-08ddd9b075fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sTK3/XOVC8oKGjySh7lz0/aAaSVqHJMkJBxNw9Hvk10XQlEoGaj28W25icyH?=
 =?us-ascii?Q?QVm//bpFCwj9Y1fWSujXGaEz5C8yGTBoaQdJ+Vf2oqW5K83BIDaKh0qFCrt4?=
 =?us-ascii?Q?oCE1nHyMi4Ixo0Q8GWFejJsGl1GxUmf6KUkWTDLp+nGUtUwBHVotO6rHylXq?=
 =?us-ascii?Q?OPKQl5P64udy7TyprMyaOwddHW4WgHV2bE+nPtbbA2i6sBQ35dP1Ybx+6F5m?=
 =?us-ascii?Q?862q+m+bFF/QIGtRcX0Pd3p0maBm8Uqpf2soB9qM7SfSZfPYLnXSNADllIi/?=
 =?us-ascii?Q?avmBzGEiNRmpsAHVow0+WCWy5T3cGpELdlCahgHbQS103L6x7xyK/RZy5OpS?=
 =?us-ascii?Q?Xf28CnT0UM2GhalEkok6XUZ3lpNrfwxQ7/NFUsTNxrFvQimbsVc6w2CHTT6A?=
 =?us-ascii?Q?ZajMhfoBb9nO+tCDB+rEv3aLKLub50N207ZvbzbBKdOk8QMSkBq2B/PcX3od?=
 =?us-ascii?Q?vLrUPzY9YrGqnKXtlD9ImvIiLdhjMNfY6jQ1mBmOBPEWohNemRf62qMizIpQ?=
 =?us-ascii?Q?whdrJVuu49oOgUZYSeNPFBQXKg4UGpo9OOd9rqO7ijpGpXorU3NXVyZXJTG2?=
 =?us-ascii?Q?BtzcwCnkF7s0CDPZKoLXyhj4ogPQ5Uk6YqycVWfXWhcrcqG4nw0zUd946W9I?=
 =?us-ascii?Q?sl3rBukNX8pkUumPKxeQOzYSE1KykB1jFWD1UBl0ZBJAG1nbA6SDM2kBBGGF?=
 =?us-ascii?Q?qEwdzXgX9Pp7CKp/5JYBRtZSNBfzjZLceQh+2xRFyXmepJFAGaOb9hqTckBe?=
 =?us-ascii?Q?wRvaZ1jTNBbnSdYcJlLs/ii9YSIcwLDKlrr1Tn1Opo0htPx2/PObBcBmC+jC?=
 =?us-ascii?Q?d58aZwptnBLaK1014Es1cIWlroojM8kp7O/Tdy7/KdG3uor7FY0N8wdegiDV?=
 =?us-ascii?Q?155GqsUis/sGpjxx55i0IzWyuj+JlhjNnirg9Ig3HYcS6feaZd8+jg3ljJgD?=
 =?us-ascii?Q?LHKGFuyBHPF79OkR7AwOW7FvKKm38hQoRFiKWOM6fOES2yjD0lB81kdFCaig?=
 =?us-ascii?Q?QIgXejhan8CLX6c6+dbXH8UiveyFNH+x+I3zxrpvptsFhEsolDWg34B/9BYJ?=
 =?us-ascii?Q?cxknjmT+Lr9phpV0xqde1dX2+gaZAx5+Qj/+HMQ91AeKb01cnZ8u0JHKy+D8?=
 =?us-ascii?Q?dxc6UfMc5DNDMxHk/UC6I33GVGGMREdKE98gujjUi9yGuTmFYn0P/xChduu9?=
 =?us-ascii?Q?pV/gNIePUZsOHqJG6rN0fsbjg/+r2gBONNBomU0Ev+rbs/8C/pxRZnZAoBFK?=
 =?us-ascii?Q?35XQ0S6nZbeGFM6qevXyYG6Kb+Zso2kRxo0ibMhch2mIDkNvK3my5l3+MznX?=
 =?us-ascii?Q?C+VxWO0wOg9D/QDU+1se4JvnZwuCl+NMGmp3GPRb31nmlE2AqU5XxR0jVS+O?=
 =?us-ascii?Q?sPF7V9m4zfAgIPUTiHrC3mVKBl5PTzpikwC6+NkPn+r6V/BXX0HbNBMOX49m?=
 =?us-ascii?Q?ZTdfjwMQHz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSnvucFGmdjsMP54evYGEuutQzIPMJFj9bfG3f9mV/cTBj+OyB55tvUgQozx?=
 =?us-ascii?Q?HKO2He8LJ5HMtDKzxWTGJlk48e/sh3xdfhBLmgpPtFS0ss/A6VDgVWakuyFK?=
 =?us-ascii?Q?V0iFC6QyADYjdtL82kZqZJO0jM3MZLBfQ+Vc++lPloNayAb+X4aIgkMXA3Wa?=
 =?us-ascii?Q?Pby2K1oAvlDXBYQspkx8/58TU3tsrcD4xpeWQOW74uZ0lZRHPXDBCEdcIKMA?=
 =?us-ascii?Q?0XzZ7jiWkCF0dhr0BTPvakjqkSnG8t9CElOHHKPS7ZkTBnwndDQc90nNa0LF?=
 =?us-ascii?Q?cq3dqWfJvCnJQd+915ejEyo18Wx9bZHIPsCD/lX3t0/wCRmxMbV6S6dyRBzY?=
 =?us-ascii?Q?2qwMDXoXDJ9QQGmAtFkk6jBD9OPQu+dqFt2Xvzy3sjYYwOrLYhlt7Y9Hzzdz?=
 =?us-ascii?Q?4478sitCw4djHIqcQc7mJrqnU/kaZh86gCrpTGpsLowh59lmSeylKPhYs9mm?=
 =?us-ascii?Q?0Vx7Osp6WmnAnw5lQcpQsLBnJecbi/aG2JRej9YVj6Fqcmt8Qga4G3RsM/fZ?=
 =?us-ascii?Q?SvD1boD9xHv27Xh1MpECQqVjO89LkNEz/axH+d5lopjkX0443cIfGABdCKsm?=
 =?us-ascii?Q?QFzZiv/Xt8431tum+QWHsSJ70XHcy7CoPnMJaMOr1fHd8MVaNQcqpvg1Qw9c?=
 =?us-ascii?Q?MYoZCaXgRbIDwOKjsgrCEmJ78odLKOnGiWxRgvKWidh6wvpuu0p8hRYZZMyj?=
 =?us-ascii?Q?Z7nHEd0liKT4aXpK3k+QoA+psZZ8M7x1yZmzbOufgDO2U110qO6/YuC4EJjp?=
 =?us-ascii?Q?/U/1WLcwiVQ7NSOoIOHKyIpieJ15p8SQnjQy8sGxmztNAJYnp2jw5wjX9Obe?=
 =?us-ascii?Q?flsh17x9jzquB32ZMSRDV8iDl24S635rmeX9Yfem0aqi5FozX2pXHq4WGcna?=
 =?us-ascii?Q?UGiVktTUNc4UPEC05rlrwLqTWOuspWSquf6VUsatr1ggttgxJphzNRpXziP5?=
 =?us-ascii?Q?fzOb+BfRBkmXoYX1rPY6+7AFVpoBxf1TX6lilMGzRYHTo0x3d5ZJpYCyVnno?=
 =?us-ascii?Q?JZioc7OC14p50vudvrfa/VmRQ2v/AxHI351MmCWMD8nfhG4w6DIoiTY2nw22?=
 =?us-ascii?Q?TueoJksFl/mZXX3zMDNNN5LYbnmZwVCMlvDRh3Ut0P5CvSmlbzFslHVCiQ1w?=
 =?us-ascii?Q?Cf3gARrsA/J5eTyq3JqKkXiuzanTOkM68hL6HZmbMEW8IxV7V3XvX2/uKGc6?=
 =?us-ascii?Q?JG16MLEZ2glj5kUO0HJeciglA7/LSDlzSjywm4qaqi3Q+rc4rcFkGPoPD009?=
 =?us-ascii?Q?BJTB0dSmKk7/8JHPHRrIlpLt/uKUqjZs7lZejH08PFli/Ozt3Jhrpsc6yyb7?=
 =?us-ascii?Q?EUyr5JJKw2f44c0Rtk7Tobpf/NAPjMCPEPKPnmko0JBclrGnonp6a1GpQEUc?=
 =?us-ascii?Q?ULAX6X5RGqcMaMJQbELylcf09fQF6R+uCnPEESlT90ZcCF23nbge8k5RcCgw?=
 =?us-ascii?Q?RfFBoHkRpgynNi9sj6uvPviFctXs8mMQphzpquwaSRwz/cwo20Kb51crHioi?=
 =?us-ascii?Q?vyNv0E8bKP1cKhK/dBzdUcFtSo00BokHWMtf262ccsKrVLukZ7D0aAORMgG5?=
 =?us-ascii?Q?hFuiNqc9d7uiJsowl1XMWcOFBA0z6zJnHsi9ZAM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cb846a-e173-4427-4a45-08ddd9b075fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:56:47.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezRvceMyrYoHfrnuNtrrVBJvMDSG0bI/2AR3eo5M31oQRNqGfCLYexVvYzhjMNAHgV/gk/FsnfI2SdRGe4nNbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

On Mon, Aug 11, 2025 at 10:55:29PM +0200, Borislav Petkov wrote:
> On Mon, Aug 11, 2025 at 04:34:08PM -0400, Yazen Ghannam wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 4da4eab56c81..0ef164568077 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -1951,8 +1951,11 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
> >  	if (c->x86 == 0x15 && c->x86_model <= 0xf)
> >  		mce_flags.overflow_recov = 1;
> >  
> > -	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
> > -		mce_flags.zen_ifu_quirk = 1;
> > +	mce_flags.zen_ifu_quirk = cpu_feature_enabled(X86_FEATURE_ZEN1) ||
> > +				  cpu_feature_enabled(X86_FEATURE_ZEN2) ||
> > +				  cpu_feature_enabled(X86_FEATURE_ZEN3) ||
> > +				  cpu_feature_enabled(X86_FEATURE_ZEN4) ||
> > +				  cpu_feature_enabled(X86_FEATURE_ZEN5);
> 
> I was fearing this day would come where we'd need something like that and it
> would look gross. And it does.
> 
> Can't we simplify the quirk to do:
> 
> 	if (!m->cs)
> 		m->cs = regs->cs;
> 
> when X86_FEATURE_ZEN is set and that should be good enough if we squint our
> eyes hard enough...

The quirk doesn't apply to all Zen-based systems. Only the Zen 1-5 are
affected.

We could *not* do this patch if it's too ugly. The quirk would apply to
some systems that aren't affected. But this would be a NOP in practice.

> 
> m->cs on the fixed machines won't be 0 so it all just works...
> 
> -- 

I've been thinking that we could do away with some of these quirks if we
refactor a bit. I'll dust off a patch I have and send for RFC.

Thanks,
Yazen

