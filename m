Return-Path: <linux-edac+bounces-5324-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958CC31779
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 15:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75B818C63F6
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB6B32ED5C;
	Tue,  4 Nov 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZXwCV0Y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D532E73E;
	Tue,  4 Nov 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265747; cv=fail; b=MhUrKBUweurd1cNlkmNTNCFGA9mPoj3GF+dSgJS20TDWD+qGjnswKfRTj0hRhhomkkSliFYKFipFdUJVVzwAn4wjxGDz9D8j2VLRMNviyaz+bDaIgpZQtv+plEEge/AL4tFOjkEZkyhDjn0bjRgMtCY4VGBC9JiUX6OaPQ5NeyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265747; c=relaxed/simple;
	bh=ZuMXbFucgmDVxjvsQAJeAqina7vMxAUPKu3LUrrJiwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mnmvcCKXiLCOFjOIvzsb1ZABXjq31Y2TLqlIW+0tzB6Gi/UwBwnhROdkYJnxifN1TzlEaqpDTujZogQ7nmCHJKkIApxZDdZ3f6gjmRE5zLNlIN+6FArdMQFmuhzXgmkyWkYcqb3HSZfJN1SKWqOBUM49s4QLB5WbM6S+24A7oRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZXwCV0Y; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762265744; x=1793801744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZuMXbFucgmDVxjvsQAJeAqina7vMxAUPKu3LUrrJiwc=;
  b=QZXwCV0YTr4psmYkYjWdT7UXpHXA/7oEDnjW8wR9/1QwwI5b1P2Qza5Z
   9LE9+fNDhkiA/dUN6llqLwZABgB591Yi5fAEV2ZgRSh4iBpV3iZB+L4fb
   m1M6NGo+NRRZ+UN2YX1d2ZFUj5g1sxeMVRJoThu8ggfwChuPnQ/MBc3ta
   Q+nFk1seLaCxUSA+the39jJKSkBVLqS0jAMbPCfhp7O0yO2RG48KRD0Us
   rlrwnTWA2GBs43sIB71ZS2C/f4uyTdCxBqrAnkV1ZeQ2n7nOQYGlY5Hp+
   5fMUPFQRwbgL9tuwgdefspsS3z+m1Uo82aBQOw1OGvPzVD9wO4loA6NI2
   A==;
X-CSE-ConnectionGUID: MvfQV6jhRx+bXtLfRqDGDA==
X-CSE-MsgGUID: rVbuWwTvTCWXvMo6bRtTEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64245041"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64245041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 06:15:42 -0800
X-CSE-ConnectionGUID: 2FeST9XFSauqSbdafF0ydg==
X-CSE-MsgGUID: rOTfsPYwRhG67XwZmIt88g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191520879"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 06:15:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:15:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 06:15:42 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:15:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeFkr2Iv58Fxs25GinVjVAwKecjWgcbHUGf4TfAL2ZNPPjHVG42UPdwHhdMiIabk59BqVl4bzxWcxrysN67V/mNOv8i9/rCvtvGC9T67HTXU8QgLEez3HTNeU090aove57+6Ml0mhS6IQZhN0aSJoccAV7hTPeigVOWxEil9gHMCJh6ToByubrQGn6+uCl1Bx/tPv57frQcNO0eIHbfPKVqItYQd4/SbaD/lS/tvTesf8FIY+j9ZUtjJvk3+vRTSEQIGSOmqYBMuQ0JKJZZ1QDu87Q9P8ZEeC/Tkfl/urXos3Tj9OXUHXOQHuM911Mwnqt3osZUK1tZD0Ux6sYF2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQXYnEs/GPYY2uacQQ4tmYSMTT8wAmMlmUzJEczMG14=;
 b=BEdEZkvVnmMq0B4iuiGNxIlgLzVO3rCTHIEshpYJjcLjsolUm5rU1Ay8HN+OEo/TwfBBnzp9TeBpKs7K0art6j0CZaSWvwFj9AvIrXU6WVej5X0CEeDdeKRc5ldgFjuHOOaPZbAbAWIohnws5ET16kNytxp56HJTAOQAActFDwPjdaj+erD1pHfMHh1PW+u+2D6cJ7mbFII+fuE/jvdS1pt7Fr91pesxCDGaKNRcl02viHOLqoTmX7+s7vsHMr+caIYfc3N0XVrgaAdOJpCOdxNBd8mLCFH6PuXKsXq6+1/pr1s70Ur07QfZyr/V3tPLC9nmZPi6S4jC2Y4ekwbz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 4 Nov
 2025 14:15:39 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 14:15:39 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Ma Ke <make24@iscas.ac.cn>,
	"jbaron@akamai.com" <jbaron@akamai.com>, "bp@alien8.de" <bp@alien8.de>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/ie31200: Fix error handling in ie31200_register_mci
