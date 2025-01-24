Return-Path: <linux-edac+bounces-2947-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C7A1B3AD
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2025 11:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C783A39C0
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65A1D7E31;
	Fri, 24 Jan 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIgE8Uj2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B2155759;
	Fri, 24 Jan 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715442; cv=fail; b=tqFzcKArgyTFrDwZi+xgjJEV1Wlee1IXQEAHAd1TyR611w+GsIfzB9VTOthsp8nfiSejJBQf0UsrNmceSlHrVC+ZURoH80VXjw1fg0/kVphQbnZ3tcEkcmmx7YtHxeclGrV42uCkQ5t3qx/GhO2E/V2384VSNua6n6xg4mF/SeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715442; c=relaxed/simple;
	bh=SZVzzp6n4gMJhRAz/PYwFbYTk/x3Hj7DpvDnoXT1mZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIE3ystib4lBAin376L8pnuMhm4hy4SpLw6dJmF49S2IwijGKY+eN9TIrXDHmsC+8KyOLnDB6hxS5kyPkWBZgFdTG/anNo/1185TlGnOaqDheUD40ErwbBlUO4efC+Vfzt4iuEnKgpcljSRE6HLZ7GJsY3Zk0T/87+lppcmw9nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIgE8Uj2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737715440; x=1769251440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SZVzzp6n4gMJhRAz/PYwFbYTk/x3Hj7DpvDnoXT1mZM=;
  b=WIgE8Uj2063Qsmx5gD2e3Szfs1WgfptG2YpRrIUXjZOVOsnV0D0OnFVQ
   TqiVCl6nCrv9yDZwF+4R3RrZzM7B7e/kgYIooKjjU+bvcI0FFqVa+3qtI
   BkSEpG/lb8NvJqrESnWvT5sJZDde1g5RhQSLDVijPxs+sMCj53obwVV+8
   h1jLAo2UEA+4FZIO+mor4mV+cZv1+eP/oK3m+/YtgRvUP9hC6rpenxLXQ
   kAWIaNVhA4Lz79b9S10rcYXfvkS/WFnLLZyg494pd5TfFU6tytM63Hihv
   tuy/9QyeW2B4tX168FBMxkcNMCTm6wIf0nuPKVmt0J4ExrdcYaUSIHMkJ
   w==;
