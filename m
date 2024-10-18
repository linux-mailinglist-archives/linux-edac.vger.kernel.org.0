Return-Path: <linux-edac+bounces-2140-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8263D9A466F
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 21:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB97B2163C
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D676A2038B0;
	Fri, 18 Oct 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLYvgtW/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9980188733;
	Fri, 18 Oct 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278174; cv=fail; b=B9IYx5pbdSIgQiSem33XfgSuefHefrCZJYzn/APlkRpuUt680OUzqBMKO+qDF971Sc03q4sR698VMsDt2RJHIA8/+4CnXYiplMBoUCLYT36RBp1d0xD0vts7hTfgoiXRtNYHnTXMtK4/xTvga7NwXnridllusP/6oDMLvUFtSVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278174; c=relaxed/simple;
	bh=xw1V5ksk4Pak9RntNLhsVWZm56YxNUrTRferqRt5Eew=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAs6P3VuVFsRgr2qzVL4e05S0rM949rTp9O0DZyUMKq419kBmFDDruFzQ5+amzgUklS28HwfaDWMEI831XSpQWOtNNKrZMlK6vGyuDCYCZgL5J3O+T19fWG99Yzlb2WbuAWtekFkDFdaytxhKhDIUzHTesubONwFssSx+2wHIt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLYvgtW/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729278173; x=1760814173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xw1V5ksk4Pak9RntNLhsVWZm56YxNUrTRferqRt5Eew=;
  b=CLYvgtW/CTfL4JglpokL2w5GdgITsJD/XtjpW19YY/OabBSOsIywc3Wu
   CQ+uFa6CEK8d8iSlvBWFADdwaE5a/S0wsAVbXR0qVBVAaXhyhasaoDrDw
   oXf1W574jd39HhnV7cDCijW48qVnS9p+xSB5sPXw4V10GJ6xc5t2Bndix
   rAVm7Iar1RL9KVaXuDKApJhsbTwWKTNJ1yE1QK3zcRMx4Nstu/ILsprgW
   +Groj2HcVCw8YWPhKdCPbzwRe3O6I3xicSw3pCMlfbh7L8cSV3/0u9AWm
   K0pMmElgCNBpnvM9xDjLcR/gGCyo/qY9nUo4BXIOCaA4Vik4xZb4bhOPm
   g==;
X-CSE-ConnectionGUID: 7xgD0txzRASCbe6pcahZzQ==
X-CSE-MsgGUID: FOYUUHzSSjyZbsMKe5Y1dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="29032531"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="29032531"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:02:52 -0700
X-CSE-ConnectionGUID: LmOxE/HcRq+UROJMNPJCjA==
X-CSE-MsgGUID: OY3lMctGTyiJWuS7569WOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78604706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 12:02:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:02:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 12:02:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 12:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlMfGru3JYa7/JID7oMalsVimzrGxt7acF596Y4kCOW5UJc2mfBscUUqj68MwmjzWzAHNoyoujUtcXtK/6qW4tHL7gss6PwGJIIIqdjS9O66w+bkMdmEPptfCOKCt/ZXadScitcpxI4Xj4pqDIzBmAEVqhcPndQAxdfweW4HBTuT8Rk3ZT8D8P6hsHQyTkeIjWVQivbh2SkoVsLifu94Yp4oFnRbvoN/UYfAc0oWJTE+DSc/53W0qO4soRzcYJDp5vCyIbMCfdSyrpESCbkm8+8NbDFzdiQKFF50Vuw+Yv4M/fDDf19LRgeyFkPFEpj6uNXNbvHplCgR3xYBhDl5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA+8bpNH7SKdYFCWx5DKJlk4HRNjbf7X3ufcexeD6ug=;
 b=gvkqRAd28O45C9BnUBij8dtpHualf8jqm8rod1gB2rgB4xL0BMUwengxrafTngYf3uhNVlzFvA3l/sJi/UbNeQo34H0kWS06UPMujbxCeoNoPQaAYjbgkbPbRA6aE6TNLoAHi5C8CfaOrXdqFWxtweffppdMtu4D6LTTjCxD+ygXyzWdfKZDml4Q2x146sc9aM3XWErLF5nKOj6EKAsqltLjOsBonFtn4YHO7jvkVnUW6/1CemzkMQ+1otockxdvuVmzeJr7J+AxYZekkdrDxZZCqaDsUTxB/mbKV/RBrFDflfdiruLGZlp0wQeEN5UU6BqHFlpu39r2UoOJoSjCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 19:02:45 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 19:02:45 +0000
