Return-Path: <linux-edac+bounces-3443-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB0A77166
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 01:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D9C168694
	for <lists+linux-edac@lfdr.de>; Mon, 31 Mar 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C72153CE;
	Mon, 31 Mar 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0bmFAy3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B73232;
	Mon, 31 Mar 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464115; cv=fail; b=CZLPg/NyAhpm3Qn44pNWeWTWltu8gEVc2fC556wnbbiuBxEQc+AAetBCXYCBVaebFJuPiv0fanHztFD2RoMmaBmgVFcnidXmliXAV25Oa5vgN0YhcxLfTbM0n1KbbcWVxau3y29rtGSpZRWfrZvN0NvJXK59hw9gp+JDCVftbM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464115; c=relaxed/simple;
	bh=lnQ2piG3rv6kzEqG4BsYrZCjc5iV3mfeGlpfzGS6hyo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c91xwUs72OWzYDyO6Hw/1AHJNLHkm1L8eukoFSmJdq1gPYJxXB+JjkaB6b3FxtgsWd391RVNE/2ARwiOKdqdpdcZd2cEEKtZOgAmKnLQNGiQLVCbdUawXIk+XUCTbMG6DCRmgTB15ZddhMUXfGkVP5BofOnuSSOCoecZQoHPOQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0bmFAy3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743464113; x=1775000113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lnQ2piG3rv6kzEqG4BsYrZCjc5iV3mfeGlpfzGS6hyo=;
  b=D0bmFAy3CoMia+TBM5rcEYAghxd0arFIOFporTs44TmHykgA4FT+cibr
   B8k6f6oFIAW0wEOvfM3raef41CR6aX9XU1/9koEUxu7lrqy63axf6wkyW
   JGQy4+NKafFJrlXDPjNwt+DeRW6JlrqMGiXkHZyYFkvIe6FWdXa1cHvfV
   zzDwXuBGhedbaDbmHGoQbWyzB0mfESN6puEwk+M9GINh6AO7TdCCF2Pxt
   4WDvBg5cIfzEjCW+frarxr3QR1rADQnxJmI2ZpMwmLoReuAzgY+CvSJwE
   G/x05Ws4miY2/nJYgGw0pW//HPtQSwP8znqrQf5EH5ud3XHuO9LL7u73W
   w==;
X-CSE-ConnectionGUID: olr7p88OQ9SqIB+jyOcuDg==
X-CSE-MsgGUID: O0Uq3SY6SRyxynwLBRjXCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44866802"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="44866802"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:35:12 -0700
X-CSE-ConnectionGUID: NmnuPBs6QPGG2wqWbuTuAQ==
X-CSE-MsgGUID: 9rmCeK5ES+yEYEDg8K66RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="126690997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:35:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 16:35:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 16:35:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 16:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH/+0Qn6btu45J+32j9e5MhAJIu/C5/0iF96KRDL9Xir+YgARLco0XGRvC0r0qalfKeko1hOXtFxxM793wM0OtuvK2DlmMXvacKmg9cgehBInx4tB/tYeUvoBkKIXirYVA6cjprBXCFBpIhn06MBLti6Jiz4dpCKH0PkuWf8GHfjnfinAB/uGmfppjOAwF748Wh4reHtBr6ceI1cpv5dtxO9yXSdB32/EHmDr+7zuQ9j2zEF24m7KtKQDLBxLrt9s00bM3QF7ejNkR0hCO6PTT1xyRd2+vJ38gndYIIr8ldpo3LcWnSbskr9fzcA0u+QMzL2IERqfNqY+S2Q4cIkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgSOXX09FKKXztf35xh5hXg3AiJz7Os3B3W6n8z4CbM=;
 b=NGZuKpLnSDG6/XpuYGopjEEj+wxszQtteyLmdvNVKPHbUL0Ec1RAq993KPcLZss/ONysQNEVOzZaMs5JwsNNy0Bab7yj+/ZASA34vupw8gCWSMczQuRZi/jjAKDCOcpP8aBx0/rENU9z80p6ZNsizbtTlNZPbNLZ/XMyRVxoW6HkXKhtWirHJ1cZ4K2FLqpm71zP7ZseVTZV7FJlyfrRmdOF2pnNJUacBidVbrxKZjxyUPiV/elI9NFGyyzQN0p7gA3nJZLJpkbMKlHuLLI+TrS42I11ZqIqVNyGmZemaPS5gt13irBcqi8yRA4QTE4eIwHc3law5Vcs3HpjIh8Y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Mon, 31 Mar
 2025 23:35:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 23:35:08 +0000
