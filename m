Return-Path: <linux-edac+bounces-2154-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B819A4BDE
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DA5282F92
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3451D7E31;
	Sat, 19 Oct 2024 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHutU3e1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9C1CC890;
	Sat, 19 Oct 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729323614; cv=fail; b=Xg2r9/1YtoCBUoFytgLweoESUgpAOjj/jeVJ2Pg8VGqFiy74GOpIOWGvto4F+q40CXg8tcOkvUECTN6a/B7FCx9Gkp+/K9tWvqNeWLGhvHg2FzZgIzRAGjP1V47QPMQJLp/dF2FjQLoieIZClz5+PAv7t8Zp1jqcKPyOmPSqmkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729323614; c=relaxed/simple;
	bh=WqEZFeHZhjz+awB1Rt9zw9OSYsjx4zTrmepdGCa55/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oSGzyDruQKEnlj10mtp8TVVoNqiJ0kAHAetZhItPO4DjC2dsxrKdIfEAavSfnpuxwKrpcTaSYrAcklvfPrJ+dKINxVLwJTp/iTlutdbwLsvqmZ5PfKKJJmj2LD2T0TvxvMSArHv9FPDwgvyudMHgNFaeMit4hUE4YUGVLntzgko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHutU3e1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729323613; x=1760859613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqEZFeHZhjz+awB1Rt9zw9OSYsjx4zTrmepdGCa55/8=;
  b=lHutU3e1wZW/zClZC/s5clVOZb44AtS5o/wbHt9LsnKCMFq7bC6fOJAH
   O/H0tgw8sP2yzTEOW/t1t7msEPRcPK6IvldQWtJoejpIbpSullESpf7kZ
   vX7+EEdCjjeDnMoVmPQm/OfdFkDilv58AjRCzzA5XrgqZzabE6tZ9b9O2
   RGkp7oxfEqmvyM4+8FyzgsDTHpDdEXO03E6qr2BI41bIqcWBz+LD7Vzgf
   Q5ozdRF/6nIfNCKLYaOn26a5fjt2TrQeiIYJpQng52JCA1I9fBPebvOZm
   feyZAPKymm9YpF/eXRCu3jMlVHzwwztdiAetzsuC06VYw0jXjF3Qplde/
   g==;
X-CSE-ConnectionGUID: V5kjLsdESAqMioPIOonHfA==
X-CSE-MsgGUID: K6euaB96QfaCcYCkZszheA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51405314"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51405314"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 00:40:12 -0700
X-CSE-ConnectionGUID: HGTZ8wqlSf6+eD7ykdD6rw==
X-CSE-MsgGUID: ypXaAZTaTzSDQ6IekKUPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="79031315"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2024 00:40:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 00:40:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 00:40:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 19 Oct 2024 00:40:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 19 Oct 2024 00:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzEAMKNECcflOwpZ51YCMo5J2NTWgLZ+dqY2icw2aS3inAF4iY1Yq0AySYD94jrdOg0154zuFq9LPZZnI/gyYKqUaFZ0Y5Jchcz3Fx4lNd1X3hzoBmkSYVnTEZz6ccyNe1NG2WxljO67Ic8XvrsLc/MntOHlX9PNsUogPr1QCr0qSRAV8TCyhBqFcy0JakwqrobEIrS2gvBOobN1/PpC47SLaFqocMAlYAvBJyCWvQFhSLs0zRaU9KPxWedkEozskMNYHZP7MDYvIa3dFPxg7LKwHi1k7lTCbr1ZJzqcbzCNFflP7oNPdK5jxOe6EatrolNnEZcQ4Pua7db+iUzZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqEZFeHZhjz+awB1Rt9zw9OSYsjx4zTrmepdGCa55/8=;
 b=C8q6ndLTBms/eIVH0Ce8LM5TVOl/tsSDzV5qLKHBxubVcDzbmBm+0hY8D64HAeLqzTzBQJ1EU13ezv0qBTpFU9nSUIRNQTxfSlKeVkFeCMDAv47IJytfO2IR7lSkpRLRhKY87IDhafEOCMhyp3rFZu7rudCJuhLAz7orU89r2fNzDN1u3uUcE1VYFMaolirXiHwgE9ubx/AYPR0Zsx7L9mSv/6u+7rdt6L5bnev9EO/6xpZnH3EkP/RRuhhYVFy+3pfwdSMKUFVltWQcTHZzLC78J7/f5seTTqv70dvnvhPOzSoscNyvXaCJCijePpDF8+XvyvXVG2nf2EDZoRHQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Sat, 19 Oct
 2024 07:40:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 07:40:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/10] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
