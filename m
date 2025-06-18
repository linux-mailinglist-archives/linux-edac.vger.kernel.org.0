Return-Path: <linux-edac+bounces-4173-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDEADF19B
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 17:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B081882697
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7532EF9BD;
	Wed, 18 Jun 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcUSWCfz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DAA2E7168;
	Wed, 18 Jun 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261377; cv=fail; b=KT01W+PMWLbGy7hvjg+VqbnFsCCoZRvHeczToQiB2ZRS9mws/Uw/bydk2akqq/+TdYzpujHKNtJtv8M7Rv1D7Qpo6ItRyiM0KOAXLxyb3DPBHZw6elJ6Vs2LfZhUmhZZtdzOpus4q4yNiLcYyJuWXGIvjZp4wVbnE9uEwyq9vcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261377; c=relaxed/simple;
	bh=AANZQ+hsfRAJWUNWQsSsvYl10Xe2oouzyAbMJ8M+n4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSFme4C7i2a0qfXe14bv9RhWJQjnUlK/AbTHtsWjo8uWl1QywBvoJ+7T/m/0bfJC2Agl5HotVTuXv4apNvtL8BtTeZd8g3eUeJeBmRttm7hR6P/5CUBv6fMQN8PI3uNS5VPZewTcSV2FXgOqxDm2TSPVKqKWsrLGCiemyPH81Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcUSWCfz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750261375; x=1781797375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AANZQ+hsfRAJWUNWQsSsvYl10Xe2oouzyAbMJ8M+n4w=;
  b=fcUSWCfzaN7P2TE7jIR9bpSpfVMkDHSRFTADzPj+tneh8UT7y8aG7t8m
   7Mdat3wkod/v8bZopx0gPrES7jwsDgIdMEmxhK4fOyEvRnKs2Qw7WLBeU
   GcK7v78cG7WoBE4rm7frzGWieFPZFoVrwYqy0a9xqkAoRlIfExmROyuaj
   dAIdRt5T4KyYSj2sGWDIyDvHTkmRanRJCjj6dKrIgl1IzYYnNFZPb3/Gc
   3YW9vedOM5VtsqNKr6Acdpl8YlkT2TFpPSotW7/F7zfMxq7ZYJTmWhjoa
   jYm5Zp+umXWs0MO46n02w8ll0hOAoxHNeDMRd22JeRGK7DXY4AL3ScIbn
   g==;
