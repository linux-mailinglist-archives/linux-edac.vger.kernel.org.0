Return-Path: <linux-edac+bounces-1027-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0838C189D
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 23:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560631F241B0
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838E128816;
	Thu,  9 May 2024 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ec82F/Zf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163C85653;
	Thu,  9 May 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291289; cv=fail; b=Ea5VgcQRQJI9Qzb6GN+uN/CeZtBaNHPLEVgkw2WosAZj4lpG60MhiMAdGqIj92wlITKIEFfgKWP3J6SufL0Hbv/JTRDeHmghcFhdsnoyuDqcAtJaK2NHr1A1CWKV4V2m4dqI4NsjtiJr0cvF4dWjVMA4Zt+PHQHGIFCUKJ+TUag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291289; c=relaxed/simple;
	bh=o7Wap/AISLcpYfL4eRxrvYHM7bC7MAmwHspkuKPwqdI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OBBvMUP/rn2yuakR+kITAaf3oddBZCbyzHwBNckwmmwhyPcbvgBajpx28lPVAnToEHyxXo0Bzf8VEciFedZPtO4yvZaSo60w4/JvwcKK/lLDLBMJOFvH0FzEqyUSl8L3y3Sas/+J/X37VidQlWMokcZBUPeZuVbXjREwUluLFKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ec82F/Zf; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715291287; x=1746827287;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o7Wap/AISLcpYfL4eRxrvYHM7bC7MAmwHspkuKPwqdI=;
  b=ec82F/Zfs8i7d3iVBihWdXXPjX3Sroq58MKMZxQogtdjs1C6McOCd0UX
   z6j8fu1tujWd7L8sle4V7cehP5yY8BC1LDMTcD95qINFQplhKlJIY/1kf
   lU1CP83zbS3+scy2/W9FBomP/YoUTD/q+od1JDscB/sVEFR09BCcmz3Hp
   KTuuBsOS9A/SEBApjINKZJVZCjgfPh/DyJl5n/05Rc1DYCBRKrGrH8QCy
   qthHw/D4/CO2idH1aKJdCshykw2F7DZU8ecneNFu3p9POkjX5ObVY6s9A
   FUX29hWJE8NUBr4i/mRiqv2pBmqFVh42ZCh8I4ceYnFA4LdVxuH/RUTAr
   A==;
X-CSE-ConnectionGUID: ASQacSfdRoy3UYkIqdVGuQ==
X-CSE-MsgGUID: X+fx1iWiTumCTVedlIcAyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11411660"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11411660"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:48:06 -0700
X-CSE-ConnectionGUID: 3hoLkPNwR2GU15O7UvynSw==
X-CSE-MsgGUID: u3lF9k+oTeG17yrY0SEavw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29939813"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:48:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:48:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:48:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imy3nvvL1PFqmwCShaQjAfaPlRrnIeGGSqIGsEzdUszkZYMIkvrNjEeCiISsahUZQNLgee34DiXhwcbl+6stCtrYyacDPKc85oX4jWt7D4U74TjImGdo6haeONu11XUenF5edZPgf2BxfMohwAu3AwVKjUwViZOFsyBT7Bdv0AA6vhfgIbjcdJsMHjh9jXlHeZV1CvIy84RCy9sN9pVJ0vlLiPXNgnPkhstEz8/NnzGzqS+X72Kl8MF+fFE2W1vrJzqL8mALaW3kvnL01t3HwTc4RKmj5qRaA4bkH+jEbj3TIMNPIrqOkAyhgu78ptCV6W7PBT/MbldYBPRAaB/fuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px8sBMbabQu2hhAb2KzE6TpjFjQta0IO3DdiUYd2wmk=;
 b=ef/eU77nX8BUAmfjCIW+MB03ifQBvIHFSbnGAiKMVSrAIDd3zbtzbCcgkh/2T6AknOWHwHOwnM0ctY3avsNVTVuVqIrnldqWKvKaHbOP4oyq0R0lyPWTE+3Xp9TaP/BMeB9+7mAPlS6Ehr1Yz9gdR6pYgeWNrnimWNHPNaxW7VWu/WQiH/oC8VJR9k2XOltuiBp8jw09WgaqErVyvYpZH/8U7RnhujCDkUqEJ/WvLrneHR0m3XH/EjEUS590+xtdDRgX4spgR+j73O02uyQXUE6yK+az/bw5GUHMpM2up6exV72UsYlpm68NXv2iXcnNeYq42wkmnuGdOEswfmoh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.46; Thu, 9 May 2024 21:48:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 21:48:01 +0000
