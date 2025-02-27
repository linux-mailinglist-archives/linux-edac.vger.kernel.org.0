Return-Path: <linux-edac+bounces-3219-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6ACA4872F
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B63AB37D
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640E91DDA3D;
	Thu, 27 Feb 2025 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHFf0HIP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44541E833D;
	Thu, 27 Feb 2025 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679318; cv=fail; b=WoTCcoVuB/w9e0moBjdyvtnAGimjmOpIr35SGzyCtXXJfjCWEl0NepKGC4Jw63U2WVE3CbRvH0gJqgT/5EoHcr3bnF3tRz8AzVEX54/PFH0RoNywI08F4aWIBAvsre/Xjol1wm1BeN4yF8MZtnNzzu5hY8QjJgawtbrSPUqoCxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679318; c=relaxed/simple;
	bh=6N80a6njF93tyWoBBO0hqs37S2RuQ+Yb/1xNM4HoFuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLw1oE3Jd27B02Bzr6OXUu4FSFf0KhsNapUncdm8U7rxw2+KDkTh6et10Wl0fJ72PwLwRPngX0wx6Xgc4emsuv1dlXsVOLlA26HcZxUbEbOj5ev+oFBFrL2Npvyx6RHfnDkqMcpx/oUX38xIlAIFRLfltNR9kJ6FwiL42gNmN1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHFf0HIP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740679317; x=1772215317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6N80a6njF93tyWoBBO0hqs37S2RuQ+Yb/1xNM4HoFuI=;
  b=kHFf0HIPBbdi+us6LFPiTPgl3jajAyZ5S8yI6TQnYxW0KogCZL2ItEcU
   dYtOure2Hph52m2U8ZZCMCDrqZpAM3TiByLY7JAQ8sdW1X8F4SJoshF3l
   yDDJ7BIQHDmzNEIwrOfxAT9UKTe3dH05HH5j7DDbRYBLzoU/SArwEIcu6
   dk4h/EBrrMzNY+hFJ8fBSI9Cz9sA4+12wMzaSxNicMNk9d1aOjswP0knZ
   8KFLk682WSIIAngCVTyJV8t0Uj6KoZfmiluOIhCcNVMEk96yoEH6x1HMU
   zKleDdqsTcB9qvJztXpZtkrKC4b6X2PaRBHDnR4LdBrVcXjlSTg4HnYRd
   A==;
X-CSE-ConnectionGUID: PkBgJTSvQgyQ/QxhQkL+IQ==
X-CSE-MsgGUID: 4FQGme3DRWSt1BvrfyC3xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="64053751"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="64053751"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:01:56 -0800
X-CSE-ConnectionGUID: XwE6QhpJS0a7uafyeSwH4w==
X-CSE-MsgGUID: 4W/4S6CZR1G+Jm59Wbybuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117282569"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 10:01:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 10:01:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 10:01:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 10:01:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqQdGHVBeJGG9vFuaXsyHIYEqc5TRbfpemRLzMfBBwD9msasRu3cldpxRzH9ewuc4fTKtcCuqcrCbXxJBGBso/qsvWZojSpl4p6o2jDDGOJl28e5lyJOtUKi5s8JZXk4zk+TgU4NX0hcEdNlCLDd9WNVgwpl4B1BFSk3XXkXtgtJZj9k26wOsFqSlK5Y4VpqeW1qFI6XCXUq2Z6TFFEoRf+ULo8H9RnNNxdniHwlH6m26mprRiigZbl+5Dy7CcOzAz788YPL07An8iZNgaFtRhz7R7HgOfSI/184rtrAhkvLXplvDcRx1fgF9MBiwio6usKJgmZ9gZmxqTB/qQrltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o+pco2kz9r4VIOUo+J4s19sdB+nki2NlrgQylBGVGE=;
 b=G8FPbzc8COYpDotKYO/mC4v83FqJfcJA+G18UN/f9e9Js64I3W2Uj9NI2moUVwAqIZWpvrXZP86xMemuFEr/nsTkeU8IGIJMIVjD32VP0NL80Z9cX6RdRWBTZrjtqKo3F9vJuXo/Vd8w1q6YYzku7B7sibfGMoZQreQs8uUR9rcbaCnuIP/CR98Zz64wZlW/qMEVkePTudAD846zU5B46Gn/PYfGWQuU0fYRXUQy1kRVdlrGitvDklhKmNnoBk7DLc8INW7rLefDM1YHy4EMWn3LfmAqExyzoTSPgyHr4wV7KGbcppHj6ivKqytNEy2+MSff6956WhWW6euJiMFc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 18:01:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 18:01:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Wang, Gary C"
	<gary.c.wang@intel.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/11] EDAC/ie31200: Switch Raptor Lake-S to interrupt
 mode
