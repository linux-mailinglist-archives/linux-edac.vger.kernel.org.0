Return-Path: <linux-edac+bounces-5003-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8ABBC22F7
	for <lists+linux-edac@lfdr.de>; Tue, 07 Oct 2025 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EECD18825F7
	for <lists+linux-edac@lfdr.de>; Tue,  7 Oct 2025 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CB2E092E;
	Tue,  7 Oct 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAnW/AdR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CB3FF1;
	Tue,  7 Oct 2025 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855988; cv=fail; b=Ap2bqf0wsM7ivOT2WxLBz41zTdFy3B6qMPY8N5OduWcvL4Tslqr95/YOOT4vcZ18Px6l5MnM3uk+8gpdL0oIOoJ39BXdNq/gvieLhUojoQOUslULv7S362mCqZPtal1PYBvDV/drwIpusyCwhtBplafC8pvQmFk2hd1hXg6lyk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855988; c=relaxed/simple;
	bh=Q2qR2jBsTy6HfRODQagDWE7tAbrvBnDxs1HAaMUy0Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OwLM1bFzvZ6A54zaL2BSn0cTeAFxer9sSMJqYYjH2JQuc0SWsaBOPvhtXSg35dLSZfP5POa19FoIfrWQCP+2fWKln06wzics+tRfTpNQCXfCt5LoxQ6xLNajtsZmbruwn2pj45N/Dv9UTT10gqukPLlo/8bSnf0Ro50xWFWN+8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAnW/AdR; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759855987; x=1791391987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q2qR2jBsTy6HfRODQagDWE7tAbrvBnDxs1HAaMUy0Lc=;
  b=dAnW/AdRCGzqF/DU6X2hUJQL0e7ccb+CNbHQkhmX2FLtr5vzlPYvoYnD
   0+QTqisT1NJxoVA4iejtMKupnG+y2zizTtfkqIxa637RDjkZgsrHxkkxa
   HRmjRmBh4nfxoxbs9ESId+6yRSpGNOcAFK2YYCHsyc9vnW46qxjnhlzL1
   jDGdWq9xec1CZtb6v/RqOnVv26a3srTqcDQ9FL+qfO3h4qMoOIlqamcEr
   6PlUMyMbycOkrw1fAlU63Twk73Lx+RGVgn3KbwjtKAEr8fFuj67Fy7f75
   kBIV+QNRJUyDuBCbzK99PbaAODHjp6K7xA8XEL9hWc51cn1hcJ1ZzyrIn
   Q==;
X-CSE-ConnectionGUID: GUFTzlSfT6KdfigN74SYZw==
X-CSE-MsgGUID: 7il/6tDBRQ+D7J5aaNB7Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73146750"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="73146750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:53:03 -0700
X-CSE-ConnectionGUID: jfx8iL0eR6WFPA0uhmEPiA==
X-CSE-MsgGUID: FZ4WjOh2S4uafvWySHD97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184241629"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:53:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:53:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 09:53:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.63)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYvGiPR4KCSIFcL1x2A2zxpoIs6sFGnvWOzZl2857jEk9U3N+wlTiSqY6cabg8b7D8soI9VTIcOrD4pcMFrPIlOVenHdJhbo28HLP0pq0zwRnnLSqq6nbUEkPZn4uiOCFE2U6KbH4lAS1L0hVrR3aq1dolVQ19guqXKqMhkfDl+0KPpLk1MLkZuGMXqo9cQFsQriiOwkfvS49BqR6eqxQtEtvdKKLEHbISelrY+2QsWN94DvlmQu6sSYZSwXqiD+IQIyIJGoK3pkd30pU1yzvsTJ3/mi64seJ3pF6jc51gYnESnWxorlcJl84yRezcZHENLpUYpdDjpqnCQ270mT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crjGQ+GU4swrpWmvSNbLd8WMxbb1NP2B4tXdapVEf4Q=;
 b=dubOBM2Hle497b2RuBfGuseDiSbM2AJLWlYXJi/vqa/d/az+Dgs1ffElvJEsIYUJ7F5Yy/AtlEJ+fdHCiSm0XuU5OefTG/IJmjIg+c5gLj7GWZzrMeP4iO9C1b5ifLnUaAI50UwKUMChOuPLI5c9hJkXQhVt1M1rOfI1mkXdU7YiT0xduuneDDXZDmECl9Tfz0ItC9+khulBndRbkhCN5aeGwPIoH21e4WFMK1B6Ua9NC/hJKaj3jYZ75VgJmd+/41YbghDUF+Z1Zy7pza3N2wROPhr9WNVRhjf6mwDXKBzoqZsaKha1chP1S+HaH3vxDkea6ImwJ8ZRPS+7NAahtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:52:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:52:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>, "john.allen@amd.com"
	<john.allen@amd.com>
