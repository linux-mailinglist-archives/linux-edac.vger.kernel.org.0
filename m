Return-Path: <linux-edac+bounces-3023-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60DA30BD8
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7DF3A4CD9
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853361FCF7C;
	Tue, 11 Feb 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp5LPU3J"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF46FB9;
	Tue, 11 Feb 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277453; cv=fail; b=kDHhgZb3wM16O6RuAslbvVTCl+/5qTd/swXMZMtVw4JUFQKV4OBq23pDOV92REBRPD+4LVI1nV5qsDmwFIsfupn5hFy9vmHAatoeTSyjaIjnFh/jnksll6bAiTy9I799m2ljJ2hF8O1UjE67srjiV5/ksVrEijkccSRbZ/As+uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277453; c=relaxed/simple;
	bh=whEzsY6qXa1d65lmN752R1k8LeblmTIC6jdrQtTsLik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWS+QQsaNAHFTUOxKdbBy7KQ2Bvw4J22O33Z039RFpU2xue6BfpHDMDx9/FdC9h/dRUZWLf3Tiw8qZEFHiBubfxVWGnYeUeE6fxdxyar1eyrScnKmyVPwjCMDc07m/v4mFHewBWoPy82EqisoRE/PEIpoZxod4Q/BxUJp8Kib6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp5LPU3J; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739277451; x=1770813451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=whEzsY6qXa1d65lmN752R1k8LeblmTIC6jdrQtTsLik=;
  b=hp5LPU3JM6Byd9dyipY+ZXoZ9InglUxyersZwJKc2I8B0d8N3wuL/V1F
   J0D//UO4tr7x9ieT+EewNkeoJXeS+o1oIffiLraVDBIjvd2rPmSEGdoYb
   uXpUB9Jv0xHznomv4u+DoaEBLGV2MxtJzBGWWQZmhdAc9wAdMDrgF/3AU
   Dn2/WSZsMnQer7rAkBkbtutTbhtQTPHA+OlxldX5aN/hsfjNYzxAam26K
   41xjjUmExPISq/Xvdtx4qMxO/qluGs7egZd95ytGBSIwE6IfVU+Wpanik
   nLjTis5LgP9E+PaWQqm56IiY3qQmcg9YBrpR3oUIB2npFesmxGOO9mVHq
   A==;
X-CSE-ConnectionGUID: L7MtUuIsRiOvlfd7/WkwCQ==
X-CSE-MsgGUID: z7FhA+vJQMiAbi6wnfPt5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="65248403"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="65248403"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:37:28 -0800
X-CSE-ConnectionGUID: H9xt/t7tSqaUvSo1tM9BFA==
X-CSE-MsgGUID: sa4k5bQpRgONYqBgiVpiFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149683229"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 04:37:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 04:37:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 04:37:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 04:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iADcJDJd7JSu1feBun2KptZwippxCpobYxR4KiWjBBF6J6q5K+bGYYFBXX0ns6keMs2hoxLLxVyN0fpqVRCJQzVfPgYbMZLcf+qEaNAAGjKgvsyGF1v3zOfXCST12h5Fp9cOapE/u0L1ZRLkSBvxxaE2qj+TVLuePP6+uN+TOthbcNRNkHbBZ+fL9lSdaIfU7jjyExECEGgj9WNeQmNy1W7NGzJSJvrerog/1ExtocRdTdCwGrmufSoSFHjf6OdXTRBFoJuKW0MMJF5DUWNd760+JfnaM9/fabtmHuz2N8mKtiK1eQ5gIQYOA2TStyPYISrlrmKadkuenkYLjrug0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whEzsY6qXa1d65lmN752R1k8LeblmTIC6jdrQtTsLik=;
 b=eMdNsOr6TdATfpwWuQW8VlWtQXvb3ObfKceaMPhfka70RlPSBvHEwNKq50vBQrC/mmwYCQY5rQyKGtFgSje7faIF7hKHMNcimz20DGMhqw81iwus7EHBa4yTWm7mE2V+KLUIe1e5qJej4KBLHiH6jMeWqn8lX7KQagE12R71/+5GjiIDWpiutwxaC5ERBTKEKbjHulFPQDi+wiPnuLfPVPrZSv5FzLQ2ZDvc9MOE5X9fPyywJVSCN7xLUUppjgl7wTN6Evci6BTO//gRCHoyuVw3hwvxMPgRzuNojDnuk2eMmG4beKxsq68xwgOZASvhtyQJsuVqbqcTO8zTfo9hKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 12:37:12 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 12:37:12 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
