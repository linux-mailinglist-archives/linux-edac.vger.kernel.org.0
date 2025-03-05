Return-Path: <linux-edac+bounces-3275-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115EA50A51
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 19:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81993A733B
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE602517AE;
	Wed,  5 Mar 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R87H6OZ+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17318A6B5;
	Wed,  5 Mar 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200725; cv=fail; b=iyLU2/lepFLs+0KgjfmTf0aYrZQlmvo23nCSuLcUZBnyqzpFYU/E2T/FfLaeXcW9E1jGiYUJXxoM8rzRPGYqVkISRYw3IWGNBIR6adqL/KhcFSiwYWSHUPmDWd5pQBa0xtVvZYbUnNw+Y8OBvTfDftf4utRcoQoHpaLhOXC3CWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200725; c=relaxed/simple;
	bh=8toXzFWmlLy/2KIZXMJPb5FDc6muFUkZa7OWjgdRYz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EPf3eYo+5HPiEsShk0Ly6TiBgNaJsPESwQv0vqgE2pMzvjCGlN6E+8dpN2S4Kmz+HSPLam8sc+UdgEtpjlQgbhiEDRTRZMmTHv++vbm/bcz2nxU4qK5c760R5+jFDsgN1gPP8WrgMP0EGKVUy7P9TgJD12toTbiYNyG5h9Mdk/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R87H6OZ+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741200725; x=1772736725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8toXzFWmlLy/2KIZXMJPb5FDc6muFUkZa7OWjgdRYz4=;
  b=R87H6OZ+9+/0xfSGUNZmnz1aHmBwdJ8KRXko4fwiI/SJSDXOX5Bg8S8p
   H+e+hW3U0LzXyAPlCaFEfFKmu5TFZTiB2rbyNIXNdJqKwR0p3JVox8Q29
   ObyDKJPq2yckol+1wRThmj7YJyNW3d4o4ljfTUOYxUB9vhU2fwZit0IHk
   X4L5UwAx6s4yv2YA4vsKV4rEpLp1uKiz8fSstv/ESnF08GfZikTv5NMJF
   UY66dDhLlG8injm7MM9JvLDKq5QmijSUzG9t6+d+4SN/JyeEuBw9xnJ45
   JYNDnaxnE7/CVZA/llCmjuqaDB3G07bGpMUN2rukLuCLLFRhaJbrGEcNc
   A==;
X-CSE-ConnectionGUID: NRN0c4t/RkKQSJ0rYMQVNg==
X-CSE-MsgGUID: BOHS7mvqQ8GjzooxlAtPmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42206640"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42206640"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 10:52:04 -0800
X-CSE-ConnectionGUID: VWY7VmLLS8+fSfzkl/xwIA==
X-CSE-MsgGUID: cD2rtaAkSJSmgyow9fkyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155986636"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 10:52:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 10:52:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 10:52:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 10:52:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cqz/NfJiEPq8ftAoxjMS0jahG5Umn9fdVzVDKwtSRgCpAzsH45NUH1CeTNuFonlSZxFqxHz9udEPhp9Dc9egJqw40zV7eObKS/vhbOAdXanvvOvDsZM7NJcOnvL65Xcl+on7s53dJVAhudBv5y6NOSqLYB0j7MuLSnMjMdqO2p+V8W3aCekv6NzzL7ihuL9q9Cd0UFj1uKkjiaONE19C3sL9KicwGMCGpTJkXs5SXDmhbv/WqtHiT2qoGtYFr3SoYw0Hy7a3+Inr9U4C0ed4FG3kYstt1USrWDacj0Y0LSlkon9jGZDDduCu2tePvQP59FRZqUMBwcaoP4oWOVmzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaYRSA6WxowHJHLNj1OgBx24zosO7WWopIq3RAIxt40=;
 b=vHosXrOiSc2cNsJKUugfrT8v3n+acI34jIGb3TIhUwIihg3BYvka4Rw2dq5pyBfneO0+Q5hK9NGtfyYwHsxSiG1tf2qw6hrXE93DvmyhgMoSrlYuYlmkb3M6lWNhA8jDUoQoVi4N8NuCyOaOd+KAgRs6uiDgjQZEbDEqBU+ntsyDFTUDsPkSSNN2EJxLpFUpe+YcPOdFci7EpOOGKGp3FwfwoM7WXNyI/kgoS6q1hPrjN/U2dZpku1M3gKZ1Dus+0bJsY1e35zqaesoU+v6zvDpFpvoTucd6XJLGTNmGGASm+id3RLhPmtn7MJjnCZcSdWxqggjYUGHEyGWrJNeHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 18:51:57 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 18:51:57 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "rafael@kernel.org" <rafael@kernel.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, Somasundaram A
	<somasundaram.a@hpe.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
	"prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
	"roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	"wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>, "linuxarm@huawei.com"
	<linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/3] ACPI: ACPI 6.5: RAS2: Shorten RAS2 table structure
 and variable names
