Return-Path: <linux-edac+bounces-1800-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5622B96A9A8
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 23:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790831C20E23
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3C1DA30B;
	Tue,  3 Sep 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhzznXI5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374E1F947;
	Tue,  3 Sep 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396887; cv=fail; b=ZlD3CJTWezE4SBxex/Ohvj3KPAmCQ+RXjs/0dtE8CYCWacU3SC8X/AAQ4WYgZRn5g1wosFkaQNPfFKINDpppzbRWGkm+A1N5yAPf5uxyXirq8L9YntTsiaLn4saP2nJhU82YRlYxEnILD+MCb8E/zrf/d9fIcEdlvPq9upJWCWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396887; c=relaxed/simple;
	bh=m00b8Qb2b1DN2fSmKZYx3JqEntxqvSO0snCjOkSbySE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c0j8yJ8o1se33ZP/jV1nXBFMvsNIVKM5I0Zt8WlUSKln63wC5O274dfP+kgJdiXLiWZSOCuxVpRoH9i73NHHP6+iUs/5hDqMO1P/l38+xW7CHTh+Plre7n0VVl6bsX8coKJB0IkO1LmANNwQD+3idbvE2NoE8BPuAY+WF1W4xjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhzznXI5; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725396885; x=1756932885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m00b8Qb2b1DN2fSmKZYx3JqEntxqvSO0snCjOkSbySE=;
  b=FhzznXI51vhHvgqzfhAWV+QE+yRu3E2L4jfpW3hh6O1jcBy/PdOxWKCc
   1RJHLFz0i4pqDTPhJL/ljAtsrXopZgn6lQ8r0pj4y6r8C57tsfRWwMUVm
   9Bid6wssc2HwBYAyRQnprUI2o0dFMVl1hd9CEUe/EbvBAK5N/18b+Re20
   kBAMnT2V3MwYv4G11XMoHuEr4FYgrt/9lji2b9fTOfENZygET6nBH7IIh
   QBubGae4Jzw5n3a40guVUTYgzZts7hUxT63LAIoRXE0Qgjule0/t0If3Z
   ZUKnFoaGo2YVcnB1vSemGIZIaNwPJBhtea3NZux4qree9BO+qTjfgVpal
   g==;
X-CSE-ConnectionGUID: lLVbDOsASAKyQY/ddScwYg==
X-CSE-MsgGUID: 3zWMVF51QHKrxbD+rAdsaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23888010"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23888010"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:54:45 -0700
X-CSE-ConnectionGUID: 7VXYup1PSyaWidu1hxqGrA==
X-CSE-MsgGUID: bXfsBh+EQi6Df7XXDI4Wfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69853068"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 13:54:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 13:54:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 13:54:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 13:54:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4J8tNEmkT2GzB9cjRyBtXMiOYwoAjIzJX7Xgmywfq2Oz5gsDVb4s5b4TrPCRV3kpN1pvJniK9Wa/kpdIoruWIpX6jWJ8uTCquPheMF4IpfUdKA0T3lhZ0NjG6FfpIH/6kR2HubdO9RQP+xN7peytDQRxOg/vsRg17olsleKO+5HxR66SylT0lb0wrCsHGfD8cVg0EZ5VqBQCnCG0KLCEFo2bhZVgQAn6cpV7qgzzENVi6zz4k9/H+2gHtsfgNlbWS2aHmj5liiEXhtjdM2icAuEFewotDK6ZlX0EsVskm/UoyJg4BJbIV0Qq5TfCFlIvGm+Jo0CyrHW2h6S+UJgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m00b8Qb2b1DN2fSmKZYx3JqEntxqvSO0snCjOkSbySE=;
 b=XBA2i/bT2e9xw0pZJLD4yRgpyl9alMl6taCD2jRa+peBX2eUgVrZygpGoA2dztSRIx/F3NDxs4GrQKiZDTjLvD2Jh5lKkEscm/R4d/RWKeT9GUozBo7yZExVrlg1Y63bHvsmyHglNOCghtIBt8tExBcQ+tHIe8qsDTmX92xkos1eOllX0cqOeMJDsYrAeqTXEGQ4A7jPykpZdJ1I0LAt8wtpg3YMuUNyT8jhYJ9TP/gO5J6OxoEuOV0Nt8My6EmB1mijIvOOHHcYyPxOLuTe7Y2kV8HEvRMNzcSQ/oIbHUhILGWEyDHZVOD76kQpMryMMnbdBQppDrOARNndWodsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 20:54:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 20:54:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"Zhang, Rui" <rui.zhang@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/sb_edac: Fix the compile warning of large frame
 size
