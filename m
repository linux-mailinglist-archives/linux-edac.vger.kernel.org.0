Return-Path: <linux-edac+bounces-3001-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B9A2E5FE
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 09:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9C1882B51
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C51AF0AF;
	Mon, 10 Feb 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YB9ST4V/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4A57C93;
	Mon, 10 Feb 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174696; cv=fail; b=kFTdB328V5/xdogbyJzLiWDgOQto7eAJg034KC84qjXnTR8ZTjEWN19QuAzH681sHD/mgAf9g5ChwRlaApvnBffxEbUkksrWVp+xP4Jj52RtMACdwK0v/3w4mOwyzaI2ZHGqw2EOKMTe8/HRL60xaKMilDz4sZS8Kk8UKozTzNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174696; c=relaxed/simple;
	bh=bAEMJFfbqtMXje9KQ7qD9V5YeE1s1e0uNENcgz//+SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKUxQMv/BGeOO76gefK8SmO1l/tBwkLP/Tojq72EHS2FC0e/ddYRC6wveGJsubM+WxjNfFPz/xMB5SPsX9zfTt9WM6tbFt/enn/1wsjI7TGyIdVQyg/HqRRWERuYwPB+c5il5SruNNIU//BOb7QD9aRp2mB/Qv+bRAdTgqf5A94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YB9ST4V/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739174695; x=1770710695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=bAEMJFfbqtMXje9KQ7qD9V5YeE1s1e0uNENcgz//+SM=;
  b=YB9ST4V/xYFRbmhsC7FW+4K8dYEQqeJBngHZ50ewf/Q8dzme3h8eMaHL
   lF1MAOEYhZH7SeN7Znpqsd0/7F4oMQ/maGtHUG5BcAlAqHsHgxJWqrQVG
   c66Gb6GUlIEtjh68bmumdCe7A42v1mk+d0Qf38x2Bzcori635m8wb+GPs
   6UrYByhjR9Ng5u69CjHylVG7YL//xGhzMQ45yi4OJ6TGAdznNyIcSuJG1
   O5hk+TaI64pBqDk8CfYuWzsHV5yRkc1wgRk2fcD13pe7IrWOYt1WLF/lD
   /Rg9rhKJ00NG7o+u1p04/+7gDHfc0drEa2Hjqhv3a1EqSSu+baxYFPdER
   w==;
X-CSE-ConnectionGUID: VNYVyODSS42Q8UkMlLLgEg==
X-CSE-MsgGUID: 4X6edpltRCWHuJlsgCmMLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39654483"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208,223";a="39654483"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:04:50 -0800
X-CSE-ConnectionGUID: SZkNhCeDQNWP7OP33+uI6w==
X-CSE-MsgGUID: FyIFYFoaRs6lz9MO01qUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208,223";a="116716861"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 00:04:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 00:04:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 00:04:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 00:04:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+YpaJbC8RYCER0ttdhw0wZ4gWJtqT1Vv+oi5cokVsGe+fZAlwIWQpCwRQWzZFpFFC5b3aN1ZcyaIWc5M+RNk5/DfJSLvJgUigaMMIGOGtT0c6cPJBkrVGR80PMyAiNTZh6yC8NqupWGxWNOre0t1uAYc3fQr+cjKPBbFSEWeJO9MoN916XuB2dKJB7KHjgb1Aa0wM0grCtx/+2z+pY0voa/QEZQEMgxezwKvfvkV+ilr1eDhso/F0XkZaTR7pnfuij2t8I1Jggw++yL/rV/UD0tbJO1LJLkYRPM0k3wJ7O8uwLj2oi1chawzVqBptk+Kgado2LpXNCfvK5vb3HLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FTCH1lFDKXHhk0PR6204FGLjghgml7osh96MFUWvo=;
 b=pLRb37E6XRRMSjdZlz9oPWX2EwKo94Cm7z1Ur2aIrz08KR4ETNqeIloSpRozg6gC/Rg4LKb1QvZ6raiH853J7rocS0xgMsWw9HESzeqvQn7CMGhpWJhfPibhHxQ9I35gb75yLglbO5qpIEfZYx98okh5XHpMMsqnKcn/jBTHnX5ajx6H/K3naB0qsYKKIMfk2J2N8NLpQis6vCSrqH1/PdRy1TsX/1zeemnRLo7ooOOrylDKwGAxQJhu7JicGwZUDKrQLehhypyK4wkVunwn0s/qteeTTLxO4NScrdSRM6QRT8Mkya5lFXe1QgbSKaL2c5RtQfZuPnv++JPaDcOA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 08:04:44 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 08:04:44 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ramses <ramses@well-founded.dev>, John <therealgraysky@proton.me>
