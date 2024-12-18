Return-Path: <linux-edac+bounces-2734-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603F99F5C31
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 02:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071EC1892A2B
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 01:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19B1EA80;
	Wed, 18 Dec 2024 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0xRfU/d"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8F2F2A
	for <linux-edac@vger.kernel.org>; Wed, 18 Dec 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484899; cv=fail; b=Bg36af4d+e6ZOWrXdCJ9aC/iNA7r5vnPjsPPwbickCCnZIkVa930nOFY0d3Cq2SNVee0jETtvAkbS6P8aKATG2frHAc83w9p9c2NOOB3WvxHC/7vdKdO7zQ1mhoW3HdVLySURMA/4y2AsgU4NkQh3hnnz7hfHyq+pnFvr7vUaf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484899; c=relaxed/simple;
	bh=B2XxOTY0q3vy7lx5HomR1iNsHBaR7ziBrCxeFVYAevw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kez9nHEAtUHZKrDH3PY0Ka+MKUZKANSLdzsHI4kOPZUAHkqoOq0WTzjeJAcY+72LA3AQKOp5pRnigxfeYWeYtT3hVKHIfMk/UZKH+5EK06m7x5T1tpC/2BWyZpsLrphTBh7mG7tGqLQGYYtmleaO6uPS/QIzDmBPzg9+gPO1sJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0xRfU/d; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734484896; x=1766020896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B2XxOTY0q3vy7lx5HomR1iNsHBaR7ziBrCxeFVYAevw=;
  b=V0xRfU/d1u2JjWocyuJBZU6Bo/uQgSVtaoFeC/cA/TtKF2CyHIb3JJhv
   wThVxMiZYwS6Rvci3RjjizuwOQkuPphlxN7s3YaTeQblvlA0TL1LwQhP+
   rzUmkD7S2EyVs+vOtkt8XoEjNs4aeILX8pjecQWAs28rIxTYwvfUJblgP
   CfH51jGeDsuTCkVxjtgbWqC/k0Ke7VnnW/VXJdcSd0aMmK6++dXb+hQUu
   p4YY24/3I5JK8YQufKuwDJyVEcXXsrnitFx/4bJANAM+snRpQB0scY/Vh
   Xajn2xxmCtSKsSvADZZD2+c5UXqf3toMG/JuinqivAQpNF0fZyQjnchYQ
   A==;
