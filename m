Return-Path: <linux-edac+bounces-2956-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C46A23297
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3F18842E8
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24111E9B39;
	Thu, 30 Jan 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev9eBu5I"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6913FEE;
	Thu, 30 Jan 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257258; cv=fail; b=qnk0TplRD8FLEE2qtXGeRIohQKLpaXVPhni/G6veKelLAqqztmWw/XpGsMPzcBDAFs80zW/Jz66IAyae+s8QdpOAsLGeGGxaaRiuzsqz15ziTx5+5qEo2z9q/g27DBf9p+QNYpZ7FZechcIQXoQrFkU6STA5GjmTbk2D2q4r0HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257258; c=relaxed/simple;
	bh=r9/Qjg4YixA4yovMz1duxlqBuFGW7n1IswdcSluUlcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jXnF1ctC6dZTh1ao62ysUFnkAtMjJa2cDFWiiDcu1tvwYwKASUTOb5Nd5EYlZ3kwJh/P5jJXGm/B6WGofEs31I5Ql/y2A41/xkMA0pZ3ZioM06HI8D8JuFVbpKGPQPPcknkyyrxrMREn/6kEZgiSieIdkkZgEEQH6vSjXVIRZ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev9eBu5I; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738257256; x=1769793256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r9/Qjg4YixA4yovMz1duxlqBuFGW7n1IswdcSluUlcI=;
  b=Ev9eBu5I3sJg53XWFMhKPRMUhp9A2GX4tCmg2HkP6/kY3/KQPfDcAy7t
   idffBegdpeVE40rrvumxL6/uW+fDS0w2ooPu7fkGB99R995/Blug9H6Rm
   V05omwDI2a7I68v9tmOnpUov/jcsxizBOzwc7YmFt/6ouF6xXIsqGIprc
   G5NN6GJznkgbXAAEN48G5wpHBazxO7fDcp4T/XDQNLfJldbEbzqD6Cobk
   VrgkgiJSXemevxEZys/wv9Wx5lul1fz414NxL0c9Kxb4FAuUfBjPlWm1u
   hG32WnTbfOoP8Dz2z7Fd4v0zheE7R+nzoMAA/4x3ovGVvIM0v5XIbIgRp
   w==;
X-CSE-ConnectionGUID: 7uzkDEBrStC4LyMGpPZfrQ==
X-CSE-MsgGUID: 40t7Rm8NSumCF1UY35i3Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38705451"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="38705451"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 09:14:14 -0800
X-CSE-ConnectionGUID: HQMKsQvrROCKLDEE1I54oA==
X-CSE-MsgGUID: zCzROWTRS+uQoLbSJRXY4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="109188134"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 09:14:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 09:14:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 09:14:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 09:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKUUHXwr7qHm2Rx3mUX98vF4oXUD//3QjJCAPzQr8jqUiE64xipWdxehP1ucOVzxOLwtfuAd7kvO0hOS/ARG9tlZZ+VHLWeFaj3kieTs18a8eGkooMAwQG4RkfIbWlEToD0qmukYhbyZPnVMrav0zdWTDZbtpGgGVoTu2kHsW1IxDnRD2NO3uxvTn8tl0/jHUQGwRGjWGiAfMk7iSVYa4B7z1Zhakf42nS3E4q6ZMMhmyfoygVbLt65KM2TkoxfcLuf5RQWnGVrBnvqFiznnT2UoG9yFsbb71W2KM8McibGKIEnFB35xAGYPo2HTltcIVIduht4HFOoJb/YG0yy0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9/Qjg4YixA4yovMz1duxlqBuFGW7n1IswdcSluUlcI=;
 b=RIj+Tqi2PGHmoekx4yyWbB/K+QoRpJ1t53WuUou7ZoMXY6Iobpcc6tVTNAFQjl7w2NMQpvnsnCpBt+A1FHWayMj75vx/7lfw3v/UHRyHJXAswZG13e9PgjJxm823mc6YZ9NsruqJ4jDmHEh9HO9hW2E6Vi2Bc/CjhqAS/Y9Mv/1AtKk2VNMxjVBppUVfJlEI6BneWCAsoWyJd8TTmmgzVaFEGMRyLB/KuwPga5DErhJ7C7UNCOE0rsFyvrWlWa8mJ4FtXTzWl9pcRIgETaZfgAAeIo01dCZ1FACbeEUb9DXBuAAbBxIHt6WkwBWP800KUE2HvIENKQuVPU1e4FXFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 17:13:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 17:13:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Haoyu Li <lihaoyu499@gmail.com>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>
