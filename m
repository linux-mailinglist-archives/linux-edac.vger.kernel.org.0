Return-Path: <linux-edac+bounces-3305-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148CEA56EEB
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401DD1697B5
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA3623F417;
	Fri,  7 Mar 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dm9uVQ/w"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7C23E338;
	Fri,  7 Mar 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368016; cv=fail; b=WQx5EyJAi2uvLQLllySbQu4jDV0DNmuNyivHJGF5yeb3qHlsek9OEPgrnp2jyU7dOVw3wCP6TW+S+aDtGKs99uddL6qrrpAGG5K9wFlHdXjh2zFPwghVDNZ0Ko3D14lmZtoJYNhpY1/uM1M3LNdGTqFgI9rX8O1sUZW95WjVgcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368016; c=relaxed/simple;
	bh=3D0mb9Cu1FE0JMc8c1ekE8W2hVIN/riw9t0icP/HMEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gActKBw543AxjEvho+tc9FmYXSjMjKp5GCk5jzmESL1my3CHb8kP4R39pyS2EkQZsl4p7VWKJlhsczZ9NPagFR41SbG1763oLkj3CyxsJQdiSZHeQueXwf0RFLipxcDYeDY7i4ztHBpVrnUQ/1tj/qlumh0HFaRIEw6UBrNYqio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dm9uVQ/w; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741368014; x=1772904014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3D0mb9Cu1FE0JMc8c1ekE8W2hVIN/riw9t0icP/HMEo=;
  b=Dm9uVQ/wPqG+E/zhR8+dKoXiyDp8hnxlEI9SM6cJosPkObIEFZ4dH6Ol
   thlqUOqcUZGHemjjG7LlTw/smB7xnlsLMgzfBQt258BCiv8QwHUQo48U6
   vAwup2ZLKduFNDNOxuc6vrLn2hekdiibbzag9JgX0ZfnRsvbA52WvAY2s
   ekvndgtx+80FAsc5WmjTv7akBu/T0uDa+ZVRk6TtEH9YtWAw7UuF/qWXj
   77eUYAsO9k9vcVQN/6cemQHM3TkyslrmCGCLIU4OpxY0K4VkvKZKOJ0Ft
   V6Tp5G0+IuEef4jMFlsfUNO5iOGE0Zw+VpTCDpqFXYZW0adKEqIe8Q+F+
   w==;
X-CSE-ConnectionGUID: HhGsLcJFSPSnOrG4t9apZw==
X-CSE-MsgGUID: huifLPk6SmOD0eJhnnZ9sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53414937"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53414937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:20:14 -0800
X-CSE-ConnectionGUID: MjE5e8bnStyyov3gm3xoDw==
X-CSE-MsgGUID: q9/nVbfvRJe0Wo0mQCA4Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124402895"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:20:13 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 09:20:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 09:20:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 09:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+z01R00AwZo4T3aV3rgaaVDZCESihoz2/fUEiso4YfOS9nvXaNblta4uJ9DjpXPg0mlQmCQqYTKqh0O//OROP5PJMTgUhOycRxqpQZnJM236g87+iGh8GrSpnLhE9RBC8e2uDtckH+hZHjmq7hjl6KafttqMvEzSjVJx105Cdc2XDCL8h2fucGgnbo75vfp1u7rh+iwf5aB2OY+fKVq+HFV2Em91QHYP0Wzv6PZRYYHW+dmcpbdOtCRLUbSPQt3aK2ll4Vqkv8ZaPK+W8tCv88TmgLKMR4MeecI6SjDwIOyHd6I8NimqTj3vnbBKoN0cvqdRhkgqqhMI/OkDLrYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MktKCfgtpFxlMOV5ZB/zYpLVBswWHMzP058n4+sMPkM=;
 b=KApA5PFTAfIH7Tzy3UM2Iq+c/APS0A6SZexlYEtGZXq1o4rwhkogrIMdDWwDUCjmGG/0qho5TZcxCBuCEFFt1pNt6D8sMUHrg61VYMp8vaBYTAPfSwG2bPywx5ii744F5gZA/+nWri9lf5o4ivlSAPqbMxZJdznVj96VR33j5pXewfBsmDUmk9dxWujB0DlDLXpzUVfKTuU64KuuKYKwX2rXAWoalAzNOaEk0rXrGyyic9/PctcySnV2L88FcVnzLokHkAc9du5AC9mBtDbLvjfZLOmyqGdLiaoLGQ73JTCw1038YUw0lBrWtisUnrRePheWgylhHSwezBLT8iUG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Fri, 7 Mar
 2025 17:20:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:20:10 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "tianruidong@linux.alibaba.com"
	<tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v4 0/3] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Topic: [PATCH v4 0/3] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Index: AQHbjyP9ulm7+criVEmpEaNvU8s5arNn60xw