X-CSE-ConnectionGUID: uYtD8IMqSR2uvvEyl2+few==
X-CSE-MsgGUID: hvM/jm2YTQG/leTlic1iWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="55658657"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="55658657"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 02:43:59 -0800
X-CSE-ConnectionGUID: sEXtfW2DQ0ONg/Xc+Pm9+w==
X-CSE-MsgGUID: K1xxOE02R2K6sC6AT4aj/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="107861698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 02:43:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 02:43:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 02:43:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 02:43:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYUWGgJuwHdpr2Iv2bm7nsO5tJHwbffLOzV2EiqAt6Kc9AAsppogp5uxTHXHGQXGj8ZfKgPuFCTbJVBdZnDvKgmEbj3p43K3LOQAbKmCALJ6GJpaEr/vgSrcsERRnoqgFtojIFj14V6F4MsngdtFB1wxC5IosRbTEvdjTdpWlxRkVnCHBLtaM3SM+0QVskVBgZn4fb7hjZNOo3niG7PpVPF7AZci90rrbaffVTsMnNILQWhkVlMZD7+xOMocW5OWWkp+9bk6OEE6jx/rwD7xByJVHhfr73eFu2foMjLwZRIbSXcPW0iFzN3zd7koif/6M+hRA62Hqdeh+2+DQlk+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZVzzp6n4gMJhRAz/PYwFbYTk/x3Hj7DpvDnoXT1mZM=;
 b=VpFXVRbqRLfmwPFzIzLpeOjVL+rbIDvELX/8VxgUB5iQag1VnrV4+Qu7NiNx+o7NQAo/PeAscdGyETDSHw9IOkRTQDHK9smWHJI5wbzXJ0pyxe2sRLH1BsXkSQzwgJ2erpOFBQZKFUVOwhTsmBLBQS7UQXzrVOqs2zG/+lKx9h0sZq6QfjWRuDr/PsubdmB7LKPfLjyERL1FqGu90jTqGlGKhxY5tBAftoPtdV6fOo+GaiDIErz38AgYG03hOZMXNZ+TeKIPszc4+T3mMOSOyJgn+oe3TbG7Ai6pzyIJx5nMRNtQNczKo4cXfUyqidmJbEiOkNVztl4U1YedwHzY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB5947.namprd11.prod.outlook.com (2603:10b6:806:23b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 10:43:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 10:43:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: RE: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Thread-Topic: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Thread-Index: AQHbZyBULE3CljfIAUqEblQV0t0RvrMX12qggAAXOQCADdavUA==
Date: Fri, 24 Jan 2025 10:43:42 +0000
Message-ID: <CY8PR11MB7134D97F82DC001AE009637889E32@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-4-nik.borisov@suse.com>
 <CY8PR11MB7134DEA89B78F45AA20C1C2E89192@CY8PR11MB7134.namprd11.prod.outlook.com>
 <9eb0be50-c051-4e71-9d7a-4e609da1266f@suse.com>
In-Reply-To: <9eb0be50-c051-4e71-9d7a-4e609da1266f@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB5947:EE_
x-ms-office365-filtering-correlation-id: ae11f818-64de-4bb8-926c-08dd3c63f8c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmNWYlQrOThTcFFGQ21ldndXNlFWbVdFWXF1VzYvU0U4SzZkY1VvMzFJSi8z?=
 =?utf-8?B?dXllbmh0Z1pBckVtT0JxM3hwcVlPZjZUaEo4WnFjUnNqMUFVS2tuS2RnbzJQ?=
 =?utf-8?B?VytacFBYcjVLa25Sd1QxYnFGNkpZa05EdUVnUjVvdlJmM2lYMmhuWHh4Zm91?=
 =?utf-8?B?UDZUVGNzc25qMkNMM0FzOXJ6elRPNjYyR0NUQ2RCZ3oxaHNBVlZCZlJNcGxO?=
 =?utf-8?B?ZEJhd2UvelZtQ2ppaHlaSGtyVWdMOHgveThkNmhLVmtzNkx2ZmRoZzBIK1Vh?=
 =?utf-8?B?eTBIc0s0ZGFhRyt5amJrT2hIR2ZXUXJxdUlzVElpNWlFaGtMN2FoVFhzemZZ?=
 =?utf-8?B?eGk2Z1R2MnVXS1Zhb2oyZmtPWEM1RXU5SS9yNWxJSVF5cGN2REU4RjJRdFpO?=
 =?utf-8?B?dzhqaU0zazhOSklmT1RmYklCNUdlaUZKdHk3TGUvR1VnYkZ4K0JuOE1RWTR4?=
 =?utf-8?B?akZDUjNhbWN5M3FpNHBrd3F2QStHNk40YW9yT1piRVBFdmNUTk05eklPV3dX?=
 =?utf-8?B?U0NWajV1Z25QQ2lrbmZjM1FIc3dVVnI1YjFpOVFJMExMY1pMZ3o1WS8yVUlj?=
 =?utf-8?B?aVdMWnFQbGFJVG5vOEoyNnBHWThWaEY4QWlTUGZqclB5cUJQL05mWHp5SGFN?=
 =?utf-8?B?OHdHcjhCaE4vakI4ZE9SQVlSS2MrMGovVmVFcDFjTFVCRWUrancwZXJlRGJI?=
 =?utf-8?B?ZHNJQ3p4UlRCTTVLdHozTG5OZXV5aElEcTNoeFJXVzRtdGNtV1RJRGs2QWNk?=
 =?utf-8?B?REdROGRYMS8zMVlHWXVaS0w5d2lPSUVDUGVQNzR0NmJFMWVGU09qVnV6eS9t?=
 =?utf-8?B?a1RyWVB5dnVBRGMyNUR1eGErUGx0ZVcwc2lPZmt0eWozanB2WFVrRnF6N1lK?=
 =?utf-8?B?WnhlRHdnNEsydXFKTnNFRTh5OFZWNW1rK0R0VGE2K21lRDBCdXBMWmRuSVBt?=
 =?utf-8?B?c1pOSUQxaXp5QjQrZm55cjdnUVVwdXlpVm1pM1ozOFUySjE2dkRlZkZabDMx?=
 =?utf-8?B?Nm94V04xcGpFdGdkMC9WQzR3MjNjaUJ6N05QM1pnWTVaTjh3NjJZYTNmNHh5?=
 =?utf-8?B?M1VCNU1PVjNpaHdGTFZsTVNnM1NnRi9OWWNOMmJtL21GWXhOZkZ0Y3h0L3Vl?=
 =?utf-8?B?eFZERzduWEROSVNyeDJpM2R3VUJCT3B5ZCs1c2Noa2NhaDI3eWE0TFVNbExj?=
 =?utf-8?B?UDI4eXVybjQrMEt2VjNXd1pSR0w3R056Y3hsbUx1Q3ROOVFEQVo3T3d0VFI1?=
 =?utf-8?B?d1NhZnZreTFFNkNXbGFkc3BtM1RiclB2NmdWWTN0anFmZDFCbVo1R2k3a0VX?=
 =?utf-8?B?dUxkbHRTU2p2aFRWQmI2QUE1YXpFcmNRaE9hWkdEU0RvSnd0eFFSdVgwaWpF?=
 =?utf-8?B?VWJRV0pTZjEzWmtKTSsxeHRSQ2l1L1BCd29USFBVRmlEUDNCZTJzQ09oR1d3?=
 =?utf-8?B?d0xtTitzNW5KUWk4UGVxV3JXQmVwNmY5cjlCNVBxMG1kZ0Y0aGtuSUZNZHNF?=
 =?utf-8?B?OUxvRHg1WHR0MzJka09rR0tKb2ZEVVdkY0ZpTm13T0lONElBdncwTU9icnJI?=
 =?utf-8?B?Mk9IcWtHMHY1bGlBWlV4ZEJwYnJKV1ZpdkkwcFhhWVlkbXVIRE9FM25hMm9u?=
 =?utf-8?B?ejhhUWl1dnkwbkVyTHhxZGJoTDg3U1ZudDJsQ211VyswRWo1L3pIMThBLzZK?=
 =?utf-8?B?R3BaL2RuSUZia0d0QktreE5DMjZFOWZsbkE2WEJIdVlWZ3dydUtjbFpXVnYz?=
 =?utf-8?B?VmlGR1BneHAwNVYyNGZXS2g3OXBDOHQ1Wkx1OG5HbHp3UlVpZ3BrcDVTS3RF?=
 =?utf-8?B?Z1I1eGRJbWRIQWNza2NubCtTYVlKOGlEZi9QNnBtVTlHRUtER0orcklaNDlE?=
 =?utf-8?B?KzZFamJidFNPemU5RjMzSXB3d0ZNZ28zSlpNU0NoZlphcmZFZktJYWpzaE9r?=
 =?utf-8?Q?tUEeTx0UVcD8TLx3GiHmv1X0UMJXUWx1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2ZESTF0ZW5kWkU4Y3FGRVYxMnI5VjFjQ2d5UFB2UHgxdnJoSEMyYzR3alNj?=
 =?utf-8?B?dEF6ZW9zdnQ0bDMyWmRsSXp4VHFUUGpRbjlvcm80Uyt4WFM0UWxLazVsT1dT?=
 =?utf-8?B?SnhDQm42d2ljNGtyQTVldzZpejFWd0pZOEFjNXRwdVVZVGRFQzdvYTBaRU16?=
 =?utf-8?B?UTlEN01xVnEvOEhSR28xbWUxMnBFUnVld3Y3TjlycUxtWlhJZ1NUOTZ4WHJx?=
 =?utf-8?B?Vk5JYlBrZ1BwbGRPeW5hZG9LVHdnQTh2TDJUejFVWnFQODFwNjlUVEs1SFow?=
 =?utf-8?B?SGJybm9PQjRwVWs5eWI1dHFoU0JjVnZQL0MyVjhNRC9oU3M2dEh2cnZ4Y2pV?=
 =?utf-8?B?U1U2b1BrMnZKRkM2MHhPRDBRbmlrd3h6bm4yVkI3K0FycDZoYjlUcXhsZEZz?=
 =?utf-8?B?alZLWlRmQ2x0TGNhSSt1MTc4bzI5ODllUjZvT2dFdEJJODkrTjB4OFF1V3VP?=
 =?utf-8?B?allUdTJ3WjR5UExhUE4xN3Q3a3d6L0NmTzM0R2FxMm5DUS9keVl3SUVzOWFO?=
 =?utf-8?B?TzVHMU5tM0lzaXU1cGRaUkFXdmdoa2VrKzZOK05VakMwVklZNDV4c0NVNkhk?=
 =?utf-8?B?MzZ2dlVnMGE0M0w3T3pyMXFRNUMwTlNTc05BTEFnMzFKZ0ZTWWhpaFlCWGZH?=
 =?utf-8?B?K005RkpwKy9GRFNham41d3ArS2NKRC9ZL2xFT0tnR01xT1BTdUplRnhneWNi?=
 =?utf-8?B?UmRRa2ZIRTE4dUlCSXd2ZHdDZjNEKzNPMm0ySEs3MFdvaklSSjFEcVZDT1VO?=
 =?utf-8?B?ZUZNaG5yemFKMldEd3RiL1h1aThnUUJ2UExnZzRxeEpqM3NxZThHalVDNHFN?=
 =?utf-8?B?V0hzbFRTT2R4c2FIYWYvWm9OTXNuZDlEamQrWDZjSmtHOTc0cm1kcUVLMDh1?=
 =?utf-8?B?Mm10V1JiRGJNdXNrcFUxcHNrNVFUL3F0YWJ2cFdLNmpyMEFaYlAybWRZaDRN?=
 =?utf-8?B?RXlNVzA2STFWRFM4SHVSckhLdWtuQVBRK3ZkSU9lQTM2NDlFUlB4NlliR2tw?=
 =?utf-8?B?STRiVm0zQWVCRTVQYnR0WkxCcDVacUNaYTUwTWRlSHNwUnVmeGVxdkJYRVpR?=
 =?utf-8?B?VW9xWnJ6cDNVQ3FhWldwM3ZMbmxRY2hlR09IWkc1K1M1dFNWZHd1ZmRycnBy?=
 =?utf-8?B?MkZaOGRqcFR5VkhtOWlBQzh6eFRlZnRGMGRsdkN6Z3ZvQzg2S0poL2wxSVcy?=
 =?utf-8?B?MU9uZnFxQmRuS21ld3d1c00zY09qcWFWZ3JvWW1aMkJmMFFudDRoM2FRaDdm?=
 =?utf-8?B?TWYzdFcyMUEwVFY0Q3Z4VmtMOHgzSmVYNGhhek1LVlMwcFVNeDgzNWRLSDFT?=
 =?utf-8?B?WXk0TVVGM1lmckxaRmVCWlloVnFaajhuVkdzYU1zVnBRa1pqS1FncW5iWnR2?=
 =?utf-8?B?NFh1TVBvd1VBcVNXSy9ZTjdzYVBxUVRZaGk1TGtMTkF2RTVIR2ZMVHRQbDlG?=
 =?utf-8?B?Q05BNE4wWFFHQlh4YVA2SGV3WnZWYWpEVVloV3hqR0tUNHpud0pVVitBWFJw?=
 =?utf-8?B?NklWcmZpNVBaM1BDMHY4Vkk2WlpzQ3Jpek9ZUklsUk93d0ppbVRPMlpicjlN?=
 =?utf-8?B?b2MxSXBpQ0lXalRNRkNZTnUvSWIxK0kvdFJpRkhZY1lPM0VGTXlIbmFMOHky?=
 =?utf-8?B?Qis0d2dDbWRtODY2eWVBdUVXNW5mLzJYem5FMWpMZ2lKRUFiMEhuaURjU3lD?=
 =?utf-8?B?bFJmY2Uvays3OUxla2FYQlVVcE5MbHU5NURqb29pRG1ETW9vYWFtT3hIYXNn?=
 =?utf-8?B?ZHdrTlQvN2szdXpMcnB5M0t5OE5FVUV4cU1UOHYzbXFOOEdnY0FMeUg1b1U4?=
 =?utf-8?B?NVJucHcrenBkT2ZmczJSSkZpTzIwMldZNEpwTFJWUDJLN0VCRmllYXZhN3lw?=
 =?utf-8?B?blJod1I3eUxrVUJqSE94amZjV1lEZDRTY3V1Q2ZPb3RnOURQdjR0eFZkUC9h?=
 =?utf-8?B?VHBydFU3eTZZVVJRU0FmUUZ2dDFtcUxCalVBV3BjaVcrQVJwcGpYUU04aG9q?=
 =?utf-8?B?TlV5bW43eE85Y2ZNSWxadVFJREhTNTlQNEFRVWJyekxrR1IwME4zRVNnc1Np?=
 =?utf-8?B?cGt0QWgrK3pWeXUzdjMvekN1WSsvTHVtTWVNcVV3WnByVTB3aWI0RFJSa2Mr?=
 =?utf-8?Q?vJdtWEVJEk8Mv/e2MN6wB3qol?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae11f818-64de-4bb8-926c-08dd3c63f8c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 10:43:42.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmLOxO2HAcBIodtYNJ12k7ywGkkx+orDSQl2u0/xmxBc+fabZ4iQsr5KwcCoTiMshhju58SG7qHw9YhFLRFmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5947
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBbLi4uXQ0K
PiA+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gPj4gKysrIGIvYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+ID4+IEBAIC01OTEsNiArNTkxLDcgQEAgRVhQ
T1JUX1NZTUJPTF9HUEwobWNlX2lzX2NvcnJlY3RhYmxlKTsNCj4gPj4gICAgKi8NCj4gPj4gICBz
dGF0aWMgaW50IG1jZV9ub3RpZnlfaXJxKHZvaWQpDQo+ID4+ICAgew0KPiA+PiArI2lmZGVmIENP
TkZJR19YODZfTUNFTE9HX0xFR0FDWQ0KPiA+PiAgIAkvKiBOb3QgbW9yZSB0aGFuIHR3byBtZXNz
YWdlcyBldmVyeSBtaW51dGUgKi8NCj4gPj4gICAJc3RhdGljIERFRklORV9SQVRFTElNSVRfU1RB
VEUocmF0ZWxpbWl0LCA2MCpIWiwgMik7DQo+ID4+DQo+ID4+IEBAIC02MDIsNyArNjAzLDcgQEAg
c3RhdGljIGludCBtY2Vfbm90aWZ5X2lycSh2b2lkKQ0KPiA+Pg0KPiA+DQo+ID4gVGhlIG1lc3Nh
Z2UgcHJpbnRlZCBpbnNpZGUgdGhpcyBmdW5jdGlvbiBzaG91bGQgbm90IGRlcGVuZCBvbg0KPiA+
IENPTkZJR19YODZfTUNFTE9HX0xFR0FDWS4gIFVzZXItc3BhY2UgdG9vbHMvc2NyaXB0cyBtaWdo
dCBsb29rIGZvcg0KPiA+IHRoaXMgbWVzc2FnZSB0byBkZXRlY3QgbWFjaGluZSBldmVudHMuIEl0
IGlzIGFsc28gdXNlZnVsIGZvciBkZWJ1Z2dpbmcNCj4gcHVycG9zZXMuDQo+IA0KPiBUaGUgdGhp
bmcgaXMgaWYgTUNFTE9HX0xFR0FDWSBpcyB0dXJuZWQgb2ZmIHRoZW4gbWNlX3dvcmtfdHJpZ2dl
ciBpcyBhDQo+IG5vb3AsIGhlbmNlIG5vdGhpbmcgaXMgcmVhbGx5IGxvZ2dlZCB3aGljaCBtYWtl
cyB0aGlzIG1lc3NhZ2Ugc29tZXdoYXQNCj4gYm9ndXMuIEFmdGVyIGFsbCB0aGUgZWFybHkgaGFu
ZGxlcidzIGpvYiBpcyB0byBsb2cgdG8gdXNlcnNwYWNlLCBpZiB3ZSBkb24ndCBsb2cNCj4gYW55
dGhpbmcgbm8gbmVlZCB0byBzcGFtIHRoZSBrZXJuZWwgbG9nLg0KDQpDdXJyZW50bHksIHNvbWUg
Y3VzdG9tZXJzIGhhdmUgcmVwb3J0ZWQgdGhhdCB0aGUgSW50ZWwgRURBQyBkcml2ZXIgZGlkbid0
DQpyZXBvcnQgZXJyb3JzIG9uIHNvbWUgbWVtb3J5IERJTU1zLiBUaGUgcHJpbnQgbWVzc2FnZSBo
ZXJlIGhlbHBlZA0KbWUgY29uZmlybSB3aGV0aGVyIHRoZSBNQ0UgZXZlbnQgb3JpZ2luYXRlZCBm
cm9tIHRoZSB4ODYvbWNlIGNvZGUgb3INCmlmIHRoZSBNQ0UgZXZlbnQgd2FzIGxvc3Qgc29tZXdo
ZXJlIGluIHRoZSBFREFDIGRyaXZlci4NCg0KSU1ITywgaXQgd291bGQgYmUgYmV0dGVyIHRvIGtl
ZXAgdGhpcyBwcmludCBtZXNzYWdlIGhlcmUsIG9yIHVwZGF0ZSBpdCBhIGJpdCBsaWtlIGJlbG93
IA0KaWYgIUNPTkZJR19YODZfTUNFTE9HX0xFR0FDWToNCg0KICAgcHJfaW5mbyhIV19FUlIgIk1h
Y2hpbmUgY2hlY2sgZXZlbnRzIGdlbmVyYXRlZFxuIik7DQoNClRoYW5rcyENCi1RaXV4dQ0K

