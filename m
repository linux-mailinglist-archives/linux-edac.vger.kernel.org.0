Return-Path: <linux-edac+bounces-1372-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A100B9175D1
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 03:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B48283388
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59212B87;
	Wed, 26 Jun 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Ba85tMr"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444FF9C9;
	Wed, 26 Jun 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366277; cv=fail; b=D/31RnYBgHMI17/R6ajhT99YrdHnxLUaD++wdflIzazbRZo3nm8aFVHSRkiJbEA3exnzgcpqExzTJbJdx7lLRk+jdmvyfFOoXqckIU0B1biga/v1fSOKVlj89a0YOOC+FsG9CbEsYzyhdEQfEPPK2uSCwhRczP0X2ZLi/eJVTws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366277; c=relaxed/simple;
	bh=kDeM4dTL1ZxQTuEjHddqB3zZiAT3c1EpP0R4WogeTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajYll+LcNYePUsa3qUcGaGGb4MNltA5csxUQdhmVoSml4eYFMvE7Et9ae3Msez6PXPPzhYg4OpZPZNlcIkqPtTXcQlyUps52Jc1iUDCiatvHBRsKgCjS5GCw1G9CocbizgOZOrvS0ujqtCfuO37G2gIbL5yjBxOI6K74/VQ+yHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Ba85tMr; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDPcRz6AWfhoR7HlDHNxjguOeugMgQZzaAF9DgEACAn6HN72DdS5iZjnaXmUQ3i46sCWFauP4Gu2NDTB0OfXS1g1wcT/39OZxbcV6dBEXze1VPsHp6EWDko4HQ8jQxnJSBRXmLAaVnDza0+ojQaKsTZrwo+t1l91HJUTzy0hcr3LImB5JyopsZgoRkUIzJWGjDjRHQXOnA1jnD14eDbF87I9gUu95YOK7RCOztVz2uI4mzEyVikcicLnBcYVud08EMRHCk1XqqdUvSsWX7UazmkpkFhEHS17eGRbqHsOsojudw4vuwKMwRa/S9NiA1r0U1i7XFaZeI4t+hi1mwQ8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ5xL0rqeAoSCbMn+Eag39JFBu0r1yT5alV2aw/hlhs=;
 b=KBQxTMEa1MUGyt+rDF8AolEeQRoTjbXMs6MInMVE3aakeVUTFazobKF2jivjUHk7iauMA7enqQyrblEm5BJDqYIa143twckWOy+ke+EsEdhsW+OFdEe3gkaPLVeQhB3Aonodu4gbPt1lnrgrwrX+Dv2M7l5oOpy8Ct63NMxwzHxSLEeiV20Kbt8i3/lS8RdB96ac9PK60LWc7WqCzIiR+Ik9zUcstWmeziawyAb2KASIY0fzZ5P8Mw9ET/EJxKAIMGdmDH0SLgrCcxrRqBohxpVijumt3vthWKN2RTPHugj0WOD4uVFkWZRn4F/6coRhS63nopUYYjErlXfw2LuaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ5xL0rqeAoSCbMn+Eag39JFBu0r1yT5alV2aw/hlhs=;
 b=4Ba85tMrAbclAg2BPALTcbhNxD5c7uUl2wkqc37wMcR8xDqtglQwxuD8U1+dTmi4ZPqyoqj8ZJURmowo+NNyU02BMVIIJsWYTUw/GeLZzk6cnm1YefE1pFU0hrzm7hCcFU2FlwRsYx4cBF2Jb6vtokfinUWsX1CMZhTFVCIMdBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 01:44:31 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:44:31 +0000
Date: Tue, 25 Jun 2024 21:44:27 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH v2 2/5] x86/mce: Fixup APIC ID search for x86 CPER
 decoding
Message-ID: <20240626014427.GB1086@yaz-khff2.amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-3-yazen.ghannam@amd.com>
 <87bk3p7by0.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk3p7by0.ffs@tglx>
