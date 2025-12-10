Return-Path: <linux-edac+bounces-5562-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 550F5CB197D
	for <lists+linux-edac@lfdr.de>; Wed, 10 Dec 2025 02:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBFAA308D5A5
	for <lists+linux-edac@lfdr.de>; Wed, 10 Dec 2025 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7521ABC9;
	Wed, 10 Dec 2025 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZIIwzBY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889314A4F9;
	Wed, 10 Dec 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330026; cv=fail; b=s4fGh9dAZYSWF/MnEAvWTezf3MpNsas16JNJNMeadEl0gWTSU2PzBLNwDKt74KEmll/NbsSWSrxFnAr01gkhCLgg7x4zG9imsje1LlCq3bo6vCeve8aEyaHiLvbmi7EjcFLiKnw4hzfF4pWXDmJAGrQSHXFLmkxIMqCfXDNXEww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330026; c=relaxed/simple;
	bh=GyBhQTIhq5YrhSPSbl3HWhIS4UG1b07WP3P8+04Bgmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eULGIgCD7pmTR31hihsfSSmV2KfyGeEoZqCoNp612pEuTw4Y0WD3uSoDy3eAFLTLVbQDbeVtWLNhAcJhp+lNJrxeMWseCh5dpuFSrDdhAIOUvfNzeQpWVdGRiFpRF8ngSN1SHmTQd99REu1iDOrHY0YL8dSrIT2FMAfnnJMU7p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZIIwzBY; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765330025; x=1796866025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GyBhQTIhq5YrhSPSbl3HWhIS4UG1b07WP3P8+04Bgmw=;
  b=nZIIwzBYOMuTAmSAC8AEXxaGpmmRy/9hWWavyZboLD9FNIUlIDAHwFJo
   C5qUDQOK1fXyXZlZvZMTZXBBDiR1/0/YVW+2jma1Eo1L7mzyEMkSGQei0
   D1W+X5uSHWHxOdfsNTmsgmhjMg0cfYtyr5DB9DrROE6UqlxLfqj6ZPvSW
   VcNp6qdZx6Z38T14e3gaXRqMojipmCHr1zHabi/vNKjeO6A5g9cQWev3w
   RMQ5z9Th7++XNTG35YsXEY95oYfR1dhRxuGWazfbvMJttKOSK0GsWwaeO
   eSNAZ4wiyswUy8oQO/YI5wv5yLVvgk3hMYSOLdhSQ+sI7KneKk9VfS6Wf
   Q==;
X-CSE-ConnectionGUID: LSQcSnyxRbeRfX0OtDnCkw==
X-CSE-MsgGUID: xIYnX5joQ2uXhE7HkqsQjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67335533"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67335533"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 17:27:04 -0800
X-CSE-ConnectionGUID: ovAZX4CUSoCAfsEeKrTkAg==
X-CSE-MsgGUID: 5O6IS0FoT3S92e++R6j3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="201490203"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 17:27:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 17:27:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 17:27:02 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 17:27:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upupaFzDJs1o918XIpzOWsZK8ZYLwOygtapDjIWXSaegDQ3bYkaZSmUWEpBDkhhxJKWsxYqatmuVgrQ551uVOTlwABndB/L8mIoqhvG8+w8oEIo+M899EvvNUT4D/Htxu6qTdyC7LCvm2cgcDsTpTQPO8jobjVsAwKX2OTXOU7AtOcW3Jdv0szd52KQVfNKXrX8dWtX3tPCky4TWc8MKMMVBK7yb7rERTny+ifBvzK58eB26a3peZ5TQUxHOUB+YpNbi9ESvJCwrtiMB3PlLJeqJBmjhaaXoyot8uBQ96PvW+CO/OcKg6acvL9xW9gzGXHvZUmikS9U+O/hTyuKSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6bc58/EmTCSN6+Hp/uaHxp5Qsy31UiR82hojJ3iNgc=;
 b=neSs4FVawNlEFBTidNkmc594UlqU5Mvg1Y+3EEIb5QseaD2/Oa4ebgtzd94YimirH7m/Nn+xfGy9PtlPRVkaVLAtTMtBFx800fqacYbZ4Wibt5xdaETnsA146WfXxmOTh0PSIHuoej03OCxUvXDsEq0+CeKsfRPMW1mEx7EIGAkQ0SXYwW4WW+4lV9BQBeq+MZnVqyGf6SUZLJ0cdYLjZW5pd6BEO/tlw1Q9bXREj2i6OuBzFi4xW+gqQ0JylH62g9gFtjeu7CPaNOQRkRJYFzSKijnMfo8AFwQm4yQqMrsxW6O1fsI6PvIVgTRA72L/ih+Wv7cGMB/qcOh3yiwyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 01:26:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 01:26:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	Aristeu Rozanski <arozansk@redhat.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] EDAC/i5000: Fix snprintf() size calculation in
 calculate_dimm_size()
