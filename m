Return-Path: <linux-edac+bounces-3163-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDFA3C6B4
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D650A188047F
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E41FECAE;
	Wed, 19 Feb 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6Z39Zb+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC73192580;
	Wed, 19 Feb 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987447; cv=fail; b=tCXX5IztrMZkux3tHVr1qqtukLYiAIZylnOuCf5n8GafBjbEW437VABxInjVnreN98V3hz74vAjoEuPvphNoWyTT0CH4nde0JFS2tacbGtTswuPD5BySUL3KejjOfOv/UNSFO6s1XmVpzX7mO/4TRSQSZ2hwvRHR4haqhjGTkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987447; c=relaxed/simple;
	bh=JzhhIZuWWfy++Uo7ZgrW8b5sR6viKvShP3uHBq5TBUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PejlLbRWVXRRuKI2vqDM0pQ9ZPlnZoaQ6UiuyZa2+myyug6+u63/7AVeoeNVhE2TmxTigS6FHnddz3L/ez19IfDsPd8hWFvxwsLbGhlxxh1/lyIVxSpD5ag6yhz2MK3x9vDpELldb81OYYIKkui9mR89Q2r7V9otsZoigCLMNKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6Z39Zb+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987445; x=1771523445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzhhIZuWWfy++Uo7ZgrW8b5sR6viKvShP3uHBq5TBUo=;
  b=B6Z39Zb+L6IHjyM9x1tIfaMsXMY2UDh/HY4iuvcR8dT/yn4Q0qBqdbC9
   uMmsp46wYAe9S3EeeIpkxIkPh4PI0sGdzOLedWMdPUL+7jBp+GYEG2aE2
   ITyFsIfzKRfYPWs2RFZHNuFKB3JJ6TgLXSaVFDYk2CIRTxCsCGrYXa8Ks
   S2xjuc1RBLHpFbo8aEBbaw7rPgj84/tSMyvupGeddyiLMdPheRYin2SEW
   Rn+lYHZfHhRzxhja1vEmR+ZZD1pYFh+b0DwjlU8/Y6eFfcsLhz/I72yM2
   6pKbwDWl+68kIZmIBSdWfNGjRhkJcQY3RZPnUjFlSESuXlIXxUckuhPDi
   Q==;
