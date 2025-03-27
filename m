Return-Path: <linux-edac+bounces-3410-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3619A73CA6
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B22117946F
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397C218EA1;
	Thu, 27 Mar 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOITSpor"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805131A3150;
	Thu, 27 Mar 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097457; cv=fail; b=r76//vt2f+NOgfybveSoRCoJw+Otumk47pptqN2NXTkwO8e+uEQ5rzS4RNJNRhFQDnJsqAsodyVFr+/wcuDAYRQE7UmPJWfjAQ+5M/Ux+78zP+00ZTHaTyUce5ZLtSs6Yd8wDB5GWutxqWB4wI3EaA5w1JJsS1I2CTRh12TkjcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097457; c=relaxed/simple;
	bh=fUi0MQwvuJ1TyoKkkdLxeLBvUHxagLlGWkwRSxRxxio=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f1zSxeIviFi73MEU2PCbzmQp1dv4d65yHGYTpFeyBONfjM5K2WOqGG3WtrKizKRx/HMnPB12948RNY/j58ijZ9rJgXZWsFKFjiOhmp84tSq3o3cSqgJNmJZLs9L8aG4DGNhrFkHfTHgrxBFkc7od+4Qk8GUm3G/lEwOqC6ChGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOITSpor; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743097456; x=1774633456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fUi0MQwvuJ1TyoKkkdLxeLBvUHxagLlGWkwRSxRxxio=;
  b=fOITSpor3ajeIPj/SXGEJFofwFrcfGq9fPLQHVZ8cjeVX+bkiCkxY2v5
   XmNFWiBHNnyrCSZnstu71BhOi/Q3FS1uLKObiG08PBwlH3QoRqcWBP9RV
   0xn9hPKUX0r7Gc+AceWc/L2NnJYVUY5tnR0WR4mhLV+LbDJHJgCCSnuM1
   1GVnBjFWzr5xcTZae+wnwJJx/6rY/fHtwnxEU3bPF9jCghBxZPGzALViu
   cqdP/zEysI8/c2IN5mG0+ceKB7SrfpTZRu1U3GJZVlJZUt+dHzZX064Y0
   fRmSn0LP4/PQOS3B/imr4lmQj7w0Y8zlI6ZCwdfJMWK+KV6QOos5heqUj
   g==;
X-CSE-ConnectionGUID: OpMwsiArQCeic8mZXN70Ng==
X-CSE-MsgGUID: lU0B/8g2SfCMlimuh29VyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44632853"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="44632853"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:44:14 -0700
X-CSE-ConnectionGUID: x+OF8TPmThmJrz5bBGuQeg==
X-CSE-MsgGUID: Y+gdthUeTh64OiIzGFui4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125722876"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:44:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 10:44:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 10:44:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 10:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seNMQKe3rg5lt/HJEjMOgZbDYp665r+JKkSScxPysdPe+J2+eO9OgxLn+SWDsdkuWH3H4XrJ/gaQPYaZ4FvGujFXGFx4G2uBZWnfxs+ginP7ZB542iCveG/oedRmVnGyZrqTKFHIdO4oGUXuD4z35MojzY/0VyBiyW7V2uVXzQ33XTDgvT37GM5vRG1IeqdV1268PKozVn3uWVEs3Uu0s97sKpLnboYg8C2K0k/ilpDAsTzF+aQ8HRhdzHgmMynq0ZJpvK+PdpPWSefOI/YUd/dkmlqclzWq+k6Pa/G7PUny3Gv5D0DK7zh88MzvktKOdnOjTkhcd+46BQExNo+5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeH3TkVFJRG3/vjwY/jqA1PskvMmyW/RZmhtaYedpgs=;
 b=t6VvnNbNyMaagYsVDo+4pYz0Bzu5IMAknVRG+N3w8CuieAR/TnoaUEFzSfsjtka+F4uzF9uHsaWCwLNXRE49Jf6gFFsOS2kl22FNozxgTI3nTmPgtYPf1BUPTIYsGJNSCLmRxJJOISSK8XiOpbXpcwJ5Z5N6BCwFq/m04PGspVkzpDIeB6xuW3yMlx8jp6h1qSyF2wvWrhVtG2jXL1QCsLVE5u8qOR0lx2eWhxtantDkO0mHbKrktBjTnTdj0WwiMCCJmS8vT1GjB3GaSfWmBvh98ibyOROwtUpExE91o/g4QAGpvf6tjW+OF+WE8Ib7ZMfVhiuPLpEAwMMOtmJR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:44:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:44:07 +0000
