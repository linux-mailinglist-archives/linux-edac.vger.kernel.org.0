Return-Path: <linux-edac+bounces-2321-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114CB9B4109
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 04:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3286B1C216CC
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 03:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB382C60;
	Tue, 29 Oct 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aERKTtmv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2B4400;
	Tue, 29 Oct 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172751; cv=fail; b=tafoD8uxtnSFgi+wO21M9AKD4mz2jX5OENG3LWcrSQAILvnUcIjjjqVOXwax7OF2xIKc7fkY7Bwn1D01oBMOYaufiRBgJ+Gs1v7ttFdCA61xKkuxy2e+DTDl7YS50qIxtFOMrzXy8YMpEV9b/wP+jWnOpmszylPp50XVgxg4u94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172751; c=relaxed/simple;
	bh=8LoqvMXa7a3VVnDkGkYFfTAd8yAb2EQWud5D2aND8hM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkGE+GiONPI7K20z6c44Q4SzgErtc40q4B6AWU6UUBYzrTgN7b66Qk4I46oVAk1ZkRZeALBeWqSPojPPoSOFlB774H/s8HMe9xaig+Y0t5tZ3p1W7d3iOc4naCPZcM3h8LbwNTWzC3dUgQgs2+wIf+NkBgOTCoedsP1vBgjsFhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aERKTtmv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730172748; x=1761708748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8LoqvMXa7a3VVnDkGkYFfTAd8yAb2EQWud5D2aND8hM=;
  b=aERKTtmvRRcxU4oLLGHdJOG5QXNor2GQmrIoRH/13eXUBilPFZivDmxR
   8zNi6XntClrmBXMtMwd81Szd3GIRXEOQR0jZ/iuU/8iCJ8p1NrTbeTKfT
   0kW+Y2Hv2qNl9KJ5GepcFciKFOgGVN6kFYycduOrC6OUIVt9LaVrSbaGv
   R5qxy7ulQztY7XV61nKJnUXgLRHgACNCHPYWKblYXD62VJj8y+Vawk1EH
   4BTDGH6LZR01hzjgmXFJqCaJsIj3EpJ7eZIyyuRX2D8NDjwnGarLWfQ/P
   lAitnNg3B2ldIp4QItWCllDYhSWiLz6dhKySKJLwt91d/YWnuw5kXGJ73
   w==;
X-CSE-ConnectionGUID: TBfZGwmeS2mSVS6LTAM/6Q==
X-CSE-MsgGUID: zhG8UXFFSCqFVYdq6wEZRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47257186"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47257186"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 20:32:28 -0700
X-CSE-ConnectionGUID: ip6wjgN8RICEKCIZHjg44A==
X-CSE-MsgGUID: j1DpmGoES9OXHzp6KBGkUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86955392"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 20:32:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 20:32:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 20:32:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 20:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsDLFSidbSohwj/RfONz6lZedorIXlt8FmSUoG/Gk9zChWpq8S6+CGJ5NrMJiAIaMHfaSpYhYd6Oshk/wasYb6n1QKwIe9rDMdfVmVC8fT1lR7SEHPdhWoJvkl6rMV8Ev6fpvIfG4xqW3Z0WS7aJq+KDsoZSkrM7d7KvBU9gg7Ix6lEUg1fqmipZXGmzRYC0gVtiYMfgLgtt55islfYOmfETPRhLnyuPBNvwd2E0LQ4cBtpps1Zzwq3WwwXSdETrGC5GuSZgLHcdlGyYuXGXlebzEXbZPVZ60fFdTRl7sTYEqou4v2yYB02wnpmZwhjSNcVgaIrs7N5xLHLsFye3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LoqvMXa7a3VVnDkGkYFfTAd8yAb2EQWud5D2aND8hM=;
 b=tpOUP2pMcihNGkxsxWASa5bgXnQIy5+O+//okzSXGxwjG2HIosI3KWydEDPi6oByyrc05EMmnCEbPvVUHBZ6dt1RLZbhS8Bd+TQJRKwbD2JQm5YTSDVxiSDHL8cVM4zgu2Bl90SsbJ3qvZiPCZfWXanKGAR25Cp37RvL1wqfm16+gxAmRtPGGCu+fDYXJ/vKzyaFQzvIKOgY1ghNGsmD/pY2sKgz1XyiUtDHDVtSnLbBNKvMox0DnbjI7uE8MHeMr/1+j5J46fXKk0iVasYEHyXHvQT74zWwZLdW2Ngx5vzHxOqd4hmD0HiM4OjWIu4wai31gXYDfLFnKmiBCWEtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 03:32:00 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 03:32:00 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 03/10] x86/mce: Make several functions return bool and
 rename a function
