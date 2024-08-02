Return-Path: <linux-edac+bounces-1614-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20C945FE7
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C92F1C2212C
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0962139B0;
	Fri,  2 Aug 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fto0uPHx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61B2101B7
	for <linux-edac@vger.kernel.org>; Fri,  2 Aug 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611289; cv=fail; b=plw8Rj7QQQndkTWlurUveAE2BVBybk3eyyy1JAmzE1HCLEA06G1Ulq5MMc2zS4Dq1lubcLI/4gmicDDVPjHvznfSAtp3Wmq/A/5xCFwxvk9tZWtO6GcZ/5jLNksCOCbk5LV9XUO9Ibw8oP2TWhluCN40Ix2PgR2lqfZa3DXM1Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611289; c=relaxed/simple;
	bh=/kdkaFcPQsIw2VJYY9Muu9Izip9PiBVp0K8B6v3ygjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mvU+0Wvcka6zZeaMjDAs95XZAFXaxjZTr8y9DkSQvLtKRpQGoSOHP+oGtUxqx51nIv8Zw+JilAybwbEAjHYW0AP7/sudxQU/OBpSC27Tj7zblHuwIhaPgIpl+81c+byNNeyNsiT/aOicSXRD0dDUA+AO6Ce4OhtfkxdLDxV6vHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fto0uPHx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611287; x=1754147287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/kdkaFcPQsIw2VJYY9Muu9Izip9PiBVp0K8B6v3ygjA=;
  b=fto0uPHxVNwRq/LzhoqA2IAsbahasoINlembSRJnNlzJxUaCkiAxPx7p
   eRL+4CJAhx7JmsoL/wVZesdPTMlS+JlV1leg/O9W6nXRDPi1pQJb+2o1X
   +H9J+tnCpy6caPEVGy55Cp1LOGRd0i+dAIwe0dsaH/9W+5wGgPLKDFtUN
   VlmVeAQwZJhYvaesAdn83G2FMI6Ha5i5FelCQeTtFLFMIvlOh8COTnDKw
   WmMyzcCCwMWqwKQMwHnbuH2XddgNYiw2Pp5SYeNDGSj3qdNNkWDDs2XX1
   qjpOKn6Yz1ytLvAMRblzwoCszdjGBJXZ3tprm+rJD+HjVKKXPtl5t+uzN
   Q==;
X-CSE-ConnectionGUID: pJTI1YMdR8KO75ocyuSKlg==
X-CSE-MsgGUID: g++e+L4eRZiLAw+3Z3vODA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="32034546"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="32034546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:08:07 -0700
X-CSE-ConnectionGUID: wc4jasRWQ+mU3BNrQgIzjQ==
X-CSE-MsgGUID: P9OcfJPIQb+BIz/ZDbYURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="86362008"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 08:08:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 08:08:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 08:08:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 08:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7msylLxANf3dLK1F1iAJ0HThkKueiSncNgHA3M5WvwjJYRGsyQhtOwHGlNZHEd2JBxgKRVj2J15+8Zb5yWQuVvj+u0JaS2YskN9B20FnFkD1PjBI81EPFvfEzttDHlurHBcSCotxNssOZtARCqn0aE8msnhJEU7Pollo3diH8e1xMbrTsZMvHqnq2+/pLtTb8ktojw6B9XtMtWxpZgH5bInX9LX79rg4fTSSnIWH/x+5Dp3xu6q9RGjQJSwxvkyNt20yMRYo2ivH7w1JfnQxCeWUNJNzEiQzFd+XLtvyIM5X0AopX0V4TZ0b8DK7O9fDrxqxEJGAlgziiAoebhHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kdkaFcPQsIw2VJYY9Muu9Izip9PiBVp0K8B6v3ygjA=;
 b=LFlafww30CFWxIV32ymDI7VGwEZMCDk8Qr+0IKokK4h9EadQEvoS/mxWeRphxQjtmqSYm+Ppz9UgT2o02UxelVlD5OiIQGTLAn16ogd2FX6lU2kNrqTSmg/MiHlBh6UkvmJXmf7IKLtPcGiRoMPTRyTKAXSn5b5Z+1vz9m59GvB68Xsc5eVliJGdbM1740qO/+IeTSMeFyMMZNmlGwuQW/M3mcLeYNZtiXceLzrnxyvKOPdRjiGiftu9Lnl9L0tdgE23AbT0ul+dEUEjGAv/M1QoD8E2y2QEfRHVDKnI02g57LeuS28g3Ubx+B8GYjajoyB8rAZbu5ydmw8HBNUuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 15:08:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 15:08:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Andres Valloud <ten@smallinteger.com>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>
