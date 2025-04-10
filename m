Return-Path: <linux-edac+bounces-3507-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D1A842BA
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B20A189D858
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF432836A7;
	Thu, 10 Apr 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKGpLTkd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4021E25E3
	for <linux-edac@vger.kernel.org>; Thu, 10 Apr 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287249; cv=fail; b=cN3eluzJ+Yh55od3ulpf1/WS6c4UvKWq5lRx3obZLKZ2VNQ1Kowrge+DCQVCS7ataGfyJZmU4CnhwMqWwWptaaV/b3xdiDx0keY9/WjprQCjKSCYBYNLEa1mySilesRDw/WaLKiUh0Llp99DJ0RX++D1Nc0uKset8sxv/K5qH4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287249; c=relaxed/simple;
	bh=oFxsPOCyd6TJCeNhGewNpN3kfFAFWPyZKpd0LxvsSOg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BrM6PIAUkFkWjLDE82iVLttIJzAp4F10kvDa8MXljHaq7V9bdu94gcw3p4jgoVr5/OV7QpOB+/ti0XvAanKVKcB4pNEPocOk+NrIPtcrarz++4WnAwLVccxRfQw7nYQB+E3AkkZXjdrrkqDEH/xaxSH7ky4Cw75uS0OkuiI09Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKGpLTkd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744287248; x=1775823248;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oFxsPOCyd6TJCeNhGewNpN3kfFAFWPyZKpd0LxvsSOg=;
  b=PKGpLTkdcj3WGNBqeNAtjVqXXVgLEwHkvbhz6RbMOq2oJEbfOz7AxkCs
   sHUxI9/x4fGSdx6k8gM2MpNlc7xX1WrrMKG6oDHDwrMigUmNcGSY0vNL9
   Ua/ht/5YUl5gUJ/h5UplotvHyDt8pUnoT7M2tLhTaHG858jzFCeZzzTn9
   EyzAfsTBieSy2EwpKLy9e+jCqA0QhtQiVj19Pw9OaXyJSWF8EJq3CEE1i
   xyYqlaytoY3RFuvB428hbpVz1amiFcYGP83FC5GYBzve6TeehfJxZfBc3
   xJcI9OBCDIhNvzYut9BJY8+aQuvvPamy0FhMHc0HWTM8QPXQVutSXuMMh
   Q==;
X-CSE-ConnectionGUID: Kchr/Kx7REGgyehg11BnFA==
X-CSE-MsgGUID: 8dsGAeQ8Rp6XAtiCfswP9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56782267"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56782267"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:14:07 -0700
X-CSE-ConnectionGUID: Jrgl1wSiQZ2fYk0ardM21A==
X-CSE-MsgGUID: 6cqPZoXHRDy6Y2LGj/F6Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128631550"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:14:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 05:14:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 05:14:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 05:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRzbmLkODVJktOvgmwkjoV6uxlydCxgDlV94Sl5nJYiZvMOPI02lsb9RtYBA56Kl7gz3Hj8zIGNFDn7CTj9CNs08cjVINoA+yr7432E2QvFal1cIe+rvQrO/VNX0yHCl9Bs7GV+VABZRu3PO7Z5Slw8C51L9RY1QaGnI43VGQYvWFpt2hpmHim2py2sGWAXBeQ3k24LnnmL6GBppjbtxpcE5dJyXO9RsU7WAi9RCIMrHvhfTAUyuUE4mxDRTtjS29CbfdOf7+pvcsEGRB8x9Y0W7Vs8CWucXpCvJuobEmRGYW1LtY8J9GvfbauNQovmP0nVHrgZl4gBEfg4CXqWEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFxsPOCyd6TJCeNhGewNpN3kfFAFWPyZKpd0LxvsSOg=;
 b=SPDpIj6XHTyUZ5cFIABCiwgTWAdT7Cfwfa0po3s6o2DLWBWPZa1vzFnmXkPBU7uYRQV7841ndVpCVZWYAMv7wWxUufMLxd93SlzVe1uXqoJukDXuxgEdv8QCzjUG9Apdq5R4Tfw8551C07Sv+QbLw64LumTizUsjBU6q6/G8luzxsJV/wqZFd8vP/s79h8Y/vcMqR6r1KrnwORbV7zPbLbcJoZbEeSXUQNTQZk0idDddCx2dTCu6oINrORTScrpHE3dxTkM9hrZ6LIi0wK8oOH/8kwqy2KxHGxjCqecpXPcSZ1yItVob3OEyZVybQ0NJGW8WA517uYdOpgWH2twZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 12:14:04 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:14:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Steven Haigh <netwiz@crc.id.au>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: RE: Constant EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR printed in
 dmesg
