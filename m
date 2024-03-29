Return-Path: <linux-edac+bounces-856-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A168921F3
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 17:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64C11C233DF
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0F2C6B2;
	Fri, 29 Mar 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caJFuQY5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FC1C0DD5;
	Fri, 29 Mar 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731045; cv=fail; b=rhVUIPG1wxBfbkEUdrBiNJhI9Wv2osnZCoDHfgLn+z84BYz/pnNxRiXgwu7b/cjhMuXQAzS0tJrOgfetxyvKjpfE6EcoklnxVCOswv+hBa2IELum9iFhYarqOw9vYFeWql2Hu0hzTbpWlWLD8y3zp+VFknIJSeaOR80Jt8qF2ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731045; c=relaxed/simple;
	bh=6pGXOXXXTf9M1FMdydDvhfbFYMiZAe2owLI3EEFXrwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJkrexQ9ZhNTPyOn1Oj9uHxQVE5UXwnIk4ivSYFQQA06yV2B4FrzLGLS8S0GQnzDa9kwMiYljRpfIQKZcA9HcVSq6o8HacMhAmK4IVhogaHT02VIQ56PEm/nyY1TMWz4li+fWN6q6YoUvAy4GNhZxB4T4mLz5sz1aniYutSwWJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caJFuQY5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731044; x=1743267044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6pGXOXXXTf9M1FMdydDvhfbFYMiZAe2owLI3EEFXrwo=;
  b=caJFuQY5Y+CTeq6Ge3W/cVqfBhRpT8DLAVwTd5YG/dHNOyfVbwKvY+EL
   EobxhwK26h51e/8rMbQU00+geWnzYhOYHswjeyMAay/4Fktd64ST919Wq
   rBWoCbxRsoSTLTMKqHyyMUlelPoT8FbFG/s/S5wopfLjxqVBbvtqPe467
   Bk8DeFT+jcnSr16AvZfyLBv16BYZKc7yHKvu4T1u1aRFhCnSiknpyWJg6
   E2mNvmSgCkv3/LV1H80WLN97yQuBoYJOp6FQBx6E6tPy6ctANC2ROJHlB
   oHLxKt+C0s6D8yeEOOvNm/tTbORZGmjhGo4pkqfh99W58G40MI2PVC6gJ
   A==;
