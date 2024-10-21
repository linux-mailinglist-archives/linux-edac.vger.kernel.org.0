Return-Path: <linux-edac+bounces-2160-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB09A5A5B
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 08:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100101C20B03
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663E1953BA;
	Mon, 21 Oct 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A589xN2f"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE317579;
	Mon, 21 Oct 2024 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492159; cv=fail; b=VGXCCNTjx+/Q7kEvriNNT+NTF6UFCBn/7J3XswiUT+wCF6HeugbtxGSzHOSC2X8Wfs2lgym2ZrsVU6GSS24enAFKsXxiziX8U6zzfdCYWAggCR9I9d7IDhqQCDiuM+TBZj07X2Jh3ETcbYTMKvC2RW/uszD5FSR7pnEeEIFPO+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492159; c=relaxed/simple;
	bh=O0EWINEDbVL06Bu0hAsukjaLWURHNdUKrhhPsqQkDO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C7Npuug6b4sDPnSUmbUoSyZYCPWpEHNUruhMHg0r6pKRLPqOSEOk0CuGaT4rLZOA3iidr0W1pT5Pi9JkmQ7/4QZnVjFlJyV87lXmM2YqHAH21iMpSbvGyZpcKe6V9KNqA3XtBo4cMSNJR9ZDYFYpv05mH5oxJVKWE34hE3kP0D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A589xN2f; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729492157; x=1761028157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O0EWINEDbVL06Bu0hAsukjaLWURHNdUKrhhPsqQkDO0=;
  b=A589xN2f36lt1q934IS4SY+18zhO3tb3xMK/G6ICdZTb4ufN+/DdarB0
   LWwfF/dqBtVEFYn/Th+qKv/pUrNpRKitsQRnQ3rLMd37obRs5WZeuhUlz
   Fsz+QI4PrLHjysNVd0X4/E49LnCV6c46hE3DMvqMR2wTCyWl2LGuirpql
   4q/c4Ag7pETBg5pgJw7YhTBwIcLQtpQzrm9AtA45LJJDqdIl1sFWsWJin
   HCLRuzy/MsyaWDpBYYIFqTCCK9yDSvnDOrNQWTuc/eSOkMJXRwVYkPkjb
   rW8htN73rFsDqOoXmi9tCXY+KpmQhX+3JIsl+y0KDBgGV/pFSLk/0ANWD
   g==;
X-CSE-ConnectionGUID: T/IIPFSyT6ajmQSVvW5Pug==
X-CSE-MsgGUID: ydZZYOl9TS2h5MyJ4B63yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="54370631"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="54370631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:29:15 -0700
X-CSE-ConnectionGUID: 4N143J55Th2sXBZc9OsOeA==
X-CSE-MsgGUID: yeicAt54QJOEqKnAcBd7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84052455"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2024 23:29:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 23:29:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 20 Oct 2024 23:29:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 23:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhbdWXDdWXlb+y8+5KVnh3/TXX8muzePXCmEBcoGEVpeX63kazu8F/UIWFZFRY2ZC6fu04yPvfNn5ILd+hBSE0A+24vFiP0KdXtsCrc3SMlkud607DbJqdEu4c/pby0LrKItDiW3m6Wzunq/YeeHcDtRPEVK+aS5nTv48Sb/mBkGlYwaEbVUlaUHPHBjug0CvORtqNNXaklr7/ldYFC4GRA1dFjE6/VtMiKTheK93Bfz9ywkLolrVBbsAXXv9CXRGzHHug/JjlEjj2musbJzd4msCLJjH2DJYZqSFnyGD1Uiw/0YVlwdDUNQK/EUJJt6ERnygwLRxBXjDTKSN4UcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0EWINEDbVL06Bu0hAsukjaLWURHNdUKrhhPsqQkDO0=;
 b=HhL1gx1JFVFYSczoLTL9Em7nXxnGlzUVBdPYCmEIEejEXwK6FIO1Wv6A4867fgYoANnOLocvTGMSO1q56etR8eIGHqcQZnG7rtr3ZRsIud/KmGoAqTkSKUVN6nFo4+WTMYcyZNyvXrG8NkQZXBB4QNxzH82NUp79Or0tmXOnEehSeknFhPKQJWD5lwFuT1miScqLREd+hSueCbg0kefA/1strpIHsWjwywLbMr4yL0S56ig7ih3qxxNj/Kpp+eA0AlXo2LDR1HpUxCMLEJ3wiA8u7ECAcRcuzoJcTxOE/aNwy0Ek8VDDaSv4m5yHDlCkMA6k2fVJHsoTmmzpNsCgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 06:29:01 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 06:29:01 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
