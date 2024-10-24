Return-Path: <linux-edac+bounces-2224-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6629AD9D6
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 04:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D468BB23033
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F10145B16;
	Thu, 24 Oct 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1F20YCB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA35143722;
	Thu, 24 Oct 2024 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736472; cv=fail; b=W5NkxPt5pVbEDJpLOheyXqI3tvHMpE8TCBsqtZEDVWcSyy5eZbsJ+eydzEmrD+jrBEf30CS5cuohgMZXGsMy7NQy0ly6dwFb5wNY/5COl0WJdV0V5aP3zpp6ba4jqQo8XX/gBqtdd88utZDdWYN3+SxeLUGOpWZkRAH3JjLXAag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736472; c=relaxed/simple;
	bh=irEqPGEe4L8XMbkHOZrpv11DPdXKg28z3sVXrF+BeoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5fQb/2MlRcEmmp+brM0OSCzpaPZIC8ceOUmiFA65QVHiZlibD3tJQdKBlTwIVPUilAbcm8j+Mq2cyUQSXatpEANIbbsKBjzA/T7+J6CeGopCrAHpvYLnF5eVJ3XdfMck7FPy8EaQ6gZx8dJCwFPMeiXl9e4pT0CGF1Xye4Rdb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1F20YCB; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729736470; x=1761272470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=irEqPGEe4L8XMbkHOZrpv11DPdXKg28z3sVXrF+BeoQ=;
  b=c1F20YCBTKcQ1n315ZQaZlEgbNPIAqFwM6DqFDT8pto/NmgQ4NTyf97r
   +b3PTPlpnZOZSEyEQUYoWpWNH8Nr444L77PC5m5TVExUOPkBDSSTY6aB5
   AFYJx5jjdv4jPq/h9IEVaB2hKWH71kThyvKpdwxlVKyHj5EQ+ICreqThX
   I3ExpAd4lmjrUePm/BHa/FJEof42ROPrCcB4Lc9dbq+RiNIAYexWXrAno
   aGIdIl4DHy5JHplIRn86rjQRLU+nzmDcpD59/koR+OEg8VBObDtwPPk/D
   8ba8QkQ50oL0+oaLxM+vxZt2PMi9ArHKeYcDPIsKc++cBByaw1B9+MI2N
   g==;
X-CSE-ConnectionGUID: p3+CkkqtTJ6f4tIg5C0iaQ==
X-CSE-MsgGUID: bv7+D14HSmuCK6icIeymRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39935333"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="39935333"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:21:10 -0700
X-CSE-ConnectionGUID: 2dgp0sWPTK6RS+HAXc/ilA==
X-CSE-MsgGUID: mGItSZpQTOyIgxcvzGu2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85560782"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 19:21:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 19:21:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 19:21:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 19:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpcOiN1qOlbLGW513t3UdJlT62eTsEvZbFmpVRgy4U3/t5WBoTvTfLnvu9tAM8j3HEiLFDf6ROys4JMYqN8NTpXmUhmTGixvyS7pk8gkXklsHVqmwOr3eygfWw/OL93xdd5e6Pfy8HswvgC35eq15ZR8tAV/9F7WQ/IiCCxrMiyM+c4LkJ9voh8ek51UH/FXrBTDMT44Ms7AxkrTw5L/yY1h6B6hzB1rRMRQPCskeF3pdYFczEPrqLaQcJ2gCBIChqRl+HiSqgTXIWI/yw71Y9oj9qHro4kDsOTzeDXRjHvYMKYczMtFC3ftDTxMkkN92s2tm+wImy2GIwC+rEHexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqI+rc6s/NU8V6DoyzppU4TPXPK5wcEWo++l6OqumaM=;
 b=GQJ0R4FfmmmPAvfx1t66Y6aq8AvR3/42E9dleU2/ztnlGGf1wScev1e6vWbmw/yhyZAw7bMXl5qssSzu+u3OrE6wmCjveVoAOlzDVzVwEHyLvbl/JqupZ4PXTig2d2KQ9g+LSNNsV5AAqR2irzC7sBeQmXa3WmoIma/4vctBZ5lnM35B8c3euhOdSyQLUgFpU7SqSQnc4tiqxrYisONf+Goq0BVjCo1GrEHTJO+0G+71bDNj68PP7JAhBOhUFu47G7GBa9jm9XcvwQBjxkKj6OInENvXRbLEc76mKpP9mHmqdSA099su59uqkE7bzuZDFtnGTBG8Ststjtg5LzlMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 02:21:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 02:21:05 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Topic: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Index: AQHbJLqN1+pvEpVD2Um4DnhEfAOoZrKVK/nQ