CC: Linux Edac <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Flood of edac-related errors since 6.13
Thread-Topic: Flood of edac-related errors since 6.13
Thread-Index: AQHbeOe8nlKhFFXJVUyTVIAGkw2yWrM7Kj3QgABoeICABJ3RMA==
Date: Mon, 10 Feb 2025 08:04:44 +0000
Message-ID: <CY8PR11MB7134358940D4625E5196349B89F22@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <OISL8Rv--F-9@well-founded.dev>
 <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11.prod.outlook.com>
 <OIUifRt--F-9@well-founded.dev>
In-Reply-To: <OIUifRt--F-9@well-founded.dev>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ramses@well-founded.dev,therealgraysky@proton.me
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB8720:EE_
x-ms-office365-filtering-correlation-id: ddd2b4e5-f581-4160-c276-08dd49a99457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?bXhGYVp3YS9YSDMvZUFBbys2T3ZucFNSUzZMUU52N0c5d1JxQllGMm1Ed3My?=
 =?utf-8?B?aUM4QkNGOWQ0UEZDOXNQRWxodGkydW40V2lwb0dRc2lDYU4wNWE2ZU5JWHQx?=
 =?utf-8?B?bFZqalpHT0VnVC9FdDFHWHYybkFjdzcyZ2UyZjhOaGhaVHVGSUROTStEWU9E?=
 =?utf-8?B?VTlZQ2VDSXlTSmZPNUdXSHp1cXo2bi9IVEdES1c1VmREZi8vZTdCWHVXRUdM?=
 =?utf-8?B?LzU5M1RuaGtPWHF0dWFFRkRNNDdOOC9CMkhoK1IvTEo4ek0vOUwzdHA0cnBv?=
 =?utf-8?B?SlFJNW9PclVUcldPOVdqMlVDZk8zZHFIZ1FUYmtxeTRxM1dCSWt3TVR3MEJI?=
 =?utf-8?B?ZU82NVhESnRtMCtYdTFPVythd0lwdkVPT0o1VDhwRGw2bDU3QVlYbGxWc0Vn?=
 =?utf-8?B?eWt0Q1lxMUd2VGxDaFI5Yk5tMVVQSnFuclB3bGhBQWQ1Y3V1Z1FINW0vOE4x?=
 =?utf-8?B?cjJMZ2FNMWI0VVBmQVNScHZOdm0zTWVkM201b1ZEdWlFWFNlMU8wbTZ2OGhU?=
 =?utf-8?B?NjRRNW1tTVJteXdKdUxyRFZ0NnNpZWJVdXRvM29DWmtQQWZmVWk0NE9QTGYy?=
 =?utf-8?B?ZkVnWkNhQ3M3ekxtUHRxZC9lTXVQOWNtUmFBbWlRcFA5dkRZeW9UcmZML0dw?=
 =?utf-8?B?VHd2ZnJWS2s5dVhOd1RWNkxhQmlNMVhmTm4rWjBjeXZ4dzZDakVtWk5EdUo0?=
 =?utf-8?B?aW9hMDNjMjJLVzZtVUI5NlFvQXIxWitkdU81R0V5RExuNHo4TXVkOTJJWlZh?=
 =?utf-8?B?Q0szZG1iS1VXWmRTOEJ4M2hXRmozL3p6blJyTkNRTFB5RzVMQ0ljL3NOUVR0?=
 =?utf-8?B?Sy9oM0FPL1hZT1lDWmdOSUcwNzV1Qm5FY1VHcXJBTGR2S2Y4VmZ1RlNMamMr?=
 =?utf-8?B?NDZrQ09WeFlvSnV2MTBzQ1plZzJUbExCb1JGazRkL3EwNmtVMnhLeitwVmNk?=
 =?utf-8?B?VDBIQ3BWYUVjUXI0TUNCeUlORGNING8xRXJTbkxEb1hpWGpiNEsrdDB4Qnc3?=
 =?utf-8?B?VVNCVE91OXZXdklLUllUZHRhaFF2MWJxMXM1eFd0WXQ1Z0dvQTVCTnZvL0xa?=
 =?utf-8?B?RjJjQ1BjOTlrTTJORVRYYSs0ZDdWUXRrN0pla3Q5WTM2S1ZhUDlHcFRxUjhn?=
 =?utf-8?B?KzZxVGMyVzJBZXMwMVpINlJrV21JbmtJTFBsZ244MTRVNkpLb2F2QmlxU3Bq?=
 =?utf-8?B?T0ZnWGg2VWtudXpkNVl2WWRqNkxjaGo4NlhZUmRyZDNvQlZSeUFxbGgwUlRN?=
 =?utf-8?B?dEs2MVUwalRzRlhtYzNqelFIdE85NGRWeXl5SUMvTndRWUl6TjJDTU1aNE1D?=
 =?utf-8?B?WVhwYkREcDlTRzZXeElDdE9uenUvdXFja1JMTDRGKzNtM3JHWXVUcmIvSW9r?=
 =?utf-8?B?OG9HR2xRaWwralVkR3I4UXdyNVVFK0FNYWh6OWtsVjBMMlh4c0thaWcyYjkv?=
 =?utf-8?B?TU5LY0dDcm5kVkxzNE1UeVlvMkRVV01ONjM3SkN0ZXZmWTVsSnkwVDZSbTZQ?=
 =?utf-8?B?aW9pTFNvaVNoMkN3d0t5RUIxWG9sODVxcmIyQU1nTHUzalc2VmRYZmFxeC9Y?=
 =?utf-8?B?TUE2ZndJOHlaeUw5c1hrWjhkWTRzc1I2UnN5dVJDODdwcDBkN2s5OGlmTXZQ?=
 =?utf-8?B?TXQvUVhKeU5sbUxLTGUwRTlNZHhaUnlNNHVhTklCNUNsdEN5d1p4d2JCZTVN?=
 =?utf-8?B?K0QxbU03SnE0VDRQUm8xUnpPcVhvN1BINGlocDVhN05BMnh5K0JQRXRqd1RT?=
 =?utf-8?B?ZzRJZnpCcEJlRGQ3S05pOWJrY2loR1BvUkREN1VrRFkvMEJVMk1uYmQ5ck45?=
 =?utf-8?B?WElOVXByYWE1QzlQb2hkU2ZuNUdJWEtQalpFZjlrZmxWSXNQRXFXakZlMTJ5?=
 =?utf-8?B?amt5U0ZwVU92cjZmZEY4bDlOS3l4MHlFdDlYZUJjQkhuTkZwdTlURXkrVHgw?=
 =?utf-8?Q?czVzw+DuCYe2uAvXi0imLjm0grKPMOjN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW9XRFIvdmhlamNKNVA1akhkUFJPWHQ2WlNyOGd5bVU3Q1NyajdkaDhJclFS?=
 =?utf-8?B?dkVqV2p2TnlGUjZvdUhHTFpJcG1PZnUzZU94UlFOTkRkMFM3dVJ0NE5TdEll?=
 =?utf-8?B?azdGRksxbjEwaXprcEdEeThwV21UdVBVcTlTMmJTbnQ0bU5SMnlPQjgxYVJI?=
 =?utf-8?B?Tk00ekpBWmtqZGl2L1UwL3ZCQkRMRnpLRzh4Rkg3MVc4YmE2NSs1bkljZ1ZL?=
 =?utf-8?B?N0RqWnU4RVlYK0h2cFU3d1NlN3hEOG9SdUYxMnkzUlZXa3VsSSs1dmtiYk8v?=
 =?utf-8?B?M1BybnhZVk9hOU1wUi84Ly9aNEhZTCszbnZaZlg1d2JOMEE2dXNiWHRGRnlk?=
 =?utf-8?B?RkZwU29kVEZiMy9IMnVGc2h1Wit2UTBzbCtZWTFCZFQrUThDK2FMb1JsZXJN?=
 =?utf-8?B?dW5xYWh2WFNnZmVzTXU1V1htWlkzVnJqRnJuZTU5QUVKeExGaHR1WHpwZEtQ?=
 =?utf-8?B?UVMyMDlUUlJvKytmb2hTQjVFL0kxanZJM0tBUXRuaXFpT0dvd0UwVmpUSjZF?=
 =?utf-8?B?dlpUWGpxTGo1MHR1SEw4cXQ4WUY5dmpHaVNGVnNlVjNTQlVmQTZDY2NNNiti?=
 =?utf-8?B?Rmx1ejIyWUhLRUZsYWIzWVM3TmwycFI2RXQ4ZGZmdmREWGRDQzliNUdYY2xk?=
 =?utf-8?B?ZlFZc0FHdHp4aTkyZ2xzZFVnMzMwOUpDNDJJc1RoTXR4akl6UWJLcU1sYkNU?=
 =?utf-8?B?d2VnOHFEMWFiSStUT1J5UDA0VHp6Y1dRQzV2OW1UUzJkQVl6ditvMlJvOHpl?=
 =?utf-8?B?U1RQSjAvSW94T2QrUnNMeFQrd0U5VTA0K0VsS3pUOUNNbFVubDU0MFZpK1hI?=
 =?utf-8?B?Q0IyNW13OSs0cDVoSm5EdzZZV2hDeUY2Z0poQXIvdDMvUXU2V2JqaFExY2ZG?=
 =?utf-8?B?dnBQRytpbzNVWUkydWVRL2NmMWl3eVZOd3dnenIwbmwwNHE1UmltN2Z1UmNi?=
 =?utf-8?B?RVFhMVRDeC83WHRIaGJlTXVHWENubjJKOTliTkUwZ2dLS3RLbExqcElvQTNN?=
 =?utf-8?B?Y1ZZbDN3K21BVFVranhwVHlsSUNMOEhhNlluOVBpK2gxS2NvQ1lZRjRNdTZT?=
 =?utf-8?B?cFNvYm8ySDVIWmVYeXZXRmU1NmVMQlJBdUdGYzZCT092OURJaU0zcFE0VUhp?=
 =?utf-8?B?ZVNRQzlvNE5mZjBtSG1Fbm5ieThXb3FkdlNLU3hSN0d1ZDV0aEF2UXl6aC9l?=
 =?utf-8?B?NUVvSUhNUE9VR3F4aGNzdnVXYjZwMjdEeXZpU05Mb3ZDMWNnck1nc2lpQ1Ux?=
 =?utf-8?B?RjRNWkVPNlQ0NG5yWDNGaWNuWDNjRGU1aEpxWFQyQlh4Q09SNCtES3I2dElF?=
 =?utf-8?B?dUFjVG9OK0Zmd2lNZlBmdDdzbVArL2dJYVNEZGVJRTM0R3ZpUlp0bEZGdWFV?=
 =?utf-8?B?K3NiSUdsZ081S25SWUs5aTNlNkdiY1VXYXhzRTI5dFFVZHAzSTJRazVwdGNX?=
 =?utf-8?B?dWl4R09nR01ScExMTGU1R0pIdVBxZGpNYjlTcFpVWGV3K05QRjBxakxCOXlz?=
 =?utf-8?B?QUVadmhiZG9wQUZSTFg5d1cxa3hUajZ4QmNLZEZOT1dRUVQwbWRyZnBGYXlj?=
 =?utf-8?B?b0NTd2cyQ29vOTduT1VzS2t5UURBVzgvWVVyNEltdUNFMGlxdm1qcitRY09W?=
 =?utf-8?B?TWlIVUNkS1FSZFVOVXNGeFVqVlEwcFdsaXczenJONnYyU1JxN3VBeGpVanF2?=
 =?utf-8?B?VlJVUlg5KzQwcVEvV3pPUDMxSEVKT1VqdE5XL05ZV1JhKzZMQ1RmUHdkWnRV?=
 =?utf-8?B?SDgxS1N1cS83bzM3SkNPTzViZGQ0L1RVd1dPOFpDRTZuRktuYXE0WUd2WlVo?=
 =?utf-8?B?VUVmTDBEc0xZTHFxUE1mc3pLQU45RW1SUThpZS84MGpvRHJ3YXM3aFZvVkht?=
 =?utf-8?B?dGc2cUcxS1ArOC9wNWxwWTk0Y3dKNnpZMDd4dk9jamFSYjByQWdoa0FEUnBW?=
 =?utf-8?B?dWIyY29WaVVjcDluTDNlYSsyWFN4R3NsallFcFoyc3MwN3MvakdjSGFRM2tz?=
 =?utf-8?B?cFd1aUhJeElhbHJ0alZTdE4vNEpOYWZnY0gvd3pGcDFRYVlYcWE3L3VSZW9i?=
 =?utf-8?B?VjNPZlhFd2t6T3BKY2Y1cEJYUzBDNUtLaU56c3FRNGNtWDFNcm9qcDlaMUxw?=
 =?utf-8?Q?+nfSSxYmPvX29yJBT6WkN3JmZ?=