X-CSE-ConnectionGUID: Q7r2855GTaq+mByqkRndlQ==
X-CSE-MsgGUID: AXoS4ECUTremkHjDgigfvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10737127"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="10737127"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17000267"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 09:50:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 09:50:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 09:50:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 09:50:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhgJUNf2b1M7+zxpGCI+S5wQ9ji+OxsPZTe5N5ZLlpA/7WPZ2pei0wZwvgSZrTBLqJiXFZMvB9ie15XfTzZJ6xYnnUOm1jeyUQ1/OHsq1vXPA6uHZHH1smfre4aRxQnI/QvR8PJ4if8BOv2Cm9lWGsbjTE64N1AwIFIJ2eUrNK2fudeBtMJCTT02oXSsmiDMWnsiHUwe7gwwo7Rq6J2ij98I5Xf+tT9nhjbkOjYfElZY8rBOH9WNzZt30iUCoVmZwj7gqX/CervrAnrfTaeejwtP2BZg/dFV+UxWw8sHW73hKT6GKSu0spsSbYnZxHaDOR5hEQIN2NJDx+8LCvkI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pGXOXXXTf9M1FMdydDvhfbFYMiZAe2owLI3EEFXrwo=;
 b=L0Bgm/Voygzq8pIz0ovIDCrfC2WWG6GOKg0GYsmn6xMNKMPEh305Uriq4HDunG5XeJ2ef+VwgNmttzs8dGk9LIFN9A4ffBjU0LiMz64ce3yUBNg2I0YEa2eHLKtBXdWemDHUmex2ATeXEqH70C+YWyVI3Ah7gYs19w/NbqNZOujxHKA5Yz1OQ3DvjrYIzmjEjpByHaT3ScrB+ipTkD1AEIEji4SyimGq99MlWhT9csYQE11OklbCroi/YEJ46nAvR5UGahC6bukvtvhs0W4WAwofUaEYqZoOYKffxqTnNA2+7k9o+1Zhf+pP15KKRt0lJE1izC0i6IV097FCRCmX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7739.namprd11.prod.outlook.com (2603:10b6:8:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 16:50:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 16:50:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, Ingo Molnar <mingo@kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
CC: "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>
Subject: RE: [PATCH] x86/mce: Clean up TP_printk() output line of the
 mce_record tracepoint
Thread-Topic: [PATCH] x86/mce: Clean up TP_printk() output line of the
 mce_record tracepoint
Thread-Index: AQHagahYRDBG3UJG4EKTiOYhZDQBcrFO50yAgAAHFcA=
Date: Fri, 29 Mar 2024 16:50:38 +0000
Message-ID: <SJ1PR11MB6083DA954AD9C56DCB68B357FC3A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
 <20240328180435.435076-2-avadhut.naik@amd.com> <ZgZpn/zbCJWYdL5y@gmail.com>
 <93895d82-ae81-4fa3-8d58-9958d7130dcd@amd.com>
In-Reply-To: <93895d82-ae81-4fa3-8d58-9958d7130dcd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7739:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8O4/VHNnq2c8HkxriRlihNldiuAW91Nd46r7nxCtaxkFOJA4QXYvXXi1RBZOO8BiBrbeCiiVxCG9k/u64To5jVFq0yRtECoTnsjgvPpir4Ed4O5VzKpTAMLe3bSwbN4+aWLWOEylh7OxN2X9osJsqdZ2vlsPYsCIaEmIGMZ7uEYGva84YLVD1LpVmDGPuoKIDjz+skgrx+nNkXfLa9PvYSnKB355kV0o39kURXStn5MZwK+cheGvDDnpJ4+4yYY96fTEKXEI1dy0niWuJKDx4dmJy0pfNLn93o2oWVByasOngHnwMDmn//bnUAiLmINc/pUogjSBg/NJdy5q1dWPpJ+4j06W8LFIX99rIsLWm62QfNV1g86aE96ckRn3NfVDvUjpqK0dPGoPlEESTXAe/jpHW/JyKw5BzfGPMKHpQkOpfvmKE6C7WXX6RhE+4lGmI7UiJQ8QILefkvnd5F+G32qU3yqUNXE77iGKDSDHOpcjq1QFwjs+PjhGGkX4y4ft2PEMlCbuJRxALsSkqnVNse/WRvvz9NPYxCvIU9RBigYGasrBAOexC259RozWdkgFv9ZYdrDzYkF+h4OyTpPpeIXTsgKbW94HeiBzvHazyaOM7tJlyegXduTJ96DGS1cBWXI68pEP/evb/LcQRvnw+pSsN9pIsnC1HZfdU339ff4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M05vTDVHRjZZNlQwQzZMQlFjR0lZMUdUOVpNcTBPNktWNmZJSHlocFc4K2kr?=
 =?utf-8?B?VkI2RzNibjNweEE1aEtaS0NUTU9sekJhYWhUWHY2OFBObTBRZkhBdkU2KzZW?=
 =?utf-8?B?NlBjU3cwd1NIVXJ5Q2l5aWJwejNGNVRiYVZFNHk3Ti9IWHFVWmFQYzJYeEVv?=
 =?utf-8?B?OUJLTFNHa0lkWm1IVmZua3R2d3F6TXJySzdHRnFYVE9KMWUxVkNkeUNzdm9G?=
 =?utf-8?B?K09Keit4WElOTWJyV1dxN2ZZVEY2cjN0aE5PYTZ0dnMzQWs2cDlpMFd6d2tl?=
 =?utf-8?B?cS9aWW0rVi9JSWRrVEZVZWNXUWhIdTBvWVVDR0sxWjJWTWZDWW9mN3EvanBT?=
 =?utf-8?B?Q1FTOHFzTm1xUjFkV0E5MzFraE04MlFLY1hyUFpKQW1zbUNROFBSQjBVWi8v?=
 =?utf-8?B?Y0M0SkdPZS9XU3ZSckRRSXc1Y3U4Mld0SWttdVZUeTIrM0VGWmhXNTMxcXlI?=
 =?utf-8?B?QWVlWGtib3poZnpCY1crNktSZmJEVTNWSEwydzBjRFhwdkJqWDBXMW5Qd1RF?=
 =?utf-8?B?VUJUbHIxdG0rWnJydjJJZ0pEUFRaRkMwb2psL3o4a3pQNUY0aTdEMG1YSXNZ?=
 =?utf-8?B?a0cvSitRa3RYb2hLMHlmdjFMQk45SytBb0daUGpvSHZKcnpZTmVjQ1N4Ly9H?=
 =?utf-8?B?dWMwT2FkdzZwOEZzb3dQRUVPWVhPU3orazBKLzYwaXJZOGs3ejVOWlhXQ09Z?=
 =?utf-8?B?QjBGMjI4Wnp2SEg3V0ppQ0YwKytBRVUwMi83dmFTRFozS0ZYQ3Z0K0tLVXZU?=
 =?utf-8?B?V2F1ckN3eGdvNklkRTlHN1JtMVRYSHpsc1M5byt6R1dJeW1rT25qMGw2SFdQ?=
 =?utf-8?B?RXNnVzBBb25nMEVEa2o4bWduOW5xS3lLRWtYSHFzUnorN1NicStVM2pmeWR2?=
 =?utf-8?B?bFNSMmJCMXVZQkJJckdRYXRTdytxWGI0R0dWNnB4S1FDYzd1Z0ZrM2pPbnJF?=
 =?utf-8?B?OWYvYzRWcGkxWklDcXhsVkdQMXExb2l6V2U2ajZ3Z0tUMHg2U20vTWpNQTlw?=
 =?utf-8?B?OE4wUS8zV01seGRza2RQTTZUL21XZWpYbDBUcXF6Vkk3cHozK3pGQ0lrUEYx?=
 =?utf-8?B?L0txV21aWFphVTRuUEhmZHRWdjZOajBiQ3lkWUR6bUpqTS9SNXdLMEwwdmlq?=
 =?utf-8?B?enRLTFpUMlR6eCtoM3FQdVdqMEYxTTVVS21Qd21OR3l5dXBhaURvZVVscStP?=
 =?utf-8?B?Y1BXRHJLOEFEbk1YbEJkM0tVMHpEZ1lZeVExcmJCR01LdVR5TjJtTEM5ZmVm?=
 =?utf-8?B?enZXUnFCT3FOTm5Yc2NkY3RnblZCN0kyeGtuREVoY2lrUXJ1bzd4aDNvNjRG?=
 =?utf-8?B?OHdsOHljZHoxbFNpSWN3cGE4TDRRckJJelYvaUNjYXpKNVBQZVp1amwxMkRn?=
 =?utf-8?B?eUtvSStYSzliYWhvUEZwSWJlL2lpcDhuQlBtMlFJZVFaRkg4UjhIeDM1UG1W?=
 =?utf-8?B?S2lMbUxCWGNIa0ZhaFBwNnFRT0lPL2hzc25YQS85dFZkRW11UlUrWFNTVFV4?=
 =?utf-8?B?YVNpOEFyME9LZmI0VUZPZlg5ZU1uOVdVQ0pLbFptbDJpZFAzSXpKUXQ1b1JE?=
 =?utf-8?B?UHBJeUsvK09ZL25YMXlRZW9taVVzV3hnUHNUdWgyZmdsWi9IQlZHMzd0SktV?=
 =?utf-8?B?YlJSTGh4bmJObE1CRkY4K215MHdvbVhwV2ttMlpTYUlRam8rS0JUUXo3TkQ2?=
 =?utf-8?B?cjBOeFlQVmk4Q0krcTN1c3hDd2RRMGlOQ09tTDZUa0Q2MCtiQWdhbENiNitT?=
 =?utf-8?B?UEttYlY5c2FFKzY4anZjM1NrZzRXcnBrOUdUejJDUE8zU3g4SEJtNWdZWUh5?=
 =?utf-8?B?N0ZSSktpZGVWbTRJRFhmN1pvWVlkYU1QZWdEYkRhRDVlUlpsTWtQYVdkRVdR?=
 =?utf-8?B?ajVMU1dEakNaRE5HUkc4MVQrS2VkT0Vac0dkVlBmeXZLZzE0dVRTajlhSzdt?=
 =?utf-8?B?TlI2VFNMcVJxUTZaSC8vMFB6OHYxOG5UMHlncEFhOCtCa1VNbFc0WHdwQ2tE?=
 =?utf-8?B?cGlIRmNMMUdLOHZFMStaNndLM1ArREpHL0FXcWpZVnNuRkJod3B3VHRuVlR4?=
 =?utf-8?B?bU0rcTBCOTEyTUpNbEhWaVdBdXRPR1BnaGJjVWg5cDlzbVVnckdka09vTEE1?=
 =?utf-8?Q?tAZFXnRhQgAI79Mv7AEmHf7qU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd24a29e-fb0d-49da-892b-08dc50105c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 16:50:38.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4my/n5P2doR4uY878x2m2Vbv/q3R2Cldo0hn4/J9HuXGL34HHC5U1gjC1dl2PLo+VDeVxyhCdzNfIgsSoZibxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7739
X-OriginatorOrg: intel.com

Pj4gLSBXaGlsZSBhdCBpdCwgZG9uJ3QgZm9yZ2V0IHRvOg0KPj4gDQo+PiAgICBzL0FERFIvTUlT
Qy9TWU5EDQo+PiAgICAgL2FkZHIvbWlzYy9zeW5kDQo+Pg0KPiBUaGVzZSBhcmUgYWN0dWFsbHkg
YWNyb255bXMgZm9yIEFkZHJlc3MsIE1pc2NlbGxhbmVvdXMgYW5kIFN5bmRyb21lIHJlZ2lzdGVy
cy4NCg0KVGhleSBsb29rIGxpa2UgYWJicmV2aWF0aW9ucywgbm90IGFjcm9ueW1zIHRvIG1lLg0K
DQotVG9ueQ0K

