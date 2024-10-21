Return-Path: <linux-edac+bounces-2169-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7A9A7287
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 20:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EAF1C222AF
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CF1FAC21;
	Mon, 21 Oct 2024 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsmyQdIu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEE78C76;
	Mon, 21 Oct 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536013; cv=fail; b=BEJU3+ZECFJtv/3yjYbasZfmpbCv63h8+iZpkQkAC+PJkX6kZrJENRVdTuszvqGEcA/FLmWdlcDw8REYNzteF7kBpRzFWm73llkTfFMGQRjen9J6hmEQbGyU97/ofsjd391pS/OwThgbJ4lHF5bBEx8KfUb2U1tmDajcJc2PNlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536013; c=relaxed/simple;
	bh=dxlPWDpvGJlYi0h3+UhWd+10m80PC/qylrMRKgCvFbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VDK38I+KPkdM1zxgIN9e4ybUpI8TI+jlt9ftTybRZA7BufXqwjlu/6twJECsQRaf+X5hn5ym1weDUxDVAcgi25yHnKlYMPnJVRADGv1gS2jacxYqWs5iqC/ZORe7HV23DoD6uzkjphgg6AafwEMprB5wnmTzVQyB84veuQKcZMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsmyQdIu; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729536011; x=1761072011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dxlPWDpvGJlYi0h3+UhWd+10m80PC/qylrMRKgCvFbM=;
  b=YsmyQdIu70I8dvqIVXEvRVgnTpPBWxZxGEQKEm+R1JHpFCCRMMu2UO0u
   jHpgGfEKiFcFoCISolXx1MHAcGMKII6dDmPf2zH9IgqRtbDazmnW6XgTl
   mthPx6OQzMrAcFJuiQEJc1Py6zb6Av6C27EuS46Pi+sp7eedEGrfWDXUx
   dTla5UStL82wMRrsCMtE+7G4ujn3z2XQ/k/AF8K6hjZZypJg4CUBmKIWu
   6/hTaHdz2T1OxH9IVSxLmaUSX+k9qLhCX/9e5KQCgMJDxoionbc2m8Kdk
   WD/3F+a1Ej73qkncGdUo8A9pGu8/KTgJpFpEXub8qTHeNq9ToWQlOji1x
   g==;
X-CSE-ConnectionGUID: Px/3qtWMTRGpuXla2mCcRg==
X-CSE-MsgGUID: Zird/F3HSDeUxgqxUQKevw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39622932"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="39622932"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 11:40:10 -0700
X-CSE-ConnectionGUID: QCoTr5XGS/SaVLUIo6iLYA==
X-CSE-MsgGUID: NIIlgNE+SL+PFR4OPCLFoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80014676"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 11:40:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 11:40:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 11:40:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 11:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN1ndv5uIe4AP2kcYhuo7+eVAesw1FZeLhQrx3oeGsRpgEo1ke7KEN6GVChwvGDYoOKoSoI4x5I/tr+EUU2fN9WqtQeHR4RGxl8XJuaRfC9xA8wPoh2jOusWIX5rIuZY8UrjwTBJ7w1ozcuGcgxZwj5/pvtJq8FCCwEtcHWXJfynhO6STxHidiS7UMgRWvV4L+cYoyFhKj5e9LZJUw4Uey1vPE4aJZB66xWzBI5Exqn+x09ucikzroMHfgipdj1bD5+bx+4SRrICRUXlLQPF8aEDvstSdfada5Nzv6n7cI9252dHfnvACssBHYMeyVh+JhRA9JfdMQ+9evzQbwahsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxlPWDpvGJlYi0h3+UhWd+10m80PC/qylrMRKgCvFbM=;
 b=RWQnLo9g0Gt0+a2trP5dCxGnrql1lBXkjBlUmnk/6NLxC4u1tcn8TIa2QLSiYTnt1LZnE9MwVAqL2Ivs8Vr7qXK7klL7l9R32cVTqiKQKLv6SMabNCQAqpVgMMlMYaAdC4gUT9SGjEg0JovcMGIFI2tmoz+ctYZdXTu/VlPBhof+Jbi9brJqcrEe/C4IP0mEUfQeAqUFluhFPh0oz0B0wZ+e4+WNCCQpCAQaixRsVu2fh7UHE1NSXWx8Hos0upYFZgBfGWPyrRA98brnYCHdetwHuCL4L20XZXHn7n34+QkKv7FIOd2naeHNaINOkjqPh+LJ+3h/oJ2VJEqLmLEwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:40:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 18:40:04 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qM4hN2vTGb8EmNSTTck992prKM7JIAgABI4TSAAF9SAIAD0KcAgAAbFACAAAC60IAADI4AgAACokA=
