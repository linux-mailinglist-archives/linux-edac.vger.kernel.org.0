Return-Path: <linux-edac+bounces-5199-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA942C0E1CD
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 14:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85EC34FAEFD
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 13:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB1306B3B;
	Mon, 27 Oct 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pn/gSnBj"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21666304BDD;
	Mon, 27 Oct 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572152; cv=fail; b=o251f2Z1MA+ONY4P8DlGf0/RcVmPBb/RqKCYU2U15rUPWB3UKQmq9Jyy39IB5NKwarQDMwX3gYMAPPTInjtjrDz6unYQ/56L0M7QLR50tv9ClUogI41mhIVysTTqSunj+AcioWE1P7Dl5blWUtDw9TZs9VmsTerSFT8GoZkVjts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572152; c=relaxed/simple;
	bh=h9U4CSOr65l0QkLZbgPBoE9Bq8rAnwBpk+a9Kzj2Kkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aH7QiJ/zcS7Bg8BeiSyrFrh0vWOBbqDdOIuwf6aYrZUnvuhbxTRU6aquLN4DXzdG+6B4m46xIRktUC1Fc59CpQrnEm4Pkolr/lPWMY5HJrOsgPZXOG/lzfQtNszOtvdP20i6czheRf2FZGedkisQ+WPxN4fyXSfDF1FRPTCVf48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pn/gSnBj; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgtrIVFiv/n0V/rum4eB9ETwp8I1Ei7kD3IOySLfAGPkgcsr9Jeuk94gMdeKcPiPvKJYbihyu7SELiXuazJpYLu/Cn7KXk/oB+PNeMD/GjGuzArCsnjLhjl/MlbW2n85U8NJiq3vYvfJBcr6uYfM9wUwlz/9i4HL2ZAPpoVx7Ml3UJIKJCKMQ/2JlYyTg7ZHymnZANu6yFnn0aRmyBWPVMXQAquGw+aMg45t2C/7k00ZJQ/PSjiMVUr/SJkHrvp8RV0+vRZo+o+1JUvMDUVTar0BJlif0xSAQi6rJgGAUDUM+vIfLI4yd1yauZ3wXhl69ap2NZSCz9DPMWSb4Im7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy4dUH2ayrOouBOlHa9UynWRmUtN7FvcZCY5j2q+ZKA=;
 b=NALwGJZXFQgA10muYnNnyl+5XSe55wbX2UaTNLz9z7zM/qEb9+NwpbsCmIFdtfjbNypxktkrlsqeNak70vdgZ0wSU2YQ60yiqMOLsl1CesDSjMjDScs/dp5JVaMHFHhUVQmMb2G7oO9RO+R0k2iKQ4PMU8QJWQD1Fjxi0gOVCGZID8Vkd4gYs29EJRsfl64WS4N/5ELyAMrECu+UaEeAqo9/Y9IdyzWbt5gp2K/ljn2KHztRQu/6BcEdQHo5Dfq/1IP4khQ/J7HnaiWzSRmToBTiSzJrYsO+y4E+Lood54Z5OB9WCibaWrDs8VuXBYDt5Jkl4Q1kLJBQgwbanMfn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy4dUH2ayrOouBOlHa9UynWRmUtN7FvcZCY5j2q+ZKA=;
 b=pn/gSnBjyWTjcCe0GCsBg+a5+SSSlEkaCFXjenXZfkmaacnn0vDwc1UWL8Uj25gmKPu4lNVjIVsxMukihHup84pAIyzyPsZtLrxbHQGlP/imzXysybIT69UEnQnyANSlilgr75qPfMPXKZEuHW7jvTAb9PqXTt3275hmDKM2WwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 13:35:47 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 13:35:47 +0000
