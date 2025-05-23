Return-Path: <linux-edac+bounces-3996-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B636AC29FC
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316C43AAD02
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4729A321;
	Fri, 23 May 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahOGKGZ7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF6227E82;
	Fri, 23 May 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026456; cv=fail; b=VjuLXXkHuCcqZw+QUFnD8jTA4sAbdYyX3RIega0JncqBfub61GpqSji6OHu8G1SlOS6aPV14GZspCcK8oPo8OzJZwf7nahtW7gRbzxil4hTSdsNUxVFClcleMzCuRfcFWm53+IfAgDt5n3Gffg1sNG1ditYV5NgBe/bavTE2X/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026456; c=relaxed/simple;
	bh=cxn7zQKfNbWQWDyeRoqhRi06dfu/WYp4PHWcNFZBLJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUU8k81VrpEPGPbkoswlVi3LWFceMkw7lO0WvYWeRWuf9iT+tqTqnLeDlynO4DsNVQzZI2YN7sypJuL1CQTiKW4Wqjl14q5rENCrP+HhwA2gCgW0WeN6yG6LJvd4olvWzKP/9zMerMdl7KGAhUuhDVsV0w95pgm2adROKV+V4nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahOGKGZ7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026455; x=1779562455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cxn7zQKfNbWQWDyeRoqhRi06dfu/WYp4PHWcNFZBLJA=;
  b=ahOGKGZ7WsOzhYvhLmy/dlxzsabDTPt6UuGMNz8ssX61GyEeECVyYPsi
   OHlx8JtroDJH5Vt8mnvy5Zu4ZgFeyVMcsEAzQNK5bp0stHQFMxQtJDd5d
   6iWYFyu4NVvUmmvBOXP+ueVtDdTlIuR2/zCwQG9OBTtzqZ55DM/oj/Q5w
   uORPF7gWny8F+PwDT2bW9hJRFI0dhXHM9ibSxgRL8VdIIGJvELhNQYkfh
   ZAcLy+M+dK30XpOA2k81/V33YC+l//m8AxuycJc9TK7klaf4UposjnAGV
   cSkUJg/TdqQXxRTfKpjtdyanObRIYHnPzp7dah/CwQrg2sEJzRRGW8gac
   Q==;
X-CSE-ConnectionGUID: k4y142LZQGqxYca1tyVNCQ==
X-CSE-MsgGUID: AHFvRUpgTJaLtOwkDXZ1hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="52718477"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="52718477"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:54:13 -0700
X-CSE-ConnectionGUID: E9X6ximkSwavpDxaBYOqGg==
X-CSE-MsgGUID: HovLwLYpRAaQ9cct8os3sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141309858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:54:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 11:54:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 11:54:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.73)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 11:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib6b5yr//sXimY4NZ7xGQ5JDkGpKACDxZoj/jVZqHi3jBMMOwox1VciAV99K12PUqRfv4fb4HxiA07B6hXDpV1gFhw380k9M6ThZ67jgCUoWPTpW61fm/FkGcpWQLveS9UL4032koId+6XUhFcPlWOf9SgGQZQhYwCb45Atakb7rXuPYfSLdN5X9m4igo6SGe+cIlm7njsJRAJdvvTuRrzGUPDnRlQ5dabG/itMQ7q74SVM7YiRnWeGXEDqb9NfeKA7TgetF2y+Fo90zZAfZKfQMMvSKcM4uwF7seG4sQ7cDTHI8r7Om8JXcCk6Pll2tlhNMeLJvb5LKCRsjgHR5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDulkfJyIrEumlkqtxjytQBMW0CTonyNESA5OSm7hBk=;
 b=J/bxtnB2KrImr4+2HOz5jH1i9iA1Qeh0US98u+Oi6lZ622OARlGjZ9TEybB6jiaa8GtxTU+hid5MNSzE9NaTf7+YMdFwNGWCZ5h7i8G8P/gY0PCsFNxcHVDX+GfxEEaNy+3W5Dr7oMd0EWFSJCrELp3X94VhavTtESfEJVGr17S1gEc1YOke6zq/tlHWS3Kd+pyeKWiVam7mMDCrJnO/XiR56LldVUxEXXzJwbHeF4qunhRV4QFL2mGD/s1t3YI3gpltreIosViecjrCNyj/VPEmpa+84cLc/jWtmd47F5NTjtM9UW3lIPKUgsmf4haGgZjgnYbVqbZ3TqS2d+tcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 18:53:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 18:53:56 +0000
