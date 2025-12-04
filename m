Return-Path: <linux-edac+bounces-5547-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332DCA395B
	for <lists+linux-edac@lfdr.de>; Thu, 04 Dec 2025 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6A33010FDC
	for <lists+linux-edac@lfdr.de>; Thu,  4 Dec 2025 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6133D6FF;
	Thu,  4 Dec 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzevV1cH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA92C0275;
	Thu,  4 Dec 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850802; cv=fail; b=f2OEO686t4lUMnDYXkVofL7HwlRehiLVb5MXkiBxN2fPvwVWR0MFTxHCXhrq07gP1eAud1nj+cNKUj/bi8fhYWx2lsCXj2+pCuFnyBYJNHh2gmHKNM2a6Acl4GXgGWUg8W93TNeBV5b7GrzzXR84596Czqx5ysG9m+YEdwx6NJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850802; c=relaxed/simple;
	bh=b+gGkJY/R9ewQ8FvBN7hD/OKLCoS6qoPSzAVWcS4WCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DROkS1kJ8KcSNHr2F3i505vfOOQCG6POxrHomMKyBOOcFLITZDr5lQV2TViee1/65JfPf60dCSUG+cEt3OZQQhuR5IQnGJmDc/E3Hm1UlBstVOfumHcNhfZPL+Of8P0hAsMHHhNtCgnCZvIA+MYcBGW/CQO1xI8RITC02N5012w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzevV1cH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764850801; x=1796386801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b+gGkJY/R9ewQ8FvBN7hD/OKLCoS6qoPSzAVWcS4WCM=;
  b=hzevV1cHNdKjA6oo3U1tloGvLS3TLehIMAgJEqryZFraUw7a3CX64Yvh
   z7BsyjQu6zig9Gj4OZiL7UBJMIrUOs9xWUVYxmBno1BmZp0YtwvjtzcLO
   4N9v8laNkv1JEeT2oi2rkgBSlULmJqAo1M60FHzUAKCXQNb1+z9So4o3K
   3X+uHugWs6v+5aexRpjuS6FeSi9645pIe8MiKWEq6bkkK0MtzFNTK9Qc7
   JNha0g1KRizqpj3dEwM0/X/TUBCfpTyU/SyOcx4E8XPeJ8OL6dtSo/ngJ
   EvIsjUeSeGhUf5BQFOObKDsZH8C2iZK4ckwXv97+dKKVAOTJ2DfFNvf/r
   w==;
X-CSE-ConnectionGUID: BrPCrWPoS/KojRuYPuKOGA==
X-CSE-MsgGUID: er243C/BTO68LDqfAUAYhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66054911"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66054911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 04:20:00 -0800
X-CSE-ConnectionGUID: 7JLAMPS4STGBZkzufH7X4g==
X-CSE-MsgGUID: GO7cpHwkQrmq0z4clCXhfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="194632503"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 04:20:00 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 04:19:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 04:19:59 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 04:19:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKmsVK36twMxFPNx3zLl97vgGmPU58lyn6gmo+6jbngY8Qvwr/MOV3bKCs8iwMtGesCzYIhc9UWxGv+oNF2e7rxojcKTlh8UQ6FI7ffPbOl89eBciUCsFdyCW035JaDVDOjPX3wXJDj3aEUF7EWzp3sVbLN+e0XzPMlQOctPS+uULlATjkdNMOBiDAb/ZeMlE5cCPdhDLvr1i6juEKs2jMGByPEOwxAn/n3CLVYThzGWwXXmjRr0hsT8GlLA72XTAA6vjJCEhGudN+8LMJWyDdU3zW7n7Z+SiJypu8wSU9h7ApYEYXVf8nuW5fwIbEnACwcapiKjpJGeR73ach18Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS7wj+inVkoCxNdvfTMjT+yrnSAKTP4lqDiNFukdeO0=;
 b=SaFlC7B5WINes/D2HkOPm5/o3rKt71aWca23mzz0Zxa3mOxl5jH+Ob/xtFdsqgOsN4NxJVU/G4XEnC/4vx1p7SdzYj90823Fa5lFfy15bJpOxCJe+3QmVNzJ4N+azeRRUkC2MvHim0M6EbJYydRAtDdChauEmAGpGJAkyxsgJn4u16pgq6aNv+5Hi6xDbEkZ+FocQqVJiQIwQPbSLQw42ASTauvydGwasckZ5x/ACHGkCTM3TGeH5u+Jvi4tlrdr9DS+AYf7f69gAs4nUUHjljCa2K0upV8jtraRnlMCN5nz1hjK13JEQy965auUV4LbK27mC4qEO0TFu94eZNsJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 12:19:57 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 12:19:57 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "Avadhut
 Naik" <avadhut.naik@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, "Thorsten
 Blum" <thorsten.blum@linux.dev>, Mario Limonciello
	<mario.limonciello@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/amd64: avoid -Wformat-security warning
