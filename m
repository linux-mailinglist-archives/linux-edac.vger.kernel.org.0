Return-Path: <linux-edac+bounces-5425-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A03C47140
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16AE1891BDE
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F731282B;
	Mon, 10 Nov 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkybZguU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238233126BE;
	Mon, 10 Nov 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783366; cv=fail; b=BdMbZu8IyHXKLH7JRK6h8I45qiW/9AFLwcCztFdXQZTYb0Euw5lnODRwoC1e67k98SDw5V0HwG5G6ehQZxZ0sxzXtcheWXuSO0S+0D9wufyXoPUjhhrMhtBCDat8L5TmcyM3dSvylajjjfHC+AQerr6ZPnvFuDmBX3Au1d/SXfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783366; c=relaxed/simple;
	bh=qZG9kvPfRV1aqGof0ckElg7ZY0VFrf9hHd7O1MQsbwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CuNeyKyspiB609GxWxhZvDZpH6ndKkrkb45lW1zjakMLdQXn0XZo4kNJslYPbi25oesk8ADWzt/7rvJn+htS3CKh8SY6gLWMLlge+umRFb1vXdfcfwzaaior++MyT08fHW0J9OsFA8CvAXHxhvmLJ0DjiI8tWFTlj+DfCkVvtk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkybZguU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762783364; x=1794319364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZG9kvPfRV1aqGof0ckElg7ZY0VFrf9hHd7O1MQsbwQ=;
  b=AkybZguUzLucxe7/3f4/+2ShWAjk3cjmOpalybEZiopMwnU3/fOqTnIL
   3L9KC9lw6dDlThQNz1g5ofOjL2WGg8H+JTT2eKq3GNYIqL7esAhJB66uO
   mmeiJsRvgPAHO9r158KuVlykn9YqsSWX+EY9X7iqW4tap3CeV4CMf1yvG
   zGtQhR/KxX0GTdwd92mE2+F8ynpxVc8P0tzi/wI96ilV5RwqMUEVjhDBc
   KAmS9gCFVvskdBsNRZQj81LhcNPNAbtHH1Bt2RFC47EeXv5ymv503H1Tu
   Eskx6aaf1I3YkcfZwctS2e4zaNlMlfZJ0i6Xh9XJ3RALcTPzz+JfaJG1U
   A==;
X-CSE-ConnectionGUID: VYlIJ813RuOZ7mtaFEdixg==
X-CSE-MsgGUID: mY2aDvMqQHydNqe6ceXWDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64987385"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64987385"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:02:44 -0800
X-CSE-ConnectionGUID: dwJX/aowR1SL84yVPjfXZA==
X-CSE-MsgGUID: 7nH14OIZSS2EIrwg+LAIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193062713"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:02:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 06:02:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 06:02:42 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 06:02:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzUbC1Xmc/D6yV2zkkO7X+Px2ZlnnT5gSBIm90dMAO+7d/v2NkY9SLA+Q7pyIGpVo56jWQwNidXSpKLHhy3Mr9S8xWsz/xPJx6bk4vdYVqt8TdYSZrLIPOFqjC3dav4pwtWBa/M60YkmrjOE4sS12wAHPDMC8CBRmWI3Ajra5mm5HAQufpUi6N+2f8Y2HFJTN9Lz3Xz5NVLni/m6PeHXlszXQQWiVyE4XHuXTGOrGMGeZ7W1bn1i9WYc/fR/zK1iP87nvUidEABd1PVPqCW+d9UTkUVg+ezgEHiS5hqxqp+vQPWGETzCZ1xFuTodRsJeCcoxibEqZsLWwwMVvldkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSsDQzbGNLgLMukXZKfcoEKEX4TN8D7tl7IYu5F8Zxk=;
 b=IJ9l0PRbs9NzMhFPWO3O32jE5MSyJ78/5EtEacakEJaG36rZUbW9+iWh2LbxgiMmd/2SM7xZQAA60Yg3SVKKJlQRRfMtlBDQOGo/pGkl3Hh9b9IhEwnECnLVUp8aiy1WycGcudeI2upjLgN1o3T7uHlrjBxsAo3SMaIf49ogq6fFT+GWgcA5+sSadQ1vgkZI0tbw/AX0vwDTM6PZyA5b66Oh/4itm+efwfuSNf38JmSYBZw3OOKXT9UMVeAdGZUy8/Om/P/FLhRxmrh3hYRsWJhcT2seVzfQB4CDtfBWyhNALIFWs+KDwF27/QS12h4babO0Sx0jMfd/dVxYFsOTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS4PPF7A0031045.namprd11.prod.outlook.com (2603:10b6:f:fc02::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:02:38 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 14:02:38 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yury Norov
	<yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
	<ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski
	<kuba@kernel.org>, Alex Elder <elder@ieee.org>, David Laight
	<david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, "Luck, Tony"
	<tony.luck@intel.com>, Michael Hennerich <Michael.Hennerich@analog.com>, "Kim
 Seer Paller" <kimseer.paller@analog.com>, "Lechner, David"
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Richard Genoud
	<richard.genoud@bootlin.com>, Cosmin Tanislav <demonsingur@gmail.com>, "Biju
 Das" <biju.das.jz@bp.renesas.com>, Jianping Shen
	<Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, qat-linux <qat-linux@intel.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 03/26] EDAC/ie31200: #undef field_get() before local
 definition
