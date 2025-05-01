Return-Path: <linux-edac+bounces-3801-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E862CAA6240
	for <lists+linux-edac@lfdr.de>; Thu,  1 May 2025 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD33ACC38
	for <lists+linux-edac@lfdr.de>; Thu,  1 May 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D802214228;
	Thu,  1 May 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ieRO/Wh"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C520B7FC;
	Thu,  1 May 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746120229; cv=fail; b=dTk27DCrm8gLGaHJDoS2AL/s6XgruQ8wx3wEm4WEa3f/S8KiVvt3HIh145+bxIhVQ2B7QYKVp0wxgbu5gqT8Z33/8T2CcaXszD4ILBYQt2yKy/wdXOMyD9rhmMNRuDwFN9KB8HDxL8mFf8IEVzaAjO2wWRWD096Th833yzlAJW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746120229; c=relaxed/simple;
	bh=vZRPz8s2LcYJxcfezGel1uL/xFFMuN/w30lNBVnRMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FyBjByPpb5xMFbQSF/VgABY/ZYhXBt3VX3RH4tBLRzeb2KK4a1m30VPyZoqIKySsUwhhWgCMyKECnzRY+zTN75Gv2PqgL6aLtXveQpg3KFf0Ccl//Hrme4LW4jduOqPn0yMKuY1XzBgv8KAQaUpb0uaoy+RV2NLDbs03YOCypDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ieRO/Wh; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdJhSNiG6pAzmu/XAAOx0TCQfOOJKb4GF/Xcm8L6VZ767A7io6TxOg6qstdAMcf+++/6iNG6hNLgR/iPXUIZActjpQLrqsltkB38lMYC2dkub8m2jPnYfmvCUMwt23dkGXCDMusgE1QlD/dFVHUwSuqE/Q/9tXHubMDnKPfqAjVMT36NS9WmJDREEz3+Q+cukX6SpHdY2BDO4C97npPNBxjqmCd5h8rK0CuGQEjGUwR8LxuowAHyflat/ahWUNV7j5zp7H1Ubhk5l1TBcfe0cMVJTQjJcdIH5k5zog4gXPWnvd4XmHsmXPG/yJi2EPopqsFo5zKk1CYtkbcwicJ4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PV/qqQWjL9b4sEQAFKvEvgfD563YUKjwVYL5DbBX2I=;
 b=cp/XjcQGFpv+/9Dxbq4PI2+L9rmEoJPnAAxhyI362Du7OKXDCNXCIIy+JhkQGETRk/Z/RReUcLV8lh8aXd6ZXRzWfDUymvHcNSqYkZ2IsxzmMPUto5+9m2a5J1+QHeA3PY/8H6ToLo+RPubHmyRelq1f2forF1/Jb9L6iW/tBBPmDjxQ+ie2c5VQIyHXZzYKVRnBamm60w8J8NW/rWvPiyKr8NlM5lAGRArrQ7MlR7hQs582yVWI8UWdXSqoGe9Qn40F8Lb9UoxkMOVRoNKMZNiTRNuvq4GwJAdr95NTxGMjoLgFdkEAru2adby4af4+8UVhEFVEwSQi8JaLF31Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PV/qqQWjL9b4sEQAFKvEvgfD563YUKjwVYL5DbBX2I=;
 b=4ieRO/WhJeQTjzBUY8syqwurzyYRfLuUAnaYokGDMX1CX3ndu68e3AsYddDu94bnXS+H/XubG8Yl93XyxEhzgG6YSZUfAffCBjEOVXh46gYFgv/zMsGehUGWzs2tNJUsljPvDER3H2jOcR97zJh0oaYr+/jZioJvHd15rhF7O7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 17:23:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 17:23:44 +0000
Date: Thu, 1 May 2025 13:23:35 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 10/17] x86/mce: Separate global and per-CPU quirks
Message-ID: <20250501172335.GC79372@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-10-8ffd9eb4aa56@amd.com>
 <20250417121631.GPaADxHwT-OrriCFU5@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417121631.GPaADxHwT-OrriCFU5@fat_crate.local>