Thread-Topic: [PATCH v3 03/10] x86/mce: Make several functions return bool and
 rename a function
Thread-Index: AQHbJouBCN10HIsjC0+EH3rQD3OlZLKcJ3AAgADnMfA=
Date: Tue, 29 Oct 2024 03:32:00 +0000
Message-ID: <CY8PR11MB71347B5215509D3B58258DCE894B2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-4-qiuxu.zhuo@intel.com>
 <20241028130656.GTZx-McByoo3wsR3__@fat_crate.local>
In-Reply-To: <20241028130656.GTZx-McByoo3wsR3__@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN0PR11MB6231:EE_
x-ms-office365-filtering-correlation-id: 265bafde-32ef-4089-ab50-08dcf7ca3f9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UzhVNUFuY1AvakxJTERmV1oxZnVTUzZMSUgxRGFZdktGV3JobllCV1U5RW94?=
 =?utf-8?B?NExWRFplME42TWovdjZyS0JnQmlYUXJDZUpIWE4raG90ZWExMWpiMVFkb29Q?=
 =?utf-8?B?S0x1OHFBVnA3M3NodHhZUzZsY3cwVUw0M3ZJakZDcng5YkxVMTNqMFM3aDFR?=
 =?utf-8?B?cll4cTRyYmVuMStRM3drQTFQTDMybE9uMmwrQ1gydFpQelQ2aVdqeTRXOGFB?=
 =?utf-8?B?Y0RxTTU1WFptck1uMFM4OXFKNjNXMWMyNWs1N3ZJak1TMEY4NVVxUlA1RmZI?=
 =?utf-8?B?Qm9lUzBFamh4dkdSYU15R3duTFJBZXNRNzVNK0RlK0FEMUdwZWxEQm5TQ1d4?=
 =?utf-8?B?cnFCSFlZanBGZ3JGWitSTCtTa0htQ3F6L2FSb05MZXJ3UytSMEUvSVhrRjFh?=
 =?utf-8?B?L0k4Y3VvalJvRWNJNi8yaU91OEtCcWt5VFhZT0IvWFZoL25sM2YxRG03Z1Vr?=
 =?utf-8?B?cnFkTlh3ZXF5cTJrSGxBaEFtUGpKVEhwSW05Q2djN2lVSG1jbDZiemRZdklu?=
 =?utf-8?B?STUvNU9PbDR6a3k4QS9tV3V0ajNHa3BhdVJqUUJ0Sk5XczBaVnVaSVNOVUY4?=
 =?utf-8?B?cGNDTjY2cUJEY0swYkhSblpTSFIwNDlkUmVXalM3S2h0M3UzUkpSZEw2akE5?=
 =?utf-8?B?SDdWbDlNUFlnUmU5cGtvRGJkdkJ2RjNQWDhpeTdHQWRKYW9CeTJiUHFXcnd5?=
 =?utf-8?B?UGFKV21YcVJ6V3A1TGNlaGxBSUNIMGlHcGVwK2hFRUxuZFRWcUd6RG5kamtB?=
 =?utf-8?B?djNONE8xajBQTDdVOVh5aURWZStQYUR0U3gxN1hSQ3NmeTJZOVA2OFRxNEl4?=
 =?utf-8?B?RzlScFQ2TXZtMWkxN1dwdzhYVFVsOFgxb1lyWUtOTHV4aVJybVo1cGt2QmZz?=
 =?utf-8?B?VFRNMkNrVDhWWStwMFM2NXlsWjZ4OHdSZm9IWTI4NFh1cTBjUnYzbGNBVElJ?=
 =?utf-8?B?WGk3MndJUkE1cmtySDdOKzZNTE5YRWJQa2lDem5nVmk5NGo3MngxVDZWbjdF?=
 =?utf-8?B?VGsyWWlxWE5XMHFLTW1KcVNGaVluTjNTVDlHUHNEZXI4Rmt0STNWRlBkNU1k?=
 =?utf-8?B?V3lqNjdFLzZpckR0eVVlbEFYVmo2dEY1eUVlVkt3NUJGUHJnTGw4MFR0eElY?=
 =?utf-8?B?R3JoRE1oQ3Q5QitTQ2Yza1BYalNHaldGVDhzMlJSdlo4SmZoTldqd1dUWnZY?=
 =?utf-8?B?c3hnM1ZwalJhMWNQRjZLRTYrNmRPT0tJYnZPUE5QMk1od0VibnJ4QWs1UGNU?=
 =?utf-8?B?THVQNjE4VlpPVy9XMWw4ZDRRSjRyUGpDS1VuZW4zNUxBNk9Qa0V6MDUyMFVk?=
 =?utf-8?B?UjJiVGxNWnQzS1pGaTN4ZjNPN2NTWTFEUWhTS2owalE3SjYzQ1cvSG9NOGd5?=
 =?utf-8?B?SDBETjMybTRZcmJwdncwRzNKZlBQSkdsdUtJWGJLZHhpVXZnUjh5bFFrYnJ6?=
 =?utf-8?B?MjAvZEVLaGNrRkVIZVRZM3RjTVZsVXkwZGJsNHVMYU5BUDJTVGRxTjFUQ3Jh?=
 =?utf-8?B?TjZMZXRpUHQ0L2l3QVB2d3F6akFHTEV0a1NVNHJYMk4vVkFFOGxQNXgzbmtC?=
 =?utf-8?B?Q2FQaUt6YzBmVUcwQXBneVE2eUZDL2J6dWdjdWREdEMvY0RtWjZUb1hrRkd3?=
 =?utf-8?B?OWhQOUZTT3lWSWhZS0lFZW41OVhTQWVtME52RW5OZnlUck9Qa3hVWmR6ampK?=
 =?utf-8?B?TnBXZlA0dmRDU0ZZb0crSmh2eWNUM2FRZTN1TDh5bVB6V2lWTzl6NDFrWXRt?=
 =?utf-8?B?alQ2L05udDNSM2Jzem1BMUErdVJZM3pqNjdpOENyUk1GeFYyWWwrVjY0TXlj?=
 =?utf-8?Q?8rn95q2ktUEeR8cccF9BFEBlqoUh2rjkqONcs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVNhNnRVVzN0MEk2Z3ZNN09wZ1FQN0lQT2ZyMVRyTXdyMHJkcHFuYmpNK0xZ?=
 =?utf-8?B?QnQyTEpKODhmYzB1SkZpUThNSm56bHRzeHJVQy9VZTUwYkltUGY1ckJzcSts?=
 =?utf-8?B?cUV1dE4wOWE2RTF2YVNYUG1KMDlXa3M4bG9EOVJESHVtcXRJN09DWDBYVUx5?=
 =?utf-8?B?YzZ4WlNpQTBCbGp0QzZlNElMMjBXV215MmNvb3Nwd2duL3lSZExib1JYL2c0?=
 =?utf-8?B?WGpDMDlEbENTTSs0SWNDMVpmVjBzZkFWUkx4eEpaVllxMUUvVFNYMmc0ZXVR?=
 =?utf-8?B?aGx0VU9ibHl1aUdvL0lwTG4wcmwzZ1Rtbmw0UDNTQUJ2MDRIV283V1dRRXFQ?=
 =?utf-8?B?MllqUTZtWFBVWjNYOHNORlZ4dGRTV1ZWeWRqa3BSbisrWXI3Qnh5OVhnWklB?=
 =?utf-8?B?c1liOU5HVFUwTzRIWE16Qlhlb2dWWlNpenFyWGh2OEdjQ2dXcXFKUFByK2V1?=
 =?utf-8?B?UTlMK2toN1poMXNmM3B5OUJkek5UcjY2eVJ0Q0pXbHVubzhWeG16Y0dqSWti?=
 =?utf-8?B?bGpYS0Z5NThxZjJmNTR3Nng0bUorWWpHVk9ya09Xc0NEVVZMU3pacjZUM3Za?=
 =?utf-8?B?U1JKaThoWW9xeTJ5VWhZWHE5enBJRDBvS0UydVBGd0djSklRZUFwNjZ3Ti9Q?=
 =?utf-8?B?WU5kblAzQ0ljNXo1S0ZhWWNNQ2Y1aUhsOTZhUHFwc2ppWmdJbE9GR2FqdlNa?=
 =?utf-8?B?cUZTZ3QrTVpqTE1VRGhhdy80NllDeHI0NkJVcUJGNUhFTFZDVkJjQnpYL1Rv?=
 =?utf-8?B?SU9kR0xhNnlkWjM3bEJSTnEvS2JzRVJnVHN1RnEyZTFoQUowRlZtMVVJN0No?=
 =?utf-8?B?QlV0dXp5U253LzRLN2dOd1B0Rm16aElTU1g2cUIxQ25GQklxNnJ2YlArcGFh?=
 =?utf-8?B?aThFNHpBcDFHU1I0MXIvR1BPc0pIL0VvRmM2M1l0QjNGUHVHdndoNjBlaUwv?=
 =?utf-8?B?Slh0a2trRStnTG4weit2YVo2Z3U2ZnNta2h5RmtIalIxcWh1R252bWZPZnh4?=
 =?utf-8?B?cEwzR2thdWdXUUthWXRpMFh2Rmc0WWlncU03OG55ejJLZmVmMlJKalJpL2JD?=
 =?utf-8?B?R09OdVVZeHQ0dFdoZ0Z3U1RkakwzclN1RlkyazNNa2tETjA2emxPT0pqWnhT?=
 =?utf-8?B?YkpKS1VRdjF1R0tzNzZnZ0FUMTJOMXZIY3RXTVBPSXp1R3FBdTZiQzBpU0E4?=
 =?utf-8?B?SU0ybHAyVGQ0ZUxYTFBSSDdyYmR3UW9IemhhQWFSbW9UZ2pVN3JyNFFsbzNR?=
 =?utf-8?B?NlltOXl1MGU3enBXdUVVR3VrMjFkQmdNRXUyOTEzNnRqQVhnb05Eb0MrclQv?=
 =?utf-8?B?N0R4OTd5YWZIdlFlWTJxQkRrSHk0TDRFbjdyTlZOV3NpOXJ6ZXFPMmdEWlNR?=
 =?utf-8?B?a1FKeW5ubk85WUEvaWE4eUVYamFueG1kcDBOS1QvNXJ6ZEk0S1UzTi9NOTFs?=
 =?utf-8?B?aXFlWTc1dFJUcCtIOEtocDFyMmNMZG44dUk4WXllYWQ4QWw2V292SHZ4dG04?=
 =?utf-8?B?VlFCaFBCdUZGeDBLRG9RQjQ5TkJyVjNGb2lwMkZhWFZmajl2K3B6QjFQZi95?=
 =?utf-8?B?d1Rkc3R5OEsxTGw0Y2FrajV6RjVUSEEvSDNJZEJiZ3hydU1nRWNaeG8yUDBm?=
 =?utf-8?B?L1RXeHJXNUZYY1AxcWpQckN2eE9aL3VhWFhYcEgxNFFTaEZkeHB1SjNCeHBE?=
 =?utf-8?B?TGs3R1QxQWNWNW1hcisxUXRoTE1SUGlmSkxxYjRCaHpQMTZuUDNSOGhwNE5J?=
 =?utf-8?B?RnZkWG95UElLdVgyaTVXUVZDNTdPQUp1K0NnNzU5NkRKRXBpTmRMRU5DYUFL?=
 =?utf-8?B?bi82ZU9uVHBaN1hjSlh3SWRaMmxMTVcwZzBiYzFFRENYOWlLUnVWejd5aURu?=
 =?utf-8?B?a0JERUFRQURCK2kzdmR0QnZzTzlZWU9nS29VL0JnN1FkdkZnWC9pdngrU3RW?=
 =?utf-8?B?cVhrQXkvZVV3TngxdEJHdjRJWGNHR2x1WkxpVEJSMk10V2pmcFdaV0ErbXRS?=
 =?utf-8?B?dG9ONHIrSktEeWNuRU5vM0VYK3FOVVVSSWtuOW1scEdTcnF4dm40T24xbkJy?=
 =?utf-8?B?OXhpSTNzNjJPbDlTcTc4aXJ4Q2c1QUZXZnpQSjNiVjArVElTQTd3cWlzMHFk?=
 =?utf-8?Q?ap+zYB8kMWbtJ6wcmX6d0VvP/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 265bafde-32ef-4089-ab50-08dcf7ca3f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 03:32:00.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVZ78PHwlW5HjXIKmZbHYYkisRA3AbNMqOInbgsq2I2h48NE4dFY4PiwxbGTzJVu+lWtAb7JcGmRDEeDULuCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6231
