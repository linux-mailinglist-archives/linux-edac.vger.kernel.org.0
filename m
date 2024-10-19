Return-Path: <linux-edac+bounces-2151-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFA9A4B30
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 06:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4461F22D42
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 04:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBC19341F;
	Sat, 19 Oct 2024 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPD7NJxM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9C20334;
	Sat, 19 Oct 2024 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729312775; cv=fail; b=lBeyRInO87HbVfrRm4X68OX6AUbyVEqgSIPzv+3ITFENqx8jTMzfZp2Vp2AhrPQ3rLedcbybXZ//B/M4g0kRCqUJM1aGx2K5vijDsX/YB9YJsiED18Y4amBYqBcUf3bOlD8dUXAshlSB0LQclv4H+3iUu64gGyhr58z8jYhixoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729312775; c=relaxed/simple;
	bh=t/049fNmKr6Eiz9VQGXhEL6LOzhl3Vfsv+Z5QsXmeuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s1XtzIu/RSQkIx62Qc5vSbyeqnShwO7j4eVj/Jo9eGZtC5DySKbuBZ1gpyR//qHeAWE9ytHIJmcwXkGYitDnFbQpvy8bCszxlMLfWydtSS4tvKIs5wIglHYk3GV2E38/5jW/6Lq6nv3bxsV/W/XU25vXh7qpdwnwSZFnwufjtGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPD7NJxM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729312771; x=1760848771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t/049fNmKr6Eiz9VQGXhEL6LOzhl3Vfsv+Z5QsXmeuM=;
  b=RPD7NJxMWEmBZfrUmq73lsxTesyyDSJPGcsLgBg+CvcTr2i51LZTbvw9
   VA9GHujp+oYfKREdaUj+SASLj+6uWfZ/3Skp0ip8eQQR5xhB4grZcYcD6
   kZ+sdFVkajZKeiybnCFtKEeONmd0RpoC02JCMHxy8LUSboy2arW9cb5u5
   t8Pb4J5UU26yk1jNpgWOypwmMvHs+9D5e42PS7ys7luJ0ZF4zzVQssdof
   edVnpuDUY2xNN4f1h46pqB2l6fXCr578m7lJXsX4xtdySPAqo5c+sLrWX
   uXfycjzqLTlOTCESsDXcCYg2xd5TDcbmlDlwrEsSxsEwuhRdfkRKaD02V
   w==;
X-CSE-ConnectionGUID: lsNFl34vS/O3Pbgl0Xq1Gg==
X-CSE-MsgGUID: 1zSQNalTRCy04hx8GZzAOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40253379"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="40253379"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 21:39:31 -0700
X-CSE-ConnectionGUID: HYSryCK/R9Gp4a9QWUGbFA==
X-CSE-MsgGUID: 3WJjGsdMRMuaVnhwJ+w87g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="79859220"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 21:39:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 21:39:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 21:39:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 21:39:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZDgqMHZCuDE6+YVWoxEykGVVz4TyB1WUpJuzREMaZQeKnQxdcBJ480wsT44lBttUT3li5RgDbRweLts+010z+npU78IFtrWcD9QJw6kQi2/93zxj6ySMj4SrELlIUUi6Ci1ZhjyuGI2DN5rzLKa/luhi3C1oFp19mwobLH9g5/IXJ7W91jcsYZNtFOrZNVVYJgYh+U4SQQeOatW6V7Eo8E9gV90sOgX3mbh1ejiAGDSrkPIDXyaPvOkg9BfkgJroyHmC6yg/J9k5OqB6M3apbVkmHqwSvLzntSGqpea+mJH5eg+NWCfJXfdvUfELC8Igfa9nQUyrAfW48vL2GakaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFvG1gIPDpdpv36tGNp80dKO4EuOROkswcaq50l2xMc=;
 b=bHSV+dW6vjRmWGAp+Aa/KtozwAcMSrfrxSUR4YExn1Xrm0wXCYJ8XggVdfg3tfyB1aHnu6y2AHkJBuRiEsnR7gY8SHJzMEXqlQ1cyBhgVIvtaDf9lZxCD4z5VTEef0D79ObSwmC8t4YCG5FmfR7E5Fq14GytJMuIretTfQoIJnxgnubyIvQsefsbXexaAhdN+F39HSpIOmZNjJCxRSgnZS/GU4IWqaHcpAsOJ9RK9r1SIZrnwTOeujeK7u8RsWYwaUu16YoX6Ps9etIlhVPAZnph+WCM7LV7SaA4varNDzfYUhY8X2BW7+qzuD1YUtXmcidGEODbCOv4QNJDJ6HIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Sat, 19 Oct
 2024 04:39:26 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 04:39:26 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAIxC8A==
