Return-Path: <linux-edac+bounces-5637-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B6D1B589
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 22:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9165305B595
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38173321420;
	Tue, 13 Jan 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/HQbjmy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F1318BBD;
	Tue, 13 Jan 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338315; cv=fail; b=HvhruLux26qpoFMWN+UCzz2kAgp0Qy1JQ58Bsw009nIp4BjD65vUWBhYp1MubBW3FBjc9mDBJm/vqY8aDZ8ZqYqLYSsQJde8ntaCTgRpS1Ed5j/lcOWZbPB10IuW48WPG8Uaidt/zLN+GrpiMHXAb5QNT2NGXFB/wfBsJcvk1RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338315; c=relaxed/simple;
	bh=/HmLegKngDLSNg/xwoLywrASo8eMBUs0m1jyMR2hmAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKCKgySquuV4Q4hFapIskl/k8xVI2f48y0ESLQDb1TtP9aXxfZtqE0jXYcKvPSfbSXnjOL2mznn6KouBBSG15ZoIAByu5TZi1al30gQ/tjp7EwlciVgXMGDISI242cMLjVxqYD6skWNihFDC1tbWv1DC1TS0mO+rYGp6xTsa20U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/HQbjmy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768338313; x=1799874313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/HmLegKngDLSNg/xwoLywrASo8eMBUs0m1jyMR2hmAM=;
  b=i/HQbjmyFM0xCcOKWb9CcscgK5zAdntrxCbA3nOIduSwVHs3T2pM145j
   tjTNK+OtiOeshd/5tVFgR1StnHaWW7G74DqgZaq9GJ7gvlVcEuxIpTU6E
   oaA7QOZo5iH8K9wrYz1MLguBDJbDICiD+EleQW2G7FSKC46kSVaMnZVv9
   aghBodjb5rdFEofzOTgjl5+YIgNHmmTCMmhoyKbLn9vMr6acZAczw+EFx
   xqQFG8wmP1rQhQXD56OEDfgjtMTaEkIwJfzUrhTQbLM/ZzpDdyV1f/m6E
   ZXfl4za7Yaa6bS3+LDVulQkovMxS4KAiQN5UCV26nZg1vC0Z7l33mE1g+
   Q==;
X-CSE-ConnectionGUID: nMaQ627KQ3aEhYZO1nV0hg==
X-CSE-MsgGUID: uMiPXsYFQl2rtqTgETFLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69715394"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69715394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:05:13 -0800
X-CSE-ConnectionGUID: RuRws0I1SgyPq1JnfSpFoQ==
X-CSE-MsgGUID: gWk6BU+uTpms0dG3aA/0eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="242015538"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:05:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 13:05:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 13:05:12 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 13:05:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtGQhd3fYBUSbrBquhiS6RCwuq1f8bi76XRywri9bOoQsAjJpJQoGEuJZHI8fPBCzsX1fdcet6f65CF2tAdzaEA+fWNCOEqhtiwETFsFVh4NcIdKwUmPhfe+/A1ahHtfCGFSf2iF5ALXVn2XhQIi8VCK/CMPm7Btl6bcK61CGW/VkrZgK2X5gp6FNdNE5ZMCIKhbqcPnxhDpdIvTHn/rH3K99QhNPvjHprSBeeyU4ttdlrwhTKW7po147ImdZ4bOleFAAY2VXYEfmc/VkC+plHcLGQot0XC290MJeVc5iVNdPrpIEEGPZBF/nFfpIB6tZGYCb/tkI64yfK+eA6BezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HmLegKngDLSNg/xwoLywrASo8eMBUs0m1jyMR2hmAM=;
 b=ajp6g2N58vabYuqGaxkFyCIgNpZvu/PbpJlVHoldM3Ix0ZcmqjZRy6i3paQPCUWT3r+nlrQ0xwc9qO+mKYLeoqIdkbBRjcOJtlgIqlKs4gOzO8Gc5foiLw2MehCw3svGyh97TxbbWcPbK0LwhWT4t8hy1tUOw5y36yu7IUz/+QDWO3rNK0r8StcPOOYsNL/RGj2C8L1gAQrkVRfPkxTSrW+B9qFe7VDCvV+/Thcp/Qdxst/C9+sumkMbUe2ATNm/5/hCtc916kjw223ZZnK+ySFqdKOxNXQzJGkgcUmR+rSEdRMM4OVhckbHitYeOTi7Wugj80eBU7Nmj4panWBLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 21:05:09 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 21:05:02 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Li, Rongqing" <lirongqing@baidu.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7ZdIFJl?=
 =?utf-8?B?OiBbUEFUQ0hdIHg4Ni9tY2U6IEZpeCB0aW1lciBpbnRlcnZhbCBhZGp1c3Rt?=
 =?utf-8?Q?ent_after_logging_a_MCE_event?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQ?=
 =?utf-8?B?QVRDSF0geDg2L21jZTogRml4IHRpbWVyIGludGVydmFsIGFkanVzdG1lbnQg?=
 =?utf-8?Q?after_logging_a_MCE_event?=
