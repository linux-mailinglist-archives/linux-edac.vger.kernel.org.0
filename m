Return-Path: <linux-edac+bounces-3117-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DCA392A4
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 06:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9603B3B1238
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00A190661;
	Tue, 18 Feb 2025 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T53iPgb3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B810E5;
	Tue, 18 Feb 2025 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856671; cv=fail; b=OBpAi8PAqdfib8Aroo5Kh6/3ssjfNPk5Ag5OBDuoUq/SaFxJO+UFIXxYgUeVE6QkLP85KmYio+8g0kRa3uE8F9kXQZECO1sHBDs84BwxZuBKZ7Kby/bZ4yexwRX+K4zI5ZzjDAqmKm6KOCB7vWYJRH6FQXZa8PkXXNT8mjSJf3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856671; c=relaxed/simple;
	bh=tR4VyGcEscmW3rd+pfAQVAWEjbWcWWDWsuwE0KPJ8hY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GgwXn/JsVZHvtl7NwK9Z9+BAaBOqINCyviMiNVUoH1V5kb1yrJ7bL8e25DJy7dHwjHmDHRSjsqyHjgKiQnJT4zzR/E3mbR4tNrMCS0oX290wh0r8lkcw1vkVdQsW2jRkPi1W1EgJsPDsFSKAsQZlnw73CS8WKzfr7NJwkIW/Y5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T53iPgb3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739856669; x=1771392669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tR4VyGcEscmW3rd+pfAQVAWEjbWcWWDWsuwE0KPJ8hY=;
  b=T53iPgb3pxozYZ6+967NH+8ymbNKH3KU0eUxM8FFPKrbyGRxeZ+HzEhv
   BAQeYd4Moritto+VL4yGgm/I4NxVY/Dz2AuIMsHrMxwqm5t5+MoUH/d1p
   omPjPDlpDtDylelhZrmPHb5mRteU/DQ7sWDpMPml1RMU0CrKhq9LflfSS
   1R4scWh5Jxk0VLqW8l5uPwZkvoPjnL1vQoPFSj6xmmCq2Nr4sl+oB905M
   X25xjrlOFP5husefJnEezF+/GJBHq+qsCGrmHjg/sNKSmb1XjB2urJOJQ
   C2da2XG+EUAslTZCxaUj6OWdMCfz8y0ti3h0YAr0tMxBkMYJeIW92+Bvu
   A==;
X-CSE-ConnectionGUID: d7HFQYWVT1G1R8Pp7G1OlA==
X-CSE-MsgGUID: b0arvI7QSMqdM7oFvps/6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40243594"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40243594"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:31:08 -0800
X-CSE-ConnectionGUID: IYwmz17mSdGAhVU6MGNqOw==
X-CSE-MsgGUID: FcaMzoSAQCy9kx9keMvDqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="119289550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 21:31:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 21:31:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 21:31:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:31:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDczIoMORtaGxBClNCsz733WeMEXTTWrEM7QeUTgOhQPXnZz74s633MrSkRrQJE0ZJEoC7V4DXWm5zCGGaUJp2VQsNZd9p5jp5DRTp/ord1Z0c7DT3pqV7rKbSIwFuA9z+z5Pnp5QdrMqkJVK1FB7QmnnhgdaIwotWHbK+5BeeV4sPG5NiYZJCRw87SrmTKzgKNh5ULw15q8Ur5TcZVuhH4VafYk1itHMIydRHM9EjbnKciXjN0axekJWJ50PQfe4SRoiPlVj+nSBqiYJQTM9wOdnQR1tG13fBXdXEyfgQrhkHYr9+YZz0KIGmw0lI68ZjQMpbzUhnO2WeK7RYYSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR4VyGcEscmW3rd+pfAQVAWEjbWcWWDWsuwE0KPJ8hY=;
 b=cGoTEj+9Xor0c5LaB46Xreh1ESIhEc71QIcNKww3UxrgD7YdiFWOfPI5HSqmudvpEU94BhVPIMsH4B97Q4BxvIF3J5hHHGgkBE425pX6hqq6N2P8UAt3nPXRUwVAUA0W8gVnPU5ocmubXMsq2ne4rWJ9lOblpOQZ4pzPjDE4EjIEJ/lTjJukElG+N3uV9pSx9cDK9A4tI58KTqq6GYeURr5OFkSJaD9WfPTU08Jy1+5ac54cwvneys8w+IS2Lxv1lS1Ls/ZXez8y7HHYaSGNpZ2fWvdBVDwdcJwbOO61wdrXQ+aBBY4Ak6ZEVyHOt0bpS2Z/cKtoSKnB9i5qjyZoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 05:31:01 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 05:31:01 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 09/16] x86/mce: Do 'UNKNOWN' vendor check early
