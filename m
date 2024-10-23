Return-Path: <linux-edac+bounces-2196-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5F9ABF30
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 08:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76DF1F24EC5
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC93F14BF87;
	Wed, 23 Oct 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uz2yxyLy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2614659D;
	Wed, 23 Oct 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666089; cv=fail; b=eof9wnkigrHpXh8ltFM7AdS2LRq9kvLVXV1ctiqoC93EJAHxQujJDSiIkfrZfbrb0w3F6CLjcWV2dkkb+okSLF0WVhlWoLv4KrjQeOkrqeiepaOqJFsN/5aqKKsWUsOwfHI4vdYKdCoKKU+4rGgAd986WcM/4Tiv5s07gcnFNjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666089; c=relaxed/simple;
	bh=KO7LymrH3kFkoBinrdvBamW3HDBIh3UlWlVYp51nhQE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MLuUznkH5DCzFHfZo1Pq32WEBKV3lMVSxgewrT/g9jIgyswlPBYu8Am3SW/sNI0/7j2jMBxew5UmnJ2HJ6JZZMq0X0gTODtD5S5n9nt3awIUnF56AZ+IXGx7wnzzq+C1wwTyKjW4MMMIL2Jt+xWfpx6AoPDCAhlHiILSidXKHNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz2yxyLy; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729666088; x=1761202088;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KO7LymrH3kFkoBinrdvBamW3HDBIh3UlWlVYp51nhQE=;
  b=Uz2yxyLycmJ8Fm0UoBSJCJv/E3mBq2vR3O3bLYfRjS/8vHUQoiROrZm5
   wuXSU0N1XJXYB2kelLXIyhoWlzXEVRmsywz1+9qc3RH9wfK72vc++wSKZ
   rsRWHWOdUQej2ppfVOwHAd0z2HQRLZ81QWgmjFKs/TH8Tak+ZHynW3b6Q
   i4okWhsm8YHKeALs7udwsHR7o+rpeLCK/FtlFAOVS9x+7V9O7URYfaBwu
   68fIa1Norn8YlnZ3etGnwZSwnF9vT+sorNm1BNDsSXdInmMP98VvkdS9/
   BmBiQi3ZczJ5A1jQPRfGgLd4q2GSgpf26b+4rGlKGt5z8r7WGlYPQLY0k
   A==;
X-CSE-ConnectionGUID: BdzCewFDT5+7nl6+iLYjKg==
X-CSE-MsgGUID: J0VTZ291TYi2lwCm69vkjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29017128"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29017128"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:48:07 -0700
X-CSE-ConnectionGUID: /lBu/kmHTl2/uNnpPOZ4/w==
X-CSE-MsgGUID: Jq84ute5T1uU2JOj4QrU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84721289"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 23:48:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 23:48:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 23:48:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 23:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIAGKW7F+sSmtOMeV+qx6K6B3knO0iL2DTKjLJwBj6DzONvX1tjfNMuirq7stnkYpN7bwiwt47id7QLTXim+lobmEPpqM53xRPJj7XiXLyP0jZ3UkQoNaR4HEPR1yq8wCGxcMD6E89TNNuT3jlTgAFtshbmb63UFqgo9jHdOCByzhWpHdS5/pmVl5TejRiPxyuE7V8HBCr010W2xkng2K1SkuBJawTixnmhgL+g8F5k2L33v6nON16NzRo13U73XgtOTMoCO1LllSd9ar/tQPuQMtxUOXFMtxKeyeAm+Cjc7DbaDLKeqDsnY6rDWAeKYllwKCs9OXgsXSWtc9hTzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPWunYKp4/LFLviu17vZ8h+KI5mi926Msmocj78Y3o8=;
 b=tMGRBVWJUQJzh2AMNWO6bl1FE7p9v1uStmblNypvv7SKHfAXa7ConOhO+Wo1FR9w2sf4yS4TgJwoaGhv36/G8gP44+rIhodzWXcZGUWKGK597GParh+0midw7VwMGGXcRTG/YvXnZBJktvkARauoRUh/GuUO/nNQ2Kn0RmEZYkd9+7Y2hCc834pQpg9qr/BZRVHCqopZp0tmtersHCWwZ67BHGB3kZNx5JxlJH9Bcm87ol+qmuJHubXs+o4jYkw9x6s1YcrlqnwMJgYXlitxNY0hbhIshf4HiXp2tbSuvTRgMczK1iBKjz5bJ43iYk+J7xYIi2z3AhiooUxTD5kMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 06:48:04 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Wed, 23 Oct 2024
 06:48:04 +0000
