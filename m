Return-Path: <linux-edac+bounces-3108-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CFA38593
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D181630EB
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648921D009;
	Mon, 17 Feb 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w1jfNGk0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861D21CA07;
	Mon, 17 Feb 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801210; cv=fail; b=enYQ+OaGuA32AQAyl2E3Z7mOpIatWedSN9Uio6D9xRu7DSpqFMd4oEFxPmOKL8C0PJv98z7oAa8Vx2GFG6MGnpJ/X8U9pZBmjJHtNujTXiG+ijLtZkKa7aXm4FrwNawrwkE2DVOYgKjuHt2oJseHebUkbqYvsePpbS9A4OLsyqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801210; c=relaxed/simple;
	bh=zF8Zgs2xaedaeEBYv4eG1mCOmx/CvwoTqgJa2CcrseY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dWe8wjGIuKfnPEgKOzQgN+3H6DYhb48PZ8k/qTFgi7guFx5zKwL7Kq/XoS0XRPvyLMtbwdalLgfNUwflrdPYnAYzpHpy7kqr9p1Z4b7XQ13yuts/g3JgG4wMq42KGdFa2UPK0cPYpkOO1MYkoxV6CzTF/0KHLf8k/GtTqsTU0mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w1jfNGk0; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDTiRaaSJzA0cHhsU9FyalyAxS83TRU0T83qqxAoKN5qdKpKOKh4+TQ/rBL1JTbskUInsvWAUnDxjgic/UPMRPD4xl9ldyaAbUsGBSH9w+ghYLkXRVwmiWouH+iFcuPFKxhwxvzX0RbRt/eby4aAYbbqKypJZJoPMHsmpIZgUzsOCYYAFAC1RywAtqyKtK5uHrf23RFzHQZupKYQRcG3XeP+t7bj014wvxCbmo0tL2HkGaeEyKKfgll6M63lko3gaPbB/Rr4Q9203aoX6TZ2/wFfiMURHF+Tm41PCJPtQp+fFkYHOuMc1+PnJfBkQE9pClYERocfDPxwrlrDrDJt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZkeIVGXv4ni361g+kJm1agZ4BGxnJ6jMCLxPwOHubs=;
 b=WPEAngkiLZwg7qOBJ+omKjw0IhuImtfsYEunciQWSrOvtazfh0hHAblC124CvBYtmonp1gXDPT0BTMJKEEUrm3hCebhzk78Duhd4mwYvJkcVZnPlxIZ0X+3nw9pKjYiUoaETANGvOEZiLp/6e8ZNEOcjYs8rEPJtTB/3Yi9tH8xk4tExq+TMgQE29Sfy/NDuCciBH4OtmVQyrjRZDsVuJYhT97YeiyiM/fMzlWf2LPFQ/BMqHVJs2onu+JeVKrid2jaH14nnnZ6UlFfviU5pdphpEdUVazCpdsZr7r6XYi3Vz8fAiObq9wFThzQTFM7Jmw9FdkvE8uBQ+XqGLd6iTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZkeIVGXv4ni361g+kJm1agZ4BGxnJ6jMCLxPwOHubs=;
 b=w1jfNGk0/rNmay15MaP1JcK3Mk3soeMDXONIphGVVP98Whb3+vqhX+MRN4TVh0APubJ1zjRb2Y8pN/cXOcSRWh7nNKHObmyo5WrEk7fvemsJ/Aty6KorSdaXQoFWIP1e7t7UEmAKtmUC84kgfSGquyoUoIZzcABXude1aw2eI98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:06:46 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%4]) with mapi id 15.20.8445.019; Mon, 17 Feb 2025
 14:06:46 +0000
Date: Mon, 17 Feb 2025 09:06:39 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 15/16] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Message-ID: <20250217140639.GB591070@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>
 <Z65zk9rbOvUivAfA@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z65zk9rbOvUivAfA@agluck-desk3>
