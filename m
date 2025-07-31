Return-Path: <linux-edac+bounces-4477-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD50FB16A22
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 03:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0873E18C76F3
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51A13D24D;
	Thu, 31 Jul 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8Q+1f6j"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D42F41;
	Thu, 31 Jul 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925322; cv=fail; b=qgNIRBN5LpbuJGPNRidisx36gPfIF4quzlU8ALRwW13527ye+SlgZcHc2BTFyOvW73KmGaZthAW3tILY3h1uPLiw98Aiy0gEgTnYPI3gAMazsiXqru5J5t6knw3+vF2Y4bi5QMZNDEBjkj+hSdE1K1OMlmUvv5i08suwWNPJf4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925322; c=relaxed/simple;
	bh=TIT3KoEjzYntf3E1eiNd0DIk5q35zxoFxOQEb8ajfiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rueYJn4rfSVjYtM8qP0va/cY5LHp3h79YOImCitKhz5JZjGEtmNZ10rVrFZWwr/OV6CiOFfsvneINi4Xj6stbzy0/hW7xvFhpAAIGMr4xqrR0y12j0sOaH2J/gcBNSKP+EX2AlcqlHni61OD4pqtlXPzo332pveFALXY5CF1BCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8Q+1f6j; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753925321; x=1785461321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TIT3KoEjzYntf3E1eiNd0DIk5q35zxoFxOQEb8ajfiU=;
  b=f8Q+1f6jmfny4rlux68/sFsIPOz23Oa5l+ON5GiPP41aGI44CELr6/6o
   PxM47mL2dHIQNB63jSeEEE01SL9OlaB44UszUtxqASiX7bKLBYH1y+T5n
   FyPXLULyoBmGkQH/AHDTYrphIjhs55sN+cm0vX+1nYZEfYFTZOMoS8gZU
   6ccmsNEL2DxKxFcqMEWjA3kDLvpnVLvvkFOiOQSM9hK8GF/bVA+fpiq5h
   Z6kHD1ICGI8TSKI9BdOr5HzWRbQejtoc2zb5zEyDG+2cOPPOwJNfXPrEQ
   04/FSMUEZ6MHiwRxuAPukTCgTkk2qVLjNLB530I7zJ+7zJPjyQVeoYaHb
   A==;
X-CSE-ConnectionGUID: WSkHqqy1Q9yvpsQ9ZytxGw==
X-CSE-MsgGUID: R9DgPCdOQj6E9UWBZtUYvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="81692636"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="81692636"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 18:28:26 -0700
X-CSE-ConnectionGUID: MQOF7QuQTLC9Ie2HCkGKWA==
X-CSE-MsgGUID: IXvc4AqUQj2GzFO6bC1fDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167306683"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 18:28:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 18:28:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 18:28:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 18:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRQRCfzMKDPhF+Xj2WcN0RDSyIDV6ItHKG46l3xd6nlQh12nN/qOmC7Qs3PPp+3QXsHgF2R8r4maGR4bA853GQwumv7JNiZ96dUZ0ZgAd8x0oGyHuqjO++hxuxy4efF3gEQmwPcYuahwCm4hl2hf7jHndl0bY6uW/YxQK6p0uJhjgAHovuTbuTI9FF55+RS91pYpQWp7FOBDHonLrvsSMHPTlJyLJmxlFrHHYu3v8ci4awbeO614XRmvMccIJmIT91Lx+jzmsF8Q2b/nhuiLVGAuXTHK/RVVLuvbFoHbH2MLQnpX3Z9VUqkWHh/UQslrsYKGGf7WeYfago8ssxgbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIT3KoEjzYntf3E1eiNd0DIk5q35zxoFxOQEb8ajfiU=;
 b=jWO+xZfHajKBs/zVLyHsoxWpPid6LK+OSsuB/xHkWkvJrMRdMRZYXpTqOwDgRz2bLjD3ECWP81fQAjcGs5IUgiXpO7ZumzPGF4FEwGsog8CK15+zUQl/rwQEggeVOFBVwf7Pt3vU8rkOnfxhYYWg70xvOHCQQNJs3hunzS/FStopNVDT6vYDPf6fmUz1OrZnbYwy9UYT8tua66DintfAMh0rflpSDoanBHX+uKggMVaRxaBXhXYTYLKPvuVAqL5r4uDbRTLm2XQxUJvayj0OY3YkPaDJQcKTUWnl95D6bZkd0PmblCqHn4fyM18FA6FGXs/ZJAE/ityDdZMehm2qlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Thu, 31 Jul
 2025 01:27:38 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8922.037; Thu, 31 Jul 2025
 01:27:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "kao, acelan" <acelan.kao@canonical.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
 size calculation
