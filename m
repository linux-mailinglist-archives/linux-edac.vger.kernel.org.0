Return-Path: <linux-edac+bounces-5761-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE8fBp6gpWmyCwAAu9opvQ
	(envelope-from <linux-edac+bounces-5761-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 02 Mar 2026 15:37:18 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5C1DAF98
	for <lists+linux-edac@lfdr.de>; Mon, 02 Mar 2026 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CC0E3063A3A
	for <lists+linux-edac@lfdr.de>; Mon,  2 Mar 2026 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358B3E5581;
	Mon,  2 Mar 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zFBT8QYt"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CD335066;
	Mon,  2 Mar 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461387; cv=fail; b=gHU1yJ5jM9iQFHRZcM+vlj9vT+MHT5NjOfLO4qyNaX6lzZtmldUZp8u2Vvao8SbAhZTwH4I1F8qf7zG67LFXEHeiaOSJpRC/kD1eEXxV2hTnTBFscqOhoeUq5PhlioD3o3ay+y27tBzogUfo1FDZAZDAP7VNQdpvmd/u6Bbvzho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461387; c=relaxed/simple;
	bh=cVJgeaXcD8NGt9NodriLZTlFAUOZybcq2WaW7mUaH4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rkOMURW8lYkIMcg28ZaMJdR9xdjRTz2oHTWYnAqdpnrmBx8TUG+HjUmBXfAaIMT5YqtkMkWMrZxuSWbaZ+8e7cBw4i01O297zAJMon+K0xGY0Cb9vfe6S3vGLVSCp6oKdAH3DQtOJjA5tPdcXCyUGk3T6ifuhuevCmar6RPf6T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zFBT8QYt; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNAnTFxnzWFEXZiHPzFM/QonpL11MxvU2R+eboJFY4Wz+/z51MYF2t20HNOfblvXcQi2fzoSUVzStLFG9rgO1yLqINqufsVbnByybSBq7LbepJFUiHkocSv+y6F+Sqtd8cwi6WVwOm7XneojpVCmX32H6JmTkFNc7NJF1VTPw0vN1sEB3Heg6C/yd9kt8A1pYqmsvAL6A9FLDTbcqTl55jl+F2kM7BKr0DCHUEbTQ+83JYDL4Gx1gs9eE5E1Vt+v2Qk4oGojdTHjgwN5eyTcnIqbou9oEeSUnFHMLNzkIpSVfLSjm3z5rZiSYmVW3UdFXN3vbowXfGMvkULxoAdJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbktHD2wqM1azhqOolkPEMVwJfLdr60cwZ1CE2c9l1g=;
 b=p92/3jb776c6bNgs0/NqlWVpwHSt1jjfN0MS+8evl2yBEle/B9tGq2A9oPMCOo8Rmaqv6MPxRj8KbQccXPsRZwlid0MyrtMzHgEszR3FzePMZlCnh3pqs+hnv3QCnfWAu8l/pkNhv0FNdz5xpBMGYglCBTLTR6vt7IjT1jxj/pWcs2oB/7bHdtwbMT63HpXdLuYbOthqD33XplHotNow0dmtv6bjbno96dNixuQTekNGhBv4lrb13eSy0WMfdtgRzQd5ED2AKz7tpbwpiMUD++B5ypmWr8N6pDZ004zQHBIVy1tD7CZRBPxwsbhaw8QUpPFWwrtnLgEKTdwM2stlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbktHD2wqM1azhqOolkPEMVwJfLdr60cwZ1CE2c9l1g=;
 b=zFBT8QYtxUKt/ygWDpXRm37NhEz8N18+T/+JvBQmyAKcYsJ1N0unAUzZ0FHytl+wtZcbtL8LBx8CmISI5VW834ri2j+M30vQpGdzKm4kBEIaC2pVv6zYc0kOfdP//XLjkVI8algB/oMMrotElK+bzlp3NIUYQXy8D1wHgC8XpN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 14:23:03 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:23:03 +0000
Date: Mon, 2 Mar 2026 09:22:55 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Message-ID: <20260302142255.GA145106@yaz-khff2.amd.com>
References: <20260202172158.2455749-1-yazen.ghannam@amd.com>
 <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
X-ClientProxiedBy: DM6PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:5:334::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: c30aeca6-0c9b-4924-b2ec-08de786736ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	eKzm0Ba1CXYk0et5CePpLE+KwZ4shEGtLggUCUDvIqciVsfJThpCc5/SPXGgCudjfFXfA/6nmlj/RNzKfFbBdrsTKZSrwpuxSCDijV91/DifOcn2XNXbnMMekGXfFZtBTwL1BnHLPatcR9eZr7j7QaPG/hHQiVcyLPxJNsEgRTxg1Icpj49wI7yvq86EJQyt9Ny86ukoCfktUnGDh8fJUutAYveP6W7iNWc7vP2mYtdKFfnb/YH4Z0o2xV5g6s6daZnb7AWIOCaQNrFmibS88HgwWAwRGkjMX8m8s8S2KZzav9w2hChNlVIX9Ly52toGx3/H/gP/IBQ//+yEqj32TBlp2BnFrx0em1gCqpAWsKXiRd/3AUi0wqIWDtvdPvA5Un4PNr3QAnIqdzXixvslEtLuJxJlcYDuG2PRbwLmcq7PCXpJ4l/YSj7ZItF12WCgzTEcah5rFe+UoKCTnl9ZXgmNjb3IsmAe5yNkm6lWKNJypuDEjtIAEE4TCAUjtCXTOyl+7UJ6AXaFi1wwapJwSw3O7UDPbbxUIBU8LFaCKVcEIakzZtv7UVhoOJ//p5Amai/b8P1p8d3Oo9073moeYri8fvHEgful01O1FZ3K3TYp13pJUWA1tGKBRfTfJPd+R/EPzN+OKkUmDvcwuG3Pe68vBJpg239iQxFujOvBjgyMWT25DZO1JcQs60aB9SOhgglW83OUqTPBlKkMTDtgsTfzJvQHI2psy8rMxaGnIws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMTKCeUNOwCljGB1AskrUj77b1zL2gIX5BcultuzE7cQTNGlMU6YFGR9a9bH?=
 =?us-ascii?Q?pNwm5H9p5OWjg7ZKiiTmAa+EUnr10FlOATzh2s+D2BzNoCUYh7fDkjleTlGO?=
 =?us-ascii?Q?GJqjlsrEnnDpR6Xn3fR8LKV4wUKlbm2J+gpSBkojcBdO5E7yqPUbuouMosgF?=
 =?us-ascii?Q?FvhRvJTdK+qfLiS3dvRt8B3m7z8gY9JmDubeKIwc7V9dKP6NlLA5qrFklAqT?=
 =?us-ascii?Q?hgtJsHWO3PwAtdNoh1BLmg6sNUZK8XO8LAtwNIYl4DcV/YAP/x//7xatCHnM?=
 =?us-ascii?Q?Qk+hzptYqgnFaac1sEKHatNhL9Uz//tF2zgMmDhyzQcMJizBE1ChMFcGYd79?=
 =?us-ascii?Q?XyC2TBPrTGV9sFGUF/bYVaji58zoMBNWahrxc9qwltVeFiRc9WW8olSxDDXD?=
 =?us-ascii?Q?Dezr1K79MfA2i8aZ/JHT5eYdC8WE3MdT1ruhxAD4wt7Xr52EW4QdxNFtoOM3?=
 =?us-ascii?Q?bQGJLzYZpAER5ymqeIkoXV4z1GjIOr5cK20RRw4AmEnkqW1AbBIDl1XVeDcZ?=
 =?us-ascii?Q?DkWKyCp2Q2y9R+hpfFAiPJEBdDlrfRnjJWZkB0uTkiRkGE6NIMknBZhpuYc4?=
 =?us-ascii?Q?Nb46xKdcVsOcLvnXDsaqKiOAx9nJmaNdy8NqSN1kcKAvNgdTMnE6M3fdPANe?=
 =?us-ascii?Q?rEr16F3xQqEd1CnNQCFHZiJPE3qkDTLJrFq4KhsTz3TDutZgzXbWaBKRuHF2?=
 =?us-ascii?Q?u2UorDutsKldSjeZG2/mzG1WsIdD9oBaMvuRxGyIpJRMichhbA76q14tDLed?=
 =?us-ascii?Q?HTw8ubO96NwHi++ObS2Eej3h8OoWYhCXAHlV/dMiz963lLHZDpmIiWtzQylq?=
 =?us-ascii?Q?9HGGyvs5AaM+t6AY7hKv8HACS5kONVWVzavnJRuOvaNxEpr7jQdGlg0uZ0Me?=
 =?us-ascii?Q?ldI/LxwuTcvS1U4X16kC7J+pme8ciM3QL7aWmB5baT0V7ujQwcthoUh9knc3?=
 =?us-ascii?Q?gusBzEYvzbuFzRzqN1yZKDiatHTDWEs9qlmy5x07oE6N5rn40EK0ovJmqMRD?=
 =?us-ascii?Q?MzAhJH43uNeiwT1foVLr8MzNZgZvP+f7bv7HpRXCQtfm+1l+w1NNSuj5COmx?=
 =?us-ascii?Q?YhfNU7eHA5g5cTK1QpHQHJA5drREyhC7Ym80+Jsc/8ZFChMhr40MhnBE2Lzn?=
 =?us-ascii?Q?+dtSmWEmcggUB8ZkdP/yt6K1R/1N0LcdCCkaiLUFgLjt8YbpWUnooXDXyIVa?=
 =?us-ascii?Q?nsJFwwGuLc+25Fo4O0K8/4AxvIihkzq2thbWclPag8HwMNmEmvDQnNLvhuMB?=
 =?us-ascii?Q?BmpMhVqk0XbNHgKDn8TEVq8Btcrt3ows+tCPblOp1S6eVLSyC6yfV3nOoNxq?=
 =?us-ascii?Q?f4nV0dQgpVCRpIc/CQsEuXchi0zM+GoLcKsUaESq490vp1pEdaQsiltloaEe?=
 =?us-ascii?Q?rNKXDwbR8gYePjBPlk1CQM8+RSE3N7ndTQU/C9740+9PVSpHWP2ODa+JBvKr?=
 =?us-ascii?Q?B7Unr0fLzS2h+TIl1BFLFMutXe84QQe5cPRIFQCALl44xXQxaangRmbT93sg?=
 =?us-ascii?Q?U7EtA5xT7edcCFPPcNFqdrCngo+PKfJN2QZtTYSyLOMuSr44BrPo5B93YDRw?=
 =?us-ascii?Q?BIxuLLGZPLlHQlTf5UKw0wsJAIDOCDkPlpTmqinAFvMsVr2h2nDerQKYbeOX?=
 =?us-ascii?Q?ByVIF6BtZ1oS/f2H8/nxQv+93o7mFgxXXTHO13WUSUzEZQGpkxFxXXYxSfRt?=
 =?us-ascii?Q?pSfTaZsGt7Ay4d6iP4r4zZXdHKGVplRbNn71qNqm35hi+JQoItzYVSCQ2e44?=
 =?us-ascii?Q?z65L+psppg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30aeca6-0c9b-4924-b2ec-08de786736ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:23:03.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDpaOUtEK1AaY7rZsD1l4TpO8PA3BZofsd4+w9O6yWMFXjvs1DRr/mOG1zSjuQBnf6SvGQYLjlvfzz64fRv//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
X-Rspamd-Queue-Id: 75E5C1DAF98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5761-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 04:04:47PM +0100, Borislav Petkov wrote:
> On Mon, Feb 02, 2026 at 05:21:58PM +0000, Yazen Ghannam wrote:
> > Recognize new SMCA bank types and include their short names for sysfs
> > and long names for decoding.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/include/asm/mce.h    | 11 +++++++++++
> >  arch/x86/kernel/cpu/mce/amd.c | 21 +++++++++++++++++++++
> >  drivers/edac/mce_amd.c        | 10 ++++++++++
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index 2d98886de09a..6e1f10ca053f 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -370,13 +370,24 @@ enum smca_bank_types {
> >  	SMCA_NBIO,	/* Northbridge IO Unit */
> >  	SMCA_PCIE,	/* PCI Express Unit */
> >  	SMCA_PCIE_V2,
> > +	SMCA_MPRAS,	/* MP for RAS */
> >  	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
> > +	SMCA_SSBDCI,	/* Die to Die Interconnect */
> >  	SMCA_NBIF,	/* NBIF Unit */
> >  	SMCA_SHUB,	/* System HUB Unit */
> >  	SMCA_SATA,	/* SATA Unit */
> >  	SMCA_USB,	/* USB Unit */
> > +	SMCA_MPDACC,	/* MP for Data Acceleration */
> > +	SMCA_MPM,	/* Microprocessor Manageability Core */
> > +	SMCA_MPASP,	/* AMD Secure Processor */
> > +	SMCA_MPASP_V2,
> > +	SMCA_MPART,	/* AMD Root of Trust Microprocessor */
> > +	SMCA_DACC_FE,	/* Data Acceleration Front-end */
> > +	SMCA_DACC_BE,	/* Data Acceleration Back-end */
> >  	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
> >  	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
> > +	SMCA_EDDR5CMN,	/* eDDR5 CMN */
> > +	SMCA_PCIE_PL,	/* PCIe Link */
> >  	SMCA_GMI_PCS,	/* GMI PCS Unit */
> >  	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
> >  	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
> 
> That ordering looks rather random. Does it matter which enum number a bank
> type is? If not, let's sort them alphabetically for easier reading...
> 
> In the remaining places too.
> 

The ordering is based on the HWID_MCATYPE() tuple. The intent is to keep
those in numerical order for easy reference with documentation.

See: smca_hwid_mcatypes[]

Thanks,
Yazen

