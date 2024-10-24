Return-Path: <linux-edac+bounces-2243-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622579AEC6C
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3D91F231B7
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE021F81B3;
	Thu, 24 Oct 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjOhC+UK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D71F8195;
	Thu, 24 Oct 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788154; cv=fail; b=sawV9r2n8SvxVN+jr5Sf+ItdRfab1OE0dyUK3JCuuwQBSQ4xECrN6HPBsbtDlOXMfSsmHud19ULsyopJRAe63qULdrtSPRgYI3SbfYBaSGuFyXTKmLhihja+8rymx+NbrtKi17PYCh8YUu5/9WxCM7YyyRfWUcLFIymPnQqrvZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788154; c=relaxed/simple;
	bh=2bZcfD8IuwZ9yAEqcnye1aBjbLen0CkgXIkVlxNYhJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1dbP38UL/A7W9yCYBJxuicFXrFLdtkcpXJnVBhhN1eodrygMuH6msOnGhXG0qi+Z6GAn7+PkGiDNjMyvSknq5jrCdBTjf5CvjTXT81hqnCKRYL7eANwSrVx8nI/t2Ooq2/hDgdikaFZobPyXx0DugR2RS8Be99ClLmaZzMrAPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjOhC+UK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729788152; x=1761324152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2bZcfD8IuwZ9yAEqcnye1aBjbLen0CkgXIkVlxNYhJs=;
  b=VjOhC+UKRfqxMEm+Oi3ApOCsAhqRH67nw8sah6a2ESp0cyRiHX2eCX1M
   Z27+/3Hpy5734sncG5KqWjEPD8tNgsrXq2eQQ1O6XWilg6XfnYciVk9/c
   wgrd1wSN4XnxIFnXyj1wB1af+DBv61P/OFXD0zxRCwaZdJI7FSdCEiTEN
   rAWjVOGLCE7AK/tdDkwg/RD5esiymzD769i4KoK5FvcDgB7t85PQywk7Q
   ihEOk8FtWF8G+reIEwrb/L199JeExt8c5qhlyzTNR+pwnRLloYuQhezmF
   qQ3zsbRc7GIUGRSr7RsK7lgkBblNDnWW97q9IrsoGTyrmkUcyShyNu8Wh
   A==;
X-CSE-ConnectionGUID: 89Zc8Kh+SRubcUaXPTs2wQ==
X-CSE-MsgGUID: IQlXRL4GTPe+ZDoo6GEPXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54831646"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54831646"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:42:31 -0700
X-CSE-ConnectionGUID: ZMLQtFWhSx+W+CJ4Yc2ztA==
X-CSE-MsgGUID: py3p4KpvTa2w8HHoOl3oKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80295887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 09:42:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 09:42:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 09:42:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhuztTW22sBXooSerq8FRuQso3RCVFk1+YuzhTj9vwfrzj828HxEqZLwf25cuLZQ3lWHFY+rdCzhbigVxp4VL+ssa5Aa3w/s8vszeMFUfydGLj58lzeREdrg4xyHvZakA0usaYb13kUzF71wnQP8ckqqxDLyUVAUDNx4gSt7dKhom5Se1cVaB6ojIWIbJSKVYnGqy+BJLUPh2y/Z9Z+6Nr/GjmMio+4EOVQPADo/vuLTrmBK+M5KP2fAxJrjrr4bJg4TFyDMgOH2haTmRg1FTzMeqmzW839T/RQzRf5Iq31ZtkoY/9ELuJApR1ZEVe5qcR740S01vPvWAlKDVMac6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bZcfD8IuwZ9yAEqcnye1aBjbLen0CkgXIkVlxNYhJs=;
 b=mBqlRtdkOkuB8b9+zIOWbPdo9qTsX96a6fKYCTOatsLwyqvakRLADDp+ip11VOklqJicDRwep1KqKpyTM2tiaa1YFCzSqUDQf07BmHX51RZJxZwNQayNOjKt+jcsvdxBuQaPbPIG6zYiwwKqes1zLw9SfBIMzuCYN4SwXiXU8r6H0P0QlLGUXYzkVsOXY23MTkMoY0egSHBAICigIG3CRSUrP4GWQ2msSj9t9lraOatpgCFp0fDzbkSiyrALNzRhAveKjskL71M8FPHUziZwIC+X5tUrZKWwOl67ejQjNlHg22EfDteon5SSqibPn3ka2Da1CmYM3fW3Rxmkregw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Thu, 24 Oct
 2024 16:42:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 16:42:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qM4hN2vTGb8EmNSTTck992prKM7JIAgABI4TSAAF9SAIAD0KcAgAAIXgCAAptvAIAB4iEAgAA6hNA=
