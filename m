Return-Path: <linux-edac+bounces-4357-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CB0B044E9
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D9117D324
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD524EA85;
	Mon, 14 Jul 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3c559WW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB914D29B;
	Mon, 14 Jul 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508857; cv=fail; b=MWVhtOK9CB4hnENj5JmVxfEzgstjb90f+RN1+yB2F2jNJRfDqv8ZUMhDKO0SeUrR97G6B4PMSNVVsiaREbmFd1jtOY+Drv54GEx5qHMBxEklvigePkFlgposwRzLtt+gCJ7Yo7vPBUol1PFlx1TfwqS/DZl5mmnGODlec9u/PQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508857; c=relaxed/simple;
	bh=CMZR+9PGlS0MPG06gSU5uthApQ9JOqx9rwo4pZFX2Mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z58bJXnasHJwXqS3lARwa34yuphhZlthB63EtoUFaFxhDniHDoD0O0aUlLlkOkrHZ2JalZR589U/H39qisWBAW1KUBWgUmITz+0V7tgDjYBt+r/hhOzEEBBcY4R0O1mpOeG8AS013WiKiIPN1XTT/3DAARbwlto0ZqcT3clzyoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3c559WW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752508856; x=1784044856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CMZR+9PGlS0MPG06gSU5uthApQ9JOqx9rwo4pZFX2Mg=;
  b=k3c559WWwUwSbsyYCrTeKyjiFPF7qjtJES8q88s7+NHTKm5qpXTUAfr3
   gA4VPeEywXithyrZ76bVOHqUWLVX/eWWuSAVJvf8fe1YV4CKL0v/g4xxk
   vjDB4/vEck9nbGjOI9t0ixQ9AvllBhpZlk8iDZYfMMD6r1z62D0s1rtkW
   G+EQBgTN1FVQmTY6CVXB/272CEOqLXjTmDhhezE56dVyUQkbyT0QZ8Q14
   vuLgbNhbD8JSK52/1BGxzdjBF5QPTC/1/pTsPFeFetfvegpGQeN7GudSy
   zH64QL/2vEjFcCWCN3RXo+o+YvFxWy19VBcs4TwRM2oPzT0ubKPG0pZvu
   Q==;
X-CSE-ConnectionGUID: gZMnb2wATYa2t7AdO1ui/g==
X-CSE-MsgGUID: OICVM9uFRzqZpCfhYlxObA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54414983"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54414983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:00:41 -0700
X-CSE-ConnectionGUID: 4puoEKxMRrmLUD1Ik8Fo2g==
X-CSE-MsgGUID: w/4IOJkrQpetRSPjMyw1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="161272940"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:00:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 09:00:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 09:00:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 09:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf2jyr++GaM0sredHI2fJW1ko0qCOZk15IH3/BxCOAj0LHMD4t/qDRY08TRunAeYJfu2byDgWuBI4LmwV+m/7gIwe8pLHaLcJMT+igmQFu88bqyZZcY5MXzP2rq9XorIWB9ZREWCek1jXZkUdDL4YJEGRSLRvwmC5mXXzRZKxQOYga+sFEDC82lLGXtHyBKuL+a3VZsjA43yoV5GgMk+1b2/dL6r+hQjErSXQrXzm9fCRMCOy+E7wsnMiwfBIA8MQQUUAnMwb6TZHpW0LqJ1giSojJICJmRhnBhFHpidzHikowIj34lSz3cgeRny2CZ2WDi4w2IybtCvzWVqfbBiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMZR+9PGlS0MPG06gSU5uthApQ9JOqx9rwo4pZFX2Mg=;
 b=D8JcWn4lH8XwJ32CLCemUgg2/RVQ0mQxkFcbm75F9xiwRaPTUAUECZxfpx6h9GF4RTNc4dnZtqnXIHTwawr8I/Aeh4feC++q9vma9EkItx8Hv/kqbR78VVN4FE7x1ZVV3cTHd93xPnNOUyz8RPFKKPAtNa9o5pZ1li46Us9mmXyLwuYJmngv/ji+fH0i7qQjFFm9ocWyR/NllgGxrhHsjjNxiqxw3vtQBItcHlCTXDYaMqpL+WNfCnAQ53+QTjF0LaM6mTrlswfcfepwg5fjmQU5EGlcGsHBgGeQaRUTd1xJ7i+nAZ7aPT9xclg2Sazp8GAspAUFqGnUSfbM5IdZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 16:00:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Mon, 14 Jul 2025
 16:00:11 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, "bp@alien8.de" <bp@alien8.de>
