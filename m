Return-Path: <linux-edac+bounces-2877-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358CA09E5C
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120D616A762
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB572217F48;
	Fri, 10 Jan 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSD0RZkQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4920A5FC;
	Fri, 10 Jan 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549383; cv=fail; b=rz/p+WuU6xxJ0hQC6yW0JitdRXxpjfvl/SCH3RMQeEkbf80Wl0kWNuCEsBpPyX0F/kvzrkdhxp3RsDZVAVSrimMsFYNy4pY0z6dRxgTUAUqplvO4tNI/vc+b6/kc1xyF86fFFg0A53sn1s8ji2Jo6/6v7MinJ9CWew+3xrsbmyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549383; c=relaxed/simple;
	bh=Lm7IQtaOsTzYgcLkDNFJgGViHIVt0BMgUWiRXfxGiEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uUnoQhsoX4kMHO0EQBbdQ1sWniQI0qhI4t6zBDsN4DCNp2EqK8INadgM2YhZ+/ktgnkFeGO0hDoAAnVCqM3nwhjMz7WrNH+0v4yusnq7ujWKkish3ri5XAbvHu/gTCn4409CQ+hACipqx16JUKcnCkqHLEJewcB77cAW0rdNoPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSD0RZkQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736549382; x=1768085382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lm7IQtaOsTzYgcLkDNFJgGViHIVt0BMgUWiRXfxGiEA=;
  b=jSD0RZkQleeWo/L8meyS+4h0W46BMbBia5yuGbzSJEauigBQCF6mGIER
   vRiCsXSG9jNkKuhlDtj/MB3QuNRGSwKxskl9VQINlx755Kz7jGbttMRQ5
   OhUNYnlmjUTS+DBUPVblButu6T7zAE6hVmgBarSu8FLK8MiwFWpVA0gDp
   GRpNWmuO/0SJoNsmSfie0Axt/p5CJWA8R8XY0vowx+k7pMPdtGUvgQBhS
   BwyQDAFxdtdlM9C3cmLnL2p6FBMDVq180oLSX/GOEB9kqGkr4cv5OUn1Y
   QQZOI2eTgDpVWT1Qm9pcmSa13MbXaSNqVjf7FuuddfiO6pIemHz6q5guZ
   Q==;
X-CSE-ConnectionGUID: go+VYJneTWOxVMT9R8GQXA==
X-CSE-MsgGUID: MoCqgBadQtuexDri9xtGkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36541711"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="36541711"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 14:49:40 -0800
X-CSE-ConnectionGUID: sX7wJaUSTC+RpKN9t9Rr3A==
X-CSE-MsgGUID: c7aAYmRBRkmSJI0aRYzUPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104740447"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 14:49:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 14:49:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 14:49:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 14:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xemKicTA01IJFzbnMoM8DmmDXZSiKwuW5fXZN13z5ikTw612sII98nVEvipZuG4zxbgrGV6DmLjQSZnaHpoh2/zcwTh+NV0HegAtQybhJ6kOW5XwlOgUqAJpaT+23/pxFD0wM0ZH9ieSpil9VxgjYB7gFnMiqRCgP/MkTPr39cMzOEajWYg/7g1eo5lW5Gv3yP79RHw1/aqhGtKAo8DYKzp/kkGIidvWIxUtfl0N0h5u+yvPM1iu2FxJ0gksvjD/nUrVLkhOSqKw4eBTGppYQ4NellPk1CM93nOs/sUKZKNcUuH0Ua8gEvNUr3Swhw59arZQ5fD+T2MgrA7lXenC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glIpxAVd5LzhtHsZS84peyE5expnYnu+l0ZyCOj0VgU=;
 b=EqCRBnLtxiN8Qjd+/Eh4GmXKGPHhSSdkN2iE0ETgyEqPDJCggBjszRDWJmU6IbTJMbOVM1rDeHGqJxvjpHYVfcaoPSq5h+2iu4Q4n0C9DfCPoNBZyEVAbidj46wTY0etnX+BWIOOfpJOJ8q36qBZBSf8iCApi4NSuibpvwDBvc6VoEq8DKYjqywAEke1AaecIlJQntZlS5AoL3KrQW08vDh7NK47k175d0Zm4OngaPpFreze7HI2LVLvon1Qn4gcKhljuzHfLJT3nC6Y1jWQF819yE/V0R5hFNr445qP6/wbk/F7Pv2r9yuUZINLXz7GwDFD6oD15LwTWbx1qPbS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 22:49:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 22:49:07 +0000
