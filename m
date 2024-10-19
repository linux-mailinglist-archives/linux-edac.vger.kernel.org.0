Return-Path: <linux-edac+bounces-2153-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4F9A4BDC
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF61283509
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5911D6DBE;
	Sat, 19 Oct 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGwpSY9t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7851CC890;
	Sat, 19 Oct 2024 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729323436; cv=fail; b=GNQYIbs3QH2P7JA5Qo/xOZ5CTVgfMN6D86cpAiT1bRvHMQPqD6Rgonnj2Zj1nSNsOTb0KQSylVzO2I8osQOBDrmQ981b2hJvMBvLznoCZW3ErdKfhBbHqrhTXZnOAhx+5TE9Y2rwzzStFR3JO3xUBnuLtfJUv4kk/MwPJMxSG9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729323436; c=relaxed/simple;
	bh=ZSEcvc9F0FCoL3zJ4CK1FBrGYbqYudTJmQ4awAKTyBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRd2sZTUdrRMFkmpvL8m5yBrmtjl2IYU92iMjb3aR31NnCSnlAPXnwmd8ZWmV0XOqamE3autLXV4YQ0UurJ1+lwM2I9zQvDFd/CEx+qA1ihXYeN6BgaUrshHQpw9Sb2c63s8TsPNM6L6OmLHHJC13tqQoqnz6it4vpzvxD2EzoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGwpSY9t; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729323434; x=1760859434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZSEcvc9F0FCoL3zJ4CK1FBrGYbqYudTJmQ4awAKTyBk=;
  b=mGwpSY9tYnG6fVUa0nsaceAseJEzBSc2ZJX0E9uZ4SZgEibhEj6uvPWK
   p+h97G3ApPnrvbE6IL0yunJA9PqM9jKJBs6SP39vGxduX4VFoUG33gDKA
   1Tn6JBkIMtFpoARCpPsclwSUIFvF9RmI8xnmAhQsw6q1IHbVKLMnx5WNe
   yjN2sBacyneueKZ0+2uRhYYtv6BlycgGUcw9A5kNt90oho2iWOoxL37wi
   VeoMAgmqFUEaEu2NA8YwsDWNYeFQPfOkz1JA4i+i+dV70XX25e3mZY/2I
   cPouegBBc9A8N5ven7WN1h1YbpWe1yr2E5M9VJeb8V3vJ/ijvUsYNU0yR
   g==;
