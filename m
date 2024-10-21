Return-Path: <linux-edac+bounces-2167-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921669A7164
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92CDB20DC5
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A511F473C;
	Mon, 21 Oct 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKzfa1qz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472781E572A;
	Mon, 21 Oct 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533098; cv=fail; b=q6JBt0Vu06eyW/O1YBhJ4rdDbTIjnnuftAjIF//JFvXc7TyKZzCnzrTXnRSs0N0g5sF7/64ijdDcTNgsQUYXzCNs2FdPYhJkhupuxVR0RTu6o0whLPWJvXn93IGQKGZrsFZxfl2E6nFL26IA3u7grHCP3rSd/BQiCFix8kVRFjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533098; c=relaxed/simple;
	bh=tAzI/yqnY8epicYAR9z1lLlI1YdkN2DDfnHYHMSdx08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEhk8ofHKEFRLwizXkaO060kyQIqv6EkfTTNFy/A0z8gUwc7RTQskhXJP0HIgddQIUXCT0JiS5zZz7igg+lq2a1MYqLP3AcASB0CpnTC/PQVhYBNYSKC0JcOWhea47IPCzKtQty433HkT5tpUbW6r/Ip6NOTcN9KxUNByJaxjAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKzfa1qz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729533096; x=1761069096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tAzI/yqnY8epicYAR9z1lLlI1YdkN2DDfnHYHMSdx08=;
  b=TKzfa1qzhA1H5ZljqZfOrBlMnTNGTS2LwXsif3yva81IsZ+5jSI2lAmd
   YFb/zc+pQM7sfXW1IcvdxL7HTXkO6ooAPQdsMwSVlk9648jhtOqr6QluM
   gzUB5OUJ+zNwiQb5bqwmzGvGh2R4OsjaUuQrR9QnWcHL8GNrUzxfhigQm
   WuCzpIFT4LEPasCbMfVVOoN9HMlFckpewL8KjpF7Hje+8t7QmOP2JSGEJ
   Xqi4ujjsHvITcmFYBoGtUIySGixrQ69B6aqNBi6Mu+pnb0sv7I+PzDIVW
   yVpxbjwHC2LWMd0hHiw4sg89NSILaCeqlhbZvcESxJjwOT+dxqzGSN8wm
   g==;
X-CSE-ConnectionGUID: fimyM3/HT5CiGJvWQ0jGyw==
X-CSE-MsgGUID: AqQI14s+SrGgtVD8ftQTRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39571777"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39571777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:51:32 -0700
X-CSE-ConnectionGUID: uZq4J8pwTRq8w2UH0NmzCA==
X-CSE-MsgGUID: Sw7Dd1+SQGKRGLDs8JAIHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79231148"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 10:51:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:51:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 10:51:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 10:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtS9TijXyI4JcrvVRNHxty9ve/V1pEvtg8UC+ESfBRACHl2ZklJewVTKd4HZG3BaSQQ2CclD0Z1vVVg19mN6erBktDel7jmEw7627WexDUQGcB6S2TLittU6jJ488EPn3KGamG2M1Sls3eHUmvJlNvQElSGVqYrd4zyEnYFzXm3I/nKLpIlPk5niYPa4bVZE/iPDpFR6N6UhueZqDQToew4z9uqt+EsBBDFVza+NOpjjPWf8u7ucsti3HoktRH84zTpakTvBmsHexP0KZbRCmIGKFcKRdEp+oC7c6G+otb+yedKn24Ba3wDbCAO5vL75j69pfCowjNWBIFtPpagpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAzI/yqnY8epicYAR9z1lLlI1YdkN2DDfnHYHMSdx08=;
 b=lWufNlgnKZ+rV/X5lxOmUUFQ+4/HHVZbKdyb+IYv9xWwsDYYOTbtPVbjj9pbeGKT990Guh3CCMJ2TXRHyxVbLcLQ7WgXdnIrdsKQYJrRWfdBD/o3zoWZnt4IXmNCrjO1XbTszkPT4kMvVaJK6XB4HRNUert94UTbEeJhASxfCYCfM4P6gyY8HU1qQqlri7jINd/gM4QcG2VVf9FdpMgJCAEfLJ6LqdnxD8vUDWSRTkpQGNgnUB/U0pxmHYcaD68SELFape7q1dyVdVKpuXDrNSj4u4HS1CO5zi6kYcwe8yh7FIszK2wERumPZF0ug+rhCOcmPQgssi1Vyhu9pBsq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:51:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:51:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qM4hN2vTGb8EmNSTTck992prKM7JIAgABI4TSAAF9SAIAD0KcAgAAbFACAAAC60A==
