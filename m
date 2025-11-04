Return-Path: <linux-edac+bounces-5321-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E45C311D8
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 14:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 756854E2501
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D92EF673;
	Tue,  4 Nov 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbbhASSM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721791F1513;
	Tue,  4 Nov 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261707; cv=fail; b=iQpvXDomcQrGUVVNxbwu2HxBUIXQinvQuGrvblHnltLLF5qrgxvLmSADROF+dnjp8pMV45YrrX37iuPeARAx0xGMSi19lCSHctv6+9TVqOXcGuHwou9aMyC9hVW/fPmQYbcRnVKQV0PDGKWGj1Ydw93xo0fD5z1S2L12QzSUyvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261707; c=relaxed/simple;
	bh=HVAEpGcTrTMLWJ4O3EG/2tm8B4m2urOKiJd19nta4SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvKWjJ1MPTYGXZnGnIvGcaelqy/rKiQUpLlZEzyvAd+LvoOciIONYPdFRM4EoJABKY+YGJvP9YMZgx88gk78V8cyxHi+KDcNt+Mtnzke9zhk2Itqu05nRjoQ2qfOJlnKjUsg+hDNgv+F2T6leYMeiGUFf2iOL9bKCWgxQYePPFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbbhASSM; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762261706; x=1793797706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HVAEpGcTrTMLWJ4O3EG/2tm8B4m2urOKiJd19nta4SU=;
  b=bbbhASSMV75dE5YpTRMdQJjoZfoF+Xhek0hJu+CSg6zjFTLpoAySw8nq
   Kj1yd6TjcM/nPH0II16F0B9/fYP7ws0EIjMECR6MMjYL4NsVetywNA/nT
   fSA5iq1FL9gF0eOv+CLrD9kszOfGtN2hO4TJM+FTrzrpG9vzPGSkBr2c1
   rv2N+7WIOUP7y20OkxjhngDUgYh5qZ+bKlT5aV8m133ptfg/hiGZMcsJG
   Nzi8PWlC83NRFOkHRGZu/OqQeyslSwpt/lc8Y1GU7iITsPsKTJnfgrQ+8
   HWC+3AV553ESxMMqSqW99pV37e+gRwizjVQz+0PbVk+EPzcsuEz28RJSa
   Q==;
