Return-Path: <linux-edac+bounces-2021-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B833C99B3C6
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3AD1F266B6
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD91B85CC;
	Sat, 12 Oct 2024 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NElQcdgc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355A1AB6FD;
	Sat, 12 Oct 2024 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732471; cv=fail; b=Pfa7CzFjQ+U80YX8TRykuLZRyzqwbU1bLmNGaFzW1/ywX0KjSGaydhTCbRxg7hnQlfu17+shRiAUiU4QOmXV/G3hRtgyEc3awt8yDSU9ATzEzv66sT+0DTYYOxNtrEa0mT1ngDOUPNi7h/ZABluK0Ob08wdaRW/wGS6DgRaUIok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732471; c=relaxed/simple;
	bh=qt/8TWhXbUJMKrQTaj5PlH6scW7KarjT0ieb4kZ/Zcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwDVTnh6e2EJGjdF+ckbS3c/TnErtWmnVhTpp1/Muo5uKdfGugkqRLYIjw1rKzspT+bVw4mELtNV3ytNv371XbRLcrlBlqRRSmXo6Sj4OcEtB5vEdi77KwevwOihdfaGXC+e/DfkpeSyabB0vIFz9BNuI/QaoPEOtQFFeGiI+uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NElQcdgc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728732470; x=1760268470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qt/8TWhXbUJMKrQTaj5PlH6scW7KarjT0ieb4kZ/Zcw=;
  b=NElQcdgcHTATvLvxwdYIMSPNm24aSBMayVG6+MCaemyFppxxcRtIfXMf
   q+y0NtjSdt1clADZloPCbV5l/+PNwIFOGrIawBlDUUS6IBiE6Jn2nWWST
   fEeSnhOA/+YFHNaI+OcvjK0o+WKOMYVYOmSfNjVgUhR0SVKRNQPZJToct
   HZdYlJHwWS1e2EY/BE2cvT3NA6qyGykNfBBWbvVi8P6rBPQa/sECHVCbz
   On23AX73V9BOwgKdARHWWL5PehQw4ejmXHF8GmQBRte9PKdQR0grZxZYV
   6d88kYqNB29unpUhAmoQYa38IkFpOzx+TFW62da4b6SSI7Rxsc5QnCthi
   A==;
