Return-Path: <linux-edac+bounces-2737-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF49F679E
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 14:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F06168E89
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E09F1ACECE;
	Wed, 18 Dec 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h48/e6k/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E081A2380
	for <linux-edac@vger.kernel.org>; Wed, 18 Dec 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529595; cv=fail; b=CLZDR9nzozMDz6fVnWsfiA+/7fes+el0SQmRqFYawI/N5OQDQ8l/K6A3Fr25bWi1LHOwj/BMJPDqNGVELcRN6QavMz94h+IXkrHKvL2rAJCTNAuPE5AxprwCEC1E7JQDF3MblCpLpLo3zz+r5mXmWr2IjLGreyzrzmdC+r1bKH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529595; c=relaxed/simple;
	bh=EF0orybPgS17tlcNzCqN1yu/UrEsT63duPwypSRLrOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0GACOBoMHibgShqdOfZhie+HTDidSvRhTTc3eXQKbDh/0L3uFYeISomL1Y2v3lQB4XKLclODx1H0jEkhFiuWGhHW/S3ie/lpOVx4uORKXJMBIWDo55xtXN0aS4pDFvKAVJ7/z0utxaVENyuMjvWU/bVdibrbyg/0MLvWDzJKkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h48/e6k/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734529593; x=1766065593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EF0orybPgS17tlcNzCqN1yu/UrEsT63duPwypSRLrOs=;
  b=h48/e6k/dFIWtAntiq29Veomhnon5FVHTFwlpfyn4t3Rw1qv6GgLVFn1
   YKrVij8PJZYJn5KJv7aHM9Jw8EfMZdwu5bnHFAMLLhHI0+QjP7LaMDyC0
   GC7BDlmU74KBnEK4jHYlv5Qxxc3//TjZsx6nmaxbM4qMkNIoz3T0Ig/ud
   Gc53ysQ/bSIuFc+ptlwJwrK5TvCgX8bbIA/lq20BIT5zZIalttx30KyKp
   3ydvc8ZGXChgVjk7uaRC7q+EbTd4Ajeq7AeVRdQk2UmdYd3iMOTeZQ75B
   WvvAIWu55ot99l3tnBUvdUjngYIUirrvD9rloOgO/q6PYuUaE19glX+Cr
   Q==;
X-CSE-ConnectionGUID: EVWnKu9VTXWTpUc+Xwp5Ww==
X-CSE-MsgGUID: pxXL//6eS5e+FJIZlviNkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35154421"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35154421"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 05:46:33 -0800
X-CSE-ConnectionGUID: c/ev+zLqS/GL6gJeCvNslA==
X-CSE-MsgGUID: IF6KXlPEREG4Jn/omBMt0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128849969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 05:46:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 05:46:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 05:46:31 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 05:46:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCtVj6yOz9HSg0xdRmJQWXX37aYkK/zfrA4E1xn0pcJovslg/SLFbmnY7Hi/VyBbMpxHcTNf5QCjo0V2KxmJLrigJA8e3QFGXsznwY27ljbeopoAlBuFFJb1nO8cDD/4pccleo5LL4qn2Vi6+Z3RDtZ6v/Pyyub3C2vIkhbyV63U5WFDujNkEPSjzU8FKMWmoF0lRUt9G/iGAuxwEcV5nNfBjrSOP3eKGmTPz+qrMmGl6PocZJaoaiOlzadc7YSk9qko5HOWidtAm3JboZkUoUHZHjm/r1s1xUBWvZlKbh4Mwdk2WniXzwchifLQwPEYVi9+gXaqUfVroy9iQuZSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF0orybPgS17tlcNzCqN1yu/UrEsT63duPwypSRLrOs=;
 b=gj1URgV4FQ3DOztklQBMqkKtaEPbKR2fqiqxDRjTMUzBEwyXBmVaSHbyDfeiB9elMjsNUXGFlMGiXMoRH0PfZ2sqibhXY3LuMiYXgNzV3PHBkoZyRLxZJY+tQYwXBpi8z25xION8NWSZcFKvxX+2wdCTPF2mqLDroo1guOctUPoGyL0eXTjryz+h75+ULApkInmtpXOb+DAbty1LGUpelKHzoxu3PvV/iQzR1Tyi2y/RdD4ukEP/eVT+WELr6HPlYfn4L+vc0TSQqQQhXmJV2H9AjEJR2HpS6cuUK/0glLWsnpQ777LlQmCb/mf/1jR5fDq6NGkRfkxixcOXEhGZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:46:10 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:46:10 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: RE: [PATCH] x86/mce/: Make cmci_supported() return bool
