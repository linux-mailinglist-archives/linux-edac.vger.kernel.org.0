Return-Path: <linux-edac+bounces-3091-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F7A363B5
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C45188E7EC
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730426773F;
	Fri, 14 Feb 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISg84gzO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD0262816;
	Fri, 14 Feb 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552259; cv=fail; b=nx5aRsvRj6nhiUsB7WwVzy2hFQY2lGpQ3QDo+H5AZKtXK6u6M/55lroM+RrnzqNXg0//haOpxcNTwbMRQ4AVDuykk4hd6KoiIQpBj7zxrx4i0IdIbYV2+2TdYXJw5LEWQUEK74TVCWdV0P4p1kk7fFoXkUp4fUsjZVrKjgHNgys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552259; c=relaxed/simple;
	bh=SIVk5kFa2/udblvJChVgYsBPKurdlNPil00YGX1tAh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dO8U1FBvh5HFLI3e+7aF2Z9wLHiUYkZz8x9KcbngMuakPyZ60ciDz/y/K6wS3yOQOsWa5oSFiB5l5rP05+Al8q8KxVQwLa0JHIpfWMC2qoV1YNJvfiraGWPI/Ob372WYufAor/Al9S0mq2yQ9JasRohyQhFahVO4vCoIQevHWJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISg84gzO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739552258; x=1771088258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SIVk5kFa2/udblvJChVgYsBPKurdlNPil00YGX1tAh8=;
  b=ISg84gzOXTYVyiFcVv9K0rir2CQJtcP4OaSAdRX2SjwEYVp6iMVmtpLz
   ZrBwHzNgsFVDwEJNefxsubupD5GE6xKaC4TDGpRvcO+JyRCUMn4z5OOFW
   FTRJf2ulXfJk2Ck7NkpB7hfIEAkAi4UxoBAk0fjbvA5xSu8Zb9yVTmtQ0
   kZSPDIl41dQ9jkNXhqe/5zL7Ce0dhVgo7SDbsnqnH8QEmj2+8p/QYMpnz
   9xGPWukbUcWGDQuomAnax7p1S9LrPP6TdaPZ5dGUIcNIbZSif9DDpWU9b
   Uy6nEPuQYdL5pfn+05/aJot37gs+xZD38onUchloj/tYiNw8YT5yQfCVi
   Q==;
X-CSE-ConnectionGUID: NqJck5HBTg+T8Dx35qZKIQ==
X-CSE-MsgGUID: YEPhAVxBSu+WUZFptEVzSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40431701"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40431701"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:57:37 -0800
X-CSE-ConnectionGUID: HHmyT8U4TTmhlJh7DwSc0w==
X-CSE-MsgGUID: 3AUW0P7ySWy1OevPF0RyOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114018724"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:57:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Feb 2025 08:57:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 08:57:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 08:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j076ZLHce0ZC0yDsXVDyj7y+U2/zZ7cIVgCCdE3muNtE7v+JSyXnW8bfpZ63pckhQ9zl16cKrZyBhGahcc69Fkx9cBSO5Ete/3ZuR73aeCsV5P7TVQi3PBIVrts6S9sl4hnStnAbSTxasHMa6OcGnIVbd7riAX2PNq/PqzZnD9YDfJfInWdMpiJoZBM40psAXb782aOR0jlg5qQ7d3dkfgQlNztszTfFeKCX6VibWJfZ2SEuvE0LS64fwtEXc1gSxqJxp/M6iLfg3VKNXwhGFS6Pj7oM8M/wb7ksAxBzxp00LRJeMTzTUnC1pH7J6+MJVo9V+8Dm5eG0WOiia1HmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIVk5kFa2/udblvJChVgYsBPKurdlNPil00YGX1tAh8=;
 b=YeS5Gwco9Uih2cTHxlGFzZsr9Nzas2QOPyT5jl2q36nn+KRRHOOXzewLjQKITle3dqWLCelZSubK6XBIZRAnsceY1LwYBlNap+m3SnOJpg6q+N+qgBlIQEK3H7H8rHBq0Uw7kEcFfdMnxFJ+EnLsJ6y8fEuCy4ZD7siyMOiGPSIH93MNueL1hynY804vUjHy/Vw9uOEco0yAwxiQpvqPg8hikV0tFaxPWq+l+57qTeH+yvzBysSBQQI0aS3uAb8Xa5QXEgkA97xCwSPGU/N8PuNz/bTFIEfyWCGc1Ow3J+kJKU/hE2XAz32VIYkjuSxec5re0CQHDazI9ULmaXgX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 16:57:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 16:57:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "bp@alien8.de" <bp@alien8.de>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v1 2/4] x86/mce: dump error msg from severities
