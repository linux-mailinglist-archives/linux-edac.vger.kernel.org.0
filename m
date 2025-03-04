Return-Path: <linux-edac+bounces-3267-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70847A4EEB4
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5808A3AA057
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55182063F3;
	Tue,  4 Mar 2025 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iueNcxxH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB735156C76;
	Tue,  4 Mar 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121183; cv=fail; b=OaZqwtwrGz2U/rlRYfmk8zu95xqc91rN1orDVFP296LH58sP3iqg6fGGJWuinv0JL7512O8abluCp+oC+0w0qpDk01XmLubiqNQRfSwRcTCjrJcWNnMuCOPbvuW0qWVEuU++suvxOR4PxSRFb3eWOhf83W9NHhqkQr6X4scAqPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121183; c=relaxed/simple;
	bh=m+JtJhO4T6nDenAIAYzY1389p01WuB68r12T9ah1JAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+Z5uUJ3fc3pwRD4gwMOSagphq9CWbAvaR32fiX5X4FsOEFp5WeId89PVOvRyayPWuMthEr0nqRylqKtXxUgaNAFtZQxhm+dJnOaueAWR9iibkiVYhKkGMKhvlnNmR8gfkrKphHJWdABsr714gGgFzNfruLUnL0CBdpt4FsmUP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iueNcxxH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741121182; x=1772657182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m+JtJhO4T6nDenAIAYzY1389p01WuB68r12T9ah1JAE=;
  b=iueNcxxHaKh8tvAWs4lq34hoBeNjMqfVkEvbFY6O1r6xFQWBGPm4lwcC
   5zegunTxeBdZFqSl+sST4MHN+KpR19IWVE8QM0ils6eDP/a20kgyjswC/
   eEezFPPjgt7NpkqI+51KLrOT3o6yag9vpKLLACoR3UKgpB1q2Aj9xSPJO
   dDfYA7KzWU6Sw38T1KUTvkWTRu2sDqc4DSDZRz0ThV+ExzHD6/mYgiBbA
   7wMpzTPK37nwiPNScOMzJAXVWcekQklTJPNb6ijRzI3imAQnMs/QRGI6v
   KR3tTR5jfosGmz8IeeTUrSdajN2G9Ru9wMn8o6PvN4NC0PQhBfOrxiKmp
   g==;
X-CSE-ConnectionGUID: PVjkzvwCS3y4ASoNLuz1Hw==
X-CSE-MsgGUID: o/cyj2mcQ8CBQ1DknpzNPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="44867724"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="44867724"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 12:46:21 -0800
X-CSE-ConnectionGUID: MzibJL28SlmCQqHOlB60Cw==
X-CSE-MsgGUID: WAX+UBUJQKWq1N3u2+X3SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118379495"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 12:46:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 12:46:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 12:46:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 12:46:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LybsIlor2cLURjYO8oZ4sL28C+M4XPHHEn4xLYztkTq8Ga5PeNEHyz0kmGsiIeOg7q5VNn7klAzErN3OfZbc8KukcGzceQ7f9F0o3QLqEt3S4HDv0w59g/QpqnSLtNd0kIy8dR4x1eOUjPQaeZ5OSvhfARBogf+GLL1nEH9JNZ9L8Bo+DL+sQSs6mcTyig+UOb6gohOfnX+uDLoXioWEqVaVmIyn3HRnQt3Qxb1hzoUKyrlbNYufcwdZpb5TX5IGWvP51NcvdLLvCphjwVOEA46Sj5kjCu6dUBsvxOOwfQ2ngmmZwf0Ou7tQwJMra2mwXJiCfiqXuj8wgFHy+VOwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+JtJhO4T6nDenAIAYzY1389p01WuB68r12T9ah1JAE=;
 b=Dd+T6M8jyJIIJ8/sP4aLBhRU8hc6FbscfKH++JzulRX7SEskrHUsj++Wr/1R9XkrSeFc5TKcPLLFBcwOsiltFzNieSlexx+9WdVoaiOcK9g0Cz1fdD7D7phQm0w3ShBx3M14fBKiPVmiA7Gn+kPy6QI4D3z/jqdBvOHx0YcnNzaTOF8S4H9SEI3AIDCmi4ZTn061uqJ2CX6tkMVYyY9nBtUZRsXSZ8+RtfQctl+JE4A7a5S8P0jvmikisBdpZvN2K0y8yfq1dLwGrkCGC4N3A4OSlByHMY9InXySjeoSC3dp8gNuezbs4/15aEuiCrpQsl6CGXnggx0qFO5SYaRRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 20:46:16 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 20:46:16 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Schofield, Alison"
	<alison.schofield@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	Somasundaram A <somasundaram.a@hpe.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Topic: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Index: AQHbidxTUNzZg9ONHkWLPIGHJasSPrNhK4UAgAAQuYCAAhQbAIAAJHOAgAAC0eA=