Subject: RE: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
Thread-Topic: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
Thread-Index: AQHcNtRr8Axlj0Kpv0W2YzGSUuJJlbS1pDkAgAEjTwCAACAu0A==
Date: Tue, 7 Oct 2025 16:52:55 +0000
Message-ID: <SJ1PR11MB6083CA3B5E46A4386A33699EFCE0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251006151731.1885098-1-yazen.ghannam@amd.com>
 <20251006213406.GJaOQ1zoXUKEk-7eCn@fat_crate.local>
 <20251007145644.GB11984@yaz-khff2.amd.com>
In-Reply-To: <20251007145644.GB11984@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: 54fdeca7-03a0-4d79-9210-08de05c1f67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Hm5D5uIfgQT7V1UiXXMmUiUt4ewrL9EG/rwzGUctxIu3Go4fwHdQkWsk+xCK?=
 =?us-ascii?Q?mXohK7mnONnPqi2cfm2s4qG4ZhfhkBalyu/qgm7/Vx6fOEaPneXT/ajnPmv3?=
 =?us-ascii?Q?tTpjFUn7cLvLrsznI939FfPbx8oMDTxlhinXiFiECp5q+CLqQXTjoe8bkL3N?=
 =?us-ascii?Q?JBIKLuq6eYrM6dajxJW/ZHaxy/2qeUAL+hML6agTVpiUnw6WsPKR0kWUFstT?=
 =?us-ascii?Q?r7zWZHhbyWq4/I2GBlUCdxQ6Yh+0zsQFNVr0eeFwg9WcQYAbOuKo1FI7jxN5?=
 =?us-ascii?Q?PMKhjcvr4Bv/Q1xQB5tK8yocZ+rDjbrES8KHe89oen2Ge196yKI7l6ksO8gO?=
 =?us-ascii?Q?H2BOZCYZBMxGICmABts6XAoCDKrnVIiIlKcMX1hIjDitPm30gD4BuaKwzMLV?=
 =?us-ascii?Q?C858ZyQSIlzyTGvfFsPtT3IYLSQcrvMqhGxWJDIAZgiR3QcB3bw/MBMruxyw?=
 =?us-ascii?Q?ur7pI4SpecfvMJww0VGwLutwbM5ZjQByHZJJ2X0VGFrsKoLJWrfTpxrp6Xob?=
 =?us-ascii?Q?eOkCSjwxo4uifo+uXj2I2cUeAIjiiKUIILOey+h06hSRB2M239L/VJUY87Gs?=
 =?us-ascii?Q?K88pxhZsmTQDLvkjlrCWhzGwhTqn5Yvxfjb0xkJFic6yzfYaAT/OgvjHNzhA?=
 =?us-ascii?Q?I6bobqdNshkUzFB7VMhy+36+cPnsX//dsx8S5p9favrwXwPpvsjBLe1iu+P7?=
 =?us-ascii?Q?hRQnCgGLYXnzAzHqOLKWjW3RBEyZ+uaS2UNhaHua/HeuYJWllSX2exgPHMUo?=
 =?us-ascii?Q?nTWN9cWrVpNxrprM9Ea2CzP1PvG2Wlt2BVWkj1DLwX2HNPbYrbCrCSmDunUF?=
 =?us-ascii?Q?LPuFY1th0e2w57sp2gE9GQGRKk2NSAxgMKEoKKTZW7G9jsOkTfznhUcgwCeo?=
 =?us-ascii?Q?sUzw3GmRLdGKYTm8+oPDGFFZuB7JQpSVEMKXVax7JJmMRZ2P6Cw6rq/lqNkd?=
 =?us-ascii?Q?kbiTXJvYo0DcxnvWSPa4xQZLsa8EU4KX8pNqYQ5nQjEGrwTGWLaYImZ4Bpac?=
 =?us-ascii?Q?xYww4v1ctLK5X/AaBs6BC8poMHGIHVQA1LtuAA3a9ff7dkx87478zAIIe9cD?=
 =?us-ascii?Q?RpOawMXTzUPp8BTKw4MSupjcROjmZxYr60m7BAspIFt0XjtOgrtE3cBw6r5O?=
 =?us-ascii?Q?pqsqtdw/2spH/SsHaEPk42k81vXG9T+RToWVoRYVm1zBVv9R+WCwEWY9UDpI?=
 =?us-ascii?Q?M5hQNkSwikPzRYUeXyYf1/YIxdFt801MdIlGc8Foi+H4QXpuvU5Y4PHv7naB?=
 =?us-ascii?Q?AsNGCb2KD/9Lhqe/cV3qiGaHxWtKUWe7v2N9nWRQeQ4iEBAzi66Pi1/KCtEs?=
 =?us-ascii?Q?f0zhdgeu8SuHm6H9jXeRX8nmTuQrQ5bJ6fvAgU8qhf3ZJJ35wgH3zV8MQG7j?=
 =?us-ascii?Q?xsH+gGXUbB2/X99L6cNm8nFaKJ34dLAFIljpFrj0Pu/S5Fmwh4Oyf4O0mPgP?=
 =?us-ascii?Q?fAlK3cLGkVoynflwNHlL2Ys+6NtZ3VgDtHi/nyVqh87hPhR+SRATyWtRhRQM?=
 =?us-ascii?Q?sjjhIdYe3cMeh7wU/HBXf7oenQ+lxMnos+32?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xPwnnzKqLhcoEGfkwr9HWxGG6hiRWNLk00hOOk3QD6mtDs/3i7wdu3P6mS7B?=
 =?us-ascii?Q?yvvd9eiaX6TlydBNcmSTOAkx/rzytEU2T/WbW17n4PwyuF7Nccr0MlkGfmi6?=
 =?us-ascii?Q?9FvfQKeQ5c+b27+GYzcbIhUIAH/FosSgDdZ/tMO1t4RwDZwyEI+nCVoQR2n3?=
 =?us-ascii?Q?ewQchsu1GQbMEx0aQEi95gBdjDr9fMsrmR92FZSP52GgZtnrCyFAxriIS+ZI?=
 =?us-ascii?Q?vyfWAXgus8hBVhuala7tdGl5iU4GzJ1XRQXKTJ1NNydC2l2fV7gJhOwP5qBe?=
 =?us-ascii?Q?5wEoF/md0nEvob/nxjt2SiQtE2nqQ32CsjtYSd5JjwT/sulYUFqRbZl7mqr3?=
 =?us-ascii?Q?7eGuLvs5N9Tw1HqsIRhH67eEQSZeHgIB7hJLBmDedO9ZKHEkJI1a/j5I2FAB?=
 =?us-ascii?Q?oElOKSN5wZJ2cNw4aRR5GKX4bIRIC9HAtCQjocqGHkSnOWkryU/sUgfuKhnv?=
 =?us-ascii?Q?eaxWrj7Ec6SIIZbsE/3qfmZBI5chDj/TyfYya8x/6d69qsTdCD7FbaAARkJK?=
 =?us-ascii?Q?gXMVtzV8+brM29O8w7bRkyd7P9CL8qh65zUEYinnSJMBSQOjS/GgKVCEceLL?=
 =?us-ascii?Q?QfrQ/ZJDFbYT52kNvu12++i8niuU+v0QgQ0yd5Woc3q4yeka94bZ2YWCeKLq?=
 =?us-ascii?Q?veRGvBrMr8++lA3hqW2fcYmakvA3HTYZjT46WxAYgjOrp/z6214eGURmBH4+?=
 =?us-ascii?Q?QHyi4m3WgIPYwkrQq8KDm7D4jlWHmk9goorIg5NOhwP77Iwr1+58azFhuE7N?=
 =?us-ascii?Q?902oDknPPP11EY53nVF1FVJdmAO1Uq+j0U5/Bt1c9pHRHHZ9xaTLTES8IDsY?=
 =?us-ascii?Q?8hWWC6qT0pWFs11B6dGK48GAKInODAZpnF6bjAQfgogp4mEIu3CN3HkGppcG?=
 =?us-ascii?Q?Ciz5JNd2RNr/8uiaVNHYkz5ZIcr3JOVM6GwnEjOR+jpLUn7Ga38Ql2u+Foie?=
 =?us-ascii?Q?G5wAMh0NHDc5hWCFlT99R8hspNPZJEs64p67gT+Koxi4RHs9XMhoqG6nljkB?=
 =?us-ascii?Q?LxKz5UXSP2Jf3bSfkM2LmPlvhFwvk8n2ejQZyz1dolve4x4e+6ZmuMJIQCfn?=
 =?us-ascii?Q?QK5xoXBzbEsCfqPfbSeQGUnB9TLMuSg/kdnx/3cBbmNonftScJQ6Bxg7kRJR?=
 =?us-ascii?Q?DVyjkLgvD6GyZsnIz5J1nPO4u6/TKzrJe6/wVkUwL5TDJvN1Zl5g2nUzE7jf?=
 =?us-ascii?Q?/XkjBD9Y5JrPj79JL+e638uVaHibGb7ErZE2boPvwowqK9CpRtjeXScjr9bC?=
 =?us-ascii?Q?lUu/41C7pBpNfMGy9zeDKlbX0wj7l3YInOP3SimKNYImm9NZc17IACT9ozqp?=
 =?us-ascii?Q?EkgPUNO6fcFnm8nK5eTZQGZl3Vm6eqluxbbojeephGW4gCOX+pi2C//rJYbe?=
 =?us-ascii?Q?QQvUy63KCh/VOUl6NjyMU5k6gtmm7Mgr4qOcEs4VtyEHH91PEcvNhT1QFbtj?=
 =?us-ascii?Q?FHQzyyLPJiV1FZykwY/mHau6NgUFzca/y54vp82OARunGfr0WZjW/HYGCrjj?=
 =?us-ascii?Q?HAqrbb3Vf+1hrHK0l8EK/MdhD/uO1D2F/Q2FbSMh16dLsaz8NqkW8JLNFtvU?=
 =?us-ascii?Q?pWPJMnheULw6F/q4x9QbaNgPQtpTRVMqk+wFPeWC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fdeca7-03a0-4d79-9210-08de05c1f67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 16:52:55.5038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0O9D32ylUwsW2ayJEdV0kE63rhSOk8F+1ynWPwRmmJt+CCIydllzb2t/J908wsPIVsxU6+sjP3DpHeYsGTfDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com

> I think it's a common use case without FMPM.
>
> IOW, log correctable errors but don't offline memory because of them.
>
> Does that sounds better or about the same?

Linux has  /proc/sys/vm/enable_soft_offline toggle for that case.

-Tony