Date: Fri, 10 Jan 2025 14:49:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
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
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <6781a3dfa53d6_2aff429471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
 <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
 <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
 <20250109142433.00004ea7@huawei.com>
 <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
 <20250109160159.00002add@huawei.com>
 <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
 <20250109183448.000059ec@huawei.com>
 <6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20250110110106.00006cd5@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110110106.00006cd5@huawei.com>
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 198e5d62-9aef-4340-2c80-08dd31c8fda2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/AK6SKE7Gub94oHs7ogt1YDDabZJ0mpuwo0Shr69JRy++vULWdo5fKApgAH?=
 =?us-ascii?Q?8DceiqUQCUHT0MOG4141q8Z2/4yJfMtjF+KgSAhkzEYoZsxgRR84qINa5PQ2?=
 =?us-ascii?Q?WBF+dVsxrG18T6kLActfF4l8btuP2B7YIr1de7hmMZNPBECQmv5E9Kb25QG5?=
 =?us-ascii?Q?9kx4Z2o7F4ul+PnYxMl/bJWjSH5ytM3llBnQsAlPi3iAZb47hA5PrRNszG+r?=
 =?us-ascii?Q?w52sLw9cPoGqZkbrLrp/84NvB4xUcEzTqrQMn+W+RJvMSeYwvpVpunvOi51H?=
 =?us-ascii?Q?CMkjPOZuC8MU28gm8XHHiyOy9wsAAY/a/36b8CCEHhnVbrE78Wo1L1lenXu9?=
 =?us-ascii?Q?drc30HgWmlLEabxub7THaAuyrXjrnEes3TqsJQtNhavMb9i/GT4y3cPF0iTu?=
 =?us-ascii?Q?VbuGjgwcSRkBGEWPWhkW6bW4UgIjLAqRvpTkkEpxDHfAvDjmHiaqBAMnaBxF?=
 =?us-ascii?Q?VeMvz2xQhy5bsbn4mEtWGUWvHAw3c82evO0aIUMxJ54eLeKR/1JTM8DG+se8?=
 =?us-ascii?Q?B9WL/V2aJ7tiI1EoKz3b5iJcSTsSUaWfV2F71GT35SUYGW2265G7D1QYpN11?=
 =?us-ascii?Q?ELBL93fiCFyi5WBr4JJeRnMiD5XBJrH+PmkP/3PtCycI4zJjunhKt92X1ylj?=
 =?us-ascii?Q?Mnxt43OrwO3eZPS88NJ0QGemkKkISQCHxgZXQkXcnb2l5/0jtmfmukIJ4m+s?=
 =?us-ascii?Q?rpuVH2Df15940mszPpqXcFj3G4507PyMpacyAO9z2cKa8cdGQAoSBerjBMda?=
 =?us-ascii?Q?mqA8vk182CJuztJFdEB3HR4zpfU85QZuC2y1DOR0UivmiHjeU5BGvyFK0J7r?=
 =?us-ascii?Q?Du2iHSgNq/ySdQbnC2o0EVN17EkwlIhWHZvjNqJEpe6nEpRXEI6ixXF1JG+c?=
 =?us-ascii?Q?UZvlI7hWlG5Wrfd2YPXZoYnUs5/9aSMisa3KvnYPIcpcdO9bVf0gnUMTWKfh?=
 =?us-ascii?Q?ocPlq80UfgHEV4d1HLa84joJ8hFHhDkHIwRXyqkjQUMynFvk9umSoeWyg807?=
 =?us-ascii?Q?Tn8p30GO4QpUmHUu+kp3Rj2GiG1V4LzB2NO1USYnyW4nnV9Kr5y6znbVMk37?=
 =?us-ascii?Q?SGSoIM4zO1DF5RAS1UxKT67YKYIua5SVYd0/WR8eqfXde2nrfN+wL7eY9v2p?=
 =?us-ascii?Q?6HhmmKkdjk7jtAS9E+hZQY3nLaC59hAzWXeJIsb4H/zCXWTy8+13OWUv7TeI?=
 =?us-ascii?Q?rj6CO6/zXfbZh22ol/MYzdE2jUowxverL0KT4Y6+cQB1zexBt4RTBsx6ge8W?=
 =?us-ascii?Q?p8ry4/g4vY5UClpzppiAZvnSJVbxUggEBOUzjlr6NUZ4/ln+8inrh5I/xkrw?=
 =?us-ascii?Q?/CEtBwJ0luytm6I3gU4Hk9Tiw94sgvYyEvPxqDTiiPTwwkN0iXfvo8PzpWb9?=
 =?us-ascii?Q?szgpB/GcL9Tk0Cgjba2ABEzCuUuD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhqOorbEvwEYRXkYh0SHTQW3yMvL2Nef2l5DRhaJrCxYn4V/lSv5+kCWNota?=
 =?us-ascii?Q?LVcpRcFOHJeiGS+4teCE+q4HjSc9eHVpNGHYv650oPD4INELDyZ6rzh/Gsqv?=
 =?us-ascii?Q?BqdMH/eZJrQGAM22MwM6+J1xIFz8DIqJk5gI+m1lMnXjkqQVpzK18kQ2SB/6?=
 =?us-ascii?Q?pD4S1yLycznj5K8WyDrRFo1A6eC+7SujarFpACepD711IlEak3u/vx/npBnn?=
 =?us-ascii?Q?B6DXASCLvXKEo4azzmN6kl6O0NDtUWstgF1rLAP5/83yffBaC6gkmONCpbxj?=
 =?us-ascii?Q?lNFYhM+ImOn2h7wKjBK9he1Cp/g1ZWMBmkd2yxwifvLQEH5XuCB6mm4WRvRm?=
 =?us-ascii?Q?PwCmy1DqbFsF0C9ggmrKp13eApQ/G3wTGibqWNRLla6UXIK2EC84hTfFCLN+?=
 =?us-ascii?Q?21AdY25qHM3ttiyG3qrRgqQfk9+G2Y4+p/1/037BA5nWUdaWXQ2lGHVLQEuD?=
 =?us-ascii?Q?nngJhBNw9TXI4l9iYsD7LdpikXAeUnFeVj8f9w96xydX5yaAJvS7aVDBoWx0?=
 =?us-ascii?Q?4m+o8pTL5bORtc41NT3S4kcvCStaGyCM+qJUsDUv9IT+BaYMAhGmof/78uZb?=
 =?us-ascii?Q?KyFYYWNORVN4bnBHEXNBwakmk9BwiWeai0tdP0c+O0hbnQRDEJpooHQF+hkf?=
 =?us-ascii?Q?BWVAjUoroZifLwAIPlTKKKPmMFFYvr0vE/9Ra87Y4I90HM1jToo/PUeRXRBl?=
 =?us-ascii?Q?yj350ucXGHXZAb7lmirukqOOoi5w+kbKxsv29HLQ0O/QNk711iQgrz8km8x3?=
 =?us-ascii?Q?TEG2zcMANQWTyrkEi8/1bbZR7zQNDQzE6Us2ytqsab+qeA1ESpcDlV+0vm+4?=
 =?us-ascii?Q?PmETcSZCXXl1timW0ljm7v++uF5ZWJY5WYIbh2C/eBuOup4Oskth4sVSEJOT?=
 =?us-ascii?Q?gbXohT7lvGaT01/XPBuYSgLZaJUspq+bf8eVq4l6f39oSKT+XknTGUwekugn?=
 =?us-ascii?Q?uGLqZ69FNNbVfof2r2dk2oKDubQBviI+D+3z7AnDF47AI4UxwBzWBspCYciA?=
 =?us-ascii?Q?GFR6+f6iiFpMylhgxO6XnkQitH9+or2d2ltKuR/Sn9wgUljetocRSHcLAhq2?=
 =?us-ascii?Q?Wyi1i88soANtJYxFfWjCfMf2BaEjqhkGqn+StIWZ8d1clXhoTvLVAlS8GwmE?=
 =?us-ascii?Q?jcH6zdlXDJPnFJagkUqj/hOPXQW7OR5veIbRXMRNL/8URbY6bBTpYektXFZL?=
 =?us-ascii?Q?Oefepl6vicAcV4YfhpzDukggi4zNgEPA8HIwqDFfqiXShyUk+4bmu5zUSSrP?=
 =?us-ascii?Q?dltExuxQTU4OPuN9xBj10p0h/fZmeDbnWPrj0UCCTlcXULYq8enMiy63mG8x?=
 =?us-ascii?Q?BKU/b99OXlzBtKeFrIBO9AEgP++QKUBa2XFDGeRCx0+V7GzIPxda9WmSA3AX?=
 =?us-ascii?Q?jDXDt1tPtp5tfPykmErOjExKnomLNWIULA/eWqAx0I86fsL8tAzvnjsL/2m5?=
 =?us-ascii?Q?i5Vp9DavpzKiEpbT5gujXmAuRdn8VFA4y58V9kru6VxL0OlvtnKUFg9aMZdi?=
 =?us-ascii?Q?f5MkPVdihF3uK/+Pk6WPhPAOKbUzmvqZfySGBotK3YGTCwkcDQsI4BuE7JJH?=
 =?us-ascii?Q?C62wI6zbRI9EyEnu6HhcnI1gi+IMUpSJSWb3r/N7j7Yd+jX2KQL/86H51MIc?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 198e5d62-9aef-4340-2c80-08dd31c8fda2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 22:49:07.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C7SpHpv6SQgypNJUb2vboLunPsYkgfFtADHL62rc7uWsC+bHmcaK0xPG62qK3QPvdpfWxD6/Ptf6iV7IqzJ6OisrWx6TGgnsK3rpfqzNx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 9 Jan 2025 15:51:39 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > Ok. Best path is drop the available range support then (so no min_ max_ or
> > > anything to replace them for now).  
> > 
> > I think less is more in this case.
> 
> A few notes before I get to specific questions.
> 
> Key in the discussion that follows is that the 'repair' is a separate
> from the 'decision to repair'.  They mostly need different information
> all of which is in the error trace points. A lot of the questions
> are about the 'decision to repair' part not the repair itself.
> 
[snipped the parts I agree with]
> I'd advise mostly ignoring PPR and looking at memory sparing in
> the CXL spec if you want to consider an example. For PPR DPA is used
> (there is an HPA option that might be available). DPA is still needed
> for on boot soft repair (or we could delay that until regions configured,
> but then we'd need to do DPA to HPA mapping as that will be different
> on a new config, and then write HPA for the kernel to map it back to DPA.

This is helpful because I was indeed getting lost in what kind of
"repair" was being discussed in the thread. Ok, lets focus on sparing
commands.

> 
> > 
> > The hpa, dpa, nibble, column, channel, bank, rank, row... ABI looks too
> > wide for userspace to have a chance at writing a competent tool. At
> > least I am struggling with where to even begin with those ABIs if I was
> > asked to write a tool. Does a tool already exist for those?
> 
> There is little choice on that - those are the controls for this type
> of repair. If we do something like a magic 'key' based on a concatenation
> of those values we need to define that description to replace a clean
> self describing interface. I'm not 100% against that but I think it would
> be a terrible interface design and I don't think anyone is really in favor of it.
> 
> All a userspace tool does is read the error record fields of
> exactly those names.  From that it will log data (already happening under
> those names in RAS daemon alongside HPA/ DPA).  Then, in simplest case,
> a threshold is passed and we write those values to the repair interface. 
> 
> There is zero need in that simple case for these to be understood at all.

This is where you lose me. The error record is a point in time snapshot
of the SPA:HPA:DPA:<proprietary internal "DIMM" mapping>. The security
model for memory operations is based on coordinating with the kernel's
understanding of how that SPA is *currently* being used.

The kernel can not just take userspace's word for it that potentially
data changing, or temporary loss-of-use operations are safe to execute
just because once upon a time userspace saw an error record that
implicated a given SPA in the past, especially over reboot. 

The SPA:HPA:DPA:DIMM tuple is invalidated on reconfiguration and reboot
events. It follows that the kernel has a security/integrity interest in
declining to act on invalidated tuples. This is solvable within a single
boot as the kernel can cache the error records and userspace can ask to
"trigger sparing based on cached record X".

For the reboot case when the error record cache is flushed the kernel
needs a reliable way to refill that cache, not an ABI for userspace to
say "take my word for it, this *should* be safe".

[snipped the explanation of replaying the old trace record parameters
data back through sysfs, because that is precisely the hang up I have
with the proposal]

> 
> > 
> > Some questions that read on those ABIs are:
> > 
> > 1/ What if the platform has translation between HPA (CXL decode) and SPA
> > (physical addresses reported in trace points that PIO and DMA see)?
> 
> See later for discussion of other interfaces.. This is assuming the
> repair key is not HPA (it is on some systems / situations) - if it's
> the repair key then that is easily dealt with.
> 
> HPA / SPA more or less irrelevant for repair itself, they are relevant
> for the decision to repair. In the 'on reboot' soft repair case they may
> not even exist at the time of repair as it would be expected to happen
> before we've brought up a region (to get the RAM into a good state at boot).
> 
> For cases where the memory decoders are configured and so there is an HPA
> to DPA mapping:
> The trace reports provide both all these somewhat magic values and
> the HPA.  Thus we can do the HPA aware stuff on that before then looking
> up the other bit of the appropriate error reports to get the bank row etc.
> 
> > 
> > 2/ What if memory is interleaved across repair domains? 
> 
> Also not relevant to a repair control and only a little relevant to the
> decision to repair.  The domains would be handled separately but if
> we are have to offline a chunk of memory to do it (needed for repair
> on some devices) that may be a bigger chunk if fine grained interleave
> in use and that may affect the decision.

Again, the repair control assumes that the kernel can just trust
userspace to get it right. When the kernel knows the SPA implications it
can add safety like "you are going to issue sparing on deviceA that will
temporarily take deviceA offline. CXL subsystem tells me deviceA is
interleaved with deviceB in SPA so the whole SPA range needs to be
offline before this operation proceeds". That is not someting that
userspace can reliably coordinate.

> > 3/ What if the device does not use DDR terminology / topology terms for
> > repair?
> 
> Then we provide the additional interfaces assuming the correspond to well
> known terms.  If someone is using a magic key then we can get grumpy
> with them, but that can also be supported.
> 
> Mostly I'd expect a new technology to overlap a lot of the existing
> interface and maybe add one or two more; which layer in the stack for
> HBM for instance.

The concern is the assertion that sysfs needs to care about all these
parameters vs an ABI that says "repair errorX". If persistence and
validity of error records is the concern lets build an ABI for that and
not depend upon trust in userspace to properly coordinate memory
integrity concerns.

> 
> The main alternative is where the device takes an HPA / SPA / DPA. We have one
> driver that does that queued up behind this series that uses HPA. PPR uses
> DPA.  In that case userspace first tries to see if it can repair by HPA then
> DPA and if not moves on to see if it it can use the fuller description.
> We will see devices supporting HPA / DPA (which to use depends on when you
> are doing the operation and what has been configured) but mostly I'd expect
> either HPA/DPA or fine grained on a given repair instance.
> 
> HPA only works if the address decoders are always configured (so not on CXL)
> What is actually happening in that case is typically that a firmware is
> involved that can look up address decoders etc, and map the control HPA
> to Bank / row etc to issue the actual low level commands.  This keeps
> the memory mapping completely secret rather than exposing it in error
> records.
> 
> > 
> > I expect the flow rasdaemon would want is that the current PFA (leaky
> > bucket Pre-Failure Analysis) decides that the number of soft-offlines it
> > has performed exceeds some threshold and it wants to attempt to repair
> > memory.
> 
> Sparing may happen prior to point where we'd have done a soft offline
> if non disruptive (whether it is can be read from another bit of the
> ABI).  Memory repair might be much less disruptive than soft-offline!
> I rather hope memory manufacturers build that, but I'm aware of at least
> one case where they didn't and the memory must be offline.

That's a good point, spare before offline makes sense.

[..]
> However, there are other usecases where this isn't needed which is why
> that isn't a precursor for this series.
> 
> Initial enablement targets two situations:
> 1) Repair can be done in non disruptive way - no need to soft offline at all.

