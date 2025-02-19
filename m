Return-Path: <linux-edac+bounces-3158-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C257EA3C479
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448E817126A
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81541F150D;
	Wed, 19 Feb 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FNVGCV37"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3891E8331;
	Wed, 19 Feb 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981258; cv=fail; b=Xz8t7gAGO7/r5RqmkLf/rNP2kGdC8S54E443T9q/mdW9FyqiTLArNA6rGiKtSwylaC1hjoB6eZixADY6ZOkqe72zKwmCc6+pZU89hhrujVU2jaAGIUHDsNdEgpZBnQse6YRbvFWpREh3wchiJF+111twDSJVhTLlFxoUt2jSJTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981258; c=relaxed/simple;
	bh=+DN99jx+xj3g2/1bga57dcAy+Z+WSC7P6GBnMiBPB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EoC/ZKSqsXEi7yG4dibKqcd6rUsMN6XPZnMWuXloNPs3B8lYePS+MHqYtrqBbRRdgxgn1b6GHuTgtPiZkNCVITIBf/DvXlyJXRpQ4kC3qyEeW/2IbvkXe3HnULwtTtbNUJbRrXuYon1gVtOpIVWVCP5IWvUrfgAGGdt6s6Zk0g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FNVGCV37; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvYU1kGqZ6JRwtvZBrdNgwkWNCE3EXiThu2iMhOTVetOtuTnag2wuRzb2oyKz8FSJyqwzTcvvI7r5Q6EdG4Rc3WXSOAHR6V3QHrhmfYXFb+ALZGN4FaiLK7W58LXzaztSwgmt8/D9xo3Tvtf3gGdY+wtzINF0Ywdp7LnL1zbQHFDQDWdfXsJwncVyTUMdSWKlMsptdzCAWOCE3+xXa8u0fcnFdi+BehgNKoXsVdOnJSDy75ye7CmKJ6tJoqVCLbkfSYM2Yb3kcB7AJ9cKvOJuyScD+iO9q2eLFdG8Pby20l1s7ysadnNWYvPr7013F+10UiGOQUwXvu+sHwqRGRV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbVLz4Wtl88gHhzlHYSQN0eW/2BF+LHH9CHJXGoWuHo=;
 b=YG6wTm61IHa8jIpMFPvHbSVV4Dvd3tX8moVg0kIMEqWGNbg2TnxvwwNEBTZiMDqToi2Bk8tXCQ+s42qdsCvP+YWeuyTBf/XJUJ4/O28ciEy4sz9e/FTH9R9uAdxeOzjI4V0WjXhicqAlUSPQ8xAwDyRiS1c3nxXA1ObKhxwwsKQWKwgK1/5ibXpCH1782v/oXta3HlhHba/VUVoATjh5EdX9U4RalFc3JvVkGSCXwnfPdBlK/dsfAdAFvLXxY1xjmIXbZ3F5CvZB4qtodorkEXkz2peXvBbkjKC2/L674wimW+fvaO/1JHd4ZhsfCSfeLQ0j2w2pZEeYMK/Pn0XEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbVLz4Wtl88gHhzlHYSQN0eW/2BF+LHH9CHJXGoWuHo=;
 b=FNVGCV37MFR5vpSD5l5ThNPMU1eqYeZCpfdcvzPVw1vBaW1pLHfOED6U+5zpSkhxtCwa5mHxcTLEyPby/2lEFSRXwIYIfGq85aDn8X+U+Xzs5SrEVURLK1wmu8MeRuSp7WqOR8oNvLfhdiQKfA/425G5y2vAFu3UeaMPMAHCSfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:07:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:07:34 +0000
