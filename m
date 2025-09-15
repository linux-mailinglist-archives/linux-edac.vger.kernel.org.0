Return-Path: <linux-edac+bounces-4803-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9292B583B9
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 19:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830BB483DF7
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30433285C91;
	Mon, 15 Sep 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZE1XiffS"
X-Original-To: linux-edac@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F21E5B68;
	Mon, 15 Sep 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957625; cv=fail; b=fOyOfYI/l5lvEVH6Cicx/unkJtO7bL9texKt32yyntb+VvjYC5JJ6Q9iq7xZdGEbi+FhcMc7zosS2pc+5BbIs6M5jZb6i0IwckcEVEo+9py60b4RV5LjLoX+iD3NKAZF4BDrjbTXzPJOPd3SVpdrjAjx4ysmKT+zciTwMaXmhL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957625; c=relaxed/simple;
	bh=pyXynGPuGF6byeAvD1vPGetK6N2fAYao8FxX2p2RUvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owWj0LaiJb4RgJzRtBnPjkZSAG+uCI79q9bOpxOSQObsgLxCK96xwSvOTiL4kgO4bIgre+tqqkZZE2xJMNJZXoV3VUjf8opqmg4l2B98o6OpZCBBujF0B62YNGgkSgnZFSsjpZpcu5XjUkbjLftK2o/WRkFnR+gx16HJLlJ7ums=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZE1XiffS; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2pGL6XzPDdEV967Gik88fpQMR/6wFb6dBBT5QMH7DkjVH7YGE/J131U/9pZUjzzSIKmwARLugFXx/ImXFafOSLv9HAfaeHOvGcIdX+mgr5GkRx6MQytpdn1lOt1bP7hYi2+gh6e3TW1rp6F+6tNiTLvJJyfzXNiukDpvufUrpSzMpeeG967xCslJYQ02/eOYYaA5JUiZErbC2+jJ86siuXp9xTjoC6s9gIGMTjXgqrbfRPiRl3RBSjMsgDdxr/wtIznWwoY1lmt1vlabO45OLO2FBtNHj0HiX3jVdsGiaZL91OoSYCY6g8auerZ8ykqzE+FB7zEobDR9yxnFokflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG0l4XdImdGS4FtAkAkIYxfOO8w3VvgalOhXho1YBP4=;
 b=Zn3XdLF6jaGo+Fov9vm1KUaPUjzQqmLLpBbdQSlYCHQ9UnC2awmCdNETDXkNmLXXq9WZ6tYX21DeLzedITbsldAdCLzH4F8xm13MHwMJcdZJZIFTiqjBEYBAUeLzFLigTTw0f8Pada9Ihoh2YZ1gZekcMW1JgdjQVPamkCrHStKJwmALdCj6SB4ULE+zZT37JxbdpW5GqR+TUVl7Cq0Iq4jwqy3UPx+lv4AJp02eTZS4WW7VSvIsZN9sakpBlsxoSzugXLlWo80mb6e4i0vSU6Ul2Pw/3mh3YDJzL4n+a2SBHn10fxjx8ZGAuaY+n7aJ0w4zB6zMZGt0Pn+pRkl7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG0l4XdImdGS4FtAkAkIYxfOO8w3VvgalOhXho1YBP4=;
 b=ZE1XiffSMYnpf4yBGeZgTJev0mnkdYgHwRu+Bxs9HQdvguNKg0k2TPQBA1RdPxSNqtzaECqnOJyL7VropUXsxyc1EOo/1ilY9dluIvobs0/N7NUM6SBpQb4p3dBoMHCycO2lLzXN3KkD1UM7jXawH9A3UOtFc+8T/ZRy8CUr8Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 17:33:41 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 17:33:40 +0000
Date: Mon, 15 Sep 2025 13:33:32 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 15/15] x86/mce: Save and use APEI corrected threshold
 limit
Message-ID: <20250915173332.GA869676@yaz-khff2.amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com>
 <64314c7a-5212-4bf0-8181-8bbada0e81b5@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64314c7a-5212-4bf0-8181-8bbada0e81b5@suse.com>
