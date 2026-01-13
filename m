Return-Path: <linux-edac+bounces-5624-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA67D1AE89
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B0523009266
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D09352C30;
	Tue, 13 Jan 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn5JCq2x"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5312E974D;
	Tue, 13 Jan 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330400; cv=fail; b=Fsa0NOy6IhZeMemTA+pLymX6vj+YMohM/kt7OIKFm4tVxLev7zNWuMLAMwelPAIcgn+OA19fht+4zc++4GiEjDGy3ZuXmmGGmZeVs1GMCkYdKgO9GtjEFewC2kZZvMUCwDfMo0IsmMxX9J6rf36vUnTeGnSNm10Gn2uBAyPKSSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330400; c=relaxed/simple;
	bh=KEP9/AOkjJj6e/z63e5//jSDMePk0HOkfOqT+Fm41F4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U336Ya4NmWYhyF3cgp8JsCZ7PjgaUaFQWMRGCGGLOUepv6igf3EFCPyh7wRfRClH6Nsww9v7h3EHtALbYKmK+8cXpfeZLXNaNn4fbHOla2O8vCqgCc2iGsS90NXQR3iHTOFWAHFjwQJM+sQtZ/m73FB5iAKWTzzmHvT55RRX4ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn5JCq2x; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768330398; x=1799866398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KEP9/AOkjJj6e/z63e5//jSDMePk0HOkfOqT+Fm41F4=;
  b=bn5JCq2xz0ff4StRW/eUxs075bwTVXddx5YmgGhqOrD/2F2sTlZfnkBC
   BhgUOYO6972zyDfZQCd2mj9Hfsy/oe65lGasTVYO7LDvpUs79ACewXs/+
   +l8NZ5EWn6MLkwN3D/HLSTZzqLi+vG7wy+8FyR3Cf5CUriEJVpS06yX9a
   14PX7hJDieShIGu3d+Sxvn4jGa2hbFHF8H0TNo6O1E3S7qb2DOfSZTJnB
   lzIEl/HBDd6H8bgHUbrwd7cYOuSmPrlWhFqbzqAwc55JFe0Mf1ZavG6gf
   0sVFj75XCNjif2MII0GowiCQ/NDMluzqrYvhzQkltpilOu663SyyPByUC
   g==;
X-CSE-ConnectionGUID: pMSJ+u/cQ76mYQuX04yerA==
X-CSE-MsgGUID: aYPomvBsSz6DgUelO4BMRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80989413"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80989413"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:53:18 -0800
X-CSE-ConnectionGUID: klK2Sw+kS0Wqm10Sk2qhCw==
X-CSE-MsgGUID: YaINjW9pRuOInacAEX3MDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203598741"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:53:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 10:53:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 10:53:17 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 10:53:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3DpJFN1CEy/RBA8zYSo8+RsS3aeX6X+1fhrXSl1d8E5gE+nhh177+HudRTWYpxaTh7rK6BRqg7aQhjPXxriqqrPaEdqtsxd44A1y+QJBRPVotuGO//3b0yRvJORI4R+cE9VmlfF+aws7LyoSIKrJqoQs+av88usJRCBg2d14ovBiJTEa+qKnjKZYPE6pslBp77hMXoaIFa+fRZBs/lCXtTdI9Zk+DIy+lXHAjFEoienD5l963caJ7n5Vf3x7P4mBHZRsW5r3TWwg5EcgSMhUw9YjF4m5uFqhX+1hgZ1hnGvOp9LmBhnDCBR9kxuYXYkyYY4KmYVdrJUufR1g+xVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEP9/AOkjJj6e/z63e5//jSDMePk0HOkfOqT+Fm41F4=;
 b=Idq/HZ6qgIPna9nY3tiju5sCtFc66uInfjckHMeJ0aj+ipMKaGnQDKaVCgRFu1SEBOTndHZe6LKEa2nMi+pJhKkTS7tWKGfCn+CmyFAFPP7HNnNZW6DPzjE8+FA41TsYkl7QoMoGYm75gsrQHEyRVQwHa6iRKk82k7c1x49+LubqqA2PS1T/OBZhRssZA/Ie6utcrsUOJKcBdBBq370mIGcukbrMLcpHeCVmDOv6vfHioBMlDH4x1VtcxHxjorYDaGBShvLDFtkQmtdDtNVs9qihf4YJoHTTCsn9FQ8cHrBjWcsjMYO19vW8vfhs5FkEJLe8hflbKKCdHKxt4qIT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 18:53:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 18:53:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Li, Rongqing" <lirongqing@baidu.com>
