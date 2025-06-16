Return-Path: <linux-edac+bounces-4147-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F2DADB661
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EDB188D6A5
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E48286880;
	Mon, 16 Jun 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OE2XjwNy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B142857FA;
	Mon, 16 Jun 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090412; cv=fail; b=GQ+BWZHmrGNZUj7JLXc3QA9lH6t066xEs6+o0IQQjURvSJ6n5eyUEgx00r2cZG24fM8IuzLEmH1m4cXuVIR1/PV+v10WJ3BBu+HY5u8ouGooH4YuNp9qhKqHQ5MWSxsKhCCInjD01bQme0dl8HJkKCZnqCZRJRFyQcufiYeOwZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090412; c=relaxed/simple;
	bh=P2SoBvfFYuf2SlmNjNlsXbqVIWWj1nqleJHvSdfY5Ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4WmPl9MCl/ccdmEE7l0VtwObslcLdF7w1kk2Coa0y2PgoL2RpHo2LSyTYc7W45pB/Ic2S4Kq1Wwngu/qrkBps70MINHTF6RLacGzOTjxAsMB8pTo+eaNVHMBYT6Ak4qeC6WN78zwyaTtJHb9dNEwwChCRDWytFEoO7eYkDpKc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OE2XjwNy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750090410; x=1781626410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P2SoBvfFYuf2SlmNjNlsXbqVIWWj1nqleJHvSdfY5Ds=;
  b=OE2XjwNy0zfRf7DW7VyVw/g9AiX8BgsxktqSqsfoXpqWQJ54tr62JOWq
   Vs32CnMZ3yRJ5tkfrAGnYs0/qYhZaYmWhv0Ky6R4wQZ3xhYvjtK7+Ox2E
   /SpygHDnyrbjrPzkp0Iu3la/ewIttNaqRuAFgBCktk6zcYk5QofBDT0Qx
   MjRPZoqB/FwJfSxUUO0lySkXb3Gpd/w5dayYoFxbilc/YEpQh1c71LgS4
   FZAmRJjHO9hVMKp2V7Zwufp3CsAOTcExcp/ZS3D8HCb10RnU+/Paajb0j
   o++vOKSIuCyrIfBKKt3kQro6X2ylnAVWYE+HfCWE3nq68uwNmkBGFmWwE
   w==;
X-CSE-ConnectionGUID: 5JsxlMLdQIikEz0GXB9x9Q==
X-CSE-MsgGUID: he/shv5uQ++Cx8ZtH1Nqrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69683319"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="69683319"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:13:28 -0700
X-CSE-ConnectionGUID: cHVS3Or6RZqapwbNExtA4A==
X-CSE-MsgGUID: GxntcGTAS7SNKQBkcghDrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153392508"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:13:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 09:13:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 09:13:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 09:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opgXECIgcUd0kG7Q11vr505Ugd2Lg1/SJT+K9+ORHI+F+gTMvXJdUop25mqgx27h+tw0sbO/fBywNGGqlOeCtom9ogRAi7zRBaVRxAuT+1ioUV8Tyy1Bl0nsRQ1JbaOEO5ngAc8v25jVSsuYq6WEFMkxmeFM/0xzh6QeJoBngO5uxff/ECpAtATqUtI48Gxx4DlPcKcruwQuMAiIqLsjUAozLIR/Sk02jVfAxz1PvGut3HtVIWjPrcsbLwpmBzbdOxDSZhvKBnp3oG3ugvoGVd1CVTILev91siN4aYQs5ESgr8RyEEvxeqbrMQdz5Nb2Cq+5Xd2rA3ih4igfdxp61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2SoBvfFYuf2SlmNjNlsXbqVIWWj1nqleJHvSdfY5Ds=;
 b=CMkX7NcOCl9STIQqyvftsdkgIDpuMlTDVm3CV1LjSRMVNWr1Y97FCnp8MTAWZ1A6lN2T4SHCij7AMxV3Tiepuxu9+nF3nUkXW2GH7QdPD4OIOVOWI0X1Z9hmuGgOZuGvheuzK+2cUch2kI478hqx2szv88qAu1vcSdkxwf6y2mjmIufR1bXsmXxOHWfUM9Q+hHGSIK6rFGUAWZ92VP2kOHVAIYa3hbdI1rD83+tgfB52va5yDEKNUhJEpc18uWm59EfC1AqyhtNVwod0PXesZjeEQBaGxxVoTvCRNWJ/1ATWcIekUT1PPqRqOD/WjWEXoFR5C/uDvmi9iftq3zyx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5059.namprd11.prod.outlook.com (2603:10b6:303:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 16:13:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:13:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] ie31200/EDAC: Add Intel Bartlett Lake-S SoCs support
