Return-Path: <linux-edac+bounces-2138-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF69A32EF
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 04:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCDE1F21CDB
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0A14A09A;
	Fri, 18 Oct 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B25nqX3V"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABA558BA;
	Fri, 18 Oct 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218908; cv=fail; b=jOr+t5R5OV1+cQKg/HxMYIrnMVuA3Tm/rfENIoHxt9/GH1QZmsGLRyqRJw4ABdah9fTD4aRqSFQwOAYp++qlYv/mAxZimJBFNeNKCCLBt/n8Ogqv+1hgzyaNshW3KGQDkZIsKyGNBO3xld+tukKuXmxU+DaBA0RijDz7+uXXdqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218908; c=relaxed/simple;
	bh=F3aFSF1iyX9hOVaRM9Pl5127NCa4y7bSIro9AO3V9vU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SR1CffESb8B/0Pe5r5LJ06E0jQ+48xhN+wjkIwED9VBlUe6nE+y9OUvJzzkwN/4CDyCFdkgyikI/x1cFzgTrw09QkZ4jvjmOhWs5qJuanpvx74jXTwD0wj7fVceA1f2I5leiDEoYVKGHrvJcNtxVnzFjfWGF0+1+QnUrLFtLopI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B25nqX3V; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218907; x=1760754907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F3aFSF1iyX9hOVaRM9Pl5127NCa4y7bSIro9AO3V9vU=;
  b=B25nqX3V1GcDoYWZ/YqwNU7A1CVwGykpwt01PZ13XAQRJ/TeBVwFPyqD
   5tWDmAyuPlgxKRv1DAlSMz/efCJvT5qT/l58r6uj1XsmeeHGMlz4c0TbO
   kpzEkt0JfD4M3+KiQHeoGgJVIIdeo2qZw3Vz6HYy1ztHxvgLOrBIPeWZ1
   tov1kb5IIUS49sOb4p6mebATELRetgKJuFEHV3PfL+b5Q7iaBT9VHALL7
   OTrzNs3AqaetnlPSwfRaGDW8rhYTxtZ170nhVlI3BWo9szOxhi/g+y8bp
   IiFjMwl3UIfQCfy/LzPcqYr9Byt/DaC4eKP3UWWiSl7AxX/4uCRUDspTq
   g==;
X-CSE-ConnectionGUID: Q4EEZb1nS324jTKVEgeaWQ==
X-CSE-MsgGUID: IfrQzR5wSsSxDJITQ0HJhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39864007"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39864007"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:35:03 -0700
X-CSE-ConnectionGUID: 1QEAVW+2SdeR7c+qcFxalw==
X-CSE-MsgGUID: bvhADudhR4i6P8rYz16I0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78882680"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 19:35:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:35:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:35:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 19:35:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 19:35:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2+8Cjuh0YESGdOwQl5ew4EbIy7DmySWwzoy9zoKsXWfhDpRX8aG53kyta8vIhZRvZlo08hOl7aWFoTkuSwmnJd2wC5br9HLUhM7E9UkFy+KHxLa/Q4NqQswTwurb89VV7F7hk2hbxr5PRaUfutnjmpyNASkieedsE/njTJSGtE+tGcu3FpjGMDL/HzOlHOnSJeLNfAxUAQmLuDzD1oUYAyDU6eOd1vSIxVdtKNr+aX4XqKnmUa+F/8R3BBaRSi+pPnF9l9neZT8eMnO9pIHs8C7wJjna46r1PY+vy7UpOCW6akq5jhykRxstQ/kt3ttQZoR3kkvAhDoJQw0mSy3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3aFSF1iyX9hOVaRM9Pl5127NCa4y7bSIro9AO3V9vU=;
 b=DS+uTVXZ7vvE2HH6kzGlFm4sfNxREfdHFxn9QL0AU2ch4LW11otDAi+CXpX8gb0zfy0TSat0ktZEtoPMCeX26Z1mAHeUyOUPdt3x9yLI2vbSXsyh/lsdtmslLSoT5v/Jse6VOJRLH+pylOK7EgXMkioim0QOJ0pIBXy6W54Om8BkHVgdVLIM35S4PRLHuSREwOlQg2VpYuwkzQ2J8sz+WtQKwyHSqcrnTn26TbvtFEve5Bwh0TPQDqFFaEGL4sV6we9NMVNeZtG32itnxrjV9bfWP76VNfcTufd1Bsy3fHxzgJ9dBXBuOPWYsGyhpNd12py8rHTZdilOTLKCxOOZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:34:58 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 02:34:58 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v6 2/5] tracing: Add __print_dynamic_array() helper
Thread-Topic: [PATCH v6 2/5] tracing: Add __print_dynamic_array() helper
Thread-Index: AQHbH5ZikyBRI4wavEGOaeFd7CEx9bKKgy/ggAB1w4CAANJcQA==
Date: Fri, 18 Oct 2024 02:34:58 +0000
Message-ID: <CY8PR11MB713442F7BF502223DEDFD30889402@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
	<20241016064021.2773618-3-avadhut.naik@amd.com>
	<CY8PR11MB7134B1AA1F13546D2B84728089472@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20241017095419.2c4a7943@gandalf.local.home>
