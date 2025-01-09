Return-Path: <linux-edac+bounces-2858-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9402A083AE
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 00:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CCC188BDCA
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 23:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293E2063D4;
	Thu,  9 Jan 2025 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcfJP4/u"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A218132A;
	Thu,  9 Jan 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736466713; cv=fail; b=ARTlJWSr6l+flr/Ej9O+pN12Ajhq2/F6NtykvOEkPIBuWgQTthVgx8nrvfGSUC/Mx/YOahnXC+QejAog0tflKujSr2lwI2t8M2p0zANk2mBLegRcnbjriBnGbEFUIuPvgWuv/JDSgChcs/c7mP5remHVqN1pp8U2daxv9/AQdG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736466713; c=relaxed/simple;
	bh=hDXv5ZXic8UzhpmsU8Dhuha7Llxi470A1xfccdqiOXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D/kGcnHq9v7gpro11Is6XfNALCrgk/D90SnchKl9pToMCY7PSlE4b35sZ80Go8P/meOhAMV9pBfl0oYPnuv0fmrcB6u38kLyyzxCtw2/81VHlkfqV8o9u45ylzj90NTm5tLnt92PV+GcXjQhPrTy1KBYnMZBIXZfv47ykqtHL3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcfJP4/u; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736466712; x=1768002712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hDXv5ZXic8UzhpmsU8Dhuha7Llxi470A1xfccdqiOXo=;
  b=fcfJP4/uAtAHwxVhEuFHSMzXom9rQa15TXbuSl4Qkvp7qmPqsY9b7vYN
   DzPLO1Ve9NmNVMmfv9UkXrOpQABQa9ltsuL7KIZ54X/L/EJEmVXbsja8T
   yQTYEltTO6fb9nq4rEGo3ZIE4t/x8e0LxR1zuPqo8atqSmIzHFAg4t+oQ
   MZLi2DzOikveG5OAK1l2OqZWnFRpuI2u723K2yQ15fSMLkui/IN7RRms4
   CuTkuNv77AsDIriv8BOJLW5SaFX8bbKdMaP5yESxnqyEd9+4nj0Oedu+t
   iWhmzEXDYXw7x5yxRHTvKo/lRTLCFU1asX2urwpHLT9az0HImJHm2AwWK
   w==;
X-CSE-ConnectionGUID: rkIk6YsLRY+fez32uiYlpg==
X-CSE-MsgGUID: oL7NKXfpRhSkYapFJ5L4bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36035918"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36035918"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:51:49 -0800
X-CSE-ConnectionGUID: ic549LJtT1qaSvYjQi3P7A==
X-CSE-MsgGUID: oO7JVlyFQSyTdV8IdC9B1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108604479"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 15:51:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 15:51:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 15:51:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 15:51:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr7KV1Ek1uI4lMHJBpASMpT6ELG+OENnQzHBQnn4HIZ9OGtTGIgMe5XjF7STxt1NDFeP66oxnmqWLG14D+QC8IRljCE5CPBxOHNN+M7aTXgRCn6HoYWG9E0BrbARyOc5YFE7gYkAxsUhyvvX0sdqtzHELpYb9RhMpLDNYyqm2gLkiT+3acyZD50SD/E2iey55gMOP5M7n64oQafC4OQUYvuw1BfmDZIgFT6qB2OpGgAAGlSc2V1x/irroRGzfGuXTC6F8/ZzkAV8S7OMzTaVIlP3cHCMl6Ucea38BsQ0NYbm4de6UGCLc1fl0pXubpjEvKQnLBz83Oj6OKx8ajnHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOlxWkqqOaeFKa/NzPMh7bKbxaiutdKDhAGkCw3vxTg=;
 b=YtW5ZrQdGPWrJCYJdXEoEiqoqJZXBX1qq++Uq/XD1HmMjMjfybEgoqNuFoS6j0K7KDW219nDosg0FLud5ZuVjL/vFFIOdwNTsssp9gs5wWwjPLAwJn8q+JkPY7IUOUCWATvH842AfiOHWxSBIYMREWj/0gZEULKynQjbSLk5UP9fAt5dtNl0e727LduK+dyNwwsj9Le6Kh5Df+muirC1PhQAFP9e8LDewD0PstbVkvr723di3wtU8WLNlURyPNpl74gjWtBVNQjH7PpnJCXysy8imMPPrhUbxOLuD1oCjwHpmiS0nIjYKQjr7aQALDpPtCAfAcOlU3FTyh6Go1KW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 23:51:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 23:51:46 +0000