Thread-Index: AQHcg5123MgPXG+o9kCRbfhvENq45bVOO4iAgAALDoCAAAQuAIAACTCAgAGJHICAAC5XAIAAAzyAgABVQpCAADMrAIAAAZsA
Date: Tue, 13 Jan 2026 21:05:01 +0000
Message-ID: <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
In-Reply-To: <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB5826:EE_
x-ms-office365-filtering-correlation-id: 057c3a99-8340-44e5-aff8-08de52e76af5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bWFEOVIvVlpCMGhGNS80ZFVoZEhVUEpkMVYvdFlubTlRTHVJOW0yUm5lNVpP?=
 =?utf-8?B?T1U3L1NkZWJFM04zSTZPQ3RDUzVPWU0yT05xR3VXOENZZjVZT0prOWNGcjA0?=
 =?utf-8?B?YlpyRDRtTzltTWZrN3JyTCtJMU1FVFUvUElON0lZVllVV3ZBNUgwbW5SYTdD?=
 =?utf-8?B?b01XSmtEUnF4WndKUkM0WUJQR1NqdEdWMVZqT1p1YWR3ZTlOQmE5TmhML2lz?=
 =?utf-8?B?T1dRZzJIOWdhbkIzRy83am9McTc5cEpJM0hvYjlMd29sRFNzNnFpWTNXckhO?=
 =?utf-8?B?WXR5ZTNnOFNKQTlob2FDOGNhN1BvNXdteFg3bjJJS0NCVFBQcTVzMjFSSzRN?=
 =?utf-8?B?VGJrTlNmYngvNnZlaDJ4QUJNbjJ3bndGMHRybmpaK1lKdklyS3BVd0pHMWRs?=
 =?utf-8?B?QlhaZjFlVzZtVXNiQ1BqWnVJb0t2UkxYbmNyTUF0RXJ2QTR3ZWVHdmp5TC96?=
 =?utf-8?B?dTBIanhyU3IzcWxlSlVvL0hSalAwWnZtNmNtSGZpdk0zV20yd2pPSmRmMzNy?=
 =?utf-8?B?VS9CZ3pxakZQbldKWFBpZThodzZpWlhDMnRTdW1yR3ozWG54Rzh2bUxaTCtQ?=
 =?utf-8?B?VTNRTWxoVGpSSm5zQmdERTJDTHMyYkorL2pxZWxSckNQZHI3WXBydDRpSWhI?=
 =?utf-8?B?R1ZwQng4QnlvRVFoQXlzVktrdHdYOGlCR2RHY3dkemthRW9RN0I2SWd1SWcr?=
 =?utf-8?B?aThDWCtHTjRTTm5sQktJV2ZNMkhkSG9wcURJZFhmN1M0a2FMem1XbE8yU1VL?=
 =?utf-8?B?WDVuUTNJa2F4YVEwK2tZNUdiamdvQnkycXR4cVpxNkdxT1RXelErNFhvbm5K?=
 =?utf-8?B?STVJU20vTXYwN3UrMkZKSzlyOXVUd1ZSbisweDZKTVpRSTdBOHRoclRZVkdk?=
 =?utf-8?B?dzhVL3V3S0pmZHlVMkl3bnNESzhISGRkNzNtSnhodmhMSEY3ZkZwN29VblM0?=
 =?utf-8?B?NXp4Y1Z4UFBTTVp4M01FZlRBbVl0MUdQYitoaWx4bmdVQXE5bmV2aXY1cWRm?=
 =?utf-8?B?c3luT2FKYk5SOWZUN1pNdVU5S01CeXFBNCtTbGo5aXQ2ZC9HeHVXWnNNRHlS?=
 =?utf-8?B?VWd3MWxyVk1DUlNRWHhjRkxmNDY2ZDJYdUVnNU0xemNyUEZzR1JJQ3FNdk9D?=
 =?utf-8?B?cC9DWG1iWCs2ZUJXY1RKaGk4bC9COXpLaEJzWmQ2cG1wVkNSdDBXQnlEdFRi?=
 =?utf-8?B?WUd6bTBwYzdLUlhJK09ZWGs5RGxuVHR4QVlkUkxZNjZOSW4wTDIwbEZxOEhj?=
 =?utf-8?B?bEVUVUZ4RG4vL2VXR2djOWZZY0pvRThqQVFtWFFwTUwzNnpTTHZ4bndYL3Jp?=
 =?utf-8?B?UTlhUHpUQWZXdGRBaWZsRjdoV1JqQWJabUFWdmhNZFd0NEg4WjllejUvMit2?=
 =?utf-8?B?L3FxSGp6TlJUK3p1ZVF2dlpmR1NVWmtEajRBQWNqeVRuazRURERwRVNRY3hp?=
 =?utf-8?B?QzRzNmlVSUxLb1gwaXJoYmk2bzlQQ3BCaHdOWFJpY21jUUg0M0g4TGNieDBR?=
 =?utf-8?B?bS9wQjZwZzR0bGpGSGtJWDFXS0NVeHBrcXlmYjh4cU9OSUlzdDc1dForS01Y?=
 =?utf-8?B?MWZaTjNwK0h1Rm9malp3K3NKN2hhczN1ZExZYlR5L0ltYURMeU9lcTRPbmZT?=
 =?utf-8?B?UzBOWSthK3JFaDhrbFB0ZEx0UDNuYmZlbzFyRUttZ2J4SGgyWFIydnEwTzZB?=
 =?utf-8?B?UFk1SzBFQmMyT2dwT28rUFgzODc2OTJ4cXRoa2Y4VGV6WlBwSzJoaFJ5djBG?=
 =?utf-8?B?OHNxSHFiQlpNVWp5cU1OTEYvaTA4VVAvWGlaNVRjVmxqZHhrR2ZBWVRHNFhB?=
 =?utf-8?B?ZW1oR1pvY2xPanY5TndSb1l6U1Z4MVpNZUR1UW1pYWRoOEdaVks5L29XLzRj?=
 =?utf-8?B?RGgxeURzZm1zMzJXY2U4MHBQT2VtVW9wMUxJcktBaW5ZUUtNemgzT3JSUU1V?=
 =?utf-8?B?RmRxQWJ4Rm82VWoxRXlDZ2VtdlliM0dnSDZBcERvWHRtV1o2UEJMZGRkcWxB?=
 =?utf-8?B?N2JycG94UHo5MDJKY1VDWFpvZmdhbzNuV0U3SGRpS1plT09kMXppUUtPd3dD?=
 =?utf-8?Q?uOdOPA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJYSE5xcW1hYVBFSzYwL0cyUTRsVEtDOGt0cnpwYmFlMi9zTlJoSHRVNnFl?=
 =?utf-8?B?QWZMSnUwRW00Y2pkWkRmcW1Ia1VyS0NReXc0azMwenNLSGprTU1ENGRtTTg5?=
 =?utf-8?B?UG9MWUppdndpSDQ2RHdMeHZLMVRmcjZmRlhmeUxBOTRjNXVhYkRFTmpRT0dC?=
 =?utf-8?B?OXMxOWZpZ3FUUzdYTWV5WTR5cFZyK1Y4N2NjWkRSOXEyWkhQUU1FZXpxYlRC?=
 =?utf-8?B?Q1FKeHVOZUI5RFoyQWFIaGUvQktYb3dsdGIybEVoUEM5MStRZFE4WTlydjBB?=
 =?utf-8?B?aWdhd3VOUW54V1AxUDhLcCs0SEQvUmlDeUZuN1Q5emJlZ3o4bC80Q2YybVA0?=
 =?utf-8?B?anljbldYam1adnZnVmhQajhxZFNiS0lSNzFFckxYbk5lSCtQTXlqR3oyRnB3?=
 =?utf-8?B?UW53dVFkOVZOTHlUelNncWlNWXVDSmd0cFBPSkxJeHJOQ2FrTk5qOGtEVWdu?=
 =?utf-8?B?WnNlb0h5blBUTE5lS2tjSDBsV2FFaXA3cExpM1VsSG1tTG5qYUtKaHgxRjRN?=
 =?utf-8?B?V1d4Ymw0K09XYUl6bHRZcWtnTVREeHlHMnVhSkVWRDlNeE9sYzdDb3NrR3Ex?=
 =?utf-8?B?UDU5cE1QdXFHYU5abzZkV0wyMkJQeGVoWWFkbDFrcDQrNDVvWjdxU1R0Vng4?=
 =?utf-8?B?ZFd1eDk5eFpHOVNiS1lkR2xRODZNZk1HeGtPUVZLWjhuS1ZsWkJZMXlYa1VW?=
 =?utf-8?B?N2J2TmJsSTNLVW1HcUp2bDZPT2tub0VIdnlGUjNFR1I5dzJpSTkzeFdTdTl4?=
 =?utf-8?B?bERDeGZPVWRFam1ReUpEdi90aGlGSGVHNHZXdXN4TmJzR09GdjYwV0Z3SjVW?=
 =?utf-8?B?RExqVFdjMGRTTnh6b2x5S2llRzJTTjNXZGEvUUF2bjI2emhoWmc2MWUvS0pC?=
 =?utf-8?B?cjlsRVZNYWhTUTJqOFhsUlNjZHZqaEJLdUE3V3hHcXlvbU5sMUJwbTlSN1Q4?=
 =?utf-8?B?N2kvUW4rRWY1RjczQTB2K0s0LzBrYWcvRi9hK0FjaFdHZEtZRUc3NG1hbyt0?=
 =?utf-8?B?R0tCRlRrRUxKVlB2NUNlSnlUaW1tOEtIZXN3bHlPYWpNSHJUQ1VJK3JON3dp?=
 =?utf-8?B?c092aTZPWXlhS01JZ3prZzJrVmZCRzhXVk9XQm1iZS84TGFFNVgrVnNZU3dp?=
 =?utf-8?B?RmZkWUNrL09YUW4vclh0TTVJRU5HRWtVM0tvS3F6NGRvZjg5VndkVkVnS0s3?=
 =?utf-8?B?c0tpYUNZL2NZd0ZUcHM4bVlIL1JRMkYxTjhVY0Qzc2dWTnBENi80QXA2RVdS?=
 =?utf-8?B?V0t2Z2NZdmJVblZhWTRFR0wyWXUzajhVcXB4VWhpSEJObGc1a0xuRHljSG1j?=
 =?utf-8?B?L0RKOTYvdjhLL005aDlhMFJrWU5pRWhFM3hFaGhlODRxSkt3Q0RQSFI5Smhi?=
 =?utf-8?B?eDF2bi95M25QVnlHeDFuZklNbEdzT00vZ1o1TUh3NVY5WmtqN2IrVDEvcTZO?=
 =?utf-8?B?Z1BsRnlRL0pyUm9YMHBLZktuMUM2R3R2aHZLb040K2dVSU4yR0YyZzhyYjND?=
 =?utf-8?B?QWtBWW9MUE5vWllDWktZY2Z6bGdBaWhpWWFFb2lKVUkrdXlxeWdkU3VoNWdh?=
 =?utf-8?B?eFRHTVFIZGVtOGRXQjFZZ3E1dEJMVjFwSHJScmZiMlBXT3VHYmxOZ3V3b3NP?=
 =?utf-8?B?Wmc2enZMdnk3L2kzTDYvNzFaM29hRm5JWm1xRGFkUTJLT3hzUzRucHQ0UVlL?=
 =?utf-8?B?T0o0bytSamZyQjE5cjFMZFcyTlFFbUYzR1lWbGRac1dEU3B2cEl0UHNqdlg5?=
 =?utf-8?B?WjlXM2FQVTE4aUFDNm0xT1NaMDc0OXZha2VHc0h2MUkyRzlBcmV1YmtxZXZW?=
 =?utf-8?B?aStZVUhPekhZdTE1SlNCcXFyZ2ptUjdhb1g4ZmtRcjlPb2RNMVhFcUM5dFpt?=
 =?utf-8?B?Tk5KZGw1SGlqSlZ4WUNOODJkTXBFK2FHeGl2TzVlcTdDTkcxSW9paTR1cjBa?=
 =?utf-8?B?eTdwTWMyN3NzNy9rQTVXS3dQOEhhTzZsRGFXMDJsMDhSMzk1b1BlbHZncVR4?=
 =?utf-8?B?MG5iSFZmVW1DWkFCUVlZUm82b3RjUnl0dS91MmtydTdObTRlVU9NMjlwV2Nr?=
 =?utf-8?B?alhyRnhmQ0tTbDY2MGV4N1BtcndLcmNROHFTYUtYSkl0VmhPcHg4RXNsdkZz?=
 =?utf-8?B?WldxaGVCL2xMeFdEOFF2NUZuMzQwUjdmMkZIWFpxNlFtVy90Y3lqRHFxNENF?=
 =?utf-8?B?T2UxYi9pTktIc1dSakw0SWdLaFJ6dGg1ZjZBNVRqdi9OQVVMRTNCdjlxWURl?=
 =?utf-8?B?L0U1SGw1NWJOQ1o0cE1xd21VUjA3V1FsV0s0RUZwRVZ2VkpSOXVUQVBMR2lq?=
 =?utf-8?Q?Q91YPpgPUhvPgsziUH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 057c3a99-8340-44e5-aff8-08de52e76af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 21:05:01.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SthfIQl88DuhryNiWjVPQQcrK0a+K8/XiNDkc75TQ11OcFBadxoJVq7+eWSyPIQBjdd/HayGOANXLgraOLwKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com