Subject: RE: x86/mce: Potential Information Leak in __mce_read_apei Due to
 Uninitialized Bytes
Thread-Topic: x86/mce: Potential Information Leak in __mce_read_apei Due to
 Uninitialized Bytes
Thread-Index: AQHbcxJskyLFXmlWZESMOmawoC3UmbMvilyw
Date: Thu, 30 Jan 2025 17:13:28 +0000
Message-ID: <SJ1PR11MB608343DA951D303A36B2A29EFCE92@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CAPbMC766gbD52cADhXwK0BC-gN-pmTa0+4Kk4+hyM6LfAWrhJg@mail.gmail.com>
In-Reply-To: <CAPbMC766gbD52cADhXwK0BC-gN-pmTa0+4Kk4+hyM6LfAWrhJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB5911:EE_
x-ms-office365-filtering-correlation-id: 50268039-9422-431f-f832-08dd41516a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWxXSjFRQkp1WUhIRnN3V2pjQWd3N0JqRDV0UkFkQW9GdTE5VCtNZVpmUVlh?=
 =?utf-8?B?Z0h4UEgzZThyKy9NbWFXMHppSHlpWnBoYm5nTFZiS3B4YzFCSzZzWkJheERG?=
 =?utf-8?B?MVRvT3pnWGV1T205enRYQVhmelZjcFo3N3IvMmM4YnF0aG1lV3BCbWNFNk1T?=
 =?utf-8?B?Z3d4S1YyY1hEbldoa0dnZUhucXJpWTkrdExVNENWeDkyZ2JRQjMxQUJBaTZr?=
 =?utf-8?B?eFlEc014dG9YSEJZTzNyOEgxRHlYM0xlKzZ6NTUvbERPZFlLbXc5NndUVVdK?=
 =?utf-8?B?QzJPVUVMMzhhdUU2bXpQVEd2d1BKbXNnbzlOZW1hSVRIdmIyZ0t4MkFLQ0Y4?=
 =?utf-8?B?U3BoZWNFQlVvOVZrTzcyVVNEeTR0YllsOU42VjZ3YjZ0SDRKa3lFcFRKMnRO?=
 =?utf-8?B?cmhVaVNITEp6WUtKOVA0NktSVXNRMHA4SEdoTTN5Tkw4Z09Xa1liVWIrb1dU?=
 =?utf-8?B?aG16T3ByeGowL2lhT213RU5vWlNKTEExbVJZR2drWU1vRWZYNHplRjhXM3p4?=
 =?utf-8?B?Zmx4MUZXaEVtaDhwVkFLcGU4RW9OeXh0ZlVoZkN1YStoYTZCZ2FsM1B4ZDZp?=
 =?utf-8?B?Rk5ocWtIWXRmckZiS3RZbkNjNVkzVStteVlpVGd5KzNDbXdNSm52SzhYZGZ3?=
 =?utf-8?B?dWNYUU05NGw0b0ZBOTRSK0lWT2R0LytSK3ZIbk1Jd2pRU25hUWpVR3JHLzgz?=
 =?utf-8?B?VkZKWVZFWEYxMkx5bXczSWNpWXVrZFkrWHRYZGkxVDViQ1dCYmROVzRGeWd4?=
 =?utf-8?B?aER3Rk9iNHZLNHpVR3lzbzcrUE1wT3kvSDJuR0JWd0xYcUxGOGlJM0RIZXVR?=
 =?utf-8?B?TjI5ZDQxZVZlV0lsYytBRjNaYUc5TFlZUUlXaTRROG5DdmVsc3dTZzNGOWZE?=
 =?utf-8?B?Z2Q4c3hXTHBKaXo3S0pVeDBSTlBCT2J3czNhZXhrSUIvLzdFMWl3YzdOclZG?=
 =?utf-8?B?UnNMMkg5QXoxVnlTbVltb3lGSHQyRXlTVG40OVpDK2JjVytwNWx3bFFGOERG?=
 =?utf-8?B?ZnA2Z0kzRGNyQVRPdG8rV2k3QWMzVFJMOHVHdVFzQzdQSzNRWkpwNDgrU1B6?=
 =?utf-8?B?ZGtsZU40Y0RVM2dwdnord1NJQ3ZzQ0R0Wk9MR1l4LzNGcXBPM285cUdiS0tp?=
 =?utf-8?B?Q0VhWGxtdy9BOVdjc0l6K0x1ZFRaRTJLT0c1V2QwOFZDbDh3NTJhTTd6UkRv?=
 =?utf-8?B?S1hEblFMNFVNNUozYnB0QjZOMzQzcVFBVFMySG5WMCtRNmxWVklBcFZWdS9K?=
 =?utf-8?B?dVNsMFpvQmZpLzRYL1psTktpeEdka3pNRmdaWjJ2UHF3L3VJbG5ET1lFZFpJ?=
 =?utf-8?B?ZU5SRytGdjRCdzJWK1d0LzhmYS9RNHliS08xcURsS2VGeEZzSndyd2dIRXZa?=
 =?utf-8?B?WEtEM00xZis2MWxlVkZTSm1NY1Uwd2NFdXVwZkxwVFhHRkJoV1F3MHFISTgw?=
 =?utf-8?B?YXhXRFZNNWkzcENyc1dYUU1BdGd4RWlhSS9HQ2JWYkYrQVkwQjF6NStKVWNI?=
 =?utf-8?B?NkRCSHA0d0h3NytEMDI1WEJWblZvbGdBWUNVQWFENVZ2Nkc0TlEzZHpwb2VI?=
 =?utf-8?B?ZHdRbVN1MkJOUWEvZVkxWkNvbmUvR0w5RmIzTjhUU01VaW5iZUxJRlVYdFJY?=
 =?utf-8?B?RVRPbjVIVFFDRVZrNTYwSXQ4c3NnY1FZZW16U1VZZndDbXZkSERCVGFUajNK?=
 =?utf-8?B?VmhTWkREMlBSSHA2bERLZnB4Zys4L1NpSVJCU2tRQzdHV2lYcFdjOTZPRzM5?=
 =?utf-8?B?U0FnYXNaR2lURnkvMDF2aEdQWjB0aGora09nd2xtaldqaE5Vc1FvMEpjaUJW?=
 =?utf-8?B?MW0xM29kT04xOGkrbzNPRjhyclN5N2o1N09NYUtTRHEyaGt2UVlYY1RFM2Vx?=
 =?utf-8?B?MW9CNHAycDlmQzdTbHBkWjFGSmw3S0tUdVlFcS9zT2lWYnhLYWdwT0NWYlYy?=
 =?utf-8?Q?PFjah80tyzehkd7GaCvLPi6Q4Bj0ZDt2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVoODVJWmdDTDQ1Sm1yMzgwR3prY3JJRnRpOThMRkU0YkFrNWV4elpsSXBZ?=
 =?utf-8?B?eTVsNWR0ekowS0lSejVRMC9lWVA2ZStHS0RVYTRMYWQyYjhWNUhmUFFRT1Rj?=
 =?utf-8?B?OU1EQzZiQlp3SmVXQ3NvanhWWExQSk1LRlk4cHdxTmJxL2ZRVG9BTGhKUHUr?=
 =?utf-8?B?MFNGUFo5c216b0g4RWhucXBscU1meTFmWFZuY1Avcy95UGJ3WmlRbmVyVTR6?=
 =?utf-8?B?QlJkSHhPak5pdm1QeFNueERzdi9pR0twRlhLZTY2bzZDaWJFZEFQRlZxUENl?=
 =?utf-8?B?c1dkOGE2VW51Mm9YMVZub2V2bk1ySXYwbDFUNHNadU5GODR5cnNXMzRDVDU4?=
 =?utf-8?B?ZE00QnhjbGplVHZsSXBtS2JCOWd0NHM2WnRKRGNZWEdOWCs4bjZvZmlQVlYz?=
 =?utf-8?B?N0NxSzJweDVKYS9PTFhpK3NnTjcrK1A2RFdtWHJCTFJCZ29WV0VxMERmeWtU?=
 =?utf-8?B?d2JKa1ptQlNFc2s2Z2phTkdWbzhKZk1ibWYvMzNCMDB0dktKTDNjZTd4UWpv?=
 =?utf-8?B?KzJVcGQwTXp5aTh2TEtVNVBiZjhmUUE3YzNTeXc4RjBFaGl3MnJQelFqcjJ0?=
 =?utf-8?B?dy9iUURFbS9Yb2pjeHpXOFp2ZlRtWllUa0RrTnhPRG5xbWwrS2p0enhLVjls?=
 =?utf-8?B?TnpQamlJMkRsbmxFaVBFWEpGQ2RibG9aK2h6MzBmZG8xZWpMcHV5dCtST1Uz?=
 =?utf-8?B?dkdQWG1oV0hiVUxPemJtTEpWS3JDeGJlOCtDQS9aTkExZlA0L2NSVGZkOXdn?=
 =?utf-8?B?dndISUV2RElqR1ZPY28ySGJsRUs4S1RLL3M0MDY1SVkyRnhIMm1OU3NwRFla?=
 =?utf-8?B?bk1zQXg2LzdNQTBIWS9UN3FaRGx3Y3hmZ2RxYnowc3dXaERzU1RaVTFWNDF2?=
 =?utf-8?B?K3NJWGdaQ0VoOWdDZHVjQlkzbThXdEpUZ3lOVUI1WVA0bjNZVkpxTDlvdVA3?=
 =?utf-8?B?NW9xWnp0WXN4RDFqSmZlZ3FpUWlMdHQzSEdGc3JOc1BHa0k4V1IwRjk2YkNG?=
 =?utf-8?B?Qnh1VmZUZVl3Skl2Q0FMMVV4bUxjZ0hFUm5hZ3ZQdWxKRGh6OHdKbjBMaVlZ?=
 =?utf-8?B?dGFmU01lZC90MzdrTzdrV21mWjNMdzVJRGZyamVtQVJEdlNEV1NGc3R3amZr?=
 =?utf-8?B?RjYzS2Y2SHU5TDREZmVQdEZiM081SlVqL1JqRXVaWHNmVDYvRW5FRzlnWlcy?=
 =?utf-8?B?eDlZNVM2RlhhRkNBWXZLcFZoUW9QdlJkNENnNWY2Ym5ZSlM0ZE50Tkd0cXgw?=
 =?utf-8?B?ZmRaNzVzWHlEVG1nMUJqRHVGYlRBa25HbkVzWGxxa1ZMODJ2djBUeFN6L2tF?=
 =?utf-8?B?WndnWUJHWFRMUEV2TjAxQTRDSzJ1OWp2a0FJZzFxeTZvVnI0U3ozWmRUZ0VO?=
 =?utf-8?B?NkwveFQ4TWJxZVkzZ1RjMWY4NEVXdmk1VmNERUlnS1FFZ2N3OGFLa3Q5R2pV?=
 =?utf-8?B?RUZuU0xUU2ZUS09GSUJic25sR0dpQVVRUG1hVU5uekpMVk80OVRDTTIxU1kw?=
 =?utf-8?B?Z0FVTDV6clIwa1dlRFhZcmxPMjF1NCt0U1ppMHF4VTVFanMzcVpqd0pjamVO?=
 =?utf-8?B?a3dObk12VGpRcDl5MVcydUlLcmEvNnJMOWV3MG9kTGErK2s3dEREMHBiWGM3?=
 =?utf-8?B?T1RpMDRJZWpqOTN3bHQ3SFErV0JaN1ZsYXlWUVcxTHBHeUtzNms0SGRWYUxi?=
 =?utf-8?B?M1djVk84emQ0MG1BQWVEZkZ2TG1Wa28yRm1lK3hpak1PMlV6VUc1Q0xGMEF4?=
 =?utf-8?B?TGtDOXVEdzh2LytxeXlTaW9POWh5M1JVK3V6YUk2U2Q5NE5TNmQxVll4S290?=
 =?utf-8?B?YXRMRlFHZ1ptdS90c1N6MGhtZ2p4dEJuYzhyUWhUbjh5VjlZWGxqNUVydnJy?=
 =?utf-8?B?QXYzOFRRQlA0Yi83NFlGNUZCV2lVN09zUjE2U0hPNDdIK1Vhc0RsNGpMMFQ0?=
 =?utf-8?B?TGt4RzRPWHphdlJmNTVOU1hYSmh2VkpvT3dReG92cVVJM1RlYXlPUXptTFpp?=
 =?utf-8?B?a2dHUFlSeGVpR1Q2UTdBNUYwWFNxbEt4T0xzM0V4R3ZYbjVLVVlmTEhaUy9n?=
 =?utf-8?B?ZGhlMC9DNW5rbHNicUt5eW1LU2kxY0ZmNlR3eUF2N3JTdFB1T1V5UmtqWm01?=
 =?utf-8?Q?N6MW+3MFWALSyFoSvrSnCkdZK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50268039-9422-431f-f832-08dd41516a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 17:13:28.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYja6nu1ip0moR0AO4P1H+WwTvHWfNH2lVX7R65zPJIOt6jkIEWY2FAkP7SR/grhcmCwecl4s68ckkP9SjZWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com

