Return-Path: <linux-edac+bounces-3121-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DCA393DA
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 08:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B984E7A224E
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D71B87CE;
	Tue, 18 Feb 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nbp56iCp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271B1B85DF;
	Tue, 18 Feb 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864245; cv=fail; b=aW4LSlj+p675A5qU3KwJkYSYc8usxCGAQHcu8Qs05mH72VCcIi1PXgPaYlxnW2rEPOkhZKe/5c0N7ozaxfi5R7VClPJoufY18f7Od3z6ebHgXmY1G13Qq5PW4IOUevBNfyZpQb7iZpQXdLNksCabDKWNOmL3j0BdAfcMH4z3WPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864245; c=relaxed/simple;
	bh=tokc9IecguZrbJFCVuEn5GJfhPyABGq2i29udusFTZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXkFpb4YqPZwuA4fphrpKb9Eq3wvoTbLSzMv0U6JkoTa6CYA5bxKyK4R2316vdJ4XjvwPP5/7HyAx90YuXTocc06S20kkXY3Io13xFtx1uQVt8s/63joa4ivhqL3x8cMqTxkSc4byuF9AQ/9o9uCZ8UVuL/u8QC3x6H48aI12eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nbp56iCp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739864243; x=1771400243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tokc9IecguZrbJFCVuEn5GJfhPyABGq2i29udusFTZc=;
  b=Nbp56iCp3S7YrtMFzRwQkifnvzzXH4XS/yz7o/CtMZHT0jANrAu93o7f
   6oinMwushXpU6f/2bfuTCthGrN2kWntD+3UFlzhJ/Cyq+VGwalplXb2ze
   FQWlywsIYgIPaNAzVCpVt5OnBtcBX2eF4GIHbDe/MUgJ3sH8x0tuZh26x
   hACvVAiOFoYMNoJEC3gy97bg7HgiOxkv7JLceB5lv8gnjuB2rZJ48zmOA
   e/7imKtTm34qNDfSwnhKVpw7P/y6s1IDDc7CM9uEnSKMqhWaDR2dP2+IN
   ReZWb981tYDOyfdqVVWdvNXBiQylTwZ15kTdKqUqGaHhUevx5YtIoMLU4
   A==;
X-CSE-ConnectionGUID: o0LlmmMfT7O6MLLAVD9F1w==
X-CSE-MsgGUID: OODlPqrTQQKlmOpBGKfJRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57952747"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="57952747"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 23:37:22 -0800
X-CSE-ConnectionGUID: xs63l5fsSOiBIKoTDkWa8w==
X-CSE-MsgGUID: 9bS2skXhSuqFKI93+kRx5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118446395"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 23:37:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 23:37:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 23:37:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 23:37:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpSx5McXx1FLmaFCWbMWw8HOycN6BxNW6oG3DO9rcL0QhoM3f3y/OT71TJAtTGUdNxjNV7pOvwPOG2wcLzlBtC4bA0hRj5MVG9BiBAP/SlHiN6ZIfxOghNibB35YRszEGwxbRxR+7A6J99ti8nPXdpyw1SmWUK7uFffYDArFszBoG1SOqvk7IxEzKTk4f3Ruz33fiKe+WUQPJbHBIMcGW6soXI6NUYKYrLO3FEr1nMx8yPieZ396a+VVYEIzAg0Yv6p8GcYP+JFByRjuyKimnhR3gy264n9MIKRCNo8SRwjQhoHiTMZpq7wIucE4iVJNAZjtxgz67aXnXem4vz1Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tokc9IecguZrbJFCVuEn5GJfhPyABGq2i29udusFTZc=;
 b=jYe1ngFhawN2Cz7RLcyDz89RFCkITPRW0sKTEtCfrcK0gwWzjCtA1gIbF986xqpdR3zYD1tzlLYqD27jKvKjHgU17TsjZJpU64j2HDMbGQbTx1cv/49TSmBXpZBZ9U2x/wgJ2aY+ldzEAVAar/jJwLmBqHJ2Kjr5UsUxMVihpBS6Ecmgu3jA99yM5/D/d0KtfJ1GtFi4B83gsJtqPLdTrdlv3ALR+eWiWLKsRPN2jjryaDmslt0budPD2SiHzhMwfxdrsdYN/ZPUN29fBpVpcdwO7nLRKfDAPX+AF0+y+0FolNMU88k67nLCxQSjDz14EZQUzsWR48UT9t1NQL/L4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 07:37:19 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 07:37:18 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Thread-Topic: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Thread-Index: AQHbfjgoQWs/bRLHLkmM5J8oXwf5nbNMsZTQ