Thread-Topic: [PATCH v1 2/4] x86/mce: dump error msg from severities
Thread-Index: AQHbfEqFA97VivoKakaCvm7AQzx4cbNCTzLQgAQ+EYCAAHxtYA==
Date: Fri, 14 Feb 2025 16:57:33 +0000
Message-ID: <SJ1PR11MB6083726C2A8951777CCE15B1FCFE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-3-xueshuai@linux.alibaba.com>
 <SJ1PR11MB6083F8EDC173234D31D6708DFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dceb65c1-9d8a-4675-9354-574deaf141be@linux.alibaba.com>
In-Reply-To: <dceb65c1-9d8a-4675-9354-574deaf141be@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: ff9797eb-0236-4af9-75ca-08dd4d18ad36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cGdsV25mdEtFMDRrU041QThCNGR3TzJoUzk3QU8vZnZOdjdUYlJHdHRWdHph?=
 =?utf-8?B?UXBaS25pU1M3YmhmNEVRV3ZXU2JZYkRPTWlJREQ1SS95M3hlaDdnZ0tHaXpT?=
 =?utf-8?B?TlBac2xubDN4RUxtVEtGdXJmQWVwMU03eXRxeHhhRnA1UkhIdEZSYStiZ2lo?=
 =?utf-8?B?RE9XQVlZZmRIVldiSVQ5Mm0va3hCQ2hTNDB3WXkxWVEvRlFDREtOWWJSWVlR?=
 =?utf-8?B?cWxLd01RT242MGxqMEJNWVRPRlUrUFFOeUlDRzhmc1ZEbDJnOEV1QWF5Wnk1?=
 =?utf-8?B?dy8yVHU5MWdVNFFObzNQM00rQnpFdk0vUlNRL2ZuSUJPVG8vVWJXVWgxVFNp?=
 =?utf-8?B?SmxYNGVKOEdkZGczK1drUGlxcnFaeWlneEtZamk2aXh4V0U5NkYyOXVaM0V3?=
 =?utf-8?B?QjdqR043T2pVYUN1Q2lpMU9hc1h0QnlMclRYdjBXVTZVbXE4Z2trZXR1VFQ3?=
 =?utf-8?B?c0tjRGhIT2pHS1VRZFd0SUhUUzNjd0pCa3pORC9Oclo1WjlRVUF3TkQzclEr?=
 =?utf-8?B?VUsxdTFyU3lIL0hDVVFnQVhmZjBxWVNoczJaMG43MTdNR1ZTbmwwbDdDQnNu?=
 =?utf-8?B?Uk91UzdnVFZJanFQRHJWQncvTm55MklZQldKdG1nc1MySW5Zd3Fxd3Y2bGpV?=
 =?utf-8?B?dGpiSjNuZ0hyUEpMdXplZi83UjQxZUw3NVhkK1dUa05aUVJ1VXBWU2tvalNq?=
 =?utf-8?B?N3gyRlpNRXRsOGZiNDlZRnNBNE85aFN0VVVUWDFFdVdKNmRFRldKSVJVNU0x?=
 =?utf-8?B?UHE5NHNTTEYvU1AxWnZDMUswYzBlWjJiM2xzZ0RWeHRCRGF0YUVmWHl4b2Fs?=
 =?utf-8?B?L0ZYUm5sTjA1S3k5S0tPV2EyRXpFU3M5U2c0RzVsZGlsWEhMU2VXRklUdHNu?=
 =?utf-8?B?SitaWHJnSlZpaXRic2JuQUE4RThIQ0FhN285N3FxRW1aTmNBVzNQdjk1TmFq?=
 =?utf-8?B?Y3JrTVArU2FTMk9OZGxyOFhSZDhMWThVZngwbnE2SlI0Z3lqNnZZYWxyZEdt?=
 =?utf-8?B?VDN2WmNJeVhrN1d0cVkrbitDVXdSZ2x6TDloNHE3TTBWTEdIWG9CdGtHU2Fs?=
 =?utf-8?B?UjcwMHEzbWhhSUFoRHJsRDBEcE1IOWZJUi9nV1lTYUpML0EwU0wyUXVHS25h?=
 =?utf-8?B?TTUxWm15YUx6QmN5ZUdlaFB2KzJiRkNTdHZtN0RubENJVExnSFkxNFdLcEpy?=
 =?utf-8?B?cnpJU1pYZ013T0JJdldlL2tIelRJeDdrT3FYamFmdGNUdUV6eUtZTEtEQlZC?=
 =?utf-8?B?SWZ6SmdsRHJ1eW9vSUt2WTU5VFYrZkUwdlVYK1BVcWRKUThQdk1VRUpUcWNB?=
 =?utf-8?B?NmdjWTF1NDE5WG9ZVUNMNEw0dzZKUDVieS9wb1hwVVJ1OHdocWI1RHp1VU80?=
 =?utf-8?B?YjV6Q2xTY0p1bmEzMDNOSGdqYmpXc1lTNWJLNklLd0g2M3NNOUwrdWNCRE5H?=
 =?utf-8?B?T0hHaDRnRUJlczkzUWcvcVN2bktZaEhBQzN3VGtiK2kyS2dWbnNXM0tpb2p2?=
 =?utf-8?B?MUF2UktSWlZ1aFJEbXFBcnZmaFp1NjVsMGkwQ3ptWVFyei9XaEZFenJPaEpu?=
 =?utf-8?B?WExVMWE0dFI2VElZV2hrait6dzcyajJvRjJVbklQbWNTNmR4cDFMWGJwOGxM?=
 =?utf-8?B?QUxBa3lMYXgzUkMwazRXZ20wVFV5Q2U5OFp6alRTandkeG5ucHdSM1VlcG8r?=
 =?utf-8?B?WUVzb3dLbWw1OE5lay9xdFg4ZGJaU0M2dGtiNWdjNGp5Snl2a3ozdmhFTUJK?=
 =?utf-8?B?RVJ5UU94ZEVub0xVY2k1SEpRYUpqVnhXVndyNWU3S2JYV2Q4UWthbVFWUk5h?=
 =?utf-8?B?R0Y0QXRPUGVhSVlDT1RsUlVVR3dzNU9jNWdvSXVkeWJyVkJIdzZ5Skd4QVdL?=
 =?utf-8?B?SnVqNVFBZk5RVUtUYithODlBU1p1MllPb2h6K0NCWjZUY1pwY05ieHptRkd4?=
 =?utf-8?Q?tffbuwlSUte6CCIGNKCPzw5x/n2N7UZ2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGtJQ3FCNjA3Y251Y0JRaHc4a0tjd2dEZFpwUG1QbmN2ZHVxSW9tRE9SUGtE?=
 =?utf-8?B?UnY5K1hLUkFMWmRQMlYzSitPQnFUSUdROUp0S1FSZFVmZVJtemxLa21yR0hv?=
 =?utf-8?B?SzdzM3p6UlE2MHpFUGF2NWlVOW9iSVk3TFc1b0dqSmU4MkhuREg3R2JaUzRa?=
 =?utf-8?B?aHVrV285NThBVXBDaXEyMUJoWHd2bUMydWxiK0J2aVBaRHUxRlFlb0NmS1gx?=
 =?utf-8?B?UmFSVWd6SlNpQld0ZFMwY1pMKzJNSGdkdi9nMHlOSm4yanZGdWZhRnBJNzBi?=
 =?utf-8?B?cFhPeGdxY0o2TXFMQlVwSTArUkZnYzBkeTdORWF2dGFQajNicHVoS0hYdDA0?=
 =?utf-8?B?MC9WOS8xTk5WSC9ESEpVQlZKWEVsOWFIdVRua2xMSXdkTWk3Y3pVYUhCcjFm?=
 =?utf-8?B?U0o4RnM4d05xNjduU21jZ0NPa2EydW0zV2tHbkIyYnJGT3ZSVjhXS1J5VEVa?=
 =?utf-8?B?OXFCN2pVOU41aXNwb1VZMmRhbjdnQWFnQ21OeFRCbDlIVjhiVG9DZlVNRGJG?=
 =?utf-8?B?a1duL25RLzFOV3QrVkVWQ3Uwbi9FNDZqOGo5VFdVTXpXZTAwNHEwcldHOExC?=
 =?utf-8?B?bXhrTThQdnF5ZEx2OVdmZExYcFNISklWVGMrWVNyN01Hb0lkNVZnS29NZnlK?=
 =?utf-8?B?Q3dqaUdUSm5iNjY5VGtDbWppalgrQXJqTGN5WEpnc1BhdExCMk5XWXcwQzlT?=
 =?utf-8?B?WTViekMxcWlEVmhwZ2FseldEU054b01TY2RUcnpDdGxkWERHWVVCbk9iN3Vn?=
 =?utf-8?B?L1NYZU52dE1OVGo5NlRhK2VQanpNR29DUGR3UW0wUllkeHEwTjRPWjA0OGtY?=
 =?utf-8?B?UG04K2I4L29aYURhRFo2dnJtQkdtYkJNTG5DK0UxRXN4YVE2OHp5M0I4S1dX?=
 =?utf-8?B?MlJrdVp5L3FhRDQ5amdzejN2QUJzV0tOblpNR0JaYk5pN01xZU9oNTlJTmZU?=
 =?utf-8?B?SnU0RUorVkMwUUwwczIwMm5KekJGUzlNSWdkVE44RWthMjFEMjAycEpQYS90?=
 =?utf-8?B?NUJ1VUlWNE5ybTRGOUl2ZUpKaldBV2NzMEtzN1BkVUpXOE8vY1MyejNjRXdm?=
 =?utf-8?B?QjVmeHJHRGpxamJkaHgxQ2JLODgybXQzVzFwclhiOHRMek5yWVZMWmRoaXIv?=
 =?utf-8?B?Rk1ubERoSVNaY2kvTzJQMHZpVS8xN1NpYTFSZ0JLWjdLMUJIMG55MG11L2l4?=
 =?utf-8?B?S0p5L3ZXT0pqUGQ1akN2SHQ4cUY4aGJGTUpOa2xxRWhKOThHVlNUSitZVk5L?=
 =?utf-8?B?cTRGYU94SFFPVG9ZNDk1dEVHNlNFMmt5a1RoWmRrZzN6dlRRbi9oYkJ0R1p5?=
 =?utf-8?B?ZWk1V09VTVRwMk9xemNzRDNDdkwxUldGMnpVQXB3dWhlUEE3dC9KNjhlSC81?=
 =?utf-8?B?WUFKNk5KU054SXBINHFueUxRbm13ZkF4SC9ydU5nYUNrNlNVQzBSY2dQcldH?=
 =?utf-8?B?UllxR3JWUjA3YWNUM1NTOW14S2VVSEpidVZEMlBOU1h2NFp5cTNZR1c3SWRX?=
 =?utf-8?B?SUtPWUUzT1dIa1FTSmo4MTZWaERGZDhzSTZxTmZjZkJISUhkK1VnYUZyRVNq?=
 =?utf-8?B?QkI0NHFMSkRaa3hvWDRPMHliU1dBaG9FNWI5cGhqL3pHUE5Jd3lwcmVxZlhi?=
 =?utf-8?B?YkU5NnUvWStKY2Vwbk5NVE1HbmtkemZMaVl2ZFF2NTlHL0FobWhEbjByeWcy?=
 =?utf-8?B?bVJSYzFtN3FQYjk0c0dBMUM3OStKRWN1SnIvejFIU0JQd1dXNXZiVWNmRWF2?=
 =?utf-8?B?d0tmTk1Gbm9qcDRWbTdhVExvQnVRSGxjOTNzeHZTMEZmL2ZsS0E3cjBZakJ6?=
 =?utf-8?B?dUJzVjNrclozc0FiV1dlTjcwckd3V3hheklWWktEYnprUzQwdmpDSXpoUzZu?=
 =?utf-8?B?cG9FVWlOQXg5cGVONTZKUkpsUk1lTVc3M1NNbFJhUVdnaE9HT1ZrbWZUVVdw?=
 =?utf-8?B?MzFjUlJ3MlNiaUdZR3FqZnE5OFlwYXcrOUMvRUlsa3FobDlnTndPbUk0dlJY?=
 =?utf-8?B?MjJHQkFLaFpLRzJlcTZTcklWZ0FUcUlLbmpieFlVeVdyb1FERHhJZXk2Y0cy?=
 =?utf-8?B?WkkyK2lRUEluUFVDMW5TOGVwRmRMNG5icE1Ka3NEaURTWGdYRnlwK0JDbUhi?=
 =?utf-8?Q?vLkOj9lGtQdKGz5eVBzCw5XSF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9797eb-0236-4af9-75ca-08dd4d18ad36
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 16:57:33.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HtE2N3skqtbeU/86/yTrJx6zMC4hRgfShlKeJdCLfnAnXv2pqGAliB3rGmPedHrR07dCD1P+iJ//xkQhclRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

