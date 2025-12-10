Return-Path: <linux-edac+bounces-5563-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08235CB1983
	for <lists+linux-edac@lfdr.de>; Wed, 10 Dec 2025 02:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3747230271BE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Dec 2025 01:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A99221DAC;
	Wed, 10 Dec 2025 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPwwsAO1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45D2032D;
	Wed, 10 Dec 2025 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330073; cv=fail; b=pZMEgjDOFr7ezcStL+fotKeAloDpkzA6RTAnAAT8q1zvAqTRi787PNxGC7QkMhfLXk6ECusICkeMBloZAoTg2plSaSPA1q097vuysvh/aOcQKmqW5zSfiDAjXcBG6oQnI90Nbyqr9QiqBPrdwe8n8bHY4UsRNcz8D6XIFahtrgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330073; c=relaxed/simple;
	bh=wlcxNiYAd6+7st7tfXDU3c7RfyHj1y4kW5nhWJ4HevA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBBZSx5dCv/9bkPL6y48n8Mwi4UbUZNRUH+Ku9aT/huD0liArVFHkJ7JKjkWR1lO9b+IrbW6Ier/B3TsA232vuH9IawL4b3SQVOrZv7ISeGYwCIc+rRCQaTTUPA2p6I/6/bw97JrLE/P9PQdKT2tbR2umOEKkJkakeuvZaNb1oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPwwsAO1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765330072; x=1796866072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wlcxNiYAd6+7st7tfXDU3c7RfyHj1y4kW5nhWJ4HevA=;
  b=aPwwsAO1Cd4yaUVUzFrbrnhuwgwYKgP7OJCnyZ0pGmqdg9zCwzZI98Al
   Xl/lppjhzFl7wLKAJ60exLJzfnZxVJ2A9o3gORvfI51G9cysmthiu3K3c
   O0sO/C5BkOqoBXPck1mNIh/+qo70Wg/b7/C+JjPp0HBWCPqHccvUSvinD
   Y7ZQzQFMjmX9qxhFk2ZV24gpjwGXp2gueL2FC7tTYsGo+X9VK1EXHN/xi
   QMbROgyP5gsFhJJ2T2LPQwgwqfrCw+NjN55mTA0V0/nl1RuzVgQBiR7l1
   rxSxFx1BAQP+v2enBGIfL2NjUyEln4YUvYa/l5e3YoWsdPYISHLpR+VLW
   g==;
X-CSE-ConnectionGUID: DQDJM5HnSmixs3LtodxePg==
X-CSE-MsgGUID: 17RDskNNT4ejnEhqX6xq+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67022738"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67022738"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 17:27:51 -0800
X-CSE-ConnectionGUID: qfI8VDJlS2qnWlNe7SV1uw==
X-CSE-MsgGUID: uHp8rZy0SQOHSdUw75wpRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196279622"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 17:27:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 17:27:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 17:27:50 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 17:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhyH0bYA70GKR0Yd/mrCD6KscPBtd1VCgc1dKC2EWwKyJhKkrbWCX4L02tbq431+ost9AfwEwXQg6a3w6iyD1cy6BbY0AuXHGn2T4n7kzxoqjC+7q59LlpRtH8DQDKBGGBCiGheMX2ybg7s2sSgt9ozHwmHP1Fx4OFYHaurKvabZSXdWWJlhBKMCbfg8Blik1FpDBEdZqNdzfC3/WiSR+dMzbLv1c5zbgW7xj/OFQPBCXb+jPv1eZ+MzMRR9IUpF+A4RgbMwWZgPvWiEHZBQkFhXuihVZM3+Tl7SY+3SNuk59Q5X9CwK+ay6xWwjp7QTwhgn+sxzntAchYFsz7/MOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a80p7i0SXMD5AHww8xZ7xn3c9JxV85yc3/PUFtyOrCA=;
 b=GqC41MXp2faBQKTU7SoEwoTZGU4Qp8I4oVzgdKmekeA6Pn3qV4ZYAULIpFn1VWkzIhvId32j64Dj/2pMpihSKZLUFJ9s47NyqnqJRjfIhY5MyMw9P2bQioBPjbueK0VwEOnOwp899XxSdOn0UxnundvWvvy6XN0JTTSsERlBbVwywjOOjEcv6SUrJzRyQCAYIzeDxxcq95x5oxntEgUStEN4bE/U5OPOeas2n/323V/yWsLtvEmGZhpqxU+AQlgWosxxMAYeygOH9QNYhEk9VvBd7szzkb3mDk12D10ZR9XuB9NNPZtOaw9HBF/AMW6JtqCLB7D5euSo01DSAMJXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 01:27:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 01:27:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Borislav Petkov
	<bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, Aristeu Rozanski
	<arozansk@redhat.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()