Date: Thu, 27 Mar 2025 13:43:58 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v2 6/8] cxl: Support for finding memory operation
 attributes from the current boot
Message-ID: <67e58e5eda9d8_13cb294a4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-7-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320180450.539-7-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a7a3a0-6102-47c9-ca92-08dd6d56f95c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OGvxbd7YFjDJL2HR0womq/SLJUgh12bojbMB8Iu/DUtCSXNssm5aaPL0oDin?=
 =?us-ascii?Q?GM3HMDIiGEozR37EmLwBvlkLb7TTplQaQw36zvNM3BQ2hm5DGg8RWiiy6YzJ?=
 =?us-ascii?Q?VOG54JkOoz3zllUZSawIt6cBSdIMj57OD0KRueX3tDJuOEB72oJrT9sAvxJ0?=
 =?us-ascii?Q?B3+bgB9ncvOMzlXFGVrWFu56g4DuDBvmm3qOaLcZqX3AIZrSrlw2G8YswxWX?=
 =?us-ascii?Q?DVOMIuobKti1ZG9ZmjArrrrfO22nk9/2QWcJ91UlWHz4SqnzZiQhzXwm/9qB?=
 =?us-ascii?Q?DFdkD4qDo0FxZdALUIxiodB/iC1NlMkodVLeUaO1vVqYbjwWCr9BrnV2LFHa?=
 =?us-ascii?Q?Wtt2AzvAwO3G/I5jt5ynwZtuvZn2sk0UKL4i9UZERoitHd7tnmfSLCHCE9FA?=
 =?us-ascii?Q?qb2MXP8n4NfzUcgwCrybJnzElDMQq3lXk3V4ECICG2tN4ZqRaHRfUIdt93QS?=
 =?us-ascii?Q?1lZzSARhqYhVMVF3MYzrjhck1M54b5vzecViBu8QiA9qoqD7MY3hpSUKk8a5?=
 =?us-ascii?Q?VTFEdMcXhL0pYDsJnFVyNOFXY0s5KyOKcABG+tF6ECeJKrKRS8T7Lxc+73iB?=
 =?us-ascii?Q?t9YBxPCbrl34uukpAiuzbxOUHUJJyQ5tnshp+I6lgypgrtoKEc5lQ5KDnmZc?=
 =?us-ascii?Q?m3xS0OMEHx7DTeYrNbptiGr5wEv/bXxPKwDHo4LUAkW3JVXU+xlyJBRd7TL7?=
 =?us-ascii?Q?YGfOVU5xSj6Qzic0cu+fFywFPjr/MHfOL9ViNLNofZCJuJLKB1TWzPOfv1e2?=
 =?us-ascii?Q?kG5Xc4tHt7cIuFKGroRQd7mAPQnaPquQvSZyB0pOuTsZ5uUl4MgYRIDNOuFm?=
 =?us-ascii?Q?A4hkPA73MhAs1daaCsEuhRXLzT4HgGnNNvWR0t71sokD0aDUv6dCmObHJGmp?=
 =?us-ascii?Q?tfTIKZZn5BBgN87rk/4jeEfep/yL4eNzNYIsXZ5pMsCW/jg6OAwdC8bS3lBz?=
 =?us-ascii?Q?ubc8xrAmq7a00KDj9A6W48lk6F+sOO9Lm+F1dUPz99vtxZw2iehiriYjNOqp?=
 =?us-ascii?Q?uLWbzbyMO345r2Qiq68hUY5ckMdDhOAGyYj938sYgoXzB+oVhE5SFBCS5O2m?=
 =?us-ascii?Q?ug/gjzthfE3ZQZwGISNGWYkfuoK05m85tX0wK4aL9fhbsz3thsXk+KaZ/un7?=
 =?us-ascii?Q?IFldDatFohYcOU4jnrDIaXrtH6AuRZ4e0JT6HGW08R8/3hGF283IUygqw0bP?=
 =?us-ascii?Q?FVkpFlMTZ9JZW9PPr78jpXwIqzIJ6jaLHVpHE04wO9PgGvFeAVWTqQ4fTZTL?=
 =?us-ascii?Q?UCs/sJNlz+Wx7Hd6BJgBqs1V8l0UwoDFZbkMMmyD6zKegCMfUUmYu/9EyLPU?=
 =?us-ascii?Q?KcyMy0sMm8qxMWTUm51jYPepMkYGEOEexUt9tvSeXlVx+p24GHhtL0hTV0vG?=
 =?us-ascii?Q?ZwUOfrNiZXdqWCw7npk92Xn7Jg+eGSlpCUHYslFML4k8eVa/WbdY648POJ8H?=
 =?us-ascii?Q?F310M1FAAr2Niz1O6vCcO0CwHQAjt/papLX4GYBEh5DXMG+w+YrNew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OUgplYDZD/vM17FFKTtPP4ic78yWTAgeX/7sJcdPPQcYneV3bK4bM+4milA3?=
 =?us-ascii?Q?UChbNMCh2Uz4wxiqLR/mpTplSPeZfCjO2Cmi5gIg24mhSWpDB0QbtfrMCCx5?=
 =?us-ascii?Q?HTiluxwNG9i66QxRW09i6/U3dJtzIzxl1bDba+4KKZM1m142PGukoNz/aadE?=
 =?us-ascii?Q?RyOPQ4aF/fsF6B1GcwJHFfh6mlriFglRQWcKQ3t1Pvym56NEMC9+RTcenxwD?=
 =?us-ascii?Q?DA+3vTyF++9ihH6UBLbQLK3ZVtkTKLPSFRtG4v3uI2uhfo7goChDGpMouFRZ?=
 =?us-ascii?Q?Rj+LjSD9dUmeOaBU/36B74nBmFYsBapuWXA9m3/Sv38ZEe6wpjlIUxgaw5Ee?=
 =?us-ascii?Q?GmfTGsE+Z9EuONNdbm4UT0iFzRFBpfiXwHC8C33BbJRhwnV9NGKRkOjW/z6v?=
 =?us-ascii?Q?AwZG/r+M8G7cU7gTeig5NFcAQgfONe1eU7uPkad7eCDxqUjTq8BkR69iDQu3?=
 =?us-ascii?Q?ZvoUFEo1CvabyqH/wQEkfhHQQ+E/gjnELJ91HNnVd+y4hTb7Kk9kVoXa6EHM?=
 =?us-ascii?Q?mkHU3KHg1GK/TQBzWUzzhxea2nHqyRFxlFPNb0SMS1QLAJCq8nnrbXPFNT/+?=
 =?us-ascii?Q?WHriJbwVdfNdwWVD95KX0dWYLxghMb7kjRzl4iV8prCznFyLw0rA1kChlnqR?=
 =?us-ascii?Q?NaRuCg06UG6DfXpuiHmWYC9BbxhCthu90obXlxU2Putei7FTn79Yi2ZjK5dr?=
 =?us-ascii?Q?1dUR8gnZcX/Gq0mtVkVKghxCGtNW5N2dwwisik+9fp5htaPNqpCMIpAF8yFt?=
 =?us-ascii?Q?EDmgEodec2dyKLk4tdVJOxy1ASl9QPSuajYu7aWhBnv/T/AGZ3zcaOtmbd7T?=
 =?us-ascii?Q?DpRf9w9Q3qHcv6u/+mn9ho/uTPl1TRMSjTBfTLV7YCVimYRCTF5foLtGrukS?=
 =?us-ascii?Q?M7RXDjcPA4P6Qso0429DKfiUsHzaKbS4p4bXkmFoUsZjnE3GJH82l+cTGiB4?=
 =?us-ascii?Q?Jp6eYn4rsGIOf5mFLsBbSu8gygLqhmdN0wKuNsLMt6qIHFpUxQ+tbsEagejp?=
 =?us-ascii?Q?sTE8BcuA2IMoqQkPF7iOMjZSWu7wDH0r73WUVi02Tnx08asiPENj6Q1ZRQtH?=
 =?us-ascii?Q?pnt1nokZckhS7Ha5oYNat+65bKxSFbQrBwF0+YtSOW+XsPWcbtMHFIZ4Cyz+?=
 =?us-ascii?Q?4MlNUs/mbjDpn9PF4xgVNGQE88vU6R3FcWqOXQedpnPH97YXxa1x2HFej251?=
 =?us-ascii?Q?njWjZedDVdzrU0pWEXrhuyhmuG7S/z3dcwhjSbtc4x+siJ0572bVvKNYwqoe?=
 =?us-ascii?Q?ZEZpwLwiwU57BmhXW+jLtVVvVDJkOTqOHSybxpoPB7gzwI5nX18s+JygCKfx?=
 =?us-ascii?Q?IfCQ2ZCJt5recG9b7gbfcVAATJXS7Kim6SzYRgGEdzBxTgb1Ze1Epnq0OG0R?=
 =?us-ascii?Q?9on3mIx6Y4ByBZPSgugkxUhapw+To0LIuWPy136wNXW2hRsRhL5EhVFyC4cS?=
 =?us-ascii?Q?LUOPaUGKHWsrjC9mQGbO2X7HwgYF2+24eL9AuTLO6U7lir3mMGX8lrOPbIjb?=
 =?us-ascii?Q?Wb6YUP+S9ZtAMVS6oCmYSWc+xPUocT80j0/g//NvyBle4prtDm+pcSg1Fkoh?=
 =?us-ascii?Q?qKSnbV8JTuI6dqdv7tjp3gC2RN0vg1btugh1dlffbMMqrZd7B6XdHu+zZgGS?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a7a3a0-6102-47c9-ca92-08dd6d56f95c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:44:07.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d51a1anETCHR9QZjmBdXxHguL9dAay9AhQONhb69nEP2MrVALjinzmRP1QM8yb5h4qDA+/00a9CjSWZwHO3P/VAu5OeWzHhL68OmThIFyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Certain operations on memory, such as memory repair, are permitted
