Return-Path: <linux-edac+bounces-2200-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B6A9AC0D2
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF523B24544
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3BB156885;
	Wed, 23 Oct 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqn3XmtY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C9156880;
	Wed, 23 Oct 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670390; cv=fail; b=FRljagvQeegoB/okpAjkpinRJn5jiO1sLTGe37w6yF47sTdMtex/VTVlePNN1BTCfyAJWGNaIqirrE3mTRiZezNBphRwpl/bllaMx/pSxlk14ReaFXyn6CJjZ36GUGaWLNCg1CvS80aVqU4r0D4+cozxFCYEN00sjik6Ny25HIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670390; c=relaxed/simple;
	bh=kn1dkcUZGTxtL9xte9uspP0xjgIqhLiKtSDDox8sa7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cl+S/SEVJ0OEl5TYfnFJi1u69J2tfldtjgg91fVEXWBzeBS3+p6QAuTy8Wb7jaoPHZgPCdegJ0yTExZ0CRy1J01drKT0tKLPWDicY3/AglIF7DPmofsVXaR05AmG+TUI5fpCTCh96TbMSaRBSzJit9Y+HbDLHuIKsOpIPoIAKQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqn3XmtY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729670389; x=1761206389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kn1dkcUZGTxtL9xte9uspP0xjgIqhLiKtSDDox8sa7o=;
  b=eqn3XmtYkZEZ1Etn3aaOveDP0GxV7SEumuOWhPmun8Ni0+sfDu63mtip
   6fuKpgOQsgRzKshCR+MjQkddKIDFe/0JwDb4RPyukKq5xtkysv/fnQy8E
   T6OH2UBWJ3mFR5368nlQe74a0Vge+/JQvnczluI6xUGnxfzQuGbB34IQ7
   H/qQ7xl0ZgTNcDdstluD0d26sK9uMFaqXUPmC/ahTshn2Q2onZ7v91Dzj
   1IswCuKEoVQBkqg2vWDbFzxVctODZYe1s1vudhyG7g/GD311HcJqG2smP
   FDEqtJMl2gzOUAgoMKdy2ufVhzN7uUBGXV8dApLyvwCpaC1CTJHtjHmdM
   g==;
X-CSE-ConnectionGUID: HP1YtkVOSFKGv73X5jw2zQ==
X-CSE-MsgGUID: iRjR5sKkQlCoXdE35kEq/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="40636606"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="40636606"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:57:42 -0700
X-CSE-ConnectionGUID: QltUKiM6RhuGS3VcNP681g==
X-CSE-MsgGUID: NgrVKBJ2T4yKuizqt4gU5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="117597287"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:57:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:57:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:57:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7PpPIFEN4Ky6URb6hD7IfOe1H+tDm7S41m0M6lCf81bpwtctre0WaLKY85mwpe7LxuCKSG7i3B20hNIp705eDTMBc9UPiJskVQWmuiuQdjMHha4fg6JYEyl3Mt69fI2dMSS+O7NESBeLH+6BA4yxy+5Yvfv5TXEVFvcnuhF/HIuiLdXukuiGy1N2in1hiOLwBoVRYXHmXIw5YAIk8AdmHS50mI2dLzW6rTQMzO5UCvWsDFk73u6lfR7+M+CIPcyuZqBHJp4/y3+N8H6vFhX5mVLFXeyeUfVBnU6kXCrR2inBs9YV5GCmUtunzuUOGsuMkKFFQKj8rRJ5teZGqqsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn1dkcUZGTxtL9xte9uspP0xjgIqhLiKtSDDox8sa7o=;
 b=Tx3wSrt32X4wa1KOzRRPGrwGjWmRQHNRUIRAQBo2XO2t6V0p85xXVMb7DxACq4j6xVFik6eN7esD1SaFfjK/AOUsbSp9MJI3Tx5nZbsH0wOC6itL+U1JK2y2Sr85IYdHMjk+BXVrPrVHh5isdK8Kmt0FZPKN0LsmhR6VfGPevPg1Jav+fuT1hIrrJXWN04Arf+M19AywdBk/pYb247WljNVOaaPBXjIOti5NFeUy9sYR0zE73BXYgepnMyoQ2t9c55BTjqemQZi+WjH1O+JnEZLvgMjIMKckMrvIah9eOeGUvJZ7xb04ZaApD2QtNaGr8MQaZHLQ/FPAJKTSBv/hHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 07:57:38 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 07:57:38 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony" <tony.luck@intel.com>
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
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAEAyAIAAVvpwgAPafYCAABmgAIACIGkQgABOhYCAAA97QA==
Date: Wed, 23 Oct 2024 07:57:37 +0000
Message-ID: <CY8PR11MB7134A6BA8506765F7C3A9141894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
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
 <8a0c337d-ff4f-4da9-945d-12fe7119fef7@intel.com>
