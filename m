Return-Path: <linux-edac+bounces-2499-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEC9C4CA6
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 03:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191DAB21EFD
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7119E970;
	Tue, 12 Nov 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPnmisNd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF2F4F1;
	Tue, 12 Nov 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378660; cv=fail; b=JcCFGO2tRZm9Hq6+0e/qRVc9Oq045G1JvUTydFSKdQe0LjfKV3H1bGN4ALMk5GrKOVBuwencPyXFCuxkjzSBZqy5kMn5/9oAtnOiNrqNMOQXi2zwjQVVoTh9WkWEJE4LmcbRlbCuWxAdPDUV8TkJanjSf9KciWYVG/Le7O614g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378660; c=relaxed/simple;
	bh=rU0oe+jZt9IgyaGX1/n4Bi77WdAdq2ZLhaKbZMae7CM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/UbOob3tu5b6JJcQCI1phxm78RcjXx1ACEG+SVvzZnQeTjGEO07JE75UhA/UsYnRtDqDfB03IiOgiGGj0hH5f3G7+BeC36+MTHV6UpThI1clSR9/YLIPjheHjHS0rFMtNrgoC9SobGfExpFesmaTJpqIUpc7SFKZwNajbhcU1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPnmisNd; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731378658; x=1762914658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rU0oe+jZt9IgyaGX1/n4Bi77WdAdq2ZLhaKbZMae7CM=;
  b=gPnmisNdsX4p3Ovyk/E3tWosnlpBsaNZJ57atosR/yibCq+/XTkp28rw
   dcFr4bRqVtamijcNOhmXst3wDojfIODAyTUJVK20bYJko0iMjq1i3wV+T
   wQ3ZymbHULBWYbVswcJdAh7emiOHQ9J3niY7sabf5fLkdfUmLB/hMC9Pu
   qYk+4SCNENH9yeI58cSlO8mwfUHUAss4c8Jz7/AtPzzFGgdRSYmKC0Nzj
   E3BcHw6SEm8oHheg6QB0fXi/nAuuHIdqMNN5i8zQPfyrVv6aBEsDp8FA7
   geeLmwWgBbwANuQCn8lKWFAdGFKTWC2aWu/z3XWD6/cpOPzjWNVfckDur
   g==;
X-CSE-ConnectionGUID: dlEZhR7GSvm2HgE9qHXHdQ==
X-CSE-MsgGUID: eFkB6/KJTSmCweKVZ1tCKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30598811"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="30598811"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:30:57 -0800
X-CSE-ConnectionGUID: Zesz5VQLQ5G4sPVv+zzetA==
X-CSE-MsgGUID: KQtYB3pzQWS3GQOK8NJGbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="92150437"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 18:30:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 18:30:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 18:30:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:30:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjRSpbRNBuFkjrodSaHyCE8q5lDmmsO+6fd1cEo4WUlhdYXm1vHogTndycYwTkgwVKqSijY7UUTH7LHQeVGk0d5sQAj1DZkOgkVS8Ewmk1ud7znEEYLafvMTyFlNKi5pEmEqLqWqcNdb4T6kyhdA9cqZFDjleREnOaC3wDhNsVhB4GZFeRnNEgFRYypyT56tWlJ1SGa0ei68OFgleekTSIAQKIxh6DeB232JJ/pMVN04cE4c9TJDeHPVf9NNUO4JB1NSWH1igTB5wBdK3n2IEhNEyl3mGgKjIL2pIPLE8ewZDh97Kudz+KdAj1uPPl67ZpsfEE3kPrSwll47RpU9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgna+uAYd1gnRhznqPXbln9HnHcEXbt4FFESlWhDB6U=;
 b=Ux2aO2t5A2QDkwcJA3niacnxAtwrvlfgeNxjfJNzHMCY8HHBukGBWS6dS22rMGRbDkP/OkPlI2LUMHFcUcV+ngLpMJ7ShKi93PsVGNqM8TVEEGo1csfGNRXjVDlKJWtFpy+GuiMfsdRRq60dUaboWWerfBnIM4dwniAJPIobL1tX4hMKf8APw3yHzvKuks3XLliTdh3NLm8I/JZmG8fNYHBUytbYbgJ5B54ZPhCorCe1Sc/7narXPrtsFt7RGXU6ZBteDcWKRX9NaDF4jMgcFrrGSqY4TEvl/blPTu5jziIIVLGUfz2PShw9x5T6CfHOjMkdKiltsnJDcP4L+srvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:30:50 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Tue, 12 Nov 2024
 02:30:44 +0000