Date: Mon, 21 Oct 2024 18:40:04 +0000
Message-ID: <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
In-Reply-To: <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8428:EE_
x-ms-office365-filtering-correlation-id: f53233b9-17c7-48b6-a503-08dcf1ffc7a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGxiTExWYUxlK1FCa09GYlIrNTNucTUzR0hyV28wYm0vdi9Gb05nQ0VkYkJk?=
 =?utf-8?B?UVlqRkpXam40YmU0QmNWVzg5K0FDdnFMcmlDZHJtc1MrZGVFL1BCcEFMdXNL?=
 =?utf-8?B?cjZSYVd5UWZQNTBWR1IvVllqQytMdk8yTlZUcXNzekkvajN4Vjg3ZWJmdy9h?=
 =?utf-8?B?a1JweDIwMUdENWlNNlYzSFA3WWs4dWNqUDFpbmFkWDNkV2M3aGVUK05nazJ1?=
 =?utf-8?B?QTdzcSt4V1Q4NUhiRWhqU3RYV2dkTElGUTA4MVNaSmQrcFpvQzFiUEZUcCtB?=
 =?utf-8?B?V0R4aDE3WkczQUZBNlVOUjNMcWZnYXd1ZjRBRkJiSWFXRXAzNXlsRllyZUF4?=
 =?utf-8?B?ZERJNGNGL0RnUmFZTE5HZ3VpRjFyNHYvV2dVVlZhMHFiY2RwVUFkVlA5Y1Yz?=
 =?utf-8?B?N0hEallmRC9UVkxwYkw5cWNLcHg3eWQ5U1RDclNGTVNHeHNSMU9IM0JiaWpK?=
 =?utf-8?B?d3V1UVRRUzZKaFk2RzhCTDZDWlJEb3dOd0NLNXhoNTYwQ2x5OHJnK2Z4L0wv?=
 =?utf-8?B?clJYY3UxMFd6ejF3OEJEQ3R2MDE0ZlMvVTE3Q2lhc3VJRWxYbG5DTDNRWVBi?=
 =?utf-8?B?OWNDeUsrazdHQ05xWUtuSklFdGRQMUpyWWtZZjZwUnVSam96YUZHdVh2TWEz?=
 =?utf-8?B?bkt0VnhwT0tidEJoVFVXNUpWTWYwZFVVamFOcnZOVzRxR3A1WXJCTENpTlVG?=
 =?utf-8?B?SlFQZmRlUjgzcWF2Wi9wRHhNVzIvazdrYzhqV004RjBNWHRyeDZiRkNadGhz?=
 =?utf-8?B?ZVFzdVBWYXQrdkpQTnh3Ull0YXNNZE5zWEN4bmJVMWpVVUpzRmxUS3l2WTli?=
 =?utf-8?B?azdDYVJRb1NTRWVmQXdjZS94Q1A1RmV0dHF1UjQzV2tMK3hmblZsTUw5bk8y?=
 =?utf-8?B?Qk1sa0RSay9od2YyWWdIMTBBakgwSWJuQjlvOEhPdDMvRXVScmh0S3ppbmFT?=
 =?utf-8?B?c1ZLUVhWemNlUGxoK1AyQXVISVI0RVhoVzZwSkhVVU1rRHJ3LzZxb2FKellt?=
 =?utf-8?B?ZmtSVlplaGNPTWx4aTJldVhyOXEzSHlackhET1QzdFlEZTRPZWRQVkRUMVBr?=
 =?utf-8?B?eEVzNFc4M2R1bUMrTGNLVHlBQWFFdkdubVMyZXgyQk5QaDNRTW1zcGxJOERE?=
 =?utf-8?B?eng0aWoraWVmVE9mdml3RzY0bUszcmwxakk0VUk2aGVDODlNV1Rmc0JhalA5?=
 =?utf-8?B?K3VuQldzb202QU5TZ1N2YlBqdDh0Q1Z0a3BFK1U2TWlweFpIWUtIbjQ2Y3Iv?=
 =?utf-8?B?MmViSzdtSE5KNXgzQWNYK0g1Rnc5R21GSml6OG1KMjZJYThTRzdFYW05UGdM?=
 =?utf-8?B?bEpKN3B3dE9nekpNRmhyalArZlFobDNqMGM1SHVNVGV2eFhQN3NmVG1MOVVs?=
 =?utf-8?B?S1BGRUNMeWNHVFRWSzNBS3luK1lmaTZWY1Y5NWdlZHZYcS9JZVFadEcwN0pX?=
 =?utf-8?B?NmVBaHZqL2dOZGVCT3p3Z3hORnQxS0l4OURVYU1aL2xnWjBSbDRySVlpcU9y?=
 =?utf-8?B?U2h0amNPSjR6OGVZeG95UXNwQnZSWkc2eDZlcXBqWWZmdHN5elZ0aUY4MDAy?=
 =?utf-8?B?dEViL1A3K1hwbzNDblNEWEF0emxjc0RQWURyUW02dms1Y2xGeUFtUDRRRU9W?=
 =?utf-8?B?OTlaN3FYTm91Wmh0MlNPTDNCZVRUc3RLbUo4d3NMMmRONnRYTm4rR3ZOWTFx?=
 =?utf-8?B?dWRRbUM1U2FEQVM2VU95S2xmNzZtMno5TVlVc09sbkhNaTdGdFZoZ2hGUmJv?=
 =?utf-8?B?WGdsUnBDVS9IcG9rb2ZNMndOLzZMbWlmV2N2MDJSM2tXWVRBODI1M3p6Zk1w?=
 =?utf-8?Q?2dWHGQoTZf6hr0vfZ8PVbJzgE9/V9QNYfMgbs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkxhbHZHaWlzV3Y0T3M5ek93ZFdZU0prZnFqRTFmNXg1UHYvbEVkNHR6bldS?=
 =?utf-8?B?b0FDMHJRcWN3Y3NnNkpzOExzQmJXYUNtUElseTNaUlNkVVJadDFNUEpiTTUr?=
 =?utf-8?B?VWRMNGFMdTlNU3I4ZXlyUG9BTURmS2dCYjdRZVBTZDZBYUpnS1o1d01mRllj?=
 =?utf-8?B?VlVyaExIU3BLeG5BbVc4VndrN1k2cWlMaEp4Zkh5c0pET1NIZTQ5TzNESU5y?=
 =?utf-8?B?RmlqbUVZRklZVXA5aFNoVFU0THRRbHpIdkpJdUJCaENMb1Z4ZzNJTWVGVktR?=
 =?utf-8?B?OVV6TEhpSzBaWWs0SjdaaGxhZDNEQzJoVWpiWFpZcS9RSWRaQS9ZaHBCWHZu?=
 =?utf-8?B?dEVBVjBmVUpzYnlpT0FIdUwveUpucVJHTll3VXp3S3cxRFF0VWpUM3JXenZR?=
 =?utf-8?B?U1ZhNXFhZE1GaFVnVzdEVE9uMTZtOFVjRnA5TlpzeERPcnVrTGtMK2lkUG9G?=
 =?utf-8?B?dEhNVmpIYll2NXJrOVlYd01PaUtXeWR1bE43TThPTDAwUGx3VW5xV0hiSGhV?=
 =?utf-8?B?WTFsYktSUzFTTWdrWEd6M1RaMTg3NHJBMmNaTUlPOUYvNWsrWmgvTVZRWjdr?=
 =?utf-8?B?K3R2blVhN0MySzExeGRhTXN5VTNFNkxQNUVLdHl0WGF5QXcxRi8vaXpMbit4?=
 =?utf-8?B?WHVIZ01xS2ZqY3F3WjFUMkw2NFhtdGM4czdQbEg4NEJFQmNmZk4vK0FPUWQ1?=
 =?utf-8?B?Rit6MUFsaXNEVVBGOSt1aXUvblVaQTRteHNqTXYwaDdCYXUxV1pmT0dUM0RG?=
 =?utf-8?B?QXNyWlBPZzZ4MmtHSGVFNERPSUg0Ym5hZGFOZnRCTldsUjlsWlhUK2NZREpJ?=
 =?utf-8?B?Ny9lT005eW0yc0RZMDE0SkhVTTV4TVoxcUpMNmFtbEdUQ3hnUUpRUnBLaFJD?=
 =?utf-8?B?bUJWRTI0bkF1Q0xyMkdhSTgrUExydmJwTWtRT21zcnJIcUd5dDNtUC85eTZI?=
 =?utf-8?B?YS9CUnBZVnFtL29rUFFUS080a040OEFZOUVNekRKakhiUmJ3MWhoK0VadEkz?=
 =?utf-8?B?LzZubHFWdXAvTnc0aGdUZ2hKY2ZWUjg4NjFFaDl6TEdqMFN3VEo5N2JSUzRr?=
 =?utf-8?B?OXEvZGZLL0J5VUtUK2w2UnVQS0hMdUFwbDI4T2dBTGRMWnFVNFM2RG0vNW5u?=
 =?utf-8?B?QW5nU1FKWUVSQVlWWlpvUnExVndlZktaRTgvY1NZMUhyYUJzYklOTG5Za3RD?=
 =?utf-8?B?MVhJNU5xZzVQamhlN1ZBWkN3Kzh6Q01JTlZwTGtlNkhtM3pSZXQzM3MwVWo5?=
 =?utf-8?B?R2pHT0psNzdRenZmKzdwR255RGh0YnBndk5Bckc4Ty96TWVpdkh4SUlLb2da?=
 =?utf-8?B?MHVLSFVOdjkvdWY0MU9TZzhPZlF3MW9ac25MRnNJb1pOVU5ZU1BsYk1ZanBs?=
 =?utf-8?B?KzhsblptQ2tsd2NKVTVBNGlPL3BCSmN1NWxFVXk4WG8xYzl4V0tBZHpKY0lS?=
 =?utf-8?B?ZVhWbURPVE0rejd5ckE2bWxTR3NycElPOXhhZkpBVldNbWJHREhSRFkrSXJS?=
 =?utf-8?B?K2RkRGJ6S25HSVdWSDJXbUt1RGNzbWo4Sy83Q2FBcFpPYWRhYXI3dmhBSEVY?=
 =?utf-8?B?RUpvYWNjWXFlbWxFemU1Q0F2Qm5nZGpkNzR3d0JOMkFWNkRkSklNdEFLM1Qw?=
 =?utf-8?B?MGE5aFJ6OU91SWdTQjNjSjZ2TUozenJTY0Zsc2h1QzVGSmRmMDRBK0VpWWdm?=
 =?utf-8?B?aU45ZzBWRXRUckl4WUJNb2dlZjk5b1JLYlJveE5CeWs2V2lQcmZlVXBUT1JN?=
 =?utf-8?B?Z1Jrdy9DZUJBbEhtREQraEJLYktXNnVabklSQlZJcU5LbmN6elVOTFNwU1l1?=
 =?utf-8?B?MkdzSzFEMW8zY2FiRHBhSEE5eG5yc00xTy9uYWE5QkVQNGdHZWxUcFFZSG01?=
 =?utf-8?B?RDl1UjdSSzhOS1JUZzdsbTVleXVNMHRZaldvTUtROXJxZWdjTy9VNVZoNzlM?=
 =?utf-8?B?azRsM0trSDNYdnNBUU9BMkkvYjBpWDdTOGpkQXB1L2x6Nm1BLzRLTDFjYlVE?=
 =?utf-8?B?K3VpSTFBcUVNamF0R0d5UXVRVkNOVEUzVzhlM3NaVWZjSldjMUtlbk4vN1Bo?=
 =?utf-8?B?NVVvYWdCNnVEYmdYTThBeGlTOGpJTHNMdXVseWE3TFZqWkRxTFFzeXZkcnhi?=
 =?utf-8?Q?yLY2TSlN+QMKUYkp3iBOFWlyP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f53233b9-17c7-48b6-a503-08dcf1ffc7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 18:40:04.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DccYJ/TuxtlXYB8FnMgTksweMKRXLiIhtClddydC40b/wvvTpbSssMq7/pI73y/VeuWQWiiP63sgXEnGKLPQ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com

