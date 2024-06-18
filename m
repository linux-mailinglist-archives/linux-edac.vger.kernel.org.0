Return-Path: <linux-edac+bounces-1307-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434690DAC2
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 19:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36018B213D6
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095CF13EFEE;
	Tue, 18 Jun 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd8VhTaS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EA50246;
	Tue, 18 Jun 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732140; cv=fail; b=cS5mYXrREutBrfzzhXdZj4bFkyx+/6WYpGwVkjqANr/hSA5ekeTePyIlSPBzMF/zQZQWnsKM4p2wdlgMgTGtPZdB2sQc3Wobt8STIP72av0UopSC4xFPpvhXNKMO5JLIh6BU/HEByZZzE+vVWnqqlJOaR2sEyxLHxCZvav+e1JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732140; c=relaxed/simple;
	bh=S0doI2G96d662jFbTfnVrpPmjGwbB55y4y67l95uN4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RWSCgZNmN6rqMmx5YIFaD0mIjVxa7srqe7vajEvvWH5mEf5/IJW7xrIc3kqinfCuBGKZkdmkrE86YHdBMWpurSXFrAiiFx04ky0oQavaQUiuQcOSnfzOK4dXvOwxMZoDOCxzbVytY3ggOPeWBP4j3FbBsj8rSIrqmzOFZ1bjYO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd8VhTaS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718732139; x=1750268139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S0doI2G96d662jFbTfnVrpPmjGwbB55y4y67l95uN4w=;
  b=jd8VhTaSmuZtVNi5ETtKPZ6/xYQOFHJgDqk2c+XOdCajFZiow6l3egEH
   52OB/VyWWRwDrVuXNliAh3aXoJ9VSXi06cOV+dkAmbstepTpn/sGY8Noz
   3bd7ar2q6PR8SzIPOYofOQrldO74EDVp4fih8hadyk55/7j1sooMqgKuI
   rQGIUn9TUmUOSBc1gpY3jMWx1AYODPHrr2DFxVgRm22w4F5UqhJo6GB8E
   2NIH/HJPlrPV0jclZHN+lHoCgAFB2hwHOpt3TVcZD8+JvP/cIf8yqOdQj
   6MyBDLz8qxovMleN+2eMx8UilT3AS50Wn9B9N85isV8jlDq6x8aoiP5AB
   A==;
X-CSE-ConnectionGUID: 8AXp+2yYTWa6aXMlLUi6+Q==
X-CSE-MsgGUID: F+of78IrR2eaDcDKdmO2Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="18548301"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="18548301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:35:38 -0700
X-CSE-ConnectionGUID: LPWiB0oKQo+pG5jUNGpXmQ==
X-CSE-MsgGUID: s4ahbW07SyyuUqPMeaN6VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46074087"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 10:35:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 10:35:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 10:35:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 10:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTyJWpskEOHq9D/rJNTw9Dh0w2COJjBIAfrFHKTvsHMDNsogOOHSyLtOqMUZr3F/q5YQtqEroZCePNHvb2o6V3AIv5IuXdB1U3Pb9nvTWgvXjlItPTpS2c0JgPw7kF5hWEzqzXIm3VYtoaC7bBBSK+8UnkSUmLetbNDePQUoSpC83raltE1wwSpR+i75QVyRtvQpZAnFI21h0rFky1YvS4Yx9Qn6iXtGqpFxxgGJvLCmqxAbh7lnssQTkBt+0hQs8ENuYbMIz7X+um66+SsoSsZv3JD0wVO9zp0MRy/6fJx/CNWA6l7C4n6jZWDsqevAnE0MZbC0DrB7JVuktwBVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACaCNNg8HNpPy+37AvWNcqqv4vmAkxwFj968yoVgcXQ=;
 b=cmjyfHS0BvtzJVG/9DlRIrMXr0ohU5qCl4gAQeId7NOMRWwtunB+OV/RLwgOgfjWYrchBSf5FLUf3ajll/K2btOmJgZKvpsDClwv3GmF4lN86DCbFwl5ARDhhOpJUOQbhv2yrXjVeuGRR4IRzf3dXxkxMk9fzbGGIGNE6ap77M62jOGJXNxJPhsPIrPC5QAKsh0ikxUn7kG2NgA6xSMB8RJ/iaqjryghuxhju/DPGgjqT1y+6dFpMgb68RCQQR5r+Y02kUujy6e0Df7gfjpn08h7BnUPhDc8zaRca5nwoc/hci/mlGmLtAjyg7VYLTmJCxv0vH+wt+CMajP66St8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 17:35:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:35:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "$(name)" <qirui.001@bytedance.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mce: count the number of occurrences of each MCE
 severity
