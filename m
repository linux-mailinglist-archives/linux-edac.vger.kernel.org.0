Return-Path: <linux-edac+bounces-2199-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B99AC088
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 09:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866381C23895
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254BD155391;
	Wed, 23 Oct 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXgB9wVw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEF433B3;
	Wed, 23 Oct 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669391; cv=fail; b=Ge8IS0sInqOl3QnNW9jx7NuL8E6EIjM1i6x2TcC72bCRqpjB43vAcq4Dfi5c91fYAdWGq3TMPOYcqccZTRDvBebL6eO1QAAFa1ISqAy0uwYKEZksGV9kQM9WAdIGaBGzHWRdKj9FW6cZgqoGLpSUQhk6X53+3HGp1d3/FdzgRz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669391; c=relaxed/simple;
	bh=9J/S5dRxXZUecyArUysRmPgZU4GshaceIKcm3o1Cj1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAm+RTGBfJ//vCIV4lZYIflPLjWoxVUDML0rjTABL7Wv2lJWcyMUmaJSibsVnZ5jy2dg7FFtfzwdJ6vf4XSIFK+3keLIYAw0i1g+pOzaaw11Hfr8rpB8lQm6bS5RI305dKJDUH+7NIf7NX+7GbErjjqukPYaF8Z5RMZxesEa9y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXgB9wVw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729669389; x=1761205389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9J/S5dRxXZUecyArUysRmPgZU4GshaceIKcm3o1Cj1Y=;
  b=bXgB9wVwVEbf+t5bgkgwdE1hpjAtBJc9zJQs0bhVVTBX6ImtqhlnobgJ
   oiYjIoVfOS5F3Cqdbd2aS4Z5UXzZUGQu0Qyg9MZIXtvbDceF8RKYjkvMe
   gaRhMP2AP0eHibL6Sf+kXHkJN94w9vRWzRyQHMlMcmfvy+v6KlE7pzkRY
   IHzaLpkn9mO95pM9/+uUdgWdyc0j7hjOPvTnuKeE5g5dbKy7oiMefiYPR
   IV2bodtwm4CDNlO6soSsGFsCdwYe1c2BUbPOeti4yxbXljMfEjt/b3BP6
   /a5P95eSBIjoyv9YkostJy9MmH6a58fZw1gqqI6HAQYf4ODvmBwsYbUOU
   g==;
