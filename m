Return-Path: <linux-edac+bounces-5427-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C553C4A8F3
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 02:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20083B8CF4
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 01:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9888346FA3;
	Tue, 11 Nov 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLT7burD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB41D86FF;
	Tue, 11 Nov 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823727; cv=fail; b=WNi/0e9kQG+99N3nNfsrVQZiupuu2Dpz1oVWooFKs6muj2fo7OHi4+xghSHyVHtFoZxikQnZbzeCFh5+B7iqL2CZJ3v7ne0GAcVvcXOZHP216Ihn3gKV+vL2HUSjkfbIqQHr0lD+VdDLli40l01KPoFvWPxWJCLoQOT/zwU5TtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823727; c=relaxed/simple;
	bh=1ntJmUt8jx0ioSxBbsb2UmrX7TOVFHKaZgzzk0F96Z8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OsoF7HXsy2+XIe7LQbatF2YhEzYuEkhb98rGUpiGHbZ5oRzpf3U+3d2mTTEw08hMSHZQS9fidrnH//uynaA2v52vcVmmHUJLl5XuXGTn4jV95+/H70ZxZjTx63TAEahrA11LR0lNISWkC1ntLMIkVyzZuoetjrpMevhdTlJtTeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLT7burD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762823726; x=1794359726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1ntJmUt8jx0ioSxBbsb2UmrX7TOVFHKaZgzzk0F96Z8=;
  b=hLT7burD7TCjmK9KteMujkKMfv7RxvGSOctyoyQUM73kWZs00iIuqQrF
   4V5zvr0nFwkwvGKh2fQk9dmUYF9c6KtediIxvClie1mx3/5LFZOS7Biv9
   FZT0wvr7tGHxIvL8GPKT0595fG6YJBZzrLCcJ8Q1+ed37pVXkuVPFD4g4
   tQNoi7a2qq1+Ki+Rd8VJ9L0/eVtrbWnObgwk6iX2QsDgvpxkdhkAM37Co
   QsHEfzjdde8V9nFzs5tzN4N05HrkinnDf4VvqIAm5WWhLzVLqX7G8eR5/
   IDJbcgf+/Stfg9HM577XCfDZY/5SOUE4BU3Z4eU5ivUKHQzhe9UbSc80Y
   w==;
X-CSE-ConnectionGUID: wo1AT3tVQWu9vwnFXOYl9A==
X-CSE-MsgGUID: wS1cVuBXQmWlxa79sX5UuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75494071"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="75494071"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:15:25 -0800
X-CSE-ConnectionGUID: qQxdUFSkQNyPxJRZtw/NUw==
X-CSE-MsgGUID: 2Faskmc8TWOnwTQg5jz/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="188462283"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:15:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:15:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 17:15:24 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:15:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuQCoNkiYuFflxemwBTCjx1kuaHRkyDOfMan+eQXglqDoEzIgMCrhZ0rOlzQF6F0Hb/KQ7XYwbpHVP5YBsZA83/l+VEY+b8U+plnCSAlYu2SCCXXNnWBGkDvCFxDVBOsldVdR1Cc4LS4ymEHHcBVKj4YqOrHNXK5/33r8XCXS1pCiNTOO2KwmR4WFgYlYvpzlMCFv+RoEiBf92Xk11bLHYSjRu7l6pEh/xi/NrCzksuMPBaiVpGKZ4B7j5Nn6Ms/PRNIo8jRw5K6835PAR45dvozw7qqZiogKmxZLeSbmeGRwEcskD4sokH0aSXQyWCBWgqIGNbQnHRmlBbd15wwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD/OJd+CaY2Nu2PyxNxa9H/G4dvdPH3OzYmD2AyCaFk=;
 b=SJ5rWI7khYYT9wvY4koQanQ35UPusVIWQx2GBAEBfr8omoVOjb37G7y4ttNFoauBylpbagzApOMiPGYeGBpVTV922O7bsVN3qRPnG45FRKe2tJ0GdqCKm9j034Vfuc3zZkNMsOttRTwuGHVCKYUOf27fAr6SLVqumuZVuEUR9RVqlpK8qQ54+rhdFoWPH9/oXczPwW9YiZdepQiSdUmd2CAzeEXN6dL7n3T9VZB9PgzVFUoGuLFbpTgKgdtvegx+SZRGkbLzjTenHyZPJjgQFXOmcYLcCAftn8E7FMXACSK2C0OZDyr+CaLczWEC51RxQrymSI+4fwEcSp5TzdhsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:15:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 01:15:22 +0000