X-CSE-ConnectionGUID: qoAmo6sEQDqiUtGaBI3cfQ==
X-CSE-MsgGUID: DHORaPOeTCGKbxAZwo3UBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35159379"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35159379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 17:21:36 -0800
X-CSE-ConnectionGUID: eeKTThWkQ3OKcyj44KBRmg==
X-CSE-MsgGUID: 2YM1w2kCR6OWLd7gQ51Rsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="97606102"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 17:21:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 17:21:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 17:21:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 17:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWSBhu/QyN5TCXHpAr0akibAd5ueLwh8mqBOduQLEV9945F3v/+3c7pvbP9IOZ5uvNDh99RLTwJwXUto+KWlzm1TvJ9ZSw3ABggxQsQTixO8zI6KFAneOXryFqp293Fm/ojmazh0dGJA4cmZewr7AKfNVegs4olUpS4axYWT9IQiR1m6z0pj1pLWNTlVpo+FVxerpHvButkNOEaDlIc3DGKWcL4BRCZNf+GxbP9dTlKKAgKOK47oOQ0YUF9fhS7Q9Vy9LrB+PSrNBfX9QhlFP5e6jWkARypWLrZQ310CLEp/7xWibYHPV2phaFsGFpSui17oJGceCGdfyzHywALtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2XxOTY0q3vy7lx5HomR1iNsHBaR7ziBrCxeFVYAevw=;
 b=ZPc8rszjsmlRjGmfgiFRveqv1cqtX0LAopYZKsSSU60IQrnWYna5Lnrlj9Et2+W1ebFYTyXsPrcrS9XWM/6/RDOfWnhjvWJnLxpZT0/mYF1Lc8/9pGNqjBZdyQ5LcHP1GRcCuk1XUZoVLKEJsNF6tKIMslx8V23wJI4uk2VcdqASV99+UjVu0JhR5VCcbHIEA4EjdrN02/N6zI651wAhbpg7hfDDwWBIaSapCjgif4Yf5EiVl97XHsDd5fcY5KmHGD/p/QGPtIZs7yqvNgyt+NfhMP6xnjDx9/T8da9V+qRbCK+otbQrcY+gX3psVu4kszMW+7BFvTxUPLYU560Y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH0PR11MB8234.namprd11.prod.outlook.com (2603:10b6:610:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 01:21:28 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 01:21:28 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: RE: [PATCH] x86/mce/: Make cmci_supported() return bool
Thread-Topic: [PATCH] x86/mce/: Make cmci_supported() return bool
Thread-Index: AQHbUJN5XZBI6zGzSkWkqaNvqmkHk7LrMo5g
Date: Wed, 18 Dec 2024 01:21:28 +0000
Message-ID: <CY8PR11MB7134CD07F072C6F3EE6C4EA589052@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241217145117.155990-1-nik.borisov@suse.com>
In-Reply-To: <20241217145117.155990-1-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH0PR11MB8234:EE_
x-ms-office365-filtering-correlation-id: a606fb15-fd8e-4bff-445b-08dd1f024c38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z0lRVWRVY0hialJVa1JFbDdJZzhteFhHdHB3Wm4vVE9ITWU5V05VNi8rbTNZ?=
 =?utf-8?B?Z21vL0ZMeEN2Ri8zY256SGtPS1ZOSWVLWkQwMDZSZFh0RGp5U3BlSlhHazhi?=
 =?utf-8?B?Z0QrcFpDb1pDcmVqMHpqRGFGR01uSXZQeUY3ek1EUTd6aHVsbGdQZ3ZScW5Z?=
 =?utf-8?B?UnBQb050YjNtam5palQ2c1hQclhqc01ZTFB6YktKYjBRMG9GSEwrYkVqYnNJ?=
 =?utf-8?B?QnlLQTlNL0lrTUNMd3FyMTBoeTh3a3pINDdBdjJCZWdRQW9xMVRWNVovZHNK?=
 =?utf-8?B?T005OHVzK2V0NkNpUnZnZjc2Q0dQZzQ3elpGZzcra2UvNlJWMzNyUXExeEVO?=
 =?utf-8?B?emhaL1VBRWJrMVNHUjFTK2gwY1dIOXZYaTQxd3Z2UE9PM2hZeDdqZCtKQVNo?=
 =?utf-8?B?c2dOb00wMVdIWTA0NDZWbVJoeTJGLzE4SkRWZXRPZkxSbHBFSWdKUk5CN3pF?=
 =?utf-8?B?ZGJUNEtRS2tXTytwdFlEMkhESzFTT0tWQmdtV0gyZDM5MzA4cVlnd1E1dUs3?=
 =?utf-8?B?cHMrYVE2M1laZEQ5d2tXbVhRN2dFTlFMaWNlRXVReDBkZlNLZlpBcnJlQmQ4?=
 =?utf-8?B?SmNhUWI1Z2lsNzRtM3hCQ3BNNDd5VGNnZlJsMktOcC90TTk1R2QrU2h2Qk5B?=
 =?utf-8?B?cEcybkdoQkh6aXBKS2NXVmpDMTFENS9jR0tSRVhqdi93VGhHMXpKaGpJSVkw?=
 =?utf-8?B?TVg5ZWpJOWwvUkVNVFk4ZmFxR0Z0R2tFbVZtL0g2NEluN3h4MURCZzVFcDZQ?=
 =?utf-8?B?NjB0cGRRSXo0bDJNK05Zc1dyM3o1bUN4Mm1PaDExVTRsRXZ1YlArVkNrVVBH?=
 =?utf-8?B?aVdCZGZqVXNGeDdaNU9ieWR6MU8yOWs3WHNTaDRpUmNHazNSUjVVNFRvc05X?=
 =?utf-8?B?YWpKd0M0Rnl1ai9EY2UvbzlKRnJYRU8vK2l2ZXlKdGREcElGaG4xWXJOVWpY?=
 =?utf-8?B?OW1zdmhQSEhwL3RnSG4xZVgvN253MGNHR3lrdDllVDhVbjdhQWFnTlQ4ZEhu?=
 =?utf-8?B?NTFZckpEeDZWWFEzYmpzT2FkOHVQbUVoK0ROeDA0RVN4bjBRVkpNMEQxaDBw?=
 =?utf-8?B?am9tck9pMS9hMmxRTmRiY2RCNzkwQStFNzV2WTZWWkdyNG9yWnlCZjNENHFz?=
 =?utf-8?B?dEdqVU5nbTJ4QVhWTktyRXpPMHdoM2R1VExiVHNJVWZjZ09iTFlNL2ZEcE94?=
 =?utf-8?B?VUg2ZHNnT3hwbTZUWkZudlk4U0FCOERIS0VwNjMyRmNScjhSVzJCS0diK0dJ?=
 =?utf-8?B?REdUb3ZKYjhsOSswMTU5Z1NCT2d4ZGFiN0JEMmE2WUMvRyttZ3VNN09jQnN1?=
 =?utf-8?B?a0Y3UXZiMWhqUEFlYmlFbjJoaDN1UGl6N1pWUXhPejZJTWZoVVJMRnBEbVE5?=
 =?utf-8?B?c2xjanhSRWtwdnhTNWlSNVNIaUFod0lCRU1QdHpJMFlZTWpkVFRDb2FXWXM0?=
 =?utf-8?B?YkpyVWtEb3loSVB4MkJCUVRadWpIOFRwS0J5Wkxka1F5QzZMU3psVFhHNW8y?=
 =?utf-8?B?eE03MG9wTEtnRFF2Qll2S0Zra1NNZ1FsbDdEYWlqNU9QRE0xS0ZDaXloaWNL?=
 =?utf-8?B?V2E1QUMrcktzc2ZNTkttYXJIanRQbnJWSzJQZGhNN3cxMzBBWlIyRk5xcEJN?=
 =?utf-8?B?WmhZVjFhUEdWV0tGajdldHhMY3VtWDhrUzFFKzNKWHlweVN1WG5FbDVwR01u?=
 =?utf-8?B?UjFZYjk1RHczMUphUTVtMDZSL0U3aWRRS2hVcUpoR0RHRWkxSmxZaFBsRjdN?=
 =?utf-8?B?MnJHSlRNMDhtMnU4TXJvRFUxTkluMlZIQVBRc1NXd2FUVUZhMTJVREpBZ0Qr?=
 =?utf-8?B?cUNyRHJta1pxWWx4YmxlUmp5S21FTVZodnpieDNCR0ZLWUdoTE1aYjNRZytR?=
 =?utf-8?B?RGVHcFpyOHUvK1J3N094aWg5ekJoNkpZWGE3cFUvbkMydFl6SVo0MmtOWmdE?=
 =?utf-8?Q?sEfagOXcFkle8S7Eh9djEpnh2b04pyTK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1ZZSW5HNHRqMUtGVWdkUDduRS9pdjUzRFFmNmpSOEZvMHV4TnduTXlFWjQ0?=
 =?utf-8?B?TU11NENxVUlhZUNEK3FDY29HUVlWcEhHeWdZUWc3ZXBtRTk5QXArMmpGUXQ3?=
 =?utf-8?B?TC83NWNpK0dwTE9ObHpGR2dlWXpjUVM1WlFJOG11MEFkRVd5cEM3c0lXVFBE?=
 =?utf-8?B?cXIwRlBNY3RaNEJTSnJ3OXVyd1FGVXRjMWlyc3pmTlY1YUJON2ZYQ0RQSE9Z?=
 =?utf-8?B?YVY3Y2lFd0pvQkM5blZpZm1sUWwySFQ4a29JQ0ZUdHI4eWRPdTJGR25LUndU?=
 =?utf-8?B?YUl1NFJzNE1TR2YvamhvMmNWMTNSaDM2ajU0MnBOV01kN0puR0N0bHhjTDVv?=
 =?utf-8?B?NlRBU2lFQjBjRWVRTmFzN1VwYWt1NlZQSHNoSXVHNjRyamN5Y0xEZWJGWWJk?=
 =?utf-8?B?NDRIT0JzQjZ4MEpzTXY4S0ZNa3RCbkNxQWY4ZFpTZGg3dFFDV2xxQ092dkFu?=
 =?utf-8?B?ZzY5RFF2N0JJeFNnclFOVVhMQXo2WEdoTWdRYkYxSjB4czhrcXdrd2Y1WTZr?=
 =?utf-8?B?ZnpEU2JJVEhnN3dVUktvbTJlVVhKdUk0ZEdyNmlwMkE5TkJxTmdGL1RZdmRV?=
 =?utf-8?B?am5STVZmOUx2cGZVWVVxUTNnSW5NV1Vxb2xjQ0d2N2tGZ3dZV3Z5b0JoWkdT?=
 =?utf-8?B?aXR0UURvQlRJVk5xcVd2Z2sveTZWbWxYVDVXZnlIdGszY3RLM3QzTUE5aCsx?=
 =?utf-8?B?MWNrbWY4Q0pYeUJYcjJ5R1o4MWF3K3VwOTJqQzBUaHc1SG14bmFtVVVtNkhJ?=
 =?utf-8?B?TG1zd2JxaGNLZkhScURKODZoaHJlWFRhWXlqc20vYTlBMkxmUmxraC9McTYy?=
 =?utf-8?B?M0JuYlFzdDVrMVZpZSs3ZmVrODMzYW83YUZ1a2NqNUFYK2JCQjJDUUJIKzl2?=
 =?utf-8?B?bTUydUVySWQ4STVpMkVSMURYbGdRMlpyTGNqZ1pvZWtCRXJUQ2VyQUtzcHhI?=
 =?utf-8?B?dk94OVJpMDdoaFhQdzlqL1dWT3h6anM4Ryt5L3ArTXVnckRBckl3NkxWSHRj?=
 =?utf-8?B?TDN3ZlZwSG41eVJIQk1QVGhyZFRkR0N6ZmllTCs5QmZMdGRXTWhjN2dBTndv?=
 =?utf-8?B?NWxpOFh0cjZyS3lObm03K3Z2aTAxenV2SjZHamRxOEc2MHN1Z1JiejZFM2hp?=
 =?utf-8?B?bTNtTGZ5MGZ5a2JyZHE3akRwMVpYbXpsV2NlUktSK3BJVnBPbGF3SXA2VVZj?=
 =?utf-8?B?K295Ui9jb3NYVHlRK2lQTS9OaVNMWWpVNjJ4c3pUOTRWaU1EUnBMaUJPSEVl?=
 =?utf-8?B?TlpmV1JPRXcrdkdubGkveHRlRUdXSnFKLzQzYWhKbCtQTm9OMTlwWTJXL2NX?=
 =?utf-8?B?Z3lLanAzb0p5ZlJJWk8zV0xVQ2J3UXBjWmoraFNHS2JacDV4L2l2VTJsa2pF?=
 =?utf-8?B?TkFSWTkyNzdDdmFZRWdRdmxMTGpHTnFWMnM0aWhYMzVMNTJNSWFMRWo2d3RF?=
 =?utf-8?B?Ly83TzVKd25NZGFiTDZqMHVzSkphbmJRMk11Q0J3M0krdHhlNTRIaW15Smw5?=
 =?utf-8?B?K1Nib3BMZUtaWEpYU0NkdDh1MEljelVPVXp2MDcxZU5odHpuaGFuWFlGYmND?=
 =?utf-8?B?MUhXSEZubjhXL0paMVpzMTdFc1ZkSzI4SDUzcGlaM3kvMVZuNW00aWNrRXVN?=
 =?utf-8?B?eXFYbUgybVlrY0hBVWh2cnhTWlVLNUNsV1dZY0wvMWpBM1JUZ1phTmlMWlFx?=
 =?utf-8?B?ZjR5TVZ0dmtDK3IzL0FqQlZKMTE0bnUwaFBYWkxCZFBvbEgzWXZSWDhhYUdW?=
 =?utf-8?B?WXIwVzR2VmxGa2h5VGF3aFJXKzBqNVRrUjFJWnBaWmFJK1JSR0gwSnJRTkw1?=
 =?utf-8?B?UFFXZnVNZFM5RzdzZXlUQzZDMWNmQjByanVhR0FxVnFIRmVuc3JQTUJaOXZJ?=
 =?utf-8?B?dFU2SDI5VU4zdlFDZWkxRzZBdDIyUGZLMUxDdC93YXNsanA0eTlmSFdLaG05?=
 =?utf-8?B?V2RJdFNpWmZucDJYbDVYMSsxTndvMC9QQ0kwOWxBc2ROdXp2V0xVN1FOdHRJ?=
 =?utf-8?B?THFGUnM2akFlMVcxL2VNbmJ2UXE1U2ovbzhpWGNVUjU2RVNHZDNTaHZPMGtn?=
 =?utf-8?B?SDAwc3l2VzRMek96akMxNWM1dlRCNkp5MytLUjI4Z3BVNUNQUUMrWEloZlpS?=
 =?utf-8?Q?WprGsAd3rAmXPwlFlT8tDRT4K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a606fb15-fd8e-4bff-445b-08dd1f024c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 01:21:28.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYyDzdrAM2tDbGnsS7tSfzQpgiXgxPxuOwZH9y2rA5VYez6p9e3JK3xZaFq2Ps/of7oKwldV9h5Urw/atryO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234
X-OriginatorOrg: intel.com

K0JvcmlzICYgVG9ueSwNCg0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1
c2UuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxNywgMjAyNCAxMDo1MSBQTQ0KPiBU
bzogZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tDQo+IENjOiB4ODZAa2VybmVsLm9yZzsgbGlu
dXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IE5pa29sYXkgQm9yaXNvdg0KPiA8bmlrLmJvcmlzb3ZA
c3VzZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0geDg2L21jZS86IE1ha2UgY21jaV9zdXBwb3J0
ZWQoKSByZXR1cm4gYm9vbA0KPiANCj4gSXQncyB0aGUgbGFzdCBmdW5jdGlvbiBpbiB0aGlzIGZp
bGUgd2hpY2ggaXMgbm90IHJldHVybmluZyBib29sIHdoZW4gaXQgc2hvdWxkLg0KPiBSZWN0aWZ5
IHRoaXMsIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pa29s
YXkgQm9yaXNvdiA8bmlrLmJvcmlzb3ZAc3VzZS5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYva2Vy
bmVsL2NwdS9tY2UvaW50ZWwuYyB8IDggKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvaW50ZWwuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVsLmMN
Cj4gaW5kZXggYjNjZDJjNjFiMTFkLi5kYjA0MzZlOWM4OTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2ludGVsLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvaW50ZWwuYw0KDQpIaSBOaWtvbGF5LA0KDQpJJ3ZlIGluY2x1ZGVkIHRoaXMgY2hhbmdlIGlu
IHRoZSBmb2xsb3dpbmcgbGluaywgd2hpY2ggeW91J3ZlIHJldmlld2VkIGJlZm9yZSDwn5iKDQoN
CiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMjEyMTQwMTAzLjY2OTY0LTItcWl1
eHUuemh1b0BpbnRlbC5jb20vDQoNClRoYW5rcyENCi1RaXV4dQ0K