X-OriginatorOrg: intel.com

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgeW91ciB0aW1lIHJldmlld2luZyB0aGUgc2VyaWVzLg0K
DQo+IEZyb206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBbLi4uXQ0KPiBPbiBG
cmksIE9jdCAyNSwgMjAyNCBhdCAxMDo0NTo1NUFNICswODAwLCBRaXV4dSBaaHVvIHdyb3RlOg0K
PiA+IEBAIC0xNzQ4LDcgKzE3NDgsNyBAQCBzdGF0aWMgdm9pZCBtY2VfdGltZXJfZGVsZXRlX2Fs
bCh2b2lkKQ0KPiA+ICAgKiBDYW4gYmUgY2FsbGVkIGZyb20gaW50ZXJydXB0IGNvbnRleHQsIGJ1
dCBub3QgZnJvbSBtYWNoaW5lIGNoZWNrL05NSQ0KPiA+ICAgKiBjb250ZXh0Lg0KPiA+ICAgKi8N
Cj4gPiAtaW50IG1jZV9ub3RpZnlfaXJxKHZvaWQpDQo+ID4gK2Jvb2wgbWNlX25vdGlmeV91c2Vy
KHZvaWQpDQo+IA0KPiBTbyB3aHkgYXJlIHlvdSBub3QgZml4aW5nIHRoZSBjb21tZW50IGFib3Zl
IGl0IHRvbyB0aGVuPw0KPiANCj4gSGF2ZSB5b3UgYXVkaXRlZCBhbGwgdGhlIGNvZGUgdG8gbWFr
ZSBzdXJlIHRoaXMgZnVuY3Rpb24gaXMgbm90IGNhbGxlZCBmcm9tDQo+IElSUSBjb250ZXh0IGFu
eW1vcmU/DQoNCkN1cnJlbnRseSB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBmcm9tIGVpdGhlciBp
bnRlcnJ1cHQgY29udGV4dCAodGltZXIpIG9yIA0KcHJvY2VzcyBjb250ZXh0IChub3RpZmllciBj
aGFpbikuDQoNCj4gRGlkIHlvdSBkbyBnaXQgYXJjaGVvbG9neSB0byBmaW5kIG91dCB3aHkgaXQg
d2FzIGNhbGxlZCAiX2lycSIgYXQgYWxsIGluIHRoZSBmaXJzdA0KDQpUaGFua3MgZm9yIHJlbWlu
ZGluZyBtZSB0aGlzLiANCg0KQ29tbWl0DQoNCiAgOWZmMzZlZTk2NjhmICgieDg2LCBtY2U6IHJl
bmFtZSBtY2Vfbm90aWZ5X3VzZXIgdG8gbWNlX25vdGlmeV9pcnEiKQ0KDQpyZW5hbWVkIG1jZV9u
b3RpZnlfdXNlcigpIHRvIG1jZV9ub3RpZnlfaXJxKCkgdG8gaW5kaWNhdGUgdGhhdCB0aGlzIGZ1
bmN0aW9uDQpzaG91bGQgb25seSBiZSBjYWxsZWQgZnJvbSBpbnRlcnJ1cHQgY29udGV4dCBhbmQg
bm90IHVzZWQgaW4gbWFjaGluZSBjaGVjaw0Kb3IgTk1JIGNvbnRleHQuDQoNCj4gcGxhY2UgYW5k
IHdoeSBpcyBpdCBvayB0byBjaGFuZ2UgdGhlIG5hbWUgYW5kIGFkanVzdCB0aGUgY29tbWVudCBh
Ym92ZSBpdA0KPiBub3c/DQoNCkF0IGZpcnN0IGdsYW5jZSwgdGhlIGZ1bmN0aW9uIG5hbWUgbWNl
X25vdGlmeV9pcnEoKSBpdCBsb29rcyBsaWtlICJNQ0Ugbm90aWZpZXMgSVJRIC4uLiIsDQp3aGlj
aCBpcyBjb25mdXNpbmcgYW5kIGRvZXNuJ3QgY2xlYXJseSByZWZsZWN0IHdoYXQgaXQgZG9lcy4g
QWZ0ZXIgdGhlICJnaXQgYXJjaGVvbG9neSIgDQphYm92ZSBhbmQgb2ZmbGluZSBjb21tdW5pY2F0
aW9uIGZyb20gQW5kaSAodGhlIGNvbW1pdCBhdXRob3IpLCBpdCB3YXMgY2xhcmlmaWVkDQp0aGF0
IHRoZSBzdWZmaXggJ19pcnEnIHdhcyBvbmx5IHVzZWQgdG8gaW5kaWNhdGUgdGhhdCB0aGUgZnVu
Y3Rpb24gY2FuIG9ubHkgYmUgdXNlZCBpbg0KaW50ZXJydXB0IGNvbnRleHQuDQoNCkJ1dCBJIHRo
aW5rIHRoZSBjb21tZW50cyBhYm92ZSB0aGUgZnVuY3Rpb24gY2xlYXJseSBpbmRpY2F0ZXMgd2hp
Y2ggdHlwZXMgb2YgY29udGV4dA0KaXQgY2FuIGJlIHVzZWQgaW4sIHNvIGl0IGRvZXNuJ3QgbmVl
ZCB0aGUgc3VmZml4ICdfaXJxJyBpbiB0aGUgZnVuY3Rpb24gbmFtZS4gUmVuYW1pbmcgaXQNCmJh
Y2sgdG8gbWNlX25vdGlmeV91c2VyKCkgY2FuIGJldHRlciByZWZsZWN0IGl0cyBmdW5jdGlvbiBv
ZiBub3RpZnlpbmcgdGhlIHVzZXIocykgYWJvdXQNCnRoZSBuZXcgbWFjaGluZSBjaGVjayBldmVu
dHMuDQoNCj4gSW4gYW55IGNhc2UsIHRoaXMgY2hhbmdlIG5lZWRzIHRvIGJlIGEgc2VwYXJhdGUg
cGF0Y2ggYWxvbmcgd2l0aCBhbGwgdGhlDQo+IGV4cGxhbmF0aW9ucyB3aHkgaXMgaXQgb2sgdG8g
cmVuYW1lIGl0Lg0KDQpPSy4gDQpJJ2xsIHNwZXJhdGUgdGhpcyBwYXRjaCBpbiB0aGUgbmV4dCB2
ZXJzaW9uLg0KSG93IGFib3V0IHRoZSBmb2xsb3dpbmcgZGlmZj8gDQoNCkZyb20gZjMzZjczNDBh
NDBkM2RiMWY0YWNmM2M5ZGVkNTc0ZDFiOTgwMWZhNyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEN
CkZyb206IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0KRGF0ZTogVHVlLCAyOSBP
Y3QgMjAyNCAwOTowNzo0NyArMDgwMA0KU3ViamVjdDogW1BBVENIIDEvMV0geDg2L21jZTogUmVu
YW1lIG1jZV9ub3RpZnlfaXJxKCkgYmFjayB0bw0KIG1jZV9ub3RpZnlfdXNlcigpDQoNCkNvbW1p
dA0KDQogIDlmZjM2ZWU5NjY4ZiAoIng4NiwgbWNlOiByZW5hbWUgbWNlX25vdGlmeV91c2VyIHRv
IG1jZV9ub3RpZnlfaXJxIikNCg0KcmVuYW1lZCBtY2Vfbm90aWZ5X3VzZXIoKSB0byBtY2Vfbm90
aWZ5X2lycSgpIHRvIGluZGljYXRlIHRoYXQgdGhpcw0KZnVuY3Rpb24gc2hvdWxkIG9ubHkgYmUg
Y2FsbGVkIGZyb20gaW50ZXJydXB0IGNvbnRleHQgYW5kIG5vdCB1c2VkIGluDQptYWNoaW5lIGNo
ZWNrIG9yIE5NSSBjb250ZXh0LiBIb3dldmVyLCB0aGUgZnVuY3Rpb24gbmFtZSBtY2Vfbm90aWZ5
X2lycSgpDQppcyBjb25mdXNpbmcgYW5kIGRvZXNuJ3QgY2xlYXJseSByZWZsZWN0IHdoYXQgaXQg
ZG9lcy4NCg0KVGhlIGNvbW1lbnRzIGFib3ZlIHRoZSBmdW5jdGlvbiBjbGVhcmx5IGluZGljYXRl
cyB3aGljaCB0eXBlcyBvZiBjb250ZXh0DQppdCBjYW4gYmUgdXNlZCBpbiwgc28gaXQgZG9lc24n
dCBuZWVkIHRoZSBzdWZmaXggJ19pcnEnIGluIHRoZSBmdW5jdGlvbg0KbmFtZS4gUmVuYW1lIGl0
IGJhY2sgdG8gbWNlX25vdGlmeV91c2VyKCkgdG8gYmV0dGVyIHJlZmxlY3QgaXRzIGZ1bmN0aW9u
DQpvZiBub3RpZnlpbmcgdGhlIHVzZXIocykgYWJvdXQgdGhlIG5ldyBtYWNoaW5lIGNoZWNrIGV2
ZW50cyBhbmQgYWRqdXN0IHRoZQ0KY29tbWVudCB0byBpbmRpY2F0ZSB0aGF0IGl0IGNhbiBhbHNv
IGJlIGNhbGxlZCBmcm9tIHByb2Nlc3MgY29udGV4dC4NCg0KU2lnbmVkLW9mZi1ieTogUWl1eHUg
Wmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQotLS0NCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9t
Y2UuaCAgICAgICB8ICAyICstDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgfCAx
MCArKysrKy0tLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW5qZWN0LmMgfCAgMiArLQ0K
IDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbWNlLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9tY2UuaA0KaW5kZXggN2EwMWJiNWIxOWQzLi5kZDllZmZkN2M4YjUgMTAwNjQ0DQotLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaA0KKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbWNl
LmgNCkBAIC0yNjQsNyArMjY0LDcgQEAgZW51bSBtY3BfZmxhZ3Mgew0KDQogdm9pZCBtYWNoaW5l
X2NoZWNrX3BvbGwoZW51bSBtY3BfZmxhZ3MgZmxhZ3MsIG1jZV9iYW5rc190ICpiKTsNCg0KLWJv
b2wgbWNlX25vdGlmeV9pcnEodm9pZCk7DQorYm9vbCBtY2Vfbm90aWZ5X3VzZXIodm9pZCk7DQoN
CiBERUNMQVJFX1BFUl9DUFUoc3RydWN0IG1jZSwgaW5qZWN0bSk7DQoNCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9j
b3JlLmMNCmluZGV4IDcyNWMxZDZmYjFlNS4uNWY0MmFiMmVhOTQ0IDEwMDY0NA0KLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21j
ZS9jb3JlLmMNCkBAIC01ODQsNyArNTg0LDcgQEAgc3RhdGljIGludCBtY2VfZWFybHlfbm90aWZp
ZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwgdW5zaWduZWQgbG9uZyB2YWwsDQoNCiAgICAg
ICAgc2V0X2JpdCgwLCAmbWNlX25lZWRfbm90aWZ5KTsNCg0KLSAgICAgICBtY2Vfbm90aWZ5X2ly
cSgpOw0KKyAgICAgICBtY2Vfbm90aWZ5X3VzZXIoKTsNCg0KICAgICAgICByZXR1cm4gTk9USUZZ
X0RPTkU7DQogfQ0KQEAgLTE3MDQsNyArMTcwNCw3IEBAIHN0YXRpYyB2b2lkIG1jZV90aW1lcl9m
bihzdHJ1Y3QgdGltZXJfbGlzdCAqdCkNCiAgICAgICAgICogQWxlcnQgdXNlcnNwYWNlIGlmIG5l
ZWRlZC4gSWYgd2UgbG9nZ2VkIGFuIE1DRSwgcmVkdWNlIHRoZSBwb2xsaW5nDQogICAgICAgICAq
IGludGVydmFsLCBvdGhlcndpc2UgaW5jcmVhc2UgdGhlIHBvbGxpbmcgaW50ZXJ2YWwuDQogICAg
ICAgICAqLw0KLSAgICAgICBpZiAobWNlX25vdGlmeV9pcnEoKSkNCisgICAgICAgaWYgKG1jZV9u
b3RpZnlfdXNlcigpKQ0KICAgICAgICAgICAgICAgIGl2ID0gbWF4KGl2IC8gMiwgKHVuc2lnbmVk
IGxvbmcpIEhaLzEwMCk7DQogICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICBpdiA9IG1pbihp
diAqIDIsIHJvdW5kX2ppZmZpZXNfcmVsYXRpdmUoY2hlY2tfaW50ZXJ2YWwgKiBIWikpOw0KQEAg
LTE3NDUsMTAgKzE3NDUsMTAgQEAgc3RhdGljIHZvaWQgbWNlX3RpbWVyX2RlbGV0ZV9hbGwodm9p
ZCkNCg0KIC8qDQogICogTm90aWZ5IHRoZSB1c2VyKHMpIGFib3V0IG5ldyBtYWNoaW5lIGNoZWNr
IGV2ZW50cy4NCi0gKiBDYW4gYmUgY2FsbGVkIGZyb20gaW50ZXJydXB0IGNvbnRleHQsIGJ1dCBu
b3QgZnJvbSBtYWNoaW5lIGNoZWNrL05NSQ0KKyAqIENhbiBiZSBjYWxsZWQgZnJvbSBwcm9jZXNz
L2ludGVycnVwdCBjb250ZXh0LCBidXQgbm90IGZyb20gbWFjaGluZSBjaGVjay9OTUkNCiAgKiBj
b250ZXh0Lg0KICAqLw0KLWJvb2wgbWNlX25vdGlmeV9pcnEodm9pZCkNCitib29sIG1jZV9ub3Rp
ZnlfdXNlcih2b2lkKQ0KIHsNCiAgICAgICAgLyogTm90IG1vcmUgdGhhbiB0d28gbWVzc2FnZXMg
ZXZlcnkgbWludXRlICovDQogICAgICAgIHN0YXRpYyBERUZJTkVfUkFURUxJTUlUX1NUQVRFKHJh
dGVsaW1pdCwgNjAqSFosIDIpOw0KQEAgLTE3NjMsNyArMTc2Myw3IEBAIGJvb2wgbWNlX25vdGlm
eV9pcnEodm9pZCkNCiAgICAgICAgfQ0KICAgICAgICByZXR1cm4gZmFsc2U7DQogfQ0KLUVYUE9S
VF9TWU1CT0xfR1BMKG1jZV9ub3RpZnlfaXJxKTsNCitFWFBPUlRfU1lNQk9MX0dQTChtY2Vfbm90
aWZ5X3VzZXIpOw0KDQogc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X21jZV9iYW5rc19pbml0KHZv
aWQpDQogew0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2luamVjdC5jIGIv
YXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW5qZWN0LmMNCmluZGV4IDQ5ZWQzNDI4Nzg1ZC4uZjVh
N2RhZTM4NWM2IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW5qZWN0LmMN
CisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2luamVjdC5jDQpAQCAtMjI5LDcgKzIyOSw3
IEBAIHN0YXRpYyBpbnQgcmFpc2VfbG9jYWwodm9pZCkNCiAgICAgICAgfSBlbHNlIGlmIChtLT5z
dGF0dXMpIHsNCiAgICAgICAgICAgICAgICBwcl9pbmZvKCJTdGFydGluZyBtYWNoaW5lIGNoZWNr
IHBvbGwgQ1BVICVkXG4iLCBjcHUpOw0KICAgICAgICAgICAgICAgIHJhaXNlX3BvbGwobSk7DQot
ICAgICAgICAgICAgICAgbWNlX25vdGlmeV9pcnEoKTsNCisgICAgICAgICAgICAgICBtY2Vfbm90
aWZ5X3VzZXIoKTsNCiAgICAgICAgICAgICAgICBwcl9pbmZvKCJNYWNoaW5lIGNoZWNrIHBvbGwg
ZG9uZSBvbiBDUFUgJWRcbiIsIGNwdSk7DQogICAgICAgIH0gZWxzZQ0KICAgICAgICAgICAgICAg
IG0tPmZpbmlzaGVkID0gMDsNCi0tDQoyLjE3LjENCg==

