Return-Path: <linux-edac+bounces-2233-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755309AE5A8
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68581F24D42
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E799C1D9A49;
	Thu, 24 Oct 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f30d9R4m"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605451D9A65;
	Thu, 24 Oct 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775165; cv=fail; b=M9o2uyZOpAoeddSQgaVU3pc3dd1xzjm4Ju9wwPGAf1tj+EvzpVY3B/BD+xihrURlsBHQktHdbWhsUYgwWELgW2iM+XQ9AExPqqpEhAv6IYwGcZFSfQF0osHu7KU5CrieKOp6y2MVQBhz+sno+LDUFwtkn26PfLvbhEjE/4hLx+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775165; c=relaxed/simple;
	bh=0smr3GihlVywopjZkPTtEGP3o2jpHz6IR0xit9WDtPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t0OuDsRfFoWuNfj7dB3D2rsUT93V0vPnWCq3yFT9j31RYGTsXHMJ4V/Ws+VjnBSwM7nvJiaza7K0G7FYQux0bDxIdBl01tCcHKUg0HoSgkUXrChe/jKNjie9Hojnx4eXkdCv/wbUd92syQscgUeDmU1ymSiU2BxrXJS9mxeNZSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f30d9R4m; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775163; x=1761311163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0smr3GihlVywopjZkPTtEGP3o2jpHz6IR0xit9WDtPc=;
  b=f30d9R4mbuIY1r91cAIv43IrZQAA3Es/BrSJK54fSSQLYVur7spTlIhh
   19dWysfK16nw99U8ZFMJfEQHz2PZpKJQM+4tivoPLJD+WuOpp9Nj4hrC6
   awLAQwhp3Z7oSc++oTZwgkyP7d9LwHEPU9GQ5s3Ce9upZ5xMrXnfEL2wY
   r+kpe01ZD6+Vw/SkjDyVVjZVyv+JtLs5lmZrkJMHw9Ja3iZvqgjqovc/k
   Y3sqbci4dUjWovxkZRhBrhm3GpmeNRr8MUoVC8j56A+srefdKqAucCt4F
   vlua/NoDRZCX2/UR9Vnvi4wDEu7z43GrYCR4mYjM14nlYpsRk5IFX9pH5
   Q==;
X-CSE-ConnectionGUID: ++//0nKQQEyeyh5lZZV5NQ==
X-CSE-MsgGUID: j96QX/ycTeah9S6etdt1OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40795484"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40795484"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:06:03 -0700
X-CSE-ConnectionGUID: U8l+5dQUQaSxTpNyX+/FKg==
X-CSE-MsgGUID: fyFD4zlsQyWfTroiMReVqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="103899098"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 06:06:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 06:06:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 06:06:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 06:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lswNY2iZlqBAoZUMVst29rcQgOyEerYjSJzpxIZSvZQsnIYo0RK1p2ERgc6MVifcsGXrGTcKDwePqsl7BitPtEadVXlpVp5BOLpvucIBg97ygFKgCHyBYKmlMNsM0/0DSfIbJRkrYhISUAfLgJ1bF6V1bSz94cX9JJdhhEWyhoqbphVpDutOKj+1EO/lrKEh/TmzLKFOZ6/ydnk9FIFcy5tUpygbLxtnyTXOlnNvK8pzVODjdD2Wbrlu/0pG9Zh/5XH48SBpu1agi7PJng1LBXhBbVO9zAMmqDJyOFCKcrWIGFszA5gcQ0CQq+OhWAU8X19l1Fou7mXN5CjHsQgI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0smr3GihlVywopjZkPTtEGP3o2jpHz6IR0xit9WDtPc=;
 b=KkziRTN+14JuOUd7MQPPXKI6BcfEaqnkONaM5npn0wDLpyYh/fH8y9Eppt19Km+xbwjyAoosrITkd6ZgZJlNE3YUcgBnX5HGSoYfrCioafelAydgnpopXA1CDXhFg5XeKnlLuL7Yu08iNm4183iLtdv6OIglPSI4JsidfD5y2mznxMs+7G6yCLJNBL0F0olgAjXmE9bNd+/Mtkzm2pGhE6kaXbo4uAWpMPLd3Nuzd8MmtUjtenE/d2dzhpye8xRcxL0TLkTYB85p4aVHt+dVmD15LQFT8y26ItFnhNEpFR6Cmgsisq+l6EFzloKs00p25JfQtuNJINwVlO0D6FBN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 13:05:58 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 13:05:58 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>
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
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAEAyAIAAVvpwgAPafYCAAAbqAIACmD2AgAE5VEA=
Date: Thu, 24 Oct 2024 13:05:58 +0000
Message-ID: <CY8PR11MB7134DED56F51E59273F3B063894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c9ffb6b0-9c75-4990-afb5-33094d049570@intel.com>
 <CY8PR11MB7134E2BD84013EF41F8F5AC8894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134E2BD84013EF41F8F5AC8894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: dave.hansen@intel.com,tony.luck@intel.com,sohil.mehta@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB7114:EE_