Pj4gJCBkbWVzZyB8IGdyZXAgJ01hY2hpbmUgQ2hlY2sgRXZlbnQ6Jw0KPg0KPiBEaWQgeW91IHNl
ZSB0aGUgIk1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZFxuIiBwcmludCBmcm9tIG1jZV9ub3Rp
ZnlfaXJxKCkgaW4NCj4gZG1lc2cgdG9vPw0KDQpZZXMuICBJIHVzZWQgdGhlIG90aGVyIGdyZXAg
cGF0dGVybiB0byBzZWUgZGV0YWlsIG9mIHdoaWNoIENQVS9iYW5rIGxvZ2dlZCB0aGUgZXJyb3Iu
DQpTYW1lIHBhdHRlcm4gb2YgdGltZXN0YW1wcyBzaG93cyB1cCB3aXRoIHRoaXMgZ3JlcCB0b28u
DQoNCiQgZG1lc2cgfCBncmVwICdNYWNoaW5lIGNoZWNrIGV2ZW50cyBsb2dnZWQnDQpbICA2NjIu
NTc0Mzc2XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dl
ZA0KWyAgNjYyLjY2OTI3NF0gbWNlOiBbSGFyZHdhcmUgRXJyb3JdOiBNYWNoaW5lIGNoZWNrIGV2
ZW50cyBsb2dnZWQNClsgIDk5MC4yMjQ5MThdIG1jZTogW0hhcmR3YXJlIEVycm9yXTogTWFjaGlu
ZSBjaGVjayBldmVudHMgbG9nZ2VkDQpbICA5OTAuMzE5Nzg4XSBtY2U6IFtIYXJkd2FyZSBFcnJv
cl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZA0KWyAxMzE3Ljg3NTk5M10gbWNlOiBbSGFy
ZHdhcmUgRXJyb3JdOiBNYWNoaW5lIGNoZWNrIGV2ZW50cyBsb2dnZWQNClsgMTMxNy45NzU0MDhd
IG1jZTogW0hhcmR3YXJlIEVycm9yXTogTWFjaGluZSBjaGVjayBldmVudHMgbG9nZ2VkDQpbIDE2
NDUuNTI3MTkwXSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxv
Z2dlZA0KWyAxNjQ1LjYyNzA1OF0gbWNlOiBbSGFyZHdhcmUgRXJyb3JdOiBNYWNoaW5lIGNoZWNr
IGV2ZW50cyBsb2dnZWQNClsgMTk3My4xNzg1NjBdIG1jZTogW0hhcmR3YXJlIEVycm9yXTogTWFj
aGluZSBjaGVjayBldmVudHMgbG9nZ2VkDQpbIDE5NzMuMjc3OTA4XSBtY2U6IFtIYXJkd2FyZSBF
cnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZA0KWyA3ODcwLjkwMjQ0NF0gbWNlOiBb
SGFyZHdhcmUgRXJyb3JdOiBNYWNoaW5lIGNoZWNrIGV2ZW50cyBsb2dnZWQNClsgODE5OC41NTMz
NjRdIG1jZTogW0hhcmR3YXJlIEVycm9yXTogTWFjaGluZSBjaGVjayBldmVudHMgbG9nZ2VkDQoN
Ci1Ub255DQo=

