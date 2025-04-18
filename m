Return-Path: <linux-edac+bounces-3589-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6334A93BE6
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8CB1B65DCD
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5E8F77;
	Fri, 18 Apr 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsVJ3v/A"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B221325D;
	Fri, 18 Apr 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997013; cv=fail; b=kUmKKcVWpNuWx4YpaZJYn8OpQCH2Vy/fJD8BPpcxTttUFfSEr3cRyRTleKhu+DeiFmyQY1bl68q5TJFxrWiRKQvYJqLsm/gU7450TCBjIKCGjZ6Xw7RYQemA60LtJSvZqPrHLvT0zZshf2SUeACXZ1n/Eip2kbt32/DCY2WuM/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997013; c=relaxed/simple;
	bh=ZRuDw/KgfCY5+jzVcVeGlIb37wjX2qBit8tj0K8ieq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZywPm22exbyBb/f4HTJz6QoApCrGYNqAcvRdMZ+u/4HUjjEHHIDXOTqS8C9fv4DeKkvazDr/5OCXFHbdqp4V4KrTbnqUemuOw2bNyZQr26vqphEk3Navt5FRFUQR0o4HBygoyg8Clb2IzHLcP6u5Gk2qMhdVTYwEXr/LWEA7mw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsVJ3v/A; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744997012; x=1776533012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZRuDw/KgfCY5+jzVcVeGlIb37wjX2qBit8tj0K8ieq4=;
  b=LsVJ3v/AHrOUkbxqrm6GFEKOuRBygqfGlyiywaYNo8IfAxK4zKUVG/KA
   pU1v0tif1cF+Ug9MLHFjCE0CJQRNxDyrFJuEMH8/3rv3oCeTKfjtrN+5z
   fYQle/crLBH4IU5p9tDzEfWSNjSYoNEpKsFApGGosl8KGOeRh09Kn9XV2
   cClXW5lxbNQ8xJMe+9eQSE91VW+XkouvEey+eKOJEorY7m4hqT8FrAYQ5
   /QGnr0SHBe8vNorkhvQJha3IbZNBCzI59Go8aw5renAK3/KmcpH2vaIym
   jPXzDlIe1GV0nc+v06sk7YzImotwhjwBzpqBVcOjTDtI85OH6LEH6k/Nt
   w==;
X-CSE-ConnectionGUID: YlVgdtCWTGWtUzZREvZF/A==
X-CSE-MsgGUID: c7x06LAoSjmwaCES1l48XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="64034877"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="64034877"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 10:23:31 -0700
X-CSE-ConnectionGUID: 1br8FDgVSO+WFBZJT/sSVw==
X-CSE-MsgGUID: FF8mxcutSfykn755oO39Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="131463304"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 10:23:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 10:23:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 10:23:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 10:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpQtvrBwOl1UyF3SQ/TZA41rYmCZxctHJr2MXYEP3zFS1i9mGfFRz6dsEJAnENFs+8bbHCgWMpDp4E7FmljWv2FvcMelhmLXTCM1fqXw2EgPUd4FEO6lVMX20+qT9rdzJ2cOyZaane0CT7gYYms0j+LuF8YWAv8g6V/OCsWfmXTFLFUPF6fLlxzF6WS9AIu9vIZJhtJWT9knhDfeHHXdtQgQpwB27fl8pmNGkE1UL2ah9xOtsEdDcgUbi86nOxDevhxkdo1HMMx00OB9KVbUHuj7ggof/OPDQlHg6k3i1y0BaJ4rZq7R3zR7e+S2y2AYGwZ0PgsR9sZK1J+PLo62sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEbBjR7Z25V0SighiW81mBoTwP3HyooeuHThWF9jXI8=;
 b=xUMrSKsxbuoBCOSO6P5CfgmD/WcxxTWpm4vxEHoo86yu48KU4UN8rBw07LbnzdY3GlzBK8oWt+ZMR/ahBWlcje/Hln8cQmE5+xj1OPilboWS7cX82k8AJmH2iBSysb4fEkoEFul3YVbpBe61P82utoagTBNuHFGtB5WSLuuK0gDuJwFT/zxHMWkdl56nVJeTO3VsldWhmY00cmKfdkRJi2AckyGwv4m/9oN8p+dMHIx+auQ/+fhQ0pTFcxvsH7o22MO9iEHojYBC9iZawvV6ZvOohrU2qDrPIfi6DIRE/erdSyyvB+AQuWV582EOQ69ZMVTGgmWYR1fAQYiuaHUDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.45; Fri, 18 Apr 2025 17:23:00 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 17:23:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"Lai, Yi1" <yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] EDAC/igen6: Add EDAC support for two Intel SoCs
