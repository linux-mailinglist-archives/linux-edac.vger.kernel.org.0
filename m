Return-Path: <linux-edac+bounces-5582-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB97CD20F0
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 22:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B75300F590
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30192C235E;
	Fri, 19 Dec 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgXg4s6P"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB802652AF;
	Fri, 19 Dec 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181116; cv=fail; b=Xgq0Li/EqQ98tXvDANb9FgmWnZiA8dmht1Lse/sO6FSoZyGeYY71D7Tbz74ivn5CXbMk06QkIiAz1VgUKc/yoQd8VEf6ceZdnpw7O7jIbho1gZW+9xbSZx7zMwx36u6fzaxDR6VQYb6vkf6xDlpU5BMT7WHT3snW52ffb8ilCyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181116; c=relaxed/simple;
	bh=U/EwejnhmAHniTOY5G05fLd+ifdHXwkPQFmOq9kZyGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nW8hW6aTaCp3eOO/CdzlXhtSpYMlopJtPheMwmzvAnbGuuzZPKKzg7nYo8oEe5o4/ek6fQfiP4vBzdmfdVoM7JCuBlN2BBq7V9AFfcbHcNHcMZIHUBYXdnRNtN9oKFApCbYN7cH5EIH7wao6RSzkm0WxkpPJ5/cXreuAyHJUXkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgXg4s6P; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766181115; x=1797717115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U/EwejnhmAHniTOY5G05fLd+ifdHXwkPQFmOq9kZyGE=;
  b=LgXg4s6POX+iQ3SPJSx17TEWYeDZXPnsZldRI2bKHw+2tVwjfGBWaOVh
   IJ9AZYuV6gY1riDyJPNslv4ITW0TK2yMy2a5vGMtcAdbmEbcITVyT1+zy
   HPh4e0Yj23YSAN37q4KsknA9LJmHg7G1uEufTHHFTWq9f1kAD8qja7yd6
   2gUdg3py9QYhrsVwcP3OwyXFjFNooxw9531OP39kUV6iTZc27PpJvz34q
   KPQmUmLJcUkw8m/qjfRQC+C5QEhn0xkPI3CNRHsKxEhgpcdFUVx8oStj7
   ClwuiOMTnlkAE3YVI63u0eFxv1EzE9kzjG3TSGbIZ4dLWMCbEZ3jQOyRW
   g==;
X-CSE-ConnectionGUID: 4eOYiUAdT12IhSnes1If7A==
X-CSE-MsgGUID: q38i2V33S2KCFSjv7ltIFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68079673"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68079673"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:51:55 -0800
X-CSE-ConnectionGUID: CD3Th4Y6SzK6cNbdm+B7Bw==
X-CSE-MsgGUID: E2XBESZ8R/ChfN9xZ+zqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198116551"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:51:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 13:51:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 13:51:53 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 13:51:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf8mMzzkVy6C0++9wj4CVu1tB5JGSmxeTDzEA9UT11TigaTLcuGaD8REVrJudzjhxNBcgar5GyEgQCsI5TlMJEC0z6cDydwLIMB3MmMi2065e0s1fmCt36/KoMsvQCQzhJvfrodvgsYTNo1oICXYAa3YwjHz+j7vYfPlk055meTQIFIIgyFrFv+STqS0jrCZaCr9dYQQMCInF1Q/FMH1qh78Q9NyVwD2n1OXS2whd8BxEUC/0RHE3Ijzjwi+WAfyldLHmaDHY75F/wkEfNqCkEKhW65qO6ChnsKZn1ukacBiEuB8OCbVx6BA4+Xwv4pyv6LEdu/J9l7E5nsKdDDx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5nPBpdkhQ46qwx6Ss4KqGAi31iZnFHta9BqK8e1X6k=;
 b=qPcVJO7eP1zW8Htuqdnpu+HIvYOTkzMd5z3DUfG2W8NhRREXWLbk1ofe3m78wxMwzwvN2jHwH3Hr3YrX6wDPdTUdaHaFE9WN5BGenXyEucBKj8CBtsy/gIB3kTU0FSR17LqgNwcnAmAYmzgcsPfChKUnHDPh64Cd06OonmDpAh469fPN4fh/bki2az2cqWTxHXHnuupd2d+3Wi43Bjl4rE7LWwPrbWWohsgouur9iODiz7PkjrH74YWCCdUDh4wbCpfAuSqwcyzzbp9j5ixTjWQhGYLOE+EUqNcnWxXnNdKGjVJ42HUxNzHvI7fv8qfPLf4XlMJDKAd+l6AAktk+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 21:51:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 21:51:50 +0000
