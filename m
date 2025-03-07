Return-Path: <linux-edac+bounces-3311-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779EA574A4
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA19D7A1AAC
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6B25A2DB;
	Fri,  7 Mar 2025 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mV3PB9gg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B48258CEB;
	Fri,  7 Mar 2025 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385137; cv=fail; b=ZFr8YiDNsWx0ELtZGwRJTF2M5pY3aoKQ4PGluTuyimcIK8ALyNf2FUPjYuzSgOi+rM/ckx8dt6jtQCB8Rq9WFkg3eK6KNuQ+cyK0woUw4o3aTx5NEr1zkMr4fvDXgG8G/7WnAVzSf/HcmwV5neTLN3pJEMzWNK8B2mG0QpwJQKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385137; c=relaxed/simple;
	bh=0xYw2ZkVKyntnu6t+RGR4Z7GII/psiilS4/ypjfwcUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cw8sn0ktOp5aAg4nr92qD/fCPikOor+lbnLVmi8o2t540iZ/3TsRUr0URcV5XYbjJdB4VBWTiJk1qCp7/baSmpjwkQ+zV3sxWYAW9o204dsCUbu819tgiwr+GqUIx8yED72GEwVgt5J1unjtT0vkiGWen1QUKfbzlbTjG+0T0z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mV3PB9gg; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741385136; x=1772921136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0xYw2ZkVKyntnu6t+RGR4Z7GII/psiilS4/ypjfwcUA=;
  b=mV3PB9ggdylhGYF1Y8VmgZzRm+0lrb+XgivSR3j6k8wT2Njraey6L1cT
   O22dsgJSmnTobBPYMF85qOzWdltboMdkWnB+CGMk+PuaZt1pC6ivqq4he
   MYEvPIzZp6tn+dkaWeG4yNsgfRQS2YUczhJpxpDajAdhjWAWF6ccUgyLX
   G9YIML+TjWJNhH31HkpHC6oo+CU9Tvi1CysW3vSamizgFkMX40HDpKDWE
   S+9U8OTh/uiyVriH05eIU7m7IM4wF+SeJcEnLkQFDnaLyoJPOF7XGDxfh
   9IDPS5xeeqgHEnd8lssCcpBCegb6qGn92Ty4f0ZXSuDSvWdMosEIs7l/o
   g==;
X-CSE-ConnectionGUID: p3Y5xeseSBmm7itekf7v1A==
X-CSE-MsgGUID: PTQAtzXMQ26NxbqBy1YX6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42326475"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42326475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:05:35 -0800
X-CSE-ConnectionGUID: 0mN5iqzZT4yOPGUpEY9Utg==
X-CSE-MsgGUID: AouvDxRyR3ut04ZWnHmhmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119262131"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:05:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 14:05:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 14:05:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 14:05:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPp81kdX8o3aQgTgmedVn+g8LcDcrLP7P9OLBN+OxCt2pNmIVcY5O2Dkop+Fe3nOjKfXL/9gkWVLTKBgxwOVzPpqbDcmnv/FpD+1Rwt28I2n+KnlI6aevhLo81c4zRo/RnHT5ioJ+a+GJ/taH517DucbvY+CJ1TzicN3Lj4bDar1lXihjrwMsWFeaMuIc617dv5tMeNWK+aYO68LIA9W6iH5ChPbZj8VSn/vF5zXezjUGptbYJIS3B87PH3soiJPdcELXoKWMn+HhYy5KELwD1uKfz227JMEknWWO9L+AtL4ecijj/sbwjS0dmOBCno8lsZu7Y9k5Dqvmvsaw/Lt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xYw2ZkVKyntnu6t+RGR4Z7GII/psiilS4/ypjfwcUA=;
 b=qXJBoDS2PXriGsj4xi+RGDH5cvKZH/mw3uGtaLz+kIHfmVFMhg1121hAzwcEYHy+SoQXt7jtVUJSOP+mMZTtZTPENjltpx0z9kVIZ1Ru1ymW0J62s7NcGKrUEvRo3NjFFWDJdqpl7Zdl5FKTpAAMQBMy+POKiNiIx+ZEePp8BWOmpgNjrPieVClvz1fOLmEUDvIXSk77nElqH2/As6rYbCEM2wPM6L/SorFxN7IZJxBsHUPcZHjC9hulptXaSZ+4spQYRHkVIU8j2A4XWEfLO76ed/r32RghRn/ylEQxup6H3X5RTaw/MoEA/ZC1IBXZC/iomlNU8F/PCyM65fXkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 22:05:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 22:05:12 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "tianruidong@linux.alibaba.com"
	<tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Thread-Topic: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Thread-Index: AQHbjyP+jS5lVBxqwkSk4GQtSSn/LLNoI/4AgAAVztA=
