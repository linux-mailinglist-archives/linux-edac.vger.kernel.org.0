Return-Path: <linux-edac+bounces-3102-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D7A37C9F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 08:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A716C504
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9019ABD1;
	Mon, 17 Feb 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJVnYlc+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECE19ABCE;
	Mon, 17 Feb 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779105; cv=fail; b=fnWvbphk+zB6wSBl1srC2P6r8H7Hn/viq2b5vxv9hYxWgUoP9nDlLQDyFKl/RBhf8DCN+OPtamlH3dpOJOE8Xlgbajkygq6T6gw6imCn/I6tbGKGlJBW2IF1KKj3s9G87/dTtF7iO0CYCNEMde8ExBWftMK8nik79LDUdtm9w1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779105; c=relaxed/simple;
	bh=QJzuzTYgstXwKjzp2qLDVre5WEvGdmuujKTeZwT1tNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IcICnS0lM0W+hnee0bcHUPgTrassVzcDQ0o9wqxpMpgBc6fTAtHtknzwzc60BI49+UnJ+P0yQiUk617jrguTZedH/nWlFNA5WNBemAtpynyyqpyekkajlzbNg0XX0D++LohdrhR+fN8hQn3F29UiIO4zsXsVxkO+zeqjVlHq7jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJVnYlc+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739779103; x=1771315103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QJzuzTYgstXwKjzp2qLDVre5WEvGdmuujKTeZwT1tNI=;
  b=fJVnYlc+i7FPcVLLgcgA+LDPn2L1+A6Bjy+CPI1xggLoGzjSUpQ3l21l
   xzKAMApGVRq0zntiuohYYeJfGtEQK4jXCfLV2A3GZMunAm3GIda8QU1HH
   6Nmkq/2GNMryiRuWT+Y2LBnRbN8LJO7nO9KNDbwTxrn8JZFcYnL7+RuvB
   HuvuoJDdoAq9q/QR9n0jjDfPgvtGSp/pw0fAuMK3NnlHe+b7z9S0qStUv
   RrwJdhKm+LyK37XHyZGiFyiU/F6mmANf7B5DPPj1w1lh+vaOj7BHB+mzG
   yFIKwMJCntgh2hc5r0jxfgslhgYNcCXfgqq2sVE/6eTs0Ft7iKHx2dC3+
   A==;
X-CSE-ConnectionGUID: GN13QzcLRMqAXLMB9SSq4A==
X-CSE-MsgGUID: IykSxQBhSiez3AwZjujtMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40589220"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40589220"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 23:58:22 -0800
X-CSE-ConnectionGUID: a7dKYkg3SSOz4vQqbeax5g==
X-CSE-MsgGUID: g0VU33BiQrSXWPGBoIN8dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114678908"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 23:58:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Sun, 16 Feb 2025 23:58:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 16 Feb 2025 23:58:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 23:58:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TinxAHpBjVcmqvbykLI4x/EB7iTr+1KChs33nYKL87hO3nQ6iyatRlbvts7ZIn1ZOEjaFwRZlhaBpaImVbj5BjE8Rj9tAmi8gpXmiqMBfEd8OT9FqKzJuIS0n6FqhD5Gw+3uZr/7+9a7AnwmJAlgxBrrp4tuxLQ92YBqRPY2N7zfmE7YbEXkKtZl7nyRGK10RPf4M9jfw+I0tDPIylmTvKRai1ClNcUFvX7jzRa2HmlwWqsvlkkX12XbcDXqaazzwrLiiMJmVVDrwuB7cnkg1zW/0jRTJ/4toiTigoK1irAr6EvTCy8QzBIFSvCrfpteurg0iFmqVPDE5TU44qSnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJzuzTYgstXwKjzp2qLDVre5WEvGdmuujKTeZwT1tNI=;
 b=TGlHqY9XDNkh703cKRA/MMpcr8laxtOUnEQ2xYRyiD0T5+Isjcb7FddBSyQ18ieVE/dwCKebCV7S1zWH9tuugN1dLrcUNAfQnog+nRWnucDXB+rWChTyHD7uxsyy3oupAKf541Cgc1C4zrPksfbw6PEMfEl97DqbcLhJRpLMvkF85TGbg48L1rWgcgQNwaLFvS9TvoZeZ4m7tP5s0v6/oCFsEg3mDpuMfpTuzPKykQIkxfJlk5ZTaOAMYuPrdSzixcbngEiGD9Ddh+QVzucHYNYqvcrtlCAEzT1I+P0WsWtJTDhbjI810Zp1yD0lXbM2XXpqA/CB7rk8a+7VDOQoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 07:57:48 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Mon, 17 Feb 2025
 07:57:48 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 03/16] x86/mce/amd: Remove smca_banks_map
