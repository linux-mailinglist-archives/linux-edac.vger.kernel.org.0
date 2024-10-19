Return-Path: <linux-edac+bounces-2149-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78759A4B0A
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A40B219B4
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736861D0DC9;
	Sat, 19 Oct 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4jll2VI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D691D0168;
	Sat, 19 Oct 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729306822; cv=fail; b=d+YwXd8nCIvnKO0b1W3T+/gUtp99Jckw6H/B+eZMwjL/S0NmzfuPiuE8sXYt3wEmHp34ATUab3LhS+d8tFMFRn31oIn7XPII1E9eI+2aA3sz69oS0NTpRNwPFgCF3JP1pStKKc4dgVPENMdXE+9C/G8wG9qXsc+UkmILxz/XNak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729306822; c=relaxed/simple;
	bh=l4r4UlgUiaBcU4qYJ0yQeKg4bTicJtNyh+0l0b43BO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVaI6rHMdCkVz+iCY/3TjBKuGefa008Zw35i8XGSsfL8Xap9kTgVJKdfJJJrZRT8QxhMSc5agrUukMa6nA+lx9q1pMciPXnzzuoHyG1NuThEJeTWl0EWEoVspsboigy8Sf4ZdKLWTs2gdsl5f4xv3k7/XA1rlY5rZxpPQHCl5lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4jll2VI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729306820; x=1760842820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l4r4UlgUiaBcU4qYJ0yQeKg4bTicJtNyh+0l0b43BO4=;
  b=M4jll2VIRAbbxAKu6fHSyJFYxZhbI4Tj6pJx9Qg1106l2MkuoIGVUwUp
   o0fVPwTOeAok90U75NFKDxTtLDzO10oqgghm1IMNcCFZRxazG3oax8MET
   wxoBnqpU508BxhkgWpe9AagDZLyo3qCjNI9mIyQSD4PNvbu4LXs4DYyZk
   q/EtDxhxw0izkWtFQ+iqpLc86zWgdt7gVTlUlQLLGq/Mu/GVnu0dHG33V
   JYOSwIcBNVNpALhOnDptZoKLcP2ElKljxcARZGEeBZsLpYMzE82ioVfei
   C+yofH1RRjrQmjHXzwjXJXtTXNjggbs/H5fmRDGATB+ATA2QkgQ5mOEc0
   A==;
X-CSE-ConnectionGUID: ycNMENF7TWuBOkE9C29ZYQ==
X-CSE-MsgGUID: gtZRrRr2QtCwi95rg9dSTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28942219"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="28942219"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 20:00:20 -0700
X-CSE-ConnectionGUID: 1DP+kpquTn+64gEwh7A5Mw==
X-CSE-MsgGUID: YhZr5gXdSqqYLPLUVTcrzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="109860804"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 20:00:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 20:00:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 20:00:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 20:00:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPOmImFqRuKUuE2iidDZ5n+XA9HAZaeNM6fo/XPAGmrNdAD6W6mkfNGIs4JFHrWTb8YNEPTbv5Dtm7gwWaYMOtTdZ0+uAysuSZyZk0lR4eMdjn3THcQnWiNuiGTxgJqCqZ/mAI+pvfxfOpMsz8ozI89v9xpsaeoF/WwoFs4VVZhtjRowxCN6bm1nEJZ/bmbCRL1z3gyGV6gyP6sqoHNuuvt1jMUI4ppG2/MQFAsGniIBzFhQ6bpRMoG7BkR8ZKN8GiH43s8fp5KYBLEM4E/3LXLFqQvOd+RkpIRAco0ia72VZi5Ib39tA5Ypd83rPcLk3acFcI1kOky7bQYPSPO6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4r4UlgUiaBcU4qYJ0yQeKg4bTicJtNyh+0l0b43BO4=;
 b=R1iNdcv5pn71f/pVYNpk9B48wE8gYqyh0etqZCvnL9bXgshy+aKGwIfq1TErhaqR6DDEFyeW0kRLUTEbVjF7ewlfhBwhwxRlh3aAAs07VoapP7o7+Lh0ZXlz60OQMeG0J5zuf8PtK2LIxCP96qFTJiLlc+nI6cckmNuDDJdRmjodJxu9Q37iRAuzBqiL/DCXrqbg4qe+W6TaDXDmZDv3BhN6pXujdvK3Zt6rMuzENovuk7DUf1mnS0pYBobs67knU/lZ/ujy0dnamq1d28ZTvImVgaWNqOSteze2G4W7pAzbgg6Ktc/3Vaw2xXU7L/UcC3YqUARGKLRbZevQhoOMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Sat, 19 Oct
 2024 03:00:16 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 03:00:16 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/10] x86/mce: Make several functions return bool
