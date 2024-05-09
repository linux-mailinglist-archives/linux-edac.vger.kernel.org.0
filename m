Return-Path: <linux-edac+bounces-1026-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589108C184F
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 23:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFC0286A05
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 21:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04E126F2F;
	Thu,  9 May 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is9C+lk6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993148595F;
	Thu,  9 May 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289705; cv=fail; b=Yb67kDqatoQ8vR+ilVqoOsbGvxmmmpAWjs/ZZt80KvSg9xkb0/3pvuxy62GAOunPHU7M8FFqCZXjqt0HyD7IGrKIAtVBnokim+Oye8BMc/v4dMzcAFNdD8hM4sG0hIJALBmAiBQJklYaWlBaHt4+GPw/oMmwbpIanM3LXx9p9Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289705; c=relaxed/simple;
	bh=rPfCwgoL+onHcpfaszo6XDGvIj5veYDPdhZJaxpD5QM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OuWSoZt4FyozyMyXbW/XGlrFOMXFn0DEHw32XXqcXyxbG6D7Eiyvjyeberev9OrWdsUnnObBkxcWQUXpW2Ilg1jSIx5iAWWjrsX08LKtdV2d1k0zODuO+6gAX/m8GQhNIP2iuoiwAlat33f5HzlmKNeh9xcjL8j3zCV9AEVhBoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is9C+lk6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715289704; x=1746825704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rPfCwgoL+onHcpfaszo6XDGvIj5veYDPdhZJaxpD5QM=;
  b=is9C+lk6jHmifbL2UbHF2pkGAsHbJrPvcfbz10VWRq/HEm7lDtrlEva4
   2s/lkg3x05BCWmIsOBgTvBF/U0DHOW3buoE7ogMKYYJHamfJHmoHOwJnj
   iPQvUQqXSGPSilj6RRHbUR9SrKpi3kU2BnbPjz/YVRHUJzmPdwiv0gRmz
   dhrMu+TMa3hHq4zrSh/aMgPGlKdM0a5YMz90sw/WrH59yjMgt7hg8C3MQ
   P/nnlYLbzxOkM6bLenajeZ7XDgzNWeGpP85YjzMLQq8m0PmtMBOpNy65q
   okcinHWfuD3743UZZGGMHQjcHIC1vDC4hrkBXCeb8m2En0HHWYvaAU0ms
   A==;
X-CSE-ConnectionGUID: feO+se/7TN+YPHJOWfTmxw==
X-CSE-MsgGUID: ePsm0c9oQfeDtmia8eudbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21914061"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="21914061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:21:43 -0700
X-CSE-ConnectionGUID: W2oAiiCtTEaQRJbYUQo0UQ==
X-CSE-MsgGUID: Du+XHcfqT26e5iPwaiI28Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="66825303"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:21:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:21:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:21:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:21:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIxbhZzp1OFujaD5cydc9uhHBos6VLUDc+5Ek9+L1LPe660OEUbzQIAZCNP4+cafqLpG0Gm+RhPfVS0RjvX2f8/8IRENL1+puQHnH3Tjhpw3Ho2dqVd67nNLnYLysuZPjXipZAvMsQgVy8QN8xixLAYP8KVCroPeraQkXI7WUCEkGApowtuQqVyx+XzQilQjhjnWCXG9YQAG9G4mI9YsR04RH4Xpu1Yqaf3ucddoaAkCXB1TIx7uszfuaXG6OgOi70/nutmRSGaJDmCF6z0k0vyBCMGvhBmwUdkh2R3mtZUOC+Yx1yyTsdAzYGQ8leUIaGYW1sTsiCOB5dq63tvSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LksOm5/nsFoXZ0l4e3aR+GCDF//5JkxivCkcfl3u44E=;
 b=E2k3jbkWrw1bDHvlylTFbSXwsWabfnK7+Glm6SaRA/RK0tSROt0sp4TUCCjVsL+lwysBWLHlp9CAb3Sg512u29Y2Hf9gRBF9qo9cN7vgQ2RcsTs9oV4NIJ+3koDwGe94YskjXRsU4hjWdXgsgoTa/GsDN+O1UKwbKCie68Xcl53Jyf1KtpV3VKHsgXqbtb/sQr0I1eFxnCplTFZPdXF8AcEyiB6GoME5+d1vQPjEkaPqTKvbW2a2/uT5TUYqXVoU0/IpCAvzPxWen+/OIPrYO0PxKHW6hPHXlkDY1T43m3N1z/Ykf16Xp22Zr0ybh9Lau3OJuYdLTsqrkotVrDOYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 21:21:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 21:21:33 +0000
