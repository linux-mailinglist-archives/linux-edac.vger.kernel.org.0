Return-Path: <linux-edac+bounces-4491-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D9B18546
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 17:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46B71896B01
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67E27A927;
	Fri,  1 Aug 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnGDJHEu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F11D7E37;
	Fri,  1 Aug 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063481; cv=fail; b=SvTOzYFJ3Nb7YapKnJ/zPTCSYgaHrWECKgrOK75R/a+Tvb/L0IkmUinYot7leoXImKpDTeBJQohdHkKlV5IPDRGhO9scpmYwh1xFqq2MKcGnFVoivRIo8MFRxONhvW/xpmxGOR6GIQy9kdr8ft0hLaqGoby2kLKQ0I6Hr3mgMQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063481; c=relaxed/simple;
	bh=Y6BrLjp044d+hncq6bQhOT+F0wXgE9os31UROoZCp6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nGWpzHmIVtNweDeTFcuTChlJZfY6tmotlI+lLF5e3G53gSjnvRGUc7ncvqrWu3q6j96syC5SthmHQW7vVu0mSrQeEdEkLGv18vIvanBpXyyPAJBXuOVG/6NqwEF9ZxNVDn0wcQLxCKw5VwE5LLlykUWZ1s9/1WKumRnnxaXOi6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnGDJHEu; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754063480; x=1785599480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y6BrLjp044d+hncq6bQhOT+F0wXgE9os31UROoZCp6w=;
  b=JnGDJHEuAFiV7N5NwnlBLHwUDivYYwce+hy5VywouOaA0gs8VyU/sIO5
   eSFEwMPhmY9eMUqYgyrY0fmFh+cJTf2yVjfLM5Lp84OfH4oIY0BZ2PRK0
   L+sOYm3VL6hJ7T3QpAO6tXBQu2c9Z4s2cu4SPt5hUU9WvH+BfFqiz6fUH
   In2oylk2YQXwWKDqxwigDSNKWXeTIFHJ+jxH8oYTVULQyYmXmaUzFf9tu
   bNYgYs/dTbOvXl9CO83b8nDBRV5j+mVeWvqx8OwfqKEpnxEJuddDyR/1N
   GPwNzCErQGELrx926PWmSOi+1MwM90ThDWvB+gxnBc0Fw2eiSn5VYIQ1b
   g==;
X-CSE-ConnectionGUID: MgMtrRrpRZ6DFi9rkeSZMg==
X-CSE-MsgGUID: 5ANZTg16SDWEnrW5WG7/GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78967114"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="78967114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 08:51:15 -0700
X-CSE-ConnectionGUID: 67qthLFZT+27Hd5VjKe2mg==
X-CSE-MsgGUID: F9dLx+PVQkOpsLWr3TrPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="194554401"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 08:51:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:51:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 08:51:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj8Gju0lBn0Af2cyF7dHg1rhInzSuH1B/36RzVkeIbCNLonO+9tx4ro2YrJvpUoeXcs8blg5cnNyscpd6tP/z+qBVTmO/fmdl6tP8dwqfZdsK4pIjg3HjMisNDHiBovM2StIar4Cs5Ell8Z0kDFxU05svasxFrmQLFnN5l0P+bC53w0RKYPbr8l4ADfXdfpkA4LV89GjnJvf8ZaF9R5wSY2jVLHlIEMBoJqBUk1AlcTKwWksDJyAfmniqdJuVeqHLGLMXzuNa2pwiN2Mfd4fkg3mpD+yxgfH6/h/EsbXgP6/MEFxVS3K5LCnBZuh6r0Cn6kIO4LJxChRGyGnhMVw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUqFGC4Vrdea4RaPYvjnPbFVnwLxu3db9Xb2WDQuY88=;
 b=f6JQfdpJcfT7Aa46uBghV9iQs7kjlUHH+Zv7O8CgHjT/U9K9oGUDAKMJ1UTyx6gQxc5vjeiQdO3t1+vEm1wZzqN62wnwh/ShKvwUEBZbbP7x7bSGL+geHkNvzoejoQHwU0fGCV2F069LJHv/stNKv5Lsc/acYxtSPizE+0ZclYvekgfo/+1nrHDS5056OVU0FwJb92HGBpbC25qk9vobuULbech9N3LXGmZoHcGGFzjMJice/2bOSnm1PFQlHsuybg4AEh7KDk8y1cXIGvS4EquBxjsxvgFzomu8gp+5lS+/EK9/xV/3fPRrkQQlwZhJSHxJXFYwxLKNyoTdDNN7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 15:50:43 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%4]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 15:50:43 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Kyle Manna <kyle@kylemanna.com>, "Luck, Tony" <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Jason Baron <jbaron@akamai.com>
