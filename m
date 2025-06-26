Return-Path: <linux-edac+bounces-4257-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B9AE93FA
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 04:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59ED14A3A6C
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0884199924;
	Thu, 26 Jun 2025 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy1F2O/g"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972354BC6;
	Thu, 26 Jun 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750904329; cv=fail; b=pTh+8IbRtdXDtHIz0EnloPhGB28Eb2lA+EFYaHA1W5ecHfTfgFTzd+nhe7sdMiIWtHKBgk0oKT9SrQl5c5o7DsI/u5MDjFiaN8AVWFOdFnzDLodcf4HN4wkLggxne7pkyLX98olZEbCYYec4WkwyCymcjHgy5bCq9jXHAGD1kXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750904329; c=relaxed/simple;
	bh=IFsMZb6rliqaAtbDVpTR6j06bIGtT9ARfsxfobEPISM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXoPtuKmpqSyuohbStQZ3f5NKGboCwHwF4J8BvXrx88qfN6n8BK46xuVvcjYwd31NxprtplWMC27YquTKP1y7tYsmmVXxraO2ZXSiu6mIwIicgYSITxP1YNxfHY+GDocHSBoDq/1keNUnQJlKySRiCtNryxDGY6Et0zue3qZmkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gy1F2O/g; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750904328; x=1782440328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IFsMZb6rliqaAtbDVpTR6j06bIGtT9ARfsxfobEPISM=;
  b=gy1F2O/gQ296tVGw0g15LGABmp1I7tusq83JK9XpgYVsvJC2W96NUyZl
   GZMMeayHkBOK13GgjI/imFXwNu9CfJWeraVSb5L1sswefZ3RyJuTL8uw1
   rl3xYbeo6dM+DwY/qaJ9NcbPgYM+basVXl7GfbWxT8GJ8diuKpdEfE8I+
   /wyym8YKwe5V2o1CmSlK6fCe4HDYfDnShJtDzkzom9V8BHzfYG4qe0sbI
   xC4xQ1O/vB3W0uOFTHL7zenIYD6mP+KfFmU7dlWaAkKxdpSKhwxDr+Eya
   tgTsLzFtD+ivR1iY3ioyuoRU4bnmSPwR8Cc+FOnCAg73jtqFD0VVonJEV
   Q==;
X-CSE-ConnectionGUID: GeyihaioRhCaiA71DDw8vQ==
X-CSE-MsgGUID: gKCR+HeOQcWBg1Bept8ocA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53286941"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="53286941"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 19:18:48 -0700
X-CSE-ConnectionGUID: jAAVSOhFSQSt06v9wo2nQQ==
X-CSE-MsgGUID: sEAvOClETxC2Hnn7yE9Bbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="151803449"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 19:18:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 19:18:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 19:18:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.75) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 19:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnqtVgFsAiSlkaskDpWl6R4l4gKQEkO6CGGtSavxCeU9JOCFjsZ32GvFV5kkRfvBSIBM/lvvPKJ5hPbaBBxbeGRAMqQiN1Qrfoz4D3n7nXKj8eLrm/ljg4rDmIBspUCe+och7EOSC51wLzNm92u00rAFo9OlgBkdsYQbc+/dc/YZ7BQwIzDenXFfIfNBfG2aCodKU64CAWOhjnC8ENl4kPFuMp1u3AuVu6bN+SkebvmBx0PIXncuT9p2GNvidfi1ZH+zuU7U58TREnMwYLOSbrXUC1axYKKd1PoLjjMgQn+z17qkd1rVwGCxYdHHCvapH4JePpvu3IFwmMiARRlXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFsMZb6rliqaAtbDVpTR6j06bIGtT9ARfsxfobEPISM=;
 b=X5S7csqaOCpONb3znC6MMBN94jkByie7M0AjiGgRCdbhsig6rQ4ODF5R21nXCnPh2Mx5TD1mcw8jj5Xf1QZMSLou7hg0lpL1s4lFq5hkCY3L8dVdaPQKWfRsZMWE8fFDyUru20oA6f6ZzsMRG/H9aEtiAqkhNDpYIESRO8/rstTcIZqzr7cSQf4meuGE1NsFfnSBcWweM6SF/thq/AHiUcl1IrYFuk+qEKGCcknF0ULq0DGQgH+nZqeYED+VTWBk5wyryeD8yp5I2O1qMBtviE7L3iHGcCGrHxtz283N8kKsdGwolEyAyKcnSqkoEGkhypYYP4DOsLKFr/fIjazbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB7451.namprd11.prod.outlook.com (2603:10b6:510:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 02:18:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8857.025; Thu, 26 Jun 2025
 02:18:41 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>, JP Kobryn <inwardvessel@gmail.com>
CC: "Luck, Tony" <tony.luck@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "aijay@meta.com" <aijay@meta.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH] mce: include cmci during intel feature clearing
Thread-Topic: [PATCH] mce: include cmci during intel feature clearing
Thread-Index: AQHb39GPjvEgUcfF40OPKhGrKGa9RLQUUy0AgABtOZA=
Date: Thu, 26 Jun 2025 02:18:41 +0000
Message-ID: <CY8PR11MB71349D25CD9C67B65DC5B849897AA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250617214752.178263-1-inwardvessel@gmail.com>
 <20250625194322.GGaFxRWqx0WbE90k6N@fat_crate.local>
