Return-Path: <linux-edac+bounces-1176-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31598FA858
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 04:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2F1C22975
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB913D2AC;
	Tue,  4 Jun 2024 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IATcrZLn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18138B;
	Tue,  4 Jun 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468789; cv=fail; b=CLk7jE0kQ00sgdw6iH0KSZ000X5mlv0tnWJmjui15/k0YQ2zumaI2bSAu1V4prP/p92yw23Z1sqLc2pMUDOfd9D3E1MWMn4s9TU5GL/vZ0logOnbxHqBT5PcKv9KMFmVgubKOWrdGucp8YulA/Mkp5JAoCTZaPP8xms7bOupJuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468789; c=relaxed/simple;
	bh=Jritx93eumd7vWPGY7v0DuLasE4ccRgDUw0U3sgESUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ik6Y7PnxR3aqiSeT0lKnJrKUdi1Qb3bik2GtvNyxEu27fXP6swYJier7GagyJmvLiftpbGWIXdbfl2POrgH3ACGktHODp8BBIC2hgNEdJdSVG3L0UyDziFq7czCzWcUTGJ9RYvkzIJw3prtwncP0LVo+Qn131ajBH5w4f+MXqa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IATcrZLn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717468787; x=1749004787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jritx93eumd7vWPGY7v0DuLasE4ccRgDUw0U3sgESUQ=;
  b=IATcrZLn0FSEBJBQxEaNdVb9B0NkredBnWx5CNi4ij6Kuoc903g0KoFq
   bH9tmJ0s8L2LiBYGJGLpTj1u9eVneXR73psDyjLotWxJ3kJ2lOIWqrY+k
   B1CxV+88oufROZCVG+eZOx0omJDNiNzvUiwH/RZbyQvaArWIIcFz2HuFm
   tyCOajdDLXQhyeyliAOoEZAzuUJZlZizDFu9Dco3DUT/X8YxAimu/KtRs
   m0Krytnhkp+7EKf04aVgsIqu9n7VUtbWZiVg3sIATXTvfLwjZcXNbCtr9
   4psLL3aix6nJXm9jKO6FFMbDnJTjLl+yXmqZmJ2bA+MS836a2lvcmoMT9
   g==;
X-CSE-ConnectionGUID: QPqZ+5quRbqyL7Q9rG56Uw==
X-CSE-MsgGUID: IRIeiHM3TumBOKIUKrxgvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14107403"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14107403"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 19:39:47 -0700
X-CSE-ConnectionGUID: wCUjrR4rTYi61SK7beoTvQ==
X-CSE-MsgGUID: vcw39u5HTJeF7PNtrj7goQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37060800"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 19:39:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:39:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:39:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 19:39:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 19:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb2D5FoZZl7EnqA7i7MKl0JoH1osXlcQ+2z95YqCekiIPOeXvFhdQa8XShK/BaHM8rLzTbPXXfHiRS3PHmGccu1m0I5oZxWtAhJ9U5zzyvj0VDSd1ntrP0T3lgiu66weZgsvmEsr0T38dW/QbDsmlX/xp3fnf8j94NmNEpYvEPB5WLdrrqA6cZqOAsp4+XB3X+F0mSObJIw+3SIcM0avwsHHFdPLd2h+HK6S9E7Zm5rbSdF6b9e2a0OckCZViePck1numrWrPHlVe1cUaf9Hlg0pP9xmc/Sr5BbCBnPELwrWCkLFGuUz6hCoTKutEutmnaJCudh5IwII0LTHde5TWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jritx93eumd7vWPGY7v0DuLasE4ccRgDUw0U3sgESUQ=;
 b=LfkwqUa2k9aEScSa0ojVTRxizxu32L0gdIYXBdxFRiKp8Si+PiAWdy77eW2K5IugYX4qxddCuEUvvbAwxkIjJVdudobraaMKkFTeOAFyag7kZwLIdQRqUwn528KB7Ow5YPGvNq+tL//Kc1UKQXB/6q+CiflSOpI5dhZjHHrDs2zYN+p2LG8EGvJS+3/NA/zidjKEqxb6eUAvUQzZChYxRDc80mZLqWYqUd979BVZ6o9ljnCreiE6h5O3UxQgQxz2+nuhhsh+AqKRgPSuchWrOeZ1rsonSecog2sFqeaFTVhXFUPtfwnRpO5QjLcoI68IuHrewpyAVa9WjqLniYIhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 02:39:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:39:43 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Luck,
 Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] EDAC/igen6: Convert PCIBIOS_* return codes to errnos
