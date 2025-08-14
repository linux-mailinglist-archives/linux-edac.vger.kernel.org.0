Return-Path: <linux-edac+bounces-4592-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7676B26FB9
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F57B170F2E
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C2A1CDFAC;
	Thu, 14 Aug 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9TLp8DH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15F214818;
	Thu, 14 Aug 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199869; cv=fail; b=ZlC6gaM0vRsLfMNYBSQfqjZWdm9DUz2Hy0cIiWG0VXTayErUM0rLBcqsVUhEg4WnXBa7MDhjt2uYCw03Y+2pOJdfZz8GDrrlmUtKEIiM1YCS1/hTMAmal00KwBoqF1dqLmCDyOlPDt5+xtfD7FkKXp+CzbHciuVhmWDcmwtVuIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199869; c=relaxed/simple;
	bh=phngisT8EUc8qh/ZmhXr9/qE/CwLEGlwE7swoxokrmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ckwehwvh6FO4f2n77bP7OvmtaUFRMcOqwzWORKUMKkGf9cbMUt/KQ1ezVwCBYaqs1vYqUl5G4Ci7kMBgmEIfpnmiv39g/dIngP1HKpgGsRUDrMQhcKkN/Lane9UA2JtWU/wewRg15s4bT+e+OskgQcHLQcewXRxgxJdbdNNnDm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9TLp8DH; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsKpappn7bap3WfeMS/sLjRe0jZn705pDIxNc+mXd/jkkdtSWyd7l8KXIO3AYfP7RXxh2d/b6UyO0pbyBepVFfHAkXrgNKYrQde5Y02YDK2Hfs+JgRON19OsDGgOA8H/bPMuI1tT7GjSyybB9PHdHWp6OwwoD9lvmDRT1m6wTaz2BS0OEK2rl+Y7MobkQ8RkgIsCWx/z7rDGPSBPVlo83WuOLiQQIVCc6Pv0CIfYpjnWuSY4lywtYMeAQlXoYzzXp2g8wHvihH2+F3OiYyzzj3LFPqTwCr504+jngRSeOWHPX/RS2tS4j4fqxXVI8hWg3uRWY52RdYOLtRCfzNjRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpeQVbud4RNzUVwEE4xSF1tQnhM22GEaSlLfq2L5NHM=;
 b=hFr6mtuYBTupdPhGmSJ/tT1tfwJay/jIlXWgHCxBzED8ApgPiKQn7Ytpu/bpk3BkBexE14BL2nvBSu37cjvkO/RhJkpriebuhN+cdVOV4L8UDciQBeyWOraUv1ySDX4JH9RYkXPzGujmSdrcqWYBRZHe0UlUA7etxLs+adXciwhLVJebBypf96DkIMSuL+CqlXzMmtL8/s95YpfWD8FQrvRETjzXQZbm7vRRjb/blKzEEPvDESx/RLln190wF9V4c+DOfQVfaQMu9B+zsyZ5iYAvvbI6zVAduI1QHti7RynJ6hmSQx0rTaJxatovS6NWIpRiIFGTrEEAwhfISjO/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpeQVbud4RNzUVwEE4xSF1tQnhM22GEaSlLfq2L5NHM=;
 b=X9TLp8DHsIX+l0M4s0xpakzcrTNmKydK5C5p5WBD8sSTempMCD+PSPCQxsXHGfom5a91ljBKe8AFCav46odBVrNgGsZe6dWfm9nShEyTvcepe5v3qlE6xbkSoFlFaO3Jyjlf9sMMoEULc4Gi+JB7M0r7I2aFjFN8TKlqNXSn7r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 19:31:05 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 19:31:04 +0000
Date: Thu, 14 Aug 2025 15:30:56 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Message-ID: <20250814193056.GA192444@yaz-khff2.amd.com>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
 <aJ4U3g4fDNNibUOz@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ4U3g4fDNNibUOz@agluck-desk3>