Date: Tue, 4 Mar 2025 20:46:16 +0000
Message-ID: <SJ1PR11MB60838072FDD00EDA9E3742D2FCC82@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250303173538.000007cd@huawei.com>
 <20250303103529.GBZ8WF8flezRahE-1h@fat_crate.local>
 <977a011b1ede4093a8e49d9cbcf49d19@huawei.com>
 <20250304203025.GDZ8di4fTxb0QUo8h5@fat_crate.local>
In-Reply-To: <20250304203025.GDZ8di4fTxb0QUo8h5@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6546:EE_
x-ms-office365-filtering-correlation-id: ef4a8100-49c1-450d-fa61-08dd5b5d9bff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTFuTThFdVdMeVJHWGdMejNDRWRXSHBpTisrS3RvbU5ZTVZ4Q3B4QjNoWGIx?=
 =?utf-8?B?RVBTSy8wOXJkbjl3c2tycWdIci82YVZRQjZrNGhmL1RYSDJHSngzcThQYldH?=
 =?utf-8?B?R0hxUHJHV1NjQTVVWmdMWXRpemlhM0lTTlVrczkxNUtVR2lYVkVHQVZLNm54?=
 =?utf-8?B?Y0t1NXp1LzFSWUxwYlN1YVJPbmlIcHRZQkl0MjFiT0hZcGd1VVppWk82U1po?=
 =?utf-8?B?T080ZGhSamRLYkhPUm8vU3ZscmtrS1ZXeDhZeFp4OFRsUDZOVGg5b0hKQWVU?=
 =?utf-8?B?V1NhRWtVS1k1c1pTdkVMbWRzK2pPNXUyU3REaGdaS2YrK2ZZYTV0T3FkVjJR?=
 =?utf-8?B?d0VUSThvOExaZUNRVWZjRHhuWU0vUnVuVDdOcVZBVzcxRXU0U2pZWHB5N2hR?=
 =?utf-8?B?cDlsTEtpNDQ0UU1NVktOdURXNWZRQ0U3S0d5QmRINHdXTkpDWnQ0cU1oZnY0?=
 =?utf-8?B?SGVlK2NXOEtReWlFbS9ES0lvSm43M3o1TkxPTzdZQ1Y1K1FwRmJnTWRYdm51?=
 =?utf-8?B?a2dwOE1uUUpQaE9WZmp1clRxVTEyRm1uSTJzVXlVMVphbDdHcnNxay9qdkhL?=
 =?utf-8?B?K1l6eERFbTZxRWg1T1FoMkdXNkNYNlRTaVpSdEJFOTFNZFV5a0l2U2NLREQx?=
 =?utf-8?B?K0l3cy9DMkFSQXY4WVd6R3RSd21oWUZKUWEyK1pmem52TmtEK1Q2RWRyQUh5?=
 =?utf-8?B?NGJ4NjlUS25LbG1YUkxCTHdRSCt4dkphVEYrbGFsNS9jQ0JhdXhjZm1XMmpC?=
 =?utf-8?B?YzI3OGZDT1lSZkRNMFA4RkxXUXRIM1VRSVA2NWV4bG14STV4V1J5VmdaY2Zq?=
 =?utf-8?B?NVU5TTBuWS9HNVFUQWY1bjQzRGg5VjRZaGxVM3NlZ3Awc0k2V0FFaEc5eDM5?=
 =?utf-8?B?VHRCVUtKU1F1cXBwY2cxcXB6WjN1SjNIVEtDaG9SZTAzci9pdzRLaU52ejk0?=
 =?utf-8?B?Z1NkaXpiK20vT0RWTnFpYllzaElFcXFVK1NaSDdYak80OFVkQU9yR1BraFhE?=
 =?utf-8?B?QjVHZm1qVG9mR0s5M1ZQS1pBS0t1WUlxUTVlTXRQRTllZW9nT2ZtQ3g5QUFG?=
 =?utf-8?B?OE1vcFpoRURtaW9sRDF3T1ZxQ2NJQnF6WU5YR3p0SGdLTUxUYklVSm1mRHRN?=
 =?utf-8?B?aXQyUGZ0QXlnTGxRa2NpeDNxWEgyc3AxKy9naVVsRTVEV2ovTm90RnRkUXYy?=
 =?utf-8?B?SnZ2dHhKOWw5WUd0M2RyVjd0bXdmYnVNOGlGQ2FFbjBjZ1B2S1phV2NxcThQ?=
 =?utf-8?B?dGMwUnFPeEgxVEhUWmpvWlROb1NzeWpVQzVQS2F3L29nZzd2enJaWks0YWxu?=
 =?utf-8?B?Qm90SzgxTm9KNktwcWlZWGtHbDFSTEttdEZuZFpodGJ2MW5ULzdZSUF0c0RW?=
 =?utf-8?B?UTFoNjdKMHJ4NFc4TTFaNjlrM2hmZHdyTEZneFNGdG5PMU81WHJtY3ljODVG?=
 =?utf-8?B?YXZRNllLaHlwN1VjaVJ1MGNvdEZ1SjErazRScGZGRit4WlR2c0lwL1doZ3ZB?=
 =?utf-8?B?RGFXWmR0N0tOaXZ3QkJMamhBYVorWVU5aWZuUHpPZ3BsUnV1Ry9BVENPM0or?=
 =?utf-8?B?a1dhTkdXWTF3WkJBQUJoM2UyM3NVT2pic1dNRVJGMzdLcmFJOHlyK2N5a1Q3?=
 =?utf-8?B?MjY4TUJ3RzN3d3RLejByZTVsRjBuam9kWTN4Uk9PeWhTQkNYT09FM2hScXhB?=
 =?utf-8?B?eldyUWpFQnE4cFRhZ0dBYk15ZlZTRzlMM0U1Ry9VRUp0Mkw4dTBiVjFsOWNE?=
 =?utf-8?B?VXVOUkJyZlpCTlJ3ckl0TTJMUWRJcEYxbXplTGxEOTdhMXRjUDhraGtEMjMw?=
 =?utf-8?B?Qi9BMGtkbXVRRjdNWXB6N3E0ZzdrVDlnQ2VLZkkyemtyUEEwQWNYMHJ6eGZJ?=
 =?utf-8?B?VUMzbUZyZTd4YUNDOTBHejJpY29tbVBSWE1Cbnk1eGRHV0RERXhpYWgwQ2JR?=
 =?utf-8?Q?IkcKoFNcCk5ao6R12Cf6Yr7OuDcxs6IW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWJ1Ri84bmdBRTBCNkJ3QTFtSExqNlViV2JUeTlVSXEzTzIxcHJSWTBIZWRQ?=
 =?utf-8?B?eEwwcjVWKzRZUFgvOEMvWXZCT1lUUksyd0FtS2Q1M2g1a2R6TVNUY3dmVG9E?=
 =?utf-8?B?RGhGcmd5VEUrN0lPUHRVYnhQRmFWOHJBY2t4OGFXWlNBa1ljSkxYVGxOZlBI?=
 =?utf-8?B?Y2RMQ2k2a0tiRVE3dG4yQm5zMDcvVkJHVEFHZzF0VSt1RWVCMjM1WHFvQUV4?=
 =?utf-8?B?UFhpNzlBYTA4aHhGeVVMQkY0ZkswU0VHLzlRNFY2cUtObm1xODNNUkNCZHB0?=
 =?utf-8?B?Z25NVzg4eFlEYVd1OGRneVhEaXhJU21IRGtwK2ZCQ3VMSTk0WU40a2hxdFVN?=
 =?utf-8?B?UWhISnZFSTR5bU9aSW54a0NZeVBGdjRDUGMyVmZTZFNEQlhwQmF1TGp2TWtG?=
 =?utf-8?B?eDZKRnRkNllFNW9nenVjQkN5bmlxZGo5eW40eWRheWtTQ2xocTNrdnorajFv?=
 =?utf-8?B?WTdYVWRXV1BHQWh0czlEWGJNYjVmMWlUbFVubUZCTTZWVTlkUVBCVW5rcTgr?=
 =?utf-8?B?OXI4K3FsaURzZzMxWkF0eVBsVmMxMFlGY0VZR3dTbm9XZTArQ2tKbG5vZnVC?=
 =?utf-8?B?Z29ydUN6anIybG1GQmN2TWVyZWhLYzJYRmw2aFlTSmgxRlFYUldJMkxBbi92?=
 =?utf-8?B?ZGJ1SkFuOVZmakVPSXNkU0s4alVnT2RyWXBmLzMrUGFrTUtYUFhHcWd2Mm81?=
 =?utf-8?B?U0VNVGl3dUQxOU1XVDlkRHNWUnFlT2crYURVWkVrckJaK3lLNGlLTElYMTZL?=
 =?utf-8?B?M3BUT3pES0pDR2NaMmkwUXhtMVlEMFJidENEazJlY2FJU0wwRnQzOUp3NUhD?=
 =?utf-8?B?Vllidys1SExMajBDNmIzbFV6QkZWTkorcUxyZDFDUVlpMUlnQ0p5Nktwam9G?=
 =?utf-8?B?Z2Y4QTZJRFNZTUJzSi9ZUis3MjVPQ0VNM2xUVVV6Z0Z5ZHlORFNpbUU4SCs5?=
 =?utf-8?B?Tzh4V0dDbjVpRjJIYjg0ajBzMDUrdzFaZU1xNm82c2RJbzdKemdhcnhwc1hO?=
 =?utf-8?B?NTR6WEw3dm1BaXBSbmZjWko5WHREYW5ZZk9ndUNXQTliL3VlbG5yVW4vWHhW?=
 =?utf-8?B?WlEvNXlzNjRyRS8rRytxdkhXMjNHejVXbXN0R1VlL3JSWmZTWjh5ZDQ5aGd2?=
 =?utf-8?B?dVJmQkN5L01uWnJWalIyaGpyUEt3bHpneGtEU3Q4K21zRW15b3VUdUc5V1Z4?=
 =?utf-8?B?QTFMSVNjNDVmanN0TjQrc0JXU2k0dmlObWVhbXhGNG90L3k1TDRQZlJ0MG1s?=
 =?utf-8?B?dVR2VFoyM0F1MjFyVnRCTldBOUFMaVRJWmhOSzdIc1VuQzgrVU9BT1lUckpO?=
 =?utf-8?B?d3E2Szl3YjNwMGFYdWtHZDVSeHllQURUV3hLVEJRUzE0K3FOWW5NRHJVanEz?=
 =?utf-8?B?emlVWWlxazBmTkxLVXFsakZmWDBNcVd6OXlKSGI0U0FUVTZPSWJhK2pEWmVv?=
 =?utf-8?B?MWIrVXJIU09uenRlU25wTm85ZEx5bHlZOFZDNTErSUZhNWpFU1lkVndmbjFM?=
 =?utf-8?B?SGUzaXY0NnFjVDVEZVZqUW5VZjNUaGR6WVYxV2lTd1BXUkFVRmhJTDk2NGl5?=
 =?utf-8?B?elhENTVHMVI2YzAyYmd1VUxGZko4d3d0UmI3eTZNbTQ2YmZQT1dLcmh6TFps?=
 =?utf-8?B?ZDJxTE91NGR5Rm5SSTRrRDF6NTg3VytkYXJXaUVhVkg5cXpIUkc1c0ZIUHJp?=
 =?utf-8?B?Uzg4UVUzNnlEZ2RxV3pOWGg5amp3YmFHbUM3V29Ob3ozN0VNdE13MWFLS3BJ?=
 =?utf-8?B?UHNUTHZYdDRERnJ2eDExblhLTys0S2VoODNMZldvMFNhMUpmM2IwWENFczBJ?=
 =?utf-8?B?R243OEtHbVgwQU9KelVmWVMycmpTL05rd3hjWmFyNjVNRzhnYnc1Nlh3SXF3?=
 =?utf-8?B?RUk5WGQreHJFS2NYVlZ1VGNWbllCTXJZM1lnNUhDaVpJVC9DRVBQek4zZzdT?=
 =?utf-8?B?S1dIRUJ1OVVMWlpVc1Y5VGQxNm9XYm1xS0Nhbk1XMENIVlhBUzFIeU5IQ2dO?=
 =?utf-8?B?RVZuMjB0emp0VG9lUGVBTGozTzcxMDUveFU3QjcyTGdkakpCUFpvNjUydFpF?=
 =?utf-8?B?VitIamxxNXhzRUhoZmpSK0hQMTAxWEd3c1hiSTh4dU9JZGR5YURKSm5kUFEv?=
 =?utf-8?Q?6Ai2gtSrAumi5DO1ONGP0WOuA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4a8100-49c1-450d-fa61-08dd5b5d9bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 20:46:16.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zg4KiTlf0Ab1QdrrELM607XLTo4e6dL2C3+z2XLGpXrtdkbfkQYwE7JM6rUWuf1U+wi2sw440aqTug022z5YLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com