Message-ID: <abb86e51-ae6f-4872-afe1-627824c1e763@intel.com>
Date: Fri, 18 Oct 2024 12:02:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] x86/mce: Make several functions return bool
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-4-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-4-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a12156-3699-44e0-386e-08dcefa77338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1FKRFFQN3JoRVJwMEErVUtobHV5WGdMZXVwTWNEbEMvaGxrNFZvR3hWT1lu?=
 =?utf-8?B?eEtyQ0x0SkdVbHZIZ3AvQ2ZicEk0M0JtdUdOTkVqd1ZDbDRVWDV6Uy9rQ1FJ?=
 =?utf-8?B?dnJFL3BPTTNjNnlwNU1nQWVEUzJjRVVxR3F1dTAvcHg3Tys1VEQ0Z205RUNO?=
 =?utf-8?B?VGQ1b0FGQnVyM2FnTzJVd1JxOVR4YVI5blByY21wNEViNVNaTVU2RGg0cEJt?=
 =?utf-8?B?d3E1WFFyZ2FPbUNETHFrU0g0d3I3ZnRLbkxzWXB5cW1Pemp2TWV1cmgrMGc5?=
 =?utf-8?B?YnpDN0dOZzN6ZnNQclF4S09seW8wT1Y4N0ZNdXF2QnpUdHZLTDFGRWR2NXdn?=
 =?utf-8?B?ekxLQlNLKzNmRyt6Wnc2NTN0MGRUNld3a2NUMVRoS3U3WHdrUHFNRk13KzdX?=
 =?utf-8?B?V0RQTG01L1E2Sm94TTh4TzRDV3RiV25kVnZYendPSlBrelZWN3c1cXZSS3hm?=
 =?utf-8?B?MlRLbFlxd2pKR3ZvWGpQOVd2bjN2Tmw3aHEvWTY3RWJpYW05cW1hZkxwVmZD?=
 =?utf-8?B?V2JQekZ3QUw0ZWVDMTNoajgzOWFRS2x0bDMvcW4zMENDdHlHcFVtNU83d0xX?=
 =?utf-8?B?OGlCUmdiMzJmWUFEcDFIWWkxUXFTYTkvK1kwSnNVc0ZINkZLNlA5N1o4cFJV?=
 =?utf-8?B?aG1pNFlRY1puZHk2aTNhWVpROEJoV01BYU5jYUFIWnpKR29BMXZyQXVLWGxO?=
 =?utf-8?B?ZzN3amFkUUp1a0tidVlzL1lUMGlCZXVrSDAvM2FyanlqNHFySitsTTVkeUVv?=
 =?utf-8?B?eEM4VmNxQ2NDdDRpeWlXTUdWMnI5cGgxTXI5bThobm9sekc2cmJLS21NZEph?=
 =?utf-8?B?NXZUMDdOVElvenBkK0ZYL2VtcWx5VnV5RnJ2QncxbUp0Wk1acTZtY29WeU5N?=
 =?utf-8?B?dHBjWHRRRWRXejhyTzBMb2JhZ3RUdEN0K0hiR1RUZ3RCRDJpWGNtQTNQekQ1?=
 =?utf-8?B?TXJlMDg2TnIwZVdJbnBabCtVNHNJeURMaG9NTTlxZjNldkJJcmYxQjd1RDk4?=
 =?utf-8?B?NUdjdTh6RXJhdlBOL3ZER2dtVFVBbWduUWlDakd0cDk0TDdUbUswd1pUdFV6?=
 =?utf-8?B?eU5WMW1mRlg5WElwazdSK1NvOUpSOGovUmxTbFd0Z0xIbHYyaUF2ZUJ6L3VY?=
 =?utf-8?B?dzlIWmowRS91K28rcFdlaHFnQUU1M0RTUEdTVGcvRzZrMDBJeDN6ZEtYeEpH?=
 =?utf-8?B?aGVpRlNEU3RFRUJqUEU1NkFGQUMzVHVmLzAyblNsK0E4ejZoRCs3MEpoT1pp?=
 =?utf-8?B?TXlianFqMVI5a3BNVytLL1BYMXlyMm8wNERnaHlrVEtrS3orODRKS1NGcldq?=
 =?utf-8?B?V3V5ZmVNL05oajhGZ0RQRk5HVUJYaUJFVU9Uc2FSeWJHa09xck5xUjVYRllZ?=
 =?utf-8?B?dE9sZkt6b1RaendjTHk3TFh6RkhGMnVBaVRRUVdxYVpkL29FTHd4eTRJWUU1?=
 =?utf-8?B?NFp5K2Vqay8xQzFvdEk1Wk9ZbjhXSFRIbDNmaStGMEQreTFyOFFWaGxIenZE?=
 =?utf-8?B?QnNWN214S3Y0Q0Y4SFpoY016cG04Mkp5bFo4bmpQNVFjbHhtd1ZYN1BGSlIr?=
 =?utf-8?B?TFQzcVdmNjgxZnQ2d05pOXM5TGJEczZidEdSQVNleXdETi80VnBadDdFTVdJ?=
 =?utf-8?B?aHE1UkpJdHd2djRhNE5aSnBsUVc0a2pNY2RzU1J5b0xsUmpqd3h6U1daYUNN?=
 =?utf-8?B?ZlN4Q2U3ejhhUHJZRnNpQUIwbDRzbVQ0OG9IN2hNNzZUNFd3eW1KTnNZb2RG?=
 =?utf-8?Q?tg8RPyNkrCCLYpu5j0V4XBbv9LRdrp5A0jU2h4N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5rcy9DcTMxU2w2RjVoQ05kbEtPNDIxVlpRWTVCVXczeUVUSDJEd3oxR3hJ?=
 =?utf-8?B?dm9USm5mRUFISGNTYU5PcVJoK2Z3SU5ROEJFQ0tRaW53UWp6TEJLckpKcVBN?=
 =?utf-8?B?ZHRnQWh4RERMWWhkNCtycWdSUnRrc0NPQUhzcW52TjVNOUR3Y1AvUWg5cHlS?=
 =?utf-8?B?M281UklzZDhnejVmM0x2RWZBSzBBdW5WQldXUWI3dmpMaDR3NlJCQ1Q3cWlm?=
 =?utf-8?B?SWJ0RGdIdWd1WURPOXRCRktqc1JVVXYxR1FMVUMrL3JEQzJtVDR3K1l3K3hE?=
 =?utf-8?B?ZjdZamx1Qkd0Y21UOENQaUhkLzl4SlhsN2xRTzFBaXM0YnREbVBEZmxOaWxI?=
 =?utf-8?B?RjlwTlRuSjhNYkEwdXdJUWtadUJjNTVDZGJ1SnlUaGRSOXlZdWFTajBHODhu?=
 =?utf-8?B?dWxteTQ5UGo3Tmk1VlJaYlRXSEI5SmFsSDV0TWQ0SHhYNUpSNWV1V09Oekt6?=
 =?utf-8?B?cUN0ZWhRM3RSM3E2dko5OFpwbndqWTAxYm03Q0NsWFdLSVVrNGtjNWZHT3JP?=
 =?utf-8?B?Vjg2NmxMcXhDUEdyWTQzeUFjcVdKNVlqRndQQXM2MVJaQ2FlbVRLSlIyTXFM?=
 =?utf-8?B?SDdqVlQwWkZLRXc1RGFXVkgzbUMwNmJER2hZSEVtTVpZQW82NUxMQzNBeGl4?=
 =?utf-8?B?Mit5N2c1dnFWU0RhTjFxS04vWmVHTWRoMlBWQkw1bHJQT3R1MXZQT3pFUG5w?=
 =?utf-8?B?QXdQU1BTNTNpNFNacGRIT3hPbzZYN1dEVm5aYmZDNFBZV0FEa2R4Z0VWekcr?=
 =?utf-8?B?VUtsY1QvU0JyclV6WERVeHZMRzI2MGVwRHlvMWlFZ25ZTDljNzE0VHkyZkpy?=
 =?utf-8?B?T0dlR2IvSnZlNUZhRmRXYkUvT0RqSk9ENEw5SUdjSXM1aEU2TUs3UzJ1WW5v?=
 =?utf-8?B?YVZFZ0RPSkZmeXlLYUZham1IWWhQQjFmZnJ0eWZ4Z1JLL2dhWHE5dXhCTnFr?=
 =?utf-8?B?aDNITWh4ZjAxckFxZGc0NUttVHRwbVJKUVZNbXpKaDJBT2d3b0EvTzF2OU9m?=
 =?utf-8?B?UU9zaG1qdjY4eDJSL08wZmpDczVZZU84SVNySWd5SVRCL3U4dWduK3crQThr?=
 =?utf-8?B?ZzduQ2hKcEpsTEVhN1VsZDI0Y1hobjA1cTJGWUs4a1NBYkRweVVOWDJMMSts?=
 =?utf-8?B?UnUxRmYwVFRobjhYd25JTk9lbUpTenF0R2NWUnZGYjBicWkzRnJ0dXFpaEZh?=
 =?utf-8?B?V1BYL0JIemhTd2g1ZFhZWTdaZzR0ZkR5TWlCUGR6elM4M0VjUU5UWmQzVENx?=
 =?utf-8?B?WmlLVmI4OE92WmE3QTBjSGlpc2RpVEFrWTZPZEFubEwzZ3o1YzNVUHlCS1lD?=
 =?utf-8?B?YmlyeWt1Y1ZhdmhqcnFkZzltbFZ0WDlXQnoxOFNJUnpBaU0rMWlPOGV3N05Q?=
 =?utf-8?B?anNORllETGs4REtkZHZIUGpIWXgrZlUyL20yUnlERWcwWWJrMDFVTjgzSmZC?=
 =?utf-8?B?ZWxFN2hrSklWaTcyVzJDcmsxMElJNjdzbU1VbzVFRlA4cVR6TFJ5N0VnYXBl?=
 =?utf-8?B?M1hzLzl3TGdFUW1wdTIwaGFjSU5UaG1XU0RhM1Z3OUxDQ1B1ZjZ2TFJNaXpM?=
 =?utf-8?B?dFNaRnhycDRQSllWMXNVbDJwRWQyZXFvdUlsdzJma3p5Yk1QR1lVanpldlJO?=
 =?utf-8?B?VWg1dC9OUkZ4MUJmSDgwSzMwZ1VMalZITFVBa2ZnT0pBd24xTU1kRmQ5ZEw0?=
 =?utf-8?B?UUxwY0RWN1pkYm1UQVl4UFJwN1A3TzNSUkxQWEF0QnhwbDlqVFNHMUpNSk5q?=
 =?utf-8?B?bkRtY2ZnQjY4Nm9ER1dtVFJqakVGUjc2bi93N2t1Uy9ReHFldzFURDdCcVA4?=
 =?utf-8?B?MmJRb0JFSno4WXhvNmNsbWM5dXlHaXBFdWIrNFE4SXIyclRJZ0wvRnlLVk9N?=
 =?utf-8?B?UHBtSngxR1ZQZFBqeDNUaUIxNFhYc2l4MFVyai81TzYzWDd5bHFQWERDdDBx?=
 =?utf-8?B?dHNzWlZtaVlqeDJZL3pQQ1dPV3JaK1dzanVudjI0cGd0U3R5WVpuV3FVb3pO?=
 =?utf-8?B?MU9RT1dtbGRMVjlvZ0FiekxNby92c1Y1RXZmbGJJNWtCNWVuV2R2K3VsNnRU?=
 =?utf-8?B?V3lhNjlkMGlpVkdyYWcxVG5QMjZrdHY5d2U3TTFQNFVBTHBQUStEYjAwSy95?=
 =?utf-8?Q?xCLI4rS+auq23RcjGhGoJZTJu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a12156-3699-44e0-386e-08dcefa77338
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:02:45.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccHJmpE65nVg7BadztB9by4uHiBuT0EuyqUSOM1GGDqzTYNqyySNLKz23u+i433M7Df4WP8J5NEC1flKrO6Bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
X-OriginatorOrg: intel.com

On 10/16/2024 5:30 AM, Qiuxu Zhuo wrote:

> @@ -1748,7 +1748,7 @@ static void mce_timer_delete_all(void)
>   * Can be called from interrupt context, but not from machine check/NMI
>   * context.
>   */
> -int mce_notify_irq(void)
> +bool mce_notify_irq(void)
>  {
>  	/* Not more than two messages every minute */
>  	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
> @@ -1759,9 +1759,9 @@ int mce_notify_irq(void)
>  		if (__ratelimit(&ratelimit))
>  			pr_info(HW_ERR "Machine check events logged\n");
>  
> -		return 1;
> +		return true;
>  	}
> -	return 0;
> +	return false;
>  }
>  EXPORT_SYMBOL_GPL(mce_notify_irq);
>  

I am slightly confused by the function name mce_notify_irq() and the
boolean meaning. Would it better to rename this function to
mce_notify_user()? As the comment suggests on top, it purpose doesn't
seem to be irq related but to mainly notify the user.

Also, the boolean would probably make more sense then:
	True -> Notified the user
	False -> Did not notify the user