x-ms-office365-filtering-correlation-id: 1864a9b2-63dd-4c4c-96c5-08dcf42c9a7b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WWNjV1dhbXpsMUtrMFhqSlNZdmF5bUpHMHY4ZTVuSVNXT3gwQ040R2dGMytn?=
 =?utf-8?B?K1VSMnREM0EvcGJOTDFCZWJybG5wTENwTlRGWFMxbnhhaGc2QjFRaWlrQmg2?=
 =?utf-8?B?a2h4ZFNMY1FvTDJCbVgyNzRXS2J1R2FzYU5pbzhqbHg1UW1MQzFvZ1JiL0pO?=
 =?utf-8?B?L2NPK29iOGVzNisvdEhmSGZGR2JHcTFPaTBGZ2w2TkJ3c3N4czNUOXJXb21r?=
 =?utf-8?B?UlV1a0VjVUdvUmt2eXhIbS9ZQ0FaWU5IYnJ2MjhoQjZUNUp6MWpYU2YxdkRq?=
 =?utf-8?B?aGxYZUU5b2k2QnlIM29oYm9Hbnc2TENzVE9zVlVwNEIxL0N6NUFlbmN6RHpE?=
 =?utf-8?B?YmZJQU83NVNUZWlKa1FWM1U1MXZ2RjdNVzZGM2toZ0tqYW9JZ0lEelJTeExQ?=
 =?utf-8?B?ZjkyMTB0UDZGVnFIbHNucERIVlpTbWNldHhreVk4aWhoMEtXbHVjUm1ZTkY5?=
 =?utf-8?B?L2pRL1RkT2V0VUhuNkEzMVdkRnBiT0xCVnhhVnhIQnA3ZnVDY2I4ckpCcjZC?=
 =?utf-8?B?TTRLVk1HcmFCUGVwSkxtVm9BdTlOQXYxZjljRmxjanVXVzg1K2MxNDltdEw4?=
 =?utf-8?B?cnJvcFgycE1sVU43RjdCTzhSN1FzVDZReHVydXBTUzlHNDB4bmZKUEpqc1c5?=
 =?utf-8?B?L3NaYkdaT0k1ZjRXdjVDRlZ1SkR6VHorVTgxRWppT1EzQ1lHVDdDTzBWdmpv?=
 =?utf-8?B?MWRaZWhlb3BUSmEyeUlZekE0STJpb3dvZnp1QkRxOGswS0ttWGhLTmF6Mkt1?=
 =?utf-8?B?eUpYRFBwNUhCdXpBUzNqY2l3MlJsZVF3Q0hTbVgxZXNtVFlUOWFJdXYyQ0lQ?=
 =?utf-8?B?bzJEc1ppcEN2Q1g0dDhKMWdNdjJJOS9EelBZR3kwNkhnNFJQY29tWGY4UWM1?=
 =?utf-8?B?VHd1bHFqcWlmSyt0RzZ1b2huRjJ4eEkxNi9LQlU2QjFTWEdaeU1PU2JLdlZo?=
 =?utf-8?B?cXdkbVdWb1B1b3lPT1djR0hCNlc3eXR2K1g3RTczVHU0WTQxNDhwMGVYYUdn?=
 =?utf-8?B?Tnl4SlFndCt5cUE3WS9RbnZmVHVwUGx6cExSNGVYVFZ5eUcxREFUVjJ2aTVG?=
 =?utf-8?B?K0dRK0hrdTIrdWhoOTd6QUtJdWs3QkxDajZ1b3JJK2xiZGkySnhOSE5qNjVJ?=
 =?utf-8?B?eDdvNGdjOTdxY0h5UFRrb2lZT0NDbFhSNWo2RHhaTVF0NnR2clpxM09yTFh5?=
 =?utf-8?B?TU4rcGVJWllIbkdka1Iwb1U1cXFRWkVEOVRGcERYL3pDa2tGdCtVbkUwcElI?=
 =?utf-8?B?SGtuTU9kSnROUUo0c2RNVUJsZ01vUExiT3phQmFza0FQVmJsbStWMUlkOWhG?=
 =?utf-8?B?VGZmZjlaam5XMlJXK0hsQ2t4eUpWM2FVaituRVM4TFVxYlpYekVlZUtWVFVV?=
 =?utf-8?B?VHRYV0Q5Z1NRd0VidVc0a1ZleGt1emVlT2lXYVp0SnFSMVQvK2VEU0VmcERP?=
 =?utf-8?B?bUc3RXUwQWZsK05PSlhxQjFDaFpOMWY1S3Y1VVdma013YlJKamRMazUwOEM1?=
 =?utf-8?B?bWIxWklmTnE0c282eE1XaUtTMmlyY01MOWJvU1l4SWh3UEFLUFhWUmFlZ21O?=
 =?utf-8?B?WXYyZXdNNitxYlhwbSszMU85QWM2c0t6b0JrMkRKMWRSeDA1R24rSUN6SGt0?=
 =?utf-8?B?alZjRUErdkh3OG9FUW40SEhGN2dCaklyMytnZjhsbmFtbUxjeGJ5eTBmZEl1?=
 =?utf-8?B?QjJNcm1CN3hZcHhJRWRVc3dNbFdwWTVSYmxENXBDRk5BS2s2SHJnWTAxRmdB?=
 =?utf-8?B?OTR6YlhoRVkzaTlsY2krVnBhNWVDUEpsRXEwYlQrZVBaRysxM0JJaXZ0YmIr?=
 =?utf-8?B?WHJJc3NUN1pTRzRnaGdQUHdPc2pzeGJBVW9mSS95Z1BGYmNRY0pGNllSWGJa?=
 =?utf-8?Q?Z2pbZGO2MPXTq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejB6Wk9sR0RoU25va3dDN1IzVmkyczc0NlJxMFpJblVacXpzb3NYSmM1Q1Bp?=
 =?utf-8?B?TmVXdWdUTE9ESmp0Y01xdU9VMjFXNEsveUI1UVlwR1BDeHhMNzFIVEsvQUE4?=
 =?utf-8?B?SkVkK2REZWFvdk9zc1V5VmdyMW5Cd1k2OWRZT1R1aXVDSTVIamxySHlSczZa?=
 =?utf-8?B?YUozZjRsenlXZW9BTGlmb2xwV1pBaEFoNmsweVBBMlNsd0NmTzF0N1NBWXRZ?=
 =?utf-8?B?VGRuaGxHcHlQbHdsVzlJYlVYNFBGRTBoaGR4R1cwQVM4WXo3SGNLdkFWK1pK?=
 =?utf-8?B?aGNUN2o5b1hCYjZrcEhDVTc2U3FsRVVvRTUvUkVNQmNMQVliVEhkbk10Z1NW?=
 =?utf-8?B?VVhHRzhiTnI1UEhURlFyMzZBK0ZCN04zRkYxSXVveUhUSy9ET1piM0NFa1Q1?=
 =?utf-8?B?dks2am1FZlArd2psN2hmaG9TTmk0NzJ5Z2UrazNwS2J1eGl0bGtycmR6Qzgz?=
 =?utf-8?B?cW9IKy8wRFBQdWlDK09zUnlZcVZYVCsycnMzNlV5SnZoK2ZtRU5KamU1UVlU?=
 =?utf-8?B?eTV6U01YT0tMcXpiZS85RXBnOXpqMEt0TVcvdXRQSnM4RlJJMVdocFpnOHhp?=
 =?utf-8?B?YUg0N2tSTmJ6aEg5NksvM0t1RElNUDVvclM4RG02S1VkaFZ6ZTFJOE44L0Fi?=
 =?utf-8?B?ZGt2MmR6T09CVm9CaDZCUWtuU0Ryck1YSjNwUFhYZG5XQ3doZjJBT1p2QTRI?=
 =?utf-8?B?L3B5d3NRcWNMMkVyZ0V3enZsMWFCT28rUGZJNm0xWjU2UW1mdTlHWStGdURU?=
 =?utf-8?B?THJDSTRXbGUxbkRnM2M2elM1QmpOcDA1VmJ6SW11dDNoTXhKRGowR1d2RklU?=
 =?utf-8?B?ek4vMGZWVElOS0dQeDhQQUp0WFozcGx1SUZzUDNWL3RQNnU4MGZMYjhxcTZK?=
 =?utf-8?B?bEt1WjlmWWVxLzBTQWo5L09OTHhiNW5jRzBBRWdBNWVweU5tb0pjdXNBL2Np?=
 =?utf-8?B?ZkZDWmswYWJXWS8xbkxpSURDck1TNFlXbUlMMDFMb3BpeXBMcGpjZlRDTVZx?=
 =?utf-8?B?WEorRWpYdlpoTXlOb1RLMUlBbTZKc2dJSGl6UEFBUjdIeXpBdEFxR0JzRTFP?=
 =?utf-8?B?dUg0dWR2TjFvdFI2Yk93ZFFFR094MUFQS0JaV28zVUptOElCWW5rYzdaWjJn?=
 =?utf-8?B?bTA1WUs2VWlxYnR6cmt1eExOWkw5VTlIb3Q0MVZDaDVvZXRFWTYvQnlyRjNC?=
 =?utf-8?B?UUhYL3cyNTJ4Uzhramw4WU9DdFp2VWtHbk52Rko0N3FOUUx3L3ptTUVSTXVp?=
 =?utf-8?B?Z1lZMVV3SVFzWUNBTkJURkFtWFFoTjhvWHdHQ3hEVHBvNUJYd0ZHbHhQL0Fq?=
 =?utf-8?B?THZ6UGpnMlZ3RlRGcytHbFQ1MWxSdGtpWGdYSUVDREI2M1Y1ZlNZb1ZKMU5V?=
 =?utf-8?B?aFRFYktHT0d0UHhuQ2E0aHpxbUVGanNiZkxCWE82TEtjQmlDcS9RcWRiNG52?=
 =?utf-8?B?VnhnRGd4b1N6bjRJUlhhdVB3akNTWVBmK0RSVHNUWlpibzFBNTFQbzRWZmFE?=
 =?utf-8?B?OWg0dE5ad1ZObm1wMTN5VDBvZC8yakhpNlBrbGtnRlBXY0hyWlNVOGh1S2xn?=
 =?utf-8?B?dGUxdnJGVVBkVWJsUEc0UVV3MWtab2VLSDZPSjdGVjd4cy9sZE9vMmU1V2hx?=
 =?utf-8?B?QUprUjBUcUZMYUdrOFZsYTZrQm51bytlbC93UnRtUnEvTmNqUU1IRVVWQ3BZ?=
 =?utf-8?B?ZEliN1ZoRHFyNnFNYWtmTUE1NUJBNXZ3MDdraWxwTmNXQmZKSkt0ZFEzMWcy?=
 =?utf-8?B?YTVlOVpSdmpyWGpta2tyZnFTMDRZOVArWnJyZEUzbGJ4b25tYyt1anR3anNj?=
 =?utf-8?B?T0V2bFdDRzZ6N2UvbmlDU25ER1RRM3VZZFcwMmtZRzd0R3phbUZveHB6aUlV?=
 =?utf-8?B?WjNoOVhSMzA3QlhUSDAvSGdIb3plNVdFZ0xlTll2UG42ZlhNS0I4eEJ2Vnpi?=
 =?utf-8?B?T2oxN1VDNkpWc0EvbklNaUg5UzZJL0t1VVFSWDkyWG03cjVvVEdFT1ZjdGR1?=
 =?utf-8?B?eE9sNmNvTUV3dllwRkFPN1hXSlE1WDlpR0JGelEyWi9Ic3FBeDlsTkp3bEdW?=
 =?utf-8?B?R2U1RS8yMkZvQnNrd1lXKy9MSFhXT0dmempCVDBBSC8yVWR1SE1QU0tQNk0y?=
 =?utf-8?Q?NNs6QfuIISvTnkR80d6jnML7q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1864a9b2-63dd-4c4c-96c5-08dcf42c9a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 13:05:58.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKzfCPqmYP60Xv/wZMfUZb9W09cPBmGfEoEXFCr/2BGHxezi5bjifc0VyZ1g0KwHOiXgFPTSrfb8B6KL+7A+lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com