Thread-Topic: [PATCH 0/3] EDAC/igen6: Add EDAC support for two Intel SoCs
Thread-Index: AQHbqIm/Odut+dQSaUWUNiZd59ospLOpu5iA
Date: Fri, 18 Apr 2025 17:23:00 +0000
Message-ID: <DS7PR11MB60776D9EEF66A2B55433A7BEFCBF2@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: ade7b2d2-1c2d-4403-63e0-08dd7e9dab64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TTvtyoRS8LNmQlNByLUewOYtQUTiNuo61yTtbhS0DV/A6hLKUehkrLAu9tMf?=
 =?us-ascii?Q?9Qh9/Nj+t1M1FohXAzDYXLL56v9ItVhY0wf+jdsT/24UxblInEj1YeoYN841?=
 =?us-ascii?Q?Nj6J8UdgOwUEmFely6UUTmWAj5pUwqPMpp8emDsNM4UML/bnvQ/cYmIetQf6?=
 =?us-ascii?Q?xfgyDPtqISg3NB3+J4AZldUiSVpGmNt/VIfj8xPqls7yrK4glytpl1OomyPs?=
 =?us-ascii?Q?gVIgviShmX+g0Umcem724llpaqeUs9tXvciUqon24lg5cb1JEHblCmjcHP39?=
 =?us-ascii?Q?qPW87iTDV1A6ZqEkstWE4GE89wDSJC79vRcddhOYcUF5n3YiCORJwy/TRD91?=
 =?us-ascii?Q?gswAJh5tsqcxG2/Fei6QmPq3jH+lEbabiTO1z6nu/zMaXWhkD5axN+3yNf+r?=
 =?us-ascii?Q?SBd4/cITxFlewcWVEW69B6G2ioeMhKsFydYd/UXOVKbRZ/SF684bQbZHYyWk?=
 =?us-ascii?Q?Zo86icz/WJRe0y5yC3C009+G/fqAh803Wf2sYa2CbKNAx4n/S7ttZQdA7x3i?=
 =?us-ascii?Q?WLWZbQI47Y5XkN8/peMXPIrDNcmeV920wRzvzEEMssX9pD9bCoE2lOZqjozY?=
 =?us-ascii?Q?Ge7wtIAlrjPQwnbFtSB7Z6VzEy+u11AGoc3jxk/cVz3xWlLSk4POpYlAke7z?=
 =?us-ascii?Q?2+r3HeqlzHyKihotbzdvrPDeHW/xbm9l3Vg9q7DnEiNILxLkQQuXv/vHRVJ4?=
 =?us-ascii?Q?vE1T77XuWfW9AnZgxO6SkJc3iT4n9BVfjw9Cla6E+troKi/S57UZSGamccs9?=
 =?us-ascii?Q?+KnAMqW3PdTlQAcyaDsTQYL/GPEir+J0xhNny1FaAxoFAe5y8LsQAcDtexIf?=
 =?us-ascii?Q?CN83cuPG0BJC0TQFZt/6S33PO0I8SmFJxYv77vIAJrFaYgeo4OrF7W/rIood?=
 =?us-ascii?Q?WYmJom2kPefOuP23SY/YYSS8GVCaftZUZKhB2VLF5O0avt10R/iYcv89qpGM?=
 =?us-ascii?Q?qimg150qxnriUsV+yF8BPEL1Cnw4NTlBWs0la5JMoMFUedIQoOS81gGEgzFU?=
 =?us-ascii?Q?QGpflLXb5yclYesoF4uaFUlC30yCedROeIbeLp8MvNKxpNOhsEXSDVOMfaC1?=
 =?us-ascii?Q?6NDGPatjoGPr+cvtfiAA3h5D42uGQcXAqMa5MeliXTFzUGAtOUt7v4yRCwJ/?=
 =?us-ascii?Q?u6k3JmqVoWjxRnxVuIHEVyKXFQ0dxfHHh5hIv+56bqOLoiQgZ4bEAfuTOlx/?=
 =?us-ascii?Q?w/bPDaOUmSjgEs4M3XvsMhvs1dqSmVw+0ivY81gdevFq2+UKYkCDQJO+QEB/?=
 =?us-ascii?Q?G7+a1WkzYFggZPk19lxUvTpVe3hS3H7JW5MykI4Av8hZx+/9tW1kxwoswoAz?=
 =?us-ascii?Q?HSFN/8U3htXVKdf6bY+AtZCciXFUtw4m7dUFHfeice+1JSij1RAVb8hvtzxr?=
 =?us-ascii?Q?+0yvvh2K+2dYRh9AyKVegkR20tmqMscpyxus/Y6VUyN/b65jUmkODRYItD7U?=
 =?us-ascii?Q?4sgKb1ycaiN8M8oz5iTe+xgAn1u2AmABGtRqncnsavs9PayRiwPqG1jlSwYo?=
 =?us-ascii?Q?5zxoAOQsYwy0EbY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BXhPX7mVWLSAJIwSdmtQOyQQrDZUozqlQ+Z58M9f3AsQTBziyjhjcjyU78Hq?=
 =?us-ascii?Q?f9tjWLPOiM9WO9drBxYLtxEw09u/BSgvyyBdPy/aVPU9AZgdIPDQf0sMqJl0?=
 =?us-ascii?Q?+kMsEWvZSi5JzgYqOSszduv0mlvYVprJf0RYU24YGGXKPUpHkKiC1oKU08bV?=
 =?us-ascii?Q?mk98KpR/loLastcswgoSD2ga7qoPctAVREoZA+zv9Fg79j+w8YP3OBb80+np?=
 =?us-ascii?Q?VRcp/AosBEUIjD5vp38T+3X9rutmQ7pBtpF/XlmMe4gmy9Z7HgxknUU046d8?=
 =?us-ascii?Q?G/QdOApaE0BNk3kDFliunU400SI1P+NMKeklKrWLWUzAZLTWZvheGERNeVcU?=
 =?us-ascii?Q?G+cDRxYpSgDitri1gyhKL1VpeU8u5toEy34efpnof+LcFicMQGfUfxOxJMFP?=
 =?us-ascii?Q?EKQBePBfJ0Tdao0BgRtTIhMyX9sTHmPwtSVR9eJZ5h5DXp0tsx4KEo3yJcQe?=
 =?us-ascii?Q?DQII14QqHUndweN9An0TJe4x8VnrvWtYge4/T1vQnL/Rp4Qk2lRS02+qJRkF?=
 =?us-ascii?Q?r6/F+sJDadXVwz5GDG8jlN/HUHUbi/b4KO9T1x1wI/Z/WZv9vQBnrGzQypn2?=
 =?us-ascii?Q?/TBpZM7qm+isOzDRysMWtrT57U7YnZcUbULpXIAcE1mUUfvOVbgUMu7cetUB?=
 =?us-ascii?Q?3EyGVlWp3h+4VXCX4TkijGTtqDrjjhTOg5TBLY8oJy3HaBIL1y3g6rx9Aqxr?=
 =?us-ascii?Q?FPoTvqBaI/8lOJnAmjxZ3BR6cd2xkn48QWEUlqWo60LGo/mzwd2DjSu9HfPc?=
 =?us-ascii?Q?8KQRbOMGtsEyx0laJ6NiiUZ+iBQQ4XeRGH45YDZUbJ4OeGuuaQzZja/+kueQ?=
 =?us-ascii?Q?UjrH63jY6GGtXmwhq9IRG/1dHF9ujPuxTH2b1Tl52HVWJs47i8RcEe66gewR?=
 =?us-ascii?Q?Qi+t/omjF++DNR40go9y7RbiG3jZc2PSG+wkpbZj65i8rAbCqyXN1ZE6WVwc?=
 =?us-ascii?Q?gdPVnMfsxnNznBxyTsAzM9J5iaXBivn9HcskgJjBzYPo/rskgkD0dm8kLv66?=
 =?us-ascii?Q?O5MpNIy5mEuVfUT27kwA4RQhPJ95uvmoMmHsb8//+b0o/jORi5Mb2MszRFeW?=
 =?us-ascii?Q?/SUDG4bgv/Ea3X0Ecv8Cj3jeR+6orE+OduguPM0a+fWWiuDs3rCfx613F/bz?=
 =?us-ascii?Q?UI/N0UCz6yb8uXkrwVx7EA6fJmjpY/PFUQHWWNtp1c0RbhIs5hoHFnbt9h5/?=
 =?us-ascii?Q?QWLDHGvLYstEWx7JO0bjE2ypWm13KyRCUBWoISdAwoiUpFLWRpIIhzPi4T+W?=
 =?us-ascii?Q?5D2i/55gbMAZdS/DD9yl6NeNJSW+g2HOmFUg/b5I6g+GL8QeVKuz3dQpKR0l?=
 =?us-ascii?Q?o+N2KO9k+sWFTqfbStHy6kL8Fx8zCgbm/xPSuwpm61NeTxfY8EPJ6OiHcp6N?=
 =?us-ascii?Q?WtZAoq3Bs6c/EWEhsQDjDfc6qKyPOfbHnTSvEoZ45Y44czgQDzIPuj4MkMEo?=
 =?us-ascii?Q?RG7AoJyV/7OUd7j9bP5B777ofS2k0rku6utNSi471V6QvNJFl1ufrKv8x1Tv?=
 =?us-ascii?Q?yRhKLPeA+vSnJrSE8Ve506O21awAxz1czNMz/iNGiE0m0iS7Ldya+CYL1sEq?=
 =?us-ascii?Q?6gLzGbIbUhX1ZJDwCgUytTlL67d+qiVKybO3Svr1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7b2d2-1c2d-4403-63e0-08dd7e9dab64
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 17:23:00.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9nkSQ2nm3JIymG6vcIfU1fyZwVjApcqsra7KBTBk4FnHuMOTll2njYFy8NHzpIyHIRv5P4DpHxJ2JI0tji5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com

> Certain BIOS versions of Intel SoCs with In-Band ECC capability
> (e.g. Arizona Beach SoCs) may fuse off some memory controllers,
> causing the current igen6_edac driver to mistakenly register these
> absent controllers with the EDAC core.
>
> Patch 1: Get the igen6_edac driver to skip absent memory controllers,
>          preventing erroneous registration with the EDAC core.
>
> Patch 2: Add EDAC support for Intel Arizona Beach SoCs (for network compu=
ting).
>          This patch depends on Patch 1.
>
> Patch 3: Add EDAC support for Intel Amston Lake SoCs (for edge computing)=
.

Applied to edac-drivers branch of RAS tree for next merge window.

Thanks

-Tony

