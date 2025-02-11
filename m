Return-Path: <linux-edac+bounces-3009-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56FA3012C
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E3A1887C91
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066926BD8A;
	Tue, 11 Feb 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0h9OxoY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942C26BD84;
	Tue, 11 Feb 2025 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739238922; cv=fail; b=hnBvNIfrhkoj81yX38VyHlp2wdHeDbb2QG1qLzEUE3S12EdXS9GGYFBM8no9THPbAYX9d8alyoQV8iY/QD6Vhw4Id+tEHtNa9IWQaLbQQhEUyoLez0peXqfD0cPsPE/2QeYNEmWIfK30jU+RPxkQE4bhsufiZ199HqF6N3Q/etc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739238922; c=relaxed/simple;
	bh=EUkboqv/cMXEjoQOgp/wx/GsOcpkjWZ0Lg1XCYFP4Wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=diSuuEpOo8GLOC6fFdspmRB6tgduH0FvHeD9g88JZHFNpq2YE4LQ40tV5o67cwvtntsgMDYFoJmUoHuU9iG6Wdb2Fs+b/71io/MnDULNi92XdxdjYmt5LfRfxFxqgSPUSPr0D/T4tsoIxDquyEMSjM5ZGKbVTFJ499V5SzKvlRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0h9OxoY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739238920; x=1770774920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EUkboqv/cMXEjoQOgp/wx/GsOcpkjWZ0Lg1XCYFP4Wo=;
  b=n0h9OxoY90RX6nLwyIWaejNl8bxpvNooVpdK7k4e2VjR7ywLME2ryaPa
   NN9LOHVljy61X2q0oeZYXj75dFTwINNiavWE+CaJkYA0U0b7zsQA1/sIv
   MpVSjpWVb32DAEXKrbHH0f9niTa5KWcznUYg13/9r9oAc8+7hC3ezLO80
   wwMG4qRiWBTQkmNl4I7g14mzFz47sYqf+Rytk2FdUmlb6jLPP0pMazGSt
   dLOCKs4uwT0VIM7wcine09SAn/DspFvPUfdZGcC0XFKUNIIKtJP1NO7nq
   n/nF5K1O34Y8WTujdwDIRexcCKenH4QCAVT+jhVDqtuUem7BfBca/bfVm
   A==;
X-CSE-ConnectionGUID: 6h+aiYAnS1SPux1MQcicCw==
X-CSE-MsgGUID: nQiCBClbTtu9m+IYF/20jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="51237401"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="51237401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 17:55:19 -0800
X-CSE-ConnectionGUID: ts4pD277Q72Ncw0BNZB93A==
X-CSE-MsgGUID: tsUzNh/TQAmTwiRClMtuxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="112880684"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 17:55:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 17:55:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 17:55:18 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 17:55:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHn7kj+5OFtREP1MMIO1bRnY8JMSHTSP7En0aqwMkaXJdpg85YP302uVLtspJetJIT0cbj42XKzIWKNjxyxqMGDX3wK6Kl/K74RKtDPo6L10oK9GBX3fGt3X7Ir37Y5BSqfVNqbo505aL2ehyNc2sHUODBZQONeLjClq+9hYh61fVhVynP1oCu62Ch2KeVg1KKeLbezpXtIaFZ6hfWHq1FAsEhzitasF7Cs3ZPfjYKEJiqlv7txoyDoPl3ubXWDZtgOO6EGy+Gt9itWKzhtXRxdfCubneuYXM3c9C3NCq0neBFH50vCulBwxaSTpfPFfbvfiQHmgKqQnif3FkuKs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUkboqv/cMXEjoQOgp/wx/GsOcpkjWZ0Lg1XCYFP4Wo=;
 b=lhPm4cl/80IEPPojWmpumGn3eIIZBwDuEGypLBL76UowKPTL24zu2Q4lTVo+u4FSGwebCeStqXmjcQo1KozZzbSNGIS8OiiljVBePxa5mep2qrLuZtz0EpwlopdvhR7QuRgEK74e0c//0fUi4itjVqh/cRdcNDppfOT0lCwjf7+5sQrDe5g+TdtW7fi7oDu34/rOo7mkuTJc5U8e0pB0XmTCbk/AXZtxh3YEWmoafNMyzo/32LDLcMxwGznk+X5E6hhgJ5xF5kw+NaHyApUwhmzpr6d91FaVxfZUaLiUQ8NVw7eRV7cQiSKRvOREQrXP4WVudazbWO/NdJVciRbckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5113.namprd11.prod.outlook.com (2603:10b6:806:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 11 Feb
 2025 01:55:15 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 01:55:15 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ramses <ramses@well-founded.dev>