Thread-Topic: [PATCH v2 03/16] x86/mce/amd: Remove smca_banks_map
Thread-Index: AQHbfjesm7v8+hFKp0uXrLWAGZ83RbNLJDFQ
Date: Mon, 17 Feb 2025 07:57:47 +0000
Message-ID: <CY8PR11MB713439C32E76A85C09C666BB89FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-3-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-3-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB7564:EE_
x-ms-office365-filtering-correlation-id: fd39169f-9f05-4dd8-d26b-08dd4f28c515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2EzeVQvRVFFdFRCcVBFSXErY1d6Q3NrNU9vLzAzOEx4Y0tTaERRU05tREVo?=
 =?utf-8?B?Q3pkUm5BU0grbklhTHNxMm9XTEYxSnloZ3dJZWJZdkh2ZWJ4N2tGL2YzVGVi?=
 =?utf-8?B?NTV3M2pzY00rZXlTNzVDOFVaNUp6TW5DaWdvSVhtR2JET1FPMmR5cTV6Y3hp?=
 =?utf-8?B?czJpeThUS1dwOHBRYVE1eWxmVHFjTWlBRkY5V2xKTmNOVk81YlpKam9mTTB4?=
 =?utf-8?B?WUU5aFc5OGhYV3VWYmJwUVhwQ3RDSmhCazdjMDZiRnZUSGxFN0lrMVNqVFI3?=
 =?utf-8?B?bEdUMlJleFB0eVdoUURpQ01ab0NJelVyTklmYnJCLzllMWlkczg3RU9Dd2xZ?=
 =?utf-8?B?Tmd5c1YydEpzNmx1cFdKemhFU05rNW9oWDBNUVc4STJ0SGd4WmRySHpoQVM0?=
 =?utf-8?B?MzkwYU1OZE0wbjQ2blRIOGZqZ3VUeFN0Z1RQWjF4UHNXcW1Td3MrU3VsT21a?=
 =?utf-8?B?RkY1MXpWd1hrb3VsWGxicWNiUlY4ekczR2V3SjJ2azEvSXdNVEcxQ0lPYkpR?=
 =?utf-8?B?TXBJOVZoU1hrRDdsU2M5a2ZyWVJaWndydFB0NzZrRGZwbDV5L0ZnUmpQUU5y?=
 =?utf-8?B?aktqZmsrbzYxSm43NGU0UldnSWdCQlFJY2NJT2VVUk00ZTFtVmlQMkJBNHJ5?=
 =?utf-8?B?YjQzcFBxbEhBeXNlN01YS1NJS0VheUhEQXJybUhmNFUvVFJ3N0tPcWxrb3V5?=
 =?utf-8?B?cWRoWG1reWROdTYwZkwzWGR0RzVQZHVHcDB2VFRZUENZWmozLzdpWVJXdStK?=
 =?utf-8?B?UjI1cGFocDdUQ0VPYmxxeEczVW43L2VWTVFXM3ludUdDeUFDQWJINDR1OEdU?=
 =?utf-8?B?K0xmYlJ2ZC9Ncks3RlovTFptQnZET3dYTFdEVmZSbFdwbk11VkovWkc2eDBM?=
 =?utf-8?B?NE1VSThLbnhPdjBYdEViRG81a29FRjFJQTNWT0EvZFZsNHlxNzVUbXlTeC9n?=
 =?utf-8?B?WWx3TmpDeVMrUy9JZ21TN1NHQlh4N3M5ODhQQUZ4NVZNMDNrTFc2bUtLYWh4?=
 =?utf-8?B?bCt2U0g4U3JsSDh1c3kwNkxRZHZjQmpORUljWXRJZFc4UlZ0NjRQT1piUkdQ?=
 =?utf-8?B?dm85N1N6RW5pazZ5WFZuTEQ2cm44S2JzN3UwcHBSNURwSmRUSlZrdkdIdGxt?=
 =?utf-8?B?RUZ1eGJpRUxxcnYvdG9MOTZoclZkNkFLQmZ1VXRsRTB2enQrOHc5TThCMUJX?=
 =?utf-8?B?eEJBbGlQZFVPWjhXbjhjVmFjbzlreHNaYnJGVG1JNEVtZmswc2U0SUJiRDN2?=
 =?utf-8?B?YVB6dUY4WldmZnAxMUZPTWJYKzVKcDJaMnNpcjZNUEpEU2pZK1BqMWZGNEEw?=
 =?utf-8?B?WEVZN3hCV0liMS9rMkdjM2paYng4VkxtelZxWWFJbjBlWlM4QWZJcHVVMDM3?=
 =?utf-8?B?SjNtUHhJNjcxM01ndzVYTkhEbW9qZ3RJVVJZWThjVkxkcnRrRXJHWlBia3JW?=
 =?utf-8?B?ak4veGlpSUc3OUYzbXZ4ZkE3MFpWdmNTcEhkZGt4WmZ5c053N1d4T2MyZm0z?=
 =?utf-8?B?d0ZyOUloZEVkREdPeHJZaDdnR1RQMWZIKy9EZGpoR281MzEwK3p5STcxV05G?=
 =?utf-8?B?ZEtrSm81dEtiTkt0ZDkrSDFNcXBRcXN3ZS93Ym5qSWgraFJJdytkWFlnQUpN?=
 =?utf-8?B?ekF6dFFrbUI2Ymp0MU9naU9zYlNwNFBLeWtpREFERXJ3MzJSczA1aU9IcnpF?=
 =?utf-8?B?amNWY2dHWW9yNW5aWlFBb1ZTMkVvN0lNNlRETXhBZ2s1a0k2M0pza2dGR0pO?=
 =?utf-8?B?bkl1M2pidkVTZ1JkMDFPUnNSOVFYNE1pcjk2aHFFSUJ1bHNzK3ZQYk53eFI4?=
 =?utf-8?B?TkdkYkk1b2RNYmZqdnFMTkM4aWFqTE95MlppMXJRZ1NGaDRPbGhGV0d1L1hP?=
 =?utf-8?B?MUpTYXpKTlJvUFd1NStTbkdiekxWOVJTYUU2WURDbEVVVStQZXptaE9uMFdn?=
 =?utf-8?Q?63mPvo9mj/U332HbDSS0rHy36gyJjWYZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHJ2Vm1LdkZocHBnWXJpanZ6dGd2c0VTN016OFVLYzBHNCtnRkFVRlNEa1pa?=
 =?utf-8?B?M2M1U1E0bzZuZlVqM2x0U2x2N1M4NEhYQzJKZUFacVM2ZHRVZG05VzJLUEVp?=
 =?utf-8?B?c0VteTA2M3F5dXR5Umk5QWsyQkNscVlmRmszNTl3dnZxY3o3ckFud3JFRU1z?=
 =?utf-8?B?WTducGZDQjdIY1RYdm1iQk9EV0ttSWlJV0pXVnU4dmlRdmhnK01OOEZVblBm?=
 =?utf-8?B?YktpSjdlN0F2eGdLUFpPZkg2UzRjNklCT0llQ1FieHIvNHFvbDJkQ2UxQW1z?=
 =?utf-8?B?SkpxNnBsWk1HYVAyRnZ6UysyME9xY1pvaGZaS3RxTVlIMlhPR1FqeVVhSFNF?=
 =?utf-8?B?Y3d0L0tqRVVzZGlyak4wR09ubWxFMC94TGF5aHdxVGorekVYcml2dWQ0UUpi?=
 =?utf-8?B?MlIvaTlKQWdWNHo0bzNoMk5FQmRyN0xVOVk4QlJ5N1N2RTFOTnoybWdNVGp1?=
 =?utf-8?B?MHJyeDZYQ3pMRjl6MlRacWRFV2piUTQxMkcrSUxxb3hBQ1NudkhYMGtpeDdL?=
 =?utf-8?B?c0x6TWk1SUpFbkU1dkJ0WGlPTWE4MXY4cWNON2lqOFl2Yk00TXRGS3l2UzAw?=
 =?utf-8?B?VzIxKytybDhBUGdqdSs1aGxZT1ZQKyt5Zm5vRWtZT2k1SDUrcklvalBQam5k?=
 =?utf-8?B?UDNXTWNDdjQ0QndJVjBpTDVUTWU1ZlJpMWlVc0lHUVNPL0YvQjkvbnZhcE9P?=
 =?utf-8?B?N0xQV3p0bWErZWQrMUF2cnVNbXdOV3FWdERoOEg3dFltenJOR2JqSjhqL0ps?=
 =?utf-8?B?LzlDbzk1MDZHQ1pueTlHMFRiSUJkTDlNdXQ3L1NCL0RXMTNTbjBCQ0k0L0Yy?=
 =?utf-8?B?NDNucGJMVkMxRS9BSWFTdFBQRUhWVjNQU0twb1QxMjhSWEJsTjFMOG9scTRR?=
 =?utf-8?B?eEZqcXd2b1I0bVpWVk43WFJpc1IvalY5YmQxODYybjZ5T3J4S2RkUnhkN3Fx?=
 =?utf-8?B?aTl3TENFTmxYZ1F3ODJYWFlFdHVieTRqaGpUb0xYWXdidDBJcXFmaG9wV1lz?=
 =?utf-8?B?Nlg2UHcwQnNISnBFcnZEN0V5dmYzZGVXMVJVNVJWcGxEdXBtMk1OblRuWWYv?=
 =?utf-8?B?bmZZR0dVUldvQkUycjBrM2hVY215R1VmOVRHWC92MWZqUlV5Z04rdUxWSVZR?=
 =?utf-8?B?TmVEdFcreVdaTHY0SUJiWFVYcXAzdHl6eHNuSFRjTnpsOXlFN0pNeXJrVlpp?=
 =?utf-8?B?QzQ3M0x5MUdrNGs3OEZUM053YTVxMEViaEdJTEFqVFRNbUZrWjF3WW1lY2Rt?=
 =?utf-8?B?dFQrb2NsRW9zSzBFcVYwNk4wMGw5YVoydlYyV0toTzl5bDBldUk4SlUzcERZ?=
 =?utf-8?B?Yyt2YmtCMWVCMmdOUXRqZEYrbzl4UHJCZk5WTFhpTG55VjlQa3ZwUU15Yms4?=
 =?utf-8?B?M0FQR2lrR2VXajlraFQ2L2s1d0pOb0d5MFVyV1BOd2ZaSHNsZWZFemduU0ox?=
 =?utf-8?B?U253WFlSNnkzbkVYa1l4YTdGVDFoeWo1cTl5Vi9ES0xCNndac2RHVUswMTJm?=
 =?utf-8?B?czR2dGoxL09QalgvS08zUjRqSURRYmVNYWw4cTFpVW1PK3AyaHhRdHptTWZ0?=
 =?utf-8?B?RG5mTjN1T29FTDNKK2FaVFRzNzRkWHl2em1vTlBjMGNVOHZOVGJHbmZSdklW?=
 =?utf-8?B?NVBOUVBCMHVGY1JBRHZYSi9TNVR4NmRsRnJKK3NrUytod3JWZHF6ajV2blJT?=
 =?utf-8?B?YUtjb2kyVGRZQW1JLzg3anRabUNSdSsybGxOcmpjeEN4OXNmSXdmbStsdWFQ?=
 =?utf-8?B?a2pRZ0dCTVQ4R24zTTRZaVhXRWMyaVFkY2Vod3lpeEY3U2gra3NTazlzVWs5?=
 =?utf-8?B?Z0Zoazh5U0F0OW9TcEMxQ1VycGc2ODNIaFJVb25QUkRpU1VIeFV0amdHOWlZ?=
 =?utf-8?B?NXBoc2tTd05xYkdvK3hNQVFxTy8zTlRDMDhqZm40QTcrcEZiWEUxdXoyNkh4?=
 =?utf-8?B?YUN6SDkzbWtNYmgxcy9JYzgwTEhLNWxDNDZwNm9oNm9iVXRxd01tRXNpKzB2?=
 =?utf-8?B?R0V0TW5kWktYRHozVWRUVVBlUlo3NUs4YlhFQkxRZ0pCZkkzNHdWR0d3d052?=
 =?utf-8?B?SVBTbm15cElzR3pNRmVvbXgrNEpzcFlOY2JydFZiMjNwOG51TytiSVg3WUI5?=
 =?utf-8?Q?fqHiyLZnjarpvjVzAIEPrM8WK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd39169f-9f05-4dd8-d26b-08dd4f28c515
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:57:48.0125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Na9ELKjthvivVWdW7gF2uPEw35mHaOlkHL5N08Ts92I71Hehe6aH3vr6MkCoh9ETd91MR88EFERy2Hjr/+wjXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwMy8xNl0geDg2L21jZS9hbWQ6IFJlbW92
ZSBzbWNhX2JhbmtzX21hcA0KPiANCj4gVGhlIE1DeF9NSVNDMFtCbGtQdHJdIGZpZWxkIHdhcyB1
c2VkIG9uIGxlZ2FjeSBzeXN0ZW1zIHRvIGhvbGQgYSByZWdpc3Rlcg0KPiBvZmZzZXQgZm9yIHRo
ZSBuZXh0IE1DeF9NSVNDKiByZWdpc3Rlci4gSW4gdGhpcyB3YXksIGFuIGltcGxlbWVudGF0aW9u
LQ0KPiBzcGVjaWZpYyBudW1iZXIgb2YgcmVnaXN0ZXJzIGNhbiBiZSBkaXNjb3ZlcmVkIGF0IHJ1
bnRpbWUuDQo+IA0KPiBUaGUgTUNBWC9TTUNBIHJlZ2lzdGVyIHNwYWNlIHNpbXBsaWZpZXMgdGhp
cyBieSBhbHdheXMgaW5jbHVkaW5nIHRoZQ0KPiBNQ3hfTUlTQ1sxLTRdIHJlZ2lzdGVycy4gVGhl
IE1DeF9NSVNDMFtCbGtQdHJdIGZpZWxkIGlzIHVzZWQgdG8gaW5kaWNhdGUNCj4gKHRydWUvZmFs
c2UpIHdoZXRoZXIgYW55IE1DeF9NSVNDWzEtNF0gcmVnaXN0ZXJzIGFyZSBwcmVzZW50Lg0KPiBC
dXQgaXQgZG9lcyBub3QgaW5kaWNhdGUgd2hpY2ggb25lcyBub3IgaG93IG1hbnkuIFRoZXJlZm9y
ZSwgYWxsIHRoZSByZWdpc3RlcnMNCg0Kcy9ub3Ivb3IgICAgIChzdWdnZXN0ZWQgYnkgQUkg8J+Y
iikNCk9SDQpzL2RvZXMgbm90IGluZGljYXRlL2luZGljYXRlcyBuZWl0aGVyDQoNCj4gYXJlIGFj
Y2Vzc2VkIGFuZCB0aGVpciBiaXRzIGFyZSBjaGVja2VkLg0KPiANCj4gQU1EIHN5c3RlbXMgZ2Vu
ZXJhbGx5IGVuZm9yY2UgYSBSZWFkLWFzLVplcm8vV3JpdGVzLUlnbm9yZWQgcG9saWN5IGZvcg0K
PiB1bnVzZWQgcmVnaXN0ZXJzLiBUaGVyZWZvcmUsIHRoZXJlIGlzIG5vIGhhcm0gdG8gcmVhZCBh
biB1bnVzZWQgcmVnaXN0ZXIuIFRoaXMNCj4gaXMgYWxyZWFkeSBkb25lIGluIHByYWN0aWNlIGZv
ciBtb3N0IG9mIHRoZSBNQ3hfTUlTQyByZWdpc3RlcnMuDQo+IA0KPiBSZW1vdmUgdGhlIHNtY2Ff
YmFua3NfbWFwIHZhcmlhYmxlIGFzIGl0IGlzIGVmZmVjdGl2ZWx5IHJlZHVuZGFudC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCg0K
QXNpZGUgZnJvbSB0aGUgc21hbGwgbml0IGFib3ZlLA0KDQogICAgUmV2aWV3ZWQtYnk6IFFpdXh1
IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPiANCg==

