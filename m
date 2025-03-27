Return-Path: <linux-edac+bounces-3409-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9AFA73A4C
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA118972B2
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CB1C6FFA;
	Thu, 27 Mar 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO0KoO8i"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF88224F0;
	Thu, 27 Mar 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096210; cv=fail; b=e2RvDOpMtZ+rjn9YRiPw0O/opTHZgbNnhAwHP7/6FmintLOahR5nm4EiA3vGmOnP6iOiMRHXd0FX5UDwxfSmzSTBrSTGnN7idMs499+BQ7ZffMaPlEl+cq/sjHX5/BCYxQLfHZoR3oBNkis9gd/Rh33pdt4TfWPXoIV00Emghj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096210; c=relaxed/simple;
	bh=w4bzhobDHjLJvxs9hcKv9TxmhDMhTGIcMZMqzBNsYhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jRAOkJNYDB2Xm4ktPUUxfj4NmMpXJmBeuSUiXSGFxVXPoF4Of9QHST3NsbuZo4qAdTay5aP+5DTxK6GF+z1U+vdsDP3gIkYN2cLl/lwIeWrKO6ydsL4KkguwyELQ9Rj9TcPbmwU2jGuVNy6wkYrdgUxitdtcJ4Iq7iJCk2tf08w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO0KoO8i; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743096208; x=1774632208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w4bzhobDHjLJvxs9hcKv9TxmhDMhTGIcMZMqzBNsYhM=;
  b=SO0KoO8if8kue5LxO/MUs2h0VtgXqLKuIvNvn9GYcjBpSosvc9gwE66A
   pedOH+X24Y7h2xIC97Mh8J6ZEH9OrsjllhQatWEdyaiWBGkX7n7TWHz4d
   YVGlMIdafcj4bQdoTaluVq7cQiCy1hHnEvbgjCRFRbZR0cO/j1/P4IrDp
   40B2EjvU0MnelsnS0xI2BAaIb7HrWE4SsWjQHK8lYSTVeQkLrsvdCyxf8
   lpNE88+HP1gPOFU83Pnznk0AlgF5gfwsCdyOrYHENGA9ymnGblfQLAO5L
   eZ4lE7MATYys+XWzLyxO+D2BznCRRl5e1wKCNkyZWkCvfA+w87oak9Tnv
   w==;
X-CSE-ConnectionGUID: SAoEBHWuT/uFMh/E1nKWQQ==
X-CSE-MsgGUID: 8X6reYRVQr2T8f6lGnMaJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61840151"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="61840151"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:23:27 -0700
X-CSE-ConnectionGUID: /pwDaOj/T/KxS5+9Q5xkug==
X-CSE-MsgGUID: YVcjEO8tTb+8+qabjktAGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="124954972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:23:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 10:23:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 10:23:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 10:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQlJY7+D9mQSuWO9B2pvjUM1NVa5HdvaRspX1/3qZZmzPkdqEJeEtqKoQ1S6FFwm6qV0epPdEDKLdbjzT+FmoioU33XvjOq5C6FBdqpWvTe5k7QKp/fnTNU3Lc9+PRkLdTcc2Tmp6f3TSD9ntCPnq12DX6IrC1xEiQB6E/+tdA+eD8t7Fxhp6WW3jiyHH2PX+2v4+Hz4Nk0PU3/qW4WVvuvj4gMLWWEQr+2T2b3/hqKNMnM47OrJfIyzeJMvAb9SbByEFkomyBzKakh/95at5+f9ppHSmFSNcvbB2kHAFMInX5jG/PjSkbA0NT8EAa5ZH4wKQEO/GItKy3MqZ6AthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhsXuIC3O3bveKAIbEo07zJricBTPjQ6AEUkX53XyP8=;
 b=bc+DdcKCHO1sMc2zdqlhZkvkSNN166EqVkeqAStHIrWt06z4VEXbFeggfAb+3SzmmadgvCeXm+jcod3XROtdrN9Tixe14cAyBePKKNfoOHKOW7CbOuPtcHM6FvGCXMQgxJf1E0st3CsbhImztw01s9M04SkLWqnvnCcXf1phlv9c3go7I1PWrQgNs4oITYMCbJ+/S6g7MWZ5Vgu+2ibZ+QKY3rqv4jBCiYux6wVDgLKYPjG8jwpoVWPQknA0Va4RJ+ZWcPrh6NPBDDbSsIUMq2qB+338rDcY8Svvw+xw4fCWk7UCHUN6Zz0QkYg41dqo6gv/OPHcL60Zc6VgT09VDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:23:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:23:22 +0000
