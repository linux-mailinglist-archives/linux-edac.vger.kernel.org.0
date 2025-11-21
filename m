Return-Path: <linux-edac+bounces-5499-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE29C7A2DC
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 15:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A49038184C
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594FF33B963;
	Fri, 21 Nov 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCQGUAJW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E22D1932;
	Fri, 21 Nov 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735103; cv=fail; b=hnOM++icj+kl0EyaQ8GJeW0ouMtMubN9wd12f6kLBrvmPaua/GepPdr4R33LqYGsrhJg0PqGSOPttzP0rNmZJZHFJHXF7dAsSZL3W2UEjaFJZU16KEqL2LnrnKspJwtdon5dk2DBBhJ0/KM8PxmrRvv+IbZIv8V6mZQK/xouH6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735103; c=relaxed/simple;
	bh=cOZVLBO9vHa6p5IvGM2Uqpr3ogqvZe/TjpJWPHGXfl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mz04Rdu6PmEtBy+YNv61RFDhm0FKDtlR8B89AFppXBIvku36nHNcdmYgkHu6d7Xh4FyJ405YdwJRgxsn925SEtAMzU5pYE7whiAccJi7FGf9GZM/+6RfjYkwSKlMmBIwWnqf9LOTG1UDFVtWL1JGIafKtdvY3v7/mcrOFYX4E6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCQGUAJW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763735102; x=1795271102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOZVLBO9vHa6p5IvGM2Uqpr3ogqvZe/TjpJWPHGXfl4=;
  b=UCQGUAJWnJRoSSb4Om8Y8g6agGuiwviEDYVzsoV7zwM4AZtBE/za7IgX
   b5WGOD8bLTnRD8QA0Wiu/C9Vmrv805B9fBUWaCmYG6GplzbyxYncdt1mN
   RKjkTOfYOQBXkJ6uZKArInGVf1ysF3CcPpAOKjodD9d4aynuwVuePMold
   qk/0laG9iGALPXo3HxvJzdYmZCryubtlAPhwVZxt0ujQ5bUZ8d4abpb17
   il9rjoeq+SQK87Lpd7uUN7DLMq0CznJA26RjH9Jv7M1+hv59PJvw/YI8h
   VWzqb/J3SN4gwNDdd7Ih87aoJ39TSGdgir+xwX8ngYvNdtZCxLwmIRU9+
   g==;
X-CSE-ConnectionGUID: bQ1W/UAjQMKS0bwO12nuQg==
X-CSE-MsgGUID: UNV6I90BRYaEcUa9TbVHfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="76440662"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="76440662"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 06:25:00 -0800
X-CSE-ConnectionGUID: TzqZRBg4QUGF6UO2xggB1A==
X-CSE-MsgGUID: Lo8MdZ09Rw+8EJq95CArmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="196652409"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 06:24:59 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 06:24:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 06:24:58 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.66)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 06:24:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVNeN3yk+qY7MEc1IpVg+AJobEM87eE8jR63JBIbQUPHc2kNEuk8BaODhByaR4moAq85bPDOmEHl2bmWJVlNqoNqMhZMuXP08lTKYLPsYgMJyNZ+5nAzx2tD9ipbdY4sUues0WhyLFmbkWg5WwI85r4lLP0J0DNUitk0/UTXh8yvHyB9lkwiB8bQEWqYPx2VzM3f9GtvVg2hg3sEsKKtKMJoJbKd9Zq9X7v4GtmBSys7s4Z+PNj4Ye5a219zFeXBmvUQvmV9u0L9vwBZLiAZzIaPCexgNnKmRWg7INP7ruLdIxqpVAbhfqG+bBEGa5oSRHLI/mkhfaqBgm6+aTBX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOZVLBO9vHa6p5IvGM2Uqpr3ogqvZe/TjpJWPHGXfl4=;
 b=dAVA79+01ub1mDVwULzbKoc3hZqKVBRlP09Gv+QrQjZ49BI+JKWCQLjaOHy1CHtcMdIsC41I2YsaeJKZWoaOhk610ZUCk3rNwjl6TMptSEg1KP3FcUuQbh0RljiUeOffa1d4p7bdd/0c5K4lpx5BUutyk1dmFiQvuDPPPngtL4VrWZC5Qc7VnlZRR+a6QKfO9vm9PQWogYXhRojxARkDjfG5dGSg3qnYS10DqBiF8UAf3apJaF/ENIPXlUzDM9UPuUk/TwOMP1m8yikCJf6cesvCppDlFnXWYALg3IRWD907OthcxoSRysb8Z8rVc3Kx6EhwFT+RvpXTTmhdJWhBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 14:24:56 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 14:24:55 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, Lai Yi <yi1.lai@linux.intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Topic: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Index: AQHcWVsxTtdfmoKPdEe5hxzqLpk4EbT8+P6AgAA3JuA=
