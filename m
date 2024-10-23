Return-Path: <linux-edac+bounces-2193-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972659ABB4F
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 04:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC67F1F2454A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70EA22615;
	Wed, 23 Oct 2024 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxbuTGnz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957320322;
	Wed, 23 Oct 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649350; cv=fail; b=KwIkYypdJV53vHeXcqqkisriyMveNcgnSyY5xTRwylCc9QFw5AewisR8i6nYk1q7BGVf1zgc0Z34u5NpiF0uAGE7uvUyxte2m4ze937pHDeUUaBDCJDecmQvYjI6GF5O1YK3R9gDc/PoEwYZ6W5qsCgmqlcs7tWJwh3HlIZLtBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649350; c=relaxed/simple;
	bh=0QrJ7k9YgSrtx6ovUDX9GntTHCKjqhoUPHnG9+GEhjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2X4MsrlcOKYK9wokx0yPQEpaE0HNbGokgNFEOiYlmFhJcMGmp09sVWtxcphtX37QLRT4xEh+XfPgcIz6Qrxqqly2/gpOmh6J7jRf8oKlcGa26NXQKgfIKa8aiD8/XOrrC7LV41JXLHS80xTUsvQteU6EDhloFxm64uDDjQs3Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxbuTGnz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729649349; x=1761185349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0QrJ7k9YgSrtx6ovUDX9GntTHCKjqhoUPHnG9+GEhjo=;
  b=SxbuTGnzvO8a4z7nlp86dbsHi80VejJaF03UE22fE5DukqgLz5+7+ISy
   rx/jypckvscnhlCLwnF+hOjWRZNxL0fcJphn54hAUuHdaqtE2lScPX4k4
   wJ/hudyQsdHneJE9ZtLO23usqBDm8TV8ZMWyx0bkqKLdOdatk8bDJZ98p
   9pkOfwBN2naiadc3ovEdV4YdGzVNlyVn1ZIHnJE7nCTYzzTk0aVPDBagk
   OhQo6M+f2Sy2wd4PzKSo5pFZe5LKjMAij2hikxQtP4NzLkXHlmGXcq7e4
   ZnPTPBRfPNENC0cTxz371I/NBwFlzJ8ij4rzqEK1d1/AwZm5Xm9LfQO+K
   Q==;
X-CSE-ConnectionGUID: k5F56luNRRiNkVKIURI1CQ==
X-CSE-MsgGUID: 9L/LLMpNRqm2havDxsxhxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29112862"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29112862"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:09:03 -0700
X-CSE-ConnectionGUID: TbyXVkLmQoiTWovhV6yNbw==
X-CSE-MsgGUID: ocXR26xpStmbBl85dt4sPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84840010"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 19:09:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 19:09:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 19:09:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 19:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUqTzeuH/Hw6RzH/UJdRFeUjcHv7rSabujKQccwFc02is/LUjf6Ol4Xr1lv9tJwJhUGjh5Ko7hCi0I43yE2sjU8teOnNo0isUPVpYIsA9QiuEC8zbQzlhHx8oRkJy9DtK2OM657zb2cVmrwQ9YGrRvEPcUg58a90jKwQk9rImFj8QN1nKSeEjRluTAIDa68TPBUa+ntLCw7VkNwNW4aDI9M71u6pLJEdqJBzGQ1sVuOaU/hNu3njRSHfUD18jq5nWxznKwUDTjvRRWwpvHB/3CI/yRL5jJq4RTw0hRhvEcxBITJJcwPMVNxJdtY1vewFLHNndy5hsN8eQt67antx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QrJ7k9YgSrtx6ovUDX9GntTHCKjqhoUPHnG9+GEhjo=;
 b=Jz0M4mqXo4zWmZLLG1+E/t5HVSQMjLSirYYB9WkLEZtHa2C62Lt8KhLEU616Lpq92eicWHv5eqGc6Pxkk5bIMZ7mzhPovPk6n/a8zFU5rPoq+V+Vp4rJv84HCYSx/r84AX6LV0a2L/aGpJlxxlDGTmfr8wk4ZtXAglcOkh6A1Ocu/zAxJlnwj4aFVSCcl61JOIYiQGo6Sp42jEI7yvLf0cVbSPqebqYxi4l7RCqH0GEyqfz+jvBVkOiIAe9IVb9T1Py7vnuG8vL8+LSDjccccLPqOeZHCO9t1RLuEkfCAQ3XAHOxJ2CwdMwTkitEv4iGW2kh/TE86ZdkJMtlFTLZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:08:55 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:08:55 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAEAyAIAAVvpwgAPafYCAABmgAIACIGkQ
