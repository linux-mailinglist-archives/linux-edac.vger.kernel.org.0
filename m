Return-Path: <linux-edac+bounces-3948-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAADABCC8F
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906E4189D3C7
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBE255F4C;
	Tue, 20 May 2025 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBPNZQzV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9A1DC9A3;
	Tue, 20 May 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706555; cv=fail; b=NqLDKr76O7h+TMfIWOypQPJ/LUj8wJpqEcILr60OSPv7VXLFYUA34GK3iKv4L6rCT4sjtnDTWbWha3B4nQn9T9kJAu57VlQBu/YcDwfwFsTeskGc4zXlKkdh7oqqc82ywQ95lq024N38sWFIIBXapAGCsreBIXlK1sV3GVMcjxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706555; c=relaxed/simple;
	bh=GLtXzhHHvQvCVsl/MMjZ+YvB2xbln9yVdotOKYvx44Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W/QjBTppwDWgBPT+lyBb/m6VU/Agfhlzs2uZpwVIuYNxxtm5TnTN29ktiW2FjfHzR9c9rmvfslA6JOMEq0/Qw12J/NetD5W3QbltmqHo8SXxksmSCn00gF9g/+1s004bx/sk+KPzntAyWzdepMtvTtlF+MxrJ/10ulB9pVtihsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBPNZQzV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747706554; x=1779242554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GLtXzhHHvQvCVsl/MMjZ+YvB2xbln9yVdotOKYvx44Q=;
  b=nBPNZQzVDz6kNKPngPmeeQw8XeUc2zfQOiuCWV51ql2VFC04M5mjo771
   spiM3xyAjqmqg9WoXFzJBlIFn+gsTJelSpBMfFocCLqfqRjGmSYZkPime
   l/CIbpNOANKq0uv47rdWertRGWCqwgYLCWcrAyWFsb1lN5WFOhg0V2Klq
   ykpwtTTcIoeXP3V/gyX73Dac0muKJaarxFoohDP4/mNVorG63f4qCJSnk
   uqEoDGwbO1ReTOWQsbdnRnaIgcH7cig06WXtQIQmFACjeCyR10B70M1Bv
   s34ifmytldqtbInh4VAV0JxDx8/fwscmmAjte+jBwCQXQY3gCmjeCH8Ah
   Q==;
X-CSE-ConnectionGUID: cNRmLuJGTpekj73bZ9xHtg==
X-CSE-MsgGUID: 55Jy8Wf8S/GAjFzd73ICfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37242059"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="37242059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:02:30 -0700
X-CSE-ConnectionGUID: dw4TNAWGTwyVxdc/A+OKqA==
X-CSE-MsgGUID: XIiKeZ8eRp2T4IAQptg/4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139432764"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:02:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:02:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:02:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5lYieEW6eBIpHRfrrTEbUYqwGR3m3nYf2YBVxrdhtLiEN8Uh10fQocXh2o7bX0hbcxpSlmbUwLZyp5z1C0BLFi4EZsKm+2Kb446GRNwI/xIoUkPgr45/M1Mcg12SkbxFeF/D6Uxt5AfJ8wk1RJVdOhW5/EwtgwYyx2sS22tSmoOjaO40LC4rQZQl3PTALQwmQq6zdgLUIF2E/keUoOWaSQ2bOYz+7MiOYUXXrW4QngUdSFPoS9T8Beox+wwD3PbSkCacAfHaB/iLaaDu5L4723y/sLQ2nEPRVTGEvXWOKtfckevOgyJ5NqcJEfT7EAXsaWdLUCzRfiIHIH2WGsGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJA9+z600Rx7V//y8vYpUKGbfKNihsc2zGMY6w7ivpI=;
 b=zMNz81MccofPSM8QQuQSkC+22Tjoo1fcHYYHH+JeKLnluLE6+LsGQozTJZz7T0Ay+3Ten2JEem4P/KbzUDqN7sedL7RqZEvl5rjKG29o4nEQARsqO2DT8icD7k/PREopqQlwGDPoGQ4aHVIIfJ4t1Ny5Vz8m0PbAsoLJGCGZebcYbL73x+QmTQaaVGkwvyOmuGOFwtIhdGVLts0qZI3lLMBLHwOBK01rPYvm+lHPaLV+PX4hcSZU0k/EnaUx6GbXLtu1LuC8uUEZRSavWfs/rlLsed48dO+ufl+vmjDcbE9TFaQl5HXD4wKm08r34FrTDX2djRd/QixnRM8hqPF6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:02:26 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:02:26 +0000
