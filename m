Return-Path: <linux-edac+bounces-3101-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A2A37BE4
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 08:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A781689C7
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEBA18DB1C;
	Mon, 17 Feb 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHLbuN6E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C818188006;
	Mon, 17 Feb 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776319; cv=fail; b=AZSROQHCJA2DnCJEVSQQhX2RZgdqcoOi2xzkWeANJS5fkxAh070zI75vyzGz/gTlYpppkGGSnI4gqZZ5g9myS7j7aO5cSCvr8hIm+hl9mO0trfOBBi/TWvh52y42mPmTQSrgkXOPuR/mDw+Bc9n3+X/lluZU2ZrjwoFIiBwJHag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776319; c=relaxed/simple;
	bh=VJFaXPI1s8WgU4u9RaAAze1QfPoh6sEHi2xVP02t+64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Baq8VRA5jI+hSVEWezAs4P/vuhr76br5XVhZ330Yj75UwgSF3HPtVYolzCqlQJwOmkKlqym/5awadhy9QQknLXZ5y9JgAa/pdSH7hurFeO1UDp5RRAR2aUv9jwO7j6VfyEQVVd1T5GyCXqdaQPpBsfzt5gt3mGOtHJxyc/gpQz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHLbuN6E; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739776318; x=1771312318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VJFaXPI1s8WgU4u9RaAAze1QfPoh6sEHi2xVP02t+64=;
  b=OHLbuN6EWGmNNuWswVQF/b3ClsxDDl2B8n93hEw/uMtzS1VRATs2U5ME
   KhLy2+YbmwSW/M2XLtot0LcU0bkCXaQ8UtT0V1+jELjjc5679KyqVoJSY
   Uq9zRO3lzC2QEEcY7Usr6h7Tw1paRR3siN6gH1xfHJb36YnzgPGXkk4M2
   RayzfHW2W3vdcVifgfSWSKFuVoGm2H6SJWGw4mD2LNqpXP59vkU19f81W
   EjR4ZVwXRHqH3+YLlnt7n2DaiM5drh7yQpLn1sb6zrklSJKwOtl3hSjY0
   eD1nD0Z032v+kERnoRhdTBuyqtjQnDCqdD7nJwddYigdy+B0QCPYy6pYs
   g==;
X-CSE-ConnectionGUID: 7FD1LuGsRPaGxs1/Jy5r8A==
X-CSE-MsgGUID: 22FVvzdQSeG7L21b072NuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="39676947"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="39676947"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 23:11:57 -0800
X-CSE-ConnectionGUID: V5TfdBWpQXaetefyowhUkw==
X-CSE-MsgGUID: /AGgd0zoSCOALprSa8Y2gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="119152253"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 23:11:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 23:11:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 23:11:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 23:11:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVMSvkKbJ3Cg7haAzPg4dhNIHPQYQ7O6UGQgzwqNzfgxVUALZ+pIVFZ2/0gN/KSjnBuid6f6Y2dcCp+qp96Ubj0g9XKsGPWfSEhju6fPTmFmg8PzhPV0OAHmklLNb4jEOPYhv8VMXny8O7QFkbWvlUPxzjcl64f7q2Jm3cwcY/bqJ5Pavq1N8ttGqMpNe/hnRTnTcxAejz5GyQODZDkXysaIoZAcOJt0/B9wKAqR7i6Ja6RCYFbZNw3uLCqOzR8Ut4xuIOaI1JNUyyllG2Qk5O94Ic7jl746mAryFQTHPmfcjMhc30BdcxeNpRSDf910jRc3Gme8H5G0Aj88MQNtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJFaXPI1s8WgU4u9RaAAze1QfPoh6sEHi2xVP02t+64=;
 b=S2rqb/24BGx6hw2YMs/jybWNdO4HXWAfUvsocfONTO0vUSfeJJNPJqAaFrhq0yozr8IWE35aDamhMlpSk9uHVgBFT+PzycfHR4tu1861t9mj96bsi2t8Ej0OzjatSwnnJ+jbf0+fgDe1/p8ZGDSDedF3r0xvkmUnA8fhSl8YMr9qcR1aD5u3RlPJmXz9hLnol+vGmCM7QXbYvTKEkYJtA+pISdjThT3Gz7hjYPax8Gg9jcTl5Ko1fX2VAHWESUMRjA1RAJ2nGrn/NSMyEIoIs7s9uDq0twW40wPY1lzcojNfBZTW6NE15KfmwWbv9hPDG+O+UV77YDgAoF3JXXwRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 07:11:52 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Mon, 17 Feb 2025
 07:11:52 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 02/16] x86/mce/amd: Remove return value for
 mce_threshold_create_device()
