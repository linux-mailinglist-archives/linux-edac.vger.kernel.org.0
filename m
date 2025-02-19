Return-Path: <linux-edac+bounces-3162-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137DA3C674
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9D47A3290
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E3214219;
	Wed, 19 Feb 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUcX1AzN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26087A944;
	Wed, 19 Feb 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987067; cv=fail; b=FhfXpvdLgbPGi8hq7M0vmU9mjhmXoxP7WtkRAk6Q28Mp+NwQ0BSKGWq5hz9rT0GbY1LE+ETONc2GlSVoyKzSfsd1LOZeqY/zAJHOnJ/y5zTgu1O75AO0tmxd+8NOWarzmag/tlzBaTs1lnE/5wlE82/2wJ5sBbqo4AO1YeqF21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987067; c=relaxed/simple;
	bh=270FKZueewluMOtunA4s8efRoYTvV/d9aGXMrkKA9Ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrjmvrM3vR9MP90iOtALTcvyKJ1BR2DCzFc5yCQwLappFEG+aSQJTPa29AqXDTZRCJ6pWVvcUfo5Gw5jQWZxLwB1kTmhVsxIWPdKzHmEPiw4ajcCc1G3tBPmr7DrDdiDNQCGKfM/7ZdFzkdhUl/m7JPa2lvtd3y1qQKLvJMSFa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUcX1AzN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987066; x=1771523066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=270FKZueewluMOtunA4s8efRoYTvV/d9aGXMrkKA9Ro=;
  b=EUcX1AzNsPWnjOIs4FUXFR3h8T6MNrnNKuCeieCyC9zrzWSxSN92D625
   lk3LsHRHRrRAVDbTlBuy/ZkB2nJ2QKjFaduNP2lw5wTbUgc3dNm6tF3KO
   sjJHoLNhy5nxdl2X14evOgcHPSt+IPFZSsAwqBxz4AUHyEtKDCODmAxHi
   QyQtLSKXwJf84pBZgXTEwZ/qpq3FgSLhGeL4wp1n4iTeyUzYKc2YtquFP
   CvHSp4mFNILfEvYX01MmpVCGXXGQXVFUyl+IycQ+zUe64CZ1VABJk6N6t
   bgbmlO4W0Et2iHuxFzQUd1F4poGRrexWoMaYsf1LTChKAsz5Vv50JOXuZ
   w==;
X-CSE-ConnectionGUID: lm2jhWE3R9W6JOz7VX6qfQ==
X-CSE-MsgGUID: tOaUAQ9kTR6I1Cg+hgPYEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66094245"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="66094245"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:44:25 -0800
X-CSE-ConnectionGUID: G6QYcfFdTvCktH7XivRYMw==
X-CSE-MsgGUID: lkDnVODkQhWiOz2Hwo5c5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114516580"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:16:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 09:16:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 09:16:29 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 09:16:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJWYUTewFe0GVJIckxVgPT4ecgo6HEANS3MvcZUsEvf8PnyqjKR0lTiTfAq5K5CwnfH9YuswQskW25YpQ26d08CwL/umNMo7DVGNi4djdMGwb92uxmwK+8d21qe81tcnKIyCO/x3hZjdEXb44EwBGZ+wB3CPi7sXoBsl0ZE3F7PTTuwG4MNvQZYrs/OcJWhBQQBdSZqAGoSkNKF+O9PG9NAWPLugS4HPvuxohA26FYoCQSWurtSNjdcajZ0QB84O0tyIik2+SIjAVbqwuBALovunGe7qdp23ppSLv5pe4Dsb7oHKIOfaSVlFJaFLZ5H5Z2XOBmLZ5Id6Cos/jCSikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=270FKZueewluMOtunA4s8efRoYTvV/d9aGXMrkKA9Ro=;
 b=GpwbX4/u9EkAsK8308qpHojCFLYdjCbFMYg2771x8qFMvkXP3QjVqnPur0BdQr1ZI9zGVXYQkjMrWzX4i0RTvpGaNyD7Nf0DLuWFp5fqPnaJtrSLR+tC3InbnIBoFbGnmgBu4QotVB86CVwSYPeN5FaTWOqIQJSefj52kVyL369d/D1G1npQ25Dtt29FnHdjTknfYeu3dSDJ3gclaIm6LMIzUxWfj575Uc/vTjI/xe8Phw6NkvPBVPP2lwvr67NBffiiDbRxOYG/7/bWLPTZKa/FmTuklJTHj3z6mC1HRxbdswzWfKHlsWjgALL6GSE8I8MGC3deiB4t0z+eddSzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 17:15:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:15:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Miaohe Lin <linmiaohe@huawei.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>,
	"bp@alien8.de" <bp@alien8.de>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>
