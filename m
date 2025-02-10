Return-Path: <linux-edac+bounces-3002-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA0A2E639
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 09:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79591886BE0
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B951BCA1C;
	Mon, 10 Feb 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwKOkTCJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BF1B87F1;
	Mon, 10 Feb 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175657; cv=fail; b=nsCcvRW9Kg1NuCj9qlZYJLvVK6ZxROFcYFxaAM0+tKJfhBNIQZSol2qXOjD/AML9/tJ8J4UCZkX2CHDe4sTh8/ytkgQCQ/mzwiIlwCGNtxo8LFSkHpCOphtvhGJmYfafKLVqhvP8QLsHhToXpMZYhsd4YRESPt+VQdxiJuPeIeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175657; c=relaxed/simple;
	bh=15Du14TFekRzsLXSMWMsC++fKNxPxG6ClvGhThMVivA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+PeJNsdEeT5CKT6eJWqIkHcr2Db5y940GiTLL7c7uF86Zc4W72Y/jR/OsU/PD31hSzHMuoTxG5ESryv5IkPfZLxfl0ZWEpZ3/5OVF9/RsnHiD5I/dPyyvE7YhJYB4CGeEXnrviTG9hdXFrpQQE3BCQdMCsj8cScTSjE0kHGf/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwKOkTCJ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739175656; x=1770711656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=15Du14TFekRzsLXSMWMsC++fKNxPxG6ClvGhThMVivA=;
  b=SwKOkTCJ+m/t6t5KmwpTiyigGGfhasd7aHvsOWoVop40ftNEtyuEU1Mm
   gax0LBRkHenGV83i2xHWaH25Ccp52+QOPlkaI28B4CNdwZ9hcNon7xWGm
   Ul26FuA22Hg0uv8hqYndkPFGsh3EoOOAqgjCiY4n0aSbp1j1NgwRRWLjP
   jU3zo8RINdH0hIRzln8YwrHAFlySiPzIkswaBpHoIpFIrAqQD/XvtsAeM
   00S8Ei4pqNrA6qir1GgRXl3pa2wlds6NfX5iUcoURTuUmAtLd+W/7f8vT
   IidE14zqKStl2pGGtWvaFYXCNb71pXGFGSnUX8o5r9bfmjlhGDYH2Lty/
   g==;
X-CSE-ConnectionGUID: NlYEpJ6rSIaR9seIpZc40Q==
X-CSE-MsgGUID: UlaqR1YcQXWweHZbUjT1QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39893385"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39893385"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:20:53 -0800
X-CSE-ConnectionGUID: KBMyPM+sSuauM/1EzNC2RQ==
X-CSE-MsgGUID: DAZ8U5QkTwS69sVa4ZbevQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="142981215"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 00:20:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 00:20:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 00:20:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 00:20:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn3r19JNjK3f49Cl07JvqxD8XjKUcQ4pFMfQ5GGTUNJPXxDbgB2xNrQ257kGfgSGKXGIlQLbCVRe5hu6RbQ+NL6ocE7jSo7jE/DIfNqNo/T6KX5R8rIFxrXwBBSrAIcI8dmwlr8HzZuUeEYCeH3HimMxsa1IB22OxrZfIsV/NgtS/ajeKmtSrDlLSRQNlfXZH3THwW9IOzxqh7PVwqAkjpf0c8SJUYG80DOeDabKnzvuoG0fGxr4P4pUQZW0khIJO66h5DQisoPbdPCH/0pRxbUr7wfihwiu8DwNLQySJR4R4rW0jWww4YNPJ6TiwBm7iUz9czz7YuNINMMDlveiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL5AOE6wXXsTDtH46dL8bfshLhDz4vdpc1bMptU5KLY=;
 b=mFEuT4vtdn8JGBrwNrQCbaxBexOPnEbr/lxMo+dXjp7kl02t1xGEKhUMQpup6u4vceKjb30d3TP1rgqzvi7fimaciSsbCE9S7DAqExb846JmtG5dZq6Ezi6wnAXfjZ1ZdGlcs2/+iLIhjjOsYGI01pkkP++pY7YBGB2kTIV6JKo4LM7TQFwF49MMpmUcBMKbuMJE6OkL62/LouvIQ8X4NxQz6S9PwxH6h0UIipQ3zcxMvGZqTL2COca5kLXFPgthR6q4IokOB/d8Hy3NzzCetSN66qG177jRec+kd7BmZJ1kupFsx2ugCnWBYQgAMVMi37SEvCS8Wdeon937Z4Q65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 08:20:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 08:20:41 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, "Luck, Tony"
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Khuong Dinh
	<khuong@os.amperecomputing.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC: Use string choice helper functions