X-CSE-ConnectionGUID: cXs0y9F0RiyHUVv/zYo4bg==
X-CSE-MsgGUID: vnYjmbRPTiCDlFWFpzpDdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29116404"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29116404"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:43:09 -0700
X-CSE-ConnectionGUID: sxARINg4STu+7OnuPbhCmw==
X-CSE-MsgGUID: d4jlof0LScqsUBQoPHyUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80123708"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:43:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:43:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:43:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9Q7OG1lewLvdcoGdP8ArV8biJdpOBcRcJ3VkP3B8chAFi4yaigWcQyGBYGq5RanmstZTFQdPu0h7SQfva3z0X8qLVYiZsHNOB0iMG1O+iaBYhh9pPlfwBwwLVMrJM1rLZmbzUmN1+8iboOc5BXqv27P2tidY3SBTlMcCeVi56h6WxPm1Rkl5o4q/WyuC8C7WZXTM2SpHyjModmPHCMKokDTwqvDrT25R7innTnfeiBy6mJ6+esmMW/7AqPLHVQ5f4IWmMNDU2m+G30XrJaE1IsKY1NxxvJglxwjAnH+AlLphtq6khyfJ83ayO73Jhy8GkloDK776NAHVqto/j90HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J/S5dRxXZUecyArUysRmPgZU4GshaceIKcm3o1Cj1Y=;
 b=yTHyZJdMmQj9VEGZAjCQjGgWIRSpdxm78cVh0tlslnBD9RM3zqoA534uPQUH1XTqE67WyfLlX1RfJnIdD5ON8QvIRxVaxNz4TqO+1x/prhAbK73gAGg/MgAEH3z9vX8+0fdF4jbvrskJqQJ7plzsFrazODG5KlVgKlhVfuKe0LRsmrjDkkkOkiF0N88J34aFDVFXZ0urfcNBVSFDTTXvBpt+/QZnHlTe3TXQuznLZxq9MClsGDave70mF/yb1XbOL31MI62yXrbqGsQHzHxX3hXEEultVYY11Rb7FKHICamEjLjiHRG5W1E/0XHkXzPBbc3UQwnqVERsbLNVywO6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 07:43:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 07:43:05 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony" <tony.luck@intel.com>
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
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAEAyAIAAVvpwgAZi84CAAAvg4A==
Date: Wed, 23 Oct 2024 07:43:05 +0000
Message-ID: <CY8PR11MB713409872B826AF7A527CB97894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <c3bb0055-49c5-4e0f-a9bb-8f56e862e11c@intel.com>
In-Reply-To: <c3bb0055-49c5-4e0f-a9bb-8f56e862e11c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5212:EE_
x-ms-office365-filtering-correlation-id: 3ff5a121-ad03-4f13-97ac-08dcf33654b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UzdnR29SU3dpNlFtY0NBVS9jSnFTUDUxWjBCeWEwQnRYRTFTamUrR0c4Sk1T?=
 =?utf-8?B?WVpFMC9CNWRpVDBmbHc4ak1wU2J5U04vYmIvKzR1WXFNdnBaTlVUWFhoaTlm?=
 =?utf-8?B?dCs2Qk0wcTkyUllqU3NWeHIrdSthOWczQ0tGRWVtNk1KWWQrWmhxTFl0VTdN?=
 =?utf-8?B?OXFWWEQzY0UyYWNZODEycDdFY3kycG1WQW94dE5ybWUvcGV0S21LZlFIYnJK?=
 =?utf-8?B?eWw5eEhiZUl3dDRUQlBJZmxNb056TFJSRENQSTltOWFPZUZXb2cvVGdFT2lG?=
 =?utf-8?B?ZW54cVBoTUFNUU1hbkxyenpyYU1BYmdCWDN2ZzdMNzBQdFlPcGg5NTJsNFlQ?=
 =?utf-8?B?T0xmcHJwT1FtTEdtWGhMcklvTDBlZ3NobkduNmQ4ZnhnVElRVEE4TkV1UUF1?=
 =?utf-8?B?RHBZZzR0MThRQndwcHU3K0djcXRja2VtR2ZhL2RaMk5JVFlYTGpPd0daelNZ?=
 =?utf-8?B?Q2tpRW54S1VXSG1sSkJjU3UwTUZGcjJhejJTYktmK3dtS0xOTjdKd0wyemlR?=
 =?utf-8?B?ajR5aFhCWnprMSs5ek1MMGxzK2xNTGNNR1VBakV1WmxPS0ZBZUdnTkdTc3pn?=
 =?utf-8?B?UEdZMWVtQXhYOHNqMDhLK21YVkwzVU9yN0xhNlpPd1JuU0NveHFaUmExTHB4?=
 =?utf-8?B?eGREbk41S2JnV2RjU1hmRnRETXp4bFU5bVZ0ZzA0SDN6T2RKSWNVRmFYa2VM?=
 =?utf-8?B?ZG93ZVVjK2FhSzBYUnQ3NCtNVjVlKzRZY3YzZ0o3OGhXcVliZHBaN2U3R1Iw?=
 =?utf-8?B?b2U5ZFBtM3d4V1hlV0NISXBaVVNVdUlDZEgwdGhSVEhLeFE5U3FHd2dueTJh?=
 =?utf-8?B?NTU2aTVmNHZKNlUrejU1Q2h1ZzBtRGloVnVKcVZibjdYcUlNM0VVUUttdnlH?=
 =?utf-8?B?N0NodUlueGR0M2k4cDRzWDlwWjEwWW5zWCtURU1iTDJUejJUdm1GWjBFbzda?=
 =?utf-8?B?cnRTWXJEWm54ZTg1UXZYTndldlRxMXhVQ0syN3h3Rm5nTjRkOXk1Ykl3cXk1?=
 =?utf-8?B?ek9VNlEwc3N6TXlLZzc1Z1RaK0tnU3cyWmwzeUZmYXhQaG9xdnRrOUlqUXRJ?=
 =?utf-8?B?YWVuYmVMVVNEb0x4bzNJZmYzQ1BybVJsZEkrNHR6d2Y5UnNYbkJ4S0labGtR?=
 =?utf-8?B?V3l2cHpTbS9qelpmNVJZV0hndjZiUUFlaWFMUkZWL0NwZEFWc0F0cUh6dVFv?=
 =?utf-8?B?NHMxU0lBRGI5blF0QUZCcmZYOXgrUmdtbkFvUlZ1UDVBNkJMaWh2dHZ5cGdi?=
 =?utf-8?B?Y0l5N3lXdzlXZy9LN1IyUE5mcDJrSmRYaWM2UGowK2hXN2JHN1ZkRWtkTTEr?=
 =?utf-8?B?b0xsektkUHJiSm5HZlZiNkFrZTcxSGlYbCtCaXUrUjBXUXh6UkQxYXlONWdU?=
 =?utf-8?B?dXdON29lenkzckdyQ05SSFo3K3o2dHBIU1NPOWs0MDV6bjE1WGVVeTEreXRI?=
 =?utf-8?B?Zko1SGIwODhSTnNJRDNMSjFiY2FVUGYvaS9uNCt0NTluUXA5RTVlQjdoTmdt?=
 =?utf-8?B?bk0xaDhuQm1MMnRKMmJIN3VaS0ROSlJaZnJvQUF2VnVwdlhmRGNzR3c4VTht?=
 =?utf-8?B?cHUza0ZYZjBkS3N4WllHZTFkQ3VXZ2hMZFVlclJmOGZBdkR1V1MrRm4xa2ZW?=
 =?utf-8?B?c0o0RjlQUmVhV2NvakY5TjVaQ1FjQXRaYmhIL3NvbnJ5bHZ0Nzg3Sk1pTFBN?=
 =?utf-8?B?alc4QjlUZXhBTDhYN1ZUMjA0WW91TUVmYmxxQjdad3N4aDdwVHdZS0FIV1Zx?=
 =?utf-8?B?bFVlcUFpNmtoa0FQWEtHWXg2QmNqb0pxSkNZOWlGcE9xMU9rTy9JdkZTWWR1?=
 =?utf-8?Q?SVLNp199BBZFfhwx6Pauy75hFPrivs/LcVQBc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU9QUEk0QmV0R2pvVTl0eGFmeTh6bmRPdlo5ZkIxczJ6eTRBdkNpU0xuZ1FQ?=
 =?utf-8?B?dXZwY3EyU2xBUDB1RmFnbHh0ZWlRQ2tubEpNN1V2eURQNkQyeXduSTJvanpI?=
 =?utf-8?B?YmJQN0RDSUJQRzZkZEZDYTFoR2xkQVFEc2E1M2FlZTFjWHptTjUvc01GSVpE?=
 =?utf-8?B?QWpzYmxwczgvSzdUUUxrVW9yWVFjcFhBM3FPODFzeFZ0SFFVSEUzYTA3Ry9K?=
 =?utf-8?B?UnFqdjFWVitQWVN5TDF3cHhLQUR6Q3pZSnByeE9HNnpHRWFSOUg3a1FLQVVD?=
 =?utf-8?B?VjI1NHZwbS9XSTBNTmM4bTdocDRoSGI0cFBCVmlhUlJNb0p0aGd0MDhLSFpJ?=
 =?utf-8?B?Zi8rempINGVCaldvbFRPOERIUkFLTVZFMmM4YXlyb1V2dVFUSE56RXRraXRW?=
 =?utf-8?B?YWVqMjlNdFlDWEU3TzB4N2V1czA3NzBpckZUTGRRL2IzZWJHRm5XVzkyK0dh?=
 =?utf-8?B?Uk4vV3dJZG5zMlZyTUFMUGNRYUMzSnkzamRFQUprKzdrZ0RXa0w5Yk95TFIv?=
 =?utf-8?B?eWpwclBpMkpCZkJ4R3g0WE1XbEZoRWs2Ynk0UTFyc25sSkFaRHZSRU0wVkdB?=
 =?utf-8?B?QjNNdnFieVVPaExuc2NTb0xqQWVReWFBSmx1cWt6Vi9vUEpOaFNTV0hwN3lT?=
 =?utf-8?B?MWFMRWMyRVBtc3ZjbGxGOEordGh0UFNUVkNRYzhmVUozSTIveElneGpKSkVl?=
 =?utf-8?B?LytEWFlSd0RydEU2VXdzRk9waXlsNjRjNzBaTWVwRjRFRXlEZFVXRmdXdk96?=
 =?utf-8?B?blNJWVdqNFVWaWV4YlowYUs1NU82TXZyUWswM1VGWWZpaUxRMlkvWnVXT1Fz?=
 =?utf-8?B?WFpTTDlIcWZOaDFxcTAwcGFLRDNWYVNjc1REVFp6cG1RdFRGZzk3SGV1VVBQ?=
 =?utf-8?B?c253RTRWempuVTBsVVNpOXBIV0Qza2paZDNvQ2FpYnVCZmJDYkErcEhaaG9k?=
 =?utf-8?B?VjhwMm1Ic3BsUjFjZzVFU3FDV0pqeDRWZ2dkN0J3SGJ1K3RjMkZLdkJNY29s?=
 =?utf-8?B?dk1YeVZXKyt6T1Jkc2xpNll2RXd6MlJZYVpmWDJVZmFRcUw0TE1wVkFFRHVi?=
 =?utf-8?B?V0FtT0dKSjlDSWQ1VHVJZGhvTEFQYzNHcmU1YUQwWXRCRDZxYmF5MTdyWjhu?=
 =?utf-8?B?SnlSZHlvWW9yMUcvdFFTNXNIcWtSYnhNZUprN2ovRXppMHVyNkF5bXFsemli?=
 =?utf-8?B?eWR0aE81Y3FXcEdvNzBhcjAyNmxHNC9PYnI0UEcvaWdnUW5qbnYvMHFUR1BU?=
 =?utf-8?B?QnZnUnkyQkVhbVpxQVlPbnZxcldOcmFoS1Z0NTlUUVg5UkY5Y2tTN1RrcjA3?=
 =?utf-8?B?ajFWWkJCekhJelM5Vnppd2lqOVZ1bG83akZYbmFIVHlrSkYwMktFaFdZRnVr?=
 =?utf-8?B?MCtZb2ovZVNtRlZCQTh3M2Z3NGNtMFloRXhZMkthZlZXVGJjK3EwM0VoWGgv?=
 =?utf-8?B?aFB3Y3NPZ1ViRGhDRWFPWWZKV2ZLblYxdVJIOTRtR1FKT0dVa2ZaSSt2c2ZY?=
 =?utf-8?B?N2VyOC9OZ0FuMjZzTDI3Mnp6TFJwaUc1MDRhR09rVEU4OUdjczlpZ2h0ZzFi?=
 =?utf-8?B?eUdCMWI1YXZ3WFV4Q1FpZkNZdzlmWDZtQlNGZ1dnNDZpL1ltdHNNajN4VFJn?=
 =?utf-8?B?MnBHUjlkNGRlUWdUVXdybnpDeExUMlBMUGVKVGljakFLSm1hK1lpaGNyMzVO?=
 =?utf-8?B?MU8wV0RSY0dqV2Z4ZG1xTDRKQkU1eUhjQklubG1ybTF1ZDJTdHpDcXhnSXpi?=
 =?utf-8?B?NmpJYjh6ZFNKeTBtakZMSUdzSzdMM1VRT01JU0Y5cTQ2OVJNUXh1cGFnZkRL?=
 =?utf-8?B?RzhPbGZzR1dGMk1TbUN2b1NCb2pLbkIrN3dLb0ZEUHFlb2ZOUjZ6RU9MSzFV?=
 =?utf-8?B?SHFtcnl0UUZnZjZ1NGdvSWQxeDVoWE1QMjRDMzBsVUNtcnpZd0FEbW8yVG5p?=
 =?utf-8?B?ZnJZM1B5OW02cSsyYVdRbjJ5aHIrUW8weUUya1NxM0VCeWhRaUdnTWptMXJx?=
 =?utf-8?B?TEFlcjRzOGk0RTkxWFExdjhnZkhFY04wcXFEVTJZOC91d0h5RnIrSkpDRkZY?=
 =?utf-8?B?VUlwUS96eVZ2VGNnVzliS1V1U3hFZFBNR0ZKZWQ0OFFuTmtzY0JGbFI0ejBT?=
 =?utf-8?Q?3YQDdSyC+zuzR3mSDlVfmy2/D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff5a121-ad03-4f13-97ac-08dcf33654b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:43:05.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPhjbFrDNtRaxfNotInkbvbcOG5rr20QNjDMMz+4Vj+QY5iP/h+eQfDazd8fMpjOpbUCdZWaqmfOcCuu8VQKcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
