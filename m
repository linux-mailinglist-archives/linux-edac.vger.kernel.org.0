Return-Path: <linux-edac+bounces-4473-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55296B164C9
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA9188FA96
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACE2DC339;
	Wed, 30 Jul 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJPDlu2e"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D331DACA7;
	Wed, 30 Jul 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893224; cv=fail; b=DT7Fv8oa8aQ5ccrbQ+Z/rQD1tVtiPBTSU2/CntDjprVza6CbsZNTh1x/OcXfnjjeVjLvqvqKtL7zTmfKumCxR/+wzRyfvbxqSw44m4qd8ix7mPY9dL3mu3wOFnxU9a1ZFPY0Yi45imJoV4QdQrgpSDAXdieqUJ4Q6x4LYHDB6Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893224; c=relaxed/simple;
	bh=iiYsEW4tBTUDeOsNP1oerfA60vZMXlS3eAOBhIL8WOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiKQtuEwYJWFMW5M2qDFhagYkCuW9FKu7oT3iRBBOBUBTNPEc+bs8LZDz9iV6jFJpWUtubgzdN9B8uvORfNfSG0IBAbao3CdlLxNExNld76GocF9YBvZCbZ0uRAEsRiO+tRBBqKo9R9JciApKARyXjr6oYZjadpO7oAq6/HQOGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJPDlu2e; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753893223; x=1785429223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=iiYsEW4tBTUDeOsNP1oerfA60vZMXlS3eAOBhIL8WOg=;
  b=NJPDlu2ewk7So/Cs0YDGE7ctZsH9iRnwjJ+P6WDkE5Z+fOMbBPXy1L9B
   yeo3kmXxVL8sPEC3LAxiY+4tq9Rl1MS+8KtNDdmC8jau6bpSBAtjyfufm
   CSnCefHiAR0qPu5YiWQQZ6HyEixSxr5/ppvC6GlFGaQKbKw90MKyyLjBI
   XcKGuXn/jVGxFZu2Q80yrUG+F4OnE63nzAHHCjEpuZib/L+rhNk00s3bd
   EmQ1QK4gOvDm//2LrQP7V6RSs7Jo302IN55dcsywQRgUIq74sH/SkZFWR
   a3zVnnHqrUg9OSxMlNZWOSvrH++G0+sPin+66LIKB4K2+oqCWaeir2c96
   A==;
X-CSE-ConnectionGUID: 4Gj4duXAQNeSaC90mpdEYQ==
X-CSE-MsgGUID: v8HNaHDjQ627V3aaYaay4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67644486"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208,223";a="67644486"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:33:43 -0700
X-CSE-ConnectionGUID: toJYBTClRquJZiuo9w6BhA==
X-CSE-MsgGUID: fSM/EhV8QoqNk7o0xiF7kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208,223";a="163058808"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:33:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 09:33:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 09:33:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 30 Jul 2025 09:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnZqqwvbWOfsAp5o8FiN5HIo2OdefD+N7/y2KPWFqQh0VH29fFUkz1kP6QjUqDIbei69GLipEIh48WOXqg7WSAIpqc2fiGG67HImTuNLjbSyG0qe0mYe8WlxIElWBRqyM/m+0Em5pJMfEkUYZt3HxS/4rsg8UMLlpax0piUCo0JN1u8OceeoAu+0Je+pJaE79RRfJj8DpiOSfNQwtyRN/knH4EL7Ze3CQcCdVIcg8lxHKeEJORqE+jQzuu42oatDfREiQ2ElTsmiX4FyCCRO39LTX+JqF8JBYP8Cvjo/l7PYa8Pldm+xL8+GWB9mBJWtFa0lFsvzLZ5ZP64NhwMg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24aUmBH0JEFvJJKg9o5IYJSjPBG2qcjGxpI2Z7kfazM=;
 b=UAOm0ULWoHNww9ZI5mpSQyNnfti1Qv7ulcKcW+2dyExmYVX81klxuHOuQfr7cDa9wEr+Pf7FwsWq9trWaOFnNDQgOXKq1Ll8Q8zoTlQSjTBHdG7pXCUv/zPLEyGIYpzCL/fKr3I2U68pfnB4aCQtU1nW3G6dug6E5CtkQkVArj/7dOy2VzRKF1xOaggVaoYUPhXBzBqSJBXBdG/PoufGtWuy9llpTXRQdLG9i+H1P6dagdGREyAmT2N0Qp8InVb44arcvNvy4u3pF3StLWecfOyMjRgNcYSCqf2VaPSfZ8vieQBndZeXWk72IgBONLCvJOAuLl7TpoAl+7nVbSF7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 16:33:37 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8922.037; Wed, 30 Jul 2025
 16:33:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "kao, acelan" <acelan.kao@canonical.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
 size calculation
