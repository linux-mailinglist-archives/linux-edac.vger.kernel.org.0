Return-Path: <linux-edac+bounces-2529-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CEC9C75A8
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B692FB3A8A0
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5641F77B4;
	Wed, 13 Nov 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IHkihaOT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116262AE93;
	Wed, 13 Nov 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508292; cv=fail; b=t5GY1qbkHJmdccRGAvBcu8QAG+Bn6Hx24DXXUi5+VXcfwuV8eN3/lT7nPCXTaLFg1xJ7vm6rCfM1EnllChd/IvWFviF7h/9KKWHdBr/eHWr1nvxBgbuwF72vFYFlRYMgumBTf7MwhCbcRHPH6SPYrPoTGHVU8vN4fKxiDRpdrWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508292; c=relaxed/simple;
	bh=/bNI+tK+n40T8z+CasklIvUOD1lXMmOMCCgc+PYU6/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OXQYX49KpBgMsvN+2mixyd1NgxlaTvIBLRNh2j/jOltfGRk/dOUQKq4oCF58CnMfK3x9ljSeBHXgTmtpopM2XGMNIzpS9JW701q52/ymQh3z78GSU1KcuqfjtcpPrCBF7l7CAEO91k43OeCAmcjUuJiBbHSoYQjQ9FxD5IxB3tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IHkihaOT; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVzgpOgiwtfBWMQl3gdH4sMKoq2JggfIM0AGPSDaqZHor5RtVWaQeZ0VXC94Nj+8/KGzoan4SlBQUdsH/XOgm9/t1yGYH2ZULLj0yPTx+4R2bb66Vw4qQ1aZDD1BoLSUGizjUN5S8itcvlSEImhn4UmU8SS19BQnG5IZpWwtYLQqKpUN3bS7aIsXp2E66X2mnmmh1NQDlMiyvi5Epz6MEkTAGbXemJIRZSM2Bs1+T2R1mHlKCvC4bEz01wHx18qWWr8d/yqjyQB/UKbTAH6RIPE17e1XLieD3TII218r02UwVCcs5hmdobqJjl58MM4H7g9fPzr3qDWAccUMESlryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiFExv+OGBhb19z7TZ2lpSO+UkOCCrCDp35yy1bo3L8=;
 b=pF+XFoupukEn5+X2aO2Ba631cWkvKQ5Aba/YDwVlpdcCKFoZ6VCfybxIPIdd7F1/WzaatDxsEuNulEyRq0XA3vByumekEd+ho6MXa4u8nyLr7ia+nBCBVI5goKBcOBDJQqAO6u9btvMPxcCrOveWX0YjDL53DcohrhbTDoCxm75dBmvphARomupjUYSCLxxpZZRWjBIGYgXP2zw6LsOmS27w/mTywHJtMaseitcZYNQJdTNgjrfIIVCWqIa0tmGXGhDXmkSIj3uPMC7h0LnWtkX00ZuGPxNGrbvZwdnezOOKcHMovyaBUQaWhYcbA2JxtLc8EwUGlbE6r79oMbRB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiFExv+OGBhb19z7TZ2lpSO+UkOCCrCDp35yy1bo3L8=;
 b=IHkihaOTcYXK5ne2AKKwq5IgG2HoSX5LT9bkq15LTqLww5eWN18rtTvvOsUSXvE5iJd6f4WJU9Qyu/J9sGDaTh6gximzaUt+rGPn29e2fg7XUCetLcgaczZQ1MW8J/D5AAhFcX6EcvTrv1/a/R3wtBq3RQPg+hXZM8ItOemck8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Wed, 13 Nov
 2024 14:31:27 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:31:27 +0000
Date: Wed, 13 Nov 2024 09:31:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, bp@alien8.de, tony.luck@intel.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
	hpa@zytor.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] x86/mce: Fix typos
Message-ID: <20241113143123.GC3181969@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-9-qiuxu.zhuo@intel.com>
 <20241112153842.GC3017802@yaz-khff2.amd.com>
 <befe8002-a5fb-4d68-a7f6-1bffb97ed255@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befe8002-a5fb-4d68-a7f6-1bffb97ed255@intel.com>