Date: Mon, 19 May 2025 19:02:17 -0700
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
Subject: Re: [PATCH v5 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Message-ID: <aCviqcNwQCUokZhl@aschofie-mobl2.lan>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515115927.772-4-shiju.jose@huawei.com>
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: e82e093e-7ad6-42df-4c55-08dd97425e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X3LgZbb4XZkWjhkZtmV8HEJrFkFYJ0mVAC1wwAtDIa/ykAt4lQMlumgajFWb?=
 =?us-ascii?Q?Ry0b5WdUyxwR/lgrufT/IJGQei9E/GC33pBPPpa+PFAtyrFiFkFDNHhjdVOk?=
 =?us-ascii?Q?3lSzpXxEHMjQo68Bwa2Wh2nPSwuy1xjbyV4VwD7lTHS3y67of6157eS1JoM0?=
 =?us-ascii?Q?4p8g4W8PdX05RwS5GJPs7RBILU3TU2ubnQ/kXqoUcc4t1rd3BI8kGcPv3rX8?=
 =?us-ascii?Q?3uQRPvQWWxmuclxvTLppnRIltPRye3JRqqCr3QaytXhNjrom85rnu4aoAOvQ?=
 =?us-ascii?Q?K+POUnb4TSxGo8YV8sfrv4ed1z8sewheQgMSkPfIjKHeHYkCZOZanfL3mNfg?=
 =?us-ascii?Q?+FQsq+iRmU843GzTrOwSkdYlSrAmf8AGJj95RYkBJH0+9eT4a76oSbdvfczw?=
 =?us-ascii?Q?/DNbflqhjCSb3Ui1uzF2HkROrbWkORtYfCLDVU3yeYWNrD9+Zj4MpHNHyyGr?=
 =?us-ascii?Q?AQCIT4hKmBI6SBYh7KjkcoJ+CEasesdWYAMMr2RC62lhoiSk5/1/U+hcfCah?=
 =?us-ascii?Q?VdgDD7bquC3L8wyQGXD30IU7EfIVelTZE/4okzKgt/A679deJBl2iBYqUj9A?=
 =?us-ascii?Q?EEAd1FKTGTMq5Zxqj6q7shA/YreWgzHkbpVGjvykGaVC9CygNC53RnqK+4sZ?=
 =?us-ascii?Q?m4N6dz91m458p2CMNicqbPiAIPBt/RGkFjlyIJP2c6q4eVMzue/yQEeTbOz2?=
 =?us-ascii?Q?7NNcD2nHv5AVmDoD+MI72wevOAIYcPwjhUpJkBJyCXYijR36XnOR/LWMOzXL?=
 =?us-ascii?Q?9wG0MewjWJmDKMfjlCMAqLND8qpp4h2h91lUhwWLl+LxHPE474mnmsTH97+s?=
 =?us-ascii?Q?5snR41oRt4veXxztFFmBJ34pWUCUCMJT296EQvOxkJQ7T5wblIppSWmMzaWZ?=
 =?us-ascii?Q?Ofe6X73NwG57KxsURZRT3cHUdMI3zRtujtvOzaFpgJPsAmfxV6CC7rgVQ2sD?=
 =?us-ascii?Q?NAOZ4+w9JkBlbKWdfQAUTW6DzUFzfIMMb4aF7/2cz+4+hePGZxYI1gBKIXND?=
 =?us-ascii?Q?+I2rO5gJ2KVRYWYf3MSoPBRm5KAonZNp0w1VddaMC+3mFixFTs5rhecFoJpC?=
 =?us-ascii?Q?Wf6e/R3xf5QXpIMnLYb0o1ZNFOfTUwrvrRQVTYy7L06tCZCnHuHjqxH6fJUU?=
 =?us-ascii?Q?RX1e6rsBAC0dLE+dm0PB3UWa33vxKN6tqe4BWwNSgMTspaGKLB5ELRHzQrm0?=
 =?us-ascii?Q?kF+GaoAAnxPqZWjBU+UDjNT8SnfAzJuhvUJZkCErUi69ZGSuBbSoDWvYFPCP?=
 =?us-ascii?Q?1AHqrqN9B0Y+n/f8aZ8G1F4yXsO6kL2/6pFmGM+T9hJCfF7KWiVnq98IUvte?=
 =?us-ascii?Q?mezFktXNZdnCTLoZw2BdIojuMK/QnUevgMMCwpr9I3lpI2EV9858bVW1+UMq?=
 =?us-ascii?Q?pwOTXCqqGhytvH9I6hvuN17uiFIM1qGcB12Tss3/40eenI222qrbwpdCjpDP?=
 =?us-ascii?Q?okVvopd68C0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqg/GcN9FbM22cfhDRkQqLGunPi/lhK56o3zZw7Z3NIkUNEjnusOStntoW50?=
 =?us-ascii?Q?09m2NNEQ9w90Mia6UTu/bMDtCR3CkuWCzBdBv3Vu9hqIU3/KsD83NU8mUI6U?=
 =?us-ascii?Q?EFZwe5zKWWsjX2S1KKKv8LNjHyy6K0MIhqkkzyP0Fybap9+g03Y1ZkOL0Q3L?=
 =?us-ascii?Q?BT9bjWcpD4hrXc9utzVuHmix2+4BHC7eT2YaThW6rs22ECLtmgD54lWp/vr5?=
 =?us-ascii?Q?LoAJrEm5McCt+ClEmd08x4h/BJKlp4vXI/aWMMvZtXC8VCNkewFqYcsHijPK?=
 =?us-ascii?Q?pgMFNtTXOfsDQqgVn0fTKmbnJJfwZp/wY0izbGTvXJLdmNPo84vo0DINX5ht?=
 =?us-ascii?Q?c+b8bxvGpL2io4T4871KYuT2RDEkv8O24CiJkgig2J6G0y4e90VFD0uLDoOd?=
 =?us-ascii?Q?yxDgAq//fGOJTETJm10ieBb6cdIWitt0+CuXAm/RlFLL40YjrBOFHP+GuqU/?=
 =?us-ascii?Q?jApQ3bz3MduHBew+NAjtsHwufk9zgVzY3w9Z40hMstwAgvMT2hV5REzoVjub?=
 =?us-ascii?Q?0xGPRIcTVgOpIORBnQ1GSPtP3kDeJLbBCsDGEhaoQHlTD56NiqNjgDHmuKDD?=
 =?us-ascii?Q?kUat8J3kUbYI/RyxdI11fr4lpAP8RUtbL58C1xahMUdCZBrQiUCRysuNUE/R?=
 =?us-ascii?Q?zCgLZcKNoZuxblLRd21B+hqo0NqXfq1VdFC/uGqV1dPemWwqYoz1o6w5QKUN?=
 =?us-ascii?Q?namoEST8V5tBEjgOK+nuWSDuIXsDrYJNfnw+Tg4l81G6k7/smq/U1/sYy4IE?=
 =?us-ascii?Q?tuWHtdG8Cna4eRwZ1ox0fwuQu8ztM6h9wkZnj6nuKaod58PJtwoxGIVRg4LW?=
 =?us-ascii?Q?A08Z9UtXvN6nWvT1pPc3D79dYH0+QqMWzPtgbe2iTGJqKDpbBkyKC4/pQuWe?=
 =?us-ascii?Q?mniy/RcVPPw9YXba2FzzSzUOuJaw/J0mj/9mV1KvduGLkXHITtMsVHOpfY/N?=
 =?us-ascii?Q?mdTGLH4u7g7uv3boPqfccp9V6QNlmH+IixQ/JVe7R8yylsDD4mzUlKar1z2l?=
 =?us-ascii?Q?53HpV5AvapNG73R9wKSynYht6bXW2kITBVwsm2SUuEnVQTMcy3dBZxgZfMrr?=
 =?us-ascii?Q?+Wc+SiQneuWI7Xb2NuRukJqDWcpTNtchH5mRBeIrVWawaMN/8EeP0Re9vtBD?=
 =?us-ascii?Q?lFbudKsQxKyzCLSpG3GIw/GU4YfFt89z22SDLZH2SPpcKSawoD9K8RWQdgcg?=
 =?us-ascii?Q?xZWDNTRT5DEj5H0SgAwHO2HBxMtU8excnIuB43C/FHGyIBn6YIVE/51WV918?=
 =?us-ascii?Q?NTlLLSLEq77wTUJU2GYI7kY17v+qsmQmMWo+I0XYb2RS/sFjkkoupPoBigt0?=
 =?us-ascii?Q?t3MzPihmqoPTlhGsQGWSjyMrDqdohYNiE9MV3KjqSy65uiaVHMk52vLVi7L6?=
 =?us-ascii?Q?Zs04SPSVg/8YnvPiQu8KJcseRmALyfW+7g34K+FwRTUElA9kwVdEhY/1eDTM?=
 =?us-ascii?Q?w+2Rh4yeA54uB/GqKeYoh1dIVISrJxQHCW4Ln1QgycxUeeC5fg8Hw/Gw1sQ9?=
 =?us-ascii?Q?f2ZbE9BUUi+rhzt5WDn+WIftuMKQM5hz6bRQt1meNu2wH7zkhuYuLh2sriuQ?=
 =?us-ascii?Q?8QWsr1IbDdeD/IMsAJzW+mgCcn49FXY7pizpcuOm+cqNxYO7U0v81GrnIck8?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e82e093e-7ad6-42df-4c55-08dd97425e6a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:02:26.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAUj1G+tPdgdt4Noe5MGrc6EYLzEqu38ZAHZdYAzGDtWz5zCFByk2bKk6PiwAZSpSXm9sQgeK71BDtkCq1Nqvw24mMjBcNDM4GUYCjix4ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com

On Thu, May 15, 2025 at 12:59:19PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> control feature. The device patrol scrub proactively locates and makes
> corrections to errors in regular cycle.
> 

snip

> +
> +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
> +{
> +	struct cxl_mailbox *cxl_mbox;
> +	u8 min_scrub_cycle = U8_MAX;
> +	struct cxl_memdev *cxlmd;
> +	int i, ret;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;

This function and the next, have a big if { } wrapper around
cxlr existence. Can this logic be reversed -

ie, declare cxl_region and cxl_region_params in the header and
then do something like - 

	if (!cxl_ps_ctx->cxlr) {
		cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags, min_cycle);
	}

	cxlr =  cxl_ps_ctx->cxlr;
	p = &cxlr->params;

Then all this code below can shift left.

> +
> +		struct rw_semaphore *region_lock __free(rwsem_read_release) =
> +			rwsem_read_intr_acquire(&cxl_region_rwsem);
> +		if (!region_lock)
> +			return -EINTR;
> +
> +		for (i = 0; i < p->nr_targets; i++) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +			ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> +						       flags, min_cycle);
> +			if (ret)
> +				return ret;
> +
> +			if (min_cycle)
> +				min_scrub_cycle =
> +					min(*min_cycle, min_scrub_cycle);
> +		}
> +
> +		if (min_cycle)
> +			*min_cycle = min_scrub_cycle;
> +
> +		return 0;
> +	}
> +	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> +
> +	return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags, min_cycle);
> +}
> +
> +static int cxl_scrub_set_attrbs(struct device *dev,
> +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				u8 cycle, u8 flags)
> +{
> +	struct cxl_scrub_wr_attrbs wr_attrbs;
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_memdev *cxlmd;
> +	int ret, i;
> +
> +	wr_attrbs.scrub_cycle_hours = cycle;
> +	wr_attrbs.scrub_flags = flags;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;

Similar to above function, but more work in the !cxlr case. Maybe a goto.


> +
> +		struct rw_semaphore *region_lock __free(rwsem_read_release) =
> +			rwsem_read_intr_acquire(&cxl_region_rwsem);
> +		if (!region_lock)
> +			return -EINTR;
> +
> +		for (i = 0; i < p->nr_targets; i++) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +			ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> +					      cxl_ps_ctx->set_version, &wr_attrbs,
> +					      sizeof(wr_attrbs),
> +					      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> +					      0, NULL);
> +			if (ret)
> +				return ret;
> +
> +			if (cycle != cxlmd->cur_scrub_cycle) {
> +				if (cxlmd->cur_region_id != -1)
> +					dev_info(dev,
> +						 "Device scrub rate(%d hours) set by region%d rate overwritten by region%d scrub rate(%d hours)\n",
> +						 cxlmd->cur_scrub_cycle,
> +						 cxlmd->cur_region_id, cxlr->id,
> +						 cycle);
> +
> +				cxlmd->cur_scrub_cycle = cycle;
> +				cxlmd->cur_region_id = cxlr->id;
> +			}
> +		}
> +
> +		return 0;
> +	}
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
> +	if (cycle != cxlmd->cur_scrub_cycle) {
> +		if (cxlmd->cur_region_id != -1)
> +			dev_info(dev,
> +				 "Device scrub rate(%d hours) set by region%d rate overwritten with device local scrub rate(%d hours)\n",
> +				 cxlmd->cur_scrub_cycle, cxlmd->cur_region_id,
> +				 cycle);
> +
> +		cxlmd->cur_scrub_cycle = cycle;
> +		cxlmd->cur_region_id = -1;
> +	}
> +
> +	return 0;
> +}
> +

