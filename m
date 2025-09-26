Return-Path: <linux-edac+bounces-4939-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4454DBA48C8
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB0B2A3E79
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84751233145;
	Fri, 26 Sep 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXWrqlEV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0423313E;
	Fri, 26 Sep 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902835; cv=fail; b=LVra07HMHEmOdv50vPIsLLI73FC0FYidKdG6nbKZ0ekEOy/3A3urYt8cGt+g9Wj8gYFZmN0xkjFBIeuUP2r9Pr6w5LbXjhKp9AyDKO13ndAVMntFQugzCo5rFg6pc+28zsDWGOTbBdxsgbHWjZ0dTtbRG/SNvtrsdVeZvrafB3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902835; c=relaxed/simple;
	bh=aWPQ9kBMyEnfpKMzYOQ7YYnje2B2iVqSTUZKViXcSn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JpNuCr0OaLzFVM/7ZjTg0z12LFBKXNYgRs5RDp1IrLL5FSA5K0FwqzwPhOti2sxme8nFa+RTVDUnnR2B7VRodbW25y/HI7syTU5bhVEiEM+sDi+wnlD1uXjSZjr6YcfKdHKalQkz1M//09RoT5//fXXn01ZIfi6vjZjrBdsRJOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXWrqlEV; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758902834; x=1790438834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aWPQ9kBMyEnfpKMzYOQ7YYnje2B2iVqSTUZKViXcSn8=;
  b=HXWrqlEVJgy0Xd4qr65qle9ACxwiANwC8EJfLDYhT/6l/HT+m2CbIlSB
   EYQFNlitST0PCSF5BwNrqd7ORyOdNK6FbpdR0MSi/kQ/TR1a7tzXWoxJk
   2jV72t3zjYcWGBBN7c1HfiYCGJXdVbjsloKUl59edO50esp6zEFqItKn2
   OseNn+JmfDC8kj5MGiNh3iOjqQsuBXVAF4ejVzXkNMd0wncBWWzX+hXxJ
   Ds925VNn+uXvk1NKb3whc54i0g2H1rROqegGnV8LboG0vj2cfUhonFXeJ
   4fQ0G2u/ywfRPSjw+xf3A+8O3Fe3TvYDj5L+2XWn0Ix2V+C7ncTMuDeE/
   A==;
X-CSE-ConnectionGUID: GME4s4rbS5GvKRppPrFV5A==
X-CSE-MsgGUID: SMkJwsRoQgil/KXDCGX6eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61153014"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61153014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:07:14 -0700
X-CSE-ConnectionGUID: pXTXiOd5SE2muergTerioA==
X-CSE-MsgGUID: urcGI/W2QKCe6OktJy3mJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="181948085"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:07:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 09:07:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 09:07:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 09:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUbqppy6rCLZK38rfeGk0kCgChg5UIe6RwR2uNG7YAcl9DnZ5H8gSjNfZvi7V+fKPF98S9u343eUpL7IaUFUaCPUfCJRjEmibjz9yqHWiiHoe7SkFFxZF4GrRIkFlX9tmNgo7HDpTHt1f/EjpcmsHZSETsQb/829WOlAOrtIBblgveNvjzFj32I80of1YeaJH2f5Zmy+emqRl6SSTZjDTKORk81aujKwv9e67mgPp/bBhT3knwTLyB5qjwHMSPqYfD6CEZrLnitclm3t831GU+XNzwe9nYT/z61CZhfkh1+GIX9BJpOv/Wo1uRbC72pugfNv//mKpYfodSEEd+y28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JtcpV7cqHI4IYQXPaG3Vad0nHXoPHaAp4lbUyDIUzw=;
 b=Xmf+0JF5GqHl2kH7gSCEQ4R5R53b4q+CCS3PjfGoBquJP1aCb3qmYa8vw0klaCvFl5UGeuv2T8GWkNh0aL0vzTciDcYS5CloseL8zRxTVz+w2yOVCeGW00NKMcA1qPALDMb250woXiwQGB5uodde0ROGjaulwy1OQiBq/OVQ57CgONeighYZPmfPLjIBC5c1D4i1Ol9HFf6giU/kBzrhp8yrEYRvg+7//asaqvZQ6jwzOclswqlFW3dVZah7SEmPYGAP5FYQA92NtbS+kLs/hEZuphlor0IjSJENBV15KDSmD70UQzj24FiuauyOQiknSwVEbPUE4quTlAOpMIZvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8060.namprd11.prod.outlook.com (2603:10b6:510:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 16:07:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 16:07:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wang, Chuanguo" <wangchuanguo@inspur.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Wang, Chuanguo" <wangchuanguo@inspur.com>
