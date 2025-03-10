Return-Path: <linux-edac+bounces-3341-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77876A5A19A
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE9516EDC8
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213952309B0;
	Mon, 10 Mar 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPh+b/6x"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764762206BD;
	Mon, 10 Mar 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629899; cv=fail; b=SavuR8X2H9xabCmL2QrMiICybZ4nKOozS9wraxKMzJRr37GDEOQS//cHWaMnSQllMeYZbolvSE/wVq/p9K0dZDyZPyJ1MMq+wF6iTGTMx6k8e513DPjOJ19FKMZsxpP2gfnVucyEwr+sGtzB7pXO/3oIKi+v6PcBCcA/5RUSq78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629899; c=relaxed/simple;
	bh=DzWt5xjantqtz/GhbNKEs/PGy5Wu9DW4FJO3nfZ+C3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRWMu6ySpNE9GtnMh8ovHnjKsQtMeotArRTbnPZ0CD47e9XoWn30Gxpr5x2vjpmkO7rmNCJJr987xSLdIUVaicRsVuH704XMVUH3lMcwn0QvfSzbbc+2loYy0icVniygOSwaH/u7X0+A8LGUhdy/bJHbTZCzAzGquJSOiryLwyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPh+b/6x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741629898; x=1773165898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DzWt5xjantqtz/GhbNKEs/PGy5Wu9DW4FJO3nfZ+C3U=;
  b=NPh+b/6xLXCeTPrEgznrCULELWo1kn76k0Htf/hXsYIjxD+SKr/6cTgu
   4S1a1eJjPraVouWSkezPKjtIWY2ILJVV/bjoukmlJmuuFJ7ViGbmuVo0o
   ioaC29Q4LJO2UjurFsThqH0rXbuc5N8JXb96IiMXr17iWkDN9Osbuu9JM
   eLfm51k39TlLaiCWwy9HU0go+UOhzkoMBVQVPR+Xd3skz/wJVIuvvS7gK
   qDiBrk1PYaj1z8BxOcYQfINRdwcuCCZq/NSfVG01tDxyVVr+WLoESBd/f
   oTe7jOX82nUmtKMdsschr5rFrb2tHWDxF6cQyOQyjJhaqpXQWZZ1s/eUe
   A==;
X-CSE-ConnectionGUID: T4AXHi3KQtq0Bj/qGxaOjw==
X-CSE-MsgGUID: UVwCrr06Tu2fSOfUmPKvHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65095741"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="65095741"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:04:57 -0700
X-CSE-ConnectionGUID: RPngwpSSRSi+BPsDazsu/A==
X-CSE-MsgGUID: q9C/YGwzRUWN7B8wZ3B6CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124225408"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 11:04:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 11:04:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 11:04:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 11:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9V1owHsIhB8afL6pFJUMVqrwtBotqO1R5hw+C0b4mF38E26tB5hMAOgBq5JPBKSfj5USUHjfhs/TniajD0X8hbFvI06TbRIcD39tSB98FHCXdAGANmFKg7wX+hoYYdZi1QJTof9IM9/JdEBXL9656BcJra9kfp3noOuRrIHJe3dQWmIOWYdJf2MxJ9cC10uETbCLgIepUj2zwq349/r5zrO/iZA80OuqLDyFcuuafJlsUw6cMU/3V4oA0bPXcRnH/jtXYHWvXDaytYQ/D03D4IS2ZYNEBHEbqrTFNaHkh0TANv6s/h2J6qfvKuYgnY4S5d4uoz/1ncVVdFxIwmrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzWt5xjantqtz/GhbNKEs/PGy5Wu9DW4FJO3nfZ+C3U=;
 b=o+FPL6OjJJAKg1cYCSGK4pRUhRvBswGT+ZKDGPJSdEYq7IabH7K3kkKHNtDy8joviBXKvt4du1fP9P8AEQhVSMrf+h4SqhfcxFvHhQUkFKvUj/xNp8uH3iM/SUVHkJkuYOizRqOMNQGzpCG/k3EJLQNyxndUOUgWc01PsYfjz7E2jSBu4LSMYsL+RFPJkgyEWdrJwg2zRZ3d9DYlUretaCKGJsloH+3pDJAwtmAqOA6WJN14WsrGHEFLoc/92g6t7vFLawHCRj11I4m8kIV9E//pUgkAPNWpKhE9NdoAo9gj3mo617EvVceUVCNvGfd0WvhED+2X4KNd17fn2AcrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN6PR11MB8147.namprd11.prod.outlook.com (2603:10b6:208:46f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:04:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:04:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Wang, Gary C"
	<gary.c.wang@intel.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/11] Add EDAC support for Intel Raptor Lake-S SoCs
