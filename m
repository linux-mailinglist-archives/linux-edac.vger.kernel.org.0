Return-Path: <linux-edac+bounces-2940-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F41A193C0
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB6E16B909
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C56214220;
	Wed, 22 Jan 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NS4a7gI7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1A213E7B;
	Wed, 22 Jan 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555547; cv=fail; b=Ca+oN94v9k1x5VvjVjYhOa+21tAQWaCc8jdklq5UWIPMRQnN/D9iPvDvpWtZLIo6D7f+d7AHoYs4gZZEEYo3RI49F3sZHtUp7AWzfavArW3+yiiAW67CZp9ueIzlEdTD/QCTY2sa2+iiH8jPRS9Uix/1fmVW3xQ1d8+w04+tigc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555547; c=relaxed/simple;
	bh=HyrhQ/LSrEQg2eUjJ1xBIDLd4hO3Xi67LrN5lnZYQpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIL75tbfwnnqvR+3pix0AQBVPyWkcAwgyqhFawEvwUTPyLFKW6+6eiyZO3LRyhIjZSHuGXndF271ptyC9ZY3h7xRb7Y457eLtlSASDOFMuKGL7Zr4ISYHE+TM57sd7iiXc4JvbyXOD7SbLBlvtj4uqLek5qFg39vyNFcv8n2OOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NS4a7gI7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737555546; x=1769091546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HyrhQ/LSrEQg2eUjJ1xBIDLd4hO3Xi67LrN5lnZYQpQ=;
  b=NS4a7gI7Bj3gbpNw+Fqj1ulGYCiqdG4qYdk6U+Es+Nm410BzUpATLtwu
   bjumlR1eqhINZCP1DxWOb8nyXdzNLRZ3tD3lk8Gvk305KR/82R58u9gUH
   wAzHjxPtnk9w05Az2nDSO+zITaimhDUnEFQnFSBV5IFMx1tWc9LbvQ2D0
   FooaYgmAsTbeBO76r3+NSzqbM4VbnZVrwvJ33yPTl55ZRX3W4aV/PQYNN
   RU8Kp57zIhiW9IYnw/lnkECYKPGBnfr5F7gu9BIjlnOFh2sfXbeS9FHZl
   HLlkghJUy++LW5U+golsZYmLX8SoWxWYCK4dyfO/oYf/4M32QpyQDxuAs
   w==;
X-CSE-ConnectionGUID: PhZXfMzQRn6mkU1GEEEGHQ==
X-CSE-MsgGUID: dEcCmucGRMaAMZLXljr1tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="63365608"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="63365608"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 06:19:05 -0800
X-CSE-ConnectionGUID: CsnUGEOuRnC2l46nXrXvuA==
X-CSE-MsgGUID: sqzLmBsTTqGl6xxAdapcug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107025822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 06:19:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 06:19:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 06:19:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 06:19:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSRBJVVj0Z5RR6Ag9PkHVrfwD/WpSGBllKpwAjHaJZCRPNUiXIYg5uXgxtUallJBnV8GVGAXtbRSkt4aWFllbpkQQ8D8adfb54qlrXE3P3nL354qD46Tj9KUa7G1YtAi1RJ13XWHqnxYeW/cS8wzLHgFkvp/W4YPA/D+2H1fOj0c2JmxHTG3XQX2i0zXc/rMPh6Y98txmsg4ptyHElRgdeMooIR7Kk6zBBrCnev4Xq23wt1tfSrvnOm4chFpv4LkwA+m5NacT1LuT7GBXpZ6AeQCe12nZKS3lvUM98OgnPLT7zyqhK0bIygn02Le3Fg4jOUBi9uHwMHqLFxtlu3vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jboTZSe9Gn49qB5jGeZHHH393b3GsNypmUW9VCHitz4=;
 b=KMGgLctoy2/cqJkF2A/pLme+0T7HDasClQ8YXfYTdAUJxB4YEyCScPf1+TNjyLkaoODx2/9nbi0vMa/W5/38x/hZobTVV4PTq8noBmNwrVnJAJ7JQI7BCHK5/FdqGpms722+P2IbiSUGkeVjv4+1KnjOF5UWWUBJ1bMgJAdpvifNYc6S569wdm9dbOmBuXs/T1vs8LAjPMM9moRt2Ev2lQvqansgHtFUD9MzS3tHWWb+2aLZS4K/GomoOuzeM3pWx706tJGG+LpocWdU2VG7l4G5tgApnOKdYDSMV8uKF90AQYJsesmdFiFJ3YEmJS4Xbo+zZ4ERaXgu5/1jLNaZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 14:18:35 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 14:18:33 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Jason Baron <jbaron@akamai.com>, Borislav
 Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	James Ye <jye836@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/ie31200: work around false positive build warning