Date: Fri, 23 May 2025 11:53:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v6 0/8] cxl: support CXL memory RAS features
Message-ID: <6830c44161538_3e70100c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250521124749.817-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521124749.817-1-shiju.jose@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 159fda74-f684-45e1-d202-08dd9a2b2b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LV243/HE+AGoy+9zA/TQLag5qag5YshjuJmCjJbafDysgq8jsm2kYVIR53U2?=
 =?us-ascii?Q?eD2F222mB5nXLzhqIqcA9jcJDZYZo5+oZC05aqOrVHJiH7gzc+3Voc0alFqL?=
 =?us-ascii?Q?jCRIEwQFbam/sgZ74hO3ig5fe8ZdYLuyL5/M6KLvreNXlwvUxLgU3n0CuTcA?=
 =?us-ascii?Q?j0zlLuCOyVeXVagl/l/0+2foM2316g/51TYZbjENAvleYPRFSMgoU/JqT506?=
 =?us-ascii?Q?ZxmPaPUiXmPGryMGLx3VCT89yzwKgX7bvf9Rsj+6wMZjsaseW84rE0LeW5uy?=
 =?us-ascii?Q?LIjs92/Mn6+ZScXTtCxBfR/rJBb9K0Yk0G4bKehyZ1OFMgL4sVRUdy0YhVgX?=
 =?us-ascii?Q?hOgLCbDkuBWM3yHGeaDSAhjf/ci2iUUAsC9iEiuzLwTKuttfPFVY/E140wMI?=
 =?us-ascii?Q?z0SyNceyvpK8Swiur6tT87TI7T2E1w+8G6U2KE25sCghDb8amvyngzxKRtcX?=
 =?us-ascii?Q?LNqlhVIpNshoG3C2G3rqV5aApcRleQiz4pmgWDBZtg15XjZwSuQAS9d1GwXB?=
 =?us-ascii?Q?n6K/7uJQdwOmwxPUKHzzle5RG5VuSxOvbKQwqawNvLcH9XOlA6wrtik5M0fv?=
 =?us-ascii?Q?JDnLsaWeg27VTkkPkGnjLe088sm124O8S9W5yX5ziRj59XcJyshqAci2Q/K7?=
 =?us-ascii?Q?l9lIP98EjAsa0CZyostjMig6zy24ZLohDx0NEoTskIwFlGqNwhm3/xCZveKz?=
 =?us-ascii?Q?Zb7byW+dAed4JaHSkZHzOGYb92Zhb2fR+8vzMpBaM42m+jiA/nClcxDgBtli?=
 =?us-ascii?Q?2An4ngzShwPAmPxyddpyVSawDA+x9znjqNDQR1PvQ4YDmGR8EWLs68sAQ6IG?=
 =?us-ascii?Q?SMfRsntJ4aZvn8Vm8hLt+3O5aZeI+pXAL5kJgzMKTPn4abXnllmplEUBFCWt?=
 =?us-ascii?Q?IIga7GHWH6NCCxyTnP0yiikTPDuzEElKNs6gX0jepsgK9TUALocuxGDEQ8Hb?=
 =?us-ascii?Q?w999jf1OU5nrPxvKB2Aqsr5HzkxrJSQSw94Nn8Y3+JPCFLidyU+X7HVaVjVI?=
 =?us-ascii?Q?Nbiny/AlDw4Mke70XG9ZmCiC84HS3dQw/3lqLaE2/aul5JtFflkLL0263Wgl?=
 =?us-ascii?Q?j72Vfe8JwoAD3cGyYhf6Ij+7F1E0hPtYPTWECV1aE+6CMQcvnLJ/GJqv+BYG?=
 =?us-ascii?Q?8Pph4CkL9SVAVr4ZfjJ1K4uRu4qk77c00CmPR1lKmwxNr6ImeuAP2JXb157a?=
 =?us-ascii?Q?I06UVlMCkApWiVg7rO0ozJjs47xJ+vReZvchwPK6TAN1zXa4eoY8Ms98CUOR?=
 =?us-ascii?Q?vBNcHTZcBzfI3eOtwGwdaKExTFToB3v4OQMsIz1ImTASLOAFFTwIaEEDSbOW?=
 =?us-ascii?Q?FP02cQJhmEAp1V9SqTSMdxoQUgw2dOnfSkjob05PudOUeB5IEjseczUDEksc?=
 =?us-ascii?Q?TQ0vIkzUkzGkRXR0FqZruoJgJqKG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N17mEJpfp7GmFJL0EavTLU2/rHRvydr/4xvht5s05q4Q2R+sLAHKS70ajKnQ?=
 =?us-ascii?Q?HIzMCCQrIaGXOTFuzQeDqhMkDODPTR4FIXsBdXl+4lBedBHJJRXIpSRKZxea?=
 =?us-ascii?Q?nNzD/6LZCdgQSZrHmJDbauy+HfYvhMDjRpxlUVaNZ4UQ9voavLrgn3knJl57?=
 =?us-ascii?Q?Aa29SqCT8A+JEOq+oMqLpc1KvLLGyWwaDmZzE7/+PSB5L20QdSV+W5Vwrii/?=
 =?us-ascii?Q?YS3KQO4t6lgIhprct4J7NHxvLRSJXV+m7ItjYJ+t8jUi7wcVunClF9tbfpVn?=
 =?us-ascii?Q?CXR+uUk7rkCERN3S8nH+SjrvsqOcLGIpFN0wjVPdKGB8Ig+dp/uUrjENZ0Eu?=
 =?us-ascii?Q?dZc8uzBU0v7ofmz8F25kgctbEwOZCDdh2Y5CtiQmo0FWw0MZysi6/9DSgVCP?=
 =?us-ascii?Q?XoztCVusDvIZETJlV4fuhm8EVqK6hngWU+pushf0WagypJ7/rbq7ML3wUxzS?=
 =?us-ascii?Q?Dv+N/FQGKMdqsXntJwNaFR+vibiUW9S7HyiRQItvFkf1P0iI5EuqFQo8plij?=
 =?us-ascii?Q?9qf8PPm1kVCX0CSPfu6ZXGRDL56WDT7axVWjbiRG+HF26z9NbwvCbemJEg30?=
 =?us-ascii?Q?tV3Tv6ZyDNE01KrdgQ5m3jyoSVvYi269d0ukgyky6iL1s3pcwH4kxVKwySvm?=
 =?us-ascii?Q?mtdYnBVYoBSYGCcAN+J0Z2R9zWifZLP2f8a5OsMxo/M18eqo/xF2QzoBkAI3?=
 =?us-ascii?Q?NZzCDGdoMuggHd/culAwbpRXlU3hHD4X0+ZC/Bv8glZIwHZTAcwdHO9ztGqs?=
 =?us-ascii?Q?Gi+Jd09YdFFUudUNSt2wRZ6Oa9PpWEzxZvWp33HBWf9WNuFQDs5iYNF2BdX3?=
 =?us-ascii?Q?HLTZhWlBqVOm1e3V1CHhiv8DsJh7F1yrbL0M14Qf0YrX/otPc2TMKBwnWch1?=
 =?us-ascii?Q?gwAjPkhmaDrKPgy4mMfkwME5+2ZEatA0gKO17hSTuhaDyse29extuKkhAGYb?=
 =?us-ascii?Q?hNcHZJ4nSOQ8yl8cv+br2YornLKKqMKACX0osa4QdnlUKqDnKBG/ZTjo6u5T?=
 =?us-ascii?Q?cOyp9j0LEcIqwcrf/Jsjou+L4hVnIep6zr35/wVfuM4xciBoceO2xuebl96f?=
 =?us-ascii?Q?Y+dypgfFrxxeOcdBF1aCMl77zAqN23N+nJi4F63ZpJYZwUGntzBg3vYErl/C?=
 =?us-ascii?Q?s6eTA2iaLI1D+O/qFhaNOY5RAmm9T9rMhSxcmH3QRkcxjbOdC4+/NIKhkUYs?=
 =?us-ascii?Q?4GTyyyWJ7QzTCANSgK9TU6UDl8X5+dShShqsXol3oIATmK+2bscfT1B+AENs?=
 =?us-ascii?Q?ytQdEomLEOkoDoQ8wHWLX2z78FQVy+hxZ/bvvc5Ngfj1degtJnbJOt2+4uLD?=
 =?us-ascii?Q?NCwopuXaB2LTcjWXUWpZROF4jl3u14O/9k4yPVryWlr84w9e/CpSnE7DD77p?=
 =?us-ascii?Q?vBp5qalPzPnBirQ0gLtNUAPpYQ/QTZeDVmaqb4+gbDft39CJU2G1CnEVbq4q?=
 =?us-ascii?Q?rDKOgxenMH7en9ZVOc4JZLdzOUkKJdzlQrzXjwcuFPwYJ1ZVFPai6mEBbkpR?=
 =?us-ascii?Q?evcAVDjQsXGNa1FCicpfOVzOVr/SFmFmdUOWWcwFtw+aZz7vmuvrUvItrxRn?=
 =?us-ascii?Q?UFwBHV6cpZVR70jYvjmfMnbBM9T+AQ4QBt4CEE7G5xYNDISx8zvjdlWiJ9o7?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 159fda74-f684-45e1-d202-08dd9a2b2b8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 18:53:56.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG3LSHce2Nwg8qUuhrVN3dGmMvS3csSyHIiOiI6NsdpKbjfmYZtihANRhcKErsVL0CXfuA3XEC1M5KUVp9XXfOzwKBIpsTHom0AXoAKWjN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
> memory sparing.
> 
> Detailed history of the complete EDAC series with CXL EDAC patches
> up to V20 [1] and this CXL specific series had separated from V20 of
> the above series.
> 
> The series is based on [2] v6.15-rc4 (based on comment from Dave
> in the thread [4]).
> 
> Also applied(no conflicts) and tested on cxl.git [3] branch: next
> 
> 1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
> 2. https://github.com/torvalds/linux.git
> 3. https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
> 4. https://lore.kernel.org/all/d83a83d1-37e7-4192-913f-243098f679e3@intel.com/
> 
> Userspace code for CXL memory repair features [5] and
> sample boot-script for CXL memory repair [6].
> 
> [5]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
> [6]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

All of my prior review comments are addressed, the maze of type-unsafe
callbacks gives me pause, but not disqualifying since it is all
self-contained out of the way in drivers/cxl/core/edac.c

For the series you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>

