Return-Path: <linux-edac+bounces-5426-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2DC4714F
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 15:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695AA1886E49
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2797311C0C;
	Mon, 10 Nov 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzcvpHCl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D51E25F9;
	Mon, 10 Nov 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783426; cv=fail; b=nE3kv8mzaJOrsn4KEkfft+99jeN0c3MExTg74n9LtzHJ3Iwnqwph+uvC5efdTaZS/46KBPB2Bw8ZzxC/igPmXIyRWK8hEQwPqgrfFxj5DoTefgk4219QMYZlzR9r6pohteIY++qjQEiGBZXG47KaN3x0bDKbWt4mLJc+wdSIaos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783426; c=relaxed/simple;
	bh=Ti3QfC4kLuRh/p3T4LZ8K0uYWdBUcfZzpFVkYEWehFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1jCGqQ0nVjE6oos/CN/MospBN9slbAQywxUclqlqrORrWqbfRDQTo2LBV/mMUTJdpkYPCQu7+zJbvK+RErI6AWKbPnQRRME6dUTLjG/90CSWnwr3NrJNSPLw8spP618W/xnuLwE95ost1Rox0njvwmxgr4wx69JvoAPOri4CfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzcvpHCl; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762783425; x=1794319425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ti3QfC4kLuRh/p3T4LZ8K0uYWdBUcfZzpFVkYEWehFY=;
  b=VzcvpHClHBXGTNqPUsgFYwh1Mf1W1XEqYneJsqWK067HlEaufGU46l1Q
   ApeqTKLC0l2QFG/Ygjq2H6StN4uFr/3SRQbSQ4kA+0wxcpkHGVzGuXdz+
   jI3w4cqQ0rl0uv0i5RJK9fVLpgJIxGN1AWURbYFyZhUKm0SQo4oxwMe3b
   WeLM1AW+rsROlblCKw5KiLdTMPBAqJfhTKnUH19nu1ShnLmuo9QP1YtPR
   sSlfPugLVPiAdMNv+Wg7Af/+XAfkYNWpOtuYOoTMjZoq8shuDg6wZ5vXY
   tTV8WeFBm5ixLK+GNxJoeDG2gPsmxodomaFqjUxRaT9Xcenb1e+QG2aQv
   g==;