Date: Thu, 9 May 2024 14:21:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Borislav Petkov <bp@alien8.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4e4376-556b-48de-2ced-08dc706e005e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRnbZyZ3tlWfPY9Um54xbAyoZjP1M0k6DLF0DyxnaK37eDOa/ruptsNEgoc5?=
 =?us-ascii?Q?76z1VT6kFl/Zx7R85bfIFSXQO8Iv3CZCBwRg9hM3MEH0RHvgCaqiRyXPirJE?=
 =?us-ascii?Q?OjL1jolwc5xh9cxMYGF2p9cVy5qqtz79dSjTR/hRnYeNeOct2K//sFqRHfLd?=
 =?us-ascii?Q?PVEamF6Aj2NMWMCOGF8vCQc8kdLNta79+Hhj75vzYN97XKS2eu9OnYYHaABM?=
 =?us-ascii?Q?coPcoMc3I0WkZsEUnooyrUoBr1ExJf0ICjaXP1XMWpjF2iHVeXvBABIgkEQ0?=
 =?us-ascii?Q?Tm09w+KAjDCSrXb9WEQNNsvX4/y6QcUgL91YDa1p+4vSBvgna6TBZfiUy2dZ?=
 =?us-ascii?Q?VQc3oulv3bfskQlGe3kFzNJ1ohkys6Xlx9jNSdye3r5Rc6OwyUZY7b+LnyQu?=
 =?us-ascii?Q?FlEeVBIMQfUNLnS+ka9/ZLoIF2fQLAY8sye/HGz1EY/6m41MoJI4jy69CVyE?=
 =?us-ascii?Q?Chc77rK48O1YdtUgAEraMbItkv2/8tsg8bRoGwew4F0EH+YMzk8dH3+HKXDF?=
 =?us-ascii?Q?0XZJtnAN/kPsz6DBVFCF1XGOhZb8VrLMl6/89c7QIaff5TkdVr4zE1Mogj4U?=
 =?us-ascii?Q?l5TPw2SjGLeNUxoTZo/m0XIGUa96tU2lJRrsnH8Wh+TNKxupVoD55tTRF+it?=
 =?us-ascii?Q?0uLohymNOm83gtIsVga22c98SGH6iAi2lsIkWjwfgZ/4z7C1bJtXSJmWrxZV?=
 =?us-ascii?Q?EyNWRPGF5VmfXRYT+AaDVQVoBA4IT22Lu0YmIPzAre/fe9SkBWywQW1hCTis?=
 =?us-ascii?Q?C3wcGvHENe4prf6rvpYC0Fg++wZwO4voTc2Z22LUw0DLU8FISBS5phWuExek?=
 =?us-ascii?Q?KGdpKn/hmVr59lbeMY1Rs/MYn/zxP3/Ur3gvxFJJ/xo2JVRxdy8VI6j1HUTz?=
 =?us-ascii?Q?ZglUDtouUl46Byd0xpK4DGwEckrBfiE+xU+7Dwx8NvxP3laFgwkUsE+jpk5A?=
 =?us-ascii?Q?EJEpRH9eh63Cys2wLdg+8EA2pBhS9831m+xjOkBJzer66RGNPffXVM7WFkal?=
 =?us-ascii?Q?XsdWldT6l0OFv37tCE/Ay+WnYWeJ5NMxAQ7U+Jo+UQQdXkdMIma1sOtWuHS2?=
 =?us-ascii?Q?czVw6w37YkY1Y6vWngWqDenGwVH+0LX+Mt7AoDSNAgkw1eSISWSEOV/kVV8X?=
 =?us-ascii?Q?d8BVITjT4W75m5Wq02n3ftMGPcASgBzbUvLl26pKklAKOGbBajmyit5XsayV?=
 =?us-ascii?Q?UXSUV6McWbUp3E4Pw6u1jzUTbjYNP88whzM9GvClwGCwUescejQ7gOxDJair?=
 =?us-ascii?Q?07DpKJfRWDY2dQjkA0rbCzMC0UGmh3jbUPjlfrLwYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8v33joibrc9hplfQsaKUXT/5Sk6twiLHZkfoSUIrBrarKOLwU0O5PHHZcSp?=
 =?us-ascii?Q?MeGvMcIVLZqv2vWNSm3Xc9S/JzeR80G5loKIY3TmcCcV2yoV8XnU3rQc2cc7?=
 =?us-ascii?Q?+koTxS5QAbSn6VY4VYeRdHBgWOjRDEbD5UUOHNQizxZAE4N/tyO0yuFrtRUx?=
 =?us-ascii?Q?LLrwA+7vDVMdaCRP8V4ooLSB3x1UI7TvPgYLSKoBj3Q2TqVt1t55UonsnM7W?=
 =?us-ascii?Q?+U21SRC4l8gNQbfrbM/u6ysoN4eM2cCe8glM1iChxKVYmuv+vQrTdurzaQUz?=
 =?us-ascii?Q?R4iHV5o5q4FApABovQUY+J0xmW/iu5nE9P66fdEiwAecOdL8BPBfFqrtRAyR?=
 =?us-ascii?Q?t7IvgqMSpTnDcag5O5mjlUfCjucKoWPkvsV5pHTEr+p2KooV5MlCftEjnwQs?=
 =?us-ascii?Q?9XRbob+jN+9vBsq+WnpzAl1B7bVfQer+GFpgPPF8E5txZap7rYBl66gLd85z?=
 =?us-ascii?Q?7xUw0isSt5nNdTHdNyZldFZTby+Qu8CAr+FBZif2nAwnpdcnwRuUyI4nXYAg?=
 =?us-ascii?Q?ioLpWKfvipGoG0hodNvwBTvZ3KqtdJptEPR4cYwbEtoGLNr5DFRhmBKDEUMc?=
 =?us-ascii?Q?Pxq3fHgy6UVzbvYBAVNTLwycV8HMjpDOBx/yAlmgZCKs1HSzrMhOnz+xUVcv?=
 =?us-ascii?Q?enhTluTgfeFS0AN8wuLsGatKi3c5amp60OjKBk9cpXpbKPVasOCD6tuRDMsJ?=
 =?us-ascii?Q?IiH4NUWbmE6iH93NdihPyx9cZ2C+QYjkzuEb63qqCmbX+tJj2qmu7th6FbJr?=
 =?us-ascii?Q?GyRyqKy7FoakuQuGeXhOoNuQUqqrNTDfvkCxn1axzZKxHf91Hf5XX/BwOtDK?=
 =?us-ascii?Q?5WMHJCObAJ9CPZk1Q+xiL2yknnKQPCMNlQFLPLRE+2hNgIdmamlMy/cZjcz4?=
 =?us-ascii?Q?IaUkPyVUuIh8IXY8IVk88At9Ipb/Hia1pro24xzevMtxTO5F3vYWFvxoHrmq?=
 =?us-ascii?Q?lbZWPMZonwQzN2amx4ORHhzYcipGxNakT8rne7sZSvG0CiwAuBfUzs1jPprh?=
 =?us-ascii?Q?RaYnDs3x0sr4LBOZOQMEgtgMS8dNXXQxkgD0RFiRuOMJrHiOqtSxHxiZY4Ok?=
 =?us-ascii?Q?VSQtsqnU/w+AACEyCzNr4efBaliDIueQ7OSoL838Xvg6VR9eeH936K7dX7ZB?=
 =?us-ascii?Q?xlaxaSA8YZAgW5iOTq5tmmEy7NPsNYcxve0SeQKSbnU9sVu59ckUNKbFtrrx?=
 =?us-ascii?Q?FfiuDwgRLh7BaDQ/fTdHdCzUsIMsrHUauEdiQcX/124+Y5YkLgF4zku2yrw9?=
 =?us-ascii?Q?ihGZvN43qJtQOLgpnLVpN+WB7FUw7xBH917JBxGaCsSD8iUtSg+V9FI4Jv8R?=
 =?us-ascii?Q?bs0T1QFm7TAV4a9cGx6P1meMz+QCclT4BurrsC6gSlPjG/ksGlBDUhIVUZul?=
 =?us-ascii?Q?txX4mH4K3lfSbRNpghzNoRld2L63fCSFNd1kjEzbqn2pX0zNA/Nnib5VPowp?=
 =?us-ascii?Q?ZGjXwHlMrr5WiwvuEp8QoRseL8f6vZoQbvmckcJwLsDTYGKujluvcGsmFW23?=
 =?us-ascii?Q?pjRuWOp4gIPh2Yb0BKfFdP4B9I8daXvLwxR3lqg2LuUjjdJcVtkXI/YIVLZk?=
 =?us-ascii?Q?YITgiEVQsBJeD0+dtjSEcBRHXtI4LuWnNXRJu7Y+qxmQQtzYejRI9W9Ped8f?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4e4376-556b-48de-2ced-08dc706e005e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:21:33.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eexRFzSX7/uMCgWAgiBcIzDjvT5PGn0HlUuV/XOYUF7KnxIh3hpDGtnGYtc2Sb9dTcsKeVZfnnjecSI0q1keOyopLHV2RGpSkqLp9fIVogo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
> On Thu, May 09, 2024 at 05:52:18PM +0200, Borislav Petkov wrote:
> > Are you arguing for the nonsensical "it should load" case because it
> > is simply easier this way? How hard is that "jump through hoops" thing
> > anyway?
> 
> Let's see: the following patches add something called
> GET_SUPPORTED_FEATURES which is used to detect whether the system has
> patrol scrub functionality etc.
> 
> Then there's ras2_acpi_init() which checks for a RAS2 ACPI table.
> 
> Are you saying that checking for those two things in the init function
> is jumping through hoops?

Wait, this discussion has gone off the rails.

Recall that there are 461 usages of module_pci_driver() in the kernel.
Every one of those arranges for just registering a PCI driver when the
module is loaded regardless of whether any devices that driver cares
about are present.

Consider the case of the PCI subsystem that allows dynamically updating
the device ids that a driver attaches. I.e.

   echo $id > /sys/bus/pci/drivers/$driver/new_id

...the fundamentally does not work if the module unloads itself and the
driver(s) it registers when the PCI bus core finds no devices to attach
at runtime.

The mitigation for keeping unneeded modules unloaded is that udev does
not autoload modules unless a PCI bus udev event matches a module's
published PCI device table.

Don't want to waste module memory? Don't load the module.

