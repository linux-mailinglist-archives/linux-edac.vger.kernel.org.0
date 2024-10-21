Return-Path: <linux-edac+bounces-2168-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFA9A7243
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81514B21127
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C560A1F9428;
	Mon, 21 Oct 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSSow4MI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0911F1307;
	Mon, 21 Oct 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535174; cv=fail; b=Br9IT58iXa23H2A4xh8WHjsBWZ41PbwYuaaHQk3MLwZIFa5ojFoWKbhhAlodY+6NoQaTSdoekeJKj160I+uiYV1HSRxphPZR/GzE4QayCufQB7FVVrh/YStNSAaYeuK2BA8kYy4sxxPou+lrIp8fWMmtIirj7sZZzQlAUX45mcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535174; c=relaxed/simple;
	bh=P7BpkB7lwsdp5KqrRCBbcVJ7TGehI5znWvyUj7olGxo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SucsNXhKaxcwZghZ73Xfw9GYWPOInHZv+tKTshckayqkugDBps126TZ/Pv1WGtVZkUNcCBW/P0y1bEBlt4tLBB0AsJoAFs5ljSSBJvopBAETYVkKigYm7TeDOqiVoJq3gxpdxMH5uQqj3b8s2nASlxYyr9E5V35rskziLdCpqRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSSow4MI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729535173; x=1761071173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P7BpkB7lwsdp5KqrRCBbcVJ7TGehI5znWvyUj7olGxo=;
  b=kSSow4MITVFh7Vu/XyitSVtSbRyOonnwGEVIUVFyMFzlYZz6KLTnWDLL
   cWAZqhQtwOaGWAhNDQGebl9oC6U+0OIrle0PAm0leOXwwN+cewNuX30Tu
   ecxXrxUs28nRkHQVsUfIDzCG2AGg01F0EIUbA+AbShgcmeKt+p1TThUbm
   BzOrc2wXua/61vK6bqvitcvkRtPJrI4ceEY961QuxkD4YYH3lSO4djjb7
   Tjmj+QxnTkqWGDHbIL5tknBPVwUOlFdLbwwBzL4y0T9nB61ITREQTbuxX
   8Za8spv4R57+MW8DUs466wAWDVJs33vwOkc1RixGGFppMQE5axv54o1cJ
   A==;
X-CSE-ConnectionGUID: IV5u3keJTry58Mdm4YTWBw==
X-CSE-MsgGUID: gzkX6ohZRVmsk39z+MJl5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="32842869"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="32842869"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 11:26:12 -0700
X-CSE-ConnectionGUID: ocQMjIQ7SbubtreyoCxRcw==
X-CSE-MsgGUID: /Dd69RrAT06R/h/o4QdzIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84425825"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 11:26:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 11:26:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 11:26:11 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 11:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBleDm/78Ab8A9w+szW4PoSRBlYswrPPbFwUwuvkNS+yuRuS3mDTejcaAVhtuvQVMAjpVciJaWMX4Q4y1LI2/LHqoSVm8QhYcZo5eTwqVTzFOnCqCobpHKhPiiW2+xmmrIJ7u0K7Sl6jFDtvW2cETnlXkIT/yDZo3DOM9tNvRCS7AWBlMs6FxL7+hb1Hf5/DNQthlqSiEdXG1X5kTy4Il8dSGckm+zmzAgG7b+aMLf+4geYdOSF18q5QWvTrNeZAfUMifk8JQqtgiBkz4WWkgxCJaaSpDBuHWWRr6VwgvTjSvTIe1ZB4dSi/gQnNiGb3/THKjWooOYHx1MUiVyupMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifeuNXpDnevlfQc0DoREjYV+/bkuewxZca1zMWHp/tk=;
 b=wlfjhuDJAMR99swO2g2nQKB1Q6AIG0ZO83Eh+uJ7gozw1W3SNOsVlDBeG5wbPXsUsR/zbUSujwo4HBxcqd87ro0sh/lMhKlH0ylsg4NpLlbojWwhm6WOHiis2VAywjJ/2zFvQ7NKUulFTofDn9yOSEoEY5x/2EpgHMdPXlAhpYqC7kxnsz1r0M1mHhmdOikGYHBtmCffxUeawmlrTTz0T2110voR3zusIKlbyNYvB+/pafSfrpbNu8b/nhhPKCcXRTolMYeXqNWoc9J67WggnIX98mMaVqTXk7zsK2A4mjsjfKydSaVHURQgmEse1OKEvJTS8Q9nqMr1bEHr9R4+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:26:03 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Mon, 21 Oct 2024
 18:26:03 +0000
