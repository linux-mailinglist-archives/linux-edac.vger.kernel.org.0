Return-Path: <linux-edac+bounces-3276-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37975A50EA7
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 23:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61109188CA72
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CEF1FF1A2;
	Wed,  5 Mar 2025 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4ObVKf3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBD4A33;
	Wed,  5 Mar 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214031; cv=fail; b=m2/26PDq+8+IbUZwGE3rkmDR6gM2+F+CpfB6wtKFVdLTRXvSxM6+vcvIUbHuWyPsi7wyDE9CVxU4gm41momD/kbsIqTMvSWReai7eHcM0qH5hWMAxaCgdemQmCSMQEtKRWiQBIGST3EbXinNJMq5vgDoaUUNkDozc2eGon3UIZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214031; c=relaxed/simple;
	bh=8p7O7u9+deNyv5LPpJ2Jr4zL/dRvMeyO4VqQ3Dpea1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlBIHbHtEx4Bf5Op3VxBIRUoQoKuV7ke/XyWciow9Rx32ywDSh+ZWedCBcVsWMJwJMY372tFWrxCBLOgExHm2V3uWr7w8+o7lWZBFGnsb1ngEAXKW/oJhhEY2YbyopxfXS8as0cOkI/q+5L4eyc3W0yM1IcRdCCkG5DuyEufexQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4ObVKf3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741214031; x=1772750031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8p7O7u9+deNyv5LPpJ2Jr4zL/dRvMeyO4VqQ3Dpea1U=;
  b=G4ObVKf3Y1fYW0vBM/ino59bTb+7qsl71n+B0AOpO+D1UhHrNiC9HW+W
   SDLLN4dJEpxp6S1EjK+3uUewy0QQ65cHwDBwv7OEhcJUkYiVM9GB5Jyaw
   E3cJLbwMHXDyMOczPNXNlFJjvrIskKOzgRKnVtTK0dIvil0V5PObEEFEG
   Nnl4LnoPpyGFD/5Ua/GPEoxKlJJh98Jo3VaGme1EhxE6WBmmf+AspcXRF
   fy1lOyCBbetnp9SCE7eSNa7y10PyUM8KeSDqo5C7zH1SM/WYcaV7oTTxe
   vtGX2YONksQiBALm1a63h7aj3NSuYuiQjtYj8GCyoRKJoH5bmnxJ1VmyK
   Q==;
X-CSE-ConnectionGUID: i/BGSvO9Qdm62/hdFajTbw==
X-CSE-MsgGUID: dF9VtER8S02FrIqoPry6Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41911096"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="41911096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 14:33:50 -0800
X-CSE-ConnectionGUID: DlYNUuyZSNS8eVcbl3vQeA==
X-CSE-MsgGUID: s8lqpsgCRTKVWOemfqgnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119746364"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 14:33:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 14:33:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 14:33:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 14:33:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWqGBfKIe+WDwvQEZjHARo9FTpByz4Y8jRXkbXG1e9BcRiw2Jo52Ew6J6yjnamp/O3MHYXNaWX64ddrJ0193nDIqP79jjbROjRduAgX+m3/EWskjNxJA2PAN9D2umJ+8obtNUiT5t8rCZyPnm5VIjwRxQ0m+T4mOMa0cmrdaBGnF21dgVu950NY8N6rV/mYsK6n7jOkexnesg8spUpxlwW9kcJsI5S7hiu1oF0beKZ/nyBXSNQKl5zD15Qn5/N9ZWywAi9rT1ztDkgqcmvEZyp6ZgEoYQkvJacXNl1b1v2gQLA4Rj7369IBnCxrIXa4+owBhXlhCr+wPvmZhGRxuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p7O7u9+deNyv5LPpJ2Jr4zL/dRvMeyO4VqQ3Dpea1U=;
 b=N2dTY+GvOLLGpBwii7sYTcfKFFqQTpx9slLmZHvpPbvh+55GYUZH32KS8vdRO7hD6XZKYAWHrSlBhwi+swK7nhshl7JNHHqt/svUvTKZwPmPrUqGbYMejRtnseupOPlGUitLcYgAc20Xy3hHWUtzzruBWpl6sZpVjTpSdXrLXpsC33DUvTgnc7dlgvN2U123m2C4BPUBPgb/LiPnsZJcxx24NtB+wVKRA7z4q2dHjVwqBSXc0dIdSYj0Qje5JMdZpUfwJXkielUfSv+NLzsg3Q1tq20kTinaZrCw1P1USSzXwnuuX9MS1U83+/PAKA3pITyWNWK8vs9iR0ev49tLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:33:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 22:33:04 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	"Yazen.Ghannam@amd.com" <yazen.ghannam@amd.com>