Thread-Topic: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
Thread-Index: AQHbe9MmPOK3qhQALkCLeoLYg5EdtrNBrQ7wgAAfB4CAAD4xYA==
Date: Tue, 11 Feb 2025 12:37:12 +0000
Message-ID: <CY8PR11MB7134B7C43B2CC3B4B0B1919189FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
 <CY8PR11MB713403A5AC3B0699B56A552F89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <1ab8afe8-761f-416c-8584-dcf15972e363@suse.com>
In-Reply-To: <1ab8afe8-761f-416c-8584-dcf15972e363@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB8226:EE_
x-ms-office365-filtering-correlation-id: d718a016-c3ab-4b6c-5f0e-08dd4a98cef2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFZFUXlzM1RDVm5LNENQbVZsS055MFJWMXRicGQ4b1dmYW1XeGNmNXNpZjRV?=
 =?utf-8?B?alcvbnVYUWg1a0R4Uk5sMVE5b3plWk1lYXN5MlMwb0U1SlRIb3ZNbWRCN0Vm?=
 =?utf-8?B?L29qam9mQWE5NVQ5cWFZam1zMUozSnljcGY5SHFiWGpuU09vUEd1aFhDcEpW?=
 =?utf-8?B?bm9FTnhxSHVONno4ekp1NUZQWkR6WjlZY0VBOXM1YStjOXJsNTF0NFNVa2Nj?=
 =?utf-8?B?TlhmYUNWMzJPT3dpcHZ5emltSExTSEZOb3M1eHBEL2VqRmM5ejdPVDFkYnVy?=
 =?utf-8?B?MU5rRUdWR3YxVzhVMC9taTBoQTZnd2oxNjM2WTh5eHNTK21VU09vNTZDL1dr?=
 =?utf-8?B?ZkQwWmpEeWNTK2YwZzcvOUc3djQzNWd5VHNjaWFNSUlxV3pBNjVwdCtIN1NT?=
 =?utf-8?B?ZkVuUW9jNDF2aGVzTEV4Zzd0YlNjM1A3dWc0VzZqZ0UzWDJEaEFnTW5Zd3hm?=
 =?utf-8?B?Y1VtbUU0UWxlK040S1BMdzZwamxtTTlsSnNtMTVPaEd5d0M0K0pCaGd1Z2Iy?=
 =?utf-8?B?LzJwMGtCNDRUNmN4V01MUG5JbFdzSy9IMHpRQlptSlZZSHNSL28wc2IwSVdm?=
 =?utf-8?B?RVlLdkJSRnBNU0VPSFVSTFRPRVZpNTI3dnRVTlhQR3VVOGYwa3pQOEpKemtu?=
 =?utf-8?B?NzJVL3pZVDdIK2laeUkvNUIxTjJmT1hQQVp2NmxXd0F0NVdQRC9ETllWREpw?=
 =?utf-8?B?dDhNY1RvSzA1OXo1Zm1kWk9vY3B1VVlXYUZzWUVCTjhYaVJSdFpMUVJOKzRX?=
 =?utf-8?B?a3lISEJQbExycG9QMFpHZG84a0xSZFBZZmpRNmtvR2duQk5oZ01nOVlNMzl3?=
 =?utf-8?B?MWRhdmNJbnhCQ1FheFBvUFFONGpTb0lPWnN4SXN1bFZJZUZYbmd3Nkxaenkr?=
 =?utf-8?B?OUhvZUlnYTRFWFhHQzR0S0UrV0lZak1FMDFidmo2Z3JLV3FWVjE5eFJqeFNx?=
 =?utf-8?B?NGVORHBDNmhtRkVzRUlBQmw0Z2dOUHRIcUlqUUVGWDRtb2hNWmRTT1RXRkRN?=
 =?utf-8?B?akhJY3JsdU10SEF6S0lWRTFwQUg2MzhjLzl1anBSdldrU2Z2NnBXRDFNMmNh?=
 =?utf-8?B?dXhkcjZKclZXL2VpYlBvSlRoVzZWbURFeGxFanZ5UC91eUtrZHMxQVN6ZE1H?=
 =?utf-8?B?dEwrNU5nYkpuVVJ2WVd3R1YyOFZCa3RpalUyOEtlYkUxY3ZUeHBDLzdYWlFJ?=
 =?utf-8?B?VnhuSjJyRzVXS1dkcGM4Y1Q4LzNWay9yRDJoRmlFRkpwaGdvblpLd2R4K2VM?=
 =?utf-8?B?UFlVd3VYZUJFYjNST2VWanpYeWpia0JOOFl3bkdVeW9kR2FEMU9QdDFsZ2Zs?=
 =?utf-8?B?Mmk1S2RRQ3FTNUVJT29ZU05penRHMVFLRlNSTVN5YnBRbHlmQWZCVysrY0h6?=
 =?utf-8?B?RXNrbGpKQ0hVVkViaGdFaDhOa3p0NStLZ2UyeVdDM1diYWo2d1p1a2pUQkFC?=
 =?utf-8?B?UFl4dm5wam03YlZEZlJxSzFBT0phd0pTdWZnWDFIRmwxeGdSTWpwMERnVWpm?=
 =?utf-8?B?VGdrN29SZHBXcmh1VTA1S2R6dTVHMDRtYmFmTFNicUVYTTVFVGhFK3lwMlFN?=
 =?utf-8?B?QmxmRXdKVVoyRlZySkRSbFNpdzVhYUFTT2hVRmQxVnNQSGVIRCtMOWU1T0J2?=
 =?utf-8?B?UlltZFUydzYwVVFUaXlocDhYT09lanc2emtUVC9ROEU1aFpna2NjajJyVk9x?=
 =?utf-8?B?S3BxK3BxMTVSMlQ5bXlVYmdYNmh3TjlGVFZsekNVYWdWcTZKbm02VkZkd3d1?=
 =?utf-8?B?V2JxS3ZCamxUcGdTOTVCYkZRdkhDeTFuZHNVK202aml1U2tkMi9rU3ltV2lx?=
 =?utf-8?B?aVR5UWcyeUl0TityY0x4VWl4U21ZMm5ONWFnMWJMU2ZpWUppN0lyczExNVph?=
 =?utf-8?B?T2U2YW5jUXNlQVZEb1laSUh0cDZkbzlycVN0TDNYc2oydWNaU1BBMnVFNTVL?=
 =?utf-8?Q?zivRID6Z96XzsGmyW5/ovw9j0sY2IqXH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjdoWDBUcUQrV3UreEM4VzJ6a3NPRk03bDZNTDhtTHpZQm9JWThicHJkSERD?=
 =?utf-8?B?NUlEQ01lYWY4SmZQVnJFZE15ZE92V2pjM21jNEt4d25VN3Mvc1BmMWZNS2dG?=
 =?utf-8?B?UlNDUTNONFFaQmxYKzFZcXdCeGYwTzBqVkp4Umh3TElzUnlRUG0xQXllSFJo?=
 =?utf-8?B?S1RYMHozRmc5NXpaZFhIRWNGYjRyVGVmTkZUMHB4UE5XNVRzWWRVTHpyWk1o?=
 =?utf-8?B?aHZNUDRBemJxM0xlb2dHTVFHcnEyUUxhOEtZSEFpTlhwV0lnY3Z4Z0ZJbTBT?=
 =?utf-8?B?Q2ExNkQzWUhwK0RLMDV1dzhMaFJpdnVZeDcvVm4vL2xBSmNZb3R0VldDcVVT?=
 =?utf-8?B?MWNueUI5Skc2YUdWczB6KzVTSFRhNTFVV2x6OGRWQlEyOW82MVEwWUYwVDBm?=
 =?utf-8?B?cmFqWUw2VWZ6Yy9SalNneUVod1VIL0d1MHpxb2daTlMyWHdMUkVxSElGbTBj?=
 =?utf-8?B?dFppSm1Zakc5S0dRb1diZEVxS3EvMzR3RnU5d2RzU0R4Z2JtSTBxeGZyVjEy?=
 =?utf-8?B?UUx3N0NjQVc1YXRQVnVWRjdNZFFTUG5jcnQzb1EwOGlBVXIwRExwa3RXMmE3?=
 =?utf-8?B?bEp4cnlNQjhRVEJabzZ1ZmxPRjg4YWhYQ3BaSXRsSkdIOGdVOWZEUnpEZlpK?=
 =?utf-8?B?VEpENFpTYndrR2hTR2VjdHNDQUd0aUd4ZEQ0aXczVVFROFdKazF5Mkh4T0w1?=
 =?utf-8?B?d3VveHZuc2R2RVJ6NmpNMGQrOWg2Z0VJQ29jb0NzSUN5cndFU1RJYlFDRkNK?=
 =?utf-8?B?d2E5Qjc5bjFPUjkxTlNuYUpkZ0huN2hJSlN6VWFPTitEMGVLTC9ndmtFYXFD?=
 =?utf-8?B?NCsvcTN4OGZETllYSWU1dmhsUzVhL3gzSDlHTzBYZDRXQXN1dWVBb2d4MTla?=
 =?utf-8?B?bEoxNU9LbkgxcnQvWVh2bG5ZMkxLNkJkWXBydUdIQmZMR295THZiUVRnTVhP?=
 =?utf-8?B?QnA0UFg0K2gvZG1Bb3dGYmJlZEVvT2dBWE40N09OcHRrVTNBcndaYUhCR1lM?=
 =?utf-8?B?YkZFSWVMY2FCSEhrTHBFb1VaWWR4TUFNcXBKQW44cGlGb3VvNTMvVzBFZUhK?=
 =?utf-8?B?Z3c1Vk5aVkZXYnVoekxwTjdyOU54bTZMMHAySjJwL1E1WVVUcCtEOEJtRDNp?=
 =?utf-8?B?OU9iNlRIZlZ1Z2ZIUVFONjRQKytXVnpNa0VvRVViWDRCem9oNzVUQWRxa0pL?=
 =?utf-8?B?cUR1a3lGQUgvL3pxTmcwQ3doaTFaVFRrNG9TYXlkenFBRzVqRGEwdEYwVHZp?=
 =?utf-8?B?aUNjSjZBemhUVUNRRUlKM0Rpejl0SkZuRCtsZThRUjJOR0dVd3dteElUcVJG?=
 =?utf-8?B?SmRpT253RU80c2Y5a1ExdllWQ2NwRHgxcUxJWFB3NVd4MjZsaVNtRU9QRHJu?=
 =?utf-8?B?K3doRnVWV0pLQ3FGVmQrVzJmTDk0TFNBRFdGUytIa0xycWVtb3FNYUhCSE9X?=
 =?utf-8?B?TzRvTmtVM0xIYmdoNmZreWFJcWZsVjhvVXYyc2MrV01PMVM2NzdzZFNlYzZT?=
 =?utf-8?B?cU5YZkE4eHBjalVPamJNbll3UEhNTUhGV2huL1hPMXhMYjNGRjdMYUFlTXls?=
 =?utf-8?B?QlNLVE9UTjZub2xuLzV6dzZaWlBKU0FqSGw3ejZ4bEhsaEJZRVVmdGsxbXIy?=
 =?utf-8?B?WjVobmFaRENvcUN0YWFCSHVNQkZRUTVMVzFFb3VzSCtDNVVVSHFDeFV2dmxB?=
 =?utf-8?B?d2ovTVJFNTBvd3A1eTZzMk8waGJzcHhxQnUzd2NzL2VJV1FGOXBRRlRHdnRM?=
 =?utf-8?B?VlV3NlN6NWt5UzhXRHVxeDJyQ1hweHFHZDdKd0c1ZjBrbitveHlMZXUzUVZS?=
 =?utf-8?B?WDczZWpha01ldU12N1JBZXlCQUtMb2ljMXJCelowdWhzZzIya09tS3k1VFhs?=
 =?utf-8?B?RERkU3MvbXY3RjVTWGtIZlVXcFlabjFwNHl5QlV5TUVUdHloWlFmMHVMWDA1?=
 =?utf-8?B?WFloS2xTb0Q3TlR4ZVc2V0x3akhFM1FHNmJXb0RvaitaYldneVVBRzF3WWI5?=
 =?utf-8?B?VEJOdU54dVRaZ0UvTFJOMXVCNUpsaHFvc3V5WVdIWmZURmFXLzJRWFA1b3FF?=
 =?utf-8?B?djJidXNjQkx6c3lhZHlvOVpFWFVVMU1WL2lYaHQwNGxOR2VuL1RSNmZZQjh2?=
 =?utf-8?Q?JypFztSS3OyWE1yLaI8i3FJQP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d718a016-c3ab-4b6c-5f0e-08dd4a98cef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 12:37:12.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6PpfhIb4CASkLlfaU8HEeOdTNjN+//a2EVomVH3ZRnxaObzgQl2FH8lgyqmMz/JoDR8wlkf/5Pcs1xpibzThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBbLi4uXQ0K
PiA+PiArc3RhdGljIGludCBtY2Vfbm90aWZ5X2lycSh2b2lkKQ0KPiA+DQo+ID4gV2h5IG1ha2Ug
bWNlX25vdGlmeV9pcnEoKSByZXR1cm4gYW4gaW50Pw0KPiANCj4gDQo+IFBmZi4uLiBiZWNhdXNl
IEkgYmFzZWQgbXkgcGF0Y2hlcyBvZmYgbWFzdGVyIGFuZCBub3QgdGlwLCB3aGljaCBoYXMgaXQg
YXMNCj4gYm9vbC4uLg0KDQpUaGUgcmV0dXJuIHR5cGUgb2YgdGhpcyBmdW5jdGlvbiBoYXMgYmVl
biAiYm9vbCIgc2luY2UgbWFpbmxpbmUgdjYuMTQtcmMxLg0KSXQncyBiZXR0ZXIgdG8gcmViYXNl
IHRoZSBwYXRjaCBvbiB0b3Agb2YgdGhlIG5ldyB2ZXJzaW9uLg0KDQotUWl1eHUNCg==