Thread-Topic: [PATCH 2/2] EDAC/igen6: Convert PCIBIOS_* return codes to errnos
Thread-Index: AQHasDj9NzY4hNXIc0CVPgEpZVIRzLG27vkg
Date: Tue, 4 Jun 2024 02:39:42 +0000
Message-ID: <CY8PR11MB7134B091C68A84EFD5CBD9ED89F82@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240527132236.13875-1-ilpo.jarvinen@linux.intel.com>
 <20240527132236.13875-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240527132236.13875-2-ilpo.jarvinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6953:EE_
x-ms-office365-filtering-correlation-id: b8861986-1034-4721-9072-08dc843f96f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YkR6amFJZHNTTEFUM0dLTFBOeUtzM05vcXBIdG5MTVlCaUg5SVYwT0JML3J0?=
 =?utf-8?B?VXVmYm4zeFhYeXRILytaQUlDWGJrNkFpc1pHSmFRanA4ZmtkbHhMTUVoM3FK?=
 =?utf-8?B?S05FdWdBbFByN3dEaFVIUlI5Sk5qZFkyN3h5RWE0UUgveVBNelNUVmJQR0pp?=
 =?utf-8?B?aGp5QmpIYVMrN2JEMGsxbmpzbEt6NmUrQXpvSVNmdTh2Z25ZUGo1MnNpZWdr?=
 =?utf-8?B?Z2loQ1ZPWUpoM2ZSNS9QNUp1MzcwWUxZUy9Kd2Q5bnhHbTVLKzNQV2gwVXBw?=
 =?utf-8?B?Wm5sZHR1TEw2OEpLM2NvSlJyaG5LUjgxc2ZoS0hjSlUwbzRvYmVGcFpWRENz?=
 =?utf-8?B?dFQzK3F1Nzl1aXIzTWVObHpETVVXT2hsMktSbFRjQlVGV3o3M3B2YXlaSDRU?=
 =?utf-8?B?YTc4eGVCUTdHeHk3NFcrYzNURVZqZ1l3ajFHUGpGa3NGNDRONzRRNGlSdjlQ?=
 =?utf-8?B?WkFrT3Rpa1ZUL1lPTyszNkk1a1NOWjdqNkRCd3Z2d3M4NkxqVGY2aXl6RWRG?=
 =?utf-8?B?VlJBQlFuYTZkRWtvUFBNaElhUHloeXVYVURDbEZXNElmZWoxQnYrQXdQVFdU?=
 =?utf-8?B?QWt2U3g1YjNRMzQvcGQzR2ZOZ1RZWjhwK3NkSExNOEl4MnZ6VkJTTElNM1g4?=
 =?utf-8?B?WjJFV1RvNEhpWi9vaGZoalZYY00ySTV1RThTcmhjcERyek9Od2NRM0ZvYW1l?=
 =?utf-8?B?RjNEYzB2eXFZTU1NLzZhb2ZHY2NKR3Fwa2pwWktWZ25HcmlXNUZjUnNPWFor?=
 =?utf-8?B?eTROZllCT1lNakZub2FDbFA1MHFSb040UVYrelpENDl4SDN1SytmbDZFZXAv?=
 =?utf-8?B?YW14UnFOSUZZV0VCK1FDc2FXUUJWa3d3UkZXelY2UVNocCtxMkQ0N1VwMHFC?=
 =?utf-8?B?SWd1Znpybi9BczI5YW5qcUE3WWJoSTNEOUx2elB4ai9ma0hJZWRLSjlaMDRX?=
 =?utf-8?B?ZXQxUTVKSG14bVJhWWpCRTNDR0owUnVzVVJkK2VrajlzN0ZDUXJQamZLSllx?=
 =?utf-8?B?VHh4blVaQ0M1blovM29EMnZpMVNWWFh0SG5WMU8rWlRDTUxkelZtV1BBVjRl?=
 =?utf-8?B?TTduRDljVnd0c1JhZnZNYXBiaDUyTmxNQ2dTOG4xQmtSMGFKZGl3dGJSVWtU?=
 =?utf-8?B?LzZTbXNMaDlNS3p2ZGpGZjNEd3k1SnJpOXQrSmpHeElQb3djcjhnSnIvZ2RX?=
 =?utf-8?B?VnlGOXdabDJoOEZ3SXFORkplK0ZBRjVmSlRwNVJUZkFFZHNJT1J4ZnUycE94?=
 =?utf-8?B?UHRQWW9SMkJ5K3RVa1ZMVk5Ld1Z6WTNwNzBOQmdGZ0VWUnZScStXUG9hcXVU?=
 =?utf-8?B?RHlZUlJlQW9PS3ZnV0pvM2xyZW1QR0doSXRQaDFvUSsyODVrMFFBeGZGdGww?=
 =?utf-8?B?a2pNTHdtZjZad0RHM0tIZStXR1ZKUmRiYzgreGNiT3dRa3pTK1BMVnRyTUJ6?=
 =?utf-8?B?V3RtKzVid1UyV1UxQjljY0ZjUU5RaUtYYVNGVjZ5SUdqam5GWG1nbmozRTE1?=
 =?utf-8?B?M0pjOTVYd2h1MCtpcGRyL0ZUR24wTVJZL25TUUJzdXN2TkZ0UXhPOVdwQjQ2?=
 =?utf-8?B?YWlkZE5QVzkvejlkQWVIZGhycktlQThsdXlTM2ZZT25Nc3FkUUZSUVZBQTRB?=
 =?utf-8?B?OVk4YmdsV0gyL2hBZ3Z4SlhSNUtCUHJqeGNaOUdvWlF2eDE0eVR4NklXRWRi?=
 =?utf-8?B?RnZZRkt5eTVGbTlWVDViVUtuSHRJRTl2MWlPb0lNM25tQVlQU2o5dFFGTGdY?=
 =?utf-8?B?NmZVcERyMG9NRFV5RTY3L2NyMnpwZEVHWW4ya2IyTE5yNXFXMHRRK1RmVmNV?=
 =?utf-8?B?TG9QbWdYaG9CRTArbGVSUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21XdXRBVDhMMU15Nm9JdFVlSzlBYjF6VWVwVUt0NVVPYys4d1lzanY1aWpz?=
 =?utf-8?B?LzZkQjZNam83SUozU2dGeFhyWWhtUnR3UE9MODgxTnluWFIwMHV1dld3NlNF?=
 =?utf-8?B?dEVJbFg5UHNoSEMzWC9yVU5YeWwzR2JxVWZKSkpvZHp2bkZsSXBXS1hqZTQ4?=
 =?utf-8?B?MVFEWWw0RFVnVzdFcldETGlFcnlKVmY3d1J1K0F2Nk02WE0rbkhNRGhMbTJn?=
 =?utf-8?B?b1NPSmUyV3JScmRVS0M0a3JnRlVyanhxUys5cU5KNFJwZ2kxR0tVbTQxUC9C?=
 =?utf-8?B?cnRVa2Y0YVlWOENEdXgvVnk0ZXp2UFZFY3M3ajl3Y1VqdzV4T3F4bzZrZHh2?=
 =?utf-8?B?T3NMOThmUWhMWUpaL3Ryb3ZrcjBKcFJiNzVZWWZPTlNNSExEUTJ0NjVmMjU1?=
 =?utf-8?B?YmVXbmxWUVg1V2pPTnk0bWFSTkROcHpwRVc2eG9DWVkrS1BrZ1A3eGU5M0ow?=
 =?utf-8?B?eWhzY1lvUSszVk5zMDJSYjRqajZxUDFpQzNyc2Q4MUhtQjR1UHhLN3gyclEz?=
 =?utf-8?B?STFObXRlOHZkbG9NVU5wZUV2SnZqdCtPSEczaEYrcUtudURJS1BzZlZna0Zy?=
 =?utf-8?B?eWg4ZWRBY3AvUXZWQXV6dmNzcDl1eGtEWVJ1Y0E3SmtOTVEzL21zS2VhSUd1?=
 =?utf-8?B?WVdrMSthL01CTEdKTTIrcmVLZUhoTHRtT1NoSHdwWmQ1aGtQS0llQkZWdDFE?=
 =?utf-8?B?dEhvNWp6MWp3WUtFcEtja01kSlYzMmliZDZybWhxZU4yU1U5d3lYMjRPRC9L?=
 =?utf-8?B?Z0VybTdKcStHR2ROY2tCeUNWSUFDR3hwUEo2NE9ycEhma2hDVEJCR3pXV29K?=
 =?utf-8?B?UFFmQzlVYVgvSEcyVGVKdU9UcFA2OVA2VEZYZWdYUkpsazRTNmNoTUNHR2VH?=
 =?utf-8?B?OWora2RWQmF6aE9NR3pFV2VpYzNtaDdsWVoxZGs1bEhaRUZOREFuSEVOWDNC?=
 =?utf-8?B?SlVPZCtyaDNETWYrQlFWMGtsNjZ2QjE2Qm5YNFJmbG5xV1kzclhtbFYxOTVN?=
 =?utf-8?B?Q3JucDJYblNENXorQnM2bDhwTTJwNGNrclpDbGxKaU9UZFc1cEhZSElrNXhX?=
 =?utf-8?B?ZGF2Tjk2OU91dnlxdmZjM2lLYzIxZ0ZzT0YwSFIyRXR6cVAyTHorNjhrWjhv?=
 =?utf-8?B?am54QmtoaS9qRy9RNzhPVXQzcDlpUmUrUUc4dTBzUERTMlRqN2RvMzFXemZX?=
 =?utf-8?B?SnNrVnAwY2NzYmhUTW9TM3N2aEtGUExpOHpCZWFCV2VGZjQzVlpIU3UvenFF?=
 =?utf-8?B?eFplbXFBdmpQdkdzcVdyVHVkQmxkMWNjSTlrSlRENzRLOEg0blNzV3p0SlR3?=
 =?utf-8?B?VGxsUy9mUWVHSmZPUm1tRWs0ajhOSVhHcDVxbFh5bDVuMGdhSzFxSkpJdlkx?=
 =?utf-8?B?cmsyMlgxbHdJRmVkWEhVSko1Um0rakI3WmEvTE1oYmkwanV2YWM4R3piemdj?=
 =?utf-8?B?dVRRdXlCSVVTcFJ0TnZYNXdmVFNpL1ByN1l2c1dMam9tREhjYVBnbDlLaFNB?=
 =?utf-8?B?ZytyQ2hDSmkyRmZsNmM0ZUlBR0tSaHg4WVhqQksySTg2MUM5OS9lek9wRzRk?=
 =?utf-8?B?RlVQVndNUEhzZ3g2eGExUkk1aFJLYzVCdUlxRlkzTlJTTnNHNnROdTZTRzE2?=
 =?utf-8?B?aTRDSHBHcFQwZjRXVUI4MmVxRFpoVjEwbWwwcEE2NUw0bUkycEF2bjJ6Q252?=
 =?utf-8?B?Tlp4SEJLYStnS0FKU2VvYlJ3T0luc2pDTTIwZ09DZjhXQTVISkYrcTJWSVBo?=
 =?utf-8?B?K3FpUEp6K083SXBoZksrdExDZldOL0VrSWdaUUcvYzluUkNnNkU0OG8vSjRT?=
 =?utf-8?B?VERwNEE1aU5CTmt1TlZScG1sV1dnNE1aZWZKQjZpaUtjUkZ0eU8zNzJPbFZl?=
 =?utf-8?B?T2JTKzc0bEhoWVlWTGU3SHJGSWpBeHVuSStRRzFHeXpPMFViUmZpTkpVUVhV?=
 =?utf-8?B?Q2RQU2ViN0hEMFVwemlFcjU1dUR1aUVGODlGck5EMzRSZWxBRkl0Vk9yd213?=
 =?utf-8?B?cVB0SFNncFVNdlpZSTZSazAyMUNVNUVKTms4QVk2dWtQUG9LNGYzZ3Z4K3NM?=
 =?utf-8?B?Wm5GdXFvaFFPd0U5WUF1N1VJazZ2YUxSY2txUkk5c1NlYWoxZ1RwZjB1UzZh?=
 =?utf-8?Q?d7nddpAl6XRe3q1iZHXdCtmCF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8861986-1034-4721-9072-08dc843f96f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:39:42.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlgXZUo190dcVa+bYRK6qZc5g/JllRIRqiagEaTLa2uvlUnaE0cwl1jKd1LbGkGZknV+8EmO+lA3SjQdsgRlzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

PiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+
IFsuLi5dDQo+IFN1YmplY3Q6IFtQQVRDSCAyLzJdIEVEQUMvaWdlbjY6IENvbnZlcnQgUENJQklP
U18qIHJldHVybiBjb2RlcyB0byBlcnJub3MNCj4gDQo+IGVycmNtZF9lbmFibGVfZXJyb3JfcmVw
b3J0aW5nKCkgdXNlcyBwY2lfe3JlYWQsd3JpdGV9X2NvbmZpZ193b3JkKCkgdGhhdA0KPiByZXR1
cm4gUENJQklPU18qIGNvZGVzLiBUaGUgcmV0dXJuIGNvZGUgaXMgdGhlbiByZXR1cm5lZCBhbGwg
dGhlIHdheSBpbnRvIHRoZQ0KPiBwcm9iZSBmdW5jdGlvbiBpZ2VuNl9wcm9iZSgpIHRoYXQgcmV0
dXJucyBpdCBhcyBpcy4gVGhlIHByb2JlIGZ1bmN0aW9ucywNCj4gaG93ZXZlciwgc2hvdWxkIHJl
dHVybiBub3JtYWwgZXJybm9zLg0KPiANCj4gQ29udmVydCBQQ0lCSU9TXyogcmV0dXJucyBjb2Rl
IHVzaW5nIHBjaWJpb3NfZXJyX3RvX2Vycm5vKCkgaW50byBub3JtYWwNCj4gZXJybm8gYmVmb3Jl
IHJldHVybmluZyBpdCBmcm9tIGVycmNtZF9lbmFibGVfZXJyb3JfcmVwb3J0aW5nKCkuDQo+IA0K
PiBGaXhlczogMTA1OTBhOWQ0ZjIzICgiRURBQy9pZ2VuNjogQWRkIEVEQUMgZHJpdmVyIGZvciBJ
bnRlbCBjbGllbnQgU29DcyB1c2luZw0KPiBJQkVDQyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxp
bnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2VkYWMvaWdlbjZfZWRhYy5jIHwgNCAr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9pZ2VuNl9lZGFjLmMgYi9kcml2ZXJzL2Vk
YWMvaWdlbjZfZWRhYy5jIGluZGV4DQo+IGNkZDg0ODBlNzM2OC4uZGJlOWZlNWYyY2E2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2VkYWMvaWdlbjZfZWRhYy5jDQo+ICsrKyBiL2RyaXZlcnMvZWRh
Yy9pZ2VuNl9lZGFjLmMNCj4gQEAgLTgwMCw3ICs4MDAsNyBAQCBzdGF0aWMgaW50IGVycmNtZF9l
bmFibGVfZXJyb3JfcmVwb3J0aW5nKGJvb2wNCj4gZW5hYmxlKQ0KPiANCj4gIAlyYyA9IHBjaV9y
ZWFkX2NvbmZpZ193b3JkKGltYy0+cGRldiwgRVJSQ01EX09GRlNFVCwgJmVycmNtZCk7DQo+ICAJ
aWYgKHJjKQ0KPiAtCQlyZXR1cm4gcmM7DQo+ICsJCXJldHVybiBwY2liaW9zX2Vycl90b19lcnJu
byhyYyk7DQo+IA0KPiAgCWlmIChlbmFibGUpDQo+ICAJCWVycmNtZCB8PSBFUlJDTURfQ0UgfCBF
UlJTVFNfVUU7DQo+IEBAIC04MDksNyArODA5LDcgQEAgc3RhdGljIGludCBlcnJjbWRfZW5hYmxl
X2Vycm9yX3JlcG9ydGluZyhib29sDQo+IGVuYWJsZSkNCj4gDQo+ICAJcmMgPSBwY2lfd3JpdGVf
Y29uZmlnX3dvcmQoaW1jLT5wZGV2LCBFUlJDTURfT0ZGU0VULCBlcnJjbWQpOw0KPiAgCWlmIChy
YykNCj4gLQkJcmV0dXJuIHJjOw0KPiArCQlyZXR1cm4gcGNpYmlvc19lcnJfdG9fZXJybm8ocmMp
Ow0KPiANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLS0NCj4gMi4zOS4yDQoNClJldmlld2VkLWJ5
OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCg0KVGhhbmtzIQ0KDQoNCg==