Thread-Topic: [PATCH] EDAC/ie31200: work around false positive build warning
Thread-Index: AQHbbJoI+Yh3Y6BtAEWvGoAMTLrpmbMi1JOw
Date: Wed, 22 Jan 2025 14:18:33 +0000
Message-ID: <CY8PR11MB7134E3B1BE3DC6448EEF36A289E12@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250122065031.1321015-1-arnd@kernel.org>
In-Reply-To: <20250122065031.1321015-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5177:EE_
x-ms-office365-filtering-correlation-id: bb734023-bdf6-4f05-6d29-08dd3aefa754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?riy7/ifuJRiAStmEDFz6A0qjPpUxnGKQQQTsqkzGGvpZmEZYdxEb09satR?=
 =?iso-8859-1?Q?5X37VlBfpa2xDqGJT46ORI7ND6/SRq+FsTLmjOh58RsPYWlfIMyYzyvAWi?=
 =?iso-8859-1?Q?Wohm47SFuGrDX2FkjGiH79vdrd6cR9hEJkGJTPekXqFS2LEP8/sM2+9fa7?=
 =?iso-8859-1?Q?o7HIZ+Gy8/Ed6lY55XDw+hd77kSulL5DE1azJk/70uEVsDanoCIrFi056a?=
 =?iso-8859-1?Q?K6q67s1KPpOq6pmG2+aCtumWRYzZXsB5TqNzLAqJQ3MhLdgjNDOAjbJd5K?=
 =?iso-8859-1?Q?F6Ty+Vodfk+NtxpsoglloBS6STTzdCfJYcM5UjwRJCI8cCSGcf87EaookK?=
 =?iso-8859-1?Q?u8x4yYnWtU/aNhmE5sI8weDGtWH8B/85Rnck/KYJftfZ7TLrcMQFnCm/x2?=
 =?iso-8859-1?Q?ki3LrS7WzA+GICbwmYjutwl29pZ5b6h55zKqfnXTK6OUSNq8iEdruO0+Kh?=
 =?iso-8859-1?Q?BbhEdRgNImcNqClVl9kDX1uP97ufaW9bE978xsSnZJQUc80YPiVCKE1VGN?=
 =?iso-8859-1?Q?gcLgZ4AliSjwJAimalMzA0gjnATvL/5HA/iJL4U1w9OAnTY+RnpyNnHOpS?=
 =?iso-8859-1?Q?Z6vh1IvcTe+MTwicG8iWNsPfYY2Cvzso5zCbOOSzQY7ysFn14afQbE9t0N?=
 =?iso-8859-1?Q?wkvOKCiAVjAGQXPwOvLmmsokpf5mQNwZ6lt8CRiMzRjFNnOoIztRuW41Bt?=
 =?iso-8859-1?Q?AETt+ADI4SwzpbHPn6IIgNV/APuNVTCi0lipycMvIxpxqOkwaW2645oUXZ?=
 =?iso-8859-1?Q?bgikpafudjHynU3rBYmnW60O0UM3YxQeZe93cgFFBaodWFQbG0PKPhV+ee?=
 =?iso-8859-1?Q?ERs8s4bEjjDHs7wJSysuYrIhUpUuCTMPTG+vn226oUaa4Rhcpax5V28WB/?=
 =?iso-8859-1?Q?vfchQpV0/dVrM7/eCSwDmFWVbCpWBKXuyFv1V4kMk2fJYli0TKELTAz69n?=
 =?iso-8859-1?Q?KfaKL94oV3scvN4ybKrk/Dm7hkspH6KrL/PJi5H7ZvijrQbcC4tdBw2HLY?=
 =?iso-8859-1?Q?u6ai9HY8JWEDgwx6jwy4qG2i0FU1IYLvFe/Ojcvak7uHQp4y9u8icm3AAU?=
 =?iso-8859-1?Q?QnUnT+/NeiPQLpeDnszXMtbPHQitK1awcLyUtlZaj42ru8bZRHh94bQwQq?=
 =?iso-8859-1?Q?3+VpiHJOF5IS4Ar9upWt4OxnXfCTjhQYMlAgceYgfeq2WmMwocAPKTlRej?=
 =?iso-8859-1?Q?X8Yy6S56kLGh51alXqbKXFHSiquWM9UfOCN5frj6uaMvIK0Eg1X6pDB62F?=
 =?iso-8859-1?Q?AfUkgsNEs/UDp5j+D1xOUDbJA3iWxamxMX1ucdE+mJhmAZ9twhHBjU6O4n?=
 =?iso-8859-1?Q?tP0skjYHqblxx24ZqqmHeYJcfMtdfiO2uGTaJjdS5ZktNBPt4yrNyasLzP?=
 =?iso-8859-1?Q?DJv6TMaaN8gBIRE6nU1drZEa92TGcen+OGnd+xpSWMSpEnXA4qptB6sdxj?=
 =?iso-8859-1?Q?4bNbTg26HFFfS6guyiJs6THUmra6Zl53PDgp/oH00DE4/oFBbhKX/pPMgv?=
 =?iso-8859-1?Q?IpvJoZF9WMS1l2o4DRbATW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sZVH7ewwHdfh7Msaty1+Qxv5wyQzPQfOb0SiAtDEfSC2mPa7KKQqjz8Ag+?=
 =?iso-8859-1?Q?2Lr6fPRUQQ4sijw7KUJW3xRD8XU27lynIP9U/pLpSbru94Y/6rxgXRCW2v?=
 =?iso-8859-1?Q?EsZ6tVSpYZpxhYE8VHR4jNWx8E44thPolfsmCJ4ErPkyT3UCHmyry7b2X9?=
 =?iso-8859-1?Q?TmhcBEpYjt07is8CUZkW0A30S+MeTWiwdQIR39xlkuigQH2Pm3xx2jQ/8a?=
 =?iso-8859-1?Q?lqqJJnkYazF79ybzB3K+5mzJFKa7eUZBKZ5Wovrn0cjFXGDWE57BYKm55X?=
 =?iso-8859-1?Q?QTbvHmfV4+oXUm1tDeQsbF8vF63KxwpekIDUBCS8t3XEMIY/z9foNSm7UR?=
 =?iso-8859-1?Q?poKPAXtubxqNlm1uVDwxyuLJSt+Uw1VgUUBnLXdO+Ijsmeb8qGHqlKF7n9?=
 =?iso-8859-1?Q?PeB2LKyEbkB5BB5J1CQ2598OCFet0FikyVG0osMkbkaUoT+oNHvX/dPaNL?=
 =?iso-8859-1?Q?EfIGdbmbYHYyj5R4NIgdtV+ijAfSd8mZA5FPeqW0nQkGvyaYawZ7EmHKdW?=
 =?iso-8859-1?Q?84jHrYmCZsF6G8E+S1N/syM/uMQA6u9glFBj7VVnclXFm7Elt0BvgufLQF?=
 =?iso-8859-1?Q?ao55WtkOQf1UlhAFNcUiunc088/Oxei/WDV8RaMwDOyELfG6K9uWAIxRtt?=
 =?iso-8859-1?Q?Bt15wsa2pAASYRClSGeqhI9y4612UWIW4r3J2YyDfKzQZMEMRFQBwzrbiN?=
 =?iso-8859-1?Q?dAaTvIGNdKxuy2N6tnlJpBA+XpwssC4t3N5CR+aa2EsPy86nK8UO5OXYcB?=
 =?iso-8859-1?Q?3+a5oZxk2hKSsLWBpnmy8a7qq25cRk0PWiaBrI6LtK/f5V0S4k0SuRNSYr?=
 =?iso-8859-1?Q?jth4Ejfm0IFpfeBra9N52UZDThc31L5zsZaMA+Ri/WlF0a0z7HRAyCA4H2?=
 =?iso-8859-1?Q?mS7YZmPvoYyDCsBlQAnezeqPvfnFF/9me3QRy0DAv9RLsHQ30RnWqx7xX3?=
 =?iso-8859-1?Q?uDrsn/B/3vXR3wmTDDaqqB6y3UWtVuWYghZUoJf6MEFScy4zgwXI7nh8NP?=
 =?iso-8859-1?Q?2WTeqXDlqxPfSr0hcp2hnpAe9dLRBYrmBtfyZeDcajD+4aNMFEP/GBHun8?=
 =?iso-8859-1?Q?yEMvW/FV6P1Ts+dwH4bxhS1P37UyvmxHFtaz1NtWcmoqPCeHHwNWPg/Ds8?=
 =?iso-8859-1?Q?gD55JKSc9h4RgIyjXjspxyFKROA//XnB7fqAP/koYiesqY9zM56J3pyWLI?=
 =?iso-8859-1?Q?WbowI/xyCjzaFDGWkhrtDlTq/ymACcwDRmPv2cJ6XM8vDHFEwTtGdF29po?=
 =?iso-8859-1?Q?6iPqpNHL4p3d1bF2x4cMHmaRcZrVgXti/XMJlnz7C+hmNatkXmuoqqSZTN?=
 =?iso-8859-1?Q?TUwMuVrKMo/vEtx3glaS/ZGAGodRKX9yg+Doa/pvIU3vfbUgPbv89hwR7j?=
 =?iso-8859-1?Q?SyMpdNlaTi4YNZqQGhGjogd/QDXpotJ7VoIIe5O4dJ977OVoJ4PlKA/uWH?=
 =?iso-8859-1?Q?Cye4oMy6y9In+zJRIcSnZGB3005E9rJ80kl4WIIz8W07NLf3b1lOfUjXaC?=
 =?iso-8859-1?Q?1avMB+yIGht7ZI5k/98kqVdrXOg9NzneiyhQMAN+e2i1NmZcbGYJkgZdx1?=
 =?iso-8859-1?Q?I4Ry1iNpM+L2Vej5TWFgWFtbwuLJx/yG3B3MV5TNoGF+AG645VMHtlEW+K?=
 =?iso-8859-1?Q?1tLbWHscbrQnCAI3pgx2AN1R6nF1lf1tig?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb734023-bdf6-4f05-6d29-08dd3aefa754
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 14:18:33.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELCqyLxyc/T83EryollBMeOaRW8/UmNPxNgNujtlBOLt9rbuHNWNFSSwvkqTv+FXAcDCpwgtRMTlw1P5supr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
X-OriginatorOrg: intel.com