Thread-Topic: [PATCH v2 02/16] x86/mce/amd: Remove return value for
 mce_threshold_create_device()
Thread-Index: AQHbfjfYYKIwnF5ETUWBZdKKBI0ArLNLFxhg
Date: Mon, 17 Feb 2025 07:11:52 +0000
Message-ID: <CY8PR11MB71345FB3EA6A7AE492D62E5589FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-2-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-2-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB7585:EE_
x-ms-office365-filtering-correlation-id: f4300d40-e531-4550-c810-08dd4f225abe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UnNUVUNiWElaNlgvOEQwTHRxamtPMHZEYlpHeENlVUU2Nk00NEVzY1d3Ynov?=
 =?utf-8?B?c0RKanFrTkE3U3QyUGJnWFR1RG5ybkVJZXpVTi9iZ21qREtTQzZ2MWxzeGox?=
 =?utf-8?B?UnY1MTVSMklaSk9xVjNJYzFLc0luQkxqS1YyMmQ2K3pwOCtCbUY3Q3B5ZzRJ?=
 =?utf-8?B?QTJpZWpIZ2NpZlhuNzFRM0dqWXFDT0pxVk05ek1BaWJ3a2dvandKY0VIWENz?=
 =?utf-8?B?ckhyd2pvQmE2UXlFSmIvTE9aWTBkV2xISStqY2pFVWQrUlQyeXRtclFieWNq?=
 =?utf-8?B?YS9aYVByZFNDMzhLbzBtNStzRXNGR040c3lqTVNzYU1abzNua2xOT3lIUzJ0?=
 =?utf-8?B?a01xelF0dHFya0pQVVhEKzU4UW5vb3orVWpuWjhHZmRPVVVlWVNlTDRLL2xm?=
 =?utf-8?B?Z0Irc3A0U1grSjNIWlNVZ3VyZjEzQlVxNnh2anlzVnFCNTE2R1RXckVTK3Vl?=
 =?utf-8?B?NTMzbDJGUU9EVkRLRTg5enlnVzFpRk5YMzBGSExtbG1YYTA4MWpRcHJjVnVr?=
 =?utf-8?B?VUZTVXMrVkFhUUlJR1pVaVFUK2U4R2o0ckZobFVlZ1JJc0tzcVlWaGhxZHpT?=
 =?utf-8?B?T0pqdHA1ODVRa1pobW16WllYUDJNcS9DM1J5T0VtV2tjSXVXc05Wemk5WkNo?=
 =?utf-8?B?aUI1VlZJcm1xNm9INm8reStLcWhRaTA1YzlYZ1djTjRWQmFjKzBvUUlZWitn?=
 =?utf-8?B?TXc5d3QwVDVibFdvVVQ1YXNmQlErOURJM2l3RXM2TnZkVEkyQWY2eDdIS09h?=
 =?utf-8?B?ZmVmZFFiUGhIdXA5SDJEVEh6eVo5RW5GS3JoeGtOS3RyYVFhT1R1OFFuTzVT?=
 =?utf-8?B?ZkFTS0lZOW9HdEJHZzBlUWlvOHQyVHBrb3JTNUhjT01JSUJENHQxYnVlK3lm?=
 =?utf-8?B?U1R5UlRmRkIyK3dVemFzUGRpZGlhT0ZyejdMbU91M3BPZVZWNmNYc3hnVkQ4?=
 =?utf-8?B?ajM2SS9DdUlmVXkwRkhUUDE2T2JmejhWZ1FzWjlTU2dBZkt1OFFzRTQwSXUw?=
 =?utf-8?B?Q0RZc21OZlYwbnJMRmg4WWMyM2VPZW1CUHVjMERVMFNOMW5VK1I2UFBhOURX?=
 =?utf-8?B?Q0tZRTM5d1BQd0tJZVVHdFdUOFkrUkNqYk9tdWpQQU1sWitRYmtkdDI1bVJv?=
 =?utf-8?B?Y0MycGZsODdWaHBnTkcyTmpGQnVIM0d1L2xaT0VCcUZRZElMWkxocERQZmpn?=
 =?utf-8?B?cnlYY3dadTRNUU9oeXc5Wm1qT0tLdENPR01UOG9CYzl3OFRTR1NnM1BsYWVM?=
 =?utf-8?B?eENLMGlIOEhPQnAvbVFiNEJtVUlWTHdmRVQwOEEzcVNBOWdraTFFRWJFb1Q2?=
 =?utf-8?B?SEowdG1DL2FkdWtHOVowaEFQR0JWUFFnQ2pnVWR0Vk1pUGZHeDFGU0tTaHFQ?=
 =?utf-8?B?WFJFUXNRSEFnRldURjl4U1ZwWWhSSnIxSWFBMThpN3N1Wk44akxHRS9kaFJ3?=
 =?utf-8?B?cnRCVUJpMHNrdHhKcTFTRjhXTnF1L0h3c29XV3I1ejFNcnJPVUE0TWNrYUln?=
 =?utf-8?B?bnFsZ01YMzBvUjBGTDBQRXk4ZWRpcDhSOGNGekNKT2ltNk1SNXkvVDBWT3Zz?=
 =?utf-8?B?dFp0d0dTSHBSMlRGMFBvNDVicXhxc0wvTDJiMmJjSU9zSVppZTJPR3VPNTRr?=
 =?utf-8?B?bitZcnBDRGxoSzdGcElwYWU2UHNkM05qRjFpcDNpZWJUaWN3VTRtWStGREJB?=
 =?utf-8?B?TEd0aVlUeE5wV0tvYnJPMVB6TlM5Um0zRk5wUFJBUGp4emdsQjhGczZCdzRX?=
 =?utf-8?B?YXhyemR4ekR1WkFFcVdDOXhpRlBUaU9Pa0RmMFZxa0NxQnR3VjBYeStRZnli?=
 =?utf-8?B?bEt5Zld1bHU3aEVaZWJ2OXNtMy9vSTl0M3FYVUhXdjRsWUFyL3h0UFJxT2V0?=
 =?utf-8?B?cGpreCswVktlZmxJSTd3Zjdzd2Rsc004RUc2Slo1L3Zsc0pvRDhBK1NWblI4?=
 =?utf-8?Q?+iTMxgeum2nmjhptxwZ3X/kuMVAA2KXQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXJKejNlcm16a0Jkb2trV2NRQjFicEZVd2VCZHQzUTRkeGhyYXZKY3JpbFdI?=
 =?utf-8?B?MmVYZ2F3dFNtWWNKWW9xTUhVZDFudGRKbDVRS242MTFzbVB6NXpuU1dmQ243?=
 =?utf-8?B?R3RCcG1HNXlzZnp5MDRGSDE2VFJYMkY2TVpjNjg0SWNvSDRKQzY4MXNENzBM?=
 =?utf-8?B?Y0xydWMrM1FzbmkzSkc3bDFkbEQ1UHZBdXF1S01qanIvcWxjMHNqMUxlK3FT?=
 =?utf-8?B?K3FXQnZDRXpxNjdjOStoYTBNeWlyUXJoR3NhL2J5ZjRiOEQ0MExFUDZTcldT?=
 =?utf-8?B?eGw2SW5VeXg0ZDFoTnVzVFJKTmo3d05hSkZweWtyeEozU0dxTUFnWUlJOXZa?=
 =?utf-8?B?M0lGM2MybG9WSmd2dnA5R2crbXRJeW1jNFRZTitHMFR0ZGQxbjZINGxBSkZY?=
 =?utf-8?B?MmF2MXVodkdvNk9YUXhXRVkwVUtoRi9tc3RVb2ZyWnhwN2lqNndkNFdqYVBG?=
 =?utf-8?B?M3VWTVBaZW9HSWJPRC9zb045MTZiaUh2dGd0UnBqZzBLK0dvQllCQUQvSWpV?=
 =?utf-8?B?aVJGMXBpNmE3TGdvbVZuSXZYWmtlcXRVV0R0djRudHpmT3RzaHlJcGhMSnFt?=
 =?utf-8?B?UGFZSlc4bHA3VTFsaVVtcG5lbEtOSlBSSFpKK1FXV3diZTdiTC81cEFCYUhl?=
 =?utf-8?B?MHFSWTF2V01mMWtaSkxTaU9aV211dkJBVUVVczNGM3pEM2ZQQTdMU1dDeUxn?=
 =?utf-8?B?M1hZQlo2Ykoxd254Y2RweE85RkRVdkxvUUNlenpqTVdtT0w4OEU0RG9iTVdT?=
 =?utf-8?B?ZHFoWVV2Rko5NlQ4TExzLzZYVUdRdG9GbnEyOWsrR2dqMlZTODgxVUZWd0Vv?=
 =?utf-8?B?N2szblRSQ004WDBDTDJCNmc3UEg0THUxUzhObk9zL1pDUGE0TzlEcG1XOXE4?=
 =?utf-8?B?VkhodnVVNWVlMU5QbVlPNnQ2YnZPemZ0blE2cWgxcWp2RGIwbDYxSS8xRm1x?=
 =?utf-8?B?ZVhnRHZ3M0hmTkhuZXorSFBFQU1QdUUwUjlWNWRJMzRYVSs4TFJ1aUhhYmx4?=
 =?utf-8?B?L2k2cUNlVkg3cDBxRzRhdDMzVC8zOGk2S1dxTGtyRVdHbnlYU2ZlTHFIZUxy?=
 =?utf-8?B?c09KMFJSa1JOVHhncTEzWTI0cVlNQnBOWXZuejhFcmNmOWZOMFBMeVM4Z3Bm?=
 =?utf-8?B?U2RoWmlSeERMREcvcTFKdFVZWDZ3bmxoUzdvNHNFY3NiMnREKzRWalJxSDY1?=
 =?utf-8?B?cTYzY0xFMVJ5UTlHUTRZbFRldHZxam04a2liZDdnWG1SeWIwbS9PbW1pWEVw?=
 =?utf-8?B?NjVkWGN5Zjl4QlI4R1NIMkdNc0Z6MWZoQkM4VFF5cEZHTmx1SXExSVNGb0lu?=
 =?utf-8?B?RXA4UGZWNThNeUJRb0tkb2s5S1NxdWx3V3I1WWRYb1FFNUc1dGRabm02dWky?=
 =?utf-8?B?eUV2L0lIcldHaFB2TGtlaGUwbEFqRFQxcG45WTRTVUFvcXRvWEVvMlJpdDls?=
 =?utf-8?B?Nmg2ZUtUcnkrUTJBaVl3NWsweVFQRklkcFZtMHV6WGFsL3U3YzQvR3llb0hE?=
 =?utf-8?B?a2YvY1F2WFovbERGR25zelEvUjRZckgxWFdLVVNIWDRURnhkVEFCT2lyN0hT?=
 =?utf-8?B?V0JMTTNESHhQMlFwdVA4dExxdGZNVUxmaTJXN29rN3J1Y0ErRE5BeVNHQUp1?=
 =?utf-8?B?UDN1aXpqclhTa2NIN1V4czQ3amNKRk5OYVh3TzN6ZGNSZ1hXRGpONVREdnB0?=
 =?utf-8?B?VWkyNFZEUEh5dHlSUVJqMnNFYTNGU24xUmpSMTRQTVFjMHBQSEk1Zk5oUmky?=
 =?utf-8?B?N2RDVDZPY0RKSkNoOW9xaTBndHhwdjFBTDR4Q2krbldTdFYxbC9pUE80WTVw?=
 =?utf-8?B?ZGhOMTBEUk5NR3ZCQS9xQys5RHIwY3NCZ00zeU5LbEY0cjRkT2ozdmYzTWVN?=
 =?utf-8?B?SGJJWjZ2Q0ZlMmdPTmhibVJnR3RZOS9UU0FKcVFIZU1jNWZaOVlaZXptTVE1?=
 =?utf-8?B?Qml4TjZNUUZWTDJ4blhYVXAvY1ZqTm5QZHJkK2dBTEQweVZ3UzkrNVEzMDYy?=
 =?utf-8?B?TktpZjNON0x5T3RvUUgxdmc2cDF5M1ZXZDkra081MXR0V3cxT3oyY29QQVZK?=
 =?utf-8?B?THVEK01CSVlFTlJETi9Nd0w3YjZMODdjc2lkdHlqeHVvQUpiWk4rZUxTUGNL?=
 =?utf-8?Q?ZG1ZV6J0Rsqq+mSMIopZiaS9A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4300d40-e531-4550-c810-08dd4f225abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:11:52.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a66eHhwQkZE4QvSpvm7OFjmms4D3W99AXkuYLktfN3OvymaLLHRFdpyu///HBNijKcx41JgJ2FVFI2bbIgHRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwMi8xNl0geDg2L21jZS9hbWQ6IFJlbW92
