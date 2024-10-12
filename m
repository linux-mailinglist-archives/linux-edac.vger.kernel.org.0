Return-Path: <linux-edac+bounces-2015-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CF99B119
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 07:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9AF1C20C3A
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 05:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733E7E76D;
	Sat, 12 Oct 2024 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq5t7SkR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC6946C;
	Sat, 12 Oct 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711450; cv=fail; b=IeXYVRmUeOnBZJQqC/Z6EeUN181jCjv/7L2WsSPs4otA3JEuqnL71BRvy5xPJ/AEan0MPtnGoFvk/goCdT4BrPTnXTmqdwHIJG/Rt0yIbw+3erTSEmpCdRA3FsTvt1pd0HKZbgQD5gDTELBjiEzgfrm6ckcepCXYif/J2a2shOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711450; c=relaxed/simple;
	bh=kb8T6gxNcHsJcs84FkQUD0ToBLPGle5HinqhJGmwey4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIA9OwdATDPDT8fSGnhqS77tapOvv4C+5PAzPXvpjevTWk5ZVjWlUUFm74jV5MpQ5+Sxj3xfx5TbbzTcBaQuuyY3iaubNsdAqK69v24zpxsQs3Hy9oGjnZbAwg5uI8xVK+YwFBAA0tpYFYYebExo1gKDTdLXAFpiw80YeAgjKIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq5t7SkR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728711449; x=1760247449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kb8T6gxNcHsJcs84FkQUD0ToBLPGle5HinqhJGmwey4=;
  b=Oq5t7SkRWPrT4MISpiK7YuPS/6eb0zP0hAOE8cZsQ50Cvoi4wjkqS10U
   yKlgsPAPkDnk4z5MAmjS6DLSyMI6ppqpuCc2pTkYkittHOa/XTPKxvVDE
   mJgVI5iFv2YQ3R5vGpZtJH9IpURTodHqXTMEioyflpAEF5UV91KPVDtSj
   XkrKV4GzEpqNQi/+I1gUzfTLG8sH3P7ZuMPDmIlbTv+xRCivPGLfuE2+f
   qD3kURC1L0Fcoq9g9422Xq+8bL5TzD6PwNdw+u0apmSYuDjTY3noYe0BR
   usv4lAmHIKFVZdQc5uB9FKVp9U2Nkv2OzYWuIXqvhB5Y3tiasNKiot7U6
   g==;
X-CSE-ConnectionGUID: mFXVKGIKRhiHFz2qcaIBiQ==
X-CSE-MsgGUID: cBwQHfPSQRqwgv9aSb94Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39505560"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="39505560"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:37:23 -0700
X-CSE-ConnectionGUID: 1iNo/ERITsSpyEaUUhMSrQ==
X-CSE-MsgGUID: EaxFrffoSpakI7akPRkEPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="76975488"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 22:37:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 22:37:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 22:37:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 22:37:21 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 22:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adYtAZOt1KSvpQZacpNcwdn8VKUzdAZBumhimsp0mJ2WpkQPkyGDpJ+ltIYf+NgWYq/9P+ZmnS9j1fDJk7EW2zPkD7nZVMa13adg0JyEAQGBq/EJDrE4zqsBHcgfW2MSbUq5xblInLnXqcqMi54qvM3mKLIJoPCtRSR8O7NPzgU5j0edEBT4pO6f7y8k922eKbN5M/OiIBFfqQCMFnZayGh/KSwGZ0rVGT0QjVsFT6W+N0uSxvgKIhH1t+h42g4GLg7SHrkMSkdlgon2DjJmAyMwnuv/Rdt0RHDPwin2TOxGcklhk1qH6bp3FeUnDMGqOVgBFVgnyYepeRWg5rYvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOOYtJz/q2kfWR2fILKOjePgA2emNUDJkKGBUmljDsg=;
 b=mxM97CX+Aj8fQWweVk4kMnIdjqDRmNblXE2hVv3k4cw+/5s+R0hbz3/XtQiZ3MGYo0r+c2dGzi5BWtyXOavlfCM7E3wGxI26BKs03duZg95QFvBhMGzTxALgIVKw9UzGAm1I9XdYVngxfrX30fkE42GyDyl1b+eOkFzxf1xB5zwWai2CP/zj6oI4Q3pcZX2YoIl/iRHuTIRqMTwhVV3DtkFRot0lKYjMBVtdhCO8OUptVv7uGXlucP+5g+lvk+/CpKRrvxW2N03TuQSV4cgTzOgyiqt5n6vT2aUObo9LlOg+5eNHrzQ9vFGJQJpXrLg4Cq9ciJz4J6XvcHFNSTKNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.21; Sat, 12 Oct 2024 05:37:16 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 05:37:16 +0000
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
Subject: RE: [PATCH v4 2/4] x86/mce: Remove functions that disable error
 reporting
Thread-Topic: [PATCH v4 2/4] x86/mce: Remove functions that disable error
 reporting