Thread-Topic: [PATCH v2 1/3] ACPI: ACPI 6.5: RAS2: Shorten RAS2 table
 structure and variable names
Thread-Index: AQHbjfjzsiWvAkyiU0aFqbnPrJLz+bNk4oSw
Date: Wed, 5 Mar 2025 18:51:57 +0000
Message-ID: <SJ1PR11MB6083959730C8EBC504C05ACEFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
 <20250305180225.1226-2-shiju.jose@huawei.com>
In-Reply-To: <20250305180225.1226-2-shiju.jose@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB8165:EE_
x-ms-office365-filtering-correlation-id: 843ab883-4788-45a3-2426-08dd5c16ce3a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?RUeuXdBdtLkUDRnMoQ1JNeNE/PqbMvWjw5uZlBO+SnGBRJ3lIMwn9cAW6gVm?=
 =?us-ascii?Q?DdtJMe5i3MQ8rrXYCbUJosRiEnmQNu3oHrtL0Do/bVl7M2ykexNg8gE+ga++?=
 =?us-ascii?Q?z0XuzqthGVChabUSNZYUwCd2WJF1DWpJ4IqKq8Wn77Z9u1rHegLUfd9LvsPz?=
 =?us-ascii?Q?4lJxsf9jQUgkJyZhzpKaTvpUhhKbgHHpH2tWrFG19iKVBHmIFir9i7oiBOpo?=
 =?us-ascii?Q?Jm7IuicPJK+e8BRBJvsjxd8XOyLkUKJkbnl5vt3QUDux6pIsM7D5xVDB30Ie?=
 =?us-ascii?Q?S9wr0NaAOIBJLih7CEYFVfnRvd+NwAcg9jwXx/OiF7D5lfOWKawQj8AvxtU7?=
 =?us-ascii?Q?99aDwoInj6nSf3uaSpmJBUx6vS9M1pc5HawWjVRmQTUYD31Z2M1ScEfqDmWO?=
 =?us-ascii?Q?rrebt3Ww77azcPhijUFBYtVFE0knVFEYSnRPcE02bOn8U2k5wsFXGFiSd+Qc?=
 =?us-ascii?Q?KBYIbt5v6Wr3pZj6nrnLZeIk+hJtiiyPRFjn4MFBczBleRGDF4Q8fPWhg3R9?=
 =?us-ascii?Q?wgQHCQBRKsNQ4liwkTmSvqJi5otApvTqbgZ/XerO+HOa9f2ciU0rkrgQYyXm?=
 =?us-ascii?Q?8DXSdto8IQSQ2+UxXLm5Ao3taV9BjC3S8taQ5+Oh1ii17QlYzn1GprYWpVC4?=
 =?us-ascii?Q?/y+24xPSQXFAW6/HdYCzRz/zhOKVOmPKZbCPVxQKpeSS5j6tL8sBLmvuKO4V?=
 =?us-ascii?Q?eKDgtnk30W9Q+YFCmhciPrJPZq0pbSrPYUngCFWbC1Ai2aBsoi2WGql81sZu?=
 =?us-ascii?Q?pNLc3r2UHYH7A+bGkCQiZsOiXE19Ri35m0KS/apPlqMpHa0sJDeqH+lRTP/m?=
 =?us-ascii?Q?4eBfVSyi08loo2QhI/txX2+Lq89wNbTXELJJli1MEZdO9pIdlg1yXDePGRtw?=
 =?us-ascii?Q?MVHfGB5T4NajmaAdgAZa63Z2BKqUS9/81z+RiEJHMSB4u4tz3dJ5MwF05f0n?=
 =?us-ascii?Q?8wj/L7FMnleBCixFqeJ6HJpjrzmiwG+wpUASH1cgPsNCqjASn0a/zNarN040?=
 =?us-ascii?Q?z4FpwOq4LEgK6ymj2/xrhdc64ZWciQ9Gkr+dSHl3kyZ1LWE0VHEd5IAMcaDh?=
 =?us-ascii?Q?eMiakTar/kR9q1uY+/fv+8Z6nzdfuLHWMhyPd89SmfGPLuO24UKLKRD1Q6+n?=
 =?us-ascii?Q?hiyje5qOVBQjgZjGnKG3RnoH+Sm6WITIsRwsKbN+lSwPpxJdDtBNS4TZMkMJ?=
 =?us-ascii?Q?EpSQUL9o7N5OzUcCheuWvwALBuzXrRqCy0xj0kk0lWQWqJJnP2n9hbNTIy40?=
 =?us-ascii?Q?Iyek5uBktCMEzcYSGwdyCySD4mNrhwALiDlgnimMIyd15rD0sDUnds9kG56q?=
 =?us-ascii?Q?z9d8z1d0DCV874QwTg2GJdMahS0BwR/Gl60lDvDtMN6S0Q/d8DF3FPlSlcir?=
 =?us-ascii?Q?9PC125BEu/g0KpJOViGYhbfgFh9WIU8Re30I6bCB0uazVq5VpOOjQIq4YoZg?=
 =?us-ascii?Q?l/U2fpkk26i4BKKFw0nymKgMamwmJ+RYT/2XB0cnvvMzsjZ36Eiyyg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C239LXoskIQwMDC6IlFm/IjbcnnSO8QXNqfrlyrGAxI/Altb3KC2eopDJ4Ob?=
 =?us-ascii?Q?xZZyBUeY8j8lCxAT10rlUQCJg6l4aDBf+naVD3jT/xsDNbhkMxCnKTJ49IeF?=
 =?us-ascii?Q?HqSDnPka28y3Y4LNb63O43QBFuUC+SxQcX1K8cXyuTxFfmZtx7InzdB3gG0/?=
 =?us-ascii?Q?j9mISHCQHPZQ1XDqnFueLusdl0d3c0XWAslfu+SGJR42PD/AHSAggbROSsXd?=
 =?us-ascii?Q?PznSg0h+PryNgG4zvtoA82g2x/dbJwn13C4JUwx0YAVMvVxKKUiYfFUxl1je?=
 =?us-ascii?Q?n55fS1fEupZFUOuPltEslPTUq3E+2z7lVxOAU6rTGYkVAZ5AQBqCgWkq05kd?=
 =?us-ascii?Q?if8D7Avrs3byNhg/CCnSyFH8t7ltzW8cpWo+pzr58hnZbeVObL+zAATZq1tO?=
 =?us-ascii?Q?l/BYGDzES4AsIxPgY3nFYDMpCmw4fBc59bOL1JT6+AGaKa0bT8HjklBussnN?=
 =?us-ascii?Q?WQqTLWQhYO0ORWVM2VnmgYsNHeKHDwJGbSS6trmUkOoMqSMZsAD3ClHQGUmm?=
 =?us-ascii?Q?CMluTnuWVyoGjwFL9XSlCYVPDKWvD4Ql5c0/g4kNe8CKxw+0FeQU0Eaif76Y?=
 =?us-ascii?Q?ZnrF757YnMr3gIoyPj2rMcgp7VD9DHjsRJKFHwY9i3SxjtXEbeZxSXB4cXWS?=
 =?us-ascii?Q?SQXDWY4fP5exRS3AHTShsv2zW7OQT6sc/YUngbOLPT4ht+VtmWSrf1gLMP1W?=
 =?us-ascii?Q?iG6jIRSPJ6zNfr3Oujl8ij5IlEWfmf6D/MIqNeP0/Hu2KUdsJP6oCidY+1k5?=
 =?us-ascii?Q?dZlR7fl85QQQ/HGhGWU6+kucByM2djtm8JBzwm50baWtpDvCkBPQj03GLbE+?=
 =?us-ascii?Q?kq2T11eYLPX9CyYpGCO6uF/A5qYnZ6OKD95PzvVY2J0NniMhLkVAr25EYIY9?=
 =?us-ascii?Q?Jc/Ejuvv3yExoxbbVUW5lwUK4tvKTwbPH6vw1mt30cx+JRoFIYF5yGQSx437?=
 =?us-ascii?Q?8C7v4Gwt+yzw9Xw7xxDJSso5Wjp26SvaA48HzPjYgLMOw3oGAZAQ25krc7vn?=
 =?us-ascii?Q?03v4m2yjpk7cl07dXcfNwyH9GDFrMPZfQ4asE78i86insvh1Mc1u0ak0iWwI?=
 =?us-ascii?Q?k0qj7q5wR6UKDBOYaFTqmIeZHYNnAjOf2RnAvBTZcwyf/szZrb8LZPrdr1qz?=
 =?us-ascii?Q?mRjTuz67Hvp3EcCxk/nYNvKaD8XOCoXrFerHTE6YJkufln8E13IRAgIpIfcG?=
 =?us-ascii?Q?FobL75PwRrOni1Ynj/uyCXVgmLLAluYF5Fr4DZ5jjzNa9YST38ysmlpnkSy2?=
 =?us-ascii?Q?9Lf8imCGGonhwQNJ0mSmnU67k/SqpqPHQUOHoHK77kdTD3UDgE6YzhsUM56w?=
 =?us-ascii?Q?SGJ28A3hi5tyBmPjh3eHxTUbv4dBsHWjAXZUWfANk5f4lB9EzE510CRqJ247?=
 =?us-ascii?Q?HDiPPx+YfFe4kCroCQp9AmTQl3D2l33GfwKtRNkYwjsUI6+HqRLim6eA/7Wb?=
 =?us-ascii?Q?Y14Sfy8JATwTJrjepi5jEB5o4mmNQE4EaiwS+W1P5sZEMOnlBgRPpcJiWNlt?=
 =?us-ascii?Q?EwGULVFEij+Nbb0Cy4wrL4cuQt6IONu7FBEKfV9GiuljVKhYq0KQGKnIgdt1?=
 =?us-ascii?Q?jLX4pa+NiM7w/zab6UDSx9JjmGKkg+s2rSMG+DIW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 843ab883-4788-45a3-2426-08dd5c16ce3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 18:51:57.5275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCL9fxVfHKh7stfZ9hyz+m/0mX3rSO/0ri2eh14585G8jwBpYQhE9trWe51hcuAe1kc4Hby2yV09LcKfGch4kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com

[+Rafael]

> include/acpi/actbl2.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

This file is (somewhat) automatically generated from the ACPICA github repo=
sitory.

https://github.com/acpica/acpica

I'm not sure how much divergence from the original is allowed.

-Tony