X-ClientProxiedBy: BLAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:335::6) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e79b3b5-0fde-4fed-e378-08dd03efdb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V0k77pQ/kLCawnYWdjzZQvUbQtlSO2U+3NkMdKqnu7O3J9kqvjiZ0zyo+1DO?=
 =?us-ascii?Q?Zq/jTOp3Kb4zrKy6Fc9heze+xN/SlPYpTW9ZE4o9YJiX5L6Xejybf8oSUxKm?=
 =?us-ascii?Q?bBHo92+XRRLRgHPG8jfJ+5iXKCWPvXnpjfHQERAXmlrryp0m1jE2qwIHhvMO?=
 =?us-ascii?Q?4ddAWfZj8D13nR355dJx/svo6dlllGyJvaodLRa8tiasvs9Fsi2ZKAIzwcnI?=
 =?us-ascii?Q?fmwaydSFq/sVX6iigNtbzbr3xm5xHWKfJaBxXuQsxQDd0fqfd50eZcDyg92c?=
 =?us-ascii?Q?JhlDmpnGBgqnWcugzdr7YKM6mTNRkCpjGkQ5Fq8PQBCrmPGe2DiPpoVVRwNd?=
 =?us-ascii?Q?fdl4iNOFFAcGODhq2PSl3IuR227rrZMMzBRENfdX48FL1k/RcyXZ5EsEdG3p?=
 =?us-ascii?Q?4VcpRTU95LQpqvN/OmJXh6zbAHURJo1iSCQqGQOgUBnUJTbWsm1i5eb6KIde?=
 =?us-ascii?Q?gpfSi+eM57nPdBJ2DQ6Ghi6zaPgC51xfVZBxxciMSZ8AzUfZv5HLf6oFz9ed?=
 =?us-ascii?Q?H/PMYmRH3+b+sHqQQPAU311bBdP1/r/9u4wtHDFaW+Fh0LpCTuFo6NRFGzV4?=
 =?us-ascii?Q?i0lgsH2Ts+cKXT3V+UPar14Y0n4xNKEBdV14kgkVIGDrimSWR2cLyeFl7FFT?=
 =?us-ascii?Q?8WHfHt7mlvKfqwveMSfWJilvualMxEDkeSdeRPgmKw5AISmiJDSS/E86Q+wb?=
 =?us-ascii?Q?EyR61smgpHi1/IUmyW7gtmSiqxUi7pQHdxrZCs6qKfJ8ZRddlLey4omtRPln?=
 =?us-ascii?Q?y6fvnCfbp9VPdfaYByezBhtcZKK/NucM6jCL6nwNS4nJwJMKAFVzhfehOh8o?=
 =?us-ascii?Q?NEJTtmX5xqMduutD+n8OsiaBeKSQpJfTreHL0djFmu5GJSwaN+k1n6QMmnVd?=
 =?us-ascii?Q?4pIgZjnYrBNRp47GxeS9Lr+I+rJsAvAbFe02JePceL7Z0KU2AgitQKIE/9yi?=
 =?us-ascii?Q?gLMyEOzwHFV3KjVDXhDbt4Suwlot5HZc2l7M+Hc3kAaf3zPPiO7K7lYk3cJd?=
 =?us-ascii?Q?KtluW7q5W74KiZosZeblrwnZwUN/H1zuFI7gW4eDpdlj8BTVWVy3MypJRJj7?=
 =?us-ascii?Q?IqP2XbC21C9MbmoG1lgjVjdRUg0n00+vdhiTb3CPMzQq+KfR/QjvSkEpU78i?=
 =?us-ascii?Q?USc+XxupaNgzBoiT9ssvWYX/gegZ1mf4xejQN21cMwmDb56U/XkDpFk3p0MU?=
 =?us-ascii?Q?RtKZvE9l8HzOUY00s8SlwaV+Ze7zYrU4RPOmCGFBmX5tYDLU3mLf0ArwQV+R?=
 =?us-ascii?Q?xiFtZifwGGFgLIbBh4mhrxC5y1Q/HXSLFXTvZQilAw49jxBRfS2+d5HwYMIC?=
 =?us-ascii?Q?GpgIB0fr5TIy720yv9DDFvC0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFGHPrsEGuvChmnGFLEx1KVJy1+Xbk05ZV9hYXGgNaGU6yHnEcXAjQu+EeT7?=
 =?us-ascii?Q?rSCnpl48dWdVVpz9q3ZRvYKWw+lf33kwXv5xDFBUtSwQSkNiVkJPMKeHiAkD?=
 =?us-ascii?Q?BEYCncyxHqwrxuy3B+wcsGDJgVeusIXVZwOWUS1Y6fviXKIKgTOs++3tDOxG?=
 =?us-ascii?Q?TVeFOiL8OiFNxSpyvtiMdR5chuhE44Q5gtndtr6MevvCk4Y+IssnibIDB4pQ?=
 =?us-ascii?Q?jriYkW5xyzd3CdMzvJLCaw5GjLyobrblktu/iBGlK0Xg6lukmpDMTLBRxio7?=
 =?us-ascii?Q?CoSg/mg55H3C+WGIdXNupZKtdjFctgHApqhxMuchuD833OUsM0YMm0GadOTh?=
 =?us-ascii?Q?UeYjcDPw1OJYTyoB2pojuqyIwjhuTRVr5Be6yoOHkph5VJT/Za3itaIVwP/D?=
 =?us-ascii?Q?3FB35rp6zIsVh7R7l63Ax/ZTbu40M4sXWKx03PDDt27VuNiV6xhycTgvIx86?=
 =?us-ascii?Q?mc8x1bvlxYOuaixKM8b1undSEoxembCgD9MjaB4pORuX/VoF88k6H+xM7smI?=
 =?us-ascii?Q?a4xocALSimMtrK9aE+gAgJCGMZYuy2zblUYDNM59UQHdV4EAJJROfHP0beFY?=
 =?us-ascii?Q?RFoSn+8AcTsukOgK7J1L3kdKdyTFjDHgxq2SAC8fkcFWFXIpwdtVJnzEdXGZ?=
 =?us-ascii?Q?E0lWM+7bJilofy08jztf9U2JTOKzFoXRg5cHxNJp5Uh4/xPv744S3bQakf4R?=
 =?us-ascii?Q?MNxq2fHj34LgTx4n5mnMjWAcM+DoqOBCQ9p7gRyPTqlONeFFaHb+a4jni1WW?=
 =?us-ascii?Q?AAejNV3V0T1cw/9jOlQ2rhnqKfPCjgsOaK8/HDS3DoliJ8Yqx6/f5MILBp1F?=
 =?us-ascii?Q?H5vtCyyYDOdc8UTaf9rFi5hlKsbeG9Uk40hnVHpDr0JVe0j/jcBSaLCbQhhK?=
 =?us-ascii?Q?cwgAYbO9gf6seYlLgbe0VLLUCJJfDQtSqI5WXbKpELc3qqC88GK2yZOhsupc?=
 =?us-ascii?Q?oEsOSOazrAR0zpOE8REUdYh3cCIIibWlmmxim6k0f2+13qQO+H6ruSvWUlGY?=
 =?us-ascii?Q?IMHGnONPqqQXn9psFgamweqD7iV7outVV1iNIRkZ9sO958OllouVNMBQWQ+c?=
 =?us-ascii?Q?/uAaLowdiOD6mupPdtUUfIWqHIEC8aqG1/r/uHq3QeRzdIXpxwj27hzgijVF?=
 =?us-ascii?Q?SHoWFU/JW8VVUUQ6rjB4RdCky7jrBWCUbnh1wf2jxzTILaOjEJvvd/nGl931?=
 =?us-ascii?Q?XU9TdLFEEkGWtgWTNCggKpiz1vj1KNsQ3sBhDEBjMAWFUCPdcQ0KYaZKr7fW?=
 =?us-ascii?Q?sHlFsJ7c2iBH/0+ATYRif9Jx2bwPp/qoyMyv/q1Jfr65V4p9aOKCZbZhOba3?=
 =?us-ascii?Q?oEUrrwY0nXmrwuSqo30O9pJ8eTuySp8BgjVetEVkv2SxeW394c1csEFUW42b?=
 =?us-ascii?Q?OaQ0vikH5gmc9xBC/hxYeVIidhDWu3m2lwga+wIz5JhXVenYoUTYlDZEhZ2Q?=
 =?us-ascii?Q?H+t0GjPEqW9qCWvCRr2QnHpRCJAO0NyKKzAtOlwYoMjQlzC+BuWWQHuWPZT7?=
 =?us-ascii?Q?a0kw3SAzKBLTWrcApJahe06fODPywlbzn/zrM3nNaVvocnNr46mV1Z5/MHe5?=
 =?us-ascii?Q?jz3wQVY27k76RzNzNF0f8AhYEERSR2E1mWLejSqH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e79b3b5-0fde-4fed-e378-08dd03efdb84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:31:27.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2IyWYBfMX1K5GnBL4z2dhyZDiHLwA+xFuRsXrv8ZtNxxblkPVWtzT7eLRdWi5vRx5lJJmouddMw/8E93qiwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