Date: Tue, 18 Feb 2025 07:37:18 +0000
Message-ID: <CY8PR11MB7134EE8E03532382B8FC23F389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA1PR11MB8174:EE_
x-ms-office365-filtering-correlation-id: 0575f510-2395-402e-54c4-08dd4fef12c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWcydHBETGpqTHFaQ1pwellTTEVhSTNVZWc5OWVUc1pBMWV5dk13M0NZdm52?=
 =?utf-8?B?YVBvY3JtNUg1czZBdHpBZjhvbkhIdVNsaXNtTDVZcHRGeDBabFJneDV4WVda?=
 =?utf-8?B?QXRwUU5FU0NldzZiOENEWkZYWklyRFFTSnNuOTlpOXpmWVVaOGhOdVNFbkRU?=
 =?utf-8?B?R1J5aEN1cW5OanNUaHU5Si83MzZ5ZWsydCsvSldCQWFhd3BPc245eENKNkdw?=
 =?utf-8?B?WHdieUl4OUJueVcvdzc3WlBycllVT2R3Y0NMRkdKVmhPVk1NRGlPV0RpTUw5?=
 =?utf-8?B?SWFCYWI1amFDcUJHYVp5RUY2U2pSTW8yUEVMaHFJWXJJRUN0SnhCNlQrdE1l?=
 =?utf-8?B?RWtuUGNTZzhRU2JHTTVTeXBhQmR5ZXZabm5ROUdybEk1WUtYS3ZWTGlFYzgr?=
 =?utf-8?B?VjYzK2g5NTVWdXFrb3ZPSytsVTZ0ZjZmN2t2M1h0REI4cmMvVktYREVrTEZC?=
 =?utf-8?B?MlZ3S0lWbnFQeGlmbG1IZ2VGNERqbGFDbHpuZmNSV3lDL0xZd25BZURrS01E?=
 =?utf-8?B?YjA3bVlkaE5jazBSaGQ0Z0dCc3YxNzFBK2xqZi9vVmNEMys5MG1MRXZvRUJl?=
 =?utf-8?B?a1dnV3dZQTRpUDdSNzRTKytoak8wU0tlcmVDVkN3cGdMWEtZb3dzMlR4Vjdm?=
 =?utf-8?B?Yk8rcHhSZ0hON3ZxWVJxNjVUbUVyL3JyRUpvd2dvOVExQ21KWkMxQlJjSU9R?=
 =?utf-8?B?dzdneURCYXhBSEdDT0JPeHlyWWRzQjlZWllZQjZ1MEZIL0I3b3QyYXpUaW52?=
 =?utf-8?B?b1MrTU1MYUJGSzNHSzhpSWRFWlJqWVhldjZKeEVTU3UzREc1ZHRIbUZwV05j?=
 =?utf-8?B?TjFKbUJsUWYwenF6TW5SNTJrOW5iMHVTelViRkVzNnJRZmgyWmxmZUE2ZGF1?=
 =?utf-8?B?SmkwV2VVUE8zaWdjQmtpWkR4K1JVOTVpL05tU09GbmxNN2ZSeEMrUnptUXRr?=
 =?utf-8?B?TXpzQ0M2VTRNOEpsZXROZXRxNU02dXEzRHo4RE5pd3JGeHRQSnZiM0xuVWNv?=
 =?utf-8?B?M0dTYkpzY3pBSkVPZzBZZlZBYkFaT05WNThmZ1lheTBGWHhFVmFZUFBTaXoz?=
 =?utf-8?B?REp2ZlY2WkludUx4WHU4c0R6OW9paVhMU0lqZUdjMkRUUEZnVkx5dnBBRURa?=
 =?utf-8?B?MEhhbW9XUWxObXRpMFZFLzIwZk0wRHFFUFpYTnZad3BwdFFiekVtYVgrWW9r?=
 =?utf-8?B?WCttaDJxZWR4UUVsdUNlTVNWS1VEWVB5MWEvTXQ0SGR4WHNhUFo4aTAvZnZL?=
 =?utf-8?B?cGc3Z2cvZnJxVVNLSFpGNVliY2RTaFdWampMMGVnMmlpT2VaN255ZGwrcVZ1?=
 =?utf-8?B?Y1FoSlZ6N2dzSEkyT2pQWk82cWM3SithVzdpb1U1eStiZy9IQmQ4NUE4WDdC?=
 =?utf-8?B?OHp4VkNqZjl2MlJYaFFhbkhEQi9yVmJpbUlIcFFDWWllRmhkMHp6SWM3U2lD?=
 =?utf-8?B?eUxjR0ZyMEtTc0hxU3dkakhkZU90YlFvbnlrR0Fwd0IyTnY0dUlFVlFORnZ4?=
 =?utf-8?B?aUR2cHl2N0lmM1VNb1ZvMSs1NUVKc0ttTWg5L1dVMGZpbWNucFFtL2VxSndF?=
 =?utf-8?B?SGFOQkxQbXJFMEZuMUNBcSs2dmZkUmxubVJQckVwdDlRWkxpdUs4SzdZTXVK?=
 =?utf-8?B?czIrZ08wV0IrekZ5a29QMXFWTjRzcUg4K1M5YkNjd2o4TUsrRjNNbktvWm9G?=
 =?utf-8?B?RXoyWlBweTdzazgvYm5kVXZOckova3FyT2lLYU5KT3gyaWREbXpjdEQ2bEZN?=
 =?utf-8?B?dHRxMGxMNGhnODZMZHRod09KeTVSb0d3eVlGU0x3cVFOZ25kK3M5MHJmeHFk?=
 =?utf-8?B?TGoxL1J2OHBaczgrbEMyRlA5Q3BFWklqT1pzYjJEMkh4bWFzM21ZemE1MEVU?=
 =?utf-8?B?enhDRGR6S0lSOWk0cXRYM3haTlNoaTUvWE9zT2tIald6TTBGOTNjV09WQm9k?=
 =?utf-8?Q?RGRL3V816nFXA0i5uRAtklqeIbU+5Z6S?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05hZXFXT2lwL0xLRURlbkpXVWVoWmJhcXlwNTI3RExjZFdGMytmWkJUZ3k1?=
 =?utf-8?B?UGszWGJHRmpIZlo1dkdMa0Jva0hoWHRUQlZCYmNZRTJoZHZhbmZvNk1TWjUy?=
 =?utf-8?B?TFFGeVRGUFhwbGVuSjFXTUtlODZMdyswWTc0TC9qUTlFeDM1aHdtOE9mYUNJ?=
 =?utf-8?B?RkdzdnFSei9rQWpObVZxOXRlK3BjZmRkaE1GdUFFY3FDbXV1RTdhcmE1ckd0?=
 =?utf-8?B?RktPWFpvV3pSZTh4aXVyeVE3NVd0ZkhqMjdwYndoM2RLR3BRbUFNVGNuZWtH?=
 =?utf-8?B?cWNGanlaNmRTZExYVVg0Q2FqWEtDQnJhT3BTTkRXZ0xMR3Q4RGNWWXlKUkRl?=
 =?utf-8?B?Z0twcXI2SDRkN3l6Tks2UWRhOW4zbk5OVWFjN0xNVE91dXVCQzQ4NzhvVTAz?=
 =?utf-8?B?Y0dVcGxuTzVWdG1vQ09zTEFnYk8xZklaN2FTVFdsUUdEVXZNSzh4Q0lXL3B5?=
 =?utf-8?B?R2lGTkdYZ0NLUEFrSHdDTmFwcFY3WUYxOThZS3lGYkpYd2RaTnNFRUY2ZTdp?=
 =?utf-8?B?NVBWRm9SMitsUldnTGUyOHVZejNxY2N2NHF3YTJnRDgrKzRWaTI4UVBMeklm?=
 =?utf-8?B?aWRNVThLZW9NTUtpSEdEOVBIZnA4TGFaOEtYSkVUOXNUSWFLOFJpYVZWdHdq?=
 =?utf-8?B?bDdxcEdIcCt1WnhPUzNtRUdyc3pFNUk1M1hUS3RycUxlZDFadi90d0RmNFBv?=
 =?utf-8?B?elpDSnNJNkE0VExLcUhNdEwyZklqdFRFQ0FsVmswZ0t0MUk4N2dlTWNKMzNF?=
 =?utf-8?B?b1JEYnZHZk5CbmVTRUF3UWZEVlVDT0FEU3ZGR3lneVNkQlBRSUZnZEx5Y2Zz?=
 =?utf-8?B?cVNxRGhDYWZsdUFWVURlRkJGbG1VeGdRNXdSRndKQnQxSnlMS0pCTzRTcmVF?=
 =?utf-8?B?ZU9XeW1kOGJwMzlyaCthMVNlZDB3cUpPOGJBSkE1cnZGT2hITzJNM0JhcmEw?=
 =?utf-8?B?TTh0VGxPRjFReGV6SjgzcVlSQzVaQTdqV0c1NENSOXhKbUNEUVJIVjJBUWtL?=
 =?utf-8?B?MDIyNXN6dXNJb2JJaWQ2bURRNFJ6UWI3WXJUSjhMOGxIRTVTYXUrT1RKMDMx?=
 =?utf-8?B?Z1pFNmo2OHl0Mi85ZyszclUyY09JN0lRSzRVWjFvNmN6OVVvTnU4T2xGTjUv?=
 =?utf-8?B?aEhQMVl3N3FFSFQwR3EwY2t4UVJMd2pyQ0w1NnhUOFIrMWZ5RmRGVjJlYTNk?=
 =?utf-8?B?WHBwMWJKemZOeHdyanJ1WHMvU1pENjlXNE5yZVM0clBQRFRyS2g2aGdVejdC?=
 =?utf-8?B?ZFB3R3RkRDBSUW5rakdTZlU0cFhRRGVIblVXNFk3NS8wY1RJbWJsWEgrZGE5?=
 =?utf-8?B?TDI5WjRGeTN5WE4zL1o1TGZXMG9mNXhEdmFiV0lsSllYRmtMZ3hWOENzVzQz?=
 =?utf-8?B?ZzJ6Y3RTZ2VWZmdxQmtOOUF4U2RKdE0vc2M0Tkkvcy9oeERTT2FWdzg4UVFQ?=
 =?utf-8?B?T0FmTUdUZW14UDdLUi84KzJsSENFOE5IanpUbFZoZXdYWHhudVJUdXJZMGFx?=
 =?utf-8?B?ZDBzVUVPN0xySGRFUS9OeXNjY29Ya1ErNnkwY1lsV1AvcW5wVWUrRGlVMzVN?=
 =?utf-8?B?RGlzQnJnUWd0Q2pXSVBjZ2VTd082c1IyQlYvTy9pR2cyRVdsaGNVUDFLNkNX?=
 =?utf-8?B?c2NWMmR1L3BFcVBzSno3Umx2U1c0aHZIaWRlQzRGVEREeVRYQkIwWGNlQVlj?=
 =?utf-8?B?SmNaQ1lGblNTR3VDTnpzY0ptVHVJdjZzTlgrbWtYdWNXUGd1ZG8yQ29MVGJG?=
 =?utf-8?B?YjBRbkxtcWJVcmttVUVPcE9SSk1RN0I0WFJsNWNpSGFSaWsxQ1Ywcm5kYVor?=
 =?utf-8?B?R2E4Q0htSi9yOVVTOTlWbVRzNlJKQjRzMjErbVovL08rVkRndDFEaVJpT0xt?=
 =?utf-8?B?K01CVjhxNG9GSy9zK2Zjc0UwcUMxL1dORUpNb0t1TVg0SGpEWnZuMHR5dTNM?=
 =?utf-8?B?d09qY3oydkh5Q1dTMU9sZEZzR3lsOEVoQ2o5RExaWFZ3akg5MDBXc0IzbW4r?=
 =?utf-8?B?TWVrK0JHNk4vd25YYktsR2o1RUFqSEZ4WGVDdFVsYW50cXNRRG1LYUVpb0U2?=
 =?utf-8?B?Q2t0ZG1BSFlnSnEzZHRDWHpDYkNtOEo0STJnd05IQ2xON2RGay8xTVNoTDBa?=
 =?utf-8?Q?q4f38eM6T19o4w49oJO8XxdoC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0575f510-2395-402e-54c4-08dd4fef12c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 07:37:18.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC+3puIHttsDfngaQJK03H9dQ0/b5gWMeaHNn53A2JO4tHUTcQTvdO0o6rA8v9A2M+8p3HY8jsw57x9JW2risw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFsuLi5dDQo+
