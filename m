Return-Path: <linux-edac+bounces-1837-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18C972915
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 07:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2635E2859CB
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 05:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD9170A1B;
	Tue, 10 Sep 2024 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPWbkRqN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0D14A088;
	Tue, 10 Sep 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947788; cv=fail; b=M6tV9BhpfeCbuhHM1xtYPlVmHULQs0m2WTaE/3aRx+M96qnBlpZ4tsTgYmLwwm9QG9RInL7F2kseGFFFO++PTb2FTPrkzEkTyndUCLP/m/NFr0Wg2DSD5Z/c65oZ5Ww5NqHEVmQW9iFC7iz3DeuBbAmbfvwY7HgXSyb6Rht9DN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947788; c=relaxed/simple;
	bh=+isKga3gN5p6y609C79No9QHHGvEkP/kpRi8kAHuzPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=igz0aov9p0UbsDGFFDX70QCq3YEGeI8LGGzl0Bkt+6KFeoXevcv0fF90jvjIH6FRbnNwPK0KRRsnN1wSO0xg9pChT1jec63TWwBKlIs5e+XhRCbq1xsGQ6J4nP0Gsfn03ihfQy2FTakfnX/dh2eIUFdWjPrfhT793N0w2xPaeH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPWbkRqN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725947787; x=1757483787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+isKga3gN5p6y609C79No9QHHGvEkP/kpRi8kAHuzPM=;
  b=YPWbkRqNuWlti6pyZjdrqgBROj6QMcNwjBj3O92GSmgTwIpG46JT3MSv
   n22/89SY5sYzyx4ovQjXJB0CeVYJxWhA7nINyMCZslWkAgGYYHdESaZtu
   vEdYE8PW2i7WSC9F0igUpqgCM7o8UhtdONohJp74Q0+TGAQbXfVnZEqn8
   Vmt2X7V8Nm9KuN+nFvcVz9n0C3aVhxs/T744tAK/VR8uXwWOA6j5J4hLH
   VIeFTv0HpmMoA+oqgQC7hwJFYxJiXAWCgS1BSYqzvd6ENMIKeZr/8zXNS
   jiDAyvdss6PYA29C5xQfV2Pw93h7w9dgGm3rkcE2hS+/08q+EwwA2dxtL
   w==;
