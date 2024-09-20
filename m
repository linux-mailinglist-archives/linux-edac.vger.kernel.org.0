Return-Path: <linux-edac+bounces-1899-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB197D384
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C9C1C213F8
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5FA7DA87;
	Fri, 20 Sep 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNTb8V8x"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22D52F9E;
	Fri, 20 Sep 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823848; cv=fail; b=d039ZU0MIkkZcLKsZhKvrbUTlXhwOE7vDMR6QbVK0X4MffDmwVa7SJtWTiwVqLlNlO/WeBYYVOfoHn1ru4zDj+oNqe0zuhudIxYLGymbN8VbV7Gmk+9Dyezhp3ntobUgUkQnXs/1lfajg2SOWpzVRa5K9hx5DtjZWPfmjHonISw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823848; c=relaxed/simple;
	bh=6lwr3aNeAAA/2iTr5b5h+LXG+db+EEZ0YBgFaUh7XQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8RrtPbGQxruhGsDFuSVd1CXHopyDI1gvTrbiC9aXOJy9T1Jidkw0cewLHU6PGyqdyxMBryhg2t2EB0DLYYDcmOTHUMfGminlaKjoscGxqjfAiVpBqVgkyfM5nlbMcRBvOBbYmjqTHjJf3s4qlycVYPLgRfj0eRHeHe3g+zr5tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNTb8V8x; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726823846; x=1758359846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6lwr3aNeAAA/2iTr5b5h+LXG+db+EEZ0YBgFaUh7XQQ=;
  b=SNTb8V8xEDF4uGwYB/WatsxmVjm7IoS/8CPRUGhVxfPoW00+BszOz6m8
   ryWwRH5q6HeF7nU73IZtVF7Ko9ncJfSU7kUTMbt4Z/O1bLFWwDYna/ujJ
   kQ/2UC+hfOsqx7wz5m0heUUuoy3xU0BEYKryYoo+HCaXQpZ6damoZQZWr
   JfPrfBDHokR9R5jqkU94WLFn/M665dV8aQJqBR09v7YtZGk+1ZKWez5M/
   jQD3xCQ4yUWjEgbn00fD+ZaRDndMs4VbtLsDwscKR6Rb/BYWGvGbI9R9m
   VtRXOmRVoxrJcXYxeJIXt0Sk3TpV7+FQXs35+5Kz9v8J7+iBUb0wTiSU6
   g==;
X-CSE-ConnectionGUID: tU91U9gHRh6tm3L81om7Xw==
X-CSE-MsgGUID: QKR89N61RNmUioVYtLtjjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="26007918"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="26007918"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 02:17:25 -0700
X-CSE-ConnectionGUID: PudzP/Q6RNKjtWuq3we9yw==
X-CSE-MsgGUID: DyyTokX8TLaaKEq1yyQ2Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="100978832"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 02:17:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 02:17:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 02:17:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 02:17:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 02:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBOtYfruiE5ZeX3RBvfslQ3/VGRNhLeoXaX/fUUactAfZwYtkpE23lRqZdcYiThy0e/hiog95PpQIx7gDhGZDz8Ok+/zGBbCYKsCGCNbwNMX3b8yeP+ZuZu55RQ5MEaz1PLvapxVYMQ2nEopVJbgy+N66HjCdAhVQVE6YjXFpJ9t3S6o8uH3C+j+KrJuNNv2dljPGQ4d9YXeKiozn2l+28u87vNZTG9Uwdfc23UrbrreUbGpfj2lN+B8SizgocaLI8HPixMRHAGEev0lVOaBjcvlyx+MxMvHT8JqJd6sqsuEK7EiJYCFolsDhhFLoNO34WLY8+kMRnkR/CoQ8LK2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVIX1hmGa/DItxvUH7k2uI6oqOG0/XOrOKPflQUYbxM=;
 b=W5Y5V/kUyJRUjrMxYKNJUZ9WP0lzOAPfW2deLww9+KmDqGlGSOI++x0EAiS5WkaElpVRKmT9kujUNnUyRwPIAy1WZODgYt5nQGY8mkG8LRhczq0g+CJvmgrqZX2vQjiDvf8QVoSnpiba7/LpPaoHQ88eQ3nQOtN3VxQ/JAz0esOBUMY1On+/52oS0LOs+08N/kgbIRpWWEF+i0q3WYwJQSN5YYxNa2ASYAjlkC9lF0Fq5upK2vcyLzeqpFxR3hQt5azPu+2m5k7Sqarwy4MgAabcyUErsKri6VhlnREXQLgRGk6w3WyEcvpUilKDWNJnR0xDsn0nTmOnqC52JMwl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 09:17:21 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 09:17:21 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Topic: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Index: AQHbCZVjPrbUzsWJXUSTGjVHYWY80rJgZ4xw
