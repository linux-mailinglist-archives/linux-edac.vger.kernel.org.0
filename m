Return-Path: <linux-edac+bounces-3707-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28466A9B2D3
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278B7188574F
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053031C8616;
	Thu, 24 Apr 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0cbZ142"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1F2701CD;
	Thu, 24 Apr 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509645; cv=fail; b=FiXVZVEOVfEojqbs8E+xJ3vSFTR2+QWRCdDmZl2JQ5k0IykZyC6aeLE4kknLtkdJI9NkmokYfr97qH6exBlRlNbdLx0xQyPcm8Q7xeNwFCUmXVRB/jLu9JNMq8Bx0+CI+4gS0rHhqen4k9EAWQED6RWpnBXdOq5VGA3kq0WHySs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509645; c=relaxed/simple;
	bh=UyxVGtp5XNCDz0yjowR+5OTiGDJwJd/4ELVKqWWWLbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCT+QFrEx5geWGCcpJbnYkmDTgywrEefsA7jP/bEEzzD/XMYJeWdwvTWIK9rLg7i9CQAVV0tMVYi9/7vqX8lClxP33UBp3boJu8vXi2ruTKsZYWObKOS+jVz3NVxuVNi00UtRN40Pb8efnM8b06E/XQQAWuqpEjyQYgLblHUYI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0cbZ142; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509645; x=1777045645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UyxVGtp5XNCDz0yjowR+5OTiGDJwJd/4ELVKqWWWLbU=;
  b=U0cbZ142pj9UvizVqUlJaMeocmc6s1exhBrcm9r+jh5S/hUFgvdje/DA
   ALgyAix/pjVHVN2B8W8dpv6UEhh24tEYVx0rc9uGAYUxtx8xHx59CrYp3
   D1dBi2SQaUA3Gss0Z89tBsSYI42gYkesUbBhV0MwKTsjn+YdjJsvzvFxc
   gDiJutROSM2k6EcukQJQ9fh4vjqlqRHplPbWE/j24fUeQqelh7S0JB912
   c2TBJ3+E+MjWxIDKdCZGtZoowhKXtdcLJyXZdVb8cQep0D7Nxloph1+bL
   MToy6dV+JVLTTAA5DcqXmlVi8nPLl06ASHAAcMk9tB9hvYtPG5NuoeSMi
   w==;
