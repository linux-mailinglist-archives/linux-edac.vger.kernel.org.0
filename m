Return-Path: <linux-edac+bounces-5571-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C76CC9455
	for <lists+linux-edac@lfdr.de>; Wed, 17 Dec 2025 19:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2A04301FBFE
	for <lists+linux-edac@lfdr.de>; Wed, 17 Dec 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C428B415;
	Wed, 17 Dec 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBtp8JlC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6E2367D9;
	Wed, 17 Dec 2025 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995551; cv=fail; b=tp9aQJMtJhzCRyifBz2UNxv8rMGdcqtlCCr49kzEmsWx7xu2z6zbexTvIlRPvKv/pBPNp2nMaLBRfuQpojczBuo4EV3XCbgDov1d06zdWhn+HkEPr+XNWGNO89rs5TunKqTJJhGj0Ybgcg4h9MrSEmFZO3IqTJ0lS2PUBnEg2GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995551; c=relaxed/simple;
	bh=PQFQ6ZfWNcPPWy1i18eICb1PqpGNLGJY7dfYb48i12I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n3sSE6KXz/OS5qkgzAoXhTPjBzHykuqmgm6tqXcOGbGt/wdABAnbmy6MvC2o2L+AvvENtr7krkBCkyR6E3RN7ZQkDNXSp2zKHjWz9WXXHYKWdfRh/58vWipOWI8Sfd+TJbDCGhZqf8CU4vIxR9xXKWiZr7kf69TsfCPanPX9Qgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBtp8JlC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765995548; x=1797531548;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PQFQ6ZfWNcPPWy1i18eICb1PqpGNLGJY7dfYb48i12I=;
  b=LBtp8JlCCU/yDUcND+3ks3I+2QvJ9GxGvH1JT9xTeu6+7rdj2CRsn27m
   oCzATvZ72Tq1SgqPY4mD2wahuMa4ua9LjrjSC8mXqDlpOGX+N6xygIM42
   B8jw7lTp1RYfkYHE2yDw4s1PBfm7aRD+r/HpaIxZZksszG0HT9u2uSFxl
   K4hmGMaZQVtrtX0+2RjCnyb+FG9i/uo0UdLb/jY5caMHV6u+y+WSjKt0S
   uhfffcd0LVVbiPLolETGglPIOBK/fdGZ3wQkauzoZVC2dFV+PFJ79Ovjd
   wErjnSJVC7lS907VlX9DPkPfKNNVfvLdpEoDJjwmjhC/HXSm2n3iTBBrj
   A==;
X-CSE-ConnectionGUID: Io2a8P31SHmr7MriCl2UAQ==
X-CSE-MsgGUID: euHXXM5QS1uSGCdTdWguSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67137878"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67137878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 10:19:06 -0800
X-CSE-ConnectionGUID: VfF7EZKFTk+fPN0LNQuzaQ==
X-CSE-MsgGUID: kHdgFN/JSUifHk5u52j/jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198379852"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 10:19:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 10:19:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 10:19:05 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 10:19:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WivW7xyr6E/EdddtqnnMs8Le1NMIMDoIWExfzIcczT6QrdIFViuV8D7pv7XH9bbCIfYPjX/Mpm5stoegd+4jDNPTFEmSuyOvTCm1/11etfUhurfIuCAR/J9WEaqXDiaTwfur8+ETIwHgZCluHaAZn8krlAW8JWsYRSme8Gwpn0TWJj8CJ7C38yQKaV3KkwAgMtuZPWnvtO4rR4xCjTAXyfsxPP1Q2oUMmzXpJYwWUu75wmw0rDDeuV8gcEVyOr9qj8GkLO2Z9qUhbPt/7a6fpO7J+WQpSd+HB4VOAfNam1HsVUwvWes/8KD5FTpCvRp6KLFPzxbeLx2QrcvJqIi9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvUX0g6iVwG2v691/xdutMQAoJ8qbkkDfcv/RbMlIfs=;
 b=GT0Srnr/YL/Z573ASWmZjqPetSPAPsm9fQ7Du/AuwBJXxkQJdfz56Z6yV6ItBgsW1E8xeD6z7WoETl8sIfnTAUcoqHCjb6v4XJzlr/ZIoESTuHbzzFNj/gxFtVfA9sSr9vFlrT9JA5DK2HHp9RYergTjWlL8aBqtZFIsX6oyrZloIUIocifoBb1QFt8a2LQe/wr6Cf2/OlIGcasIqrbxrtbHD2tePR0CSy+3rSoxO4ne1cL3C2m+bz40UmjHzlfChLbyuF1O4D1wLLzs7EfWKXJCJ9NeZ0lasrhoUVsMH/LFZUkMWFh4OwMCQO5hRE2wmmsg8DEENhHAPNtrafmNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:19:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 18:19:03 +0000
