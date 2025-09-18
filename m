Return-Path: <linux-edac+bounces-4835-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5733B87007
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 23:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0033BB126
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243F2D877E;
	Thu, 18 Sep 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lh5miG2b"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4F2BFC8F;
	Thu, 18 Sep 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229501; cv=fail; b=GP36ZgwnVm7jyt2dEAlTCxpMXwDn2fCb5oB0Y1PJtwuvvd9vGeHNqUso4dffOc4K48FczPjgwdCLGPgA6pL8aeVF/QOkb0AzyxsjZllbNBr6mF82dsDdy9CNxaGr6Dyr3xwSLMejUsxTB6y2DAzNgykrkRr4HI7QPAQEWtcaWzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229501; c=relaxed/simple;
	bh=JgJPpaNUSEqPqFWxZmGHIwdtWT8Uh1aOl4DG611UPnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYtmZs3DoHfmnB+QUTy9KA/YnOCOoaWFPNNPJM7MaILmuvynSbUeg3RATVLCoLGInsiRMUVT2PWgDc1WB0cZo3dmVR5chwj+Acky03YB3MjZGlbglZIxsfXlUteJRuD/2pET1atgBD1GVNb8DbNPnkXsmF+mhR6gEEZJ5HyJ8oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lh5miG2b; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758229500; x=1789765500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JgJPpaNUSEqPqFWxZmGHIwdtWT8Uh1aOl4DG611UPnI=;
  b=Lh5miG2bAGKkQb/3HBF1yxNZ7R1F5SPdPms5lFc/svbNJNvrezfxDJsw
   V5MhCJ+0lC6cQ/J7S+mw/BYSWEVVHm5oG9AlnlXykAFLPkzJBW0Jnu4p8
   gQMahtQy+O3Ew7tku4MmbxGbOaENhgQgaBboBGUssw/2sBjupWxKlkV1l
   hshLjc4RDpV43N7MpA/+2tKst+XsCNZQDdxXo3XmK9JJKucMg+ECsvlBq
   RwsQhEkpKIam3kn+W5MfxapbI5+uuqyJ3bo63OmC+LZDGZvdsYug2XWOG
   eEvR+wMCEUhaP0WKXzcCBFvFTgbNtK+erc9NCOWHkJ0K/p5w235itRLAD
   g==;
X-CSE-ConnectionGUID: z45z9L6yTA6DpxCfA4BGWQ==
X-CSE-MsgGUID: /h5JbvMbRi6UgbiBQVQPWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60639761"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60639761"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:04:58 -0700
X-CSE-ConnectionGUID: dkr+zeu2SWKwoKF83bGQsQ==
X-CSE-MsgGUID: 55Go/ABeS9OWH3rENh06Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="180939480"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:04:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 14:04:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 14:04:56 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 14:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkZmXE12EJoFrenGRskME0Zko0PnTTHrsvPRNqN8mgnJ/Zzg9ZAvaBSVECb7ZeP5aYH653olKE4sdAfEpuDq4ftL338ZOLbuFwz2rSRsXw/eSt1IE5z4Ejc0dkGWS9CuzkEPENoEW7ufJTRgyqgWzpK2sNGv8sUWANWuvaHvLH9HOdyW+r/7zSLpPSKCdODVwHh380oMZvYMXeRMTYJDzlx09IidOCje+SRZ1t72MPp2hr/G76/HLCEShX1AoA1gHs1989nw0FSAMDmQP3342iI4Hbtk0iH0FrvDbIWWZBYG5DFwgYXpphFZMNowpbYgPdNPJQBP6BRCbEXbWX2ixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgJPpaNUSEqPqFWxZmGHIwdtWT8Uh1aOl4DG611UPnI=;
 b=qwEE4rxk308htc7oka0htEWXIV7ce3xleakJGoadSHXMQTCukKc80JiREoTxNISkKxVu8SnOCtSTqD23meEfbmmGozQiWczDH/Da2zb4z9537GWAmrpylfudE0HaMrsy8sKAUgKTqqJlDUlHXn5gObq7O3hy08YQxWGP6ZPzJtuuZnb/4wr+k89Ick2hopRi4A8XqN9q/HoQoYT4uEMJ2ZnHoBJpg+ll673wrrMPvKpoipBNaN3hS3Q6YpB2RstUWE+6gc5JyfiIXZT5vDdK4tL2aZdUuQ3IpEH/fmyWzBSc9FDLhNXN9lyG6AfZUePlj6Oaaao7KdG0cdsUtC3bCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 21:04:54 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 21:04:53 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Nikolay Borisov
	<nik.borisov@suse.com>