CC: James Jernigan <jameswestonjernigan@gmail.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC support
Thread-Topic: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC support
Thread-Index: AQHb/GafXcVlZ3WZRkiBtd6ukhBRJbRBVQ7ggADIQoCAC9vO0A==
Date: Fri, 1 Aug 2025 15:50:43 +0000
Message-ID: <SA1PR11MB71307A62016838428EAB52F58926A@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20250724064415.1134574-1-kyle@kylemanna.com>
 <CY8PR11MB7134484D663C31DA1544945B895EA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <e3bc0591-7ebf-4738-8848-599edd11c10d@app.fastmail.com>
In-Reply-To: <e3bc0591-7ebf-4738-8848-599edd11c10d@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|MW4PR11MB6715:EE_
x-ms-office365-filtering-correlation-id: a72f448e-bb43-427c-caef-08ddd1132c2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WataMUcaJsMKosH5H0cY5YwMMe2yc555HphyeQqcj3G3XCgHXQDqRcmuq+?=
 =?iso-8859-1?Q?QL3npHEXm/dNRoe3/0edsGldKRpELUhK3jzcAZyADIeTezWrSMCMpJ8EOZ?=
 =?iso-8859-1?Q?DxT6HtLiRGRKm6zWHMT8dYEIIuThNxaDvOkQCkHUT1zbhGlf8vX+fvSJNu?=
 =?iso-8859-1?Q?7F+jCli1O9xoEagMKr1M8KntHgtFigIX1xlG+wDtxbK8Y2+JHbH/BRG9Db?=
 =?iso-8859-1?Q?7jOdQJBn9rPzMFW9YyQm5+dbau3/8YufrphhLVUtykEk3NfTFE13JTJY4Q?=
 =?iso-8859-1?Q?xcqFLVyhA+Wc30PFj4z6pcl+eKV4HiVjElrizU9vup3w431CwSZz/2k5Zm?=
 =?iso-8859-1?Q?mOLwemsypQhfrnGbDQ/4dvgkQTsk0GdFEbutftk3BNqgwjsjbF8qVpbizM?=
 =?iso-8859-1?Q?uzsHt1N31WCIjwMca2fcbnCV+2kUTMowYcXgbpJKExD77IG+B1rDd6qbz+?=
 =?iso-8859-1?Q?4E9uuyQ4f4E2KWghPDB7d+f9Kvj/O4EC/mi5hoI2+JprS/5eysc1IMVACF?=
 =?iso-8859-1?Q?tMeHVZqTkerKZULaggw5ulnvcU6vSaFUnv7qrqipAsoc9X4tc4U1yyMb6V?=
 =?iso-8859-1?Q?7OMyR8fHvBkaSygswGU6KxmWN3B7sJAqJszWX8baCkTCds0b/inCrS7sP4?=
 =?iso-8859-1?Q?3ka9wf716fj+mA7sOaDBu9bkrewPFbBjiEqCGCY2HvU1f0HiZ5mGanr3Bx?=
 =?iso-8859-1?Q?QE4nwBsjgRSnvOHEENdI6YdEgWyQwc6lN0VavIW/BQL8k3cR6K8C44ur3A?=
 =?iso-8859-1?Q?280Tz6ubCERevKqGtCdOg4bimUgD4zlEH8JO4zmH75PVvIeL+IRyt8ZhJJ?=
 =?iso-8859-1?Q?fW0mgtnQj7ztvQmcjM5hDOB+viFnIhU7gN2CQdl3wOvAkShoyCooeLf+/2?=
 =?iso-8859-1?Q?hQcMgoZ7TZpTWEaoedUxzTSPYEbcwcKlz0aOHbSU3ffeIV4cjefPqucL1q?=
 =?iso-8859-1?Q?BJMo9RmWH0gM49J2PhAgJINE99jkxrxX5UXVm+BFN4zPzfW8O0kBtlzpW9?=
 =?iso-8859-1?Q?ikjX8GhmWP002ZjDDSOVznC0FefjBW74FhsK8wimhSl0TV3mDlhDfR05vN?=
 =?iso-8859-1?Q?B1jHNz1UFOG+saP/QzeM8uMZrVsDjg448ABm9kgqZRCM46DV2A787qFKKi?=
 =?iso-8859-1?Q?7pM5mXgt2jktAh/QzbMeQIi/xIuY4vYqTEE3DhrwOPpAZU4txhbVC147O1?=
 =?iso-8859-1?Q?Q6u7qmYB9oNXE98U9xcA2bD4t3HToCKqwTZbAZUTfgcBAGG7JfcvTzrf7c?=
 =?iso-8859-1?Q?2+zr6alO6m6sTuNrS+0IFlPKmQji0WfxkQaGidqGjxe2rdDBqwvano3Rbt?=
 =?iso-8859-1?Q?WJf864FaFZo6Xh1s0nmqxWrSVLDsKf2qHJ2g8uLPBVvLfOSUQC1RzKoVlc?=
 =?iso-8859-1?Q?wbCzWDGkuucnjjns4SGq4iWl+yCBf/W9JNs/4k2gVZd7gIfh7j+EA55RSU?=
 =?iso-8859-1?Q?uj/bEagzoq/73qj7ifgwfFM4hefo8TkSPOBZhErIU8EqmCCXQuejdjm+uf?=
 =?iso-8859-1?Q?nZjWe6AE6E6TsfmPfFJHUB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mSKKnzuImsPiOLQkY61Wzc8QadPplqU3miOxnWBGRQWZtbYX+9KOq22jmh?=
 =?iso-8859-1?Q?tSWV0EkR0B0bpOFm8ayKapr7tX/qIfLrMctQS/yqnEw0ACAiZO3pkuw45B?=
 =?iso-8859-1?Q?gJMRDiWzXlI+VnGiZ4XUNanxrPOAyTS5X98183Kbh+5qrMsKQlJ9Lpzj2u?=
 =?iso-8859-1?Q?FpvIMlGt1BtKAfCuLqaXb7ASbU3CkpKTPl8nPEScg1yhzgLMm7wFNWWXKy?=
 =?iso-8859-1?Q?UWynMBo5Op4ixCb03EGvYDsUkfQicdNoHiuTtfrYGVUKBbK6dduoLdxw1k?=
 =?iso-8859-1?Q?O4yuzCgtjNrd91+sgQKcvgLNr56dR3JMXK5qR0gC7QbO2dKvFNc2t2TUPh?=
 =?iso-8859-1?Q?Ck31oNt8tljGBWYGDpV8wIbmEugGY/2cO1Aud6uc4YOq1wBj04sIHP1ZFk?=
 =?iso-8859-1?Q?rwsnocXh6waWmNioAmVFgYznaj/m7VEy20mfB03nlkjWauZzmN5VLYnZO1?=
 =?iso-8859-1?Q?fUT/nT1WVTGSmhbNm2mtSIpA/FSRk66EfP6XCKsq94sbNkykDP5mQvtf5Z?=
 =?iso-8859-1?Q?lc+ynEVt0BJFlUwuU5MqA/g7id2/rC+UgLhlCbN6GI8kPdR73O2tMe3rAu?=
 =?iso-8859-1?Q?HL9ycmHGu48dvLhGnpdVy3E6lfzIzkhKg+N5KHOfoODrpvJsfP8vB/xxCo?=
 =?iso-8859-1?Q?XKWw5tc192n2t6u9KPPfmONzSfOSo3SRQkDPXqYn6Gv8BDq23YyIUA4/nK?=
 =?iso-8859-1?Q?MktD9S7LGZv22KpzB++Y3JQFuTN/SJcaufPsppOvWxL6/HvTO5w6xuRyF9?=
 =?iso-8859-1?Q?NuP+nAJhR4crPe4wGTbRI/zeFCIu3K/EbmWGtxHAXY/KO80nBxRCCoUKlk?=
 =?iso-8859-1?Q?aLja1nDYsp/oqbTz3qLEgiN4EBaCdUlNRmDovvUSnXFoQfunMiOuDDFCfG?=
 =?iso-8859-1?Q?EEty9ac36F4nxDLFHJ2rcIdLS/NAWUelVL/VH3pWFBPNmKHLPFcx/5R2Y+?=
 =?iso-8859-1?Q?yabQnMrIiHcDgwkG8FKo9w6YNxNeeDvu2EYNlU5QTLkHp6huK5WfOCwPuj?=
 =?iso-8859-1?Q?1tSpRCojTwGZUqs6RuS4uAoZiMEqc2YpI6zGgmJCAu0M9/TiCXrAZP64hq?=
 =?iso-8859-1?Q?kn1AMKlTO2brwrazz0B5HNcaf/VNRkzsr5/gxBYEzJia+v1liUWCexqMJe?=
 =?iso-8859-1?Q?yXAJYQSV/7LpZ+mxUHq8B7bPNTYYr0QIE2ajMkvfiVyTv8t3GZWCzyxoMw?=
 =?iso-8859-1?Q?7ElFNidAYyWzbDNPBiyemV9UjvMl64IheV+LbQdLs9tfF0SScTA801bKzL?=
 =?iso-8859-1?Q?vzZPsK3WQp12JukRtvvADQ+PfsERONU/1jMYQza1wMe+C4D2bVZHgrSPUS?=
 =?iso-8859-1?Q?3NkyNAJRXAyTPLLJBjH9DvbUaNvtLqXCHZAyMYSCqVppqXhwkBSLGzbgCe?=
 =?iso-8859-1?Q?szpb2Agjp3v4NGlJ2zH4sEKUzQg+q3A2r9ovW2ExddytCliWnXldnSdvAZ?=
 =?iso-8859-1?Q?V7r8l0ZiFF3rllKQICYpqGuKo0PKz9qMDm85/yNSBptoj00jZxzpQZu+O3?=
 =?iso-8859-1?Q?pdFVzw9acmFJv4hVPQF+TJXQ5CJBPvt2TZpDjrhXxC+vi1JPeIwdrARdhq?=
 =?iso-8859-1?Q?Y3ZzMF2PgfrJzXDNg0F7bCwP5MGj6VV5kyTFEI8I2Oh8E65Uwf8nD4j7Kf?=
 =?iso-8859-1?Q?CkfSUSBUTpZqLjHvZ7hp3lmQi14xS/jXOx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f448e-bb43-427c-caef-08ddd1132c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 15:50:43.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVippTzLYue0YA8+JmPO8FS6uWSiy4aU/LjurwDoqaH46Dr5nsxvWKnA9X6XYl9sO+BjhK+u9r3aDgvOQojnQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com

