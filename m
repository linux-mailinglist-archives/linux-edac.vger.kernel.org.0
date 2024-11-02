Return-Path: <linux-edac+bounces-2407-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D09B9DCA
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 08:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B91F2157F
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECDD14B965;
	Sat,  2 Nov 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdI04/hO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3D12FF69;
	Sat,  2 Nov 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730533517; cv=fail; b=HYSg/aX8JR9Ik8JVjgyPez0nWIOFzBJJ3GFUJi8EqvHK/jma3AujZaRe3XAVQIbUqTScuaITw2O4JivuHKK7k4mdmCZeEw69A/QzVTjWqZLYDTvsNRWDEd2Nro2F9oH/OUSFKrQkrSNrmV5/gp0srogRht2omv0s4cm4eOIkiew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730533517; c=relaxed/simple;
	bh=m4ed0xWAUiSFfAFSNDpfvadk8xuQG1sCDblYIWfxDXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VoM480ANdSxvAJ++QUJ5AF71uAjSikCSeWbd/ah7Y8M9kShhJF0nzijPy5Wo7vMrucEpUKauKK21qVJa7c5GtzqT/xyWWJ9PnHNfippS5Iv1z0BPzLvmYrrortpIn/KrLflB7m56q1P2Zp1NdzlNHY6SpjpvqIp2yKSDmcU3QD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdI04/hO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730533515; x=1762069515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4ed0xWAUiSFfAFSNDpfvadk8xuQG1sCDblYIWfxDXA=;
  b=ZdI04/hO5zTZY0aFc61fxhymE+2MjUlXJ0HytAJf4eq5wNFDDArtt+Qt
   Dp6OoJMdr5CHYw+vsvsUnQRVTVkA5JOR79fmeyPvCi5KlpA4pDmo1r5Cr
   2mEcxxCJMlnoRnh0jc1bURyniUUcCnUty7EbDGB8bk+xcWxYzJwrYAspE
   sfF4k5OyZtze9Cl83g2as1yTFOWBzZkOq+N35CnGderKEobml0SryK4OH
   /8rTpovtKlrP1uLHIs4QtsVxJs6lm26j0lo1qQqa9CfCrOdjB2SIytPhK
   3TmREZg/eIiel4GEQPiGia5RO/Bc3Unw9/wAAxQfjHyFQDZXfH8zogI/1
   Q==;
X-CSE-ConnectionGUID: YLsi42pWRZeiqGIJjmuBRg==
X-CSE-MsgGUID: sbdgrYIcSai7Q0CivzuSfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30476916"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30476916"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 00:45:15 -0700
X-CSE-ConnectionGUID: 0FUi1f8RSuC18A5jhrwDeg==
X-CSE-MsgGUID: 4e9gLYakQ6i2LhV4LsKT6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87936225"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 00:45:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 00:45:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 00:45:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 00:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLM0QTVtHuJr9jYgWL16HRJada+lJF9+ExZjPikj2hSREmKpIVrwh4OHhod+cJ0ja3eF6DbTnqa/qFRLpzUnLzliwnUh4o+FNLoTCr663n9a+7CZXK1NrXqqwoX1/ll2p7JfpTI3uHS+VpKJL3v6OaLpCDYwRe/iNfb6rEfBHtpmiiGPbS3+hH7I3Gn26kfkoTAfxGNkIskzTZyBi6UZpchw0J0Evj2z7jI7EXyc3iTEc8P72R7zztij1GyAd2bax8OObGLkw+nB1MN0YIhGH1oaE80GL4Sg65Fh0MyyGNgHd/LN+lMvPDGWGNTzcKqTjfFIL3aKDL+O4EShEwRxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzsXmELCS/zU6s/Y+p+Av/YbvuKHczhN8IX7/a/M5Ec=;
 b=STNfG67aVfmaRUhY7xtwcnIQvtnWOOumGbf9ua8CXYtXhCtzsiGi1QkON0NALKZm2z7+WUuv/Fyjoi9IDhV9mwdnxi+TzUcTp4Ju8sWl3MKpHezTFMz/A+83fgUgsxMUBi6lOlLpL+4USYo1SnRWewMM4+41vgw6z2WTpTlnOcFEaArhdrNi8d7Cz8AZeH9P1MK8mmkMP8KG8kGjvZBfCYwXel2RSjRKC1ZRSszB0JJdFNVwvFQBSmDMgEeE20L3aFq+20wP2PUntwcCidUeLjC6kUsiS2wTM/ugfqPYB2aIasHjrDXZ9bW1SvggzN+7zTz1+KGip32oGi69bvQRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Sat, 2 Nov
 2024 07:45:06 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.015; Sat, 2 Nov 2024
 07:45:06 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Orange Kao <orange@aiven.io>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 1/2] EDAC/igen6: Avoid segmentation fault when rmmod
