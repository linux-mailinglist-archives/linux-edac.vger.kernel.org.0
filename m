Return-Path: <linux-edac+bounces-4598-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62126B283A2
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584825C82B3
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE4308F27;
	Fri, 15 Aug 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqMOIPNJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B420288C06;
	Fri, 15 Aug 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274457; cv=fail; b=JZ17w13EqOw/jqTBk2AKsb6b7Q54C4cISuEzTElNkx/T610/TMyDojd1+p+zX88QfBS40Sy9u7gxVBjwhlERHFm/n4QHfqUcBVMQEXJcQ/y3pspwg2v9+h40t118pHNTDyF+lA3ke1PeBxjfFiHOZCoScc5m/x+gPPI5TAylbSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274457; c=relaxed/simple;
	bh=qqT0z9NZTsOue3YrQvuDZjmInNU4OJ7LcD+iWMkiEKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erxc01W9RaUP7U4hWZL2Id/SiTYrsmBcRk0aOqIhcfHCB2eb26Gzz4ADgJIWp9fkFOoHKIZwzPLmAUPFv3XzQngjm3RKJcFcHH6vI7nOPCeZbut/LpZ4SBVfNe3VvZogl7FCzGMs1Zpn1z2qRHz75+fBzy5N9Z49qjxa8YmtYB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqMOIPNJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755274456; x=1786810456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qqT0z9NZTsOue3YrQvuDZjmInNU4OJ7LcD+iWMkiEKo=;
  b=QqMOIPNJw94GA3Bq3aJlpPHiDNMkvG9TyS9U8hdYzg9Vft5ek+CwRzvy
   D5xpiW1ddADFgrpy2NfSjXCh7TNRBVN24MplC5qeaNSq5H4QDOaeFTIco
   /XRkff2BuemQR+iiC+zuUQvT/Wimn4AyJUtH7eZzASxNn6qj4o7kbas4Z
   H1eEP2Uk7eHoNf0Lon8ozZZyUcVu3F7NU7hkKRNGK8J7u2XMvbq+KKGDt
   HA/p+Q/g7IJfxaVZlyKECYX3d4umBLlfPUgO0K9NqLaBhqdb34J6vLER7
   tNCWRinF8eVZRxhWsxsT68Q57ljD0Lqx7PItKq+wqDtXvvLhqGprJCtKy
   Q==;
X-CSE-ConnectionGUID: boYDXXyiRZuCqX9Ab31ESA==
X-CSE-MsgGUID: yl5wS0WCRO60HCVGU+5IUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="69044982"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69044982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:14:16 -0700
X-CSE-ConnectionGUID: I/eQkGnkQr2vuReNDYdvYA==
X-CSE-MsgGUID: qv8iiJpzTjaM21s8iKTK/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167296901"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:14:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:14:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 09:14:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.82) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4DURe+LfzDL+wltdoB6LuEjptuwqjPC63zMYKkwbLZ2P6wylZHYIPdDe4Ld1BfKKAlIWSrktjBs3JnXjV2zNOsE5ix7rC+nNuywsDniXyt4PdCcgdNkvLuy/My+3iXyoS9BKJJFjc57hGjd5r7udlOwgCZs/ns1S128ILN/3t9rZ+TJoo4PaCJthfgjh3F9B38D2I1VnuckCeWVSAQfZYmM9990h7/mUsBtg4qlOvXhnX1ivNL4aCvvGD4TJTh+2QB51d6BKTzMMmlgDV5lBGFjrBna95rDHjpLCndDN2XJzBdZuvmTdtpv2Vh7D3ZSIi3kd8Ansm9X2WbWUMuIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqT0z9NZTsOue3YrQvuDZjmInNU4OJ7LcD+iWMkiEKo=;
 b=Agt/pgAj29cODjf6316/7g3829mvgdylQlQvT/IbXCmdBq2wXO675eMn4DMfggFBuNJGQoH/FJj9Mv3omZq2lsGlpgMGgWNhnjuq4H1SsV9pVGwcIiikl9IphIoRZ24lz6mHAPE7cJBsYXTQqBIftQEO+pVNgA31jestzFRVkRzWkxlxr4Si5zodg34YZbdCIHoRzcBVHZiJf0urIpBZKtQqXb1kc5yOVciQ/wVJnEY/akhOvGhqJVJDy3fe7RHE9BkaosNVRUqRD8h3+JaDo2Xx0fZCT+DuV6Qb8/19wSOEsJDu9hN8ZCSnqwZXL4FZkqInY54xIonIjYouP5u3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 16:14:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:14:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "avadhut.naik@amd.com"
	<avadhut.naik@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Thread-Topic: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Thread-Index: AQHcDTLlXEToa5RkX0Wxt1bBlAn1ubRiXeoAgAArmQCAAAX5gIAAFQIAgAAThICAAQKegIAAKC2w