Thread-Index: AQHbDYuCv88QOUn9kUSrVGbMP1QigbKClMdQ
Date: Sat, 12 Oct 2024 05:37:15 +0000
Message-ID: <CY8PR11MB713464ADC274CE5679994C4E897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-3-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240923073311.4290-3-TonyWWang-oc@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB6472:EE_
x-ms-office365-filtering-correlation-id: bc7c46fd-ec8d-4e3d-a770-08dcea7fee4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?4RQ5FWcUh4PjU5/2TFWUFnuiUHKy8xfkvCBO5eOYFWU2U1rRy9g2iFNUC3JF?=
 =?us-ascii?Q?zkgj1lgMokIeHzGKJPjYkI8y0Ed9S0Jol2bWi735hRo9LdCUiak6pckbzcqv?=
 =?us-ascii?Q?UrvrHAcaq7WiuOEOGkyIVTNmTN48j7d6QJF921MW6YzGMtP3lD8FcWot9hvx?=
 =?us-ascii?Q?9COOLu/UBoFY9ojyLa8Z903VWTonc28FBBCwOPFTCL4srRmMKD35z/sSRUmT?=
 =?us-ascii?Q?c4MPdarZKXx/otZkIlthp3t3kZ8zqRKlyriWgZBSJKcQMTYO8TNCWohv9IsG?=
 =?us-ascii?Q?yZ2gXcYqHoCx4oicc0/L50GMMjl/yjina4GbVt99o6LwxirnV5ub6tDJpZSe?=
 =?us-ascii?Q?WqQsW7UTV1pxdMBzSTvdEaBXEQsXrqeG+AUfVQQdxrqml7rd2355hDeYE5m1?=
 =?us-ascii?Q?WyRI/4V1EPKhyoz5qLtH84c4TpyNSTP2AzqbgLXhn9MCg79re4LBW2yFFPzG?=
 =?us-ascii?Q?o+NO0V9yOb997K/N/PDZmFxUxmFaihEWCY9Rqto9UbDllxMIx1z0hmA2snyE?=
 =?us-ascii?Q?2m4zGtkI5q+5QCuzE1iM5zQNxAci12FNDV2zxhtilfF1x5tQrx0pp5QS0hg0?=
 =?us-ascii?Q?7YJLefGO/JuX1HR9hWPqnuZOLtD2xvz1IdCCjCiOCipYPzKXr8nJwrPB0DzV?=
 =?us-ascii?Q?XOGTscYzliOFqyj0NU7MLlnkfwMyVhvPn6VLayiN5LEE11//aXhBwAeqiWPP?=
 =?us-ascii?Q?Uo83HsvmSvrvSkHyuXkp1uGqkeLKBz9SoqisWZmF8JY0ytTMZhumVQY0TOjR?=
 =?us-ascii?Q?FVf+/7zO8b880SqpSh7AA/Nm6n6XOqsWC35+MXaGn5ppz0abCs+FAZ521Tix?=
 =?us-ascii?Q?9dnvGUk/AbCZ8Krnbj1J2mtrk/ujZ0uO+9ixUyir9aDAxTMV/AdJl4oVoSck?=
 =?us-ascii?Q?Y3hPdUqUEtYviOU++rxPKF4St2y9XJV47H2cMt08eBKeIdUzqwYlEKnKbQET?=
 =?us-ascii?Q?fCu60Eit1puXthtyn6xoI61Y44j3S7Uiwvl+oBA+XZ9A3U1BX2Wm3NnpASBb?=
 =?us-ascii?Q?e4XfMROFdVWoFBxw7/xEul0RTBrS/SsGAKBLsXOIZ+BYU9W9q4e0Cl57lON/?=
 =?us-ascii?Q?AtXfstfYUgwV+bHRhiRqOAq3O3pNfUkX+HVj1/e/jtn7nzZE+auERtBRaXzv?=
 =?us-ascii?Q?mwvjx1WMKnnraOKkvdHEKTmMMCeZLdmGJ617I9jxkX9SMG+PjUL7GLKGaFfV?=
 =?us-ascii?Q?xOxWeftNX/fhJQfcQASTqGuI82aL5fOHS9hY5aTD670GcidNEiqFH7KC0jWz?=
 =?us-ascii?Q?ZS5mcerFkTb2fTj4CP3z7/LIKtOnWtB1fcmN8xWx8M/y8TMYaLQZ8cCe1EoQ?=
 =?us-ascii?Q?FaSUSvtBe6GS5M82vzuPhAFYsJUuEaPB7sX+r6HgrA2/waRdHrpzjoSZXcKl?=
 =?us-ascii?Q?1wN4x+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+58iwHM12wi7O7drYLycfe+VbHB4UVeycih57FfkxOUrBo0SAVHlPwG//K+?=
 =?us-ascii?Q?RVHW3MKeYPL065/uP/K7UQXOmRTcf1Oe1AGnu/mG5YZgfKLOYBRUFVs04CzG?=
 =?us-ascii?Q?Tcl3Wqq6PJ0YkecThyOyzAM6bQxrLMwIbmV3f1qw7Y3d7+sT8SIKGISa6LQm?=
 =?us-ascii?Q?8VV1rM3ZzTXT22fC6aBm8n5+lvypuUfCzh/jNsl/ULEQMoy5xVo9WbHLSpkz?=
 =?us-ascii?Q?3rDM7FwkkQqHPgTGY/ZR9QqOzLjJSipzOZixfd/hP8Fs69GuT39xXowU2+yC?=
 =?us-ascii?Q?bZNK54KDoI60LGYtLjMtJo7hoecL6rHG0Xz/JsoO/NuZmDsgyok1dBEoBKr/?=
 =?us-ascii?Q?zs4ki9YJzXAilDSS64svaeNVdIdvAX60maLnwYOXaPVtacUtECt2ktwGmPCV?=
 =?us-ascii?Q?Od02Pv2nFC0PEW96YoarXDRkF0ex05OVyxuHqJfrrrWNQMXtEt630JVr8bAy?=
 =?us-ascii?Q?Md8O/9bwytymS4ceJXNY2c1wmczDIJOpnDlhSnxvsr08gwC3WBcHkFBK4APv?=
 =?us-ascii?Q?EeTicNy892zwuZ+c1RTZveLs2aABIqt4zV+1SAyAN4izgJI5S3og8DRaniUR?=
 =?us-ascii?Q?Ki2wV4UXPAZ7OHyJxztz+UXipHvxmLPOD7iCQSYAcW15TQTJVVtO70KrHRER?=
 =?us-ascii?Q?3RbqF1IW9Q0VGTPl760Ab8wZePcFfUQ+eaVvlJyVGxnOIrPspiYHTlj31qXs?=
 =?us-ascii?Q?gqaSdO1HreWgYT6fKk0c1xAVdw8bne1gwB0Ndz9ZwcrHsIq3tsq7G21HgVxg?=
 =?us-ascii?Q?wK6u0XE95xCTeVGGAoKMbhUX4r79O85Ie7KQdWfe0vTF5jf099UlWK/kP3GO?=
 =?us-ascii?Q?pZzti+V0sEvdG7DEQlAO7t9SmOE5M42E+fNkzkqNfGqlDuZa6beQX9CSScnY?=
 =?us-ascii?Q?BevSPfwxNvIbSfUtGMFER2aMcA59rI+rrdfAxAiv6H1jaylUphYpFcy3pGqp?=
 =?us-ascii?Q?vx16kiif5vmZL6/Q6gbFmMbh3f+8OAJN4SSRD6cQAl13IHAHKAPiPujSVsBc?=
 =?us-ascii?Q?6rzeV9MWa2aHD/Ov9Fb8qGcpB0NoyyJ6jKO/N2CaJJzOPiyKe/H0knni6r86?=
 =?us-ascii?Q?qpxsNxtGNzt8Px/duLnftho+9FY0LgVbN36zIhuB638G5Tq76mTU3JUKKhSQ?=
 =?us-ascii?Q?gQgXlzFfn9x3HdpIStCeT7sB6YETCv68BesrF96Rn6szwBpHGExtkGI0PCyp?=
 =?us-ascii?Q?3QN8LCZXfyHumiO5gbtdtChXzdAzbF9mRMAAjeFCpBpc7Mw+5wmJfrZai31s?=
 =?us-ascii?Q?OFUb6HztLPuYlF3Yigtnn2pLBd0DD+0RtHiF07RK3/mbjQAPtFg+497FDXTd?=
 =?us-ascii?Q?o4BBbPBuz7JzkOCeIPPJRml+A3K3WqghDFqtx0ciA0tX19b0zuudasrtNgaY?=
 =?us-ascii?Q?VgfXgOGZvuMByNrBgU/IHg/a1m3bnObMMi7qov71v2FBud8WnpFGvvWEZNO1?=
 =?us-ascii?Q?vyRC3mqLDIoF/ayZQlSo1/zjGPEv/hRvjv6IQbQWkDmS5VUvJSC89Z/Xpquf?=
 =?us-ascii?Q?2JLBN7FKAvP1+bLGjqqTVNJmAVCVLZJe4zhMNdG6HXjaXNjW9TAbWdHuo77I?=
 =?us-ascii?Q?i5CTjpGvQB0AI49lnLVEeGa1mLhGK7gZvXVgalPu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7c46fd-ec8d-4e3d-a770-08dcea7fee4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 05:37:15.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIh0jhauo5Fn+PguIAoWWTr/PM8JFQvN4EU9+8xs+J5+1rIt/R0Zu/AJznv75m5sBjq7oi0MuLqoFblaaqNANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com

> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> [...]
> Subject: [PATCH v4 2/4] x86/mce: Remove functions that disable error repo=
rting
>=20
> From: Lyle Li <LyleLi@zhaoxin.com>
>=20
> Since all major vendors do not disable MCA_CTL after initialization, func=
tions
> that disable error reporting should be removed in mce/core.c.

It's obvious from this patch that the functions are removed from mce/core.c=
.=20
IMHO: No need to mention the file name in the commit message.

And please use active voice in the commit message, like this:

    Since all major vendors do not disable MCA_CTL after initialization, re=
move the functions that disable error reporting.

Other than that:

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> [...]

