Return-Path: <linux-edac+bounces-3171-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F3A3DD0B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978D9163DEE
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1501FAC46;
	Thu, 20 Feb 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JwedhTXi"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B41F91FE;
	Thu, 20 Feb 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062171; cv=fail; b=oC3+m3E/YP0C5ibu0hvjqsYyLQ9O4L3CHmd1fjg4uHv0pV7MzgP8gK47rUtFtzpTmRJGcEtnj0dh4pUJfXrDi9Y3B2VQgUi9sX6AOSWL+dp4LOD4dMb7M4JIBq7fpwCMdAwI1Y2vPs7HsmSjQzgV6FddYzUHEJUTlTvWdtkWsEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062171; c=relaxed/simple;
	bh=rQ4q6GgoCLCwYdxC6GD/DEmwmCcsgy/8mozK8pmn4mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hTzt8HrSce9LIauTwMqbcdzIUEl9Rmh373NotgLhLoJCi2SIagjAwFVUIB2EB7AbgvEmZeDuj9ZvPiIWvxRhhZ87sB0pFczIr/HinE0BxECaV4i9mpL524AWhqD0IZNXpJnbpMjTcEWX7NsReChVV7Cz1Wz8EEfakAVJUpvKM9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JwedhTXi; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRoqhIfNMeoCV7Gb9T/zPISw5O7iTpVXTKP++QGzc7+hh26SV8BT4E5b86Ufhu/FyGYd4sFGig6cvOoMLaTlvTCEarubmMHB2C9iYsgRxYOLXSnzx+a6OoGZdosGMgFl/pfR49XGaBYcbmRyvc3Z0pjXqW1YepY0XUSaEv5RhxtA64ONXk4tsPgsgBsn4jEOAgJy1NilNGcqKmvd16rfCGfgYrDBbOc5IWIdPjZXxWA4a+IfGVGq41HK7+LTrMGonyUT+rrxi2LI+nGoZNiA1uC6TB8WsaGq/iUKvgPyavByEJP0pj7+aq6Fjrs4tpgP/3iB6YEmQxhrwFv9Q63Jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAs1VRwFF54r5KUeBfvdnw8zJmhFUuEy1sU3NSg//QE=;
 b=MeeGWB5UfzLrjfDxy8qaHZONEu96jBzzaHNHFcWtOKvUQf62XQ98X5HWu7j3DGyqWBGPslZsiVX95uu5qMJDgKgNcXWijg84XiQ3FFZy34AUmIfVYb57WC+p0YSFDS3k/Y3VpQu7pIKLgfdtga7wH9JaIaqgpVs8Tf6ni+dI70dlZ9/sXaRq2LLnp5Hd/bhwfZwRg0FKVjMp56AIk451R+lNYca8b1m3QMJWDxzQa5DLEQ0Ivbh4lCuS+wPhOLjSTwxpTaE5nCqjkGdZsXG9s+rb5oxY4NFsOVuAndqZ1WeYNpjsf9l0EQsZkdsPHlBoqWKoJNJ2c9+Wrk0beTD/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAs1VRwFF54r5KUeBfvdnw8zJmhFUuEy1sU3NSg//QE=;
 b=JwedhTXiKDerv1I7PculLOzo8tzAZhqzNyYmSsXmU3WXd5xCCh3E+DwbOJBZngTj/A/gZpUsZbDaVENSP///g97CKAf5p2H+BFOnb9MrYe28LbStIGMoZe7Cy+KA0vmEVRPTWolOIMdXhQNBATHDAFXujGHUbq61ee3hxYdgsls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 14:36:07 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 14:36:07 +0000