CC: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7ZdIFJl?=
 =?utf-8?B?OiBbUEFUQ0hdIHg4Ni9tY2U6IEZpeCB0aW1lciBpbnRlcnZhbCBhZGp1c3Rt?=
 =?utf-8?Q?ent_after_logging_a_MCE_event?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQ?=
 =?utf-8?B?QVRDSF0geDg2L21jZTogRml4IHRpbWVyIGludGVydmFsIGFkanVzdG1lbnQg?=
 =?utf-8?Q?after_logging_a_MCE_event?=
Thread-Index: AQHcg5123MgPXG+o9kCRbfhvENq45bVOO4iAgAALDoCAAAQuAIAACTCAgAGJHICAAC5XAIAAAzyAgABVQpA=
Date: Tue, 13 Jan 2026 18:53:13 +0000
Message-ID: <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
In-Reply-To: <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7917:EE_
x-ms-office365-filtering-correlation-id: ffd39e18-9f27-4a34-7fa6-08de52d50128
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y1F0cmppV0ViMHBDUDBQcUVHWnF3NGhheE9FcVNSblAvN1JHMnpDTm55M0NU?=
 =?utf-8?B?dlArQ2h1VVdEdWszYmRQRjJraEtPaG5ObW52eTJjQlNUY1RJZHROMGZ2MkQr?=
 =?utf-8?B?Q2picWc3K29DQ0d1bTQ5Sk90cWNROE1iUTBDUWpKZy92K0tnR1g2Ym02SHp2?=
 =?utf-8?B?Q1FlU1dpVU9qdWw3Nmk3S3BHQ0oxcWZDUWNqNWZpcjhMMXM1K3ZNbkJ1cDhl?=
 =?utf-8?B?R0YwUUhoSkRQSktZcCtyWjBTbEhqM3gyNzJxZVkrdzNOL3ZOcFBDc0twOHVp?=
 =?utf-8?B?aFBIRVVoVW9idEVBYWpiNHk3eWRSQmJWTVlFaWRncjY4WWJCR0w1Uy9BYkND?=
 =?utf-8?B?VXhqV1c0TnpLK2N3OHVvYUlGT2xXVFh2V1VlWEJkRkxjd1AyZkgvT0t3WkRC?=
 =?utf-8?B?VTlHSG1sZFJPQkZzSURpV1MwOWIwY3NyQm4weUNpVkIyWVJzcmRSQUN6ZzdY?=
 =?utf-8?B?amRHcnoyWHc1TnU3cEpuSEdiL2ZEYTdmQWVjY2J5cEg0S0hFWUgzWHdMcnF0?=
 =?utf-8?B?dFRSQkg1d2wram5lb3pCWTV3TlVlQ0ttY2lYNnZiOGNiVFg2cTdyVGh3TTdU?=
 =?utf-8?B?djZXSlYyeG1tdk10WWpJOVJpV082cnRxREhvS3daenBJcWRDRHQ3SC8rWkFC?=
 =?utf-8?B?MmRMOHNQc2FId0h2aWtSUlhROXpCaWdHc044U0NKWTVRakd0bHhpQ1FQOUl2?=
 =?utf-8?B?SUgvV2VtY2xTc0JoY2x5RWU1UDdCdFZiQXliRlExbnFOTmRYd2NBVjFaZU1J?=
 =?utf-8?B?TlJEUnBVcFNwTDcxdlZtWVRweWQrRml6MEdiTkxSanJsR0FwUTlEb3V2MVAy?=
 =?utf-8?B?K3c2c0xPdkRNKytYM0NYQm1DYXRFS2cwcGJlUElTeFZLM3FWVzdGaUJucGQv?=
 =?utf-8?B?YnlIVDRtSDRYbWdvVFFydFJuUWlyY1JoWnBKV0hsWVdaR29YS0V6U2w4TnJ0?=
 =?utf-8?B?T05udzlkb3c4WDQ1cm5yRkFCV3lBNkZUbDV1OUkycjJhdjlUemVReEhBMVA5?=
 =?utf-8?B?TjNxeWM5YkFCMnZGNGd1VEV6TTE2aWFkZmVGY0loNHE2Y3h0SitHekxORE5O?=
 =?utf-8?B?U3ZWVU40YmVZNk1SOEk1eU90Szkzamo5OUxSd01oUU9BTjROMVZ0Zkx2WmRJ?=
 =?utf-8?B?eUptU211SVhtU0JneTZlSFNUU09LM3k1OVdDK2RaTkpTOGY0bmZDVGJzZE5l?=
 =?utf-8?B?cWVGNkdoSUpvNVh3RmlWTjB1YmZ5VWhSSnlMV3Jsai82czBPSEpJZ2xRNmdI?=
 =?utf-8?B?Y1RnWjl1cktPRW4wZUNNcmVLN0RMbFVKN2JIQUtQOE83QVB6QU10SlpHbEZV?=
 =?utf-8?B?eUlRTjRpRmcxN3BFenkxc3MreWg4QW0zekQ2TS9Uam5HbWFVZTdzd21zWEFW?=
 =?utf-8?B?dDJDdlYzRjNTeGNYS0dXNXNVMXhJZ293WnluMEZ1VmRVTDA0ZEw4aW9MZ1pl?=
 =?utf-8?B?QnhvcTdicFJac2NtSjRtSUxuT2YvSytZTzJxa0JxVllreEVDd2x1UlJKcTRB?=
 =?utf-8?B?eXliRllhTitSaWF4eW9DakhxMzJDeURoektiQWkxMVpyZFBFOTR5RDc3QlZx?=
 =?utf-8?B?eENXUHk5UVNjMXFGTi9QeUpWQTFTYUZvMlFVOTY2U1ZVN0p2WjEySVU2YWFZ?=
 =?utf-8?B?aStENFZRRjVrK2FObS85UUt6aVFEeEhpVnBYb2hhQ2lxL2Zab1dBRHJ0S2xM?=
 =?utf-8?B?WjdHb0Z2aUd0SmxQQ2NNcVlWaTZlSDR5YXdBQ2xDNWNkQWVYVHNRNXpsbm16?=
 =?utf-8?B?T2hPUjdiNG1pKzI0aVdtRWJPd2E3TWp2aXU5UWpac1lWWkNzOXI2Q0pvc2tx?=
 =?utf-8?B?SmkwbkVjTGQvOW1FbVQ5TVVLRkFJUlhDZ0JtL2svOXZ3Yk1RQks1aFhkclJ2?=
 =?utf-8?B?aCtDSmJZOU5GelhsS1R0WWg3VENqMGpWa1JsU1BFUlgwTWh3TDh1VEp5bWdr?=
 =?utf-8?B?ckZkZ2NoU3h6MDZwdHh0eTl5d1BsZzZlejViT0lxVS9iMmdRNGtLWE5SeTB2?=
 =?utf-8?B?SmIyUytGQ3Q2SVdVdnhGS25ueWpXSXBoblZwV0I1TitXUkE5NXNsSnF1TWpa?=
 =?utf-8?Q?mA36ov?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUZIaEZCTXhYVEtzSUhxYnhaVEwzTTVhdlZlUzJaeHJrU0ROciswd21KTVo5?=
 =?utf-8?B?UTFHSXZOTmJBNVIrYkpyeU9maElmMEVxaXZlQ08xNkh3WndGR0szcXFLRXZB?=
 =?utf-8?B?NGhJb1hpeWRxbmF4bE4vS212VWRvWG9EZ2dGWlQwTHZCTnZWYTZPVVU3amxB?=
 =?utf-8?B?QXRUSHdHSm1PYkdRNlBIYzRsdUZmUjNtdjZXTDNrZFpRQkUzSG00OXB5ckxJ?=
 =?utf-8?B?RVhHZVlzWEEvOEhRY1lmVnd3bTI4dFdhU0dCb2xOUTZneHBhazRyMi80aWJp?=
 =?utf-8?B?ME1POHBJOEpQL3dBS1l4UGx0WkRZNVJGaTU5QnQveW4ybDFsYlFwaDlrWHJR?=
 =?utf-8?B?ajJkcndXcDBZQnlXQi85dDQ5c084elFKMENFWTlSZlRPQ0FtdXVjaGphbUJQ?=
 =?utf-8?B?Wkt6cWd0MnQ2cytwQ01TTjUvV28vQ1lleUs4ZnBqT2VJZmh5TEVZNHRYUnJ3?=
 =?utf-8?B?anRobGhEVFBZK3l3OG9pOUo3eTkxM0ZxQTIrL3VGOGFyeVVDTGJtWlFYaE9t?=
 =?utf-8?B?TkFWVFZYWmg4OTJpd0VyM2h1K1pFR2k1c1U5dFJ0amczL1lVZzY3NGlOY1I4?=
 =?utf-8?B?TkpRNVcyd3QrM3RRQ3JIN0pQOHpJNi9PZGhDT0V2U2ZpcStyTERoV2VSMmZo?=
 =?utf-8?B?MU10VjBxSFhZOXhQaS9OWGlvRSs4ZzlINXlBZUhFZzUzNHVVMCs5dE9qMUhC?=
 =?utf-8?B?Tjg3VWhObU9DOVkrTUdncmxUNVAwOEg5R3BSVjk3SXhjdEhZeHY4d244RHRj?=
 =?utf-8?B?ZXFPbjhoT3VSYXI0SkdWY3RndDNOZ2tVejE5T1BPclQ4K3JrWWhiZ0hTRWM4?=
 =?utf-8?B?TEJteEllZHJ4WkJnbFRLNTh4VTVBVW5xZGZwVXF1N210QktVbjErcW8wWmRj?=
 =?utf-8?B?ZjRHSCtpSUg1THhIRFdsd3F0Z2piTHo2R0xDcyt1WGJlOVJkOGZ0a2FIeUJP?=
 =?utf-8?B?SHBFcHVRUGE5MUZLaDhVRGdKYlZlMHVqNTFDb1pBc2Y0YStoTHZLclV0Z2ds?=
 =?utf-8?B?TEN0bHVFZUFTVXpvdnJtR2VsTXMvUlRLODhkTlcycTFlQ041cVM0dzVabG0w?=
 =?utf-8?B?d1UzMkpGTGZJMDR5bFpKNmNoZno0WG93amRaeUdocFhZTWsxV3ZsM0hKZkFj?=
 =?utf-8?B?eFBmZVZlQWdnY2RlWDk4dzJ2TTE4QmxBRVdRMENRWWMybWx4cUdldDd2UVNK?=
 =?utf-8?B?aERCSnJra0s5UTV6Zkgzcmc5a3hPNHc2WXRIQlVSQW1Na2ZoTXhUMG9DZStu?=
 =?utf-8?B?Q1F5dVBtb3FMd2JRbWRxTWQrTVZvSVJ6SW5abHpJbmwwUFhDSGo4bnRKdWdj?=
 =?utf-8?B?QzRvdi9PRVhzRWpTMkhzMUJrb2RILzZHam1nMnhiRkhYak1WZHE0TWsvZXhU?=
 =?utf-8?B?OGdROUZMWE5CaEZTMkQzQjZ1UVR6RVpqNnhCVFhocDQ2S1VTY3ErRmd0V3dy?=
 =?utf-8?B?aHFSWmpmYllpU3BoTUNkeGVFd09SVmNWWWRGUGZLcmxWQjVYZEV3S2s1eTA4?=
 =?utf-8?B?eGRaN09GTGhJdzdyS0RUWDVvUXlFZHNxaGJLRkRhMEYxWDlmUndsVzdKMGxj?=
 =?utf-8?B?dVVCdG92cDdhZnBmQ2gyb2RQM1pjaHd5Yk5JbVdhSWIxZDEwNlNQcEZjbmJ1?=
 =?utf-8?B?eU5INXJQOERsY3p2aDE2Z0hvck9Mc3EyekpReWdCcWNUcmxnL2JYWjEzNXdi?=
 =?utf-8?B?TGNkWXRwUUVhWXRsOE5pekp4d0ZuWUlaeXVCZEkzYjR4MUZoN2oyT0Y5MVpT?=
 =?utf-8?B?cVAyelNHbFVFbkJFWkNtWVFwNlVxYjBUV0FGdE1xanMzZ2ZXRWgyek4zWU5P?=
 =?utf-8?B?RllDeG5oSGs4WkNyaUI1aXRWS1lGL2tNRSs0S1VGRDNqbVVUY0JoZ0JTczRF?=
 =?utf-8?B?WE1LSEFJdlpZdXBteVl6dTF3TWhEdmhocVdyWGVVNDV4Q3dNQ0JBMHZ6Y0RD?=
 =?utf-8?B?YjdqRjU5dXFVYjNDMEhhQjd6czFnZnpDNG85Mmt2dzFRaFA0MXgyS3ZDbUVN?=
 =?utf-8?B?NVljSlJ0c2owVWl3Ym4xSmVJdy9XY2VwSjJjb3Z3cmJkYzJsUFNWdEgzZlU0?=
 =?utf-8?B?Q1VNSXRNWjZjMlFDSnQwU2JPT01jc0h2aGxMZklIc1FxbUpXcVZKclo2V0ln?=
 =?utf-8?B?bXRPWGhzaXdQb3hXOEI1N0U4WVF3Q3h5bUVGQnBWbCtybENZMzVqV3NtRmZv?=
 =?utf-8?B?MTFHOXlPTVZLRXhaQjBsU0FvWFJYbzJDNE1zN2F3bXY5RjJ4UWwvVmVGckVp?=
 =?utf-8?B?aUlobEp0SUkzSHJIVHlLUFkvTjRQT21mYmdiZ1U3RmtUV2J1OE1KbHdmejlR?=
 =?utf-8?Q?/QQDn9srwsUpoXpENZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd39e18-9f27-4a34-7fa6-08de52d50128
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 18:53:13.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXzkpE7J2x7d56Zgv7X11s3gyLA2nnFtYZa4FGhd/XVZLAHceqVrAazWJrccmpkXuTql8vFuA1MKu5ktx+NAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com

