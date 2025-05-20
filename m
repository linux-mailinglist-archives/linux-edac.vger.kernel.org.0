Return-Path: <linux-edac+bounces-3950-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38736ABCE34
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 06:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302D8189F02B
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 04:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473A256C60;
	Tue, 20 May 2025 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tvy5U9eU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4A1E5B6F;
	Tue, 20 May 2025 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747715513; cv=fail; b=ahbJQxr2gpkhYRqNl3HBY0fSCF+L6nwtaXrQgAMWNWEQo6/3yg0mY7TE7KmuUV64PW15tv0cLBjk/iQTT/F+bpSSLfyPQ2yG6BBjJZB9iX3z+iBvidDGvpTQMgRxnZ0/XwTEkaHVBA3JflAC6izf9GwhXyie1qCu5xgZ6TYIgHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747715513; c=relaxed/simple;
	bh=GeVigpjYldHB76HAsF6/aP0M2xBXJH7q7w3yIKiHz40=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fvFk8k+Iwej7fruCUcIspjNz7ZnkxkPXn+CYIoiGrBWxQx8j6yXDvPNDFQ61zsyVgRsVc9KdUi2hY3nxPvDy2AolwBo4PHSy8xkSjI6juzG9Jvg6eSCYfF0BXpZyQI7YfN6j+pHM3khXbb883hj0TiptLEsd1DTVv0bsmNU2HZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tvy5U9eU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747715511; x=1779251511;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GeVigpjYldHB76HAsF6/aP0M2xBXJH7q7w3yIKiHz40=;
  b=Tvy5U9eU0p52wEdppyMj/akV8948aKf5m5hwxOxscLoOO0dS91jBLnDH
   cSQcDz9qBnSHwpUettFqFaQkv4bkPgkmDgHt3IVegY7c79asCjxls1izU
   sr+3GQs66tpgQhqbRi6xQbeoUgaLzRQR96wPhKHj42QznRVmg4IfdPwcm
   tw1ff1w5XPQNBs9xGb7psu20AjOjhDrosRenDUXt0UR0pSE3ssQBPzYty
   SlpznbDteKVm0Z4fhZKNWX1kXKoDJWM5pFQ6R8KlVjP7v8/ausoEEec50
   mweufXrS5hhqfoWDDubXoSmlemo7tIVKxvuMxjrRiCEQs++bMpKa5Yq1U
   A==;
X-CSE-ConnectionGUID: CaGYxIsTTgSws2hP2ukkIQ==
X-CSE-MsgGUID: QN1RP6UwTfedjEtBpydGTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="67186058"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67186058"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:31:50 -0700
X-CSE-ConnectionGUID: +KCjyCo9RzScRpv6sRbpfw==
X-CSE-MsgGUID: ZbRMtX5fSrKylw637vjdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140098727"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:31:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 21:31:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 21:31:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 19 May 2025 21:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H79uzHCjCbaLQ9G9GwHUqSiCT52B9PYx+aD6EwkWjL70xjTdHQbxR0T07RhAOYCVVNqyxPLG8yehEYtcP2nv0i7sK8ZLDJ5e5D/vQ6UstsFSSgAiZnntnPjQTzZkWfm3If5KGQrNySlzipYbFlGttiv8lpOtzwPFJIYuIzGL/LXbbHMceXeMjWVTfpxQ7c5bg6V0YC5BeFPsvpOMzh+8CuirzzrOgrnM0h3oKJfpL8HZeMjtU5mUOk0GFDJRZgcumw5zo/V3mkGHv5WxCozhC4JUdLooQHDQFLtjGTPrxX1wzK0ICVi6U44D+n7k0STZHjoBUp7tmK+GBshS4f73IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhpUj28754dQ6iw8ISnvttKNhr5MUcPzaeS7UMASA2o=;
 b=Cw8XgIbUB6YUqfMPMfrbqv3eR5lDKjRqESqMRTjGIAmGHJ8ap4aRNrKZdSCzd+JA/af40Y5CW0cwovWl/PA3/+NQ5M9znfU7fELl/cGE3rxBlT9/hh0hh243gOxNPnkruM9RqzevW6/YnaHhAiH3Qycgrr1Nmc/MLe+33h7uR2CIH0yLEun5g4yiU8YtuwpCbVVHHQr3hnCg+RUMvLb5J2zD9dJ59hrz3TvS1LYs5z+PEkkokG2IviFxjewivHovAceudutt8jnUNW3PL32uLJIZN/8h+uhiCvgIC1zQkwQoWpp9zNjB/b4D4dkbqAcdSIQ0CYDLg+bEuG2J7kmH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA3PR11MB8074.namprd11.prod.outlook.com (2603:10b6:806:302::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 04:31:10 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 04:31:10 +0000
Date: Mon, 19 May 2025 21:31:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v5 6/8] cxl/edac: Support for finding memory operation
 attributes from the current boot
