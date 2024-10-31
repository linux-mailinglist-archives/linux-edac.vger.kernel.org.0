Return-Path: <linux-edac+bounces-2368-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85ED9B741A
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2024 06:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEDE1C21973
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2024 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904D13B5B7;
	Thu, 31 Oct 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzcvj7BZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E713210D;
	Thu, 31 Oct 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351944; cv=fail; b=csDrKU6IykdjNKNqQd9PMc3zwOMlcogqRSB4isc43O71wqvvh7eqJwXVKrpv9wYGgjKvXIDMz1R/GBAaWteZIC+z+TioH/GqS53CfOUUVSwuiFyIojjVoeIWNKxWNCiaGhBiwLIK/Ksvs6VA4MNI+NVpEjbxhPY8n4Fd0tF77/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351944; c=relaxed/simple;
	bh=GSjP3agfO+vfQCu4RqEase7dmzY2fZdTt/UzT+t06MU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uMF2KysYWiHQf5msBV1S/Bbb2/LawDmVSisMCRDv6lKHb/BKqr1vtyTe5uqfBjWJ58OFxvDUCvuf2g8XZiEveEdxhRF+apASii/IbP+l0CVcQW+1dowULptOZuAenELL6i4+2FkifC9FBIur1NYH44mvv7v+kHB5TK/LYCcQBZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzcvj7BZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730351943; x=1761887943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GSjP3agfO+vfQCu4RqEase7dmzY2fZdTt/UzT+t06MU=;
  b=lzcvj7BZMHsRerQ0f0mCXBeizAUn5uE6S5qvrzRIVKHX1FtOD4le5E/x
   tTu9UpiK/qmtvNJZpgxKKuois73a38FlU+Ant9UvE+4ev9CE09MKxPn+3
   zvk02naPrTbE1AjEmOBmlAHiqrQdCdzV6ljE2J8pGFykq4xCiTnA25WeZ
   xXosDAPjTB8J6QLPX4WNpHL0BTysB0EFt9Ue4bF+2IGD9C/V2cH5SZT8u
   pftCesAHu8KbZ1lpA0UpBTbTLaNda19PsZu0J2PEJgBtloOb3BQIXI53i
   pjHu5/CVf13qdss9eDEb1qBiAIHelVDrXdcPOUpYmy69Fg2x9qIr9uwIg
   w==;
X-CSE-ConnectionGUID: Uy1sVMRhR8mH0gxBylPhJA==
X-CSE-MsgGUID: U0+/LoVtSAmSE1JnpDQFOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29971308"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="29971308"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 22:19:01 -0700
X-CSE-ConnectionGUID: W/j5/F/0TqGg7FSZ3AKBtw==
X-CSE-MsgGUID: XMTvzqe/RsWipwIPPNYEyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="87309399"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 22:19:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 22:19:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 22:19:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 22:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlijKD/EJvoXvPVSmZMMSeLpBbH6F52IWhwe29iq+04KIE1wP2+JxXzu+oljL4fyUjhZ0+hbvXjCPJ9Nm0cICDQGqLkgZnBxSf+29GXmLY6UeFJBJwgoUxn/wMeTKiyWSZ+mcXd6fw9NduvPvQNmtvjbCm/lvQ7Y+/meeG2IWTAwf9kVoBNMhFZRg0v96y+gBkYqYUpu9oiAMGeOJUFMkyURHFBsbrbtO+7JHC+0gE7HqkPR4RIIsBfk56bpiWT7KJYegNQx5kGXCMHwhqlx96B/vz8O7hs2fVMbFdbRbvvmOyYo15wkY9u/bEECJ9iN/UQYB3JPDlHCRtMFX+ZvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSjP3agfO+vfQCu4RqEase7dmzY2fZdTt/UzT+t06MU=;
 b=uQykpL0L/RQ/7qJHjFaBTPgm3IJv2mIMF304BQolMkfc+01R3v2Bk8pZWZspZtqyQPMjHQfypL9KTDHMVp6nTMYAgN963rhqJ66vtawQ+gjvMnkTpDYh5SJHb0fOMnTH7dzH6Oggsp0tfB/Eow+heZ+Dtj1hfql+H1qmPA4p5eFu4isfVfXXw1LhzEyCvz8ILoxeObJ/Db/Yoeys62wyxEJjppAbdgSQXIN7mmujXlE3IpAB4CneHaH/nuopjgsSqMxA+MQt6+kBJ6jAywaJuNKtuNgkjenGpIgzd1XYY95JWlk5WYBXOYMMXGue0i2Hza7mHXFyB5K61YsLqyO2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 05:18:55 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 05:18:54 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "bp@alien8.de" <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Thread-Topic: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Thread-Index: AQHbJougQzANe61d80Cc92LJLibtebKeSO4AgAA7hUCAANscgIAA9E6Q
