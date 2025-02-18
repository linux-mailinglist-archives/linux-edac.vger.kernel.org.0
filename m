Return-Path: <linux-edac+bounces-3144-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99AA3A458
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFBE167E7E
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8601426F47F;
	Tue, 18 Feb 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqJoxFDx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E5191F99;
	Tue, 18 Feb 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899826; cv=fail; b=U5tj+SYdWtMji4u5RTaqaporDfgmbNCS99VV8q+0gGrF0vtrL9Cf6ZMASgaNjM0SaotqOmmcOPcG/n9WmghKt46ApBlsp2Qk9+y4gu6LP2ZPQt0cPLuOUPCIIrlMrX9p6IkixqTMTlrDCwSvyEddUxIh11YdOKbRnm0SmKj2vXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899826; c=relaxed/simple;
	bh=JrdoEjbhP45bApRpgqp2mMXiIoQjtIeYlg+ReYXUEyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CtEA9WIYYB2NKXpJmvyLA4C3WTODJQCFL0X3kXf89tt0zgy4N+WKO7qjKAUw5vJPTLlSMHYCaJoiiM0GWvUuU3wchiwY98RyxNrxJJNS7+jb5lHqVH8XBIzKF7EwGtmrClfI9+i3oFK9BJE3X77TBSRxgvZjV2hYt1iGRvJHaPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqJoxFDx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739899824; x=1771435824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JrdoEjbhP45bApRpgqp2mMXiIoQjtIeYlg+ReYXUEyA=;
  b=mqJoxFDxHmF6jy9j8g4Rv922mNofL6+snQd4sNO00aiGd0VRRjU4Oxnv
   cVr+jfLM2NnE1DaXiIMHeGSuQi4W9I5g83jxf/ue9Zy6AKKPMnZ1Ktiqy
   zwFrx2yda4G7YjyPLMPxrwnNdthqMJQp5cLhj/1doQirOs5IzYmp9M407
   dW8Pdf/9rsyezWmqOi5UCc+wijIUlCOPD3IHfTM0GZXWduOmf0NcNDv5o
   l39FWsZiWCK8PoqifMtcx5JVQ60ZXttBfmrOZqXziCyk+jDh1H1nciVkN
   mdofH6UCl8tjCXuef8Ivkj/o1YOZqvkZFjpQ3TDpxDQxNI9jkIAfXR/bk
   g==;
X-CSE-ConnectionGUID: P8NHAoISRfWG+xY1Yl/ChQ==
X-CSE-MsgGUID: fiA9z9ynSQOT72x1RCRjmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52039855"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52039855"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:30:23 -0800
X-CSE-ConnectionGUID: Q5XkvlQvQNaWx0y09XzVhg==
X-CSE-MsgGUID: 3J1LnO5AT9OiL34ZyXVhKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114931271"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:30:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 09:30:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 09:30:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 09:30:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k493EOojABOgzSwhilcQOPpcstbvYulEL9S5LSxhzM3rJxE5wa/wlW65Ao0RhA5QnRJePhzQ8uwhh+BeHVqPrUfQi8vEJjMYEysuUoiufl300UmZL1tCOaImmFm4eOaA4qd+MmTASzeLZpHGBkgHKEpvNjvG1lpa/aTTRPgnp5agBRpq06qB9DBDn/Y8yYDIkK5fIyNrNkM6mn2vavyAcctXrKUpH/lsReJmlJhh9V4+rO0SVD6WenT/jLYV760VOQybK7oYcyoid/swGlANbUwOXhUbed56WDwjJAEFK6M/XnzvNIiStOsQQYCzoQgXb7vlUTMEM49Xdna8HHPthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrdoEjbhP45bApRpgqp2mMXiIoQjtIeYlg+ReYXUEyA=;
 b=jbvkp2YWzZXcqFGOoh0IqEo8O6bsLDcIsjtrxF1yQlNfSAGsx5x5XjOoDggZEVwwehIbhNt2x7hAkYL9QDBP4HKajHyX53rJoc2MknpKN3vnCRxLZYmcZYgwt2Jq4QfR1MEK0cvjntVUebeSHn2jZAM1vc8po56aA13gXgqjUSPb2D+N7Ll/irBVxyBB5+yN6PUilMVtsP9NSrrr80a2wz/elAqGzgVEQYqhGXCOSkb5bgRCleEaZai07MfR672fr6IR8Q/faGpj9+P3280PzG90qSmBDNL9JsQ+8VMgXywNgOAsgT8Up2McX7Gl/BYvV8w7U5s5PnA1ifriCw6vLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 17:30:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:30:19 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Topic: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Index: AQHbgQXsd1SPCL4WjEygZkFauCaLrLNMu9aAgAAzcQCAAA67gIAATn3w
