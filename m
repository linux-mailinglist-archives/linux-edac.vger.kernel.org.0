Return-Path: <linux-edac+bounces-2683-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228379EB8A9
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316301888C93
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194FA1A9B31;
	Tue, 10 Dec 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWIqCmzZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF186358;
	Tue, 10 Dec 2024 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853071; cv=fail; b=Z38dWsYHsoN7ryagNcUGEOBVVg2BRgBc9dLvbtbm4K2R1WfhAmehuFQjI/M7jPnSI3OPw4Wf5GU8ZtjUif1XkDavjkNpn1D3fmVKO91NLLy4z3FgQifKNYd3hJjofv5Eho0tJ8I6sCnOqoDswTkrJ9Axz18dvaQX+G6xZALrI74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853071; c=relaxed/simple;
	bh=7PyoLFftSdKFMWFHGS0oEfqMQcV3GYFRX1hvZjxutV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jOju2e6iPXUxW/q/Ur5zP2jEfjJS5vcRwvsjxF/QB8qYuwmXUy3MMs8UPbEI1ttU+E69uj6LSq3D9ue7ZD75O4jIHRTQIK6F1HSmkeyCTRGDU6aAZ1VX6ELELhHeDToBGG3x3HWhMkpPQ2ANcQyDkGlXd+vP5hKXk9eNamlIVr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWIqCmzZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733853069; x=1765389069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7PyoLFftSdKFMWFHGS0oEfqMQcV3GYFRX1hvZjxutV0=;
  b=WWIqCmzZZEslNUuF2T2qbsn+9lJDA9WiRG2U/3IakmirwruTv2PRDkdI
   Dx7DtonlpBG9UlsP57echrfaN2qSrjaTPv1n3GHB+S9oz62bODQjbvgsw
   VTj+/MhgAMQi7YcEM2yIkBFX22JKggs/y6nvNwrnEbPVCNNSWUZPWEhVs
   et6KojA7XKDZYcJel1pd3XWDvjcl+4kTEn7yCQI6jiJRHn+A4kXMXOPFP
   1GYPy0EjbiUJdN5/opN8zXxH3JqTI2b4sJSeHVvXEQ+13aNOYVdOrWSXz
   +W45hIGUv2fszO1PsgDltokOXntzNMiTZrqxb20nQul7WXJWTUE/4LGb0
   Q==;
X-CSE-ConnectionGUID: OYBLdAHYQ1ee+2jC9SRMIw==
X-CSE-MsgGUID: VEFD9mg1TICSA3Na18qcTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38137164"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="38137164"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 09:51:08 -0800
X-CSE-ConnectionGUID: vm9t+VvWSg2IEakY6sHFkQ==
X-CSE-MsgGUID: RRsgZ5CWQ6aWfrQsx3ySkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="100525746"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 09:51:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 09:51:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 09:51:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 09:51:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFdVeaXGPMMSSZ6srEH8VDnevc31gcrVPvg4yWM+vOmugcB2aFf9Sn5IWl3JxhMzIctX0KQhW23NWOyqv0lY0m+BpT/0WtRVH6xK6+8feLrx6a5OcYeFRr4VGtGstBYyWSZhJGE5shzQEFuUfUtF1OB0BihVbfOurlwNeSIJCSne3vAhyIrSidQ4dkv+YT2zibbDSb8TzsNlj7jHWX8+fuNDpxVsZb0qYD+BDzulQb8XpP6NtiWwI1VCmwOfbP/CJ9OuQW2yaAFztttSwe8ZQtbtXTVOElx6+dQ/LNyZjJ3HWB2tUs/cRPPq9PR2XGtESa4sbu/WANaDEmCZmt344w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEhLLuKVtjma12JqPLc52U43MxOPn2bUojz+m6mLkIc=;
 b=cpOqoO6nYEbfD+lpVzShpnWYzkui18fnTLSDaBRYKYy9RsgYZrEXfMNEYA7c0MY3CQoChLYqDEkT4gETZTUzQym8OOwXq5/FczrLnW32uwokXk5sSeD+lIKy+iUJ1auHFI4phbZ3nC1RpLvu7Vi6H+RMXGvsj3b8xD6kYK9n6czFeMn/lt1FefYTygce68tBIBhZKLyc0B+BUJpY8BSRifH4dj2cVK9Og5szEe9bpU32AgZTZfyfSUv41h1PKnZlqdE0pnVy6SsTX13AGd4pC6zdg7jfav7oOQiRQ3bIBEWNBt+3uiwJit3ohS0Q/cA5MKMHub5hojvGTR7iMIh1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 17:50:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 17:50:58 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Meyer, Kyle" <kyle.meyer@hpe.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Topic: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Index: AQHbRzdYr6wewCl8WUSfAZZpbFHGCbLYE+DsgABRaYaAAAfzAIAAEs4AgAE5QuCAAA54YIAF7W4AgAAN+nA=