X-ClientProxiedBy: BN9PR03CA0674.namprd03.prod.outlook.com
 (2603:10b6:408:10e::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d43c86f-372b-4ef4-c929-08ddf47e02a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xH3MLel0pa/bomTNV69qACGmsFs+h5GBoDCjotjvpa2r1tsDL4JcO/GSup5N?=
 =?us-ascii?Q?4S6Y6FmkmETs41UdGz/znqcQUQQVuaqWm/Ji9gpiJcxjP/+OO4q++6LS55zX?=
 =?us-ascii?Q?jxB5vPjswSNdsgXkkimqJCiAB9yVqgKPyDLzwkrRKoi/y9nQsp8KPgWxFvZK?=
 =?us-ascii?Q?1s48HK91qGin/4VsJ9fTl+FYcCBQTKYxOmCfj5nsDdbJPXYCHCZ8/HqYh5QD?=
 =?us-ascii?Q?HNzrNKcDnfQgeoTthtpym4ee06KUbGYmNcHmhvP7YGoN6S+ibkCHa+I1bjNi?=
 =?us-ascii?Q?6sBeWjBh23pkzRMtb2uXYmrtuxHiPkDcA+lO+8ov9KzL4taSKz1IhT4I3nYM?=
 =?us-ascii?Q?7WlcL6BzQGdNE1fYYvjS9g8DynzZKiOlBuGZ8LZiju9DIGcmaD7TQRKk7wbt?=
 =?us-ascii?Q?vEc+wfQhWIczJL4QeYilLDCZClFduMEpdhnel2ULs0rViUycEZwv3ZcTeJIq?=
 =?us-ascii?Q?xLweZ2LjPvKxsZlsO7UCrgt5Bc9va2VKyggDkw6S5wr/WmrXKXz5LJXUDnbV?=
 =?us-ascii?Q?w2QaLpaB/aCZIxaHbHs3D0y2s/0O57xhEMItZpSOkL2KSVAQtVCdKGIr6b69?=
 =?us-ascii?Q?L2JRFw9jhYOhbMQpsF6YmPBY1iQFjoNiQdtMuqlPvDwgXen1BlqlfIRdzMHg?=
 =?us-ascii?Q?h+YK6GX2rUkLoflLOtI6jUEHjMDXwWzfPMUUbOEoJNuuWQsx7PQNVIOB+hp9?=
 =?us-ascii?Q?5v3QF2cMRTvbQlPqmuuw+Uv7Cug0EzbvfO0fDkvGHdkcNgQapthvM+EmyQ6c?=
 =?us-ascii?Q?tkcNcX1H8BTt82acnTGxcd0QEGi04bzrMTRHibMZu+imo8Mw0aQ6QbLVB3Uz?=
 =?us-ascii?Q?dYgmXFMbbtPBDKOy+Eng/d28H8XMOLhsMMCK3YrTEqUVfYREIw/NEjGPUgU/?=
 =?us-ascii?Q?h/en2wUlrVRvpAhfWcxGGYZ5GF/Gs6DmczHmkv/nllYXRID2TP9hwjF+7DVC?=
 =?us-ascii?Q?Zt1menLKW1frLQgMp4zdAame7Tuu4jcbZbx1ruTTsbXApQqkyh/qK1wVg501?=
 =?us-ascii?Q?dBx+0vh22D22HYNI1PrJyqvSB7XqAGqZvPbGLOTG3mbuzp35J44+tWECRacL?=
 =?us-ascii?Q?xOFUSxRinsj/kNk6zx5DgdMKA+FqZLNJeJob3Fsn32CAhaATUQvaj9wtxJkS?=
 =?us-ascii?Q?5BBRi187zHVEyiMv/EIIGJRVoMTYQ/VC3zW3QsPZHgChx8TtMJJLpHLp37ef?=
 =?us-ascii?Q?3aEJoPZokSesEhQK8Z4pdcAvAhK74e8cj3CvxRBhPRGEuV37rZ/noXlqJqA/?=
 =?us-ascii?Q?+NMaM3bgWnDbn9lZNUPi7Lbc2ZIhG98AhdaZBabSYP2PuB8rKcO9VnNkF49g?=
 =?us-ascii?Q?Cn1ccULF12BmBaiP5cT9eRauwhlLzgy18PXnAa+zTx3zC6AjbaNME31aSGcP?=
 =?us-ascii?Q?TvDQzocq21O1b0cmqp7Hqbuymdxsr92b3aQetsGUO42djWM+vruEuFfpIAez?=
 =?us-ascii?Q?66WZx52opHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqpGAe28FzgOW9W7PnXt8y6lbtiL7+PpmKNpF+c9rO/GB04okNlkTbwGnMl7?=
 =?us-ascii?Q?nGTK2e/lqE0ij7UTiYssCMnl1Vr2eByyxzLz/cO7PXUiXUIwArdeBD95uEmO?=
 =?us-ascii?Q?14VwKaVCTwRInDTPud0RAnB5UvY33sqFTnQwKpFdAeQKqqO0aTMefKwVRb3l?=
 =?us-ascii?Q?xUNldpi8LYdiJKOEq5WQvZeO0SjJhjt74IEpi8OAnFEhJmmyuhZpRv21cJ3y?=
 =?us-ascii?Q?ybHyQBwvnsrDekNQYfk0FDb8ZOj9J+XJmIBbujWjCupvugLa+NlYQrP3xgAs?=
 =?us-ascii?Q?9atMkwP5R3slw2yl0P6rmgbWJz551HNSkBgBECUldEAQqvLf9Uo107jTxpFO?=
 =?us-ascii?Q?Bj8a0WUgr6Aap3U+BWcDqft0cYknkwl/nYDcs8PUDDUEqG/BZUUty75xQ+V9?=
 =?us-ascii?Q?vzO0j4OVzEBY7IlmRHnQ277sXeCWojnobBbcMhNf1qarJNWIUgnZEhkPxzA/?=
 =?us-ascii?Q?lvNgEEMwAiRrqu4CkdPNDbGom2jr4FZoWoHbGyCGt89oDh8vZxTmrnYdD2dI?=
 =?us-ascii?Q?dG4zyYINdImvPysapFrTV4+4/5bBxSSQz/zVy8gTQd1v/DD37aO6ykwlD4ur?=
 =?us-ascii?Q?4nrcmdApxG5hff0WFxIi8yFFYE3aEJzfnyc7jvheg7PYTyHH88AkVz5thjSH?=
 =?us-ascii?Q?GTxhQx9ipKxY4KUUB6DxoIRaVxBfQHm5WIK84UX4iwVGtoJnA7tm2SCmTrK+?=
 =?us-ascii?Q?XagohIJzdeRbSDEZ2aXnMaigH/r32Wm5xcQsDlsgvfNCEaoHaNLMqBJga6em?=
 =?us-ascii?Q?AHMfe28a2MaEbO+jpPZNPzMG36zHxe35YMIjc/v71BVsyXg/yjxIVVfBHreI?=
 =?us-ascii?Q?SZ1EiAUJbZIRwn7J6egCHYcGJdpcJKqKc4HHNedHoCSHcZR+XE8TGJamzVmH?=
 =?us-ascii?Q?BptJhBws97ERufE4sZ7X8QussEVKbXuyyHjF3LqI4o2yBCsrgyX/5eT5LrR0?=
 =?us-ascii?Q?ptJqrCUVE6pK5q9SHPck/mAPxhRNSzSa3DjeqCQAgDPwCGwf7PqGPXehQ8Km?=
 =?us-ascii?Q?4zH5cmzdZYS1m4tr08B9fOxaH66Wblpqx81DwvBg+vorJGeg8OaHJrJTWFH/?=
 =?us-ascii?Q?gMyo2/i9wirqdUAgF9f/xDWuLfqlG5rteGimjv3vIKeUpjHBgkmpzrc0Svsr?=
 =?us-ascii?Q?UYUvfMq/wJMtGDFreqndEnivUKuwut/QVLqIlJIUG8xQTb42Ho4YEH5rn3l/?=
 =?us-ascii?Q?fD1d6HrU6m/BU1RVSwvsGJ6976x6UjH+TtIVaGiCvy5F0mJ4yruq4d+jRSJu?=
 =?us-ascii?Q?6RJRFWhGlg2JFCxtmqNGq7GWGkYQ7Rzuskt0LWcgH05Slwh+kKTS9DOj19zg?=
 =?us-ascii?Q?tyZZJ1DuRWIGTUOE3Z1khT4gSND8do56R/8v6jvxO2fT5Cqjl8kfPWFmgh+1?=
 =?us-ascii?Q?79VRh3hc6U9roAEoShgLvXU4XuiBgI+obRZayal04Z8eh4EwsdA5/xOqufZW?=
 =?us-ascii?Q?k4tn8xdTK6vJ7osLU20eMwkK+Y3q4eBDUeRhAZaBR6SbC99NyInLdFjWTM9w?=
 =?us-ascii?Q?JjktgqSipTjwmw5KRDqGbuYisoVso2CPoVvOCw0TxpqMls69akBFHadUoSqG?=
 =?us-ascii?Q?USsP1tMVBCLEOf2g0mtE1d6NE0HpVfTRxBzSuaGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d43c86f-372b-4ef4-c929-08ddf47e02a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:33:40.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8Vh29SBJLZX8YKAsMhiBcz4x5+RC6vR+JQ3oeZt9aYG2bt2qujblswyW3xxeyzRIcMGv4/Zpm+iamJXRFqp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

On Thu, Sep 11, 2025 at 08:01:17PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9/8/25 18:40, Yazen Ghannam wrote:
> > The MCA threshold limit generally is not something that needs to change
> > during runtime. It is common for a system administrator to decide on a
> > policy for their managed systems.
> > 
> > If MCA thresholding is OS-managed, then the threshold limit must be set
> > at every boot. However, many systems allow the user to set a value in
> > their BIOS. And this is reported through an APEI HEST entry even if
> > thresholding is not in FW-First mode.
> > 
> > Use this value, if available, to set the OS-managed threshold limit.
> > Users can still override it through sysfs if desired for testing or
> > debug.
> > 
> > APEI is parsed after MCE is initialized. So reset the thresholding
> > blocks later to pick up the threshold limit.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > 
> > Notes:
> >      Link:
> >      https://lore.kernel.org/r/20250825-wip-mca-updates-v5-20-865768a2eef8@amd.com
> >      v5->v6:
> >      * No change.
> >      v4->v5:
> >      * No change.
> >      v3->v4:
> >      * New in v4.
> > 
> >   arch/x86/include/asm/mce.h          |  6 ++++++
> >   arch/x86/kernel/acpi/apei.c         |  2 ++
> >   arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
> >   arch/x86/kernel/cpu/mce/internal.h  |  2 ++
> >   arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
> >   5 files changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index 7d6588195d56..1cfbfff0be3f 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
> >   /* Disable CMCI/polling for MCA bank claimed by firmware */
> >   extern void mce_disable_bank(int bank);
> > +#ifdef CONFIG_X86_MCE_THRESHOLD
> > +void mce_save_apei_thr_limit(u32 thr_limit);
> > +#else
> > +static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
> > +#endif /* CONFIG_X86_MCE_THRESHOLD */
> > +
> >   /*
> >    * Exception handler
> >    */
> > diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> > index 0916f00a992e..e21419e686eb 100644
> > --- a/arch/x86/kernel/acpi/apei.c
> > +++ b/arch/x86/kernel/acpi/apei.c
> > @@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
> >   	if (!cmc->enabled)
> >   		return 0;
> > +	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
> > +
> >   	/*
> >   	 * We expect HEST to provide a list of MC banks that report errors
> >   	 * in firmware first mode. Otherwise, return non-zero value to
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index b895559e80ad..9b746080351f 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
> >   	}
> >   }
> > +/* Try to use the threshold limit reported through APEI. */
> > +static u16 get_thr_limit(void)
> > +{
> > +	u32 thr_limit = mce_get_apei_thr_limit();
> > +
> > +	/* Fallback to old default if APEI limit is not available. */
> > +	if (!thr_limit)
> > +		return THRESHOLD_MAX;
> > +
> > +	return min(thr_limit, THRESHOLD_MAX);
> > +}
> > +
> >   static void mce_threshold_block_init(struct threshold_block *b, int offset)
> >   {
> >   	struct thresh_restart tr = {
> > @@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
> >   		.lvt_off		= offset,
> >   	};
> > -	b->threshold_limit		= THRESHOLD_MAX;
> > +	b->threshold_limit		= get_thr_limit();
> >   	threshold_restart_block(&tr);
> >   };
> > @@ -1071,7 +1083,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
> >   	b->address		= address;
> >   	b->interrupt_enable	= 0;
> >   	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
> > -	b->threshold_limit	= THRESHOLD_MAX;
> > +	b->threshold_limit	= get_thr_limit();
> >   	if (b->interrupt_capable) {
> >   		default_attrs[2] = &interrupt_enable.attr;
> > @@ -1082,6 +1094,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
> >   	list_add(&b->miscj, &tb->miscj);
> > +	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
> 
> Why is this necessary? Shouldn't this patch consist of mainly
> s/THRESHOLD_MAX/get_thr_limit();
> 
> 
> In allocate_threshold_block have already properly set threshold_limit. So
> this change really ensures threshold_restart_block is being called for the
> given block being initialized. Ignoring the changed threshold limit logic,
> why is this extra call necessary now and wasn't before?
> 

It is necessary to apply the threshold limit to the hardware register.
The MCA thresholding registers are accessed in two passes: first during
per-CPU init, and second when the MCE subsystem devices are created.

The hardware registers are updated in the first pass, and they are left
as-is in the second pass assuming no configuration has changed. That's
why there isn't a "reset" in the second pass.

The APEI tables are parsed between the first and second passes. So now
we need to update the registers during the second pass to apply the
value found from HEST.

Thanks,
Yazen