Thread-Topic: [PATCH 1/1] EDAC/sb_edac: Fix the compile warning of large frame
 size
Thread-Index: AQHa+g5kxR5j4OA8SUqTGUESKGvrGrJGkh1w
Date: Tue, 3 Sep 2024 20:54:36 +0000
Message-ID: <SJ1PR11MB60838520BD3696B2A6C1792DFC932@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240829120903.84152-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20240829120903.84152-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4924:EE_
x-ms-office365-filtering-correlation-id: 653a217a-841f-4327-7803-08dccc5a9f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aWpzOTNRZ3JLRExmSyt6b0Q3SXdsTWdnK21FbjJmNjQrOXhYb1Jtd21zdmlM?=
 =?utf-8?B?dm1QcXVEa0xLWmxWYmlVVlVSRmVZWWpibGFsMWY0WVozNGo1R2N4N3BVeGFl?=
 =?utf-8?B?L1pwNjBYVDIyZUZlTHh6Y2lvVDIya0J0RUFJTlkyNGl0OWZOTndaUnJ3UmtS?=
 =?utf-8?B?VGtlRTJDeE9FV1F1cm4xTXl1S2NmemQ2eFJpMlgwbHBGOWJyeU0zSzEyc044?=
 =?utf-8?B?UUk1QlFRVEtLSVBIaVRXVjM5WllCd1EwZ0FuNFdyK2lFTmFKa3JLendyVXhz?=
 =?utf-8?B?N2tpNHBIa0s4aS9oQ2FMWGhxVGs4OXdaVHJ2Z3M5L0NObUlpVVJROUVZRWd5?=
 =?utf-8?B?WmphL0RSWEJFbURuc0lFZ0hEVWhldlp5OHR6eDBlREo5bk04RmRPYXFoMlJY?=
 =?utf-8?B?UmdxRW4zc1dxNnNybnRON01QVTdqOGt2ZHBBZHZBeGdXaHpRVlBDaGhiNnNr?=
 =?utf-8?B?bXJHV3p3VGt1THFNYXlwWjQ4amNldHlmZkQ0eVNwV1V1dVdscWtrZWQ3UkV5?=
 =?utf-8?B?QlJkbU8wUk9ZeGpodWRpdkFEWjZUeUVFamFVTjZOMWhFbXhqOUJsSWIrY3FJ?=
 =?utf-8?B?NGY0WXR3ZHR0eC9sTlJHcm9XY2xXbkNDM3lGYUMvSWZOOUVVeDREWDJQaUYx?=
 =?utf-8?B?aHRJSE1kUC9KcU1ZQUZWWml6SHZwd1hZNHpnb1EvUFV5b1J6NGp6TDdZa3Jh?=
 =?utf-8?B?a3RQTG04dnZ5bU80cU5rT2dKQTJvQ2hsRmM5UkRUU01zaUhZWU1YUjh5MjRP?=
 =?utf-8?B?YXB5ZEU5anRJaWpXS0E3UFhScUc2QjBTK01tSzl2MlFOQk1zVnNFK1lldU0w?=
 =?utf-8?B?S0hwVUlsdUlqc3c4UW4wZWJTOTYzVkJKeGduUXRBRDUya1VwS1JPMjM3MXU4?=
 =?utf-8?B?RXBpRXNmTUdQak9vejZEZXcxYXVYNFhIVzNnWmRqQXV6RHJZd1hDOVFKdzhG?=
 =?utf-8?B?allzdGlWTURheTBnejFiSjNIK0prWTUwRWxIUGRlaEgzR2xzWEdXWG5ESjli?=
 =?utf-8?B?aFJleG9SZkNyMFdHbnRpMUVyU3VlMDc3SnJwWSs0NktsMGhJZWlyQi9ENWRN?=
 =?utf-8?B?SW5BUXVmQSt3bSthRG1HYkV4cEZ6VnFxZ3JuRVZjbWtER2tkRm9ENnVDUXoz?=
 =?utf-8?B?Ky82TCt5RmpabXN6ZmtUdmg2LytvS3llQnhZWUZuVGJmZE8xN1JNRFA5Vm1q?=
 =?utf-8?B?Uk9USERhQmRQaE5SV0tISlRac21EVjNkNy91Tmx6OGRVY2Uvci9XZWJKNWdl?=
 =?utf-8?B?aG9KTWxLa2pSWVlBZ0NtcHRmalM5K3dlNEh2MEVxbHJNTytOQVhoQVduT3lj?=
 =?utf-8?B?Q1NNZWxoV0VVbVBTQXFLamQ5VEUzMCt2WDh1VHhLL1o3amxMTExQbENuM2h0?=
 =?utf-8?B?OCs3OWZzbGV3WHlnbFZLa0twUUZFQVhDc3UrTENrUVFWZXh3MG9RLzRRUEpK?=
 =?utf-8?B?UHhCd2Z2SlJtSzBGWTV0OFY4ZWRCLy9pOGlyVlZEa2RVcW9WV3ZBZTZ4dThO?=
 =?utf-8?B?cEtkQit5c1JZa1RKc3hydVk4a016c1o0Z1g4Z2txVS9LUG1rVVNWOU03cURq?=
 =?utf-8?B?R2FZT204aTBIaGd5NHIyOFF6MU1DTGlDekFXY2R4citZWDI5TmUwSEg5N3N1?=
 =?utf-8?B?WVYvMGVxNE9OKzlldTJCUlA1dGhETktnb0xSdE9tNmYxZ0pTUkQ5Y0ZVUTlr?=
 =?utf-8?B?aktUZDZkWVZkWHU1VjJvRmxwSnZ3QXBxWjQwcCtZQnV2Y3hmY3hKMXdwaUxw?=
 =?utf-8?B?Z1dEOVdZdVZYdDhZY2s3TTdENXpVdWMxd0JtSklPM1Rmb3BFdXpLek9JM0xy?=
 =?utf-8?B?Z3dEZUp1YnhQejFtSFg3Sk5IWTdiaXo1TW55aG9oTHR6WXZ3R3B2dktMcGVh?=
 =?utf-8?B?VHhsY2JmcGYyUXhJSW1pcnlFVzkvQU8yRFJtYXVlVG9Gdnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkI3NU1Uc2Rucll0bmgvWC9MZ3p2TXl3RzZqOE1TL2hBaVZzdmM3Qmo2MGF4?=
 =?utf-8?B?NW9QMUpKbUtVN0ZVaHpTREo0OEdrTUxmQ0IwRUpWNUs3YTA1R0VXS01KYnkx?=
 =?utf-8?B?YzJqOVZYV3EyUWwvY2g3TlR2YmtVbHZjSzh4S1Y2cDZ3V1RZdUNLQlc1S2U2?=
 =?utf-8?B?WEZ3eWFXQm9pcnV6N3BmSWNvUGVnOHVqU1ByWnorWkU2dGRRRXYwT29hTFlX?=
 =?utf-8?B?djU1T3lYanR2U2NpQ2hKKzBqMU5YOWhlMmpjbW1lL3hiVDYvdDd3MXRhMDVo?=
 =?utf-8?B?aitPTkx5RFRSQkw3eTlpSlZzSE1yenFoSUQyVHplMSt2S2Y2b1JMd3I3eXdZ?=
 =?utf-8?B?RU5ESmY5WC9NQktqcHZ2WFE2aWJJUE5KUE5pQ2JvYmhEVlVVRUljZnRWZGxF?=
 =?utf-8?B?TnhsZzRqSERGdmVnbityYjZLQjVTaWRMUXNBZ2NTSkhQdkxhY0o5dE9OWlV4?=
 =?utf-8?B?eXhjVElaWllJemtwRUZLNWh1K1Rodjc2L0p5VlYzZ3kyaUMrUkl5cHFscnI1?=
 =?utf-8?B?ZmtCOGh2ZGFHUnFaQmVBTCs0c2ZwdnhUWUdudHhJY2w3dFQ5MWhMei9Eb2p0?=
 =?utf-8?B?eFNSQ3J3UzhtdjJ5Y0ZOQ3Ywc1NGZGd4aTFQTTJwSmc2enpQNUlueU4zTFA3?=
 =?utf-8?B?d0hDbGh4R3kzVTRPbnVnY2tQTHJwcWF0RkVZRXNBUTVsY1VRYnhPWG5zcGJn?=
 =?utf-8?B?TkUxVUlpSFQ1bnlNWTVZZ2lhdmlqdFdKSUd0UGtBUGQvcXREUzJhVGZvSkVt?=
 =?utf-8?B?dWV1enY5ckVSaEJHSVlLa05XL25wdXluN3Y3TTdxd0hhS1Z4ZnFNZHZ6WUhB?=
 =?utf-8?B?T29yaEVsMEZ5VmxNeFFmZlVrZFpOblZuMjZKMmpzTEYya09oa2pMV3dtZ2pK?=
 =?utf-8?B?SU00WEZBUmQyQUtkb2g3SGZMNm5KUzJ5SENsVXpyMVAxTEp0UkVESWJTODky?=
 =?utf-8?B?QVZKcXd1U0VVK0NQZEFWWDJxYmFNMHIzdkNDbEFlcGJzejhRUWwxVE43T0Fj?=
 =?utf-8?B?Nm43L3hsa0FLQVE4RWI0Y0xycnR4dDJlU0JCdWI5YlRtWUpCRjBPTTZzaGJF?=
 =?utf-8?B?bko4VlFoUFpHTWhVRTZMZHFaaFZPK2xabkxnSmI5UDJHbEx1aDdzR3phWENI?=
 =?utf-8?B?dGxkN2Z1WGVBRWgyR3Ezcm9maWVCR0dKUmZRQjdtRUFHM2hTbkdTaXdwanV0?=
 =?utf-8?B?UFRMS1dvVTU0UzE5aTM2WkVLL2ZkUUhuU3F3MEs5Z1I1cEV1UEhZK2JXT2U1?=
 =?utf-8?B?bTZxZUFLL1pxSVhoeEVhYyt2dUtEU1UzZHlSUjdJV0VDWW5CQ0cwZW91MnRt?=
 =?utf-8?B?WUo3UGFjNFpXZGlBSmRxcHA0eXVNcE05dGNpdXFNczJMNG92RlBPaGV1aXYx?=
 =?utf-8?B?MFBtS0tTcFFIRGQrYThVaVkyV3loTlBHeGU5aVhPSDZaV1BQeXRBWkJQcnYz?=
 =?utf-8?B?RjhpSnlZYjFjY2FpU2RCS2dub2RwY3hTV1FPWE55c2NwOERianhnZHRyait3?=
 =?utf-8?B?U045ZDFNNEsycXZiay9GekdyVEJzWm9xTlZaY04vNG5lbTlZTzlmMVk4cllN?=
 =?utf-8?B?dHFXcjltTDRtMVZuMGE0UXBOUk0xZlhqZXE2OHNOTyt2MzZDVk1iMVI3MDRF?=
 =?utf-8?B?KzdURE8vTUcyY3YwYXlGQ0hkcXprS3R0Rm4yTmVnU0Vvb2ZEVUdrUHV0THh3?=
 =?utf-8?B?ZmkyTjlOWnQxWThJVVl1NXhGYlhwQ1lvRDRkUm54SXlHQmZiakM0aFY0elFk?=
 =?utf-8?B?WDVZQnUwL2hLdjJDR25HVW55dEcxQmFZWHphaXpIYXMzNXBhMUR1dDBpNXNM?=
 =?utf-8?B?aVdTd3NaajFHRC91WUdsdUw4QUNOY0c3OWJEUnAwZlNVUVUzWUNCellUcEJ5?=
 =?utf-8?B?VkdQbnhTT3BlU0VHblZvT3VLc0JtVVJRTjZ5enkvUVp5NjlPdTl0Q04xd3da?=
 =?utf-8?B?VndiN1dGV2thcmFQSEVvUWR2bmxhMVRMODFVdnFPMnJyLzEwTmdWUDM0MUlH?=
 =?utf-8?B?VXRxYXRLV003OTNlNmdYamFPZ2xsV3VKeFpNUFFFSEVnekt2d1JPM2lVNlV1?=
 =?utf-8?B?dWpqbG5pOXpORTFhUVc5ektOOHkrRzhxSzV4RnUzanJmaG9HcDFNYXhRMTRX?=
 =?utf-8?Q?uPsiPC/xm9jqNuYC6AxzHNwfV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 653a217a-841f-4327-7803-08dccc5a9f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 20:54:37.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5HjYeiudqf1Q8BeCHae1WWuu7eHPV2eDbVwpyXqDojvDibWHOquOuNty4Jy98XDKtfZ04VMVqp/aKDj+LhDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com