Thread-Topic: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
 size calculation
Thread-Index: AQHcARutltp8VFr67UKnYaFhiZ8S4LRKSp5ggAAEGYCAAIr7oIAAjK6AgAALNpA=
Date: Thu, 31 Jul 2025 01:27:37 +0000
Message-ID: <CY8PR11MB7134022A4A28EC6D8D8154E18927A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250730063155.2612379-1-acelan.kao@canonical.com>
 <CY8PR11MB7134149FA7DF6E6C0FC7A9BD8924A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAFv23Qk3vHFk36deq4NUPsE7gihqa9vdSVM2irnEye-KKLpBMg@mail.gmail.com>
 <CY8PR11MB7134BDC448F3DB558917DFCF8924A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAFv23Qk-ypdyDDwNyeSeSWwirE19UtgdR38zWy2NRC+iJVk18w@mail.gmail.com>
In-Reply-To: <CAFv23Qk-ypdyDDwNyeSeSWwirE19UtgdR38zWy2NRC+iJVk18w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6522:EE_
x-ms-office365-filtering-correlation-id: 6406f113-67de-4cf6-aae3-08ddcfd16f11
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TnU2bG04aFRRTC9KbW00RERyVFhUMkdaTTVyZ0IwemZmb3ZjR3QxNVU5blE5?=
 =?utf-8?B?T0Zxcjgwd0hIYmRLVlUwdmVOYjlmVC95ZEZSTG1zQ1lOTk1kU0xmdTZxMmlD?=
 =?utf-8?B?WnBoY0I2M3RQdDdlb0xyWmxiNzc2cnpDbkwzcE83K0pOSXI4VTZtb3FKS1Nm?=
 =?utf-8?B?L1UySEVCMTRrUCtwdHQ1N0FyOVF0NVd5cEVrdVFOU2JBWk5sU2JVUFZDR1cv?=
 =?utf-8?B?Q0wwUFczWUtsbDVnSTZieElnR0YxVkFnc2VTalcxMUdlaWNVN1VwcGZYNDIy?=
 =?utf-8?B?NXZDQXltUHBpN2dId0FNV2lsUmRZWmFpaW5HTHlnWHI5OVZjTzY1bGlXZ0lV?=
 =?utf-8?B?YlAybXZheEZtRkFESGh6azAveXFmNWNoRTNBUWdLNmVqQ1d0TlpzVkRCak1k?=
 =?utf-8?B?MkIwQ0kvV2Y5bklDUFFBbkZhMTZWZWlOOXc0cy9WQWlqZWZva1JVUmp4VXBn?=
 =?utf-8?B?RGJsVituWDBENHVoOHZKUEFMRFd3cFNmSEVkNDJKRi8yV2tUMUEvWXlxNXAv?=
 =?utf-8?B?QklEU3FocXFxR0Q1aCtib0MrcTVYUTZxaTVwZFlBamtwU1VDVmxSZHR3MEZF?=
 =?utf-8?B?Snk0Y0pmUThGbkpEaTVXd1ZSVkpQS0FsRmdyT0JwVGdDbEZ0TGNHSjFsNHRZ?=
 =?utf-8?B?UmlCaWhaTzgzSko1NUcvaytjWUc0eVlkbC81VzE3TmlhWDd6NjEvOWQrRUU0?=
 =?utf-8?B?dTBDRWp5SzFPTkdWeWczZjJTTWZSTVJSM1RKYXJBVVNiSERiYVVhcUlidG5s?=
 =?utf-8?B?NkNaWHlmOEh4bXlIckFVNTl2NnNhQm0wNk8zZXJ2ZkpYQTl0VzFkamdqMzQ4?=
 =?utf-8?B?Rmp5M2U5YVdZaTFWZHJhK0NobWJnMUNPY3lzS0dZTytXSU0xd0gvOE1CT1Jh?=
 =?utf-8?B?RkZFUEU3cXZlcmpFVkNBMEljZDN4OFU0d3d3S3FEcUlvVDZTcUpuT256bjRQ?=
 =?utf-8?B?ekZlNjVSckdmSThLdlpzRVprNkp6Q0VKYXRSREV1cFJlU3VLbEwrZTBHQytZ?=
 =?utf-8?B?aWozUHljK2dOL1hwdDlYeEdPa1kxL0oyWkxYczBqS2hWL09XY0FtZUU5TitK?=
 =?utf-8?B?NkhQN240ZHVQMDI5MkgrZTlrZEk4U2hnTHFKQ3p2dVUyOHgyMDFXbFh1Tk4x?=
 =?utf-8?B?dGpxeGM4ZHB3SzlzWlZJU0swWjVQVUZvcWNCdmJXRnRvOXFlVkEyWjM0UmMr?=
 =?utf-8?B?KzF0TFlnN2t6N29HdXVHR2drMkJzbWFWR2liT3V5TGZMYm5CbUN3L1prNWYz?=
 =?utf-8?B?TUJ6c3hDbDlTM0RramhwVmtpOWV2M2p2WGNRUHRCOWZtUVc1dWhjQlRXNzVS?=
 =?utf-8?B?Zk05MllSMFpHdUxjVWVjbXFycWdTbG0wc3lFWVg1OGZDVkorTjRKQzdXWkNO?=
 =?utf-8?B?eWZxL0gzZ21TU0hmQk4yUGRKTVVOQXJNWlRGekZDc29ZY2Z4YWRUdW01WFJQ?=
 =?utf-8?B?VnYrTzBHSVRlQ1BBWXBKZmorRmdBNkhuWnU3amZWOG95bXltQWtGdjNUWi9N?=
 =?utf-8?B?enhkTkNVY0QvSU5lMmdGSXI5TTZmMGdtSm1TWDZFd0UzSlpGWVVlOVVBSVNv?=
 =?utf-8?B?NlNDN0txamJUbkpGd2pWUzF1MnU5Y2hxaDBVaTVGRERzSnp1UjhwTXZuUWpk?=
 =?utf-8?B?NkJocWF5TVRQUk04RGxtaFBSdHoxYkpZbWtINGlxNEpwNlBsNnNDOHJJRFVH?=
 =?utf-8?B?R3J5WjVBU2hqUnVlakhIbzJ6V3diUk5UWFdPckJnbEU4bVZHaHlVL1lwS1I0?=
 =?utf-8?B?REtwUlUrS1R1YTcrUHlpVXFPcW1IZklkR013aGpGRDN3amV2UnNmcWk3dXBp?=
 =?utf-8?B?aWlRanJxOGt0ZnA0VlZhcWN5NHlpQXZHQ08rSDFPcndzK29QMGNPaEdWbUVi?=
 =?utf-8?B?cmp1cUhzTE9RaWFuTVNydUNVdlk3cFg3cUhnVjhyWjVUOUhxYzhyVG1iREhm?=
 =?utf-8?B?RnU2MjJkaEF0Y2NQOGwwUFlRUFZva0thUEJkZ2MvT2tTRmJhbUxFNW5WY2NZ?=
 =?utf-8?B?ZFNOUmxCaEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJPTWdOcnpaajVHb2pTUWdvRGxSZGdSRWloU1c3NFdZdVJBV0lUd2dZVHpQ?=
 =?utf-8?B?THlGTk4yblEvSTBUNlkyMzkvRTFIczg4QVJDT1JlRXd1bnkwWU90eVpxQ3lt?=
 =?utf-8?B?Mk9OdGEzYldRTWlYYXQ5WUZWamUwdCtYMWM1eWtCWDJqVEFic2gxTFpmNUtE?=
 =?utf-8?B?Ny9uMFdyYndlVmhOcjhXZ2k4NzgvVTczVzI3RzA5ejY3RDFta1Bxd3RqQnFJ?=
 =?utf-8?B?RlR0emNFeHNjOWs2U3c1UjQ4aXNvSnBkRnlIUFFNSmoxOEdYYmEvaU1pczN6?=
 =?utf-8?B?WmxnalEzRklHZ2w1UUVBd3hwQ1pzUVJlTnY3QlgwVG1TUEpYdnhoQ2hObG5D?=
 =?utf-8?B?SXdwbEJQQ1FaQXpTeGZDTC82QmlWVUxMRi9FTkQ4dkhESEptYXBoY3pmRlRJ?=
 =?utf-8?B?c0RSd2hQZTJSancxK0Q1S2YybUJQQkRqQ2lQQ096eXpvSE1QNWZxckRBV2xM?=
 =?utf-8?B?SFFUU1QxUml1Z2JUdnRwSXQzT2FPYXZuRFczbVJDUG56S1dyNjZrVUpHOEQv?=
 =?utf-8?B?c3NodEFUcHJTWkdWd21LbkY2Nm5XRFY4YlErNlhoSWdjM2JhclZCbTNTRC9K?=
 =?utf-8?B?V1lxZDdab1U0RlNyVkZsTlU3ZlpaZ2lKOGZXV3FwcEVtN0pFMVZCR0NrZGgz?=
 =?utf-8?B?RTlGNmVHbUpRaXNMZG9SUkNjVlZ2ZnErR3BnTjdaQUtqejh0THJVbXpmVmRi?=
 =?utf-8?B?MzFFLzhvMHh1UDQ0LzhGOEtBRkppejRyclpJSVRwYVdkSzZGYUhFN3cxd0hm?=
 =?utf-8?B?dGNBZ1FoTmVPaExlN1ZBQlJEVE9qdmhLK1A4bC9IT0wxamhNMFpjaTJTbkww?=
 =?utf-8?B?U3dxQzRVYWIvVmg5SUxKWVRpT1QrYTBUN0JOaHZhU3h6VHNTc3M2T3hXWmFo?=
 =?utf-8?B?NDh1UzFNWWgxWnJySG1RUXoyV3BMUVo1aXNkUkdXaktUWWJUYWwzNlEvTFVk?=
 =?utf-8?B?V3hmWkpvRjU0MGhLeVNhMWNySlgvNXJ0YXBOSnM0K0RweDdXN1NDSW44djFv?=
 =?utf-8?B?d1lhQ3FzYXBiSTIyNitCNzZKMloySkUwSkRMUE5aWGpoQU1hek02L0Q5VzlG?=
 =?utf-8?B?SGp2ekxoMm9wblE0MUpxUGpRNzFxR0RPZlJ1RmVGZ1E0dktWMmNaZnlRbkFD?=
 =?utf-8?B?TC9yRnVxWmZTWXJkbGZKbFI4WE1iNW5pc1RBVVdqTkh2ckhyWSsvNnc1aFVH?=
 =?utf-8?B?WTJzcXc2VGJkeU16dGJEeHJFMHp3VllFUW1WYkpSZjlxckxLRkE2Z0hUMEFJ?=
 =?utf-8?B?cW8rVUFIWUpnd0VhYTFyZkJMUTVpSmxCL2NINCt0bVRucG5TMmhBS3krd1gw?=
 =?utf-8?B?OVdMQzBoVFh0RW0weDlMVjJJOFpNbXhQRDdhYndFQnJVZ0NobVFQMit2RzBD?=
 =?utf-8?B?c2o0cE9yVTBtZUhaMXVzWS9UcVdpKzdnVnUzWVkyWXdTbWttYmxnU21FREMr?=
 =?utf-8?B?NFFMYVJNQUovd0t1Z3ZudEVVREF4STdNN1VRMVUyUzdrTm8yWDdiOHBCRExJ?=
 =?utf-8?B?eExyOGVzZVFGNERpUDcwYUlHempXNEx0SUUrV3hlR0pkY1FsRjZreVpGb3Y1?=
 =?utf-8?B?SnQzY25uMnh2L1BXV3pvYy9NaS9HRktPVnNPR1ZieU9jOTFPMCthYktpQi9N?=
 =?utf-8?B?WU92QVpkelp2K2hTYW11WWRQTDRrbkFFdU1sRVRhY1NkTyttUktVZlhvUCtT?=
 =?utf-8?B?SGZTak9qWVhIU3VkYVJkZ0xtakxiOVNjWjNOQXVnWmc2dnk3VWJGckVWeEZH?=
 =?utf-8?B?MHdwRkpLd2RjQzBIOTE1azVLeGpwNTR3aUdlNWkyTENBdG1tdUVSQmRxNFBs?=
 =?utf-8?B?Tmc0cE9TMXRDcUVHS1VNckNVTlU1VVVNQzVwN1ZlQVdIZ3RuNXRhUjBZRUow?=
 =?utf-8?B?U2lWWFZUWDhRbXRjTHRUSUYzeDVjQWtpM2UxMFpFbDNHMkZ4TGt2Ky9lUlZX?=
 =?utf-8?B?ajgvb3RCTzg2em5DYk1wZTVmem93dmFOc3hGSUJkYUxaUG9TbzJjS29jeklx?=
 =?utf-8?B?L2Rrb1pTK1hiTndIVFI0dlhVc1lraldja2FPS21QbTJWZ0VSTWdNb0IvSm9Z?=
 =?utf-8?B?Nm5yOEU3b0FxSENWVnI0K2hOSW41T2oza3p5WmVlaGxFU0tNWmNiTTdIQmZI?=
 =?utf-8?Q?ePvbltRrWErvpruaUG2Uve/4f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6406f113-67de-4cf6-aae3-08ddcfd16f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 01:27:37.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12lCJj1xJIAbDclq2Toph2cDhUyi5LUMTWp9f1Y7sFD5dvTSBtS47w/wGIf2gOHAsN2Y/tnR3oolFQb33ZXZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com

