Return-Path: <linux-edac+bounces-3404-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD8A7285C
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 02:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41981841A95
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9D14A0B7;
	Thu, 27 Mar 2025 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYDxTkNB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845F19ABAB;
	Thu, 27 Mar 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040079; cv=fail; b=ZOvZDgXuL/ALFNexnRhl9qpQrdHXadOUD9+CmYemLd8wbeK3Tzq8FwwAty+MRjs/n5kPtKru7pyJ6uEsl+6JdOmRqACUSW7i5KYJq5tF1PsK4Bc2HnGMvmzoYeGDXsS28g46fbzHSxR5G/Bb5+HevTob5Eoxw7OZAIhhSx3nUio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040079; c=relaxed/simple;
	bh=7Irr8NK7G455uFpiRkXRAN9aSx3WYM2Ed8jy0336pwU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpaYFzNKtDF8WTlJcC8zOxCYs5dhmI+exnQcGlCAjgc/tr1ZZbY+yVijHY1XZpzhu2gWfFIHg5Z2K4klpUx3lnRH37IO2HltlkmJv66zyAI9cvXUaMsisxII6IWzjei9c+2GRv70EQHTwB9NUpACFld2nWje/frMkOZdgcYTdUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYDxTkNB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743040077; x=1774576077;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7Irr8NK7G455uFpiRkXRAN9aSx3WYM2Ed8jy0336pwU=;
  b=dYDxTkNBM0083zqGt56ywyuVH2HGc13cq3L8xJPftWn3kA2bjuHfKcNm
   y0MJ3h1cjltej8R+sK5yUshi64YWn16/6dxWmthB6fX1trbluk3mfrs5i
   Ae12/gPVlCHxdm99Fg1sdTxjWSW49MilZXlCCBgL5eMjM7sQ9q3nONek8
   zsijWxzHgzYWUcw5FEC5Xhg2CC6TDanvGF/33vCz2mrAgYghRK4Di+RIv
   yV/VLujfwk9eUhDDedla9RVdxVtCzCNG1a10G2+cjsFlVuPKnM8gxXncA
   fj8uHJ9Ra7GtlhyG4s+15I6bgFEEwByw4HlEkBtHD4C5TEAs52mWwUPJD
   w==;
X-CSE-ConnectionGUID: nZTlF7HzQ9aEk829ftsDig==
X-CSE-MsgGUID: gyi9AgzhTZqoCjoXOuDiBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54557400"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="54557400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 18:47:55 -0700
X-CSE-ConnectionGUID: xyb1D1KrQcmOrCu2u5+FwA==
X-CSE-MsgGUID: jkhFA3oCQwyDWVL5Yy6kjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125804260"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 18:47:54 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Mar 2025 18:47:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 18:47:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 18:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDz8eaWTraxNBn2a/wqDImDH3rwRxIMouqlNS00wsrb1fcrko7iHAeG0s2yo7z9yxhOTVCVOOcAHncL+YzyAf7J4X7NQf8dkc+pezqq8I7b0ZOxIutYPsA/skrIZPRcWBIJiYVAkX55FtUF+oXbsQhSUsB4B7olb1rQad0R2D1iS4sKSVqzoK4PmH3z6ui5UPJw2uJj+G9x+YNVFEJ5hTMOGlFhlerQuZrpazm/iUXMIhZHlbfPSbU8sqHAGCJnIRzbzXeZGZhilrEMOQMWyrUWPse1z11wvAIsv6J+/C47N1ZYeAkP2DoxTH5cXRRn/20A953G4BpcyFefoRH2rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpNRxZC1bYF4TSKaaICXxbsUw9Wbh9NrHE1z0kPV3j8=;
 b=VAPhoXts9E0WfNvx49fHmrzW/nT4lpAcb08xNzyn61LS0WyF+dwByK7SYMCGTppYG/d6KQs3dyzn6EHkmnJFkW2ayrhdjXdh22Gz8HAtWWjkQE8L2EX1/xpn2wMUNV7h5sPGUvP6Bej2njaNTPBlVKLi7DBBll7aitYFsOrTJ3GGMahaEmVVPkgNZ7vqc+ljvRQW0B0Q+0pnF8FWgdLsEpgK4Vl+b3tK6uCsD3uIoiMRHzxc5EJ6WK+lJRBoWTFuvU/pgv9cWcd6JMjB3/DgzE8xuXY3IjCSIk5bLxwcJ6tQY1ks3GpK5ZAVPBE6OGG5OoE6hhSH84WXogQyJHhxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:47:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 01:47:19 +0000
