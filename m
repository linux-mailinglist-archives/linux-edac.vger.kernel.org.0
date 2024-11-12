Return-Path: <linux-edac+bounces-2502-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160399C4CA9
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 03:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913011F23099
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 02:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC8204F6C;
	Tue, 12 Nov 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrSoXtqq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FF205E31;
	Tue, 12 Nov 2024 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378989; cv=fail; b=LKqEYO0ZYx9P46l4lCbmfjoEYhWCwX0QJca8WNQiBppweXIaADF0b7dK0iB6wZf7pmHNU+d/6EUidKisDltTKrjs6JSABVVTi2mEaxFEO4P/pIO0YspZOQPtsZcLrX2rlErdZBJpB/+2Zk0rxZTL4FVpQFPm+wZZ4M/5DJAosiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378989; c=relaxed/simple;
	bh=D1APpeTRzzSv64oRRd/eWYVbxkZouBp3esZ74oCAi7Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BskQZqMBYT0OYuhXsW1zLZqdnml34PILAAolafYCf7zk5TktZ6oZK+Ek4i0mY5TGvcrlZ6Dbr4KacWY4qH6wWh8JIO1Xm6jGgX7eyXOEEy/sZkaJHvF6gCTdgsLMyfg7VZ/7M8BaaLBFLsuR9md718K4uvdIJhXoSYgDtKylz0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrSoXtqq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731378988; x=1762914988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D1APpeTRzzSv64oRRd/eWYVbxkZouBp3esZ74oCAi7Y=;
  b=BrSoXtqqa3wXyUBl5EqpnwF5J4tAojF7bNrUFx7c32Lej3bTL49nUBB4
   K/+IYI8kfe+i2Qz5447ITlqxBsgwU63D07Rytfq6ar1DrLkT4N023ZvAP
   HLxP1G6zJg+UgVBb3glHLmQ8hRxcVvTv4B5gc+OfvxQ9h7yGjQRQr6uNs
   cdOQNNQWOoSbAc8yAL7J80gAwabvd5iOXkcW3cBK9t9fH5yWXvlaWNNd2
   uAqlgd52CRIaMo0WeMuSnyu3PuS5jcJxlbawOK5NTPqVGSyHegEm+95sS
   B89eZIiPJkAosRL2IY2O0PihB6IcAKW0K1I7TJ5YIufk040Eq92QV7DD4
   g==;
X-CSE-ConnectionGUID: Uiu+Yu0fTFypLVll7826lQ==
X-CSE-MsgGUID: UzPSWjl/RvmGnaYKQL4wHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="56588378"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="56588378"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:36:25 -0800
X-CSE-ConnectionGUID: SVecR2I0RumabZvQodbesg==
X-CSE-MsgGUID: 1HsRYQlQQFiR6zAkpPn0Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="118141060"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 18:36:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 18:36:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 18:36:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:36:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0j0dAnDFlwjYy+GZ6iH8JpMcEJlOCJxWy0066FhK0nS136M2HFsom4sFW6+W7/+Xz0PsMHC3LfUYyWTx7sdFS1nrqTVy9AVzrlsq6BeGGdwpIMPTHE1XMutBULQezj+3YN6NrBOfzx06PeAhVL+IFzpw5f0RZ/6IeReUfBZj2FTgl1D34Fw3KRaJUzNxNiTjTbIJEWOmunWRuPESoz6ApR0ysRshvE+Y6PNX5h/39JUItNvNMPfYfNRypbLGawM2FCb2ePMiClF9CyZ8iRkQsARr5I114oy8M9Kyzbq5x6qoVBySW2q+iPiD8QzOlqpvVDwo0eiYx2/Cnxo+uvrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhSPX5PrO0tUAKnZN1hfrhyVjqGjzMFH6koXZUims+0=;
 b=EjjbsZ7oeoS/9VcxOJU54Ldb2GUcBgm+AowJq1y3uBw/ej+DjLGaBd0rJ7cZX9lykHBYHRwUR4+Wy3J4tWGn5ZYfY0IwH8VezTdpilRiNjLXm48jYIf45/NGrjIze5f4jg+RoT3MVSzu9Ot+uxJ/oxatzXsWnFobmYkWYiMtNIPW5MoQqhMmObCAnMYnA7OIHaW8TXzfA5q+lSm8+QE1fTFUTC7rMUUuqMKWCXqloKnQcj1D/kJmrXiXIM4NYH91H0JFhG0AxxVwOtLSUa0CgDjbFPbeNzEoVw67+Bz/aWiqoOUJ4OZKLxjyoJ/uAFHEG+fOhtun/2vNbSFa7EOyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 12 Nov
 2024 02:36:16 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Tue, 12 Nov 2024
 02:36:16 +0000