Thread-Topic: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
Thread-Index: AQHbH8qVDZ35fCCPoUul5iBQZYHMD7KM+CmAgACvGnCAAA1gAIAADTjwgAELkoCAAfeeMA==
Date: Mon, 21 Oct 2024 06:29:01 +0000
Message-ID: <CY8PR11MB71341C3DE209B2AEC27ACAAD89432@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-9-qiuxu.zhuo@intel.com>
 <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com>
 <CY8PR11MB71344BDC1A3AB4454FE9446A89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <36673130-7548-4BE5-8E70-ACC100A0BDBF@zytor.com>
 <CY8PR11MB7134A69052C691C9B2812F2189412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <E0031941-4ADB-4BEC-A913-4E74B88A60CA@zytor.com>
In-Reply-To: <E0031941-4ADB-4BEC-A913-4E74B88A60CA@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB8135:EE_
x-ms-office365-filtering-correlation-id: 681dbaee-d108-41b4-f468-08dcf199a724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y3pBTzlCQXhhUk81TzlXUVBPTCt4bEdKV29HTXJvd25HaGdBNWFiemhwamZX?=
 =?utf-8?B?Z0duejNpWnI0T0oxS3ZpaldUd3BpNE9UL3did1B5dFUxeXJFcmdwU2tNTzBa?=
 =?utf-8?B?cHhpNTQ0ZTRZV1dJb0RkMVh6UWxvL2VSODFMOW1CblBobHgxOGRUNHNlUlZa?=
 =?utf-8?B?NnpkcmdFMWFXRkFGb0tEWmExcEJ3YmNPY0hTOVRZZHlKUy96WkpaRkRPT0dx?=
 =?utf-8?B?ZU1KeCszNTdFaXIvdTBzMUE1b3g1TEUyQmFocEhlcHlnQmNac1FYelBwVHJ6?=
 =?utf-8?B?SHZOd2JxYnAzUDlhWHdVQ0x1WjUyNGZYK2tXd3dpUW84anJsd210UTBHbGlN?=
 =?utf-8?B?UGpGL21HdEh1QlRrMjF6eXdKN3czRGxHTVl6WW5ZWkI1UER4MkRhQTFKQmJ5?=
 =?utf-8?B?Y0ZsZXUyYVIzcFRRVS9CZU9WUlI0OCtlbzJXYjlIUVFDc29kQkxYU3lqa0Ry?=
 =?utf-8?B?OVVQeDNaS3FnZlhGY21VaS9FV0R6QUlQaGFFVEVZR08yN2dwYmVxaGt4YjlB?=
 =?utf-8?B?dFlXRzJnanNxeVZuN0ZaZXZEMDNSZmFjSDVpWEVDTzNSWUp5eUJZc3c0U2h5?=
 =?utf-8?B?NHY2b0g5a2FXbjZyZkVjVWVsTzhqajJmYjRqdmJ2cG05ejF6d0VnRXlwZjQz?=
 =?utf-8?B?Q1J1RDlrODlXSDVDZmxvZU54QUlUZlZSQnNwUVVvY1lLditzZ1RERnJNNitD?=
 =?utf-8?B?UnZHVC9rbm45RnkranMyc1pUZkVHSTg0MmdCbjBqS1M4bU9xQm5aeklGUjN5?=
 =?utf-8?B?NEl0ZzlsaTlFL25UNzVHVnZyWnMralZQRHlhRUdpb3ZBS3NaZ09DMWhVSFBv?=
 =?utf-8?B?MEFDQkZ1VUpuUjdMK1FFZ3VIcktkMERWZ2Jad3JtSXl5cUR1MjE0NE1DWFZX?=
 =?utf-8?B?SG50ODVaRDJzU3BiYUFIR1ZiSU05QmFERXRmK0JPSjNYUlhQZTEyRDk5MER6?=
 =?utf-8?B?TUpTR2FXK3d1b3puSXBDZW1BN3pvcEp2amRKMkVrZjNFWlR3a0ZCenZJSExu?=
 =?utf-8?B?ZHY2SGZ1OCt0SVV1dnhuT25tT2tpSVNpTWFEWmVITEVwWjZPekk2M1JwU1Mv?=
 =?utf-8?B?RFE2NlViSEc3cW8wS21KUHZrN2wycHdzMEJkR3Vjd2p6UHd3d3ZhRmh6dGFs?=
 =?utf-8?B?UG1uM0U3SWNlSzF2TEJvdzlnRGJndnN1UUVISkp3V2t6SStndzNOMkViWm5W?=
 =?utf-8?B?TU02VUJqS3ZlRGNGTHpMYzY5R0ZDeGxwREJsWDd1V01paVhNV1VCZEJndmdl?=
 =?utf-8?B?d3BDbzYrUWptUVNlak9TOWNJRkhoU0tYZWFlSnJMejJINmZ0dlp6eVhjZ3FJ?=
 =?utf-8?B?bnloY1FOQVdlN0MzWmM2amhhUzFxK0xXR1RQQWtaTEFrVkkwVWUwZG9KWkxL?=
 =?utf-8?B?WEtjbklabncxeWRIRzdaVW9Xbm45aW1yQ3duWm1XNkNqOGdLSWlYUEUrODdv?=
 =?utf-8?B?aEJYck9HR3BIZ0IvcVc2elRselFla3E1VEFxWTY0SDlIMXp4TGpSand4TnVI?=
 =?utf-8?B?Snp1SXlhd29CczZlWTViRDZTU25nR1ZiTS9HSlcxbUlUSzF1aStNaEIvZFZV?=
 =?utf-8?B?d283dkI0R1lhK3QwbjBxN3U0WVhNWFZnelhXYlBxKzIySGFsS1VjWDVSWGdG?=
 =?utf-8?B?My8xdFFOT1hWeTFpV25MTjBSMmo5a1VzaDBCMVphUkpKL29MblBibVM4SWxR?=
 =?utf-8?B?bnZjcHFtbERhWXB6ZTYySWdMRnBoQm1Gdkk0MG5KcnRudXRhUTRyZ3dLZGZV?=
 =?utf-8?B?QjZkMEJDbHNWUElBc0xJNmxQU1JRTjBnUVVGSWJhQVFNQ0dtTS9LV0R0ampt?=
 =?utf-8?Q?weW3J2yFLSKDMkwl5cpdbks3DQExjUMEcieWU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VSt6SXlxNWxPY1VhdTQvbXY3WXVPcmNEN3ZFUUVRd0w2dVY1S2pqY2VKMlFE?=
 =?utf-8?B?NGYrKzdTUUhleTJLQjBjMSsrY1NsMEROc3Q3bUJrYnFESElGbUNnVVB0U09u?=
 =?utf-8?B?ZUNZaVFHdGNsQkJNNnp6RlJielNLNWx3dW5Wdkx4a29XbE51YXc0cXhRTjI4?=
 =?utf-8?B?SlA3QUVUS09Ec1FYbEJtM0lIcmw2MDZkWVRTUDlJdmJFWVpBL2l0RDhqL1Z0?=
 =?utf-8?B?ZU9hd3Nvd1AwaHhRc1lDWU9BL050NE5IZzhIMzRySFNMRVJQTWhvMnhkY2J5?=
 =?utf-8?B?MmUwVnp5bmRydzF4akdUYXgxNUlKUjZSVXVwdXVWd040WFFKZURZMFE5Wmlu?=
 =?utf-8?B?dk5LQmROU2EvWHVVVmpDQ0toZ1pEWDMxZ2xxTkVrKzhsS292Umt2b0Z6SnRu?=
 =?utf-8?B?ZVhuU0Y3ODFQT2dwaEg5c1pkNnNsMldmQ0RDbzlRSU5OdEtqN2xGRWRsRklC?=
 =?utf-8?B?QmlSWWJYTUdOcVZha3lWcjNDbzFqS2c4NVdpZVFlYjFMeGxpRnJwa1YvR0xi?=
 =?utf-8?B?ZUg2U1RibktReHMyOUJXMkk2WXJRMXkvNEJxaFVzL2kxWGFKeTBMNUFYTm5E?=
 =?utf-8?B?MmFDWnl1S1dYWmNzRFFvTitFT3ZiZjBVRFFrSEMyNkxpVVNQUlhsS0ZnaFMy?=
 =?utf-8?B?S1Y1Tk9KbXg3dDZmenA3aStpc2pzL3RTSWlBK0tnbWVWRXE5REtyTWwvZ1Zq?=
 =?utf-8?B?ZFVuK0NZeTlPakdzamJYd1Zzd1Y0T3U5ZnJDNVAzU2h1R2h1T1RBYThJU2lz?=
 =?utf-8?B?TzF4anN1VFpiWXhwR1E4eXZOeFdabGd0cndiV0wzWHlVRUI4V3Z4a3lIQUZF?=
 =?utf-8?B?K1ZBVzhGL2lOWG9ZNDV6SXVFSDBqd0hpdGZtdTRxWm11NER6NWxlTzNWOTVT?=
 =?utf-8?B?MFlMTDlVVytWeE1nU0g5SFBIdlM4OG01Z3FrRGpvK3ZrdUxhMmVROEMvTXdE?=
 =?utf-8?B?aGtxUUNrby9rdHVKREZ0T3FLMno4Q1hBWDdYSUMxaktmSTY2Y3FkMEk2L2x1?=
 =?utf-8?B?QnFRYzczdVh6Wm1VNURkc2hLelVJR3MwKy93THZkSDN5VE1zK1R3bUxDMnMz?=
 =?utf-8?B?dExCWUkwZEdPeXM4YWhYc3hxZnVGc0VWck1waWtBZ2lrQ1J6Rk8rQlhNejE4?=
 =?utf-8?B?ZFZtZ2FacGcveEJyc3FVNG8zUjVHZ0xRWDdJOGlIaVV1cjBmTGRaZGZ4UUNE?=
 =?utf-8?B?TnRKYjYyTGhJaG5RZ0lpUkxGNGRUTzlRRmpOZmExYWIxWEJNMnVPS1FtWkhp?=
 =?utf-8?B?b3FneVd4dmw2YWVvbHg4SzFyVjBkdldiU0FkNWE0dHlwUE8wR3YvMjhqSWti?=
 =?utf-8?B?ZXNCYzY1bjR0OThMdDNMYTdaSmpIKzF6NEFTQjliUitma3U3QjU0Q1ZYWTh2?=
 =?utf-8?B?WTY2NmJ6OStYMHp3QSt1Mjg3YU9WVWg5OEd6aGFzRjk5bDZMdWQ3d0krMmpJ?=
 =?utf-8?B?eTRBekZMUEc3ampraEFMTldmZWYvcVFnV2paY0dDamFWMERmeXZYYUcrdURk?=
 =?utf-8?B?ZDV6UXdrU2FkSE9oc3ZMSmpaUGNGM2hBaVNWb0RhcDlFLzg5ejh3WWk2Yzl3?=
 =?utf-8?B?SHVjRUNUUnhBOS9uSUQ3Q0g0SmNIN0s4bTFZYWkrbk90YjJYODhTT2V1UFdO?=
 =?utf-8?B?ZmxTN2tLaHRpR2U3TUdMbHpTMUNLdnQrZTNQUWxUaTQ4WnA4dk16VzZLWWFl?=
 =?utf-8?B?eVZQdUF4eEt1VWhTSmVJN0hmcUUxb0xZQjZnNVZ6SlFWQitwTTZTSHh3OEEw?=
 =?utf-8?B?Ymp6N1RYRGhQa0JmV01ieGJxVHNVeDBua3dmQ1UzeEZYMWw0NGVBL1pDTWJm?=
 =?utf-8?B?QTBxMzZvKzZyZEd1c3BZd2N5NjI0aURwSDVjY3ZXeHA4ZHQvdDBpZys3a0pq?=
 =?utf-8?B?Ym1xakg0VjNrdy9ta1RaNjRMMk9Hc2VzQnJMRUNibEZYaUtDamJUMFVLdkMy?=
 =?utf-8?B?YS9OTnJqQzBuYURibXpGZWRqL1FHOG9FN0ZaVzhWNkpIclY2ek9ma2JQL0My?=
 =?utf-8?B?ZCttN0dqVE9CV051Z3RDVnRGNEswYzc1Y1pyUjhRcnM1dlI3TURmQWVVMlZV?=
 =?utf-8?B?Z0s4bHA1SlVTN1FEODdjd3NVL2Q2ZTFtV1VYUDBSZUZ3N2E2QWxTU1Vvalky?=
 =?utf-8?Q?J5VIUXDYMq7GwUJfeo4anatr6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 681dbaee-d108-41b4-f468-08dcf199a724
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 06:29:01.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAcFFl0lc9XLBIUAdFpmrmD/1OXcHBcGp0fqdiAhzceRntudj+r3gg+Ff1OkIqzYLy5KGjrQyZ1qvYI/hZ3O4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com

