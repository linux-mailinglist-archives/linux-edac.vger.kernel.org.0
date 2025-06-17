Return-Path: <linux-edac+bounces-4151-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC12ADCF8E
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AE41899304
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECF2E7F20;
	Tue, 17 Jun 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRuIhPCZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9C2EF655;
	Tue, 17 Jun 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169403; cv=fail; b=ifDhbAZhooyTl+DTO7ikcSSkLSsp3mSm3F7JqDCCaCw7mGlMAST9Lg4fSjbI91OG06eAgjLaX/x+g7iHhHb5JkdpYQg3D2dWrgLm59jtUJkq1aJWbnJQggvJTP1UtIZSz8uhLfCmpzO0P0tU1EZGYoNjTrJBYdX2uBCg7DnSJ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169403; c=relaxed/simple;
	bh=PSD6g9Ddh98W4sL+JQ+NNU6/biSCNnQxX3yepCcqLuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNS/yhgG7iJ5L2WL5pwX9m+4NdL7nYvGC2qaM+2uFPLVDgXdMwPZUAOA1NNa4CQpY8rdkSEg09L2FbpQ51mxs3oZKRgHhBy1QbnqADVNGfVB7Cl3YUABnpIQnni2WSHSvIji8jtF3ioox5RNzke+1T5ZT+mwrOu+VpVPFlU3e7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRuIhPCZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750169402; x=1781705402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PSD6g9Ddh98W4sL+JQ+NNU6/biSCNnQxX3yepCcqLuE=;
  b=PRuIhPCZumemoW9oC+OhfSiIeyQXlcRMD/+IDdM3Vf46PnNtD3KT1P13
   lOicOxM+j2FTwcFSV79seroIBGU0jJWKaecL4f+Cy/xjzWvZgQGfFUQyD
   m+G2d1fHPgmW2UhfgnIRZaXw/L9Gfp2JbBPj8YhN1CFwAan5//UtAWMpX
   f35GG9H93nEihQfbu9/9Mhe0sHy/uF8KFbdbOrE8iSWkTyDnS8OqfphLx
   0soqCf8tLHztK3LA1ON1zeqvJo0eHkJRWeGm/LlUHY101WtcldWQ5prgR
   EEkVaJND0y8njQBcIxLzFuzEIrxv+Ms+FswZxn5/0fv44dOcNC49G+W7+
   w==;