Thread-Topic: [PATCH] x86/mce: count the number of occurrences of each MCE
 severity
Thread-Index: AQHawX0xJTiAPghlyEueMSNTNwYZZLHNxjqQ
Date: Tue, 18 Jun 2024 17:35:33 +0000
Message-ID: <SJ1PR11MB6083AC9C721D46D3CCF9846BFCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240618124331.12729-1-qirui.001@bytedance.com>
In-Reply-To: <20240618124331.12729-1-qirui.001@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB6443:EE_
x-ms-office365-filtering-correlation-id: f20a2c9a-f383-4ab5-c372-08dc8fbd0ec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?MhPOplQNgSzsKzxjNRFBj6Gp6GVbyS/uDsGeiA1vlVtiptNQSzi2YPY4Mr2Z?=
 =?us-ascii?Q?ifmT0ANWviF3r8lR7MTjO7SOAfVjK6Hh03jGp9m6hrU6+YjyVSzR45IbGlSU?=
 =?us-ascii?Q?invKFaBK0iBMEgMgUNmaTZ76wBRQrX2Bml/qPgeDw8OpHeP17MSqJ0pzqold?=
 =?us-ascii?Q?Cc7gV1+yGUrmnGh88cENnpaEqZH/NagTUVajYYzq71dz1gFWpZhsMtnTRGrv?=
 =?us-ascii?Q?P8nS7zT5jr+Vn0sqgQXcjHqmYNVpehg4eGr0KC1RieAWu6CWlBpATYhkJrjn?=
 =?us-ascii?Q?4iELsmRGEoSY34vPchO6NEN7VIh/aLoPKzBPZdLUPtWGheoDEDf/ISJADhci?=
 =?us-ascii?Q?CvMkyQTfofa166FFYEQk2peEbu6vDZDmBqMY1rgSmhvteA7qt0ENaX1BrUHb?=
 =?us-ascii?Q?F954krM3MtsxHWjXZpKdF6opCLNzwhQWgleVs3Lwb93nHHT1Cy60H2125Col?=
 =?us-ascii?Q?XcsjiccZG7oAqF5dbtgBtUQh2HPGRNaxDsX2xbQrHNc3gRNsxeeTiPslxo9Y?=
 =?us-ascii?Q?equSB2favLs4L95OmXBGtNebw8yumo/HCRQnLi0uRbrdv605UxkW4y4GQt6u?=
 =?us-ascii?Q?+VyHh4OqJIHr2+Pk9wOLWCTACm3w+ohuH8jzeW7X9xI10HzT4cPOZNc3TZE9?=
 =?us-ascii?Q?ak0JEvueUH1gTLBxDEPTslT83yx5e5IpppV5SAn5W+qy55ngGTo/PwTQjLuV?=
 =?us-ascii?Q?JaOJhxtz6CvAAVsxDVDLvDj/CrSz35hADfAAhZumj8M0Z85U7wnzYjFS9SwI?=
 =?us-ascii?Q?XvXDm86r/Gbhje430lKFUeJxz8QkxyiNorOGjYKQUFJHJ5zelEHMeF2FXZxv?=
 =?us-ascii?Q?iZCM8pwhmT02me9GR7VhdEjc57Z9YCKekHqkj27z1DWD3c4VPuVL57LdWvWc?=
 =?us-ascii?Q?ksUblfCBxh5EF+1EXK0YFvYWv+CJg0kfq/xTvInfMS/eNmkiztu8ROrphyyg?=
 =?us-ascii?Q?VeGRn86yriG5+6LYm1n6jqsP8Lbnd7niCkMPMpTqLcCmtCZyfD89iRoWZZtf?=
 =?us-ascii?Q?z4+x739ICQc5NKJAkmmxf7lTC+fsPF5JdvWJZaitL8cxanzdBbpLM3F6Qi7I?=
 =?us-ascii?Q?odZlqReWSwks5fw+8/9jmiaMPgonIdio81VulTUeVs5eh/5iz6/7TpprJIJ8?=
 =?us-ascii?Q?QsY64KpFLMBolSK54spMHvPhYhGzipkGVitQZ4c5sL1994ol+2aKLcvCkTpB?=
 =?us-ascii?Q?SfYCEXMPpjd2cAnJn22pkH2KanJuQmNJSNGwI4tdTznKqKfNBxCi5EHqbx+H?=
 =?us-ascii?Q?U0C6yDhzTEPcEgK6j2G5qcCwb0y8tOg858MHG+NAWW1/Fd3/15tVOAFe2rNv?=
 =?us-ascii?Q?0OBZU0FcDXk/MDbvnTJ0ZMolr4qEcSHSsD22Euk1DWSRxnTYVpxDkhu6oe5T?=
 =?us-ascii?Q?zYEYyY4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dllZQZuJOW6pp+s0TGPLaBJP3n7vkW2EcPHrcMJ56QPipS1rUVgZjfXyA9VZ?=
 =?us-ascii?Q?ZFwZ41bWPqINryrxtyWAbcrfMMDEyAbEenLsqkAUlnsu4EAGKqJgKTMxFt4U?=
 =?us-ascii?Q?/UgjiwCFGpDyFIZchbmbIElGj2T5odH2biRcsDbmCQe6u4q2z2o8QuOzLa1o?=
 =?us-ascii?Q?HIoI7DPXjFfbHRYEfbKVoxKZP6vJVdeB2SaBIRZhFCGybjTm0Urf3775Xcoo?=
 =?us-ascii?Q?iry3MRorHszBS6snfbkIvKAPrhjrLrzUT8SniWlzsvO8gQNE98Xj+lNpkhiT?=
 =?us-ascii?Q?UHiyP8ZEa2k4BpFu1NRQdGD3fjOd6o/3QI6I+fxPuHesFlU5k262o6j+Quf0?=
 =?us-ascii?Q?O6ZSM//mHHtD3k0Ys+YJIY1Uhkvge0NOu9IOS9IstSlpLzvxbkOJuB1ejPsl?=
 =?us-ascii?Q?gvnB2/UyGLFqSzDz+Owlo7LJ3T9NiWDYMubzoquHeLPaaBkL0WM2wALphC4B?=
 =?us-ascii?Q?7vRy8RptUbo55+doHNbMtA30h4Ns9ymJdvVq3/z5p5c/ZTon7SpqRW3Q1xYZ?=
 =?us-ascii?Q?ZR9VKzvIJyeBjn5AdFsOCQwhzMei5TFoeBE35nyw/wDtBDc8H/LBgfOh8nZM?=
 =?us-ascii?Q?3TYNxSzNyWT+cwoNVQZgLOxG+rDqGRwcC4tC14iHb1EWnMVXcRgD/hatX2MB?=
 =?us-ascii?Q?5p+ho4Xd4WmQxw1g+SUu4yrykeyKSqdTmcEcVcjPsZDQ9HXAOegTUJED0LfE?=
 =?us-ascii?Q?E2nRzg1UxoV+5c/am9zoo6Db2Qa68hO0GgiDLHnEL/BelgbYi52EUDplXkVY?=
 =?us-ascii?Q?1geLYP30+bI0QNIQGNAJW2t2r866V2aQwEHWhAw6XWXpP9TPNo4I8csj1Ysq?=
 =?us-ascii?Q?ewYlcv2KdH/lEhAFOXBEHnG/2sA5iW1Q30jgJ7Thi657E58qMmv2iDVHbngB?=
 =?us-ascii?Q?Q1waYbd6YiDq+Ggl+jDb/8h9QqSbYIzYPCNWJXHckV+7IoTSoJ6drdx6CMFX?=
 =?us-ascii?Q?ZVHSR1/cmgNJ/PM2WPGXg5Ujzdw1J4qn29DKru32rMs4C+iABwmyyUml3NWn?=
 =?us-ascii?Q?bgBfQ5OjGAF3EW3tbotJbrKpqxnCgFEzBaW9joGv087buiLYfKULsevuVDXy?=
 =?us-ascii?Q?rHW/0nDTJiGIrMwt2IMf32/ujqAkzxq/ifH1sxq1+zsNAB99hk5QT6sKVKJh?=
 =?us-ascii?Q?75NUlSgK4whWLR3N3BzcBp9p8Pfj4MQhZfJtTGKjibYSCDzAr5U2dggHk9nA?=
 =?us-ascii?Q?hb+Z5Z/MBxrT9SorMbjgw3WtimCaJqhP8TC/7AOsnP6Ogd0licejOigi5lge?=
 =?us-ascii?Q?uukcr+Ms6nryfbFSKoclJcXzgF+m4PFFTyRHwWSDLoV3Tg9lfGIda02riCcY?=
 =?us-ascii?Q?F5BVJKdtqLcyjL3Uv7/dBUHcaDsp9QIUHzb/QEzmgpFe2UE/BmqbvQ+Sx3Xs?=
 =?us-ascii?Q?d4MrnrTLWYnTL/6ikV4PGJ2NLj00O3x5prJG40H4LgfIjaKn6SpTgIytU9U4?=
 =?us-ascii?Q?80A8Guppoh8qLanJo/V8pX+hoJcEN8tK8PTnDEG1R7xns989KyECItuDg3V+?=
 =?us-ascii?Q?Omu1GRodbx8VrKTCJUIY5WFRGNA/ZGrb1KE4HnRrzNoizDz1Jdx5y7WxjXD6?=
 =?us-ascii?Q?3zbUFdBwq5ZTdwkcM5cZs3obdqTdkxuZoO5hPNOx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a2c9a-f383-4ab5-c372-08dc8fbd0ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 17:35:33.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VuAnCVI9TDAlUqLP1qI4wmSDrxE46Kno7ZELAre+pjVHpGh28wubqpBrtPEjvSsHg+p4ttqRepMV2EqJNE1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443