PiBJIHdvdWxkIGxpa2UgdG8gYnJpbmcgdG8geW91ciBhdHRlbnRpb24gYSBwb3RlbnRpYWwgaXNz
dWUgaW4gdGhlDQo+ICJfX21jZV9yZWFkX2FwZWkiIGZ1bmN0aW9uLiBTcGVjaWZpY2FsbHksIHRo
ZSBzdHJ1Y3QgbWNlIG0gaXMNCj4gaW5pdGlhbGl6ZWQgdmlhIHRoZSAiYXBlaV9yZWFkX21jZSIg
ZnVuY3Rpb24gYmVmb3JlIGJlaW5nIGNvcGllZCB0bw0KPiB1c2VyIHNwYWNlLiBIb3dldmVyLCB1
cG9uIGluc3BlY3RpbmcgdGhlIGNhbGwgdHJhY2UgKGFwZWlfcmVhZF9tY2UgLT4NCj4gZXJzdF9y
ZWFkX3JlY29yZCAtPiBlcnN0X3JlYWQpLCB3ZSBmb3VuZCB0aGF0IG5vdCBhbGwgZmllbGRzIG9m
IHN0cnVjdA0KPiBtY2UgYXJlIHByb3Blcmx5IGluaXRpYWxpemVkLg0KDQpUaGFua3MgZm9yIHRo
ZSByZXBvcnQuDQoNCkknbSBub3Qgc2VlaW5nIGl0LihpbiB1cHN0cmVhbSB2Ni4xMyBrZXJuZWwp
Lg0KDQpfX21jZV9yZWFkX2FwZWkoKSBkb2VzIGRlY2xhcmUgInN0cnVjdCBtY2UgbSIgYXMgbG9j
YWwsIHNvIHRoZXJlIGlzIGEgY29uY2VybiBhYm91dCBsZWFrYWdlLg0KDQpOb3cgYXBlaV9yZWFk
X21jZSgpIGRvZXM6DQoNCgltZW1jcHkobSwgJnJjZC5tY2UsIHNpemVvZigqbSkpOw0KDQpzbyBh
bGwgYnl0ZXMgYXJlIG92ZXJ3cml0dGUuIERpZ2dpbmcgZG93biAicmNkLm1jZSIgaXMgYWxzbyBh
IHN0YWNrIGxvY2FsLCBzbyBuZWVkIHRvDQpsb29rIGludG8gZXJzdF9yZWFkX3JlY29yZCgpIGZv
ciBob3cgaXQgaXMgZmlsbGVkLg0KDQpUaGF0IGhhcHBlbnMgd2l0aA0KDQoJZXJzdF9yZWFkKHJl
Y29yZF9pZCwgcmVjb3JkLCBidWZsZW4pOg0KDQp3aGljaCB3aWxsIG92ZXJ3cml0ZSB0aGUgd2hv
bGUgb2YgdGhlICJzdHJ1Y3QgY3Blcl9tY2VfcmVjb3JkIHJjZCINCmRlY2xhcmVkIGJ5IGFwZWlf
cmVhZF9tY2UoKS4NCg0KQWxsIG9mIHRoZSBlcnJvciBwYXRocyBsb29rIHRvIGF2b2lkIHRoZSBj
b3B5X3RvX3VzZXIoKSBpbiBfX21jZV9yZWFkX2FwZWkoKQ0KDQoNCkRpZCBJIG1pc3Mgc29tZXRo
aW5nIHRoYXQgeW91IHNhdz8gQXJlIHlvdSBsb29raW5nIGF0IGFuIG9sZGVyIHZlcnNpb24/DQoN
Ci1Ub255DQoNCg==