Thread-Topic: [PATCH 11/11] EDAC/ie31200: Switch Raptor Lake-S to interrupt
 mode
Thread-Index: AQHbh/MOCRVNkBgOnEqCktsRR5o3KrNbcROA
Date: Thu, 27 Feb 2025 18:01:36 +0000
Message-ID: <SJ1PR11MB6083A8D348C9DAB38444B2EFFCCD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250226015202.36576-12-qiuxu.zhuo@intel.com>
In-Reply-To: <20250226015202.36576-12-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4653:EE_
x-ms-office365-filtering-correlation-id: 2141ac76-8b88-4d6a-05f0-08dd5758c750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CdR1o88FeJhFhf37tHZ3MXARwRpy//XpnRl57UzM4+Yrnx96m9SDv0JT3Y0p?=
 =?us-ascii?Q?CsH9e66iFaeuNN6E2iRPPuJumohswncXWGIoKxhcIyuoX82OMkpluBIWZEPp?=
 =?us-ascii?Q?Hk+Rv2wR4t5bFFeiR81AOzsJfmjE3etvG4/S9ijS/nJdJ/38wYdpcgoNK0Mf?=
 =?us-ascii?Q?/UznnDAfHRHj1Vr8PF09MKGT49lwU7OyU9qze4S42ES1AoPcyMFfXj/oEjIq?=
 =?us-ascii?Q?wXoSyPKPBV+yuNM4//igGaSPhFfReo/aqad7fufL5EBcaa8j+GQ+GXSNGcQ7?=
 =?us-ascii?Q?4UNHD1L9cy1udrqIb8ffez/zl7R/W3h+SIXNAfHwo0f+PtJzCnylmSCIAnsC?=
 =?us-ascii?Q?1g/GNNIP3sapAf/Tz+BUM1dGRHdnmpxcgP6+I16TKPIPve+v5JHraEW3v+z5?=
 =?us-ascii?Q?3PMeCbSibuvhz2ZjjRd+OdjjtYnrsdryFkmnRRCkXNUNuUmNcWtFEaITeM3Q?=
 =?us-ascii?Q?sXVTgiV1I9aguR9ilqvEE1uKaYJECJ0qOCPXyPwENgNNGG4EZL3ra33Cp2j8?=
 =?us-ascii?Q?WFLPp5AqeKe0Je48OkHIA4RlTbVMQL8fn+riCw0XxeYMJO7BhTSz05LxGmUl?=
 =?us-ascii?Q?qUPRlxTY19RoL/uv2ZhJo39bdHg6a+H0ZDb9rv2cZwbgtuMMb9YRGEPr9zE6?=
 =?us-ascii?Q?YWWVlpv22nTRQFQAqp2ZMzj079K7WHAMxcIQsNoKOxULlpVGbtJUbkL5K/EY?=
 =?us-ascii?Q?lsoZLrk19faWiz3M6qt9H8/urMPgFE5xpkwHhYJQdfRZE9EiMkz6zMEWCbRC?=
 =?us-ascii?Q?TJvfb7vfA4eiNZ9gD75PglifpMkgp6iDAI1QhzJqirTFNAyIayQb3dx9zIHv?=
 =?us-ascii?Q?4dC5s7RYn5bysvQdTILrlFKnsHtnXdEhkXwHFHhyCO0fr8sDVmpYcDhNaZ51?=
 =?us-ascii?Q?nPUJDY1bKp3UwjsxpSE0EjMpf0D7BeZsZHKN3+R2+slUEvIcu95+MnQJoFjX?=
 =?us-ascii?Q?3gcYbEmCz0VjYxcHeDx8BpnjLq1pmbyTdz4cT5ljDoNBo0eRXUbb8Jend8/Y?=
 =?us-ascii?Q?1bH1yb9+45zJ+EAnY8UY7t1Vd/ib9kXjafPIW/xGrVs+5kdYInHZ+zhR08U3?=
 =?us-ascii?Q?Cyf3LUANCKFdAwp6aUzqiI0rMrqwuAGrA47WdkqbigCEidMKMaFRH4tCNWeN?=
 =?us-ascii?Q?0bmgHzzyTkFLR8lo5oD8ILUs7LJEHX+ENSim0wC1aMZiHlYkCssH47nE9uwO?=
 =?us-ascii?Q?d0FsOi5DjdLtVPAfubPfqpa3qQuKE90uEwI/6zHzoopwncdHZBLbkzda/7NE?=
 =?us-ascii?Q?b74c4G/Ywi0t6Bw1tZSqOrNCt1hs9uD8vVVDklzKXyC9N2A5fHtKHCOcRAnc?=
 =?us-ascii?Q?gKoFMbzIChpYY6mUJ629Uaff2ATs+3WV5s2ntrp3w0d/j4UYPKidYZqpuxQ7?=
 =?us-ascii?Q?+WfNxyXqhPxvKsyxJ4yWsI4GiftMiJFY7tnsi5UZ8b1qOcJSkOpQHt6NUZHb?=
 =?us-ascii?Q?IHa0hGLnJpJPq1qt+IRIIDal7xRKnZop?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QsKs2UHj8KA7pMMlsiJTyqi3FR9CkSxKINaPJY2zMwr6FfusqblypOhLIUcr?=
 =?us-ascii?Q?tmEpTZ8B6v2SnCme3XlX97PCjqjABwI17Tu2MjKOgAPaBRQHZ5560b3fJcdm?=
 =?us-ascii?Q?FV4WPhNzMC8yQENknCrdkUO/76NegkvJja1g7dGEITWtLspsmHPVhhzP7rJP?=
 =?us-ascii?Q?7mRE8Sd1YgMrc5bmDZWBj/MWlWin2QYpJWyRqA0JPCuaOK766g1BzIawSnPo?=
 =?us-ascii?Q?kVSFyRPHHe/Q4ef6xOO/cyjt7OB/mK4nb+P61q8YcvMN5LGpVE32mf3mXod8?=
 =?us-ascii?Q?fUHe5P+K4gcxKJGpzjVbYQ15XnKo8IXn7KzP10XlOujTnGHvGwsayjVwrIG/?=
 =?us-ascii?Q?7Yb2FEJhEEuGT0pwnO7qmoCpqXCDfE4dFq2dhShwzohdywHzwU7waudcV2az?=
 =?us-ascii?Q?KSUk6TbXP5S2c32AfB/xHBG7pZZtwlvco1NqtkxArWuGi+zFKuOWxj+JYaGT?=
 =?us-ascii?Q?BezcYibnhXbU0/O8VuaraFHgYsnE3Nzh2KfM0E89nMxq+deWHNkRaNMt8fc2?=
 =?us-ascii?Q?CImVhxglV7VoTQTusunWIxxI924358sr9lB70SfCqijYrab6gmUlOHjGbpu1?=
 =?us-ascii?Q?SahMfmVJofKwxRDYWVr/TYy3pv65mgzFGK9ARDloZYafwQ/+uqObu8tmykdq?=
 =?us-ascii?Q?19RQDgLDEVr7zGDM7YiTGRiBxTu6olgsfOfA5Z8lnDwC3S/L9c+zU5tbtWM5?=
 =?us-ascii?Q?jXoBjHbpMpFnYi6HljrVEzlw6gfT3gufRUFNzqrBiwU5eL5qPoNWxJzLaBwi?=
 =?us-ascii?Q?SO9qVm0ptzUoIfa91f80fn2W+DSWJ1PK3JC7B5nZo1lWXDSNCkRlTciH1N7J?=
 =?us-ascii?Q?Aj9b/grIXoroh7nqDbeNEIrIxuu7BN1cXLxbZBKbjf8u/4mU2QOCUqlqk1Nf?=
 =?us-ascii?Q?8HZ4fANtftLyDeAKk2EDAN7778HtZ95SWlr4//F7WV5yJL+hKlZqa/qHv+S2?=
 =?us-ascii?Q?FEsnHFwe7a90MfOxV2owmaeeDP+8KjlXX4eciJMpvdHimX2Ignagn1DEZ7my?=
 =?us-ascii?Q?3usbdbZ3s8fDbtbsrYiNEPC5MeAn5H9deMgONYtyAaGQPCU/6iecA5HRHe5d?=
 =?us-ascii?Q?iNTZjQCPke/G3sw8Gf5Om6+v3CFMfmc+cmvW2iLu0O5Jn7RGJcD9bpis5Swj?=
 =?us-ascii?Q?gI98c/6ox7CzbETqUBJq8eWM/gcKLCHMIT+IqElueWtgDHojQWiFOTWXxAHY?=
 =?us-ascii?Q?ZZql4L5FFpLx7NY/hL0a7ZoSNiUNY3BKaaXvfM6AqsFYp1MsvrLktdvbpwB2?=
 =?us-ascii?Q?q7wToQLc7Z9suh+hn/GxZW9gTwqNTx24Z+cw4qIhhVma3/Lq0M3bk5Bub5vS?=
 =?us-ascii?Q?7tjCfu45z4p0x5lyD/lRhCMlLgzyuc3GlD+sDCHMkCYnKxcxhJNrGJCxcNNC?=
 =?us-ascii?Q?q/cwLWukek7cci4U9xIBXnbIwfAt2J1U9uGifcBo+e5GWD8GdjlmWnDdyJkF?=
 =?us-ascii?Q?kIE+kjWu4WkFWbPfSwCvwVaRDDY0XU7HdvBZ8CAwDn8q3TqI/Ezl3HmEOz9h?=
 =?us-ascii?Q?R1jijgFI+KxESJJjyUeINFNDsoxvHjZWPQ0lMn6T+lY0ZyslI+H3Hkzg24AO?=
 =?us-ascii?Q?TBbAeL3yqxZBUw2kbIpLX8yGoVAQ5tb3nVnNn5mF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2141ac76-8b88-4d6a-05f0-08dd5758c750
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 18:01:36.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UA/qrsW+XdMIQEWdXjE73UN8rtXTjfICl/OWGTayd3k2woFdvJ6R8jp6lt0/UoYxcxN4UivTlRtiK1k83oFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

> Raptor Lake-S SoCs notify memory errors via Machine Check. Add interrupt
> mode support and switch Raptor Lake-S EDAC from polling to interrupt mode=
.

Is this notification #MC (a.k.a. INT#18)? Or CMCI? Or #MC for uncorrected e=
rrors
and CMCI for corrected errors?

Corrected errors -> CMCI I can understand. This code should work well for t=
hat.
Same for uncorrected patrol scrub errors -> CMCI.

Other uncorrected errors -> #MC is trickier. Does Raptor Lake support recov=
ery
from other uncorrected errors? If it doesn't, then this driver handler will=
 not be
called (Linux panicked and never called the functions registered on the mce
decode chain).


Which is perhaps a long way of asking whether you really mean:

   Raptor Lake-S SoCs notify memory errors via CMCI. Add interrupt
   mode support and switch Raptor Lake-S EDAC from polling to interrupt mod=
e.

-Tony

