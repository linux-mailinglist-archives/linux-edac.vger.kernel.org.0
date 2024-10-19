Return-Path: <linux-edac+bounces-2156-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB49A4BF2
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15517280E6F
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660E1D1E89;
	Sat, 19 Oct 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs7TwF6s"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65F20E33D;
	Sat, 19 Oct 2024 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324990; cv=fail; b=VNdOe1xpHXc97fAE6qO9agP0Fg2D2oarMk3Y0/en9TPpxZYZeMD7KHfxTSuyfe5MOu0jDQanIt/ictqJKjHkvWKgkL4c8hnr8KPGO+4COQZ5nctaXG/A+jv7oU6XKE43PwVKUJ27u7/bMxuLsDAS4vn+rV1jZg/dxXsFvXFjn+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324990; c=relaxed/simple;
	bh=CsLsQC+gQpyxDMIRFrECNisdE0AgrkU/VOie5YNK8d4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gFxLoZuYcSL/ORcmxpcUyh6ZZkvztQVJQOLPJA5XWA0kIdfOIttk17Dfph72vsv8rAN9MJWd/bAwiz4O9NdVd3Kp0By98F7UqWfqcvUZk8G3LDxruDKbkhqHRVW4+N5yBu8TEjgH/8fj1ZszhUekT7eampc2X8gZmWu3Zw8srfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs7TwF6s; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729324988; x=1760860988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CsLsQC+gQpyxDMIRFrECNisdE0AgrkU/VOie5YNK8d4=;
  b=Cs7TwF6svSFblXPRhc3Tsdycv3Uf3SDJ/kFTc1yqOhAqE2Xp/cmxmtXE
   9OTT+Qls4bWGRthnpE/3vt2YdLtw27JN3R3QdO+wYTd1h+yvmVo7K7R1i
   lpotfRpgVAByKJRh9PcO1Vsq4tYDsriE2ZnMoo2zfcOh1xDw6mKqdApLO
   g0zw4yqrndPLGswaTHzZUNvbCvXa7XbQ6HDGw//ZfT7n65h+/t9USWxnw
   UW+Sm1+2qsPEs82fghvX9kqeu2urNP5en41rMqydV+trZqR55s66iD4xg
   eWxkXS6ylSap/GUWZ58on5sHDitPHQNmHWloUv8refYUTUrFbDGFbp8Oq
   Q==;
X-CSE-ConnectionGUID: 79eqC35ZR/6LgmbOPjE2Bw==
X-CSE-MsgGUID: hkLtTAL6SLWkoqzVt8pz5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28969610"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28969610"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 01:02:57 -0700
X-CSE-ConnectionGUID: nQQR409RTbWoSuymn1LXmw==
X-CSE-MsgGUID: qKDl5gOsSGuDRXqyiWUOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="116538791"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2024 01:02:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 01:02:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 19 Oct 2024 01:02:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 19 Oct 2024 01:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tebZ8hFa79dGqJSWeHH+mp/o56D/KTnGJYOuXds+ESoALAAfBDdtxXMtqryAwAzgbUWPsWUi5D2g0iTEnIXn8F3PwtirYw96MTgRJXxavNsOsNfS/sG5e6wAeF8Hyx/P56otDENm72dtuamcYRCTasV3ysnTB3MtQ8X9m+2pll8y7FIPV9tOyWb3PqdXm9ENAYZMwAsUvegz2phdVp/TKROJnSTdHLYK9IjcyRIvL06isOLvIWY7+PTJHrjq/nndLRJCJZt1PP9+9zs+OViK9bnbOWZ7ImNh/mDShWQ3TYsJaWPSwiw9RNQApqRH/KlP1CcS6WZ5c/gkgvWqY6vHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsLsQC+gQpyxDMIRFrECNisdE0AgrkU/VOie5YNK8d4=;
 b=cb7+0KUiNhocR3u0txgRitVKTDY4Xw+vTDJgK5qbgJrDSsc+3ZZkDFKIWyLzGRwYYJIhUhUuHYmq0ySQcr9ywYLLNDnkfPkQleroDRZRkjkBisMyoRg8Q8nCQKMyeXzQN4UL6gvDm6mbIIADSTKuRcY1oTWsttvULt8DUVDQfaH/mjoz86+NUzHQvy4xrUp1Tfyr+JBmoUv4Nc7nTbCT47U9c/LPrUzLETzTyZNhYEKq2pgonZMZVNgIgI4UB6ieOeY3xC0Yphd7cKpOqfQTioTYhxrN733nGfWwDtF3YNCwkeu//Ko8+z/4p5eez9lmpWhhbhHXq9encJPJweZXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB8095.namprd11.prod.outlook.com (2603:10b6:610:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Sat, 19 Oct
 2024 08:02:53 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 08:02:53 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/10] x86/mce: Fix typos in comments