Subject: RE: [PATCH] x86/mce: deal with UCE when copy clean pagecache to user
 space
Thread-Topic: [PATCH] x86/mce: deal with UCE when copy clean pagecache to user
 space
Thread-Index: AQHcLqieN+AycoZWY02pIuihgVt0dbSln8gw
Date: Fri, 26 Sep 2025 16:07:05 +0000
Message-ID: <SJ1PR11MB6083DAD269C3ACBE663AF67DFC1EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250926054402.1571-1-wangchuanguo@inspur.com>
In-Reply-To: <20250926054402.1571-1-wangchuanguo@inspur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8060:EE_
x-ms-office365-filtering-correlation-id: f56d5eaa-d3ba-4617-b330-08ddfd16bcb5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?VYepSPGAFcDlQcWW2ivnUqXhW+46UKpFQVYk9b97SjYxuOA3LC63t5OriA0o?=
 =?us-ascii?Q?+cigvGvxAjFzqPboje0zgtxTmnnjt65m59fskeU+heUFk/cI0vbkYzmdZL5K?=
 =?us-ascii?Q?yvn9r4dq1+CgkizZU2x4xc15Nrdvzel/4zsdDvom1B7DTy5jpt6BWPd2leBi?=
 =?us-ascii?Q?X+2SgpK3xG7fejMoU4F6Goap+51rJxX/jiAYpY183SfXMUyi7DihiG5w37Df?=
 =?us-ascii?Q?AbXQSNWNWXfYaLy4F/gSZegs86+60r00K6SHEwbeXD2qGzdxK1M4i5oJBPuU?=
 =?us-ascii?Q?c4gcKe6aXbicT1LGXCBaVfljsCGiLW0JwGUVTjVGG6JNCsHon2vPZQPgQSTd?=
 =?us-ascii?Q?2D2UenmkJ8mu/DWUpe6aw/PB/ZoL3H2Uy2zc2vZV7dU++rMenbqlcWb1oEmn?=
 =?us-ascii?Q?SPQMqao+zHiBEZziCAO9qoyi0zqvCeSn62ea3CKyuRiQGW9fLqyNfP28PeNh?=
 =?us-ascii?Q?+tdXfAbWxKOff6UWH//W2Heryxo31swlHTc3+/L8n6T/BFi0Pcb7M1YW+yxi?=
 =?us-ascii?Q?hwXxpoPkSwHqaSPKs7fhYl1nhOOF+dof6X7e9W/Jun0MQAgv7LkzBWSOHzXL?=
 =?us-ascii?Q?2Nc9Xj4ynKXuZZodh0Jgi5+tHyVgmV8if0h7LXom1mD0Jwx0xteYl2cNoogd?=
 =?us-ascii?Q?TfLjpUfcoaDRHsevpM3R0X8+uzWIKfEgWy+hRfJNDjK77Pyv1BiH4IrC0Dyi?=
 =?us-ascii?Q?wJqg7cNGA3jjvXmpBZJZC0eBkL1LxWTI4QZbVZbFD7IO1uulHUAsiW3jjHfF?=
 =?us-ascii?Q?bRfy2T7ufzbjXINhMLZGoM6s4E/TX5HwsMqPuBe3TDFpT8EGJBDzH9nqblDO?=
 =?us-ascii?Q?/3j8I6fR9IHtaKmkckm771+T/wlF2KXiK+KoFzjgpfQrPjO1iLF5DF2AN7cD?=
 =?us-ascii?Q?jT3XAWrCItwkJQiJjhkBd6R3/9PO+p1zTRBlbooOiAomkwxo3UV3ShNDDRrI?=
 =?us-ascii?Q?PEZ5y38+VbwxPrk245VUFzjJ6tNo6Skw8SPwQKFuq8TzwiBrZbycT3xhHSNj?=
 =?us-ascii?Q?nv0IfT1V88idfjZXWtHRBsyo7M4ot7n0QULmwiSSH9LF27+zGfpEp19RkFwQ?=
 =?us-ascii?Q?bb+Otau86ws/X7H22xdgADFwel2hVLl04SuqWyG3jp/WczJQ8zjvg/ytspDi?=
 =?us-ascii?Q?HeQPMf3Qg4FWBr4vkgG1RXDGpu7rbEaZVOIVrzeuYo1J+sOb4oD91OKD7YIN?=
 =?us-ascii?Q?gmMm+9a1lil18Qwrge9neKAQcDsj/q66hn7cEPiNlGsCPc3XgM5qm/aqaMh7?=
 =?us-ascii?Q?9hNjO3nvfOVGofwg69nHf4FWO7pdcG5gPSq8cl55loJHkRupiQANm6Amc7bM?=
 =?us-ascii?Q?ke4UAb6FfmV3GNkhV7JclfMp42e1f+qqoNHsaAkto8wD0MOvjsmSqCRQiAQx?=
 =?us-ascii?Q?ykTtX4p045Cmb6VBNZyrDH0Wq1slGmQekeZzur46C9khlWAiRStlzNt7X0nI?=
 =?us-ascii?Q?gBkWmJ/kkoZXSSmoxX47zVS4RPU3e2kZkuWY+4LVKT/2M15cxbW4NT67sL0q?=
 =?us-ascii?Q?JhhoDhLL87OOf1VtzEAkmT2OgVMNDO5p2GTa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bncE6tYJLnB1Yydrl1RYSdWz2wMOn2P4tHI2BtIgZZgtPGiwXKV4lJoMW6th?=
 =?us-ascii?Q?CZw9+lOgk31xfJnutDpYdDmkuw4Rj/861r8QyW6PLzKMEcXl20A23kVbwksN?=
 =?us-ascii?Q?8fJ8HTzm40I4Etv93HcsYOfMFTXk7poA32WzWOsffEB6FG7N74UJ4JlKXAy+?=
 =?us-ascii?Q?i3yFGSmDj6ypyNkcMtnzxFELVdeFdugSdEHuEQj+oA34PX969Ik23eImnnAI?=
 =?us-ascii?Q?GwSN25LR/71MyGIwD8XNN1UejidiZwLx0hyu5Uj2U7VkcuHEjAkUhr81b+Rs?=
 =?us-ascii?Q?LqH6caAEASY1aQTRnh9pLFrUWA7z8Co4p+3rM3XkgDltpgmd7tcL0oMio5sQ?=
 =?us-ascii?Q?Sf/rQ9iOznoc8PTq2+l0GgV1ex2Nka+a25SxGIcWy+T4txL0hWDh4YNSSIdE?=
 =?us-ascii?Q?wIE7yctbaK/9MqNRI7iuHkxkbOKvEkXO8sx52e8WmZmYft7b6CnqDy28jYH9?=
 =?us-ascii?Q?gDPL70DRMsz/ZZeebLAGDRbK+z0urE/HHuaqcStXqfh+4T2Xe8Ic3yVuaUem?=
 =?us-ascii?Q?Bmot+XmT7NLbvm7C9isfz+/KOBYazN8cXk8cMioP3/SDvnxaPbtiQRstLs6D?=
 =?us-ascii?Q?RO5tJyCpOucpiDs14ZNTmpQ9f/rzjscKd8iiV69EHPzC54b4XLVLgYD34UsV?=
 =?us-ascii?Q?s2eTN4UcuuXGeOGy39JCnG6GZi2J0kxhcaLwsa0O71HuylRIwOSex9FZ3MiP?=
 =?us-ascii?Q?VjxRr0CvELBEPV38X81uUvj3q52nsVVo6J+l+a37MFDWA/Wob1X2Pt5o/lhZ?=
 =?us-ascii?Q?NUG73VHAkWDTZvHM/M9/+n96EFFrBBqjmLvWq2E5hFVimAhfvRlB3uHhe1xu?=
 =?us-ascii?Q?gDHZQPZKoXu/23mxFMxdq4E+X7BXe+wTkZXPIE+l1q86sa3eCk+uJbKjUvpx?=
 =?us-ascii?Q?BuKJ9F3ttIjeL2cQxrX0vckv+/Cj3opFtOF2XHU5+8mC5fcdsNOA0MGGg02A?=
 =?us-ascii?Q?HyvI/YvWZGYSGKKmxq0DtapFw30MKhXXqgcr7k11NthdYlzjaf6bSt6oq27X?=
 =?us-ascii?Q?6Ux2du+jdebgP2JKW13+UosiD6ZD1koL7P9q0mDfjrsL2wyODaU2r602sFe+?=
 =?us-ascii?Q?Yp5kdxq+9WLUP9UEATnTcxvCXbhCT0E272898qgtIH3mzniVbF8Y4lqt+g3H?=
 =?us-ascii?Q?rnMC+3Egw9cCxEHggUjQeIE4J1JyZBybeaysBadpKB+4UonQOnDDqDkDHLHQ?=
 =?us-ascii?Q?9hc5H1AWi4y2MQExwFEJ8YwSY8L/HFwjvstlBzEiwV3bPM+dRPDPJxIuHdZV?=
 =?us-ascii?Q?+6o6g5apVM4SFX2JBadBwpnODoTRJTRwAHbw6pm6sTEtCPXvbknZCUYgrcqA?=
 =?us-ascii?Q?s/CqLxvNs6IwDI4UcZ0qHS91P4hoCT4Q9URml1AWZZcZJvKlXaW5wpbLwfa0?=
 =?us-ascii?Q?fiMcYf8HT46EBEA3hXbu9XX/vOqhvRZC8JU8kykMGGV2eS7U+2xHMcL2dHYa?=
 =?us-ascii?Q?62nMoICtZIhsH5fZlqapOUape1Zr5pgihZJ3zGaEr92q2GaPY9arzdj8TyVs?=
 =?us-ascii?Q?PX2fRvYhU7aznSMjXH0qOfJNp0xPH5CT6iDTMdQ+1owe6FQUiOk4b+cgdIL9?=
 =?us-ascii?Q?NIFaSZrnvVbOWBkwAKZt+cd9Cu15OEcmUW/RAPq1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56d5eaa-d3ba-4617-b330-08ddfd16bcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 16:07:05.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7UTdaOf4Hi0euU+Bgj3bowYInvZWbhpH3beBdtUNQDjhyJleFpXa32Vm3k9ujaGxMW1jIxkwhGoVgWgCa4hcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8060
X-OriginatorOrg: intel.com

> Based on copy_from_user, extending the goal to unmap,discard,
> and remap when errors occur in clean pagecache.

This looks to be covering the case where an application does:

	n =3D read(fd, buf, size);

and the kernel gets a machine check because the data in the page
cache has an uncorrected error, which the kernel consumes while
copying out to user space.

I think this patch solves the immediate problem by avoiding a system
crash from that machine check.

But shouldn't the kernel be able to do better? The page is clean, so
the kernel could drop it from the page cache, allocate a new page,
fill the page by reading from filesystem, and then let the read(2)
syscall resume, copying the freshly acquired copy of the page.

-Tony

