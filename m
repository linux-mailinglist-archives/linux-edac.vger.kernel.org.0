Return-Path: <linux-edac+bounces-2117-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3FF9A1A60
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 08:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF0F1C20D4A
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 06:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D215575D;
	Thu, 17 Oct 2024 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF+T1qAu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909E20E3;
	Thu, 17 Oct 2024 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144986; cv=fail; b=UhVe48LXHzeWwl/cOM8ILy1Xj8kGAonsaGOSbM+PtSRqmJCvo8m153ZWEsgUkvyBbaFE/DkdJ4w4uh9P5qvOpufji7WBGCcY3WzC4uiagdKbszGE2A6o7VtzUrmJxSIhW1eAlnlMDk/v0nI8oHTJtSlTKL70rPeGNm4ZDV1hJWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144986; c=relaxed/simple;
	bh=TuTKZpMazm+yBMAv7mnaLNePLdUYnw82OBHS9piNhEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Si3GUgGOn/OZwTtjhOXwleDavnWeQM4ZysBeyVbKLs5+NP4GbwWxVgDzu88fqjr9dIj7RCaQD2I8qyEWYl+4Wz4b/b16rHg2LB0kbw2czTUHTcPSaugq+zIe3iQzXCFcjiye6XSrgLj9825Ydq+6LpG2RqQjEOXvX84RZI7aGSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF+T1qAu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729144983; x=1760680983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TuTKZpMazm+yBMAv7mnaLNePLdUYnw82OBHS9piNhEA=;
  b=KF+T1qAucfWqJi8nD+WmUh9GlDH/MhSrWOiIGuKYaanuZCXIRROcazmD
   BVcYZFiU7xnqKHm2Qzl8/QphVsru5gqXIg6oVeT0se2xed6SJLlZrKZXR
   BC/3ZwFNhfByuVL41YEA3ppAGBMxVKwkLODI8nWS4DIW5abBvOKGPtsWt
   UL5tnSrPEc4hqsRf/lg4o4LzIENN9turW1NUPFYFOZ3DAbBufBLcfkWz8
   kjo4aDjGZ1NWVapSxFTRbNDHRYnMSLXWLGz24L2fNM22//bIO8fCrzJFX
   N5S/QTrOBG6xlz1oDNw5GJ0uZ+HzqNiE7vWhALLyf7U20oCE+HSqBY727
   Q==;
