Return-Path: <linux-edac+bounces-2146-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053929A483B
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 22:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846371F221D2
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1520898B;
	Fri, 18 Oct 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpCEG0CU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1D205AD0;
	Fri, 18 Oct 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283820; cv=fail; b=N9vZjJEHMn5H3Cb/m46hPt5jTU2+sfmM7Yb38qCWdRUiaeou7sMcewFpDwNxdtuz+Ok8cQODXsF8k5DWHak4tDeRMQcuJ3NoAzvxn+54SN9hRYqUzhcwcDpvKk1slHLYrM9YDW333wljMcascDnuf62gcMg33R0K3Vs4oGT3DHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283820; c=relaxed/simple;
	bh=WKKI59gleAeRsVVJ0KA0cS/ivQjD8QGIgQVwie1Cug8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ozMVGCfru6IJA5JmsGZqjU/WD0ElUk3ITxs7zD72/5KnHDCV8hs9AfLeuQJCIVtP3+oZECUo6vgzEXpqE05HZbjVccDrFesWZQSLOa2eyuGWceNfzmHpcK0aQ1CX+I/KhTgc0fW3RCbbCn+zZ50SJmqRranj6ZE1/Rn8v92EiAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpCEG0CU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729283818; x=1760819818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WKKI59gleAeRsVVJ0KA0cS/ivQjD8QGIgQVwie1Cug8=;
  b=SpCEG0CUiE2eL1d+pXUqzWeZ59Xj8vK78XKaXa/YV04NIzyBa2WN7jnh
   iJRylHfIQH/j+7/GRPBoNS+NGHkvEs8llsp3W+xGi3l6TGmpjbXWiL+9q
   xu4FVNTEh55HZHlimxEF7D5OamXOZe38arSpZVBjDnlotbcGzqoc+hCVb
   SRTdGaLmWnS/LqHo/C/Re7NAnQFvM8zp3yEhyH67dFhd3DR0rN4SU+TAb
   NJdP/U+5c7Qh6HeY1bA+fHpXVeNqYijIvjebj/FSVscsxPWK7kBRpOkAJ
   pilcKIneDbGLp4K5TKHobwbksAf3a+hBZsY22/3jALoMN3G/mKtjLaXLC
   w==;
X-CSE-ConnectionGUID: pbdP6bI9SwifQN83kxBwDg==
X-CSE-MsgGUID: 247VzF/WQGOqlmhrZNcoOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32514921"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32514921"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:36:58 -0700
X-CSE-ConnectionGUID: rcHCtLQoQLGc2yDOi6dLtA==
X-CSE-MsgGUID: ZkWm3k5rQAGyFysYAWVgNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109795930"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 13:36:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:36:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 13:36:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh2oOIRxReTorQg2yuv2DTAyP3p19mTlgcFHpfu1Tl7YvJRdydoz4IlyVLamx1e/9utDSIroJYNgxH3QCd0qLNKJET6AFkyHiiWaFwQsitjNTEthQZIXW7RiGiA+Tw5aS/APojiED4Ks5F/bxXt3NioXGcvN+csaTkGuP+G+2I6FMDwY2uEBmYUJQWW4GRWvTS12QImCJDgG/GckHKK4vHm4gDaVjdhLC+1nvdfKWw1jZwJNPdjlk1cxzmJQRNfUGgFmWQoGJpkB0fdptvSZ49OgQetsqfNmxBMzWFiwrlSfHAmGqfibLMHgfSUW/bMezVdYyHXfZEbmkHM/++46+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Kb06P1N1WAHq2XnN8XKbY4IKJ8pnJSZ3QQbhuMSZc=;
 b=mW2K6QPDiuADVHHuq+t5vuTSEzvCDGtbcYGR3zyg90CRZT3XyZAi15HkW/iivgotvNL1NsnPuU8mUc6YZF5qTZ5nlgKceJkjJ0vsbM+CYPyznfyzLMGsdDeRK/lXtF3DWGdx76pic0QLvycy8sERPVptfLB9cZfudeuXvs8yZfVTDrWth3UtRMpKSFciU81CyLGcGivMW0MOuhU0ANEQoZCVL+ziahPExwc9WB2G7MZ/s7Xzt4Tyn2euaxrYPeC5cfZuAsnI/D9B6VBvfgx/hDj7PnMGb5M1byGxKxl/PGMP96mUmZ13q311yH/u3yK8N5+xoQ6JbpcyFX1mR99Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 20:36:54 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 20:36:53 +0000