Hi Kyle,

> From: Kyle Manna <kyle@kylemanna.com>
>> [...]=20
> Hi Qiuxu,
>=20
> On Thu, Jul 24, 2025, at 07:31, Zhuo, Qiuxu wrote:
> > Do you have access to these machines to load the ie31200_edac driver
> > with your patch? If yes, would you take dmesg logs?
>=20
> I have access to a i5-12600K, here are the logs that I observed:
>=20
> $ dmesg | rg -i -e edac -e ecc -e ie31200 | rg -v systemd | rg edac
> [   14.379905] caller ie31200_init_one+0x1b5/0x480 [ie31200_edac] mapping
> multiple BARs
> [   14.382709] EDAC MC0: Giving out device to module ie31200_edac
> controller IE31200: DEV 0000:00:00.0 (INTERRUPT)
> [   14.383042] EDAC MC1: Giving out device to module ie31200_edac
> controller IE31200_1: DEV 0000:00:00.0 (INTERRUPT)
>=20
> I posted additional logs from sysfs and "ras-mc-ctl" here[0] after I lear=
ned that
> support was added for related processors as well as discussion with other
> users trying to get W680 + ECC working.
>=20
> [0] https://forums.servethehome.com/index.php?threads/intel-w680-ddr5-
> and-ecc-reporting.42559/#post-470425

