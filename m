Return-Path: <linux-edac+bounces-4162-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D429ADE1A1
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 05:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54891685CD
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F81D5CD1;
	Wed, 18 Jun 2025 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z44iM7Mu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762D39FD9;
	Wed, 18 Jun 2025 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217212; cv=fail; b=rnzO3HgZrWKbb5UkDck9BfO/oETGMYgIRa27Fr1Yw9hxbTvr/1/VJOck1q4oyg1q/JEY2HB2t6ZJDpmCq16UARBEF5PoVfx6jNQdouz/5arM3OFbFOjg1gKeMKFPrsNLyQ6HhlojNKo/7B6z4Dm1fIGGHz05gQJm9yxZBbirqBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217212; c=relaxed/simple;
	bh=t+fjkE1QRu1zxpgMeov0p867+iOO51Y7vtNZy52Ev3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsjVWBQdiTLTCejFadm4qW7v94L0V+RTUz8o5UAy9dLQDoToHN76cBOrzh0qqPVgyQVcWnrHFLM2zWVfTEOZZZ7GB+ulwhyoE2S6o7BRH+VYmsoc7cKC+X5zLmpY5rb3+xjVQkDhSSJ6GMMhgFQuzvfjOdCr1kxfLaLHv8JDA/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z44iM7Mu; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750217211; x=1781753211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t+fjkE1QRu1zxpgMeov0p867+iOO51Y7vtNZy52Ev3A=;
  b=Z44iM7Mu1Y/1HgxBdEttWx2OKVYbM6ixLt8xxa4OpK5NMnJszfou3+Kn
   gExK5pRsc3z1zngQAgwhGrBZBA4H7jOpxurioxsuKh53j/FxiZBAV8ayI
   Kq3/5HHqynX4LHfkAw7PZjRMw03hMuRzRZcNSaGvvWinHeJJws7PC6P9v
   2Y5I8Q489OHOs4BDEbZc8C+PnTB5rQPHtkNVemi/J4ifAi4im/DN9eJUh
   Ul08i5sJILaqoP156E3JafgBN8KmMoGCHL9qylu/doht89OiD63uXRtbA
   UMmWLzuLUO1BMGEK8H09Wz1PxayExAtxNsk248QbugHkssaIy42uyWhLV
   A==;
X-CSE-ConnectionGUID: JfErdLxxRdGg+An3R0oWkg==
X-CSE-MsgGUID: vg0slXi+T86rzjtrtpUb0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52336542"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52336542"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:26:50 -0700
X-CSE-ConnectionGUID: bWsIBOGUSaurp5j7AdxgmA==
X-CSE-MsgGUID: gbo6ZR+FTvmmXDBY3dRLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149709973"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:26:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:26:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 20:26:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvzaVmyFsrbjZpeuKlS2weBFVvlHdMgQ0d1b7vRx074+i99JLq8Xm8V4upRvC9yhqbeZUtc9pE8ye14mj9t51Fqi+6EUEisd/E4RF5CYBuw9EmM330ZmVlT46bOWSwQzEWmwoDhhlyjoqBlA2g7Y81AdvUulvNBgn+7aKQ9tbXHze7zWt5sRv4SD9/+1KUzxr8eWKXZa23PNTSxRVuIT6mWYn6uE+SEjF+lIzzMJuFXJeHeZDNzzClEFKryi0C/nAlXR6n/QVAURCElT+u11C4Pn2vaMf/bMmh3NZvprWJldlm1fXG3ktsw2BSF9qa5F5aCdhnyHdZdi1R3BoyNdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+fjkE1QRu1zxpgMeov0p867+iOO51Y7vtNZy52Ev3A=;
 b=s5Je5sezVIzKX9536CH6pGy3dfhcAamRH3dKXc7R4WYyYKC+CAOa+dk2hvulylbJiQAOAgcBp9Mz/AZE83F7K921YAaetgpXbaQLk2bXFztsU6sgufGWHxCi0J3hoT1EI4R34nuI3CvuT06Q3rxTPfUOpqxikJhdkfA4g2f93TYPHfPE4IoAafbvA3+ar7kmsJaBnyeICangtgjrOYM3A4ovLgoyMCe0ikDxkqzjD9l/uA+Sy/cvh83DqrF8QTmZu5iP1xayHOpVdzQiXE1l8KoiNME8rC6CYukDq5cyn+Y+/B+ag/F+EOo50m2kFFw0v3cliuw/kGCJ0oV8SzBy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 03:26:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Wed, 18 Jun 2025
 03:26:43 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Thread-Index: AQHb3//92oSRM+Zs5UagMHP66pMForQIQGXA