Date: Mon, 27 Oct 2025 09:35:42 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251027133542.GA8279@yaz-khff2.amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: db40c8a6-e46f-4757-6f84-08de155dbc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZ+c2A7D3TMte8ZaSEY+u+Ot18W4hR/U2B9C+5JKp0Y0Av2fckwOKSVbF2lK?=
 =?us-ascii?Q?EAcYofReLqpVeuiTr/rWx4Tg6fuNNA+1aYGLz6EIAoJ8YQnpSF225ESD41eg?=
 =?us-ascii?Q?cm45FMBA3z2KT57iq6LIfNgFQvHJ4mAQ8DmBNF2yIM+WtEDaS/B5aELto775?=
 =?us-ascii?Q?yfAztEdemtWvvSZ9PO9IxrfG+wc5/Nfgbvpa6YapptIrZi90CKSJNT2LgEWo?=
 =?us-ascii?Q?4/fe+q7OGTVbrX4TcV4GMNOd31pMeS1EtHJ+iOch+eAB2GuvjKMtIzfvMjku?=
 =?us-ascii?Q?0yySjUVMj9MkSrE3vSEpCkban9i/o2BykjHKW9j8Y3Itdbgd64lXsHNMgM51?=
 =?us-ascii?Q?oroHAWk1Cu6H6mTNFRUc56vkJl7dvqutpXIMcLLgA6UM5F6PDxmf7+yL83xi?=
 =?us-ascii?Q?dYDlB+MYUb1Cw4SGEt6BWLzk9ow366izeewYaAPMhskLEsja1Dfe6P/2zf5f?=
 =?us-ascii?Q?XpubderIBbUa8oCJJ/PyX6QASKInrVd56xaFh2NttXIrf0GRmq+RS7gbO8MU?=
 =?us-ascii?Q?MQPrSqnvXe3D0TT677sgNkn9XfeyS7pKQ2/YEYZytfJVWPueTvyWmWuzDtQu?=
 =?us-ascii?Q?a3YRfl4VN/g9SyVxemVFMXNboi5CDwJIQzqgO++opVYk/QvuuWNrYMWPv9qZ?=
 =?us-ascii?Q?XzIBwe1HTW/lXoTSRm9jO9aNrjD8ybXrNXtNxWBjjASaazNMW3a5rjjCqd9j?=
 =?us-ascii?Q?NOFW+J/6PddJGBC3oaOrfiQ4F+v3gYluzHTm/F9Qa/ldg0QGM7JD0NVyjCLJ?=
 =?us-ascii?Q?T+nEZ7/fsj0I2b0iWmY18i0ihBk3ZYKIrQ5mK625uJgjeMSZk6U/y2pYBHQq?=
 =?us-ascii?Q?ZGf4EVtlukkQUs53ZpALsg00E4fzC4AjCFvnvtFbjOk0sTnmJSGquWSDoax/?=
 =?us-ascii?Q?4vLNnt5VCBGFZuXpoTNr6W3slznZ7RNgDB84KDnpJ6J+9Fs0W+NQsMH0atdn?=
 =?us-ascii?Q?HkAUUkj8WoY+7PUbpCQz+VZG6Umk7YiQAd9f0OV5yryMdSUGQjhXLnmO3Ocn?=
 =?us-ascii?Q?V02Isk0vI2wqQZtj58U0wK7MdHRjncQLChpPzHIALs+tSCBMCaUOAhf1Bu8k?=
 =?us-ascii?Q?pIzyIbdnbnPMIIY+yptkqtl/VRXjmOc1JLhWftSrvsPQUWqsCiKDJEte/M0v?=
 =?us-ascii?Q?WydDKQuGgxuwT+CG+1SlSf0ia1pV6OxsO3YiLtPi7D4OhUGoKxj3M4Tx8gjs?=
 =?us-ascii?Q?cSt2iLUXYFksk9tdybfPiQ7GcbywN082+3dIQ7zhHuf1EqvF+t3cUFv72dcu?=
 =?us-ascii?Q?KNuMueJGvZLXn7FBiDJQ3d2DDey2rFvBwiSZDNdBIkiKD3deWhO/TDZdUeEO?=
 =?us-ascii?Q?gJXTT49F9zqHbtUrRVVw1J62+rFUNLHnocJzIlxCvdwlE5JgvtzvXC8qJc7A?=
 =?us-ascii?Q?Cr/K8ZhyyAZ/o42ICb1iuL0hltyVHYlnvA2/Kzk0zvvb59Z39A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K7kXfJoCBjWhFY94RticgVsI6/tz1CoKki441TLT+cfvOGnMt5OTQIpvv7NP?=
 =?us-ascii?Q?DvFXy6sLP1cADIkhjjXcUs6oztLzQSCOnVjUvaWsZvHH922B2Ab6QNJVUlYK?=
 =?us-ascii?Q?I7XPWn4KLWQjE+gRDLK7I4VVrngf4baPKiw57bgtvRO0s+whODLzXWJot1OT?=
 =?us-ascii?Q?0MzVotLjCNWT4OKrsfQXGtorLnZjto8zflR4UGM5gc/p/fiC/xfeRNkPRV8u?=
 =?us-ascii?Q?zCGfiOHDHpp7DHKFitjnUzBRkQ8l0lb1zSrq6ivKYsmJexQUopxUnI66bBLf?=
 =?us-ascii?Q?6AtcUrBBeXfLsz3HtRnVnmxhf7qlF1Dfe5M4uH6/ZLpI6245oXjl/621Wr5u?=
 =?us-ascii?Q?mfmjZF//8tC2MKuPDPurOPfyBlyY5VbNkxXVTD+sVAsblR/TfigU84RAAWlf?=
 =?us-ascii?Q?Ni2zm/9h02uEG7goiPdZC1x+ax/9ieM7wtlTzQ7g1TRDNCpZ9d5TmL9/tTTJ?=
 =?us-ascii?Q?dQXqoBEyV+3D96PXOIAnO7vSYq2yMlzriKXv2kHQ3DpDOjlHlUxoD4kUwNPG?=
 =?us-ascii?Q?NKBZkS4CrWS8BmCDWKZwKoiZ6HCZDY8OvMmqZof1pUYz1z8ZG7CBoTVHseFT?=
 =?us-ascii?Q?ouqD4uVwTMpfYGGIwb5GHtjH7hNgCKCV+6yeSTQdU5x1SH2syJ8Pb2ueGwtF?=
 =?us-ascii?Q?499X6thrtHeUDXSm5wkXtu9QwAXh4DPyVqZQvR2GWQt97cgkgZb4JPbX5wMh?=
 =?us-ascii?Q?kckwy+NpVsOXbzsof01ZG/4B+pw+1ZeKu1uhY1B3WLuhQqoi+SUz1SFYz/9f?=
 =?us-ascii?Q?44fK8+JEUyJ0NQFOW3Lfj7CkeUWFaB/SnnAMDPmEF/J3JPKsrA21gxCeTGeV?=
 =?us-ascii?Q?FOF50aNa18rKOBWuD779Wm5QgwFDzE5qAE0zR9mguz9SgjwnZyQepYbOI0nF?=
 =?us-ascii?Q?rMPRrq3DeXs9uJHfJSIyIHV9sk1pxBX2KtCh6KeC3iuy2bhzOHR/drhZpIF4?=
 =?us-ascii?Q?WCV6coDIK6p/eY/4uh5qIbtJOkhEimEWUfdo2JhHfHdBNafUQKFI9Akod33o?=
 =?us-ascii?Q?kXVvZVuIGXwV03P08AXaSnIBt1O+70o9vwwuciccXGVeZnxZ1bxleJN3JOVS?=
 =?us-ascii?Q?l6PgpZILMu8K8+xYrE+ANwFrE1MU03qL2MTWLj7rW0/yr0Qdi7MpvgdRFPnE?=
 =?us-ascii?Q?k3nc45qdpr6rCabjoPEOojkVsIWEwLHR5YPnnRvTXJ+HExGNPIQcvMvqUGCI?=
 =?us-ascii?Q?5SVzGM5j8UsQjMXo//iuIdLai3QFlsQWyJiPudBwdh05GjXmHpiCQ/cILBb3?=
 =?us-ascii?Q?upo4X5DCQv60Di4l23tP3D7Bo5KKH7CFFs9hDZ8L6uSAXLnb0fxjQyLrfEGm?=
 =?us-ascii?Q?RGWfdicoGI9gfUm+AtUMaehOKsZxTWegvpQXprRJ1Ye8/AG89HHHlLx9itU5?=
 =?us-ascii?Q?8jlhY5nJI29bs92zMroxHbOAkhXXopHkJ8DfvroGu8FuVAunCy3z8y/8vgWF?=
 =?us-ascii?Q?U+QSpaRBkPcFzsa8rKFKIX1rb+AAnuI1CK0adAyCvPVHkwcUIWFuALP7PQk0?=
 =?us-ascii?Q?mK8IAq4RxkUkZCyAN+HC+adSsifgK2OoUJ1Xw925HKK/BwgUD0//X02Or3Ry?=
 =?us-ascii?Q?N54bilXI6lBM5+R9tAwvw6zyIC03o6D9CCSUb1JR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db40c8a6-e46f-4757-6f84-08de155dbc48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:35:47.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CenoMm9C2U1BRWzrjgpVwgdwzQhCnCaF/jQGLGxB+MAjHyOSnYI6ifSV+2sEUKogUkBRF4YMGW3bWd5t7TDFjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

