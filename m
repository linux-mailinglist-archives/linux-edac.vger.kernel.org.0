Return-Path: <linux-edac+bounces-4492-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E2B18556
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 17:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D52E56288C
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7966C287516;
	Fri,  1 Aug 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOX9F7fG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95042874ED;
	Fri,  1 Aug 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063879; cv=fail; b=RiO0/Tcj9tEtnWG+QmUgneUw/mmGz1KWhcjGow0S1nX/tKuOTEtWaY8UhNErhU1MZujZ+1mT92ofiWkqnDthv2EKTbpQs0ReH+P79N25TjmPFOl8KMsZfi/JdYu4OJSBdns4N25WVU4vclyePImzuckdAgtzIT7nTOz2MEDfOVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063879; c=relaxed/simple;
	bh=6aWWz5y858VxhBINvmos2ylLpdTFv4YZ9pCGFvNUmi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYdgUBJS4loDfaHddrQuuHuC9K1hmDz+0gWBefzdRNIvw7KVJ3U5S+ZgYfyDa2gKqAMegpt+BC3l9kic0YSS3PWkFRtP8KpdRh1FIGMtBlP51wgyDCJXdtdzU4WQkQO8AbyhlzsHXTLxcx8Z2I2mAk2TTxZ6XwJm0hLkTWKAPNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOX9F7fG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754063878; x=1785599878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6aWWz5y858VxhBINvmos2ylLpdTFv4YZ9pCGFvNUmi8=;
  b=bOX9F7fGDlusoBNHPX3mKfDrGDwUegS2ykib99L7dd9vrE0h5Bbprlmt
   58l+ruV/uodC0Pa15P3O4SFwGGC5FWe1ONQ4/6heHzzX+8v76G6nym++a
   pbhs0u4P4gFwHJji7uIZ9Q1/5tWB31YqZzZ3YXCOOWzBf7LxYQY5afH69
   20HxLMaJx/1k77yxA+DJSRZkX9FaNlHpCKRWZpRY95OjV/9NoYfi59+/7
   Rk0q705T4ZR+TDo9hxJLSBoSY5U/RD/ZQGFLZVk+2w2UwTxpeZnzk2j11
   TNXgX8cKaSHOJeJo1nwIk6/N8XxRxDyLhoz4vSdWGfmNJ5F4bMd0YYhQM
   g==;
X-CSE-ConnectionGUID: BeVy1ur4RG6B/vd9RZ/8XQ==
X-CSE-MsgGUID: pEagihpBQwCs8K4zXjxrjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="74004450"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="74004450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 08:57:39 -0700
X-CSE-ConnectionGUID: V872Y3N2TzqT+ubSJvGeSA==
X-CSE-MsgGUID: SK/ckhZ6THWAlk2wqO7Axw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168897015"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 08:57:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:57:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 08:57:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 1 Aug 2025 08:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urgw7QrfJotE6vmMdnwN6Qhj/dQMnZeBWK+TLXKP0p3kuCb6GHc0lAGi9pKs2J3OD0GVhD2bEHrXtaIUWv2eHEgxS+w5t1OVmSHzxBnq7fm4jbR3YuTNwohVsv/V3jZsBx8znhWfZKri2aTuwhud65qh9+LARofffiupfMxq1Tu6ghnFsY1sAWdcOKZCeIbx65NXS4vAQKRFPJAHpmmUAiEl1AlqwpavIoFsGSNqkAxMPjThHAd9ju6xH4r1eLC6Ezfc+YUy7MjheLTCCBj87C37k1zRNaRnMoBEO15kqfYImeC191OS7fVIVYKiWBG2o5LD/2pLuWcn0RykOnn4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aWWz5y858VxhBINvmos2ylLpdTFv4YZ9pCGFvNUmi8=;
 b=TkmHVDR28cuKC6Ong1jvPNcfyp5u3zzOcmJIe787BvLfN3WarlgS9asBlCLjL/ET1g90j7S7cjSX8EFqTRkLl90F4eY6XSC12nKX0uQx+ipWdpA8k9qDLiTbVzjyhrMYljc0W5ZleVx4yovfA3aThB9+gCu7uCkwQzc3VekRCNzi0v3D/lzWNzoC6MIZLIZ0adpoLOIlrYZrfF0vFU9O9qveh4TlEG1Jitk7sL3cOavZiYJAQH+qS5o/TKMBQd8gHd2vn/XYiXQAtHTrMLBuAXOAFk6AOQOSADo33Csjcrfl7lvJ8zHOb0nhl+3e1Tt6nHK30JZBCSnsu8SrxeZhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by IA4PR11MB9203.namprd11.prod.outlook.com (2603:10b6:208:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 1 Aug
 2025 15:57:35 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%4]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 15:57:34 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Kyle Manna <kyle@kylemanna.com>, "Luck, Tony" <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Jason Baron <jbaron@akamai.com>
