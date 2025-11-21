Return-Path: <linux-edac+bounces-5503-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74494C7B5AB
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 19:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04AE94E1CD3
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4382E7BDD;
	Fri, 21 Nov 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd0m4qqh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484062727ED;
	Fri, 21 Nov 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750277; cv=fail; b=PV4iSlw2Ur/Cpzh/sUO0hTWagX/roSHqobBKv6e1GILguV2w/Jg2triJTvP3E9rCG41jRHoCJPGxPZbeMdUQ+1vycJufdQD1cG5lIW7Cb8xmNvXjnzp2oIzZrC4ejFeH0wyXy/FRWSjNGN4tbJRGjn/rhX4Ajnzn0+P6Qx8L4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750277; c=relaxed/simple;
	bh=IpJiYhiZE9X9ThJpnGcDACjxNSvINlC1D7odBfGVY6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCgOjTAR1qcdqdKbefh0SZeSzrM6UtpCGq8F+c9lJijiT0qehVwoGFLtSbDZZh3CDgOylI49MIGAbnJJvmmMvmbgjKQ+y3h2qseH1jIRzyLnpFBZFnh8QSIAOuVsXqd2jGOD3rwUI90Nlu0rtSXZzgw7Pa45UhM9oeECB18jh28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd0m4qqh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763750275; x=1795286275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IpJiYhiZE9X9ThJpnGcDACjxNSvINlC1D7odBfGVY6I=;
  b=Jd0m4qqh2PfGG2ByDbNiY3JmhCflLXfVt9yXZhIWOSpdKbzoqm/Xsg9w
   /IYZ4P7zwXHiPLRh6F4saXBZklZtrcWjNlit4O4cVD6GUeoIx+ToGi1wX
   w03HmSKt18fjrUikIhGIElbvw78xrz+CGbyR8gSkVZXKan2jIDcUAYE0T
   sbabprgoG5da4dPVaK8fRB+LBZJNhLwoJOMoIVbJJsP32d+wijlQ75hCL
   8ZehW68qb7SoN4EQ4f5KcSoPBm+FTW2cIs6l4EfafyqxWkM+cT0GGIw42
   hwH3D8fuSIQjzxrfaqXQAveaUqLwXqkxBNz/l1fumM3V0yzPrcRxEVEpJ
   g==;
X-CSE-ConnectionGUID: j7HD+fLUSLWRIeW/+jaXVg==
X-CSE-MsgGUID: PSnOtFGFT2KO+AGlHBI5tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="77212741"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="77212741"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 10:37:53 -0800
X-CSE-ConnectionGUID: qJJPBpgBQSKBiagbU/9nzw==
X-CSE-MsgGUID: qk6lHHTWT7C0HFGyvloPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="215122038"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 10:37:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 10:37:52 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 10:37:52 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 10:37:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi7giZUBbw99zjVm1xiuM63q/unAOiQkuMOuhXCgSgKQD/RjazIRmLvxel55z8I/KkKHYN65kOAlDasyqvlkqIVHcGe0C8pT1yWfF+U3GgfbET3/8ME+sy+kUPf8P0CFRP46V+tFv4HwZ5m/H9kFs7HG4EZuyjT8w7a3gng59MTGCha/N9O+opY6JCS5VkZl6lgD0u+IEToW5nLBW7kZDDiYD56Lj7nkkghf3cOdsfGge2csxn4jp7jKHDd2rNWKSv8/fEIcMwRG81p/w8m59Er3ZZpPRo1cpSX4JrSEABES+WbuNahtueEb+/2rjw7Ha2gRqjeZzKaQofTkgvGlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpJiYhiZE9X9ThJpnGcDACjxNSvINlC1D7odBfGVY6I=;
 b=C/BgHyyKYUcMWdhL5RAC81ou4hglKTsCbOMw4OV/az0AL0oEGUI5HTS8oDUVf1YZta7532UyP/685/pzBEP00LTI+T2smLvAa0nhADvirw9NmVC2hTCgLMp61YkY3ivTGY4zaHT1RcsiF4LxsMSZ7bisLOghqCWlxmwKmMwoOy8NW9ug7tcjhHQ17q7UqG7iYFb9VP0EkrUfuowKCov0h2/3TwrtJtIzcsT4ts7sQCRmZfE2GmGRgNQQ2r97NGW7Jj9TuBDpBRTmM7US/qGcn12GgOabopL4IUjzclRt/aHFAOuspzET4jb38YLnzt/oETBNHs+sWjA3mRDXBsYCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 18:37:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 18:37:48 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>
