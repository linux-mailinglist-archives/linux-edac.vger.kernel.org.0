Return-Path: <linux-edac+bounces-3111-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB6A39060
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 02:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFDE3B0A10
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89B77111;
	Tue, 18 Feb 2025 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMRN3sKm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6874C14;
	Tue, 18 Feb 2025 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842107; cv=fail; b=JK9wJcJzytaBMDqIiKnYPl13YbGy6bMG4FN0pK/5luOfRqce+BkK9HYpoFLiQx1F8blvigV6c8hof4vXoyJjWxnDTBYgcLVBrJ/tPofStBeUzf8LQsCgrYmjp3BGA9zlzNC2UbFxjp6TZ0L2Um1gBkMnyxaeT5f03y46fUpuzqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842107; c=relaxed/simple;
	bh=tBURBrRHEf9KGHz9omtoL8BUKkPeAs+kHWL+cK0OU0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=puhWS0CleYTRDlj1UrLZC1JtHEEp7ktLNUaUPu6biAD8tm5YOwWS95SoVB1Rdxq0dk8I9Pd0R7UgnPMVriQ8a6ACG7hGArA4lMmwNMt9HUkwTpU1cHfSmFmatbs9f4idp2JqVIyWcDmdvXlyTLRi/+sWkQq9Nt7HbT+DuVjfsf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMRN3sKm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739842105; x=1771378105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tBURBrRHEf9KGHz9omtoL8BUKkPeAs+kHWL+cK0OU0Q=;
  b=cMRN3sKmx9Gi0ARRuPa3Qj0cZAWnE1l/A8U2/e2xwBPjKtS1v+Te7hOY
   hcoZh8M4KzTzTjtp5xeJU4kuutgnrJqQq9SyZ6vIEfj0LjQRypfFGUHMk
   POHvRv27IMFvgbV0sQ/nDJSEGYnVfrooL2uPPItJo4y2HjA+QkRdaFX2q
   8cj5Q1HzHpH5SDZPTCtLoZ6EupS+BEHFuu8GyEgWd2zV3YLSwBkwosMuJ
   Teaig9Wxi7IcIrxtjiJ5tUHoKBYiQv4zrnukCA1NK0ohQc6sO8UkE1nP0
   SX0mJw1h6Z6d+JGNUAQTa6fbo9JbdGbLqjQslZTaoxbeDpq/841UQfqP3
   Q==;
X-CSE-ConnectionGUID: BAsT6MR4RSiHvNVjVXv9WQ==
X-CSE-MsgGUID: 856Avf8RRPykw1BcID0FCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58058192"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="58058192"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 17:28:24 -0800
X-CSE-ConnectionGUID: DZNn31p5RcKmo5rPRFORZg==
X-CSE-MsgGUID: fwfdDbbYSJuCr7croFLcWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="113993797"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 17:28:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 17:28:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 17:28:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 17:28:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx0bE0JOmCv06rLr/faEqDcYqKAYRKcjJdzhp07I9ky1XiyACrVe+/at+vNiW8yzD3YfTP8mK90JCjvFCFmiu3vHdQky30/nBcGqjyEmfMKm1RCSOkB7YK+5dU9KM8t1MwmSM/MDYJeama06lhBNJJqjqSw6yOwJsCMMNgG9DrddIDeOifsQFPJSTGhyEdUZ+XCUhROpu9QUrmW300PnVhgonjE//JvZfQABS3VodZZRsKaf5/fV5NMFn9HkrStQMMpDGh+i4G/UBxhLfvPjUliMCBwsg6ivm7R3urDW45x3gXVz3HMNgkIRXcDkKUMHRr/wQwDx5jG1oe0TIlNYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBURBrRHEf9KGHz9omtoL8BUKkPeAs+kHWL+cK0OU0Q=;
 b=EsAG1BchMceQMpys8nc9fax7FuWM2dkLj44UgqHt9stv5uxdOFU/r7M+9Rv6kZN3pi6yrh9C0ELypjF1BIfFumHR8JtSQK60X0l0Wx5tGAZtUFAA2tnA0yruQcvcZd9wPTemXOjUdV18dee7sq1Wk8SEQ5GmxkuiRk0dhJMLw0rY+ZC0vWnrAzj//wE4iaRRrSJkCbGxUyMLIOi4TIq64pte5GLS7SOMqDG7bD7aXZ9l13ex9Iw70RAtcgi+rPqO7ipx/FPfMxmAQGvclbVfbs7411Ko2r/LIejeieuF3MwMELoHR9XLfrDocshs8wUrqoDXEbfB8SVz04fkt0rczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 01:28:02 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 01:28:02 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 04/16] x86/mce/amd: Put list_head in threshold_bank