Thread-Topic: [PATCH 1/1] ie31200/EDAC: Add Intel Bartlett Lake-S SoCs support
Thread-Index: AQHbuwMUh98xNLjD00ag7W3QhqrIdLQGPNfA
Date: Mon, 16 Jun 2025 16:13:23 +0000
Message-ID: <SJ1PR11MB6083BFB95E228F6CF3BFE666FC70A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250502013900.343430-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250502013900.343430-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5059:EE_
x-ms-office365-filtering-correlation-id: 3f1179fc-280c-4054-2f5e-08ddacf0b82a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?smqV7GlKIl4cqMiRgi6hiiPikHN8+ZzGWRuHNEpOAzjPUI1ApvUZ5oE1P/Mu?=
 =?us-ascii?Q?p0ldLXrWTWWq9PLtnG8zNB39H9N8SVRYmR2gGINrvDi6ZlPC9rOn7A8Odf4u?=
 =?us-ascii?Q?7B8ZJlFyE5yKuBRHDDjztRHWcNzbS18YOmI5xIXd96UWbwccJnK9W1V7aDCg?=
 =?us-ascii?Q?tZL+sP0kfBkzkIGq1lvZGvnFzBW5znrIQ4c/sRAUyjioAFSGGoBX9PGGZBb0?=
 =?us-ascii?Q?iHr+jrXmvi1uL2tThHiR0HWo+ThWgzLphomv+arIX7gVDgFuUqbqbGhnKZxr?=
 =?us-ascii?Q?uDq7uCEbiWh00a/xEvD0TfDJXYQ70rHCIn/2rJTwYvQDE4qNr+fIF5ecSjYy?=
 =?us-ascii?Q?0QQTm0z8mPw5dL3FPTA5fMaqbLI5iPu7Szas8ruY72bu24v2tXz/FvebKvn8?=
 =?us-ascii?Q?dCcYD99jfsPY1pXBJx6WigtvMwHe2TqBcIbCNi4UULa2NIefULP+l8CheLAX?=
 =?us-ascii?Q?BJzCukFKS77kpxTPq3SxQN4NRXM4jPESBo5Xt0EpDIg90hrgyqovCpoCHqKR?=
 =?us-ascii?Q?iw92EyyjYkFbFrK9LejLVnpATVrl1qvP0eLGNpwQXGz0ryKrw46j2glGXsFL?=
 =?us-ascii?Q?tPVhCKeHu9o+7EXEFKya8MbEp2ZyAdDIPDRQi0rRGNrgC0bq202eKYN9IWy9?=
 =?us-ascii?Q?wbJTDCiGLaR1cemab1mpQJ0jMjmyVycAMa/Sd0lf3cbC7OLFQ+sK3DG9if0q?=
 =?us-ascii?Q?7iArkkOoXC2f5Im8l5Oh4tNP/BqQB3vF8mJYRawhtaKDhBJ9wH9F8uAi/+ER?=
 =?us-ascii?Q?03K2FJnNl/iOdbjCBtJbwW5KgEAaHKGRtbDhRrJZcspqo5dhCo2yh+2GN3hK?=
 =?us-ascii?Q?HTBasKMbMojIeHMtRFaQwzsOjeWxNlHJEX3Jq5dN5EDWI5Hwp2G2JBTh8x8O?=
 =?us-ascii?Q?Riedz3QVnzwI9dCX/eR3SbV9Q9bZOFSGz5OgYGWKnaZfdgDoN5hf3gJXLyt+?=
 =?us-ascii?Q?p27DsEqeLj8h1BaV2ht6f47yy1T9ZdO8Z92zjeAN7fdAz1MCxFu5zmYEOPMo?=
 =?us-ascii?Q?1pcjFKGFXW5G1YbhfvwwIoMbauImJT0gF0kjhtoXC1EEE3yerAPPHRqiXe2N?=
 =?us-ascii?Q?qHS+OBNAZOg+T64yqfUEbx/YPzANDZrV9SpgDqUaFKgf7JeNDRa2sj2t1uNc?=
 =?us-ascii?Q?I/rdrMOo9yLUM2GsyWP/+0enefYcSPt5WYU8I+z8H3SJShHiAWscmMsm55Er?=
 =?us-ascii?Q?W3ybIH1hMd3A8uyyERRI7YhS26v6y3q/kZ2f9hPf/nSuTVwaEU1gp3hHzT2q?=
 =?us-ascii?Q?W8Tx8G16AU90yyr5GfNAwpSWE8Zw/sTH7S+28KQ+RMwShdbrgSEXuDeCcwR1?=
 =?us-ascii?Q?muv+7JHu55Iga8lo4hxZfDG+j9TqJe9pqqBqVplE5Koay23OOzUbIKnc7SSo?=
 =?us-ascii?Q?IUGdwh60kguFxwXF8kow8hbPRwys80dnpNgBDvw7/Zsp+9mOw7ach+bZEwk+?=
 =?us-ascii?Q?hWwY7huHrJOXrMRz+W45Mo7aC55wN0OVUXGwysszEQ+fCdwqP1B1Gw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p8NvAePolnNNBy/sSyMxP1f5rJM4rOX/4dz9q2fLUEPOFRXsYmTHaM+kJOQP?=
 =?us-ascii?Q?qAJr5fqgweKVCMH2N/kl4ChvHg3Ypw8cccMPFmsehkEb3q3Ys6zhLPtx3rMd?=
 =?us-ascii?Q?JVEet4V+fnQIi989h9zxl0uqhc91Jmue4gF4LBeaSXhjfVY8c2oaz0PmRCak?=
 =?us-ascii?Q?OCQuEshvnAgPYDxdPSG3K2CNJItBYqpPI1oRnwSZa3Z0JMvyP8KJfyl0o/DD?=
 =?us-ascii?Q?KIiJpcNag4j6RlM2SMrTdNjIIPVFJLT6SQIof1NMTtxxpddPM6wXKoJTBVn9?=
 =?us-ascii?Q?oinnAv/r+VsX6xeu7AOo92KO4uZeJdHs3AsBRqRFIDruMmekETQzagM1x+vW?=
 =?us-ascii?Q?8Ruu2nwT/PMA8e4FSl1GhabkSQHdp7Gk76aOygzPopSJjulVKF0CF4ravbGd?=
 =?us-ascii?Q?QAAjV39A6eKxZZBa3fAvpS0yvmGXGgyOWq8vaVYZM8o4OXcJqgntO1PjvKmE?=
 =?us-ascii?Q?DfHLiHPH2v/6uFipEUjcRJ4IJY8dBUREpeW/CosRAf7y+/UfllF2l0+payiQ?=
 =?us-ascii?Q?dFU2jWm3F2xJiAATC1Xwq05NMicURDY2CziR1GlH/YPt8Y9XeEXpYeYUZhT/?=
 =?us-ascii?Q?XccS+8+gYxmz8HOPAq3qDXo00F2Pws9tn4805ujjWW70szYro/IdD7xyC+5z?=
 =?us-ascii?Q?si/bM3JIyvQODCwBlU67TQoif1dDStiDuU4HuXnMGetg5Ai1SigTXudr24nk?=
 =?us-ascii?Q?AyH1CC8/a+Dt9eoh0iE/8GrfpJ1fmbNRicEOedleCodQIkzGKhZv2sJuxKZk?=
 =?us-ascii?Q?G42z6I8xkV/xOU6jZ3iCDcx1dZ3oECnp92tKD82HXoUPbVXo307vvz8G09oV?=
 =?us-ascii?Q?uK71yi7nxJNYjbgoUlGQ17O87Tcs9DHi6DW26Y0mi7xTb+3lP6e/OG9yAqti?=
 =?us-ascii?Q?jX5NWk0NfSW/kv7glfeNL1A7yGn3zQJgGWuuEKHllkPXVbUl5+z822rHuqPM?=
 =?us-ascii?Q?sRYi4m/f8JXICjpuphYc8grh0tz35QGS+dMYgkPm3POtuIPYv/ammAsxKpfu?=
 =?us-ascii?Q?GjTMsBg5Z8g7PTEJO97NGaCtwtufs9nivAJFIJi9l5i10JBfvrkBeJ5OJ18r?=
 =?us-ascii?Q?OF1zZu/01KzDq8tZYlGFMfZoNlfQbCK5CAfi89bfRBQYvbvq38wilwGMFUEB?=
 =?us-ascii?Q?vdfr4HPnSJVIP/O6DU24niHoTDKcisB0F9Br7TkQEZsf8e84WhPSlJI+jq/n?=
 =?us-ascii?Q?3S5pAmQyS+MKbl6T8vvBR5PclwL35P4j4TD/Zxc8Sxac6+oj5a/tuKsn+aWY?=
 =?us-ascii?Q?A/Whd+vR8vMO0u4wnmua6xRvNiE8tSRfucSDTgC4PS9tBVs4hsYJNKEj1xnl?=
 =?us-ascii?Q?9w2jGH2h2i7wkjT0zvsyokG6vu2gqyXiRfi66M/JCS1NJDZ5D/7ASjPtdaxA?=
 =?us-ascii?Q?gB80RwB6gHEKzR4yd77fU2Z1gMr0wxPwSmyB7n+JGALF3pauCM6hpexqmqQu?=
 =?us-ascii?Q?oI5SafUXbPQJENxgWUrJ11z4xHWfk5cNQfccqT83NzEPLVf6hngc1dbv+dtV?=
 =?us-ascii?Q?ijmHtRCxx7CulQ5XocH+UjTPQSevlpNbjqTaLExCA79ywx9jD1irqGJuaI06?=
 =?us-ascii?Q?8Uh8xRJ1lZDzMIUXuD5AVlTA7zSPs/xFu/PzpevN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1179fc-280c-4054-2f5e-08ddacf0b82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 16:13:23.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohtgxDQhW7jAgv0ag1k41KyS/tHr+Gy3RNCenxfMHzD1D3GcevAORMTO79NiJ8IFKx84qvBsx8Iz0WjgfyM5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5059
X-OriginatorOrg: intel.com

> Bartlett Lake-S is a derivative of Raptor Lake-S and is optimized for
> IoT/Edge applications. It shares the same memory controller registers
> as Raptor Lake-S. Add compute die IDs of Bartlett Lake-S and reuse the
> configuration data of Raptor Lake-S for Bartlett Lake-S EDAC support.

Qiuxu,

Merged to eadac-drivers branch of RAS tree.

Thanks

-Tony