PiA+IFRoaXMgaXMgY2FsbGVkIGZyb20gdGhlICNNQyBoYW5kbGVyLiBJcyB0aGF0IGEgc2FmZSBj
b250ZXh0IHRvIHByaW50IGEgY29uc29sZQ0KPiA+IG1lc3NhZ2U/IEl0IHdhc24ndCBpbiB0aGUg
cGFzdCwgYnV0IG1heWJlIGNoYW5nZXMgdG8gaG93IGNvbnNvbGUgbWVzc2FnZXMNCj4gPiBhcmUg
aGFuZGxlZCBoYXZlIGNoYW5nZWQgdGhpcy4NCj4gPg0KPiA+IC1Ub255DQo+DQo+ICNNQyBpcyBh
IGtpbmQgb2YgTk1JIGNvbnRleHQsIGFzIGZhciBhcyBJIGtub3csIHNpbmNlDQo+DQo+IGNvbW1p
dCA0MmEwYmIzZjcxMzgzYjQ1N2E3ZGIzNjJmMWM2OWU3YWZiOTY3MzJiDQo+IHByaW50ay9ubWk6
IGdlbmVyaWMgc29sdXRpb24gZm9yIHNhZmUgcHJpbnRrIGluIE5NSQ0KPg0KPiBwcmludCBhIGNv
bnNvbGUgbWVzc2FnZSBpcyBzYWZlLg0KPg0KPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIG1pc3Nl
ZCBhbnl0aGluZy4NCg0Kd293LCB0aGF0J3MgdjQuNyAoYW5jaWVudCBoaXN0b3J5KS4gSSB0aG91
Z2h0IEknZCBoYWQgaXNzdWVzIHdpdGggZGVidWcNCm1lc3NhZ2VzIGluIHRoZSBtYWNoaW5lIGNo
ZWNrIGhhbmRsZXIgbW9yZSByZWNlbnRseSB0aGFuIHRoYXQsIGJ1dA0KcGVyaGFwcyBJJ20gbWlz
cmVtZW1iZXJpbmcuDQoNCi1Ub255DQo=

