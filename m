Return-Path: <linux-edac+bounces-4619-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFADB2D001
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 01:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E2E3A8DC4
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E740B22D4DD;
	Tue, 19 Aug 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9W8aY2g"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4235337A;
	Tue, 19 Aug 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646440; cv=fail; b=bXXm0kEptyUrqYoX0K1R2RllwS+FHjU9BNoQ7kzGxc+CXeYsxX6KO35O0hY43GUrJnycAfbQOaeDzoSxRZR1G2sgmBTheM152g8RND/+zyjVfgRwlP+stjyWcXQf6tq+mRtOhyJD0/oHFtBErfQd2iAPeimQ3KyRxeUn4iUnsbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646440; c=relaxed/simple;
	bh=Lwf4lHbp9vOLKDHpXFc69H2N+0k5g9lIZLT3BuSTXuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZL5rJEbDKE8OhU0Cra9tk/bAGDpdTrDaib3ki+JsS5+Wt8qJjA7tVPi00bKDjl1IzYwD+KXEozzYzHG2UYDbafJ682axiFQlLUxNGu3qvGURx48JeivUabWM3yIyEQ4B6J238ooE8Cd9SZuqXY1lowKuc7QDWrjKr7UhnF+HWe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9W8aY2g; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755646439; x=1787182439;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lwf4lHbp9vOLKDHpXFc69H2N+0k5g9lIZLT3BuSTXuI=;
  b=c9W8aY2gvomedw37/pb6SKVzgkOVUK5O2LbDyEAEAbO+SYyM0kF8iga7
   V8S+8sVRVvMMEcCrh/ht2dV1BQ3fB0iDsEWd5Ldzz1/layJFX82ZHcuWd
   ZvxsTTYUMfml1KN8/vLVDqfcdWUbb0G+RTDeylRN+1VbUCxw2/0kY4DhA
   +zkIEM/NUTyDAapx/xAHTvtSSOXtDxcnePHCSsfTRLFEEMvDoaiLEKosv
   0Glqvf+6h5Bk8RFjbLoWQsj/joouvz3j4YFUOuhGJXullKPGTI6Mvpp5N
   ChdIrNJnaPiMBrFarhvM99nM8A+ntB6zV+RPd+9/7nvoNxqvCGLLgEzVA
   A==;
X-CSE-ConnectionGUID: R3IVhTqlSduNmJnvOGwtyQ==
X-CSE-MsgGUID: FsAEFqq2SWeSKXHshSkfVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56932778"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56932778"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 16:33:59 -0700
X-CSE-ConnectionGUID: Rvd2lzNxS9ynCZ8m2YsLbg==
X-CSE-MsgGUID: dA5D1SXaRDCjgs+E4ljVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168389832"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 16:33:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 16:33:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 16:33:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 16:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SazqUKRlzMtMeGmH3RZcHyFrOOkjHv2Kk2RKbaozyo7ztyNNlDLPMEvz+TEr7YATjV/Sb7sDJR+y/X0fqn5EHGx5aUo/edB1eXOhIfe3hep5yvChelG6bgRxdAPWybiHzjwlrDYCyl3NUVnUfGG7CGK1Lm1/M1hU1BI1d02xPr8i8gJo3FPoyHYWDOnrn1pabP2O0zePhlIxvelhXnybnF4NPWacf8wvrydzrA4tWkwteYc/nA8lzTNMzMf/0s1hyjbP880f+9v6W95SXVqoI3vXWCkckpYKex+Y8PbaA8+BFFzY7VvmF0I80BmdEW72TqKwUbh/xTlC/Tcp0CS71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMdqSXPaj93Ud6vKT2r2YEXF3yx3JFaZA5JnjZnfBQM=;
 b=VKiW9pr8juFkeTnEidTH2KpS0GrX3TBcvZX4eaooFAZ03A25vH+SKQjSFV05xbNkJPtgFZGuyxeXMgCU+/mVfxU52aPrSs2BExNRBAZyPLqPdUeiQx72x8qYti+xUgP3wJ6yGdvehPTblNlkyUi0vuS98renc58xM+DaA9KesQNfcUGK90NouOGNQuAcCkrs4SyJiM5k96l7F8U7AY/Ez21xhF4sGXWU90a2zVPTCREIYNX8R5CnAJ/BtwkbT5f/uKgh00sKr/739aSbvMeRRef4kOJ5zNDSkUYv3cHumbk77EXNwifw2ZGiyM3+bCFFkBuAg58Fjg9Kc4W4LM6KLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 23:33:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 23:33:49 +0000