Thread-Topic: [PATCH v2 00/11] Add EDAC support for Intel Raptor Lake-S SoCs
Thread-Index: AQHbkVua20zfdRLTcEGcEvgHbhzs17NsqsDQ
Date: Mon, 10 Mar 2025 18:04:34 +0000
Message-ID: <SJ1PR11MB6083CC952179153AD7361808FCD62@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN6PR11MB8147:EE_
x-ms-office365-filtering-correlation-id: 2ced39ca-26b0-441e-e5ff-08dd5ffe03d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?geuRm5cvAIcKnI3V0RFC0PXYJdQuOKtrqTehd9Glw0793lVRU4LSICyrSlbU?=
 =?us-ascii?Q?5SE20FF8yKLRzs8tVfLXgidghURQPr7YGig+e/1+PeL7UUkk2mh9UIfkpOWp?=
 =?us-ascii?Q?iVgHxTiA8fJ3JcUGtksDTxFr0XPbzYQw6b9kouGyn9SauymYnzmM8UpP46vA?=
 =?us-ascii?Q?0iV6VYeehatNhX4y5OK7k8F+wai/NNXi/DiGOWHQFVgh2928/St5QGQfv/sn?=
 =?us-ascii?Q?yJDC511PJ61CQHs6UKbYAjfd2DOLdaI479+4iDDZ8k0Lx6LLU9upVpDwNfWy?=
 =?us-ascii?Q?O8Ts4T1omYUnoBy5bUCZr5n+qgCVuff06E+DZycTfZy8zjOXYWDVMFnDAbXW?=
 =?us-ascii?Q?mVbP8dKIfONyA495pvDpsIhJoaY8YUJ5/tagLVSclx00fc8HzvEqzL9uJI84?=
 =?us-ascii?Q?NNNYQBOUGTkK+9eUWoaQ4JtxdTZFhIN/pK35flxecT9RF0sLOW0NxIBdSfv/?=
 =?us-ascii?Q?DR6NuFQ8hKm16b/z3fsygsY6f4vV3T+kvVbUYtAADtbSHue2m4tSB+Dn1MWn?=
 =?us-ascii?Q?BzhBDVs5ul/aHih8cM2kHVIPMFVC7F4Cj3TsRMW5K5ABiyCfOewWSQPb1A2j?=
 =?us-ascii?Q?XE6swQMLd/TRfFMbJdgPXzyXTurIulfRR2rnf7wBmpOihYgG1GsZBHHExUYg?=
 =?us-ascii?Q?PD5yZuwzc2Q9JtKY9lWG/M9t8rpO7spOscR78gmvCubujslYKV50/8gmPdET?=
 =?us-ascii?Q?6ghpE0N1XyFyVlI1fyVEO6H/PbvMwZ3uSnqq5F1EtkzJYNJarXRs48cUxZgB?=
 =?us-ascii?Q?mhkPeR7MRJYyWzFf5ZInw+irdDjjxK6EC9g7t1DdgOY610r4XvOeAHoEXO+i?=
 =?us-ascii?Q?3qNu0opJnn9vSjsBOGKZj+0yDUcawuk4mQidyplumx7eu2NU4VKNhleeZixR?=
 =?us-ascii?Q?D277ZsshTNeDYx1dNqcs5peu5eJ/y9hyd+zKCqSahZitNVPSCNSNrAwI+hvK?=
 =?us-ascii?Q?WOan3UvETiqepD5q+v86BYb0/FOegxCgYcw4psFi2XrYsGTgTfGl2qCFJxOS?=
 =?us-ascii?Q?OP0EbWx0oSR79hHgwCO9oXwH+xO5w68wwNY+1A3TBcilzeGo5zvQ7pkKlBF4?=
 =?us-ascii?Q?KKMNzWKGCj/PsuqxXJh5l8QBMPv0KKkj2/woRfMpKaGW7eKsKJYo0hJYFDi0?=
 =?us-ascii?Q?mTVJfWQmLdvP8jFP9S7mgRzyyTB90MAdgCIwS4o80/0ZPiZoe81mBw16fJFR?=
 =?us-ascii?Q?QRvKhbSWkLW4mMzDTv/Rt/3Zkp28WtnpfNrzFPjcbHXjdy/hmFLRiNdux5HG?=
 =?us-ascii?Q?kNGkfZT9VdiIOeWvb70xokxr2ZS7NxNnec50d26ySV4SuYocAxG/zp1Xh8eE?=
 =?us-ascii?Q?GiyWtONcLVscnyeGP7d4UHzfVYN0AX4k/AAloqaxcYaobNLqpBJieAP/jWry?=
 =?us-ascii?Q?jBHSebKmjOe7snxLyqPGpA9mth/Fhza7EYP1E1/opw5uJArD0R1Jbm4JpCmv?=
 =?us-ascii?Q?JLM4uBtJKjwTE3T1HZXvr8OQbLCxsXaQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rz3xJZypjR6ka3GZoB41zMogIsZ4u9dhws4+jw7dBXoXTD0uGYu3dQoF/yTF?=
 =?us-ascii?Q?/oI3G5efVYVV1PxJjhmHZsbG3USgkF+HMgVIqzPWUWXnMT8dlabZSvdZO+WM?=
 =?us-ascii?Q?GVRzjdOZl9o6dYtXhQxbwJX81Rmgsdlo+zb9H9x6iqwnroWWooei2P3QZDqF?=
 =?us-ascii?Q?/Z8NVbvs0k9yhrhNgPIK0FgqYHn2IWXck7V1pvhtdpZ53Hgku6II046MUSq+?=
 =?us-ascii?Q?9+uetsEicdp/+w6PljDdcMxUNNlFa6CF51dgmhTdo24SLNychpUXLZriE6es?=
 =?us-ascii?Q?vfssjHssDaRdlhMmJaI16Xr9fqYrdnakZfoxI/wg3xcDNmyO0gSCQOO5qgic?=
 =?us-ascii?Q?bN3AZK/YM200UsItbjegSri90G03iX29w2ZCPkhKkHmmKZ1ZCdUmfcZrd2so?=
 =?us-ascii?Q?NRFNgmdV46cqUP9RWEWUXLDQn2ZBWWBDFwypQH1yILbJQlWsio8IEMhYdX4w?=
 =?us-ascii?Q?CS8acn1smZz33qFt3j7jYow1SljyZFE39WtucmSNMGBrvTexIpeOlkUwHmfD?=
 =?us-ascii?Q?wfS+bkbXiXdSRWt33xDtpvyT0G2xMpGMsx7mB3Go20f6xpW/8EE6YVfrHY2h?=
 =?us-ascii?Q?HgQG3ac2C4k8+vapHY5Rfrmdb+wG6q1bjA6qNvICkx4cxjWow7FYE2VZJ/FM?=
 =?us-ascii?Q?UPH3i8ITa+slGiKkFn6SmzB1+gun56Dnt9r9avCTMVbKMwzMGrFVqciZXwGN?=
 =?us-ascii?Q?i7BhNMp/oyv9ueL77rTii5KBgp9121dvkN+4IV9j4OZgMAswfHJV7pDcoYT0?=
 =?us-ascii?Q?ooF1qq5HB9zGD7LeqZ3HuRq1j5bUq3UN2p07cy3MKhIAQu4syc0ZrclzmGiu?=
 =?us-ascii?Q?PqT0qoqi9lz5yP296idjOa8XqLdfUeSidEN3Lsumu5GIpbXa+OttkOq2NNpl?=
 =?us-ascii?Q?QVrHr7YgzkyrE9D5ODj4/1tScOzHe1VNsclgZjxel5qNadsE0LP5ROgoN1UP?=
 =?us-ascii?Q?Azx6tL58C5GJSQwG58Ep62ZtLn6eLgOGTTS5EhhTUjVYJr3XkJc0yE0Sd9a4?=
 =?us-ascii?Q?dZwtywt3PRj1MZ8I6SsYiuDdXOT9eyMdd7lXcsmD/3Xo9nZfVrgbdHh6Yzo5?=
 =?us-ascii?Q?Ci2imbdNTYW4FYiEE25l7bYSu06jn2H3XNJHoytlg5v/WqZIEZ5dzxNODe8d?=
 =?us-ascii?Q?UeZkiyee0//p+dbiPTkdmBxYF7dYryD8TAh/Zzsqswkg8fTvTdAfUV8fLxwq?=
 =?us-ascii?Q?Ypy5gjr4tgpds90iFfNsafmBcHX4jWNyllRwsz16vqnfoQ7ledVPqTFIUpFf?=
 =?us-ascii?Q?fbLMjtgxFqBOkJRzsPLXqPPN0ipABKogj08BeTgyxvq5Mv7WkQBwd82JJ9y9?=
 =?us-ascii?Q?+ea3LBP2Hv6/BFJwfdXCiQ/sN5r8YE0axizh5XvTI1M3p/ftuUPlbQYCLojh?=
 =?us-ascii?Q?rMzPK5yOsTBlVTLZWWv3iBD2HCnw9G5lgCfrl+QM5XiJaeKqiXNDhg8bG31e?=
 =?us-ascii?Q?2kP+rWflyd1DT7jpnY5or6OwHejM9+6uHtejrCVoTpWlT1Mu0hFdcGNWFzha?=
 =?us-ascii?Q?Q28rvydrCeG682Pgi373zacnu11WWAzrOuFOzdD99DLFs7poc6phFsisouPj?=
 =?us-ascii?Q?uUvtGCT0MepZBgRVDy7HOfAWvU1S90udQoZWOn1Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ced39ca-26b0-441e-e5ff-08dd5ffe03d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 18:04:34.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MO+64Q5JpOm8nhbu0dxfuPlRXvBGW6ltfWPaCRONOEQMkY1IzTMonUoJ7gSAsdYbXR5KyfAQXpqhPed8f1pMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8147
X-OriginatorOrg: intel.com

> This series refactors the ie31200_edac driver to add EDAC support for Int=
el
> client SoCs with multiple memory controllers and out-of-band ECC capabili=
ty.
> The first SoC with multiple memory controllers to be added is Raptor Lake=
-S.

Applied to RAS tree branch edac-drivers (and merged into edac-for-next).

Thanks

-Tony

