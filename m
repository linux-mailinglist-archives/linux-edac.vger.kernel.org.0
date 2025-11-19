Return-Path: <linux-edac+bounces-5478-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87951C70625
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45D54E3DFD
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD532F99B0;
	Wed, 19 Nov 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeTehPok"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222728CF6F;
	Wed, 19 Nov 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571921; cv=fail; b=pz9+DCBd7Aol10RN3wswi+a5xEoE5fqvK5oLZAaxPiCTaqFH3vSIhIGOkxeEQz+N3XXyOjJKTNsnemqD4sX7HWng55DxUYRdIrvLwsFfnHGkiczUQTBlKo+FtkhaHO5gS0WFV/I5aLovkGM0mSuPT34VY5uTW4vHUyicVzsfccA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571921; c=relaxed/simple;
	bh=vHYJvub9S+HJmhn8M/8OmxTTYb6hNkdpLEZAFv7n9v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTOCRjyJLD+lOcSK6Xy6UiMRAmH0AEG9Er+48wp/0zuEhiQ/q9e3iAcnNyIoG8JcsVbelsZXj39MPS1MugJOtPrJ0bucG5z04ZH7i+l83Ddp7lpcCQ0Rte9Jw9/2M+DNP6MTDUqGOiyoTjQre4T64BllzcQUX5DRNqptzZJJEZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeTehPok; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763571921; x=1795107921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vHYJvub9S+HJmhn8M/8OmxTTYb6hNkdpLEZAFv7n9v4=;
  b=LeTehPokovtlXA04l2y9+okejc12RYVFeShELrEEIBuKJnOWdK4fz8jo
   A4FWrnYTuB+/bxPaf4aggyDby4jV8zq6Xav813pqHWCdOSHL9L3ydSG/2
   xCRggjXF0ZA0FO3rAS+tZRfaGXDFFT1aHd2Qb7qcsig5zF5PQO2k8Y+iG
   Dphb/Rt/Vdv6R+yVYydqTsS6u1puMezcLuBOZ7HzuBgEcPCMTDRGNJifP
   SJt4qRpeEM9RWFWphSBoM7Pl7+i9C86T6Zf1A7hotwr7LxUGe6lpMQTco
   MI2VGkJgqBfB0c30DYpsKpgODtiFsKqS4DCYTW3hEhfV4hngKIIiNqjYa
   g==;
X-CSE-ConnectionGUID: zknzeeQMStayXTMzdEv50g==
X-CSE-MsgGUID: JBIbRjkuRWGNn4N793FwVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65501235"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65501235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:05:20 -0800
X-CSE-ConnectionGUID: 6yChERUlT8S3tUkMt19XFg==
X-CSE-MsgGUID: 4DxZNz/jR9C6tppZmje+rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190776697"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:05:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 09:05:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 09:05:18 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 09:05:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irXvKm8sY87QyR2ZOYzSTXR7Ozt6DXEmjNgpFKsYWNcoyVCuvbS5ghf/KTEUqqt6y4L+s6zbRmtB/tVdA4lmuzf8ha5XxwiMRDU9NlODB43Uy5+qDcP3Db6b0aIKJa/kI5oLaYVw+wqSzj/024nvsGwNm34FLxYj0ddbtPFC53iS+bgZBktZ8mprTWQXMzE1tNSn6dHxH4BWLylYtLovlFFWCP3KcHEj+xBNSmOpG1sMv/+WchUB6pYiY1VTUVSoFQKNji12/2udefQ838Ov0IvXQ2/8kHMd4K2lXZA6XCX6nM3xmcDPYhaCtwnXsnPBNNJKOyxkZ2wn0nWxx6x+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHYJvub9S+HJmhn8M/8OmxTTYb6hNkdpLEZAFv7n9v4=;
 b=lvNSFV9y4bDKzwPT+jvA6OTQCX1HunKo/9mzw3qHBsUeE2Rnb+o6GNMfviCyp8r/zfOPnVbtjTM00ufZ/+A+eU5D6Yhq4HoG19ZvI/fo0GdFLPWqQAQb08N3CRifOtn0mzNnljyXa7O0BnItdqdjULYTLD8AUcHq3Nv70ZnCZmFIITDPn8B0PIoymrcU0Pe2LBXEF/lQZH/sKaY6IJXnmy2lS19lW9Gffw52Orsz7fnYtVqF501Aav/L5gGNHKzMrTIEwPTP0tIPg+Vqc/5HVXRmGOvaMywTeZVD3PP7aHMhvtPALLaon+DMCIXNvrA3AYzkS6SPGpxowe//7AfEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 17:05:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:05:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "Lai, Yi1" <yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel
 Diamond Rapids servers
