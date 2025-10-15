Return-Path: <linux-edac+bounces-5050-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735BDBDC02F
	for <lists+linux-edac@lfdr.de>; Wed, 15 Oct 2025 03:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C0C1922510
	for <lists+linux-edac@lfdr.de>; Wed, 15 Oct 2025 01:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A72FB0A5;
	Wed, 15 Oct 2025 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPUlMJIE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7D2FABE1
	for <linux-edac@vger.kernel.org>; Wed, 15 Oct 2025 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492546; cv=fail; b=ixNrdkGLmF0IZd15ncchsezrmKQR1oVmfnacKvj40ImiCplDrF/lr3w4qF2bCFavNoWueIx/Ksru+Z34MPPWVmhsjcwdNVf0vCdXVoUeVV6hAMzNIrKVVzYp/Su2szEcgVvYCBjMEPRyXEM5q1zuprL2KDLko3tDBlT/LqXToQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492546; c=relaxed/simple;
	bh=wJIQ//1jTGh5s9cikhqsny9ehgliN4b7WHcTc4tFqIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glEco8Dp7s/s4XqeA3tZLIXBotW5MKWeX0lW1J8nvGlkqCACLHChis8zPb9iBuoSwC5J9JDqg2I/ri0A8NN2pBO9+u6Dxgai4VPjgUGbr9VFZ6ZfR5M6E0FcWpdr5V40xJBxBwXua95iovlH0K4ZoPVvM/8WrNvrbJuOC2A5BRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPUlMJIE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760492545; x=1792028545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wJIQ//1jTGh5s9cikhqsny9ehgliN4b7WHcTc4tFqIs=;
  b=DPUlMJIE1CGW5dH8l7nNkFjdU4kC7s5f0VwmOusUP+zybFvzU1GBrMhT
   1RKpwgzcNZ9caINpc3pt0O7TpdrOU6mRKPNGVZqGw/+MoJf9fFrSxqMoN
   BUm+ypkQatXCxGGTwOesyE5/XqKmgCbL8Jd2n7TGiBJe9kGfZi6Ta3WuX
   K+19GgdJbXcOsRoAH1TnGgMjMduf7eT8o4tZl/lEkrJJ5jo+Mh4PCVhRA
   SswJ3+ffe6FrGZlOht8HUs6VSkWYczESlhk7SMGstAl5OWh5pV4uEXlD+
   rCrsmlFva7ScMq2xAx4j/tRzg/eGG3nU9lKA2cTwQbaqhg5yfJTd1Ei83
   w==;
X-CSE-ConnectionGUID: DqfyBVZVTRGKrwkQpJmmxg==
X-CSE-MsgGUID: haQe8Y7AQXih8chAeklZNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62696853"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62696853"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 18:42:24 -0700
X-CSE-ConnectionGUID: SK4p/KSrQyC5kAhefy8TCA==
X-CSE-MsgGUID: fqKg/TrsRj6YgQ0ShBpq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187343685"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 18:42:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 18:42:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 18:42:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 18:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP0NgrktI1go8y69pvVq3xKdNrdLag7HpGXJNP7T06I7rrEEMQ/9od+lIvgeHZc4jR5n80Ayvkv5BqylD+3QA6Q0467W/awnLVtD5io5nUIzLSSMq4klcP0Ccu/+5+cpZ+m7RGjBKJWLpWRQBvxzMHVcTJTohkmSwdThfxXOZpw+3l78BORC0sCQ7BaG3CI7C3zJGEHBjEJJA5RzbtSj7x0S0oR1R+B7GbavFgVE5W8QTpHq2X5h/cgXSJKK2ce+JwtR/+tt5nHquYoYZ49KyZfo6XTFxdeedeGEfkugG0jotHX2c/xeFZEdLSTxc/xhs7G56ECVDZSuNcEFyz1RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJIQ//1jTGh5s9cikhqsny9ehgliN4b7WHcTc4tFqIs=;
 b=q4WRRUFnbz9dX6SzDbd7MQmylaiXr7DOj9t+Bjv8q3jm157H+ma5b4z0Bbq20rROFjX4LUHaaYxrp9dva8fxbloezgNWVajL6VNlZrRGivEDPGOw745Ur7ULJdEM0Y6nMKMgklfPoxfHTzRcSvLrrUVDOUm0VtXW7PsXNTHc9i2YaWM0kHYuIPPAdv4ZFDzHBatfqwoZAkvITzin/OM432rQ/FZ+cDoBmURlMNjLFSHxGuDv6oMf9nndgzS1KEB1UCkAAAemFnLvlh2Zr3kk3XgrsTe4dh/41lHU/6Rj+MUd3SRU6fe6SvPJ0YYh8FIA2Ipvxw8CNusYHyL2D/KzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 01:42:21 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 01:42:21 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Matt Corallo <git@bluematt.me>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] EDAC/ie31200: Add support for additional Alder Lake-S
 CPUs
