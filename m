Return-Path: <linux-edac+bounces-4345-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6AB01360
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jul 2025 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212A65839D8
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jul 2025 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D995128395;
	Fri, 11 Jul 2025 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyhF1vFo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596DA92E;
	Fri, 11 Jul 2025 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214576; cv=fail; b=C61DdyHQ/yg7at30nii8MM/B/fHkDm/hYeapudhp3yzx0efsCUwHz3dHSlKyqz2ttD3SMkh0FNwe9ug4ENBT9YCDxF34jwsit8lHHVSi7F/ZUg+slCZ1Pgu92YUuPnZDDAXtnT9NCnGOSehxA3/M1ZGI3hX2ipTIMxKgII0iT7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214576; c=relaxed/simple;
	bh=AXtiMqpPPeWidb5gQSI1o4wRIlRK3a1SFqakrW1RvOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QxqK1GHgP2M2x45BA/dRdFqdBnxCOcugoGb2cA2mkGKEUpKc662pjPWoT+KipaRRMSKdouAgZU59ncNq42SYsGqwcnXW+/nCuMck2SAygnTfHf77MLYssqjByGXdP7qhkIpkv6vIz5Qljr43lQxk7U6CeQDUYQArijrTSa4LiB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyhF1vFo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752214576; x=1783750576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AXtiMqpPPeWidb5gQSI1o4wRIlRK3a1SFqakrW1RvOI=;
  b=CyhF1vFo6mnCpECdi6BBBqKZ7D+x6NigkCJ/sRHWeEj6RSzZEN/0sue2
   wgzTyjPoJK0bJ5h64N+M8TlmQcQXGvVj6gPUWfYdnW86T7QV1ZFNrITUm
   D4aAnPuOxnq8NYyGWJlbfw8gONNAvfCtqVZkAjz3gcEmxOTQGtKecK8Z5
   6JrVH8udo+y68bVJlrkggmSyVQ2kHZvTAskgfutoWpv/JJHeRElFrJCfV
   NV3PocfyfTbx4t1zmc4cnPtVI8tQmirAxMjeA0BO6VST2gu/YPzgd5SPA
   lysgq84CidOfBIbdz5rmaNLCi9eRALry1yhvqL7X3z9kM1jbPzROnm5Bm
   g==;
X-CSE-ConnectionGUID: 0ta3o8k5TGaSc/OPQU9eIQ==
X-CSE-MsgGUID: ZLrshIoOQMWS/YJogiS2gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58315616"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="58315616"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:16:11 -0700
X-CSE-ConnectionGUID: eDydFRakQa6WxpKz7Q4QOw==
X-CSE-MsgGUID: Lg1S5YYWQz2bDT0B4RWC7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156632260"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:16:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 23:16:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 23:16:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 23:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpSNkLCebS+fSQNPCeVHbVxd9sSPFiuNsAcNg3gmxPLd1+Xdb/fYwZfRITX43fk5ZfU1AgyPC7LUHc+ex06/4yX7V3LTKU9sAuIOtAqJZV8N7JwYxXK0/hi+wlyliJAEFdqBtVP/MVobNCFHzVwaBNnDQnqLKE3itLTlZH/913mGM1LLxWNHzrb7TYb5jJOHEN4sjV/MgjuyWr4iq7oT/yUq3NloKUVETS/GMwNKKclV3JLlv8eWlsvIxnmewqZU/+nqKiiqjvn03l6nLBQfK+apE9fN4nF/svefHYr7VaxbX7w4WHXmCA6/E2H25J+nsCXomhnhKGiCUqT6q/imvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXtiMqpPPeWidb5gQSI1o4wRIlRK3a1SFqakrW1RvOI=;
 b=jXpMLXFyLRbjQwJenknbR+T4T2GMjsKV+LJUWfJtS56iIrWYRXlxqBvLTS9FPCMb2LlNcNxAW942uTZ6FS1dIVVecsw00lN+SKsSyzXCTvODoQp4ZGhpJj3BmEnX/yc1fI4BReolRIj7ldOHt7k8cSJ5PzQQdz0UPDZ/AD7FQbgwlsQEaYnW6ElrmxYmqEOrr4Ve2LqixE6Zl7I0ASJ/00hCpg7/jhyRq1cPslDHCc694RAXtMbxhrLc1rZaWTNycQxqXvUQRNJu0/TE6aAIrlxfEzqU/YjmbbmhwzLYZUBQNWx4L2FQbXT1xSxaAeVgJ1WGBJ4gQh8fXnBoV6bmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 06:16:06 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8880.027; Fri, 11 Jul 2025
 06:16:06 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: We found a bug in skx_common.c for the latest linux