Date: Wed, 19 Feb 2025 11:07:30 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 12/16] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20250219160730.GE337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-12-3636547fe05f@amd.com>
 <CY8PR11MB7134A549EDB172C3FB87233989FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134A549EDB172C3FB87233989FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 46841eb2-9203-480f-7aa1-08dd50ff8575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zFTO3mzOSS1/ITuh7SiJQuAshy6eOIu40KwlgCdfwSSkAQw9cUwZf7WATKaM?=
 =?us-ascii?Q?CU6ufLGne9Aq4BoKq7reL+LJMi0z8gAFgq8QmubOlQmmoW156VEEFuY1IGQn?=
 =?us-ascii?Q?8uVGIZUfCqMpw8ZOPzEoEXcN7c+1lqCX9FmqDhulFbzZrbCnZSzNMp3653cU?=
 =?us-ascii?Q?c2EFf3y9wi98yAX6s09TRuLUd6//cy9WbJLju4TyqOoDW0A5MiHLwJc/Dcv9?=
 =?us-ascii?Q?5rFol0BP5T6JSDQ8z3Aa+argfZtAZJKvXDMGID545zMoWxK5FsGYmfTgG62y?=
 =?us-ascii?Q?jW7ki6rNijxiExGo+r8+2JnVUuYcB1+ZbdtumbVG4lspfcJJJ3SbOTOjF1Cn?=
 =?us-ascii?Q?ROhXEw3BR14tsDqDKVTXD73weYjQAyizkiVaHyIKOOl583leKj+l7O71FWKi?=
 =?us-ascii?Q?z5Gv9wcqWomw/owhtjALHPUGyMyT0bOw27embTulzK7vrjruwPhu2UOvknjI?=
 =?us-ascii?Q?vE5SRVqgq9zfCbrfiGZATZd6N3t4o5ST+Mn3hphj620K1ldBnNk8EH6wqYt4?=
 =?us-ascii?Q?sDkG5KJ8NQbH88LPq1gtNTd8cf5uftd1lZbxobL8HYw0S4+vAnGjV0nLyuTA?=
 =?us-ascii?Q?mt+DiSZmeKR3mRS4VN7w4s6IFzUntT9+N8P6Es+HHgsgxBP1Pz8xFWCvlXNF?=
 =?us-ascii?Q?KJcHM2HG0OXOH9AGLmeYNjncUqfpiVRyuCERoKNby3hmrietZd9f1ch407Uy?=
 =?us-ascii?Q?Nvt1UQevM6YWGhJBgPfWIRfN7b8pnX9sGFR3beFu7aDzHqh3NSi0+hbinqIS?=
 =?us-ascii?Q?1p0nmdnFviHmhZHENrvKSpWa1EWxQQTPBMsXHBtr3vLH7B2/hTGe3iMpbH4b?=
 =?us-ascii?Q?JkMZyOs7VWQ+pCOagbPiMe4OLVkaofzrSQzUsr1spaM/Rckn1qFijptPJk8+?=
 =?us-ascii?Q?Lz42h1RDB3rnLGJGYTVLBdeipayhhnVkpqxHYaFvZldmI9Y5XGuPHjBWRKrA?=
 =?us-ascii?Q?F2MX3kxdZPmVE/hf2Y7+gIt1Rsir8wD0cdFvRhZdC4HHULFZBw8+A8bfYlUR?=
 =?us-ascii?Q?BwqnqNNs+IXNo9ZCE4uBoclzW8n6jtTrCNVeHv//CI+LG57DLRhh1bBVQ0dQ?=
 =?us-ascii?Q?oLaPlQmiDsfkUf77PBqitoT3OLXw8Vsri5Xgl2VEOBx3csahwMHaWL6w1uvx?=
 =?us-ascii?Q?AOC9TBsyhbfn4Je54xFpePKm0vqKWrPsrB7HLE3u3VH+dR4sKx9CUnxMUGvD?=
 =?us-ascii?Q?yj9zQrOCRT5w99ORfvqaVBS3Lmd3AsH7QGAzX7vFNOHkL6lGM2QPRWmIw+Qi?=
 =?us-ascii?Q?LCW6PRb14k0OdrRB76XUyW7V047QH9JzC3mCvEGY/HRDzQQ8aEN8mKPhY1IV?=
 =?us-ascii?Q?weXHoyEmBcZbUTVcbXFfOfiDFIdzBZEfET4FlSwguR3KRHmllPFyVAK093Gx?=
 =?us-ascii?Q?7vnz5j09xYbRq0OQ/T35hzZiD0rH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1yFWbzq8SqmGcEn0MrZSC5TBX4UJu8qwwyho1V08Vz7cu+pzog1PmYrRq30?=
 =?us-ascii?Q?sGLeZbOyKnFuJhWcJlhxPSxAMpUT5hjEozeX5KGFA1Qend7WMPd/X5RKQE38?=
 =?us-ascii?Q?hE7P0r5SwSfZj+mdzN36+ynKCPkgijI/3Wwzz37EU8HbWE6HVwQ0bicHG/od?=
 =?us-ascii?Q?J3Vb8tKNqEdsu+b+ID1SCtHGZo2lyfQbFlXTH6Qsw3RssruebOGVDYgTrBFv?=
 =?us-ascii?Q?vkymFbWkpK9JPKiRro9xgU5O7ycp+j9H7sHV3ZhWxeEr98vq4XfQiO/PtpQP?=
 =?us-ascii?Q?UwcGNM1l/AhVU+4M3r1TEDuV9RZbU3QnEPMFs1nQl6LOT0eTG4gT6n2wfCU6?=
 =?us-ascii?Q?3XMEkNVzUmYQnJJIdoXTYdZB+scTrwiTiTT38yspH1Ao5L1URqEn/H5hg5gP?=
 =?us-ascii?Q?VZhgvf6xly0C38PW20jCeTp60/lko+fWGQMB9ufSxcpJV4TMmWZXajV8OiTP?=
 =?us-ascii?Q?2qHU5cBmZCBjbMq8N+KvP+t6feNaijVCozZOQ5pFn8ViJITi47Isy9iccExl?=
 =?us-ascii?Q?MN1PgyBicayuABZE+B5jddWazWPBjm6V7w0qm42KWB7aN/ar+Foa837sbi0A?=
 =?us-ascii?Q?kmt/mpnoa9NU/2xMi7mwgG9aDkwDorILfcST6JuvxtVld345H6UPJEvffArc?=
 =?us-ascii?Q?7KtEuC3/kwRbQ+AFchRX2DhYSmFdcbOb6GpGcZs0ACVgWb++4hnlRtKBcvfX?=
 =?us-ascii?Q?NfXfE70m91nbsOmeMljKI9V7XS+UP7vgFHCRpMHMpCi7QD8yaP+YhJU9Ho5L?=
 =?us-ascii?Q?GTErz6TzOuVSTi5vVj3oJ5oIHBISd0uOMlPkoEi0hupjT2oT2LQ2WsvQt6yd?=
 =?us-ascii?Q?n056DDtPzjpzeYJwwbDs8UVf0K0GPe6MmUKednmhjPzMpAVbew8b2FVxIwhd?=
 =?us-ascii?Q?oYqgS677tsTDp6EFD+cUHM8LMP1ci/FjtKoFxaQiUvKClrcAODQeZmyc6LZK?=
 =?us-ascii?Q?2MPt4x2a2rx72CYWl5LqFB5nvalbQyYcXilNVoEF+TwzYogTmxmkHKjO/eUV?=
 =?us-ascii?Q?zqcyYaWnLS1WWq6BzIX5syqSxUucTY2IV9CreA0ehRRZI1Rty8DFdxLNgswg?=
 =?us-ascii?Q?wOKp2V4Qc5zSZH9PuP2ElQBAHT2j5SQts52Mt92Xh4lhREiUMS7x+kr1dvHs?=
 =?us-ascii?Q?R0jrzcywFHLxfEIl0cPMjYycwkrcQAkA7qOR3c/znfPwwq9g91/wYPqsBsB4?=
 =?us-ascii?Q?rafxBnyLJheGbkbu9rSirKbrNXgzhP60BsS7zMPr5EgVuG7795JDHk5OJpXJ?=
 =?us-ascii?Q?e/zvcneXhi7uhMVE0BWAKMyE6bRaitvx4L5yrAO1ivzRm2gmDSfmHxs8KGM4?=
 =?us-ascii?Q?c6dUI3Ryqhvj+Sl5mDmyhCnkYX0YAot73xyhWg49T0qC2Vk4JVx1eSijUE6Z?=
 =?us-ascii?Q?PGdAoOEaj2u/PzPEh59ADEvHsOLKYGJFe3+5vaXVWDbqRplfVtKFGsc5Fvil?=
 =?us-ascii?Q?VoYxzXVNApZV7N69PzdKHNOGxO/fKb9ggSGE+/tdZyEQjR2T5dpQsWDJ+exy?=
 =?us-ascii?Q?NDqtDoMUQaezmm5CO3jfCUkuq+35wbsFcaD3sapC3qORlMYhr+vd+WwsDAcW?=
 =?us-ascii?Q?Tk5ckaADCrNqNcdbWRzO+xaXi2t/SgK8Q8aIVO2Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46841eb2-9203-480f-7aa1-08dd50ff8575
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:07:34.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ3UA02sTDs7XNy97i5clmvyt+IaOSwq6n59cYWZjV9yrhSFEXmC9aarc/0vyZbbap5F/Xjjooydr3PxF1iaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433

