Return-Path: <linux-edac+bounces-2436-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80989BC343
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 03:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500351F227E0
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC9374CC;
	Tue,  5 Nov 2024 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ig/ovn8j"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28A17583;
	Tue,  5 Nov 2024 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774132; cv=fail; b=igWR6fJcpmCmnmUElUoV15x+d7rV340mxu5t7b7y1IBb7RUIFxUu5CKH8T/6SyOr7XHv0LXY+0CcxojmSTkS2/9FbQNkw6CAsHy2JuOYMgr6XQc7L9amZYIcuW25/u0bXxaaO04rLsoYuaA5L02ueEY8HXhUdK1OF7xkkUbNcso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774132; c=relaxed/simple;
	bh=exycnMiV0xRd/2qw9i6zwGXOHH38qIn8ztndjzHBCPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/1fsYg5RzOFZqxQYjfMfjj+nCvVECdqRUFtBUFTEVOtVxPSt096BRg/9fNIjWGtilOpbng3BrVFCFi7RECjCKJyJsm7c0dsujFJqhX+EL4DGy/cqB3dgnARtQoVpIJ/dDCLqCCiQljFUReZZ+j22q3ZOAs3DNBR3+2sXLNdTQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ig/ovn8j; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730774131; x=1762310131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=exycnMiV0xRd/2qw9i6zwGXOHH38qIn8ztndjzHBCPI=;
  b=Ig/ovn8j7k7inggkqpkKFiL988XPCxYsYJiGQqInb8ZJj8LMmVVOWka1
   1U0Tu8aoGjdAn6kUNXbMxzNFxz3K39p34sxp5JvpLriTGo/198PjdATfb
   Za0QHtb2urNDAKb/0D+Gd4MCTX1vSDSC9aYKti/euyFpPgFCxOEZQft9R
   0s5so9379L0zvaCQigoY8YXJ30+8WF2hFUC3ovecrEXdKxT++MejrQpHq
   zIJaWSPOKg/AaeGT2BrmSUMowGmtoPsUQ0jtwxA3ehu9kT/FdqCUjeSj8
   MVtvUKwfp9vRKC6TdsuoWsQXMWgq8oDOX7X+cEyKtG4mD41+HVRLSNuc7
   A==;
X-CSE-ConnectionGUID: kRQUUAaiQuOL4X1nImasQw==
X-CSE-MsgGUID: +R85goodS/GHVCd45AC+/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30614747"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="30614747"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 18:35:30 -0800
X-CSE-ConnectionGUID: TjY3hUrXTtaP+wBDn/CIXg==
X-CSE-MsgGUID: uIz7hPvJS6+V9haPQOS1Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="87774851"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 18:35:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 18:35:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 18:35:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 18:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/VD8AglCTFpM5F7ArRTlum+vSKSgCUMEYrAKCuOiUoRbxt8ok0u1lblZJ7sGjVSoC4zADUnJEn/CNgcgKTOb/tIaI8f3wnHueJxqFGY3lysezXUxbrXyVsFpMBnsc3oHrxQLMw2WTu/ffARqBQmQk9PO9xfH7/tFR2hGXz5Rc1FimrkhbHKMgHu5oZL48lP3DZDRlG7qP9sGy7Wly5DcGHBOLXry4SaSm5GCJCGD0ofD2Rbyyo/ziLQIo8z/f5hpYsIBkuIDelZ6FE69EnlLi7Zi9r5oancE3E/wn6oJowd6Uv8ewAw8M6q2Etm0OdnOvCqqQO8Ik4glPtZHP3WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exycnMiV0xRd/2qw9i6zwGXOHH38qIn8ztndjzHBCPI=;
 b=G+mdfLgi8VaqzXgeQdZ5aRlnJY4Z8Q3lBsLAFKDyyEdXoSFgq6XvR6dDKRiKwvd9X4kKoxVTKxlbGBuKUubReh/RCgRFfKsu30ThZy8tAVOILB2B0jewGUmNoA2qIb30MR4NBVOQCCi3DMlOj/Lr2qFW5pKx/ibh9849DAw14rWrqRmSL4rk3zDtO0VcBLNSGlWT0d/ubj4Mn8ruMlDvAV8sQ3c7oXYR18yXfsR6wxXUXU8+zrLibEuF0ukHxGOLjIph99aoovbvT76GlB1JEZPtB1HvDxRIxGNYhIogEgYn2qIyGIchXArja5Jl0c7jGJQhXPPBywZD+qaBnflx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 02:35:27 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 02:35:27 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>, Orange Kao <orange@aiven.io>