Date: Fri, 7 Mar 2025 22:05:12 +0000
Message-ID: <SJ1PR11MB6083654405F2721E5AA0C1F2FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
 <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
In-Reply-To: <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8478:EE_
x-ms-office365-filtering-correlation-id: ef4772f8-8583-40db-d10b-08dd5dc42257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bzFLcGt0djA3WnAvMmVzRXNXT1Z4aWZtcko0QmNNYkNPT0ltV1pIZ0IvUDJl?=
 =?utf-8?B?Q2R3aUF4SUIxeGR3RjRTcUQ3Q2Rnc1MxN2VUSytwalUrdEdGV3Y5cVl3ZzhC?=
 =?utf-8?B?V3Ftb2RheEIxNUhKeU9Yc3dGL21oM09lYnN6TlpWWnNIRjhoK2R0bGVkY1ZO?=
 =?utf-8?B?SGtrc1Voa2E3Y293L3AraTJCUnV0WTA1dEJIdkc3czh2K2ZPRkNCS2E0NkN1?=
 =?utf-8?B?NzA2UlFzeVZqWnllbFRWTzJRODh1NFUzdmdRdWhrMWp1d2VzRTRUbVJNMjdI?=
 =?utf-8?B?UHFibTRLOWNaczlFYXlNVU5ySXh5WVZaakFCVlVFdVk1VWFrbDdqaDlWRDA4?=
 =?utf-8?B?bXpYazVlZDdJVmJWZVhGMW1ObVBzOWNhWUh4WlhqSGdVL21SS2xRbEFVbE5t?=
 =?utf-8?B?ZGg0UTNoZVgrUmZKU1V2Mk1hT2JJQmtpaHFmQmRNamZZN1dqd0VTWDE5ZVNm?=
 =?utf-8?B?Y1JyYXNmeU1Xbm4rMEJPU21nUG1jOHdOK0FNL0xZY0RTbU5LZVNwZ2w4b0dv?=
 =?utf-8?B?cGI0T2pReWN6YjR5alo2ckZGVDBydENxb0hRTW0vNDZ1ZHFLZ1k0amFrVzBP?=
 =?utf-8?B?MVBkaWtuNHFEWitCSlVKWmx1RHNndW9XU1BvUitDWmIzMEpldGVXdlBicXVm?=
 =?utf-8?B?L3hQSlNuOG9kN2RvV2hvRUtiNzNXZGF2MDdTd2Q4cUhObVVyNTAzZnZYNzZu?=
 =?utf-8?B?bW5yM0lNMWEvRDhSN09PZ1R4Ymd6Z1FoOHl5VEM1SndPaTF6V1g5SFA0a0Nl?=
 =?utf-8?B?STB2UW9oNXJCSGpSK1MwVEVRSTJKZy93VW4yeUJlQ3hCZVBXSk9RMXNpTEs4?=
 =?utf-8?B?SC9FQkpHV295azRDcE1IbGVaeVNCME95a1dsd2RGLzExMXNxdmxPa2c2TkVS?=
 =?utf-8?B?SFI0azg0UFkvcTlhMWdFeGd4b2hjdlgvTXFUa2Vxcjl2NTNUQlU5RU52K2hv?=
 =?utf-8?B?R0RNeWtEQU9uc1ZpT0hKTW1DcUlPZVN0VHB1ZW05TGJxSjM2c1h1YjNCeS9s?=
 =?utf-8?B?Q0hPcEJPM2U3bDcvem9XaGM2RzNiSExxUzBiaFg3UGlYVk5LWDJxYVhNWks3?=
 =?utf-8?B?UmhEUU53b3E1cDNXbWV2V2VDWGNDMkk3OEtya1RLWDZCQkxZamYrUkNoOERi?=
 =?utf-8?B?QzhTYkhaakEyZEtwMWwwSk4vUllCaXFvUW0yVFhxYkJrbURVelkvd3FoeGRK?=
 =?utf-8?B?WkU4THc5UUUyK1E3ZDZHWTkzWlFuM1dEZjBTQjlCdkppaytaSjJvNkZ0Vlpn?=
 =?utf-8?B?MFZVd083QzNCeTNHTzlSc2NrVGh6M3pVU1dwN2xyVWx5NStpcjBtRWRKTXE5?=
 =?utf-8?B?eEI4cjRBN0NoU3dTaVZITzdRMmk0QjFQZ3Z0eVJkalZUcmIwL2ZNZzdHdVJM?=
 =?utf-8?B?amdUTnJZU1pOZFNqTHVZRkE4UmJ5ait3cVcxdUIrdkhqNGNCL2xxTHFLT2Va?=
 =?utf-8?B?VjRFcDF5ejJTOGNLZjBreFhiUU5haERDdndvRWhCZkFQaWpXQS9nc2I2U3U4?=
 =?utf-8?B?NjgzcHM0ODR2OFFHeUowb0plVEh5clBLd01Kc25GNTZBelAweXJkYitJNG5L?=
 =?utf-8?B?UTJNY2dzRmxrN0hmTitRcXNXb2FkUmNtV20zR2x2SVUvc01ja2EzTENXcm1E?=
 =?utf-8?B?RUxyWVNUVkdyUnFacGNKZGRSalQ5MmVPYm5hMTZVOVdqdU1ubjh1WkdhUXQz?=
 =?utf-8?B?YnJ4b1prckRaSXRzaHBsbUJKY1NoaEIzMEpLUWR3TUQyL0RLaUpPc0JHMkI0?=
 =?utf-8?B?dGN4VzBNdndId014dWY1SFJtaktEekVoa3JOY095bE41S0Q5YXQzV0FUbnUr?=
 =?utf-8?B?L0hBVXgyN2NFK2IzME1Od2NtQUcvb0xianNXaXdyR1pITlh6N0UzZVJzWlhx?=
 =?utf-8?B?cEpCb1lDbDJTMzZObmhueXh2VjZOUHA0VW9WWkhGS1UrWk1YOHVBRkJpYXNr?=
 =?utf-8?Q?YskouULIiu+9A49PfcdBA1mHWZd7+uQ2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNsY2hNUzVvL01KYWhWK25ZTGpUYjdXQzZ5TzBOcGRtTWRmK0p3aDczME9s?=
 =?utf-8?B?STc5QlhmS1ZLOU5UZHhTUjVHQUNHekRuWUFRUXdCU1FoaWFpRlA2QU9Kczlh?=
 =?utf-8?B?YWpyWkNkdW0rVCtGcjVQdlZ4cFljalpJZFFhZ0lEOFZDazhyMXY3bnVrck1p?=
 =?utf-8?B?Ymk0ZUdtamM3T1orZmZtQmpVUnltTzc1amhDMTl2bCs1aG5zcFN4VlJrQmJz?=
 =?utf-8?B?SDBiRkllcU95RXFqNXNib1FqdldsNTFhVHFBWG4xWk05WnhlWmpoZGtDcW41?=
 =?utf-8?B?ZHhrU3htaW0zOXMvSE5CeTVMMkJwYTk5YXlXaWRTUGxrTzNPRStFQTlwOUxJ?=
 =?utf-8?B?R3JwMEVyL0RoQlpaTDhZUWZTOGIyOFVYNkZUVjNmbldVRi9lbkVVMEYvcVlk?=
 =?utf-8?B?WXlLTE9iOHNFSjl3Mjd3QnE4ZWVlcHJWWjBYbTRXcXZQcXhlVXArUVJxTWRw?=
 =?utf-8?B?dVU5ekdTRXZUMXhFUWhQTk5Hc0RqNHl6OUNNU2ZRV0Y1RmpGcDZ2dE5DTWpH?=
 =?utf-8?B?SG5ON3k1dnFyMWgyME1xZ3hCYk9qT3BaZmRaOXpPNmxIcU0zSE1LLzZQNWM4?=
 =?utf-8?B?K2Fmd2pHZ1ZlUmF6R0dUUzEyMlVxM2h4R005aVVLMjYxdElVeVZ2VWVwc3FY?=
 =?utf-8?B?VG9lRW5uQndjNGovMUtOOWh2eE54RDdLS25BbTFVRFppOWRFWEVaKy8vQkh3?=
 =?utf-8?B?eFFrQzBKZ0lJcmlmam1RNi9NM09kTDVTNEVoLzBWaGdmR3dTRDFkaVRNbk5R?=
 =?utf-8?B?RndEeEpVUDVETGNXcngxeEdNeHpjczZnTEEzdEZra21DT1U4U2V5WW5QYzZD?=
 =?utf-8?B?bUlvTVNrdmZoWDY3UVg0T3g2NHY0dEhZcHgxRjhqUkZEYVk4QmJkUVNrSVlJ?=
 =?utf-8?B?V0p2OVZ4MlcwNmdhR1JQM1I2RFFLRmZ1TVMvRjZBTEY2NFB1U015WjlsVmM2?=
 =?utf-8?B?TkxPZWROckYxdDBBdWo2b01uMktNWGRUZFRBUFVvZGlWdW5UMHhYWTEyaE9Y?=
 =?utf-8?B?NjRpdk10RFFGUXViWDM1aFFuKytCK2QwekwyWEpCRVllallpb3ZKb1duS2dJ?=
 =?utf-8?B?Y3JGMlRnZ0VNZy9ldm9Ua0hNOWRPUTRkSTdUbXhwK0wxMXJXVzQrbnJ6aW9a?=
 =?utf-8?B?Z0NJUEFaOFZlZkxHUGlwKzNpSmZ2N1M4K2NnNVBhL2RjbndOK1FXQ2MwamNV?=
 =?utf-8?B?ejdRVks1T0U0T2JNNFFkY0taWW10Y1RjNlFqS2lFTUFXV2w0QzlvbFhMQ1ZW?=
 =?utf-8?B?cFZoQitaa1ZZdlVZeGtNYWhsL2t3cDVXeU91UUdBa3FucmFyZ3dhYlpBM0tk?=
 =?utf-8?B?dDh2NXJrcUlBN0UwYmZTZGNZN1N2N25UdmdqWVlKTVBNUnhRUGFIOWtQM2JJ?=
 =?utf-8?B?M1FHVmpqZ1B5djRkbTNZNEdOU0xaUmRQRlhHVktVQ0pabWdxaWJlQjUwUkJn?=
 =?utf-8?B?Q3V1bWViRzVIK05tKytqazMxVDlQV3VBL3BwcEphT2ZJUVlGNWdoK040SGJZ?=
 =?utf-8?B?UVdlejdQeDZxSHpmaTVWekNjT2lXVWZEUjhibWxRYldqcTFpaVhFc2I1cCtz?=
 =?utf-8?B?d3lGNnUxMVlMbWRJU1k5MWUwaWVRTWNrUHVyNVV5Q3QyVkEvbGM3Nlp2N3N3?=
 =?utf-8?B?SWdqeWI2WU9kU2pUWGtvU3FGaGtyU1I4YlRpeSt1bm4wbzNmcGVHcGZUWXMr?=
 =?utf-8?B?SW5aMjZaVWxMWFRweW5ZMlFpNVlDaUNlelFJMUxtUGtaQlVIM3RTcndnRDll?=
 =?utf-8?B?MlRyTEpTUXIxaGtiZEVKYVFGWUI4M1AwRVB5Q1RVOVAyOUd0Nmd6V09mL1E2?=
 =?utf-8?B?NUJ5eXhtczVyZkZmc2ZaSEthK29jQ1dCa245cHA4QzA0Y1llTWx6dzFhTXZM?=
 =?utf-8?B?SXE4RkVBaWVXeGphY3JyOVYzKzh2c1FpWFlwVmV0a21qU3JoemNqRUtOd3hK?=
 =?utf-8?B?MVlyL3FMakFVTTlOVitBQUlScHBDdHgzYjZXTFdoZk5ZbGpaV3RDbkdYSHhH?=
 =?utf-8?B?Rk04QjdZSEFxRjNTYXQ3S2FadFVkWGlHaGNUMXVqa1N0WGF0SHJDM2o3NTNR?=
 =?utf-8?B?OVdybGFyQ25OMVJ6alhRaURXaEVna1RLa2MwaU9SUWFKNDZtOHJOdnNqeTl4?=
 =?utf-8?Q?Oidw57B/2zd45e+1onFlD4CSX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4772f8-8583-40db-d10b-08dd5dc42257
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 22:05:12.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aW61sHDrwr+6+3YhTQ7fmhq+TxT7bfkPdTMjp3QCU5i//gmzhLLVNGksmESW44iCHr+RJhDFdphNx8KcxOMuzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com

