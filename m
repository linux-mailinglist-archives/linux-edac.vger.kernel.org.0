Return-Path: <linux-edac+bounces-3136-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C378A39E00
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6308A161FB3
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B831E526;
	Tue, 18 Feb 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI9Tcs4Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085938DF9;
	Tue, 18 Feb 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886715; cv=fail; b=mkCAKjbHpsCSOhMgZsP01cT39VxiJ0lWfvpJ0XdjT+kuwL8Lj0gpx1qTUCauHGyg6ZnZhN1KMxi3s+gh3IMEKusK3PrrAG86bbFFpsX/SGqbn4HWU7yLoKPiHHwGCT1ID2SY1AJjBkWk9bAQrLJztVh3yK8REOhL0vUbxMsmdhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886715; c=relaxed/simple;
	bh=qJCabo14c8nMkf0tkDPqA0MXuam/riStPOfVxFh91SA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=olu3wiv6QWlXecyCzOyguifZohakcxfKbPS9x/f8egbmqOiXRLuPt6i+RVfiEHcp1HCwQLkCIUUb+xz1EhcapMy4LjrzTE0hHK+TIcMu+33x2Vq9VQOyQNjuPzdOYZf36r/DSNW1vO7yoiuv9yQ/WI/UI7wOZWIj9LuQ9cAOEnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI9Tcs4Z; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739886713; x=1771422713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJCabo14c8nMkf0tkDPqA0MXuam/riStPOfVxFh91SA=;
  b=dI9Tcs4ZR7m2HVmD+TigthwUjD4emlZ5JFll1CNFAkLmzwvm40xCKKE9
   ZkdmAVnf5dW/ga1t58EbkOYYH81KybttUgiXXynpT7SH4UDGxvrybsawY
   myFkbiFaekreKK9VDF1Wyrj7UsIqRQVyrLSb6ValK3LqeeMlJ2StYl+sN
   hyC+lYixjKdrNldEMtK8PY+k8dw2s93jeSfYdAXJfGlYrPinW/WrP1bZr
   BdQYVtuTL4N8nINUKVv9qa9ZahUiB2rN7tdjgmb+5FbTfPstxZoSql+Ib
   miq8xT9wLnJieOW9xKBht2VYISmq7iIQrw4wtNVgp1u+OehI9aJF2eQSt
   w==;
X-CSE-ConnectionGUID: JQXpkrEBQgGLbZoHqenGmA==
X-CSE-MsgGUID: DcuTiauSQamDL93M7Pkj4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39772112"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="39772112"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:51:52 -0800
X-CSE-ConnectionGUID: SuLzFeHoTtmGOHj4xOnZrQ==
X-CSE-MsgGUID: UWEzTrcNQTqWr8nXoyVn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119332095"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:51:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 05:51:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 05:51:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 05:51:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0PqZSDc591aN4XafjY3fc7T1VNM29amF/qlCKufSJUfnuKoDpCz+lIUL/e5ooX+5A0rys4BE7wzVoW4lEIjhLWrno2to+czQbMpt/hIdo04Nqw5nLWJ6ZaeHw6up0G4esU4AT1wpr0ekGRinTIVa3N9QRoS8YpHJIn3CqmibQ3sFBQt0hE79pIr0zGkBqKNPRPzO4A60D0L1cDK9v7WSvZVyx6GXoY7uaAfE4s3BlEcSiXKaHVBtl/kzPdnLkP4pXSr2SprhhRI0Q1q9AgXKsnp7gMwxhVmkGIf/FBvSEJ2AH4T01WYMnvmOZ5zEyjLxuWYuQjYRWZfLqhywjQxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJCabo14c8nMkf0tkDPqA0MXuam/riStPOfVxFh91SA=;
 b=LmnQHu2EjBaBomki4JmvuoityJfKpZ1Hc/SuM/dwj8v60jk5zAYNI50cnigmzAMGT9awrVGbUmMyQm8Itsq8hQqveDSt9NOMkqI7KOKcz4N3dY6mEudtMX/rfjWV4o38cPHdXrHig9YuVr10skp9608iIVK7ZpSvcN4mYD6q7ekH7MBMlZu0KLHmQ+1B1XN0CIeY3Ds+6Ph4zMrpgeXp/NPK+2QkUvihCUnuQzX6FJ1yD4hljRbdA4tgyix5njoaekRgC9CA9rxC1otpvcmUZ/yi/nB8mIRseUgsJpp0uoFhpBH7f68pOBlBOvxZe1ldYs51CMbmkhf//w1osUOyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:51:27 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 13:51:27 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 16/16] x86/mce: Handle AMD threshold interrupt storms
