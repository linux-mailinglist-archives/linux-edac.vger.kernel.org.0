Return-Path: <linux-edac+bounces-5481-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2AC711E7
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 22:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 601DB34B04A
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BA2F290E;
	Wed, 19 Nov 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8oRkXzB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C72F12C8;
	Wed, 19 Nov 2025 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586784; cv=fail; b=KHGtUWO1vGgetvXWfuNalwK9AZqiJSni5tRhQB75P4lzK6Bi7XRe1zjoA11oOcuCR1/xl3/DZ85yUL+/C3MDgKIjxiZ0A+fJKL7/hW+QCRjTp1edkgU99F2WTvr2a/I4t9ltMV4bgT91uYXIAZbm75oyte3s5ncJHq0d3NFcDcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586784; c=relaxed/simple;
	bh=H/fGLPdD4N5ojRImk1XMFKSqEE9yN5+qXJyLW/Nww/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nAQ5jQrs6jgkMi9SfuvZuLyoVBbVtXGx81wijRw5BvUvNAffDeNOn4B3/1123ysSPHo5GdCNAL+od5Vak867pAGNHGbZNRJX7JJtZJQyJBs9w9U1ymVjT0StYtnQjSkJojb6+6HF600DDBVvVKMsfStgLHP1LBoahUcHD5VAmVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8oRkXzB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763586783; x=1795122783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H/fGLPdD4N5ojRImk1XMFKSqEE9yN5+qXJyLW/Nww/A=;
  b=V8oRkXzB0stAZVzO5BnHPPEnyQekRzfXG5iDTXglYIfRJn8ZYHuSF/eH
   w91avrfSgwU1tKd15BgVX8eLXIJ3YLU11b9TA6cAEMTnmN2fWlq/fhiTa
   pAxghwdCOGqlwDFGD+5gVWyVsEXEo44LikyMxj+gwGP9PAnKFv7Oo6veS
   KJok6/AovIw2Wi9cd7WDdfk3hIYf++MdGw9mCWAhXZKHq4gZjI4J8KoPR
   JH55701qfa77opAIRors4QgNKv1K9a/Oe+KOoDgBiMPSvcL7VcgJsqXsW
   P+6XazzQlDFtRFh/rKAAc0ccJyjKo4pHjRZNkQXJ8En3BsUi7WJwOrp4Q
   w==;
X-CSE-ConnectionGUID: DIWsNiwbRrGT1Uyvc2exPQ==
X-CSE-MsgGUID: QBZOp9DcQzy9ADBSmcJgTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="68250129"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="68250129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:13:02 -0800
X-CSE-ConnectionGUID: 8ZpHJDjKSN+tTA1D/iu2fQ==
X-CSE-MsgGUID: AxpXZpMfRUCezyvw4ZEXEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="222101366"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:13:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 13:13:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 13:13:01 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 13:13:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB3P8iC/uxwfXm02q3FKgjJTDtBTt6tAOVwkUdJaj5InF/QkcFbwfpqqb9RWY0hSHfk9+AQAsNwClISAqj1NFPivEmKIMKHnNfJ3gf+4sDFPgnZivhMC/KWZ3bVoSPyDeKaej3nvN/S7s8m9Mhy6KYajsF3or0YrfQhXu/VZihG6uzi5GBh1gW+w0Xo+xgaUa+eTmfNHCf2OQhkfwvC7L3NmPlFUk8i3nB4oGcev95fmUUe6tE+CPt2+MD65T7Md6ZYQfxPSn5Yv88wpqIiwMrCgA9Vhm75wn9NAgpK928L3bTXvGfgerzbRAYi5Vidbk1V66fMNgOVtgZwWjsSEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/fGLPdD4N5ojRImk1XMFKSqEE9yN5+qXJyLW/Nww/A=;
 b=RaytZTMZbFkZulo7sb72oxqT3YHFJmQp88EWp2kA8ATzPcHjkcCngdhhebmZ1g0w7tYVAf+uQo0QImDHi72pJrzn6jsj5qClPz08TijGkHH6DCopRPQ2zVdP77iOxqzDi8clm2d1Vo7556N4tP5fCujb6GluOZKkCxNllHAKyfirEOvTFXs/opbKdTo5Ey9qJYcgWmM6YCBspC7l2UR0Lp+HLTgX1DhGvj2o6lpiXij9YCIpGyU9aauGENqQsZGDS/sBCaJ13KrkTV8Sk+MzXZ4JPRRFmr9r24a//JvfiOaMCPLS+EJ/Sh0GPCo1LT3NzEsKm0BESf2uVYq21tBLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Wed, 19 Nov
 2025 21:12:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 21:12:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>
