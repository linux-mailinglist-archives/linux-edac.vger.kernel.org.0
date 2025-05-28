Return-Path: <linux-edac+bounces-4018-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9DCAC6D2B
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873BAA229EE
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718B1E8337;
	Wed, 28 May 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7RXcLWu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6901C860C
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447258; cv=fail; b=QUi/dQMHM0hRjVE2Dc2UyAF4CRZN/jECp2MLODzebI/WiopfYCNMAddvwc+I82xZL/nM4cn7wiYS6U2H4k0jkBcH9KbA3jVtMb7YRUoIvLXPi7RB+pqRU9g5T/PSVrnYeTuLyhq2TfxxWLfPVUOh5fQmQAne7I4XnqRfGUJ5TYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447258; c=relaxed/simple;
	bh=vuXmgYJyWpa941gKZrdtDJfFeeBTKD+9kQsg5XysZzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZujb+/Wx/Jy4gnU5A5rAyr2rXmak5BK/a9kRDitO6qAf9qVm9WppRNmsK52ogM8Fgd5HnMe6imAADd4CQZV1av4lgIlxzov1MXPAy7AXI8QqqhzUrXoA0XRSpB0sBaGeMny4xE+PInWh/Y4nsTmqJGkAFRynICcZdG+xKUUCl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7RXcLWu; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748447257; x=1779983257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vuXmgYJyWpa941gKZrdtDJfFeeBTKD+9kQsg5XysZzQ=;
  b=M7RXcLWuUXJF0F1rBx8ARHpoXR5CK/YMDQEC+ysWrlOsVeXps7Vii4Kf
   kzBoPJzJE5mJ0N0RY23Ag2LacWgl4iX/IcBNu6Tnk1zVD606/Y138Zgtg
   3x111ZFJx9J53sciVn8KMe3YBBcPAMI25g6a0sDTIyGmEnm4gp8MLiwmz
   LMC8OYejrQ1YYLhwnGtG4xcRBtffWElItyug1CVapQjbMbkN+senxcLkt
   w7vOBvAkqz88Qo+c6qU7wYjQi5FPCOGzp0R4z6oeyp5cWP580byIfVUSi
   J6WrwiY899iUFBmBUYXT8J/CJTrDZEJNn6P1RZVEBcmjVhIoLZEx4HPfu
   Q==;
X-CSE-ConnectionGUID: Ssz+TfrRR+2qCV+lm2QdUA==
X-CSE-MsgGUID: 2VfPBYbbSwWf+IyoBa76Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50365829"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50365829"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:47:37 -0700
X-CSE-ConnectionGUID: RMdKeRMDS4a6MEWj5B2m7Q==
X-CSE-MsgGUID: RtM5U9euRD2zlxluTHMJkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143610852"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:47:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 08:47:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 08:47:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 08:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbJoKGBP6/YaVHpZMcAgvkTsqA5gQO2NlLoMM8CpAX9a00mD8Lf1O74/1T+pAd8XizH4mIvYWdWL7LLc6Ki50/Yr7wID0wBnLDkKFG8OKe9tlet33kVg8UK8S7R7puLcFwrH06TGEQ2gLNn+YT8xjPBIE8jSw6/jyjsJgyWyjflFfHcrO6EF02JPj0Noh0VXJoaM7rY5KJemQ4AzY5vk5Sj0UJAZqFiVv91pCbWn+lFTy/aQC16fBpimKHv6s2ACLsMefV1AS+StZHT7fqQb7LDghEyBBIbqM5UirwqVkT96XKJXGSxAr+A+imhMxRBJwE6hWd30WDa8LLWIqS7fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDwqdLhybiv+MjYY1qSQe2k8K681/4vGrFAXFXsVd8g=;
 b=hldfiflzE6R8Cf/uEMHVr/JZm0cZRW+tB14rXun4bwThRPQSstVSVZAGMh3kTvT44xAnl4GBzCtB9kQw8XscU1l4hwbUofM44zoP7p3ZV3rQnSWLExpbMPeU5Ed1ABd0xQYsIeenrxht5YFxCE2AX2hu6xHl4b2MgNK2UopsYjhLQUTFx3h4JHWPyWC17YMKaMhTQWKzpLWy7UDo8Umwz/FenIYUioKZ4kDooqvxnj/utKTSPlAsg1i/SrA+96gXsoFXp6XDX1XVSf+bfOolrD+iQiYi7Qd/VBkw0z41+DEDsgMVqXYhjYC0Zd/7xCIGxU4KS7XEkfRXvciwykku6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 15:46:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 15:46:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test
 failure on AArch64
