Return-Path: <linux-edac+bounces-5484-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E839C729CE
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 08:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259434E3A89
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F372306D3D;
	Thu, 20 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mk/t4tYG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94363305957;
	Thu, 20 Nov 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623828; cv=fail; b=T8i3DA6+8ie5whWESeu84Rs3wk/GE4//yYIkwUTGkMFxmnbMT4ydycnEjk6bd2i+CG3+2ZBHgr9lQvMUl9XCP7RpoNGHhkKpYp/WW8koKKZnxiy+QmYguWRDA7T180qlsvH+WDNZdMqirOh5x2wQBgkZYfsop88jU4pCPbEDsBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623828; c=relaxed/simple;
	bh=J2CcPmuHvlTAasFquH+QTjikOE/KWJe+bH1kTfb4ebA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJYE3MLRmctaqRo7Ato8lJIU5hgG0lBBupID3zaE5B/FLmEpvbpeuik2iUnd9TeAoDhw3lnMmKgq1KPur89+tau55YUfTL3QvLVOgKtWve69rYj5LOBW7RL6K9t3aSo6r7vMPTdZcVHIeiDrbuRjl6QHOM4RWfQvHArBX/bAN5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mk/t4tYG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763623826; x=1795159826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J2CcPmuHvlTAasFquH+QTjikOE/KWJe+bH1kTfb4ebA=;
  b=mk/t4tYGcBnmKlgGjYe/TToMnuipbRhvX2uAJ1XNPCydf2Z/fxd3wJUy
   q5GH3siuo33RYdvvPxI3pqxMekgxfXvQeBY/O5tGbJ0tfigjNGESA0c9H
   UWhsy4Su/ELGs4bePbdf/ETR/hMN2qWCTqlC/1FQhIckO10Zv4oz2aKdb
   f+/LnHgXMwPfhHW/STfIwEcxz9aBKeTPzlIKPfd3inoaXMDwEfCi08SnJ
   e4wI8+FAdWVDaDNIr++wbyuVMpd4CCHxLFZ4Qi9T1+Jo4ZmGjohQO5iuX
   ypOA0dM5BZY8Jw/fIqT6v1KJlfNDkv/rYFwCKQKXNZKWbT33mEoncVzNE
   w==;