ICtzdGF0aWMgYm9vbCBzbWNhX3Nob3VsZF9sb2dfcG9sbF9lcnJvcihlbnVtIG1jcF9mbGFncyBm
bGFncywgc3RydWN0DQo+ICttY2VfaHdfZXJyICplcnIpIHsNCj4gKwlzdHJ1Y3QgbWNlICptID0g
JmVyci0+bTsNCj4gKw0KPiArCS8qDQo+ICsJICogSWYgdGhpcyBpcyBhIGRlZmVycmVkIGVycm9y
IGZvdW5kIGluIE1DQV9TVEFUVVMsIHRoZW4gY2xlYXINCj4gKwkgKiB0aGUgcmVkdW5kYW50IGRh
dGEgZnJvbSB0aGUgTUNBX0RFU1RBVCByZWdpc3Rlci4NCj4gKwkgKi8NCj4gKwlpZiAobS0+c3Rh
dHVzICYgTUNJX1NUQVRVU19WQUwpIHsNCj4gKwkJaWYgKG0tPnN0YXR1cyAmIE1DSV9TVEFUVVNf
REVGRVJSRUQpDQo+ICsJCQltY2Vfd3Jtc3JsKE1TUl9BTUQ2NF9TTUNBX01DeF9ERVNUQVQobS0N
Cj4gPmJhbmspLCAwKTsNCj4gKw0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKwl9DQo+ICsNCj4gKwkv
Kg0KPiArCSAqIElmIHRoZSBNQ0FfREVTVEFUIHJlZ2lzdGVyIGhhcyB2YWxpZCBkYXRhLCB0aGVu
IHVzZQ0KPiArCSAqIGl0IGFzIHRoZSBzdGF0dXMgcmVnaXN0ZXIuDQo+ICsJICovDQo+ICsJbS0+
c3RhdHVzID0gbWNlX3JkbXNybChNU1JfQU1ENjRfU01DQV9NQ3hfREVTVEFUKG0tDQo+ID5iYW5r
KSk7DQo+ICsNCj4gKwlpZiAoIShtLT5zdGF0dXMgJiBNQ0lfU1RBVFVTX1ZBTCkpDQo+ICsJCXJl
dHVybiBmYWxzZTsNCj4gKw0KPiArCS8qDQo+ICsJICogR2F0aGVyIGFsbCByZWxldmFudCBkYXRh
IG5vdyBhbmQgbG9nIHRoZSByZWNvcmQgYmVmb3JlIGNsZWFyaW5nDQo+ICsJICogdGhlIGRlZmVy
cmVkIHN0YXR1cyByZWdpc3Rlci4gVGhpcyBhdm9pZHMgbmVlZGluZyB0byBnbyBiYWNrIHRvDQo+
ICsJICogdGhlIHBvbGxpbmcgZnVuY3Rpb24gZm9yIHRoZXNlIGFjdGlvbnMuDQo+ICsJICovDQo+
ICsJbWNlX3JlYWRfYXV4KGVyciwgbS0+YmFuayk7DQo+ICsNCj4gKwlpZiAobS0+c3RhdHVzICYg
TUNJX1NUQVRVU19BRERSVikNCj4gKwkJbS0+YWRkciA9DQo+IG1jZV9yZG1zcmwoTVNSX0FNRDY0
X1NNQ0FfTUN4X0RFQUREUihtLT5iYW5rKSk7DQo+ICsNCj4gKwlzbWNhX2V4dHJhY3RfZXJyX2Fk
ZHIobSk7DQo+ICsJbS0+c2V2ZXJpdHkgPSBtY2Vfc2V2ZXJpdHkobSwgTlVMTCwgTlVMTCwgZmFs
c2UpOw0KPiArDQoNCklzIHRoZSBmb2xsb3dpbmcgY2hlY2sgaW4gbWFjaGluZV9jaGVja19wb2xs
KCkgbmVlZGVkIGJlZm9yZSANCnF1ZXVpbmcvbG9nZ2luZyBBTUQncyBkZWZlcnJlZCBlcnJvcj8N
Cg0KICAgICAgIGlmIChtY2FfY2ZnLmRvbnRfbG9nX2NlICYmICFtY2VfdXNhYmxlX2FkZHJlc3Mo
bSkpDQogICAgICAgICAgICAgLy9KdXN0IGNsZWFyIE1DQV9TVEFUVVMsIGJ1dCBub3QgcXVldWUv
bG9nIGVycm9ycy4NCg0KPiArCWlmIChmbGFncyAmIE1DUF9RVUVVRV9MT0cpDQo+ICsJCW1jZV9n
ZW5fcG9vbF9hZGQoZXJyKTsNCj4gKwllbHNlDQo+ICsJCW1jZV9sb2coZXJyKTsNCj4gKw0KPiAr
CW1jZV93cm1zcmwoTVNSX0FNRDY0X1NNQ0FfTUN4X0RFU1RBVChtLT5iYW5rKSwgMCk7DQo+ICsJ
cmV0dXJuIGZhbHNlOw0KPiArfQ0KWy4uLl0NCg==

