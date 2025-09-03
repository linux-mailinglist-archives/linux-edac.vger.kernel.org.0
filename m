Return-Path: <linux-edac+bounces-4727-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA83B4240E
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C73189C8C6
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20A2F618F;
	Wed,  3 Sep 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5YR3hmD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1812DAFDD;
	Wed,  3 Sep 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911136; cv=fail; b=eHCz2340L1s/8tCxm/IOqi41IxambYMeKoseomQXQiZDxxEehWUUybxZP9EfvdOQL40PbPS98MtULIaSnnIznIhWMn4RBlwO9hnR+SK7kfq5uEhUmDR035N3tobyk7vZFYKwOd8/cPyUcIrjei2UhdroxAx1ugtNvvhzhHpRJFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911136; c=relaxed/simple;
	bh=lflhxwTrSNMZVDb8gYUDR/Hi0E7QAlb6NuAayNvWdCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/+va7MYZ9qqqqUrQo/RLiEw/XW/VOiqPGaQy1FHo/GOv0QSag4dbpCGnA3G1BpgPoKxORVrhHzwlD5DUH4wa6kS3WB/D0eVXOBTWymwamO7iUd9Lero/Z1P2OWXncw0V8RdCt0C6M6U2RXhmetQKqHUBYmsn9LJx+imkGBqiho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5YR3hmD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756911135; x=1788447135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lflhxwTrSNMZVDb8gYUDR/Hi0E7QAlb6NuAayNvWdCU=;
  b=L5YR3hmDmrwhCBSL/XW7CNPTVxWFsocO6w8pFeGYnNAMwarlsmzhHQ6L
   pRQnDsmcoS9ZG9q/FV5qfJMVEeOlr6BL9+gtINvp4qKRFoFX31l6jZ3ck
   UDQ5jwtgbyalVTPUzvdT5VYq3+OHTx1xBJZt5XtI03Vcrdhxi5LvvnVH/
   9f2rygqywVKfSkAa8m0jG7k0RV2oZmFS6bKLHSBEw44NUYSTeykDzHoIp
   EJKjNtNNzwU72ALCzXsy7LxUVDBJcob3pRIlS3rfpv8EHC0B/baUsj29m
   MWf4Voi65zH0GVWJcNEpd+dhW1zv8gBxERtdb0Rz0Rb/qFGQxH2QpEpG0
   w==;
X-CSE-ConnectionGUID: dEjHfa4pSJqfO1GP/QDNHw==
X-CSE-MsgGUID: Zo0QVGJ5SECjbVGqkAgppQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59140670"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59140670"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 07:52:14 -0700
X-CSE-ConnectionGUID: oFc2suK0T42+oqGiVimf0A==
X-CSE-MsgGUID: YJtjgimpTbOkT4fWBduDOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175966274"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 07:52:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:52:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 07:52:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVM/mpQ4lshD/B5y41ssAbDGrQ4Yfbd+7aeq5sE+bzxdjRtX8tVwM2dL0+hGD1mJEkP3N05SSPuRsmoAeLTIjWHBCvDi0d5z8m5CT1kjfIZOBta+Obo4UOxR9Uy/GHVGmx4kDCO6D7pRkBlORK9coXrWVLoG/dgqrrsGGgqQqyDEVVu2OuFqD88d8xTqmaCGOwNV1oZ1IEFH/kRvu6FI5v/hJ8njabQUl795LTDFmU32Q9+GzBRTGyrp6Xrac8ST+cKi2W3ksgHJGPRrqhvBewV5EFipwC8EN418coO89LPp4qJlQLYCU6P001Y5/0+boDf9XQEoSwuMJE2NMgRoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lflhxwTrSNMZVDb8gYUDR/Hi0E7QAlb6NuAayNvWdCU=;
 b=cYA7wccvyzm2fVHrvyZ4DPficsVJbtVdzhggCEQ1YgbSZyIWXjViqunQ5Uhfh/tT0S0NvzeiCqSMeWxR+LIXHiwn6ps8RnDPzBXJyNj6BQZOGSvprxdAhmHrwfx+hXZqubQPTSxGYdBJGusSbkLeHBxP3E4nL5FpGm5kgLHdUbiU2KU1ccbzV+lGbzY6eCtSgdjo8WhfoMcVG1sySq7AHNjN+VeCwv+arELVuy8LR2CDJL262lBbC50o7g6gTvz6UDllyUbO5PnB6gnLlOE68sGLCIGZvPMgaPcwWaAq52OzCYVFxVudN84NMQZPZCiW/h/jT9ItLrhMH97Oi+FEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:52:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:52:10 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Zhang, Rui" <rui.zhang@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/skx_common: Use topology_physical_package_id()
 instead of open coding
Thread-Topic: [PATCH 1/1] EDAC/skx_common: Use topology_physical_package_id()
 instead of open coding