Thread-Topic: [PATCH] x86/mce/: Make cmci_supported() return bool
Thread-Index: AQHbUJN5XZBI6zGzSkWkqaNvqmkHk7LrMo5ggACD6oCAAE5LEA==
Date: Wed, 18 Dec 2024 13:46:10 +0000
Message-ID: <CY8PR11MB71349C4E33CBC0A329948E8889052@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241217145117.155990-1-nik.borisov@suse.com>
 <CY8PR11MB7134CD07F072C6F3EE6C4EA589052@CY8PR11MB7134.namprd11.prod.outlook.com>
 <31e87668-afc7-41a2-8cfe-1de609e6f2ce@suse.com>
In-Reply-To: <31e87668-afc7-41a2-8cfe-1de609e6f2ce@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB5215:EE_
x-ms-office365-filtering-correlation-id: 447ff0c6-fc90-4068-0dd9-08dd1f6a54e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2srRmp5UmpIQ1psMDRFekZ5WTh3S292SjJlcGZIaWNCdzBPck9henUwZ3p5?=
 =?utf-8?B?THhTMWtBUXR1eDVmQ2JmQnltR05KSkFReG5CdkVIZVhQRUZPWk10MWp2V0l2?=
 =?utf-8?B?dnA3Z29oemVjV3RSSVVnMExSeXR0R0c0WG85MzlOcHlHZlJEcHNUZE9KQkMz?=
 =?utf-8?B?SkpsRVROMU1KY0xtMlFkNjI4RjgyN241TDhvVzFRbmFVSlR2QXI3NCtJWWVT?=
 =?utf-8?B?b1JmcjVQZXJXOVRQNXpudGtYTytkemdsZEtHMHFaUUlLM0U2UnNFVWZFN0Nj?=
 =?utf-8?B?RWZnOUk4c2tvYWRKUVpUdmx1SGtta1AzazM4V0hZOWF6ajc5WDZhMUgxem9L?=
 =?utf-8?B?eW43QWo3eDczY3dvY0N3TUNxbVVHcyt1NDNJL3RRQ2IyaEVYR3k2dGd3WEZw?=
 =?utf-8?B?eUhuemVrNEhSS09rbFJvdThmdkNIVzJVZXRCRUROTFVpWkZ2b0w3V0lPNngw?=
 =?utf-8?B?cUVhUEtSYlI4Q0tUazhoYWpkMWNzcjVSazYweWV6aXdteDkrMzMybW5reTBz?=
 =?utf-8?B?UlNvckg1R2RDWXo2SnhqVVU1ckxRUmhsdDd3OHRoZ1c3SE9SWU4xMW1ZRVAw?=
 =?utf-8?B?NXROSi9TU0V2ZHBPQThPQ2x3Q1BuQ1pmYXdpbFZ6VU1oTlFiK05YZGRqbUJj?=
 =?utf-8?B?RERxR2w3VkZJVTlQWkp2MWtxSmZzYWZTVjYwQklKQ1FXK2JxNXJkMER4N21k?=
 =?utf-8?B?azlJVmdCcmpNZUpNQTZqbDFlSFd3UGRvMTNTdVQwOG91MktoT1BSclFXdkpG?=
 =?utf-8?B?STVWaS9YdlBBSWRQTitnZk5wTGM0ejZGWGNRUDRQN0RiQjNmcTNSM3RnMk83?=
 =?utf-8?B?LzJIcHgyR1NUZDdFbDFDNUJWcnJFRDFPZUtYbDBZQ3JSL3ZLOEFKQ2NLdys4?=
 =?utf-8?B?VFR3TTZYVEYrT3lDa3NZYnI5MlBYcGtid0w2cFdUbGlYN1kwaXkxVFR0aE5M?=
 =?utf-8?B?dDJsaXE5dlFzUmhWaXpnaVdTZFhuSFZhOXMzQnJ1NlJSRG1FTFBzNjNpeDU3?=
 =?utf-8?B?QlpUNmIzQXBtejhXUWh3SHlNVExYYmtWbmdOMEphNkJqdW9ZbzJwLzk0cGpJ?=
 =?utf-8?B?MFZGRUk1cWE4dmVyamRtaFZJU0MzUTdiMkNMUFJNS0hYUW5hY3FvSHh0bmox?=
 =?utf-8?B?UFl6RkZLWkVwOFhaNjFGb2NRekViSkR4VWJrM21uNmV5eFE0dVpEZVJGR05B?=
 =?utf-8?B?cm55RFJVR1NjTWZrbk52WUNBOS83VUVhUDVIVnh6c01rV2xiOEcxMm5GSXlT?=
 =?utf-8?B?U3JUd2JTSUwrZjdNYUpZelphODdVaXdqTXlaRFU0VFpFbDQ1bm9rY2hGekFz?=
 =?utf-8?B?RGRIeklVTU1XVWd5d3IvK3JsZGprOGVNSkZ6d290b2Z0VUs1UHVYRXhOay9G?=
 =?utf-8?B?U1E3SktPdkR3d2RwRG5uNEFjQ09qLzZPWWpoRTJ6QnhGUnp1VTZ6cHN6QWFp?=
 =?utf-8?B?QmZCUTVickI0YTNhUytSS2xUTVY4NGV1YjhEbHo4ZHN0Q3ZWbTEwM1pLcmlM?=
 =?utf-8?B?MUJNSkhDaXA0OWFPMFdGNnpMQW1wTkU0TUFvNjU2VTVUVTVFWXNGZWcvaXJK?=
 =?utf-8?B?TWF4a1BRSWZaSWJkQjdFYk5YMC92dWNqM04wUkhPS0hHdzdhZFNVK3pwSzVN?=
 =?utf-8?B?VVY5cUY0NEgzR0krMjlTUTFRQVVkMGJwaS9VWExSelcxTk9CUHFTRnFzbDN0?=
 =?utf-8?B?N3B2N0d2MGl0aU1TL3N6enY5aEt5MXlGRm5UbWkvekR4S3hvVkJ5SFpreC9R?=
 =?utf-8?B?dHNDbjJ1eEw2dXlVa3N4MVFENnpIdkU2Ykc2OGF1b2tOZkFxazR4WUV3YXZa?=
 =?utf-8?B?bldoOHFtQnVhT1QwVCttZHN2c0tNbm0zTXI5V2VDV2R2WDhnTVFVdDB4MUxi?=
 =?utf-8?B?Nk9GbHY0SHJzdjJscWNwK1dJT3NMaEdUQ25hWG0yZ0ZCK0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnlaRWtKeGNrTG9WbmpqZ1lPTXgxKzV5SzZXT2dNdXNnYWMrVitPM2tPQk5o?=
 =?utf-8?B?SFBYRnlrSDZWUHEvWFd6Nmc4dVRsQWFsRFkxK1puUW1FYmlzQUVOR1FPZTZs?=
 =?utf-8?B?VDkvUlJ6OXd2Sk83N3RxZUVyNjB3d3FiYlBYYjgzWXBHQjBkcXBiNlVPaDV3?=
 =?utf-8?B?b2pPMjZCUnlFOEZxVDI5MWNkdGhvWXZzV1lJSEdOUGtXWUhKNzZ2a3VSM294?=
 =?utf-8?B?dkpsSTRuSmpzd3k0NWd6VVFjYjBJb3lXak5OQXovSWxNOEpKT3craHg5S1BU?=
 =?utf-8?B?UWlSSGlvOTlHVXVmbnFCYVBwQXlqRjE5ekpINC9VUlpxMXpwcjRpay8wSXRL?=
 =?utf-8?B?UlBOdHVNMC9DclQvYWVPa3VDb3BFcENvZDBpSlhaaDlvTm1OY2NzdlFjdW5S?=
 =?utf-8?B?d1d4Yzc3OG5KZTBpaDExUjNFc2FaeEYvbTNlWkVEbHRQVklicDAzNUJxWEo4?=
 =?utf-8?B?ZGJiNU5seEJPY0xCTk1FQW5QVEJYV24rMWhLa1V1VW4rbTR4d1NvWWZVMmI4?=
 =?utf-8?B?SjMyaHVnU3RZTTViWWhIRWtZVEg4c1gvMW9JSy9HekkrZytPL3FxaE13NDJN?=
 =?utf-8?B?VjY1VzNMSjJweklpQm1UNFZQL3A0eUxpNEFMNHBTVmU4REZRMUZibjRkZXhS?=
 =?utf-8?B?amY3NkZWYmYycU1RMlI3OE5ETzZVK1kzeTdGOW0wS2tITkhKVjRLUVd1WUgy?=
 =?utf-8?B?L01NbmR5d01NSklLMGdIUmFycUtteE9UWUNuSTM2bUVjRVhTVDRPMHgrNlZT?=
 =?utf-8?B?VGowT3BsMGJZVkpyYkw2Mi9nTWRWc1pNR0JmMldKa3VVcGJiWWFuZ2R6c1da?=
 =?utf-8?B?M1o2OTluRnluSWg3eTJ0dG9lTTV5NHlZZ0hjcC9NQkhKQVZWZXpSTDZrRmhk?=
 =?utf-8?B?dnBPT1ZrQ3hJM1FMRUk4eW1YanNLYy9McjJOV0hjdGhOamdjMXRFdGlQNHZr?=
 =?utf-8?B?b1pJRmU1amNGTEtRMWFvU1RwemNzcWhDU2I3S09KV05ZR0xXb2VGMGQvV2dw?=
 =?utf-8?B?cXExa1NxZHE2WTA0cys1TjlwLzZkbDUxNXoxL0tVdCt5dDdhYzFZT1RFdy8y?=
 =?utf-8?B?TS9tRHZXL1hRQ1drZXFFNjE4c01HSXNCbUhYcUZHakVqb2RVQWJZUGtGN3ZX?=
 =?utf-8?B?aGRsMjFpQVVhcTFqWjNuSERNTm0vL1N0V3pkdTRpTWdWT1psaWx5YXU4bTZR?=
 =?utf-8?B?elR5REFBckp6c2h3QnoxU0xaajNscWtnaGYvb1hMaGxRRGZCSGhIYXErcEFH?=
 =?utf-8?B?UVh5UGxldG1ZbVZ2dkJZaTE2SmJHQVEyeGJ5TVhKNWJOMEZaQmp0eENyeldN?=
 =?utf-8?B?REw1bENoWnpUTG5nbW5vQ0g1WHN6Y0x5KzZnaTFZOXVGZXQ0VTJjUVJtcHBt?=
 =?utf-8?B?eVZFVlVUbUFpb09OV2pOeDRldWFycEtHQ0l6d3dLSUQwc205dGhYczdKWEhh?=
 =?utf-8?B?b1pzZUMvc21ZcTRSZXhETzhCTWl4QkZZa0hic2hwK2xxTWtaOVRSdW55L0Y2?=
 =?utf-8?B?cThIR3FpdVY3NXlUdG1iUmZQd25wcDUzZFd1MVJReTFxNGN1YmhPTmFXNGZx?=
 =?utf-8?B?bmVOdVRVamFuUW1USWdreE00Qnh1aW1mWDdKNEI5cXJQS3l1NTkzNUlkc0ty?=
 =?utf-8?B?YjM0WlZSZXdvS0pvOFVDdDYwbVhvejQ2clhKeU4vMnRxL0VwVjkwZWY0WjVJ?=
 =?utf-8?B?SE9CNnVBcVhpMllsWVVUT0R2eWRZaTRUcFYwU1RRWUphaWUvblVUTkFWVlRx?=
 =?utf-8?B?VDBxVnNKQWlKZ2kvT1F0MkNYczRQMksweEg5TGptazdxRjkzWHNTYUZZVWZs?=
 =?utf-8?B?Wng3U1Z0SWF3YWFEK0hLTmlEdjZkUWJCdmhXWWNJbkhmUU1GVVFPb1YvWTZM?=
 =?utf-8?B?U3lqbjdvdE9HL1lGeDdXODliVFRNeFVOcFpibkRvNUZTUE1uMHRuam80aWNz?=
 =?utf-8?B?dkFLZTRGZ0xSNXp5WFY2bmdPUUE1eGQ5NThaRSswVDVnWW9JT1A3QzAwcWtZ?=
 =?utf-8?B?UlZDdnNhbUlOY244U3FXait3aHJVY3QxMi9XZjBhazRyNGtyTmNQeWc4ZUo4?=
 =?utf-8?B?VHQwVzhkYkdDU3V5ZzdOa0xPcUlTbzBTeDNLRFQ1am9NS2hJWVhWd2xRWEVq?=
 =?utf-8?Q?sDGd5WJcC7rKaK2SBJIzvXFH+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ff0c6-fc90-4068-0dd9-08dd1f6a54e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 13:46:10.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qRfJL8U9ywXEQKssbTIuLPIZLFEo3LIQoREx83j/D2FIKsnUglENvREe8KBWtBdN+5NGBepP2kvc6yKImgUCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIERlY2VtYmVyIDE4LCAyMDI0IDU6MDQgUE0NCj4gVG86IFpodW8sIFFpdXh1IDxx
