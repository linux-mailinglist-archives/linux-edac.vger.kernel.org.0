Return-Path: <linux-edac+bounces-2340-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8799B59EA
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 03:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D344AB213A2
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 02:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E1192D77;
	Wed, 30 Oct 2024 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNVrAaw8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8AD531;
	Wed, 30 Oct 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255208; cv=fail; b=etc7iy8Fs4ggk/mP6PSLKxXmW7Uu+XlAgQzAz8igVKFAlI/DofvqvVm22cF/3KgJUNyXg/Nkxd+NG38s3YjNSj3UJ/DhxO5mCxxWSIAEOnQXMPCh4sWJiAiGbdIepePh8CGpRCIkcgwrQWaU0fUIg1O0d//X2g8pAQuoxgEeJh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255208; c=relaxed/simple;
	bh=PyiZdH12e+aa+ay23QYMBTUkb1ornMRYMgS3tKSSf7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HbH47eijqHzDzjQBrc9phd7AzkW01ARB4LCp3I/Wsga0yGmFSKyMry3GEZ9uSHQZcSCl/3AtAiVI50weaRFfSZJSdHS/zc0aoQ7Cx0aEO/gZRfNx/o70yNM+g2Y9P/uYe85XqDyBEued+EhK4uL2iG5YgYFBskwDVDFX5LjVAno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNVrAaw8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730255206; x=1761791206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PyiZdH12e+aa+ay23QYMBTUkb1ornMRYMgS3tKSSf7c=;
  b=hNVrAaw8ymDD6ExBN9mtQEaWgATCiH1oA29027lp539gXJ3QAXsU5lEX
   0mlOhHktJ0TQCx3sYi53CQWncsTaCVGv0sVy0pklHxVAdYmcdUhoXhcGO
   gnD5benKPglE2wmDOKHkU3Bvf2s5hAZYrm6AR5wGKtBZ75bkUJpe9xkKj
   /xKfViBYr4jBoxIXXUf9KHzXhxXFAuxNYXDesHCr+QoVU2vixzmsDyz06
   MrhBsUFt7WvDhKhlycY745319SYUrkIrWwvE0c5VglhwQ2kc9THhUFt6r
   hMVhIow8NC4HNZtshjkXodBzRtsGjZux1k3Uvlhyj7WRYEnQ7+vrbyvYX
   g==;
X-CSE-ConnectionGUID: vwmhQuTaRwyHlPpC9nGtXQ==
X-CSE-MsgGUID: 2FkScPqJS2Gj/RkqRrKQGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33738062"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="33738062"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:26:45 -0700
X-CSE-ConnectionGUID: nNYV71E5SAyT2Uod/yVC7w==
X-CSE-MsgGUID: 16lYq5amRLC6MbaiHREg6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82973969"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 19:26:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 19:26:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 19:26:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 19:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmr1cGhVusQy+ALOC0CHlaACmA3f7WiWxAVamJ5vutWvgDlrDcq4/hrt8qSJ4dJm+7ZNyGdpZmN49YgT15gcG5lG2Eei8i+IR1KGnK/i1RWlLi/HKqqPo3r+lO4DmWrDdSUZAZ9D+zNThwd6KVybgzaBkUOhZqrgdN3uRiEAnc1HkUygFYrEKgVG8JCCkbbNzGaCKEjmRKXmc7ruaGC3S7nLZINSMfqpu3Umv5FAmZ9KwmA09IY+yPZyRVY96HAvv5T8YajSpG7jZRFIoSCWifS2aAxnGHMc8pkH1Z5JrvmKk4TrgX9dloAVKrw5kZpazOKCB6Y0O8EhvpKzN9l4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyiZdH12e+aa+ay23QYMBTUkb1ornMRYMgS3tKSSf7c=;
 b=Ikb8ZHcPWRk+x6t/NKRsNly9jEArvhRi/Aewe4q55GIcsIEk7GOTf7Kx3HNcgHzlOWlyfLkVnc3Q+0MXbz5Qdiio+F/QNASDpseHo+sCWx1Gyu9tVTyxSOHNbrhXC7p+IKe57PSv9QYoCbWNgSe0DK7RKP8w2nom8JQGb5SMh3mRCsS5HzHPS7VEkHOBaSe6WwShEfI6w43afzTK/7mEMK6Tdjj8MFYjtUfJNQLN/sY9SffeTSP1enawFe4G/QzglZA/29GW0pYhTnSrsA2wMHNuaA3D+SOzNAxoEmsKAwMRJyUNhUtc4PFudOXZsNVdT5tptSxktxLxQlsWhooimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 02:26:41 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 02:26:41 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Dave Hansen"
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Graf,
 Alexander" <graf@amazon.com>