Message-ID: <aCwFhNeeX0YC41A3@aschofie-mobl2.lan>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-7-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515115927.772-7-shiju.jose@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA3PR11MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb03633-97ee-48b7-47e0-08dd97572524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AkxON4doOXkc3Ddxheeo+QDK9MgWsiE5nYDq8S2kAYa1QhKaj6cKf3K9eDky?=
 =?us-ascii?Q?mmK1SdWveGpMN60grSRc9u/PHaP/fB/ybKpmticZSb31+MzNiVD3ecz8F4kz?=
 =?us-ascii?Q?VYqTWGxEoIlNkv5vv9XrCHcW9xdaJsMoNz54qXeRC98G4t06w2/f0/IZ80IJ?=
 =?us-ascii?Q?yKtH1NCoVQSJ6g5Uifz+vMQgij5m61ZkeTmGfQoVzDfPFqdk3ls8YZdo6WaK?=
 =?us-ascii?Q?vrvMc4ra5xv8XbzrjtiH4hK6k3lMBWrLrf8ZVnfAT9+4XVyNzfztgQ2AcbDP?=
 =?us-ascii?Q?9jYhsUj3dJQRBzcqzh5jzKXmJ8rMztr2tGEy7O/ijt7yhfmzrlQ+U6yT+Jd7?=
 =?us-ascii?Q?SyBngBqt/cQ97Pg2xNa0H6Zvq4EL5RI7UVvIPMnQ4J6S2p7j+/Yn3Nnb4p1g?=
 =?us-ascii?Q?PX8ZQ01ROT+uyRDsB+Q3TZPr7hQOFKEOnSACpNJyXlCwW/VOrPawAxndBR61?=
 =?us-ascii?Q?YPPczIdyQwrRABhX/c4l8hhfr3sLVaPwQXYlyGTqKMVpEuLVrCBPbdYunD58?=
 =?us-ascii?Q?6OyDnleurzdVdZsL04o86l4+e0vdRl5pIQe+UwnRT0NIk4IvmolHuhcUudcg?=
 =?us-ascii?Q?sjgeWJMn47TNy3TAo8rocZbNQBrsypgLuxZAQVuQLwe9NHNe1JXbHzrCiuu0?=
 =?us-ascii?Q?E5UHyQPGHsl/W06dUKmne1eR/CUfAoQo+jVq29xvlkRhpBdP+u6Am08yDLbn?=
 =?us-ascii?Q?2Ta4eByw+7I0VJRhMSvCHefEI91nvu0gL2rV+Q/mV0i3cyYkYqA7bqQjzpky?=
 =?us-ascii?Q?NpkxTDQXgEwJTpCmp5ND3xQC+qV8o33bZhOO4taAjKuOFpZ2uVlZddF1Sx2b?=
 =?us-ascii?Q?w2hIefTp795Azr5Xd2o6At5UT1wckXRf2NLpgRiCJjEcjc2LfuwfYN9Y6sQZ?=
 =?us-ascii?Q?qRnil9OwHHn0ZUwrv/YlayZYIO9qyJbwAn/7FlYcnRmfS3geNyK4Vpk5Msdf?=
 =?us-ascii?Q?ApMpc64CMBelA2bhLRnh75LchwSQ6D+fmILFMP/gCeU8cmhUOr3aR4yHgwYN?=
 =?us-ascii?Q?vOj6QO3wVxYme937XrkMDE3O/osKPT9HYZh4AsCCqZZkRkzH7xxXzHDXOB1T?=
 =?us-ascii?Q?AtXv7anRREJVzwfbrbuuXy7NujCLr9SQQ5b33JgO4OalXfG2FCPeanuITE80?=
 =?us-ascii?Q?X/ELqrPpQN6jMsTDEGb3QAcOpSdD4MexjKiyaN4f3MMvO8gVW4Bv3REGNfO8?=
 =?us-ascii?Q?yzRHh2evJwqvDM4xjHqAU5tRP6Y/yuGqK8MB/mmtM7ncciCNjERGxSMIMrbx?=
 =?us-ascii?Q?NpjKV9ghrRC4AH9VOluS5EV95Ou5MAftganyzv1Ccc797L47k1ms9zls9rBy?=
 =?us-ascii?Q?n2OI2uzBpb8tKV0pfeptiHnLrYFoNedmjQG7lCzKJwZfj4LmWgFjTGGfzfJ2?=
 =?us-ascii?Q?j7l08i6CwznFhxnyPDFuTEPxngsEmHRcJBsb029WMuILkAinupSW/pWD0PZD?=
 =?us-ascii?Q?T3e7/FcZpfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBE1QJb8ynVGmm04HjI5fh0G9LnbK/lnuMgZ7EJ6/9sfnmaPchwDhUpc88/h?=
 =?us-ascii?Q?Qhe8z3DZmu8ZeVs30CNw6A50DMncrfPWIx2lywdqv92I3pGvFbkIiwUvtmgp?=
 =?us-ascii?Q?tZimkpiwyxheAkSAl9VJuMyJG+t3LHGuYR+N+cd+NiK5cnZpwxR5WI0pPXZF?=
 =?us-ascii?Q?kMcJGzbJR6kFN6jzul6JvlwnbI9LiLP2oku7Inm21tRNKS2gp/oCUg70BKgA?=
 =?us-ascii?Q?BYpL1J1gXeDrVkKy8Ps/8qYXoWzsANkfSbKWEYfswyHHWEwOfSIWzoqoz7oa?=
 =?us-ascii?Q?nerkP4y1N5axyGiAGqMqxEn+X6JNN/SBzflvvNAKAbyEiEHvnQac4E+6lZBH?=
 =?us-ascii?Q?h9ABQxACcS4SkzXXuLOstxa2uVn3o1lJm66C9ZL5uozvUa7Sbi+WmtavHYOm?=
 =?us-ascii?Q?CWLQ6w4dVArQ/jZCbwwKl7xyTParZGTht0AmrV+eU9n4lgIEITYyYxba+XmA?=
 =?us-ascii?Q?S0BgKWWQ1evupqGN+XiE+/AkcXNgNRgItVltc2ymfAbjOJQH82BWR2K5xV4R?=
 =?us-ascii?Q?tDuarhf8xE8ygxujEhRxJ3GaK8flsOZ11MiftlusZkbgsNytt2R2vpxuMKJZ?=
 =?us-ascii?Q?DQWWeD18y0PC3IGA8h2mWoxPj2xNvo2onhc3UvfFtUSUMqMbP0yyWcEuah+e?=
 =?us-ascii?Q?3B2zLA9EYUQcFwOU0G5bbBtFPG/6AvaFURC9t5AltCCSWKSktNOhrPZUyF5U?=
 =?us-ascii?Q?ti3+Y807KCy6GT+al1xeAg8wde1PUgnxiPorzC02Sl+TUFsceHv+rUsq9eAv?=
 =?us-ascii?Q?qlzt7iNmqe6tC7M3kPwPP1wggUyD7kikhHKMBMEJsaPq9GYvgq4AXYYhhtTE?=
 =?us-ascii?Q?n9xEPxGrdl79wvbDd2OqvphFwwObHrORcT9mQS4k90IaI+45JRtomC8Ye7KD?=
 =?us-ascii?Q?9gKtLdzJKI0iCpSs0rMsVwiKNOpyYsUwMsZznCKClRQCRY0yK3gWlcGlKk9K?=
 =?us-ascii?Q?XX+CyUTlC4tC1ka/xyHhsdj+dcfb9wlNm+giCrcwK+UErO/0dmFgJ+6KrZED?=
 =?us-ascii?Q?7ItClAgLEpH/NP0ZWTzXcyxpZffawv5kdM0fVfkXZcJg9obVY91nJVRAVROV?=
 =?us-ascii?Q?dEpjXU4Botg//ZqN4TtSDeGLfVSWi3fQgizQ0es7ocrD0eCShNNMRhC1+8y+?=
 =?us-ascii?Q?vFvaPUYuKm2I3sG3/vTxPCGu1LGMmWGUi2mdMk6AxX6FcQDdCgSB6PZaM6bJ?=
 =?us-ascii?Q?HrEMNUjbwShy4cMLnEww2V8MVG0uVMfUnVqn4lPkVDXhz1c8LnfdcRYzT6la?=
 =?us-ascii?Q?sOxup/BIVvjD0MqBaJ59OsO/PpPOhu/DRQbGxAjz1v3C6DLhzp78NGS9umru?=
 =?us-ascii?Q?+9hyU4fuBwBRGDUPzDD9pIVyDoGQnmWO6xINORPC1y4qAsJIUUsIKUiTbRhx?=
 =?us-ascii?Q?p7EHLzc1DEToWaS0Zk+jyuJwSpCzBtnnxq+5Muhgivr7qFvexl6Mt9EawHq3?=
 =?us-ascii?Q?XSNbwtP3f6YIWX8QOghfP1Ub4tFYGCbntrLP2mBbr+1Nk0jijJh7Wo+yZam6?=
 =?us-ascii?Q?QiBx325hNkeaXwqWonWHL/mTkCp386HXYggNItBgyhuV2cVoZ5g/O0zgtTb/?=
 =?us-ascii?Q?HdFJ+JsP0DHL6s2QIsRhP/aYm2qipjhYGGSHaMvnz4I92Thg1aJM9TF1XVaX?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb03633-97ee-48b7-47e0-08dd97572524
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:31:10.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFvYs6YolLFFQDY5haz2BpG31udIwonbX0KDsOU9kO7g5Ta2MPbAMVavuHxWjWrJifysgRA1/S8dge2dcrRoqC2Tz5S67DGhUEzq8CH5v+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8074
X-OriginatorOrg: intel.com

