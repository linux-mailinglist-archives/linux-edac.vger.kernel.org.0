Return-Path: <linux-edac+bounces-4789-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65A2B51ECE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 19:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D838B1C874E0
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4748320A36;
	Wed, 10 Sep 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcYQrvuG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979D31D378;
	Wed, 10 Sep 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524998; cv=fail; b=NVVuDhpjAuqk9oSi6nLRaF27QOrddcTaaRC2jb5DUh1NddYVVcPuipbCtm5EcwiWrjsMTPwNjgXIYcu/PaqKm1hDrECLUfdy0ptRibvHJoL68ZEYVLsTBcRIjCM0/atrJ4UhCeXmDZvmim+Z4Q90e7V6PXM5kAuXCypwcHv85gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524998; c=relaxed/simple;
	bh=3bcOzNjCTbuQXyIkKWbw2I4GF1aHnkDEig+bSc8JgvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RLnsWl1MgvXDprQVtlcxoqpGLNkMDVoya4gHhntD1nawJqvjM2L6hmhUVc/2CjHXGSDmF7T8Soi9wji2ps3zUcyXjb7ZqygG+fLx3r97S/dsQuyVywklBewnkBViUFZRowufHT3HH85CHER0RWbnlWANuHcUuZKlCTmK7mKx5eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcYQrvuG; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757524997; x=1789060997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3bcOzNjCTbuQXyIkKWbw2I4GF1aHnkDEig+bSc8JgvQ=;
  b=RcYQrvuGqgOMxJ8rNssUIxf8FWp1iNZh1/HoJlApZOZ08NadFtOw2NNZ
   EoOcre5WWbIpzpSmp5InJRboWSClTwqh+OCgSP6lR/6MUQn1B7GwE03pZ
   Zp6UDmRNPxYQ4XnUcOizmakMbbwk46uD2kxRnSxl4CqV6wskcdOHors7u
   DkIET+pGogpX7Fw/2bUQNlE6AhmCJa6s7isth7kTG163bKbkPxOny9hwi
   MEQaoOYglpVpBP4h+dS6SdmYByIIGeQPj+pFH2SM4eRH07Zl+2XGnicMa
   v8kxP29w1ZX1NdGPArLzDpHJs4d/QkluB1He/FR2/IaqH/4101suJ4kdU
   A==;
X-CSE-ConnectionGUID: 6+YQpfS0TX2K5+Nrp+qnZw==
X-CSE-MsgGUID: KCe2tjroTUiYX0N4OFW1Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71224414"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="71224414"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:23:14 -0700
X-CSE-ConnectionGUID: J3YEOivUTMuvjYL57FPRDA==
X-CSE-MsgGUID: AtDr1iGhRGOojeXampzNXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="172638588"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:23:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 10:23:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 10:23:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 10:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXpR0wODEEZeR3RvQnw5+sov3JaByajp38YR7EjI9ppKYkrdK9kVakq+33VbLImq2vO6qenqcnlK2IzsaQ2pB2oJ5xyTcoUJHWw6zLGSlBXLWGLO4J1lyppg6qF3WI+SlVeJA0T3XNWy+19qHoEbBXf8LhZGH2amh0vnscO4hJ4mO6qogmXkygWWQuevo7O+uc9x1zh5HCEA/KBFQ2ZHCmTPuTgmh9dT6ZH5dB1DhYgtiJZIJeJSeBQVj5JAZ8Cm0tMEjOf/PHGH2i9/v4Z92els7Yt2kgCW6cDWj4MKC5Z4cucFnSR4ryNANUDRMAjHIM6OBkorT7Te55/yRpDwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bcOzNjCTbuQXyIkKWbw2I4GF1aHnkDEig+bSc8JgvQ=;
 b=EaRuSXTVwpulciEHgpqlV0bP0x+eVnGlBz/NLhwAQfhkfbYfx7Q8y7kcfqMzsSsupHBzuehsPL25skvkBgxPWWutVAohuY/fI1iyb58zrBP4CJwYeQgpYX6hKitM5rCnS4RFcpCE/tADChOrpb7HirE7t+fEPhywouVgdMOX2pppJe7KCIohM6FdprUop7UGeGTs1jQ7iV68RFOuLTVYWyiF9+WBWvqBF9U93UIiyb2CXZZu3nIvkqzurdg13nWXZYPFvj4akVgOtYWk72tfS4/JCk+PcTzcup5zeicOV/bSvzu9Cv0O21hgK44aFxvabX7z9IjRhV9Ur2aBJp1C/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 17:23:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 17:23:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v6 02/15] x86/mce: Define BSP-only init