Content-Type: multipart/mixed;
	boundary="_002_CY8PR11MB7134358940D4625E5196349B89F22CY8PR11MB7134namp_"
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd2b4e5-f581-4160-c276-08dd49a99457
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 08:04:44.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+EcRAAhtbgK+llriIxAKrSKOSxCQKw2Z7LkJ+dDNReISij5fI40u3rfgMeUgXPJ7CbLTCzWxlC3UuOf/BLFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com

--_002_CY8PR11MB7134358940D4625E5196349B89F22CY8PR11MB7134namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmFtc2VzLA0KDQo+IEZyb206IFJhbXNlcyA8cmFtc2VzQHdlbGwtZm91bmRlZC5kZXY+DQo+
IFsuLi5dDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcmVwbHkhDQo+IA0KPiBJIHJlY29tcGlsZWQg
dGhlIGtlcm5lbCB3aXRoIHRoYXQgb3B0aW9uIGVuYWJsZWQsIGFuZCBhdHRhY2hlZCB0aGUgZG1l
c2cNCj4gb3V0cHV0IHRvIHRoaXMgZW1haWwuIExldCBtZSBrbm93IGlmIEkgY2FuIGRvIGFueXRo
aW5nIGVsc2UgdG8gaGVscCBkZWJ1ZyB0aGlzLg0KDQpUaGFua3MgZm9yIGhlbHBpbmcgZGVidWcg
dGhlIGlzc3VlIGFuZCB0YWtpbmcgdGhlIHVzZWZ1bCBkbWVzZyBsb2cuDQpGcm9tIHRoZSBkbWVz
ZyBsb2csIHRoZSBFQ0MgZXJyb3IgbG9nIHJlZ2lzdGVyIG9mIHRoaXMgU29DIGNvbnRhaW5lZCB0
aGUNCmludmFsaWQgZXJyb3IgdmFsdWUgfjAsIHJlc3VsdGluZyBpbiBhIGZsb29kIG9mIGludmFs
aWQgZXJyb3IgcmVwb3J0cyBpbiBwb2xsaW5nIG1vZGUuDQoNCkBSYW1zZXMgJiBASm9obiwNCkNh
biB5b3UgcGxlYXNlIGFwcGx5IHRoZSBhdHRhY2hlZCBmaXggcGF0Y2ggYW5kIHNlZSB3aGV0aGVy
IGl0IGZpeGVzIHRoZSBpc3N1ZT8NClRoYW5rcyENCg0KLVFpdXh1DQo=

