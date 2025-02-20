Return-Path: <linux-edac+bounces-3168-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF79A3CED6
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 02:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE36C3B6261
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF281B6CE9;
	Thu, 20 Feb 2025 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ea5kVzKR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AF12B73;
	Thu, 20 Feb 2025 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015695; cv=fail; b=ieomyuHbEwAydB0vkbq8RG24eZwXKlkxrL03Ap0scdy3hXhh3FtqXesQhkJBTrdRPH2BBvSVeADDo+Znlfh0pFGWyfkIjnIgY7400+RsLpLZuDyT1pkVGIDn6Lh6Pxy20/W22gPdFMu60MK+kbCT7qpH62K1w5CPVIlxyYbs0k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015695; c=relaxed/simple;
	bh=FSJMth3GAXej33LnNoAaybDIB7enrYPg8avGh2DZ0pM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Itj2rkAH2Xu5xKkdvtpzdhNWs3foz6SsqXbt/JzEKnDBW40x2yQPrtp0TC4xIM0M+FV3xfH+86F8EMLJriBt4lSwK8IeorQV2+lZmlMy/e21L5Q+LW1uQGkx/Jl9nMaaVpq8sbwiCfViiI5T55c1HnX99ayT/6s5LUCHdCIpwWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ea5kVzKR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740015694; x=1771551694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FSJMth3GAXej33LnNoAaybDIB7enrYPg8avGh2DZ0pM=;
  b=ea5kVzKRUj6lYmLhifVkTNdDkZvqMPGy5M84Yp3ZqdRAUTbXh8/I37wy
   zgN+Aae842cCc3f1ErjRIyXWe/UZ6+BToiPN/+U/nHQxJjE12TVQ3SBKJ
   N0xGgYg80j9Q/s8lMtKy8sSHSUYhY6byfuyS8HAWBhgjtYrcOWEv+vr++
   bpTWv9O7aTwwZWuGyVSvHFYHxEKtRCDAcY+6RYyFM27s/Umy+DWZ2FpWF
   Ef0bvjOxmryhGzV5yNFm8zvrrW30gGevftMMu4uxrmoXOWzGy8RIRz4X9
   G4FQfdjm/K0VyJ+RfkwVTx8du4fKpwnpfSnyktjro+7FLG237EnVw/HpU
   A==;
X-CSE-ConnectionGUID: s0KQpBDwSSig1RhlQ5avuQ==
X-CSE-MsgGUID: lMlAEvYHQYGEHRuIUnbquQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63256842"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63256842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:41:33 -0800
X-CSE-ConnectionGUID: uxy1j+BtTJ2Y/d05SjgkRQ==
X-CSE-MsgGUID: qMTcvglgTdWKiT4bqrzDsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115369258"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:41:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:41:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:41:32 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFiFO4QI19urW2Bxr4pNGmwVq8dM14J40r+ojpMCi7XkG/H0MnSlyrwHYkxbAWW5Vbk3JrQk9Dl6Qcymd1lkMz2Z+97vkHD+V+0Nqzp4YUGIkwPUxUGOAalZAYz80j0S4TRma6Z3jx2NDN3aOjHJdJOXyw9kRfs3bnJrQn47YIdMsDi8Vn6K+c/Sxp2Xz6zhj7+ZxFDUo+4WDYM41D1btJJyt/GaB0zvQljWj+ZXcoJGqcSYvgKGTm3E9FoybzZ1cjEMg8A7YtmhmieezrFcjMgfucTMPTlcn+Jx2XgDVGDHK2GdVOfVHV6xDLCetHptAfCXCnc6B26BTL6ZoT36FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SuzUir0a/80ys49JPCCNRJ1mtCmHYTM495bFOW7WbY=;
 b=VWRhnv9YsxqviHqlHNg8cS7b6fTKTQ0iIdyj4TgQho7n3B+c08MUvTq83Bjx4JAXgr7SF/vZM2zP5lxzBxtOlPLygubcD2g/bcX9IjKObG2sV+gE9x0U0BSeZ43Bwaff4tV+gd0R2ggresLew5/CgKF04c/Ic+7N+184Lqpzk4aXv6HzOWrBeQd4O+en8tvfx0TdqgwIM+CvVhWizdc7DtPAk/z1szzDLXvTkSrN5kPreMVOgSrJHHCXtgTCdxdGAo8Pp2VahAdxbfeKhcXpKG8Xh8VYbzm/dE8kS3xGaagDc1aNxQTUMMNcmjgjzjhMTH1BBWGrwp5kAhAxFy08Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:41:22 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Thu, 20 Feb 2025
 01:41:21 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Thread-Topic: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Thread-Index: AQHbfjgoQWs/bRLHLkmM5J8oXwf5nbNMsZTQgAIjSwCAAJ9a4A==
Date: Thu, 20 Feb 2025 01:41:21 +0000
Message-ID: <CY8PR11MB7134D8A672FE9F10305546DB89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
 <CY8PR11MB7134EE8E03532382B8FC23F389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219160930.GF337534@yaz-khff2.amd.com>
