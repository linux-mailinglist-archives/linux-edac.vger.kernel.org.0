Return-Path: <linux-edac+bounces-2367-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823D9B72D7
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2024 04:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CC2B21133
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2024 03:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C7132106;
	Thu, 31 Oct 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ip2WKn/w"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968B14F90;
	Thu, 31 Oct 2024 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730345051; cv=fail; b=CDROrniLhcWryg2dnibqnLwCbyLk6Lh/WByOgAPchVGEEMzdfg7gUtRSNWgs5/BDl2J0+0opH+zpbhn82zwZMbpliGe0RVwK2vL/hHxPKKJ8gZlRniPX+gLqQMGfoixJRejMs7tLmf7Ge8/hyOxiz6gYI4LcLueIqWaTX7/2cIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730345051; c=relaxed/simple;
	bh=uaxkh+qNaGs8kROrVHTz5xXcm9XQ1MUJBnW1MRmEBN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QFCBEiM0g41/wHar7lKM7rvOxzP03BJfFdDC/njEwdtJD7YO5lV7wYiiz8GvLQF7Qfl/K709vx+u1+CActpZuI4HO1FTGW/c8eL/ZIJkW/WSrUxFsXAJJQii8z5wxaDIwIckj+ETLkF7BLisFofweDFj1f/rpfahiJwGHX1Zu+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ip2WKn/w; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730345050; x=1761881050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uaxkh+qNaGs8kROrVHTz5xXcm9XQ1MUJBnW1MRmEBN0=;
  b=Ip2WKn/wePTa7dTtx+QZxisBDoBZHRw0ZGCsBUNzP/mNYfgvQH+U71gd
   Wic2nAabLcyEgRa6DNxuYyDWk2tu3LzLLT/Hx345oc04vI6idXvs+KKRT
   mBTNDPpokZ5yiQICb/hIEFn60qnObuy+GXXtPd1Le/25/tFpxcKbnTz+V
   OzLvdvOWScAIvO1xsuFP8pNCl9k+QesLC6xgPUR3QWQT7N3Yd05crVj8T
   sJwhkzez+00Nuw5BxKmlj+yOZep8UJ4x9z//enwyosRa6P3OTbUWChMJV
   P6NU6bVx/Jn/9AgS3de1Ye1dkCoNzKqGb9390fWrij04VKKQKTUHpwHDn
   A==;
X-CSE-ConnectionGUID: 2SLOWt5XTYqL6RfeJlXqlA==
X-CSE-MsgGUID: 2rgiIGWRQLivFUzgOo9ghw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41466586"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="41466586"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 20:24:09 -0700
X-CSE-ConnectionGUID: RphE28wYT9GRuK942empug==
X-CSE-MsgGUID: +wDLoZTxSduIHbgCIAVwQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82422429"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 20:24:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 20:23:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 20:23:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 20:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csAUPoYasrZHQH6BMD5j2wlp82iCaXiGsgMjgsUiiFbqUzOvtXbr9SYF5X+fNITfRsc3aUd0efKe/FSz7vwc5fqYEh/u1XWG/KVkp6bEdsu9UHrIuicDt/h79VT66cf7yNF9G8kMVYKwpHefP6OD8I7+7hNunyUAQIJtznruSIX4O9c/Ej/lKoVQlYMYANnOrlKe+MVMl4jMquXORJUnO+fTlWpI4XAkg5AIAryqG2gTtnuH4fZQFP7029Cw1RSdzaPiTusnxw+pZ8yGmJBVz1rQtFHoOct+qidHTvkF+U2iRsYRsw+Te8EjQPydK/dQSvBVqVftYiTVV8RliSOvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaxkh+qNaGs8kROrVHTz5xXcm9XQ1MUJBnW1MRmEBN0=;
 b=ZwJ4SFnbVStQyL/j+tOUKAXdSbLk8HCei/UWVhnOUKqIp/z2EymCDUor1g3mwzR3wJKiCTTOs9jkhl/PCr4JeHx/v57kgQY8fph2LGFcZiME5lptvfZjghwv+Oh03IGLnKadzETXSP4fVGhSO7cCltani5Rd/aFsGCd/D39MbIqmBUCaLtobxTy8GT8FsMzdLRxP5xs1K8i81fuGLvYz6aXz4ADklTWo8AlVgvh3pHtLpKiyCUO5kR4T8IQKNtLI39A9/sXkYWEhEJ/jJxBV8Ho9oUgrXSlW4WJCt37bqOdsJo5gkOr664LW2UXi+pKYnW8/iTn2trEvQdYTo6R/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 03:23:54 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 03:23:54 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 03/10] x86/mce: Make several functions return bool and
 rename a function