Date: Fri, 15 Aug 2025 16:14:12 +0000
Message-ID: <SJ1PR11MB60837DE56FAE5869234BB34BFC34A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
 <aJ4U3g4fDNNibUOz@agluck-desk3> <20250814193056.GA192444@yaz-khff2.amd.com>
 <aJ4-c0gNPbwwU3jk@agluck-desk3> <20250814210730.GA228071@yaz-khff2.amd.com>
 <aJ5gcUsaKK2AXDsu@agluck-desk3> <20250815134259.GA27834@yaz-khff2.amd.com>
In-Reply-To: <20250815134259.GA27834@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8375:EE_
x-ms-office365-filtering-correlation-id: 1dbdd605-a482-4622-700a-08dddc16c641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHcwY2pkeVpyQzJ4SUVCRmlvQStBZGhVSzI5UXdwMU5NK3pPdllaUG8xcFQ3?=
 =?utf-8?B?ZUN6M0JCNXl0a08yNjNrR0MyNnF4bFBjS1hSNTh0VWJhL1FGVUhuNUdwdHpD?=
 =?utf-8?B?eWQ2N0JFcVByY0I4N05ESGk5Sm90ZUpzdlY3ZnBSTktTd0svTW5aRXFYNHNN?=
 =?utf-8?B?eGd3bkF6dlhXcEJ6dEN2cDVuNnE4eEZyK1BKd3phOExIcTJUbHVGVkEzQUx2?=
 =?utf-8?B?ZWxZbnhSYWZKblF4bFJWdFVuVjJBL01NT0FnYU8zME9ZZDFSOTNJSnJPcXJJ?=
 =?utf-8?B?dGpnOW5PUFBtUExtdDRjaEF1Qlg0QUZtbVF3Vm9GOC8xVHBhUzZWUUE1eDEr?=
 =?utf-8?B?bHlmSSttRXR6MWRvT3RUdzVFdmN0bEFlZkY4QVdZbHZTM0N2TlppMURPcm8v?=
 =?utf-8?B?M2wxRmZ4VXJLcldFaWNzWVdybjhCNkNCVHdGMkJ0eWVBdUhQODlqdXh3L3JB?=
 =?utf-8?B?U1l4NjZSajZoejlNRVFkTmtQWitJc2wxcjJlWWVJZ0s3YUFEOWUxeFU0QXJL?=
 =?utf-8?B?TWJTcklMYnNWRHQ4QWc4eWtQOWk5UDkxY1pGelZWZHpNTVdNWnczeU9WbXE5?=
 =?utf-8?B?WDZPS1VWZjJjRlRCV0lBVExuK2tKbGRtVzByREJwVGE3MzI0UmdlOEdWeVV4?=
 =?utf-8?B?dU9UakR4dUcvWWU5S0RzK3hMYkhrS3NxRHhva0piUzFCaWdhb3NnNkRpd0p5?=
 =?utf-8?B?OVh4UFdMVXc4UytZMllQbmNEN2tHYUFQSE5HdGdkSXFrMzBXV1NveC9aZHMy?=
 =?utf-8?B?Q0Q2Z3lCM1pIMHhlVWZmWjIrNUFnWW5DcWladXcwTnBJOWlOZGNuWFgxTmhG?=
 =?utf-8?B?dDM0V1g3cW1Zd2VleGVjbXBDK2dtUk1pREZpWEI4U1Z6dit6enh6bytZS21n?=
 =?utf-8?B?dDkvSERUTEw4dWVPNTdEL0F6SnNRK3R2T0VZT1NXalJ1N2JnZEI5WFFPcXAx?=
 =?utf-8?B?bElNZkk4R0lLVDFEclRmYkxHa202WDQxVkV4Mk9KektDSzVsYWdRY0R4Mnkw?=
 =?utf-8?B?b3NlVG5RcXZ0djc1eXRMWHc2Wm9RWU1TbDZFYjNaM0NsUmE3eDU2dm43UGwx?=
 =?utf-8?B?RjJqK3BSWjhhOWxVRnhTeFFxSDhuY2U3UXBxdjhWQ3grM2QxYW5ncnFLd0dZ?=
 =?utf-8?B?TURBb3Jpb0w3OFpUcSt1cTRWdkhLVy9aVXhJVDE4T2Y2OUs1WEFXdnFFamla?=
 =?utf-8?B?UWNCWkFGTVJyMUVoNmJhWi9UL2JFRElVRklVc0tHV2YvMlFCLzRVODg0WFMx?=
 =?utf-8?B?a25ZOEx2WEMxai9YaTZScS9JcDF4cHc1QXB3OWEwSFVlWjBsL2NBVXdCR1Vl?=
 =?utf-8?B?NloyTjBTWmkxU1V2ZzFpNExEekRFNWFNZkswZ3VrS3hjRGFyQVVDTnF0RE4x?=
 =?utf-8?B?Nit4aFBwLzh6K1RoMHRBRlBydEpuWVphUElEZ2w4Y1dOYjJTdzFmL1JuY0kv?=
 =?utf-8?B?MWdiN3RXaDd4aldiMFVPSG1UN1VOcjhtNTV6N0RkTlNzbis3K3hCVXc4emdY?=
 =?utf-8?B?RnRDWTdMbzVGVnB2Z1BRUmZQbGw5TEZiMDZ5Szl0RFB1WHo0TE1UcVZTRUpq?=
 =?utf-8?B?Y21xMjM2RTRvMTVWVUxENEkxOFpqQkVWY01SdE1qc1hIckxXVnZxcStGZVpj?=
 =?utf-8?B?WDBKZWV5SEk4ck1jdmlidmNHcnAyZk1JSzU5bFIzT3hhMHRObjBxU28yQVNU?=
 =?utf-8?B?ZXNPYVdhY21DdGhOSWN6ejhqYlgrS3pwMHB6UytOU0dZWUk4NFBLL1U1Z3FL?=
 =?utf-8?B?RkIrdm14STUwaWNtU0laSmNTLzU4YnA2UWxsb2x2NVZVVldSZnBkWU1zOFdJ?=
 =?utf-8?B?dDZ6YzVGeEVpeXI1Sjl3eEJtL2g0Mnd0VWtMOEU3WW9kalhacVdvRWhrdk9w?=
 =?utf-8?B?emgvQi9sR1RXSjFMaUt5Ly9BZ1c5eDZMQnZleXVMaVhuMStsLzV1SWlBdzJW?=
 =?utf-8?B?Vk5wOTBwbTJkZGVGY09FZFVLYi9NdnVtbXpGUVNJeTVOT3IyUE95Uk5YdzMz?=
 =?utf-8?B?QVl5ejI0anl3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2dLQWIzSU8xSXRzQXJ2NmdZTE95TzIremVYQkxPSDlGN3NUbG5xQ3ZTTHFX?=
 =?utf-8?B?dkl2WE1rVTF1Ym92cGE1NU4zQjJKQjRFTXN0anVwVlVramltcGxBVVB5ZGE5?=
 =?utf-8?B?bmNrRzlqSEgwYnV6M2tiVzZUenRJYjVlOFc3eGRpSGYvNm5TdmtrUUl5Y1Q5?=
 =?utf-8?B?QXFrVmFET2FPc05JSmNCUy9pdXpmTlcwM0RqajJLclg2VFFYTHpmckowU3Vl?=
 =?utf-8?B?SWdEb3VOTXI1NDZCa1o2SjBMMEMvMnpEcU9sU1JGZ3RCRDRoTWppQXQ3bjRZ?=
 =?utf-8?B?dkJDNXF5MjZMNFM1QnRPdFE3QVFwUzdzNkl1ZHlMUGFFYVB6YkpXdVlzSERV?=
 =?utf-8?B?c2VXblBKd3IvVXYzdisrY3NjZlowcG1nZkF5cnZJNFNzTlVrbWg5NTRBR2Y0?=
 =?utf-8?B?Q1VtTmp3Y2s0eVUxTDNCQ1NXYmVOdEV2MWRkV3BtbjdwYllPOXo1MlBqUVlr?=
 =?utf-8?B?bVVacFVjK1RIbEVnVzllejBBTUtub3BXdFZwbTFULzVWbGgzbi9jRjZzdGZG?=
 =?utf-8?B?YkFSTFNvSWZUUzhDY2l5SFc1V2ZwRnFBU3V6L25wVHVEYm5wUFhRT1czVVZC?=
 =?utf-8?B?NGZEd2s2QmdGekprVHdGcjNEQlVzZEQvTjg5QUFWV0l4aDRsRm51akFYRHBy?=
 =?utf-8?B?cTJQM2dtTXdqaFp2czZWY3lIZ0lmT1Nrc3o2dTE3Zml5eU1IM3p5SW9jN0lI?=
 =?utf-8?B?Sjl0QmFVM09JcXlTemliQ3hsZTIvcTVKaXhwTXp5YXdnTWxuN3Vadm5lT1J5?=
 =?utf-8?B?bTFKRTZkRDRERTM4dTRycUlhSy83bWlDSWtFUWRtT3ZvSXFJYUE5NmcybklI?=
 =?utf-8?B?MllydWRyREh3V1IzcmR6L21VNWtLQ2ljMStFWlVlWE90aG5KTU9PdzcrdXRn?=
 =?utf-8?B?MlJZQTFSclZHSzJEWkpMRTRWTHZ0T1RuTWppRGVObGh5OXN6KzlSM2FMZGVS?=
 =?utf-8?B?eHc5VmljZmU4RjMreklFV1UwS0FMa0k3VWMzQUdkZnNuOTZreksxMVg1ZXBQ?=
 =?utf-8?B?YXYyUXJuUy9adytnVE43bUw5Z3BUa2RpU21DcE5MTU04aHpBdkszS1ZFSmFu?=
 =?utf-8?B?L3VlVmF2L3NHTWVkcHl1UDlEOXpFeUkxakgva3NGTVJzS1VvRXZDSEpEYits?=
 =?utf-8?B?aFRsWnBiakNEYmdrNDU2ZlN6VkVLYkFzWE9DVG1aVlA5d1Q5bjVXODZNQzBz?=
 =?utf-8?B?Y3N3dlZPVzRIb0NwYXEvNjhBZmxzd1ZmbUVDeDFldVEwRmcwMDBieXBRbTlK?=
 =?utf-8?B?WUlMZnFyMTdMMnF3Q2pjMklLY3cvVzFjTGZUdElWaWZvNzdWR3NwZmVsUjNQ?=
 =?utf-8?B?bVlPblFSZlAxM2MrbU9YbUdJbHZlcXFzR2Q0NVNHaXU2R0dMMFIrRDVVZkRi?=
 =?utf-8?B?WnhTeFphcWpEMVdzeXlQS1hyWTRtT2tsckRJU1ZXeGU5T1E0OStIUzFwRW5z?=
 =?utf-8?B?Kzk2T2tqMzRoYmFqOXVMT0NuQWs0d0RyUUhiMVpSNG1ucTFYNWNsbGRuT3BJ?=
 =?utf-8?B?RVZXbkN3K2ZWUzlxeTBtVUZzZVVQaWhwNFJsUUJPN0kydWtPVHdQaGxWNkxk?=
 =?utf-8?B?Wno3ZURRb2gzOGMzdTZWZ0tVaURZVDBrNXZtOHlZNk4wbVFpNld6bzQ4Yk1o?=
 =?utf-8?B?TGJFaktPbXhlMlloc2dvM0IyOGdVNHNTU2c1K2dCaFFBejlXbm5QZ0VzQ0la?=
 =?utf-8?B?VFd2ZHE1T2JCU0xYK0pla0NTSHQ0UVd3UmlSbHpPM3ZvRjBDS2FPdzd3RkJM?=
 =?utf-8?B?aWFSbHlHKzJBWTFsVExCbkMrQ1ZmRmsxUmlKTzZRaTNSck9lYVpweFFTbEM4?=
 =?utf-8?B?Ylp4cFBKbllSK1h2aCt4cVpBa2JjakVDdEZ6QW9VUFk5TktpRFVrbThLbm5s?=
 =?utf-8?B?STdCT3JIM1hERHR1OEVtRTl5WVJ2ME93MDUyRlFrdGsyOWVLM2VHcjVVOVlF?=
 =?utf-8?B?ajExVEJWVk5KelorR21ia0w4b2VQL25KaDIzbjRWanVsSWRpcjEzd3RKRzVt?=
 =?utf-8?B?VUVjRnlOcytReFpFTU5RRDNBOXdXc0gwWDZVenFnSmY2ZDg4TjRnSUpnbUVu?=
 =?utf-8?B?WUllMWlyNTZsWWJzWE1UdmM5YzRzZ0xPamc3MEpZYnd1cnJNQ0c5em9ud3Vo?=
 =?utf-8?Q?HJHHZM7NY9Sg4TsqUy1azqmML?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbdd605-a482-4622-700a-08dddc16c641
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 16:14:12.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSE2Ra0ZqbW4v7rKagB8HgFTv20KTlGOeYTzgVQL7rSavXhssi200G/AWLgD/eq+UfD3qDuImf/Ige0ANvgW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8375
X-OriginatorOrg: intel.com

