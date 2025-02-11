Return-Path: <linux-edac+bounces-3024-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68075A311F0
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 17:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BF53A4DD2
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC225A33C;
	Tue, 11 Feb 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLcLTb69"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712E253B57;
	Tue, 11 Feb 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292310; cv=fail; b=sF+cwkH763/w20KNPw+eWKKTyLeRdAE5paMtzEH2Krol512KMlaWznO28pOkunzv9MuR0zYAT2mMZQsbUHjsl4mzOY0efaz8QZgPTwEZw9LIJ356Q809pGd5z4yUOAO6HK0yUie7upJSI0mjMbN2rVLAggJfQbakIKEX6RYx6g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292310; c=relaxed/simple;
	bh=VEYI1QshPIDl7bdxaucA2a1uPOTb2GHXH5Mr8sSx4A0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Md9GKER5tbQ4JBMh1EnTF/v4Dzdrf4bY6PR282TDMMZIfHB2Kz0AFlHKDzpqfq/F8gCADvROSGDFSPWWGigx0ZUTH13bslENGQJg8+MbVURKGTpQeSCI1GMuvJTcENc8MLo+wYtHXKSLOOyhj7+1NfdD+v+5hf+H9NglDtAc0MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLcLTb69; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739292309; x=1770828309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VEYI1QshPIDl7bdxaucA2a1uPOTb2GHXH5Mr8sSx4A0=;
  b=SLcLTb696O6bq4+8RcOkGVUbIIk7JiQqVh7Kdag/XWl0LgcAKOhCAEL7
   ZFDlO7REyZX6kkOA+kQFvMaOBqEFWpTuLNlkIBkWWXQmypCdNwMcMKc8n
   MHqFRcAB1QfAbke+/SIe/KK2tyHM52EOIa25eal7T0lUlNU0QE5G3jBHZ
   FQvEzcLoy8w5tmYZBj85q42mR9pXWF9savjtbu70yYNukehCkvEuHB39V
   ikiprFhtzJXhsuO6l0LZCJMxwIoY/7EGqnM8gRKznuHV/oB6FCIkd+L4H
   bwNHBYzaULCZT1NKwv0cpJpL40oksvft4/D/rTY5Qp+DawOrg7DnfnGnj
   A==;
X-CSE-ConnectionGUID: vptnCyr6QGOk92joE89kVw==
X-CSE-MsgGUID: Z/aIPM0ISg27rdUoujLpqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39784531"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39784531"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 08:45:09 -0800
X-CSE-ConnectionGUID: aF6J1j4WQR+d+zFbjx8/Pw==
X-CSE-MsgGUID: CHz9cgcFQoO63W1vYCu69g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117740466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 08:45:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 08:45:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 08:45:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 08:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBcLfbExCy3PqF5fJ/DkhSbG7X/3cVerqtZb1CB/bWt7ef1sPQhp5iStbFHhbXoeyrY6BLmv5QtJ1zCcx6qAgBUlhrB6wqrc0cgX+WoaBc4FZ4yN1P/8Havui/IQXLJlYjqOhYkUke3nYouBHcIw2vK+WAJ1/vTuY4Ug3FF4NW13xSingIU49DgJ8mw4Of31QHROoNo5KIKbR5zDyvhB5Dwf+VbQz9CQ1WsHXU2779fbqKA32ChyPafP3ruvmRKWbvisCwCO4FTyenCEu2n110bCv+3y1Z1P1lKegDtYGzVXgGNtVI5hdRX7teenQ6r1bMrs3Qu3GfRdEhfNeOfN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f77PTqwiIajQ3qV/Ge7IeAJ2fiD4AiGwa28mnjgbrGA=;
 b=a51bwdWB2Mk72HD7XFnQJwH8nsJsQfv+tfHFTXeuNxdz2KE8BnPYTg55X+IHcglvwFyvExAGe0rgDt0PAjHeNOvqzJCF4NKiXbn1XaEa0XChJkOLA3eafuGy2t1Kjw28VIXngPjxRT3RXZ+o8J4HYD7xipiff9apSv2xCSeJFvnSbH8puaNWTYitCLaa9WQYglOB6r3iDTjUNA0fI87U8JrUMo3FSl5qUjuFypAAoKlfRNqpMEccuhNRPfc3bJ0zQPcfnuaDIlQX3fKCFxZiAF3EQ+7fERAB++xoseIDnJwwgEpLiX/uaX2yiaMQrMesK+JsgcVf6P0JqWQVJSpGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5903.namprd11.prod.outlook.com (2603:10b6:510:144::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 16:44:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:44:52 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "bp@alien8.de" <bp@alien8.de>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v1 2/4] x86/mce: dump error msg from severities