CC: "Luck, Tony" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "orange@kaosy.org" <orange@kaosy.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 3/3] EDAC/igen6: Add polling support
Thread-Topic: [PATCH 3/3] EDAC/igen6: Add polling support
Thread-Index: AQHbLrc2U4gA5F4hv0a539M07zU/RLKnY/QAgACQEXA=
Date: Tue, 5 Nov 2024 02:35:27 +0000
Message-ID: <CY8PR11MB7134DCEC6313A00307FBB31F89522@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241104124237.124109-1-orange@aiven.io>
 <20241104124237.124109-4-orange@aiven.io>
 <20241104174052.GHZykHJEiU2KPqIMRr@fat_crate.local>
In-Reply-To: <20241104174052.GHZykHJEiU2KPqIMRr@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: orange@aiven.io
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN2PR11MB4536:EE_
x-ms-office365-filtering-correlation-id: 82b179dc-ddc1-4884-4c02-08dcfd42821c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVRnajZJZS93Mlc5ZjhyMzIwM2dHTXRUSzZSSE5mT3o2K0FVQTNHSWw1bW9H?=
 =?utf-8?B?NzRPVWt1MWI1K05xbHdoOEwwTjhQb3I1aTk2cjExSk8zeEV5SysxTERGR0FS?=
 =?utf-8?B?LzloSWU2TGdhcGxiZTlEdENjQ0RzaUFVV01UczhSUEsxUUpIT0dBaVluNS95?=
 =?utf-8?B?cGpMZG9hZXhTVHgwQ1RkcnV4akg3dm5PbWxhNGs0OU5rN040dUdtUFoyaWNG?=
 =?utf-8?B?eFFxN1B0bVo2ZE9RbDNUa05KT2RzZURFYitiMUYyL29jRHNuM0t6Q21uSXJT?=
 =?utf-8?B?QmliNmdGeEJFQU55cnZKNHBVNzZzVUpYSnhNYk1BUDhvdzUwUW9VUktxcmdh?=
 =?utf-8?B?ZDFuZnJmYUhmQVBiNDZsWXM3Mmd6L1AzcmhqbEZkSm5wbjZ0MGVaMmdIc1U3?=
 =?utf-8?B?U1N3Z3RMdHZpUDdTZnpTblZOMzFMZW5Ob2JPTUZOZGZBNzJrY0VsbnNibFoz?=
 =?utf-8?B?TTl0OFNQZlVwRFpObFh2dHFtdUFCSTRzOElWZEthZ01GSXQ1S0JhQUo4Tnlw?=
 =?utf-8?B?TVQvYUFRS1BMdCs2NnBhUjkwaUhrMjNIMGNHN1crTkNoVlJhUzNGUUN0S3lu?=
 =?utf-8?B?T2lDT0ZwWUkrU24xSnJHWlhBOElDcEZmOVdjVHlZUk9lSXlmNmN0VFpTRWM0?=
 =?utf-8?B?MFVkelZ6eU9BVk5XcnRKWG1BNFZIaEI1V2tlT0g2RGdycEJtd1Y5TGtNbmhx?=
 =?utf-8?B?bExkbE4rUEpBeDQrMzVZTkxuaGpCMVBROG5GWmZMSVFZL3hQTWJIdjRqQTlL?=
 =?utf-8?B?dlg0Z0lTVlNDTVhBcnA4V2xNd3E3M2xPbkR4Z0dDZ2VOdVhXREZMTjd2VGtv?=
 =?utf-8?B?blVPcWpKWHZhd0VwTm4yYUtsVmtONEowTHplNWdHUU1pUEVGU2MxbWVPUkdn?=
 =?utf-8?B?NGx4eWJBcUZiMm9IR0VrUThSNTZnLzJUUTF2NzVja3RyYnFlb1RsdmR1anVQ?=
 =?utf-8?B?NFdPOWJWOVNHempFUkx3Z0lxMUVQL1p2c3Q1dTRtRHExOVRpZ1RYQUtMU1J4?=
 =?utf-8?B?eHl1aGN0UVYyWlp0WjhTczJZa2E4eXBJaytYSzhMbHdzem9WK29oR2tvaHhz?=
 =?utf-8?B?dW1xaGN3bnBScEJOQVN3MUtjODdSQnBkcCtxK1ppbjQrendDQVJZWHowVG94?=
 =?utf-8?B?RlVzTjVwMXdlc0x3TjlYeHpNSzFkVUxOa1RpRTBSbDB5ZTB0bDFGRDRXcytU?=
 =?utf-8?B?R1lkY3pKZTJRY0xycUw5QnFZWGhWTHFLTXVUV0RUNS9CdXlVbGE1emszankv?=
 =?utf-8?B?WmtQZHlUNzF2TEt3cXdxRDNwK1hPOWZnaDFsM1ZldDdQelArZlpMZmwwWjE4?=
 =?utf-8?B?SUpGOC9TVmc5LzM1bkk5M2ZiV242OTA2b2NyY204MDU4SkJQZ3p0dWp5QjBZ?=
 =?utf-8?B?UDVoeVdDb0FuTUkya3NaQkl4eVR6alJGNS9pSlYrS1RHSEEvRUtpVGxlWXdi?=
 =?utf-8?B?RlBvTDVQMjByK0xjRU5Jd1F5MWI3akRjUjk1OC9oQi9JNnBsUmJsM3pmUnZ3?=
 =?utf-8?B?dkZSVTNKMDlKVHhlaGc3VnlrK0ZiMmhsVzZYMEk0NnhWVjUzNG52OWVtRitT?=
 =?utf-8?B?cGhtNXlTeG5nb0NaQnA3eFlILzBiMFNLQ3A5K0twaVVKUEJ6SkJHWkpHZDlU?=
 =?utf-8?B?QUwzTnc0ZEdlYk4wcXlNeWIrb0dxUHY0L2tIQVFLbTY0b00rTFo2alBxcE94?=
 =?utf-8?B?Sno4T0FOMXlCczRZTkM3elREMXp3SnoyY0NyaGNCUit3RmFOSHArZXFrdVNq?=
 =?utf-8?B?S2MrQ2MvSEQ2VmdydGtQcDVEV0pCNDQrWkF1RHpHRVYwVVA4am8zbXpDd2dB?=
 =?utf-8?Q?yHrRXnzNoYbAaQ5c04lB8gqKmu8yrB9N0PXAY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1QzeDBMU0YzSzVtWnN1NGRxVHNkV01hTXNMSEZyNU5JYVRqbDdLOGJUVFNM?=
 =?utf-8?B?U0hUb1I4dEdiRE1WcGZpQ2JyQ2hiSGs5Sk5FYVg5OXNMVTZ0alJhME9RK3I5?=
 =?utf-8?B?NHAyR3EyWXZHSW5INThCT1lnQ1N3YjhpdTRMSnZBOE5Cblc4UDlDKzB1d3Rl?=
 =?utf-8?B?YWc1dG9qMGVsOUJpT2xQRGR3eXlvQ1NlYTFhNXpYVXlQbldkbkVjbGltQ0JE?=
 =?utf-8?B?dHQvZmI5c3NxUm1weHBqR1lTT01ISHBZT20xaFZobS9jN3VFa0NEWmdhckZ2?=
 =?utf-8?B?YThTTm1hVFVXY2E4SVlNUjFlNDFSRjc4NUVpZGFZSjdQSENMWWhVY0NncmpO?=
 =?utf-8?B?NGx4TzdpaG9xZlppdkZBMDdiTHJteEZ2bkJBOWJYaDRFNzRJNGFNVGxueWdC?=
 =?utf-8?B?NWZTbmdrbnNkNlQ2OFZsLzNBY2t4ZG9McFRTbzFXL29pWnU3QmFVQmM2NjRJ?=
 =?utf-8?B?RHlqdWNNMWs0YmQvSjJ0NXBaYmgwYndwWXdNcVZiMzZZbTdQSW9TczY4MTRD?=
 =?utf-8?B?bm9yaWtTOXAyUHRNNlFJRDBvMDZydFlNNWdkclh3R3BScjJ0VjArc2dUOEJX?=
 =?utf-8?B?UWdwSlErL0NWRnVNaUlhbHl3a2wxYURJNW1OcFgyWHgydlRJRUQxYkUvd01Y?=
 =?utf-8?B?MUhXdWN6RmF3ZUh1UlUvKzdUdGptTlpOQStaMXFtMVlWem9oaXZJeFJmVlhL?=
 =?utf-8?B?NklibW9Nd0NpRXhhUVZGNkRlU3NlMk45M0w0dVhkVGtGR1ZhOXZnZDkxbkhH?=
 =?utf-8?B?SDdlVWliS2tZV05DTno4akgvaitpVnFkemE0MFplSzZqT0lDOGZUMFVYbytm?=
 =?utf-8?B?STlyMkZSeUV6NzRoL0I3VUJOWGIrblY0TStsdzJ0OUFjenRZeHBRMXRFajAv?=
 =?utf-8?B?NHEvMmxURDd4NzZUejgvWG5BajA5UWl2dno1b3dKeTZuUjg3V20xdVBRVm96?=
 =?utf-8?B?T0RzSUllSzRldnozR2lPY3FUZC9DQTFqbXMzL2dCQ2JUL3lYVi91NmttcHBY?=
 =?utf-8?B?ekRsenVsR0NwRjRQd0dmOFJTOUx6NjROQmlUVWVEMmI3VFhGRG5xaWNVcTVF?=
 =?utf-8?B?RERoMm92T1ZyOExPNGhPdHFhRHNDd3lMejhmSldLUHNMNWN5UzBjT2hxWU5M?=
 =?utf-8?B?RFhlYStSWm1oam1CTEV4ZEVjSFRZQ3hIVWhLWWQwSnJkU1MrYXJNMTNKRUhO?=
 =?utf-8?B?L2VFSmZ5N0dUcE8zYlpGY0RQZysvWm4rZkNvMnBrUU5jWEdJZy9MSklYQktK?=
 =?utf-8?B?azNZMVFkaU1KdUdReXhTUGVTSTJ2YVZGMktwb0ZBYzNwU1M3bkVzVndEVloy?=
 =?utf-8?B?NVR0eTkwWDErMkYxVjJnejNFSzNsdVFPMHNnQUJTY0NQdC9ZY093Q29acUha?=
 =?utf-8?B?V25vZDJQYjVLL2FIQ1BWMVplR1JWNkpIZlp2YkVDeU5KZXFicHZKLzIxWi9z?=
 =?utf-8?B?VFFHQlA2UTgvYTBiK0pSTDRFTVBzRmpBOGxqaVJabnBid3ZzQnMzYnduSjd3?=
 =?utf-8?B?OHlkOVNSV2hFMUJKRndsSTlGUmpKenY2OWZBTXlMeENwTDhuajUwd1NVMVFr?=
 =?utf-8?B?SHVGL1JSb28rMW9yYTBINWpWOGFtN0JIL2VKajMyRW95MVpOc2V1K3Y3RHBS?=
 =?utf-8?B?SWRSZVYwcVZ4bmJZa0RIb2RER1lXOEcrMDBlZHo4Rm5WVXpLMHZoZDZ3UTRF?=
 =?utf-8?B?MUpCR1RibktBNEdLY3U0UE1oRDlNSDBucC81SDFsVUhSMHdoQmlhL2tFV1RT?=
 =?utf-8?B?cHBBWW5tU2Z1NTJRN1NUZ1J6d1RnRUgybFVyTzhvM3pyS0Yxcy9qYXgyY2RO?=
 =?utf-8?B?dU9XZFAxNE5oM1d4amtaUVJDU05Kc2tIM3ZQd09qeUcrVlNIZlg2ZHNkQkV2?=
 =?utf-8?B?TVdDUGRibnRSN21nNTBqOHVNMkhQdS9seHdRUWhNWWpVSVFHaDZHV09sN1o5?=
 =?utf-8?B?OERiL1lvcTc5aWh1NjA1UjZ2K0hqbElhcXJvUzQ3b0pXNjlWaFRWNXV2R1VI?=
 =?utf-8?B?UkFPWlBKUWpHT0djQXVjc2ZGOWEydHpMQUJlbDhLNVdtZnR0dGZlOVp4dm1v?=
 =?utf-8?B?MUlreUpGSVhDZ3pKSmNIYU9HQlhMcTNiZHRaVER5MnhBOXRxVkpPWEFQajNz?=
 =?utf-8?Q?qyCf7LA8pZzu6sgH/aY2HiCnH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b179dc-ddc1-4884-4c02-08dcfd42821c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 02:35:27.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Slu72eOf8F0fq70/U3Om894cFv90TxOBhn67YCMgYGzvV2SIJy9IPPEkCeef8sIkx76D2Rix3sFwTYhbb6vBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gWy4uLl0NCj4gT24gTW9u
