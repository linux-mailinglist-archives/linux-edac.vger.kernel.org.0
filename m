Return-Path: <linux-edac+bounces-2911-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A293CA119C7
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 07:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13D5188A1BF
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 06:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391622F850;
	Wed, 15 Jan 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho2KYGh1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6822F3A0;
	Wed, 15 Jan 2025 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923083; cv=fail; b=sbIu5NldzO+3eBhhLXSdOP/2CD0ncFlRl1RbE61Kj7DkworIZ7fof08h+9zwIr147lBRCCHoOJBIlEaIpEaip89EmqBqv5WZZlJqLrfqwGQU2eJHWH/NVAwPtxVMU7G/F6ShqBQBqlmYh2erKpEBCvDTK/JgnJiK9UXP1/YRaIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923083; c=relaxed/simple;
	bh=cnAtmFym7cqcsnBetfox5EikvYpD1aJmwgv9UC2UZ58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gl10CAVaOa212SnFTPmuNhB87QOs/qITEtQqMsEhx9ZKDsKzLRIzJ4J/qZwzeEfi8mCapQrnAnpgiDQmxNQsumD7qq763Ct6LeobZSKCcTdUNRYPnQun8RKjbbajZJ7nbdmVjHZZdP3VvPFS8BjT+rF9+MQ/YlPE8LurMvCZT6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho2KYGh1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736923081; x=1768459081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cnAtmFym7cqcsnBetfox5EikvYpD1aJmwgv9UC2UZ58=;
  b=ho2KYGh1M/1rTMTHLLZP/U64lPjU9T1rX7ms0dppOJ7b0xDRCMXht63Y
   HJkFmvrTpckuYN0kKpN8lyN0R+pHsxMEfqDJpnu0klunCxB4NBsvXBJGC
   L1oC9WlH6Yl95b3y+ePynb7AP73Rj/HNYJWn+RloL9Z7NwKJwA4/ri5cU
   rG2exvLXEquY2+wMp7fz4iNuFrD3JrWDpCjBUOfN5ceYdHaBREljFHSck
   DqxLgzCI6PPNsA4FNqMgs/liwT4Y1ta7yePVikpB882FJhjxnnILk5mlE
   Vz9xdrQzF7VSw7t5hPBaYYFNS+zu3g34SynnlX1/2wcjxWDoMTrghG8+C
   A==;
X-CSE-ConnectionGUID: 5qRDmX/CQkqHtAz5Cx92aQ==
X-CSE-MsgGUID: 65w6fXChQ76IOrFk++qJOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="59727218"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="59727218"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 22:38:01 -0800
X-CSE-ConnectionGUID: epE3/I2FSRuottgdQ6mkIw==
X-CSE-MsgGUID: HaltSqlgSWamYELAQBlKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105223662"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 22:38:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 22:37:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 22:37:59 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 22:37:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Brq00CvxEYh895x+hV3ulCFBrMstCk1Vi03csQlnGjEahbq5RKRKzD4vhryqMgxZi+lQFxwLCYEqcM8JiYLLaiPryzJni/1aUx/fR+8gywhGLZmHhLgNAcXrd/vfyZfolHooGcYEthq3CdiE2mWlv5UzuFmSfgzesnVuUY/z4lKZcWd7BZeEXxuAqpsLsOS+/nM/4/9/RGPCwdh519wSKbpL7Nrvu9wf5DqxgsncBqZ2Y8Y7opjhZxRsNH6ICu2sWJN+Kzi335bgACE6GIfTDhqhAzyEX1C0ijkg+Wa5nAYKDzlc3fx1CaY+5e620iWFuODFicmShQWKmsgUR1l8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gnjP7/SgRnTYfTALMvHHBtlr3IXWmFusJD87pY0N1w=;
 b=C1SiFZtNUP2QvNUm22cPByyBZpadzg82W+8/ich/dF+7mIyb2VgI62IwYGkhBAqtlSzsTDXzYxh+LWV2yoItxscwfoOBlPObvUQgg0VKWZRds4Z2XHOmskGqrqDQ1S5ja1Xw07HwRgCsXjJLW5YUvAzhRw3q0p4xN/bo+yKNBWyZFERS6Y8TCVSmpaam+x+/G5ui03GsoSXjTgdpoLj9Jxit0+BlCfd4mqF96Tf8DFu/vCKYGQq5jv9OILXtS2owiOuzmguJyWmZeTd7F6ONQJ+xwUC6REBvzEfGS6x2gdccLPX7ef404uJ3vdDtA9ywJJCqfex+C8XTHUd69D49nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA0PR11MB8418.namprd11.prod.outlook.com (2603:10b6:208:487::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 06:37:52 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 06:37:52 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH 0/3] Cleanup mce_notify_irq usage