X-ClientProxiedBy: BN8PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:408:ac::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: d35fd67a-6c14-49de-9fe2-08dd88d4ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GF7hEJBHAomCrdzQGnWFEcymMxis4fD6AVfNSs0y6rqH2IoMryCtSGhgA23x?=
 =?us-ascii?Q?4idKi++voaM0KsjhEBEAIjJIUDlXaXMQzG8LcZFV7jMYmekpLoFN1uDNdHKQ?=
 =?us-ascii?Q?mt95MxA80FJizlupj/d9vO3cnEbVZ2vmP/NCZ3P4KgwbM/KRNNS71g0AuBC4?=
 =?us-ascii?Q?nZ8y5Bg7YTqGco8ctnDQYAh1MRGu+9XzSPAZY4d3QsUUElJzirinOHAuD/sS?=
 =?us-ascii?Q?eZfxhYuHAzs6cw2Uacwt+UFJyyGCHi7bEJ5rd7Vn8ABfesZyVitLqQMcbzAh?=
 =?us-ascii?Q?pwqdjtj9KhYZJ0sn26hq2uK4eSLGTZXPclXnEQsNqngN/wVDuZnxO1m88nQv?=
 =?us-ascii?Q?fuvoRaiDAJsR0dzfO+e0NuZj7MbyBtXXCh3mvW6IhJhggEiR36BbWp1avwaE?=
 =?us-ascii?Q?o7jWe/O35704gdeuKhsmAyfByNYLX2PMM2ZPxpQTF67m8Po4zhqemnzhVieV?=
 =?us-ascii?Q?WhPz8MYhzMhpMTjULTj6ioP9swXJCYQvPz1lFH+2E4a4K1MoxMBSod5havG1?=
 =?us-ascii?Q?8eKzo9f5hQ88fEUCX7YH3ix1v9aSHTGK/P1ccwuOgNnR+IuC5Pbh/N6vsaaY?=
 =?us-ascii?Q?XKMESUxDpZSkWPEKJ9vRTdJWYsHs2ZaHUWDAsTn6N7Yfe33sjFXWqy/fN9GV?=
 =?us-ascii?Q?KTQCvfu6+pJnxVFR9ZgMY9q9tO3Gqj/a2vq2YM7bLGQ8kxrusmVC32AyEt2h?=
 =?us-ascii?Q?WjpfUG7335a/9JE2ukV6xqlKQe7fISVkWAfjajj4Gs3rbqHwIW/iQ/9FhbxI?=
 =?us-ascii?Q?iJdIUWJrbrSXuc4qV1kmjW0/Kivb6Rq9Af3rrTWsPiljFX61YGefnIK0ed5y?=
 =?us-ascii?Q?CAMRgtxfJs3vs/5qmpYV5v7002GUVrAwKZhdK3pAktPXCnYpqk1iXCBbgjUp?=
 =?us-ascii?Q?NshUJQn+RruKZr1xi167Kkk8tbcXntY4mGP74S6GmRzjNKwjTcSC8Tg5X8mK?=
 =?us-ascii?Q?d3D08aLxDhEYAMgp3HEMQODK5Q849wkbCrufHRh2+MZSYsNvqjE3FVSIZ+r3?=
 =?us-ascii?Q?XFuU4VAGrGXmrlwQSPa63/n+0BNstqafCZZ6ep3YJxSQHmgHdB6XaSOT04N2?=
 =?us-ascii?Q?B2ZShsWw6HLxq/Y3Tq5sl1pRF0E0B6CRvNjnYWTfbAh74LHoP6l3gq6DnUmD?=
 =?us-ascii?Q?3cIs2GkY5ibz2FvVCc1mwfTpnqWfATRLhi5PVyQCPCXGXa1OaYXWduO0Uipk?=
 =?us-ascii?Q?9ZuoUul+lXEVeTlYXdWpz4WvCkjb2Xapium/WfZnDkyjYq6oszWRy0KNm+cE?=
 =?us-ascii?Q?nYVmuP4eHrU2/dJ8kibU/QGuUZoEMftT3Pd2lXr+Wyo3z2JE2q+5aWOm2hWW?=
 =?us-ascii?Q?H0k+28u0nOGjVV8Ykz50Laxr2vLX93wdD39CeLJNwHoqSe7OuWq7MdJOKEVH?=
 =?us-ascii?Q?87q3mueGUdnTQ13bKwFZ4eBTUAIu/KgEGnTI5sElX3MQCV0C6eeaPyoEZ9Mp?=
 =?us-ascii?Q?pUvDwcBooSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OPC8H96Pfoj1uNsy9an2g7uliDWARjjsZit7GifICIq5e99JO1DccuwjR4x?=
 =?us-ascii?Q?fHwy3kG495ZtFDXhNc88Upgiuq4lNqm45bEJZqNFkdPxykd7CYKrmOTjZDaT?=
 =?us-ascii?Q?J39NEjcIJ1SLdMP0wY3Sz3IS6kPKNPDF0AoEfIqSjFrmnKHGvlWiC9S+ZEvk?=
 =?us-ascii?Q?Pt3W+4bdc+RuX0/UNAYWmBo8q+BSBypRFz81TkFCoC58CzCOjgAcZFujkXbk?=
 =?us-ascii?Q?888X8HHAEhj9ZR7eIO3J470yQfvOsfRAeqTdOt+RVVHwLN+gACeHfYzK2gos?=
 =?us-ascii?Q?eAjGbmK7dYBWh+pZaCOice+Uq5vipDh4B9XDeUSz7P01xUowwGZxQ6bl+VIR?=
 =?us-ascii?Q?aK6K1oYwsFZN6kTj6lkTpClp9DIEWU4FQx7t2O/y3Lt3V98AxAJ/AiNZYZRR?=
 =?us-ascii?Q?oE0+QSLoplzFIdjqPU8jtthWVojHJz/r+lXNZeCyOKnMnfGzaiUFrqikQhz+?=
 =?us-ascii?Q?LR4lwJxcmOZsNCWwb5pZfXhk0/nWInAoGKr6xlXlfJANXxGhFQQSYueTm9Yc?=
 =?us-ascii?Q?5OwkBsfUnPAaift+UgN1Zt9aElK2IKu8UZ3CUPFYm71DF7ROPaopcaz/1Ivl?=
 =?us-ascii?Q?yVBDv+4h6JMV4YJEqRO1peqQgHbVeR+iqnue62DZlFvGcJV/7FPm20ZJtYpR?=
 =?us-ascii?Q?2/g/gbiRradTmLWPphAhDeRK8CTWx1O544lAcLvjdCrLGjJ+wQKVfXsio7Qt?=
 =?us-ascii?Q?/hYM16HCFtVt9G3ODR0GQpV7u6tU3KtW6dLTQZthiT34M3a9x1spdBSAM9Kt?=
 =?us-ascii?Q?3QNEtlC1HQs/gMwDrMxDcpAfEKULO2seilHXFkY7IwygkRsVLeIthrLZOYKH?=
 =?us-ascii?Q?v8LYIdWR+mK4qyUzdx/ryhK+0DK2agifby7KzfgzIx9T39/BzqUCATuf+WRV?=
 =?us-ascii?Q?3JZBGbsA6Y3fq/ejzOpXFEfNo4RasFAo10BnSfKXhqlo0qA8E4+qsg5pZf1B?=
 =?us-ascii?Q?sn2TlgdUu46ZHl6Km9O14mJMx+LMDGhq1ripfq1aAUpdHcx8BGHg2Pxmhflp?=
 =?us-ascii?Q?2uqoTVdY0TLng5PaAO99r4LfTCKPO14sJLMN0H0SRo5I8037KYYXnRZMUbbw?=
 =?us-ascii?Q?UsozztF/vH7tONheDOJgtwG2nn82l5oFS4QtPGQUD8iPG1UaRtfpdcnuspn+?=
 =?us-ascii?Q?DmMWlvVWHwMQLdOueTvLbGRkvArdFSSXgXR2v5nk/EQDvNa/Zp8geMXF1p25?=
 =?us-ascii?Q?dajhWyrKGSbcadZopSurnS+ltS/FhU4YvppyA8H71GMxQ64s+eMDy3C8UTwU?=
 =?us-ascii?Q?6vvRaTHVjy0jS0c785q8GH7wUZt6+ZKHlOn/7/f//UgG8Vu7+Q0k0IOxCTjF?=
 =?us-ascii?Q?LYE6Qsnm3QN4DAcXxNFUf3T0s1kHAsMTel7zUi36sE5zCP7gpfEwSBeVXUiW?=
 =?us-ascii?Q?dYOKtbAmn6DG9BwnCuywqW5twXkZ9GwYUDumlavD/VLDuU8Ue2XSeO+iFwLW?=
 =?us-ascii?Q?Jny9d/tZa5vmH4bXfDad4pqMs11xop4OFpD4Es0mPt05FWqVV3QJ+c6+eKcu?=
 =?us-ascii?Q?MtAp/yCR5djsQ1b3ovgroNtwTRKGpoHPLp4m7YFNcx0xzDAWuV/bF0hFR0rO?=
 =?us-ascii?Q?LqweNAyecm9w0lYSNsEj+eJ5AJlYmcJ8SlRco4ti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35fd67a-6c14-49de-9fe2-08dd88d4ec84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:23:44.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tltoQJfP6Tu8D41RtVPoAvbXM0b7bdZMgUzwcejxKNSjMUJBpb49eCQZo3OWbgsqA15WwVbuwxXk3O+IHWD4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

On Thu, Apr 17, 2025 at 02:16:31PM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:05PM +0000, Yazen Ghannam wrote:
> >  /* cpu init entry point, called from mce.c with preempt off */
> >  void mce_amd_feature_init(struct cpuinfo_x86 *c)
> >  {
> > @@ -656,6 +678,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
> >  	u32 low = 0, high = 0, address = 0;
> >  	int offset = -1;
> >  
> > +	amd_apply_quirks(c);
> 
> <---- newline here.
> 

Ack.

> >  	mce_flags.amd_threshold	 = 1;
> >  
> >  	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
> 
> ...
> 
> > @@ -2255,6 +2223,8 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
> >  
> >  	if (cap & MCG_SER_P)
> >  		mca_cfg.ser = 1;
> > +
> > +	__mcheck_cpu_apply_quirks(c);
> 
> Right, this is not a per-CPU init function anymore but a one-time thing and
> called only here so put its contents here and whack it.
> 

Will do.

Thanks,
Yazen