Thread-Topic: [PATCH v6 02/15] x86/mce: Define BSP-only init
Thread-Index: AQHcINcB0Ab+3i01aE6ovrd6IImgErSMT6EAgABdIuA=
Date: Wed, 10 Sep 2025 17:23:05 +0000
Message-ID: <SJ1PR11MB6083D2E29D35B29A9C2C4317FC0EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-2-eef5d6c74b9c@amd.com>
 <98d80660-7140-43a2-b17c-07a0884996f8@suse.com>
In-Reply-To: <98d80660-7140-43a2-b17c-07a0884996f8@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: 86f0a874-e364-461d-7040-08ddf08eb455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YzlTTlJycWk3RDlqbHFQeXNVYjRKV0VER1RndzNzTjJUTFVKdm1DZ3M4WFBC?=
 =?utf-8?B?aytmNVRlbXJGNHFiVEZUR1VkaTdWbGl6WWw2RzJITW1LYmFEN3Z5TEdzUjd4?=
 =?utf-8?B?Qk5HY04wdGNDNWNQdFVzVUtYaUNQUjBERGxGQU13UEVEUUwxd0sxWTdZM01s?=
 =?utf-8?B?SXRnWXdvS0EyaFZ4TUlsKzJWcHl3NVI0ekVsVENwa29INmhIRWJJU0kyYVBB?=
 =?utf-8?B?S09IZFZzSmJmSUNGVUV4ME1SSTFHUXFwRjhkeTdOY3daSDhyMVV3QnNqSmsw?=
 =?utf-8?B?cTRieHMyS21TSDRuSnNER3I5bGJpQlJGMTFSM0VxSXZiTE9xeU80K2lpMi8v?=
 =?utf-8?B?TG5TTlBGeDJ5UGFPWE9ockZndDN0TGR5dkhWL3owOTVtZW1WcXdnREFqMG5E?=
 =?utf-8?B?UXBPd0R3aWNNc3lrcDNuNW1rQTdnMU9CQVYwN1FzbHZjTllCY0kzUzU5WVZQ?=
 =?utf-8?B?SVQ0bWVKemtXaXBxeC9UL2VSOFRqVHUxVmVMb2g0OUdsV1lKK3RKQ0NZdzRo?=
 =?utf-8?B?eW5FZWtDV01OQ3grUGQ2cnlURlhvOFVwSkJ6L0I5ZVY3aXI0RjV1MGNqTk5z?=
 =?utf-8?B?b3VhTUQ2NG9rbXk3L1gzWGxEL0R2azRnVDBkWWFtMlgzMXBBK3NMbEFOYXNO?=
 =?utf-8?B?RkRZOXhuMTVHSlFBeVZxbGxqaHZGU1owRlZMb0NQKzBHQTl2bUgrcjR0R0ZU?=
 =?utf-8?B?cmh3bXpHaVJ0L0RFWVB4M0RORjdDR0x0eGk5Q0RNUjBFcU92SDdMTHMrV2VJ?=
 =?utf-8?B?bmJCMkdBUWFOekhFRjNhczZ2akZ1Y3ZWNkNaWHFUVlNTcVRuSXMrTVNmaVVC?=
 =?utf-8?B?WlR3NXlSRkQ3YStRd1pUeDJOazFRS3pTbjlONFRkeitGdGdpUUFmZVUrSkxw?=
 =?utf-8?B?bTBvbC9LYnp0YmZxNHhSOEQySG9TMmFKSWNsRXZOUjdSNVlhNUJvOThER1Fq?=
 =?utf-8?B?MWdqN0dMTHkwSENpZ0JFbWdZTURpTllRbVkyY1d5MUFFVHliY1BlVERVVnlZ?=
 =?utf-8?B?bWlvSVB5S3RaM3EydkhFeEpGK3k1MUg1UXFqMXU1M3FlMTBpMnJqc0J1cU5H?=
 =?utf-8?B?eFJxZkY2NUZXL0lpKzEzdXg0YTFKakRUKzFrMUVRY3pkOTdUcW1YWWxpT0Fa?=
 =?utf-8?B?anZON3pNMzdzRzVKMWFUSGNrQ3l5cTAyTml6UkhDNHZTS2VKUkdGNnJpL3Z1?=
 =?utf-8?B?T0dteWdYUHBUY0lJUWtPa1p6ZERxWVZ3K1ptUWJETi9LYVJLdzZFWjVjMXRD?=
 =?utf-8?B?V05zdEVQWUwxOFA1ZWVFU3Y5dTZkREdNOTdRb2J0amJUbEloU0Z5QkxBYUNx?=
 =?utf-8?B?MGkxWWxFQjFDc2wraFU3UUxIQUJoKzgyN3EvZnBMeVlDZ0hDTUhnbTRCUHo1?=
 =?utf-8?B?VVNIUG5Yc25kcnZKUFc4R2VLMlNKNzJKd3BDdWhjWkJyMzlRK0ZQTjI2WjVL?=
 =?utf-8?B?cHF0aDhnR1M0M0Y0c0U3MUhKdVdaTm9NVzZKNW9uMXRPK09LWHN4SmVnSFho?=
 =?utf-8?B?RGFvSm93OHJELzlkdXlMUmszeDYydkFzNklseTZMRzlvVkZ6N1N4SXVwUjMx?=
 =?utf-8?B?ekF2dU9Tak1aVm11bnBZMmVTTVlVdEgzNXhqS1llVjJCWm9razFlQmU1d0VW?=
 =?utf-8?B?d1k0Y2ZuRG9YcEVyTStoSzczeXkweG9zUHlUVlFTUjVnZmtlRGw5Nm1hWUo3?=
 =?utf-8?B?SHJ0ck8yS1RieTFaZ0FybDUwR1RGbjRsdVpoeEdEdDBKNkFMc0FDYWtQVEZD?=
 =?utf-8?B?allSanE3VXAyK3RzT0ZRcVJpL3pRWnNqMmZxUU1jZjJTb2hXZjNsQm5rMDNn?=
 =?utf-8?B?c0VlSjZhYVEyTC9KaG1qM0NyUzErUzhNSk5mVjNQM3ZYMkQ5dkpCNkliejIz?=
 =?utf-8?B?UnkrR0FEVHV3OXZCYWRZTlNnUUY0djNRNVY5NkZuVmxxejFFdlh1bi9UdUtL?=
 =?utf-8?B?UkRHaitiTWpic2h0UkFYdko0YlJVV21TU3FOS3F5U2FsTUlwT1ZBZ2k5MnQz?=
 =?utf-8?B?TTRUU25Gd2tnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1doV3lhbTlYb0lQL2V0eDhPWG9VbHRuU0pwbS9RdGJZT1hWcmR3aXZ3dGpu?=
 =?utf-8?B?ZksvUGFEMm94elBmMTNrRUpJdEIvWjY4NHI2amZidVkyRVRWSVo5ZWttanJn?=
 =?utf-8?B?Z2pGbnRoUGI1VUltenhjQzYzcFR3L0oxMzNlWlVWWUkzRkxYaXgzbWhNQ1B1?=
 =?utf-8?B?MU5QS3NPZmI0cEZ4RDR0WEsvVGg4eWYzdXlYbmpnejl6OHlMOWxlcW9RdnZk?=
 =?utf-8?B?UmVGVnFVTXlRNHA2UWMrTEVGTnJsZG8rWkNjekhVdFpqS2JGak5HNnRCVWdG?=
 =?utf-8?B?WmVtdVBoRmFXalVaUUpXVEpmWC8rMCtrMit0eGNSMkNMMjRqUks1YlM0bEF3?=
 =?utf-8?B?cE1SaXBvekMwemlURy9LaldubHdjQ2VNTDBjdjBpMTluRE1hRkJkcTNicE5Z?=
 =?utf-8?B?dUptRWUrcGN1QW5YT2JPYnJ6M3h4aUJ6WmZ2cm5LeVN6NkhnVXZWQUJXNlFD?=
 =?utf-8?B?T0NhYUFVczRmcjk1U3JEVzc2VVNCSHB4SCtlSXhZa0EvdUZidXJ6UEQwY09t?=
 =?utf-8?B?dVVIR09sVXRodUxKOFpJcFhhZStYNDZydHpoWW10dFJuL3NiMWlMN0RQRzZq?=
 =?utf-8?B?cXJmNkhIalNTNVFHMEhMTzhjQjBOMUE1cXJkQTJXbUoxNFYvZk11VmtydzJG?=
 =?utf-8?B?NTE2QjJvS0JRMWZMSnNEZkxEOWorOWN5RUljU0o2Nk9KM0NxNldVQ3BpcTBk?=
 =?utf-8?B?UlR2ZUpLMlNUUmNWZkpQU3ViZ0k0ZzhaZXBWVWRrT0psUzAvU1Y2OFJXRUd6?=
 =?utf-8?B?TVZZVXZDNU1NMEhxc2VucVExZHoxQkYzbTQxZEoyUHNVb1NPYnNJQk5vc3ZW?=
 =?utf-8?B?aWMwSkFUTXVWcC9Zb1hFRzAzU1UzdVNnUGZaNTZvU1pqVzJhbnlDa1RMb0lz?=
 =?utf-8?B?emdGRlBoN0tocmZlU21hUEdCWnlhS283OSs4Q2I0cUVyd2M1NDltd2Z3Sy9u?=
 =?utf-8?B?U1VDandkSkJkUmtGS0lHMHM4YUYwS051NlhORVpNQkpHOXZhdmY0bjZ5d2pt?=
 =?utf-8?B?c3E3TjJ1QXdvaUNXYncxMVEwTVM4L3g5cjd2ODEweEtweCtLelNqbWQ2YmNE?=
 =?utf-8?B?UWFyTHV6WkpITE1GbmYyN0NMVXhkeFE1T3ovelBINXg4UXBRczhXNmpvbEUv?=
 =?utf-8?B?a1dsM3Y5MFYvOU1WSWV1eWR2cEVnaHpPbjEvbldML0FCeiszNDg2NVBMa2Jp?=
 =?utf-8?B?R0Ric24xcGFhV3Q2c3VQYmh6eWNBNldBalR3Y3ZLMnVHNnRkdEY1KzZxUklE?=
 =?utf-8?B?NVlMQmZIaVFWa0pobWErcFEyMkEvQUtVbFpZMCs1eGJvNHpYOWh0OXNzTlY1?=
 =?utf-8?B?b21GVmxVWXpkQ2dDYWU2Vi9ja1JrczRrWEhjc1R4VWNKRGJGQVlNbm83UnBv?=
 =?utf-8?B?dUp1U1lIME9relJUMFpFSVdBRmVwZTBTcllONVdkMStCWDVMWUpYUEltdWx1?=
 =?utf-8?B?Zm1qelhRUlJ3aG5pcU5tQm1zZTFCaGFkTkJFK0NpQ1U3cFVZR2M3cFhoeFhr?=
 =?utf-8?B?dlBLSWtRZURoUlNtRmxCK0wzTTZ4ZU1yTlJnM2o4ZWVoWXRFRGhZM2ZzNGhF?=
 =?utf-8?B?MWQwK3dzdFpIcmt1TEl6K2tvVzJtOUlidms5cVRSWjc5RlQ2SUt1eEJQdUZk?=
 =?utf-8?B?OVRid1dhL2ZtU2hWVmZ1Smwvc3ZxNVI1OXRnWS9XMWJ3eXBvL3E5bWZldllG?=
 =?utf-8?B?cE0vZVk4aEZNSksrbWVhMFVkK0ZzWWxIQ0xiNnNlQkVadXpxUnl4cWRqU1c5?=
 =?utf-8?B?ZnRQY2tqdFVJclo1S1BGRFFoL0thaE1OSlc1K1k4NGlZUUhjaTJxVWVuYjdw?=
 =?utf-8?B?UWFaM2lMUi9SUWxDa25IRStnMFZkTWNNUytsdWh6ZXpCK2hnalJ6OStiaG4v?=
 =?utf-8?B?SERSdUJaUDhpK0pMNXVwNGk3SXBDcm9TTTFwazg1SDhJNzRqa3o5TDhZVmlm?=
 =?utf-8?B?cHJUMkZNVi82Qy9JdVVxeVJXYVFvYXhsU3NRWkxtL1pKMnNrNWtkSTJvUmpH?=
 =?utf-8?B?WC9LYVBvRVhjaG1nM0xNcXFqRkNybHRxQUcxM2FiRDRwNnZuS2VjVUEwOXFP?=
 =?utf-8?B?UUNhSkR4UUZiNGU1LzE2dEt6T3NJcG1pZHpqVkJYYTZDd0NPNHQ5cUt1TEp2?=
 =?utf-8?Q?6CtpmzyP6AeXPWWepdRvo+17S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f0a874-e364-461d-7040-08ddf08eb455
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 17:23:05.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LI+Fq7pU9BzKUIxN1S5/1+CVrDMP3c4nl23Y6QwqGUzf21iuv5Jtnx7ah7M9eLOpbApJc1wdamZE/FJV/dYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