Date: Thu, 27 Mar 2025 13:23:13 -0400
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
Subject: Re: [PATCH v2 5/8] cxl/mbox: Add support for PERFORM_MAINTENANCE
 mailbox command
Message-ID: <67e589815e91d_13cb29455@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320180450.539-6-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 6692a9af-7356-4796-82f4-08dd6d541302
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hGThsPB35uDMlaQduXL6H6duquulJwkSfzmZOSBYtbuLI8VL2kNTRKZ+bEKq?=
 =?us-ascii?Q?ciSVFJznE/CfsgDte3IN49f1Ui4FXp6NRIxv3CFnpNPpwSrBrKmLLR2PT5oR?=
 =?us-ascii?Q?tzP+Yso3Wcahvyn3NgH4VF8zx/xneUfFxhsbP7I2fjGr6sngTIlCGZmrnDzY?=
 =?us-ascii?Q?ubE1YHZdY9V6loo9+GKl/HjW4g6MxXJJW4s9crghS5ZUUO4WTiEspiQznsn5?=
 =?us-ascii?Q?dvrZtyviT9CdH7ctsT6BjQOi3zVTDk6sAWOezbIFVXr3OiBc1dFD+B8BxYh2?=
 =?us-ascii?Q?YEj2nxOfiLhFq+bcgtaY2zS8WEgmO24sbT1J0ABgeehJ3J0+F2djAW+1jF/1?=
 =?us-ascii?Q?Y/eywGxGOxhlFZVrhqDiWGV/WPJCxqgzbUqCjSzTXWGipr1q8TRRZMW9KPL7?=
 =?us-ascii?Q?LPZT93yRzG0SHx/1GHlEaWpcyFPdL5QgwNNQ14yRtrNl573jsZ0GFGkAUWG1?=
 =?us-ascii?Q?qfR53VbWeuGafiLkpRP48vQEZwIdl+met+x3t4lchkACAAxnpnw4Pwst3EPP?=
 =?us-ascii?Q?3xp9Kz3/JcYVPFoH7gJ+OBe3YDs4XRu45j3hudLrE3NSIKS+JZjYaWl6OaKQ?=
 =?us-ascii?Q?/jcUxhMprVjsVpvcA+V60Hyh20mTw2x4F/zREkOX/dpdITIuEfKIl4AmUWvA?=
 =?us-ascii?Q?rxsLVxXRsohJmY1NWFCSm61NB5vuCNMrHzA6Utj2jNcAXiIH+WrldnFyfozG?=
 =?us-ascii?Q?kXhwKW5fIGHk0hgY6DAacPjiA/fCyPS5WcqMuh3dHM3shbngiF+pFVu8nIlJ?=
 =?us-ascii?Q?WiDiIiLYU4oCDeFET0lHCvVEhARDBU30lZx9IdHCCQlxoRjTJl6eVJDJ7qYe?=
 =?us-ascii?Q?fSHvW99p3fe2tAMpyD7eAYZ6Rvii7+U25q3xIMfOuih45ixMebHz8XgCbmKf?=
 =?us-ascii?Q?Opdhxo1KQ52RWmU41vOK9H7/y/aC4x/S26cZQRSB9mvKrc1SKuDBAKOj9QLv?=
 =?us-ascii?Q?QLEwE+7eS62rKrlx/KIbovzmZxadKMJuJ54htVhTq53S1sQUAAHMDefn9x8j?=
 =?us-ascii?Q?HLyea6mL49DaiWy58QsCPaDQMW2rK3jtbCW08jWzcODA+3u86V3Tc9xwEfLp?=
 =?us-ascii?Q?BQWjsY+s2jBXfZuKQ8XEGfSYGCXfHg17MxjZA3SPsSdPQbPFusSZYZnsXEcr?=
 =?us-ascii?Q?wNteIPmc4Zqt0hybmLbvk1gK6TFTen4jOobAaPrGlZzLPRtW0fSvA1opxRzx?=
 =?us-ascii?Q?9RrygCpUKAMi+tVrvOn3m1tuTCfwtIQtTTKezeF4ORDKMjwRJWnrQhDRIGGh?=
 =?us-ascii?Q?GajpXUFaoQppPllB0r44K64WAzFp+Avnh/h5nBV01c7XfgM7i6qsokSUakCq?=
 =?us-ascii?Q?XHtdqXzSE5Jnn2e6flq5lb9GJzafGamTQzkFOyt88mFGdWQqSxt38b0WO8Pw?=
 =?us-ascii?Q?ptzC75AR/UFszdfcj/Y1D657Q6/7lYnntnOHvUaLkxig5Xtz2cBRG9WUnHvu?=
 =?us-ascii?Q?EbTchE0Qixo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YayMM0lJRm53HQqbShA1KYMrXKAHx8DaFYD8A8SaMQzNyJjHnJdG07BMggv+?=
 =?us-ascii?Q?Halnm/yEmeonbMyHBA+EhjQAC3UQ2xoWftTLC4eLvAS5fKUoLSTa4jGpNjEx?=
 =?us-ascii?Q?I9jj8R87E2lAnKhMpb1UIyey7tQSHWIWI/M2ZBiNNGiAXgz0KA6JdZx37L8w?=
 =?us-ascii?Q?CQEyNO9sO6cCShrqTdbBcEK5BSk+UaZbWw/LQjBmab0Ib8L2megWl8GgVBvY?=
 =?us-ascii?Q?+IKq0dbx/mPEGNwxTmLH1OOxZ0Oz3yd07fhPA7U2WFtwjVsx6bbQ9jU89nSL?=
 =?us-ascii?Q?Rf0vkpW/9ZiEvqyIRaA05SFMSPrJm2NZURSQgL4AvZrgh5O+uKBnNca6Jpd/?=
 =?us-ascii?Q?XNX+pdkP+zheiZL1+z84Nqf2egmsKFD+S34cJf7vR6ksRBMLaiwXS1oueI8O?=
 =?us-ascii?Q?pX0cZMmTjgrT16Gn8YAKDxTyTPPiLySKwGHEwX+MPuJ4sRlDhCGQEojraW7X?=
 =?us-ascii?Q?kcz9yz2t+1lZjwWlLfMq/3CvIiy7iemDSUwlCdgksf5z8EtXBL0qcbkRsgH1?=
 =?us-ascii?Q?ZWDc2qYIev0DWlPDPaBQPVwGN1zYEPXEgIHW9U3WyBWYTjENuLY9PPPSnI3d?=
 =?us-ascii?Q?A1ctib//z3j/aW9XN0fqTy2pMH/9VlkhK7vz+YxtHU26Ail2cPdfkfHOVV4/?=
 =?us-ascii?Q?dYDXPIJyeN/fCFSgG9FGXHMYGCGGJ7zFNgvGahkWUL6Xv5JrA/ri5Ml40YXP?=
 =?us-ascii?Q?9FKWE0rCm/Qc1+doy5d+BwfFR3xPq19pnZxobaCanZoOn96M55+Rf1Uz7b3d?=
 =?us-ascii?Q?Fb/fzsfOSFoSiczRXOneEq++/JPrRbqBb5l9L0K5nNxu48f/KCK27qp9tq7A?=
 =?us-ascii?Q?ZgCjJ2CKd9mKrmTXEWGsPIebxpoCVq3TIJRzSuV/YjPi73/VgUvKTpgXt9A6?=
 =?us-ascii?Q?5FcDCSuA7osxXq47fpMcaAgWQ+K4E/5FJAeOSfhrbyRblkUhHkaIfXhTpnz2?=
 =?us-ascii?Q?6mbFzw97ZFhugwF7rXfBoWpyQJPHq4KFBEklCtmQcqHj1jPPp7vwpwiQNrUa?=
 =?us-ascii?Q?LUAkFaGchPb/vFevI0/uBRgOmdvLZhqbmS9itkz1DAG4ttG4XRA9dz9s0tpF?=
 =?us-ascii?Q?FoUGkSVaHMpSg3/APTZGKXz6C0MyIU9CWUWuyuNJD567vIlWmzu1NChZZSdx?=
 =?us-ascii?Q?DjJe2Den27W2yuY4b/KOeMbWoTFO+Gc0GYXESibrQKeRaQMl4OYTXA2NHd0K?=
 =?us-ascii?Q?qSDg1iwAD7rbq71DydrpHKtrXLMG51SI/Ijx7bpovJOF6PBvSdyzZaC1lIU5?=
 =?us-ascii?Q?LJienUEmkP+LFvo9SiPYZA/uh2FCWdUUNF2gVIxTiQHx6UYhj9Hf3bFDDkC2?=
 =?us-ascii?Q?R3RQRyQOwtyVctvB4YpmLPstEG/KvLM31d/AJEv8QHt2Lld911u4vJH+kDY7?=
 =?us-ascii?Q?5pBtgPuc0JY1Js4uPHc+kviD7rbuXAdw9CBpA4HEAIGRLsEvjhIv0dwJ+RMi?=
 =?us-ascii?Q?0uUJDHLIbM6TSr3dc4ZESEVVw1Vzr9z7Zwwr93hIW5jcPH57YLlRA+0t14vG?=
 =?us-ascii?Q?0LB5SzHOvK3uXWBdlKjRde4UPLII4Q8onxqPku4nISjPhx1qcEyZ8D8arDou?=
 =?us-ascii?Q?kOJ7V8AZprBTNXddKA7KEG9zY3097GeQxlVDBTxemgmbiEhn48FqVju3ijNv?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6692a9af-7356-4796-82f4-08dd6d541302
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:23:22.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/S0c2diEFK1dSgFp3ypLo3m6wHGWtQkYkafKkMKjzAFcXH3JZ5uDM/6F9Dx5K89T8KXcBUDdiYoixkqyEcLMnlEpNHJ8CbL9rZLz9McELo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for PERFORM_MAINTENANCE mailbox command.
> 
> CXL spec 3.2 section 8.2.10.7.1 describes the Perform Maintenance command.
> This command requests the device to execute the maintenance operation
> specified by the maintenance operation class and the maintenance operation
> subclass.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 17 +++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..19d46a284650 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -824,6 +824,40 @@ static const uuid_t log_uuid[] = {
>  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
>  };
>  
> +int cxl_do_maintenance(struct cxl_mailbox *cxl_mbox,
> +		       u8 class, u8 subclass,
> +		       void *data_in, size_t data_in_size)
> +{
> +	struct cxl_memdev_maintenance_pi {
> +		struct cxl_mbox_do_maintenance_hdr hdr;

Please call this "perform_maintenance" because "do_" is usually a
Linux-ism for a core helper.

Also fold this patch into the caller that needs it.

> +		u8 data[];
> +	}  __packed;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +
> +	struct cxl_memdev_maintenance_pi *pi __free(kfree) =
> +					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);

s/kmalloc/kvzalloc/

	if (!pi)
		return -ENOMEM;

> +	pi->hdr.op_class = class;
> +	pi->hdr.op_subclass = subclass;
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the maintenance data transfer.
> +	 */
> +	if (hdr_size + data_in_size > cxl_mbox->payload_size)
> +		return -ENOMEM;

	-EINVAL
> +
> +	memcpy(pi->data, data_in, data_in_size);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_DO_MAINTENANCE,
> +		.size_in = hdr_size + data_in_size,
> +		.payload_in = pi,
> +	};
> +
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_do_maintenance, "CXL");

Why? There is nothing in this function that needs the rest of mbox.c
beyond cxl_internal_send_cmd which is already exported. Just define this
in the only object that needs it.

