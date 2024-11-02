Return-Path: <linux-edac+bounces-2406-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150A9B9D75
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 07:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878491C212E9
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32514601C;
	Sat,  2 Nov 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hH0halQ3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED89130E4A;
	Sat,  2 Nov 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730529048; cv=fail; b=rsOjA/XAUkkPrUpMvYmZuoyZdtraT673zlzzMhpvBiPTNoLDsFlkdTS/0FdBnty4IRwD1B1GM1OqCqE51HljGvICpDmxez5k9w3tzgr0A5pedqrOtSjJ63xGLwc1I43hISb7pjH3cTVAFjIgJq68BtZcjRBApHSuzWIVT2Xyrwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730529048; c=relaxed/simple;
	bh=MXMepXCSX8cqCGLs3/3DvoTkWLkIfRkzcH0J8H5hp0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmVCQl+JpdyLIKZrQuvSdltM4XKnfNZIvHLd/Dep2+GOgHYB195MtyCY3553mwwgrrD3yDYGl6x39tW1kosJwF+Li5O+pidvEd5VShnOjXby0e+PHvSl/BHlCGPSlkzJ0ydVR9dA2/9Fh1fpp1adahbvG2vqvDxcqdyZ5BoGtV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hH0halQ3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730529047; x=1762065047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MXMepXCSX8cqCGLs3/3DvoTkWLkIfRkzcH0J8H5hp0c=;
  b=hH0halQ3N3Le66egeqI1xyTusg1U8CDNv2yth0zkwTYx9hMPH1IFXjbv
   P4igwDVgisSZxeLI7LSPJDWvZyDTIp/hg/kxMX8ttnkQ+tMf4mMXcNyi9
   BkN/wS972dfxh+u54L5p/CQOUB/V4YCPmaXs+Lj1xEwO+OrRJOucWJUIZ
   KG+aJmEl5bR76nmtboP8YnggxlGlG+xYgQs0qD4JkGnwJ0Kc/ZADLc1wY
   hNqzsVagPUAGxDKS4irL9cs11OVzQWE0Ta52pr5nTJH+egRvUbWyHTUFU
   qR4SthlgHfTV61y1oiYDgAc+O1GTV4t1tRcwKW2dYxpKrKLGTRAI5g6Q2
   Q==;
X-CSE-ConnectionGUID: Gpdoy1qySCeYqRp2h5OPlA==
X-CSE-MsgGUID: xfgKbZ1nQcCWjYkyeQivIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="40925870"
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="40925870"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 23:30:47 -0700
X-CSE-ConnectionGUID: 38ASYyaITcecytGba3pDRA==
X-CSE-MsgGUID: 8NJwnysTSC+9Fsv//eg1tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="83279567"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 23:30:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 23:30:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 23:30:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 23:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY4Nn8onSJuiS8qM7Bk4Cx8zQ0By7MSGgrWqYgvZG95yfKrcFeg5Hk1ZHglu0RRvPL1hGerLnIpJtqy7+22xFXPMTj/vYAoHeJ2GvpDOXYW4bu0a9rPaLbzXCuYDAYmAG17AE9Cx2DXih3zd0DL8RZEf3XpbWBG04rtQ0FrzNJQQshK5WNv3qqXhtHgDEDZMORJdbwhYy466cZGTpvk+SH+eTgxKcQsNBfSUgUAIftGQ6VID2//YiP1vpWphKCxDTcK/bE8TOUdtv05J2Mow38g7boatO/6QZjww2vZ5Oj6gy4LcViGdJ84IUYdRexIAZQElcnsvDFQmBXsdvOr6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXMepXCSX8cqCGLs3/3DvoTkWLkIfRkzcH0J8H5hp0c=;
 b=lswqxBA/ok2TLSYkXktXpjQ1Quh5IXilTt508+jyrMCZjHCIxlGicGcgdL4n1lAlpIf8VSNc553VCRcD+ELFebSWTSSi87OxdDxoZkJgWU62u0aty6rtpl3jCIePBsElJCKOI9buA6Xd1smdQV1N9iAmwI6S2J5J0LJX5N4H6jZLrODl9vlHmsqOeu79D34uTkXYw9CK/xi3B7ArmEu/P/kshViFOgBBFkTExhrRWBf0mEZMsD6AXHku8IWl4WUTkxGgmFXNFsidcjbB9whkP+59GssjkE/39U6KoAF4WE9DN2w2mq+R0gN+nSiV341MMOQ5/wL9vQjIhSUyNkz56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Sat, 2 Nov
 2024 06:30:37 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.015; Sat, 2 Nov 2024
 06:30:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Orange Kao <orange@aiven.io>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 0/2] EDAC/igen6: Avoid segmentation fault and add polling
 support