Date: Mon, 10 Nov 2025 17:15:20 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <jbaron@akamai.com>, <bp@alien8.de>, <qiuxu.zhuo@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v3] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Message-ID: <aRKOKF-UTpdmtxnq@agluck-desk3>
References: <20251106084735.35017-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106084735.35017-1-make24@iscas.ac.cn>
X-ClientProxiedBy: BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38)
 To SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 9775b613-835f-4c6b-6f9e-08de20bfc936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JH94jVBVzj9u+MGcljg3dMts+E1dtEIHqCNx4muQXCcXizWJhgCUzHxC3QcG?=
 =?us-ascii?Q?eTFnmAhVYiSORK5BtYU752yQ0g9OfQyoAhLNn6hkcY6LyvTPxpp3UMvtTwkl?=
 =?us-ascii?Q?QSEbXhra06GLBPUa6SJacMXRnXFUw/aqssy4WaNjWvu1DLwQ+wU1i+lRJQJM?=
 =?us-ascii?Q?0StDR6haobssE42s517AIaOzy0ImrCfPfxtBw1jwOJaY4pAOM2NkFbTMmWod?=
 =?us-ascii?Q?MhybFOzpGTPFFfdF7Rg5veRTDCgbtwMqQFadAVvYjdBYXRChUEM+t+l/Fq2b?=
 =?us-ascii?Q?L4uJ63kMKigDC1Bs416HN7XuYDcArpNrQWtl+Jnn0yuq4YD3Lxfi6YcP//pb?=
 =?us-ascii?Q?B+9xFaRgJ97AUDQ37ejV8VEdl8yX7dBB8KGq/i1apuzaCCGoHLYnOyDQFBn2?=
 =?us-ascii?Q?9pWv312tA5/lcHfa/2exw7vKA3staaGKl5ZlNHDhqN9uvYi/0yj1FBPTmWjl?=
 =?us-ascii?Q?beCCdy97U/NhfIzp10FZi5Rp/VJllBZoSuxFw9mVHluspUHdKZaqkAKaB+xe?=
 =?us-ascii?Q?R58282LGcps3Dt3WzsfKajgQSXRR19+RgTEf4Ycp1UX36Owp3BbJS3mGaGjv?=
 =?us-ascii?Q?T9f5HmiNb09Nu1TtKvfTBkikAlzybYOcXjuxzQlb8ywgkyU7ycLuRhwB3tYg?=
 =?us-ascii?Q?YmEiec33abpiN6qSdDClPqN6ldCEw5PUkWBxplVqFjQqMr8Hff9wFHpfj2P9?=
 =?us-ascii?Q?zjpwK1H3ESGkqDiUCddeEPr/BGqXbGa+xNvvM+PPxAda2UoM0O1rn3pbk9ST?=
 =?us-ascii?Q?u8kvXKxFVGCfT0BnLVa9FVhf4WlqwhcMZ2kP5i/VBeHMGbEXpCPQUWZJ9i67?=
 =?us-ascii?Q?OnCrglN3djybTKTR3Ua5CAkW9oJvwyVyVhNS6SkEPeS6LPyBaozMY7YdvPG8?=
 =?us-ascii?Q?SmgYjXvtD9hrbiCqFbZZFepXG2JVLhQUhnhtPhNyVR48nV3EzHQgl29oJxGS?=
 =?us-ascii?Q?cSEOkEZQJa2Z//0ncL6NjpxjCUQj2Dja2IGKHIfDF/viTXINAdafsRCEX1p4?=
 =?us-ascii?Q?MxQ3nqanJj6V/b2Z7WuPVOkeuByRspfUu+ahQQp9Pwb8+FZW3lnA0zALWbh0?=
 =?us-ascii?Q?P8WsuogiEzqptBAI6LTbfkmUyFjmnBY3rA2klWGtgxSsJYQx8xRfUk4vRor9?=
 =?us-ascii?Q?4JZk+4mSTGfK59drSLQbhKQ2a1MuhkLHLJuob3VHz7pMJ+oLEBhnhR86lvCO?=
 =?us-ascii?Q?mXeGiXDmVRtYhLkH2+p5GIuDJspvsEURr3T7F3//Ysw8b851yPcbGG6tCq8x?=
 =?us-ascii?Q?o1yWA5e9Ooe6pLrI54502NnvUBZF80YbQcgSYyk8D9HBV+JZLHXXDs184xOC?=
 =?us-ascii?Q?me/S4eY7zBd1H+TXw81OvqACj3lNL4fvkpY9wdhL5H7lbqBsEWlsvmSouHzV?=
 =?us-ascii?Q?sCWOTrKFCk9YDP683zckbRqmMbVrO9w5hNk/wTOihN3KnbGmh4HC6BrqEIUg?=
 =?us-ascii?Q?CV7GIja4LHsnTpbuGRXEWJa5uLQiGKEn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/Qd5yVWWeZRCr9HiHDloxUuJ1AKLfb0kW68IQnCw7dg5EzT3oe2fL5mET/4?=
 =?us-ascii?Q?PuZxt5cmt0w2dYTjqKPWYqZIsjRJGL0VjpWh4P+8VBCxtGrZ6gOiLN0Q36TH?=
 =?us-ascii?Q?uEmnEGSDj/uM2IFSs9hrRTY4ruuTjBZSbM16fpIr0Nkk+FcW41F5Q/VVt67F?=
 =?us-ascii?Q?ObBDNzzxE/9La/NfHfQPApvPTRCnLu0yRxtMwz+6vlKypk1NKwHIg/cHcGxO?=
 =?us-ascii?Q?0qoubQVqyTD4CZKXRD8nm1dLCY9vGGMDlh8357hPpUijsOzkQWEg6wlDmmGp?=
 =?us-ascii?Q?b/ErlaG08zYBC4MGScn0CCn5V1r16kmQ+ZsAdHxzb27a8wojRvlmjFc95xpI?=
 =?us-ascii?Q?9RFYnsYtkk9nsth3/1N62ozMMqrXCnKr9zuzdwgxCW6q/GYtZM4vnVZO8N/l?=
 =?us-ascii?Q?qgbP/T6flfeuQUjForWI5qKYb7dv6JJ46mfLp2etAaCI6KiLDyfCDpF2Lq6h?=
 =?us-ascii?Q?hxxAXRAixrxLM5yfY2e6Bq2yWOXa3l0Lr+klFRgGfFJXN+0ex5zf89grCeHp?=
 =?us-ascii?Q?HMkhO8JNePkL6tO1sOOdpptE5MGdhoOKLDgCW3Uo+ZTbOFt3aWJayylYf8a0?=
 =?us-ascii?Q?p2bTAhzY6T2h0+DqgKa5uXjfiSsVtRSd35wZ7HUOBkbXmJvWsLgpVvXHqiED?=
 =?us-ascii?Q?tpArwYDYDUDmho4/bGcQnydEpI90qBHGaXjhjX9L7RvADZe6KgfyYcS3Kh4p?=
 =?us-ascii?Q?kRNhJaoCMj9wIwSeH3MZww5MAtT0ToPJtnaiiSjQrqVyVUIJd9YGEl7cnxMb?=
 =?us-ascii?Q?GGgifUofbtI9Oh+DWNq6Jn+bc0Pnnu+ExrHrCbj1x17u1jnCspKDRza26Q+5?=
 =?us-ascii?Q?Uc7hhYQxnOLiSQYRHn/01hNfURp7qDAoOpFYOcLEDlWjg4SZJRfxvaEa4VlG?=
 =?us-ascii?Q?slWpem5y25zWIQSbL9srSg/3JusKCMp6vVlvIvxXtWF+RrXSEpuj9+pJMCXQ?=
 =?us-ascii?Q?37h1c9wQPCufi2WJemYdBvGDn9uzRTH+EQVOFFGv2eXS+XwKBU9S8U3skmuO?=
 =?us-ascii?Q?p874aG/IxvnI6esQESc+qKcD38P8xKvxD2wIN91IH+c2iIel+SKW6auSCCZJ?=
 =?us-ascii?Q?8U8N7JgsXB2XfQmQCw78JIyll73gKUcczuJhrQLwbBZcMtSlnpWd3ckLOC6k?=
 =?us-ascii?Q?YTRfbpEIOrYMJ1e02GsqovbFJ4TXQTXJzzJqT75MmRp6rj7BSAI2aW8fcbVB?=
 =?us-ascii?Q?Gbj3YZMz5b4G+sXEPGLJX9UjkLzGpZtmGtnNM6M24n9T5TIyVpEjiTHoAZJY?=
 =?us-ascii?Q?+SfltIbfwq18sCsiTSnJMZegFhI1FtFkUlLu3MjsASXDzMAPUVKUrNUOz3F6?=
 =?us-ascii?Q?gNcsuO+IqAxs14cUu5eE9jDK1vk791J+HSvV4Y4n9TSToF3dTP2t0n6Tciam?=
 =?us-ascii?Q?W2eZ+SG9uzQR6nj8VihncLsKWLK6A5uch29cAjNlTGpRzQE+Q+j8H/ryIODG?=
 =?us-ascii?Q?3Nd/A51qicAul20hrKkHRgX+HyZ7TBra+hio83+zsMVXle5QTte4Gb0NgNW2?=
 =?us-ascii?Q?PZjTT4Bm40R9PRiVovza/jvDwWAX5bjXNxhdcDMU/KctVF1NCNrcLANOMLis?=
 =?us-ascii?Q?IO1Vp+FQZELmvHNbAAHzptKTFqStxWrxGto6Q0RI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775b613-835f-4c6b-6f9e-08de20bfc936
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:15:22.1305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vytKEkm0qqPfqpanfek0n5PWtiln/PJMGcBHybNsYXny9lNVaZu4DSc1d4IPu2VPie3vMlWVW7KF3wpI3FdqXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
X-OriginatorOrg: intel.com

On Thu, Nov 06, 2025 at 04:47:35PM +0800, Ma Ke wrote:
> ie31200_register_mci() calls device_initialize() for priv->dev
> unconditionally. However, in the error path, put_device() is not
> called, leading to an imbalance. Similarly, in the unload path,
> put_device() is missing.
> 
> Although edac_mc_free() eventually frees the memory, it does not
> release the device initialized by device_initialize(). For code
> readability and proper pairing of device_initialize()/put_device(),
> add put_device() calls in both error and unload paths.
> 
> Found by code review.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Applied v3 version.

Thanks

-Tony

