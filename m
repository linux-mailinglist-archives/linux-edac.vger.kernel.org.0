Return-Path: <linux-edac+bounces-2412-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E89BA34B
	for <lists+linux-edac@lfdr.de>; Sun,  3 Nov 2024 01:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E1E1C20F6D
	for <lists+linux-edac@lfdr.de>; Sun,  3 Nov 2024 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F6433BC;
	Sun,  3 Nov 2024 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTG1PbAP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908238F97;
	Sun,  3 Nov 2024 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730594572; cv=fail; b=ogd/q/su0ptfzMKhC3iMngJGTIQiCkTtJKoY8pamN/S1MYbr3AlMvdSHvpo1DfAkXYEouC2EfJHGU3p3OOR1dfGiEH0eaMb4Q/Ysae97gxXSOTmeC1u2kdi+3HoaUOW1q/Ad09vfONHpZ5KG5JBCrcqy0vpwUkyPsEftjwRCWok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730594572; c=relaxed/simple;
	bh=koSAnmpHKdt0dR5oI6DGT2E+uB9qL7Apd3Yaq5+ZoZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvHZzq6k08CyVXrB/X1L86lw7Yk5+TW7mVY+QK40BDljqBIIgzScnosNDfVzIp7q5FB78N6m4+RBxBdampYjAZGLdwWOhs/eGgpvqYpSYd+NJARMddrHNcIW5tqvAdkeIFQpn7DhP0WdgyjoYpgHRlzBcL4wVYwtKeXwZ93M8ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTG1PbAP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730594571; x=1762130571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=koSAnmpHKdt0dR5oI6DGT2E+uB9qL7Apd3Yaq5+ZoZA=;
  b=KTG1PbAP4mh8tXz56ZRbk82pfvJBWcgQMq5s8AISGtlVGpy96z276mnU
   KMke9Rcr1gTbDSc1hhI/TlOdwv8cTbjTuo0XtxURg2s+PW/ZzEeRGx8XG
   bOmqX8JeKqkvnKsW/MlqYvFGLgiFFsH1lpjJOr1aLkstpqMiPVcv9PeKi
   ujDK7NlC4zGlShClb4p7A3tYnrrmUFCwm9PAe3EcQSh9iYvIGgnt+h9XB
   Er8XWpAqmy8NuLb1QgZjs0Q/bg34XNNLo9rSYTNmWD4WIlBvNMQKTtmwC
   /j/1dlwW+T/tmLh3Q9ocFk8AYW8AqxLWbh5G3H5GT9N5SzChYqUAXh4hE
   g==;
X-CSE-ConnectionGUID: JDEhvkp9QMaJYPu6ih5JwA==
X-CSE-MsgGUID: os4EiVCES12YRKSjsNMDVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41415315"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41415315"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 17:42:50 -0700
X-CSE-ConnectionGUID: 0tyT/kRpSo2kCs4dTCYmDw==
X-CSE-MsgGUID: JMiuuVy1QsSGFAfP+MElmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88062247"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 17:42:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 17:42:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 17:42:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 17:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC7/d+pVxShtv+qj+L43I4uXHD4HfMMNgc89xrmNtidI8cp/HANkBF1vdKFoRZ+xe9Tqqu4sG2VEvPj1Jpy1dQM6AH9gRZ03oz02ftkd2aWA145wSzqd28hn1w+YHSV7EBd4/r1inVTykbCb0dD1jBsBh8oTwTIaxXdmb49akOXkAYRdmYUVS7p8MWPNftj0X2LCCxOrZ5nh4dDyons/MyXp2Uo9OsiLkTmRxnN8R1lJeZFRpqRwrmOApctSu+UapWy9hnJOc+zqLWt1f0W6KULUrq6r5IsDP7XJvClONN3f/V8X8/CKHTUc5rn1zGRuoViJYqq83topBCTsNIokAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Sf6LXsp/Xwvh8luEzr6OwmB6ZKEzve6azebni8mI4=;
 b=x7OS6j9KqeQzeephDpdXjP64vzK6W3elXDMKYMSVZ7ojAGEeOZrxOU/kEGd8PBydfkLjGQ3Mng30xJrB2Ft95QTkaN7NE04RRWzbT1Ov90CBPTU1WBBOApO4Oy8pHxFGPX4/cqQTjisIXE6Ud9CdWZm1nbAzXp853R23qO16elu9fC8Tvh5RltAxlJgXEGC8L++TfIR04k+jE7tGdBc9OVXGxgKExj9WF3VLKKZRPVlX+sgYYrFCtc93QzbQv4FT8L5xLYyTDkRtCt78QGIdirkYZrVBKtq72lY+8YU/TqjLOJtTa9zSm75zldutwByXmVxIKzYIUiSPmXFyRhZ9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Sun, 3 Nov
 2024 00:42:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8114.015; Sun, 3 Nov 2024
 00:42:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 05/10] x86/mce/genpool: Make mce_gen_pool_create() return
 explicit error codes
