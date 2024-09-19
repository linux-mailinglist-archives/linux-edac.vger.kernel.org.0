Return-Path: <linux-edac+bounces-1890-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C097C62E
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C29D1C212F6
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44601991B8;
	Thu, 19 Sep 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfGcLfwV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194A16D30B;
	Thu, 19 Sep 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735682; cv=fail; b=XmwspLDKIoP6qMizck1VmiJlD7aJiKXg/m/5ujh9mkaYxx55hd8ojo73TJwEWlhMllEoRmsWnYEIznmsaAq6R9VSEZz3+UUG7wrfijGe1pbdQEcaNLa+EWvHxYy81fXFpbCvLarcBVA/XvOcKckKMHGIuEWXVF5aITxjSUn1Lz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735682; c=relaxed/simple;
	bh=gVp9ZhEHLaY6BqJy2lI/koaWU/ACoCfZi5OsgPq4DkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+rFUs/iTgsbky6YZ5VMSOheb/J0yHpbvJAZuQgBeXFg4rbuwgFd8a/QqpHVwYMbeU15EYZPwLgLtlUtLqQHYaJxyTkgl67xqofTml9MDG7FfvGaPaSct7YbqRU7yzFMoN1H2DaxuzwCY7bgtiDgz6jHCQPQO6Xut/ZUbu+OkeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfGcLfwV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726735681; x=1758271681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gVp9ZhEHLaY6BqJy2lI/koaWU/ACoCfZi5OsgPq4DkQ=;
  b=hfGcLfwVNTgWo1YssmA99N1pO64emtTkfpM9aX7/thbYGQbGOMLmaDL4
   r/zUMXk46bSM+uDFicO/IzDzsvWr5KpODrsu0SM0ESyz/0oSfbSmKoNqy
   lK0vxGoOuAYwGg9W9w9ZY8dLDUYmHRw99dEjHO9uQCHroMmxRkiUo+MuS
   rdHMaxXwDv/N5qmFjcb500vlEJAJun5wc3pDJ6LYlF3gOjA0eLo5uwjAG
   iJwpnEmpGpmmeMVXkxRbune9jlbvrZKv+5MgIThrOq0Q4L9jJYqiGx5gP
   GugBU1C5F73Wu+Idyg7R3SD+13xjGuYudn8kt9gNeK+gqWSIdc//CCzwu
   Q==;
X-CSE-ConnectionGUID: Jqk8fMBjTOCPk76UElasbg==
X-CSE-MsgGUID: 7zWY+VQmRy+1OcgoY7Nfzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29475543"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="29475543"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 01:47:50 -0700
X-CSE-ConnectionGUID: ZC3y7awBRGCvVgzQLWIVLQ==
X-CSE-MsgGUID: UVkXPRgGRa233UtjBL4Tnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="69895595"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 01:47:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 01:47:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 01:47:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 01:47:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 01:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOhu9mV8Wkg0JyDW1Q7KPJ98RuM84jYX5hKu7VsVJauMJLgOrDYzY/+vWiZqrk7oE65xB4+czH83ZxzmQOCGIYvYf5w9qvX633lBV45hc3CMRP+nqEWyhchYWfNrAf1PS/tTnYxqf7v4ueH0wIUzuMo4vpLje4+nHAVQZ58HAzUAbXubgQH/HMWoxFpsnB3kxS4LbND0lrNbBJmlwouvg4lr4HqdAXLpaQWknM+U3DJzfHSCjts0Wk7Y+hVwm6KFqlHx8bVU3umx95vRncBq0AaQGgyRs4XtNOayYagNGbd8VWZmSVG3L6jSUcxFwLMKSreOeguRAfwIMmObGMPFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVp9ZhEHLaY6BqJy2lI/koaWU/ACoCfZi5OsgPq4DkQ=;
 b=jIPAjsdHOKxWv5zYydJyByEeCuQNB6lJ6z6vozJXzwqsTMAKHDvraAb7ZAdFVaYUqvJ2AqI5daC2IC8gM1jbBBjaCK4mJhtG4bUd8cbQP7yMNbMohVWfXsMKPPwHlH4pD+odR6JypuTHYWm4ap+Vi6zI00oqxJXReO/TuFleIV0F95IZU7wDU3sJC9LhAPOlRiBdQbPxVaazUsilk8h4Kvdt+2L4khnHuR1jc+BBoQRfucV/DRIl69e+NisWIX+nH2Z/yMH3oPWW3jA4Ej/29VNIIBPHHEsQs/maVrPf00QLIXpYuDlGPxTrQuIhOQVaIp0g3z0/zTolwT2bxSor2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 08:47:46 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 08:47:46 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, "Luck, Tony"
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] EDAC, pnd2: Make read-only const array intlv static
Thread-Topic: [PATCH][next] EDAC, pnd2: Make read-only const array intlv
 static