X-CSE-ConnectionGUID: Kth9KkZsT92WA3PDUdoNTw==
X-CSE-MsgGUID: ii+AfLswQUSZBjd+GtThbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="54030033"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="54030033"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:02:51 -0700
X-CSE-ConnectionGUID: f5KpIAKETUmumlX4O0HKlg==
X-CSE-MsgGUID: QxYxPF2VTyKt3U4jY2043Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78785277"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 23:02:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 23:02:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 23:02:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 23:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyEr6N3MH9RGCLBQNktpswnou56ncyVmm5I3U240+E4QD0O9AHuld6XEM0Cx36YHH1hrKvhkEeo1bXPeI9hBQBT4/qf0Uok1jlwUB4yLAX2OU8GRBzzsjD58sJEaevzyfGKoP7XF9tsd1T2DcDk8J+eg2Nc6f6fmNa0gH4IsJL4fupnhsK49G26bJ77zKiCq7zM+pAqg0TRwr8iiLZje6LCVYneREP0bzzlhl/32Px73waC8GEv99QCMcvWXzHR4++5/Ndvxp0wpb2an8mv0m5F11I3NgylqLU5ECJCdBurSG24K/iN/1+og4a+7qKXE1geIlV+WgK0FvxASrakp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3IUCdczzXo1GARlka+FmgH8N+CYNuUCtNT3NcJ/x4k=;
 b=cRvf796P+yOkN5aEA2xcOGDSzaHCFa/yqroXcp2THRQ2lMwaAyNXvwp1RFe+qrw0O0YugBziPEgx2OiIg0AiRe5hE0Qv2SYiG9K6EylkRyr/p2c98KXPTEwoKhgg0SHQcW8HG/1vUqO+ibCLFj0o0N1TNHwNv2a2iBTsU7tcDbKN5rpd8/I5EvEnfldPDTVEP9awKuQaZFtruE+k3y86/XXTX7nMy+BB6nuOWHOIig8SyNWTsrgfeirRt39iCcrPh1b0AFL5VUX86gs5cebm8rDCyzFek9410tgbq8+0qcY/nSYAmp/a59M2AheMG9g9E1jV7iffHO5L6WQA3NHkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 06:02:46 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:02:45 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v6 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Topic: [PATCH v6 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Index: AQHbH5Zdm9yV0mP6y06bZaH9WdyUurKKb2zg
Date: Thu, 17 Oct 2024 06:02:45 +0000
Message-ID: <CY8PR11MB713407C7FA225301B9072E2589472@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-2-avadhut.naik@amd.com>
In-Reply-To: <20241016064021.2773618-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB7159:EE_
x-ms-office365-filtering-correlation-id: 491f2256-b829-410b-2bfa-08dcee715253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fX3/c4F3+lc28BeRMLE7KFFyks2eh6ad+BnQ93dHkS2ourTNb2PkKeKoMr0X?=
 =?us-ascii?Q?sd4J9GRoWpQ1g9uHcBgRMzTJbKsKgEpNvfzaNbbLPDqenf1uwYQ9rCsczBM4?=
 =?us-ascii?Q?ctfyV55Jcw4cQgMtRgG55XiUQc5zGGokYa+u9vqJ3pfYSUMI3xt8nOWgL2rt?=
 =?us-ascii?Q?TwjiS4pj3PZH7LfWrkQ9jAc9N7FN4JZaix/9voMaS216Qcw6aR5rHXZEeEqh?=
 =?us-ascii?Q?VBhLDu//o8v4P5Eqnk5XM/almoByEr+EmUwhyLu7OONPDDe2L+Kts7yO5+n2?=
 =?us-ascii?Q?c8cmFu1nxs0xTCZq60S5LcaE5Etg9+S0LqPLG/Fa4Aatv3SHVZ6Hx0wTHCBi?=
 =?us-ascii?Q?uhda0ycBGqd8xU0yfm1r6Z1LsDxWCji9UKyQBpD9ood/tMXbwxWcCcHqWxDj?=
 =?us-ascii?Q?x+NxDL5iamf8u8uEyiYdrk42/V5WzuTjkaEVcuPxu2BZy4BueJ3JvUUnZBRU?=
 =?us-ascii?Q?uttDeViDpXqwagzWQi/fnChvaJJZdyDkOoYW9ipphZQwGtsE3CjhZpM96MZw?=
 =?us-ascii?Q?XB1fpiIZRhUTYdheK8r35aHLsZ5fA0qhUTbmTvLNiagR26XwnCVTxjdJRiqy?=
 =?us-ascii?Q?CmxJCXucAU2dL7tAwxSVFV4bpmdVJgNiUf7pKLBjIz6+JjUcxk4MsqnIezn4?=
 =?us-ascii?Q?Sg0LiYGiKjwbEJDuuw/nnF1jeHPOgtgcwTp3TZZUa3oYosLBuHnXxP+BxGyr?=
 =?us-ascii?Q?bl0Ld8cPR9HjV7toVkMaTpGhV025yozxpORNhUxxovnF5CL7sVjzaAh2ZaaA?=
 =?us-ascii?Q?oZ/hbtL1NjFANVssRtASHEU67RpTEclGNQWmuoJNiPTA4tBqzGg5UB4p2VcQ?=
 =?us-ascii?Q?au/XdtNr0+FcMUwFmRyVZfcdK78fWwlpwQazkPjIBvhGnYNIzlZKpxCLQgMk?=
 =?us-ascii?Q?X6XrZm32NEg2Qx0CBG4RKyZuDS+gUPvHcVbUW3WqanvyhoPKty8t2OiH+csi?=
 =?us-ascii?Q?i3rFpqT3By7B715aFYWUgSKi/otCJ2/+pgqawViTzyI/S6nrikDQUq4Fg5wU?=
 =?us-ascii?Q?0IarB3Q6XRZ/f/kft5he9v7L8y9sE2hMes1QjKi7ZH+d2GMfSAfsz257vdK8?=
 =?us-ascii?Q?81832r3fM7nt2iUxWw8chGiHEEuowKqkk21SQgK0Tyd7MIv5/Q3mSkFQcSBm?=
 =?us-ascii?Q?kWKbiJyoglq+R0SpE0YYbwcDj3+r+TQgQzUkHGcigWMEx3H1k/9AiQLW2V5i?=
 =?us-ascii?Q?qoOslsE1p+PvB210HHj8VQ9lICuk18d2t0h0dG11tOn8g8ntp1QDm3LqbejD?=
 =?us-ascii?Q?oe79CSzdkc7qlIIM+sNaxKl6CVAlPbb0hgz2DlkztCmlb1ubxK5q3MYUL2jB?=
 =?us-ascii?Q?e/uBnXmKyyVFXUJXfT/e9GOnETYmlVhv6U/jmDhaDQRZ+fFlpMVUoxo4EDzp?=
 =?us-ascii?Q?yLX4GZ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P2Sr/nYdkneidXMazcG1fnMeEvBOx38KHweCDg81q2mWJOsPNoQPmI7b/alh?=
 =?us-ascii?Q?ffKBf/ali3MrwNUX/S3qoP9NzUtC21JtQqAYzbQSw4hDjFm+tRGgscx8IOmB?=
 =?us-ascii?Q?OVAcfEKF/V62gp9rf4FhloXOrnYnkaIoeHOrhVOnNHm+AqVhlzsS/xuXqjHI?=
 =?us-ascii?Q?RiphohS18AZ78CBLoM+WdeeidgCmKe/sT+p+rDBGlH01dpwaSsjchxL63Qda?=
 =?us-ascii?Q?cQ670QCYKihXQwP6Lgih0VcAZwMmjpOCEf5g37Fop4hqyFF+AACbisBbDpCz?=
 =?us-ascii?Q?ZeOSQqbNruQtdx3+IOVkB7L9ETrNufw/jczVuqJll0+NytvfA97VN9f5E7/t?=
 =?us-ascii?Q?RyP0Mn4WDqFGq9quQZKqLNMYlIK6vJdZ8gAPPQqlnX7H2S+QHpgpHSK9NvNW?=
 =?us-ascii?Q?KJe7gDbq8/8Pw+Lj5Q36juVI6JHEQsfJAh6fije/PDqbuVotXDutO3hm4oQQ?=
 =?us-ascii?Q?xo64Vyi8DZ2EcuCJQYFknUNOAzkEYllzUL3VDCESlPuI+mWYKmiLtHCrRr/j?=
 =?us-ascii?Q?dpaxhdHOWULpOQA22ldfRIhWBo3E+7tEyVat/7shZemop/RuYHuDqZZjlsq1?=
 =?us-ascii?Q?4F0Y8rCvoEZj/fVFgHMkNy8qN8q1u93EMsNkUvtZqkM0V5b2438SUY116K1a?=
 =?us-ascii?Q?w+o65+6Zfkk9zmhdew0pTciqIZut8yMpGItcrD/FEHJvxOTstFHQoZqZMAK3?=
 =?us-ascii?Q?jxoRNlCMHnnE/KLYI4//woWwvzUsktptGtN4ZEussXxrk/MFxI1KEnDE1ZXf?=
 =?us-ascii?Q?iteunH7WwzvSwTM9N6sKfJIzbXtQCefyNPsBRkdNhXVx7QUdjdJkj4HeKNSH?=
 =?us-ascii?Q?ThVc4BptjcbsaVkxlnX24dpN9syP1/lVXBQmOxnq/dAq8hhoqYr8wAC3luII?=
 =?us-ascii?Q?IzCGFamZ4T8PiKyorqBIisQJ87V4a+838doYnbDjvexCOtEoxz+DMwb+V0Zr?=
 =?us-ascii?Q?8w/mcCPVNCKqondECeBY3ogxugtcgTkYsUV1ipT25Gl47C3oqrOuDKnix6rJ?=
 =?us-ascii?Q?+Otkqivg3sBxEptwhibSXOFeg3flp8O9MAZ+pSJg6KV6EeIYdd/2lPcbFDVO?=
 =?us-ascii?Q?B3an5yrxTv0SVyc7Txfwn1TEn8ZCiUFBSP000ArIj83T5y1Rj7PuM1aaSJKb?=
 =?us-ascii?Q?a4Fkc8rhnRoSBPK8wKKmATzoeGFHou0PDZGYhKgYwTelCkk94pYmGQiTdMtZ?=
 =?us-ascii?Q?jFEWQAG5LpEIM6nkEEFzWnmTYXw7AT6Mak4hwTN6/pZ3PA4Dt2oiNv/3x1/0?=
 =?us-ascii?Q?zDX78Ap/IA8TAi+SfW/+jp1eRSFrbAgBMx9hD9Ny80+Zt2JjRFeEQr8FafNY?=
 =?us-ascii?Q?55+xCEHlIym+q19QiEfo9477z9r6CxVRjeAMIi0SJ42ry9GArB7bkO36neNZ?=
 =?us-ascii?Q?i8sN9sN4I/WgcBvFhywDF/esTiJl5mB42XgBke36b3DyTTv1/4aXOybZ00CS?=
 =?us-ascii?Q?Stok+iUQvH2/uM2GhkfKsPgynzMgM5GsBD2UoAwHiEhr/gjhcZR/NAKPcvqn?=
 =?us-ascii?Q?bAL8o3yQefWfHtJ0ECkCzngmVuznfI5AkiyQFq5jK8XFBrcJhRtWMT7V5583?=
 =?us-ascii?Q?RQB+1qbBArxyzsVud/YGyIjt4noeMBwn3WhsA5YE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 491f2256-b829-410b-2bfa-08dcee715253
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 06:02:45.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GTZ0vZ5C+pFN1NrIGKU9w466jERjztgqwTNC02BT5v2RQW0VnvkQuvxDOohdYsB/6f2y3HfRfjixwCI1OLhiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> [...]
> @@ -1506,13 +1528,14 @@ noinstr void do_machine_check(struct pt_regs
> *regs)
>=20
>  	this_cpu_inc(mce_exception_count);
>=20
> -	mce_gather_info(&m, regs);
> -	m.tsc =3D rdtsc();
> +	mce_gather_info(&err, regs);
> +	m =3D &err.m;
> +	m->tsc =3D rdtsc();
>=20
> -	final =3D this_cpu_ptr(&mces_seen);
> -	*final =3D m;
> +	final =3D this_cpu_ptr(&hw_errs_seen);
> +	final =3D &err;

It's not about getting the 'final' pointer to point to 'err', instead initi=
alize the data it points to with 'err'.
So, it should be:

    s/final =3D &err/*final =3D err/

[...]

-Qiuxu