CC: Lai Yi <yi1.lai@linux.intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Topic: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Index: AQHcWVsxJLpLQDG7FEKCpGfQ9oJdoLT8+P6AgAA5goCAAEY1gA==
Date: Fri, 21 Nov 2025 18:37:48 +0000
Message-ID: <SJ1PR11MB60838C2994B95989F71BEB58FCD5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <20251121105905.GAaSBF-XQZCXnR6UIx@fat_crate.local>
 <CY8PR11MB7134E82F2AFCEC97BCA9EE2589D5A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134E82F2AFCEC97BCA9EE2589D5A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7002:EE_
x-ms-office365-filtering-correlation-id: f8b6b949-1b6a-4220-2d14-08de292d1204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RVBFRHFrZElQTmdHNlNBeVFZVTZ3ejQ0ZEVBWEdHRXhQaHhRQ3pDMkswY2R3?=
 =?utf-8?B?U3FDbE5KRFBmei9jeEFZaEozMzI5dHpQR0JZTmV4ZlFkMTkvOXRpUFViRHBl?=
 =?utf-8?B?ZklFMnRTZTRsZnhtOFNGRjVWekpMSVBwbHpDaFFVSHUxWnY2ZzRPVnZ4UEc1?=
 =?utf-8?B?ZllCd1YyZERVSTRrRm1xWXkzcnMyRnJ3akw5VHF3Y1VZb0hqVXVqM3hOU1Nn?=
 =?utf-8?B?MThjQ3l6RnNkSE9ERjFHYWduL1UwTUExNEY4ZlJvc1FmNmpJSHNKby9OT3Mr?=
 =?utf-8?B?M2tlQU5CeFYySUkrRHlrUlFSMTJSMlpUcW10bDlEY1ZnakV4b3RLSTdmamF6?=
 =?utf-8?B?eGVNT3RObStxRGFENjhLQk0zeEl6YmNnTlRRU1Q5Q1QvbkEzMW1MQmt3QlFt?=
 =?utf-8?B?Vmp6L010WTkydGoyK1pCYmcwc1dLWi83S1NxaytOVVFZU2lQNXkvZFhDWHlr?=
 =?utf-8?B?OUY4aUFTZGZKMi93d21OMHJVUjA0Z3Z1TmhGdzA3NE43OVlkSGUvcE9tT0ZL?=
 =?utf-8?B?WlN1ZmhJZFRpS3JadW84OGVvQzhZaWJudlBIMlRnK1c2NnlSeUUwODZTT2dh?=
 =?utf-8?B?bzhQQ0wzUGQreWkwOU1mMUxUaWx0N2s4OU1kSGpCWkdQYjQyM3ZmNzloRmhS?=
 =?utf-8?B?Y0d3bzU2Nkw3bzI4aUZ1d0wveGtyU1NiV3Avbll2R0x6ZGxXR1hFaWxjMTJv?=
 =?utf-8?B?VGl4WUtBU2hHVUdpRkFLOWZjUno5KzdzWGVjRDRzYVF5VnJJTU5Hb2xyazgw?=
 =?utf-8?B?WHRjajdZZmFDU2hBTDNuOExJREg1ZDE1N20wb3JyaGhZclVja05HM2I1NURp?=
 =?utf-8?B?SXgxTWVmODRFQTBjZUU2UmNQaG5BUk5zNlZ1c2RlTDljQXNzdWpvVzk4Q0Zm?=
 =?utf-8?B?eXMyc0NHY0xYVnNJblM4bXhaMFRERGJMbnZkakl3TDJyZ3lvRlAvYTdoaU8w?=
 =?utf-8?B?ZTBzRW1tZ09Ndnd4OG1ablpxV0JIai9FOTgyNlpoUVlmb0FYa0RmUmRTdFJh?=
 =?utf-8?B?b3UzMDdjQi9hMkViL1RaWDBpK0FXbktCdHF4STZiUkFkZS9TY3RVb1FReFVy?=
 =?utf-8?B?TVNGd2tNZDdaRTdDYnhaV090d1EydEl5SXExZzVoWk9yUWc5OGR6MzJhYng5?=
 =?utf-8?B?SzdieHZ1VXhNTHJ1TFFFeUhoY3djOGN6UVg4KzZlQ0hSUkdYdVNaYzJBaFpj?=
 =?utf-8?B?SmR1TUo1SEVkNlZ2WjRHNVFoRmU1ZU5YN1hyc0hLMktBQldDRFNoWkpDeEM4?=
 =?utf-8?B?bGhkZ3hjSGtlVVdmR1RzTm8yWjIrckFMeHdnSXRkM0p0bU96WW1qZDZPdHpQ?=
 =?utf-8?B?SkNIS0lwUFNIUGNNbTBlNkVUclVoa0JOakVZS01BU2NUUVFYNC8yQStDL2Rp?=
 =?utf-8?B?alZmRGRXaUxlNG0wYU1SbVZ0ZEhLOEhHSlhOZ2hRWDJIOXE2aVRkREZDcFlS?=
 =?utf-8?B?eEFubUJ1UU9zbXFhaXY3Z3p5ZTAyd0VBVzZjdWNqOWZZa05hTC90SjlXWHd0?=
 =?utf-8?B?TGJ4Yy9MUXY5M3g0OVI0eUFMVjBDaWZOeDg3NjY1UDB6dmg1WjU0NU1pTUlt?=
 =?utf-8?B?RjBNeVRNTmdTWWJkeTNuZStIT3JUb3VPWFBDMWxkaWNzQVZVWFAxT3ZiTnp1?=
 =?utf-8?B?NDFGelpyVHQ4dzY4b3p4a281QitnSDNlR2h0cGMxa3ZDdFZsVUlZTk9LaDBD?=
 =?utf-8?B?VUg5NXIrUFNhSWlsUlUyQ0hlV3l1NDNJditWYWh4K0FlUURKUytYeHlON2JS?=
 =?utf-8?B?OGt5bThWRjFLQTRHamRQYXdvQTFsNkhRUkVHLzdtZGsxYksvbW5WcGpxOVlk?=
 =?utf-8?B?OWFOWGMwRXAwa2dWRm1pT3hGUHFhVlp1aXhUbmhTMFQ5UjkwOVkrTzJtVzcx?=
 =?utf-8?B?VHYwbit2SFpBMENTam9Edk1sMlFiakU2Ykd0Y3BQemRzVVNNdll1d2JtL3VG?=
 =?utf-8?B?ZThNWE4xR0ZTQ3hFeDRDOGoxUmFBbTdwa2pyMldGakZzZnVqL0VaN0ljdHg4?=
 =?utf-8?B?dUNETjhmVmYzNEJzb2gxdWR2aXNDM09IVXFpUnhjbHVQUVJSYTVZQjkrVy9J?=
 =?utf-8?Q?t1UeDf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTd6aUhZNjkvYlRmamh4bFdpRU1waXlRUjdUL3FoTE14RytRNzRrbGxxMEY4?=
 =?utf-8?B?Q2pjdXNYNWpKR3BEbENEMnowVVFhS3JJaXVQS3lLZWlrNmJuWXcwYnVLVERa?=
 =?utf-8?B?QlB5TU1Od3ZBWkEra3hqVkFXR1BjTW0xdkhmWW5JZkNhV0cySUgzYk1nNmQ1?=
 =?utf-8?B?dUNFeDZqdmtzRHIrR1hSZnUvNEVjVkNmZUVzSWhFTEVnd0MwR2VOZVJtQ0pE?=
 =?utf-8?B?U0V1UG1lemFuT2dHV29ZdmhTS0ZhclVkZG1tQnQwNXkxbXl4ZDZyK21lQnBJ?=
 =?utf-8?B?WjhiaHVDL1AzNmt4S1IxYk5mM1FTRnFzZUk5dGpKdmhEUjNNelduZFhUaVdv?=
 =?utf-8?B?STAwRDZjc0ZJMEovajRDcldNUXRmcWlhampzSlV2emxNUjJtVXdKMWFtMk1G?=
 =?utf-8?B?WnFIVzJBcDJaVnRqaC9yQ1pxdFZuak5kb0czRnM1cC8zVFBHZnROZWtLNkY2?=
 =?utf-8?B?Ymk0c1VCdEJnLzU1RmtkbmlHakJ3WkxVU2JXcWNtOWpRK0NJd3VqVEg5SEtu?=
 =?utf-8?B?SVhEMjRGNkFjeUdtMmRMWmJmQ2s4OUtOTTluY095b2U0ajVtK0hKYmcrcW9E?=
 =?utf-8?B?TmxwdldrMk5Wb1lxcXdCdmlyRG9LTjJkR1YySk5ZK3hLQ3ZiZDlhcTVyZGV3?=
 =?utf-8?B?aUlmaWVRYlI5cG9jMzlsRlk0Y3hLWlliZVJ0L2MvR2ZLMXNPYnlBTXNRY0lm?=
 =?utf-8?B?dEU5WS9HdEtoM3grajNnb3phai9BZkE0VFl3OEFBbU9uK2dzUmw1WjZMSHhT?=
 =?utf-8?B?RXpxNHJycFM4WGtZMUhuU3lRaUdCdFFLaUJaa2gzK0w5L3MrbDdpRDVQNHJO?=
 =?utf-8?B?bEZWdlEvcE9QOGhubnQ2WU45T09lTXVpZzhySGVKc1E0SW9vckN5QnVaNTFa?=
 =?utf-8?B?ZUpaWm5Yay8rc083SzUzNk1jUzV4bzAxenNydXZySHd1bjkxOTVnZG50Q1g3?=
 =?utf-8?B?TU4xTU4xbm9Rc2x5R3Azd0FZKzcxRURzN3paTlhrT3Z0YzhTRW8wSGFiakxC?=
 =?utf-8?B?QVNIYm51YW5URWRLNWd3VFNSa1dDdVRaZmdKdTJtMzAwVUxMWTBEZjU1bjl1?=
 =?utf-8?B?NHJWVHhCMkE0eEIrc0hyRkFoYUc5SzFZQWpoTk1RVWliTzY0dXVqMGp2TmJQ?=
 =?utf-8?B?ZVlCMXVxM3FYTUVyamdOTUV2VHliV1dsblVBejRDYjgyME9jT0tudGtNcVo2?=
 =?utf-8?B?TlVvZWJmOTZlTTR1dllpQzRrNWJrSUJhUTArNSszdyt4RFQyZWVsMnpYSm5K?=
 =?utf-8?B?emw1UkcwQWs4Q0tTYXJuZVFSYlhSRWppK1R6MlA0ajhra3dFQW92akZ3MGU5?=
 =?utf-8?B?QVdLN0VvbXQyVXFEd1dUT2pPN1ZmSG5ZakNaUzlySXRvUCszZkphODQrMHhp?=
 =?utf-8?B?SUFNK1A5MHRnZ0x2QUovWXJHdXUvalNDZ0NvbW1paUw0cThhcnlVbUgrekFM?=
 =?utf-8?B?STFuZkkrdzJ2a1lZdVpSRDIyVFVTNXVkM0pLTVk3eTMrT0ZFMFF1cHpFeksz?=
 =?utf-8?B?a3JoRGNndTUwUTRzOUNDM0EwNnFTRDF2VGE4K3lRNDZKdEUrT1dTTEZoOXJm?=
 =?utf-8?B?M2RZaWZ6UHBIRnJPdVR5dkJFYXAvN3ovZmsyS1g2MFdjNk9oRjRaK3ZnaTNi?=
 =?utf-8?B?OTl1eTl0N2E3VzhobVR4S1hyMEtpSFlaN29tOHBudjk5WHF2dTF3SEJQNEl5?=
 =?utf-8?B?UDBaZUVZQ0ZnZzF5YTh3RXF4L3RrM3dENmNEbFphbmJkcVA2VStTRGwyR1l6?=
 =?utf-8?B?Z1F3Z1pscUVSNDBjRHorc05LS3UxL3c3UStUYXo4c24vbFUxV3UyOU1pUTFY?=
 =?utf-8?B?bHRmTVd5U0ZRTHVXT1krUXIrRE5MNkZ3YVlWWEVwTG0rUVBDYU5DK2hkZ3h4?=
 =?utf-8?B?aFdVNWhNanZkSXJjeENjRFpQVGx1dVRCdkFmV1VFY1lBRVp4NGtCQTFvczI3?=
 =?utf-8?B?Q2V0TW5NdEpCemFyeThlUXl5T3l0QVNiZkIrMVIxZEZUV3FnNVpRd28yaUdt?=
 =?utf-8?B?RjVvVTFrUitKSzE2SG1Zb0V3OGYvUkxjOFVTQXBRR2pVMDVCV1QxWDZHL1Zm?=
 =?utf-8?B?bFh2VkNpM0VxSFkwdTIyZ1VKZlJjWEkzK0ltaStTYWVBVHdoRGY0aUVOcnBK?=
 =?utf-8?Q?CDovC2L5WvROWJVYEItuYS+Es?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b6b949-1b6a-4220-2d14-08de292d1204
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 18:37:48.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgjyiZtPfNorjaTfmDbjz+BpCxIL9CiMehzTalVnlqXzyROAqvqVl2vR4Sj1aaWR3JD7X7eihL+j9rxdEcBnWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com