PiBPa2F5LCBmYWlyIGVub3VnaC4gSXQgc2VlbXMgbGlrZSB0aGVzZSBxdWlya3Mgc2hvdWxkIHN0
YXkuIFRoYW5rcyBmb3INCj4gdGhlIGRpc2N1c3Npb24uIEl0IHJlYWxseSBoZWxwZWQgbWUgYmV0
dGVyIHVuZGVyc3RhbmQgdGhlc2UgcXVpcmtzIGFuZA0KPiB0aGVpciBoaXN0b3J5Lg0KDQpZYXpl
biwNCg0KTWF5YmUgc29tZWRheSB3ZSBzaG91bGQgc2F5ICJlbm91Z2giIGFuZCBjbGVhbiBvdXQg
Y29kZSB0byBzdXBwb3J0IGFuY2llbnQgaGlzdG9yeS4NClRoYXQgU2FuZHlicmlkZ2UgQ1BVIHdh
cyBsYXVuY2hlZCBpbiAyMDEyLCBkaXNjb250aW51ZWQgaW4gMjAxNSwgYW5kIGlzIG5vdyBvdXQg
b2YNCnNlcnZpY2Ugd2luZG93IChtZWFuaW5nIG5vIG5ldyBtaWNyb2NvZGUgdXBkYXRlcykuIFdp
dGggb25seSA4IGNvcmVzIGFuZCAyME1CDQpMMyBjYWNoZSwgSSBleHBlY3QgbWFueSBsYXB0b3Bz
IG5vdyBydW4gcmluZ3MgYXJvdW5kIGl0Lg0KDQpMaW51eCBoYXMgYSBoaXN0b3J5IG9mIHN1cHBv
cnRpbmcgc3lzdGVtcyBsb25nIGFmdGVyIG1hbnVmYWN0dXJlcnMgaGF2ZSBtb3ZlZCBvbiwNCmJ1
dCBpdCBkb2VzIGV2ZW50dWFsbHkgZHJvcCBvbGQgc3R1ZmYuIE1heWJlIHRvZGF5IGlzbid0IHRo
ZSByaWdodCB0aW1lLiBCdXQgcGVyaGFwcw0KMjAzMyB3aGVuIHRob3NlIG9sZCBzeXN0ZW0gcmVh
Y2ggVVNBIGxlZ2FsIGRyaW5raW5nIGFnZSA6LSkNCg0KLVRvbnkNCg==

