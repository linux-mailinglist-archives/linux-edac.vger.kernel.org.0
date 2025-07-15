Return-Path: <linux-edac+bounces-4366-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E91B06502
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637AF1AA6A49
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51DF26CE27;
	Tue, 15 Jul 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV97lJrB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CC6A8D2;
	Tue, 15 Jul 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599827; cv=fail; b=V95AxlZActaXElowfUnBpenWDrMpwMd79BtMGpzWzAp8Uk1jIR0Qh6h4eoM1ClaVCDQWXsgQLcWv/zL9QfbfoLB1oTEu1QzxuTp7KG+6828fMTHY5Tp7cQLODZlWq/WukklZKgJpzerROxAyCeqhK5F0e1SDTdijrC8Z/S9Bz3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599827; c=relaxed/simple;
	bh=GyxZ5vDNMWnPajZ8PtKek5OkU7xWuCreqHq0A9ouHYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l56NNPKFDrZdJ0pgRm4KO6Y21hR2D+xR8C1JMRT8lF1dIFTfixVVFzXGB0VMY2NeRGrc4BSllC+i/XkiasHMnCDOrapUbt2geVej1M9CiaUCAtJqxEFW1RHRnaKHP/Hs3Su8kwshuQXnAqC0e/pfI2C7C431gisQCna2o8a5iKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV97lJrB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752599826; x=1784135826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GyxZ5vDNMWnPajZ8PtKek5OkU7xWuCreqHq0A9ouHYE=;
  b=nV97lJrBkwWyAuO90O+e5JFS3eiK+t44T57lA85JgTlxguVvPr6SOZB4
   WK9G/jIDvY64yGHA2cdGayVgWk2jd38OVfJOPpta6ZwQmW/z23nUvmSei
   UJ9280vT5Ou9i3CkeRyIfw2PK2gy/8hZAQBWsXNcdN0AXGyDQCE5egyqd
   9Q+zdMoSDdxple8f4R/hi4/lpofrqWkwNOwTgXHxslgyC7N/nnREbrVKV
   8ldMClMPUSfWjvr0v7DYlApTPEAevcVOEOsTgWCQz8FgGK0PryN4OkLBA
   nOZtti/mUFfsUWYl+r0chm1gPGqb9pdGgXPbgWZnFi/OISYy14w3BsYLq
   g==;
X-CSE-ConnectionGUID: KOozX8naTjK1NhxlUDD9BA==
X-CSE-MsgGUID: qNz4uflNQvCOFQYf9h9Q+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58643709"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58643709"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:17:06 -0700
X-CSE-ConnectionGUID: GmoqZ7IrTDiIo5CaOnOR4w==
X-CSE-MsgGUID: EsabCAVtRiy7+FX71wF9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156690918"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:17:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:17:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 10:17:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2r1peMGUtI2s/Yz87tdlhwNv3WluRuHFHpSEEeQsrAeYjKuMSv81d/ysOR9lrEfw4hY875wJ7IH+86lPV7/lajNVKyVwpSNKJyDUeodBl33wyGdEqfWGeAZytq/DfXusoiPT6kMGgKKA8QaSmKTeOxe/J+m0gRdBxO3Da1XuUZPQtR+S540V+ar8U28nWwJL6vhW6/pKYBAA11rlF57cmWC64A4TvnsdOVOW/i+VIMeqDDLkwWzVNhy8+4JfhpJ5+kb6BzstAunMLpc/2Fuok+WfnczBPPaiPBCu2LXvaSuO+Rpfhb5A0/4ayc18XFpAO+sf2jQqmKSn4iOJHMcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyxZ5vDNMWnPajZ8PtKek5OkU7xWuCreqHq0A9ouHYE=;
 b=UGCZMtKQ+7DNHPj8rgpCMZOG0QCQxfKX9LWJHRQfukiBXBAzQHLNM4jdFDjruChA8qihE2FK3B6qqDwmu/dZr6MoJOOl4XGScJ9AhZgEc9YuFHsEperYRB1OReLO/DxOmKsfYEuWaBI8pQ1ew6TNyG3GYz+3Bro+l04vp3ERPW5rlQ+QjpEgIuFX67jbtIMkQMxxJjOD4r01cPsO/LbipN5Trf6kHqMbtkxapM2YYQ/1Evvv8DS23ryHRfO44mISDYdBpMSzsDT4+a5XVpF9eZ1Q0wdNcyogD42cizb21hLPBTLNTC8aWCec+u3sYika9vqzvdo9aYm+NIdpezkTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 17:16:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Tue, 15 Jul 2025
 17:16:21 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, "bp@alien8.de" <bp@alien8.de>
