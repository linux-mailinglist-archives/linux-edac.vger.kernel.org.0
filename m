Return-Path: <linux-edac+bounces-4760-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC7B494D5
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ABE17D8D4
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A630CD80;
	Mon,  8 Sep 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cu8USLBW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C82B9A5;
	Mon,  8 Sep 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347837; cv=fail; b=VGvZNN20r5/L8og20HfC/Dwoy4Lng5grg3efLbeR8/DDKlgym9vO+jiprO0O0Hs6YB1BG2q0YJ4o7gpTiL9gMyevlzZ7wz2kUSN9Jd+d+QQgJyeE7Un3PDhPn8xHXqnFWGgElS47PZtq4BKMQSrrVkz0nWu5ad+/gr+gm2pJC9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347837; c=relaxed/simple;
	bh=K+NjZmZuH+LUWv+mzTSThsgc9C6am3PMS8EwzQisc68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0lUjcx1HinqBhaB7sFzgM9qWscaZdDJem7JYmFk6TVwQpZDNaXH6tVMuOuNsFuOVjyNWwZncKxkN5B8RnQhrCRjI4ugmAx/GF1bD1wWa/xAOy8Is/hk7hPvEF6EqmLmPWJmDaoh4K1tOw59G8h96Fv2C7qRQFNnDzfHc+UKFLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cu8USLBW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757347835; x=1788883835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K+NjZmZuH+LUWv+mzTSThsgc9C6am3PMS8EwzQisc68=;
  b=cu8USLBWAItpwzdBOsMITEFNY31zwf1OSe8BvNgxseT3tfZveIVrdtPD
   P0XyUpdJL3p5WWy1NCezR2zJND7HU9w7Ijnnc5g7tZ+SBbTFt1hF+frJT
   bN3A/tVORue4Vk/UoaR0eNUG96X39XhxXFGuVs+7/W3P8/2M+tK4XJsAM
   5vwkfDZehTMSdOIPbuILj5DFvQPOMsWwykX64MsSnskbJGg2dKdZXwyeT
   72elY+41lX5kzhyyiOIzY+czrfBrEwit6us8Dfa+Tu0lIiTgKiXCFQV7R
   M1BAHVODJlHXPlUUwb2J39PhtERD01BYKKRK7KVgcvOvPD7vP9dOL1J5z
   w==;
X-CSE-ConnectionGUID: bteZs92KQ2iJbIAylVQONA==
X-CSE-MsgGUID: KuKkm4+zTJOCK/5UX51ltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63439209"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63439209"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 09:10:35 -0700
X-CSE-ConnectionGUID: SpPG6j0uTEK9d/7nlsiShA==
X-CSE-MsgGUID: FdhnXHLAQGq8Xz/yWa5S3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="172962687"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 09:10:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 09:10:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 09:10:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 09:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJDWNcgkLyhrQbH8p+Hk2aXc5BsCx6gYcXwmGrOgYeL7QtLAqpfETisldrJNhT2hBuyHYf3Y15ERhj0RRXsnUneY0ZYYlLqRg6mWYHVDFH91Zr5rlJdMdEmc7cUIWTV34qT0Vdy74KqqzROqpdH2E7PE4UDdPABWBuzlloOi+9uq7q+sccFNwt5gBq8/DOez6ISd1eUq4CLhCcmfcReKULjUBt8Ad8MZkHpDUyy3hbH+y2lZgY1fd1kAhJj1XtcjHpM6cA4XtGd3Ba17fqp6VxDYsDiGfdgVr0M9tHcPRQ/cPd0rZ4nn8qJF9c18PvbC6QJ24hwZRdsed+/uV2B9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+NjZmZuH+LUWv+mzTSThsgc9C6am3PMS8EwzQisc68=;
 b=WT7xLXHUa4P4Zh9YOaqPyA8MeyZunRCGyTQS5djCv+krZ02ReOgZcX+lHtqfpuHT51pEcGkJ7NP+eNpvEzN1ba7zJff+fDFY4Tvsu1We+TVqroO0Ioii6O0N9EO7u+OE41xjQZHvD3b3fgROQ8l7PUVGpYkn2Zgz4gJsikaMY9OaantOxOo78StJ0FJGkqONI6tuiyu2WlqEkhbqSRFDTqLCvnHeqyAXfZZ0FIa5cy48HFnQXVouffcTCg/8gsGo7RvElzaWBtuBFYe2uEkVv8F/JbFr8je4eizLv2229i8kfYTjWuzqA0xHl3GHrybjqcpnxAsgMcCtJIWREKJa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB8002.namprd11.prod.outlook.com (2603:10b6:806:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:10:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 16:10:30 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v6 00/15] AMD MCA interrupts rework