Thread-Topic: [PATCH v2 16/16] x86/mce: Handle AMD threshold interrupt storms
Thread-Index: AQHbfjifrGgGcuKdYUSWkeVIDynIErNNG7qA
Date: Tue, 18 Feb 2025 13:51:27 +0000
Message-ID: <CY8PR11MB7134F91FCEB3BA8D2CFE4DE689FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-16-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-16-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV8PR11MB8608:EE_
x-ms-office365-filtering-correlation-id: a2273336-a328-448f-bd6d-08dd5023577c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azR6Z2N5ZTJ6ZG52Vi8vbkQ3ODhxVWZHWFVLQ2xpZkdqMmNtUmNKZ09CaFZN?=
 =?utf-8?B?YVpmSEpsNW9jeHNMcEovazcxMUhxem1GQU1yWkt6dWRUUmRRai93UnEzUUdh?=
 =?utf-8?B?bC9lQnI0WVBpOGdVUUk2My9EWC9PK0tyWmpRcFp1QjJlWDV5TW1aKy9xQmlU?=
 =?utf-8?B?N01PaUlubUJLMFk5VHRWQWFFcTk4QzlqbUVBS2FxcVdCdVFyUHZvUFBmblZh?=
 =?utf-8?B?Z3pDcmFuOFJXUmZnM1RrKzVab0MyVGphNGdFcmhGOTJyZTFuaTNVbklOcG9K?=
 =?utf-8?B?WUp0V1VmcGxvOTM0QzRQcWxoNWFid0RBZkp4VUFwUFdDMkFxSUZnTVFDeDBU?=
 =?utf-8?B?UW1ldFZzMGpjRXNSOG5XTTJhK2RlZE13dGxRc3VtTDhyRzkxZUpENDRMRE92?=
 =?utf-8?B?bTlQcklOZmtleFl4SUlQVTNwdnJOOUovcjBKRTUxcmE0a1djdUxuRVEzVU90?=
 =?utf-8?B?eC9pNUNZdzIvaUtoUnE0TE1uWmJFMUVhRHJPZGg1d2NEU0FZOGZHVVVaQkY5?=
 =?utf-8?B?YlI5VHM1N2YyN0l4NmttcHB4cE90V2FLalZCNVAwa0UzRUFqbVd5ZVB4bHl6?=
 =?utf-8?B?YW1nc2FycDVoSzNZakdwUU94R094MXlaazJTMVhFM0xHdXVqSDdGRFRMY0Rm?=
 =?utf-8?B?cjUvM0srVzF5Rzh5OFZSMjVCTXpiWkNMU3dpYWNHYzA1cFBwYTl1Q2lQbGl3?=
 =?utf-8?B?TXpxL0pnVSt2b1pKRitmMVduVHVyTFhBVVpjMVdVWC92MktxdHVpTmJJdEtR?=
 =?utf-8?B?MDhpYStkU0dTNmZPQk1pQWN2a2Y1bitodmQ5clU3MjdHazBxL0tXN1FaT3Ez?=
 =?utf-8?B?Q3JLZ2ZXL05uMW4rYlU0bm5HbmJqMm5tMjBQUjJXckYydG8rYlE5dEMwQkFa?=
 =?utf-8?B?cm1ybk9JRWhNL3l1RTBrcEE5UXR0SUMwV1RrS1FjbnZTQm5MUmNPSWFmUEtK?=
 =?utf-8?B?djlsc2EzNVRLR040TlZmeHY3MlFTbVk1a3pLWGxLUFF1YXJadGlQQ2RwNjJ5?=
 =?utf-8?B?aC9ZNi92ZzhuR01WM3A1VXltSzBJRzFGaUtONFhHTlgvcGtaVXBuOTJTQmdj?=
 =?utf-8?B?MmdrRVgwakRHMHJtbE10NUNYWlYyckNvYm9oaDR3c3gvUnVQc3NsUHI1aENu?=
 =?utf-8?B?aWs0MlYyamc2K0NsV3Q3eFgvcUZVZjdjVG43RVp6WVBzVDdBT2RPeDhyTmI3?=
 =?utf-8?B?U205SGt4bjZYTHpnN0pva3pPbG1FTkZuUTJxOTBVNUtGaWRuSjVRZXNlZ0dx?=
 =?utf-8?B?RmZlajZUM212b0F4NzU0QzFhcXZlcUxVbG05WDRhZFZYaE5qblpUc2FWcnhm?=
 =?utf-8?B?cnFxSkg1c3BPVUZMVThjTkpnZzhTZk5DNExPMG10L0VySTV0MVpsWXFzdGtI?=
 =?utf-8?B?SmR4aVVjM2JZMDlDUUFnb09WVVk1c25VaGxvR2pRa3VsQWtHcXFXK0lOaXJx?=
 =?utf-8?B?MlZDenJtQVRjNmlzc3piems4eUhseVFxUmVpeUtYQk5vaFNHMEVVeDJnUC9Q?=
 =?utf-8?B?YnFBRzNqQ0JTTDhUZUFKVkZNdWJPTlUrdjFXNHU0Z1RhSkRxVDRzdFJYV1ls?=
 =?utf-8?B?VGs2alVJRWZ0VlQ3U21KREV4dWsyb3RpYWxXMFBxU25KM1NlRCthV014ZlMx?=
 =?utf-8?B?eVhraVJSTmY0UkZiVDRNWmpZdXVJSjZMT1JRclhFZ3U1SXhTZmJUOFV1VDZm?=
 =?utf-8?B?dHdYUmN4YTVCOEprNCtvYUxsOHRxV3NnOTdYc3JpRDc1VGFrd2dQZUFVL0xL?=
 =?utf-8?B?KzNFdk9XRkRjQXZwalJ5azJ4NERTVFR4UWVnV1U4Tk9RNTg0eFZlUEp1VU9a?=
 =?utf-8?B?WnJVbkNpMEgzdXhtMmVzNzZmTnhseEhUMmFHaW9TWm0yS3pBS2prZElsWDFM?=
 =?utf-8?B?MnJ0bXVXM28vaTBNV0J6UmFzWVFyTHZYUEMxRForc3R4Yko3T3lScDJyTGth?=
 =?utf-8?Q?GvVq8lLZXlXUfNu2Fs0L8PI0YcdfubLN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L09GZnd3TjdoZDc3Njdab01ZcFVJVUVoK0xXQ2hZeUJXMVdNbFd0T3BJRDVR?=
 =?utf-8?B?MkhLZWdPS29saXcwTjI0MXlGT2RKYWhKUmkxOXNDNmoyMjMvek8xMi9ZSER6?=
 =?utf-8?B?d1A3NW1zNWRMZ1I3YVZreG1kdmY2YU9BaW8yRFVLMWFmQmVjNjBRcUZYdUtG?=
 =?utf-8?B?a1hsdHlkWFZDVlN1b0ZoTk9YRmF4NGVUQjBaY1BTRDRMYjk0U1BIQ1c0a0d0?=
 =?utf-8?B?SHdRbkJkS1ZvUXpqNlBVWUZlTit4TEhBdXpueEtMcGZvSXpWWWhCV2RMeG91?=
 =?utf-8?B?RWYwL0V6c3ZlcVM4UkFNbEdFa2RIcDZGVGVLb3Vla1VOQ1JnT2VDV0xEa1VY?=
 =?utf-8?B?c3htTHI5NjBPeDRkTm9zYzJTU21ob1dDVlNjTVM2bkFXNEJLeVI4SEhZWjZa?=
 =?utf-8?B?YnVpeDBXY2RjQ0pzUEloZ3VPU3ptaVYyQ1FRaTVGQXVCT0YxRmJmTGVieHFa?=
 =?utf-8?B?VnFKTlFZbXVEZWdYeGlkVjdPNFczQldUTXpURzI1N1lVclJPdmZWMHhGaEQ2?=
 =?utf-8?B?SGp6VjBjRjd2dnlVT1lOUkUyYks4L2oxVVBKeks5TE1Wa0NndHNtR2ZKYU15?=
 =?utf-8?B?NDV6ZEdRTUo3a1B3R0dGTGUrSzdzUDVpTndBZU1UaHRZai8xMWNaeE5uZk5D?=
 =?utf-8?B?Q09FeVo3aGYwWkw4RnNXYlFveWFCZk1EZ1dKY20vbHk3dmhtVm9ZSEgzOUtk?=
 =?utf-8?B?YUxzTkwwZUJQcVJSTnBpOHFkS0VHcERPUjNzTngvNHRLQ2txRlErQWN0bXdJ?=
 =?utf-8?B?L3N2SjdCUW53TS95bWNUbVI2Y09KYXRHSk5BYU5aU2tGQjdRYWpsYmZNMXk1?=
 =?utf-8?B?SzViVEl2Yk5TOUYyTklIZUdQUkt0ZGJkYWZWWUxIbkdBdGl4K09HM3BWZUZk?=
 =?utf-8?B?bGszejVZazZUdTF1M01XcEZDdkt4ZkZlWFZJdFY3SVlrN25PS2xQTUlWR1dD?=
 =?utf-8?B?eVl4TW16Y1RQVDVQaUx5ZXJlSjFOemVVdm1nVys0MGRlTFF2S0dBS1FyeHlq?=
 =?utf-8?B?OEsyd3ZNYnpWMUwyVXRYV3c0Qm40dVdxNHpQa29hWDhWbmk4OXV6VXNEOTUz?=
 =?utf-8?B?SmZtbGp1M2RBalNZNWRXQTVnK3NkcWVYZjRDYkFTSmZyR25aWUU2dzdhVGFW?=
 =?utf-8?B?N01rK1FaY2ZYQXRwdXc2a25IVnZWbFI1aUxwRnBYbXBKRTdTREJxMU5GVnhQ?=
 =?utf-8?B?N1grK0VNVFFRek1lT0RseUtXSk5iTlRyckpybm5QTnEzcW1mL3Q4T2JsdUFm?=
 =?utf-8?B?anFyckJZQTRnR0J0MDgxWlBNaXV6K29JUDhQdGIra3IweXVzUEhkL2svY3Jh?=
 =?utf-8?B?dUpJTXJLUXY5cmdpNVphay9za29jZzlmTWZOS29BdGpXSkNhcTdYSzBGZzJU?=
 =?utf-8?B?VWNCa1Jiei9QMDN2ZmJUblBYeEh2RklFUE1JZHF6dUFXQjhuMUNEUnYrenZ0?=
 =?utf-8?B?K21LODFobmlLSHVwUmJOYWMvS1FESU1aa01pNXA3azdBOFJmSFYrbWhYVU1a?=
 =?utf-8?B?N0htT0RjVHZ0NFpmTEhSdnE4MGZiWjVIaHdJVUxRWVZWQlEzY3A0ZEc2Ykhs?=
 =?utf-8?B?emNqeXl3T3E3NktmNHR5RTN5ZDhucU9JczZKT1JuOTBWR1dKQnN2TzU1SE1P?=
 =?utf-8?B?bjYxV2tSZDRzM1FvR0JJMTUyQkNOWlV5K0xRL2lLU2k2UEdCS3lhNkVyVkpD?=
 =?utf-8?B?YVBvSExjUkRiV2FGUWlPazNKSjEwRXFJRTRWNTNnaTc5TGdPeGhyY3NIMTQ4?=
 =?utf-8?B?dm5EMnRJR2RPaE8vWFIyc1NYYkhGSUhYL3ZIMlAxMkoxaE92TWVzYWg3dEZV?=
 =?utf-8?B?cFJhMEtBRWpDQ040NjIzclZEaDBGL0NDbzQ3bEUwV296UXFqYnNhQitwVHV6?=
 =?utf-8?B?N0kwdmJzTjNFejVTT1VlcmJRQWJFeG5OZitxVUs4QTVpNncrZFN2bWVTaXJD?=
 =?utf-8?B?SzNWaHExdzYxMTNNYThBei9UK25XL2hUZTFPVmFWa1ZQVFRBQWlRbUVHVnl0?=
 =?utf-8?B?R2dBRTV4M2t4dzVqMjBXWHVvTGUrS2NiSXd4L3BkRjdDblU5eWdEL0dPaFlj?=
 =?utf-8?B?ZDJZWWh1bjNaNTRTNWh3TDZjd0RtS2pkWFM4SUl5QVRGR2JndDdwMHJ5UjRw?=
 =?utf-8?Q?MI+Mi/7n+9MB8E2C9took0Z1c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2273336-a328-448f-bd6d-08dd5023577c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 13:51:27.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXyNEABTulvUH0rCNoGENed76Cfy5FWWraHAPB6g1/lWYcPy8n2MEejEhyD4P9oOBwdBsxloO4XtbcQkzyBZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAxNi8xNl0geDg2L21jZTogSGFuZGxlIEFN
