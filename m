Return-Path: <linux-edac+bounces-4005-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A99AC5C4E
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 23:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E633BC5E7
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DC21420A;
	Tue, 27 May 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJTl/yqJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938C1465A5
	for <linux-edac@vger.kernel.org>; Tue, 27 May 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381978; cv=fail; b=EXHgpHXaY5R+2xsFAYVBtXD4y70x+fcsUdAxOtVxdx49fvVWeZKC7D93oSaQNhTNhWx3POQ1CScO8ZG3u5W13jYE/jeTQpg14nuK/FCi3lpJxZGTD7ua0wSer3eNaTB3wgQgaFOhoOjXxbvFtWjrliR97Sp4IBMVC3PupdlkKzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381978; c=relaxed/simple;
	bh=pqf5Laah1QLKvxsKBS/f5XYl2gLwQwLKwLnrxJT64cI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edxzAmf9LSFAu6nqRN0BFcKDW9r3ULjy6l2kvSXnkO7m2imTMLfIa7OyqqzuqbDTdpqAUpTEJlV9BqxXgK00tLmUq804lgtTAbCzLjvoMFp4WfF08KPW77YuptebcTAzx7AnCp6QHy9gqtXDyMg2pGpLRB0MAm7D8dxfGRI1HOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJTl/yqJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748381976; x=1779917976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pqf5Laah1QLKvxsKBS/f5XYl2gLwQwLKwLnrxJT64cI=;
  b=gJTl/yqJC6rHRFX4lfFPFNKosf6kKjOWh3jyZ27CaUCo2wye8SBYx5b+
   gMMUk4vZy7OGIxWdG3S5xStNecQ04oikZxOcBehI9bkIy2xZKcHkbfElu
   DjZBs6Aacxn3Vo7xBsZDqB+LrFMNvan3Vne/mvB6hOQe9ApewFkwo5XU1
   w658bka8Sz4IWUALpxQ0hwMsBEc57kqXV85y2knmLLtJWEMVbCNOZL9Mf
   5x0mgE/euKEBpgn3pym5hpPqguWDCF98PYTG1wp6C0HA68wK5wBBa08fV
   vgtYg33EBogbS5SYesuQyFz/chNhciTMTq2j6ogny37cuvnAPgQrflRX2
   A==;
X-CSE-ConnectionGUID: wkhTg+wWT8S8isviL1N7kQ==
X-CSE-MsgGUID: XDzNIezbRRW13DKym/smoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50266437"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="50266437"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:39:35 -0700
X-CSE-ConnectionGUID: JPoJQn2bSQqXsXWAkTOlLQ==
X-CSE-MsgGUID: DbnHrE4rQ9u1NCbba2DtcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="143965776"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:39:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 14:39:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 14:39:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 14:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiBLm6PoiGZHYe+w8MeThS1n83D+gaaU+R8wUIWoYCimyxgyT+cJRng1UQsAvHGCJz6R08GD2t4pzEgkxmo9Rlk2Bv8PijrlxF3rUQ2OCQ/s3gQuC1TGZRm6s3L93nFRgtJ4IDbSAaC7v13BMVFdBUeZe9yMWTgneHfafHVJveD7sr5nLAL54FEhwYniGCTdfSlsgfpQSIdA7Oi5hEuAXmwW/fe55pbo3guJ3UhTBX/h8OJzfdNN65DiVX4sykGVax1RNiK0Ca5DrE2pRaW8Z1nP+5yd5Amtxf7gHSBExEJraE2eIY5FTX0VTl9tct1TmV6+RGPP6WRctyN+pV23fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ojNWqJ2jA026Snpk6VlBWW5GWIH9ry4vvFev9NzTk0=;
 b=UQwWJbkh2tgToArfvcDIaOG/RhD8R+Hv9FUx9jEGiSv859iwvW77EWmsEZ1FjNuAOSyuERwCjMdHOTzFM5tyg5Jd0hg1NkDvcZEkdq4/wHpo2qsVc8W2PqpFb6OEiIx9JTn+DI/c6Ou4/IH76+9Fo85pR0uH2Q36CgKapbnwDH3UdiMDi/x8sUulPtYXljPPO7ln+pecp8k3FBTMmTkEtatx+ZxfCt4ilXuC1WVuQm0gu8TCM+hTcPuAEJcuh0w2wwXpkH4cpck6pi1SxbdwsO5ZgoxzaCmNQZ95R16fhQXPGMeERpBnvYzOEZfXSPC+0Huw7VQosfB9eIuni2EKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 21:38:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 21:38:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH mce-test] random_offline: Fix 'syntax error' test failure
 on AArch64