Thread-Topic: Constant EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR printed in
 dmesg
Thread-Index: AQHbqWI4VOfkFMIABkqe61s/XHyz2rOcz6GQ
Date: Thu, 10 Apr 2025 12:14:03 +0000
Message-ID: <CY8PR11MB7134FD1809BF82C3828B499789B72@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <de007cb2-e64d-46b8-89d0-a064a7ab369b@crc.id.au>
In-Reply-To: <de007cb2-e64d-46b8-89d0-a064a7ab369b@crc.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY8PR11MB6819:EE_
x-ms-office365-filtering-correlation-id: aa922cc8-ea42-4411-221a-08dd78292f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Zk8wVjQxVW1TZ3UxZWVuMitBTzU1R2kyQ0lxcGJ0UnMwSDFrSzE1MnlURzRr?=
 =?utf-8?B?ZXcyQkVwTU8rYU8zN1lITzY2SnpBMXhOWUhQRVZhRm4zeGtsOUxibGFCVE53?=
 =?utf-8?B?MkQ4Z280OXFBNlV2QjdlMjdZd0dxSVQydmRnekpXZERRYTBCc0NUeWFETnpB?=
 =?utf-8?B?QVVrSmo1OFFORVJKY2Q3dXlUUFArQkxybWcra3dsbzlTazcxYkZZQXJ3cGlG?=
 =?utf-8?B?VFM5ZmYrR0lyN3o5NXVMenRMU1hnOGR5US81TmFzNFZ6NThMSVhLSkhxcUtq?=
 =?utf-8?B?ejBjSzZSU1pNelpzZkJGc2dhNktnM1VZODQ1dDJIaUtGZEdPSlJkcGhWdGYr?=
 =?utf-8?B?eWFMcW1XcmJldDlJdHBBWm9BVHZXNzhZWUpMcXRoclBoVzRQWVJZa1JnemxY?=
 =?utf-8?B?ZDQ5TlhvdE9sNjBQL3JXQnVlR3BJMkk1dUpmd210TlBhSkJnSVFYcnl3SUg5?=
 =?utf-8?B?eU5iL0Nyckgrbk9rL3JHU1c2Zy94YW9RMVdheVhjdWVLQ1NNcHRKQSsvMGpa?=
 =?utf-8?B?L1FDOXAzTnNmNTVEWC9lRXdnWXVRUklNSnllaUxVaVRsSW56ZUR4clN1SnhT?=
 =?utf-8?B?OGJsNjFZdXIzcUlWMGdkZEpjU2hFdDN4dk55eUlIVVNFUllTeWJLTFFJeEJh?=
 =?utf-8?B?YTA3ZDViQkZ1Y0MxZTFvcTVQN2N5UWtxczVRcjVwUFpycld1UVhTUkhhdGl0?=
 =?utf-8?B?NEFuRzdmR05rK3I1MjJOS1RnNHhvK0V5VjVYVk90aGYyaXQ2UjdyejZBcXNH?=
 =?utf-8?B?Q2FBZmRpQmpPb1VXREVvZmZDZnlvRXlwZ2tldmh2c00ybXNBZ0Y4cXUzN0Uv?=
 =?utf-8?B?c3ZCcjRvUXpQaGl5RFAxY3I2cGhyWTVFSzlicEY4UWF4dW9KaWhjbWpHVFVY?=
 =?utf-8?B?dTl0MExDdDAzNGhqNTlES280V2xkTWxTV1h6cSt0VE5SZkp6NnVZRi82bWlq?=
 =?utf-8?B?cnhraWZiaU9SN3pHOWljZFpqa2tOMjVIb0o4d0kwMXp0cWI2aVBuOFNra1Uv?=
 =?utf-8?B?b0pidCtmZEFCdk5DejF6bStjZ3ZIYTBQSk9XR2ZHOHBwUXRuYTBnMTBpWjU3?=
 =?utf-8?B?Z3RSOTl6a3R0K1JRVjFQVDZXcERGc1dhQldUMW1xZGlIbkliS1FHWGQvd2xU?=
 =?utf-8?B?ME82cEdlUzFCUmVFZDRxMnFTWDhKbWs3R21XUmthQ1FKcmNqMFplT3VLV1Ur?=
 =?utf-8?B?M0VsQ3VWQmY2anhVVm9tWGVIek9uSUszaW5zbFpheTloakZad3BObjdqRzFH?=
 =?utf-8?B?VFNJS0ZqUkw2UnJ5cjVCWWh4aGsyR2RoQlhWV1pKUVYzU0pmUUVWNUR0eHZj?=
 =?utf-8?B?UzJ6OFFTSStjZDVESUl4NVc0ZFM5RmJpbHdNVHJzOTR2UkJwckkvZUliU0Na?=
 =?utf-8?B?VDIwNHFiQWljK1g2aWNQdFpEUVpnUCs4NnFOSGRsWGVPK1JkV21JdE15SmNF?=
 =?utf-8?B?YnFpVFVUV2xIbDhCZ2g4N0h2ZUFqNzZhNHBGT096NXBwdUNyY0NQeTlNb1E0?=
 =?utf-8?B?bERaZm5hRWpDczVrWWZKek56NmxJaVIwUW1MMThaeXlNTWVEN0xHTHFycDJG?=
 =?utf-8?B?eG10SUFCbExtai9HU25XblgwdE1kK3ZOK3JTb1o1SERnbWZmbnA2bW9nbFdB?=
 =?utf-8?B?d2VFemVNZnZnWkFSUkRKa3hPZjc5VDBZaTlpZXhVR3B6NXMzM0w2REpIMy9x?=
 =?utf-8?B?Z2thZnNaeU9pbEt3TVpqeUZkeGJkekVpSW9zc0lNa3FxUmNFMGVSZmhPZHVa?=
 =?utf-8?B?TTRiZ1NORHRKb3J3SndIT2Nyek9VaHpVUjhmOWVYT0MxYnhFYU9yNU5GVXow?=
 =?utf-8?B?RUhoTXpCYTNFL3VIcDlvSFlteTA5Y1I0ZTlQRW92bkFxUjBoZmRyWlF5alZh?=
 =?utf-8?B?WkErLzRnTGwrdU4vVlI3RlZqb0R2VVdLMlpYdXpOMVhCTHJnV05NdjZFd1Z6?=
 =?utf-8?Q?fElG33K+Bx8BtFjxm0c1XLydRj/AyQOS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0RzS3ZiVmdQakx0Z3VhNWxTaFRLODRQL1lWdFhrV0VQcGJaUUd1eEFrcDZB?=
 =?utf-8?B?UHpocVE1cHVIYXRYZk5iMUZSN3o3QzJBdDVBWmFjc1RETUhFUHo5NFBTUGcw?=
 =?utf-8?B?ZXg3VTUvcTBOT1dRZWdvWWwvakhSMmhlV2RYS0pWWmFJZmdyaHgzdHRLazBj?=
 =?utf-8?B?MHhXOEl1OGdNaFUzQ2FteEVkN2JtSWhIdktkT0NIUEhsVEY5UjVCaVZ2d0lG?=
 =?utf-8?B?MURtbnBiUDg2THFJTk1WU3M3aUdia2lUZWZSREEyTnBRLzVBWkovbjE1RWRH?=
 =?utf-8?B?enZJOFYzT1RGMlhaUHRkMVdld3A1NXpXVXoralBSZ3BFNys2ZUR1c1YwQXJH?=
 =?utf-8?B?blJBZWduQmhzeEFKM2ppUWZkckNOaE5aOVJtcEcrT0dhUm5od05JRjlXY3dp?=
 =?utf-8?B?a05ZY1ByK0t1aVkyYy9zcmhIZkd2TWJFNWhiYUxMWGI3K2ZZKzk2UUVNS2wy?=
 =?utf-8?B?bjFQOFZWWFFLRXBxK2NhSXZ4T1RzZzEvL0xyNi9qMVRXQWxBaHJPbTV4cURN?=
 =?utf-8?B?cW1BQUE4RkMzTm9QeXdrMW9XRUFldVd0RE1Zc1ViUGFpTW04NHJJTlRqQ3lI?=
 =?utf-8?B?dUhuQ0ZidE91dzQxeFBnNUFMQ3oyNWcva3FLb2FMSnZIUldpRDFhU0hJdHZ6?=
 =?utf-8?B?ZnUvcXNQdm1iZWZEMm81ckY4Qy9tKy9UNkJTRlRrVk9IMVUxK0xsYnhmTE1P?=
 =?utf-8?B?czMvTGZTVXdrZzNMQzQ4RER1a2RvK29oNnlCT2lobEEyQmNLbUxIVFZGenlE?=
 =?utf-8?B?NHEyMjVTYjBXdFJqY2c2YWxSaHhGamZ6YlZWY0UxaDVLdEpERFEvQ0hTbjE5?=
 =?utf-8?B?OW9rT2ZmRUdDbmRKTFdITEo5WDYyRGljZjZmN0tKWlFGQi9qNTQ2OXpEcTlp?=
 =?utf-8?B?THJmWDhVMTJQU0NFejRkVFdvdnc3eVZXNFNsTWpFSG1yWHZxTlh0OUpzYVpD?=
 =?utf-8?B?Z3VvY2trb3Q4VTIxL0VOVWFmM21CVlozek5uWklsZzFXSHNMUHJBMEZ5ZDdT?=
 =?utf-8?B?SzEyMDdSVWtlWDJuN2tmbjIxL1J6UndkOC8wcVRacXVKWUtZTU1iWFZRZE1U?=
 =?utf-8?B?bDdpNm81Wm95WkNqUTNqUGtxODBkZ0tlM3FIK1NlMGF1c2d2b2w2UG84VlNX?=
 =?utf-8?B?L2l3T012TWg1UHlUSGdmZ2N0Vk1rdDhYUGptK3hxQXc2WnBwSUZXNHBuVWxQ?=
 =?utf-8?B?SHlmdXNTSlpEb1lrOEFoblE2b1hwaVo0VitjTFA5MnR4dWJRNHJDRElnZnNS?=
 =?utf-8?B?Z0pIN3ZNaVRJS0QyVzc4UWpDbXlHeXc1dnF4NzNIMTEzQk5ac3dkbVp2cVB5?=
 =?utf-8?B?WjlSSnR3cWkyeDFxeE9DcE5BVFd0SW1mTHBYY2Z4RDZNUWZwZWZUYUIzTlVT?=
 =?utf-8?B?bWE3dElWRjI0VUxqcXhuWUtPMDRoNHIwZzk1MmViVlhVSm5GRGVZRk1sMm5W?=
 =?utf-8?B?RGdmajcyeHVyR2xrdWc1cW90WVhNcWV6ZlhNZjZBN3R6eVl6aEJHU3l6cFNN?=
 =?utf-8?B?d3cxVTZnQ3RIdnVOSi9jdVdPNjNqVG43bE9peW5ndDA4VEhZM3pkQlNUQVRB?=
 =?utf-8?B?OUEwTVNaUE92aFV2L2xpZ0ExUnF4R1h6YU03T1VlVXlGRmpYSGpxWWZMdzVq?=
 =?utf-8?B?bHErRDkxTmNsRjNzbEV2UGRGUW9vMm9BcjZpTENiWkNkNXlvRC90QitZYWEz?=
 =?utf-8?B?RmJuZ09hSmpuWlVSYTMyL0dITFpEeGtrSXhmZWJ2T0RJZnVhVWpJNnRFV0Uz?=
 =?utf-8?B?cTYzRFp2UklBZzk1YmVxdGZkQ3lZRkR3VkZUSmNjVHkyQnpqWmtkY0lsd0gz?=
 =?utf-8?B?OXkxWHhzalZWZkN3T0pmUEoyQUtONFY4Z01jdnpWbkJJbDhrZFd6Q0VOVlA4?=
 =?utf-8?B?ZXNTU3l2cU9mM0R4ZG5OMjZEUS9VWUZKc3pySWE4Mnh5ZVljUG10VjZOUDhK?=
 =?utf-8?B?MVVPOW1Ub0pzdU1pazZqNnJaOVR1NGtFelRQVXY4L3ZBK0FFb2FOTFB6bHd2?=
 =?utf-8?B?Znl6bmRTd2xRSmwxUjB0U0IyUnhuaTFhQ0Zqck1KQTdJTkFTYnZEMXZUbEN5?=
 =?utf-8?B?ZmNUY0ZwYXRoazBUODM3RFJNSmM1OTVSdW0rYXMrL0NSNHhJVEZPZjJ3Wnhu?=
 =?utf-8?Q?cxCmYdmCd6KsCdU+X03F4DZBy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa922cc8-ea42-4411-221a-08dd78292f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 12:14:03.8578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WRGWxRCZw8MXUJ7+HAl0w3l4dloOCy/8DDTAv//+I9lbVX1Y7FZsSW8oZVeCh9u4sy31HVUdVTx63JEtzVk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