PiA+IFRoZSBjb21tZW50IGluIG1jZV90aW1lcl9mbiBzYXlzIHRvIGFkanVzdCB0aGUgcG9sbGlu
ZyBpbnRlcnZhbCwgYnV0DQo+ID4gSSBub3RpY2UgdGhlIGtlcm5lbCBsb2cgYWx3YXlzIHNob3dz
IGFuIE1DRSBsb2cgZXZlcnkgNSBtaW51dGVzLiBJcyB0aGlzDQo+ID4gbm9ybWFsPw0KPg0KPiBV
c2UgZ2l0IGFubm90YXRlIHRvIGZpZ3VyZSBvdXQgd2hpY2ggcGF0Y2ggYWRkZWQgdGhpcyBjb21t
ZW50IGFuZCBpbiBjb250ZXh0DQo+IG9mIHdoYXQgYW5kIHRoYXQnbGwgdGVsbCB5b3Ugd2h5Lg0K
Pg0KPiBBcyB0byB0aGUgNSBtaW51dGVzLCBsb29rIGF0IGhvdyB0aGUgY2hlY2sgaW50ZXJ2YWwg
Z2V0cyBlc3RhYmxpc2hlZC4NCg0KT25jZSB1cG9uIGEgdGltZSB0aGUgcG9sbGluZyBpbnRlcnZh
bCBzdGFydGVkIG91dCBhdCA1IG1pbnV0ZXMsIGJ1dCB0aGUNCmludGVydmFsIHdhcyBoYWx2ZWQg
ZWFjaCB0aW1lIGFuIGVycm9yIHdhcyBmb3VuZCAoc28gaW50ZXJ2YWwgd2VudA0KMTUwcywgNzVz
LCAzN3MsIC4uLiBkb3duIHRvIDFzKS4gSWYgbm8gZXJyb3Igd2FzIGZvdW5kLCB0aGVuIHRoZSBp
bnRlcnZhbA0Kd2FzIGRvdWJsZWQgKGdvaW5nIGJhY2sgdXAgdG8gMzAwcykuDQoNClRoaXMgaXMg
ZGVzY3JpYmVkIGluIHRoZSBjb21tZW50Og0KDQogICAgICAgIC8qDQogICAgICAgICAqIEFsZXJ0
IHVzZXJzcGFjZSBpZiBuZWVkZWQuIElmIHdlIGxvZ2dlZCBhbiBNQ0UsIHJlZHVjZSB0aGUgcG9s
bGluZw0KICAgICAgICAgKiBpbnRlcnZhbCwgb3RoZXJ3aXNlIGluY3JlYXNlIHRoZSBwb2xsaW5n
IGludGVydmFsLg0KICAgICAgICAgKi8NCg0KSXQgc2VlbXMgdGhhdCB0aGUga2VybmVsIGlzbid0
IGRvaW5nIHRoYXQgdG9kYXkuIFBvbGxpbmcgYXQgYSBmaXhlZCAzMDAgc2Vjb25kcw0KZXZlbnQg
dGhvdWdoIGVycm9ycyBhcmUgYmVpbmcgZm91bmQgYW5kIGxvZ2dlZC4gSW50ZXJlc3RpbmcgdGhh
dCB0aGUgdGltZXN0YW1wcw0KYXJlIDMyNy42OCBzZWNvbmRzIGFwYXJ0LCByYXRoZXIgdGhhbiAz
MDAgYW5kIGNoYW5nZS4gU28gdGhlcmUgaXMgc29tZSBzdHJhbmdlDQpzdHVmZiBnb2luZyBvbi4N
Cg0KSSBjYW4gcmVwcm9kdWNlIGhlcmUgb24gYW4gSWNlbGFrZSBzeXN0ZW0uIEJvb3RlZCB3aXRo
IG1jZT1ub19jbWNpIHRvIGZvcmNlIHBvbGxpbmcNCihhbmQgdHVybmVkIG9mIEJJT1MgZmlybXdh
cmUgZmlyc3QgbW9kZSkuICBJbmplY3RpbmcgYW4gZXJyb3IgZXZlcnkgMzAgc2Vjb25kcyBJIGFs
c28gc2VlDQpjb25zdGFudCAzMjcgc2Vjb25kcyBiZXR3ZWVuIGxvZ3MgKG11bHRpcGxlIGxvZ3Mg
c2hvdyB1cCBiZWNhdXNlIG15IGluamVjdGlvbiBwaWNrcyBtZW1vcnkNCmNoYW5uZWwgInJhbmRv
bWx5Iiwgc28gdGhlcmUgY2FuIGJlIHNldmVyYWwgYmFua3Mgd2l0aCBlcnJvcnMgd2hlbiBwb2xs
aW5nIGhhcHBlbnMpLg0KDQokIGRtZXNnIHwgZ3JlcCAnTWFjaGluZSBDaGVjayBFdmVudDonDQpb
ICA2NjIuNjMyOTg4XSBFREFDIHNreCBNQzQ6IENQVSA0MDogTWFjaGluZSBDaGVjayBFdmVudDog
MHgwIEJhbmsgMTM6IDB4OGMwMDAxNDIwMDgwMDA5MA0KWyAgNjYyLjcyNzM3N10gRURBQyBza3gg
TUM2OiBDUFUgNDA6IE1hY2hpbmUgQ2hlY2sgRXZlbnQ6IDB4MCBCYW5rIDIxOiAweDhjMDAwMGMy
MDA4MDAwOTANClsgIDk5MC4yODM0ODRdIEVEQUMgc2t4IE1DNDogQ1BVIDEyMTogTWFjaGluZSBD
aGVjayBFdmVudDogMHgwIEJhbmsgMTM6IDB4OGMwMDAxMDIwMDgwMDA5MA0KWyAgOTkwLjM3ODIz
M10gRURBQyBza3ggTUM2OiBDUFUgMTIxOiBNYWNoaW5lIENoZWNrIEV2ZW50OiAweDAgQmFuayAy
MTogMHg4YzAwMDE0MjAwODAwMDkwDQpbICA5OTAuNDY3MTk5XSBFREFDIHNreCBNQzA6IENQVSAz
OiBNYWNoaW5lIENoZWNrIEV2ZW50OiAweDAgQmFuayAxMzogMHg4YzAwMDA0MjAwODAwMDkwDQpb
IDEzMTcuOTM5MjYwXSBFREFDIHNreCBNQzQ6IENQVSAxMjI6IE1hY2hpbmUgQ2hlY2sgRXZlbnQ6
IDB4MCBCYW5rIDEzOiAweDhjMDAwMTAyMDA4MDAwOTANClsgMTMxOC4wMzM3MjFdIEVEQUMgc2t4
IE1DNjogQ1BVIDEyMjogTWFjaGluZSBDaGVjayBFdmVudDogMHgwIEJhbmsgMjE6IDB4OGMwMDAx
MDIwMDgwMDA5MA0KWyAxMzE4LjEyMjYxMl0gRURBQyBza3ggTUMwOiBDUFUgMTQ6IE1hY2hpbmUg
Q2hlY2sgRXZlbnQ6IDB4MCBCYW5rIDEzOiAweDhjMDAwMDQyMDA4MDAwOTANClsgMTMxOC4yMTE1
MDddIEVEQUMgc2t4IE1DMjogQ1BVIDE0OiBNYWNoaW5lIENoZWNrIEV2ZW50OiAweDAgQmFuayAy
MTogMHg4YzAwMDA0MjAwODAwMDkwDQpbIDE2NDUuNTkwNzczXSBFREFDIHNreCBNQzQ6IENQVSAx
Mjk6IE1hY2hpbmUgQ2hlY2sgRXZlbnQ6IDB4MCBCYW5rIDEzOiAweDhjMDAwMTAyMDA4MDAwOTAN
ClsgMTY0NS42ODUxNTNdIEVEQUMgc2t4IE1DNjogQ1BVIDEyOTogTWFjaGluZSBDaGVjayBFdmVu
dDogMHgwIEJhbmsgMjE6IDB4OGMwMDAxODIwMDgwMDA5MA0KWyAxNjQ1Ljc3Mzc0NF0gRURBQyBz
a3ggTUMwOiBDUFUgMTAwOiBNYWNoaW5lIENoZWNrIEV2ZW50OiAweDAgQmFuayAxMzogMHg4YzAw
MDA0MjAwODAwMDkwDQoNCi1Ub255DQoNCg==