Date: Thu, 9 May 2024 14:47:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: RE: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <663d448c2ef3_1c0a1929453@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419164720.1765-2-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dec9619-3f2e-431d-28ef-08dc7071b2b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnBPM0Z5ckJlSTdGeHBqOENXUVNvU0VzMkpjcUlZdnlpV3BOc1pGSUdkRzBN?=
 =?utf-8?B?RDA4emZmWERsRU9UdGhBNjM4MlRSKyttbUVtOGFZU1B1QXFSOEZyR3AyZ1Q3?=
 =?utf-8?B?Sms0N0dEd1ZNNGhuOHN2OWI1Y0xhWDNnNGNVT2s2bHVobE84MG5hNEZIMVZM?=
 =?utf-8?B?dDRZbk1SaEdMK1ZxVFA5azhsQ1YweHBDclRUVXJNSmNrZ0NCMW9LMFZ3bVhB?=
 =?utf-8?B?SU1UQzN1bG9TN2w5YUF6UUVhQnJ0bXV1LzY1RVdKR0dKZmxQbWRmR2VVOGhh?=
 =?utf-8?B?ZTFLN0dUZFU1T1FZNGNsZkdsdGlpL0tXc0FOM3BHeWZIUGdSWERhS0gwYm4v?=
 =?utf-8?B?U2xONjlPeDhhS0MrKzBRcWdkckVoMzRoSHF1U094VWhiZXFLV1ZuUTZ3VlU5?=
 =?utf-8?B?ai9Za1g5TFpqaWl3MzgwazF1NTRiSEFDeEJnK0JPT1lRTGwwWVRPWWk1U0hl?=
 =?utf-8?B?NWlPdi9wZFU2WEg2dUt5Ly9FQldqTk13azhvNk9nVHJjdUdETXlmN01NdFpS?=
 =?utf-8?B?R0c2VzBnVDhlVlFEdHVoQVlwYzVwbStpRHNJNzJnT1dWV1FWcTUyc1pBdmJq?=
 =?utf-8?B?QngwVGpLUnNIdzBtQWVERHcydkwvejAwYitWYVVsdnRkOEFhZmhzb1VrVVdS?=
 =?utf-8?B?WFpQQjNiWFUrTkY5Q1BHVk1iTmNtcWhPK3ZQeTlJRnFscWtIZGZFRzNNdThD?=
 =?utf-8?B?bU9SbTcwVzlSUDlySWp5MlRLdWlVU3QwUHJCK2Q5ZEVXQmxPTkV2bGtRa1dN?=
 =?utf-8?B?L2hPRVVaOCtzVmhEejQ4cHNrMEJucVlCMGhBdXVjelBGRFRaczF3Y3dFdFVx?=
 =?utf-8?B?YUhyR0g4RTdHcFh5M0NhT3RKVWxSeWc3NnBCVUtmZ3RQZnpNNXYzV1MzV1lp?=
 =?utf-8?B?RkVGTTFHdGxxMHJCTjlQaUFGU2RWb054Q29OWFRvZWtPU1h0cW93VkU2MDVE?=
 =?utf-8?B?c3lOT2hHMlVKUS9UK1kzRjJndllrbmtLMVBaanY5RklFbVFxS2Z0V0hiMXZW?=
 =?utf-8?B?a1ZDL0tvOWo0aG9xMldmNDdacVBZUDNKQjlwcDBSMm41YmYvaVI5YTBUMGlz?=
 =?utf-8?B?SjduV2VBczJSY3FMYWdqK2N4ck1jakNXUG16ZDZKdG9KVFVpU2ZDRHdhRzJu?=
 =?utf-8?B?UktoY0VvU05xZGR0eUpsR3RCNkY4NEpnYzkwZHZLazEzTkRiUXVmeXJwUXd1?=
 =?utf-8?B?UWRmbmI3UnVsd3NlbXZ1enNkVGZPYUtPNDJsRWNtMmNKclduTmZsMGJSeVBH?=
 =?utf-8?B?NmdQS3JsQ0d5N0M2dUh1TTZzaHZDeEVtNmt1Y1QxREdXc3FWNFY0L1Z2Tk82?=
 =?utf-8?B?Qm4xODcwUUNnVVhnK3hZQkp2LzcvbGw3L2NjSFB6cDRQVkFoTGpXRXVidklr?=
 =?utf-8?B?RlgyTFE1U0RQVGI5UVNYSGRmcXZmQTlYdHZGb2lKUG1mZEJBOHY3a21CWWRO?=
 =?utf-8?B?VUlWOXhnd2N5OWwzaXNCY0R6bU0ybUlIZ3llNmVGNmtEM3pONDFYMjBvRTQy?=
 =?utf-8?B?L2RNOUJZYWl5WXRKQk11UHhERjlrWlVNZGE4WE9GeWRaWE9mZkxiWUhmUDMw?=
 =?utf-8?B?Sk1FN25TNmlOY0JTQWpMOHoyNGxqNjZPN3A1M1UrajVBaXZNeHBnK2QyZm94?=
 =?utf-8?B?QUN3SVBKNWVJTDR3Q1Rnd1lheUdsVmZUSEVxeUtHblgwSUhiMk5vc1p6d3R1?=
 =?utf-8?B?TGRNcm9RcWdxcVVzNTJuSFpUeElVRWRnTktyZmd1cXl5S3hlQk1ObjlPaC82?=
 =?utf-8?Q?YXqym/3xKzoZjPppXVgIu2s0vZb4+qJg4dp4mma?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVqSmhReWp2UjRoVXI5S29LL0liSGdiZFNNcVd4UFBVaWh2RERYNlo2cVFs?=
 =?utf-8?B?ejA5UWEzaWZIb0FQUzc1ckhDVCt2d3lzTGlraVk1eUVJRTFIRGpTbWJRK3BH?=
 =?utf-8?B?NEdBOWVVTmpmaXlBSWgzWEppMjRtK1ZEWnlhMTRxZVFtSU9wRi8ya0ZITEkx?=
 =?utf-8?B?ZXdoTGVXc1lObXFqeDZhaURhVUVmaUVDenROZHE1NzZGOHFCamxNUXN6cVdE?=
 =?utf-8?B?UVVTRW5wM0poOFJ6VnBFQ3dpOXpqR3JhL3c0VWhtMXBORTltaVZLZWJHS1ll?=
 =?utf-8?B?dnJTSERhRjQ2eDE3bTlXMjVzd1cwUEUwRXdjZnNKMVFJTHZQSEpNQmdlanM5?=
 =?utf-8?B?QmZpTm5lTGN4SFZtRExwVnUyZUdXazJDcGE0VTd5U21PNjVXTm1TeXQ4MFJU?=
 =?utf-8?B?cXFSVmpNdFF3dDlaZkJvSWl5NFo0WWdrVXA3bjNrMmZYRlp2dmhNempkWWl3?=
 =?utf-8?B?SEFwTnVPUGsxdUpkSTc0ajNxM2Q2Vm1DOUJBWEtKNnJFa0NlemdDUU5JR2Y0?=
 =?utf-8?B?TWtWYm0zNGFJY2lnWXNCbkVVSVhseXVkZFE4NlhsamNYUDlVU1RDTGJNakpq?=
 =?utf-8?B?SW9VT0dRMmE0M29UTkh2OEhUQWRRRUlOTnFWVWVqRFJYaURmcFJCRExYUitR?=
 =?utf-8?B?ejhFZ1ZsSitMelMranpPWlZWU3hrdHJxaDdGNi8vdmVmMHNDam1HVHN5QVls?=
 =?utf-8?B?aElZak1hVnR6cDVyUDA5Zk1VQk5ORE4wWWdrQUcyN3BiSENTWnBnN1pzUGto?=
 =?utf-8?B?MFlGMlE1YTdFRUxGNUZVcCtrQUswUzZxRjc4V25LMk12RjdFWGhQMmxIaWpa?=
 =?utf-8?B?TkhrRTlYMW5wMVU4MFUxTWYvbmVRSTBUTTBWRnlUczlrdnl4a01SNHkrWmRy?=
 =?utf-8?B?NTBpMUVZUmpDZzI1OTljK2RjUXpFSFZIdmg3Mk9rZ3VIcGNPVHUrRWFZaHBP?=
 =?utf-8?B?aHFmaFR5SC9pOHVidllkMElPWjAwRGxnVnNMelZEQjBYS09mMnNCQXp2WjE4?=
 =?utf-8?B?SGhxcFhmUk0wUDJDYXJCTURUb2IxVmJ2ZWRROUtKeWZhaVAwdlplL1V6Tzc3?=
 =?utf-8?B?WkI2U1NDaGVUdDN2bTMvQzlyNEtxYXJrazcwRWtqZFdweEt3RmJmQmJoem1T?=
 =?utf-8?B?MWdLK21zY2d4RSthWkUrcXdYekt1NllQYTFJTHAzam4rT2NVMUZYTUFjQ3lP?=
 =?utf-8?B?QitHTGdsb1NkTndHV3gxWVVJYnVKQTYrclZ6cnZMb25HMzM4Ymw4ak1PZVh5?=
 =?utf-8?B?cEVZcGhBZUJSUEVZYjRUUUk2L0VERkdRbENQUStmTng3Ui83T1Zic2lTVUlR?=
 =?utf-8?B?RXBvOEIxZWlyNXdXd3VVS2RWTDJYQjBGMW41UGxoK21CTkdxelF5N2ZqREhz?=
 =?utf-8?B?cExFRUl5SXlsazhCTVVwZTdmaTBxck1DZ1dxdGxubnY1S3E2b3FISFROUUFB?=
 =?utf-8?B?ZkVuOURhNjkrU3JCR1IvT21DdHZWM3FkUXFsNTUzNlk0T3BPYjEwaTZyRXRa?=
 =?utf-8?B?UW9rS0toL0ZWNnN0V1NaV05SWVpHcnN5Y3NMaEFYNnVYdWJMU3ljelloc1Zr?=
 =?utf-8?B?Z0ZBMXBtdVptVGtPZHBtUmNzVnhWNG9teUpISlJtc1VJRHVSRWxCTUUwRk9Z?=
 =?utf-8?B?TituM2U4SHZsak5OUStjYm9iUFVBZVJ4YXVBOCtvbDRnTVBjWDRzSlFCcnFi?=
 =?utf-8?B?RmtUNFRKQzlSMTFXSUw3c1M0TjZrT0VVck9KSzdDL3FlT1gvWW9yL1YwU2t5?=
 =?utf-8?B?RytNWGw2QWlnWG9VOXB3OW9aUXhkZE8vbENkMXo0SVlST3h2MmZITWlhRDQw?=
 =?utf-8?B?N3Y3YmZnMjdBcGZDSGxTRzN5N1hPei9kSHlIL2VLQlBCL1ZtTGJPQzdiTnph?=
 =?utf-8?B?cGZpVTI1SnYzd3U0YkYxSE54bWxEQ0JybEJvVnJjdUFORzVRRnZMbEV1MWdM?=
 =?utf-8?B?dnFFUzUxR0ZQeW9sTTl1OGtzZExiZ2t0WHRzV2w1UWVUWUN0RjdmUXNpd0dI?=
 =?utf-8?B?dFYyRGdxNEw3Q2o1ZGpBSWxYQVRqeVhIMkx3VkNnS3pFejlWMTRGT3AvVkFQ?=
 =?utf-8?B?WE4rd2xtaHN1TDZRUTVndHVxeG1NQVhYRm5zMlVKOXp5WFdKVEM4Y3BIMjhr?=
 =?utf-8?B?ZEs1ZVFvWmN5MlRzc3JyTGJ2ei9CV2hsYk1DVVcyK0IwVjdVUTBrZlNWUTl0?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dec9619-3f2e-431d-28ef-08dc7071b2b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:48:01.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oelbHCfZu+kzOKzK4rrW9eKm9BSXY6dgwF7mkkg7W8e2+ZMnGc5bMgcBZ/vnQ7PXw0TiZ6I8DfdTvSul019lLPuaY6hCg/PvDHFHd26TxfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add scrub subsystem supports configuring the memory scrubbers
