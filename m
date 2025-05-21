Return-Path: <linux-edac+bounces-3983-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B4ABFC02
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF38D3B797E
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5102609E7;
	Wed, 21 May 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR/p1Ij5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259617C21B;
	Wed, 21 May 2025 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847324; cv=fail; b=MwwpjKlzvl9IBJx8H5PvkCvur6Ix29aPawgSN1iuTRuP0pn3wfR2W86p50fMiLh8gNuG07YMvSQSdC9/x1GWMWl9S1fq+5oz7/3arbXxN38jWMfqBXFBRPHivRt81XLzK9JepBz15DII0yF3PIzU1uzu+tQyOM8yL2qJjq1UrLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847324; c=relaxed/simple;
	bh=bT+ChSLJS9SwOhVGXxv/b8wOoVeeWkbZR7r8VqvcT7Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+HbM5SC5UJjXN1BbihJnGPIBCUhPBAmKQhgpILgdC60MQqvBF2mrTHJXVfVk2x7UV9a1TWxaH7Pmpi53PwsoBCg4h4ZnfAMsiPtBUH7lExol42rwzZgnbkUOKbsPtC8Zdj0Pj5vQlHGYGxn+MOYEmHCmf+/0cG6MK/4yHoirUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR/p1Ij5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747847323; x=1779383323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bT+ChSLJS9SwOhVGXxv/b8wOoVeeWkbZR7r8VqvcT7Q=;
  b=JR/p1Ij5cYno94gDg4I8ejoG9fyNmrp01xL8WJfHFTG7BkjAN/iDkB8i
   eDHvAKd52bEG66mmbyEiTvtMUPA9gV1tjlSGag59tDJvQ4qRsLM7Td/QT
   6b0FpO0BQ3NWZwSgyMC2PDR8rpyM+0Hj93RQx2SQcRydoEp4aPO/Y86fW
   BWWdUbvhB/6ExfjBFb4Z7wTZ9aA7/p0brnIyV5xTLebNvFiuyVHjWQSvV
   nCv/s9QYvX8ASlc8TT5dU+2hrt9Fz07HkmXx3RfAJQhmkU5L9BoXU3Wij
   10j/4UNVkrEKCRZds5WZiGch7wvREAoevO3SWO/51bvmcDqFbYLKng7S3
   g==;