Modulo needing to quiesce access over the sparing event?

> 2) Repair can be done at boot before memory is onlined or on admin
>    action to take the whole region offline, then repair specific chunks of
>    memory before bringing it back online.

Which is userspace racing the kernel to online memory?

> > So, yes, +1 to simpler for now where software effectively just needs to
> > deal with a handful of "region repair" buttons and the semantics of
> > those are coarse and sub-optimal. Wait for a future where a tool author
> > says, "we have had good success getting bulk offlined pages back into
> > service, but now we need this specific finer grained kernel interface to
> > avoid wasting spare banks prematurely".
> 
> Depends on where you think that interface is.  I can absolutely see that
> as a control to RAS Daemon.  Option 2 above, region is offline, repair
> all dodgy looking fine grained buckets.
> 
> Note though that a suboptimal repair may mean permanent use of very rare
> resources.  So there needs to be a control a the finest granularity as well.
> Which order those get added to userspace tools doesn't matter to me.
> 
> If you mean that interface in kernel it brings some non trivial requirements.
> The kernel would need all of:
> 1) Tracking interface for all error records so the reverse map from region
>    to specific bank / row etc is available for a subset of entries.  The
>    kernel would need to know which of those are important (soft offline
>    might help in that use case, otherwise that means decision algorithms
>    are in kernel or we have fine grained queue for region repair in parallel
>    with soft-offline).
> 2) A way to inject the reverse map information from a userspace store
>   (to deal with reboot etc).

