Return-Path: <linux-edac+bounces-5325-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C59C317C4
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D5BD3415D6
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD612EBDCB;
	Tue,  4 Nov 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXgSQAJA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EC2FB63A;
	Tue,  4 Nov 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266160; cv=fail; b=D5Z091VlZpija7NEOn7jHqqlovFub7i1ZhQj4CExAMGQbDsDBd66nQew4EdZkTYqlKSVkRDvbEQ0G5fkLcJCwKBVePs81TVbur5xNkQz/r8DRXUgvZyjMrZmi9xKbo56igqV9lo2jtMNhBXf9lLRDnNpdNxB4l9F8KW2t6M7YTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266160; c=relaxed/simple;
	bh=d1FqzFJSlt8XNmDzdPz+no4Q5vTHLwK6ygRb4VpEmT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLcEA63dnCtP3Ak+vSky4nVZWKcC6xDspcZOPoHerFyJSxJF3IrBBOiVjf+llrF3VV9uZB9o8oKWeLqkMPln/7dN3EL5hLptGaX/Q1W1xkMMaLmaPaxIbXdEt4lC7Th+Db46VeW9tXYfUS1j9FJRXQ5+God+nURoLwJ0CJ3JFBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXgSQAJA; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762266158; x=1793802158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1FqzFJSlt8XNmDzdPz+no4Q5vTHLwK6ygRb4VpEmT0=;
  b=JXgSQAJAhrDQQhrDVlpxX5Rjp1CvhKGqSC7l10mgN46TSN2rUsWho9kA
   wj0eEIQnWVWYBS+sE1314uHLQOXs6BtXB0FwimGtER2NvEzHjg/BzxSZU
   HXSZMlAu2JwLdWAbw2uFmA4F086OSMkISpiDf1cDxzudvC6nKFsT4bnaN
   BMMOFy4ZfPaZ8a4gB4+7J2XCsmPbUXtWhdyuq4lI3j5mky1ZYCp6FrYRk
   YAoulWWaehNakXhWY1kLKd4hKbvA1Udr3F1oX9BWvD6IpP2ixkfM/qYeZ
   R12Hohu1yulh1kVWjQtlKUR3cSus6IbehrDxvGSJem2fzkEw3z89PZ/dK
   g==;