Message-ID: <7af345be-8e8b-4c36-b105-67cdb24823e9@intel.com>
Date: Fri, 18 Oct 2024 13:36:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] x86/mce: Fix typos in comments
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-11-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-11-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2f3a01-392e-4a24-1724-08dcefb499b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU5ZYVFCVGxWSGYzMmlHbWdST0s1UUc2Y3gxNGZFMDVsZGp3M1I5U2J6YmY5?=
 =?utf-8?B?ZmFxTHpicktHTGdhR2hCNU9Td2NWbU55STF5YXo0NC9zYTg0R1Qvc3UzWWRQ?=
 =?utf-8?B?a3hIMkhSTVVQdndnUlYrT0tXOCsvd053aDFNejdQM0xnVEdCc2s5dGhnQUNy?=
 =?utf-8?B?RkxvVFdnR2FYZUs2eVlPeTR3OEk3Zm1SRHpTcVkzWFBScUs1bnF3NEhIdjlT?=
 =?utf-8?B?S2dJa1hpemx4SEZwbURkRnpkWGVFZ1U4OTBFekg0RUtLblpkak5KbUFmbS9B?=
 =?utf-8?B?RzkwTnZpWXk1OVQzMG96bWZhRjVOa3VHSEZEUjIxQ0lkMVBMSU1oMWdGaUI0?=
 =?utf-8?B?VWtlbXN6bUp4OHl1cURjNEFUUUtVWEF5Z2V5WlgvTkRXQ3JSUjFXdDhDOTVj?=
 =?utf-8?B?ZXBRQm9KalBYdjBoRUlpZ0FlTExHbmZqTmc4aHA4UkJtQnBMRWJJWnpaM2hE?=
 =?utf-8?B?dXNsTjdlTmlRbm8xMityeHI2bUpJWGFwdDRwMU9PdHQvZExBdlM2WnBkcHE1?=
 =?utf-8?B?alBoUzBIeVJCUUwyR0hraXZ0TXhMWjlqZG56QllIL0pTbzJ6WHptSFRseWlP?=
 =?utf-8?B?MnJoUzIxUFVWNmhTSDdaT1ZPUUROeU5kU21tb1V5SlN1Q0xoYVJhZFhlajk3?=
 =?utf-8?B?cCtnbkRQWG5xOFR3c21uQS9TL0NvNC9ESDFkMXh4WG9HN2NsZXBGQUM2QTZl?=
 =?utf-8?B?eU9UanE4K1JXNlRtUUh3SC9DQXVkemJzejdScTdnZlVnUGN4ZFlBcDJYQUYr?=
 =?utf-8?B?cXdBaHQwQitwVXUyT0FYRkRXQlRjazhmb3l4b01IRkJjN2k4WGNqcXEwd2h1?=
 =?utf-8?B?aGxUU2dYQlJaUDhETjRFM3N3Z3Z1MUlPdEpEczNsbWJ1MW5JWGY0VXBnT1FF?=
 =?utf-8?B?N3hDS1ZLMi9LZnJTR1c0U2hyazBEbU9yYmxXTGY1Q1pJdDk4ZWRNWWRxY1J2?=
 =?utf-8?B?VGt3UGxQNnY2VGowV0FuV3REdkQ1T1l1QmpMVGRUL0g2ZjFaYlZGSVN6bEtD?=
 =?utf-8?B?MWxPa1BGYVROK1poREREait4bVVvTmkva1haRWtjTkhaMHdET3JZOFhqT1lv?=
 =?utf-8?B?NWFLL01WZ0VJbzl0UWJXSlhRaExiZEtCN2EyZUZ0emQ0NzhlbmdCekR4NnZ6?=
 =?utf-8?B?Z3BWUDc1OStkM3prdUc2bDgrcVdoa0IwU3RyRmwvd3Roa1psUHErVnNlODZO?=
 =?utf-8?B?Q2RudGhiMTV5Q3A2dmM5TFJWRTBMUVIyTGpJNGxVSTg0VGJkcGhwdWcrTmp3?=
 =?utf-8?B?SGR6dENPcWNVOUhpVWppcnFzZVltd01TSTFHVXNLT1NqV3RmR21EQW9HbGFP?=
 =?utf-8?B?UjZXOHA3bE1vdG9vK01RdEIrdHJIeS9YSFpLNU01NmltTXNBVndvN3R4eEFK?=
 =?utf-8?B?V1BCMXU0Z3F0SVp5Zy9LVzFmN3NMU01IamQzM2JPc3hxaDNSTnBGRTBIeXFX?=
 =?utf-8?B?aHlobTg0bG1UVWZ2Y2hQWU5NTXYvdDZ6WlJmMzdZOTMxdllxeEE0ZElYZmxK?=
 =?utf-8?B?LzFmUElNVk1ua0RSZWQ4ckp0VG90VDBUVjdjeS92OWhxTENVL2c1VWJQK1Ni?=
 =?utf-8?B?REV6S3pidEYyUTZoWXhHRHh1Y0tRUzRFMGkxclRJZTFzODViQitRTmRYSERk?=
 =?utf-8?B?OWpMTllNOVByby93M2RSMDVtZFF1QlpsME1iQnhnYlQzNzBjeThPdVJoOEpn?=
 =?utf-8?B?R0cvK0tGZUlqR3Q5WlRLMjBxZjJRMlhDTVpLWktYY2p0YWlFY2dRUytLMy9k?=
 =?utf-8?Q?XgPYynoyh81dTX3gr66yBG1GxZKIckz6X/J5obY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXQwRzV0SVJSNkpNRnlIRW1KK3hTdmhhZCtmQkJVcCs1ZmpjZnpMTG5aWUVv?=
 =?utf-8?B?ajF5RkJJakFjTmRMbFJ5SHV0UkpDdlJwdG5lVmtINVNPYlZYNVhoSExIQ3E2?=
 =?utf-8?B?a1M4a1Z3ZG9QRW9xMFRid3NtMS9XTlR0UUM0MUFCZWF2cWkwT1FybkQyaTlz?=
 =?utf-8?B?SzdLUHhYcHNOYTJqaXJkMGZrYkdyMTZsK2xmVG9UNExLVmRNSzJQM21BcG9U?=
 =?utf-8?B?Vmdodk9lQTRhMEFPMjk1eUEvdVlKZGlDYjd5bHYvWHRTbHIzdStvS3loMHBh?=
 =?utf-8?B?Ui9IZk5SbG5kUElYSGQxRHFRY09vaTlsMHZJTXkramJmQTk0QW91MFF3eXJO?=
 =?utf-8?B?QVN4L0NZYnNFTE5GK1BSNDJPRlM1Mk9DSFdtZXRJRlR5Y1RLVjUzYSt4dWls?=
 =?utf-8?B?WUxUbE50TEdFalIvVTBWcXpGdUVUeVlwSXhTOVhVeENaNFR0RmpUOTZBYy9W?=
 =?utf-8?B?MUp1UXY2OVRUOVlqVHZuckE4eXF0emVKYTVJWmJCNjArbDdpR09rbmFDUW9x?=
 =?utf-8?B?SFh6cGJqbm5pUlJzb29VYnZTdStFKzRiMk8yRGJjSFhob2YzNWJYZlRxSkxa?=
 =?utf-8?B?Q1dwWUN6T2tBM0hYakRCaFpqVmhveW1mRmp3R28xR0pNWEZHSzNsNGlUQ0V0?=
 =?utf-8?B?c3FiRkdSUSsrejN4d0RpcUoyZ2Jpc2gvVHVlUFFMa2ZSeEdlUCs4bXdQUVA5?=
 =?utf-8?B?TGNONmlXcWxGNVJuaU5zaFFWSTdsRTFYL3FFS0cwek5FUmRzTWZ1N1V6UjU4?=
 =?utf-8?B?V01IRk96K3F4NHJUQk1JUHdxRmI3VEs0N05Qdmg5VElMUmVIeUJtTldhR2V3?=
 =?utf-8?B?cGVLZWxmclpEWEtrTjVaL2pXVnlwMEw2TDVWRjU2ZEdlTm95WG4xc0Z4ZENr?=
 =?utf-8?B?N1hIeDBaak9LckI4YllMS1RpemRRRmlXTXFoei9qR1pyL1IrQlNZRjY0Mkhq?=
 =?utf-8?B?aGFOdlJNa3MvdnlLdzBGQUJMSDJFczFxZ3NYVHdaaUE2aGlZcUFwTjBleXhH?=
 =?utf-8?B?MENyTHl4MldWbEpxL0tLYVByNVZSRDk0NHBLdXJBZW9Td0tyS3hjSEgwT25M?=
 =?utf-8?B?V3BjTjB6dXkycFQweHo2WEJ6WG5ucGJGTFY3bUtST1FrQUZ6ZU9OQUJTNWw2?=
 =?utf-8?B?ZWpnanAwVzd1cHZWVEc4d3dhc0NSVUh5RS9kU0FyREV0RWFVL05kOHlpNWY1?=
 =?utf-8?B?QVBaM0krUXBrc3U0ZVR2ZXNTcThpQ2lKd3VGR1VJMjhGZVhRRHQrL28rNldL?=
 =?utf-8?B?YnZxT3pMZXY0cENUQ2ZqTm5UNnRvUW9zZzU3Wi9Hc0ZvZ0RFWURaZks3bitq?=
 =?utf-8?B?OFBlRkgvWWVmQkdGR3QzK09MbHRyNzh1WFNGaHFXME9lcHVBSXZNUitsNFhH?=
 =?utf-8?B?RElFYnY1d2VETVhaR0p0d3lyZGdYc1dLZlQzbUNHakdvNm9BZ0cwWDF6Y2E4?=
 =?utf-8?B?N3Q0eW5LVFVrYStsRWo1ZVd6a3hDNTlQYmVJRmdsKzByM1RPQkg3NGpzMFRu?=
 =?utf-8?B?Y0tOalZkWWZUc3JQS1F0cSt6ODMwUlZKWDF2Y3hsVmlkL0o5T1haQWtGaXRj?=
 =?utf-8?B?ZzNGVEhmSnVFdytGak80OXZpR0J1NDI4bldVWUp5eGpmKzF4cUJKdnE3M1NQ?=
 =?utf-8?B?U1ovK1cxSDNoVWR4Z3c2T3kvQlZTRkF2YzJUZ1d6YktPQkpXbmpkbEdGWDBZ?=
 =?utf-8?B?azFFWTk5UjltMVIxdGdKeFljd2lTbkVIelpDcFdFWFlWakJkMnd1ME9ndndj?=
 =?utf-8?B?U3kvSVpDc3FOMjBVWStzV3lLSmxpOXZsVE5YbWIzckhSTzAwYm16TER4ZHZY?=
 =?utf-8?B?SU5vWmltWlJMYm9sSVhSd1YydmpFdG5zSGp1blpGdytmOW9oRHRDVkhoakc4?=
 =?utf-8?B?T1Rxc3JIcnpMbVgxbDdncVhNWUh4a0k2T1BCNGNmZFlUcmx0ODVUVGNnY2dZ?=
 =?utf-8?B?cDVqQkk1WWphWDB3NVY2WlBiZ3hvbVFWQk5IQW5kZ0tsTnhIQmQzVmNGcExt?=
 =?utf-8?B?ZjVYWGFCTkl1ckZzZ09NR1NHLzdTV3crWDloVkZZTDVmR0MzbHZpK3lQT01s?=
 =?utf-8?B?TG9uNUFCckE3MUVLNkhpVWJsaEM3NHFqNVFBVmlpaEU1YmJ0M0FyMk4wMDdp?=
 =?utf-8?Q?76YsP1QNToSqhiWbWnkNk+Gkr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2f3a01-392e-4a24-1724-08dcefb499b3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:36:53.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItSeQn3XrWBq1WoY9QafE9pu60DQc5rHBVEupGhMYKO2ce2Ym/R3azX7iSEva0In3/Ma2rb9Q7nvKG5ocy+WTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com

On 10/16/2024 5:30 AM, Qiuxu Zhuo wrote:
> Fix the following typos in comments:
> 
>   s/callin/calling/
>   s/TBL/TLB/
> 

Same as before. The exact change with details doesn't need to be listed
out again in the commit message. It can easily be observed from the diff.

> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 844a6f8d6f39..19e6730e7c22 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1118,7 +1118,7 @@ static noinstr int mce_start(int *no_way_out)
>  	} else {
>  		/*
>  		 * Subject: Now start the scanning loop one by one in
> -		 * the original callin order.
> +		 * the original calling order.
>  		 * This way when there are any shared banks it will be
>  		 * only seen by one CPU before cleared, avoiding duplicates.
>  		 */
> @@ -1892,7 +1892,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  	case X86_VENDOR_AMD:
>  		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
>  			/*
> -			 * disable GART TBL walk error reporting, which
> +			 * disable GART TLB walk error reporting, which
>  			 * trips off incorrectly with the IOMMU & 3ware
>  			 * & Cerberus:
>  			 */