On Thu, May 15, 2025 at 12:59:22PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Certain operations on memory, such as memory repair, are permitted
> only when the address and other attributes for the operation are
> from the current boot. This is determined by checking whether the
> memory attributes for the operation match those in the CXL gen_media
> or CXL DRAM memory event records reported during the current boot.
> 
> The CXL event records must be backed up because they are cleared
> in the hardware after being processed by the kernel.
> 
> Support is added for storing CXL gen_media or CXL DRAM memory event
> records in xarrays. Old records are deleted when they expire or when
> there is an overflow and which depends on platform correctly report
> Event Record Timestamp field of CXL spec Table 8-55 Common Event
> Record Format.
> 
> Additionally, helper functions are implemented to find a matching
> record in the xarray storage based on the memory attributes and
> repair type.
> 
> Add validity check, when matching attributes for sparing, using
> the validity flag in the DRAM event record, to ensure that all
> required attributes for a requested repair operation are valid and
> set.

Using cxl-test I'm getting the below stack trace when trying to
modprobe -r cxl-test.

These cxl-test memdevs have num_ras_features == 0 so upon adding the memdevs
	edac_dev_register() returns -EINVAL,
as does
	devm_cxl_memdev_edac_register() 

Later on when I try to modprobe -r cxl-test, it seems odd that the
devm_cxl_memdev_edac_release() is being called for this device, but
it is, and that where the kfree() oops happens.  Are those register
and release functions intended to be paired/reciprocal ?

