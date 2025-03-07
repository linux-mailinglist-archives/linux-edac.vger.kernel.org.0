Return-Path: <linux-edac+bounces-3313-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E314A575CF
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 00:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808CD189A7B2
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71377258CEA;
	Fri,  7 Mar 2025 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOeSeezs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A24208989;
	Fri,  7 Mar 2025 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389092; cv=fail; b=YzJK2wUuYQEha49k8iVR0eNOMpBEk/YXtMnBT2IIRcQg4SefKyh0ONjEa6QdPvz9schUvMkH9QYhHksT83Hlw0JQDq0BmljHFfjta/RMZML6PxxbwtkTe/iWYYl/gZQqcrl3dhMNipvI6DxbZLwvjfiS3FMa6oNNqMeCG7a1BGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389092; c=relaxed/simple;
	bh=EzDByBjPs0pkWvjHgqPmpyuqjtlCsPJo6dIHb2l6t1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzIuYnO5Sa7OHksALDiPuYJsD78++5b8xS4fbCdj/KfgIRGBjz9LeAe7mlFl9nYr4olryFDbvWn/+ogzg5e1nIW7ORsw9P/muWdbjjM07W2DvoPEkLRH8pPFErWUnZasbCmRXmJs7OhFrA0BfFiKCiwTx1up3vRaDEaLX15Wh40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOeSeezs; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741389090; x=1772925090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EzDByBjPs0pkWvjHgqPmpyuqjtlCsPJo6dIHb2l6t1c=;
  b=aOeSeezsnGL6h8zj/LPSFpLqJQvylHp4VtcD/s3w4H11NCPk3dLkn8Yq
   eWsya2xF66liLQVADiYpRZmlu3+F5cjjLyEHn+vsXVB9czjTXK4DMmz9k
   v3qaoVYn/vyzfR8Jebxx5NPr4oXUSxTCkaTEB8pM2WOriztgYT/mHC3x7
   PXQu1MtHBHkceXb+p2fRhZD86Et6/uMxd6wgUYQKmgs/3yVoTr1rf+uVB
   V8gctg/gV9N1tCb4fc2pz0MgsLPffrQZeWHYlfV72xsGyfwiM9TJAq+AV
   NaaBcSFX+rTVHE8v1+zHvSQAb4SuaHZ1XbSVnJVr0OoMAQK47eLlJsgST
   Q==;
X-CSE-ConnectionGUID: rJglJAsUTjC5BXA5PCn7Gw==
X-CSE-MsgGUID: AyfdTGWPT6O4vJBOS0hEQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="41614815"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="41614815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:11:30 -0800
X-CSE-ConnectionGUID: EI1vMkrDRz+gVZbdBWgggw==
X-CSE-MsgGUID: ryOUwL1cT/CiWk6glYvLUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119939253"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 15:11:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 15:11:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 15:11:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 15:11:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNAuL7o8vTYSO1RUO5niOeRWln4c/w9ukZr4S9G+aKDnDKEjRGFGR4uEHc9awlal8owp4zNw2w1gzeeS8OFFNW0EpkZZ7JodHJ/USJH5SBg9a6B2GirLr4PZaktUWNRybi7QNK1oID2qAeExvHXiZtEKNyZpayDUoQwbi/jsUlq2ibDoIs8qn/1evTMdOtVr6KUjq7QeiA4IgVN26pboBndC3s0EY4MC+V2SwjF/K4V2B3XNEUUIBJ36wVqpVO8MT8yV8CRmCIbgvcoMbYDd8d9uHLPTuCGfK6CpY5YLJTz/muUxNwPlGLXJDG5xSw/TOT/wNNHmqPq+41GF224OAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzDByBjPs0pkWvjHgqPmpyuqjtlCsPJo6dIHb2l6t1c=;
 b=fXhPW8k4HU0Ud/JljShhBftZJNzODiV/5bfeH1iKXEl4CMUMxrv6qWMIoNZ0/htOWocaqUdFqnZHitfwILR7szSzqb1r+OBWV4KPkrUYA35zFLw7O+GhgtcZP8XQIzXA81NWmJ8st3fhbekR+8paZHABMy6cFdeZR6qJIwpaR+buLeuBgX0xD7/+c5dzNnEzuKoHmGhJB8SLkRTEBgT4mqprFOasr90SrxAKSmxiOxBBNKZ8MEJhzwoHP8AAExlocgyEfliwyhIGnx1wdbFdpfp1udukm06hTt9JsIWtQh6anBJqAVHECQDQ4F/Ud3S2MSJtMeZBGp6akxCgd2KE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Fri, 7 Mar
 2025 23:11:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 23:11:26 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Thread-Topic: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Thread-Index: AQHbjyP+jS5lVBxqwkSk4GQtSSn/LLNoI/4AgAAVztCAAA2GgIAABPnQ