Thread-Topic: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel
 Diamond Rapids servers
Thread-Index: AQHcWVvQIPH0ljuE4kmp+eSRIa5crbT6HnsAgAAXQJA=
Date: Wed, 19 Nov 2025 17:05:15 +0000
Message-ID: <SJ1PR11MB608363D7FBC9BF58DE3FFACCFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <20251119134132.2389472-5-qiuxu.zhuo@intel.com>
 <20251119152430.GEaR3hLonaUag36pFg@fat_crate.local>
In-Reply-To: <20251119152430.GEaR3hLonaUag36pFg@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7409:EE_
x-ms-office365-filtering-correlation-id: 1ccc4b84-05d5-46f9-fa5c-08de278dcf26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bVBJVVhoUFdmRlUycUoybG5idDFCYlRwVEp1TG5Zc2tpa1k0WHZvMEFKeVRx?=
 =?utf-8?B?TnIva1M3MUpGeERGK3hKZVUyd0VlY3M3bWFhVUpKYlVoc2c4dEsxV3FzTnRk?=
 =?utf-8?B?RVZQYnIzeE5TWWFnNjlTT3ZpcEtXVTdvZHQ5Qy9hSWpDRkF4ZnAyOTYyUjEr?=
 =?utf-8?B?Wlg5WHNFbFFPcGN5MkJnbCt5RlFwK1FZZkpQbS96K0t3S0lOQUsxc05PMEpP?=
 =?utf-8?B?RnR5K05GSDB5M2xtdmJRQTZNMjM0VWpZdk1XdVZaT1RxTnQvS25uUVM4a2d3?=
 =?utf-8?B?UGMrMzZ0d2hPRFpxNEt5cUlHejUyVmF5QzVwd1QrZEVNWFNoRkNiSHpURFhn?=
 =?utf-8?B?QTRnYWFNVTZnbjFxSU0rYzFuM2V3N2pvSmx4NzhiVEx3cnd5UEZFMkV2OTVh?=
 =?utf-8?B?YWRFRWl1RlhqS2RIN2U3NlpYYk9sSHB3Vkdaa21xV1hZOFBIeCt0ck5zNmlr?=
 =?utf-8?B?bU1sNkpvaWs5dUg1aHBEdzQ3NjBoYms0RFRLcFlaTXZDMWdhSzJRcTd6RkFH?=
 =?utf-8?B?RE90ZlBJaVVKV3hPemtFS3VLODBneHRFdUJrY3EwMGUwSEY4Q3cydXRUR0lZ?=
 =?utf-8?B?V3oyck8yR2o4c0R5WmtVeTVIUFZlVDVQaHpFZlFFU0RaMmtDRHhoaWt0N3Av?=
 =?utf-8?B?OWovQjZkbFppR0k4UDdiMXJKcnl3Y1JzOUVmcjZYdEoveGpkK2hKc1Z3QXdt?=
 =?utf-8?B?S1g2NHNzV1FGMG9naE5abEpSdFhjcjN0Wnl6RzlBY1dQcVczN2NtNTF3LzN5?=
 =?utf-8?B?WmJvakVHR2dnMWlPUHB6ejZRMGNydmhKM3JEZkJkdjFJNzB2eXR2REhZU3Bz?=
 =?utf-8?B?U3BBRk14VEdtd0dNVWJCRi9mNGZudUFJQkdlc2lBak9odks2dkFEeEpUeGho?=
 =?utf-8?B?V3Nyc0RNSEk4YTlCdy9weGQzZElBK2pSMGlDbkNCSjZicFNiaHkvL2Z5azJk?=
 =?utf-8?B?YnVYTTdma3FXb2VkRFF1eTVIL2dmNjY5SXJmOG5TRjdsZDZVVk1RVER3S3c3?=
 =?utf-8?B?TE5DUnJnMVFnKzJ0b05LMDFOQmY1d3c1VjhKNjlwWjlYUEIvelRZUnY5NmNu?=
 =?utf-8?B?eUE3SkpraVdzblN2TU9iY0NIZ3AzeUdDZVVUU0w5Y1ErYWFuMnhzd3NJTCtF?=
 =?utf-8?B?N1BrVTNGRHhHNzNaaFhlNy9HeWV2dVREdHc3RjRIREgvcmtxU1pVeWhtRHJt?=
 =?utf-8?B?bDhBbDFnS2dKYjdBVjQ3WnFUT0ZaSE11QktVeS8ySDFQeUdOOEEzS091MTBL?=
 =?utf-8?B?K2hpT29LL1pycHhreTJuYTFNQ1JUanczY0UzR3o1b24zN2FtTW9XRjFqcmhx?=
 =?utf-8?B?anVJOEhkU0JNN2kyNHJpNzVBQmJqbVJFa2F5S0ZLY1VKcU9aOHlqc1RqNVJF?=
 =?utf-8?B?V3BBMnZKTEJUQVdLVlpIMGZ0UzBSYlBVY3lKSmZEOVBxQWJNYnNsVk9rTFVq?=
 =?utf-8?B?L3dvQk5kODVIZkJ6QXpDSXlLUlByTUhHSnBXS0lhZ3VLQ2thQ0w1c0puZXVK?=
 =?utf-8?B?VHl5SGV5UThubkpzTUdUb2FMM0o5S3VySzMwUDRpbEhaVktIUVNJWHgvOTdi?=
 =?utf-8?B?RzBQb1Izc3BnSEpGdmZXeVlVZnh6dnpWZHpZeUo3MzBwWU1MY2NNZjNMZDM2?=
 =?utf-8?B?bGs3VkFCeDN0c0Y5MFlEdXFBMWpKQjV1bXQ2M0VoUFBxRlc1UmVKQm83NFhP?=
 =?utf-8?B?ZnVLWnpPQVVWM0RqM1k3ekQzWlphK2VOb1Z3ZHZINFVvK3BoVEhXWWxtWkVz?=
 =?utf-8?B?MTBPamw0SkRzQ2pRc21WTzBvcnhpNGhwVHloSVRNY0xIZmVpcC9KZzJ6UnFO?=
 =?utf-8?B?MzNvNjBQRDBGMHhjdlVQSURpWmZoRkl3TmpXOGRCSi9zWDIyTlRiVWNmNVFJ?=
 =?utf-8?B?SmhZcTVKTUo3MERpczF6dzY5QUV6ZG9VMFhrb1BCT3UwcVBsUkVqOWxvU3Iz?=
 =?utf-8?B?VG0zNU9QVTAzdzBiYk92ZWdZS3FsMEU0MzlScjRNS3djWUtJdUc3aHNmMkhr?=
 =?utf-8?B?ajRkaUdTcTB3Z2tGc0ZwSHdES3FXemRnZXF6YTg4S1VOemludE9HYjFkcmQ0?=
 =?utf-8?Q?5P3in5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3ZPdk40SktQZkQvajZZQVkwZ0d2YTE1Nnh0SW4xN0x1TDNIK3JxTlVEUTY2?=
 =?utf-8?B?UlFzL0lWU09EYTBQYjZMMEtJWHNCZ0RYVDhnSE5hTmgrSjR2Qi95OCswZ0pz?=
 =?utf-8?B?bzNpOXZQbzNIam5HQTliQ3pCT3JSTm00N2cveHFUN2xVbzM4M1AvYTF1ai9V?=
 =?utf-8?B?RmI2cklMOHVDOE5YQ0IzdmxTYmNsZ0s0YVN1ck9hdU5kUGw1TnFWenNYaEwv?=
 =?utf-8?B?WDY0Y3RjQjhkRDg1a0x5K25GUlMyci82dXV2cnJEV284TmRzVUoxTHpiSGZq?=
 =?utf-8?B?SnRRYXN3QzYwZDlOeVVqQnlrZ2NsWW1OVlM5SHQ5WFV4aFRTWjF1YmJqNnlJ?=
 =?utf-8?B?SkpqV0tvOGhSSGlySjBmU3ZYN2ticmVmWWZkZXBOUnpSUEc4YTBma2tJRTcy?=
 =?utf-8?B?SzJ0UFBid2h1SFUwRUpiV244d0xTWkJOdEtpQ0pOTmJuVlRWWUk0MEg1dEha?=
 =?utf-8?B?aCt5OWxhN3p3UW9pQjJjU2hwV0UvOTBqOGphR3N6RnNYaStOci9lZlIvVytt?=
 =?utf-8?B?K0lqeWVmZUNDQ0ZLMk5tZWZLR0UwUFNPOUpQVjNaWC9zSi8yZHB2V3dmcGJK?=
 =?utf-8?B?MExoOFJ5M2pENEdpcHUrZmx0TG8zb0NGN2pxU0MwMWNjRDVzZGFidFUrTmQx?=
 =?utf-8?B?R25Ic2RDMEIwbXQ4c3FhN0ZxTDR5K0E2T1AvOS9uUzYySElRS2ZOZ0pvZXdj?=
 =?utf-8?B?eGJlR0Ryb0VxcXJyaitwdWw1K3BVMFpsWnVOYlJGV2JnNTZLbWV0S2FhQzlR?=
 =?utf-8?B?aEJaODlPSGh1eWp3RXJKd2Y3dzYyZVlxbjh4elBJK1I4dVN6VlFJSFlSTkx5?=
 =?utf-8?B?NENKalh2OCtIS1FRR0o5YnIvR2VBYVF3RUpFbURPNVIxNjFVZDZEYVduemcz?=
 =?utf-8?B?amozd0RCZytwZEpUU3NYYVdKd09mbk5TbHIvSUlPS3ZnTnRUU1FubGt5THFK?=
 =?utf-8?B?QjU2S0hyZjBaVmZXbHpobzV1MUpWTkZHK05oelFLVzFwK0VUTlBzcm5VV2RN?=
 =?utf-8?B?anJ6R3BnYStjQzdKa2hyK2ZtMG1TaXBBS0VUZGdLcm92TEt3WmlPT0tJaG9Q?=
 =?utf-8?B?V3dTa3NGeUNRaXNMYzZJWGdCMWJRbW1IdThtMWZqMjNaWWJEaDd6eUw1blhs?=
 =?utf-8?B?WlZxSUdhb290VHNwOFp5UG5rZlkrWVlvb0hmRlM3Y1Iyd2hlWVoxcHZVc0hI?=
 =?utf-8?B?b0xYVytIc0QzWTZJNmt2a29EdWNPenBQUE1JUE0zcm4rdHViNkVESVFxV2RT?=
 =?utf-8?B?RTl5cUN2MHJOMit2RGpGOXdnTm1VclJJZVFrb05IdktqMVh1VVFBSkJBQ0Fv?=
 =?utf-8?B?NXNwWm1iMFU3UitCYVR4Z2M2b0JJdm9NU1VENHBoYy9wTTZwVlZFeHByRTNF?=
 =?utf-8?B?dkZlMWRjbkVRd0Fsc0JMdnkvV2IwRmZGMXV3dXJHWU10bFJiTTRrS1lSTmdF?=
 =?utf-8?B?MWVLcThmVEx2NDA3bmhta3NVMjd4TzdwSHZGa2FLdnVVV1N0WnoxSm9wMFpS?=
 =?utf-8?B?RVQwQmthaVJCeXlnNXJHVUdtSzYwczZGTERYMS9oeDQwamZONFBMWnNyaHdk?=
 =?utf-8?B?Z0VpYVhQYzM2Rmh6OG9GTWdnd1Yyb3c4ZU52Sk1rM0tQTEhqbDFLTGM0ZStl?=
 =?utf-8?B?RE43NEp3MVhybXFrODh1d1RDWVN3c203b1I1UHlsUm9PWEVvbm5SR01YWHdi?=
 =?utf-8?B?QzNJMktZOFIvRGpOQ2dhOEVaelNMenFpRGFXdGw3ejh5Nm1YOFgvNXNBZGtv?=
 =?utf-8?B?UXlFbXpXeFhKMW1Wa3FJV0d1QmV4bldHc0V4SE9VQU9lRHlmRHprTk5Uek96?=
 =?utf-8?B?aEtDbzJid0RxcEh4cWlvbUQ2aG1ubmFBWWNJUnhsK2RkWVF0VlNuZlAzZUky?=
 =?utf-8?B?eFVMOS9XWk5QZTJCaU8waU5YcEZTWWgyd2RSa2dLRzAwTWdldVZ5d280M3VU?=
 =?utf-8?B?SDVuQkM1d0djeXRMZUZjamNpblVHSnNVbWw1N3A5M0Rzdk1EK3ZtVXpzZS9x?=
 =?utf-8?B?eXR2cjZvdUZ5eVNhV0hzdG1RaC8rZStiZC81YWdFY1BVUXhIZG03ZUJxcnZQ?=
 =?utf-8?B?b1ZiS0Qvb0FCOVBlT2NzMnYramJhbDJGTUlKdzRETUdpVFBxMVFxak11T014?=
 =?utf-8?Q?LBz6jypL9Txe2IlM3jixgN9Ez?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc4b84-05d5-46f9-fa5c-08de278dcf26
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 17:05:15.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUAhUMi6cOs5UdXjKZjurbS7WgAkbaVbfgQjXJ9MzdbfKdjDLUimvb3U+1gQaf3xKjR4fT3CaEW9Hn3hU/TU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com