Here's the code segment (from this patch) where it is failing,
and the stack trace follows.

> +
> +void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
> +{
> +#ifdef CONFIG_CXL_EDAC_MEM_REPAIR
> +	struct cxl_mem_err_rec *array_rec = cxlmd->array_err_rec;
> +	struct cxl_event_gen_media *rec_gen_media;
> +	struct cxl_event_dram *rec_dram;
> +	unsigned long index;
> +
> +	if (!array_rec)
> +		return;
> +
> +	xa_for_each(&array_rec->rec_dram, index, rec_dram)
> +		kfree(rec_dram);

It fails above. That's as far as I've gotten. Hoping that you recognize
something with this case where num_ras_features == 0 that can lead to this.

Here's the stack trace, and I'll hop to the point in the diff below
where it's failing:


[  108.114491] cxl mem9: ALISON try_free_rec_dram
[  108.115654] Oops: general protection fault, probably for non-canonical address 0x1ad998badadad88: 0000 [#1] SMP NOPTI
[  108.118125] CPU: 0 UID: 0 PID: 1187 Comm: modprobe Tainted: G           O        6.15.0-rc4+ #1 PREEMPT(voluntary) 
[  108.120507] Tainted: [O]=OOT_MODULE
[  108.121202] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  108.122466] RIP: 0010:kfree+0x6e/0x300
[  108.123099] Code: 80 48 01 d8 0f 82 98 02 00 00 48 c7 c2 00 00 00 80 48 2b 15 94 70 61 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 72 70 61 01 <48> 8b 50 08 49 89 c5 f6 c2 01 0f 85 4c 01 00 00 0f 1f 44 00 00 41
[  108.126050] RSP: 0018:ffffc90002c03be0 EFLAGS: 00010203
[  108.126905] RAX: 01ad998badadad80 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000002
[  108.128035] RDX: 0000777f80000000 RSI: ffffffff82a44991 RDI: ffffffff82a5ac86
[  108.129194] RBP: ffffc90002c03c30 R08: 0000000000000000 R09: 0000000000000000
[  108.130346] R10: 0000000000000001 R11: ffff888276ffe000 R12: ffff8880075a5000
[  108.131414] R13: ffff88800680a578 R14: 0000000000000000 R15: 000000000000000b
[  108.132234] FS:  00007fce1dd38740(0000) GS:ffff8880fa52b000(0000) knlGS:0000000000000000
[  108.133256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  108.133952] CR2: 00007ffce474e6e8 CR3: 0000000143296006 CR4: 0000000000370ef0
[  108.134787] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  108.135560] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  108.136375] Call Trace:
[  108.136694]  <TASK>
[  108.136939]  devm_cxl_memdev_edac_release+0x6d/0x130 [cxl_core]
[  108.137611]  cxl_memdev_release+0x22/0x40 [cxl_core]
[  108.138268]  device_release+0x30/0x90
[  108.138720]  kobject_put+0x85/0x1c0
[  108.139111]  put_device+0xe/0x20
[  108.139478]  cxl_memdev_unregister+0x42/0x50 [cxl_core]
[  108.140092]  devm_action_release+0xd/0x20
[  108.140531]  devres_release_all+0xa5/0xe0
[  108.141059]  device_unbind_cleanup+0xd/0x70
[  108.141416]  device_release_driver_internal+0x1d3/0x220
[  108.141890]  device_release_driver+0xd/0x20
[  108.142236]  bus_remove_device+0xd7/0x140
[  108.142578]  device_del+0x15a/0x3a0
[  108.142932]  platform_device_del.part.0+0x13/0x80
[  108.143330]  platform_device_unregister+0x1b/0x40
[  108.143786]  cxl_test_exit+0x1a/0xd80 [cxl_test]
[  108.144171]  __x64_sys_delete_module+0x17d/0x260
[  108.144579]  ? debug_smp_processor_id+0x17/0x20
[  108.145004]  x64_sys_call+0x19bd/0x1f90
[  108.145321]  do_syscall_64+0x64/0x140
[  108.145628]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[  108.146284] RIP: 0033:0x7fce1d5128cb
[  108.146775] Code: 73 01 c3 48 8b 0d 55 55 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 55 0e 00 f7 d8 64 89 01 48
[  108.148672] RSP: 002b:00007ffce4752768 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  108.149490] RAX: ffffffffffffffda RBX: 0000556b12b5dd60 RCX: 00007fce1d5128cb
[  108.150284] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000556b12b5ddc8
[  108.151169] RBP: 0000556b12b5ddc8 R08: 1999999999999999 R09: 0000000000000000
[  108.151982] R10: 00007fce1d59dac0 R11: 0000000000000206 R12: 0000000000000001
[  108.152756] R13: 0000000000000000 R14: 00007ffce4754aa8 R15: 0000556b12b5def0
[  108.153523]  </TASK>
[  108.153925] Modules linked in: dax_pmem nd_pmem kmem nd_btt device_dax dax_cxl nd_e820 nfit cxl_mock_mem(O) cxl_test(O-) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cxl_mock(O) cxl_core(O) libnvdimm
[  108.155784] ---[ end trace 0000000000000000 ]---


