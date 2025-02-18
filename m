Return-Path: <linux-edac+bounces-3145-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93734A3A4D0
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 18:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B353A954B
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439926FDAF;
	Tue, 18 Feb 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmi/415e"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EA26F46F;
	Tue, 18 Feb 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901567; cv=fail; b=EsHhPhQ5BRKDFsVvQcSPWWzpn0wwuGSlhlZRs5A9mMk9KebW5RXAajLUkS4d7LRxKDHmRxWxW+SzcGjcDHuFJZvwDUcd/0rMe9B36xlG4CFDwSic7mfEdsb6yrUFPUqz7AAf6IjOugNA6BDoihCCDq21Z3ZlUs6DfP6GtHC5o44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901567; c=relaxed/simple;
	bh=Ossa5DX7FT89+TcSe/bkDW0V2rhHaBKFggeZeE9EMY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgzxYJ/PvDGCbM0Y9G5T4mkaDx+cK2PIMqyDbhx3UOJntqF/RE/5sZYdRBAyAGs1nYGo6sf20refJ09plOoJQScYJETpfbhjg92fpspGq07ECiSMeEJ3MFJZsjQkQNkE9ZAAvqGCBsZNuk+XUIM9v4YoLcpEz7QBSU471dfcWkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmi/415e; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739901565; x=1771437565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ossa5DX7FT89+TcSe/bkDW0V2rhHaBKFggeZeE9EMY8=;
  b=gmi/415e7Rpm5DD+sAytE57l5y4crcL6U60qkl9vxa84WZy5Y1HMviik
   sjFxEQUS89UwJzyQ1nShk6rosIKj8WK+9k+W766qLNwmAuPTibJvzpohO
   P7LfZEN8V4Cx59uP//F8IgGvdPGoV3+j5cdFQJ8WN2PcZTn7f5bGxYTDi
   9qgi0lZXKzHOVBYAx9rQEjLEt8EE2WUtB35KroJc7l32GENcHLW3kTwRd
   FCOMYLa7YMSSmEh2FBrfIbAnInN2XcyCHEX2yBiBRv2WEFHItu0hOrXbL
   ZQUlUgMgl8nYORLoj/yUh6uu2D5WwDbz7x4hb5nPRWv//+fleR5bJ26Yn
   g==;