Thread-Topic: [PATCH 0/2] EDAC/igen6: Avoid segmentation fault and add polling
 support
Thread-Index: AQHbLJ6czBGP13h7n0aPlwt+x2ZjLLKjhYLw
Date: Sat, 2 Nov 2024 06:30:37 +0000
Message-ID: <CY8PR11MB713490E8FA1E7BA99204854489572@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241101204211.414664-1-orange@aiven.io>
In-Reply-To: <20241101204211.414664-1-orange@aiven.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB5945:EE_
x-ms-office365-filtering-correlation-id: a3eb2841-1d86-466a-7058-08dcfb07dd41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BdoBgMZaGiyCpfZs6mXE87MGyvzIHYiuWGE6E7TNSVDulyNBVQI7onABdTE5?=
 =?us-ascii?Q?tSW1JxBEyUBrcvfDxmfiEZoPXEWcgvYhdIuPkASCVMcd3mRHOurpTytHEm56?=
 =?us-ascii?Q?AeDAyvtOqVJJMaNYIGex3s322TsoEV23e2Qn9ycf7PUVkFLzVnO1rmuWN4U+?=
 =?us-ascii?Q?Vk37E7NBFvSwIfT2sN8BqDGIhXhqXnltBCt1lnQFZQrjMqDWe3K61LfDSZdj?=
 =?us-ascii?Q?2PhPkKf1/4sAultMCX6XqoXEM0wq5y0GUBZF3YqetCXChd+Ilx4dWK3sW78n?=
 =?us-ascii?Q?/+19gLwZ7t4OY7QYV/k88e1emwyDZCXGqNjhS8nHM80JUr7tJ5LcF5392PlT?=
 =?us-ascii?Q?KLwCQYtJiQLOUfNsrXpLASlJzd9KTLnouen+8dHkrU6JAlWUKG8iNelBvF03?=
 =?us-ascii?Q?dKyhm002DZ7zb/v1ynXbY8/pLEqchZ+SmKW1mOJZdBCMbjmnWF97V3Vls4M5?=
 =?us-ascii?Q?D/HbyrHDY5+/4wWH4ckxNtpKYJ7/JbUNBf7nh7ibiBixbtFxab9VCLnZIgEL?=
 =?us-ascii?Q?gUzU/0GVhyXN9CKnE/QHFvuNKx5cSsUgBttKofBL7aGVFm5YdSVoZ2n2dYDe?=
 =?us-ascii?Q?S1d7goif6tuu2x5629wa2uePlD8osCMONqIwacfJJwiBG8PqisRqpPm3m+Np?=
 =?us-ascii?Q?c8onQzPwEGbd3ymV1XG0BlOcmoBOZ8hXof0hdwgzW3rqb+idRcAuVHklhxYp?=
 =?us-ascii?Q?WVn6cx4/4QGSUAFUhKxO7qXJRMm1V5XkXvfSDq9lA9wNQHURLia6zGEC7wmb?=
 =?us-ascii?Q?gNp76NNacJmFemrRJU8Ba5DJx7lIMLYK2GmmgXlkngxOMVGKIZ4b3g13kTBy?=
 =?us-ascii?Q?FnTFX/gpIawHY6D+G65wFort/tzJFh1V/42dweV9Y48MycMhzTyOCwK7BOLs?=
 =?us-ascii?Q?urYTeAbAA8LpE2dHuTl82SUJhL5yr/n13KJn/mEYg8x4zX9HD4uH0x3ifBIZ?=
 =?us-ascii?Q?Q9EpQz+YUQSP6DTJ/mLnubo547zv3narfdKlR/xFoUF7uqFuK6etjDbWw60d?=
 =?us-ascii?Q?T5o/kRlIaOTFwgIg20A/OTStUGsVUrE11l6qCLuZzl0/k++0SypJqua9Ge3H?=
 =?us-ascii?Q?2UTbgelYnIQ5PLFrDed13tQlWUNuId2nlBEmyqEjoAQqoSqQpsjvEQMH/sZE?=
 =?us-ascii?Q?npvCIt6ssxlJA7WmHcmlpBWyQx8ctKabgcVMdCu5+WsXhbEOpbjv/jdpO3sw?=
 =?us-ascii?Q?q/r9aNxPHjOqLNvOBIU/aJwjmGLfs2VOM/vRU/IjrKiwgvKYe7qUufj5CHki?=
 =?us-ascii?Q?54rE/ELhRmc+Yp4xuIAkbs8hrSnaVnjZ797gp/a0DbV1vF1+YN5ruxFBqnNI?=
 =?us-ascii?Q?iUleSbMwjYHeLZsGR/Jql39LAriEn9lAKM4JcffdtRedIqLklDudm0Q6KJPM?=
 =?us-ascii?Q?Qr84Qfo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8DDGHYMHQhHaWOFySJkO9n7xrbN0JrzDHCyQTTYarrq8kdvzL4S5bpY2Tozm?=
 =?us-ascii?Q?x0/RXtxtNah2r2TVQ9qehL/RPkSFikCPkCL8abVBdm1+B3LIo2fI71ksgE59?=
 =?us-ascii?Q?z1OJ/Sk94KEfeVkL5mFw6HtIIOEblQIHLO4/eHDaOrb4ExOAbfInL+yJ1ubm?=
 =?us-ascii?Q?Lp8pfTWq9LIOujOjjIhkBA8AtcfiHm1u2yWFh2KO/2Q6VZG8sHEPsZXXYCdg?=
 =?us-ascii?Q?RSo1sCZGJeLx0A9kqgc5o54s3YCugEd+9C4o1T0PO1TdCB5LamL5MgJFRF8C?=
 =?us-ascii?Q?BFnYVHK6Fk18BMULj4aZsMjEbu39I8+MuWSsK1vmGBzvvqU2M65yo+6FBs5V?=
 =?us-ascii?Q?naACilL+jh3nkiA86FHOPRj9KoN8jqj2jXcRo5Y+AUkvY6yo6QNhVG1EvqzA?=
 =?us-ascii?Q?TdixHtZ8jSif8oYHmIse3Sd6DOKqCRt+90EY/jTkTT3UxQKchCImyb+2AEU6?=
 =?us-ascii?Q?A6tiEBBBMqDvG4Lt0ucMoCrZViX1/hwjiKFSOvcOKn2Sqfx9uUJKjaoOLgEK?=
 =?us-ascii?Q?7wn2fJ1AytvG4DsRQ35LFUXUfBxfiOHGSVqb4Lt6yG81BRH+xXUGOZVHEpT+?=
 =?us-ascii?Q?H7axkajSFn28GtlLfbJohZUiW3s67RD7/dfs+54HmW4gB0SG5i/jpZR6BGF3?=
 =?us-ascii?Q?rpuYl2h43IRzcuJ48SdMAN/q3eKbtFI/UKzFZQoIKQKGZ4SpMVuCFywPqqRT?=
 =?us-ascii?Q?bgApubaHMvFkLbOBFBQMd2enWxnOAqGoTEmE8OdmLnWdk7JsBtfMpVjn8pog?=
 =?us-ascii?Q?c4Kef9TOIpsAY5vs6/i5pSxSv6QBSxSo3xK2lGhMSWwsJHWI5afbuagQamg7?=
 =?us-ascii?Q?q5C9m2Mw29jH80OMs64RfB0jl+cERKMR3lEzAoPMr1B0779EFb+SAwaGYkDr?=
 =?us-ascii?Q?LBEtkbi68lBHXIDQ69QSGowyYyk1fatHETYHuL1iTAcbrjdkLBxvs0hwtBxB?=
 =?us-ascii?Q?951w5WnfflMr5aThIHd0Jq+qUo9eBfvtMgpQaEaAEBNZI9WA7pgB3G+QJX7o?=
 =?us-ascii?Q?dNqw1rk2fPcHPZtoaBBIvYc8bwA8tsmN+swSAihI/wfCyHQaubEHmjdkahFb?=
 =?us-ascii?Q?flLVOth56Ld4AFzhgm59BucD6PI0FT8FbOGe82aPSYV4znklJ0W2/+ziDODx?=
 =?us-ascii?Q?Ml9cNaxe2z/hVIRtR8XeniXQ4IDpnByiHw4FGvQgezhF4eANM3Fw+DtPGWGE?=
 =?us-ascii?Q?3eb+yKemsookxtQicErNSowhQpLrfClHUEZDbclP8XpwkuwPooKgtAodGPnD?=
 =?us-ascii?Q?j83O/eCH9giEznFfdUMEFBbQQBOL811ge8BgbSzggcwbEOehJr0egBDX2pDT?=
 =?us-ascii?Q?mLYQec4fNcYrQqvgpeEI95OR13CHk4th4N6OMLVHsJUe3wIh7J8GSrbA9lMy?=
 =?us-ascii?Q?MozduCecu7ObIQ0G8bLw3C/UEwCF9mtN9sLCsw805XIC7xrFnyuubxwjgt8w?=
 =?us-ascii?Q?MxjAoDttKgccffsan/4M5JsdCSuL2OKU2i3X8qY8RbPAm/mjdyTnUMKGpuQK?=
 =?us-ascii?Q?jVpk8oWVt+X8rL57Mf4OMtZR5dIa/R+Vn6fku18JfV5pYw2audS/BheKWREq?=
 =?us-ascii?Q?lSoy1RbCIB/YZgmE9TB3QJ+xdu5QbbYKtQm3oYFR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb2841-1d86-466a-7058-08dcfb07dd41
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2024 06:30:37.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAa5sNKWBbz5DksEMCvYGwrD9Hvssa1lQ9uRmj1NMgtiw8IBwuzADYgP9FnUmr+uTMbfCkFTdnq7su1z5ruwNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com