Date: Sat, 19 Oct 2024 04:39:26 +0000
Message-ID: <CY8PR11MB7134B4D87A55C6680D5CB0BF89412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
In-Reply-To: <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB6238:EE_
x-ms-office365-filtering-correlation-id: 0e1be5b7-6222-42a1-c054-08dceff80375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XQCO4euIq5BIpcaj6YJ5CiHtcjF+WYy8HcNJ4p1AINinEAG085o8aHZ0kJkB?=
 =?us-ascii?Q?VEisqbdGh70cXfsWZDj4/u/g4muP+i/QmODP7SgjzDrWvzQHa5F6rSkjm42E?=
 =?us-ascii?Q?el2SLX6NYsdp/IynWeUlcIk6/QI+eI7cfmsfB6LoxGtrFqsNK4lHw4yQtbbm?=
 =?us-ascii?Q?zCGEiyGwy6ivhcPBwwov6EUxA+7hp76kk5/ivLS2baCOwsPPVz1vtyA3XIcf?=
 =?us-ascii?Q?ttZU3EWer2M2thUJHg4EAPuUbAHzYcVJw4z/SqVvYX08FgjQt1lJuy7ZaULm?=
 =?us-ascii?Q?TBOmq60qnnQXoq6oVCj6cypOTYXQUkQpzwyFQ6OsA8AahRhqdPcCCAKo7S0s?=
 =?us-ascii?Q?Q7uA1ZSS0Rzxf1WkjpbzcMd4cbEOf5m/KsPgI4Z0n94+Mlh4K2kB/8YpUlhk?=
 =?us-ascii?Q?RDYFT52+HTVTIYQIBTYE9sT2CVys5Eg6MGRJQV8ZjBan74ej1/c0zPTfAW5B?=
 =?us-ascii?Q?g09un8tzuKTtlTkSU19Pmr0wAdWHa7uGJZza75KuKE9GwJTHz7JqbNL1xwqh?=
 =?us-ascii?Q?gGtm6aSB35aJu9TbxYacdmMQC/VXLgO/VWqMibwqhymLB7BhiO3bI8mO1OEZ?=
 =?us-ascii?Q?ryr6WqNUvI8VulJnxWQ0Z2XcT0QYRSyloSUl7Yqee/6GtS2C5MfAry7Nkwgz?=
 =?us-ascii?Q?RB3YvJfDj0uGHhlwIP+tWhciK+mzrxomdNFggIrzBWl+LJcfCQpsT5nS+xks?=
 =?us-ascii?Q?1fU55T3I4kFxmPcU5gro1xLzI80Tu5ur2LdsMg45vDtjEAEb09Yr8QD7QAtl?=
 =?us-ascii?Q?fOvOihNnCZZD9xfqvZyV2+CxLgYjV+eVts35etjn0jtQIKKT0kZPJgRkDXo0?=
 =?us-ascii?Q?f0xhbJMlfd8AEeEmwWc1jxiH2j3/+B4Ff98TGYqaYKCB26PsGngrSxKalkpG?=
 =?us-ascii?Q?xGaU6HbqYDOfvHu5aLBblndCyRGDcwK0TMohuZTqGAjnvKlJzCSipU8iVbN1?=
 =?us-ascii?Q?hnNThk9T4aCwtT6pdccGvirrDz3VAlf6V9fsKC1wIEvToDvPlDQc2g99EBrv?=
 =?us-ascii?Q?Ps4rL1ajUNn2nNmidLeyyehniyMsECBfBNENRLVSJE2ixgW+DwGEKUcTrLWm?=
 =?us-ascii?Q?1tLktLOLtwhsWKjjJ5ZbbHCtGCj2XMsMOhiUKPulT7IfcZdN2ekZdbiAYjA5?=
 =?us-ascii?Q?hlPmxpFSbe+08EIRUwmSJ54X4JgUI41fdl6NHHX7l3etWb3l4wa1YIEFxYaW?=
 =?us-ascii?Q?GuCc5/pGf29ecp5MEo3ceHCGOcvx1hzkRqkzosDsfIiX4aw/cHWrpuAWN5ZD?=
 =?us-ascii?Q?UHHxXvuwkWd6cRIFXonQ52+qT7D0+CatXy9Ciqh9+qAq0pIaTfNMRjHxhu6y?=
 =?us-ascii?Q?z2aERKFUeFjHlH2hxPiLQUAX2CXMPFq60vTm39Tp0XBzO51NnVy19KxpETVk?=
 =?us-ascii?Q?2LoyRq8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2YUwVymo32kytAkVWf//CJRYw68E/sEEhufpEnGLG/sF1Ydj4rrq57WfuqN?=
 =?us-ascii?Q?4qjMFZNE3mWJHuhSouL/RiJnoPnOt8PwkJ2J3gDNr2yjbFoAQd/jRPXQPRWq?=
 =?us-ascii?Q?M2Xs6Pj02fiyNaYAhxdi5+2RFJlZhemBMfYxdL7Ek6BwyRHozsQ+h17jiRxa?=
 =?us-ascii?Q?ZUn4hpMk7ECn1y0v9ADDl1vdhkhVZSJmxENfNyqXBVNOdfFkO6YD8mebijFG?=
 =?us-ascii?Q?mbR/bAjOcSHqvE+a3OJ8U6zthG9D+rIYCj9ND8QrQ4beOYmOlG1j2Ci/HKSE?=
 =?us-ascii?Q?kZAYmJB+phxkw3V1MZn2qLYs6SVM8YO6r8GuOSpVIvhkNx9BuiR8MseE1UjX?=
 =?us-ascii?Q?HgPPz5gnjTD7UYQSRfszVwSwLQJP3LWO0Niwfzrys1tph2x0DbBAee+8aREe?=
 =?us-ascii?Q?9CuHhzQJD8QanGCZFRNAiiT/HWq9ibtuChOOoeRIOQddG8oJXf4Rj+TFDNpM?=
 =?us-ascii?Q?myVHQKopywXBpFKCVkraPljy12LhamYcSQEsH3OKZ9FYSmH7KLdMJdYru9mb?=
 =?us-ascii?Q?HLXhlkq1LULWAB4tQ1+KQ8DlJejM+wsSmzs5KcbLV43aejcWs4e+gooVSlDW?=
 =?us-ascii?Q?xqeZaOyiVltJyBOha2uEC76qxzBD7Dzu3TNO54ePGghe9JdWc4Q0Qy4h0f/O?=
 =?us-ascii?Q?QFl8XcNNp6pxOAJLZpsRbDwiR/dcK2tu177NRP6jF3ihEUjNRpp1B3wrPcSw?=
 =?us-ascii?Q?Ft5/9bEtH2rH8DC+v/QE8pcUk4ZGLI1eoDXf7vOA6k8GXz3wLGfuwSwZkn68?=
 =?us-ascii?Q?HOtyzaa887R/ZKYcuWdfLvWRiHlKZ6mXf4NrG7PhwHXuB4fYuCDpe0mlsCBu?=
 =?us-ascii?Q?6AQ781/Gpy99J2cAn7inALQKmClv5Rzcx/ViECwU3kgf6cN9vYSwht51Skja?=
 =?us-ascii?Q?QeTck4pBDPF3/Tu8u0WmcgnZDIWk32LE+hTsTGMc+xvwpkjDhJBF928vyJlM?=
 =?us-ascii?Q?i8K3hjJoM5Kjs6ZZlmrmFgw0iA0snhF7mxoTbs0J3SOLTLWJ7Ybm65vDI69Z?=
 =?us-ascii?Q?3ZCgQBnNJNNoMEhYdBPCqPu8Cko+yC991fQSjKycI06vDZs1iFtLq/qbP09Q?=
 =?us-ascii?Q?OeJQkkSSHlCOYlojdtIX2WuBsuWyeS+fhi3RPuqLxaI2uVBK37FGV27Hdl0j?=
 =?us-ascii?Q?VI4lPkm2WfkU4JGp9dEY+IUjCRtI44hXALOiHl9GygHVQzP9h1+jy+7Knd3k?=
 =?us-ascii?Q?ycLOPYjDFRstST5HjC24kfR4ogT3ilfn4gajos1cKgsYmhUiZtS7OTieVojY?=
 =?us-ascii?Q?ssWFIZ3pG7Bdx9+txzuU9TFHZlO/O0ZsKTHRVnK2lP7VgE8ME/j5X3Hg1otj?=
 =?us-ascii?Q?DlZBHFD/JPpUuu2YpN9bGNLqlthDiWIHuWakAX8M+mVwV7eKaXW4+vAValvu?=
 =?us-ascii?Q?pJKlYmT7DvznDt60Fdm1ImBuvfTPTuU/C0LDfHPPnbcBXPnJ6iTuCiMor6+A?=
 =?us-ascii?Q?uBsypQ5Kq+CaYbMKwsplUz4FeQc86kYY9uWmTB76LPOl0gPNWaZOBeksT098?=
 =?us-ascii?Q?rx1wNicfEli6HMfmcXAjGHhHuOY02tQy+1+3M4qOKDXoOgTqj+2rio8qa1D8?=
 =?us-ascii?Q?Z8EGn6mKLl0gZVmMTiX3C3ihxurh7Nex7fyStgqm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1be5b7-6222-42a1-c054-08dceff80375
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 04:39:26.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpvMD+vuqtbTCQxeYIx54TIo8AorYYWI6dbIhCfraptZWFIlIXMATc9nnVdjfj3d7O62jT7bLz8zGihrR5ftWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com