X-CSE-ConnectionGUID: 38swnblFSmugmT+BvwCtQQ==
X-CSE-MsgGUID: wfF6L7bUTlChdoqXLFJotw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52021241"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="52021241"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:59:25 -0800
X-CSE-ConnectionGUID: bdJARJPARxOiYUpdrzVsBw==
X-CSE-MsgGUID: /OGS1CGtSP262G2ayDqT6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145366628"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 09:59:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 09:59:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 09:59:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 09:59:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq23FR2mzF7cpl4by+XT5alQayEvJlJePI9pJk7hKtWGJMeUxgthRTijM9TULQnk473KzU62hb8Wz2Ui9TyAnzrdTrA/+BaoaDP0pVzP1du1n9zHmg8TsYLgQvYo3spIzInAMCfKN6223npDb1po1BdIUGTQl7LtUHSBjbaNL6NJEnlOjicAIqIcTYWHGZCOe5W0YLYyO3QnR1nuIX/ir8XXE0+RkPz0PtnakouhaCqzk284xFa9+3g7uS+x+8Q819GfRvHdx5GhEsB8ra+VmNv+ydmFyy64I4c0aZpWgv7woHFeqa+tx2BktlNcMpbeJcmpTESL1Dis7ZPsmoUJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ossa5DX7FT89+TcSe/bkDW0V2rhHaBKFggeZeE9EMY8=;
 b=G7X8MPKQTlMvshxoiwrYkEhsdZWpDHfmykcxaBvYK6lpn43ViLpBEMGYdQTLQs5bllE54z9f2w9qCKlgbn72zVcDNWbBrJ0glcNnblbdrff4eHt0kfBbQ8S6Ebp17WtmJ5PwOCXCBS7Q4Aws12Rw/J+u43XBkVVKKXmqxPMSbEfkHRQVlwonIcOtXnoNcCiUdT0jjBEsoKHrGyntStR8mf9KybyJg25GCi0XqAeIoxbJ8kqBZmlqJWTIr7E0JvxMZ07OqHijn564iegib4HoV4MErfLvWrRNwBXje5Gs0PpgALNzFBv3rds7r6nN66mkvAHSJaSUbbt2kqWP8nBpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:59:16 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:59:16 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>
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
Subject: RE: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Topic: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Index: AQHbgQXsd1SPCL4WjEygZkFauCaLrLNMu9aAgAAzcQCAAA67gIAADFWAgABQz+A=
Date: Tue, 18 Feb 2025 17:59:16 +0000
Message-ID: <SJ1PR11MB60830555A8B1621CA62D4FC3FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
In-Reply-To: <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5201:EE_
x-ms-office365-filtering-correlation-id: fea93921-5aa9-4a43-aa13-08dd5045f5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0lwajNaczZxTi9CVlYvTFZRRGlmd2R3bk15TXNEZy9LZU0vS0ZGMHFyTlVR?=
 =?utf-8?B?RHdPc3JBQ1hJK2ZGejlpdDVFNEFGOGtUeUR4Q2VMMEdOWHFmVDQ2RFAyeTlB?=
 =?utf-8?B?ZWpSdG5NL0VEOWdZWGx3V2VEbTBuWkxHNk8xKyt3em0wNVlCZDZTbjN0ZHZQ?=
 =?utf-8?B?enZNQlhVNVdsZ1hBTDA0MEhBWDF2aE5VbHNtR2RBekFBMUtSU1dzaVl5UUpN?=
 =?utf-8?B?M2lMS1U1OFlvUlpMRlJoQkpJZ29iTWhaV2s3Qk1KUXAvdzZreUJDN1ltUEMy?=
 =?utf-8?B?NmtqT2NBMTN4Wi9UZVBleXloc1BHMkxVU0d2bis5V3dBRjZLZXBBaGdsTTc4?=
 =?utf-8?B?YmVZeUxrSmY0ZUVjUXlnUkFnWmFMaWgwYThJdWtXRWFCWjFCeXJBcTlScTh3?=
 =?utf-8?B?Y2NpQWlNcnN2YlNFTnQrUnU1V29wclRhZTgxRkRTS09tczBhWkVpV1VKNkdn?=
 =?utf-8?B?b2RTblJ3OGJWRjlXbUNDNXRvK0VjbzVGZWRrM2RrR2VQSlNvV001bjE2YVAy?=
 =?utf-8?B?RWlUMmxyV2dycGdaTEdJL0FmYzBnZGZSNCtxWGsxZjJFVDAxbzJqV2EwdkNz?=
 =?utf-8?B?NmF2azlCQUdxajliZEh1SlBtckU4TXRPS3hNRWtTYUJhMkJZWGt1MktPbTRi?=
 =?utf-8?B?bXBTZEdienZvVTN0cFRScDFJQ2M0NE9HN3dnWFhNNjh6akMzU3JBSEN3K2g1?=
 =?utf-8?B?eTgxOE1BZGVxRU82N1dDamd4NFRlTEVSenhQYnY2QjkyNHRjekN4UEgvWG9i?=
 =?utf-8?B?NVhpeE0zRjhqSlBadmJPdnNuUUFUS3hFSXQ2UmRYVEphL2hra1M0M0kzeTcz?=
 =?utf-8?B?aFExY21CUlljTDlvd2o2RnNDaVErNnl3bWxlNmRLTkJ1SjFNZXZGZXVkRHBB?=
 =?utf-8?B?NEpaL0pSYUQ3VnVYMVYxeVZlS0ltWG9XTm9uUndZdjVYTzdkR2pUQnc0ZGhl?=
 =?utf-8?B?SEh6UlhhTEpRd3ExbEhUNmc4T0hVMUU0d3FzSGJUQjNYa0VBbTdwL1hEaHZq?=
 =?utf-8?B?YkI3d29sQytocG5QTU1ORmROYW9YSWh4N1Ztc08xV0FCL2g2UW9YeFFCY1dD?=
 =?utf-8?B?YmNzaFZPMHRDZklDcEVoMllxbmVHdmN6VG15eWQ3aWNwenp5b3oxNzlzS0VD?=
 =?utf-8?B?QnRsMWoxL2FYUFhGNHNHQ2ExZjd5VkJ6TlI0aTNqL280N0hSbEFPSmIyd21B?=
 =?utf-8?B?dFhyWW9pUEc4bXQwNU9FV2h5TXJ2RkF3R1J0MUxzb1AzVkNjT3pvcHdjcVFo?=
 =?utf-8?B?ZkNWWFZHdE41dlZpWmt0cm8vT3ZlZXAzemthN1dsNHRDTHB2SGZoU2pTOW02?=
 =?utf-8?B?RGRTZkwvZ3gvRjlTWFRKc2FSbE9ja25JOFJyN3JPYlFCZWN5eTZwU055azR6?=
 =?utf-8?B?bHBhalhrdklpRU9CL014VXB6RHF4Q1RucEhQVGhvRitYRzcwRWZMQU9QYXlZ?=
 =?utf-8?B?ZGIwTm5HblB2QktSK0pCZTNjVCtsMi9zbTNua0JZTXdXdWFCZHlFRlBQdGVx?=
 =?utf-8?B?NGtOZ1NBaHk4N1M3L0Q0Z3FFK3hOczhBRm1PZG5NZmRhMWpsUkQ3RnAvbFhS?=
 =?utf-8?B?WG03ckpCM3NvS1JPZHAwVDE5VG5xdFdtNjIyaUo0RTJYUGJwdExEbGJaZXdU?=
 =?utf-8?B?K1ZrbjFheG5nWlN4R25SaEdEendsU0h0QnhTT3hjNDNKQzFWRnI2dnppakYy?=
 =?utf-8?B?clVSeW5rWDNlMDZjc3RyM3NCQVg4RkhIMkhvclVSeDZwaU5OcC83MHdvcGhH?=
 =?utf-8?B?N1BkUG1FckpmUEw3SXhUdnFWRjJHbU9Rb1ZQK0h2VStjeHJKOVNoNVVRWXVE?=
 =?utf-8?B?azJvL2RWdExWRUJXYVZCUVhUcXNwenV3SjRYY2lFMWRjUG85aVhFVXgyMnVD?=
 =?utf-8?B?cEZva0NDb2VtbmdXeWV4dlhneXR6U1hFSDJsWS9HZUZWZTloVXdjcjdNdjcx?=
 =?utf-8?Q?S93me5AYCx3lIo1+d7vAUplipJyCBMOp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXVFdTBYRHVkek9FK2xUR2hSZUVIcUlicjVOTy81c3BWWG5ScDZFeTQrbTdl?=
 =?utf-8?B?Q010VVJ6WXJ3U3Bkb1lFVnBka3QyRHB4MjBYTlVZWlBFalN2ZzI3enVaRzZY?=
 =?utf-8?B?MWxOcE1ieWxSWkRxSWN6aWsxUTRHMzd1MlNXOHRXR3RkbFpRMWtXeVhpR085?=
 =?utf-8?B?aTl3cDJWNGFxUXB3K1VXc2I2MFY3eWJvczhkb0tuTmRHUnl0WmZLbmxDeW1M?=
 =?utf-8?B?ZWc0RmhKenN3SDk2NERKdXcxZ1ZST0lLb1ZzV05QbTVuMjVSWFV6T0pwcFFF?=
 =?utf-8?B?VTZ1ZzlaTWh0azVUa1EzejF3dm51eDBvclNWcVVmOG1OWDRiaFBvVzFiOHlC?=
 =?utf-8?B?VmFXbHhuREtzVEttNDhlblpyVERHMGJac2l2SSt3L3RKdHoydWxBTVdtSU5n?=
 =?utf-8?B?OE5tb2pFSlprSS80RGN4TnpXRTE2bGswcHNwMTF2cDFuM1A1R29TcWVCOHVV?=
 =?utf-8?B?SkVYRXRaNHVrbVA3eHZEUDAvbVNwM3oyTFovVGlDK3VwblFBK2RkMjhjS2lT?=
 =?utf-8?B?U3ZNWUVTNzhueUliUjJaRjdHYVhaV3hyL0hSUll6WTBwMG9YdVVqZnZWdjlO?=
 =?utf-8?B?Qk9nVUs5MmNiQW82TUgvQjRpa3V6bDY4S0ZzakxlZGUvTEZITTk0YklwVGpP?=
 =?utf-8?B?K0taQ2VmWnlsdEN2QlgzSmZLL1pZUkYxd28yYW55TUxnUUFET1FwNlRlSkM0?=
 =?utf-8?B?TlFEdUpkdXdoQlhNdE5mY2RRaFc1ZEFiSVlhdWVybVc1bVlkQUxsbmpsY3hp?=
 =?utf-8?B?cWhSUWFtV28zZ0FRRnp2dVBWWStURG13bzNWVWZkakNCeU0xd1FuaEp0cnkw?=
 =?utf-8?B?OW5tNUxZdkRnWWI0VHpMMEM2ZUhuaUNnWXZOWndpMzVUcnN4aXRsMzN3UGM2?=
 =?utf-8?B?dENFdXVXUElDZjFYenRzQUt1azl1QUN3YzM5ZWRUdkRTVE5yb3R0RnNQczJ2?=
 =?utf-8?B?djV0Wm9LNmIvRWhlVURzMHlzeWZSUFY3TlFZWUk3ZDBPdjAyUE03cjRtYkdD?=
 =?utf-8?B?ZHRSUmtXazNrejdiU1huZHVxSVRIaWxCd0RoTldDL21UZUxXemhqYnBVS2Nz?=
 =?utf-8?B?Si9OYlJiTUxsRWZKeUNmSGdKanJ5Wmljd05PeXVwY0JuNGFpNHUzbU9UT0lq?=
 =?utf-8?B?TGFoVDFoUHdKWUZSQmhUaFdNRmsybmlqV2ZiMC8wZlIwVVF1d2tkc3NzSkVD?=
 =?utf-8?B?bUFDd0tkRGxZZ2d4QnB0UzdpZk0wSlc5K0FMczR4YVRKcnNwMG5wTTNsY3VZ?=
 =?utf-8?B?Q1dwei94d29OZnJ2blBSeVNLRXBxQmZUbWV6dTIyWmpJL01Rak9HQjV5amkv?=
 =?utf-8?B?YnpVbUVJZUhDdUMwUFNNMXRMemFzUCtHcFRoT0x1a3lFRm5IcThEM0xNOEdn?=
 =?utf-8?B?dko3WEY2MStRZm4yQUFWSDdWVUYyTER0bUYvdGgrTDJJSFJ1Uzc1YkI2aVVP?=
 =?utf-8?B?Q1JvYUpSSFEzSDkwOVB1YmhhQmlLbVlSKzVGYkM4Qmlmdm5xZFM3OHBzYWkx?=
 =?utf-8?B?ZmhSSTZDNC9nSzVBZ1NKS2MweWRBNXZ1SlFXWldFTm83NlJ1TitXSHhhWEFI?=
 =?utf-8?B?MGFPUGpKa25PUzVRZ1hDZ3lLdENqSkRkTXJvblowc2E4TVFyd3dHQmh3UUpw?=
 =?utf-8?B?cThURTJhSk1mZk5Zam9naW5pMmtiM2dROHdpa29yUy9BeE9oRjR3OThpZ0Za?=
 =?utf-8?B?MEp3L2M3M1ZIWmFBa3kxaERBTUc3YnFjaFBmemd3TWRjZWdMNlNOSFBHT3Jn?=
 =?utf-8?B?QzlQbitoM0dONEg3bk80QjdQM3lZTXNacmkySjFYUFpCcis2WEtQVmpVWWNk?=
 =?utf-8?B?Y0ozaXFGOTB3aWhTdUF1dmRFR0FDdm5PZ0Z1UzRIcUVBOW1JSnZPWjZCNkQ4?=
 =?utf-8?B?ZzJuT0grRFUrYUNGcWpzVjZvZjdDVktiU3RzTC96UDF6TDVBRnB5bDhuSGpK?=
 =?utf-8?B?VC9JVFR0L0lCUU03N2pUMmczVVhIc1dPT1BZSjY0NGVOUHFjWWZrSnhCNzY5?=
 =?utf-8?B?dkxyL3Z2Y05VZTBmc25WSjlIT3QwVkl0RlVQQWF4R2FyOUZ5aG1LS3ZuUVc3?=
 =?utf-8?B?Mi9mQ1cvS04yU1ZkK2piRWFtYUVFZ1VuRzNQRkl6VmxyZlhLdmMzNkFpcmZ6?=
 =?utf-8?Q?PsAz+lw23ff/BH6jo6HebZRJZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fea93921-5aa9-4a43-aa13-08dd5045f5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 17:59:16.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fVzJh0zLRTDbK8DrQOQawMuOQCaxofn8VjW0CptQ+guW5ABoMtXF0hJHzQTCWIm2t+RDwJILxyXmt0vZB1Ppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201
X-OriginatorOrg: intel.com

Pj4gV2hhdCBkbyBmdXRleGVzIGhhdmUgdG8gZG8gd2l0aCBjb3B5aW5nIHVzZXIgbWVtb3J5Pw0K
Pg0KPiBSZXR1cm4gLUVGQVVMVCB0byB1c2Vyc3BhY2UuDQoNCk1pc3NlZCB0aGlzIGJpdC4gS2Vy
bmVsIGNvZGUgZm9yIGZ1dGV4IGRvZXMgYSBnZXRfdXNlcigpIHRvIHJlYWQgdGhlDQp2YWx1ZSBv
ZiB0aGUgZnV0ZXggZnJvbSB1c2VyIG1lbW9yeS4NCg0KLVRvbnkNCg0KDQo=