Message-ID: <e8ec4bca-6deb-4ecc-a354-28374f9f5441@intel.com>
Date: Mon, 11 Nov 2024 18:36:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] x86/mce: Fix typos
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <tony.luck@intel.com>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <yazen.ghannam@amd.com>, <nik.borisov@suse.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-9-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241111060428.44258-9-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab11392-afac-4bbc-9675-08dd02c2c868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzd2WlAvWEwyS09DV0xraWljRTBrV1BGZ3VyMkpqWURrQkg4QUthR3l3LzFz?=
 =?utf-8?B?dGQ5L3NmWEVUWEMwTE1lM3M1ODJTUmZuQzUzV1BJaDI0RzVGUDNRcXMrVjQ2?=
 =?utf-8?B?Ny9RRkszblRhanExRjJaWFplcjBEY2doL3Jnb2IxZ1dzSkpCQzBOdmdQcWFx?=
 =?utf-8?B?R2Y2WEcyMUxiUTZ2Tks5T1ZUbW1zNnhkOU1wb0RndEpNdXZLS0h6TU9yQ01h?=
 =?utf-8?B?Z1FuM1dmQjVVajRvbVlYUnJXOC9TYlpVc1RBaVMxTXFoYVg5bldqUGtFVE5r?=
 =?utf-8?B?V2krTFpNR29pYzEyak5ENDl6N1lSVWwweXFKQWZ1b29ocTFidlkvelh6a1M3?=
 =?utf-8?B?K0RpRTd2bDVFK1htSXkrYm51aGkwaGxLSFRwQ21lekp5QjAxZllPdkR2ZUhu?=
 =?utf-8?B?ZDhZNmt2ZVJLYXR2Zm1DOFdDWVh6bVYvc0lOZUtxc25nTjloQmVJeU9NU3lO?=
 =?utf-8?B?RGRES2NqNXlzamZwZmVibmdkNTZiWjhoUmNvK21QdmVnQjRybjZTb01FajdS?=
 =?utf-8?B?dm1oWWR5Y0N1TFkyRi95MG9aTUZTYlhtbXVLU3Z5clNVMVU1ZUpFdXhHYTN6?=
 =?utf-8?B?VU5MdlFyZnRTeFhrZ0laVGg1TElFY3N1aVhFcVpEd0RMNC81V2dZR2FlRTJy?=
 =?utf-8?B?cHZWYTYrdTA1YVg1a2pZS21VbnR3MWVJQk5NMXNIbTdGVys5ZmJUam5PSlNm?=
 =?utf-8?B?Tm8zQjR0YXVZQlcxNlp3R3hGTDBDcHFHZkVnYVFiVWl6azMwSmxwZlJ5bDBo?=
 =?utf-8?B?VlkxSFh0S1UrN3daY2JEZTMvVjZweHIxTkJSSHRyajROYnU2ejloaFdmR1dP?=
 =?utf-8?B?SUZ1YkRYQzdzdFBLUVRxK21yeEhERzdVUTQ3ZytsdGVaeTYzUWkvcjVwN0Fx?=
 =?utf-8?B?Z29sMGhiUjVzMGtXV2YzVzBuZGRTdFZBZTkwZDNubEh0RnlYZEhmMURuTHRo?=
 =?utf-8?B?TEZoUWZ2QUVUaXpIYXVNMFZjVWIxSW9RMjN1WkVVR1ZQSGRLS3NMU2MrU1ZO?=
 =?utf-8?B?SnhTSEMyQm8yTnU5cVFVYks0MXRjakttN293RUVEZ2htSXduY0s1dkRVb2FE?=
 =?utf-8?B?c0VvRDJCUlB2WnJEellaa0xzMW43RkxiaEtvKzJPUG5yZzJvY25yYVBMYThx?=
 =?utf-8?B?eGwvTEVDbU9lS1ArSFhIQ2xydHl1akdoZldoRkRMbXRJeGNuMkF4dmlySGts?=
 =?utf-8?B?eFljOWFhVnFvVTNhQ2dKR3VMZVZCVzR6Q0lnVUtZRjJSVFZsYUowR1RGdDdt?=
 =?utf-8?B?Y3ZCcFVsV2Jib2V5bDlheWVpMUZ6akhWRDE5NEF0OVZIaVMzZDdQZ3pZZ2dL?=
 =?utf-8?B?TTBCenZWdmt6aVpvMnNrcGVmSjFVWkgyejR3V1NrV3M1UkNoditvQStObE5w?=
 =?utf-8?B?QS9rYTZCcHZkT2lBSFFnLzJEc2FqTEZ6d0FNRVg2TWRjaGlyOEh5cnJ1Z1g2?=
 =?utf-8?B?NVl3bmRUVFlFRUExUW4xbi9ydWIwQWRtVlR5Qzl2Z1prbFRVVjNuRmlaa0ph?=
 =?utf-8?B?Q0VkcGwrTkowRkQxcjZHR1R4c25WbjREMHJFL0FKWldKbmM0MTNsZ25GUHhV?=
 =?utf-8?B?ODMyK2UvSFhDeExCaityQ01td0l2Uitxenkrb1VlL1FVV3RRVVBQWUdZMENH?=
 =?utf-8?B?d1h4em05cUlPNG5kUzdOTGNTUjhpZ29nSjZDNkN5K2xUMWN1RlBqT0hDTHJY?=
 =?utf-8?B?dEIxYUtOMnFwM1pDTHVqQTlhRTVzOUtPS09OSEQ2bzJLVmR4OXJoS3JCTDl0?=
 =?utf-8?Q?EUAKPBjQN15zPhnGmXCGV6mcljsWlJA/i7XA2Re?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1J5emt6YmphZUc5U3RGQWNHR2JyNFlQREtuNkxhWEo0WEhacDh4RERja0FI?=
 =?utf-8?B?cGxuVGZjZnNpWk9vSVNPSkdiOFpBbVY2Ti9KbTlONXZKVXBHODJkS1U3cDdR?=
 =?utf-8?B?YjVJN2xxOVZvTWZkeWJKa29YaGdUT0Q0TjNOaS9idlQ3eG84Q1ZzdzlJekpW?=
 =?utf-8?B?QTkyRU5EQ0tERXZzMzJHbUY1cjl1WDdYb0wwZy9MYkMrdUpOT21OSWh1cm0z?=
 =?utf-8?B?aGVpUUd3ZktPL3c3MHRzc0swYUdVVnJaR0RhOFpYaTkvaWpRQUxaNm1zQTFS?=
 =?utf-8?B?dlBmSktSZWhFa25xb2dTSGxwcGc0Zkp5bDVoeW43eUM1aEpxcFJZWXlyVG5H?=
 =?utf-8?B?Nm0xamZmNXorYTJrbisxMW1Uay8xOEhjSFlyeFBlSWROSUFFTTREL051QWRD?=
 =?utf-8?B?R1lObUFia3RmaUhHbFM4eVVGZGZhbGpJWWg0VHhpMldqbWcvTUdLRUhSdU5K?=
 =?utf-8?B?K0M0QmU2V01yOU8zZ0NhU1p2dFNWemdNUFJibEpiaXI3cVBxNk5IMVVvM3Y5?=
 =?utf-8?B?bUlNc0xld3grVGNJTFA4L3psNVdvZ1hkdHcwc2o2Y0FaSWRVb2dzWTliYXIx?=
 =?utf-8?B?N1MxOEl1bmlzZDhqb1ovMXc4SU5UVGMwQnErWEZkOTBqWEZuTDF3T1ZEU1Zk?=
 =?utf-8?B?UnZRTnhtekNrbDMzQ0Z3RVlCNE51cW1CSzFsZUVieWs2Ums3b2JmUUlFb01u?=
 =?utf-8?B?aEx0NE5ETzdSTlNnYzlTZG5JM1hBR2hKK2xjdHNUVk9RaHlaQXBud0plUitM?=
 =?utf-8?B?V000N01hNXdYK0FscGphZ05sdjdpaVFXMzRjNWFPR3ZndUJ1Q2RCM0JYeWRr?=
 =?utf-8?B?bHl1ZUV1Zk5sdTJybEdYVHJrUmpRT3lTQ1JBYlcrNjAwZVNFUi9FMmNDVTFS?=
 =?utf-8?B?dVFjTStEcStSS284SDFTV3FheWpFLzdsSWRtbkZseDAvYldOK0ZkendLSFJs?=
 =?utf-8?B?ZG5qcWxLZ3c3NmNjOXZ3aVh3bTZFOVhkQU0xTlA2V1ROSFU5cGF6dHYyRFRL?=
 =?utf-8?B?QnE5cCtSWXFJdnhSSEpPb2R4QmEwblhHWGREMnJwRWhJS0JWRHY5d3d6M1gy?=
 =?utf-8?B?QlJvOURuTStoU0x2NXAxWW9ENFM2ZjVWLzAydXVQVUR6c3YwcysySjhDaDdS?=
 =?utf-8?B?UFN5UmFMNkxieGNHWWluRy9ZNndXajI2a0orNW9lOFdMNnNySC9EZnBUazlj?=
 =?utf-8?B?OC9lbktnTVoyUjkzVlRhUHFweWVtMG5GUDRWVE1jZVpBZCs3VUlULzd5N3Vm?=
 =?utf-8?B?MlNDMndpZUxwUkMxUURLSlFCaFpsYUgxMFJ6K1JsWGFNeVJqZGZuc3h2ZkJK?=
 =?utf-8?B?VWlnTGg3cWFQTE1qcmV5NVFsWlJoRXBQV2hGTWgvV2p4MTdnTzE2azBoSWtt?=
 =?utf-8?B?cEtWSjdTWXg1RUFNQmIwcW00VHJrQ1N5WG4vYUpRYmpFcUlvMnViQ1Z2VTBw?=
 =?utf-8?B?Tm1EdlJOVFZZZmtKOW1rZ0I2SzkvQ0QzanBkaTJrSW1OUitOblp4bzBQb2xx?=
 =?utf-8?B?S0pHTVVkWHNWWGoza1hnVzcwYWF2MlVDeXhZQWF5QjZIb1diMVM0azR0aDBy?=
 =?utf-8?B?MUIvd3VkbE1kWHpRSUlBVXNRZFFXWVpRdWxvcTNBRTRObnRaVkhQUWh2RXdi?=
 =?utf-8?B?eVJjQWlxSXVEM0hQeXcyM1VoNk4vYUxEdzk4dk9ycDlEUFY2dEZyTXJNK0Jn?=
 =?utf-8?B?K3BuUm54MytxTWdrQjhrdDFDUHdIQzE3Y0JQNlZ1VnBWczZhaVRJRVk2RXZG?=
 =?utf-8?B?eU85N0RBNEVCczVGWW8ybWJGZVlKdGdxVlBwUnp2QUFvR3lKZ3pOVWFZUENS?=
 =?utf-8?B?VE9ZTG5aNm1Uc3NmRGZFRWZiZUN5QTlMWnQ1R1BWQmd1cGhVVHFKTU5YY1Nk?=
 =?utf-8?B?eC90N0tNQWpvWFVrVExuSnZoTDZHdjNGdzF1Y0ZGUHBLU0Q2VFZMYVUrZ0x4?=
 =?utf-8?B?OER6Q3JObVZNMDNqZDQ5TDhJT2xGMG5zSm9RdG1hY1ZZMmZxNjlha2M0cDhx?=
 =?utf-8?B?OGpSUXBwWXVITzJYdHA3WHRoOVVUc0pDQ0tTUGRVdzMrM25EU2lsb1lEOWVM?=
 =?utf-8?B?Ky9PYjhwVUpEclVJMWd6cjVDUjl0Vi92cGFKSjVwUm9MQ0lGak5sRE1ITlBn?=
 =?utf-8?Q?vgInj2vc5A9VQMamWOWNaNhPF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab11392-afac-4bbc-9675-08dd02c2c868
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:36:16.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBD7MuKXda0Kg/EDHjLw8Gh07ySQLdcBYlH+FtPG4cuWv1FjsiV5I+xPzxf/O5VtDHqOdGJGwX7RTdcZgxte2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

On 11/10/2024 10:04 PM, Qiuxu Zhuo wrote:
> Fix typos in comments.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

It might have been fine to merge this with patch 6/8. They both touch
the same file and the changes are mostly superficial. Probably consider
it if you do another revision but not needed otherwise.

>  arch/x86/kernel/cpu/mce/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0f0c6e9d9183..6e194ccffc7c 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1144,7 +1144,7 @@ static noinstr int mce_start(int *no_way_out)
>  	} else {
>  		/*
>  		 * Subject: Now start the scanning loop one by one in
> -		 * the original callin order.
> +		 * the original calling order.
>  		 * This way when there are any shared banks it will be
>  		 * only seen by one CPU before cleared, avoiding duplicates.
>  		 */
> @@ -1917,7 +1917,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
>  	/* This should be disabled by the BIOS, but isn't always */
>  	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
>  		/*
> -		 * disable GART TBL walk error reporting, which
> +		 * disable GART TLB walk error reporting, which
>  		 * trips off incorrectly with the IOMMU & 3ware
>  		 * & Cerberus:
>  		 */