X-CSE-ConnectionGUID: paB/qgWhTtSmcfa+UyusvA==
X-CSE-MsgGUID: itNWdwSzRHSBpVwNkVvfQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64398679"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64398679"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 06:22:37 -0800
X-CSE-ConnectionGUID: +/PIIlL0T9yTQIAcLI7d1A==
X-CSE-MsgGUID: l6nXTycCTU2lHLaxK1x9OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191522683"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 06:22:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:22:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 06:22:37 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:22:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJYZMQcd+xjw1wu2lrtEIlVAsC+vhKFR0KbKiQy9kfTUBcA6mN+eX1+Oq9tY/Dz30zJvgjPl22uxN6XjMHRvk/xyr0ozvdTqJ6ztT0edKK1mv+5bZSz1UJMKSFZ3WgiNaE9zSqumyWem65tK3xV0YAusb/m3sunsNaGfeDMA86QD25iaCUOgcP+Lq+Slm/XUwJek4+xf+6rXW9YDBxmcJv/KSXMUeccX5Pma/yfAgwMJrUt7CMBId1eYyabABj4a1k6Xw4HOlkn5DhYkNnSheveheKbQXCEdzspdcQWWRPbvCtet7z6tDP+XVR2rLx2/gX58P7Ya6WnuEtpD+qOgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNWpPdqO37c+VYgxQlRG2COpbO+G/70qz7BSI7CT1zA=;
 b=bK1Tu/fDhWFq0QQYE20MLektgsLMQKZ8OhPhG/Wa5q8GPKvjzWVSrtML8AkE5+pUHhRoZxIxqoMvlKijG8/C/Ka99QdrwdJeTUOugrsP4KgtCwd8dekDrtU8KPY0AXygBorTrbjF54+4IEtqdwsT99cngZN1/incr08th+Po41nhCLswDAuirPjCeedPOBt8K5zcX6UbKAibZsnRfqFqEqpUzubX+gv0K8Z3FGjABO2VVsD740Tnh+2TG6MCwLHBvXFdU35wuVRlNOhXeRlRQP0GfLq09bhQhrKGqCLyHigkCtoHQNuXFUo/cb0Nob5Op6wXJwoKVbdvLtIK9tzK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4617.namprd11.prod.outlook.com (2603:10b6:303:59::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:22:35 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 14:22:34 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/igen6: Fix error handling in igen6_edac driver
Thread-Topic: [PATCH] EDAC/igen6: Fix error handling in igen6_edac driver
Thread-Index: AQHcTL8FvQs8WpIPt0eT1P7PC+N637TihV2w
Date: Tue, 4 Nov 2025 14:22:34 +0000
Message-ID: <CY8PR11MB71347E33FB63F294BBC3F4CC89C4A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251103123948.23701-1-make24@iscas.ac.cn>
In-Reply-To: <20251103123948.23701-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4617:EE_
x-ms-office365-filtering-correlation-id: 7e225f55-3c00-4c20-78b6-08de1bad9959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?0xIYh5VAvekKHT/WJWLcLmLWv55o5LElzpQLAhgcz8F4yWVf6xy4gAvGgDLG?=
 =?us-ascii?Q?DQ+Eeac9s4H/Hm3ngpykUEH5SZPW4YE1LPnZre/AA67JUrzd+sQXdV9Ydrd6?=
 =?us-ascii?Q?WylgRrugsjTjeWP7d29Vpcqs0gGfWGbivg2TKC4rJCeQ/NMyRm9q3Q3cPg9z?=
 =?us-ascii?Q?+J4SB6ClNrZHLMV9NoWRM9SRgOIMvDVSr4Ig+tWR5x/fMkWzB0l9U4+Zuxrv?=
 =?us-ascii?Q?h6bt9xCuYcnuCQD3w3kkca8G/b/hD3R9tb5kiqgVeSWM6GNWu7KDScB8Bbqq?=
 =?us-ascii?Q?mOBNmU7dA82GCV1idQ6X562rssy3vbYw9a3utgHOTTo4m/P78Z8SDRi4M1wW?=
 =?us-ascii?Q?vEZATBTZUul5Emp+f7bydn9EQxNEvWM5riY5DDXYZB7YZ0MdDjO1IeCw8IEi?=
 =?us-ascii?Q?5DEMsgN96GMSuzyOcXxgI/wy8+//IEEpnDKfSeyLO36BA/6RK3bunRd9ArKo?=
 =?us-ascii?Q?FA7ouTmUjI4qxxEPGOLl5Eb/jbjFBxz/W5faQIUgvqOTPJ9yLQ+PYlYUPCnp?=
 =?us-ascii?Q?QwiAfp9f4utwdzk0crboj+JHbLLKi7ujbr51yBxRwX5GMSo3i1b7K2A5L2+4?=
 =?us-ascii?Q?LT5CoSHPhbUHtCTLt6EN2v5mGjQz4MYnc/NXAuC9uf0KfjSVHVHfhFp8mAyL?=
 =?us-ascii?Q?r8GOXqwvGBKs6wctoc9pkRsxHBs6EchGGTxEBah81/qt8Kz+37ZLPcpcSME6?=
 =?us-ascii?Q?YSdAWOy5Jr98JyB3KQSEskHIOtpsbY6U5V0kanQ/baUvx74GEWCoEaBOjcOD?=
 =?us-ascii?Q?3S8Wsvf6lJ4M12ZjyKEBd+Vd5DFclgfLI4HFSYItPs0noFsZo7n0GO3CJ/j4?=
 =?us-ascii?Q?pPcmmYdzJWLA7f+AGFo+bA8njRKFRd2asjm4AFpOtnoJ1gcxZzGMTBRTFFax?=
 =?us-ascii?Q?0gKbjq9llEQjiCk5wYlpyGl37S/qRBIuGcJ6tb5XIkm886uMW3LSvd2jVYl3?=
 =?us-ascii?Q?KiZZriLzECfP+inWne564RuDtc+YSmq6CrZj+eFx0PbDINGgQ80WfeFXVybp?=
 =?us-ascii?Q?uQv6fPUPOricBkg9EmkRgPMBf/oxj0N631xId2B7thK1mRKSZYll0Byd2EZ/?=
 =?us-ascii?Q?5+z4prW1PdFlTJXrHLRjK2XwH7EWRE4NqpjuuvqWWVY7o1KlCdgQFRBKOvdX?=
 =?us-ascii?Q?H2uQfgG8/KQcn14x7krmQwWDu/WnEZjrtda/k3/BFedc1VK/p3mP+FZQIvdF?=
 =?us-ascii?Q?N3rk0YknFYluhF/viniIevNtcKUoCvQNhLjsWqDMGICtMCC3FjeRKOXxrlMN?=
 =?us-ascii?Q?knJooWybrAHZj9IR3vHYn5APpgdHEvLjmBfBu4UPrXFw5hlJiO8Ywh7/0w1t?=
 =?us-ascii?Q?/WWkEY+lkzUwb6qd68OLvdZr2hJ5A79RBmZFla774BWLfZ9/Gc7d52tHE8tK?=
 =?us-ascii?Q?GF1ElRhnniM8Ekt55WVnxyM4mhMrDQxC9sRCImbrUnTAU0h9KjcLrXcpqeM7?=
 =?us-ascii?Q?gwmf9tbQvIlxNM/PguEiYtnqM20MCYHN0qgUslDXeZN6hLbg7fXbTrAExVJ/?=
 =?us-ascii?Q?sUYMGR84Z+wRTYTDN7NEoeiDa63fm0RG8/QB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v0sw0SGwoDH2Zr9SgXi5UWfWiO6EXocr/hWmX4QDty//CGTMplOyEZ8LVrnU?=
 =?us-ascii?Q?4q0y2oclHi6SJD6qClqYR15pUoXNwRYHsrhvOEVsH9KYQAm8AWmaVf0uSaT4?=
 =?us-ascii?Q?xGOGMG9iucqCngeVg0UrolpIZnFdSLiYpmZDESTkeJAzXFyR5l1Agh3D/Kym?=
 =?us-ascii?Q?GldQNrCr1xH/ZJ/nLbRfQ8Iu6C6fWn9nQS/NByhwS4vPb6ZcZ9X8XvX448+6?=
 =?us-ascii?Q?EAiBD8V5l3I3jDlGgvkxcoDJhaBJ3JvFConPy59KV3BXCOSsaScMznxBhhX4?=
 =?us-ascii?Q?sc8FmOs6ubRt6EExNJpejF/0pfiPdlw14sbM0NVvGn/jJWo4KEnQ3rZFAKJn?=
 =?us-ascii?Q?FEX8RxoPYUSfsNJXYGbVXea4JWHqJH68/v9vuGc1c+o1pVX0pftLyrn/ZhgL?=
 =?us-ascii?Q?fMAghvEuU1AMV5OgHGE6nHUYCvIidN3OJh3iwKn++ith/sbArvJfFAxuFLpr?=
 =?us-ascii?Q?+WiFnIcHHuLHPcWlxdysJVfwznrsUt32IWT0x9sokILYLY1DqfcAwzhn08BK?=
 =?us-ascii?Q?qDsMP0EaqdOxFgyMAd6IhSlOeyvvIttO56l13CtbEJBrwVOk7b5NMShgmQLz?=
 =?us-ascii?Q?b1an53PGjbe6/kSTk9GyHjm3VcMNGbqyx7WBEK1ZexNITSc7vSU/fbdNtvys?=
 =?us-ascii?Q?/tVLZFbY8CpXhmGv3oytk84bXSJzYkVbit22GkJof1ASI73JKcAOUaR9ZxjX?=
 =?us-ascii?Q?7iTFq4BSXTgKoW2EyRiAV24JEp6m5mfPpRmQ5uc/B/jhNl9oJFrV2MBRZJz9?=
 =?us-ascii?Q?vqO6Mb8I7ZnVzaZ/X2Y/JvgyjTgBbSvM706Vb4PsE6HofL6HbKr5UoSnt6R9?=
 =?us-ascii?Q?vkdQZOHkwu81sMMVCu/s2OjpnoWFiI0R8adfdUdQHzMakgesLDKBIGvoWMtR?=
 =?us-ascii?Q?k6H/L53Ot3HdIn0ukbCD+9/fwNWzfAY5FzCjLNuWpq9uov70uo32RndmdFuW?=
 =?us-ascii?Q?be0iixwp5Oi9v/uPJ++jJREese/eqL6HpubIY7IGJPTKgYnVzWTDqvohlxwM?=
 =?us-ascii?Q?jl8Xip5ahLsvTGi1LiRiC7/4c8r4iMSQAbfFhtqcs0aW5MnuyPr5Ub+xlKi/?=
 =?us-ascii?Q?JbHJ2eWKGIvTIQ+GWU7ffi9DnC8pHd9JcFOXmLO65aL2JAMIohQCrGXWQ9+a?=
 =?us-ascii?Q?dmH59IqXo6X5CgUTOOnfw3GQLbcanfxDxr44eD0pdWHlODV0CFAe+jrxCYzi?=
 =?us-ascii?Q?/1Ai/HrVgnDTBiO7PXbUy80PrHFhJxmcA1nU5IZaCwnVlBZ9SYcCxWiM5/qG?=
 =?us-ascii?Q?FwYOhVWR94PLV7NnBJNmEzQBgG7rmx2Ztgj2bhLjrnXhQSdfVglVE8zjed51?=
 =?us-ascii?Q?uvuwA9v1vnDj8R/3cbjR4LehGD40StgzHdeOw8aKqKe1eqijgFO+qwfx0FId?=
 =?us-ascii?Q?2GgzOx7tikBrTxMQBdli7644olvDdBhbLo2zw+DWttkIEUjnTXQtGSFWOwY7?=
 =?us-ascii?Q?NtuHB+zDeu3zt9aAXqL62JSOrbOtTzkMeXLRY4mjHS5O9TNv0uYmwahBRHH4?=
 =?us-ascii?Q?+OhrYbCrtAsElh53ZZwCaLR4r5N9hBkZs2SoceKFf0/lctiyc2gebHfmt0ZM?=
 =?us-ascii?Q?SygeDG+dvWxX6p/whPoYB6rawW9Pd1cM0PKdI0TQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e225f55-3c00-4c20-78b6-08de1bad9959
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:22:34.8706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5TlVIXjiHEByRzlTS8bSiQ99JEgKUAnyfvXZcFgASct4WaoTgyqg8mHMf8SxsjYu0QtORNFLx0WFe8L6NUyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4617
X-OriginatorOrg: intel.com

Hi Ma Ke,

> From: Ma Ke <make24@iscas.ac.cn>
> Sent: Monday, November 3, 2025 8:40 PM
> To: Luck, Tony <tony.luck@intel.com>; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>;
> bp@alien8.de
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; akpm@linux-
> foundation.org; Ma Ke <make24@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] EDAC/igen6: Fix error handling in igen6_edac driver
>=20
> The igen6_edac driver fails to release reference for non-primary memory
> controllers during both error handling and normal shutdown.
> After device_initialize() is called in igen6_register_mci(), missing
> put_device() calls in error paths and igen6_unregister_mcis() cause refer=
ence
> count leaks, resulting in memory leaks and improper device cleanup.
>