Thread-Topic: [PATCH] EDAC/ie31200: Add support for additional Alder Lake-S
 CPUs
Thread-Index: AQHcPR88uG+8H/Di3Eed8RifdNWDtLTCbslg
Date: Wed, 15 Oct 2025 01:42:21 +0000
Message-ID: <CY8PR11MB7134927522BE72D9772314D889E8A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <8ae4f35a-0cec-455f-8f2c-ce04fb99aa40@bluematt.me>
In-Reply-To: <8ae4f35a-0cec-455f-8f2c-ce04fb99aa40@bluematt.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5129:EE_
x-ms-office365-filtering-correlation-id: 9e72806f-a5a2-4ce9-0058-08de0b8c153d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OUZjZ09tVkI1cGg0L0hZVFJvbVdrQVNHVEordUlTbEJ3dnBaMitQZzR0dGtp?=
 =?utf-8?B?VzBJQ3haT3dmNGp2YUVmVXdwVWMyeFFlb2RkeUFiYUNOQzgrcFNSS2toZ1d0?=
 =?utf-8?B?MTFtSW8vMExKQjhVK2c0eG9qQThWYmNnSWZyb08xK2R1WXViamlEeHB4dVNE?=
 =?utf-8?B?L2h4dkw0NUNXRmVVcEZ2YWhmazZFWTYrU2s2NDljS0NGVit0VS96Wmg4Mmxx?=
 =?utf-8?B?Qkx0S1JnUkZMQkxIVWpYMWJQcmtEeE16YklLY2R4VGs0OTR2SFRmeG1uOFRN?=
 =?utf-8?B?cWtqZzBSMmR6L2oyRFdGMklCWldwLzhsK2xPK2lYa0lBQVVMMGxvRjA2TGxo?=
 =?utf-8?B?K3E1SWgrNllyakRhYSs3bW0xMC9ZWnIzMlRlSkQ1SjhldWcxc3o3TDhQNWo5?=
 =?utf-8?B?YVU5WXR0WUQvU2NIMDVXanlrNTZuY1NiWGZ4WUYrK1NFSkEvMlBsV0Q3NjdQ?=
 =?utf-8?B?N3hkSmNWWW5oQlRNNGlJblg5c3UwWmFEaklpQkw2WnhQdVp0TnBZWFJWbXNr?=
 =?utf-8?B?T0ZLaFFzL2RrNU1xVi9NRkRZdCtRVFlUb0NLZ1dIVi9xQlBkcGE3RkF2dUZ2?=
 =?utf-8?B?RVk2c0xmTWhEODNHWmtVSjVZc3FxS2t1UGRLSE00SURsbHVFdUg0THlYb2Rv?=
 =?utf-8?B?TTdYTkN1aFZTOEhtcXN5VG1xSTR3bzdSTVRhSFpuV0ErbHZwektsSk5LaFVJ?=
 =?utf-8?B?V0hvM2lRdUZnOTFObC9GZFZzS04rTnhURGwzYVgxeFE2QjFScE5KVUJoMWZR?=
 =?utf-8?B?OHAweTNpdzk3Zi9Xa0FiOGFqNC9qdU0rTjNPZ3QxS3djdlBHK0hlWi9zbGJ6?=
 =?utf-8?B?OHVyWHRKbmdUNDZTblRuZ0Y0Q085aHJlakJtWEI0MjhLcW1oblZwMUx6ZTZJ?=
 =?utf-8?B?YzdBdUU4OUJNYXlmdkd6czR1d01vU3FHWWZDalc2ZElUR2VCNXlENitlK1VT?=
 =?utf-8?B?ZmZqREg4QXVXR2l6eUZwODBFbEkyN0xtREFELzIxSGZGZU1RMGlSb1lMMVlN?=
 =?utf-8?B?SHR4U3R6Q0dlN0k5UjkzWHZLV2g0L2VhaUdDTmJHK3luL2dWMnFRSHRXWUcr?=
 =?utf-8?B?aFJvWGNjT21tTlRzRXZxc3hrNTFtRUI3STFyQ3FaeXVlZXVMQjByZXJLOEVv?=
 =?utf-8?B?L2JLcXBBS1ZMSmx2WG9wSlhuNUxqWWhUa1BwOHIybVFTNjhBb0kyOEN1d0VU?=
 =?utf-8?B?b1VETG4wMFRDdDRQZEVHUS80dTBHSHU1U2pHSzN3MDZJbTVCbjVEUHJ2Rjg3?=
 =?utf-8?B?Vm1SVmdTdHZteDlkQnZCRmdhMUJsRlRQNUpabU5abXQ0T2pzeWU5Vk5aVGxm?=
 =?utf-8?B?Y3JObkgra0dnSVpvbmN5NTVpRkFFVDlqQ3ZqMFYzdTFzNG1CWUdwWWVQQ3pv?=
 =?utf-8?B?OEplY1JjTzlhR0NrUlVvRU16aFpYcGFHclpPRWtLR3EzbnZKbnY5c2s5N1NQ?=
 =?utf-8?B?RUVvOElIODJRWGJmVmhKdDF4YlYxSWtJMW9ncmliTnNiamY5cUJkRDBIbmN0?=
 =?utf-8?B?czdEdnI5RDdmRzBTbkdaOEl4djJaa3htM3FGMkhLZ1BwaHBSQTZjWmozNDlh?=
 =?utf-8?B?ZVdJOENlTU9YYUdrQSs3ZkJBQXZuejRaRlE4OGdQMTFRd05GaGpXTDIyTU8w?=
 =?utf-8?B?d093Y2xjclFoMmo5VFRtTTV6LzhzVGxZYTlHV1ZnUnVKUHczeTIxQVZkZWRs?=
 =?utf-8?B?aVprSkxLdmFuSzQrOHBIR2Fra2x4OGFvRkFmakFIdFIrVWttdDNRUThjRk8v?=
 =?utf-8?B?dnVGUEpGaC9hZ2tZczlqSnJyRU1qdEEwaUs5RjVCeDU0K3hMTkpRR1VYZ1lw?=
 =?utf-8?B?Y0c3TWxvcHEzNXVrT01lRmdlbXZYak5NaXp5TXJIdkJmZHVJNHB2NlhlV3dH?=
 =?utf-8?B?RGE4NGl4TEJxQXFGVWQrK0U5aVUzdE9SS01NcG5ZTkVUb1ZNaHo5UlQvNjNk?=
 =?utf-8?B?cHFEUEtuTlJQR2NjcE5IWVlCRVRubXUzOWJIWnVmR1VpLzNDVm9ra2xHL0lG?=
 =?utf-8?B?QVpMTDc5UGNoSzVaL05QeXI5ZzMxU1k2RGJwUm1kUSttWS90QU9PMzA1K0Ew?=
 =?utf-8?Q?MU/4le?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdIYnVXdTBZU1NTRkIzQXYxREFrSUhoSGE3eHU3UFRNMWlkbnNXRTg4MlJK?=
 =?utf-8?B?Ty9IdlJHa3FrbmtIbFg1ZTRGVjVZL05MYzVLaER3OVB5ODZoU2N4UHVUUDB1?=
 =?utf-8?B?ZkhNYXlDRnZKaFY2MG5GeTVUWng3aVF3V2VRbFViR0kxdk9KekptVnQvNUda?=
 =?utf-8?B?dC9OZHh6cGxhYXg1RzFLR2NISTV6eVBoUW5Tbzk2bUVaYTljMVBLUU82NDhQ?=
 =?utf-8?B?Z3Y5TUdhYlpOVFpHb1VSbEZ2NCtyblJzdXR3dllvMEl3VkFMOEw4MlpMcWlM?=
 =?utf-8?B?Y1BtMytzN2p0bmxmb3M2WU5ESnJsMzhZSzVqdUN6bVhZUzQ5U1QzUy9jSGtZ?=
 =?utf-8?B?TUpaaSt3VS9CSytJOXhqYUJvaEhTd00rZnltOXlEWXFtQk9PejMwWkk0d2NT?=
 =?utf-8?B?WlVXYkRhcTF1UXZiRmgwYVhxeTcrano4OTlXMlptQW5pMWZQR1V0VGxQdmFY?=
 =?utf-8?B?cXVWcTh4MGdyVUtiMXFocThNSlhDdVI5SytvSFZaRUdGbVRWa3BVaWFIMUlI?=
 =?utf-8?B?cmovd0hKWHRZSzhHdm9aRE1MRkZtMDRHRVNhc3dlb1ZSbnFrM3NFVGROcUdn?=
 =?utf-8?B?aWpKaDYwRkxrZ0Zwc1NzTHFuaDV1QXNKNnFVKzFNcGd0SjBqZy8yeUgyVXNk?=
 =?utf-8?B?ODFqR2RMNG1WMmNUcXRSUExwOGhVVDlOd1lKV0NSK3ZtbW91YlFvQ0QxZG5q?=
 =?utf-8?B?aVZxRW5hekRMOG84d040cjF4Z3lFSnIza3JaSmcxNUpsTlhFNWlaV1VtbUVD?=
 =?utf-8?B?WUJMdXpVTjZVVlNMak1leFhkc1FLRkRNcXlYVHVNbDBVUFA0NHdOcnNnUWhY?=
 =?utf-8?B?eU9nMkQ4VEFJNlJleGl6b29selFseWNBSlFPQlBFM0JmNDBOaENMYTk1OHRz?=
 =?utf-8?B?NXV5TktuaS9FdC90eEx1am8zdDlqYWphamhPMEdWRXh1cHB5bVE5b0JpZlcv?=
 =?utf-8?B?aVlWaEpMbFpISzIxc0I2MVcvM3dOVTFSSVZYSWxYd3VFOVh1VXRselNmS2hF?=
 =?utf-8?B?MzdaUEROTVBtM055SktjK0ltd09CazZKMDFWTkltR3VRdmhkSTN2Wkd1cTdH?=
 =?utf-8?B?cDF2TzhzeEwxekhPMUo3aGdZb0JCaWNwbmhxcjJZV2Q2aTM5R3E4VjY2Y3dr?=
 =?utf-8?B?bTlaRGlLWDNBZlI0aDVDb3ZTMytubWp1bVZYa3lEMHg2OEFhSVRpNkloOFds?=
 =?utf-8?B?cXdCRERtdnRWR1ZOMWx1Y1JBUWVZNzhmQ1UzZC9SMEx5VWM4YlZWSmc3WEMw?=
 =?utf-8?B?ZzhLUzN6ZUtYMkZkUUMvS3VGTHZUbDJUMW14dEg2cHpseW5oNEc4L0d1elNU?=
 =?utf-8?B?RXFWRUNFTERRSjdLdzNIdXErcllrREZmM3BNRVNla0c4SGIyd0tiOEdKRXJz?=
 =?utf-8?B?MmZTcWlITGtVcklDQzRGSVliOU83R1RVSVVOdFA1aDhZaHl0QmI0b0xPUEU4?=
 =?utf-8?B?SlJCd2FvVTBEdTB4MzdsaGNFS0RFTUI4RUZtdDdlWXp1UVJEMGx5ZGljYVZk?=
 =?utf-8?B?OXJTVFZkeVVZTm1UNzQ2L1ljdjRFUUxPSFl0SUNtMWorek54VnlvWFROSXJQ?=
 =?utf-8?B?V3NVZk0xZkU1WmxFaWFYYUpQYm1KVHM0MENpanVIdUMySmZmbHBGRVJUZEZr?=
 =?utf-8?B?MHZvbmczemt0M2M3VDBjazRvdUExVGtoNFRHVXVkdDNZUFBSUXVsQUF5WkdS?=
 =?utf-8?B?RVZVOEFYSXgxeHJkZDQzTmF2MThBMWpacndYOUlTcnM1VmowcU5ZTWxhbk92?=
 =?utf-8?B?bCtPZG83NFQ1NURTaS8rTkdhL043UnlWbE5Md1FiY1U4T3lCN3cxdFA5SWJa?=
 =?utf-8?B?TWtGNk4rQ0J4eTQ2LzlkOVhORzhBWkNHaU5kK2xLUjlXYkxZd2FxdEc0VGIx?=
 =?utf-8?B?RWxncEswWGJObnJoTUh0SHVkL3VBWUl2WjVxTFdpZlJKUUJVT2JzTEovMHQz?=
 =?utf-8?B?N0dsMmY1Z3BLVG1DWHBUNGUrNWZNTlBDbmkwZ0JHOVFiZDJaTFNSVis1OURr?=
 =?utf-8?B?di83a2xheC81V0RYOTVudVNZWjk4ZFl6anhMenlmYTUvcmgwRWN5QzN1QzlN?=
 =?utf-8?B?aVlHWmE5OFZYWGIzYnUvUnFQS3pkaTdBbHROWjVvSGh5TE9VT0hBcGsrYXVh?=
 =?utf-8?Q?r+MEkZ+encCM6w3h9B2aOyCK5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e72806f-a5a2-4ce9-0058-08de0b8c153d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 01:42:21.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qyL+J7kn5qmwN3PCbSlFayKT8PryzMDAJPxh/Y881AKpfmijfes8GtpKXCdgpqq7ygRXchpV24ScqQJXRb1cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

