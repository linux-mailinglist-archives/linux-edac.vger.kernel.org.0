Return-Path: <linux-edac+bounces-4045-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E247AC8CA2
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 13:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFF516DBA3
	for <lists+linux-edac@lfdr.de>; Fri, 30 May 2025 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D81227E8F;
	Fri, 30 May 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR8K3CoF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B719AD70;
	Fri, 30 May 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603432; cv=fail; b=X+ynLfq6+adinE+i5Mqrix4VAJfimivnFDxkWJkHkIvczpeePNDdcXUB0ZQ1xuXGyJXBbs4bbd0bBjZ8H1bdN9gzOonuv/MUo1EW0IMvn4Po+qvtJixca+3CCTA+WcZ0Mxn0GvelsuTZeyh9tDg09d+WeFuonLofGbqw7JZ/sw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603432; c=relaxed/simple;
	bh=dAkJnh74hjwS7c7c6h82oonWxqJf9eDsVvG1geUSLbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qOA9Zx2ZJK41tWY8v7PAaUnJuPiE+RAGMmrTF4vz/MHxDEuDA4nWLzlqug7f/MpVrHPrBt+vrRHsuFWqy3g3zi8IclAvvSCyyj3/uXNRLlVPsfnvqfglVLYUcpDj/hsfHmHU43yjzT6bbPfz6Tojz6Pn4i1LWUQR4an91x7l5Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR8K3CoF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748603430; x=1780139430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAkJnh74hjwS7c7c6h82oonWxqJf9eDsVvG1geUSLbE=;
  b=AR8K3CoFIX5S0BpjRbuAkD9USxv67KxkuNZAZ5uiNDT5WCro1Vmw3J45
   V8W57LvGKtMNNXaKCOkY+s1AEqkP+MTCDXnXzTdARAFYiBI8jM34bfIAy
   RDxK1p+shCULBXIgNmVu+lXDo3YHR2TFpDxEi9tpas0/QovkXOSufHMSc
   8LHgN1ljHRDrEsWZebu042IEy7BUMTIqd/i0A6IshfAy1ACB+1WQPMxJR
   WYtVE2ge0hN3YSt3pfxkYMxDTktqYu0m5aaKqmawicsZ2V49S07m8I/B9
   bTTohKrGyjCt4E+8DjWZVgPbz59nAxoe1M7a2UpC3tEKMKKVzf3KO9KRp
   Q==;
X-CSE-ConnectionGUID: TbVmhB/0RcqsE7zhPPGv2g==
X-CSE-MsgGUID: bMVLtUmhRx6XLHdg2lVnGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50389494"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50389494"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:10:30 -0700
X-CSE-ConnectionGUID: pZtzXkpaRnGsHExKPzt39g==
X-CSE-MsgGUID: UfOVrMM4QY+Ac2jFCBR/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143681721"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:10:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 04:10:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 04:10:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 04:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs8EcSr84zLFFRL/kdk9HVEaUA4aQrM96ISSkD5uyQUv13GdSifOVtwPeWKnAJmz97Ws/M3RNjg+9vXCkeKsHj+a+cAuLdnYj50ENguRfdEVM4jdVI9DmbpV5W/G5f1+ZQl9OrcDZ/vLru96LsRpRJy1lp/6mBj6piDWfk3OMSac8KEgjjhnHKltxuw9c9JDbQgdin6Gn7nDqsCE8HUsb1zi7Xv8HmjCPphXRbD4ZAO7QgNGKQ7MtplqdQqgG2r7ZoT2i7RFv1HmMr3WpdiW++WBeJp9Y3yNlSHWpRWaZNbizeyE76Lk5NCQp1ecMH/Ovwhr4dUN/ZuGqDHKMPmlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MxEWY/GXQclSJAPZ4TBdxcAxhRpsARYeqCjLFOKcFo=;
 b=Xe2uOjUAnIqZr/FOLm3ZzzxfN6O7CRbaRpWdGlXP7NQAiLyfWr9/KVP0poYnNVZwKh29pfBF5gZTXlpeY9E237gy0b7WFivtKOeHQSPtNj+NI2PiVqCrJwPQhduwDaU0Nv4rNW2bdAeX+Hi91Mv7qCOJQC2yUANtckVmC4L+KfqiZaCP7onkAEf55CfX5syDqokxNsDIFszhR/8djzLDSRAjGh3LGGCCv4DYkFAKPVn4P1b19oDWsFla0krYv4KDpg8iw0TaKcCv2nF4QBx9Nx9tvafOCfflrNsP7i+9Jn72+6dwYBwQZxFFW8FCLJOgovjPygwRvC7Mkw5aq1Swcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 11:10:26 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 11:10:26 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: George Gaidarov <gdgaidarov+lkml@gmail.com>, "Luck, Tony"
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Jason Baron
	<jbaron@akamai.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, James Morse <james.morse@arm.com>,
	Robert Richter <rric@kernel.org>
