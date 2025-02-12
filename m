Return-Path: <linux-edac+bounces-3033-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD2A32145
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 09:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD3A3A281F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F9C205506;
	Wed, 12 Feb 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujk0wWpR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5C2040B0;
	Wed, 12 Feb 2025 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349373; cv=fail; b=jWxm2AZBdPTxyToeYrK8Xnrx21VidNiM1byFGrPQFAVhcL1smFP33fvQzefhE2mlxNMbOR3HQ4sUEntfmKIjdOJ3JP4vbxEAb/3Ll2oTkgUwzuVxnZS2AkkeHko2iP1bp0wqvLtIfs973EZ9+qgGMdUzplAIAZJIGe/x+FzuL1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349373; c=relaxed/simple;
	bh=i/lUiWOyq1yTqlUAmff1TZEyU5CFIYaniQ2TXR39qxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DnJbp7m0gOPKl2Yxq8taXcx4EleGoH9jSmfZjZhxkV2f+OMAdVTzFd74WIsj/Z8y25a8ynNSmrbn9Azd/3/S+lJmVBSQNjdTDtrDRM5zHGtLqBUwwdEsmXv7BGe4uyinzkO00UbWHPHwmX0Jv1AInIxXe1NOL48AUh/sQyB7x9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujk0wWpR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739349372; x=1770885372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/lUiWOyq1yTqlUAmff1TZEyU5CFIYaniQ2TXR39qxs=;
  b=Ujk0wWpR+/hfEA1zVx4RM+BRhrWqsBbAKiVt39cll0ub6Ni3Qgpj9f1v
   xe9kvvtyEBrRu2vNDNknL4oQYC+jdqChfVqFfdReL08gnaGm2PdG/VgY0
   gUFMThQz9UuAqb5l01PcG1lyKryG/+8OwYAlec9QjLmRlYOG/vyTyCCYm
   b7uP/3BQkwjWRXuNYJQeCn0DK6srr0i8Ukumkq+j9tpVeqvgGo4mG82VA
   VqZB4v7L2Bn6FMV1Didrg2mHDb8u5lkcgl2GDONAxyjD7pwbrbFV9rKcA
   GvBfd3rgw+HFDCndCoCCNUIOJebtoScSGNVJkmlfGqXpaO2rWpB7HuNHY
   Q==;
X-CSE-ConnectionGUID: TzH18OGZQM+ZWElS/BlKbg==
X-CSE-MsgGUID: f8ciCo5wR1SorXw7QKbzGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43757889"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43757889"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:36:10 -0800
X-CSE-ConnectionGUID: SJQHzEvPRGKr3j5Km9+02A==
X-CSE-MsgGUID: +sPEPUpCSJ2MCRP73v7m7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112610845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:36:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:36:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 00:36:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:36:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDDg+Gk0mX/YWQX7TrDLN2RJyPMsLh9174bLTJVTMUBZMANEWa4ZMxuvHr1EJ0dLge5rIveckaSkbRdsMKzTqeZKG8AiDQiBZeaMK8Eb7HzxeQwvfBcU89mRaWyiUBm3PqfbsS/OjmgP1awsQqocVkVHgvHmqNciJIbnioJyE7fnoZCRibQB3j+wXm5GDVLJXbWSF04zoZbTTex979q536hsxWw1QoGjZKNWXAS9JrqJXGzBiaESbJ7cXCM+SVcCPO31aNFWxkYpVJHaKpa9bJUVmfmCAh7BFazgjqGNyVybsqdcoArf3yyi8KtcqmDQZrhjIjjVVxXgtgHqdtAB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/lUiWOyq1yTqlUAmff1TZEyU5CFIYaniQ2TXR39qxs=;
 b=Gp4PwXkJIp7M9CLFGSHot57R5oi2uiVvvO34746lUdPfqsWd1bO3SqqXFDZDrS/e56J+84wNF7ZIKYLNup90npQqJEigO2hYw5RQCMiWv43DfhbiFOpjSG+QNoJ0QWZsBbd9TvPM8E6eecwgmAYpuijEILXlhKEjH0yJhOBxjaB8hi5GOWgJODxDTDsyLaBMRTeXs+xf/89SUV8/hXRswNhTbcoCV1N4KWpYqx4CeK8jC7omw5LA+L/pU/dnfSKf1knzgKv5Hqy5ubUIwpHHUAwZPROJZpaWj0QS5pVCa+GBV9QQP8Z6l9VViHj7DDY6NIqXZ95ExEgoq7RbHKrflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 08:35:33 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 08:35:33 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: John <therealgraysky@proton.me>