Thread-Topic: [PATCH 0/3] Cleanup mce_notify_irq usage
Thread-Index: AQHbZqKpMczfMbECdE6svCd3+rMHirMXYVPw
Date: Wed, 15 Jan 2025 06:37:52 +0000
Message-ID: <CY8PR11MB71349D74B4BBB90E0EBDDD9989192@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
In-Reply-To: <20250114163722.34850-1-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA0PR11MB8418:EE_
x-ms-office365-filtering-correlation-id: 994690a3-d710-4d1e-bd94-08dd352f22d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HdxE1B3SAvAO2p5QSOn1b35/chfJm/zC1fbTcsxN0RlcYTwOuTUUA2hWNvLs?=
 =?us-ascii?Q?qI/s+mWR5fs/sm9C7C7NeDTKE4QwjSeSbe/49L3F1yQrXJRWm/5v0QSfY2J2?=
 =?us-ascii?Q?u7vj6vcsa6URKRRQJ56VMxVjJuyppHEkB1QWTOpv0gmZq9V2DL3mRkeSGJ8I?=
 =?us-ascii?Q?pKtGAk8G2O1Rnceh8WVCrRcpYUrPH2Lj39pdj/OGj16+QsY1xH5eK/ACwTYQ?=
 =?us-ascii?Q?+EOBGBIkuEPRlOgLoPoQRHnmm69ocEGshT8CnfyrSlTPLf+5zc1gknFSuMBX?=
 =?us-ascii?Q?vozT1LZAxP2fPec0YGlFwtMYAOlluz39Qq9fGMJJJuuiZx0VAMHRA5UyiGdl?=
 =?us-ascii?Q?yThS+SnjEL96XpL8jqI+5xcHH8PxbfvlXZx0+0OEz/9QDZ6BoBNYwhPdslKi?=
 =?us-ascii?Q?HQ20ggQ+RDASHXa1X6N8/GzU+fIfXv7855pYQwQT05t0q8l5d/JeBDdpvOy1?=
 =?us-ascii?Q?2BOsHGdXqzKTJKLQ4x+puFfItaRCzjFgsAnjNjlNjbIJbDdl8r4uqSd5JOTp?=
 =?us-ascii?Q?BTvYhlJiHWipimEBWNvcc+OevK2wjVaYcMtSE9SjwjWe3zKoQXjzGHkwZjSQ?=
 =?us-ascii?Q?ZqGaj2AKaYjJV0R+rwXf7436v7YkSI9fBwrpTkh7R6EszfgsC+f4CrmE6EBV?=
 =?us-ascii?Q?VFQTtpdTkX0WKwjojD8+Do2bQVEEi2QVfFOs+Yy4SBHrLuLa9iVRQBClwbvf?=
 =?us-ascii?Q?I/VcRNkfBqXNrgEmeTDZPj0kWrs6szte5kXHWuLZA+laqvNaJWSPALAl/TKJ?=
 =?us-ascii?Q?BXSp/N9anyRerUwXL9iRot2NMNC9smwMs/iD80rmZwQ7Owb/kUkhzF4XbdD6?=
 =?us-ascii?Q?bS+GRR5vZxhSI03lL6Weuu3gSqBNTSllMc4LhgsqcHqntH5bnIk3jTcNuuWn?=
 =?us-ascii?Q?Rn2YqIEjxSue1pOGKdOiBsuPSTtr0B14fPoBey+IgsnHcAxbiXcxiyPcqOUb?=
 =?us-ascii?Q?UU6e02yoXC+c3BGoP5OJAA9x02Dgve4AzMrSEw7b4pKwIBoWNjQ0p1dFNA8E?=
 =?us-ascii?Q?Hdca73+n6zuU8YFUzgLtPmSITqSasKaYvmaWE75KvRSUc7w9Kz5BfS79Tk7/?=
 =?us-ascii?Q?SoVYNTp7iLp/DhkHOS8aUOeqeZIFcarY0MwADqVtDAlBbNHzFjoMMG0Naa0R?=
 =?us-ascii?Q?SvOxjdjgWeO6Q7/2izVheGs5yw/sukw4146rVlU4r434ja9AsnMvhkk67Dwz?=
 =?us-ascii?Q?hlSq/9RRlQLScTfc6xzu5d0lQ1Guwns6acyNs1OoeIFE6IMvZnSQt07dcRJw?=
 =?us-ascii?Q?TfovjElv2zt75k38Xrcb11dvRRp8Nim3Iyg1K+CoqiPDO62Dimk/bZjbKgyM?=
 =?us-ascii?Q?8n997QXATMJyRlA5cxqooH1M5Y3Ii+qTgZXICUXRGd1MqkvLHjrIDy9N6NVd?=
 =?us-ascii?Q?eftNzdWXfGTqJ+6iRHP4psrBuXDc57htbF12EiBLpb1KZWXuMwhSOdeBNC8c?=
 =?us-ascii?Q?P1HH2NdtHVnfWLFPfemorqDyl+HVNbiZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mD884jAc0aSmulq4y65BaTx7qCo4IV1eHbX465LgK+mrSX1YT7LzM3XD+WN3?=
 =?us-ascii?Q?xirfvDyyNEkCVDKenLS4Sl4E9NhfK36Ob2NC54/TGhLx+cujwgM43u1Yst6d?=
 =?us-ascii?Q?XjyOYVt2k8T2NTunX6Nnj2T5F2rJnoeJW7v42ZFqNU8STip5c6UL6yX42Yyr?=
 =?us-ascii?Q?oACEyk3rnJjmAOJDinfLUQvO9LdHnUpg6d9SMCM+fgz3lUgRnTUebiWVLZw+?=
 =?us-ascii?Q?vs5LVGwM5INKV8ZyV+17dNABB3zaWCWy9vDjT3u8W5mT4yvMgLxgJBC9DTnw?=
 =?us-ascii?Q?OGa0VjfX+ZpYya28b/Yv2EPgQqg74cgomLRp+ht35EUdw3863/4EJ0jricgX?=
 =?us-ascii?Q?EGK19J4KnW3k6DOUsgJmgIcrap1RFjskUBwDYHJdCYn/p5VojNXrhHjyQDbT?=
 =?us-ascii?Q?xLGwM0eqMACOvTKBwH1rl5bWS6JGojts3qXPIFjt5LONOHxxcscECpwVhd18?=
 =?us-ascii?Q?v1x3QHHEZIMODc1tjaF9t1IsncDi8U7P6iVfuQviscOombIaFKD28g+LvBDU?=
 =?us-ascii?Q?zqWvP1XX9rK76lNbDPAZr1eXPxU9vaY3dnMY0UwUV0oOIizC6TD2tDK8FuR5?=
 =?us-ascii?Q?5C2ptTy8LViUZvI65z8HRoMn7vak90DzTdRc4mrSvgSqfc76tmWqegp3VvIn?=
 =?us-ascii?Q?d5BaP1WOs4U98B6dsMM0w2WikcS0ZsJTzCCD+RKfBtMNXCnZLiYTItTa0BKC?=
 =?us-ascii?Q?3uoqWoQQRJyv2ruhHUTcGEsU57e2sv8eikRkMLUfuDwXrkKmp4AWgU7aOpyD?=
 =?us-ascii?Q?YmkC/y8eFBIerNlMhDlfWMmcC26StBFp4X/SKT/wlfwxCRScFWwEfDNyLqwM?=
 =?us-ascii?Q?ql8QwNKCWsgHMiWQ+n6vTwCTKp3Nf9LODp3F8THJSK3sbrfNPkl9x7wQVm2s?=
 =?us-ascii?Q?qG7ml6I2SNJ5gii2mJ8p0OJcsR20fIgi4SOWBJ5WZF7/fDuZt2Ft9kYZZReR?=
 =?us-ascii?Q?GTqnfTJKO09GiKifV6mJ4qV0NjUe2IYjNoGaSrPijj+MFZgNVgSf1tEfS9Zp?=
 =?us-ascii?Q?B7oAlkn+caWJCQ4T9xLBEwSYJfO+Nx9qmo6u93K7WwZroPFVJCGdW7gFaNuX?=
 =?us-ascii?Q?XWV67O4t1E/A2KGJnnbw1q40UGHpmO15yJTUqZQF80/V/QGTf7FxtJudXwnA?=
 =?us-ascii?Q?E24hmuBmKkCu5jv8nUTmA5ocCgiVBpZZIk6snDinlxFZWsFXxFN1/Fs2B0Tm?=
 =?us-ascii?Q?LuCe20+eV0ywVIjaVmlSijysguIacYEUJWMhMOtCrcIUuitZ2LZrtq2FCAjV?=
 =?us-ascii?Q?3dgFvYE0kPB0hWiTdqeS9VMHsgT37vUWOLbnojiRemN9faQicCHq9OepRUTb?=
 =?us-ascii?Q?O9pvtnruwnjUCYzWINlAoBz+JS5sgJrOjlBoqsF87YSGV3bBezsqQzPyfy8v?=
 =?us-ascii?Q?v+xzsbpPvNGKbCsjd4biJTHPjswStO0uptuA6NFBUbUyYrY9xyRidPudiwOB?=
 =?us-ascii?Q?WwiywP24qPGtf3yeFHMTDML0X/aQOVrl+3xEqpeZUpQr3hiIUQ/OvmVtrLhR?=
 =?us-ascii?Q?iMIs0ODAYkbnmViLsnEYK9umgM28BYvmiM8ZqONPF377pMu8CiMMkFBYw9eb?=
 =?us-ascii?Q?JIbcIEaIEhB1ksPS+lravcr/hxN8mda0fQGGPGkA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 994690a3-d710-4d1e-bd94-08dd352f22d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 06:37:52.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: duz0+gJmNSJNjOApHIHEh1i7ribPs/Wcgvsk62cEQpJhHAcF/FLjOsydqvCTfx1ANo6KPOFSngBLb7wR+tiR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8418
X-OriginatorOrg: intel.com

> From: Nikolay Borisov <nik.borisov@suse.com>
> Sent: Wednesday, January 15, 2025 12:37 AM
> To: linux-edac@vger.kernel.org
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@alien8.de; Nikolay
> Borisov <nik.borisov@suse.com>
> Subject: [PATCH 0/3] Cleanup mce_notify_irq usage

I tried to apply this series on top of the ras/core branch of the TIP tree,=
 but there were some conflicts.=20
Would it be better to rebase this series on top of the ras/core branch of t=
he TIP tree?

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git   ras/core