Subject: RE: Unrecognized MSR report
Thread-Topic: Unrecognized MSR report
Thread-Index: AQHa31mafl/h1YR3i0mf2CDlV/Hy0rITp77QgAAvJwCAACtfsA==
Date: Fri, 2 Aug 2024 15:08:03 +0000
Message-ID: <CY8PR11MB7134A23EAC691A383F6F555389B32@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <f5fab0e1-a6f3-4e53-a605-0aaf6d26ee3e@smallinteger.com>
 <20240726124232.GBZqOZuM0yue1Oak-A@fat_crate.local>
 <CY8PR11MB71343FB88D7F84EAD9D189E389B32@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20240802105742.GAZqy7ptiSmi7H8VHk@fat_crate.local>
In-Reply-To: <20240802105742.GAZqy7ptiSmi7H8VHk@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: d7195676-3117-49a5-0f11-08dcb304e82c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXkxK0ZDV3NyTXdsZitQMzRlZ0ZOb0ZJOURwem0xL0JXMFlYL0NMYTFlNWZD?=
 =?utf-8?B?MG1QM2FzMzZ6VjFBWXZBaWpTOEVBR0FlUmhzNGxVMkErOE04enJ1ejBaZWlY?=
 =?utf-8?B?eEdVVU5Va2JXYmN2OVpSN25FRXpuZmIwOFVPOFFta1dJb0orOTFESjJtNnJY?=
 =?utf-8?B?N2RWUnQ0djNpdHFxdjdqK3RtQVRId3ViZFExbnJQaHp2ektrNXo5ZlBqYllN?=
 =?utf-8?B?elZFSS8yNkJYVFdFSDVScEZLcnZ4K0VSTVNPWTYvTVhTWTVibVhqRzdkTk1l?=
 =?utf-8?B?cWVKakk2YWt5dEJ3SlVQQ29la28razk3T0s3dGw5Zk5XL1pVakpoUmZ1ZEwy?=
 =?utf-8?B?RjBQYWhwRElnMjNZNk1LVksyZXNPcVpYM0F3RDJBeGZGMm9KNHpvY1pJdmRm?=
 =?utf-8?B?bzRscUx4SFNGQ2ZNMmZyRjlVckU4cTU1NDJXUFBSelBjQjR0RGt4eURMM0hD?=
 =?utf-8?B?Rmo0cFZvU24vVCtXNGdTZmd3azNzN3p2R0N2a1JaZ0dIRkc5TjRDS2FDTjgr?=
 =?utf-8?B?MzBMY2JyQkV0ZUZqVFJTR2lycitoRGFmTWdPaDY3dEV5V2RMTmFVaGN5MmJF?=
 =?utf-8?B?RTVHVnhvU2Q4TnZTdHp5aVJCZHFoTk9KdFBMVysxaDE5ZWhMaVZtNjVhZTFJ?=
 =?utf-8?B?RzdQOTdHRmZSbHJZVk1rNHp0N1ZWTGlMWVNGb2dnSVpLWk5CWGJ4ZDRkNEJy?=
 =?utf-8?B?c3JURFlaYnNCTXp6SzVrRjNJNW1TTU1tVDBIVGJRcTc0a0ZPUTNxczJySVFT?=
 =?utf-8?B?SnJiaGplVE9ucGZ0WndsWElrYUlURHkrQWl3Sk5hSHhLcWN4cktRUUYydjdP?=
 =?utf-8?B?VDNYa2wvdlVBRHJiSmRhSkg4UDZlK3VLN09ObzdVQmFNa0RSb0ZnS2orbnMv?=
 =?utf-8?B?SThWUzF5NUJNbVhtNUszaGdDUS9rZVVGZDE0UGx6MG1lSTVpTXA3dzFjS3VI?=
 =?utf-8?B?M3pvY05vWExHVjk5NFdlR1VYekJoK3pwL0RwNXVySmVsVW1yWUlMZzByVjhj?=
 =?utf-8?B?TW00RjJob0Rva1BOeEoveGRVdUt5MVU0WG1WSlF4d0xzT0MrQUhrekNZVWRi?=
 =?utf-8?B?UWFKanJMNWhaVFllRVM2eFYva2hFTUthSWRXU0FxNDU1c3NrdXpacjhKQnk5?=
 =?utf-8?B?SnJnY1BwSlB3ZnB3SnJheDB3ajhmUGxDSjVkMVVRcVBsQ2ZzRU1lcGVhN2VT?=
 =?utf-8?B?Sy81b2xrZkhBNHlsVHZEZzRmWEVtZ3JUMlN6bGZ0TTExVHdmQm11WXBXdzA4?=
 =?utf-8?B?V1crUHJxUlY0TytxNWlldnhrN1VoWXdpbEVYZWJLVzFWUXRGUmpLRFZzT2R5?=
 =?utf-8?B?Q0tHN0ZNUmhuRmV0MGZmdHJKOFZUaGtZWGsranFBUHlnYmhTTytjTEdTbVlD?=
 =?utf-8?B?c2dzMzFPbmI3dTE1cGtuRTMreFZsc0NOT2NOSkowak9xWVdvMHo2Yk9wdkxs?=
 =?utf-8?B?ZkduekFNUlJjSkRJMGpqL0E3QXR5Q1BvYm5QMkxaS3Q4b2ZsRHBodWJlT094?=
 =?utf-8?B?dDhNTzhULzEreDBTNHlCdGhrdktqeEQyNkFGekpYdFBwUFdYYXFmcy9OQWdj?=
 =?utf-8?B?Qm82UGR5V0U2REQvMklwUTN3VytBV2M4ckFUS1l2MC9lTUMrdGNCcyt1VWk1?=
 =?utf-8?B?WGxTU0t0S2IyaHdVT0huYUJwb1pvc0d1MnFjeTB2dGFKS0JXTzVCNTNWQXFG?=
 =?utf-8?B?UFJWcHVLZy9uaFpTVjV3aFFqZlRNaXdWSnVxM0F5eU9pQVB5UE41NWZKZWEv?=
 =?utf-8?B?RXo5Y254SEN0d09LdmtUaHozT2h1UUxWVjVJQXdiYzdiSUJSUVkveC93QldX?=
 =?utf-8?B?K1F2aiswWmhPMXlpMng5bmNCd2d1VjZrUDlaMEhwN1diWFR4d1FqaDZBb0FL?=
 =?utf-8?B?YUhoYUZqNy95MVFrbXNxOXUwNi95TVN1UGRCenVPNkluS0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFFtODNCblRGWDlGc1ZVRXljU2ZOODNhT0h2VlprQmp1d3pyOTk2V1hkbFlj?=
 =?utf-8?B?M0orc0t6WG1vMEZhNGRzTDREZnFFOEZ4N0tMR2hGdndFK1VoUEFCV0g4Mmtp?=
 =?utf-8?B?eVF2Y2tEbDY2L1gvSWwySHVEUzJSQkUvMXErRC9LdVR4ZzJFMkdjaCtSVWx4?=
 =?utf-8?B?VFJSTU5rc1pWYll4bC9OMzR4RlptK1RWUVBYcVpqU2NNTmJkZmRSejJKSlpJ?=
 =?utf-8?B?NFFsYW5yU0ovVzhBeHVHdXJVM0VQeXNpclJ3OXJseU4xVFdpWEwxTCs1ZDdX?=
 =?utf-8?B?WmRiQ0JUQmRVQXN2bC9TNFNQUmFYV05KWi84eFBxVHVTMk1Lem9kNDA0ZmdN?=
 =?utf-8?B?Yzhld2NTVzhoazc0RDhJeVZsUUJzbDQzU1cxaE1HZUc0YmticmV5UFZ6NDZn?=
 =?utf-8?B?YXhwOGVmNGd6M2tZUy9kamtEaU4ydFpqWkNsV3o2a25hR05abGF6c0dqQmxr?=
 =?utf-8?B?ckVqL2JyYzZ6Y2JIa3lBN0tjcnFlcHd3c2lrWHJjS3ArcEE2ejhoYnpScVhH?=
 =?utf-8?B?aGFacTJnMUZoS2xLVU01cXJtbzd1SDA3TVFjMmJxTzBXVCtaeVhYZkFiQVBs?=
 =?utf-8?B?VkNzSVFjUmkyMDEwUUdIc2Qyd3NRWTl5RWZxQzJyVUgxRFJRYWIxdUFXVzlF?=
 =?utf-8?B?RnpoYjVhTXl4bTV4SitGTGNXby9jNTdNWmttTEl1L21uVitTRi9Xa3o1azRl?=
 =?utf-8?B?MUVoczIzZTROWVJza1lXSVMwSlJHekhDNVFqYlZlS00xV1h6Z21jNjJvb2p2?=
 =?utf-8?B?OHZtSnNTWkpBbXRMUjdraEtDR2tzMlp1NndQck5Hd042NDlHSSsrcnBxeFFk?=
 =?utf-8?B?dXc5cksvMXVXRDZUNExKM0JZZTJuWEVDbmlYVEtsckxzbEVtUDIwQk5wck9r?=
 =?utf-8?B?SW9TNHd1WHRSS2NLYXU0ZzVBZVJ0WURldU5zWjRuNGhsSG9NSlQzU01nRS9m?=
 =?utf-8?B?ZVh1L2pjK242UzNVemd1U2NpUmNqOUFxNDRsWUJXUUU4UmY2bG9va3hVYVZa?=
 =?utf-8?B?a01oWUZSZVdpMnRNUVRQMGkzMDlMeVJiMCtYQ0FqVDBXb3BOOEgzbjlNekFB?=
 =?utf-8?B?Y2lHMFNWTytwNzAwRFZabzNyZDB6VzlVV2N4U1hWSll4SjA2RnloRnhCWUZ0?=
 =?utf-8?B?WWV1TlJrS0k5U3prVW1OekRSam44YWxad3JYSmJWUUw2eEQ3NDY3TlNtcWVv?=
 =?utf-8?B?TjFXRE5JdnBzN0pyTzBvMUdzWGVKNG9VSFVuazRETDlySWhkeHNBNkRFUnZF?=
 =?utf-8?B?Mytna0ZQdlo2NDgrR0o4dnJRTEVTbUJibnViUUM1SUdYWU9BSXE1MWN6MlNv?=
 =?utf-8?B?aG1aM29ESzgvTVV6Zk9Lekphbjh6dW5yd1MwazdTeUNqMm4vU0IrTjVkQ00z?=
 =?utf-8?B?bXJBVkVyUW1NMGtuUVJhOFdlNnJOUndXaWZTOWREalN1M2cxeUc3WVJyMkVy?=
 =?utf-8?B?cHJDYlZObDZtZE1oSGtvak1JcTFWRkVMSWNseEdjVElHaDQrRllzVHNVU29M?=
 =?utf-8?B?RlBDdjRvM3FWNkM3Zk4yTTBWUnVSdEg4M2NENXpPYjlnR1dzSWdSYUp3SWxu?=
 =?utf-8?B?QWxjOGljZi9jRmRERlFhTFZRVUFJQ01BVVkwRDlTUDVTanpZRjYyQjdmenE0?=
 =?utf-8?B?SmcrRXdEK2VjOVc4VC85bU1ZUVNiMXIydXc5dlZZcnR6YnVJRkNoaGo5QTBp?=
 =?utf-8?B?NWhqQmI2Ti8wemVuWnk5Nm5YNml3RFhZYmVNMEo1RWp1L3d2SU5uN3BLeUVW?=
 =?utf-8?B?QncvYzlJdTQ1dVBsdW81Mm9Kb2t3dUIwTUxoWFNKTVBDL2srWHZhTUZsUzZz?=
 =?utf-8?B?SU9RNEJVNHdzblZ4ZjlRU3VFTlFUQzNUdW5LVEZxZkdya2ZWSzk5UnRHRHRC?=
 =?utf-8?B?VjhsNFYyWUtQVHFNVHZWdkt6NnJ0ZFgrYVRVSms2WTdiYllaTE1DWHNtdU9G?=
 =?utf-8?B?NGlDVmRUVC8yOWxKS3FRRVN3c2sycmlnTDVjZmp5V2Z4bTMwN0Rzekt2Q3Iw?=
 =?utf-8?B?RHFrR0pjSnFSZEVKckljTE1SNnc4RzVuNCs1enFpbHJoS1RQdld5dGRRczc1?=
 =?utf-8?B?UHF0TUdvMXBnMCsxbHFXY2s0UjAzZ2ZQalFqM2VwTm1zRjBNZ2JLZW0zUmxV?=
 =?utf-8?Q?Z7d2d0wYpkOu97iLFnZ665mY3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7195676-3117-49a5-0f11-08dcb304e82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 15:08:03.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxhEFOSz2AHUNCpnBgLg9MTZbp8hYNgCn29eBupsOF+XMS2XjYuZq53M4ugfHzgI94d9KUxITf6h2DnNwMNT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gWy4uLl0NCj4gQmVjYXVz