PiA+IFNvbWUgb2YgdGhlc2UgdmFyaWFibGVzLCBmb3IgZS5nLiByZXF1ZXN0ZWRfYWRkcmVzc19y
YW5nZSBhcmUgbm90IGRlZmluZWQNCj4gPiBpbiB0aGlzIHBhdGNoLCBidXQgaW4gdGhlICdpbmNs
dWRlL2FjcGkvYWN0YmwyLmgnLg0KPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aG9zZSBj
aGFuZ2VzIHJlcXVpcmVkIHRvIHVwc3RyZWFtIGZpcnN0IHZpYQ0KPiA+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9hY3BpY2EvYWNwaWNhID8NCj4NCj4gQXJlIHlvdSBzdXJlPw0KPg0KPiAuLi4NCj4gICog
QWRkaXRpb25hbCBBQ1BJIFRhYmxlcyAoMikNCj4gICoNCj4gICogVGhlc2UgdGFibGVzIGFyZSBu
b3QgY29uc3VtZWQgZGlyZWN0bHkgYnkgdGhlIEFDUElDQSBzdWJzeXN0ZW0sIGJ1dCBhcmUNCj4g
ICogaW5jbHVkZWQgaGVyZSB0byBzdXBwb3J0IGRldmljZSBkcml2ZXJzIGFuZCB0aGUgQU1MIGRp
c2Fzc2VtYmxlci4NCj4gIC4uLg0KPg0KPiBJbiBhbnkgY2FzZSwgaWYgdGhpcyBnb2VzIHRocm91
Z2ggbWUsIEkgd2lsbCBoYXZlIHRvIHJldmlldyBpdCBmaXJzdCBhcyBpdA0KPiBsb29rcyBmdW5r
eS4NCg0KVGhhdCByZXF1ZXN0ZWRfYWRkcmVzc19yYW5nZSBmaWVsZCBoYXMgYmVlbiBpbiB0aGUN
CmFjcGlfcmFzZl9wYXRyb2xfc2NydWJfcGFyYW1ldGVyIHN0cnVjdHVyZSBzaW5jZSAyMDE4DQoN
CkdvdCBtb3ZlZC9jb3BpZWQgaW50byB0aGUgYWNwaV9yYXMyX3BhdHJvbF9zY3J1Yl9wYXJhbWV0
ZXIgc3RydWN0dXJlDQppbiAyMDIzLg0KDQokIGdpdCBibGFtZSBpbmNsdWRlL2FjcGkvYWN0Ymwy
LmggfCBncmVwIHJlcXVlc3RlZF9hZGRyZXNzX3JhbmdlDQplNjJmODIyNzg1MWRhIChFcmlrIEth
bmVkYSAgICAgICAgICAgICAgICAyMDE4LTAyLTE1IDEzOjA5OjI2IC0wODAwIDI3MjIpICAgICAg
IHU2NCByZXF1ZXN0ZWRfYWRkcmVzc19yYW5nZVsyXTsNCjJlOTRkYzExODk4MDQgKFNoaWp1IEpv
c2UgICAgICAgICAgICAgICAgIDIwMjMtMDktMjcgMTc6NDE6NTIgKzAxMDAgMjgyOSkgICAgICAg
dTY0IHJlcXVlc3RlZF9hZGRyZXNzX3JhbmdlWzJdOw0KDQotVG9ueQ0K

