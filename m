Return-Path: <linux-edac+bounces-4019-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B2AC6D35
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 17:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3A5A24A58
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24FE28C860;
	Wed, 28 May 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1DRqfEv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBC1A9B3D
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447354; cv=fail; b=O8CGSvOGY8eteeywz4G9R2MsDRR5RDFI7yuxdAZwfHNyeOeoGXKz+ZaiIDuqzMuOzKcbIpKgmfFB12qDnZQKtBTsEp0RHvcc44kINFBAHPg6r4QzkEDDsv+z34o7Wx6PPXew6fhMeGM/qLz33SI8qeiZO4kobBpEeseUrSfZcWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447354; c=relaxed/simple;
	bh=dRA8dtYnkgjqCEjr4W8ynV8PeEUcPqxuyVwsnHvOqL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fPofB+1Akxe0KJ/OuR/5TTd8RpZ58TpKiaXrrC6ntke4nveMRARHXaNGJSZITrCqtHAIYMF1DxKoVMZz3C+k4wZwuC7eZc6ORCXBjv/WDRUTK92kpY0GTBOBAWizGP9ZNJrbNN2e2eufnOHYWNb3SKYXYr61x0QI6BLbw/5W6so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1DRqfEv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748447353; x=1779983353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRA8dtYnkgjqCEjr4W8ynV8PeEUcPqxuyVwsnHvOqL0=;
  b=e1DRqfEvMEnrAy5ok0gfatMLiIlq2QTtQyC0bfHjO1PdjJDkNTcYoC8u
   dHnRvtmTx/qjHT2xZPIaUQEQgjcZ6SyanLxT3VcPCfYcKAeFyfzl/CCTK
   M9foMhd0LWK5C2DX/tF3/S1v9OJNzLK4ja5oevgqKWaXXrpiJFf7h6H50
   WQocgfAj5sbv5CWM2I0zlTjInU/bpDbVRz9G9YH4BGTGXNmIOposzb9P5
   sQ00DY28eVekCcQpuczzkBmx8Mjq8T3xZPgK5VEXR0YnYddmrfWhtVHux
   5MPzfvUPOzwRCDxCcuyeIhOC4PMCYA8mgo68uku9kwby/4I+cpOc5GcMT
   w==;
X-CSE-ConnectionGUID: Aki4OMFcRMiRNdX/y40ZKQ==
X-CSE-MsgGUID: kVyB8eiqSNek6nVQSinhwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67895783"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="67895783"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:49:10 -0700
X-CSE-ConnectionGUID: cod71H/dSke1T/Cnxs/IVw==
X-CSE-MsgGUID: 5npjYSAbS0q+FajFJI73rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144246228"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:48:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 08:48:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 08:48:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.47)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 08:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfep9xKkBRpWDUrz15sccHU4WQ2sD+rG8fNBgr++tILJo3Br9SFJyYFXX/2Mxb2XZ8fwXspkCGckFpyH7A00B2iRBsZIHr56DTVmAxerVHAmvrZFDy7FYY+O05+cChPOTW/a5aXWbFE9ZK5/RraLtToRyGxfo6nrldvWuPMR3cVxv+8hrn5xLEdFNZAy1bTHULDTvg71bxeNRuCPQCYhCHqSv8uYq3snVBdEgGBx2Dcsn1USEgDjkBnr7W0eVkpwzXQc3SaYTz/m8evMc/UFoq7ON61wjXSX4S7vvj8OH7hNHlDm/BCo+iSLq30xC5yr1fE77SNei+KTl5SlxIWlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+30Mr3j/vcp6BnIAPVwuaqk1usGm7ws/Rr4alaW2Wpw=;
 b=paT6MOAQ6Q3h5L472X0TzvjFbIbycuY8/KfZceV9ojT68hTQpEwlYYe8C/GIOqflegCXa0hqnvAOuHXQKlJgYL/Q6xtgmqcS1dvHnur9fC6kzdHRAt+CiDrwcknzLFkBg/xzJsEqw2Bjpx1VXjDLIxdc4Z8O62wpN6uj3e98XP8sYR5M2vGjoQyjn6fA7mWDvDHhboofDOJVnA6hXizPF3AKcgXmyxy8ydD829WzRe+QDpQXsvVD0YyvnkQXCMQ8F142VceIcha0rkgzWU1rI5HWk3vlri39sKaosRi8dwJxY/+hGrZG6fVk6zAHUGoYvEwVb2ouUEn6GpWtae8i4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 15:47:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 15:47:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test
 failure on AArch64