Thread-Topic: [PATCH v2 04/16] x86/mce/amd: Put list_head in threshold_bank
Thread-Index: AQHbfjenP23s1tpOEUOP5PPDFTNd87NMTApg
Date: Tue, 18 Feb 2025 01:28:02 +0000
Message-ID: <CY8PR11MB7134FEB75F14FF772827AE8C89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-4-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-4-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW4PR11MB6934:EE_
x-ms-office365-filtering-correlation-id: 2f90f3f1-6a00-426d-03fc-08dd4fbb7c64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RitKVnhtc3o3akU2SzJYOFJDQ1VNdDJTNGJXUFlPeERQYTJlaWcvSHl5NjR4?=
 =?utf-8?B?S0V2N3E2U1VNUGMyNWRhM3hGeGRSc3pDZTJ0N2o2RmpUWVNYOWE0NEd5SkJZ?=
 =?utf-8?B?czM4TnUxbGZ3a3M3cWFMbjBWdnVOMnpSOHVsODZEcTVyckhoamNCZHAxREFu?=
 =?utf-8?B?VXg2bmJPSzdZbWMwaTYyR1ZvUFpSeHowcXgwbTZBdkhrV0RqT05KNVlrRFJx?=
 =?utf-8?B?eFYvNDZhcC9tdldIcCtzQW9rdHZaTXNEcHR3YUZaSjlwb3ZpK0pLck9nYldT?=
 =?utf-8?B?aFhDOHBiUGFCS2ZSa0VSNTNCTXUvWXprSE9CTlNKNGIrV2REZHkxSzJ3bVlk?=
 =?utf-8?B?TFRVdTNWbExiTmtqQ1pIZEppdktBcUo2V3lEc1BBQ2d5V083KzlRRjg3WU84?=
 =?utf-8?B?R1ZtS2JQZzBzeitndVB4ejdZcElycHdlTURNNXdydXlYeFRaTjdhV3dPbTNv?=
 =?utf-8?B?ZXJpcC9kQ1M5eElWS0xIbENqZ1hrZWtuNjg1V0xleUhYZTFYYXo1aUxRWXdP?=
 =?utf-8?B?ci9iR1I2YnhxSEM0dENBcjJTNStUdlYxZWM1K0wwN2x0VkQ5VUhJY1NUWTF0?=
 =?utf-8?B?ZUFKeW1XV2hsUWZkTGpJdkxpVFVGay9nKytuQWY3ZmxoRE1lckxpN3RDQ3dt?=
 =?utf-8?B?UFlvTzM4STl3SkpSdG1zZGx5ZzJnRkF2MWYya1REMFNQcWFqcldZd0Q1TGdM?=
 =?utf-8?B?WWVaaGxmMkNSZndRWGNVYUcyL3F0dWtndklGQ21oK2U4MjlUcXovUWVuREJa?=
 =?utf-8?B?b2M3THBwUCt0WitLaDRJYTAyMDNSdlhabmU5VHlDd3VGVThvckJPMzFRUGxa?=
 =?utf-8?B?Z0Q2NjRlazZqcmtlWkl5TnZCWS9vUHFZQUpIVXNqbTNHWlhLdHA4WGxZZzdC?=
 =?utf-8?B?YXN6cCtiT3RWRmV6RzVLaGZZRkxLMEVHWFJxR0xNVXdHSGdNVFdnUkRtdGN6?=
 =?utf-8?B?R2N4YmVoeEhzSlRNRm90djhTdlhYZkcxRytEZzFid3Q5ZkJGQnlYS3hPMDR2?=
 =?utf-8?B?UTlrLzZDeXMzcW03dFpBaXk5cnF6ZHNrZWU4dEd3WTdxc3ZSUVEyZEZDMGNY?=
 =?utf-8?B?UXZ5SGNpUFVHc1o0dEJhNy9jVWw5VDMxUUxVbTlJTjdJclhQK0pMNUYrS2lR?=
 =?utf-8?B?V3hKa3ZjUXFwWXBRemZmTEx4K0UzVE5UOGVjM2FVb24wWmgzUFp5a0NmVksr?=
 =?utf-8?B?VUJIWTMremVpYk9NNVpIamNpejRKSDJRR1lGTWVqU1NiT0hYdVBIdjNSM1ht?=
 =?utf-8?B?RllKZmwxd2orcXUwK0Y2V3hHWm9oVkV0ZXZ3NG9ha0dhd3RwYXhDK0FXK2Fo?=
 =?utf-8?B?KzJ1THR5alVNKzdsMXFPRFlON2wyWmVIV0tlQncvblVFYlk2eHVkNzJGSEpy?=
 =?utf-8?B?UnZWNjgrSW8yNzlVQkxOQ08yMVdsRWhCdmFYamFpWVd3ZUgwOERrU2xVcTUy?=
 =?utf-8?B?cnVaTDVtUGV6Zm1qMitnR0lPampZYnl5YU9ubUttTXhlVGVMMTJJaG43eG1N?=
 =?utf-8?B?U2JjYjJwQ0RGRno3Y3lvR1hKOXdhUEJicTU0alBRMFNrSVhDdkN2dGFVeWF2?=
 =?utf-8?B?N3dqWDhROWZMNXZNMWZ5OTYyczNkYURTcTdYazJkZ0lJVG80UHk4YnJha292?=
 =?utf-8?B?Y1pUWkQyYjkrbkJZSDFabjBBZlFUbC93MmZVR2dzc2JjRloxeGVYWmtiNmRa?=
 =?utf-8?B?MDBLRXVoUEcza3QwNTJTajB1M1FrRjYyNExqTnptVzdISS90STdETjNqY1k5?=
 =?utf-8?B?bk9PNm1KakIxK3QvdzljTEdRdWZrVTZWdnZPUmd5b24zMEoxUnVqeUJObEh5?=
 =?utf-8?B?WDlTZnVLQk1mT2xLU3VJNjNsQ1JFMDZISHk3SUpsTE1DR2VhaVlpZ2dKc3BY?=
 =?utf-8?B?OGFQL2lndHpCekc3ZUhYNWJrYWo4aEhWWTQ2QTFaY0M0Tjg5UmZKQWdzYUcr?=
 =?utf-8?Q?Hr9gNHSc+dx+kOhhCYO8eLgh0VNfBRrk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K01zT0FUWE9WUjE2dmh0cTJRZHY4a1pTUkV6YldjZ21TcDhsMEVmQXczZUtH?=
 =?utf-8?B?MTlJRXVsbk85WENadVc2Y1B0endkOWxzT051TkxQWDBHMmlGYUMvNmIrMnFv?=
 =?utf-8?B?VnEyZXoxVVREYTNnNEZ4c1BYa0pXY2hQTHVDK002WEFuMno3Rm91bmNJbDZB?=
 =?utf-8?B?Q0h2V2FBZzl6dEdpVllXMmlkSXJBVkUvcjZRS3Q4QktYK2xPSzNMS1JVMzBn?=
 =?utf-8?B?QWNOalFZdFdPTW04YTVUbnhzSWRGekVWZXhaTGE0bFFqVDlhSGZra3llZjdJ?=
 =?utf-8?B?N09Lc2xDU1VtL3RWd3RRRUNOaE5iQ2xpSFhCb3YvUktyZ3JVSG9mRXRwTmo1?=
 =?utf-8?B?UG5xcU95RjdtT3h4Mm5Jc3lETFlzbnBQZkpnUHRySU9mUXdIVzlnK1YvajA5?=
 =?utf-8?B?TC9tRHR1aWhxeWJLdytCVkV1TU9wMUZTN2g0dHdLL0N2bE9ZcXFpRkxmVTlx?=
 =?utf-8?B?QzBSTGwxK0xUV3JuMWFHT0F6Y0tZSEhXdzY2S0VRenhRY1FvcHNuU21lbTJR?=
 =?utf-8?B?ZW1CbDI3VnNIUFVNTG9sbkIyR2FMc0Jra1pUMHl4Q2ZZZm1XOS9Na2dvR0FK?=
 =?utf-8?B?dUVOaE1xS2ZXMDdHL1B6VjI5eEJzUFRvTml3ZlpacG5jcjk4bFRCQUg4ekcw?=
 =?utf-8?B?eTJiSTR2MU14S1kwd0RHV0NWWkZYR3o4MVZreEZuL2VrdHY2SnBGcFBsUE1n?=
 =?utf-8?B?d0lqVWdwSXhoVGNoS0ovM2tuMC9ka2pSUmM3d2tweXpMVUk0ZWtUVjdSTzRo?=
 =?utf-8?B?d1lWWlVhMExEeWpRdXpjR0FHMWxCWTRYcnV0L3FOT1VKd3lsOWlwYkhSYXJZ?=
 =?utf-8?B?dkVlRUV5aUZZT21mbTF6Zk0xR3FtMURGZStKL1pwOTBCZExOWG9pL2paOGV5?=
 =?utf-8?B?bXl4R1VsSlMra2IyUnl1ZE5kTXJTR2N4NDBacCtpSEVLakxDamN4K0ZPeDFw?=
 =?utf-8?B?dlg1emt2eXp1ME9BUDZxMWdrYjgzUmdGWGZydy9YYmJ5TUxydG0wOW14VXpW?=
 =?utf-8?B?NU4rR2ZoblJtUGw4aWV3QUpkL2EzcTZ0bnJjVUF3aU1iajBkSWk2K3l3ZnVD?=
 =?utf-8?B?M00rb1lURG5XckhSbCtlUnZ3ZVYxcXhmczJ0cFJDYmgrNWlzeDNTcjl2d1kv?=
 =?utf-8?B?MklyRmhXTjZzQm9BamhwaGJZS3dFV3dybFkrdXBwYkk5TjhPSjhLUHVyVktS?=
 =?utf-8?B?V2pXYThReGRodld5RVBvWE53TkJzeUxYTjJvbTRVc2pvZVJibUJwdW1HNU9E?=
 =?utf-8?B?MzN5dytGaHVZM3FMd241YlFFOXNYMnhPQnlVNVlpVVJlK3lhdFhUSEpUVEQ0?=
 =?utf-8?B?VEdPL1MyQ28rd0hqaldBWWhDM0hwSDA2K0F4ZU5xc3E4eVdRZ1daYk1obGNh?=
 =?utf-8?B?ek5TTCtUeHZZNW5lMG95MnN0ekRGUjFUejEzdWU4SXFOakM0QytQcHFYNURZ?=
 =?utf-8?B?OG9GUmMveTlXenBNdHZRckRRdHk5QVRtc2hiT2ZUR0Urb1QvNGJMZk0wTWJj?=
 =?utf-8?B?ZjNBNW13K3ZYRUJ2OWIvdXBmby8yUlY0a3o5Um90aHVrZUhldFNESXpwcDdN?=
 =?utf-8?B?SXZpZlprY2NUSnBJRmx5LzhiRWFrb1VlRHhhYnZTNHdmYWJnTnVjMzc0SWtC?=
 =?utf-8?B?OS9GdUtiMDZManMwSCs1WWNaUVl4YWorNXJNWHhUTWxMT2c5Zm5DR292RElQ?=
 =?utf-8?B?bDdSbEFsYXB0NUlkVEVDNzFiSXF2Y01vZUlaV2kvaUExOE9tN0FIeCtBb1Uw?=
 =?utf-8?B?SUx6QnJ1YmcyZUFybjgzQi92eDRmZlkyUFNiUVFhQVdzR3ZMUVhUK2lFOXpM?=
 =?utf-8?B?L21SMkRJTEpzZDNyc1RleTlvZUtma2dDWEJGZHhoNWNPMWIvYzVLV1l5Nkh6?=
 =?utf-8?B?UFBTZHhPcHQzamxLU3BjSDVHUEo4REFycGpBN24wcGJQZ3dZWE00VWVobTZs?=
 =?utf-8?B?N2xiYXlrdnEyVnlkVldSSlNHVEphTWlmcis0S3oxOEJLejA3emxNZzRwaFBi?=
 =?utf-8?B?VU1KdTVDQkVBZE9Zdi9CWFNBTUVrL1hZZ1VxbzhiY2JWdWRjNDBZSGdvM1U0?=
 =?utf-8?B?ZklscXBNbUo5WDhSK3lSK2E2UHlvTUIyVHVVbkRmNlVtTGp3M05Ha2srUmxL?=
 =?utf-8?Q?b3/Hf08gccuT2pPRWS07cmRM7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90f3f1-6a00-426d-03fc-08dd4fbb7c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 01:28:02.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oRVnKX704cptOGcmjU8Gg3m9QtlPTvUCqzg0YJerWqcgvHRPe+VcBVZSNLyCW74efrMB42+riPxuSkx2DzlhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwNC8xNl0geDg2L21jZS9hbWQ6IFB1dCBs