PiBDb21waWxpbmcgc2JfZWRhYyBkcml2ZXIgd2l0aCBHQ0MgMTEuNC4wIGFuZCB0aGUgVz0xIG9w
dGlvbiByZXBvcnRlZA0KPiB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+DQo+ICAgZHJpdmVycy9l
ZGFjL3NiX2VkYWMuYzogSW4gZnVuY3Rpb24g4oCYc2JyaWRnZV9tY2Vfb3V0cHV0X2Vycm9y4oCZ
Og0KPiAgIGRyaXZlcnMvZWRhYy9zYl9lZGFjLmM6MzI0OToxOiB3YXJuaW5nOiB0aGUgZnJhbWUg
c2l6ZSBvZiAxMDMyIGJ5dGVzIGlzIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgWy1XZnJhbWUtbGFy
Z2VyLXRoYW49XQ0KPg0KPiBBcyB0aGVyZSBpcyBubyBjb25jdXJyZW50IGludm9jYXRpb24gb2Yg
c2JyaWRnZV9tY2Vfb3V0cHV0X2Vycm9yKCksDQo+IGZpeCB0aGlzIHdhcm5pbmcgYnkgbW92aW5n
IHRoZSBsYXJnZS1zaXplIHZhcmlhYmxlcyAnbXNnJyBhbmQgJ21zZ19mdWxsJw0KPiBmcm9tIHRo
ZSBzdGFjayB0byB0aGUgcHJlLWFsbG9jYXRlZCBkYXRhIHNlZ21lbnQuDQo+DQo+IFJlcG9ydGVk
LWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+IFRlc3RlZC1ieTogWmhhbmcg
UnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBRaXV4dSBaaHVvIDxx
aXV4dS56aHVvQGludGVsLmNvbT4NCg0KUWl1eHUsDQoNCkFwcGxpZWQgdGhpcyBhbmQgdGhyZWUg
b3RoZXIgRURBQyBkcml2ZXIgcGF0Y2hlcyBwb3N0ZWQgd2hpbGUgSSB3YXMgYXdheQ0KdG8gdGhl
IFJBUyBlZGFjLWRyaXZlcnMgYnJhbmNoIGFuZCBtZXJnZWQgdGhhdCBpbnRvIGVkYWMtZm9yLW5l
eHQNCg0KVGhhbmtzDQoNCi1Ub255DQo=