Thread-Topic: We found a bug in skx_common.c for the latest linux
Thread-Index: AQHb8UCXLp35SLv4qESMGHAJHYuEdbQrOvQwgABGM4CAAMCx8A==
Date: Fri, 11 Jul 2025 06:16:05 +0000
Message-ID: <CY8PR11MB713497AF56976DEFD1B8EB3E894BA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
 <CY8PR11MB71349230AB9CF3347D333AC48948A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CANZ3JQQdNGjzkAY-VUbs22sveHCsvCtgVkUApfTYFG7wGw1gCg@mail.gmail.com>
In-Reply-To: <CANZ3JQQdNGjzkAY-VUbs22sveHCsvCtgVkUApfTYFG7wGw1gCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tony.luck@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6759:EE_
x-ms-office365-filtering-correlation-id: 37ff2f12-33b7-4ad4-27b6-08ddc0426b79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVZwTm5YMUZ4a0c3WldKOHE4a1dTWFRqNTAwRk03L09rTDQ3WnNlL0hqanFs?=
 =?utf-8?B?RlBpcUZGZE9ReC9NUDFGT3pZRExlMDhyVTdjYmZ5T3dkQk5zK1Q0M1pIYXFH?=
 =?utf-8?B?KzFDN2hQVklrS240b2UreUo0bC8yYTVlK0hIelNnSU8xWnMrUEVnNjJWMFBM?=
 =?utf-8?B?WkhJLzNyQUIxOEdDMENtUUN0amlzYnBYRndFZXlNT3ZHQjczMTRiQUwzMkpX?=
 =?utf-8?B?dnRwYmpzalh0enRCTU15RlhWbnJZSlNFTXlzekhEbktPVWt3RWQvRXhjY1da?=
 =?utf-8?B?VGVxeUFpL2tKWXcwUFA0a0JCdWUwR243QXJmSW1DOVFPZExMOWljaXFId1Na?=
 =?utf-8?B?d1NkVFhsc1Z3TzBCZTJLbWNGMWFncS8wYkp3Vm9nQlNPL1lTd1dadFI0WEI3?=
 =?utf-8?B?NEc1WmJiN05ENXI5dSt5UjBnSnJzV2tTekxHbE54cjE2VjZveUxjMTBsdEFU?=
 =?utf-8?B?NG9MMzZzTGlpVWxGUlo4RWlweTM2ZlhDOUl6bW9KR0lEWGtxNWRBMEpkV0tu?=
 =?utf-8?B?bjVLK0F1dU1nVUxtQ3l4bnR1anBGdzUxUGlDVVVvWGlCNVNlWVJ3RkhOUTZO?=
 =?utf-8?B?aVdYK2JrV1NXTVVjSkQ2OWltalJqMllaVjB2MFduUUwrWDZOMFg5SmxzbnN2?=
 =?utf-8?B?TGJlSWhsdTkxeklJK2ZsTmhvai9IKzFpallYZFJkQVU2SEtIU1FXVy9JaDA5?=
 =?utf-8?B?NE9OVEVhaEV6ZldaQThVQmlscTdRSjgrNERneThvdnVvWHVMQVRVY2ZhdXFr?=
 =?utf-8?B?aEVJbS9SS2pyNG1oVTdnZjc1d3BGNEhUUjZRb2FuMm1YMkFYcURSVnlJZ2Yr?=
 =?utf-8?B?a2VRVDN1dzY5cWphM1pEa3V0QStxd0RLLzM4NXB3SzNBWlpCZmJacFZ1NkJI?=
 =?utf-8?B?U0NQRmhtZzRnTENIMHlVZFgvM1pPc3A2L09vRnYwM1F5RzhPQnBtbGlrVlhn?=
 =?utf-8?B?amZxK2lpejlnQW5mbXhLVVU5K0FQREZZb2NDOWY1OE12WHQxb1A5T2tUdUUz?=
 =?utf-8?B?Qk5lSEVuV1RmbzQxanVOMTlzRUJrM3F2Zk5wL21kY1hHMVllVXlwR1FSakJY?=
 =?utf-8?B?OXd5ZVR4TisvL0lWUGY4MW9BT3NPTG4zUEsrVDFXeWNNZWZNWGtnWFJYeWFa?=
 =?utf-8?B?aFdCVTE5V05xeVNTeUh0QUhuOWFMT2xKUzhrL1p1ckJLQ3NqZURSMTNoUm13?=
 =?utf-8?B?WWZJemdwVVJhOThqdUl4Q1RLS2FXbUcra1d6ck9pL1dnQnJCNHAybE1PV0Fa?=
 =?utf-8?B?djlKQnBYMFRrZEduQzVBMDY3U2lQbnV5Z2J4NXZmdlpzMHhvODZJUDdFN0Qy?=
 =?utf-8?B?ZFA2UU1IUmVLbUI3SFZvakczaCtpK2dZRURYUUhBMU0vNm1peFVUSWZUS0RO?=
 =?utf-8?B?UXZ0WVdqZ2dnRjEzY0xveTlSZVBxR2g5UUFRUHgwaTdUbENZcDdkZVZDVFl1?=
 =?utf-8?B?NjJ6M1hUVTcrb1hHVDJqNjNWNStSRk5waHZZRzJ5R2IwdURwc3ZpVG0yWFRl?=
 =?utf-8?B?QXBGa2lHektLN0pHakhZWWxDNGdIYVV5MDRrbS9RbDRxcTJPYzZ1OWJUVTg3?=
 =?utf-8?B?WDEvTzlVcjRPR1RlaFpzWGhkeVZXOW95SzJmUjBCbTJCMm00elRxMUxkNEp2?=
 =?utf-8?B?N2lUYXVXbzJNRVl6Rll6UjlXbDFKZWJoTW4wOWVqL3ZrMytDZFFNZTc2aGt0?=
 =?utf-8?B?VnJjKzQ4ckFlQ2h3Q0lUT09mZ3YxNldOOVpLVkNZZEt3NEZ4SFprOEVsVFNO?=
 =?utf-8?B?NEVnRTFmcmFlcVVrdnpkSGpuQktITXdsRks5aHFzanBtUkVsWUJqMnBja3hh?=
 =?utf-8?B?QWtWaTRTMGgrVHNzUXhGOUxnM2RGdUdiZE5hcm0rVUZsRi9GdUhjN3JhK2lN?=
 =?utf-8?B?SkwwV3ZCNWZVSkFDT1Q1VHlmdm9LUTRsamltazR3MWF4aHJYb0lqRTg0MVlU?=
 =?utf-8?B?TE5pUnFSM3RkbTZIQ1BIemJjNkVzL21KbkhQams4YjRHTERLU3lNRlhXV2JV?=
 =?utf-8?Q?+K3XXg9LRjoLGu1W4fLCjCnmsgWhQU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTRYTkxXeGFPOEtGd2NvR3oyTFY0RXlQZTZOZXdsbzhpeHRTR1dxS3NXeTBk?=
 =?utf-8?B?ZXNGWmxMWktScCt5dVpBMDFWNE14TndENStwV08xcEplTzdmNUNiUTBiUHUr?=
 =?utf-8?B?bVJUYW9aMEF0RmFLRlMwZnZjYnJ3S2gzRVdURG5KVk9ocDdxSFlDcFlvWXlB?=
 =?utf-8?B?OURBejd2Z2luUDlBM3RHNGRWbS9DZGk2bEg2WGFjdjZwUnVIZzBPZ1pwek43?=
 =?utf-8?B?M2pvM3g5TjFoQVZqenFyYXFFdktZU2NhY1p5MThzbHM0TVA4MVQvbkV0Q0pH?=
 =?utf-8?B?SkpXYlZocVlnVHd2TkJSUUtydHVRUzRoVkxyWVNSdWl5Z3ozUVROdUtuQTdk?=
 =?utf-8?B?Nm9EdlR3M3dSK0k4T3hVc2x1bmdlSk5vUFJjcGo2bTA3T3JBNXJ1MEdWYmk5?=
 =?utf-8?B?UXluTXBKNjZycXR3OWNmRExEMkFyejVGTTVUV3I4Y2JDWkF4MnpzbUZhOCtY?=
 =?utf-8?B?dDBTNzVaQ1pBWnFhRFozVlR3UXg1eGNYV3E3NFErZThwS2h4bVNVZ3l5VENi?=
 =?utf-8?B?ZlNlVURNM1IvMGZhbmxHclFjQmk5VU1Yb0c3SWgxbHlXVHNCZEpjT1V1UTVX?=
 =?utf-8?B?cnlxZTZzWHRMa2Y2TVg4cmVxaHh2SXFsUTBkUnNkaGlmTnFVS0d2VncwakFH?=
 =?utf-8?B?dk5aZE43Vm56d0JPTFZmOEUxNlhRM05WUkZKZXFDVnhYdVBxc2NCc1pIc2xq?=
 =?utf-8?B?dUk2aXRValAzVlRrUUVDK25xMlNPemE2anU4dlpUK2V1ak1FQjdEa1VyNFFP?=
 =?utf-8?B?OGgxcU1pM3BXcDJ0aC9mbmN1b1pjRTdlb0FoNUJHRyt0by9ZRnBOYmJlM2Qw?=
 =?utf-8?B?azluTE5IMGFTWGtWUWwxMFJOZlBQcVI5YWQ2NzhNVVVIdEJkR0JQcE85eC9P?=
 =?utf-8?B?MVh5RzFnRjRwUjZ6WFg2aFZpT1BVbFRwMk02OFU3UmhKNjJoZU1jcFJVdVBw?=
 =?utf-8?B?Q1p4OHNZV0xpTnZoS2JKOGpzN2U2VUQzY2sxNzBmSlRTYlRmMkpEMGxsVEYr?=
 =?utf-8?B?citQS0pQNzlIWCtmdGV4SlBGSTQ3ZVZ3SWgyVVBXNDZSekd5YnBYelhwLzht?=
 =?utf-8?B?dWUrK3FkZ1diV3RLeHBrK3VLOHZ3TjFnS3VLTmlKMVNXd2RORnVSRkJLQWFY?=
 =?utf-8?B?a205dmltb24rNGU0S0RrdDZTbnBNZnhDV1Z3WWxXS0FCYUxDTHhpQXJ2NEtn?=
 =?utf-8?B?ZU5mY2dJTnZDQWZadlhHY1ZkTjlaeGxBU3c1bEdQQmYwTjNsQyswa1hHS0Vu?=
 =?utf-8?B?d05tTEp3RElKNmNRSWc5aWVSNXFHeXg1QjV4U3RtTWs1NERSSTJvR3p3MjMv?=
 =?utf-8?B?MlJVSUZidGV0d2JyN0pFT2YyQXZxRmxIekhoTGs3czg0L014WXl6TEpPeWhk?=
 =?utf-8?B?ei9iYXBmNjQ1a0o2dE80NzBUWGNlYXlWYXkwS21sSjdtMGp5eW1mMVJoMDRh?=
 =?utf-8?B?YU1jdGZMVUtOOFFyTFI0MVVkRDVOTkRjN2NLakQ2ZXNaTXhPN3FoQ3dWT0Ji?=
 =?utf-8?B?M2FySWJDZUhIWDRiLzJua0JkZUxpelRXdGhNYjkxZDNLUjhIM1ptcDdZLzJt?=
 =?utf-8?B?QTZobjExV2RqaFlKak1wenJmVGF3SnMvK0g2Ry9YRzljczRIWDhmSmZYNGpq?=
 =?utf-8?B?c2x4d0J0Y2xSblBsb1htV25FeU1UV2g1cm9qMUx2a0dqT2J5bzEwc2lJNlJI?=
 =?utf-8?B?MHFCcXRlMThnT1dLRUhIYW5tUEI0dVBRS0NvS0pPeHBicjRES1V0UlZUc1By?=
 =?utf-8?B?ZE91UGJqaUZ4cjkvaWg1Vk9VTmJOVnA3dVBEek5nbGxqV2MzWHBZUUlWc1Bp?=
 =?utf-8?B?TnpYMjNaMFEwZ0hCVnVLZzN4a0pjYzNmVC9rT2YwRCtxWUdOYU55Zno3UTZo?=
 =?utf-8?B?cEN1SnpZbmFQNVVzWjNjZk04Q0JFZU5ldFZaRzlrMkxsc2w5YjdpTGpVeklv?=
 =?utf-8?B?ZFhXN1hBdVBFOU41Z2lOT0p3R0RZWlNLUEdkaVBRRjdWUFFOY1U3L1pYRHRq?=
 =?utf-8?B?dXBVRHVyeGgxcEQ4RHl5QTZkMFZqY2Z0bjJ4RkRGUkNqOE82ejdRWGV0azh0?=
 =?utf-8?B?dEkxUUtZR0huTWJMTWxUdWRESndoL2NNRml4Ni9ZWDNpbjVzT3dBQVU2dmdB?=
 =?utf-8?Q?9MDOgq96lfTpm/jkWmSXy752j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ff2f12-33b7-4ad4-27b6-08ddc0426b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 06:16:05.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CwvBcDwYsPJj6bFZb3bDgxE6784AmBtsuOq+Fpg1Gdtkw9Q8qGqPsAV82YiN5Xj0Oy7p/MqI6X9lBmTtG3H0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com

