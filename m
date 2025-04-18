Return-Path: <linux-edac+bounces-3588-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A86FA9398E
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39F87B2DA3
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5B210186;
	Fri, 18 Apr 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd2Wvzo8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D211DED51;
	Fri, 18 Apr 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989908; cv=fail; b=UKqqBhvR4PoSOaYkBEKlx9IRYfNv9/ilX6u8KWwVfm4qkJyWLfjVyyWjeuBFoyPUkHxSiuMPDkfGFXGut2DjX14T0u6fHz0Dy0lPvuSnFu0GNip1FyvDcI7Fjj88I4qYmi6Xu8UyfyMThSiIri7GNWZKKpZk6T9l1JQ1BoN8tFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989908; c=relaxed/simple;
	bh=wMeMt/4f6RfdR75qvNyNN+FbUZ3hsFf5VRZCyb5AXiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFAJFVww0LV9wTLQmn0Qpt1uBRiAVFY55VcYkct14HmUUmKa3nr0LHOY3ikY/V+LPMPAyp0tbSzzHwqAJIy6PgK6yQJm4Sa4PCDoJPNi+0Oxa2zxUsYxVAQRmdbQOZNu2B/CrnJubdx8drOW47HFeUOTlW/gkiwn8kn0lYgwWDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd2Wvzo8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744989906; x=1776525906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wMeMt/4f6RfdR75qvNyNN+FbUZ3hsFf5VRZCyb5AXiI=;
  b=Nd2Wvzo8Zpz0CtWDouxwd+x6lRm3r/O6yP6c6hKH6Bz67Pi/knGgGz66
   tCxFADEpxlx4+MrZkVxW2Zz8nt78BZsiAlA5GrwUfeSrxDo5wgBDWxMQp
   5qtSftYbI4kOO8sf5ItE+9wvdGcIMOk2JRpytPER72yODwXO/+xKtG5sO
   HiANM8UEXXnj2PoGjtEGXwDUiNlnhLWMMQ8d8Q13dsAX1uHm578wjosBZ
   7Y+wr3KVuX/u+ZjIXmwovRFtWpHTWkNs4Od9Q5CLTUTC3rffcU7MWPERq
   +N6MThSTjTXvBgDY0CdTbP3I53u+W+H0hzrq1IZMrYjhOnGKYperIxOB5
   w==;
X-CSE-ConnectionGUID: wAl8m9BNQJKkv74urbXxug==
X-CSE-MsgGUID: aRW9uqFFTsiurooeGueNNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="64024944"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="64024944"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 08:25:05 -0700
X-CSE-ConnectionGUID: qokg23CCTCuVZdEPeeOQyA==
X-CSE-MsgGUID: GVIvN6GcSu+esb/5nOIlVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="131436044"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 08:25:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 08:25:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 08:25:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 08:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJp4zGL315k2Q0ZtR7IchRwAM13FH+vens16j1fVSVJshMmSLp3MEhS2JGEM0+gvdt1X0jSoKIfinHFVD64eWLuhhWGlR9qVUfuFr8uniXASmA6oYtA57kgrzXuauXepA+GKF+44Y8XF0rcUhlkKlXu61PsgYPlGz1PTexiwOwcLfdVVgpKxpjxTq2eSE5yzpLv/o5Iu7uh3W7GNSkEL1cidLO9XVBT7sAso5fyIxpY+fiCW4tpTQKI+TR6iTPiRxZ3Ky+WO6j+5dGgsZDMJFiWZAS2f5yqvg22QkrJcpvUD1567k7VXKsnOVOWeJrGHC+6YFFovzQqnf6GhzbUqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMeMt/4f6RfdR75qvNyNN+FbUZ3hsFf5VRZCyb5AXiI=;
 b=Y461b0iXqvRDv+RWzHyqXbSESQIchro3OsgVskv7hS6ZK5IiDmOr0E/zlkmD6FbVspTWIyyUqACr9ezEaK5DQq3UEZNaXdV6s0ju8YgmserGrw8hzwBJrpMblMZ+5bUVyEPzpgf7dRaxk+MKHkQB/az3xXN+3PIM8niBIdLrD3Lp144bq/GKIacTktiklj2g/gb1P6PY4M99eLb8EmvNE8Xnlds0xZsclkDELtkK5lYMBh041liTr05P7ekgEelKjnfF/DnHlxgWoq/zRweRNe59geQN0+r7xJ54G2kUQwgzGrGhh5uUsrllL3GoDdANjh5dHhfM1TE/0adXSzPElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Fri, 18 Apr 2025 15:25:00 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 15:25:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "Xu, Feng F" <feng.f.xu@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>, "Fan,
 Shawn" <shawn.fan@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Topic: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Index: AQHbr6q/0z1w63rIwEW69eY1fshpQbOoIYaAgAB/tXCAAOpAIA==