> From: Orange Kao <orange@aiven.io>
> [...]
> Subject: [PATCH 0/2] EDAC/igen6: Avoid segmentation fault and add polling
> support
>=20
> Hello. This is Orange from Aiven Australia. I want to propose two patches=
 to
> fix a bug that affects my machine with Intel N100.

Hi Orange, welcome!=20
Feel free to propose your patches. :-)

> Patch 1: Avoid segmentation fault during rmmod Patch 2: Add polling suppo=
rt
>=20
> The detailed reproduce steps has been documented in kernel bugzilla 21936=
0.
> Summary below
>=20
> I have a PC with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4 in
> igen6_edac.c) with a BIOS/UEFI that allows me to enable IBECC and error
> injection.
>=20
> Interrupt seems not working in Linux, but it seems able to detect the err=
or
> when "modprobe igen6_edac". I am not sure if this is a BIOS bug or not, b=
ut I
> have no access to BIOS source code. So I tried to implement polling, and =
it
> seems to work. My proposal in patch 2.

Good proposal.=20

> Also "rmmod igen6_edac" can trigger segmentation fault. It seems caused b=
y
> double kfree on the same memory address. I tried to fix it in patch 1.

Good finding.=20

> Thanks for considering this. I am new to this area so I could be wrong, a=
nd I
> might need extra help and guidance.

You've already done well in this analysis and in providing patches. :-)
I'll review and add some minor comments to your patches.=20
If they're OK with you, please re-send the patches after=20
resolving the comments.=20

Thank you for your cooperation.

-Qiuxu

