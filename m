Return-Path: <linux-edac+bounces-3218-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02528A48546
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 17:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E7E18989F4
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A44EB38;
	Thu, 27 Feb 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eMQgQWni"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5A1ADFE4;
	Thu, 27 Feb 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673921; cv=fail; b=RTOMbUhW4n3y2qowhswXpFdUwVkuWBWxB3jaSm9ze11DzO4J14XmQ+l5kWBdi219+O6jkqjp5Q66lMZIIkLl6WZLqiQ4tDmUdaVXgBJJfIYTpT+DJNvBzHspzeD4cBy3KGVAV8ielFTs4OHfEO6sr9Xd6miXN81PGZGVYvGglrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673921; c=relaxed/simple;
	bh=iL0YqAiiC9DoFIYVD7vWstUzBwGU6YVcseCCTB2toTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Akd9RqRnXSFHdEYPH61EfnzCorZuFArA7tg66/MlwG3aEyEUTV33CwgOrK4RlrPgd5Aoj+lkLbaPHqkbCSJVfypKaDj8sEJq9gZ3qDAY8YOHPQOq71b3udp6AGH/1fL6b19xZuYfyOdpf29Zzj3q4qQ/ykW7JotIVRQPJAhxCrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eMQgQWni; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cqh71sB9RXRFb0vYextsNvXjOD7yyGy6vFBHowuNiwytWRlMRksjWAri5/9mpXjjfWChwY8ZLC60H5PGozQaZe41jN/EgNGeNJDqzier4fE34AKDqXYQQZiaMS7ATFPNdUtfiVZ3dd1MTNO2XZ/95lA8P/5+GrKtJOg+ejtNeaa7LV8wfYsUX2qYamvwpXI8oY1ULzn33F6JxnFM9COuZD3nxPg067eH33l6LELDpF9mYzsLp/khTJLpY+ZynIrxbevVwwRCm0yyBZRmb1fprsQMrFPVDrIJf9h8S5C0lVkJjvMlht/E64/he6OWYplyvWpFE3h9wkOQIhRahwSJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SJ/m0Ejw1G3PmBmnIcZdwnybVeylxyhfPvWrZ1Yeb8=;
 b=zGtzhZg10ZIA5ZjxHGlN3hsCj7aSzrVCQkD3GLv/oB+sWtdm1F3mSNQsvRuVyN1GWqc2dVHNDauaDYP/QYG562ZvZ9xJucJIgjKwjALLrtNSw/0YbcYzDs/5M3xRrzSduyvIM/6qChRI5bgNVIf/KZX9l1u92aXSQTcTTnqk9BPOyA5neFduoJU1/Redpn717Q5Ph+8JBWxXbTNOblJRNbJaO6e7/SV3l90yE1dvhuvYxF7SWR8Rzg86uJGep0cPQ59xVNCFHyRWh0g5m+tj8xDSuQCKcOcz5tgf0JbEniVxQVumwcV56JK2lopm4c3bsYT5fQNSvJoPQp3xm9raXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SJ/m0Ejw1G3PmBmnIcZdwnybVeylxyhfPvWrZ1Yeb8=;
 b=eMQgQWni7dTDugwxnh06jZMgKH21FpydAJy5IC0ctymemBfjPJAMiikT3NdEaNTeSwKT8MzHYf5RhkSdO7FSRoDHEy6zXAHxe8z0SOSh5vT1ZhilQTQePLtmeHQdWZGUPsLw6w9L6+mwbSFhjXgHUiJUMsmDSWwmJus1hknOgJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Thu, 27 Feb 2025 16:31:57 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 16:31:57 +0000
Date: Thu, 27 Feb 2025 11:31:48 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <20250227163148.GA785742@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
 <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local>