Date: Thu, 20 Feb 2025 09:36:02 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 07/16] x86/mce: Define BSP-only init
Message-ID: <20250220143602.GB589698@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
 <CY8PR11MB71348FE4A5684E941992B5CA89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219155745.GB337534@yaz-khff2.amd.com>
 <CY8PR11MB7134DA72B48006B403A6516D89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134DA72B48006B403A6516D89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:408:fb::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6800fd-f57c-40ae-68da-08dd51bbe917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPab/XivFdytIU87Oz1yW60Xb9Q7bYgGP2BMMlMiGrd7h0cgPNUd9GVrA43v?=
 =?us-ascii?Q?EgjoHPt+RhqGBo4FbrYvKML1p2cF+sgxFtiMdo34oLJ1K2gzjJrh7ydWsWL3?=
 =?us-ascii?Q?7OSgsbor9le+abXn6rXi1DRl9HHP8bhzgoVFmlqiW7x7bTI3h7y4EB6jXoSM?=
 =?us-ascii?Q?jZAqzai3Hb+ox/xogLTp+OkMBNLj8lycssIS1ae00BpbzwYFn0MGent02+XU?=
 =?us-ascii?Q?kojfI2DWLmuv1NTNRVBEyLu0PdW/J4CQcucKS2u7gc8XgVZE8t0pbIXgBgPQ?=
 =?us-ascii?Q?wjbRLAqZj4u7Vz81Avczd+7hMU5FRp/QTxT9KBGi+CY6pOmFnAGlU0ejpCgL?=
 =?us-ascii?Q?2U7sNnB7GxGsJY5+k8VRluGvrjP+yEvaUKN1GVZgsTXsow3mGijofgDFtGE9?=
 =?us-ascii?Q?fv60SrtBtVz7WvMLMqUwMIx1GR1vOj4SgFOsIdOlP+QKfVKce6uudFPQRVFj?=
 =?us-ascii?Q?u6mYGJX4RBrRkyxwEH1u2nhDRmNlyYayHbZCepbjwmOfcrs8SbT30+8mNSDr?=
 =?us-ascii?Q?HrLwQo/c1oXQz/OzxqVIPB1eMutYp6vAJL3a42fOoCbM67TyXqx2uaeopynJ?=
 =?us-ascii?Q?8XWdJ0jvMWJZFwzsOD9TYZds/k+KqvujuxD/fGoApxZhdBJtKqDUhHyA98et?=
 =?us-ascii?Q?3V3W9YQxOVrAGU9fBo/RrNcGkcLt73Y/swRmyC1nuvWef6xAKJowtHY+S7pl?=
 =?us-ascii?Q?EtRr88yWUzUcqVm3LQN7FXtsqvpQtiVAfK6UX14Ua7dkJFcFcXUT1pnwqF08?=
 =?us-ascii?Q?Cz5dMZaPMRHrxqPIOMMvNysgpwsRl1pu3M4x4E+rESmHGZ4mD/3kRGDbd4RA?=
 =?us-ascii?Q?J0CMcgmjwL0wrtiijL5ORUTXNC/goFiSxzObRH7v0cCz+tHhdmtA6M4k/kKo?=
 =?us-ascii?Q?iIPYBTnyAq7+qIaydXqa3dP9DUXkqPeIYG31EjsPR5OGhPxqD/B+tDfW5E8S?=
 =?us-ascii?Q?xLtf2s5vGENXwWc7lNVUtVpomjiRAR26pzXAKzDC86sKoWa2RhnAxCPdc+YZ?=
 =?us-ascii?Q?PmUwxNVC0VY27z4h7yYg0O3qRkwntbCYDR6bg8BYdZf9HBVhEt0eMoimK+Bk?=
 =?us-ascii?Q?pkJXzvKeDmaCYjBLLxj/laNUgxmr188wDV1Ea216Kpa1nlkz9d3wpS68gtOO?=
 =?us-ascii?Q?5v6fug5WIeSjGY2K5svDg4WgnWG2xWYEqqHiAMgSemzpCQqFNJkbJDr4PDV7?=
 =?us-ascii?Q?AKFwyFBeUQvv8FbszowOiMBtvPyTvCIF0GhPZF3y5ocuaKCp+DOw7JxZGe3/?=
 =?us-ascii?Q?5oyS25nKvalWZzVCtxRcFeCkzQmySDhl2AA+5tFjH+/iqI0usg84dODPrckS?=
 =?us-ascii?Q?r1W0W5DugC00QJnRZcmBD5Z6zAB9jTOA7prC+g0a6ubE65yQ2K5rjk2Qb9gC?=
 =?us-ascii?Q?YLhmZ4YLnYEdwuRzjQt9i5WHMebB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6F2/ioFRJavQ3uSkCx0ChhL0yZpwxRdDjkLf6yB/Ju9KFjwtiFKedDt+oTE?=
 =?us-ascii?Q?exoeXhDGrsTITTbCtdnRjQgoidb/hXoREpM7KjCxC5mmUNvIJW+UHOMxcl28?=
 =?us-ascii?Q?LdRoXp6ewojuWtfjJR9qIupYv32sGALTHluyolNLug8Vzpikm1nsyDyPXntX?=
 =?us-ascii?Q?CM1V+YZk6z+u6l07hJfoCGm1xmRt+H+T0125looUF0zew0OXlvX9l/JFKjx7?=
 =?us-ascii?Q?3kGehyvZNEDZAupcFjB6E3OH+b+9y3auJmiBqcfgNhd/dVxAVPtaVO87d6x+?=
 =?us-ascii?Q?4CA1OhKJRlMU91c4QaTNychdG/IBxfQU3aaqCcjYHaVDr5ePiFpASkDQfCGS?=
 =?us-ascii?Q?NnZULC5nqrZ60lX4hJBovDNA+dDjvBg0i4U6Lt5NYOWY1ZCHeUaK+SSuZq+3?=
 =?us-ascii?Q?3xnRpuX31oqa5RhDGvFfuqbkFRMMOox/umjtIJWD4jdMMNwr1lEgZl4nP9dc?=
 =?us-ascii?Q?pIJ3uTm7q+wqv8IR8SHqzSD0qgiIXVEbySUHHwZRsEA9uHyoRXIwPiqzq5qt?=
 =?us-ascii?Q?Mepm2SxOfasx0jw7CqKBbiMU2Uz96Lk8m4nPfbM1xFHqXyUpFmAWsjQEpM7b?=
 =?us-ascii?Q?ne1sLIJoameCj713izQKUzxVI/NS2HtAUSHQI1L8lAZ0HiamUqD5Mh4MHb42?=
 =?us-ascii?Q?dUETdllNRZZurfHg1oGL7rze+sY+QSmU/aKQPK/5MQhut2aO5MJmo2b7SwM8?=
 =?us-ascii?Q?7WGlS3rMrLmLFW5GJUK+FsAZR11OfrqwH6rO+lJdIUDcereT0ESlteA7nf1b?=
 =?us-ascii?Q?f0iHTqxGHpOWbl+v2ihI9O9qBdTiCcfnRBGgnpt0EnFmmVRONYkLspIoJRU0?=
 =?us-ascii?Q?8/H9ymJXD4f7vdQmsBbO0mmAX2KfAxiQMEoesqCVdO507BBzWxaehgZf1KKr?=
 =?us-ascii?Q?9SmSUenqV1//XkGJRbiC6XOAkIT8Rmxo/17Kub4WKUMZCqg7fzuraRxssp4E?=
 =?us-ascii?Q?aE1TeqLjb2/UxbfBeTX/kgLuouLzYvsBmj88hSI6wpoh1B4uW0j8inSEuL52?=
 =?us-ascii?Q?n8TGBKTAP5+WhoBebqxr3hu4rpJdfGfoM2g5qvsl1zN276YHT20zGDOW8Cxq?=
 =?us-ascii?Q?1vxWu0Ik2ZQKe3XlllKl9ceb9/1/MB6G8UdnCuaG8v+Bfm7+8EMVFIalbx1y?=
 =?us-ascii?Q?SjSCmk2Yb20m6+J8lXjNonwLJf6Lg8KuCXukluzWOR+qX7CIcqLtd0WPXsdp?=
 =?us-ascii?Q?Po2LDg5GD2gjMvBAaCDA0tuuZ/IdfVDbTIqYREld/mTx+xEBWfgCs3J4Hhgr?=
 =?us-ascii?Q?mVuHxHBjkvEI83PM+QBiYFQgOuuIUkUf8rEpIj9H+UnKHZbaHKGuGU7gXdTw?=
 =?us-ascii?Q?gny/VHSLL0x5PvSQLQTXF6eW4CuNysaT8xRg1hAMxF0O0LsTkai0G7gUr8aL?=
 =?us-ascii?Q?hz35M79jRIjAZs+jZ5JDSb9M+e20D+IJ3sGIG+an2gCHl0o8+N2iGiNSNRn6?=
 =?us-ascii?Q?KTs1vPOo+0amk6tHENTz7Gfkhn9Ws4GBfQ733qcKGtc8rG8hRAvw/YMo204J?=
 =?us-ascii?Q?si1b1X+0OwCSf6MypDiwJafDTTmxXLvODATFxdiyhv/HtDF5H2OX9L0x1Qyo?=
 =?us-ascii?Q?3KhtQh/OCP1UXw3DXjlgdArHRLo0BEvpxUsOiUtR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6800fd-f57c-40ae-68da-08dd51bbe917
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:36:06.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJ3+iN3T16ZUpmyAhvTfsoyZIdGgK2aLQaVMcB4FO/QTxz+d4JWf8/RWhrUuMVE5WRjlilu5wmzz2jVw93Nfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368

