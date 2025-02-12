Return-Path: <linux-edac+bounces-3036-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A6BA3276E
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 14:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377947A1423
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B50120F073;
	Wed, 12 Feb 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4yhkraq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323712080E6;
	Wed, 12 Feb 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367878; cv=fail; b=GwCadypPP7VfVUbe6LLDMilG6+OXcJiJcaGqrdcK4QlKxf0Iza9YjSQt9KB+YTEFg2DoonivhMyq0byeFiXyKXfKY8PPixvvenfxhkPEfrOnRnBAh4ZHGb9LyEAelqy+t512uqvFMcvHszsMv2Pink1dLEtv1suM8hUf6nadB9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367878; c=relaxed/simple;
	bh=n1jOnKRuuwopb+at4eJZS5uk0QjGvs/YQ69dQweiSbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUo7X5R+HHksQxz0xLCoKkrCBsEBHi8BfLdAs8a5gZzeLZrnQPU6uYQTkV3eWWp6+gLDBDdKLu3Sx5jkBAVAG6jvCsHkwYUiK71RhOZrP6kIJkh4wm+H4bam2l76oVC+GO94Ux5p53hLJYYjtWU1847gShxFlLcV//l4PqmKCYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4yhkraq; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739367876; x=1770903876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n1jOnKRuuwopb+at4eJZS5uk0QjGvs/YQ69dQweiSbo=;
  b=i4yhkraqigNCUyg5jzCzo77672Fodup1vrVz8OYmY6u3Qnvsk1lZusEw
   Y2r9+kmErRJQ151PrsdsCSW4l3fdCCCesAhBhfA1rvkD29xGn5NiRx6dy
   Wx4ITzBOsgRBlYYgaYC3CVF61H1G9W+S3qXn4eWccHmLYCXui3NA+oHpq
   uiPMAu+xyrAdJokKViOrOKB1mAccauuJzKhgszEGHlxnF6H1gT5q2WbWI
   YCDKylLptAitN2Fmdg1bWIPB8vb19lFnc5V82mZ8MxB0sS5iPGEruId7F
   oJyHNm3WCm8tl9emFqLKd4mPE2WbHRvdUG/0nRhDLgibp8K6msj8IQHGw
   A==;
