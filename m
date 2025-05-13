Return-Path: <linux-edac+bounces-3904-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7DAB5F07
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 00:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868981893489
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E48C1F4190;
	Tue, 13 May 2025 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCVcKvx0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82C1F9413;
	Tue, 13 May 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174038; cv=fail; b=KI2R8+OMAfWKSgsLHMsWsiIPB2cjvOzxbGUWIWB5Vd/4DNOtH4HDcVOcmQK5mg/hkAZKaYB5d23PLr+0Q4jKkO+A+gW1GQMeyp7QzL2sGtkIz44lZDKl+0d/9u8xtJpiNWBoPT/2F70i4jgEzIii8xL2gu53givyiiepELNtuiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174038; c=relaxed/simple;
	bh=cvNYF7NFQlWqHtK0ZmuVBjhEFkjXJPZ8FVxSkO5o52M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tATWUwjtAoimfjrAl0u4vg1xtk0AuyKv6tygo1d7Q7rJm+frLU69m4vtyJMVg7ok4Qqd/09cvt5Zl9qk7fpRwXh16jvtYd+kebFx4aESxL+gDiKJqSUcN9EePCFPaRyYyjHTZRuZWrH+viSamnwmIS8TdCJcVZFctXXGbUep0bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCVcKvx0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747174037; x=1778710037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cvNYF7NFQlWqHtK0ZmuVBjhEFkjXJPZ8FVxSkO5o52M=;
  b=gCVcKvx0t93sGXjvBO9OemiJF/GM9YDA2oWyVWDQUWdE5wT+UdIc+cfI
   nQJbtNwGUKrN7I70Y+RBitZz/sSRP9+SfIpnKt9DNZPy6PM3QJpNajKd+
   WNJERUQ//qKxh3l1AZUI2/WgC2Qb+D28ZpyDjXT4xISh0tkAA/o5W7wtX
   m9aED3HbDT73oLER53YAaY0KOA3+I3o1C/meweN0FEQROrp4orWfXQZxc
   1KTFyM6gyCNYvUsJZf+xbSMCua12N6TErjefPj4G7RkgLuv0rspNNXECd
   IdvbwRI3oT0t6r2c5mBlb5DasPY+t/sWHLCljsXvdVEoRWvXmMMTO6rxJ
   Q==;
X-CSE-ConnectionGUID: CtrZaGBNR0qCdoXHsTuzxg==
X-CSE-MsgGUID: +415fR8JSmmLoRxhU1/Puw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60446404"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="60446404"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:07:16 -0700
X-CSE-ConnectionGUID: QqqfCRZdRWyi7QYf6v8R7w==
X-CSE-MsgGUID: WzB0w60LTh2xA5SoSpG3zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="138355594"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:07:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 15:07:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 15:07:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 15:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwygDA2gWZut2VVUoLgPwigjkxovOHEzX7/6AbGQNz8j+se3guvaSJQdw/7AwONusbMSYDhxtTTK+f6Rj3RzxHwFroziNLXFdoA6vKVwSEiLwkyh7JrhwXj+6WnN2oD0R7LJ/hF3hR9DQVbzzg25mvMvPNeevNq8bk8qJJjymO1CnnTRjbH3ytP4Qt8o8A4dNKZwSDYX3clJ5iUBA5oEOYZgd0koobM+uVkfH0S5iymx/cKe3Iy1Kajh18OJ0VFlWmPZD6hMRs6BY4uvjcwvIUY69RuNqFygpqeh0LdO9HOxsrFKTgjL8KXrj+aV2aD6h7mMl+39WLBD3EEXRbDpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvNYF7NFQlWqHtK0ZmuVBjhEFkjXJPZ8FVxSkO5o52M=;
 b=KAklRSmgC73dMIkbjJyiyTZt7voZnnkmAt1U1QzPB2DMgaStX/AjZVSxfRdqUN8AC8iDn5BdjVEvVn/9mXrx5lYPYqY2hlc9gz4IJDMhtKNj1jouIQYCNhpcNScj16zaF/e+QygtJiEQPP5KD0KPu8VFFC+IlQ3qWdOP3tLwU8Ta4mDYWQj0kNH9j7pa2mdrI677uffT17p725VbQI+gyCPkvQlU38Wq2kU8OUieIwzrXZDKPFkrZqT+g1mQ7cKzgWWIBJyCJ35XuWRdlPZ8vyu2I0SBLiYKlNgvXMgRUeKX3NpKdxRO6srVD+bUnajrIu2vTMTslMaEv2mgAbksBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 22:07:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 22:07:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>
Subject: RE: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Thread-Topic: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Thread-Index: AQHbrhZ3RPR8ouSpe0+U9dFVnyjlnLPOx7QAgACFRYCAAbdXgIAANVoAgAAQCsA=
Date: Tue, 13 May 2025 22:07:13 +0000
Message-ID: <SJ1PR11MB6083BB314BDEDB397861C845FC96A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
 <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
 <20250513210640.GA515295@yaz-khff2.amd.com>