CC: Lai Yi <yi1.lai@linux.intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Topic: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Index: AQHcWVsxJLpLQDG7FEKCpGfQ9oJdoLT6f44Q
Date: Wed, 19 Nov 2025 21:12:59 +0000
Message-ID: <SJ1PR11MB60830D5FFEB9762FEF78DE5DFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6093:EE_
x-ms-office365-filtering-correlation-id: e5c00c87-cf12-433c-7634-08de27b06ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?JGABtHgISmZYDXNnDNWfdtt78tTG73qUEy+AKXhF2yvuJoXAOktC4+G+V0iE?=
 =?us-ascii?Q?t+4GoI6zRtV+S1EOk5fbdMFkbn3r3fan4PcKXikZ41KUOe3vBSWjXQo/W3m6?=
 =?us-ascii?Q?76JAQlOfGnxnzSSlBV/kJFTNtT+ihIl4IQSP4tL+rplKX4mP0g2Ft9PqSQ/W?=
 =?us-ascii?Q?5XiA20aDMGze4ncNzJMK2dIOWbRDc4EGLopoO5BZghfoSidvB0PYm9VZfbB4?=
 =?us-ascii?Q?6AAyO+vaGbRqdpUg7iiRAqKlLwiQgW7UBplW3xBZAv0Lv56Z/3xGlAT4vWOp?=
 =?us-ascii?Q?tHZKizdLV8NGBrJnKmuw9PlzG7NDKMmA6ihS09LyQUMwTu+HFv/rk5dDd+jm?=
 =?us-ascii?Q?RxQx0N0xlLYjh3KTOPmmye/tz1YqWqoUPhDiG+5IEnHJRFZq241YlnVQAknQ?=
 =?us-ascii?Q?klEeGYMwUa+1/tMD3Iv6H3nJxn6hFVX4aPmxh3PTIMXgvUgtLh7jYVR1npHe?=
 =?us-ascii?Q?MvuvStMLtNQ7ZmQzWfYE4YBA8HYIcWtRM1Q6BCtGz8V7S4RnVNJWRmDl2Mj2?=
 =?us-ascii?Q?WV5YYMmDf5nveNUmNQQEY6/3q0OxTy9qS+ZjX1XYK7/TpOA97vp0w8++ZAce?=
 =?us-ascii?Q?WY/2+EcvVgFXFtpYYIIfI4Z3s/Jq9gLZy9rCq6Z8C1s5W6jRGaefrFWeuvaO?=
 =?us-ascii?Q?g5saR5y54B4IpXAdcxudAyFSgFwOjdlt7opr8rMJT0ujRMnr77bPoP2LJGVE?=
 =?us-ascii?Q?SwYMt8mYdsoL478gJLwA5ns6Dz9C0PJpTULTfZv/S6MoT4RgXOv1bzMy17Mc?=
 =?us-ascii?Q?sHBY6Bqy+VnKDxClV1Pl2QYhNS+4myGyJYArkhzSWvLeMvVEB+hfOj9G/aZD?=
 =?us-ascii?Q?DgPErIfEQKharsPqOI3W7MmXzCWakLOUEViLQ0Ex5ixrXTnZ8LuKDGfOGxg5?=
 =?us-ascii?Q?Llr/tcf5tT9a24Eq3pr05BwAvCEOETLJv+S77l8dokcn+Huf5BudkHviVpOw?=
 =?us-ascii?Q?XA0mJUsu199hKQN8rUo68TYjUL2fVKT27ucnza7FFWZlfj8/XyzrPqOMNfWd?=
 =?us-ascii?Q?2daFFEa4aMbLPF5hCdF7lm4msLAA7FQrLLlgNaXBk7KbHujm0Byj9dQ777rK?=
 =?us-ascii?Q?hVTrrA4rgK2mmmdD5FsDoILMIvyPIyNtZlh3Sumc8hGOuFhDbTMvNIFm3QPG?=
 =?us-ascii?Q?fskcnFaBibloOwSVPbKuEUkcB4X+2Gc/0CvHwHQ+GlCeFHygbawGTMCCbpYG?=
 =?us-ascii?Q?KQOcGyxSvh6Se79RGwG3HOlpbKjwO+tqOJQSsnATh9Be0tw0fxyncZfKN+eT?=
 =?us-ascii?Q?3lYcv+ce2UZqQ9w6vIcXjEjhMvY2VjnNvax3QCXyhtY7/f1MTp0gAVbPDRpN?=
 =?us-ascii?Q?wOPwe28djf6VOqIrcDgQ1hxd5SCWzvJQ6c7hoXMbLzb1E0lAZXP9P96RBAzk?=
 =?us-ascii?Q?8Ei/4LoeX7sI6Hjj1a6rQ1cgwviWAPBAXUo/coYOdiSwZ0KjXLgTW2U6w3VK?=
 =?us-ascii?Q?1LyJiyLzQyL957AE3pSOQn5zkxppB6d74ykTTgNoWQ0jEa9p55gFxgmDgPdd?=
 =?us-ascii?Q?0RGmX5M/lDTq2w1VEQV2QjkuD78D2W2tM6j2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gdKw4IMxi+j55UEYxlJntfMzhjhv0COznAM2FNmfbuJzm9keaaTX5uWjg/3M?=
 =?us-ascii?Q?RHysn/4tb1q3PM2BnhdKZF3nYSmPI5+k1VcNpB52nyuL9lQCVgHXCPK6iwmM?=
 =?us-ascii?Q?cVs2c2qlrnBEqrfgIKSfGLLpUYSgHVPMzvUafMHqAG5KlUhE/8CWgBnhgcpJ?=
 =?us-ascii?Q?Pjk4itm4XQ6m1ZBOj8l02B62kUllBE8kfDurLTZDvPcPKhmz2KiSEhLkKnzK?=
 =?us-ascii?Q?XxMz2F0Rl00AP22K2ECldnMYJsaAwxzYaOx4oVJsKx0UxKnJdaOLdJi8S7qJ?=
 =?us-ascii?Q?NUElUB/8GS7eyZ2T0brtDMKEr3lTMPmxM2N8WnxuRrkVt9aap8P+3XUcnLat?=
 =?us-ascii?Q?jyjidgB7txvqoukYzUyN/chSgnhj8llx6k+7aKr+wrb2W9605Sy7mElWzIb/?=
 =?us-ascii?Q?pYcq7iGWXLLVwUlnKWFz5HfNl2Ya9o2cNDbUNnXk0vn7jt/SAWLCXwDtcsmW?=
 =?us-ascii?Q?7eMkvnaHDcaoLsklhWOrodx+D3KXFyr3SmWPxlhkf3Jmhq9/S2ORliKiWtYO?=
 =?us-ascii?Q?HahMJNJbo70BV3EAohBit4CF308r9puDpvHlfS0rq+x/HHX2GHgrhDNtvmko?=
 =?us-ascii?Q?jw4zO5N6UUcudJWigiPtGgmlUMQ+o2pph9aEFjv5eIafV+pbv+vV9TqInJUT?=
 =?us-ascii?Q?CeSUwjgL2I3KpZm1Rh4SqHsUjvg+zD9PXvXVjek/+Jpd8IxIZZjYKZu7lFRf?=
 =?us-ascii?Q?4EoGRLE6EW7h7Zi4VVLscwSDzeVqE6q9ZEyYV1mMWIwUcO1+TNisTbal8NOg?=
 =?us-ascii?Q?RG/BX5x3PdQoJ5dCz8mJvconxH31K1HSiLf/6d+i326r3kKl2KFJtzUqVFsL?=
 =?us-ascii?Q?S/36zoNo8QuY879Pzqt95YgeHIdQRb0q0pkfn1SVBvJrh84Uzn9os9MAPbRx?=
 =?us-ascii?Q?XVzCZhwPIq3Lqsck8oqCwCfnvwf2Z6ByfXExMg31P8s/NL63JlIDe9CsADjJ?=
 =?us-ascii?Q?8yJ2KfQd/TorzCVSH4PSC4IGf3+b9zMHDYMJ4jqIp+i9L9933C9wKAHfOh3X?=
 =?us-ascii?Q?xHIjTOMFIF37RTr+zHAznHD2Jd4RGLtuBzdYzHiJGicd2Qbyaclajm7wDNNT?=
 =?us-ascii?Q?0cD3iCIV6o+1E01rSsva2KTIydVr178uo2Twczgf+bksXS93tXHZroaTQDYc?=
 =?us-ascii?Q?hkdCoyMnEskcekPEyQvZUehT/FdG/Pfh/OydzDp6ipiEalsmz6deMncnpy1A?=
 =?us-ascii?Q?rqakcWXFGWwZiX8WuVkHJrs7e2pVPBSIxpWVPCddA/oaCRk8C08uhnjxwJoi?=
 =?us-ascii?Q?D8tgyWSQ35kJ/xq+cQurKXWg0Ua5uZeWCvGRVfuPyjXEPDtYkLloSBSUdYXI?=
 =?us-ascii?Q?7wu8yGkjwc28gBtfleDZ1l48N5dTYUUkf4wIncz9DTpt1ca91NFdQ912288M?=
 =?us-ascii?Q?XeE5aISKv/tKJxPlPCb9Pq1602+ocr7BOUvAgg0DDsu25zMyZP0Kn0vM5/0j?=
 =?us-ascii?Q?KGNbd4XC9Z+T+MqkzkW1qrNHrsjKNt+lGO4KUpLNH6uN9UiVrLz2AWss9+ff?=
 =?us-ascii?Q?PhUnnSIa+I7g1B5mrYMJOHe6Va88/Cex4q8LeXgOgxBRgjxcwQONgAVJLyyF?=
 =?us-ascii?Q?NQGPy3KmKNZ/pcAmomVhFv1HBcaHNAfICYZ55QJv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c00c87-cf12-433c-7634-08de27b06ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 21:12:59.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COgSFEVcAuGDwdDimO7mwoxWJR5FXUfDRJGXk82x991lMlsXY0dNmn8jRZxuAI9nZDpO6Wsv/QPrUD5svRwz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com

> Add a new EDAC driver for Intel Diamond Rapids CPUs.

Applied (with a kerneldoc fixup to part 4).

Thanks

-Tony