CC: "james.morse@arm.com" <james.morse@arm.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] edac: Use scnprintf() for safer buffer handling
Thread-Topic: [PATCH] edac: Use scnprintf() for safer buffer handling
Thread-Index: AQHb9MfpZBW3NHXjD0K24BN4XGYpF7Qxxf8A
Date: Mon, 14 Jul 2025 16:00:11 +0000
Message-ID: <SJ1PR11MB6083F39182C67204BA009618FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250714140130.1092079-1-haoranwangsec@gmail.com>
In-Reply-To: <20250714140130.1092079-1-haoranwangsec@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6452:EE_
x-ms-office365-filtering-correlation-id: 711e9c9b-bfa8-481c-50b4-08ddc2ef8379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UAdzGu9O+eaTu9QozeFurTCdbAgU1MMbwlCSk0ln73IAC1Elgq/u5yFBrXUJ?=
 =?us-ascii?Q?V0a82Ic7HMK11T0e2ebI3JpB0H2xkUZXKJgJBBtQzTTVLtQiOrxRsSuw0yM4?=
 =?us-ascii?Q?EnTMJx1/faSQfykZYuPOthgN/eglnEef6tBXQRQFrVAErWI5sW4AQ295fr1n?=
 =?us-ascii?Q?x6tnAdj3n/rXLZf9qdSfmWI9hwiFWRaWoWl2p/DiCLTAryBvf5i9pUjsCwAq?=
 =?us-ascii?Q?LsN8KcSFyQXFrLU9Pvh7NAnsOCTLQAt5bSuogoPoMGg5YHv3UMXmXKRQedw9?=
 =?us-ascii?Q?RP8Dgpri6ALD5afPW5cS+PxSh8Pwdx8p1gNbmMTqU0RrMw5n7vs8dHB2ihnC?=
 =?us-ascii?Q?SKMBKuk3L2M1X02El3zefM9cLsoUUgLRcHl4qzJEofbPrhTjVZ39oq3xMNz8?=
 =?us-ascii?Q?5QThzKMxtxbtS64xy6psjDlpygDUlm5ylzh7Qe6WCA7t2FiYtOIAaQz3cXU5?=
 =?us-ascii?Q?vF+3SBOFt9/3txk67YCd9ML9Hi6oou5IJRqQ3pjr5Ojy8pC2dcpI+8d3s27f?=
 =?us-ascii?Q?Z8cUrLqYkipA0h+DV6sOp1OuUzgMV7/sb3yzV1Bj9DzrJ1+LcxhuRRrIw4CE?=
 =?us-ascii?Q?BmXj7VoGf7zs4aemb5f5xVD0c/ATHeYZ5O3sa2sABJuz8eB8i7zdaI3XEn68?=
 =?us-ascii?Q?+a85C+6QtXgI4xDf5nASY1toHL6ol0dt3uleg0BZBw+XeyMHEdaaBcJI4Uc0?=
 =?us-ascii?Q?v6ybcneCe/cbEthDAv4Gdhvf/2gxFKW1xIrgvCddsBXTitJ4LRmdJOr7e7XN?=
 =?us-ascii?Q?g6RU46EvNPyageo1qgGkZl4mD586t1rZm0skX0GRS3PCK1mZfAICda48OERX?=
 =?us-ascii?Q?lQGFFzhP4HVqvl0lScoPEsbx7eVH0BEFHk2CH+3hIs3kFd9n3WTj2Qtl8gUU?=
 =?us-ascii?Q?k9hZvqPeo3mstqyNlGOSrRlzsvK5q1OihzeL7pkL5BjqgffPWyXzV8Mjp4eD?=
 =?us-ascii?Q?iVQFgx7zon2kCzmk0t8Jk+xQN1XfAagWbgGodieUIGANq0FUCndr/5JcNvIN?=
 =?us-ascii?Q?X0DGzXHYiUoEeQxS5/DnvFhjS922q6UuETlfNHYDwRQN9RtYYxdO/gTdR6KY?=
 =?us-ascii?Q?BHhoMX6OU/ZSsexIMoyPUt6oAEXZ52gVDxYL/+8axTV1iGfRCnGqi2DkVbh9?=
 =?us-ascii?Q?F0YvAqdEbPDBO0Y1Fr2kBe+jGJGX9rba2oP0jjOeodaN9lyv/UZiHi2YFirN?=
 =?us-ascii?Q?SlHQLO03kJMxk3+vtafmqkSLP2oCai8VGymebb7vyB3yJaK2v+4bVpA7HEap?=
 =?us-ascii?Q?MerzZ2JTthIIeDEkeYjUtrL/02uATX62QTqr0obx+br12Rj6Xs3rplbaQbhk?=
 =?us-ascii?Q?KuXorJ+W2Fet2IVslE1hEyGTfTUr86MJPD21Z7fTDDteZjJV9SN6LQ4xEpBD?=
 =?us-ascii?Q?m5RxpTz/75MAGA1tCqyVjwXPo3qLkgmqWJDmb+BU6x/dDkkGsXtmPV1jX5Ua?=
 =?us-ascii?Q?tFJK2gveWJrTjTgbnfN1I9XtDAZucESiUDcw243ANk/eAm4/NNLKZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PiZ8YIHeYh8QTUM6SgrWR4QAXQ5Yrq6slELDlA03DKSKDUjbrst0nhtO+7PP?=
 =?us-ascii?Q?bhd/jnc4wPpwt884w2+aGNj9OfvSetGUrpIVkD1IOj92Nn5kUYT4bOG+wFtT?=
 =?us-ascii?Q?J0taOx4deb5DMdcgBLErImZX2JB8jtBKXdWvpmOB+nGOaipmuxY0nOC6bFnc?=
 =?us-ascii?Q?eY2B9FFHgbXRP9ZABJamNT1G+i+ym6L/SkT4XnTTBSNJoIHSYVgvGEF6eU7q?=
 =?us-ascii?Q?aOqfvgwCR0vT9ScagIw/TMYvwmjn9+FgT8mQ6GYZn/CsCgQu2dmzypH3rYsx?=
 =?us-ascii?Q?8NCYZFprBUyRqPpl+PnfdUxB2jdPc2/1MZ9lvrvTvq4/w6cP1HdVuLPVi4Pg?=
 =?us-ascii?Q?mbQEfD1Bp/NUGK58owbmjbJhsMPQWurbF+Ob7aYE6CwAskzoV1H7mtVm20xV?=
 =?us-ascii?Q?Q5pQbdn2uU24NGDYx++2cfgCHrPmK5r4b0TXyn6ZxWXe80jtb5neR9MtgC1h?=
 =?us-ascii?Q?v1GBqkkUjE0oWbbbQowHZIW47i33cGVsDhHuWcF7Pj2v3iUMiiGgVA+aZ3cH?=
 =?us-ascii?Q?T4/Fda5g3K0YNubMfmZrjri7NWQNzlEK4Y1u0aYDMyX4vzgMuJ7JL50+dwIs?=
 =?us-ascii?Q?VI011mvy1YZ+rBrRZyK8hljp9HKJWGscLjEZ4AjKlpLM7sGPa6F0QTJKbhC0?=
 =?us-ascii?Q?3Xv0pbw1EqQHIG/EKLdPzVFeoQRD/4hVyKecRK3KWYA2+ezI95TeN1Y3Y/KA?=
 =?us-ascii?Q?em+bOfZzZ3MkDSiT+5l7461g0e1c2HtV9C5qWOO2mUsKOPJU0chhaV/VPF2J?=
 =?us-ascii?Q?xZ2RDs4roa6yumd/8YvHBsq2j/ZcOpkd2RQwrCiTBe0Em23VcyUbj63mMV9A?=
 =?us-ascii?Q?nKALHKbUrGbD+TcIVuDwQBgfgnJRw7N05Qe/yjIP3pVdjRTFKeqWb2xaffOO?=
 =?us-ascii?Q?X7aVoNiKyRvhDogFBiJiu5z1hm7Whuk6XUaLCubKRAbWzxEEx4dGzPdUpf6r?=
 =?us-ascii?Q?IH1ZDDTHb/z5hHg2JP91UpdSAhCfJi2GX0DS4Wh87SvrYGJXJMUqwTLB721m?=
 =?us-ascii?Q?ElgT4CAa6tBiQCncC1h0TWMh4f/WLQYj2+KwX06gnQpqaTI7zoJTMvT6Y3OI?=
 =?us-ascii?Q?OMzf+vR2XqFU79kLO890xWuuupJJtBMaxZM3Wai4wRMeia7yGS1+y7ButDzF?=
 =?us-ascii?Q?S1OmcTrRjjKmzw5xUJDUfiU/fhq2pfC7Emi2PqNUCnEr3bFsg1YnkOC2cqHf?=
 =?us-ascii?Q?aKzrgpakSTSiLZ/0VnynlruYl9kWtHcUPTxkgsBPSHVdyDB3zQyaZeWnUAmY?=
 =?us-ascii?Q?9PYZyD4dug6PAWdGA/vfFQqG4Jz7H0CPZqNZ7rlwxHR6DRR3xdJADMBISkXK?=
 =?us-ascii?Q?mVo+ZZBX5zDXOZm/9Jl+liUsfHHCqU2EriV995Vup/caZd+ZIOamwx/IfvPf?=
 =?us-ascii?Q?fqNnwJ2FpJfnT2n59uhTEiTMEycN6cihzSmxVVt+xl2wlQXBKiD/EfYf7+k6?=
 =?us-ascii?Q?Z7tAaB/DfjIhxloKO7cxq9TKmYC1mK7IgirhwPdSsSFGHQT8d8C19gt+KZVW?=
 =?us-ascii?Q?4dzN6dlxV6SBIHnrGt3JyX3eqWjiOEKGdJ4JmBTLF/dM6DP3pchazI2pUezP?=
 =?us-ascii?Q?DOgxh65RbIVq4/9w5i6cs/6mSNUoxDl7Zr981zZw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e9c9b-bfa8-481c-50b4-08ddc2ef8379
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 16:00:11.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDV8g9CePxyTdQ8jvHKftYpOZLXkorDa8sX4YGxBdYM4y2qlUTVgxuIDBSzWDzOL1WMkpxxHEl0RiwZ97xeMHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com

> snprintf() is fragile when its return value will be used to append additi=
onal data to a buffer. Use scnprintf() instead.
>
> Signed-off-by: Wang Haoran (Vul337) <haoranwangsec@gmail.com>

Patch looks good. But what does the "(Vul337)" in your Signed-off-by signif=
y?

The scripts/checkpatch.pl tool complains:

CHECK: From:/Signed-off-by: email comments mismatch:
'From: Wang Haoran <haoranwangsec@gmail.com>' !=3D 'Signed-off-by: Wang Hao=
ran (Vul337) <haoranwangsec@gmail.com>'


May I just drop that from the Signed-off-by line? Or is it important to you=
?

-Tony