Date: Thu, 24 Oct 2024 16:42:28 +0000
Message-ID: <SJ1PR11MB608380793D6F55A62332E0D1FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c9ffb6b0-9c75-4990-afb5-33094d049570@intel.com>
 <CY8PR11MB7134E2BD84013EF41F8F5AC8894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CY8PR11MB7134DED56F51E59273F3B063894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134DED56F51E59273F3B063894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7457:EE_
x-ms-office365-filtering-correlation-id: 068a9626-fda3-4a6d-75c4-08dcf44ad919
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHBVeUtlcUtKUjZ1dy90cjdmOGpsZCsxVzFnNnl6Y2xpaThlSWY3TUVkUE1s?=
 =?utf-8?B?OXNCY3BSQzNkb21oeXJubjBuNWdoVko3Z1JJdCtsWExjMUd5RzU4Y0pRNkh3?=
 =?utf-8?B?SkEvU0xiNGdMUTA3eFg3YXBHQ051RG1STERCRWg4anhzVzFwQm5Bd3lPZTBJ?=
 =?utf-8?B?SHRpWU5jb2JCTlV0TXp0cnh5ZUFWVEN0aWhmRTh4THBEbFc4TWUybGxBZzdY?=
 =?utf-8?B?OFRjamdsK1BXZmZmaDZaOEgzNEE5YkI2d0pNTGU0bGNvTkV0YlY2WHpxYVFM?=
 =?utf-8?B?N1kvT0hjYkV0N0xrbStDNjFwVks1dWsxb3pYS2pNY2ZsWStzRHRNZHlNWTJw?=
 =?utf-8?B?VVM3ZDRUd3Z2ZTQ1Z1dLSk1WU1F5dENQYXB3QjVtYmVORER6c0xhdTE2NHhV?=
 =?utf-8?B?YVQ4NHQ1a2NHb3BaN20vV2ZKc1dKeTJXMC9DUmFIY0hRVW9xVm1TOXRFMDIr?=
 =?utf-8?B?ZnZJaS9JK1F0N2dLM0loRG1ueWdMdHpKYTNNVnBMQUp0cnZzWnZ1MlpaNVd4?=
 =?utf-8?B?U3NBeDdOYXUzMGIxbTFQbUJTckhianphUWNvK0ZNV0dnMnYzRWNpVUdWSmFE?=
 =?utf-8?B?ckU3aXFRN1RaT2xDaTd4SDdZd2c2ZzJlekVYcDJsd3JRVTdUOU11ZGFkaVd4?=
 =?utf-8?B?NnhjR25sam16QmlDbXUyUnlXOFVVUGRMSG92ejZpR0JHNjMwSHExUWg3ZmE0?=
 =?utf-8?B?KzN4VHNoQ2U4RjQ4cGJnMnNQV0V1S29nZkJvZ0I5Vy9TR2J2eVJtUjJrejZW?=
 =?utf-8?B?Z01mVXdVTTZtV2hhQi9EUUZCRFdhZUZ0aW1VYTRwdnBwbWl6V1cvZXJqQ1Rx?=
 =?utf-8?B?SnNMZnFmdXRlRFVCSGdiTUkvcjFMUm1lVXIxdldnOW1wZllmd2pJZFczZFMr?=
 =?utf-8?B?emtCUVNnQkk5V0Q5Z0JBMGFlbWlxQWlCNEl2M0h5S2d6azJyQlA1ZGVSY0lF?=
 =?utf-8?B?cEJCdTAwWHNZZENzM0dOU3ZLVHR2OGNXU0pqSW5VYkRnUFdlOEtzNDE3NkU0?=
 =?utf-8?B?ODBabXRMTC9PRXZPaFQxb29rM1hqcmFHZThoUkhJT1g0Q3pFbHpwTmxrTW9D?=
 =?utf-8?B?LzFPV1BvWHZUOUszRmE0Sk9STi8zd01ISE1HRnE2a3kxSWNTaDd6djVaTXFw?=
 =?utf-8?B?cVdaNHJCOEd5dXlRSGUrTDdJTDNZNTdUNzNGckpkalZsaHVOa0RYMVRuenky?=
 =?utf-8?B?WlAvbm1ocnlraUVpaVJjaDJ2aWxVZXRXN2NpM2t6dVJsZVdSTkQ3aUM1MjZS?=
 =?utf-8?B?bE1ZOEYrMmZpQ2ZMWWtHSjUvWVJuQXQ3WElqSUUrT1NCamVFekM0ZUQrWWFx?=
 =?utf-8?B?VkFFaytOZ0tFMUY0QnBsWjhINmZJVUl6bURCbzMrcGs2bUt3NUFuc1BMbUQ3?=
 =?utf-8?B?eXhyYlpHZUdqOFVpQStEeE1uZmdockNHa01pMkh4UjFEM081SWxYbWc5b3RP?=
 =?utf-8?B?ZTBLUGNLQ29pWlF0d2pNWWZ6N3pmelJUV0h6Vys5T3Z4TjBQZ0FMZUF2eGl5?=
 =?utf-8?B?ZW1DWUJwWnZlem9JNnJTL1RyNEVGdkhEUFJzcUhRNFVGZ2ZNWFBKVkl2UXFU?=
 =?utf-8?B?aGJqczc5L1pPRDVsU05wNkhScGdMRHErOWw2cHR4Nm1PRnFXbi9xZ0djK0o3?=
 =?utf-8?B?V3JEMjVUTGY0U2UxWTJUK0MyaWU3YmZWQk9nb1FUR2RPVXhxcWw5R29OTEx6?=
 =?utf-8?B?M1JOR2ZYU1ZyaThQa1FMNk9GTjZrR3djQktsblZKZjNIcUNZemMwalNqbWwv?=
 =?utf-8?B?UGl2bUtZOEJUOVZxMEVVd1I2dGs5RmJuZ2JDN25zeXpzU0tqMW8vQzVlYkFR?=
 =?utf-8?Q?m7PgYk+aHRFJr/y7L3M1O0gP16iIUAhiwNvOM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjRvMmN4TVNNTWw2cEVNSy9JYkFubUl4bDdMUFZPSG54bUwvR3VIbmVEQUE3?=
 =?utf-8?B?b01vOFdIOEE2WmVKU2V1S2ozOVdJNmtNblZ0WmY4Z2NTaHBpdkQ2ZE04WEhQ?=
 =?utf-8?B?VEg0ZWJ5bUdEdHhGaVNrakxrcVJvRG1uTTE3bG1hRFNEOTVYTTAvNytBRnls?=
 =?utf-8?B?eWJtOUhncmVHNWVtS0VyUitXNm5taExNSDNUZzVSdm04a0FYOTAxRkFWKzJX?=
 =?utf-8?B?Q3Z2eHBDYVN2YnNWRnZvSldqS2x6M0E0b2lnOWpnQW1nelVXVjRleDBtMjB1?=
 =?utf-8?B?bUZQMjVteHRuMDFHaFI5VkY4T0FpMHNSb0FyNytUdnJSZllDNXNsVHBjQk1j?=
 =?utf-8?B?WFpvNVByUUN4NDhSUW9OSUtOOG5RbG00UVdPS2R5eExJMEFaME92QWswRjdm?=
 =?utf-8?B?WDRreUxibHlGenI5Y09NUGNNc0orUEd6d1Ftam5TMXRPV2tmRkZqRlZObWxO?=
 =?utf-8?B?MVdpakxmc3ppREpzTGsvVWNjaXlOWWpWblFhbS9hRVorYTlwN09oazdTT2pT?=
 =?utf-8?B?clVnWTF3U2h6VHIxcWZmMk5sWERoYWJLQTZ0YnNPNG9LZ2FpRXZrZ3ErTUlB?=
 =?utf-8?B?TktHYm94Tmhjb3JEUTlHaW9EZVB5ZjJNRExPc1VIRmxZaEdjTkd5RFd4MUpT?=
 =?utf-8?B?dlQ1cU5qWTFiWlFObE1uZ3pQSy85VHVVMjNyODFkTHlLNzZmN3Y5aUVjcmdp?=
 =?utf-8?B?SzAyNysrZ01IVTl1aDlubTJrVTZTQzFXRWcwTjRrUi96dzhMeTdmOHRsM203?=
 =?utf-8?B?Z0c2Q3d2c1hnemVKUnE3Q2YzZk9sUlJGS0NHR1VJQ0psNXp6eWRXZkFIZ205?=
 =?utf-8?B?NExJMUh6ZEdNQ2IxZC9YVDhGdlRTV0lxazlSOXZKQnI4dG1nQUJ1aU5OVUty?=
 =?utf-8?B?NFcwNVJpY1NHQVd6Y08wQXgrWml4Ulp4WURHaks1OEhJcDBBRDl5dHc4MWVt?=
 =?utf-8?B?K3JBQitZYkNLRTZya00xRElQSEd3RXhYUjFlclpjQWxvSm04OGRrbHJzYzRq?=
 =?utf-8?B?T1J1N2hyTVRiMFBqQUFpNmdqWEpZWnRZOFhKWGVvbUVJSUloNmhhTUZUOUJJ?=
 =?utf-8?B?VjRiSUFULzBlZzRyQ0U2RHhsWnMwTWZZUTlyNXpvcnJDUEZzQ0FBVXlGV1RM?=
 =?utf-8?B?bHU3MnVkRmdRSXdweTFCZ2xoWVZLeVVmVnN4Ui9NdFd0Qk9CNzhNK2Vtb0Jq?=
 =?utf-8?B?V3hBbWVnNmoxNWVSS1BweUdVYUJqTmhzam50NFQ4THpkLzFXbDRTTG5ZTlhZ?=
 =?utf-8?B?b1JUcjM5V1VXczNEMVE3TlVsZmZMa3JrelNqR09VblZnbnFjcmhiMGVFL1pD?=
 =?utf-8?B?RjQ4dCtaY3JTZWhxeENYOUIvcUlBVEU2dXBXdUk1S2FadnlVUkNKbEtRTFk2?=
 =?utf-8?B?ZThwb1FjeXZERnVRNkxJWDE2a3dGb2I5V1p4WDBOVVpTWmNYSDZzN0M2end0?=
 =?utf-8?B?Z3JES2cvaUQwMmc0SW41VE4vVmsvL3ViRFh4S00xU3lFVzg5SWVMQkl0YmJG?=
 =?utf-8?B?Q1RSWXRRL1BIbW94ZDExT0tOK1QyK0Jhc1lVNkl5bEFpTit1eFRNQmVKTWU2?=
 =?utf-8?B?TTdZdStXYVd1cXlBNEc1UjNvZ0xFbzlBYWJKRk15ZlA1UzJEaEJSSWpxcW1v?=
 =?utf-8?B?ZjdUTzMrdGc4RjVmek5GZmxrZFNsREd4SVMvcXh3disyMzZSQlh3WDZySDBs?=
 =?utf-8?B?VkorMHVDTS9jSzBKY2dLWHl1aVQxMW5JYXlZWDNnM0JjNlZROHZkNTZIN2Fv?=
 =?utf-8?B?elVaZFlLWW40NWJwTlV5cnNMbjRjaS9zdERiRGo0b1VqaXIrME80QmpQcUFr?=
 =?utf-8?B?VjlkeWFDMGQyb1NzNmhnRGQ1clZ5aFpGbzdmSDRsSDJtK1JaNi9PRXo1WCs0?=
 =?utf-8?B?QWV6b00wTUdPTUNLSXE4WDdlRmpKVGNUTEJqQWVsVnY4SHJwS1JVUUZQM29P?=
 =?utf-8?B?eWcwZWhUOEpjc0RPNllQVG5PcTR5eHNpcTFBNFAxMUwvWXRRMGRXM1R6a0M0?=
 =?utf-8?B?bzVwWFRHd1Jndm9mK1doR1ZFdjRMN3piTWdkN2RHNlY3UmdPYm03c1lQZHZh?=
 =?utf-8?B?V21PSTZhTVV4MWMybWZmVVB3UjdrL0xDWWRZZzYxMGJuZUpvL1p5RUpXMUto?=
 =?utf-8?Q?2Fe+ijXKvFfPuRzxlWzmPUtEg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 068a9626-fda3-4a6d-75c4-08dcf44ad919
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 16:42:28.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJ78ywc6tUTgRfLiVHZTeAR/kUxHeIJ9bxr36/4raaGrare6CkxvGY5C51CnL1BlZt1XU3aDuoL0SL9Msg12iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com

LSAgICAgICBpZiAoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsIDwgMHgxQSAmJiB0aGlzX2Nw
dV9yZWFkKG1jZV9udW1fYmFua3MpID4gMCkNCisgICAgICAgaWYgKGMtPng4Nl92Zm0gPCBJTlRF
TF9ORUhBTEVNX0VQICYmIHRoaXNfY3B1X3JlYWQobWNlX251bV9iYW5rcykgPiAwKQ0KICAgICAg
ICAgICAgICAgIG1jZV9iYW5rc1swXS5pbml0ID0gZmFsc2U7DQoNClVwZGF0ZWQgY29kZSBub3cg
bWF0Y2hlcyBmb3IgZmFtaWxpZXMgYmVmb3JlIDYgKDQ4NiwgUGVudGl1bSkuIDQ4NiB3b3VsZCBu
ZXZlciBnZXQNCnRvIHRoaXMgY29kZS4gQnV0IEkgdGhpbmsgZnJvbSB0aGUgY29tbWVudHMgYWJv
dXQgbWFjaGluZSBjaGVjayBiYW5rIDAgYmVpbmcgbWFnaWMNCnRoYXQgUGVudGl1bSBoYWQgc29t
ZSBydWRpbWVudGFyeSBzdXBwb3J0Lg0KDQpTaG91bGQgdGhpcyBiZToNCglpZiAoYy0+eDg2X3Zm
bSA+PSBJTlRFTF9QRU5USVVNX1BSTyAmJiBjLT54ODZfdmZtIDwgSU5URUxfTkVIQUxFTV9FUCAm
JiB0aGlzX2NwdV9yZWFkKG1jZV9udW1fYmFua3MpID4gMCkNCnRvIGF2b2lkIHRoaXMgc2VtYW50
aWMgY2hhbmdlPw0KDQotICAgICAgIGlmIChjLT54ODYgPT0gNiAmJiBjLT54ODZfbW9kZWwgPD0g
MTMgJiYgY2ZnLT5ib290bG9nIDwgMCkNCisgICAgICAgaWYgKGMtPng4Nl92Zm0gPCBJTlRFTF9D
T1JFX1lPTkFIICYmIGNmZy0+Ym9vdGxvZyA8IDApDQogICAgICAgICAgICAgICAgY2ZnLT5ib290
bG9nID0gMDsNCg0KU2FtZSBhcyBhYm92ZS4gTmV3IGNvZGUgbWF0Y2hlcyBmb3IgZmFtaWxpZXMg
NCBhbmQgNS4NCg0KLVRvbnkNCg==