Subject: RE: [PATCH v2 4/5] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
Thread-Topic: [PATCH v2 4/5] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
Thread-Index: AQHbgQXqknHuofGPgUGBTzisw8EteLNOLrQAgAAm8wCAAIuSIA==
Date: Wed, 19 Feb 2025 17:15:37 +0000
Message-ID: <SJ1PR11MB608384612B78AF0D65ECC545FCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-5-xueshuai@linux.alibaba.com>
 <ddd769c2-a17d-9e34-822d-66f72bd654ac@huawei.com>
 <be78641b-becc-4cdb-a90e-574734638869@linux.alibaba.com>
In-Reply-To: <be78641b-becc-4cdb-a90e-574734638869@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7190:EE_
x-ms-office365-filtering-correlation-id: 27e9c04f-fa31-4e2f-a47c-08dd51090763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzV2WStsUFV4dk9ha0JUdFFTWHY4cUtpOTNxRVBmNUg5dXVsOFNtV2RlcHlu?=
 =?utf-8?B?SlhOWDdUdlhrZXVZNmtOakhicDRCUDd2elNiNS9YU2EyZ0lFa1NZb3k5NG1z?=
 =?utf-8?B?T2FqcFRxaTRtL2RTRU9nUVRsOENwL01ZWlAzSG1kRmJadzZwZWpnZHYrYTFw?=
 =?utf-8?B?VWE0R3AxVHovVmRLQnJUL1lDVlI0VXprbTZzZTVQdE9OQkIxMkZyU2FyNDZX?=
 =?utf-8?B?aW1YSlZraDBzV1dEblRMcW5TR0NxOFZJWmR2U1RZUWhOS09sQVV1eXYxOE8x?=
 =?utf-8?B?aFhJQzUyUmdMd242dmF0SVFydXZNZW83LzFPS1M5UVpFVjFJUGhoRlpwYnk4?=
 =?utf-8?B?NmsyOEF2eFZWU3ZRY2U0MHR2ZU95djJMZ3dPdDhFOHZHYmRSWktxeTg5RUlO?=
 =?utf-8?B?TlhFQkFlcWVSU1pvdzJ5dGgzcjNrSER1azBSVkFpTzRrMEZWR3FGVmtGWkdB?=
 =?utf-8?B?VVNFZ3pRaDF0TVR0UGtYMXBYYVA0eTI3MXFVTDlacWZGNU0wQnVrUk5rUjEv?=
 =?utf-8?B?M1FieWI1ZFlwMWhNajFuaTVIREY3RTlBaEhvYkhMQ28xNXVEVGFYZDNQVzNa?=
 =?utf-8?B?YWhRajJDMkRHK3JzbUxKQjhHeHRsaXY3N01GU01SbnRCa01Nb0VGdWdUUmxU?=
 =?utf-8?B?c2h6MGRuWDhGYXNPemRUd0pSVzNvMmFsT2dFVzRObkdqcjVYNkhIVWJjT2tB?=
 =?utf-8?B?L2ErNjdKc2o3aVZySXZQVStJUUJMdjU0dnRqamZRc3huSUpZUWtPcFJYRG5H?=
 =?utf-8?B?V1A0UVdBUGlCQjBmK3pRUzQ1WVNsVnEvSzFVaDVQOW8wNzdadDRMcDNoVlQz?=
 =?utf-8?B?TWJsdUZSVGZydFNTRlY2WWhGZjhmVWJ5ZS9NYjNpRGpaWXgzL25ZeEtlR1pR?=
 =?utf-8?B?ZnFNYy9scDQvT002YjNEMzBSMG55bWFlREd4bjM2cFVqcDE1Y2lkR3VjdzFL?=
 =?utf-8?B?c0NmbVA4Y3NDTGREOG5GcC9admdlRHJEb3JwZFEyczQ1VXRsWElzbTZ3dHAw?=
 =?utf-8?B?VjgvbkFubzBaejFVSTRYUXNUQ2hTVjVhOURhSk9HOU1rd2lxdUlGZUJtN3lG?=
 =?utf-8?B?UGZyTjIzQzVEWjVGVE5TUTVqWmQ4TVUvVmxkTlNHRnhFMEJxT2JKTm4ydzhr?=
 =?utf-8?B?MWVPOXh6czFqN05zbmtBVFc4WE1WVzhMSDU3ODdFSGRuTTQ0aVVyZVAvRFkz?=
 =?utf-8?B?TXNqbEI0dVU5WWxKKzFRdm1icFRsSHNpVnlNMWwwZUd5ZUw0MkRJSTE3ZkZH?=
 =?utf-8?B?blBQTThPeFpHdHZHOXhOWkphVm5RdWpDc1pXVWVna0lrVStzVkNPSGlGZm1X?=
 =?utf-8?B?b0NwditNaDFWU2dlMDA1Ziswc0xGelhIbi9ZblowVW1kclh0T1kwY0F4R3dX?=
 =?utf-8?B?V3BmQnFyUDdMK0xKY3NMT0JCcGw1aTVRWncwZEU2Q0JySHk1eVNuTzd2aGFn?=
 =?utf-8?B?aHhtSU1qWjVPZ1N5VmNobjIzVzFjcVJ3WHEweEswTzh6UWNsdDJvMkE5eHFH?=
 =?utf-8?B?a1BldElhUmp3OER0UHQ1aFBCVEJlYU9TdDVEOVdqNTN0aDZqdzlsdjNraUJN?=
 =?utf-8?B?a3dvVTE0V1kxODBCaFhMaXI3emFrbkV4WmFiRGlRdTRyaWxDREVHaTJHODZj?=
 =?utf-8?B?bVNId0J5QnFBTjV4NXJnVG12cExXelVlUi90UHlmcUhoODR1ckdJVjVwQU5T?=
 =?utf-8?B?MnB4dG41T0piN1JnUHdGcEh3UGM0REY0L3E3YjBSYllrY0N2UG9JdkVjRUlo?=
 =?utf-8?B?dWdZSm9uR0gzT3dmSzUvOUJQb25qQndCWW1UWjRBRkFSUFR1SkZoMmNaUWN0?=
 =?utf-8?B?dXhkdjNiSnkzR1o0MVBVNzBKVGYzMjlHN0FEMmkzWjJwc0pWRE5rSmhSV2pt?=
 =?utf-8?B?VVlPYnl4VTNPajdsRENBK0Y5TmxKS0ZCcXFpRzVvMityaHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFdqWE9ybm15S2JGRU9xNnBxWFVqR1NMbXhteEVlRkN5clZ3c1M3SjhvWk5z?=
 =?utf-8?B?TTdEeEI4VC9OL3ZkNlhRVlpqU2sxVzR4UkloU25wejJqRkpERjFYOWdycHpx?=
 =?utf-8?B?SHk3MTBDY1VuRlE3dGRzaXRGdFpzaUY0azJ4VG1pV1U3R04xSmREN3NUSlVt?=
 =?utf-8?B?K1NpYlhnOHNLa1NuSlo0ZFBZN3kzbHAwNS9pQ2dvWkpDK2p4WTdZY0ZrR0VQ?=
 =?utf-8?B?WDJIVDRzVkdXM0NSM0E1TDA2emh6OVlnemU5eTYrSDducE5NeDdwcnBSb04r?=
 =?utf-8?B?Y1E3Rks2SUpINUZVY29RZHZqUVVNenJDNkxvT3I1b3BzUjBUK2ZiOTZaRk5m?=
 =?utf-8?B?ak5QM0VMS3d3L2hLMStTb2dya0xRdW1qMHhiUExoZzR2L2FLVkZUUGRLdW9F?=
 =?utf-8?B?Y3JscXRoNGg0N044cHNZc3N6TlhYYXpFSHRaMTRQUGNWejdOemUvZnNXbG5W?=
 =?utf-8?B?ZFd4UHZUbE5qeGVyMkhNSy8rU3cwNGhSenBHejdmSzNOU21iZnkyTjZldmdh?=
 =?utf-8?B?bTU0U3JSQlQybHB0bGNkVHEwMlAzR1NwaVFjc1FEMXVrV0x4NVVzUGluTUtq?=
 =?utf-8?B?NURrd0dYVnVURFlWYWxqcGlONDBzWS9STnF5WVQyK3VQNCtqOCs0akI2azlp?=
 =?utf-8?B?M0hOMlUwT3ZOU3J4RVFCK2dzRWxiejBZc2xYUDJTVlRhSzhFOUp0L1hCajU2?=
 =?utf-8?B?ejVLd3ovc25oMmt4Z3A2dHhBNFR1YzdYWWhUYldHbEE0RjJMMjNMRWRuR2Ni?=
 =?utf-8?B?TE5vYUV4dFFONXFYY25hU3E5MW9IclF3N3Bkd04ycXRJUUU3ZzBTbjYwMlpo?=
 =?utf-8?B?d0k3SmpFQ2ZYVldla3FsU0hWeFhHM01EZnJ6NzE0a3FMS05JREVqbnhPUDdH?=
 =?utf-8?B?Vy9aQ2ZjYnJ4L2lram9IM0x3MTNhdzZMZnlQVERUY0xiTklQYjNXSzM4Wi9v?=
 =?utf-8?B?bVhhRWo4WTBLUExROGxlYUR6TktjWDFRQlRoYnZ4ZHVGZlptUXRaV0JIMmRV?=
 =?utf-8?B?N2ZYYnlFY3MxaFg2WkcwU1lWL3JwK0NHT1ZpSUdxcWxTWWhQVWpGWTY4L1l0?=
 =?utf-8?B?UGdXcHhod2YwQ2cwSDdFWUxFemRUcTlmejRLemNFLzhjSHVFSHcwSmY0ZFFF?=
 =?utf-8?B?T1J4MGtXL1VRUmE4c3lvd1h3NGF2YlRidmNjVFA2ajc0aUt2UGlRdVJXcEtO?=
 =?utf-8?B?NDcyUG54Vjdoa2pBR1B2UmRhL3c4aVBiQ1pkSkxUSWxKbEZOYXJUajVKaHMz?=
 =?utf-8?B?dkZvUnhqcklxUDJDQjVDdjIzb1Y5ZW1ESHZzeTlOMGtqTmxheEt0MGFSOERz?=
 =?utf-8?B?NWpmckdtMFNtdWthdVQwM25xbGJsV1FsVWxySG9ndnZRd0xneGx3dTdtdlFp?=
 =?utf-8?B?SUs1OVZYbVpOMVFORFh6aXdGVndMeWx5allDalllS2J5VzZhZ0cvbkJzaHU5?=
 =?utf-8?B?WTlxMVhtT1VKcUpCenNNSFFaWkt0d2J5cFBkWVFFM2NWbUhwNDdpdzJiT1V2?=
 =?utf-8?B?RXloWHQ3SkZoOVdDU2RHSVVxWW5IT0RJWUtOaTk3MVBnTGNqUFRxQzN2N3Q2?=
 =?utf-8?B?R0VYalBjK2dQd1Rpd1V2elRucWtSQ2w1aHp0VmZHWG9XWktMRXJOVHF0VERH?=
 =?utf-8?B?M1BnTE9BL2JkRUgyVjNGT00wODQxd3EzRFlyRktDNGM0MXNOL3dDNUd0cm9W?=
 =?utf-8?B?MTlacFZpQUZxTTV6bjZ3QlFlU3BoeVlNbDc5QlVRT3VMUW1ZQ1FmMmI3K1Vh?=
 =?utf-8?B?ZytmcUI2OW5vcER0SmRLemxId2d3cU9kMkRHVG1wSytnT1VGcnovWW5BRURZ?=
 =?utf-8?B?eUUxL241amdrZE1pT3pGUWM3NVNOMUQxNGZpbTFLRDJVTzNPVVBEcWFNMGhC?=
 =?utf-8?B?Zmw4bjk4QWZBM2NLZEVyaXh4ZEZORTVKa01nMzBZVVdxeWdSbG9Qb3MwQW1p?=
 =?utf-8?B?aGd0ZXF4aEE2R3pyWkZNV3N6K0pmRTRzVUt5Z1dxU1l3c3J6MmMwZWxLZTJX?=
 =?utf-8?B?Sml6d3d0NkM1dHhKaURkTk04dXcrMWZhSTN6eW9EdE5NUDJiNjZROTNwNzVh?=
 =?utf-8?B?d3BZYXpHNUxXVGlQc0JSWkx1TFUwUDB5M2RtY1puS1hpcGxlRTBYMnpqeFFs?=
 =?utf-8?Q?rbNodKcCBfUmxacrfP3Mc/72w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e9c04f-fa31-4e2f-a47c-08dd51090763
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 17:15:37.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oxvj0kztWjQpsGr9k3701BC5UbqOPZIRRiiyrSo25m/ln150NXF2ahq3MLXZc9jHLQgyZz3fIv4mHhR67/IMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-OriginatorOrg: intel.com

