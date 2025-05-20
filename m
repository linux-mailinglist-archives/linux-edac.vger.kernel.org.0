Return-Path: <linux-edac+bounces-3947-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669EAABCC63
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6483A7CAD
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AF253F35;
	Tue, 20 May 2025 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIXuBbaJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E5AD4B;
	Tue, 20 May 2025 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704990; cv=fail; b=D/udoDCCY2ZrekBLBR2PsSzbrwIetC3CWOvZr5doWNQWH+bEmBigeIiSoJX5dD/x1qRek9fz7IZCrtHUAmCI33YWaUw91/VdoxVdAZw63zzBUsOaMLMEsBCkwrwmzvNjwcbFaKQQiZfPdUgFdPu45VOjAJY0p3T3t+GqCwiAOjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704990; c=relaxed/simple;
	bh=5Yu1YNVu1JnkEzlL8vq9pSKn8JtKi/NJRJpY2d5nfDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qAQSeGWzH1HJR8I2Or3ys+IRyMB+vWX/kPfwvVeX//Ky71IpwZbhyFxVcXJDMbYL7Who1nI6rCy+7nCLScbvICTjSDeYhmK+Nkp4EmHuY8MaR1uYPxC84xYH3KjIug1LJfVMNfQzx5hdNBt5luQJN5ni3xKfFTnI4SdJZL0741A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIXuBbaJ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747704989; x=1779240989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5Yu1YNVu1JnkEzlL8vq9pSKn8JtKi/NJRJpY2d5nfDU=;
  b=SIXuBbaJnGtRTM4dPeBoqAGHEwzBYojfvIqWbHXBXW8ShA+D1xTXFgRx
   eFDkuB5Tns7hy2UOwTSC2MBAqr6XyJHaFpvS+yUOTuFmXwdbv8aYeK5d9
   JWQ/P+FCA1ft9v987km3nnmTPMHaRXd3G5PbWwYt4REHcTPw6SLAY2tVU
   Bs+eT8VxboTv197u39JgHoMFCJh4EpDl1bhAzXqL5puNy8/k+tYQq0tCP
   c3Limdx52l9MLhspgzsCG3vct+hyiRTyozBnldRlaXcO3cESrXblxtNga
   iIjXXL0KpyVrqphEPL9Txjjd0CMcdetIdFgnOhbOxUwsLcxZNzFmjZpn7
   A==;
X-CSE-ConnectionGUID: wapzyJPlTbSVXqI96UxKPQ==
X-CSE-MsgGUID: WmU8umCdQWGxqFFkZTZPxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72132726"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72132726"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:36:28 -0700
X-CSE-ConnectionGUID: N/Z/NHLGRz+7RS9gWSClFw==
X-CSE-MsgGUID: aXIS/bWWSlOERmTzB5ndOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140548833"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:36:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 18:36:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 18:36:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 18:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNKm/8tQo0AaXJvArT8xoJCUBiFtFA/JxhEIuisMVzotHZDGjo9ZUiVlfazK89S7VPNsZKIWqvNkhLAHS7yCThibDJEkINCozOC8uCEwi5cyK8fFl4W4LBH+2dXP8YbUYQ8v/cKQHwJi1K8NB5kzKBjH3KVH88LyEdBWT+ETXdcUz/Okgywbz1KyMvjy8uRbef8EYJmL8MCG/q6J8uABvzE3ITpybcAybrNNskVwFMMehgaexW4dfvaLyQOIvPCdUmuaENDKE7zpjMzwCQvs9hPwzRucAXKrtRbYfWQibWn36/bT0RDi+wHyqNnK1WOnqrNSEBhHAn6Npc1QbWwyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS16BpIvL3boVhmUsyJpzc+EhP/XA0qtXRk41+39WiA=;
 b=Q37+1/OU4hhO4+Ps6o4lsjouW+iKLAwPMwRzevJK8qiE2tvf0WvtsNmKyDo6s5CfQmwXwUYqQX1a+INxhwLY+Djwcn/VqjjcbcmRKg8jPOfaUpPX6LZlEtBsakt4caEVYIHYyHh9IJYT1ne6mGs4C96i4xS+lJX+Hb41GdyrHf3ZDn+ox+QPVtZ5yH3xZqhA/1w19kMRkMmL0rwvB0XIDO0Wx3m6pry/NJh1yB/KfUgTKlj2TFa7KSBw4yk4k5iN+w70Apigb7aYlf36e8vCDVjyCAHfde53enfyqm9oTJeLH5X3IoXlnnCZYfRYerSApzQUe+FZTZtP111Kss/N6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 01:36:09 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 01:36:09 +0000
