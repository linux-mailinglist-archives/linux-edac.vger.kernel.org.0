Return-Path: <linux-edac+bounces-3100-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18DA37BB3
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AE63A2FD0
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F0190059;
	Mon, 17 Feb 2025 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktiiQNYh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953F15442A;
	Mon, 17 Feb 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775485; cv=fail; b=fUOOSuAbbAK9giRML8EgEOTapUqS3jx8bjy0Y7t+k35uOWEbmS4Z69HM0u04+uS4nCNHbkdMkZJEodAKE8pjIWh8BbXwOAFIyupylHhumtSLVOaQId/V5/cIq+4bjdvOuFTpnVbe7NB/gd9EQYAcY5Wc/wqJnMzDKYZfEHah8vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775485; c=relaxed/simple;
	bh=gbwlJMCtluZyW6iKLr2Ru2o7RG4UqLODiT+NBfdnAQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MzsFn1zLsXDUEUrETwrG+JSPpBA/9Q5afOikAc4md+Ezh+QjD4K147x4FoAQsIw1cWZwFFBJ7yHIQOrJzmTExXQfHCn4a28rSt/6SCVuTXE26s4A54fDMKuoEG6ztoq7X9PLtrKbzsqNzx7kkb1YtBbc5x4mqIjlVbH0ryJpvvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktiiQNYh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739775484; x=1771311484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gbwlJMCtluZyW6iKLr2Ru2o7RG4UqLODiT+NBfdnAQc=;
  b=ktiiQNYh0xgsCeaKvJ2OegPuXfKTGrvMrfx3Nx2VHaxKw9ngNm863onw
   E2UNplpcUnzGFk6lbrpIf/rHYHT8j9htL8B/87T+jWTKRE1l3ISUAs4gT
   uLRwxiTCwdsjIZiK1NZY2+9tx6EEhkA3Vg8mo74iMKsPrhlqeMplwMKtM
   apbfiTS98rCgFYJJfMBlR7AlBroEHe45136PK1CgLY/jPBWgdJizd78Uo
   dbrxrUUctJQVN24thjqlte5Fwk8R9Akd3xhlW6G/p80Vph4jH7VGnjwcw
   RWZBngOd0LbJhFdHsxo1bpMl+feIlgvDlHEGYnkjaWm8czBEUrBa5lycI
   g==;
X-CSE-ConnectionGUID: cv/bjuClS4uRUuCRssbFeQ==
X-CSE-MsgGUID: jTnI0PcZRjGwdqqCcoj4+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="28045245"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="28045245"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 22:58:03 -0800
X-CSE-ConnectionGUID: 3/PBJ4ygSfe527oOXK26hg==
X-CSE-MsgGUID: XAARnlzTT8OiEDxtSY/vvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114928098"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 22:58:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Feb 2025 22:58:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 22:58:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 22:58:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTT3ytx3IKnvSDu7YxUbe9vNJBMxELnpBAF4xGGlgnHHbRSHcrWh56o6GnrgMf10syXIjTpLszGWRV+28/SjWHnJq4aGzFbuohxpgvbep0PqyVpgRRQzdFSI1JfIkhv1VzcRlTVywm9a+008GHlJxgvnAr0SAvLS1myIy813/IS8m354k6sylMz2ABNLbz6avYjTc0UqlAgyHtCrvaTfkicLShVlmmwD2+/hvLr16JGE+ZROZfnN1p8NdnLuO+v3Ze/0ivKKyzEvWE3q8ysxzOtBwc0RWCjXPj3mXKt+5Edy1xhfgbVXYn0tBd1UFzZWdHCm7iNUQ5CT1TOEdrQ9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbwlJMCtluZyW6iKLr2Ru2o7RG4UqLODiT+NBfdnAQc=;
 b=quwOxwj/30PnLeLbEniCyN1E+/WoGhANA1zr1SzQPDAQkPRJ4m7NiAXt41YC8TeGP+cBSD6sJCejtbpN+cjw/5eavSgtIbu4o3/OjX8wNY9KLg/K3pkSJYWAHJv6/KXy387RjprxoRu9AFbhl9aCmwi2dITOGLbtVVC5AM/HbG/vMCA7ZDfWLVllf1E1k1oqC40uAO1dUq15V71LiUcuymjvpQ+56YvRZtmULuMOsMUJu9aT84dwHwgmfpi+u2M84a7APEHZZHm3bxausZcDKqatYjRKuAKgRlCWlq67/ZIom3q8OvsgU8YyPjSZR39vAbo7ZY89LVNSZIwqOBuUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA1PR11MB7344.namprd11.prod.outlook.com (2603:10b6:208:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 06:58:00 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Mon, 17 Feb 2025
 06:58:00 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 01/16] x86/mce: Don't remove sysfs if thresholding
 sysfs init fails
Thread-Topic: [PATCH v2 01/16] x86/mce: Don't remove sysfs if thresholding
 sysfs init fails
Thread-Index: AQHbfjegHHMW0HKgAk2TeTq14DG+yrNLFPMg
Date: Mon, 17 Feb 2025 06:58:00 +0000
Message-ID: <CY8PR11MB7134FB62A26B7E96A40BDDD989FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-1-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-1-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA1PR11MB7344:EE_
x-ms-office365-filtering-correlation-id: ec0d9f4f-15f3-4a89-01e1-08dd4f206aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K1dXV2xLM1FRRHRnRFJCQVNTb3lhZkFVckhVSFFpbEswclNFR2k5SDg5VlI1?=
 =?utf-8?B?TmkrWjd3b2tpc2VyWk1CeWxFQXZhSkVMYzhtTStnc0lUbFZQYTBibnFNM0JW?=
 =?utf-8?B?Tld4YnNjY0h5Ujh5cjJocC9lYlpnTmJsb05DdUpkRXZmL0V6Z1lwMjh5V2Np?=
 =?utf-8?B?S3pRdHp5azFBRENJeU1KMm9FeU80cy9BL1lqQ01GVFJjSW4xVmtMVytqWW9m?=
 =?utf-8?B?eXpBNnBjVm1QS3FEbXdyNmdyNEpLck0yL2JiMVBadVBiOERlRTZYV2pvKzB6?=
 =?utf-8?B?L21aaFZJdGZsYnB6c1p1MzFMUkdnNGFKaW82d1FHRHg5QkNNMVNBL3pmN3Nu?=
 =?utf-8?B?Nldxa0xNUUV5MklLQnRRQmhpN05vZ2FKcXpGQVpFcWxnQmJGMVdEL3lORG9X?=
 =?utf-8?B?NENJK0R2UFlkRlNBeExrNG12blFHcllKMGVDSWtuNkM3alZLMk42VDVXSDF3?=
 =?utf-8?B?ZHR3MzM5VUt6VUFtMXcycDhDeXdsbi9UTVRaTThBMDVEZVErZHZxcDNWNW1I?=
 =?utf-8?B?cE9ackF1Y2tjYTdlR3B6OWh4QkJJTnJsOEdaRDMzV0luY0t1ZGNrYUs2MUo3?=
 =?utf-8?B?c3ByeGtPVjdJRitZU2drMS81Q25nTDFDMjE0TldWelo1OVVoWU9Xc29JdWpW?=
 =?utf-8?B?NzdnZWNZWUhzZXlCUDdxSEd4RkQrUCtuSzQ1SEFJV1N2T1hGc2hGdTNzQ1Ur?=
 =?utf-8?B?V21DWkN3UFJQY2hxQm5jYU5xd0NVamFCbzdnQUZGR2ZSQlgzUXZFSjlFQTQv?=
 =?utf-8?B?SGt6NWpXeFJjK1JualZoZVFIVzJrQjRtU29STGdDZVA4MlVFWi9MOHprTmx0?=
 =?utf-8?B?S3hsSUtPTGl3dFN0M2F6eFRXUVNKdnhRd3VuOW9kNHZ3cUlpUCtMQlJhZ2Jr?=
 =?utf-8?B?SGpYeTM1b0w5bk9VaU1neWdWME9pS2ZzcWEyRi93NUpVSml4bFVqRGR0d3do?=
 =?utf-8?B?a3FJa3hNZE1sR3IrZmk5bFFXazZZZkxLTkFoM1YzQVdLZWhxZWNNUUNIS1Qy?=
 =?utf-8?B?c0YwbERMZjgwWXMrVy9yeDQ3aVlDOVNnSnNPZldjQzRjK0VUaFJUYU0zQkJ4?=
 =?utf-8?B?Q2J6UkNVd3V6Z09JMDQreHNST1ZzQ1NXcnFVU3hjM0V0UThvNzYzZFl0bm1R?=
 =?utf-8?B?QXF2ZDBxYVpPSlBRTGZkYmw0TjF6V3c2OWRIbXRpY0NsUkFPL3VkK3VMcG5h?=
 =?utf-8?B?d3RXUWU5VHh0SUZKM3NJcUxTN1dWN1drQUZwZDQ4QU50ZkV4S0JTaGlnTEFK?=
 =?utf-8?B?aGo4WFNlREN5VUZTNnJpSDZpSWYxTWRHNFhFUnNoTno4ZVc2VXB6d3oxL08w?=
 =?utf-8?B?cDZGSmhPS2RabVNkdFUxZEpmR21STGVvNVJWSDBQMWs2TWx2WVJZbDVxbHFC?=
 =?utf-8?B?STBUeVZKdGcrSFNXcUxROUdicStMZ1M0QlZwSWZtL3RVeHAwQ2ZrWVJSVjZz?=
 =?utf-8?B?SG0xYVZLSTJjRGwyUmVlVVp0VDVwSW5ETGdUcXQ1MFdoeWpMc1BmS2ZTcC9Q?=
 =?utf-8?B?Qi9jT0EvNk1BUklrSnJtR3FNcGk1SGQzUlEvMUl3ZzAwUElONHZvYzhMMStB?=
 =?utf-8?B?QU4xWWpRZFB0R3BGODRxSnBKZWpYMXgyK3N4NVB2SFkvMFBnUTlDd3lpU1J0?=
 =?utf-8?B?K0QwaEkvMWE3bFQzVUg0S04zMDZheUFMK0FUaTU0c3lLMStHcWIvaG51OVdG?=
 =?utf-8?B?ZXVnalp5RUFNcW80Q3U2bTZVYUVhZDllTHVadWVyL0s1bjZ1czVPbXZDdW13?=
 =?utf-8?B?K21OdG9ZcVBwQlhKMnZXSmoydXRXVmdkYTlZRWFSdWZCN2lReHBhcUtQZ1hr?=
 =?utf-8?B?Ky9uWlo1VGQ5QVN3U0RhZERPZk9vMG14WjhtMXJWdjlJUjh6R3FVK1VTakdQ?=
 =?utf-8?B?OWZ5RCtkVFBsZzZVY255VGRua09uaXFlYll2TmVqZTFHODRVOUd5eDZ1M0pu?=
 =?utf-8?Q?B0K5pzbrBVUZ/cYoh9bw2V18seeI3lmF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkhNQ1BvcU82UnFvNlBxSzNUKzFTRmJhSHAwMnE4MmhkY2dYdE9DdS9zY1Vw?=
 =?utf-8?B?NHJXeTVFM2Z5bk9XUnA2aWpRRHRQYjhvQkhHZmozZ2t3TkZVQjByd1FGaXRZ?=
 =?utf-8?B?OWRRbDFaVWg4MFZ5UnJwZVptMzhiRkU4cExiQ284R1Jid2xaTFBKdkFOaEVM?=
 =?utf-8?B?bXpBN0kxaTYrcnY4aFFHbUVlUE5IOGorR1dydXNxcGgwd1JjSUtTVHRaN1Mx?=
 =?utf-8?B?OHdZci9IdGVlR012eW5HOGV4TjNvbUdScEFkcSs3bTl1NVo2RGZ2NXkxWnVi?=
 =?utf-8?B?ZVlrellvSWlPbFgrbjBoMWYycCt3eGlKaFlOWVkzVmRqSUF0Q2c3NFNiVzlN?=
 =?utf-8?B?UndPbVZLTUMrbldLMWRYTXpTNExha0RlTTR4TkdBWGViaXZLS1lURmhVdVNK?=
 =?utf-8?B?VjJ5cG1PT0ZIM2NPNS9jQ1ljZXpTM1VOZkZobFpQY3pyTHZQYlIzQkdGalhk?=
 =?utf-8?B?dVhLVXZ4SEdrTzFYODJoeXZ6MlUvYTRkdW1nMXBhNXdwWFU0WnZsVkMvc3pD?=
 =?utf-8?B?MEVOZjlseFBrVTE0SDd3RTNNRUUxSFRDN0pPYU1ySXBESk85QkpvNHdYRVN3?=
 =?utf-8?B?RUMxZGlDSnA5djUxaEc4MlJRbFhsdUlEdUkwTExucDdtVStySVU1V09NM0dn?=
 =?utf-8?B?LytsVnhvZTN3RVFhVEovbTJqdzF0Vk4xNGlPYUFoMHdrNDZlV0tCRSszNWp1?=
 =?utf-8?B?L05HRUVKb21SSHZDYWNMd1djQU9VaGRZM2pIYk1XTjN0WDVQUHA3NU54UWhU?=
 =?utf-8?B?bVREOEhiL1V4NjdOdE5FeXd5QmlTL1M5cXZVMGhHWlBrNzlCZGk4dExjV1ZK?=
 =?utf-8?B?OGRrZUh0SHU1dVViTFlHeW5KQmdrR1BWdmFNSE1pOHVrcUh2N3VIck9DS2xl?=
 =?utf-8?B?RWhzN2YzNU55RElQYjZFTm1NeUkrV1lYQTFYRkE2ZHdDRTZvOHFkWkVmU0kz?=
 =?utf-8?B?MnZMR1ptQWpvTktMdk9udFFIZCtVRW5EWHNVNzVFZ3BFK2RPT0E3Ynh6eit2?=
 =?utf-8?B?NFRCVXZzNDcwL085aThzSy9EcDdYdFNSUUdBN2ZueTNvN3VpZFdENU1nQVAy?=
 =?utf-8?B?MTdTM2I3bnlZaXF0VlpsTlZYZGc0QVljSlR6YlFzME9RNVI2a3hERkM5bzVG?=
 =?utf-8?B?ckF5ZWlKektGQmY0Tkl5MklhRmx1bGN5VW5nUm95YXhNaUN3RXlxamtpbnVs?=
 =?utf-8?B?YTV0cEVRbGdNWmtLaWkyeEIwUXZNbWFJWmZkOUs0L2M4c2dkczdHMjhvbjdX?=
 =?utf-8?B?VGRrQ29mbENNYktBVFF6TVZmZkhoSjgvWkNaNXpzWGFra2o5Q3c2VWRTV0to?=
 =?utf-8?B?TGlLblhVRmI5WWsrTHpEUGUxN05uaTg4ZDNYMVNzeFNtVjJWTG1kNHB0TGR2?=
 =?utf-8?B?Zm1SQ2dxTFBnZnZkeUNPZjBZTFVqSlplQnI5dGFKR1hwZmFlUDV1a1lWK0xC?=
 =?utf-8?B?bUY4YU41S1ptMmxqNUtDVU5GWktUOUFnZ09tcXY2Vy9pOVozUldvZzBtUGlp?=
 =?utf-8?B?WG52SDd2czJvaWN6cDAvQlNyZkhRb3FYbWVxdURYaisrK1NCaHhucERscUdu?=
 =?utf-8?B?N0pyckt0ZEE4UmFFVFpSMEczYjNweGIwQ0lzSDRQcHg4UnB0aVFmTUIyYmNx?=
 =?utf-8?B?S0hjcGRneWp1bjd6MHRNMm5NVGNuVTBXWFBlN1ZxNUdUSGxqYWlFdVBWWEFG?=
 =?utf-8?B?eklVbEZ3UE5Nc3hIVzE0QXIzUGVwcTYvQVBUM0lsZlNjNHhnc3V0aGRjdzhG?=
 =?utf-8?B?dElJSlBYK0hoWjF5STFMTmRXRTR0U2g5M2FVcjQ5ZXFFWlhhWW9VbHZxai9P?=
 =?utf-8?B?akpMVER3aldwV3d3Rm5MWWlHNEMwWUZuMnlzd2NacVREYXJVY2xIMzVuVU1i?=
 =?utf-8?B?YzRlUEZMaTErSWVEVjlaVjk1TEJkTG52R25HKzM5WlpFd3BCYkVQODViL2pL?=
 =?utf-8?B?NWUvMVlZczFiSUFCS2ppdHg5U1I1WnVkcEhSeEpUaVVwelZUcTFNcHB0SVFr?=
 =?utf-8?B?TTUyNWhlTUFKQUJDSGt2dWxhMEhIdHd3Sk5VSU9nYWh4djBOYlZ0SWkwL0JS?=
 =?utf-8?B?RlQwbUUvZGRTWHQyRzNYU1YvbFAyMWFoY20wMUZ5aEhJWmRhcmdNWjltT2U4?=
 =?utf-8?Q?Nu6eZNnJy7LNKw+jDEuHVnXQj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0d9f4f-15f3-4a89-01e1-08dd4f206aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 06:58:00.3125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rW2Fo22UR4coo18FyMxcLTFwsckt3463bYQ+tHiIucFbQ04FFCnCfCx5ed91fXU2sm4CeC9hjFFIP1Kupi70jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7344
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAw
MS8xNl0geDg2L21jZTogRG9uJ3QgcmVtb3ZlIHN5c2ZzIGlmIHRocmVzaG9sZGluZyBzeXNmcw0K
PiBpbml0IGZhaWxzDQo+IA0KPiBDdXJyZW50bHksIHRoZSBNQ0Ugc3Vic3lzdGVtIHN5c2ZzIGlu
dGVyZmFjZSB3aWxsIGJlIHJlbW92ZWQgaWYgdGhlDQo+IHRocmVzaG9sZGluZyBzeXNmcyBpbnRl
cmZhY2UgZmFpbHMgdG8gYmUgY3JlYXRlZC4gQSBjb21tb24gZmFpbHVyZSBpcyBkdWUgdG8NCj4g
bmV3IE1DQSBiYW5rIHR5cGVzIHRoYXQgYXJlIG5vdCByZWNvZ25pemVkIGFuZCBkb24ndCBoYXZl
IGEgc2hvcnQgbmFtZQ0KPiBzZXQuDQo+IA0KPiBUaGUgTUNBIHRocmVzaG9sZGluZyBmZWF0dXJl
IGlzIG9wdGlvbmFsIGFuZCBzaG91bGQgbm90IGJyZWFrIHRoZSBjb21tb24NCj4gTUNFIHN5c2Zz
IGludGVyZmFjZS4gQWxzbywgbmV3IE1DQSBiYW5rIHR5cGVzIGFyZSBvY2Nhc2lvbmFsbHkgaW50
cm9kdWNlZCwNCj4gYW5kIHVwZGF0ZXMgd2lsbCBiZSBuZWVkZWQgdG8gcmVjb2duaXplIHRoZW0u
IEJ1dCBsaWtld2lzZSwgdGhpcyBzaG91bGQgbm90DQo+IGJyZWFrIHRoZSBjb21tb24gc3lzZnMg
aW50ZXJmYWNlLg0KPiANCj4gS2VlcCB0aGUgTUNFIHN5c2ZzIGludGVyZmFjZSByZWdhcmRsZXNz
IG9mIHRoZSBzdGF0dXMgb2YgdGhlIHRocmVzaG9sZGluZyBzeXNmcw0KPiBpbnRlcmZhY2UuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNCkxHVE0uDQogICAgUmV2aWV3ZWQtYnk6
IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0K