X-CSE-ConnectionGUID: nyPGyvHLTGmn5s4M5h3X6g==
X-CSE-MsgGUID: K+Zna6tmQmS2yWukRoks5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45604588"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="45604588"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 04:27:49 -0700
X-CSE-ConnectionGUID: vLo5YNUMQVWRLbfJ+QK/6Q==
X-CSE-MsgGUID: Zr5/JQNsQj+KWBBjvH5+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="77458011"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2024 04:27:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 04:27:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 04:27:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 12 Oct 2024 04:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0hYbVYtdk55n+BO5ChdRNGLRsag4v17aqvggRGfMc+sDywYdVDSwqYfW5p9VzxFsCblFnHv8WGNvrkHD/yGETWUwoqVQbqyDhBUTVWHSOBSlI72Y7zeESRqPL3uuzVR0rzRdNhZfxAk1qGvjIdXM5usfLSh6cJM5p/ItYW7UUzk3Rtng8nfnREd2YHEl0hDP/JMZhlYzT6l2ZgDuBdj0ePonbaiCd35Uw73S0muI6zwlqBxgdOsxJ7eccTfOT0DGwlAZ+FlV0AHRLZd38GilqyYJpm17SkLcrrjwgQ388KNcXkOc40y6mP4mbpWVK9N3ntsw7nSAe2s6cGinK1gLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt/8TWhXbUJMKrQTaj5PlH6scW7KarjT0ieb4kZ/Zcw=;
 b=Iib4MJWHzaj+H0uZRpgh38z+4syttM5lsR78kbjI6yc8IA0DEq9skEl0mej/2DkK6v0Jw/bE5WGzuxFOCeUn/Fm2+HJVAxihzl7Xa0xtwZJugWcNWWPZyWjsT6Z1ZFAb3Rdfvh0ISUyHsGAipWuORRptZf96D1NX+9z6j3Fm1GKJ9qdWY2aPerJSHYqbNBy+r+THG1EJ09erY4Tf4Qe0SGpAPnkBV55SCz4pC0zQ2wJkddqA/Ya9MpIbWKc2JqzwVMJuarU+9VkaIUhT8H0szC7ddYykoPnHWTlm3NNV5GUdOj6HtDuypNh2jMRxXfhlaNkHWGAtYoEECPa/i0petQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sat, 12 Oct
 2024 11:27:46 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 11:27:45 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v4 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Thread-Topic: [PATCH v4 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Thread-Index: AQHbDYuMlBzIJKUlfk2Qfcrk3AxZR7KCwhyggAAuyICAACT0AA==
Date: Sat, 12 Oct 2024 11:27:45 +0000
Message-ID: <CY8PR11MB71348CE0BF3139D69169F9AF897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-4-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB7134431FEEF5A9EA6A7CD3E7897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <830f88fd-4f05-478e-aace-e6ca20413133@zhaoxin.com>
In-Reply-To: <830f88fd-4f05-478e-aace-e6ca20413133@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4649:EE_
x-ms-office365-filtering-correlation-id: c0263d9b-8d4b-406e-92cc-08dceab0e4fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXFmeUFEMnhFcWFydXFpbm9oNnByeWhHWFJUb05QNFE5QTRCeGNDeHFldjVI?=
 =?utf-8?B?Q3MzTWVZanl1ZzVmc2xyOEdnUitYOTErd21VT3diN0l6Qkg5U0JGR3JSd2Rw?=
 =?utf-8?B?aThXTHA0Q2RrWnNmTVpSY2FxRndxSlFsQi94TytUc0dsaFEvK0lnODZ4TC96?=
 =?utf-8?B?L2gyUjM2ekRuRGNoRWYwUEVZbklCMW1RQzJHblRFR3VhQ0ljZXZGYkx5S3li?=
 =?utf-8?B?YXplUnBCMXU1dkVpOVRRUHRsNFFFNE9TN21iYi9OTlhWK0NOK3Z1OHBIVnNI?=
 =?utf-8?B?SGJ3RXRmUDBBR3pOTjl4clhkNkZmSFVZUU14YUI0M3lxbXloVTY2TUhIM3V5?=
 =?utf-8?B?ZHNIM2VGcXhvVkxTcVNyMm91aEFJM3gvZW8ycU1XNzdFejRQMGxacDVBRmxt?=
 =?utf-8?B?a20vdzBNRDZWemVVSjV3bHhNYXZ3OE1OMW0yU3VGbTd1VEtNRDhXNGhCRHNK?=
 =?utf-8?B?R3g3cDlpbkd6WDAxTVpOZ1E1b1RJWmRNOXNJbGQya1MxT3BlcEx3bmxmT1pV?=
 =?utf-8?B?RERiYno0U1owbEpLdWR3TXFacXE1dnNjVVEyaWhobmdwK28zeTUrOHpTWG5o?=
 =?utf-8?B?YWtldmp4TnFXUzB6dWEyR1VHK0gzSnNoRmNzckxjNUUveGtycnZrdExUYUs1?=
 =?utf-8?B?SmVuUlU1RUxzTGxEYjJaUXVrY1hOb2Y5Qm1ybEtUaVJSZittUVJPTmZXcjQ2?=
 =?utf-8?B?Q21NKzZvOXRhei9Hei83TkFiL05tK2s3N2l4bzhmM1diSlhhQ21EaDZ3QVlz?=
 =?utf-8?B?Ui9xRXd0ZEoyczNiNEJ6ZkhoZVhGWkpETUpCUGdjQ0hlZnY0dkFyYW1IRGVH?=
 =?utf-8?B?NEdtUUhyZVU5TWlYYXNKcXIvaTR0Umwzand0WSs5cVd1RnFXdW9veGZJQ3dp?=
 =?utf-8?B?TVcrdVlSSlBja2kwc08rTnBHUVpPanNTNHY2dm8rNk9vUTRORzRuVjRhMUZh?=
 =?utf-8?B?WURVYWZVdks4ZitXbVptTmM1dmVnWEJNTHhBMUlGcTRDZDU1RmR5Zm9Cdkt5?=
 =?utf-8?B?MEY1MHh0ZktrT2NOVHhER1o2bGhpOUJOSFYwaGVNdThzZlY4N216eEtlUXdk?=
 =?utf-8?B?U0lDM1pLaHpHUlhWdjNLUUNZUFFVVExoOWcySTc2bjhtTGk3UDk1eWsvMVEr?=
 =?utf-8?B?V3pGUVNUM051alNXcVcvU3VsOXRzYjY0ZmxyNzlCekx3aFRUZ0RRNXVrK0hW?=
 =?utf-8?B?VzFrOTc0N3JobUVsWWR1UEdCU0RtLzZaZGlja2JKdGtGSFRYTDgwNlVVNURE?=
 =?utf-8?B?SXdXU0VTN0pjTS80a2hwK2RJUkZhYzIvVG9pdVNSUXJaRGZ1TnB2Z0lDNGRT?=
 =?utf-8?B?ZUxGSjJiSGdYTzRwQURHeW5IN3BxUnZlWS9WOFBYMnFWaVQ3TkZqK0Z0aW9S?=
 =?utf-8?B?cVdYNTlITVg0ZU10U1pCdE9Xb1o1T0JPZ1JBTE5Sbkk4T2lPbkpzY2k2bklL?=
 =?utf-8?B?aCtEY0xDS3paMHFjUDdGNExhR1UrWVJ4S0wvNlJacTR2M1BoZXE3ZHRmWXpN?=
 =?utf-8?B?djRUcUNqekFRSGxsVmgvM3VIUGpNQmhKanFzOVRTNVBaQ0VPeHlRQ1gxdFc4?=
 =?utf-8?B?OHBUZUVCU2lTRkREMmhQbmtLZm15TlhSTkVIeVpJQWJ3UEdscFdBTG9VQ3BJ?=
 =?utf-8?B?c0Y0S2xGcmVlbklERzFpVkE1Mjg1ZkE0dXMveGtSSTF3QzVoR3U1VS9iVFB2?=
 =?utf-8?B?T3IvRkxPNDdzdmxRM3M5eUtqdFkwQzVBTGp2Snl1ejNWaU1aYUpsMS9YL0lL?=
 =?utf-8?B?cEJYSDFMVTl1Mnl1VE1NVWY0NjFidjQxTFB2emNMYkVSWGQ2M0VJbGF3L0Yw?=
 =?utf-8?Q?gychXLpsWdTllerivWVdJvEgkv4sOIXbaaCxM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTRKekgvOUpMNlpJeE9jN1JLZVlMS0kzUkoyRXBwYnpiLzZZcTJuM1RJc0N0?=
 =?utf-8?B?bkpERm4wUFU1aE1HZDk3RG1LZklqZUtyczhUUy9KUmF6WUZsUFdDWGQ0WXpB?=
 =?utf-8?B?NGZ2ZXNod1JFR0w2NlJIUG0wM0ZCWU56c1NTMGhoSEplOS9NOGRZWGdoaG9U?=
 =?utf-8?B?clJUMlBZMjhSRkVlQXVkUEFnSzA3Mzd4MTk4SGFDYzBIVGZYcmJkQUI3K0Nz?=
 =?utf-8?B?Y1pIU1FGYWJZWk9MTlhWeUtlQmhyRXhMYTM3SHB5SkpTV095MXVDNkYxQUdN?=
 =?utf-8?B?YktteHZiam9NWmtKMHNSdkI1MFFpamVua3BkUFRTTUlKWlZCSUJmcGVuVXZZ?=
 =?utf-8?B?K240dGh4Y2gwOGVDNithTUNqcHVRa2JBMkx2VjN2TEJmMlp4MWwvaU5RbnN0?=
 =?utf-8?B?bHgwK2srS3lqdC9NQnZLQzllS1crbWtuV1c4eG1vK3BHc2xYbEozQTc5TGlu?=
 =?utf-8?B?OW5pZWQ3bjJxMHdhUnNza1d3L0JITTUvUTdONWRrWVlsUnlJRkhmL0FTeTEr?=
 =?utf-8?B?b3BKT1IzMDEzQ1BhRUZ2SVBDanhxVWlhMmRpSXQ4K3pEK200TCtRRFdWaGV6?=
 =?utf-8?B?ZFg3cWVFbWlBWFFGYzVud3RFei9vWnJpaERaWjlwa1pTQWlid3RvcURCdlVa?=
 =?utf-8?B?N1pRdExqODJMVXFXOGJhMm40NFhjWWFjSUJIVW9MN0VjdjVFTXJWeitsYWRl?=
 =?utf-8?B?alJoQkRSdnV5aHNkWitOWWRuRWgvNW1KV1Y0V0pjdjAzdVo2OGxRRkhuejVC?=
 =?utf-8?B?Z2R0alJJLzJEVFFvMTNnVEcyTWxWc1NVTGs1V1N4TWV1SExWVXo3MGR1T2xi?=
 =?utf-8?B?Y1RqQm1hMUtpZERZbWxpeURibVFsdzBWZ3dFZDJYQzhGS2J5MU90TXFrRzdj?=
 =?utf-8?B?Ym5XWCtadTRNR0pnTU1naE9BQlJXMnE1MVZjQ0IzUGtOTDArcERaNG80T3li?=
 =?utf-8?B?Q29lVkNZUUJiZFI1TlhuS3pwNHNrUlJ4Y3JWd3J2TGxqVHRBaWJ0YVB4d1N2?=
 =?utf-8?B?Y2w4OHF2NkhSUS9WdEREc3dMYkZxaFFoYU9MRGs3RHNhU05IbFFORHp3Z3lQ?=
 =?utf-8?B?Wm5UWUsxOWRjOGN3cDQzUW9Ja2c3cDBuT3NudGNaMlV2aWx0U01zSDRJTFpP?=
 =?utf-8?B?ek5BejkrcFVYbU9sc3Y3b1hJMmJaMm9NT3hHQ2ZpaG44OTVzaGdvZjdza1Iz?=
 =?utf-8?B?d3QvMjlaVWJvSkZocUlsUnFsYkV2OXRyWjh3cmFrQy9waHhuVGtDdVZLZkVD?=
 =?utf-8?B?eXFzdFFya3QwYUd5MlRML204OS9aNnFJS2hna29odnFIWjFqSWFoQnl5WjB5?=
 =?utf-8?B?bWhGbWdiMlV6eEJtbDQyU3BXaWlSWk1rK1RrdWprQWFQQmFra0RaZ2MxWDlJ?=
 =?utf-8?B?Tytwb1NQNjJYMWFZTVdXN0l6Vy85eU5iSnRWdXRmQ0MwUWpFOEdpajdETmdk?=
 =?utf-8?B?eUhvaE0xTEZ3VUYyTkxQa0Z3MFlSZGRpdndJdUlianZiTnI3TGo0OWcrMkVW?=
 =?utf-8?B?ZHdYU0ZzRzM1Kzc4WjU1dkN1QlpZemlHV1VTcHIvbWFpb0o5QnB5Y1NvU0hv?=
 =?utf-8?B?b0RzSlJ1VWV3Yno3dTJVZHhTOHdRbWdoUmNXK05xSmVFREZpV3FYeGVOT3F2?=
 =?utf-8?B?RVJmVWdwRVczN1E1QUtrcWVtUGlxcnBNaVJJR3lvV0FIY3ZFVVhlL1pVQ09m?=
 =?utf-8?B?WjBLbDJHUGwybWNXSVNUcDV1MmlMSGYwd1J0VmkySlpjVGk0NmVOQkpYakZa?=
 =?utf-8?B?TzZGODMrTjQycFF1WmVtOTVHMzI3enRERURVV3NlaXZkd2syU21DcVNXbkpi?=
 =?utf-8?B?V3BmdVI4QXJDd2xCY3VneHJjRldTbE0yV2x0alh1VzB6UEFlMkxNdlhhR3Vl?=
 =?utf-8?B?enZ6Qnh6T2oxRHRHWkl6YWxHbXp4QUtiTUozRExGSzE5T2FSbmo5SldMWEY0?=
 =?utf-8?B?NytwTW9haDdpdHN2RlVuc2dWS0Q2cFRYWFpxc0s0ZkZwV0IzbTV0cGNuR0RH?=
 =?utf-8?B?b0ZOaE9YNTltcWYzUXhaNTZ2VVVGaUxVSTMvd0l4bkhEUXlDVDIxUFF6ekxI?=
 =?utf-8?B?cFlsTU5VM0NZOXBvNWltenpLbUV2RnRpM0NlUDIwM2tIT0NBcnRuT1BEbE1E?=
 =?utf-8?Q?xKkTxVaUYEAoIs3zTVOb3XzJT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0263d9b-8d4b-406e-92cc-08dceab0e4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 11:27:45.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRpjwZtj9tVrpwT5OYSupBNzF76s0OD2fNQtHNadK4HekEJ1vHBm6oPW9tj+kTl8i6YtURk+cN9DlBVqfjAKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com

PiBGcm9tOiBUb255IFcgV2FuZy1vYyA8VG9ueVdXYW5nLW9jQHpoYW94aW4uY29tPg0KPiBbLi4u
XQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvNF0geDg2L21jZTogQWRkIHpoYW94aW4uYyB0
byBzdXBwb3J0IFpoYW94aW4gTUNBDQo+ID4NCj4gPj4gRnJvbTogVG9ueSBXIFdhbmctb2MgPFRv
bnlXV2FuZy1vY0B6aGFveGluLmNvbT4gWy4uLl0NCj4gPj4gK2NvbmZpZyBYODZfTUNFX1pIQU9Y
SU4NCj4gPj4gKyAgICAgZGVmX2Jvb2wgeQ0KPiA+PiArICAgICBwcm9tcHQgIlpoYW94aW4gTUNF
IGZlYXR1cmVzIg0KPiA+PiArICAgICBkZXBlbmRzIG9uIFg4Nl9NQ0VfSU5URUwNCj4gPj4gKyAg
ICAgaGVscA0KPiA+PiArICAgICAgIEFkZGl0aW9uYWwgc3VwcG9ydCBmb3Igemhhb3hpbiBzcGVj
aWZpYyBNQ0UgZmVhdHVyZXMgc3VjaCBhcw0KPiA+DQo+ID4gcy96aGFveGluL1poYW94aW4NCj4g
Pg0KPiA+PiArICAgICAgIHRoZSBjb3JyZWN0ZWQgbWFjaGluZSBjaGVjayBpbnRlcnJ1cHQuDQo+
ID4+ICsNCj4gPj4gICBjb25maWcgWDg2X01DRV9BTUQNCj4gPj4gICAgICAgIGRlZl9ib29sIHkN
Cj4gPj4gICAgICAgIHByb21wdCAiQU1EIE1DRSBmZWF0dXJlcyINCj4gPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL01ha2VmaWxlDQo+ID4+IGIvYXJjaC94ODYva2VybmVs
L2NwdS9tY2UvTWFrZWZpbGUNCj4gPj4gaW5kZXggMDE1ODU2YWJkLi4yZTg2M2U3OGQgMTAwNjQ0
DQo+ID4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL01ha2VmaWxlDQo+ID4+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL01ha2VmaWxlDQo+ID4+IEBAIC01LDcgKzUsNyBAQCBv
YmotJChDT05GSUdfWDg2X0FOQ0lFTlRfTUNFKSArPSB3aW5jaGlwLm8gcDUubw0KPiA+PiAgIG9i
ai0kKENPTkZJR19YODZfTUNFX0lOVEVMKSAgKz0gaW50ZWwubw0KPiA+PiAgIG9iai0kKENPTkZJ
R19YODZfTUNFX0FNRCkgICAgKz0gYW1kLm8NCj4gPj4gICBvYmotJChDT05GSUdfWDg2X01DRV9U
SFJFU0hPTEQpICs9IHRocmVzaG9sZC5vDQo+ID4+IC0NCj4gPj4gK29iai0kKENPTkZJR19YODZf
TUNFX1pIQU9YSU4pICAgKz0gemhhb3hpbi5vDQo+ID4NCj4gPiBNb3ZlIHRoaXMgbmV3bHkgYWRk
ZWQgaXRlbSBqdXN0IGFmdGVyIEFNRCdzLCBzbyB0aGV5J3JlIHNvcnRlZCBpbiB2ZW5kb3JzLg0K
PiA+IEFuZCBrZWVwIGEgYmxhbmsgbGluZSBoZXJlIGFzIGl0IHdhcy4NCj4gPg0KPiA+PiAgIG1j
ZS1pbmplY3QteSAgICAgICAgICAgICAgICAgOj0gaW5qZWN0Lm8NCj4gPj4gICBvYmotJChDT05G
SUdfWDg2X01DRV9JTkpFQ1QpICs9IG1jZS1pbmplY3Qubw0KPiA+Pg0KPiA+PiBbLi4uXQ0KPiA+
PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL3poYW94
aW4uYw0KPiA+PiBAQCAtMCwwICsxLDY1IEBADQo+ID4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KPiA+PiArLyoNCj4gPj4gKyAqIFpoYW94aW4gc3BlY2lmaWMgTUNFIGZl
YXR1cmVzDQo+ID4+ICsgKiBBdXRob3I6IEx5bGUgTGkNCj4gPj4gKyAqLw0KPiA+PiArI2luY2x1
ZGUgPGFzbS9tc3IuaD4NCj4gPj4gKyNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPiA+PiArDQo+ID4+
ICtzdGF0aWMgdm9pZCBtY2Vfemhhb3hpbl9hcHBseV9tY2VfYnJvYWRjYXN0KHN0cnVjdCBjcHVp
bmZvX3g4NiAqYykgew0KPiA+PiArICAgICBzdHJ1Y3QgbWNhX2NvbmZpZyAqY2ZnID0gJm1jYV9j
Zmc7DQo+ID4+ICsNCj4gPj4gKyAgICAgLyogT2xkZXIgQ1BVcyBkbyBub3QgZG8gTUNFIGJyb2Fk
Y2FzdCAqLw0KPiA+DQo+ID4gcy9NQ0UgYnJvYWRjYXN0L01DRSBicm9hZGNhc3Q6Lw0KPiA+DQo+
ID4+ICsgICAgIGlmIChjLT54ODYgPCA2KQ0KPiA+PiArICAgICAgICAgICAgIHJldHVybjsNCj4g
Pj4gKyAgICAgLyoNCj4gPj4gKyAgICAgICogQWxsIG5ld2VyIFpoYW94aW4gYW5kIENlbnRhdXIg
Q1BVcyBzdXBwb3J0IE1DRSBicm9hZGNhc3RpbmcuDQo+ID4+IEVuYWJsZQ0KPiA+PiArICAgICAg
KiBzeW5jaHJvbml6YXRpb24gd2l0aCBhIG9uZSBzZWNvbmQgdGltZW91dC4NCj4gPj4gKyAgICAg
ICovDQo+ID4NCj4gPg0KPiA+IEluc3RlYWQgb2YgY29weWluZyBhbmQgcGFzdGluZyB0aGUgcmVk
dW5kYW50IGNvbW1lbnRzLCBjb3VsZCB5b3UgdXNlDQo+IERhdmUncyBjb25jaXNlIGNvbW1lbnRz
IGFzIHN1Z2dlc3RlZCBpbjoNCj4gPg0KPiA+DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL2EyNWY4NzhlLTgzZDktNDQwYS05NzQxLTRjZjg2ZGI0YTcxNkBpbnRlbA0KPiA+IC5jb20v
DQo+ID4NCj4gPiAvKiBBbGwgbmV3ZXIgb25lcyBkbzogKi8NCj4gPj4gKyAgICAgaWYgKGMtPng4
NiA+IDYpDQo+ID4+ICsgICAgICAgICAgICAgZ290byBtY2VfYnJvYWRjYXN0Ow0KPiA+PiArDQo+
ID4NCj4gPiAvKiBGYW1pbHkgNiBpcyBtaXhlZDogKi8NCj4gPj4gKyAgICAgaWYgKGMtPng4Nl92
ZW5kb3IgPT0gWDg2X1ZFTkRPUl9DRU5UQVVSKSB7DQo+ID4+ICsgICAgICAgICAgICAgaWYgKGMt
Png4Nl9tb2RlbCA9PSAweGYgJiYgYy0+eDg2X3N0ZXBwaW5nID49IDB4ZSkNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gbWNlX2Jyb2FkY2FzdDsNCj4gPj4gKyAgICAgfSBlbHNlIGlm
IChjLT54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfWkhBT1hJTikgew0KPiA+PiArICAgICAgICAg
ICAgIGlmIChjLT54ODZfbW9kZWwgPT0gMHgxOSB8fCBjLT54ODZfbW9kZWwgPT0gMHgxZikNCj4g
Pj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gbWNlX2Jyb2FkY2FzdDsNCj4gPj4gKyAgICAg
fQ0KPiA+PiArDQo+ID4+ICsgICAgIHJldHVybjsNCj4gPj4gWy4uLl0NCj4gDQo+IFRoYW5rIHlv
dSBmb3IgeW91ciByZXZpZXcuDQo+IFNob3VsZCBJIGFkZCB0aGUgdGFnIGZvciB0aGlzIHBhdGNo
Og0KPiAgICAgIFJldmlld2VkLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4N
Cg0KWWVzLCB5b3UgY2FuLCBpZiB0aGUgY29tbWVudHMgYWJvdmUgYXJlIHJlc29sdmVkLg0KDQot
UWl1eHUNCg0K