Thread-Topic: [PATCH 05/10] x86/mce/genpool: Make mce_gen_pool_create() return
 explicit error codes
Thread-Index: AQHbGyzvV8CT5wVO0EKGMa76je072rKkMX0AgACp2KA=
Date: Sun, 3 Nov 2024 00:42:41 +0000
Message-ID: <CY8PR11MB7134A8A89F8CCF83FF24803489502@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241010153202.30876-6-qiuxu.zhuo@intel.com> <87ed3tr9kn.ffs@tglx>
In-Reply-To: <87ed3tr9kn.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB6899:EE_
x-ms-office365-filtering-correlation-id: c2db251a-083a-4d81-2c6e-08dcfba06cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?92BeuUnp/YELOLGLZPtIIa2w0XSg7d9jHClwVBr99A4Ct4Z2ZvhuOnPhpt/z?=
 =?us-ascii?Q?LtHaEBKzuqBnDC2+8RFtBGvnioIY12MEp4PjDSoHrjrNao0tXfuCk8h5XIwI?=
 =?us-ascii?Q?w9TWRcwu0pW+o31UGUS6shgXF+vaUSQxAggOMQ3FGp4YFybAOdZOP/kb0asJ?=
 =?us-ascii?Q?Fa2KCqjZAGSsi1ruvWhGGzHCIqkR0dMmXEP9coV+tUvdKIrtXmAZq8HOvF6Q?=
 =?us-ascii?Q?UjzIDM/sFxyfgAd2sNW72eaIvzeGR1U3athbZ/IuRvc5KZj6R0OjZRVc6ZXa?=
 =?us-ascii?Q?zbxa5plH7FBMChkxCYoysjZZ0k7twWPzV0IPWrPnlalejEdubi8/xefsRQ8T?=
 =?us-ascii?Q?7Qzd2yhiB20kfg46wPou4YzIcTciWJLwazifcFFJ6PBHzUkaiDdSpoqvM7g6?=
 =?us-ascii?Q?f9RXmjKhSjY8wt3zjxihDbd3tQRU3WDOV8HXOzb8za1j4mlLzBt9e2HbFC9t?=
 =?us-ascii?Q?f+YgQOnrlPW6+PjZosbr+8xAa5EY+fImViyisXa/l1XBSRiGAxWOaDLrnAX6?=
 =?us-ascii?Q?5ipXMDSFJoARvcqbNh89jJQ56y8muFOeOjgDlcPpL3903VBrYeBdD9cBSvEl?=
 =?us-ascii?Q?MfhONGd0Cn6etsLh0zNe0KlNKGXdPpLKNF/1QOU0IlKHAUEihG4Tsl81Usou?=
 =?us-ascii?Q?fMMyKMvdCA9pkj5/+REMFGGLE8Kf7zxHy8Q84zttPlOhz6LD9tMIb6yLm9bv?=
 =?us-ascii?Q?r3l6AV4asrber80WBQDC3nUPv6zjR9EOfjPdW+6tvpk5Vj5i4aGCJ78NlWHo?=
 =?us-ascii?Q?j/G3bppApyau0Zww6qdwNg56zOxB2n5WkaMnDi3pvG8S4MACAjI4OQ6FB53U?=
 =?us-ascii?Q?O6yehbifmvJfKNOaCssYVrjWYyw8su4S6ygUGKLd/dkpIDsMzsJ2brdpi6PA?=
 =?us-ascii?Q?Z0kAzgELkP1Z71IFY/FQQTTuPzdOYMV9EVXIbLtMK74zdngns8Ze04wry85p?=
 =?us-ascii?Q?642gGczFisvAtD+gIg+dA6KilJha/EziDPdeUbT0KhXDNQNl8D6TOGfCLKAT?=
 =?us-ascii?Q?ltBKmPV6dOTG37CbxUaoAi8XDKSDz7qjNOHVdn9qNlTsi2fD0Su2jUXXQ2Wq?=
 =?us-ascii?Q?tFOHHNxY+MPKtoTDRmPK8QCq6HmEuu4irU+c5JHkwloYMv9FOorM8gS961DO?=
 =?us-ascii?Q?wyGYA0uGEnnpNlvaVL0oOp6ylTEGe+A9E+7y6jlQE6OjMoWLUJHIIxp9SfiU?=
 =?us-ascii?Q?pUinTHkv3hCaaiTzZQVG3qqQm9DTlJHud3O2IRZkBA8+ijZlPK7qdQIurU4Z?=
 =?us-ascii?Q?jCUfIxvdpcX9ovlhqcNGGAMWs39wcrMoXav1ET5ZUwrUP5/4GC5emaOj9Wbf?=
 =?us-ascii?Q?IjEr6k5+9kJhJoq6Nbb7r1O9J9zfk13GsewE0xeyJId5eL1q6cRPqe5VvSSK?=
 =?us-ascii?Q?J81/ifc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YLXEqfzf1s2FxQ3+IruS94nzqplKATQdEBWVsYaPJPCvFpEfdq6mMS5lBax7?=
 =?us-ascii?Q?4NGeWa2QQsFSoF3xKzSJdBnJ5eXe+fQoyEiyi9ifZbOFU2fOIJvpfyIKyCBN?=
 =?us-ascii?Q?c0AkrPfTnR3dfTGHsV8F8ahhuvHJLJkPFDIlDyTb+zCvgOqSqq8VmkHRMV9s?=
 =?us-ascii?Q?3d/OUweLpdWjkof1+RTOHZdjZoz1K4TIm2kXiNmgXZ3zPDB3ZIg8ekfdhN6e?=
 =?us-ascii?Q?vm0X0vad0DWNGPYLrsT8MzYucU7tieZ1DeYteg1BepO9FIbqZQaWNW03cJuc?=
 =?us-ascii?Q?+WTyfPifa1XQtsrTjR5ULB1p9oXggiFjI0PBqQ+PqUqbRTj6mGqHCW8Pvdn8?=
 =?us-ascii?Q?lx1C19jae+CkZZvOR/2UnkgpQg212RZba++gjTCBx9S0o0ACNli8weetRTG5?=
 =?us-ascii?Q?Kbi0vpk1HQ5IHBH5kJOqGYBB4Ek7FgrH8XS22SAeoZ3afnwnG9v51F67eisu?=
 =?us-ascii?Q?NaPJKuD36rr0mUbJ3YJa03F4XyMjShJ2F2qW+tyU4IhW+MzzifT5admxlie1?=
 =?us-ascii?Q?3VAD8qIioUT4nqaFmAUs3k6BcjAOWPhhF0WbWnVmb1n7ngslGUsKuI4d0Pwe?=
 =?us-ascii?Q?jUuoc9ci/eYNUYAecAqGhp5JQrtks2wwdlDRsXhb1CeFPXsa1/CbMiJpCC4C?=
 =?us-ascii?Q?FMpOR//T6mPEbjlSKAgsdGUhJeKTDhQBNFNJ+sI0bhCnZr7GgWRbA2YyOHKY?=
 =?us-ascii?Q?+rW2zBOimIuM/oht9EbVkmOHQsyupWZGvJ6vS+zQDhjOMzD9KWBUNb88uO3D?=
 =?us-ascii?Q?kVBbw9M1cHOz4dpLUmytYm3tvkj8hb+nPcQ6lRYfNazzGXoEbXrbYqJBrn5l?=
 =?us-ascii?Q?/3SLAU/NIADamAa9S5kuXLx6jPX6F8WTW1Jv+recfADs9mrNWCP44+KGglL3?=
 =?us-ascii?Q?gPhHUeZG/YjE/nTCMwsRBe+hlJee5aXumJEAzo7pjuGZADmjYYnE0M1qDB3m?=
 =?us-ascii?Q?gYaAsbGUJo4ncuorkWsv4ndlIrd4vuEKBsN7pF46w1kuDiWBYvB5T0Rqi5LQ?=
 =?us-ascii?Q?kqeGMABt15RAT+92PQ1eY106VwMrAq4f0J/nvf3TkyrfzWkHoUGo/vN6Q6C2?=
 =?us-ascii?Q?P+5ZHT3DGJV2GyU7mSUT2Og3kC/VutdvwGvC9LLw3jp5rCBTD4Kr8ZPZpF12?=
 =?us-ascii?Q?rsHzPhmN5JiTVasBh5h2hky81doNeumCqGnCwPzDIJR1TQPRmg8WvS30Da3W?=
 =?us-ascii?Q?R/IWfRq2UQj/LMvZeL9+OoVWf78mfnv1WeRldu/NBLHvnW422pxBqxLgd863?=
 =?us-ascii?Q?BTevcsREJbCEdmhWuLA8P+Iqb9X8VYspt8JhdASLfaenjMbCf/D1A9N26u6T?=
 =?us-ascii?Q?RfzraFa1CXaXSeWuULyxTBH/T7BzaV7FPD2zOE7BtNxcBjXwON6O+yTCAUwv?=
 =?us-ascii?Q?z+NiESY97kKlUrPZpbkEcyRakH0t+CW8qJxLmZuzEUgFMxM1C5UIZhJgNMj1?=
 =?us-ascii?Q?WSVjkUevE4mZ+9AXUMVd4beXXLCTCizBQXrkpjDoMDgzGu4J0s3vjkWElACp?=
 =?us-ascii?Q?EWgL3Wm6fEhNCgNWsf4RVTkABWLcnYMivagOg7LWXcoP68OX4iioSmHlRCU9?=
 =?us-ascii?Q?tk5ZBmEzlZFykwq+YwX015K2B44rhNTfftYpMJeN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db251a-083a-4d81-2c6e-08dcfba06cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 00:42:41.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qh3J+yyV+7i5Fcb19jGqli1YWN9qh4aSQ0ALE+tELUJydbXGH/GIzfD75eS7ERRMRADZdusG5nxd+zUge4+6Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com

> From: Thomas Gleixner <tglx@linutronix.de>
> [...]
> On Thu, Oct 10 2024 at 23:31, Qiuxu Zhuo wrote:
>=20
> > Make mce_gen_pool_create() return explicit error codes for better
> > readability.
>=20
> What's the point?
>=20
> All error paths including gen_pool_add() return -ENOMEM.
>=20
> The call site just cares about success or fail.
>=20
> So this can simply be converted to bool and return true on success and fa=
lse
> otherwise.

Yes, this way it's much cleaner.=20
Thank you, Thomas, for your kind guidance.

> Thanks,
>=20
>         tglx

