Return-Path: <linux-edac+bounces-3800-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BCAA622E
	for <lists+linux-edac@lfdr.de>; Thu,  1 May 2025 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55441BC7209
	for <lists+linux-edac@lfdr.de>; Thu,  1 May 2025 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924E2253AE;
	Thu,  1 May 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGMwFR46"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3A211276;
	Thu,  1 May 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119584; cv=fail; b=TJ6Za+PefuswXv6/0LQhZJHCvf6Sf8sRPS6FMYvdL/1Ssd58VbvXGpNY+/Vg8sgHvyffzW9J30M8JhWp3TFx+lyo8sx1js46ucgj3v2dFFCgK1LOzNOoTo3n8IfvJS0/yl5Ok/AO/Olw3s2R+7i41GSQ10riJmOzXSIgkGtBFLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119584; c=relaxed/simple;
	bh=DqyAVi5oVsAYHBi281EmT11MW6ZVMNFmHxk5+QikP9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OCglr0s37YSG9prGmgMpIamXJRCl52MY5tjOEjEHrOQrqy3L87NFnBWITZDPfk0W1iA1lAThlBgHtD9nSsti4TMgYqSzoTaeUpV66Xg8doA9FnAnLkm2ajPKf1GyWJP7aKDO3UVm9yMchfcpXenl2oz2kePUHN8/VC+RSACJJ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGMwFR46; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5bOlMijoCgtArJVyvr4QH3BxDkd7SZuDmFInPt8HUrDd828p5wYDKB6cW/qyczOMnekQdEcYrnZFpMc31Px2S/r38WcyyNDLoZl5SeFT28T0LUxDPaS9GdDjjAlG6upbfbxaNd5a4J17i9tLYiGTcitRvoPPnmSuw/mS2IU2cvBHmPvsVaj+tfYycmMFDjXVVVirW2d2KoD5TTiQ2tLnO3EdN2Py9sJZ+LaHi3RbdFd039kBCmAnA6BZFSzZf05XtYhi9H4v8Iyfd+rpGQ10JvlmLVciYryHveY+kvqxyMM4UAPdpxUCoV+l/RwzSkG+0cj/0rZcTJaSt88ymmquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/u3D23+JEF8ETyuL0YALx/qDTjS+pkXadjjtG3xFok=;
 b=jQfdnh2CsXp+Uy2Ucv6ZlJHyo4nzfcNNLITeYqtfSXs0nNVLM8VWA72lYrurPEi1iRsJzOmW90ae7tjwTanynyeHEqC0cpdJGX7x4cynDcvZ0VD81zDDpwitB1px0MkNxdh+YmzOIjzDbsNSWFydFdbvsIru9o3tyYt+DCce55pQjjkQGnRT6pHwBclkfURtqfdwtCWO0wxlydOpzdzQ2dn/W0Oa6ITtvtvzJfWEK3+kWq0yRLYo6/zusjIBItIqtIYo08ksNF4+rOQqz0IOPI/ADhpENVzf30k4GziNR9hdQD3N7k/ZuQgN5/wKDOmW/EBMiSkE5N8q8gQVW/JnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/u3D23+JEF8ETyuL0YALx/qDTjS+pkXadjjtG3xFok=;
 b=rGMwFR46MzZUbd+ZJT2ERwbkQvpWPssQW8dOpafcKWeiJrUeaeXhKe2FTR7FfhSEbY5JdUeBrLnbp55Xf4zDcrckZDrbGmCjfDrcXMg7/zGv8jt3emOwI7NsdfFvv7MS8U+7fEg405pZN++cUGPfEpAV4JofGneB8hji9yxAdeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Thu, 1 May 2025 17:13:00 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 17:13:00 +0000
Date: Thu, 1 May 2025 13:12:56 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 08/17] x86/mce: Define BSP-only SMCA init
Message-ID: <20250501171256.GB79372@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-8-8ffd9eb4aa56@amd.com>
 <20250417095224.GOaADPWJkNPV3rChp4@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417095224.GOaADPWJkNPV3rChp4@fat_crate.local>
