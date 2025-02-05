Return-Path: <linux-edac+bounces-2967-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C558A289CB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Feb 2025 13:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F95E7A16D9
	for <lists+linux-edac@lfdr.de>; Wed,  5 Feb 2025 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D521D595;
	Wed,  5 Feb 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hB2MkDWU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBE151986;
	Wed,  5 Feb 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756860; cv=fail; b=siThSR7HtlkWfJ4Vx7kO4dXCAVRo9NdEHhHoXxPRvmI+/Gt47QRxy71tV5HYuWSJK0IZdeCWa/yiDxufyCB9fA7Vl5InCSfQQ6co+pdl8z0gSPaWeaCk6WVpE5obw4nH88Twywc8IrLy9ErRRtrs2EPbsSVqHVwDGs0hO1cv4hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756860; c=relaxed/simple;
	bh=tkrJaCWjwsjXI/cIA4nUFakAYvIcIyeqPX/2KGAbb40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f3+SQrG56JqsEA1QmZFCgEyxIYzf+Uy15n8i0m7IgHjC91urchBVH+Xdne4BJbgMvr0P2lyPG8LpeJN2a6p9g6rkFPXusL7ayq8itdI/FqyoSHeZ/+Fob5qqY1xmbz+QivhmCT3quJ5I1VFgCwPLTee3CDDZUaGO+VbJTlIbv0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hB2MkDWU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738756859; x=1770292859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tkrJaCWjwsjXI/cIA4nUFakAYvIcIyeqPX/2KGAbb40=;
  b=hB2MkDWULst9LBSUy5iueUtz7lFM2SaKjLzvGhTkVlCXCwDYUlwRe/Yf
   QWqHWtjNkBq562Ag+ud4vLuqvnOYYPGtiXMB90lo0RH8kdigCj8Xkom2j
   yRoLpw1xu2TU/cJH7U1wFwVi0YOASv40/ZuvLPQPzuR//3k0bXKxBwtD5
   Ql7v26ssRoSJ9+yV5QmXfg75tSO9yUpJP9uY+LJX+vR3VWjk1hcRe2a6A
   VsNf7ou9hkGvJzF23i7xVTwETOu2DE9Cn6uRxwAyvwu7v1hhYyYMgcLQT
   rwcJPhr9gYszvscMkOl3AehBSx2wYbNeGZx7/Il6K/XcTyzVHauKRIaL2
   A==;