X-ClientProxiedBy: BN9PR03CA0513.namprd03.prod.outlook.com
 (2603:10b6:408:131::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a5f391-8be8-4896-5fd4-08dddb691bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9X0rKvYBKuJdFzhUrjiYTUxSesnO87E0cc8U3Id+UZ2ONlLYN4kaDcA5PeHm?=
 =?us-ascii?Q?cq+YHIdkwWW4iGYHDS4RlfeQTeuBjS85i+AY+lossTJ+2KcpVg4cZ38AX6Mx?=
 =?us-ascii?Q?U8IvxeAfl4kwmPRk9bqthdm1FKyrALDPECKPifdIgQYeQJ+k4E3wRYhs4Th+?=
 =?us-ascii?Q?2PAu859LkTdx7kg1TS5kx8j0nhFc6p9lyN4N6gystQZ6CKYSZ+Y+qqt2RH+a?=
 =?us-ascii?Q?edwXMNr/ySluRuMua72JthmnFr9otjEIYFoxnXse1916rkM4bzzgOcgfKWOd?=
 =?us-ascii?Q?Gd1EH86Yz88H+xknq6mFtIKkAqOm2THvzfiSgbaaz/yVZ1RTqZksmZ/juEUA?=
 =?us-ascii?Q?yoWpGPlaTkA3CjSROyDJvjcURd2rV8Y/eEYxh51UXkolGI+A3vlV9e+MnsKH?=
 =?us-ascii?Q?QoYgN2qQc6kJeziNol3N7ubJgzxuEhEJ3OtK8UXCoCLQciXxInU85Qdk/Ndf?=
 =?us-ascii?Q?9YjgElSX+yE2ziQbfVUK5xhaG+YKcdir0M7uRD1PkIV4sdGPaps02D9Zr3Ok?=
 =?us-ascii?Q?B9GFCUieEXo4MVtngTbxwp2Tef4GZMup4p4OpTlmi6wlCAUimQKLJ8Vaplkn?=
 =?us-ascii?Q?CBJPGMS/pJtFYy82TEylurYt51hFGKJo6FpBZKycMaiAOppn0JB1zKFWfu88?=
 =?us-ascii?Q?LGJ4IUbdxIxV2yGjbCo3/LXK5kDnudFVvfW8bulp+IYivFbppM5A5uXK4sCr?=
 =?us-ascii?Q?83zKKczoPuD0bWIXcoSqOHZ3NY5x+gQ8NB7nBvnpBdVHtd6if/f6IlUmr9Yn?=
 =?us-ascii?Q?ttqes0q2aZ4n2lhvA0uIe3Nz1MK0r5BugNS6+Trp4kZKRyovA1hciCfRl6aC?=
 =?us-ascii?Q?4iqEK5h90c2IA1Z7s3ZYU1VTEP8LO0RH95ICLH3S9Kh2UBlHPqu+s7rxgFxC?=
 =?us-ascii?Q?laAM3p5HQZiHLWxve3Q80QsnBbz9D808DTl+YAgEcEj+qDTQndaQJLJnzkkk?=
 =?us-ascii?Q?YcDsg8ceamoGpyLcUGd7B3dXnoACdHDeYeoIgPlXoglJaTVyTkmb9gkTAjpV?=
 =?us-ascii?Q?2Hb7Ox6hH/M6BpnsGYGUmvEWzTKGr0Zi9r8im4ff5DTgq7C1iXVWIGwLwu7b?=
 =?us-ascii?Q?l9/GurV5iDOrSu/IKrULml6DCZ1wSzIod8I7/MKVoww9up6bh6kxHNpgrQ4f?=
 =?us-ascii?Q?5lM1igDdM3QnZWVW6QJwWMgO8EJ0SWqpKlH83nuFaIhA6JWYxI5q3jenu884?=
 =?us-ascii?Q?czEBU7nXKwcsfjjRrw93oad9VTaqeZUv7rglQCiWTEGPKFJfeMxTa4VsgmnS?=
 =?us-ascii?Q?XdLTG3lyDwkP5xYAjOX9WjmYW6P7Fh2TUMBAiUWMdOqcPw3UgF170dR6eH9U?=
 =?us-ascii?Q?MppglOT9Tzpt+E8txnTGHQqjWrgFpmolLU0vCxMSnfdKU3jKtCi1y4UvBQGc?=
 =?us-ascii?Q?8Cs0Y81/T2oWSkVBy0VLMbFX2z0AUyhdjagdFhN6ryI6iycSn3dApN2fBpBc?=
 =?us-ascii?Q?93PtiOvIuXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bi9o53CkY31hxoWsGLBzsmKi6y0SQhAabWMtnrMwuw+XXC7H70weP/4siSAJ?=
 =?us-ascii?Q?YQ6V9bk4hGbtmRfg9s5tgGKV8SR59VqwAVy6xKR94BGrZ5JlObJ5go/mI7Qv?=
 =?us-ascii?Q?cenRlFigpA6pld3DPPfGRxElXkQsVJGMTsJVLS3G6tXiyLWtZwRziENjezmL?=
 =?us-ascii?Q?/shvyW1gqhIzLhmtimcgPZXP/ZcZA7zTHBkQ/ntqZ17kKJ0YD2SgfUj+OrJB?=
 =?us-ascii?Q?W3OooY2LI9MjeN2fjUd3/t5U2m5HcdciTrr6S/Si9OLe1QCBNNgRN6eJoXV8?=
 =?us-ascii?Q?Ynzc9G1zxL0CYHltTdAgfnnf9Zpd4Sxikh6Uo/CTnN03cONzkazYcCGc8Bki?=
 =?us-ascii?Q?y0mD9Ch9hZRZ78HjattskCKrbSjf5e7Yw67boqzsjdJudLpuYvbiU7qPNxjZ?=
 =?us-ascii?Q?pONCH/TbX6uh3CUK6pqKMkkMNJ+AWTXY5LV3XCm45NFg4q63Vvn4aBhhtukE?=
 =?us-ascii?Q?mWqRbOkDOIh0rryjF6Nr5UUZalowkva9s39GEAiq+F7T0CAIRftv4FK055dL?=
 =?us-ascii?Q?uRCjva03zcjSNMG1jY2RqY3Dsz2dE5u9jb6sZlsBmKN1/ORV0rL2TlHHVVN/?=
 =?us-ascii?Q?RxC1QhGCNKwgi+ksbeJyyBkySYruKtEf9kQD/KxnhBaNB5LbGJgQneJUWr9u?=
 =?us-ascii?Q?ENcqe4WRhpW3aWasrbqciM9j93FIVr/zQKIfHl9TPpxXIclF5uwyaRfOh9lF?=
 =?us-ascii?Q?AWwQ3z8lzEUNV1u/3jaHr0PGX2q7tbfe8uNPL10YGM6bZTT/YeNrs96AQ7V1?=
 =?us-ascii?Q?UUlGJMxdOClwFXymo5bH6VnaB62WKcv612ByYAOCWAs5Wt57jA6iyxgyMhQ3?=
 =?us-ascii?Q?q8lGQj2lF6C22hqN7FMfwiMMBKYcQhVGQ4wfZ3jKo8nbBcvEqf/dlm3qswbB?=
 =?us-ascii?Q?Q5tsCAEoVq55hlpLGGY/BBnsSCHAJ3RcFdfw2OrBe7U8OOSSPzysXET8ax1s?=
 =?us-ascii?Q?S+VUgoKlqvw+z/8o0607Gy1i1cq+VprPO9gf8me1IRHj6MLv373NaRfcivl+?=
 =?us-ascii?Q?mf1kkhZ4eXfVqG++ny5MOCDA9UfzAdFTrroYKNEPgjo+pKJw2FxvbtOb3bBS?=
 =?us-ascii?Q?EDqc5Ta1LFouv5H6ZPuZQfAQu/9SNIUufVF48yQCZPnyLEUUaJNH27SzV4fe?=
 =?us-ascii?Q?18ziyFusCLpd51mURhGR1T2Gl7pd6XPWz5pqFlfjXtXgoQAZOk8lrm+Fhb14?=
 =?us-ascii?Q?LHb+yrrOX3K897PTz5sGoTigvARvm+0Kr3eZ17tgnx8wbKNDBWuJN09ERNTj?=
 =?us-ascii?Q?JY42vao9Bw4gBHMblaCazNdK5IvEkxq1lu5oesrPe4k7n4azdjx7Vp6AggTT?=
 =?us-ascii?Q?YmopUexKpnAl2pn1+ALgOmTiTjFUDtt1//Bk07FxlwNuCihOcC96SYU8CTGk?=
 =?us-ascii?Q?InPXO6tm6z72MiQe4P5nFM1AuCj0DROQkwAfIcP/dP21kLD76AKzH7zMmPhZ?=
 =?us-ascii?Q?/soVoHIqFkIPa1iaj+ve7zbr5luU9OxF3dsu1m50qtsXmWWbVixBW7w/OC6X?=
 =?us-ascii?Q?B3RU11JfsyoujyuEr841E8GX3QAFKw0kWCnix4qvENm+ALCM2Zt/LHPdnFEj?=
 =?us-ascii?Q?EbItS/ZenDaKtb/uOODCJ2yrEeYnAVjsY9uykH8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5f391-8be8-4896-5fd4-08dddb691bfc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 19:31:04.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkAPKfE7NJB6Ra5D4ooi7XflW/F05o6MKdI8i1RhEtHsOO/SeGWU0byR76q7RyaF+ZfgLL2/VhsEoAxhC3wWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

On Thu, Aug 14, 2025 at 09:54:54AM -0700, Luck, Tony wrote:
> On Thu, Aug 14, 2025 at 11:48:09AM -0400, Yazen Ghannam wrote:
> > -/*
> > - * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
> > - * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
> > - * Vol 3B Table 15-20). But this confuses both the code that determines
> > - * whether the machine check occurred in kernel or user mode, and also
> > - * the severity assessment code. Pretend that EIPV was set, and take the
> > - * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
> > - */
> > -static __always_inline void
> > -quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
> > -{
> > -	if (bank != 0)
> > -		return;
> > -	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
> > -		return;
> > -	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
> > -		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
> > -			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
> > -			  MCACOD)) !=
> > -			 (MCI_STATUS_UC|MCI_STATUS_EN|
> > -			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
> > -			  MCI_STATUS_AR|MCACOD_INSTR))
> > -		return;
> > -
> > -	m->mcgstatus |= MCG_STATUS_EIPV;
> 
> I don't think this part of the Sandybridge quirk is covered in your
> new code. Without EIPV set, the Intel severity table driven code will
> fail to note this as recoverable.
> 

Which severity do you mean? EIPV is not needed to be set in any of them.

Unless you mean this check:

	if (!mc_recoverable(m->mcgstatus))
		return IN_KERNEL;

This would never give the "IN_KERNEL_RECOV" context.

And this is the only case affected:
"Action required: data load in error recoverable area of kernel"

But that is for "Data": MCACOD_DATA

And the quirk is for "Instructions": MCACOD_INSTR

So I *think* we're covered.

I got the impression that setting EIPV in the quirk was to fake our way
through getting the CS register. It seemed to me that it wasn't directly
needed for severity grading in the quirky case.

If we unconditionally get the CS register, then we no longer need to
fake EIPV. At least, that is my understanding.

Thanks,
Yazen

