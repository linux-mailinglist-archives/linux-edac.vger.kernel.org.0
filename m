Return-Path: <linux-edac+bounces-3582-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F022A92FCB
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 04:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C93462976
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 02:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB832676CE;
	Fri, 18 Apr 2025 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcQEm9PB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43E263C69;
	Fri, 18 Apr 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942447; cv=fail; b=qzCqB6b4SAKcNZQ6y96OjdtDwjV0dew+uzQ4bXiFo3le3of3pdWPLgZina6gqW2ZQa/WlbwoD2n2CdMkrFZC3gbaaWht/O/duEnOmjT2otCA7TObH6mhs01voWnhRPSrfgDRtOdiDjVax39Api4YIy91H8xX4S5mV6TeGzg0fsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942447; c=relaxed/simple;
	bh=dz4kXcitHJ91QAqWO1skhxKgycS3n3MJ7kgr6WJqEXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsSxXYQputTPSkaCX2EwRqmdhohPUXKtlLk06Og4LHEuCqyZLZTzpVHRK4OYyCzjfP7g+2dTA5cfdzh4NEXRrb9Vf2fvJEMqN9noK8xR6tqMDwPOhKPaB3Ww57ok2epO4jrWiqfpSY8GB4XAnKncsjDwEwL7fZW8MJvKJMiFnEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcQEm9PB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744942446; x=1776478446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dz4kXcitHJ91QAqWO1skhxKgycS3n3MJ7kgr6WJqEXg=;
  b=LcQEm9PBEC6wRYWCDzmrCE8fgMQxZEacZoLePgvXJWzZCQwmWweYqO9l
   svwgjmvbqMms/Zlzc2qZMXQYPF4ITTAab47Dl37Pu5Ot3/OW3oGo7Fy2S
   ZCxIvRADag/LgE3VMuCzHAFL0XfjY1tSmlmyituOu6s/Xh1E94jECGBcO
   4kS68mDwZWVcpd+QVSPYuEaNk51m0GQylN39Jr5+SpPRS0qWN1rU1lFnt
   ckO/tlr61Lu9zrTamWhnQW3hPOPRzS0Fi1lLVHw5/nx+eS8xmbWxv+2al
   S8wt7pBQdjW6JBsOks/+2YX92GykyQVHscZDCQFtXP+S6/139zE1xCEV3
   Q==;
X-CSE-ConnectionGUID: sRbmSZJ1STaereR7IjX0FA==
X-CSE-MsgGUID: k1fkYABORkORDgtrnP8/6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46574618"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="46574618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 19:13:42 -0700
X-CSE-ConnectionGUID: 29IcCm78QrOH2ztMm02V2A==
X-CSE-MsgGUID: BkRNMO0uSw+Yxxl1vkwVBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="130754829"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 19:13:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 19:13:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 19:13:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 19:13:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZibZWjJQJUGRkKUk+PzQEpC2feSWfwxLchkzuT3SkMd0fbdza2/Z3jHlcSqjVd8/6rb9l2RIo6TqhmfA6Jofx5lBPJmeeceYVS5ZAoftzPFPoj0w0LExy+7CViI8YX7SV6rq/xnj71LQjhk7GsSZT5d9nTIp7/20lm9OFkxUcaF3HRovlEcNtyckNhqBIMcNQuAhzmw6671puRIvQY+bwuUNO0yY1StJhBTfObZ9evVLDqhDBWx5oXgq7bptMsiia+vYW58MSPleKU5vtixJDv7f3ZVhVVbgyhUYjmz8thYCe3Wia53Ufj0C9ulEK8J1SjWdnn6nfqs5ANrgely6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz4kXcitHJ91QAqWO1skhxKgycS3n3MJ7kgr6WJqEXg=;
 b=nGRDqi9wRa22i1TFqaNntyk+1U44onS6ETKdYxxPm2izYI/uQ08SRRcIoMeXWy9q0IJSu8hNWpI0/Hnbkmj3/TwNqt69V7iB/i2nRtd1ah7B7qIp5AqVRXygzHhSLkfbVWAteiSWiiLukqhYGfNENdSpq9eKPtEst01gGE3IEbjth2oEuPK283Eh1jdmUb1Yo+C3s11ECmul1qgKf2C/02cAdBOw009jffJD7YMOWmeko3u4MzCSM7hyx1e3L5xnqr1awYrPUXlp3B04dIU8Qhz+nLOTfRLGhCjTleDyTGIFc0x64n3xZtOZfooq1+DWthawPBN3rLTR2PJ2vt/KyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Fri, 18 Apr
 2025 02:13:10 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8655.021; Fri, 18 Apr 2025
 02:13:10 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Xu, Feng F" <feng.f.xu@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>, "Fan,
 Shawn" <shawn.fan@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Topic: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Index: AQHbr6q/0ZTCFWELlku9ccGPSGY3jrOoIYaAgAB/tXA=