aXN0X2hlYWQgaW4gdGhyZXNob2xkX2JhbmsNCj4gDQo+IFRoZSB0aHJlc2hvbGRfYmFuayBzdHJ1
Y3R1cmUgaXMgYSBjb250YWluZXIgZm9yIG9uZSBvciBtb3JlIHRocmVzaG9sZF9ibG9jaw0KPiBz
dHJ1Y3R1cmVzLiBDdXJyZW50bHksIHRoZSBjb250YWluZXIgaGFzIGEgc2luZ2xlIHBvaW50ZXIg
dG8gdGhlICdmaXJzdCcNCj4gdGhyZXNob2xkX2Jsb2NrIHN0cnVjdHVyZSB3aGljaCB0aGVuIGhh
cyBhIGxpbmtlZCBsaXN0IG9mIHRoZSByZW1haW5pbmcNCj4gdGhyZXNob2xkX2Jsb2NrIHN0cnVj
dHVyZXMuDQo+IA0KPiBUaGlzIHJlc3VsdHMgaW4gYW4gZXh0cmEgbGV2ZWwgb2YgaW5kaXJlY3Rp
b24gd2hlcmUgdGhlICdmaXJzdCcgYmxvY2sgaXMgY2hlY2tlZA0KPiBiZWZvcmUgaXRlcmF0aW5n
IG92ZXIgdGhlIHJlbWFpbmluZyBibG9ja3MuDQo+IA0KPiBSZW1vdmUgdGhlIGluZGlyZWN0aW9u
IGJ5IGluY2x1ZGluZyB0aGUgaGVhZCBvZiB0aGUgYmxvY2sgbGlzdCBpbiB0aGUNCj4gdGhyZXNo
b2xkX2Jhbmsgc3RydWN0dXJlIHdoaWNoIGFscmVhZHkgYWN0cyBhcyBhIGNvbnRhaW5lciBmb3Ig
YWxsIHRoZSBiYW5rJ3MNCj4gdGhyZXNob2xkaW5nIGJsb2Nrcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCg0KTmljZSBjbGVhbnVw
Lg0KDQogICAgUmV2aWV3ZWQtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0K
DQo=