Thread-Topic: [PATCH mce-test] random_offline: Fix 'syntax error' test failure
 on AArch64
Thread-Index: AQHbzwfWat+zAsHEnU+TLcHvkmJo1rPnAF9Q
Date: Tue, 27 May 2025 21:38:49 +0000
Message-ID: <SJ1PR11MB6083AEEFDFB56242726DB758FC64A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250527130228.315-1-rex.nie@jaguarmicro.com>
In-Reply-To: <20250527130228.315-1-rex.nie@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: ac859522-6fab-426d-7a69-08dd9d66de00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RM6wtL/jJMx0CgAQ/uLq3h3HtgrLmlFK3WFHc/PpcS5RGiSZPKQGyZ7FOFYD?=
 =?us-ascii?Q?JCfht31S5T8jaeug8Vrx7AiWF60Tyy3ioxNJkJ2dxCG5ZOPK31S/QUC4zG2B?=
 =?us-ascii?Q?T2A+PtGhsvgn4S66/GPHnf1NK0wMtrzObeege6DcqjD9WSo8j+yMB35OJqei?=
 =?us-ascii?Q?oxkWEtXpPVu5vpeLLoyFWOtcpXJEvs/ySt83B4yFYDJWBVzHmHuVCJvwaYED?=
 =?us-ascii?Q?cb3K9aKmnbTJgqOUZxtgdrd3rzDKcw3nqQ4k8v5zJnJ30snROHUWiiLeCkOi?=
 =?us-ascii?Q?3REJknXocRtt1GnyDsb9vKn3KzC7cyo/f2+70mlP5YcloxH2BFXHL/uQ1OVz?=
 =?us-ascii?Q?IysQihPLATCHfgvHAoBR+SOskWETfPc8KnHdWems5qs8qCYQWgcURgked1HM?=
 =?us-ascii?Q?Ud2Q96IcdH+x6QQ6NhQyg4mipmeYycSjHDb68Zay3r+lCn552HkkiYY00oC4?=
 =?us-ascii?Q?Mj6YrFGyYE0QJSGBxLKXidefyAZBHxiMdLF8OKXhrNZxp0w1e0O717l7cuO6?=
 =?us-ascii?Q?vjyMxI492Dbb5JDIenhcZADvQO9qfyEZIJBgc3Os9sUJ2ZYlqbythmoqJxiY?=
 =?us-ascii?Q?YVxY32fiC1gWMOuqZlLeGock6tILs5ZgYdkzbJTdG+K0EcFbxrke3faFOjlY?=
 =?us-ascii?Q?aUN9B9cXKeVw0gfTrV61bWN/seYnIUWlGx6kHCDgyIKC8aXVxEMfL0mUuYTI?=
 =?us-ascii?Q?qcGhH+F+BWkF0q7eiwRdyThQrmkXNV7AM9LPAmvMNs79g/iabqJDCU75ud6g?=
 =?us-ascii?Q?S8KU0wzfuAtff9q2eHr5ZUId1cCk8tSiwiemS+gnrByEaLrOROEohhjVLMQH?=
 =?us-ascii?Q?48NdNsl5xY02TepV1bYcrTIfglP9ywcWE2IuH5safXctUOWxP5vSbmWuBfCw?=
 =?us-ascii?Q?0qlaVCHExJuwK//ROyTU8JvMGKmye7naOvUD55ee1/Vq+im1AE1kWJMMGvw4?=
 =?us-ascii?Q?3tKAny+HIbVNYNZanrbOYrrnVhFNzfn0tDQdCvYgLkSFNR4WQknluWbDnk6u?=
 =?us-ascii?Q?anIL5tQyav3M9uZ280OrnPRblC7NYpdkkf9MnKVZND9mtzJY8F/oveR2K4IJ?=
 =?us-ascii?Q?/lq7/lmaMbcE3zoDLkVI97kfW8/ulzYUqsTvaghUjMHCmHsElcGISp7FiFuo?=
 =?us-ascii?Q?iVYGSlqpzYQjXnuwU5mUMRf9/4rc7RUK8sxfuDrPG9Q1NgisxHZkCLKl7Vdb?=
 =?us-ascii?Q?SLBvbwVfVna52NAGSoSTPNgkqIWHyj84V8A+y4D/HQefoRx7/b4Mf+glMOka?=
 =?us-ascii?Q?+9hx93ft/QDQId6JoiytOUkAp4PWNhMAAyRSsYlQAB2EDd339wMHTMZ2+Mbp?=
 =?us-ascii?Q?72vi00+oNgt50isa/m3ezRtKDUGJkeHDIGwrIPTZedN19kStVyv+9DYlbp55?=
 =?us-ascii?Q?Lxr4cVXC9G/mNgJDtCIfnjy+PrCHj2bqo1oxAlbsHxsSkecP2oS2lDL+t+Ch?=
 =?us-ascii?Q?fopJ05buiuJgBYYxQwodeyEZ9gGuzG7HzAPOkxlMRNV39zbdiwV95Rfw1kZk?=
 =?us-ascii?Q?Hw8b4KCddnKQtPg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9TlNLyB2JmG1uBi+ZFoVzd4y4RtK6sV4aoXGDakHyoTyu1fUFSgo/ZemA7t/?=
 =?us-ascii?Q?UPtnvnc+qKDAPEVgsHp86++j8XEcjPKDd2BjO2o2AjmJ7eP1E4yycElaAUbu?=
 =?us-ascii?Q?O3qXWTf0BzufjguRergPFpdPNHEziMzMbWhG81pu3Cpn6j4R4J+TRYoqrdAa?=
 =?us-ascii?Q?0COerWj+YFkPdTX/BjsBXGPa6x5TVJ06W337B6qcrBpMfgigNIfByWif/UoQ?=
 =?us-ascii?Q?g2UTPJK9MoTGAl9CULFhQfygyp4Uqe36LiPJeIPrLrELS2PqIL0aT46gsvPV?=
 =?us-ascii?Q?G7cltkfAyWDMV1l48t7w1c00S26CHs2rIiSpaNjEkBATHYWbJwH8Rcyn7QKp?=
 =?us-ascii?Q?dMzZF7gkB0F2hLpUDvCLROHb5RshrZNL7iWpis6jSH/yuJhEZsrVA2DGbrVL?=
 =?us-ascii?Q?vg4plt1tgb1n6Kt2CXIKSbI7bsq708Joy/uHWgUj41R6roDm8K+kFitrJSsh?=
 =?us-ascii?Q?Xods+o+kaNx3ob79fqZK4fzWIE3hhuLosQJ7O9UfzpWGKa4DdnoTjk5gFM2F?=
 =?us-ascii?Q?OMwwW9Q7pUTYAgvqrcBQejIlpr0+knmKnMddtr8OBkimL67VRpO014a0VZjl?=
 =?us-ascii?Q?Qn+15FwhkTHkHu3WccXRiuxSkhm1E2P8OlswOEG9KE6ZMmfqRLJcLBbzC7Ka?=
 =?us-ascii?Q?PEiJuT04jjtgZp59JwrC4c9zKuS3xfFPmjQnWVE3oO4Zdq1qKIKB3PKbYqVl?=
 =?us-ascii?Q?fEn+L61EdzungRLvRBGGERRUaE/44r2QEQ5xWTtjFSOaiGmpd4JqADrVrhJG?=
 =?us-ascii?Q?mJ4671gxDwQ1kUHw7ooToIzpaLGAJlyI1h4F8a6c/sqLiskYsgtaW63V1e2Z?=
 =?us-ascii?Q?zz145TV9IA8LeSFILHwW1E7uv9K1JZqIIBv0LlNnO3Sx4hKM1xqKOpOnQ2++?=
 =?us-ascii?Q?l+pZw2zDCR+gCBGE7tikKCNoIJc8c328xKOzm9OXZP4N8BvCvbKkclo6LLRs?=
 =?us-ascii?Q?eyC3KsnXCgeQtqHeJYY3u2BGWxOfRtnOkYoztVl24bDxyP6vEtoXTXztUBG0?=
 =?us-ascii?Q?UcDpEqPaiQfEkPVLCTU/cxhPRjLWNCVLEX0zcueUe1hLD6+RPAVOLvZWrxCR?=
 =?us-ascii?Q?+mUtodOw5uYRiNX7CSEqD6yCuLrKeCcMxeu9g2GPQAN9wOjetk8FwHRkut+G?=
 =?us-ascii?Q?2N35dRDZd3xJsBvoU4e9qoc9C0+7t4meNmWh/Zsn4WL9NW+ojvlIpu8Ksjdd?=
 =?us-ascii?Q?VUMQ592VDHyLXz1HnTCxPKfLSTfZRe9WZ4+PnZVYYu8g98dUIbHn6BMYP/2+?=
 =?us-ascii?Q?AaieZM7Uncpgpw09Wl1WHKCtjjJoj0k1pIC69SPV7+c9WCUm+vni3e/kODQM?=
 =?us-ascii?Q?Xp1aCGmwtguKBPSjKWfMxLnXuTbT/tzEmb7BEEsHODqIeCO5Z2hVpPEDP6si?=
 =?us-ascii?Q?IsCCaZoofxZRVh7hIBsqGnRBBQhD9sajsC5papwrhQ53TvH+HIenqhqg4xYe?=
 =?us-ascii?Q?tVrxT8jOf26fZhedZuRqYGSfeGFOSJ1XEs1WJ8l7tlUMusUAW/nXFatrDWQD?=
 =?us-ascii?Q?fR/VUUDpvAN95nWsIlfaHCB/q7QDpTsjCQ/1JKbkSSSK/6mr8IKCe6HdpNdJ?=
 =?us-ascii?Q?fbxD7WugDf6h8C/ScgT1CGFUUffQVeHf1h0LkkTM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac859522-6fab-426d-7a69-08dd9d66de00
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 21:38:49.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+kVxlzgKdDWCIBRsrL8ril5vX+ACX5Y1C/W4A3+UKrvZNs9hbPTlVKd2OsbWoAJTCEalk8MN7xsXrD7yVK7mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com

> E=3D$(end_of_memory)
>
> +# There is no /sys/firmware/memmap/ for arm platform, so E will be empty
> +# If E is empty, try to get end of memory from /proc/iomem
> +if [ -z "$E" ] && [ -f "/proc/iomem" ]; then
> +     k=3D$(grep "System RAM" /proc/iomem | tail -n1 | awk -F '[- ]' '{pr=
int $2}')
> +
> +     k=3D${k/0x/}
> +     k=3D$(echo $k | tr a-z A-Z)
> +     E=3D$(echo "ibase=3D16; $k/1000" | bc)
> +fi
> +
>  echo "soft offlining pages upto $E"

I think this would look cleaner if the fix was in the "end_of_memory" funct=
ion.

Something like:

end_of_memory()
{
	if [ -d /sys/firmware/memmap/ ]
	then
		... existing code
	else
		# Fall back to /proc/iomem

		... your code here
	fi
}

-Tony