Thread-Index: AQHbBRYqpilgHw9ZJkOa+CqFj5nF5bJevGKwgAAKBACAAA8CgA==
Date: Thu, 19 Sep 2024 08:47:46 +0000
Message-ID: <CY8PR11MB7134A87E8FA174CED8E144A089632@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240912131730.588673-1-colin.i.king@gmail.com>
 <CY8PR11MB7134F6951DFF67FDED364FB889632@CY8PR11MB7134.namprd11.prod.outlook.com>
 <351a69eb-bdad-46ff-aa8b-ad156de10249@gmail.com>
In-Reply-To: <351a69eb-bdad-46ff-aa8b-ad156de10249@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN6PR11MB8241:EE_
x-ms-office365-filtering-correlation-id: 6c249276-bfdd-48ea-dfd0-08dcd887bbf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blVMM1ZCSEVDUG9VOG1odXR1SDJLelFhbTlzRHgySkVXcjIwZTBHa1hGaEdn?=
 =?utf-8?B?NjNSOXI2S2VLNjlidEdNTEVrVHBRVWt0M1RJaWNhSUYvYjZTb050VXdUTDVp?=
 =?utf-8?B?bFNTL2JxUWRPS2Z0dUFGalZ5NThTWkN3S25EbEszekFyY3V2dG5ZNWJkUmhR?=
 =?utf-8?B?b01BTXRUbXIyckhXUWhuOXRobmxrT0pMd2FSNENPSGlTaGxnRUIremZvRnJh?=
 =?utf-8?B?VVEzSGRmVEtCSkJWRU5BRVpvK1BicTdxbS82KzF5VXdBRnJxbDdja0g0YnVM?=
 =?utf-8?B?Zzk1OFlFMWNJa0MyVmppSmpuQ1hhS0F2VFdMQjBhR0dlZ2dwT3A2cEZDUGdT?=
 =?utf-8?B?MnlOc0lBaytMQlk5Q0lKRDdheVdIbGhidFdlVVUvcDNYRkExNkZsMXU4SktD?=
 =?utf-8?B?cWlldHBROXlaMGw5VGtQbmlBcGNUdEZsR3VqRHlwcVpiUjkyWk5xb1BpN21q?=
 =?utf-8?B?Ni94WjNpUTM1M1kzd1l5eDBvcS9QTDBLOHdiYVliNnR3UnlBUFRtVWJOdkZ0?=
 =?utf-8?B?bVladDZQVFVHTTEvazIvMWIxRXNLbXJMU3BLYTF3ODRVQXZyMXRFazVEMHFh?=
 =?utf-8?B?d3F5dEppblNaejc0MG84NCtvS0c2aW84R2ltNS9TamNOZzZmOUgxQjd0NVlJ?=
 =?utf-8?B?UHFPZ3gzR0kzMm5teTBtQWRmZHQ1YUtsR3E1YXZuRVg1WnVFbDZHYmNuVVEx?=
 =?utf-8?B?eCtCRHR0WFRZeTZYTWVhQmYvUGZKS25QNU0wZjdOK1FYZGVVZlMrdTgwV1Jq?=
 =?utf-8?B?ZFc2UUhJOU9tdnhBSVljNU1mR1BGbnB1ekFUcjFqazVkeGxMaWtVakdmak1k?=
 =?utf-8?B?eHBtZ0Y3UHh5MXBjZ2NWMERSZDZBaVVFcGw1RllHeUZ6RzNXbE5NK3RtWUFi?=
 =?utf-8?B?TUYwRFU5SHJDalF3bTFwZTQwbEFQSTJsQ1VvZGo2WVJQa0NIVmk4c3VRZ3la?=
 =?utf-8?B?U3ArVWhQR2g3WlJMdi8xRnZ0Rk5nU2NIamNRbVRUdWNjNVIzSTM3NzV3Wks5?=
 =?utf-8?B?TEhWUzduQkdKN2VRWENkR2JSbWpqVndtWHdyZGZjdURYb0ZwemtYNk5ETTJX?=
 =?utf-8?B?Z1E0MmNTZEJFblZBTXUyaWNrMG1oUWN6V2dEYThnclltbSs1a1BIck5hNlNM?=
 =?utf-8?B?VVZhS0ZjRkoxRThXRUZlbnZoUnNDRkI2M1pQR0VETlFNT1hFOFI4ZzQwL1F6?=
 =?utf-8?B?YWxTT2NZY2FWT2ZBellwTjNweDA3cVdjL3B3eWlBbERBSVR4b0hqbHlRdGdt?=
 =?utf-8?B?MTRqNTdDWFJHek93emRXUHkzREpBdHNDd1NBbkE0V0hQa3h0SVBGZTFWYkFZ?=
 =?utf-8?B?eWxBelJvR1gwbEJXeXp3ZTI4VFNIa3lwdUpSVXJyejBDc09TRVVKRjJEU29v?=
 =?utf-8?B?MzJYMDlHSXN1OWc4ZnE2ZDZ0clBjejUwYkZkQytKelBBNlp2Slo0ZTNyMWp2?=
 =?utf-8?B?cjdkVXFnbXBreVNRUi9oaGhURHFzSFgzQXJFbERSV3FWbzh5aVd6SS96Vndq?=
 =?utf-8?B?Z0t5eTU0R0JkSVpna0tueUZUb2Z6cXZjZWlhTTRQb3FtM3dBTGtJRjd5T21R?=
 =?utf-8?B?dmZwazBOWU5Zc2ZpZC82NkYrcy9jN1NPakdGNUFaT0lzSk05d0hJbkh4ZnBV?=
 =?utf-8?B?NG0yVitkM1RhNVZLK1UvTEpwWFRpY2J4VVh5bVRJTytuekpxZjFGcE1EQkFR?=
 =?utf-8?B?eERUbWdFWjVLK2UrMGtKbG5nTEloZ0F1bEx0L0d2M0lQd1l1cU01N3ZlZVNj?=
 =?utf-8?B?SWxLVXp4cGVOc290b3lTdVRQVERpazJ1M2QvRmVGc1pDSlZaYWVmUEx2YWh4?=
 =?utf-8?B?dFVoUTV6UVZPdmlrVFBQZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFVQWmVFbGlHdXpBa3FxcXVlbEQyTWtzOE9ZYWkvUGdHOEZjWm13S09HMXVU?=
 =?utf-8?B?eVFRL2lBU3FCUHVSU1djUU8xMHlvWnR1M3JPa1NlQktjSGh2NnRwYWNVTllz?=
 =?utf-8?B?YXF4dkFnWWsxem5Sb0lheVlQZmFzeVpiVE55SUZiZUlNS1UyR0p3NkJpVDdu?=
 =?utf-8?B?VFc0cFNuV2Z1MXlFTEFGeGRQMUE5RlgyaE4zNnV4TGpmVVRiMFBhN0wrODFH?=
 =?utf-8?B?UTdtbU9MbjBvMWVKL1VGakY0RHNSTndNTERPOGVMZnpXM0V1MzdIZ2oyREt3?=
 =?utf-8?B?dXNiNDMxNnlCZDMrbWNHbEYwUU5rTVk4Wkw4UHdSVm9hMGpxN0FPZW1LeGVL?=
 =?utf-8?B?bVBydWhmTGlVVUZjeDd0KzhHclNMTmtGRk0wSm5icE1JTEt5aGY0RWF3MnVG?=
 =?utf-8?B?UnpwVVA1eUxmWXhPcm9aMzRTbnVVVkdKWVN1eEFDOXpQS25CZTY4WVJuaXFM?=
 =?utf-8?B?QTArSXB4eGdMNmRQckdPOHNMcXdkalpnZ1Nua0pHL1FHMFM0RTR4OUc2Qld0?=
 =?utf-8?B?SVdoWkdJaTRKUG1hMlNHL2FLUGNQb3ZFVjN4SzErMGcrK09RdFQvUU9vMmZj?=
 =?utf-8?B?UzFGNGtJL2IrNjV6YlRSRURDamRzN1ZDMFRiWk0rTlhqTG43YTFDNk93cUxG?=
 =?utf-8?B?OURKT3RRSGVXMW54QTluZVJCVkhrM2ErNzB6QkNhaUNqRjk3bFdIY1JncnRZ?=
 =?utf-8?B?cmpjb2xOUDA2RGhnWW9DeEtQVXprQnE0cjVxV3U5aUhOM29uUUNFNHQyaWh6?=
 =?utf-8?B?RC9ZUXpqbDBodEo1MWpNSHVFNm1jckdKVjZOMm9XdnlNaWFjdFRFVHhnOVMx?=
 =?utf-8?B?WWxwaC83TVhQUVdIQkZrNGluY1hkMmRyRVgrNTZxNndSMzFjSXkzbHZLWmpC?=
 =?utf-8?B?NitJSVQzMFh6d3hlWWd2d3VSU3dyYkFWRmMvUzVQNGlFZ1NrTmRFakQ4SnJD?=
 =?utf-8?B?aEpFaFZhalBSYmZkRnIrRGVxV0x4MGRkYzBlWDVQaG5PMUVsZExMUjNuS0F3?=
 =?utf-8?B?V3FHQVFMdUJzQy9rU01XdnBYRndkYlMwd2dvRFZQcm5iOXNBRUZBT2NNa3o4?=
 =?utf-8?B?aEQvVmlSSmlidUlRNWo0cnBvZitDZWJlU3A3eFNJbzVCR0lzdUhlSXZ5TUxH?=
 =?utf-8?B?eFpCRklhOEU2TGxPY1RCWEs1N1Jha0lhTHQxL3FxSnZqODIxbXYwMlFHSVlZ?=
 =?utf-8?B?SWJuQVFkbENHbytCeWw3QkZjdXdPZTRFWDZ2UDRta0p4UGQ4cGhuVGJpOFpj?=
 =?utf-8?B?OUFzc2pvRGZNenB1eUdCdmhpelZNY0V0KzhISzlsSTVKTTc4blRmUVZYS2kx?=
 =?utf-8?B?UjBmU1FveHZzTWVPRFBrTkJmdkxTNUxjWVNvL3YvU1JtUnZNMFIwUzlLUUFH?=
 =?utf-8?B?TFFsYXBZYkZLYzJZTDU1NEZ4SlB0UDJkMThSaEh2V3pxQ1BrUFZpbXFoQ1NT?=
 =?utf-8?B?N3UzUDdpaDM4T21WRHQ4Q1M5UTlyRnpTWGpYOVcyaGovN25ZWCtTb3drWmtZ?=
 =?utf-8?B?bW1ING84UFJPUzJwMVpiU1Q1aWhEOFNlemFhcGF6aEtlLzYxOEh6c1Rjb2Yw?=
 =?utf-8?B?WDRzMDZhUUdIZzNUb3pTUkM5L2JZNS94TnhRVVpJaktaZno5YS90SHR0SHNC?=
 =?utf-8?B?VXFhT0VQZGRZMFdsdVBvYkZQU0h6OUtCRFpMUURWaFdTT01mSGdjR1dGTUpT?=
 =?utf-8?B?MS9LVkFRZkxpQXZ1ajJpSVlhK1d3bTk3SXE0U1pTUTlzeXBrdlpHV1N0QnYw?=
 =?utf-8?B?ZHQyZkt2RFNaSjV5WEs4d0lPWmNMazN0a3RzSGdBTk9BaVVYZHh0VHkxNkpo?=
 =?utf-8?B?Wjlmb2p0THE5S292eHR5T1ljYjE3ZGZhN2laSWc1NTIrWVo5SFcrTzZ3NVd5?=
 =?utf-8?B?RUFXaDBubjZkS29FZS9raFdMenk0ckYzb3lQd2RCdWRESWE0NnJCU045TlY4?=
 =?utf-8?B?VjBoT0JiZlhNQlh6RnhaQWhremJlQjdrOStRL1IrMFpYZ3l1d2ZwblNvRE55?=
 =?utf-8?B?VVJ1ZGlLZUVZUFkyVEQzY3NROVRUSVBEMVFDbThJejRBWDhYZzEwaXFDS0ZZ?=
 =?utf-8?B?TEUxWXJaNmNmZDE4Z3J6ZFlQN1VSUWtFNDBuREVTK3R5eFR5ZEV4ZVF3d240?=
 =?utf-8?Q?kgM21Z4VqTurOJpq5XJSQQMZS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c249276-bfdd-48ea-dfd0-08dcd887bbf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 08:47:46.4982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ys+hSsjNhfXCHyxR/iUmzI9NCT/9S6SzbUkyFEiAn2+9DdzFu+ZtmDel2OotM4xce/P8xrZ/XM1UKcNPPYu7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com