X-CSE-ConnectionGUID: TeJaFUiZRJ+ZwS5Kr9nsrA==
X-CSE-MsgGUID: 1oXaZtNGRy6EFCUhW9BAjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87463451"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="87463451"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:03:44 -0800
X-CSE-ConnectionGUID: 94E4WRgpS+yx+Ck0PSdIKw==
X-CSE-MsgGUID: Q/8P3qqHTpu6Vi8g89usZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="187989543"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:03:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 06:03:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 06:03:43 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 06:03:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqIPCzk+WbZaq3xwuGppGS5thN6dNC4t1/35aJsDPK9qWBFOBIi5ZWy+xCICwmBN9Hij7+cXRRi0hSg+poLncyKMyAeQjY5VZQ0MOObwV1yPkUIjthH6lmwCt1g1KB73FOdV/sbER2DU27EsTTytQP8RvsJv37mrnY7BTxm0ITT+xsZvcY4D21pXoZyP6zSP84ODLMipxUV3OVIiVeUNW3o6RgR1GIiImS6UVBIJhBGJadKSFRTOKXjO5d0t1nUUGUFrz1d5JWv7SRPBWOj6A5KHdhJYQQz8yZtseitE7aqQo1ZR9kXa3e1hio+Y6RqTSmaEeFpA5qZegPXMEhudkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti3QfC4kLuRh/p3T4LZ8K0uYWdBUcfZzpFVkYEWehFY=;
 b=YE4oltW0ccHZO8AxeYzvQiH1urmwxxKEK8woSwNG01o8t2jEdSIA9wKI4Ib4UhGT1HJJlBzcdvkMITadQiHkTNkILeCAPN+/MGZOY8qlQgu+La7sKP2wH0lgqk+tg2cRxpkUwHEkrysrpwHXy02TxjSOV8Y/AZnmyGsafoCbwMghQ61VKJs4DEEFpSqze5gTTpksKWe6vjvsDU/diYR/I3a4srOwJBOe393fN1gZYk3jUcHIBjftc1mZFTPbhAlk6BsCbxCiY1pckjaPQLTozGR9sURCFkOfRhkvAH4MZHvg26HdPhYb17AAjbrH/Oov20l1WRJ2joAdLLE9dIK3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS4PPF7A0031045.namprd11.prod.outlook.com (2603:10b6:f:fc02::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:03:41 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 14:03:41 +0000
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
Subject: RE: [PATCH v6 16/26] EDAC/ie31200: Convert to common field_get()
 helper
Thread-Topic: [PATCH v6 16/26] EDAC/ie31200: Convert to common field_get()
 helper
Thread-Index: AQHcTyO4u5UeWvoBYU2LiD69V832hrTr9xnA
Date: Mon, 10 Nov 2025 14:03:40 +0000
Message-ID: <CY8PR11MB7134E33018D0A0BB4FBA477089CEA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <56ec4d8e40d24ead68a14948cbbe122c5aaa1405.1762435376.git.geert+renesas@glider.be>
In-Reply-To: <56ec4d8e40d24ead68a14948cbbe122c5aaa1405.1762435376.git.geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS4PPF7A0031045:EE_
x-ms-office365-filtering-correlation-id: 621cb6b4-fb1a-423b-b05f-08de2061f405
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qwNJE0AKgyrcoqKyDVu/dw1hkRrF5/gnKFiftxCCQtMk3cBIO8K/h7XW0t?=
 =?iso-8859-1?Q?jlSrVfktdkGaGkaF8uLblZ0zIXqizcDnq/lgf20S6Oo870O8oSiHXKhCiN?=
 =?iso-8859-1?Q?iIxffZuSksONEh4TBYFtftCok/98ubrX7oMAEVtX8yvkgZIn88VkWlXAqn?=
 =?iso-8859-1?Q?XKIFOzw7vWNTXpwy15tJLw6y8Kwfng2apjx8eHe7wKMRdPsNbxf/4vS79Y?=
 =?iso-8859-1?Q?lfi4C38TzPd0f/T1LbB4eKdNF1TOXCg+sA3bAEQDDBeADoWN9groEE2c07?=
 =?iso-8859-1?Q?ldieEyBfPNGssxc/2by+lA+kFUMdpIIXbqLnQ0VBPx699CBYbvHrOH9ldt?=
 =?iso-8859-1?Q?tfqfADlSFIbBHRAE7sSsVobnFhBiEc47odNrqXZsE1+vbK/vs2OzfV7FTg?=
 =?iso-8859-1?Q?xvugCm+gEDkre1EPvgexmbNRLeyYOtFLgAndgWk/RiPMyXw5si6QBe3XFz?=
 =?iso-8859-1?Q?da4tkpT8H2cz0WeBV/FbSgS6GRXfaWXDloXHPSulEsMJOl24wwIfsIYi5o?=
 =?iso-8859-1?Q?8JNTVRYbrEJTtMOveBzmAVM9Zpr2W/xEKgiyrXdS9XBGlD7Dvddx4d0RvV?=
 =?iso-8859-1?Q?jDfe2iRgrD3fxsUlp3xt+bDzPZtRBbJn1AyyNSDp4Wrsjm3fcDz8CS1KjP?=
 =?iso-8859-1?Q?8YNOTIZ8PjJt8Bd5ktt2ruQa9Ok8Og4WtJZwBT6ZzIrnb74fkpQND/lHAK?=
 =?iso-8859-1?Q?bAsYPoMfiydIeiMn5Fr3seKlVxV4BWu1BMlCJhLbhwg66MFfUPm6JEMyzK?=
 =?iso-8859-1?Q?MXcqfSf0m2T71S8Mtx8i82VMOp+tNAUF6Dduw+/y4KAplhD4XEmBJlpHIR?=
 =?iso-8859-1?Q?18CrJoNQSJmrBTfAm23p2mY5iV5XnQj0/WedtsGvXXRGI/hjPIfCCWBMWt?=
 =?iso-8859-1?Q?NDwpu4BK6ucXp9Pka+RNYB+rWpwPDmQqTvNN+rml1l2vimHv9ojo7Xqly8?=
 =?iso-8859-1?Q?olXujx19RffjTOCVMxHZ3+lNhrwoq9KKWdX/bN50YBIOo4AhQaHEGQ2WAU?=
 =?iso-8859-1?Q?6sFeHXfqZhpfZWHRlruGEhpUTRhZRrAu6Z832KbXbCj7o56oo2kzg0tGlw?=
 =?iso-8859-1?Q?ciV5o9Q4MJLAQNcK2Mhu0RhggncFOjPzCRYhPSUtYBpYh7QK27HUKR7q2Q?=
 =?iso-8859-1?Q?X8Ob8wgV/1FuquyNFjvrIXIfCljV4CU6TNlHpjqGMSHH0Ln5YAss/sBCDU?=
 =?iso-8859-1?Q?7Wsbo3C9k9MmPAt9YEy3Aa4ZqdTrYHQSlaCJ8TPJaVVSULjaGU0lPn6Mit?=
 =?iso-8859-1?Q?goav0TPhA3Fx/62IHHYAeVWZ1SRBOKLvAR59qRwx3M3ZgcvG6si7Fd5Dl8?=
 =?iso-8859-1?Q?OJssNf9PBrwZpW8c5UgjlJ3PTzOU3jlpAXN7rgwjBN/LOwc5mroXwQuOEO?=
 =?iso-8859-1?Q?LjdHlmzJKMcCSuGC1WrWRiM0HpIEnf9sQGpV+WiGPvHluGVaOjumbCRYhd?=
 =?iso-8859-1?Q?AGsrDRdhmZZT1UslPLz8yiqc3eJJzAVdYd99UCNXk2I4p2GPnYlO4hLxsP?=
 =?iso-8859-1?Q?235F9bp1GdllSs4XW0JK86aQYUCcT/+K1c8kfYjcnsNnO15fconWD0ErRp?=
 =?iso-8859-1?Q?8/FudqvKrsR+ILjUGVQUDG410je9cnQHLYHQG1WtLSkwmeIzAQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bzaCV2nYWMMpwye3ErfcmsY66BV1CZiT4xDSBYY4aqqjOSAJb4Sgmj2IFN?=
 =?iso-8859-1?Q?KqWFAVC/6SDfEaqPyrujW3Zs1nAW9LMZ/Ev2nFZG1BEXFULyP9YSBLV3cO?=
 =?iso-8859-1?Q?OShX45a7aR5V4q4UogInsm2jw7i1eBbbFc36qOWRYPOUllsBhXYppEjtNw?=
 =?iso-8859-1?Q?fqmVBtSizUcK5bCLbLAZvUEV1ouUvMbzCuvzRJ4RGLGW476C4P3wwnbpuz?=
 =?iso-8859-1?Q?K6/0rTTLX3x8COzI2L5jMcNasjigWD+ITQigkZL7YctTl+j9pbW4VMN0fJ?=
 =?iso-8859-1?Q?+iqtGYDJbhVQSVC9SsyZkgGes5SjqfqCn2FUSmV+v+zcpADYRnjmYOrdfF?=
 =?iso-8859-1?Q?we+N9ujoIlnRFxczETRpb7CgvV4mOV/Luw7PK53npbpsFgOX9+EAQptIyf?=
 =?iso-8859-1?Q?+05p08ScnRdUo31NJ/3nE/JfQCvTnV1tmYBaKFHkQZwHLZhyMNhq9g9WFm?=
 =?iso-8859-1?Q?Gh4SZZjHZvOem7m3gVHFVFkJkuPI9l3dbgQVDyURA8XIb4nmUNlB2vcuZS?=
 =?iso-8859-1?Q?peTDxddhfebXC2/7cSWcDEuFZGvwEi9PrJ6dSI7cDlyeyBmkaHCv3D382v?=
 =?iso-8859-1?Q?hwWKhbC/jdUG1DG01Yia+WGTItiU4YWOKB2VhsVNJkZz4yoB/pwpSwllXz?=
 =?iso-8859-1?Q?6FqMORGdiDwy/mOxtcIkDc5Rij8TqnZFyl7VZXKUSt3uSIsS8TL3AMFZcq?=
 =?iso-8859-1?Q?nJVO05cCCNNYI1GHlmcU+i20kQlN+UQDaIdNwYsUj2Y6SupxYavflSnrsc?=
 =?iso-8859-1?Q?tx/0Ha37uUBRZtAvEoDs/rNuLpPv5yPoMNogGOqbR6IkFfpNigdIryI0fl?=
 =?iso-8859-1?Q?E5ruXCsjUTkuaG26iXv8uKShp8dWJ1PbQEZ859PFSM+U/RwzYHr7LlgyAF?=
 =?iso-8859-1?Q?Yh79Re/Blg2pvz9ZoqxI/WslauhN2h2fMUJd0sFe12tV+Id97v4FSFoLEu?=
 =?iso-8859-1?Q?27CiIx1pwWGml8hq7yErj4Q+2yECbtWCG50rtZ+KAD0WIhcHS8VG/pn4qE?=
 =?iso-8859-1?Q?rWuqb7bs8K8P1s+5V5Tp43OeWvZ+Oax0RDdL+jEzKwlbe1eaw6MQ+BU/z9?=
 =?iso-8859-1?Q?l9aldRwvLQrp0uKXNRbrSRbVTPsu7J1RTx24JLF8aluo+4JN4EuvTGbdVc?=
 =?iso-8859-1?Q?Va+M6C+jCFabUM8Fyz5m0rcXoQovL2aR1JcwEkLiOI0KNVoDZUKPnOTSzE?=
 =?iso-8859-1?Q?vlRQT+PAO6RByg+i4otVP0TcqooxaJiO2JbW941MAU6LUlycpY1jn5hDxx?=
 =?iso-8859-1?Q?T181iPrpGxA/Lx3RyQZRhNN/1WdDspxzAm7mcpU+7knCYqYiXDVXXWLawi?=
 =?iso-8859-1?Q?50NH2/lEjXsgJUlI3zwdqgM5DSl6JLCG4WsPaBIKdYmMhEBgZBdS/xJ2ut?=
 =?iso-8859-1?Q?wiIObCffh8N9PgZlzGznZy4qv+wjCXvPS3JK860lGI+N/4fDCFG+XSxXff?=
 =?iso-8859-1?Q?Xn/+f7qndLXYNcuQKUE1Y5VyBfLBqjcdV1oPeJoK20jvmBj+3QYFFHWmnX?=
 =?iso-8859-1?Q?IAaDIEHzwyMagunYXRJvErDO7sESCGakDX2SS4p2FIhjPZ/9IJ5zwF1i9w?=
 =?iso-8859-1?Q?HqNL75xadzQf4Bhi4HPtANW69LUp7i71w9EQ0T6aEFhVRRPWp6pfcRuKgt?=
 =?iso-8859-1?Q?8uvWEUnho6PUrWKtt0ua9OwJM5UU5GRIV8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 621cb6b4-fb1a-423b-b05f-08de2061f405
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 14:03:40.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3Dclrjj610Ir3Bm2a9SMkkSvUoUKI6zM63G2VVWbICpObVUDqzYheQpuhprb4FVflm9Yfg3Wx+DWYrRtibAIQ==
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
> Subject: [PATCH v6 16/26] EDAC/ie31200: Convert to common field_get()
> helper
>=20
> Drop the driver-specific field_get() macro, in favor of the globally avai=
lable
> variant from <linux/bitfield.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good to see the global field_{get,prep}() macros are available for use.
Thanks.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> [...]

