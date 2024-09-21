Return-Path: <linux-edac+bounces-1910-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223997DBC5
	for <lists+linux-edac@lfdr.de>; Sat, 21 Sep 2024 07:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78971F2187E
	for <lists+linux-edac@lfdr.de>; Sat, 21 Sep 2024 05:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119E13D503;
	Sat, 21 Sep 2024 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHFyhoOY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55F13CFA6;
	Sat, 21 Sep 2024 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726897168; cv=fail; b=MEOcdYNurA5/cJURSyLWB3d4EzqfN3IEkdbgDeWykV/bY25hEf4MM0tdlmCPiV1FuoIM/nlw4bYOIu08LvdSTFK5/bnF7AYV+AttpZmZRXKDfYY/lbhX31kERj7ZnHqzHy2BSMNRa41eCgW8q2pWKQCF+OxSATCOOJsZIcnF9Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726897168; c=relaxed/simple;
	bh=fQfFgb81vH5nCtOnZEJr4EEOPusWNrZb2ilsD+AyI3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avyxvZD/z/XpzYqyyNr/xSBDDrB/H5HB1cYbL/ZP/zpgWc6JbA6+R3Vl44e8Sclm98wY1DRFo1dCrS98lx8bEkrBk5jNrSp4bDW7okrgGChJEnqKMdkjKoBbi9PAQYKkSubboUvOq2CRJvUb3tBMWadktUoueJy/h1sknfGoVjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHFyhoOY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726897166; x=1758433166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fQfFgb81vH5nCtOnZEJr4EEOPusWNrZb2ilsD+AyI3s=;
  b=UHFyhoOY8vFEAdCgDQhovijc2JOeNBvDmREiD/3l0MVmDCWi2yAke9wS
   dFliZykAKgF9cqU3EGNoXbq4CmgWBOYcVlhWfOKx2FPATCk21UH3fF0Ue
   nM1WAceQx/agOfbABFRDYBilaMc7slrhKXgqnShoJOsJaKUU3zktp+e79
   SbI5eytGOJ7V5VCdITfwuwSuLRIdrI/nVHrwuS53sYKTcdJqOIorkIRSK
   duSTNMkct2ado2ZNx0dHn2xSTLdwc9ij1pf7jjsLgrI5YvbYC6Epa82BH
   SzFzlfMdzy/UunT8gMoArkQHcmmkHkhFwY2SgejCGCnR9hw+MKSPAOTOA
   Q==;
