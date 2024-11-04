Return-Path: <linux-edac+bounces-2434-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F129BBEA8
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 21:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469EEB2106C
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3231DD86E;
	Mon,  4 Nov 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuHuz1mk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CA70837;
	Mon,  4 Nov 2024 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751425; cv=fail; b=Ep9UyZENq1wigVV9nPJDjyJjNrtaSuxAIpaK2yzHdOWs4bVMdGx7Ewn/4DjcJ3jK9INYBjDUyK4R9vGb+UF+At1zcHGp5jpNdiMFZlodq/ia1JFR7G6nUOLrkrUIi0WaB7ayDKM+AAGDyvnPHUddnftuQE6JMg6C7Z1alIskc/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751425; c=relaxed/simple;
	bh=3HxazMWDelvLn9iyks31q7MZ1ABEomt3IfaL1VYTg1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zx9aF0KLQhTNCzmOsoFkzhieaRm42PdlZUwfy9Hchf1sJiPk7U0dQRl+7jT6ue2xwgAve+KzdobHMJ5dybLOcB8Igf9DoqHXtAJdSipaxxT4d1oR7cdKrs/zlmPQdKc+X1aa1+f7aITqrYK90L1+/ZDsIZt9YDbl8dMbRif1Kqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuHuz1mk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730751424; x=1762287424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3HxazMWDelvLn9iyks31q7MZ1ABEomt3IfaL1VYTg1I=;
  b=CuHuz1mkUhXh59WxPsihNW6Sg4SA/zGJ+qT2eskCrcDp+Ppprn9unrA/
   inPU4VUXOexXp6QbOaT7l9VbvZQ2QoMAfDtqMWuYqywKUwb6qtRy+xdOJ
   KXfaA3qglSLVgqy3vqqlXNfjOB9HRrsNVnDBpxQj6LuBjYuBV0SwScR1O
   BzQ9PiUz4903n6WtMvkar0uJX9kzLIieSZsfhE94OODrZg2Q8sAh7tu/W
   etpDN7YUByiqLF+MLF/WMgqL0Vp5Z/Mj0X7xVddq68lPRnbC9HHTTqx6f
   8Oya9iiD1bqitT4YhZFi0ZaOzQU+YW770alkyvsN8RFKqu1CY+15dR/Q0
   A==;
X-CSE-ConnectionGUID: IYriFTyOTbK9kDcgO5PoYg==
X-CSE-MsgGUID: cCH1OzHIS9mZkdLErGI/2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53037164"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53037164"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:17:03 -0800
X-CSE-ConnectionGUID: M2uDj2bvRR+ysAU1MrqpIA==
X-CSE-MsgGUID: F3dsdSF7QNiD74iaVdUAOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114566033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 12:17:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 12:17:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 12:17:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 12:17:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in7HINaJZFVPaHgojrGqtzBRGUNNBaex2HWh6IjBPH7NUNlUv5PtNynVQGL5m7jKQBiMY93HwF8P2Uxv72PVF3+JGXvVlPq6VhE2R3nPHydNv4et3NPBGbRcA0uWnCfRBN5WYNM8jkqdpTSLWCfCnusPSozniY00v1EiJOUyOOI4UHJiixpg9BRikHE7YbembPBK89zPq/+Vi+PKxMfA3vKzcMaE/A2RhOEeZLaN0g3IvcOYhKgJoYH4w8Qm8FshT5CvJHdkX1bBmSYuigMYvRq/BZDHcjfHD6zYNr9ZBzPOLzolShJcHEsoMawucSe4grOEgbrmkw14mAiZVaPNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMq540DD4RVFy8UZLKwmJv8pXBupvx4pdu6WalOeHWg=;
 b=TTfvvv6qnJkF1FhUSbrf9sgqwDC09M3m7j7fI50ghcK9wU6SAF2qXQ/wdKeQaEpBycpKo7YhwjXdGRYHoZS6D/6oITeAyeXMblFaVoErss/6i26E3y1dYxTOMjgYRsq/7tEL6Y5qwlHiQxxchmDcYPvPVgQLeE0R5Dhb1T5wxWL56rWy5ukqSOJCx2wcaFGT+5thPMwddXs9VysSaxhV9C3fGG51Tmcs6tdFUAgrYoOZZLaiAdkXeK/28EqXAYSbjoWykF99VtttxLU5uBQOlAmFAazL9GurT2zyPEsuCJWpNnYgrKxEjZzsyQ9xQpQFgdu0okIZC+k10e9RY06hWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 20:16:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:16:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Orange Kao <orange@aiven.io>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 1/3] EDAC/igen6: Avoid segmentation fault when rmmod