X-CSE-ConnectionGUID: 67VV6BI4RrGUs/ViaWjT4Q==
X-CSE-MsgGUID: zZnZryN4SLeakDIr2lh/1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="52145037"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="52145037"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:50:44 -0800
X-CSE-ConnectionGUID: sziQv5MDQ4WtNLPRCshc/A==
X-CSE-MsgGUID: 112wwbwhTHWZOPtP/N05aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114972374"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:11:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 09:11:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 09:11:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 09:11:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xlp/yJ6ih8etjt2bAT/SmPcyDC2W0G2ZsKFwtPaBOuHlkZWkOe/WsxQ1Q0yQRY7H1q6H+blxekFrXKedJU7zGi3+MU/os1k0eDeyT+xYjtw8s+Ljpvor8LTnjSM13qdFWnEUMcCPptSgCg7xt3HBLvofnwQWrK8ueiY2an5Om3IF84FdZPd9ANuCfnjvd8RApbrsup6zdBtKwQp9d5BttYv72clKKh7fuvq/RAcBT3j8eRDfOwR2PG/4eK/z59uUcXlvJL6flSSOcpOeJ8DspS+psp2teelwMNNfDUw7JI06uS0rvUJc/ZbOtXZ/PqNp+8qOddPwfvgCGocCwt8WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzhhIZuWWfy++Uo7ZgrW8b5sR6viKvShP3uHBq5TBUo=;
 b=VO3wKSWI/5T5Qwce21yV/Z0SECV/OB6dhd7L2B+wgi0FZf7vJgx0bfjIkhLFklJlR8OSy/ImCsE5tvSuO7kwcvCfscaQ4ok7sDLp6TuWvAny4NKtNdm2dSIz2u5LNXCa4gNNNM2bWQiTAzK9HJ61UNYfcHkmJfltAHV93jixOyrujKf5yQtYw/H5FW3Xh1RYiDK6IuaEhwCcYDVlP12wqQoxXNDfVaBbfkquU6F6K45jzl+L/tZau6NT/EGzWuNvtte8emQVrQg0nFCCVWZ9/RqIMMp25b+0QLZDfsARfTjQRi7psEMyiMsUEkxSX1Z7AjHM/7lPBVITchIia67Png==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB7503.namprd11.prod.outlook.com (2603:10b6:a03:4cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.22; Wed, 19 Feb
 2025 17:11:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:11:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Topic: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Index: AQHbgQXsd1SPCL4WjEygZkFauCaLrLNMu9aAgAAzcQCAAA67gIAATn3wgAD8+ICAAJGUUA==
Date: Wed, 19 Feb 2025 17:11:00 +0000
Message-ID: <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
In-Reply-To: <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB7503:EE_
x-ms-office365-filtering-correlation-id: c2ecdec2-76bc-4be4-b0dc-08dd510861e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTI1YmVLYXpWNENLZWc4ajN2UGNNUDgwUFZLcGRaeUJLWklJeXh2cjVEbWVN?=
 =?utf-8?B?b1FLNUdtRHRETlUwYlVMYnh6dTd5MnFZdTV6SXpYalkrbFUrYVQ2dG9wNExW?=
 =?utf-8?B?UDZZd0dnUGMwVEZDdWtkRnhNQ0s1bGk0aWZzZXlXZkJrS2I4dzlUeW9uYXFO?=
 =?utf-8?B?dFJBV28rSnNqMjR6WXVBRno3OXF5bkNPUDlKOFN1L0lMd3hOSW5takJsZEc2?=
 =?utf-8?B?a2hyclVDZ0lXN3l1RjZqc0Yrd2EyRFptOVl1UEI2dXlZbTBmMVJqYkpkMmZR?=
 =?utf-8?B?b25XWkl5NUtQY09xWkEzanp4djhmek54SE9MaXd5QmtDcG8xb0RuMHkxMDAv?=
 =?utf-8?B?MWVzLytjSnRRaUNKRzNCWGh1OVh6ZTZ6TzExU0pmRkVMMEtHNGR5Zit2NXYy?=
 =?utf-8?B?Ujg4R2VJemZmdnJESzZJZnhuM1hLSmFGZzlZakVFckdIZVMrdWhvQVRNWjN1?=
 =?utf-8?B?cnMxdGJiVFNvQmtPZG8xK0pyc3k2NlpTdEgvOHZDTmhGUGtJQ3RpNng5TGZR?=
 =?utf-8?B?RTFuREZKdGl2UzA1QkN1QUVOVXdvOFRIYlBwWHM1T1YrOS8rRG13VldKSG9u?=
 =?utf-8?B?aTJYRlg1K1ZKWXh3RWN6WWo1Q2ZoTHhBUGkzWXUwZ1RORlFCRUZDZWVmY3Z1?=
 =?utf-8?B?RTN6cGJ6ck5PeDVxcjFXaXpLRmJnMWRUQnlBbm56VDZJdXNTSnk4bVkyRDlq?=
 =?utf-8?B?YVRkMXl4VDUrZk9BU1ZWelB0MElHSzlZTC95N2lWbENJbkJWSTE0bnFsOVlK?=
 =?utf-8?B?cllYSCtBUUowWDhlSWJtdXFVNzZBRW9HdXc4RnBJQmdRZ2hxOFA3THZjN2po?=
 =?utf-8?B?N3pjRklhaTNnNUlQNXRBTkljMVNsMzV4bnIrY3BBYnlyQ1pMTlpWTDJMUkl5?=
 =?utf-8?B?NkNsNXQwQW5PZktaNW1aRWVMa3dDL1BsUjNjSTBuckdnTythNlUrMVdTWDVC?=
 =?utf-8?B?VzBiVXhrQUxJNmo4MjMvRlN3VzdHNXpSSG9mRHoyaThjQk9DeEdTSVFiVUpY?=
 =?utf-8?B?K25oTUwwQlhlUHkxL0xXQVZxNTNZOXdCZ3JKS1JwZkg0QUhYN3JYSkdNT2du?=
 =?utf-8?B?MlhQRFdwSjd1SWZxWkVzU3pJa0V0c1RwN3RhamNranp2VkxzTllrSWMxSWxz?=
 =?utf-8?B?YlMyQ255d0RDeXhYTDhHUE5HbWFvaVZrZEU3bnNRWUFzbzJybjh3bDRrbzVQ?=
 =?utf-8?B?V2lNaEV3VndZbFZwd1hiem5rRDhJckZWUEs1WWhhY3lWTjRQcDZiZXc0c0wr?=
 =?utf-8?B?cmxlaGt5RTRaRU9qT3B1TUxrc2xFMHZTbWxMV1RWRy9reDg1T3RFUnIyVm43?=
 =?utf-8?B?R3pSR1pZMUpsZ3A4TC9OcHdxckRnZXZuZE1ydGw5TlBBMmZUUGNLTDFoWmFv?=
 =?utf-8?B?Qm50K0c0bWVHNUgyVmhJL01HQUR0eG80Mms2clNnTHRub2gvNW1TaFNiZ0tE?=
 =?utf-8?B?OE5hWnlyTklTTTVZK2cwYjU5Zk8zdjR2Y2FMQjdtVHJMRzkrZ2JZb29oZ0I2?=
 =?utf-8?B?WnpPSXkrbktQTVNKYTZoNEpqL2Q2bGQwYm5LWFBtTkV4Y25mbERRWDdXTmtI?=
 =?utf-8?B?all4NCtaQnc5UWs4S2M3eUhEWkRxT0lOdWozNzhGNnZ5TFIrd0pONnBsY1J0?=
 =?utf-8?B?bjlRL3RmUHB1QmZZRVY5amhzMWdBVXI4S2EyRS9ZTzJmbk82bTJjU0ltUmFB?=
 =?utf-8?B?ODVBUHlZc3hYa2dWa01DNERUZVR5VUZVanVmUmJGWTA4MmJ4Wmh6ZE9lMDhV?=
 =?utf-8?B?M1Nmb3JzaWt5NmE5enFVRTBaS3VPYTBVQlpuMFI5L1d4U2hGTTc1ZFVTQytq?=
 =?utf-8?B?TncvTDdXWmxKbEsrVkt5ZW5XWUo2UGE3bGpqL3dpWDMyR0hVMForUFJrTVpS?=
 =?utf-8?B?aitPWjl4VUU5RWZab01kUFZ1ZXN3Y2hkWEZEMnAvNGdKZEVqaVY1cU1QV2hK?=
 =?utf-8?Q?a3T11evGk1csJHFV/2ZclgcKt+mlj5LE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVkxM2RDT3dCSm16MFZIZWYxQWV3aWVXZzAxN0VGUDQzQ0xiWGdRYUN3MmRp?=
 =?utf-8?B?YmFoQldURkhrN2NFQVhmR3hvWmFRdFRwZU9sTHBZVHNUN0xkN1hUYmNLeDhE?=
 =?utf-8?B?NVRKTXI0eEplWlBmMzMrTTlua1RORUpuNkdXd2laMUh5MmN6NnZoWmtobzcv?=
 =?utf-8?B?c1huQTYwQWhnVHMvR0tuWFhDVHRsL3NhWWV4d1B1RUV2ZWZKTFBnbmVDZEc5?=
 =?utf-8?B?ZzYzMGN5L0Qvb2dERkpRRk4xalFodVd0STFzdEFSc3BsdVUzVSswa3JmUTAv?=
 =?utf-8?B?RGNkQUIwOUVBdm5jTUdNR3gwMTZ1ZWxwb1pLcjZPZmIvdXVXd0Y2SG54R3Nr?=
 =?utf-8?B?VngrLzB5R0xaYzNKSzVHZVl4VzNIQzlDbytzelgrYnZ4MDRXeDcxMkwxWW5D?=
 =?utf-8?B?VVhwbEtwQmIxdlhaT0VhbXU5cGxnbXI1V0IzbWtZM1ZCNS9RbWkvc2hESFFD?=
 =?utf-8?B?V2s0OU0yNFFOU3RKQ3g1T2Q3aHZSK1Fvd0o1Mk1TWUhydEVFbVRpMXZ0VGFs?=
 =?utf-8?B?L1ZSeGY2dXY4empEdVBvZjVrRkhSWmxjdnRFbkZLQy9lR3FJM3I2MU5Zd2pP?=
 =?utf-8?B?cWxLdDBac3M1ZVVZUE9xakFiU3NjQllyMEdGTTAwdEp1TXpTL1N3RmU2YXpw?=
 =?utf-8?B?eE0ydkdCMmI1WTNOK0cyTjdjV3JJQTZnMWQvKzgxbi93QW1ZQ0JlM0lmMU0x?=
 =?utf-8?B?YTFSS2VnS0FCcFdtaWx5ZGFRY3ArOVd1MXNuVUp5OFJQYnNqUEFQd09kc01U?=
 =?utf-8?B?S1h3MWpsd0tiT1EzbjJiWEdjaW16Q3pWNHo3TDFLZ1JlYkEyRjhjUUZjbkNO?=
 =?utf-8?B?R0t2TG5mOFhzZllod0xER21hODJHcTN5SndWam12dS9tNTd1KzlURUt3Tktj?=
 =?utf-8?B?bFBOYzhXd3AreTBncTVQQTZ1QlJIWVFudkpISmRmbnoyYk1Ga3BuRnB6VFpH?=
 =?utf-8?B?VXJ2c2FFTndCMm5GZHVQMFlNTWkvOEkyV041a3dXZ0JQaGo4NnlZenR6WGhz?=
 =?utf-8?B?eE1payt1UjhiTFFEK0h4UzZqa0paLzRyNzU5ejVQSDRsQkFyWXBRV2xIWDB3?=
 =?utf-8?B?MDNwL1BjVlQwODh5bmNVZmI2RHJ3bGJtVGZYMWtYQjgyVklhY0RjWmFqSjRS?=
 =?utf-8?B?SE0xTEQ0NGNGMGNxOFpuM0VJV3kzbGloTzljKzZ5Zy8wb0tnb1ZkY2pwdHNt?=
 =?utf-8?B?OUoxZ2RTZTNPeld6bnZFakUzOTBhdElTckdaOEJaalprTmZjQ21oZWNFUTkz?=
 =?utf-8?B?WW50MUpjTGJHYzdUcVdlZ1ZQZDNtalRmUmdHL2ZMWVlYMlA5NDNodUl5dkdF?=
 =?utf-8?B?dEtuL3hqNW0vc0QrOWVObFpBei9ZV0QwV1pycTdRVnBwejhtZ2kyNllGUTJ3?=
 =?utf-8?B?MkdQUDlRNmZEUjgxbkRNS2FacVo4c1owZHYyVHhYNmpjYko1OTdXcFE5TUh0?=
 =?utf-8?B?aDBlcC9kMFlFV25PcXVhR2F4cndQRWF3UUttQ1pkYzVHOGtRRXI5MWpTU2Z5?=
 =?utf-8?B?NUpqdFlXVmkxUWYvUGtqQ2JmeDZFYlpGc25GSkhhUEhxbEFvcHNyQXF6K2tR?=
 =?utf-8?B?WnVVbGUvQUFUS0xCNVo1NzFlRFFZUXRVVVRXUkZzR2psRnhBR3JHWHprZDNm?=
 =?utf-8?B?VVAyNzhsYWREK3BJcUgxc1QyTklmVDY2eWwxalhZZm14aFJ1TlRKYWtjcXBM?=
 =?utf-8?B?RTZCQUVUcDVhVXNheFByOUpEbWIwMldCcnVsOENZNDFjK0dDYW1Fckp5c04y?=
 =?utf-8?B?MzB4eDlaQjhhTmE2VjFlOEJ6bStNQmtHQ0VGUzd5OGV2Zy9LZ25sV0JiSVhN?=
 =?utf-8?B?bnJWYlNvMGxGKzNlQ3k1aUNBa0lqa21sa2xJMTZHN2ttTGxWYmpJR1NiOElD?=
 =?utf-8?B?dWo1OW1LMGhiZHRHTVAxNGpoWG1BUDkxVjRxSjNlV2JsNG52YkdJQXhGOFR1?=
 =?utf-8?B?UUt5bUN4eUZTNXJqTmNsQkZWT3ZmRmVqM0t3M01SQzQ3NXY3SHlBZjlqYnVL?=
 =?utf-8?B?di8wekNwVWxYM3ZRTU1kdXpEd2dJajMrSmpVcVdMbmRFRXpmVU9RMEFEUFFV?=
 =?utf-8?B?QlhGOW85WUt2a1ovMHdyRFFJald1d3JjUjlhNTNGcjVnZkFQdnAzRjRoMUVj?=
 =?utf-8?Q?zN7AV77i6CWtOs4wWbhRvQp2W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ecdec2-76bc-4be4-b0dc-08dd510861e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 17:11:00.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJ67RTiuBAFupHy6OmxQ9sWDGNkeq6G2cVD723kfUuYEysd1N6r3gfa64JuQduyC0+fbIB8GWnqxbl8RTQ0xuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7503
X-OriginatorOrg: intel.com

PiBGaXJzdCBvZiBhbGwsIHRoYW5rcyBmb3IgZXhwbGFpbmluZyAtIHRoYXQgaGVscHMgYSBsb3Qh
DQo+DQo+ID4gVGhhdCdzIGhvdyB3ZSBlbmRlZCB1cCB3aXRoICpVTipjb3JyZWN0ZWQgZXJyb3Jz
IHRpZWQgdG8gKkMqTUNJLg0KPiA+DQo+ID4gSnVzdCB0byBhZGQgdG8gdGhlIGNvbmZ1c2lvbiwg
TGludXggZG9lcyB0YWtlIGFuIGFjdGlvbiAoaW4gdWNfZGVjb2RlX25vdGlmaWVyKCkpDQo+ID4g
dG8gdHJ5IHRvIG9mZmxpbmUgdGhlIHBhZ2UgZGVzcGl0ZSB0aGUgVUMqTkEqIHNpZ25hdHVyZSBu
YW1lLg0KPg0KPiBTbywgQUZBSVUsIGh3IGZvbGtzIGFyZSBiYXNpY2FsbHkgdHJ5aW5nIHRvIHRl
bGwgdXM6IHdlbGwsIHRoaXMgaXMNCj4gKnRlY2huaWNhbGx5KiBhbiB1bmNvcnJlY3RhYmxlIGVy
cm9yIGJ1dCBtZWgsIG5vdCByZWFsbHkgaW1wb3J0YW50LiBXZSBqdXN0DQo+IG1ldCBpdCB3aGls
ZSBmZXRjaGluZyBzb21lIGRhdGEgd2hpbGUgc2NydWJiaW5nIHNvIHdobyBrbm93cyB3aGV0aGVy
IHlvdSdsbA0KPiBjb25zdW1lIGl0IG9yIG5vdC4gTWVoLi4uDQo+DQo+IFNvIHdoeSBkb24ndCB3
ZSBzaW1wbHkgZG8gdGhhdD8NCg0KV2UgY291bGQsIGJ1dCBJIGRvbid0IGxpa2UgaXQgbXVjaC4g
QnkgdGFraW5nIHRoZSBwYWdlIG9mZmxpbmUgZnJvbSB0aGUgcmVsYXRpdmVseQ0Ka2luZCBlbnZp
cm9ubWVudCBvZiBhIHJlZ3VsYXIgaW50ZXJydXB0LCB3ZSBvZnRlbiBhdm9pZCB0YWtpbmcgYSBt
YWNoaW5lIGNoZWNrDQood2hpY2ggaXMgYW4gdW5mcmllbmRseSBlbnZpcm9ubWVudCBmb3Igc29m
dHdhcmUpLg0KDQo+IFdlIHJlcG9ydCB0aGUgc2lnbmF0dXJlIGJ1dCB3ZSBkbyBub3QgdHJ5IHRv
IG9mZmxpbmUgYW55dGhpbmcuIFdoZW4gd2UgZ2V0IHRvDQo+ICphY3R1YWxseSogY29uc3VtZSBp
dCBub24tc3BlY3VsYXRpdmVseSwgKnRoZW4qIHdlIHJ1biBtZW1vcnkgZmFpbHVyZSBhbmQgdGhl
bg0KPiB3ZSBvZmZsaW5lIHRoZSBwYWdlLg0KPg0KPiBIbW1tPw0KPg0KPiBXb3VsZCB0aGF0IHNv
bHZlIHRoYXQgcGFydGljdWxhciBkZWJhY2xlPw0KDQpQZXJoYXBzLiBJdCByZW1vdmVzIHRoZSBy
YWNlLiBCdXQgYXQgdGhlIGNvc3Qgb2YgYWx3YXlzIHRha2luZyBhIG1hY2hpbmUNCmNoZWNrIGlu
c3RlYWQgb2YgZnJlcXVlbnRseSBhdm9pZGluZyBpdCB3aXRoIHRoZSB1Y19kZWNvZGVfbm90aWZp
ZXIoKSBvZmZsaW5lLg0KDQpNb2Rlcm4gSW50ZWwgWGVvbnMgKD49IFNreUxha2UpIHN1cHBvcnQg
bG9jYWwgbWFjaGluZSBjaGVja1sxXS4gRXZlbg0KbmV3ZXIgWGVvbnMgcmVwb3J0ICNNQyBhcyBy
ZWNvdmVyYWJsZSBmcm9tIHByZXR0eSBtdWNoIGFsbCB1c2VyIG1vZGUNCnBvaXNvbiBjb25zdW1w
dGlvbi4gU28gbWFjaGluZSBjaGVjayBpc24ndCBhcyBwYWluZnVsIG9uIG1vZGVybiBzeXN0ZW1z
DQphcyBpdCB1c2VkIHRvIGJlLg0KDQpXZSBjb3VsZCBtYWtlIHRoZSBhY3Rpb24gaW4gdWNfZGVj
b2RlX25vdGlmaWVyKCkgY29uZmlndXJhYmxlLiBEZWZhdWx0PW9mZg0KYnV0IHdpdGggYSBjb21t
YW5kIGxpbmUgb3B0aW9uIHRvIGVuYWJsZSBmb3Igc3lzdGVtcyB0aGF0IGFyZSBzdHVjayB3aXRo
DQpicm9hZGNhc3QgbWFjaGluZSBjaGVja3MuDQoNCk9uIEludGVsIHRoYXQgd291bGQgbWVhbiBu
b3QgcmVnaXN0ZXJpbmcgdGhlIG5vdGlmaWVyIGF0IGFsbC4gV2hhdCBhYm91dCBBTUQ/DQpEbyB5
b3UgaGF2ZSBzaW1pbGFyIHJhY2VzIGZvciBNQ0VfREVGRVJSRURfU0VWRVJJVFkgZXJyb3JzPw0K
DQotVG9ueQ0KDQpbMV0gU29tZSBPRU1zIHN0aWxsIGRvIG5vdCBlbmFibGUgTE1DRSBpbiB0aGVp
ciBCSU9TLg0K

