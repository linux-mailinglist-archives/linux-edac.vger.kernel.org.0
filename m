Return-Path: <linux-edac+bounces-5700-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN2EB2gbimnJHAAAu9opvQ
	(envelope-from <linux-edac+bounces-5700-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:37:44 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C91131AD
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F13523005A9A
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6729385EC1;
	Mon,  9 Feb 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii2DNFk5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBA2E62C4;
	Mon,  9 Feb 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658661; cv=fail; b=JnStFkwOZXCg30SangPrbgiUjyiNm0w3y5PYHfAVvSYofzRN2op7dFLLemj6ZZ5T/koRg3dYwZ+zhzWyjHP5m5EKFg8aY6asu1eD09sxXow9Imvi+DO6kjQZeBUfgL6eFPS8NL0wkHzbYtdP4TjMaaMTIHTwmaUS2dG4aHv1fKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658661; c=relaxed/simple;
	bh=J2mcpMa0plr9QOlRM1Li7KbGNN9qMCzka2pbQO0D9W8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LG5nePn5lgZvPOBgs91kbDkE9M39lwH3dt9ua690WcI9Ip8tyCQHqECP+B0JDBsYHvU/2J1Cgs1s8W425ntlu7WQ9uPs4TBvH5ZCBY2jUFy2XGtiiu/SUw8+yHT1e9nBXHLpeo0r7MUF0WPMGY99hsWEm4lLnpFaKYZ0ZT0zWOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii2DNFk5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770658660; x=1802194660;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J2mcpMa0plr9QOlRM1Li7KbGNN9qMCzka2pbQO0D9W8=;
  b=ii2DNFk5Hzg4CfDEQy14/YSEzCriSz4eISwJgPVWNPXYW1Ocki9Rc87X
   U+2wQo5E4gsQHCki+KKY51fXUGja3+GsWBVjxofs+ToEw/tIzPA/5GMW9
   av5zd2Zw7/fdrphZnkpbCmbAXs8a26jL16tPxgAZKWrD0zb0ak2ZtYIM2
   fBLD0e7irLg141bc6t+RfLd3IM1TBYl+Rrpj92VlmkgEvuPXyn8UnOxIb
   GhvaxDN1HQwodmBDdq3ANNFNEY+FfaEe3fPROYeh8E9rhmbWn3xW8qG0R
   orKZNuAso6tUmV4SuPTY67TKf8DSYFU+7PWS3KaivXG1NmSI+M8TlLiqH
   w==;
X-CSE-ConnectionGUID: Q4jraPjUR46Ap3nixHyfWQ==
X-CSE-MsgGUID: tkKGBAz6RMeR3/v3Zv3zVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71497421"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="71497421"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 09:37:40 -0800
X-CSE-ConnectionGUID: J1osjNQ8SlC4C1w21yb6CQ==
X-CSE-MsgGUID: cD5z2SYiSBari7iSH0ZJCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210750980"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 09:37:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 09:37:39 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 09:37:39 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 09:37:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukcm7URlnHwNB18/wdEFARvZ9fl7KhyFkUFNOYbwfqJz6fp2qvWmFOsdESG6O1vI9stv9g1xtBQ9cZEA4Vu31kfgmE+bsh5tfnjWf+/E+oNFO3K6v6rwTt7fL1rrLuFOr08Q7T2vxphg2aKVX4/q0JoVFnrcY07jGnELYmxXQRCNSuFLefD07a9A+/zowMNnemZl0/RTIsU7y59aVq+XMXzejXpuCSKKTgni8dlYYsy3P8gz5C3syE5VSB0itHN4YBATdbp6mXnxHz10fSgcc2R3Rk7AEKKO0GTOJjY8Wsnd4U6dDxlUpWvme1LExyNi69jdpgqmhyJ0K0+xqesCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d18U0LHq9yHI5RgXGODWJTQ+o6bXNaXPaURkS6UM4zs=;
 b=sQUaWR0h0JQmKwe5u1cnpmPE5L09K35lnxrOd4AWjHwBprnMGPJKToeYWmjaTqFjALOjxCWtm8H5xj0c7OCSG2MTrWP13tNw2RVFn5qE/OV8UEF9tDk1N6nFldk+IWZzPIsFXG2CrM+VpSihb4B+OLU3OtCy+mcqk3GPlPDypq2P6tmqpTW7LJpnFYC/4NhU0hkVI5etrj8KdgLgaTgxFz7AaVElWW20jlQS3cY4Bt0GI8ZScf+YRgQJjGQ6/WzxT7Y/hQ6J1wBri3I5jP0OE+w9GnRTAhzs7gL/6CSKEyYxCGjwMN1B/XxF7MZGny7VP3KHxgIth+kIJpElVCayXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 9 Feb
 2026 17:37:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:37:37 +0000
Date: Mon, 9 Feb 2026 09:37:35 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Li, Rongqing" <lirongqing@baidu.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <aYobX83_0kElO3NZ@agluck-desk3>
References: <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
 <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local>
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d1d959-77e2-4a33-bc62-08de6801ea1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qgSmsJluftDxJ3XFxsEvUSQe5sXA8OxbCW2I7ExckPtbYpm05ZGI8au+1PNE?=
 =?us-ascii?Q?PEaSzHTbOM4EnJlg95bmxQZWLu3nURreHL+0P+/bhlTaB6pYQ1UdvfoYfRBS?=
 =?us-ascii?Q?0WUc2J7MAgoiIDFtxJ5zdRVQi/iZR75BxUJvaJm6/Bk052idvjzq18808Pcx?=
 =?us-ascii?Q?7PrpMXU9nHeYGbmSLIlVPYWZ2GhD5VCeBGGnT6mmtfnC6d7MetjVumY9gdCf?=
 =?us-ascii?Q?tygBMoevOco56FB5h41GzPz9J2t3V/oA1VWVOm4JWk9lS4ZzxqyN+UGUGHpS?=
 =?us-ascii?Q?4Dkk7JyUkyqLsABXVIBXamnJvLPpy+eiKMjfLJy7pBZzSWSfY0dGvXJRRvrN?=
 =?us-ascii?Q?j6wCC/gZ14YSuhhuI6MCbAyEwKDqZp651nhFzlY4G22GDiLsayb+t/KYb/48?=
 =?us-ascii?Q?OD4fOrNrgjjPOHdqe2cmCHufQLWanpG+NBA/mdGsU8CaU6a+3QkWKtVYrxl/?=
 =?us-ascii?Q?r4S5Yh0jYVn/1wOzvI+iKUQI3y33+kO8Ng1TuGS/Rf+HFvU3PWKAIOS1ohHL?=
 =?us-ascii?Q?HgOSGpLDPzTxMKzg3WC9OyQW/yPov8EogiIiC7WoVIsbrxvD71/A2GoPEuyz?=
 =?us-ascii?Q?Tv7tqGfXtLsvMw02L9GdgyTKym/Ie9WSw3d04MrkjJlf2II9o13i3CMWSdIF?=
 =?us-ascii?Q?h2hj8ZuIywGAu2uIv6dULKofqDRS6J3rCdF9+hH4xXWSnQgTmmU41EKguQ9s?=
 =?us-ascii?Q?Wk83oQZRAB9XbbKg+lI4EWfGnw+37pKlykXE0gksj53xW15AGl48zKLArniE?=
 =?us-ascii?Q?RzPvd7Sv4OWiBUcS9RNJ0Ja0XoMo8m1Ri/bLAGS/moyrcrMqQ1eOJWF5D6Yw?=
 =?us-ascii?Q?KgsQqzegG3Il4FRuFvmMhgpiJBm3rsJ2n1JKdvwWDaP61HkyyyBxG834wv0X?=
 =?us-ascii?Q?80I10cJ+Bg8q6Cg9d9mwcHVt5D8H9QmDk/9M3bTwDV3wljuWw1M07YjUFQjh?=
 =?us-ascii?Q?dIzRlkwu3egD6WGLBwFyTF6BFFEd4n1ve2s3BuEsGiXdKH2c2K/PYHo9yOyg?=
 =?us-ascii?Q?TX0SmmZdzcAJUVn2WzQrbtLVK0kp5H05YCV0o3670/s3e+wHaYf92jpOTZTh?=
 =?us-ascii?Q?buk2qp8VlVmd14xSAGCkbRoBpQ1HXbaD58Fa0H9V3ylr3MiJlGkEo6wsJelN?=
 =?us-ascii?Q?449zW/ibb+UAVLfIUQmELG8+Fd0UgnqdD/DGveKU7uEULRsaHg9lyqyvS18T?=
 =?us-ascii?Q?HgsVdsBSxG7KLRa6DHF9HFRakHDl2FzPcIa+dWPp13bv3p1ETilrfG3qq6pz?=
 =?us-ascii?Q?B1loyfWVgm3EdXwSSw3qIIxfshJHC3reayjvzDeWiXjTHe/j7SFhBsMIO229?=
 =?us-ascii?Q?Ac/Kd8zw/Mevz7JnLIi9IvbjbOnHSwPsQ+HAje4oFDwDmNfkC96lXAMjTn8O?=
 =?us-ascii?Q?IEOLXP9/9zX4beM9UmXtYAnV/BlWy40xw0tOVAPYpnWs0z8BJiwT9IxwiMKQ?=
 =?us-ascii?Q?NptBlMxBB+qDQqPItDTgjYk1/KPnKVgtXXCH8Hd4wMQ+9TAe01nguIjYEJVT?=
 =?us-ascii?Q?FaNsYxB2vx3DjfW2l/860bLQbyESVt8QuuOhFYnCFPWq2L/U5bz9Hq0e9XrN?=
 =?us-ascii?Q?K7zNgTwC0Aa2EGwe9oo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecg1QKLgJFFXT6mbn6+LMCgJBI8dycGNNcz4cihiuAX0Ewg4D1R/QkV77s4v?=
 =?us-ascii?Q?vgca+c15r7FcF8kTpEhAZzJ2woTj+jAb50aVMVwCpoz2dvLffhBa72rb93eM?=
 =?us-ascii?Q?id7nttq5huLwEE2B5g1VwCCFIIwtba2FcsdeoEuaFx5ouuZibKvknts6GPrk?=
 =?us-ascii?Q?jA+NfKNROxMp/gLEZEWpMPw2RGBDWFI8ZN02HCmSBBNm0uaX56kFbVsPsQKi?=
 =?us-ascii?Q?kJn9XrZ6X4RW9MhMA+ndpzPG7HcCLMY9U0QQZAIa+Zpdp0bMI6FwELjnitvu?=
 =?us-ascii?Q?OX6skB8seY2XURLd69hhwAWf5XlaWpd7uqDtvUbiB8HTYfDmg7MCTJVUpqYm?=
 =?us-ascii?Q?8Q5th3EMNEkDg6R3XUhe0mQaahZFakww/vJfbB+0kSSJZBEH8nf/aGsGjbfe?=
 =?us-ascii?Q?4EK58Cm1eLHhoGRJomtid+au4jKUf+q+NMRoFQvmRgY1zddMsEs7813D6ifX?=
 =?us-ascii?Q?uKbtZ0NB4yzaKLyF1QLvbABegNWLUg/iFAOxaKKwgDekTOB8Bf49ULM9VxAz?=
 =?us-ascii?Q?Gr8YAXUNZv0W2HOdzNFsHCmerHKWMkPX1vIH+kKhTpmCteZtlz4Y88K8Nqx/?=
 =?us-ascii?Q?wwlLkVydfV3ufhokZDzT3gE8S7E2degj4PSMC3J7vXsA/prWs0P57r8eBWMD?=
 =?us-ascii?Q?MafwLwyPT+8112NsfKsM0EUnc6r68eOBi365hXKlWr405IAABnG5c/poLeRA?=
 =?us-ascii?Q?A2kM2ig8f7SE2GxaNsOtH/IgOmLeAuqnHDp0GpRkt+roOCTPY+gpik8AYcf4?=
 =?us-ascii?Q?A2TCthfJUVDegOvZ0rvfH7nWsr4jx3k6HNBQ/mz1lNtAFS0HhX4AtAplRe6b?=
 =?us-ascii?Q?zwJLV/ejhCuHU0DMFsQIMqzwEFcdrMQeDWYCXAC28JhzsENrlFna3QoG9KQq?=
 =?us-ascii?Q?hrCeid445hqwF5G9qQdHPHnZ3OyLyWx8n1ECFAeLrh+BN7uq+VDQv+bb0ArB?=
 =?us-ascii?Q?eoW0NUsgckQDJv65AWhOhmXAMUrPfqg+QeNYyu7Q+3bYvR4jBSP5JTYtx5qn?=
 =?us-ascii?Q?lxHgUaYUAVUhZY1qnPRN4RrccX4I4WV4fzb0KPrOJkOLA/6zba4A4vgOi5j1?=
 =?us-ascii?Q?iIwPyhuA1NUdOTUUd4n3qIvPAdo6hrUU4tv63wMyj6mV80oWLXo8OwXfXKes?=
 =?us-ascii?Q?OpiQPK557zehRasCcW8mxj52L3klfuY9QFsxE/HWjk/SL7ro3HplzSUcr/kX?=
 =?us-ascii?Q?o8bYUo+tADJSohpz/bNit5TNWMOcysB+M6LG1lA+YMDfTSMW0pL/KBlLXaQu?=
 =?us-ascii?Q?SkjYbBgsd85FNgFNIHUc16G7Rmf5Ms5HfrYHKZds/Nc5laeRtE9a7Xk+8eXH?=
 =?us-ascii?Q?ug4l3qeSBpF8xtMRoO6gch9f8/Nd4nAYMshqy9xf7xknrsplo+9mc8LqrFr4?=
 =?us-ascii?Q?s8MePzTKZZn8BuTD4GD1shLWqnUe+CRo7ubGuqXiCTQdsW+k1PDyTqPTnngW?=
 =?us-ascii?Q?+ma/Wps26k1x/VPfJbCAnVwL2aTtVcwq2vA/0/x7jj4S4Qm4OL+8FlrRHrR5?=
 =?us-ascii?Q?aTPNVS6YVzPTjQbp9z7WHpaM3eBdxYpAJQ0n0ZG42as4P6HaVcD5il5XROUM?=
 =?us-ascii?Q?Rp6pbLaIQovzkyboF+VBq3YoEnYW+B0OYlW8V7ANoz0wTXAgBswzjMXref73?=
 =?us-ascii?Q?eSr1HjLQn14IdnfRNs6/pdjOJodCrCH37HkHb976Hg0gyAdtdkcpKcgWJA0R?=
 =?us-ascii?Q?agb39g21mfQ199NoEOkHx1tVymPFd79YmOfKve1xrkxWzYogdAxV3tg2EShi?=
 =?us-ascii?Q?vt7vTKLeFg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1d959-77e2-4a33-bc62-08de6801ea1a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:37:37.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9I/c9M2RmxdJiDIAPIfEXe30Y3P5lSy0ktViEiP7Np4X5ltfaiYniL8wetLcFHiTvHIAecb19c/uMwGkxEcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5700-lists,linux-edac=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tony.luck@intel.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B60C91131AD
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 12:51:42PM +0100, Borislav Petkov wrote:
> On Wed, Jan 14, 2026 at 02:50:34PM +0100, Borislav Petkov wrote:
> > On Tue, Jan 13, 2026 at 04:30:08PM -0800, Luck, Tony wrote:
> > > Seems to work (though you've deleted all the places where mce_need_notify
> > > is used, so you can also delete the declaration.
> > 
> > Right.
> > 
> > > I see time delta between logs reducing while I'm injecting errors.
> > > 
> > > When I pause injection for several minutes, and then restart I see the
> > > interval went back up again.
> > 
> > Thanks Tony, I'll play with this too and ponder over what would be the proper
> > fix which to take to stable too.
> 
> Hmm, so looking at this more while it is all peaceful and I can actually hear
> the thoughts in my head... :-)
> 
> The whole dance here on the MCE logging path:
> 
> mce_log -> ... mce_irq_work -> ... mce_work -> mce_gen_pool_process
> 
> can happen in between two mce_timer_fn() function firings - just think of
> the default timer running once every 5 mins.
> 
> So in-between those runs with 5 min timeout, errors can get logged and when
> mce_notify_irq() runs, it won't see either that the genpool is not empty
> - it will be empty - and mce_need_notify will be 0 too because we would've
> set and cleared it. 

The algorithm to halve the interval when errors are found, and double it
when they are not found was orginally for a "poll-only" configuration.
So there wasn't an option for an error to be logged between timer
invocations. This all dates back to before #MC was recoverable.

If the system is now running in some mixed mode of polling and
interrupts, then it is unclear what should be done in various
new cases.

> 
> So basically, the timer fires, we log errors without it noticing anything, and
> it won't halve.
> 
> The only way it would halve is if it manages to notice an error being
> in-flight to being logged and it fires right then and there. Then its interval
> would get halved.
> 
> And this sounds kinda weird and not what we want perhaps.
> 
> So fixing that would mean, we'd have to write down the fact that in-between
> two timer invocations, we have logged errors. Maybe a per-CPU counter
> somewhere which says "this CPU logged so many errors after the timer ran the
> last time".
> 
> The timer would fire, check that counter for != 0, and if so, decrease
> interval and clear it.
> 
> And it doesn't even have to be a counter - it suffices to be a single bit
> which gets set.
> 
> A scheme like that would solve this accurately I'd say.
> 
> But the real question actually is, do we really care?

I don't think we care. If we miss out halving the interval becuause an
error was logged between timer based polling, nothing really bad will
happen. The interval might get sorted out on the next interval.

> I mean, this thing went unnoticed for so long and frankly, people should run
> the CEC anyway which has a better MCE-has-been-logged stifling capability so
> that I wanna say, let's do the simplest thing and be done with it.
> 
> Or?
> 
> Do we care about some real use case here...?
> 

Unless someone has a real world case where something is going badly
wrong, then I don't think any changes are needed to cover this race.

-Tony