On Thu, Feb 20, 2025 at 01:37:37AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > > > --- a/arch/x86/kernel/cpu/mce/core.c
> > > > +++ b/arch/x86/kernel/cpu/mce/core.c
> > > > [...]
> > > > +/* Called only on the boot CPU. */
> > > > +void cpu_mca_init(struct cpuinfo_x86 *c) {
> > > > +	u64 cap;
> > > > +
> > > > +	if (!mce_available(c))
> > > > +		return;
> > > > +
> > > > +	mce_flags.overflow_recov =
> > > > cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> > > > +	mce_flags.succor	 =
> > > > cpu_feature_enabled(X86_FEATURE_SUCCOR);
> > > > +	mce_flags.smca		 =
> > > > cpu_feature_enabled(X86_FEATURE_SMCA);
> > >
> > > 1. Before this patch set, the above code was executed only if the following
> > >     condition was true. Do we still need this check?
> > >
> > >     if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor ==
> > X86_VENDOR_HYGON)
> > >     {
> > >           The above code.
> > >      }
> > 
> > I don't think so. Feature checks should be independent of vendor, so the
> > vendor checks are redundant.
> 
> Without the vendor check, the Intel CPUs will also run this code (which they should
> *NOT* ) and may mistakenly set those global AMD-specific flags, which may result in
> Intel CPUs performing AMD-specific error handling during the machine check.
> 

It's okay if Intel CPUs run this code, because they don't support these
features. The feature flags are generally derived from CPUID bits, and
x86 vendors do try to make sure they are unique and not
overloaded/redefined between vendors.

The same is true in reverse. It's okay if AMD CPUs run code to check for
Intel-specific features. The feature checks will be false, and
feature-specific code will not be used.

Thanks,
Yazen