SGkgU3RldmVuLA0KDQo+IEZyb206IFN0ZXZlbiBIYWlnaCA8bmV0d2l6QGNyYy5pZC5hdT4NCj4g
Wy4uLl0NCj4gWyAgIDEyLjg3MDM3OF0gRURBQyBNQzA6IEdpdmluZyBvdXQgZGV2aWNlIHRvIG1v
ZHVsZSBpZ2VuNl9lZGFjDQo+IGNvbnRyb2xsZXIgSW50ZWxfY2xpZW50X1NvQyBNQyMwOiBERVYg
MDAwMDowMDowMC4wIChQT0xMRUQpDQo+IFsgICAxMi44NzA0MzNdIEVEQUMgaWdlbjY6IHYyLjUu
MQ0KPiBbICAgMTIuODcwNDQ5XSBFREFDIGlnZW42IE1DMDogSEFORExJTkcgSUJFQ0MgTUVNT1JZ
IEVSUk9SDQo+IFsgICAxMi44NzA0NTFdIEVEQUMgaWdlbjYgTUMwOiBBRERSIDB4ODA3ZmJmZmZl
MA0KPi4uLi4NCj4gWyAgIDQyLjgxMDc5NF0gRURBQyBpZ2VuNiBNQzA6IEFERFIgMHg4MDdmYmZm
ZmUwDQo+IFsgICA0My44MzQ3MDddIEVEQUMgaWdlbjYgTUMwOiBIQU5ETElORyBJQkVDQyBNRU1P
UlkgRVJST1INCj4gWyAgIDQzLjgzNDcyNF0gRURBQyBpZ2VuNiBNQzA6IEFERFIgMHg4MDdmYmZm
ZmUwDQo+Li4uLg0KDQpUaGFua3MgZm9yIHJlcG9ydGluZyB0aGlzLiANCg0KQ291bGQgeW91IHBs
ZWFzZSBidWlsZCB0aGUga2VybmVsIHdpdGggIkNPTkZJR19FREFDX0RFQlVHPXkiIGVuYWJsZWQg
YW5kIA0KcHJvdmlkZSBhIGNvbXBsZXRlIGRtZXNnIGxvZyAoaW5jbHVkaW5nIHRoZSBzeXN0ZW0g
Ym9vdCBsb2cpPw0KDQotUWl1eHUNCg==