X-ClientProxiedBy: BN0PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:408:ec::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ee9fb6-aac8-4c95-9cc0-08dd574c409f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYAqUTu81IgnS8Sa81ubVL/ui4r363Fw9KoSL8hCLbCidPz/cVqQSKfEeIZx?=
 =?us-ascii?Q?cyXNvTsMZvLmIK5IzaEsdo26VhSDUVa62Ik4DoPSmz4brwMOf3Og5C0cLsvp?=
 =?us-ascii?Q?zbWhkIeZnkudgyv5ADQhsFvtjZASGUVM5SZt9+bAjW/SpzCLMjEC0B5F3/5v?=
 =?us-ascii?Q?1qFDoekeAM22jtkeOQn9lrMdsrkW8bSZ0KoTcFx7q6tqN45wyh4PF7HVjxxU?=
 =?us-ascii?Q?aHh0xVKx8a3GSv3L51zkfo0vHo+hC6aE2ZPknsXdGLwxRGVBrr1UmvHKnQew?=
 =?us-ascii?Q?Bn5mFv6qyG8Z0G5rXB1uTepprtKqHB35lqLpFXHlc1IhyBtf7pHbHD45zea1?=
 =?us-ascii?Q?8Ok8jK6Fi/LS69rmvmns9upjnYL9WuL71epGXEE97HkFAuZV//KCH5FDmBOI?=
 =?us-ascii?Q?LEASE2ZmGWcfZ6LTcpq/WT5oJBR0t26bnG6TOnngMQBCbuQ02/FPtWooZ0wH?=
 =?us-ascii?Q?bYMYNcs43lDtBvSYFDBMF1tdMAmdfXTW918ywS78E51YFHZow0+plLV5LIIm?=
 =?us-ascii?Q?ZzZ1dJjJlnfTyDTGKsmH7Lhms8GmvJJbFQmf1im3IhouAKexm1KnGMakIyuG?=
 =?us-ascii?Q?9Q1ReH5hHmTKY71SSg2nEgfwqbtuAY2Nepvsg54g1bUKhrri947mNyytKRef?=
 =?us-ascii?Q?zaHZhAogthdsPtad2/s5SKa4qFKHvjmNQ/Cvs+5iZKpHVZC9jMJjWtcTaiUG?=
 =?us-ascii?Q?9GULPshPqwErsrFFy3XgrgjCV69J0DEzxbOqP1fBHzvoeUHB24HXvRysGWra?=
 =?us-ascii?Q?riEoxkUdgLvuXO+bC3nh/5fq4VB1PSTonEjz0PrUKlwlACu2rnju5RBgVL1W?=
 =?us-ascii?Q?wlZYKvq+O51gViRRjQYeA4IgfbI3YtZCJ0g5YPEIKIpAQ4esDAr0wGHxIRFs?=
 =?us-ascii?Q?UXbmuj7n+HYfZKG7T6H9pwKP+6oFS6rnrkOSXWkxnVZETa0AKn38vMXhJv7l?=
 =?us-ascii?Q?J/rmGe7iAtxxyJYR3bDGa0IbIkqshKNNGGlFIF6lXDKmMQIjC+JdqWDW6q2h?=
 =?us-ascii?Q?eTMC4vq9PMcZl+AJ6L9jVxTyI/W7bIDiNDUdnwWMyrwjIVO6gQp0Nv90i1CQ?=
 =?us-ascii?Q?lUo80aWUBSfgBAu9/qFTfYZtIJlj6tcn0cfFWKDm1pdMZuUe895nQJypfK4H?=
 =?us-ascii?Q?CMAISMCDE6AbDoQgdEGp1GJHvJbmGpd5emXDFgIWfqdb4XPwErPXVYIwNgMQ?=
 =?us-ascii?Q?gC1iOqvZU+o3pYKg7NEocSD9OuRVaYMaYIGr0MMgoAO2LGXmVFgXwOr6ZEjz?=
 =?us-ascii?Q?j4oVwHlbWO5aOwc+PYlm+7ghPqdM4WOP31hcBFQD+g3lr62uUqOkMN/AbXoe?=
 =?us-ascii?Q?qYJVV4NCgt/5iGtGluiWNjSo6SCUdgyVYLvVQtjeTo845Z0fOw2Gi8+D6Mjj?=
 =?us-ascii?Q?tYGxKYc4nzamoSvbKYrVoOsqce0F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SkRyAqChTqK4RwQivivgCkpMc40a6RzYb6NqETTwetn0uXdknss5V+Cz4M9K?=
 =?us-ascii?Q?8GQjXcvqT9XMQUFx0dGRFwOCAizvTS4S3s8oazcYLktSeeRA1Y6keeQcP1jZ?=
 =?us-ascii?Q?DRfIp9F2Z6jmqOHwMIPawuyx05uXAHHPvkjte2IqocTQSwYVFyj8kFvuYvCc?=
 =?us-ascii?Q?F+vbcR47F2BOBSld0yrCHx3F3jye17AuVpqrjbvTuU7PuopmgY+l0S4selGu?=
 =?us-ascii?Q?Q/jIHJgmL9df5dj9+XVKlmRDmt1GPv3BEQ8cEzi26gzmpfIz7UXvjFg064do?=
 =?us-ascii?Q?JwGNy9Y2vfPTLBe90FZpr3XeGKAOoZ7RrQ7Mj01toVK3cYFjaP0ex0Rg3r+p?=
 =?us-ascii?Q?V90BtpB59yedpHZHRMBlVkTgiAVlPFlqz416TJjCl62uHshu0nssKtDp6SEW?=
 =?us-ascii?Q?ZMnS6xALphpB3+Ouzp1VSGNZG3mWZ167weYpClJbCvAmKOd14aFPBXhQtODg?=
 =?us-ascii?Q?D2HDgri9fuLvdKNc3Lj2uYOWoX4lyWuHisnw0qEsbqVsWg4Z1MG2pMv1v5jy?=
 =?us-ascii?Q?h4RoKZ29Qp6O2sFlZpQnC90rU/+kaHxybV8OPbKJ1X/PvrcL9dxOnveLEx6J?=
 =?us-ascii?Q?YLVsv88v1YRvpITDoTMDf1/YprLMtPXwr+XvaC+h7+kBIVtbG+rYXVOH6L8f?=
 =?us-ascii?Q?pU17Gc4tJkAWnoojKtwmaYEaMB/5BCHtyOxTOd8JCCOP46k7O7h0pO+5OjCj?=
 =?us-ascii?Q?klVgoOoetZCKvuylgiy9/qevWrE3eeoV5Ik9nX4VM6KhMsdAyYpNlnyOboVX?=
 =?us-ascii?Q?agK1DV4OXfFaf9C45ppxcszsmtt3eZ71FQLH4OdboX6dFJyCg1ajNGc+8NuX?=
 =?us-ascii?Q?TJPoU685XQChq80PaGXHg9iuWWlbxyYDrLBjAzGIVUeUjrQp+x4dvGhrnhb2?=
 =?us-ascii?Q?zw2mLDIRiR1mWCCrbx3jS4K5b9rWWmnQWWBfH9Y7o9JKWPjuk6mEyeQUqdkq?=
 =?us-ascii?Q?ofkN7WPZWGB15PiSXg+tISFQw+QDmuE+pl+kamgyYcg3fjU+YGUGxIE7PkUZ?=
 =?us-ascii?Q?b9QSAY/cSUMad/B443l9p2CVIuqWSTTeW4jenCzjNHpBM+GOiV9lYPSvrDE2?=
 =?us-ascii?Q?73b1CAHn+sperTa6EkEgk/OGxK9bvgE5cc5zsTz3/12n3mZkiGKQkIrU3PXy?=
 =?us-ascii?Q?hTcycQmB6If+v8pKJIWdd7EuUstr37TpbBu/PFfYi766fAbjFtCgj4qaaJKL?=
 =?us-ascii?Q?Qo/c1ztMgyjWXH0ipyMW4WP3h1yWAxUPDTrNcUReZxyHom3xuOFYvM3bBrXK?=
 =?us-ascii?Q?g1toqkoAMSVBIS9pDm1kZbMsQY0k8Bjqsmn0QMB9Fi76Gwm6YH72gox/9cXH?=
 =?us-ascii?Q?nrxVo2+DIIr5+JqY68N1UehTZPM2bbIrIQzBXHd1z+JRDE9TZpt5elZwmaSB?=
 =?us-ascii?Q?/hOvLoQmeQk4q1MOK6c0zs8E/8fJIddgeIIyXMYogouGVDdt6tTiFp+79MMt?=
 =?us-ascii?Q?ymY6FZSTuKBAinz2Ndd5KMyxy/UaQa8cVmfmQ7AgfqKZlemldvXe4paVB44Y?=
 =?us-ascii?Q?yGusw9bpsmfoKZ3rTeTNbFMR4dC31b5cyjDOgJkntJtuBTnFOrkPR5/Fvbng?=
 =?us-ascii?Q?M9M60jan2dHNe3QYnLq7Z+3AizQRlRjgkT1H2rIG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ee9fb6-aac8-4c95-9cc0-08dd574c409f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:31:57.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5CHBPpet59NtSO81T4lAMAFjSqhiQfWCGFiM/2KkVUf2HvRugpSBIKP+IHZFNfvKSVwJ8Kl3xaPBl5sNLvaIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

On Thu, Feb 27, 2025 at 04:25:00PM +0100, Borislav Petkov wrote:
> On Thu, Feb 13, 2025 at 04:45:55PM +0000, Yazen Ghannam wrote:
> > Also, move __mcheck_cpu_init_generic() after
> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> > MCA polling event.
> 
> The reason being?
> 
> Precaution?
> 
> It was this way since forever, why are you moving it now? Any particular
> reason?
> 

1) To read/clear old errors before turning on MCA. The updated
__mcheck_cpu_init_prepare_banks() function does this for the MCi_CTL
registers. This patch does this for the MCG_CTL register too.

2) To ensure that vendor-specific setup is finished beforehand also.

Thanks,
Yazen

