Return-Path: <linux-edac+bounces-1888-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5497C4C5
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28312817CE
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6D192B86;
	Thu, 19 Sep 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4SUND70"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4B192584;
	Thu, 19 Sep 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730384; cv=fail; b=bEE9mnRhjDgJgVWcD5ml4akpboA4Yc2aujn7rnrzf4YmMLy8ZMui97rvojjPfIVi0BWcEOT1BVAx4LpMEeAYCsVhI4RqhpRLlQTIeNgmEpKIjvcKfjNmqdCayZIHlbxmMAVk/PqFVS0RewR8TjKcAjCbFbFhhtFI5YXM+D1MOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730384; c=relaxed/simple;
	bh=cpz61Y/0hKthBSr+AQ2rN2vFKLCxyJAFQGHJG8F2aeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZH2/yTdwCfuQaC9qvOiUJCY+4z8r6QCHGiO0nHZeY+hLgqnY+4f/c0Cj0PHaQBCcccMly9Z1HflJWt7kvS99m7XAhn6axw5SY+2a+vXfkT1k28+X9Vz1NDgp45LRBsCYNFDzJ8zcRtBKHceBLl6uWQzPloA6J99w6bG6IGlRndI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4SUND70; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726730383; x=1758266383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cpz61Y/0hKthBSr+AQ2rN2vFKLCxyJAFQGHJG8F2aeQ=;
  b=Y4SUND70RYRdlSQePidVTmfag+BZ0/6zFgOvN4mMNkRPu9wFu0kIXSXT
   VIESe3P3cZHKiU2exj7nEGOOaBU9z6WC0UVplpKpOX0lSJK18biVoZFo9
   3+iolkw6ZhtndPA12BeTtavEgPeaRaoCdylT5DVzag49V3IS778j+SzUC
   0U6I2jzLu6T8Qyxrxg4b0I76TRlekQD66w/rwDL8+EY+QatQ4q5S3zkcZ
   qunoGLOsOyJs/mI76kL/SmgQU4dDhQ1KHJYJVlVCP0MvuXAOkG2F2Fu/l
   gZ3m++ZegT9C4R0X011GdwgMfK0O8pzUmML1vXHF1c+zThiyu+yFi6KyL
   Q==;
X-CSE-ConnectionGUID: zZcO+VQoQ76isbhYIYNndA==
X-CSE-MsgGUID: 35+I+YAmTb6YloJFN1el3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25829370"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="25829370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 00:19:42 -0700
X-CSE-ConnectionGUID: Zw4GCTJCQNiveM0U5h51yA==
X-CSE-MsgGUID: oc06gxHRQzamB90DXuNgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="93118730"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 00:19:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 00:19:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 00:19:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 00:19:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 00:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0hHoeEifGNBW+eZSJ3RxvSL5Aizd63nEBevKizFJ89UmhYp1Y60HCI8dmh2IDfRcOZ7qXcPmwyKej1JJrjQe7xTKWtx9aocwuNLIc604FcY5gEceSOrVNBZ4byh4TRY8AL9ML7WfH9bp0Gy44qK+ZsSl7WliTOVD5xMCFcB/jn/839oguw2rT6yn5cmzx5SKaCC076HvVjS/BHzUMUKUPs5RsRVDtkB9aD+kdu1I4r+QkXiM7TYQDPStxveQJl6J67L5f03xfLppsjj04gmbiNIm/6an+RbeCN2o/sOkpeWDiyXsawcA+enHDS3jBRA0aJM/ap+GYYLuEH8Oi4EaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpz61Y/0hKthBSr+AQ2rN2vFKLCxyJAFQGHJG8F2aeQ=;
 b=I2aMqHcBa6fERF7eOkTqAtATzVzgCZNyW3pl2APdhPYBJlS7OZ+riLv/j7iympI2x3kNDumFR7qc5tloPwMJVV5H8lsB28VfXQIKh9ZXfaIZrvfmZbvw8VQqTcErex6FVVLqLKd+MGlXwMiN6+45vh1wkLymXZzmYb4uADp3NO8CVnErzoHXov8rpyp2azZVERIgScvZ6oI6RbcPfKRLTiEb1rI5RXjmgnIR+y5dipJ77TzwH7fFzZKGiuS0QEoRktMl2qNA1CpCIxH4RY1wkLiktfcYo1dxtviUCUVftc9ufgypd5iFjuU401sOlyLC6VyHRKyPKO1z27/zY91DQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 07:19:32 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 07:19:32 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, "Luck, Tony"
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] EDAC, pnd2: Make read-only const array intlv static
Thread-Topic: [PATCH][next] EDAC, pnd2: Make read-only const array intlv
 static