X-CSE-ConnectionGUID: AqqJy4arQSqysy+zm792fQ==
X-CSE-MsgGUID: zaQaWc3/Rb2719R5yAuRwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61246730"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="61246730"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:08:42 -0700
X-CSE-ConnectionGUID: Dh8xT7TzTSGDu0DIeUw/hQ==
X-CSE-MsgGUID: aOqzFWXZTju9/o8JEkwNMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140586039"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:08:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 10:08:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 10:08:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 10:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPdnccdcbYbz7SlMNLwdvHSrIOJq1VXAzdf9dlExBuzSAlFeAEuj4WKOC8cQBc0Jpi89c8bnF7sF3KBw6LA5wJvs1MxESNdWC0eeUcSrJL88EonUM2QT9aDMdsBf4DPBUSdben6N8ETMWoGonmsbaswA6WVk1Dju8J9MFOQ3qn3Yzr42/3LN1IL8KeIPkxfmkVtCRVjJl7XPbZynnzeLrTmzOPkY7JBZKFNM0yZI8NdZADOFhLdDmzpPWJpPa5+4Zvd7S0kt3cd0JMnIO/WAN1keRiNIiOMhD4FT/hD9nknUq0/3tf31z2oaUR6wNFiBC0YZmjkK2LgE/C4PThgWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/W6LOv8LC6iAsX4Tm2dSmClF4fl00jh+IHTuKCO7ko=;
 b=evcLA8XXRe9x0aTgT9MPBgiJnwU2JaD5nfZVKJUrU6Fi/M+glctvy/Trq/nUnEjaCTT3yvJBssW/PhfemTam/kW/K6Wndkgxm1n1UM0Aw+NO7Q10Xzi9/sph2n59qLo65FE/xQZZKh77GLoEIT0YIB4h3yEKGsuwtgxwfg7wJ8I5K+B5cMlrs/JWSze8mXl6+UAES1UZl6kwIk+claF+9HbYgYKbUloEreenxPPDRNzkfHDhaCNVBZPq/Y1hdKsiZTXJildVfRjs15mkD4H5oWIAc028FodDAH2ASdZskJn/Or/9qtv3fEZwsY+ORMSWZuhWgRMdWtTVN9+t/WrbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MW4PR11MB6959.namprd11.prod.outlook.com (2603:10b6:303:228::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 17:08:10 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 17:08:10 +0000
Date: Wed, 21 May 2025 10:07:57 -0700
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
Subject: Re: [PATCH v6 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Message-ID: <aC4IbZQrhmL9PohM@aschofie-mobl2.lan>
References: <20250521124749.817-1-shiju.jose@huawei.com>
 <20250521124749.817-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521124749.817-4-shiju.jose@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MW4PR11MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 606db024-f212-46fa-0acc-08dd988a100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m4OZRgTIHoAZIb9FMscUOiatuS1NNlyOkd3cbiCN3FbP0phE2pYgTnhEyRLz?=
 =?us-ascii?Q?1YmahXMEk5JexKS9yswTRqY/9bLjGa5KixSLNOz3RGrwWIEXK5/6pBfjHYrX?=
 =?us-ascii?Q?YFkU6BU6rYyWfZ/8QVTdbkTALziYYCP8L8eG/d+gXBSHPdhzxSXDfD+Y8bAN?=
 =?us-ascii?Q?XUch5i6cL1lzZXl5p8AzR5XBHYgeYPN/J5nZwmb5ZDtFni+xxq8fzaGmxdjL?=
 =?us-ascii?Q?P86tB4hJ8m1e0fc+w9RL3tLdNwirudrWbzuKWDCx9hrIA/htmz6KTTeOLgMV?=
 =?us-ascii?Q?BZgi6aA16DTnio8IEZykuG2NDG9+nFg4lnH7BjurNam/0xUPVFHJWPoud8a8?=
 =?us-ascii?Q?yhyYHLKk0MK80cAQ0LX3otGil6nxJbaJVaiTbSBPDVCcksjBCn6EgngMWHg3?=
 =?us-ascii?Q?EQkDATyLmUebPHkqtzSGYMsZRoqfTt59tSsEUiIxG0mnfqUWEJnH0K7852fI?=
 =?us-ascii?Q?gKNwkU7NDClSJsJCQe955rHj98svLm2zOCkEoZPudLweBWoksOyZafQc/T45?=
 =?us-ascii?Q?WexCWRKPBgcc860RGTQ278PvwgiSE5BC+sjQ388V4pbOXQQzcqp+1x7UtXwX?=
 =?us-ascii?Q?O7eRQq7kKb9cuQmLcHRBIe7oHwWEB7jzE3jfE2Nvu2UB2aSLkN0vbtk+35so?=
 =?us-ascii?Q?5LGO/M72qgrUAQxBSoaQsz5pv939Y/snVIug8RKZIRNAoPWN7nK9xlbgGYi7?=
 =?us-ascii?Q?dSTCQSZmZN57FVAMJ2K3GR4aK9sjxvqARXzttRl112pSLhuubW3l2C12HewU?=
 =?us-ascii?Q?mdXD5Wig9dH70hhzLoBti2oU4rHI1ntMr4KaWvuQbip3Ps+eBy8ExuAn/BW0?=
 =?us-ascii?Q?MMPRL4hrjEr9Y+XTwClZXIvpyjcNIuCPQ50kif2NiviDViW1gaaRfzDmGKJm?=
 =?us-ascii?Q?WOHcteInByb0thtSYPytviCeIx19cis7RKkxiac9l6SKhWCAu1UlMIGx7ANI?=
 =?us-ascii?Q?nJmEYXvjLGUjnN6mt1y1dDizwswRXZv5XvtECJrNX2i8j60cbUbGTWbJUnRj?=
 =?us-ascii?Q?Uos9q1TYd8vd4JcNI2U1k/Z9fW50iOWU4NnOJGHZlTSgx6DfNn6EMu1cdbNF?=
 =?us-ascii?Q?lvUQNIHL0cAAywbtnT6JBLXpYB0sNTpP/wzsDFldtLvxx//zVKl6rVZ6bCld?=
 =?us-ascii?Q?SYLZHt+1OA0pcJdKU1qq68D8tSIsaeyn/L45QNXFBTyxFXWvfzI+hrxRWqL5?=
 =?us-ascii?Q?v1bMYbC8gW0pxjoppfKFzQaT7Mn7VsMuDQgeEkoWD4Gt8unJpy44EeAD240f?=
 =?us-ascii?Q?qM5Hr5klh4trXHAe6hVi0x0zhpvwLMPK+NHKoaMXa9bgBLpkS0Q7M3bkhzIz?=
 =?us-ascii?Q?gfuti/O/MblUE3Aj8wmb1N4DOEtIlOkNCRXMTz7gEtfZzs7TA3BRBGLvZN4V?=
 =?us-ascii?Q?sZQO9DvcdJ1TZc+mq56BVzj8EpCf1PM+uhgXn0SQ6bVC61/X3/3m25R3RalY?=
 =?us-ascii?Q?l5wz5MsitAo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfoK+ILWruxF0pSrcP+jiFTDHJZozad770fqAIYVlv2VmP2J2nPkUOVFq2KV?=
 =?us-ascii?Q?HEUMEGNu6tO9c6U58AlAan2tvW8TnbVoQd6tbn4jXc62LonS/ukeuysOl+S3?=
 =?us-ascii?Q?pWX2LKoxwKIa/fRnYtSmYc/w+xvCiOqQ9nFSo3/vkI6hhG6wCHhYZW9EfTzO?=
 =?us-ascii?Q?xSECu51g/8i6YsoyRFpFjKYGULOTv7JwZkvHqE1a8+F4nkLr08dYPA1rl3Uj?=
 =?us-ascii?Q?tWAK0kT4a1edZ5/Dhf7H+eoq0bpIA+QArc6Tw60MQbJ5G1KFeJBi84Gwnx4k?=
 =?us-ascii?Q?ueMpar6VEdOqWruqsys0LGpsVjYwcr0LnGyRP/t+zQeQhEuzA9ewySt/UIte?=
 =?us-ascii?Q?bpiJKdA6oBCGvAYYImixSaQVHiTUzzoDkfCbP6u4mehJMR9DmCooMTBbPJTK?=
 =?us-ascii?Q?qlHYLONYmuWiqz5VMYOZhsPcQyWKdVnpTQEW91BvQmWzewKR84RK76e1wcTf?=
 =?us-ascii?Q?y8q27CypvV6m71Q79wacf/YdO/IlPTDn16he9uu/Rv+cY2sqZZP0DvnDysQY?=
 =?us-ascii?Q?udjidSFYsjfomVDnXOT/esxMzr+S+B0AfbRRNEKVgw00Upu3Ecrr9M4QpwG8?=
 =?us-ascii?Q?ZHZPxdAhrnUeOP+1tMU5yIRQAWI7oe2ckiPxbGipP+VTC1H2Xcr5PFqo0T8j?=
 =?us-ascii?Q?wCyrPtHlFmTyjR16AEiICqC0mGW6y56fGskXY82S5i4iho3LOY8hEEvJLI6z?=
 =?us-ascii?Q?xshSjtrC48t4a0EHef4k5nDgsrVoVGpoYNGB/WUnFn3Sj+Svy3seigyMery0?=
 =?us-ascii?Q?2f51imKYrgW6r13dQAEClWrxoGaEX+74jK67P+cEQXawOLEiGD6PGRg8bclL?=
 =?us-ascii?Q?HPTWaXrtzIRpwAg1yOEHJuBFg9pMHBxYcSVyNTM9f7qZGyl1aGKmsyt02wWZ?=
 =?us-ascii?Q?m9mn62IZR66oroeE4KFBNBDmyBSHV+5/zlNIrKqzGVkB/c9JyJd3tDhusvgl?=
 =?us-ascii?Q?MznyxzOvLibqfPA5bkgqU8lBWK7u27MieTQJJJu/acMHRmmok1xzqcqLkXFR?=
 =?us-ascii?Q?qs70N9I24k490Gzf4P3l2Ha+3HdfR52ah5jav0LyLxq1Jq003OBe2fnobY+9?=
 =?us-ascii?Q?gzqMWu46aAxXbN4rt+lvp/gghdJFNSmyF3My7xii1SdAltR0nxlME6jy52Sz?=
 =?us-ascii?Q?IOSUJr530BTF+Igm8GEgnOX+C50oxZ+wstLeLOYGdGEnQe50npsRfIFflOZD?=
 =?us-ascii?Q?/YcfB4beNf584ZzSqdP1FskAc4xzXsvIIZwXRejqnYvPdF/nzjBGCYXEf3pa?=
 =?us-ascii?Q?y9H7JNuLuDeexHAw+ovaSofFug9hdQhkVOAiCWF2H+GiHTO+BCKVR503tUov?=
 =?us-ascii?Q?Kpvel5JJ4HV7X+75GOy9jr9nBIHc7XGv5xntPf2WEW2VlXzC0PLYjq6dY8zI?=
 =?us-ascii?Q?nbDJssQV6loZ5VRW0HnvNFWt5lOygJNjUyu2RWkBDna4ArVKeIlcL7Csc7vH?=
 =?us-ascii?Q?gsL/MtkEYB0Y0puBifpgwTL2oCBLV5bBrKSgxTy6W7rbmASte1q7kG+oTGQt?=
 =?us-ascii?Q?qhuPuC8l0GTdT9v6EibD2G2wdbOEUm5m3lX9Ku+vLJUkWeCAg6wK/C5Y8mMa?=
 =?us-ascii?Q?wvBCWT1M2FvyqOYO7S56cjpzpSZcCMvO/D/jH4onF9Lx8mF7/RC3rpthB8zz?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 606db024-f212-46fa-0acc-08dd988a100a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:08:10.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbRn+PRHieEgyPvqnCROj2aXb3a0JLIxbn4g618kMChGGlK0nFe6yhqxd8OFaO1mIlRmlczFUnrOWuWWn5KKEtVludlJYLRu1rEUF776ENA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6959
X-OriginatorOrg: intel.com

On Wed, May 21, 2025 at 01:47:41PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> control feature. The device patrol scrub proactively locates and makes
> corrections to errors in regular cycle.

snip

> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> new file mode 100644
> index 000000000000..eae99ed7c018
> --- /dev/null
> +++ b/drivers/cxl/core/edac.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CXL EDAC memory feature driver.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + *
> + *  - Supports functions to configure EDAC features of the
> + *    CXL memory devices.
> + *  - Registers with the EDAC device subsystem driver to expose
> + *    the features sysfs attributes to the user for configuring
> + *    CXL memory RAS feature.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/edac.h>
> +#include <linux/limits.h>
> +#include <cxl/features.h>

This needs tidying-up. Not clear that tidy-up belongs in this patch.
sparse now complains:

drivers/cxl/core/edac.c: note: in included file:
./include/cxl/features.h:67:43: error: marked inline, but without a definition

because there is a proto of this in include/cxl/features.h and it is defined in
core/features.c.  Compiler is looking for the definition in edac.c.

Removing the inline WFM but that may not be right soln:

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index a83a2214a136..4599e1d7668a 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -36,7 +36,7 @@ static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
        return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
 }

-inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
+struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
        return cxlds->cxlfs;
 }
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 5f7f842765a5..b9297693dae7 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -64,7 +64,7 @@ struct cxl_features_state {
 struct cxl_mailbox;
 struct cxl_memdev;
 #ifdef CONFIG_CXL_FEATURES
-inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
+struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
 #else


> +#include <cxl.h>
> +#include <cxlmem.h>
> +#include "core.h"
> +
> +#define CXL_NR_EDAC_DEV_FEATURES 1
> +
> +#define CXL_SCRUB_NO_REGION -1
> +
> +struct cxl_patrol_scrub_context {
> +	u8 instance;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u8 get_version;
> +	u8 set_version;
> +	u16 effects;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_region *cxlr;
> +};
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol Scrub Control
> + * Feature Readable Attributes.
> + */
> +struct cxl_scrub_rd_attrbs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle_hours;
> +	u8 scrub_flags;
> +} __packed;
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-223 Device Patrol Scrub Control
> + * Feature Writable Attributes.
> + */
> +struct cxl_scrub_wr_attrbs {
> +	u8 scrub_cycle_hours;
> +	u8 scrub_flags;
> +} __packed;
> +
> +#define CXL_SCRUB_CONTROL_CHANGEABLE BIT(0)
> +#define CXL_SCRUB_CONTROL_REALTIME BIT(1)
> +#define CXL_SCRUB_CONTROL_CYCLE_MASK GENMASK(7, 0)
> +#define CXL_SCRUB_CONTROL_MIN_CYCLE_MASK GENMASK(15, 8)
> +#define CXL_SCRUB_CONTROL_ENABLE BIT(0)
> +
> +#define CXL_GET_SCRUB_CYCLE_CHANGEABLE(cap) \
> +	FIELD_GET(CXL_SCRUB_CONTROL_CHANGEABLE, cap)
> +#define CXL_GET_SCRUB_CYCLE(cycle) \
> +	FIELD_GET(CXL_SCRUB_CONTROL_CYCLE_MASK, cycle)
> +#define CXL_GET_SCRUB_MIN_CYCLE(cycle) \
> +	FIELD_GET(CXL_SCRUB_CONTROL_MIN_CYCLE_MASK, cycle)
> +#define CXL_GET_SCRUB_EN_STS(flags) FIELD_GET(CXL_SCRUB_CONTROL_ENABLE, flags)
> +
> +#define CXL_SET_SCRUB_CYCLE(cycle) \
> +	FIELD_PREP(CXL_SCRUB_CONTROL_CYCLE_MASK, cycle)
> +#define CXL_SET_SCRUB_EN(en) FIELD_PREP(CXL_SCRUB_CONTROL_ENABLE, en)
> +
> +static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
> +				    u16 *cycle, u8 *flags, u8 *min_cycle)
> +{
> +	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
> +	size_t data_size;
> +	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
> +		kzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
> +				    rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	*cap = rd_attrbs->scrub_cycle_cap;
> +	*cycle = le16_to_cpu(rd_attrbs->scrub_cycle_hours);
> +	*flags = rd_attrbs->scrub_flags;
> +	if (min_cycle)
> +		*min_cycle = CXL_GET_SCRUB_MIN_CYCLE(*cycle);
> +
> +	return 0;
> +}
> +
> +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
> +{
> +	struct cxl_mailbox *cxl_mbox;
> +	u8 min_scrub_cycle = U8_MAX;
> +	struct cxl_region_params *p;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_region *cxlr;
> +	int i, ret;
> +
> +	if (!cxl_ps_ctx->cxlr) {
> +		cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> +		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> +						flags, min_cycle);
> +	}
> +
> +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> +	rwsem_read_intr_acquire(&cxl_region_rwsem);
> +	if (!region_lock)
> +		return -EINTR;
> +
> +	cxlr = cxl_ps_ctx->cxlr;
> +	p = &cxlr->params;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +		ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> +					       flags, min_cycle);
> +		if (ret)
> +			return ret;
> +
> +		if (min_cycle)
> +			min_scrub_cycle =
> +				min(*min_cycle, min_scrub_cycle);
> +	}
> +
> +	if (min_cycle)
> +		*min_cycle = min_scrub_cycle;
> +
> +	return 0;
> +}
> +
> +static int cxl_scrub_set_attrbs_region(struct device *dev,
> +				       struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				       u8 cycle, u8 flags)
> +{
> +	struct cxl_scrub_wr_attrbs wr_attrbs;
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_region_params *p;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_region *cxlr;
> +	int ret, i;
> +
> +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> +		rwsem_read_intr_acquire(&cxl_region_rwsem);
> +	if (!region_lock)
> +		return -EINTR;
> +
> +	cxlr = cxl_ps_ctx->cxlr;
> +	p = &cxlr->params;
> +	wr_attrbs.scrub_cycle_hours = cycle;
> +	wr_attrbs.scrub_flags = flags;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +		ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> +				      cxl_ps_ctx->set_version, &wr_attrbs,
> +				      sizeof(wr_attrbs),
> +				      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> +				      0, NULL);
> +		if (ret)
> +			return ret;
> +
> +		if (cycle != cxlmd->scrub_cycle) {
> +			if (cxlmd->scrub_region_id != CXL_SCRUB_NO_REGION)
> +				dev_info(dev,
> +					 "Device scrub rate(%d hours) set by region%d rate overwritten by region%d scrub rate(%d hours)\n",
> +					 cxlmd->scrub_cycle,
> +					 cxlmd->scrub_region_id, cxlr->id,
> +					 cycle);
> +
> +			cxlmd->scrub_cycle = cycle;
> +			cxlmd->scrub_region_id = cxlr->id;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_scrub_set_attrbs_device(struct device *dev,
> +				       struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				       u8 cycle, u8 flags)
> +{
> +	struct cxl_scrub_wr_attrbs wr_attrbs;
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_memdev *cxlmd;
> +	int ret;
> +
> +	wr_attrbs.scrub_cycle_hours = cycle;
> +	wr_attrbs.scrub_flags = flags;
> +
> +	cxlmd = cxl_ps_ctx->cxlmd;
> +	cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> +			      cxl_ps_ctx->set_version, &wr_attrbs,
> +			      sizeof(wr_attrbs),
> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET, 0,
> +			      NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (cycle != cxlmd->scrub_cycle) {
> +		if (cxlmd->scrub_region_id != CXL_SCRUB_NO_REGION)
> +			dev_info(dev,
> +				 "Device scrub rate(%d hours) set by region%d rate overwritten with device local scrub rate(%d hours)\n",
> +				 cxlmd->scrub_cycle, cxlmd->scrub_region_id,
> +				 cycle);
> +
> +		cxlmd->scrub_cycle = cycle;
> +		cxlmd->scrub_region_id = CXL_SCRUB_NO_REGION;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_scrub_set_attrbs(struct device *dev,
> +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				u8 cycle, u8 flags)
> +{
> +	if (cxl_ps_ctx->cxlr)
> +		return cxl_scrub_set_attrbs_region(dev, cxl_ps_ctx, cycle, flags);
> +
> +	return cxl_scrub_set_attrbs_device(dev, cxl_ps_ctx, cycle, flags);
> +}
> +
> +static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data,
> +					   bool *enabled)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	u8 cap, flags;
> +	u16 cycle;
> +	int ret;
> +
> +	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, NULL);
> +	if (ret)
> +		return ret;
> +
> +	*enabled = CXL_GET_SCRUB_EN_STS(flags);
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, void *drv_data,
> +					   bool enable)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	u8 cap, flags, wr_cycle;
> +	u16 rd_cycle;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
> +	ret = cxl_scrub_get_attrbs(ctx, &cap, &rd_cycle, &flags, NULL);
> +	if (ret)
> +		return ret;
> +
> +	wr_cycle = CXL_GET_SCRUB_CYCLE(rd_cycle);
> +	flags = CXL_SET_SCRUB_EN(enable);
> +
> +	return cxl_scrub_set_attrbs(dev, ctx, wr_cycle, flags);
> +}
> +
> +static int cxl_patrol_scrub_get_min_scrub_cycle(struct device *dev,
> +						void *drv_data, u32 *min)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	u8 cap, flags, min_cycle;
> +	u16 cycle;
> +	int ret;
> +
> +	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, &min_cycle);
> +	if (ret)
> +		return ret;
> +
> +	*min = min_cycle * 3600;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_get_max_scrub_cycle(struct device *dev,
> +						void *drv_data, u32 *max)
> +{
> +	*max = U8_MAX * 3600; /* Max set by register size */
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_get_scrub_cycle(struct device *dev, void *drv_data,
> +					    u32 *scrub_cycle_secs)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	u8 cap, flags;
> +	u16 cycle;
> +	int ret;
> +
> +	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, NULL);
> +	if (ret)
> +		return ret;
> +
> +	*scrub_cycle_secs = CXL_GET_SCRUB_CYCLE(cycle) * 3600;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_set_scrub_cycle(struct device *dev, void *drv_data,
> +					    u32 scrub_cycle_secs)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	u8 scrub_cycle_hours = scrub_cycle_secs / 3600;
> +	u8 cap, wr_cycle, flags, min_cycle;
> +	u16 rd_cycle;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
> +	ret = cxl_scrub_get_attrbs(ctx, &cap, &rd_cycle, &flags, &min_cycle);
> +	if (ret)
> +		return ret;
> +
> +	if (!CXL_GET_SCRUB_CYCLE_CHANGEABLE(cap))
> +		return -EOPNOTSUPP;
> +
> +	if (scrub_cycle_hours < min_cycle) {
> +		dev_dbg(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +			scrub_cycle_hours);
> +		dev_dbg(dev,
> +			"Minimum supported CXL patrol scrub cycle in hour %d\n",
> +			min_cycle);
> +		return -EINVAL;
> +	}
> +	wr_cycle = CXL_SET_SCRUB_CYCLE(scrub_cycle_hours);
> +
> +	return cxl_scrub_set_attrbs(dev, ctx, wr_cycle, flags);
> +}
> +
> +static const struct edac_scrub_ops cxl_ps_scrub_ops = {
> +	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
> +	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
> +	.get_min_cycle = cxl_patrol_scrub_get_min_scrub_cycle,
> +	.get_max_cycle = cxl_patrol_scrub_get_max_scrub_cycle,
> +	.get_cycle_duration = cxl_patrol_scrub_get_scrub_cycle,
> +	.set_cycle_duration = cxl_patrol_scrub_set_scrub_cycle,
> +};
> +
> +static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd,
> +				 struct edac_dev_feature *ras_feature,
> +				 u8 scrub_inst)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_feat_entry *feat_entry;
> +	u8 cap, flags;
> +	u16 cycle;
> +	int rc;
> +
> +	feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
> +				      &CXL_FEAT_PATROL_SCRUB_UUID);
> +	if (IS_ERR(feat_entry))
> +		return -EOPNOTSUPP;
> +
> +	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> +		return -EOPNOTSUPP;
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context){
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.instance = scrub_inst,
> +		.cxlmd = cxlmd,
> +	};
> +
> +	rc = cxl_mem_scrub_get_attrbs(&cxlmd->cxlds->cxl_mbox, &cap, &cycle,
> +				      &flags, NULL);
> +	if (rc)
> +		return rc;
> +
> +	cxlmd->scrub_cycle = CXL_GET_SCRUB_CYCLE(cycle);
> +	cxlmd->scrub_region_id = CXL_SCRUB_NO_REGION;
> +
> +	ras_feature->ft_type = RAS_FEAT_SCRUB;
> +	ras_feature->instance = cxl_ps_ctx->instance;
> +	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
> +	ras_feature->ctx = cxl_ps_ctx;
> +
> +	return 0;
> +}
> +
> +static int cxl_region_scrub_init(struct cxl_region *cxlr,
> +				 struct edac_dev_feature *ras_feature,
> +				 u8 scrub_inst)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_feat_entry *feat_entry = NULL;
> +	struct cxl_memdev *cxlmd;
> +	u8 cap, flags;
> +	u16 cycle;
> +	int i, rc;
> +
> +	/*
> +	 * The cxl_region_rwsem must be held if the code below is used in a context
> +	 * other than when the region is in the probe state, as shown here.
> +	 */
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		cxlmd = cxled_to_memdev(cxled);
> +		feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
> +					      &CXL_FEAT_PATROL_SCRUB_UUID);
> +		if (IS_ERR(feat_entry))
> +			return -EOPNOTSUPP;
> +
> +		if (!(le32_to_cpu(feat_entry->flags) &
> +		      CXL_FEATURE_F_CHANGEABLE))
> +			return -EOPNOTSUPP;
> +
> +		rc = cxl_mem_scrub_get_attrbs(&cxlmd->cxlds->cxl_mbox, &cap,
> +					      &cycle, &flags, NULL);
> +		if (rc)
> +			return rc;
> +
> +		cxlmd->scrub_cycle = CXL_GET_SCRUB_CYCLE(cycle);
> +		cxlmd->scrub_region_id = CXL_SCRUB_NO_REGION;
> +	}
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlr->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context){
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.instance = scrub_inst,
> +		.cxlr = cxlr,
> +	};
> +
> +	ras_feature->ft_type = RAS_FEAT_SCRUB;
> +	ras_feature->instance = cxl_ps_ctx->instance;
> +	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
> +	ras_feature->ctx = cxl_ps_ctx;
> +
> +	return 0;
> +}
> +
> +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
> +{
> +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> +	int num_ras_features = 0;
> +	int rc;
> +
> +	if (IS_ENABLED(CONFIG_CXL_EDAC_SCRUB)) {
> +		rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features], 0);
> +		if (rc < 0 && rc != -EOPNOTSUPP)
> +			return rc;
> +
> +		if (rc != -EOPNOTSUPP)
> +			num_ras_features++;
> +	}
> +
> +	if (!num_ras_features)
> +		return -EINVAL;
> +
> +	char *cxl_dev_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
> +	if (!cxl_dev_name)
> +		return -ENOMEM;
> +
> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
> +				 num_ras_features, ras_features);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_register, "CXL");
> +
> +int devm_cxl_region_edac_register(struct cxl_region *cxlr)
> +{
> +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> +	int num_ras_features = 0;
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_CXL_EDAC_SCRUB))
> +		return 0;
> +
> +	rc = cxl_region_scrub_init(cxlr, &ras_features[num_ras_features], 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	num_ras_features++;
> +
> +	char *cxl_dev_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlr->dev));
> +	if (!cxl_dev_name)
> +		return -ENOMEM;
> +
> +	return edac_dev_register(&cxlr->dev, cxl_dev_name, NULL,
> +				 num_ras_features, ras_features);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..d5b8108c4a6d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3537,8 +3537,18 @@ static int cxl_region_probe(struct device *dev)
>  
>  	switch (cxlr->mode) {
>  	case CXL_PARTMODE_PMEM:
> +		rc = devm_cxl_region_edac_register(cxlr);
> +		if (rc)
> +			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> +				cxlr->id);
> +
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_PARTMODE_RAM:
> +		rc = devm_cxl_region_edac_register(cxlr);
> +		if (rc)
> +			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> +				cxlr->id);
> +
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a9ab46eb0610..8a252f8483f7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -912,4 +912,14 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
>  u16 cxl_gpf_get_dvsec(struct device *dev);
>  
> +static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_semaphore *rwsem)
> +{
> +	if (down_read_interruptible(rwsem))
> +		return NULL;
> +
> +	return rwsem;
> +}
> +
> +DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_T))
> +
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ec6b906371b..872131009e4c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -45,6 +45,8 @@
>   * @endpoint: connection to the CXL port topology for this memory device
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
> + * @scrub_cycle: current scrub cycle set for this device
> + * @scrub_region_id: id number of a backed region (if any) for which current scrub cycle set
>   */
>  struct cxl_memdev {
>  	struct device dev;
> @@ -56,6 +58,8 @@ struct cxl_memdev {
>  	struct cxl_port *endpoint;
>  	int id;
>  	int depth;
> +	u8 scrub_cycle;
> +	int scrub_region_id;
>  };
>  
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> @@ -853,6 +857,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +#ifdef CONFIG_CXL_EDAC_MEM_FEATURES
> +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
> +int devm_cxl_region_edac_register(struct cxl_region *cxlr);
> +#else
> +static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
> +{ return 0; }
> +static inline int devm_cxl_region_edac_register(struct cxl_region *cxlr)
> +{ return 0; }
> +#endif
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9675243bd05b..6e6777b7bafb 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -180,6 +180,10 @@ static int cxl_mem_probe(struct device *dev)
>  			return rc;
>  	}
>  
> +	rc = devm_cxl_memdev_edac_register(cxlmd);
> +	if (rc)
> +		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
> +
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 387f3df8b988..31a2d73c963f 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -67,6 +67,7 @@ cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
> +cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
>  cxl_core-y += cxl_core_exports.o
> -- 
> 2.43.0
> 