X-OriginatorOrg: intel.com


> In the current implementation, we can only know whether each MCE
> severity has occurred, and cannot know how many times it has occurred
> accurately. This submission supports viewing how many times each MCE
> severity has occurred.

Is know how many times each case was hit useful? The original commit
for this code said it was just to check coverage for the mce-test suite.

4611a6fa4b37 ("x86, mce: export MCE severities coverage via debugfs")

So you either covered a case in the severities table, or you didn't. Does i=
t
help to know that you covered a case multiple times?

> Due to the limitation of char type, the maximum supported statistics are
> currently 255 times
>
> Signed-off-by: Rui Qi<qirui.001@bytedance.com>
> ---
>  arch/x86/kernel/cpu/mce/severity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce=
/severity.c
> index dac4d64dfb2a..a81e34c6e3ee 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -405,7 +405,7 @@ static noinstr int mce_severity_intel(struct mce *m, =
struct pt_regs *regs, char
>                       continue;
>               if (msg)
>                       *msg =3D s->msg;
> -             s->covered =3D 1;
> +             s->covered++;

Wraparound sets this back to zero. Should this be:

	if (s->covered < 255)
		s->covered++;

[Is there a #define for max value in an unsigned char? I could find one. If=
 there is,
then use that instead of hard coded 255]

>
>               return s->sev;
>       }--=20

-Tony