Thread-Topic: [PATCH 1/2] EDAC/igen6: Avoid segmentation fault when rmmod
Thread-Index: AQHbLJ6kkDm+QeVZgE+pYKyCyEpiJrKjlFPw
Date: Sat, 2 Nov 2024 07:45:06 +0000
Message-ID: <CY8PR11MB7134B277CF143FB0C5F3002A89572@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241101204211.414664-1-orange@aiven.io>
 <20241101204211.414664-2-orange@aiven.io>
In-Reply-To: <20241101204211.414664-2-orange@aiven.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY5PR11MB6487:EE_
x-ms-office365-filtering-correlation-id: b6cd4b0f-e9bd-41e4-90ba-08dcfb1244f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AMOJp/+pFxCPQ7/+2SV/V7xOxC2PXGWPmUzYu0IyG438NTheeJjrTTBmUnKK?=
 =?us-ascii?Q?sYPznoeszv8KP0aDqorwdFhKovF1dIBNz6VTzQHF8FGutotWCbFAXukA0r+S?=
 =?us-ascii?Q?LV7kneDGu4xtxH6PUq9tx57S9y6wuGjl/VHfyGBEoBXvj4Ly3FANJ7aQY6H4?=
 =?us-ascii?Q?lUod3JVVXp0mmlU/2i2hPU9Y/tAs1/Wo6Q0eAAjQC7s81BUZ57/LnIaP8BqS?=
 =?us-ascii?Q?pKS4C2TTAzDAoMKRbcCcTEHSNfTSmFRa2Ck+mSmDB02NbgHy+/KEF3NXu0pM?=
 =?us-ascii?Q?rZwBRrYtWuPfjoqv9ri1dNPXRVdieWcrr2ey9I3N8jDGVDD6FpYO3Ra1qD+U?=
 =?us-ascii?Q?QiGNAK7nc9bxvLXRMrYfG8pmdR2okbWxp5EC7vSJu9c/dJhlF6JYX8uR0C66?=
 =?us-ascii?Q?4NxwqDpihl8XpeSCn7UWWf/7AIHMBfsNtLfrE2vFBNj18FzQg/tFwPzWlVu0?=
 =?us-ascii?Q?30IHfFio2iCgS2XMJ9fnpvj+rERCOkzxHfARkqyua6OIxhHJCOKJ/W2MoB8f?=
 =?us-ascii?Q?cLbQgFsUxB1zeguMJtOoRJk7m1iHVYKIuNqAMv2aJonzvIsetx7KmanURLmj?=
 =?us-ascii?Q?3MVmBQ+3paCrKYSvdTqOXrAtZMrOoExwMwrcB/Y6hLEyAkRo8NqYsDeGgab8?=
 =?us-ascii?Q?j3HlCyB7F4BBUbumLOVjSxLZ+PnBHun6/APSTkR0+y5xeOYzF90zAtcNooIh?=
 =?us-ascii?Q?r4cFgUCDJNEdOWy5F9KuMm9UY4yi8P52KUrQx8f2sDDroO3I2LSiFg9M92Fj?=
 =?us-ascii?Q?5X2wN8PWsI0feALLh0vMs5cqOSWzEKhd6LDskLvn5B324Rq4Od7WyIR3mdNc?=
 =?us-ascii?Q?sYA4luPdr9b8o9vfqG7YFXKYobobcPvOWSRO9N7wz+SgA01uHRmt5k/Fm874?=
 =?us-ascii?Q?f2XjMiUfDmyz2Ny4Z9uKQLNoI2aDKAxTzGkIfLiS69GTzXrxh4LEpZ50o5dg?=
 =?us-ascii?Q?SztgWmm9dQDJETih4MGyg+RcPmOtDluMYwdkNyXGTRF3zcAHIk1Ib5npplw8?=
 =?us-ascii?Q?88WaExliJD0/q4ObnRopiQyxBTDmVlkF7E3tFVMksK+UJFVWiWTPC5eo4Ck2?=
 =?us-ascii?Q?vZJFy6WeXYd6qDe3aYsK8OM04oHynftzrl9qZojV54DQ+hCUzBxLpsQA2LCZ?=
 =?us-ascii?Q?ccJn2qlmdCdJ2L5LrOGb4ortona4zDouXGzL6RWHLPYrFaYfE+8X/l0FvsJ9?=
 =?us-ascii?Q?i67boTfh133WQMsY+MRErXjDvJfMid+UaWtqQ94v/TXoPLqA7fUWL5a/9d2C?=
 =?us-ascii?Q?ndZLtX922/mu6lu45ovM8xi17/y4Px77B0nnQr5nmnv2XfAc5wmG7YOxI4Rz?=
 =?us-ascii?Q?LhZuBrYLr0DTe3YLVOTIodyKQb9vKwg2KomlyLKSUs1c00dCFVyi7JfRRs1B?=
 =?us-ascii?Q?RFsl0HKO+yc4FrM1nKZs1JqyGdqz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yl1nrH8U1KvdnjnUmusDFRTGbqb6oVRoXOLefxF86uuI2X5xuDH81s3Zs81V?=
 =?us-ascii?Q?GfZuAfLHOxEorTxfa7NUaoxPB7iI6SPLJo18KlV3L6AWI8JJpO9V0fsrMRNO?=
 =?us-ascii?Q?PBk+g+ssBOm3KRIZOAKj217GBITzofGLOpBIrOYswsmsK+Ptn+58DXF9USC7?=
 =?us-ascii?Q?rRwggCYrtgI81onsNL1ZJaaiDdI0Zx1fEyAeqq53CXZhAxsfdV/KEWYmo6D2?=
 =?us-ascii?Q?UQramqrrydKnb2M7ADMeKugzAav1tVXCZXtG6hmkID6VEwfrSk5lMPr2Zl+Y?=
 =?us-ascii?Q?q7k9pdq1CjbJYk3dK3FmG4VJH2Xj55ZfiMTRzy0e6TETUrqn7IqiY8v/3XYj?=
 =?us-ascii?Q?nSR4DC6UFtKChMxI2kYw361SfGScL8nRX4WRt+QEZZHbMgw2AGw+gRpEO7VB?=
 =?us-ascii?Q?BqNJKHZ7e3WKsy+qzL+f0W/qvSR6lGCsajPtQw02QPmdBXesI6glKEaYApcJ?=
 =?us-ascii?Q?3Tn6+sKPb4AfxW6hbCvekp0YeXIzsBoJDtvLqnEzIeZT58r2SqxVkUl3yRRb?=
 =?us-ascii?Q?Nt93A+jh1DnuDfXSnlBx0/MogIJWL/pJigt0TJ89XUOEoxb3Mbbdssn4Xo8S?=
 =?us-ascii?Q?Dq+9CVPySLyezr+zUzelaSmmcVksOZkTWbuLlQogE3kkZnVl7Wq5hD0ZqzJE?=
 =?us-ascii?Q?pN4riPzkl0NraaYDpMWj9y49FDWhMk/muUVuxq/lyKp8QquGOekodaFqgG5R?=
 =?us-ascii?Q?h3x6DJsRFCDMye7OJHPPXaFLKOM6/3v7b3YXXUXhI4Ml6IKf69MS53GUFNCW?=
 =?us-ascii?Q?PCgfBZhMCzIlDh/Jlx/oRw0iwQe6G11BN8gn7hZNlu2XcPoK6TTb/7Z9SRcF?=
 =?us-ascii?Q?XpSCUPL9rob3EAbG9s/fMRAlNDCDbyQABRqJOBFUxBsxbJkW8ZRQ5Df6sYoE?=
 =?us-ascii?Q?sU55TjhY7jks5Noki/n9LDSuy+B8O4gQa2kdaENoT6PNAeO5Qz5erds9EMq+?=
 =?us-ascii?Q?hLy42aSYM1NoJGM68e1R2lLGScVxrvurWNJekLXeSY7UXeTtsQCZsd0mCjC3?=
 =?us-ascii?Q?8DNCQ9Ur8remvhf5q8zwNtmVIx6GfzN3ayAjY92BY6XmCUz44HYFAKDPGToG?=
 =?us-ascii?Q?ODeJr/qfqUlhHaX7lRyA8fRDMFP95kkscGeWvKgf9Q00eZx5ZgczAeh2jhpO?=
 =?us-ascii?Q?JdYHjCw4L4SQ2wXFgVVEfWYYjqMWHvrQUwdTH1CNo2DSVaX6YGumX4QrIPvc?=
 =?us-ascii?Q?Hp4AMah8hX2YpxZbuWtNSUSxKQpVk0GevXlz542phHJbY4n6iVh41m+Z2amM?=
 =?us-ascii?Q?KQ3RzVh8QAQVl9LBQGHbQUME9P3NQO5Es+D5XF3IbIGCHC3+G89cqW5bIABI?=
 =?us-ascii?Q?5huLu8wYq6dJvb3/RJIBJPETWxNdPpaIWmzvvxBmKC7t78zqEZVo/LoIY/P6?=
 =?us-ascii?Q?jfRAL9l4V5bBMyRhj6QQ1ibm3TXTOl9Z8LSQ72v37g50ZaEj2j6bPLISyYcO?=
 =?us-ascii?Q?xOV/oMzPsNgXZahlONvHSDulCpNY0bOFKF2RuTAWzwKiOhC9SHXtK6ECwrYL?=
 =?us-ascii?Q?C0oBh2SbR9Ud7rvbHOokwQCpoKLGu9F8e06/V/CMuSq54QwlzjAtWEOvfTq6?=
 =?us-ascii?Q?CsXOxchHdmI1OzNuhyEFNxegXfF69alTLrR/oe65?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cd4b0f-e9bd-41e4-90ba-08dcfb1244f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2024 07:45:06.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5wn3IpG4pk+zwrZvLGTK0MK//BI1CI2CKB+kyMt2KyqZjj8aLFWlYuOYfUVsR54gtFODCCt0hZU0sPp3Xy6NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com

> From: Orange Kao <orange@aiven.io>
> [...]
> Subject: [PATCH 1/2] EDAC/igen6: Avoid segmentation fault when rmmod

This is a bug. Let's fix it. Suggested subject as fellow:

    EDAC/igen6: Fix segmentation fault when rmmod

> The segmentation fault happens because
> During modprobe:
> 1. In igen6_probe(), igen6_pvt will be allocated with kzalloc() 2. In
> igen6_register_mci(), mci->pvt_info will point to
>    &igen6_pvt->imc[mc]
>=20
> During rmmod:
> 1. In mci_release() in edac_mc.c, it will kfree(mci->pvt_info) 2. In
> igen6_remove(), it will kfree(igen6_pvt);
>=20
> And that caused double kfree on the same memory address.=20
> My proposal is to set
> mci->pvt_info to NULL to avoid double-kfree.

Please change the last sentence to:

  Fix this issue by setting mci->pvt_info to NULL to avoid the double kfree=
.

And append the following tags here:

  Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs u=
sing IBECC")
  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219360
  Signed-off-by: Orange Kao <orange@aiven.io>

Thanks!
-Qiuxu

