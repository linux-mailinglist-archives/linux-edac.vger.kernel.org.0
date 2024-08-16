Return-Path: <linux-edac+bounces-1657-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE73954BD2
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44F01C20C83
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1261BD51C;
	Fri, 16 Aug 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="muXk14iE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB11BBBCE;
	Fri, 16 Aug 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816875; cv=fail; b=rFXHTyudHmd7teLM3wllmGIOAqoO0iFFeb7PeFNezjMlYbiby74dZ8jrJRsNekP/SXtAut09jeggDDZA/GDaEOOQfBA0vc63X0ffktSg1dXotTnKE654bidNdtd1Of3HJ1ZuqW2Bo1L6pqK+TALxOKNG43C7ZsMUGzOnrAKRC58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816875; c=relaxed/simple;
	bh=fh5JtXo2hvJeilxmaeulCENcXOZUme+UXtql+nh+S/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMP8XR0EE+HJ1mKyVs7BQkfwdNgd/QSQ6W6+eN53+MhTw4wernL6wlUwPuHPOj7LrMF/aDu6kYBxuj+C521L/SjoZvyVDnwXf2Wb2d2lO8M8kRk5dKCsVFyhnKnInNj4gd6tluFQO8Av4NmIBr1Du2qFUk8lIRNPDMHQsFQ/jk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=muXk14iE; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmdaH2opAq8beI9iXt5C1iUnSHNuiYiOXafk6BNg10TBEU7wdNBBWylXMNmOAaxaqjYPwxij1XQcrKfvQ7plsptK+30YHu3xO0wAGqm9WcucO/lieUx/DqvkNvmRbmL66QWSMF8Dl9higSpbk8Ojmfi0Fmk8iaonaQ0iG0kcFAuGmZKerBtGkEGf7DIlYVoxw7Ig3HDk2QV68oUf0EQRl1MV/g05/NNPauOSobjow0nqWU1BtnZKLyS6HKYz8DCvl6L+erCUJOXAEQO84KOC1VlZn2OQdl2i+1/B+SLFr4NWQDk/MzBctAQqBYJoSS0Asy1IKuVVfAV1DfxZPyhnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Osni1fNnI9aNog30Eg5p3ImIWNOTLKsZ7zjs3ckLqo=;
 b=Hno0OgEwoFUne2QOW9L/mnGsciyFAPP7Ua82G/k/2WCoirsm8sZILqFfbVs5HipiiadMet61ebVccdhUzX0M8VEBHd8ZEUGSAWDqgiUeKWQbVdYrX9sfpJCoeW8wPJ/G1RZCGQVZshfJmEHR3RhKylrgttlkSUx60qUsUL5J6DawScaViC8CDjhO/9KMwQxjloQz7Ixjjzd0qhihWSIgII7LKUUK8c/7pG7uzxtPMl3HeYJCr7tSpCGKu1P5l/iOD9YEJ8cxW7XyKnKHKW1TYY2/VCBjfLQVzuoclKQZLPhweFvL6A2N5hDZo5r8tSVAhCFBK67P4fNFTFL5x/SGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Osni1fNnI9aNog30Eg5p3ImIWNOTLKsZ7zjs3ckLqo=;
 b=muXk14iELKdFA+f8+F4zS6SQ6k2HkpVrxyff2SucEPVW2ClRwxYTID0UOua6Bq5mbkKAdQoWAnVAFNnds8rqNiDHo9yc0oZX9GEVEQJ9nnnU5ODwJSOvxCtf95uCR2h1z3VAv3C6Yq9mOa5WYzzPH7QXWix90Lk0lo66tloeak4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Fri, 16 Aug
 2024 14:01:10 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 14:01:10 +0000