RCB0aHJlc2hvbGQgaW50ZXJydXB0IHN0b3Jtcw0KPiANCj4gRnJvbTogU21pdGEgS29yYWxhaGFs
bGkgPFNtaXRhLktvcmFsYWhhbGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tPg0KPiANCj4gRXh0ZW5k
IHRoZSBsb2dpYyBvZiBoYW5kbGluZyBDTUNJIHN0b3JtcyB0byBBTUQgdGhyZXNob2xkIGludGVy
cnVwdHMuDQo+IA0KPiBSZWx5IG9uIHRoZSBzaW1pbGFyIGFwcHJvYWNoIGFzIG9mIEludGVsJ3Mg
Q01DSSB0byBtaXRpZ2F0ZSBzdG9ybXMgcGVyIENQVQ0KPiBhbmQgcGVyIGJhbmsuIEJ1dCwgdW5s
aWtlIENNQ0ksIGRvIG5vdCBzZXQgdGhyZXNob2xkcyBhbmQgcmVkdWNlIGludGVycnVwdA0KPiBy
YXRlIG9uIGEgc3Rvcm0uIFJhdGhlciwgZGlzYWJsZSB0aGUgaW50ZXJydXB0IG9uIHRoZSBjb3Jy
ZXNwb25kaW5nIENQVSBhbmQNCj4gYmFuay4gUmUtZW5hYmxlIGJhY2sgdGhlIGludGVycnVwdHMg
aWYgZW5vdWdoIGNvbnNlY3V0aXZlIHBvbGxzIG9mIHRoZSBiYW5rDQo+IHNob3cgbm8gY29ycmVj
dGVkIGVycm9ycyAoMzAsIGFzIHByb2dyYW1tZWQgYnkgSW50ZWwpLg0KPiANCj4gVHVybmluZyBv
ZmYgdGhlIHRocmVzaG9sZCBpbnRlcnJ1cHRzIHdvdWxkIGJlIGEgYmV0dGVyIHNvbHV0aW9uIG9u
IEFNRA0KPiBzeXN0ZW1zIGFzIG90aGVyIGVycm9yIHNldmVyaXRpZXMgd2lsbCBzdGlsbCBiZSBo
YW5kbGVkIGV2ZW4gaWYgdGhlIHRocmVzaG9sZA0KPiBpbnRlcnJ1cHRzIGFyZSBkaXNhYmxlZC4N
Cj4gDQo+IFtUb255OiBTbWFsbCB0d2VhayBiZWNhdXNlIG1jZV9oYW5kbGVfc3Rvcm0oKSBpc24n
dCBhIHBvaW50ZXIgbm93XQ0KPiBbWWF6ZW46IFJlYmFzZSBhbmQgc2ltcGxpZnldDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTbWl0YSBLb3JhbGFoYWxsaQ0KPiA8U21pdGEuS29yYWxhaGFsbGlDaGFu
bmFiYXNhcHBhQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNr
QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5h
bUBhbWQuY29tPg0KDQpMR1RNLg0KDQogICAgUmV2aWV3ZWQtYnk6IFFpdXh1IFpodW8gPHFpdXh1
LnpodW9AaW50ZWwuY29tPg0KDQo=