Thread-Topic: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()
Thread-Index: AQHcZdfRXG663KnRxEu4656mexaIlbUTJg9wgAZA9wCAALWIQA==
Date: Wed, 10 Dec 2025 01:27:42 +0000
Message-ID: <CY8PR11MB7134A2DD79F094BBD5DC08DE89A0A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aTK9mKTphPwuR7qb@stanley.mountain>
 <CY8PR11MB713404B614F5D046E94DE2A289A7A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <aTg0Lsj_3bMrsrt9@stanley.mountain>
In-Reply-To: <aTg0Lsj_3bMrsrt9@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB5864:EE_
x-ms-office365-filtering-correlation-id: ef831c53-8b02-4827-6d5c-08de378b504f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fPUZeltDQh4r9xXdoi4odIZ0D9H6iMRUbQL2ibk2qzNQ8zDKPtXlqBeFfThH?=
 =?us-ascii?Q?GLNuupD0M7Uv7FNOFwyTQGHAI6MKjH5wYiNlmBL0UTxD3P2gFkZTM+wtetjg?=
 =?us-ascii?Q?yBmtDokpEjGTNnVRPBwey/nNHfHdVz6lKgbNDJY3gSvQQ1FG4VLwRzFV+KNF?=
 =?us-ascii?Q?M6c5XlxT+OaUACeUe3NazbLGLB8HbZgAdo1UsYZJnDTPgZsajTWtwxTy/3tq?=
 =?us-ascii?Q?MzaLb8jCn1XoloLevt2CpbD6r1x3i6FkU688ze/hbIi2cVFA6ROMfmg1SPyC?=
 =?us-ascii?Q?WDLxhapKw5+3getQT8lsvZExmKl7HAxo/YAU8tpZj2LOewBrfZG/VME2fHlZ?=
 =?us-ascii?Q?r9E0MZLeQCj8I1iVoX9Ffjng+HCPWzYJphFRyc3fAW002zH7rM2ykeWGW1Rb?=
 =?us-ascii?Q?eE//EHsAqrBIzGVgFLSDMhfByQZl4Gmk97As5JJ834dH0bigjxNng+iy9BaD?=
 =?us-ascii?Q?9kTFXT7qsgva1i0MzNEtmvHXsMBBZSFY/+pmk7k4BOgzKUKRxsfnwZbOCIV2?=
 =?us-ascii?Q?DIIqMw5hfpCtjpDYwIPX8ZNHxMDmJXgeWWivHj7+h2hZNRJANOU7I384Lf3O?=
 =?us-ascii?Q?uupYawQSotzjHr1eWq6I/+MTSJgm9bbrtYb6H67UO093cyNLU1RCz97DcxEZ?=
 =?us-ascii?Q?9RIyUpIX+3FTkg4cyv+5lEhngUN69ndnSTujg2IC+doKwE7jj1kkP43gqoNl?=
 =?us-ascii?Q?Hq82Hl6HFsPnPf4W5abX+co5q17ZiOMXkPR/iBXcoa/zDkTxK3H/ZpW+DPZ6?=
 =?us-ascii?Q?hj9wMLw2nIgTNP7kFYGD7p6PIHchnPiQUZLsY1OKtNcnNiFkxAa3dL3TlqyC?=
 =?us-ascii?Q?xONCrRKFYaoIqu7qTGYSY2Sm39NVGvVWoantAzCnme8iXPBGqI3RGZt6GJ8+?=
 =?us-ascii?Q?qm8S+TzIlKSdY6dLlUxvqOdpufhZ7V9GPAToRz8cqDXW5zf8dkpCzpDsDrdq?=
 =?us-ascii?Q?achHIE8E4VSy+l7BKzTenEBGQBDoIOu1/9m4BZRvmmRiN/bDGwxv4ZRaaSvL?=
 =?us-ascii?Q?yLNFh1rUwG14oO6ZgWHHxHxHl6hgX1PZTKFjQsErwYuFpARQ4Diav1TYDDy6?=
 =?us-ascii?Q?mBYkzOn8fvqdu8jb+4yeA0I7dooCF2KmIqoC9EgEXqTjuHUBZZQsb5mr5dYe?=
 =?us-ascii?Q?JVsgVYSHmou2A4DI0mdTDvJafAmMQCj4j+PucZkHd48RDprbrDG6BF4QZunl?=
 =?us-ascii?Q?hDzxX6cNRELKQvbUZrHAelCPdFS8ydLmD2ffr4FNnrNEcH1LfxsgfbPi+e9l?=
 =?us-ascii?Q?sFrgT6bSrt+IPFTbXb6d2xVJyw2T4Oau47Q4R5XY8wxCOomCHzIGqP1sLDhE?=
 =?us-ascii?Q?AtEBaMkSEuGGssCFOtJo0vqFtn6nEIE5aqgkBzmvCblg/I/l8D8Xw9cm6ZjQ?=
 =?us-ascii?Q?i9OK/a4/BLK9WMQe2IarBrMfkvMWTDtWh6pq9Ljewhr7UzWernm4W1SUV31e?=
 =?us-ascii?Q?QU2UTFP4zVfd78fspSCdLwZmxpPvl1XOqNQoFznfI/koFrMsdSiR+Ybulmxa?=
 =?us-ascii?Q?KiFZdBYkq6HcGS5K5Xt/+GaCxd+jxDZIlLGQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kNrtd6NasqsyboHAjg9Irn84e2rT0IYiXXKFVLKdHPiITJkhzxpZVlf4RMFk?=
 =?us-ascii?Q?KlUWz2TtCerYs0IEAHiHxRcBiyrFC6nmCOB1GlXfNom35H7CpqXUp+Jqocr8?=
 =?us-ascii?Q?jbPsPOdU044uc90Sv1d7YoSmwyvLT6Dwx+CFAC83c8fPWtndjVYdE8iKMCPT?=
 =?us-ascii?Q?IGRR0959kS41GgdylMGLjKIFS+CsNFX4LHTMGCOmfzw962qrck47wyY7GcwQ?=
 =?us-ascii?Q?Zj6BB2zn2wM8KNtP2G639Ti3efrUcqL3jGaflL6xqsDXy8mN7vPXo/i04HMF?=
 =?us-ascii?Q?M1A70ZI0hyJnZQyPBAirCd5ReMMHgKZotwIpQmyPHfaMlH10nshQogwPGGNQ?=
 =?us-ascii?Q?cLu5Itd41/NZqocWqVjF8qU3faIw9AxCpUZj8QSHiulfeC6nAopyoSb8kO6g?=
 =?us-ascii?Q?jlBbyqLRGHJPa696ziqqLp88bZBcmlYqshcVL2xIyKJloMbwp2SfoQSuhoEu?=
 =?us-ascii?Q?GsPAzZ0sso6fsyMZCGtYYbt/Iy38Eshx4tJzzh8aJyKMZT7kzdTTef/K3Fxd?=
 =?us-ascii?Q?yBhhx3tpiLH0BC2SNsZF7g2BlanHYIK8W9Qw51/H77qs46V6hsvTmz+7aY1P?=
 =?us-ascii?Q?ai2ARSEORZzpioGQ+cC8PbFeDv98vJ/xmKN+tt+UMdLf0O7wC0WkRpA1B0Ab?=
 =?us-ascii?Q?KF7QTxStmx/npdPlmPolgHK1uHvie4rP9aKvDGT6Kxy+6GjiRRyLxAwckZLV?=
 =?us-ascii?Q?LHF3uprdA7F2RN2A9ha/sfk64Teww0CCU1WFDWFLr+gniZEh5FC5aAGzPZYG?=
 =?us-ascii?Q?AvoVfp+VhWLQ8Z576Ci96sPQ+oLcO48lwnZmU8UTbsiX/hS+EZ+euz8EFsFC?=
 =?us-ascii?Q?QyHP3grqJnnRhLb24qqr/gB63j0ztnO5cxqRw3H7ma3W5jRSjuizYZNH1+0I?=
 =?us-ascii?Q?grdMUYkA8hyC23pfL2MIY1gnBxIiPNhpKp9vUNk6uxUEkdJxh24x9FXVbLN/?=
 =?us-ascii?Q?qjPvp0lDmxCJjqrdTw+aqGGV2e8GphKGpa6khu2+kjl1X+/K1rcFKQbwJY1O?=
 =?us-ascii?Q?8Jr6CICiPMXVG10iy2LUDNZwsTb3YgnrjKESIQi6eVm5sl8ALx6q7fTUikE6?=
 =?us-ascii?Q?IxxTYX1SsfVHGXjh+SUmKv57qpu3YOO56o5J8Swi+5DZrhlXsegGRVYTvZ9R?=
 =?us-ascii?Q?7KQwxlW2i2YWdQTfoOjJTsIFtq5/O4Ls6d1Ax4Lcp/qE/p9gqgTBqPPj8vvA?=
 =?us-ascii?Q?uK2+eB1dmDvxYgsSOOgyUMhv6uYL2+mkPQ/FZICQHy5Q7VZC/oZGA73xpxe7?=
 =?us-ascii?Q?KvSsesI7KohvYDaiccfOpd5JwZCo+7VWSEH1U6EpkyRzFIcYqmLl3WUVXLOc?=
 =?us-ascii?Q?T3HNq000a70gdUk2a/fQ9O91D6l4QdRcKJhzRE4qLccdjfpjeM/AXkNHx5cL?=
 =?us-ascii?Q?bY+hv/5SKXySCKJlv3J7SzOiTOubS0X0f2YHPmIHn54yjpKRkkAOCk658CTo?=
 =?us-ascii?Q?Z8BKVR//nvDYOQuB4Bq+cCLBoeCU5/ELmO52doi/yTF+6ZkP+s3spF44POr3?=
 =?us-ascii?Q?e7fsiu7eRnoS0GdGbX/rXro5atDkwZ1fD2rrK1VKyzvJTH8hGXll0v83VDqr?=
 =?us-ascii?Q?PwQfd7Flqiole1BSRK0p6lFvDWFOtSS43RKLbvGP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef831c53-8b02-4827-6d5c-08de378b504f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 01:27:42.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrACb8B3z9EMHriXe1AOp6C/08dkfCISFumcxbDWNhYGiULykCQc8V5ax3G7cdf8zX8q3+0DDBc/uMzwibBdeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, December 9, 2025 10:38 PM
> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; Borislav Petkov
> <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>; Aristeu Rozanski
> <arozansk@redhat.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size=
()
>=20
> Thanks for the review.  All good points.  I have resent the patch.
>=20

Thanks for your update.

-Qiuxu