X-CSE-ConnectionGUID: 41ZOHqvBTzu/cnb2byleBg==
X-CSE-MsgGUID: +AteVdISQTSrrQYuYNQeCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81983487"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="81983487"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 05:08:25 -0800
X-CSE-ConnectionGUID: +MbugtjxQQ2R4HfIDrg5YQ==
X-CSE-MsgGUID: J2cttss6S2yBhLjwylFq2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186446398"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 05:08:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 05:08:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 05:08:24 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 05:08:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbijR83tuP78v5jFI2CiApwnSusrwjwQ4kY5I+wFcz8aDiTXBA+E7pd8PRXhiSdT2UCNDpsCwPG83mKLAP434h3x5fTnlTFAKnOkIJ7VNN1DCjVG1Q2QM1QRfK4UL2J3oKhuc+rLpYykupYZ9g815EbzCm/S0RZZo7TcKAO6mIHxoR4UwdISVAq/GzSWwYukLufDk8FQ37Fq7RYD6r/YUgI+xHW/nhA5IQUInXmGnDihIAudjjfckSzTVeLIJ+1yYvj+B7eJKewhdSneQfj0A3+Y31cMh3NCMF/P/ZEOzKeeaBffMjt61jNrPZ9sb3wH1sq5ehWHgR0n1dQ8jEYqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHIXlQVwix2AWpaohhB5RrIVfR8BFqgEBujHZH7Xt4s=;
 b=Yys7yxDQ47Ufcsjh4MJPhCoCAVfu4xdr+Iji3RmQPpyL1hU9OMC9aY66DoZ/fj2mkl99IsIRVRzqrboee0CaBOvyMlubUEbHZv8TMzI4g7Q4TK8YfItCOwoxeuYsUsQIIpPzwcr9WrWWS3NQRc5hNZvp7QJjEzhwIFdkyF5pXNjhy1Ky2ww3RLbpCQSCtNmrCErZK9B9mLS0q6joL41YABv5+yGjaV/ULtXxPSTGGdJfgJ0UfRf1T9vsYvuFp/oW5tQO0hw3zdcHbrNitJRW1aXQWUsdlEivuwKmFfgvWQbIFk7Cd4INrO+KyvqnUoDGO0podI3cl4Uu0tg0TKVqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA4PR11MB9009.namprd11.prod.outlook.com (2603:10b6:208:56f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:08:20 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 13:08:20 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, "jbaron@akamai.com" <jbaron@akamai.com>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/ie31200: Fix error handling in ie31200_register_mci
Thread-Topic: [PATCH] EDAC/ie31200: Fix error handling in ie31200_register_mci
Thread-Index: AQHcTSmpmIuHMzfXiUaQzhm6w4io0LTidEUw
Date: Tue, 4 Nov 2025 13:08:19 +0000
Message-ID: <CY8PR11MB71348C8D1C35AD7DE3DA63CD89C4A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251104012317.34637-1-make24@iscas.ac.cn>
In-Reply-To: <20251104012317.34637-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA4PR11MB9009:EE_
x-ms-office365-filtering-correlation-id: 0ca43657-71ca-479d-f1d5-08de1ba33a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?09IsBGz+u3YGLwMNQ7g54hFgsBwPaKhS7mirpiytclcXqQh4kHlki8f0LnTw?=
 =?us-ascii?Q?5Arcwa3T5kU31FAcgx8h48X5GI62Ez1yWhwGpulKqR4sfsQb/AgUE05IonpB?=
 =?us-ascii?Q?PvR+ivbgCgqyEt+9KtqHPns7D3AgTsi3QveWouYYnCrA4PvdgD98tvT4r5oF?=
 =?us-ascii?Q?m4dDvyxWG5z0fVpluMklqpMZ3c3SydQj4gV5ZlD96fI5HxbEUXy3cg1gnsXz?=
 =?us-ascii?Q?O+sAvmZ4ez1uU1Z28eR7rKn1W8M5ZCZtEVXZm9ud0kg2v1UQfMYfpI/uknt6?=
 =?us-ascii?Q?BCUf3p1DDJ64Cegrsyp+FNsdZBci3rqNgg/Bage0ILszGEPRdiZOb94HoFZs?=
 =?us-ascii?Q?BVfmWE0orF7dWbn4RcQxrGF8BeRksC9yFa1DRu1N6TbMAvQ3xL2jJ+JOFsTQ?=
 =?us-ascii?Q?RQtsgMwr9CnHZt8Zhhb5pKy53F3Ubnlghe3jcHPQkVxgYmi8ZhmI0ly7wI9W?=
 =?us-ascii?Q?3MDissVaPixIoWPA3lVN0RB3nKJ42jwW+IiIuw2ihLvWzso1AU6zzId6zDSH?=
 =?us-ascii?Q?LAKQZFKzdyWEhedcERzv7ab+/aLNtH+GHvB2Dle59EAcHJb/R8in73Kz/HIb?=
 =?us-ascii?Q?pKylAUtT3UVNhC3AoNCq+EEJReMJZau5Nn6rZ27DeIjfWzXXjZvw2771N4tp?=
 =?us-ascii?Q?eajwM6jioVKIMnsKy1FN5RAvC//+1sH1I+6AjkPdSXrtewFqRS/dq/gRm41J?=
 =?us-ascii?Q?7jFSdd70bKmY52EkD5MrKu8lEatpmLl/4kTi1CDrWdCKfj9WxusvD4KdP/Sm?=
 =?us-ascii?Q?SAysKrTxlEOmUpSRF2zqES7+tEzEoI6ofN66Yv6dTYR93ZdTGgl4kmzKMc24?=
 =?us-ascii?Q?5HGxczShKaYBQz8NqYdZw+frgAeNBGRA5I1q9NfQ0+KPLSnCxobatSNFFQtn?=
 =?us-ascii?Q?JQMVOxEMtBcfK2Sl4vScvrtCzB99Tj/w2cXOyBh0HJI0hM4Igt9tIi/5s8YP?=
 =?us-ascii?Q?DhBgtf97vPJS4PM7gzGSP8YmmrWNiVw/ddKWJ1bNCq3taqs5aCPLVkgab6uy?=
 =?us-ascii?Q?DFrGvRbxGD84hJGDdjK4xMW0/S9vQRetizmAe1UtT6Z22ZVyjw/qVLjeZhe6?=
 =?us-ascii?Q?tqx8nMlbX9hgT6dOnYOF3RSwFMI02/FhAnqxGuL3/TR6vdHf4XtynS76rtDI?=
 =?us-ascii?Q?kCyZUSYpdqYuwIZ+4sVFePgd8dsUheqFXkoxUo//hK55l5seZXkXvQoUrgqH?=
 =?us-ascii?Q?zchslFNTfn5pqosy2GTR/DXLiR5ERdBcXU4rT1hpwifnhu1vsZYoJLDi+3HA?=
 =?us-ascii?Q?aNDcdMEgMNXxd4c+nfU4gTtiAW0qExLVxkJ3VE85+V0j+y9usI3jjEQjGtvB?=
 =?us-ascii?Q?zNSIPxJUDpp5qVJqXfQ/qJSB0MK+Wy9vCSEpxnFjcYmYqbXYctAD7hgBh/4N?=
 =?us-ascii?Q?z9yWLum8E79SC2cLK4evX0Wy0W1865WRpGXdQDLi/DBmzHQ1kc/Cj1b4co/v?=
 =?us-ascii?Q?7nSQG4Sii1TqYPWTKF7BrbFawY3ikCERwe4NH3NtPud7Pitunn/87ul324n9?=
 =?us-ascii?Q?J3DlQNF6oBhkZVkLo4RMj2Ypk4LupAG9In8U?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9zImdvy7nlPZjddW7NGGqQ9EDkW8KPI62EWhbRM7qg+3ULJPFA8s68DJ4oY0?=
 =?us-ascii?Q?PjGb1+O2QN9AsouYG7KXZ6aENt0Y4VYf9G4bafOZsyRwAvGXQ+Tpb/mNQlBb?=
 =?us-ascii?Q?Ke81IfnwplFiPUUX0a0V0mzyezAoulRaU0Uft/5T8whzzeM3gT4rRWoyV36o?=
 =?us-ascii?Q?h2Gk/pHJGwX4BDcREBBPegSVc+d5pmu4rSXKbgJECDIpXXDuHUvFJLvQh/K4?=
 =?us-ascii?Q?kT10M6fS1xfZ20AHE+hG0spD1e21gmmyfO1CSal95+9eqeF0jWQSbgeIZduc?=
 =?us-ascii?Q?ghGuuZ6a/USkMgKFIRnwzIOG+MYTyXVDg2xfpgnc7Cus6ARGx4bd4dFfxl8Q?=
 =?us-ascii?Q?qMBjIYHyLftxo0i+6YU0bSzkt4IYsHgVCwXZ03a7qmvcluVulVFqvV2djohi?=
 =?us-ascii?Q?KB3ioD8epkAcid/gGDvPxULQFyOQQPTPh2zVgGS1/A5e772/jm2SaIALEFLJ?=
 =?us-ascii?Q?8q6bLggrU4745JSmnsHOGKTYCFx12JsVTOzsdoCpqEo4bkln3+hGSuQK6dIR?=
 =?us-ascii?Q?UrNbzGfYorL0szd1L5WFLl4YGQBYDO39WtvbZScF+yX4U7NoA8UXtQDkV0Oj?=
 =?us-ascii?Q?DyKlEHSBk7m+NRc/na6UR7b3XmW8Td4tmnMK9NczpfYX0GRo6ALmrxw4ym0X?=
 =?us-ascii?Q?2m8JbFlCNUwkWD13VQ8O1kbwwQGstgTCR2UB7+LJuhxv9FOJr4/VcsLD7+2z?=
 =?us-ascii?Q?0SBRaNhrqqvS/nKvqEh65t20uDehu4JoxWOjp2/tmih4ZlL1xVpmZdrdceDp?=
 =?us-ascii?Q?PBImK+cPi1aWpykE9Lib5HjCzuZTE9saishJivC70calYGUwdEHcCoAR/Cdn?=
 =?us-ascii?Q?UL5xqdMY4FvsiEV2Frc4iH0sgmyVA/90WH6bTQg6m0kES4SOO+FS+H3c3tgY?=
 =?us-ascii?Q?RIq4y/X3E5i79Qz6FMPePqWKBbuzE6l3vVd7WMtXjaBfJf5EBBOW2PryiqSF?=
 =?us-ascii?Q?E169FU+0Im8+LTrixUHMChvrqjaCOoKIp05jgK7gqkfu7LBgqVGip1Ff6F16?=
 =?us-ascii?Q?vBmNaGkx++U1c+x3mlb066iM18ffbUVHgH2eoUlNd6tx6o0vkxI6lUDWg+ZV?=
 =?us-ascii?Q?dabT7t4Ylt54i4tqk4zIKUYSX01ng2Vu4jmyY8P2MO9f1sLOX7tN81qtNbU5?=
 =?us-ascii?Q?Fj4bd2oWE2JrlyKOD3zDOVBW9UNK5NJDPOfnnrcB0soBNW49981rR35i9DiI?=
 =?us-ascii?Q?md0ReC8Btpp6ggOxaA9x4+urjDy+3BGUwcP6dCl+viQjsbpZpGzo4Mhvh/tR?=
 =?us-ascii?Q?G8UDL29pt9H1NRJRS/N/J6eOcGg0jb0qqyAykFSProm8m5TyHfCAE4t21Rxl?=
 =?us-ascii?Q?mcwm9HMavN4dJ5DyR7mWiwsynvcVnnhk6Zdj8F0DQK2IPSatX5VqTVcciMjA?=
 =?us-ascii?Q?Ob1OajIwaLjoaN2U71GBeRUsFM5Y7HLKSwFmX7+HjGf3KPCj1V09fhYTcVEM?=
 =?us-ascii?Q?QH0rdibbGF8WnAF33Pfi9xW12KlYoEO7i9xUJIHZz1HFcKbyrW0q/dnLiSlY?=
 =?us-ascii?Q?dnEsRk9ZjLAALaP9jXhvY7pB9x8r3yObjk44IWuFtP0ABnlySbZFFlt3jSh6?=
 =?us-ascii?Q?0jgoRm3mgzqMNcuiKAjOmWd2gplHDprCFJXQXph+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca43657-71ca-479d-f1d5-08de1ba33a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 13:08:20.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAH72Gvs2ywq2rTnqZoZ89aBmnx6RxR+2EiCHyt8HcYhV86bQiUmJfUo84GhSMuGYY8SkXPpNgnQfPwTJEmjqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9009
X-OriginatorOrg: intel.com

Hi Ma Ke,

Thanks for this report.

> From: Ma Ke <make24@iscas.ac.cn>
> Sent: Tuesday, November 4, 2025 9:23 AM
> To: jbaron@akamai.com; bp@alien8.de; Luck, Tony <tony.luck@intel.com>;
> Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; akpm@linux-
> foundation.org; Ma Ke <make24@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] EDAC/ie31200: Fix error handling in ie31200_register_mci
>=20
> When mc > 0, ie31200_register_mci() initializes priv->dev but fails to ca=
ll
> put_device() on it in the error path, causing a memory leak. Add proper

edac_mc_free() triggers mci_release(), which eventually frees mci->pvt_info=
,
so there are no memory leaks, and put_device() is NOT needed.

> put_device() call for priv->dev in the error handling path to balance
> device_initialize().
>=20

From the perspective of pairing with device_initialize() for better code re=
adability,=20
then we may add put_device().

> Found by code review.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d0742284ec6d ("EDAC/ie31200: Add Intel Raptor Lake-S SoCs support"=
)

This is not a real bug.=20
No "Fixes" tag needed to avoid unnecessary backporting.

> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/edac/ie31200_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c in=
dex
> 5a080ab65476..a5a4bb24b72a 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -528,6 +528,8 @@ static int ie31200_register_mci(struct pci_dev *pdev,
> struct res_config *cfg, in
>  fail_unmap:
>  	iounmap(window);
>  fail_free:
> +	if (mc > 0)

Since both primary and secondary memory controllers invoke device_initializ=
e(),=20
please remove this "if (mc > 0)" check to call put_device() unconditionally=
 here.

> +		put_device(&priv->dev);
>  	edac_mc_free(mci);
>  	return ret;
>  }

Could you please address the comments above, update the commit messages,
and send v2?

Thanks!
-Qiuxu