PiBuaXQ6IE9uZSBxdWVzdGlvbiB0aG91Z2ggZm9yIHRob3NlIENQVXMgd2hpY2ggY29uc2lzdCBv
ZiBQK0UgY29yZXMsIGlzIA0KPiBpdCBtYW5kYXRlZCB0aGF0IGJvdGggdHlwZXMgb2YgY29yZXMg
d2lsbCBoYXZlIGlkZW50aWNhbCBNQ0UgDQo+IGFyY2hpdGVjdHVyZSwgSSBhc3N1bWUgdGhlIHg4
NiB3b3JsZCB3aWxsIGJlIGEgbG90IG1vcmUgdW5pZmllZCB0aGFuIA0KPiBBcm0ncyBiaWcuTElU
VExFID8NCg0KSW50ZWwgUCBhbmQgRSBjb3JlcyBoYXZlIHRoZSBzYW1lIGFyY2hpdGVjdHVyYWwg
TUNFIGJlaGF2aW9yICh0aG91Z2ggdGhlDQptb2RlbCBzcGVjaWZpYyBiaXRzIGxpa2UgSUEzMl9N
Q2lfTUlTQyBhbmQgSUEzMl9TVEFUVVMuTVNDT0QgY291bGQNCmJlIGRpZmZlcmVudCBvbiBjb3Jl
cyBpbiB0aGUgc2FtZSBoeWJyaWQgcGFydCkuDQoNCi1Ub255DQo=