PiBGcm9tOiBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4gWy4uLl0NCj4gPlRoaXMg
aXMgYSBnb29kIHRpcCB0byBxdWlja2x5IGNoZWNrIHdoZXRoZXIgYSBjbGVhbnVwIG9mIHJlbW92
aW5nDQo+ID51bm5lY2Vzc2FyeSBhc3NpZ25tZW50cyBjaGFuZ2VzIHRoZSBmdW5jdGlvbi4gSWYg
dGhlcmUgaXMgbm8gZGlmZmVyZW5jZQ0KPiA+aW4gdGhlIHRleHQgYmVmb3JlIGFuZCBhZnRlciB0
aGUgY2xlYW51cCwgdGhlbiBpdCdzIE9LLiBPdGhlcndpc2UsIHRoZQ0KPiA+Y2xlYW51cCBwcm9i
YWJseSBjaGFuZ2VzIHRoZSBmdW5jdGlvbiBpbiBhbiB1bmludGVuZGVkIHdheS4NCj4gPg0KPiA+
LVFpdXh1DQo+ID4NCj4gDQo+IFllcyBhbmQgbm8uIERlbGV0aW5nIHRoaW5ncyBsaWtlIHJlZHVu
ZGFudCByZWluaXRpYWxpemF0aW9uIHNob3VsZCBvbmx5IGJlIGRvbmUNCj4gaWYgaXQgbWFrZXMg
dGhlIGNvZGUgY2xlYXJlci4gWW91IGNhbiB0aGluayBvZiB0aGUgcmVkdW5kYW50IHN0YXRlbWVu
dHMgYXMNCj4gY29tbWVudHMvYXNzZXJ0cy4NCg0KVGhhbmtzIGZvciB0aGUgZnVydGhlciBjbGFy
aWZpY2F0aW9uLg0KDQotUWl1eHUNCg==

