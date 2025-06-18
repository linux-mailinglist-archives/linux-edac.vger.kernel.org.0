Return-Path: <linux-edac+bounces-4176-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E6ADF4FC
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 19:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D2E163493
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106B2EA74E;
	Wed, 18 Jun 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ7JNwOi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C21E570B;
	Wed, 18 Jun 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268791; cv=fail; b=BNnhaJvYxc+muySRrpWMvHhABO6TNjXSBBGJKU7w1RsXiosQb/2k1AuRoOw++6T2IUh45/uRvLG9OUhKFZPGPPMohCjZY9HRsVI0o2XMDoz4+47VaDwtKYAeHBOvwAKyzXpl0piKLt4fL3lCmYTsxDHhzbesNIf7cRd18FLjVYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268791; c=relaxed/simple;
	bh=Rb+FfU/mwZ7FabpL5Kgi1UJ1hj5mBqgu6KFHFAFRd5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fxzli/ZFdVmpgljw2eBTyYt6GvLFJwclbQaZhC2Fat6jc3Nwu0JFKYKPCgXEfL21RA2ZWtBjlA381xv/ZtuModcU5E35CmHHyrUnU1PwQMURIQq26mOmnF1SgbRXBW0EwjAZTL/7Ye6U83QYFtumgip5EeIo7b6EvA6ZNzbEQXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQ7JNwOi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268789; x=1781804789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rb+FfU/mwZ7FabpL5Kgi1UJ1hj5mBqgu6KFHFAFRd5E=;
  b=OQ7JNwOivptwHjCknGvtU2Fo2J1Qu2n5kU/AWUxHrMxSwoihGltfSg9r
   rgH9h2rLsfUdJPssocYX7L7lpNIaNppaqmm9S7lCidF/QVDWbEf7I6DPg
   wBRwUHhERxd0NZSYp5KKvlA09w3pd+kxcZUlZwbqIVe3i/8VbFfj3e1gs
   6wIHBLcLu+2YNOxBu8vuNQ9MzTDN2MunjAUfSNP9VjQo3NK45tNPTIqI1
   H7mmr/v/sG4euBrGyXPEoNzb7UOi1HFtn6g6NRhFiY6i3LBFZoPj7k42Z
   38nTSQKJxBnxCkphuyHgLebBiEaLb2RbtzjzyT9FTQ/+xCHP/l8K0ZYOj
   g==;
X-CSE-ConnectionGUID: dGnjhPdFQomqtw98uAUlKA==
X-CSE-MsgGUID: gjxsDR56TFu3QhqCOW4j4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="77906729"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="77906729"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:46:27 -0700
X-CSE-ConnectionGUID: ZwrsipBcSZyHieVRQbefwA==
X-CSE-MsgGUID: LO+BWj82R0iReAaZCj1cdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150639693"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:46:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 10:46:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 10:46:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 10:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWtrmc8uAY5uRCHg5+D/20ujrB0Si+BnqeVosiFpQtocbYK/qjSduUXA1lWu5KoKD2Ku39YlQqElSxaZ7TYzdleCWVsToVYwDalRXubfTVbZndzGRrd9Nkwfeoqlye+V7rhdYZkJ5hdH0pji9DdbRahcnSdQJiXtZpkj6du5AGfTyUDxljbkZsFSklBr8rLdkiN2haEfXsoHziBG/bA4OQOas+5V+jm51bY/G0GNnhTm1KX8jF8TnJVCA4mnYH8PQDYgsmMD5WXOs0zrsRGQvd+gG0bmf1A9awG3YavpNTaYnV1N+4BgpUUB+wGYJHyfZku0KbbaaWh5tAHdmGhX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb+FfU/mwZ7FabpL5Kgi1UJ1hj5mBqgu6KFHFAFRd5E=;
 b=pGh2IxYU021mRLnp2TIeg+b/zeIDNVfsRD3orCompX3XgONiM9D5JVaogITM0sY7RqZnZFvWw9d1u1czVmBD3qzFY3hZuIi8jgkjZpIS9+VByETtzl2B62wKR3sjcDMM010W1eoO+hPBdd3clrgUlp2RMBrkgmev7k958TpmCQS0WTl5XYMiycEvcVGHGrPeVSfaBe7kkkerZzCbhIgqNdpN0tANGB3ApiEhNtsgBX+KmeTfu72nz0saqu3tmtreBbkE5Gl1URrGyuBYS7hUZTRa9GPz1gDhcUUYg2rkgBDu0wi7cnC/gL/Y+hLWOHf8y0dlGMf9C/+g9DqotKMdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 17:46:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 17:46:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "james.morse@arm.com" <james.morse@arm.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "marmarek@invisiblethingslab.com"
	<marmarek@invisiblethingslab.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>