skip

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ec6b906371b..685957b312ea 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -45,6 +45,8 @@
>   * @endpoint: connection to the CXL port topology for this memory device
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
> + * @cur_scrub_cycle: current scrub cycle set for this device
> + * @cur_region_id: id number of a backed region (if any) for which current scrub cycle set
>   */
>  struct cxl_memdev {
>  	struct device dev;
> @@ -56,6 +58,10 @@ struct cxl_memdev {
>  	struct cxl_port *endpoint;
>  	int id;
>  	int depth;
> +#ifdef CONFIG_CXL_EDAC_SCRUB
> +	u8 cur_scrub_cycle;
> +	int cur_region_id;
> +#endif
>  };


Why the cur_ prefix?  Seems like it's just 'the' scrub cycle.

How about:

s/cur_scrub_cycle/scrub_cycle
s/cur_region_id/scrub_region_id

That also makes it clear that the region_id is related to the scrub.

Somewhere later cur_region_id gets compared to -1 a few times.
Perhaps add a define for that like #define CXL_SCRUB_NO_REGION -1

>  
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> @@ -853,6 +859,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +#if IS_ENABLED(CONFIG_CXL_EDAC_MEM_FEATURES)

that's the one I mentioned in cover letter that can be #ifdef

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
> -- 
> 2.43.0
> 
> 