X-CSE-ConnectionGUID: hxNN+/FISX25dkBMxJFDFg==
X-CSE-MsgGUID: Ns3KUYpUTCeyVEu0GynXbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="36496177"
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="36496177"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 22:39:25 -0700
X-CSE-ConnectionGUID: ISO9RBE4S4WMyEupMiEg+Q==
X-CSE-MsgGUID: nh2KUj8OSj+gNgBS3ZRI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="70113075"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 22:39:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 22:39:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 22:39:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 22:39:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 22:39:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqXiMGPuO6/o3ASGaKxMSHlOf/moOQQagc3C1f+zd6xRBVxXqwSNYZuChYLOHYdqH9JtxYOhWWJpLQKL3suBJ9pboYRU+1CQucUevWG7GNOukbVxsk8eIgoWlG+pk27ucVZ2MQQeRcXcdcEWqbP1+1k/GulG3tSjsquJiFJsTY7ecxqEEMzM9lmiidTc/gfECt+wc1ajSATLMn1/MK3C0OJVA0YHK0OsCTBFXK6/huinZlvU0HJNTpT0OfIpZxNrUCDe8i/hoJO341RUkcgtDqR7u5laEZ59FlvVUwogrbqctiyYn7IIL3cBS4d1wlDxPfXBqRHv+bzWAehqRp6W0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQfFgb81vH5nCtOnZEJr4EEOPusWNrZb2ilsD+AyI3s=;
 b=RlVFHyp+hTjaw9ogxK/gdc+oK4SFcTUiPW0M61jEyHX8AXbhotVNQm4mAq+TghUIie+Mg7u1ppemD/Gy9j8RGkkS/Y0exAsFi3NJLeq6q+NEa2V30qTtS3fJy0BnIVt6/G7SkkT10j/6qKsTiFcHcumfojYueGzALNQuF01I9eUIpi6KT+/xvxBquHdPn0ckN6gPiqLLkGJjAEmSQ2bht7cTPCb08DYQm1T3Os1GoIyqzBQ9rc5GKAXD5xOl0diWaGNwEE35tmSLnQq7Wf0LT0LWQzQCKKOlG8Hi+1Uc09IOR8cCWeyjDI5XZGxhjmG+gKtzhk9Fn3Oczqq7lXLLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM3PR11MB8672.namprd11.prod.outlook.com (2603:10b6:0:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sat, 21 Sep
 2024 05:39:22 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7982.018; Sat, 21 Sep 2024
 05:39:22 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>,
	"TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com"
	<LeoLiu-oc@zhaoxin.com>, Lyle Li <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Topic: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Index: AQHbCZVjPrbUzsWJXUSTGjVHYWY80rJgZ4xwgAAY1QCAAA/1UIAAIKeAgAEMcdA=
Date: Sat, 21 Sep 2024 05:39:22 +0000
Message-ID: <CY8PR11MB7134C3A419C1A093C9E86284896D2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB71344BE2857EA522CF71DBA1896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <7a80b9f5-9503-45fa-bbf4-d0dfa97688ff@zhaoxin.com>
 <CY8PR11MB713412D068F202057A71CDE8896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20240920133621.GC286939@yaz-khff2.amd.com>
In-Reply-To: <20240920133621.GC286939@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM3PR11MB8672:EE_
x-ms-office365-filtering-correlation-id: b9c53e6d-a476-4746-eda0-08dcd9ffbedd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tPfX6ZQDH9kJX0LYky2mKvPU7MwmH39nkRg8xn38z13Cd3wKnvIz5Xk+rCdw?=
 =?us-ascii?Q?/jyY1iPaAJWo7nshprGBcCUBgqWdD0I7X7mkZfDrvzdf22ytLH9XFY4wIuMU?=
 =?us-ascii?Q?WY9NOIX3ZxvN8RefKiH7QQT4SYTqiL9XKARFlpfpMRNjIiR/Gle6yQ88nsWR?=
 =?us-ascii?Q?ibEG4ip1n9DVOh9BVZ8YXS8Sv/7QXODMOee1JMkHn+2CQZCZPlR/LTfgi6qE?=
 =?us-ascii?Q?zsTlda9HdtPmDobe+Qnx6x+vHw8Fr/UQ7qhZ6yA7I4B+4BsoytWvi6DBCn4g?=
 =?us-ascii?Q?gisE+Sj21epxCWkHli/MK6WMwkMS6thPKtqppn3RegjvGawdWsZalwiPy66h?=
 =?us-ascii?Q?hJpO3LBIw5auwkJK3awq8JmAdOtCLvwiwvgMlJ7L2s2AO18YzwjZ6bqgOSr2?=
 =?us-ascii?Q?hJvIp4nvA0PhsnxvLOKcmRAXYAd+s5Sr6TNDXozfvyn115auTCHoTvsrpZHC?=
 =?us-ascii?Q?/0klG5EsUclqpXCZmrghwBicKoyZBOcM6pcvGU/9GBnrUtGVFX09eJyVVvS2?=
 =?us-ascii?Q?De3SZSahnXaPQVeJBZhzgOcntvyV1HtfYRdy0xoVR3F+oz39ksIh5+7v7ZQ9?=
 =?us-ascii?Q?I7wpapHgQ5vJTrlT2yV1yoSmrMA89Seuu01t7cdFkD48U3JGxsFgRhrAq32+?=
 =?us-ascii?Q?GPqbwmNOW2gKNZOobZ5gpZKASu8u2YJWILikp9oqoD2Mt/UPR4+j0d2XyoYz?=
 =?us-ascii?Q?SJRzrXsEsWwlNnJAksMMK+Pwlcrp7UaxYYzGd3Xfb/wUSCcq6JtjLcku/Gbx?=
 =?us-ascii?Q?dXIYXqR0oh0I9xRM0Oeg95pNxMLZBDkyeBZ479Kj80+UV/QLHgizvmN9T4EI?=
 =?us-ascii?Q?q2LESOeyMEU6GmDlu4h6094eSHo7Y2CxQJekgsXC9DX2IXoEpEbnMyb2h6qL?=
 =?us-ascii?Q?irWHSm+GR+5G8JyLMEXtj3p8tF5C6iaCXXwWXJo6vcHB16+YdHIFsOXP8FFf?=
 =?us-ascii?Q?FkFX6er5OuqW+etpujz1q6/0JysBYNDoAZKbnVU0BgWDpqCCxM4OBjnGVekX?=
 =?us-ascii?Q?eggsxUshpANjgOxSeCHlEUw6LttCs6vYNeXb3fJ/l34q96YrckzBhtXtc3a2?=
 =?us-ascii?Q?EVjdqfWMdD9smwocVE4bZ84FjkRTJcdiMtC0uCIbGXIjZ8+OSI9bYx5xPaKr?=
 =?us-ascii?Q?DZBpKQnx6PpFxhOHDpyUFaa37htLcXwK339MFOfveqD0n79ruFdKjqn8iSxw?=
 =?us-ascii?Q?/A/SLf9XUfUcZLFZWIRfnk44gDrt2Zyz/Xb4JP7MKi/HQbSDLICLhJQP35r3?=
 =?us-ascii?Q?3PUk81q9kzI1o8eeMSwc5Ml6CAf7zT8aM49Wg2BAjui1Q1E3a+EewKnA4m9f?=
 =?us-ascii?Q?WYSt0HDKd3iO+kmjQ2DxeSSTnOs8JOOje3pxMTS2r/lZgw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zmzvtZ8tvAPu+Bhp8iLNl3ZpRgIuTgOw/MLMeD05Nf8bjpSVsEiXjEfmm5GA?=
 =?us-ascii?Q?1Hju40NHeJ2+vUeF90ASj/a7J2HACOqtlDYJzImfaWaEB/9LqUeBnJ842GoF?=
 =?us-ascii?Q?nQ4UlRh/bdvgFi/x+ArpH5TkhQaEJihaXUCZg+iiT1OTyYP9zCbiDbnYG1UR?=
 =?us-ascii?Q?3FOSd83hf1fkZASpFUUYhNqEo+skkCy16wgEKWahnlJtFm7nx9v6a4SDjlUt?=
 =?us-ascii?Q?pvXI8fB8YOuX3En/OFxYCa5bNhQV78N5BkGKFzZYPCVaF1hUQuDhGOaOyFhM?=
 =?us-ascii?Q?LlwyiNRXDW5MXf3p42X+FeOombFdYvIJlKa3Qi3yFhnuh3EGda+gZ6BiKz97?=
 =?us-ascii?Q?b/vKvIAePQmCgpm+J1ALm4xhM/pvVR4Qlp2o1Suw1omi+2DukiPyUwYJEaPi?=
 =?us-ascii?Q?HoxYs2wRwjLQ8TYvQBkz5cMw3GkA6UqvD26Dtmt6VsQBHk1weBUglws3SA5J?=
 =?us-ascii?Q?3062qPTt/ksFe3l88RJRA6Nyj65lI6rwWOcibNXvHmcb4PSv9hhu9/osz4Az?=
 =?us-ascii?Q?3v4T/iAO/9/BK+VA59Hw94OMfN+v4pqSyvuFpCSVx77aQOyuI/hjo1nVXm5o?=
 =?us-ascii?Q?kUXLdgDHutRzoe3JfEHXY/mCf8ULUcyTj5HuQZpG3TmThphrlHycJdaYV/6q?=
 =?us-ascii?Q?ZsFFyeaxA5EKjg65eZf1PiviXRwLcdLMOLON5BEMZHdVUOTYDopHwJ1vr1Zb?=
 =?us-ascii?Q?d4tUXqq2gbyg4iPNCdVu//pxTL/F7Qjwq7l8ABkIQhXyfWEPy2GmIioD+PLD?=
 =?us-ascii?Q?HjIfI1VzBEvv9+iB7ntv0EoH4I0SMebSeZVKpz5syFE9U3dP5lJmEAuVV1dJ?=
 =?us-ascii?Q?Gvv+gW4jJZWZirvwnPdyP+rgiS448P8tq4+U4wd3V/q9vqnwgKoPeeG/8D9g?=
 =?us-ascii?Q?d2s827Xg/GmxRONsN9murWl9XWHc2/YUTudDn1MT3L8LhmaP1MAVet563abk?=
 =?us-ascii?Q?gml2TvszYoYQgEH/1nUDUiiWxemmjBaZW5vkrcqpgOtSmvGmPkOIHyVhhZQP?=
 =?us-ascii?Q?KqFYMxnyZSqsSv4PlKE53NqRkuyvYX1s9sgW+D+s04I2oKPE89uapRz9CMY9?=
 =?us-ascii?Q?4q+z4H7S/ZlD77oBWd06aRGTjWEPcSiA8GBaf5S7pW1EnRVLGpPrEDYDyBAT?=
 =?us-ascii?Q?hmTpUb2LZ0OCfLxB2zDayxjnMhqR5pB1fyIJiYnX2eQE/HiMPy8c0hqJXDw4?=
 =?us-ascii?Q?p5OkZ7o3tQZ1VlOArO7j7eUmlGr3F7TQ+SRGieVxWr3baTZNKeRr+Wp+Y/Qx?=
 =?us-ascii?Q?PK5/eUpH66QKiQ1FmHSyIhFMJoH6cUlEwE0Evilx2eO9lQMK2PKlWaiNL+sP?=
 =?us-ascii?Q?UkI323ZZWRLVqiPzCy13RzZM8RpYxKrEVh9dP5NnfCv7BcxFJa3l36PKS2bG?=
 =?us-ascii?Q?g0YABqMeBZPiMeYp/pkg/bS26o7Fzp4ceEfEJDOivOvK3wxq4wtYeKZCVE9b?=
 =?us-ascii?Q?tr6K0YTQ1OD8t2Db4+qT58aB1chOi37Ztm8T100Uo7kvlo3xtqvFyw0gCbtb?=
 =?us-ascii?Q?KY83thcR4NSHWf+RQ4bgh5GG6EXo7vJvctyZcQNU89YJr40ZXbnQ7rys0YrT?=
 =?us-ascii?Q?cxD2FzDmEXr69+KZK2f4uK5djXCqs+nRHIZVS2fc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c53e6d-a476-4746-eda0-08dcd9ffbedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2024 05:39:22.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpkR90jXn5Ue2kkdudUWUy8V5eKjNk/zoqhCT3Rrau7EwK013G5QtERTgON+mSwTZ8GB4mkuqLQcHCaUPVH6lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Sent: Friday, September 20, 2024 9:36 PM
> [...]
> > So, this is just you want to disable CMCI when a CMCI storm happens.
> > This doesn't explain much to me.
> > What's the problem if not disable CMCI when a CMCI storm happens?
> >
>=20
> A more direct way to handle an interrupt storm is to turn off the interru=
pt. The
> proposed AMD solution would also do this.
>=20
> Reprogramming the threshold to a high value does not 100% guarantee that =
a
> storm will be mitigated. But this is a necessary trade-off given that the=
 CMCI is
> used to report other error types on Intel systems.

Thanks for your comments.=20