PiBGcm9tOiBDb2xpbiBLaW5nIChnbWFpbCkgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+IFsu
Li5dDQoNCj4gPj4gLQljb25zdCBpbnQgaW50bHZbXSA9IHsgMTAsIDExLCAxMiwgMTIgfTsNCj4g
Pj4gKwlzdGF0aWMgY29uc3QgaW50IGludGx2W10gPSB7IDEwLCAxMSwgMTIsIDEyIH07DQo+ID4+
DQo+ID4NCj4gPiBJIGRpZG4ndCBzZWUgdGhlIHdoeSBhbmQgdGhlIGJlbmVmaXRzIG9mIHRoZXNl
IGNoYW5nZXMuDQo+ID4gQ291bGQgeW91IGVsYWJvcmF0ZSBtb3JlPw0KPiANCj4gVGhlIG5vbi1j
b25zdCBjb25zdHJ1Y3Qgd2lsbCBnZW5lcmF0ZSBjb2RlIHRvIHB1dCB0aGUgYXJyYXkgb24gdGhl
IHN0YWNrIGFuZA0KDQpUeXBvPyANCnMvbm9uLWNvbnN0L25vbi1zdGF0aWMvDQoNCj4gdGhpcyBv
Y2N1cnMgb24gZWFjaCBjYWxsLCBzbyB0aGVyZSBpcyBhIHNtYWxsIGFtb3VudCBvZiBleHRyYSBv
YmplY3QgY29kZQ0KPiBvdmVyaGVhZCB0byBkbyB0aGlzIGF0IHJ1biB0aW1lLiBNYWtpbmcgaXQg
c3RhdGljIHdpbGwgcHV0IHRoZSBkYXRhIGludG8gYSBkYXRhDQo+IHNlY3Rpb24gc28gdGhlcmUg
aXMgcnVuLXRpbWUgcGVuYWx0eS4gU28gdGhpcyBjaGFuZ2UgcG90ZW50aWFsbHkgc2hyaW5rcyB0
aGUNCj4gb2JqZWN0IGNvZGUgYW5kIHJ1biB0aW1lIG92ZXJoZWFkIGEgdmVyeSBzbWFsbCBhbW91
bnQuDQo+IA0KDQpUaGFua3MhIA0KDQpBcyB0aGVzZSBhcmUgbm90IGluIGhvdCBwYXRocywgdGhl
cmUgc2hvdWxkIGJlIG5vIG1lYXN1cmFibGUgcGVyZm9ybWFuY2UgZGlmZmVyZW5jZS4gDQoNCkJ1
dCwgSSBkbyBzZWUgdGhhdCB0aGUgdGV4dCBzaXplIGlzIHJlZHVjZWQgYnkgMTIgYnl0ZXMgWzFd
IGFmdGVyIHRoZXNlIGNoYW5nZXMuDQpDb3VsZCB5b3UgYWRkIGEgc2hvcnQgZGVzY3JpcHRpb24g
b2YgdGhpcyBiZW5lZml0IGluIHRoZSBjb21taXQgbWVzc2FnZT8gDQpPdGhlciB0aGFuIHRoYXQs
DQoNCiAgICBSZXZpZXdlZC1ieTogUWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQoN
ClsxXSAkIHNpemUgcG5kMl9lZGFjLm8uKg0KDQogICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAgICAg
ZGVjICAgICBoZXggZmlsZW5hbWUNCiAgMTU2MzIgICAgIDI2NCAgICAxMzg0ICAgMTcyODAgICAg
NDM4MCBwbmQyX2VkYWMuby5uZXcNCiAgMTU2NDQgICAgIDI2NCAgICAxMzg0ICAgMTcyOTIgICAg
NDM4YyBwbmQyX2VkYWMuby5vbGQNCg0KLSBRaXV4dQ0K