Date: Fri, 16 Aug 2024 10:01:06 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 6/9] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20240816140106.GA29375@yaz-khff2.amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-7-yazen.ghannam@amd.com>
 <20240603180409.GPZl4FmUZhYJHmcj2I@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603180409.GPZl4FmUZhYJHmcj2I@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:408:f5::17) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: e352e7cd-4ef6-4355-ecf1-08dcbdfbe1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQSpOoDwcD90Q58F+fveGTS8ml+Pf+VK0u/NjVIKVIvdKrOnVBMn5DqaCXLc?=
 =?us-ascii?Q?RH3j55XMGtZOdmBAciZ7rqxOX19PTD2YoQL5GSwMfwQcx+XiPN68erUGnyFX?=
 =?us-ascii?Q?jf/vPGzCAYEQ4uIL6nyBH8MBDQRdvDO/OrSv0GULQQMizCbSisNSRc+7Irvh?=
 =?us-ascii?Q?m0mqvE7ZAUbR9vPLKEYAf3Ms4uC85qeeru4UtvZcnw2dwYrNpAny0Ygc796A?=
 =?us-ascii?Q?9mazFD6Hz1Hw24txd562fGotq57l8EeuEzq51vQ+z7mooEb1SSUumpCk/A+Y?=
 =?us-ascii?Q?Oz5RyzV2UNiv86bKjbbfy1OpnXeedUcYJctRqhqFy345kqlntIT62wTPeYWQ?=
 =?us-ascii?Q?9Y3mU7RkvkYjVqFyxsdcjyA/bQSjO8FN6qQkQZ8/322Tx2iOIjDzi7tlfCzq?=
 =?us-ascii?Q?alC7uFkxURQwHEL50TD9PAyB3YWeXEUKFSsbBov4hzF2B8ZlhISym0NBLilP?=
 =?us-ascii?Q?4xMzdcz8djMRc7JTgAzIcNxfMaLvuW7KCfA5naokf6m52AIkqPVM6ojIH/lf?=
 =?us-ascii?Q?rndA5yUSryt2508yKug5gXtLUv5OJLVqV1mgpUek2tRFJF3R/nOMJkkufNDt?=
 =?us-ascii?Q?/WNWrPysGaaeuRy+mEUXE9dXgfbNmFOrb0Rp2uDKO1maa7cFdNHzelLOhMEo?=
 =?us-ascii?Q?AyVP41odKDRkOURI981ei2eqZogEUFACvAqHr9ClVzfAPqOLhSvuKVNRNaDS?=
 =?us-ascii?Q?s3nvY72NOybYminsliBJsLHJG2wYZydEm90CgEZpdaZ4onpSKvolOXmysfrE?=
 =?us-ascii?Q?3hpbW+xfAP/okPUWhROOkLYOV8YwNokG33nDOlED2bsNnvefh21n2ZNQUA9z?=
 =?us-ascii?Q?CkgG2abswJSzaMRzhW75ybCU1xSB//URKDP4iHOL/9K3cNT59ncHmnNrSj6m?=
 =?us-ascii?Q?o7hOKFLcqmDn+dRqobmnyXhXzC6h4jlwC6Hc9C/UYFW2Y9NXbOI9cRlpIT0Y?=
 =?us-ascii?Q?I4Djgv9hXpNC0BfcZDSRxyWt++OfdtrNmDtjwVVMhsAzCFNIHKBZ4S/4AQrx?=
 =?us-ascii?Q?ZlQrnEfDn9TmZCDvzXLT0JbKg38v+OYVQDzESxPA+y0FEsWVA1uVW8tgkNZM?=
 =?us-ascii?Q?idBqu2pIEVX93VFh5ywE3FQA7BCBUHFGrfHo2mpZY4B4Z29Z6t6dsCyRypHl?=
 =?us-ascii?Q?th4lDupa0nedIM4RlGrsgCBIpGrrThox3ZUOlF/j2UEZOGvhLrXO1VLEdDpv?=
 =?us-ascii?Q?aoY53DZMs70IhaopUoAznx66d1xB9hZ0oWUcXw5jwsVU/8vX/8tNsvgJPGaE?=
 =?us-ascii?Q?NH5anzZgKKW4T7nCkiXMmR/88VMNapZs8H6dC16EGR+CosapfVcEjmdAvBKU?=
 =?us-ascii?Q?i8YIrOttzYA0v2fWUyOmxigJRa6DnB6h49/KWIhSBuMcyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcgoy/wgTYL45RK4EvVbe8+Ote0aFbX+9Qo5cYBH2gSTo3NcPBKHSlO5fAs2?=
 =?us-ascii?Q?g+ZUvjXkJ7Wpo8jUvarhaUgqoJr6u0Xea4L2cX8Zq3rdL+u1Z2TlIJR0aAf9?=
 =?us-ascii?Q?4ZO/YBMWnaG59gUxeDuN5PIO+O1lky4B2NRWnipGwh6lBY3b1cBXuv2AiT8K?=
 =?us-ascii?Q?kwFD3PX/L7QfGNctbiA3EJRjBrCv0eg1VxkhEn+OC/n346LntmePYtRAFBzH?=
 =?us-ascii?Q?WZdTF2kZbEuDy5sgW0Z0c1MkdRkSGXl0lnJbbbxe/ZyDWbzm59qUWi8NBsOs?=
 =?us-ascii?Q?7s+6Q7N4sW9v7vSj0Dak1VabAl6VJskD4Xr9UVlR4hj1LJ221C32FJre57cy?=
 =?us-ascii?Q?AYY8Gcvo3dGz/xWz8/0fgolxFMjiIIx7YZCVRbLeBnZUTpFxaEqhVGFtFqvX?=
 =?us-ascii?Q?sg85tL8rg/93TPiqRL4U477S1RW3YOF+I8wLawd6mr1otXutayrIJCasU2Qr?=
 =?us-ascii?Q?Yw2Q2Bwv9mrYmzb//QLc/aivXxAkhVQTWwWYGNEVVcYAGBZ7v0aiGx/Ixfng?=
 =?us-ascii?Q?0iOpPwFJdHb0NBiTQ1qaFy52uens7mQ/IKk+C+LUXHbx5gbTlOIp9KyFozS4?=
 =?us-ascii?Q?Zyk59IbEQaesfKyM5kTigs7r6CK5YpZVFTnySNkTljHGx/vEXqdlQ6eRdBk8?=
 =?us-ascii?Q?Pe/7+7+zTOCJDeCF5bFP2JxghcbgzAEzZs0P9mR3sDLFWgWhemTYwV9WCSv8?=
 =?us-ascii?Q?Jevz3MmAeu/pnB/365gWvjI+PNhKGmrJ9UwRbGnq/+iHIKYqYJPEsFEtLN+7?=
 =?us-ascii?Q?8LiklAq/fqVex35n6DWd98le7uyROeo1Kv7+fynfVVY5hgXSM/UDMEsga3mB?=
 =?us-ascii?Q?ipsh4U30+W6Exau5s9X0V5UL/KFIAXj+V25fVmux9ABP2k2s0azhky/9HmGt?=
 =?us-ascii?Q?+xQMVKK9q8hPUzeY3oJE5eUoargpPE73jjYWI7UNiyo0GlA5dCeF4ZY8MJtK?=
 =?us-ascii?Q?lw14ECj+fXvhN8llfLtJFgE7vjaRVntXFBawGGse/JdwAX7HVBEJbGvp57qV?=
 =?us-ascii?Q?RnpXdXkUMM7Uy3+K/t7wrg8WBfhH8pilP/SPQiuZt0rmy+eICI5ahZV80wXo?=
 =?us-ascii?Q?xxptTJk1SsgCelNSigq5kON66tXmGuBncyUzFqEpv5VDc9V/o9Syej3F6liF?=
 =?us-ascii?Q?qji3wNZiBaKx325P1uuU03sBmiv1VflwITf6e+pi5YdT0N9DBz/yOLNWWLkm?=
 =?us-ascii?Q?808cuQ6honMxIOQF7gBNW86ZafJ+cynkqD0QpCE7eVdVFwbmCq3MaYEakZfU?=
 =?us-ascii?Q?i26pg8xQy8+HPLksj+bs0Bve7Q3lmJlkzi+pOYgMJWU3FBZ5/5eg7KIgaNuh?=
 =?us-ascii?Q?chI0szC+0AieOzAygWKSX0cg/6AEwqZOGY12zgYFdUlvponcxLR4dUKfdwnf?=
 =?us-ascii?Q?to2O4VbUfjowVhHp2QaDagLf3uTynUEsb8gVHfK950QZyG0F5GZ0YAQUrB7L?=
 =?us-ascii?Q?MemHlrXOKr37XuVSRAbOxNsnf92cCc3IN9jGWxFizdZbCqoOqZIvyG17x92+?=
 =?us-ascii?Q?ClT8UBFSorj6gKAnAbonxw8mchpPy8WaSO0QsI85aYg8n/5hxcdBJJ259W0x?=
 =?us-ascii?Q?fxq5HkPg1F5EFNDAIOrYcBkhnKMKN8et78EzxBJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e352e7cd-4ef6-4355-ecf1-08dcbdfbe1e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:01:10.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW1/I/uBGjb1GN0KGZ2O9D96DsSmkLlQeBUXBIReqE1y69Aed0o95J1HxjXe9NAYKSzXWF98wk+Ah6H49lETSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319

On Mon, Jun 03, 2024 at 08:04:09PM +0200, Borislav Petkov wrote:
> On Thu, May 23, 2024 at 10:56:38AM -0500, Yazen Ghannam wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 58b8efdcec0b..d6517b93c903 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -660,6 +660,12 @@ static noinstr void mce_read_aux(struct mce *m, int i)
> >  	}
> >  }
> >  
> > +static void reset_thr_limit(unsigned int bank)
> > +{
> > +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> > +		return amd_reset_thr_limit(bank);
> > +}
> > +
> >  DEFINE_PER_CPU(unsigned, mce_poll_count);
> >  
> >  static bool ser_log_poll_error(struct mce *m)
> > @@ -769,6 +775,8 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
> >  			mce_log(&m);
> >  
> >  clear_it:
> > +		reset_thr_limit(i);
> 
> 	if (mca_cfg.thresholding)
> 		reset_thr_limit(i);
> 
> and then you don't have to do a vendor check but simply set
> mca_cfg.thresholding on AMD after having defined it in the patch.
>

I can do that. The reset procedure is vendor-specific though. But we
only have the AMD case right now anyway.

There's already "mce_flags.amd_threshold" which got removed in patch 5
of this set. But I can keep that and reuse it here.

Thanks,
Yazen