Date: Tue, 19 Aug 2025 16:33:47 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Lai
 Yi" <yi1.lai@linux.intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] EDAC/Intel: Make memory controller instances into a
 flexible array
Message-ID: <aKUJ261tPZf8gfgr@agluck-desk3>
References: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d102975-166d-466d-2c50-08dddf78d90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J9yOQkD6FO2qNpKqcnpU9rxN3vAZdAVmjSBsWEY0UMboMfpL/ww0QBIjrNAg?=
 =?us-ascii?Q?LcM5fGodBbCcEtY9tHKHwokbmE5vVR3f/EPy1DwnIiaqKx6m3j4MEVVJFuCV?=
 =?us-ascii?Q?4nhxbnzk7uGhKFpCrb+gIonviQTP2mP10qtvfks8bYm4FIPiIMDKtKVwW8Kt?=
 =?us-ascii?Q?dEJ/n4SibzdPaTRqzLn+7Hri+wPTIVV4rN8NU0j8Hlg68jKrBHJoxhd/wF7O?=
 =?us-ascii?Q?t5RqmKrKzbLSjdIZ7PMuhFVSFn2BJW1QwoMXoCdGD/PTtkLBrH7mgNqT6R9A?=
 =?us-ascii?Q?5i/T+LXOErLhZdu7/DuUDgrODEB84TigQTmBy8ET9le0W8VXl+3D/Tp4GS7I?=
 =?us-ascii?Q?nGIj+K8qgc/+SiVD1E5Fi935aCoz+wF63ZU4h+in6s0voYK+BXC5RQy95f4Q?=
 =?us-ascii?Q?B8aeJ/bRG7273mVauFzXAn5qey1pRHIhjidt/Rsl+GZB/0Hu1j8DNhctVCMa?=
 =?us-ascii?Q?4lCV4w//Il74wf3V/v3nVxHJE8HU8rJ1jvSH07xdK5XLK8XJMnnTqaBbjpO3?=
 =?us-ascii?Q?GGbfO9nDQMS0hFWL7fILt4DTv6UDvDayxlXZlK7M+pebmt4dLQxMLVO3Op9w?=
 =?us-ascii?Q?HvuSD0tH6NF2heRJRYRccq++Gqmh+mLw9hvf/Nrnzreb/Jq4Mw6KYILVj9CQ?=
 =?us-ascii?Q?F64l2Dqn3stgWAunCVV2EN/1bTTj0GIRWsLrmdKUSc91DZZhAMjQeEjfmg2Q?=
 =?us-ascii?Q?4ZnhtElPLGVZnXM8A6GSdhbq1+0w63Wblfy8irjzbuRaz2KBEGmROjZ+xIOA?=
 =?us-ascii?Q?kS75sAz7uB5WdWhiBGnITdltxIllWMZ4q512H7FLzPq2IZY4F7R1ReOr7mbQ?=
 =?us-ascii?Q?3+DjPkYTNgoGhYBzqvG6T4+d1YfQbF5y1gEeVB7e3DM8Eprn4kNXJPnGVOce?=
 =?us-ascii?Q?lyCIMMWCWv4U7C9Fwp/bLijVFttBiQM8ca4rqnu7J93xVFRuPK6MaJd/OwQ6?=
 =?us-ascii?Q?QcKKialO4kRXA/5VntIr8vjp63ezvRb3ALkqaGcln1gadXaz2Ua3smEyk+Bb?=
 =?us-ascii?Q?gxJj4hOc28IEPtQ9UF26JjFyowJEnfx6QFqXKhXcAFcLBPUX0SCA6qoVylz7?=
 =?us-ascii?Q?Aeynv76UIMF7vBhhbZqGtqd0+33NJk9x8RT24+UnGvHF7pNXG7gEFxqISKRe?=
 =?us-ascii?Q?1x19mcvbg3WO7zj//TvX2ZTSXBTNQ3YcdCqBADhRZGKek+OYaS548Ilk+Fea?=
 =?us-ascii?Q?Poi/hI5zZWw9BFQ3w9a6lTTq70E11JFkEMbP3o9DpXZJGdTScuKedBtF+vZP?=
 =?us-ascii?Q?BRKQ+hF5e88Afw7nD8bFM2pGhfZzYlrrtZAdGaVlWYyfwnP9WR2gDELM78eV?=
 =?us-ascii?Q?Meqshw4+c2tgHW+PpbMXoPJBQ8WX6mb7oISkWAr+tpKD4PFYm1kKxvy3D9Um?=
 =?us-ascii?Q?rAVLLxzUSYAGKWyXmHTTRCTxgBGZ7s6F269IOr80bOmSzde8hQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSDytprT43/SogzGDjHTlj5gOB59YkU7cJX5Vv5jAr2zoNMyXLywcXaKmED/?=
 =?us-ascii?Q?GidaU7Q2eg+4ieNLK6HokPwzoxCtrdzS8+SawY+0yHT2uxvAvgTeWLFs6ncy?=
 =?us-ascii?Q?pkYRSoSaq8tgiwx58b3b7bRb2XOg0YscYXYWn/0YtZzowCM/TDZiyXzRHWwI?=
 =?us-ascii?Q?zFgeZp51LVR1x/EUZ6Hwms6gwv7MZ4LyqyZ73xLjHt8Hm871LRY9qORakMco?=
 =?us-ascii?Q?FiPJJoWnis/guQBFJv1WtcypI2VEyiUc4N2eGUGCiUQUBWY84gxaephQriEK?=
 =?us-ascii?Q?cLPEcJtsIYWo0pa+aeYAeKBWe/8h/xylHuDtlp9V3jbYKlyAYZkF8jX75HSK?=
 =?us-ascii?Q?G3UpmPuSv4xUmRKfFVwnhh2PzDtwcQjj96Z99OikDGINDBxvBXzyPH1+moZz?=
 =?us-ascii?Q?HfhLxBqkL7Q+uOzSKhJIn+oeNYPWOgA66MuzD3O99vINIaSg0n4k6hqi9VCM?=
 =?us-ascii?Q?MNzSgePOVli7+ZLNRraR3jby95buZjYeKLv/3vWuX6F4t1oavguzff/G/Iak?=
 =?us-ascii?Q?Mt+lI4p8kzBYyeKnfNmZeMI3TPZpbFr1b21Ys+spYswVT0i9Yn/WzltuW7C/?=
 =?us-ascii?Q?UG73x+KPYQOzNkFTjp4q5IzSRnqo/ZKFrUlzzcO4dU3SHXN1wC5WUGw0oOEt?=
 =?us-ascii?Q?Knll4/wz5CsV6LTVVQboRvK8yr1OL91hpYskrEDOjW3AiztvNp2sIeyOTgw9?=
 =?us-ascii?Q?KGDB5C+Jc2WYZru7VwEa2ThsuYlZwSkqVkt+hYJM/KLu1namkhp0WS5mB7sf?=
 =?us-ascii?Q?Tw2N6xfl9wNQX9llGxeag7zcJRzH2fuy/D8vvGQBrOR5I9Vg5aKEqnRXtvCL?=
 =?us-ascii?Q?nydiNuX7VH9RQ8o9DnmiCYR3R6b48+ZAJuVJmOTbv8H2Mt3w9AJblZCW9Tfl?=
 =?us-ascii?Q?EtF8BEBmkqJjaHmdF98/am0rTC/YAgX9uvahLZvtejdAmvn5o1HsMA9W1XAH?=
 =?us-ascii?Q?YccfThVDJJ2u9tBuyn003q27lsxrx/0/J5v1TrF/MH5/j74+EVa7IfC8avTk?=
 =?us-ascii?Q?sNRvbYR0Ot7cd1LQ0D0Rsnq+pT+llnB9oI2X5U/p4MREmHiWpxfIuyjPCIvZ?=
 =?us-ascii?Q?ayDce3yGKdjFg+SHlcGVY2slcyXeerDcU/Afh/vCaj+hFedzPD6a+wN3Wv/f?=
 =?us-ascii?Q?KGg2gWyxgkIZpGiG7raULk7emacbr8ttBaeV/nufLQ6s6n3CRLJRzz0bUDKP?=
 =?us-ascii?Q?46lcypV8b+yOyJ6Swg9JLv2g8TnDoDqoh9TLMcwvfiRBCPAUKcu06LrsQE6v?=
 =?us-ascii?Q?wSOQ4Y/EVuY/axxUfdrHGt6fK+sztQiJvNwYYxoT/AIJ3dbJ8lmFNdeQOVlf?=
 =?us-ascii?Q?U2tRPXUM1HZWH7/3uUzPjObVAwgkkuns2FfNcAsfJZWOvBDR6sYnMnaFuScw?=
 =?us-ascii?Q?UIUSSn+Hs0AmhsD2YyZ1lFB6uPLpPLufJiBK/JuI1ZUGQ2IHp3/xFNdF9r3n?=
 =?us-ascii?Q?0JJ9/ZMKAHiJQQsXgzeMk2V9o76SLVscXsD1DnLpssmqgKPd/kdqwTkT+PnH?=
 =?us-ascii?Q?gvdpzwsMIvMDIfZodRhlRu3ka+lbGr0mYWFmxjUyyK0W9JFSZgr+ucjdP9TC?=
 =?us-ascii?Q?36o9FZMqTkAznyZ0dVQ3IAzceWSGLVCZt0MDsaUK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d102975-166d-466d-2c50-08dddf78d90f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 23:33:49.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feYeEyI1I78o2iicL4QkeeJhzsxHNw6MNGGJ8ZJjlyetY4GJWjYpyVTJQmV4Ny1vQi/q1xRC4N3tBA7xfCiJqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-OriginatorOrg: intel.com

On Thu, Jul 31, 2025 at 10:55:27PM +0800, Qiuxu Zhuo wrote:
> Problem
> =======
> The current array of memory controller instances for Intel server EDAC
> driver is sized using the macro NUM_IMC. Each time EDAC support is added
> for a new CPU, NUM_IMC needs to be updated to ensure it is greater than
> or equal to the number of memory controllers for the new CPU. This approach
> is inconvenient and also results in memory waste for older CPUs with fewer
> memory controllers.
> 
> Solution
> ========
> Make the array of memory controller instances a flexible array and
> determine its size from configuration data or at runtime.
> 
> Patches
> =======
> Patch 1~3: Refactor code to be independent of *NUM*_IMC macros.
> Patch   4: Make the array of memory controller instances a flexible array.
> Patch 5~7: Clean up and remove unused *NUM*_IMC macros.
> 
> Testing
> =======
> Pass basic testing on Cascade Lake, {Sapphire, Granite} Rapids server CPUs.
> - Load and unload the {skx,i10nm_}edac driver.
> - Receive events for memory correctable errors.
> - Decode memory errors.
> 
> This patch series is on top of v6.16.

Applied to edac-drivers branch of RAS tree.

Thanks

-Tony