Date: Thu, 31 Oct 2024 05:18:54 +0000
Message-ID: <CY8PR11MB71347AF10C3ED8FBAACED62C89552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-7-qiuxu.zhuo@intel.com>
 <20241029213920.GB1229628@yaz-khff2.amd.com>
 <CY8PR11MB71344FF8D9EA706AFA74618A89542@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20241030141635.GB1288714@yaz-khff2.amd.com>
In-Reply-To: <20241030141635.GB1288714@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: bp@alien8.de
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB6970:EE_
x-ms-office365-filtering-correlation-id: f8db6ea8-86c8-477e-f6f5-08dcf96b83a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzZqT2xaRFAvS1o5NTJ1R1EzLzZIMzhFcVRwWU1GSkI2cXRqMzA1d0k4dEdF?=
 =?utf-8?B?bWFYWXpxanBrTGlLbWVsOC9BdW1lQ1pJWkVzUzZQeVVncWg1VUl5d2p2K3VD?=
 =?utf-8?B?eFk2V20vRnVFSnpVWWc4eHBmOUdLTHQ4YVdwUVQ4ZmkrSmtoZktVR1FTc2tj?=
 =?utf-8?B?SDlScDM5TW1EYitVOENkcFNaNHdKOW11WHR1Yit4VE8rdVRjT0E5Z2tVazBQ?=
 =?utf-8?B?alJSeEZHYmRsRE1hVzQyS2NkZkd0Z2NSamZiUWVJQ3FlaVJBT1JkOGNyUWxV?=
 =?utf-8?B?NUlZc1ZRMlFUZlpmOW9pc0p1ZVE1UmxKd3ZlY0c3OWlHZFlvT0djb0VqcE1F?=
 =?utf-8?B?aWdDeWI3M29UTmwvWFcvQXRhMGF5WlBKS2xDNDZRQjFTaVZsZFlqUVlwSVJH?=
 =?utf-8?B?aXpXU2xoQUhLVnhxZHdvTmdWM0hldXNSL0ZHdXdtMExuSS9Fc1pxcEJWblZy?=
 =?utf-8?B?M1hHOVhhc3BlaWlHbUZFODlZRFhtZ3NmNnBqUGU2RE4zeW51U0FzWE5FNU9K?=
 =?utf-8?B?dENQYXNiMjRTN0dVSVgrQkkvckNWU3lFcXFVOEF3VkdmVWVZaUpLN2thVVBp?=
 =?utf-8?B?QzJ2U1RTcE9ZNFlUVnk2Yi93cVNsL1ZRbUptZE1Cb01ScUpBM1lpZi9LNHR2?=
 =?utf-8?B?L2luenVRR205SVlTVkFEUlF1L2h6dXZVWGNCRExubFlPQkw0OExBemF1N2JT?=
 =?utf-8?B?UkxZZWZ1L1RocEx1S3hCZjdqWFBoUlRzWG1CaUx0a09FM3htaGZSV3kybUNQ?=
 =?utf-8?B?SFlnMzRVNDdoSE5LaGFnRm1lSUx4NktkTzVYS01aMVJNblJlV2lRR3NzdHlx?=
 =?utf-8?B?dlVqQ0tsNXZoRTZ5dm9jY0pHTzVkWUx0c2N1MHNHRVQ1YVZaMzdsbTlOU0kv?=
 =?utf-8?B?MUN4ampaTzZSOG13eVIwY2xLOUVvZ3gvYjZaNkhrRmdRN2RZUUJFQzV1RWJG?=
 =?utf-8?B?bFc5M2hXQkxyMytLUkUyaEc5ZGxwLzNhWWJXQmRYRHJsZ3NHeWZQMWlvZmIw?=
 =?utf-8?B?SFh0WDIrMmYwYUw3Q2NWR1dPYm12NEdQUnlIVXpPWlk2aERNZ1E4V2ZxQVE4?=
 =?utf-8?B?cjVhaHhOVXF5eEU1WlpSMERKZTRhV2Q2YjlsWHREUEp2dHRuUkpHbmNkQTlU?=
 =?utf-8?B?Sml2bW52QVJCMUl4RDBLL2Y2NDhCaFBQU05LSHFPejBBek9yQWJIYk1JUkxO?=
 =?utf-8?B?bGdYS3p2SWxGdVY4WXhYZElLeXFMemk5bHRQVmpDOG1XMXgxUkZKL2FhZXpU?=
 =?utf-8?B?UFZKNURrSGNIQTFWdy92UDY4M2F3bkhHMHNQeU80UVdDamlGRkNvMFE3ajB6?=
 =?utf-8?B?S011V0psci9vWjBUSmFBUnp4UEdIekpES096U1N4SEdGMXhDZ3ExSkRhcnZJ?=
 =?utf-8?B?SE5QTUpxeWg3RlRhVE9RajF0MUJRdmMzSHYrOU5uRnFwOExOaU5DaVhHTmIy?=
 =?utf-8?B?Y3ZGUHA3T3FoVm8xUVpER0tEWitpSE5hV1R6TjEwVzRlcXk4SWFTYjRCQ1ZH?=
 =?utf-8?B?MTd3SzNkTFhYK3R4eFlIL1V1OWJZeHRsMFovTytBZGRPMVVkQTFxM01GTDIz?=
 =?utf-8?B?NTB5UVMvLzZmZ1pHSFZjT0t6NU1FSVp2eUUyV3lTdGVTRDkrZjZ2aGd4UFV4?=
 =?utf-8?B?VUx4dHpFa0Q3Z3lxNzFjOExNNlVHWjNHMFNWQ1ViWXNiL0N3S3M0K3VpMUQv?=
 =?utf-8?B?WU9OSER0RHZYUW1waXAxM0Y3SktlQWRLSkhELzJCaC9oVXVuL2J6N1RmZDNq?=
 =?utf-8?B?ckdVSjhCR3FqUmpxMnVwQkRCRHVaK2JOeUFPRUpBeXk3SWVvTDVLUTdFWEdu?=
 =?utf-8?Q?8SV2LlnL4iYqvXJ8UjbwKnjypwaLNQ539d954=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTNUZVN0NEVITEZ2ZHRyKzlKeVJ3bGxOUDNyT0VrUlpXdzd0bzdRNExmdk9Z?=
 =?utf-8?B?QWhMbnBlY1ZuZWhFZEdaYnVQMzB2L3l5M0NFcTZiQmlqZzFyZnJTTzl0Z2hh?=
 =?utf-8?B?aWg3Uk5aWk42RGUwM1BjUnpLS3dHRE56WmV3VEFlbnNDcXA2ZWMydkN2QlRD?=
 =?utf-8?B?cVM4TzBhZFZEK09Db3ZBRkhoVzF3YmhITVo3NHozN04rd0NkSjlQajhYZGNw?=
 =?utf-8?B?OXJlL1FJMTlzQWVuU09DYy9POXlYM3ZZVFFXdWZqUStHdkZXYTIrbUw1Y1lZ?=
 =?utf-8?B?dm5CdEhQV2RDdmd0cDV4TzdaWTNwWGo1R2JNcHEzaXVobkhjM0NEOGRpMEVH?=
 =?utf-8?B?VGtTblQ4enI5eG9QTXlvMDhqZ01Bb2I5RlU4NFdvOWthYS9QK1ZaSndCLzZp?=
 =?utf-8?B?ZGIweGw4eksxUWg1TVF0bWpSQVVOSG0rWU1GRXMyWlVoT3ozZnQ4THl5Q2N6?=
 =?utf-8?B?SUV3bFhIQUVJcVhpRzRrS3FNb3BQQlphTHptY0NpWWtZZ0pLVU5BREFjM1Fx?=
 =?utf-8?B?cTJERVFtdHA1eG4ya25tN3Z6dHpyT3VyWk1vdDE4VUowRy8yU3pIT3RzN0xK?=
 =?utf-8?B?RFYxZ3JYSmRycVRjOEIzdkFZcHd3b2Nua050MVNyYzFZSzlKSEg5YzJOYlUx?=
 =?utf-8?B?VTVtVWUxTyt5dkJ5OEFrRi82Tm03TG8zeWMzTmtCaW1HUUhUK3pOcVFITXhp?=
 =?utf-8?B?a0I2QmlCSllSblYwdDlta01JNU1YTFV3UkhKajVqd0tPME1oN0pDdG1XT21E?=
 =?utf-8?B?dnJld2gwdzd3cjJtUFY4WkpKdm9ORm9YamdDNnpsOVRTTU5UVEVxL3NZVEtr?=
 =?utf-8?B?WkQxZVVvYjUzdUJkVzJhOUtjMmdFb25EZ1lwMkNGaHhPczYvTWlKZGRKY25J?=
 =?utf-8?B?NGhmR3prdVFJTGlLMXV4bzdleG03b1R3OWZiQXRoaHZwSy9vL0xZU3hEM2Zw?=
 =?utf-8?B?ZXd5M2RpZW00Q05ERU1BK1kxbFZ2UytMakU1Q0dxTlF2c05FblZSazV3RTds?=
 =?utf-8?B?ckRpY0JJa2lFMGs5d0NKR3Y4L2k4ZHBJSzhSNlJQQVN4SW9aTDdVRVV0NzJt?=
 =?utf-8?B?d0U0WmFNazhITndMcDEyOTJ3Njh2OUNnT3BVeXFMb0ZUNkc0QTI5bWpQOVEw?=
 =?utf-8?B?bXkyWk0zUnprNnpENFNFS0ZWQUZZaUJpT0c2ZUFHZVRiSWR2TzM3WEVRWTZy?=
 =?utf-8?B?bWlZL2xuV0JNZWVLL0t0ekhlemJlZEkrYkxNNmd5MVdXejk4RDFrbVp2NHdl?=
 =?utf-8?B?ZGtBRXlmUUV2THViQUVRNVAybm9BT2tRMVd3RW95SmtUS1JRRHRLY3A3cjUz?=
 =?utf-8?B?N1VLRnJOSmNjOStVQld4dmhtRU1uMmpBb0hZT0VBWEhJVkdZWFFmU2ZLWDlC?=
 =?utf-8?B?bnF2UytqcGNGYmFJWUdwYk9pYTR3TDQ1VloxZDI2U2JaNTRMWE95dmc2M0JI?=
 =?utf-8?B?cTJTZEthR01lWmN2cUN2Y0xLMWEyOU1oY0hGV3UvQTZhQ0E2QTk5bkMzZkI5?=
 =?utf-8?B?TndQbVMyRGxldHhtbmZFOFZrWWdYM0Y5YURSYVJTSmV2OUFhdkF3VUw3MmdN?=
 =?utf-8?B?UGx3YndvSEtaL1NHb1gxQnFSOTVnSEVPN1RIdTRaeGQxM1FnNkZHb3I3MTFH?=
 =?utf-8?B?NFk0NVgwWWRGOHR1dWs1QW9DS1RiaHJGUzFqdHlNUUJ1amJZQ3FmSVpZYUQ0?=
 =?utf-8?B?bHg5UUk4dk4rK2luWnpuQlA0NmlUbmsvYVRyd05ObWFqSGFWeURDYjRWWHA5?=
 =?utf-8?B?VllKOXJiTnZvTUdoZHFuU05aK201TWxLZzRVWm1xSEl2TDZJR29VSkF1cmVk?=
 =?utf-8?B?SUlYYktnUU5XRFkycGFqSlg3NUd3NldaOWpyUnM4aWM1QSs3QzBFVFdYeDVv?=
 =?utf-8?B?c2J5VzBEaDZsM0NaS3JjVm5qUUNXMnlaTDZkdWVTRW9XMzdIeldxdFBGOE1F?=
 =?utf-8?B?b0ZsOXF1YkJSelNiZ2dBWEJJNTc0NWVCWDVJODJyVW91bnAyTjRRY1RPNUtL?=
 =?utf-8?B?ZE4xNkxNS2lReDVWL2lYZU5YdkhEVW9NbXdIbG9wNndtWUZyYjNaaHA0ck1U?=
 =?utf-8?B?Wmk2VEU0WGVZeEEwM091Z0s3VHYzd0FZMkpMYlNZQjc4MzhNV2l4K1IvbkZY?=
 =?utf-8?Q?agzJ5qCsjdbOMttQivm4+SSNk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8db6ea8-86c8-477e-f6f5-08dcf96b83a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 05:18:54.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oqQypg/T+zv23VJ3NuJyTb2sHB6GYLhH7JC/8Ssb04/WItgfweJWygIUeHvNtD8RiVYHqsa+dIjX8evNgV40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