CC: "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v2 2/5] x86/mce: dump error msg from severities
Thread-Topic: [PATCH v2 2/5] x86/mce: dump error msg from severities
Thread-Index: AQHbgQXyPXX+b5DVvk23qF/fq5InZrNcuPwAgAEn1ACAAFIwAIAAMEuAgABPZwCAAvzzYIACMC2AgADxTtCAAGioEA==
Date: Wed, 5 Mar 2025 22:33:04 +0000
Message-ID: <SJ1PR11MB60837F3079308E3ACF7EC5ADFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
 <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <89027155-8ca3-46a5-8c3a-e24b903cb3eb@linux.alibaba.com>
 <SJ1PR11MB608315FCD2EDF6408A2A05EDFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608315FCD2EDF6408A2A05EDFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB8000:EE_
x-ms-office365-filtering-correlation-id: 2db25f8d-b419-4775-b383-08dd5c35b22b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OS9RZms2WEZMdThLN250ejdteHgybnFnbUgxQkNQRGhiblN1N0JIZVYyS0Ir?=
 =?utf-8?B?Z3dLa3dBbk9xdDRNa0tZREl4TXhVdm9JY0NnSXo2THp5M0pwamNZa0VhQ3l1?=
 =?utf-8?B?VGl0STdzOUtOQnA1K21IdStqSFhRUmRUSzNmWDhjNHQzYzhEemxLWWNaUDh5?=
 =?utf-8?B?T1p6UVlPWThUSUxzdHFiOUZOQTJiVDd5b1pvVXF1QmExb3B4eXBiQjRiWEhG?=
 =?utf-8?B?bVFQb2FrQTdvdHR2K2RTZjZxaVJkbzdBczdJQk5WZCt6eTR4MmlXc0dLUDEv?=
 =?utf-8?B?MlZNbVRIejMwcTZRdkZlcFl4aW42REZjcGRQemVHNm4zZjJNNmxqdHB1Sis4?=
 =?utf-8?B?cjhRcGMxcXo4VEhyU0prUDcxa0I5d3grdGlxNksxRzZ5aURhbS9zZy9TTU5h?=
 =?utf-8?B?UTdXZnZ0bm8zczFHa2MzNVlhU1kwWGhQVms0Y1lWZGI0dkdKZ2NJckc4cHFS?=
 =?utf-8?B?YVlxRkN5Mmt1aVp4d1plSGo3azBHQUNQSXlDSGtKeE83VXBPd2N6Y1BIbUVq?=
 =?utf-8?B?bmhJWGpNTG9PbzNXUWF1ME9WUG96TXpOcmlCdjducDhIL1M5RGhsV2dIRnBB?=
 =?utf-8?B?WGt6WWZBaGFueEpsNFZOT1d6VThVTHlkaVh6QlFWRkQ1NU4vbktkWCtUZFlw?=
 =?utf-8?B?MFk1NWV3d1RwRDZRajFRbU9mZ1RvM3AyR2hBRk5WeXBMUm85VmwxYStVVnFU?=
 =?utf-8?B?eEJ5OEMyK2FoZE5EOXh2NjRMVjFwZWxwaGZHRENzcDFUZWVGUnhpMFNhYWd1?=
 =?utf-8?B?SnJYTldST3RWdWE0cmdHTFJsc1FjRUNQODJkZ3kwcGQ0UFdKTFFrYzd4cDhi?=
 =?utf-8?B?MHZrTkQ1ZFhlSWlJd1ZnNnpJRU1XMlVHT2FVUGxLbWVlSjloMUtCSWJ2M3JF?=
 =?utf-8?B?UklrcVBzaUVlQ0d0cGVqZGNwRjc5bG1oZXUxbUFuWWkwTjh3SHBnbEdWWTJO?=
 =?utf-8?B?QXgxbTk3RGFpSlBnMGpXTlhOOTlrN0I3QWtBL21lR2k2NzhHbkdEQmxjTXA5?=
 =?utf-8?B?bE5YOXFRaHJkLzhWMmh2TlZEZStKNmFEQWRMZ0JPeWc5OXBoQWNESGltWEd5?=
 =?utf-8?B?anhyRy9rYVdGYldoK1lHOHZ1VmJKOHMwcjBTR3VEQ2VwVVZXaXpQMFo3elc3?=
 =?utf-8?B?bnlOZ0JlbUo2c3dJUVgvbytXaEZOS1ZhTTE1VlZQQStyTG5hWm94R0xGRWZj?=
 =?utf-8?B?QjNRb2IybmdzSnBLelcwVWlLdXZIdTFJTTE0OE01cXpkM2szSDNycDJ3cjk4?=
 =?utf-8?B?b2h1VGpZQ2p0bE5naktBc1ZCVGNkMTZ4YzJJMHlZWld2eUY1RVRMVFZDWTJ4?=
 =?utf-8?B?NlY2Y0Z5NmgvSllsTytOWlRJc3JGaGxsUHBiRnI3anI4L3VZZElDYmZTL21K?=
 =?utf-8?B?cy9HbTRZRVZCTENHOVNWaHVIdTRLQ1BqOFJKblYwampXYkNsc2FoMTdtZ1Fw?=
 =?utf-8?B?ZFlxTXJFRVhJM0szdm1pZjFZTC84NnhxNGQ0K28ycWNtcnFQaWJSeEhYb1FF?=
 =?utf-8?B?RkNld0o3blNVc0xPcU0ycG4zaEliT2tQN1JJZGxmbjZrOGVCdFpxRFNKczRl?=
 =?utf-8?B?YjVhR2F6cXVBWEo3VUxzbU5QRHBBbWpLd2gyUTcxbkpqVk4xZ0Zzazd2aG9D?=
 =?utf-8?B?MHZKRm5PQWJzOVpSbFMvVzBSUGhnQytMZDZJVGZ1aTh2bmIwZHZXeksrcnBo?=
 =?utf-8?B?WXVxTC9yVTJML29TV1MxKzl4dmZ2WlJMeU92QXRzZEc1WEdlVlNESmczQVlS?=
 =?utf-8?B?eXpYbS9xQnZQUW1YSENyYm8xa2JGM1lsV1Rtam5yUTNPTzJTTkJxWmRKTEJz?=
 =?utf-8?B?K1REZ0xYYnJRanZUNkdVSC9kYmFtaTVBYWMyQTkrbm9mZms1L2VsYXIyRmNF?=
 =?utf-8?B?MVVmM2d2cTF6TFpaTjVPbW1iZHpRZW1tcVdMSHByYmkzSlkvNDg2d1U0NjRB?=
 =?utf-8?B?RzBqZEFBRVEvVlJLVG50OVBvY2FqaEZRUjVHYjE5U0dtcjBvUUFuN2ZjY2pn?=
 =?utf-8?B?WVl6dUJTM3dRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFINW15Y2w2NkJTR2haOHR0QnFlaWM5TVB3Vm5maGVkd3c5NVhLMXJJZHZ5?=
 =?utf-8?B?SDJuRm9tbERpaFBPbkRrM1pSdVhzUzlUVWpwOStpcTNjV2tTc2E0SzQzNlBF?=
 =?utf-8?B?TDk0dGREMG9hbDJxNUU1YXhPQUkyWVRSQ01odjl0dUdQcTF1ZThWVzFUekJH?=
 =?utf-8?B?SEdkYmxaNnd3VnhjSVNSYlA5SE9ydmxLRmFHWE56RnVLVnRKbGg1MUlsTWkz?=
 =?utf-8?B?Z1YxSEE3Rldkb21lUHlkTVJFME9ySzhaajltM0lNQUhPMEo5N1grNzFwaWtP?=
 =?utf-8?B?NjEzTFNkVmphQjRCVXpFeFc1dndWUVc2L3lIY0diMm9uR0hBUCs0c1gwOXlR?=
 =?utf-8?B?Qkp0R1Rhcm1DUzNUTlpidnVyckw4WWs0eWxkSEVYUStHUGM1Zzc2a1I2anZh?=
 =?utf-8?B?K3IzZ2VEK2ZRbVAzazFNZXVUOW0yV3VkTWR0c3djbEpsV2R0YXhxNnRvZXpl?=
 =?utf-8?B?RURIQUF5dTdyVjZMYTVRRUFwWURmQVRsQ2xOOFdGVFJnZ0p0bit6SnEyVzho?=
 =?utf-8?B?eGxZdlNjVkpKUElSdHk2K3lmNnhVODlRNW5hcnVUOUk1anBoM3JDRi94NmV3?=
 =?utf-8?B?ZmJaU2k3Snhkb3dHUGZxektwUU8wN1Y5OTRPNWVUMGdCU0c5SVNMR2tQVVU4?=
 =?utf-8?B?WXQ5b3VFWGFtSlRXdnZiNTFQaXYrQTVIblk3YTlEalIxdS9FcHoxNmZrdXJq?=
 =?utf-8?B?UDNaNEFvV2tjWi9uRDVWRGt3TTVRNFBFWTJUbjV1VEp3QVptTEJialNsTysz?=
 =?utf-8?B?blFYNlY2L05sVFhmVmFxV2VkczhiaGg5WVh6OWpUbkhzWHdIWUpNVmlVMmk1?=
 =?utf-8?B?SmRiVWNhZE5lSytwQ09XUDhmUHd5aDlVUkFvOEl6UzhMa2cyZzB0ZFNpZzRu?=
 =?utf-8?B?VTlLU3o4dmthM3Z6S090V01zem1pUVhUbDRPaG9OSC9UZ2lHQUVqYzZsYXht?=
 =?utf-8?B?ZjFaZHJMMmQxVWN6ZTF1eW85NXh1cklJYlNRc2VEQTZiZXplZFM2b0NCSVV1?=
 =?utf-8?B?T21wTHM1Rlp2SWw4cXhlL0RKZGdlWkNjSFBBWkxEUis4a3ZDOUNHNk5EWHMr?=
 =?utf-8?B?SkdaUzc4TzNmTWRYUC8zVFJNNm40WEhzSStXR0pOQldacmdVYm11TEtvWXJq?=
 =?utf-8?B?Wm9QYTM3VXl1T2xaN3dxcU5lSnZVTE1uRG1uS0VZOHBBSm5RWmdLblFSMlJC?=
 =?utf-8?B?SDlHQi9yTDlMa0V3SzI4Rk5qWWV2MkZzOEZlSnRMYnpRcmJBRVVLeTNqU3dz?=
 =?utf-8?B?UGw3RG41MC8yRTduM2hFYlJkQzRuK2ZZaDBtYkpPbVJUU3F1QUVoOUttOTI4?=
 =?utf-8?B?WHJLUC9ML2h4OUM2YlRsTHc4RFZSclpVZEVCdzJJeFF4alZQK1lVSVpVd2ha?=
 =?utf-8?B?TlZSNStHK0VRSjFpTWZWVXFyTXlXd2lCenJacmpZL3QvOThwZ1NNOEIwTzNE?=
 =?utf-8?B?T21BaXd5NEdOTUt0MGRnaERLS0ZKM1RjaWRKcmZGakxMOUlPUnIxelFEVWkx?=
 =?utf-8?B?SFN1UU9IWnJjRmY2Wm1iRDlQUTJUWDkyaTVTUS93eG0vSXFIYVZZNEo1Kzlr?=
 =?utf-8?B?MlBHd05LU3F0YlNPQ01vY2huY2djVTVYVGlwTGpPZlBZTkx0ZzNZRldHdm56?=
 =?utf-8?B?QVJoeU5zdXh1WE40TWgzRXI3eGxINkI4ejA4VXFkdDNhbHJNVTFuSlZ6UHBx?=
 =?utf-8?B?SXJ2Mk15K1o4RnIrZ1dCMEFOR2F3QmZtZFFLTU5sbDR6MU1DZmNkYXZ6My90?=
 =?utf-8?B?NFlIRHNMQ1llZmI3cGJONUNIOTYzREtycWZhbmtUbkVHbDhmdHowVWxhQnFK?=
 =?utf-8?B?eThtL2JETVBOam5icnBFZ00veEZvMXFLQTlDVnBZSlcwR01TVEI5RWZMSWtx?=
 =?utf-8?B?VGZyYkNTdjBvT29kdTFVNWlyWEZ4U0JrSGhJbklDUnVPRnZwOHdGR3ZaU0Zp?=
 =?utf-8?B?RWVLREc5TmxMTXAxOVk1UTg2LzRscmlOdmEzZG5VODY0Yk9KRTNreEp2RGVY?=
 =?utf-8?B?Yml1MTg3YXpicTRjaGhjdWU1ZlcxRjRDK0o1Q0NPcEhGSFVFSHpHQzVOekho?=
 =?utf-8?B?bWhkVi9IREFZVmw0M2lzWGxJSytSbkZycWVsV2lrdTJOZlZGc0YrUTMxQkJ5?=
 =?utf-8?Q?oFAQ9k7IbgoWoZJ439ghNLKhG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db25f8d-b419-4775-b383-08dd5c35b22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 22:33:04.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddEWn1o//XKfJigBHZM7Rpyti4gkeKwexNwCtf2YVZ4vgIFwI+rThj0FSMJYjvs2ZjoQALeAqfHVMya3LSOAag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com