Subject: RE: WARNING in lmce_supported() during reboot.
Thread-Topic: WARNING in lmce_supported() during reboot.
Thread-Index: AQHbJzOMnI+axKtrVkiRKyOsEUKyt7KYJUGAgAArOwCABkW7EA==
Date: Wed, 30 Oct 2024 02:26:41 +0000
Message-ID: <CY8PR11MB7134049E49C3AFA425EDC4E289542@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025231320.45417-1-kuniyu@amazon.com>
	 <e1c50570-1b5b-40d2-bab3-05e9ead51a57@intel.com>
 <7080ee37ce53d5559ba85f72a0ff59b4bc5a083d.camel@kernel.crashing.org>
In-Reply-To: <7080ee37ce53d5559ba85f72a0ff59b4bc5a083d.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6567:EE_
x-ms-office365-filtering-correlation-id: 631c5748-642c-4ca1-8c5a-08dcf88a4a65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVBhMmpBSzNacnRRdnBad2xab3lSYmpGeE44TWt6TGhQaGo4ajlSTkpQdHpB?=
 =?utf-8?B?OURxVWswOVBZVWVLK0VYMDNRWEtzaVA5cHdqc0pOVGNjUmhqZy9FcjBIeXJv?=
 =?utf-8?B?bUw5K0ZoZWlPNXlBYlVZVzJkTkRVSFZ4b2liZVo3TzloV245bUx3Q3RxNnp5?=
 =?utf-8?B?UlJiRU9TQ3llcjREQ3NNakFQODBnUFB0UEpwWFdkWUhsdVM4bkNwcnRFWi94?=
 =?utf-8?B?MlhCY2lnekMwY0VJaEJtcHR4U2pDZEpuWU9Cd1VuaFk5cVBNYjBOSlgwa0J1?=
 =?utf-8?B?b012M0dsT1pDSzYySU5vYWFzRVBWZzI4cUJzWXAwa1dYWUdFV3hKaTN5MVJP?=
 =?utf-8?B?L2VDcG1IcHUwUlp3SFlCUE14Z2RuRDNyNE9POXZFMVBCTS9aUTYzcE5VbUwv?=
 =?utf-8?B?QlpPZFlaSGkybjNTM0ExamttSE8xY3BjVUVBYUR5SmtsaWJsdzNpVzFsSkxr?=
 =?utf-8?B?Z0JzMWJDTk9ac3R1NjMwdWtpd2F4TWRBblhNOGVyZmtJcE1OT2R5Y1U2RGFJ?=
 =?utf-8?B?ZnZpYm9TWXVlZ0oxTmhtZHhQWnMzTEZKUTVZRVpDRWIvaC8wclpWZWpUSTMx?=
 =?utf-8?B?WGdrMG5IeWtYSkhkNzEyYWNUbjhIK1ZlUEtmQ3Y4TGFzVFNOQVFVMUw5Smdp?=
 =?utf-8?B?YkdQMkpWMSsvb1VpaENkdEFTN2N2NXJwTjNqaklLbE9pa3h4c05lQ0dLaWda?=
 =?utf-8?B?dStpdEk1TmF5bnRhd1hteDFRaERxMjFwVVRPZWNkaVhmUlpTU1Q3TGNlQmdJ?=
 =?utf-8?B?dG9uSVpFUW5oNldZRjQ2Znlpbm1aMHBSaHRObkhmQjc5VVdFOTcvOXB6N0d6?=
 =?utf-8?B?b3VaSm5Zc0VjUU5oMXNydlVhSnA3YzNVelRvZkZLQlM1eExnZlFRZzVDa1oz?=
 =?utf-8?B?QWl5SmQxQTVWeFh5YmJsVm9aTzRTRXFtYm50ZWhoM3Y1QjBuSG83MnJ1OVJX?=
 =?utf-8?B?ZXpGTU1yNGM0blBBaVhMaFBCNkV3WmZVRElBRW9MNnpxQzQxYm96L3lVdG1n?=
 =?utf-8?B?OHBaMUdNNVgrUE9hVzFlNU55UHBRb2JJZ1ZQL2syT1IyN3UxTTFlOW4ra3dR?=
 =?utf-8?B?OWRPMzRudkVGZ0gwODVSTjdFczJzd1ovVFZYcUR5VjV4M0dDb0dsbG1JQ3VM?=
 =?utf-8?B?bTJiSWhQZWZJMnA5SmZoOGhYelRiTm9MNEgwSHU4ZGZHbDFBTEZkN3YydWt4?=
 =?utf-8?B?YndCV0N0d0g2WVNmRGVtZ1NYNEh5Z1BtMHc2SDgwK3lpeGhLdnNtREtQMFEr?=
 =?utf-8?B?LzNNc3VSQmZnRjRPWFFZZ1BmZi82bUUrbXJJWVNEZVdka0wxQlV4dDlmd20v?=
 =?utf-8?B?WmE3QXJ5ZzFDbHlueCtYMFVsUXZ4cUltdXo4WGZIK2cvUXhJSGtDSUJxc1Jt?=
 =?utf-8?B?SllKRURhRGUzWHBES2JHOG56T1gvdTNuRlpjdXY5ZzRpenBPQjNJVXFpRzJl?=
 =?utf-8?B?MHliMnp1TElHWW9KU1BKYTQwWG9QdFFCc0d4TWJtT2ZJVUVRSW9qRDBsUjg0?=
 =?utf-8?B?OUZXdUhNL3l1WnBUODB4MEhaZXZrRmpUQTZyakE5bHFaNzVuWXlyQVB3bkJ6?=
 =?utf-8?B?VHhobFlpamZZWmQyTUlZaXF0OTF4d1laOHA1SytNWDFSYzUwWkZXaDBmTWdD?=
 =?utf-8?B?N3cySklvenNQbkdYREZURGd2all5TC9KUUxMVFhYeTdkZXptMG8zbFVaKzZs?=
 =?utf-8?B?ZGEwOEZWcjRIVHBGWkhMakN5ZVZIYVdUblNyeFV6ajVka1FHTS9UV0JEM2dF?=
 =?utf-8?B?RW0vem9uK0kweU1aUFZJNUNqSnJwUWp5Q0RMY3grSGkxdGZPVHJmU0NBbEtD?=
 =?utf-8?Q?0cPRWox9AhxPUi91atp29OXKxxxvCCRKEp29Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEJ0bEdoZmhKL0NpN3ZLQTlqZ0wzNU9FcWdJMTE2cURLLzhHNXp3Z05TVWNP?=
 =?utf-8?B?WlNzbHdzWmRSVTVwYS9aUzB4Tm5uN0ZHSGtsRkJ1OGNCWUd0elFnY0FlYzRQ?=
 =?utf-8?B?L3N2Uzg3V2tOdUhzMWVyZm0vS0VGWGN6bVRndHJhZWVJUHlzK2E1Y2swc2RM?=
 =?utf-8?B?K0xlcFAzOXQ4WXlCWmEyN3R4RlB6dDNRVEI5ekorZEZSQ0MzUXFOSyswV05P?=
 =?utf-8?B?cDBTQjlYSk1ObCtQVWE1Lzk3eWY3OVA1ZUZUdld6RTlmS2FVdHplVHFrSm1H?=
 =?utf-8?B?SnlYTUJpM3hya1dVaWZNOXR1dlRody9peDBseTgzLytIUWNjcERyWjVQOHpn?=
 =?utf-8?B?WHFzMTRteEFFcFZ4Zk9iQkgrU0Q5Q205a1plN3JMak1OWS94WGZNQ3JmQXZV?=
 =?utf-8?B?T0V4Sm90Wk43Ujc1VVI4RHpDZlkyRnVDUHNsU2VDRlppeHBIbnViYWhIamNV?=
 =?utf-8?B?blI0eXZray85R3krQUNUVElNVFhBQUVWRHJ3SXhVZjg5ZkJ4c25tU0p5TkhQ?=
 =?utf-8?B?SWxyYUlpZXF5M2ZwMFQrUFdySmVpRnJnM3FzQWFpTjFGMWJHTW1OMzFub3oz?=
 =?utf-8?B?bXIrUFlJUmY5WGwwako3ekFlMzVITGd4MTN0ZjdtWVRjTkVZUUcrV2N6WTNK?=
 =?utf-8?B?NEI5ZFRmN29SeWd6a1pzNW5Kamt1OXQ5ODlBM1JRQmFuNldzZWVrT0NPOGlW?=
 =?utf-8?B?TUROZURoQXZyQWlwbGhoZUpCdzl6UUtSUzM1eFR4WDFka1hKN29BNCtET2hq?=
 =?utf-8?B?ODAzdmQrUWtCQ0doVWV6Uy9WY25uWGVDNlE1S2VyZmZBVWsrazRMM3dpNXBq?=
 =?utf-8?B?eEQ4cHVKSElhb0RidWFPelhiMnNhVVpjSGlSVnlRVU1GbjVuM1Z4ZFVEVVFS?=
 =?utf-8?B?Sk90M1V3cFN5aTlRamh3dC9XQTZMazh4MThqRlhNR3F1ZG1ZRHZOUkNiekRP?=
 =?utf-8?B?ZHNiQ3dvWC80VFZmd3cvMXlOQ1g2UkwrNDVURWhmVzF1ODRaTllhOU1HQkkr?=
 =?utf-8?B?WjNWRFNHbzlIZWpMOTkzeW9Fc09tdGZGVGt2L1RCamFMcTQ0dmFXcDBlUmdu?=
 =?utf-8?B?S2QwQU83cXo3N0dqd0tBTlVWckhVVU01eUZWVjRJNnJHNzFWUUJNZjRPSUNQ?=
 =?utf-8?B?b3lrNTBzUVUydG81eVR1U2RBZmZDTW96K2JNOFVaUE5yWVY0VnI2RTVCQVhZ?=
 =?utf-8?B?enArS2NaaTZDNjZIaFcwK0Z6QStIZVh0ZGs4bnp1S3VGTVZMY3g2UnBpdVJq?=
 =?utf-8?B?bmExSGJ6Zko0N1JlaDY4a2FKajQwNDg2YlZ3NndFRGdiQWJIclU1cnozYzVy?=
 =?utf-8?B?bW90VGwrZXVvV1pibDNGRStkNW1hT1ZsMDRDaW95N0J0L0lwV1k4RnhqWjlE?=
 =?utf-8?B?YWFkWXA3U21VK3hsazB4RU9GK1BRNjRZVWkxaTgrZjh5NEFsTHpLNTBtZ0dp?=
 =?utf-8?B?c3p5K05yY3c1QTlaeFVzRWZmQUlJUWZwRDJDUjMwdGovaUxTWEk0MEU1Rk9Z?=
 =?utf-8?B?NjVObnY3SHRtQVlFc1FOWnRteDVOYU5zdklpbnE5cko4K3V1QlhNNkFRQWp0?=
 =?utf-8?B?eGtxRGlSakdEakJaNTd4YlJ0a2NXcHlDSENqRlVqVkJCWlg3cEk2cHJBQ2Zi?=
 =?utf-8?B?RXllcityNm0vUS95ZTlUWFBXTHJDazRLd2RyVlREK1lFMnNUeWVxTGlSYThr?=
 =?utf-8?B?YXNIc1NwTWdPZEV1STBkUFBVU0dWZTQ5ODVNVkNGUDFMZDNxWGZEandZQXBZ?=
 =?utf-8?B?dHVCaGFsWW03ZHU0QVZzcVQ2UTAyTFE1RWZ5SERIMjdoTDdxSk90TEk3Vm1a?=
 =?utf-8?B?RGx0NzdNZkliOHA5WHBIamxpVWZoaHlEajQ4SDFmMVpVOWVra0QvalZpSmtG?=
 =?utf-8?B?NTJnNGR0UTBzZTNveDNlVURaM0N0a0doUTZTZTVXWWQ3WndnQlZranRuczlD?=
 =?utf-8?B?Ui9aQm1QQytCUU9pREZQWHdhMDdYUjhsNjdtUFNTeGpRbDRPeVZEbG1KVTh5?=
 =?utf-8?B?akRMdExVWCtLSTVqV3dCMFpvcHRCVDNvOWFLRy81bHA1dHVtRXlLeHlreVVR?=
 =?utf-8?B?MkFCMFFLamxMR1hDNVhSb1FTOUVHSm5LZ2tJQ00rcnlydlN6c2xWOEUwZDRv?=
 =?utf-8?Q?ldC9eTNtNB3HDvG9FPn3xT+FG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 631c5748-642c-4ca1-8c5a-08dcf88a4a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 02:26:41.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foFZLcTnQrAXUfU6oHB/avUMbbq7UQnZDKqhQIqmytR8nEVmMsvngdrROE0+BkNz9V1lRllo0iRGxP0/XmoD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com

PiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+
DQo+IFsuLi5dDQo+IFN1YmplY3Q6IFJlOiBXQVJOSU5HIGluIGxtY2Vfc3VwcG9ydGVkKCkgZHVy
aW5nIHJlYm9vdC4NCj4gWy4uLl0NCj4gVGhpcyBpcyBhIEtWTS9OaXRybyBndWVzdCwgc28gdGhl
IENQVSBpcyBzb21ld2hhdCB2aXJ0dWFsaXplZCwgYnV0DQo+IC9wcm9jL2NwdWluZm8gc2F5czog
SW50ZWwoUikgWGVvbihSKSBQbGF0aW51bSA4MTI0TSBDUFUgQCAzLjAwR0h6DQo+IA0KDQpEaWQg
eW91IHNlZSB0aGUgc2FtZSBzcGxhdCBvbiB0aGlzIGhvc3Q/IA0KSXQgbWF5IGFsc28gYmUgd29y
dGggcGF5aW5nIGF0dGVudGlvbiB0byB3aGV0aGVyIHRoaXMgc3BsYXQgb2NjdXJzIHdoZW4NCnlv
dSByZWJvb3QgdGhlIGhvc3QsIGlmIHBvc3NpYmxlLg0KDQotUWl1eHUNCg==