On Tue, Nov 12, 2024 at 02:35:32PM -0800, Sohil Mehta wrote:
> On 11/12/2024 7:38 AM, Yazen Ghannam wrote:
> > 
> >>  		 * This way when there are any shared banks it will be
> >>  		 * only seen by one CPU before cleared, avoiding duplicates.
> >>  		 */
> >> @@ -1917,7 +1917,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
> >>  	/* This should be disabled by the BIOS, but isn't always */
> >>  	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
> >>  		/*
> >> -		 * disable GART TBL walk error reporting, which
> >> +		 * disable GART TLB walk error reporting, which
> > 
> > This also is not a typo. TBL -> table
> > 
> > From old AMD K8 BKDG document:
> > 	10 GartTblWkEn GART Table Walk Error Reporting Enable R/W 0
> > 
> 
> There is another comment in init_amd_gh() that seems to be related to
> the same thing and similarly worded. That seems to refer to TLB instead
> of TBL(table).
> 
> /*
>  * Disable GART TLB Walk Errors on Fam10h. We do this here because this
>  * is always needed when GART is enabled, even in a kernel which has no
>  * MCE support built in. BIOS should disable GartTlbWlk Errors already.
>  * If it doesn't, we do it here as suggested by the BKDG.
>  *
>  * Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=33012
>  */
> msr_set_bit(MSR_AMD64_MCx_MASK(4), 10);
> 
>

Now I think *that* is a typo, since it doesn't match the documentation.
:)

Thanks,
Yazen