X-CSE-ConnectionGUID: ZIgH/JF0STeFk+mKo2GLHA==
X-CSE-MsgGUID: iybomtVrQtamWfYkkSxInQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28739902"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="28739902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 00:37:13 -0700
X-CSE-ConnectionGUID: 83tUN42KS0ysINfCDgcVXQ==
X-CSE-MsgGUID: e7qaHRobSGWiqRJB13IAZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="102376340"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2024 00:37:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 00:37:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 19 Oct 2024 00:37:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 19 Oct 2024 00:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBLpqwgIvYbMUtrb1bs61mCoRG4ue0lwTIRRwPIetSVNjyIN+OgSfvXzpqOllXCdDWydAsvJMDgd+p1cYJabv7R2v/CCYjNpzuwiZSPi5nIWX+1GFnLP2vRSD9LqzNMcCvnrIVSiWPE26jDLtv+qTTnfIGTk9qxODE2uYfYr2WQWddsfRLMUygXtBCBcJnMHTc1XB68pDIA1KBW8gzXweAibnUxscrm1yJxsn2o+qcwXqA9G+An9uz105rfyaAesx/ilWsCAXUTGEgxBuqHwrSIr8pJG20LlLoLoZssNtL/Onie6wwpxoYMyp/Mv5GNrZ5bLmtISIyr9R1sqCXm9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSEcvc9F0FCoL3zJ4CK1FBrGYbqYudTJmQ4awAKTyBk=;
 b=Lw9KVmkPuDJpIohyf15ozex0nhYAL8bEue40qPbog1Et47Vmi0buePIqWwpTI0NKJQpQhtAi2i7NaHZNDAOCMG+eyd1jh9tAH5rye3HMTaz6UJdK2JMYv+DClszV0PluvFOFVgDcmfRJtub/qsDFAPd86w+AulghbEz3KpqWIVevGCVw+oxWS6R7L/iFyn/U12tHbmHe1eklIatY1hlXgcNG/2glVUxBsC585XsoakGJZhB64FLqNS8yqhEam1UyMvJ30UsqwH1J8vddj194xzsuCx/7BRanef0o0kIModjllGc5yTuYguUD57zrZiJYq082hUBXhqjQLkKm0FOgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA1PR11MB8803.namprd11.prod.outlook.com (2603:10b6:208:59a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sat, 19 Oct
 2024 07:37:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 07:37:05 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
Thread-Topic: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
Thread-Index: AQHbH8qVDZ35fCCPoUul5iBQZYHMD7KM+CmAgACvGnA=
Date: Sat, 19 Oct 2024 07:37:05 +0000
Message-ID: <CY8PR11MB71344BDC1A3AB4454FE9446A89412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-9-qiuxu.zhuo@intel.com>
 <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com>
In-Reply-To: <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA1PR11MB8803:EE_
x-ms-office365-filtering-correlation-id: f0caf8f8-216d-411c-145d-08dcf010d474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGhERDlFOGNYQm10aFJiMmpkZVBYUXp4eUR2YndTTyt6c2V0dkRMeFRpOGtD?=
 =?utf-8?B?ZERzSStydnN1Z3krSEFxZ3EyeUo3QTFKL3lQQnFZd1pEOUNRRDVQK3F4Mll5?=
 =?utf-8?B?dXdvMXc2TkdwZzFjampKeTlUL2JRSlBwT2dIbWR3VzY3SXcxN3Fnb1daNGxU?=
 =?utf-8?B?TDJUNE1yQXRlMkZRVE1pYm0xZGlxTENpTTViUFBoTTBSUWVZa0NIRlUxRm1L?=
 =?utf-8?B?NWI3ZEJYRnY3NE9TSFhFZ213QVFDMHo4Mmt5bXl3REN2b3QzMTZpNk9abGVa?=
 =?utf-8?B?VDZWM2tmaEdTeGRMdnhvbUl4Vm0xYlZ2eEU4N1kvZGFGaFJPdm1UQW1JTnhs?=
 =?utf-8?B?d24wcDExeFZsV2M0OW00czZCR1hOaFphaExaeExxYnJ2Ry9ob2NBcEo5TjdW?=
 =?utf-8?B?Q3hmL0lDWnlhYk5ObC90TWJJZVdhZmxrUG1wWVpOQkVucjljd3FRSE11MjQ1?=
 =?utf-8?B?Y1h5cmRYUTZlMU9mNmZXN29qYjVGRmlocW4vVWlQVHpGeGJPbVNYd1V1N2pN?=
 =?utf-8?B?N05aM3pxWlRpSkZuWXBXYlpPNWkwaWZLRmZLL3lJQTBmRzhZYTdzdTNQVHhm?=
 =?utf-8?B?aUFGc0tzTXZtSTZPRU5Ja3lmdWpiMlpHMTkrd2Z5bUNuclBsekVzVVFQbGI1?=
 =?utf-8?B?VENQM1BGeFQ3T05RTThQa3l1OGJXVWdYZkduajYxMmNCSVRPN0MvZnFzVS9z?=
 =?utf-8?B?UzYvUXNCK2ZXby9UNXJ2Nm15d3BGcVVTNy9VcDJQOFZLcGtDR0J1Z1RQZW5v?=
 =?utf-8?B?bzAvbmYyOVRYTDJ1YkF6L3BRRVFpV0YxWjg1c2YzL0dVZjBhWnh3bXZPYlNm?=
 =?utf-8?B?ZFFPN2pUTWNnbmZhVWlpaWRmZFdwd0NqMjdwNUt6NU5kUFdFcElGM3ljbC9t?=
 =?utf-8?B?V2wrNTVZV1NjOTRJSXh1WWJCRVlLODVsblEzZTlZUHh5QWlLeUszMjFJNnFs?=
 =?utf-8?B?WlFEYVFTTlF0cVBMSGduUHRkdk0yYXY5ZmpwYXk4c0ZKQitSRGFVUXA3bU5P?=
 =?utf-8?B?OENDMjNnbWV1UzdWZllTOW1oeGhheEFjdTQ4NmFTQ0pVcDVIanpNdE40ZkRE?=
 =?utf-8?B?K2ZjWHhKakJJcXNnT0RWbzhEUFpjdmYydTErR25lWW1tdDM1U0lZZEx4OHFH?=
 =?utf-8?B?ZUFCWVlmemt4NHJ5UmpZRjZ3OGhBOFdJZFdvUTBEQmRrYURkNnV0KzRoOHBS?=
 =?utf-8?B?eVRrTWlTTWlrT1QwSXJLb3FyRGdqR3NKRnY0UVBOdTVuSGxhZDVXbVZKMktm?=
 =?utf-8?B?VFdJWkhiWDZwK1JnMG9wNWwrWGVJNzVGSnZtWjhpSGJCdXlLUHRmSis3WWdl?=
 =?utf-8?B?dGtHa3RiN2h6T3RmWkF3bUd4ZnppSVpBc0NuMGM5VXoySTNpTDFPKzdaN29x?=
 =?utf-8?B?bXNVMjZ0NkJkdm80eDlKaUNFSloyK0FpWUdrT3hiNzZZRE1oWnloWUxCRHlm?=
 =?utf-8?B?eWJtbmtsYnJUeGwxOUFobGpuOGsrNnFtVTNzU3Y2ZWZCRjJtYlp4eUhRY0hN?=
 =?utf-8?B?NGFZZ2lsdlR0Y1VNOVpoRnhBMWM5bjc1Y3p1WGJBekF5QkkxK0Z6dENIaytx?=
 =?utf-8?B?bG02Ui85TjVxRHdZWHc0c3hXczN4MWlZWUFlK2Y4cnpoUzQ0aXN3SU0wNXRq?=
 =?utf-8?B?Mjc0WFRIWGs0YTdsYTJqQVpvd0dZK096ZEVlZ0ZHQW14TWVpWWl3RG9XM3Zn?=
 =?utf-8?B?ZnhMS1d1YkRnQ0JKOWUwdzhKYUZFK20yWFN5S1A0YVV0eGZQT0xlL1RNMEhj?=
 =?utf-8?B?R2NnSmJwenM1VmM5S2xWTnVYTzBGdE02NVJ3NlpwQzkrem9WN0FZLzFqelIz?=
 =?utf-8?Q?ZIcboDhXA207JSx61oa9NBNGpHP5NlXYQ4a8o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjk5RW1KMnAxWjlCbklVTjNMN0RUWCt6ZmxhV0VFN2RwNWpuL2lMOER2OGFV?=
 =?utf-8?B?SmphclVlZEJqUTBKTUhXYkMxZ1BmMmRzMWxBQ3g2dlcrZCtUWS9zSUZnc1hO?=
 =?utf-8?B?UWhzOHllTWVJVGVRclNVVis5Lzh2L0lrTC8ybFVJNzRLUjBiTjdLekhpUmp2?=
 =?utf-8?B?VHpmZmI1eDZMd1I0NjdoejN2NjJ1ZVZIQXExVUNiK25qVE5jUXRYZGFrSEtH?=
 =?utf-8?B?VklDYkxNUFlQMDJwaEd6eWFRdVluajgycDh1aWNqUis0UTBxbUJ3a1BaVENt?=
 =?utf-8?B?NkN3VUgybzRKdFpVN3pZMHZPQ3dqTTNJeGVGRCtkMDYyQmtjTGFTVWdlRUFD?=
 =?utf-8?B?Vk5EczBPWTAwVXdPYzFPK1BRaVpSTUQ2RWM2elc4VnFDU2tPalV1TkRyV2Zu?=
 =?utf-8?B?VklYNkdXOEt4UEVHSS9ISENjd3R1YUxRRFVISlNaQnVBNGpmbHoxUlZEU0s1?=
 =?utf-8?B?U2YzWTdUcDNlYzFaeWpXdFVZOW11WHlHWndxSHVaVXBLbzY1bHE1akxwa2Js?=
 =?utf-8?B?NUtwcEZTc0lFVTROZU94SVRoZ2lrcEVMdHIxZENQZ2VTeGZTKzZNTENvb1A2?=
 =?utf-8?B?T0RhdFFCL1Zhc01nOGFUbE5GOGZ6aVBmczlOaVZHaUNYZms4eFFYVTZvb01L?=
 =?utf-8?B?YjJwclBydEcrbjk0NUhsQkxvNkMrQTUwTVV0aHNiVXN5SUhDd3Y4TVBidzNL?=
 =?utf-8?B?N0ppNlNFeFh0dW1XejYwZlJ2VjNQNWQyQUdJN1hKUFMzaURJYm54VGtSQXhK?=
 =?utf-8?B?V0hqbFNCZkE4bzZrcElTRmg3VjA2UkhFdW9JRzFFZmRXeDhMSmJzeXhUZExw?=
 =?utf-8?B?UVpjWjVmSENMSHMvUG5tbE8vL3dZMjlKZUFYckNIWFNGZitEY0tRTUE5NGwy?=
 =?utf-8?B?UHVjSzM1c2lOK2xwdnJoUDFmbk5YZFNNWmlHZFp1bHA2OEdlOE9sY2tMa0JH?=
 =?utf-8?B?MFlwc0FVS0x6cXQvYVdQcHllUFpvN3JBMnNCU04vMU5QWFhDRERpS3liSENN?=
 =?utf-8?B?d2RQbGxNNmpzbDI4anc0dm12bCtsU2g0TlNDQnI5VVRSeVptQWRxcWg0ZExp?=
 =?utf-8?B?VjJoRHRSUk1aSFhyZE55K3ZjbkJINEZaTnV0QVB6S2k1Q2FVU3VhbzEvajBx?=
 =?utf-8?B?OXVUTmJsZVFPODhYVVZBbEhZYmZhUVFYUTRkUFZrUklXbVZ1M1pncnBZL3lu?=
 =?utf-8?B?NjhEd2xyZkF3bHFQa2RzU2N0RE1HZlA2d1g5Y1BJUzNCWVdqNGZ2QVdmMDdx?=
 =?utf-8?B?dEZ6Mi9OTE92dHVYWmFuZTNOeWs0cGIzaTRrQWViQnFtMzFHZFBreWM2d1Iv?=
 =?utf-8?B?QmlUOXU1a2FSRVRVOU5UNFZNaXBZR0hkRmpsb3pLRzdJeHFaWHdEZHcwVU1U?=
 =?utf-8?B?bGp6ZUxhUlZFUUI4b0RZa25vZWJudXl0V2F6dCtZcGNJaG54RHB4SnB3cERi?=
 =?utf-8?B?QUdvS3NIUlBxTVhDZDBiM1A5dkhiNGNTRk5aTnJFcVY3NUw3bnI1R09IUzRO?=
 =?utf-8?B?RWRxc3phd0pCUjd2VHhxaXl5UWFZMUVucXpuMTJTVHkvNE5DcnliLzhOZkdy?=
 =?utf-8?B?aWpoNGVFckd0RmtLb1RCdGFKSmhxWXBRTzdYR25jME1ibmhwRVdyeTJ6RzZ4?=
 =?utf-8?B?bDFyaVlLRDJDWUU1ZWdjMHdRdGkrTFRwWWZldmNlWjNQQVp0U05wSHBuOHhv?=
 =?utf-8?B?VTg4Q2JCekdvdVo5R0RqU0c2Y09QODhEYTJDUm5Yeit0V1B4ZUdVY08wTXhz?=
 =?utf-8?B?dzltSm55eW1LS1kwTVp6MjV3c3lBSDBjNzN6SDdySmJaR280N1JudWdzYVFU?=
 =?utf-8?B?anBVNVZXaWkyNUlSQTdFeFMxY051YnpuR2l5ZUMveEtWRFptTE1DVWFLMkVM?=
 =?utf-8?B?c0VQQUFhcGlEZGpPRHFNSjA2a0NiMGFHRE1LQ2p6RVcrcUNLTnRLdk1GM3hy?=
 =?utf-8?B?RUJLRjBnVERKUFFZQ1NwUlpuZFFPaFhBRGY4S3h2ZmtLMUxHTjZYaWJnMUw5?=
 =?utf-8?B?TzVKT2hQM1o5c0tGTXM2RjVpQTdLaks4Q3dIbTBiL3JOUXhML3J0NnFFbmti?=
 =?utf-8?B?bmk4cm5PYXd1dGxHTGJXbTRQZlBKbkh5M2UwdTJuTEdOYzh0d2tSM0xXSTRv?=
 =?utf-8?Q?QT2ZlyQNRX2t97WJ75vXxtOf9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0caf8f8-216d-411c-145d-08dcf010d474
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 07:37:05.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIqzt7NXLEXdfc7q3P4vqsRGZW3SmhulFg0nzAd2WdD/praiPlxQYiHCDVy36PV330DsdEAYt5WBlXt6sMK1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8803
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
PiBAQCAtMTI4NCw4ICsxMjgyLDYgQEAgX19tY19zY2FuX2JhbmtzKHN0cnVjdCBtY2UgKm0sIHN0
cnVjdCBwdF9yZWdzDQo+ICpyZWdzLCBzdHJ1Y3QgbWNlICpmaW5hbCwNCj4gPiAgCQlpZiAoIW1j
ZV9iYW5rc1tpXS5jdGwpDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+DQo+ID4gLQkJbS0+bWlzYyA9
IDA7DQo+ID4gLQkJbS0+YWRkciA9IDA7DQo+ID4gIAkJbS0+YmFuayA9IGk7DQo+ID4NCj4gDQo+
IEhvd2V2ZXIsIGluIHRoaXMgY2FzZSwgSSBhbSBub3QgZnVsbHkgY29udmluY2VkIGlmIHRoZSBt
aXNjIGFuZCBhZGRyIHdvdWxkDQo+IGFscmVhZHkgYmUgMCB3aGVuIHdlIHJlYWNoIGhlcmUuDQo+
IA0KPiBUaGVyZSBhcmUgcG90ZW50aWFsbHkgYSBsb3Qgb2YgdGhpbmdzIHRoYXQgaGFwcGVuIGlu
IGRvX21hY2hpbmVfY2hlY2soKQ0KPiBiZXR3ZWVuIG1jZV9nYXRoZXJfaW5mbygpIGFuZCBfX21j
X3NjYW5fYmFua3MoKS4gRXNwZWNpYWxseSwNCj4gbWNlX25vX3dheV9vdXQoKSB3aGljaCBjb3Vs
ZCB0aGVvcmV0aWNhbGx5IGNhbGwgbWNlX3JlYWRfYXV4KCkgaW4gc29tZQ0KPiBjYXNlcy4NCj4g
DQo+IE1heWJlIGl0IGRvZXNuJ3QgbWF0dGVyLCBtaXNjIGFuZCBhZGRyIHdvdWxkIGJlIG92ZXJ3
cml0dGVuIGFueXdheS4gQnV0IEkNCj4gZmVlbCBzb21lIG1vcmUgZGV0YWlscyBpbiB0aGUgY29t
bWl0IG1lc3NhZ2Ugd291bGQgYmUgdXNlZnVsLiBJdCBkb2Vzbid0DQo+IHNlZW0gYXMgc2ltcGxl
IGFzIHRoZSBicmllZiBkZXNjcmlwdGlvbiBtYWtlcyBpdCBzb3VuZCAoYXQgbGVhc3QgdG8gbWUp
Lg0KPiANCg0KWW91ciBjb25jZXJuIGlzIHJlYXNvbmFibGUuIFRoYW5rcyENCg0KRm9yIGJvdGgg
ZGlmZnMsIG1jZS0+bWlzYyBhbmQgbWNlLT5hZGRyIGNhbiBiZSBndWFyYW50ZWVkIHRvIGJlIHpl
cm9lZCB0aGUgZmlyc3QgdGltZQ0KdGhleSByZWFjaCBoZXJlLiBIb3dldmVyLCBJIGRpZG4ndCBu
b3RpY2UgdGhhdCBib3RoIGRpZmZzIHdlcmUgaW4gYSBmb3IoKSBsb29wIHdoZXJlIA0KbWNlLT5t
aXNjIGFuZCBtY2UtPmFkZHIgY291bGQgcmV0YWluIHRoZSBvbGQgdmFsdWVzIGFzc2lnbmVkIGJ5
IG1jZV9yZWFkX2F1eCgpIGluIA0KdGhlIHByZXZpb3VzIGl0ZXJhdGlvbi4gU28gbmVlZCB0byB6
ZXJvIG1jZS1taXNjIGFuZCBtY2UtPmFkZHIgaW4gZWFjaCBpdGVyYXRpb24gdG8gDQplbnN1cmUg
dGhleSBkb24ndCBjb250YWluIHN0YWxlIHZhbHVlcy4gDQoNCiBJJ2xsIGRyb3AgdGhpcyBwYXRj
aCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQotUWl1eHUNCg==