CC: Ramses <ramses@well-founded.dev>, Linux Edac <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>
Subject: RE: Flood of edac-related errors since 6.13
Thread-Topic: Flood of edac-related errors since 6.13
Thread-Index: AQHbeOe8nlKhFFXJVUyTVIAGkw2yWrM7Kj3QgABoeICABJ3RMIAADzCAgAEcTlCAAS26gIAA1mvw
Date: Wed, 12 Feb 2025 08:35:33 +0000
Message-ID: <CY8PR11MB7134CF11A7F17DFCD413E68289FC2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <OISL8Rv--F-9@well-founded.dev>
 <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11.prod.outlook.com>
 <OIUifRt--F-9@well-founded.dev>
 <CY8PR11MB7134358940D4625E5196349B89F22@CY8PR11MB7134.namprd11.prod.outlook.com>
 <OIj2FiD--F-9@well-founded.dev>
 <CY8PR11MB7134C4D5D727A523F8F3CC8D89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <5Suws4N3ohcTi4z3uWVYN16n4119blnT1QL5qAzzj77LVEIPTO624pJPaE4Wj9kRdUUtUhAw_rM6tHKHXdSw3NtP4uPec9gl1wNFWUPDDYQ=@proton.me>
In-Reply-To: <5Suws4N3ohcTi4z3uWVYN16n4119blnT1QL5qAzzj77LVEIPTO624pJPaE4Wj9kRdUUtUhAw_rM6tHKHXdSw3NtP4uPec9gl1wNFWUPDDYQ=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB7579:EE_
x-ms-office365-filtering-correlation-id: 2c98fd65-067c-4fcf-ddbe-08dd4b40377f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cDNib2pqU01zZFhGcEZnWXZrK295VGk3WThhM3J0bEtrZDU1elFRd3RxREoy?=
 =?utf-8?B?MWIrTmd2Qm9BN1hmc2xZb0FjaFMzbm5xUW55NExORlN0R2xMNzdxZkxOcnR6?=
 =?utf-8?B?MndmM0JCS2I3L2g4b0oyZnh2Y3MraWhGUFN1eVBWaS9oOXg4NmFvSXpMa2Fj?=
 =?utf-8?B?MitKb0V3SWp6NUlPZG5hRHZzUURSSE5UbWlEelc2K1lvYndJbzJxaTM2YTNM?=
 =?utf-8?B?MjNJZGdDQjJIakVXYmNYUEJXQ3BBUmtubkJMUkhkRFFQTWF0L0FJV1F5cEln?=
 =?utf-8?B?OFRRZXh1bmQ4bGx5MjFrd01OR1NHQTg2Z2FFU0hsV2lUQjQ1TzZkdGFLTDM5?=
 =?utf-8?B?dUc4T1JKNDBSWEk3eDZMenVQUjZ2aTlJbXlLaWtiZjh3ZEd6anRnMkp6WHNP?=
 =?utf-8?B?cURaWlhlV2dtcXVVSVk0dk9rWCsrUjFQUFFtekJhNWpNanB5N2Z0citZTkpU?=
 =?utf-8?B?amF6STB5QTROc2JaRWNPNi9OQ3h0R0oxWkxnbWdCamE2eEl3cTNXREl5R1FY?=
 =?utf-8?B?dURDQmszOEhES1dNWFV4RlEwTzJoMEdqQVZITTJqcmhobE14aVJoQk0xTVdW?=
 =?utf-8?B?LzBxNTBxV25yRTNMdmJWOVVhdlVLd0tPZjVKR0l1S2NxSllhNkV1ZHhicEtn?=
 =?utf-8?B?aGdnaGlqTnYwSkN3UWoycEZyTTV3VVJHMHRGc0JPdnUrK0k4Nm90Z1NNblRp?=
 =?utf-8?B?SEZLNzVWUWhka3ZRalQwNWVLM1kvb0VjQ3NiT0l1eDJ5VDlib0Z2a3pacHhm?=
 =?utf-8?B?TkdIUDdvVnJ6YnNuOUk5T3dTMjUrYXlQMXRiSUlySjJoRXhTZkNyV3Blc1Ir?=
 =?utf-8?B?c3Z2dDVtNmhXTHlmdWVmNnU1SjltbG5kQ2hqN3NubDVIN00rR2xmdzV6U1c5?=
 =?utf-8?B?UitQcmhuZXI4K0JZaFVicVMyaGFhZWlvV1FiYWFRZ2g5MUVOY0RzOVlJVEpN?=
 =?utf-8?B?YkU0MmRBbnd2dnRqU2NuUUpFREJVREVDTUwwY1l4Q29DYjE3VW1pWXJLRVUw?=
 =?utf-8?B?SXd5aU1CVDBYbU9hWVhBRGlSZHQ5T3NJSTIrNEhYN1FNTE5ra0hnMkRoL2ZB?=
 =?utf-8?B?MTFuRDFJSFVGSE9YUExxQmhudGlZZUxBdXQrTmM0ZXltenM5QXh1MmVaTWtZ?=
 =?utf-8?B?a004YktWMG12THJCRWJVV21jNEgxcitkd3JMMTRFa3JnOXA4ZDZobURDcmph?=
 =?utf-8?B?bFUxRHk4OXdOVkVlMUdrODdHM0dvcDc5WkxmMzg3NGFmd3ZUWCs4bURZb0FO?=
 =?utf-8?B?TDd6UzlDT05sb3ZHSmJUY3FhS0p6ajFkNjhycGxBdXNJa2l2SU13WjRJQk5s?=
 =?utf-8?B?QkJVNzhkYTNtSXJYekd0K1ZEOVVPbVUrdjlndTgxdm5CZURxSitSL01ES29w?=
 =?utf-8?B?VG1xQVpCS3NNZzZRVm5nSVNTc2NpUnVzdXEzZ1ZiRFF5Z3djaWcyNGYzYnh3?=
 =?utf-8?B?VlVhdjVrd0dLTlZIdHpJb0hldFhzUGgwOWUwR3pjVDdjS0I5VEdKNmgvckhu?=
 =?utf-8?B?dStVYThIdEtsMDI0b1NkUlpPSG9NSS9zc3diWnl3alpwMHhrWm16amxJaDh3?=
 =?utf-8?B?ZktTV2sxKzN2T0RZeWpUOVZwWm5JNThBR0RGd3hzM2VXLzgraW9vK2VveE1z?=
 =?utf-8?B?aEpWaEpDeThSamljSmdzQUxFdzJjMzhxUDVHOHRETVRLbzJnaEhCc3hwWnJt?=
 =?utf-8?B?T2FsYjBDOW9OSXN5REdEcHhad0QyN2JuWXoxcEt1TnFDL3hJb01UbWFnd3du?=
 =?utf-8?B?Ryt3SnJBZ0IySFFwUStKNmR1cENZcXpnMDFucDBFSjZuMFpBMmRqRHMzVzM5?=
 =?utf-8?B?eFltZ2FTWVh4ZmlTSU95NU1IYm02SUVNSW5yY1hjRVhZejk4KzBKTjJjYkhT?=
 =?utf-8?B?SjZmVG1UM20vb0M1NytJLzVYQ1B3U1VFZHprT2p4S0V4MUIvVUNwM3MvSnJq?=
 =?utf-8?Q?nr9e5NURCHgh8ojCBxrs9uXDYf6hYRpi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEI3cHFnbGZZcldmZjJWRGMxY3dlYUtBeEVZWStrNFFDVjR4VWczdkJETCtV?=
 =?utf-8?B?L290NG5VV1VCSmEySGlLLzZ1Z0FubEtsOHlCMXJhcHpHK1VON0lPamVQUTZN?=
 =?utf-8?B?OExDa3F0WlNEUUxzdkdTTHNmbStLR0RtQnNrZ2RmeEtpaVZpYTFhQkhTNWk5?=
 =?utf-8?B?NXRhY3grT1dvUlFnbUdrbXgyRStRaExhS3cvQjgyR1k0UVRPS0NPMkxTcDB4?=
 =?utf-8?B?WmU5Z1VqMWNYTnJsOHlaNWhVUS9tVmN4Y3lhMlFiOHRScUkvWGpOL2VWeVNI?=
 =?utf-8?B?WUY1Q0hHVDZzVnhmRGF1ZWkveFRGZktxQWJwM04rNUNPYlA1ZCthYndTTDYw?=
 =?utf-8?B?OXpsSGpSWHluSmdwVG0wQkNqYkoweENBYTd2U21UVVdPb0JTZGxCY3ZsY0c5?=
 =?utf-8?B?czBodS92S0FOK3V4WWY2bCtuYmRZMVNoMWM3c094enN6N1pOclJ5SnhXMC9D?=
 =?utf-8?B?SFRjNE0vWWxzNklaNnNudktPT2JmMVh3KzZIcTE3aWVweWxQRC9RdVNjNllq?=
 =?utf-8?B?NmZzcVlSbVBudnJiOStCUXI0L3BDN0xQM1RZNnM4NURZS2pvUjRPYk00S29l?=
 =?utf-8?B?MzVnMzJuM3ZxbVJjTVBabWZDejUxelFhWG5DZ0VWZCtjUHlZVjJpWjJwVmp6?=
 =?utf-8?B?eHh6OGxlZWpXVjNqZ2RnUzV4R0FrVDRWYitiYWZGblNKcVpEYWhFUFhpYUFN?=
 =?utf-8?B?YjVDc1IrSko4QytiSnk4REVON0N0bUxJcEFORlFaYmNZdUlsWFhwdDVuQUJC?=
 =?utf-8?B?WWVsaE5wWkphZ05jdE5sZytUTG41WWFkRnRHbERkSkVINnF5Zk45bi9qK3U0?=
 =?utf-8?B?dkdrZnZuRnY3RXF3U21nOHNIZ3lvbnJwcEZqV0tpQzNJSjBDTThBelVlRWRG?=
 =?utf-8?B?VDZUaGFvNStDS29XTlV0LzVxWXJuV1RJMEZ0S1FrT2tObWp4dG5EWEVZcEpR?=
 =?utf-8?B?TVl3TmpTblpSM3V2VGVQZDlqWk5MTDJ5blFxQVpwK2RsU1BabDVYMmZabGVj?=
 =?utf-8?B?R0VCNmlYMWFhWDM0T0gyTzViMjRkUHBIdDg4OER6Zk9vb3phS1ViUzBlSlRr?=
 =?utf-8?B?VnJVOHpNSXN0ZG9iWEZsWGJzTGZSNlBrY1pzUXh5OStQbEJuakMwaFA1NVdG?=
 =?utf-8?B?L2pMUTdVN2ZwbTJObU1oUGtCUXJ5N2tWdXVveFNrQzJ5VGE4WXJxbVoybkZT?=
 =?utf-8?B?Z0J6TDBVTUE2TlJkUTRQcS9kZDAreUk1clFOQWQ4TmRYcTZFMVlxUGNaaHlq?=
 =?utf-8?B?UWFib2NEWU9hTGQ1Uit1dGpLR0o3MElEYlNCWE44NkNvd0tpMnBqZGFGTjl0?=
 =?utf-8?B?aHo5VEt2eEp4YnErQVdqRDBaWW5uT0tMZFI4eVpUWjRYQ2Z2cDNMVGJEb1dK?=
 =?utf-8?B?cmN5RkJ2Z2t0aUdnZ3pqaG5teDJNU3NESlhGZC9HOWtSZnliN1ArekthcmZW?=
 =?utf-8?B?WWkvK0Z0UjNldjlyZ0pNa1RPY1VDK095TnNuWDJPZDI5a2YyZkoyNVZMTmlO?=
 =?utf-8?B?U3BSdU5YdVUzN1dCWEFjZDhRTWNlM3FCL1IxcDFZOGU1Q2tHMG82dVJqNUV6?=
 =?utf-8?B?MUhIYnI3THdPdldmS1grK0Q5VjBWV1k3TlM5cmgvckVlcERtT3h5S1padnR2?=
 =?utf-8?B?RXVvMnVTTVM4djJrdk8yRUd0eVFLSzVYY2NycFhsbyt2dFNJS09NdEFOU2FS?=
 =?utf-8?B?WjRjVUJFWHJsNnh3VVFJN2F5N0c1MnBvcnlzTGQ4UHJHbjQzcWVVa3VGWWtR?=
 =?utf-8?B?RmJiZ0ZhK3VEY3RvY2kzYWwrZW9FRndTTU9yRVdISjZtNHJhMm4yeHc4MXF5?=
 =?utf-8?B?NWN2OHl4L0VXM0FDeElqSnU0bUhaYnVFZDVXQlVtdTRLdnFtZG1FalFBanVJ?=
 =?utf-8?B?Q1oyWWhWYnFSSng5dVQxS1pLY3d3bVBKS1BGc1Znc2lUdHY0MmhXTmlXb1lY?=
 =?utf-8?B?V0RkbVZzOSthc1dNTTIvNzlTNVQyWTJvR2RXaDRadWZ0OVh0UVVMQ0RVdHZs?=
 =?utf-8?B?WGhkRjJyNDJDU0F1VkZlSGkzTWUxbE1xamU3ZUxGUUxORHU0QjBvbVBEUEtr?=
 =?utf-8?B?L09ERmVNY1ZkNlJ3SlBoUmtuQ1kwcFVjWFZpSm0xMTZtQnp3bEUzOHFmaXdM?=
 =?utf-8?Q?Ar6nXMdD3TxTWbKYtXyh9B2U7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c98fd65-067c-4fcf-ddbe-08dd4b40377f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 08:35:33.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZgmfz5qBNsg8xBhtY+pR/9b/JAX9BdBNYDoPx4zYbNXxVbUVFL6+G513obR/jR0fXaKcLgcZzZB5Yj5OdLXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2huIDx0aGVyZWFsZ3JheXNreUBwcm90b24ubWU+DQo+IFsuLi5dDQo+IENvbmZp
cm1lZCwgeW91ciBwYXRjaCBmaXhlZCB0aGUgZmxvb2QgZXhwZXJpZW5jZWQgd2l0aCA2LjEzLjIt
YXJjaDEtMSBvbiBteQ0KPiBCZWVsaW5rIEVRMTIgKE4xMDApLiBNYW55IHRoYW5rcy4NCg0KSGkg
Sm9obiwNCg0KICAgIFRoYW5rcyBzbyBtdWNoIGZvciB5b3VyIHZlcmlmaWNhdGlvbi4NCg0KLVFp
dXh1DQo=

