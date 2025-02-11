Return-Path: <linux-edac+bounces-3019-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C311CA30456
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 08:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BFA3A4849
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED391EB192;
	Tue, 11 Feb 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ok2Qd+AB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0001D63F7;
	Tue, 11 Feb 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258443; cv=fail; b=eShcnRVL+7xTMf3Aiz7NJaJPS5xsZOKZ0vCM/oDqCDZMgAA1NUlaCWeKsWJGjZzu/OCKjRcnzlPi5I8YYpGXPXfKMIxD0cZ794d5VL8bPjoVAqVBhBc7X7VbtYzwAibY7A+wywTcX1WsoE+ofKnaiPjdSUyMV1FA3JgQFRKCb88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258443; c=relaxed/simple;
	bh=Lkbm4IjqOC3K29+LBbABb5CDphMeT4V83iv9RJkrW2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IABox9TCMLtd/81S6Up79geqVrJpGqABUncCLv3cGMzSK18Hlm1/duQupPmX94/ixA0WOTpiY7GfEZJ2YG9SCcrmlItrT6cPEW6PoTm99YqokBKUwR+0S5bjuxmGRDI0lQ+PSfad8O/+Ym3OtbJPFlW+5DkLtSU5g0C2DrmRGSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ok2Qd+AB; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739258441; x=1770794441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lkbm4IjqOC3K29+LBbABb5CDphMeT4V83iv9RJkrW2Q=;
  b=Ok2Qd+ABBphOpMjXfFD3xOklHO+wLATot+D7p9Pd9tAghxeCTrolDJP/
   KCrkIZERPjg8bvIISbxivjjuci8iZLTNEfb4TC2pCpTNky5RGw6B37OeT
   lUXDTY4+PPgUkEvG5OtZ1couB/0xgn/bimXVQAQGIZ7oSzE06e2ZlPY3o
   iD6DoeIZEgzEVIhShFMMgoTk8oVzcrBcgDPoUyjj+C5/2H+Yrx7LSFCCQ
   XvFLoK+94N9dtM77QB8c1CcTn0rCrikZ+u3C3JHV4VFL2i+jKebNXSdQF
   yOlDCzWLXClVP7sp4vOTFoXsz5hfHnBQdGKjx27eAHv70oADa8v+idIDn
   g==;
