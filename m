Return-Path: <linux-edac+bounces-3118-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C74A3934F
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 07:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21B13AD4AA
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 06:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1101AF0B7;
	Tue, 18 Feb 2025 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdDclgqy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AE10E5;
	Tue, 18 Feb 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739858657; cv=fail; b=Qbicr1qHvXZ2hDJWi9sgPZCbPutOx5Dg1CoGAZJsbKBmQw5tOhwAaBdD+l3LBQ/1XoRXC27nrynInZV2lzxNCNBIMT5d8be4/v65Xg0n8iVX74YyL8hRR4riUFTFwCUOyyA46PWU2TvRxVozKOlry0mkMY0vneVgmP1527u0SW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739858657; c=relaxed/simple;
	bh=76EAaMnzsftCPOqiHZo5UUvkNX+7hgw5cX0SQjobRpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nEDd+RPV8/EuIfnA88tG764XyRuDU+2XGsTk4TX/CNLcMmI85uwz6fxRy0/nk9R6r76Na0PqW8cIU10glAP4ZW5ZeGo5NoSdGXHi3lIVfDga6Po+otWNAIQEcUdwjgK/bdhAt8XMmHnkr/PtRj9qDr9SG80Wqi5XxNTwTrEWBVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdDclgqy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739858656; x=1771394656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=76EAaMnzsftCPOqiHZo5UUvkNX+7hgw5cX0SQjobRpI=;
  b=UdDclgqy+vIf0P5ictyvDIkf0v5uAUTR9X3B/JiQLGQ4KvKf9a9dy/fu
   woEPLnFWSIX9rARBpXchT2SyZIKrWTSpYuYMQr9awRDzmNDsvxUGzC5cU
   PoZ7LUFWaWGTkzYzxr/2HUDoePB0VFdh91a6mYfq+74IDDldtXMClyUFU
   kzWJW3TU8bb9QvFRkYoLKnKGJZCrc6spjIrYEJljQxC12ypwMmwDfhuEp
   xjpyLCuYpS1cACReuNUyWn7taWocfrXJlfgHwWmPp6WCXibSRHKAnALes
   7RUx6GwrGjHy+pzY7ObAVZkcpFuT1+3/5K6Nhwrgut1BCsoYGx3vJiF+q
   A==;
X-CSE-ConnectionGUID: ss4bHKSfTZOXexfkepysHQ==
X-CSE-MsgGUID: yGzd6vfFTCO+IWzmW8sEaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51160987"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="51160987"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:04:15 -0800
X-CSE-ConnectionGUID: wAiYjgltTWuRgdnwJgujjQ==
X-CSE-MsgGUID: pY52qAxVRRiYMO/jGx0sLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="114498705"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:04:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Feb 2025 22:04:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 22:04:13 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 22:04:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZs9C1figf1LOmcajGc3SlKTENrQsDTFzsvbnia9JIRJtHQacHsoxkJTEYNpe6SzLbzFD7gWvFU70CBzG5YQET7edheQHxgALl/TJL57XYMttqL2WuyBP32yG8PHamStonSykj8lHyZIyKAyrNGzY1M/wwjhFMD5fClNuUg6ptGRdCxWvLKGY3V8xDjRMHFG6gkSz0YK3d4I1LhQyAdT09z81eauASH3YwolC//hUlkB/7PQbQhWFUGwz6wKUd3cmyvh+mEZFNkZ25fJsBqe5YkNtOroqZ8vfnzJm2c+C+oxdA4W6sqQg9IZWfnddrRzcyCyYxiN+t+4jxukIBSBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76EAaMnzsftCPOqiHZo5UUvkNX+7hgw5cX0SQjobRpI=;
 b=ls1KXqr22n4sIx6ZSRPVPrullQDiEFTwevqCE9uYoYAH6mPj/roP6B8BMZf7wgWrWqVlV4xdQi/LTsAjzNyX5VJpISz06w2sMU+HHCSQ/1PCySwuYjGrvZ6w/+zMoeT0iE7T4JrGCnF0Xt/z6sdFGf70E49mti44wVJKVzpadPfpG2lBOdmQfAomg1o5EY2OjfLm3it+Ntc010jbuVtvqYgDYuz6gxAbdAKcAF4jZg0Rk6ugdaGCVNu+O74u3GE4/oX2E3qNaReoDdzltzBbNbcjLTeShWLAdD7vXTiR3CIMO4G7WARHlF2Hl+aXXHpK9NNgvNJhmNuKTUOX82asqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 06:03:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 06:03:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Thread-Topic: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Thread-Index: AQHbfjfFfcwhoaKyI06fFY9NnIDF+bNMliVQ