CC: "james.morse@arm.com" <james.morse@arm.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/{skx_common,i10nm}: Use scnprintf() for safer buffer
 handling
Thread-Topic: [PATCH] EDAC/{skx_common,i10nm}: Use scnprintf() for safer
 buffer handling
Thread-Index: AQHb9YrRLCv9//qHFkKJMevPixW0TrQzbJWg
Date: Tue, 15 Jul 2025 17:16:21 +0000
Message-ID: <SJ1PR11MB6083F48A0A17F85632D08643FC57A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250715131700.1092720-1-haoranwangsec@gmail.com>
In-Reply-To: <20250715131700.1092720-1-haoranwangsec@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6576:EE_
x-ms-office365-filtering-correlation-id: 59abd2c3-8f52-429b-aa62-08ddc3c351a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ofDpn0AJNjFtgTTMe8dysKfwEjX5GnqoUZhPqQECVO2levV0a3y2Gtxd1sit?=
 =?us-ascii?Q?qGLJPhsgMdFi8TvwLUmIjAH8XztwP4Z6XoJHffKi/Le8bxwuO5As45M1acbP?=
 =?us-ascii?Q?3wj9n0cu/q2mILWc+58uisI153/wps4HPZUKUM0ik5pPPTgwDv+yJ9vAqyIC?=
 =?us-ascii?Q?BIaCcQ0CmaVX08Qp0U6Oi6f3iJPELqC/fqwa773pRzi5szgBvVHRa2WckH8B?=
 =?us-ascii?Q?saYiTT+tNwvJkjLZ84d2NVHA6Xv7mJREz9HeynznuoRrR4nhj1YsfCNlzedJ?=
 =?us-ascii?Q?4cnj5hWbVgts7KrOTBDrjmdh5unDfPmzMJkSrq3ldom0r21BhrheVvJNWQi5?=
 =?us-ascii?Q?68BkgCty3ARpjAvU6tJRsAzvFyqFiXfQfBMU0PUlRxRrbsEAPcLEDjWNpuMb?=
 =?us-ascii?Q?PP7JO6T+27rH8Ay2fCxja//1A7FUQIzmn2CDnNSV2bU9bdUy44QAvYySHy3D?=
 =?us-ascii?Q?XgOKSoCN/UpohEuW3vgV7SlNQC0a4BTnSZxT/oAS++rRIPTVOQj5x8vsKlLp?=
 =?us-ascii?Q?LIVBCI60JmBNTgONCoYXpaCx/0DFNyX33GjkkjfW4V2nd/Gkb+TKLcU7bZGV?=
 =?us-ascii?Q?UembBOn1lvksfBoDlT533EhyLH3XA/MB8bOL7XAUht22GlVlKe7Z18UyfYrW?=
 =?us-ascii?Q?fJqiTBlaZ1jXRxrTEBP+rEGLtc4r6fB8RxAgQZUOCK3cTMixSiAjLDAPuiqz?=
 =?us-ascii?Q?KjP0YDS5ZcjjgL+gaK52y1OMc9CmDBJhUpC7t+JLJ/Wt+cw47iwyr9r1QMmi?=
 =?us-ascii?Q?UQHkMyW7HSdee3lWeWE6Q02xS4DaxypN1taszq6BUifSalSKRDUfva7opFGD?=
 =?us-ascii?Q?ISvfOlX2epe8JdbLtdjo4yXsYrwIvToC97Tz3FcqbqwnDvSr03ksI/Pi0NPy?=
 =?us-ascii?Q?5kcA//zssc5pculutSMNA4ULGKTIYol8zgiF7/2ha4jp8OuPogDfKcnxLdEU?=
 =?us-ascii?Q?iaf8qKpTMQTFS3u8LIuv1eXXgofrieiVXByWtdnh/6YViL6ZLaSCJaq9FGz4?=
 =?us-ascii?Q?jjIOE8Xn5PGiwnr9B64Xu826xflQs2kb6hAp0RoxLqqMVtL/2VGwJD5SU/oH?=
 =?us-ascii?Q?dAxZbsO8UL1xoS8QwDMnN3z6mfs+/G6+2212RZaUr/EDivfZtVE/+mYbZd6r?=
 =?us-ascii?Q?+bEAm0ekElVUbiQUZOy4xudQQbrfeB9vYBB8LmdP+WFsNSdj3hkpG5C2xUR1?=
 =?us-ascii?Q?do4EFQuVgC0nJ31it+xFAr8L0c5zmPjS/hPClvd89CuDlgWFCtCr6BLuQ3cx?=
 =?us-ascii?Q?cg22fUctmBe2DDLnm5OpWijUvXJM0Qv27dfFnaICkBfUHnk5wmfA0ydTEPkY?=
 =?us-ascii?Q?2v7ytP5lQlfLRJzBGsrBMAEs5KzxmJu2UMrNkiJa5wJMreRqp3wf+0TPSTMR?=
 =?us-ascii?Q?b/Vc3EG5gGCmG6KmDDIRLOA8qncrnxb76yu2he/jCPKTjGH2c9qvfrVE9X+e?=
 =?us-ascii?Q?76lNnH2Z0F1LPQ4OMVDkGZMqOke5XwKAKJ8cmpSR/b5qRnMoqmK/6fhXXj5Q?=
 =?us-ascii?Q?RsKa1lKljy23ed8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6zxZ95vdEIEHbny8pwS0p6Ui5+sq30A8MKuKoShRr2UFTRT3k8xVHEiQqv8?=
 =?us-ascii?Q?++XbtZKWEVg+Lrc7MLhRUykozwsqa8j7hIWmqc182DAFwfH3M37KbAps3sk2?=
 =?us-ascii?Q?pFG2ddE10WHse+XFULbK4+SQz1X1tIRdWQOdMor6oqJdvhdG7bZ1EetmXkVt?=
 =?us-ascii?Q?COXeMN1mJLPPDJAm26HHpwEqIUaeyt8Xg0oEYjFzgvAQ99zWN8dMlHSyfUna?=
 =?us-ascii?Q?v9DMNWme+RDJxiD+GHmCOghlatW5msVqWNrrjSMPRXZkHJ28P+QlgyZjJasF?=
 =?us-ascii?Q?LMwR9bsbazVvMsrPsCDyvhklu8vpVNfFd2FyXpdV9qrlXid35gYOYd2+VVpb?=
 =?us-ascii?Q?m0MHybu4Jv4+O/W+Kbth62gx4dJqeFt7pf6Apzg66mNk1zZEmBCODVp5oaO/?=
 =?us-ascii?Q?MRnADpaqpzkaPiKxfsOiWgoZ41UK8Yo2WZNt/gdtDrrJ9rje1yH2wJKxCKhh?=
 =?us-ascii?Q?CA6FsX/k7uqHYA8uBeLgeg+dm1tt+eaiL5RfWBnUoHzodDp+YnoYdgK5TXs1?=
 =?us-ascii?Q?kFTuyK/W7USiYjFBx1e8Rz6rK8wLHS4zrYb4JySeKZO2DAukx6aDDgaMiS2Z?=
 =?us-ascii?Q?1fzMba6oSAe9cUgHC93yTnLs8KdWlma9HtoAG6/qErWyDrltYHWkuNgMmz0Z?=
 =?us-ascii?Q?BvvNDRlLWabLiWQ6igJfOm87jaNgHJW2L6L0DowJwwmUCdwz3rSk5gHUDjq5?=
 =?us-ascii?Q?3MGjmr34PkE1NIh4Y+NX/6wXHI2YbCne2WdKYIzBGxWhuAv83L3rBXeCRUFJ?=
 =?us-ascii?Q?lKysD9Q9RJbPZL+Q1TdhfMiDFsIHKSWOzjP/eZtNA9wrkEzQp0TJPM6M9MeK?=
 =?us-ascii?Q?5QfJW9D7saaOZ73hwt+YAwiJsxvK8KS/lL26BtwyJZ6vSyC/bfQ4UfZBynyf?=
 =?us-ascii?Q?v0Vce66S4qW/YV+Vsb3SUf5+Gpvv+MECFYyMDMoYG7zruiaEUm0PUahI7P5H?=
 =?us-ascii?Q?suitlR+1nLv2OyaGZG8T6HqAovjdR+LQlGscfdYWsSZB5Q734MLyTjTdEQSL?=
 =?us-ascii?Q?5Z7trvmywAG8phau4/i0j3/L/ENLfTTPTqkwyoWr3oqc+Sc8Xt9RzNLeGvqA?=
 =?us-ascii?Q?kq82JdrIakBFb6tnkSlnJoRZC4P9ODZR2lalz8Y5SH3x5/AoOeEvUH4kNkXs?=
 =?us-ascii?Q?P9AW3k1QttP8L4Suh9C1pcXS78/j2r9e2Px28G5bJDpvO/QanJQEQWHSzmRg?=
 =?us-ascii?Q?PZUGlIp9uV6us0hPzHHviTe4SBLdaRxDiwpxx/hFpdb94nsUgKKMjTqHX912?=
 =?us-ascii?Q?V01eQcYdsmlPbQCMPZFG69JcE2uVJOO2DH2VBuNiUxcDtrV7mfnkgInmvtTP?=
 =?us-ascii?Q?bVtsVMEiX7lAZtkGcufP8jt+moTedd6V2elusk6o1C9QhWFiWACwS5n+64Sj?=
 =?us-ascii?Q?/QvZ+3aXl91FBaHFcU1lenr5ijZlvCUc/p1WxHiNb+11gZTvB08xoEaVXqRZ?=
 =?us-ascii?Q?AtoIGBVcxaixmi+BQjP3qKeokG1VXIOB6Qcx2nj0NtOKxbmJB5Ntmx+ZjEW+?=
 =?us-ascii?Q?5bkgrg0+ewnz6JjewBuuiGYXZTPjH7Q/TQN8vlMGIHWnlsMfnwcgzlOpmSdb?=
 =?us-ascii?Q?Sms26jHCABESKsvqNfiYXeV2Bf1U8ZNUqX2wpPYC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59abd2c3-8f52-429b-aa62-08ddc3c351a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 17:16:21.1571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0GsXK46IzRU/Ul/ZaWvNS6GtdOJ8XG2Z6Bc6onWfxRu9QHC00twAbNCYqjaKCu0bZONK4hy0/M8Xy7DQSy1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com

> snprintf() is fragile when its return value
> will be used to append additional data to a
> buffer. Use scnprintf() instead.
>
> Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>

Thanks. Patch applied to the https://git.kernel.org/pub/scm/linux/kernel/gi=
t/ras/ras.git
repo. It should be picked up by intel-next soon.

It will merge to Linus mainline in the v6.17 merge window in a couple of we=
eks.

-Tony