In-Reply-To: <20250219160930.GF337534@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV3PR11MB8765:EE_
x-ms-office365-filtering-correlation-id: e9ccef1f-2312-4147-2632-08dd514fade8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t8rJNHJPgN/1rwy/5QSbcREnqW21qZ6aTCVw/WAenlTY/nYJl2QnritvyQqB?=
 =?us-ascii?Q?KCYDm2m/C1LkxcNxRSpWHoS0neh0qYcBRhdmiuWBFThMxC6AVIxCvMHLCJxS?=
 =?us-ascii?Q?oMQqlELjM4lMOybKxBBj2TeAEsRbIE7c8dyV5hD3ynPrg1yIX0+7+J7i4Eez?=
 =?us-ascii?Q?sLzggmjA5AF/pYHvXCix231ixRBs2vqx0VDujow1frYCjvi49Ob68B+nAr9l?=
 =?us-ascii?Q?LzgJTOZESRH9E+3aDXWdH4+23d4gIz37BtQafAePEbZZwhASqdj3KfHLt2Vu?=
 =?us-ascii?Q?foOv6QbDJDiyaOj6Ewp+U4lx7iQd8n1cCQqNi/X7LrIZZ+OtyoxK/B1+o7iT?=
 =?us-ascii?Q?EXVu9+qy1TS5+ycx3fJYcS9ntmQ0Kc95bLP87G6DZgbOkpBKAFIEjSk4h873?=
 =?us-ascii?Q?EKyYuibLcO6ybBiASZTxD2zd9mtfhKsVq6UR4iRLjXPzusa3+s87JP7f38OR?=
 =?us-ascii?Q?med6XQ7lNz3447oILe6i8KEWjCn3/MIiyIhPCc/FzO4BRjf4rNX8ZKbGWvLR?=
 =?us-ascii?Q?Sb0AJSGCjYmGAPoC3r2ueEH/QkBWT6wza9T8OJ5pEVRDXSsPfwNfo3mX2EKi?=
 =?us-ascii?Q?qZ7g43rLQiU78E7STkG3IW6+uLZQVqmM/fcwDl0Zv6AK7dtu/cTyRNee3Klj?=
 =?us-ascii?Q?ZKe9xpVv+FpSg8Ri00gHIw4px28E6Razcg0taek+3f6I9Ph4taIhCn2HuYS9?=
 =?us-ascii?Q?Di1bH6UFZwKHMHtqfY4YJTt0PjcChyyoGSZGFKaUcFoB4PHmMSfYAmzktR4I?=
 =?us-ascii?Q?a6xAwj7SEOiPHluOifVgFA15tlmah/N+dAcv1DdGkexl6hAH44r+ICMRh9rh?=
 =?us-ascii?Q?VLt9q6Gn+942NgIidmi7leonScL4kdQ0WGBFbKp2mYt9Co/CP5izIvMNFPmv?=
 =?us-ascii?Q?2rSsSgvJ4k3zQ9l9mhMPhA6OiRjGviujtqYlfTViDqHV1II/BNncDzhnGOd1?=
 =?us-ascii?Q?asWr98JQHiVvcrJyRbzQgklOyQTneLWA51YknVfkCelvN8CxCnXDrVNs8NKw?=
 =?us-ascii?Q?PCNUDchLBtiCRIb1OlC4/3eowCOg9UKlq+TVbp3+pC0fhUSXSP06h1DE1q+J?=
 =?us-ascii?Q?pr2/R5VaIOqL5u0moPqwAXQp7P185sy7BJGMOudLBHzvotrGGtU83OOFlmNi?=
 =?us-ascii?Q?jOgvQ2AgRQ1kDi/u3HHM52dQp8zX7IcqKiAH7LNgM4SzvjeGKx2Bw/gDp/nl?=
 =?us-ascii?Q?UKLvz5ZNqQnGZcY5Jf60IQ6Xg3xffwmlZckeS7DOpggtjXk/yiuYzAa+2aaQ?=
 =?us-ascii?Q?7wraPa/twbQqVi/bGIGvTtV3NWZb6tJ4LX5ni9gEk9nwouI5Ro6FsH0hZMGN?=
 =?us-ascii?Q?ynvyvnn8nJsP1XvBiTfjh4qMwjDX1C3yzefkDvbjOlh2r7fC/yqwVEUoRkn1?=
 =?us-ascii?Q?aY7E5NZDD1MFMrOPbgEbVEgx8l9S8g+O2BbRjO90ALX3hPtkJGPeCvsvNm7d?=
 =?us-ascii?Q?o2sf9eLTtK2vKqRGBljRRR7CDHUjE0R5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o38B+id2CCEGqq7t8iekMGYeVICfcrctI+YduqUvHCnbSjeggN2FI6bmaP6k?=
 =?us-ascii?Q?Vrgb7PDbAeFTEyT9/2u0+br1wiaz9dTDcreCy4J5ABEGK/oWqA2vZnRrVGWF?=
 =?us-ascii?Q?2dXQ3zOQvMSGGDSOYPvzKEQeA65iTcX1hudjKQbP7VDJMS6M2ylnOshwdOQv?=
 =?us-ascii?Q?B35YG51b/MP1gOUe+R56qFFrYi2ZBgX5KcQefgH6VdRII8pH3kHuq8A/pO25?=
 =?us-ascii?Q?RKxFJTulJx8vJsPKowZP8PdFi8i/xm0+JDED6TBkptNwDlVxfjGAMuf5KZh5?=
 =?us-ascii?Q?esHSOoM3fSPRTwsOpVFQSvjOYWNugaIntwjYxoXOTKRRK1iGnlPTu4Pkrg51?=
 =?us-ascii?Q?MbRIdfZNEPhmEL/canA0OfU+plng52wPR+s4yAj+EIOZkvZ4fyvQAM394xTV?=
 =?us-ascii?Q?ug1825jKPqb5CAiIFKluLwjcfHyhgH37K124lMDDIJ/JcGinI6v1zWtdRDxw?=
 =?us-ascii?Q?cpI+fLMm4uYYGzsQblTY/M+NBAW1+Zo8jUh+/rva0bYvlJHLlE0aC5FkWKJ3?=
 =?us-ascii?Q?obZm4SH+rjgo7jGaU3h2FvdXQRyJD0/SECGUPEnOhiDx78ta0RveRysI/m97?=
 =?us-ascii?Q?65viiEIPtnTF23AuVL52WJWdWoCH9zrJmVx6bMeYYSbKv8rD0WmFvmHmluXw?=
 =?us-ascii?Q?nDk/Vy3n/+HFPuBukbQbBAt8VE9L5pEkSKOPdkYUiANYJgBun/6vJfCoiiT0?=
 =?us-ascii?Q?QtgXo4vyt1xcJkfGx/+iBxSVKs5uhK/AamGj2AVHNsNyfxOEab1Wwae2GTZr?=
 =?us-ascii?Q?opAwEIwdHC5bxaFojnFJn+V5qrUYYhP9NF5gyGoL52Wi/679ypb0QKGCIWQd?=
 =?us-ascii?Q?U1qaIU1qhwaH9TsEWKj6jjvi3epsq+671bjlgrYcFyTkTMvKOp1snVZmL3WE?=
 =?us-ascii?Q?Jnsm/ji2A+qnzGK8bGaw54Rw1Br9qm5w8z9lC67Q/N3sKsKPahI0gr7yGGka?=
 =?us-ascii?Q?ZkFhRcjkQOeryAwgTQoubMoeC3tQKWOX8Px42FBGCkzuZ6q/HSlj9K2s27fM?=
 =?us-ascii?Q?/BYVtrN8N/RkkTh21EnrkMUT2BfWwPPQ2ekIUmNTB/qXi+OnRYOaK8JM1tvK?=
 =?us-ascii?Q?P+t/DbeU3fTzj8pv9lVMEuYlOFJ5wNuN8RDvmiQWu1+T8khvNsHF76JxK6kR?=
 =?us-ascii?Q?1ubGLgdSJkkUVQuh0zmRfXFeR72QoeshTDABVPXAWgrWgQQ5szHO3WuJ8yl/?=
 =?us-ascii?Q?8aVRvM8glfRhrI1+FPQsvlvLEZiWwOVgNfDEM5lTG565N7qdHF8X2tL6iKtR?=
 =?us-ascii?Q?sgG/ZkIIIdM+GLd6wjVZKo2jA/wc3PS2YcxdV9kM+06ijEr03xZrmVgs5pSX?=
 =?us-ascii?Q?oV6PHs6YDtipWynwc2TFFt+QL9ZM+cFe+LTW3a6J2eoXsJLdE51xGkyQJwvE?=
 =?us-ascii?Q?VfidPlK943DKvqZsWnsaZ6mrWqEPh//PsMU53SONzRVDqlVkU8i/7uCcDkdw?=
 =?us-ascii?Q?BNIdJt/4DbWdLUowDERtUo+6t+Q8bFKE2NoCUpyhjszjKefh4f5mvMJCN6gC?=
 =?us-ascii?Q?1YvaMV+5UxsXmoizgoToFt4OKSykD98gICQiBzl1wfzjSkmoNkEdrpIDpB1H?=
 =?us-ascii?Q?57GkQNZm5cUFhFSrCsCCBFkc0njsOHrMQAwVK8im?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ccef1f-2312-4147-2632-08dd514fade8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 01:41:21.8211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQQEQ+pU3Pgoe5+mWNkk68M/ST9JJxlGoMchZh9gW2g3PnMEckcR2O7SOPzq2phfzO566TlBTOzoO7SljNsGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > Is the following check in machine_check_poll() needed before
> > queuing/logging AMD's deferred error?
> >
> >        if (mca_cfg.dont_log_ce && !mce_usable_address(m))
> >              //Just clear MCA_STATUS, but not queue/log errors.
> >
>=20
> Good question. Deferred errors are uncorrectable errors that don't need
> immediate action. They are not correctable errors, so the 'dont_log_ce'
> flag shouldn't apply.

Thanks for the explanation.=20
How about the 2nd check "mce_usable_address(m)"?

-Qiuxu