PiBGcm9tOiBBY2VMYW4gS2FvIDxhY2VsYW4ua2FvQGNhbm9uaWNhbC5jb20+DQo+IFsuLi5dDQo+
ID4gQXR0YWNoZWQgaXMgYSBwYXRjaCB0aGF0IHNraXBzIERJTU0gZW51bWVyYXRpb24gb24gYSBk
aXNhYmxlZCBtZW1vcnkNCj4gPiBjb250cm9sbGVyIHRvIGZpeCB0aGUgY2FsbCB0cmFjZS4gQ291
bGQgeW91IHBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24NCj4gPiB5b3VyIG1hY2hpbmVzIGFuZCBz
aGFyZSB0aGUgZG1lc2cgbG9nPw0KPiBZZXMsIHRoaXMgd29ya3MgZm9yIG1lLg0KDQpUaGFua3Mg
Zm9yIHlvdXIgdGVzdGluZyBmZWVkYmFjay4NCg0KPiANCj4gVGVzdGVkLWJ5OiAgQ2hpYS1MaW4g
S2FvIChBY2VMYW4pIDxhY2VsYW4ua2FvQGNhbm9uaWNhbC5jb20+DQoNCkknbGwgYWRkIHlvdXIg
IlRlc3RlZC1ieSIgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpUaGFua3MhDQotUWl1eHUNCg==