ZSBwb2tpbmcgYXQgTVNScyBmcm9tIHVzZXJzcGFjZSBpcyBhIGJhZCBpZGVhLg0KDQpZZXMuIA0K
DQo+IFsuLi5dDQo+IFdoYXQgdXNlciBydW5zIGFuIG9sZCBrZXJuZWwgKDwgNS4xMSkgd2l0aCBh
IG5ldyByYXNkYWVtb24/DQoNCkkgdGhvdWdodCBzb21lIGNsb3VkIHNlcnZpY2UgcHJvdmlkZXJz
IHJ1bm5pbmcgb2xkIGtlcm5lbHMgKDw1LjExKSBjb3VsZCANCnVwZ3JhZGUgdGhlaXIgcmFzZGFl
bW9ucyBhdCBydW50aW1lICh3L28gc3lzdGVtIHJlYm9vdCkuIA0KDQo+IElmIHRoZXJlJ3MgYSB2
YWxpZCB1c2UgY2FzZSBhbmQgdGhleSd2ZSBiYWNrcG9ydGVkIHN0dWZmLCB0aGVuIHRoZXkgY2Fu
DQo+IGJhY2twb3J0IHRoZSBhYm92ZSBjb21taXQgdG9vLg0KDQpZZXMsIGFncmVlLiANCg0KPiBb
Li4uXQ0KPiA+IEBCb3Jpc2xhdiBQZXRrb3YsIGlmIHlvdSB0aGluayB0aGUgZml4IGFib3ZlIHRv
IHRoZSByYXNkYWVtb24gaXMNCj4gPiBhY2NlcHRhYmxlLCBJJ2xsIHByb2NlZWQgdG8gbWFrZSBh
IGZpeCBmb3IgcmFzZGFlbW9uLg0KPiANCj4gVGhlIGdvYWwgaXMgdG8gc3RvcCBwb2tpbmcgYXQg
TVNScyBmcm9tIHVzZXJzcGFjZS4gQW5kIEkndmUgc2VudCBhIHBhdGNoDQo+IGFscmVhZHkuDQo+
IA0KPiBXaGF0IGZpeCBhcmUgeW91IGdvaW5nIHRvIHByb2NlZWQgd2l0aD8NCg0KU29tZSBwc2V1
ZG8tY29kZXMgbGlrZSBiZWxvdy4NCkhvd2V2ZXIsIGFzIHlvdSBtZW50aW9uZWQsIHBva2luZyBN
U1IgaW4gdXNlcnNwYWNlIGlzIG5vdCBhZHZpc2FibGUuDQpBbmQgSSBhZ3JlZSB0aGF0IHVzZXJz
IGNhbiBiYWNrcG9ydCB0aGF0IGtlcm5lbCBjb21taXQgaWYgdGhleSB1c2UgYSBuZXcgcmFzZGFl
bW9uLg0KUGxlYXNlIGdvIGFoZWFkIHdpdGggeW91cnMg8J+Yii4NCg0KLS0tLS0tLS0NCmRpZmYg
LS1naXQgYS9tY2UtaW50ZWwuYyBiL21jZS1pbnRlbC5jDQppbmRleCA3ZjQ4Y2M0YjAzNzUuLmQ0
YWJjMmU5YzU0YiAxMDA2NDQNCi0tLSBhL21jZS1pbnRlbC5jDQorKysgYi9tY2UtaW50ZWwuYw0K
QEAgLTQ4NiwxMSArNDg2LDE3IEBAIGludCBzZXRfaW50ZWxfaW1jX2xvZyhlbnVtIGNwdXR5cGUg
Y3B1dHlwZSwgdW5zaWduZWQgaW50IG5jcHVzKQ0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0K
ICAgICAgICB9DQoNCisgICAgICAgb2xkX3N0YXRlID0gZ2V0X3dybXNyX3N0YXRlKCIvc3lzL21v
ZHVsZS9tc3IvcGFyYW1ldGVycy9hbGxvd193cml0ZXMiKTsNCisgICAgICAgc2V0X3dybXNyX3N0
YXRlKCIvc3lzL21vZHVsZS9tc3IvcGFyYW1ldGVycy9hbGxvd193cml0ZXMiLCAib24iKTsNCisN
CiAgICAgICAgZm9yIChjcHUgPSAwOyBjcHUgPCBuY3B1czsgY3B1KyspIHsNCiAgICAgICAgICAg
ICAgICByYyA9IGRvbXNyKGNwdSwgbXNyLCBiaXQpOw0KLSAgICAgICAgICAgICAgIGlmIChyYykN
CisgICAgICAgICAgICAgICBpZiAocmMpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHNldF93
cm1zcl9zdGF0ZSgiL3N5cy9tb2R1bGUvbXNyL3BhcmFtZXRlcnMvYWxsb3dfd3JpdGVzIiwgb2xk
X3N0YXRlKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByYzsNCisgICAgICAgICAg
ICAgICB9DQogICAgICAgIH0NCg0KKyAgICAgICBzZXRfd3Jtc3Jfc3RhdGUoIi9zeXMvbW9kdWxl
L21zci9wYXJhbWV0ZXJzL2FsbG93X3dyaXRlcyIsIG9sZF9zdGF0ZSk7DQogICAgICAgIHJldHVy
biAwOw0KIH0NCg==