--_002_CY8PR11MB7134358940D4625E5196349B89F22CY8PR11MB7134namp_
Content-Type: application/octet-stream;
	name="0001-EDAC-igen6-Fix-the-flood-of-invalid-error-reports.patch"
Content-Description: 0001-EDAC-igen6-Fix-the-flood-of-invalid-error-reports.patch
Content-Disposition: attachment;
	filename="0001-EDAC-igen6-Fix-the-flood-of-invalid-error-reports.patch";
	size=2007; creation-date="Mon, 10 Feb 2025 07:58:44 GMT";
	modification-date="Mon, 10 Feb 2025 08:04:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYTg0MzU1MGRhMDU4OWExZmFlMmZhNzcxMzc2N2JiYzk4YjNhMDJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4KRGF0
ZTogTW9uLCAxMCBGZWIgMjAyNSAxNToxNzozNyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBF
REFDL2lnZW42OiBGaXggdGhlIGZsb29kIG9mIGludmFsaWQgZXJyb3IgcmVwb3J0cwoKVGhlIEVD
Q19FUlJPUl9MT0cgcmVnaXN0ZXIgb2YgY2VydGFpbiBTb0NzIG1heSBjb250YWluIHRoZSBpbnZh
bGlkIHZhbHVlCn4wLCB3aGljaCByZXN1bHRzIGluIGEgZmxvb2Qgb2YgaW52YWxpZCBlcnJvciBy
ZXBvcnRzIGluIHBvbGxpbmcgbW9kZS4KCkZpeCB0aGUgZmxvb2Qgb2YgaW52YWxpZCBlcnJvciBy
ZXBvcnRzIGJ5IHNraXBwaW5nIHRoZSBpbnZhbGlkIEVDQyBlcnJvcgpsb2cgdmFsdWUgfjAuCgpG
aXhlczogZTE0MjMyYWZhOTQ0ICgiRURBQy9pZ2VuNjogQWRkIHBvbGxpbmcgc3VwcG9ydCIpClJl
cG9ydGVkLWJ5OiBSYW1zZXMgPHJhbXNlc0B3ZWxsLWZvdW5kZWQuZGV2PgpDbG9zZXM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9PSVNMOFJ2LS1GLTlAd2VsbC1mb3VuZGVkLmRldi8KUmVw
b3J0ZWQtYnk6IEpvaG4gPHRoZXJlYWxncmF5c2t5QHByb3Rvbi5tZT4KQ2xvc2VzOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvcDVZY3hPRTZNM05jeHBuMi1JYV93Q3Q2MUVNNEx3SWlOM0xy
b1F2VF8tRzJqTXJGRFNPVzVrMkE5RDhVVXpEMnRvR3BRQk4xZUkwc0w1ZFNLbmtPOGl0ZVplZ0xv
UUVqLUR3UWFNaEd4NEE9QHByb3Rvbi5tZS8KU2lnbmVkLW9mZi1ieTogUWl1eHUgWmh1byA8cWl1
eHUuemh1b0BpbnRlbC5jb20+Ci0tLQogZHJpdmVycy9lZGFjL2lnZW42X2VkYWMuYyB8IDIxICsr
KysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2lnZW42X2VkYWMuYyBiL2Ry
aXZlcnMvZWRhYy9pZ2VuNl9lZGFjLmMKaW5kZXggZmRmM2E4NGZlNjk4Li41OTU5MDhhZjllNWMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZWRhYy9pZ2VuNl9lZGFjLmMKKysrIGIvZHJpdmVycy9lZGFj
L2lnZW42X2VkYWMuYwpAQCAtNzg1LDEzICs3ODUsMjIgQEAgc3RhdGljIHU2NCBlY2Nsb2dfcmVh
ZF9hbmRfY2xlYXIoc3RydWN0IGlnZW42X2ltYyAqaW1jKQogewogCXU2NCBlY2Nsb2cgPSByZWFk
cShpbWMtPndpbmRvdyArIEVDQ19FUlJPUl9MT0dfT0ZGU0VUKTsKIAotCWlmIChlY2Nsb2cgJiAo
RUNDX0VSUk9SX0xPR19DRSB8IEVDQ19FUlJPUl9MT0dfVUUpKSB7Ci0JCS8qIENsZWFyIENFL1VF
IGJpdHMgYnkgd3JpdGluZyAxcyAqLwotCQl3cml0ZXEoZWNjbG9nLCBpbWMtPndpbmRvdyArIEVD
Q19FUlJPUl9MT0dfT0ZGU0VUKTsKLQkJcmV0dXJuIGVjY2xvZzsKLQl9CisJLyoKKwkgKiBRdWly
azogVGhlIEVDQ19FUlJPUl9MT0cgcmVnaXN0ZXIgb2YgY2VydGFpbiBTb0NzIG1heSBjb250YWlu
CisJICogICAgICAgIHRoZSBpbnZhbGlkIHZhbHVlIH4wLiBUaGlzIHdpbGwgcmVzdWx0IGluIGEg
Zmxvb2Qgb2YgaW52YWxpZAorCSAqICAgICAgICBlcnJvciByZXBvcnRzIGluIHBvbGxpbmcgbW9k
ZS4gU2tpcCBpdC4KKwkgKi8KKwlpZiAoZWNjbG9nID09IH4wKQorCQlyZXR1cm4gMDsKIAotCXJl
dHVybiAwOworCS8qIE5laXRoZXIgYSBDRSBub3IgYSBVRS4gU2tpcCBpdC4qLworCWlmICghKGVj
Y2xvZyAmIChFQ0NfRVJST1JfTE9HX0NFIHwgRUNDX0VSUk9SX0xPR19VRSkpKQorCQlyZXR1cm4g
MDsKKworCS8qIENsZWFyIENFL1VFIGJpdHMgYnkgd3JpdGluZyAxcyAqLworCXdyaXRlcShlY2Ns
b2csIGltYy0+d2luZG93ICsgRUNDX0VSUk9SX0xPR19PRkZTRVQpOworCisJcmV0dXJuIGVjY2xv
ZzsKIH0KIAogc3RhdGljIHZvaWQgZXJyc3RzX2NsZWFyKHN0cnVjdCBpZ2VuNl9pbWMgKmltYykK
LS0gCjIuMTcuMQoK

--_002_CY8PR11MB7134358940D4625E5196349B89F22CY8PR11MB7134namp_--

