Return-Path: <linux-edac+bounces-3112-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1C6A390C6
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 03:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B8E1705AD
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3831914F117;
	Tue, 18 Feb 2025 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA0azc0f"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE512C499;
	Tue, 18 Feb 2025 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844940; cv=fail; b=HikFMouTRJJINtoMelZI8BKoovVtGfqLIDPzOp1uZxD6vxF/z0EZYHcxkis1aUOUu7fRIpT/n1/nlu1Cb9YwXEK1cM9Rs8Py2PZk702a4vBu9ADqVIZzo5kArHDSjLL8O+y7T1YXhOswe59jTBZci8pzihjwMTwdP6ICpQ9gLik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844940; c=relaxed/simple;
	bh=yK0nrM1iSudqmCG/1FqT9xDAaYhvjev30R4ya/TW6eA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GA1xw7C6d9jXBfc3DX0dz1kaUSwckskhnb35wCJraoi7hCKTG0SOqg2OtMUzp0OZMqv/mcHg7Z0ObduHpC9KdsO4BdAo7N9NeA4jLrF/SuncS9YG7fyxK2t4jeEbQCVIt32QCZce16E/b4tJM1ygwzJmaCTBEw8bvwLcBtpvPRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA0azc0f; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739844938; x=1771380938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yK0nrM1iSudqmCG/1FqT9xDAaYhvjev30R4ya/TW6eA=;
  b=UA0azc0fptH/7QRWVXtxg1oBqP05XCmtuQUy5qXyS+ihhSc9DDhpCmFH
   S7VvUyWQnq1qLnj1/Kw4rO4Z6OY8112UHbjqLRVxJg/uGEWGaeQpUsCIf
   8Iz7c/2F5RAgJV3O67EANqPKqaZFQSVhYRRjt+RcMXycRPfBzDkzLqcIv
   Bkk8LfBVqUmt95Vu0DandoNo0DxGUI/lUpyC7AlQUDQOvQngW+eSNl9Or
   mmIlKxrfeztIdhkE4TFPvkWZ0RXO5IQZEb8DSWrx0LZADmk1NrMSB2Qwq
   6VlBnjqDjJ78Wwk9WhXvloe7KRNLXPOeNCyCLR5nWu577vMO96xhAH7AV
   g==;
X-CSE-ConnectionGUID: zm/SnRn6RYWExCK6lkqIoA==
X-CSE-MsgGUID: 3Um/7BjDTFO0oA6Wi0wGKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40387101"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="40387101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 18:15:38 -0800
X-CSE-ConnectionGUID: D6kahAyuSe2b0iRC3AuOrw==
X-CSE-MsgGUID: ezhBNyU7RveJsI6AENHQnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115156275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 18:15:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 18:15:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 18:15:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 18:15:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGGz39GZL3oCW7sDKEvKipaW0mfCXT5zQSKVdQniA1jdavSOQNont7n1jdUJf5WyVGt21kGGjZQ4Jve5ZYuyNrYDFEkMJWkiUdFUpjWe6n5RJ6RpxmV9EJyIr8THZPNPx17nMwSq8LVEQB9CsyQVwpR1DsxLCc2Qf8VNmbVYG83RRa9irZGuTeZMoFpK8d5TnVWtVRoA2Ii7Zo4n+Ef/nC2Pqh97rqRdVzHhu6bPejlHM2xzB6RnTaQ3Q4od6R3i3ji3wCsyjwXOVIjVoeeUFphtRBa+z3VD+bL815pYJYx/cFUYCbiL0EAiiQpClwAI94Sa+hqpbIbuXeBJn3+/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK0nrM1iSudqmCG/1FqT9xDAaYhvjev30R4ya/TW6eA=;
 b=WGFehiLVNGXKhvYxKKbyvziXJv0OZWmSgtEJIo2kRpGvPxH80M+8QZWUu64pIxpj378WNNXc6pJ3/y7I26bW0yI61jKlDza8cGU1XHI0e/vHCiCc75tnt/o+dUuPt1jHnrcvolPsyc4Nn3NuUYxKitrsLER3SPE1CuBraOYCQhCqeJis3q9pim4KTrEko1YijhHeEu9SP7c9K5hz4+ygrBPcnUM8Dd4Omeaajhc0yTV+3B1bpCk5nIgWD4adhcj8fgqOmXlptNz5NLsJpi576B+tsOTSkd4UNHvfBbmod3tr+lRLQtosgpsm29BS+P3IcygJFDapxjJGA6OoKccJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 02:15:29 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 02:15:28 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Thread-Topic: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Thread-Index: AQHbfjsYguYOq4jQR02BA75dIT/Sg7NMWPiA
