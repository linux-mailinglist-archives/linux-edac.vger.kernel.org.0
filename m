Return-Path: <linux-edac+bounces-4315-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABE2AF8BB8
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBACF1891F14
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246B21E097;
	Fri,  4 Jul 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzpYr9ss"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029A283FD6
	for <linux-edac@vger.kernel.org>; Fri,  4 Jul 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617133; cv=fail; b=IXZfyAVO5Bm5C5Y0Q79wQO5BKRIElb/cKuT4tXFY2c8xKDRjNGvmeugTthbRDoIYshZQcItFGiiNylzIgBdi5vMpIFrlVu6wEeanb9hTbpx+UhOhcDAJN6ohL0jLID+2kuxHsc5CDXwumJDVazE9pgzcP4gMpZqUHhDmWgkee6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617133; c=relaxed/simple;
	bh=QJMAC1twxAIkWecKl24Cj2OJa7+XoszQ/Ze6vPpq3sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lStY2PsPdAgQlOdYFNlgX4jEdqekC87E0dldBuNIdaByIp6c84EpaGHKWn4UebMlQpLJyq9VX47ZHAVfB6lO6ChNdcaL7MNM0BjHfMYIwX3O5EP9brIkSBVUEC/tKhm0veLyLdv6Xm2VN+9qfzSAdUGv8dJ5gJCyJhQJkHp4H+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzpYr9ss; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751617131; x=1783153131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QJMAC1twxAIkWecKl24Cj2OJa7+XoszQ/Ze6vPpq3sg=;
  b=jzpYr9ssFGFmt/uUAu5bLYzzcxiARQbT0O7kmzsP3HWVKYfZdMNtWaKn
   kfrU5TgBrMM3wDXH3cBI4YTvO54HAvpgrxWeaXvipWiHGakjRm4SAZuAN
   n/qnHeOfTdAiGQpvRMLMaBf/y/AfBkxKmTbLxTXuK1NlIoPdoUYF0bKtQ
   8uqGJBPxC+vwDhePi1+WQpedn2vxxrBG9pICA3OOGkpWDHw5nd6uSO6QE
   X1bjq99tutmqfsMJQ/e/64NWo7ykEoVXxRd/+AFdq7Pmm0RNO+VUQ5ggQ
   psaf69z58fS/KVoBVVD8aRib5A0IsgQZ9znBVrFk7Ur7LzIa9H4rDuYgs
   g==;
X-CSE-ConnectionGUID: djmHkhSUSIa/it7cBWrYBA==
X-CSE-MsgGUID: avMH1+rqQ0aqnah+cTbxPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54092642"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="54092642"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 01:18:50 -0700
X-CSE-ConnectionGUID: k2a473QMRKaNGG0nJlG4jw==
X-CSE-MsgGUID: U09p/yWqS3uOEtFGPbnB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="191760688"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 01:18:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 01:18:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 01:18:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 01:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW84SyAtv0weE8xhNDeLb93VuVTkfllvxAUc+B0VE7e4qzose1PN/YhEHVTkaeZfZmB3rb1Fquwao3tJ2Q3aBTDWEKMaLJJC7ny2od2rF4P06NgAap5XM9elhhfOI4sU8fQFgcG+iUwQNSkWDO9wjRqAUP4tyMUfk/0LbgAmfatYShd5JvEs5aResJ2gIguWuNLHjT9x6le0Jtv3t+d6Hx1GgdeMMppMHi3Kfz6hVBV5hZl4Rjca+wsXnRRehgEBkjtvJ7AFffvW5TwSqLxCs96ZZR7ciFFGdzQ792TBd+sf/WY/JD+hzJDMX+vEzRIo++dBp9vd5UaGzecjfAPMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJMAC1twxAIkWecKl24Cj2OJa7+XoszQ/Ze6vPpq3sg=;
 b=jqTFKnEMthg/AvKqa+QV8gCLCqGxjeZYqN4dcxUOW7JiJTkYCs42yf5NnDCiyoiECowlYueIB09iAdNu06n38UXnKUy5rMgKmxwkN1YDIRPvgtBgrUeo9WGkeB1zkuu2Sqo1o3c208efXnai4eliYn1ATaThr5LEhwGIKF+nM3NZCriosbcorTRzvZ6H6It0Gbf2LtPyCluJcLfRdeXBZozdG27sHlOTH6SD5HjF8Xk7VH3uqijaJayc+oPraJMVRLCxyMFoXg8oO7w4SPybU0iLRXwhyUxRPwXUrNmDE8q7UdnahXWlZOcojJ7nU8Z6U2dovRWweYlXgawM6XB+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Fri, 4 Jul
 2025 08:18:18 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 08:18:18 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "arnd@kernel.org"
	<arnd@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "tanxiaofei@huawei.com"
	<tanxiaofei@huawei.com>, "prime.zeng@hisilicon.com"
	<prime.zeng@hisilicon.com>