X-ClientProxiedBy: BL0PR0102CA0043.prod.exchangelabs.com
 (2603:10b6:208:25::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: d100b6a1-18cc-4959-7e7c-08dd88d36cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbtBHewEeq9H+pUUrorV8QqraIknuIwGymsQPxmQcByLg7MjD7j2rM1PGdlW?=
 =?us-ascii?Q?VvSTOtUhHafkxf73eQ63lWfaJrauqMbaKg5QoLDQrmt8zoEElTcHN2CYb8D6?=
 =?us-ascii?Q?p34QjktGJMamXVKlwCeLixKXdUUG5HeD+a0kLEhLFNoHDxvqovQpH+ApFqMs?=
 =?us-ascii?Q?RwrahZRzAc8V3Np/z+eEmnD2ctcoDqhi7f6AKmLnTtq6FSgNkr0dJXTVZv29?=
 =?us-ascii?Q?U04s8HyNOsBF+aqrg26i3uscBWjtIpR3shPPEUl7zgPdVUyGzv6I4Rw8UqI9?=
 =?us-ascii?Q?d0rUbMU91Gei/Ls4zX3q5jRZCMo2LSN+b3CE7Nlfe5zICpV2P30inBjGtP98?=
 =?us-ascii?Q?cnSLfCvJhghS/DwarTbEhhNZM3z5M8gO9WUWPtBNmsXxhOVJXqUrjcpcry+R?=
 =?us-ascii?Q?uV5hDbeQsoyfEnFIQlzcnLn0Z2q7oDn1oINWSKPGimat9xbLHRm2ChYpZAhy?=
 =?us-ascii?Q?R7T+mYRM6ypJ01VtkuYBfKvHB8XTt+/st824Dt7a+7jWyeUskJqQhkWimiSJ?=
 =?us-ascii?Q?9tGhsWPK3UZgcXhhOQF+/pOCM1B5G9ILcqxgMHKi5nnqow6F6NYuRIJw4ddX?=
 =?us-ascii?Q?EiUcpl7Y5GTo66pZSpfoZf/fiGDLjHMQF2QHIY1vrpH7ZyEWDULk/OIWJmDH?=
 =?us-ascii?Q?vPtIKVYNSaQ5MzUgreu1nuEpeEr+VhXdhLd1XZ8YGZmz5zmRdAkD8QUx3xQi?=
 =?us-ascii?Q?662TnOVD1bpg/u2k3GjpVWT/NV/aEdKxPcYUY//yuDMubrMJOHAYmFuBzmhR?=
 =?us-ascii?Q?CDzY1BceQT5frDYcCyKSH9XR7cp5Sghc/yHjbqMP8s9Tf8O2p8oQBEmbaPmm?=
 =?us-ascii?Q?cIeNdRMdOh9fFTc8oWfmY/ljz7b/hSHvaiirpQG9VKvTnI+DaY6eIsgnmzMV?=
 =?us-ascii?Q?CvHSZQ+ufy09GyJt2D/rnf82qfwOi5LxU4IaaIdLOppgOQCvqoVBqxkXbmyZ?=
 =?us-ascii?Q?wKYRVnvtD6iHF+Za3UlykTWPh9R0hiJDDf/kQCd/bZo+nD6rBCNJ96gL2eyC?=
 =?us-ascii?Q?kXqMa/QrPGQ9+46bfMa+x42l57P2v/kRwEZ5Xu6UHr6DRSQLwYil+bLjWwkE?=
 =?us-ascii?Q?sAGTjsgfOWfn149M5n7BfXNFvZ/qzkqnutRb8vvM5CZsM+RjX+Bv5JmSGZEN?=
 =?us-ascii?Q?e5uuYo5yD5pd/8dphs7AYprGZeOhHXhqHUHLCzXCOLtkH9I5vJUQMsGnELD5?=
 =?us-ascii?Q?zKtgbGY0f/hFZdzh14rOOiFvjU/ElP4eHbsOvwGN2Upu8mZD20SeTRLaQg9X?=
 =?us-ascii?Q?s8XxNc52uCqQ3akqTVHFa/NgtPUu3zBD8qUYwSA3lz9gb05GrXEMSN5ppDpT?=
 =?us-ascii?Q?ykf7OC7ml5gT7m16G2fFHFOMRJeB9YPjnUw3y9ukDRU16pMvk2akp95KiWbG?=
 =?us-ascii?Q?7/Rfwq8wE1Yf8Gkt/ChQxDHl1yjNiqSKL43GSmUnxMDffAH3qmBF1oPPJT3C?=
 =?us-ascii?Q?xTk1LiunTkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYvTQf3DWNy1fnUrFe+UlpvA0Cs+oQCXuIw8udHGRkPgaggjZC6O0W7J4Nrz?=
 =?us-ascii?Q?gx8Up/5SfHTIxh1xq/h1Ym6eQq0dEYBxkSeZA1zNE/T96HTRww52PZw4umJt?=
 =?us-ascii?Q?46W9YkA9wrKHBpq7DWcqCYm6EIzBNKCnCrEWV1Do+TfLoS8TJELe60EDw2nQ?=
 =?us-ascii?Q?9mfmP4srdSzqedWQlJBl3GuAo25wuz1lfpmOBXLynQ8g/nhqlsJ/XDSNIm+w?=
 =?us-ascii?Q?C1ewuKSA0nx3yMyD6pnUVJ1NXCveB3WscA3CjwgogqvfP322cteZYqHR6Eln?=
 =?us-ascii?Q?i3L/lVvbAsrxwcb9ClDuFma0FUf2kIKehBxn+iUEM8+f7kuREk3rLhl2L/JC?=
 =?us-ascii?Q?DLbFVpkFOY/f1L5HNJPvJk1th7D25maKxR1xMWzkh1K+kGzWlvfLi7T8LSfp?=
 =?us-ascii?Q?mi7ubFrkrUM9BSqQcMNRgj9ourxCuycYsgUtGDeY1pJSkT6hkfoykIcPr2hF?=
 =?us-ascii?Q?TNpPMr+tKj7kUF/0Vl4ZCHJ/2rInlh0d/qP12K9KZgJt/tW6cLvBEyzVS0Hx?=
 =?us-ascii?Q?ilkO/2ehanbJzc3D+I2ngC3Oc6bzXps5JGVLvjc/PIzGz2v8TR+324GNJ4wQ?=
 =?us-ascii?Q?4fr4daBTskrCd1k65ZQIMr2PGys41lArIPQ41ws4MzUEyt1ej4wr5zoCHQDA?=
 =?us-ascii?Q?hVceSIQqp/v1nFd5sCFJvRArCUCzl8Pg0ckFIzJQqfVQz5GOEbxPKxl8zesU?=
 =?us-ascii?Q?GE6yolr42+TwRjWIh9knm5cvgOdh1/RnGde0AGgy2nrTD2HfijcH+X+IdXbE?=
 =?us-ascii?Q?koAHvtZiHxwsgmIJcJt67eX+kr1uKv731ldN20Min273rlz00Yf8zSQYpXo2?=
 =?us-ascii?Q?d2CIAgrlC9Es+9FI5n8sRGt0Vx4IeFEvyC/njoYuPJmzyeRHlce6a3O1LH4k?=
 =?us-ascii?Q?sDyU9N2QFMtOWga+RZS5aaP4A7nvNku+fK8WyTTHP0sKdfMGJ5x/jxuUwCHW?=
 =?us-ascii?Q?HPyGukDGgvQ0+ljCqo1UAW28VjM56BpaBJixvd++uDod+j4Ee5rn00lCJ0zM?=
 =?us-ascii?Q?PKrYjh6K42hDOfufF6CS7naRyqcaUS8n7SVAKpOQFOvhVc4Es7irgQERUKto?=
 =?us-ascii?Q?ecpWx3U38a/K5C7mPWx5gDPE+kLgnM56Mqo7ZYM8SjByXfU+KRYJdiITpIOJ?=
 =?us-ascii?Q?eyvsa5aop7XJHvUbm0dnLC9lfAOJ3kkEHfcyoo59K8TvJWxWhAsV5O3Uae84?=
 =?us-ascii?Q?SkACETTg4D75Yo4VQVtgmFFOXJzlF5z7iEy95plRG82064/ytObEBmj/kCJy?=
 =?us-ascii?Q?SVKXBI5oHyV1VfEvRjEH3dZ0EUlz7i4CqrHejqyVBoQodntOAKFald45WnQ1?=
 =?us-ascii?Q?vOQ2GLkkVXtXFx4Qw//A2WqtuZlDU+8NyTNn2u34XEL2nXPGVBXf1wOYQa4J?=
 =?us-ascii?Q?batO3YDoOkGgQe9NTqiBv97U3NyvQYyQn4ZQ+p+7KBxeX95KOiid4I9lbMQU?=
 =?us-ascii?Q?LsAjCG9Co5o5cSobRlZHFbBgAUSbkI6glNdz8j4SOAaPPu60JKXmpMHJBP1f?=
 =?us-ascii?Q?TE5QSd2LnfgPy5lW1ngWrmbeQJE5tK/tWZ9gtnO14JV4MECIGRt7wRxEF5EG?=
 =?us-ascii?Q?djiOtcT/RvjQev8N6mi3QlH6E9Y3OWEAEaIi/Il6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d100b6a1-18cc-4959-7e7c-08dd88d36cf5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:13:00.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0EH7NxEUMT6O7wxoxJxXjvyh1WCnoVBB07y32OEY9NAs+7aZTCJlCWTpsNRP3dzAOHjwedBN+ricqjXNithjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

On Thu, Apr 17, 2025 at 11:52:24AM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:03PM +0000, Yazen Ghannam wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 206973d7dbcc..0d84b171b851 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -687,6 +687,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
> >  		deferred_error_interrupt_enable(c);
> >  }
> >  
> > +void mce_smca_cpu_init(void)
> 
> Same note as about the previous patch.
> 

Ack. Will change.

Thanks,
Yazen

