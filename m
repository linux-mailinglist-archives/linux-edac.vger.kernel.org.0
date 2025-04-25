Return-Path: <linux-edac+bounces-3715-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B62A9BBEA
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6771BA38EF
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D2139E;
	Fri, 25 Apr 2025 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThMasF/q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BFA29;
	Fri, 25 Apr 2025 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745541660; cv=fail; b=alX9Fxj09JVRkViw6aY/ThwndZjbWvU/hbqQ9dO95U+4qNoaRfIM0zE4vk7TPonmLSSiDMn4Wk89/8lAsLybYwf/+8YuXmry3dPEHnkpHigHRGcS9Wja6txByog/W/agIyr0GsUYioL7lMG8kfpPhD9v4/7CC9gODfc/pTKlduE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745541660; c=relaxed/simple;
	bh=EUEQO2rP9kFq0WBasP3qI1Kvl7G1axwONSMm046Dh3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzoYZvUxS4LMVeOt20IMH1nxvCu3OW8uwM0ZnNGltta/2vBc7C4e2T8IP+em4aJDbmN9S/bjubrvb8Hszd0x3vCpk1hUk4B70Ium5SEvnVcf65n1jF3I+w4ZZvHU+n9XpOdqfJ5tcLzZVNz7Eu5gURYWW5UtpVveh45vOKyTj3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThMasF/q; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745541657; x=1777077657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EUEQO2rP9kFq0WBasP3qI1Kvl7G1axwONSMm046Dh3Q=;
  b=ThMasF/qURmfGUiBx/zJaoO+0fn/6ksgs7/GtozykcozL6lfqSRiCBde
   qI88O0+Qtp7LRtoAYoIQpLkaj6cvLvhs2dyk0sRe1Fa3VaWDg+NwGFLft
   BdlX7ecg7tUQBa28VfxRnZ/FzD2Z73SmrWJ4yaGkWYkIX5i3Tck3VB4nh
   n8onEjZ7c3iG2N4X2y1ZqMa4UnJGyWBi2W/zjia8/WziV2QsHk9Bl9eHX
   nP9SG5QNtbnFX6j2jottx4HTXls0otGoN9NtvwgmRLt83+TrSil9DzAeE
   esnviqK468VmI3Bg6UnaCUnCmOpiXHMkNlaP6907Coa09gzPoxHCu5GXN
   w==;