Thread-Topic: [PATCH v3 03/10] x86/mce: Make several functions return bool and
 rename a function
Thread-Index: AQHbJouBCN10HIsjC0+EH3rQD3OlZLKcJ3AAgADnMfCAAhAygIABHEEQ
Date: Thu, 31 Oct 2024 03:23:54 +0000
Message-ID: <CY8PR11MB7134CFAA90B50A823EC5214689552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-4-qiuxu.zhuo@intel.com>
 <20241028130656.GTZx-McByoo3wsR3__@fat_crate.local>
 <CY8PR11MB71347B5215509D3B58258DCE894B2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20241030102453.GBZyIJdRgPVn15dXiJ@fat_crate.local>
In-Reply-To: <20241030102453.GBZyIJdRgPVn15dXiJ@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY5PR11MB6137:EE_
x-ms-office365-filtering-correlation-id: 09f28d8d-3352-4e05-0259-08dcf95b72d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UEl3ZU5wdkZKQVdpNVlNTHl0a0UwSndQOXF6M3A3a0VrUDR1OFlDUksrUDh3?=
 =?utf-8?B?WCtLdWlLdWR1WjF2MDN6M1RSRkU1SisyN09aSWRiVjBrNkJBc2QwNGtMSzN2?=
 =?utf-8?B?bVNLRmhWVzVhNnpkWEc5M29EWWlnNVk0WXFjNmljY05lNGQ5QnhBVUZGS3BP?=
 =?utf-8?B?UGVFc2pIRDdSQkppcHlWa1ZIOU1Xc0U4eFBURzYxdVBLYXdoVWhkdHVzbzZi?=
 =?utf-8?B?MmVnR1MxWEFSTnR5VWdGb1dqNzd6NU9zcEZ5NHVHYWZKOHVjZUlBNDRlUnJl?=
 =?utf-8?B?ai85aDJGNFBWcGFCQU1qOU1qM2dxQXBFZ1V0UEVvRXBVQ2FDNElldmRnZkdu?=
 =?utf-8?B?Y3ZEc1VZUUF3Q2x4K1p6ckxVSXZSMkkvbkNvVm1CV3ZsZnE2ZUQxcGVEKytK?=
 =?utf-8?B?d2xDRVJpMGtNTTdIUEJUd1lLd1VBSXVLcWMvcDFDSVA5eUhIcHFxbHFlUWdV?=
 =?utf-8?B?Uy81MG9rT29BSXA3UHB5SHZFVE1qUDBZeXRZMUY3YnNqSGRhQ0tCbG5LUGo0?=
 =?utf-8?B?M0M5enZ4YjFUWHVMOUxhNkZXNXhTbmRGNVV6VnYxSXcwSCtWb211eERuQXhT?=
 =?utf-8?B?cDlEWDQ3TkE0TnAvZE5OenlIV2lnUGZ3dHBMa0QwMU1zcUh6Nzl1Z0pXWGR3?=
 =?utf-8?B?YjB4QmU2a3pGMGlBRFM4WVlmK3BmZTRsY2E3ZHo3dzNGaGtINy9wdUlOU3Vm?=
 =?utf-8?B?ZEhXWFJoZ0dseit1d2l0VkhSdnVMZkRKSTZRMmNRSEt3RThnblNjc3pBTDMw?=
 =?utf-8?B?QjRMUkplbGgyWnBLMFA5eU1hZHJlNmhUb2RhU3ZsYkxzQmxYZjNGRThPY25l?=
 =?utf-8?B?NVh5UnZMZHNRTmZDeWVQaG9YMnk3ZFBRQk5YYlBOZ0FRYVUxSllsSEczTUtB?=
 =?utf-8?B?eG1PeTRVUlR6cFZVQTlxQXVwWEw4YlIzNmZNTmdxdXhEeEJQNDQ1dThVQndz?=
 =?utf-8?B?Y1N2ODJoSm02UnpJYXFGM05LWmZ2alh1VFJiQ3o3NG8yM2hML0F6MlIvZE5P?=
 =?utf-8?B?cEFUaS8vSUk1c0s4LzB1OW5wQkN3M2lpWXQwQWFyM1pHMXJjT3E5aERSdlhF?=
 =?utf-8?B?UXR6d3l4cXA5Z0tLS1czcmlLa1Bka0RENlN4NDhFSS9RY1JVUUFUeEI5ODZV?=
 =?utf-8?B?NEptTzlGR1FqendxV2R4Uld2UXU0bnhhZWw4MG9FWFEzdW8wRnl0b3Y5aXdD?=
 =?utf-8?B?eUtZSmZYdjQvZkJIZVZ3SXR6QmdEVHNHNTJWSmJPeENHU1lqQi9ZOEVRSW5R?=
 =?utf-8?B?RlJGazlIejhRZndCcnJZUGg2dTB0MVgrbzJSWEN4VHFYWWlLM1ZGQitqZWJ4?=
 =?utf-8?B?b21rREhEbENHS0M4U3QyVkR5bVpGMWFmSytLcFF6VzNuWEp0a3dJRUJDcDVi?=
 =?utf-8?B?TWd0NUxnek5nZEp2SXliRzhrUGcvQSthemFWZGJoU1UzUklHOGVSOVBMTDJn?=
 =?utf-8?B?M0VOQk9aSFMwZDBubHJBM00vRjg3Ulc1L3ozc2FOMkdKWVVTV1BmMTlBalRG?=
 =?utf-8?B?VWptWE5Gam9pZ3Qva2t0MnQ3SGZsSURyc3BCZ1NWWUVOWVZFdG1WQTNTNndi?=
 =?utf-8?B?UXRhWHVnSGNiSHByMjZmYTZGYUdGUWV0OW1aQmhEckhMSkZIL3R3MnFFV0hj?=
 =?utf-8?B?aXZ4QVByS3N2Tk9CQzRxSXBwWFB5cDlwVGZ4a2ZrcHJrc2NnS2YzekFZa0lx?=
 =?utf-8?B?VXVxWXNKWWN2cW40K1NhQitYT0xzM3RBVWhBenZJNmRjMHFaVDYrdlNyQmdG?=
 =?utf-8?B?ZUxHd3diUmVpQUcrWVh3ZkI0SUkrUHZ3Z3JzVDRnaGxseW5TYUpHenU1OVNU?=
 =?utf-8?Q?1FniH7JYTfD+ryesXweQhat3zv/3jh+or8fQk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRVQmNBK0J3Wm02OGNQbFYrNWxtT2xURlY3UUp3empCQWM5NzVBc1BFRS96?=
 =?utf-8?B?UmtoMEJFUzFrUlovNlNWSzNBQndlcU80dFdCd2Q4Rzd6SFEvS1d3Z0wvdWhY?=
 =?utf-8?B?SVpwY1A5d2d3SzlSdVlLVXpBc3hWUW9SV0JudHNlbVJCS1pkK1orQkw0ZnNU?=
 =?utf-8?B?NXFZd0NOaXBaZm1SbTQ3Rm05dzZKN2tSREdHSGRpL2hmZXdPRnVtZkJtY2lq?=
 =?utf-8?B?M3NQdGFLMXdFd09tMVl2aGdQK213ZVR4TkxLMUZTcVFZbG9GakpCSlQzRHpY?=
 =?utf-8?B?QTJlMXExcDBlYVVFL1dibU9qNUVHVkZ6MmFJemYvRnlPL0NkcVFpZ2NFd1NU?=
 =?utf-8?B?cGo5R09JQ0Y4d2V5TU5JRTI2SUpPaXVHajZZS2QvVlJWZ1RlTFRHZThtRzNj?=
 =?utf-8?B?OUNOUmxCeWtwUVZISFBPdjJCMEhMVzZSMUVaenk3Umx6SjFWd3laRWNwTlFZ?=
 =?utf-8?B?bmJLTjBMWFV3b09OUWlacTlnYlJwaWRzcVFjdUVRRllob09LUXEzbExLS210?=
 =?utf-8?B?dWdybGxJQWxIdndvd0I3bjdrejZwSDNVdVVQZzAxYXFhS0pWQnFScVJtalhj?=
 =?utf-8?B?TE1rYktlMmVMS0lNbTQ0YXZoNW55dXRxUHYyYWhBMm1iRkdRYncva0ttdVFo?=
 =?utf-8?B?alRBOFpySWRTSm5mV1VKTGovS1E5MUlKeDZ4eWQ3QlRJTU1JdVVSQ1RlZTZV?=
 =?utf-8?B?aFc4djRtMktPYlNVcXFWZEQ4cmFPZ1h3dHJNcitGNkM1QnZlN2RIc0FXTEVz?=
 =?utf-8?B?RzZLSVg4cWt0d2lrd1hleHp3WXZ4QXhWWGtZTEdyTW40VkUyZDhjemM4TnMz?=
 =?utf-8?B?Mm9GeEIxT3BHK2ZRQlN1eFdya3k4b0ZxbGJjRkNOcFdQRDFqWndLS3V0L1RE?=
 =?utf-8?B?Wkh1ckxjd0t2bCsxb1ZMUmxaUmRybFdITG1VT1IrZ1pSRStzalM5YlROSGl4?=
 =?utf-8?B?aDdLbFRjc2hzTTUwbmwyQStjOWllOEp1NDJ5TFBjaXFhQk5mU0tQKzFNUUdC?=
 =?utf-8?B?Ti9JdmxLd2JJeFhvRGxLZ1ErTWZqZ0wvSUFwaXlaQkhkR1JpMHF3YmpESGFS?=
 =?utf-8?B?MWxpdTUreXQ4bFZ4aUtrdXJRTVlzSzljWUNGYXpISFl2M1hiT3k1Y3grOVVJ?=
 =?utf-8?B?ZFRTZjJ6dWlmZUcwQUcrNlpPenQvc3EvV0NrNVZUKzJzNUV0NEt5bXRwTGt1?=
 =?utf-8?B?end6eG8vLzFJVE52bnprZFpRRHRnc2Y5aFg0aTd4eWVqS1I0SjI3WW5HdkJW?=
 =?utf-8?B?Q0RmQ1pyWnJTLzRETmhYVkh6SHZPc3V2UDNhS3VvZXB1VjloNWJQd0N0WEE5?=
 =?utf-8?B?VWdvYnMvRUgrZzNGb3lGUmdKV21PTXpEQ1BUNHhhbWU2UlZXS1NSN1hBbjlE?=
 =?utf-8?B?aTU4T0p6YVc3ZkltMkF0SVpJUE1YSGd1WjBpOW5ZcC9WUFR1QldRMCtQZ002?=
 =?utf-8?B?eVpZblE0YThOQWNsS2MzcmpJTURIWWMxYnVPODFzNkVCRmRINklsWHR1WVZi?=
 =?utf-8?B?VWh4K0U5RWxTN1pjRDVHeVpyVUJKMlhzNUR5VlhGZGp2WVo0WGZlN0pvWnps?=
 =?utf-8?B?cXVENzk5K3YwZkZvdllHQ0M5cVNYSzVyUmZSWldwU0FZNU9DeGlRelRMNUhU?=
 =?utf-8?B?b1gyOEs2SHRROEZkZHJZREM1a09hYUlNNXBhWHdock01OXM3SXRyaS9UMDQv?=
 =?utf-8?B?cmlJMFVhQSszL2NvN3dxUE85MEtyVCtVT0xJSXBQdDRzVlB6SzRyNFdFbUVk?=
 =?utf-8?B?TW9kN1M2YXdmSzRyMjNRd3kwSzA2dVQvNE1DclFCL3dwRmNEbys2RUc3blBE?=
 =?utf-8?B?ZkhBV2xVVk5QWllXYlNuWjVNN3lsSmFlSVZxakZodThxNEROVWRTSU9nVUlI?=
 =?utf-8?B?UytUSTI0RmxBTXZUVVl1OVpvMzIyNE9aeVhBbHllQnZ1NDJkNUtlbDNUN3VE?=
 =?utf-8?B?U1Z3djNoRGhTbEx1Tis1bmttV3ExdmxXMWFhSkZnRklhVUhacGxhbEZQREpL?=
 =?utf-8?B?OXo3YmRvbWJJT2xBcFcvMTl6aDRINkVZaEFqTmxjdXJTbUtVbXZPOWJWcm1u?=
 =?utf-8?B?cElmZFQweTdOQVJxYzFPUWVVU1hwUG1XK0NjY2hiME8ySUYzL3QxbW5ReEs5?=
 =?utf-8?Q?wzEey56eu93yB+AoH/mG64WjC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f28d8d-3352-4e05-0259-08dcf95b72d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 03:23:54.3281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDgAv1eO85+CipPB+YqhyLxGbQ9c5fwDx0+3tnTZOlQaDGYZ9y9twud8RIIeBH+feBe+aBuCr6afNBgbGA1T7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
X-OriginatorOrg: intel.com

SGkgQm9yaXMsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFsu
Li5dDQo+IE9yIG5vdCBkbyBhbnl0aGluZyBhdCBhbGwuIEl0IGhhcyBiZWVuIHRoYXQgd2F5IGZv
ciBvdmVyIGEgZGVjYWRlIGFuZCBoYXNuJ3QNCj4gYm90aGVyZWQgYW55b25lLiBMZXQncyBub3Qg
Z2V0IG92ZXJlYWdlci4NCg0KVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cgeW91ciB0aG91Z2h0
cy4NCk9LLiBJJ2xsIGRyb3AgdGhpcyBwYXJ0IGluIHRoZSBuZXh0IHZlcnNpb24uIA0KDQotUWl1
eHUNCg0K