> only when the address and other attributes for the operation are
> from the current boot. This is determined by checking whether the
> memory attributes for the operation match those in the CXL gen_media
> or CXL DRAM memory event records reported during the current boot.
> 
> The CXL event records must be backed up because they are cleared
> in the hardware after being processed by the kernel.
> 
> Support is added for storing CXL gen_media or CXL DRAM memory event
> records in xarrays. Additionally, helper functions are implemented
> to find a matching record in the xarray storage based on the memory
> attributes and repair type.
> 
> Add validity check, when matching attributes for sparing, using
> the validity flag in the DRAM event record, to ensure that all
> required attributes for a requested repair operation are valid and
> set.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c   |  11 ++-
>  drivers/cxl/core/memdev.c |   9 +++
>  drivers/cxl/core/ras.c    | 145 ++++++++++++++++++++++++++++++++++++++

I thought we agreed to call the file edac.c since "ras" concepts are
spread throughout the driver?

>  drivers/cxl/cxlmem.h      |  46 ++++++++++++
>  drivers/cxl/pci.c         |   3 +
>  5 files changed, 212 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 19d46a284650..c9328f1b6464 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -956,12 +956,19 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  				hpa_alias = hpa - cache_size;
>  		}
>  
> -		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
> +			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
> +				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
> +