> From: Arnd Bergmann <arnd@kernel.org>
> [...]
> Subject: [PATCH] EDAC/ie31200: work around false positive build warning
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> gcc-14 produces a bogus warning in some configurations:
>=20
> drivers/edac/ie31200_edac.c: In function 'ie31200_probe1.isra':
> drivers/edac/ie31200_edac.c:412:26: error: 'dimm_info' is used uninitiali=
zed
> [-Werror=3Duninitialized]
>   412 |         struct dimm_data
> dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
>       |                          ^~~~~~~~~
> drivers/edac/ie31200_edac.c:412:26: note: 'dimm_info' declared here
>   412 |         struct dimm_data
> dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
>       |                          ^~~~~~~~~
>=20
> I don't see any way the unintialized access could really happen here, but=
 I can

It looks like gcc-14 isn't smart enough to recognize that this is a=A0false=
 positive build warning :-).
Actually, the dim_info[][] array is always initialized by populate_dimm_inf=
o().

> see why the compiler gets confused by the two loops.
>=20
> Instead, rework the two nested loops to only read the addr_decode registe=
rs
> and then keep only one instance of the dimm info structure.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/ie31200_edac.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c in=
dex
> 4fc16922dc1a..b0ccc54dc66a 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -409,10 +409,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int
> dev_idx)
>  	int i, j, ret;
>  	struct mem_ctl_info *mci =3D NULL;
>  	struct edac_mc_layer layers[2];
> -	struct dimm_data
> dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
>  	void __iomem *window;
>  	struct ie31200_priv *priv;
> -	u32 addr_decode, mad_offset;
> +	u32 addr_decode[IE31200_CHANNELS], mad_offset;
>=20
>  	/*
>  	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
> @@ -472,17 +471,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int
> dev_idx)
>=20
>  	/* populate DIMM info */