Message-ID: <8a0c337d-ff4f-4da9-945d-12fe7119fef7@intel.com>
Date: Tue, 22 Oct 2024 23:48:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>
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
 <CY8PR11MB7134BB473B10DE627CC5784D894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CY8PR11MB7134BB473B10DE627CC5784D894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: b00e8d45-0bea-4506-9572-08dcf32ea4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVhsRjRhaDlVMEQ1UTJMcnVSS3ZVN0pFL0lrcFNTaE1IWTJWRGJzTHZQeFBq?=
 =?utf-8?B?bVMyL2dsd01iQlZJT0dOb3FaNUpmOUkvZ2dXRlNmYWkyWlVIMWhWTVo4Q041?=
 =?utf-8?B?OFFSUi85cXJGZFRtdG81L0REcTdpd1RtMDJGWi85N3c1MDd0Y2xzVXFZenpq?=
 =?utf-8?B?N3FLWkRLZFFmQVdRVE02bTZ3N2RjWU94Y0hIRkVtNWxCUWlrdUt1dlEvMG4v?=
 =?utf-8?B?LzVYY0dTekhWWmg5V0hKSkcyN1E0L1NlL3psTytoNHU2Ylo0N2RnUjZreHF4?=
 =?utf-8?B?Ym1yMFJxUWJXWkh3TWZJRlMvQXJJN0tKQmZXR084eklsbkVBbEhPdzIwbHZx?=
 =?utf-8?B?cjBIMlFBNGVpS1IydW1PeWVsbWNmSXAwdnd6TFl0RE55cHBXL0dtaFI3NSs0?=
 =?utf-8?B?OHRTL05kMzlJRUp3cHk4QWJxY0loL001V3pkR2RRNkJvelJOaERhYlFSbGFZ?=
 =?utf-8?B?UTVJZUEvMjNvTkZsUnVRcllhR012QlF4RG94SDBWY2ZhbUtMQzFDWHlvNEQr?=
 =?utf-8?B?Nm1VQW9VUTRkL215VDNSeGE1Zk8zU1U4Q2l6ZWwyRmxjcHRpK1VMRUw5NmhH?=
 =?utf-8?B?Q2YxajFlZStLdkNmRDJxNkdNcmp2ZG5SaTIrMkoxM05RSDltVFA0U3hzWFkv?=
 =?utf-8?B?QlZnbFVFNkpzQWVZaG5XdXRGb1VSS0t2ZVhlbnJyNzc3Nm1vU2xZcjR0R25j?=
 =?utf-8?B?TzBiaU9QMVdNRHl1Z05Nd2t1Yk5nZWp0eUpLeUxrODQ0V0djT3RycHFPRzJT?=
 =?utf-8?B?dE85T3B2RndxMUNBYVJnejdSdzFtTjFlYWtDSm0yT3BlZGtmVWJuNWZZbmJt?=
 =?utf-8?B?VVFpNTg2a1h6VzdyalFuaHU1Qis5TE1ZWFc2cWFpNG1laTcreFpnektKd2xI?=
 =?utf-8?B?TW85TXlUTk5ka3p1UkdXOVhQd1lkcHA1OUZyTkV6dnN5Ri8wKzBFMmI5YWVq?=
 =?utf-8?B?VTJVZ3VwVFRPZ2hSZm1MdW56REUrZU9NbnZib1dYcXpLeVRnZFBnMU96bnIz?=
 =?utf-8?B?Vy8xSGFEK0ZMMVJBZlY2MldaY2JNYm9wOUU1Ry9uMm1NQmhJV0ViTEllZnAx?=
 =?utf-8?B?dmcwZzhjcVNkUkY3R0FSeWpaZGpmV0ovdUc5aEFIR3FaOHUxT1pxQmZ0TnRM?=
 =?utf-8?B?Z0poRk9vSjZ5TkdSekFRdmRETkp3RmdJMng0YWJPc0ZJK1QzM003QjR0UnFU?=
 =?utf-8?B?aXB3UlNWbjNTUjlqWmhxSnVlSXdvUmIzY0V5L0tTN2ErNUYyRHlQejhjK3RV?=
 =?utf-8?B?ZWZ5R1BSdUo5Yko1d01yVzVHUTZRU0xkT09YYnU0T2Z4MmxEV0xxb012cWFC?=
 =?utf-8?B?cXRVQ1ViSXlIZlo2U1RUckUrUmE5SHcrTi85UEVGOFlkZzZsaDJOOUtKS3A3?=
 =?utf-8?B?aGNLS2JjVG9BNG0yKzZRZ05nM3o4bi9ESUlHMWZGeERRY0RkTitzM25wamM2?=
 =?utf-8?B?dFZWOUtNVWxDRmx3aEpnZkhEKzFMZ1lOZm5nZlhSWkRKOWNhZHJxVzE1SkFv?=
 =?utf-8?B?OWh3TDNJNXFmdExlbCs5M3FBMlhwdnA3dE10YmtJRXZmd1hlcXltK0RVVFlz?=
 =?utf-8?B?VUVyb3Rtd3dIdHJiRzBMNWN3dlBjd1UyWUl1YU5YWjBPTVhJYUJzaDU4aTll?=
 =?utf-8?B?WERoV2tSeC9jSVg3NVFrRXlLbTZFRFlaTlRIZ0thT1lSUVkwSWpPQVNCQTRP?=
 =?utf-8?B?eGhleXM0dXFmejRvYzZBejBtSGJXbjJYamRBZjlZT3ZCYW1tdy96RXVvQjR2?=
 =?utf-8?Q?7PxdqdK7W21vIlWlIZYA/gnmcFEETLtd4FR84LJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RndBY0pjNkg0cXFUSjdkWVFkUjBZc2J1UnFZbFlYeUx3dWloU3BzeGVTMDRk?=
 =?utf-8?B?QW15dFN1QjkxMW1MSzQ1d3ozcWxyUDl4Wit1NnlnUFg0a1FXTkE5SkxSOW1u?=
 =?utf-8?B?L0l4Rk1lbkFsdk5TUjNkQUtQU1RrN1k4clBNelY2eXRLNUJkM2NRV3BhQTFM?=
 =?utf-8?B?azUwMDlDODE1ZUIxTTlJNnZWbzFJKzI4MCs2K2xZVXpLVEN2MlNxK3BEbkpp?=
 =?utf-8?B?Nm96UDdxRkQ0K09sYUxjcDRPcVZud05nZFVYOEtoY2tmaE5aYUEzSklrV1cx?=
 =?utf-8?B?NlNyaUNkdTQwMlRYNURYdDhtS1FpUVpsTGpBTy9sYmI5UG5MVVRwY2pvN0Zq?=
 =?utf-8?B?OHRYakRMYkpFbVBTdXg4NU1UNkovMUl5VklZM3k1cVZ2YVY5QjZGU0FScHow?=
 =?utf-8?B?dllQSGp0dXlvL3VBaXdyakZ1cFo2WjRLaDdBTnE2R05Mb2hXS0t1dDExR3VZ?=
 =?utf-8?B?bTEzQ21mZkhQRmVuWmw1MmhiQnk4MWczTUpTZkk4czk4ZWsxK0I3RCtjL01S?=
 =?utf-8?B?NlBldzIwQUZpSVZSRngxRWVVY0YyTGc1cWlvTms3L013cWtXYkVGNm43a3lm?=
 =?utf-8?B?ai9yN0hCaFhIYmhjRTBSdDg5RTF1QkNyNnZvR2MrK0NueStJNUNWVDMxVVMz?=
 =?utf-8?B?RTRMZHVZL002VHNNT25ubHhNRndHMTlUV0hvRndzbFVJV3RHc3A2Sm9ROGlF?=
 =?utf-8?B?eVdJbXppZWJLRkZneEZBakFxU05mMXVIVWJmZkN4TG1yemNiZzBuT0RTQTFo?=
 =?utf-8?B?a3dZRGFQSnFMSk9BQ1N0Qml5MkNRN2JOVVNCY2JZb2NaM2ZOeUNJQ0lvTnMv?=
 =?utf-8?B?N0lnTVl4MXNldHNwWmR0cndzTGxQOWVFRmFvR0xJUlRxdFVTeitxaFpoUnVu?=
 =?utf-8?B?djVQTGYrOTlrdE9CWEpBT2ozUDlGMUFObytjbFg0YkQyVGZhSFBtWVZzQnc5?=
 =?utf-8?B?S1ZnRnplQm8zS2tGMVJVUERjWlo2U3lhL2QyNUhKa0I5UWRDZUZIcGNic3NE?=
 =?utf-8?B?bTFBZ1dBMHl3d2t5VE9KYzlEZlRLQUZ1ZE12OHZLd3JhS0ZDZzlpb2d0aXZh?=
 =?utf-8?B?eURiYUY4bzZOZEhubjRsZExnQWlXWW5vQ1ZZMmVDVUxDVXd4K2tGQ2s1WTNW?=
 =?utf-8?B?QkhFV0xscG01alhCb2hmSmFCNnpJbUpFanBOT3hwU3VKTnRmSDB4TWtrNTJm?=
 =?utf-8?B?Qi9UVnlsZHdqajJ5ZE0reHpIMjhQeEx5WFlKQ0RuMkFJc3YweU9nU25CQmpC?=
 =?utf-8?B?OTRGMFhQK3Npdnk2Y1BlbnhZWjNrWTZtcktBdUMxMlYvK3NSNVY4cE1YK01o?=
 =?utf-8?B?MVdFU3VMSzBKRTZqcU5wWGRXaHR6NnN5eUpzSE9hUVlXTUNUbXNjVzBSamhR?=
 =?utf-8?B?TW5oQTVJY1dBa3BaSWFYL2E2Wnkvc2NpSFJ2RHhLYzFicEJMK2N3ZVI0RFlY?=
 =?utf-8?B?N21WNnJ0T2dURUIxWk9QY0ZONVRIWVVva1VQaERoWnViaEpQT3o4UkwxRVM2?=
 =?utf-8?B?MVRwWGorMytOZHJlVVFGRmdYWVRHTE9jQzFRa3pPZjJMYmxxREZ0aTZpbGor?=
 =?utf-8?B?K3VnaVVNMEE5OGt3UlRrRFFnRlFkNHJWTnoyVkhZSlUwemk5RmhISEhyRmhT?=
 =?utf-8?B?ZzFCaTc3YVovOXBGOU1kNFZmR0U0NkNzNXpKbkZ5ZkV3cGdrZHZLQ3p2MlhR?=
 =?utf-8?B?NFZDek1oZ0F0amdZa0FxQVVTSTg2QXlWcHhtM08xaERtOWtyZEtoMUdIQjdl?=
 =?utf-8?B?UE5PeVcxTlR6aDgwMUkzcFBqWUtISkxXODRSWEw0aXdlcUIzQ0dSRVJuQi9o?=
 =?utf-8?B?SFZIS3JWWXVrRGlpK3VnUEFmRTNvTE9ZNFNVSHlZNEl5UnZTSzJZenp1TWdF?=
 =?utf-8?B?bW5TbUF4OHIwMTUrN3IwUzVkejNzajF1SVJQazFnSDNlMkYzdGpFZk9SNTFw?=
 =?utf-8?B?dytOVDVUUCtvNjhEUUZXeHZ1RVpTZVg2N2NEb2hTc3lDT1ZUcndNZ1JhcHlO?=
 =?utf-8?B?Ty95WHhPUVlKTFk3YnVkbGVOWGk1Y0E1VlNyV0NWUGRzQ2NLazlxZTExbnF5?=
 =?utf-8?B?alF3OGdObnhXaTZUQzZLOW1vWmpWNVlTN1dPMVRYYmM1L2lWQUJoTEdWbFBk?=
 =?utf-8?Q?h1eFJ4C4qOtIjEg08xhyNcJtn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e8d45-0bea-4506-9572-08dcf32ea4ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:48:04.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn3xpk2TAZyACzhyod7EJtSu0V5aEPH49SEeiVzlXIHCdu7FRj65isTvOx/Vl2sfjqUbb3ZzOXPja/oGy89m2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

On 10/22/2024 7:08 PM, Zhuo, Qiuxu wrote:
> OK. So, back to your original question below, what is your answer to it now? :-)
> 
>     "Can some of the hardcoded numbers be changed to vfm macros as well?"
> 

Even though it takes a tiny bit of reading to understand the VFM macros,
the pros significantly outweigh the cons. I still feel we should go
ahead and make the changes.

I have responded with minor comments to your patch.

Sohil