PiBUaGUgbW9yZSBpbXBvcnRhbnQgcGFydCB3aGljaCBJIGFza2VkIGZvciBhbHJlYWR5IGlzLCBp
cyBpc19jb3B5X2Zyb21fdXNlcigpDQo+IGV4aGF1c3RpdmUgaW4gZGV0ZXJtaW5pbmcgdGhlIHRo
YXQgdGhlIG9wZXJhdGlvbiByZWFsbHkgaXMgYSBjb3B5IGZyb20gdXNlcj8NCj4NCj4gVGhlIEVY
X1RZUEVfVUFDQ0VTUyB0aGluZ3MgKmV4cGxpY2l0bHkqIG1hcmtlZCBzdWNoIHBsYWNlcyBpbiB0
aGUgY29kZS4gRG9lcw0KPiBpc19jb3B5X2Zyb21fdXNlcigpIGd1YXJhbnRlZSB0aGUgc2FtZSwg
d2l0aG91dCBmYWxzZSBwb3NpdGl2ZXM/DQoNCmlzX2NvcHlfZnJvbV91c2VyKCkgZGVjb2RlcyB0
aGUgaW5zdHJ1Y3Rpb24gdGhhdCB0b29rIHRoZSB0cmFwLiBJdCBsb29rcyBmb3INCk1PViwgTU9W
WiBhbmQgTU9WUyBpbnN0cnVjdGlvbnMgdG8gZmluZCB0aGUgc291cmNlIGFkZHJlc3MsIGFuZCB0
aGVuDQpjaGVja3Mgd2hldGhlciB0aGF0J3MgdXNlciAoPCBUQVNLX1NJWkVfTUFYKSBvciBrZXJu
ZWwuDQoNClNvIG5vIGZhbHNlIHBvc2l0aXZlcy4NCg0KVGhlcmUgY291bGQgYmUgc29tZSBmYWxz
ZSBuZWdhdGl2ZXMgaWYgc29tZSBvdGhlciBpbnN0cnVjdGlvbiBpcyBkb2luZw0KdGhlICJsb2Fk
IiBvcGVyYXRpb24uDQoNCi1Ub255DQo=