X-CSE-ConnectionGUID: SkTyWwugRKexlyrScSXaRA==
X-CSE-MsgGUID: pJK2By1CS/aKcElHWkTmRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39582911"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39582911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:00:53 -0800
X-CSE-ConnectionGUID: g+TYB1HhS42oqQ/Q0sU10A==
X-CSE-MsgGUID: xonKn630QaKXDqPTWObM6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110733719"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 04:00:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 04:00:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 04:00:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 04:00:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9Y/sOLGLRmR1cC1p/B+lnXQbENPvnfJJiv28EIEbP4hcPqG0IXkZVP4J/ojwMscgmqxrQdXqbVOMwSstZYwKKNQ4/6Homw6P5og7oAuxeu2RW2DUuKSVGnsG6Y4Bq9oYOMvg8M5lumx8ESlxwp/66MfC3bwE0xpOD4+y/268W2nj644nQp2TS2mcc7/9tHN9GyCkVkAQPYN3JfMnYk/HrtzSvNI6CPXikgyc+SmQ/HqzSS9Dz+eFxH5ssI+fUxX+ngNW7Ne01YrEWhyT+J1Totjw5nh0ywfcMUuk28uEiKx2C2Dx5j2h2griMG7GbARz+9NjLAAAq02gP0rLaBTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7tplkOZlNSNjKQEoj8Pg8sgxBfQ6WqWgMXga2hz4CU=;
 b=St8p5kUvqCfP3EcvTWF07egcWKfyhek0vVHSaETEfDyj/CtD3nhipdjZTWlv1x6A+vixTlUWRK3BtrxcGgZRxVUVA3CQmPWcs7fCN8C5IAKMVrNmsT7fc/a7gYJ05nhJKxLKc1q7XFb7ppQZlr+QjFdbSb4fciYY7o0ZCuniOD39/JTWdmhPuYY2S9XNVVUUqZ0rsPz0RWkibRx5xeJDDt5pF1Q++p+xbDyjyJ4KeVRByLsHMP469iwxbfL+VlUcJxYDT9VD3CG6XRXk1oKmrT6XSVOv5X8iuyxU5pEJkYS2Jp4WeXFLbBLxPrRrdzTDc2sEefXjP8jCl4Ww949rRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 12:00:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 12:00:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, "Luck, Tony"
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC: Simplify return statement in dct_ecc_enabled()
Thread-Topic: [PATCH] EDAC: Simplify return statement in dct_ecc_enabled()
Thread-Index: AQHbdKrKacEMiqdgt0yjuwQETRxmC7M4oJkA
Date: Wed, 5 Feb 2025 12:00:42 +0000
Message-ID: <CY8PR11MB7134F69FBDBC05FEC0C4815089F72@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250201130953.1377-2-thorsten.blum@linux.dev>
In-Reply-To: <20250201130953.1377-2-thorsten.blum@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB8596:EE_
x-ms-office365-filtering-correlation-id: 1a7e0c74-37af-4079-5215-08dd45dcb776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3rt7VeMMqrO8SYIyEQDkg587Th6KD7FLI2e7/LnysnA1t/KnL3Mk63L8yrXK?=
 =?us-ascii?Q?yJpJd23LuiDQokXUvHSvgWQbvNtT8S1tUwUyppvvjAo9/hrLXrH2/h9K2qEv?=
 =?us-ascii?Q?yZrIlCGSmGDVSV3uuTmk/sZ6d7Zrey28gFj5lMdT+1RQWLnk9699ky+DK6K5?=
 =?us-ascii?Q?kXhCwE0ZJqYqF88VMOmj3acd1X8teKPd/WELUhut0iGExEFKDuMY2l4jHhLC?=
 =?us-ascii?Q?JRORbnT1mWKJWEISHbdLnQSpUUxbWVmpYavRfO/qdhggSscPhuMvl9D0tTGc?=
 =?us-ascii?Q?u6VlQuGLyBneY3q76/VfvNLbNOWbwH9ufqlW5KeZLkyN2ePj+sQw1LGUSIi9?=
 =?us-ascii?Q?YjuSwGjhKFnwboQsDxuYmNEMCWxleV9reIUdHF/04tjfd9m/pYgyvDfHK0p0?=
 =?us-ascii?Q?UrQwA1JTF7b1E3BEwIG6SEZwC2h8ejMb5xljm0F5irGzNuxKgbi8tMNEx3uf?=
 =?us-ascii?Q?mBqcQZ/TC+JjGFm18EFqFROFnkpLD4XBNjKneVGfDKHPokqRp43eCvpL02yb?=
 =?us-ascii?Q?zqDf7Q5LNIFNeZUMoFxHGOFib5GL65r32eSfvGL1mQ46s2c8rP68E3RBUhea?=
 =?us-ascii?Q?/Xseh5uiO/Qsb2vrUXw4rRZ9Plxo/+D7JOU2wD+cO1oV9Ylxgpqlkv8hzo98?=
 =?us-ascii?Q?qf3pCTXv3uoeG8tPfjqdx3eDi6mR5ec6uUPa3AmMBkTDsVqlqLvzKmVa9Ib4?=
 =?us-ascii?Q?E8CVMdxBo0YDxDREU1W7o242CEF62cgl25ld3CInqTj1KYRMFRER/EhpaszC?=
 =?us-ascii?Q?Cz1VDlAP/WnM+raEK74xPz2OPOBO36SuUu1l2OLrJ7cLlps12drZGdUDj4Nz?=
 =?us-ascii?Q?rjjND6d3Q4TgEzTYRCvaNtZMZ6Tl9xsJ6uIM6HvvbxHiVOBAvZ6jLagwYb2n?=
 =?us-ascii?Q?a5CAn/fixJiJLYfqqN9a8uBLGGuiWIA9LuLxXKLdAlQ1betFUqoFMdI9vLHb?=
 =?us-ascii?Q?OXDqWXCRQ0mU9iVsEKelqZ7x49R2mIP35pWNWP15K6lEMg7QKtyCA1Thbxa2?=
 =?us-ascii?Q?AfZUH7QbBnBlJCI1rPNLri0WhSRC/zGlIgXFoIOsgNeUJmQz7Mm8vy0Hd9ty?=
 =?us-ascii?Q?ilGmYuqUAkq7AdP7ofAJSs6ph57lXvSk9fxmg+EuWfURSCn2yAlklhapHq91?=
 =?us-ascii?Q?W9k9w+r7+mMNQKybNaJiNx8pFnHU5pAZeMm5gKcJBuI4+egrkhKs5Zv+jIKi?=
 =?us-ascii?Q?unB9l1vdh5jSJnu3kl+SCYQY3Dtzaz3unR+9vnNVWjCDK0luOzCtFxbBGQnz?=
 =?us-ascii?Q?nhnC/cuK/hXcYRtX78B/9uOMywYzHUjzU0HU3zcgO4Cg2ZCLaJaVKC7Iu/gk?=
 =?us-ascii?Q?62+MXgDBACjczRYbtmrInndhNC9ymI8YhOgMrJqHkoG9sVZK5uOljRnXyLQs?=
 =?us-ascii?Q?VqvqOO7kyQiJQhnkSrjknGYG1C6ccgxQN8rZDNGfY1ySe0Yof7r8oYUkSOVo?=
 =?us-ascii?Q?9wWmJmwBW+FclTr4keqSrxD2Vrnx/0jW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q0WE7YTX7KP3mFEDfsG5O4by3g29MqGzEM+sRqwpgvMAKt0kEP5VHehD4GPm?=
 =?us-ascii?Q?H+qq+HppsxC597YeM+BafVNnf6c16jd6FXsTOWD/RGqDz1uRISOBtVwDQ3ZV?=
 =?us-ascii?Q?j7H5zysjChW/2ShZG9UTIbWeB2n3dwriOdaFyFkHMEeeoredL8/eD1VBx73N?=
 =?us-ascii?Q?oZ79RBQgP8G5stnJI7rJCZtCmdyEM/PMBmnI19tuEjZrU7efvzSRECkA6Yns?=
 =?us-ascii?Q?YgQesDlOQnUpmANYjmfOnDY/pyRTAh3Wj3K/1R9RAP+zGIWbhpRo+BlFfBHA?=
 =?us-ascii?Q?XHihpb97mo/WX8Rlb2izo2NXAHmidGDhEIJE0ulKI5SUGfAjgD5hxECkOQY6?=
 =?us-ascii?Q?MvY7Zfwg6ldFx4Fbxlki+vnAN5o7Gw9jKK4eHYvPUSSQZX6tZM6KZ/3EshbS?=
 =?us-ascii?Q?Ap81cYazBMd3vNYt/vRSObXm3fZcv5AL5/8KrhBJvLqW4Fbmc8qsI3EMFZND?=
 =?us-ascii?Q?dF7ELwQ2DiItiLgmtbfTU18yGdP6FAdkFNBtxgbQVjrex/uFmEZ6oHyuWKxQ?=
 =?us-ascii?Q?UMbvObXAhO7I/Ypn6jPHizE6EH4W6YVnbf4gTemjDYJHcwJKzjtnlpTuadda?=
 =?us-ascii?Q?qABYaJ3dVotvJf2jBp2j7jmPWo8vBI+nf/+81VuE/+AePcXAAHJbNpwQC4sN?=
 =?us-ascii?Q?xpA4xvnl7XGSlyaFBB90dG4f/3voi2EEnmYrHdkRfCv6muAcfDD11BmptnOw?=
 =?us-ascii?Q?m5+IgwQlKHeuvCLB1cmEcuYTL6pVt0VJecdfHSwopeHj+DeP2/NoZ/CmxSDM?=
 =?us-ascii?Q?UaJo5vd87rC/534SPIBfu4VVkYEpv7LB0ZSjM12ln+giFStPx7FGZAPzej72?=
 =?us-ascii?Q?w1gujqAd5kqSHMqdrkH24dvdjRX1nE26o5sWIOBwN3+JqEYOwb3zeGdpGrxv?=
 =?us-ascii?Q?rJ/RzuVyC0b+GSacYjN2K/Yw3w3A+qYDOb07zl5Ds1nmCKa9j4Fiq8y8RBES?=
 =?us-ascii?Q?X8H4D2BF9qVMqWtBAD7sVhToKFlIRJw3x0EEgap3iBsKbxlMDoNP2g/110dy?=
 =?us-ascii?Q?Zl7/oSys30ah7d2Z9glB54VMJj9pu5br+QD5ebTSMBK4FroL5+2GO9ocOyRL?=
 =?us-ascii?Q?+hrwT45LqLSVkBBnuqyHCFDtlbB+VirYeCFka/eRde5yjXORJVdu3JpVyyei?=
 =?us-ascii?Q?HJBiRZYDMU+G2gSoBcvLgybg7J/bs5uh1n2Bl+sW8WjuPEo2hBIW3lgOvP38?=
 =?us-ascii?Q?K5yC5DeoI+yQ7W45Xqen9YuBp9P470zbDqF32l/ElqzH5FWVLkk0s/gFcm7H?=
 =?us-ascii?Q?TzMboGPmDCU8XNyVazeHEWEiBi/32tXyQVs3UNZHGpVyLqgHDZCL/l0elw1J?=
 =?us-ascii?Q?3y0xX8CjfMdRSytj8RVru/hqYOr93leubnkOs3feXq/p9g3c+NsRv57ZDLVV?=
 =?us-ascii?Q?8TtLOVPXch2+LZyY2kXmvI1yQ1LtNAcLsnK0vE0EJ3HwqB9fxPw7+OD02SUK?=
 =?us-ascii?Q?MmDQybgVeYbpmyZbSeWM0JBpphoDHEhSGTnLENuco2ni2wGy4L3Xf+hFL9X8?=
 =?us-ascii?Q?KWFLo95pzdz+cRZ2EQ5yhmw+95APb1Ih7d30Sa77OOJT67fl+fRtr3cO499p?=
 =?us-ascii?Q?akuhapffYKaUFQ/DXj4f2VI9A8SxcDG65uZDLMyN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7e0c74-37af-4079-5215-08dd45dcb776
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 12:00:42.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ7VP1XFBcnmhzryN4b9DZw/NxKvm5T04xSlEmChUr8AdbQHLRtA8xyIxtDMVY5ubbJukrOcnFwJ7j9NPKne7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com

> From: Thorsten Blum <thorsten.blum@linux.dev>
> [...]
> Subject: [PATCH] EDAC: Simplify return statement in dct_ecc_enabled()
>=20
> Simplify the return statement to improve the code's readability.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/edac/amd64_edac.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c index
> 8414ceb43e4a..1f106b4fafdf 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3355,10 +3355,7 @@ static bool dct_ecc_enabled(struct amd64_pvt
> *pvt)
>=20
>  	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" :
> "disabled"));
>=20
> -	if (!ecc_en || !nb_mce_en)
> -		return false;
> -	else
> -		return true;
> +	return ecc_en && nb_mce_en;
>  }

LGTM. Thanks!

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