Thread-Topic: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
 size calculation
Thread-Index: AQHcARutltp8VFr67UKnYaFhiZ8S4LRKSp5ggAAEGYCAAIr7oA==
Date: Wed, 30 Jul 2025 16:33:37 +0000
Message-ID: <CY8PR11MB7134BDC448F3DB558917DFCF8924A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250730063155.2612379-1-acelan.kao@canonical.com>
 <CY8PR11MB7134149FA7DF6E6C0FC7A9BD8924A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAFv23Qk3vHFk36deq4NUPsE7gihqa9vdSVM2irnEye-KKLpBMg@mail.gmail.com>
In-Reply-To: <CAFv23Qk3vHFk36deq4NUPsE7gihqa9vdSVM2irnEye-KKLpBMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|BL1PR11MB6049:EE_
x-ms-office365-filtering-correlation-id: 78a897c4-d493-47bc-b229-08ddcf86d5ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEdCczgwNFBobDRiaDdGNDk2eFNzQ2pRRTFqYW53elkvckxKUUorY0owZEdJ?=
 =?utf-8?B?Vi9vZVg5dmo4WURUdHV4MmFCcHFqR1VCTDBSSFJ0alZBdGEzam5pUW4wbkFw?=
 =?utf-8?B?azN5Vit4V21kdk41SUw3d3IvU2I3SXNyMzJyNmMrMGMrTHppZ2V2eDUvQy9l?=
 =?utf-8?B?N0hHL1dqVGhvYWtTbWtrME8ybmVsSjVDVCtIMTcveVkvdU82aWt1QnRNc3dy?=
 =?utf-8?B?cDZmeFBsV2pnenFRZGhTZzY0cEU2S1RlU25wanRWc2dRUlJQMDJmL3BlVkZ2?=
 =?utf-8?B?dkdRSk1uZ2Rvd1RRS2ZVTGpmZFJveDQrdjRJdjI1eWpxTXFNU1h0Rjl0cnVD?=
 =?utf-8?B?V0YzZWdsMmlZTlJ6VGJPMkpyejJ4K2UySnZlMG0rWHk0RzI5V00weG9ZVElt?=
 =?utf-8?B?a1FEMS9uUWN1M3ZHRjVKU3JueUprdTVNZ1grdTZZdStUUml6dHRPRS9kVzkv?=
 =?utf-8?B?MkpqVndtSEhocWpzLzdKckVUMUpmU1Jwc1pGTDZUV2dPamdhZkI3ak9aUSta?=
 =?utf-8?B?dUJvUzlkWTZyQnlKQ3ZtWThBc2dwblVYY2JXUG1KWEZCTGdubzBIUTdJQ0ti?=
 =?utf-8?B?d0d5UkFMR25YVVpuUmExT2FCV200SHlnLyt2SHB1aTc2V29SeEdkMXdZUXJL?=
 =?utf-8?B?bXZHN2pldkZlNGtoMk5hWENQZjdwU2krVkxQeVI2MVV4akVMZjNWR2Nwd1gv?=
 =?utf-8?B?ZWpCREZkUVppMnBTYUdNUlQwTE95dzdRUFB0WEhIcUMwNWdxL2hRNHhzc1ND?=
 =?utf-8?B?NTBBaEczTVovTFZaNENLRjJLOTYzK2xXR1RSQW84QXAyVFN4ZTNBc3NkNG4y?=
 =?utf-8?B?Y04zSm5SMm5ISDVKSGl6YzVPalN3ekNlaTdYbHA3cHpZV09Ed0Ziemt4blNn?=
 =?utf-8?B?amU2blM5QlZJOFpIWGFYakdoa0U3MktaajlaS096VFpYOEQwOFRaV2NLRElp?=
 =?utf-8?B?OU4wQnRQU3o4cVhBU2VkdWdiVlN0VklBSnlkQ0NUQ1huT1lGd25CSjJKcWp3?=
 =?utf-8?B?VHZWc1dnZVZ2dTVDdm45Y0trZy9KNGsxVUVRR0FlYVc3SWxDMStyRkpZVzhO?=
 =?utf-8?B?VFNIT3RjY2xDYzVMK1ZSUXIyaTMzeWxnSmM5U3hjQmJhdXFWM29MVnVNaXVO?=
 =?utf-8?B?dUdaSTRWaXdMTUFJTnpZc01JOGlyaGZreTFUeTMvTDRtVWhva2lDRTVCTDhh?=
 =?utf-8?B?YzR2cEhzQmpUS3VQMzVWWWh5ZFk0NFVjL3VEN0szQnBISmRHa0VYMVRyUHVO?=
 =?utf-8?B?cnNxQUdFcGV0YmJzWGxPd203UFFpU2JpU1JCcEpTbEM1cjJwQmxBWWFZTENE?=
 =?utf-8?B?dVlBYXordUlkNHFCSFBPaGg2djJKSGxFY1J2VlIrV20rM1JRVWJCY2dmemk0?=
 =?utf-8?B?MkdlRGpVYUZSTVpDcU1ETkZFM2lYbkZ2Rm8zdUNsM2ZqVGhRZU9aQ2dEYUoz?=
 =?utf-8?B?VWRibWZHd2l0eURPcWpBbEhzdGcvQVREOEpPZlpSbjRaTEhEU3ozSWx2VWI2?=
 =?utf-8?B?T1ZhQlZJQklJS3RkUmVjM1V6UW0rMVpsdEprS0NTbnR6c1l3YUV0VzY1OFJ0?=
 =?utf-8?B?cG8renpkOVdPUVlYQVJpODJERERwL0xxdmJHWE9UcGVvZ3dqalI0N0w0RmhC?=
 =?utf-8?B?Vkh0TmV1R05vcnJSY25oMmtOSlQ0N28wS2pGdEhXK1dVV0VEOGJabUZ4VUVx?=
 =?utf-8?B?Skd0T1cwQTl0K2twYVZFZW5aeU15Q3FMQjJEcmh4bEs3eDhTYnJxKzhWcDJH?=
 =?utf-8?B?djFEaGx4TFRGU0pXdEN5ZTdSTitWbUx3VmI3WGg0Tmg1dUh5L1AxYnN5UE1k?=
 =?utf-8?B?L3lqamNNK1Y3eFdzaW0vbW10RnMvYW1MajQzNU00SElkb1plTmxyQWNLYmhT?=
 =?utf-8?B?RVNLa0RrN2J0VDBnT2RLVlk0a1Jyd3ZESjBWOFJ3Z1d2TDFFSlpTYU9yaFBK?=
 =?utf-8?B?cnZEcWpva2lrM2QxWXhWOVNYVHEzT01MdFRjbFcxZkxObGo5VU5jbE9Db2Iz?=
 =?utf-8?Q?AVIZFW0Bji1P7E+oDuwKEVWMPdtFQE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBSbVBBOWtodG91ckR6L0FCU1RaK011b3Q0TlNQU2V5eUJYU0dqU04wQVpW?=
 =?utf-8?B?UjBvMmZmbzNnTUErM0thcExERWxwUFRlNzdXYmIxdXZtcWVIcUhQa3lUOGti?=
 =?utf-8?B?ODlJMlMySzROc3hpeTBHSWdTK3BNZW5TYTdwNElvN0t3ZXMwb3VtK200cStX?=
 =?utf-8?B?K0E4bWRTSnN4L2ZXTXFWZll4RStMRzZoTGF3QmpvTHptU1Y5T1Q1Q2dyNndw?=
 =?utf-8?B?SjJuc2hXcUFzRnRqV3ZoUlM1STFuZFg2MW9HM3VmY3kySUNmaTMyUUhYakJq?=
 =?utf-8?B?elU4NmVFUGZZdmhvMkdNNE40czR4V0dSNUZQdlZFd1dVVEtnblplU2huSTM5?=
 =?utf-8?B?OW5SK0Zqa1JPWHoxSlZNTUp6Mm5XQzZCVURPWkRuU2xsaWVQenBSSXI4N2Qx?=
 =?utf-8?B?NmdWODZzR0Q1OFBiajBUalB1L25XK2ZmVXViaHB4VWdCNmxsVWM3V1BqbW1a?=
 =?utf-8?B?Mnp2d1BNTUlTV091MFErQ1M3NkVodVlLWW4rSFNiRmRKaHlDa3k1WkVLZDZj?=
 =?utf-8?B?aWlnK2lYWDJEcHYyYUt3YVA2bUpESDIxNlIxTlpxbFBPYkY5V3dBY0RpdFBu?=
 =?utf-8?B?bWxDNUFxWEtabkJHZEJqOUVyRVZuVTVyUmErTDNVdlFDMEhpeHlCTEt2aENI?=
 =?utf-8?B?S2ZTSDJENzRhR1NVbktrRHZpZjE2YkczK3NXdzRveDlUQW1vS0d4SGpTS3pB?=
 =?utf-8?B?bDhxYktUOVFFdWg4UmU2ZGRDZkwvckdrMU5aa3RMNUU3TVZ0U29KbnZVR2NT?=
 =?utf-8?B?SktiWkVMbWZ1U1FFdlVDYm9YczRKRjJhemRjNCtkVndoOTNsVnBmaWFPMi9Y?=
 =?utf-8?B?KzdQeENYampqQW9xUEc0QWt6L2RlcXNwTXdrM2JLSHloSjBaVlI4K0tBbHJO?=
 =?utf-8?B?UStyRGxGaGVSZmdNOGdKRGF2U0hUWnJyZXFXQ1hWWEhCb2Q5SVpJQ0UxQ2di?=
 =?utf-8?B?dnNWYm1pbGxIeC9QYW00U00xY0NmdmY0b1RKRWNlMlZzYWh6eDlUS0pKTnBR?=
 =?utf-8?B?TitMWWR6WTROVTlkUmt4aXRybjY1c0N6ZWZvQzJmRTRoR2hpdENvL09iQ3pv?=
 =?utf-8?B?TnplSDJOc1czMlB2cG1sQkxjNFoxK0F2UDlHeUhrd0JsTXFhU1FVR3Zwa2x1?=
 =?utf-8?B?UFdWelNQWUdnamFwLzJaazR4NldqSnlWWXY1UHQxbElvK1JyaStPUHkycTVE?=
 =?utf-8?B?U3c1K0xvSHBFUkVtS1YvSnpTRDZEb1pDaHQ2NzhVQTBUbWV2ZHRnVUhvbkdT?=
 =?utf-8?B?NXZSNHBDeGFjRTAxMVhHMEk4cEFTVUkvdjVIQkdUaHBIWjYrY1o4blRrMVBm?=
 =?utf-8?B?YVVwVEFYeEVBV2hBSHErYWhUYXBvNmtiSjRmNXRBN3RDV2lHcEJtV29oMWxp?=
 =?utf-8?B?NWRlOG45Mi9pUjI3SjEyNkx6S0VkaStjQklqeWFvVzFST1gya0VCVUdiRkNu?=
 =?utf-8?B?N0hPMFF5Tk5zSURyaDczOGxDRTl5c0Z6RDNxalpRQlYxTTdkTlNOYmxuTmNO?=
 =?utf-8?B?NnorTUx5M1VHelZFekRjV0FaMEFGaGdyQmFEK0VZZVlxYVYrb3VQL3A1aURs?=
 =?utf-8?B?NzBuSEpZdnZNUXZidGFNZUJxaDE1bFRyZXBBczIzZmJtUHFHcUdBR0ZITEVS?=
 =?utf-8?B?ai8xR21OVEViRnkzazZjR2FueHJwTURUY1ZoL0lmbDRrSUthUTVaelZIanVY?=
 =?utf-8?B?M3BOTXNLUEdGaEpubmQvdUFkRG00bmhvSWNvdEo3cEZzRnFoUFJETHlibTli?=
 =?utf-8?B?NEMyUTVDWlJwMENORkxRTjZXdU9OeHhRTEdjVjBrTW1vZEFSOXdFcjBvdE1Z?=
 =?utf-8?B?WkNhaGxPNjczVlJUSWp3dFRBVWgvV1RJVzduWEdkcCtOL3FiYjhIUzZOYkJ0?=
 =?utf-8?B?TERNRkFWbCtob1NIcFUvY0FoQlRjZ3daSFl2NVZwZ1Jpb0s4Tks0bGdkRHRZ?=
 =?utf-8?B?K21oQ1ZtNERZTFBseXdyOFVWVytmWHRyWTZOUVZCQUJ4WWo5eUZDYmlEZDgw?=
 =?utf-8?B?ZWxNdnh1L3NRUXlGUHo2S0NFdlhNY1lMY3VtUVJHVjVTRUxsMWdnenQvR2t5?=
 =?utf-8?B?WGVpUFd3Vm9vNzZ6WnUwa3ZYdzZCb3JndllrSUNjaTkyMmpPUElja3hDZ2FH?=
 =?utf-8?Q?y+af+skDq+waAIkYlN0UYjzQw?=