> in the system. The scrub subsystem provides the interface for
> registering the scrub devices. The scrub control attributes
> are provided to the user in /sys/class/ras/rasX/scrub
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  .../ABI/testing/sysfs-class-scrub-configure   |  47 +++
>  drivers/ras/Kconfig                           |   7 +
>  drivers/ras/Makefile                          |   1 +
>  drivers/ras/memory_scrub.c                    | 271 ++++++++++++++++++
>  include/linux/memory_scrub.h                  |  37 +++
>  5 files changed, 363 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
>  create mode 100755 drivers/ras/memory_scrub.c
>  create mode 100755 include/linux/memory_scrub.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
> new file mode 100644
> index 000000000000..3ed77dbb00ad
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> @@ -0,0 +1,47 @@
> +What:		/sys/class/ras/
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		The ras/ class subdirectory belongs to the
> +		common ras features such as scrub subsystem.

Why create "ras" class versus just a "srcub" class? I am otherwise not
aware of a precedent for class device hierarchy. For example, on my
system there is:

/sys/class/
├── scsi_device
├── scsi_disk
├── scsi_generic
└── scsi_host

...not:

/sys/class/scsi/
├── device
├── disk
├── generic
└── host


> +
> +What:		/sys/class/ras/rasX/scrub/
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		The /sys/class/ras/ras{0,1,2,3,...}/scrub directories
> +		correspond to each scrub device registered with the
> +		scrub subsystem.

