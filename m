Return-Path: <linux-edac+bounces-4337-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3A5AFCBB5
	for <lists+linux-edac@lfdr.de>; Tue,  8 Jul 2025 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832461895EBC
	for <lists+linux-edac@lfdr.de>; Tue,  8 Jul 2025 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51E2BF001;
	Tue,  8 Jul 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S91UJR83"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1E2DAFC2;
	Tue,  8 Jul 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980791; cv=fail; b=f3XHMP62WxuH7MDh1DTTjzlqendbAw1oRBWVGe6PuYPMcRhb8krZ+LwZyXmCnHvkOrnt4scv7Rn2ATVYVDCkTMfljYm79OXB4bXzhubnnn3SXRpQXnpId0vkbzcIowgg/TXqiDsLzM85ug6djH9rucEfcEaihP1NlqXo2eswnbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980791; c=relaxed/simple;
	bh=JWeooe83ycXQ4k+WUjiISVRNoQGRafdWPkmtOWYopho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TiJ/Ca7hbjLqxLOE4jcR+OoRcGexrEUWcOcUAjY70GPYLGffd2Ramx2Jnqr8GyPV99627FPTmO51zqHRQPsVPp+Rt/nVe45+eZhW41pebidf+aZ/1bcECqNW1SNWolNxSbXXjYrr8fcT/kaZKsuitAnEeUrk2GihFuZFI17eo5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S91UJR83; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751980790; x=1783516790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JWeooe83ycXQ4k+WUjiISVRNoQGRafdWPkmtOWYopho=;
  b=S91UJR83XsLbg0TwyEL6ybEGKZqW2i7SzYv6rDX0wsAk93VLCAFg4hmH
   7kMr/gTcgjcZc8D0PVtJuRI5Hf08x6yOjAPJxkDCDY/VGsFy1BKcZe86d
   8jhIS9+gUC+2BHyp4dNk+zC7ex9LZblpgew3loDl6nvGLRhUM0hy6jHT6
   nORrhrEitwVzjp0OsrFz9Y7vs+n1uQsJt0yT97MW7WyhpBzeeXj4H+phS
   jjkWTMmZrMUIIpq+4ERfw55h/ftz/Ir91WgMgx0z2G9UpbItEQfIIYIX4
   ikQ58TLBoIRdETcbxKz34LoNa6DGdHl4poaCY1ZI5g5Teaw8XI3kdKh3C
   Q==;
X-CSE-ConnectionGUID: mrddmbsZSAm+YK32RvlD2w==
X-CSE-MsgGUID: ciuKz296QuWMsmIrnn5jyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54076912"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54076912"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:19:50 -0700
X-CSE-ConnectionGUID: u/vK6KPpQsq8AbPpum4u4g==
X-CSE-MsgGUID: FKPNLYNuTzq9mPpdysEH/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155114466"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:19:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:19:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 06:19:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4ilAWUCOhT+o1qDAWShh+WieMWATztcgkHN52BG/UvofOEpYp21LmF50biZDdny7C8nbv3CEa/nFz2DPo7jL2C2c9moNJOo5d40gw8XtCKDmnll0KSu9pp0+X6mXMEvJtPxjGtl4NFxLnxp0RCT/mmwUMkIW+oe3AFMciAi5iRN620IPuzCErgbegXA+zLe2Qhm/YTZ0TunbmAbSLm//rLmNK8NTK81WfroVkeunuIRvtk0idpScDw2WBtx10pJiI+zRu237KsBXNT5VJRe0erL7ukctqaJ31UscOOYKsnFKGsiC8at2F2DxewNzhXhZs5f5VYie40J5epDHJo+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJwwlIZ0v8hhUMxFf2G6mtChJUr1FJMHEG4L/wfHo+k=;
 b=C4isd6gYw9kcCbqTLeMcj8zUDfy7c9MucEES8MBZ+Guuj3ICaysjChGomJNb/8iUpeevWxxeEdn8mazWXyfQUJ+wF2uRbhiBHX2S5+pfIhby1n6VlwUAJmxUOKB8mbSzc3EisJezfPkH5X4Kgwp+Wgg22QCN63BRSPIRAf870Wxh2K5B4tioQgcabhiG9VV5Dq1LEpkM5mMJTRKaoRyiLk1OHpOvfevWP2ENT0my7gwx3LS/qPxr79vs8WUpiSBtCaMI0POGhIBdsHPgxh3yAwRrUSOW6Nuj7TXQQQnxm9d6ZvDvUKGCf+SHBzq+Lj1GRv7sWdRCwcv7tefYRi6Gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:19:45 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8880.027; Tue, 8 Jul 2025
 13:19:45 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Li,
 Lili" <lili.li@intel.com>, Laurens SEGHERS <laurens@rale.com>, "Chougule,
 VikasX" <vikasx.chougule@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] EDAC: Add three Intel CPUs for EDAC support