Date: Wed, 17 Dec 2025 10:19:02 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Jianfeng Gao <jianfeng.gao@intel.com>, "Yi
 Lai" <yi1.lai@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD,
 ECC_ERROR_LOG} configurable
Message-ID: <aUL0FlWTViEJHOKi@agluck-desk3>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
 <20251124065457.3630949-3-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124065457.3630949-3-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 184960e9-1b56-4baa-f501-08de3d98c22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+fX9CI2JNIrrzmz+s+uiWs2uvJgIp8D5cFNQDDMdE6xzwOtgk8wXJ/6+xHV7?=
 =?us-ascii?Q?q8/VaaPPcU8+K70ln+/n3egU2QcYLVxcz/JbZ2a9kNhqkB4jQaM83wd476LH?=
 =?us-ascii?Q?LDzJRSGy4dcglywST2IWHZnL/eZQGo2HUe4D51LxrPCyq64KowwbzfaXtozI?=
 =?us-ascii?Q?hbwXr9U5Ou5JaCJbYVjDFwNQqvxE4TiSUQhd9Vp9QnjcIErNlrYIS47bT+Wl?=
 =?us-ascii?Q?YPyYnLAd6cZ5YlJQ9d68fR+x3rq0HyiThqqdDWG0DYAzPT/hA3swBc0vT/nZ?=
 =?us-ascii?Q?D6xRNjTJ5MCQJs+EWz9KCnmhHLqDHS1a9m3xO3wqxbQTV4WINN+z/rFlwGcn?=
 =?us-ascii?Q?4eEBt3UP0FLZZl3lTmeFTUIGMXTHpHOgqe6VV0UODj0/E4C+UgzULO7eJJvY?=
 =?us-ascii?Q?3RuHZw17ukZ16pj3BA2Ydn6olS+4TUZtycpb0HkWCKwKHukOLZKiHCDpFI6/?=
 =?us-ascii?Q?zD+RgxCVTrTqIuep1yno2qzzgfIUykAc2saEt9vLl9ubs5J7ZwvBPg17y+Zl?=
 =?us-ascii?Q?DI1+ZNNKxmXaNHSlxcxpBv66GvpVY0UPgKcx30JxLLhNO4rzR9H1KZW1yvyr?=
 =?us-ascii?Q?uE81kws8bb34d/CzN49cSttpqe7TY/fYDVDTfCp2dugClZlDR31SGttQHooZ?=
 =?us-ascii?Q?tngXrwp/w5WPGw7BV4qtKEpH+oftti0iAsQCUV2vSwwWc50A+ZLKv3fqAvxm?=
 =?us-ascii?Q?RVlJrlGHWYGKIwKq6WKOiJcmjh5HRFjIzYyEhisFQuHpEUmhtkQ5w3HIuOt6?=
 =?us-ascii?Q?5G4STOK9UCYWvdIDvSnhGLKvSn+yvD1hNEiaYNLMQvoa92TfjKUQO9PPaXe/?=
 =?us-ascii?Q?u5QIR1ynQAkXijNs92mgoRY5x0CcWZd1TDkiyABHVFtAfRpMB7qp6Xuo/nsi?=
 =?us-ascii?Q?YZGDZd0/1t+hi/YhrAzb4wIXAA4Q1M3zTQtl5c0HLbTr5IqKn946APrUDNnm?=
 =?us-ascii?Q?BQ7ofgZa8jiKPxzwnIi2t1S2Ctb3v4Hci3ZSUs7VptfTI2nbuIMb2y5gYvpP?=
 =?us-ascii?Q?8MOdZnIp8qv3H3ypxRnlh9Mg9XfMhmoOWr3xJr2vPWlzVlqyPKoC9nYWKv+o?=
 =?us-ascii?Q?q3lPk9HcFBPEBgUlvbxRJOisrvOSuXcwWXapPyY5j5rryab0Kaj6k5CiqLEl?=
 =?us-ascii?Q?66XlnZJHagyjVyJ5jlwBc2rTN5JeLxn0LIzsFgtxX9GmVtWo9hFvl6s9cbBd?=
 =?us-ascii?Q?YeviTzjKBs8GgLQ8Gh3TYXQJA1fgmrVy+0f0r7/Houqxv6bZz6p4xLWA6lho?=
 =?us-ascii?Q?N32B5v7T7IYhzYjdVvEW8r9sTJkRuc+2dZvoDvephbCvRia7QMAozJJu1zAu?=
 =?us-ascii?Q?n2hJ5hwSB7LZVBNI70srEMYXqkaDmxO/HuyD/cV6c1FSm3dgiWio+d0LdVWd?=
 =?us-ascii?Q?D2gsRGp1NB/gafRHjRm1GK2RrG7hfA/hnTV/jUxpYG0LTahfD8xqmTSiHbUt?=
 =?us-ascii?Q?0lqMO6i153o2Reh7/x/o5T+Zb1wINMDC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvMh4JTV2ftJ8GBEyFMyFYiRxN6E3nUgN6YyYje4wEWpaRo8NHz7Xfj3GRZw?=
 =?us-ascii?Q?X0velowaCsKMpuMJfc5Gmi5xdPWsNnO4jvJ5plWibnme0XumerJbwrejJPzm?=
 =?us-ascii?Q?avPknEmBfTfG1xB1HbFyo8q+AD+PkignSWEt6yXE//N4v48cabzEpE7Aa5nf?=
 =?us-ascii?Q?FS59pM4Qpt6oJi91RM4yYX0dX7T4f0bZTjFL5Rwk5gIC6x8Lb9raKcHYAjPY?=
 =?us-ascii?Q?kY23LjZGmbuigtlYmo6hzIvbXYoafi26z7ILxhZ9K8UxM5jS4BUtYvoW3pM/?=
 =?us-ascii?Q?rbn4QUdf1Bw1HgZXKSxmeHL5RngfFuBJb4TDXElCul3t9CPwj4uZ1tdZMT0l?=
 =?us-ascii?Q?a3hxD4iVU3akFVYoXKsAWShUi7Rrlb6wsbbIJCHyPRYZ60xtSuJYAAkdjL5f?=
 =?us-ascii?Q?EHc3fjkgFTkXJcDeLKbqTXd3joATyaJGetVSCKUXKyywylS4mEnbhJG1Vod+?=
 =?us-ascii?Q?BQ4RjNCxL8a++YQtEn3igZnUHA5V/o37Zuk8NL/80ehmRr81frrn9hlnfJfT?=
 =?us-ascii?Q?LHjnlNqnfSgYA5h+EAAGWKokwqmXshJVka2AKCz9s7kuEbxNqshHwEq8vQpJ?=
 =?us-ascii?Q?NqTQQRFZa4bkDbcmMKzoxO8m6nP8N6cvaqic62uewwa3aOV/LoMRrYbXGE1D?=
 =?us-ascii?Q?/9g/5b5Q4uqJdizEDctawloyvd0ZCzNLj2XlhuugYyzr5KmUDWi1QgbC5KjD?=
 =?us-ascii?Q?YrlrI/4aIgjKfTI+ek2C37KfSvUBz5kTfMy3s22yIHRDxhjksW4H+wXoLKOt?=
 =?us-ascii?Q?yFLcHsqRISIUyJ2PO2OfBUX3gHNfUxRvkf33LWzwGmHD3q+DREZP10gOur76?=
 =?us-ascii?Q?gOKTNpFE0Df+B9bjHcBTsE3w/+pRkmJh1IBm9Osp6V9AqAXu++zne6PEvn86?=
 =?us-ascii?Q?D1vWmhl9WT5gED1nafUNeqUvR4aDr4xm1fHRk5JYCro1PrUBZa7RzjwCoW+V?=
 =?us-ascii?Q?B0T0E+qD9ZPzgvvs0AOyS2HmNGe3FsFRKX6PnRmrvsW6xfUx5zdvg3AVyAou?=
 =?us-ascii?Q?ARsQecUSXXe+rKncMWBq2qSK4rZkEGza28F8Z8/LJv9Ecsm4pR1dCpzJ6vTC?=
 =?us-ascii?Q?ACWk9T8/KhgEMHjHvvC3vyS+HhG6abhLJBr/W3OyscNxwm+dqKj1ynav6HoW?=
 =?us-ascii?Q?XlQV8c0T9rfML5cjKTZwleaAwHUwtjrQXkjvs9ndKfY0Y838K5hxF26RoPs/?=
 =?us-ascii?Q?nF+zV83+DxUHTtX5/UgH98O3DV+5+TR7j5SzAtgKi25ko/SuFaUNDvZXbSg0?=
 =?us-ascii?Q?MagdnfFxoNxwsOtdaxcxMLjCn1w8036p3WSmlJpHPL7Ib8pWMlrCD9e483nh?=
 =?us-ascii?Q?sESAcvNG5POcZbZZ1/0uVp4xMSZY0r8wJnmII9kvi05NhWBpT0dr83lRN9ns?=
 =?us-ascii?Q?idi0tHnh63ugSUQJjg/5h68nLGTUCARNOZaqnBf+0s+FCW0pc2WK8tt281/c?=
 =?us-ascii?Q?6uoAcdoMBNp6MCNTOLzCoz3/N0uBhb7gIE/ikdNMb3Ed176GZwbdyFnL30cH?=
 =?us-ascii?Q?cd2F3pl7c4AoQugQtc15vVJBiFQqFhYZuhdtvnzBKQbiAh0K3NZuYvWLgwmS?=
 =?us-ascii?Q?57ZqcANZNeVU6vkgkO8HCD6AE+LairDQVHQ+19SC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 184960e9-1b56-4baa-f501-08de3d98c22e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:19:03.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7kkWeEcGbOOpptV7dq6ZWugdlPoyaWR9o5ikCYdN2Yjz3W/RcXOurATpxD9eYCCSrBaf09E5kEOjWoEva+Rsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com

On Mon, Nov 24, 2025 at 02:54:57PM +0800, Qiuxu Zhuo wrote:
> diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
> index 5d887a3115f0..db4aa9f581e3 100644
> --- a/drivers/edac/igen6_edac.c
> +++ b/drivers/edac/igen6_edac.c
...
> +/* Non-constant mask variant of FIELD_GET() */
> +#define field_get(mask, reg)  (((reg) & (mask)) >> (ffs(mask) - 1))

I applied to v6.19-rc1. But when building with make W=1 I get this warning:

drivers/edac/igen6_edac.c:125:9: warning: "field_get" redefined
  125 | #define field_get(mask, reg)  (((reg) & (mask)) >> (ffs(mask) - 1))
      |         ^~~~~~~~~
In file included from ./include/linux/fortify-string.h:5,
                 from ./include/linux/string.h:386,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:11,
                 from ./arch/x86/include/asm/paravirt.h:21,
                 from ./arch/x86/include/asm/cpuid/api.h:57,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/edac/igen6_edac.c:13:
./include/linux/bitfield.h:298:9: note: this is the location of the previous definition
  298 | #define field_get(mask, reg)                                            \

-Tony