Date: Fri, 21 Nov 2025 14:24:55 +0000
Message-ID: <CY8PR11MB7134E82F2AFCEC97BCA9EE2589D5A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <20251121105905.GAaSBF-XQZCXnR6UIx@fat_crate.local>
In-Reply-To: <20251121105905.GAaSBF-XQZCXnR6UIx@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: b7def643-80e1-44b5-db21-08de2909be4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QURjcVI1azlPQ1lpZUlWc0RwR0FrSGtPaVI1UGRKTGVmcjFOVUN1N3BlTjRU?=
 =?utf-8?B?K3NPc2lJMHZodmY1ZERKN1FKWEpRd0N0NXZxWDBNMjZLdFVkOGtnT1A4UEs1?=
 =?utf-8?B?d2dYQkpCQ3NYRGFPVHAxVFNZOXprTk9UVmU5ZGpoRTl3eVd4emJBT2JielBv?=
 =?utf-8?B?cW1VRldURFpmb2hvWWR3YWhvOVZBbUZmSitSNHVHV2hoZWpLYTVodmpVZlNr?=
 =?utf-8?B?djlMVTR0MVRxbVRPU0h0US80NHBUekNUK3plWkk3QmhNYVlvL0FwQWpld1Ni?=
 =?utf-8?B?dzRoSG5LS05aZVZBaS8yb0ZESzkyZHpVVCtaMFYxUkdyRzlUY0lJRDh3dVBR?=
 =?utf-8?B?aEZUWUxyaGsydGU1SjR3UEZoSUFFMkxFaHllQytWaXowRXdBYk9BTTUrNlBQ?=
 =?utf-8?B?WTY2dUxRRXBIL3BpTy8rVkdFbmZKQkliZ2c1OE42OXYxZ0RRSGduNGhDNG8w?=
 =?utf-8?B?b2hxL2t1TE5CZGo0MEV4NzBBdm1KR1p6bXdzVzRmVnl2VENPWUQ5T0dlTFhS?=
 =?utf-8?B?R2FES09NeDhveThHL2JQbHlLUjdMdFVKSjVyb2xBLzlSWVlFMEFSMkJkZGlm?=
 =?utf-8?B?c2N4NXdpNnRxOXplTnVTUWp0M2VFd2lxZENldnF6QnM1Z1ZrSTQrVU44Skhh?=
 =?utf-8?B?NjNCVGhoVmRXSER6eHg3UkFKM2srbVJ0Skk4eTZzLzV1NkIyVm9vdUxtUGRF?=
 =?utf-8?B?d2w1d1FIRDdGbkFqeVVnSFN0ci8wRGRCUlU3NVl3N0NDV1JRbmVWa1dzTEtF?=
 =?utf-8?B?a1BVOGFHeUFoMUo5d2JNN3M4UFVPV2EyRzUrUk5tdnZzbjBrYTNHbm1pOUE3?=
 =?utf-8?B?L09YelhrY21IU0NvYlB4VFh5ZlU5SklZbmpkTEhHMExIZUJDQUJNYTNoNlMz?=
 =?utf-8?B?anRCMXBJY0ZGSnI2Y2s4cDNPM1hQSGdUNzN1UEJwTGNuM1czZStUNEVxOXV3?=
 =?utf-8?B?MmdoVm5pckQzeXZjRDJrYUl2Z2NaWWdYT2g0MnVRUUVaSWdCekI0SzJ2TFNa?=
 =?utf-8?B?SjcwM1ZuRVBWUlFMMFBWRHQxS3Vhdzc0YzRHM0ZONDhsT2k4TkhUM3lQeEV3?=
 =?utf-8?B?UEZ5bFhFMEtqNCtUKzFpTTFxMUY0dVpwQklVclcrUUhnK21TcUt5MmlDQmhE?=
 =?utf-8?B?S0h3U0M2K1JCWE1BZFhNV3VqekFWcTA3Vmgyc1dTaFZoWlJJSkpFS1hxU3U4?=
 =?utf-8?B?aHRTaFdMVENGNG1RdXBJc3BIRmJlTWs2clh1UElrMnkxR2xIQnQwSTVYaVJm?=
 =?utf-8?B?Q0pDR2lKcVI5Z0w4SDdJT0twREVDTFlLOTd3SXYzd0dJTitZY0p5amEzbzJP?=
 =?utf-8?B?djZoMzJQMHRmYUl3eFV4Uk9TVE1qbVBRZzRrRVhpMTlqSFNHbklyTHVSRWdZ?=
 =?utf-8?B?blFLcS93UENsTGhHZ1Zma3NvUGkvMElZd0E3T0NCVHBIbW9JMlRJVWR0MzNt?=
 =?utf-8?B?MkJMb01WUS9mS0dvR3RBMU1UOWs1eWRCYmoyT2JKb1k2RjcyU0l5YlZZUXFD?=
 =?utf-8?B?UEN6bXBNeVkrTWVxbXJkQVZuK0RoV0E4MUdxYUhFcHFHUmUzZWR4NEQ4bDZ1?=
 =?utf-8?B?bm1LaTdabXRwM3BBOTlJTmxnNDdETjZhS3JHZ2VsYlphN2lDNHlXL25JS0xZ?=
 =?utf-8?B?VXJDQW5DZXpPbEFoTFV4MldCSm9wdHN5MSthTXhVNE5vYm14VVpOVVgwTi9L?=
 =?utf-8?B?OFZPVlhtakZ5aU1udzB2L2EyclBIbmt4b1lLY2JlL2oyYzlPYnFQNDV6MkJL?=
 =?utf-8?B?d0twR1RSSm11c0RCcGYwM2JHeC9ERkVvS1RpR1dFYjJ2Q3JQa2lUa0VFVEFy?=
 =?utf-8?B?NkdBTXRob25oVmZWUjkzWHJNUTVlUDJQQ2xobDZ2VVpGNHd6UWJSTk1oMnBl?=
 =?utf-8?B?NmMxaTZFYVA4OFY0QVVQS01acG4yVHNNa0orRmFhaWpHa3ZyT210MXgzUnRR?=
 =?utf-8?B?bXJqUG9NRFVITDlLYVhzeXdiZ1FCS0M5bjR2T2V1dzlZK3p5TXlDUjFiNkc4?=
 =?utf-8?B?enoxY1JpelN6YVIzaFlGMFRSMU1Bc2R4R1BRWjBOMHhnd3pnRm50dzI5eUdX?=
 =?utf-8?Q?udFSTy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZQNy81SDBZY1RxQTZHWE9WMlhuYnhuK1NUaFJtN21RYUpESlc3VTN3Mzd2?=
 =?utf-8?B?LzZzUlF4QzlFeWNDZ2ZGb2dRejE0K1JTOGRGMHhGcksrLzhUVEFoOTlTZWwr?=
 =?utf-8?B?QU5DTzc3YWJxckRiTWhXVExRTThoN20wRDVnMWx1WC9xcUFZU2hqZ0tmN2dk?=
 =?utf-8?B?dHVCL243Z0hvam0vVS9JMHhPYWxqT0x2NHp6N1crREQ3L2lIMkhkbDg5aTN1?=
 =?utf-8?B?V1FheEpJMFdScy9ibkhCT3Bpd29XL203L1d2RlN3YWlySjBHZzhueC9sazFT?=
 =?utf-8?B?UFR2b1FHZ3lSaGlVSDdENm94UFBFQ1R0RzlpVDdsQjFaeHBNUC9wZzl4b2l6?=
 =?utf-8?B?dG5DOFVjR3VLUmcvQm5DRzhVWitFVm50WVNBdWlrOHJnbDR5K1dmNWYrc0Vx?=
 =?utf-8?B?VmUraENlNmVxdGppeWEzMlprL2k5bVNDUTJ6R2FQLzBqRVJ0Y0V1bGpJSW9E?=
 =?utf-8?B?TTEwekoxOUZvMnUwWVJRUnpKK3QrUTkzR244Tkc0YnJ1Q0ZMT21xRVd2bDlR?=
 =?utf-8?B?TUE1M0lFMUVYOE82T0pBdXBEVUhHc0pHbnIyazd5U1N1SVN2eHhpR1o2d3BS?=
 =?utf-8?B?QVdtVVNOTktYRjdDOWtOSG16YXV3YTBxK0FXUEh4d3BjY1RGWFNMWmkxaDd0?=
 =?utf-8?B?U1JOcnZ1ZHl3dklmOHVRODhVRFA4VFA1eHNJMTc3TUtNUDJyKzFrTjZmRDdo?=
 =?utf-8?B?bm9yRnVyaloyMk1NN0NmY3BidWJpVFZmcHZKUHJpaUhPc2k2VWdSQXpkTWNi?=
 =?utf-8?B?d2NPYzNZUGRacXRlYzdNSVBHTWhyM0pPbDFwMGxDeHlPVm5XN0lMenNjU2M4?=
 =?utf-8?B?ampmc2dCR2JTbHYzQ3YvYWo0aFdkUVRQc2hHcGo4bUpDY2czY2VOQVlwaXl1?=
 =?utf-8?B?TElyYk5HK3hhM1AvR0w0RjJmRG1qNHZnOXlaNm0yQmpETDI4cUJ2d01DYmw1?=
 =?utf-8?B?dlVJZE9hcGhqNFlsZGM2N2YybElDaEQvakFaWUw3cXZMZm1NYVlNR1FIZFpr?=
 =?utf-8?B?RTJwOWVncE5FOUsrSmxNUm9UYW1wdXNFRGtZTWtURlVGSDE4YXNEMWM5b0d6?=
 =?utf-8?B?R1A0ZVlHNitkRXZNYXJ2TkFSbXV0VVIzK25nQlNKK2F3VEtJM2tpakNaRHN0?=
 =?utf-8?B?cEtPWTg3TWJqc3lvdjYxcG9XYnlkSWo3RU1XbkE0NDEwbVphVnJUZ3RUZ08w?=
 =?utf-8?B?ZmNmbVJyNVVaUG1GYmJsNGk1WEYxU04wOTZYRzkvRVF2NWgybnVqNlJKdEty?=
 =?utf-8?B?d1BneXllRG1UelVtNjdjMnVVSm1HRS9UU2sxaVdlWDkyTzVVc01OTklWR2ln?=
 =?utf-8?B?TTkyUlZPTCtkU0o2dE5PUTI1Y2pBb0pXdzhqNTlwU0pHbUdhOEh1M0JGOWdk?=
 =?utf-8?B?b2JrbGhKUHd6ZlY5dXRBOCtvditKenZHV0djeVRRMWZIbzYzQ1FwRTJVcHly?=
 =?utf-8?B?dC9oYUJiUzQ1UmtVaDBIUEFiTy9RUExMZ3RmQ1VoV3RrU3JJanlINHVNTXRP?=
 =?utf-8?B?NmI3bGxiNlJTaGVPTXRtWURnZ2t5Skc1R05TS3FvKzRNamd2cXBKbFV5THVL?=
 =?utf-8?B?WUI1NkFVb29VV0ZQNFJUZ01JMVhlbG5CMDdqbGdud3NHaHc0UmN1TW9iZkN6?=
 =?utf-8?B?UzV6NDdDVXV0V2MvWG1nWEczVTByL3VjOTd5N3JSVTNCVTFadjB2SUZKZXdz?=
 =?utf-8?B?VytobDlycTF5ZDlobDg0WTBXSGxMSTgreGRsV2JCOXMyVVdPL0JBUEJXYTJN?=
 =?utf-8?B?d0hoVjdGeFhaclVUd1VXWGRzZlRlTFh1K1dKaTN0aXpTdldUM1ZyNzNZMXBQ?=
 =?utf-8?B?eUVzRkh5eExJYnRuMGd0bjljMFlLVW8zSUQyUTZIUUNmaVpRNk1xaTF1QWk0?=
 =?utf-8?B?ejd4WGZxcHh2QlVML0I1WUdPMlVMYXJrVGFGVlREUTFpZkFjbmI4T1h6VDhO?=
 =?utf-8?B?V3ZNeHM3V3M1Y01FTVFiSHdjSWZGVmJ5aVkvb3hvdEpZV1RadnBRNXgrdWRx?=
 =?utf-8?B?Y2xVZlNNNENXU3JzTFp1OEpGVWExUG1rakIvV1B3TElCd3psaTJHcEpDVzVH?=
 =?utf-8?B?WFpwSEswTUdHbzFRTVR3QUtwTEFManZZVXdHeXdDdWk2SHJ1ZEpaUGFXSlNS?=
 =?utf-8?Q?cHDSMuK+Khl6y0HAB/0mGX4WJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7def643-80e1-44b5-db21-08de2909be4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 14:24:55.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKU6DBSWoVS4L26+cIClIsOsGnAVXsc+FfI0LyKFB6W+q6zjTJXVcGTwy2y1lf6ZqBlZsUI8X0LEmmgwbhd7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com