LCBOb3YgMDQsIDIwMjQgYXQgMTI6NDA6NTRQTSArMDAwMCwgT3JhbmdlIEthbyB3cm90ZToNCj4g
PiArbW9kdWxlX3BhcmFtKGVkYWNfb3Bfc3RhdGUsIGludCwgMDQ0NCk7DQo+ID4gK01PRFVMRV9Q
QVJNX0RFU0MoZWRhY19vcF9zdGF0ZSwgIkVEQUMgRXJyb3IgUmVwb3J0aW5nIHN0YXRlOiAwPVBv
bGwsDQo+ID4gK090aGVycyBvciBkZWZhdWx0PUF1dG8gZGV0ZWN0Iik7DQo+IA0KPiBXaHkgaXMg
dGhpcyBtb2R1bGUgcGFyYW1ldGVyIGhlcmUgaW5zdGVhZCBvZiBkZXRlY3RpbmcgdGhvc2UgYnJv
a2VuDQo+IG1hY2hpbmVzIGFuZCBlbmFibGluZyBwb2xsaW5nIG9uIHRoZW0gYnkgZGVmYXVsdCBh
bmQgYXV0b21hdGljYWxseT8NCg0KR29vZCBzdWdnZXN0aW9uLiBUaGFua3MsIEJvcmlzLiANCg0K
QE9yYW5nZSBLYW8sDQpBcyBwZXIgQm9yaXMnIHN1Z2dlc3Rpb24sIHNldCB0aGUgZGVmYXVsdCB0
byBwb2xsaW5nIG1vZGUgZm9yIHRob3NlIGJyb2tlbiBtYWNoaW5lcw0KdG8gb2ZmbG9hZCB0aGUg
YnVyZGVuIGZyb20gdXNlcnNwYWNlLg0KDQoxKSBBIHNtYWxsIHVwZGF0ZSB0byB5b3VyIGN1cnJl
bnQgcGF0Y2gsIGFzIHNob3duIGJlbG93IGZvciB5b3VyIHJlZmVyZW5jZS4gDQoNCnN0YXRpYyB2
b2lkIG9wc3RhdGVfc2V0KHN0cnVjdCByZXNfY29uZmlnICpjZmcsIGNvbnN0IHN0cnVjdCBwY2lf
ZGV2aWNlX2lkICplbnQpDQp7DQogICAgICAgIC8qDQogICAgICAgICAqIFF1aXJrOiBDZXJ0YWlu
IFNvQ3MnIGVycm9yIHJlcG9ydGluZyBpbnRlcnJ1cHRzIGRvbid0IHdvcmsuDQogICAgICAgICAq
ICAgICAgICBGb3JjZSBwb2xsaW5nIG1vZGUgZm9yIHRoZW0gdG8gZW5zdXJlIHRoYXQgbWVtb3J5
IGVycm9yDQogICAgICAgICAqICAgICAgICBldmVudHMgY2FuIGJlIGhhbmRsZWQuDQogICAgICAg
ICAqLw0KICAgICAgICBpZiAoZW50LT5kZXZpY2UgPT0gRElEX0FETF9OX1NLVTQpIHsNCiAgICAg
ICAgICAgICAgICBlZGFjX29wX3N0YXRlID0gRURBQ19PUFNUQVRFX1BPTEw7DQogICAgICAgICAg
ICAgICAgcmV0dXJuOw0KICAgICAgICB9DQoNCiAgICAgICAgLyogU2V0IHRoZSBtb2RlIGFjY29y
ZGluZyB0byB0aGUgY29uZmlndXJhdGlvbiBkYXRhLiAqLw0KICAgICAgICBpZiAoY2ZnLT5tYWNo
aW5lX2NoZWNrKQ0KICAgICAgICAgICAgICAgIGVkYWNfb3Bfc3RhdGUgPSBFREFDX09QU1RBVEVf
SU5UOw0KICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgZWRhY19vcF9zdGF0ZSA9IEVEQUNf
T1BTVEFURV9OTUk7DQp9DQoNCjIpIFRoZSBjYWxsIHNpdGUgaXMgdXBkYXRlZCBhY2NvcmRpbmds
eToNCiAgICAgIC4uLg0KICAgICAgb3BzdGF0ZV9zZXQocmVzX2NmZywgZW50KTsNCiAgICAgIC4u
Lg0KDQozKSBBbHNvLCB0aGUgZm9sbG93aW5nIDIgbGluZXMgYXJlIG5vIGxvbmdlciBuZWVkZWQg
aW4gdGhpcyBwYXRjaC4NCiAgICANCiAgICAgbW9kdWxlX3BhcmFtKGVkYWNfb3Bfc3RhdGUsIGlu
dCwgMDQ0NCk7DQogICAgIE1PRFVMRV9QQVJNX0RFU0MoZWRhY19vcF9zdGF0ZSwgIkVEQUMgRXJy
b3IgUmVwb3J0aW5nIHN0YXRlOiAwPVBvbGwsIE90aGVycyBvciBkZWZhdWx0PUF1dG8gZGV0ZWN0
Iik7DQoNCkNvdWxkIHlvdSB0cnkgaXQgYW5kIGhlbHAgcmVzZW5kIGEgbmV3IHZlcnNpb24gb2Yg
dGhpcyBwYXRjaD8gDQpPciBhbnkgcXVlc3Rpb25zIHBsZWFzZSBmZWVsIGZyZWUgdG8gbGV0IG1l
IGtub3cuDQpUaGFua3MhDQoNCi1RaXV4dQ0K