In-Reply-To: <20250625194322.GGaFxRWqx0WbE90k6N@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB7451:EE_
x-ms-office365-filtering-correlation-id: 48d941f8-3d0f-4f49-62e6-08ddb457c50f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STNTdzhxeDY4SWhYai9xaVZIcmNoYm9BMERWTWs1NExOZzV1VzlVc3F4eSsv?=
 =?utf-8?B?R2dyQURFajgzUmpUellkNkxYdmc2K1M1SDdYRVdZWTFKSzBSWnFyS0MyaFEz?=
 =?utf-8?B?VUd3dVlKb29Uckg5NVNIVmorZ0R0WVdnSW0vZm9EVWNLcFI3TUZxSDlEcUJ5?=
 =?utf-8?B?djhVQWoxSDBLenRlejY5aVBWUWJwV2hxOUZvazlTZEpkSDM0Sjg0LzRFZHQ3?=
 =?utf-8?B?MVRtMFUyQ2lvSGRPVEFoakswbzFENTRQZVBsbGlPQnY1MzFsbmF0aVI3azE3?=
 =?utf-8?B?Ukt5dnJMRExHb1h4dFlKb2lmem51RlBPamdFM3A3bjBLTzBMdzdvTWs5UjVC?=
 =?utf-8?B?MmU5ZER5amFPNjNNZWJ0U0traElSWU5ua2wzQS9LN2ljVUd5ektwdTFDVjVU?=
 =?utf-8?B?ZW85YytBT29DSmlnNTZlVGR0UXFsczU1a2s4YkdIU29jNEFnMEE2ZzQwd2Ro?=
 =?utf-8?B?M3JYV1doSkxrdTJySlpOMFdTdUhobXdURXY5V0MvZFJlVUhYNDZvUG1PY095?=
 =?utf-8?B?eDNseFlwOS9mZWNJSHRhc0hRWWF6ZTk4dHhqWjZWVWpXVWd6cTFSTTdqSWpQ?=
 =?utf-8?B?VEdCWU5hdGRMUGVoVktvemg1dFViYmVLbWxMOGJFLzRDNGVDNys2SmtySWNM?=
 =?utf-8?B?eXY3aUpzYTM0SU9nRzlWVXh3UkJ0OTJ1UVF3YkhJUTZJUXJiLzdZbVNKc0Ry?=
 =?utf-8?B?dUQwUnhqWDZNL3loSUJPMERNeDdiMGdsSlNSRG5aSVZ3K3hVSEZHWitFN09h?=
 =?utf-8?B?WE1RQldwamFSMmFZbUh6czdXZUh6K1dRd2hGU1FIaGY1U0x3dmRVVUtpWjRV?=
 =?utf-8?B?aXNTZnhsM01TMHNLTjBjRWk4dXZmbEpuTUpQNkFNamJPVjNRV1F2QzlPOExo?=
 =?utf-8?B?MWtpSmhVV2piMlNwREp1c3prUEIzNXM5ZXpGQTlvMFQwb1Y2Y1V6WWhYczZM?=
 =?utf-8?B?aHFHR3UzRCtOdWhMTWJhZkx1WUR2SXZSQk5qZnFRWEFJMDQ1ZC9wbVMwemFi?=
 =?utf-8?B?K0Zad2ViUUVIcEprM21vc0xoV3UvZVQxQWJjY2dFeDlNc1RYVXRnN3UyYjdl?=
 =?utf-8?B?T0o0eDBFeWV5RVdCMnhTL1hXRmZUNjVDWXpNd21NUlRjWmwzNWIydnhTeFd3?=
 =?utf-8?B?ODBKaTJObEV6U1lMU1NoZytsN2UzdkVrN2V0VHU3blZnMVB3Yy9qK2dybXFQ?=
 =?utf-8?B?cFJhRWFWdkc1QWNya3FkU0t6bjlPWnlLandwb2p1RUNIeUNlTFptTzNsVVk1?=
 =?utf-8?B?M280WnRKWHIwVTUrT01TMktmbFpxQXdQdS9ueC94LzVZd1lVVGw5eHNIaEo0?=
 =?utf-8?B?QUUraTVkd0k4V0xQWS82Q0VYVzl0Y2t2ZXFBbzFlUWVST3Q2d3pQa0JYRTMv?=
 =?utf-8?B?RjNSQWhBN0pWZnc0aGJpVHI5eEY4NE85aFVjcWE1SitBOU1nZEhxVlpTbVNs?=
 =?utf-8?B?V3k4eW9xSGdzQ3FVK01tRVlsb1RuQUduUGk4VlR2d012Si9YTmZUdlNTYnlr?=
 =?utf-8?B?ZTFiUlZscVQ5RWtnT2lBZUZGVUZmYlArbjhXWm94RTFTem5BdGtOaU5pckdm?=
 =?utf-8?B?UFRsVVQySjBaekFBSG1FWWtTMmVKeW4zNWdVRjc3UFJ0RHdheFFLWERIZ2pq?=
 =?utf-8?B?a1gvL2xCRTdreWFaWjVKMEx3S0pXVU03VGpFQzJ1NkxWV0xFTlpQSmZ2eTlT?=
 =?utf-8?B?aVFRUE1saVBwTFExRTM4Nkt4UkFBbGFNWHFseWpqek9KN2tNUndmcXJ1Sk52?=
 =?utf-8?B?eWY2ZDVlZkRwSHBCeUJLMTllZS81a3V0ZUVTbmxNcnJYUFFROS9qVUxGbHJz?=
 =?utf-8?B?UTRza0tpb25ROFNEOUF2R0dzTkJiS3hQTGljVHZyV0l2cVZSaERVM09ETFFi?=
 =?utf-8?B?cEZydHBXM21IdUlxRXg2ajBneFJBSXZzdFRWaHd1VFp5MThSSUs0My8zZ1Vn?=
 =?utf-8?B?bDJOOVU1M0VpMXRKWS9uTzN2R1lqSDlqTnFKTVJnTXZMTlZQMUk0b20yUXc3?=
 =?utf-8?Q?VNs9+arvpuCcCAJHtEtIsanWH4l7Vk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHBwY0xwRTZ5aGRaMjdpQWk3dFZ3UDlwZlY3MVlSWWtxTU0vcmlvL1NLd01I?=
 =?utf-8?B?Q09mYUMycy8xZC9iMi96OVc5M1F5ZExWQTAyMG9ISmZJQmxkSGZsS2NsbTlR?=
 =?utf-8?B?cTBnSERYVEhWUmJ5TnY5cmZETWRGcXhBdTh0bmFwU3B0bGhiTkp5Y21UaDly?=
 =?utf-8?B?L2VTT0VjTFBaSG9USkFqb3hSSmtRZFdia1hKZEFFbk84NDE2V002NjRSUjRy?=
 =?utf-8?B?VFlrbElOTUhzZzUwTyt3aThQd1RxWjlZK3Ezby9ieVhEcGNacTdQdXlHTVZK?=
 =?utf-8?B?UHFkcVBUM0NZR0YxdXpLeHBPbEF1bGZicjgzWHpKcHN4UHI4dU9XZHYzbTZv?=
 =?utf-8?B?d09HY0hwZjdUbHY0NVVrWUU2VGgwQm9Rd2RWNWorc1BZQXFjUnZrcmNFUkds?=
 =?utf-8?B?MzJQRFcyYkFLYWMrTnYxdWk2cEtWaUlpZGhsK0hOVXFTMjcwNlFTQjlUaWN6?=
 =?utf-8?B?UTJVRzRWV2x2dWRKWmV2YXNZQ09wa2xINjlDdWFPTC8wVFUzdjlwYWxQRzhH?=
 =?utf-8?B?RFo3MW9Fb2ZyZ1ZLT2JCUkt1ZEZnS3dLY0p4SDFmNGNsMU5PTnhiekdXUXVl?=
 =?utf-8?B?SlJwMnNDQUlyRUI0YTBkNHduOEs1RFdTNDBKQWluZ2gvdFN3UEhBQmFDWlJx?=
 =?utf-8?B?NDlZQ1l5L1VEaktpdHpHTVQ2K2duTWszWUNmOTlqSnl5ZzkwSXFZdmYwclZU?=
 =?utf-8?B?MXNhNitaYS9ZMmFFWXdNb2Uxc0d3MEdYY3VocHNOY211cjZwUE5xZTJkbnlw?=
 =?utf-8?B?RHlzMnFsMDZxaHkza1lNWjRsZ0RIampuanlNMUdNVDZOZ0FOWEVrei9TYjV0?=
 =?utf-8?B?R3hMckdoSGEyS2ZmZCs1SkdndUd2ZGV0S0F5d1hrbmRITWNlZVp0VXJDb0Y4?=
 =?utf-8?B?S05NbDBRaG81NGg1cFFXa0dyRVorOEp4MFdNWXg2bUoyLzFTb2RvNTJLZGlu?=
 =?utf-8?B?bHhCSk1HenRsamRSSDFQczM2cGRjNmRUOW5VOGtJRDg4VE1PbU9PQURGdnpo?=
 =?utf-8?B?TTdNMXBFWkQ0ZVlBNDNHTnVmWGx0OC9naXE5ZHVyMVJEMmlEU2gybjM4b01U?=
 =?utf-8?B?WTZub1FxRjlwYnpYeHpENzJBNE8vRGV6K1ZNTnpVa3B1SFUrcVVHZW9RK2dB?=
 =?utf-8?B?UjhXRDRjZFFxR1B1RVV2N1JDQ0M3K25MUS9mRHQwYmFRaElSWTZnNUNkWnJm?=
 =?utf-8?B?K3hEY2o0YmhiYnB1ckR2VkpLRFQ5T2s3NlJTY3l0ZTMvdDAwckNkZUdYbnR3?=
 =?utf-8?B?cnhYTVlpbmp2WG12MWZOZ3RmT3h0Q3FVS2xvU1NtVFNrWHFPc21Ra0oraldu?=
 =?utf-8?B?alN1NzdQWThTcWF4QkxNRmxtSk1mUDFEVnY5NmVjeEd5SUQzMmI2V2ZNRkJw?=
 =?utf-8?B?WWtJb2ZZeUZBb2MwVGI3UUVIUG5BVkNZaUpaeGEvU0lsbFg4MDZ4bm9ZOVhP?=
 =?utf-8?B?S2lEQXd6OFd0bGptVkNWZlNQQ0JFaklkREk0VjUyazIwcFhyZTByNzUvZVgx?=
 =?utf-8?B?VXBuWUN1T2dxTUJaR0swdGR5UHMvai9oMXl6QjZTSXNHM0NzYjd2a1FYZTRS?=
 =?utf-8?B?M041T1ppZWNyd0wzSjhKUzBPUG1xakh3eG9wVkFaOTNNWGJmWnR5cmxIV1hD?=
 =?utf-8?B?dkJMeS9lLzFOaUl1Q2Ixb1BoMFROWVlSUjZlK01OS0U4Q2dHSGptRTJrbjE0?=
 =?utf-8?B?TlZtbTFDUFNEUzB6WHdTZ0hPcHJCMkhEdi9NQlE0U05odnZUMFlRaWE4SzBS?=
 =?utf-8?B?K080M3VBTE5XWlBlYmxmZTRKc2VYdVpHV1U2Vk9xcXZpNStpQ1BLSXpoTWo2?=
 =?utf-8?B?SnliUStJNWNtbHE3SFc5TmlqbjE1SElGa1Z3UFVVaHRBdzVGaUJUbTlsb00v?=
 =?utf-8?B?VUFTOTV5YXFSVnJEM041OGsrMmhWbzdmSHcwakRLK2RmK1g2ZFBVa0VDalAw?=
 =?utf-8?B?SUxYZ0tWNjlVandwQllKM2xyNmxJRGNNankzTkp6WCtTWGNieElUY0pqcTN3?=
 =?utf-8?B?MlRZa2p2ZDJFUEw5VVlqUnlQcGtoS01xanRGZ3c0R3BobjZZNFQxazgzNGMy?=
 =?utf-8?B?eEZJZXlNZTBrOXp2QjMvVjB0aTc3Vk9WdC9YbWp1ZWJ0L1c0U1gzVUNNWDd0?=
 =?utf-8?Q?0M1PYqRF2F5EMV3Wl0Rr6iplY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d941f8-3d0f-4f49-62e6-08ddb457c50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 02:18:41.7213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIJbOTOcqnTVHsPSV4WTjVS5VTfcEg6viFP79RvCmb2u4uvyTgJJnqGBnJNVAKb9PMw7UDxg93Vnv/jXB2yudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7451
