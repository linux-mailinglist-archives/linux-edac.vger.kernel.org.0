Return-Path: <linux-edac+bounces-1281-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F6F907F23
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 00:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB928528C
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983114D6F9;
	Thu, 13 Jun 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRwUgnME"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB0137923;
	Thu, 13 Jun 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319557; cv=fail; b=qgS4qqrqV6z/ujAFpHM157wwuCNSsKau+he2t57uRnTcnJ6lFYqZK4RaXrlYSA45bKKYIdUPNU+Spdqzv8rEokigL+RaYd9CmUc0uN0QIj46uSjMmlGTrswNs0Qio6atP3BdacPjWtak3sbAJqdLbru6HNGt+b/zs8ISPJ+HFOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319557; c=relaxed/simple;
	bh=ygOxfbs6RfxKnIqS2m54kMFikQivDyQw1LJw9f0EvBU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ocTGg0GqG7SMtUKiQZLaLoa/OwqDV5zaZYh9pgTfIwArUmFny+5c1hMUZogxQAPDFuACIOE3oQVRGHrekeYRHBaVzW4HgrBQcAPQNCmbf/7hagOjW/gHSzYXGxK4N4AZd3UAArefMe++deh+KfnOf9w9YdNr8pVYoRRzbTsJfy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRwUgnME; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718319556; x=1749855556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygOxfbs6RfxKnIqS2m54kMFikQivDyQw1LJw9f0EvBU=;
  b=NRwUgnMEr6OCtq+0RXJFzJK77q2T+JLhKQo+JkYdxDQkXCYxO6zxm0YO
   TArn/QI2AAuQrS/JpO7+h3ZBIBzep9beexwsHNcbVzmu2BMuUWfzeD7By
   mNwgKypSbuKxXjAAneg9w4+7uufbJJ9AGoUDh1Rp+akChN6/P7yH5tEZ7
   Ff/8N5XhEa15ZP3Er9a3ilFjHGS4kcaLbq/LMY+QMHB127V+lEyPlbqqk
   RW9T+O2iu6Ob8mI5Vs9aQn91VSt/YmkueFjDuV2T2b83COwiNMEzv3nom
   RSZax6357qlJhXRIODkV5S7+moLDIxAVzLyVefQW7/CumIDzDAoYgdSRa
   A==;
X-CSE-ConnectionGUID: zn4noow5SXm9NcbxXojBrQ==
X-CSE-MsgGUID: +cby7M6CSSyiq6sQ2dPxeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25761620"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25761620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 15:59:15 -0700
X-CSE-ConnectionGUID: RWr2uBKzSHut9uTL5Un5hg==
X-CSE-MsgGUID: zqz2Qj4mQsSEaPgUnhSfXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="45264038"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 15:59:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 15:59:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 15:59:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 15:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5uEWKJkeHAax+LO2v1rvjU+QR19LH0CJq+yGoDm8Yrg6UxYDY2rks1KhrnFpwfP4btrgIqsI6Zk6zS6yDi3btDEMyz+bPQecrV/gVW2sm6gchQHzVWXl3dofsxw3U8CGgooeHASaU804aX5BvS3laePweWBb593dPhRDGWrrfWUT4PNYKsYW2dJ1RWrpIEbOArmgfZqImDpJijpyDitxq+xCOIR0nZ6eJqDqBIv6QihKYZbzJCAhFQazI6muV+CPmM2J8r8aHKjQNvGGhRjlFHyyVrklrjgmjR2C6aZIbl8K3n3DhU/uPO9kapPN/AetdAKGwzWdAwZWYnP37fMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unaTORv6P235m0eVXFaGwF9ce47kBYDjaju/jbLYw7A=;
 b=XFR1S8euq577xdhBO6rytfI3ifCVDdUGga6v0qLVjyKSilw0g5q3QmytlZcLbtNRCOaYGyjT8/hMO7PmvblVqw1RWcSb5olmW19iXmNEyFxmhgowySqrOr3t4lwZ2Bppd3PBFZC+zHihMNic4hvjsoSaAJkqSNuJrMhbymDrcacwkQjQlL56rsjOjmcOsI8Mr+hop66HQmsDuDM/EOw3nvtCxgh55nt8GOlMyT6rQyMq1pjMdWg9dcwApaw8QZXenowLhaU/09BysAJIz9npuHF1Qfh188iFlGfQ7PVVCbgVhROD6joyQK5n3RZDSjq8ZdATqpmkX9lKlsg5yaTKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Thu, 13 Jun
 2024 22:59:05 +0000