ZSByZXR1cm4gdmFsdWUgZm9yDQo+IG1jZV90aHJlc2hvbGRfY3JlYXRlX2RldmljZSgpDQo+IA0K
PiBUaGUgcmV0dXJuIHZhbHVlIGlzIG5vIGxvbmdlciBjaGVja2VkLCBzbyBzZXQgcmV0dXJuIHR5
cGUgdG8gJ3ZvaWQnLg0KPg0KDQpUaGlzIGNoYW5nZSBjYW4gYWxzbyBiZSBhcHBsaWVkIHRvIG1j
ZV90aHJlc2hvbGRfcmVtb3ZlX2RldmljZSgpLg0KDQo+IEFsc28sIG1vdmUgZnVuY3Rpb24gZGVj
bGFyYXRpb25zIHRvIGludGVybmFsLmgsIHNpbmNlIHRoaXMgZnVuY3Rpb24gaXMgb25seSB1c2Vk
DQo+IHdpdGhpbiB0aGUgTUNFIHN1YnN5c3RlbS4NCg0KVGhpcyBjaGFuZ2UgY2FuIGFsc28gYmUg
YXBwbGllZCB0byBtY2VfdGhyZXNob2xkX3JlbW92ZV9kZXZpY2UoKS4NCg0KU28sIGNhbiB3ZSBh
bHNvIGFwcGx5IHRoZSB0d28gY2hhbmdlcyBhYm92ZSBmb3IgbWNlX3RocmVzaG9sZF9yZW1vdmVf
ZGV2aWNlKCkgDQppbiB0aGlzIHBhdGNoPw0KDQotUWl1eHUNCg==