QXMgRGF2ZSBtZW50aW9uZWQsIGNoYW5nZSB0aGlzIHRvIG1ha2UgdGhlIHVzZSBvZiB2Zm0gY29u
c2lzdGVudCBpbiB0aGUNCj4gZW50aXJlIGZ1bmN0aW9uIGFuZCBwcm9iYWJseSB1cGRhdGUgdGhl
IGNvbW1lbnQgYXMgd2VsbCB0byBtYWtlIGl0IGV4cGxpY2l0Og0KPiANCj4gCS8qIE9sZGVyIENQ
VXMgKHByaW9yIHRvIGZhbWlseSA2KSBkb24ndCBuZWVkIHF1aXJrcyAqLw0KDQpZZXMsIHRoZSBp
bXByb3ZlZCBjb21tZW50IGlzIGJldHRlci4NCg0KPiAJaWYgKGMtPng4Nl92Zm0gPCBJTlRFTF9Q
RU5USVVNX1BSTykNCj4gCQlyZXR1cm47DQo+IA0KPiBbLi4uXQ0KPiA+IC0gICAgICAgaWYgKChj
LT54ODYgPiA2IHx8IChjLT54ODYgPT0gNiAmJiBjLT54ODZfbW9kZWwgPj0gMHhlKSkgJiYNCj4g
PiAtICAgICAgICAgICBjZmctPm1vbmFyY2hfdGltZW91dCA8IDApDQo+ID4gKyAgICAgICBpZiAo
Yy0+eDg2X3ZmbSA+PSBJTlRFTF9DT1JFX1lPTkFIICYmIGNmZy0+bW9uYXJjaF90aW1lb3V0IDwN
Cj4gPiArIDApDQo+ID4gICAgICAgICAgICAgICAgIGNmZy0+bW9uYXJjaF90aW1lb3V0ID0gVVNF
Q19QRVJfU0VDOw0KPiA+DQo+IA0KPiBJbnN0ZWFkIG9mIGtlZXBpbmcgdGhpcyBvcGVuLWVuZGVk
IHdlIGNvdWxkIHR3ZWFrIHRoaXMgYSBiaXQgYXMgZm9sbG93czoNCj4gDQo+IGlmICghKGMtPng4
Nl92Zm0gPCBJTlRFTF9DT1JFX1lPTkFIKSkgJiYgY2ZnLT5tb25hcmNoX3RpbWVvdXQgPCAwKQ0K
PiAJY2ZnLT5tb25hcmNoX3RpbWVvdXQgPSBVU0VDX1BFUl9TRUM7DQo+IA0KPiBFc3NlbnRpYWxs
eSB0aGUgc2FtZTogaWYgKG5ld19jcHUpIHZzIGlmICghb2xkX2NwdSkgRG9uJ3QgaGF2ZSBhIHN0
cm9uZw0KPiBwcmVmZXJlbmNlLiBXaWxsIGxlYXZlIGl0IHRvIHlvdSBhbmQgVG9ueS4NCj4NCg0K
SSBwcmVmZXIgdGhlIHNpbmdsZSwgc3RyYWlnaHRmb3J3YXJkICc+PScgb3BlcmF0aW9uIG92ZXIg
dGhlICc8JyBhbmQgdGhlbiAnIScgdHdvIG9wZXJhdGlvbnMuDQogDQotIFFpdXh1DQo=