Thread-Topic: [PATCH] EDAC: Use string choice helper functions
Thread-Index: AQHbez09trFw1SRdakaipbq1YcNiDLNAMl1A
Date: Mon, 10 Feb 2025 08:20:41 +0000
Message-ID: <CY8PR11MB7134D7331909AF9D8FFF162889F22@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250209215222.52260-2-thorsten.blum@linux.dev>
In-Reply-To: <20250209215222.52260-2-thorsten.blum@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: 4a01c0dd-4e09-43cc-4111-08dd49abcea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jnPybDCXGcHpGEKN+J2u6cbCbWMxf6JZrbI43rV9AqFs1CEvKfjWCyJzdYS7?=
 =?us-ascii?Q?O+vIlQZG2vfGC7OZ0Ah+r4uhaiW8NH6q/DtAYMZgAy+tPmx2iOz580gX9XBy?=
 =?us-ascii?Q?UnRAcnx78nMeOvXYPE5MJv5tnLlv4ju0Z9Vjhw8wTrLB0UXCrYtGd2bgZRXr?=
 =?us-ascii?Q?nTT4bN9brcMJwvdCi1l18ReUSqQgtXKJJ7ECuBm0f8SLqMsm+rYck6ZmBhbi?=
 =?us-ascii?Q?MeVabRarYNsvOfSmwv6Pt7qWn1VMlCIIFF2MElXhYdjh1py57D4w0hmJWPyW?=
 =?us-ascii?Q?sbzDeixOhIQKkSlL8I1gnbdJbpD4ewuZ5+2OPoRjexrTi10b3rMZNhyXW5tw?=
 =?us-ascii?Q?Zd5b2xEOd7fVX1HWIqMGbFX5r+5BG5vu88Y3ZQeRKQ8QWPQJ3tYm+PGPUO8v?=
 =?us-ascii?Q?3vsjwdC3GuaUl0QJvl5J99DpBtPO8A8UQnJ2j3TX1X+lRGM8PbL9s3LxMDk2?=
 =?us-ascii?Q?Xw7TGOWntJ2RX28pOV9NylPXvgkn/oJf5S7yLVnY0ezGlq+ED+FHN3NHN+zp?=
 =?us-ascii?Q?anxkWC8FrVKPJw/dOBUSr20Y+qQUxI+jKv+pO8urKQsNbvBrtmt311aotUIg?=
 =?us-ascii?Q?cqR3v2hBPo+F82EH09h+8HWaUEGgoC000ifdyxbAGw7ICvbUB1tmRr2gbzKO?=
 =?us-ascii?Q?I5blaSgz9/PK1ZJkU578KXzag0m/eiYxaZxplu0i6V2czRNK83E1w0f6OJNK?=
 =?us-ascii?Q?hCUQNa+GPVLEJFRyR0Jtmb/OJ+ZadhwLjplTgStFi8LT3bRZDxPH2xfbZCAL?=
 =?us-ascii?Q?n79MBnUBaLpboxYpOVUrz3GDE08injW4ddfFswvEJUvNjUMGPVv8yOUJ52CO?=
 =?us-ascii?Q?X32Glka8SwtQMOqYGt6dTSi/wYKU9Mx20ZFVcjJgWIhzKPUKxxggZp8KV72T?=
 =?us-ascii?Q?sm15O5D9tn1ulDGOT5dFm9sujZFIOyc8vE4zhBDmjmw9jvHbLN06mlVj8nfO?=
 =?us-ascii?Q?gTCjrgKwI/Qfvxd1H8VLU5iy8Dyp0t7eA5kvh8ifcJzGwp9N+roG9SubDV6k?=
 =?us-ascii?Q?6l3C9zilMOlQ1zX2thwmqoeqOpjgOX5MaTfPhUejMa11UMNsQpMuC1rTtk4y?=
 =?us-ascii?Q?fetLt4IrmiIHGzmVJ5NXkpa0NeminAar31GJtwIvdWD5OmU+S0ygHcn2ngUz?=
 =?us-ascii?Q?bFG91oqXFhfMePNNi6KFkByHWHSq4Ipzw68OOaRZGGzbGHxvyuT8aGLUl8os?=
 =?us-ascii?Q?Y9Pob3yksGB1INpCLUjMrONy9zAdpl7kx18Xv3fnA0b3rwfXlBSpJ6mSn5xY?=
 =?us-ascii?Q?r6Bw9gZ8Qm+/MRIAUEU3xfOTqtn5E1BhTFBv+K9iIerAjHShNtNlBz31bER8?=
 =?us-ascii?Q?GUKZhLYWqPU5UNFGyCg+dRZ+l7801+jibJvJQqvPliAwzYYBwLswdfvepfZU?=
 =?us-ascii?Q?tcQvwU18fPVaIreJ/RmyCZGKSgygjDP9baYm5f0twuYZdOqullECzGAVCyET?=
 =?us-ascii?Q?lH48umSVq6QSHr0B5JQfHthwBNnMcn8u?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1QKDq7dXjvQhMsFyfM2bxWRyQtbpHuIRephty6iu31qR4+bNxmF5NQHcN56W?=
 =?us-ascii?Q?PhYTOSgLn/t15wLFAcIZK+W/zM0jUGqu0e/NDftCxDRgPYTJ/5Js2wsMzMd8?=
 =?us-ascii?Q?0Pjvm+0T7KthR1fcVKYhTJ0dRAukQEFNhc69JQC1dcY/HYOJc4AKMbnu3u7a?=
 =?us-ascii?Q?OM0uXruU6mxDjkLQg0Dr8mTz6h4ruPbusnTl2+hROIJhtQJVLeLR/tLuCEzN?=
 =?us-ascii?Q?vd2MEHUjyrtgj4QDAeV21NTK+hQE8StpF3tcUuW+dNetJwahAoIRmePFK+N2?=
 =?us-ascii?Q?Y9okyKyw/PtUrQdtTLZ82qRHlGfEObcwVPcESpDAS1Hoe3gyp4TAgggbQkqc?=
 =?us-ascii?Q?GXSotEgCtearYlDGa5id0hBKDACmkKrmq25kXbpuv7BxVKLIiemQ/jBjjFXa?=
 =?us-ascii?Q?1RbmlDS+iLdmESv2QSeA8BEFDzvIgxpHqNtG4CZe5A/ZFeCXBeq6qZEXlx5n?=
 =?us-ascii?Q?jSBI+CTqOQUtLw0M5SFAHnLWStAhUj1pXfrDkjID221Gtpv81oFUypQ3dm3v?=
 =?us-ascii?Q?ozboWj3MHrUasZBh7EJ+w52iKcSoXxNa2qbkJTvmqLoU6oBi2kYP6yTe3Y67?=
 =?us-ascii?Q?BHfQlHzaRTIBVWz0g9bC98FRf3He50gZCRNa7OckkMb8elhBC+7iBQsGERfg?=
 =?us-ascii?Q?cVFDuXmx00Wbg9oYSQfSqhTPtldt0Kv+KVTh8WZwWWO82GWm/72vHxs3vmYj?=
 =?us-ascii?Q?t6Ojf7lf46O5xWm+Xghlk/B4UCxcaRFwJct0BBs5N3GXOJoI/xBwVEvExlRz?=
 =?us-ascii?Q?QcV9t2B9ZdqbT9GrptGWrLMJ/crTnuhkpJ5P+GGgapdUbePDUBsTkyHQRkY4?=
 =?us-ascii?Q?F+VdkmCymofC1WzfToA9js4F0mdHDe4x1YVVktvB52vzb10/K/8NaSMMOXY5?=
 =?us-ascii?Q?8uj9uysstKtnzSwOuHPhLIPLaGbb2sTo3FfejrgjJW76yu1yiSE/TtkXgug6?=
 =?us-ascii?Q?KyYj+Cbd3ntDrZ+D698qhtIFcEvivLYnGpxWKIn2XPyred3OyxcjEtT3y3bX?=
 =?us-ascii?Q?YBywrXcTAZuiAdPLsfRLNIHz6NVCZ/gEsuc5b0jN9XoyGxtmNXW4jYynBX0K?=
 =?us-ascii?Q?1NfDKFQRyOZSWcRKts5XyXd94GsnRCMCsLYlfJMj5Rq0C1tluLpxvDOHwOum?=
 =?us-ascii?Q?CRLVf67WkjEY8goTOhc7OQC0zEvTQp6LMUF+EdKQWOEj/P4mARYKaMzaPM8n?=
 =?us-ascii?Q?prhSepDl0V5pKxk2e1DoT1bD85NBC4Wj+3SPULBkGqKgqp4bYJg9VezmC78t?=
 =?us-ascii?Q?+yxLkVKSyDEY8EXvN/Qn69nMCPBgivDH5xHLObROjWHIhVwQgpsZcJNwQdGe?=
 =?us-ascii?Q?uOpjPlLm/9qfSOPUMvmIWbsHzcUh88yy/FTaiijmWt5MEzVpljBW3lvjbAQr?=
 =?us-ascii?Q?WRYBIMHfKoe8kuQ+gA8o9icpKuTE+YmsJ2lmD3Ag/yOBp1lohURl4dRX0uVk?=
 =?us-ascii?Q?6J3wdXPoZUpJIuqHirXbx5uLvaKaiHtvg3NjKGatENkaDrXU6VwgqkC0c9RZ?=
 =?us-ascii?Q?7dZmcRFteSloH4A0uI1hMp8jB/NntmtXaZEitnUpMSF4Zfpz80VUYm37cpg2?=
 =?us-ascii?Q?PTrU7tfdpzp88yrGUlxyyDgflOJflhZwfKkk3tfM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01c0dd-4e09-43cc-4111-08dd49abcea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 08:20:41.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ox214A7TJxk0oS4oTYjfdxHMeMs8Oed/w4TmU0RqAqiN5switIwQ4YgXV+I62bwdcWIBJsbf+JXZsAeLXoSL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com

> From: Thorsten Blum <thorsten.blum@linux.dev>
> [...]
> Subject: [PATCH] EDAC: Use string choice helper functions
>=20
> Remove hard-coded strings by using the str_enabled_disabled(), str_yes_no=
(),
> str_write_read(), and str_plural() helper functions.
>=20
> Add a space in "All DIMMs support ECC: yes/no" to improve readability.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

This series looks good to me. Thanks!

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