X-CSE-ConnectionGUID: bDhcpXJnSXGukF1PBhsWVA==
X-CSE-MsgGUID: LGh5pb0kQ+u2HYbI/tgqpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40146271"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="40146271"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:44:32 -0800
X-CSE-ConnectionGUID: zSuFWx/IQhuX494SQkNzyA==
X-CSE-MsgGUID: xUfLMNn4TCSGVhRnvX2//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118003451"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 05:44:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 05:44:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 05:44:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 05:44:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy94xmQ25wW40d7rkmVVZrNhTdsAUCzz/Ycn/cxjcaZtrqK+DHzj0S/O8nW8i3An1AUMaDa9nsmkZ7lm4/U/oRmgbUALBKo5C6TUWhJz/AFur0o2Ng5yOQLL8fqYU83aG+ESJnyhbXZUKowA/q4yzB0SDhV7EwNMNYg0dxcGqE5dm3wPujGnPIeqz1YHBIt6p13i99p3Tcn7nQVFVFHqI+OQQmZXffcYlHozY39PoYQrcDY8xFlNDyuyzraIox9hME5hCqFDZ6q5jR1qns+pEcI75iu9PcYffgCX0cR+MaaCl5RIfVRxUa7RWMqjFd6DvTngcUvvBFzvQ3/IKm4Xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1jOnKRuuwopb+at4eJZS5uk0QjGvs/YQ69dQweiSbo=;
 b=GkG91HoQhOteFXDMrEjLi+9qhYCo2TdbB+vZLzUkScRI+C5u2eZtxeZZ7UB0FkwIwwn19qCY3j+ro5MhSLeCWaEIHOGoUGd49uKKsvUNgYZGdyzJcHOS9iyOx6gqaaezwSXoBocZ29ANVSjXG8AE82CNsKVvkwpAch+tJx+lJjnvmwgcLNfOCIwR9eB03VlfhSAd8wFvK+P8hSd00XXeNe2VNrhephr1T65srBi6bBvQ2lr1YnIdMfudbXcTcPOpfimX7irxg7MOne1DfuQL8pu15BFqOVzhjDBeGKbJ7TckjBjFxxNfemPiMWQ24i1MSzP91idoF6zMP5sEwWWF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB7844.namprd11.prod.outlook.com (2603:10b6:610:12a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 13:44:28 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 13:44:27 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, James
 Morse <james.morse@arm.com>, John Audia <therealgraysky@proton.me>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, "ramses@well-founded.dev"
	<ramses@well-founded.dev>, Robert Richter <rric@kernel.org>
Subject: RE: [PATCH] EDAC/igen6: Fix the flood of invalid error reports
Thread-Topic: [PATCH] EDAC/igen6: Fix the flood of invalid error reports
Thread-Index: AQHbfUboQoh8tngfwE2mQPlzg+2wvLNDrUuw
Date: Wed, 12 Feb 2025 13:44:27 +0000
Message-ID: <CY8PR11MB7134D73FF4D4B8733AA4B56289FC2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250212083354.31919-1-qiuxu.zhuo@intel.com>
 <ef5b12b4-d7f6-421e-9339-8621fb672021@web.de>
In-Reply-To: <ef5b12b4-d7f6-421e-9339-8621fb672021@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB7844:EE_
x-ms-office365-filtering-correlation-id: 190370e5-368d-498b-8053-08dd4b6b5ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHBwWWdwcmJUdkRqMEcvV0NYM2xaa2NST3hOOW9yWkhUa2ZyMndBUkEzYmhm?=
 =?utf-8?B?d0ptZ29IYTlCZkd5d1A0SFFnVFg5TzlxZFJoNFVrbU9TQ3ZGbE1XbnlMcHJI?=
 =?utf-8?B?em4zNDF4TzAybk1JMTZSbTEzbnFHYkxTM3VKNnA2SjhzS3gwUHo5a2FJUlJS?=
 =?utf-8?B?SkhRM1F2TURFZGM4NllXc25EY2NyU3hXbGtLMk1sMlhCTVB0emxJUnlscGVp?=
 =?utf-8?B?N3RLdk5nNERsMU1DQ0hCcVZSTThmK05EWURhY29PaTRUTTNoYWhQT2xic0Iy?=
 =?utf-8?B?NmU0bVV3VDYzVVNndGx5TnV2Q0xnSTcrRzdOSk8wNWw3S2NRUGlsakIvWDlt?=
 =?utf-8?B?MXo0Q3NDZExKaFArUzZJVjViZmw2dWNDQkIxM1hiWEg2YzFwTXdOUUJ5UGpn?=
 =?utf-8?B?QVVyMUdNYWVMSFFXQjFoMm5lM1FYNGNoTEo2UXgxWTRGU0FabG5KVXlYQi9h?=
 =?utf-8?B?VzRNQloyeGl6K01kYmtpeE5BblNuQjdLWXNINjVTUUNHQ2kwYnJJMXFnYVlu?=
 =?utf-8?B?ckZMWnlQRnJWYUJ0di9vQTJYaVpmU2VVaDRwbUhkTkk3NDJiYXZxTWZRMEZj?=
 =?utf-8?B?WWJBUit2R2dqVEI0elExS3Z5V3NxNENPT0UzcWhQcXVDTTBMK3JYLzZVVzQx?=
 =?utf-8?B?QUdINUhyaHlFV0h2MGV2c1pZbEJBbnd5TW83ZDZvc0pEVnRnbm5MSGk4Qjgw?=
 =?utf-8?B?SWtNaEdQQXh0TDJQbk1XR3dXS205VWxTb1JCL0tFM1NFNUdRMmE4Z0cxaFRk?=
 =?utf-8?B?d3NiUkN5Z0hpYmd0d2JQYnpOT253UUJyeWRqQ201QzJ3WDFPSDFINnFhNDZ1?=
 =?utf-8?B?eXJHVGlORy91Z0FXZHh3SDZaRGFvQU9EZ1RjZVg1dXFFajh1dlFWdGFYTVRX?=
 =?utf-8?B?aWJ1SytYeHN5RjJLVzRFa01YTWdhYkgyL3JuTWZRZHRRdG4rbGMvaCtOOHpJ?=
 =?utf-8?B?NjNJNFR1SW5DMVcyNUtSK01CSXdkQ21FL1FOS3BhOVFOMk1zTWk2OVo0ZHlK?=
 =?utf-8?B?aU1LUE4vMm9uSy9pRXBDVUREL2hoaDEvOWVMVG5rQ1cyRlAybmRYZnJESmdO?=
 =?utf-8?B?Nkw2TGZzc2hPNzV3eXgxTHFQbHBBVUZ1dXE1MktEYzRrWFZKdE9wdkJOWlRq?=
 =?utf-8?B?TjZhbHFIbFVKZkFoYm1iUUM2Q0RsNE1ITWJSa3lrSUZURU0rM1VKY2ZqTGV3?=
 =?utf-8?B?Nmt2cGJvdnZ5VUtoWmk5a282NHFMUlFsZkd2Ri8vNXI5OVI5WnlMRVdqWjhG?=
 =?utf-8?B?K3dIcTBHMmx4b3BOSzYyeUh1T2JXVkdlQXgyVGhSMTlHK2g5Vy9qREVER09q?=
 =?utf-8?B?OERrQng4bVdpK1pva0hlSGtkaktQUmtJY3ExQmZLb1dyWElneVc0bnI5N3Zk?=
 =?utf-8?B?alhUSnJRLzllS2V4RW5ML1lPdU8wQXBSQmZybU40UDhVSW9CaW9hQUxjcGpI?=
 =?utf-8?B?KzM5Z1FsaW1TUGszTFZOdnVqbWliSzhZOGN1aVVWMmpkcGRBSVFiSDROU2l5?=
 =?utf-8?B?Nmk5UW5mNnNXeEJXazZaU2ZCTnRYNDFBUHZkN0RqNkZjSEh1OE9nQ3hBdmlx?=
 =?utf-8?B?clh4Mzg2d3JIdnNpRU1yN2xkRWpLcGlHVnZoR0srZ1BKN0V1M05JTDlodnNi?=
 =?utf-8?B?YXpJZ3FIMDFaRDhxOWNkV1BRS0RFWTJmbklTR3hBVVhGS1Qyc0FyckZvdmpR?=
 =?utf-8?B?L3BmTTJGSFFpK3ZGMzltVzdwUnRxVGFNaTZMYzE0UG8zZ2xPcFBUY2JYVW16?=
 =?utf-8?B?MG9BcmlDdHhVS242UW91M2Q3MDE0UXh0Q3AvVG1MTGx2bFdjQVFVN0gyNUdV?=
 =?utf-8?B?dGRETXJmOG5nd3NGSjE1NlEreHp3b1BHQUNlalp0K2tuSmE3bDVhVXZvY0pt?=
 =?utf-8?B?YXFUcDQxVUVON0pFWHhKWnRYUTVTb3R5alFRYWc5dXBWaXErWk13bi9uc2s0?=
 =?utf-8?Q?9ASiwYsOl+NAz7PCT5IzNblQOikmt8Me?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtXUmsreG5HRU9nYzQ1TDdjQkhSQ29BSjM1aUIzbzlzeVJGRVNENmhoNDNa?=
 =?utf-8?B?T0E0RHVOMVhaUDE5UHZBVkVwOW9JamZqWGNFSXVodVBPeVBPZlB1bGg5Z3kz?=
 =?utf-8?B?M2NaQjd2UmVObnROTm5OSDJhL1FYRVRjS2ovRklENnp6OHlvMUZNQWFFRUdR?=
 =?utf-8?B?K1hCYjRUS1BpanMyd1FFQzVISjFDQnF0aEdUcDNjcmkzWmdTMHBUa1FvOVVC?=
 =?utf-8?B?TFltTkJhM2MwdUdlM3dCRVVFRFI2Y1F6VXBSUFR3Q2ZDSXFvRGIxcGhTeGVz?=
 =?utf-8?B?d0FySDN6U05yLy9MQW5nc0dtUjBaQjFudTY3QVdscHlNazZYMVpFMkluNjVm?=
 =?utf-8?B?ZTJTdU04MTZHODVRM0VIaHlhK3hMcEh0c0VTWUk4eGllUVZjT1NSTFBVSWtu?=
 =?utf-8?B?aHRHS0RnYjg1TVlSY21ZbUNJMWVEQy85bCtzbFhEb2pvS2pBQnJ4TGlsK3ZB?=
 =?utf-8?B?Q1VNeWkwd2t0YmRqYy93YU02dkk1NHEzNE0yVVNKQnJZRzdUT2tjSGJuK3Zk?=
 =?utf-8?B?MEhzZEZLcDU4ZUdLMzNMdzhWQ0RIMnJBM3F3RHpUbVZMSE1Tbngwa0dOdnpp?=
 =?utf-8?B?YTc2eXdsdGlndVl2TE1IYjZpZXZvVzlrM0RSQUM1YmZKSjZBNTJYcmZwN0RP?=
 =?utf-8?B?c3g3MldldEx0UGZPNm9VN0xnTit2dE5OMmI1UmJXVkJlc3VoUWRlKzZLUDFh?=
 =?utf-8?B?K2hkWFFTUTlXWjl5VHcrcTVMUGJZQWJMUzRFdCt6ekF3NnhYWDlxWVJuMEd1?=
 =?utf-8?B?OE1ZNEw2b0xMZkZzTEFic00zd1dCV2VGNXp4SGV0cWtFcnhVYU4wVTBUZGc2?=
 =?utf-8?B?S2k3VjZ2Q085THA1SzNoN3h2RGQ5dWxoSk11alVZTVdDeUJCd2gzamZMb09i?=
 =?utf-8?B?aTdSdkhyOVJRbGRxa1JoWGZvU0lmQTA4M3JwUmNobU41OStlY1d6VVpMbjls?=
 =?utf-8?B?YnNpaTFCbTd3ZlA0d3lPSDZTN3NXL0gxbTE2S1BTTzJSZytEY2MrTWYvWTBX?=
 =?utf-8?B?SXBlc29kazJJNTZmQnRRS3Rjbi9lV0tLWEltVElEVFFZSTVEMGVEb1FFSDk4?=
 =?utf-8?B?ZVU1a0NrRFY4bWFYS0V5TTBGckduTXl5S1NKc3VuQ2VqbjFWRCs4NkljN3Ir?=
 =?utf-8?B?MGZRTWwyM0JvMVdtQnJoMGpVTi9xMElFck5EdzFsRTVaaDRBL2J4ZnErRDhR?=
 =?utf-8?B?NzdNb2pNUkVCQW9mY2g0Y28rbnp4RVRhZGVBRUZWRzgzNjdWdTZpaThCdTlC?=
 =?utf-8?B?dHlYc3FTZDdtY3QrR2JYbnpldkY2M2xQN1dSeURveG5LaGRsZkZmZVNxUGdT?=
 =?utf-8?B?VDAzdVRxNnlabE9QTzdPMVFPL0FNZk1tT3J5YmFnTG51S0E5cGNYSFVIRGZ3?=
 =?utf-8?B?NFF6WlVITEtmTXBpdHduc1FNaGdkbHlQSU5pU1hkdVFQTURpMFcrYUV2dzVZ?=
 =?utf-8?B?OUpvZjF4RU1veWozaEZoZEZySkFPV1gyK01ES25GQlVHcUk2WG1CdWR2eWVE?=
 =?utf-8?B?K0lzcC9LaWZ4ZjNVNkg3U2dxNE53SE1VNUlHQU1xS1ZIN0FEV05VUWFHd3BJ?=
 =?utf-8?B?Uk80WE9FRWMxd2lxWmJSV29FSlpsa3gvRi9DMk5aV3VUblhXd0hFbWJFcGhQ?=
 =?utf-8?B?Z1ZFSlB3MERJN3dCekxRRHJscExlaUtBUmlhTVR5Ny9SK09RWkR1dUxEY3F0?=
 =?utf-8?B?em0rU2V2bU5oSTRXMmNWWGh4QXRhRGl5N1ZQTDRlWnNhRGhBQUtPZmlkKzBB?=
 =?utf-8?B?ZDRYb0gwdUtOZ0xuOWQ2NXVHSURtdlU1MHFJZm0yM3BQc0dMRlBSNkFwQmFx?=
 =?utf-8?B?dGJVOUgzck45N1JIUFBNWlR6WCs1OTlZUysxRnlWeDhpOXI0eWlydjJuVHR3?=
 =?utf-8?B?N2lZVTlFQzlEbmFzOHY5cUI4Rmdlb1RqOWFXWG0wWDdpR1VQeDBxNmxzNGNQ?=
 =?utf-8?B?SXpFWGVxRWgyd3hIdHJXWEQ0OGNkUm80RmRKTkpFT3dINFQ2YVAwMU5xZGN0?=
 =?utf-8?B?UjI4RXFJazd6SU4yWHJ5SzJqbitPVERlenpoSm9tYStiYnR6TnIxSHRENDdm?=
 =?utf-8?B?eW0vWHdoSnhjRG9pRWFhd2laMytOakZWaFRkNFRjYlFKT0twREZKTzJlQVIw?=
 =?utf-8?Q?fNXD9RLK6RhYqoVRKJFW+pEZQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 190370e5-368d-498b-8053-08dd4b6b5ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 13:44:27.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8neP/tz9QH9MZzZLkOtXsSJ9+sqc0iAyf510ROjFhHk1JF/y/RG2C3/tjiJWwmNTQcVenqrLKQX86U6Cgkeiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7844
X-OriginatorOrg: intel.com

PiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBbLi4uXQ0K
PiA+IEBAIC03ODUsMTMgKzc4NSwyMiBAQCBzdGF0aWMgdTY0IGVjY2xvZ19yZWFkX2FuZF9jbGVh
cihzdHJ1Y3QNCj4gPiBpZ2VuNl9pbWMgKmltYykgIHsNCj4g4oCmDQo+ID4gKwlpZiAoZWNjbG9n
ID09IH4wKQ0KPiDigKYNCj4gPiArCWlmICghKGVjY2xvZyAmIChFQ0NfRVJST1JfTE9HX0NFIHwg
RUNDX0VSUk9SX0xPR19VRSkpKQ0KPiDigKYNCj4gDQo+IE1heSB0aGVzZSBjb25kaXRpb24gY2hl
Y2tzIGJlIGNvbWJpbmVkIHdpdGhvdXQgcmVwZWF0aW5nIHRoZSBzdGF0ZW1lbnQNCj4g4oCccmV0
dXJuIDA74oCdPw0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBZZXMuDQpIb3dldmVyLCBJ
IHRoaW5rIHRoYXQgdXNpbmcgc2VwYXJhdGUgInJldHVybiAwIiBzdGF0ZW1lbnRzIG1ha2VzIHRo
ZQ0KY29kZSBtb3JlIHJlYWRhYmxlLg0KDQotUWl1eHUNCg==