Thread-Topic: [PATCH v2 03/10] x86/mce: Make several functions return bool
Thread-Index: AQHbH8qAPZNcr7aYBE+5OE0Co2cZQ7KM4QsAgACCoRA=
Date: Sat, 19 Oct 2024 03:00:16 +0000
Message-ID: <CY8PR11MB7134681D1C16EEFFA37F9CED89412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-4-qiuxu.zhuo@intel.com>
 <abb86e51-ae6f-4872-afe1-627824c1e763@intel.com>
In-Reply-To: <abb86e51-ae6f-4872-afe1-627824c1e763@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA1PR11MB7775:EE_
x-ms-office365-filtering-correlation-id: 26677db9-61ed-4eac-2406-08dcefea2893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnlFUkltcVh1RVNCSllDZmZaRWdGazRqckVqaEE5V3ZZWTdsOC83VDZhMXZj?=
 =?utf-8?B?b1M2UmtIRFloQjZIdTdkRnMrRDBuc1kzbVRzVlhGM3FoMDVuUVRCZ3RFMllr?=
 =?utf-8?B?TFpheTgzaHdYcXVWWnJveWpGUGlDSlc2VWpVZ1ZGYnBLVVhTZzJrY3REUWRJ?=
 =?utf-8?B?N216dmpoMnFNR1RGVnNjcnNCcUFqSGhDVkNHT0YrVFFVMmZaYlU3bS9ibU1J?=
 =?utf-8?B?Vm50R3FNdXJvaWw0YjBQZUpRd1g3SVlmNE1waHNuM2pHOGozWDNWZUh4MG50?=
 =?utf-8?B?NXNwcjFSWEEwaFoySjRCbU1HWTJrU09ob3FYSUlOR1lJS0FONVI3eW9rcUlK?=
 =?utf-8?B?Y3dIeVFQT1ZXeisyMGc0VHdRVk1sWXBSMXZqSDZQOFppUS9na3dJSk1CdFFp?=
 =?utf-8?B?QzRwaUorcVNwMFp1aXF0NGdMR1NhODMrUnZHNVRjTEVVRXQ4d1NITUR1d3l1?=
 =?utf-8?B?eTI1eUVVWmNlQkpwSlJyYlNzQjY4dHF3aHpreHE1MDFpT1M1cjRVdDNmZFhp?=
 =?utf-8?B?dCtMZHdxbnBnbHpLS1VyL3Q1RnVUbGxrRUhUbjg1c0R1UW5vb1kyWURuRUl5?=
 =?utf-8?B?dzdQWkMvSVBKM0pIR2E1WlZHQi9qRWFVM2FhOFpicmpPSDAvbUlMK2k5YVpj?=
 =?utf-8?B?dnJ4alVqajRUcEE3VTdIRW55SWR6Zy9Na0dIRVRLUy9jN2hpeENQWG5KTEtE?=
 =?utf-8?B?MjI1b01sbllHQWpqY1Y1L3FvdzQzejNCU0Z5ZFNVczBVSXNDd1didlgyV216?=
 =?utf-8?B?UFVHQy9qZmFoc0RBc3BOeEJnbkc4SGt2L25XNW9MQk85RUFXQnMvd3lUenVz?=
 =?utf-8?B?M0dsSnhYcHY4RkpaeDA5NU5mdXVxNkRXMGt4UEZVZ1UxcGhFaTBZSk9WYVBR?=
 =?utf-8?B?bDdLSDdtNHg4R3p3aWpxNDBlZmE5TmxIWlRGcFdPMXF0VytIdlZjWHFRcVFU?=
 =?utf-8?B?RWJ6dUZuMXpMNVN1cHZuMHR3QVRpRjNnWng5NStGSjExRXZEZFNyM1IvMis1?=
 =?utf-8?B?UVdlZGRSQWpFc2NKbWtMKytkUFk5S0EvVTVFYzYrSEJFNkRvVnl6QUZOTW56?=
 =?utf-8?B?U29jSnZYTHBSNWhZUVY5bG1Pb1hWazVIVFByeE5CS0NFd3FsaFExRGxQNEVh?=
 =?utf-8?B?MTBXVlNPb29sbEowZ3JnQlY0cXNvRUhiS2pPTGY0bmNLYUk0NU05YmsvSFlp?=
 =?utf-8?B?alVKUTFKRnhSTjlEanhqbmhONmVIVys4bS93QVlJMHNNNTNMTVRXUDliR0JW?=
 =?utf-8?B?MndkdFBzcDU1dmlhcTRtVFJlaDVtekZzeitHWU1GTDdjQUdad1dHQkNxVHdx?=
 =?utf-8?B?dk1uQjl1UWh5Y0JYSStTdXZBSVdVbFJwUHdNa1VmTHpSOGJhSnIzZE1WZWtE?=
 =?utf-8?B?Z29WS2RMVTYwT3NiYmsrbUxJNHJncmdoenZ6cWlvSmRQS1VzTnRtbjgwTjlz?=
 =?utf-8?B?dVQxZ1JpdisvaUFQejRHOFJ1WlMxeEYxUEJwVE5EaFJEcE9adkRvdFJlQnZu?=
 =?utf-8?B?bThzQkp4dTQ2VEJrMkRjblM5TTY4c2U5SHpzMVFycGhQRTd2Y2lJeDUyVExU?=
 =?utf-8?B?dFdUUzhYV2hhdHFMVXdDUlVtNTE1OEk1SFVtbmZ3UktPU1l4dnR3Mk44WElR?=
 =?utf-8?B?Q3QweTVzb004c1NKU1NCZmg5WjVPOGFYRlpyR0lTZWx5MW1xN1F2SllTUVAz?=
 =?utf-8?B?eXRuRFZFKzhzaldWbk91MGtFK21OUmdNVDcxMjk4SHVKdHdIQ096SGJNYVBp?=
 =?utf-8?B?RGdJOWZQQmhPT2Q3UXR2QWR6Q09iVlY1RWRtbEJFcEYvVm5xRTlQYndjbXhh?=
 =?utf-8?Q?meokxDWp4EK4OfRpmm2gyKPjprOJwxV6IM3Ok=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEQwOW9jaGdRWVJIU1R0eDlWbjByVlRaMW1SK3V6QWszZjRVTkVhUU9mTmtp?=
 =?utf-8?B?Smlxd0NKK1ZPQnJmSGtYRngrK29lajV3YVpjYzM3bzJUNnFtQSs4YUJJRVdk?=
 =?utf-8?B?ZEdDQlRUclVwRjNoYXpJM3BFc3c1QTJDTDErRDczK0VmWEM4MTNsNVV4ZFRY?=
 =?utf-8?B?NXY5UEU2Ly81WWVwaHFCY0UwUGEzSkl4dEZnOVg2RVEyT1IvK0toOHI1cXNi?=
 =?utf-8?B?anlRS0djdFFFWERwc2NaZThUOC9WUFhEVG9COXovNVRnandYeWRWSGY0TmZJ?=
 =?utf-8?B?SDR3aWxHa3EyUVJOYXBNNGR0NVh0WkV2emJ4Q1RCUS9iTEtmb0FVR3EwRXdp?=
 =?utf-8?B?WkExVVFvSXBENDFEWWgvRlMzYi94MVVLaTl4ZFNkdVV5NHJGSTRHQUdMWWY4?=
 =?utf-8?B?dnNZb0hVUlBoYy81Qjk2eXhCYk5ib0hmSS9SV3duOGM1OUlNRFZMOWZZZngx?=
 =?utf-8?B?Rm84ajhSMXNwQTlYbERVVkRRRU8vMDd1Tk82Q0pnWkVwODNkZ1pXOWViSFFB?=
 =?utf-8?B?QUFUZnR4Qk5pK3dQU2ZiYVlBUHhUU1ZLbjFOR1E5MGk4Sks0SUdUNGNXNlZw?=
 =?utf-8?B?QTQ3Z0JGUUpiTGVEakhoS01SWm5xam56c1B2bWVwQUtoTGY3aDZ5QXo1K0lR?=
 =?utf-8?B?ckwzd1QvdXVORG5IWHhoejR4NWd6V2I3NEtvNU5sd1VYVlE2bXozbUgzUXky?=
 =?utf-8?B?VHJLcWZ1d3I2eXdFZXlXenRyZ3U5RFZNL0ZZZEVQaVVIcmxqbEtRYWVTNFJN?=
 =?utf-8?B?TDMrekZKamhUeWg3R1BoWXZYcHpHYzRBME8vZmc5QVIzMDRHR3B3bkIycExM?=
 =?utf-8?B?WmZUaG5uYUt2c1JUUDhncWhxcWNNTXpsN29GaVhDWkQ1SFlONWZ5ZWZQcFhp?=
 =?utf-8?B?UVB4cTJCTGhtRW5DWHlrdHRLUGp3aE5yR2dRcW9Eam9CcXBDUTJ4VzQyR0hn?=
 =?utf-8?B?V3piTkRPaU9nTnFKcWUxekZ2TE1lVnorWEczYnE2cGVmUTVBN2JvUFhid1A1?=
 =?utf-8?B?NmtySU1VNmplZmltRFh0ZWVzcjArV2luR3laZWNzS1lMUE11V1R5blY5Q3Rh?=
 =?utf-8?B?WWVCbFYzWjA1YUNHRXBKNUVqS0ZMNlFtRHluQkc3c1I2ek1zbHZianl3TThz?=
 =?utf-8?B?eC81bkdhbE84QnlLNFBNVjdJaWY1QnVjUHBqWnRPcWhSS0RveEZvRXVzdTlx?=
 =?utf-8?B?Q1ltbmg2N3Qvd25CUk1tWS9sQkM5NjUvd2VDYmpIYnFWaGo4cGlReVRLVGJ5?=
 =?utf-8?B?V1BNc2YzTTVSU0FYY1NkV1dGMkI1eU00NkRlVXBuZmFEa1pKcFlIVzRySFE2?=
 =?utf-8?B?SmUvWVVZc2l0MldoR1p3QjRGMnN1ajh4YnpBdDRqcUtCenF6WU9qaU8yK1hj?=
 =?utf-8?B?NUtrTk5HUHRUbGxpL09hRzFJNUc2c0J5V05laHFEQ1BhbVNldk9HQzVuQUc1?=
 =?utf-8?B?dHdZcnY2OUd6WUcwNGhmaTdWeVRTMFJMRXYzTlczNGIyM0F2WVNXdnVPTFdm?=
 =?utf-8?B?MVFJaUliaFJhSlNWOHJSVDdvRGoxTEhybE5wV2xUZFp3T1h5SG9jQXhvODFa?=
 =?utf-8?B?UnZKTEVvSkcvRkJkQStrUzF6M3Z6ZWVYQTE3NUpJUnlwUlRKaVZYbThTTGxx?=
 =?utf-8?B?K01VOFNmdEU3VlhMeWJmZjRYTDl6c21TR3pOUUZvanhuWU9iSTlianJienJ6?=
 =?utf-8?B?SVN6cEpRNTUyVUZ5SW5BVkFzSHBrS3J3MEZCNnZQWTBTRml3alNSblVoOURj?=
 =?utf-8?B?MHhFb2d0OUF2VDRQV1Znd0E0cjNMblNuZXFNbFVGMzJVc3dYSDR1U3pOakFL?=
 =?utf-8?B?MURXeXRBZkF6UVdzNldlWUp2Q2RFZjEzYURVUmNxNHRQcHNSNUs4MEYybWRx?=
 =?utf-8?B?U3A5WHlISjNLM21iOEkxbVB2Umg1aitBWmFlcC9Fb2tpUGFKL2ZnWWNlUnU5?=
 =?utf-8?B?KzVISERGcUlZQkpHOGQ5YUUxY04xMHNjamNOOG41ZnU1OUY5d2tOK2hRLzhF?=
 =?utf-8?B?R2habmtsSDFla09JYis0TjRGcUFRWGozbDRZZ3ROTnVwcmdPMTdrMXhsSExF?=
 =?utf-8?B?ZnV6cnczcEt5OEFPODJxTk1QU2JsTm45R0xFbndUaEpFdWlDZ2cyU2NPWEhR?=
 =?utf-8?Q?T3T4Gympla45J1I6pw7q9sPO7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26677db9-61ed-4eac-2406-08dcefea2893
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 03:00:16.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB59rbyyPN0wJj27zpiC7nOdelZhU1lzN0Yl/LxeR++t5q7pkC6hIwNrnjKimHI5iTiJKHU2ILlwR2wQUduI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
PiBAQCAtMTc0OCw3ICsxNzQ4LDcgQEAgc3RhdGljIHZvaWQgbWNlX3RpbWVyX2RlbGV0ZV9hbGwo
dm9pZCkNCj4gPiAgICogQ2FuIGJlIGNhbGxlZCBmcm9tIGludGVycnVwdCBjb250ZXh0LCBidXQg
bm90IGZyb20gbWFjaGluZSBjaGVjay9OTUkNCj4gPiAgICogY29udGV4dC4NCj4gPiAgICovDQo+
ID4gLWludCBtY2Vfbm90aWZ5X2lycSh2b2lkKQ0KPiA+ICtib29sIG1jZV9ub3RpZnlfaXJxKHZv
aWQpDQo+ID4gIHsNCj4gPiAgCS8qIE5vdCBtb3JlIHRoYW4gdHdvIG1lc3NhZ2VzIGV2ZXJ5IG1p
bnV0ZSAqLw0KPiA+ICAJc3RhdGljIERFRklORV9SQVRFTElNSVRfU1RBVEUocmF0ZWxpbWl0LCA2
MCpIWiwgMik7IEBAIC0xNzU5LDkNCj4gPiArMTc1OSw5IEBAIGludCBtY2Vfbm90aWZ5X2lycSh2
b2lkKQ0KPiA+ICAJCWlmIChfX3JhdGVsaW1pdCgmcmF0ZWxpbWl0KSkNCj4gPiAgCQkJcHJfaW5m
byhIV19FUlIgIk1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZFxuIik7DQo+ID4NCj4gPiAtCQly
ZXR1cm4gMTsNCj4gPiArCQlyZXR1cm4gdHJ1ZTsNCj4gPiAgCX0NCj4gPiAtCXJldHVybiAwOw0K
PiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKG1jZV9u
b3RpZnlfaXJxKTsNCj4gPg0KPiANCj4gSSBhbSBzbGlnaHRseSBjb25mdXNlZCBieSB0aGUgZnVu
Y3Rpb24gbmFtZSBtY2Vfbm90aWZ5X2lycSgpIGFuZCB0aGUgYm9vbGVhbg0KPiBtZWFuaW5nLiBX
b3VsZCBpdCBiZXR0ZXIgdG8gcmVuYW1lIHRoaXMgZnVuY3Rpb24gdG8gbWNlX25vdGlmeV91c2Vy
KCk/IEFzIA0KPiB0aGUgY29tbWVudCBzdWdnZXN0cyBvbiB0b3AsIGl0IHB1cnBvc2UgZG9lc24n
dCBzZWVtIHRvIGJlIGlycSByZWxhdGVkIGJ1dA0KPiB0byBtYWlubHkgbm90aWZ5IHRoZSB1c2Vy
Lg0KPiBBbHNvLCB0aGUgYm9vbGVhbiB3b3VsZCBwcm9iYWJseSBtYWtlIG1vcmUgc2Vuc2UgdGhl
bjoNCj4gCVRydWUgLT4gTm90aWZpZWQgdGhlIHVzZXINCj4gCUZhbHNlIC0+IERpZCBub3Qgbm90
aWZ5IHRoZSB1c2VyDQoNCkFncmVlLiBtY2Vfbm90aWZ5X3VzZXIoKSBiZXR0ZXIgcmVmbGVjdHMg
d2hhdCBpdCBkb2VzLg0KSWYgbm9ib2R5IGVsc2Ugb2JqZWN0cyB0byBpdCwgSSdsbCB1cGRhdGUg
dGhlIGZ1bmN0aW9uIG5hbWUgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzIQ0KLVFpdXh1
DQoNCg==

