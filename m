Return-Path: <linux-edac+bounces-2150-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F799A4B1A
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 05:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A579AB228EC
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 03:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341F1CF2AA;
	Sat, 19 Oct 2024 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjslIAUh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3BE137E;
	Sat, 19 Oct 2024 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729308590; cv=fail; b=Tw/T91fWVN0X8rtR8Zi0/ffTzs2Hkfs0eEVXknD+m+cF1n9zLWJEEHRh86ivo7ztWzIfRjcM4CO+LzWNzVGJMcRG8Njf2c4/REmHlrR3vXa8N3K+mg7kQlEuJxkK9Zgttat31emepAzm1Q15DNCWEubuJ4m7vDJ6PrYLma9i5Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729308590; c=relaxed/simple;
	bh=6rEI4WoxkJ9WmCMip5dEq8XXzmr4rfwgO28r+GDmrEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lIzpUkmDUI/1dP8zVxOUN+tVkjRX/CobrwvE+NjbBpWAY/1emujiD7WAjF6mElokPLPzNJz7HBr7ETKtB0Z4nrU2nHIsv7XwDAB6XC1iUTrLwkCMXZ1zXECKLThenXKkttKwOfJ2+mOXmQE9KF7bEn45StqRPAiFW1sNpWT8zIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjslIAUh; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729308588; x=1760844588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6rEI4WoxkJ9WmCMip5dEq8XXzmr4rfwgO28r+GDmrEk=;
  b=VjslIAUhwBhUgs1oBZVT7S5qmXd/V5fgaxmQjzJv40SXHDeNxQDOXbus
   Iu+QJ4Y6xhJbvnVnEvRLy+nt/sU77ZpcgL8Ns1EE5TTyJQGHeJJioqhyg
   QMQWJDsRfzXdRFFIpbJTCHyBQs29w/box1Rr6l58GQMOStk1gz/LcOfL2
   XZcyFXNtKGEl+R/9DubSOWNcVhWJnm0ddheL6k/sh0QtwrXytDgCF3/Ts
   Mjei2T9dHshCYeP0YMQKRHu5LcYCl41n7dn/OnoPqP05Rpx7smXcPOzPM
   vEH7MEIVJt52/AP0rhwefh0kayGntQuUzXUoOHvKHRKXjJvcS9Msu5xzl
   g==;
X-CSE-ConnectionGUID: yiEcvxkQS3efvlO/mzwS4w==
X-CSE-MsgGUID: c9nP9xyXSr+HI1u8UFCtdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="54266212"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="54266212"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 20:29:47 -0700
X-CSE-ConnectionGUID: St4FoFhMQt+WNKk6hfGRXg==
X-CSE-MsgGUID: A1QBXN0eTu+bq2hKp4bJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="116496174"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 20:29:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 20:29:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 20:29:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 20:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHPQb1kKP2nxbQD6nBPDRWVw8lmK/h2Vaa9BKWYxwbU+ohNAVoLyTpphKiDrGl4OLV9RoSMGN5igjk61sffN/9vDQ8+qirIrU0I2S+U+ujwgLCQbLfBU9IfggqaDuiltp6FYs7rJrxElI5qleIQJqnhLJKOtehCSLkbIynrKXDTlnzyB3b6LnPVQ0n6YxDXHPuWViiNcQmIHn8hslEyrkTk4t6mo/MclzzJ6tMc/ALsEMNtnzKvtGKMFsaf5dtP8gX8fYjaTB7TsNfaxqY0KRgjIT4QATC6JTLzdTT3M6tOWgkW6ME6QeHZOP3JoTxQnyJBZDu/c6JuQ2M5lRZs4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rEI4WoxkJ9WmCMip5dEq8XXzmr4rfwgO28r+GDmrEk=;
 b=GLk/nDFPov8cE9GkJzV3AukTVy62soQskl/U99h2NiE1ESa7gLeQlrc2xUk2vcrNxuEIfz5TP+05MdpOQGGkMKgiVz6zz67rWVotARji1gWUJXooDWQiP/Jvjugr+rDHWz0J5IzLkadT+OQT36QpkQ8HSkYPgMX6Xv7ZLuvD1bl5P/rLoFm8wAHoJk1IFsQE+XH1oKqH8rybU1wxuyquPHkQmmU9ayPoqzLqmL/eJvhnOq3YDIqWUQpnPqWL1zqqtMvUrKBKS0k64W3w13MkNffkmek5AN/dQcQmaB/ILE+KNcLVB2iyb8jRdQpgFI2Io9fOCemY/lBlFVCfrTfdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Sat, 19 Oct
 2024 03:29:45 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 03:29:44 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 05/10] x86/mce/genpool: Make mce_gen_pool_create()
 return explicit error codes