I notice there are some visibility rules in the code, but those
expectations are not documented here.

This documentation would also help developers writing new users of
scrub_device_register().

> +
> +What:		/sys/class/ras/rasX/scrub/name
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RO) name of the memory scrubber
> +
> +What:		/sys/class/ras/rasX/scrub/enable_background
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RW) Enable/Disable background(patrol) scrubbing if supported.
> +
> +What:		/sys/class/ras/rasX/scrub/rate_available
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RO) Supported range for the scrub rate by the scrubber.
> +		The scrub rate represents in hours.
> +
> +What:		/sys/class/ras/rasX/scrub/rate
> +Date:		March 2024
> +KernelVersion:	6.9
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RW) The scrub rate specified and it must be with in the
> +		supported range by the scrubber.
> +		The scrub rate represents in hours.
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..181701479564 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -46,4 +46,11 @@ config RAS_FMPM
>  	  Memory will be retired during boot time and run time depending on
>  	  platform-specific policies.
>  
> +config SCRUB
> +	tristate "Memory scrub driver"
> +	help
> +	  This option selects the memory scrub subsystem, supports
> +	  configuring the parameters of underlying scrubbers in the
> +	  system for the DRAM memories.
> +
>  endif
> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> index 11f95d59d397..89bcf0d84355 100644
> --- a/drivers/ras/Makefile
> +++ b/drivers/ras/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_RAS)	+= ras.o
>  obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
>  obj-$(CONFIG_RAS_CEC)	+= cec.o
> +obj-$(CONFIG_SCRUB)	+= memory_scrub.o
>  
>  obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
>  obj-y			+= amd/atl/
> diff --git a/drivers/ras/memory_scrub.c b/drivers/ras/memory_scrub.c
> new file mode 100755
> index 000000000000..7e995380ec3a
> --- /dev/null
> +++ b/drivers/ras/memory_scrub.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Memory scrub subsystem supports configuring the registered
> + * memory scrubbers.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "MEM SCRUB: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/kfifo.h>
> +#include <linux/memory_scrub.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +/* memory scrubber config definitions */
> +#define SCRUB_ID_PREFIX "ras"
> +#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
> +
> +static DEFINE_IDA(scrub_ida);
> +
> +struct scrub_device {
> +	int id;
> +	struct device dev;
> +	const struct scrub_ops *ops;
> +};
> +
> +#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
> +static ssize_t enable_background_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct scrub_device *scrub_dev = to_scrub_device(dev);
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = scrub_dev->ops->set_enabled_bg(dev, enable);
> +	if (ret)
> +		return ret;

It strikes me as somewhat pointless to have such a thin sysfs
implementation whose only job is to call down into a callback to do the
work. Unless there are other consumers of 'struct scrub_ops' outside of
these sysfs files why not just have the low-level drivers register their
corresponding attributes themselves?

Unless the functionality is truly generic just let the low-level driver
be responsible for conforming to the sysfs ABI expectations, and, for
example, each register their own "enable_background" attribute if they
support that semantic.

So scrub_device_register() would grow a 'const struct attribute_group
**groups' argument, or something along those lines.

