Return-Path: <linux-edac+bounces-2166-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0A9A712B
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F811F22F6F
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F21EF090;
	Mon, 21 Oct 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGiaGHlL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D64199239;
	Mon, 21 Oct 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532317; cv=fail; b=OdqYjtURG67OCHLOCCAu3gg5lnoOo2nZg2QICcO+/vCE4C2RC/gRy5UCIksgEHcVRva3CcUXPcDcgSpF2oajPGHZXoG914NYlhv/ZdllIo3KmioBo0zQwnvRB5d2F91XbchVxAGfdnQUHJQSqJ6Wp1OK6xwSXyuKvUQOosuLpgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532317; c=relaxed/simple;
	bh=CqcRanDrSpylX3r+K84ArXbVAgDkBQkUc39J7HiBtRc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOE9iN8FdsE3OchMAtxFhIN1UMDakS5t9pbFI8814TnA6M43zp1ddrUdnIqSi7XXXqSILJ25/yEfhaS94rWj0D/pJW5Bv+DV/buO9J8fr0L94VoiMRgUsAVI7hec8+EtoH111vWqyHoDPDidXdWUFd8HXJcstjqKFnCgUCrvBM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGiaGHlL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729532315; x=1761068315;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CqcRanDrSpylX3r+K84ArXbVAgDkBQkUc39J7HiBtRc=;
  b=ZGiaGHlLCCc8xEzjKx8Cic8YReiMp3XhRfTYfymfRG2w7Loz1vXsuFc+
   D684ojJ6aaqOk6K6R4VWi+8bfL3aSWaMrYCqY9VrqjT9a1l4J6FbCpXtJ
   T8ZDBHqnrsJhCcrncpQQLM92BSiNpE3iaKPgTncPINyh4JFcVVBGcN13n
   TYdNgKjX4Wqg2luGIJsvRZXmPS7W8ls76MmdSr9WA1bjy9P1PSEtOEPwZ
   9Guzk3nfJw9Gu0DWK+SWneCUkavkWNJwlZ/CxlspJEatdL5qR4iiybBJl
   jwF839VjUN1118B0SqLdutTf9cfbNtgNFZCrcXSiaZcNfpTCDvrLMU0fp
   g==;
X-CSE-ConnectionGUID: J6E4FB1ETzWMPUKkRcI4ug==
X-CSE-MsgGUID: JQYzVz6lR/SnEaXLJpjitQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="32959815"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="32959815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:38:34 -0700
X-CSE-ConnectionGUID: ooAiisipS6KQ80HisM/hNw==
X-CSE-MsgGUID: 2WiiS9tmQ4+CXzaPAmtrGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79938778"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 10:38:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:38:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 10:38:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 10:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLDlao9XiEwOJZdD8upvPd2hiHNkgbVH0RLv73zqjwgckYwAZkehfuzpocukDsMyoojNcsujg0jjQEIxeWGfkB1LXEyulCwb8vlO1TVkyUmZrojjxwfTT0S6SCNwGHH27SxjQVo3csXEE1/nCVOZpyh2T+i5IYKYYj31IoVwJW8gNnw0tPbQxmFWBmLn/Hk7ZgxFoXEfPlbFO5GMl8zJy8P1hGO0VDAlijPGaF+taDB8N2W4qEMUN7qHo7oCWsGdlw/mGu6SpWab6kE4EdFd4mLH9UNjDLazZZXTUiijrJFJ6wtXVGrEK+T4bLBTWZx/MsrjReGxOhtVVrBwBmgkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM0rcNZGC9+ho+VSrX/ExbugVmqnmxPROZYC32l+kPA=;
 b=EYXDewFqYHrbZ5uyDZNPIVUGVJNAotr/AMkAUvs5ce7ph+Q8fpz+ccE/JX1azQ86APEVjOjx73UyH03P8410xhLp4ecA0RPOdk9lX/MBmy2t6PFa1BGaoLbEzl8u1TsEWc65zyW1+mf7Z75tMrQ7DQGSfqqzjK+eC55sUXNQ9SCZroq8qV66Fed6C3T6LeTWcN9/wXE2kkmY/ov8e3ja78nqwvQLxuGZMpKJIYUvZUPsx2RbXbbOO8JJG7mEQhanGCGJEtpZ66F3pNy1yiu5rqTu+ssUcFErJ/f9R5nANxY2Ov87Z1GgEst6Vu5SBKXLYuq3uoqaAR9C3GGcAP1JlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:38:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Mon, 21 Oct 2024
 17:38:31 +0000