PiBGcm9tOiBaaHVvLCBRaXV4dSA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQo+IFsuLi5dDQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMDYvMTBdIHg4Ni9tY2U6IENvbnZlcnQgbXVsdGlwbGUgaWYg
KCkgc3RhdGVtZW50cyBpbnRvDQo+IGEgc3dpdGNoKCkgc3RhdGVtZW50DQo+IA0KPiA+IEZyb206
IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiBbLi4uXSBPbiAxMC8yMS8yNCAw
OTowNiwNCj4gWy4uLl0NCj4gPg0KPiA+IEl0IGNlcnRhaW5seSBpcyBhIGJpdCBzdWJ0bGUuDQo+
ID4NCj4gPiBUbyBtZSwgdGhlIGVhcmxpZXIgY2hlY2sgd291bGQgYmUgZXZlbiBiZXR0ZXIgaWYg
aXQgd2VyZToNCj4gPg0KPiA+IC0JaWYgKGMtPng4NiA8IDYpDQo+IA0KPiBUaGFua3MsIERhdmUu
DQo+IE9LLCBJJ2xsIHVwZGF0ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiBBcGFydCBmcm9t
IHRoaXMsIEknbGwgYWxzbyBhZGQgYSBjb21tZW50IGJlbG93LCBhcyBzdWdnZXN0ZWQgYnkgU29o
aWwsIHRvIG1ha2UNCj4gaXQgZXhwbGljaXQgdGhhdCBpdCdzIGZvciBwcmlvciB0byBmYW1pbHkg
Ni4NCj4gDQo+ICAgIC8qIE9sZGVyIENQVXMgKHByaW9yIHRvIGZhbWlseSA2KSBkb24ndCBuZWVk
IHF1aXJrcyAqLw0KPiA+ICsJaWYgKGMtPng4Nl92Zm0gPCBJTlRFTF9QRU5USVVNX1BSTykNCj4g
PiAJCXJldHVybjsNCj4gPg0KPiA+IFRoYXQgYXQgbGVhc3QgbWFrZXMgaXQgbW9yZSBjbGVhciB0
aGF0IGl0J3MgYSByYW5nZSBvZiBtb2RlbHMgYW5kDQo+ID4gYXZvaWRzIGhhdmluZyBhIC0+eDg2
IGNoZWNrIG1peGVkIHdpdGggYSAtPng4Nl92Zm0gb25lLg0KDQpIaSBATHVjaywgVG9ueSwgQEhh
bnNlbiwgRGF2ZSwgQE1laHRhLCBTb2hpbCwNCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUgZGlzY3Vz
c2luZyB0aGUgVkZNLWJhc2VkIGNoZWNrcy4gDQoNCkkgbWFkZSB0aGUgcGF0Y2ggb24gdG9wIG9m
IFRvbnkncyBbMV0gYmFzZWQgb24gd2hhdCB3ZSd2ZSBkaXNjdXNzZWQuDQpJJ2QgbGlrZSB0byBh
ZGQgdGhlIHRhZ3MgZnJvbSB5b3UgdG8gdGhlIGZvbGxvd2luZyBwYXRjaC4NClBsZWFzZSBsZXQg
bWUga25vdyBpZiB0aGVzZSB0YWdzIGFyZSBPSyB3aXRoIHlvdS4gVGhhbmtzIQ0KDQpbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1p4TEJ3TzRIa2tKRzRXWW5AYWdsdWNrLWRlc2szLnNj
LmludGVsLmNvbS8NCg0KRnJvbSA2ZTg4NzQzZjA2MTlhOTAyYzZlNmY5ODViOWZjOTM2NjkwOThi
NGFmIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogUWl1eHUgWmh1byA8cWl1eHUuemh1
b0BpbnRlbC5jb20+DQpEYXRlOiBNb24sIDIxIE9jdCAyMDI0IDEwOjQyOjIzICswODAwDQpTdWJq
ZWN0OiBbUEFUQ0ggdjMgMDcvMTBdIHg4Ni9tY2U6IENvbnZlcnQgZmFtaWx5L21vZGVsIG1peGVk
IGNoZWNrcyB0bw0KIFZGTS1iYXNlZCBjaGVja3MNCg0KQ29udmVydCBmYW1pbHkvbW9kZWwgbWl4
ZWQgY2hlY2tzIHRvIFZGTS1iYXNlZCBjaGVja3MgdG8gbWFrZQ0KdGhlIGNvZGUgbW9yZSBjb21w
YWN0Lg0KDQpTdWdnZXN0ZWQtYnk6IFNvaGlsIE1laHRhIDxzb2hpbC5tZWh0YUBpbnRlbC5jb20+
DQpTdWdnZXN0ZWQtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQpSZXZp
ZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
UWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQotLS0NCiBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9jb3JlLmMgfCAxMSArKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCmluZGV4IGJi
OGIxMDAwZmEwYS4uOTM2ODA0YTVhMGI5IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvY29yZS5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCkBAIC0x
OTI0LDYgKzE5MjQsMTAgQEAgc3RhdGljIHZvaWQgYXBwbHlfcXVpcmtzX2ludGVsKHN0cnVjdCBj
cHVpbmZvX3g4NiAqYykNCiAgICAgICAgc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgPSB0aGlz
X2NwdV9wdHIobWNlX2JhbmtzX2FycmF5KTsNCiAgICAgICAgc3RydWN0IG1jYV9jb25maWcgKmNm
ZyA9ICZtY2FfY2ZnOw0KDQorICAgICAgIC8qIE9sZGVyIENQVXMgKHByaW9yIHRvIGZhbWlseSA2
KSBkb24ndCBuZWVkIHF1aXJrcy4gKi8NCisgICAgICAgaWYgKGMtPng4Nl92Zm0gPCBJTlRFTF9Q
RU5USVVNX1BSTykNCisgICAgICAgICAgICAgICByZXR1cm47DQorDQogICAgICAgIC8qDQogICAg
ICAgICAqIFNETSBkb2N1bWVudHMgdGhhdCBvbiBmYW1pbHkgNiBiYW5rIDAgc2hvdWxkIG5vdCBi
ZSB3cml0dGVuDQogICAgICAgICAqIGJlY2F1c2UgaXQgYWxpYXNlcyB0byBhbm90aGVyIHNwZWNp
YWwgQklPUyBjb250cm9sbGVkDQpAQCAtMTkzMiwyMiArMTkzNiwyMSBAQCBzdGF0aWMgdm9pZCBh
cHBseV9xdWlya3NfaW50ZWwoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KICAgICAgICAgKiBEb24n
dCBpZ25vcmUgYmFuayAwIGNvbXBsZXRlbHkgYmVjYXVzZSB0aGVyZSBjb3VsZCBiZSBhDQogICAg
ICAgICAqIHZhbGlkIGV2ZW50IGxhdGVyLCBtZXJlbHkgZG9uJ3Qgd3JpdGUgQ1RMMC4NCiAgICAg
ICAgICovDQotICAgICAgIGlmIChjLT54ODYgPT0gNiAmJiBjLT54ODZfbW9kZWwgPCAweDFBICYm
IHRoaXNfY3B1X3JlYWQobWNlX251bV9iYW5rcykgPiAwKQ0KKyAgICAgICBpZiAoYy0+eDg2X3Zm
bSA8IElOVEVMX05FSEFMRU1fRVAgJiYgdGhpc19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKSA+IDAp
DQogICAgICAgICAgICAgICAgbWNlX2JhbmtzWzBdLmluaXQgPSBmYWxzZTsNCg0KICAgICAgICAv
Kg0KICAgICAgICAgKiBBbGwgbmV3ZXIgSW50ZWwgc3lzdGVtcyBzdXBwb3J0IE1DRSBicm9hZGNh
c3RpbmcuIEVuYWJsZQ0KICAgICAgICAgKiBzeW5jaHJvbml6YXRpb24gd2l0aCBhIG9uZSBzZWNv
bmQgdGltZW91dC4NCiAgICAgICAgICovDQotICAgICAgIGlmICgoYy0+eDg2ID4gNiB8fCAoYy0+
eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsID49IDB4ZSkpICYmDQotICAgICAgICAgICBjZmctPm1v
bmFyY2hfdGltZW91dCA8IDApDQorICAgICAgIGlmIChjLT54ODZfdmZtID49IElOVEVMX0NPUkVf
WU9OQUggJiYgY2ZnLT5tb25hcmNoX3RpbWVvdXQgPCAwKQ0KICAgICAgICAgICAgICAgIGNmZy0+
bW9uYXJjaF90aW1lb3V0ID0gVVNFQ19QRVJfU0VDOw0KDQogICAgICAgIC8qDQogICAgICAgICAq
IFRoZXJlIGFyZSBhbHNvIGJyb2tlbiBCSU9TZXMgb24gc29tZSBQZW50aXVtIE0gYW5kDQogICAg
ICAgICAqIGVhcmxpZXIgc3lzdGVtczoNCiAgICAgICAgICovDQotICAgICAgIGlmIChjLT54ODYg
PT0gNiAmJiBjLT54ODZfbW9kZWwgPD0gMTMgJiYgY2ZnLT5ib290bG9nIDwgMCkNCisgICAgICAg
aWYgKGMtPng4Nl92Zm0gPCBJTlRFTF9DT1JFX1lPTkFIICYmIGNmZy0+Ym9vdGxvZyA8IDApDQog
ICAgICAgICAgICAgICAgY2ZnLT5ib290bG9nID0gMDsNCg0KICAgICAgICBpZiAoYy0+eDg2X3Zm
bSA9PSBJTlRFTF9TQU5EWUJSSURHRV9YKQ0KLS0NCjIuMTcuMQ0K