X-CSE-ConnectionGUID: IVJyF/C2Qh2AchWfNuIZ+w==
X-CSE-MsgGUID: 1AyS5urtSKqDHqCtOTUA3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28454819"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="28454819"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 22:56:27 -0700
X-CSE-ConnectionGUID: YmNFme33SzWZk0SE4axS9A==
X-CSE-MsgGUID: Eung7WvpSdaI1UyqXjFwdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66614931"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 22:56:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 22:56:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 22:56:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 22:56:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 22:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvW2ps2PD+EQ6cVnStzLlySJNkTSjs/u+0pJw6omiu3H6MqzTBMdFAqFQvWZmVq6ahpbGTHO3/P8XzGN7zumPxVnIRJJGbH5NoloUUCqV95/lQBkbpqJHlxc6Cue1jNBtNwXPuTcr0bDfAydr36MeLvtBJmnAUOW9ZmkmfxTStGBNiJJboFlkqAKCVt5/AyDJQcqks8s+3NjHg20YNgLa3yLRS9qC9lO9+zu9utqqJQhcCAgqHRp8CIFrTHlG9Sn8f2cfqfUvlYNV3gd6b0SypGJMFwJIvxfVoIWcTxK7ON5k+10xfWBHYtpVg8wfXzKYaJBEDYlpXtW9Bb62VAD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DuQ/6dpTrwZNk7bug1OPSUqRAYgVo8wd7drGAEyFAw=;
 b=LFA85GSzv8X7Ia8yAC3OcMW+4GashFaUY3gzqg2HqATmE3u7B8jvEPy9omPaqYPgXVU0b0qqD0iDYJF3bEgs0Q9UHZXTRdUyU17vyQO5Uh98Gik+vRvHnhnVfLXcxEDiSXyeFNQlVbkx3e9cZRnRINxLu8yKGCnKkt7tTxOla9dqMDLNxOUwGm5cDUgun3BE2BLYeOYfSM/Nm0wkPTG5MIjbsY28tQSgoC4RjQ6utgiJZE8fW8aUI75fXJO3s7ukuBM4P3XGWG3vf9G6RJsBjYBXPPXbQpFLpbrurVLrBg6raIqWbRsu5KUQGTxduB3FSN7oCL8dna2uZpp7B1nR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA0PR11MB7936.namprd11.prod.outlook.com (2603:10b6:208:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 05:56:22 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 05:56:22 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Andrew Kreimer <algonell@gmail.com>, "Luck, Tony" <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>
Subject: RE: [PATCH] EDAC/sb_edac: Fix typos
Thread-Topic: [PATCH] EDAC/sb_edac: Fix typos
Thread-Index: AQHbAwT5Vyrja9mfWE+wanwMtXHs/LJQhdGQ
Date: Tue, 10 Sep 2024 05:56:22 +0000
Message-ID: <CY8PR11MB7134987CFC664AE4F7DFA353899A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240909220904.11461-1-algonell@gmail.com>
In-Reply-To: <20240909220904.11461-1-algonell@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA0PR11MB7936:EE_
x-ms-office365-filtering-correlation-id: 599dbb6d-0063-4b60-392d-08dcd15d4c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?n9y4zJLKCjYioqI0+StP4pTzOJCBiwzgE+zNTwD7OMXQiZclJMqLbBViMkvt?=
 =?us-ascii?Q?Wnf657wN/bxLIVOb4D83klHgCHh6IGpOR9aeGZr0NMgcBSPIO/d/dZ5Ww9Zr?=
 =?us-ascii?Q?PZWbGSErF/p0A4+3wlvJ1kMbTDPjBrLHe0LUH5aFmtlNub5Go2CO6WFAkDYA?=
 =?us-ascii?Q?DvHyP/EGY+PJ/HJoPOp29Np00o0YZqCYQR6xFlvcGcUh99tFWTaRNSkxk3h7?=
 =?us-ascii?Q?JOm/7xJMZyd55xiTsKMfK3edt/jjiLQJ/qxtUCLcIva0EvSaqc0FANkmRShj?=
 =?us-ascii?Q?kCL9Zvz6H59PpbZJEe2Q17qOEZBnVzQwCkzUVQALnIffR/55fOZ/BY+N+IN+?=
 =?us-ascii?Q?W1ToKcvk75q7jmw/xDDNGhd7oNT4l16ABTfxgFG0GuOVzjAD3GC2t71B1CJH?=
 =?us-ascii?Q?rtFXkeIgYThlngFLAQKQev6J+fhPp5sOKyZ/xCR26pdi5W+MDyjq6gaxlPYw?=
 =?us-ascii?Q?euKBKBa5RTcNQjLwhbdJSNmGQU1rVksGsMgA0HX0UIsU6xHY4JPJVsS5gujc?=
 =?us-ascii?Q?hrKP9uQh+7qG9hayOhDI7EyGzV5O5xknwXg8n8G1Vpy/iQ58WZn9lk/SfKHs?=
 =?us-ascii?Q?G2wAzLcDU+Z3A/vZP+UTNFKSm9BDjXa81+QAwMY0G2yDjm49EtedyiB4VniU?=
 =?us-ascii?Q?jNFRYatu9o54xSvoLSUgo8uvNw+IuUwD/3R98kXDksmStHmwzkBnb626mo8Z?=
 =?us-ascii?Q?qQy9FwiHoVRo5FZy2b3lKwiiL3zLAF1bF58Y9xS0eFeA+yEdnX5BQRvOBaJk?=
 =?us-ascii?Q?/8YJqlmKA6YqpfKLdDuqPwJHw54k7C9pNaroV0k5jmsmvTax74jycYRzGKhJ?=
 =?us-ascii?Q?miQUE9p2Yg251g2yu1C9SmJE6VzkSpDCDrn8d2crDmBxxJs1JIQWHa55Waps?=
 =?us-ascii?Q?q5X5IPO9iVCrCnX+ecPTUwWoZVJS2KTJguAcIE+flT7YfsuFnNxZp7zsazWt?=
 =?us-ascii?Q?9y76O6QGbvowgzX7CENvTzRj6NCohbxmdJASIODM94XBt8QYFDnL2BwG4/lP?=
 =?us-ascii?Q?JGoJ6LMTmLO3ykPn/d3DT4iMeqAnKD069GLE2W8TWY1SWPUAjswkr30Ycus9?=
 =?us-ascii?Q?M3d6uJljAEvLL+H9kxx0Jhh5pSc5ecX6ZEL2xnzZ95+zr4rKgJLAL+nadc3T?=
 =?us-ascii?Q?H9uKUfLw8pqBd8+RmVnfqOEli3gTUUqUBN2f0JjU8sjnkbjooHNGBOEvD5Dj?=
 =?us-ascii?Q?8BvaUqTXLp2hAek5sRZPESjmxE0YOD9X9E1sCRH/VBjnPUVUVDCne08PWB+6?=
 =?us-ascii?Q?9KG2hNN4WdSTYvvFUevwms4ZPbuQx1+mJztngJrHqYaKkGD+p6fYAobwcygV?=
 =?us-ascii?Q?ccKlXjAN/c4DiquUFYm5dHEs+bnnnswFDoKrPwvM0CWksiniwuKINvNX0RQB?=
 =?us-ascii?Q?alp5U6yvtwqTHnwVnGN68i6+S4BI7wapuNFarW8W9HTrYpK+iQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7qywzNM6LHh29e7bnd7pFEEsYJEW7ExFTt93RXYSZppT63iz7g71sMNdnHnm?=
 =?us-ascii?Q?HnrUcOnYE7kSL1qOYwv8sF6x1/xqy8FJbBahIkwIi9DM7TzH/SE1i/4wSRO+?=
 =?us-ascii?Q?/SQL3hZ42Z4tMxDOoyBi924vsSU5RmoBtJ8TD7mnMulyNJpWw3H6hzHonUd6?=
 =?us-ascii?Q?0xzfoINn+cKY9BcfgLqJYRrcO5oWnC9q65K7MUFIoLT2fpJnZeFtrsfeNxlf?=
 =?us-ascii?Q?g4zcumrYNChbb826ZSHFW+YKIsYrWaCnt9gVfGzzKiPFViJoG8deZsPPTIPp?=
 =?us-ascii?Q?UrMK9P1g8b42sFuoteI/LS37Ih5EcvRJyc2YM6DNSIB5PV7mB9wqiz/6hxvH?=
 =?us-ascii?Q?FHYXGJUJAxlQHrIRV+vMA0fm1b6XjINL3vYQF0vn+SqnY+w+OEDZHR7EAmxU?=
 =?us-ascii?Q?uGkU0O9Fp8YVNjmzqRGZqYdju+EYUUCXWa6QlrBaPbx4T6wCWNdXjnRrprSG?=
 =?us-ascii?Q?zqy8ZSS6+/hF1HAcFrguMo2YER7YrUC/KX/iJUqlpjeEB3za7fYqwIbNDfeq?=
 =?us-ascii?Q?G2mpmi1QRdmxq+p9D76cC8bFOSJfrJFDS3xuVAF3zOllKELAWnIl22D/bZOt?=
 =?us-ascii?Q?YFYIUg3KtRCzSaTIsX+7DTDojQvYeUwGOyNg2ykSugE8KwQaf8QHuSWf5OoO?=
 =?us-ascii?Q?c7Yx1W3KZZ/co/gM2d4hnP0oH/bd8snVfLHGR+Qqw436lMsgdimjjEErIno9?=
 =?us-ascii?Q?2nakQdjM9SDwL4jpj73G4SQ/rnTIcrEl4fAhslEzT9r29WVEYbzWqwZkXbnb?=
 =?us-ascii?Q?s3Cnc9LQAMI8WI16SuJg3aDlOcWBgkLCd0gIKobdnYL+QAYEDpWUQ9g6Uw7c?=
 =?us-ascii?Q?I68kUiGGuNzEvz9lDw1ZRGYgE6YGvAVxVSoVWdE/S00FUuVfH9CSgNbYqRCq?=
 =?us-ascii?Q?RkNowusVVGSXzu0QNk8nx5QwKkGxrRbGOmm+5kOMc/EHHUZW13Yc+5sYIiVR?=
 =?us-ascii?Q?bQy1zz+YkAOw+16vE0QjFSGANTL+bopj5WGqTFuunHzN6Dx8e3NC64t9BByN?=
 =?us-ascii?Q?qIInWYJh9UFfb14c1npVbIpWjapSgywc8uERYLqe/ikzGTwOHajHc32tfkQd?=
 =?us-ascii?Q?DqIVgqh+P9wQNltw44WKmMq+FDKOjSsj5Hj5HxcPEfgBBMnOYKPiJrcx4oHH?=
 =?us-ascii?Q?DONChz/c5V89fc7weRsOGnBIbUum9Afb/WIoDSjTrSF7e6Yb8BcbejIdGXB0?=
 =?us-ascii?Q?ZkQEprAxHfQTdQ40x0L17Q87rScN/oLF3u1QZ3H8wsU27B2QW0n6BKXLA0fv?=
 =?us-ascii?Q?Pao5J3k5DqMiyKDoWxH0BPzpURBbeVSaQWWbFYKjCp3PSZxRaALOWIJnoQiR?=
 =?us-ascii?Q?l+m9ATisc1UzBlSJd81sJ2grHxDFY50LxSiZoGBLzJ0yHmN++2D4Qw6mR+gb?=
 =?us-ascii?Q?Ij1TCGdwVqvI69XwX81v41QDxNApVMCQsG0d4yJq9TiMGxS0Fapgb7+aIJ+u?=
 =?us-ascii?Q?X0YpRkafKApSdRmxGkkIU6e0NygbdW/u9V6jvUqZW/2o3PLlBVgpK48U6cPD?=
 =?us-ascii?Q?Lc+rnMAa8pXZNcJu2x8j8ArEoM2Q0U5zZABREQplWitStNaiVNNE4kZc82m3?=
 =?us-ascii?Q?isAOQX7NPO7zxfwz46VWcuuCxbh+IxdcIj17krkD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 599dbb6d-0063-4b60-392d-08dcd15d4c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 05:56:22.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qPLifHZaxucd9UkdjKD36iYVqR6fF33tCXQ+kLbaxwRXvKXkoYy+Lpkw9wIeYuU0cyCNYlyH8DmuvVnyl0LIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936
X-OriginatorOrg: intel.com

> From: Andrew Kreimer <algonell@gmail.com>
> [...]
> Subject: [PATCH] EDAC/sb_edac: Fix typos
>=20
> Fix typos in comments.
>=20
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  drivers/edac/sb_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
> d5f12219598a..d47f1240c738 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -1797,7 +1797,7 @@ static void get_memory_layout(const struct
> mem_ctl_info *mci)
>  	 * Step 2) Get SAD range and SAD Interleave list
>  	 * TAD registers contain the interleave wayness. However, it
>  	 * seems simpler to just discover it indirectly, with the
> -	 * algorithm bellow.
> +	 * algorithm below.
>  	 */
>  	prv =3D 0;
>  	for (n_sads =3D 0; n_sads < pvt->info.max_sad; n_sads++) { @@ -2055,7
> +2055,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
>=20
>  	/*
>  	 * Step 0) Check if the address is at special memory ranges
> -	 * The check bellow is probably enough to fill all cases where
> +	 * The check below is probably enough to fill all cases where
>  	 * the error is not inside a memory, except for the legacy
>  	 * range (e. g. VGA addresses). It is unlikely, however, that the
>  	 * memory controller would generate an error on that range.
> --
> 2.46.0

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks!
-Qiuxu