PiA+IFRoZSBjYWxsZXIga2lsbF9tZV9tYXliZSB3aWxsIGRvIHNldF9tY2Vfbm9zcGVjICsgc3lu
Y19jb3JlIGFnYWluLg0KPiA+DQo+ID4gc3RhdGljIHZvaWQga2lsbF9tZV9tYXliZShzdHJ1Y3Qg
Y2FsbGJhY2tfaGVhZCAqY2IpDQo+ID4gew0KPiA+ICAgICBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAg
PSBjb250YWluZXJfb2YoY2IsIHN0cnVjdCB0YXNrX3N0cnVjdCwgbWNlX2tpbGxfbWUpOw0KPiA+
ICAgICBpbnQgZmxhZ3MgPSBNRl9BQ1RJT05fUkVRVUlSRUQ7DQo+ID4gICAgIC4uLg0KPiA+ICAg
ICByZXQgPSBtZW1vcnlfZmFpbHVyZShwZm4sIGZsYWdzKTsNCj4gPiAgICAgaWYgKCFyZXQpIHsN
Cj4gPiAgICAgICAgICAgICBzZXRfbWNlX25vc3BlYyhwZm4pOw0KPiA+ICAgICAgICAgICAgIHN5
bmNfY29yZSgpOw0KPiA+ICAgICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgfQ0KPiA+DQo+ID4g
SXMgdGhpcyBleHBlY3RlZD8NCj4gPg0KPg0KPiB0aGUgc2Vjb25kIHNldF9tY2Vfbm9zcGVjIGRv
IG5vdGhpbmcgYW5kIGhhdmUgbm8gc2lkZSBhZmZlY3QuDQo+DQo+IHN5bmNfY29yZSgpIGlzIGlu
dHJvZHVjZWQgYnkgVG9ueSBbMV06DQo+DQo+IEFsc28gbW92ZWQgc3luY19jb3JlKCkuIFRoZSBj
b21tZW50cyBmb3IgdGhpcyBmdW5jdGlvbiBzYXkgdGhhdCBpdCBzaG91bGQNCj4gb25seSBiZSBj
YWxsZWQgd2hlbiBpbnN0cnVjdGlvbnMgaGF2ZSBiZWVuIGNoYW5nZWQvcmUtbWFwcGVkLiBSZWNv
dmVyeSBmb3INCj4gYW4gaW5zdHJ1Y3Rpb24gZmV0Y2ggbWF5IGNoYW5nZSB0aGUgcGh5c2ljYWwg
YWRkcmVzcy4gQnV0IHRoYXQgZG9lc24ndCBoYXBwZW4NCj4gdW50aWwgdGhlIHNjaGVkdWxlZCB3
b3JrIHJ1bnMgKHdoaWNoIGNvdWxkIGJlIG9uIGFub3RoZXIgQ1BVKS4NCj4NCj4gWzFdaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjAwODI0MjIxMjM3LjUzOTctMS10b255Lmx1Y2tAaW50
ZWwuY29tL1QvI3UNCj4NCj4gSU1ITywgSSB0aGluayBpdCBhbHNvIGhhcyBubyBzaWRlIGFmZmVj
dC4NCj4NCj4gQFRvbnksIGNvdWxkIHlvdSBoZWxwIHRvIGNvbmZpcm0gdGhpcz8NCg0KQ29ycmVj
dC4gUmUtcnVuaW5nIHRoZXNlIGNhbGxzIGlzIGhhcm1sZXNzLg0KDQotVG9ueQ0K