Date: Mon, 19 May 2025 18:36:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v5 0/8] cxl: support CXL memory RAS features
Message-ID: <aCvcgUv03XUWtYKS@aschofie-mobl2.lan>
References: <20250515115927.772-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515115927.772-1-shiju.jose@huawei.com>
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|BL4PR11MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: f4681158-4840-4607-25c6-08dd973eb248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQl4XgqihnwQ+9BHkYGjrHN5x/VvjleaeBxFQcJpqYVeUm26y8YNRoeE6GaY?=
 =?us-ascii?Q?RbKdZdhz0ZSjnP8pdoAYF9oyNW+GdDR2EKNN4SDHiTo//gMisW8dNF8yZXiR?=
 =?us-ascii?Q?hKVIUgRAdpGtnFopkLfv0IbvHdvy0UAIHXNVcfXuVEUbbpfk/YRU8XxsXVJE?=
 =?us-ascii?Q?5/4CgRrV9CbAHLmAtdAbj51NcwktUFJsuokBknT6qpNnAI5lHUd5T3s7hFIB?=
 =?us-ascii?Q?CQ4fShGCY25NDMn92QQyrI5hvZL79uSf2Wqqio2qwdBsWgEdc+5kDt9qm1Uh?=
 =?us-ascii?Q?7s+pooDfLnCzGUAodPJF5t4RG4nGAOU5JCWn1hs9QrTkRybMRWGW9SaEIKN4?=
 =?us-ascii?Q?x5G909JTAeRbhLgiba48yXb6teGkLd6A+Jtwds3HiTLthzpLl/YTw9GnAIYW?=
 =?us-ascii?Q?Usfw7ZWHydWFi+Q5kFCic3UwadHy6PdGCsE1qLNt/Xi9EqGwjTlSKK2ZGTb1?=
 =?us-ascii?Q?2FiqMOAFojC0c806OdKn4WSgQi56EPxbU4zgF1hQjg5SZlq1xWKSbYdoKssP?=
 =?us-ascii?Q?7W6VdqZNNsb94JS87FKLnJgNjY44Roxisn7HvU09uArIeGgI1URWQ3q3aP4d?=
 =?us-ascii?Q?oRv2w8q+HkV+ioBMDPBcTnmNZ2g/KUo3W23v8VcDr7iO1MoxHvXmV6lSqBHW?=
 =?us-ascii?Q?TWT1XiUKxYqbrHQlHX60l12t9QxgR/YSfi6p2v/XT/Q7EYbWq/lQshX13n0c?=
 =?us-ascii?Q?P3fWtK/yHQYShYQvE8bClTS1SIC2gbW3W7ploWZsU9kSBWHsp2jGT/oB2bDO?=
 =?us-ascii?Q?UoE1nWlUuF8Qjf6aUNq/JjP6OKT0QNil1C8iv1UHUocFdTFNNS8n91OIYRwe?=
 =?us-ascii?Q?ZiRtNg1z3grRp/c/LP7ic8+rlv3C+i2yqqUjTGfGpKUHheYWFXaw+0yjbIbk?=
 =?us-ascii?Q?//YDb3XdvdqABDfyyK3eEvK2VOYgK12YHf2cW2wsvG6VRPelC/KufrcVvK3H?=
 =?us-ascii?Q?JLBviqPVFuGYTnM8pll0R2YGkK4XbQTB1Z9mlN7WEbFMLysfey5inyUZJZ12?=
 =?us-ascii?Q?o1ZRmxAP3yL5YhDIl/8z7LNPjuD11xyMZ1iV+6da8vsIt2nvfqQkVwxG2PvS?=
 =?us-ascii?Q?1j5VHRScG5ENYSYVe/5gCKq3GReH+W8ZXf8adHWlFkIJr0/7YH9qBbShtdsn?=
 =?us-ascii?Q?ptjZKxhhxAsFqwVGLejtB5mnqOsyoUulvntUuE+jQJqxc+Ow2bXjyCfUiOrO?=
 =?us-ascii?Q?WLeN6kOPL1O63M5fRnMBgy/ZdaG6HgGyOOjAXmxTxF/i04VQSQV9tYpR9HVw?=
 =?us-ascii?Q?WMpv7wSY551i2e8cP1cueWZghl/Al0h329plk5X7je8HF3fHU7CFnuyqq+gY?=
 =?us-ascii?Q?rivNb+AcwFQCrIWSUMBRXVDXqMohjCdYF8l1Gi6mwaM//ShLVLI/7G92LoC2?=
 =?us-ascii?Q?NtMSxLYEAFsLcP4NLVCO/fy+PJqrpcvGBlEB/rOI/bFxPU3rkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vyla08Qn7uld1CDb70tWAFXoTtp1g0E7qYr1Y18nJQbfkeJd6FUNJQUVtlpz?=
 =?us-ascii?Q?oNPCg1zpL2StqKd3E44zsldWKIlI7kOI4UZFjYQ0QHnFm5n6sTyYIshu/Asc?=
 =?us-ascii?Q?DG2Iq3yYl/TwEESNT3Hd87bBsKw6O23tuGtPlcVRIJt5G9Fp/4rpJOy98Zsb?=
 =?us-ascii?Q?aTXgjM2twC2xIJgkr0RanWT7H5WdBDLIODRnVoynLLRx3al57A50dbmPexnc?=
 =?us-ascii?Q?ZHTbqwiof0W4YMvsCBrfoQKAv587eNfw8TGvIkell1ZxM+s7WTcS8jf59D4b?=
 =?us-ascii?Q?UY6OVUgMr6i8fh7TZ+DyfSFQQQSxTrZUWxB7dHhsHP4x4YwrUN2ZYwchjywm?=
 =?us-ascii?Q?A9BHQU16oBjNX9gSvoRKUSvy2ULD+1aCL2qP0WtSdi0UCAfp9dlOhU/3ZIEf?=
 =?us-ascii?Q?dP2XMsuekNy5Yl4/c7WJDdqw7iXoJ2atL5py1jp0pvEY3QQBj1Svyj0acgx1?=
 =?us-ascii?Q?yceBUKEqw0+/Sm/Lyh24xJZMedDblSMVo2ftm58r4nlfDnMWo96m35h0gZne?=
 =?us-ascii?Q?+VtXFLrSAQAfEjhnfbtHQGjMr65MVPM4FlrOw9poKVllA5w8kwbs/VW52wmd?=
 =?us-ascii?Q?rclt4Sqc+HF8l1fRG4QyG3kL+rQ53byYUf8gPpc0CVEZc+guFH0onNb95bkb?=
 =?us-ascii?Q?5WMzCitssBkO2o4Fn9g27yzSQTG6NJBV/QoSg6LUfoRO8JqHdw2F1bMsAYS5?=
 =?us-ascii?Q?t0LcOaVaGXiobR4QQd2fCExGqeHQnExh5arWL4XFPhhOGGPIyjedZLWf8Hve?=
 =?us-ascii?Q?jbOG2B+kJJO4U9L5b2CwhCMwPZcL0AfmGTgadzjM7x5I0inNx/yxi57NXFZZ?=
 =?us-ascii?Q?oNUqmOEjQWirMjjcYmbvKJO909RIzHMU36nlbRJOtQavdfbyku3NHdN0BX9j?=
 =?us-ascii?Q?nHERJNBCgcfetzTHp8A2BWbb1eynsf9wOzBkfDWKqKSsyFWeilSGB7I+7Fv3?=
 =?us-ascii?Q?WLdAGCZ+TWNd3NnxBrQkfEVQr0hEeH0Xn4S5QVaIyhltUWfFkYAAjAK5f6Uf?=
 =?us-ascii?Q?0WPyUtf419yrugW7RMFjBNfuFNnj0BlzllOudcvpMitJtUJir+5f2tSpvQ+2?=
 =?us-ascii?Q?xTuU4XifYqVQ872JXlS68/aedQPmOFtrgW/weZVHaEQWcxN7beDOQeaBpBz0?=
 =?us-ascii?Q?zkcu78WHKCQxcta8s+VyMF72TJxmlM2RERPvi+zMOLYM60kpRxnMkwvdm9s5?=
 =?us-ascii?Q?iGSDh+JzWqboLLR309GXccIZ32x2OTf+Y9pUwYbL85vtgJBYWZLl7vWksTm3?=
 =?us-ascii?Q?noUCgrwyOZ3JnV6pB9ikQIOUtq1zy4r0dT7OcambMVoVkLAdPjimlDZFsXzH?=
 =?us-ascii?Q?GiSxjcBGhomIrq5s9twGF5ZV/0FXll1wuu7DY8CJ53NRCmbuwQUdPNyPELOE?=
 =?us-ascii?Q?uuNNB6cuhgrgZHLEljjHMrj5VQs0J5V2A3YdRb1o2xa3riz6gzMPyryirI4Q?=
 =?us-ascii?Q?pxIFJ0VCISVHJTr2jRFCRm1pArPWSPrKe8yv2s/uz7+Lfq1p1Ka/iUic/NzG?=
 =?us-ascii?Q?7bC4xBZhWnfxDsMUMm+h9fULyD3aeOdSoSvszmGx6vvLhitLMTdP5kW0C7z0?=
 =?us-ascii?Q?k1qKG7thM2xtfgYRjb26rrZ3N0Xinw7M4z1kBwsWSgI1Seg0Ltl7lxewWCJQ?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4681158-4840-4607-25c6-08dd973eb248
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 01:36:09.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJKFVAN/9DzLuBGraJK1UIW0THDNIcL8GEYToenPG68FPBQ6RWOIlpL7yH+7GS6ur2r0vHzu4CPEk8Wn4E6dwkV6f7F27Fm+XYn3fSlgdvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8797
X-OriginatorOrg: intel.com