Thread-Index: AQHcHIAQKON09vUGNUa0dsNTeLVwy7SBi3Ig
Date: Wed, 3 Sep 2025 14:52:10 +0000
Message-ID: <SJ1PR11MB608377C592A6AAD99D4384C6FC01A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250903030648.3285935-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250903030648.3285935-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6401:EE_
x-ms-office365-filtering-correlation-id: cdd6a5a8-d8ce-430d-c987-08ddeaf975f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cp0zipz8ohSFBISqeIuNdmZv1ChwzGwaazMUNnLDudJ2i57GyBuAgcbfAtHh?=
 =?us-ascii?Q?fWB2EF/dYFwjPKbF+ZJfJi03lWZ3uQI3UNyRT+UfSxzS1RzRdfRnCRhigjoJ?=
 =?us-ascii?Q?RJMCM7qxoPVIs5gjoEx6CYAQefyej3msDmj8LTqtge0rbbeMtzgXC0ZVTCOh?=
 =?us-ascii?Q?B8sg1ZaaXSa0F1M0C3gXU1GYWC4gkQzlXmk1Wp2Elde68HXWbNqU73bkpg9K?=
 =?us-ascii?Q?Y3yg8jMpsWR1g8wyLwsVW74gP2bKphK8r2vGdeW06jPG1E0t6pYv7MKZc7I2?=
 =?us-ascii?Q?4uyslDR/toSXOkTN3PIV5gj2LthphySuBfXPy2KLCOAAPmN0kQTBvcWn6Gbi?=
 =?us-ascii?Q?nnSpMnAX4+6SlogWPfNEEAephEdKJ1hrRlo0V5kZ59y1xOeke3FH8KaGz436?=
 =?us-ascii?Q?vA1hK9lU3lZdO3msttOFLv4ks6201p3+ju4CscKNtr7t6i8HoohZkknRqlZA?=
 =?us-ascii?Q?s3N20jONNKVkLKIl9mju4Z2gQs14uPeLmpLDTArtabEWzu14plwJc83w1Pu3?=
 =?us-ascii?Q?i6fq5K5aBeTXEGyGVsNV4R9kaiKIJbw1NdLM4jvZzW3BgvvSe2ExhUDYDyAe?=
 =?us-ascii?Q?DGAT6dv9/pdCsKhzRs+rweV3FTuhI48VHqNT26beOuLoXukw5Z03XTsO1fei?=
 =?us-ascii?Q?1dZR7kydHlube7LgdHe5MG3QPtdZtEfN5CAvVy9fyhZCIQ4LXvD3/kJoIpKR?=
 =?us-ascii?Q?1Vumx6KAJiWSHP4MY6MfOh2SKRBotBjx5Su9q4SfH7YxUThYWeoDsjYOZ98A?=
 =?us-ascii?Q?AsEakw126B2DgQfDPepyRC2MCZ3hE22nX/utNhX7cpIusLugbY6m0t7DHk3t?=
 =?us-ascii?Q?dyXPX+RdJHiy2EUC3yodykVv1eb31UanD+Qthhp+6qLPKMH51heVis6aAinl?=
 =?us-ascii?Q?pVpCXW3OwTltVdYwZmJVl37s10VKC8Y1442ES46puXcd4gMCWi8RMS3vXivJ?=
 =?us-ascii?Q?IC8MIn7IGdX+SudAx5GSYMv5ol3AA31fO7LBzPwyuuQHcgt1i/Rei6ZMh4u+?=
 =?us-ascii?Q?w1305eC0JEC0G93hKmIw2NixRjFrjacdM9f+Vss3uFPTUcKSNt0dlh2P1cUr?=
 =?us-ascii?Q?i+AwTQuPK6dPVjBh0mMBEIb8eL0qvsK+FiaYVaS0Jou4rIU7XBQI5IJU0l5D?=
 =?us-ascii?Q?6JviesN3pf6bG9SBLVlQM1CGewpaxTHgBoPkpDz2KOcxemnEZnVblRJZ2ylj?=
 =?us-ascii?Q?TAQD8S0VTlTUEvObo70rO5NXvMISpDMn26RgA/44b8T2N/fzj9ljjqehgHkT?=
 =?us-ascii?Q?W/jlmJiQahyIqjsA3WCYlOPgzwsJFWohEsNRjfdOWTpsAXu87IjW2E4i6F1o?=
 =?us-ascii?Q?9uYD3gGJrUmlU592SkUeUmBUJkfga2LYTbMK5VG4l50xgd/geWbqtAQh9NNW?=
 =?us-ascii?Q?4M+nrjHKjf2zJHco4yyd8s2JOapcNMpz1uQHcV7c6FCnjsBjGqa7b+Ni2pPK?=
 =?us-ascii?Q?8N/1yybArPjZ/Z3eh0X4EPrCOr17+pOcAKJTbtdvKbSgKxquNRho5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SznBsGpJYSOuKzvbw2m+2JxFXm+syrJmdGu6p2e1ikA+sTt0053rNLRHx40S?=
 =?us-ascii?Q?6UQzGLpG9KGHjSdn/pHIoP8XPWR6PmbN1tduTPXNtopxqm3OnglCbqZddddX?=
 =?us-ascii?Q?kSpfWOtE4Rug/Z5Mfjp3T8FT7CFMyq9rmgq/4lbKEjy3pgAq8cJa5y+MRyKa?=
 =?us-ascii?Q?BUqzllM/iiQlwdbTP92WbfcYfgTS2WCoOJLu9yk6MM9q8cy+IF32qMx2syAd?=
 =?us-ascii?Q?4+PFr18/rG0nDsURhG4C+EVk9n3nDXZvpg6gUG1nbY5cZjsQpDX/u1LhLM5U?=
 =?us-ascii?Q?rTTJFaJ16aQ/mLUW5ZWN5jr2VzJUqOXtoegPqpSC0oev7M9DQAcUZ2vPTfKw?=
 =?us-ascii?Q?6rXBC7KlDLF5r4MgSQxSLEke4eQ/jyggq5woWpbizgK+JJZi94OYaxMbCwdH?=
 =?us-ascii?Q?z2EVB7Rmr5yeWQUxm1YyAH8oRGRUvPUjNUj5Tq3UKI2bhnpMWNtYDNVwKJBZ?=
 =?us-ascii?Q?QsUZgW4bM2yE18hsJuirNGcDyQTIyCPE8jQyORKsnECY/92fS7Q2RKv1Tn6e?=
 =?us-ascii?Q?Xc4ly0xTZIC5mUA0s4PBNiuuKsp3K0yGxMkro0d9aUQ+FWD4JdPapk8AHOdz?=
 =?us-ascii?Q?ea8KwrlbZDqx6ANDOh1V7Yx4EfFeY0+/Zw3ukor33hedAQP4TX8lvQDpOvLu?=
 =?us-ascii?Q?ra0pbzPbpC2Ic4FrFQG2iBMd+HneAtzHf+Fon2lDuV746KNCSxahJW+8ROvw?=
 =?us-ascii?Q?Mip5pTH45VNaM6oOrcK9gQWMH0qQZY2xjH/gd7A69ewy8r6vmsupwckKxAPZ?=
 =?us-ascii?Q?zHfSEPRRM8qWT37CBwbMWHDfQx6azhPU2H84sEkBmimQhSVv/HnuBGcYCEbS?=
 =?us-ascii?Q?+tC24a3y3aber2aQWSprGYWFMkJvneCFoc/3uYOzMjn153IQ6lB7V0yHwFoV?=
 =?us-ascii?Q?wY30mtfTC8i64itguLe+UUWA9qLf6K6XOJqHa27+UoACq0bAtLLjuX0SRDSW?=
 =?us-ascii?Q?LNOptaqfzJLxgjZQQXCVCMV7xOwrsEhplIoq+i1WhU6uUuzHbalq6lxpsyYH?=
 =?us-ascii?Q?8OjeqL8SAl7BenyjwqrwzE8Go55IY8pK0SOu1/LQpdcSTnfhYXeYCsZmVLi6?=
 =?us-ascii?Q?pnB9efJtqXskTHX8u02VOE65uosdbGYkZX6zxmZjYdSJ2S/bR01my1VN6nWF?=
 =?us-ascii?Q?O83EVwnqaZTWHsxekTQ6Un7lqFG6zuANZaimcRkwOiPfuJLQrmqvN55rOdfm?=
 =?us-ascii?Q?LPmdwem0or0ZcI5kPmR8pmSbS4EZ/xTuCw9UVIXvNOJ/FFIbhjg5Xdq3ZGHS?=
 =?us-ascii?Q?xWMIfuwJ2G+2USD/Ne9w6O1rvNST5p72I00N2kqyujvsfLmYg4JKD/jZbO2R?=
 =?us-ascii?Q?pVn+yDfIFnYf1+9+nOjVvCYoibGlrNlmiSNQexiWPskDgJHKqbmoUR4LXbjA?=
 =?us-ascii?Q?5gm8uBCRGiuT50X7lcIOsHf/zCfJVGkLeBNAjzhDT/VQDcLvoSoi7poBf2WL?=
 =?us-ascii?Q?yfUdxAbIn26eLOZBZ2eSYx8O08w9n4qXTFWiR1ldOFcL2+ThR/8Y35DlAdya?=
 =?us-ascii?Q?yN8vvf516ZacAV0I+5ewTW1mrZABuGYC+tAmI39/Kl16chmaVpeCB7fWVYMP?=
 =?us-ascii?Q?/dmOvgJE4PodsCrVYNvGczpT3SogLsZG2tlZcNkN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd6a5a8-d8ce-430d-c987-08ddeaf975f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 14:52:10.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWKMNsq0EbfDFnRe4voHs25xJWkptKkEsWqwPgAnizhS71Csu2PhOR2CgBgG8fGBHbLRESEjJBUvLPiBe4qyMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-OriginatorOrg: intel.com

> Use topology_physical_package_id() to get the CPU package ID instead of
> open coding.
>
> Suggested-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied. Thanks.

-Tony