Thread-Topic: [PATCH v6 03/26] EDAC/ie31200: #undef field_get() before local
 definition
Thread-Index: AQHcTyLZlBp+VEoVpkGka3pFTqVJFrTr85wg
Date: Mon, 10 Nov 2025 14:02:37 +0000
Message-ID: <CY8PR11MB71340DBA5EA023F7CADD008A89CEA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <581bca4d109242bb5acb3be49dbf1bde780f2884.1762435376.git.geert+renesas@glider.be>
In-Reply-To: <581bca4d109242bb5acb3be49dbf1bde780f2884.1762435376.git.geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS4PPF7A0031045:EE_
x-ms-office365-filtering-correlation-id: 07020963-c15d-44ed-f9b8-08de2061ce64
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ukoixdh8/bnnn0Yy33rOWJvyz3RDNFBSh5yXYAh437ZqCyLFYwnnnbX+IP?=
 =?iso-8859-1?Q?EJhoIv3FJbJCms1z0OhYji5B1agRpdxWm9I5Pi8kiUnzBfk0ddT2u8EFni?=
 =?iso-8859-1?Q?LUuvpWVSlb7ZcWmB9HJ8bhoElCZ41hHJxvYwHBlKlMQR7hfi46xNLkDpUi?=
 =?iso-8859-1?Q?NpDRrrQsEnhJ1NmJHU7Y8QXspSeznBo6eHezf163iN84//x5HX6fZoeVKw?=
 =?iso-8859-1?Q?8TZjH6CHqHDKmpZrXGHVIljB1wR1rf4rgIoSwRk8XaxheHBvoaJfAtZ8SY?=
 =?iso-8859-1?Q?OJC2KFDBMbZICGjeOtzGSkiWHHJUeuG4k+mH9a9XNhSjXvjb/fUgynlWO4?=
 =?iso-8859-1?Q?WvtRqMWWJ8fyO3Ul1YNfHTcvwSNuH9FNgVHXTSxXDRfWFe7Qwcdki8R9U+?=
 =?iso-8859-1?Q?ALiDzAYbBZ0MZI8BJijwB7Gs19I200hffW4SKFEcos6tvR/OrbaliPS0Kr?=
 =?iso-8859-1?Q?DEl9TGwunRfBlQHJRMwibyRDM8dElllEYROPJrfAEhXXdJ6CQ+VJ81sl8n?=
 =?iso-8859-1?Q?6vPObdv+Wa0JeLb+QUf91t2KUCBQvj2zrTCNkocubzryL9VHaM4IM4sXZ/?=
 =?iso-8859-1?Q?zRN1gcAhwBidqZj0YL6s4HIO5y5cbYeUS8EBiZcgGZp9+M1b59+qXYcnQN?=
 =?iso-8859-1?Q?BSxKrgIADE2QQ5toyWjArBZGzDsvWzQ3W1lftfMNEANcnJ/APmw4BDtyn3?=
 =?iso-8859-1?Q?CqVNHvG99mTn4M7vLGIAWdO5Sv8W5+xCu8f/7UhPUPAqRelb23MotGZNBU?=
 =?iso-8859-1?Q?sXv3fU6DJnWset4KaOH8sNBxzumPQeVl+XRARJ9LGqJZo4dj4SYmYyJI04?=
 =?iso-8859-1?Q?WUbnUFbpPIIaDG8gZITbpRQNX7WQQEOZEqKwZVLUr6I+MLFetCzIFGpAlR?=
 =?iso-8859-1?Q?Iv+njzSjXvf6rxWrxuWvdfyXBiEo3iKF5U4Nc2xyLL7+NnXa+TLGlUxAaS?=
 =?iso-8859-1?Q?nU+cVFkj1v7PZkcDd1qezE/SYCe0YXu1BgIackTzECcDlBTcYVHyh4gXGP?=
 =?iso-8859-1?Q?8e2QjAWOD8BQt40MnJ/hpIXVO+VNBODsn8SHDpWFtE4QUhBnS7eYRbNOHH?=
 =?iso-8859-1?Q?vYgSCmFn1JPMzFKbt7cUFD0GstT0ISUlggHBtjnwxa9qqiBsEvwxzfUquM?=
 =?iso-8859-1?Q?LD1vtP1TK673zrdlpO0DVCXC97ry25PvYVOjaUdEnwqkTwwoHXUJPCM9ep?=
 =?iso-8859-1?Q?FiZ/1zMzPKLykWv8gXnGmX65XTfaDduiIDt8komS6wuoQZqiv2DjP+Asz3?=
 =?iso-8859-1?Q?157u8fUdoZDe732plMRdXxKYU29q97QFfruzRP5CcbBCjLxBN3J1RwL4Pk?=
 =?iso-8859-1?Q?PM8nv5owHjq6x6H9raiiJA4Ua0NWOoalD+jBLCiT7JopMgzLvttvS0QCtZ?=
 =?iso-8859-1?Q?eMgWMj5I4eVOszML5wUPckEv/2PqGNDSxMOBZlm8z1pJwfeTlgbM0wl1x2?=
 =?iso-8859-1?Q?xCS/IcF/gNDDH4XaJ/RkVE098I2O5blZBElpxjiBfA+xpLxS+dm+oBr/M8?=
 =?iso-8859-1?Q?y3OGiyjlrCLtUzC2Qm8iK3rxccl/pcyioDDZzHI5V7jvDr920dFN3lVJ5M?=
 =?iso-8859-1?Q?RmCCWMk1SouY3feyOdn6FwSYF05P6SwZ9yfq2+5LMv3aQWyy8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lbvOFlvl/6b9cVnji49Zol6chG2c6qmMvYXSLBA9wjzC0ewgp3zBQOUJ1Z?=
 =?iso-8859-1?Q?bCXQHAuySWybnYfZF9RKyVPwFtt/0QQmrGPo22kQ1qTy/BGrVXwzE+CLie?=
 =?iso-8859-1?Q?2X51RginulLJCra4vsrIdnB/PNCotx8Vnzmin1cqmHZEnRKtJRjJN3xZ3m?=
 =?iso-8859-1?Q?v++S8e7R1Mo9yPnebz9If6gJs91jfgHPZ0pMfsrptrjIDjzjDjEexOQVve?=
 =?iso-8859-1?Q?W3kWsGNdgY9RnREUeEAZTqDwL/N8f0noW3PwXOtm5GF93Oy7uCc+cJUh9S?=
 =?iso-8859-1?Q?0zB/+2Wr5Z7BWTYlN62cXTshfRQSNHYmlR5RwReRiXgQp289VoXl8Gj2X4?=
 =?iso-8859-1?Q?w4zLG0iuUsDs2mBCn8Te4uRB6HqsgOOxls2JS8Gxp0qMrK4xXcLovYtvST?=
 =?iso-8859-1?Q?lLzOtOt6lm/P6ZWXQD7AtEC7BrqJsDWOO/6VvO8GxwTIdMRDy0pJhaqq4V?=
 =?iso-8859-1?Q?yVu65onOYg9+HH/j1kRT2/O2WyyFQ3T+Nq0h82M9gWRqywvrxMjZyXArk6?=
 =?iso-8859-1?Q?uSjhiY2kuClTgX+ojCZ1Tmf2M2KYVSSKpnOAsZ++dc2wo86Ur2q3doaN7Q?=
 =?iso-8859-1?Q?QOndC6+eL547AiRRE3uOIodfNVM6WbmIne3H4RHAuRE23kdGJ23zYjvDys?=
 =?iso-8859-1?Q?fDK4bPE2JpO77lmTvKeRVNRA9fqzYOmTw4kICMJM8TpUtl2MQhel92voDZ?=
 =?iso-8859-1?Q?JmXhdtHL7oPHGzHouJPAhbVOqoeMoRF9bHsjNGQUniEqkNrxZG8/VJ7lDM?=
 =?iso-8859-1?Q?H6dzJznGkajo0WReq75w2bxAxXaeFA6Eyat4A8HfJs1JmN38lQEyrJvX8k?=
 =?iso-8859-1?Q?WwaN3LoyEke+MAyL5IgVQN0/pbSM9SsD1PWNSAnDWk4VknNndJM6Xu5lIE?=
 =?iso-8859-1?Q?rOwUVDsQpEZc3elk8oqa+A3rsqn+gBsWUQOUgFA5LLT+/nAI9sNFqfQWEN?=
 =?iso-8859-1?Q?yxwwWcZ/mytRX2EvF3gD2vSvJn4B+k7AybiERqaMEWJpWOq/ZC07M0xYWC?=
 =?iso-8859-1?Q?1fHki/eWkpa8AGlmHUuAv/SFL5Jo77osaNY9Ze97eLa5UTB5sVblaRCD3X?=
 =?iso-8859-1?Q?jpPl7ZpJKDYjd4s/Ou4jg1sLe/0faXe0wWg8p43GFi0ZJidGYOv/KD0g87?=
 =?iso-8859-1?Q?kAEQoHSsWjKoFeeqiINtIi1aqpl5KNxi5UoOcUiFUUN6mhjkEKdtc+2s0v?=
 =?iso-8859-1?Q?WeufQQ4wLCo9JzAalGXtD/nXhxJmOXVPgcFMFe0ckSPn0Sx3+m7/rXh5HQ?=
 =?iso-8859-1?Q?Q1sd9T8Ai/8+Fz/HcW37Ivw8uXqpWMX5qgavME5SVkuTSIp1S9HwTcUucz?=
 =?iso-8859-1?Q?vSHr5DL3LjVnvlmn22Wx8v/7F+ExlukwoGYDUR739dVoVOknEK/gWwzZBx?=
 =?iso-8859-1?Q?F3R5oG7K+mgGT3G34L3SKCa7P4KEIwpro5+7GMhzulT8QboUAM0T8gcMln?=
 =?iso-8859-1?Q?TD7cOmVdble7uaig7aMUPtZI6kZW7uJTM5wCZkutPH82R3u974yVXfhWQr?=
 =?iso-8859-1?Q?ANbQhdiExySPawF2F6W6q9a2NIIH10ImI0J70L2n87pr3WVfUgbSXbeUVO?=
 =?iso-8859-1?Q?pjuv5a5uknJdD8Kf2URRig0MFeNL7ROR2+5Yfuvd+fEDQ7cpkMMeQdQQL5?=
 =?iso-8859-1?Q?JB9AqQLXNwoLNPaF3CknJwDeFIjF8HE/PM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07020963-c15d-44ed-f9b8-08de2061ce64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 14:02:37.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/SOjpEBbEcNcg76PAAPiH34aRMlkRY7gv4W3yYyMaVYu3agIBvdY/Psf7rTB2GHbuYx58pZvbnlxD5HMNMJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7A0031045
