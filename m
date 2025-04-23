Return-Path: <linux-edac+bounces-3674-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E0A9942A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323D81B880F3
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA928DEEF;
	Wed, 23 Apr 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f53/CmVX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4B27B4EE
	for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422696; cv=fail; b=nixijNVlKA3IWzA6QqM7sZv8IFP5u+iHxTQ8N9BcKm2BoftoeaWm4gtD+LeCICflgsKA+zr44usEnKoTC7OjnD3RIwrpslnzNzMJ/pTJj1BM+jyjhK/hAB6HLzJ4PT+WD4YgZQBsR88NFtpTVD7eBLniwOd8MRxAk+tOApNzjW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422696; c=relaxed/simple;
	bh=StzM1OuznNJf/1cRlWcrMwJwZbAYoikxgeYx2Yr517A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I70HGxsBP3puHKtK7Nkdn0jCcrRZK4ySYXTpjQLbtbcjWf9Ee6vsuEzRgsA1ev+Y3ZnSyOISKria6WZ/bv8/5Gta8+BlFx81Djqx5zZWGP+ZthqIMKyZoLmxAx4FepdupKFthrylxE/RX3KLQPmb/20d7klow0y/wrciqPF9sxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f53/CmVX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745422694; x=1776958694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=StzM1OuznNJf/1cRlWcrMwJwZbAYoikxgeYx2Yr517A=;
  b=f53/CmVXxHoSvyXiqvMATGYkuDVYadc484L/9IKkodpp9vQLa8OUdinS
   iYW/uxTGs+sFqbnjlb7FpkBQQHatMltDcjfEk3qp0Pz5w2TwtGToQEpap
   auI46zm3tt3mF8irGyDGukch7TiBhONW1tRQdfZJCVFNNEaGk+G0VHhpL
   cudZAl8Y1siRqpD5/FSZ1WaP7LLdRx8dDVoPA8Rlgl1YYtW4fvLWxxNLI
   VLdBmUsR3bYyNUB1Y0wRhT0C2swE/EGpQB753H77pyqN/7oL2qG/j3AM1
   VB33DEzt6IVer3YxsxmzdjF6FWxdkrsh206ORz709j8FzsjLOnImrdfkR
   A==;
X-CSE-ConnectionGUID: t5Xzg8nJTSaKSo0A345CHQ==
X-CSE-MsgGUID: z67M+KwaQ02hNNkHgX9Kxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50685398"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50685398"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:38:13 -0700
X-CSE-ConnectionGUID: 8epTUO2HQy+MSlRM6LAJgg==
X-CSE-MsgGUID: kN1a+NTVQ0usPmj9NDjN2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132199143"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:38:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 08:38:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 08:38:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 08:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB7+7pwaQYLINKW7quGaPYoI1x8j8ofoPiM9JowECMBNipBevriamhhRLsej6ldA5VdmJ8YVFeK0b81yvNApqyhxLwKweEAfq0VsW45FZeyoX5CSGBhrFKYuqnZzpoi3MszSvpcG5jT/QPwSrP/zXNDPleetqcoF7VejRYIrA2/7scYUnzOk2BFhtJPczv8r/UjeOwISCa4aKn8tOW7irG6EKhJyM0u7oIyJVP0iSfIUFLABtEQjpkCOxr5MmpK4J0hicQbgpx9LOdAn26hs1lIPWJtT2TxCGy938P47LCohZAlhEDnjZQlbdae4pBfFwr/JiYS3b6P2zYffU3EqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMUYigq4XukoXHHSqqFkfNh/c1H/p+IW9+wLIqEsDm4=;
 b=ukQhaj6FRhcDgwOxQJMfKT4A4+YXykEe8O9aLiOdC1pLbV/0BNGxE/F2CUD/WDLqaGtkwJehoHDb4Prn5dIEchVcNP7GqjZPq6pmLBma3ElZVB2ngsxh3O4srWREzbXcDVpjJcp0FnXbUzl/u5O8J8wb2U4aBJHe7N9n2urqgtRXZIOVCotFUMqBahLDobzG4H3YXm3zb3KSxY6OeTMmwQT93E3/5l9GHfnd16SaQBayhJV1go1Z9FHJsMWavMR1ZEGcL/cc+DsgzWLgDo78Z7vTcDLborasWiXlNXrN1FHBdCS9h7/ZQgn1zG5VlbgiseHLn7o1XJZsR0HwIUsJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Wed, 23 Apr
 2025 15:38:07 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 15:38:07 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [bug report] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Topic: [bug report] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Index: AQHbtCgMrDCDe2ufx0quRowENIlKYbOxXheA