Thread-Topic: [PATCH] EDAC/amd64: avoid -Wformat-security warning
Thread-Index: AQHcZQUlCwTsUSWh0Uy2EscmtIta3rURZEtw
Date: Thu, 4 Dec 2025 12:19:57 +0000
Message-ID: <CY8PR11MB71348CB80E76A94FB00AB17989A6A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251204100231.1034557-1-arnd@kernel.org>
In-Reply-To: <20251204100231.1034557-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 9064a607-4674-4baf-2e2c-08de332f702c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?svLDiHcEvy88iO/iB5FBbAodPmB5e9fpm/DCb7f7EviWdut2sUihmDLpyWlw?=
 =?us-ascii?Q?V7VlAXcvgj8I950ktyNikgjhuRJkYTp41Nqv2mZzDnRMwRGuv6XSb2CRUctr?=
 =?us-ascii?Q?VUfrq2Qn31fWOcWplvkB/5k2+g3N+jAyPHkyG1AnUdV+9Fb17hhEW+RoOI4G?=
 =?us-ascii?Q?ozsfnf1VoI9Pdaz9m9Q/P7073dhYHyJG2CmPiV4qY6G1sO4IP9G9+HbLSSNc?=
 =?us-ascii?Q?eGqzrGuqJ48LjtXGXqIb6aYxZ2boxGncFJ6Us/1rwk/EEqKKbHvEIivtWhGS?=
 =?us-ascii?Q?qlUmH+Z5U/fAebDjcg0kgXrBvVnhtsJG/fX2GP2vHw1fdRLYkCVxdktYbato?=
 =?us-ascii?Q?ZMHMTol+jqBBY56A35lj1JE8ySryYv+zo1UZuvucpKEaJ41Y2DFXkWlgsl5x?=
 =?us-ascii?Q?7YuicTLLAC4wGWrYmSQNoVem4XiVkWghZtaZrX4L9prCMhhvHEn4vIX9tp3u?=
 =?us-ascii?Q?3pgbtsE2EFVm+cOZTSKggeOXDrAU1JRR+RT/ryO/s+dD1Ih+aDwDrpSNJs9n?=
 =?us-ascii?Q?0sL/i399VnROdoBxtRUfze0m5E8KOTCteAhDyexCF/E72fWxm1nw9w/FZi8f?=
 =?us-ascii?Q?dLGGAmOsJ03B3HExcB4mifpHKUNaP12TbaCkGMhZkakdlh2SNffY+ngX3lYJ?=
 =?us-ascii?Q?KAeqyrQ7/7l6CRTOJlph8ZFJfb9rxSaZfv0FgmlNEY637sADtNHYOEHLPzVU?=
 =?us-ascii?Q?kZ8Zq3Os+KPdp8f1ZNx8X/22YREeUN9sdGQcCoKBZewNXg16aCgrGHVLxnP7?=
 =?us-ascii?Q?iFy/YVP2y1NdHahVpx5uP7sLEX9ypfVVE8me7SmNW4Z/+QJ604ZyP4pzlsPZ?=
 =?us-ascii?Q?SDgXT7njJXJDhmIcl656+M0jaAKOXEKc7nH3c4ZKICe/oh6SZc4meUvb88q2?=
 =?us-ascii?Q?heITzZ5mmePjKiMAjR4V/4Nw3rKbqUek+nT4KxHsNVCe8UEHa7ZwjIb5xNn2?=
 =?us-ascii?Q?Lp+lSv+uzBEKtG5G1AHxApa5WjC3iltNUCMe/O4G2lsrlW2fq9hHtWz9VWw0?=
 =?us-ascii?Q?ha+NWoiqJ9ly2JlOBmy7utUBZdJoF/ySSgml7qBLLZeJJThCEn1ozxoZToxP?=
 =?us-ascii?Q?IFCZ1enu2rGmLy+5pnE6cbnNoyk9ojKqw4tc6FF9G2LZN9U/Tl6LyBAWQcKL?=
 =?us-ascii?Q?Vpon2FuDlL0NKuPBDfhMFdYhToEUStuSr853FUZ3KQrsD7ulSw3KbL8gLXis?=
 =?us-ascii?Q?xtZU1u9k9YxbtJsexCXFqljiDYskVg0GbiMZYYym5/FXp2CLm0ML/TDbHPPe?=
 =?us-ascii?Q?WIx0QmdLwwVz1IYK5qfeBS4jxu6vPw8wEUgt10YhxQlfvvOjZteHwM1dK0iS?=
 =?us-ascii?Q?xs/DYeVut0ebko4ou+va2Yg/cqkwB4owB2CjKUhj90bp1jOW3GG4Lf808EGj?=
 =?us-ascii?Q?czMI1FAyytjWKbfWhSAsnrGulRAsoOIs2ZvIYJQUn5cfzDNIeuD7YmC28fM2?=
 =?us-ascii?Q?kD2AKn0yQzOuFf/Y78eWMy8VbiBQzAOZk37tQpnTHQMsBq1RmZaw3dxEYnkV?=
 =?us-ascii?Q?DuuFTMUHhKDA4Dy9B1dp+7F54XQCCg/om4yW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hOeEKkwXFEjdNnJiHo3VMQBLYQFPbos9Ss2fa4dYhsMSEJgUiFMMcjrPnvIT?=
 =?us-ascii?Q?rr8+OglswP3fIlA10ZHy8M/hzL1u0KqYoFMzSpsjKxC0ht/Z3JwAgLWodn6+?=
 =?us-ascii?Q?kFGOkatyQZEdGFfBBwt+hv5zY5+QiUmZSRw8dCGmwY/Zk2KpnhdaaU2f88+K?=
 =?us-ascii?Q?EeE+bl7bWlpeTxOQGtHzJMyKEBqCxqhWRHa1dLIp07bRiGfRvpqJJhsn0CM5?=
 =?us-ascii?Q?DbETpimghO7rrMlCduUgjlYZ9NueTgDWNxZlchFU3OMXPlYmE+BoF6lCkWmC?=
 =?us-ascii?Q?+lVHEJHgZ6+iXwiP+Q5bB6SEysFWh9IbLpeiTciThGBkbnoeYCpgoHE4nEtg?=
 =?us-ascii?Q?ta9D72Lf/dNg7PAbEf7n5S4SeVe//oNFVBzr0PkfLc4CPSJ4LZ9praT6EXGR?=
 =?us-ascii?Q?pQivs29qO1jh+wt8aTtlHceTG590vqYG54RAjm60jduDBKUtrD5KExbvE3iA?=
 =?us-ascii?Q?NnZP1MRMAGGB9mJE1FebiQBj3uKxebz6cjDitg66DFRRlOkzJQY9641k9L3J?=
 =?us-ascii?Q?BshaJ2Tcp5UKFMi6N3MQqePrdi2oKf/J6qFsLt+LdCvLhsLXURR0mUy+kEFi?=
 =?us-ascii?Q?Y3Dg8IkMmyJMzTdzuo0kMSy3BpwAOUf6/I5DyvDf6lkQpFhdH7WSgycF500l?=
 =?us-ascii?Q?cWmpI2h8RJvpxnEZuTOjLOjahiT1Pz/4/tcjZblvqnXrAzLgj/fJogqKkXdm?=
 =?us-ascii?Q?OsoiXrwMDXARqh2CyP1W5nu71+EiSm8mz/dP8Xuzt8T9teFcNdMiHrDsIAUk?=
 =?us-ascii?Q?v0wHrKOA7ArM/zE1J25pAa8kwJpD0JPIj+UQr6hYHiH5ajOsPXEc56XxwyQ7?=
 =?us-ascii?Q?t1iSPH8nlB+gqYkJSBAipdSfRHTZxZFzTa0dUiVdwHkDaL8Ek4akGQCgJNj/?=
 =?us-ascii?Q?XCAXRtdoD5vZ31U/U5bweMk78SN40CO/jP+BDoB9MhMsUJa1RmBgmqUy4cC4?=
 =?us-ascii?Q?khAWy6QcOV0PbK4cI1OWqr4sbEVcp80VjWMYW8XehX6/zPW0IwrHvipbqJtC?=
 =?us-ascii?Q?uiA6iLKALJDu6M6nPArSazU+XhdUnz62TVReQD/hWRNZOw7ZDuIWyPuXJNj7?=
 =?us-ascii?Q?3pbdusz7rwBCypDS+cbucpmykJpyouYNToX4grmLe1kCXctlthmA2mUm+4iU?=
 =?us-ascii?Q?bdQkO/Btd9gWK/4ljH/+3EUqve6ooSN6DfFdzxDNkwW8syE7U7uw/eBNCbTn?=
 =?us-ascii?Q?MqXnueA7yPfQTAL++2SKLzEftusUO5/EqbjASTZ5BNYUUoPK8awM7ewT47iA?=
 =?us-ascii?Q?Kkt9U03uTWaR7FYEdIr/mVpGuAMil92j8O+FHSenW84Ka4W+/bN9tsyptSe0?=
 =?us-ascii?Q?/U2S4eqQ8gcdV6Bn5BxDu/+lymns0eAeFKdp8C9sGYYgHpvISLrFM9+9B8gk?=
 =?us-ascii?Q?UyA5ux8tpI85H0ZHCuaWjnpw3OrG56oY3skS/PTk8cHqq+K1FvmRJJNNmOo4?=
 =?us-ascii?Q?m3xrMV7jq/4TSqkQEVYib1wnTPoJZaYMdQzwWTW3FIfWR6QsTkZmzKnaF8Bi?=
 =?us-ascii?Q?zeD0Zg2cAMVDpIoBNGYvmSOnKrHuO81REQMvxL67bEEAR9pWrWVymPx7Yfh0?=
 =?us-ascii?Q?a7tq7l7/l4FVp3Zw3DSIrz0/2ErepDxZlZLaNbzX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9064a607-4674-4baf-2e2c-08de332f702c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 12:19:57.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKwuqkaebhsfzBdjIZ+x52lcLzHBmF5d5kaaykH5rFhHBCdlpTI/PxPVmU3XN+8W2frHbf04nT7hpCDBz26I4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com

> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Thursday, December 4, 2025 6:02 PM
> To: Yazen Ghannam <yazen.ghannam@amd.com>; Borislav Petkov
> <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>; Avadhut Naik
> <avadhut.naik@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Ingo Molnar <mingo@kernel.org>;
> Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; Thorsten Blum
> <thorsten.blum@linux.dev>; Mario Limonciello
> <mario.limonciello@amd.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] EDAC/amd64: avoid -Wformat-security warning
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Using a variable as a format string causes a (default-disabled) warning:
>=20
> drivers/edac/amd64_edac.c: In function 'per_family_init':
> drivers/edac/amd64_edac.c:3914:17: error: format not a string literal and=
 no
> format arguments [-Werror=3Dformat-security]
>  3914 |                 scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), t=
mp_name);
>       |                 ^~~~~~~~~
>=20
> The code here is safe, but in order to enable the warning by default in t=
he
> future, change this instance to pass the name indirectly.
>=20
> Fixes: e9abd990aefd ("EDAC/amd64: Generate ctl_name string at runtime")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

LGTM. Thanks!

  Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[...]