Thread-Topic: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test
 failure on AArch64
Thread-Index: AQHbz44ravwctxXgtEGOmt80h/eaQ7PoMA5g
Date: Wed, 28 May 2025 15:46:50 +0000
Message-ID: <SJ1PR11MB6083AF9B06EBBD3C4864B929FC67A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250528050345.380-1-rex.nie@jaguarmicro.com>
In-Reply-To: <20250528050345.380-1-rex.nie@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7512:EE_
x-ms-office365-filtering-correlation-id: 1c658bf7-f817-4a73-ed91-08dd9dfedc68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uW33+UXAwe67RRISs4iaBkDzan2dq4hQZg+JDYiIUHMw0Ijtb8R5TT0AHXml?=
 =?us-ascii?Q?zmaKAcXUoivlgJNKu7Zth5RhY+1pz8pXlZvYxntWDp52Yri8by7eHt5Q167M?=
 =?us-ascii?Q?HQ1K4I6m7UH9ormxEwmZlQFksHxTBE+PEaPsHqscmTXI0dgfi53RjP/svE6z?=
 =?us-ascii?Q?JmFAaBsq1tt+6ybVN8TAe+USiyZnLazMSAU6uUY8LiZTIWN+xQCFabgnjqZg?=
 =?us-ascii?Q?OxghcIHU0WjPWKPeiP7dxk0xZd+PSOCA2Vd3ZPdgSJttdRFd74J0OnWke/h0?=
 =?us-ascii?Q?2NMqg+BkseJN87F2nkvH6Uek7Pk48nbK+6DS3HMpkeiHZVh2BCOrb+TQw2EO?=
 =?us-ascii?Q?QUFitpJOJ/nRUFY68k8VtEo0vkIUiQLrVcAxNm0C5NVsH2MtzojjmxcGvOMt?=
 =?us-ascii?Q?2PspFsSa36/bwO+lyNJngMYr0aSpgp7ZZMaQEOnAhF0v8wXY3bSiyYYUG9R9?=
 =?us-ascii?Q?l9Km/4uCzVRADQjxPr1Ioyf4Tqou4H2sns5A/aLSo97k/QXyVJvBI/UhRIFO?=
 =?us-ascii?Q?3xaGyp07iJPQMD9D1x/O1hKNIxRSZT+DFcVc9pq6g7cuzND2mGHRxUPNgWTc?=
 =?us-ascii?Q?H3AIUzlku1DVd5k5MZEADBbW7rAE+JV2Id7pS+ipLHN3Rva0c6nHTemuF1XR?=
 =?us-ascii?Q?JASF8eg5d+TE2VCXLWaBJ6AMpIvNddM7Nn2idO9e/ytRQgF71GeWlipVvjRW?=
 =?us-ascii?Q?CK1Jj0VNbDW7Cfs9aHJnbOZQRkoEolk597oFfDeoEZvmCqE5u2UhP26JE3uz?=
 =?us-ascii?Q?HPmOxGh6uhFUMamptpNjXgXSjjuSyIbzDILyQvsYduryKjZ5hOSS2iqmbO8H?=
 =?us-ascii?Q?zCmgsJjkuAZOCABzZVHJYK7bbmRJGFxXHH0bRASsiiNW35r1VUvdNdWq6Ccf?=
 =?us-ascii?Q?oX5AX98auFDCssWkUEwfySkx/kKOGHvfjBFClumojmGoAoS2+OUquyhJ5YWR?=
 =?us-ascii?Q?ok0E9SrhwazZaJY9K5bmjGrhC2/Iha2zxBVZf3fb9UNLOSqjwYYH6jYBSro8?=
 =?us-ascii?Q?Sjy4LhYENyMyXlorncAe67R0DN3UtbIuWaKYwg4LNLn0cPBaoh72cximL0TA?=
 =?us-ascii?Q?TtZk/8uR07hK91MyO/ep76QorTI9VAtsC65+haxhnOP7BzHmUjPBxfjuu7x/?=
 =?us-ascii?Q?LkWPMo0eRcMvPLmJoFpyj3y+R5ZDM0AvDadg2fDVqOMWGKjQEldsNXgEs7Jj?=
 =?us-ascii?Q?EsljEsiQMqttLSzI3sDWGr+QRXT6yg0dTl8bpD3tB+DrBXlFevZIb7Ib4hNR?=
 =?us-ascii?Q?pIpt8YetFBIULSrbC0H5j2NtAbqWsoN+SDCua7+7/2LCp+8RRvYInJVGPgdF?=
 =?us-ascii?Q?/ChGpNfwn43N0WB0uF0grBhBaz7GE+Jf3lp15H3II4SlrV7Z98P+kMjJLOIZ?=
 =?us-ascii?Q?73+xU1R24i+MmmyHMhICVMZxOjrQ4abSn+DB2MglQMr+5qMuCG2isel9Vdl6?=
 =?us-ascii?Q?qRV22Xacp+KP+wjQs5/T4iy7Y0koIFJivh46rBcobJ0Zn3NR+FQb4UD4eNAi?=
 =?us-ascii?Q?sBPdw/0+6Vn6lKc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ec5UIdGQnzV0CVNxRxy9tzLHnGDJ5lVhgH7YqD/or90rST83SbVTNtKAnMMY?=
 =?us-ascii?Q?ixiOzpMzyyu4BxaD7O+TvGf0Q3gWquZ3aZOSVoK6UATG2mkpb85lH+glvjBh?=
 =?us-ascii?Q?4VEGjOSI8zHWySu/+9ORvPrx14vuixIbf7DpMmiU/y+2TqF7msAIUQXXJnnR?=
 =?us-ascii?Q?C9JTdTRiQfdvPrjPmCoUnrh5xXoxMhZ4io2Qc/bmIHTtIjLIkIFoDg1Ykc41?=
 =?us-ascii?Q?rCL09ms4ftVtzPK+rhuFWJfkSk1cNqXWpMb8iGIjOjwTKKenWzsVdBlGMG5Z?=
 =?us-ascii?Q?wk1iK72bVTkwBZwX+2etGpKLtoehj95AHu5E6h4kYfZ0fsJWIDdHbWXBfguG?=
 =?us-ascii?Q?ky4obeLI/oQVRGUCkzFlgEfP+oql2NlwU/h3BWtg/GOFj+K9RmjWYHCT5Vlr?=
 =?us-ascii?Q?7hA0aTX2rx+n29eMgRJvrttyD6kD7Q+ooPVgNZU19joMxwGO6vE7pHgZIiEh?=
 =?us-ascii?Q?mCD8b1fdJqCrGSxiL7xM5hjTCHLZNHJhLeId1LYKefTSYny+MBEpo4iZrEGr?=
 =?us-ascii?Q?yDUfavzA2wptxCrE6IHEjK0hgK8tZO/9CzhuaZ3y9f8tLoR3BbD4I4BEz1VD?=
 =?us-ascii?Q?Fxt+H0wvJChwPGD2FXo70cQdRqbcFiJTGWAOQZH8qtcIV9LJRTO1/DHbwWah?=
 =?us-ascii?Q?RkZsM24N6jZkiqcA85qGeIGlsM7XaurgyYJge5FFKCMtnPWpAlo3s1O+wbNN?=
 =?us-ascii?Q?Vgoj0BygDELs1KooQKRJzIgVlwQFBdx6Vw/0wfgFtmQbdc0SqN9y1ObYrDV6?=
 =?us-ascii?Q?VN5dl/ijjyra3O9pPhlgW5UiHW1u4gShBtr2F/OHVdFSdFx4iFGwMbdE2xPa?=
 =?us-ascii?Q?QqFzDPAlUE0nGOBDzT6209UTcVLrQ14wZ3Qw/IoQ+m/unj3dwJDY6hj9yoNA?=
 =?us-ascii?Q?bVIbQpsa6ncWEqQUqeG2S7sWyfXE/9eZMp8rGsQsVZAsGzvzWZ7DsEctvnxi?=
 =?us-ascii?Q?dXrwJdl/AKyJ+KQ2c+z2ceUxgj8c6/VLRo9OueURxb026lJAUs24AaLYF4dW?=
 =?us-ascii?Q?ht12Z6SGLYNClQjPPfQsLy3a3O1W57ZUFQDsvU5Xq4jYR7LKNOuYHikDRq02?=
 =?us-ascii?Q?YZhC7RZf6d01DKvgtr35G05tR8SzFjH/USiWo4Jmz55LHBH9GBHa+y5S7C/r?=
 =?us-ascii?Q?c9zSBlii9PJ9pTMviDCrRWcOQltdrtyadD+ery7ZvBXfwdXkKUN1pvNuRFR2?=
 =?us-ascii?Q?SdnlpmTEirrNJe87AwGxcW+qrrvG++vJQLuREHXLURiqrRG+Up/q49342uzp?=
 =?us-ascii?Q?zgUTq5E1PLZ1FvLuiSuMXNz5PpQ7Dkch2JbwK+v33dSUPy3+Yv66ykeCEZo2?=
 =?us-ascii?Q?tmHM0/bnZOutvaFLFXASTsRm+E82jMoFsA6rBXjy9vELLUbmAoinaS9uModB?=
 =?us-ascii?Q?Pf+M+93EMV0glCflO2g7xxNEGIbDK8RNpWWobiaueqeMHsbOM03ZbuQY5vNE?=
 =?us-ascii?Q?r1SiBakvDvqykJSiLR24uSkXyoU/mGVTWbDIGTJ3m/SY5i/FTE5CABOFPnWO?=
 =?us-ascii?Q?9HsYpPtzaNyT+259MW61Am3YHfuHF+bPfIWihVc4QEdJ3JnV7NavvNyk6WPL?=
 =?us-ascii?Q?Y7ZeXl0vvTM8hJORdZRDsokbGr66CFWk1ZBT7m2d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c658bf7-f817-4a73-ed91-08dd9dfedc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 15:46:50.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ya9aXrsOnJ9xQqt2Wn42NRdhRSZcUjihniv/NzhfDbWNGPQvrCNBacOJvAYJoIrlUjjSNm8YJQ2wHVQqJOAg9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

> There is no /sys/firmware/memmap/ for non-x86/x64 platform, so E will be
> empty. It will report bellow 'syntax error'. This patch will try to get
> end of memory from /proc/iomem if E is empty.
>
> Running random_offline (random soft offline test for 60 seconds)
> ./random_offline: line 61: /sys/firmware/memmap/*/type: No such file or d=
irectory
> soft offlining pages upto
> Using random seed 1748344561
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> ...
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> time over
> soft-poison: success 0 failed 19856 of total 19856
> unpoison-failed: success 0 failed 0 of total 0
> poisoned before: HardwareCorrupted:     4 kB
> poisoned after: HardwareCorrupted:     4 kB
> PASS: ./random_offline -t 60
>
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>

Thanks. Applied.

-Tony

