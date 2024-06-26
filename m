Return-Path: <linux-edac+bounces-1371-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191519175CD
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 03:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CC4282E9F
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 01:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985110958;
	Wed, 26 Jun 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q1fp4HY5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C914AA0;
	Wed, 26 Jun 2024 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366149; cv=fail; b=RSohmuQHfsh9Bd8WcCnY8EcYZlx5lDrMMW30z3y98Tytz2qo9Jj2sldVdLxvEP40ukDz/IPm5wU0/yyJ7f8BKTlmbIa9DHO9mZX6NAZ5/Zvnuos2SKNZm7+49iWCcaX2IFBV6eXcZFshgQzJzri7FiUAcRfgPQdjB9A52J4vjeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366149; c=relaxed/simple;
	bh=unDiHqQm+T6BgpuzSE8SEsiHOo3QLtzd/W0XXL89aBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NfAE/y8XGMHDLCwtbuh0fyYojfssqUVJtjZEhcRQJvJ0hJ7FArtfwpFZ1UTjouKfBISXbW6ZSI//3gUt96HSe3rWkNG/lPo8IOANRTfZTeFjJqKUGOd/ZSNXRU7UVB/DItw8sZEHDJdvuPtjFkeGKKaxDsQAD3BMVw3bGp4phXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q1fp4HY5; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcGAkFuYDyDr+r6pcHC0F7VH1Ay2hFG/IiSk7F1M99YUS4i8WsnZcx3xqvVN3gPxf3ERXCG42RodFC1M4Q+CUyTzQxkkLMDTyVJG+VEJo6I8+mVUrmCQtLU/moMVhBHhRP/fBMuUJCj9zD6fMli1NUxlrUtnftuUJQ2ctuSAse6vPOtclUPIlrfRl4NeHo2skibNh5JcxY9GAK+KBEARj9hyzYZcGnXHFKVSPKZC/PPr/JGsJ1R4NNWrgAe5qSv7/VTrX9ZtZ2pO7k+Gubb9+vyZRdWxdc8ck2AIkIAimozqRFzbUHkxBY05RAkn0ZM/JektdjVQY7mdQH8WdEpqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPHOK5u3SxGjVrxr5YspYE19jKhI5KN2Oij0cY/PtrM=;
 b=fXvpf2Wxo+sm7VuVp106sScTxbQhTN6fNMo2muJhH0RwAnyccRi8z4LQxcZaCDNZSlYMW1RkMpxhpb1CaH3TvtvDw5nMTV5zcerUSlja3ygOVWebIFOK+VnCH8u9cCEFevVgOKnluaMFmhFsLomveiQZ28YDg/r97MigBC6+e+A29zOpxgULmvFjrFqmnPWCIer964BWNQjrV09UaIWYMGJ4q5r5nLvr8cYwxuDTi1qP2eW1ZmNAL8ZT3w2dnyPMXdxm3ve24zxTd4iXQC65Cb43mSp2JdsmuV9FUOa4TT0EQHF6/2Fk3l7lyyprorDNL06k+22FmhVl/lnlAAt6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPHOK5u3SxGjVrxr5YspYE19jKhI5KN2Oij0cY/PtrM=;
 b=Q1fp4HY5MPVXqPM1Daah4cMIxym1Zf6+pqmhbaI6d4yXy1XgPhC7Ujs4JoDT3qQZKZTCFSkUh5djQLJ1Bj7KwPTiJldGXnF4voC5068u/I9dBkBH4o8q439Iz0/oa5B83MGoB908JMj9BJi9c0M+vODj6hcoGQhaJZLr8o7wVBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 01:42:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:42:24 +0000