X-CSE-ConnectionGUID: RYEn/3lnTKOuBMs2V6qg9A==
X-CSE-MsgGUID: /kc5xfgWRp6H8A4ZLM6KdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47109978"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="47109978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 17:40:56 -0700
X-CSE-ConnectionGUID: KH1WgEIARRKm9cfyZm7saw==
X-CSE-MsgGUID: Eskba5piTCW/WZB/bLe5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="137841013"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 17:40:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 17:40:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 17:40:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 17:40:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkJKHYS14gt3oQFaoHvUYwdM+6yCgpQf3yA0O3lqrEz5uemR854x5Eskfperg6WkAHkdJaUYGbRLomjtHk8Uz+W6gRFFuVu5zeOj6KVQi89oK0gm0krFqm7cq9dtRmc6eGqgrd6ClRp7sf7o1ws7PXtbdLWtw8gSeFGgDkj2PDdFvNT7RuTtgA75SLp+gOG24o5EXZ4I29RyFZ3QnJ8bC5l28OWHHuFDQi4VoTqxBxsthXI6ew2CLeD2jivFnaH8dxezwBYe1sMfxa61KESv+DALC5g1v7eo6XxtDZzsk+ZEVOQl/Lcpk4ddLlhOtSDwDRm2rbMEZPT8MssRvBc1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUEQO2rP9kFq0WBasP3qI1Kvl7G1axwONSMm046Dh3Q=;
 b=CPtsidbEgEvWk06atY/6mtYyp8FlPDWOzUAxHIIOG+IL7ml4nZ9qbO5xuUKDBFpB+Kd6CdrgeBtTmG0g7lzo5ek7dMpEknx02T2mQTapij9qg0EubtaClB2+4wbxwtinrP3WJjUb4bFpb83RhcBg/eeNjDvC+LSTNTw9477aXrTvOjLY68cTt+nuaON+TRxZBQDTq+mGLiH+5yTRPbTVTNBrwL6a7KpQvN0Ao8KHzsfa4bmLmjowVAA9IfSvLXQKlzUX0lvrwbwYGpJ6Pi8OhSyhPZfANsxMrIPNs4zEKrmKuN+MowyWosP+rjgICJ/NhLPqNmdWTIfHRvKXs0kSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1SPRMB0020.namprd11.prod.outlook.com (2603:10b6:208:3e1::18)
 by PH8PR11MB7967.namprd11.prod.outlook.com (2603:10b6:510:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 00:40:50 +0000
Received: from IA1SPRMB0020.namprd11.prod.outlook.com
 ([fe80::83d2:f8bc:73a5:7890]) by IA1SPRMB0020.namprd11.prod.outlook.com
 ([fe80::83d2:f8bc:73a5:7890%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 00:40:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Gerlach, MatthewH (Altera Corp)" <matthew.gerlach@altera.com>, "Dinh
 Nguyen" <dinguyen@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"james.morse@arm.com" <james.morse@arm.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "rric@kernel.org" <rric@kernel.org>,
	"tthayer@opensource.altera.com" <tthayer@opensource.altera.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>, "stable@kernel.org"
	<stable@kernel.org>
Subject: RE: [PATCH v2 1/2] EDAC/altera: fix cut and paste error
Thread-Topic: [PATCH v2 1/2] EDAC/altera: fix cut and paste error
Thread-Index: AQHbstiNNRTV5x23u0CEkrRn+ODEJLOzcb0AgAAbtwCAAACxAA==
Date: Fri, 25 Apr 2025 00:40:49 +0000
Message-ID: <IA1SPRMB00206461C620511B31BACC3DFC842@IA1SPRMB0020.namprd11.prod.outlook.com>
References: <20250421161447.41886-1-matthew.gerlach@altera.com>
 <20250421161447.41886-2-matthew.gerlach@altera.com>
 <20e82d2c-b035-4bcd-82f7-807134101e28@kernel.org>
 <a518bc57-6fa4-4c3b-a037-8458a9510b7d@altera.com>
In-Reply-To: <a518bc57-6fa4-4c3b-a037-8458a9510b7d@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1SPRMB0020:EE_|PH8PR11MB7967:EE_
x-ms-office365-filtering-correlation-id: 3445fcfd-d6f6-446b-bc1d-08dd8391d395
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MTdBcHA5VkpucnlwSkxyc1ZJVnlrRXI5eWFyS1NNVFZvYWNZTmJiRktBTHEy?=
 =?utf-8?B?ZkZ0Uzg0WEc3Qm5WTks3b21QWTBBVWl6MFl4bXJXNk5reksrelJiVy9KMzMz?=
 =?utf-8?B?NHFYQ1FjdzR5OGUrQTREWmtaVXFMSGNzOU1uUVdlUlF3WGhMcjExbHpLU0tl?=
 =?utf-8?B?dzIxMXpvZ3NhM2JCeDZJa1lZZzUzY2oxcWJmQ2tVTFlMRTVzamhsUnNxZjNX?=
 =?utf-8?B?dFpkQThRZTgzNFlMaFg4RTBPOERjZmQxYTNUMGtDMjRXY0lSMWpKZTFoYktn?=
 =?utf-8?B?c0tiM3BzWkFUME5aTlFhWit1QXRyVHlQRXZCayszakQ1NlNqVE43R2xLSGhX?=
 =?utf-8?B?UytGaVJwQnMyenEzc3RMMFJ0ZlJuNlhOWU1VOXVNUHhXaDJLV2RWaThlWC9s?=
 =?utf-8?B?TEhKd2JuMGZOT1B4ZXBZWFhWS0JSWkVYU1ZwSzE1bisvclM3VklHb1BqUDV4?=
 =?utf-8?B?a201ZEhmRGQ5b053MGVSOWJtc3pKN3ZYeER2SGs4STl5RTVZR1o5Ulg3NTQ5?=
 =?utf-8?B?RDVjRXovVFV2UWxhL1JoSXpFVWFqeFFaZTJZVDBydWw0N3cxQyt1R3VoR3k2?=
 =?utf-8?B?MmtMbm5yWm9zOFdNOEdEcEh4VEhwc01YZWFINTZsQnJzRkd5QjJ2b0pzQlhi?=
 =?utf-8?B?MXV2OGRJY0FkUHBib1B1MzJheEU2ZDlBdWVpUlc5S2NxTGtLTzVaemNCOThh?=
 =?utf-8?B?eDhobVlNNkx6dXBwVFBURWJhUVZvZmlEVkowaFJVNWExQkg4QXQ2UG1lTTZi?=
 =?utf-8?B?UzAyYU5ZRkd3Rkc4OHhFVitDbjVwOWpqaDFMQ0h1dHdJelBJWUVJd3lWdSta?=
 =?utf-8?B?Z1cvZDhwWmlSZWd5MStLanJ5UGsxNzFqUUkwZHFGNW9ZR1QrbVFFakdJMmI2?=
 =?utf-8?B?UXE5NVZGY1ZqYlNNcFB0dDBlMTE2UlNiem1JOENVcGdxaHBVVmphU0JxRm5C?=
 =?utf-8?B?dmlGdEZvNmNkR1hzTTMvdzNBRzR1cEt0REYrUXc0Sm93S05wWDFsV1MwNmdx?=
 =?utf-8?B?Ly9hWVdCWkJDc245ZHlJNVdDcEdwL09seWhHcDV5UVVIVWtCSHRDWFAxK0tn?=
 =?utf-8?B?UHZ2YVp4T1YrV1ltQnhsSStQNVBsSTJoRmRGUnYwNzdCOUhmb1ZmeDA3MStV?=
 =?utf-8?B?Q3R3OU9ueW5WMEJYYmUvQzZqNWJiRHp2ZzE0eFlMRmE4emE1RENFOHdVQVVq?=
 =?utf-8?B?N3JieHRWaXFlL0JBcW11eWxlc1hqQ3lBbEJvMUFUL3I0djdMZGI4bjMyRElS?=
 =?utf-8?B?OXlWTjd0OXVrYW9LZy9aWEY3MXZBSWhoS2k1UyttN2wrSytjL2tXZW53U0xU?=
 =?utf-8?B?OFQ1bHBTRUtTM2JJRis4cUdyY0NsUWhEOVBiTy81WHlUeGJHL1ZncW5LQ1g0?=
 =?utf-8?B?b3FhdXF3QXhjTVBBSFh4TUZBTlVzWTI3UUgzbjkrY1RVSEo5QklUb1YzU2tq?=
 =?utf-8?B?RGFmOGMyNnpROThiS3M3b0RxS0w3UXVxRHRPdTNaWThDWGF6TkQrUVZ3c3Yy?=
 =?utf-8?B?blQ2SXNNalF5UUtVRDRpZ0dpNTF5QlBKcDZKSFllMzczc0lUUEpUTXh3dGt5?=
 =?utf-8?B?TzN3ZXJTamhNNWkyU01nSEJTOHJQUUhkUm8xeEd3R0g5ZzlaRXA2MWMrZzEv?=
 =?utf-8?B?RmJTRFczVTYvNWtJL1ltbWF2UlU2cFVqVUV4MWhvNWVxQ2p6d2JVc3JrMS90?=
 =?utf-8?B?WTd1VmVCTTVxZFkzcFJKTHRwK3RhUFMvMlhoT1Vxa0p5Q1JQK0w3VUJlZE1p?=
 =?utf-8?B?UUFqVXhlckFKTEtUVU1UcXhRZnpyZEdtZ2xESElDcWhsZHFQUVc3QlpHM2ZG?=
 =?utf-8?B?RllUS0pxV1hBaWhlRGR3Y3RFei9OWnVvUG9YdHdNaktsRHVseFJHMWxZL2Uv?=
 =?utf-8?B?OHlDZ2JhWmFsMWFkeVcxdWRvT3V0Ty8vOUlVQlA4R05WTEZkV3REQUp4S2Z3?=
 =?utf-8?B?VlNrczQ4cU1HVUpKR05rUWVDRVRQbUE2ODdCWHhSODFWSGhRdXZKUnZpNnRY?=
 =?utf-8?Q?VQp28nkqgvFoCvUelDxET1E9geqU6k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1SPRMB0020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVFLWFdpUHlCVURGYzBmR2dUbnNCQmFJL25xUVAzR1R6ejdJTEF4UzEyYVl2?=
 =?utf-8?B?aENtVjhLbVBkdER3Mm9CZmVob2ZDWS85bERicjFWNzlTbUp0YkdIa3NXQkRD?=
 =?utf-8?B?eHpvQ2Z0cE5kakNQSjMyUkR6ZFdMUW5qdjlVZnBGY2JVSGtQVTkzMURucHRs?=
 =?utf-8?B?Vi8xQ1p3WGJMc1BJc2E0eWVCb0szc2tuRGxwVG9nUVJEcXduRkpjOU90eTNx?=
 =?utf-8?B?LzUzeEJRcWwwRFRKUnoxV3BQaThXdUJlUDk3UEp5djFvSHBWYTBvMlZTRE1R?=
 =?utf-8?B?Y1JZSzRTMU13NUt5S24yQ1R4Nnl1MDBmcFJ1dnhZdGFLMU15aXNiTTgzSlNV?=
 =?utf-8?B?eFdpbXV6ejhDYVhaNEphUW9TQVFpK0lyTkxSRkh1VnFUWGVMVE04SWNTRXA2?=
 =?utf-8?B?ZDJLNW5za0RFU0dWSFhKUXVDWnJqRUlLM2lhTXBvV0VNb01qS1hOYVdFSmF4?=
 =?utf-8?B?eXROQlhtV1d5bWQvNUlwNklSMGYxWmV2bE1Cak9pZVluSWdBaHB2NHNIVXdw?=
 =?utf-8?B?ZnVPb1crbDJiRkhQSVIrTU4wV2dBY2M2eG9waWVSamtkOVR4VkhncTg2RnU1?=
 =?utf-8?B?YUtTNStUTjZVQ01JVFNEWmY4b1RsQkx5SmdTTEZHT0x0eWhqMmIvRFBEMUI3?=
 =?utf-8?B?QVdNNWgyUmhPUU45YTZ0MEQxUEt1enpDaFR3L043OSt1ODU3MTRDOW5QVHVS?=
 =?utf-8?B?cWliTGNoRzNaRUhNTERmamVIRnpZREFHb1dnMkY0YU5hMGlhSFhiQjAzR3ZI?=
 =?utf-8?B?UEVtb1dyMklPYWxjZTdtRXhZN290dHRSRmVHODFxdXNORWJQWWU1YzhZNU5N?=
 =?utf-8?B?VDE4R1BKemwzZVJzdlRtaVREdmhwVXhHYXYyOHFNTW1LeGZ4b2h0ZWJkRmZw?=
 =?utf-8?B?U01OSnhkZkZvVUNTUzlOWWNDZkFtSHFNRTVJMHpQbE4yS291VzVVYzJLMjlq?=
 =?utf-8?B?YWZ1Q0wvZXNBbHo2dGdrdldueUZ2YnJjNWxtYlprcTR3Y281ejUralJ5YXda?=
 =?utf-8?B?azd6TGRzdERQY0hHd1dpZnFJakRkNGQwT3p1MnVRL2QwK2hIRVRwdkwrak9G?=
 =?utf-8?B?SEphdmdDMkJQVmtYNkJ0cVVZYll3RmpGeEVjZit5a3FRblFkc2d2S0NLWGFp?=
 =?utf-8?B?citvQ3pjaCtMSFEzMkV3amhGMksvNkdRVHk5amI2TEI5dGJDVDMrbE5sZmZv?=
 =?utf-8?B?NFNDZ2M2a0l6V3RWVnF4RUxCR2hnVlBrMmJRVEVGSmY4VHovdUo4QUR3ZXNw?=
 =?utf-8?B?bEdERHZNL1VSb0ZSMTlLVjhmNEUyN1NoUjFUWnE4SG5zWnFEK1B6ZklhTmho?=
 =?utf-8?B?N0V0MmprY3pRY2gydmNuU3VIK3lNcDF6WFlOTVB3L1E1Yzh6NjFESzBnVDFS?=
 =?utf-8?B?RlZ2RE9UQzBtYmJBRlNsNC9jWnpkMVU5Wnh4UnZSL0dnNU4yTjVnQkxQTUxT?=
 =?utf-8?B?ZklwejdJc1c0M2pZL2twZGNteDdPc01SWm5Ic3pUYkg3YS94aWdNRitKWndY?=
 =?utf-8?B?ZlFFL0xGQTdRbG5ad3diNzZQRGxpUHJMZCtQZ3hrL3FPWHRFYkZRZW5pM1Yz?=
 =?utf-8?B?bjE2UDhmQW9iWFNOeTZpRlY1bHBqTXFybFZxOWNkcEw3Z29EY0tDK01OOHQy?=
 =?utf-8?B?d3lUMUNFazNUcEY2L0s1THJzZk03aFlQNlU5ZTVXMVJPNjU3Q2ZPaW9jK3g2?=
 =?utf-8?B?ZkpLSjY4UjZ1RHozVVIvWjl2aHJzOVl1U3piUldYM3l6bW9KVmkyL0xiYnJC?=
 =?utf-8?B?eHhSUkt0b3NmNlBwZlZBRU5jc1pzZkxHd3l0cTVZRG40TW5SZDFpTDFVQlky?=
 =?utf-8?B?WHNrVkNhK3AzTjZER01meXBSWWdHZ0YrTkpVamhzSFFaT2NnTWUwQTJhYVRS?=
 =?utf-8?B?SVhOcFNBUmRYOXBSUFdSRmxXSlBLc0NueHIwOUlZVDNCMEJ6d0hCalhJanZV?=
 =?utf-8?B?ZEV5YWE5dWJPYTVLdThyK2dBSWxPZi9WNjdrTTRESnZYRnJTN3NaeE5GR1dR?=
 =?utf-8?B?Z2NqRFJoVG9DRjl3a1JzS1M0bmYwN3NabXFCVEtvaVYzTW1kRDVFcTNhNjdK?=
 =?utf-8?B?NGs2NERRRElBZi83VlczMlBuUWNFMjVKVi9DZXNhVUp2WW1rZzZ5OE4wWks0?=
 =?utf-8?Q?FyYp6tzOeWfnd1KpwEz2XCTCJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1SPRMB0020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3445fcfd-d6f6-446b-bc1d-08dd8391d395
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 00:40:49.9494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqXza5uFIG8pNrX1UAj9K+SEA7+8Otca3ptS2ZuKPR4UHUSf8oa1xrq2J4d3SnAKBqdgWTpmpm3rDk6vqzBIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7967
X-OriginatorOrg: intel.com

Pj4gUGxlYXNlIGp1c3QgdXNlIGEgMTItZGlnaXQgSEFTSC4uLg0KPg0KPiBJIGN1dCAnbiBwYXN0
ZWQgZnJvbSBnaXQgYmxhbWUuIEkgd2lsbCB1c2UgYSAxMi1kaWdpdCBIQVNIIGZvciBGaXhlczog
DQo+IHRhZyBpbiB2My4NCg0KSGVyZSdzIGEgdXNlZnVsIGFsaWFzIEkgcGlja2VkIHVwIChJIHRo
aW5rIGZyb20gQm9yaXMpLiAgTXkgfi8uZ2l0Y29uZmlnIGhhcw0KdGhlc2UgbGluZXM6DQoNCltj
b3JlXQ0KCWFiYnJldiA9IDEyDQpbYWxpYXNdDQoJb25lID0gc2hvdyAtcyAtLXByZXR0eT0nZm9y
bWF0OiVoIChcIiVzXCIpJw0KDQpTbyBJIGNhbiB0eXBlIHRoaXMgKHdpdGggdGhlIDEzIGNoYXJz
IGZyb20gZ2l0IGJsYW1lLCBvciBhbnkgb3RoZXIgU0hBMSkNCg0KJCBnaXQgb25lIDczYmNjOTQy
ZjQyNzENCjczYmNjOTQyZjQyNyAoIkVEQUMsIGFsdGVyYTogQWRkIEFycmlhMTAgRURBQyBzdXBw
b3J0IikNCg0KYW5kIGdldCB0aGUgY2Fub25pY2FsIGZvcm0gdG8gcmVmZXJlbmNlIGFuIGVhcmxp
ZXIgY29tbWl0DQppbiBlLW1haWwgb3IgZ2l0IGNvbW1pdCBtZXNzYWdlcyBhbmQgdGFncy4NCg0K
LVRvbnkNCg==