If igen6_register_mci()fails, kfree(igen6_pvt) is called, and then imc->dev=
 is eventually released.=20
So there are no memory leaks, and put_device() is not needed.=20

But from the perspective of pairing with device_initialize() for better cod=
e readability,=20
then we may add put_device().
=20
> Found by code review.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs u=
sing

This is NOT a real bug.
Please don't add this "Fixes" tag in v2 to avoid unnecessary backporting.

> IBECC")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/edac/igen6_edac.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c index
> 2fc59f9eed69..ee2f00b204bb 100644
> --- a/drivers/edac/igen6_edac.c
> +++ b/drivers/edac/igen6_edac.c
> @@ -1300,6 +1300,8 @@ static int igen6_register_mci(int mc, void __iomem
> *window, struct pci_dev *pdev
>  	imc->mci =3D mci;
>  	return 0;
>  fail3:
> +	if (mc !=3D 0)

Since all memory controllers call device_initialize(),=20
please remove "if (mc !=3D 0)" for unconditionally calls put_device().

> +		put_device(&imc->dev);
>  	mci->pvt_info =3D NULL;
>  	kfree(mci->ctl_name);
>  fail2:
> @@ -1326,6 +1328,8 @@ static void igen6_unregister_mcis(void)
>  		kfree(mci->ctl_name);
>  		mci->pvt_info =3D NULL;
>  		edac_mc_free(mci);
> +		if (imc->mc !=3D 0)

Same as above, remove this "if()" check.

> +			put_device(&imc->dev);
>  		iounmap(imc->window);
>  	}
>  }

Could you please address the comments above, update the commit messages,
and send v2?

Thanks!
-Qiuxu