Message-ID: <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
Date: Mon, 21 Oct 2024 10:38:30 -0700
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
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fac0974-3612-4ac4-a894-08dcf1f72e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFhsSUFIOTlIN3VYMmVnVFc5NnIzZUZoTGhQTTVocTRBWHNUZHdqQWdyN3F4?=
 =?utf-8?B?dGtocDN0UUptVDJPZTFyWkI1Y1ZhSG4wc0pVMjVaQkJyZ25vNTFMZTNiUUZj?=
 =?utf-8?B?cXpETXlLQ21HZEtUN1IrWTlqTHBiUEhibVJPQVVHVFBPTk5jMktMem5pODFt?=
 =?utf-8?B?cmticWQ1Mkc1engwS29lV0RYVzNWeWRPMTd3TGxJblp4ek82SmUwUWltR0Nu?=
 =?utf-8?B?NzZuQlkva0hyM0VMbXpqQ1pIbWF3eVRoL09qNGNqdXBuam1DQVZuVmpkL1Zh?=
 =?utf-8?B?Z3lkR1pUODc1eVRtSzVWeFNkckJBaC9OWDc5V2tqdUEyWHVSOXllcmFWb01I?=
 =?utf-8?B?VktJcEtMK0d3aGMzUDFMUEE0SHE5VmZ5azBhbGVYYk94OTIwRERXNTZhZjY0?=
 =?utf-8?B?M0xtcmZGbW5MQ05aYnNqTndtc1lOZ0NSNFFvWXBZdm1LMDVnUUVoWlR3QW0v?=
 =?utf-8?B?cFhTa2doUHRmVW1UUktxRlU1eFBvZWJKTHR3cU1mSVg4VGlqQmsyZ2Qra1gy?=
 =?utf-8?B?ek9PaHRTSzNrVlU0SG54eVlQclIzVFZFOUFLaGRNUGxPU252WlZRb2dFeFRq?=
 =?utf-8?B?MzVRSHl2NWJ4cnVPNWd1VGNXaVA5WG4xdVk4MHVwUVVOQ2s1MklDaGhSZGll?=
 =?utf-8?B?aW1hTzFDUWdMVllDekRDeWY2c0J3QXNpb1VTYkRGNjIyQ1NoVE5GRURucG9H?=
 =?utf-8?B?Z1hsY3NZOUdhM3A2RU4vaTFSU0NpM2FNbHBKNWFKdWFsYldTWnRZUTJWaWly?=
 =?utf-8?B?R1ZnaVVKU2lzYncyWitsMUNlTzZLSG1aYlcyZTFENks1SFh6azBXc1IzR1RU?=
 =?utf-8?B?ODdLSUNOS0FpTnJHU2FyenhYcFV6NjRVd0Y0R0gxTXY0ckZsOXRTSldjZDNW?=
 =?utf-8?B?ZjVwOGVUL0ZOcDdwcE85c0hjb3k2MUFqV1BDanFZbGZYcVRCWjlkNUVVaWhq?=
 =?utf-8?B?aWVqWTJSdkt6clUzWGwwcnZpUGRWdEpoOGZTTWxjZFBvU1hMSmpnWVZ1WnF2?=
 =?utf-8?B?Q29LOXY5WjJMclpUYngyMEM2Ym8wVEYzWEdZYWhucWJZeU1tdHFQYUphUFh6?=
 =?utf-8?B?MDgvakpCQlNaL2oyMURMZHZuRUxFR0E5ZkpMempFbVpOMHpaR3paY3JHRjZa?=
 =?utf-8?B?Tk0vcEo4TFJEMzJnQWRGa2pyRlJrd3Q1K0xyQ3lXeGJqSkhjWDNkbndUYVNy?=
 =?utf-8?B?WmNwemdLbXFVbTAzUmxuUEFVZVo3NEpGbXptNDJVcEpZWnZKS0wwd3cvaDNF?=
 =?utf-8?B?S05ZYVBvOVlPMGlQU3B2b05selZBbzhUcFNaRVFCVUdTNGFqTjJMdTVvSlNP?=
 =?utf-8?B?VVlsRWRjYmxGanRqaU1TK0Z6cEU4S25ORVpEdkpMQVhJVENuL2Q3Rjk0WEI1?=
 =?utf-8?B?MlhSVkxuZ0srZ0drY2dlSEpqb29xbGRvQWNvSi85TWVtdmdKcG1kb0d3T3ly?=
 =?utf-8?B?K1hwME1Ldzh3MFhyR2drMzRKdzVkcHFYcXRVMFFVQm83N2ZKOWh0dlVmM2NQ?=
 =?utf-8?B?MnlwL0E0M0tPZy9BUDlmTEJYM3dYNktKYm40QjBwYWVxc0FXR1hlZWNIemU5?=
 =?utf-8?B?T2FuUTd5T0MzTGhmRTRVdFhTQ2ExOENTL0lkajR0aHppcWZFK1BDSFRhZTJM?=
 =?utf-8?B?ZG9BWHFsNkJKWU04UjlJRHRpZVNOUmV6M25NWU8vbndMR1grOXN0YnVXUUdr?=
 =?utf-8?B?S1RSSXNqb3ptUlhkVjZLSjEwSXdrOHNwTlZSa2IzQlpUS2VST21hek9pTEdv?=
 =?utf-8?Q?6h9VGQh5r/Cjo9sTejT02RkjweHlXoVWQ8nX9BN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdmb002TWpkYWR4UmZyakdadDFEWE5aOHNCKzJLMUt3M3J4Y3d6ZjZZNkkx?=
 =?utf-8?B?SVdURmhBZEJXT3Q2OE1rNW9SSVBiRHRFc0tyV0FUMjJWY25udFU4QkMzbTIx?=
 =?utf-8?B?ZzdGMlNNaS9BTGttZEk2N2ROeXlsbkMxdEtCcW5HeDhjcUpQUzRyeEw4VlRE?=
 =?utf-8?B?YjNiSzRha2xkekJmRU8yZ3FrVzFQdi9QcWNEUElPbUxEcmNzRmltdkxpVHcr?=
 =?utf-8?B?bFVaV0tKamQzdndoNmpUTG14LzNET25GcjRnenFiekk3bER3TjVkZ0E4cEdK?=
 =?utf-8?B?Y2xqNFRnNFFDTHJKWmgzOHFobklNd0FtWGVsU0dzTzlHZzZTdWUxWFpQQ0h5?=
 =?utf-8?B?S3lZbjJvQzZHMzkybVpJMUU3WkRBQXdROXdJc1JqZ2F5NWRJNjQreEdvcXBR?=
 =?utf-8?B?dHFpcnB4Q1dzdmhJRU9scU40bXVab0g2QUtCd01oWFg5UGxHWjN6eFZNVXh5?=
 =?utf-8?B?WFNOZUNJdmt2MkpUeGNLOE1PckJLcEFoa01ydXZGWWtXdWt2Y2ljSkVCeVJ1?=
 =?utf-8?B?VVZSUzJyQm5Za0pMYVFiNEQ2NnJEZFhYTTN2UDFFa3Zwcjk4aHlkQzhXdFQr?=
 =?utf-8?B?cnRRcE9JM2w0QUpvV3c4dEN2V2FzS20wOXFGcHRIeERSZ2ZHUFlyck90dGpo?=
 =?utf-8?B?dWJBa2RzLzg0Q0RBWnJ0dWRQbGJVQ1RTaktPa1ZkaEhLZXBKdXl3WjZneGY3?=
 =?utf-8?B?TytVSXFISTE0OHFtMmFVUmlnYk9KN2ZjRnlLWDFBbzhCQ2JuUEVjcHJtOVZa?=
 =?utf-8?B?NUQzaFNWcFFyazhpdklvd1cxNEhGdGdCbDh1SndzYlBhMTlTekhZQWtuajhB?=
 =?utf-8?B?SEpKbkljalFhbHRVM05SeUdBbzdsWUJXVXVzaEdWUTJsM3FHMU84cmEwWjZk?=
 =?utf-8?B?ZGdEM2ZHOS82WjJJRTNIS3ArcHF5S3FEWmhTWFhXUUcwY2MzSkN6RVVPR0tG?=
 =?utf-8?B?ckRoYmloSzBaU3BtZ2JYVk9UVWtOamlobmRva3VKWG5vdVJQajEwVG5icDd2?=
 =?utf-8?B?TDB6dkNDcVAyOENkdE5rQ1ZpeGJNZXhXMU12QXFOQTZ2a1VrZnUxRVN3UVRq?=
 =?utf-8?B?aUVPYStqL05UNW1CbWtmVERJKzRIZmxSRXNyYVhKaTE3ZlhTM3ZuLy9qaHVz?=
 =?utf-8?B?SHBlZFlXSVNQbkZ1bk4wR0RpcmhpQk5UOHNSQ0JaSzZpVjN6SFpoZ1BYU3pU?=
 =?utf-8?B?OUVyaUt5cC9uUGkyWXJSM1FaWVVqRnhEZG1rYThhdENINWZ2VHoyMFM1Vit3?=
 =?utf-8?B?RldwaFdXSmNlRUhDNXVDS1YwTTlLL09VcjFBZDVpRWhyVEVZWDBKN3RnVkZO?=
 =?utf-8?B?Wm1qZUEwbmJSR3I1UjA0bXNZQTRyNjk0S3Z0LzkvbzRQQlJ0Z0ZTM2I2RGlw?=
 =?utf-8?B?RG9CL3ZXc3BydElBNlliUVdmbWVOWHIyeWV2NittSk1BRWVoaStlM05WMGJ4?=
 =?utf-8?B?MG5yMWdTRk9DOEJkM2FkWDY0Z2FESXFFNDg5NjB2OFJSWXpPSmJ1UzZqZ3h2?=
 =?utf-8?B?ZFQzNVpqZE9JeDVWUTZROEtNdmY4VUh6ZTh3NXY5cklxWDYraC8rRWhPS3Bv?=
 =?utf-8?B?M1RraElqbTNxbGI5Q0pBYlpZakIzQ3dVZnZVcVRSb2RFQzdrWEVuSjdGYmV6?=
 =?utf-8?B?SUVrcHNZZVdzSFRLNGVGM3FYZG5DeHY2N0pRWjR4dGZaVzc5dithTEY1bmZB?=
 =?utf-8?B?ckRnUXpnMi91SUQzc3lraG10U1AydTVrRXcvTUJOZEdLWTQzOFR1eU55MjdE?=
 =?utf-8?B?MzlrWnF2REdCZ3lQNXpKWERGVVc4aDNkdWZRbVJYTkg5aEwwelh1YmduZXh0?=
 =?utf-8?B?Mmprc3FaamlUNVA4YjhUM1lXTE0ra2J1cUZpVFdYaHZPR2Y4bDBUOVVyVTFi?=
 =?utf-8?B?enBabVBNVjJoUldVR2ozaEdKcFRRWDBJUk95TUFYcU5rZDBBT3l1bnp2VDRE?=
 =?utf-8?B?YmxySWZkRklyb3VYNHB0bk9kZzJZRFpkTXdURXI3OFM3amxMRlVNdk9udXVs?=
 =?utf-8?B?WUUvd0RwZHFvb1NSenJDQ1MyMHdldFhkK3d2U1M5UllvMUlLS2o2WU1jTEZa?=
 =?utf-8?B?TGhlaWFlOGFwOFhFbmFWUllsbkFOTFd1S2k3S242bVY3Z0VlNDJGeEtnV3pV?=
 =?utf-8?Q?b50kf92pYAmhwE6efOW9BpFQ/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fac0974-3612-4ac4-a894-08dcf1f72e36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:38:31.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et6mOH1casRnjtljktt1CN44XJ8gUNHpM6D8p7POxNvt4Clm2c6imAM1T+3Oqi+/ZvDlVAGNnMouy3eGBB9nGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com

On 10/21/2024 9:06 AM, Luck, Tony wrote:
>>         /*
>>          * All newer Intel systems support MCE broadcasting. Enable
>>          * synchronization with a one second timeout.
>>          */
>> -       if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
>> -           cfg->monarch_timeout < 0)
>> +       if (c->x86_vfm >= INTEL_CORE_YONAH && cfg->monarch_timeout < 0)
>>                 cfg->monarch_timeout = USEC_PER_SEC;
> 
> This change is correct. But the old code makes it more explicit that
> CPUs in families > 6 take this action. As the author of the VFM changes
> it's clear to me, maybe less so to others?
> 
> But maybe its OK.  The comment does help a lot. Anyone else have thoughts on this?
> 

I am not very familiar with the intricacies of the VFM checks. I did
take me a few minutes to figure out why the modified code is correct.

But looking at the prior or the later checks, I see the '<' operator
used directly on platform names. So, the new check seems inline with
that i.e. in this case, any model or family after the said platform
supports MCE broadcasting.

>         /*
>          * There are also broken BIOSes on some Pentium M and
>          * earlier systems:
>          */
> -       if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
> +       if (c->x86_vfm < INTEL_CORE_YONAH && cfg->bootlog < 0)
>                 cfg->bootlog = 0;