Thread-Topic: [PATCH v2 05/10] x86/mce/genpool: Make mce_gen_pool_create()
 return explicit error codes
Thread-Index: AQHbH8qHAery+2GFtUKPB9JJ7G55HLKM5fKAgACGKJA=
Date: Sat, 19 Oct 2024 03:29:44 +0000
Message-ID: <CY8PR11MB713494AF7E43D936A23C091B89412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-6-qiuxu.zhuo@intel.com>
 <075d1720-2c2a-4be4-b5b1-45ef9c309096@intel.com>
In-Reply-To: <075d1720-2c2a-4be4-b5b1-45ef9c309096@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY8PR11MB7845:EE_
x-ms-office365-filtering-correlation-id: 163ee79d-c168-4507-082a-08dcefee46cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2tkTWt5citGN29JbytaSENBTEZ2dDZrVEJZcVo4NVpidk9yamd3ek5HcTc3?=
 =?utf-8?B?RGJhV2I1cVV5NCt2d05WU2lSOEdIRVE0WktJb2ljMUJjRHNYalZJbGgvSGJn?=
 =?utf-8?B?NDhRckJjTGdzbHVqM0ZYdkQ4RXNDNHBmTDNpYkdsbDRINmlFSEpHRk1wY0hi?=
 =?utf-8?B?ZEhhb2NkWStBSTFhdzcxY0xVaHliZHo0eTlqU2phMUZNNk1TQVBFVFNwUXhw?=
 =?utf-8?B?bjg3NXZDWHNKS21SMFd0RG5ubDZ5NEJOTE9DRStuRXVTMjhXdldyanpGdm1z?=
 =?utf-8?B?Q09LSTY3VlR6ckl5V050T0ZtTTZhdVVOV3lONEFLbnV1czExeWtoZmI0b25K?=
 =?utf-8?B?YXdZMGdJMzJNL1FEKzcrMDQxczhXWkxseVo4ZG5kSUpETnc3TWdHZ2tjdFpr?=
 =?utf-8?B?SXl4WnJ3dWJsVTBtdmFXZVFldGo5V0VLdUtUU211ZHlScTdDRmp6NGtyYVZ2?=
 =?utf-8?B?V3NIaW5ZbWVSWUVERHhBN1N3aEhLV3kyaGhtdVRKU2F5emg0RXF6QXcwRHhU?=
 =?utf-8?B?ZCtmRkV6Yk5mZ3NpU1RyUVRSclFVcm05RHZGdElObDl2Y3lzT3ZVcWJTQW1R?=
 =?utf-8?B?ajdHYWUrMjhXakJUcXJQVDVWUENrNlRSTWNtV2V0VXpEa05nN2xmUkJ5U0Qz?=
 =?utf-8?B?b2VnNGtCdFNabGdjdUp2RmFuWmUrRVBEODI4eEp4UTdJMHZzZ1QraW5ObmhO?=
 =?utf-8?B?dXFMRHhsdHJsWk5hc09OUkdKejdhK2Q4SXZYMWhjZ2wxOFIydzBicC9LemZ2?=
 =?utf-8?B?ZnU5bk9OUFpKd2xzQ0tNSWJlTURab0tnQzUwTm02bndaZWhOdkdKV1BSZzJF?=
 =?utf-8?B?TWNoT0Z5akc5empGSnlDaGVTN2xQVUV3WXJaOVBsK09udElyU2dTVm5xMXVD?=
 =?utf-8?B?R0hQaFN5ZHhLSE54ZkV1SkpTVmxJWnh0a2VvbkdnRm55THdjWlFTcDQzZWJY?=
 =?utf-8?B?dEh0MVZReFNTOEFYVUp4SzRXNlI0ZEJkS0VnaEQ3QWVJaGF2V0s2Y2tYNTdL?=
 =?utf-8?B?czcrWDI4WHN1Wm5oTjB5NUt4eFk2TWNhbDJFZlZDRjFKRXFGdnk4eU5lRW4z?=
 =?utf-8?B?V3MyL0szdmx0Y2FZRUx6L1NFRDBGMmNEUVltclhCMUs1cnlaM1c5VFVFdm1v?=
 =?utf-8?B?VjVidGNhYzJLN3UwL3hEL1AyWVRFSlZTTENDazI2azRZTTdmcUVTUUtEc1F0?=
 =?utf-8?B?elplYnlidlc4VlI1WldpWk13Q1lDYk1WZGZtMHQ2TkV6bzRaV3BxNGxsU3RK?=
 =?utf-8?B?M0poOXd4ZkR0WmxYMDZ4Vm15eDFJNEtLcnBVMnp2alR4RmJwUThKN3ZMdUhN?=
 =?utf-8?B?VDRKdFRIY0FMMnk1QkpkWmk3d21GOHdSU2FDQnFHVnpkd3o5d1Y4TlQ0OFpV?=
 =?utf-8?B?T2Jka3UyTm5OOHZCOFB3eXVuVVZ5bUlBWE5FMmlveitoZFFXM2J6WE9KZUE4?=
 =?utf-8?B?bHhUZ3ZSVVJFWXNDUzVlTlcrQlV2TU00cjN4VGlQKzl1bGhRTlJhaTVFeVZR?=
 =?utf-8?B?T0JtbHQ2cG4vajZ2cHgzZVlsZFdLbzVxbDhMdm44VFhqVHpYWHRrSS9UNGpq?=
 =?utf-8?B?ZjBFaEthRGc2M2M1R1N6bDEwUWFJQ0czNlhxTDdhWENiaXh0YlU2ZGtmNGM4?=
 =?utf-8?B?RzJwMnl6THV3cTF4V1RUNHFlTnlaQ2tiNjRDQzJYRFRORFBTYU40K0pZWlB3?=
 =?utf-8?B?aFpHZGsxMnBITTV1RW5ickVwVFZQOTVwdnI3ZHVjQWxLYWdCM25FRDhMMjRN?=
 =?utf-8?B?a3lOdlRDWXBWTXJpYXA4R1ZDbGdoVjdBSmI5SGNBbWdqMHRydzc2djBDUjFE?=
 =?utf-8?B?WmtkOFF6VGVIWUl0ZGZGMmZ3cTlseWgwR09mMkNXR0VvaVZlRXVaUDI2VTZj?=
 =?utf-8?Q?hK+uDLXzgcpEx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rmpoakd6MnhiVHYyOFRXU25RWlAwQ3NKMnRIRmp4VXhNdUY1MC8wVGN2TWxY?=
 =?utf-8?B?VS9aNEpnckhRaHFlYkE1clh5R1RqQ0w4VC90OUU0eXpDb1ZhVnBoMUw2WmJq?=
 =?utf-8?B?ME1uRjVOVFdBVmovdisxNW9uSmVTTkt4ZFJkNmpXakFKeG5JSFJhcm5LVFdO?=
 =?utf-8?B?emFWZVh2cXNYbEZpY2p1QWxOSFdQc21sdEtpNjkxZW9nWjFRWTZLdElpZTlx?=
 =?utf-8?B?Vit6SVVlSGZsN0hUUnBtOXNLeFMyeE5QblNtVDRNQ2F3SWpSOU9qcGUzT3B4?=
 =?utf-8?B?REVMR3hmN3h3bHdqYVNwNEJiOWJXdXV5cE9jZ09RMUxUa1I0NHA0OEdTWC93?=
 =?utf-8?B?VGhzeGFFM0VUcGxrVFpva0lRbDRCdGs0Y2taVTRXSFB0d2dETmc4UWg3Sjhj?=
 =?utf-8?B?QkdjbEZhWmxhM1JjS0RpZ2QvajRiSlhzUW84U0pOeWVEKytEcUhRRjZpVysx?=
 =?utf-8?B?MkVJL2hVVWk4eGIrRkdpaWlDV3BRbGE4SU9kWE1sNC9tRWFrSHZiTUFSWTRZ?=
 =?utf-8?B?T0wway9majg0am4zSnZwL0twbm1kL0JGclNHWTREcVR6eWlONmVocStkeThv?=
 =?utf-8?B?b1N0M0tISjhJUzNsb2dHSTJQdXlNaDRqR1Y5VzV5RTdzcHVKQk1DVzJXUVZL?=
 =?utf-8?B?QXJtK2p0MmFVWHJka2VxMkc3OG9RMXNPS1ZON043ODYrTEk5cmIrbDlUYUZ4?=
 =?utf-8?B?dEM2Ulh4QnMraTdSaTE1Yy9GQzl2K0NyVkFRSzNtWXFqUUFHUFhNK3JLUi8r?=
 =?utf-8?B?V29VaUFlWmJDR21BMHdZV1ZBd3o5Y3dOTHNJNGlrVUQvdlp0T3U4T09zWk5K?=
 =?utf-8?B?MWxHV29pR0N1ek5VcHdVSDNUNTFNUXIvaHphSlk4bHc4WERiZlF5d1lBNHpx?=
 =?utf-8?B?dXF1a3lRSHM0SzJuYkhYaFAwQ3BWMGNyN1krZzZVQVZ1cDhZT1VsUnUxMmZP?=
 =?utf-8?B?Y3F0UjRNTkMzd1BQOGIza3Y3TXVoWWorWVI5SlBscW9EV0ZtYmZ5YTdVQjlZ?=
 =?utf-8?B?SHc4bTNsVlZGZ2V2aTlDc0xtVkkveEwwVmEwdm42dDBxRXd6QmNkTXZOZ1RL?=
 =?utf-8?B?c1cveS9zRURnMEVYMTlidFUwZUlSK2k3c0I0ZHh5NCtmSGg3bXpEZnRHY1JN?=
 =?utf-8?B?ZFI5ZEhPeGp2ZDB6T2d1ME05a3kvaHp5QjllRHJJZnpDcHNBdnppOStMdFlt?=
 =?utf-8?B?ZjhyenhWcXMwcjBpTlkwTTdOR1JHSElsRlhNRXQ5QnQ0dzJRenN4Q3RDU2tM?=
 =?utf-8?B?ei9iYWtIOERoUGpmVWhoTEl2UWtWeVJrK1lkZVM5WFJud05TNk43c1JxSitH?=
 =?utf-8?B?OVBiKzZlOVFpR3dpL1FPQXUrb1NaWVE3RkNUc0FvWkMrZWNscUJEd1VUZ1VT?=
 =?utf-8?B?WmxqSTBZSUdMQWdpOVgxUmtZbXoyUSsrY3dMZitNUldCZWd3Tnd6VGdNMG02?=
 =?utf-8?B?eVJPZ1RrWXZNQWVqSEcrM29QeDVmRkJXTXdaNk5hbWp1TWxTelZQMm96L3Zu?=
 =?utf-8?B?STJCUFMxNlZ2N09OY1E0UWJvT1dVTTYwSHFvZXN4djVLR2RiK2FxNkRTREVo?=
 =?utf-8?B?dDVIM0Nac091bUdnWmVEcldmYVRSMFpuakVGaUo1MjhRcW1tQXpsaDFaU3p2?=
 =?utf-8?B?RWZrQXBZekJxQkxrYkZqaDNtUVh6d1N4b01sQWF3TXNtT0hYOTNLQ0VsTGRh?=
 =?utf-8?B?WXVadEp6VE1KT1ozNFBSSnRCejZHeWk2N2NFMFk1RVVQTnRQY1NVc0lNQzBY?=
 =?utf-8?B?ZThVMC9kTGNkRFFJVC9QUzYybHQ5ZXBGaW5OelJ1Z2JEaktQUFprb1JERW1Y?=
 =?utf-8?B?Y0dDTHVJV0VySC9qVHY2Z1BnMVBhMlhYQjFlak1GQ0tpK1BEWklXemtHZHAy?=
 =?utf-8?B?SnJ6RWp1RWYzcW90SmNySTU4ZDZGazlsRGkyL0RFTzN1ZzFsVXhBUm9EL0xh?=
 =?utf-8?B?M1lseUVLZ0dqaU5oVm1mUlN0Q3FzUFFIaVdQbmhZVGJzNHV0eWZ2TzFncVZL?=
 =?utf-8?B?VHowK2RkOXpLOU9KNnkzSVl3RWx1M0M1K1BaaEJoSHlLaGhnZUdORmZ6Rmt0?=
 =?utf-8?B?akJoSlR2Y043RjNUOTNkM09KQVVCaFB2VTQycXZ1SHlLR0JBMzdkVHFMcGs4?=
 =?utf-8?Q?Ft6/O9vWsi6ORmip8xn7CK8rO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 163ee79d-c168-4507-082a-08dcefee46cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 03:29:44.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlEjuh06XnOYOhQjn7cShwlUVvo7VwrJ1s1UKpGUwyoKIuvubjUbcRLl5BFx6pOD2dMVG3rPeXAsz9Wey/7y6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7845
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvZ2VucG9vbC5jDQo+ID4gYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9nZW5wb29sLmMNCj4gPiBpbmRleCA0Mjg0NzQ5ZWM4MDMu
LmZmYTI4NzY5ZGVhNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9n
ZW5wb29sLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9nZW5wb29sLmMNCj4g
PiBAQCAtMTIwLDIwICsxMjAsMjAgQEAgc3RhdGljIGludCBtY2VfZ2VuX3Bvb2xfY3JlYXRlKHZv
aWQpICB7DQo+ID4gIAlpbnQgbWNlX251bXJlY29yZHMsIG1jZV9wb29sc3osIG9yZGVyOw0KPiA+
ICAJc3RydWN0IGdlbl9wb29sICpncG9vbDsNCj4gPiAtCWludCByZXQgPSAtRU5PTUVNOw0KPiA+
ICAJdm9pZCAqbWNlX3Bvb2w7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+DQo+IA0KPiBOaXQ6IE1heWJl
IG1vdmUgdGhlIHVuaW5pdGlhbGl6ZWQgcmV0IGFsb25nIHdpdGggdGhlIG90aGVyIGludHMgaW4g
dGhlIGZpcnN0DQo+IGxpbmU/DQoNCk9LLCB0aGF0IHdpbGwgc2F2ZSBvbmUgbGluZSBvZiBjb2Rl
LiAgDQpJJ2xsIHVwZGF0ZSB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gSSBoYWQgc3Vn
Z2VzdGVkIHNvbWV0aGluZyB2ZXJ5IHNpbWlsYXIgYnV0IEJvcmlzIGZlbHQgdGhhdCB0aGUgY3Vy
cmVudCBjb2RlIGFzLQ0KPiBpcyByZWFkcyBiZXR0ZXIuIEJ1dCB0aGF0IHdhcyBpbiBhIHNsaWdo
dGx5IGRpZmZlcmVudCBjb250ZXh0Lg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjQwMzA3MTcwOTAxLkdCWmVuMHJlNkF2cHNjTGFUTUBmYXRfY3JhdA0KPiBlLmxvY2FsLw0KDQpU
aGFua3MgZm9yIHNoYXJpbmcgdGhpcyAuLi4g8J+Yig0KDQotUWl1eHUNCg==