On Thu, May 15, 2025 at 12:59:16PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
> memory sparing.

snip

> 
> Shiju Jose (8):
>   EDAC: Update documentation for the CXL memory patrol scrub control
>     feature
>   cxl: Update prototype of function get_support_feature_info()
>   cxl/edac: Add CXL memory device patrol scrub control feature
>   cxl/edac: Add CXL memory device ECS control feature
>   cxl/edac: Add support for PERFORM_MAINTENANCE command
>   cxl/edac: Support for finding memory operation attributes from the
>     current boot
>   cxl/edac: Add CXL memory device memory sparing control feature
>   cxl/edac: Add CXL memory device soft PPR control feature
> 
>  Documentation/edac/memory_repair.rst |   31 +
>  Documentation/edac/scrub.rst         |   76 +
>  drivers/cxl/Kconfig                  |   71 +
>  drivers/cxl/core/Makefile            |    1 +
>  drivers/cxl/core/core.h              |    2 +
>  drivers/cxl/core/edac.c              | 2082 ++++++++++++++++++++++++++

Hi Shiju, 

The file edac.c contains a scattering of ifdef's that can be replaced
with the IS_ENABLED() mechanism.

This issue touches many patches, looks like patches 3-7 all added to edac.c.

See Documentation/process/coding-style.rst  "Conditional Compilation".
You'll find a few usage example in drivers/cxl/ and of course many more
all over the kernel.

Conversely, in cxlmem.h, the patch uses IS_ENABLED() where an #ifdef
is perfectly fine and expected. See the surrounding ifdef's in cxlmem.h

I'm aware it's not a simple search and replace operation to rework this
but it is worth doing now to make the code more readable forever, and
there's also the benefit of allowing the compiler to check code inside
the block for correctness.

-- Alison

>  drivers/cxl/core/features.c          |   17 +-
>  drivers/cxl/core/mbox.c              |   11 +-
>  drivers/cxl/core/memdev.c            |    1 +
>  drivers/cxl/core/region.c            |   10 +
>  drivers/cxl/cxl.h                    |   10 +
>  drivers/cxl/cxlmem.h                 |   36 +
>  drivers/cxl/mem.c                    |    4 +
>  drivers/edac/mem_repair.c            |    9 +
>  include/linux/edac.h                 |    7 +
>  15 files changed, 2356 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/cxl/core/edac.c
> 
> -- 
> 2.43.0
> 