Date: Fri, 20 Sep 2024 09:17:21 +0000
Message-ID: <CY8PR11MB71344BE2857EA522CF71DBA1896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: ad655587-fdfa-4bdb-b03a-08dcd9550871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?J9byCLZxd1mZLWoOdbKQUmlymud2wm+rjnwecxqftEQIbMHH6NIYdIWBPxQW?=
 =?us-ascii?Q?Q9k/bmoUzthu3XYm8hscosG/4wbwZutAY1OUHQ1kzr3qhXbEwhFKjCF+icFN?=
 =?us-ascii?Q?H3vv5V2pkvy2WJ/6x8Xkg/tOUfyN6sBsocOtu76N2U3AHdzcfJP3wYVr0BoB?=
 =?us-ascii?Q?7vL7I8GcBBFPAFq/Y7+DUfuIlJGJaRO9NsFYBjaZpbjJwu8Jm1ve53CHjCMb?=
 =?us-ascii?Q?oT3NnN6PBQPyXaplbk5AQU+enJ4Oz2HfRqRDAfafQjgHbS7NvDaDqaxLKouC?=
 =?us-ascii?Q?g6bUX/kB+Vs5MxLlsR7p+5YxuEI/AAmQ2SpyuonecnevuIpND5coCBfT3Oux?=
 =?us-ascii?Q?YWVrm8GIZq8u5cnk2dy8iYGlpjUXT4FZR7mYVDSvs7H2SpduzRM/etKw7XxB?=
 =?us-ascii?Q?Sm4fxu440PAaENASHAogEMY3RqDHPEHY+RbGUYh4DbK1Dawbb8LluDmX/47h?=
 =?us-ascii?Q?KGbYyI4FQsfk7Sbq6xr6tZZnoImD7yKHpUehipuyGHouEYylBar7Udc//UJ3?=
 =?us-ascii?Q?Een7E1Bff8ucgQN88bneMTxP3pRe7d7hHP/sqXBz1rXrsYya4itTJXa5TpDn?=
 =?us-ascii?Q?A1SJCGXNbOwAxvARWjmOu6b2usjHHOHnAQtkVIs5sp5KaB6dtVJj3s8P/vGQ?=
 =?us-ascii?Q?SE3RQHtvSATYOpheusSTY0x1K1UC2OJFRTgGlznjuAwzVXiqEq0no88wbNfg?=
 =?us-ascii?Q?o/5OSGmSJ0V23JHHxIBqiT1kU9R1E4WPzjUa/lG/iir9hiCz4RzLxYtGFvyv?=
 =?us-ascii?Q?7PL7Z7X2IU4SAOUlJPuZ8FAL29MS+sng1GftnMiNV0ahQx8bEU5ee1iMVsmO?=
 =?us-ascii?Q?dYrcJF4iblVZoen5nWLgV3Y65azacfIJQB2jN5BALmf9/yiZQ0zD0rZWWtKj?=
 =?us-ascii?Q?Cn62cIaUmqwquSo8Qk5nfasUXrKSktM+QGTyfsnVdqGlgxF2rsGp2qwjKXos?=
 =?us-ascii?Q?qb1FYhXEj2Qm2BkBh0temlIBE6CHaAEUBlU7kPVFDz0p2RPNdZ5RTIZIPoN2?=
 =?us-ascii?Q?/g/1yLFs3e4KIy2jOacf10wfPP7icukDVRiCUTQDnISzdPwOZ5DjzpoBpDo6?=
 =?us-ascii?Q?YSBja73SFwfCpQpkNLGWn/2R2IzIDywemgJEq2fjqvPpfW9B/YnGRpZb2Dly?=
 =?us-ascii?Q?8hkuZDuNjNy3heK8IJtz7WTOVSO7qZNzOC66k+wBEfJqpzCYPvJlk8dp2sbR?=
 =?us-ascii?Q?K3IgF8uMCnwzxzB2DnKH9Zw9/CoAfzzCqrTah+dAS0bJTp16/BkQz90Dy99A?=
 =?us-ascii?Q?aBhOUXrghfMzHmbDJIzQnZVbOypG9+aqV4hbbb1hx2WYLx2qA6eC0p84itqu?=
 =?us-ascii?Q?I5m3ILUUPgdL7/dDD8tTcmsKS5ThwTYa2jBkoxKldvWvLQu74ti55vKUXCRe?=
 =?us-ascii?Q?Y1/rqqk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7OCxN0ss+IldQHTu7NB38/hzApMUkOYHvhuc6OGqbKEifWB/3q9BXT8DGa38?=
 =?us-ascii?Q?2LPU+0DnNXBlbng8BitJ7gdEppqhUOc2GgClI3MPjLlUO+r/PPlhG8c/FvD5?=
 =?us-ascii?Q?N8Z8wbR4gbofqDhpYqoxgo9RNvGrW8FTJUH5M2sXwaCBNqWZrDJIuQD2NgrR?=
 =?us-ascii?Q?eXrmlC6+dwIhVuQxM59C/5DPzj7aLyBICzthxTsZHoEYb0zCKvY9P4tqdBR4?=
 =?us-ascii?Q?rBX0Hm/J4/AaS5+TDHo1q1YeaF3flMjxGV3C0llURpo3v8c6zi0qfbVd/MiM?=
 =?us-ascii?Q?ct+wnu/p38dPDeUsLb6sXN7Lo7qNcBzLvBm/60+KxapIbcNFyJFztGq2O+hb?=
 =?us-ascii?Q?69vKm18tNiIHeN0kgNHZOpkWIBoVkweHGgAQ12qQpCbVOPVWHvi038Mw1pAm?=
 =?us-ascii?Q?M7zKD+nLEBCd/sAUEeP2HMFmDDZO4+MF4QRc49ZlOVWHLeZHU2bvQWAR/BQn?=
 =?us-ascii?Q?ADdeJT1pE9/tXI/jt/0v/e0fgSJszcYTF55UENg79aerW0RJlpRhQOvG+Juu?=
 =?us-ascii?Q?oTVzh71hF0rI2gLBooCKe+i9RMysTCOG7btYkBzDy3B3D+trZiyzu61+hKBE?=
 =?us-ascii?Q?sOIxE1IgVPBAol369Vqw5xNk8Z8+hQSqECYDXDt3uj7u68UMcRZur2RYTz4j?=
 =?us-ascii?Q?QVdf2GdFTzWXxGjWsVw4ZoCrf1paNwGgb+wLX0nTnN8yujBiLzFC8PgxSQlb?=
 =?us-ascii?Q?SxWa2J/vgw59OXHAP8chJ3ZhhpZxsxPbMs8wfDvCCy8ZtwgCqN+/xdOJdzR7?=
 =?us-ascii?Q?mc1/KbrfOFt85oY4jg86mW4LMVVQ52GBddKIcHswshnmS3Op8G9TRZaF3dun?=
 =?us-ascii?Q?yFLnYdhkh4YUZvKCl7GXb+ffXhh5bbVKvuWe331YYJ5oSRqd8ZJMfnG0bD3x?=
 =?us-ascii?Q?tIouekOnYYZUlXU4KuHTxLaXQ8i8Y6cHRSjpNp1zVhbkFTo9erFbqMZ1AAvr?=
 =?us-ascii?Q?i3XsSTH4pdaGzMo2GA1p9HAAgGTVXSV0hgsrk7CFHmqxGi26Lb91qKnOPgOY?=
 =?us-ascii?Q?VvwugyR9ZtW2fcBlIkOAtVz0WrbTB0zMNslDwIfYy9Nbq9zqpM/7igs+8T4Z?=
 =?us-ascii?Q?Br22claWqCLEMDCSVgOgGLhAdOWD6jvkRVxM62QckPO3NWFRSEif9IIZ9qi8?=
 =?us-ascii?Q?O4GrCtvizIDys6YTlitL+yn6qGFaBV010LfVnC9z2PCwK196qmq4/SmonwkP?=
 =?us-ascii?Q?mHxmhlBUJc1SFY/r7Lf/3epEvy1s9Y1Dwy28oEHe6dS1O2RQOZHorBV5fBGc?=
 =?us-ascii?Q?HtSBxiy3WTP0S/VWh/kHzVWunsbIWgRvm6j1fo8+HthtGwnqF2cNnBQ5xr4g?=
 =?us-ascii?Q?AdAodYUcGdtWZ4IcRE1Fa3uXEeOZ8RPUXEHN1E3mAvhukgWKQ1cW5DYyxFpu?=
 =?us-ascii?Q?XQVkq9RGghEaZIIbspHX8uVDFllXeREEw1Gwo++9Qj0Al4Uzy2qB/VwPx8oX?=
 =?us-ascii?Q?5Fooxe9Y/n7V7CGXnwjvcytAZ3xmvt+C1xJpMWAAaYI5J5Y2piKbu3MVsV/q?=
 =?us-ascii?Q?Ir6jzLNM2pAjwiZmxs565YnTeFKpA/DTVyIKe1io/hUlGLZnp+u4dDv8Yr4V?=
 =?us-ascii?Q?AVNkSS4Q3GanfQ5RZhZZoZX5oNA/fiyGlbsN/TlG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad655587-fdfa-4bdb-b03a-08dcd9550871
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 09:17:21.6352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32PHUBvwAeW9SCXH4fuIzIdg/ZJUQXre9BAohN6ud/lIi0smiVEgJbW5d3iJt20klZeP48TB79pYS8qlUJMjig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> [...]
> Subject: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
> [...]
> --- a/arch/x86/kernel/cpu/mce/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
> @@ -63,3 +63,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
> {
>  	intel_clear_lmce();
>  }
> +
> +void mce_zhaoxin_handle_storm(int bank, bool on) {
> +	unsigned long flags;
> +	u64 val;
> +
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	if (on) {
> +		val &=3D ~(MCI_CTL2_CMCI_EN |
> MCI_CTL2_CMCI_THRESHOLD_MASK);
> +		val |=3D CMCI_STORM_THRESHOLD;
> +	} else {
> +		val &=3D ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> +		val |=3D (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
> +	}
> +	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags); }

Are there any reasons or comments why it needs to disable/enable the CMCI i=
nterrupt=20
here during a CMCI storm on/off? If not, then reuse mce_intel_handle_storm(=
) to avoid=20
duplicating the code.

-Qiuxu