X-CSE-ConnectionGUID: 4yEb//jZS5O7XU8px93VOg==
X-CSE-MsgGUID: zjehBIKaQfStSodcThhgQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52462631"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52462631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:42:52 -0700
X-CSE-ConnectionGUID: s2bIus+TRaGFmESid1EcvQ==
X-CSE-MsgGUID: KK8KeudJSyqFP2atRHnDsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150511415"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:42:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 08:42:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 08:42:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 08:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2aip5KXa1g6LZpsyOitoE9O1wrfcf7H8CuWpP/ev89APWGa79nG1a3g1zNbCEuxMTDAtGnvOzaY+bX9i5Aq4nNrf3ZckNfob2JZdhIGp/vTDzXGGCCb7/03lLoAqF1lrrMICCvHhS0Ang4n5h4CuyoldU2JCobEEKZnzvH2xfRWXuQmrss2SyvuSZIXF7jOanFTs4KFRkfvaUkyWuP42IbVNNSfWBY444JemW5bqYJsM4vA2KMy1z7d/RiyW2CXUSIH6hxEhc7zlX+xvUcgbBokVGA0XxqNKnyhkOYG6KfFLRs4z1OmUO9UTREnDkdSQ9UqnZ9K1cYeX6a1yPyZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVwX2wefnfQtqf7JSPvTizTAy6qpRdRZ6+JZz0HV5KY=;
 b=adug8e6+hzlJ7rYpelMLbRnyjyppdEUipCgvxNiIckOWg4pF02pGEZqzFOgH4h3rtlTgyS0+CU3J+Kk6E/GPlHIZqwsPPT6DKxuvW9+OVAdSLShhqVfvRheqYt5uPoDIf5GOzaOJ6XOz6LDsl9wkLbgshvkcJepEj7QQ2zGjprdCEQS1ssyUqwBHk29R2p/VRBTEZngPQY3Us3UcUmhha/BmmtzDQVdjTieZl7M0UJgvphXRhZWcGkbWD6Lu6X6ikv0jxQ53h3Nmh0XXdXUxffx4S58QDSr8dKMxKRxOVnLuxJmsXDo4jbcrjEfT5L8ECgHhoykcOeS2K4LoCVubGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB7988.namprd11.prod.outlook.com (2603:10b6:510:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 15:42:29 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Wed, 18 Jun 2025
 15:42:29 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: Borislav Petkov <bp@alien8.de>, "marmarek@invisiblethingslab.com"
	<marmarek@invisiblethingslab.com>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Thread-Index: AQHb3//92oSRM+Zs5UagMHP66pMForQJBQGAgAADjiA=
Date: Wed, 18 Jun 2025 15:42:28 +0000
Message-ID: <CY8PR11MB7134B9350A5DF2AA69640D418972A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
 <aFLV2YMOzXe4iP-I@agluck-desk3>
In-Reply-To: <aFLV2YMOzXe4iP-I@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB7988:EE_
x-ms-office365-filtering-correlation-id: 10c311a0-bebe-4aa8-b48c-08ddae7ebb70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZuMCAD60+xy7LpMGkLd8XiJuzhdnCICTvWyNzb+/aQ2a+sghkZPM8eKDJ+?=
 =?iso-8859-1?Q?PMYbsr4/12qquUeuJleJwR/YISF3eRBNMjwtK2fxkIcoLaPlth2DOCKOge?=
 =?iso-8859-1?Q?2CrVGebi7Cn/wSDkbdjwyaIClipoQ3Hz1EHm1n3+YGo5EN/uQVC0Jlfyd2?=
 =?iso-8859-1?Q?7y/2OKQWm0qryRJ8ahwrFvMXBdk3MTFonNOfyUH4gtyMsFAsp5sGr2VM/x?=
 =?iso-8859-1?Q?C+5rYWXx7zBFJL3dzrjcOv1hzZmz4k8r6/imdbyYT+WeeOeR0+u6r3vZYj?=
 =?iso-8859-1?Q?dm3/pLYkObyxtP6dsIFsijK5J/LEutY3HKLb3KK0uE9O8nc0NkUhNeQEYT?=
 =?iso-8859-1?Q?xgKrC0gB1109MAsx4TIUtOEJBc9olJwWtYXt1hIm/LJO7XGzYPT9ncjvai?=
 =?iso-8859-1?Q?GFFhIoEBj6CP8MWUUjq3p/AVJF7XyD/mbia3D7j0t2Vc6GpPwR0Jwu5qLX?=
 =?iso-8859-1?Q?AqQVdl4GSmsYHZNH2OgdFtZtB7KN+HBMUVvlddASWUCPwppNwLcSfljn/e?=
 =?iso-8859-1?Q?BrpQyNgnR7Aopfscp7xBIKkUDvjJLMnP8hqRc+fpA5P/gc7ft/aaAEOE2c?=
 =?iso-8859-1?Q?hsgnMg4WYWgT7dC0SR2rz8GKmuA0CCRL69fmdZ+HIVLYtDRqMV+9tiAao9?=
 =?iso-8859-1?Q?nuAfVSx9Jm7wC+WP6qGJFkRXORgt57mk/6oyLBoam1qmVuYEpWAaZqRn47?=
 =?iso-8859-1?Q?nYku7a9rz7XPZkAVAXBbPTZppg2OVOUV/Wkv0vE2ODT9NB1Dz0SLOgYiKS?=
 =?iso-8859-1?Q?VVMgZKbipoWnnWXIsrWbbllQmcmmkuXDxuqtz5q9I3gXuSze+ynufP4liK?=
 =?iso-8859-1?Q?Eg+Usx2YZWxwAnHYHR9Q/ouuCGxJqw0Uv+9pLgT0+Y67eSiFrga5/iN0Xr?=
 =?iso-8859-1?Q?5roOgcuUjfNc6+V6tEKyJzgl/ufb4x+xy+6AVYbuFeP8/HTUWtmflD5V6b?=
 =?iso-8859-1?Q?SMyW7zdUcDA0uf4gscWAiS4ZteAqGaGFHELzii2smrCtqhCAN4dgpfx9Wp?=
 =?iso-8859-1?Q?fEMiVY6Z2iqaJvgiiB5/eqsW49x3sS1Rzrk5zb2cIpwLBywaeqqgBky5hV?=
 =?iso-8859-1?Q?XvDt441fCZEVdb36lfj+Dwl08DpGcHCEbYRpaFN1YKOA1IWB0jqY/hiP9a?=
 =?iso-8859-1?Q?rYNUeVqn1wNgizC5cLtRzEsjJ0eW8pmkKsEDEF8Ji4/hFpBvuAHuGkt8/0?=
 =?iso-8859-1?Q?KoRkb+VYyAWzg8UK/LALbOw+7l6arr2FIoXMPSu+jyViqt18D2+3ITjrQB?=
 =?iso-8859-1?Q?i6+mIbyusvvuAY9jD6RfUP3ed9Yh7o9YrFV9iI4BpjoGO3Vlah7U8M0od4?=
 =?iso-8859-1?Q?JJFMLYuS953KHLH7NyYTXpPjAo6AQF5+1OdlqcL4yYZypI53TYbX7Gr4/Y?=
 =?iso-8859-1?Q?i415U+n2o2hA5sXddUCOrx5WBRej+Wkw4+a6/1Si7Xbkx6oI0J2CP8AU3Y?=
 =?iso-8859-1?Q?UssGQWqrTUY26JD8ppuJpved2n0IkPbhm4Ze1ptbs4rAxalRh3pUNrlCDO?=
 =?iso-8859-1?Q?70+9d0uipdOng0dMpT04HEgfsyLHq0p/yjttJQ8Y3ZwBuPnGipt2CXdsU1?=
 =?iso-8859-1?Q?F4Bg9I0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2qbKYf8hJq4kJu0eRwhjprRaNt21ZxtdSwSE74p0VosesHl8M17j9eUw9w?=
 =?iso-8859-1?Q?LUIrZcg+b4zn/9N+IwMw+CRWggypInVNNl2V4wiA53ubAZQRGbqJxj0IIY?=
 =?iso-8859-1?Q?7O67HrfLShF/OhMLbYJc6WcbobZLllKKIUXglW0yrZapGjF2Hc0r7fdOmM?=
 =?iso-8859-1?Q?hKn2AO7I4Q5hwdZJTl95orc8ni6C4KxKQWnBqp+WmqXgO4vIY85pJYff/z?=
 =?iso-8859-1?Q?wlG5adyPUKYP5lP9jfFJ8k5b/TI0qQMEMxLTxV1r5R63g/o0TE7+e/EUDs?=
 =?iso-8859-1?Q?qtJQLZ7XD1J+1fRIofxZO3S/Y8Mnwm540PkE2dqRQfDlGH5daAHSh3KYxK?=
 =?iso-8859-1?Q?HZRLnzNay0Kykb3aXTavLxb2IJA9M5GOqFgXkAmKgWdG1E1vlJm4u2ijmG?=
 =?iso-8859-1?Q?d7CJzn+IRVf+S+HzUaNCX1Y8KttKeii045Ibjc0RZIfzo6BUZEQE8y6f61?=
 =?iso-8859-1?Q?8uOkDUjZ2JPMaGDOI74I2Z7VtnCUTHgdDjECvxPgRTCTFXjYx9eMVdd+Yb?=
 =?iso-8859-1?Q?Y5bKzsBiWvaghr94frd9j34PXB0V9L+zRKOY5J2gWaQxld/OjhVTEDvZJi?=
 =?iso-8859-1?Q?FxxIfpDnropVLDLgYS6I+YipdYsF2OFaJPPdNJALk6GxQ/Y+CnVuz5qfLh?=
 =?iso-8859-1?Q?2mNsuIHPRohV2h4jijBG/BXwod37F/2xTKcYGdIU65IxD3Lftc3T6V2FCn?=
 =?iso-8859-1?Q?QtWRccSmjk9ymTcN0frR+aoJ4ZxksXV+BoM0I1sy5hj7o8oqXGPF+/9C7V?=
 =?iso-8859-1?Q?oshPEzAvNV+3iz49dagZ6z626uWC/J3rPd9zrtNZJPgLe3jNHIlhnkgicO?=
 =?iso-8859-1?Q?N4wBUcUEL7+tjwJbRc7f39uWPoquKtnbncVYtapqgKyyI5fxV44dZ2jDu9?=
 =?iso-8859-1?Q?7hddWHGd1yWO0XTfKorIEU2gmLOb+I6yN4+MlNA/lpztXmaVemIzHCYod/?=
 =?iso-8859-1?Q?hMRg9/u4Nhh++kn7V25w2ByUz3IbQ04j60lG/03AIqCGa6jjIZGpxV4N3P?=
 =?iso-8859-1?Q?GxYM0g4WMEfbH6mP7BdjNBV/cI7F4TZQGWF+o0F0cjPjxIHAfPKtp6M/5a?=
 =?iso-8859-1?Q?A8wrNb2b3m8EKikiDMfZy92121sDTaSksmEXwHTNgLn4l1fhayHj7Cya7A?=
 =?iso-8859-1?Q?kqtyE56L8eL8BU+WAePuyu2jY/UXEZSHAoV7ZjyThKfGYNymlcvtWl+2oI?=
 =?iso-8859-1?Q?zHkFML5D7CI7Y6xmlMpQRmZamRQGoUxFtdHRS9uATyfOSfoWiSZYspk8Pn?=
 =?iso-8859-1?Q?tOkg1GeA7d94grorY0jX8f0VjnEqI9t9vEkhHyFXAHZAFrUA1jLf2YRvcd?=
 =?iso-8859-1?Q?qK1zmTkXa+ao+1tnf8kCCE3ldOCeK65MJoKXwH4RRXl8olNZCkmw8R674z?=
 =?iso-8859-1?Q?Wy/lC/yY+m9W58oI6tmKmWeyzqBbgAjYgFfwxi+WOMXp+N1ssHtDl5SYLH?=
 =?iso-8859-1?Q?DyM4fOGlT3BLYz5dwChjRD3xyFdcclrI25ttirKiZvyWMIle4ykCAMDYBy?=
 =?iso-8859-1?Q?JoSykm3lIVsT3KK5ZuJG+bPRHxKUQRmaqCWbJ3O/GBycnAOs5HK6O5uTBT?=
 =?iso-8859-1?Q?FHQb+NTSwouegWILNGSLYq5EQmosyBo8Gu8jxi2VHxAmBGdsJxO1gYefjG?=
 =?iso-8859-1?Q?PhPpQ3htOhe/hiebUG1SWu2AclNrLF/n/Q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c311a0-bebe-4aa8-b48c-08ddae7ebb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 15:42:28.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Odhe8mjgVARljfQJ2wCWk4GWgxMrpNgLiPu3YiNE5c62VfaPLu9rMxE2fpJrc+VRy0ehZuRTb5oy8YuPRMmyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7988
X-OriginatorOrg: intel.com

Hi Tony,

> From: Luck, Tony <tony.luck@intel.com>
> [...]
> >
> > This issue occurred because one memory controller was fused off by
>=20
> Maybe "disabled by BIOS" rather than "fused off by BIOS".

The phrase "disabled by BIOS" should be more appropriate.
Will update it in v2. Thanks.
=20
> > the BIOS but the igen6_edac driver still checked all the memory
> > controllers, including this absent one, to identify the source of the
> [...]
> >
> > -	if (lmc < res_cfg->num_imc)
> > +	if (lmc < res_cfg->num_imc) {
> >  		igen6_printk(KERN_WARNING, "Expected %d mcs, but
> only %d detected.",
> >  			     res_cfg->num_imc, lmc);
>=20
> KERN_WARNING seems overly dramatic. BIOS likely had good reasons to
> disable the memory controller (e.g. it isn't connected to any DIMM slots =
on
> the motherboard for this system). So there's nothing actually wrong that
> needs to be fixed.

Yes. That's true.=20

> KERN_INFO is enough. Perhaps KERN_DEBUG?

Will change the log level to "KERN_DEBUG" in v2 to reduce=A0noise.

- Qiuxu