Thread-Topic: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test
 failure on AArch64
Thread-Index: AQHbz44ravwctxXgtEGOmt80h/eaQ7PoBjwAgAAqQJA=
Date: Wed, 28 May 2025 15:47:55 +0000
Message-ID: <SJ1PR11MB6083E24E27AFDAA5DBE44974FC67A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250528050345.380-1-rex.nie@jaguarmicro.com>
 <CY8PR11MB713460180A89FCE6F8289A368967A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB713460180A89FCE6F8289A368967A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7512:EE_
x-ms-office365-filtering-correlation-id: 110b40a8-b742-43f9-b45d-08dd9dff0326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lSVfzx+QhekpRkdkFh0bv/XPVgg0ChUZ6MJX1n24wisOoLkWxZTe7AoVkMUI?=
 =?us-ascii?Q?kFRYYj8VA6W25Qfp4pOeMw4mGkX2LQV1Avmi/EHXrinpf2+1ixmplD7lIYiF?=
 =?us-ascii?Q?2YDV3ZvJzErdUgOwHigxFCPgY3Jdzk3L2XyNFin0fh1+aY7qsw64/geowwNA?=
 =?us-ascii?Q?ko7rw7WaKE5xRMDWH1GJufMD1ZjbzGzcZcodyJPbwJQRT4tDTraLMxVDUEgq?=
 =?us-ascii?Q?gJl191doP1xREJHq2NOeGJRfS1hnU1T+XNXeXt/DfSo17wmYqn/kTp0BbjUD?=
 =?us-ascii?Q?HkVx65qpSW3LMxJ3pMDozbPzPOTwGKiLE9/NcGaVRQ2OjSjCiDg0xkeeKO0E?=
 =?us-ascii?Q?5Fq+sfEqL92b/WpcNb2enGSUzou51Edezv1y/nJyJFD+UCGKY2jhwuMPQ83L?=
 =?us-ascii?Q?5FokE6Cf1LDWmSxJDgmeJdRRpVFWgdaIlvpbcGxUOY1VXMp317CIWwVQUZdR?=
 =?us-ascii?Q?l19s8ucIsNKDLVWCyXqpBaNMFVKbTJb+jzui8M8XKC1je/F0+CzBtyZ+8g9S?=
 =?us-ascii?Q?gYW6JcU8iBTZbL9zYem/WcwMSRwR/+QNdwLDO45QYXJ0icLchUy7IEibWVkp?=
 =?us-ascii?Q?bM4rkvrBEn+V/rk4M87Cngfn2T6mCYOz9JB1b5q1HXkcHz+GssU/SOB+RybV?=
 =?us-ascii?Q?1ZVfQ/ixUgzpw9zPbu7FVW/KePtCnNAeDmxTpwEUYL8dd1oSlr5HGUxzYe41?=
 =?us-ascii?Q?lgMTtlDnDZQFtSgEuG3qn2MzD9RJWhJ+lO/K7qhekyXw3uFW9tv7yqGf4xFZ?=
 =?us-ascii?Q?bFn/+6ZlJGlV6FymUUhEiPQH0U/sf6T9qXLLmwH7gn08Peqswvg6pUzPA3FG?=
 =?us-ascii?Q?8Dn+Gm4XjcNxSmoCAnhCZ1EOb3o8evCfEkCFas4NeXzKMzUVWk20Lf67gLXl?=
 =?us-ascii?Q?HbJUdYUPmxn9cRyKP+90r5NRamAMivUrJmMDg2UT6hrdbLDpVrzfozL+h5jT?=
 =?us-ascii?Q?I2DTj07FG6MeaK/gQSwT9d6ci9W8UbH2HL5fxU5XEzdFtNP5RMPdFuuVJ0U2?=
 =?us-ascii?Q?u7qfZxDyuhcTeD/qYiocuPvHSP9PZ0AraG7ixZgl4CoaEHFbVXLgvrKSiz4a?=
 =?us-ascii?Q?lzG4Jk5jYmSbphLAJboE59Is+GPzqs3vMU6rNUVA0wqVgaInXKQNdp5IIxwn?=
 =?us-ascii?Q?oJBtIlIsCdOVkbO0PcatFfs298DEkTXOg0wZQm8ooG/zNoZXw/mQJS10+XqG?=
 =?us-ascii?Q?0Y8z/f7h7F/FXMprBl6cQAyLaG/+pTEsuTr9XX0l7Mng9b53iOollOUYkgpK?=
 =?us-ascii?Q?nc2ZSEqRc8S5frZg3gxlSiS6HDmvqWcDJchBiHIZ7wEfnJoU15q8dR5H3QN+?=
 =?us-ascii?Q?UN5r36MsB90bsVKjqYTUONGPi2RAPQ9tIAAj46bSZ5cMhX80txihpmGjj/Jj?=
 =?us-ascii?Q?sIqEpZifc5grNq11iEHqFBHfvrV3bhxNpHF8xxwkoUZk9HoJTfqNFvMKjEdT?=
 =?us-ascii?Q?jjrtuVAlBNaGwg2AN6PusLVwjHDrXHqTIVfX4uQAxw5WY1c4Q0WfEalcEfDC?=
 =?us-ascii?Q?vru8I5IFIklDSgo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tW6IewFO9DFcQPGyBi6+Y1mN3/ra6y3DducEQyDNM3LtyQPApz10aUY3qcND?=
 =?us-ascii?Q?NiY1CtDuV2+C+K+X0Rmxqp6T/0q8u38uuZeuoaa+q+ezCc1Zg4raGB93n4sv?=
 =?us-ascii?Q?j74eSEI8+JmQqEd0/Sit9JSrVQO535S76LcZKXcnPwFRrEH26QrjnG1PvTdY?=
 =?us-ascii?Q?g5xSvMxmwz+Wv1BUJV1vkv77nJyc0wrjnXeLM+gIlD+7sI7zYd+01i7iF4r9?=
 =?us-ascii?Q?7S/Ok665u/3AOyCIfo6jr2QdNc/3wJR5a09vB6FFCxkAYgyQSuBg5SYWGqIV?=
 =?us-ascii?Q?gKxFoVqgwY5dhpwlXCIjnZJ+4S9VSn8Y1lPVBklW1Ob6dLKeiMkQYlVkhRtQ?=
 =?us-ascii?Q?yELAsPgtS12+O28w7tfvO31PAuZhqDeD0UewEqn4UVRg3P+CcrbaQr3OYzP3?=
 =?us-ascii?Q?LRihiJTWMSuP3qRiGyxzKnrVUxh2eJMU2gu9rfNpwctOsGx2IEflsz5VYToP?=
 =?us-ascii?Q?HT2F87YQptZdkLkrbaxkZOhiiihqc80ECyb+A1kyFikuILBcD5gpTbYF1kNG?=
 =?us-ascii?Q?Wcod2NepkOjPkWKTKGO9W2C8OHo3YWZ9C7uDLnz7IrSl94mUH5nERpitTuhq?=
 =?us-ascii?Q?8ZYO9YQtdKR2EG2S5hRsnvEA1ImWUJM1+RcQn8U36ERkMafda/dIQcMBl3mI?=
 =?us-ascii?Q?bhrwflixVmPQrjl0p1m8ufOKxM7IF6ZlYYLC3H9OG8IPceRSO+/YxX2kz8rl?=
 =?us-ascii?Q?4xl5FHQEZYse1TLmYOIYBVsby1N7OQGSSdG47IlVLW3vFTC6lOhmx1zqgpTT?=
 =?us-ascii?Q?zy5PzkuGwZUwEnJj/qApByTdfRoIpZeCAobnEjrZbD2dzkKizqROMGpj5d9a?=
 =?us-ascii?Q?X8MPHtKTGNFbLuQgRj/f61VgaPn/ft6tbw1UAKFDqe9i7/MmgB7jqVMky4Aa?=
 =?us-ascii?Q?bZWiIukZKaD4FQbyMZOqQzbjbkMB1A71tSgcNIky3pBmYQfZsMcvoxX8MIvz?=
 =?us-ascii?Q?lr57QPhrd+OekDHL/uqn8RFcZV4SHD4g2GDUcc0Qsb+2qiKXYZ/I7njbqZF1?=
 =?us-ascii?Q?sNxaUoDZ7EgtdPGOBcYAjbX6g0oi5eCbXxyQdNeCo62YhV5YrJjPzS+j9Iiz?=
 =?us-ascii?Q?VF61bO+3dPRrPj+7v+efZSpDi3eSURC+hRYz9IJz9OLB/nhAyQ6QZWq94f5a?=
 =?us-ascii?Q?9KUA8dp1MkKT/ujBEaj6umRYgSrprrB/O2oED8HaqyGrJAFIBRF+8d4TZIQC?=
 =?us-ascii?Q?H8eJVXWMcJqtzbKJybtTdU3S1JbEzucLBMyPukwu1waAR1EgNIE4oRPlTGoE?=
 =?us-ascii?Q?lvRoCeJ23s1OhOBcKs5U4AHj95N9gwA+GlspNJ5LtCA+eSOPfcfvHw2JLyHS?=
 =?us-ascii?Q?Y0StUTc6+UrBazgIFx0jNgvE/hxpxtVsPaycdX3CML8q5SpeAeIzg9jqeYyw?=
 =?us-ascii?Q?znRYxYTw2aDXxZBV0fqZdzyrIkDDoEsGwPYrrbHQAJ6/VRE4rqs7pIKpvXqm?=
 =?us-ascii?Q?sy8pn1/acTYvaFj3AL3EFvH1PzbIXW4zftV+Rev4qoI4ZR+SkCkA0qK3byOH?=
 =?us-ascii?Q?Js1mHdppq3JJrAE/yevAnWE2TO1UmxJoUlaNtiq5Lwc/HZ+MnE8YDHcZQ+8R?=
 =?us-ascii?Q?Qqz/f2q3MGoWSUzvhL83vTOUHf84nmhYBy+iXBib?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 110b40a8-b742-43f9-b45d-08dd9dff0326
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 15:47:55.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0Pd1fgVMMDvaPxI+JZWx+dzuKI20NAUPl3MztCA+0iR6/Q+AVPxg34uR+kgeRBiJIw4ovGO9EbQHQX6xh7bmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

> There is no /sys/firmware/memmap/ for non-x86/x64 platform, so E will be
> empty. It will report bellow 'syntax error'. This patch will try to get e=
nd of
> memory from /proc/iomem if E is empty.
>=20
> Running random_offline (random soft offline test for 60 seconds)
> ./random_offline: line 61: /sys/firmware/memmap/*/type: No such file or
> directory soft offlining pages upto Using random seed 1748344561
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> ...
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> time over
> soft-poison: success 0 failed 19856 of total 19856
> unpoison-failed: success 0 failed 0 of total 0
> poisoned before: HardwareCorrupted:     4 kB
> poisoned after: HardwareCorrupted:     4 kB
> PASS: ./random_offline -t 60
>=20
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>

Thanks. Applied.

-Tony