On Sat, Oct 25, 2025 at 05:03:04PM +0200, Borislav Petkov wrote:
> On Fri, Oct 24, 2025 at 11:27:23PM +0200, Borislav Petkov wrote:
> > On Fri, Oct 24, 2025 at 04:30:12PM -0400, Yazen Ghannam wrote:
> > > Should I send another revision?
> > 
> > Nah, I'm not done simplifying this yet. :-P
> 
> Yeah, no, looks ok now:
> 
> ---
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Thu, 16 Oct 2025 16:37:47 +0000
> Subject: [PATCH] x86/mce: Unify AMD DFR handler with MCA Polling
> 
> AMD systems optionally support a deferred error interrupt. The interrupt
> should be used as another signal to trigger MCA polling. This is similar to
> how other MCA interrupts are handled.
> 
> Deferred errors do not require any special handling related to the interrupt,
> e.g. resetting or rearming the interrupt, etc.
> 
> However, Scalable MCA systems include a pair of registers, MCA_DESTAT and
> MCA_DEADDR, that should be checked for valid errors. This check should be done
> whenever MCA registers are polled. Currently, the deferred error interrupt
> does this check, but the MCA polling function does not.
> 
> Call the MCA polling function when handling the deferred error interrupt. This
> keeps all "polling" cases in a common function.
> 
> Add an SMCA status check helper. This will do the same status check and
> register clearing that the interrupt handler has done. And it extends the
> common polling flow to find AMD deferred errors.
> 
> Clear the MCA_DESTAT register at the end of the handler rather than the
> beginning. This maintains the procedure that the 'status' register must be
> cleared as the final step.
> 
>   [ bp: Zap commit message pieces explaining what the patch does;
>         zap unnecessary special-casing of deferred errors. ]
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/all/20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com
> ---
>  arch/x86/include/asm/mce.h     |   6 ++
>  arch/x86/kernel/cpu/mce/amd.c  | 111 ++++-----------------------------
>  arch/x86/kernel/cpu/mce/core.c |  44 ++++++++++++-
>  3 files changed, 62 insertions(+), 99 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 31e3cb550fb3..7d6588195d56 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -165,6 +165,12 @@
>   */
>  #define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
>  
> +/*
> + * Indicates that handler should check and clear Deferred error registers
> + * rather than common ones.
> + */
> +#define MCE_CHECK_DFR_REGS	BIT_ULL(8)
> +
>  /*
>   * This structure contains all data related to the MCE log.  Also
>   * carries a signature to make it easier to find from external
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index ac6a98aa7bc2..d9f9ee7db5c8 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -56,6 +56,7 @@ static bool thresholding_irq_en;
>  
>  struct mce_amd_cpu_data {
>  	mce_banks_t     thr_intr_banks;
> +	mce_banks_t     dfr_intr_banks;
>  };
>  
>  static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
> @@ -300,8 +301,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  		 * APIC based interrupt. First, check that no interrupt has been
>  		 * set.
>  		 */
> -		if ((low & BIT(5)) && !((high >> 5) & 0x3))
> +		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
> +			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
>  			high |= BIT(5);
> +		}
>  
>  		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
>  
> @@ -792,37 +795,6 @@ bool amd_mce_usable_address(struct mce *m)
>  	return false;
>  }
>  
> -static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
> -{
> -	struct mce_hw_err err;
> -	struct mce *m = &err.m;
> -
> -	mce_prep_record(&err);
> -
> -	m->status = status;
> -	m->misc   = misc;
> -	m->bank   = bank;
> -	m->tsc	 = rdtsc();
> -
> -	if (m->status & MCI_STATUS_ADDRV) {
> -		m->addr = addr;
> -
> -		smca_extract_err_addr(m);
> -	}
> -
> -	if (mce_flags.smca) {
> -		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
> -
> -		if (m->status & MCI_STATUS_SYNDV) {
> -			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
> -			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
> -			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
> -		}
> -	}
> -
> -	mce_log(&err);
> -}
> -
>  DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
>  {
>  	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
> @@ -832,75 +804,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
>  	apic_eoi();
>  }
>  
> -/*
> - * Returns true if the logged error is deferred. False, otherwise.
> - */
> -static inline bool
> -_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
> -{
> -	u64 status, addr = 0;
> -
> -	rdmsrq(msr_stat, status);
> -	if (!(status & MCI_STATUS_VAL))
> -		return false;
> -
> -	if (status & MCI_STATUS_ADDRV)
> -		rdmsrq(msr_addr, addr);
> -
> -	__log_error(bank, status, addr, misc);
> -
> -	wrmsrq(msr_stat, 0);
> -
> -	return status & MCI_STATUS_DEFERRED;
> -}
> -
> -static bool _log_error_deferred(unsigned int bank, u32 misc)
> -{
> -	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
> -			     mca_msr_reg(bank, MCA_ADDR), misc))
> -		return false;
> -
> -	/*
> -	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
> -	 * Return true here to avoid accessing these registers.
> -	 */
> -	if (!mce_flags.smca)
> -		return true;
> -
> -	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
> -	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
> -	return true;
> -}
> -
> -/*
> - * We have three scenarios for checking for Deferred errors:
> - *
> - * 1) Non-SMCA systems check MCA_STATUS and log error if found.
> - * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
> - *    clear MCA_DESTAT.
> - * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
> - *    log it.
> - */
> -static void log_error_deferred(unsigned int bank)
> -{
> -	if (_log_error_deferred(bank, 0))
> -		return;
> -
> -	/*
> -	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
> -	 * for a valid error.
> -	 */
> -	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
> -			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
> -}
> -
>  /* APIC interrupt handler for deferred errors */
>  static void amd_deferred_error_interrupt(void)
>  {
> -	unsigned int bank;
> -
> -	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
> -		log_error_deferred(bank);
> +	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
>  }
>  
>  static void reset_block(struct threshold_block *block)
> @@ -952,6 +859,14 @@ void amd_clear_bank(struct mce *m)
>  {
>  	amd_reset_thr_limit(m->bank);
>  
> +	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
> +	if (m->status & MCI_STATUS_DEFERRED)
> +		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> +
> +	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
> +	if (m->kflags & MCE_CHECK_DFR_REGS)
> +		return;
> +
>  	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
>  }
>  
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 460e90a1a0b1..7be062429ce3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -687,7 +687,10 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
>  		m->misc = mce_rdmsrq(mca_msr_reg(i, MCA_MISC));
>  
>  	if (m->status & MCI_STATUS_ADDRV) {
> -		m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
> +		if (m->kflags & MCE_CHECK_DFR_REGS)
> +			m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(i));
> +		else
> +			m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
>  
>  		/*
>  		 * Mask the reported address by the reported granularity.
> @@ -714,6 +717,42 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
>  
>  DEFINE_PER_CPU(unsigned, mce_poll_count);
>  
> +/*
> + * We have three scenarios for checking for Deferred errors:
> + *
> + * 1) Non-SMCA systems check MCA_STATUS and log error if found.
> + * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
> + *    clear MCA_DESTAT.
> + * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
> + *    log it.
> + */
> +static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
> +{
> +	struct mce *m = &err->m;
> +
> +	/*
> +	 * If the MCA_STATUS register has a deferred error, then continue using it as
> +	 * the status register.
> +	 *
> +	 * MCA_DESTAT will be cleared at the end of the handler.
> +	 */
> +	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
> +		return true;
> +
> +	/*
> +	 * If the MCA_DESTAT register has a deferred error, then use it instead.
> +	 *
> +	 * MCA_STATUS will not be cleared at the end of the handler.
> +	 */
> +	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
> +	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
> +		m->kflags |= MCE_CHECK_DFR_REGS;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +

No, this still isn't right. Sorry, I had a brain freeze before.

This function only returns true for valid deferred errors. Other errors
return false.

>  /*
>   * Newer Intel systems that support software error
>   * recovery need to make additional checks. Other
> @@ -740,6 +779,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
>  {
>  	struct mce *m = &err->m;
>  
> +	if (mce_flags.smca)
> +		return smca_should_log_poll_error(flags, err);
> +

This will never find corrected errors or uncorrected (non-deferred)
errors. That's one of the reasons to add the MCP_DFR flag.

Otherwise, we'd need to include some of the same checks from below.

>  	/* If this entry is not valid, ignore it. */
>  	if (!(m->status & MCI_STATUS_VAL))
>  		return false;
> -- 

Thanks,
Yazen