CC: John <therealgraysky@proton.me>, Linux Edac <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>
Subject: RE: Flood of edac-related errors since 6.13
Thread-Topic: Flood of edac-related errors since 6.13
Thread-Index: AQHbeOe8nlKhFFXJVUyTVIAGkw2yWrM7Kj3QgABoeICABJ3RMIAADzCAgAEcTlA=
Date: Tue, 11 Feb 2025 01:55:15 +0000
Message-ID: <CY8PR11MB7134C4D5D727A523F8F3CC8D89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <OISL8Rv--F-9@well-founded.dev>
 <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11.prod.outlook.com>
 <OIUifRt--F-9@well-founded.dev>
 <CY8PR11MB7134358940D4625E5196349B89F22@CY8PR11MB7134.namprd11.prod.outlook.com>
 <OIj2FiD--F-9@well-founded.dev>
In-Reply-To: <OIj2FiD--F-9@well-founded.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5113:EE_
x-ms-office365-filtering-correlation-id: fee1799b-b9e4-4309-4b2d-08dd4a3f212c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dm5QZmd1Zk8rQzhBY0JrYkhBMlhlTGVjQ3NmTXRubzF2SWVUV3YzczRSVmVl?=
 =?utf-8?B?UFVOc3lVK2lRaUsyczN4ZE9tS0JEZ1ZDNlRCejBoY3crN0Q4Q25QOFRlbHpp?=
 =?utf-8?B?cElzU2Y0dTREVXo4U0sxM0JqU0tCTEE3VVZ6YW9maldoYkhmRlVqNENKakpv?=
 =?utf-8?B?UXU0cWEwbkFaQkZoSmVpZGhpOTU1MGRCY09kZG1ubFNQc1lheHN4S2Nqcysv?=
 =?utf-8?B?ZmZUeDZCRlZpc2JZWG9Sb3pVOXZjWlQxWmlSUnRjREc1T2FhT1JoRUVxSENW?=
 =?utf-8?B?ajZiNXZKVWsyQUlNK0VJUWtFWTdldFFmQlE3K3dDWGx1UU9jRUJncXNIcWdJ?=
 =?utf-8?B?Qm1kU3pUK1pwU3piTDVKMk43dXZRMjdtR2hQbCtGQkRuZnRpRHpEekVQMGgw?=
 =?utf-8?B?aEhiSDNhS0VGWmhFTk03UVBNa0NEa3Q0UW9VM3QyUTUvMDRObUZaYnpKL2RZ?=
 =?utf-8?B?WXZsdjZ0UnBqeHM1SFMydmtCVUxRMnUxWDJNSzNQMVFxOHEzSDZRak9qQnVm?=
 =?utf-8?B?QWRuL2U5cnVnalRNcDBiVmd3dHZFbjRPNVlpZkVWSDFEV1IrU0kxNlhHRGU3?=
 =?utf-8?B?WGVJU05wditQR3pyTGZwdmd2d0VkWG1HNkdmSlNrVExOc3QwU25GU0tVNzFK?=
 =?utf-8?B?YkgzSnBYaUtIKys1dGFkNEcxeEo2cUpVWFJPYTM3MlVDMDhsS3pRMDRlMHV2?=
 =?utf-8?B?ZzQzaE5kSHlaY2hBU3BjSE9sTUZZQjRXVFJzdmIwbjlNQTNWKzZadGltR1Yy?=
 =?utf-8?B?ekhLdkk2UzBvR3pkRnFORXBUZXlMUnJTRjU5NmpPK3NyM2tJeFk3UFh3d0RI?=
 =?utf-8?B?cTM3emxoUWQweGYvdGozdE1jMzhtVm12eGlmTnRtb0c2RHRzT0NGdWsvaFhk?=
 =?utf-8?B?V2tJemdmeDJ5d1JVUitwVGtsbUZvZGxKUjc4QjFDMDNSa0xGS0tUUmlkN2V3?=
 =?utf-8?B?MG9Qb3hITEhvK3FtZW1RVUxiTGREcDcybElXeGJYbVBaV1R4ZkkrVUlPYWRu?=
 =?utf-8?B?Z2dZLytPek5WOTBaaWhycjJjZ2gzQzBWSmN6VC9PTVZsUGRXWk1sVHc0USsw?=
 =?utf-8?B?NVdVV1l0a0RDRTZFbTZ4UDZFWTAxa3NYczNrNk1GcXVqNlZVY1l1OXhQb1I3?=
 =?utf-8?B?ZS9HclVuMmVnSnNUbUJBRHFZWTNVUnFaaWpsd1hST3lVZTJNMEFyNEliVjdz?=
 =?utf-8?B?OTUrYVk3a1lmMEZrTEs4SmNVditGMHhwajY2Sm5KclJSK1RUZERDZk14K0pI?=
 =?utf-8?B?bmRyN0o0eXJsUGZoczlZVU9wYVdBdlM5QnJnNGhZOFdCblc0ZzZrWlJqYkth?=
 =?utf-8?B?NmZpSmlqTlhiMmdtZEpBR2lmNStySlB2d2JsNS9nWnB0d3hXS1VVRFh2V3Bl?=
 =?utf-8?B?UnJ0N0VOaHlPOFhOV1cyN2JsSjNUbllvcENxVmRwSW1NSnczSSs0TlltY0Fz?=
 =?utf-8?B?azV4SGZ0NlJVZGZWMWVvM1Z3VjRkQzdTK2tiQ0NLN3Y3VmNtalhQU1dDekFL?=
 =?utf-8?B?ZldOMXRaeTZtd1RNcGp6ZmZ6OXhxanpOSVZXcWJ0T3pqQ1h5TmI0T0E1Smls?=
 =?utf-8?B?NllqLzk3NjhJeHE5MlZVVHFaU1NieWFLUis5UWZCN2hTS2tUZFdLaTBDYWRr?=
 =?utf-8?B?ZXZpc21Sa3poY3ZXRExzUmVIRTNJMWhZY1ZqMTRocndoQWpYV2RMeXFyZEtQ?=
 =?utf-8?B?M2NUS0JqOVZSTXFaS3d2QkMzR090eWxudXhYYmZ5MEllb2FFQ3hxRXg3V1BQ?=
 =?utf-8?B?WHo1c0g3QnU2T1VXWDUxeHEvMzJMUFE1K1B2YlBKQ0NmamxGMThGMGxFUkdZ?=
 =?utf-8?B?dXdSKzFCcWkzYVRuRG5zTzU5dHYzUXFPYUlwelNvVkhobUV2UVhyRWtabzdz?=
 =?utf-8?B?M2RJcWhPajdXOFVtUnF4R2FvQTZUVUMrMGR2aDRSK3hqRjVOZG5jbWN5Sjhl?=
 =?utf-8?Q?1WhCpKO8W4RRsiu02mga9MqrkuzAYNlh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDlyNjNZYW9lM09sQ2RLYUFNTmxudldnbEhGNTZBcW5lOW53VGZpOGVHdXZu?=
 =?utf-8?B?dlJ5RXg1eWlFcnd5WmtDaUNMMUhzZmxiV1Q1cUk5RnNtTGNSckFVdEp3Q1p2?=
 =?utf-8?B?ZkRFODFKaTJUREt4TXNjZXBZa0JkMWtGSFlHODhkcVVMeGRWRkZScVlXeEdW?=
 =?utf-8?B?Z2NpeklFZFBXYXRZRG1GZWM5bEpqUStlUk53WWhtMkZuaDl3emtsbzl6YnpH?=
 =?utf-8?B?ekliVjJNRHpjamUvbnVKZ3NhTDQxTnV0aDhQWXlUUFY0U0JiYmZ3L2tSV2lP?=
 =?utf-8?B?MERhWUsrMDZoRmFlRUI1MFpQZ0ZmK0lZbUZYRFNjaHROZVZuckhiTm1JK1ph?=
 =?utf-8?B?YUtIbTFpNHlsUEVUaHlYSGxQTlhMMys1a0tDOEhHQXY5SncwcGFoOG1lYTds?=
 =?utf-8?B?VXVHeXdIYlA2RjRzc0p1c2M5djh3bEF3ZllYNWQ3TytlOEY0Z0pSWnN0dHJa?=
 =?utf-8?B?ZmtSOEY0ejZtK05MOVNKcnJxU2dTajVGODgzbE04RWliQmcrU2YwN0FPbXAv?=
 =?utf-8?B?T3NYQno2b1V1bURyakZkN0hJbUVGRnlERGJuSXhTS0p4azFrTGtOOG53TkhG?=
 =?utf-8?B?MGNPU0VTS042RFN5ZWlwUlVSTHNIVHdiMWo5T2tVaHlWeWQ3akp0ZG5jSWR6?=
 =?utf-8?B?SnNUZjJ1bTg1cW9Pb2dBWjBuUG9OekV3R00wTW1WNGt1amdESjljWUU2dzlI?=
 =?utf-8?B?TFF2aXlITkdONzJUaktiSGV4UlJVMUVKUS9SNDFlQXBhQU92Ujd6SWt6YnJo?=
 =?utf-8?B?aW4ySWN4aFpXbU81ZkplUWxWdVN6OHMvc1A4Sk5DQU5GVVNSaGthL3BNbnFD?=
 =?utf-8?B?YzRJWDBrSmltM1djaStNOVpRYXhUU29QUjdsTVZYVHlPWmQ0b2ZJQ1JyL212?=
 =?utf-8?B?Y1Q2TmZ2TTlCR0g5S0wvSitidU9XRmpiQkM4NUdrTWdGTm1lMFZDQjlLVjV2?=
 =?utf-8?B?VW4zZDIxZ0NkbkxJYXVIZ2JNWmlTNnhsRHVrSlZldXpQcEpLWU1RdTRqYk9L?=
 =?utf-8?B?VGkyV1BjQzM5Tktsc3ZEd1hBcm1oS0l0aTJZRncvaDNlcHRNaHZiLzBzT2Y3?=
 =?utf-8?B?MElWUDhNWndWaUpISXB4NFFVSUZSeXJXdjFzQllSL2F1eXZmMHJZeEJsK2dm?=
 =?utf-8?B?RkdxS1dlVGZkUGtoWTV4MWhrQmFldTJuemZOQ0E2TVJyd0hNWEpzYWp4MEtF?=
 =?utf-8?B?V2pIczAwNkhFR0dHVVByL2VEQXBNc1dqSHVSQmRjZU91ZVRhV0d6OVpIUnZ2?=
 =?utf-8?B?VUlMZjFUVUdJOHpkR3VJMmNPMzBYRXVGYnZiNllqM3UrNitYRStYMWFuOUtN?=
 =?utf-8?B?U2FlR2kxNXVmSk5FUTR3UUNFRU40R3N4ODViY1hmTUg5cjA2a0tjK2thMzVB?=
 =?utf-8?B?ZU9ETjlKaFM0bE1xRzFwNElLbjN6bFRsQnN4SWl0QmEvcjNxbURTVExYYnRa?=
 =?utf-8?B?N3d3Rjcrai9wbEdHcFRwQ3pjMDZ5Ymh1K044YklhUmxXT3ZORE1vV0tJZTlK?=
 =?utf-8?B?T0NnNnA4WEVnTi96N2VoRG9DeitFMmd2b3c5VUp3d00zVXRqVFBCeWI0Mkxk?=
 =?utf-8?B?anZPWEhldlZSRmUzMkhtSmdjclZYcFExcEV0WUlieUtOVFdURFJ5WFlObTI2?=
 =?utf-8?B?TS9FeUUwSXhPUG16eGJPZWpWY1h0K1VuRmQrbEJ4UmwwZGdKZ21oWHVpakRW?=
 =?utf-8?B?UkVRM0lGM1dSMS9za1BZM1RhRDlwaGFTQThHSHBBTkQ5SDZVU3F4UXgvblNB?=
 =?utf-8?B?L29rV01yeFJiNlloVEFqUXhBakRGZWZyWC9LRjhFWHlKUmVmcXZYejVwcE9G?=
 =?utf-8?B?ZUp4WmFJU0tRSWtEcGNpRkhrMWJZeEVWb240OVd0MnpxTDI1WXBpTTBVZ3c2?=
 =?utf-8?B?UHIvV2xqMjdoV1YycTcxSnlwcncxSHRPcnRlVi9JTmI1SFViMWN2eitldGdJ?=
 =?utf-8?B?U1BxZDhQK1JRT0prY3dzRGxnNCtYdjZKay9PV3h0WUh0ZEZnUWRBRS9ickp1?=
 =?utf-8?B?OG1FbjQrc1FvMU0wQ3RMSHl0aXBHS1IyYjZwL01yeHBpYkZ4OUtnVkV5eGJJ?=
 =?utf-8?B?bjVTd1dveG9hZTRDSWpPVFBSc3BRdkVOYmU4T0Foa09yRk5aU2d1UnZTa2dl?=
 =?utf-8?Q?ONyIuq7/JB8tv3t5SU9RYg7cw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fee1799b-b9e4-4309-4b2d-08dd4a3f212c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 01:55:15.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00shnvNg1Fsn9aVjllGY3Fs/Edn6KSTJXhWBihzm57UdLrb8GpzamgYuEtIpY7tVyJqtRwfoaUnPVU9WSIm3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-OriginatorOrg: intel.com

SGkgUmFtc2VzLA0KDQo+IEZyb206IFJhbXNlcyA8cmFtc2VzQHdlbGwtZm91bmRlZC5kZXY+DQo+
IFsuLi5dDQo+IA0KPiBJIGp1c3QgYm9vdGVkIGludG8gYSBrZXJuZWwgd2l0aCB0aGF0IHBhdGNo
IGFwcGxpZWQgYW5kIEknbSBub3QgZ2V0dGluZyB0aGUNCj4gZXJyb3JzIGFueW1vcmUsIHNvIHRo
YXQgc2VlbXMgdG8gZml4IHRoZSBpc3N1ZSBmb3IgbWUgaW5kZWVkIQ0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgdGVzdGluZy4NCg0KSSdtIHdhaXRpbmcgYSBiaXQgZm9yIEpvaG4ncyB0ZXN0IHJlc3Vs
dCAoaWYgaGUgaGFzIHRoZSBjaGFuY2UgdG8gdGVzdCBpdCkuIA0KQWZ0ZXIgdGhhdCwgSSdsbCBw
b3N0IHRoZSBmaXggcGF0aCB0byB0aGUgRURBQyBtYWlsaW5nIGxpc3QuDQoNCi1RaXV4dQ0K