X-CSE-ConnectionGUID: rgcBuMOrQaKEVKblxYrmXA==
X-CSE-MsgGUID: gbyhGHSUQkOgCqnm4Ty4WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39728109"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="39728109"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 23:20:40 -0800
X-CSE-ConnectionGUID: nhEvg1VrQBeWDWPUfWULyw==
X-CSE-MsgGUID: S2dxIYZOQxCDEzCY/YU8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117344720"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 23:20:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 23:20:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 23:20:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 23:20:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1ljGTPl4QO4gUkihavfqMoZNBguJ6ErmJhhpQ/X2uhuvKM6Mi1uOZztwZfVeEgFgQJXKQAclmUNWB/dOjjfVvLmKovdSgyyW/SD8guiA1pLCDTI1O2HsF1fQ9dGmnXupjfifHBbM45/W9mIa/B2KRk1L5JMHdiKY8XO34UB35fJi1T29Kmwlo0g6TI2kdkQSFujip9Hs9XlInYK7ptiJCq2X4BT9PgjdvHLWUUDPvAp3NQDGstzUGA2KHd2krnS5qtJm2WQc2JPTCGh8AJimZh3eS9cE4dEOQcrh0YZOOs3JJrl1ieTBIlc/B4jRwI+Gw2c2K543tK+KHIwUXOGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQQkCFCxb/VTETE2tJYr8MNEHJZBdIANEN5Fx8qu1Jg=;
 b=AX6txvHp9eXpgRIQT2JMXYiT/rWA80dsILQhMlnGhUonszWLDanlnipu/CsFobAONYySDRt3uXjTEidXSVSWxWfQzGT7II8FyKqUjP0isqUAHWgdR2sTL1YpoC090v2XmziR9MFeFP8e09MS8owpV0y/Hq1VvOsBbrpwWh7TIgVGxypXpPgcxni47nTvfH5jkOHyo2HK8y82fshRNxeSWn0M7jQzHX2FFHgy4kEkN4UrSwH3dwXEn0ur4L6y8kks93oyyHRzxXesCt+OUWOSw04xnCQQbPpz3HtUHP8m8G7aAwJ9y7neEdxLu36F5kkQwKuVUa/aVyfgR/Hsr6XoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 07:20:37 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 07:20:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Thread-Topic: [PATCH v2 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Thread-Index: AQHbe9MoKPDVZIqU70maoUZtaUn92LNBsYDg
Date: Tue, 11 Feb 2025 07:20:37 +0000
Message-ID: <CY8PR11MB7134CA4E20537911F5E8B11489FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-4-nik.borisov@suse.com>
In-Reply-To: <20250210154707.114219-4-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ2PR11MB7519:EE_
x-ms-office365-filtering-correlation-id: c06232be-c958-4d45-ebee-08dd4a6c9524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JPdr1r4VwB2gdMwTBGw9NZ0qkbYzgs9Nz+5q25CZIR4/GQqF42Y9Tje1a5Jz?=
 =?us-ascii?Q?mrYEMjOtQXAeli3WfESkMTfr2YPxxM/sjUJvSjqPWlIgn4T/Fw02w6MZd9yr?=
 =?us-ascii?Q?DuQU+o9M8051+5vRXHo8G5VdR63gCyUmZPgJ5t9CtA6KE2XtQXdgp258eH+7?=
 =?us-ascii?Q?WsxLjURBuRU5cHIJBBwUBV6RH+7fj9f1oUiHZMR7+GnK+OXIKhlxu5OyteoL?=
 =?us-ascii?Q?gA/y5/CKS0xpzvgEefZiGthcIncpEUAv9mrfbxDjWRqHLmHnt/yIBYi3WcF1?=
 =?us-ascii?Q?1nTtXSrvcoEdTw3i9bI+PGHMCKEB96LpCdyRKFJQE6LCeK5MnYBN4pLx8azH?=
 =?us-ascii?Q?EXwVehhNz71J08IdjuE6NmXC/ZEZfQkgDCbrxZhiOufpMvV38NB8qzsH973x?=
 =?us-ascii?Q?D6oaHee6eT5OyF3SpCAoHeXod4l44U8J3MQMaHMAho5RCrenJzeNA3usKyED?=
 =?us-ascii?Q?SAiWgJanUM5Df5zlbn+VOF6/kfgjvBqx7232Z6owRApxyb3WPStjKaDoMxNA?=
 =?us-ascii?Q?IdFgeC3lUv+WV9M2YfZ0i6N5xs0zeEXTZdkCZzZxflq1rWmILR9pG+mGoOh4?=
 =?us-ascii?Q?p+Ja6WM7+IKE2tLLuGmDgy4cDJTRBLcUkex+6quqLAOeQdvmBElCXJX/VaPr?=
 =?us-ascii?Q?InDP6UpsC8/BtBFdLrlKIkio7zdq9upV+rZROvjIPbRUcGEuyiHSs+hcak1m?=
 =?us-ascii?Q?+TLJ1kvyyWFhfK7PyBK2KyrIuuFYlk2HCoZCVfuDkk74a1icaG5a28/OO/0B?=
 =?us-ascii?Q?+p0jSavsNUxF3aAgHASQdBqO758fapzxKKYqpFXqmY/U9qa/ezBlIK7hEYbF?=
 =?us-ascii?Q?yCor0eqr9Z5GvRXCUImX8WtpadND+TMwNiZi36fweNVIQ5UqYz1qvfcnbODl?=
 =?us-ascii?Q?Fb3xJ6f+CSlb2ouAAOoWqL76JysLovMuwkFAw2Y2zTO68EBig3RqigDf6SWf?=
 =?us-ascii?Q?tPBnIOy6M3ZPOxMi3l2ttOIosn+cOGaJPFPg3sp27fxC9z0C091Hw2JU/IPT?=
 =?us-ascii?Q?wbXYW0SSxpZQXfqLSaHUz/IIPnSr8YK0GCeDyYNbKyWhSZNv50Jl+BNbDQDo?=
 =?us-ascii?Q?Q94nRXRhkJGLRDGuMN1dYq+k8tHU2df6pEfof8t/5KNceoOwj9QyYnP9dWNS?=
 =?us-ascii?Q?5Tz34KnVAmZ/YhXhjlE5H9j6m7GnjZmAyIZ2UCrtGG3ZJVtAcXa63caDz51z?=
 =?us-ascii?Q?ROi0YbfodHfRbqPH+7gNeMlM4Q4PVLJyglQT+NHY1zv212Wj1IQTRG80MMk2?=
 =?us-ascii?Q?HqfpgwjVWpHVwyjxsV8Xebc4JDN9BgZiZtFCvv4rMSn8/dgI+rL0tq24GlM7?=
 =?us-ascii?Q?cF1YleIqNThNatuOs4xB9vwy2zFY+tmAM/6wH6tRO+o8+YPE6ApQWtV0JD2D?=
 =?us-ascii?Q?yeoukygFtokVi7qqevL8otuxVoGNdIOZYe+mdrb1GE+/rgVXO2G1fT1+pqv2?=
 =?us-ascii?Q?vVXwZCpbUI1xtuKFyyAKgkxBqUVJzad6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AbsymiLwrQFaDZWAbcXL1WfzaThwI/USEWVoHS2fpcu4txMePe8t2IjK4akX?=
 =?us-ascii?Q?wveskhyOC8YMQM0LZL+xe0N3AooIC/o8Y040E7E9zJWvmadNAKwuhNhByl/u?=
 =?us-ascii?Q?q3pzLZfmj6HPAdXSl7AwKnWL+rLKOt+inEsVlT7juMnIfH8+7tiqT0wNair7?=
 =?us-ascii?Q?Vad0naFFaqGl9DJQFABbn+e4DxkMKZJcHjy76yBGbwEnpHeeRFQwZXmGIUN9?=
 =?us-ascii?Q?Mjrp9V0j3p7P8+9wax6vp1gTyenYWBH6eORCvnfAvQCqo2D/GGL6aFyHcirI?=
 =?us-ascii?Q?tEgA+DHS7H2tJPv6GT7JYmhwvaUyvuwv3tkZVHukNwBXHHma67b2ropfV/65?=
 =?us-ascii?Q?NG6yxSr5mK/z5jPhqPAnY+kjyzC0BMbpWELqtu1VCNlYO3+D79lvr0kDW5r9?=
 =?us-ascii?Q?8wPS6PB1RoyhtH1L0XFgxUnzBDkoz2PuCZIGzHQVQ46m+Ily+z7LrpyW/KHK?=
 =?us-ascii?Q?enykacLGe9jEJjOXa4HwJ3XFPXjX+th8UBVYwRix3im4kMEyv043aW4j/meE?=
 =?us-ascii?Q?QycjAQB4s/3XCKhaPpyx/3+jbttKKl0TtiH2uZ4AUbD6P8UugP/gOEOUojvA?=
 =?us-ascii?Q?jruvUwLrnBiOP4YCOfQJ9fpsKydfAF8/0bsgPymjoHiW/VBhzDpGyOHI0Kxb?=
 =?us-ascii?Q?NXEQVJIPTxVMwZ8/BbS7Y1srVIM/SHX2Ng+FyAyCciyl46ugzKraMOJicnpT?=
 =?us-ascii?Q?SmzVZtVEYEXR/+UXR2tZ/N3kMLMsOmlgwUTOul/hE9GZWgYTYKZtWzxcNfbC?=
 =?us-ascii?Q?55s/5Uj7es5NHawm0ZGfvUKpdV8EyaZoPUGREZjv98Bb3H0qQdFy4IcuRHAC?=
 =?us-ascii?Q?pxLHxQkFrjla35Av5O1rbm8fKWx79X7moRMypstjXRFUGI9CLgKbVI8BYJJ9?=
 =?us-ascii?Q?1bx8t03cCIAtwYzCO3F/CzMatCApfpJ2jsOBNerdtPV4cMSiO35Ytr3220/i?=
 =?us-ascii?Q?1cYZ9t/z3lxCrDcyCm4a62JXOkpFLrJKitmQbCJyzlu0t9qR4X+Cf5QnKBCk?=
 =?us-ascii?Q?NrcNaCzJq5X91BQ4xfOCGzk0uAiTBq8W2Z/ADOhDWBUAoDpYek37KU48QWI3?=
 =?us-ascii?Q?8G250N6HATnVX0xS12pfikzUEnh6fs77TnJGUlVx0F6TNxFw7vNbhJ0ODTGw?=
 =?us-ascii?Q?ffYx4jL6MBNaOrPI/vsoZ/UnLEd9q3xwrsbPufQ9P3bd0Iw7GaJ8GHEBH0w4?=
 =?us-ascii?Q?PgIIibQPJ/vOKMJXnWEsb1/Z2jXQ8Y0sYClHGu+0xKB/9z1SU0iqqmxdBzBQ?=
 =?us-ascii?Q?oOBTCXqW45+IxQq3yqXTZ5hYtI2AtKVM044N7yZBmDBgpcElPzdt7+Llc/Sa?=
 =?us-ascii?Q?B3IYbOkz9CMm3V4YcuNtxSMSqDRxAhsLiIrVYrIC104HkI7qyZeWZHPdostd?=
 =?us-ascii?Q?2UQJEltObg4pOZJWUme9WQ/ECnSPAcm0wRBOtLQ0r2ovDB0FOHC8eFD1bVUm?=
 =?us-ascii?Q?v7OshKY96XAaiqOFU4JW53d/2I4AebEdLSo/Ubf5kVRoBYcYX6Q25dl3jBMi?=
 =?us-ascii?Q?BalRqiuYowxOV2zZwkQKXbp+0Umfnc58kAmQ4RfpgQ+xuclgSaK6DEIqUHAL?=
 =?us-ascii?Q?dLiqoMlHve1IaZFA/esG1mYCLsCOJmLd6rGfAA4R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c06232be-c958-4d45-ebee-08dd4a6c9524
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 07:20:37.5493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: og1hYUlOY8jLIvpd+UGsbzVybXsWlYwkxES1rVDN2UpxNAvGFLgeOwzHTnJ7QdEdDfoXxrbR/rhCgJ3unF6tiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com

> From: Nikolay Borisov <nik.borisov@suse.com>
> [...]
> Subject: [PATCH v2 3/3] x86/mce: Make mce_notify_irq() depend on
> CONFIG_X86_MCELOG_LEGACY
>=20
> mce_notify_irq() really depends on the legacy mcelog being enabled as
> otherwise mce_work_trigger() will never schedule the trigger work as
> mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.
>=20
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index d55b1903fde6..8b8553e144ce 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -591,11 +591,13 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
>   */
>  static int mce_notify_irq(void)
>  {
> +#ifdef CONFIG_X86_MCELOG_LEGACY
> +
>  	if (test_and_clear_bit(0, &mce_need_notify)) {
>  		mce_work_trigger();
>  		return 1;
>  	}
> -
> +#endif
>  	return 0;
>  }

The empty stub function below can also be removed from the file: arch/x86/k=
ernel/cpu/mce/internal.h

         static inline void mce_work_trigger(void)       { }