Pj4+IDIpIEknZCBsaWtlIHRvIHNlZSBhIHBhdGNoIGZvciBhIHN0YWNrIHRyYWNlIGZvciB0aGUg
dW5yZWNvdmVyYWJsZSBjYXNlLg0KPj4NCj4+IENvdWxkIHlvdSBwcm92aWRlIGFueSByZWZlcmVu
Y2UgbGluayB0byB5b3VyIHByZXZpb3VzIHBhdGNoPw0KPg0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMjA5MjIxOTUxMzYuNTQ1NzUtMS10b255Lmx1Y2tAaW50ZWwuY29tLw0KDQpZ
YXplbiBoYXMgc29tZSBjbGVhbnVwcyB0byB0aGUgc2V2ZXJpdHkgY29kZSB1bmRlciBjb25zaWRl
cmF0aW9uDQpoZXJlOg0KDQpodHRwczovL2dpdGh1Yi5jb20vQU1ERVNFL2xpbnV4L2NvbW1pdC9j
ZjBiOGE5NzI0MGFiZjBmYmQ5OGE5MWNkOGRlYjI2MmY4Mjc3MjFiDQoNCg0KSSB3b25kZXIgaWYg
YSBzbGlnaHRseSBkaWZmZXJlbnQgYXBwcm9hY2ggd2l0aCB0aGUgIm1jZV9hY3Rpb24iIHRoYXQg
WWF6ZW4NCmRlZmluZXMgYmVpbmcgYSBiaXRtYXNrIG9mIG9wdGlvbnMsIGluc3RlYWQgb2YgYW4g
ZW51bSwgd291bGQgYmUgcG9zc2libGU/DQoNCklmIHRoYXQgaGFwcGVuZWQsIHRoZW4gYWRkaW5n
IGEgImR1bXAgdGhlIGNhbGwgc3RhY2sgdG8gdGhlIGNvbnNvbGUiIG9wdGlvbg0Kd291bGQgZml0
IG5lYXRseSBpbnRvIHRoZSBzY2hlbWUuDQoNCi1Ub255DQoNCg==