In-Reply-To: <8a0c337d-ff4f-4da9-945d-12fe7119fef7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA3PR11MB7553:EE_
x-ms-office365-filtering-correlation-id: f143c8a9-26ad-4554-aa91-08dcf3385cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z0hqSllHYkI5SkpRbXdxK3E2Y3dDL3VHTG83SUpka0h4QkZlMjNzR0xUS1R5?=
 =?utf-8?B?VnhuQXlTcHFwUDRweEd5UFlRQ0lIOGFGdWdIaHA3bmc5VzhFRXByZ01FdGgy?=
 =?utf-8?B?b0NHeFVxbzNKV1dQSDZrcjJlRHJraXJjZys2N1dualBlL0NUVDIreGdMc3RE?=
 =?utf-8?B?cDFrRnNzeFFpS2tXZCtadmlxbTgvSXY4b1lBWnRUN2R2aXNBYmtjTDh1ZzFP?=
 =?utf-8?B?c0NkaHR1bGUycS9zdkFjTUxNeWtOVml1NVI0ZktzOTRFSUpYT0NIaW9YV0li?=
 =?utf-8?B?VnZTajJKc0xRekxzb0NKcFYzbUhNSUh6STh3SjF3c3R1dTJCM1JKQ2hvb0NW?=
 =?utf-8?B?azdYQ3NadTZFYjNURy9PUUUxV1NiYUQvQVg2Z2loY1VmVmEreEVIQThyTmVX?=
 =?utf-8?B?SzMwSzJnanp4UFUrN3lmN3Q0NFc4cmllZ0JGckNlRXdTeEZvalcvY0doSFU4?=
 =?utf-8?B?K2lXdUx0Zk01M3pObjI0Z3VOSnVVV1dOZ3hjUVhhNFJROU1SZlRFdU5WOUNF?=
 =?utf-8?B?SzlVWnJiY1pWUzM0OTBnbHZ0NXlBNDk3UHBpZG1pS1VnMWRvS3VnMHJ1NmdJ?=
 =?utf-8?B?S1BKNzhPY09BeVBJWU5tSEtHSXhaeDd1RG91MGlKTTJHNnd2akVzR2xDSkJ1?=
 =?utf-8?B?dHlqOHA4aFp5aHlUMFh6WjlkVStwdm5DSHRGN3JTU3EzYm42MW9wUVVuOUJO?=
 =?utf-8?B?YlUyb28xNmlUNnZlV0U3MUtOT2kzblB5ZFhjT0FpSW80V2VibFpzQStSMGVz?=
 =?utf-8?B?eSt5SVU3N0FYVVhsbEZsMEhJY0RLcnRwVitDU0pJQVR0NDFvcXY2S3ltTThU?=
 =?utf-8?B?dm5VbysrNk85ZkZDZ00vT1l6Q0xWL1c3QWc5WnRILzFJUGFkSksrR242bzJt?=
 =?utf-8?B?S3diVlA1OGJ6RUR6TldXcXY4L1o2TUtrUm1heHNSYkJ0ZHZ2V2wwcGtUVEs3?=
 =?utf-8?B?U0NFK0VVVEtLRHczUEJNVENGVVVwOXlTVUk4cUtaRFZ2Ynh2YTNZY1R4eCs3?=
 =?utf-8?B?Syt6eWV0bWU2Ky9TUUgvRkdzU0NiYXBYQXlqOFgyU01tS1JxOHlSakhyVWZw?=
 =?utf-8?B?Wnp4K0xNSU9xT1NxSUEwMnlrQlRzOVRoMnlPQUtCbkNkdTNRS2phdis0T3ph?=
 =?utf-8?B?Qko3OHBCOGZ3anZTMDhoaHRHVFFtSWxZT29La1ZhUFljWHhQRjg5QlhDSVVi?=
 =?utf-8?B?a3hVWmsxRHdrQUZobjZqZG5TREF0cU5ISWdZYU80ZHVSMXE2MWE0Z1lIaElM?=
 =?utf-8?B?Q3F1UjFsZVZ1bUVHamtGN1ZHYzFWOFFNa3hORFZPcisxMUc2ajhHbjVDOHho?=
 =?utf-8?B?MkIzZ2RtUDlybU9RTHhFeGwrU0FoSFZTY0dBQUpEV0NOYkRBNSs1bFV0dWtE?=
 =?utf-8?B?aXp0eFF6ejBzS2hyUndRb3loK1pRS2JnMnNZK21FcWM5enNJOFEvNWRESTBG?=
 =?utf-8?B?clpHMmIzZll2Y3haN25ibmVyWjVMbXRZQjBFL2o4cGNocE5xSXRKMnNlckV5?=
 =?utf-8?B?RHJwczJBblZzN2lZcWhtT0s3V3R6UWV4YnBvY3QzM0RKdG10VXM5c3ZVWUVx?=
 =?utf-8?B?YlRDMFdkL1FSZVV5Q0ZNMGNLMFNTUFpGMVpDYk1PbEtBQU9uUGZrcW9Qb2Nh?=
 =?utf-8?B?K0FiVDNGYWpnUEZNQ0RZRE5YdmRPZkJPOXRjTC9CZVVMczlsUExaUEFxdmhu?=
 =?utf-8?B?S2pjM1c2K0syVGlFbHJIZmNYVEcyOGhHbkJQMVYwQ1JqR29IQzRuemFWQjls?=
 =?utf-8?B?bDhTR0FzM3ZXYXAxTTZnakxlcTRQeks4R2ZodUNRU1VoUlVpZVYrN0tOUkVQ?=
 =?utf-8?Q?8Fa3+dY+AFN63TNtPtf9sxZBn1t6DnNO+JEys=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE5aY1B1bmg1ZkVNK3FUazJTTWFnVHBBZkVLZmJ5aVRzVmJFUWM5UUpDSFZu?=
 =?utf-8?B?blNEcjk5VnFjTE9JWVR3d2c0TnZjRmNJdGZxd1lBbUdORmpwU2VRVSttWGZO?=
 =?utf-8?B?KzMrdEoxSnpTUUEzd3hZNnAvNFMxd3Q1R3ZPcGFMWXMwM0ZjWUdzOWZ4U1pC?=
 =?utf-8?B?OHppK1VVYzlGRlJqamM1aTRxNG5HNWxqQzVXNXZkUEszc1M1U0dPb25VUnR4?=
 =?utf-8?B?YTZXdC9FNStuUFVpY3FRMStTWDRjcjFXSy9BR3RMN3U1OTVNdTUvaGZSeUZR?=
 =?utf-8?B?T1pTMVNhcDdtNjNMUXlzcXZrQXprZXpMeXVhV1hCaHM5WFFjK0dWcHdqa2ox?=
 =?utf-8?B?cXRuNkpGeXBrbEc2aUpyeEU4MzBuN0w0VytDSXdkcXhXRmg3NEFHZ25XOFhx?=
 =?utf-8?B?WWpRdTNQWmcxSElaNkx2K2dUOFk3ZFFMczRwSDJDMi92M2VRczN6c0h6VGxx?=
 =?utf-8?B?QmFlY2xrT2swdFVIQ3hmZjVtNUtYZXh1UkZENTY0OEtVNkFqakhabnF0b1gy?=
 =?utf-8?B?eEc4cnhSTDUwdXRBc0I0b2F5a0IrVDFOK1hSOEpUZk5laE9lN0VNeXR1SmVO?=
 =?utf-8?B?Y1BnMUxRTmlJTXRPWUJpUG1JT056a3RZNmxQY0k4KzJQTmZrS2JpTzgrN3NJ?=
 =?utf-8?B?R1FCVDg0U1RxeGlQVXNZY2QxN2RSSFVZcXBhNkMyL3FTK2piWFFRc1VhcWJp?=
 =?utf-8?B?U0FpR05WTzROM3poUkE5ZkJtQTJlOGVyTFhoaHltcTlvU3hDUkY1cFlzZGtk?=
 =?utf-8?B?cDBUck8yZ21QT250aStwVVE5RTV1dlE4YjBxVmE1cEU2YS9sakc2cXh6a3dP?=
 =?utf-8?B?R21sQ1ZPekZlMkZNNnNxMlV4cFRLME04S3lTWXZIdmZxWUFzMU0weXl6cDQv?=
 =?utf-8?B?WUhvOWcrWWFjV0I5eXFJaS9McmpEdGhQZ2lNb3VvZU4rMDBUYnY3aFY2blIy?=
 =?utf-8?B?eFR2SGc4ZFlEVTdXV0V1VUpEMDVxSzlCaTYyUjVLQVN0Z1hFRUtPVkNHaGZ6?=
 =?utf-8?B?SmNQUWJEanZjWUxUd1lKR0VYRHlRQmJZbXpRVWxscHoyaURvampRb1BoSlVL?=
 =?utf-8?B?dWdCazlHYzlhRU1GT0ZmM0dTazR5MStBK1ZCQlFyeHhyZVlTdTRrSXVqUTlQ?=
 =?utf-8?B?VTIvcXhFT2lKN3dpeWFncHdEMkRHMlF5N01FZGtFaE5ndEVBbjJzYjR5cjl1?=
 =?utf-8?B?aGVpV1dLbmhjVXJGOVFaU3l6WExZd1R1eGxuWkJqZXJ5VDRvdW9CM29pNUdQ?=
 =?utf-8?B?K2llWndFVkMzSStZbXFKcWNxaEFhYjJSNVp5TEVObVM3MVorVW4wdldLNDhx?=
 =?utf-8?B?R3huRk9MR2Fqb0RTelJKM2IvNGRWTHQwVWQzOHlVQ2JjWXN6cEtNN3NXcnRT?=
 =?utf-8?B?ZUVaK1R1MVZ1MUNFTWxZUnBIc3phOVpHNlpHWTcvVEplL24xWVlnSVRrVG9X?=
 =?utf-8?B?MjI4U3pJZ05WNkNIenRnT0xZeG1GeHZTaWZQSUp1QStvajRkbHltR3RVbllh?=
 =?utf-8?B?ay9KK0JQZjdEZTk0M3VJcFFDVENRejdMR2FUVmdwV3FSbUNwMHZUZlVCYXlv?=
 =?utf-8?B?cExtL3phenJsNGJPWncyTHZnYzFHeFFoTHBLQWNVY2t3ZDBmbWZaY3R2eFUy?=
 =?utf-8?B?MEJiZmJZSmRkb1VyNXJBOGNnNUt3b2pPdHZFVmcwWVJjSjhab25aVXFTaFhZ?=
 =?utf-8?B?cjVLNVA5QVV6M1JENHVvMVNGNEpjSi80MmFSMUxDeUZHVEJBR0tHSEkxTXZv?=
 =?utf-8?B?MGhMZHRKN3lKNXB6YzZMYkVtRFBBamhkVEE3T21MV2dEcTBybGx6QWNpNzdk?=
 =?utf-8?B?Zm5QT21tMlhRbGVWdlE4dlNSZjF0c3lGMXA3MVZqRld6d2hzUzl2MUpjUi9F?=
 =?utf-8?B?YXdwdFM0M1dZWGlPNnFkYzh0MVdBdzJHZXNhdHN1VnE1ZGJjZEdwSDlTeXJz?=
 =?utf-8?B?eTJtMjlZaHo0V2UwSVJ0WmpZVi9MR2xxaDRsMlNVVzZrZUgvY2Y4TldQWW96?=
 =?utf-8?B?VDdOZ1V4dzlxLzNQaHdDd1RiS0xlN0ZLTUJhT0NxY05mRk1FajAxM2JwRVp0?=
 =?utf-8?B?M0tOVHpmZDF2dXl5ZmJYelR1WXFlcWFNTVBzSldvTXg1aWltK2dSak9EMmRz?=
 =?utf-8?Q?5OJt+bSBelrp4ldQJpnho1BAI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f143c8a9-26ad-4554-aa91-08dcf3385cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:57:37.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FskxXmWuhklfW2wPfx7L6Xd0x4B0ttv8P3+uD2Dz8+6t7vybiLUKbzgZZ3JKQLUyeuu6qdu3eOashk2UHi3dmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
