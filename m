Return-Path: <linux-edac+bounces-2147-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5F9A4843
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7D1C2088E
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F95205E34;
	Fri, 18 Oct 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Et1bY9X9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048A18801F;
	Fri, 18 Oct 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284024; cv=fail; b=pYW9NwXED4MxdT9Vpj1JeI6t3DA1bp3hehjwchzll7RcnHDpsixV6xwnTNXuvZUoA7V/s4ecPoe6+Z0LbQSVg3Bsr2ZpJP37cjC5NdUoT1J454vBtvCE5lc2OhUEuN6fQl3Pt7CRX7bA+U15FLZB6ijIHZg3UONN6Rx+D7NYnqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284024; c=relaxed/simple;
	bh=kbRyZGytg8k29qfQ+ajeOcQi3DJ1CFmKvlbOgJJuVvE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7YtdFVdiVM35VBvOUNBclMbFP/TyG/CTg06xJAw6BXDVMrL0lk45iiqjafkRE/OW23AuOVh3C/0tCr0wT51dR5Sm8u2Qb5q0y4+Vwy709Z6x3c+XKtfNlfe5Pm2tcrAf+asRX6iVEz+YScjwmr5OeGOmhHt/yJswJl1hxxLD94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Et1bY9X9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729284023; x=1760820023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kbRyZGytg8k29qfQ+ajeOcQi3DJ1CFmKvlbOgJJuVvE=;
  b=Et1bY9X9kI5l1l0hODdIVCWUrTZqN4TC/9aivpEEBqd5UxKEIJMGpaMo
   3rmA+dHQ8gCpPlSjlC4IRXzgVINEMAhCkHh8ecHW5hwkTU2JLh82575We
   su7hP1psUnkmgUdAad86Krrv2RbwlILdTrBqnVZftwt2oUI3SKte2S0YS
   1bs5cXEOBX6cqYrm3QgWehAWQIaoXDgScRRBamyU+4PkFfwTTjNgBMv/R
   567gfTN3u5xjvcqqnVd46M/8feuyugu+Fw2XTxR9QR0rJNwG4FAl2o0q8
   qXTzaLKR7JfRwqyYD5IKDSTKV5vkea/fLs2WAVXkvXlKuREbJKmzwe+PD
   g==;
X-CSE-ConnectionGUID: b/0ZqKqtTRuAFvs767qAEw==
X-CSE-MsgGUID: 3XR6rB4OThiI5rg/7zawfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39958084"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39958084"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:40:22 -0700
X-CSE-ConnectionGUID: Goe+AXSCQW6aD7elWZwZ5g==
X-CSE-MsgGUID: 1plO9JQVTXuetNQd0n0SqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78985777"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 13:40:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:40:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:40:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 13:40:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmrpqs288VRLlASnD5d8kal3RgyNXuTpRQpHXn2UhDla0IzczcOWND4IYEQPTV9aRnwybx+p1dh1fPtlKc1vdQxEq2JLcZN5BILCegxe/axkNfiPRigRgZHdBF9fR6e5O3oOkFsmpRioL8wkeOs9mQL08L0lQhLs1aU7/zaVol7MnNF+R4rgK5kJaUdPqgMgTXIzstnZNsouLVBq1Naf+xht2ajmWoHFn8OIu9i940GAFVW3sJMF22QI6N9ur/6jOxpRPxPKUuv72SkYlnLv5bB0DKODDEEhBAR+HwsatWEKS/yh8xY2Z7ycy/oVZsSVAOy/fKnJxkCj9+Q+y93E+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5INmKjUexhiIVAGUsrnd7ughVH9bgwRsrqX94Mx5Dw=;
 b=nS9TA5bQ2GUq+6RSVaxmY4UUXYkyqQ3VV30eD8iOGbFGoOCCOAD8W+KYxV4WDF2vGbG/X4rk7XWY5zoDdrGGhFNcveLLoWJuVNMOTHZFbZ0K/KazhKHvKD8jdD+NR9MrVC0V/t+N9dcDjNhVsYj01T5zD8tP6mYl/FdDeOq6ETtauXRDCdu5d6SKGDOvsXA7XftzuQrDU1+uDooQ0gP1cVAX2onZTi5J+B0hENz1E94w6sH/1YngM+xCY3o606r3IyCgHfK8sHvMdMTNvOC516e6hC8CocRw8LGal7gC8yTPFyOLbiQ0OFOTU2cQ9fHYJPcyEYrj3rRDSYVh54gy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 20:40:12 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 20:40:11 +0000
