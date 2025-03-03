Return-Path: <linux-edac+bounces-3257-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46634A4C8E6
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16673AC9AB
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEAD22B8A2;
	Mon,  3 Mar 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7Cn+qaP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92101DA31D;
	Mon,  3 Mar 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020571; cv=fail; b=CRAa2c4pIi9kMwqHNxtAaF7bCkzOS//bKmRlE5+IlTTxurioeuK4zL2SzzQ6HTqr5LuMu0rIg6clMhd2jHuMhQApjRWux1r+yUUTE10uB0JHyjP80VoenOus2MKhp9514h/J5CezSPSKe2PUodDNo8rdvwfR8xjUMaUWdSbd04U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020571; c=relaxed/simple;
	bh=sxfWXyhN5FqwBnqqY+xdgpCjluFC/wRZltl2PjCyIKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exw3Zd+raaglmmrig4WudE2+K5Uk0ONhO22gnMuGqIDUY/+AY/UrlzhL1mASYZRDuuCpaQP2qFmyA7qSDZZ16ReDvpRJ/ocL0oVUC5U+Fp73btx5QyzIO3/w6J1AFhmdimm6U8LcysJcIq+be68X7ER1o+3ksS3LWRmqxr41TnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7Cn+qaP; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741020570; x=1772556570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxfWXyhN5FqwBnqqY+xdgpCjluFC/wRZltl2PjCyIKA=;
  b=U7Cn+qaPpvyGwzg5EQ95C0Mls1V/r/pcb7LgKnmE8rvLIlpL9TxyD/uc
   JpSaDSQh3wCM7wMxwqlYF13TW/t7ZCpBMahiiF8D+zpIj+c/2anVx1OXN
   t0insG9eCDVR2gfHyOzqyaQB5W4x1cIX2SBuYnhm0V+eD8LBBaDqahO1m
   gQbHNSo8XKgD8BbIBkvF9FzytIJujjs26bZJ1341SK/aIrO84Fo7bFZYA
   kSt02DkSDJ8yLJEd+xKc3EgsiQGr7fXgKcklAqASDr/zvywrk1ZDZJTqe
   cOOyqId2lOIUOf7rveDdkpI7UF2vYHaww3+YBx3vdxd6dkfD3+4waWDPm
   w==;