CC: Bert Karwatzki <spasswolf@web.de>, Borislav Petkov <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: spurious mce Hardware Error messages in next-20250912
Thread-Topic: spurious mce Hardware Error messages in next-20250912
Thread-Index: AQHcJdw/IC1O54W6GUSZlk15RgJwJrSUiCKAgAA0l4CAAAsXAIAAwBSAgABS7gCAAGohgIAAtGGAgAB9WACAAA5wgIAAQTUAgAD5zwCAALKRgIAAAMLA
Date: Thu, 18 Sep 2025 21:04:53 +0000
Message-ID: <SJ1PR11MB608353C84F69E8EC0D6744ECFC16A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
In-Reply-To: <20250918210005.GA2150610@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN0PR11MB6009:EE_
x-ms-office365-filtering-correlation-id: 67655069-1fdc-4f33-2db0-08ddf6f703e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V2xyK1lWa09yT3h5NFFLOThjMnhwelo5eUFnQTd5NXd1UnEyVUprdFVTOENz?=
 =?utf-8?B?Q0dRKzl5YmNHenJSK3FVYkdlSlNEYVdpNTAwbFV4TFJIZ3BQenJFNXBYZHZy?=
 =?utf-8?B?MjN5dWgwK3kwbHhJYWFwSXdNYjVLcnlTVEtmSW16VEN6VndiTXpDMVd6MFli?=
 =?utf-8?B?ZzhVc0JxWkpkM3pxWC9DYlJ5NTk4R2VLdHZ1Z1Evbmx5SExKTkoyVnpXU1Nh?=
 =?utf-8?B?TTZMcjN3Q0xuVUp5Z2hhaTRoSHpKd0VteExWTDE2dG5tVlQ3MjBSbUJPblAx?=
 =?utf-8?B?MXFpZVR2ME5YSC9PRUtlL1lIc2RvNXRjRnROZ2ZLZmw2eWQrMmZESk56L2hC?=
 =?utf-8?B?eDhCVjl4NGRWR1RpZDBrcVlER29jeHhKb3FoODlNUmxyRUhvdW90R21mZnBK?=
 =?utf-8?B?UzMrMndoc0lzMHE1a0lndk9oU01BNVhyUUVzZmVTVDNkaExmK2w3L2VQNGFK?=
 =?utf-8?B?N0JvRzNjVzU4dEcyekIvTTMySER3RVc4VGtTYitJRkUrUFJGSzNUd2tUQXg2?=
 =?utf-8?B?dDVsRVhGUDBPTjhEdksyRm41YTlYRUFrYzhHbnUwY0UxbjNzTnYyK1R2VjQ4?=
 =?utf-8?B?T0NpTlhZZzZuWVdxbU80aG9pd2FGSUEvYlBPbTBzUWtsQkhncjlzNmE3YVJx?=
 =?utf-8?B?N1ZBQ0FDQzJ3d0FYMzlPMTlyZlRGN2RyaVpHVytuYkdOVEs4aXRyK3U4N2Fv?=
 =?utf-8?B?VHpuU1g1SjFYSDRHdHg2WWJhaWlOMDNwbHZhdnhiZ2tWQi83RUpjazdzd2pp?=
 =?utf-8?B?REpLRXErazBhV0lNR2ZPZk1hVFNjdmVNWlZWTkNmaFE4VTNCSHZXU0MyclN0?=
 =?utf-8?B?b1F3L21ubUZoQ003clExZkNvemFjU1NXbS85MFpLaCs1Ym1uVVBZNE1XTERt?=
 =?utf-8?B?NC9vVWJ5Nk1mSi9xSUxQQzNVVkNjaU53RHVybXNmenM1OXNUN1l0RUhNcWNs?=
 =?utf-8?B?N0Y1TjNpam95ZWxxNGRSNzdYTXZNTXZaQzN2aHNUWmZyNVpIY3FJWmExOXUv?=
 =?utf-8?B?SnIxMGs3UmRyM3RoN1NqcFhwOTBuL0FNSFB3RjQvR0paVmxPN212MEQwbVZa?=
 =?utf-8?B?czFKakhYTkZBdTVQL2dpZHFCbU4vRnU5ZzFQcFdRTE9ZN1EzcTZOT0NlZkZL?=
 =?utf-8?B?cmN1VHBhMnhqcFJpVjZ5NGQwdFBDYVZYV3FoOWRJUjRsaTZOMkh4Y3JxaTdS?=
 =?utf-8?B?OXpVS2g3anBVa1JRVXlVN0FLSG5ObW9WdWlMMUhNcXBSeWFmV0JoeEUzK3pB?=
 =?utf-8?B?bXJVS0ZBS3ZNbnNrdFNaYmpDU3kxQWNmL1J4cEh4WlNWdzI4NUpzRE9NZFgx?=
 =?utf-8?B?MzNTNC9VSWFpeCtpOG4yaG8zeklYK3ZFNmoxZmpuQnNQY3pkY3FESFl3VjNM?=
 =?utf-8?B?bDhKcjlDdS9vVklLSmFPVEZTd0ZLWC9rR2R1Sm84dFR2aDNwdDZIQkpCd0JB?=
 =?utf-8?B?Z1hIL1NLY2tjMWNld3hvcm9OL0VRQkl1UWFMajlEdjBYLzJKaDUrOC9oQ3RP?=
 =?utf-8?B?YTFnb2NGOXJ0R1VNVnFXS250OHBvQm1TbGxDcWNTb3RGaVlneGdvckdlL2t0?=
 =?utf-8?B?ZGhTNUE0bk1EcFNJUSt6YnhnbEdoZVNQV2NLTUNjSmVVVUtEQUJxS2Yxcmx6?=
 =?utf-8?B?ald1U1RyamRTYXJrendrV3ArcC9VWC8xN3lKbUtkNUtvNEQvVG9Fa2tOTUw5?=
 =?utf-8?B?cWhoQUhhRkpFWk9BNWZCSU5CUE1ZaHJ6Z0kzVG5ZSWQ3Z1ROVWExRFB6S0JB?=
 =?utf-8?B?Y0xuOFdDUnlRWEpIbTdJNjdXZFE4ditCekV5SzhGaDFJUGRrQS9ONnNoYm5n?=
 =?utf-8?B?ZENldTNCR1NRSnltWEZua29mYWxBaFZMUjdhaWdsbmU1dDRiUE5Ea01zRHZZ?=
 =?utf-8?B?aWxiOG8rcjVlbko1Sk1SNVBNQllWWGJoM2xmWGhBMk10dnU4SHZqRE92QzRR?=
 =?utf-8?B?YUJhbUlkeitWcEd5MUJidXdOMHVGQ09sZzdEZlpFVjFuYnBvbk9oeHlBeGN6?=
 =?utf-8?B?dWlVSUY1SUFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0ZlbzBlVzY1QU54U2pPazl5MUpPNW9MTVhKZ0lBNy9GenN0SHFPcFZCT2tE?=
 =?utf-8?B?enM4VGlmNVZIVzVWSTl4SDhwL2ZBQzhLbkJUbHAyd0tQVEVoRFkyc2d6Wndy?=
 =?utf-8?B?dzZlb0Erem5YVWR4Q2kzQUZVWEpFM3JqejJyemFzSnpyWk00NjNaR3Mzb3Zh?=
 =?utf-8?B?VlV1SkpSanhWZVhBcHQvSUFxbW4rVVNMTEhoekVySGV1bzZJUm9rKzJpRzdY?=
 =?utf-8?B?VndqMWpITS90NmdXNVRHU09JT1JhdTlNcldGZ3Z0Q3I2Y3Z1MCtyMXBzL0R4?=
 =?utf-8?B?RzJXZENEK0xLc3FOWDdYWkU4aEk1VlZvdW45dkc2S1pjY1RFN3ZTSERmSEg4?=
 =?utf-8?B?Tm4zZ0wrajZqaUlPc2pVaTFBMUVZYytDYnlwa3dLSFA1QWJOd3lhSjZtMDhW?=
 =?utf-8?B?aUp5eElCbko2c0N1ajNDMVM0ZVByUG1FOGluOTJNY1lwV29oYTZvMzQ1bTR3?=
 =?utf-8?B?WnF0TE1QUTNEdDM3a2hxWnRtanpNaTJaa0xKY1BqbkhGcmtKeVhCVE1XY08r?=
 =?utf-8?B?eUFnb0VObmtic2lSN29WUE1vSUZoZ0RHNW1FS21UcmtvVEVzUm1QbHlmVzNt?=
 =?utf-8?B?Rmp2QytSSEVnMFVoUUg2K0Noczc4T0prMDFMZHJ5OUFIM3BpZ0FBVkJTWEdW?=
 =?utf-8?B?Q3c3Vmt5KzFlbmxwUWoraHNZTzg0c0krWmVXc05jSEd5SUdpeDAyQzk2alFO?=
 =?utf-8?B?QTFnMUdkTnJmTHVzN2pjSFB4RGQzQklJQmc1b1dDUkVmUFd3Y0MyUnIrOW1E?=
 =?utf-8?B?VkJFM08zVEZNTjlhQWJQQWc1TFlsbzhDZ0FrZ1gwNXlrTC9WdkV3RDRoeFpP?=
 =?utf-8?B?ZDgxb0wvNmUrZWtSMUlmMEU4UjNTVXJkT0RyYWhUQnZ6WkxtQ3gyRlhReTlR?=
 =?utf-8?B?NFQ2NFJnajFJMUpGQitUS0JlVmk5SERYNjdWamNubnJDUW1WQjFvSlExcGh1?=
 =?utf-8?B?bDhwUktpRDV2cEk4YTFoMTBCT2hyMlM3Rk9RZnl3SVM0Y1l2Z3k0STFSNnNU?=
 =?utf-8?B?NHl4Y2JIam84bTAycE5IeVFBdm15T0lua2Roc0pWb3NpYzZxV0xVVXZHWjQy?=
 =?utf-8?B?bkVuSTl4QzlFaGlBckVxVFFja3o1UnRaei96TnpEN3hoMXY2RTlmSjFFTXJY?=
 =?utf-8?B?UUpsbU84ZjE1SjRsRkZ0T3lCazVYMUdJN2QyR2xOQ0N1VlNUblZ5ejI5OThU?=
 =?utf-8?B?SER5WjhkbG9SUDJxMWJ6TTI3cU11UnFYSlQzZnlvalNHRW1qYTZ3NGpGSDgx?=
 =?utf-8?B?bkJWOHBVSjJjVmg5SVNQOHVXQmFMRUd6VHBuWGJhdEcrWlBlQThVbVdDKzlm?=
 =?utf-8?B?dDVJVC8vNEtUU3hFVmN4WjZVWEIrcnI5K2oreXpqNzErdDBqKzB6aVFLWHYw?=
 =?utf-8?B?TExBK01iY3R0ZjdUZG0yYVRLem1JbEYxNFJxNU81WXlnWXlEUXd1eWFoNE5K?=
 =?utf-8?B?MWVVc1NwZGhYanBvbXZvZkxFdEJpdDhBTUlETDl4eW83dEIvcEE4QTE4TjNI?=
 =?utf-8?B?NGpNTEY4QitWWi9zbjdmaUZQbWwwWEZDM21hRVlTdlkwVU5MMVhkOWhrM1BW?=
 =?utf-8?B?QnRqSFlhQ3RrRDBXK0hwcGIzZTNQTy8yR25kWmpyeGo4YTBCeVNVejBUbFNo?=
 =?utf-8?B?cHRkZTU3YmYrc1Y5YklDdVR5RVVjbEFMQ05kZG92ZWF6SmFSbTFCaVFlUzFR?=
 =?utf-8?B?U0xjanlHZEhRNXNseThXWm1JNW5sNXlEMnY1UlVDNjhsQ2ZCQ3o1MnFGTkcw?=
 =?utf-8?B?L2diRFVod3ZDOEFubktyNkxVSG0zRkVEUEhDbHBOSlhmVWVka3dMZ2dnNnJm?=
 =?utf-8?B?VExMcDhKK0Mwakk5Tmo5QVNodE0vOEZvOGRJcXd1NXhWdWdVS2pRbEN6cXJP?=
 =?utf-8?B?UFZVZW43R1pDZUdCeCtVc0dDdDVqU0drbzVlQ3Fxb3J0d1hCcjYreHd4d01J?=
 =?utf-8?B?ZFBWK1JNWk9ySWRXY0NhREdJNW1ReW5jMXVnS1piblRnSnFFSGRnMk5hUzRw?=
 =?utf-8?B?bzZkVnFOSkI1RkNNNENodXdoakc3dytHMk01NWF2aXAxeCtDbEdSOHIrQnl4?=
 =?utf-8?B?MzhSNlUvWWxlWWprVVRBeU4xWmVvZ0dJNW9jVlRaU0pxQ3cwNFdVREcvVnRi?=
 =?utf-8?Q?eglLH81mnlGuvW0jETYtK9unY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67655069-1fdc-4f33-2db0-08ddf6f703e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 21:04:53.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UByAuFlYxJhKgIm64bH7NbWxgc3uECMPPkAWqbnYykG3gIb2my6WqJdmYJN/jmZpA8+qykIu8Jj2pJOzKnx0Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6009
X-OriginatorOrg: intel.com

PiBGb3IgdGhlIGN1cnJlbnQgaXNzdWUsIGl0IGRvZXMgc2VlbSB0aGF0IHRoZSByZWdpc3RlcnMg
Y29udGFpbiBqdW5rDQo+IHZhbHVlcy4gQW5kIHdlIGFyZSBvbmx5IG5vdyBzZWVpbmcgdGhpcyB3
aXRoIHRoZSByZWNlbnQgcmV3b3JrLg0KDQpEbyB5b3UgdHJ5IHRvIGNsZWFyIHRoZXNlIHJlZ2lz
dGVycyBhZnRlciBsb2dnaW5nPyBPciBqdXN0IHJlbHkgb24gY2xlYXJpbmcNCnRoZSBNQ2lfU1RB
VFVTIHJlZ2lzdGVyPw0KDQpJZiB5b3UgYXJlIGNsZWFyaW5nLCB0aGVuIGl0IGlzbid0IHdvcmtp
bmcgKG9yIG5ldyBqdW5rIHZhbHVlcyBhcHBlYXIgcXVpY2tseSkuDQoNCi1Ub255DQo=