Not a way to inject the reverse map information, a way to inject the
error records and assert that memory topology changes have not
invalidated those records.

> That sounds a lot harder to deal with than relying on the usespace program
> that already does the tracking across boots.

I am stuck behind the barrier of userspace must not assume it knows
better than the kernel about the SPA impact of a DIMM sparing
event. The kernel needs evidence either live records from within the
same kernel boot or validated records from a previous boot.

...devices could also help us out here with a way to replay DIMM error
events. That would allow for refreshing error records even if the
memory topology change because the new record would generate a refreshed
SPA:HPA:DPA:DIMM tuple.

> > Anything more complex than a set of /sys/devices/system/memory/
> > devices has a /sys/bus/edac/devices/devX/repair button, feels like a
> > generation ahead of where the initial sophistication needs to lie.
> > 
> > That said, I do not closely follow ras tooling to say whether someone
> > has already identified the critical need for a fine grained repair ABI?
> 
> It's not that we necessarily want to repair at fine grain, it's that
> the control interface to hardware is fine grained and the reverse mapping
> often unknown except for specific error records.
> 
> I'm fully on board with simple interfaces for common cases like repair
> the bad memory in this region.  I'm just strongly against moving the
> complexity of doing that into the kernel.

Yes, we are just caught up on where that "...but no simpler" line is
drawn.

