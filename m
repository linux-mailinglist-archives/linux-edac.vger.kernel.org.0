Return-Path: <linux-edac+bounces-3172-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C5A3DD07
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4979B188A577
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911201FCFD2;
	Thu, 20 Feb 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erstGHXn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43001FCCEB;
	Thu, 20 Feb 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062250; cv=fail; b=oMAB1NS2gbzfN5wxnU4tFTe5Har/7BtwSq9PJ/122825mN7aYdcYGGUdlFLajIPCcH69cJmgD8FQSzhBiPKxhfXNpgp/MkPHPt5ZT7Gxe7yxKUOFnTWY9LTiMsUB0hy04QO+a2AizWHbhekbrDUYueMwLUwBul3Z3ErnJpihFgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062250; c=relaxed/simple;
	bh=9YB7JlN0oZf7bh3B/FoIcm9xY4LBmhWGTCG0/VrzFOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imeCCeHVtAYTnPwfGofjKbq1de08tDrnSaMtH4IPWcKygDHBHmQ3bMhZvAVdSp37+zIBfrdBSfnKlVqfOR7XbzciEMwBq9LiVPbE6SLVcwILo28od/NL4ipSKTd3hzFPXS1E2gGbL41HAo8qMJF9gcoiVIT4+UuTukcSs8ebyWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=erstGHXn; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaXayuA4gDE3b5o9c7lynyx1GaSPGzsqsBbjFryf8j2ZmifMeRz9sX4ogWHihunkZBn/lKWQS3EGwk8mlFEl/Pkia5xhCuVlPMXHptvUNzgEf8NWk8zG2LQla/y3KFdYAtbqUcrWwkdlJ8HKR1ZwCXsKUfX+vXGOiLwwsJx/3487onv3ONRhzlkMwo3dJFoz/KBOwlp/Bxfe4sucKXF78qVW/rEAtrt6W7QfkH53pO2QD1srGja4+CkhWewuxllT9KbbqGAawbfM9fp/tzWBrkp7OEW31eTnJIbg5yEo2yB/5KlnDeqP2gkPVQQjy+LQ1X0+zJUuFWXReLWLJgqxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnKm7NKvvIS+xV9AI+57dDsAS0VGe365IRGosjkviLg=;
 b=gj5gp+m9cLXNwNf3AJHSFzLO/yoe5kvlU2M11ByMXvQ6WJddW/iTC7RtipSd/NTeCdqLNc+zZVyAsqn8ydL6VceMLWUiqwoYeDrZ3aTiYcRygzK3NZrsRzJacihEMr+gbaOgKerMcj13bI/TOxMOtzqQgYr7ShzrsLiw3eSLOUWTm1kh9rQMStj4UQLl53Jw+s9Fvm4jP+uMgQKbHoeKgZpy4PaBCSYDrKdNCBgGumHyukTSvDBkenwiLfeWyv3R8v8odQpZFmmukEGqn8nsqI/G7QUEHg3CfLgtF1KKqLhGbnQXsYu0dW6makgD7a9ZGMFPIag6KFMkbclopVPs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnKm7NKvvIS+xV9AI+57dDsAS0VGe365IRGosjkviLg=;
 b=erstGHXnSZ2NEtGiAAAEyh2o/JXvl1rrGqNoEI2iOvgaBwY9hcY7UHydVHR1j5X7ij8r/6fHLU/eiLxdlsEn31c1N/UcQqi+XOKl+mqbkh3pPkwto/y9F3Yk/08wN5cRjeM3OR4WVL6NE7b2t8Wlqr8cB7Hm5Z770169dFf2Pa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 14:37:26 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 14:37:25 +0000