X-CSE-ConnectionGUID: 4IIajJc1T6uqKXp6ZcokWQ==
X-CSE-MsgGUID: fGYwf3ScQ3eUE8+M7k1Mvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53300348"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="53300348"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:49:29 -0800
X-CSE-ConnectionGUID: tbkNSLPQRTK0gX29pdRhug==
X-CSE-MsgGUID: 0mVTiu3FQP+66iRXKuvHwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117829304"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:49:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 08:49:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 08:49:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 08:49:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1aple0CTn8j3lo0QUcjGEzWy2SkQMQZ35Dunr9M/Xvr80hOyCxB7zOuUGAMdrJQ0ye1LqZyLXsf0fRn6EmgaIi+A6Rmc7MTQwK0nViR/I5RfZPQfOjuH0/arZCbFCnyAfqQ/Ho1R+4FoFZz2xtmqyhgj4z6cepyEfpgrSOwqt6T/f9vEsMu2PH28Uag8nRRpNDef16NLBf512rc21nb4AOhQjhsIOZPjP59SvKyQiMYjZlBfU82iFaiRvNKi++w4v66gYo+ETkpE+2jAvfzC+QiVjkvawGBaaj2r13lQx7Dhd6E+KehApxqC8PX/3zYtW3lYncXxLMHJ1PqxaxTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxfWXyhN5FqwBnqqY+xdgpCjluFC/wRZltl2PjCyIKA=;
 b=VhH6ebgtC+Y6DueIvMqBri82/hsxvcRgpqEaiCY+zNe1pmX4+/ckQT03mduqdxxRX2dZcmY29Ehh/3Y8wrA1/c3wmcWP3kwmS73jgRHduygA/aIubXWfITp5PMKI8OcSIOmfZWEKBKOPiEiFxOsZ2SDaacxedIp/qeMl9FFF+uAtBrqQYvd+HqV5YUTpcRiS4NMdg6e0+QWcoXdhGSVESOqz1MGZM7Avhm/sc1xQXlkT4WkzpAUBYBbLJDlxOS8o4a5fqS2mUtNG0GsLa7i3hwZG3RzB4+rRfK8itLbwUl7eu0di4X6yNHR+8Y+7DGGx5Lcx+hdLX9Yw8lbhVJgU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 16:49:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:49:25 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Yazen.Ghannam@amd.com" <yazen.ghannam@amd.com>
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
Subject: RE: [PATCH v2 2/5] x86/mce: dump error msg from severities
Thread-Topic: [PATCH v2 2/5] x86/mce: dump error msg from severities
Thread-Index: AQHbgQXyPXX+b5DVvk23qF/fq5InZrNcuPwAgAEn1ACAAFIwAIAAMEuAgABPZwCAAvzzYA==
Date: Mon, 3 Mar 2025 16:49:25 +0000
Message-ID: <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
In-Reply-To: <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB5989:EE_
x-ms-office365-filtering-correlation-id: 51daa534-594b-422e-dc2a-08dd5a735b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXRXV0J2TTVwOGo2VGpWME5sMUE1a0dOUlh5NjZya1dYdUtHZGZoUDlDbDhY?=
 =?utf-8?B?Z3hRVnpaaHl6dk00NVdzbEwzVk5GYTVmNUZpdTZhc2gwVlhRVldaYWxHUkk3?=
 =?utf-8?B?azI5V3lpYURPK1pLSE4yOHdFdWxBT3VVOEhkMkdGSDhzU1EvKzlLaWhkSVNI?=
 =?utf-8?B?VnIyUmsvek9YK2VLcVdnSUxWS2EyNStZWDgycDBhRXk2UEtiRXgyY2FWMGlY?=
 =?utf-8?B?VFhwRjBEcDRZcUtwVUcxUFlndmlkbjB1ZGpKK1VmdTBZVDd6aWhERE1YSVJH?=
 =?utf-8?B?ckhOcCtiZTJNQlJ3clJudFFRTTdtU1kySUZjTG9OOUtweDNWZTVLbE9mZTZk?=
 =?utf-8?B?TU8xY0xMeC9HdkV0TSt0RVhUMWgvN0ZwSEN3MW5FREtMM0x3Y3pMeWt6dWZE?=
 =?utf-8?B?WWp0SFpyQVd4WFc2VmdxQ1hNZy9qV21BdzVZY3BYQ3ZBdGxNSmNYRmlNTFdT?=
 =?utf-8?B?MXQxalJpbjJaQjlVd3RVOEQwZEwxR1hwcS9hNVVNUGc5VHJpTWc3TXVkck9R?=
 =?utf-8?B?TE5TZGVvdEpKaGF0SnNFZUJjZnkrOG0xNU5zN0t1NHQwRkY3YndKY0dqYWJ5?=
 =?utf-8?B?ZmUzSFpDcE1rR0xFbFVwUE9MRURlOEc4bUswdmUwUCtsOXluazBpNGlWZzBC?=
 =?utf-8?B?U29MUUh6clVWeUg5T29TTVZyRWlWRm94dG0wTzhsMGRvRm94bGpTSUN1RVZD?=
 =?utf-8?B?ei92RFc5Sk1nbkxubGpjTUs5NnN4aUx2bDJxUW8xc1phWWlZUE1nMVQ2Wmgr?=
 =?utf-8?B?OTJuWG90bExTamdPSzc3S0dNUzZ6c3FtSFp0ZUdPcnFsbGhUY2R2Tmk3Q0Ex?=
 =?utf-8?B?NVpVU1BDSUNIM2xzd2ZXVW9UQmcyY055Skh6TW5qSERTZ1ZIWTZKb0Y1bzZu?=
 =?utf-8?B?dk1qT3FGRWtGWUhrWnJUYzRXUFB2Mm9LNXJqcXV3ampoTnYrUitSZk82cm9i?=
 =?utf-8?B?SXozalZneFhaMVRRazJyNk40dVFyVzZ6VDVVQklabGhyWUpjUXkrWGsvZXJw?=
 =?utf-8?B?L0VFdHZNZ1A1RGlwVlozUGRPd09NdFFkQ0QrQlB1YkhCdG8yUHB4VWtjdTR0?=
 =?utf-8?B?TFp4YUp5ZktEaXNuZnp3T0RNWG1zUVFjTy95SE9DdllEVFNrOWNPYSt4RVZ3?=
 =?utf-8?B?eFVaOG1yejY1aFRWYngwT3RNa1FzZ056NUZqd0toc2F4cGFUUDg3eFQxVlVL?=
 =?utf-8?B?aUtsdU51Um5ONW1PMkQ5WllQQkxZdXI0V2N2Si9RMS8wODYzNGtTNWg1L2Zr?=
 =?utf-8?B?djdTM0M0N0dQS1doZVV3emtSZ1p3WHVrb29QU2FNUDVhOHFsK1R0dTFrc3kz?=
 =?utf-8?B?VzlzSTRuRzFkVTl5SnJ2NkRibzFWbUNzeHJ6UFVtWHl1KzlZUW1NZXhtK0Z5?=
 =?utf-8?B?MllVbU1UVDFhY0MxaHVJL2ZKY1d0UjgwOW9ZV1d5SkxYVUtzR3lRVXNkM2NW?=
 =?utf-8?B?cVFvanJ6Sm5QVGlrTExHbzhwVnJCMzBaT0RqbkoyNTI2NmErVEp1anBreTlv?=
 =?utf-8?B?M0JiUnljOWczd0pNY05SVy9DWVJjUyt4VVZXNU5jbG4wLzY5TEhzZEN6K3BI?=
 =?utf-8?B?MlBtb3JTSTRHZWFybW9TeTQxekxMbktQSDRmc1V4WVdYdnhqaDJWOFF5VjE0?=
 =?utf-8?B?ODVDZTlqV0k2K3ZDT1dZSGwwbXEyaEJKOW9TOHRONExNU1I1NE9GRjJRMTgw?=
 =?utf-8?B?Sk5QN01rOVFUQkNSNDQxdjBjRVkwdm9hZnFLbjJ0a1dCOTZMQ3QvRDBtY3o0?=
 =?utf-8?B?R0FkMlpucm9WMDVycG9xR0w3SWRScE4zSWh6OWp4UEo1UW9PMGZtVnlJdDUz?=
 =?utf-8?B?eklzOEUxMWhIZkZJN2kvRUg4TG9BbDBFNUFtekQwZ2xObWsrbUJ5TXQyUlM3?=
 =?utf-8?B?YkVlSnNEdFpabVFFSEx6Y2RnRmhhUVdoRjVMZHhXUGJqZEdWMFk5bk51emZ0?=
 =?utf-8?Q?bVqasCJGXVEZQvIjh2xpedGWXlenrtIL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm4ydzJHd3RpS25DclRCNENIUy9jeXl5WktESm1qZFdpV0hHQ1NxeEdxS1NO?=
 =?utf-8?B?QzBybUJmVG04RGZoVU9WczRDZmozQ3V6a2Q1NDBiOUprQUFKWURCU20yNXhr?=
 =?utf-8?B?cCs3bkx4V1daU2VuZW1qVnFvcCtITmZMNXdlcnR1UllkVEpPMWp4VzBGLy9Q?=
 =?utf-8?B?eUJUVTNZM05DNkRsVkFKTlEvYjdtU0Z3Y0JyOFd6dHVIMURuY2ozQjlSRmpL?=
 =?utf-8?B?ZHlCMTJldmdNWmVOMkVMWXlJUlVtVTYybHFFN1lxY09EUElDNEpybzB6T25W?=
 =?utf-8?B?bUlSdmNYeTgrTzlRT3p4K1BTdyt6Q3g5YXZoL2lxQnNoN3pEVjNUdWgwMVRi?=
 =?utf-8?B?SjRLa0wrZE13ZjRqY3lDQkFBcC9DUDhNaWkrT0dJU05jemQxYXVKaXhJWkRm?=
 =?utf-8?B?eDdKRlFnYm1wWVE4cjhwc2JkNGphSXZ5VDBwZVE5QjgzYjIwT042MTk2bFlN?=
 =?utf-8?B?Y3BuUkdUN0NYYUFDVWJvb2ZKSzRKR2g4U0JyNUdacUdqRjZaWUlBR1B5MlBz?=
 =?utf-8?B?VE5VVEZlN0EwS2dPV0ZXRm95cVFxMDdHaElKTCtEVThEcU5mK1VZUG1hcURi?=
 =?utf-8?B?R01hdHRaSndGR3IraFIyRXJkYUpWZ0pIaHFQT0NOc1FuWEorSC9ucmUraVNu?=
 =?utf-8?B?d3VmVHhYZ1RrSnVzS01rV0FXbU9PSnBYUk4xN1RjdlRrU2xSdFIvK3B0YU5r?=
 =?utf-8?B?K0pNQ0U3eElqOVQ1cnpQd1ZwdXZyZ3podG00aHJpYjRnRDEwN2xBQVp5QkNs?=
 =?utf-8?B?VkZ2S0xIdDB0N1NOWXcraE10U1ZKUkwxcm8rcFVvODBRaVlrQ2lwWDFDYXdK?=
 =?utf-8?B?cHFBN2xFQ0xZUktGU0FXajZlbTEvZEFFSldyTnlQclFKRno1RUNzSUdpby9p?=
 =?utf-8?B?L1BTTEw2cFlDRGU0bjByd2dxNXdPRFZERjQvczZBcjA2NDQwY1Q4RU5IajBP?=
 =?utf-8?B?REZiU0lvbGZudjNkaGhjTmt3M3AyZ1d0UWxiSzFnRi9GaVZnTmIzSzhHZlBh?=
 =?utf-8?B?RFp0cXd2ZVpNZGVmS1BweXFnZ3lLeFYyZ0NUajBkck5vSy96bFJCZ3BKbXdD?=
 =?utf-8?B?ZHdKZUpZeWdTWW52LytLd1IxQVRLZGVRQ1RLaUw3MUVLQmFEdFQ2cUJXWGxj?=
 =?utf-8?B?eEF2djQ3MG1tVE5Qclk2ZnhRaWJ0c1czWUs4bWR4VlRSYzNOOUViUUtNcXE3?=
 =?utf-8?B?ZWptR2ZOZkJNM2dxM1hsMk5uempMNWpPN0xlRkxSUW1sOWExZGdseDQ1dXZu?=
 =?utf-8?B?RmxmUldpL2ovb2txd001L2hNMTN0MFpMOXVPcFRBb2pEQTlhcFRCWHNiQjE5?=
 =?utf-8?B?cGxCOEpOS2tPT0NCNUVMdjdlVzU0N0ZuSjdMTDJEZnpHR0o5My9lZ2o0N2h2?=
 =?utf-8?B?OFJ0RzBXbXByZ1RRb3gyN09NMUtYOWJZY3UrN3B3UExBaUdoVTJoekg1Vkdy?=
 =?utf-8?B?NU55eFNvczA1ejN0ZzJNQmw3cS9VcUU5bEFGN01tK2JCMG9INVZGU0EvSHJ2?=
 =?utf-8?B?R2h3azYvblNOUTZDa3ZYVHBsRGRmdk5hWGpwMU1SUFFReFNLUFhaamxEeEIr?=
 =?utf-8?B?QzBONjhyRk04R1FpR1Q5eEI5ZGtiTFlJTFozTEFPTFNWK1VsRWtRL1V1Njg4?=
 =?utf-8?B?azJob2dteTlEVnJpK1JNNTBtT0thVmVkOEswNUtNWmxEc0hYY2ltQ01PRHNm?=
 =?utf-8?B?SGN4dXlsYzRUVlpCdEJiWjhHTGp2V0VXMW5aWHN4Wkl6cTZveitUemV3Y1hm?=
 =?utf-8?B?TnNGNGg2MkFNNFN1ejhyY1p0QXpJTy9kVlpnRmRNU2JscEE2b3MwLzIzWkxm?=
 =?utf-8?B?R2YvTmV4WXd2TjN1TWxmLzc4SGV5NDYyRzNZQjc5eG02bjRSU3dKZC96MG5Q?=
 =?utf-8?B?WndzeDFaT05vdWZXUno2RlhwZ1F5TUJaWHVEbXdQNDdHelloVzJEUkVDSW44?=
 =?utf-8?B?RGhjYTIxWTUvKy9rZS9XQkhPdE5vdk9USGROY0FpSUphajM5YUFoWkFJenYy?=
 =?utf-8?B?MWFhZmtUdmZMNkdNeG9Zb1ZtcXBvRldaT08zRlRSYUFYYUJPeUhrWkhFODJT?=
 =?utf-8?B?T0ZQSm1wWWZ0TzJQVkJ3MVpBUTBzcHdTdGU1NktyYXpDZDdhQlRtYWlxVFlv?=
 =?utf-8?Q?QUI51ReHAFDdTQ3McYFrLA7vE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51daa534-594b-422e-dc2a-08dd5a735b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 16:49:25.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJWTUOujeR4+FDRHd00rDPhHdcrrUpIdzeGPi/aulFfmf62vDIyTab4MMjcY1P2zU/iy3cwygxNx/BLRspY20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com