Thread-Topic: [PATCH v1 2/4] x86/mce: dump error msg from severities
Thread-Index: AQHbfEqFA97VivoKakaCvm7AQzx4cbNCTzLQ
Date: Tue, 11 Feb 2025 16:44:52 +0000
Message-ID: <SJ1PR11MB6083F8EDC173234D31D6708DFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20250211060200.33845-3-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5903:EE_
x-ms-office365-filtering-correlation-id: fe5950c0-a67d-4859-8e7e-08dd4abb684c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?S6BJt/sP1HTwrytEiEnr3kjAuzUXtUagiDzOKo8Sfj+/2bvS837lXNsASGp4?=
 =?us-ascii?Q?dYu50RL2aO74QWsU7elY1GeRSmaht3cTfrtaDDBYoFKZX2Cly1jwzNaZA5Dp?=
 =?us-ascii?Q?T3yWzIrIJxKuv4fb/FHTxzNfQ1aB+Q1jpSiNqcGDqGlBDKWw8YwiaGTq6DDm?=
 =?us-ascii?Q?rA46Cn+lRi5fyItwkV3Ul/cCD8Oae4ERlHE0C08UXIDvAq6Ytx7u+voG4SV2?=
 =?us-ascii?Q?DQqd152ioi2jfpAZIDXNrUR5mu156YuoYKLJO1RTzAsaYt2FlFYUUgtUMC5v?=
 =?us-ascii?Q?EBvzeu6ytINPCSSMxbrCPo3YABGJLUG538YwZrNcRCJHmWEwGe+nfVt5VN5T?=
 =?us-ascii?Q?xys+NkCk2bb0RHZwGXBbMyHgswr+0lhjsRtKfWUz+rECE9IDAog8mHi82SCJ?=
 =?us-ascii?Q?AJW0gxhBhs6Ber2kifK/AAjaud2loo9jgzbeAqsljjsw+P83bjkEY7p16F/Y?=
 =?us-ascii?Q?myKOx/tidMhvCdzb5SYw8lAo/4Zi/23EPZmU/KUDcSWFOh/d5Q3K22s8gCIu?=
 =?us-ascii?Q?UonPblDlTzcM6fthdfYWgkVdRiDDBI451gu1YRHNPmzOeWoc3myaWrc8dtOh?=
 =?us-ascii?Q?yPqy0w6DwzUZwJrsKMXBc+IyKcmhxRBfFUYrk+x9BMtmh1W2y+Q9/SlU89mP?=
 =?us-ascii?Q?HmUW5JpM2ypFhUEBkxVF7lthTp0+/1xO0ENkcB0hdvcwhowhBr5XQ0SIzqVy?=
 =?us-ascii?Q?Dt/RBKUkNbtCnaEDWw40rsCH23EBxgjvk59F8WhcUhrAxQluaEAetV5VGwgW?=
 =?us-ascii?Q?5ExZWH1OXk8YM2ZRKFV7D8zE6uSrza7n2t8vuUzjRIRrhA9vySVJcvBobcU0?=
 =?us-ascii?Q?Hn5gQ025JEax3Jng82i7sVhvcd0BLuveBcwk7HvUVnfjNwa8ok8+OBA/g3t5?=
 =?us-ascii?Q?Ci4xBToj5UfgdPUpmsbDUmonuiiBmtPJh65rEZ8+9MalQqugHyrqatJlOS2K?=
 =?us-ascii?Q?zETUCpipf4mif+5ZfGd/Yj0dKlF9xFkTJflJbUdDtr6m6K14Qz/XUctE13QG?=
 =?us-ascii?Q?PHBLdeGvfaAhhahotuA0CCXbyHBL6NNb6pdxh/x5UjsnNDqOMQSrC0Us19rk?=
 =?us-ascii?Q?yXrPrlBjzKSzS2S9QrSjhO+h8kLNxLjvDXJLZhHbHpuUtUVgL424/nN9mL5x?=
 =?us-ascii?Q?HWgIrjv8DeSEGgM90IDpGa/G23NkLfDHv6kp0u4Yb8d2DFY6bzu+5XPYP/pN?=
 =?us-ascii?Q?DIFH7eKBA8w0LTTNajMKRpdLwAY2H8N6s2CfcfYoqreobcIfuCWca1LJmzCy?=
 =?us-ascii?Q?tzWVoNV6CfmgYWNb1lCxxvfZCTnG1Cu5VXsyciPs95rN00ADaB+AmWgxBOKW?=
 =?us-ascii?Q?o08aZexjcAy6ASW9OT2QjIRmUgaLhiHGVFyVwOoPLURBeiMj7+cdTGY9QTC/?=
 =?us-ascii?Q?EaJBCEcUaOoXC4bNTjgX0rTTvRoTi3C5q0GsSSM8hh1zYEPFdas9vG20CRzX?=
 =?us-ascii?Q?XUd/r+I/jd7nGMqQvQuT6up1DBRxsoO9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZTIPjoJ1GX35BBfj+CUtqCvSCc/CEhahB+8f5mezdIIpZFVDm8ENmnSWd5ln?=
 =?us-ascii?Q?8j4kys/+uw6uDfBn8BjH5dnaHsb+72fS/0JYspvQdcvgzHrRIZnwygR38BlN?=
 =?us-ascii?Q?e7UP7OWN6lFt8/frb1FfJKPrRq9MImrWmw0KtFmQr8wuqzJZ/zD1NGwAPrcs?=
 =?us-ascii?Q?n3/1/X1cpaeksGNqCFLp5wTUNOpseDoQFoBvwtRqvSbegy2wqOEHXUKBsr29?=
 =?us-ascii?Q?poyDHZ5T8zXdjK1O/O3Uq4gYCcpUdKsngJXPfRGIu5hB8/cJ/ytYMMX3lU4w?=
 =?us-ascii?Q?QK05v2L7qIidE86zPi9QGRPSihK8Od/GsN6cCreJuoaknZJvrWaFpmR8WXiz?=
 =?us-ascii?Q?mafQWu3z/qjPEPniVvz+rRr3E+SsbxMQ09XOnMAlMZPPSHjdkKZc2fRQRAof?=
 =?us-ascii?Q?N3ZbZLIuYRWQovIPWzgN4jRtN5C27Zk27Fj2trgvb9cjxW8o39iSrapwI1pP?=
 =?us-ascii?Q?0TRcWhvhQ74ydxLh2zgBDNbqsxuDjFILaM6BC/QmPCtNwf/bVH4YFGJWT8Vm?=
 =?us-ascii?Q?Dc3V6UrmLk/gfKvyD+gFGdHA7vYYU70LWOXxzF48ZkV7mfFg75V4n1DbxbOD?=
 =?us-ascii?Q?Is9qUnvmIQHFe7rAl8c3cgXpDMahnuzCaSN0xzwOCCdtdw8hzqu/qnHIAHDV?=
 =?us-ascii?Q?JFCH4NoGQ/Hqjt27sBtl5GLAmYk9cDpyfVMuqdCwdvMKt79hommjnx3Vw3GU?=
 =?us-ascii?Q?ZMV7CDLtX7vx7L5cYgiuV7xOv8bV8rDQA39vJMngUkBHLNlu/MQxrDoyPYO0?=
 =?us-ascii?Q?rG1tHLMFVA7j1+71STQ01wKshgNAza3vyHanh5oLzd6Ja5kO+JxnnS+r6Qh+?=
 =?us-ascii?Q?l8me+0O7wf2yaSnT5jGsuQinj9FJh/3SDmpTBXKm1NIBhZX2VqVpYeOH8Ddj?=
 =?us-ascii?Q?Hj981MGtoSZB2X/ie8HIfw/2w8oodi6fNCPP6m0xFzE0pfgaD46Y9xMNspTf?=
 =?us-ascii?Q?gcHPBIaH1+7ds4ZgMGFO6yElJIyNtydKb58ugv5oB7vNqqYXPZSEvdNi9moy?=
 =?us-ascii?Q?WoKyHRlPyVlAhPCyxFOX1fnOPmO2A72GtWuWebXuqEoRi5k1k1pApKkri9kN?=
 =?us-ascii?Q?/b+TiJSKokTRF5lm3yMMY2/J1oRE+LFf/FueBAmhyOCx83jKbGO5NdLVA3U/?=
 =?us-ascii?Q?cD32VaxUBBavnBnewoi3IIt012pbR/Bck81rQ1afGYhVitnbFXn0xfkxO3cv?=
 =?us-ascii?Q?Oi3kg2jkt1XcliEDyAJhXzxNOB2wKeq4cBQHYHk/dHboWKKpwGkFOkVUoCsr?=
 =?us-ascii?Q?ARcP4zr1udfrUhQKyJaCD5nNv0OTsRNPjLF0uSxzMp1zZUdsMVL4qH9yexQY?=
 =?us-ascii?Q?lYlHZ8KRDWQTGDAC5s8eiBCV3ZKuli1F6EjAvfqqbUK9fXOqWZ9DocVDqjHF?=
 =?us-ascii?Q?811taQJ7cbeoEOSQzCzsbxZ5sQSbVyiiGgcUebNg9Gt0vaNzwkiBUoFZ2FAW?=
 =?us-ascii?Q?uZtPmKvZxJMzX0p9/NfjiDp2PjIxFjAOKPlom7j7f2QX84vkTxDKw5OIY+kc?=
 =?us-ascii?Q?klUm9728/Z1fHffLvHEe4CegoKGiDnxC2Op3F9YJqr+UmQ3pkM0Ff/dwX5hQ?=
 =?us-ascii?Q?EuU5niBSoCAjweChyP88C9ZPt/4l1hdLcLJDJH10?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5950c0-a67d-4859-8e7e-08dd4abb684c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 16:44:52.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTu/FewDZkRTMde7WWwWDbhPCV8H6tMlLlnk6E5bhpiHCaCEvxI8slUFDw9vdz5iZw/WH/wMlSYyaLjMVpJgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5903
X-OriginatorOrg: intel.com

> The message in severities is useful for identifying the type of MCE that
> has occurred; dump it if it is valid.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index 2919a077cd66..c1319db45b0a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1456,6 +1456,8 @@ static void queue_task_work(struct mce_hw_err *err,=
 char *msg, void (*func)(stru
>       if (count > 1)
>               return;
>
> +     if (msg)
> +             pr_err("%s\n", msg);
>       task_work_add(current, &current->mce_kill_me, TWA_RESUME);
>  }

This is called from the #MC handler. Is that a safe context to print a cons=
ole
message? It wasn't in the past, but maybe changes to how console messages
are handled have changed this.

-Tony