Date: Fri, 19 Dec 2025 13:51:49 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Lili Li <lili.li@intel.com>, Yi Lai
	<yi1.lai@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC/igen6: Add more Intel Panther Lake-H SoCs
 support
Message-ID: <aUXI9eBB9zavMjXd@agluck-desk3>
References: <20251124131537.3633983-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124131537.3633983-1-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: b0606453-f963-4373-cfb5-08de3f48d0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26JPMRGFQyU87R9Uf9Ic1GuW+VChVIdRrm4ubYw/CS5ldZ+uqLJdbH2x8mS8?=
 =?us-ascii?Q?ZKSva1MsiM5ZzpuB1kSjY1C5R3CGL1ZCo0usbnPiJeqRSP6mT7CcN4QhPGn4?=
 =?us-ascii?Q?g1c52nzmbTJnuQ4/AP8U1NXdgUmVxJo0jwuHnBOTwcd9XOpKdjFfTLWLFYTM?=
 =?us-ascii?Q?lXWSwKQ1TU53Hl97YFyxcgPjKas0ZtaQW7rQMedJVPLt1cOKHNoiNR/uEUBJ?=
 =?us-ascii?Q?37OEqjmgyJ6g+hIS0kEaeoEV5bgsDUrRbYB1+y1OWbnkJAF6ezdC2hdXdDFL?=
 =?us-ascii?Q?GmeWnb6qoXFBFC5LebwsuGjoz6xPboYMtKoFxDX7qWp8zVfM09OCwKlW2rOZ?=
 =?us-ascii?Q?Cu3I+/PyhrkaUw59WvkL/JdV546dRYY3ZuGf3NfOXSoUqhv56YdAm5WvN2cL?=
 =?us-ascii?Q?dEoiMlf37s3ZBIldTtq/RJuby/rwx5N3fsVunYb/qAtjgq3OBrCUBKFaUqo5?=
 =?us-ascii?Q?/sG9ex1xRWXHJzF4zkcMzp7t1qLbMoqnGl7SUcg/51yzi8y6RPMjcjYGPqaa?=
 =?us-ascii?Q?bfUBVsO3gxa3QAwvA+WfVOHA9HUBPk2yVqdP422YsqSZYhFC+wAk/GgDLTNn?=
 =?us-ascii?Q?gEGYd1vL1PGxJ+bM80ILHts/nAFH+zClNhxSoNIURxfglzeKbPw4v/icpJYP?=
 =?us-ascii?Q?FVf+0qqG/tqGyMmvjEhDpnOsKMyXSQ/CQ0omcRvH4DI8VEgiunrsvOh1da1v?=
 =?us-ascii?Q?TzJwVZ6LjeEVS9TCyUCnJj17nlgmb1+Dn+oqT1e+x48+uYQalD7nm+u7Shuu?=
 =?us-ascii?Q?t0q/eQi3v2pi1VrOfA3m9j3asCermMUdDByhPj4CBe0Vff+AK5JZpxBVgboe?=
 =?us-ascii?Q?rMwmIvZxv1YOZ0X4XCnsIehzFtzJcRu3kXJSHNusiI19OsAEoiKFttHJIRsz?=
 =?us-ascii?Q?TL9s7Qqp0Om2QbeXqFm3F+LIaX+ozMlySzVpvvFDfKrrVgNY2qgAY/guPmjz?=
 =?us-ascii?Q?g5NG7qCsuj42UINVuEioQ5jF9Mk07UURV+H9wPZWVfu/pJn2dojmVd0AZzyR?=
 =?us-ascii?Q?usHqDKAiHKFNieNMdOi/eFZqaifUa7Zl7CU6oJ9pCtXxO65BHuNpZwSshP3k?=
 =?us-ascii?Q?GI4+i31gqFtUALbtSF6s1i8EbKjjxeV8Z86QWi8+Vo682XgMwlXoCi+f5YzF?=
 =?us-ascii?Q?KTl6OWLVGjxaNP8M9jKivaPlK43xkD4HsS8oqIKReuJdrwwCANs8ZfV141uc?=
 =?us-ascii?Q?oBKfRUmEqWhoVJ/Bq5f1eyHqeaSvMlITDRwK4YgDBIF6lmYFq63D9dpiN/MN?=
 =?us-ascii?Q?yV+zOZpTg6VFT94edfU9AfDywzbFc1F4ZvSfYEo4NXtQSlUMLNvmCWe2Nz3b?=
 =?us-ascii?Q?X93tlYU9z76CSs/LfYL9tERJGnBNygN+bmx5d+70JoSNFiTrNVONccpdbQ+5?=
 =?us-ascii?Q?jfgNNuZlB24rYhYV2AyYHjrWA2ZZG5oxcHfgdh6N9NQFuPpWHE8zzGSYN51K?=
 =?us-ascii?Q?zTaapnmFavvxkrU54p3EwEwqDH8flbkT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BXQdjy7kIuJ8V+Vga1CoI8RlKnTdUQ8SwaV0tcFUVaDcS/CABTkixYleHszT?=
 =?us-ascii?Q?z4Ytle+tBNhgHi2HVXChWHy7+cI7d4r3I/MASaGYFWbrhXAHltrI0Mft9Fu+?=
 =?us-ascii?Q?LqcIBuO1oKQBQAnMp+4UxfFryO1kJNtnAu5+Y4kCUjfTczeyJrUZufyiNy9n?=
 =?us-ascii?Q?sv4OgZwprTBtGSBj3SWGfiES/wZ+cUzgfk7ZHdX9065GjMDEvHBzuRAqTfoy?=
 =?us-ascii?Q?PDsmWnJ+ZvmG7SIL6ozdN4xP2im7+0Ky3YOguAblPoUfg1TPmZg+m3EwSz5M?=
 =?us-ascii?Q?mGOw4oR/wTAslki0ql7sv9vqFG18f3DRQfPA33cikY0ZrTgAIw5OffiaFEO4?=
 =?us-ascii?Q?lCmf2NS9uEFF0/uYCa5n7/mK9mYMcmsU/7+Yg6NKUCDGA4kOKEyCjwoXPwL3?=
 =?us-ascii?Q?xry3iJ7pUpuBq2JdZsSjJOFvyd6DxGfBcI3La0yu0Emu2hRj6Dq2GVvAPw7p?=
 =?us-ascii?Q?QCCMA5Wa74N6aNUlwC/zBUZUqgdJDgUFqVdHJzqDdRH6VtyR0aEC3LGwb4A8?=
 =?us-ascii?Q?jE3ffF+bvEHQPG8hZA4WQCZ5iiRhrF7UnvmtxcJUri9tauelquSgWLNdq6KP?=
 =?us-ascii?Q?tUJwr30V75u5YQbl8PeTDz5E+npRxIiAUwZZJZL+4WKIv7CqJGBz2Hbhw4Gf?=
 =?us-ascii?Q?Kuz2mf9jgHUJG/NuhstHarU4cILxMTXVBKlPnxu2nrEqVaOinK9TGZNvUEBH?=
 =?us-ascii?Q?n0D8Fj+mT0k0EuQHYX2l4Ng4NTeN2zcdTLn7ttZjsYqOJVY0jLZV0CrOLR3O?=
 =?us-ascii?Q?A/Blvghds0X5eC5pKJgo3WdYoBOF0FXLzSYqJaoRABXejChgFx8Nlm7RlZGR?=
 =?us-ascii?Q?ZnajMdlDmAWo3sedOcdofR+QUzN5PbK8XKWwAkxSHOdVku6BVWbH28G4HR8l?=
 =?us-ascii?Q?/WdxD+lLvb9vLtPbqAoT8lZMzfXfkc9hQZF9S2p0JYHJukkPz3iZmFwZw671?=
 =?us-ascii?Q?ysyXv/Uf8izkklvJxu+9Nwl/iDO99sm7lNR2tT+rtfZLKOELvx/O/GZ5gyqt?=
 =?us-ascii?Q?XPts7sL+TFIQzsxu6TGU8XidSJJG6YTvRek3A0E990gZnmZF9jugq3flqs1D?=
 =?us-ascii?Q?3Sw+3/qpgPjc05VseISOAnjwSaN3CxqNLNMvUukkA4ZEShKrn/gpq7uZxI6B?=
 =?us-ascii?Q?BEHKcIlRjT8zCCszsGa5rqLO/b3GNWuiIe6kWIL+HxHLs4Q80tpfAF+NOlft?=
 =?us-ascii?Q?eoMW3iaoKdLa8Wi2VDl7QAbx7oVSWYzXqalrSaUEKZO4zA2RjohvE2cUEVGf?=
 =?us-ascii?Q?Vn8c744lKuqn5mjLYmqG7vtBvZoLEZh5u/kr5jxLlDKxwb9YIgdlH9ubAsvI?=
 =?us-ascii?Q?EIhqiyMFKNaGhVf1FLcVtwPRDG4DnfAiHGjaNbT4UbnbdJEGmLmhyuTtH4zX?=
 =?us-ascii?Q?58T9ZkstjKpPNn43ql3obtx6xobZ4xbgaoyN1wbLUvMWHg0eovDiVwFItEWo?=
 =?us-ascii?Q?ohXvIlNc0B5VfTVlqqXgj86vZaySdTSQgn7VEcJRRSfI+5pyugX4gQWNIDct?=
 =?us-ascii?Q?bUEvCWrrwe399rg9cCqHFozBwi6bm2/4UbAlvL3+AfmyCamHZ2ocBW9KL+Bs?=
 =?us-ascii?Q?ClRrHpdtb2ZGc8+yz0j8DgFVnYY7cGEZTnwaTlnpeIxvpfkRQgRHRjbn3em/?=
 =?us-ascii?Q?CfTSRInre8alvsHpFpRNZGPrvpxTRNC3Kk5ilukZkuzQdC6HVSmKLUXZ6WVQ?=
 =?us-ascii?Q?TdL47ZbX+Y7SZFIiw+m3eyEybgJSdnXkWWs6b6DQvzKZj9bEsmJDMtVHYF8c?=
 =?us-ascii?Q?i2FXMiMVIA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0606453-f963-4373-cfb5-08de3f48d0dc
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 21:51:50.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg+fwxrr2LchfytKYboYHl4yl88fph4rS/Qd2xVwMfPUrFzRLiCJ/h7e9fdYxmvHIjUBV7pq5vmO9Udnbtz3nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

On Mon, Nov 24, 2025 at 09:15:37PM +0800, Qiuxu Zhuo wrote:
> From: Lili Li <lili.li@intel.com>
> 
> Add more Intel Panther Lake-H SoC compute die IDs for EDAC support.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Lili Li <lili.li@intel.com>
> ---
>  drivers/edac/igen6_edac.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied. Thanks.

-Tony