Date: Fri, 7 Mar 2025 17:20:09 +0000
Message-ID: <SJ1PR11MB6083F2BA604819CD44AB5F26FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8765:EE_
x-ms-office365-filtering-correlation-id: da9db80b-6da9-40c2-1a35-08dd5d9c5048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3i2rx/fO3pW8QKAFACgQVXSHuDk9JfIYu1Ywnznj3Xx/u4FDLAbUaxlCO5RY?=
 =?us-ascii?Q?RyPf8TTV/jSt5ciZsBhhSrb+tJoDq3RlNyo7zAuuYUuSnrIXA/US4nnzr1PY?=
 =?us-ascii?Q?TTJDox0qeJjr95SCsDlBR4npHHatGAdi2xMkAJyjE9YszEKA8mWWyArBRrkl?=
 =?us-ascii?Q?XpKt7+8WLzAVSaRem6399/9mqK2RkionOeC+nyb5P51iiiLWdT2kqeMpROD/?=
 =?us-ascii?Q?8qbVKZ13Jtmlo4KEioUzaCLwTWMyyeGRudgFFA5CJR+iOntlcBKztF9iwhcT?=
 =?us-ascii?Q?4fBjQavTmUHQ7HyAxnhtt/JNwKML53BB1UypLSm5Quzt4JzgLHbJJvVzA/gv?=
 =?us-ascii?Q?3C+MWh0o93kkAx6IV8JNBiLbwFK7lJhy46xSJnz+/I5Qs3X3Gj0hb/e8dtjb?=
 =?us-ascii?Q?b67Bhwf42+HGYHii7KMDm/NvwdKeoEZRJti1N8bvoWKNozwx9c0JBwWSk0d9?=
 =?us-ascii?Q?3M2kt0FDdv+lrR0+g/IDVwSxM4d0Sm/ZgZktVuIQZkDVqHqBcbX1YG3sdFQO?=
 =?us-ascii?Q?8wZibCJz/RsTnI2EXb+ufhWoajEJ41G8mSqJUfPKMedbzKse54/BrMfPAIJz?=
 =?us-ascii?Q?gM8mD1XdlOQAxCVd/ZzgbkHmzrVH8QqfcqIXUMhnEWN2pSs5SbFm2s0eeqNS?=
 =?us-ascii?Q?B+wGoB5eALOqsI8y42TomQNahlKHq+fm4C9WV7rdkVSMKlyZjJ4fTW6tBn+D?=
 =?us-ascii?Q?AsBy1ehWIxWGIFTKbAL4YJJ3eLbsAyWJdsPucwhOJ369hWeYBRyQGb0upP5b?=
 =?us-ascii?Q?XDJ+8ZNNbSqtrtnkXjxz0jidNcSuVHuzrIoGsnrQveoA3svT0MEg/6mli5oa?=
 =?us-ascii?Q?lcdrNhDKJLUedSzb9giPGxlgskiQmvhfhRJdt06uia+IuKCWLbTfkqh+m5Ll?=
 =?us-ascii?Q?CNM8D9lLUxIVGewGXB2BrmCROMNssoqAJk13eOQFIGHIo+fgl73Wd9JMaQRC?=
 =?us-ascii?Q?sMvUHPJsu72unds9ztancUgRY0SmnG6OCEUOAK38ZcWGJb4ZqyU8KwWtGOAs?=
 =?us-ascii?Q?RMme6lvH0XfJyD0fxD+kA0ONzjA8vylSWE63oGIU+6aIRfUKiVISzsgAqSyB?=
 =?us-ascii?Q?OxKbRdbj4vRidz8S4QnmX2PgknJ9usrMnzPwJ2vbOmtEvaAR8b9GlBAXn3ld?=
 =?us-ascii?Q?YV3JMU4xOGIUsiO0PAkkni2yaJsVYqQT2XU4v3FoBuBLMtjHpNg+s+I4mH1G?=
 =?us-ascii?Q?lQkvEH/BsRARNJc+fq42Bit4r+nB5KnUdlkgjdEjxFaPL7V5PzAaEDN6RFJh?=
 =?us-ascii?Q?AvINn+f20RnxNUhcVbMZVwjY3w0ENLs6yrjDXSR67opr9NfztQKTUc7ACPzR?=
 =?us-ascii?Q?vs+/yYRwp1/ZT9xZol2yNfr32bGUnQjzY5cJN3dgbC0YgVhuMA/sSiLuEny9?=
 =?us-ascii?Q?mkmKaersNxpmvEczLaH/Lxmf7Ckf7vg0XssTVijWdKTaZSQjInEuDoiScTTD?=
 =?us-ascii?Q?Z0EJAUMFCSA7mO/aEjEnHjJOLuxF5TkH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D5Rb4IAD4tYPL5cD/0R5Yzo7CeAks6KdCbKcF0Xusw3OF1xOg5uBTxKgjfP5?=
 =?us-ascii?Q?5wISf9ma3kEDtUSxCYK505aO0SY+hIwTVwAuExe+pnDUBQpPDHT3HwQuc/jf?=
 =?us-ascii?Q?D8kXm1sj3mbh0C+BeLNCe0ALen3+mEpF3GsLlQmBEeD+OC5dQcHJg5GgBLBS?=
 =?us-ascii?Q?B7HsrfYM57J6Kb8WD+tImHnqkO9usRDmV1Eqnsy0TUJOp0QlIl9yoD7dpMtz?=
 =?us-ascii?Q?Z2eDD2E9TiEx1DuzEcS97JBIASs2+DnJ0yQMF10zryu+Ac+4eaYgckrSnU03?=
 =?us-ascii?Q?qcRfKitnroQQgbnAfMo0CE4y9+l1+0mOCZncSiwegdsViba63bAH9yPnwJdr?=
 =?us-ascii?Q?xnhsuN17OAQmFIXpy7vxEkrxQCn+5BEwKGs+LlqXeaMwuXryLl3JexCzK8LA?=
 =?us-ascii?Q?mqo+pyasWvNCv8ngMVzzgELYtb4mdu+LUE4w5TMjJB3FjYyCO16ppxtEQEZr?=
 =?us-ascii?Q?4H8x9uo481qH7laBqtLqRsctUUY4HV1Lbvf+0+osMHutacGuKfbJqQyxOzVl?=
 =?us-ascii?Q?t50rX9H1lahaZ6YAFhF8gOYlENJcGA8SfVCTZP/FmI5LZLnIlkCBdtxcr9or?=
 =?us-ascii?Q?1pBtSeQKYt8MqwnZmnoW68aCTp/VTZy6cUmQBndcyK4UliSLKclmY7jH8Rud?=
 =?us-ascii?Q?CSPaEMiy4lMRw6OaMSd6mJV2prD62So3zeYQ6QmBQrtUaJVV8HkLAa5iE9db?=
 =?us-ascii?Q?CZWrrKszQapGyFQgmLRxqq+IbZ+j0kUkNS2lXifzbQoEWjmQad9N+aSLi5Vh?=
 =?us-ascii?Q?wRyeMZc2/F1JZx4tX7CBpQA7wihnRWI0zy7SHvRwbL49lmZ3je4sQsKWfNIG?=
 =?us-ascii?Q?42yESvcUG3FRTrXIEN2YsyZxCXX/PX3RjB8wYtsItA9EJDH1scALDx+jZZb+?=
 =?us-ascii?Q?m5JkpI2bHGdQEoA/BZ4o7eamo1qIGVs00xnyb0UAvcsoQz5v9Y0mDo6NoPsG?=
 =?us-ascii?Q?yxvqSJfpFJYVrKiRCdK3Ox0fCHJ200XwmJ67TzhKxCDKErj/jgRc9rGEMWn/?=
 =?us-ascii?Q?yt35Fv/fb03bFRjdclv7PMe59AaTdNBWtVvK0TrvLxMTz7Ozba8BBK4Cagej?=
 =?us-ascii?Q?hZMVElOUWM2FCZYAmx24E2R3//hCfW6g1UycgfCO64VDys/mOsjA1IEelPX1?=
 =?us-ascii?Q?khU+j7Md/96bjQFGwJsK0cvOXdbnjzyWCZBHcR4d8IxBz3bXcvod/xnmj6Th?=
 =?us-ascii?Q?w9gXwVYEsIgKDHf9Mb2cee/EWlFtlipsCZQ7oPR4Q6xTHhGhl/+k+XH6mxSQ?=
 =?us-ascii?Q?VaP7KJnseENLRrPnt3jiECnVdq9DgD8fQsPKAE6Qaemn3sXP+wLCOsQL4HnS?=
 =?us-ascii?Q?WNie6MKzrFG3/c3NNaRQZekV8NrdzixhpiObDBFwDhY2GJ+uUdmQibxIHZNl?=
 =?us-ascii?Q?ZnER8u0WDLMIu6by2CCDBq9PCQC8++dLrz6eILxapL68KNiEKnmuP7CodY9R?=
 =?us-ascii?Q?3ohJGAs5FWmYYIm7Q9pTxc09baPz+6VMc8XRAZ39mULZisme+4dR/QTXSv6C?=
 =?us-ascii?Q?kXo+p/vTgiGHHO2GiAHnn0y3UmamIB20LqdP+61/TkEV5h2pVL8SjV8Fw2BE?=
 =?us-ascii?Q?ja1nsljnZgmx9zM7GZ7QwfEUOEJkoVmlZE27CEf2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9db80b-6da9-40c2-1a35-08dd5d9c5048
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 17:20:09.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xV1abIiDUbxxxho5kKg3uzIQVx+bscIoKCZxAtUmCAXViufS0s3YfMYyQO8eKVJZPBnDoavBdH04vx9/L1I10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

> ## 1. What am I trying to do:
>
> This patch resolves two critical regressions related to memory failure
> handling that have appeared in the upstream kernel since version 5.17, as
> compared to 5.10 LTS.
>
>     - copyin case: poison found in user page while kernel copying from us=
er space
>     - instr case: poison found while instruction fetching in user space

Tested the instruction, copyin, and futex cases. They all pass now.

Thanks!

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony

