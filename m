Return-Path: <linux-edac+bounces-3119-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A6A3936B
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 07:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C6C3B2346
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3A1B3930;
	Tue, 18 Feb 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg16jUTc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F52753FC;
	Tue, 18 Feb 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860165; cv=fail; b=p/T34BpTVvJketXO+PxsuP6NM3OkY39Po1QHULdw7VQCopXFjQrKRLvoY4n+CvZ+tEMKFqA70o8okmneXFKcuJ9b2l2gfFq3WLa0HVJ2gzT+K8HyhjfcRyuhI409Q8aE1KrRlsYaCTpw1XHrL2x5obUwk+85YAgcnBMsDksXHDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860165; c=relaxed/simple;
	bh=bga+xFOCi6YxYRn/Hf44Q3Q2XXot6akqiaFFv7TjDoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N9Sta++UjP7IxUUfwyMMGDvlBcEWWR52PLYfzEessCZigAVNg3odPgyUSfFKtt6prae/8kOMGmZ+3LUrB1ZR6khoGl9PUnmVjB6diUc+gVwhG4fTl/JTBo7+sKmXaSFR1iyNHXuZUL725o4mVmbUn6UgC/DAtKuQZLvdkkLYNOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg16jUTc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739860163; x=1771396163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bga+xFOCi6YxYRn/Hf44Q3Q2XXot6akqiaFFv7TjDoQ=;
  b=lg16jUTcWZ4QzRY8KMCVq4aDf5Zq0qBy3Iun4uVO5kKqNJmP7GHbjW9g
   z/aP/uU9Jh9KrVEpe8XQnF9+wlrSR9cLdRo1w8K0ijpeNV0K/yfhn6bKy
   of+otKcoacCPGENtwtCRkZVyOzu+1fv21f8cmBV+7fdnLHnvxl264iOgJ
   h87HRJd8rPvzqTKUo5QrZONxjaJrKgNxDQ/jPMXr5dvqF+HP9/1wb74Px
   Z9FsxMJcOZ8qNH7LSif4q5gjfjMG7L6jn+W6ms152PAu9GwqcnDISNAOs
   yJaLG0KCTFQuDuaomMQWg2K1mgLeRUtciKQ+FFWsaTClnSEFSZGthckeL
   g==;
X-CSE-ConnectionGUID: Pl1wGvHnQoWhL3BPYy53Dw==
X-CSE-MsgGUID: SexAsaNDT3ON0nUYp0CP3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63018466"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="63018466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:29:13 -0800
X-CSE-ConnectionGUID: Aj5whs4HQPSB5jAvyxeUDw==
X-CSE-MsgGUID: Ws+CPvzbS/aHQdyEW4kNvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115204386"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:29:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 22:29:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 22:29:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 22:29:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVyfoGoeNFYGK13w54HKAm5GUkI66S0BmvsVqsrxLZFkA1ygNhLCNaLBkT+7ClFI+5co8uwjN+tszy/16pgrCVsFPiXibKcMQGkAokXxO8lf15ydrh7qLcvKzueqf6D32kEHpaTPmY0r4yIQKHStwR/6KYjHMFrwJp53l2pQUzUVET42BaueOl328T0KmeH42YjQbLpuFgMcJa6LOoHF//Lz2htAmVSeQHZyAIcBHkkF4DuudQEH1AT8SUCM3uxXpBW3N9jSFlzd77Kr3THNGXP1/ThcvgphSQw+UXx/GeA0m61LuQUCn13m8r/QnegEoSLtMjB4XOFgiI+KWbBjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bga+xFOCi6YxYRn/Hf44Q3Q2XXot6akqiaFFv7TjDoQ=;
 b=Lc7ivpOAXQtVka1Onl5zWDdPniuDUzyxj5JXxQCsBKSqpLVgMK2S3SwQWnuzAnMTJp9xUCuUyvPjsSqJ/tY0nHAw2DtUUaOXxOTRAV5GuTqOh6yTggUuomXA1TZr4d6zHAu1bTWSvJVXLdnVmLZmqffUDpGn2A0vF5FObjwZnCOQpH0Y3JfmV0Uvu3aH0wMUZ3FzS5/VSKHFd25Yq+B8qDYM8/zKJTYTjj0rMPjD+lv6KL93oXovkfM+rukQbLc4Ned6iRJoyKY9voPh3fG4QEXD1pckIEYhweRjnlhtZgVkLdct2Np6dDTxQqWkMGOmoBgE3ICJNt8KnPJeV4pTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 06:29:07 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 06:29:07 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 11/16] x86/mce: Move machine_check_poll() status checks
 to helper functions
Thread-Topic: [PATCH v2 11/16] x86/mce: Move machine_check_poll() status
 checks to helper functions