Date: Thu, 9 Jan 2025 15:51:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Borislav Petkov
	<bp@alien8.de>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-5-shiju.jose@huawei.com>
 <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
 <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
 <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
 <20250109142433.00004ea7@huawei.com>
 <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
 <20250109160159.00002add@huawei.com>
 <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
 <20250109183448.000059ec@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250109183448.000059ec@huawei.com>
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ea234c-fe44-4edb-721d-08dd31089352
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8q5oJBXYApkB3pPw20By34JiJUGT8yHnHgMpqN/4F7JEEJ13Mi64idPkAa7T?=
 =?us-ascii?Q?n2BuZpDHmlgFN6C18gDCwcDiCKXfSWWlvp9wZJtY4r+l7FOthIDmdH67wupR?=
 =?us-ascii?Q?XRIDRqVQ3MtHjgpKCIKJIWOp6Eu9V+lKfWxTH/MmQDOzLYr67wwk4JIyo5Np?=
 =?us-ascii?Q?9onoCzUrf78IyhA4Rh1S5Cf/U5n4jrqpukePTz2TostP8IcjB5nQjPKXVEGY?=
 =?us-ascii?Q?1BC5A0iYr65K/nlnMyzX9WwJFQD49pL8WEzhNkajHwV71tn+kMzmHO/WGFHb?=
 =?us-ascii?Q?qOQwADHoruLIDW5MMesYebZyhKgbbzb/XdEGjpAu2CEMM/3TJkklnbxsATgN?=
 =?us-ascii?Q?lwD2Z4wth1ke0C9KBpuhbN8Xcxu4ekyYzYofN+6DRxHKiTOPNbX50aThJcgY?=
 =?us-ascii?Q?t+XUGhYVk5sLl5YlAokzmlBhsuzqqLVpV5jXJR6Z6Ae71xoaxwK+eeIuQV2P?=
 =?us-ascii?Q?0UYfgefesMwSJU1tH0zKXpFwY66hH92MZz3CtEsiJdXVrUICCoSIl0eLD9GC?=
 =?us-ascii?Q?+EsCX7uyLNByaiBwWK3fwS9yhguaKexazMD7UkR5xSGk/i1pzK89cEh7rhuU?=
 =?us-ascii?Q?/o/LCOzCY2tTR5sJNmDPk2NlU6M51W4KDm4XB2rdHs0RM1Cgrr78nu1QLQWL?=
 =?us-ascii?Q?toUkr5mT6sYsI+KivxhIIEk2FwdshqRk6qOriQ7Pxp5B5uzJPNmlnR+XoZnL?=
 =?us-ascii?Q?GwNN6fA79f7/muCQLDElyt4MqFgBKX0fGD+D9onvAqg0hQZYZtRMmz31GcYc?=
 =?us-ascii?Q?MX3VjO7/l3UPZwe3+DrMY8NotSCZQyPXhOxRfoa71fob5/99Yy0KCRX5DC6Q?=
 =?us-ascii?Q?XsRrQ8YmLo97+Qo3d3/hXh2p1/XaDgvTE2HF+rzTLWp5hPp5l32UPNx4kkz1?=
 =?us-ascii?Q?Gh/B+M0kbLpByGAntkl2zXzlqWu71lYpDwxcw+R6VFXvTIYUKmhpqhSOgn+x?=
 =?us-ascii?Q?N1hQlD8gg6LsznPPnhKI5zIMu1b/xKk1/0YWNlmV/u1RFx7IMZaoMwjqPBKY?=
 =?us-ascii?Q?jmfpbtcBXhpKstho33Ux5mcTU4YgGDIxbuzPjaCkDOeA3XM2+y+KgbO0ULKD?=
 =?us-ascii?Q?OYC7vgVEr6BP7m1P1tMviO/1cdlcKK5DsjDRBU0eXYITk73yuYdzrKquLkVN?=
 =?us-ascii?Q?mvOBiEMB8MCxqakmIF+g+LUlQT1my6ELv3Cboi9sNAxTm7Kd+hEbdHgrbT+Y?=
 =?us-ascii?Q?/ucULkcC1QzHM6mDoRWiu+n1wgQu/bkIzUJz+pXno/i21NVrGo8LribymuhG?=
 =?us-ascii?Q?BywrbgyPttX7Mgdi4xFSjVq9izH37Q5qR2l1mjbyf/anOI9CzJDnED2OCuM1?=
 =?us-ascii?Q?31pZf3TZi4AuiqKICn2zPi+L0TgbOl4jowXlYwpk1clw8RAG/5saX8A6gFdu?=
 =?us-ascii?Q?GO8/fVcsEk1aF/6ZkqyVfxEEZ3gX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEofbUfJXNH0o/atKx6oTP4kQ53NFZPKq4wfE11RWp0tYGiXhvKIdyT/Mnjq?=
 =?us-ascii?Q?9mA+CZjThKVEIOE7QzmnreDBkEw145OfoLcsGcACR6o5TjabAVQUlDetJDTB?=
 =?us-ascii?Q?vCOmb2u6wnk5Fe9mao1YccYrhAicH5rIWDj4WjXqXiq5jszIYJsrC86lhOOv?=
 =?us-ascii?Q?2R4u/oddjg07P88PVXw7F2N91U2iC/27MZxk1GUE55EKpquYSotvLtpE3gLG?=
 =?us-ascii?Q?KqrApI8aFrgReLRZWfjo42pwoO8zkRqk7KkluxkpPX/UHhyN96z6StGk+YQb?=
 =?us-ascii?Q?viQ6Yrv3M3xrt6i8qK4A7nKhaZRGibV2WHxFIr40+K83ab8DBc7mn9GtTTRH?=
 =?us-ascii?Q?+hTx/4VGmhlYdIoX9u+b8liP+4p/WbiUp/JMrgrG/0yYBKOX192pLBczGlTk?=
 =?us-ascii?Q?UmyY4jQuJMuJxK8BkIZxdo1s20pbK0jdrQtA38x1WKPVhODvfsX3rFogghga?=
 =?us-ascii?Q?yASkzSpJf0XPL5S/w6rEybtoK+/PW03J+pmeKechK5SF9bhx3jaA+GKTDkAy?=
 =?us-ascii?Q?Bgi6h1TvhtFuAu/3alO7v3z9fyPiyfYLKTVkaMxh5wKIUz5N1X4M4eyKcBeT?=
 =?us-ascii?Q?wJt9J1BTCrIaz+yWtfcZN0yFzxGSxj1i/YKq/It7nAqnlhSrAu9/6nCf+508?=
 =?us-ascii?Q?pN/YwLZB1A1Njtimp5LWF7lVAEDKB3bx6Qg/tTmTAEJ2ecnGEJZDzP9OHuGS?=
 =?us-ascii?Q?TnHjRWJWUPsJVwr3YGNAXHogifCsskbamSje6uQQKoXBI5DxTEqfiA4ytRGm?=
 =?us-ascii?Q?U8dSvbOHGtiBHAgh5esUIeXYgX5EgGjxykhOWn192GHzRAkMjvJTmwYTMp5+?=
 =?us-ascii?Q?8J39wBH9BLJ7npE+k5nEDv/eA2+DWNLD94j2KJiDq42YvRDjEKgPhM05kbW6?=
 =?us-ascii?Q?/mQdnY8x2loCuMBJEBJ87qHn8FquScaZqT6RTbZmvrVfOq5dkf3+X9vtKOG4?=
 =?us-ascii?Q?9tlqn7TLt8rX6uOISyjUcezMekKCY5j4jJppc2uyBti8wnj5T7UKwL+C0q2+?=
 =?us-ascii?Q?fqspHxDvm/PjOkX9AY/55Ir1h8BMgIVZJIr2i6+GKDVO33H4EOfREyg6NtoE?=
 =?us-ascii?Q?02cvdsWZJDRs9QkbpHccY4GWlwBKXCW3rTF51yyP3VZbk7w2HPhpUG99ex2s?=
 =?us-ascii?Q?kOfkiNZ+gFUmPA8jESDzAqrgFMDbgA7EgNUHaMY4Jm/5jQMv7b9al3HBBnwA?=
 =?us-ascii?Q?rKAHrNKCs2J+hwcN+FJKIywGrNQp72vcqNpU4LqEqNo62Kf9Azhg7QJOCeXK?=
 =?us-ascii?Q?Uoipk0TbT8gn6axeKzcNlFl+6GmsHAHlEWeAcxzUBLnkFS0gLze8aOiCMbqW?=
 =?us-ascii?Q?RcXe9+NGtb9p4Y2n7gLrudSwI5VnT7XswA3PKz5T3kY054FANu154M1LBhPz?=
 =?us-ascii?Q?ukc410vhuI/tRjGVtHhXvKunW1QpHI/P64MYsqFsHTHSkBgOg1xYpem+Cg8S?=
 =?us-ascii?Q?eX6tovKh1QoSf4VqDmbYRj6lFTKGsnp/f7+7T9IkgL+/MolLdPoNb0/Gl2h8?=
 =?us-ascii?Q?MgXXqiNCdwKqKeOpEVzZ6WCHe32FqDxDBgKfcqYCGZA3IYepQjI429/+9UDn?=
 =?us-ascii?Q?4SAFUDrWC35qWKKB0hmRp5NRKwSA/Ih1gDWj1LfP980yFQPIoGHyMBs2e/lf?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ea234c-fe44-4edb-721d-08dd31089352
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 23:51:46.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trtjteCPl0n0iHZ4MQB7pXhvcr/SP7ZLw9VEViOiIIsyPxAsOKIeKbCDx7Ueehn+UH9F4SzX0B+sl60g34kC9R2mpzGXsTCyj7CmzET4evA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> Ok. Best path is drop the available range support then (so no min_ max_ or
> anything to replace them for now).