X-CSE-ConnectionGUID: BwWrBN7URJab5VTVLb5xcQ==
X-CSE-MsgGUID: IZsWqNobSqmPPYoOuUr9RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52220903"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52220903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:10:01 -0700
X-CSE-ConnectionGUID: RzLZ0W4mSfO4DqleWpXPFQ==
X-CSE-MsgGUID: 8iMBtmKgQNGYaGfHRpygFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153996639"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:10:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 07:09:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 07:09:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.85)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 07:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8J+ev5eGVG6WTCmIx6hP7QJjimsP3DDnINrA9Z/us+5VmxvT8TQMU8F0jG/NkHxR3qbTEytJastUbiPu42IC/HO2Un3bkswVQAY/nZ/oMUT9orC2vdrwUaSh00JuGZIujNi/0pMy/wmlwo5TIohd8sqHDOFjGYZJsSaxvc8dF12BWh6bp2b3PEEicd7nTDcUqfscKiIVVc9d5g4SZG5r959rwDYYvcMtyKfiQ/S4BlcxZFDeIRBx/DVHD2eSSPt0lp6a7+v95BHiWSgqjGRD0PW66lPPHnBo2ZtHgIWVqyfnqnBjXkKhveNDwJ8eSGGhHzk4V5uRbu7eKSfCCOWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSD6g9Ddh98W4sL+JQ+NNU6/biSCNnQxX3yepCcqLuE=;
 b=paBJvWccVS+q80sEpfJHEDCNnHFSGYQcRoQqEe9P+bq/57aOhvuWnV1kgvd24CGoCYGuyaHi3VQzbbgqLMpdySIVe8cGxecsGXYZxqWHmz8QRrFrLGPRqEmaA+ybNzU1E9tAF5xonQuQTX2VTw7JfZyAzTMqbs4GXGEOBwAGOIuV+3q7smA7J9DGQbnPdHqlRC/1+2quU9roUC1Pp/o3tZqcrILrFL5+3gkVM1/N5xlWT7yzzGLwYhCvClfw12fiazT+rbASUAeXgNhqbvO5KhqZL4y98h+qTMeBrNLOeB3S4Ecragn66rxwqp2FbK4nxco9T1H7WlCfwlurpVFvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB7138.namprd11.prod.outlook.com (2603:10b6:806:2a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 14:09:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Tue, 17 Jun 2025
 14:09:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC: =?utf-8?B?TWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tp?=
	<marmarek@invisiblethingslab.com>, "open list:EDAC-IGEN6"
	<linux-edac@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: NULL pointer dereference in igen6_probe - 6.16-rc2
Thread-Topic: NULL pointer dereference in igen6_probe - 6.16-rc2
Thread-Index: AQHb33j0iZ1WW20c2U63eSjoy98u17QHPvOAgAAUdvA=
Date: Tue, 17 Jun 2025 14:09:42 +0000
Message-ID: <CY8PR11MB71345FDE3DF74BAF97B563F08973A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250617115707.GBaFFYE61vYHNuAkxR@fat_crate.local>
In-Reply-To: <20250617115707.GBaFFYE61vYHNuAkxR@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB7138:EE_
x-ms-office365-filtering-correlation-id: 8e64bc75-2d94-4c90-6876-08ddada89ae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGIvNFdQeVc1OWdCRDJvQ2w0elVwQ1FwSDZoUGVKcTdqR1d2NWM1YTBaVncz?=
 =?utf-8?B?dDF1RkV4Q1k1RHIyL2ZXMTRtbEdiNmZWVHc2anJad1lZRXZwNVllMXczOWNa?=
 =?utf-8?B?NzJ0dTAxQlZ3YjJ5N29ZZVhJMC9vRmpoeGRTN3FDM095YVJxYytPNVdNakF4?=
 =?utf-8?B?VU5sN240T2cxc1ZKRHlxSVJod0xEeTZJUno3UEZtSXVCQktmNGFYb1dDaTQ1?=
 =?utf-8?B?cFBrZzhJbzRUSWNJVk1NamlYUlZlZXd4MkZ2MloxcDR3QkZGMzBKRnZUN09G?=
 =?utf-8?B?L2g5MmtmazBOODIyRWsvZ0NiYklBWWtPZU9RaitWeHNjN3JQbDVxak1uWlZV?=
 =?utf-8?B?RDdlamJtYzdWWml2aHIrblA0QkVmWERRREpvanR0bnNRK3NGYThrRllXRVIv?=
 =?utf-8?B?c3lGME4yR01na0pQRVZMaWtlUWR2YTc5cGxNUG1RdVduOE50d1NBM1ZvZTRu?=
 =?utf-8?B?bllzZGJpaThPKzRTWUFOUFRsaEFVUGRGaU5VK21sbU0wQ3hROUZhN3NHKyto?=
 =?utf-8?B?TDdQd3NLWndJcXlKemo1aDAzQldFTWlJR0R2NXRpQm9NdmFJRXRLWkRnV21C?=
 =?utf-8?B?ODdUR0tPMDBwSUgxSSttRTlZTVpEbGE0NnM1cEpnbEdWalRSNElPTVRQb0hi?=
 =?utf-8?B?TWd4dGpEU2dsMkwwa1lRSXJnbXNrRkhnSkpTSS83ejBUV1lxazRwYXFKWWw4?=
 =?utf-8?B?bExyUkNjYXFRSzRLa1ZBMkM2b0RCQTB0ZDlveFI4Ti83QTBQTjVXdWUxdFlm?=
 =?utf-8?B?dTBnckcwTXlCamQ1K29yTFdBY05BTWVjOWE4aDFLblM3V1QxTGtMSk55QmV2?=
 =?utf-8?B?eU81S0RacVpxRGd2SlZ4Mm9WamJPSFlpUlJuc3c2UlRESnF1bjlsczFyb3Zr?=
 =?utf-8?B?b1AyVG02ajQ4d0RybGNsOFg4aVBLMm9kUzNZTFNQMG51NzJpRnBjSTFnRXdy?=
 =?utf-8?B?RHlERyt1cGlLUFhvcjExcEx4cEk4Z29wOW9RU1pIT0ZwZG0wSmFwMGVGNHVm?=
 =?utf-8?B?RVdpMmY0ZE52YmNSNit2a0tzcVN5enVKTjE3ZnRsZ3czdzRKbHNTTVJUNjRR?=
 =?utf-8?B?VmFVUEkxTWt1M0lobUFmODV3bkYxY2hLUU1FRlhMYi9pckpGcU56dHgzK05o?=
 =?utf-8?B?VzZpZ25QY2ZxckhialdjVGx0N29sQXpad0pWYi9UdXNFd0tOZXhxY2xuYzAw?=
 =?utf-8?B?cndna3UzMzhLSWxoZ3g1RWpiWFVkRFg3cUJUeEpVN3B1eGFETEUyVk1GMk5N?=
 =?utf-8?B?eHVxb1h2VWtsdm5PckdldFgvVmp4aG9HVisrVXNrbU1DVmxhY1F5eVhvM2tM?=
 =?utf-8?B?WmsxK2UzL1lkMjNXKzlQMUVzcjVEOWkwVUI2NjJ5Mm51SmlmYy9ZTjJyaktV?=
 =?utf-8?B?SHBRTXpzZ09sbU56VEJndDBKTnYzL3EyeTNOcmZ3L0Z4ZG94NDN1dWdWMkhB?=
 =?utf-8?B?UEc5N2lYWHJZeGw2U1oybmVWUW82R1o2R3BObEU5ek5uWURRQ2RZaXZXOXlD?=
 =?utf-8?B?eTB3Ynl3MGgyTlY3b0lZSVFRKzU5bzNVWHBvT2h1U0NzZTNCNlFPNm1Ja281?=
 =?utf-8?B?S01RQ2RSc1pTRHR4ejU4V3hRZ2w0R2ZYYTg4cUNBRFRMbWcyNUdaQUFNT3pr?=
 =?utf-8?B?UFdERWFsUjJHSHkxZ2lZTC9sQ1VMK3hCOXhNMGJFQkJNbVF5VmV6WEJYdWJO?=
 =?utf-8?B?YTREOVZIYU5PMFEyUG81QjhQK3NYZGxvTkp3QWo1ZXJwdnRwdUFDc0xVMWRN?=
 =?utf-8?B?bzRwSWtwN0J0TUlDU28wa25jS2Z4TEZSSnZQaDlGOXJKNzAxVGxBeVI5Yjk2?=
 =?utf-8?B?cEVoUHhIb3dYUlpuN1Y0dEhxNFlMS2YzN1hVQi9pS0JHZDVYOWVjcXkyOW5u?=
 =?utf-8?B?MlRaT1RTc2NvWVhXdUNqRzBHeU93c3d3VDZxdkFWVWtwU1cyZ0hyQkxQVGZ0?=
 =?utf-8?Q?7xeSrwFtagY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTY5am5zZ0w3dktjM1phZDZ2RjRIV1o4ZVV1RTFWS04rVGlWR2h2ejhzWm8y?=
 =?utf-8?B?b3VyN3ZLMkFhSloyNXBmR1M1a0M4NDhrV3RzbHdYWFVMTWNsb29CbUVDVjlB?=
 =?utf-8?B?VzRGMmdWQWFMUFlTZWo4c2VxQ29BdzE1amZRa1hDT1JPaUtNR0ppZjAwYWhK?=
 =?utf-8?B?WURUS0h5ejVmQ1Zzakw1T2VDOGRCZlMxNVZlMzdiOFNmZVNreEoxNkZYQTBo?=
 =?utf-8?B?QUF6cmZGNGdVOFJCS2VVRGtyWjFWOHBteTVJN3ZJcVpjdGZEZFR0Z1ZLZDho?=
 =?utf-8?B?QW9nOXRmK0srNHo2N0FHKzF0TWY3U2hkNm9oNUF1blJaSmZEWmhvTmNIcEVF?=
 =?utf-8?B?U3hJTW1Tam5jUHhxMGw3T1JwZmE1MzVYelN6anZMQmc4MksreW1XL1UvYU1y?=
 =?utf-8?B?UlRnSjE2ajM5d2hQM1FaUDR6VFQzUjZkbEwwQ3ZjZktDUFk5ajJlMldnV1NE?=
 =?utf-8?B?dHd4dVIyejIxSFM3TllWT0o4K3RhOXhTN3VycUFLK1dNeDl3dVVJcEZLTlM0?=
 =?utf-8?B?MDBhMk9mdGtzU1JNWHMwcTZQQTBYUDBJd1I4MjFmNEIzRk5NaGwwUnhGdzN0?=
 =?utf-8?B?MFRENU40ZU1nTmp1czdIL3FEcGZCeEZBazh0US9hUll6UDFhaEp5OWRlTGM0?=
 =?utf-8?B?dU1JSXY1MzhKcjI5NHFmWGZvd0NJelVMazJVcjNNNUJ4QnJ1UnY2NUdFODVD?=
 =?utf-8?B?UGJ0cVdqRmtqMElTaHkrK05KOG9iM3hGRVB6VjZwU29zeEZVQm1BYjNVLytu?=
 =?utf-8?B?NjFBVWl5ZkE4S3c5VjBQdGErbll5V3hHa2ZKbG5MSmxDeWdQcG81RERnTDlW?=
 =?utf-8?B?cVc4YURWcms4N2RaR3QxNDRXNWkyOU9OWWs1SVY4cEppaEp6YXkySjV6M1Zr?=
 =?utf-8?B?eUhqY0MzMTlLYjJsYkF4c0VYV2IyZHJZSzI1ampweFdva2htRmNkSGRNak5n?=
 =?utf-8?B?amZVVlpqSFpDYytSa0hSdm5uL2dPVVlTUGZOS3JkZDVIOVRzY0M0UFRiU1lu?=
 =?utf-8?B?RTc0ZHdPV2QvT29PejJER0pWRWtFbHdESGl4cjJ6emcvMDZ2WHVJRHhNNElt?=
 =?utf-8?B?QlI2UGRtS1JRNWV3YzFxSU1LR0R5QUJVYUpLaGpGNkZoWmZ6bWkxRFNnaHk4?=
 =?utf-8?B?bFRXb2QvZkZuMHRCZWxOakRsNW5naW9SNGNhYjh0VUZRQ01rTlF4bXphQ1dC?=
 =?utf-8?B?TmRyejdVL3ZUa2xLdXBtMnEycW9nR05RamxnVkMyOXVPQlFCekZ1ZEpqeDh1?=
 =?utf-8?B?dDVxeEVpYlVvNms5UzdwV0FOMzUrRFIvNFBsTVF6ek5ER0lPU3VFcVo1djQy?=
 =?utf-8?B?NjltMkFqOWlKemxJeis1eWdLZllYb1FXQmRMWVk5bEhRQnN5S1plSmpmNWRR?=
 =?utf-8?B?eU5yblNMUm5YQ0VDVHNMb1dSdEhKZGZnR3hISmxMM1BpYWZGdWpRR3psWVNC?=
 =?utf-8?B?U2lEQzM1REEydzlMNklmRmo2OUl6M2pPNDg2SGJUaWFDRCtQWDJNOUdkVTJT?=
 =?utf-8?B?dncrcHFGTUZGRGYxRXVGN3MybzhDWG9RcVkzVTdWNFlDWCtlNEVnUW83eFBZ?=
 =?utf-8?B?M094TjdycHFnNVEvTFpwbWRRamFpUnFzRXZPZkhjenJwTWZvekxuL3U0b2Rs?=
 =?utf-8?B?WDFBYy9xVkY2eHVFTTJHdWxRcXpER3dPN2srS2hQb3B1eFcrdDYvdUdwNmVE?=
 =?utf-8?B?VGJrQmR2VFhhREJiSXhDanlabXRGc0pXUnVIWVBCMnd2WVRRKzBwTWxsUks2?=
 =?utf-8?B?bkViYXVHeTJQK1pFMkFnbjZZYzMvTHJiS0NaTFJlS2dHY3UrbUNFd3BNeEov?=
 =?utf-8?B?Tlg3TmdTNEJFTmk3NTlpSGJUNzY5SzEyVmJlY1JrVUx1dFYyL0duRHVlTm93?=
 =?utf-8?B?NTJkNTJZRGxmcE9idFQrbTc0eWdSZ3MwTzF3SVBBcGpmdXMxK3lFK21ucWR0?=
 =?utf-8?B?a0JVWGV3N0lyV3BUT0FqazFBMTJBZkg5S1B5L0Q2UzF1NzdZcCt0eDJDcGty?=
 =?utf-8?B?cU8rZVVUTlpoTk9wY0tzaFpMQUFGUlRkbzF4RjZSVnlwb1pYRHB1UUZTcUtI?=
 =?utf-8?B?VHZZZ1NvMFBaVzgvZ29xRFdZZU8xdzYwNm4zSDd6SUhtSHZBTGFXblJFR3hq?=
 =?utf-8?Q?KvtmNoN7YTIHk1pPDLbssCXWb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e64bc75-2d94-4c90-6876-08ddada89ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 14:09:42.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afVq0W35T1OqpnxeCapdnLiTBrnRjLo/YRFXP685UYqEgKLhK8yGVQJjsRT3XiagiyLi+ANUz0mDGAK3t3BySw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7138
X-OriginatorOrg: intel.com

SGkgQm9yaXMsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFsu
Li5dDQo+ID4gWyAgIDEzLjU2NTAzNV0gRURBQyBNQzA6IEdpdmluZyBvdXQgZGV2aWNlIHRvIG1v
ZHVsZSBpZ2VuNl9lZGFjIGNvbnRyb2xsZXINCj4gSW50ZWxfY2xpZW50X1NvQyBNQyMwOiBERVYg
MDAwMDowMDowMC4wIChJTlRFUlJVUFQpDQo+ID4gWyAgIDEzLjU2NTc0Nl0gRURBQyBpZ2VuNjog
RXhwZWN0ZWQgMiBtY3MsIGJ1dCBvbmx5IDEgZGV0ZWN0ZWQuDQo+IA0KPiBXZWxsLCBmb2xrcywg
aWYgeW91J3ZlIGRldGVjdGVkIG9ubHkgb25lIG1lbW9yeSBjb250cm9sbGVyLCB0aGVuIHdvcmsg
d2l0aA0KPiBvbmx5IG9uZSBhbmQgZG8gbm90IGtpbGwgdGhlIG1hY2hpbmU6DQo+IA0KDQpZZXMu
IA0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvaWdlbjZfZWRhYy5jIGIvZHJpdmVycy9l
ZGFjL2lnZW42X2VkYWMuYyBpbmRleA0KPiAxOTMwZGMwMGM3OTEuLjIzZTI2YmEyZDQ5YiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9lZGFjL2lnZW42X2VkYWMuYw0KPiArKysgYi9kcml2ZXJzL2Vk
YWMvaWdlbjZfZWRhYy5jDQo+IEBAIC0xMzUwLDkgKzEzNTAsMTEgQEAgc3RhdGljIGludCBpZ2Vu
Nl9yZWdpc3Rlcl9tY2lzKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiB1NjQgbWNoYmFyKQ0KPiAg
CQlyZXR1cm4gLUVOT0RFVjsNCj4gIAl9DQo+IA0KPiAtCWlmIChsbWMgPCByZXNfY2ZnLT5udW1f
aW1jKQ0KPiArCWlmIChsbWMgPCByZXNfY2ZnLT5udW1faW1jKSB7DQo+ICAJCWlnZW42X3ByaW50
ayhLRVJOX1dBUk5JTkcsICJFeHBlY3RlZCAlZCBtY3MsIGJ1dA0KPiBvbmx5ICVkIGRldGVjdGVk
LiIsDQo+ICAJCQkgICAgIHJlc19jZmctPm51bV9pbWMsIGxtYyk7DQo+ICsJCXJlc19jZmctPm51
bV9pbWMgPSBsbWM7DQo+ICsJfQ0KPiANCj4gIAlyZXR1cm4gMDsNCj4gDQo+IC0tLQ0KPiANCj4g
YnV0IHRoZW4gdGhhdCBjZmcgc3RydWN0IGlzIGNvbnN0IDotXA0KPiANCj4gZHJpdmVycy9lZGFj
L2lnZW42X2VkYWMuYzogSW4gZnVuY3Rpb24g4oCYaWdlbjZfcmVnaXN0ZXJfbWNpc+KAmToNCj4g
ZHJpdmVycy9lZGFjL2lnZW42X2VkYWMuYzoxMzU2OjM0OiBlcnJvcjogYXNzaWdubWVudCBvZiBt
ZW1iZXIg4oCYbnVtX2ltY+KAmQ0KPiBpbiByZWFkLW9ubHkgb2JqZWN0DQo+ICAxMzU2IHwgICAg
ICAgICAgICAgICAgIHJlc19jZmctPm51bV9pbWMgPSBsbWM7DQo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiANCj4gDQo+IFVubGVzcyBpdCBpcyBzb21lIGd1
bmt5IGNyYXAgdGhpcyBjb3JlYm9vdCBkb2VzIC0gdGhlbiB3ZSB3aWxsIGhhdmUgdG8gaGF2ZSBh
DQo+IGxvbmdlciB0YWxrLg0KPiANCj4g8J+YnQ0KDQpJbiB0aGUgMTBubV9lZGFjIGRyaXZlciBm
b3IgSW50ZWwgWGVvbiBzZXJ2ZXIsICdjZmcnIGlzIG5vbi1jb25zdCwgYW5kIHRoZSBmaWVsZA0K
J2NmZy0+ZGRyX2ltY19udW0nIFsxXSBpcyBvdmVyd3JpdHRlbiB3aXRoIHRoZSBudW1iZXIgb2Yg
ZGV0ZWN0ZWQgRERSIG1lbW9yeQ0KY29udHJvbGxlcnMgYXQgcnVudGltZS4NCg0KUmV2ZXJ0aW5n
ICdjZmcnIGluIHRoaXMgaWdlbjZfZWRhYyBkcml2ZXIgdG8gbm9uLWNvbnN0LCBhbGxvd2luZyBp
dCB0byBiZSBzZXQNCndpdGggdGhlIGFjdHVhbCBudW1iZXIgb2YgZGV0ZWN0ZWQgbWVtb3J5IGNv
bnRyb2xsZXJzIHNlZW1zIHJlYXNvbmFibGUuDQoNCkFmdGVyIHRoYXQgdGhlbiBhcHBseWluZyBC
b3JpcycgZml4IGFib3ZlIGlzIHRoZSBzaW1wbGVzdCB3YXkgdG8gcmVzb2x2ZSB0aGUgDQppc3N1
ZS4g8J+Yig0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFz
dGVyL2RyaXZlcnMvZWRhYy9pMTBubV9iYXNlLmMjTDQ3OQ0KDQpUaGFua3MuDQotUWl1eHUNCg==