Thread-Topic: [PATCH v2 09/16] x86/mce: Do 'UNKNOWN' vendor check early
Thread-Index: AQHbfjfmYLbzjrcV50WJG1b+XfO39bNMj47A
Date: Tue, 18 Feb 2025 05:31:01 +0000
Message-ID: <CY8PR11MB71341C4B284FB8510F122BD989FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-9-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-9-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB5807:EE_
x-ms-office365-filtering-correlation-id: 392fa213-f8f4-447d-92b2-08dd4fdd6e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHp6SU9IdWZ3dmJ5aHAycHN6cHFyaGpvNE5QRnUzZVIycjBhYlM3Q1Vqdmti?=
 =?utf-8?B?R0RGQ01TU0JsUGo4b1l0V3ZWUC9BQ2kxNVpQRlRDVElDNE1Uc1JJMXQ5b0Jh?=
 =?utf-8?B?YU5ucjM3N1cwUnhuS0puVWJwTlJqQVB2eFZvWjhtS0ZrTEpqTit5Z3EwMVV5?=
 =?utf-8?B?c3FyZE9Fb0RMK3VXTVlOMUxjWjNMTW1EWUJPUm1qc29KOStiVEpCcGUwN2sv?=
 =?utf-8?B?cGk1R0xrT1gxakQ4N2ladW1Lc1FMVUF3ek12cFpjRTFsNVAyeVl3bndVOWdP?=
 =?utf-8?B?ZHh0dVREcWV3Z3NhTkVYSFdZNUR4YmRTM1RBOE9zZ0cvdDg1bkxqNkNpdEI4?=
 =?utf-8?B?cG5hbWREQzcyL2xmTGVwN25OOXFWQVNCRmdZcmN2a2xrdFpjTFM0aGlFek53?=
 =?utf-8?B?OXkweFZpS0dYMUJRSmFkeXRRWkNuS3ZTRlpLaGhxL09CZjdrd3RHUWZ4NVky?=
 =?utf-8?B?cnU4M1pKK25mcnBWeUN5aTRxL0pySGxVd0ROUDY1S1FGa0lldVpsOHdhcHhv?=
 =?utf-8?B?Z0twbnBHaHVidllMWHdNakJBSHZtUndLMDMxQlZUYkxSL0NTRUlkT2FPaTVK?=
 =?utf-8?B?RHRheFUwamwwWDhaY3JBYlJyZmRWQWwxY01RcmNkUU1SZjJzM3Jjc1hwY3Y2?=
 =?utf-8?B?dWpHNU4wRGpWNEdPZHlJSlAva3k5MVRSMThSWU5iTkZQRXFFLytVUlJkbW4x?=
 =?utf-8?B?OTY3ekRQaGNXQmhpa0dZeDc2ZjV4SjBTMW5ZU2grZlpXYUlFajRZUC9LYzA0?=
 =?utf-8?B?M1NUdzZTNTJWcW9xS2tqOFdkMVltZHZMRTNZUng1ajNNcTFkUENSeTVndXlu?=
 =?utf-8?B?WFFpRVJ4Um9vOVM1VENabWJEd3kwZjJTbDlMVk41dDZVb01kMUxjejQwSytN?=
 =?utf-8?B?cVNUUlRJNnNHb2ZUckRoMWtaUkxJNXByN3Jjc09oZ0Q5cDZmUUZ2YStRcUtJ?=
 =?utf-8?B?MGdrRlErQjloYk5CZmhaSDdoUGxQaHZrazA4TTdxY2g1MjVHQnNnRnN0WUd5?=
 =?utf-8?B?a2c1T3JqdzY1bjBMVEtXeFNjTW5DSGZzc3d3V0UwKzdBNGMyajNNWnl5UXFZ?=
 =?utf-8?B?aDlmV05pcDIvb21HdTg3QThDbXQzRW55aHdWcXg5cE5kRkFhQnJPSEFJMGxR?=
 =?utf-8?B?K1d4RVpQNDlJRVRUaTVWbC9xZlhQOWhtVUlFUC9vTHdBMHA2Tm81SVYwUFJL?=
 =?utf-8?B?Uys4cExtd3JMbzh3eHVvZitvSGs1Nlp2bGgxcjJpckh4LzlraGdLdWt4Nm9y?=
 =?utf-8?B?MjBIWW40elM0OTJxdDRlR1podCtCTmFLNXdpT0plTERMM05URHR3UmthTERF?=
 =?utf-8?B?bW1CcUgyMVlmZUpETmk5QVRxZVJucC94SEZNcDJlZjhPem1wc0JYUkYxWnc5?=
 =?utf-8?B?anEvM3hJK1FWTGoxUUFJOWJoVENxeUozSWdlRmxCNVZzS1hqRVNPK1A4RExs?=
 =?utf-8?B?MW4xd1dscDhRaWNRWjlVK09ETXM5dXJNZ20walptMTNBVk5qWFhrcGxDZkhy?=
 =?utf-8?B?SWNrZE5YajhhdC9PV2tRaHdsdjBPbzNpcGNEQ2ltTUZNdnRjQ1FXeGJKTFd0?=
 =?utf-8?B?YUpsbTlGKzVHeW1wU09CdWhVSVY1cUUrenhBMm9uL0s4UG1QQlJlL0JERVl2?=
 =?utf-8?B?RXZDdm9naUhlNDdQY0JvN1dZa3dlZDJRaldFaUtTS2JobGsrTi9EVHh6WUN6?=
 =?utf-8?B?d3VDQ0NzeUlKUXlSU1Z3V0tTd3RYa3Fhb3Qvb2lueW00dEc1QzkwQzQyUUVs?=
 =?utf-8?B?TGV3eDBzc2tWUnZ6UTBkV2ZwUVM0N3pSOXJOVDZDV1ZCUE00Yjhrc04reHlM?=
 =?utf-8?B?azJweXIydjdxVEIwZVZVQ25RSmRFakpIYUFQd0ZmYnF3VlVRT2tRbWU2QlZJ?=
 =?utf-8?B?WnVwa2w2b3F0SFJtelpkd3E5SklFRjdheW9RbE9lYzU5RTluaXdIbE5xZVNx?=
 =?utf-8?Q?r0JsTHxSdRdG8eO16DyMmY0ttbovzHD9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1J2dlRibjkrSFdHcWF3WjYydEFOYUljYnZFNUJoOTdpUzBxRG5OUktJYjlF?=
 =?utf-8?B?Q3Y3YnFzeDE5L3J1TVR4eCs1aUw1Qm91L2RGR1R1YkNlS1RSVXlVVUJYeG1E?=
 =?utf-8?B?ckhOQ1F3K0NvUEZ5a2lpYmt5V0NFMzlXWkVyaUh5S0tMWW54dmZrR1pla3VL?=
 =?utf-8?B?M3ZsSkRMSWUyVFo2MGFoNDFUYjloekV3RjYwZFhveWcxeGVyOE5GOTJmWHF5?=
 =?utf-8?B?bzR6VW4vU3NGVmtZUnI0WmZuZ0tNL2JtTXU1NEh3MThLZXJ1T3lab1NBOWtV?=
 =?utf-8?B?UkhZcWl4dEpVSXJNMElyajViU2Ewd3FXcyttdm8ybzFZcWZxOFo4WXFPOE5S?=
 =?utf-8?B?NVdnOXh0ZGdBY3B5SG9yeldYWm42SU1taDhOY0xoZzN5RkFpcjlhb1ZOYmtY?=
 =?utf-8?B?cTFGbVdqSkxpRzlFNHRONUZFZW1Za1RqSzRmSzJaS2VOa2JreC9rMXUrV0R4?=
 =?utf-8?B?b1ZnbWxDcC9FckVQUlIzSzJWMXVsSlNUU3JZNGlTWHdoTTFsZmRBZTJBdjRK?=
 =?utf-8?B?SHhITnNBRjBqYTFuaXk3QmI5eWtpN0crbEVvQTFiMlMzRHVqRFFlc2FMRVZ4?=
 =?utf-8?B?RTBtZFRsck4xc3Qxc0VteVNWR1pMRncvSGJiVDdmbmRPdUVzaTJUenpVdmZo?=
 =?utf-8?B?OThxdGJkbHhIRXF0VmIvdmtoOS93VW9YUGdYNjJjOEJJQ01CU2JBU3pqVnNu?=
 =?utf-8?B?ZFpoa0E3dUsvVXVZcUJlRUFyc1doaXVuL0gwRW5hNGFQOG83clJ0VlR3S3dT?=
 =?utf-8?B?cU9ZUWhxdFlVV0lFZUFuZm9CdUEzS1FxNEFtSFBycTdzclNTaXFFRTVwaHRi?=
 =?utf-8?B?VVE1U3A2MmdZdmFpcTZtMXJoWnRkS1gxL1EyY3hqaEx5MTk0Y1U3QS9BQ0FI?=
 =?utf-8?B?TzI4ODFhZ2VDYStRNXFZL01SMTNPMWtpZFNqZnk1Qi8wODVORExtMGVsU1hL?=
 =?utf-8?B?RktJZXN1N1NyNWxOR01McHl2QW94Z200Y2lNOUdRTG5PMXI2L01JT3FBdTJY?=
 =?utf-8?B?dC9VTkRyMHZmZXZMRmExbGNIbVNEbDNFcFNvdG10aG1oMFNuSzVodnRlTGox?=
 =?utf-8?B?YlByc2pVNElsNTNMUGo1ZEI0V0VId1VuL1ZaWVArczYzbjNQSVBQbUV4N1Qw?=
 =?utf-8?B?dFJlZCtyYkxXTFB4L1A2d1NlUnJkY2lDbmpnZVREQlUybkRiSGN6dVNPQ3VJ?=
 =?utf-8?B?S3p2SmFRYjlQdUlCellLQjZlMWxGN2RmMlZIeG1kRDd0UlFqVWVqbEpOL3hl?=
 =?utf-8?B?U2lYc1VYSnFlTWJEWklhM0RNOVdYTE53WXAvRnRJc2JyQ0ZCQ2RzRTZsYTl4?=
 =?utf-8?B?cU0vcUJSWjl5dmNFN3hjVURwOW4ramVTMUc0dGlpVldVNXRaU0pvV1Q2bmRu?=
 =?utf-8?B?L1NJeVJFTmdqNTVjdkhWbmYrNFd2NGNWK2Y3TkZkcHpaZUFNMDBPZGU4aDAx?=
 =?utf-8?B?R3hGNWxaR3hjRHFsbUtYSU5lSmVGSkszcXcwdEp0Q0s3cmVLTkVZVUl1OWtp?=
 =?utf-8?B?Ni9zYi8yQkluVnZmNndCZzRjWHYyb0pLUFUwQ2NpMEQrUFFISlBxY2xXMVlE?=
 =?utf-8?B?QmN3UnFQNlpoZE5IQkJUbUoxRmZOQkxISXA5RllldUxnOHRTTUlWSkF3T1Qv?=
 =?utf-8?B?TzRTV2svK016MnJrdzcyTkl1WEYvSUMyY1VHUENwckxMY3hHb21oeDV4K25P?=
 =?utf-8?B?bW1peERtemN5MzJtQnZ3VlBaTmN3Nm45Y3RIa3FvaVFGL1lYYzVGYmxVYm9s?=
 =?utf-8?B?c3NxZDlTT1pnaGliWnVCZVVRSE1ydCtOV2tmOUo4NjdwMkFZRUFyTmlieEpR?=
 =?utf-8?B?NXluUEx0VGRzVWVKTjMva0RvR0xRalJiZk5aLzFuWS9tMnNla1UxOStIaDh5?=
 =?utf-8?B?U1YzRTRyMUxCVEx4cjRyWWdDT3dwQlhCZHQrSm9RcU5xekNJaUxBcTRZWSt1?=
 =?utf-8?B?NHZ1OHJzRFptRE0vY1RHd0JlK2sreG1neHhQdlYxOFYrSXhpdHZLRUVkbzdD?=
 =?utf-8?B?c1h0SWErZ09CelpKS0RCdEhIak9yaUdpNHdnd3FyYkV0ZENvN2FxS2pyemNk?=
 =?utf-8?B?MzBDV0o3VFdWZXBxbGJEU3M2ZkhpT0dtdFY0enkwS0FsbUw4TldxMjdGcmww?=
 =?utf-8?Q?/1Je6xhCjsJA75QAYsW7Giok6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 392fa213-f8f4-447d-92b2-08dd4fdd6e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:31:01.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9stlfquPipmLP/He8P4HPDU3rK1kksaw1qNfVWNXYCPxBgdHESOWECAhFGBmHrEiaR66/nYLypIfbIzMipv30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwOS8xNl0geDg2L21jZTogRG8gJ1VOS05P
V04nIHZlbmRvciBjaGVjayBlYXJseQ0KPiANCj4gVGhlICdVTktOT1dOJyB2ZW5kb3IgY2hlY2sg
aXMgaGFuZGxlZCBhcyBhIHF1aXJrIHRoYXQgaXMgcnVuIG9uIGVhY2ggb25saW5lDQo+IENQVS4g
SG93ZXZlciwgYWxsIENQVXMgYXJlIGV4cGVjdGVkIHRvIGhhdmUgdGhlIHNhbWUgdmVuZG9yLg0K
PiANCj4gTW92ZSB0aGUgJ1VOS05PV04nIHZlbmRvciBjaGVjayB0byB0aGUgQlNQLW9ubHkgaW5p
dCBzbyBpdCBpcyBkb25lIGVhcmx5DQo+IGFuZCBvbmNlLiBSZW1vdmUgdGhlIHVubmVjZXNzYXJ5
IHJldHVybiB2YWx1ZSBmcm9tIHRoZSBxdWlya3MgY2hlY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQoNCkxHVE0uIFRoYW5rcy4N
Cg0KICAgIFJldmlld2VkLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCg0K