Date: Tue, 10 Dec 2024 17:50:58 +0000
Message-ID: <SJ1PR11MB60835A3F25BBD97A3B135833FC3D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB60832217752DE71A4ED1054CFC312@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241210163734.GA3244835@bhelgaas>
In-Reply-To: <20241210163734.GA3244835@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8561:EE_
x-ms-office365-filtering-correlation-id: f538461e-8fd5-44fc-2142-08dd19433442
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9m6R4ROZjb3ZLl0QTPGSqAg2WY+CTFYj6Qto3FQXxseDBTKeuIlVBbhePt/x?=
 =?us-ascii?Q?MCkfIMyQ4TRtW6sDBTeA4+fYhy7S+QpdlFols9AfyYZasuZFc2Ry9kJnXSQ1?=
 =?us-ascii?Q?l025AFDMC4vtxnEg5VInnAC9lxIQTal3C7GDk9nwUhhRewdD1EBtPdWJPvh1?=
 =?us-ascii?Q?C3lYDKWSWGQ75vFq30HIl1XyrxyjLXAhCFy1gdhWusiDFl91RJ2j6N2R5/FP?=
 =?us-ascii?Q?/PnPGKQ8h8TbxsqU+9DjZonKFCxePI+8GRPT9PrP8DfUI0EMoVF5EVw2Liqr?=
 =?us-ascii?Q?0y7G35D5lkmcy9zkawzOv4HxS0sIqkuCgTP0pAiEW+gsPntNT4MlF1eOrGmY?=
 =?us-ascii?Q?E8fy+0Zajca/Le0FMaTb7MIyPV+eri3GbCZYHBGuM22E1KoIB9oe7ZChTTel?=
 =?us-ascii?Q?Qo+qLVZ5opRWxIf01goIrYeK2XHIs7LT98ONkIALEjAGEz2kvInBI0ykZApS?=
 =?us-ascii?Q?Q6wVOlBzwO28yoe5RO0i8EIUmzYM/bnsZpp8zL/D3Ifpul7QMA7IZjg+4FzB?=
 =?us-ascii?Q?J2mBe+jMNLemaR6cACS/3XAQXY2tJqWK4SuvcwVWSdXCyRwefJf4WPoGLQmR?=
 =?us-ascii?Q?gumXj5PD6JznUdak3N7jSuenLBTjZHr2W+b8C5S2ihQISWYkRQ6ohEf1Gfig?=
 =?us-ascii?Q?zoRJ8iHbo8yvgm4P+PUQfO079iNXHUpGAK/ehpl+hyqDM5pNSZKFlmLdaC/1?=
 =?us-ascii?Q?V5npupmVWhlmlh/Zdu8N7CEy5KQaZw4jijFqOdUoalVqAoxUTpgZnUSxSYP7?=
 =?us-ascii?Q?adZedSfU42YtRFYe86Drqmx+Lkwc3dLajxxAaDPHtFwPnG676LcBATeSSnRL?=
 =?us-ascii?Q?cjnY9zCnq3FRZ67S1U943qV3W6D5FRPQDgWxvsOWf0hAUEj8G553TS/GYkFz?=
 =?us-ascii?Q?k0KX5T+dKkfJOZlPGCDF4FQaInitvENhSyH3aU+1wvatE9TLfQ+8/i7QN1m6?=
 =?us-ascii?Q?SKSpWygl4M5dYevt0RYTJYYgl3Us0AflxBPYyQykg6oORs7iDJcZSDC3u+Va?=
 =?us-ascii?Q?WFNGD0xdCBhPTLOoiU3vfaUwBktQ4sVP//eEirKNcglMM2Gj5fuA/Oxxvr1a?=
 =?us-ascii?Q?Ao6lOao8kk3YxyUOdzpEmb26ouhcmwkdlel3zYvuhokn5KrVaYTmDXS6+eSo?=
 =?us-ascii?Q?R0XR+Gg657XSwZp60xnsWmsNZFsIyy/7j2OaNJp7dVNrZcBF/cSuIHTVXMeE?=
 =?us-ascii?Q?UT8NL9ajOc3zyfYLN6N+a+2qSCjDLmkG8Ck3yilDvfjJO9R/7kZxjRBdiCmx?=
 =?us-ascii?Q?8sq4/vbHdk/ZrVUnK2dL0Muo2iKB0bPZRZCLOPZBjjBj6iDs+WA7cATFb80Y?=
 =?us-ascii?Q?HvUvDCvKWT3DRy1fDpDN6s/ekU28C3y5eyKVJ//+uyep/t+Oe/0BLffTtEWx?=
 =?us-ascii?Q?VCqzcJ4e2uRiArHRHafcMqE3u9iXPJT/1NfMAowbpzrHn9lhWg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+LtlLJSbLgjoH8QWC6+97TjtfaCKxtcxBArLZsmky0k9aQcZnN46x4QsYmmg?=
 =?us-ascii?Q?J8si8i41CV9zUsSHf1wF5oEhLmccFgdwObuyitXd5pRqajF5bxCc9bJdXiOb?=
 =?us-ascii?Q?SAJF6QqA0PfZE+oLI5wStVtWQL4cOuwnoWicmIDzP8z+LK9QXeJSgqM3i/s4?=
 =?us-ascii?Q?nXhUnu5PDuqXgbdgKDDdsL9pvgSYVNGiUO3Nha2EINCe/NOwb9t/jCDSAOq0?=
 =?us-ascii?Q?apDVH/4v16s+Pf11diu9WTLJl9MrKA6+lR+TgG3exQW8gfZ3pIXMveLr9oqS?=
 =?us-ascii?Q?j1a+xc/vhg165ufHmjHp3y13nkX+vIW/VBYR2OkNRiX+FaDvYsHiYRNsyBxe?=
 =?us-ascii?Q?aO2dss0hy/B8xv52BWlO/l9IqQJx5J4ilIk8PX0eWdKirhsPRGGZIUOaOxkh?=
 =?us-ascii?Q?0ZTBF/HvDXlo4skQ3dbADYMfidtLYQWGbvRpWo1kjbhugM0DaAuJUWagNUZj?=
 =?us-ascii?Q?3HwmazoMeD8M63uDkSeMSKyOMl9V6GnhGv4jdEgqNInwDbKYpMSwFW0Gmutd?=
 =?us-ascii?Q?oUPLGJOZjutAPHR4SQagTZLV1vnZuCM4Os/YlBQ8pFEhqUv92UPA6hflyIT8?=
 =?us-ascii?Q?U9nok+SUpIFsDgNFj9hPkL8TY+9lSM6YzLUaLGcggxin97nXmt7Q/k777FPK?=
 =?us-ascii?Q?iJ5ECP1299SmBl67YZjwzbdhMgReEGQWD7NLVjv5hQiidlZWW4vdx3vB8kYZ?=
 =?us-ascii?Q?WrS2gE8gcZBrwcjDFy7nU38E3TL/uHZ7Jl3a9T1t/NG92LOtATXjqCYkHsI2?=
 =?us-ascii?Q?DqHMbVSIPm38wD6tlD7BUuLWAj3gDhNG4xPfq9Ub9uL5Tg731yIzAbOaaMqW?=
 =?us-ascii?Q?4947ZU2dGZpffjeOkJznDJsyWzii0YnYkwCHzTfNQ0n0VHIJEOM2MrgB8dPc?=
 =?us-ascii?Q?FFNXt+B5Gw8FPdOeC/kHe/BJD4Mf+vXAT7dT0SXom3gPRTdCfzOJfBfiItkD?=
 =?us-ascii?Q?6zvHyqR9byoUdGU9RaMBgO8zRlaUqqeVX53NernaTAD+NL775GRZJRCQ1I9G?=
 =?us-ascii?Q?r5Ku2kRQQy1Uv6OXbHx0MIcBxj4VT/RoQgPsyd33+ZvR8LbJ6WEN9ieh3ccZ?=
 =?us-ascii?Q?TnhuFeE7p0ob2XAd6u5ErHqwuEkYb0ubDKgpB9Cipua7sbRTu7w52WCZovqG?=
 =?us-ascii?Q?cWT/d/KZBLkxQmQdnjeUIpja5CyigGjnlQFGm8otn5YbTFGpivqenSYk5nou?=
 =?us-ascii?Q?aHvSzZtmWprDh8StpAyqxxZaMbF1A49Nxk8l8mXDX8UJjcWipc8BGQSbtyUf?=
 =?us-ascii?Q?VXSbQoyUc+mVvq1rN92DTTHWpBqIC6iJqEnHfwdV+u+YFQtAIE80s3vBWfJ4?=
 =?us-ascii?Q?z1Yw2ab0IIw2Ho0A1ki9Fn/UjK/z/fRtTlhbhDEgAQA5vs5JY2dEluWeLhUV?=
 =?us-ascii?Q?xXakm14Z3+IISdvhXRwJKrKNk2NpEBX/nzHSWpBODMY1BU11KlqfH+lx2Muh?=
 =?us-ascii?Q?GNN4+Om1DS2ANTIxpRg5+3pTFmW3ekTv/Pdopw5u7ACE6yfJQWrRj8NEfiQb?=
 =?us-ascii?Q?dJxuyT8I1Nf+4jKTxsiJwoUFXb7EO9mglrV9qWadTK1tym+J5eh1KbV92SHo?=
 =?us-ascii?Q?dUvKyGWTLoHVb61wjR2o8bUoWxjTQx5+VL+X7yuW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f538461e-8fd5-44fc-2142-08dd19433442
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 17:50:58.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKGCrtu4qK7N/YgeUMqo4TkKdPL1Zdo5kF/kdqW7nmOCILFoQsTj5mK2tCASn15kBIY4Hs3HxkL1NV9HeTZgmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561
X-OriginatorOrg: intel.com

> > What we need here is a function that maps from a PCIe device to a CPU s=
ocket.
> >
> > Has this problem been encountered before? Is there an existing solution=
?
>
> There's nothing in PCI itself that connects a device to a CPU.  It
> sounds like something that might fit with an ACPI NUMA description,
> e.g., if a CPU and a PCI host bridge had the same ACPI _PXM value, you
> could conclude that the devices below the host bridge are close to the
> CPU.

Bjorn,

Thanks for looking. Kyle already has code that does an ACPI NUMA lookup.

But that doesn't work on system where Linux is compiled with CONFIG_NUMA=3D=
n,
booted with numa=3Doff, or on a system where BIOS option for "Unified memor=
y mode"
has been selected.

-Tony