Date: Wed, 18 Jun 2025 03:26:43 +0000
Message-ID: <CY8PR11MB7134FA32BC293D5E868016A18972A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS4PPF6F32BC4DA:EE_
x-ms-office365-filtering-correlation-id: 446e87bd-fec5-4d0a-a5bb-08ddae17f285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ajV0VG5WaUtnUHRlT2Q4SkdySEYvcFU3VHVCZUdpMFRON1ZjUkd0S3dhRE5K?=
 =?utf-8?B?eVd4TGQ4RThCWlozcFd5V1hUdC9KRng2YnNGYm5pSHBqMVQyUHNMRkovTDNo?=
 =?utf-8?B?V3ZUS2Y4QmZqdUpPKy9wUU1oRjM5Wkl6S1ZRaTdtOFc0YmhQUlN4K3hyZHZl?=
 =?utf-8?B?YVduV20yd083V3VhUVQ2LzBUb1plTjEwNFZxNW1xZ1Z4cVQ4cHdSOXhvZWYr?=
 =?utf-8?B?WUs2UVRVVmxveCs3UWhVNS9PNnhFZUV1UGN2czlMN0VaaFAvVGVrTG1uZDBx?=
 =?utf-8?B?TGNKR0JBQjRFbWdheVp1L0FBUHVQOHloMU1EZ2w4alM1ZEsvNWNudUlGanRl?=
 =?utf-8?B?L0ZZa2ErS1hJWCs0bFI3UFI1Y1VCZUJOSUZtcTFBanBWMjBWM29NM2ttWCtU?=
 =?utf-8?B?aTlXZTlaQVZpVENiMzRxWkxQSTBvblRLV3RONk0xRVpuWVZ4bndXN2EvTUtx?=
 =?utf-8?B?M3JlRDR1OWkyQ0hRaUZFekhMYmk4c1cydEVWTDZOVFk4aTZIYjUyUDZCcWxM?=
 =?utf-8?B?ZjNWaGNMSjc0anpHYXgzaXY0U2hVMnExR3hoNmw3aHpmZXhvdU90L0gwL2gy?=
 =?utf-8?B?YzlNcWtENVBqSjBhYTZOeUFHR1loelV4TUYxdFJQL3A4eHEwaHYvNFFPUkE0?=
 =?utf-8?B?Q3lDZktGNG5PTXZseUxsaWFvUWMwMzAzQkJwbEtMei9vK2ZiNlJ2UFQ4c3NS?=
 =?utf-8?B?WW4zcG9veU92UHpwRjJnMWJNOFpJWTVid202QzJ5dHZWbkRJaVUwT2ZWNnkw?=
 =?utf-8?B?Y2xVemtrY0hCdUlZbE9rdXRRc3NIZXhjWU9NWFA3ck5nMklPc0FmYWpZc3Rq?=
 =?utf-8?B?cHo5VWdkVEVQSFp5T25wYUdpVXhSS3lGSWlEUGVHSk4xN2p5eW95djJ0bDFR?=
 =?utf-8?B?Wk9JcGI4NTJJSnc1dVhZWTllRU5SdVlUTU12aEJYLy9xQkUwZVFnelgzcU85?=
 =?utf-8?B?cmVWcUc3bWQ0VnNtK2JtOVM2ODVpRStpdWZ1WUM3MERCQTdTSXB3aXZlY3Ex?=
 =?utf-8?B?ZS9GajhHUDNENTMxcVNocWtvNHJ5WkNzK3VXdTZkbEk5N3N4S0lFNU1ZaHhX?=
 =?utf-8?B?cHB0dHZXdFZjbm5mWGZoK0Rwb0ZWYWE1b0lCRS9Dbit4cXluN3pnQmNuZGVT?=
 =?utf-8?B?bkl0cVhkQUtYd3RaVnZub1hFRlJOMmlCUit4MzVSeVFpUzdHckN2QUNXTmc1?=
 =?utf-8?B?bUk1aUNQQ1hDdGJ2TEtlUkVaZXRmSHJ0aWdkVHAxaUZnSzduVk04RFlSR1BQ?=
 =?utf-8?B?K0FvYU95QlZnMkNZdVRsTDBmcUNoRFFOa0lWNjFpangxU055NXE1WEJJMnFm?=
 =?utf-8?B?V01CbkFQbWZjdHp6MVNpYzU3dFlBMHlicXpCOWtXTXFRVTJSRG04TW9ZYVoy?=
 =?utf-8?B?eWNYek1Ob2JlV0I0eFo3NVdxaCtaT3QvVC9QbmlMdnFXUnZqN0VNak4veGNG?=
 =?utf-8?B?QTFmb3lKckdGaGpPdEk2TFJ2SEhVazY3MWRHMC9HY3lqMm5MVjJDdlpnWWRP?=
 =?utf-8?B?aktFYnBBQzRxQWdCUzEyUVJ6VmlkVEVQUWs5YUYzMEQ4M1Fud3lZZDA1MTA1?=
 =?utf-8?B?ZGxjeVdRam1WR3QwZXE1Z3BFMmYreVYzMzgycnFHTFBTbnVja01YMEs4L0pW?=
 =?utf-8?B?R08wcG5FbUdMSTZJMSsrMUJSQ0V6V0JTekJXd1FDMTFBRkVibXdXSUR3OHhr?=
 =?utf-8?B?cFhhdmY1VllETFFIbHR6VnRqUVgxendoM3RuSWRNV2JORlFkMG1RMHhvOERo?=
 =?utf-8?B?eDZQZnlkaEtNMzRzY0JGeVJnakpZbDlBbExPTkFqb093Q3lsS2VIMit1K1N0?=
 =?utf-8?B?NTd3WmpHNFg4WXRHMUNxdFc4L0wyRjByc29MTGNTYTByK1RycVpuNkowVVRv?=
 =?utf-8?B?ZnJQbEIycTF2TGlFaXpRT3VHYy9BcmpuY3crVGJjYUNUb3l0SnVSV2V5RTIr?=
 =?utf-8?B?cjV5WnFlWm1DZTZqdVNrQXA3aVFydE5XQ2VjamQwbWsrbE1kQXZYTXBidUtW?=
 =?utf-8?B?amNmajFJMG1nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHplOWszd2xJdy9yYnU0YlV4Skx4N21GZ1MxcDk5Smc0ZlVxOUVRN201Y2pF?=
 =?utf-8?B?VEtxWjEzV1B5TTJNVVE2VTUyNUYzcS9NdnhVdjhxWGRVZFFMNm00THYvUHhE?=
 =?utf-8?B?anVGc1BoQVVUNnpFcWw4N2tSNS9nK0kxRkRxT2hwYmdqdnVzbDFyZ005Snlm?=
 =?utf-8?B?SFJnU1Y1Y1pML1k0NXNiM2V0M2M5eVNveE9MVGpzdVdnYXFqQlB3djJwY3Zp?=
 =?utf-8?B?a0Z1dEJobmdTSzg4UFNJUW93V0lWYTdNYkp1WjZWcnhYdU1OVElSVkJ1OHRu?=
 =?utf-8?B?ZkphZUI2UWNmL2FaNlFBL3c4TDd6ZnZQV21SbnVpRmR6M25Id2JvYkZSOE1O?=
 =?utf-8?B?c0kva2ZzNXJJRG03dGtEaUs3YXhzSUNaK0dZL3g3WDBKdjlxMkE1Y3hPZUky?=
 =?utf-8?B?THJLNEh1QmJSVE5ScHp3T0pmMFNRMmlubXFTcnR4WnBlZDJnVnhDQUEwQWkw?=
 =?utf-8?B?NFNBWkJIbkpSWmRuemNXT0xzNmZuM0w0Ly9RclJjYm5jcWp0elpkdUR5dWlK?=
 =?utf-8?B?bzhROHRUZXQ3Z0QxcjI3VXE2SlltZGJkRUkrS3VtS1RSall4RXdlb0ZwLzl1?=
 =?utf-8?B?OVFKSmxleVI0ZklmY0R6aEtXTHFLQWM1WktVRGZTN2VYdE5NeStubXI1dUMw?=
 =?utf-8?B?cVBpWWNXSWEvayttMnc0RURUUDlHbnFRZkhtd0theHRuQnA0QU5QQ25GMDh5?=
 =?utf-8?B?d1NXNGVnV3JxWDdySjhJOXlpTE9PdUlIVVFObE5Yem5uYWxQVUVUUkhkbHFP?=
 =?utf-8?B?Y1FiNUFFMERQakQ4QVNZdUg3LzhvUUJDVGlWRjBKV2ErdHM2NFZMbmgyeVhp?=
 =?utf-8?B?S2dDWjUrQXZSVnIzQ2ZTa3JKcUFNRTNURmo0MmxvZnZjWUduTnVERy9MckVn?=
 =?utf-8?B?SFR6MGJvVVhPaTJRaEYyUmlZQkdFQ2EyNFdhMGtVaC9mdHpWUTJqZlJzUGdq?=
 =?utf-8?B?UHl0OUNYTUNzZnhJTkM1UUxGTTBaT2E4UDE3OFIzY0lwdHJBbzJuZWloazZR?=
 =?utf-8?B?NEk3NUhsamNMOFlZYk1NeCtkVGlRbktVa3dBakdNcG1qeTV1UGdPM1JEZzc2?=
 =?utf-8?B?S2hhdThCZnRZbTBwOGlhd3hlN2JKMHVIVmR6WDN2c3o5eElxd1dJN2dNVVZr?=
 =?utf-8?B?MVlHMG8xSDNtOXcwM0hOVzVSYXFKVU5ySWlqVVduZTV0alNWbjVnanQvUi81?=
 =?utf-8?B?WDVMVlN6dUgyWXpHdk5ld3RES2Y1MXFUSkp4eHFDWitCSTlKWWlFaTFNdUdy?=
 =?utf-8?B?QnBZUGRJbmZlQVFkZ2Z3NEVpd1ZBK2VyTUVJZlZ3RXBQVS9hZWE0SXZqa0Q4?=
 =?utf-8?B?QUxJNWVWVGxUczlwYW1ndFdjMWxBY3RVb2hPMUp3MUFLbXQzQ2FzVkVMdzF5?=
 =?utf-8?B?VzB2MVFUaFROd3BQejFKMDNkSjhUSFhaWll3K1JhN1BjWm9Xa2VGempzVjlw?=
 =?utf-8?B?dGlwOGJVRlh1Um1yMXNpQ1BQWG9zdms3cDlHTURBZ3ZpNWQwOXVPRnBackxx?=
 =?utf-8?B?NERhZU1JanNtTFBoYUx5SGNkWGpGcTNzR3dQYkJxb3JlY3cxVVcvTTFRR0tU?=
 =?utf-8?B?cW1TbzN3Ym5MWG1pTFdkY2FPa01zVGhMK0RZOThyK0xPRjl6Q3YrdDJycWRZ?=
 =?utf-8?B?MFJ6VjNIYkF5eG8zU0lMSm9weGxKQUd3dHU5cXNtUjhiNHF4dVBlWlpIM09n?=
 =?utf-8?B?NC9pbzdUZkF0bmg3cHBLc3g0WmgzVEFhRkQ2RHJkdWhsU1dDWE0zSitxVDE5?=
 =?utf-8?B?YUFwVk1rUkNhTldBN1VSSE9TaFBXQm44OUhHd1lUQkxBK09yVklOZ20wbXNF?=
 =?utf-8?B?eWpPZ1pJekNCQW9BZWp1VUdyU0tnT2VXakdOUllXTnJYdjNLL3psenpJNjJH?=
 =?utf-8?B?YkhEK2lGUFJSckhBSWdyVG41NWpwMkNab1orUm1pc2ZySFRScE52cTMwY0lE?=
 =?utf-8?B?VDNPY2RhUmxNMkZOUC9NVUNNWG85VTAxVnhETTVDVnQyR0VXaFpWZkZIaWVQ?=
 =?utf-8?B?NzVXVUFmTFZHYjdGUzhMSGlGMjhMQlJ6WVpLRVV4bGNKekNxUE5XZmptQ1JR?=
 =?utf-8?B?dUtiZTA2SExZQW5md25NTXRRMUF2Zk5pSlhJM05vZE9veGtVODc3UWRES0Nq?=
 =?utf-8?Q?xpC9wo0LczAs5wUq1dplBElto?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446e87bd-fec5-4d0a-a5bb-08ddae17f285
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 03:26:43.2569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aisv1ylB712qHkZoYeCW6ePw9U8rpuRlsfLwmkOIEHjMIidD608pMXRGwBH0gbqoCMc3sKFyf+gmSRXm2294WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

SGkgTWFyZWssDQoNCj4gRnJvbTogWmh1bywgUWl1eHUgPHFpdXh1LnpodW9AaW50ZWwuY29tPg0K
PiBbLi4uXQ0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8xXSBFREFDL2lnZW42OiBGaXggTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlDQoNClRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nIHRoaXMgaXNzdWUuIA0K
Q291bGQgeW91IHBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24geW91ciBtYWNoaW5lIHRvIHZlcmlm
eSBpZiBpdCBmaXhlcyB0aGUgaXNzdWU/DQoNClRoYW5rcyENCi1RaXV4dQ0K