Date: Tue, 18 Feb 2025 06:03:42 +0000
Message-ID: <CY8PR11MB713455D3FE3A60DF09F5404D89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: 30576122-08fc-49f7-69f0-08dd4fe1ff49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0Y1NTh6WCtndDlLdkViYmk3aTk5ekJtNGhRNmp1dGN4cmR3bllGRFBSS01Z?=
 =?utf-8?B?WGRjQmFQRnkxYm5ZL3ZoSENCQ0tlVy9tSVdSUk1sQUdIQkhsU2xwNzZxTm5r?=
 =?utf-8?B?dnNZOWdlZGUwYVNNZGhIdi9vTTdtUkRWVnBpKzZ1T3NkekdYeHVKNkk0cGNy?=
 =?utf-8?B?ZkVTUVZSUmN6b0o5V3RXUWtJU1BUdkVvbTkxVkI5bDBUYTFzR1MrK0dINUc2?=
 =?utf-8?B?MmZCTEhoZjlmbUx0K1NKM2duRmhWRmhFUXJGdjRBNmpCOGMwME1iTU9OL2J1?=
 =?utf-8?B?enhybWFWTlJHWlo0SG9MWk9HcUFBcnlGeHdYU2RrdE9IUlJ0VW54NDlUc0tE?=
 =?utf-8?B?Y0NFd0JQc3hKa0greXllenNTdUF3TlA5K3NXVW5ZTkFIdG1Gemw1NDlrMFA2?=
 =?utf-8?B?bUV6TFY2d1lScDJXc0xzcW55SWNCWjk5akF5NWg0ZkRGK0NrM005b3pGNVh3?=
 =?utf-8?B?ZHNoc0cvMHlwNlg5N0NjYUdsVlQyVDdkaWpDNC9sTWREbmRRditqWWYyTXhT?=
 =?utf-8?B?MmhtSFY5Z3dEMGp3UUlZcmowdW5RNkdvd2M0NFc5c05TRDVRZnFYZGFSRStU?=
 =?utf-8?B?dlBDaFdqYUR0ZmpZQTlVakV0QldSc2VpOW5RRk00QyswbCs5b0hhQy9HN3pJ?=
 =?utf-8?B?eFlDTnRxeVJtRVluakgrUWdhaUhJTlJxeXFScEYyRXEvZTE4eFZNQUJwTVEw?=
 =?utf-8?B?aFVVOEFsa09QSGFWN2FxQW9zSmtqQ055T0U4Y3NvT3RKc1lIU2V4bzhMYUlv?=
 =?utf-8?B?Y1Rtakc3d01sU2hLVk9BT1Azb1hOTHppcU1oYXFTekVHaXVWL25VRm9YZEtN?=
 =?utf-8?B?NjM5Wm82SzY5Q0RCYm16ZEhlelAyNG9oTkFFQjVoTnVtVWd5S09kclMxZDVP?=
 =?utf-8?B?a25nVmFjT2RQMDJGUkcyU3ZrS1VVbmw2MU1neU5ydlNRWTJYS2E5b2locDdM?=
 =?utf-8?B?anJiRU45T1U4d3FsSmRiTlN6Y3dsRFNHa1RNWS94bUljbTFyTHg3RVJjZFRC?=
 =?utf-8?B?cE9YaEdPTjJUMjROMnEyWUd1L1oxTjRhMDJsN2dnUEtJU1dlY3Q5UmxlVGlO?=
 =?utf-8?B?STlzOWpGRkJhaWlPTzU0bFc0b3Y1M3VwNEVKYzlsTDBWZVFrcmZSTEx0cXly?=
 =?utf-8?B?MERpODhXWEdOSE9xc0F1RWNLek9ELy8yeHFZejQwQTEyR1JRcVV4K0h6QzJp?=
 =?utf-8?B?eUo0YzhCbW5FMXR0WVZsdzdVVitJc1YzQzJxT3ZlcEtLSXFyaE9aNysraitG?=
 =?utf-8?B?SUtMbTZUL1hPM25RaXVVdm5VeGpZdVlFNlB0TWE4L2dQeW9pSkh6OGsreXY0?=
 =?utf-8?B?aGd1WkpsVXZ2OXdIL0ZMcVJ4NTdGdmkxU3BScWFjNGw1NXZXaCtwbGFhY1Yr?=
 =?utf-8?B?RnNGbmkzSWFNMWZRZjNMOFRwc25GR1hIRVcrTlRXN1BYV3BxT3RobjdLRlND?=
 =?utf-8?B?bEV2eEdOVkV1SEhIbUVkLzBCT01PcUgwNjBSTThNY1orSWR5aEs0MWNXakNG?=
 =?utf-8?B?ZWg4UGUxSjJGTEJaR1llbUtUL3AvL1VBcG9PS2NObGowZEoxSzZNdWIzMEMv?=
 =?utf-8?B?dXBRTkRHQ1dJdnVPSHRIcGJZeEhEREdGdlhHM2Z1WkxpRWMwanozdGF0bGds?=
 =?utf-8?B?a21PZFZPMTVML3N0cDhOa2JUbFZwaWlCZnBmM0cwMUpxVXFTM2VSNE5JbDVl?=
 =?utf-8?B?VHFxcHpGSXJ4dGVYU1JlMktFN0Q1TzhHMEJsdDVGM3p0SkRQaXlSYmZrakRh?=
 =?utf-8?B?RE1LeERLTm9NUzFvc3JqVnRlck4wVXRDdk05NlIwQzBWdkJnTlpiQ0ExM2JF?=
 =?utf-8?B?ODBnMEd0Qlp3bmc4Nm1yaitVS1luaDVHNStjZmE2bG5LQWZjNmdDalV1Mnlh?=
 =?utf-8?B?U3F1a2E3Q0pjWVZoTUhBZjloTW9LS0x5S3kvdDhIRTNRREJsczhCQTNnS3ls?=
 =?utf-8?Q?k4tlrH8XrfBdws+NPYkQ9pgCN7FfuPKS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2VieTRSWnB2VHFHUGdKdGV0OUp0UHBPRXN4UGpJa1ZuNjVqQkFCWmdpZ3hL?=
 =?utf-8?B?NncyMFdnZjdwVC90THpPa2ZoSUE5a043TzJjRTdEakhoY2RFM3dYSEN0VDZz?=
 =?utf-8?B?QjdHZlRKMXpzSzluM3lnVm85NHhNbXhNeVlCcmFJWnUva3JWUlE3YlNjdjgy?=
 =?utf-8?B?dDNxZitiYVBPdllkUnAyYmowZ2pJS3NmTDIzbEx6d1dha1ZNSjkwUjVkazdx?=
 =?utf-8?B?bEl1ckFtdzQreWdBZ284WDFUWGwwVlI1TWU5QnhScG5mZUpINkkwODhaZ3g1?=
 =?utf-8?B?eC92VDVtQ2J2c2xpVG1Fd0dpOEhTSVVJcE0vZ01xdVN5M251NStleHBGNm9H?=
 =?utf-8?B?ZWdmQ1pFUGVyZzgxUjFtN0liaG40aTVBdDZlQUUrdmhqdXVlTVdvcDFUekQy?=
 =?utf-8?B?VE5CNkV0bC9WRytUZC9QSWttdXFtYTJkTlZ5YSsvTDh5ZVI1U25hbjlBQ2tR?=
 =?utf-8?B?cVRTcDAxV3o0bndGWmNKQ1VNaXk5bVNoaXNhZE1CZjVITkJxejBiTW1sNWNQ?=
 =?utf-8?B?QTRET2FuNVZMRTdWZlJ6MzdsMXpWR3N5Z3NGcFl6Um5acVB0Vi9vMUJRRUFl?=
 =?utf-8?B?bnA1djlBd2ZKUTU1YlVVYldXV0xkZlFaMnI4TlRjRDJsNm9oQjRLa3hTWXpM?=
 =?utf-8?B?aUdWK0crTTZ3SExNclpEYkcxb1FyRytkZmVUQ1RwUExUVCtSZHZGWnJuN3d2?=
 =?utf-8?B?cHNxcVl6a3BpZFU2U1ZYaXprZk1GZEE5OTkwUXpDZTlGdHlNYWwvRGNSd1RG?=
 =?utf-8?B?OEZXajJDOEdpTGdhaU40bktxNnhYcXZCSFp5Z1N4SWxuSFlBUk9UYXhBYi90?=
 =?utf-8?B?eTRocGt1ekVKR3dIOFhKb1RyMTVmK1E4ZjBSMWNVOTFmVlljcnVpQ051anhj?=
 =?utf-8?B?cFc3bzZUYUd5Z3RyemFOS3poNHNEekFDR2J1OHF6WlZpRlRGRkFyN0VHNmky?=
 =?utf-8?B?V3NlUTRodExrdnhKOEZ6ZjI3VUlITUZ1bllISTlyM1VYWVRVaEFka3h0K1Y3?=
 =?utf-8?B?KzhhZ0I4ejVRUGdYMEdtUndMbUZGRTN1OWp4ZUU1RjdkaUE1ckRabk1JVjkv?=
 =?utf-8?B?Vmgxc1hmeXFGN2k0UlpGL2lXVE9XeEFCWWEvODZEd0dGejdCRklXc1ludHNH?=
 =?utf-8?B?dlRnOGZremhWd05CaENIRC82WDV1eWJEY3hmazN3Z0VQZUhnb2ZUZ21aLzNY?=
 =?utf-8?B?TUI0THIwZDhSNHV5KzdEUnZUVGptWXRqcmRMeWhvZytGMGxIVUpxUjkrL0NW?=
 =?utf-8?B?Uk1oRzhrRmF3SnYwTEtXRnRNVlFJM1ltZzVTTUdiaVJ5ZW9vR1l5R21meis0?=
 =?utf-8?B?N0VleFJJNjgvMWRPeWRHTVlCaUhMdHMxdVRVdFlEWUNLWlRIMUdwY3hQWEQ0?=
 =?utf-8?B?WFJhdllFaWo0a01TSm43UUdtaEdxTW0zK3FMOHR6akJCRGJ3Nkg2bTFwOUpk?=
 =?utf-8?B?eU1KNjE2dGtTOHpiVGxaTHlHV3BoWlIrMDlpV0hQSURUWlUreGV6M3I0S0Vv?=
 =?utf-8?B?a3Y3RCtIZHpLSUIxZjdMa1lhd2N1U0hpWkVFN2xVV1o1Q1hDQ3Rpb1RyMDZN?=
 =?utf-8?B?Wlk2Mk42ZDQzaHVlMk9rV1VDMCt0Y1hGYTBMQm1CelVjczUxbXdtdnhFLzE2?=
 =?utf-8?B?OUNuOEVUSVkxcmVuZTdTcFJHSU56cWYrbnF0Z3dUbnVVWlo3MU41enplK0NL?=
 =?utf-8?B?RFUvZDR3dlB1bUV6dUd5RXQ5UDYydFdsbFI5aDZqOGE5REU1MXVDeUk3OU1E?=
 =?utf-8?B?WDUySG5aNGtnZmdscXBUc05mWmh0eGN4dkEwaElzYkcvY1AwU1ViK1g5QVow?=
 =?utf-8?B?ZGFwYUZjYjJLdWdJbzErTEdrZ1BuVy80VS9KYXY4MVlGYUo4aFJkd25oQ1pl?=
 =?utf-8?B?cXVIekRDNEpWTnlJckZlaXRZYWlUMXJuT3h6SEJWUWZzejdXdTRZOWJxVWwv?=
 =?utf-8?B?Z0pIYVZrdDYwNjhQV0drNVkwczdyRzhFdmo1Qkkya0VnZmhKOGZKdm5HcVlv?=
 =?utf-8?B?Rm9LMHZrWDk1V0tGNkcrbnRZaEV6blpva2gwVW5MelFvTGdjSzVNNFkwVUVH?=
 =?utf-8?B?NG52WFIvYm94Z2tjTkY0Sm9nZ2g5V1ZTZUc2RHV3WVYrT3YrMUtzMXluaDF5?=
 =?utf-8?Q?HorUen0Ej5KhgyR4kGOB8aUUo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30576122-08fc-49f7-69f0-08dd4fe1ff49
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 06:03:42.5153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXSFP3Y3rdp0rNPMrGUjRlntBa8ofWWkcY+6vCcMf8rxuhkSTO5PT2IXc2owfNLMgpY+EbLXuF3xTWv11+x/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFsuLi5dDQo+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVsLmMNCj4gKysrIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvaW50ZWwuYw0KPiBAQCAtNDY4LDggKzQ2OCwyMyBAQCBzdGF0aWMgdm9p
ZCBpbnRlbF9pbWNfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ICAJfQ0KPiAgfQ0KPiAN
Cj4gK3N0YXRpYyB2b2lkIGludGVsX2FwcGx5X3F1aXJrcyhzdHJ1Y3QgY3B1aW5mb194ODYgKmMp
IHsNCj4gKwkvKg0KPiArCSAqIFNETSBkb2N1bWVudHMgdGhhdCBvbiBmYW1pbHkgNiBiYW5rIDAg
c2hvdWxkIG5vdCBiZSB3cml0dGVuDQo+ICsJICogYmVjYXVzZSBpdCBhbGlhc2VzIHRvIGFub3Ro
ZXIgc3BlY2lhbCBCSU9TIGNvbnRyb2xsZWQNCj4gKwkgKiByZWdpc3Rlci4NCj4gKwkgKiBCdXQg
aXQncyBub3QgYWxpYXNlZCBhbnltb3JlIG9uIG1vZGVsIDB4MWErDQo+ICsJICogRG9uJ3QgaWdu
b3JlIGJhbmsgMCBjb21wbGV0ZWx5IGJlY2F1c2UgdGhlcmUgY291bGQgYmUgYQ0KPiArCSAqIHZh
bGlkIGV2ZW50IGxhdGVyLCBtZXJlbHkgZG9uJ3Qgd3JpdGUgQ1RMMC4NCg0KSXMgaXQgYmV0dGVy
IHRvIGFkZCB0aGUgZm9sbG93aW5nIGRlc2NyaXB0aW9uIGhlcmU/IFNvIHRoYXQgaXQncyBjbGVh
cg0Kd2UgZG9uJ3QgYXBwbHkgdGhlIHF1aXJrcyBmb3Igb2xkZXIgQ1BVcy4NCg0KICAgIE9sZGVy
IENQVXMgKHByaW9yIHRvIGZhbWlseSA2KSBjYW4ndCByZWFjaCB0aGlzIHBvaW50IGFuZCBhbHJl
YWR5IHJldHVybiBlYXJseSANCiAgICBkdWUgdG8gdGhlIGNoZWNrIG9mIF9fbWNoZWNrX2NwdV9h
bmNpZW50X2luaXQoKS4NCg0KPiArCSAqLw0KPiArCWlmIChjLT54ODZfdmZtIDwgSU5URUxfTkVI
QUxFTV9FUCAmJg0KPiB0aGlzX2NwdV9yZWFkKG1jZV9udW1fYmFua3MpKQ0KPiArCQl0aGlzX2Nw
dV9wdHIobWNlX2JhbmtzX2FycmF5KVswXS5pbml0ID0gZmFsc2U7IH0NCj4gKw0KWy4uLl0NCg0K
TEdUTS4gVGhhbmtzLg0KDQogICAgUmV2aWV3ZWQtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9A
aW50ZWwuY29tPg0KDQoNCg0KDQo=