I think less is more in this case.

The hpa, dpa, nibble, column, channel, bank, rank, row... ABI looks too
wide for userspace to have a chance at writing a competent tool. At
least I am struggling with where to even begin with those ABIs if I was
asked to write a tool. Does a tool already exist for those?

Some questions that read on those ABIs are:

1/ What if the platform has translation between HPA (CXL decode) and SPA
(physical addresses reported in trace points that PIO and DMA see)?

2/ What if memory is interleaved across repair domains? 

3/ What if the device does not use DDR terminology / topology terms for
repair?

I expect the flow rasdaemon would want is that the current PFA (leaky
bucket Pre-Failure Analysis) decides that the number of soft-offlines it
has performed exceeds some threshold and it wants to attempt to repair
memory.

However, what is missing today for volatile memory is that some failures
can be repaired with in-band writes and some failures need heavier
hammers like Post-Package-Repair to actively swap in whole new banks of
memory. So don't we need something like "soft-offline-undo" on the way
to PPR?

So, yes, +1 to simpler for now where software effectively just needs to
deal with a handful of "region repair" buttons and the semantics of
those are coarse and sub-optimal. Wait for a future where a tool author
says, "we have had good success getting bulk offlined pages back into
service, but now we need this specific finer grained kernel interface to
avoid wasting spare banks prematurely".

Anything more complex than a set of /sys/devices/system/memory/
devices has a /sys/bus/edac/devices/devX/repair button, feels like a
generation ahead of where the initial sophistication needs to lie.

That said, I do not closely follow ras tooling to say whether someone
has already identified the critical need for a fine grained repair ABI?