Date: Fri, 18 Apr 2025 15:25:00 +0000
Message-ID: <DS7PR11MB60771225065A977E58A8E27EFCBF2@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
 <20250417150724.1170168-7-qiuxu.zhuo@intel.com>
 <aAE-F4nGjuKX-m3e@agluck-desk3>
 <CY8PR11MB71349F22C613DE57758481EE89BF2@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71349F22C613DE57758481EE89BF2@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|DS0PR11MB6424:EE_
x-ms-office365-filtering-correlation-id: 9aef59c9-42c3-421f-7050-08dd7e8d2eff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?akJJWlowM1BwQjM1ZGEydE1TVS9kbjd4TmZFQlR4SUZmYUV0Q2dYQWNRbnIr?=
 =?utf-8?B?elh4SDlyZXZsWVM1bUNCUkluaTE1UlozTlh6Q3d2UThkaGJzYVBOV0dJOTdw?=
 =?utf-8?B?Tnk1a0tlcElFVGQzS2pCa3pUR0p6OStPazJoSHdZdHdDVDgvNEhWTTBvazE3?=
 =?utf-8?B?aHZBdVJ5OW5SbXJISzRNek1oVjBVWDBDZStTQUF4SU5tQTVBdUpwdUlNWTJ5?=
 =?utf-8?B?VDNEOEdRSXUvUkhxbFArTWNwbjAyeWhjWGc1K2RFaWsyMGVmbVdlUDRZTW5h?=
 =?utf-8?B?OXM3L3FtTElXMXBVY0pmdlNTVDdDNmhlTWQwbU1kcHBGOWJYK05OaUJRRWo0?=
 =?utf-8?B?d3JSNHM2MEhLVjhlZ3JwYWN5TVI3Y1M4ZUdkdmtvVDJ1R2VxTVlqUVB4QUxk?=
 =?utf-8?B?enJEaE9XVDk2WmtWeU9FT3MrWGttQ1M1d2RlcFh0UmxRVUJjaFY2RlEzRkh2?=
 =?utf-8?B?KzIvYlFxaENEMmNGU1VOQy9zN3ZMNzFrM04vaWkyc0dremE2dkh0dmlXMkpq?=
 =?utf-8?B?R0MweXd4enc4azdhbFhQNVRSbTA1S241NmFhb0RiYVhMSzBFWUtRekRaZklM?=
 =?utf-8?B?K05kNlU5cTk3clB1ekFzMS9ReWdXNnRPaDRneU90d1ppSTBPeHJYZDI1YTVz?=
 =?utf-8?B?MndhWSthU3g3c0FmWHMwaVh0aWQyMXp0a3IxWm85dTU2RkdLTExzM0NCUkV1?=
 =?utf-8?B?ekxZYmlLYlU0c3pIb3dtYzkrR3JtWkllVzUzSUxPU1hubDdnKyt3Z1dDNUNy?=
 =?utf-8?B?WmkrV3AvTlRCSFBQMGxRUmR4K2JOdHdOQ01WSHhWU0t3djFuTGhmN0NTMnIz?=
 =?utf-8?B?NkFOQzJZamhFTTNHSXJaNHBsYzU4VzF4dDFPaHRqSVcvZk02cDdaeDFNa1dM?=
 =?utf-8?B?ZFo0L2xJdnJnQlVvVVlUME4wK1lGYlUvcGdOdWdXbElBY1hSTGxOT0xXMDlj?=
 =?utf-8?B?SEVESUJiY3U1cXBFcnl5NUtudTVjZmNsWFZESTVNbGZvYUE3bk1sdituS2cy?=
 =?utf-8?B?NFJXWjZOVzJYSVBwdEhlc3U1amFkZSt5OXcrRGNtWGx2WGd3dGJ5RHE2SVB6?=
 =?utf-8?B?b2lQS2dZdzN1a0hudVU1MVRKcjBaaTYrZHRMYnJ1TzIwZyt6VFB2Ym5SVlFm?=
 =?utf-8?B?dWZpM1d5Zm9BbXQ2amFPTXQvMjNSNUFRNHFJU1BvWXNNQklId3d0VUhsVHpk?=
 =?utf-8?B?WkExZERpU2RIKytlZS81OURuaGd5YnJvZlA2Z3BvcjBjU3FxUnlzNExaUTZ0?=
 =?utf-8?B?eklSMXdDUjEwYnFDK2g3TEZRaU5LbkgxNEJrZStUc0V1ejc1T3dyTXBhV211?=
 =?utf-8?B?MUF0RTRudVJJYXIrM013ZXM1bzdqWlJoQ3NYRkZxS3V1WVlIaVJ3YUR6UTVN?=
 =?utf-8?B?eDVKQi8vVTZwbkZhN2xscUlXOXl5SUVzVDQ1WDZrUVg4V0c0TWtFeWJ5Tk5m?=
 =?utf-8?B?aXZOUHZZcUVHYjVwMERyN3kvenhIVjFOOUp3bi9mU2wvdUdsdk5pOThhcnBP?=
 =?utf-8?B?bUJYQjFsZ0xYV1M5aU01NjU3dHk0d3pIWC9EcXJ1MnMxRGZUK0FPUXZtQ0ow?=
 =?utf-8?B?OVFDOEh2aHhwOUUxdTBWb3BteUF0REFMTFlvS0o3ZVdFbEYway9YM25GQlYy?=
 =?utf-8?B?d3cxMnJEUkRJQkFjeU43K3E4N3F2V1Q2VGh3L1hnQWNLeFFER3FWbm1lUHN6?=
 =?utf-8?B?QmFNZFhGSXBGUWlaSUJkT3loWVFiK0Y4UXM3ODkzMlJMY2JpRXpteVhSQnpD?=
 =?utf-8?B?bUdkTmliL3ByTzY2OFZSRG1JeGk2UExiNWx4ZVJVSjdRWGhRWmU0dmZtdFF6?=
 =?utf-8?B?L3RkcVRrTjZXaVh5YVBnWWM0OUJBdFpGdG1mTmlQa2FnWVduMlYxa2plaVlB?=
 =?utf-8?B?MGFFY1ZVaEF6dGREeVBIWHp4bDlhQ0FRdEF0bDRUbFhuc084cXdqMUNHcFo1?=
 =?utf-8?Q?Wq0/kkxQsGo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFF0VnJvY2JvZEFxZHE2Y3ZPNE5OOHh4M2Juc0lGbWdmUW9tSGY0UEZIcDdh?=
 =?utf-8?B?SThFdm5KdStvbWhYRS9jK0tvWEZmRThwOWptaFl1MGNEWjdmNWVhNzFCMFMz?=
 =?utf-8?B?WFVEdXZPWWlZTHQvSmIrQ1M3MmcxZkZVZkJ5Ym0wUFF5czVJUk1pT3BEZ3JM?=
 =?utf-8?B?WnNqVXU4YnVZUFpub0dnRjkxSlN5clVjNDdOcDZHM0FBbGN6U0FVL1NFZ1Y2?=
 =?utf-8?B?azlpbG82Yjc3TFdIZE1VNjQyVEo3NzREd0ZsVFF3Z1RXVDhWN3BjTWlnTVRz?=
 =?utf-8?B?UFNKME95ZlZ5TGQvc2o1STBLaG5aTmRXSzhWSnRmaDJkTTdkRlJnNGJvNkxB?=
 =?utf-8?B?Nk96Y1Z0RUNySFVheXp4d24zanhSclo3SmtqUTRFdWN2dk0xcmxYMlB5Q2Jq?=
 =?utf-8?B?WXZZRlJwRis3STFOV1paZkJvNm14ZkJsOW5yQURKcVBSc3FESjUybEZ5QVlP?=
 =?utf-8?B?YThGYjFIbDlXeHg2b0VaeDdJQzJiUEkzclVGdXlUSkdNcFpzTjh1QUJ0OGxu?=
 =?utf-8?B?YmVwd1JERi8va213M0pkYmV1MFpPelZnT3BFeEtRYlQzaEtuQkZUeTFVaVRt?=
 =?utf-8?B?QWZWVkZUYXJOZVdwVEd6RTF0RmUva1JITTVpSXBmR2xqQ0Z0ZnhwQWxjeWRo?=
 =?utf-8?B?Q2ZyVDNNZldKSzBQUHRmdmRtTkhhVUNNTDdHdm8rTjdFaC9VdlVMVjNiUXZV?=
 =?utf-8?B?Vk5ySkZ3L2p6Mm92SVBpSitWVzZaNksvbjNSekxTelZoOEU4R0lIVUhVQk5D?=
 =?utf-8?B?TllzcDNHR2J5RVdRbU8rZVlHbFZaVFdjaFpGbHVNNGNvSUVhM1BiOHZoMzdy?=
 =?utf-8?B?VzhuVXAzU1ozNHkxYzYzZ3UvY3FlYmgyYkN3RW1mWjNibHQ0VUdJYXkzQm5Y?=
 =?utf-8?B?REhrTlY5UzdzMFl2amRIREZSRldwaVdlQWJuY3BiTDFCdGhZQS9UbDYwYTFU?=
 =?utf-8?B?ZFlhaFZZSTBsdXNWRkhRam5NTXZSUW1uSUhUbkRaUGF0TUgvNGhUY3UxcHo0?=
 =?utf-8?B?eHc0ek9qOERIclRkV2JDdEFiWENnNzdsRjFxNjd6eDhycjVWbDE5KzBHS2N5?=
 =?utf-8?B?eWc3VDlGLzQ0QzFudnFRZnIvcXozWkMrRWRrd25jK1BId3hjZkZDbDNFOTZt?=
 =?utf-8?B?R0tCQWNhNDR5Nk1MY0xTdlQ3ckYybUFqWkQ4dGRIaWdYVnNvYmRwRU9INHdr?=
 =?utf-8?B?aWtNSW9EcnRoV0FMaHJScHdvRWhZV0g1SXQ2Q3VOZk1PTllGbG92eWhTOVJw?=
 =?utf-8?B?a3lyYVJ3YWhPOXpmQkh2WkVHNXoyaEpJTWVjbS9pR0dPMmxrTzJCRTljcTFu?=
 =?utf-8?B?WThZazcyY1huSWFmMERxZnVDbDFzMTRJNlpsa0NQWkFSMXlabXViQ1RKaStW?=
 =?utf-8?B?T3dwTjM1RFBSOE14cnpHL0daTnVWcWIvbkErSXhMaUZXRlhnbXhrQ3BlbDA0?=
 =?utf-8?B?RDRGN2I3dFQ1YUJxT0xEVDlpbjRsdTFRSW1MOXF1ZThZdllHRUozaEIxc1p6?=
 =?utf-8?B?YkRmVWxuRXg1ZWd1VkpBdGM0Ukd1czBHOXUwMUI4OTlXNFVlY003SzBpRXVa?=
 =?utf-8?B?ZmFBWTNJSEJ2ZXdZaFh6Mlp5T0FGRDBITWE5V3BPbnU5SU5ibHZSWUxOMlVk?=
 =?utf-8?B?cklISjQveitZaHVJVXN4YmZnQTZZbmRHVGxIQUVFRXVBN05TWUc2TWZGUktS?=
 =?utf-8?B?VWxiREZTWWFsZDhhZVpoVDcwUEVaNkhtNk85T2xrTDZKRk5mNlZPaDhwZnRZ?=
 =?utf-8?B?NjRFenFBSWtSM1gyWEduWlhyTTRVN0ErYnhqVEFzeHU2SEJUb3QxN3V5RlpQ?=
 =?utf-8?B?cVlhdS9DT1oybm5VNzF5Ym1nN2UrYWVzdnZBdEU2cnpKVTRaeXNPOEVYWk5y?=
 =?utf-8?B?a3ZRejgrYzlnWkxMemNaWFBFb2R1S2tvWjdkK0hjQXJlTFZDT1dRT0E5a052?=
 =?utf-8?B?YjV6QUNNY21TeDNsZWVWUjZMMGFXcHllSzF4VFB4QVl3N1hjTDJaZ082QTNR?=
 =?utf-8?B?YVpIeFpWUVVtOGNCdDJRcWVuNkt3L2NqSmdNOTh5clpvK2VJeWx0ZHdZM2cx?=
 =?utf-8?B?SmsySXRDRWZLMGYybDdQOVNnQWovc2dSY2wyVmw2RGZ4a29Da0V2QXVxSkFl?=
 =?utf-8?Q?f6CEWm3nIPGo54geBOxq7AuVZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aef59c9-42c3-421f-7050-08dd7e8d2eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 15:25:00.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnkQ7gaYGKPxITqxrqFuea7bI2N/QbZWaNNOpeuCqj8pzpQKDo+hIOzpnXTxb0O07fGfVdXnM4xvSYDvsBLkZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