Thread-Topic: [PATCH] EDAC/ie31200: Fix error handling in ie31200_register_mci
Thread-Index: AQHcTSmpmIuHMzfXiUaQzhm6w4io0LTidEUwgAAamWA=
Date: Tue, 4 Nov 2025 14:15:39 +0000
Message-ID: <CY8PR11MB7134886BB103C40A284CD39E89C4A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251104012317.34637-1-make24@iscas.ac.cn>
 <CY8PR11MB71348C8D1C35AD7DE3DA63CD89C4A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71348C8D1C35AD7DE3DA63CD89C4A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB6520:EE_
x-ms-office365-filtering-correlation-id: 0ebf2e6f-8ce1-4164-a524-08de1baca1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?rugXoiXs2oswj+ljBbYZsWiZUxE77N/4ZHvd1YfwYWXvogsb4C/oUXdO5IxI?=
 =?us-ascii?Q?1c0Qgdk6g3qUzRX6ggu6LaOCzCIKb6t4h+Yk2i+6j8xVT+gl+G467NYwUoaK?=
 =?us-ascii?Q?o/kBR9yndo0qlL3fV857s+ssThGl9ELnnG5ehJD8CQd/k6YnVf/c8zjOmj7L?=
 =?us-ascii?Q?PDT9QaDoItm4yA0ZZG2oyIRCd+x+YgW5NDhieqB9d+FC47rxfHY20yRzetlc?=
 =?us-ascii?Q?5i+FC4IDreecrSJjRRJo3poYfxmlo447g1JXPI9VjO8x5smkaFBxfk9FoB4s?=
 =?us-ascii?Q?oqL1R/CHAZZLgV6zPXVy4WpwwzGF+6oue1UtTmdjreucWrQz0kzXR8Z3sGsN?=
 =?us-ascii?Q?hNtEO5hRZb9vzyPVJGKzP7YMmC/y7udZIDGpwuwdZABPhRyjHn5ewygSAS59?=
 =?us-ascii?Q?AprBRVrlGrXVbI/vAE0/ULr1qU/BJvWgHPR4HwPCXXNp2xEUrLrZc1nL/Iuw?=
 =?us-ascii?Q?f5FoUVgh2t/4itbRne0V5haaybsj1CU7sZBp68YmfCpjiby22s7eSht5wht7?=
 =?us-ascii?Q?xq/MVO8d7HXdXT11pTjYUN0lkqIZTrqrpBTzroIPCtK9fGh8bCSzStmvkNZl?=
 =?us-ascii?Q?AzJf0hrd8+Ou43T1fH/F7uI+ZI4So2N0t/LHdM2Y2Acawij8lzyEnY/L8IFe?=
 =?us-ascii?Q?p86cng3fLVi0Kbma4Cf/8TSIq2xs4m9KDEl7Bw47wHONL4SGyCpisAga7GtO?=
 =?us-ascii?Q?jChY79VCvJBgLC4Hfqqe7AWgkd8QTA6IJwSExi3N2RLB15ZNHBUpS9Lm+fGD?=
 =?us-ascii?Q?D9POFslaLHsu6SJDaS9abCFeqa53jIwNeU8Gm5chHV/ddel/TCf6SWlBhNhu?=
 =?us-ascii?Q?aebAxO+zujz2JOxBNqcb3MTznnMHcYk446wxD5fbT65kKeLg8OEwxHZgfDSq?=
 =?us-ascii?Q?sq3Gw85W56Ktnb6r6ImD7AhH07kZbqJ/pzQovvJU/ZSFaJiyptg99n+M+rWf?=
 =?us-ascii?Q?SYF8M4LkXoz+YvlhpwZ4V0SDOGZIzXoMliqN21dPJm1gh7la7tka++dx5ehD?=
 =?us-ascii?Q?T5RweSZl2oNllUfIdv1r17KOPf2KJRN2w0OEUITqxRfcILWpA+zmJyrwtM5g?=
 =?us-ascii?Q?+h17JjctvxJk7/1EHNtcafXJ3Of0XBSlD1rNMyA/F7GlozxoL/Mnim/UvpFc?=
 =?us-ascii?Q?PcRF5d7mbFEclF1Q7g+3NlHrbej9k6fFgsn7LJqdCZs+CUNxQmrdK+FmDUUO?=
 =?us-ascii?Q?SVK/XopA0FyVYe1uMD/4O7QtmxTYg2tbQKPTmwdwbPBiedUfDfvxHso7HvTk?=
 =?us-ascii?Q?VbeZmnXw/skQuHrnxo1MPI2XntR+E55s4MFeBmgUomxv9+Jl02JQf1JGLpBW?=
 =?us-ascii?Q?uwnj+EungT+OoGJoe+3/lM2K+D+VN1ily3T9cRwkoaSLB5RKRNZlUbKMV2ay?=
 =?us-ascii?Q?gbIm8uKaRauswpkEH2OrbZaZsfDZ/nbXkA5vqQdXB+1VZshWlN5TOuXygRMT?=
 =?us-ascii?Q?bLILqmj96vy0sRIkZsh1ahgvOdLUYbHAmeJSrdpCo2+MMHmxaCy2Sv/r6Nmi?=
 =?us-ascii?Q?OcHpXsffFxLjifqmvM8UQV9fntn+akGAZeZY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VTov1Kw4d1iYuRAkk0t42wuZlfVkNqxfArDcljJE5QoJCJ4OwSX/LGKMYus8?=
 =?us-ascii?Q?o96hVuSCugUn24g4Ytra6SJnq+fQaryKbbGvuGKXCjnYOoJVQa0WIjNiwlRx?=
 =?us-ascii?Q?TxPe+dMcZJCNnqBStw70V8Jnqs+lslW6DSl32xuGsZ0Naep76pPE/aetd9Wb?=
 =?us-ascii?Q?/UfGpxRnd0qStLLupJehq20BOLqe8PKslumxIEJi/jENS76SWGSDYfRSUkkC?=
 =?us-ascii?Q?yxDqNRizsuJV0kNy0tBasTURYMZoL3LajOXpmhaH4Y+g4ZlMTyuz/WcPCy6q?=
 =?us-ascii?Q?JvS3cidHUlXGDi/QbcFPiCiYvOhDnSO+sSRpUSiTeEPX+sTl3JaQsc5DcCss?=
 =?us-ascii?Q?OnuLvQIebH/xd17LawKtCT1DK7UMqklRd6YmWj0DShWjEWKUfFvcCPs38+pj?=
 =?us-ascii?Q?rA3Psaospj+k4DISg81EKZzD0G3XVLBkP7xc8bqNoaGz/90x0aAQzeznaqIq?=
 =?us-ascii?Q?HDYTETcOict8ZqlBn/HGlqnqh+KE0mBxFOuxOMh0q05cMakOvbLHTB7SI/fF?=
 =?us-ascii?Q?Hhz0x93T0Ouzlv6rsKMjLfvkMwABblRIikEQwhGyq1RzDpBXYsFqoF880/bi?=
 =?us-ascii?Q?r+qDEJ0viSsBIRGHo6FiY8REUvAgzumiTTleMsMPNVT3PO7XiMfvbnE1uIFZ?=
 =?us-ascii?Q?zVq62sntHO/I4CGzHU0qeWqtD2KCz14FVz7hJzWMEllWy6yfB83gTBYAsSo+?=
 =?us-ascii?Q?OHaZht3SZRur3OI3B+VGRFOtd4JWFKcl4xHA1FC/NsfKwaYbj+C2k0B9kpnV?=
 =?us-ascii?Q?WZjQt7vtBZ6jlJF/3qD8YHEBT78s+VPxSmci7wJnJZkp65kVVcSc/h8TMlXR?=
 =?us-ascii?Q?ArbHU0U//9Ga/wdSbuvrW2BtCZcb7TL9LQq4kTZ4lrWWESJiOM71bXHXDM7M?=
 =?us-ascii?Q?LR0GPo1cPNglS6ILij/JuUuQzW6OjvOQ9akBJXvGlNmUfOVrINabkul52967?=
 =?us-ascii?Q?o0KP8cmzC092IfWPxhqw5G346yUnERFgSNbpHcn7BRmaBUKk84jUX4+bxpgn?=
 =?us-ascii?Q?y8QOYyDU2zhlOl8Up7+lmgHQLzWc/epJByXCD3d8kybXgr04a20E8QetujP6?=
 =?us-ascii?Q?55FQkupmo4lVNrbbNChWL/ebVhPwAZbXciPOpvWV/YXzMEZMPv3tKTQ8t490?=
 =?us-ascii?Q?saas8C68nZO6KaeulkQ8sKfC9xyn40z18RebZtenYu+Zc1TeeLS5NoTlamBo?=
 =?us-ascii?Q?FN18CjgJhFlm2XYcjAoZyfJBLD/edGAFBpWFWtnAE5cgKeJ2iaXAiC1ndMCO?=
 =?us-ascii?Q?c8purG11NolSOUBulkQlMsI0uu62Jf3CEWovl5OieOYMIJS0MlKqkd9vTmYV?=
 =?us-ascii?Q?jdYWT4PNKYWwZd+X5KZqZDNHtwlZp6aw8yE7c74vRHI7bs4mdDvrr6uUtOO7?=
 =?us-ascii?Q?wcPVOmN04+nINOEIAe5qDKIQec8WKSvb4SQjSHBr2a0CUEwf6e8z1eoipuWU?=
 =?us-ascii?Q?jyFDPXQFbJPNUceXQ/WC8Hdwb/JulpMepqh18daWPxS2YcVjMyG9cYEW/bb7?=
 =?us-ascii?Q?hN4r00NRoqteAOUnHPpv1VT+Ktcle81R16C7F3nVIAyZJ88SsrXygz6dKMpv?=
 =?us-ascii?Q?DnEp/LhXZuakle2cbHWMJ6O7QQzpQfb6SDgx0U02?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebf2e6f-8ce1-4164-a524-08de1baca1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:15:39.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9UPC+4osDZHFtrS8srSw7LTZLEKKV3TAkeTDHnvctuT+8CRirRZ87zwMmVNMSBJfPt5/EOaHoK+BCCzJdi01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com

> [...]
> > --- a/drivers/edac/ie31200_edac.c
> > +++ b/drivers/edac/ie31200_edac.c
> > @@ -528,6 +528,8 @@ static int ie31200_register_mci(struct pci_dev
> > *pdev, struct res_config *cfg, in
> >  fail_unmap:
> >  	iounmap(window);
> >  fail_free:
> > +	if (mc > 0)
>=20
> Since both primary and secondary memory controllers invoke
> device_initialize(), please remove this "if (mc > 0)" check to call put_d=
evice()
> unconditionally here.
>=20
> > +		put_device(&priv->dev);
> >  	edac_mc_free(mci);
> >  	return ret;
> >  }
>=20

On the normal driver unloading path, a corresponding put_device() is also n=
eeded.
Please include the following diff in your v2.

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 0aea6d59f31e..4c43d7dbe047 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -603,6 +603,7 @@ static void ie31200_unregister_mcis(void)
                mci =3D priv->mci;
                edac_mc_del_mc(mci->pdev);
                iounmap(priv->window);
+               put_device(&priv->dev);
                edac_mc_free(mci);
        }
 }=20

Thanks!
-Qiuxu

