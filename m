Return-Path: <linux-edac+bounces-4046-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A30AC8CB7
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D676A4E1DD3
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B321D3D2;
	Fri, 30 May 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQGCe3/9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF261C84A5;
	Fri, 30 May 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603962; cv=fail; b=ox1S3Rp+jmegqDf3KcjULOF8M91yx4vpoV8T9+mWTQQzWAOGiQSBFNwZlTSOpkxoTvHmp8XGWPh0moixCHCTqMdhv/7zqnvETPdz6R5PTHt+J1W1QmwlFl5AEIhYZYNm8KMauyITb7fs9ixatq9sQK5IxpjqsI9ktepnVfbIx1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603962; c=relaxed/simple;
	bh=0tcMO+znGFcE4tz8iKE04iq6aqEXGy7fZVgkwPRuisk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kf+ZF4WDUJPeKkZumPPp9wFpZTFogCViZGxTdUze8qb/vujGAeOQpPCwJ/2Zc1yZ+nYrA1MxpWBqoNJBGJoxV4onf00OH7uJ3V7VL/ek+rJPYx7/wWIwgU9wca7yRTwgng/h2u4QJ1a7EK182OViKMda6703Y0INgbaYSlIDDJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQGCe3/9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748603962; x=1780139962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0tcMO+znGFcE4tz8iKE04iq6aqEXGy7fZVgkwPRuisk=;
  b=gQGCe3/9FJ6xlBFr/zg+aPC6aZ3iSOw31WkiCfSMuWA22OU+vOKmN71k
   QiEE5gGXKVeOoUZuoYqFA8NBZGOCG/ipyG/sbfwGsU91MJnNDRdH/tz0p
   ncshL+Yx3SBqT4NBCZGiroSN37K5itcCgKShimmsz1NITL/mbp1u3ug0y
   KWWKIsiEav10Tv8BeYM/p59o5ep5A9dAgs0WhJKD+skugEdP0NpamxxYb
   NA5fPkmB2+P13ZVr0LJBzhOLsMBGfYnoB/Zve/63S2oI3F77aGGO6U3Eg
   S/GDMHJiNRZ2sCZlTzVpAKm8YV+ySjlA0yU6lQECgETC4YqMX+YZ4evVn
   w==;
X-CSE-ConnectionGUID: cD+z24ApR8+FunBUBoFXEA==
X-CSE-MsgGUID: AfjcXcGzQIGy+iznYi6CbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50841672"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50841672"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:19:21 -0700
X-CSE-ConnectionGUID: jeFt/WYqQvqSwOwCN9LrWw==
X-CSE-MsgGUID: 3X5LE5ofThuaVs4ZHy0FpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143828552"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:19:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 04:19:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 04:19:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 04:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/Md4egD99LLs5kbfCGk/EJHh4JpIolcp2yABPNMRqfW4TqkQ98ObvIsRzYzz2Ph8fTBynIWuYe9c4Bdmw3ixUXti0rBckKuNje7DWAc/mpWt9xgeyJCXXC6hXiXBrS1HpVawEfzziVTdRh1xaCdHTcVZtuP3D519TBY6P5BkIA8jK77d/99ZO7/NnQQZvt0K0rOzDDZfWAGs5hrn77E9s4Mdz4lQxNVJFyONXzrlBcaqUcXE54ayTqC118ltW4DlOyqg3NQ6TDf4WlvmSSQUultDUnP2FnmBGKO592EyOh1+RY+YdSzWpJNlg/I8NZPcitIVaWATpcGBBKUlzwKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PusVhOeXD/w2iWMBv6IfVN+wOmxi9E3Bw9ukeCBGfFY=;
 b=ZNZNE0sh4ehCoKpmbk8EwJ4GTAiNxril0m0AxXrRLibvvW2Yqu5ffBdCTB2pTtYP+Sn7+cV0p4boZWr7Re6RSUjPaPkxjMQo1W1XAd7G/kFLYO/TqIyiocqCQM9cWMi28YMo5KOAKyp5MQGD9c8vuDxPNzXcsfcQCNTjy9ghtKAVx1U98SFfU9Au6LYNMqA2gHt/YAX3BvTp9FZwDq/pmr5dY20/tKm2kHPTMMvxH2MsbcMDhdaZZWVJKZZZn0wKJ7u/IL55srKxngClYB14JSv25NPhTq9F611ZV6m+EjlPo2b/GL925H70TcpD0r/eSg6HY7KNQjUXGIXD2lCitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 11:18:36 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 11:18:36 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: George Gaidarov <gdgaidarov+lkml@gmail.com>, "Luck, Tony"
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Jason Baron
	<jbaron@akamai.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, James Morse <james.morse@arm.com>,
	Robert Richter <rric@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/ie31200: Document which CPUs correspond to each
 Raptor Lake-S device ID