Date: Mon, 21 Oct 2024 17:51:28 +0000
Message-ID: <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
In-Reply-To: <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: 8c8fa727-5028-4c90-4120-08dcf1f8fd3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlkwYzVqeGI5MmVVdVh6Sk14OTEvQnZUOHpaUkhlTTY1VTFlclMrRGZsUUlL?=
 =?utf-8?B?R29XdmhzbGJoWktlR0U1MXdUaTV6blNJd2lKQUVENy9obWRMZFcrTzBKSFdp?=
 =?utf-8?B?MHV5Q1NSNE04SnNMRXp0YWMyeDUzZzV6M3NWVFFNVGw5NzJSVXVjdU1pQ0Jm?=
 =?utf-8?B?L0d3RnRWanVZekZlZjRQYjJTUUdFekh4Nnl6UVFXYmpjR3ZzWmlXNXdUTHNa?=
 =?utf-8?B?ZzVpV1psSFZTUDFQS1N2TDJ4QW4yS2ZFRXNuVTBKOXQyM3ByVk9DVVM3WFlG?=
 =?utf-8?B?TEgxdGhPMkRQS1RSWERjcFlOUGdMQ2ZGcDRsWnd0aUpVMVdGWCsrK2VNZ2hL?=
 =?utf-8?B?NjkzVGtQam5LREt3NWtCQWVCOUFFMk1FaUhRclZUWHBwS2tnWU90WUFoQUhW?=
 =?utf-8?B?c0Z6UXpqZ1lXakp3aWI3dks0L3pnNmFlRytjc3g2aDRIc1pTTDBBbG1LeVJU?=
 =?utf-8?B?YW9KV3JOYnU3eGZpd3RQTDNRa1EwVWIvUUliQWt5QTRuYjBtR2I0V0pLZjNT?=
 =?utf-8?B?Ri9wSnlwTWU1L3ZZNEdiZkVXVzVER0RkSEg2QnR1OFNyWGdDNEd5eG13dW9s?=
 =?utf-8?B?Z2RWdEhQc3haV2huUHVDeXhaVVJ0SGRwM3pjTnpiRHZaKytRY0d0N3k1OFY5?=
 =?utf-8?B?dWpGczBLWHlyQjRXc05wR1REaHJCbklNZE1IbjNXeks4WnQ0bFJSWUNUbmQ3?=
 =?utf-8?B?Y2hvOTFIWmpwbTZMWENwN1prR1VvRUEwQTdqSG1xSGhTTHM1azk4WHoxekdi?=
 =?utf-8?B?cm9JbERYbnovL01wRkI2WFVGYVFyMXlUL05kaFlzcitmOEd4WWFodWwrTVgy?=
 =?utf-8?B?dWRBSkZvWXpiOG9oVjJvb0dBYzFXR0lzclBtcDdrdkVLeUVNc0FZY3lyT1h5?=
 =?utf-8?B?U2dvcXQycUxsK2NlSlA1eW1Sak9WZytTM3htbktsaDEzNGdpUEEyODR6bXVt?=
 =?utf-8?B?dDVYUFRjRXl0ZkhBT0UzVnQ0M2d6cmxWUTdvYW1TZ0hhek10S1dTV29CTXQx?=
 =?utf-8?B?T21teVplVWFjK2taazV4OWduR2ZvbzhHeXFOOU53VEVPRTFaWkNBZlBuRi80?=
 =?utf-8?B?TWY5WTRKKzUwbUY0eUh1Vjd3cjRSN2N0azFQRkx5dDRRa0M5eHZsY0dOV2RE?=
 =?utf-8?B?c29jMXVCS2Z4Uk8xeTRkbVVlUUE2ZlNZYk1oWW9DeXp1K3E5MFJ1c1VGMDVz?=
 =?utf-8?B?TktEMUZBR3V0SkVXNURNT3NybkRUeElXMVl3VWdNYnJkS3h3NHM3d1hyLzJj?=
 =?utf-8?B?VW50cnBNRjA1L3dNU3o3eStFTDZLaDRQY0lseEd3NEV6OERWeU5CcFpScUx2?=
 =?utf-8?B?Q1R6emhqakhLaTZ1N0tnYnhXVDBGOW1jb1VDQ21jbXRLQUNlNllFOTNPZGpm?=
 =?utf-8?B?MVoyOE1EaEVaUzQ5ZnltaTJKeEQrZUZsR3E5T1pnQmZzVFNnMWRnQ0VMTGN4?=
 =?utf-8?B?OEgwK2N0Kzl3SkNDTFdHRWlzb3VwUWpaZjNtRnJVUDg1ekRjT0JZenZBSmUx?=
 =?utf-8?B?ZW5oQlJLOHBkQW95bHAxK2pXYzF2dHZ5ZS8zZXJlOFB0TTkzcDFSQURGOGs2?=
 =?utf-8?B?S01ROUtUN1hnTjcvdzhyUzA2YUV2RWhxVXZaYjY5SjNoVlNkQkE4OG5VSURC?=
 =?utf-8?B?ZGY4UzRMdUc3K2J3MzVFQzdIWmZZU05aSHdFSStoWFhQRk5WbUJPUithMGs3?=
 =?utf-8?B?eFJLT00vMUtsYXIvRHBWdEp3ajFWbWJOVXROdXRPMkR4eEtlL3ZEaW1CVjhZ?=
 =?utf-8?B?OHFhS0JFZ0xZYlJPaGJlVEloY3VnQU1ibTJuRlpUVE5DazUxRFFNNlJ1WlJ5?=
 =?utf-8?Q?sgjiNg+GU6hLB+t1ee1Bfxd6IMqjkqQGiPV58=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTRpelRrZnRscmRrb3h1R3JGNHl1bmJXZkwwSkdDSjJBb3UwZUtaL095c3dL?=
 =?utf-8?B?RDJsOUVHWk1BNStTVlFXbnM2U3V5bER2QVY4U1dwUU9XbkYxZ1l6dlc1UlFH?=
 =?utf-8?B?WU5acUlwcUtPRFAzVDl2TmdMa0Z4ZWZuK1EwZ1pIWE5sbmhCN1NyL1M5RXhw?=
 =?utf-8?B?ZUovWUMvd2JnY2NBaXQ3cTZrZmNJT1JsUzloSFd5aGFwYXFESWx4aDhGOFJU?=
 =?utf-8?B?TmhrUU00WHR0NURKaFQ3SzJhVmVJbkVsM2taalE0NXo1eEY5am84MlNYZ1FY?=
 =?utf-8?B?TlZFSW52OXhDZlhRMzlGMjJIbW0zYkRCMnR3WE5TaGVnT2JDeTFlQ01HaGJv?=
 =?utf-8?B?ZlZpT3gxd3pPYjNwTGJKcmNTYzVKcXBrMVM0UHNQZERqekJLZEZMVE9FVlZO?=
 =?utf-8?B?dm9HTzBxY0kyUXBBdjFVTkZpRHpjQlk0cVJXb2paZHE1S3hMakFkNHgxLy9p?=
 =?utf-8?B?SDVQd1luY3psRUxIUXZIU1VMbk5jNTkxWTJjK0FlMkVJWXhVK3plM3J3M3g5?=
 =?utf-8?B?bEVqTVlURm5mOU9SRTBzTzdmVEExb251dUx2TE01V1hQSXVmYnpJdkVac1la?=
 =?utf-8?B?VTB4ZEttejl1d2dHU1N2Nm5pdUlYbGswQjlsM2haWDRpUWFURm90dWpKV2Mx?=
 =?utf-8?B?cVowVXlQUzB3Nlc0MHNKRGRXMU9xMTc2QWNhc3ZoeGQvRTdPN2NUdFQxand6?=
 =?utf-8?B?ait3UG5lTjUxMEg4L0hhUUJyMllFN3ZQQlVSV3o5OXQ0NEsycWxOWUNwdndI?=
 =?utf-8?B?Y1RuZk8yUFlPTXEzbUNyNkNrcDNsTXBpdHVOdlZSY2VNRi9GMU1MY0s2Uzls?=
 =?utf-8?B?NVpLanNrbTRobElBN0xCODNMeWRSTUhHVkVuTlFhK0xiK2k5VzFxMzBBQjI0?=
 =?utf-8?B?aEJiUnR1RlVTYlppWFpqZERkVTQ1Y3VXaEtXTUZPNGRJajcwUFFDcG04QUVv?=
 =?utf-8?B?dU05TWVUeTBKWWtvR0EvaUhNcW40aWJKQzltZVZ3Ni9HaEFsSEg0R05rTEdN?=
 =?utf-8?B?U0ZnV2ROSkx2V2tZWEZkd3cyTWxRY1MvZ0hHelNhWUw2S0VxYzBtY3Q0bVQ1?=
 =?utf-8?B?WVVpazJwNVNTbFNEdFZQcGxaUDJuNzhBckhVbi8rTUp4UDlxNVRCOUk0bWlD?=
 =?utf-8?B?VXJrTTZCSkhFR3ZOSHQ2SDBkT0JFblhncXBjemhPbHVqaXoxS2JhYWc2SzV4?=
 =?utf-8?B?WXZFSlZDVHNFSG5SMnFsS2puRGhZcWNXQVZXR1JFNzg0Vk5qRmtzZTg2WThV?=
 =?utf-8?B?bzFJQzBZbXdMZDVZMjYwOS93OWJWTHpXQnRRUWhUV0NQMy94amhTZWM1NkNt?=
 =?utf-8?B?blZmSEExRFZlZmhIVmVYVmxrU3VnVGRLVGIyaHVXTXhyUUx6TmJ4MlY0VGV0?=
 =?utf-8?B?aXN4cXZ1MVRkUWRGelhjeEJjOWQ2bEYwSHF6dVdrNERYOEphcVJaN1UvSTIz?=
 =?utf-8?B?N3NNVG0wZWY0eHFXL1JQRjk0R09VZ1VIeU4zeDIwQnZhRjB0NjQ0blpHYTZ5?=
 =?utf-8?B?SVVSU3A2cC9ocmFMZkFwM3I1MExuTit5YzRIN1B3VXV5UGYrdFZvZEluSWJu?=
 =?utf-8?B?RjFvUlRIYkhEN3Q1aFZEYzIxMzJYOXY2S0FSdTlwUEQrZVpLd1pXaEFwNE9y?=
 =?utf-8?B?ajFDak5tOHJCWDR5QzU1MlU1MUhDQ3Y0VXpVTjBLZVhpclpjVzNPU3dzbWxT?=
 =?utf-8?B?dEY4Um5UNXNNdjhyR0Z2WHhuYjlWRTE2L1V4REQwWW40dkhoWjl1ZE5VVkNV?=
 =?utf-8?B?ejFTOG5IMWxUcExGWC9qVnhjVVNKbTdtNE1EU1ZWaU5oelVkK2VrQ2tJY0N2?=
 =?utf-8?B?TWNPN0ErMUFEQnBDc3dtRU9mS096eUtrL3o3bElHOHgzaWsxekVici9iWXNQ?=
 =?utf-8?B?blkzUmJNQ2VsNzFDRXZ5SkZwdm9lVnMyNEZrQzMyVlNtRTlpQUlRRzVUSjBN?=
 =?utf-8?B?WlViNzNkUkdnZEN5K1Q0WkMrcnZvU2lZOGdKdjVCK0NxNHJKWGg2QUZzeW9B?=
 =?utf-8?B?WDNTUlZqV0tQTHR1aXBKdHJ5TEtWNDRLdWtycHY4OGxGc1BWN2RIU3MwM3Jw?=
 =?utf-8?B?Tlp0Ti9wOElKN20zSHpWUVpmdkwwUWcxY2U0NnNHOFZaQ09GNk1mMUhyQ24y?=
 =?utf-8?Q?W+BwZ3r9lgKyyap6BvnIcd+mf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8fa727-5028-4c90-4120-08dcf1f8fd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 17:51:28.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EshJIoVCT6Oe6S8AHMjfXn/qjaANhtoFoOKsVXdwduIh/D0yKCY2xlomk9VRACVUo/Ejwzt81CN+c95gRJiayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com

PiBJIGFtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggdGhlIGludHJpY2FjaWVzIG9mIHRoZSBWRk0g
Y2hlY2tzLiBJIGRpZA0KPiB0YWtlIG1lIGEgZmV3IG1pbnV0ZXMgdG8gZmlndXJlIG91dCB3aHkg
dGhlIG1vZGlmaWVkIGNvZGUgaXMgY29ycmVjdC4NCg0KSGVuY2UgbXkgY29uY2VybiA6LSkNCg0K
PiBCdXQgbG9va2luZyBhdCB0aGUgcHJpb3Igb3IgdGhlIGxhdGVyIGNoZWNrcywgSSBzZWUgdGhl
ICc8JyBvcGVyYXRvcg0KPiB1c2VkIGRpcmVjdGx5IG9uIHBsYXRmb3JtIG5hbWVzLiBTbywgdGhl
IG5ldyBjaGVjayBzZWVtcyBpbmxpbmUgd2l0aA0KPiB0aGF0IGkuZS4gaW4gdGhpcyBjYXNlLCBh
bnkgbW9kZWwgb3IgZmFtaWx5IGFmdGVyIHRoZSBzYWlkIHBsYXRmb3JtDQo+IHN1cHBvcnRzIE1D
RSBicm9hZGNhc3RpbmcuDQoNCkludGVsIG1vZGVsIG51bWJlciBhbGxvY2F0aW9uIHBvbGljaWVz
IGFyZW4ndCBuZWNlc3NhcmlseSBzZXF1ZW50aWFsLg0KU28gcmFuZ2UgY2hlY2tzIG5lZWQgdG8g
YmUgdXNlZCB3aXRoIGNhdXRpb24uIFRoZXkgc2hvdWxkIGJlIHNhZmUNCmVub3VnaCB3aGVuIGRv
bmUgdG8gc2ltcGxpZnkgY29kZSB0aGF0IGNoZWNrcyB2ZXJ5IG9sZCBtb2RlbHMuDQoNClJhbmdl
IGNoZWNrcyBhY3Jvc3MgZmFtaWxpZXMgbWF5IGJlIGV2ZW4gbW9yZSBwcm9ibGVtYXRpYy4gQWdh
aW4NCnRoZXNlIG9sZCBjaGVja3MgdGhhdCBhc3N1bWUgYWxsIGZ1dHVyZSBmYW1pbGllcyB3aWxs
IG5vdCByZWludHJvZHVjZQ0KcXVpcmtzIGZyb20gMjAteWVhci1vbGQgQ1BVcyBzaG91bGQgYmUg
c2FmZSAoSSBob3BlISEpLg0KDQoNCkJ1dCwgc3BvaWxlciBhbGVydCwgSW50ZWwgaXMgcGxhbm5p
bmcgdG8gYmVnaW4gdXNlIG9mIHR3byBmYW1pbGllcyBpbg0KcGFyYWxsZWwuIEZhbWlseSAxOSAo
Zmlyc3QgbW9kZWwgRGlhbW9uZCBSYXBpZHMpIGlzIGFscmVhZHkgaW4NCjxhc20vaW50ZWwtZmFt
aWx5Lmg+KS4gQnV0IHRoZXJlIGFyZSBnb2luZyB0byBiZSBzb21lIENQVXMNCmluIGZhbWlseSAx
OCB0b28uIEknbGwgYmUgc3VycHJpc2VkIGlmIHRoZXJlIGFyZSBhbnkgdXNlIGNhc2VzIGZvcg0K
cmFuZ2VzIHRoYXQgc3BhbiBiZXR3ZWVuIGZhbWlsaWVzIDE4IGFuZCAxOS4NCg0KLVRvbnkNCg==