PiBJc24ndCB0aGF0IHdoYXQgd2UgZG8gYWxsIHRoZSB0aW1lIGFueXdheT8gTWFrZSBzdXJlIHRo
ZSBrZXJuZWwgd29ya3Mgb24gbmV3DQo+IGhhcmR3YXJlIGFuZCBzbyBvbi4NCj4NCj4gSSdkIHVu
ZGVyc3RhbmQgaWYgYWRkaW5nIHRoaXMgbmV3IHN1cHBvcnQgd291bGQgbWVhbiB1Z2xpZnlpbmcg
aTEwbm1fZWRhYyBidXQNCj4ganVzdCBiZWNhdXNlIHlvdSBjYW4ndCB0ZXN0IGl0IG9uIG9sZCBo
dyBzb3VuZHMgYSBiaXQgaWZmeS4gQnkgdGhhdCBsb2dpYyB3ZQ0KPiBzaG91bGQgc2ltcGx5IHNw
aXQgb3V0IGEgbmV3IGRyaXZlciBmb3IgZXZlcnkgbmV3IGh3IGdlbmVyYXRpb24gYW5kIGluIHRo
ZQ0KPiBlbmQsIHRoYXQgc3RyYXRlZ3kgd2lsbCBjb21lIGJhY2sgdG8gYml0ZSB5b3UgYmVjYXVz
ZSB5b3UnbGwgZW5kIHVwDQo+IG1haW50YWluaW5nIGEgcGlsZSBvZiBkdXBsaWNhdGVkIGRyaXZl
cnMuDQo+DQo+IFNvIEkgaG9wZSB0aGVyZSBhcmUgbW9yZSB2YWxpZCByZWFzb25zIGp1c3RpZnlp
bmcgYSBuZXcgZHJpdmVyIHRoYW4ganVzdA0KPiAidmFsaWRhdGlvbi4iDQoNClBlcmlvZGljYWxs
eSBpdHMgdGltZSB0byBzdG9wIGhlYXBpbmcgbW9yZSB1Z2xpZmljYXRpb24gb250byB0aGUgY3Vy
cmVudCBkcml2ZXINCmFuZCBjdXQgYSBuZXcgb25lLg0KDQpzYl9lZGFjLmMgKHRoZSAic2IiIHN0
b29kIGZvciBTYW5keSBCcmlkZ2UpIGdvdCB1cGRhdGVzIGZvciBJdnlicmlkZ2UsIEhhc3dlbGws
IEJyb2Fkd2VsbC4NCg0KU2t5bGFrZS9DYXNjYWRlIExha2Ugd2FzIGFuIGluZmxlY3Rpb24gcG9p
bnQgYW5kIHNvIHNreF9lZGFjLmMgd2FzIGJvcm4uDQoNClRoZXJlIHdhcyBlbm91Z2ggY2hhbmdl
cyBpbiBJY2VsYWtlIHRvIHdhcnJhbnQgYSBuZXcgZHJpdmVyLCBhbmQgcmF0aGVyIHRoYW4gbmFt
aW5nDQppdCBiYXNlZCBvbiB0aGUgSWNlbGxha2UgbmFtZSBJIGNhbGxlZCBpdCBpMTBubV9lZGFj
LmMgKHdoaWNoIGdpdmVuIGhvdyBsb25nIEludGVsIGtlcHQNCmJ1aWxkaW5nIG9uIDEwbm0gYW5k
IGRlcml2YXRpdmVzIHR1cm5lZCBvdXQgc3VycHJpc2luZ2x5IGFjY3VyYXRlKS4gQnV0IGluIHRo
aXMgY2FzZSB0aGVyZQ0Kd2FzIGEgbG90IG9mIGNvZGUgdGhhdCBjb3VsZCBiZSBzaGFyZWQuIEl0
IHdhcyBzcGxpdCBvdXQgaW50byBza3hfZWRhY19jb21tb24uYw0KDQppMTBubV9lZGFjLmMgaGFz
IGhhZCBhIGdvb2QgcnVuOiBJY2VsYWtlLCBTYXBwaGlyZSBSYXBpZHMsIEVtZXJhbGQgUmFwaWRz
LCBHcmFuaXRlDQpSYXBpZHMsIFNpZXJyYSBGb3Jlc3QgYW5kIHRoZSB1cGNvbWluZyBDbGVhcndh
dGVyIEZvcmVzdC4NCg0KQnV0IGl0cyB0aW1lIHRvIHN0b3AgcGlsaW5nIG9uIG1vcmUgbW9kZWwg
c3BlY2lmaWMgYml0cy4gVGhlIG5ldyBkcml2ZXIgc3RpbGwgdXNlcyBwbGVudHkgb2YNCnRoZSBz
aGFyZWQgY29kZSBpbiBza3hfZWRhY19jb21tb24uYyAuLi4gc28gY2hhbmdlcyB0aGVyZSBuZWVk
IHRvIGJlIHZhbGlkYXRlZCBvbg0Kc2V2ZW4gb2xkIHBsYXRmb3Jtcy4NCg0KLVRvbnkNCg0KDQo=