Thread-Topic: [PATCH 1/3] EDAC/igen6: Avoid segmentation fault when rmmod
Thread-Index: AQHbLrcdAfTznEy/okaqLq2gQCGWT7Knjo4Q
Date: Mon, 4 Nov 2024 20:16:58 +0000
Message-ID: <SJ1PR11MB6083DF5A4E9265504AF7C339FC512@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241104124237.124109-1-orange@aiven.io>
 <20241104124237.124109-2-orange@aiven.io>
In-Reply-To: <20241104124237.124109-2-orange@aiven.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8505:EE_
x-ms-office365-filtering-correlation-id: 0a4bf84b-dcbe-4d09-4d46-08dcfd0da2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?K0rEUr9geoc892rF4IYcVUPKzlodfO/nEq8TccIDXKqaOckfCPYqqEcWmm8/?=
 =?us-ascii?Q?Fdre32cU8E9QxBmZNk5oFgyl4qPLhaoldq7mK2CrBMCqrM3ukHXcN9JXTNum?=
 =?us-ascii?Q?jmJVB8q4TN3BlvwcYIeVrWQ4Bw6D7zVF3BT7YPi1tU/0F5Nn6DO+oLBarFTB?=
 =?us-ascii?Q?EdEM503OYhMhCAudoByYCHKgQPPbWXpFHGNPwafRTmc6X+93rMz2jG6GjWxq?=
 =?us-ascii?Q?DjSCg2VVSKxZjS4WKgVF9/CKUi2ATzQR3mOrLDIHLhXKuTweVe/1zYkee/Pq?=
 =?us-ascii?Q?2sSqIx1dNJCMeAtwZXls0/HjhVadxPeGL5kbC6F0gX+6eTEO+iNKJrUpt3BF?=
 =?us-ascii?Q?J2v/S0ltOHVCKr/7EXppIGcYdBiHbwbxxXmQKUi9AzJRc0hKHi0j24wx0mHZ?=
 =?us-ascii?Q?FFK/RVHUXEwFA8UuIVWFqm951UwPmoAa9KG9kQO6lvmv9K8F/BeAqAN6/6Do?=
 =?us-ascii?Q?bAK852Str2WqS8mZKanQAoo622B3A8wD9NKcU2nDOCE7RKu7fVCDe1nsJsPI?=
 =?us-ascii?Q?dVGfXj0naYvU0h4F8V9DZmWrh+GyDgscKgycSC/BjlNhHF6816xywKb1tFqu?=
 =?us-ascii?Q?Sg3jHAIbcCKgyKwZGhr06IdkZ0ukJof1n88nQHm2at5MeOenYEgoeTKsztcG?=
 =?us-ascii?Q?P4Pr8YThum6KCzfCOx9baAb31lWjxyVA8l/M9xNu+hwd5mY/h++D/T1GPiKs?=
 =?us-ascii?Q?+IwaFpa/eJCOdjKhtGV551FNcovhStsox3WN9ZcQ0DRWMKqVoL6JGq74JKj5?=
 =?us-ascii?Q?rdoceLKvqCRk6hAu6hVLWquVHr+R3J/AG/moU1sL2sirRiweTTXbxvDlVqMg?=
 =?us-ascii?Q?uhYlumfsY8tYOa7catiugFGZ7yeiSc+/sZNgKowpb7o8IhxFkMN+xiC3JCjw?=
 =?us-ascii?Q?ld5tQ9pKbmegfJm2ISleIHMAcSfeLwKWZvM+BGYl1He8ma5kt7UNdfsSyvED?=
 =?us-ascii?Q?g3fpfzvIK64cc2NQ3f8ta711HREaUze2/+L0bsKuHu3zkQwU+8OxBycXBQoX?=
 =?us-ascii?Q?8oPcCeSs4KLIWlOCwMu18n9WVzsoVZN2DsTB7RjTdsA0wZnguoywuUHsRb6B?=
 =?us-ascii?Q?fo2t5Fw888Hn0TggNO7TGPuqAWv/cSJ77hLU/XBLywJnPw70duxt0Dxb4KAQ?=
 =?us-ascii?Q?Truw227LcrGeSIcIje+wjWNtjdbutn6SfvB0yzg9gxUmJWYrwau6MOV3vidl?=
 =?us-ascii?Q?znbew2GiQTOuNTMeVcuNYRVAnRhD/5W7E45oWUffqzP5qV7rQ9vxekK6APk+?=
 =?us-ascii?Q?Hx+15YtuPJcUn1MdQOQOgsE8ekYWLJFCfM+Bp2u2S2ctg2eAKYsjMnbarKnP?=
 =?us-ascii?Q?p4uEikuFsIvi5OMLXC9tT4aWc26Ba/kdMmr3sNoMaPbKDkYQW+JRO98So2sA?=
 =?us-ascii?Q?4cei0fLjyBjw8gGS0TAf8/SSXz2q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZAI+JEHDXQWhvlkfrRprdLFFKK0j0LoHTA5zZ9CLAKCE/NWou211SAzp3CV?=
 =?us-ascii?Q?KtjTkB8eyvtaPoBQBEljOs7BfohFO5+JNz2fDYj42y13Nv0czva48MKPpgK6?=
 =?us-ascii?Q?3ziiVl6Sk+PVj3FQ8MzheMkY3aOV48wURmqFPY+6hcDckoKrC7RwNqMXACaM?=
 =?us-ascii?Q?0qNaMurVs6LaCA9IbKUXyGtAv2nmkv7G8jn+XuECug+9Tk0QsptJKT+4dEtf?=
 =?us-ascii?Q?dlw/KwC+vpUxWy37lYaUu33adWtXQgBJ4rPelZ2ze8EWOQkp18JACA3OA3jn?=
 =?us-ascii?Q?hy8kWwLEJdjgV650aSJLwfJBCZhlDxdiX/99qanWESRSQ7Mh06TTWpQuTxcJ?=
 =?us-ascii?Q?5xzOC681zYYV1rmefkM9X0f4FVQZ3KWvkKBcf0Yn2PeVZJGodv31Lg8k6sHN?=
 =?us-ascii?Q?y3d8qHfhw/JMZVjlNgeKrTn1L0cheLO7wAT2Hcpc6hvolqJt44UCHxjVva0C?=
 =?us-ascii?Q?GNAVX6E5RCw1Q6peMP/+XWHgKdMXxDX5dd7iOf1wd/CbqbwKEE8XuGxiZKay?=
 =?us-ascii?Q?02j1mRngLEUxuDby9JW1OHwChHqP111eCLIMtnWNZYJ95nMAtY9b+14tmPFZ?=
 =?us-ascii?Q?YAddaWBKvIlKarMYtjcbYfGYvpiWa67rfkavyaUhB0M1wVVFYPcfZnt5WR/j?=
 =?us-ascii?Q?dmuvoSX22qigpfuZgWDfR/rQRXls1yBukJidqdFCmRg3MGWlXiDEgeDE6sSH?=
 =?us-ascii?Q?FyLTzEyq3x0h+cazEB4RFv11EocnRj694Xs3vgTltr4M4gABzuAY5HEl+Sk0?=
 =?us-ascii?Q?JaIAH53x7zKrwy8qW4riDvA4N4wKGqU/VLoaPWwABJu6uVi7ubeG5mPmW/Z9?=
 =?us-ascii?Q?CS1E1xaxEW8i/6LC4YlAf17wW/P0U3tCuWT0fTvHLy+zwGYZyldWRrlho6uU?=
 =?us-ascii?Q?VfvOT8NiMlLOS75wxJe5yRjGY/eOb9j9d5x2CD/T7YtvVntGlV4irDR1dz4L?=
 =?us-ascii?Q?uFQNLLzIqQYrWG90mOAfDh/bXU4zT7QNlg4Wse56JjrSb9rmmMKhoVzmgPU3?=
 =?us-ascii?Q?X4Z0p7sAwFz3AugJyoD7bqGglHY9jhi10zlWFMdrg++cdey3DbOEubV5kVp7?=
 =?us-ascii?Q?K9tCsVo5AgoEdPjAiVwkZBsECUiixR1V4my9RlWtTIOm1e5cP81bWNemJ4he?=
 =?us-ascii?Q?ay6WPiAzJbQtbBOllIrUNy0P51yixyjgCI4bWlIVfqbUFpEcsl6lGbB1yYLw?=
 =?us-ascii?Q?9lr9c6+jfGvHyZBX87nAarK4E8UE744cfCi+PKIZ3oxPRtVZXhfv13889Ygg?=
 =?us-ascii?Q?Xy19JCfk80O3zp7qYpiHbUU+2KTlGWrUAh8dCd7IiXW39Hio1HESCImMhykY?=
 =?us-ascii?Q?Lyk9qLXCTHb6/V5z/HMwtxWhdbAsvlxXShpqp74OFEe0BXCA67SV+qy80DrC?=
 =?us-ascii?Q?8hgUTTzrme2Qwc3YOL2Q/5SClfQOpRirU/i7smROacg/9BTWWRPSs1TBMiN5?=
 =?us-ascii?Q?Qr+Sg+VSNbtL0Ze+YJX3hvd2M5bxf0DHVPQLw5yiOgOxWEhVnh2oVrmV1b6F?=
 =?us-ascii?Q?PHpoDIlbdBjSuflmXDRdRaHXfyWle9dMtFBGHBhLditsPRhj3+X5UI7/hJq7?=
 =?us-ascii?Q?FE1bEtQtL/4vFlJPylaZkO5vY6Uo0WqF/ziw9x6G?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4bf84b-dcbe-4d09-4d46-08dcfd0da2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 20:16:58.9546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2q695J52h6BmwURDVnktoazy0/4AqCQL/76NIwKIFGBbNfpYpSB8B3S+X8f7Pk91EjT6tE+6IYYdhXe4h55mSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

> The segmentation fault happens because
>
> During modprobe:
> 1. In igen6_probe(), igen6_pvt will be allocated with kzalloc()
> 2. In igen6_register_mci(), mci->pvt_info will point to
>    &igen6_pvt->imc[mc]
>
> During rmmod:
> 1. In mci_release() in edac_mc.c, it will kfree(mci->pvt_info)
> 2. In igen6_remove(), it will kfree(igen6_pvt);
>
> Fix this issue by setting mci->pvt_info to NULL to avoid the double
> kfree.
>
> Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs u=
sing IBECC")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219360
> Signed-off-by: Orange Kao <orange@aiven.io>

I've applied this patch to the ras tree. Thanks.

Patches 2 & 3 are on hold waiting for an answer to Boris' question
on whether polling mode can be applied automatically on systems
that need it. Rather than pushing the burden onto the user to use the
module parameter to select it.

-Tony