Date: Fri, 7 Mar 2025 23:11:26 +0000
Message-ID: <SJ1PR11MB6083223A3175F7A84EC4DDDFFCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
 <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
 <SJ1PR11MB6083654405F2721E5AA0C1F2FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250307224645.GKZ8t3VX5a5FhqNyZG@fat_crate.local>
In-Reply-To: <20250307224645.GKZ8t3VX5a5FhqNyZG@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4991:EE_
x-ms-office365-filtering-correlation-id: aa3263b4-fabe-427b-de8f-08dd5dcd62c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmFIcVFUOUxCc3JvbzE1TTlkM3M0UGU5SktldmZoYS95SngwVGMzejFNQ0JU?=
 =?utf-8?B?STVyeFFESEZxeWtKNjlBRFJVeU80Z0ZwMWdoVUtjVlZTT2tIVU1hZnZIYzdN?=
 =?utf-8?B?c1lsakFiTTFwb0l6UzZZQnFDM1lUSUMzcVRnbjhnWjlsb1FMUk84TlhOVVFi?=
 =?utf-8?B?RU5zNlFuaDJraVlDdVJTREZDbGdlb01SK1c4OGxKc0w2aUEvUXZ0STlpOGVR?=
 =?utf-8?B?WHdreU92cCtUT2lWTWdIMTBiOW1tbkh4bGFONFQ2dFd0bWQxVmZDZHdSSm1C?=
 =?utf-8?B?Q3BaWEducjBhWXVmUTNLV3QydzdYQlE3K0JKTFFEV1VtNG50YjF5TjRUcEVK?=
 =?utf-8?B?ZVNNK0tpMzlvdmdnOXhQYXdRbkgrUFBBL3pFVWV5aFZyVlR0UElVYU9LYXZV?=
 =?utf-8?B?U05aMUlvbE5wMmNoTkpmTWdkNkdPMnRXam5BcnA5M1o5K240RHhkZzdJYjE0?=
 =?utf-8?B?b2NaVDlHZ1Y1Q3BoQjRtRGd4QmoraGlFT1lyLzJiMEZoOFh1NWxzMy84aHQ2?=
 =?utf-8?B?dEtRWmpzbFVmWjcvVzYwU2NTZ3RwWFIzeUQvc01MV2Z4eDBuK0k4NVdBU2w5?=
 =?utf-8?B?WUw0R1U3UFVkNDA3Mzh0dTdNUVN1TFVJQ0JtSmlvNTZmMFZaS3lRbkhTMjhE?=
 =?utf-8?B?OWsrTWl0SzlEZnR5bUwvYTdKZTF0cmdCekRvbGlRRFlCV2drVVprUnJDOHVL?=
 =?utf-8?B?R0NXQ2wyVG4zVFFaQ0ZWbDlZRnR3WnNobDV6RFlIZXJxQi9EQUJ6WWorVENM?=
 =?utf-8?B?T2JvcEFWelg0R2tzdVZJZ250NlZoaVVZOEJkU0krSFBIbi9UN1JLc1R5L3ZX?=
 =?utf-8?B?Y3NDOVRSQ3hJYWNhUWpQbTJzemlqT0VGNTVRMWpGN2ZmS2UramVIUXhHTGtT?=
 =?utf-8?B?WWQrTllxbUwwMHpsRGNOVXJsbzNNcCt4SkFOcVFEOE1PVldqQmtFdDNaamVi?=
 =?utf-8?B?K1c0QTVjRmFoOC9aZzk1bWsxZ1BXb09iQXhmbXRybGdGV25seE52TTZzNnZj?=
 =?utf-8?B?ejl0TEJTbVBPWFdkcGdWemw5VERiNm8wZnRvOVpjUzVGcmdHSStqUTZpWGc0?=
 =?utf-8?B?NnVsQ2hWaE5FOUZvbGlaKzdLU3FFb3ltSnhycDhvYWJlc3E1TmRCS0p5Y24x?=
 =?utf-8?B?ZU43QitvZEMxbW1qclZDYzRDOFpNVXVEMHlnbVpjN2NtVjBScmtpK1VmODUz?=
 =?utf-8?B?R3JSK2hWa2NNOEFEblAwdHlpbFFDMldLSlpNbHZGWitLZ3hieHM2SVdtUW9p?=
 =?utf-8?B?ejF0bGU0MnNnWDBoUTF1M3g5OU9MK1Y5VGFhVE9JcXZnWjV6Q3ZOakJGbVNi?=
 =?utf-8?B?VURpZ2FSYjR6TkxJNVpmOVRmU2Z5empabnVvVk4ycXdLdXpDZlZMaFBhaWZC?=
 =?utf-8?B?NHVxMU5pMFcrK2dHSDF3NEJ0V1BnaVM2MUNSL0N1bnpTVW1HYzRtVHNVVUZG?=
 =?utf-8?B?MDlGNzBwR09WNEdhcmJBN2J4K0RvUHgrS2R3QjFJUmxMNC9RaFh1ZmNOU1JP?=
 =?utf-8?B?ZzEwdEYzczNTVnNYOExQVFozQmUxdWVZMGRUTUl5aHY0R0kzWDRqeWd3UU0x?=
 =?utf-8?B?RzZrWXpqSVF0ZmRmUWI5MEhsNDZCTmxVS3dGWUU4bkVEbnIwM3IxK2xQN2Rn?=
 =?utf-8?B?ckRtVG1BMzM3UTQvL1pxTEs2a1o5N2RXTnlMNEY5L2lNNXRCOTlQTjRiTEds?=
 =?utf-8?B?SU1JWk9nenBaVEU4M0V1YTdkdkhNUDBqejAzRTZnWUEvdEcyeXJrMStVbzcz?=
 =?utf-8?B?Wk1iZlpnUHpVT3E0UWw3MEE2MDAvRk1lQkRKKzRwbGphMm92c0NrQnVyeEtv?=
 =?utf-8?B?azZSSVJZOGduUHlsSEFwakVwcm10bE9GY2RXNFlsQkY4TDh6S2pCOElSaVo3?=
 =?utf-8?B?SXZpbExZZ0tDNExuZUxDN0xZNC9WUnhvd1JRMUFJZUU1bk9ZM3dybXpkNW9P?=
 =?utf-8?Q?hvLduZhvZqEeNW8ecqhnC5hTX0Tdd4QD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGo5SUlRUnR2cDdIdjdNRUlFdXhlZHhVNkhzbWpzQzU5TjVyakMvcXkxL0lI?=
 =?utf-8?B?ZHBlRE5oM3Qwei8rMnpJVGhyay9sVFJpR0pkZWJGYkJEVUhlLzhMRE5QTXJG?=
 =?utf-8?B?Vm12Y3lleHAyaEJKejUzL1JlTHREV2YrdWovUThLbkdoNk1LYlBGWWtJTFdi?=
 =?utf-8?B?NGxaWkdZQUZzK0RDNForcTVsdGZwVk9wYlJZZlRzbGhDTlJqNWJ5TGlVMkRa?=
 =?utf-8?B?UmJTTVBCYzI2Rld4ZWs5SDN0TjRwVGQ4UWVYSUFHWkN6bTRFdUgyWC9paHlw?=
 =?utf-8?B?ZkpyK1h2VDlNTkJaNXBWekpabFlXZE1tdTgxU0NSN0JrWTM2OWk5bWxQMUor?=
 =?utf-8?B?bFBQczBub0NhU2dVS3ZQNFFlWS9OUjU0WGpOZUZ6anBGVE51LzgzOG5RWWM5?=
 =?utf-8?B?ZGt6RDc3aXlwL2pKUlVEZ09KSnpaK3NhSmpLR0Y0bFAzVTR1UkIrQjEzaTcw?=
 =?utf-8?B?STZkRmp1Rll3YnRIeGpmNlNFQlBJSkhMUmxlcCtkOENXNjBwY0gyN1dseGFK?=
 =?utf-8?B?U1pOUEhKRWpPLzRJRVBHUnJCd0hESVRSdWgyR3dVSEFRRVFTU2FWaktHUmo4?=
 =?utf-8?B?MjJQOTFwNVduczdMSnNRbWpuNGt4dWNiQTgvQlFKQ1VTdHUwY2JMWkl5RVdB?=
 =?utf-8?B?bmIrYzJWN0hTVCs5d0xCcVB2WXJHTmtwdTlUZHd4Vjl1ZXJxK3pvUGxDTXNn?=
 =?utf-8?B?VXUzdDMxWGFGbVhGc20yYmdydldzZmpDdkNjQU9DNnFFTnE3N0dBbHVVbDlz?=
 =?utf-8?B?Z1VmUzN0RDZIV0gyNkFDOHlvNnFER1NUd0JoblRVWER3VUpJM0FDdmxWcGJu?=
 =?utf-8?B?NlJsTHpuT24vZW5JTjRxdUM1cUVpd0FBQWlJNU1iK0MzOXV6WnFRZ1czOWhT?=
 =?utf-8?B?Z1RER3VWMnRibDBZN29NNS9jWU14MzBUVW1Uejd4cElZM1RCVGxVTXJOMDFX?=
 =?utf-8?B?MXpPSStFVjV6ZUtvYXFrV01ZZWRKRXhteTdtVWdOMlpuTGRaZ1p5V1F2N3NI?=
 =?utf-8?B?MC9HZ3p5WDcya1dMVEhvaDhMeEEwZzFwYnZmM1dZN09uZiszN1JhYlhjMW5J?=
 =?utf-8?B?bG9Ud3lveWV3QUVIbm45dWFzYVNJcUlSeUlpMWFVdEljZWlaekFpZW8vd3lp?=
 =?utf-8?B?dFpaRFhoMXFmZHV2dDl4ODVMZzBYL28rOWN6d2M3SmU5Mk1JeXIwb2NpQWlI?=
 =?utf-8?B?VGVyREMvYWtDeHFOcGt0dzJmZFNLRWR3QzNYaXV5b01UTEVyOHoxWFg0TnZp?=
 =?utf-8?B?c1ZXZ0ZZU2FZSXVMRmR4OGVIaEtCZ0gyMUw2NldYM3FJYy9JVWkzSWFscnA4?=
 =?utf-8?B?TkFFWTZyR1VXUXFPYkwxY0UwTTdRYTFka0RwVno4NHN5Z0RtS0wvakszZ0Zl?=
 =?utf-8?B?SXdGVlMvQ2xQNzNDRXowbDZDbkNNWWpNZmsrTDMyVHVDYWRkdWtURHpHdXhp?=
 =?utf-8?B?eStpZVNvZjdibjgwRXVOV3B0dTN5eDlVU3V3WkVlTC9qc0gwYmU3V0U1Z2Yx?=
 =?utf-8?B?YUkrNFFOSVRjVmhsT1NpajNiVGFqT05xSlRWRSs5SW91V1Y1QXNFRHA1WVRT?=
 =?utf-8?B?UjBDdEVuOC9uNW5Lb0tUQld0cldrcDZaNDExcmJnQ3c0ZjFUU21ZSkFHdmc5?=
 =?utf-8?B?bzF4VHgzTS96SzJ2T2NocnVFMVJwQjM4Y3pFOUhBMXV6U1RTbkJWRUtFWmpl?=
 =?utf-8?B?NHVzWFFaVC96TWxVUkhoQzUvMFJUYXFBNHlQSE0wL1UxQklsSlovaGZRaFAx?=
 =?utf-8?B?QzdkVDlabFVqd0NXdUg3K2J2eFhuS3U5UWlkWjFnNlh5cXBCcXVMSjVXWGht?=
 =?utf-8?B?UjIvTUMwSGwxNFlENjNzVFBUdVg0WTgzTHg3MWhmeHI3aUh2em5wdkFHYXVp?=
 =?utf-8?B?TjdoZk53VWpvVEp2SElEUFBkd1V3NHh2QzNiK3pYem1HODliMk9kTk4zOXVo?=
 =?utf-8?B?emFnMTVnNTl5ZTlkazg0aFhCN1ErTzJEeHcyNEN4MlVBSkxxWlpZcXlveStG?=
 =?utf-8?B?WGU4MlovdHFsTFZxNXNtS0FiaWhZVFY3UHJFM253dW9kWUN0bmFYblhlc0lN?=
 =?utf-8?B?eG1XeW9wZkxrYzZOZmJBVTZGRUh2bDE1a1JZRStoL1JGR0JuSlI5M0w5MmpC?=
 =?utf-8?Q?WjzlWGzWKW7lfiDMVj739Buoo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3263b4-fabe-427b-de8f-08dd5dcd62c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 23:11:26.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HOxxBaPPYMYDah9xhCy3KjYcAIGKioHmgIYzVajNopzbtrwylxiuAN95YrW+HfqacxO1aBfnJee0NIaY74aPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com