Thread-Topic: [PATCH v2 09/10] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
Thread-Index: AQHbH8qaudskS8oGJU28Wq9p+RTGXLKM+q4AgAC5MYA=
Date: Sat, 19 Oct 2024 07:40:03 +0000
Message-ID: <CY8PR11MB713462FCF6A2B75C785C39F089412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-10-qiuxu.zhuo@intel.com>
 <9097a674-4525-4bec-a502-65d3977e1647@intel.com>
In-Reply-To: <9097a674-4525-4bec-a502-65d3977e1647@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN0PR11MB6136:EE_
x-ms-office365-filtering-correlation-id: 961ca239-5650-430a-6599-08dcf0113e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0xOb3dXTiszVUVya3BSWWZLSDNHTmZvZW1YYTNQL0xSLytpbjJwRmYyQ0NZ?=
 =?utf-8?B?QzlsZExKS0tzV0lTcktLeW4rck9rQmFMay9walZIU0VJZnhaakhlcHZCblN0?=
 =?utf-8?B?b3Y3SloyRHh6OXAxeksrNjRvYjNwRWNJandXMmRyeHY3SnpKb3Axc0I3N0dn?=
 =?utf-8?B?TGJvZzlXaG9PQXhFZ1gxOXFCbVpCUy9NVXgrTWt1Ny8wSGVoeWRkMGxLQ1d5?=
 =?utf-8?B?dkxoZ29pU0l2TFYzeTFuOW5aWEE0bjlOajVMc25Zc2tYQ0FkRk0vQm1EcjJu?=
 =?utf-8?B?dHpzbkg5c3dLQ3h2dytZVWNsQ1hIRnBLSm1LcE0vdTIyQUlKVVdpM0VQalV3?=
 =?utf-8?B?OU5rY2J4SDBYNUUyUWdqR0NqTFJUMzdGOWFGZThHRVpOV0wzM01oKzBFL1Jv?=
 =?utf-8?B?YTc3a3BEaEZjVlVhL2haNmQrWUNrRG1zY3FML3dCV3RpU1cyc2FGdm9ZdmdM?=
 =?utf-8?B?dXZLM2hJa0JwWDhCSHE1ZUZmLzQ2UjVDS1pEZnNjL2NuTmx1K0tXSVlYaEt3?=
 =?utf-8?B?RFJWQkUzMXJxeitySERVZnA2dDE5SXk3a01kUEFQNmg5N2xPNGhCWSszTnZZ?=
 =?utf-8?B?VlEvclg4MlZrcjZqdEZVSWJKWmdHNWF4bXhQVzk0MVV2a0NTVnR2eUtxajdi?=
 =?utf-8?B?OTVLakpjVWFTVi9VUG1UYm53TVRxVE5rUW9UdzQ3ckNrdzlPaDBOSkJoY3ZR?=
 =?utf-8?B?QnVRZ2x4Zkc2Wmx2bmZzck5CTEVaeTdqczRQMmluOHMrOTVzQ2taQ3hQejBu?=
 =?utf-8?B?KzB1VFY0eklXcm5mdWtWeWtHVmZLQ1FVOE9RcUYrYjZGR2dSL2pTTW1ZNUhh?=
 =?utf-8?B?VzRSUjgvV2lZQm95ZnFldHhTMmF5Yjltci9vUk1wVGYraFlHanVLTkczeFNk?=
 =?utf-8?B?MHRuNS95MXhGTnJCbFZoMlIrN1pNdStEamZ2ODdZNXZlTWJSUGVEekRqMWpR?=
 =?utf-8?B?K3R2K1ZPRVB5Ty95NnR3U3lyL042WGMxQS92U3ROM1B2UUZ1blRnYklIVGJN?=
 =?utf-8?B?UVllcjl0L0VFaHV4VTZZZkg1dXMxMU5yOWtWSnBiN3hzdERQb05VejFKMWtV?=
 =?utf-8?B?T1kybWpJZkFQVkRoUkp1RzdGSGZhUUJ6UlB2UWlFL1MwMy9oZVFXcXhET29X?=
 =?utf-8?B?OGpISUgzT2x4NWh0SXUzSmZNMWlyK2E2KzRFTytkK3BIdmtYOWpmUWtYNkE1?=
 =?utf-8?B?TDYzUnQ0R25BZnFFUVZqRk9NVnkvNGFwdk5rZ3NuN3o4YWRyRjVNajJGWHZT?=
 =?utf-8?B?dzdJSldMNGhPWlRaMmZPd01vSEJ5aWtnQWpJemZualRrbW9pVHdmM25nNnBi?=
 =?utf-8?B?MWVnM2xQOFdCMUU5UFBwZ3JValVjTDgzeHJtTWNpWnNEaGdzM2dsSGdlZXQr?=
 =?utf-8?B?QjZoWVNGTEp2N3U4Q3YvRFFaVmNWNTdlb1B4ZXh3VWlpWnVZUWNyNHExbnFY?=
 =?utf-8?B?U1lmR3BrMlFzLzgzSEVqQksySEYwN09DTjE0M3hVQi9OZ1R1YitPczhQOHJH?=
 =?utf-8?B?UGJmU3dWUGlKbGFGcUl1WVpwT29IenM3UTdlODBCQVh5VE5BdU10ZDhWZXJJ?=
 =?utf-8?B?UHJPcFE1WVJLZXQyejNHd1VGVTEvNXdqK0g3Y3hoVFh0Vk15U3lyVUFDbHl0?=
 =?utf-8?B?OUVLYXRjT1p5RVE5YTNOSlVxYTkycjZzb0QxVGJKaytybDJheVF0TlpvdGNE?=
 =?utf-8?B?S20yVFo4VEZjYk5DN094dVpuOWVzMG9RUnhSeTViY29rdG5LS2NvQU10YllY?=
 =?utf-8?B?VU40eE5qcTJWNjlrY004RE5zZitvT3NpWVVrZ2E5UzZuM2syWFEwRjdYVzBT?=
 =?utf-8?Q?O1CURl20T93rRwv/yeQz919cUl5ObEXRcOptE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNFa2xCcmNqdmZXMnVvdWhPQjUrdVVXdVh6Zmd2MFZKN05DRm93VFhWYTZE?=
 =?utf-8?B?aHBvUVEvNFlrZkFOdHNkODBUWnI0aWNGR3h4dVA5UmoxVDF3R1AwOUtXMDVn?=
 =?utf-8?B?b2o3b1ZzWWxrVnpTQjJmQWxpNGxrMWVVVEJOUjlIYVorQkt5N0lIcDI0UkEw?=
 =?utf-8?B?VzFDZ2hRN3lKV0tzMG4wVElZNTJIbEtlUHIwT3pHV29NajA4c3B6amN4RHpo?=
 =?utf-8?B?RFlUdXdrOFphVzhhb3phWlJGL05RdndRRzduSDF1Ym1ZLzZIVzd5Tlltby9X?=
 =?utf-8?B?MkxRT21qOHAyU09OTjJIejlVdFBMUVk0elNNcUJEYzdRNkxha0U0RGRGY2hv?=
 =?utf-8?B?eWdrQWxCUnA5VXF4QXZaRmtaUzNkMVR6Tjc1dVoxWVVvZUxKb2g1VXhyb1Jq?=
 =?utf-8?B?WjNJU01EK3F5U1U0WnIyVlNXdmNQWUFPclcxNFdHei9DVDU3N2xqdm9tUUxB?=
 =?utf-8?B?SkpMNFNHTUk5Q0FzSFlVMVVQQlptNU9hbWlPU0JnQ25KYVdJTHVDS2ZkNlF2?=
 =?utf-8?B?c0xNbXpEMEJJckY0bDhHM1VaWTNkWGhJajF4ekVIM1VXcGh1Njlod05BOVFB?=
 =?utf-8?B?KzZya1BKRjVGektQWDk1VGRFRzh0ZU8vc3JrVzh2Y3gwSmgxaHRCZURHUTRK?=
 =?utf-8?B?SE94TTVDSTJwVWhtQktQR2ZDZkJ6ZHNCOUlUTXBhaDkxaHpPM2w0aEdoL01T?=
 =?utf-8?B?WDJlTXdTTk50VlIwNGxqVzRWRDNMclh6SjNmMXJEZnk5TzlBZDBDVFRuT2s2?=
 =?utf-8?B?bmI3SXZEOE02RXhOOHNDRktPUnk4ZHhRQVF4TmZITkVFNnZVUFhkMkZHc1h3?=
 =?utf-8?B?djB5eit5alhrTWZEQWFUYitOVSt6aGV1bXVIMU9UbVJKMWZwNG93SXZ0T3pD?=
 =?utf-8?B?amsxcEZWMmtsbUp1dVl4aHRYdEdmZHpLVE1ibDB2Sml1amZjOTlCdW50Mkkz?=
 =?utf-8?B?R3lPQktES2RxaWdQdUxxZHJQdHRZaklieThLNWluTlRFSXBZRkxZNWwzYXlk?=
 =?utf-8?B?aUpQUHdvV3dyaUhmZmFnWlI4M0RuWjZzTkVMd3d2cklZb0l6bFg1a29oNkJt?=
 =?utf-8?B?VEVXZmM0bVZURW8xeEJLa0lzTEpKWlFPYnBOVmVHdTVNR1lzR09sdWp1NE5y?=
 =?utf-8?B?aW5GWXVjaFVzQktuaWVFTk1vL0pUemxNb0NjaS9GVVFPdlFBK0FmeU44NDNh?=
 =?utf-8?B?WVVZZlplUVBrMTZwRjZzVE5GdVlTL2Q0TC85Q3NMQXdhTUU0ZytjRXhrSUZG?=
 =?utf-8?B?c1BHWUVqcWlyOUk1K29EeUR1dGZwTUpnNEUzdWk1ZldQT2YxSXF3NlFTR1Yv?=
 =?utf-8?B?Z1pkMXYwcThMeFY5TnVXSm01ay9EQlVjZVVQcm8zYnJhMXNpT045bWpoTGlp?=
 =?utf-8?B?eG9vM0RoQ1o3K3o1ckl1ODZ2cGxaVzdra1ZMMmVMcWhnalBYaVd6TXo1SFY1?=
 =?utf-8?B?bzJERDhnQ043RXZSRkZXRU00MGpqSll5bTBoRnNGYmRtQ1Q2WTlEai9UdWZI?=
 =?utf-8?B?K3BhUUlZWEEvT1QyVlU2YkREdlA0TVJxRUhLeEJRSGFZaWFycER4dmJNS0FQ?=
 =?utf-8?B?N09SWjZxb29RV3FoVThwdDBZZmRubmNOVkJFdml2cUZaVE80UnkyQjZWWngy?=
 =?utf-8?B?UmVRbVV5ZGJxWXhkVzFBUWNid0wvVlpka0c4bTlJTzBTOVJQSUNsSG9PdFVq?=
 =?utf-8?B?TXlybXl3V2hmN3NQTGFqeFYvYmZuallLeVpGVnBDR1lQQlN5RjlXL1Y0OXZr?=
 =?utf-8?B?OTVzTFd3SUFOSTJwWDRsZXZVOUwvSTNMN1Z2V2Jyc0lJRE9Qb1ZmYlpidU1I?=
 =?utf-8?B?NzNabC9YblVVRnRLdHZMQ3hNR1Y4V0NTQ0FnYWZGQjlkOVBQMUMvYUZkOWNx?=
 =?utf-8?B?Q20yY2pxTkdjaEc5UDFCbHZVV0ZVNFFkejcxQjcvZ1BZSERLYmwzQjlrT0Qx?=
 =?utf-8?B?ZUVZdEVvNmRCMjBhM1I2ekRaQzBWZXIwaXFHc0JBZ3BPS294cW5OVG9TcTNR?=
 =?utf-8?B?enVEaEtKYi8yNTNxWXQ2dXVTdUhEMVhWYzZKbkpOYXJkZXBMSnk3SGNNNEdM?=
 =?utf-8?B?R05rWm8zK3NSdWM3Tm1iVVZyYjRxSm1SQ2ZlWGFRZzZLcGx3bUs4c25VckN0?=
 =?utf-8?Q?VWJuHangnohBs+sxXwMBvgeiw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 961ca239-5650-430a-6599-08dcf0113e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 07:40:03.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGvYFEONIS1DTIB+XflaFBKA+RHqmBgOhRoCQVyrMXwPrDRO2JPKXrHIHdwLKL65AvhfbLaIizM/GSpNI39LWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