Thread-Topic: [PATCH 0/3] EDAC: Add three Intel CPUs for EDAC support
Thread-Index: AQHb7LjanAPryzQeskGg8R1elu6fvrQm+YaAgAFBw5A=
Date: Tue, 8 Jul 2025 13:19:45 +0000
Message-ID: <CY8PR11MB713416B1079C65F026431360894EA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
 <aGwMA0jZWbQeBIuZ@agluck-desk3>
In-Reply-To: <aGwMA0jZWbQeBIuZ@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB8436:EE_
x-ms-office365-filtering-correlation-id: 4af45858-7d97-4cfa-f746-08ddbe221b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UrhW30LvX+s+Ohw2Ag53+J9/acYWmruA6PjpQ1QUOVsm0OiNu6uoQfx7TVpj?=
 =?us-ascii?Q?X2idvr3YPKJvcrsARKv+VStNqbE1i+fg5rma4SuyHlQjAkw+7NwzD+vVA9FJ?=
 =?us-ascii?Q?lTJEh7bGr4/nMuXstMQl18evMq+Nv2nvYrTfZJ1Ptv3Sm1nKP6VVwN2bhg/+?=
 =?us-ascii?Q?pC6orBr3OvFX1eI5L8I1acucCumRo0d8sPmzoj/hvBDYFpuGBmz9MOtfnzHQ?=
 =?us-ascii?Q?YLHUkOPzDNdbEjgoi4RdNSwaeSJk2Cyn3TeNXFu1lDBTp7a8uftw1ceq7tuX?=
 =?us-ascii?Q?pWcooZvW3N2bDo480iqsJZhjyFyyjfxOsooQ+D0aw+5twKUcgaMrR6673FZ6?=
 =?us-ascii?Q?/gaTUi4tNRlCnneMkaR1vemtILK50ChYaPJQkqBYEmmIJ/XdNFiNdVl9cnXU?=
 =?us-ascii?Q?5de+kamfCdySKKrrn1uPWl5ClFTQsU08wsjAgczhRAVUgKYQcoOG8xNztR48?=
 =?us-ascii?Q?BZinkc10b8chto/tkcL9jnUv16GUi8zoZAoz9dSt3xplXOd2H6LD+UNoHlLz?=
 =?us-ascii?Q?GsDRBWqvy/DQVKXUWyWRoskG7+Jm35crhO5PyjlcP683omkOJvjl6Ly23qYO?=
 =?us-ascii?Q?yPxwK19Ql8uDR2jPFMnE/FsflV14XDP4XIhndRx2Kt0XXlMpZM5obx5eaIvd?=
 =?us-ascii?Q?FooH8EqxbF1XTJ6EnSTnrqHDfbZ1sUZJe2bwI5bbzlbmVMTUPVSp8cLaGVaP?=
 =?us-ascii?Q?jmy6pBnTPxY1B5ScxPMkk659lP8ZcaChx3jGjBqnPk37avJoDEgcMlhqD335?=
 =?us-ascii?Q?srMcMM/AUrJ8bWe+BWc/v5x/tFPaBigKqGnVs4VVlaWWeMTmcsbte82ixxLB?=
 =?us-ascii?Q?gqrbhiGuth1Qx8bQbpM/VTtbPt1PSLCjzCPeTU/GtdSe6Cmh86j56W9H4gB7?=
 =?us-ascii?Q?XOC97K2GsX7WjOXttRiAY2wApoPbYbl1Y0X7J8T2Sbo723hBdp6k2UHfRRzB?=
 =?us-ascii?Q?wb+IERTsKg8XITmKJhbhy29/Vb6W1j7r7jzjoAwc6QL2PbQpJS7KEQWuSv4R?=
 =?us-ascii?Q?MYbZs2ZysTIDJBEqqMaAYjZ1rRstgn7pX7Sq4+YoxnRDNrcQOAvUMAVNLDmX?=
 =?us-ascii?Q?5uG2cize7e/b3plOPOvd7jKRcEkOR+QIFn03Vr26ezgoMPg8Zwkun99PHbKZ?=
 =?us-ascii?Q?EveMByo4yIvmBsfhrlkTrDc9dBPA28RKpl/dTKiGAxykpaUCIetvYAH0O11e?=
 =?us-ascii?Q?44sgO8uDv9InsYKFWuqPk3pvgNopxx5z/0yWXtL2Gq2kW9U6f3qQtgWQ3jYp?=
 =?us-ascii?Q?XI79ixZuzQz3vUFhUg26DjzdNNHHKA6H9uktllXCzIb/+V0x5xcJh+ZcSv4K?=
 =?us-ascii?Q?X9H21SVClPFqW8XIDmIi0BPJivxnwzXcgK0UdjuaHY5tK8a7tCLcimHGoJcr?=
 =?us-ascii?Q?uWdxMHFaBac4zMMZUR3cGcsQxzZriDWFBNuTKml4SspgwS3gEtzgLOPOktNO?=
 =?us-ascii?Q?4nSA1X9cxFXYKdKT9gET/o8f/gZES1m+LQcQUkUFyS/OBcMj6vNhlw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4BQbXlomKtlNPKE3BkptQE9c1czNZNYSb+l7vWL0jEExisAQ17mVhUmVADev?=
 =?us-ascii?Q?HJBwWmQB67DFBgougY+U0CrLYTb41KI8Z+lQ6LR4xARuYlG9OTOJlJTUOYHJ?=
 =?us-ascii?Q?TwWFcyZdDQIF5ZSFjdxevOS+cgN9LWNPpzeQ1n0SMn2g0bLVgHogc5PtOdDO?=
 =?us-ascii?Q?yqr+RLp1T5DV2ti0li/g+xC+s/2NzRJ8JiQeA/N6C+FOuafOi50Ds495VA6d?=
 =?us-ascii?Q?5hYnHQm4yTqqtEgZrylQ+1Y82U2X3X4Dcip1vM0keypeKnCsxD6n1TodImj0?=
 =?us-ascii?Q?6Gcm2u9U6rXw4Xr0y8+KEOTnU8+nX7qv/S9quZM1zJ5c6zRC2DezvkodSmaj?=
 =?us-ascii?Q?mKD8nCR64Fm9b8mSnHbljKzgo0KSeaH1eO5ABiFkti3WvR0kkT/INqop6SIc?=
 =?us-ascii?Q?hzTYifIJW8lqCBUfq6pQ3+GZGA12RjPJlqGk440rZzovfFafdzbVxJc1XCxY?=
 =?us-ascii?Q?hdgrCXfX2kPUYW2lXbdm6QMEm054LRMseMPcVp0tRrBtHPOP/ReeOzFkWrg2?=
 =?us-ascii?Q?XKT53FDqONLEAnfFYr3Jn6IMzCmoFU6ZaTeFXuQjIxYkZg6bupQudrz6l3tN?=
 =?us-ascii?Q?eV5CvuplTVGk2nfyvyaqrF9vUTeW/1nr9c5/UliCPoz9ptoZGB9os6Pyahom?=
 =?us-ascii?Q?rnj6853zk+7eUSBbq015RbKWu1o9a4ogsaLJg+zGWoZOiCjYR0DWb3Rhu4jl?=
 =?us-ascii?Q?zznsWwYDpGQ4SKZWjYk4eX+yh0H6XVJIloR/jhTfHwjLERdJ4kSsO4VpnSfr?=
 =?us-ascii?Q?dS76w6E087/hYzKAyS72L89lm2pUupZDNHuL1qJscu0Sm+A9nfSI/C/Lp8ND?=
 =?us-ascii?Q?fo+y5SEkPZz6g5ZjmttRjRkHbvrOVlMKuwN2lS6jZryRnw3mT3ghovLZPfvj?=
 =?us-ascii?Q?gw7ljtZVRvxwkkCs0ANoDZF5geCQ0qN9ajVCHhy7YtZhhC3IXcKhzIYs3pOE?=
 =?us-ascii?Q?bS/0Hu0FPMf20b5NHgW9nfUyjIGMvyNgkIdVjFecNFY+rrNlILMMrqFmZaNX?=
 =?us-ascii?Q?/i4hy6EhSQgELG/1hlgnnC3NRshW5TqCxWG00netVOsimskQZH9SRaGnLhtw?=
 =?us-ascii?Q?8+hE+jRo++QC0QekjZSX04uja91Cqmti/1iwfdhyzHBni3KHu33kL6Bsagl3?=
 =?us-ascii?Q?Q8LQXCxZrcqjwsRRR7JOdlFZblEYLqKvywZ5WqonDQ2Tp6naQh7PFhpKohTX?=
 =?us-ascii?Q?n3ZgvoU7twj2ZpGRGYxYOREgB09wnKZt3IhWOqL5e73Xe1zOct2SzWsz0IK4?=
 =?us-ascii?Q?DvFpuOCAXS3a2LFcsu0do3CSmhab0+paT5LQJbKX4prX6jMIurZN92lf6wFb?=
 =?us-ascii?Q?25fsjVqkjR52+EHq+jtY0S79Eeyxh2OUnZ3mXLo4UHrPonEWHM28m3BQ0F//?=
 =?us-ascii?Q?Gh9HFlmAdLc6c2B8BKdx6aZxtA8sNkZVcvoLTRaOEAERD8Tsv92hqpUExxwO?=
 =?us-ascii?Q?MaD79/LVASjk26eyKiVPGxzUBnPCmJxFX+1DDBVmTax7/U1V5E5izRm+6TDZ?=
 =?us-ascii?Q?Tusdb/AmZfh7yT54DZmXz9Wfqx60d6RAyNeBbjxr8ZTL2zxPExZTmBexFJoN?=
 =?us-ascii?Q?5WvNiIydKIHVENQh+jRv8l1M3YnVZF+UQ6Ep2nqy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af45858-7d97-4cfa-f746-08ddbe221b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:19:45.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9DJaV1pCYeE3i9UgHHjH+iutRrDbIIwWZtMrX5UzPvJh8etSYgv41UoVFqqHgg9hg57JPby4d1FVa0YyuUmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