Content-Type: multipart/mixed;
	boundary="_002_CY8PR11MB7134BDC448F3DB558917DFCF8924ACY8PR11MB7134namp_"
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a897c4-d493-47bc-b229-08ddcf86d5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 16:33:37.3593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HpJEk0NruIj1o++NockZVq/alLhGFCPqQ4Jx16SOPssVqM0q/Ac6dqHHf4GXymyUGx8zaR7cnwaVaOqkapipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-OriginatorOrg: intel.com

--_002_CY8PR11MB7134BDC448F3DB558917DFCF8924ACY8PR11MB7134namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQWNlTGFuLA0KDQo+IEZyb206IEFjZUxhbiBLYW8gPGFjZWxhbi5rYW9AY2Fub25pY2FsLmNv
bT4NCj4gWy4uLl0NCj4gPiBXaGljaCBDUFUgZGlkIHlvdSB0ZXN0IGl0IG9uPw0KPiBJdCdzIGFu
IG9uIGdvaW5nIHByb2plY3QsIHRoZXJlIGlzIG5vIENQVSBuYW1lIG9uIGl0Lg0KPiAkIGxzY3B1
DQo+IEFyY2hpdGVjdHVyZTogICAgICAgICAgICAgICAgeDg2XzY0DQo+ICBDUFUgb3AtbW9kZShz
KTogICAgICAgICAgICAzMi1iaXQsIDY0LWJpdA0KPiAgQWRkcmVzcyBzaXplczogICAgICAgICAg
ICAgNTIgYml0cyBwaHlzaWNhbCwgNTcgYml0cyB2aXJ0dWFsDQo+ICBCeXRlIE9yZGVyOiAgICAg
ICAgICAgICAgICBMaXR0bGUgRW5kaWFuDQo+IENQVShzKTogICAgICAgICAgICAgICAgICAgICAg
MTcyDQo+ICBPbi1saW5lIENQVShzKSBsaXN0OiAgICAgICAwLTE3MQ0KPiBWZW5kb3IgSUQ6ICAg
ICAgICAgICAgICAgICAgIEdlbnVpbmVJbnRlbA0KPiAgTW9kZWwgbmFtZTogICAgICAgICAgICAg
ICAgR2VudWluZSBJbnRlbChSKSAwMDAwDQo+ICAgIENQVSBmYW1pbHk6ICAgICAgICAgICAgICA2
DQo+ICAgIE1vZGVsOiAgICAgICAgICAgICAgICAgICAxNzMNCg0KVGhpcyBpcyB0aGUgQ1BVIHdp
dGggdGhlwqBjb2RlIG5hbWUgIkdyYW5pdGUgUmFwaWRzIi4NCg0KPiAgICBUaHJlYWQocykgcGVy
IGNvcmU6ICAgICAgMg0KPiAgICBDb3JlKHMpIHBlciBzb2NrZXQ6ICAgICAgODYNCj4gICAgU29j
a2V0KHMpOiAgICAgICAgICAgICAgIDENCj4gICAgU3RlcHBpbmc6ICAgICAgICAgICAgICAgIDEN
Cj4gICAgQ1BVKHMpIHNjYWxpbmcgTUh6OiAgICAgIDE4JQ0KPiAgICBDUFUgbWF4IE1IejogICAg
ICAgICAgICAgNDgwMC4wMDAwDQo+ICAgIENQVSBtaW4gTUh6OiAgICAgICAgICAgICA4MDAuMDAw
MA0KPiAgICBCb2dvTUlQUzogICAgICAgICAgICAgICAgMzgwMC4wMA0KPiANCj4gPiBXb3VsZCB5
b3UgbWluZCB0YWtpbmcgYSBjb21wbGV0ZSBkbWVzZyBsb2cgd2l0aCB0aGUga2VybmVsIG9wdGlv
bg0KPiA+IENPTkZJR19FREFDX0RFQlVHPXkgKHlvdXIgY3VycmVudCBsb2cgc2hvd2VkIHRoaXMg
b3B0aW9uIGhhZCBiZWVuDQo+IGVuYWJsZWQpPw0KPiBTdXJlLCBoZXJlIHlvdSBhcmUuDQoNClRo
YW5rcyBzbyBtdWNoIGZvciB5b3VyIGxvZy4NCg0KV2UndmUgZW5jb3VudGVyZWQgdGhlIHNhbWUg
aXNzdWUgcmVjZW50bHkgZHVlIHRvIHRoZSBCSU9TIGRpc2FibGluZyB0aGUNCm1lbW9yeSBjb250
cm9sbGVyIHdoZW4gbm8gRElNTXMgYXJlIHBvcHVsYXRlZCwgbGVhZGluZyB0b8KgaW52YWxpZCB2
YWx1ZXMNCm9mIHRoZcKgZGlzYWJsZWQgbWVtb3J5IGNvbnRyb2xsZXIgcmVnaXN0ZXIgYW5kIHRo
ZSBjYWxsIHRyYWNlIHlvdSByZXBvcnRlZC4NCg0KQXR0YWNoZWQgaXMgYSBwYXRjaCB0aGF0IHNr
aXBzIERJTU0gZW51bWVyYXRpb24gb24gYSBkaXNhYmxlZCBtZW1vcnkgDQpjb250cm9sbGVyIHRv
IGZpeCB0aGUgY2FsbCB0cmFjZS4gQ291bGQgeW91IHBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24g
eW91ciBtYWNoaW5lcyANCmFuZCBzaGFyZSB0aGUgZG1lc2cgbG9nPw0KDQpUaGFua3MhDQotUWl1
eHUNCg==