On Tue, Feb 18, 2025 at 06:42:52AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Sent: Friday, February 14, 2025 12:46 AM
> > To: x86@kernel.org; Luck, Tony <tony.luck@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;
> > Smita.KoralahalliChannabasappa@amd.com; Yazen Ghannam
> > <yazen.ghannam@amd.com>
> > Subject: [PATCH v2 12/16] x86/mce: Unify AMD THR handler with MCA Polling
> > 
> > AMD systems optionally support an MCA thresholding interrupt. The interrupt
> > should be used as another signal to trigger MCA polling. This is similar to how
> > the Intel Corrected Machine Check interrupt (CMCI) is handled.
> > 
> > AMD MCA thresholding is managed using the MCA_MISC registers within an
> > MCA bank. The OS will need to modify the hardware error count field in order
> > to reset the threshold limit and rearm the interrupt. Management of the
> > MCA_MISC register should be done as a follow up to the basic MCA polling
> 
> s/follow up/follow-up
> 

Ack.

> > flow. It should not be the main focus of the interrupt handler.
> > 
> > Furthermore, future systems will have the ability to send an MCA
> > thresholding interrupt to the OS even when the OS does not manage the
> > feature, i.e. MCA_MISC registers are Read-as-Zero/Locked.
> > 
> > Call the common MCA polling function when handling the MCA thresholding
> > interrupt. This will allow the OS to find any valid errors whether or not the
> > MCA thresholding feature is OS-managed. Also, this allows the common MCA
> > polling options and kernel parameters to apply to AMD systems.
> > 
> > Add a callback to the MCA polling function to check and reset any threshold
> > blocks that have reached their threshold limit.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 

Thanks,
Yazen