Date: Mon, 31 Mar 2025 16:35:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
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
Subject: RE: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature
 entry
Message-ID: <67eb26a711ad8_11987294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-2-shiju.jose@huawei.com>
 <67e47285c1974_152c29442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <610691bb7c6949b5a2137c568bc66fe2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <610691bb7c6949b5a2137c568bc66fe2@huawei.com>
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF4E874A00C:EE_
X-MS-Office365-Filtering-Correlation-Id: b71e3ea7-d49d-4780-56e2-08dd70acabf5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PIs5yVTTidENUFLVFYvljrEXGG+OijCzD5bpYBpN3h4WUEcZYPMjYouWuGKp?=
 =?us-ascii?Q?Oa3bPJaZc0L1M8xkUVoHbBo9a2BuJ8ycBYkxwUD0juWE9yifYlyf6PAd2ikP?=
 =?us-ascii?Q?Ex4+N1dfV1tYU8e+TS1nqrKGtvslkI9W0NxVp9SEJDg4ngl4HbHDWHFp+gm9?=
 =?us-ascii?Q?fgPNfm3ZSwEjMnA0AdpqM/dhi1XZVcOWP5J1lmCGW1B0ye18qC5tuxh1ujz2?=
 =?us-ascii?Q?Jkfiv/ULu4N1StNWdqYagaWTi3Ec6AHBXifuobNl8O36h3/BaF6uwr1sIqO3?=
 =?us-ascii?Q?+j0RlUqJGllnmo8hBEavzMXEh2g8zxsa3IihBejPclSzSUBpeOGBSX7EGhig?=
 =?us-ascii?Q?L9PbKyjbtnD0J/6J0NU99gS1PAq+5oVHLtQwh6na1LRZ3OD6rnp4HmytaZXi?=
 =?us-ascii?Q?zgfDT7UndgicY8F2IYMDB20HUg0oR21AmX6Qrs7Z7gxNTRoNxUquIWbk6JYC?=
 =?us-ascii?Q?zS9b/2A2ueE+FzTnMYIvj3lJhvUZ88BQeHZB09zS+pA+cs26bJHOtQp4eqtz?=
 =?us-ascii?Q?gV8hG7V8Kc0XG+8e+KRFp1xqI6oRiZncgwYJPABXDK2mJrvzNeZlQ8pDYZxn?=
 =?us-ascii?Q?HOIXDmeEVq7+xUAkCDRDyjPTGAhR6fdl7w0gJHBtTYPkXKp+/Pi1DAIpYWMx?=
 =?us-ascii?Q?9yal67zZBGgqZ/+xx48VglpkoECEYigd6rUY4cgxMc2wZkhpl0cCLt+bsqqB?=
 =?us-ascii?Q?wTHQjTbvc/kSCVmf18kQ5hYh9aBoqnzfeM9OysnMLHF1imytjg8nvu8ipqnP?=
 =?us-ascii?Q?AQXRvilY6XCzNJw3vp4QQupMaglJ8MM0ZQW8j/cz4W+Qn3aX2cEP+qIlhu+i?=
 =?us-ascii?Q?LlT/A+s4m6mDUc3x302nVbGA0u6FcSoDK+DAVMNsLtdHu1r1Vfc+5pktJ/Be?=
 =?us-ascii?Q?BIWYkLx6cyAd2JIXBYNCiMngJ6DHPSy/ZvkgJRxtbjnzheRWIrhTE27Ztvjq?=
 =?us-ascii?Q?/3lMRgOwTCfybIJ94dagR57aYgbj+/dOwhSVCG4LShNTMhhCRjoNejQV9JnA?=
 =?us-ascii?Q?wOVUyuRu6f5hkPdmfFCfKFu49yIXUg6fTTPQuin/7CU8aEboiqVQdR0rhsBE?=
 =?us-ascii?Q?jHo2cr3Y0sHr794mzsmfRUCGVYk6OvU15NnppiIroOGOfwAtglOp0e2JHHss?=
 =?us-ascii?Q?GCzdPo+OC7f12LtOy/AjyqjA6yUDKj/ODhWFrCuDmk5HFu6JoFSy7fBQ2Qsf?=
 =?us-ascii?Q?NxgMrMOEBANq/Fh1Y8IwfcPLIp5k4yxxdAWGQT8RvUYi1NpZFNTMRxVYKgph?=
 =?us-ascii?Q?7DCPDYWwvKAVc9owW0uurZY73ao36IXRDa0glEAXucXEhBjAZTTzBAjdd1El?=
 =?us-ascii?Q?uK8kwMfrm9CG5An4B5AdYDr+n8cQsB6wP1+C3oRLd2aTrQ/diNsumOT4F3g9?=
 =?us-ascii?Q?MORfXVshlLixyOcblFOCQzulH0ho/sf8Nu/zP1PsFK3Qt/OS+kvvr9IhK/sN?=
 =?us-ascii?Q?HmmK/t69Ptc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCaSf9MtU91in6EioN275XwgI/e8C+XQ064K78S+p6L+sWRgF067ZJ+0awu5?=
 =?us-ascii?Q?cE6/ojaXTqjpSLwCyUgGxooUhzeT9rdPfu0qHWvkKBsgDJjh7oLXTIfx7wwu?=
 =?us-ascii?Q?eP+wXscWrbdUDLh1cLgyIiKVNSJ8QtUSeCO7YPorCdXbn3fZHS4GPb6wy2RI?=
 =?us-ascii?Q?MNrBbdDOchDVTIQxmzdEeAXrXrgi2Uio278LmKJHf48ww6kB17Y/tTUENisr?=
 =?us-ascii?Q?f0CDCZBBWIIpZyfrQTQ7EyRP6f3lEM8VQ+iOLfGMWyhPL+ZR0BksDFaoSmD4?=
 =?us-ascii?Q?6ybmNbWByUoEORFhwefLhC/tfdTcf6hG+l42LR1XtdIadpLAUALcRaCziJ2c?=
 =?us-ascii?Q?/jqVz8DJ5r6wEXP3cOsYRW/vHFOWjNn1WjMA4TOHRVm/U7TgHLCDCVPhwTuV?=
 =?us-ascii?Q?acqAFI3WOHdWvdTKJigGAYoddC0EA7aMiZt/Sm7DW7LdvMJgqMhrjaxCnBMI?=
 =?us-ascii?Q?Bqb0i5QtBJb8PMgwUnzbpK5PC1reJ2UdF7L90gPWoVbNerE43HskQNuDSYHG?=
 =?us-ascii?Q?OwkyZg7/FvvOelKAt0M4RhQ/iji1lbVWPCP3N48bzUl2l6SxDaHzRIKvs9zP?=
 =?us-ascii?Q?61N2RWNbSBoVLeoi+HrHtnNqq0HkT/XdTzlYapHVUo6mLIdOFO+BDou4l92b?=
 =?us-ascii?Q?RdfTNcJ0pnMrksmzC+rQM+vj+udj5upAGIZmN6iuLtPSw72rqoNBT1j0iKkB?=
 =?us-ascii?Q?2/RvC5mvmObuzwIoTenpOzIuAXXgzh9IRSqY5ETpLVA+gZjaET/vZelGO3b7?=
 =?us-ascii?Q?Nh+dIJyAK2Qmbj8UTZ2jMtR+MQfFDmxD0tO8koeGX/fli0fTzYfSCkAiyQz8?=
 =?us-ascii?Q?OsuKZN6ORoND6ipMOJcKk16wUqo6/j4F3Dzt4BaZfblbaqQl0yXXyCj1Q4ag?=
 =?us-ascii?Q?NKgqyDgHWrb6oKxK7jf4DNJ3j+WLxyU042gflbqT5gr/xMy8tn2MaxIbQ29N?=
 =?us-ascii?Q?KHHsR+rMGD8RASctxm+6NWXR7EXtVtBpdpvUIRgyNphUaWiBspue44jeQvSZ?=
 =?us-ascii?Q?PO1XV/dyTWag+wh0CQ7hi4Q1aGpW4WjWCY7fdY5F41eptTGTGtz3sNCnVVCd?=
 =?us-ascii?Q?rwDI/S6vefU956w2MNieei1Mw1m6qhZESQzxTQcwI5UgtzqPSJvk/9NtMiZO?=
 =?us-ascii?Q?4eFH0lIFjwiROUHYVN/jSy4OCYwPyT3E0df3lM01/nZozlOqSTYfrUe2uiU4?=
 =?us-ascii?Q?Pi7JktSBJrs+W9xX0cOhEWvZX0I1AK9aiC/3ZJ48Z4gCYPgsMY+BLsBR/CE6?=
 =?us-ascii?Q?COwXNybmMMw7bcw6ZFiTisO1rXmCtvQ03ScLtuIbj6mDhGHpKWU3psYuxQfv?=
 =?us-ascii?Q?TTSC7tAzvZ+ugFToLmSPk0P0HpGYu7VnlHBj3dJfJvi8Yw1U39+NFbnosPz9?=
 =?us-ascii?Q?rVXDacu6SUCiC3sCPLONjpbkfLhxxx99cPT79NTUORa1IU8c7svmpAdAN+aV?=
 =?us-ascii?Q?nUT4a8F3ajUFqcD7s4vpR9C588At/7FJTWbKuSbp3guCe7AMGRCo6IehAlQL?=
 =?us-ascii?Q?dpNIjCkxEBUOkqiaTSiiI2wxwQGL9NoPXsy6UaY3pT4mYvrLDsz0uH8ekB6z?=
 =?us-ascii?Q?Y/cbcn+Y0HUltAhpx53M2f+jtqLzq/z2YAFqPYK0cnwab/5NHkw0rXzZylkZ?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b71e3ea7-d49d-4780-56e2-08dd70acabf5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 23:35:08.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmgbPGNM7atJY/3VdQ6gEw0+Z72m44PWxRKMQGZIGBv/wIoY6zDgQb4Zq755NM4d3qrpLrLAcLCWhbeRWpFbpXmdp9GfwR/8dbwNgbvQ86s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