X-OriginatorOrg: intel.com

> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: Thursday, November 6, 2025 9:34 PM
> To: Yury Norov <yury.norov@gmail.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Nicolas
> Ferre <nicolas.ferre@microchip.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Claudiu Beznea
> <claudiu.beznea@tuxon.dev>; Cabiddu, Giovanni
> <giovanni.cabiddu@intel.com>; Herbert Xu <herbert@gondor.apana.org.au>;
> David Miller <davem@davemloft.net>; Linus Walleij
> <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>; Joel Sta=
nley
> <joel@jms.id.au>; Andrew Jeffery <andrew@codeconstruct.com.au>; Crt
> Mori <cmo@melexis.com>; Jonathan Cameron <jic23@kernel.org>; Lars-
> Peter Clausen <lars@metafoo.de>; Jacky Huang <ychuang3@nuvoton.com>;
> Shan-Chun Hung <schung@nuvoton.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwa=
i
> <tiwai@suse.com>; Johannes Berg <johannes@sipsolutions.net>; Jakub
> Kicinski <kuba@kernel.org>; Alex Elder <elder@ieee.org>; David Laight
> <david.laight.linux@gmail.com>; Vincent Mailhol
> <mailhol.vincent@wanadoo.fr>; Jason Baron <jbaron@akamai.com>; Borislav
> Petkov <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>; Michael
> Hennerich <Michael.Hennerich@analog.com>; Kim Seer Paller
> <kimseer.paller@analog.com>; Lechner, David <dlechner@baylibre.com>;
> Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>;
> Richard Genoud <richard.genoud@bootlin.com>; Cosmin Tanislav
> <demonsingur@gmail.com>; Biju Das <biju.das.jz@bp.renesas.com>;
> Jianping Shen <Jianping.Shen@de.bosch.com>; Nathan Chancellor
> <nathan@kernel.org>; Nick Desaulniers <nick.desaulniers+lkml@gmail.com>;
> Miquel Raynal <miquel.raynal@bootlin.com>; Richard Weinberger
> <richard@nod.at>; Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> renesas-soc@vger.kernel.org; linux-crypto@vger.kernel.org; linux-
> edac@vger.kernel.org; qat-linux <qat-linux@intel.com>; linux-
> gpio@vger.kernel.org; linux-aspeed@lists.ozlabs.org; linux-
> iio@vger.kernel.org; linux-sound@vger.kernel.org; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>
> Subject: [PATCH v6 03/26] EDAC/ie31200: #undef field_get() before local
> definition
>=20
> Prepare for the advent of a globally available common field_get() macro b=
y
> undefining the symbol before defining a local variant.  This prevents
> redefinition warnings from the C preprocessor when introducing the common
> macro later.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good to see the global field_{get,prep}() macros are available for use.
Thanks.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> [...]