Thanks for the logs.=20
Successfully loading the driver indicated the=A0i5-12600K is ECC capable.=20
=20
>=20
> >> diff --git a/drivers/edac/ie31200_edac.c
> >> b/drivers/edac/ie31200_edac.c index
> >> a53612be4b2f..2078c12bbed2 100644
> >> --- a/drivers/edac/ie31200_edac.c
> >> +++ b/drivers/edac/ie31200_edac.c
> >> @@ -94,6 +94,8 @@
> >>
> >>  /* Alder Lake-S */
> >>  #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
> >> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4668

Add a small comment, please.

+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4668 /* 6P+6E, e.g. i7-12700=
K */

> >> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3	0x4648

Ditto.
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3	0x4648 /* 6P+4E, e.g. i5-12600=
K */

> >>
> >
> > I didn't find the place in your spec above that indicates these two
> > CPUs with these two DIDs have Out-Of-Band ECC capabilities.
> > Could you point it out to me?
>=20
> This Intel CPU page[1] lists ECC memory support and the same on the Intel
> W680 chipset page[2]. The datasheet was used to confirm the DIDs[3] were
> valid.
>=20
> [1] https://www.intel.com/content/www/us/en/products/sku/134589/intel-
> core-i512600k-processor-20m-cache-up-to-4-90-ghz/specifications.html
> [2] https://www.intel.com/content/www/us/en/products/sku/218834/intel-
> w680-chipset/specifications.html
> [3] https://edc.intel.com/content/www/us/en/design/ipla/software-
> development-platforms/client/platforms/alder-lake-desktop/12th-generation=
-
> intel-core-processors-datasheet-volume-1-of-2/011/device-ids/
>=20
> Given that you added the i9-12900k (0x4660) in 180f091224a00 and I've
> personally verified the i5-12600k (0x4648) is working (see dmesg logs abo=
ve),
> I've added the i7-12700k (0x4668) to assist future users.

Thanks for the detailed specs and your verification.
Please add the comments after the new DIDs as mentioned above, other than t=
hat LGTM

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>=20