X-CSE-ConnectionGUID: tDrmg1BZRj6aknzSZOgVfg==
X-CSE-MsgGUID: P8DAqDHpRNWUqW3JHMkO0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47027289"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47027289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:47:24 -0700
X-CSE-ConnectionGUID: O7rHaWLxTDeGJwQGLnluIA==
X-CSE-MsgGUID: h1FLD8N2TL+2tL36v5/Huw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132567960"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:47:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:47:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:47:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:47:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMNZSPj15wxxpnp1kgSZWdehGf1sMLl26tWOvuxqmRh3aitmtP0NnwSQOQqnRGUsOgeBBPEEyRo5Ec9damlgYGu5xFpEJzHEvO/MQ56pYT1e9mCTfchO1WbHlRLAThWPxoW1lUGpbF1biJjNeJsaXtrR82PiZ856ni3SWcTMf0bB1/HxwBvSDvqyRP+K3YaqwHl1Vk/2xgZTQnsHFizNKn9Nl3yipZIyxaaEB21eichDf+S029msKzi5vTH6ODrZfqnfXDZ4x9iGJ0Sq+fcpPNvSCjCdS4jGWjaUaR1y0kwrMfIJcarRdgnIJubenmk0JD/X+pU5/g94n44oDP5ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMsBn4eylv4dDRmYq/TQ1DVVP1r9ML0YcpOCSJIh8Mo=;
 b=flPS/CoKR8FB2M1vxWdYUu1q1zA9eDEpujih2Qem85b0wieY9RfiKYe4RBHCmg1xmBZNk4O2VU7GSCeG54GjYmK98tblU3beo6kEmoVMhvoOwRPxHrCiNjZNXK0WdStel2gWCwi4/oJKvNWMzm3lHJcmMjirDltqeT1xntQKE+soc24vbsZlGHkf8EQBrp41rfH2qfgV7XwZLAKp+8LEp9Cd7gltGD5oQ5zcHu+SLbCzTBzBDE/feHtVC62w+h1T51A89o68SoQsQFZophpCMb9jw8i+BS4ocRas9eG8S+rm0k761sz9VAs6Id2kaswEQyix5L3HM/0ICVJIwGkG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5058.namprd11.prod.outlook.com (2603:10b6:303:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Thu, 24 Apr
 2025 15:46:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 15:46:47 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/i10nm: Fix the bitwise operation between
 variables of different sizes
Thread-Topic: [PATCH 1/1] EDAC/i10nm: Fix the bitwise operation between
 variables of different sizes
Thread-Index: AQHbtPEWdE6vviG6SU+Q0g2xMfl6krOy9gqQ
Date: Thu, 24 Apr 2025 15:46:47 +0000
Message-ID: <SJ1PR11MB608326A2754787068FAF7E89FC852@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250424081454.2952632-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250424081454.2952632-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5058:EE_
x-ms-office365-filtering-correlation-id: bd25211e-3fb5-40e8-05c1-08dd83473906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vQtXJSQymZ4vji/G+oEq9EMlJfCEHmKuccwORm8GX/6J3LFn9VxlRCF9rbtx?=
 =?us-ascii?Q?/ngHW2DuJWB7VixwXfsgqtPOJVXpXmO4ZQZGAkc6VYCrgmpGKhPeJ3rJTFez?=
 =?us-ascii?Q?Qam5IE3Pj//ETvmRU0Ui1yashIzCFTTr9dyCAl6u6fYUhYneH7qt48EQ4CoO?=
 =?us-ascii?Q?ooTvbQ65PneNWNqV8AQPhyT608n+pCWjcH1GclNEuK1dc/Xcq8+YTUl+GCfU?=
 =?us-ascii?Q?yGSKkVxfGKbq+1y7P3+LusBf6T8rGPWaLOoC+rWQnAehHPMKKS5WLuffGF00?=
 =?us-ascii?Q?dzuFmNipAUSUPCqtFQnzes0OJFjv1bhrwBxZTiI/pC4W+tiOfS5VTepR0kZ5?=
 =?us-ascii?Q?qFJykNT5D6Nkl5oEMDYa9V8WfJ1Tp5hrxjAeoeJPAaGKeNi4bt2y1Bmj6JUd?=
 =?us-ascii?Q?zpgDDd3odDMXPDD8OgeZRcvobZfcwxqzniQw6DVmboZWsZ/zRVx9zT/xsnKm?=
 =?us-ascii?Q?ij7p4e2eE4F/HnsKQCF8e4RYErFRO64/DSZLS2DbN56px5XfxAUfh4ThddqJ?=
 =?us-ascii?Q?xmVVm7BHkneQelwC7A2HluqExceB5oo5ZDAtYoMkoVfZ13HPRQC8P/qun/JI?=
 =?us-ascii?Q?Kzb+xpcoyLH8uOl0BnNvlx5QLqGtHoI7ilLKmQp1wRrmf+4sCE9c6l8KLyZu?=
 =?us-ascii?Q?NvuGMbCb3JIIuEa0SQpZQxEBxVehKZpx9RwhpkhNhgGbZh+2PHH7Z2PDqwgY?=
 =?us-ascii?Q?Y6jUcHN+r71runZBn9gHPKD2G9HDv2glHzw64NzLy+uETVvnD6LvRU6Uqj06?=
 =?us-ascii?Q?Spls02UbbVsz6EAr5In3v1Um+fzmPzXxf/kVai/qsu14S9OSIy0qS+x9R5Ot?=
 =?us-ascii?Q?224PdgmLg3zKQl+7KumTvG1GDaik/pTpCid18iOeg7vBtFMe771jtj+Ry0dV?=
 =?us-ascii?Q?IEcHq8oN7HjqD0zEGX2WUsZT3qa4vmbuN7ysLWbkHN3pYgs1Tk2dT4xOcYtf?=
 =?us-ascii?Q?98csOTBcGHqAzL0PL1d0WAJGfWDCBT+zX7CJmS2Iq0meB+go3DEROpUVyyPj?=
 =?us-ascii?Q?xu/QP5UtcY+5p5Qi/eruFcMoCQfcvWimEqwUSPAQ8F1Rb+Du7RdL8hM1skVk?=
 =?us-ascii?Q?lz+3iu+kowf/x+XdidJdZ9LMW1OBmyPU0s8VyyQK5YRrF17/A/sREDLwn44+?=
 =?us-ascii?Q?W9UrHo4jY7ZRTGcZKqv5nl4V6wYDTxY9kAuI5Qk4XDHFZ7SCu8EUDEmm3CvK?=
 =?us-ascii?Q?XtDLc5NcME8nmr7BF9z64W05YGpbQ0gkrLEtKNlMLucw0eGg6HHQTYialp6W?=
 =?us-ascii?Q?+B8AbziuTqXMnWnGh88kRhCAsDRIdSWSVjpQbtcJjyXK0FzUwD42banVd5s8?=
 =?us-ascii?Q?nDQjfP8zdqTHtWXHISko7p6D2Parb1COjrSqV8jNYcPecNFC/SBpfvJXREXw?=
 =?us-ascii?Q?TGxBy4PX7HCz/2WNpA/+MpaV5vVRQVjdNigzK6GV78vY2Qaa9mfqf5fKTmNw?=
 =?us-ascii?Q?HPyxA3kbXV3owieQ0AvllFnjp/x4wwtJO1hGnwHQ4fT/qM4J+JAhe7x7Urik?=
 =?us-ascii?Q?Xs/W1oDFgDXTEKU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rO65hEvf6F4y0PS6iLyDiidtttSlHcXSu9UZe7lFUz8P2S5sdKPJ3tl8VnAN?=
 =?us-ascii?Q?fHNws8zj8jvA6OXgEqnt4goVHXoeGUt8G9LUHl9KFUG/UBfnp8u3yNHnrf8V?=
 =?us-ascii?Q?z2dYADihNhYi3KoOpWFbtbAieNZ+2oGEgj4n9u94ICl4DnF6vnOjda/+LN9V?=
 =?us-ascii?Q?4j57HEDp67OjjNwJrCobUZ4fHHsqOV8zbmXYyt2NfqMDsDaITK5RjteFdewD?=
 =?us-ascii?Q?nVWVf4T9dykj19smXU1fg+COBCYujQXbBdCTTif/ktgBoO/914Cjz7dSFohz?=
 =?us-ascii?Q?CjP2P+ZrBEvX+TrJk9mW2xbRSSnxeKABHwUioCEh7AkbwZFPJreyZ+V6ivMW?=
 =?us-ascii?Q?jgQ4yEVu4oKc3c/aqUOaKgN5fW/pLe99hujKAzfp4CcLgf0sADZ6fQXZpH6i?=
 =?us-ascii?Q?GblNuOchDr+p/lgXI7kn7J9aL2YKeTeclQcX9byKgIiHfmephQSHV+LHcJBb?=
 =?us-ascii?Q?FYFb0DvckoeAZ1SC08/hhUOwGRuki1lGRPHOGpNA13Qhcu7T6UslCsLY6aju?=
 =?us-ascii?Q?hZvyWNXX6hj0/NXIb+vYXOBf8jQAkjOkbLshiwwE81IUOINNqFJ2O+L5reK/?=
 =?us-ascii?Q?VmIVrDwKG1fpWydeVIqOuAXC6GBg7GbuSZdyHqcnGvky6SAUk3fFTHD47G/V?=
 =?us-ascii?Q?p9//Xkit7/mHHLkJdecMyFMIJp7eTL6hcfRoXrJTGG0fSzMR7dChtqho87hO?=
 =?us-ascii?Q?884H/qMkJaOxLZxFjFXKeIWLIr2EQDmKT4CNXghVe6JejDjWVtAgEMVuolB4?=
 =?us-ascii?Q?MTeotz2HLL2X3H/t99qqmF76vJXjB7Fx700ZU5OIopI/1l7gBHtx7nxbW3Lr?=
 =?us-ascii?Q?oFaRjvikxF0QttmKxby9O730tUlkmIluZ3X8Y0+pHEGy2gfGSEze8loJvIrR?=
 =?us-ascii?Q?8A1Vz4bQ2D7+lLfmW/tM66FftrC7nGtP1x/cpCSCBxalwgrsl+nVvbkEDXa7?=
 =?us-ascii?Q?cXH5p5rTGGECUdhVEE0JlRwz8O2Gl1rkvDImxq45p0r8+S0Nt9jMOHvQs1dK?=
 =?us-ascii?Q?6NMWOQcEYVe52FRbkk4uOpQn8A2jClv1xWzvwUUy0GMQ9/Chunbu2/tgzGBF?=
 =?us-ascii?Q?fofY7Fl5mPJ8BubmY92QO0qWApJxL5Sa2KGoB73lyktsfdtGANy/LnlivGZD?=
 =?us-ascii?Q?KIRggEd5l/SBhNHA1GlGUUuL8JSlGXrHtzzsLmUmR6fpR+1F/MyXKbt2MRRW?=
 =?us-ascii?Q?EP+nM42qb1x8cko+eadQTjPfdgwZyaOqJ/zQWed0v4BywYCbCnmhoZ05aAON?=
 =?us-ascii?Q?mjEeKxvVjECFbH6uWSidl30cvSYuuE3CVbyiVv3lxTbkls/dWDFyS+TqCUYs?=
 =?us-ascii?Q?Lgb6LbsvHPl0QmFFegM1yaV7m1zhypRSfXOXlmkF1iJwdSZMlN17JGIhONyJ?=
 =?us-ascii?Q?TZ9HQnFeKnQSb93Lw5ej+FQh3taWzhpYWZVuF1j42r8s15rQEu1eqZFX9zw3?=
 =?us-ascii?Q?t8Q+zRC/PRqpQR2j+qi3m/CJr6xLZAEddwWr/XFa6FWb3W+QFdA7jZP/1NNA?=
 =?us-ascii?Q?kzmE9IjAbrda5IHvNo3+8b8ZcJtTtZUjxu7nk1IUFpwuJjmsvicAnpfX8Rat?=
 =?us-ascii?Q?7exVWI9owyXM4hxkkcC46mUaBQMCjxb7uHf6zsST?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd25211e-3fb5-40e8-05c1-08dd83473906
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 15:46:47.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jk9EVTQ3h+OkmPb2hh+uGUHjsx+5icXm9w1pL8cU7d7zQmbDrvhomowPQLEkp6VZ/bxwk/3eK8+0KW7k35PgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5058
X-OriginatorOrg: intel.com

> The tool of Smatch static checker reported the following warning:
>
>   drivers/edac/i10nm_base.c:364 show_retry_rd_err_log()
>   warn: should bitwise negate be 'ullong'?
>
> This warning was due to the bitwise NOT/AND operations between
> 'status_mask' (a u32 type) and 'log' (a u64 type), which resulted in
> the high 32 bits of 'log' were cleared.
>
> This was a false positive warning, as only the low 32 bits of 'log' was
> written to the first RRL memory controller register (a u32 type).
>
> To improve code sanity, fix this warning by changing 'status_mask' to
> a u64 type, ensuring it matches the size of 'log' for bitwise operations.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aAih0KmEVq7ch6v2@stanley.mountain/
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied. Thanks.

-Tony