Date: Tue, 18 Feb 2025 17:30:19 +0000
Message-ID: <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
In-Reply-To: <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5955:EE_
x-ms-office365-filtering-correlation-id: 9f55a5d3-4796-4ec2-a438-08dd5041eab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEJ0WGZESTFmY2Uyak1SWjV2MzJhZjdZaEZsNkFheGtqYXhRMFRKOCsxS3do?=
 =?utf-8?B?cjNYdUd6TGRKc1dqVlUyY0xLcXlEdzNwajFodVRpOEZLTUlUWUlmK25rTVll?=
 =?utf-8?B?SkJCUnNJeFl1UkVLN2lFOENyVnYrblVseHpKdVdERHR2dXpyWmRYM2hLYUdU?=
 =?utf-8?B?aDdveStwNXRkUUc4ME5IM3lkSkxraFpBV3QwSnZxb0FMb3RvbTBPV05haGpM?=
 =?utf-8?B?UG1TMjBHQ1FmR1VvNW8rQU5hQ0F1RW5ZR0M1Q3lLODNCQmdVanZaamcxL0dH?=
 =?utf-8?B?VFhGeWNJWXRlVUlJQllBbFFPb0xSRmZFQTVHbkF1TExmLytnbnl6QWdhMVlX?=
 =?utf-8?B?VWpnUVJJK2JHVUQ2Sk81NmxYU2dHU0dLYysvczI2bmZiR0J0OFZsc0Z6c1Q1?=
 =?utf-8?B?NjN2U051N3ZVbzdiUGxoM0lDM01kNkRmaUlYaG9HYjNIc0lJR1dXU05XWXpT?=
 =?utf-8?B?VmtOMXN3OTRhWWZTdFh6Vm5KcnNMd2QwNXl0dW56OXZtampOOVVRRjA5eDNx?=
 =?utf-8?B?SE5lSVFTNkY3amIwOSt4anlnTFRCbFl0R29ZMkI1UFBubmV6UWdyaDdxTWdk?=
 =?utf-8?B?R3h5dU9pVmxIOHVodDZza0Z3SHhJbW5mdXg4QkhNSjVrS3BWYWxWS1Rwc3Zq?=
 =?utf-8?B?bjRYUVBXYWcyUExyMGNaREs0TnZhR2hYcTY4cnlsdHJ0bHUxTnVndmh6aTV2?=
 =?utf-8?B?KzBDSitzTFB5RHkybFA0dDJzVXBHN0pnL2I4V05qYlYyUCtTcWppNXFJMGcz?=
 =?utf-8?B?eWtLbjVxODFqL2w1MU5GQnlIZU0yeDhRR1ZFNEpJcHVsWlBVRUVLT1VsTHFR?=
 =?utf-8?B?WGNTZDVzbVRJSHR5VFlQOVBWT3h4WURQUGNvVnBzYmgwbUJYN3UvNXhpdlc2?=
 =?utf-8?B?ZGovVktCeFc1dXo0S3BKM3pFYm53N2p5R2lSdHRYZ1NsVDNHL0lpb3RPQ0Ux?=
 =?utf-8?B?SjJHb0tFQnd5emVqaFhwQ1dlN3NJbk12WTFkVWFZVGZlbjY5NUFSYWlrczhw?=
 =?utf-8?B?Z3dCVG5tNmFWZXpSeDQ3S0RQMmlvajBBaldGbEFVSzB3SnBLbklkbzgzRnNa?=
 =?utf-8?B?OEVJc0JQT1E5eWhyTWZKSUwvMG1XL1NQYll3dlZ3LzZoSm03Qy9JTDFtRWxL?=
 =?utf-8?B?UEVYcTh6aHZoTm1GQitDeWp4aHpDSE5SeWpDclQwVi9GMkptN3cwZFFwdjlI?=
 =?utf-8?B?YVNaaGlvbVJNRnV0dE4vTDVMMU03WlZsVko4eGd1b25tTC9ROG42RU9QdGcx?=
 =?utf-8?B?M0JHMURrayt4aWlwQWRRQjJvQVRxU1laM2R4cHJHR3loVkR4R01xSERFN0Vu?=
 =?utf-8?B?UzZYajBuUmF3dThRR0xKTk1WUXhtZXh0bXZydTdvYlUrUDByWXc1ZHI0aWxw?=
 =?utf-8?B?eUZWUXlkaldaWFhWNXQ5Vm82cW01c0o0UWRIR2poanVreEo0Rjg0SndPTGF4?=
 =?utf-8?B?ZkZydy8zOFEweDRQR0VBYXB5NTVmQmNXTVcrSjFUQzMwR3pQall0SWRCcCtK?=
 =?utf-8?B?MnFwWWg2QWNnT1VBclo1anBrSHI1MCs0OEE5N3ZodjcxVld0WmhzQjBDeXpK?=
 =?utf-8?B?VUlCNjJMQTZaTkRVN0VETGxKTEc1L0w2cXduSHYybDZPZHVweEVtQ1BTTFR6?=
 =?utf-8?B?NmUwdGFhZjFmT3lBSnpnQ2tlYjlxWDltdTRBUHMrdXQ5ZzErVkh4WkJLc0ZX?=
 =?utf-8?B?Yzdnd0dKRGZnS2xjeEViSjgrRlFlYmF2cVp6cTRoWU4vZnhkVDk1ZFZPYTdP?=
 =?utf-8?B?WjE4NWM1QU92WlgrY3dTRUhiVGZpTlg2T1A3YTNiS3JFY3dYU0dTTHZleGlL?=
 =?utf-8?B?UmRZbEkzbGJyNVVVZFRGcEdCOHdabnowSzVEK1NsbXVFN0tMMndYNllSMzBW?=
 =?utf-8?B?b01JV0paM2x0WENrTEQ0L0I5SlVoWEdPRE1uSGlXN2g1ZExpbjhlQXliVlJx?=
 =?utf-8?Q?1c0DlOoX1b+1NmHhiA3aY9nQfOUpqeeL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckxVUzBQa3VSSUhhY2ZVOHhjRjdMcjZvRHJTR1R4cVl2cVhQczh5dFVONTBj?=
 =?utf-8?B?aEQ3Y3gxQnZPd3ArSWlhZk1NWHgxempvYzdXcEtvSGJUVUkzeVdMTEdheDJk?=
 =?utf-8?B?TUxvV3dpV2RNQjk5WlIraHU5N2swZkw1anFaalhWaUs0VlRyRHVrZE50K2Rp?=
 =?utf-8?B?NEhRSWhYTURUR2Rud1NWbkpKb01RcnpoMk5oK1UvUXkrak9iUzg4eFUyNEk4?=
 =?utf-8?B?OXg2YVUxWDFzWEhzd1VrUXgzMTg0QjdqRDVidFdLQ2pLVXBWNzFwVmlMWnZx?=
 =?utf-8?B?VjIwSWpKUFlvSjBmYStFVXJhZWY0QWpiaURVaXE4aUFsTk44UG42K0RRaXNB?=
 =?utf-8?B?Nm1tNEJjUkprVkFEUHB3aFhJY2hDQWRZaWxlemxTZ2pSM0doQkpGVnlMTEtr?=
 =?utf-8?B?M0lTb1FTaEsvdDhtOExnbExNZGxyUHpac1VmdUEwbll2WFNFeUszQktWNWNs?=
 =?utf-8?B?VFJTc2hML1A1M1B4ZDFZaHRyeUhrZHhBeTFuY3BMVEZ4cUZBVXp1MlFjYzZX?=
 =?utf-8?B?WitqbWwydi9HSmRCMDJ3UFlYYXdYNGpzT2s2Zzg3Q2ZqYVU2WWgwTWFJMWoz?=
 =?utf-8?B?MEV3cGpTRjYrUWVxQ2gyRVlEMDBwRkVBTHc0MnlHcE5tbURXOUNrRjY2Ymg4?=
 =?utf-8?B?TzBkNVhxR3BpMUZ4OEd0SmZPRGprQ2hLQnZHWGVnT3pYUURQd1dEaHpnNmF2?=
 =?utf-8?B?a0F1SnhHVlRyeC9jZmhkV0UvZE1HUDNVaTRoVjE1RmFqODVHM3hHYlhVSTk1?=
 =?utf-8?B?cFREaks2d3B4L1VlMXN0bjdnUFZuVUVKclF6TUZtdm8yOFdwSXdEK1c0Q2dZ?=
 =?utf-8?B?NEhtUXU1VGg1L2tiMWJnelJ5NDZNdWlTYjJuRnNPWHhuQ1I2SVU3T1laN1V3?=
 =?utf-8?B?Ylg2bTFOVFg5KzkzSERndGZod1JWWnR5T2R6WjB4OWJQL3A4aHdjenBCVVlE?=
 =?utf-8?B?dmJNVEJFNHRSdXBJZzlFWExKeHFZVDVWMmFJTXVvR1kxUy9OdnVCQ3kvUnJv?=
 =?utf-8?B?WHp4WUxMMSsveXJpWVJUZVdUUzFFeVY2bVYzOC9yMU9wako5S3JOT050UWFo?=
 =?utf-8?B?MUw1dW9QSkkyVFU0RU9YQkQwVDZJa1lURWQ5TExqYTUyTjM5UWpFOENnMEFK?=
 =?utf-8?B?WlU0UjBnSW8wNXBqQWVyRXR1dXl5K3FpN1Z3d0R0TTVFdUFBVmEvSDF0bC8y?=
 =?utf-8?B?VW55cVdxL0lXaXIwdzhmYysyclZOWXhXaGxTSjZWRnRlR3BrNjZ3elZtOTZB?=
 =?utf-8?B?T0JEYVBjK2hOUVQ3c1VKSHlEdTNmVHlKNGkwMjZKUzVkU1IzemQ2K1lTK0JH?=
 =?utf-8?B?SFVLV2ZSWGJvdDBUTzVqUnpLUmh3b1BTOENobU1RdFFaTFg5dUxZUEhjQ1Jh?=
 =?utf-8?B?ekdzcjBPd2FCeVBVbC9sbjNhV05zRjg2MGVXZHRyd0JwbEdXK0VNVmxFSGps?=
 =?utf-8?B?eEZzQUtDZUkxNm5ZV091UEx6alp5MHBVV0daNEI2RkpDc1pTNUd2dFpiWCtp?=
 =?utf-8?B?Sk42S1hVNHQxVFlQdGh0YmplUHJVT2RHTlYyQk5QT24vcUQxZzE0RlhyeXoz?=
 =?utf-8?B?VHNReW1Ra0E2YW5uYUpkektMQkV4RDJBL1lqOTlLd3hUZUIzRmRyWnFYQy9u?=
 =?utf-8?B?Q3hsSFhMTlZiVmoraWhFTkJTK0RFdTdGa3NINkxka05wMHo5SjRRM1NuNjMw?=
 =?utf-8?B?dWhvZkw2SUljM2F2NVdoN3hNMnJpbTJQRm41ZkczR2xXUXRxbExqZndyQTdy?=
 =?utf-8?B?R1NnOVJ2akhFWitaT2g0VmlzNjhxQXljaHZMeTIvT215KzF1bTNtb21tcDV3?=
 =?utf-8?B?cHZwc2Q3ZUVCOEtWcVJXbjk1clRKYUR0VXNURTZEZnJaU0o4MjdTUDh6ajBm?=
 =?utf-8?B?OW43UWw5QXpKVm50SEFYUldqeUhtaFQ2OWxBekFRQUhHVGJQRDVERHRQdkRY?=
 =?utf-8?B?V1hZOHJUZEova1VaK0ZEekhFdUNzVW05ZUQ1Q0d5OXRVYjIwNHNLSG5BeDEv?=
 =?utf-8?B?Vnh4dXlYQTlKTnVPTE5QVy9TQy9GSkJUY2JFT3BPMjR2eWljV3h3NDVWcldr?=
 =?utf-8?B?VUIyaFJyN3NhS0pYbWtYQ3dJTlZ0SkREQXdITklLSXZvSDNYU1R5MUwvYklT?=
 =?utf-8?Q?GY5Fy6fTT+PZ6zxDe1kSOyWhe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55a5d3-4796-4ec2-a438-08dd5041eab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 17:30:19.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGgxqwIhLKc/4XJMYv3zTN3un8Uea6TKAr3FqJYtoGXjOvED9/66HWQKsQ+VotMOlawxSZnuX8uIkWoiyglyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com