X-OriginatorOrg: intel.com

SGkgWWF6ZW4sDQoNCj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29t
Pg0KPiBbLi4uXQ0KPiA+IEp1c3QgZnJvbSBteSBwZXJzcGVjdGl2ZSwgbm8gc3Ryb25nIHByZWZl
cmVuY2UuIPCfmIoNCj4gDQo+IFNhbWUgaGVyZS4gSSBqdXN0IGZpZ3VyZWQgdGhpcyBzdWdnZXN0
aW9uIHdvdWxkIGJlIGFub3RoZXIgcG9zc2libGUNCj4gY2xlYW51cC4gOikNCg0KVGhhbmtzIGZv
ciB5b3VyIHN1Z2dlc3Rpb24uIFllcywgaXQgZG9lcyBzYXZlIDMgbGluZXMgb2YgY29kZS4NCkVp
dGhlciB0aGXCoGN1cnJlbnQgcGF0Y2ggb3IgeW91ciBzdWdnZXN0aW9uIGlzIE9LIHdpdGggbWUu
DQoNCkhpIEBCb3JpcywgDQptYXkgSSBrbm93IHdoaWNoIG9wdGlvbiBpcyBPSyB3aXRoIHlvdToN
Cg0KICAgIE9wdGlvbiBBIChjdXJyZW50IHBhdGNoKTogDQogICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBtY2FfY29uZmlnICpjZmcgPSAmbWNhX2NmZzsNCiAgICAgICAgICAgICAgICAgICAgYW5k
IHRoZW4gdXNlICdjZmcnIGluIGFwcGx5X3F1aXJrc197YW1kLCBpbnRlbCwgemhhb3hpbn0oKQ0K
DQogICAgT3B0aW9uIEIgKHN1Z2dlc3RlZCBieSBZYXplbik6DQogICAgICAgICAgICAgICAgICAg
IERpcmVjdGx5IHVzZSAnbWNhX2NmZycgaW4gYXBwbHlfcXVpcmtzX3thbWQsIGludGVsLCB6aGFv
eGlufSgpDQoNClRoYW5rcyENCi1RaXV4dQ0K