T24gMTAvMjIvMjAyNCA3OjA4IFBNLCBaaHVvLCBRaXV4dSB3cm90ZToNCj4gPiBPSy4gU28sIGJh
Y2sgdG8geW91ciBvcmlnaW5hbCBxdWVzdGlvbiBiZWxvdywgd2hhdCBpcyB5b3VyIGFuc3dlciB0
bw0KPiA+IGl0IG5vdz8gOi0pDQo+ID4NCj4gPiAgICAgIkNhbiBzb21lIG9mIHRoZSBoYXJkY29k
ZWQgbnVtYmVycyBiZSBjaGFuZ2VkIHRvIHZmbSBtYWNyb3MgYXMNCj4gd2VsbD8iDQo+ID4NCj4g
DQo+IEV2ZW4gdGhvdWdoIGl0IHRha2VzIGEgdGlueSBiaXQgb2YgcmVhZGluZyB0byB1bmRlcnN0
YW5kIHRoZSBWRk0gbWFjcm9zLCB0aGUNCj4gcHJvcyBzaWduaWZpY2FudGx5IG91dHdlaWdoIHRo
ZSBjb25zLiBJIHN0aWxsIGZlZWwgd2Ugc2hvdWxkIGdvIGFoZWFkIGFuZCBtYWtlDQo+IHRoZSBj
aGFuZ2VzLg0KDQpUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdyB5b3VyIHRob3VnaHRzLg0KDQpU
byBtZSwgdGhlIFZGTS1iYXNlZCBjaGVja3MgY2FuIG1ha2UgdGhlIGNvZGUgbW9yZSBjb21wYWN0
Lg0KU28sIGlmIG5vYm9keSBlbHNlIG9iamVjdHMsIEknbGwgaW5jbHVkZSB0aGlzIFZGTS1iYXNl
ZCBjaGVjayB2ZXJzaW9uIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCi0gUWl1eHUNCg==