X-OriginatorOrg: intel.com

PiBGcm9tOiBNZWh0YSwgU29oaWwgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8xMF0geDg2L21jZS9hbWQ6IFJlbW92ZSB1bm5lY2Vz
c2FyeSBOVUxMDQo+IHBvaW50ZXIgaW5pdGlhbGl6YXRpb25zDQo+IA0KPiBPbiAxMC8xNi8yMDI0
IDU6MzAgQU0sIFFpdXh1IFpodW8gd3JvdGU6DQo+ID4gQXMgdGhlIHZhcmlhYmxlcyB7cG9zLCB0
bXAsIGJsb2NrLCBmaXJzdF9ibG9ja30gYXJlIGFsbCBpbml0aWFsaXplZA0KPiANCj4gVGhpcyBs
ZXZlbCBvZiBkZXRhaWwgaXMgZ2VuZXJhbGx5IG5vdCBuZWVkZWQgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlLiBJIHdvdWxkDQo+IHJhdGhlciBqdXN0IHNraXAgdGhlIHt9IGJyYWNrZXRzIGFsdG9nZXRo
ZXIuDQoNCk9LLiBJJ2xsIHRha2UgeW91ciBzdWdnZXN0aW9uIGludG8gYWNjb3VudCBpbiB0aGUg
bmV4dCB2ZXJzaW9uLg0KDQotUWl1eHUNCg0K