Date: Wed, 23 Oct 2024 02:08:55 +0000
Message-ID: <CY8PR11MB7134BB473B10DE627CC5784D894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
In-Reply-To: <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB7624:EE_
x-ms-office365-filtering-correlation-id: 35b608e4-8022-4275-96e5-08dcf307a5c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z0E5c2ZwSmlkdXdCMHFReERwSzlvWURsdG9QWVNmN09LVmZyZFlQeVh2L2xK?=
 =?utf-8?B?M2w2eEtJS3V4TVptTmhabW5JejJqN1VHUE1pWDUyS3hLU24xWHVBaEVNU091?=
 =?utf-8?B?Vm92MGh4RjVIUksvNWkyYTR3azBGZE5yb1NmL2NJZi9zbGhXOG1JREZENW5C?=
 =?utf-8?B?ZkFMbXE1bkNrZ0ZOaElCZ0wxQ3FWOGQxUGxDWVgvYk5JVkJCNUJoRnMzR0dy?=
 =?utf-8?B?WDhjdmJRYXdvbnRsTmtGQ3Q2MHlaRXFQOEFxcUM5YVdFd25tYXdjVmgwM2Fi?=
 =?utf-8?B?cmhwc2tLaUR1TmpsMzV1UnNXYXBGZ2srcVBadE1CdjI1ZUZEZGd2V0ZsMms5?=
 =?utf-8?B?YXExWlNkdFBxbXZxMjJCS1RsRjNSZWF5MnNleGJyT3JtdWMyempaRTYyMlc1?=
 =?utf-8?B?L3VLZTAxZ24rZzYybTYvR055bDJqZ3ZBYzBCQ3dzOUpuK0ZzQXBnMXM0Z0Ja?=
 =?utf-8?B?RS9SMnlXZ0FObWJtYUFrK2dpajNFZHEzRFZ6a3V0V2lPdzg0aG50aTFKNzgz?=
 =?utf-8?B?dkZrOTRuYUpjR2ZUR1UzaFZLZ2ViRU5OWkozekYyeTljRVNiQy92cFNadXhj?=
 =?utf-8?B?WUxsbnBNcko3a1o0NFFMTmFYMXJkQStIY0hvY2s3QnRVNkx4SDBWeE1vL1NE?=
 =?utf-8?B?NEdubGplcVlud252dmIxZzlwUjJHSkZoTXdHalhDQjJMK0M3d05NeVFCSEw2?=
 =?utf-8?B?V05yL0JSOTBTc2lKb3haaFZDYmJIY0xmUjZTcjdGTk9GTVpEVTZuMjFILy9a?=
 =?utf-8?B?c1NQaWtjY2VNSytxN2xkZDRoUkh0QitBZkdIUmlDcDRsdk5LdVpwUnRLamhX?=
 =?utf-8?B?bkdZR2QvTGdLbDRuVHFBZlJrSjQ4Smx1VnRkMmIreE5VZTN3clNTNW5relJt?=
 =?utf-8?B?R254R3Rzck9QdEN2SEdRTkk4NWQrR2Uzd2ZLUTllYUc0YnN5b21yaW4xQmlq?=
 =?utf-8?B?Zk5WbVlQWkhERHc1Yk4wT0xHTmUxdVBLMnZLYVduN2hEOUJCTC9HRlJFTC9K?=
 =?utf-8?B?RkNHRFNhanB3V0pVbU4xeHVSbzhKcUtjbS9KYnErVlRGWVhCcXpaUUN3UjFK?=
 =?utf-8?B?TWQ0ci9NeFpqb3RqbnBxU0RpMGpacnQ0cWtkQ0dZYWpwUTNOdWRZQkR0QWVo?=
 =?utf-8?B?YnZMS2JBNnYxMmJML2ZmU0E0bDVneXNLVDNsdGxpVVJUNTFIbi9rbmk0Tm5v?=
 =?utf-8?B?THk0Smw1anJSTlBvMWc2Uys4b2RqNEZzV2RPUmFnYkkvUHJXbFUvcWJlTG50?=
 =?utf-8?B?d2pZM0J4SWVXMHhmS2Y3WTRWVVVCak5kMnNyaDRBMlZRU2w2QTQzVnRyWHJk?=
 =?utf-8?B?Lzh0UFl4VnB1V0hETVFmY1FIRWMyOXZDNWRoeDNUVmpkdk5OMnhIN1JHTTlC?=
 =?utf-8?B?NWNlTktSMVdLTDBPM2dtdUZPSzljQlpSRGEvK2VpaVpVWktxcHhjT09FVEt2?=
 =?utf-8?B?YUZkNW1lWlhiVjRzWjFwOUc2WVkxR002RUo3dDJ5ZjE4SGlHbDI1d1loQkEr?=
 =?utf-8?B?QmRLeFhMSG9GZjJCOEpsbjU0ZEo4S3AzSXhXci81S3pKeEJuelp4cG9kbjFE?=
 =?utf-8?B?QkY5OGl4UWs5SkFMcjNqc3BQakRBRjY1cmE0Qmh5eHZ5UzZpeGdOS0o2a3Bh?=
 =?utf-8?B?ZjNmZHA5c3Voa3NjMjVsWmkwZ0ExOGJ5ZDRTQzlsMXM3NTJpQjU4QmxVb0RP?=
 =?utf-8?B?RmY0U05GWVlpRW1nM3diMmFiSEN6THpHQ0ppYi82UG9JUjUxWFkvdkZaTnli?=
 =?utf-8?B?dS8xbXhLL0ZCMXZiVjZiTHdhU3RWZzdGNHhIbTBpdkhzeTFySjkxbEJDcWdr?=
 =?utf-8?Q?eB6MG+KpSoaV97onJpOs6APlnoTiJSs3B2HsY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEM5dG9VemZVVk9MNS9aRjdCYzREVG9nZ0x6RDNRQVhaWHlLVjRqR1owU0ho?=
 =?utf-8?B?QU8zb21CWmZzZHpGdUE5OEVydk9WWCtjMVZVdGxRUDFLbFhjKzRZOFBIUW1n?=
 =?utf-8?B?aW9vTzEzWHdESUt4VzFtaEFBYmVCbEgrNUM2T09SUVY4cmd5RnlJS256WFQ4?=
 =?utf-8?B?V2NQa1BRbkhKb1ZETEZRU1p1TW83Rjl4TkVTamRuaDgxUk5ZRFB6cU5TdEp3?=
 =?utf-8?B?MG1DQWF4TGc3K1BHUE5qc3E1NHNsWlRHT3JwWEE4MHZBOHFZdHZJZENWajRT?=
 =?utf-8?B?NFpveTVJMVFUZnAzWUhhaTRMU3VETnpNVUdjS0xJSVZvLzY0YVZ2SmpZSVZ3?=
 =?utf-8?B?WFlCcWZlMlpUb3NzWEdqS1RIVnQzODZRcmJnRzg5YnBPWVFaUndvcUdEMis0?=
 =?utf-8?B?VTRVK3hLTWQyVVhvRFZ2R1p6dTFPM2NSQnlrcUFXbmk5VGJ2VVQ2czJtbFR4?=
 =?utf-8?B?a0hEanZOT1NMa2l3V2tWMWdqQ1NnTzNTRVF6U3FMWXJvMVl5WGdJWHNDeDhM?=
 =?utf-8?B?WUVvT0dtb1JPUjR4OWVoN1RrVWxzeWs3aEU1eXBaNzVEMHZ1Ly81V09iRUVG?=
 =?utf-8?B?b0ZmV1MreVIxbmF3V3Y4dVR0Wnl0aitlYVZEeUNVbU1uYldtbDQyQ3pLTkZp?=
 =?utf-8?B?a0FBb1BHUzdIQkxaSHo1eWRidE8xUy94bXE2M2xoOW8vYWlIZ1FaemFvcGNO?=
 =?utf-8?B?NEFNbElJUW40Z3ROQ2RnanUzOUlUZEJueXE3SitCTkFMSlVyTmtPbTBrV08z?=
 =?utf-8?B?ajdjajZDM1BpeUs1VWl0eUYwM2RmcFZiMFFwclJSdHZkUGR4Zytobnc0Skcy?=
 =?utf-8?B?OG1iU0R5Z2tZaFJOWnRiUDlxK0U1RlgwUXJUaFZKSjAzcWFtT3hjOXVBUUtG?=
 =?utf-8?B?enh1bGtST0o2NUF5ejJLZWk0TFcybGFIUTRQVEJtcnhtRnlqbnhONGNFUHE0?=
 =?utf-8?B?Yi9KM0Rhb0djSlNhQ1hPUjB6T3pRS3BwRWI1NUJUVmJoWHU1WkZpWWE0RmZh?=
 =?utf-8?B?aUlOQjZYbmF5VHBJNlA3Z1d2cDNDanZ1Wm8xRGZwQytlR3FpdmNDdnU2aTFK?=
 =?utf-8?B?QzJSUW1MS3dvZXoyTlNJek9veUhLcFNFTXZrNnJGOEk2SlNsNmhmbkRYa0g0?=
 =?utf-8?B?VHpWaW12QVhSZmFuYzF4UXBzdWlsdGhHMWs5Z2cxTmszajhrVUtwN2NCcVlQ?=
 =?utf-8?B?RStnb2QrbXJBZkxEV1pDWGNGMWhTTXR3ZG9OaXVxa1VBTWhHMzRwZ0tUMWhO?=
 =?utf-8?B?d1JPQ0xXU0c3cGpiNU43STRMSmxtUUtVZEN6OGxvdjcyN0QzL2JmQ21mbDl0?=
 =?utf-8?B?MDgrOEppKytIcU5zRkNnTFNKZWVrajZWYXpzL204cldxOXhKZkxhUGdkQXNz?=
 =?utf-8?B?UTN6R1hRTkhqVE5RV0VmWlV1Ty9ERXFtS1Y3dWxMa2pocU1BbUw4WXM2OG9F?=
 =?utf-8?B?U215Qk9UNTAxOUFvbTZ3YjB6WDlFY3VuN2VZN0R4eTVtWGJJSkZsM085OFNv?=
 =?utf-8?B?RklJd0p2OWlJQjBqd1E0VFphbERsaStPRldEM2hTWDczL3dJa2l5cU1qZ01w?=
 =?utf-8?B?azRMWnZydkRyTmdLNzRVK2lqWDd6YWxJWG1DTXhHaXBRV2lMQ1crQW1YNkNk?=
 =?utf-8?B?cFFUdnIwaXJxUS9pbGk4ZW1kMlFQQVFOVUhvYTh6Y0xSek9YazA1cVZLK1lR?=
 =?utf-8?B?VldqZVpDQkpYZGNrOVBpcVA2eWRUbDNqcXcyR0ducmRrWDM1ZXZSYXVONGdM?=
 =?utf-8?B?K3VsWUhJVHNXMXhzYm1oZmFUY1VaQlk2T29jSC9Eb3pjbHpqQWZyazk4OHht?=
 =?utf-8?B?cUwzS3JETFFBYzRjY3NvN0QzdjNLVEpUcStMVkRRT3YySXVTc3d6ZnlBbkph?=
 =?utf-8?B?aWl3UWtwd2lJM2FZWitBZExOd2NYYTZocGJ3a0FUTk5ZYVAvUllqVDJNa21W?=
 =?utf-8?B?RzcrV2Y3WEJvSTlmMC96dFpMTXBBQ3hrcTZBcjVmRzdyOUR0VG5CWTlQRVVL?=
 =?utf-8?B?eS81RmJUdVl2WXhncitGbC91TTl2aWt2NS9VSEJ0SGZ6SFE4cDdtQlUrS0FD?=
 =?utf-8?B?N0lHWC9PaGkvTzQ0UTdBelRCZ1ZpUE9FMmQwQ01IQTdSTVlnZG1IOXBQdXh0?=
 =?utf-8?Q?FIpOdD3ppD2okKr5a8fozbvST?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b608e4-8022-4275-96e5-08dcf307a5c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:08:55.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfK2HGaEuuP1VSDTGMxvI7IA6DBodz9w+HF+FCueIcv1NAMbC0LDpJlbh6BW1uoTOiCClvocRxFFxM+wywfI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7624
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
T24gMTAvMjEvMjAyNCA5OjA2IEFNLCBMdWNrLCBUb255IHdyb3RlOg0KPiBbLi4uXQ0KPiA+IFRo
aXMgY2hhbmdlIGlzIGNvcnJlY3QuIEJ1dCB0aGUgb2xkIGNvZGUgbWFrZXMgaXQgbW9yZSBleHBs
aWNpdCB0aGF0DQo+ID4gQ1BVcyBpbiBmYW1pbGllcyA+IDYgdGFrZSB0aGlzIGFjdGlvbi4gQXMg
dGhlIGF1dGhvciBvZiB0aGUgVkZNDQo+ID4gY2hhbmdlcyBpdCdzIGNsZWFyIHRvIG1lLCBtYXli
ZSBsZXNzIHNvIHRvIG90aGVycz8NCj4gPg0KPiA+IEJ1dCBtYXliZSBpdHMgT0suICBUaGUgY29t
bWVudCBkb2VzIGhlbHAgYSBsb3QuIEFueW9uZSBlbHNlIGhhdmUgdGhvdWdodHMNCj4gb24gdGhp
cz8NCj4gPg0KPiANCj4gSSBhbSBub3QgdmVyeSBmYW1pbGlhciB3aXRoIHRoZSBpbnRyaWNhY2ll
cyBvZiB0aGUgVkZNIGNoZWNrcy4gSSBkaWQgdGFrZSBtZSBhDQo+IGZldyBtaW51dGVzIHRvIGZp
Z3VyZSBvdXQgd2h5IHRoZSBtb2RpZmllZCBjb2RlIGlzIGNvcnJlY3QuDQoNCk9LLiBTbywgYmFj
ayB0byB5b3VyIG9yaWdpbmFsIHF1ZXN0aW9uIGJlbG93LCB3aGF0IGlzIHlvdXIgYW5zd2VyIHRv
IGl0IG5vdz8gOi0pDQoNCiAgICAiQ2FuIHNvbWUgb2YgdGhlIGhhcmRjb2RlZCBudW1iZXJzIGJl
IGNoYW5nZWQgdG8gdmZtIG1hY3JvcyBhcyB3ZWxsPyINCg0KDQo=