Date: Wed, 23 Apr 2025 15:38:07 +0000
Message-ID: <CY8PR11MB7134CE0CA414F81958EB5CEA89BA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aAih0KmEVq7ch6v2@stanley.mountain>
In-Reply-To: <aAih0KmEVq7ch6v2@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tony.luck@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV2PR11MB6069:EE_
x-ms-office365-filtering-correlation-id: a5fff5d2-eb1f-4eba-9811-08dd827cd841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bCJlRnlvhKBNyf2Fo6VFewDk0Vzhkgkw/v1QNwIxQ4RZLJL9FyVkBOgxizAT?=
 =?us-ascii?Q?sqOf4iBhxAmI9EDA0tMqEBgIpAfLe4AMOxz9lGruiYATPjziGhnIaQi2cqXu?=
 =?us-ascii?Q?9K7PB1Dahvka93a1tBq0TCG+x7E0HP9nL64LzAULd4te6AvO6TMUl4dIaKB+?=
 =?us-ascii?Q?Tr5e4j4VC2AxCIOxBYHOcxVVbuyyK86Be/Fzy48ul41CTJLm9oGfMNVHhdyg?=
 =?us-ascii?Q?80nqlNDhY+ADni5dUe/u3JAdGzDWy6FHvGVW/S0sR+Zjdfs5OH0DR+BQphPd?=
 =?us-ascii?Q?wEsK23NR1TL7A6GdmktqqhAjWWg/R1LSdG8Exb0sKF3VU8N4aoYFVLFeUYjB?=
 =?us-ascii?Q?f9j/8mwa3La5vTE9aJHK6BXnBo9tDB8PiATcafRzC2/hSjUtU7N2/C7kmkFY?=
 =?us-ascii?Q?A2Ia1PiTrwXnUNgYw8HAyR9VMaqSILxqz93Ge6fx/TuoUAeZWuDtoT7pO2CT?=
 =?us-ascii?Q?Qx6m3F0mtbDVciXQVlnJj8RBZ9K3Ap/oZUnoZt9lFmBTNdVvy9u9M3ybD64g?=
 =?us-ascii?Q?QBajkGtXTHa9w9g0cdZoNxD///0JH3d/2tQhC/xQci10SzfFBXKJjG7FFohU?=
 =?us-ascii?Q?7E4PYAEYO77esbTb0EasQeIUzuYh2D5B0cNL3Kc8/FVwIsL56A+hL06WDrkb?=
 =?us-ascii?Q?wpOwlqItPF4vepnlXwXeBUfNmHPfIjc/g7EBqbRRxrU/vHrP7HQdFSJ9lDhj?=
 =?us-ascii?Q?9+f5FWoSpKOBC0raDafY5lpjkEEGCDY+eEz7igtL5IkBuDsT6zbnnM9EJe2V?=
 =?us-ascii?Q?llFxG6tI6cxB3BWTVU8nb0cTYPFPJ2Y5xZJL3sU4Z+ArMvAsw2GG3fQjNT1U?=
 =?us-ascii?Q?L95nFeHOP91n5idJLVftEz8/Oj0G+WKDJUP2kV6R72nmUAmhx/k1/BSXLxLX?=
 =?us-ascii?Q?4KCVT9osirEQy/RovjJURRXwBvPTsEQTHZQ+Nj2cn2OC4+8qOIe4sMcGAprf?=
 =?us-ascii?Q?EaDZtdSy5Qqs7E6QWy8eBjnhYEfCjna7Bm5mypouz1ckWz3Zff8jpPx7jY5T?=
 =?us-ascii?Q?GJJqPNJt/hrQduUaTNbRWvAcTmSLVix52JuL3Lt/wSEehHq/MWh5naA/W67+?=
 =?us-ascii?Q?YPmaTfR1N4VJbKgF5CZwfiRToJ4/7sQ9Jr+Y9W1p0Xyb7poUrGtOqvZVbpUu?=
 =?us-ascii?Q?/5h5eMEH7awjFQFSejPJH9fzO7KwGBaqDamxfURIVaPiKi/6e8zLv8LxOaRH?=
 =?us-ascii?Q?EMIm1R/ZBKzzGkBNiVcyPE4V/YOp2TfolA6ZwHvlspD4bBpT3/16hQyNHyM0?=
 =?us-ascii?Q?Gp/CDjTyXI+iRcIb8k7PkM0CNpgOtjz/KaJi9mazVysa6jQ1qR33d/lUWVs6?=
 =?us-ascii?Q?uSmUQ9zc9AXMpYTupR233mI0BiuE1VfOgDjw8wwBSBJl9Nf+m72xzIUlk4z/?=
 =?us-ascii?Q?oj0l+BBrWbzbnLS8aSUwE7mxXe0HCHbu3Q3XseOdY7k7ciyUGESNNUVOmr7J?=
 =?us-ascii?Q?jA4c9ClHk2xnKbYuE+LWByBNC1tMwM/56oGM0bo2Wx6o8CY8VTM9Ey1T3I3O?=
 =?us-ascii?Q?HWso1srO0EygyW8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VPIuR9RC/Z5ARgFYzdBXFRXiS81f2FKv4tlB9mSRGN+xg+ib1u/r7G3ha0eX?=
 =?us-ascii?Q?I3j99AoO3RyNFWpOQZshZeHaykhO8M7Bv/9Uy1lHQsy/kuNkxpuNcNBSvMVG?=
 =?us-ascii?Q?xK2wquLjFFo321JScG7ulJtw7Zs4LhyOGbY/0wsBYZnnrDdlXENFDsXnMAGb?=
 =?us-ascii?Q?4yCtxBfcv+Wg0Wt8cpq48gJLaB8CmY1Mh1L+ubU4ZpWG/bIi+HehMhr8tnPu?=
 =?us-ascii?Q?M5DO/GIJPi2/ne44mKRwYZuj8OGXNW27GH6K5MtLAivxwP34HXOzWXUXug/z?=
 =?us-ascii?Q?TGqAMApVePTnB7YuNUZLeUclVt2E+/w9Lnyikh1S0OqDBJRiSeYnTfT7Sj42?=
 =?us-ascii?Q?gR3wmPNjp9axtESSmaTEmek/M66nY5x+qeIdF7/yab4RU6TUS6mxwVBO6RsO?=
 =?us-ascii?Q?rTD4t8GG50ENzg2ZR6+qCcgm6mNmKiS8yO+2lBrM60Pi5uTgtb+vyqN9o0I4?=
 =?us-ascii?Q?H2BWOgg1qPaasFCChMO984jpxu2AyTTCYUpVBDCpwdCKKi+WWp0JesWf61zC?=
 =?us-ascii?Q?lI6Zct4p7Pym5J+92IQeMgc3fZRyEn7Q/vbNiGVgrEUpgwPmaTYvyWI14uln?=
 =?us-ascii?Q?dMuEBcJfZp00UDuny1GdZ7OGkPqHXR9tKrazdj/aWmL4hPpOcKcMTP7k/wa0?=
 =?us-ascii?Q?f7U1V5083uSh6Earc6lA+bmmEC7Dw7bgC1R/7kZ4XtQh8da2puoLJ/GVxneB?=
 =?us-ascii?Q?pwoX3bbKk+wOGLRG2hrUCqEYFI/ApqGERTq8Xe00XRxlqHxcm45e6HJDw5lJ?=
 =?us-ascii?Q?gP1PkyWIvNJ97scjlAhAfrp98hd5eEzRuavvTQzESwZGn6wqgaD26nPTarXV?=
 =?us-ascii?Q?JxTXI+9I/973loPXkIrgkjMTYgHu6q4lFy/H7d+ysy7xrXLBKYVbAjFzWn6U?=
 =?us-ascii?Q?3BOpnNfzQ81+1v+eB50MvUQ44dr7hvDIUO96cUou9JzNw+Q6yNtOG3DJteWL?=
 =?us-ascii?Q?D3zF/037C64t7Ljn6BWCKEjM1upkM3zf3JmIxFLe5TV2phqn0i9Dellp2haI?=
 =?us-ascii?Q?rkIDtGAoSE6FzT/wgVA5hQxq97XfvL0NcP/kUT7xNo0VFc16SrYGhI40gN5l?=
 =?us-ascii?Q?CdvKR95TbrfcfOCgmqmXtXfumnPqydj2yRZS0QXvHtqlJvkbt3qCR9bFOkEr?=
 =?us-ascii?Q?VUBoxUfYJ6jKSOCeof931swL7sFTx9zpkB9sN82e4yWiJUKY3cfleWNufOAT?=
 =?us-ascii?Q?jjWX3qWR9uR2wXch+PNUZ2rNfqAwMe4irfxAAAi02bovFhBO7ohRqDPUTYs6?=
 =?us-ascii?Q?CmwwveLYBj03KDjWLS4KSEXQSaNeqeNT3eCIgrN5flJS2o51Pibq3yANLhZt?=
 =?us-ascii?Q?xdIWfeD3Xy3KQKsWWlbsr6ADZMLRh1p4KTa58yWoTVg9qUJKZqlTC66dziOU?=
 =?us-ascii?Q?4K8NUKido8ghV2OZYXCXFzLnQ681X7Ur8jgZjhzwAo3jzvqk9Pn+SysNOKc4?=
 =?us-ascii?Q?VJCKMEu/F1DmR4sJgeuMA+e58BLSRlLqJXyYtnJ1qnI9VRSwoIXyTc/T0BMZ?=
 =?us-ascii?Q?NBfFp6orxO9Uk0j0Fp0jRJPWeJbXx7K2HuOMwdF2kmMIbI3OYAQzRZb3rkqT?=
 =?us-ascii?Q?Y1Ly9B5k2h/p/VbRvdxgnJtUMMp2FU9GH5x4BzPp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fff5d2-eb1f-4eba-9811-08dd827cd841
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 15:38:07.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dhITIEr/SU7wewBfoLLyXf+ekU2SNdAqUsENUsqoBEj4DeJ8Ijf6txbfe5jQjO63M29VcsCrucHQIAwMCIFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