SGkgSGFvcmFuLA0KDQo+IEZyb206IFdhbmcgSGFvcmFuIDxoYW9yYW53YW5nc2VjQGdtYWlsLmNv
bT4NCj4gWy4uLl0NCj4gU3ViamVjdDogUmU6IFdlIGZvdW5kIGEgYnVnIGluIHNreF9jb21tb24u
YyBmb3IgdGhlIGxhdGVzdCBsaW51eA0KPiANCj4gWWVzLCBJIGhhdmUhDQo+IFRoYW5rIHlvdSBm
b3IgeW91ciByZXBseS4NCj4gVGhpcyBpc3N1ZSB3YXMgZGlzY292ZXJlZCB0aHJvdWdoIHN0YXRp
YyBhbmFseXNpcyByYXRoZXIgdGhhbiBhdCBydW50aW1lLCBzbw0KPiB1bmZvcnR1bmF0ZWx5IHdl
IGRvIG5vdCBoYXZlIGEgcmVhbC13b3JsZCBQb0Mgb3Igc3BlY2lmaWMgZG1lc2cgbG9nIGZyb20N
Cj4gc2t4X3Nob3dfcmV0cnlfcmRfZXJyX2xvZygpLg0KPiBUbyBwcm92aWRlIGFkZGl0aW9uYWwg
Y29udGV4dCwgZHVyaW5nIHRoZSBleGVjdXRpb24gb2YNCj4gc2t4X3Nob3dfcmV0cnlfcmRfZXJy
X2xvZyhyZXMsIHNreF9tc2cgKyBsZW4sIE1TR19TSVpFIC0gbGVuLCBzY3J1Yl9lcnIpOyBpZg0K
PiBsZW4gaXMgZ3JlYXRlciB0aGFuIHRoZSBhbGxvY2F0ZWQgTVNHX1NJWkUsIHRoZSBzdWJzZXF1
ZW50IGNhbGwgaW5zaWRlDQo+IHNreF9zaG93X3JldHJ5X3JkX2Vycl9sb2cgc3VjaCBhcyBuID0g
c25wcmludGYobXNnLCBsZW4sICINCj4gcmV0cnlfcmRfZXJyX2xvZ1slLjh4ICUuOHggJS44eCAl
Ljh4ICUuOHhdIiwgbG9nMCwgbG9nMSwgbG9nMiwgbG9nMywgbG9nNCk7IHdpbGwNCj4gcGFzcyBh
biBpbnZhbGlkIGFkZHJlc3MgKHNreF9tc2cgKyBsZW4pIHRoYXQgaGFzIGV4Y2VlZGVkIHRoZSBi
b3VuZHMgb2YgdGhlDQo+IHNreF9tc2cgYnVmZmVyLiBNb3Jlb3ZlciwgdGhlIHNpemUgcGFyYW1l
dGVyIChsZW4pIGJlY29tZXMgbmVnYXRpdmUsIHdoaWNoDQoNClRoZSBzaXplIG9mIHNreF9tc2cg
aXMgMTAyNC4gVGhlIG1heCAibGVuIiBpcyB+NDIwIGJlZm9yZSBlbnRlcmluZw0Kc2t4X3Nob3df
cmV0cnlfcmRfZXJyX2xvZygpLCB3aGljaCBpcyBzaWduaWZpY2FudGx5IGxlc3MgdGhhbiAxMDI0
LiANClRoZXJlZm9yZSwgaXQncyBzYWZlIHRvIGNhbGwgc2t4X3Nob3dfcmV0cnlfcmRfZXJyX2xv
ZygpLg0KDQo+IGlzIHRyZWF0ZWQgYXMgYSB2ZXJ5IGxhcmdlIHBvc2l0aXZlIG51bWJlciBkdWUg
dG8gdGhlIHVzZSBvZiBzaXplX3QuIFRoaXMgY2FuDQo+IHJlc3VsdCBpbiBvdXQtb2YtYm91bmRz
IG1lbW9yeSBhY2Nlc3MgYW5kIHBvdGVudGlhbGx5IGRhbmdlcm91cyBiZWhhdmlvciBpbg0KPiB0
aGUga2VybmVsLg0KDQpBbHRob3VnaCB0aGVyZSBpc24ndCBhIHJlYWwgKmlzc3VlIiB5b3UgZGVz
Y3JpYmVkIGhlcmUgaW4gdGhlIHtza3gsIGkxMG5tfV9lZGFjIGRyaXZlciwgDQppdCBzZWVtcyBz
dGlsbCB3b3J0aHdoaWxlIHRvIHJlcGxhY2Ugc25wcmludGYoKSB3aXRoIHNjbnByaW50ZigpIHRv
IGVuaGFuY2UgY29kZSByb2J1c3RuZXNzLiANCg0KICAgIC0gc25wcmludGYoKSByZXR1cm5zIHRo
ZSB3b3VsZC1iZS1vdXRwdXQgc2l6ZS4NCg0KICAgIC0gc2NucHJpbnRmKCkgcmV0dXJucyB0aGUg
YWN0dWFsIG51bWJlciBvZiBjaGFyYWN0ZXJzIHdyaXR0ZW4gdG8gdGhlIGJ1ZmZlci4gDQogICAg
ICAgICAgICAgICAgICAgICAgICAgIFRoaXMgZW5zdXJlcyB0aGUgc3Vic2VxdWVudCBjYWxscyBk
byBub3QgZXhjZWVkIHRoZSBidWZmZXIgbGltaXQsDQogICAgICAgICAgICAgICAgICAgICAgICAg
IHBhcnRpY3VsYXJseSBpbiBjb2RlIGxpa2U6IGxlbiArPSBzY25wcmludGYoYnVmK2xlbiwgU0la
RSAtIGxlbiwgLi4uKSANCg0KSXQncyBPSyB0byBtZSB0aGF0IEhhb3JhbiByZXBsYWNlcyBzbnBy
aW50ZigpIHdpdGggc2NucHJpbnRmKCkgYW5kIGFwcGxpZXMgdGhlc2UgY2hhbmdlcyB0byANCnRo
ZSBmaWxlczogc2t4X2NvbW1vbi5jLCBza3hfYmFzZS5jLCAgYW5kIGkxMG5tX2Jhc2UuYyBhcyB3
ZWxsLg0KDQpATHVjaywgVG9ueSwgZG8geW91IGFncmVlIHdpdGggSGFvcmFuIHJlcGxhY2luZyBz
bnByaW50ZigpIHdpdGggc2NucHJpbnRmKCkgDQpldmVuIHRob3VnaCBubyBpc3N1ZXMgYXJlIGN1
cnJlbnRseSBvY2N1cnJpbmcgaW4gdGhlIHtza3gsaTEwbm19X2VkYWMgZHJpdmVycz8NCg0KVGhh
bmtzIQ0KLVFpdXh1DQo=