Subject: RE: [PATCH v2 1/2] EDAC/igen6: Fix NULL pointer dereference
Thread-Topic: [PATCH v2 1/2] EDAC/igen6: Fix NULL pointer dereference
Thread-Index: AQHb4G11SXE4qH6JAkeHjtR8c1p/tLQJMF4A
Date: Wed, 18 Jun 2025 17:46:23 +0000
Message-ID: <SJ1PR11MB6083A3234879FED2522B0148FC72A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <aFLV2YMOzXe4iP-I@agluck-desk3>
 <20250618162307.1523736-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250618162307.1523736-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB7517:EE_
x-ms-office365-filtering-correlation-id: 49086d56-f2b5-400d-5ea4-08ddae900a97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlIxcXFRWElCZUdXRG9NcjF6cUpUWTVrVHRocERkZXk3bEhWV2prTkhVOG1Q?=
 =?utf-8?B?cnlSN0JQM25DRnlFM3Vra3oxSUxqMlc2VzlaYXNFejl3SkNGeC9uVXRYWU9Z?=
 =?utf-8?B?MFhlWGxXai9rV2o2WTRqVFRvL0V5TE9BL2xRNU1ucmxST0dnQURhQnlGamVE?=
 =?utf-8?B?eWZ5eDhkVTJsblZaTmRZeldWS3dRV0UwVmY3WXdhZGxFZ0tSWXRrSXdZenVm?=
 =?utf-8?B?eTZvNGNtVHFiaDNUSWZCV08vSmtEWXdtNUJYREFvV0Q3N2dqclNrM3pYVlRu?=
 =?utf-8?B?Rmo4V0F4LytHRzFDaGUxRDUwUU1zRGUzVEI3UkVoSGh0WGpDWGpYOSt4R1Jq?=
 =?utf-8?B?b2dHVUF5ODVSZEhvalpVdSt5SnFMamFISEIvb2syazFrbGlvSEpGSGhtb0JF?=
 =?utf-8?B?N1JQT3IrQmdQRmp2aVhaNU9nM096YlJrcGYzNkVKNXpKWWJrbG1MM1hEWHFS?=
 =?utf-8?B?M3ZXMG1lZnpvdS9YNjFNZHk0ekxSd0VicWtLdG9ESFZkMG1UM2FtWHBKV3RC?=
 =?utf-8?B?dlVjeUxqNmpsUzFGQUNIR0hWZnRvaDBsSEhuaGlWZzZGWEN3RWJMU24xYkQ5?=
 =?utf-8?B?Z0dxYk5VTFN6MnNsV3dxTFo1NS96aCs4citUa0pPclNWcWJHUmluNzVVMjUz?=
 =?utf-8?B?WE9pTU5XbUVSMjJrQVFESThZZ2ZzUGdFNldQSjRBb1kvSDJOd2VVMnBFTDVQ?=
 =?utf-8?B?VHdJUjN4eFJ3OHdsYUY1WDVxRm9uanBCVWQ1L1Y3MElKY0ZNbUNGdEk2S1NS?=
 =?utf-8?B?TXVkVk1LYmRnRk9oTnFRdFhQQlJSaFJhbmJwSTdtM25KbHovd3Q3L05vMExi?=
 =?utf-8?B?QWhwQ1dQcDVNdHcwdW1zZjA4ZWxyZVdtWC9tOXorZmZtcWlCNHBkY0FDVnc1?=
 =?utf-8?B?ZmR2RmZaVHVqaGU3QUVkZjRvbnJsZDVqSUVnR2NRQ2Z3bmRVWmd0MkQwSTND?=
 =?utf-8?B?VHRndVhMSnBoM3RnbzBvVGFvRUlUWHozSE5lb2t1eFU3NnBkVnY3VVR2a1Va?=
 =?utf-8?B?a2dOZUlYSG10a3Zqam1tRUZPWFQxM3VLR0lmc1o4Vis2WXlnNUNPd0xDK3NN?=
 =?utf-8?B?Wm56TklDMktKM21wNThyZ3NJWHBGK3Y3SllLZU55bzlWSGQrZXUzR2ZkVWdi?=
 =?utf-8?B?RmRFTEpUd01VMUkwek1JWktlM1ljZTYyMnhOMHJIMjFUcWNnWmdsT1hOdHY4?=
 =?utf-8?B?WktDQktocVE1QnJ0M0NmTkROK0dvWnVFa2FZbHpYK1pDMXVxSERhWEF1VThp?=
 =?utf-8?B?RlhobVgvVll4Y2w1OVVPN21KQjF0R2NPUDBHMTFWUWJhVnJvOHBwbGV4ZENv?=
 =?utf-8?B?VGgzY245U05ON0ZtbVNZdlRYNUNqc3QwWXlON1c4UGQxU2M1YjJzbFo1S3VI?=
 =?utf-8?B?R3F1WUs5anB3SCtYdnVYcUlFOWpvb2JTaHg4Z0x4QUJJR3V6ZTVBeEMvZDNw?=
 =?utf-8?B?ZWNldy84bnp0dmJaNnBSZ1huMzEyMDFuSE9VTWZFTk5rckp4bVlDSnlFN0sr?=
 =?utf-8?B?amxuYk9wWjNabmtjdUVHZlFFSDRFb0ZEeEZ2ZXcvNU1UbW8xNExYWHk0NS9F?=
 =?utf-8?B?OTlpRkdkNXJEYnVuSjRKVlF3UGNnNkJVczR2NHl5S3pTODdOWlRiVzJhUDN4?=
 =?utf-8?B?VE8rSGRUR1hYZXNQMU9vT3JkdmZSQVhIbUlqQXpCQXNQUnJJL2lKRGdjbTFi?=
 =?utf-8?B?bEcvRW45TkZ1b2RRenlxRmdUUHIwMXhQUlZ1aVFFRWQ2cXFZVEk0K2d5WlN3?=
 =?utf-8?B?MTRTTGZLR3g4ZE5yNk9aa3lFYkYzYTY0Y0pKcVJNSFV1cVYzRm1lV3MvZ1lk?=
 =?utf-8?B?ejV0MDlQTmN5VXNrMytmM1BSL3VLNkFHSnozUlFmZFBPYXFuTGNWRDkyeGpJ?=
 =?utf-8?B?Mk5SNzVheWpWcFd1UUwwVmlMNGRaT0h6VWxhZG91WGpycE5KSDRMeHpqaVcr?=
 =?utf-8?B?UkN5RjVHYjZtdTNmckxuL1BTN2dsaHliYTNOaDlZQVQ3dnEvdERTc29EN1Jt?=
 =?utf-8?Q?S+0q7s7ddOkKuKQUnyMNU6f/09/GLc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmduKzl6eVl4UzFkK2twSTV6TXh5ZjdkSy95eTJRd0NoVmFjTWpuZ0RGYjVD?=
 =?utf-8?B?ajNJOEYrenNsWXp6MlJBd2Z6ZWJjY01ld0lkYTVmaVg4d2pIOTF5Y1lvcWlh?=
 =?utf-8?B?WnVwemdYc0tCckU3dm82TUNDL3ltUWRhdk0yK2V5SFZwMDZPdjlYRWtvck04?=
 =?utf-8?B?OUlhcTZMSkMvdlBQY01sZFRMNTV5KzBJMkFRU1gyV0Vxdms2dXczTGdsOHFk?=
 =?utf-8?B?dUJBRXJTMWs4VWFlbnpOOTNJOEtpeitudG9jVlgvNHdqditiaU5uWEc1K2xB?=
 =?utf-8?B?dDB5ckpZK0FCZFRxOGFTeHVMeGI4VFI3ZG1tb2xPbU1UQzM1ZFFIWFMrcGZk?=
 =?utf-8?B?Y2QrOE9KeWlHbWw3cXYrcld3Y2dBbmYwR2xqc1JnRFRqNW1nMDNSQWZ5TDRu?=
 =?utf-8?B?dFlEOEMxZVZhZDhNOVhqZHFqdnl6QkdQVGlIQWZoczJPNVdBaG9vOVVHMzBR?=
 =?utf-8?B?YXcwNFlVS0VqUTgzRWpLdVB0ejBmZnIxeHpUSnFCeFJpeVRKV2E3TnlqL0oy?=
 =?utf-8?B?L1RscytyMDhnUWJLckNhZGNvazhJcGFvajRTUTZGZm5HSnZFNGFORy8xQUVF?=
 =?utf-8?B?K0kwWVVEWkF5cXdyb29mODJIcUovdzE5OUFmT015ZlNmNExLcGxrcDNRLzN2?=
 =?utf-8?B?aHlENXd6YkwzdEkrQ1BCczlWTno1OVZyeGt1bENSYVIzNUo3MXZaRDVKUkJo?=
 =?utf-8?B?RlNrOVlBRE54Z0QxV3hkYmFTOHJUUXhTQklnMHVxS3pGdVNkTzFCZkovWDNp?=
 =?utf-8?B?UE9PczlIV2xlUy9TZ1h4eDZYWVhOT2lIZkVabkk3eE90UXJkeDZQR2ZQbEQ4?=
 =?utf-8?B?VHE2Z0hTSnNoa1pGdTA5cE1VNGpJeksxQzEweXd5Tldabmd6WnhWMi9kWU9S?=
 =?utf-8?B?emNsSXdyVlVpem1Hby9FdlBqU1h3UUhGSGNkUUlVallCUW1rLzFubTlsb3J0?=
 =?utf-8?B?SnRabEhlNDllR1U4VW83cGwwRTh3d1ZRL3lpUlpYZFhZR3cwc3JEZi9lbS9V?=
 =?utf-8?B?NFlVbkxEaVQ3SWozNkxTZ0ZHQkJTMGFUQTRZWDZ5TnJ3Y09TYXZ2OTdyNW9n?=
 =?utf-8?B?eWNOSG5EOXhDSk1BcmNnTVJHSkcxeGgwcytoZjJQRFJ2SVVoOEpOMHprcU1p?=
 =?utf-8?B?MVZnS3VEbHdyWHVsQWdYQ0QyUm53VDRpUnAzeEs1QWRMS2ttU01aSjJJbGlZ?=
 =?utf-8?B?YjRldFhlcFY4ZkVSOXJBNjRZUVcvMVJDTTB3NUVsQzFxKzAxZzN6WlVKNU9n?=
 =?utf-8?B?Nlgrc0p6d0NEZDdUMW9zMUhMMEk0NUZOWUhxMisySkp0UTZUWEVvRjZYV21M?=
 =?utf-8?B?aGxubWFWa1lwbS90aHk3cjhxV25RZldJMXZaV1cvSUV1bHFZS1VmVnZHV2V3?=
 =?utf-8?B?cWlpNnlCc0U5azkvOTJzR3NpMjJjYzhJLzg4TWtFQUcxQ3p4NnkzUXl0dURu?=
 =?utf-8?B?TU5ka09TbFhMRWFkNEMwTDAzYWRrdDg2b0JIV0E5ZXdjUDhScW9lV0JLU1lt?=
 =?utf-8?B?eEJPeEZ5bzRFZUFOVG1QRmFkWUFhRXRIZkxramFrL05nY25xZGtqNU9ZRWQ4?=
 =?utf-8?B?OVppRE5LQUs4cTBPR0p6Nkxrc0EzWGNvTkdrSWF4NGM0eWtTT25NcEZIZC9x?=
 =?utf-8?B?a3dhOEUvbW45MjRmYXVpaXN6aVg5S3RGYmFkK3IyaWNhZDY3ZFFpeUdXdmhn?=
 =?utf-8?B?K2syWnZ6N0lCWmZuY1ZPUlZ1Vzlwa1pSZkI2S0tpMy9EeWR0RlI0b0VmVFIw?=
 =?utf-8?B?L2xuR1c0eW1jM0M5d0o0QVQxNFFaNllyaHpQNWZUV25Mdkh2Z09wZTZKRkdq?=
 =?utf-8?B?NittbGFsamtpRlJvUVhiMW5TNXV4SmhXUU1aNTQ0YzZnZWFGSUJFK2p2SS81?=
 =?utf-8?B?SzU3TklVZHJuT1BzN1hLOTBiOUNPd3VFSEpHSnVTK1pwOGpJQ0NIRHpaczhK?=
 =?utf-8?B?MjQrU1BtNnZFMm4vb1A1cFNQS0hMRWpVdi83bi9IOURTZTZtUzZkRndhTHgx?=
 =?utf-8?B?Y0VzR3hOc1FBRkFUbkR5M3hzaGxleFRzUm5MMVlONkd2alkrb2srVU1BUERD?=
 =?utf-8?B?WHBVZXhpaU90cUcvOVQ3T0pPekJ1YWI0Y1phYUVvOWpGQjNKYVZ5dkp5dTNm?=
 =?utf-8?Q?mKw88OwP8/N7ks5GHXHUFStdg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49086d56-f2b5-400d-5ea4-08ddae900a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 17:46:23.2180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWRoK6vWAZYO+yd8Lq70forTEuWZ29WgMd+KWmlP8lIBsSV3v3fCdsuZdFUmgNoxZ2RwJtoVcGAYnJrYIy2O7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-OriginatorOrg: intel.com