Message-ID: <c88bbbbf-9f49-4ec0-b1af-075ddb85d0cf@intel.com>
Date: Fri, 18 Oct 2024 13:40:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] x86/mce: Clean up some x86/mce code
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: f320f1d9-9bc3-432e-d1c5-08dcefb50fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlVBNUU0Z0l6MWpNSyt5VnFqMjV5a1ZoaWd2UVhLYUw2M3FwOEYrUThqY2Jy?=
 =?utf-8?B?L3BjVWV5cXlYYXFWdGFoa01qdXJFbEtYRk5jNTQ2VXAxUUlWdnVnNU9sNEYw?=
 =?utf-8?B?TWhaaVdwcTZkWUttK2JlWVRETkJ6ZGRuU3VQUnJJTitTVGRPN3dKamQxZkxX?=
 =?utf-8?B?ODJWd0JxNW5Lb3paMVM1QU96Z1ZGZ21vbDQvaGlYLy9RcE5wZlJTV0VieUZF?=
 =?utf-8?B?VVh4RFZmWUVjOWFUYkk2bUFtNlMvc1RCQlF4c01WOVhJQW0ybXJaRGoveW02?=
 =?utf-8?B?R2VLbFdBY3dEM0FHa2xWSXNNbjZCV0FkZlRyWWNmWmVWZUF0S0pVTmRyY2o5?=
 =?utf-8?B?TzlrN0hPa290dmI4NC9ZRFlkRWVzQnlPWGZYZVh1S1lYZERWbm9UUTZuVHdG?=
 =?utf-8?B?M1g2cFlTZklMbnUrN09RT3FGeGVXaVdGc3phWnB0SHNLUER5QndIdFE4UVNh?=
 =?utf-8?B?RWpWYndhZTBvZnRTOXlDK1dpM3Q5dFhMdGFNVFQ1OXVFN3habW5aTnZRa2JR?=
 =?utf-8?B?OE85V0VLOVRJdjFoWDZVMXpRZy9xd0JMeHlYRHJOOWlyRks0SWltc0dvdVc2?=
 =?utf-8?B?WC9DRjAydTc5OU1IVGFwWkdZYTJBK3NjN3o3eHdCQk9ZRzRJS2d6Y2RGd1Q1?=
 =?utf-8?B?cWx1by80RmJXaG81UktkWnBjMlh2azRTUWlud3l0aUNjTjJTVjZpTHNFUmlD?=
 =?utf-8?B?eFE1ZU1zbFMzbG8wWENLeGlkRFBCZXNFVGI3WGV1dHZYOUtyTGNSTTZHV2E4?=
 =?utf-8?B?V3B4WmdMZFc2SlBIOHJVMHVIWDlNb1dxTWtib1pnejE4NnZpOHR2cDhYMHp4?=
 =?utf-8?B?V3lyTGcrd1J2a1RZYld2SFRaSmpXT0FnSUwzTWlySC9oQlA2RitRT2I1d1Qz?=
 =?utf-8?B?NVJ6OTF5Zi8vak02OHQ4SWVqc1oydW16RjJSWG5xSWtaS0tMbS93T0FKRGpC?=
 =?utf-8?B?RmdQTGNYRnhzNWk4eDZIajlGTEdFRlJZbnJuTmgxSmttM1diclZpWVRHMCto?=
 =?utf-8?B?L0hKMFdLbStBc2hFbTF1UHp4eFJuazMzUlB4MHpJd3NSUklrOFVEeWNiSWRp?=
 =?utf-8?B?SE5EN0M5SkRaWER0V3QvR3l3YUdBZHVOcmNMemxOTlVIb2s4OGZrMUhJbVJZ?=
 =?utf-8?B?STk2MVBMSVdGdU5xNDFmYXZRT2kxOS95a0tpcU1kRDM3NktjeFBNbm9nTzNI?=
 =?utf-8?B?VUM2NFUrUXFDcTljdFo5UWw1Ti8xMjJSV05jNzVQSytQSFF1YlJaZDlRM1ZP?=
 =?utf-8?B?RU9NbXRlMW4rRXQvRVVoN01JeUdnOUdud3JVbk0yd0lqYVZNSFpGZW1MV1lZ?=
 =?utf-8?B?NHNwTFBYcnh6MGtMUFBXelZpZHk5OGVuQ1lXV1ljSVNKUXhzajFyNjR5VlVY?=
 =?utf-8?B?elVzQWJPbm5EUG5jNWdUR1NvcEtDdmQ5cWljS1phQnVuR3dmbkFjelNwazM0?=
 =?utf-8?B?R2NyekZSc3hOQk1OZW9HM3FxVDJrbElRcWJWKzhoaUh4bnZUM1A4OFFtaCtR?=
 =?utf-8?B?YWV1eEdLUndZbUNzdmNuaWcxckpMVUhtcUg4MjhqcDVHdytpazRVY3M5Qm1B?=
 =?utf-8?B?aEFJMk5YY2VvRDhSNW1EU2dqMXJKTnFwTFdIZ1lMODZPR1U0RloxejlsY1NY?=
 =?utf-8?B?QSszSUFzVWorL29VWWhkT3UrRnZPd1pTYWRmU3BtTGR2YXVpa1MyQVFHK1Jh?=
 =?utf-8?B?MWhkczNDc2E2VUF3SGtwQ0dVQzJoTlBieXNXY3g2SVE4b1k5bEpQTHZFb3hQ?=
 =?utf-8?Q?hsQi/ns3M1T+XK7gk8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNxQ1NVY2JZVHdhODdZekl6d3dkc0VHVVdSRDliSG9pamFLaXgxcjJTa3dx?=
 =?utf-8?B?RzJoY3gzVXRVK0NFVDZKTXBrbmRYYzR2RlU5VEYwNU92RWJmOGVDK1dORXZ2?=
 =?utf-8?B?K01xcTlnSW1oYkhmNHpWMFhNNVNVandFTzNQZ1pDdGNiZDJrWE55VHhEdkZj?=
 =?utf-8?B?RHJSR0I1Y01NWVJMYmwyM0o1N2lWSFdYZjk1ZStWMWxTa1JkYVgvVHBIRlN2?=
 =?utf-8?B?NVJPaDlYYjRsQXNKdVhSQlBGQTlQTGtja0NQUTh4UHNCdWMvbkhRdjRNREhy?=
 =?utf-8?B?UUdRTEVVYlo0aDZFa1UyN2o1cU9NNmJjQ3ZnR2xES2c5ZjUvUkl4N3h0b016?=
 =?utf-8?B?NHRPUG5CcG51VjhVSDd4YnFUNytjQ0kxSzNUcHVUSWdFYTZVS1laOGVSWkFu?=
 =?utf-8?B?ZWkwb0RXVDZkZzJZbFI1OHhLSi9SNkYvSVJwbEFqZmdyd081VnVDdEIrZE9R?=
 =?utf-8?B?ZmdwcDFmMXFHcWdlYmVEUlBUenNHYkFYLzJ0Z2hUVG9CR0tIQm9pN2xBMm9a?=
 =?utf-8?B?c0RRMm9xL3k4VHMxU0lHVXQrc0lGNmxxdlpiOVNIRE5uQ3IvVm0vSm5ubGtL?=
 =?utf-8?B?amkxNEZqcGtuN3BpSUZBR3NyUVhvbVYvWm1vaDNLeUZCaUNCNVkwVTZUcElE?=
 =?utf-8?B?UE1MSnorVDZTSTE5VE9wdUxvdkFWMnpHMXBLb1BrU2hLemcxZ0h5MWEyQTZG?=
 =?utf-8?B?dE56WXU0TDY1cS9lZmR2SFBnN3NPUUVwRUk4N2txdGs1c213VXhhWVZLaW1z?=
 =?utf-8?B?WWNlNE56bXg5Tll0UFhkblAvZm1keDJMeEQ3NERIa0NvNmlucnBqTlloTjds?=
 =?utf-8?B?bm1hTFB1K3dHaVV2ckFaZGM1WnNQWlU3NTZvd1Z0QkhMcldOdHZPaEJPaHJS?=
 =?utf-8?B?cys2RGtHaUtPUmZteVlsWWMvYmt2UUlEUDhSdVdqcEJSMkxEVnM1R1I2TUF0?=
 =?utf-8?B?VlFUbzlvQmxpTExJVEZrSWVEZzk1NFo3NTVVZ1NCb2hDckxzR3dnai9LdXNM?=
 =?utf-8?B?RlJCY1BmUk1uQTlEWXpFQVZzZjBpZEJvVEtBTVVVYWtwZFRMeEVTb3RLenI1?=
 =?utf-8?B?YS82SXMycDNnQ1UrMFM1aEtRTnV5NDF1c1YxZU5Ddjh0MnBRNHkrR3BTbHFk?=
 =?utf-8?B?Vk1CckhDK2VYMTJWY0crVkZkeDl5SUpFbS9MVVNWeFUzU2xGWlc3WmUyejRM?=
 =?utf-8?B?YjI2QkE1YXYyZm13aytnTGFuTlNmWXVtbHA1QTU5V09vcHRQS0VYZ2Y0ZVRo?=
 =?utf-8?B?aVVsRTZjZDVobTFzQzZFb0x6bklGemFuUDN4cWlDL0pjZ2FKbjBid1p4N1lI?=
 =?utf-8?B?ZEkzYmt0RTR2c3ZmSWNoWTdZb0V5b0d1cVBDTlR5RjBwQzJhNEcyMUJSd2J6?=
 =?utf-8?B?dk1vbVZtYUlIalZuSXk2UUhCMHg0cTRML1JSWk16RVJQSE12b1YvendHa25H?=
 =?utf-8?B?RktBZm5rc0YwZFdubTRLOXprYzdhZlRRb0x3U1p5NXRHbVkvcGVGbWErdHlV?=
 =?utf-8?B?RzVSaTh5NmRGdndEOUQvTjVXVU5HckNyNTNKbEs3cGErY1p2S2xSL2YzdGVV?=
 =?utf-8?B?ZTd4RkZKSFJQK2NVR3VHNEc0eERHdWNIeUxoRU85eU5BTzlKTlhyWWRYN1dV?=
 =?utf-8?B?aXRDYVdDbGpKeFlsQnRBMFo1elE0Nlhpd1lPYVJWMHlNT3pNOENSQ2F5cDkx?=
 =?utf-8?B?dVdQU3U4cVozMktVcEJSZUpPcnhVQldMb00xend6ekRDSDF3aEFqTDRhOUFv?=
 =?utf-8?B?TllRcC9KdVBBUnJPY0VndnpZNnlvYTVQSGwzdVd4TWVVVGUxYUxaUGFacEpv?=
 =?utf-8?B?MS8xVTRvTUQvM1ZWVE5iNk1lVHZ0RjI2UUt0VGx6Q1Y2K2R1TTVnL3NNZGNQ?=
 =?utf-8?B?dFY2NjZjMUpGQ1prSnlna3B0RFBxc3g1UENTdkhLcG8yY0FKV0l5OE43SlNC?=
 =?utf-8?B?ZHlEdU1hNk9wckFMWG9JWGxZNnBKeHZneFBzYWk1MGZwVmFsZmJoRUNMYlAz?=
 =?utf-8?B?RmFTd3ptREloMng3S0lsL1pnM09GZFliRDRMa25maHRHWGF0YjI0aHpFenZ6?=
 =?utf-8?B?TGd0L1AvNmY0OEtTcEloNVN4TkpjVE9GekNuTXhYVjhQd1dGdkNsMmZBUkJT?=
 =?utf-8?Q?A3ekQ6D2QtkdJ9p8cJuq3G9zW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f320f1d9-9bc3-432e-d1c5-08dcefb50fae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:40:11.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /65jUhW7k3QM7Fu9qesaMvw/APmBfCN8buCQ9uNmElcEGTS0qh2OknI3nvTdxm5czVF0u93N/x0SfX8vc08U/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com

On 10/16/2024 5:30 AM, Qiuxu Zhuo wrote:

> Qiuxu Zhuo (10):
>   x86/mce/dev-mcelog: Use xchg() to get and clear the flags
>   x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
>   x86/mce: Make several functions return bool
>   x86/mce/threshold: Remove the redundant this_cpu_dec_return()
>   x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
>   x86/mce: Convert multiple if () statements into a switch() statement
>   x86/mce: Remove the unnecessary {}
>   x86/mce: Remove the redundant zeroing assignments
>   x86/mce/amd: Remove unnecessary NULL pointer initializations
>   x86/mce: Fix typos in comments
> 

Apart from the minor nits and commit message changes, the patches look
fine to me.

With those addressed,
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>