Message-ID: <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
Date: Mon, 21 Oct 2024 11:26:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: "Luck, Tony" <tony.luck@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3f03b8-26b3-4979-4d6c-08dcf1fdd1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEUzeHl4WDMwVHh6ZFdzWk84Z3Nzemo0bHBJd3pTeDZZR3ByVnVSRG83RHAr?=
 =?utf-8?B?UHpPNzdwMUpjTFBCSS8yWEtBaEhybFJzNFpFMXZobFgvUDNRL01MMUxMU1Av?=
 =?utf-8?B?dkZGR3hQMkgrbzdtV1FQU0NEZVVncEpZYTBGNGdFdmY0Z3ZEYkY1ZlUxejdy?=
 =?utf-8?B?TDJxNHo4QnAyWHdDZ2N1SnZnM3ljSzJOdnBaZTdJMkV2aTI5cjVDbS95Z09l?=
 =?utf-8?B?MUwzN1lweXd2bjJSb0g3d2lZVCtGSWlodDZaNWRXNFlpWFpHMnMwSHd6NFU4?=
 =?utf-8?B?c2IwQllQOGNjdk5GUWUwUGx4Mklndnltd3NuUURWUW9mSzdYV1BxYSt4MXkz?=
 =?utf-8?B?YURTYzBxYWx3cXVwUHlUcC9BRVRzYTBhc0lsZmNGbTFUSVA0YlVGbGZpU0k3?=
 =?utf-8?B?Y3l5bThFOGt0TWFzRDRMT1lwemVIbTFmQ3kxd3p2OFphREtJSy9id2VwNVF3?=
 =?utf-8?B?TUthME52MnBPWVk0UFE0WGJlNzZlQW1YeEFlTjRrTEd2akkwZGtoM3hBUzh0?=
 =?utf-8?B?MVN3czFBSEVWb1RaTzc4UjNlMy9DMCt3ODdNQTRuQWQ4ZVVkaGEzaWJLcSsx?=
 =?utf-8?B?Qyt5WVZwb2pCVVBOajdRbjBtTDVuNEpPcmkvRXNaL2JPcFhXUjFPTG5leW9r?=
 =?utf-8?B?VDRXQi9Wa21VSHVLRHRWZWQ4Sjl1OWlycndSZ3pXVTY2NEwvMXdXbU9Ob2pj?=
 =?utf-8?B?Mzh6TC9DUzc5MGEvb0gwUDFSbVhsb3RoVUdDcEs4QWdVN1JkNndzMVk2N2ox?=
 =?utf-8?B?amZyZUc3SCtLcnRwUE5hYXNCc2h1RWYyNi92aDJXUm03TU5nUTBOYmh3V0NO?=
 =?utf-8?B?Z3J1RzB4V0FTSFF0b0hPc0JPeWhaVytiSlBzMnJOeTRvWG93NC9IcXNXTFQy?=
 =?utf-8?B?T2FHYWVBdUJNbnowQk9pNE5jUmhVLzI2VXlPWjFMd3N0Zm5WSkFRRkF0Tmda?=
 =?utf-8?B?ODZqSWtMeTBialdRTDZiQ1QvNWFuZ0JWbEEvbmw0bzR5Tnloc3EvOThxY1lt?=
 =?utf-8?B?OG9jS0FWaFIveU9rMmFTb3M0OG1MWEJGWHNPUmROVURsNXdkbW5RVjNPU0RF?=
 =?utf-8?B?NUgvbXRqUklnOUtUMWtwYU5tL20xVWNjZ2xvR0d6ZWpGV1huRlpFNExHVVRE?=
 =?utf-8?B?cW01VUVGeE5VWDdDMVRNY1BNWFl5aHhOZzcxbGJCNHBWdTNOSyt3dGdoZ3hX?=
 =?utf-8?B?aUpYT05KSzhxTUIvdzEyY2l1WHE5YmtrT2FMZGZUaFVsSUdJajZwa3cyMERG?=
 =?utf-8?B?amlERjRZRkdzOGZDVTc5WTZsOTlmTi9HT2dkTkV3b0NyQk8xZktxMk9lTExU?=
 =?utf-8?B?LzRhYStpV2hkeUI1aTZmTjFROW4yNU5CL2ZYdDkvdHErbTZsenBXMkZtRWVZ?=
 =?utf-8?B?SXRtR1NObFJmaldTdHRZdUJYc2xvU3V6V3NtaG1Ocis2eWtCTWIvQXQyWG1M?=
 =?utf-8?B?Yy8vdEVGT2p2Wk03dlpIMVViMWZQbGQ3aWZ3Ukw5WUF0TlhpclBQa2RNNW5y?=
 =?utf-8?B?UkpkcVZIWks1V1RzWThzUVpNNElBeW5qMkxDeGM1a3p3M2l5Q2JNVnBBekF5?=
 =?utf-8?B?bmo0SUc0RzNNaHBybjBqRVVnYmY0RVJ2bURQY2VYem9jRHg4aHpBUENnK2F6?=
 =?utf-8?B?aWo2WjNScDM3SEgwWTVHQlNxMGczTHNmcFllSldnWnR2OGpTZi9YSmZzMFZW?=
 =?utf-8?B?WGJWTW4zbU84NFBzK1hsTnlyMGZ2YytrSVBXeVFCUE1Bam0rR2pudWhDZXNj?=
 =?utf-8?Q?tGcKscmM+PdjKLq3d5VqSvcuyslJkzuM+Z8pZRe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhxQy9iZ3k4dHBYTmgzSDdHNkY4WFRCNFRManhja1FvZ0w2LzRrdDdrM2t3?=
 =?utf-8?B?L01NMkVmMEFESFA0SXpCYjBPNmNtemMxN3NqVlZwaVRXYm9yZ2YzYnVSOUZG?=
 =?utf-8?B?bEZpWjFQSnJsdVJPQ2FLdVM5NDFUUlVoZ29hTkY2ODBTVzJhUndGZ1p0UDNV?=
 =?utf-8?B?NytCdXZYVmthak91NG1XaXpBRmdqeWp3dUxDSUd1UWlMcDI1NHpzWmlJWXBO?=
 =?utf-8?B?WDFVZTZNbjdVeFl6eW9Ud1U4K0VzaUZheUtwditEV1BmR3VDR3pCcU9vU0xX?=
 =?utf-8?B?a24ySWh4OGNkcGVjM2ltUWo5LzgwT1VkeFc5U0dBNHl3YU44eWVZdld1Rk9G?=
 =?utf-8?B?QVJPMXZDS1lWOE1vek1jRTFRZTdrMkFQaXBnSll5b2xJVFBsYWFmQlNWU0Jp?=
 =?utf-8?B?TDFwU3N5V0J0M0JNdWlaQWQvK0NvNTczZDluaWkzeGJLeUNtZTc4Vzg2TEUx?=
 =?utf-8?B?SUQxTDVxT0FsdHRVemNITVRDMDFyV3NmU3Q5MllDcDhxeENRMXJiV0c4NnFI?=
 =?utf-8?B?ejVMNjJKdXZFRlZYaVlmRzM5QU5vaDViQVQ3SWNiQmlJUmwvVW94S3pYS2x1?=
 =?utf-8?B?YVRSaUdNeGNCR2doWVU4WW1DTVc2YkNJMG9GclMrSGdmcVZUWm9JUFRQMGYw?=
 =?utf-8?B?TWdHVForcXd4WlBMeHk0Z0QxMlg1TkhXRUFlTVdxUENtRWRrZExwSnZQM2ZW?=
 =?utf-8?B?NVZGbGNCekVvWkxHbVdES3c3UzlDbnM5YlhHLzlqdHB2VFF3Z2tiRXJlaFZr?=
 =?utf-8?B?Yk5SNXdVamQyY01mUXk1R3g3OTlJbkVWRzM0VjErMEorMG00RlZkb0JGNk02?=
 =?utf-8?B?M3JCQkdhSmw3RzJvYmN1MlVVNWFYSTlCY05kcHArOG1lNEpKZVJEaGxUQnB4?=
 =?utf-8?B?bFZKcER6TVBnRy8wcXhsZVZ1T3Zma0hOYmkyYWlHeHBHV2JsUSt1dml5RVlN?=
 =?utf-8?B?dy9HYklTWkI5ZE5NQ1VqY2dyRFVzZUdCUTZ3S3B0SVFVV2lIaWZoSUppS0Nz?=
 =?utf-8?B?RUlLVnpwTEVKcXk4VG9rWVJCUytJT05EemF1T1F6SGh2cDYrMnNWMGdWc05G?=
 =?utf-8?B?RVdJNXBoeWpRMDVCdGRNQ09xRGx3M084YlZPK2dzYmVmdTJac2dGcnNzdndu?=
 =?utf-8?B?cHJ2VlBxM2RQaXdOV09qL054N0YvdWRXaDVRdmdYV3hZRUxwczlKV3Npa1lI?=
 =?utf-8?B?TW1rbXVPZzFXeUt0UWVnNSswVWYrYW1QQ1BPRHY2eWR0SlZwcUl1MXA1R0lN?=
 =?utf-8?B?eHVnQ01mbjRRUGQ3cTFncElmTDNvQXFUaFlzcU1NcHpXOVFBQ2JlN24zZWhv?=
 =?utf-8?B?aEY5MmNzR0NzNDJoeW9DNGFIS2QvQVIwTTM5VktON0RmTVprZWZ6V2s2bnJk?=
 =?utf-8?B?VlIycXpNYjl3RTNzczNITklBcTc2MVI4MytJTlRNTU81eWpxY3N6NmtobEk2?=
 =?utf-8?B?WTAzZ0FkejlQWE9KSDMvUkN4c2huWm9JVkNNMGJnR0plTG9lWEo1WnY1SWF2?=
 =?utf-8?B?VFVjcGV1elp0djhpWDNxUHJvZ3k1TFIrNHdUVkZUMi94bVFXTVRpcUNGYi9i?=
 =?utf-8?B?MVBCbHEyVW5VV0Z1Mko1TmxvYnJDRGZmOG5MeHhGNVNkT3lLa3loTDdpUnVn?=
 =?utf-8?B?Q1JWL3U1NGxrbTBBVmNFbWpKQVNIdHVzeG5DZW81MkdXeTBmSGtBa3lMVDE1?=
 =?utf-8?B?dUh4OGl2d240K0x4aE5QcjJMMU1Cbkg1WksyRHJHcitra1c2eE45ZmZKa1pN?=
 =?utf-8?B?S0NrYnJkQmxNZ2Z2VkhoeTNkYnFlOHJIVEU0eWRhNURyRnRUNUx0eC9UYlo2?=
 =?utf-8?B?L2FZb1hDR3ZBbFQ2b2QzYW5OdXpjMDk4cm5oNzV3eFdQNUhWL3FLZmxSWmU2?=
 =?utf-8?B?ZXB3VTBqam9XQ2txdFgwVW1FWkU1Y3V2K0pPbFNqeGo0azNCaFlGRzdKNjRT?=
 =?utf-8?B?NDc3VmFLM3RJZ0lsWk92c2tHeksvamszY3pjYldJbnROTmczU3NCUHFDaVZZ?=
 =?utf-8?B?VUtvNWxuOTQydkgrQ0I5eWFvMzJ5TFBJVXR5Y243cXFOLzhvQklsa1Rad2VL?=
 =?utf-8?B?REN3UWVxN1ZRWk5jK3dLbG5TUEFQS0c0TWVBcjF0OGVXTjFHLzA5eFlNL1dr?=
 =?utf-8?Q?mDsdnPzM6I/JcfA6TNbrimxiZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3f03b8-26b3-4979-4d6c-08dcf1fdd1c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:26:02.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSCUyqHT9ojWEn7Y7nWA3LXwlQvP+V2ce+4V7oVgdvgaFXlJ4+WQNXvws4acRbhKpvLDy0Yql95bv9btLWmRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com

On 10/21/2024 10:51 AM, Luck, Tony wrote:
>> But looking at the prior or the later checks, I see the '<' operator
>> used directly on platform names. So, the new check seems inline with
>> that i.e. in this case, any model or family after the said platform
>> supports MCE broadcasting.
> 
> Intel model number allocation policies aren't necessarily sequential.

Model numbers are assumed to be sequential at least within family 6.

if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
	cfg->monarch_timeout < 0)

There is another check in early_init_intel() which does this:

	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);


> So range checks need to be used with caution. They should be safe
> enough when done to simplify code that checks very old models.
> 

...

> Range checks across families may be even more problematic. 

I agree. Maybe we should avoid range checks across families altogether
forward (>) or backward (<).

For example, does the following change from Qiuxu, unintentionally
become applicable to Quark CPUs with family -> 5?


>         /*
>          * There are also broken BIOSes on some Pentium M and
>          * earlier systems:
>          */
> -       if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
> +       if (c->x86_vfm < INTEL_CORE_YONAH && cfg->bootlog < 0)
>                 cfg->bootlog = 0;