Subject: RE: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Thread-Topic: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Thread-Index: AQHb7K0CXplwwb3rYU2bjHNrm7U7hLQhnLtA
Date: Fri, 4 Jul 2025 08:18:18 +0000
Message-ID: <CY8PR11MB7134C82ABE0CC64ABC6B68628942A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250704062911.1882-1-shiju.jose@huawei.com>
In-Reply-To: <20250704062911.1882-1-shiju.jose@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB8182:EE_
x-ms-office365-filtering-correlation-id: 2d5aeae6-8351-40ef-c835-08ddbad3552b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700018|921020;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LCNgD/oA19iSwXBLHLcG5XqWkCAURpdG74BFgY1V35T8qLwIb+jme0I9eO?=
 =?iso-8859-1?Q?78d7nTcLWw/C884f+TleVFG0TXtd94etq2KzX/WCfI0Q96OTQctyxFsQgk?=
 =?iso-8859-1?Q?myG83fOua8plKgBqN0UTKK1kTy8HAB8ozYbsN2KJNWfvrU9DlVf0lQoT2A?=
 =?iso-8859-1?Q?iftWi4DoUezRYBwZSljRLydzB5WfmYDWYHNL0agq157Ztt+VtO+uXrbC3k?=
 =?iso-8859-1?Q?WIlVoCHGr+exxFlT8ZxtwB621GVsjIdi1sE/B5Ri4HAtU4ontGkOYCruoR?=
 =?iso-8859-1?Q?odrwCclsPYyytPwYj/DMEO3SN2RECeQXryVSlw2gMkQFdWbHq7T0aRJRY6?=
 =?iso-8859-1?Q?ks9/8xpEU8M9ydgQ8XuOcy3cQCh8AY9eJA+/r5lrvEeWHfqrSUzRgX9AVA?=
 =?iso-8859-1?Q?bBYHaq+8EuWRI3OgANMl4E3b8zyzL6/Do76PYeDNa91PVD+lH/qLfFMMBP?=
 =?iso-8859-1?Q?UxJP4IbUQpZ4bvmpATqypB8SbTomcPiO1cJu4OwWpxu8xmEaSJoQ7nogPZ?=
 =?iso-8859-1?Q?GPeFzTOZNHftTNaovsXw0ineMC0lGlYU1o9VBWlbNsaLkwcnO3ENRnzP+x?=
 =?iso-8859-1?Q?88TgsQ/E3Emsr0lUjN3VsINo+WUm5qUdrKsaSMedfNgQbQGg2Xt7I8tIVZ?=
 =?iso-8859-1?Q?paAx5Tsyw/NQIB7reo+59I/ql9fCIIDuluqftCynU4Awt68q1y96hdEF2F?=
 =?iso-8859-1?Q?oqOLHg3BXiEJBNT67D6HDBq2m3fA+b6X4Xp5xT590alxoGtftFH2X+ljnk?=
 =?iso-8859-1?Q?5dfjRvgDIOFXKBa3zpIH1+Z4n5mT4d3A+qcwiV0aJtgYsmWxVtVsTvNlez?=
 =?iso-8859-1?Q?XVLvtfOnPSRswGEO818KZlaqRI3AXVAh7d/ZJR5wBQtFFbvnnt9hjGTxYy?=
 =?iso-8859-1?Q?Ry/JJtZEirU/5/yaxrhON22qAICNaXiLE9PqvLu++m0Url7jA7u6tvMoiT?=
 =?iso-8859-1?Q?Y4oHKdAOjG9wh+HB6vYh+byhn2+U5x6SNnSkMZcodbRSLs0l/cz1HKniP3?=
 =?iso-8859-1?Q?j/gUHfQx+MoxAF8C4Ek5vj4GuQFM/7tJ+Ka2QrnbfoogV2Oc6xtQmKF6us?=
 =?iso-8859-1?Q?Z4dcaeoJsxPpRId9sAR2WT8hfBsLwcCBCL2JLcOavRp8h2VC40Fo07f2qZ?=
 =?iso-8859-1?Q?AkH0tB56HTRsnCPPSfZJ7UEMH+U7IDBFtTGStzlXxWxuLCYMD6LoayD5FK?=
 =?iso-8859-1?Q?VNz/pN6/FNwlC86EDLMvaoKMnJWLwV2j0gE0idaZiTu+dtpKLkTnOadfq6?=
 =?iso-8859-1?Q?urN4gB3ZfhuL6HqcWq6KnGdo1nbxOxMQC1x+x0vkoXuPJdnSrj12J9gO8n?=
 =?iso-8859-1?Q?z9+/GhUf356RIdmPps4pm4hBM1GLoJxejkffPSeA7PKTclFiLFTmaUowOW?=
 =?iso-8859-1?Q?0D+t5iX7VgAIAuTGTUURBRelSeP8QMl9pNakpiV4PIFU7voazoZ2cSzrvq?=
 =?iso-8859-1?Q?wSoNw6451J7njzuSt0RcH1m1r8zLWOWQIapm4ToSs+6+m1r5pq2bN4DdeX?=
 =?iso-8859-1?Q?IQE1hmrYZYubKZfqblmT/wFaEBc2f02qDpr5+dM0PrqtpHpxp135A8kqF9?=
 =?iso-8859-1?Q?LdXdex4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p3CwPDPpTIS8LjU1KjMMWvlhxWTIBdNs8jJMTW5kVToQF5vmOg9E0hIonj?=
 =?iso-8859-1?Q?22OBcyU8niUNMWFQU/jBQm9bWs8r1t169+H4emphUbe+qJog5bksXEb18c?=
 =?iso-8859-1?Q?R+2quuW7I77fZ+AA3UJO5zS/maYYRwNuZQ6F7raJS350/qDUm/maoD5BXE?=
 =?iso-8859-1?Q?yuwoMiAStyw8VJF+6aAO2jKKfHeQgW85Yr9B+iXjgE+14ZKc/WPvC0SUJ2?=
 =?iso-8859-1?Q?l5iy2hcn39gf/7XU3zpiCtOKXb2NsKllq1YqiYBWW61cvw7gJkRTOJHkDz?=
 =?iso-8859-1?Q?xX1dnMtb8FtvoQlGKnweKp9YzDknRqeJ7Q5S0fMyY3GXib+xl5O6O0hbs3?=
 =?iso-8859-1?Q?DewXAMwtC95nAGFK9PpmMIBj4UMK0HqWW2B8l2dCTZGWGu3qNUNUeYsrCD?=
 =?iso-8859-1?Q?DoY9wUx//6Pf4yqMblgTJGF5I3JgeccXQ3Bw1W+HxuXqLiy9eofmXH3gzq?=
 =?iso-8859-1?Q?8bzAV4jJTfZWacmFqV/lKF12yX9i43QNKUmLNf2JftExCMkyHhWmhbQSBg?=
 =?iso-8859-1?Q?FfdCVkvJZwa9nhX58E+c9OS9ZSJRKHjNFuJqt/lr+fW3Y0WLuynkSE8ZzI?=
 =?iso-8859-1?Q?8KNoo9EBcBig+my9jg5bnfMBeS8nIsDngIhWf2cQ2qVzLSf+3PxyK/RwEs?=
 =?iso-8859-1?Q?lGeGQHGuxSrvlsZ5nslJNNxeQlckbN2ojHGaYJ2F3LfofAWfTemvD24qAj?=
 =?iso-8859-1?Q?tZyXd7ULvfJWHi1DSFsmPpPB4C1Li3210l++hNI5B6N9HzRVOzsOUlODcV?=
 =?iso-8859-1?Q?/JasJHIjrcM5qFy9Pi3JYrb9lPydWyXvcNszizsqCQfF4dMA1OGHI5jBpk?=
 =?iso-8859-1?Q?dnvxr5jkQYQw1OJXyfeFX8d+oqMkuz1G0pIDOA2tQzOCoBfRQ3w6fHAZ0L?=
 =?iso-8859-1?Q?q9VI6bVacaN6rJRuRRogzK5/8vTbOrqqnK3FpZ7f8Q5M2BnVLlH0vDnxRJ?=
 =?iso-8859-1?Q?x5U2y/2I6qZm6TCQzMEu6ZcVtr/xf9BpUoX9ggJkNbuUUENnXOwcuZ8jXu?=
 =?iso-8859-1?Q?h5bEW5yh9Ds15TIRefnIZsTHkfzN2Ovl/VcLe+Oyg6p17YuLzDKoqALsip?=
 =?iso-8859-1?Q?7Xe8Cp81iuAhSa+3JM3kD5Jz7Xc4ohb4lu9GzaNjKNvC7FAl6VvffwMj7C?=
 =?iso-8859-1?Q?fUJEE0Wt+cDgb2tJCQYGnALMeGEVmO1WGa7ycXt5toPhtzE4iSe0QNDhp9?=
 =?iso-8859-1?Q?P7vQMfsMw35cOr22a90h2aNHeneaBRBVZyvJ+UB2eYBNFUsErfLSxLYmUr?=
 =?iso-8859-1?Q?+epug3XnvF8FjVpobvoKXclPQTo0WWOf3Sf9NYfQahLjpAMcl1dWagXJiY?=
 =?iso-8859-1?Q?hqI9Gg8l/HAIwiUYhwUfpdMtNslntoNPHBtjt4bOFzGz6L+fttGpTVHz1e?=
 =?iso-8859-1?Q?ae/WFP87qgM3lEr0y0wm3o+eDSICatuwuB/pKBdbFA1ryO1S4LFL9fR0vV?=
 =?iso-8859-1?Q?AX+hUrT3i81WoFO0UDdvp7pGcuUAhi/m71UX+nNeq7PjyDVndUhA4B1OGh?=
 =?iso-8859-1?Q?i4eV8QM7R5UXMS4ROC/InYiotVv3hVXLvV4LxzLH4Zqo5SPl3sg00/cEQQ?=
 =?iso-8859-1?Q?RUB+NzitZTM3PheW582WjKK2RdJXnf/JnwT5kVog0nL6EKKkhCxgCCn48Q?=
 =?iso-8859-1?Q?KUF5R6I5cKaTrcSlKsXGYKxasReQUIq149?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5aeae6-8351-40ef-c835-08ddbad3552b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 08:18:18.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqgW1iaj9GXvyy95rf9ifT0WmhL5xErwIqjV22l9DXa0pRnBoYUslS2XHSgF0yyUcODKfdpeJ25VwzQMQajzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: intel.com

> From: shiju.jose@huawei.com <shiju.jose@huawei.com>
> Sent: Friday, July 4, 2025 2:29 PM
> To: linux-edac@vger.kernel.org; bp@alien8.de; Luck, Tony
> <tony.luck@intel.com>; arnd@kernel.org; mchehab@kernel.org;
> rric@kernel.org; Jiang, Dave <dave.jiang@intel.com>;
> jonathan.cameron@huawei.com
> Cc: linuxarm@huawei.com; tanxiaofei@huawei.com;
> prime.zeng@hisilicon.com; shiju.jose@huawei.com
> Subject: [RESEND PATCH v2 0/2] EDAC/features: Reduce stack usage in
> create_desc functions
>=20
> From: Shiju Jose <shiju.jose@huawei.com>

Which branch is this patch series based on?
I failed to "git am" this patch series either=A0on v6.16-rc4 or the RAS eda=
c-drivers branch.

-Qiuxu