Thread-Index: AQHbfjktlMQOuFIM9kSFBMmqNsmDfLNMoETA
Date: Tue, 18 Feb 2025 06:29:07 +0000
Message-ID: <CY8PR11MB713477C0B7C3353BEE79459089FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-11-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-11-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: 4cb9e390-5a62-4698-8f38-08dd4fe58c1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUN6WUxHVEZzNzMxeVdaTGU1WE80UTh4TWlTMStVUTJVenlMVEpGMm5KKzN2?=
 =?utf-8?B?cjdhOC9ndGx1RUdHN2RvSkdybWxkQ3FyQ2J6WmtHN1FpS05pMWh2RHNaVTFB?=
 =?utf-8?B?amdXMzZ2QlN6Ym9VVWJjbm5oQlpOSmJDZGJBSHd4VEFyVzlDNDFYT0JKTmhW?=
 =?utf-8?B?NGtFazJOS05lOXM5TzJHSy80cWdUQVAyVzYxZnlYaHlVbFhkZWM4TEw5WkVG?=
 =?utf-8?B?b1JNazlXZ0JURjVGeVdwdGxheFRIdW81QW1GOVRUNjBQN0ovR2xNNm9iZkJh?=
 =?utf-8?B?ZmEyUEZVQURZVFZYa1VFWkNhV2FZOExUbWFHN2d3bnBNRlZoUXNZbEcvVHhT?=
 =?utf-8?B?ejY1aDFlWnluTnlBRVpma2VNbThxeEg2NjZjM1JiTlFYQkErYVZWd0JPWXMy?=
 =?utf-8?B?VHlxTjBkSWgvTU5sNEVoWDd5VU5CODN3c0hGVnpXRlVKOW9nUWNnOUNmNk9Q?=
 =?utf-8?B?ZHNkcG91V0htc3YxQnFpTEt5OGlCUDNQZTRDa0dUMy9UWGUrMGk2aUx2WENs?=
 =?utf-8?B?NUhid3J1WllHYjFkcFJwN2xVTnpuMXFkb1d6cjBWajJEL3BKRXB6OTAxZHdl?=
 =?utf-8?B?VFpia1RUZmY5SThGeVcvaXhKZUZYeW92TzYwbHJSK20vRXJBaHhDMTNsUHFv?=
 =?utf-8?B?QStaTFhyZXE5N3ByZGVmbE9pcklFNFNyN2d1bmNxY1JNMTB0RFlMMWZNVjdT?=
 =?utf-8?B?RjM1eEZrSlFPSXNiRWpvdW1kWEdwV2JRRXdya2hTNXhsNjdTdnc2Z2kxUkJ0?=
 =?utf-8?B?bVdLSkNnZEVIcis2U2g5U3FqTmRRSGxVMWQvNVZvZFkxY0FWYzV1MG44WW03?=
 =?utf-8?B?dGNVell5bDRxSkJBN1MwU1hHN0tIK1RPbytvdWQxWmp1aFlrUTRINnUxRG9o?=
 =?utf-8?B?LzFKalNWRG5jdmI0U0FoYnpwd1FvNE53b1VzUFN4L1ZwNjRsNE5rWk9tbmp6?=
 =?utf-8?B?S3RON2ZuWVFLUXhrZ0M2N0duMy9xY1JwUzVtcERhTFpIS1hjY1JLVDVWbUd4?=
 =?utf-8?B?K0tnb1RIeERwK1o5NldYL1dCcy82cGRFckpDeG1OM0dYbisyMVB2Y3luMzdh?=
 =?utf-8?B?SDJtTHBKVFo0MUpGUXBzUTBTSDdKWjBvRStKclpHOGVvN3ZOVUpVVTB3SWNQ?=
 =?utf-8?B?VjhWQVVTbnZ6K1NWbW1ySjNNVEVMVmcyTjF1RHVkSGRSZUhpSFFwQzFGTjFJ?=
 =?utf-8?B?RlJZL0RPM25kUkNmREUwemhVREpUcVRQK3VINCs2ZG5YNDVBdW8wRlJGL25p?=
 =?utf-8?B?cWdkbTM4YkVRQ2xqamFBSlZBZTRSLzdBdy9TbHA5Y0cva0dsYVB4VmpGNjFY?=
 =?utf-8?B?Qi9nTjlvZ0Y5enFLZ3Q3eDlKaC94YUxLanE0MXkrekRqZ1NnRitxdUFLSTBQ?=
 =?utf-8?B?Vmp2SGx6dWpNYVI0UlIvT3k0ZGVXdXVsNnlCdjFnYTVvQTZOc2ZaVmJxQlRs?=
 =?utf-8?B?UmZxWG9YY3lPMFJ6WVh0T2ZPQ1dTSGlnRWwxSWhRM2xYUHZMYnkvVnJ4OU93?=
 =?utf-8?B?WGswY3NFdUJ0aHpoQ1A2MEVGQTRhby9UOS9zYitWdDRNQ2xQSkFnNmwrb3V6?=
 =?utf-8?B?UUdNaXlrZ21TczZxaTA1Y0JvSUVkWmZiNmJCTHoyWng2dVZjSG52c2l4OFNq?=
 =?utf-8?B?aHJUMmVsT1BvZU1Iem55aGxKZ214MmMvT2lnS3RWNnhzMlFwOG5HTU1sQnpK?=
 =?utf-8?B?REdiK2VlWnE5T1YrOTdobWpDdjV6OWRIZmI1cDcxWlVpdm9Ycjh6ejRzUGQ5?=
 =?utf-8?B?QWkvb3hJelZqNitabTBCSU1YYnhuVXdzaWZrcy9EV0N3eUhvVmZTL3h5S3JT?=
 =?utf-8?B?a3ppdWozM3NxREg2YmorTnlYY1diWXZXOE14UTZqOUpwSTcwK09od0dRMTVG?=
 =?utf-8?B?elg1bEl6cE43amR2UEJ1dzFsTGpCeTdqVHBJU04yNm5halhwZ080UGJqUGdy?=
 =?utf-8?Q?/W/D70wiySXSi5iFQu1T8ZtzrpZy8jl9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGtZVWdxK3VTVUFKaFJKTm15NUtWZnUxNkxIWUxremlPOENMQXAzRTh4dDI3?=
 =?utf-8?B?VWs2U1ZuZkxNM1B2eUtkM3F6ZmFxcmZUbVFmY0JrWERzdFgzMWtBSlVHREw2?=
 =?utf-8?B?eHVXcjllclRNZjd1T0JWMklUUDY5Rm5qNTVzQjFBdGxCL0NLR0s1bmpXNFVK?=
 =?utf-8?B?TDFRS3YwTTJuRWl4T2FmQnZxNEQweGJRU2pOR09scXM5TkhqeEdGUFNHOTVJ?=
 =?utf-8?B?eWg2ZUNzVGZEbW93SVg2QTMrSFBzakRlVWhjVXhmaEUya1hWVnZUcUNlcGpH?=
 =?utf-8?B?SXkwUWtSaXlTVFk0N3VSOWtIV3JkSjJvYUk5eU5SV0dPT1dsU0FQTVFzeWtZ?=
 =?utf-8?B?UHdHcDR0Um1GWEd0RFl3SDltSjBFQU82ZHhDZExlQzJ4UkxJV0tGMEFJUXpp?=
 =?utf-8?B?K0E3WC9teTdtTFNQZHA5NzZVUEhFRnRRak5DN3JsSGVRc2FmUHU5UVdzWXdy?=
 =?utf-8?B?OEhRRXg4VXRoZ2JEWTVhUDhOQVBtTksyVkhRNmhZM3RkcDdKZDhCNU44UnE0?=
 =?utf-8?B?L04vUDRzTFNvZ01FRzdnSy9Ra2c4WlB5aGNUSXJHSEtrdEdRNk9iNkFhR1E2?=
 =?utf-8?B?TzBlYnNnd0t4SFNyOEhUd2VYeTBjbHlFbndSK0RrWnhMR29sT3ZkMXFkc3p0?=
 =?utf-8?B?dGR2a3RDYXUyVlV4YTdnT2pNcWdXT0ptcktaSFY5dGJodVR4Y2FsRzlzNml0?=
 =?utf-8?B?N3R2bEtVc1FCcTR5ejNJZEZsVE0vWEhTMklySm5YWm9HeWxnREptUXJLWDdO?=
 =?utf-8?B?N0RSVk1jWDlEYVhNaXdkbXlwUFlzUnNQeGZRRXB2ZEFxMjcrZ0loZTJTYysr?=
 =?utf-8?B?WHdnWDVFTzN5UXpKZWV0VlJMcEU1dDRlQVc5cHdnYW5nYzhQczFPWklTK2lK?=
 =?utf-8?B?dWoyZHZTeEIvbFJzUGtCT3pxTWg1TVYwUXQ3Qm56QUl3WFFsU002OEFBR2po?=
 =?utf-8?B?Y2ZEUzdVU1hRcUhBS1c1WS84VzdrbzNDemJBUlE0UW5BNXNWZStvbnZtL1Vv?=
 =?utf-8?B?SXVGbXE0SGFEd1ZZNGh2UnovY0V0WnFKUWlnNnZzYng5bTFoT2tUb1ZKalBT?=
 =?utf-8?B?SUo2dEZqd3Nya0EvVEFXQUdrVHc2MEhYbllzenBPQ2RPbDJ4U001N2h4YTMw?=
 =?utf-8?B?a1Bsajk3elIxOHF0T2FZbHFUUGFSUFNicUtiSlRxL1YzNEFkRHJzdnVUKzEx?=
 =?utf-8?B?V1V5Q2pkeVZFeEJFNURUZWV0SzhCSzRrL1l1ejRObTBPMDR1eUJHQkF1dit2?=
 =?utf-8?B?NksvUHptcmgyeFhDMkNwbW03Sk5jZ2pmaDNkbGpZdldRM2ZyRVptbC9xQUgw?=
 =?utf-8?B?UXd3MXN4Y3FxQlk3YlhaUlZEL09PREVRYnhsOGFNMVF1ZUJwY3ZCQytoU3hX?=
 =?utf-8?B?c0RHMUJrZE4rVG9DQlducFhuVTVLN3o5MUlaK0xGQjlKZENPMXQ1a2EyNXhz?=
 =?utf-8?B?cDdoMWJtbXJrU0hkY2wyL01acmNoM202MWp2WTFETnc1VGNVMldKVWZxY1Jp?=
 =?utf-8?B?T3lDU3I1YlVRL0Iyd3dsTy91dkl1cWdUNldmYkZEOG1qL29FWGxJSUN5Rjhq?=
 =?utf-8?B?UjRoRUdmcG9ObzdTOUg2SU5jTVRoWDF3QlBSOHlwdG1rRDVUTWpKZUFiUnNx?=
 =?utf-8?B?SGYyRm9qVnMwUjZ4TVFXMmlkMHhWYWs3eXozM3AvdmRBVmN6L2tPUXdPYi8z?=
 =?utf-8?B?aWZZSGZZZzdSbUJ5VDVxdDdrK2RxaXZLbHFFMGtSYmc4L1cvVVlPVE9adm5K?=
 =?utf-8?B?ZDlEL0kwU1prNzVSVWxHa0VMR2VTU2NPQlloTC81a05rWkNwNStucnBaWTZL?=
 =?utf-8?B?Qm5reldwN2VVN3hkWW9mUkR2MG9NSmRldmJ0T0xJTS9Vc1ptMnFWQVR5ZDV3?=
 =?utf-8?B?N29mNjg1VmZDL014ZXhZRHRWOHJPWUYwWkNadDRQNkZSckFQby9SZ2d5cHBD?=
 =?utf-8?B?eEVYMmQ1TmE0TlBSY1N5MEkvQTJIeUZHSEhSL29UZHlIZFAycUJLTjNoM2xK?=
 =?utf-8?B?ZkdDdzJlbURLTUNMdjhZTzBFSW5NS2FrZVBjTW9NcGxtMTV2ZTRXMnpCL0xi?=
 =?utf-8?B?azBEbU1nT1U3TnVyREFneWQ2U1Bwb3lVc3hnV2w5SWgrRWJmY3lPZzYzS01Z?=
 =?utf-8?Q?rnWynxIQYj78EQp9Vn0Cc6U3k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb9e390-5a62-4698-8f38-08dd4fe58c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 06:29:07.2804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVVaM6uZq68qjtFxGKh5jtYkucu2lUd23/VJbXDOfQkTecRq0a92MtsaldpgY3qJuFrF1gLpBAfWZL1kd7M8Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAxMS8xNl0geDg2L21jZTogTW92ZSBtYWNo
aW5lX2NoZWNrX3BvbGwoKSBzdGF0dXMgY2hlY2tzDQo+IHRvIGhlbHBlciBmdW5jdGlvbnMNCj4g
DQo+IFRoZXJlIGFyZSBhIG51bWJlciBvZiBnZW5lcmljIGFuZCB2ZW5kb3Itc3BlY2lmaWMgc3Rh
dHVzIGNoZWNrcyBpbg0KPiBtYWNoaW5lX2NoZWNrX3BvbGwoKS4gVGhlc2UgYXJlIHVzZWQgdG8g
ZGV0ZXJtaW5lIGlmIGFuIGVycm9yIHNob3VsZCBiZQ0KPiBza2lwcGVkLg0KPiANCj4gTW92ZSB0
aGVzZSBpbnRvIGhlbHBlciBmdW5jdGlvbnMuIEZ1dHVyZSB2ZW5kb3Itc3BlY2lmaWMgY2hlY2tz
IHdpbGwgYmUNCj4gYWRkZWQgdG8gdGhlIGhlbHBlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZ
YXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQoNCkxHVE0uIFRoYW5rcy4NCg0K
ICAgIFJldmlld2VkLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCg0K