In-Reply-To: <20250513210640.GA515295@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6798:EE_
x-ms-office365-filtering-correlation-id: 4eb4d7c3-e8cc-44c6-b201-08dd926a8404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?O67Y421ugg5/HHgknVd9WodvfjyYOhssZsUPUnREzMf5QAw+l7XT0Nz/egtw?=
 =?us-ascii?Q?EmUe4qCdD6TvY9jIqCrBS7Zvafvewj0DyJjC3y+ml4fDWzut+CZ65h9Kpph3?=
 =?us-ascii?Q?AauSa1g6JQU+Pua8eZc9rSILTNMxtmvLP/eAu6VZzP/7npb/aBXhoY0HoNP8?=
 =?us-ascii?Q?fNZBTSw82zwInOxJTOcaWVh+ZWOAvj/iBC/q6Ay7NOSIGJOO+jP9sil01g9Q?=
 =?us-ascii?Q?RtBmZhTBo1tLlxbwLZuAWKo/D+g84aK6CnwdeJHq2TbQ70KU54t6bLxxPmGe?=
 =?us-ascii?Q?Nu2OoqmzW6hav6PIFXjDvDSjlPVoLYnQqA1i0PVaUSgqE8ICV9Ss0lwT2RIn?=
 =?us-ascii?Q?6PDO3nt8Qcm3CKWMN9hVKrctaKmlSMwTLazGWfBzV3JWMmZk5fEsuT/H297E?=
 =?us-ascii?Q?IstxW10xd8CQS0mHNGuspnNnt5y7TKAPnf55mtXAS48yqQsEn1BqszkZjCfU?=
 =?us-ascii?Q?fNtHfi9uvT4WkJnzYzVwiDFvWx0+r2qMEIg8Kdh05AFawaRb8ovXp1QvPTL+?=
 =?us-ascii?Q?1RkbR4WikSAYcb8GSeW0KH9PcmWHlHozNEpG+xrtndHnkLsP5WuhCjLuZ+9N?=
 =?us-ascii?Q?yIpvY9cxQIgEkpaMsc+EJxdvDcDIKufiVZY3OehSEayL/G9UTKvpNDJEhcmX?=
 =?us-ascii?Q?plukLzPDJml5bmRlRDogJtQ+5I/pJbveFapQ4e10Umrrw96DI6EKPpNzxZ6V?=
 =?us-ascii?Q?Jb0hB3mrAh1uP7VuJTbKGZFFPakQP1D4at1LuLLNSdcIYsu+HWTFQuxBIjY7?=
 =?us-ascii?Q?bHVm0Ul3eGizL0KGyNuxgLlfkz2Y4SrMcafHs17FbmFQ9Tsjvfr5SgaZCOMF?=
 =?us-ascii?Q?DSkAiX4RI1LiEuD9zSrggqIZj8UZejkkvffi/+O5RirixfzO56divn8Q2tuf?=
 =?us-ascii?Q?JJ2KVMX0X8ih971XTzGDsygAIws5NQl+SwaO/Dg9DVdv980zxUCipZnLFh3q?=
 =?us-ascii?Q?ypcQ+KeCCY0o8XxU+hdAgfvISTdieGecagpzt+uLlq8l6k8Y7BMpCX+UxK25?=
 =?us-ascii?Q?XXkD+XZjp1q0xc3H/x7sRwIx534c3cOZPN2slJ0K+ZO3X50hDYcb3uYn6jV8?=
 =?us-ascii?Q?4Q+o7BwmJQklo0J0oaIuO4kQffIG1mNRuDw1VNM0hCka2fNzzkVgZoelqwhG?=
 =?us-ascii?Q?Kz2xFAgRVhj8MHCljy5tyTBXPINlveaTUBB8VXf9M2+i7iB53ooKY4/cfvIC?=
 =?us-ascii?Q?rDkSS8sof+klyPlibTKt7Y989zLIaRLcQPeKGK58y+WbSs+JYb3wrBvjatoH?=
 =?us-ascii?Q?eEh/SobjFTHK5Pq2Sh21e7jSyIQ07e6oRCPeFEWz3bnHhwB0kQgK972YiBNl?=
 =?us-ascii?Q?2qLpX9PHBcEBHEfLLbyQdwMNRxYBt3Vtq06i8RLeH3zdDEwVVPzUXCZEFWUb?=
 =?us-ascii?Q?Oc9G73c9Bw4kZ09gPmBnnYeAhWYFEfq/L7MhIVN4pm7e8IFIRyUQaMUAJImZ?=
 =?us-ascii?Q?qmDjIFScSJ7MKew237pn1MrRWoDwWXkrXeezd31quJ410+NTCOfthwTAud6F?=
 =?us-ascii?Q?+sQmVozhZQaGfBY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XAjSb44k6CC04/ecTpyjw+7UpKJB7KkTdrSb1SgDKiRFcOvL2A5fCXfuYyoT?=
 =?us-ascii?Q?6JZ0mzvp1kJbOUbxx8VqDVuMRAtNARxTA3G2HwPF0k/ds8jf41BB2oPfWfTM?=
 =?us-ascii?Q?vfkVwhVY0/uXKcZbZTJPVFe0LGB+8VaflGYapko4awbJoCHVnrzYJJUUgzdj?=
 =?us-ascii?Q?jfoVlIDch27y2xXJaCEfkDnaelz8UuFkLgyFuasASFkVPRWrWrvDAWQmQvPE?=
 =?us-ascii?Q?u8bUH+ojv9byAqgzexN5Ocz9saR8MrzYFaVEIILAOrPe4zntwZ/ee7qi5a8/?=
 =?us-ascii?Q?N1UmLI5iw+R59JsQCFUoa/PlCER7sdOwPGjAzAc7gRnQe9u4EsVl2oPu0Yyo?=
 =?us-ascii?Q?CQfTlnwEatpMla6kxJBcd1IYWQcCIwc7S3N96IVT1bb/wWT6QlOVY8Ej9l7B?=
 =?us-ascii?Q?jAE8dY7l8YKX+8L1Vp6PnAgvqYwC1afGeGPQ9/XcMyM3cipPnC6KQiM7Zxpn?=
 =?us-ascii?Q?LiW/aXpm0VpXwKktaRMa28Yx57Qj2XS/AwVA9yn+5rTwEHAWFhDuaS8yJFdN?=
 =?us-ascii?Q?8McSR/9BMw+0ZMlFsvGyQBDS0kmIN5g9+ITMEWAfP2NxgfIQ9RkJQmoGaVSj?=
 =?us-ascii?Q?CMChRRVenn/fW0x/fE/i41zOQIaZUorWY+22kfdKCspc/VMPK6ZFzrGXvzgi?=
 =?us-ascii?Q?Gg29ViFYWZjuqb/mQjl3+bp6PCSfnkJZwgVwkwJFWuD1AcQ6t4oUlgHxPuJ8?=
 =?us-ascii?Q?SL+IjVBUlkSaHRVMG180GscgH+bI1KaB+2c8Rn/2U6EtVBkKk4gJBpKgrdOc?=
 =?us-ascii?Q?0EBveFP8Uk7rpw37N6HzbGQef4PjmymXzsxyMwVPdRR59xtNMVOOTdonHTex?=
 =?us-ascii?Q?8Pxys9qcoWfrFiu5uU0CdlZqtcuV0fiSlM9j0nyTu6PLvwpD+PLfYf5oiXnX?=
 =?us-ascii?Q?uqhhu2kZpmoJ2rJLetdILj4CNFgQUHLXEx991FbBpyKJbCu/yEHblnN17jhA?=
 =?us-ascii?Q?8JOb7aFr07lTJP8G5JNCox+Kg1XSua0XGq5x04f1IHtTIspHC6zyJZC3Ntj1?=
 =?us-ascii?Q?QBsnEzcqxI2mIQXG9KtojwZHmkf1DqkAmrH3/gH6VkbAQmkFIkJYEDoTgqcP?=
 =?us-ascii?Q?riSk94ndyQDsfH1MXxLezXNWMcXv5g+owsz2+2WljRHvpoU8oKN+sBaI8g1S?=
 =?us-ascii?Q?xD9kIvhXH2hBfb8ONgzkBmlm6oSw6EhL7Iq4pTH8ju3AfK+Xp6YNYD9VfZ71?=
 =?us-ascii?Q?8DoLdF14b7J54M7vZtj8l60Zfweocr6FGV6rAjBzp8gsEF2FBzDVYaSWcnH/?=
 =?us-ascii?Q?4k8vgSYxoO5/8N2iKpXoL1c7nKG4mj7slnTKO1m/FT/2zo2wDxTcd9EyDxLr?=
 =?us-ascii?Q?rHIPHX1rI2fFkSZQX5AShoNK2D9B+72P3CqfnaQg4Le2Pvl/4O7DACB0OXru?=
 =?us-ascii?Q?RGs6tklnQgviyZXldw0asjPqZFAGjRDvzns8+Rr0xhPpsGShOnvo8+mdUnDd?=
 =?us-ascii?Q?VRZDkiV/uiLq5h4vxsNC3y5g4fwMRPbRZ3aN7BDSQ1+04cdUDD1s/lXMw3EH?=
 =?us-ascii?Q?BeblwWBmyqfGoLRmetDTsHW5loBd403bFzYqPAXuwYgn8NWnh3N21l5Mfc3k?=
 =?us-ascii?Q?6TWT+aBbNhNF63ahh/eaChZSJUayf2ckQIKiq5do?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb4d7c3-e8cc-44c6-b201-08dd926a8404
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 22:07:13.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg9YataNZ+eOtB3D+t9OKTJkWHNANCdzXSgBWpPMSZGsUlNN4o+Lr2GP+2eY3bJipdFYmkfey167/+N6sLj8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

> On AMD, polling and interrupt are independent. We still poll all banks
> even if they are interrupt-capable. I think we discussed this in a
> previous revision of this set.

Can you race and double report the same error if a polling interval
and interrupt happen together?

Disabling polling for interrupt capable banks happened before I
started looking at this code. But I assumed it was to avoid double
report.

-Tony