--_002_CY8PR11MB7134BDC448F3DB558917DFCF8924ACY8PR11MB7134namp_
Content-Type: application/octet-stream;
	name="0001-EDAC-i10nm-Skip-DIMM-enumeration-on-a-disabled-memor.patch"
Content-Description: 0001-EDAC-i10nm-Skip-DIMM-enumeration-on-a-disabled-memor.patch
Content-Disposition: attachment;
	filename="0001-EDAC-i10nm-Skip-DIMM-enumeration-on-a-disabled-memor.patch";
	size=2434; creation-date="Wed, 30 Jul 2025 16:31:48 GMT";
	modification-date="Wed, 30 Jul 2025 16:33:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0ZGUyMGJkMmU3ZTY2OWM3YTE2YmUzM2MxZWJiNDEwNmE1NDc5YjY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4KRGF0
ZTogV2VkLCAzMCBKdWwgMjAyNSAyMjozMjozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBF
REFDL2kxMG5tOiBTa2lwIERJTU0gZW51bWVyYXRpb24gb24gYSBkaXNhYmxlZCBtZW1vcnkKIGNv
bnRyb2xsZXIKCldoZW4gbG9hZGluZyB0aGUgaTEwbm1fZWRhYyBkcml2ZXIgb24gc29tZSBJbnRl
bCBHcmFuaXRlIFJhcGlkcyBzZXJ2ZXJzLAphIGNhbGwgdHJhY2UgbWF5IGFwcGVhciBhcyBmb2xs
b3dzOgoKICBVQlNBTjogc2hpZnQtb3V0LW9mLWJvdW5kcyBpbiBkcml2ZXJzL2VkYWMvc2t4X2Nv
bW1vbi5jOjQ1MzoxNgogIHNoaWZ0IGV4cG9uZW50IC02NiBpcyBuZWdhdGl2ZQogIC4uLgogIF9f
dWJzYW5faGFuZGxlX3NoaWZ0X291dF9vZl9ib3VuZHMrMHgxZTMvMHgzOTAKICBza3hfZ2V0X2Rp
bW1faW5mby5jb2xkKzB4NDcvMHhkNDAgW3NreF9lZGFjX2NvbW1vbl0KICBpMTBubV9nZXRfZGlt
bV9jb25maWcrMHgyM2UvMHgzOTAgW2kxMG5tX2VkYWNdCiAgc2t4X3JlZ2lzdGVyX21jaSsweDE1
OS8weDIyMCBbc2t4X2VkYWNfY29tbW9uXQogIGkxMG5tX2luaXQrMHhjYjAvMHgxZmYwIFtpMTBu
bV9lZGFjXQogIC4uLgoKVGhpcyBvY2N1cnMgYmVjYXVzZSBzb21lIEJJT1MgbWF5IGRpc2FibGUg
YSBtZW1vcnkgY29udHJvbGxlciBpZiB0aGVyZQphcmVuJ3QgYW55IG1lbW9yeSBESU1NcyBwb3B1
bGF0ZWQgb24gdGhpcyBtZW1vcnkgY29udHJvbGxlci4gVGhlIERJTU1NVFIKcmVnaXN0ZXIgb2Yg
dGhpcyBkaXNhYmxlZCBtZW1vcnkgY29udHJvbGxlciBjb250YWlucyB0aGUgaW52YWxpZCB2YWx1
ZQp+MCwgcmVzdWx0aW5nIGluIHRoZSBjYWxsIHRyYWNlIGFib3ZlLgoKRml4IHRoaXMgY2FsbCB0
cmFjZSBieSBza2lwcGluZyBESU1NIGVudW1lcmF0aW9uIG9uIGEgZGlzYWJsZWQgbWVtb3J5CmNv
bnRyb2xsZXIuCgpGaXhlczogYmE5ODdlYWFhYmY5ICgiRURBQy9pMTBubTogQWRkIEludGVsIEdy
YW5pdGUgUmFwaWRzIHNlcnZlciBzdXBwb3J0IikKUmVwb3J0ZWQtYnk6IEpvc2UgSmVzdXMgQW1i
cml6IE1lemEgPGpvc2UuamVzdXMuYW1icml6Lm1lemFAaW50ZWwuY29tPgpSZXBvcnRlZC1ieTog
Q2hpYS1MaW4gS2FvIChBY2VMYW4pIDxhY2VsYW4ua2FvQGNhbm9uaWNhbC5jb20+CkNsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNzMwMDYzMTU1LjI2MTIzNzktMS1hY2Vs
YW4ua2FvQGNhbm9uaWNhbC5jb20vClNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFpdXh1Lnpo
dW9AaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZWRhYy9pMTBubV9iYXNlLmMgfCAxNCArKysrKysr
KysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2VkYWMvaTEwbm1fYmFzZS5jIGIvZHJpdmVycy9lZGFjL2kxMG5tX2Jhc2UuYwppbmRl
eCBhM2ZjYTI1Njc3NTIuLjEwM2ZiZjYwMmQxYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9lZGFjL2kx
MG5tX2Jhc2UuYworKysgYi9kcml2ZXJzL2VkYWMvaTEwbm1fYmFzZS5jCkBAIC0xMDQ3LDYgKzEw
NDcsMTUgQEAgc3RhdGljIGJvb2wgaTEwbm1fY2hlY2tfZWNjKHN0cnVjdCBza3hfaW1jICppbWMs
IGludCBjaGFuKQogCXJldHVybiAhIUdFVF9CSVRGSUVMRChtY210ciwgMiwgMik7CiB9CiAKK3N0
YXRpYyBib29sIGkxMG5tX2NoYW5uZWxfZGlzYWJsZWQoc3RydWN0IHNreF9pbWMgKmltYywgaW50
IGNoYW4pCit7CisJdTMyIG1jbXRyID0gSTEwTk1fR0VUX01DTVRSKGltYywgY2hhbik7CisKKwll
ZGFjX2RiZygxLCAiY2glZCBtY210ciByZWcgJXhcbiIsIGNoYW4sIG1jbXRyKTsKKworCXJldHVy
biAobWNtdHIgPT0gfjAgfHwgR0VUX0JJVEZJRUxEKG1jbXRyLCAxOCwgMTgpKTsKK30KKwogc3Rh
dGljIGludCBpMTBubV9nZXRfZGltbV9jb25maWcoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLAog
CQkJCSBzdHJ1Y3QgcmVzX2NvbmZpZyAqY2ZnKQogewpAQCAtMTA2MCw2ICsxMDY5LDExIEBAIHN0
YXRpYyBpbnQgaTEwbm1fZ2V0X2RpbW1fY29uZmlnKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwK
IAkJaWYgKCFpbWMtPm1iYXNlKQogCQkJY29udGludWU7CiAKKwkJaWYgKGkxMG5tX2NoYW5uZWxf
ZGlzYWJsZWQoaW1jLCBpKSkgeworCQkJZWRhY19kYmcoMSwgIm1jJWQgY2glZCBpcyBkaXNhYmxl
ZC5cbiIsIGltYy0+bWMsIGkpOworCQkJY29udGludWU7CisJCX0KKwogCQluZGltbXMgPSAwOwog
CiAJCWlmIChyZXNfY2ZnLT50eXBlICE9IEdOUikKCmJhc2UtY29tbWl0OiAwMzhkNjFmZDY0MjI3
OGJhYjYzZWU4ZWY3MjJjNTBkMTBhYjAxZThmCi0tIAoyLjQzLjAKCg==

--_002_CY8PR11MB7134BDC448F3DB558917DFCF8924ACY8PR11MB7134namp_--