PiA+IGlzX2NvcHlfZnJvbV91c2VyKCkgZGVjb2RlcyB0aGUgaW5zdHJ1Y3Rpb24gdGhhdCB0b29r
IHRoZSB0cmFwLiBJdCBsb29rcyBmb3INCj4gPiBNT1YsIE1PVlogYW5kIE1PVlMgaW5zdHJ1Y3Rp
b25zIHRvIGZpbmQgdGhlIHNvdXJjZSBhZGRyZXNzLCBhbmQgdGhlbg0KPiA+IGNoZWNrcyB3aGV0
aGVyIHRoYXQncyB1c2VyICg8IFRBU0tfU0laRV9NQVgpIG9yIGtlcm5lbC4NCj4NCj4gWW91IG1l
YW4gdGhlcmUncyBhYnNvbHV0ZWx5IG5vdGhpbmcgZWxzZSBsaWtlLCBzYXksIHNvbWUgZXBiZiBv
ciBzb21lIG90aGVyDQo+IGhhY2tlcnkgd2UgdGVuZCB0byBkbyBpbiB0aGUga2VybmVsIChvciB3
ZSB3aWxsIGRvIGluIHRoZSBmdXR1cmUpIHdoaWNoIHdvbid0DQo+IGNyZWF0ZSB0aGUgZXhhY3Qg
c2FtZSB0d28gY29uZGl0aW9uczoNCj4NCj4gLSBvbmUgb2YgdGhlIHRocmVlIGluc25zDQo+IC0g
dXNlciBtZW0gcmVhZA0KPg0KPiBhbmQgaXQgd291bGQgY2F1c2UgYSByZWNvdmVyeSBhY3Rpb24u
DQo+DQo+IFBlcmhhcHMgaXQgc3RpbGwgbWlnaHQgYmUgdGhlIHByb3BlciB0aGluZyB0byBkbyBl
dmVuIHRoZW4gYnV0IGl0IGRvZXMgc291bmQNCj4gZmlzaHkgYW5kIHVuY2xlYW4gdG8gbWUuDQo+
DQo+IE5vdGhpbmcgYmVhdHMgdGhlIGV4cGxpY2l0IG1hcmt1cCB3ZSBoYWQgdW50aWwgcmVjZW50
bHkuLi4NCg0KRXZlcnkgInVzZXIgbWVtIHJlYWQiIG5lZWRzIHRvIGhhdmUgYW4gZXh0YWJsZVtd
IHJlY292ZXJ5IGVudHJ5DQphdHRhY2hlZCB0byB0aGUgSVAgb2YgdGhlIGluc3RydWN0aW9uICAo
dG8gaGFuZGxlIHRoZSBtdWNoIG1vcmUgY29tbW9uDQojUEYgZm9yIHBhZ2Utbm90LXByZXNlbnQp
LiBBbGwgdGhvc2UgcGxhY2VzIGFscmVhZHkgaGF2ZSB0byBkZWFsIHdpdGgNCnRoZSBwb3NzaWJp
bGl0eSB0aGF0IHRoZSAjUEYgY2FuJ3QgYmUgcmVjb3ZlcmVkLiBUaGUgI01DIGhhbmRsaW5nIGlz
DQpyZWFsbHkganVzdCBhIHNtYWxsIGV4dGVuc2lvbi4NCg0KQXMgZm9yICJleHBsaWNpdCBtYXJr
dXAiIEkgZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGRlY29yYXRlDQpldmVyeSBn
ZXRfdXNlcigpIGFuZCBjb3B5X2Zyb21fdXNlcigpIHdpdGggc29tZSAidGhpcyBvbmUgY2FuDQpy
ZWNvdmVyIGZyb20gI01DIiANCg0KTm90ZSBhbHNvIHRoYXQgIndoYXQgd2UgaGFkIHJlY2VudGx5
IiB3YXMgZnJhZ2lsZSwgYnJva2UsIGFuZCByZXN1bHRlZA0KaW4gdGhpcyByZWdyZXNzaW9uLg0K
DQotVG9ueQ0K