PiAgICAgV2hlbiBDT05GSUdfQUNQSV9ORklUPW0gYW5kIENPTkZJR19FREFDX0lNSD15LCBpdCBy
ZXN1bHRzIGluIHRoZQ0KPiAgICAgZm9sbG93aW5nIGJ1aWxkIGVycm9yOg0KPg0KPiAgICAgICBs
ZDogZHJpdmVycy9lZGFjL3NreF9jb21tb24ubzogaW4gZnVuY3Rpb24gc2t4X2dldF9udmRpbW1f
aW5mbyc6DQo+ICAgICAgIHNreF9jb21tb24uYzooLnRleHQrMHg5M2MpOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIG5maXRfZ2V0X3NtYmlvc19pZCcNCj4NCj4gICAgIFRoaXMgaXMgYmVjYXVzZSB0
aGUgbGlicmFyeSAnc2t4X2VkYWNfY29tbW9uJyBuZWVkZWQgYnkgdGhlIGJ1aWx0LWluDQo+ICAg
ICBpbWhfZWRhYyBkcml2ZXIgY2FsbHMgbmZpdF9nZXRfc21iaW9zX2lkKCkgZnJvbSB0aGUgQUNQ
SV9ORklUDQo+ICAgICBtb2R1bGUuIEJ1aWx0LWluIGNvZGUgY2FuJ3QgY2FsbCBmdW5jdGlvbnMg
ZnJvbSBtb2R1bGVzLg0KPg0KPiAgICAgRml4IHRoaXMgYnVpbGQgZXJyb3IgYnkgZW5zdXJpbmcg
Q09ORklHX0VEQUNfSU1IIGNhbid0IGJlIHkgd2hlbg0KPiAgICAgQ09ORklHX0FDUElfTkZJVD1t
Lg0KDQpNZXJnZWQgZml4IGludG8gb3JpZ2luYWwgY29tbWl0IGFuZCB0aGVuIGZvcmNlIHB1c2hl
ZCB0byByYXMgdHJlZSwNCg0KVGhhbmtzDQoNCi1Ub255DQo=