This comment also needs to be moved to just above the new location of popul=
ate_dimm_info().

>  	for (i =3D 0; i < IE31200_CHANNELS; i++) {
> -		addr_decode =3D readl(window + mad_offset +
> +		addr_decode[i] =3D readl(window + mad_offset +
>  					(i * 4));
> -		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
> -		for (j =3D 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
> -			populate_dimm_info(&dimm_info[i][j], addr_decode,
> j,
> -					   skl);
> -			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
> -				 dimm_info[i][j].size,
> -				 dimm_info[i][j].dual_rank,
> -				 dimm_info[i][j].x16_width);
> -		}
> +		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
>  	}
>=20
>  	/*
> @@ -493,14 +484,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int
> dev_idx)
>  	 */
>  	for (i =3D 0; i < IE31200_DIMMS_PER_CHANNEL; i++) {
>  		for (j =3D 0; j < IE31200_CHANNELS; j++) {
> +			struct dimm_data dimm_info;
>  			struct dimm_info *dimm;
>  			unsigned long nr_pages;
>=20
> -			nr_pages =3D IE31200_PAGES(dimm_info[j][i].size, skl);

Move the comment here.

> +			populate_dimm_info(&dimm_info, addr_decode[j], i,
> +					   skl);
> +			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
> +				 dimm_info.size,
> +				 dimm_info.dual_rank,
> +				 dimm_info.x16_width);
> +
> +			nr_pages =3D IE31200_PAGES(dimm_info.size, skl);
>  			if (nr_pages =3D=3D 0)
>  				continue;
>=20
> -			if (dimm_info[j][i].dual_rank) {
> +			if (dimm_info.dual_rank) {
>  				nr_pages =3D nr_pages / 2;
>  				dimm =3D edac_get_dimm(mci, (i * 2) + 1, j, 0);
>  				dimm->nr_pages =3D nr_pages;
> --
> 2.39.5
>=20