Date: Wed, 26 Mar 2025 21:47:08 -0400
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
Subject: Re: [PATCH v2 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Message-ID: <67e4ae1cb0cdd_152c29462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320180450.539-4-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: bc03042f-6ee8-47d4-3b39-08dd6cd14f50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lv0m/AZdiRhiOcdLTmiT4jIcFTL5/aEzpVI/0TVilgQEvOgG4PYo4jEdSK9R?=
 =?us-ascii?Q?13A+EgVbKyt+DpgOoX0NOf6v8xxSF4ms8BdkS8dr9kKxpCHt7aav8X7uf5ul?=
 =?us-ascii?Q?qH4tE6B9LR4MLAhKGMGe9lsIniGiEtx/hSDKv00laZZ26GZQX99D2xVUumRU?=
 =?us-ascii?Q?6Ks7qhGq2BIqCbLFOGb8SDKNd7XZ2MvxZVIOqDJ2QtA74PAIOTNYEXir3HGW?=
 =?us-ascii?Q?tQTcsJ8niIFq/iebg09n1qZBGdSKhCzVemJlq+2A0TkDUemxVdeziTJFGl6O?=
 =?us-ascii?Q?sffNIglnY+fCdDxbZRywOWhFPkgJS/+nENl2YyHYhQyLFhVWCqOyXYkeY/WX?=
 =?us-ascii?Q?ClQDuIzLLV4bfvJ2GNfdYff9HdY/r7J8+3mCWOpRq+1/qN9BbfGAeZ7bVW17?=
 =?us-ascii?Q?DJ3lJoJBOkHqhhQDyst45LWr7tmVwG1hlM/YGVZ59/1Lhsl3tniuGrsHNM3j?=
 =?us-ascii?Q?4B3sFsgTqa3CfgWYUGTf/jjEbDv02Fsd5MB1ox9870CKmoEeyE+3UBAMe+3e?=
 =?us-ascii?Q?esXIhPwBKbKeoa+2Ti6ZropZOiLoczOMfvoC+/Az0OVtVo40TwypcDHaekMw?=
 =?us-ascii?Q?X0/2NwVAH19Y5KTQQJ8QslUMJVV8WCPoKM/WxpOwe88hPA1rVV39anzeRJzk?=
 =?us-ascii?Q?0GDOV803ky9YeQ0ldffiNLSp6zVwgWqOzPnq18RXhBVwXjJM+knWm4uodspa?=
 =?us-ascii?Q?xXsPm/drgt8asOi9hqkjbxZSaF0843wEWF0V7uV3P2aRyi0lQycnPnhhjEVM?=
 =?us-ascii?Q?poQ7NrlscjY565PdtiR6t8wmZhN/sZrliYchG8euQVr89XzyClDp9mMRNN87?=
 =?us-ascii?Q?Ok5wp3KYemCF+uIWwFNnMNph1r81lf4gyldhmTcQr9MLeMvJ5jpPudhbMWCu?=
 =?us-ascii?Q?4woO1h7PsEGAUfid7hQTJZkuLf0GTG3FDsN3uVsuvFS5vTGLzgx09cKZcglh?=
 =?us-ascii?Q?HoxHtA9l/NxpoyF5MpkI6dFe23085fMnZdRzodMc7EcFAMeEdFzxWOgEO7OO?=
 =?us-ascii?Q?DidMpT+QyWt5SZJoUxrq3k/2SDE14XMDraGj1bJfr3G5X2ho0QPEgSiOEGaN?=
 =?us-ascii?Q?f9POTmMC+iK8WQUrVc1EBb9PJquWkwzzvB/LuRGPynho8OqtYwk1fy/JApPd?=
 =?us-ascii?Q?3tEbxSqwrQOVRuT/LE5QxuAYFB6L0Fq6WZDgrbps2qwt2o00mdUC2vJwrEG9?=
 =?us-ascii?Q?V3sKABVNoikqLU6CrFP4jhjSvbzQRmrcRV0Y6j8qN/b84lyGLnibeuBemAp7?=
 =?us-ascii?Q?vN5ycEolVmzWoQfXgrYvooKp/ad3r0+8PP2BVSYiW4MbgBRijRN+xBlnOwET?=
 =?us-ascii?Q?HvE5YTFvjIcPCTudZRtv4rGYZYoVBj7Rwp7AFfugBHGDk8dWpacVAigd/ubE?=
 =?us-ascii?Q?ICtVvj3R9bWqR1Rj9nyXlPDaKaxePkHAxgy4IkMhbV8q7JqedSbJTwle3Hyv?=
 =?us-ascii?Q?lAr4UyUwQ6fhprCOLQIKuI/asa4+epUcqeJylvgaNzVyAxKTd1fz1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IozETgtEwY++yn2DAcD8x1UjD7HM7BpVQzCBZwidq8yjlq7hraVWpRysoHc?=
 =?us-ascii?Q?HJ7M0EAk9rhXzmwcWA0DzSUkBy0S1hHDPFi47r5qt8/2fWCGhJbJizFnGKZw?=
 =?us-ascii?Q?6eZTADLICV7LlPPu6DfAuAyS/iNdWSwA9I38wdBdqcD7cLvwquZ1p92T0fhl?=
 =?us-ascii?Q?FeG4ufmwS+gytnaTPjo3QLq2O4X9Q+VFoOWFWY/HChzNSOWV38Vwmmtr5ALr?=
 =?us-ascii?Q?nMIgIpjXH3NSW7H1V2OWYy3jyW8BFjWaP/x68ybahLwdu/DvVOcd7JXz8R/r?=
 =?us-ascii?Q?bb1v1A9+ryodwYrk2vS2yP2qdi/jYkryphQaiKkkC6Oo4dCGkPh0EXmi/MYI?=
 =?us-ascii?Q?nhgBB06WLJWl4ZTzBhUD5AoLTDOdAj3unNYQT60q+clmCOJkims73Zm20QAs?=
 =?us-ascii?Q?vISgVSt9I56W99aPayximiDw4l2WgaeQ5V+sFrVDZuTIz76Onhg4wmr0hWYd?=
 =?us-ascii?Q?kUbcKeRbpSdt3ppBLIU7xL3HaMoZ46c/PtjxpKpcKZe4B102CcE8YzeYpKr3?=
 =?us-ascii?Q?1rf5uEVjQRwiamvfC8DmfaTHxBzwblpXFAetAVa0VdNA/NEFrO+WYtMglOGl?=
 =?us-ascii?Q?ctbaVBiC65k/gv0zhzWgKds1bugkobBLL66DqzOMmV9F4sEEdir9JNzO/iFI?=
 =?us-ascii?Q?D8jCXpsTlHz3UntYT6V4uWEFvdXyFDIPFwP/E2V+VM4WTEEKbw4fRqjOMr/b?=
 =?us-ascii?Q?mG8k3mmXHRsJkCfcC16kDeVObpdeasAUDABd8KPXfadSWqUqrSLJrHdHrMFF?=
 =?us-ascii?Q?wvjBpXDTcfnWaQaMvWG6zSAsZZiL01WKON3q7sHbUw0psEYxQlkJh0VvKLyx?=
 =?us-ascii?Q?egmIgK+1W+53j56dmFYcvOPmZ6J6+xHCYJov+VaugJsy9GTa60SY0tpkmpkE?=
 =?us-ascii?Q?mfBTd3K+1SoKe3nrFs/RtgN75mxxDYhgHt8Rj6Z3MJc5DAv4GkTtnfz8Qoj1?=
 =?us-ascii?Q?DxnS71mHNjJVI4n9ANomd6ijSuoFFOdWy3dD27E9vxtjKl7u0i3NpvZSnyox?=
 =?us-ascii?Q?nD7o5N6Yoklocfhg5dmxaL8any2j0bqxVM6qGQ4lRxFP12es9xPGGMMwMx5h?=
 =?us-ascii?Q?/wVarW4fZJvYJYn1Cl4TYTc7zObOniBYxIy01FHCwioc9620gSAI+cVXC3mV?=
 =?us-ascii?Q?VwTVQnmW4ym8q5T5BZOdUtVH+mcGkqZB4MAq2xEaOE7jnXwO/QUxKZXtH4wu?=
 =?us-ascii?Q?3qz7spMzjeq8Z51JaPudhe6Hr2zodPwpLyuGGR532NFtN6OAZBxdhCcJyBX+?=
 =?us-ascii?Q?kE+26mJ9/PcF1K3wyOJRm0t0It8GHReTasz/o58Rm+XZV0bGruoolTOGydD5?=
 =?us-ascii?Q?XKm5R/pzZwOOKHWa5pKnq0AdWZ8z/vT97QDlP6oDKvStiPM5nkUzLmx+gTj7?=
 =?us-ascii?Q?AMQxqb85kH/HD4NAYVe/FGefLKw1WmD2BUN6vCQF+IE/+MyJ57c84UN9oxpj?=
 =?us-ascii?Q?x1Rv+qPDvT1eeEB+M1nzpRRMWdsutsDc5f0EYyNHca2v40j8fdXIK3VUmimb?=
 =?us-ascii?Q?53xp6JyGrj6/XiNeVFRawAvyednIvU7gjtXC5CBNzaN6GQ9lwh9fOEOo3B+P?=
 =?us-ascii?Q?kvMB53SVu1KxrWTA4EisJp2ZqVmu36LxHNwxZVyIsltGCqjpWGpfv4LOsGSm?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc03042f-6ee8-47d4-3b39-08dd6cd14f50
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:47:19.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STvWqv3BavjWjMPXzRsjyI2XjuIAihpwAp9z4uZhOvGRYIZgSgcAXnXYI715IXpHrDTBYyXlzc99eopyVkRFsBJ5J/SeIMZF5rhRzI8qLQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> control feature. The device patrol scrub proactively locates and makes
> corrections to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Add support for patrol scrub control on CXL memory devices.
> Register with the EDAC device driver, which retrieves the scrub attribute
> descriptors from EDAC scrub and exposes the sysfs scrub control attributes
> to userspace. For example, scrub control for the CXL memory device
> "cxl_mem0" is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/.
> 
> Additionally, add support for region-based CXL memory patrol scrub control.
> CXL memory regions may be interleaved across one or more CXL memory
> devices. For example, region-based scrub control for "cxl_region1" is
> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/Kconfig       |  25 ++
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/edac.c   | 474 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |   5 +
>  drivers/cxl/cxlmem.h      |  10 +
>  drivers/cxl/mem.c         |   4 +
>  6 files changed, 519 insertions(+)
>  create mode 100644 drivers/cxl/core/edac.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 205547e5543a..b5ede1308425 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -113,6 +113,31 @@ config CXL_FEATURES
>  
>  	  If unsure say 'n'
>  
> +config CXL_EDAC_MEM_FEATURES
> +	bool "CXL: EDAC Memory Features"
> +	depends on EXPERT
> +	depends on CXL_MEM
> +	depends on CXL_FEATURES
> +	depends on EDAC >= CXL_BUS
> +	depends on EDAC_SCRUB
> +	help
> +	  The CXL EDAC memory feature control is optional and allows host
> +	  to control the EDAC memory features configurations of CXL memory
> +	  expander devices.
> +
> +	  When enabled 'cxl_mem' and 'cxl_region' EDAC devices are published
> +	  with memory scrub control attributes as described by
> +	  Documentation/ABI/testing/sysfs-edac-scrub.
> +
> +	  When enabled 'cxl_mem' EDAC devices are published with memory ECS
> +	  and repair control attributes as described by
> +	  Documentation/ABI/testing/sysfs-edac-ecs and
> +	  Documentation/ABI/testing/sysfs-edac-memory-repair respectively.
> +
> +	  Say 'y/m' if you have an expert need to change default settings
> +	  of a memory RAS feature established by the platform/device (eg.
> +	  scrub rates for the patrol scrub feature). otherwise say 'n'.
> +
>  config CXL_PORT
>  	default CXL_BUS
>  	tristate
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 139b349b3a52..9b86fb22e5de 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -19,4 +19,5 @@ cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
> +cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> new file mode 100644
> index 000000000000..5ec3535785e1
> --- /dev/null
> +++ b/drivers/cxl/core/edac.c
> @@ -0,0 +1,474 @@
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
> +#include <cxl.h>
> +#include <cxlmem.h>
> +#include "core.h"
> +
> +#define CXL_NR_EDAC_DEV_FEATURES 1
> +
> +static struct rw_semaphore *cxl_acquire(struct rw_semaphore *rwsem)
> +{
> +	if (down_read_interruptible(rwsem))
> +		return NULL;
> +
> +	return rwsem;
> +}
> +
> +DEFINE_FREE(cxl_unlock, struct rw_semaphore *, if (_T) up_read(_T))

I know I suggested cxl_acquire() and cxl_unlock(), but this really is a
generic facility.

Let's call it rwsem_read_intr_acquire() and rwsem_read_release(), and
I'll follow up later with Peter to see if he wants this to graduate from
CXL.

Also, go ahead and define it in cxl.h for now as I think other places in
the subsystem could benefit from this approach.

> +
> +/*
> + * CXL memory patrol scrub control
> + */
> +struct cxl_patrol_scrub_context {

I like "patrol_scrub" spelled out here compared to "ps" used everywhere
else.

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
> +/**
> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
> + * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
> + * @scrub_cycle_hrs:    [IN] Requested patrol scrub cycle in hours.
> + *                      [OUT] Current patrol scrub cycle in hours.
> + * @min_scrub_cycle_hrs:[OUT] minimum patrol scrub cycle in hours supported.
> + */
> +struct cxl_memdev_ps_params {
> +	bool enable;
> +	bool scrub_cycle_changeable;

This is set but unused. Even if it were to be used I would expect it to
be set in the cxl_patrol_scrub_context.

> +	u8 scrub_cycle_hrs;
> +	u8 min_scrub_cycle_hrs;
> +};

I do not understand the point of this extra object and would prefer to
keep intermediate data structures to a minimum.

It looks like all this does is provide for short lived parsed caching of
the raw hardware patrol scrube attributes. Just pass those raw objects
around and provide helpers to do the conversion.

The less data structures the less confusion for the next person that has
to read this code a few years down the road.

> +
> +enum cxl_scrub_param {
> +	CXL_PS_PARAM_ENABLE,
> +	CXL_PS_PARAM_SCRUB_CYCLE,
> +};

This seems unforuntate, why not make non-zero scrub rate an implied
enable and zero to disable? A non-zero sentinel value like U32_MAX can
indicate "keep scrub rate unchanged".

> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK BIT(0)

This CXL_MEMDEV_PS prefix is awkward due to overload with 'struct
cxl_memdev'. Minimize it to something like:

CXL_SCRUB_CONTROL_CHANGEABLE
CXL_SCRUB_CONTROL_REALTIME
CXL_SCRUB_CONTROL_CYCLE_MASK
CXL_SCRUB_CONTROL_MIN_CYCLE_MASK

> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK BIT(1)
> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK GENMASK(7, 0)
> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK GENMASK(15, 8)
> +#define CXL_MEMDEV_PS_FLAG_ENABLED_MASK BIT(0)

CXL_SCRUB_CONTROL_ENABLE

...no need to call it a mask when it is just a single-bit, and when it
is both the status and the control just call it "enable".

> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol Scrub Control
> + * Feature Readable Attributes.
> + */
> +struct cxl_memdev_ps_rd_attrs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle_hrs;

"hours" is just 2 more characters than "hrs", I think we can afford the
extra bytes.

[..]
> +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
> +{
> +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> +	int num_ras_features = 0;
> +	u8 scrub_inst = 0;
> +	int rc;
> +
> +	rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features],
> +				   scrub_inst);
> +	if (rc < 0 && rc != -EOPNOTSUPP)
> +		return rc;
> +
> +	if (rc != -EOPNOTSUPP)
> +		num_ras_features++;
> +
> +	char *cxl_dev_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));

if (!cxl_dev_name)
	return -ENOMEM;

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
> +	u8 scrub_inst = 0;
> +	int rc;
> +
> +	rc = cxl_region_scrub_init(cxlr, &ras_features[num_ras_features],
> +				   scrub_inst);
> +	if (rc < 0)
> +		return rc;
> +
> +	num_ras_features++;
> +
> +	char *cxl_dev_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlr->dev));
> +
> +	return edac_dev_register(&cxlr->dev, cxl_dev_name, NULL,
> +				 num_ras_features, ras_features);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b3260d433ec7..2aa6eb675fdf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3542,6 +3542,11 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_PARTMODE_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_PARTMODE_RAM:
> +		rc = devm_cxl_region_edac_register(cxlr);

Why do only volatile regions get EDAC support? PMEM patrol scrub seems
equally valid.