X-OriginatorOrg: intel.com

SGkgSlAsDQoNCj4gWy4uLl0NCj4gPiBKdXN0IGZvY3VzaW5nIG9uIHRoZSBmZWF0dXJlIHBlcnRh
aW5pbmcgdG8gdGhlIHJvb3QgY2F1c2Ugb2YgdGhlIGtleGVjDQo+ID4gaXNzdWUsIHRoZXJlIHdv
dWxkIGJlIGEgYmVuZWZpdCBpZiB3ZSBhZGRpdGlvbmFsbHkgY2xlYXJlZCB0aGUgQ01DSQ0KPiA+
IGZlYXR1cmUgd2l0aGluIHRoaXMgcm91dGluZSAtIHRoZSBiYW5rcyB3b3VsZCBiZSBmcmVlIGZv
ciBhY3F1aXNpdGlvbg0KPiA+IG9uIHRoZSBib290IHVwIHNpZGUgb2YgYSBrZXhlYy4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBjYWxsIHRvIGNsZWFyIENNQ0kNCj4gPiB0byB0aGlzIGludGVsIHJvdXRp
bmUuDQo+IA0KPiBQbGVhc2U6DQo+IA0KPiAgLSBzaG9ydGVuIHRoaXMgY29tbWl0IG1lc3NhZ2Ug
LSB0aGVyZSByZWFsbHkgaXMgbm8gbmVlZCB0byBleHBsYWluIGluIHN1Y2gNCj4gICAgZGV0YWls
IHRoYXQgbWNoZWNrX2NwdV9jbGVhcigpIGhhcyBzaW1wbHkgZm9yZ290dGVuIHRvIGNsZWFyIENN
Q0kgYmFua3MNCj4gICAgdG9vLg0KPiANCj4gIC0gcnVuIGl0IHRocm91Z2ggYSBzcGVsbGNoZWNr
ZXINCj4gDQo+ICAtIGRyb3AgYWxsIHBlcnNvbmFsIHByb25vdW5zDQo+IA0KPiAgLSB3cml0ZSBp
dCBpbiBpbXBlcmF0aXZlIHRvbmUNCj4gDQo+IFNvbWUgaGludHM6DQo+IA0KPiBTZWN0aW9uICIy
KSBEZXNjcmliZSB5b3VyIGNoYW5nZXMiIGluDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0IGZvciBtb3JlIGRldGFpbHMuDQo+IA0KPiBBbHNvLCBzZWUgc2Vj
dGlvbiAiQ2hhbmdlbG9nIiBpbg0KPiBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvbWFpbnRhaW5lci10
aXAucnN0DQo+IA0KDQpQbGVhc2UgYWRkcmVzcyBCb3JpcycgY29tbWVudHMsIG90aGVyIHRoYW4g
dGhhdA0KDQogICAgUmV2aWV3ZWQtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29t
Pg0K