Thread-Topic: [PATCH v2 1/2] EDAC/i5000: Fix snprintf() size calculation in
 calculate_dimm_size()
Thread-Index: AQHcaRli/FeVO2cjXUKZwwtiMSf4iLUaFckQ
Date: Wed, 10 Dec 2025 01:26:59 +0000
Message-ID: <CY8PR11MB71346AB33091B972A39F841789A0A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <cover.1765290801.git.dan.carpenter@linaro.org>
 <07cd652c51e77aad5a8350e1a7cd9407e5bbe373.1765290801.git.dan.carpenter@linaro.org>
In-Reply-To: <07cd652c51e77aad5a8350e1a7cd9407e5bbe373.1765290801.git.dan.carpenter@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB5864:EE_
x-ms-office365-filtering-correlation-id: 3df8ba46-e688-4afe-cee6-08de378b36e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?//WVZXOu4xJ3rPGpPYMdkKvGoj24QwPMtAH4sJGEp4YaSR2QMVWplXYinR2i?=
 =?us-ascii?Q?UEklzfxtr5xhZKeAAEq0q1VxZzhRJ+JZbt24E61azugaNZb9nFGoPHvXmtL/?=
 =?us-ascii?Q?4QZkePOf/V2V77+ePYmELvh22WshvdRgcGPNRxuNcSFg4aiyxmIvuVtmQEfo?=
 =?us-ascii?Q?dnYwZ9n7QRJ+Eeq4zciQr63CD8aAExFRd+mCmEgt+YNqMnfla+v2FYwkEpn+?=
 =?us-ascii?Q?vxPZyKHYLTWjvuJUV3g86Pc9KEycNxBs6ihVTo33/VTrv+0r/Th/srrPGijD?=
 =?us-ascii?Q?9BQTVV32zeOHsDY9hfG3XRZZgqzgRW0F7FnHmau0gmdAp3BAEDBoukKnJOIs?=
 =?us-ascii?Q?SR2y3CZHucRhiw/laEy/GA2yZxTVk9VuX6BhHLohJ8M8yRc03BfHNqKNekPZ?=
 =?us-ascii?Q?aBEwATWLWSILII6MpANZQ9Lo57WOSzbJG14nNCUDEXlNEZZ9oVqF+8N7UGZn?=
 =?us-ascii?Q?0s/dkNySU89RsByjQLQdtyipQ8ONIUqDN6OgoaH8tqq/XhdhJAJpreG9ZFzm?=
 =?us-ascii?Q?wuWdxLB6oDonnSe9jq9tVYaHF/752SvfFYxOJvYsIC9qlPU6o6yq3J2daFgh?=
 =?us-ascii?Q?g5glfgtTg9D3Z1zS5V2PqwF5wru7C4n23Dra70SNUBVJLOUr7k/zZqq0HHrt?=
 =?us-ascii?Q?MddGS0Trde7GhI56iYvl7NnwmsiZm7ue+amhlbFvmfHrQ9DmbkJdrmWrvQJV?=
 =?us-ascii?Q?nF4x+MomNyqu1HCZJZAeb0TVurqkMGUoY4O9vRp2sjVtXZC1T/d5gSvkHt3R?=
 =?us-ascii?Q?Izjlob7W8rDoSEGYANgESRbKw0s/eRuXGxdVaIODTR7dNKu1aGleH/CTP9f/?=
 =?us-ascii?Q?UdP2W2VtiJYl1nntfI6AWNu4XPXV2kB1tn6UQHrEjAGIYbK+C8EMx7bIk/6q?=
 =?us-ascii?Q?zFZLq+cnVOWJwpW89jEjb2mUrsBJ8hfqbj+7ENLseLOT/WP2LWQc2HcwBbyD?=
 =?us-ascii?Q?hvAHki+dYprE17SfMdI9+j/v0kF/Q5Nt+lsTFtO2CgdqBgQ6IG1ygk1bHDae?=
 =?us-ascii?Q?Tu3xZUZItH86UDw9yw8h2NBwk4HWsWJ3wKbvAwnswvHT9cPZVHNzVOadxgI3?=
 =?us-ascii?Q?bJXEyP2skYd7QePcVkGs3ZpHN6kzmoqwaTXw+3RdKMq+ZP/paDq+hEJd9REC?=
 =?us-ascii?Q?mBwdEl8kqfAblZaDDYt/j+VjqYE8E9IfIM1imZkHC+OGicduqFUXn0HPSbBY?=
 =?us-ascii?Q?3pcWJofaBd1AqmE9KNeXKQ0Xwkyj89cyWN2l6N5UWsY0eXjfSLsjhj+VZh7F?=
 =?us-ascii?Q?OBE+O8kjYFTch9iNGMTvhH6naKV2cZg5Mo56dpF4P82uh2PzMghKoFiwHUg4?=
 =?us-ascii?Q?b4f+Fqjuw/CAvyqGHkPICR6G1RKXaW7hsc9jTJzjIYivts2/+OTzlq8EN97o?=
 =?us-ascii?Q?FmqhtH0DUSzMUKIFTUmk4pVneKhHtj7A/pGtSmOSeysVRSNa4Enx3uFu72G9?=
 =?us-ascii?Q?Bij7R5JYrNlrj45MXPFH3ZbdSn4tylh+KorosOlXyDJDTaeg15GuNCIWqRyR?=
 =?us-ascii?Q?7HapL52xs5Vo8Cr3xvEVDDxGhjlllvFCLwYu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHHRhu9EYLYIxfmd1Nl0/vfzHQyit5KUbS9uUirH+OrgdVC2UGVZfq2WgHJk?=
 =?us-ascii?Q?+FNhOr7b5M+tizyW2LIHHEjuJdEvc2LDZuDXz7ez1Q/MLTHMOI5UA1HKeBE9?=
 =?us-ascii?Q?beSbP4keY1m8pVvSpuV8BnY29bDRgkkKEA9bmrmZS11lWMabcbTo6OsrB0rQ?=
 =?us-ascii?Q?d22Py4J6xNw8/niGvXHXjw6I674L2tAT9JoyfU+bQgGba4gVi2hY0p+H/yO5?=
 =?us-ascii?Q?qO7NpmQqVDgf13IjaBJSatBO/oIK0i0qp4iVA8cM2xgf2JBX+Cp+QVuwQq/w?=
 =?us-ascii?Q?110GyBcRKCHpwV6t2B/Zh8ZbAFhxm8CulXtwDB1Qniyr6vsVtAvf9am9kwcq?=
 =?us-ascii?Q?0S4XSeCfxoEw3WDhlQcRYJxpUbFq0DHzgMLHk+2XyyMaTKAtHYyRBqit+W2t?=
 =?us-ascii?Q?dkFg7VPgIP4okoqazyvp1T+80yp7A/FCb9hoJU0gcV7M8bGVxIrsM5IrkRR7?=
 =?us-ascii?Q?d2IO/Xlmalxx4AbLsFO9frzOdooxhcLtnvE7hMmYtcQh/2fJxFYE4Q0PnzSB?=
 =?us-ascii?Q?jQ/q3bpJVk3RUnNzUb0FvU5Q4izIVmL6C9HM+YH39zRHJGHX9D7NSojzaloo?=
 =?us-ascii?Q?dKMIramwSoO1A2fbbVwHIg1Fhazi26LdqDUk4bj3oxC+AShxq0oWzOGlsrLM?=
 =?us-ascii?Q?Gk/ydU3M6CqUfDNGbtbZHcCwNXyn84jMQu+s3Hqw8MArpCvRKXroQdVEUww+?=
 =?us-ascii?Q?6/godOboFkRrpb5967/Rbe+aE8SrmkNFghaP+8DbK+PhgBY+Cg4PyYXIUOT9?=
 =?us-ascii?Q?Gn+bYqiCIKnLc0bUcsfWCkIulKmBAJLQv+GONeTiRRt/I8hQeHXyuC4QFF5L?=
 =?us-ascii?Q?yuY8D8ak2ntay5Htwh8jf6xZEP/MgY7aquGLfg/5hcy2iv6UXDYEXDJ6mrt+?=
 =?us-ascii?Q?hvDNz376yhZGBXDEDYj/4a9qQA9YLw/UdZNUx/elAOwH1vGqKZ8+EbovMJcD?=
 =?us-ascii?Q?K64ehBZlBnlO0j1wK+nOJ33DDl6bIY/UNtPjawwmL+zC8vo6cO+9QAzRbeOF?=
 =?us-ascii?Q?Xj2Z71X0pRdTHNKzh8cOLaELCenH5SbUS8ZF/T+nZOdIWRy1+swzYwgoqAUB?=
 =?us-ascii?Q?0fMl9nU56pMVNxIT1vipEKNHLEra0+ClwHtBkt2w+g3Vntu6SEgqpsxeaLAR?=
 =?us-ascii?Q?cPqIUCsRK8tk3d0Y4r0/S2XcYaId7HFdvHTmlajUQqwAJy1see0Shom+PDi3?=
 =?us-ascii?Q?55Getw6R2VjmWwNaPHD5PklOIz4RkuAdKUsvNdaLkZG65n4BUrQ+3dn+xzLf?=
 =?us-ascii?Q?XAeAMU5i3HLZWaVCJl5XLTbJZCDjCOr/ruUgquigPLCa+nklQhwAkJYwl1ds?=
 =?us-ascii?Q?1J73vBlRkZekCOjR1K9oK4H5mKa3TXEHWA160Nr7cyjXpnYtL5nbZR2pAtHq?=
 =?us-ascii?Q?RNI/05/+b0rSMH1L4ZuLE2TwI1WQaYL5dr5F5yt/R6WjP/vGZ0wuIQa26FK+?=
 =?us-ascii?Q?TyBLSgDwh+jwRv/yB1f55Kao/dQZDygfh6u+1CVIOvqVFIpEKN6cKD6N82+N?=
 =?us-ascii?Q?saETa2G35oZEkZwbRpxiLrd3zFGfVtq2TiDD9cuRgBTIOdYQgjYDBGQG1bKY?=
 =?us-ascii?Q?mjaQS62bAOPKi2qC5A/RcmwPpa0seOZTGAP+V5nr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df8ba46-e688-4afe-cee6-08de378b36e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 01:26:59.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YzEJ+d1VuNvP7YXVHw3YTN5GccuErBT2pLNuqG9mvrx9mzWX+/9s8p6m0XCdL5yyR9wjpJJdKfMZH4tzOV4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, December 9, 2025 10:37 PM
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>;
> Aristeu Rozanski <arozansk@redhat.com>; linux-edac@vger.kernel.org; linux=
-
> kernel@vger.kernel.org
> Subject: [PATCH v2 1/2] EDAC/i5000: Fix snprintf() size calculation in
> calculate_dimm_size()
>=20
> The snprintf() can't really overflow because we're writing a max of 42 by=
tes to
> a PAGE_SIZE buffer.  But the limit calculation doesn't take the first 11 =
bytes
> that we wrote into consideration so the limit is not correct.  Just fix i=
t for
> correctness even though it doesn't affect runtime.
>=20
> Fixes: 64e1fdaf55d6 ("i5000_edac: Fix the logic that retrieves memory
> information")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM. Thanks.

  Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