Received: from SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::c677:a64:79d5:b55b]) by SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::c677:a64:79d5:b55b%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 22:59:05 +0000
Message-ID: <9ce06552-79d9-4bd9-9a3e-2ffd72c4cf4a@intel.com>
Date: Thu, 13 Jun 2024 15:59:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] PCI/AER: Clear UNCOR_STATUS bits that might be
 ANFE
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <linux-pci@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <bhelgaas@google.com>, <helgaas@kernel.org>,
	<mahesh@linux.ibm.com>, <oohall@gmail.com>, <linmiaohe@huawei.com>,
	<shiju.jose@huawei.com>, <adam.c.preble@intel.com>, <lukas@wunner.de>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <erwin.tsaur@intel.com>,
	<dan.j.williams@intel.com>, <feiting.wanyan@intel.com>,
	<yudong.wang@intel.com>, <chao.p.peng@intel.com>,
	<qingshun.wang@linux.intel.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
 <20240509084833.2147767-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
In-Reply-To: <20240509084833.2147767-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To SA1PR11MB8279.namprd11.prod.outlook.com
 (2603:10b6:806:25c::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8279:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: bd529c19-a843-4be3-9a3a-08dc8bfc6c89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmJ6L0JmakhiVXZCQU5Tdmw5cW94Nit6UmZBR2doSjlFMjJTaUVVdXVaNzhI?=
 =?utf-8?B?ZXJ0OXlVUFZyRWhXcWxPRjFqQ2VmWGozN2cwZDBTazJIZ3NFemNYRHlOdlZF?=
 =?utf-8?B?RDhLYTdMUXNDanFVMHA4cW5kalhKN2krZTVIOGV0Uk5mZlVLVUtrV1VHekg5?=
 =?utf-8?B?MEFoUlFPRFNBaVRmVVl0eXZ2YkFJallPQ3ZPMElkd1FIWGcyaVdLd1R6dGIy?=
 =?utf-8?B?eVVLZDBuQVVHNVkwZFNVVTYxeXFEWUFCMGh5UldjWU05aEFhcnZRY2ZLT0JS?=
 =?utf-8?B?R0pQSW9LR1ZWNExweDBGeVN0SW1WRUpCYmlGbDluaXlDZW8ra29lQkI1WGJh?=
 =?utf-8?B?d3ZEV3V4RWFaQmR6a3hiY3gwK1BBNm11Uk42TmxCNjRJa3p0NWdUMnY1YzNj?=
 =?utf-8?B?VVZ0NDlYLzdtVUNRRXdwdFM0dDFLd242aHpDd3VRelJlaHdqZi83Yk5oc1p0?=
 =?utf-8?B?TlVPME1HdWZ2QXAyVVZBVDQxajNJNlI3dk1Dd3dqS3hob1BhWFB3Zm9JOUdW?=
 =?utf-8?B?VmJzdmxDdUlvR1V0cXZWRXpUdzAyKzZETDg5UkFybnRYRmpGMktGd2pzRDlC?=
 =?utf-8?B?NDhZZE45bmd4Z0VkbityWFo2SDlpRmZZTjdEZnQ0M1c0ZFhHSEkvR1BKQjVE?=
 =?utf-8?B?bS9aYkhEbmlkZSs4SnEwM3ZyT3gvMVhRWk15NnI5b3R4UitHakpGNS9KMGZV?=
 =?utf-8?B?b1B5UytLLzcrN3B6Z0pyL3N6K1ZUWnQ0OHlpekJTWlBORXRVSXZTbkNaNzds?=
 =?utf-8?B?NlpoN3lzTmxUMzgweDI1YS96NW5yVVZtSnFzM2Vuc044VURmVVJsYVdrM2lo?=
 =?utf-8?B?Q2tTSHdJelFTdHZoV0NObW1qcUs0NVBadWRRcnRDaG5RMng2RytRNllsb3F6?=
 =?utf-8?B?QXhxOWF1OWZUWGNVVzlGOTV0VW5YMitjUmFzZDZwekR0Vjd1NXlCWDh2eDdL?=
 =?utf-8?B?SWt6MjhJL1IrdVJHbTZCem5XQXZSSm5CYXlNRVptRXc5L3hSOEJXb2lFNHdl?=
 =?utf-8?B?cjdwQmgzdXMxMzdNZlJqTFJ2Vy9MeGxSOU93cEFXNk13djE2cHd6TEdyN0g4?=
 =?utf-8?B?RVhWT25CZXg2Q21ONTR3VityWEFqYnZIS3pEcDRsejVKdjJoSWFaYkc2WVBa?=
 =?utf-8?B?QmIwVVdoTWtINW1VZ2owdEkrMVhMS3g1b2ZIR0xCSG5QZWlBRXI3Tnh1SGlt?=
 =?utf-8?B?TDJPcWhlRUwxSnY1V1hqbkFnVUxzYnd1TlI0eDZxTllJVjNZMFBPcThyME56?=
 =?utf-8?B?YnNCU2ZJRnVXVFhRcWVNNWpuRWlwTklKcmpRZ1BrTVJud2ZJbFRsS2xkTkNt?=
 =?utf-8?B?MDFQUERzZ3JtSG5iVzV6N0tyVjJKdWhEWTBuY0ZUQXo5b04vSzdNeFd0L0tG?=
 =?utf-8?B?bDlnWUU5Uk1rd0EzYmdXMWJ5TXhhOTUxTERWV3ZhdGtTaU10UVNnUkY2NXdz?=
 =?utf-8?B?d240cExXWUZaOXg3a1VRM3RJaHpHQUZWVmdzUktLM250SVQyTzB2bEhONk9m?=
 =?utf-8?B?bUt2Uk1uZ2pGeHJ4b0g3OEs4dlhSRHNRTTBkZ1lGaUhIbTNLN0xxRHRuYS9J?=
 =?utf-8?B?RVVDditkRERZdm9paDY3QmVIdWZHbUhrdHJWZjZHUUx5TDMwQUQyUTU5NWc3?=
 =?utf-8?B?SFlUbERHc2MvZDdibXgzLzBLek1mSXZReVd4cjR6TzBKK1pXWDFYQVdqTEs1?=
 =?utf-8?B?UEZNSnVLdkhZWEhEOG5SbkUxVFVCZGViTzh2QTNoYS81eFR3OWdwOExINmJR?=
 =?utf-8?Q?5OTSiPjEqRchI/XRfvPTsQJdlizIDXoejp78q+P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8279.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUYyVUNTRStpSVY2bzYwVmp3cnZvZ2tmU2dFN01GWm5RbnJVQlcxQ0tOeG5T?=
 =?utf-8?B?Z3FPYmYvNDYrais3RmtMdi9XV1BwK2lLWnM5UjlQRVJHcUZxMGFldTBoZitT?=
 =?utf-8?B?cHdpZVVsVGtQWTdnQnErbHZjTklEQUc1VGYrZGJFZDhnUHI3anRSN1U2VkNY?=
 =?utf-8?B?d0NrWFdtRk0yWFhQUEl4d2ZQWXgxbjRmRHJReE5sRCtzdlRST3JvT0NQVnM3?=
 =?utf-8?B?L3l3Y1hjd2dPMDBrRE85NkloN0hFVzNYbytaOWpWWE9ncGtoalNyaXB4UU5t?=
 =?utf-8?B?c3M0cUF6TVpkbVhDdDEwczZLWFJURnBMdVBLVU15Z2t2THM2RjB6VTQyWE8r?=
 =?utf-8?B?eFhjSisxamhKUFRoczhxYXBCK3NuN0tIc3o4WDlJaVZVZ0xiRStKT2F3US9v?=
 =?utf-8?B?SzBCKzR1MndwaXUvVm94VndrTVNPbEkreGtwaGM3RGNGWnE1eDZTQkloQzVs?=
 =?utf-8?B?dm56NHFyRzZIT2ttUVBGZDhNYjIxamlibDl6K3FJajdhTmRUaFl6dGVGZDdn?=
 =?utf-8?B?RTEzd2IyM1kyZnFOdS9DcDRpcnU0eTJmSkx6WjJBQm1DeVptWWZURjVmRmVq?=
 =?utf-8?B?aUxEMzlHZlowRTFreU8zeVo3V1o5SlVTbkxEcGhtcy9ueU5iK2pYQjhMVllF?=
 =?utf-8?B?U09QWUN0alZnalFuL1BYZ093OFJHVlRIOHU1Tmk3dTVkdWE3ZVFpUmJOMW8z?=
 =?utf-8?B?SnJ1cXhiUVN0Wlhhd2VJdmVoRTN2K2o5VHNQUkZ3UzFJWk8wRVc4VjB2eUhF?=
 =?utf-8?B?VS9Hb1R0dllnUU5GaXhYbFY1d3d2blpjQnVWNDNtYytpWHNSVVFpN3NUUnpU?=
 =?utf-8?B?Uk1WOFNKUFR3cm42ZlZOL2VrQ3JaV2dOTVc5Qlc4Rityd2dqR2JjaWp1QXhp?=
 =?utf-8?B?NHVLZm9ZUXdyTkdlQ3lNS0V0Q2pJdTZBUGhBUXJOa0NlSmtxU2RSbkt1RjUr?=
 =?utf-8?B?NkFuN1p6ZFlLdTNvdW1qMkJjbVFobXM4V3o0ejR2aVRYUHFGZDNLVHl6Wndt?=
 =?utf-8?B?UW5acjFXZjQzZE84RzBUbXczV25KbXJpMDRsZlQ2UklhdWtnU21sdTJjU0tO?=
 =?utf-8?B?ZWo5aTZUREFDTWhPQ2tFVTFVNDMwQUhhUW9oNmFGcXJDanAvSlF4WVNwMEl5?=
 =?utf-8?B?eHdnNURaOVlsWjdWdXVmR0RMdDVDV1libnNBNldyTVhMcXIyelVUbXViVEdn?=
 =?utf-8?B?R01OY1EwQ2NZSFRZbCtQbm5sakZDbi9PeDBHaTB6b1NmWENQeW1WOEZwdHB3?=
 =?utf-8?B?M3REbzcwWGpreTl1eWFvM1o3VTg2RzNuNGM5Q2xNUmxMUGdVNy8xa081dzl5?=
 =?utf-8?B?U3lNTGVtQ01Hei9mZ3g4QTRmeGZZUVF1WWxPOE9vclhNL1dJSFNsdzZxUE10?=
 =?utf-8?B?bmJFQi9IcGZZTzJYbk54N1Z6Rm84Y1Vwci9sbDRPektuZjZNRlBPMHZ4SGMz?=
 =?utf-8?B?S2FTQmF1d0xXYk01WTcyL1VaVERraEJTREZGRnprSTZTalpzU1RmdkJkVDk3?=
 =?utf-8?B?TjBNNmRETndpa0hZbXFTU21qNjNJNS9hUXVDaTNQTUtrb1BCWS9HckxYZThv?=
 =?utf-8?B?K1o1TGphQ3lFSWxjSVU4SkNseFV0eVJuMmVIUUpZUG01ODFFOTFkakRYYmNt?=
 =?utf-8?B?TTBpdnJpMEltV2xqTEg2UVJPeERhUS9wU3dORmFjUkpaUldGd2lZQTdsL0RO?=
 =?utf-8?B?YTRQTmFJSld5bWdpM2R1ekxxZzF4bmFNNVFQckNYQUNGNHNsZ0h2eEdsT2U3?=
 =?utf-8?B?WGlJa3VHNFRpemxzcUxBVDlibFhPWGhQS3FNemc5OWZobVVaWTlUbXdBeHVo?=
 =?utf-8?B?ZEQ4RnpHNHYrOEJQQk5UZDgxT3Zqc09iTXNIWURaR08zdnRxdjNqeDhrb2lO?=
 =?utf-8?B?N1F4WDJwNXV2TGZNYjNyRnl0VndYODl0TWltL0tuL3AxVFRrcUZxWFZVUVhV?=
 =?utf-8?B?MUJvSHdZTUdjNThmRlJJcE5IUWtCUTA5UFFadXFDY2lqZ3ViKzZHNGh6ajVy?=
 =?utf-8?B?VHhzbHpvdDd1UlFtbUJ3Nm52V3FKWHlXcFdsNGZyY3BKK0VGTmduMTRJWjlq?=
 =?utf-8?B?MU1oVXNlKzREeklhR2lJTzhnZzlncXp1OHE2aWRReWR5cmFlc2tzOUhjTXNR?=
 =?utf-8?B?UEpFZmVoNmRDMFd0R3lkTTRpS0lmS3JlTTBRVWRTNkg1VzVtWTNDZTVUMG5a?=
 =?utf-8?B?RFFMUC9iTXdJK0t5SWE5SmpvT0p3NWR0SlVoVng1WVlWWWxKdHpKTyt6cHRv?=
 =?utf-8?Q?DbdtJFtWaH7snVMpPC6y91XItSxO8R6s1P7IOwzn7s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd529c19-a843-4be3-9a3a-08dc8bfc6c89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8279.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 22:59:05.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2ZhrNd+RLXPy04k4D5pS7ErDABemK2XPuEQmn8YYrwIitZZohhEeDO++coTrFRk+tQol1m6ucWguCoBFQk4vdGngyCerbj0666qI9yvU9aE8kU04FLQ51gvnZO6a3ql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com


On 5/9/24 1:48 AM, Zhenzhong Duan wrote:
> When processing an ANFE, ideally both correctable error(CE) status and
> uncorrectable error(UE) status should be cleared. However, there is no
> way to fully identify the UE associated with ANFE. Even worse, Non-Fatal
> Error(NFE) may set the same UE status bit as ANFE. Treating an ANFE as
> NFE will bring some issues, i.e., breaking softwore probing; treating
/s/softwore/software

May be this is already discussed. But can you explain why treating
AFNE as non-fatal error will bring probing issues?
> NFE as ANFE will make us ignoring some UEs which need active recover
/s/ignoring/ignore
> operation. To avoid clearing UEs that are not ANFE by accident, the
> most conservative route is taken here: If any of the NFE Detected bits
> is set in Device Status, do not touch UE status, they should be cleared
> later by the UE handler. Otherwise, a specific set of UEs that may be
> raised as ANFE according to the PCIe specification will be cleared if
> their corresponding severity is Non-Fatal.
>
> For instance, previously when kernel receives an ANFE with Poisoned TLP
> in OS native AER mode, only status of CE will be reported and cleared:
>
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
>
> If the kernel receives a Malformed TLP after that, two UEs will be
> reported, which is unexpected. Malformed TLP Header is lost since
> the previous ANFE gated the TLP header logs:
>
>   PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00041000/00180020
>      [12] TLP                    (First)
>      [18] MalfTLP
>
> Now, for the same scenario, both CE status and related UE status will be
> reported and cleared after ANFE:
>
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
>     Uncorrectable errors that may cause Advisory Non-Fatal:
>      [18] TLP
>
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ed435f09ac27..6a6a3a40569a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1115,9 +1115,14 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  		 * Correctable error does not need software intervention.
>  		 * No need to go through error recovery process.
>  		 */
> -		if (aer)
> +		if (aer) {
>  			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>  					info->status);
> +			if (info->anfe_status)
> +				pci_write_config_dword(dev,
> +						       aer + PCI_ERR_UNCOR_STATUS,
> +						       info->anfe_status);
> +		}

Why split the handling part and storing part into two patches? Why not merge
this part of patch 1/3.

>  		if (pcie_aer_is_native(dev)) {
>  			struct pci_driver *pdrv = dev->driver;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