Date: Thu, 20 Feb 2025 09:37:21 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Message-ID: <20250220143721.GC589698@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com>
 <CY8PR11MB713455D3FE3A60DF09F5404D89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219160641.GD337534@yaz-khff2.amd.com>
 <CY8PR11MB71348215C3D43B73DA4B3BA389C42@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71348215C3D43B73DA4B3BA389C42@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0689.namprd03.prod.outlook.com
 (2603:10b6:408:10e::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af49002-e4b5-4c29-eceb-08dd51bc17fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIZYcugnPYzrpVi7K74oR1Y4eHULs8eZsLG8S8wNPWnVy2pH9pEUskLD0Sds?=
 =?us-ascii?Q?a48uYSigQQ0oym9LcIBdVUBCxXTm4OgkxR6Ojm4YtqDPx9nBSndXwgF1CFH/?=
 =?us-ascii?Q?d2o7GXMvJ7b5qEt+QTTBgeZNvtm3hn6fRRY5Byqw6T2ai1BUjodcaw8IsGAy?=
 =?us-ascii?Q?73TgVJiKkaTcU5APyWvOCNRN1r6fXEskskGsWoSulFpq/epmzjducxBQ87Ub?=
 =?us-ascii?Q?19HxjlAP91XDc3UlxmdW8O1pXp97Y+2BVDq1dcr62PZMudhebEPp5cTOfPFi?=
 =?us-ascii?Q?dCe8rCj1zz0eInIkkGEg2eViA55uFwZSUBeuR5gv5rOTvg78x3HpBd8enFOQ?=
 =?us-ascii?Q?iW/b40WeSFL7cMv6lbdCl07eN++/aO4m7/mhOwrwIb23IPR0L0G8fTSwaFPk?=
 =?us-ascii?Q?hqVyhQxUus62r11/HCbS11pWC8EZA0nEbyBOziZi6CbnIzfsPTnk/yqnNtRx?=
 =?us-ascii?Q?QU01cHm1WtY2G4FEuDsDB/ytNeqrGHDG30Q4fBDsigpJMpkyVYkHu4RvxUmW?=
 =?us-ascii?Q?fZ4MWvTPnWgcqt3k20MyhL4KdAa1vcht5bDPj+VMojzSZTSusK+4xUsP4CWb?=
 =?us-ascii?Q?4qTBlD4arxD6YJGNRadqqvkQGlQ3NjXknyW0J7gddN2NloWWLEzjXqyG4U91?=
 =?us-ascii?Q?MRyf1VRp1TH0wcA8lb1H4gnS3SaeX/sVQeSIjFg0nmxAbZK4znxGvW3eKax0?=
 =?us-ascii?Q?XvmHEgw+xrc//8uprvkzJUvWXp9RU7Njq0ktOpJEcGu+7qLfrBkoRqQiERox?=
 =?us-ascii?Q?Y8YCRrzELcj76FNQOoiFbv1XsmxHK/WMelos9jlOjBezI+Yoj9esOJzBGIrD?=
 =?us-ascii?Q?RvY1ateGHzdwiz5BZ0v5Hh0oYiHuqGLr4AurGI5fzAif8jpgjhunEkHltziy?=
 =?us-ascii?Q?AlSZqpugfOgJzNRyiStuSeFUV3JaZKlgDY9NxSorU6haolCeoIoc+mOzfdnU?=
 =?us-ascii?Q?/54KjM8nS+vITDSasQfjWDqzXFJcEomb5J/G0ybGYZq/4FzIhZnInTcN8qZ2?=
 =?us-ascii?Q?/+ICxHWEmD0PX/p5rIniRsfij0wA581zrGFY6IojoCqZFgVoG5ZgSJXyJUr0?=
 =?us-ascii?Q?9Cvo96Y8cSmOGcrb5kshz5al2Z92Ncu4OgZtUjxYNLjcFuppXRNjR9E9cnTK?=
 =?us-ascii?Q?DDwt41jK43eBM8q7/UsLDFK5aO1HmulYfjALwN5OJHqzskGWREtmt77PvGv8?=
 =?us-ascii?Q?b9mpbqubv/s97d8h+pRJ/4fic1TgdTANt0IJysG4/sgxpU/0uFMQo8s4eWQR?=
 =?us-ascii?Q?M/FDc/Ii0UcMwWPRKQGx3McPvOT7tU8OMjcZ30LJ19n9uwSl1PqEtOmg0oSh?=
 =?us-ascii?Q?2L8rlk+jsf4vMe9HQsPM3CDNK+dz0berV7ZNJWEJzNeteBYpcDMM5woFcQs6?=
 =?us-ascii?Q?PTO0KvTesXaND0Nh1bFEhuVW+38K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwABH5vC1UCeTPTLC7A6x1fKfUuJMMQE07QudIoHtcNjiN7WkeQYt7o2CUcK?=
 =?us-ascii?Q?oIc7gZa0TRHPlDmVWWVIcOeERVveDsP4Tcii9NFD+Vu0cwELrKfiqYVk4Q0a?=
 =?us-ascii?Q?9pHLY8+06mSlUxxnHtNkqdhewIZmpaXFC1O8b+94dJ8Mk9c7muK3OHJyYwqA?=
 =?us-ascii?Q?vv0pr24FeilieJ8AGhI0PdOPmVwXJOK8aGl4d1gEy9Cy+1zSk6Dgf/+N5Nrh?=
 =?us-ascii?Q?0KnW8XKZSs0jeW46IQdeBAEBEJ4+R5KW+g3XC5k9bKwSEBmp2w02jaKYZcuM?=
 =?us-ascii?Q?ChGV/JZuaBn+MpiewMQSj+DBzNcSZXRojcnFpGt7KUJLqPme40clUxci4SOO?=
 =?us-ascii?Q?Ft6gY+omGVKBarVN3qODDY32kNsVb08HshhR6GJsRWJWXZNiuWkZ7d/a/7fl?=
 =?us-ascii?Q?x7v40C4JL78pHN2qaq7CVRN/2jGNoTm3XvMiTFwUMV81ilrtthss1ibXKa+x?=
 =?us-ascii?Q?uhzvEREUcHl1NpGEu32JbJq9gbgdN6HGBhWMyOQy/6qS7hy6/vQrRK4f48pV?=
 =?us-ascii?Q?o6CV0ctMkZRps/Etm3zflZAdnoxIxWc+kM4D2yXoEXTMKYnot2F++4h+3FYv?=
 =?us-ascii?Q?ofDMFDhfw6Vs7CMipI1vS+pFW5yOporDvVUyfcsZgJK2GQ62QXwbcbdg0z3B?=
 =?us-ascii?Q?ZNfSrBAdwWbDonH5gLiuF0XaQErI5FJkPlydBm+K8bJJYG4Fn9UbPpB3p0vL?=
 =?us-ascii?Q?Q3X2YngGfEgRjKIWKlehI5yh77UF7O8NsHZInUSTvwZK6TjXXNYnuc5Vdj6k?=
 =?us-ascii?Q?q+h5ZOQFenXmJyQWqcMum6KsTBS7kiDkTwHkXn5Itle3Er8hXS6swuWX8uGX?=
 =?us-ascii?Q?P1IrwYNdOcTL3q/Rx3ek9eEciR18qWt0wlx3dCH6Bh85+3i7+E+4vu4WApC4?=
 =?us-ascii?Q?WGK6/+dWT/3oNLoitYSotLCCOX1sDfW/SclEmlDsoI4VXwfihzY9vk2Io9vE?=
 =?us-ascii?Q?rlr8sMXrvT2+Z0QPypE5PdsNKvleFNEtxXPrNjrUcd7No2pM6Sh5eALI5UGe?=
 =?us-ascii?Q?87dIOY7UxbYeMmbxDRlXTj+TjBg11PdRqE1tNpTFA0LRVK56TdIHjoGRGwqb?=
 =?us-ascii?Q?utZ1+V4cz3omb1EQSrfRCKg9zhJ1hqW+RjADZh34hdjzKL4oG3Mdi8tzpnjo?=
 =?us-ascii?Q?6xxD0ZA/PC9201KPjxYlyxID9orDvQd41caKoSvipS2ZfwHHiX5eWyQeydSk?=
 =?us-ascii?Q?NyDkWOAPrvxBjZgjauRrlOwDVe2D2Vsiuow8BW45DWJhgPbTfpwGgMVkei7m?=
 =?us-ascii?Q?B/867ekQW6WsO8kdNJWoZ35seYS94FBNUPWK4vF0ZVGJZ4H9Me2U9q9G12z5?=
 =?us-ascii?Q?mB8hVYUIWZE8+DvQdkLx+bZd+ww5n0z/Ve4Thc2hXwVk2j/S4hMjb/albWsB?=
 =?us-ascii?Q?NOO/hmaJqWxousql7dY0+D/B4dAEEYICicGzXGrq7gRottdOPdfc5YW0V8IQ?=
 =?us-ascii?Q?w0SyKMGgJlpX+GTIefT+R5ZF7U1uYHfs5iwPgf6Eirb0BhPN5i2ndw3o5BUZ?=
 =?us-ascii?Q?4/4X5hZ/jmipqbNrgk7Mpgf9fuui7GZizgszAmEFCV/l3zHGA4N1tV184yDS?=
 =?us-ascii?Q?w8J30DOoLEg+i2PyVmcaE8FVIgqdMvAfezNG4Ni0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af49002-e4b5-4c29-eceb-08dd51bc17fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:37:25.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV0bGcxuNsW6HIbMlAXUaz+XP4gDgXsL6Nh8LSmTPdVQjKx7z7MDL4EoO7hZUfYHHSYXW883dPpCY54QIUf+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368

On Thu, Feb 20, 2025 at 01:27:03AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > > Is it better to add the following description here? So that it's clear
> > > we don't apply the quirks for older CPUs.
> > >
> > >     Older CPUs (prior to family 6) can't reach this point and already return
> > early
> > >     due to the check of __mcheck_cpu_ancient_init().
> > >
> > 
> > I don't know. As you said, the older CPUs don't enter this code, so why refer
> > to them at all?
> > 
> 
> As the following check "if (c->x86_vfm < INTEL_NEHALEM_EP ..." includes older 
> CPUs (e.g. family == 5). Stating that older CPUs don't reach this point makes it 
> clear that the quirks are not applied to them.
> 

Okay, that's fair.

Thanks,
Yazen