SGkgTWF0dCBDb3JhbGxvLA0KDQo+IEZyb206IE1hdHQgQ29yYWxsbyA8Z2l0QGJsdWVtYXR0Lm1l
Pg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE0LCAyMDI1IDEwOjU5IFBNDQo+IFRvOiBsaW51
eC1lZGFjQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIEVEQUMvaWUzMTIwMDog
QWRkIHN1cHBvcnQgZm9yIGFkZGl0aW9uYWwgQWxkZXIgTGFrZS1TDQo+IENQVXMNCj4gDQo+IDE4
MGYwOTEyMjRhMDAyZjhiZDE2MjkzMDdjMzQ2MTlhNTYyNjg0MWUgYWRkZWQgc3VwcG9ydCBmb3Ig
c29tZSBidXQNCj4gbm90IGFsbCBBbGRlciBMYWtlLVMgU29Dcy4gVGhpcyBhZGRzIHN1cHBvcnQg
Zm9yLCBhdCBsZWFzdCwgdGhlIGk1LTEyNjAwSw0KPiB3aGljaCB3b3JrcyB3aXRoIHRoZSBleGlz
dGluZyBBbGRlciBMYWtlLVMgY29uZmlnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBDb3Jh
bGxvIDxnaXRAYmx1ZW1hdHQubWU+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZWRhYy9pZTMxMjAwX2Vk
YWMuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2llMzEyMDBfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2ll
MzEyMDBfZWRhYy5jDQo+IGluZGV4IDVjMWZhMWMwZDEyZS4uMDEwMzE3ZTMzNzM4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2VkYWMvaWUzMTIwMF9lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFj
L2llMzEyMDBfZWRhYy5jDQo+IEBAIC05OSw2ICs5OSw3IEBADQo+IA0KPiAgIC8qIEFsZGVyIExh
a2UtUyAqLw0KPiAgICNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9JRTMxMjAwX0FETF9TXzEJ
MHg0NjYwDQo+ICsjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5URUxfSUUzMTIwMF9BRExfU18yCTB4
NDY0OCAvKiBlLmcuIGk1LQ0KPiAxMjYwMEsgKi8NCg0KVGhlIGNvbW1pdCBbMV0gbWVyZ2VkIGlu
IHY2LjE4LXJjMSBoYXMgYWxyZWFkeSBhZGRlZCBBbGRlciBMYWtlIA0KY29tcHV0ZSBkaWUgSUQg
Zm9yIEVEQUMgc3VwcG9ydC4NCg0KWzFdIDcxYjY5ZjgxN2U5MSAoIkVEQUMvaWUzMTIwMDogQWRk
IHR3byBtb3JlIEludGVsIEFsZGVyIExha2UtUyBTb0NzIGZvciBFREFDIHN1cHBvcnQiKQ0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwODE5MTYxNzM5LjMyNDExNTItMS1reWxlQGt5
bGVtYW5uYS5jb20vDQoNCi0gUWl1eHUNCg0K