Message-ID: <46eecde5-7b91-4cbd-aa1b-53c811a71a32@intel.com>
Date: Mon, 11 Nov 2024 18:30:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] x86/mce: Make four functions return bool
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <tony.luck@intel.com>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <yazen.ghannam@amd.com>, <nik.borisov@suse.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-4-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241111060428.44258-4-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b59f8a2-d85f-4921-2f49-08dd02c2026b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K09TMjhWMTBIdml1UmNiemszZ2xlWGVBakV0d2t5UkJoRTN0bDZxYWViaGlt?=
 =?utf-8?B?ZFBMeGdMd0o5Rk80ZVlnNGNBaGxsaWhGYTFUb3VhSnk2b05NUmF2UVB5R3Ex?=
 =?utf-8?B?K1JYVVpEQ2xacVgrT05zUnBqcmNyeTVIV1ZwSDJvOGdmcS9tRXRNZlRyMklH?=
 =?utf-8?B?T0hVVmdzY0NVQzJGUHJnMEE4Vy9hNkttREZURXJkN21GdU93eXA0TjU4Z1I3?=
 =?utf-8?B?UTZkN0pXK2NiQVdpSThWS1Fid0dxUW41VkJ0SkxKZlMrTG9uVHM3V2dRMk4x?=
 =?utf-8?B?ZHgzZ0xsS01uM0VHYzVxZnZzS1I0OGNGZXFJakZKc0dGR3VUQ1VyRWhKakM1?=
 =?utf-8?B?NlFHYVhJc2R3VTFtZWEzWE85anpMcGdTZkFBSWkwTHpHd0YrUzFpd0ZvRHZJ?=
 =?utf-8?B?eUQyZnJXeTRuUkFJZWw4ZExieE5icTczaUM5UHVIK25FSnFTbmFkdlZpaEZY?=
 =?utf-8?B?VGx2SlpzQVVZVDVFNmgvSTlNTXBSdmdGQkN6eENLbnorU2s2aGt1UklTS0Va?=
 =?utf-8?B?c1ZVL2xRbTJSSDc4elBrSTQrbDhtckhKK2t3LzRlTTdRa25WRVBCTWovSDRv?=
 =?utf-8?B?U2xkYWtwSW1jeVRYMlNQUU54Tm1raGt5OUpvZStaUU1ZVy9RY1lDd0NGcGpm?=
 =?utf-8?B?UWUzT1VSYWdwNEV2Zng3QlhRVXpGOHc2b0hvaWN5aDVJN2x5aDBlbXpqNjE2?=
 =?utf-8?B?eTl2cUxHMDZ5ZmdwTDJOM3FXN2tUdXlpUDhuZzY4TFphZmFKSHlQcDNUUk83?=
 =?utf-8?B?VFJpaVBSLzBaN3lSb1Avb1lhTS9Scms5SG5EVnpQeWtQOHJvVGMyVitiMFlr?=
 =?utf-8?B?czRTbTlIenZZbGhyWEdUYmMvd2RDdGhUeXJCTUJFOEtscGRFMGNPSFFCM2FC?=
 =?utf-8?B?MDZ2L0JQa2hoY2lMZ0loSkJkN3pFd3BQRGFFMktabXE2MVBWUS94cUdkRFY0?=
 =?utf-8?B?bEVIRXYrQ2FqZTJmQmpqa1hid3ppQXJ6SWZLUUZITXpnWTkwTTBaaHFmY09I?=
 =?utf-8?B?eVFQZStrWnR5NmZLenhqb1IzTk4vOVJQVVFGN0ZWZTYxQ1czMi81SmFjclE4?=
 =?utf-8?B?SzdIQXFNaFg4b2FPcFFibXI3T0FYUnpFWk5aMmtOY29NMnAvc2cxME1jUXRR?=
 =?utf-8?B?Z2hGNXg3RGx5OFBxUDdRM2VLNnRqTlRpdTJuRGpzUk90VUJXbE5Xd05TY3lp?=
 =?utf-8?B?NXp2eGRnaW5pWG1tcEw2Zis1aGZwb2NyRVRqTnJnQkNOQmRXb0wyekJhVXdn?=
 =?utf-8?B?NHNYYm1kVVBFUTNCdEpnWlR0WXk4K0dOc094WlJWay9PdEUxY2RUSUdaUVpU?=
 =?utf-8?B?LzlWT1BOQ1BRZldjdVBvUG5lOUh1RUhvV2RLVmUvRW9sS0s0NVJOSkY0bW12?=
 =?utf-8?B?R3lkTzNiSkRudU1yWVk0d0p6djBQakxnWXRQRW43Q1d3T1dIeUszTUVGQmN5?=
 =?utf-8?B?Q3c4OHpzL0xMRWpSemEwKzdmaVdhcVRheTFrVWpNa3JMVDVGRjZWN2Rsc2lR?=
 =?utf-8?B?aTQrb2dic0hXV2JCOWwyM2o0M1NvM2pscFl1VENIc1o5TG42TUdPZUJ1WE9n?=
 =?utf-8?B?MW9vNVg2ZXh5bUlXN042REVHZWZ2aDRZTDJ3M1NBUVExRVA3cFhvaldZR1JG?=
 =?utf-8?B?RThSbm9LeEJjM0pXeGFDVjdabGl2WkpUY0dRdWVCbVpLTXZ4aWNUWnplUk03?=
 =?utf-8?B?VzJRM2FRb1JSUUs5TFhhTnY0UGg0Tzh6cFREZThCbnoxMUpxOFZLRkdBMWMx?=
 =?utf-8?Q?iHxh8FH3vqKZi9SXEGm4QZ2PDxyFlkvYWLJuYZy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29hckk4VXc5WGFmQ1drTTFkTFErakkrOTZXKzJJWDBqMHZwWmk1K2ZRSmM0?=
 =?utf-8?B?ZzhlVGxPY2dXQ0JETktMNC9mNDdNS1ZzTUZFa2l4OUFvV2xJOFdIRDlvdTYz?=
 =?utf-8?B?MEt6NUFHMXhPeitPOHZVUVVLZnJyNmFpVCs5VXBzM0pKcDFVdVZsbzhTWFdJ?=
 =?utf-8?B?SEFzV29TTGh2QkJsZVNvNTAwb1BKc1lHdXIvSE5jbGc2T3N1UWJlYkVvWUpY?=
 =?utf-8?B?dVF2bWFZc2VnSTczdWNyUDhlM05DTlBJM0hpc0U5OEFMaU1YSVluYTROZUVT?=
 =?utf-8?B?czhIanZRSFNvaVhzTnVxYTBQNkMwZ3EvYTdONitUS1c2WlpmOVlqYzJFUkJt?=
 =?utf-8?B?MEt2M25mSTFDZ01rVCt3VDRoU1crZ3MwS0toNm5GK28yTkYreEJDZFpPTS9C?=
 =?utf-8?B?emVLLy93MXZoM3JVaElqZzZHeU9uc0hEczJIVkhsYnhMK0Z2RkEreFBuTDZD?=
 =?utf-8?B?dUJKZ09OYVhOTHhBbEdaaGxwdElZMGtsRGZocjZrR3VIRUV2NlNERlA4d25W?=
 =?utf-8?B?NGxwRkpMMnJWMVAvdUhlVXpPTDA1L0pqaHo1bzdZWGFRdU1OTWhMbnVNcndM?=
 =?utf-8?B?STVUVG5MMlRjT0kxM3VUMzEvMTF5T3c2VkhMaGwrWk0wOHpnYjhMZHd3NWMz?=
 =?utf-8?B?V051WkQza1djc0tBcThZWWhBbzZuVXEzQ25ldkxrUlVZU3V5RXN4OW10Mnpr?=
 =?utf-8?B?VmVqa0xpOXN1aUhscWVnbDZxV2tmLzFZYnl4TmMySTh1bThwb1cvTGFNTjZ3?=
 =?utf-8?B?NktZZlNNZTB3dmcvenIweitxeE02TFNOMnoxT05oSXFUZWR0SXZkaTlOaTc5?=
 =?utf-8?B?dU5EeTlkTmRiVFVIZ1phR3BsVll4QzUxNUxaVzFIT3BzdHBtdDg3N0NiQ2Nx?=
 =?utf-8?B?WmNFbHZmY3lkeGtnTEZla3F0Vm13bUtUampNU3MrU2ExMFZWSE1BdWRjZ1dC?=
 =?utf-8?B?dnpldjVsc29rUUlsN3RNc1MrcEZFOS9QNHF5SnN1VTlUc25qemVoLzdzZ2Rx?=
 =?utf-8?B?VHUzdUJnQjk5K0EzVnZjMllwNCt5bm96QWRHOHNuYlRmeGJyanpUMGg3bDZL?=
 =?utf-8?B?SkFDU3Z5b3kxRDdlcEVwUnB1TysxZEk2WkxtdEJGUDZtdGFsVXZnU3BnNWZI?=
 =?utf-8?B?bTkrQ3RtKzhZUys2Z0VHL28zQUJWeVpzVmF5NnZzUVQ1TXY0UDNFYVU0bmdV?=
 =?utf-8?B?TFFWRDYrRE5XZHNXQ2owSThTMjVlRURXOTlDSnJORWVZRTM2RFhNamhvbjBQ?=
 =?utf-8?B?aHdKb3VtcytyRDNacWNXQi8yQ1AxWWJDUGhLNlpqNE5ydytLUVlicExhK3E2?=
 =?utf-8?B?QTZtbVpiMEtuM01qVmxGU2xMa25YUDlOMHkydEhyYkdGR3F6bjhiK251aGtE?=
 =?utf-8?B?NFNOQmpzckdjbGhicTI5N2V0M25QVTlnSTNLSi9zRXBGYndGMmZkNURLM1dq?=
 =?utf-8?B?WDUzd01oNm5VbnFBWGl4NXlsa0xqZHNEd1Q3RndvclB4TUw1NWo4QUJJak4x?=
 =?utf-8?B?OEZPUERqWGF6cElsSTM5dlgxR3JlRk4xdEpEbHNGUHNLbUpyWi9yNndnSGxa?=
 =?utf-8?B?SmlFeXNLZDk2V2xJTStrcDZVNExPdDd0Vi9hbWVUK0czNzgwK1JZb3VTOThO?=
 =?utf-8?B?TC9xU09vWjVJYVNWYWJjQWJ1aGNBelQ3T2RjVnZPZmFjYUg1eERjQk53c2NX?=
 =?utf-8?B?T1NydWhKQjNVS2hRdmk3UnQvN01RN0c5OWdCcHpCOVora1FZYU5UNGcwYmE1?=
 =?utf-8?B?UDg3NW9zOXZ2SDFhdUFsUysyOGJXdnhhWm1XbmRCdmJ0ejB3cWtXVGFOM1dJ?=
 =?utf-8?B?VzN4elVhMml1WnJMMzYzVXZnUkl0Z3VTS2NIa1ZHOHNYbXlhUDJ4S3VaUWNF?=
 =?utf-8?B?WlNPOFBsMlNnQVhvLzNxZjhCdDh4QW9GbnRkNlhVM3kxbkh3TmhZMTNwOHNr?=
 =?utf-8?B?NFRhOGVxZTY3b3JRNCt1aDQxQ2pMbXoxR1F4SThDc3d5WkdoRlQzY1JReDBr?=
 =?utf-8?B?N29kdXdBQWxSeWo1WGJTT2ZFTHozbGFpM2xESTgyUDd6cVc2ak8zVkRFckR2?=
 =?utf-8?B?NFdROHNnL2h1MXRXSlpGbHdmNlA0L2VhSUw2QWdsTHN4dTZtUURNMDVvV0dw?=
 =?utf-8?Q?XK7igMkEKp0HEiQy/tMLCnnUo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b59f8a2-d85f-4921-2f49-08dd02c2026b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:30:44.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNJeA3M3az5Oa+0WE6mn4gMjSmgtxK4TMswyTa7tRFr8QXdEe11Dq+9mDzas64TBwjzgh+UjRBEGADvzP92MmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com

On 11/10/2024 10:04 PM, Qiuxu Zhuo wrote:
> Make those functions whose callers only care about success or failure
> return a boolean value for better readability. Also, update the call
> sites accordingly.
> 
> No functional changes.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> Changes in v4:
>   - New patch.
> 
>  arch/x86/kernel/cpu/mce/core.c     | 12 ++++++------
>  arch/x86/kernel/cpu/mce/genpool.c  | 29 ++++++++++++++---------------
>  arch/x86/kernel/cpu/mce/internal.h |  4 ++--
>  3 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 167965bd2ac0..ce6fe5e20805 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -151,7 +151,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
>  
>  void mce_log(struct mce_hw_err *err)
>  {
> -	if (!mce_gen_pool_add(err))
> +	if (mce_gen_pool_add(err))
>  		irq_work_queue(&mce_irq_work);
>  }

The polarities of all the return values have been flipped. They all look
correct but took me a few minutes to figure out. Might be useful to make
a mention in the commit message if you end up doing another version (Not
needed otherwise).

>  EXPORT_SYMBOL_GPL(mce_log);