X-CSE-ConnectionGUID: QYYOeNIBT8uBAFjB3V/soQ==
X-CSE-MsgGUID: dKmSif2aRquJ9p2FJnf9Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65840949"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65840949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:30:11 -0800
X-CSE-ConnectionGUID: XatdchvHS1KJLWdODBNDQw==
X-CSE-MsgGUID: ScLW/IS1RJatiyts3OaSfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="195764003"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:30:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:30:10 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 23:30:10 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:30:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5OHYNOgXXUdIsGPRHMzIH3yI2OaPGVdWw5xH/5hkbnYJdVA8akpzF+cPWuGQNBlX2vRyNgJz/42bhYl5FnxbrnY36/rFLj4Di2aMA85cl/mu+E4umsRzb6d5NR0lmfgsKn6LKTjn327D96rQ3xVKvWk3NX2f3oW+mFRoIbn67629srXot02y8WygfGIwqF0TY3QvMYvFfYAD+cfw5E7W/XzGUXkeyZDvBYFSjbCD5C0t8Ve9F8vz/snWJLE9V6BXCKt3nmHbOYl6EwOwMw+vVhaQwLWuyFi353m8O9IxIfJr4NasowyzWHnKGqdZZMNBZE+lwCVDHs98/EoCamnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvXY+sNalzi8AFNvUqDwqpaScbXJUyumLL4kPyEf99k=;
 b=erd6G2TvtHukVjDtAl+VWdRJSLlynbNNMgN7ooll6kix9ibjf1XDGCtUhRkw+H3rRwVUsOcsOdkp3XnrAV7alu3i13xAS+Ro6wiCQv4OOLFFjrsQsU8v5n/gT7XKaQddQ1gWJJMFKxKK06nZQRwdslK9TdWxUWCkWg3s0XuA416y3nOGizTsGrWuxa2uIWUeDGSb3XzOeA8M1xUugKZ4uEm4bplWb7P5Nu8neqMQLUq1bN3Wrmc80TjPjcUMKanqTXAThQSTSE5chrYM3xgzcoEReAJ7B+fsJrYueHqTowaS0xKAo9shNsJvk8JUzaK2FNpU10vnbtiZ1qNd2rOPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA0PR11MB7331.namprd11.prod.outlook.com (2603:10b6:208:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:30:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 07:30:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Haotian Zhang <vulab@iscas.ac.cn>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ras: cec: Fix debugfs error checking
Thread-Topic: [PATCH] ras: cec: Fix debugfs error checking
Thread-Index: AQHcWco3G+xrx39gCki5r3ztBpyoMbT7KQLQ
Date: Thu, 20 Nov 2025 07:30:03 +0000
Message-ID: <CY8PR11MB7134B471F7005E5F7798ABAA89D4A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251120030214.492-1-vulab@iscas.ac.cn>
In-Reply-To: <20251120030214.492-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA0PR11MB7331:EE_
x-ms-office365-filtering-correlation-id: a127b794-35fe-4a10-7d46-08de28069ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?lUIGyUbnwlw6MF/DXh2Kv7CVr1UNz2nkJsoO3U8a7uupEB6nJBp0Ga95ndgU?=
 =?us-ascii?Q?40nFk4OBwfIz8blmaiQLNzE0vQWQqiA+KNCxor2l+33hdmgotNIdq+C3Ysxz?=
 =?us-ascii?Q?xyjqW5xiykeEewtbA5i6JTF5KCfv4YFsV/fy7ZiARiTI48O45knnRq4yR3lv?=
 =?us-ascii?Q?SAjJE6XovymMc06HVvJF466mllqAD7QW1Yy2oF4DrrJ/xOF60IyoUyVnWGGv?=
 =?us-ascii?Q?pHxXWr3oA1G7FTFdqntaA/IInrtnMdB05SMW4xwbPZkiXDNBXG8/bncd+O7i?=
 =?us-ascii?Q?UVdzf7EgbzJQCfBs0jRf3lH6nGYNyVESgUMoLv5+yYnYWkhlY6Qxx1PCccZR?=
 =?us-ascii?Q?bi9V036QgOBWKRsIZjEiIx0vP+xjquvZLApYoIlmHUFquvAE+arJ0Jaq+fT5?=
 =?us-ascii?Q?LbYrdxZSjokZZe8iOQfWv5q+PP8wI6pwWA7xlAXJA6cfG9DyK3s57F4muMPo?=
 =?us-ascii?Q?JqAJi6iA243rn4m6M2pYqF2efw8exYx//bfsaJfgcZ215XQJJIzZj+FzEvD3?=
 =?us-ascii?Q?qBZD/OxkP1SxxtOJ0VUpy1zw3AmplpEFJcMREHcMfcvl8TDEngiPHH44XXT4?=
 =?us-ascii?Q?hMYX+ljfPHik8aLlr692jsQGxRkQQwcT1iiueEkj+A2n2lvvtLvPuS549rf3?=
 =?us-ascii?Q?y2cCbExWUG99BPaf/iHdjSWOy1kPMA3nhTrXYzox3degoUE02G9OUvpmuG9s?=
 =?us-ascii?Q?H/RX+rtCVqThn9iNjv3HJGtkukupVS95BgcTYtVYfYJkd1q+6epHLh71AhEA?=
 =?us-ascii?Q?NWJdaF8fYTc9D+EwOOBPgFfe0Ir4un64ijEl7BojWCewleNzbVYAcCs1jNcV?=
 =?us-ascii?Q?Uq0Wl956MUkLanV2QowHnojzGXcnL9sbX2+QqU/ueDQlXBXf0D+BMsT8Q+Kp?=
 =?us-ascii?Q?KWS5OLi7iXcDaHEmTjQLtJdUFb+NPGKAHQIgPHbtfs2gLGVs46n1/wJ2vpio?=
 =?us-ascii?Q?eB5g8lsuTu95h3NzRuHomIuf/6PL9wqJvV0q9cSoCZ0mbIGSjdwkwflAevGH?=
 =?us-ascii?Q?Zyer5FqBmF7tIfXOLpaZ4TB2rI/ui6jQdIyEXj7v6AZg5PFwIJxb3TAOLKLa?=
 =?us-ascii?Q?dfMGFycIaNwBLh5W0kYv1mObLxqGlnpORRZLk8iJ+1NV72bsjnsUwWpkrdjT?=
 =?us-ascii?Q?Mwppbdb/6dyeGNoMsmXfj1GlnyCvDhDItgBiGh4MXLEh93ZCvBigOdPXqnkY?=
 =?us-ascii?Q?GSm8f9y99O5JWtlxlRyL00c2miKeW2yO+KUvkBKs/4UrP5kB5M+r4H3m43x2?=
 =?us-ascii?Q?JFmIdiyhnG7BEHNjdZtQgbSPVWGuv/b0jkYLOjZMXyg1E1pwQoFTi9DhGCV8?=
 =?us-ascii?Q?4nYo3r76CpTt2jHFrnXCsTCHm6PI39Fwwlr8KPuq5OrfZPjWRiyGq9j7jQVN?=
 =?us-ascii?Q?Q9zouQaAECDGkTfu9dQn8ZoUqAFdZF+cgnl7a6yapmodKEzP4EcNRffZTh3h?=
 =?us-ascii?Q?9YUaBsd0FdIJedt2lbQN+XeQm6LR/bChyDZCQRJ1BK5SSAoXtfKFyLi49CIS?=
 =?us-ascii?Q?8g5wME3AgfDdTKC5Aj8nrEvG1v7W3mjiqBMN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rk7IMuHZVrJ4QjNmLbv86PQjfkMhosWM807qLbr8B7tXZteuSZtRBqfj/Q35?=
 =?us-ascii?Q?0WQlAmTerJXXBcipYybTSsD7fw4ldL/hsmCrdcyGZEN2iL95IUZq4bzWAy8X?=
 =?us-ascii?Q?yThez/16Btp0L8IhA9zYhvqC5yMi/ec0ZhQKEO7jBpY/Df9rTzeFqB6HRufy?=
 =?us-ascii?Q?X26t6vlFGZCRkjh15dWpeZxvVzxhSH24cAs+yfjG08M0goQfx33DHdJKmKOG?=
 =?us-ascii?Q?4rSNaYFgzl2PrRO2+CGAfOJbxGOBCYavAmzYfFmV1LqQd6JY2wndb05B8tfq?=
 =?us-ascii?Q?KR1iL36VHlOjrERUr9e2jkNVnHhUTm40XANq4jM7KmcFreLGyLmVrA9eNGn9?=
 =?us-ascii?Q?Gr76qadmIQNuVKIhEovzmhfLxZszJy0zTQdlVdx83bGph2/OVCRce0WU0EsF?=
 =?us-ascii?Q?ZVLv9rc+XbMI+sCJtPp19rdot+eKWxHkQ9J5+qI6wUw+FWNYkZ2BtXutYvLG?=
 =?us-ascii?Q?m7ZkU6DdcAYsdrcuflahYShd9BsvXuFBLxsaZ1hx+uQqINNDsi9IyaeKF6sv?=
 =?us-ascii?Q?yNSCIv6HLQdJoyLwwNOAlrOYIyrDagHHzlRZrq26BeGR6rXxUdJ8xy/ydfjC?=
 =?us-ascii?Q?23cmRZctVYaarr5TTu/SyKIejTdmgBf9AEzBtLvX8XGnrm1sodhddk1DjxHv?=
 =?us-ascii?Q?lk3b5yguJWmk6kp3XAr7ILDnYH6YxauS7camQVx34p8Xfd+SDK7IB4wXJ2yf?=
 =?us-ascii?Q?twYv/yIeQnyIKpWI/eoFLSVyN1hVol9m4MbfnH6vcVVHLXWWQGxZDQ1kpVDh?=
 =?us-ascii?Q?HWb9B5gCdKbESQtcmvjBl2dpnYP7a4ys2AGwPsFm0IrpS5SN94PFMpeuwyHM?=
 =?us-ascii?Q?Nb+vjrdasIzF/Kr0b7WflSTWnWneMPBq9VkQYCnO5fKRiOPg+fWBCO9ZZC/9?=
 =?us-ascii?Q?DM6BoxULO0FR+9mnVEON6eIZQMdvNV2g/CcNcnMdziV7BAx67zlRFuZs0y9r?=
 =?us-ascii?Q?K4Bg+mXmiuLQxfZV+vM+hwoXmW2Sk6tDZpaCkKQNqc9oy++XeDQKgPqdggxB?=
 =?us-ascii?Q?cDca4NzyInFcuBWqWKwQN9hq5ZIIgupRL+Cu1ei8MqcB42DjSlX/K9UUoJZs?=
 =?us-ascii?Q?ZjazUmqBKKrDPWT+aq/G+nU2DhuPAOPCqFIqPHTeBCUQMIG9byJdaAf2zh1x?=
 =?us-ascii?Q?oV92D8WCHnGM/6LXcBrqXlw3BadFuXt1mPImFeDzNFzKUXhUCEC4UlE6TeC2?=
 =?us-ascii?Q?1UYX6vNaVN5y1TSI43u8y7E2r3bd8BTGjQ++0pPhznvKsdddwU99+6X1yCfw?=
 =?us-ascii?Q?b0Ut3ybc4wGdqr7nYSGV6DmFXOKj0Bx6CgroxPa+Coaygk4Sfv69BfmPJzSK?=
 =?us-ascii?Q?dOR8fS0hyA5WkH034oAnZOQKlBIx65QmNXxHjfh7/6b3hafOez0ZBLFwzEUD?=
 =?us-ascii?Q?nW0dN3icizb+grPTh4NWcMYB/dqKLyn7cP48i9E691sbDXycvK64aXtdwW4z?=
 =?us-ascii?Q?Ag8Y4CYD/a8UmoWd9aTLJA+IzEnf2b0Tgqss/XKkgG+Pm0NtBWiK6z7XJlsP?=
 =?us-ascii?Q?yrjbzRWHI0oHt9Z3U4iI8sYwOprbtOAwDrtGYycWegqNPOzNjDbRQraZJy+o?=
 =?us-ascii?Q?oC/opNvhjZ4KSxeFPomocjFNGsPS3GyDFiNe4uZx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a127b794-35fe-4a10-7d46-08de28069ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:30:03.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NY1pC6n6EhqKs44bt9S17uuHDQExWkZh66NwkI8ae5waxKeZtK5NqyXiVe7uWbD4mVySmBu9KLMamV+eB8wpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331
X-OriginatorOrg: intel.com

> From: Haotian Zhang <vulab@iscas.ac.cn>
> Sent: Thursday, November 20, 2025 11:02 AM
> To: Luck, Tony <tony.luck@intel.com>; bp@alien8.de
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Haotian Zha=
ng
> <vulab@iscas.ac.cn>
> Subject: [PATCH] ras: cec: Fix debugfs error checking
>=20
> The debugfs_create_dir() and debugfs_create_file() functions return
> ERR_PTR() on error, not NULL. The current null-checks fail to detect erro=
rs
> because ERR_PTR() encodes error codes as non-null pointer values.
>=20
> Replace the null-checks with IS_ERR() for all debugfs_create_dir() and
> debugfs_create_file() calls to properly handle errors.
>=20
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
> [...]

I just quickly found that there are at least two more that need these simil=
ar fixes:
Maybe you can add these missing fixes to your patch as well.

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..9f6626380ea2 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -483,7 +483,7 @@ static int __init create_debugfs_nodes(void)
        struct dentry *d, *pfn, *decay, *count, *array, *dfs;

        dfs =3D ras_get_debugfs_root();
-       if (!dfs) {
+       if (IS_ERR(dfs)) {
                pr_warn("Error getting RAS debugfs root!\n");
                return -1;
        }
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..8f817bd9cb09 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -47,7 +47,7 @@ int __init ras_add_daemon_trace(void)
 {
        struct dentry *fentry;

-       if (!ras_debugfs_dir)
+       if (IS_ERR(ras_debugfs_dir))
                return -ENOENT;

        fentry =3D debugfs_create_file("daemon_active", S_IRUSR, ras_debugf=
s_dir,