Hi Dan,

Thanks for reporting this.

> From: Dan Carpenter <dan.carpenter@linaro.org>
> [...]
> Hello Qiuxu Zhuo,
>=20
> Commit 126168fa2c3e ("EDAC/{skx_common,i10nm}: Refactor
> show_retry_rd_err_log()") from Apr 17, 2025 (linux-next), leads to the
> following Smatch static checker warning:
>=20
> 	drivers/edac/i10nm_base.c:364 show_retry_rd_err_log()
> 	warn: should bitwise negate be 'ullong'?
>=20
> drivers/edac/i10nm_base.c
> [...]
>=20
> status_mask is u32.
>=20
>     331         struct reg_rrl *rrl;
>     332         u64 log, corr;
>=20
> log is a u64.
>=20
> [...]
>     362                         /* Clear RRL status if RRL in Linux contr=
ol mode. */
>     363                         if (retry_rd_err_log =3D=3D 2 && !j && (l=
og & status_mask))
> --> 364                                 write_imc_reg(imc, ch, offset, wi=
dth, log &
> ~status_mask);
>=20
> This will clear the high 32 bits of log.

It's OK to clear the high 32 bits of 'log', as we only write the low 32 bit=
s of 'log' to
the 1st RRL register, which is a u32 type.=20

To improve code sanity, it might be worthwhile to create a patch that chang=
es=20
'status_mask' to a u64 type. @Luck, Tony, should I create a fix patch on to=
p of the
current patch series to fix this warning?

Thanks!
-Qiuxu