X-ClientProxiedBy: BN0PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:408:ec::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7441202b-3fba-41b2-525b-08dc95818610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUx4JZU9AGs9F6aG+zoltZZtBhlnXKyenJ2UKS9xHMS/7bX99UnEcBK3c5X0?=
 =?us-ascii?Q?po9C3QnSrKMitTIGdAXaOSqIhn1PxXGBLnhg/4emRBi5ISGtdbU/3YiJb7BO?=
 =?us-ascii?Q?akKnhqR1tbJ1Hx/lWdixZhf1XdHGxxpuIvOpnEFAdsuf14koWcodKq1U/J29?=
 =?us-ascii?Q?hOkfm/lAJL5Nc1bScOqZyAUOiZKWmevAO4wZAdl98rU/u4PAllu71IzQdOHz?=
 =?us-ascii?Q?A7ntkh2puKvII2IAEyxcx6VtD3cG7sOADW88Zjc/trDrmh/jJr723/lqj3oH?=
 =?us-ascii?Q?ZLe5Gt4bOhkCskJxr28yJHcoLDEDFrk2oWR49LEvQRDFwGTM7RpPQghCzHm3?=
 =?us-ascii?Q?sHxLEUR3D52XTsY40h/9eaYtbWVj1jjb1qyGAVya9MDIHaO3ILQt66H+NJL6?=
 =?us-ascii?Q?yR7M8uYRWeSlmAsQYQvYzqeMhwct1DSPPDCR8R6YufUED/IcKUBbmjRsMAEV?=
 =?us-ascii?Q?mY1rUmxNjVCC7rHVPhA8XNPoU5bIdrVZu0kbi3nVHP7P91bGIC6JVgg55SBe?=
 =?us-ascii?Q?A98TE8hGQO4B7dOGK6JdWD8lthZk2xroPNROIhx5UFmoEcRgzyTb6ldZ/qSi?=
 =?us-ascii?Q?ak+y1NvuLN6osMQTyXycyD2lwDzHwueSNTCG/4DcX2LcNQkw1Tpx5v1Tl1v6?=
 =?us-ascii?Q?SCCMV9Ybv/Wor+hg19nHOonGwpHKuj2YL0E9pDq9XYyL/1n5e1rwNo3iXwi4?=
 =?us-ascii?Q?j2cwxilsXdxuLso097Hz9F+b+AL2UoL+qwbp39XLpghMcBdHSpGRL9W2ja1b?=
 =?us-ascii?Q?FyO2nTvksbjW/H2qP4nswpMqauo9aYxFXB+xEG4y5+YlvwGLfMyMV+U7oVSw?=
 =?us-ascii?Q?J0B7jo4E9BBX0RlHEn21KuMRMJUYfOPYGU62IWdD3JoJh6phCn+fsxuBxuSS?=
 =?us-ascii?Q?86eR9F+5BwzD7II/vXvfbVQAAy/zaYaHSLpjV6zP9uqmO8joTbI7SZzCVRdX?=
 =?us-ascii?Q?Eg3z6lE+ByDHQRSBUdbiDgki+YsKAHphO439kwxKXXPckz9wpPlc/DoRBNpR?=
 =?us-ascii?Q?bZkcF+nTwKcmVnUTvMF/4ygAkjjUlILxT8hTCdzcVZrvYsYxCuLEZi74EQi/?=
 =?us-ascii?Q?DOJGnMD4gPKqvvMdWtW6ERtudj+m5gG7MiXaEYady5gETdla8p19GWUzGaZZ?=
 =?us-ascii?Q?OH7JDx0VhN/WeK+JKvL2IzvDDH98VUsldI9LxAJK6nr5EE8z0unqTLf8MJNz?=
 =?us-ascii?Q?k6MXTTIj639Ev26CKpgHhrTmyzDUjOf4JCIKAIWnhs8L9tkSbUtUb6YFM6ah?=
 =?us-ascii?Q?tC0UQamjQ7KE/NGHbvAeblYaGFAEmDKBiqJQ0HtQEH5geH012WIUlvePo8fM?=
 =?us-ascii?Q?p1vdykCuSGXPUfKwtu/ln640?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jcruGAdGUtpVAHO6fHgd2Q+ugBV17IsCBKMvabhn/VYQcnmfNhRibJrOjV4+?=
 =?us-ascii?Q?CAd0TH/B34dFdGoBdCkwME8LSz5C2BxfyZp9vmgJV8UbXkhXvxrBshFKxxE/?=
 =?us-ascii?Q?W2Cp/CprILtIKFx9F7v+ws1zYgqOUJt59kYgIo78tiBuqyAnDd7p3tttfOso?=
 =?us-ascii?Q?mS1ShxO/twTgWHd0WdTePNtAX6DCQYJBMiJ9BOhn0vG3nchvWxWOOlxgRVM5?=
 =?us-ascii?Q?sigE2er8ez+jWUz3Ec98g+v5WRoYDm5bAqf7YbEMDbLI1ysTIchUYu9NYqR8?=
 =?us-ascii?Q?NrOyJxDEXBt1zZv2WBXMZlRI1K8IdcplztG/oh2nMzU0XFYx1AHCFHrscPW7?=
 =?us-ascii?Q?ka/+987Tf6f5SxJo9k24tzPc/wZQen39t1AfyifR7t3PM4Vq/JOj2HWBG7JG?=
 =?us-ascii?Q?15xlprjSOcEape+JSl0mA0EMqXFueCHCHi5c4Kx9HWM65L380rgz5FWJDxtP?=
 =?us-ascii?Q?PYp/5n/5SJ9n94PvIh77iQibD8C2Qa5pJJCTZFnZi5E6b/1DRRcSe38olP+8?=
 =?us-ascii?Q?FWhe5IuOjPTRz96PcG4TZz+zCZJb6si/DgGWVfGRjj+tB/rN+juvlCzCQA1/?=
 =?us-ascii?Q?5XTOa0GmqHc1PqmSH6bpx+qfKhz2vL92tmdYXyfTEGpFuLWAkHUmGpABs/R6?=
 =?us-ascii?Q?CfAN06rSZ/uKcYUjVJSZG0Qb0oCJHiVNOM5RwP5OZJMzZJRXGhVB5e7XcpQ3?=
 =?us-ascii?Q?bkuesxbCAHLf/xI/Ql97cEWU0yCXql+JkdLJdU8Zhl1rvH2WwpDOgpBXtC7a?=
 =?us-ascii?Q?d7S3RRU53O12PhZ7Qq75i1Fl3BhqFFFgzc0tZxbfmKH8kpmKU5PMNaPlp1+U?=
 =?us-ascii?Q?yfwVfH26mBTSpWVmKflNXNrONw/p811qU0I9nPm2h4m1uujum77KsNhV2f39?=
 =?us-ascii?Q?8yDy2RiA2DKE48Mb9aTFaMYYQ8HszCrSZeTg4hYbWzEY6ER0dBMQL4ZDv4S5?=
 =?us-ascii?Q?Jmj9Vaclsnh2zbwjOO9qRJFeK1PwCxUV3FA/xouLF/9s5GEJIfMMC1Rp4LrV?=
 =?us-ascii?Q?s8VdMWQxqN1a/l+BTz2B/84qfjFWP1Az+3ueZqF7+1qVS4Qwl0gR+hq3kumx?=
 =?us-ascii?Q?vziY1Deok3vPOdGubX7C5w5v6OQK0D+I7DERqs0f6U/qyV+9MHNDqzBURIIZ?=
 =?us-ascii?Q?sO6BvVvvihLRlDGB0vZ7uZTbLt6ACddFaWbOqPWcoM0H2B8frmIqyJ1CtQtV?=
 =?us-ascii?Q?32DKlq3tXs++s0zFQKCD4CIvcfI/W+L0n8h3XAVYHzf+vnae7iNGP6zS+oQy?=
 =?us-ascii?Q?H0/q/MfVuEMIOEvVqo8E30eqNaq5oibE0YtvU99+Xr9/m6ifqbyn5WpbJKED?=
 =?us-ascii?Q?jV5mhdmh4ELzfGNbyz2VgVWBCY2fje9bNGJR+aYW5Gs+7OaOXuSOZrcwGGDd?=
 =?us-ascii?Q?0FoYWpaAW8HTfdq29FlTTuFzImIrwD8ts0y5vl9KaVGUVF8IZE+9ifwHGHId?=
 =?us-ascii?Q?WdS+hInFwPuhhqrPcaByBLMN6ubX691D8DzAfCoU8FnqrLd08APjMq6C/lVY?=
 =?us-ascii?Q?b/9TRbLf8CiYEydZRpNjt8vMkrMQOaSK47ZbUdTTTijU3tygaZ/UzNi8mIi4?=
 =?us-ascii?Q?287gYjZQvPt1T3duN+5OeKzeBrfv/AO9Xw8+Xb/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7441202b-3fba-41b2-525b-08dc95818610
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:44:31.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6D6zrtTfM7gDVCenGZsMavmQIJoF9kBRR4BIXxiucSCw5doF5N4tBJXa7ye28KZqU6FK4vdH16yQ6PIed++pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

On Tue, Jun 25, 2024 at 08:50:47AM +0200, Thomas Gleixner wrote:
> On Mon, Jun 24 2024 at 16:20, Yazen Ghannam wrote:
> >  	/*
> >  	 * The starting address of the register array extracted from BERT must
> >  	 * match with the first expected register in the register layout of
> > @@ -99,16 +103,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> >  
> >  	mce_setup(&m);
> >  
> > -	m.extcpu = -1;
> > -	m.socketid = -1;
> > -
> > -	for_each_possible_cpu(cpu) {
> > -		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
> > -			m.extcpu = cpu;
> > -			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
> > -			break;
> > -		}
> > -	}
> > +	m.extcpu   = cpu;
> > +	m.socketid = cpu_data(cpu).topo.pkg_id;
> 
> topology_physical_package_id() ?
>

Yes, will change.

Thanks,
Yazen