SGkgQm9yaXMsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNl
bnQ6IEZyaWRheSwgTm92ZW1iZXIgMjEsIDIwMjUgNjo1OSBQTQ0KPiBUbzogWmh1bywgUWl1eHUg
PHFpdXh1LnpodW9AaW50ZWwuY29tPg0KPiBDYzogTHVjaywgVG9ueSA8dG9ueS5sdWNrQGludGVs
LmNvbT47IExhaSBZaSA8eWkxLmxhaUBsaW51eC5pbnRlbC5jb20+OyBsaW51eC0NCj4gZWRhY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwLzddIEVEQUM6IEFkZCBJbnRlbCBEaWFtb25kIFJhcGlkcyBzZXJ2ZXIgc3Vw
cG9ydA0KPiANCj4gWy4uLl0NCj4gbGQ6IGRyaXZlcnMvZWRhYy9za3hfY29tbW9uLm86IGluIGZ1
bmN0aW9uIGBza3hfZ2V0X252ZGltbV9pbmZvJzoNCj4gc2t4X2NvbW1vbi5jOigudGV4dCsweDkz
Yyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYG5maXRfZ2V0X3NtYmlvc19pZCcNCj4gbWFrZVsy
XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLnZtbGludXg6NzI6IHZtbGludXgudW5zdHJpcHBlZF0g
RXJyb3IgMQ0KPiBtYWtlWzFdOiAqKiogWy9ob21lL2FtZC9rZXJuZWwvbGludXgvTWFrZWZpbGU6
MTI0Mjogdm1saW51eF0gRXJyb3IgMg0KPiBtYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLg0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjI0ODogX19zdWItbWFrZV0gRXJy
b3IgMg0KPiANCj4gSXQgbXVzdCBiZSBjb21pbmcgZnJvbSB0aGlzIHNldCBiZWNhdXNlIEkgZGlk
bid0IHNlZSB0aGlzIGJlZm9yZS4NCj4gDQo+IC5jb25maWcgYXR0YWNoZWQuDQo+IA0KDQpUaGFu
a3MgZm9yIHJlcG9ydGluZyB0aGlzIGJ1aWxkIGVycm9yIGFuZCBwcm92aWRpbmcgdGhlIC5jb25m
aWcgZmlsZS4NCkkgY2FuIHJlcHJvZHVjZSB0aGlzIGVycm9yIHdpdGggeW91ciAuY29uZmlnIGZp
bGUuDQoNCkkgZml4ZWQgdGhpcyBlcnJvciB3aXRoIHRoZSBmb2xsb3dpbmcgZGlmZiwgd2hpY2gg
d29ya2VkIG9rIG9uIG15IHNpZGUuDQpDb3VsZCB5b3UgcGxlYXNlIGNoZWNrIHdoZXRoZXIgdGhp
cyBkaWZmIHdvcmtzIG9uIHlvdXIgc2lkZT8gDQoNClRoYW5rcyBzbyBtdWNoIGluIGFkdmFuY2Uh
DQoNCi0tLQ0KDQpBdXRob3I6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0KRGF0
ZTogICBGcmkgTm92IDIxIDIxOjQyOjEzIDIwMjUgKzA4MDANCg0KICAgIEVEQUMvaW1oOiBGaXgg
aW1oX2VkYWMgYnVpbGQgZXJyb3Igd2hlbiBDT05GSUdfQUNQSV9ORklUPW0gYW5kIENPTkZJR19F
REFDX0lNSD15DQoNCiAgICBXaGVuIENPTkZJR19BQ1BJX05GSVQ9bSBhbmQgQ09ORklHX0VEQUNf
SU1IPXksIGl0IHJlc3VsdHMgaW4gdGhlDQogICAgZm9sbG93aW5nIGJ1aWxkIGVycm9yOg0KDQog
ICAgICBsZDogZHJpdmVycy9lZGFjL3NreF9jb21tb24ubzogaW4gZnVuY3Rpb24gc2t4X2dldF9u
dmRpbW1faW5mbyc6DQogICAgICBza3hfY29tbW9uLmM6KC50ZXh0KzB4OTNjKTogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBuZml0X2dldF9zbWJpb3NfaWQnDQoNCiAgICBUaGlzIGlzIGJlY2F1c2Ug
dGhlIGxpYnJhcnkgJ3NreF9lZGFjX2NvbW1vbicgbmVlZGVkIGJ5IHRoZSBidWlsdC1pbg0KICAg
IGltaF9lZGFjIGRyaXZlciBjYWxscyBuZml0X2dldF9zbWJpb3NfaWQoKSBmcm9tIHRoZSBBQ1BJ
X05GSVQNCiAgICBtb2R1bGUuIEJ1aWx0LWluIGNvZGUgY2FuJ3QgY2FsbCBmdW5jdGlvbnMgZnJv
bSBtb2R1bGVzLg0KDQogICAgRml4IHRoaXMgYnVpbGQgZXJyb3IgYnkgZW5zdXJpbmcgQ09ORklH
X0VEQUNfSU1IIGNhbid0IGJlIHkgd2hlbg0KICAgIENPTkZJR19BQ1BJX05GSVQ9bS4NCg0KICAg
IFJlcG9ydGVkLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCiAgICBDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MTEyMTEwNTkwNS5HQWFTQkYtWFFaQ1hu
UjZVSXhAZmF0X2NyYXRlLmxvY2FsLw0KICAgIFNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFp
dXh1LnpodW9AaW50ZWwuY29tPg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL0tjb25maWcg
Yi9kcml2ZXJzL2VkYWMvS2NvbmZpZw0KaW5kZXggZGJkZmM4NjY1NmQxLi4yNmZhNzZlMTYyYzMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9lZGFjL0tj
b25maWcNCkBAIC0yOTQsNiArMjk0LDggQEAgY29uZmlnIEVEQUNfSTEwTk0NCiBjb25maWcgRURB
Q19JTUgNCiAgICAgICAgdHJpc3RhdGUgIkludGVsIEludGVncmF0ZWQgTWVtb3J5L0lPIEh1YiBN
QyINCiAgICAgICAgZGVwZW5kcyBvbiBYODZfNjQgJiYgWDg2X01DRV9JTlRFTCAmJiBBQ1BJDQor
ICAgICAgIGRlcGVuZHMgb24gQUNQSV9ORklUIHx8ICFBQ1BJX05GSVQgIyBpZiBBQ1BJX05GSVQ9
bSwgRURBQ19JTUggY2FuJ3QgYmUgeQ0KKyAgICAgICBzZWxlY3QgRE1JDQogICAgICAgIHNlbGVj
dCBBQ1BJX0FEWEwNCiAgICAgICAgaGVscA0KICAgICAgICAgIFN1cHBvcnQgZm9yIGVycm9yIGRl
dGVjdGlvbiBhbmQgY29ycmVjdGlvbiB0aGUgSW50ZWwNCg0KDQoNCg0KDQoNCg0K