Date: Fri, 18 Apr 2025 02:13:10 +0000
Message-ID: <CY8PR11MB71349F22C613DE57758481EE89BF2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
 <20250417150724.1170168-7-qiuxu.zhuo@intel.com>
 <aAE-F4nGjuKX-m3e@agluck-desk3>
In-Reply-To: <aAE-F4nGjuKX-m3e@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH0PR11MB8085:EE_
x-ms-office365-filtering-correlation-id: bfa1becd-e130-4880-0cfc-08dd7e1e90f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEN4dGN4QXI5dURBQ1daL1Z5VmQwV284V3E4bk82aFU5Z3ZDY3dFOHFpVStm?=
 =?utf-8?B?Rm1jUDRqQk9Sa2JGNE5uVmJRdVhKYmxTYWN4UmdLL2pNb090T3VQZ3ZPTExt?=
 =?utf-8?B?K3lLSDhtUEtZbmFaRmlIYjEzODkxTC9rL2hDVDdIblNndWZ6RWFQQ1cxWFQ5?=
 =?utf-8?B?YlM4RW05c0lHcHcwNndaaVg2NlA3N0JoSDFSOWVCTXlIQVVqdzcvSUo5bi9J?=
 =?utf-8?B?WlVoUU00V21OU2Y1alVVL2V4V2sxWXpTdEViN24rM21JTVIyQm5YdEZWYzUv?=
 =?utf-8?B?Z29kaEx3M2VxMW80R29yWnZpZHJtaERieU1la2l1M1ZrYXJNU1dMbFVycVhy?=
 =?utf-8?B?MmNDeTR4QVc5Ykp5YXdDNWp5cEh2aDlrM3VpZCsvL2ZmamNGTFZ3dzlwQ3Zm?=
 =?utf-8?B?TmtRQ3hzR0JWcHcvMTdJSlRzSkZRKzNLNHY5cVl0U1NIbm5zdExuYW5razkr?=
 =?utf-8?B?by9KOU1RdU5jajlpbThxcVI0bEpIUGVlQjFRSnVKQ1ZUdloySHpzYzY4M0NO?=
 =?utf-8?B?aTBPN0Z5c0p4UGQwdDdWS2drY213aU9CcFRPZHl0MWFGWEgrZzFLZUJxVVMr?=
 =?utf-8?B?Sk9JUlJ3NUxOV0J6U1hzdUtGQURObUZ1M0F2ekh6bG1wLzFwaDc2RmdCTmo3?=
 =?utf-8?B?YWxBbnV4K0hlTkdQU3ZheW8vSDlYWUZvd1N3Z2NtdUtaTlJHQ2I0SUc0NDlJ?=
 =?utf-8?B?cXBhaWlXTHdsUlFYTUovRUJTUWpJenRZKzYyZEFwcjl2dzR4bXQwZ01GWDRt?=
 =?utf-8?B?cW1hd0g0eWJhNEk4Ym9yeGxhSUlmZC96THFYbWRCa1lHTGJhTXdSUXRvYUMw?=
 =?utf-8?B?MU1QMitQczV0YUpjRE0zdHRpR2lmUTl6dXgycVluZGVPczJ3OGhiUlExdENy?=
 =?utf-8?B?YXNxemhORHRlNUFrbFJSUzRUTjZDVHU5aUM1emZtRFpaRElVZ3gvWWlYZlpu?=
 =?utf-8?B?aWM3UDBXNnNCQmVrNmlMRktNdG96UE1IRFU2VHR6RFMzL3RlQnU2NDQ1eTAr?=
 =?utf-8?B?VWtlRTlucXJodGUwRmF3eFQzUDJMVG9CekU5SWk1NXZIMkVaR0NqNmtyRkxa?=
 =?utf-8?B?a0V0VVFwRlBRbGVKeVJmQ000cFFQYXZMV3FCZ09KR1hzcnhtZ3hKaWZOQ3Ri?=
 =?utf-8?B?WElEcG1FSjh6OEowTVpIcytyTEJkcGxidk5FdXR3UUpRT3hJeFlrMUtDbVQ1?=
 =?utf-8?B?N2l5endONDh3eThyUWM1blN5NGZBSWlrSVJvcXlDMVBPd2Mxc09TVnc2Mkxy?=
 =?utf-8?B?dGF1NjhkcXFvMFNXUDFKd1BOZC80TWE2d0U0RFRibkJtMnlaWE9pS0hpSDkw?=
 =?utf-8?B?aEU1ckRKVlZQWGttbmdWQzdOZHp3UE8wdXFiMUcxKzJXQURpeTBOTVZnanNz?=
 =?utf-8?B?MGZMRjEyZ0crcVNlaVdDcGQ4UjdPVXUrTDFOZHVVTnZSdXZhUUxhMGtXUnUy?=
 =?utf-8?B?ZmpudVVYWDdBc093VG1LY1NjWVF6NnU2M0JwRFptbE1TT2JwR1BLb2ErTHoz?=
 =?utf-8?B?Q3l1L0VFYm44Vk55alR0bEdLR0htQ1d2ZmE3NVlxNnIwak9IQUQ3K0ZyRmNB?=
 =?utf-8?B?MGx3Q0hQWHVBcm5rcHcrQXZZb1FjNnhORFF0Y0FXTkpOZXNTazdLdnNqQ1B4?=
 =?utf-8?B?OXRnOEErL1NxcmpVYTd1NytNYmR3QUtva3VuL2dQUGo4SWUxWVlOdlpiOC9L?=
 =?utf-8?B?QUZRVEo0NkpGNzU4WTZOWGl2MldUTGRyR1B0V3U0MEVTc2dvT2RpMHN6ME8w?=
 =?utf-8?B?enhUejRxUllheHFXY0ZMMitMM09IZ0ZHZExuQUlTVFpSYWhHMWlPMTFvQ084?=
 =?utf-8?B?Mzk4RmZNYmhlbjNnUmxkUDZESHFCR2NZU2ZEQzJucytDalJsMnZQV2FaWVVV?=
 =?utf-8?B?ZWZadnkxaGhRcGIyOGxad3IrY2szOGtPSlRtVnJlTi9zWjRWSUdBa0VCUDNV?=
 =?utf-8?Q?A3HEvnNmVLs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlBBdUh5VkRWSndVSXZ3Q2t4VHNhanFtRkpiUHN1VHNsN3ZNR0FBZ3lwOEZv?=
 =?utf-8?B?Z3grMVlYZFl0UEJXVU5zMWcyK25UZHZwU0oxb1IxSy93WjdjZ0ZYYTF6aVdp?=
 =?utf-8?B?UjFSeG0yZGMxNDdmRjFQMEtaTUJMTkhZMWRpTlVPSlJaM0NPckQ3MWtiTWFY?=
 =?utf-8?B?bzVNSC9lVEQ3YXZHcGdHNVBlVXhOUWpaTUp5dEdSUm12K2xQMVRKeUh1MjA1?=
 =?utf-8?B?QU1IaTZpOHBEUThWWnUvQ2RZMjJZWlBzQWRhRHNBdlpRSHVQbUJUL3h1QVJ0?=
 =?utf-8?B?QjRvb2NYMkpPdjRBTDZxamdaZnMrR1ZYMnR1T0tPL0wrV09hSThjMkJNSS9Z?=
 =?utf-8?B?WU5EZTVtOHpEbnZlMHZpbHR4Z1V0Q0wxWU9MSlJOYW1tNHhZWWMxNmpmd0Jw?=
 =?utf-8?B?a0VydTF2WWgyZExLWWI4VVE4Z2ZQVjM2YUxpTTJvU3BncUdwV1NselEwSUZr?=
 =?utf-8?B?RE1TaXA1ck1rNVBFeFJ0N2s5TXkxcURWWkdobWhpaGlYT20xU0psdTFqU0F0?=
 =?utf-8?B?UkhNRTRLcHNSOXR5aWxjUkhCRS9MVzlHeDhoN0xzeE9zTEZ5dUxvamNtM0ZO?=
 =?utf-8?B?Q29PbmVjb2hDeE9SVWExZFd0b25ldGNyd1R6MktNbHY1UVJqRHpvRkdkcmtk?=
 =?utf-8?B?M3drR01Icm1EVllIT3VibzVlT1ZBM3czYjVrSnA1dzgzbTJ1djZpZ1NuU1lu?=
 =?utf-8?B?SnFBV09LM2sxVGhEeEJXVjNLS2Jhc1lzdzhqNmYyRDE4ZzZEMnRLdzBTcDRW?=
 =?utf-8?B?S3RzcEJPR0RRRVRnSjVjM1lLclYvUmxkdG5uTHVBN2ttWUxJNEhiZEIvVHV4?=
 =?utf-8?B?UmZwUlhFa2tBdDNkVHErNURCUTN1N2dZRVZhNWdPN1p6ZGR2MUlhQXZXdldq?=
 =?utf-8?B?c21tUHdqTmdkWWpyUnNsNWtGd1NpTFIxNjJBd1k3QlMxcXBVWWw4YlFVbDc1?=
 =?utf-8?B?U0lmc3didFBmcndvM2ovY1BYN3QwdFlISlIxS2VGVlhEaWlsUDV4Y0xqUlVI?=
 =?utf-8?B?TEVRQ2RNU3JwcGVYVUV3WEpGRUVFRjdwaDNVVzVOZFB4dE9kdHhhdk9OVmR4?=
 =?utf-8?B?R3FUREpwWDBLcjVYd1dRYWhFc3d3bGdROFd6Z3IzOUQxbTBlMW82ZDVVdmlT?=
 =?utf-8?B?cDZBQ3ZYc0M2dmdZRnJxNG1EOS9iRlBpd1J1T284MUd0Um1vZ0JBZWRmZWpO?=
 =?utf-8?B?Z0tQN1cvZnd1VWNCTDQ4MVNWT1VMQmFSRmFrQzlnM0NGT0FHbGlHNXlEVXAv?=
 =?utf-8?B?L2JKUml1cFcwTS9QQTdvYzNiV2Q2c1BaQ1dIY1Q1Rm11bmRmdFJZRTNnTWhG?=
 =?utf-8?B?b1QxZzRQbjZkOGpVVFh1MmVZTVZZQnJzMUNwdHViNEwyMFAxUTYwd0NFRGpY?=
 =?utf-8?B?U01VTC9vckQ0THFzWjRNeVB6QndBQTZIaVY1dXo0NVpzMzJDUkFkRDQxV0Z3?=
 =?utf-8?B?cFNFaUtvZGhKMkRJWm1YeGZMRkRaZnpPaUdqYmNNVVZ6V3crQ0RZcTEzY1BL?=
 =?utf-8?B?T1B3REJsaUs4M1hpd2FrZFFqRURhTFdkZnRjS0Y0TjM4ejg5OW04MGpKV0x0?=
 =?utf-8?B?MjJlV3daL1hrTEc1YjhmbFpGVm45dnRudWRiVkQ0TEhuT0taUEpuOENZQ3hZ?=
 =?utf-8?B?ODJyTkpYaVVRaXJVTDFQL2Nhc1diSkQzTHFWaUNTRkN3QmlaSFdnbUJzSE1a?=
 =?utf-8?B?VjdJc205VTZ4Y0Q0b3VIak9iMXd2ZHowYVRyL1AwS1FCME5vNFZmb0UrbG5Y?=
 =?utf-8?B?ajJvaFlUNWM5b2JiM09sdVBnNGE1RzBpZnBLamdkR3pHSmx3dU1landUaWdp?=
 =?utf-8?B?RkdXMDV5Q2xMMGt1cFg2MVJXRG5jTHRNa3FEc2Y2Mk5RTHQ5MUFsTDdvNzZF?=
 =?utf-8?B?S2lIcGJEZEh1RHpldW5oeXV4VWY4Zmh4MllPTEpZdmpocEp3OU4ybzFScU9E?=
 =?utf-8?B?UnRzeGYzZEZ5SmczcUtBZXh6ZlpTbGgvY3NhWUVaOUp6ZHVBdDBsempTbkJ3?=
 =?utf-8?B?THlOMlFtM3VKZ2svdXBTREp6RXhLUW1vc29hd0JiaGV6THI2SkYwL3UzZUV6?=
 =?utf-8?B?ejlXSzJlZGNPNVJGRVBONE9QMGNFZGRpT29YREtvKzE3RTVLY25DdzRsZEZW?=
 =?utf-8?Q?/XezZ+vGwEwkw8tqeDd5OyDEC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa1becd-e130-4880-0cfc-08dd7e1e90f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 02:13:10.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc6FIa6SSDMth3UScIafAqmsilkM0c9DZj8PxEYB05gpxHh0modzM82MKgE4gcqsRzZiJobdPQrM/w4IAKpREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