Pj4gSW50ZWwgbW9kZWwgbnVtYmVyIGFsbG9jYXRpb24gcG9saWNpZXMgYXJlbid0IG5lY2Vzc2Fy
aWx5IHNlcXVlbnRpYWwuDQo+DQo+IE1vZGVsIG51bWJlcnMgYXJlIGFzc3VtZWQgdG8gYmUgc2Vx
dWVudGlhbCBhdCBsZWFzdCB3aXRoaW4gZmFtaWx5IDYuDQoNCkFzc3VtcHRpb24gY2FuIG9ubHkg
YmUgYXBwbGllZCByZXRyb2FjdGl2ZWx5IHRvIHNpbXBsZXIgdGltZXMuICBMb29raW5nDQphdCB0
aGUgdGltZWxpbmVzIGFuZCBtb2RlbCBudW1iZXJzIGZvciBwdXJlLUF0b20sIHB1cmUtQ29yZSwg
SHlicmlkLA0KYW5kIFhlb24sIHRoZXkgYXJlIHNvbWV3aGF0IGp1bWJsZWQuDQoNCj4gRm9yIGV4
YW1wbGUsIGRvZXMgdGhlIGZvbGxvd2luZyBjaGFuZ2UgZnJvbSBRaXV4dSwgdW5pbnRlbnRpb25h
bGx5DQo+IGJlY29tZSBhcHBsaWNhYmxlIHRvIFF1YXJrIENQVXMgd2l0aCBmYW1pbHkgLT4gNT8N
Cg0KUWl1eHUgc3RhcnRzIHRoZSBmdW5jdGlvbiB3aXRoOg0KDQorICAgICAgIC8qIE9sZGVyIENQ
VXMgZG9uJ3QgbmVlZCBxdWlya3MuICovDQorICAgICAgIGlmIChjLT54ODYgPCA2KQ0KKyAgICAg
ICAgICAgICAgIHJldHVybjsNCg0KU28gUXVhcmsgbGVhdmVzIHRoZSBmdW5jdGlvbiBlYXJseS4N
Cg0KLVRvbnkNCg0KCQ0K