> From: Luck, Tony <tony.luck@intel.com>
> [...]
> On Fri, Oct 18, 2024 at 12:44:00PM -0700, Sohil Mehta wrote:
> > > diff --git a/arch/x86/kernel/cpu/mce/core.c
> > > b/arch/x86/kernel/cpu/mce/core.c index 725c1d6fb1e5..40672fe0991a
> > > 100644
> > > --- a/arch/x86/kernel/cpu/mce/core.c
> > > +++ b/arch/x86/kernel/cpu/mce/core.c
> > > @@ -1892,7 +1892,8 @@ static int __mcheck_cpu_apply_quirks(struct
> cpuinfo_x86 *c)
> > >  	}
> > >
> > >  	/* This should be disabled by the BIOS, but isn't always */
> >
> > This comment is specific to the AMD and placing it before the switch
> > makes it seem generic to the entire switch statement. It should
> > probably be moved inside the AMD case just above the disable GART TLB
> check.
> >
> > > -	if (c->x86_vendor =3D=3D X86_VENDOR_AMD) {
> > > +	switch (c->x86_vendor) {
> > > +	case X86_VENDOR_AMD:
> > >  		if (c->x86 =3D=3D 15 && this_cpu_read(mce_num_banks) > 4) {
> > >  			/*
> > >  			 * disable GART TBL walk error reporting, which @@ -
> 1925,9
> > > +1926,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c=
)
> > >  		if (c->x86 >=3D 0x17 && c->x86 <=3D 0x1A)
> > >  			mce_flags.zen_ifu_quirk =3D 1;
> > >
> > > -	}
> > > +		break;
> > >
> >
> >
> > Also, why not include the unknown vendor check (right above) inside
> > the switch case as well?
> >
> > if (c->x86_vendor =3D=3D X86_VENDOR_UNKNOWN) {
> > 	pr_info("unknown CPU type - not enabling MCE support\n");
> > 	return -EOPNOTSUPP;
> > }
> >
> > This seems to follow the same pattern as others and can be the first
> > case inside the switch.
>=20
> The vendor specific bits are large enough to warrant their own static fun=
ctions
> (as we do elsewhere in this file).
>=20
> How about this (only compile-tested) patch?
>=20

LGTM.
This makes the code more structured and readable.=20
I'll replace mine with this new patch in my next version after basic testin=
g.
Thanks, Tony & Sohil.

-Qiuxu