X-OriginatorOrg: intel.com

SGkgVG9ueSwNCg0KPiBGcm9tOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBb
Li4uXQ0KPiBPbiBUaHUsIEFwciAxNywgMjAyNSBhdCAxMTowNzoyM1BNICswODAwLCBRaXV4dSBa
aHVvIHdyb3RlOg0KPiA+ICsJLyogQ09SUkVSUkNOVCByZWdpc3RlciBwYXJ0cy4gKi8NCj4gPiAr
CWludCBjZWNudF9udW07DQo+ID4gKwl1MzIgY2VjbnRfb2Zmc2V0c1tOVU1fQ0VDTlRfUkVHXTsN
Cj4gPiArCXU4IGNlY250X3dpZHRoc1tOVU1fQ0VDTlRfUkVHXTsNCj4gDQo+IFlPdSBoYXZlIGFk
ZGVkIHRoaXMgImNlY250X3dpZHRocyIgZmllbGQgYW5kIGNvZGUgdG8gcHJpbnQgaW4gZGlmZmVy
ZW50DQo+IGZvcm1hdHMgZm8gdmFsdWUgPT0gNCAoIiUuOGxseCIpIGFuZCBub3QgNCAoIiUuMTZs
bHgiKS4gQnV0IG5vIENQVSAoaW5jbHVkaW5nDQo+IEdyYW5pdGUgUmFwaWRzIGFkZGVkIGJ5IG5l
eHQgcGF0Y2gpIGhhcyBhbnkgdmFsdWVzIG90aGVyIHRoYW4gIjQiLg0KPiANCj4gSXMgdGhlcmUg
YSBtaXN0YWtlIGluIHRoZSBzdHJ1Y3QgcmVnX3JybCBkZWZpbnRpb25zIHdoZXJlIHlvdSBpbnRl
bmRlZCB0bw0KPiBoYXZlIHNvbWUgIjgiIHZhbHVlcyBzb21ld2hlcmU/DQoNCk5vLCB0aGVyZSBp
c24ndCBhIG1pc3Rha2Ug8J+Yii4NCg0KQ3VycmVudGx5LCBhbGwgQ1BVcyBFREFDIHN1cHBvcnRl
ZCBieSB7c2t4LGkxMG5tfV9lZGFjIGluZGVlZCBqdXN0IGhhdmUgdGhlIA0KdmFsdWUgIjQiIGZv
ciAiY2VjbnRfd2lkdGhzIi4gDQoNCj4gT3IgaXMgdGhpcyBqdXN0IGZvciBzeW1tZXRyeSB3aXRo
IHRoZSAiLndpZHRocyIgeW91IGhhdmUgZm9yIHRoZSBSUkwgcmVnaXN0ZXINCj4gKHdoaWNoIGRv
IGhhdmUgdmFyeWluZyB3aWR0aHMpLg0KDQpUaGUgdXBjb21pbmcgQ1BVIERpYW1vbmQgUmFwaWRz
IFsxXSB3aWxsIGhhdmUgdGhlIHZhbHVlICI4IiBmb3IgImNlY250X3dpZHRocyIuDQpUaGlzIGlz
IHdoeSBJIG1hZGUgdGhlICJjZWNudF93aWR0aHMiIGZpZWxkIGhlcmUsIGludGVuZGVkIHRvIGVh
c2lseSBjb3ZlciB0aGlzIG5ldyANCkNQVSBFREFDIHN1cHBvcnQgaW4gdGhlIGZ1dHVyZS4gDQoN
CkRvIHlvdSBzdWdnZXN0IG5vdCB1c2luZyB0aGUgImNlY250X3dpZHRocyIgZmllbGQgZm9yIG5v
dyAoc2luY2UgaXQgY3VycmVudGx5IG9ubHkgaGFzIA0KdGhlIHZhbHVlIDQgYW5kIHRoZSBjb2Rl
IGFwcGVhcnMgc29tZXdoYXQgcmVkdW5kYW50KSB1bnRpbCB3ZSBhZGQgdGhlIEVEQUMgc3VwcG9y
dCANCmZvciBEaWFtb25kIFJhcGlkcyBpbiB0aGUgZnV0dXJlPyBPciB3ZSBjYW4ga2VlcCB0aGUg
ImNlY250X3dpZHRocyIgZmllbGQ/ICANCkVpdGhlciBvcHRpb24gaXMgT0sgdG8gbWUg8J+Yii4N
CiANClsxXSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvYXJj
aC94ODYvaW5jbHVkZS9hc20vaW50ZWwtZmFtaWx5LmgjTDIwMA0KDQpUaGFua3MhDQotUWl1eHUN
Cg==