X-OriginatorOrg: intel.com

PiA+IElzIHRoZXJlIGEgbWlzdGFrZSBpbiB0aGUgc3RydWN0IHJlZ19ycmwgZGVmaW50aW9ucyB3
aGVyZSB5b3UgaW50ZW5kZWQgdG8NCj4gPiBoYXZlIHNvbWUgIjgiIHZhbHVlcyBzb21ld2hlcmU/
DQo+DQo+IE5vLCB0aGVyZSBpc24ndCBhIG1pc3Rha2Ug8J+Yii4NCj4NCj4gQ3VycmVudGx5LCBh
bGwgQ1BVcyBFREFDIHN1cHBvcnRlZCBieSB7c2t4LGkxMG5tfV9lZGFjIGluZGVlZCBqdXN0IGhh
dmUgdGhlDQo+IHZhbHVlICI0IiBmb3IgImNlY250X3dpZHRocyIuDQo+DQo+ID4gT3IgaXMgdGhp
cyBqdXN0IGZvciBzeW1tZXRyeSB3aXRoIHRoZSAiLndpZHRocyIgeW91IGhhdmUgZm9yIHRoZSBS
UkwgcmVnaXN0ZXINCj4gPiAod2hpY2ggZG8gaGF2ZSB2YXJ5aW5nIHdpZHRocykuDQo+DQo+IFRo
ZSB1cGNvbWluZyBDUFUgRGlhbW9uZCBSYXBpZHMgWzFdIHdpbGwgaGF2ZSB0aGUgdmFsdWUgIjgi
IGZvciAiY2VjbnRfd2lkdGhzIi4NCj4gVGhpcyBpcyB3aHkgSSBtYWRlIHRoZSAiY2VjbnRfd2lk
dGhzIiBmaWVsZCBoZXJlLCBpbnRlbmRlZCB0byBlYXNpbHkgY292ZXIgdGhpcyBuZXcNCj4gQ1BV
IEVEQUMgc3VwcG9ydCBpbiB0aGUgZnV0dXJlLg0KPg0KPiBEbyB5b3Ugc3VnZ2VzdCBub3QgdXNp
bmcgdGhlICJjZWNudF93aWR0aHMiIGZpZWxkIGZvciBub3cgKHNpbmNlIGl0IGN1cnJlbnRseSBv
bmx5IGhhcw0KPiB0aGUgdmFsdWUgNCBhbmQgdGhlIGNvZGUgYXBwZWFycyBzb21ld2hhdCByZWR1
bmRhbnQpIHVudGlsIHdlIGFkZCB0aGUgRURBQyBzdXBwb3J0DQo+IGZvciBEaWFtb25kIFJhcGlk
cyBpbiB0aGUgZnV0dXJlPyBPciB3ZSBjYW4ga2VlcCB0aGUgImNlY250X3dpZHRocyIgZmllbGQ/
DQoNClRoZSBnZW5lcmFsIHByb2Nlc3MgaXMgdG8gYXZvaWQgYWRkaW5nIGNvZGUvaW5mcmFzdHJ1
Y3R1cmUgZm9yIGZ1dHVyZSB1c2UgKGFzIHNvbWV0aW1lcw0KdGhhdCBmdXR1cmUgbmV2ZXIgY29t
ZXMpLiBCdXQgSSBoYXZlIGhpZ2ggaG9wZXMgdGhhdCBEaWFtb25kIFJhcGlkcyB3aWxsIGFwcGVh
ciBvbg0KdGltZS4gU28gSSdsbCBsZWF2ZSB0aGUgY2VjbnRfd2lkdGhzIGNvZGUgaW4gcGxhY2Uu
IEl0J3Mgbm90IG11Y2ggY29kZS4NCg0KPiBFaXRoZXIgb3B0aW9uIGlzIE9LIHRvIG1lIPCfmIou
DQo+DQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
YXJjaC94ODYvaW5jbHVkZS9hc20vaW50ZWwtZmFtaWx5LmgjTDIwMA0KDQotVG9ueQ0K