CC: James Jernigan <jameswestonjernigan@gmail.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC support
Thread-Topic: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC support
Thread-Index: AQHb/GafXcVlZ3WZRkiBtd6ukhBRJbRBVQ7ggADIQoCAC9GeAIAAEGww
Date: Fri, 1 Aug 2025 15:57:34 +0000
Message-ID: <SA1PR11MB713005D6637EA857500D73198926A@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20250724064415.1134574-1-kyle@kylemanna.com>
 <CY8PR11MB7134484D663C31DA1544945B895EA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <e3bc0591-7ebf-4738-8848-599edd11c10d@app.fastmail.com>
 <f9c0fd21-591e-4fd0-a13e-35cdc1aa063d@app.fastmail.com>
In-Reply-To: <f9c0fd21-591e-4fd0-a13e-35cdc1aa063d@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|IA4PR11MB9203:EE_
x-ms-office365-filtering-correlation-id: 89dc1aa6-4cab-424d-fbc5-08ddd1142186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/egfORdnQcsz6QzU/OQIu/pelihveWZ+MgwiXbh/foylEgGhDbSx0l8V4QJD?=
 =?us-ascii?Q?EIRzKZyaZBKjCwHVbvne01h7WHF1sAcWT7Hz/r6fsf0RFzjMhT9Wr3ZUfbZc?=
 =?us-ascii?Q?YJEfpQcQBpfoDwVaDNaj1P0/lovLsHaSkip4mq1szTwn/VUMHJvTxuQu3KyZ?=
 =?us-ascii?Q?2M6KQBPKEJF8w4ukiR6X6SQWVo+znGxfwIIVyCv1IVnYQfOYYqQQb1681hov?=
 =?us-ascii?Q?2B2IsB3LMG+wDPk1W0x6K2J0jUzNjmGkDyGKGn/PPqXoU9mt0RONV9esN0Lg?=
 =?us-ascii?Q?D+WsRs+XqQiLOYRWuPRYYo7fygsSQg7HruEsnYIT174iX7mf/Kn78f+zRdZV?=
 =?us-ascii?Q?e4cPnhutJtjrIL3BrV1f2bRPZxfsOSe90WznFoo4rrqKKsTyyqTgQFstdkVI?=
 =?us-ascii?Q?m0BWfYZV4NwG1Y/nov8mHQnR01u/TOoxSsCVasH5Iq04YnJuN6JaPzYu0qpm?=
 =?us-ascii?Q?ZGAV8T0yjv6OBCI0+DojM2knBh/gzy5n+SvFraJCJMf1zq32VDuGYnOyYpHd?=
 =?us-ascii?Q?V+ug2sEaOYi2Jx1nvB6FWtT8TsgR5dlpnTdVwh4Cm6ustDRZA+KEMFI3DmMU?=
 =?us-ascii?Q?4VU27lR5TL4JEOr4PUMemqAoG+l2OeYvTtaPuc+VHJwRMC/oGzgq0lfxZnCf?=
 =?us-ascii?Q?r3c/06uhC0lbH/wil9ekJUBULvurkb/g59P+fS2qpanCxzGhm5KCNJjwFhRv?=
 =?us-ascii?Q?VfFX8bPWhF4I5dZjXOMgaXONgywxeAq396co1+V7HGwKW8F8onJB6WfhTmgQ?=
 =?us-ascii?Q?ObnukqwjoevLHfeUwkrb5HweKdID4ISJ/DpCyLgPiqxty/Um4BLg12iN1sO2?=
 =?us-ascii?Q?pUpzkTsAzfL4Tc/bQdYLr5JNMu0nJSSSGf29x7Vy/AKEu2jPzeOpP+B7vRJW?=
 =?us-ascii?Q?nhy6fHb91WcSICCUBYDQoJiPR5w/xMxcTRY+z6KXQT9zaJxhZptdtRhyO/GS?=
 =?us-ascii?Q?gZK1SrOWdBlZrj+DWqSxRD2g1WGPXC47vtIX39EC9OHcX2fJpU/uS0a7xNQL?=
 =?us-ascii?Q?rPR9psWVRFfpJWHPPRyynpfRoonAd0G1c6w0s8ZO+R0TmzwljV1lDaI5LuNG?=
 =?us-ascii?Q?B85tAZBIENH4rPQMvgKeSiDBhxjw0fEKfykG8pWFKWtnkxxkHtK4CZcuH+Dw?=
 =?us-ascii?Q?RyY569Go6vEhJzECArLSdkghcQsPPgrSFAAtXmAoll2GZtPh6EEFjXyuVDCV?=
 =?us-ascii?Q?HQEpi3S3+UHvcKvnLemgwF4vpWPv4144NwKWRjBJjN5A42G6zlM/09nLwfLV?=
 =?us-ascii?Q?54cginqNQoXkSoL6yOtu9ocHl5j1dieiD608qgM0Rh/ovesQFrWoUr5PjW1+?=
 =?us-ascii?Q?FyW8j+0OgWJhd3VtKnN9mejan4/7YWwC2OqbJibJN8C/cQ7lvrNrnaEs+CR7?=
 =?us-ascii?Q?T3CFsMEW+KfIHG3/XRkkLfvFkE7jE28vxotQgSut/i5oG2zr+/8W8/1tYeDC?=
 =?us-ascii?Q?U46dfpvNxqpPUDgLPvf0ClYvvv5xcWXRlivx2uWDfgti1hwTov8GFDQW83/I?=
 =?us-ascii?Q?LTMro5dR5wQKmoM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ne2hsvDR6IupqFxWDgBYpp8Fc2LirOv3YNyfGAJaGNh2kbdqvogG/mYCwO0C?=
 =?us-ascii?Q?dzzTjTFRa/581n+AdcWAzz3mziC3P1p3ycYJ3hHe/hSTRpx1zR3I5jEpTZ8b?=
 =?us-ascii?Q?3zA32r8MbV989jV9juHCuFmH4x02ifJDf9yQR3a9UsYsS/pX3ahY/w3uLjm5?=
 =?us-ascii?Q?DSxeKst/LggSARY8V8Da6NHaA7T6aZjSplq85KQqSLzequVrzDcNaTczC5t5?=
 =?us-ascii?Q?YQ0I8xW+J/dEITClVv3IZ1NQfIAe7pKs0isvI4eNHhx/UboeCYQY0sdXXSxo?=
 =?us-ascii?Q?RCVmMwGIGgxgzkO4NtGNIwKtUT6FnPN/U7pvOT+e9hS47Up/zs2BLY1hK3rQ?=
 =?us-ascii?Q?MGqmWWtk3B63ghDH7fpuBM1wgKxaWWChQJEFT5ejn8nwC71X1aObq34IvbtP?=
 =?us-ascii?Q?qAmppx8SdlwUO7i8pUfxhW3S3sO0le5ByLy3hqMiveJmoCgyEXggVzhdKM/x?=
 =?us-ascii?Q?Rz+tLqFtpHJMPmtC10ZPsoE8OqFi+DUeWRAHG3EsgFgvyKAdMknYf2Li5iMe?=
 =?us-ascii?Q?bTw7GfM6vN6SB7cllokvhFezu4MI12ZLG4Tmp3py5V5AfG0ewT7XtmiWZZ0e?=
 =?us-ascii?Q?qb5SSp4XR2ZZeRCvq2cCnbQn4BGZ837YLlDcAv3LGk0h2Eg6UafulgFaGVv5?=
 =?us-ascii?Q?xOv3j5hnJ76WP60iCVMZuM0k0wnF9k4KOt9hfcZO/RpA345m1A8SdOvR9rvm?=
 =?us-ascii?Q?MKF6xen7FaJl9dq2qRG3BOyzbeA4f3d0e++X9OiCbpmvAxzLIeipr6keLW2H?=
 =?us-ascii?Q?NbYVMCjGdtWqo79ct4sTDv+LL1b0KbS1aalr1xLmZUHmF7dPalBJ/y+Szs5l?=
 =?us-ascii?Q?wURYsmf8X7b6BBZfvK2PsuabChaXEone8TyB6vJBVHR003UbbcjTWt/8e6/W?=
 =?us-ascii?Q?kN34/1dhpc+AgNsishAfNvewg7W77SJOkMWKe+rV+CXpERxynywv67100o2g?=
 =?us-ascii?Q?aixs/21ohD+xl6ew4dZD1Ji6/J0yungcHOQR8qWQgq9O+/j1ExEuZqKiGS//?=
 =?us-ascii?Q?vBO8dxxX+lAXOLtrIMGxO9Q1BBYwdiGKCpAtPSwM8NIqUWANRRKnFlqkdJzV?=
 =?us-ascii?Q?pFAHrse17IYldqyVKt5QtEVzOwzKC+XBiWOxo3Iok1XVDH0is+gf/a478FlO?=
 =?us-ascii?Q?67LHxWUVRJXN8ZKVFtHknxuYnxiD9w85Hl78A1AL5Ctq4lQfibJqSZW06Amb?=
 =?us-ascii?Q?TrTIA5pH6s3edKfGRDTpcOzRNB4sNwUIpt/Y8FSQTNNLMf5RUy2iOVFrNF9K?=
 =?us-ascii?Q?6uEEbwbRWy/k2d6AQQU8ddcyWvEqSx+UhFXGqMcgl49HveVWXeAS2pyXrKvA?=
 =?us-ascii?Q?ke4Z5+88gMLC/0R+FQZnktSbeOkpjoOK9dRXcYDEFaP2Gy+7zCzfhPHtMHxS?=
 =?us-ascii?Q?519qo+uJQXqzu2YfmJA6CKCXYmYm+8mrXvgUj9LS97g0kRasiiSmhTGU2nPH?=
 =?us-ascii?Q?tYx9JTSBfsFZbJ2F9MEKYrDO37+8+Tykh9hdymvx5Aa+IyPxrNKaCYa7lX+9?=
 =?us-ascii?Q?QXvYXLHVdFmrYCGF6tKBR4szFaGdU42ynCcD0y935dvTUIXPN745l1BCWFrG?=
 =?us-ascii?Q?gAxfuQzBId+5diKbOGSv4sOuePoe39ztHL66KOHe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc1aa6-4cab-424d-fbc5-08ddd1142186
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 15:57:34.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmCZGMfNpNnh6LQjx5GerlqMEsODCvUcFOlsbcaKOk5oSvkmIrpYB0FPEsmezqAePO+hpeo2aWJ3HIwE6/oR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9203
X-OriginatorOrg: intel.com

Hi Kyle,

> From: Kyle Manna <kyle@kylemanna.com>
[...]
> I've added the i7-12700k (0x4668) to assist future users.
>=20
> Hi Qiuxu and Borislav,
>=20
> I saw a pull request[0] for a 14th gen version of the same chips and woul=
d
> love to get these 12th gen chips included as well.
>=20
> Anything I can do to help this along?
>=20
> [0] https://lore.kernel.org/lkml/20250728141521.GAaIeF-
> XYJVbfOQdT6@fat_crate.local/

I've replied to you in your last e-mail with minor comments and provided my=
 "Reviewed-by" tag.=20
Thanks for your detailed specs and verifications.=20

-Qiuxu