Subject: RE: [PATCH 1/2] EDAC/ie31200: Enable support for Core i5-14600 and
 i7-14700
Thread-Topic: [PATCH 1/2] EDAC/ie31200: Enable support for Core i5-14600 and
 i7-14700
Thread-Index: AQHb0Lcq44ps7hN2mUO8L3saBbm7/7PrAvPQ
Date: Fri, 30 May 2025 11:10:26 +0000
Message-ID: <CY8PR11MB7134171DED8F7B9817474D2C8961A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
In-Reply-To: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH8PR11MB8064:EE_
x-ms-office365-filtering-correlation-id: b0d03254-a661-4658-9cef-08dd9f6a94b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?neFFA8wdK2eK7lqzorThQaWD9PKIHu1S+9doVZxy0WQ86RerqetG8O41qgD2?=
 =?us-ascii?Q?YRjJyKZY91rXi2EFVCipZ2t03aDVHysZVxa/wrqLJyh4mkpmrrNXLD0PUvMK?=
 =?us-ascii?Q?QDnhoC917QAR98NXmHaV4uKam9hktBp/nQApfeiTf9++2M7M0CQzzsI2NZyV?=
 =?us-ascii?Q?yyQySU+32Vyp4Jo7ESMqqOw2/qd4mdmSDY/Zm/dfIgqiwkXSZdQnP/ro6HhP?=
 =?us-ascii?Q?LzHRRSFLHStMcONvoQnZDw2PlsfJQShHqcaxMHhJig7mIPZSnjoJnLB/RVhU?=
 =?us-ascii?Q?z8ytDDOmEWq8izoxdPiOZzylAC5FM40XaojmN/vYgqoAEQUTrVRl9ED63/yb?=
 =?us-ascii?Q?9aJ5bwRLFJfE0QJvXwaUqu+yd6HfK9HjyKkJHy6Z5JBjqTPyVX6ymt/00RZQ?=
 =?us-ascii?Q?04TeOahDXt5prONiU+2dnjtMNJEd/uGm2m/RWF8hR2uPurstbffI4AYlpwwg?=
 =?us-ascii?Q?WT0ekjuThC7E2zI1NYDltkPPLuVQPEOLWaax8M78K7AJMuUoly7jPrkvjuHj?=
 =?us-ascii?Q?uuLH4S5sgUENUqDnp1/yCx0lqo+YGBKGcbTfHPJXo+pNVrBXntxKoiX2+E6I?=
 =?us-ascii?Q?43Ameujof4IW3RKmeFos3KvF/qSzsJHGWoN6lQ9ijv4tCq0ONC7wKFyS3KNW?=
 =?us-ascii?Q?YXmQCxuwjlhw5wrvtTtpAKpQ3uwmWMFcYhn+ckD9YvUfzrCRKVQEA2bXL5uD?=
 =?us-ascii?Q?DYiWC2nMZi96U5vFPHVMk9TKZYt3v7TioAc4BReHgaIE48XDGrYxcFBiZs4O?=
 =?us-ascii?Q?VSXAsKhD9VWGREh/NuMA9ge1r9i7RoFhge1iqvtvBsb+JD9bt1B7axmTHFVL?=
 =?us-ascii?Q?xFxzsDZ3BYQoIT9jzrYUlJlIhknlGc51d7gzBN5TwmpckM9FuZ5NU2oVgUfz?=
 =?us-ascii?Q?n+Y5otFxw7bobg27qFTjagdvKyWuYLz1Dxct9KqJ+r/+XdO9NXps1TgwY6xG?=
 =?us-ascii?Q?eyioquDokfHRYvTsdZ82R1We9IQINokxDhx3c80Jp9nMBsIrxVMWczRSjA5I?=
 =?us-ascii?Q?21HauCyBRLb+yw0nOv6bxbMvhTklDZtrhR3Y8hFDuAZkfCklY+S2BrJ031XF?=
 =?us-ascii?Q?tTFkjUABAnUEl8NGjuww364rn8/HTVGIDPDFq/xEEXyKBeAG6yKVVhn4O2s0?=
 =?us-ascii?Q?w6jebixqRf+6PDROZsqW6CPJuoYBHa8XoVeOimQ2yhB9aZgKyN/LqXM0dUhl?=
 =?us-ascii?Q?SdNc5s4tl+OO5Z/kYoVzpxWFcEwrIZF4swhMRdMb6hqRB83G4vDaNlmu9Ssr?=
 =?us-ascii?Q?o0Whh3dS07CpUvLQH6DKNt4/bNZ+b45q/ifk6kyOYwz46d4b0Ee/ktGDKdii?=
 =?us-ascii?Q?aiprJj5oRfwMI0vTtzWPu8TZVtq8bVXFt0sxR+a4aPGml8gjJKOAQtGc+DQr?=
 =?us-ascii?Q?+pHXGUbwnrQULafJwddhS3chhG1WfNr3TBG1pMd3Y01txskPLcpKW/rTwSNT?=
 =?us-ascii?Q?AGY6QDWx/aY15EuubCrPJ+x66Yeb9R6zG9vcf8b74dH9bvHf0kxjJQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bb3Dy5/d91GcXpYI5lg+IFxGeJCy28Fq280AWe7Z0Aq8Yhoy/CLLag7X2wtT?=
 =?us-ascii?Q?NUxRhAVrhkIVclfeIcjVGjKlnUgsfQBNzlpGdLkYJTvE2iiqEg6rvDpZFEmG?=
 =?us-ascii?Q?t3B5csHuGXcvIKf3pjjzafo5wG98ZfVJeIc8MUY6DHOPAxTD9mtaCguC7cay?=
 =?us-ascii?Q?4Tsrr7wdYRnjJBNQ81hsuwEuGT7P3zJhNn2F++MoHMLTvoJSJY50rwJZnPHS?=
 =?us-ascii?Q?gdwLmw3xYmNljbEveDdeR1fy//+kIkcn3ZbsoY6gLOTseB3vuFZPuFvR7yEO?=
 =?us-ascii?Q?a9HpAM1QKX5FSQEvlyGqHV9wfc/gxBtmyO+j2q8rPfQNUUjbBgj0WEo7j3ur?=
 =?us-ascii?Q?rXGaKlk/vpcbbTyuzcLhee9PKmfscVuSk9aiIYzaqw/wI19rhs+glHcSWRRJ?=
 =?us-ascii?Q?LOtG/AWBXyHSkgl/FOro+lU9kxWZl0+D+3gcrc8dvFZz47lRUMruWVVnjEMH?=
 =?us-ascii?Q?tALcRN2zw+yE4WmWyrb4Rry3RqM5RzN+DSpt9KAp3dNMTz4gJBol8GOPkXvq?=
 =?us-ascii?Q?IqNYNaWRg6QBw931SvNZSCxBDdSzRygT7VGunbuU/l+u87GhIMaa/OUICDqg?=
 =?us-ascii?Q?TorA2oOLs1InP/ywbuf74CjhmpWuS7hsTE7aRveEuOLccUaByH/GxnPF+zqi?=
 =?us-ascii?Q?CJNqgABetyuTfVpWf4dPMoewhVoWLr8KXwCaRBTNUD/Q7Hvg+UCVRRvt3tFu?=
 =?us-ascii?Q?iOW1It9rpUN2HTAzRpRBAlXXhM0Ntt+3WnZ+Zsh0bSicmQ9sD6b+bJJ6H40y?=
 =?us-ascii?Q?6432JUn02CSXpFQJ7f0l/rFLtjuyWRpN80aYMqjIS0NZ4B1/wdudnlMOQhTy?=
 =?us-ascii?Q?5hVMkHxivIvC5tw5Pha7iGsHHwlN95193JTq+CNeOAGZ4xWo5P+Y89UJhKaj?=
 =?us-ascii?Q?6j9mRDKtBtCtj8D5cwks5745sEEKNfbeJEJXyvAqBB+qnY3l94db/OcqhEhM?=
 =?us-ascii?Q?krYmyYZ2WjQWTRcCs8T0KSBAjiek3dylvFE9bz9UPm6l28iqXCYQTrLaUpkd?=
 =?us-ascii?Q?YlaJ4NRrZhZk+4BpsZXlJ/eEndtSJeAy8UJ6Bo8di5YmoFrl3XpIFrYLRVS3?=
 =?us-ascii?Q?+twgUG5z8jSjppDxIXJTcuQ1jm00NCiYUqjUnyRD1DhqNzqnjSEJXIdXYRBF?=
 =?us-ascii?Q?wJXUMRmjTj6RdLB20QDoXbI0VTdeWYRjgnNWBAaOm6YXnxSCtnqKLOtW/kI4?=
 =?us-ascii?Q?8G6xW7DxKI/YA/oZbt2GDjv0lS2MqYM62x6SW6croLBad7/pMIIDs96LzmTl?=
 =?us-ascii?Q?Yj1UGP1u9ne9us5T85XPwhFFcLgKR4WMpRyekBXvjkl13HL4L3dSjj9p9xTD?=
 =?us-ascii?Q?XBxrJnX60wCG9U1yDB9ISC0P5OC6KUZs/DTHi8ikrUDvnvrt2V0sd1sGpfzx?=
 =?us-ascii?Q?E9eBqQbWLV6M3ouyEmX4yJakORvYbffqWFAsKsvG+TMGbOnaAFnSiuyFTMw+?=
 =?us-ascii?Q?1eZZyyzfDLOztdKz1AawLx6Apz9HI1h/pRUQCaS3ZJGTh2r4MWl5pamMnGjl?=
 =?us-ascii?Q?++ijmY0JORaJWpT3drFGwnx/HC5hYWwA6HrvS4i0tub1glfqapwewApgUEAT?=
 =?us-ascii?Q?45rQ/CTXWu4AHYtT2jnf3eQXYlRGvQsHoKvOztvY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d03254-a661-4658-9cef-08dd9f6a94b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:10:26.6525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXvsL21FYQw80m2wf59do2oeRPpIVrTQQ4kMrZwOvNCFHdbMHpQVaOo1cOlbCZgmNTcSzN9BmNx9ZuRlPs+8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

> From: George Gaidarov <gdgaidarov@gmail.com> On Behalf Of George
> Gaidarov
> Sent: Friday, May 30, 2025 12:30 AM
> To: Luck, Tony <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Jas=
on
> Baron <jbaron@akamai.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Zhuo, Qiuxu
> <qiuxu.zhuo@intel.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> James Morse <james.morse@arm.com>; Robert Richter <rric@kernel.org>;
> George Gaidarov <gdgaidarov+lkml@gmail.com>
> Subject: [PATCH 1/2] EDAC/ie31200: Enable support for Core i5-14600 and i=
7-
> 14700
>=20
> Device ID '0xa740' is shared by i7-14700, i7-14700K, and i7-14700T.
> Device ID '0xa704' is shared by i5-14600, i5-14600K, and i5-14600T.
>=20
> Tested locally on my i7-14700K.
>=20
> Signed-off-by: George Gaidarov <gdgaidarov+lkml@gmail.com>

George sent me the log offline, showing the successful loading of the=20
ie31200_edac driver with these RPL-S compute die IDs, confirming that=20
these RPL-S CPUs have ECC capability.=20

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