aXV4dS56aHVvQGludGVsLmNvbT47IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj4gQm9y
aXNsYXYgUGV0a292IDxicEBzdXNlLmRlPjsgTHVjaywgVG9ueSA8dG9ueS5sdWNrQGludGVsLmNv
bT4NCj4gQ2M6IHg4NkBrZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSB4ODYvbWNlLzogTWFrZSBjbWNpX3N1cHBvcnRlZCgpIHJldHVy
biBib29sDQo+IE9uIDE4LjEyLjI0INCzLiAzOjIxINGHLiwgWmh1bywgUWl1eHUgd3JvdGU6DQo+
ID4gK0JvcmlzICYgVG9ueSwNCj4gPg0KPiA+PiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5i
b3Jpc292QHN1c2UuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxNywgMjAyNCAx
MDo1MSBQTQ0KPiA+PiBUbzogZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tDQo+ID4+IENjOiB4
ODZAa2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IE5pa29sYXkgQm9yaXNv
dg0KPiA+PiA8bmlrLmJvcmlzb3ZAc3VzZS5jb20+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSF0geDg2
L21jZS86IE1ha2UgY21jaV9zdXBwb3J0ZWQoKSByZXR1cm4gYm9vbA0KPiA+Pg0KPiA+PiBJdCdz
IHRoZSBsYXN0IGZ1bmN0aW9uIGluIHRoaXMgZmlsZSB3aGljaCBpcyBub3QgcmV0dXJuaW5nIGJv
b2wgd2hlbiBpdCBzaG91bGQuDQo+ID4+IFJlY3RpZnkgdGhpcywgbm8gZnVuY3Rpb25hbCBjaGFu
Z2VzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jp
c292QHN1c2UuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9p
bnRlbC5jIHwgOCArKysrLS0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L21jZS9pbnRlbC5jDQo+ID4+IGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZWwu
YyBpbmRleCBiM2NkMmM2MWIxMWQuLmRiMDQzNmU5Yzg5MQ0KPiA+PiAxMDA2NDQNCj4gPj4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZWwuYw0KPiA+PiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L21jZS9pbnRlbC5jDQo+ID4NCj4gPiBIaSBOaWtvbGF5LA0KPiA+DQo+ID4gSSd2
ZSBpbmNsdWRlZCB0aGlzIGNoYW5nZSBpbiB0aGUgZm9sbG93aW5nIGxpbmssIHdoaWNoIHlvdSd2
ZSByZXZpZXdlZA0KPiA+IGJlZm9yZSDwn5iKDQo+ID4NCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI0MTIxMjE0MDEwMy42Njk2NC0yLXFpdXh1LnpodW9AaW50ZWwuY29t
DQo+IA0KPiBJbmRlZWQsDQo+IA0KPiBEaXNyZWdhcmQgdGhpcyB0aGVuIDopDQo+IA0KDQpUaGFu
a3MgTmlrb2xheS4NCg0KLVFpdXh1DQo=