All of this should be turned off when there is no EDAC consumer.

I don't see anything that triggers releasing the cache when a repair
makes continuing to save the information irrelevant.

I don't see any safety with respect to error storms and burning
unlimited memory in this cache.

The cache is storing 100% of the event record which seems wasteful if
100% of the data is not needed for validating repair operations.

The memory overhead expense of this feature needs to be estimated and
documented in the Kconfig so that distros can make a reasonable decision
about turning this on.

>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						hpa_alias, &evt->gen_media);
> -		else if (event_type == CXL_CPER_EVENT_DRAM)
> +		} else if (event_type == CXL_CPER_EVENT_DRAM) {
> +			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
> +				dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
> +
>  			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
>  				       &evt->dram);
> +		}
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a16a5886d40a..bd9ba50bc01e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -25,8 +25,17 @@ static DEFINE_IDA(cxl_memdev_ida);
>  static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_event_gen_media *rec_gen_media;
> +	struct cxl_event_dram *rec_dram;
> +	unsigned long index;
>  
>  	ida_free(&cxl_memdev_ida, cxlmd->id);
> +	xa_for_each(&cxlmd->rec_dram, index, rec_dram)
> +		kfree(rec_dram);
> +	xa_destroy(&cxlmd->rec_dram);
> +	xa_for_each(&cxlmd->rec_gen_media, index, rec_gen_media)
> +		kfree(rec_gen_media);
> +	xa_destroy(&cxlmd->rec_gen_media);
>  	kfree(cxlmd);
>  }
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..c703d4e7e05b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -7,6 +7,151 @@
>  #include <cxlmem.h>
>  #include "trace.h"
>  
> +struct cxl_event_gen_media *
> +cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> +		       struct cxl_mem_repair_attrbs *attrbs)
> +{
> +	struct cxl_event_gen_media *rec;
> +
> +	rec = xa_load(&cxlmd->rec_gen_media, attrbs->dpa);
> +	if (!rec)
> +		return NULL;
> +
> +	if (attrbs->repair_type == CXL_PPR)
> +		return rec;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_rec_gen_media, "CXL");
> +
> +struct cxl_event_dram *cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> +					 struct cxl_mem_repair_attrbs *attrbs)
> +{
> +	struct cxl_event_dram *rec;
> +	u16 validity_flags;
> +
> +	rec = xa_load(&cxlmd->rec_dram, attrbs->dpa);
> +	if (!rec)
> +		return NULL;
> +
> +	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> +	if (!(validity_flags & CXL_DER_VALID_CHANNEL) ||
> +	    !(validity_flags & CXL_DER_VALID_RANK))
> +		return NULL;
> +
> +	switch (attrbs->repair_type) {
> +	case CXL_PPR:
> +		if (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
> +		    get_unaligned_le24(rec->nibble_mask) == attrbs->nibble_mask)
> +			return rec;
> +		break;
> +	case CXL_CACHELINE_SPARING:
> +		if (!(validity_flags & CXL_DER_VALID_BANK_GROUP) ||
> +		    !(validity_flags & CXL_DER_VALID_BANK) ||
> +		    !(validity_flags & CXL_DER_VALID_ROW) ||
> +		    !(validity_flags & CXL_DER_VALID_COLUMN))
> +			return NULL;
> +
> +		if (rec->media_hdr.channel == attrbs->channel &&
> +		    rec->media_hdr.rank == attrbs->rank &&
> +		    rec->bank_group == attrbs->bank_group &&
> +		    rec->bank == attrbs->bank &&
> +		    get_unaligned_le24(rec->row) == attrbs->row &&
> +		    get_unaligned_le16(rec->column) == attrbs->column &&
> +		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
> +		     get_unaligned_le24(rec->nibble_mask) ==
> +			     attrbs->nibble_mask) &&
> +		    (!(validity_flags & CXL_DER_VALID_SUB_CHANNEL) ||
> +		     rec->sub_channel == attrbs->sub_channel))
> +			return rec;
> +		break;
> +	case CXL_ROW_SPARING:
> +		if (!(validity_flags & CXL_DER_VALID_BANK_GROUP) ||
> +		    !(validity_flags & CXL_DER_VALID_BANK) ||
> +		    !(validity_flags & CXL_DER_VALID_ROW))
> +			return NULL;
> +
> +		if (rec->media_hdr.channel == attrbs->channel &&
> +		    rec->media_hdr.rank == attrbs->rank &&
> +		    rec->bank_group == attrbs->bank_group &&
> +		    rec->bank == attrbs->bank &&
> +		    get_unaligned_le24(rec->row) == attrbs->row &&
> +		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
> +		     get_unaligned_le24(rec->nibble_mask) ==
> +			     attrbs->nibble_mask))
> +			return rec;
> +		break;
> +	case CXL_BANK_SPARING:
> +		if (!(validity_flags & CXL_DER_VALID_BANK_GROUP) ||
> +		    !(validity_flags & CXL_DER_VALID_BANK))
> +			return NULL;
> +
> +		if (rec->media_hdr.channel == attrbs->channel &&
> +		    rec->media_hdr.rank == attrbs->rank &&
> +		    rec->bank_group == attrbs->bank_group &&
> +		    rec->bank == attrbs->bank &&
> +		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
> +		     get_unaligned_le24(rec->nibble_mask) ==
> +			     attrbs->nibble_mask))
> +			return rec;
> +		break;
> +	case CXL_RANK_SPARING:
> +		if (rec->media_hdr.channel == attrbs->channel &&
> +		    rec->media_hdr.rank == attrbs->rank &&
> +		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
> +		     get_unaligned_le24(rec->nibble_mask) ==
> +			     attrbs->nibble_mask))
> +			return rec;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_rec_dram, "CXL");
> +
> +int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
> +{
> +	void *old_rec;
> +	struct cxl_event_gen_media *rec =
> +		kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
> +	if (!rec)
> +		return -ENOMEM;
> +
> +	old_rec = xa_store(&cxlmd->rec_gen_media,
> +			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> +			   GFP_KERNEL);
> +	if (xa_is_err(old_rec))
> +		return xa_err(old_rec);
> +
> +	kfree(old_rec);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");
> +
> +int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
> +{
> +	void *old_rec;
> +	struct cxl_event_dram *rec =
> +		kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
> +
> +	if (!rec)
> +		return -ENOMEM;
> +
> +	old_rec = xa_store(&cxlmd->rec_dram,
> +			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> +			   GFP_KERNEL);
> +	if (xa_is_err(old_rec))
> +		return xa_err(old_rec);
> +
> +	kfree(old_rec);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_store_rec_dram, "CXL");
> +
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>  					      struct cxl_ras_capability_regs ras_cap)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 7ab257e0c85e..24ece579a145 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -34,6 +34,41 @@
>  	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>  	 CXLMDEV_RESET_NEEDED_NOT)
>  
> +enum cxl_mem_repair_type {
> +	CXL_PPR,
> +	CXL_CACHELINE_SPARING,
> +	CXL_ROW_SPARING,
> +	CXL_BANK_SPARING,
> +	CXL_RANK_SPARING,
> +	CXL_REPAIR_MAX,
> +};
> +
> +/**
> + * struct cxl_mem_repair_attrbs - CXL memory repair attributes

Between attr, param, attrbs the names of intermediate objects seem to
have no rhyme or reason in these patches. I don't have a specific
suggestion here beyond please take another pass over the whole set and
be consistent.

In general attr is an overloaded term especially in code files that have
sysfs attributes, so please steer away from "attr" for that reason.

> + * @dpa: DPA of memory to repair
> + * @nibble_mask: nibble mask, identifies one or more nibbles on the memory bus
> + * @row: row of memory to repair
> + * @column: column of memory to repair
> + * @channel: channel of memory to repair
> + * @sub_channel: sub channel of memory to repair
> + * @rank: rank of memory to repair
> + * @bank_group: bank group of memory to repair
> + * @bank: bank of memory to repair
> + * @repair_type: repair type. For eg. PPR, memory sparing etc.
> + */
> +struct cxl_mem_repair_attrbs {
> +	u64 dpa;
> +	u32 nibble_mask;
> +	u32 row;
> +	u16 column;
> +	u8 channel;
> +	u8 sub_channel;
> +	u8 rank;
> +	u8 bank_group;
> +	u8 bank;
> +	enum cxl_mem_repair_type repair_type;
> +};
> +
>  /**
>   * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>   * @dev: driver core device object
> @@ -45,6 +80,8 @@
>   * @endpoint: connection to the CXL port topology for this memory device
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
> + * @rec_gen_media: xarray to store CXL general media records
> + * @rec_dram: xarray to store CXL DRAM records
>   */
>  struct cxl_memdev {
>  	struct device dev;
> @@ -56,6 +93,8 @@ struct cxl_memdev {
>  	struct cxl_port *endpoint;
>  	int id;
>  	int depth;
> +	struct xarray rec_gen_media;
> +	struct xarray rec_dram;

Can this move to an EDAC context object to not burden 'struct
cxl_memdev' by default?