Thread-Index: AQHbBRYqpilgHw9ZJkOa+CqFj5nF5bJevGKw
Date: Thu, 19 Sep 2024 07:19:32 +0000
Message-ID: <CY8PR11MB7134F6951DFF67FDED364FB889632@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240912131730.588673-1-colin.i.king@gmail.com>
In-Reply-To: <20240912131730.588673-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA3PR11MB8024:EE_
x-ms-office365-filtering-correlation-id: 38d9fe35-d989-4534-8d11-08dcd87b6890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NENYd0hRZHpLK0ljMTRkSCtzNjhJQ0FuOFJCRkpuTEJ6VUdJZStxN21TVWlP?=
 =?utf-8?B?VkRGd3VveDRtWjZMRWpkSGE2Q3dlMjIyb3BaSGRGb2JFSW42R3M2dGtOeFJk?=
 =?utf-8?B?aVdZNkswMXF0c2hkRldQb3ZWZ0RlWHZxcTZmZFdQV0RaRGtKY25aVjlHT3B4?=
 =?utf-8?B?UlEyMnVoTkRDQ01iZU4vNUNvb1Y0UTNtU1pNSEV5NnE5ZFVJUk44ZTUzWGRB?=
 =?utf-8?B?eUROZTFCdXhKRng2N0pWYVE1TmlpQ0YxMDFmNDd2RndjeThxaXlGQVhRdUp3?=
 =?utf-8?B?TEtaclNkVnNNSy8rUmZVTDc2Ym5PZmR4ZGRXcDZzVDNRazhvaUNMaWM0T0tV?=
 =?utf-8?B?SWUrTmczWTRxT2lycFdDUEpTYkJ5TWIxb3R4clBoYUsxaVFTU3U2eXEwbTNQ?=
 =?utf-8?B?NHRNOUNkSVpEc1FjZjJxbERUNFBVQ0xUMzNYZk10OFErWnJnSmVGbXdnc2hm?=
 =?utf-8?B?SEpvUUQ2bmNYWkQ0OTNXQ0Zucm9MalJBZ0xDU20vQmJIMUJNUUlnNnZmY1hW?=
 =?utf-8?B?R1NyU1dTMm8reXdkYmx3SFR3UHRyOFhwNTZxY0pGSFVXSzNhUG0vRStlS01H?=
 =?utf-8?B?d0Zxemt0NTB1QURuQ0R3S1JpRzZ0QzJrMU1sY3g5ZXlNNjhtd3lEd2JjTzhq?=
 =?utf-8?B?R1RoR0gza1AxNGs0TDZBRS9MZlFNVmFVakpGSFY3d0w0Um1nUXhneVdSbUZy?=
 =?utf-8?B?OFNFUnV6OEQ2NHQwQm9yZk8zdnFqNnB4clZnNi9LcnRKVHB1UGNEeGhUMjc3?=
 =?utf-8?B?NmJlSlIvbTdKQ1dlNi9vL3VYNEdDczBXTnI1WkN1VGw5THdOOEc3MUJ0UlJ0?=
 =?utf-8?B?K29rc0ROYnRXY2J6TG0zOUdoMEtEZGZHN3FvUEhyN2JzTjRqdks1SGpZaW50?=
 =?utf-8?B?YklQdVFGN1drUXFMblB1cTc4M2dLY2ZtQ05kcVlKaTJ3cUNSWlU5VkdRV0Vl?=
 =?utf-8?B?cE1qbUIxcDZvVkwyTXpEeWxhYUtvNlc1eUFxdUFvRFc4cTZ6VkdCTzMvMHNl?=
 =?utf-8?B?UmJ4aTVQRk1WVjlFNnVwcXF5QmFRYlZTcnBGVFQzUGhsNWZzdjAyMXdodnBP?=
 =?utf-8?B?YkN5VC9BNC9adTkxU0lvYkIydEo2Sk1OY1pkSmxScDlmVU9qZ1pXZzJzSnJY?=
 =?utf-8?B?am0vM1Z2TFV6RmtyQm1RRWFtajZYMXVDY3JnN29lL3A4cjFhM0k3OGVNOEcz?=
 =?utf-8?B?dllBNjZLNUFETC9hVkMvZUtVOVYzcU1YOWdhWEE5U2k5TjJNRGFrUzJ5Y0Nk?=
 =?utf-8?B?NVBtSEZRdEI2OE4xMDNtRThmUG02Nlk3dFhtNmN4d2tKUHQyVGd5c2EwUGFV?=
 =?utf-8?B?aGtqajdTQTBxL1J5ZEJNTzlHK1hDQkV2bVFnbEJSOVpvOVhtcCtDaWc5SGM1?=
 =?utf-8?B?STlKUGJPMTRUMk9NWUVYNHRQU1F0bkZUSmkwVFZRYU9rYXk2R0tjK1dEL0lZ?=
 =?utf-8?B?T3ZzUEJUY0d3NUkwdERZN29pL0daL1RzL09WdUNUc29QWEppajhWMFRxUVRx?=
 =?utf-8?B?NlFWMVRrMWhqbGtVekZLcXB2S0lwVXdJT2QwMENML0czYWViUkY2L2RBQ1ND?=
 =?utf-8?B?bExTaWh3amlPNjRmWTZramVNOVo4S1ZvWkRkaXFCbHcyYVAvN1BIYXQzN1Jx?=
 =?utf-8?B?T1V6R29mQzNveFVNbzUrRlFxYTdOc2NxblV2ZmRuSDQ3alpHNzlweTBnWkpG?=
 =?utf-8?B?cHUwWC9lNW0xcXpINGxrejF4Uzh5eDNWQkJTQVA0Z1R1NWlYOFBTOXdqSnRz?=
 =?utf-8?B?S1VHZ1JiYkpMb2VxWERXMXBKWU1GYlRGbHlGNytmKzRuYm00Tk1FaHVKUzZz?=
 =?utf-8?B?am9vUHJWczFuSWo3REwrYzZ1Rk1HQjFVMXZRbk16eG10alkvR20razB4UnVB?=
 =?utf-8?B?SEZoMjQ0NWZGdWhFNDZyZEx4UWpvb0dOSnZLOWJacW9hWUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0krbjJmVzNwTU00cFNhOExCR3JBa1czT2pUUmEzT245L0FHeFFnMzU3TzNQ?=
 =?utf-8?B?ZUphRjdWNk5RcTVzKzBwTTZBbFpvVGhtbjBLU1B6TlpJVHlrVHRQNTVRaVVm?=
 =?utf-8?B?VlV6MmtUWE1WRG44WUhqZ3Q4Sm4xWVRGRUJaNzZRNWFqM1VvUkR3Zmw2akMy?=
 =?utf-8?B?ZlZaNTJNRkwvRjk4UGZSMGlyd2FlUG8xWERuS1E1RzZtTW84TjF2Z3ZyV1NV?=
 =?utf-8?B?WVdPamM2cVYrTEkxZk8xWkFtSmhmVGpFRTF3emRQdHI1NXVncFRrTDFZenFD?=
 =?utf-8?B?dWV4aXcxMzZacGVrb3cvdVgvaGxUQ3lyNTJUS1NHcWFIVW8rem1VUmFudWRu?=
 =?utf-8?B?WHF0OTlFYUE4WWZHbUdFU0hPUnJtaU5CcW83MW5tclNYZEJ6cG10RXlTZElM?=
 =?utf-8?B?bUVPOWhFTUtUSHgxU1pCajRidDltUjVxN0hvVjUzSlBmeVg5TVlxZU9zbUxH?=
 =?utf-8?B?MkNPV2JSSnUvLzZSajNuL202MG1iNFZzTGdGZDlYTytYSlNGeEtpTGFoMVNa?=
 =?utf-8?B?VlNHNVY1WWdiWit2c0FKcjc4eHpZU1hNaFFwQStoMERwSFZWaW4yS2E3cS9I?=
 =?utf-8?B?d2tyazYvWkFwaUZPVlFHaEpZUDI1dUpHa0xSRGhiWW5sK0JMMlM1TXJOeDhO?=
 =?utf-8?B?bVFBblFVbk5CYlBlRGgrSEExVi9CUi9CM2ZlTVFzL3FJOHhTT2QvTEpFYzg4?=
 =?utf-8?B?bTRubklKZ0tiRTd5aGd6QytxbERPVzhUV2hjcVk0amRwbUp2S21rdDc3VjBI?=
 =?utf-8?B?NEN4dFRWZGsxZlVmdGpiZGozRnp2OGpaVzIrSUo2QnhQNi8vTC9aWldBTnVT?=
 =?utf-8?B?amFEZ0I1MTFDMkFEUmh5blFxSFl2ZEQ1Kzk3TDlJeklYNDZyaGdSTE5ZN0xo?=
 =?utf-8?B?TUErRU80cHdMSkpTbGNPcmFmdDBOdzU3Znd2QmJ6eFlEZllXQm1VZFcwcW5i?=
 =?utf-8?B?MEcrMmlRbnRYVlBURExBN1Axb3h5V05GWUZ4Y0dHeFNROCtVZmRXc0JRa2Vr?=
 =?utf-8?B?eThrWFViMnpGUkxGeFUrOUQ3YnB4RkhnMFpHNlluY2hDLzR5OEhucVNUUURL?=
 =?utf-8?B?TWdFUHY5RmNmdGJpdWgvTkNadTJqMWk3QURyQWZya3EyWngxMnhrRTN0aGRX?=
 =?utf-8?B?TXM3RW5WaW03b0RTU0wvSkVKY0pXVVBKV3lFMm9RZGNYQU9CVG1yMVZORjVX?=
 =?utf-8?B?SkVnSXJOTEhISk5WSzRqUFJNcndycWpVQ05GVGt1Q3FqRzZKb2UrUHZxRjRU?=
 =?utf-8?B?aUZld0VrOGtpL1FjLzRHZmNlOVR2N05ZU1FuMm9IMlp3ZE5YQWFCZHlKTWhO?=
 =?utf-8?B?VE5jei9nVkVybzJXM3UvOVlwaEV1Z3hsSmtDSkZlVWRjZWk2SDJRaEpiZy8y?=
 =?utf-8?B?K1NxRXcwUkgxdkVtdFMxWFgwOStEZW93aVZRNHVwWGR5a3VBWlh3M2NiTXdl?=
 =?utf-8?B?NWpGMkNyVklwcUl5d2g3NnhxcUYrSTNvUk1lVFE1YzZBaWVSeXYvNlJyOEdF?=
 =?utf-8?B?NWVBYVg2cHhId2kwS2ZPNTJ3dm9FMGlMZzNDdSs2MGZoSUhTbjJXQzV2Nm5P?=
 =?utf-8?B?WGJiMjQrSm9JNC83V0RPV3lqQ253RFVkZDNmRG9wZUJSRjg2RE5jZXpTeWkv?=
 =?utf-8?B?R3BnenBXSW53YzZ2eDlqdDhoL3M2OXBrWXRJeDhSMXk1S1I3aEttbWxxR1Az?=
 =?utf-8?B?TmdnWHpVTUNjb1NDUk5HM3EyTElscTZjcGo3Z0ZYeEFpQUQybWN3ZjBHV2RE?=
 =?utf-8?B?OWs2cGtHZnJZMHVMQnhuNDBTdXZnVjVnQTM2ODZvR3U4STNoTzJsY0xtdXNX?=
 =?utf-8?B?d0szeVZveWpxeUcrNFlLcnYzeEU0ZmgwMEpaNUZDbWwvV0Y0c1gxRWxkbUtY?=
 =?utf-8?B?TlVxVEtaTWoraE1Hdkg1eW5MYWlxZ0FGUEFuSTNIaUl1NVNNeWZ5dVVyMHZu?=
 =?utf-8?B?dnFnN1poTTIvdHRqNWx3YW5MTHA4S3g3S05sVjF6azZjTTI5RkZpTlRaS3RT?=
 =?utf-8?B?bmt2QW1oRUlIZVhNdFRyUXgxZFJuOWVRbzU2ak1kZnQwbFQ5RXZrNjJUYmVm?=
 =?utf-8?B?NnN3VTU0U3pXbC9QN0E5WDZld0RuVnlmZzZQdU9IYUs1bUViUHREa0c0bjZU?=
 =?utf-8?Q?003PPIGOtCQ5TSlBj72CDBFUZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d9fe35-d989-4534-8d11-08dcd87b6890
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 07:19:32.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3N1T7tGOR9l7ogTWB/Cs6f1KMaaMOkLaMpXbjtwOXjbK0D5q6y0OLSJB3MrGnLp88PZoZDReucih7zZcxxeOcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

PiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gWy4uLl0N
Cj4gU3ViamVjdDogW1BBVENIXVtuZXh0XSBFREFDLCBwbmQyOiBNYWtlIHJlYWQtb25seSBjb25z
dCBhcnJheSBpbnRsdiBzdGF0aWMNCj4gDQo+IERvbid0IHBvcHVsYXRlIHRoZSBjb25zdCByZWFk
LW9ubHkgYXJyYXkgaW50bHYgb24gdGhlIHN0YWNrIGF0IHJ1biB0aW1lLCBpbnN0ZWFkDQo+IG1h
a2UgaXQgc3RhdGljLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGlu
Lmkua2luZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9lZGFjL3BuZDJfZWRhYy5jIHwg
NCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9wbmQyX2VkYWMuYyBiL2RyaXZlcnMv
ZWRhYy9wbmQyX2VkYWMuYyBpbmRleA0KPiBmOTNmMmYyYjFjZjIuLmFmMTRjOGEzMjc5ZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9lZGFjL3BuZDJfZWRhYy5jDQo+ICsrKyBiL2RyaXZlcnMvZWRh
Yy9wbmQyX2VkYWMuYw0KPiBAQCAtMzcyLDcgKzM3Miw3IEBAIHN0YXRpYyBpbnQgZ2VuX2FzeW1f
bWFzayhzdHJ1Y3QNCj4gYl9jcl9zbGljZV9jaGFubmVsX2hhc2ggKnAsDQo+ICAJCQkgc3RydWN0
IGJfY3JfYXN5bV9tZW1fcmVnaW9uMV9tY2hiYXIgKmFzMSwNCj4gIAkJCSBzdHJ1Y3QgYl9jcl9h
c3ltXzJ3YXlfbWVtX3JlZ2lvbl9tY2hiYXINCj4gKmFzMndheSkgIHsNCj4gLQljb25zdCBpbnQg
aW50bHZbXSA9IHsgMHg1LCAweEEsIDB4MywgMHhDIH07DQo+ICsJc3RhdGljIGNvbnN0IGludCBp
bnRsdltdID0geyAweDUsIDB4QSwgMHgzLCAweEMgfTsNCj4gIAlpbnQgbWFzayA9IDA7DQo+IA0K
PiAgCWlmIChhczJ3YXktPmFzeW1fMndheV9pbnRlcmxlYXZlX2VuYWJsZSkNCj4gQEAgLTQ4OSw3
ICs0ODksNyBAQCBzdGF0aWMgaW50IGRudl9nZXRfcmVnaXN0ZXJzKHZvaWQpDQo+ICAgKi8NCj4g
IHN0YXRpYyBpbnQgZ2V0X3JlZ2lzdGVycyh2b2lkKQ0KPiAgew0KPiAtCWNvbnN0IGludCBpbnRs
dltdID0geyAxMCwgMTEsIDEyLCAxMiB9Ow0KPiArCXN0YXRpYyBjb25zdCBpbnQgaW50bHZbXSA9
IHsgMTAsIDExLCAxMiwgMTIgfTsNCj4gDQoNCkkgZGlkbid0IHNlZSB0aGUgd2h5IGFuZCB0aGUg
YmVuZWZpdHMgb2YgdGhlc2UgY2hhbmdlcy4NCkNvdWxkIHlvdSBlbGFib3JhdGUgbW9yZT8gDQoN
Cg==