X-OriginatorOrg: intel.com

Shiju Jose wrote:
> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: 26 March 2025 21:33
> >To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org;
> >dan.j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com
> >Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> >mm@kvack.org; linux-kernel@vger.kernel.org; bp@alien8.de;
> >tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; leo.duran@amd.com; Yazen.Ghannam@amd.com;
> >rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
> >dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
> >james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
> >erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
> >gthelen@google.com; wschwartz@amperecomputing.com;
> >dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
> >nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
> ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
> >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> >Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> >Subject: Re: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature entry
> >
> >shiju.jose@ wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> Add helper function to retrieve a feature entry from the supported
> >> features list, if supported.
> >>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >>  drivers/cxl/core/core.h     |  2 ++
> >>  drivers/cxl/core/features.c | 23 +++++++++++++++++++++++
> >>  2 files changed, 25 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h index
> >> 1803aedb25ca..16bc717376fc 100644
> >> --- a/drivers/cxl/core/core.h
> >> +++ b/drivers/cxl/core/core.h
> >> @@ -123,6 +123,8 @@ int cxl_ras_init(void);  void cxl_ras_exit(void);
> >>
> >>  #ifdef CONFIG_CXL_FEATURES
> >> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
> >> +					     const uuid_t *feat_uuid);
> >
> >It is unfortunate that this naming choice is too similar to cxl_get_feature().
> >However, as I go to suggest a new name I find that this is a duplicate of
> >get_support_feature_info() in Dave's fwctl series. Just drop this patch in favor of
> >that.
> 
> Hi Dan,
> 
> I am fine to use get_support_feature_info() for the EDAC features. 
> However this function is defined as static in the fwctl series and 

So, remove static and make it a routine shared between core/features.c
and core/edac.c.

> takes struct fwctl_rpc_cxl * as input for RPC instead of  uuid_t *
> as in cxl_get_feature_entry().
> 
> static struct cxl_feat_entry *
> get_support_feature_info(struct cxl_features_state *cxlfs,
> 			 const struct fwctl_rpc_cxl *rpc_in)
> 
> Can you suggest how to use get_support_feature_info() from within the CXL driver 
> to retrieve a supported feature entry (for e.g an EDAC feature)?

Simply refactor it into something generic that the cxl-edac and
cxl-fwctl path can share:

struct cxl_feat_entry *
cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid)

...with the header in drivers/cxl/core/core.h where other cross-core
object helpers are defined.