X-OriginatorOrg: intel.com

> From: Luck, Tony <tony.luck@intel.com>
> [...]
> Subject: Re: [PATCH 0/3] EDAC: Add three Intel CPUs for EDAC support
>=20
> On Fri, Jul 04, 2025 at 11:16:06PM +0800, Qiuxu Zhuo wrote:
> > Add EDAC support for three Intel CPUs:
> >
> >   - Patch 1: Wildcat Lake SoCs with In-Band ECC.
> >   - Patch 2: Granite Rapids-D for micro-server and edge computing
> applications.
> >   - Patch 3: Raptor Lake HX series SoCs with Out-of-Band ECC.
> >
> > This patch series is on top of RAS edac-drivers branch.
> >
> > Lili Li (1):
> >   EDAC/igen6: Add Intel Wildcat Lake SoCs support
> >
> > Qiuxu Zhuo (2):
> >   EDAC/i10nm: Add Intel Granite Rapids-D support
> >   EDAC/ie31200: Add Intel Raptor Lake-HX SoCs support
> >
> >  drivers/edac/i10nm_base.c   | 12 +++++++++++-
> >  drivers/edac/ie31200_edac.c |  4 ++++
> >  drivers/edac/igen6_edac.c   | 15 +++++++++++++++
> >  3 files changed, 30 insertions(+), 1 deletion(-)
>=20
> Added all three to RAS tree, branch edac-drivers.

Thanks Tony.