Date: Thu, 24 Oct 2024 02:21:05 +0000
Message-ID: <CY8PR11MB71342DE5B54F519A7E7C882B894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-2-avadhut.naik@amd.com>
In-Reply-To: <20241022194158.110073-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA3PR11MB7461:EE_
x-ms-office365-filtering-correlation-id: ea22f153-1470-4e54-ac29-08dcf3d28387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?koGenlKLf4N2aNUiLSKZyMja+uq0/6L0S2ld87q8ONId/vh/ABkLuCB7Vrj7?=
 =?us-ascii?Q?e05t16YGa/ez6LbdUhWM8lWqsuvmkutkGWjuHV+ufmQ2xLP3k7xJWes6O6WO?=
 =?us-ascii?Q?EAe7cQWLmsxSTEgd09DThP/oZLgSyWrGcEwDpBUeGNXM7JM+pFlnyjTjZo9u?=
 =?us-ascii?Q?+51iK42TbFitzZNxPJeIUyP0kCE8n3lCuKEqYH5zHs3o43VXXaAjUnxpneLZ?=
 =?us-ascii?Q?GF7LSnl0QbqDhCqlKDzQhcOHrBvUwc0Nqo2GwcFToH/sEWHgsHgqQUVAzQXX?=
 =?us-ascii?Q?K2PXB9hGkfN7zGVluy2NesVQGI5B5VAL+6yi4PqAmnNc17Gq8XcyfNtCOY+9?=
 =?us-ascii?Q?apShWVcBXt401CgHDv+ie0RgMDsZ5ESVyi7WWDqbTq9AehU4Sdkw5QQFtTji?=
 =?us-ascii?Q?R3FL2NIS/ab0BW9aWsfUyQ81/BG+0Mz6UcGtoxA4xEWVJUiDqVF3KfaxnfEe?=
 =?us-ascii?Q?In1l5MVhnS/qZ5MSd4latUNX2j8dP694d4NYpqiHgG8NRZKApYFhgJdHilQ0?=
 =?us-ascii?Q?oMsq59K55vvbS6+TLlSHCQe6WwJR1FRTg8Qst78Vt+ag0JNd5N6AKC2kexz4?=
 =?us-ascii?Q?zKJtnjpHZnDV0odS8ZZMzgl01FgVzCf4BD5rA6D16n9yFraqAEiYoLAtg/iy?=
 =?us-ascii?Q?coC0phG/d2D8mmgULmv1APWMgzz3eBE6MWqPXHhttGX1hysragYiF45zLbsW?=
 =?us-ascii?Q?mQkVCZjD+hBH6HyC6TpDAFg5Mp5L+bElKZVXFszgXtHVRe6ncEQnO5381NoQ?=
 =?us-ascii?Q?pJNDx3j03Y2gxxAKswXL6Vwmceyv2o5KJ9A4w6FwgBaR6PhOvQqyKHkmPDJJ?=
 =?us-ascii?Q?g0Q65s+P+WGOMlO4yUMn93f2JBEGqqdxJrLvZuy6ngMYwbVYd+0hdEkyc57t?=
 =?us-ascii?Q?5+zs76I0FkYGKE+alXSRqMVykBiGBu1CaWx1rOWVL8cA1Ty9mExcGTSJbnea?=
 =?us-ascii?Q?T/t7MyrEh1a3kJK96WXYdps0amvulz5QEenJdydIna37mFnrIid2vGG4cQoU?=
 =?us-ascii?Q?qDDRNGFmj7aDcw8Le1mcqEHX5JvOPFkXMtNViTaHIYawkkUZ2IBuWHJVcAC6?=
 =?us-ascii?Q?u0/n3s/ru3XPhL5TmqbrYD/PAK52+iIfCazk3zrpT06B+yVNSaIVqnVX5sZ1?=
 =?us-ascii?Q?ihzV76IUKtMZVkXbcgjSWrq6pQk1rbqoR2GvzgBrnVDWHyK7f+7YvyGyMCYn?=
 =?us-ascii?Q?025uTjdSOBIO7GLhTAXBwIZxGj8tyKEi4MfuZciT9efEhipQfO1bzsF9EoeC?=
 =?us-ascii?Q?sEbroTsvekEQTOpoL6daex3ZqUu/tGPxngbT1UGgPb3rbhBYMTocXJITE2v0?=
 =?us-ascii?Q?zYe1juqoaEmeAPOcnFm1hVsbwXYkUjfBcfo705rGZJC4g8fzhA0THSUbusVK?=
 =?us-ascii?Q?zeh3xaiQKDrktmNRvAkUsgAT3Mvj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OcI2zQrZZVEufn63bxmmyonP8ZhZprIYvAcprKV8SYAAmTo4WTsDBGmA8Fx8?=
 =?us-ascii?Q?ot3KlhKxQJeGim4c2rMtlmmu9omn7NPdStegjto3TAOqNoElhI9h2ScZx9c4?=
 =?us-ascii?Q?QUuXDYrlUuFCJzy/tw8ylLgtwtdC8M7SljL+hi+ny4rIAgxLlrxYKzj/x8RS?=
 =?us-ascii?Q?BqEfkCEyT/K1q9miIM/Ep0FwwgmfNxqymSm0/JdZAbQhuJfI9s9pk0vnwQH7?=
 =?us-ascii?Q?BHo/u783p0XFskv00Ki2nLpxqQBiqKjh/76xPiq6HUtBLcMc7Pxzh60wagtm?=
 =?us-ascii?Q?wFII4R4fwcObdqwipK0uFVOgohzmC3bFtNJC6r6Cpq1Dtxno7QofdaGDdPjN?=
 =?us-ascii?Q?/qAogzMM0h/B/l4ReTtFlcHl0pSFEpTQL5+JIT7BzuhtSydaj9xq+WDViKqw?=
 =?us-ascii?Q?sF9yZvSXreZsi5FkP5FzWcmvIqpVyreknYDntcosjg3Hw2tD7SpiGYiu8zaq?=
 =?us-ascii?Q?5JW3CWbBz0+apIo0gut8lFkIKNQG4I69dsdH53L5r1/6diht/v5bEk0ZaNmj?=
 =?us-ascii?Q?3vE/eRPBETGTvvKVbPYz+DNBGw+9/msRaOVbwOXNe1Rlao9MrsBaZgXf8h0R?=
 =?us-ascii?Q?Mh7FX2urUSBKgw3uTmtydb9T7vXsih30R6ZxgW/XjpXio09mkPZgXRWtIxgd?=
 =?us-ascii?Q?aSsdaDVPKEzZqZYsEtQi2V1pJ24CNHpFyZT8TUU4UlJJeVj0tp+Rp3Rplszr?=
 =?us-ascii?Q?eGFCDFuhK40hegMUfh0tnMP54OrzLfCCac655/nCQ4s+HYd5jFxZcO3l7f5R?=
 =?us-ascii?Q?aLnxffuSRLwqaEX9QWEMMpCBBTyen5cJZi0CKd+9Q56/czG8kAFricEqN6Kt?=
 =?us-ascii?Q?Zq+Q0RorI/zdwRNFaBuh96Rw27iVEr8O1UKz3wgxqw7iiapUc4d0BTRIDxAp?=
 =?us-ascii?Q?mYV1+RwlRdKwzzyJopd6Vf13Z7xcaqB57eFzaRvLCQ4eV65HkH3Vh4Fcjk67?=
 =?us-ascii?Q?McqvQkBBLHQgKf1N8uENXJKmeU9DIiC1Blqpoqy7Zb2B/cuh9czUd1ECCbZ8?=
 =?us-ascii?Q?lQJkBl34fgdTfKRCpzgqQ/tY472aSs3DCZBj2ILt0Z44FWQ0ML/oW+rgyct9?=
 =?us-ascii?Q?hkHCUlh9Va/M/QfJS5IoM0/EKyA4TXyxb/0DvfmDDqJ5hmSq3Jv+b0Xd1tbV?=
 =?us-ascii?Q?vFqj62OesSpuy/9dTYFw7Fki2bpXz7yj1QHLLuvUZt5jVlTJJSX8R0Vta9aT?=
 =?us-ascii?Q?2CmCQisEQ6Xk0CdtA/m/ESFCZaCFElXVXYAgs8MErnBCcqf7onXwLPttsUh9?=
 =?us-ascii?Q?zFiA55RBWo1MasPdkWrqZFKXJDuEsn4a3uHY0qKjiHpbgAth3ezeW8HQDKxJ?=
 =?us-ascii?Q?BlWdjjpWhEndDIjZFivvWavHM1PcSPbvJLItmbWAuGZS1bN3VIU7MYsL7Z+P?=
 =?us-ascii?Q?N582vxbazYbZK36meDZN2lKQTL2utjMuNsxGdIoUk5nSXcAdHndG1TrIM6pr?=
 =?us-ascii?Q?CizMg+Hh5FCzMCO6ZsDuhXeXaIy6l04SH2g41FDtA6uTcXHTB8PQTeRrfx1i?=
 =?us-ascii?Q?O5DY2FLbxpCoDdH/oWzLkBFGJq4tUtXcPlRQmLS9JOFDhbnopM5mQm1SNtPi?=
 =?us-ascii?Q?llG+ypgBaWjZKHKhm+Kn/otIMgD461ImjXrIpM38?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea22f153-1470-4e54-ac29-08dcf3d28387
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 02:21:05.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZU7F6F7RNBqJ4xhd+rW1kgKikSmucjNjozWBcd2VuFJDhhx3Jo2AhcqAbkShrRMFI+Uf2/kBrGTDw3jZoGZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7461
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> Subject: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
> vendor specific info
>=20
> Currently, exporting new additional machine check error information invol=
ves
> adding new fields for the same at the end of the struct mce.
> This additional information can then be consumed through mcelog or
> tracepoint.
>=20
> However, as new MSRs are being added (and will be added in the future) by
> CPU vendors on their newer CPUs with additional machine check error
> information to be exported, the size of struct mce will balloon on some C=
PUs,
> unnecessarily, since those fields are vendor-specific. Moreover, differen=
t CPU
> vendors may export the additional information in varying sizes.
>=20
> The problem particularly intensifies since struct mce is exposed to users=
pace
> as part of UAPI. It's bloating through vendor-specific data should be avo=
ided
> to limit the information being sent out to userspace.
>=20
> Add a new structure mce_hw_err to wrap the existing struct mce. The same
> will prevent its ballooning since vendor-specifc data, if any, can now be
> exported through a union within the wrapper structure and through
> __dynamic_array in mce_record tracepoint.
>=20
> Furthermore, new internal kernel fields can be added to the wrapper struc=
t
> without impacting the user space API.
>=20
> [Yazen: Add last commit message paragraph.]
>=20
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v2:
> [1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-
> yazen.ghannam@amd.com/
> [2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-
> yazen.ghannam@amd.com/
>=20
> 1. Drop dependencies on sets [1] and [2] above and rebase on top of
> tip/master.
>=20
> Changes in v3:
> 1. Move wrapper changes required in mce_read_aux() and
> mce_no_way_out() to this patch from the second patch.
> 2. Fix SoB chain to properly reflect the patch path.
>=20
> Changes in v4:
> 1. Rebase on of tip/master to avoid merge conflicts.
> 2. Resolve kernel test robot's warning on the use of memset() in
> do_machine_check().
>=20
> Changes in v5:
> 1. No changes except rebasing on top of tip/master.
>=20
> Changes in v6:
> 1. Rebase on top of tip/master.
> 2. Introduce to_mce_hw_err macro to eliminate changes required in notifie=
r
> chain callback functions, especially callback functions of EDAC drivers.
> 3. Change third parameter of __mc_scan_banks() to a pointer to the new
> wrapper structure and make the required changes accordingly.
>=20
> Changes in v7:
> 1. Rebase on top of tip/master.
> 2. Fix initialization of struct mce_hw_err *final in do_machine_check().

As my comments resolved in v6 and v7,

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

-Qiuxu