PiBUaGlzIGlzc3VlIG9jY3VycmVkIGJlY2F1c2Ugb25lIG1lbW9yeSBjb250cm9sbGVyIHdhcyBk
aXNhYmxlZCBieQ0KPiB0aGUgQklPUyBidXQgdGhlIGlnZW42X2VkYWMgZHJpdmVyIHN0aWxsIGNo
ZWNrZWQgYWxsIHRoZSBtZW1vcnkNCj4gY29udHJvbGxlcnMsIGluY2x1ZGluZyB0aGlzIGFic2Vu
dCBvbmUsIHRvIGlkZW50aWZ5IHRoZSBzb3VyY2Ugb2YNCj4gdGhlIGVycm9yLiBBY2Nlc3Npbmcg
dGhlIG51bGwgTU1JTyBmb3IgdGhlIGFic2VudCBtZW1vcnkgY29udHJvbGxlcg0KPiByZXN1bHRl
ZCBpbiB0aGUgb29wcyBhYm92ZS4NCj4NCj4gRml4IHRoaXMgaXNzdWUgYnkgcmV2ZXJ0aW5nIHRo
ZSBjb25maWd1cmF0aW9uIHN0cnVjdHVyZSB0byBub24tY29uc3QNCj4gYW5kIHVwZGF0aW5nIHRo
ZSBmaWVsZCAncmVzX2NmZy0+bnVtX2ltYycgdG8gcmVmbGVjdCB0aGUgbnVtYmVyIG9mDQo+IGRl
dGVjdGVkIG1lbW9yeSBjb250cm9sbGVycy4NCj4NCj4gRml4ZXM6IDIwZTE5MGIxYzFmZCAoIkVE
QUMvaWdlbjY6IFNraXAgYWJzZW50IG1lbW9yeSBjb250cm9sbGVycyIpDQo+IFJlcG9ydGVkLWJ5
OiBNYXJlayBNYXJjenlrb3dza2ktR8OzcmVja2kgPG1hcm1hcmVrQGludmlzaWJsZXRoaW5nc2xh
Yi5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FGRk43UmxYa2FL
X2xvUWJAbWFpbC1pdGwvDQo+IFN1Z2dlc3RlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBhbGll
bjguZGU+DQo+IFRlc3RlZC1ieTogTWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tpIDxtYXJtYXJl
a0BpbnZpc2libGV0aGluZ3NsYWIuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBRaXV4dSBaaHVvIDxx
aXV4dS56aHVvQGludGVsLmNvbT4NCg0KQXBwbGllZCAoYm90aCB0aGlzIGFuZCBwYXRjaCAyLzIp
IHRvIFJBUyBlZGFjLWRyaXZlcnMgYnJhbmNoLg0KDQpUaGFua3MNCg0KLVRvbnkNCg==