Thread-Topic: [PATCH v2 10/10] x86/mce: Fix typos in comments
Thread-Index: AQHbH8qezdgfub2Jjk+SMQnEdYqzXbKM+1cAgAC5YfA=
Date: Sat, 19 Oct 2024 08:02:53 +0000
Message-ID: <CY8PR11MB71340F4781029A2445E7102689412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-11-qiuxu.zhuo@intel.com>
 <7af345be-8e8b-4c36-b105-67cdb24823e9@intel.com>
In-Reply-To: <7af345be-8e8b-4c36-b105-67cdb24823e9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB8095:EE_
x-ms-office365-filtering-correlation-id: 6534d447-c825-4750-1f47-08dcf0146f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2J4ZlRJZENlZ0xmNmtSRGhjSHpmNWdiNjQ4VWp3aWxWQ2hjMERUVDBPYnpw?=
 =?utf-8?B?M0ZBeUhJZjBkMlJIWXZRVXZGMHA2eVhIL2MwMDl0MFJ6bGY0V01sKy8xNzZj?=
 =?utf-8?B?aEdraEQ1UFhodXYycm1obFd4Q2NPdEFNZjZ6ZkxrM1BBVXJ5djlIZW1GUStv?=
 =?utf-8?B?UitYTzlHc1oxRGwrUHlyV2txZCtZUy9Pa0ZYblJLc2pWSVd6NktuU3lNZDJt?=
 =?utf-8?B?Lzk5SGFxNFBvVkpaelBJZE9DdWpnaVRrYXdiQm1jUFZrQ29HOGJEVTViUzJi?=
 =?utf-8?B?WDgrSXI1V3M3Z3JkRXE4Q2N6dDE3dDVvM3Z1YTNkaUpMSmlwc3VkOUY0SmQ1?=
 =?utf-8?B?aytlOThSdFFOZGdmVjE3ZUVYSzF5R0ErMjEvWXRGdVFjMm56SzJ5NnVyWU40?=
 =?utf-8?B?MTcxQk5Ta2tJSVBVYXdPeUd2bEZueVdpeWE2M3Y1QlJmWjVQeHhxRkhpKytZ?=
 =?utf-8?B?NmtuUFNIc0ptY3ZxTjMwZFZiTGdiOElKMzNZZGQ0QW5RQXJYS0dhVVZtVWt4?=
 =?utf-8?B?NlRReC82bWRCYWJsYzluLzMvOGVGd0lhakVuMWVqcytpcVdYNk9zMGdrZGVa?=
 =?utf-8?B?N0dXM1BxSitHOHV5YmZiaTY1bTlQeTlvaTdmazBzWGhqZGhYNWp5eDJJVnVs?=
 =?utf-8?B?dUsxTkhzVVF6K3gwMytBeXFLd0QyK3REQlBiZExjb3cyZU1PRVd3M1kzT3M4?=
 =?utf-8?B?dWZUeGhaNExQbmpaQUN0Y3lOZkFZTlVSekdRNGJaY2tVdFltWVhOMXhLVktv?=
 =?utf-8?B?REVHeWh6Y0hGYkFhd1hjNCt5bVA2QWF6N21aQ3NPeWZ1dzJVb2pFUXhGZGZl?=
 =?utf-8?B?TnhYL1hhcjVNb3REN3hPQ3IyU2V6SGZaTGsvWk1ub2ZoVHNPbzRUdUhkZ2hU?=
 =?utf-8?B?bjFlcGNCR2pSY2FZVmVJU3V1UDllcTY0OTRKTnQxSms5RnBVTkNkdjU0Qkto?=
 =?utf-8?B?WlkwSDVDbzdQaTFwdFA0ZFdFZnZ5L2twdTNaY2w0N0czcjN3cEk5WFNZZXJw?=
 =?utf-8?B?WjFHTldqWDhCNVR5OUxNQlRmUXVJbDA4TVVZRUNkNFlQS1VPRDhDQ3BERmNq?=
 =?utf-8?B?SEtmYktsL05mTWo1T3pndzVhMmdKdVQ5M0hGd0VRZmZDSU94dFVIUThRZmNj?=
 =?utf-8?B?N1VWMVNTVGZiZHVod1RoVFJ5VTl0VFc2Ym43QldweHczaWgyT3N6Um1HTVZU?=
 =?utf-8?B?eFQ4U1JFWGJjZ2FnajMzb2lWYkNWU1diTCtPYjdUVi9uU1oxRG5sZitwNDlQ?=
 =?utf-8?B?eGxvZ3VjM1FDYlI5VGFTTkR6RW03TkxML2JabC9pblZ4ZXJoeDJPQjJ1bVdS?=
 =?utf-8?B?S3JaSGd0WFFOcnd5YXJpeVlHM1h5UU83cmsvYWt6cStoTDJON0U0KzA4SHFR?=
 =?utf-8?B?eUV4WmdmVzRhcVVUY0Qrc3RwNVlVQ2ZNblYyVjlJcnYzYWpGT2xaS3V3Rytw?=
 =?utf-8?B?KzkxeGs4a3Y4SkNPZTV0NFpEc1lKUW43YzlnWVVYOFlBcWQ0TUlmOCt4dmsw?=
 =?utf-8?B?VjN5SW9TdjMzNnhTS1VZQVgrNENhNG5ONE10bG9WWWdaR3lqU3pMNDFQYmt6?=
 =?utf-8?B?WHZUdEM3Y1ZaWkRCZDFLMnIwNkExQ2ZwbjVYZ1dGbG1pQkxGVnJSa0xEV0Z4?=
 =?utf-8?B?UFdRUzNVRDI2MXBEM0Y5VlFUTENYUEdtay9iSlUvcFV6QndiSyttRUlwT2ZP?=
 =?utf-8?B?MmV1S0lwcUlGVVhxYm5kQ0xBU2czbEt3U0c0c1cxckdKSWIrZ2hPRzlvNWc4?=
 =?utf-8?B?N1pGajg3RVRkNHBTbnB6OUlRbFhwWTFTL2x3ME1BdCtQTjdFK01TRVp0NGw1?=
 =?utf-8?Q?u6fPcjoCiP5ayiap7qF/1PkvdboN7xJw1kRpk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9wOE9vZHcxcVk1ZFEzU3E5ank2NTRPNFp5RElrTVY3NG9KVk5XUHVRdFkr?=
 =?utf-8?B?RGtjQnNMeTkvanluQWZjUExGQk5waFBiL3VtU2xlN2N2WVZJYUVHcHd1TEJL?=
 =?utf-8?B?R2ZiODZ0dTNLTE9kMWlkS05iRGV0Z1VQQm8xVUhGdDVHOFVrSUlNS0d2dDBF?=
 =?utf-8?B?QVF2Q0d0bUJ1M3dEOGxuc0FJeEpmeS9tWjNVSloxck5YZ05lWkJXbGV6bDRG?=
 =?utf-8?B?Nkdwdy9maGZnZjJENTNzd2V6cXFWa01jM3JmWG0wdzd1enZOZDc1aFBka3pQ?=
 =?utf-8?B?WXo5UmdmVVFSMnhvQ1dSS3VNYXovL3NxU2FyaXN6eE1tTVBQYkdkbUtOR1po?=
 =?utf-8?B?QzdVRGZaalJ1RmJBZDFoK3lLL1hsd1pVdUpGaU9xNWxCd1pTLzREckI3ZnV0?=
 =?utf-8?B?MWdPM1JHRFVLNTBiWUN0d0lBTUp3MnI0WmhwL3dIN0hnSHJubTYyWTZmTHlO?=
 =?utf-8?B?Tm5lU29lelFoSzdaV1RhSEUxdUJma0dEeG1vNmk5MmhYT1VkV1dDNjBEQWhm?=
 =?utf-8?B?UVJJRDByOTNPT1BpaHI3d3lkQjBJZzA3MGYyZGlwa3Y4MFNTcnptOUFBaXQv?=
 =?utf-8?B?Z3pxL2k3V1p3KzZpYkNvTVA4ZytsSVplYVZrbjljWFMxTytjaFZIMFRENUFt?=
 =?utf-8?B?eEhMRmdQWTMxY2xJNWlXZUhtQTBJV2RMdllLZ0Q0SjRQSzNNL1kxN2J2M0FS?=
 =?utf-8?B?eDNvOXorT04zamRwQjNvdVVNczFzNnFWTmN0b3VycmdKYmtTR3JUSExkTUVU?=
 =?utf-8?B?Nm1YY0R4eW9TdjN6N1BFNUFtaFF1ckNoVi9malNKZEZ0NW5FRUpaSUtVWTRG?=
 =?utf-8?B?VmVvS0JxaVhIU2RPaEVpUkthNzhPa1dwSHZpa3QzTm93eXVEOTVjWkoxejhQ?=
 =?utf-8?B?WmNXWVYvTEUvanNEZk9oRUdGUGw1Qnh4YU9qNFVqaWRsZ1JMVEVXRDRXemJT?=
 =?utf-8?B?Yno2bm40azhlQ0FSb2wyeHFkZkJFaDBGVTcrc0FJTnFLMldEVHNPd3F5Snhr?=
 =?utf-8?B?eUNTOTI4NFFJaG04M0xxYm1XQ1VwdnR3amp6d0pqWVZiVmpodS9xTTdBazJq?=
 =?utf-8?B?SVUzMWZVZFVheGhpamtnbFMzTHNad1BCdjFVd08rQlUrTkFsMjZ6Uk9JNmFm?=
 =?utf-8?B?ZmMwVE5KYVFnVG1hNXdSVkhrT09LTkNuSlBhNkVUQzdoTXJ5VDBFOCtBSXhp?=
 =?utf-8?B?QUpUYjUxWW1ZeFFzZG1EOHIxVWI2NzFFUlJHMnk1VzBZRUllZFV4allYbzI2?=
 =?utf-8?B?M3AwN3RHNmxHcDk2RENpdDJCZ1c3RWQyZG56c2dkZWdLb1VVeWxIWDVXZ2du?=
 =?utf-8?B?bmdOYVBLSFl4a01CclNTc2lkZEQzNCtIb0M2N1hiQVY2MVVwR1Jxa1Bmc2Fh?=
 =?utf-8?B?V0tQVGlVT2tmQTI3RERWOThNcFN6YW5Rcnlrb3RCNUk5Y0licFBHZk5OUTlj?=
 =?utf-8?B?bC9LUnNUaFljRnFSelF3dkpKUXhZMWhmUE1oTVRkVGs0akJES2ZhM3N0K3Bz?=
 =?utf-8?B?SC83UHRnTDg5bXQ3WXZoYmJMT0dObjJrSmNHTkJzWDVDYjRySnBXc3ZmNW82?=
 =?utf-8?B?ZUt6OTFpYXduaFlBUUhxNTBBMldWUkJQVm1rdXVoS2k5RmZNZlk3LzVZSTRn?=
 =?utf-8?B?ak9Zb1VHV2pic2Q2Z005VXZzdk5ZdXlMTDc1S1dXLzNHZVh2L2RCYjllV25s?=
 =?utf-8?B?bktSNnF6a3dKbUQ3UWV5a3REZkRsZnVQeGJWV09JMVVabE91anRFU0IxZnoz?=
 =?utf-8?B?UXRmS0FKbVgyMk11L3VocFZqRFBGRGNJL3p0R2F2bys0dnZuRzVjWFUzbWZP?=
 =?utf-8?B?K25RTXBFTHh2N0JjUFRHUDVnakZ2Q01icmh4TlBXK1JEbFRtSlVNK0tiNUs1?=
 =?utf-8?B?a0xxK3N5eVJ2ZWJsN2drakJVcE5kci9DdXJRNzVKNExlcGJIYjR5eGtGTVlm?=
 =?utf-8?B?Vk01RHJUeVE5cG95bEN5VW5NOGxYeGZmSWs5clhqTEdvOERyaHBpV3hvaktL?=
 =?utf-8?B?allmOGZ3R2lCSm5UTGwxU283NlZnWGhiL09qTVRwQ2hpL1JIYStzaHhwdmd5?=
 =?utf-8?B?Y1ZuUWN3allQRWliZWRpN2RpcVFYSitrUXlBT09HSVR2TVVFVER2MHQrUWU4?=
 =?utf-8?Q?QuACqN6WepE8uGvBMkKQU/vfj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6534d447-c825-4750-1f47-08dcf0146f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 08:02:53.6515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGGnboxA+8A8pK2KvSRWsDklpUewn/OmZ0IWGdkIeifS2tHkQEco98TM+fvGeb0khzH9Rk5BGPfm6L5qqYDrUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8095
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
T24gMTAvMTYvMjAyNCA1OjMwIEFNLCBRaXV4dSBaaHVvIHdyb3RlOg0KPiA+IEZpeCB0aGUgZm9s
bG93aW5nIHR5cG9zIGluIGNvbW1lbnRzOg0KPiA+DQo+ID4gICBzL2NhbGxpbi9jYWxsaW5nLw0K
PiA+ICAgcy9UQkwvVExCLw0KPiA+DQo+IA0KPiBTYW1lIGFzIGJlZm9yZS4gVGhlIGV4YWN0IGNo
YW5nZSB3aXRoIGRldGFpbHMgZG9lc24ndCBuZWVkIHRvIGJlIGxpc3RlZCBvdXQNCj4gYWdhaW4g
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBJdCBjYW4gZWFzaWx5IGJlIG9ic2VydmVkIGZyb20gdGhl
IGRpZmYuDQoNClNhbWUgYXMgYmVmb3JlLiBXaWxsIHVwZGF0ZSBpdCBpbiB0aGUgbmV4dCB2ZXJz
aW9uLg0KDQotUWl1eHUNCg==

