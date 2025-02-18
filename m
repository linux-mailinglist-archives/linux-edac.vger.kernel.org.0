Return-Path: <linux-edac+bounces-3134-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D020A39D97
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C193B1E50
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D1269D1C;
	Tue, 18 Feb 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gT+E08/h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A726A099;
	Tue, 18 Feb 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885230; cv=fail; b=Ji21aXkDXfzWhR35yLAywxFLc1SFy6n6rd6Sh3H+IGcCzhoXeYP4cAb13DXTbazkUuJ2+C5FgdYiwmQbTvBDf693k9S24UAi3FpnB/b1RXqirOrvb+x/A5E+P4nvZhX5nfA98A+PnFkWV+BrhpTBMQ6L6vBLCDu3CZXELFc94bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885230; c=relaxed/simple;
	bh=bd8tKZ5um4gMtME/hz0B70tYeWxDRabnkHWMNECySG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZK6iO0HUUtAkV+I1auAVqqRiTvmWhtV8B7/R8L+7Lm185sYb/4rivKiAl9VadgqR7gteVO7d92e++evatkH7GrR8xp/f/vDno+Te/6FYBkguAQm3Va0hqoQSkiHMZDNsuuGZLseWmgtSNvrFxhVA9nPmSDMemKwud3P7U4w8jmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gT+E08/h; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739885229; x=1771421229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bd8tKZ5um4gMtME/hz0B70tYeWxDRabnkHWMNECySG8=;
  b=gT+E08/h5G+Q2Y9JcSANJSrteNwVzMRZZJo1Cz6W2I2V9+O37q0wgwQn
   WWZfrDrNaM7azY6iI1DwrqwKGufIPWv3B/HaNHzsX3cJHN32dWx3uy+4S
   A7wqkZGs2vYGSnOenEJ3HikvxE9EFrk04qBNxoOa5glwltoHcHvRzO7w4
   z4qHEU3r6DIAynEAnRZxv5jqPhnLazF2BJJ9J+R6/aeSYPtmtI4aywfA3
   Atol4YyGP8rtRHLPFlmVlHyi3CkGYlVaMs11FhBRacp2JoQIds38QzMfZ
   CSMMpdL6RJi8qXo4rXAxo3SMqg4BNgHpjoJP9AjRldQrvt7kIylJ0Z5Bg
   g==;
X-CSE-ConnectionGUID: qMN3pQtXR2mKL9aE4IRgGA==
X-CSE-MsgGUID: eze2L9FqRoarpzDZMgQ8WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43412821"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="43412821"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:27:08 -0800
X-CSE-ConnectionGUID: zw1ylVFWSHunTeGbVQrxAw==
X-CSE-MsgGUID: yFBQZoTXR8eHo7yuSGzd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118527684"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:27:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Feb 2025 05:27:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 05:27:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 05:27:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT3UpbRav6NW2+FTUz9eitJQ42xo2RD1Vlq8crvDgNjfvB5ix+km/Bj899Dew3TG6snImKeNAGuMLwfrajkg+Qb6Io8Paxa+zm0kc1k9UK2CAEPfz016mbHhlJ6NpimrPorGCQ7GCbBJZxKoSr4xaoo37MM0nT0MeQudiHxYOaYZWN/P7fWy/QLkP40V5/Qzsz/WPU6I26lgKBXPTnfuW3ls72hJTlQEXYFzUG2IjIdBjZuJTUYNbZJU2rrfc0SLvJCwDfhsoM8YH4And4auxyk1qb/NpkvxE6btX/ykLnhcMsH9/X4I2EAbmj9MUaNxpz7F5ssqCIjiS9Xb5hjIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd8tKZ5um4gMtME/hz0B70tYeWxDRabnkHWMNECySG8=;
 b=EPKRbidSfjrn40/TEE0hylKgmef8P9DjXf0q6DNKgqOfcHM49zOQCg+7uw6IFRThnFIjwgjQwqgYITts2tY1fBfwadlXG6NprVtqo33N/iJCP93aOc7cDBSfJ0kItRlDyOXCw02Y/UHp+CGh6Ik4K0zij3ebWpuDg6hn1x6XwG/ZCkZG3hWEsTodF8X8+J0JgqjKJ8CUZulJ362umjP5TOFeryKVTVhN3IEED9pBtAu3RHtbM/jT3zzuDRk1Pls+yphxtqj/zxDqaL/YAEo+bw0fLSCWAmcjFO+4Sr+V1E3q3g0t6mMbNHL1c1zvvzeUQNnK3lM8gCTxiysampx6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS7PR11MB7951.namprd11.prod.outlook.com (2603:10b6:8:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 13:27:04 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 13:27:04 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 15/16] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Thread-Topic: [PATCH v2 15/16] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Thread-Index: AQHbfjgXYCxW+1N1NUa55p1RZvr74bNNEahw