In-Reply-To: <20241017095419.2c4a7943@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: 94c80860-cfe4-4e26-c445-08dcef1d755c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3ZiCdXn6BeEcomxcycizUURqyQUdHQMZmaEguXzWDADjX/JwdWCgpcXkTVhq?=
 =?us-ascii?Q?P8cIfbwGCmwe2ByyljlIX7szdoIx/TyPj/dk7ggIpKp2LAD4RvgriyuDw5TC?=
 =?us-ascii?Q?ti170pg/QD56+yLaUGIUMV2mKM2X6bTRnC2q2Hjw7ds/o9SO2wpMlNvYFffC?=
 =?us-ascii?Q?ymQuOWC5kVD/JUJ1Y1BsijYwl+v0jQAeo3nG5XaUYQbjYzWb1ZpSyvFPWmSS?=
 =?us-ascii?Q?MuHbui7dSFlKiMyEuB9GZghUDKiUO9y/gzWa13pHfYfLXn5JpuEuqcSkaGBT?=
 =?us-ascii?Q?hOAhFTfh7paFZJXrg7fDOaTjjeRrLifpl+VeEtinNu/2dmAcI97py3Ey0GT+?=
 =?us-ascii?Q?hANJ+l+lHw6fAmQJAU8W5nIBaaRaP9s4a3zXCruPNz3ax6Z2SnQQBub1z9IZ?=
 =?us-ascii?Q?/x1NCeGPmGQT5j47/LS+Wk+oUKdQQ9F8bQVeYL7Fi9UjASe3HbDBVhuUOiXs?=
 =?us-ascii?Q?KXUCbRFu3WVnz+FPG0YzC7RU4UWLz2zw5+u81jWjaXwYXkB0HAI2LgLdKTdp?=
 =?us-ascii?Q?Hpgp+iziwm83wZakKoWj7M4XJcMt4vw2s+270qPTN6LCHaopXXrl/SSacEIr?=
 =?us-ascii?Q?0nyWc8FQKEtNSvoTd2mcq8AQPinFh6JjWUIuukeoug+cyY5FZKbSJFNsrM7n?=
 =?us-ascii?Q?cHSFZyjm6F2oj66sJ164ItfUmZ00d0TSnfH29QvQeMOILbtPQ0MQv6LaZp/X?=
 =?us-ascii?Q?gSVzB09sf+YItAeZPXQ2qQArXWCDhPZtm5Ha+9Jdum2WBj0bftceXRTMGbyy?=
 =?us-ascii?Q?QaLqWpmQBGboJDDRz3UBVgDeHgtZ1FQ3ah3/oBLgviaTYd38TvDvLtutmRq9?=
 =?us-ascii?Q?/NXJdMbwU53EII+hHfWqFTyR+fVlLOQOeB+PmuNNvJjgni2QwrnJjVrlM92l?=
 =?us-ascii?Q?DBE5XvXclAtujDUe/HukxFD4lzmuvSqx0sH2itIRwcdTW4TWFTe+EsLpAcu8?=
 =?us-ascii?Q?zMoBMPaGJ2dBvW5ROoqOL92TF8mqPwMX8jGwlQGUycyx666dpLCsg/foQ7Lc?=
 =?us-ascii?Q?29y2egsYF5ZXSCyxgiCw91sa1fVn3kqA0Xte5nGzaIMgOyrNZyp6eBtQ5yWO?=
 =?us-ascii?Q?orKFkwCHLA3TPwVJD79LXol91Yv4xSN0G4S1o4GjPEq061+CbAomUknn8Acu?=
 =?us-ascii?Q?fmNp1eB/um6XJT+8PPjqzcQmCGrNRn+zeq/X14VSrc6m4ozJWOIdPEQPyZMC?=
 =?us-ascii?Q?ZyhkecvGjIciibvFhjlKcInxjgRWIXosad9Hdec4YC3wUemX+Zq0ZQZ1BUfK?=
 =?us-ascii?Q?g0mmQL9K/1neUuAKxVw/0pi7dR1h+xKoeZHKwWHGPANXFudbpkoytDgcBu0Z?=
 =?us-ascii?Q?svvlYuRo7I8SicgAPFtzWKGTCL+LNc6OVQWxdDyBQnzEslObDKlQ08Uv4dCC?=
 =?us-ascii?Q?geL8QOQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2OCepRXxoc3mO0splP05NsmL1y3zdnNy8rt/ayJCg8Q3wFTao5Lls3AVBIvE?=
 =?us-ascii?Q?s9Tt38fzZ0OqaEvuVjCuzxPZNY8YcY8SDwmIEgcwdi3gVenRIdiXuIC2aKp4?=
 =?us-ascii?Q?kS3Rwxxk1iUVM0LjS3aPAPO2VUXfSO0ioUe9DqrUbCPpngWBbHzl6F1CqEzk?=
 =?us-ascii?Q?BJws2PKJ+2Ag6eTnZA0aEWWmJ3MLP9YkaBXBLXPuQlzcwanblk+dTXvADrys?=
 =?us-ascii?Q?MhkerWHTF1D/S47rWgpu9dyWI3d7BzOYjDVc11aRcLGsVFA1vwKtkQ92XKe/?=
 =?us-ascii?Q?XBdpOh4/0hqNzL1i96kjC5EYR33sbwJQB0mUcmBXjRX2bMNfja1zJrZnc4cB?=
 =?us-ascii?Q?sKRvUXirPQzrxPWI16Qnn4StMDfNI36heTwxr6nuxU/4wDwgPvRF9ZRUMP3Y?=
 =?us-ascii?Q?af3pu/676I7Duib+8vaBaJmW+zZ44dRJO5HN2FTiLUVRjFvq5tMUT06M4jt9?=
 =?us-ascii?Q?tqKRJyfJ/RElgrgahE7yNmLelr+fJW4cyYqTyx77+LAnR86oXk68tzzayyey?=
 =?us-ascii?Q?9Z5YXZTB54y7PoxlhByCJd6TUaL+WbJK1UgVo47Yg80fI3tzb30xsiua/q51?=
 =?us-ascii?Q?uLzN6viU/2vog3jiwv0H/z65smBhq94+PsoceMR6GR8tkH9jMQ7IsHWJcFC/?=
 =?us-ascii?Q?h9YF3ogl+Wf4gyrWWH4lhE9nCM9GyJRHUK6IAdnpCiAZ4tUK1CKzKPNJRolQ?=
 =?us-ascii?Q?RwcuSW56QNFGsc7ito6hgHssb2PQc27uHIpboWIlBgSdcnwM/5iMyIsNKfqe?=
 =?us-ascii?Q?2tz45Imm5HXdhieqOowlnvQDCcTp0UPG3vUi5RQqGS7yEDZGo8bpxROK/O21?=
 =?us-ascii?Q?GtGdTU/ieGcS0l/sggx0abH7EvPk3Uub0d5RD6Y07ig5p90J0cEPELNBCQMj?=
 =?us-ascii?Q?qrwy68omxejT1z2VUjzDNTTzw33iCMPUYNWWpHdgzF77cGZmore3Jq+m2x1V?=
 =?us-ascii?Q?sqhm2WMMG6FL/yF/PyM5N9FyWG970E77mZhOA1Mu3Z3w4/jdWeDuQIoLNMQ7?=
 =?us-ascii?Q?bvcyDSAcTwc2WeltQHyERI4zTLDKKjRYm6EJdUfSwgq28Z0tkfnQKbR5FDMd?=
 =?us-ascii?Q?e96XY0zdcnW4KHkbA0tsb/lSwyfxf2ijDePHzQ4DjrbvF9fJyrudb7eRSMLs?=
 =?us-ascii?Q?UVhGl0OWULXV9FmP/A+HLcewdNLi4SRF54YHY/noRUYEHHVK24dQIOKvQH8v?=
 =?us-ascii?Q?f8qqap+jnENqRZthZBVp8QKY5YqVYo6oiMSUmQvJj4vJLjQMxiA2vd8JDAMP?=
 =?us-ascii?Q?wdUdzo3C9s1U054g/NMEpozX56wPs/hwJHinPUMr18gp67wgdLkK86lZarwI?=
 =?us-ascii?Q?tACB3T112vkOnDGDANhmOYE0Iu2skVLx0qynv+fozpFYQ8u1meuOEkepgA9Q?=
 =?us-ascii?Q?oL9KDcpkbdolahXczAjC1KkQrsKkA5D5ShA0zur+C3X5MalIC07sv7yXSgOI?=
 =?us-ascii?Q?zMnrFboIj0C9RltKlETotojrTYpw/65Y7ZiVD3UiviTHp/0nKHmkINt59/Sm?=
 =?us-ascii?Q?32KblAUUArI5JI6/eVqol30KSzx89gROsL7srI3sUIsAAIzWOXpdueq7ytK1?=
 =?us-ascii?Q?TPhjFfcXRzpYMnI40XQ7nvAUP83bSiUXobDu6SyX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c80860-cfe4-4e26-c445-08dcef1d755c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 02:34:58.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQ+4a+XUOeiCMVw1t1pVzNJe2TGTKxvlUDoaY84VMz/cSsW5SYAdF4HF85h+jmpU05hOmKFB3V8t7n+EwD84SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

> From: Steven Rostedt <rostedt@goodmis.org>
> [...]
> For once I actually agree with checkpatch in an include/trace file.
>=20
> I can send another version for you.
>=20

Thanks, Steven.=20
This way, Avadhut can include it in his next version.

-Qiuxu