Thread-Topic: [PATCH 2/2] EDAC/ie31200: Document which CPUs correspond to each
 Raptor Lake-S device ID
Thread-Index: AQHb0LdHIshfc04yfE2boYRbPCfMyLPrBY9Q
Date: Fri, 30 May 2025 11:18:36 +0000
Message-ID: <CY8PR11MB7134D62871899D47A28615F78961A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
 <20250529162933.1228735-2-gdgaidarov+lkml@gmail.com>
In-Reply-To: <20250529162933.1228735-2-gdgaidarov+lkml@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH8PR11MB8064:EE_
x-ms-office365-filtering-correlation-id: c27a974e-d2c0-43fa-af8c-08dd9f6bb8b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hMajEBAyWPdQuLugXbVGdtriABGaY2yhwukBXwDEvV9TWXwbqaaHXqINojUg?=
 =?us-ascii?Q?+eQIAsE2DmNYpevUMjfmXFmSGbT4kP7nK1GNoJrHxHoi3eePu8Mu3udp4YDh?=
 =?us-ascii?Q?HAti18sLpL6z4j+drhdHzzJKuyvH0qn401HO9s2Zy+gW+x7VeA2Cko91zbV2?=
 =?us-ascii?Q?BfM2C0Upt8uM4oQOx89Ouqn2MoLTvCanvOdRE17arxtsis9bKiWcP/nTpwkt?=
 =?us-ascii?Q?qBYVIIaaOshGqxs3lj5ZAUh9umcCqC3W9h9p66ZG4ufL76mP/3lgKUSCb6HM?=
 =?us-ascii?Q?cG2xqoshPeI8ltAhYYBnLEgCBW7KbyJG++jYPVmOm1Z2aWB075IP51wWqiH/?=
 =?us-ascii?Q?gNwokdCoTzCO64pj+rfs63woW8WwNtbVw5M3rkNgjvrZ1ztW04/iptyGQ4lI?=
 =?us-ascii?Q?MhLWBwh9cDlIBl+1o0uFvNFNCIfbxEqHiTZZW+lNZvBPS54RzXsSI7ht6dar?=
 =?us-ascii?Q?uuc0TIw+9YxQOA61HKsrupKRTZJjQi6b1tGUmJFsgZdM7obox1wcIhrJdFT4?=
 =?us-ascii?Q?codjJXnYuBMJh8418LHJRN2FM98RfTY+McUZLPU0tokR+3cJyEE9EokJIxee?=
 =?us-ascii?Q?eE2xodZcPNuEw2Ffi1rKxXCgeou3zSeQh+ZCDOtPnoRUKrcUJluQKk6r8V8C?=
 =?us-ascii?Q?+pHUJjB18xexZMCbPCsDTVwHsVivk9sXzuCR4BDZ4fC4PedILgXfL037XL7B?=
 =?us-ascii?Q?FxdiNvGDJ+n8zpXzsmfZtndBnnRPddA79xsA7tDeOMA5wtM/5TwihYaKneUS?=
 =?us-ascii?Q?6tdC19t6t+byXHYa2Ty1thPxJdCwM8lys/rvh+1hF532RcPIw6sX9vd9dx8+?=
 =?us-ascii?Q?ksBMl7ZKF8GVtFkgX9lhUL0UIuQOA+zG1AoI4T2ojhJff9dSHZ+9/1JXp4BE?=
 =?us-ascii?Q?o21mbH6WmmkW/buHF1LhPEw2bGyxBCfWyQUWEWEf+q9MfCugXeWHJ5i1L91m?=
 =?us-ascii?Q?6v3t9xLYK8x01MhKCanrOhkJ9a3l/Whm6NW2c6naz3Vv5FhlwmGGCi90YhSZ?=
 =?us-ascii?Q?UhDrqF5+efjTUIHUu5RZ/QH6C3AEkcw1oweOuA3+LRbvRweboo2HbLGki0og?=
 =?us-ascii?Q?2QHH+os6MMa+/aZByeir0/sHX7cQdnblqIDWs3IXMAfwglbEjiDxEcuLdq+v?=
 =?us-ascii?Q?fy/y1RuuY255qengeHD7sqbfzFfV3nMUSGlWs3LP5Er7a0D+4EZx9JE2FukN?=
 =?us-ascii?Q?u0tz+SXJsS/3/wgWG+SioG8zP1EpK/XXqBTaEF9XHSDvVWlA677wJ0gggHTX?=
 =?us-ascii?Q?glOoCA+4QsYGkCD7UQfgR75XdvQtJPUjRSBGyo1LSvUTj7zGQ90gzdIgRe2c?=
 =?us-ascii?Q?8bBnvVc8Ttsv+1UqqUvrizFg7nHoSi7kByr/7UQP2b8WhZ0dXZEFi6SG755r?=
 =?us-ascii?Q?5110dgxQTX1uR3WR/nemFw++J6IBLIBvJrzp0Z1WKlsm4WSbVdmyUfpiWQMB?=
 =?us-ascii?Q?U57zm6PabWYGG1v82ylLktir2JWShS/+HZlePp89JIXYCm5ZVydxWK2fANpL?=
 =?us-ascii?Q?gs7t860mdoo1Nkw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9+E9TvadR75ZgnY0gDIMpz5B8/cB27bBh76zRSkvLes9j0LTiZLXJ2J+f7Lo?=
 =?us-ascii?Q?xfXtcFKPOdjxOjRMZMDUMlshHqfV620Hsbaz2qRzvPdk4KKc5p6ODzZH/X4C?=
 =?us-ascii?Q?jpiLigWJo3DM8AhvZfsMiJzMW3RB/YuR5nf1Ilk7z5gCBo8sSJiTKyehm6tF?=
 =?us-ascii?Q?JFD51Stu4WPfVOIzpMxpJNLaKOD8A2q/3b9RB3H01bpWi2tVZ9XSX7x2ZT5G?=
 =?us-ascii?Q?4CgbsemHQPMzXVYU822qPBmMor2y2FkunOrge7mmMNreQj4Cd7AzyySdZ6Ps?=
 =?us-ascii?Q?LUR9b2CTWV08TS5EUbHg+vJgsUpXkbZocAZw/SKMxcWAPbNmaeZs7eIuL5In?=
 =?us-ascii?Q?OUJ7GK0YQpp9W59Mm59xho4IC/Eb67u1DkR36gLWJqrhXphLEwMcDqn/aXvn?=
 =?us-ascii?Q?Zv9Ax1v9gx/iotg/zvDXrbuUt1xL9gZmREjlOzkmPvujHlfncjqbqioAmZLs?=
 =?us-ascii?Q?MhWZgmZQfUfE6NWfQxZ63WYt/f4pGu7/IxzLS8K8zI2ykZoGDcv34rGAPpOX?=
 =?us-ascii?Q?RSDMw3JYzHRo9looIGl6imuGiLpSINI3E+NDoDWWzIXcsppTe3sxUhrgTq9V?=
 =?us-ascii?Q?tKrV4JP4lyrmWGuNmY+YCMskYJlIek65ZOBMCGgiRn741thcD9iKn1mwnLlG?=
 =?us-ascii?Q?N/NUKsfM1eEfO8YFdxRgHoJSjQKtEOKwtKIy+Pj9Qg2KxzuZXl/yFWnGbSTe?=
 =?us-ascii?Q?ECei1FyfzCU6Vwpt8v9Yoaz3u4epc1gOfogoMdNphTMW4UGDmOe7qHA4H9jc?=
 =?us-ascii?Q?DJWkbAfVRZv+BqnaVmOotj54s2vW1RNNGLDJjwBEUHCvIZMg5cHKA/ogSTzv?=
 =?us-ascii?Q?+cBDmqEYsVLy/zJ5pU/o1kn1OvTOXNXy/NQOcSLLTu9zof09TUN2yUG4HNf8?=
 =?us-ascii?Q?UqVodGF8IsvU/Z2oQb1PWVpNx1FCzSHumNCycn7voJT4XVH3rr+9G21wXuPh?=
 =?us-ascii?Q?C2mI3wcwyyvmxDi+dFwKmy3QX7AkHeeFw66/s6UzZBinIRET4KNxkfdE0QyK?=
 =?us-ascii?Q?bL1Rf+BisET/tIWZPCDGGho+1dWzqZm89fFQZUDBk9R83pnplWcS1QFi2B2I?=
 =?us-ascii?Q?y+micqiJMkwMDcyAxxkAT4MBCg3FJjfLcov2PHsS0HXwnqP0UdNSeE6/vLGK?=
 =?us-ascii?Q?5gv6ZTtxhan3PgUd4sk5Qo2oogqvIqgqXsRldfLWGreM+rmKjgcLwhFtvRPu?=
 =?us-ascii?Q?HFfUnRVmKkSRQyKqWeFA+LMRrEL5NM4/6zrJYRYg/kMB2DWbcDGLkGhpNFDs?=
 =?us-ascii?Q?/G0lmtfqeXoRFxZbEh8GZHMh+z9jVAfVYj9baKWQb99oh7JhYRpFhi1wJqyn?=
 =?us-ascii?Q?F7uLlxNs660bAZZzHJPlxdlJhZC0NtyoeCnBtasvMSgr1lcGPK2fUy4Ts8c1?=
 =?us-ascii?Q?cPQsrEUwJq7tjB9pnQJzIA9eOlaVqR7iNahjaA0IfEM54Uzv5qbxsiv9wo9j?=
 =?us-ascii?Q?DzO0q2HcgiLpjy0FvoE5fOYIdV7NlrGc7Y+B5S1iQikeNgz6I4PgNI3MMX5S?=
 =?us-ascii?Q?0gdC0KKnXwG+4hTrJ0ALlIB5EV7LPfRPGCNjENoRcspl9GKgcqfdcy/OR9SV?=
 =?us-ascii?Q?NM2M00iFfrJ0RbxrCf+PGjeCg6pPvSJwYdsMcaAA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27a974e-d2c0-43fa-af8c-08dd9f6bb8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:18:36.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgIlQgSKXdbuTZa05d5PTCUwjfao7bPFDDQCszBSbBUZphie2A/dl2LPqKXBFEkcmIWdR7ZCYbtha7b/PfvJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

> From: George Gaidarov <gdgaidarov@gmail.com> On Behalf Of George
> Gaidarov
> Sent: Friday, May 30, 2025 12:30 AM
> To: Luck, Tony <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Jas=
on
> Baron <jbaron@akamai.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Zhuo, Qiuxu
> <qiuxu.zhuo@intel.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> James Morse <james.morse@arm.com>; Robert Richter <rric@kernel.org>;
> George Gaidarov <gdgaidarov+lkml@gmail.com>
> Subject: [PATCH 2/2] EDAC/ie31200: Document which CPUs correspond to
> each Raptor Lake-S device ID
>=20
> Based on table 103 ("Host Device ID (DID0)") in [1], document which CPUs
> correspond to each Raptor Lake-S device ID for better readability.
>=20
> [1] https://www.intel.com/content/www/us/en/content-details/743844/13th-
> generation-intel-core-intel-core-14th-generation-intel-core-processor-ser=
ies-
> 1-and-series-2-and-intel-xeon-e-2400-processor-datasheet-volume-1-of-
> 2.html
>=20
> Signed-off-by: George Gaidarov <gdgaidarov+lkml@gmail.com>

LGTM. Thanks.

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