PiA+IEZvciBpbnN0ciBjYXNlOiB1c2VyIHByb2Nlc3MgaXMga2lsbGVkIGJ5IGEgU0lHQlVTIHNp
Z25hbA0KPiA+DQo+ID4gQ29tbWl0IDA0NjU0NWE2NjFhZiAoIm1tL2h3cG9pc29uOiBmaXggZXJy
b3IgcGFnZSByZWNvdmVyZWQgYnV0IHJlcG9ydGVkICJub3QNCj4gPiByZWNvdmVyZWQiIikgaW50
cm9kdWNlZCBhIGJ1ZyB0aGF0IGtpbGxfYWNjZXNzaW5nX3Byb2Nlc3MoKSByZXR1cm4gLUVIV1BP
SVNPTg0KPiA+IGZvciBpbnN0ciBjYXNlLCBhcyByZXN1bHQsIGtpbGxfbWVfbWF5YmUoKSBzZW5k
IGEgU0lHQlVTIHRvIHVzZXIgcHJvY2Vzcy4NCj4NCj4gVGhpcyBtYWtlcyBteSBoZWFkIGh1cnQu
Li4gYSByYWNlIGJldHdlZW4gdGhlIENNQ0kgcmVwb3J0aW5nIGFuIHVuY29ycmVjdGVkDQo+IGVy
cm9yLi4uIHdoeSBkb2VzIHRoZSBDTUNJIHJlcG9ydCB1bmNvcnJlY3RlZCBlcnJvcnM/IFRoaXMg
c291bmRzIGxpa2Ugc29tZQ0KPiBuYXN0eSBjb25mdXNpb24uDQoNCk15IGhlYWQgaHVydHMgdG9v
LiBUaGUgcHJvYmxlbSBpcyB0aGUgZXZvbHV0aW9uIGFuZCBzdWJzZXF1ZW50IG92ZXJsb2FkaW5n
IG9mDQpsaW1pdGVkIHNpZ25hbCBvcHRpb25zIGluIEludGVsIGVycm9yIHJlcG9ydGluZy4NCg0K
UHJpb3IgdG8gSWNlbGFrZSBtZW1vcnkgY29udHJvbGxlcnMgcmVwb3J0ZWQgcGF0cm9sIHNjcnVi
IGV2ZW50cyB0aGF0IGRldGVjdGVkDQphIHByZXZpb3VzbHkgdW5zZWVuIHVuY29ycmVjdGVkIGVy
cm9yIGluIG1lbW9yeSBieSBzaWduYWxpbmcgYSBicm9hZGNhc3QNCm1hY2hpbmUgY2hlY2sgd2l0
aCBhbiBTUkFPIChTb2Z0d2FyZSBSZWNvdmVyYWJsZSBBY3Rpb24gT3B0aW9uYWwpIHNpZ25hdHVy
ZQ0KaW4gdGhlIG1hY2hpbmUgY2hlY2sgYmFuay4NCg0KVGhpcyB3YXMgb3ZlcmtpbGwuIEl0J3Mg
bm90IGFuIHVyZ2VudCBwcm9ibGVtLiBObyBjb3JlIGlzIG9uIHRoZSB2ZXJnZSBvZiBjb25zdW1p
bmcNCnRoYXQgYmFkIGRhdGEuDQoNCkJ1dCB0aGUgZml4IGNhdXNlcyB0aGUgY29uZnVzaW9uLiBU
aGUgbWFjaGluZSBjaGVjayBiYW5rIHNpZ25hdHVyZSB3YXMgY2hhbmdlZA0KdG8gVUNOQSAoVW5j
b3JyZWN0ZWQsIE5vIEFjdGlvbiByZXF1aXJlZCksIGFuZCBzaWduYWwgY2hhbmdlZCB0byAjQ01D
SSAoc2luY2UNCnRoYXQgd2FzIHRoZSBvbmx5IG9wdGlvbiBhdmFpbGFibGUgaW4gdGhlIHRvb2xi
b3ggOi0oDQoNClRoYXQncyBob3cgd2UgZW5kZWQgdXAgd2l0aCAqVU4qY29ycmVjdGVkIGVycm9y
cyB0aWVkIHRvICpDKk1DSS4NCg0KSnVzdCB0byBhZGQgdG8gdGhlIGNvbmZ1c2lvbiwgTGludXgg
ZG9lcyB0YWtlIGFuIGFjdGlvbiAoaW4gdWNfZGVjb2RlX25vdGlmaWVyKCkpDQp0byB0cnkgdG8g
b2ZmbGluZSB0aGUgcGFnZSBkZXNwaXRlIHRoZSBVQypOQSogc2lnbmF0dXJlIG5hbWUuDQoNCj4g
QW5kIHlvdSd2ZSBiYXNpY2FsbHkgcmV1c2VkIHRoZSBmb3JtYXQgYW5kIHdvcmRpbmcgb2YgMDQ2
NTQ1YTY2MWFmIGZvciB5b3VyDQo+IGNvbW1pdCBtZXNzYWdlIGFuZCBtYWtlcyBzdGFyaW5nIGF0
IHRob3NlIGEgUElUQS4NCj4NCj4gVG9ueSwgd2hhdCdzIGdvaW5nIG9uIHdpdGggdGhhdCBDTUNJ
IGFuZCBTUkFSIHJhY2U/DQoNCk5vdyB0aGUgcmFjZSAuLi4gaGF2aW5nIGRlY2lkZWQgdGhhdCBD
TUNJL1VDTkEgaXMgdGhlIGJlc3QgYWN0aW9uIGZvciBwYXRyb2wNCnNjcnViIGVycm9ycywgdGhl
IG1lbW9yeSBjb250cm9sbGVyIHVzZXMgaXQgZm9yIHJlYWRzIHRvby4gQnV0IHRoZSBtZW1vcnkg
Y29udHJvbGxlcg0KaXMgZXhlY3V0aW5nIGFzeW5jaHJvbm91c2x5IGZyb20gdGhlIGNvcmUsIGFu
ZCBjYW4ndCB0ZWxsIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gYQ0KInJlYWwiIHJlYWQgYW5kIGEg
c3BlY3VsYXRpdmUgcmVhZC4gU28gaXQgd2lsbCBkbyBDTUNJL1VDTkEgaWYgYW4gZXJyb3IgaXMg
Zm91bmQgaW4NCmFueSByZWFkLg0KDQpUaHVzOg0KDQoxKSBDb3JlIGlzIGNsZXZlciBhbmQgdGhp
bmtzIGFkZHJlc3MgQSBpcyBuZWVkZWQgc29vbiwgaXNzdWVzIGEgc3BlY3VsYXRpdmUgcmVhZC4N
CjIpIENvcmUgZmluZHMgaXQgaXMgZ29pbmcgdG8gdXNlIGFkZHJlc3MgQSBzb29uIGFmdGVyIHNl
bmRpbmcgdGhlIHJlYWQgcmVxdWVzdA0KMykgVGhlIENNQ0kgZnJvbSB0aGUgbWVtb3J5IGNvbnRy
b2xsZXIgaXMgaW4gYSByYWNlIHdpdGggdGhlIGNvcmUgdGhhdCB3aWxsIHNvb24gdHJ5IHRvIHJl
dGlyZSB0aGUgbG9hZCBmcm9tIGFkZHJlc3MgQS4NCg0KUXVpdGUgb2Z0ZW4gKGJlY2F1c2Ugc3Bl
Y3VsYXRpb24gaGFzIGdvdCBiZXR0ZXIpIHRoZSBDTUNJIGZyb20gdGhlIG1lbW9yeSBjb250cm9s
bGVyDQppcyBkZWxpdmVyZWQgYmVmb3JlIHRoZSBjb3JlIGlzIGNvbW1pdHRlZCB0byB0aGUgaW5z
dHJ1Y3Rpb24gcmVhZGluZyBhZGRyZXNzIEEsIHNvIHRoZQ0KaW50ZXJydXB0IGlzIHRha2VuLCBh
bmQgTGludXggb2ZmbGluZXMgdGhlIHBhZ2UgKG1hcmtpbmcgaXQgYXMgcG9pc29uKS4NCg0KV2hl
biB0aGUgaW50ZXJydXB0IHJldHVybnMsIHRoZSBjb3JlIGdldHMgdG8gdGhlIGxvYWQgaW5zdHJ1
Y3Rpb24sIGFuZCBnZXRzIGEgI1BGIGJlY2F1c2UNCnRoZSBvZmZsaW5lIHByb2Nlc3MgbWFya2Vk
IHRoZSBwYWdlIG5vdC1wcmVzZW50IGFuZCBmbHVzaGVkIHRoZSBUTEIuDQoNCkZpbmFsbHkgdGhl
ICNQRiBoYW5kbGVyIHRyaWVzIHRvIGZpeCB0aGUgcGFnZSBmYXVsdCwgc2VlcyB0aGF0IHBhZ2Ug
aXMgbWFya2VkIGFzIHBvaXNvbg0Kc28gc2VuZHMgU0lHQlVTIHRvIHRoZSBwcm9jZXNzLg0KDQpO
b3RlLCBBTUQgbWlnaHQgaGF2ZSBhIHNpbWlsYXIgcmFjZSB3aXRoIHRoZSBNQ0VfREVGRVJSRURf
U0VWRVJJVFkgc2lnbmFsPw0KKGJ1dCB3aXRoIGxlc3MgY29uZnVzaW5nIG5hbWluZykuDQoNCi1U
b255DQo=