PiBUaGUgZXJyb3IgY29udGV4dCBpcyBpbiB0aGUgYmVoYXZpb3Igb2YgdGhlIGh3LiBJZiB0aGUg
ZXJyb3IgaXMgZmF0YWwsIHlvdQ0KPiB3b24ndCBzZWUgaXQgLSB0aGUgbWFjaGluZSB3aWxsIHBh
bmljIG9yIGRvIHNvbWV0aGluZyBlbHNlIHRvIHByZXZlbnQgZXJyb3INCj4gcHJvcGFnYXRpb24u
IEl0IGRlZmluaXRlbHkgd29uJ3QgcnVuIGFueSBzb2Z0d2FyZSBhbnltb3JlLg0KPg0KPiBJZiB5
b3Ugc2VlIHRoZSBlcnJvciBnZXR0aW5nIGxvZ2dlZCwgaXQgbWVhbnMgaXQgaXMgbm90IGZhdGFs
IGVub3VnaCB0byBraWxsDQo+IHRoZSBtYWNoaW5lLg0KDQpPbmUgcGxhY2UgaW4gdGhlIGZhdGFs
IGNhc2Ugd2hlcmUgSSB3b3VsZCBsaWtlIHRvIHNlZSBtb3JlIGluZm9ybWF0aW9uIGlzIHRoZQ0K
DQogICJBY3Rpb24gcmVxdWlyZWQ6IGRhdGEgbG9hZCBpbiBlcnJvciAqVU4qcmVjb3ZlcmFibGUg
YXJlYSBvZiBrZXJuZWwiDQoNCltlbXBoYXNpcyBvbiB0aGUgIlVOIiBhZGRlZF0uDQoNCmNhc2Uu
ICBXZSBoYXZlIGEgZmV3IHBsYWNlcyB3aGVyZSB0aGUga2VybmVsIGRvZXMgcmVjb3Zlci4gQW5k
IG1vc3QgcGxhY2VzDQp3ZSBjcmFzaC4gT3VyIGNvZGUgZm9yIHRoZSByZWNvdmVyYWJsZSBjYXNl
cyBpcyBmcmFnaWxlLiBNb3N0IG9mIHRoaXMgc2VyaWVzIGlzDQphYm91dCByZXBhaXJpbmcgcmVn
cmVzc2lvbnMgd2hlcmUgd2UgdXNlZCB0byByZWNvdmVyIGZyb20gcGxhY2VzIHdoZXJlIGtlcm5l
bA0KaXMgZG9pbmcgZ2V0X3VzZXIoKSBvciBjb3B5X2Zyb21fdXNlcigpIHdoaWNoIGNhbiBiZSBy
ZWNvdmVyZWQgaWYgdGhvc2UgcGxhY2VzDQpnZXQgYW4gZXJyb3IgcmV0dXJuIGFuZCB0aGUga2Vy
bmVsIGtpbGxzIHRoZSBwcm9jZXNzIGluc3RlYWQgb2YgY3Jhc2hpbmcuDQoNCkEgbG9uZyB0aW1l
IGFnbyBJIHBvc3RlZCBzb21lIHBhdGNoZXMgdG8gaW5jbHVkZSBhIHN0YWNrIHRyYWNlIGZvciB0
aGlzIHR5cGUNCm9mIGNyYXNoLiBJdCBkaWRuJ3QgbWFrZSBpdCBpbnRvIHRoZSBrZXJuZWwsIGFu
ZCBJIGdvdCBkaXN0cmFjdGVkIGJ5IG90aGVyIHRoaW5ncy4NCg0KSWYgd2UgaGFkIHRoYXQsIGl0
IHdvdWxkIGhhdmUgYmVlbiBlYXNpZXIgdG8gZGlhZ25vc2UgdGhpcyByZWdyZXNzaW9uIChTaGF1
aQ0KWGllIHdvdWxkIGhhdmUgc2VlbiBjcmFzaGVzIHdpdGggYSBzdGFjayB0cmFjZSBwb2ludGlu
ZyB0byBjb2RlIHRoYXQgdXNlZA0KdG8gcmVjb3ZlciBpbiBvbGRlciBrZXJuZWxzKS4gRm9sa3Mg
d2l0aCBiaWcgY2x1c3RlcnMgd291bGQgYWxzbyBiZSBhYmxlIHRvDQpwb2ludCBvdXQgb3RoZXIg
cGxhY2VzIHdoZXJlIHRoZSBrZXJuZWwgY3Jhc2hlcyBvZnRlbiBlbm91Z2ggdGhhdCBhZGRpdGlv
bmFsDQpFWFRBQkxFIHJlY292ZXJ5IHBhdGhzIHdvdWxkIGJlIHdvcnRoIGludmVzdGlnYXRpbmcu
DQoNClNvOg0KDQoxKSBXZSBuZWVkIHRvIGZpeCB0aGUgcmVncmVzc2lvbnMuIFRoYXQganVzdCBu
ZWVkcyBuZXcgY29tbWl0IG1lc3NhZ2VzDQpmb3IgdGhlc2UgcGF0Y2hlcyB0aGF0IGV4cGxhaW4g
dGhlIGlzc3VlIGJldHRlci4NCg0KMikgSSdkIGxpa2UgdG8gc2VlIGEgcGF0Y2ggZm9yIGEgc3Rh
Y2sgdHJhY2UgZm9yIHRoZSB1bnJlY292ZXJhYmxlIGNhc2UuDQoNCjMpIEkgZG9uJ3Qgc2VlIG11
Y2ggdmFsdWUgaW4gYSBtZXNzYWdlIHRoYXQgcmVwb3J0cyB0aGUgcmVjb3ZlcmFibGUgY2FzZS4N
Cg0KWWF6ZW46IEF0IG9uZSBwb2ludCBJIHRoaW5rIHlvdSBzYWlkIHlvdSB3ZXJlIGxvb2tpbmcg
YXQgYWRkaW5nIGFkZGl0aW9uYWwNCmRlY29yYXRpb25zIHRvIHRoZSByZXR1cm4gdmFsdWUgZnJv
bSBtY2Vfc2V2ZXJpdHkoKSB0byBpbmRpY2F0ZSBhY3Rpb25zDQpuZWVkZWQgZm9yIHJlY292ZXJh
YmxlIGVycm9ycyAoa2lsbCB0aGUgcHJvY2Vzcywgb2ZmbGluZSB0aGUgcGFnZSkgcmF0aGVyDQp0
aGFuIGhhdmUgZG9fbWFjaGluZV9jaGVjaygpIGZpZ3VyZSBpdCBvdXQgYnkgbG9va2luZyBhdCB2
YXJpb3VzIGZpZWxkcw0KaW4gdGhlICJzdHJ1Y3QgbWNlIi4gRGlkIHRoYXQgZ28gYW55d2hlcmU/
IFRob3NlIGV4dHJhIGRldGFpbHMgbWlnaHQgYmUNCmludGVyZXN0aW5nIGluIHRoZSB0cmFjZXBv
aW50Lg0KDQotVG9ueQ0KDQo=