Date: Tue, 25 Jun 2024 21:42:12 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240626014212.GA1086@yaz-khff2.amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed8l7byy.ffs@tglx>
X-ClientProxiedBy: BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: d78b2d37-8273-4833-7ee0-08dc95813a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igTzokvwQM767oWnTGDlvXgm7Lz3pl0SLohbbdoiFI4C0Ef2c79B8M6+pYj/?=
 =?us-ascii?Q?PgbVWXt1ZVVhbpT6SEbgTZhYNuXObIacRLnJKC1BfbORptZcABI5f7P1MJR/?=
 =?us-ascii?Q?se2O3LLt2j+OtZzke2LaT5i2XXsiu2zxAqJ63ZtJg2UH8Ou9dLWW96WCtWsU?=
 =?us-ascii?Q?WfNR1wmTDB1BOIScfCjBOXlUPZ9AIEYRiXVHjcgwy5Rvz504c/JrEDC35PLQ?=
 =?us-ascii?Q?mK2MxMUVtar4Ohfzab8zeMYu/XuAlW/fzcOz7nUOmuKoaoWHXqdQKPrrwuvu?=
 =?us-ascii?Q?THlTncN7bS5mSUufgyXEMNRi66i6vlK0kH/zaPOUMQnEmgDmEWJERyEDV0Ow?=
 =?us-ascii?Q?CljKkmGkXcP/FiWyekO2nE+H83Z1OTwk6qIglEmkcDWwXkNGkJe3+tjDLy8Y?=
 =?us-ascii?Q?+QHE+nQ/ANYH/Fok+JPqHbMw1SnZyNfXrHnX3EtdDPDiaIluMk6+FK5/o0Ww?=
 =?us-ascii?Q?7iK0qIq59beOUYF0yiumccoQiL3opIhkgu3QfPlyigTVdSEofQRDoq2b1z1K?=
 =?us-ascii?Q?LFuFt8hObRb3Sk/9t/5R80B6Wa0On4HVrK72r2SSbPXG/cVl7rlvw+RVYxc4?=
 =?us-ascii?Q?bhgukJBcMb03NHNwCoF1/X2fkl7J/+TiAFmpgBMjtzHWfkBSvGBweyMrqfoY?=
 =?us-ascii?Q?qUyxb0jazbVL+2w2h4lfLbQitf2Wtam1j1peZC1mhQ5UIpJr5X6iPYu87Gk2?=
 =?us-ascii?Q?vb1JOLNHiLBtZqKt9/8zcZAhvDS09L34OchEm7YI5lo20rXdvLAGXA34EcIs?=
 =?us-ascii?Q?/JnL8dJA1oGj4oj8TCBwXmfq9O1gOxL0pKrXjfB0ZfkwnZuQyK1T44bTRlWP?=
 =?us-ascii?Q?KMfPgP0h+xWaN0+4CteUcoF7jvmujqP+2QeBOXuZrNKCN15De2xY3EpK79Ie?=
 =?us-ascii?Q?VTbycKAsrMtdHL2L344zZMkexn4qsn6IPhammbb9LJOzv9E/x8U1OE2gY4iY?=
 =?us-ascii?Q?1Dccn7naoJ0Vd3TGG51OPa/aUaU3inO8lk1sBxcpQzV96L56UIjii+AfwPIi?=
 =?us-ascii?Q?rbS5G3KRfr92TMi/IcI3fj4tO2QbWLIdHOm0Xflyhp00DYbMBy4B5gDKaW7m?=
 =?us-ascii?Q?tLwx6+smrnYgV39iqCdJmcZQA496aFWWFGpA5pWqLdfaLi3a6ACymplhFeff?=
 =?us-ascii?Q?U7FeEpl9VbZZmDfaDJn1HrqWSUaGMuuMeeQYsp1Dcux1jvornn+fJAClLCCF?=
 =?us-ascii?Q?72XfSmU6zgjxqQU078WqTzbNv+LVeMpZJKHSkfzP3PDOkDpEe80l5suscK+8?=
 =?us-ascii?Q?XmxR9EK6te9gtnjTvs7a1ss/MPrRFezhz97wqr27OOA34V4kw+4kka6z/e5o?=
 =?us-ascii?Q?TK1m8qL7SSXELqQPfUHZM+lM8yUyuBQQUeJ77ZVteKZ9fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hg5JQB6p2rJS0Ai+XkJVyzsY5OhNo9rlaiCMjnuUC0opId//5q2NRqSVnxYF?=
 =?us-ascii?Q?qZp8dNiPYVYpkD+053u3D5pw98BY1gbJnrLRBLtRzIxaSP3M4f2mfFXKWeTx?=
 =?us-ascii?Q?7WjTSeIEgKouGHLcmMIfplLEZKgKxGIpcxK5AhZ0A5dEoOdohTAjfqmxAo6x?=
 =?us-ascii?Q?1kDhklR8IGSr4TaONWYF2K1C+uFqoPMhNQYR16ZaeYG6fJVi5GvoVKekGqDs?=
 =?us-ascii?Q?bLX7Wsex/cn7JQCrt1PHZuoFkfmmP+fxi+s4dbAAJ4yScEXtIlD1mXypRveG?=
 =?us-ascii?Q?JHqapZ5nSSMPEHfv0DS72PMBja9p94otmhobEz+hpTaFJ+wxSXbC5XoDd+KM?=
 =?us-ascii?Q?7EOBo9G5OCqMdE/owIxOEPAtJQKsEVjmjBMv4vDsEX57vIoVXV95XO59keCm?=
 =?us-ascii?Q?uPc+N4g8NCUssxtc/jyHvelJrkSsQX50bFEsf6AGoBq2LiMQP6inbwyAYhOI?=
 =?us-ascii?Q?Zm0/QdQdbFD4jA6mlrF54OpCRid4Z3lYGpju9DHiaUYxodsIHwHS6+iRD1O+?=
 =?us-ascii?Q?C0OLjfSzUmolf01hFDnryiXkbNngf4t+vbBebhl0JOVdLRlJT7kNr26FBbXg?=
 =?us-ascii?Q?jz0cz62/KWxyLZUUqH46b6GitdAroFIMMYSTFe+il09so8bia9Ns7eEsQ7W+?=
 =?us-ascii?Q?IaC5B/YzOVfjMlGwhFsu3K+1UlDU4ez/4poNKm7helLPk+/Wu7jGY42Xzryh?=
 =?us-ascii?Q?f4OMhGY9BfQL2OnZ4i1J4FhMjaYQeYGDIQYY4Mv6z2FQgC4Wh8/KK8tw3xPv?=
 =?us-ascii?Q?nk4Nc3UIf+xmkXsqke6ylJCzZ5i/PmyDTlv+Dh2k4PM3DfHTBO+cbU0SP3Kv?=
 =?us-ascii?Q?r6A8nRgv/y8md2Fi+QQ/3IfIKLpRiL7zMD64ujo55vvR4o0vk8IsSe1GC30q?=
 =?us-ascii?Q?W0DgEnn+/7KSCZhDLj3z+e9pvfZXxPGvbxi7EANHSEDnMmpswuR57RU5n6r/?=
 =?us-ascii?Q?TARrEQiUofYB8oQuT4VqTAIDf3GZ4czYqhzVBpza57ORgd3llOREWkUviDHX?=
 =?us-ascii?Q?SJPBW5o22o1R9v6eu9PfICuK75yqSHa9ZWZ9qOPLcu9o1ANGHDZeMtlqpQpq?=
 =?us-ascii?Q?goRk6LU+HAoaAfs/uFR8ayHeZAFVs/Je5fVI766QPe3ygZJUM8UJa/J3NYe4?=
 =?us-ascii?Q?ADsIJByh1As1s3kzelRZPLklDTYTxUcP6tPI4raXmNzTtAaiU+rrqg4MY3ZO?=
 =?us-ascii?Q?G9oC7OU2W3qEn0NyxioiqtsdM2nEwdvuml10ijci0j/d+H8SKIa/kHf90F7d?=
 =?us-ascii?Q?Gtp1L3zoewi8fMbnpeeba3wsRScx9QCgzexKuOLJzh652sbniidw66xPCMVA?=
 =?us-ascii?Q?Fu081/gbtGuYFeyG7Eo/NWDSkTDYA7iw4L6LTFFtQcYbKNOZNWnA7OCti7du?=
 =?us-ascii?Q?NhccZUiSKp9pHVA3FZs0f1zmXe0U7nWUaw1PAM5jQ8wC8GA3h2GGZyHkQfgb?=
 =?us-ascii?Q?PQ83hb1SvrL8Y/OJVpn7aQvQCzKZh9DieDqTYLzxVqMbHhvsbfGGBJgiS2HR?=
 =?us-ascii?Q?PZ3oXsOm6QK9L/jdzWIou8x8IZu3hmgMmfc4PNzuvDgtsCOOo2uoko6d1ivj?=
 =?us-ascii?Q?8giTQ81b2L07O9utrQZwuYOQXLq3Hh9evzqhD4zB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78b2d37-8273-4833-7ee0-08dc95813a33
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:42:24.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhdBh7OCUmNK1twWSWE6Nc6KPCorhUnkIPVX7U+k7NbcWJrgRs3OTTAGVgX22Hryp22uxiMlyTRJpbd0O4brEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965

On Tue, Jun 25, 2024 at 08:50:13AM +0200, Thomas Gleixner wrote:
> On Mon, Jun 24 2024 at 16:20, Yazen Ghannam wrote:
> 
> > The need to look up a CPU number from an APIC ID is done in at least one
> > other place outside of APIC/topology code:
> > apei_smca_report_x86_error().
> 
> The need .... is done?

Hmm, yeah the wording isn't clear. I'll rephrase it.

> 
> >  #ifdef CONFIG_X86_LOCAL_APIC
> >  int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
> > +int topology_get_cpunr(u32 apic_id);
> >  #else
> >  static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline int topology_get_cpunr(u32 apic_id)
> > +{
> > +	return -ENODEV;
> 
> Why ENODEV and not 0?
>

Since '0' is a valid CPU number, my first thought was that we should
return an error code if we can't explicitly find the correct CPU number.

But would/could we have SMP support without X86_LOCAL_APIC? If not, then
we'd only have CPU 0 in any case. Is this why the function above returns
0?

I can make the change to return 0 here also. But...

The MCE code depends on X86_LOCAL_APIC, and it is the only external
user. So should I drop the config check and export?

Thanks,
Yazen