X-ClientProxiedBy: MN2PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:208:23e::24) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa6052e-d91c-44d4-a583-08dd4f5c503e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkeWlL7zV2UH1TCtiVwpJ2lh4CxvNehN8fwzK/zQBUtL7Z8a6JJqQ+RQ4He7?=
 =?us-ascii?Q?neDQmEQOWXg6e1AGtIFaR0jC6OfN2RWEnfaC1D/FNYYBhkaQg2h3Hee6aUMY?=
 =?us-ascii?Q?NVA6vSTqSoD5lKXKi/hFdGxhMkt4nEZej5sJfF2NjYVGnHbGr5lo6FyScmkc?=
 =?us-ascii?Q?dbUJZm6DYur3YuTDgpz7Ppgn8HwgkymzBeMw9rjPWlXsxKdJybhskTvQi00A?=
 =?us-ascii?Q?nB6t9/vknoocZlVljsvJJiGr4KCXoQy4Tpc/b4aUOwzCxpXyLHzm07lsd+j3?=
 =?us-ascii?Q?yyQpFN65Vbw1z9vUYXtdkaQNUQyUKmuFBvlO42PPhDVCqIb6zVZyFOCbE5pz?=
 =?us-ascii?Q?+GVoy7pkJET4EXL1YyAi9wz9IXKA3/00OWZkoyXS18Jnwy8k015/aeSjZGER?=
 =?us-ascii?Q?o9rhdcmSCJYWrtmXdXTVNClIMOoFwx+4Nzg6gt8Mur+HDQvj8+3w4CqKQHPH?=
 =?us-ascii?Q?0/KkSzFFdYQqXA5sOMTwmxxDP0KDxdlKqqJXgHDkj+XJ+WtlWh5qD0k4XLhe?=
 =?us-ascii?Q?H2WHoIbY574LyBuee5ovFfnFEIUKTHSGmI7QxdB3/HUXxqdTV5u82kA+9vNZ?=
 =?us-ascii?Q?DIAGxzpK4M66Qa9AEAEumOh7xBLuyPs3ZsXrUGkGINnXKaCxckB852/odfwp?=
 =?us-ascii?Q?tOr5liImr1U80UgWJR53TvCZHK9t3PWDnF74kClZJK088vx4X52mAbBb0W48?=
 =?us-ascii?Q?dU1J3z9Dnhpi1Y3dInpAIauMnGOL/CPdZSAFPlMap1KQ/aDUe9BpVS6nPwdj?=
 =?us-ascii?Q?DYPRkggzxFD5ycxOsOaNwNSQr9neUE7zhdid/wX8Qdq/3j5yQgusThfuj11k?=
 =?us-ascii?Q?Ap/rahteW0yKpmk2R/bkp0Bdc1O1c9r7xnelQYGdt1tGm7eCxu3zYwAu3d1a?=
 =?us-ascii?Q?DIfC0dSzZElUymKS3+XvZ68g1RVH87brawgxRTFXanzUd8NrFpc3BYadCM2N?=
 =?us-ascii?Q?P4KfHzdu6rDlhbQoqpwcdlUghaBoF43aUYkvKVZqvIt3L1l2YDc1/Ewkbn4F?=
 =?us-ascii?Q?OybQLhYg+IVmxZgdP/3+eS9sFPwe3XbuDHEIFC+4x0yhsTTdNloiDWmBC2em?=
 =?us-ascii?Q?HxFDCp8tbqmfmFV79mWOfE45KmvADbHyRcaGd9pz1x7Mfj6BCrj8DgW+F+sP?=
 =?us-ascii?Q?ftl1x/U4AMKlrrQLlLTQNvwhQmJ8j596uhmFMChGSmD2mRIQxalXv5arjjHM?=
 =?us-ascii?Q?GTO1uFGUvWTwFEpO+jmX97Mrj5O2/OdGF0wGjC51GdB7ggAWL0rbY0dmGy2u?=
 =?us-ascii?Q?OSZhCvei+3gRrH9hvxQ4TppMI3C/E4LMDxvJJxplvktOyajqEWPbPagHibew?=
 =?us-ascii?Q?PUaXorWOhH77peqg4NDr3XXuBOumpvihMseaVogiPS0Jnj+FUpmyriPpswD5?=
 =?us-ascii?Q?pl2E049iYfPe9CFbEwqODaqUnK27n/vccKOjpVPGO7MgVhdPLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NR4U13XhRrzGKaQMV+p/DokYnndd8tBV97osfPJFMSwK82SNKh9lQ2lNVsoB?=
 =?us-ascii?Q?IHhp1VMEbhNHRdKX5no68svpGgqf8oiVrtaYLI9Wtx0RjaMx8M9/QeUOhdI0?=
 =?us-ascii?Q?AjtCQjtaYPkMNsn7PBYGDajNbJ7LmmmRyP7Gie33hOIPgH99PFXUwgnt1Rmc?=
 =?us-ascii?Q?Fruy5nECLha8cLUoWpJX/8MavtR7+TevCowd9kTW6aQjoh/RxypU+7XS/p98?=
 =?us-ascii?Q?Kdlvh2YPq+oDUCepueI6grMJp8iQJ/0/gVHSwWZGtLyHaqAISNzHprpM1Jy4?=
 =?us-ascii?Q?mup9JwNAkoZIEzJ7slEpN4txK4dvpdXifEPcLZ2bvCpIhH6RvkmUGkjWJl/e?=
 =?us-ascii?Q?8/HrldUKlMsYC/XPXiVRWgQ9ICYv9pCQBHSitmlnRx1gVo6Xt3hitbZfSgxG?=
 =?us-ascii?Q?Xm90pGwYttpqp7slc6fzhD+kpyzmXOLu2ANXisHkG92X8hf5G6vzHNnC/tCg?=
 =?us-ascii?Q?9AtDBFMSchPbsDx1f2a2jlHS6AH/1Hjcp/ixlPOTYaTkC84BYoV/cxDqVrMS?=
 =?us-ascii?Q?ZvvghUrM8TJpDkBwKih1lUmnJzAf6vdkKxN39DrsaJmAtnnHgXZaDnR6qUoE?=
 =?us-ascii?Q?s672FLDrsN20/3g4TYU03YYyWhS5LhPg1MR2ULPaoarRNcQjfhyXMB3iVSRa?=
 =?us-ascii?Q?nti3vOBX6J78/6f9tIsoQqRpQdsIRErPESbyx4LO4BPpMZ/iNwd+0bR+ihg3?=
 =?us-ascii?Q?PaJc8hw/2yjtEgj4TZyDtW+qmtBuE5EXPcxHYllhlqwgTq/MKQKNQHC6HMAy?=
 =?us-ascii?Q?ylX5O2DGebUOjnvwIWCK1Hbx2SKoNw6OLxZtm5cB6hCYDrVybQOLLHTGTkRG?=
 =?us-ascii?Q?AentcD0yENLCmLO+E/oJ3nXxyqzwfepT8+wqgHVlEJk5ma6sF7qDs0JZpBTn?=
 =?us-ascii?Q?hE2sHY1/JEhvvqDlBCV7M9b36/pE/YiBAWQHgZBJ3m3ssKt18g3fJVN4vcDJ?=
 =?us-ascii?Q?n/n6+SBu4qw5yIOKWX/7kG44tVwaxBvvyhIl52hkwIzFCrMM2s+wMjsc9R4Q?=
 =?us-ascii?Q?mfeFXoOzZsMXwRCYha6pDX72vt4sxofl1ZvcejCROjvn/wbKpzPI1cIslDuf?=
 =?us-ascii?Q?1A6VSYg3wVXl7vogr8j3tNQD5sxwPyjcfwFypL2+ouhV7SGm4ChEzz3uB55q?=
 =?us-ascii?Q?T4lH8kcao0CQ3Ojj7yF8ElEKyt4Oim4LoJvUUzK+sX08LbUUs9a4v/6e1r2S?=
 =?us-ascii?Q?98Q5fW/pdoMEwEqhl2qUIb21mPUz89qM5f8MA9eIxMrZq+vfpfq4oK4lYlY+?=
 =?us-ascii?Q?I+oE/iRjM/CNS9aD0JuYaAbbGpsxQbuDm69cudZ3Ryg/VqCNSQyqxBQXCaH/?=
 =?us-ascii?Q?SM4hTIBt8L9wvZPy4XpiXqVcloUjlWCydDmAu8eW+e9hIpGdqB1lwy+05nhI?=
 =?us-ascii?Q?cheMWTXtP6xe+sVzbLb0NY8oRi5nSUtGUBox85kSW3UIvRvWlWNsCZ1JB4cm?=
 =?us-ascii?Q?uUDVeyp/OrwjxGqwX7avUyxzPyNV+WEuOiW4e3/q2TKe537Y2rLZ99RhghUg?=
 =?us-ascii?Q?cc3tUfsXgGxGKI96DvyLmV4xkTbUt00d86UU5miLY8dGrINBeAmkmSunjjnf?=
 =?us-ascii?Q?uYOcznoQTpFN9no+07Gu4ubhMjC+l+vH+ePLLt3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa6052e-d91c-44d4-a583-08dd4f5c503e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:06:46.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kiUhfxnCcOH2mwpKhngpBfdV3cEnGWg4lC8GHakEyaHjBitubMdxBKCTTPXNS+FBSJWNLVov1OBuSQ4N5T9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

On Thu, Feb 13, 2025 at 02:34:59PM -0800, Luck, Tony wrote:
> On Thu, Feb 13, 2025 at 04:46:04PM +0000, Yazen Ghannam wrote:
> > @@ -306,6 +306,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
> >  			high |= BIT(5);
> >  		}
> >  
> > +		if ((low & BIT(10)) && data->thr_intr_en) {
> > +			__set_bit(bank, data->thr_intr_banks);
> > +			high |= BIT(8);
> 
> Maybe someday add some #define names for these BITs?
> 

Yep, I have something like that:
https://lore.kernel.org/r/20240404151359.47970-6-yazen.ghannam@amd.com
https://lore.kernel.org/r/20240404151359.47970-13-yazen.ghannam@amd.com

These sets keep growing, so I'm trying to do better about breaking
things up and prioritizing. :)

Thanks,
Yazen