Thread-Topic: [PATCH v6 00/15] AMD MCA interrupts rework
Thread-Index: AQHcINcFyIlW4rHZ50eDNd2HXPY7mLSJdCfQ
Date: Mon, 8 Sep 2025 16:10:30 +0000
Message-ID: <SJ1PR11MB60835A037ACBB309D3FBE7BAFC0CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
In-Reply-To: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB8002:EE_
x-ms-office365-filtering-correlation-id: aa371392-aa0c-4887-d114-08ddeef23b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bGJaTy9ZMnBmMVY4RlowOXErSWl6U0xaQXpLVVBjQko4QmlXUlFyRFZuV3RC?=
 =?utf-8?B?MVlCMWpEQk1FZGhQN1V6S0cvUXNwbFFjZEx3MWt3YkdEUTNsc1pFYldGUmpD?=
 =?utf-8?B?aVNqOHovL1Jxc2ZZdnlNbmxLd3NieDdQVWRZcHVkYzk3QUZmMGwrVHlqeVNJ?=
 =?utf-8?B?Yk5XcVZvRzdHRU96WUM2RUhBdlF0aEFEZ21WbmNUc29VN2VONlUxZmRrZmFY?=
 =?utf-8?B?eE9pUy91OWN0VlFTVUt0UXEzNkxnUTJGR3RwMnFmZDJDYmo5bEtZcURIaG8w?=
 =?utf-8?B?Z2tnZWJiUFlxMVYxTFo0Qkh4MWIwWmFLK3FEVTMwbzNoM1lSM0Y2Z0IrU251?=
 =?utf-8?B?REpvQnlPRVltV0U2Tm5yUStCM0JWRjNFQzA3RGpnbUplMFFvOGxpZW1pRGZ1?=
 =?utf-8?B?OGsxK0pIa3dyMzQ4M0pTSFM0MlloNnZmYkwwczFaYzdzUklUem5GVWlaODBs?=
 =?utf-8?B?TjRQOTFMbFBFRjhxZUZxdnNKb1B1QWJ5YmVETWNFRHZROGNGaEY2Q2lDQUll?=
 =?utf-8?B?a3VwSUNSeHc3L0xTaWxWemNwZXZJUDFTYXpXYjI2K3llWUdQU21VclduWGth?=
 =?utf-8?B?NTk0RG5WN0J6NStJKyt4L0tWVGVmU2RRTkZISW4yaDMwcmJVQjJnOStocVdC?=
 =?utf-8?B?clR1VWJaZWs2bGQ3TWw0OEtMSWJrWTljWHJRaW9lVXNuUmQydHU1Ty9GVTcr?=
 =?utf-8?B?RDFCa055aGJkMysxeVZwZ2VORi9aQlQ2ZGNRMWJLTFFrYkZJbUxJeDVJNjdQ?=
 =?utf-8?B?UE9RT2VWMFJCM1ZWRVlYcUowR2JLUnJ2cmtGdHRRUVUrNExBbVE3dllPTlF3?=
 =?utf-8?B?am1SaCtmNDJVL3lDOW9JbGJrYThvRjRuckU0eDZzd3Z5c0t0KzI3VzRzR3p3?=
 =?utf-8?B?T1Nsb2YyR3I0Tk42UTY4bkRqUUMxVUwxbzVEZ0VzUi8xR25yZ1VsbDhIUTFq?=
 =?utf-8?B?dUZPRlpHRU9hZHRkdUtFdGtocDhndXZ3Rk5aamhRSEVQazNXVVA2cWdYdGpZ?=
 =?utf-8?B?ZUE2V1NKSjlKY1VEVVBxN1poVklLZVNHM3lRTWo5cGdSV2VXdTFTRXNTdFcr?=
 =?utf-8?B?eVp0bU9jQ2lxUW0wdjdKSzVhYmppdjQyYWlsNVpHaGZ1L0szNWkzMW5YQ1BS?=
 =?utf-8?B?T0JBRFNyQjRuSGs3NEJWUTY1VWlUMXJtU0VXRjdkdzd1aDlYQXVSaFVlTFoz?=
 =?utf-8?B?bXlzczFPT0lnaEpUZk9xS3hHUjZkTkFuK0YzLzZ4RlNTR1RYNXIyMWlON0Qy?=
 =?utf-8?B?bXZDb0JzaVZCN29adnBRaWp1MDAvS1BmZ2hvcUpPS1MvUmdndzR6MjNaUm9B?=
 =?utf-8?B?dkgrZSs1RyswaU9LV2t5eUlzQUlFZjZPRnVyYzduVWZQOWx2N3NXQlY4WUN1?=
 =?utf-8?B?M0FEUzd6QXJ6ZzlZRzB3TnNOOFY4ZGJENUNnK1gzcVB3OUVydTVsUXg0aHZW?=
 =?utf-8?B?YUZLRmNJc2FMSmQ2Wjl2QkNJU3BlZGNPeG5Fdk1pZDFteDFvT3RLS3ZGa0Jj?=
 =?utf-8?B?N3VNY0dMZGZ4NlI4QWZ6TkpWZlJ5S1NJc21kZFE1akMwRHJheGNsWjBVR0gy?=
 =?utf-8?B?OU9QcVVDd2twZUdZZ3V6bGVHMjNXRXcyUG5jMTFTSWFUSGVoNXNlZnBkTHBL?=
 =?utf-8?B?MmpCaWtlbFJ3Sk51T3MvVXJoc0pyVjZ0eURjR1RUaUV5N3ZMRlBkTkhPcllR?=
 =?utf-8?B?VDdkNzVpeVR4UVB0bWdkbFRpU2NCallKMk9IMElyK2plaFl3blZNeDVTdmls?=
 =?utf-8?B?UzdnZVpJdTV2OGxVYSsrSkU3Um5rWGtQYVVsWmY2Y1pLZmxYcWtUN3lYU2t1?=
 =?utf-8?B?b3IxVGZ4enlYMStwZ1pYZEhnUGVDWW5PM2RDRFlhNkpsOTZLNjRpTUt4Wk5P?=
 =?utf-8?B?U2gvb1FZQm13UU9YcjZNaXJ2V3NSMG5WTUVqSGN0bWNtRXFLTE1BaUVtSWV2?=
 =?utf-8?B?RzB0Qzd4cmxKVGZDcm42R3J0c3lmNTV4cWwyclB5TjhRMlh5Q1htSW01ZHhE?=
 =?utf-8?B?dFY2ZEZmOUZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dlZDl2dlpRMDQ3K0huZ2tQcmJ6aUIwREMzN1NkVnJKK0JmMitlVW9FMUJp?=
 =?utf-8?B?dUkrMmlLRStFeVhTVlV4V1pxL05UYm43cGI3L2IvMjQrT3kxWkNvZFZ5Y0pF?=
 =?utf-8?B?VjhXY1pBZzJ2aThGYVNiZFBXdzF1SVhFZ0w0RFFsMTkyWmNrZGFUb3dGbnJT?=
 =?utf-8?B?c2YyejRselg4aUp1QzJHL2xXTUZpNE5nZVpuNGNlZkhaZjZVcnZZWGg4Y2gw?=
 =?utf-8?B?ek9KeFZKaUNGcXJreC9ITnFmNENja3hMSHR5WXJGNlBGQ2cvMTBUM2lVNHJI?=
 =?utf-8?B?dVMyeWdyMjkvY0MyNXE2d09SMyt2WXNzK0JLMWZQNWhIdGhvMDUxVHM4UXFy?=
 =?utf-8?B?NW1nUEtnVkR1Zmg1ZW9JTFcyTi9NelkveWNGVVdhR1BiOUx1S2VFODQxaDVj?=
 =?utf-8?B?VDBCSEFSTloyaXhLSFJsNHFyUXZlL1VLdDZweW91MUc4aUhNL09qQXhZS2My?=
 =?utf-8?B?azQrdU4vMHR2RUZEcitEZVFCTFRsYStTTjZkdEJ0MU1HcnVna3VoVVJDK011?=
 =?utf-8?B?WFBTTWdVbWhHUzBGMGFtckxVTUNXWnVYQmZ5TndjMkw3UmFsQUtMSWcrL0RU?=
 =?utf-8?B?clc5aHh0MmtlNjJaUFBwekdNOGd3V2dKc3VxZHZYR0hVNWZuelBQc0w4bVVX?=
 =?utf-8?B?WnVuM3VwS2F3ZDlpL2Z3VVc4ZE1iM1pFYjhlbEE1WjBGRUtjMGdZUDhNbzZZ?=
 =?utf-8?B?dUlrQ3VNUUtsTkdJUDV0QUkzUlNoSjNXdUdpZDZ5UG81ZlFjQWlxeGVxcWlW?=
 =?utf-8?B?Rlk5Y1hJOUlnVThqdUtwWTltc01KTm9MTHIzcmllc2V0aWY3USt4MlRXejZV?=
 =?utf-8?B?K1hocUxXZ2gwYzBLTC9HVGo4YlRWZFJCYlBRMlBreGQ4NXlPWnk5enA1VGg1?=
 =?utf-8?B?SzdEeDdjTEM1enZYUWliYlJJUEczQ1VhVkNPd2VYZG9Vdkd1czlqci9oNzBD?=
 =?utf-8?B?SFphcHM4Z3lRZDFLVVJXN0Exb21vSmtORE1PR3k3YW9BZnVuYTNUNmVHUXB0?=
 =?utf-8?B?MnExWldyR0FTaG9oNXFoOUFKQ2RnYVNwWFc2NU9ySU82Zm42ZksrRkhLY0JC?=
 =?utf-8?B?bE91VWFmZ1Z1dmpNNVdkUEdmOEJXallkRUlXcXR6TEhDWG4vMU9SWFFhUndM?=
 =?utf-8?B?Ni9jdGVQc0Z0Qys5QWxNNytYNWQ0ZVBsUzBnMFpGOE02MEkybzhrMzNaTDZh?=
 =?utf-8?B?WGxhWXJ3RWZ6MmR3ZmxUaFlDU05PVUpYS2Z3dEZybVY1VGczM2l5TVk0OU1v?=
 =?utf-8?B?M2YyN2RyVm43dE1EL2xVa09TSno3OXJsbVo5eU8wZDZPQUYyY1BBSTBiaWlJ?=
 =?utf-8?B?MkoyZ3Fhc1oxb29qbkE5a1Bpd3gvYWN2ZTZVV0MyRVh4djl4djUxTnFsSmxM?=
 =?utf-8?B?SzN0RFVuOTBheG1xUS9taStxMlRuV2N4WERRak9vRENrSUhadTdYUVVnblNH?=
 =?utf-8?B?Q1psUzkzOE5LNy9FeXI3YkFVSytybEhhS1pIeE4za203OUxKTUpBRXZ4dFMx?=
 =?utf-8?B?UjM2c1hRVEdQL1l4cFN4NUFadWRkZ2V4N1NmUzc4OVd2Z29BcjJ6Wk5VQ3Ft?=
 =?utf-8?B?V00reVFqZkR5MTV3VFU0YW94ZDBDc09YMitaUUM2aGZpMU9rQ01kQXIzUVQ3?=
 =?utf-8?B?VXdEWkVxY3hjdHRNNy81b21yYUpDa2s1d0s2MG1XZ2VBNWpKM3UxUGhGWlh5?=
 =?utf-8?B?cldZZmdSRjYvNy9XQmsxczM4cGdCQlBFTi9BQWt0K1VNQjJkTkJPYkhHcHFj?=
 =?utf-8?B?WVQ5Q29RcERmM3ZnRUYzd0dXWHV0QkZ0RUlWOG5Bdmdvc21Jaks2YnZuR2NL?=
 =?utf-8?B?d1phckFNNlBiaGZ5YXArdWVGQ2ljaVZCOFJKTXI4THU2NWgra3NUOEIvbmQ0?=
 =?utf-8?B?M2Vnd1h5NzZvemxKbzlCbUs5NlFXOHFnM3gvWEdRVGFwY1c3QkJZNnRCZ2Rz?=
 =?utf-8?B?dzJQZWVqUzhrQ01qOThNV0dhNXpjWVpQTnRHQVBhRE4vVFFPY2p3ZEpFaTZk?=
 =?utf-8?B?cHhtUmJLN1ppRTZPWGh1Vzl6N3NKRlNMNnJHMDdRKzhpNlZnRk02b01nWHlJ?=
 =?utf-8?B?VzR4MmhrcXppemV3YkV1TnN1d1NQZFJaQTNBQ0RuTVRLaml2M3NPVHRGV1Vp?=
 =?utf-8?Q?ntsOtr/H3ERCB+NDAihnxH7Gc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa371392-aa0c-4887-d114-08ddeef23b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 16:10:30.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gYpNcVHACbqR+Zy2Ao/XXOtEyVR9HzSJR3X0rRhCyUPoIde7YZE0qsa/npluhWYM8Q9LmiNZk3Sb2T81ezdzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8002
X-OriginatorOrg: intel.com

PiBUaGlzIHNldCB1bmlmaWVzIHRoZSBBTUQgTUNBIGludGVycnVwdCBoYW5kbGVycyB3aXRoIGNv
bW1vbiBNQ0EgY29kZS4NCj4gVGhlIGdvYWwgaXMgdG8gYXZvaWQgZHVwbGljYXRpbmcgZnVuY3Rp
b25hbGl0eSBsaWtlIHJlYWRpbmcgYW5kIGNsZWFyaW5nDQo+IE1DQSBiYW5rcy4NCg0KU3RpbGwg
d29ya3MgZmluZSBvbiBJbnRlbCBJY2VsYWtlIHN5c3RlbS4gVGVzdGVkIHBvaXNvbiByZWNvdmVy
eSwgYW5kIENNQ0kNCnN0b3JtIGhhbmRsaW5nLg0KDQotVG9ueQ0K