Date: Tue, 18 Feb 2025 13:27:04 +0000
Message-ID: <CY8PR11MB713471B0264788235FA9079389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS7PR11MB7951:EE_
x-ms-office365-filtering-correlation-id: 5476701e-7bb8-4dbf-12a6-08dd501fef2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZExkRmY5MHFzUXRqZUZiVC90VEFzVmtmZEdZRkpZSW93QkZXa2htekRaTk1k?=
 =?utf-8?B?UWNuVkJnQVpSNm5haUtQT2tKYUFKa2sxMFpRQXowWnFGL0luNjBaZzFZSlVw?=
 =?utf-8?B?YlhySGpGUFBVeEd0Z1ZuUmdHc0xSa0pjN0crMHlXWXZRQUxqSm4wVUx4eHBG?=
 =?utf-8?B?MWNLaTFESXM5R0ZHTnoxK29oSGl2WTRlYkdjaEFrOFNSb0swVDErT0hweUFX?=
 =?utf-8?B?SUl4VjVvd1U4UEtkeCtrNk5FSHgweUpiUnVpV05GQVFaQzl0TVFvejA3bDFu?=
 =?utf-8?B?b3hBS2NZMHI1Q3BDNTZBczJkbEVPRElBREJ5ajdzSDVlSnhreC8xdENnd2ho?=
 =?utf-8?B?WU1CZ1pNTHdxeGl4bkl1MlQzTzJESkRsVWRBRzdPYVphQnRGV0MvbkRYeGkz?=
 =?utf-8?B?QStmY3E0WTl2akhYTzRpTUo4cmJkS0tEUmJVTmFpUjVDWGJUeDJqMGFSU1hr?=
 =?utf-8?B?aE5UZ21aU2pZN0JyTU1vM2JqUkg3dE9maVJUc2d5WWRMVG1SWkExNEEzM0dv?=
 =?utf-8?B?dS9vWDlEOTVQY1VUcjYxZW1rQkdtdHJCaGJyK3pWdzA0RHp0NFA2ZEhZbGN0?=
 =?utf-8?B?MEplQ2ozcEo4ZlNCdFNXRHljYzQrMjNRL1ozdCtjdENTZlFOWFdtY0Y3RjhD?=
 =?utf-8?B?eVA3RjFvZk4zK0RXMUEzaUs5QWhpYXRlcFFFTHhqNGlLaFpWVFV2SzJvaG1a?=
 =?utf-8?B?TExITC92RVQvSUNyRmJnSWpXSVFTZFNVcUprRDdqcE5uVkFMUXUrb0IxczRW?=
 =?utf-8?B?ZHF4L3hKRUVjeWFhemZWWWQxMjM5cDl3QWNISFptUFpMTjFxa21nWGRoaFpG?=
 =?utf-8?B?cUxrdC9XbStEUHhPdWk0T1NHTWp4czVOVmt6WDBaNEdzbFJ6TnVnVjFOUGxB?=
 =?utf-8?B?Qk50R3hyWUVWVnBIOXNZS29odWx5K015eldpYlJGTXNabjhUNzBDSngrV2h1?=
 =?utf-8?B?V0VVVWoxdHMvRjRsVEZnWUNVUW5vVEg1SlhSYk1DbFhuc2dIcHVJdzVuRS9y?=
 =?utf-8?B?UER4RXhxYUZLZ1BUYzgxbkI1bkRaSE90ZTZkQWtWcEJjczk1bHdFcU5HUUlX?=
 =?utf-8?B?SjRVbWR5eVhrdkFvc0UvWC9XSEJsTm55bHZCWDB1RGoxUWZKYUM1Wm1JemY4?=
 =?utf-8?B?KzV6azBheTRqN2U2Z3FmR2duR2M4K2dhTkxIVnAyenN6Tmp6RzB4dVNGRFVq?=
 =?utf-8?B?Sk84RisxZG8vN1MzcjZVMUgyY0NzbER5a29EZHhQMGtEQ0JaeEF2dWQyNjht?=
 =?utf-8?B?ZFZOUFVkaFU1bG9Gb3dnMjM0MnJIR3hVU2h1bVlIaVlXL1ZTUnpQaGZTVkN2?=
 =?utf-8?B?eGhjNUdjdWZieDQreE9ncVA5SGNNMkxQdHpMSUtraHRtL2lBTUd6bTNpNFlu?=
 =?utf-8?B?czZEZHgraHF5S1k5YllwWXRkMTU3dGFjak1YWUtJQnVwSHRnZFNDY3FwR0F0?=
 =?utf-8?B?Z05FQXdNOGpwZXRFVXFBN3VWRXZMVkRiRzBYcWY0UzV3aG5jQy9TRnMzc3p6?=
 =?utf-8?B?OXVvMm1yQ3dqWHlGSkFJV3ppRjZhdEFFR0J0TnpsUjBOdFB3NzRWZmhwUU1t?=
 =?utf-8?B?RVhLTk4ySWxZb2lBK29WRW1OUTlJRXBOVExveGJMVXlmdDZlTnNtajAwcGFU?=
 =?utf-8?B?aVVlYzJXQlM5bmRxN1BDaFRFdUhuQ04wR3FpV3o2LzN5ZkI4bHJibnhxSU5Y?=
 =?utf-8?B?UTR4cTFReER6Rlg1c0dEaW83WHJWTDVpdFlMcGREZWNsRXFnN2VnRkc5UzBN?=
 =?utf-8?B?QXdWOFR1dGkybzFPbmF6ZFpQVVdNNUFVVElDeWVmSHhNU0c4YVFnUm9XR1FD?=
 =?utf-8?B?ZlpkZW9aWjRmTWZ3RmhWNmZXaTU2akdOL2tuQmdyU1p3WXZwN1pjTWl1V040?=
 =?utf-8?B?VFF0TzdyRHgwakRWMFBxSEFBM0k4bmdpcEdNNVNTT1J0K0lQbTFOYXNaZzVK?=
 =?utf-8?Q?/ZurHLxwRSS21B3LVLcEvykmzyZ7gcAj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUlRT0dqbk13Y0JLeks3eWR3am05bUQ3N2RIL0p3UnVtZThMYkM2VGRxZDFj?=
 =?utf-8?B?UVAwUllhL1JuUC8vVkQzbk5TS3RSWVBpYm1zZjFVMkNydGlMbEw3OVhkd3J0?=
 =?utf-8?B?YkNrZmg3TnJqT1FWclZuSVVsVm04R00yYWdtcTI2eDBEQnF4RERMR0M4THBJ?=
 =?utf-8?B?UjlJLzJDNVR0TFlqbDA3QUhKUzhSdlR2SHRwRVliSVRpcUxnRFVnZUhjUEZC?=
 =?utf-8?B?WWMxb3htMXVFbjhsUVV3K2F2WE44endWVjJ3SVNqMHFSMVZ2dmVLMFJKaHdL?=
 =?utf-8?B?cGcxZ2o3ejZnZkw4c1ZaeEJJNENhSVltMy9WSytLRnZYT3lxclRKYjBLOGFM?=
 =?utf-8?B?TS8rOVlvbnh1T3RRMlpVY2lYOTFsWS9xVEorWmwxa1V1bnJJY2lkamlVaWpE?=
 =?utf-8?B?cEtJeVpFQXN5U1dhZVFjQ1FkbUhzZ1B0bjBKUTVTc1k3QitDV0k3VTR4WHV6?=
 =?utf-8?B?VEZQVlFXdHZQWlpINmN4cjB1d1F2dS9tK3ZmZ2NYZ2h4Y29ERzM0VzVzK2ZT?=
 =?utf-8?B?bGM5cVk3OHhlVDZVYysxWnJLd1pzd3Jvb1kzK2N1ZGFiR1BYZVBFZjBKUmho?=
 =?utf-8?B?c0JrT3VxOVMrQ0JKVjRjZU5ON2t3eWZYR2gydkU4cmYyNWx3QzlNWjVqaUh5?=
 =?utf-8?B?MXEvSUpiQzl1Q3lnSGF2T1dlZWd5QTBJNmVUM2hCcDdpUHc3NDRWbzY4VWdZ?=
 =?utf-8?B?S3d6NFQxOVdnaG1rbXFmTmEwVGpZdFp2bTJXYStoamEvYms3OGY5YWJQSlYv?=
 =?utf-8?B?QVU5NmpGUFFzbU5kaG5VMlM5YndhSG5IeldQelFTOHQvYWtSRDRPWi9tQ1pV?=
 =?utf-8?B?UW1ZclNKUzE1MG15TWVYV2szK056SWVrMEMyeXRaUnp2QVR4eUU1dm0xZnds?=
 =?utf-8?B?eGw5WktiK2hzSVZpc0dZU1dhSjJmTVlLWTZaRUVTRU5odzdrQUxSVGFyUDhi?=
 =?utf-8?B?TkgrSHFPSWZNWmZjcVIraUU5ZHRIMUp3SUpsazlPM0t6d2VoQXlFVTZGM3VN?=
 =?utf-8?B?aUpVemw3OWVURTJkN0NtcWIrbXNxUkQ5QkpTa2wvd1pvU2JQYXByRXRJQjVH?=
 =?utf-8?B?dU5oWU9vT0FyMGdNVGpwYWNVakxKdG5nWVlkbWpWK1hrNm5oR2VxeHJYSUw0?=
 =?utf-8?B?U3FUMXZkVmZoOXA3eENEV3ZKeHZEK1ZSa21LTHhaYXQ2L0o2TFI0MGJyWFFS?=
 =?utf-8?B?OC9MU3gwYTJqNU9UaVlRcUlrTFUyQXR6RzZEU3NINFpvbC9iYUtlUFpSeW9t?=
 =?utf-8?B?SWVvUWplMUVYT0lSWEtFVStuVkZCR0pTWmpoWWtldzFtcGlWRmI3dmpMTEdW?=
 =?utf-8?B?dTEvWXZvWk1GTUhnTjJSK0o4RFFSMWw2Zy96NzBDZlBsQytwMlVDVG4rMjhF?=
 =?utf-8?B?Q3hJbXFHTXBIRjhkSzdBaTZBS08wWGxTWllvbTV3RWlPazNVMUtXSWlkSnU1?=
 =?utf-8?B?NEpRTDduQ0EyVGt0Q3pRelFVelg5ZlJsTG5QM3cvNWRIUkdCK1dZL1NyYnlU?=
 =?utf-8?B?NDRwejhBbGZmd0ZPbjI4cnRBQm1wWTZBY2FPQXhTOEx5Y09EczZnV2xERGk3?=
 =?utf-8?B?VWpGNTdWMUs4SG5zaTBlZHE3b3ByZEs1V3VWTm5aa1BGQVNoRXUyOXNQV0VY?=
 =?utf-8?B?YkViYkhjVFJtOFdyaTZMbTFWeFR4aWYrSElid1JPVk10ZEVCTXp0MEVocFhr?=
 =?utf-8?B?RGJLS0JVL2pPeWpucWdHNzNZeXhwZExVK1BDLzRCNmtVbVdYbDA2bHVIOXBH?=
 =?utf-8?B?Wk5wS0thb1YzeW1wRmI2R1dIK2p6ZTRubWl4M1JNRER2WWJGNXRuWGY3Q0tl?=
 =?utf-8?B?bXZoQ1piOFgrSnd1ZkdWWnBkMDVkUXQweUQwMWtaa0I2N0NJODIyakVGSi9I?=
 =?utf-8?B?azdvNHhlZjM3RytLUkxOam1xek14OG95aGVlcWxvVmxKS2VrNVBLMjFQYWZw?=
 =?utf-8?B?SndncllSRWxUWERZMi9WMmpFUExKTFRYQTVRaXgvbGFyMFAvT1BNQUQ5cUd1?=
 =?utf-8?B?K1lJUndoV0NLL2VvTHZVY1dzZW40QzcrQ3BzZTA0QytTOVdhc2VuUHE3U1Fl?=
 =?utf-8?B?U0NKVzBOMzZDQk91TmtFM2RXejVDRytMbjY2WkFNWGpPUmlWV2NrU2dwcmxj?=
 =?utf-8?Q?3YiSZjczzv+K97joapI4HlDip?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5476701e-7bb8-4dbf-12a6-08dd501fef2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 13:27:04.2889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/Ph5+g+ZMbWQQjkJ99Ah7jfA04db1EkIaO1UQuEJWZ0Rs3vgnp9wxrwkUd9YQkyIY1NCWg5pSazKl7hV36dfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7951
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFsuLi5dDQo+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWNlL2FtZC5jDQo+IEBAIC0zMDYsNiArMzA2LDExIEBAIHN0YXRpYyB2b2lkIHNt
Y2FfY29uZmlndXJlKHVuc2lnbmVkIGludCBiYW5rLA0KPiB1bnNpZ25lZCBpbnQgY3B1KQ0KPiAg
CQkJaGlnaCB8PSBCSVQoNSk7DQo+ICAJCX0NCj4gDQoNCkRvIHlvdSB0aGluayBpdCB3b3VsZCBi
ZSBiZXR0ZXIgdG8gaGF2ZSBzb21lIGNvbW1lbnRzIG9uIHRoZSB0aHJlc2hvbGRpbmcgDQppbnRl
cnJ1cHQgaGVyZSAoYXMgdGhlIGJpdHMgMTAvOCBsb29rIGxpa2UgbWFnaWMgbnVtYmVycyksIHNp
bWlsYXIgdG8gdGhlIA0KY29tbWVudHMgYWJvdmUgZm9yIHRoZSBkZWZlcnJlZCBpbnRlcnJ1cHQ/
DQoNCj4gKwkJaWYgKChsb3cgJiBCSVQoMTApKSAmJiBkYXRhLT50aHJfaW50cl9lbikgew0KPiAr
CQkJX19zZXRfYml0KGJhbmssIGRhdGEtPnRocl9pbnRyX2JhbmtzKTsNCj4gKwkJCWhpZ2ggfD0g
QklUKDgpOw0KPiArCQl9DQo+ICsNCj4gWy4uLl0NCg==