Date: Tue, 18 Feb 2025 02:15:28 +0000
Message-ID: <CY8PR11MB7134F3A98FA99C05ECC5F57689FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW4PR11MB5933:EE_
x-ms-office365-filtering-correlation-id: 8a24458a-4804-40de-49a8-08dd4fc21d21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cG9DQmQvRVhyNnRnOGZtQTJlbU1aVEY0dmRaWUlaUDJyOTY0d3BkT2ticGpK?=
 =?utf-8?B?MXhwS3lORFpRT3lrbk5Yei83VS9jYlkyRURTNTFwWjMzOTZjWXp0OXJyODls?=
 =?utf-8?B?eW5rWmJHdW5WdUQxaUpYSVRaUzhYeUNXazJuZzQ1NUpKQ2hjd0lDYUtKSWpo?=
 =?utf-8?B?OGtYM2JrMi8ybHlWUG9sRVFQakNDbGM2bExWelJZOXAzUVp5L29NNWxJVHpF?=
 =?utf-8?B?dzhGa1FQT1lWYXhDU253aXpZd2huUGFhbkZ5K2xyWm1TRFNTMllZbWFic2cr?=
 =?utf-8?B?QUJPTTlBOUJnanRKdlptUG1mYllqVnlpc3F4dldJS1djeE82RTgwbkNXZ3l5?=
 =?utf-8?B?M01nRng3OVlkRklNdHhYeEtQTEpYMjBkc0tsSWxXdDQzdjVFOEFZRy9teXlP?=
 =?utf-8?B?bWVnd0toMXlXVjRJMW9Bdi9yaXN0SnlKVnRaUmRUZ0M4SDVlQ29TR2poNk92?=
 =?utf-8?B?azhMZnIzOUYxL3phYWl3aEdKLy83UW5tV1FxYXRXdnpaVHRVdUNEWit6aS96?=
 =?utf-8?B?clgrUjVpR1dwY0VqeU9pVEFCREczTElDNUVJL3EvYnliOEFTR2xPSUVtb054?=
 =?utf-8?B?c3E3QVc5NmN0TU53TzI3UlB0aGVsTUt0VXVRU28yQUdGM05oeU1Ub2hEQ2pp?=
 =?utf-8?B?U1BOeFBUdmV5V0ZjbldGVkhHNmZOTzVUeVFCNXFqN1ZpYVBETW1lVkVVVmRl?=
 =?utf-8?B?eUxIZ210eEsyVjhGM0dla2lWWkkrTStoeTJXdlRHNVFNZE1sOHpXMDE5eFpB?=
 =?utf-8?B?U2Z5NlVCdzZ1dW95VHd0YlRiNzk2Z1YwcDc1ZjVja21ZOS9ib0FSTGlqcXI2?=
 =?utf-8?B?U0hpaldnUFlDWkRNeFhsKzVLU0dIaXM4RzF0THQzeXVhWS84WkFkVXVqeGV0?=
 =?utf-8?B?Q0gwMW00TXJsb3lTdUNubTIvcENyeU5JUlNRc2IyTVBybi9KdnF5SHd4Zzgy?=
 =?utf-8?B?SVJMZUZmWDAyRnVtWkdoQzh0WkwzeUY2RXYzTitrVUUvVFRtWm4xL3BENWts?=
 =?utf-8?B?d09KbHNjTThuaUQxRm9SaW5BcUJvZzNWSEhKRHMzVXFpQkhSaVRIblg0aity?=
 =?utf-8?B?eXJ4NTk5YUxEL3dMd2s2K08rVlZZT20yNGNZNHJVdU1LZzJMallhNXNpVVJw?=
 =?utf-8?B?VHRhN3NGeXZJMVpnc2xCMStGckNkd2FnM2VydGprbk1Xd3U5T1JjOXRSci9D?=
 =?utf-8?B?bXQ2Y3lvT05KUTFmdDMza0prZFNmdDMwTk5HUlBITUdSMlJFWmQ3TDN0MHg0?=
 =?utf-8?B?bWt4NTNDUFZhQUtueGNyb3FRU3VKUUNYdUkwMXp2UU1qUlZBVy9DdEZGMDlB?=
 =?utf-8?B?YXNmc2pKVFRiWktHTW1pY1cwaTloN0YzZlRTVnlRRjQ2WGdrd0swQU54Z2hJ?=
 =?utf-8?B?MVRJOEdxcVd6ZDQ3N3dVSDBaYm5XZmhOSG51VUcyRUZ6REI5NVdMRHNOMzNZ?=
 =?utf-8?B?cFptL2FzT2M5T0ZFdTFyZVBqUEJKTEhqQkJmL0dNNjRXTHN2WEFPUjNQZzNs?=
 =?utf-8?B?NVgvSG5IYkpqSUJ5S25WbVg5N0ZWN1Z6MVNKZ0lEQ0FFUmVDUW5WK0Y5MFBw?=
 =?utf-8?B?NEVtdjN2TENYcHcyRno0L0RxOXdLS1AxUHZsMFZUclRYUE4ySUpvQVIrU3Az?=
 =?utf-8?B?VjdreEdXQzNMME0wc05OT2xVMC9xTlRKQjczeFgrVGtpbHRtL0dRbHFjcit0?=
 =?utf-8?B?ZHI0OUo2b1czSDNWaC93ZDhua09ld3FWWGRYSS9FbjBqZVg0ckh4amFNQUY5?=
 =?utf-8?B?d0V5ejc5MzJtT3RsNnNrd3N6YnY1dEMwUGtwKytiS3lBRWtyOWxySEMvT1VU?=
 =?utf-8?B?SmtrVzF3T1Fqam1BQW80T2hBY3NFWmxTd05teXdPUmk1aFRSeE1yTjh2dXhk?=
 =?utf-8?B?Y0lPZklwOGhOQ0JqdTIwTXlSbzJYRFU4WElrQnIvT2M0UHRYTTVDeU9BM1po?=
 =?utf-8?Q?SgMaWAfqeBLaGQHREvha2J5mVvaQqFw5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enU5YVJVa1VsaTRQVmp0MmNxRmVTUjBXdU01aHMreHFpUHd1Q0xyeXJXTGxT?=
 =?utf-8?B?YzZlVENzSWFVU200TFJjdG5VWStYbmtFUDBQbFdvNUJPSUFMY1pZU0JNcy9G?=
 =?utf-8?B?YmtVcGNHK25yTnR5WkwwVEpqeGJNbVhHV2JYZ0s5ZlQvTFdpZ1JqRmlPbjBn?=
 =?utf-8?B?dUl4NGhNaU55bHlYZEJIcXh6WGlRNmRSck4rbHRla3BUWW5mWWRVWUtXL1B6?=
 =?utf-8?B?aE5naU4yVHJKZVdKdlh0dWlwQnNvdnl3a0VVVG9OVjY3YVNYQTZjUUwyT0Jo?=
 =?utf-8?B?UENmNnUvVzNSU3pXejVaaUEwRGxDRk9VNHBUYkQ1WXhNdzlzbDNBMmdtN1pI?=
 =?utf-8?B?WGhXOVlsSkUxN0xIQjloelFSeU9STTVZOHMvRWp2K0xMcjNXKytCWmhZR3Fi?=
 =?utf-8?B?T3hZdm1Tb0ptOFpjSW1XSTRPWlN0bnhXNHdXNFQ2cVUyY0FJSm55bUwrSzVs?=
 =?utf-8?B?eEVFUFNlSmpaeXZuSkl3Wi9mZ1RweXJaQjVmTDFvM2pGMm9jMEZiQm5NbEUr?=
 =?utf-8?B?WkNzRFRPUVF5ZmlUOUUvQkgxT1Z6Nm1lNDRreE5xWHVVNHF1ZFdzanpjUGlT?=
 =?utf-8?B?QXkrSVNBbGVwUllUUUx1eVZnQ2wvQXg3UEN1SmZpWXI1SXRoRzc0VVFEM2o1?=
 =?utf-8?B?d2lmNVJqcFhxeVlPRFl4SVZWUHdzSnl4YU8wa2JZUXd0aExpVVhZVE90Y05V?=
 =?utf-8?B?V2RXaU4wYzFrd093Y2lLbGdHOUVKT05Sdm40TjMyRTVoV2pFenVER25CTUhv?=
 =?utf-8?B?Y2NURVBrbGR2WW1zNmQ4eFZOdXZaVW1GZlZqK2gwdVc3MnlZK2VKT0hrTmZv?=
 =?utf-8?B?a1NhT09CcnhnTUlJOVJQTXc4NmxwZ3IzNlh2Sm5CZVh2MnFSK2JLczRNVEdq?=
 =?utf-8?B?OC9YL0swa2NzL2hhQ29Rb0Z5SVZSRldBZXJ6T0J5OUZ0OHd0RDR4UjZCKytU?=
 =?utf-8?B?ZUl4ei9vUnFGbHdQOHBnTjJYZC9PNllPcUtBM1RPYkRwekIramdTUVFmN2ZY?=
 =?utf-8?B?eVRKY1BzeUM4TS9INjVpclhHYlRHSXpMR0pwUzZjeU1QTGhLQzkrbzRmTk0w?=
 =?utf-8?B?U0ZEQnplTzFsWDl3U25qUGVIREl5ZTkxTCtRYmhzRHVab2l6WXMvcndLSDM2?=
 =?utf-8?B?alBCeVNhR1JuY29MQnlnbEs2cCszT1YwRCsvcU1GUFNWZ05tMnYvUFQxby9r?=
 =?utf-8?B?OHh5aE45OHcrTzE3Vk4wOHRYdkFwNTcya05vd1dqUnNPbTlVcmMybWh0M0M0?=
 =?utf-8?B?MXBWVFEvY3g3MGFVS3ZwUGFmRHdhVFNvemRCbTdmUS9XVXJXVEpSMVJKZDdu?=
 =?utf-8?B?am9pMlArck9VRnNzd3NweWdieUZXYkgxMnUrUERyYi8zRGdGOWdheDczcFhv?=
 =?utf-8?B?ZUdGUWVGZ0s0Z0hocXVTeUVKcytvM3BiR0hVam55TGpFUmh5K3NJT2VKQjM4?=
 =?utf-8?B?UXFxZytYRFlKa3NYT2htdUxoSjEyeXFCVU84T2xQSFNjYTZPV05pRWFlK05J?=
 =?utf-8?B?aGtxL002RXF3TjNpb0pNY2Z6cWR0SXhOS3BaUUx3TnkxcUx0cldocU11bTFV?=
 =?utf-8?B?aWcxTVFjejI3aE9kSDllTGdQZkpSWkp0bitnNy83K2xSTXQvY0pzd3h0bUJ0?=
 =?utf-8?B?VzlYcjA0cVJGeHJHRmVncGVhelBaYzFQZUtQL3NTN3MwRk51enJxMnRZc0x5?=
 =?utf-8?B?WnRnTHhxWEpqNlh0OURSYnQ2aEVCSE0yVElCWWt6TEJYbkNUNHJRMXhleVJV?=
 =?utf-8?B?R0ovaE8vU2lwMW51cmJvcUoyMlRKMFFna1AvbzNRREhWKzhhckM2TFBQU1I2?=
 =?utf-8?B?WUJrcFd0RXpkTzB2SlBaKzErbUN1ZmMzKzRXcUU4L0pBMlQ1NHVGanp3KzZH?=
 =?utf-8?B?c0Q2TDl0cTB3TnU3WkEwaTFTcGtndzJQZDFlRjdud0ZhVGQwdmpFL0pqQTRi?=
 =?utf-8?B?NFdBV2QrdTNIODd2UWp1Y2w1OUg1TUF0RnM0cjJqUkxPcVpIaEhBalNFeWdi?=
 =?utf-8?B?b0l4R1dBZEdwWlRXaTY3amM0WHJ5YitiRG5pdTRkeVF6UUp1aEt3NkJLRVZi?=
 =?utf-8?B?dC9uT08yK0VtU0V0SzdxUDRLZDFieERENXg4Z21XQTNuUzBnZ1lpL1pFcEUw?=
 =?utf-8?Q?MYuC9OTIih1BIaTD1DQe60rnB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a24458a-4804-40de-49a8-08dd4fc21d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 02:15:28.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IO2I0R+30sfecbJixrX+IGIUgjDweB9N7hXVEZ0Bfl4M7xlgQE4lS4iye+y9/8JTukHPTo9J5+kPMm3iGGl88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5933
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwNS8xNl0geDg2L21jZTogQ2xlYW51cCBi
YW5rIHByb2Nlc3Npbmcgb24gaW5pdA0KPiANCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBz
dXNlLmRlPg0KPiANCj4gVW5pZnkgdGhlIGJhbmsgcHJlcGFyYXRpb24gaW50byBfX21jaGVja19j
cHVfaW5pdF9jbGVhcl9iYW5rcygpLCByZW5hbWUNCj4gdGhhdCBmdW5jdGlvbiB0byB3aGF0IGl0
IGRvZXMgbm93IC0gcHJlcGFyZXMgYmFua3MuIERvIHRoaXMgc28gdGhhdCBnZW5lcmljDQo+IGFu
ZCB2ZW5kb3IgYmFua3MgaW5pdCBnb2VzIGZpcnN0IHNvIHRoYXQgc2V0dGluZ3MgZG9uZSBkdXJp
bmcgdGhhdCBpbml0IGNhbiB0YWtlDQo+IGVmZmVjdCBiZWZvcmUgdGhlIGZpcnN0IGJhbmsgcG9s
bGluZyB0YWtlcyBwbGFjZS4NCj4gDQo+IE1vdmUgX19tY2hlY2tfY3B1X2NoZWNrX2JhbmtzKCkg
aW50bw0KPiBfX21jaGVja19jcHVfaW5pdF9wcmVwYXJlX2JhbmtzKCkgYXMgaXQgYWxyZWFkeSBs
b29wcyBvdmVyIHRoZSBiYW5rcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzbGF2IFBldGtv
diA8YnBAc3VzZS5kZT4NCj4gUmV2aWV3ZWQtYnk6IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5u
YW1AYW1kLmNvbT4NCg0KT3RoZXIgdGhhbiBUb255J3MgY29tbWVudHMgYWJvdXQgdGhlIG1pc3Np
bmcgY29tbWVudCBmb3IgDQonTUNQX0RPTlRMT0cnLA0KDQogICAgUmV2aWV3ZWQtYnk6IFFpdXh1
IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0KDQogDQoNCg==

