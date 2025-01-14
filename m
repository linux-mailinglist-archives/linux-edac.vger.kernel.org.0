Return-Path: <linux-edac+bounces-2907-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6765A1113D
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 20:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9585A3A3716
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1D1FC7FD;
	Tue, 14 Jan 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlGSc+iH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1371FBCAA;
	Tue, 14 Jan 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883334; cv=fail; b=UYNOciG6BgZAwSB0QzBxLghsp6DxGO/KTQIEt6EZOB0Jjkdje1zGResFYwjfa+ABMjnrAYXx8FX4MLW2+725YyTz6U4xjxqv36WcpB/sNsExme80q79SZ3VnXa5+5Zeg3g6p8ZPPb5JyEkBjjUMvaYxHHENOxqZ72l8fxFOaZfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883334; c=relaxed/simple;
	bh=WS6sROPQzF5xK4mZQe1ii7xP7JbUysPGrN1RK5kZ/eY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWbmJv5QRu7PLotBAn3Uk5Le6fSCerHI9IeeDLcmZDVyrmnXYPhtEhw2vWS2Tfts6eePvImKKo82ez//2l17cInWlRgiubIBOVIYjNnPvWKD2NHDFpNLjiHEfMeaKLm8UMzuddvVBXpTjwefjhKHux058/Zx7aKSJSfWfzJBmDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlGSc+iH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736883332; x=1768419332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WS6sROPQzF5xK4mZQe1ii7xP7JbUysPGrN1RK5kZ/eY=;
  b=dlGSc+iHuwufnmgd5Cxp6kkc/u4lC7WJ1WuIstgGHB6EPrn0fgQQ0uqL
   DxsMJRujeJRVXFmSg2ZwanisoVe75mfrmO/NcVxHF2RjVVISLZiuCfb/I
   2R03BiSY93JOfekazbgPFdW4QnFmuOVvXZdGAbZmvSN7uvmQoIBq+6XvY
   4ZHQyikEcq5/VpUJUiEa4b3VUj6bBZYrKg6iyNMDFIEmBr1KxuoQZTUUm
   syPKjZcpN4j8MaDHsSIGICPGXJOSPaVm7ETEOnfck4wAEBJVR70tsoyEC
   kv3zVuJnrIQmnty51lhA2Tu3blxI4+iak0VGBLFmp7wF1Bp3/HaVWAM9n
   A==;
X-CSE-ConnectionGUID: i34rWfSpR4CNxqa3hzkemg==
X-CSE-MsgGUID: 7x/V/63hQl2hNwZDmAy0VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="62567916"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="62567916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 11:35:31 -0800
X-CSE-ConnectionGUID: 6/RxdHCATVGvV5BmE7HhLw==
X-CSE-MsgGUID: EkZo8CWiRXqlmZKNpAZr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135730286"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 11:35:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 11:35:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 11:35:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 11:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdOGO0Fj8+npRjOl6iq+0KOrZik/knDYEFjR2jm9QmW5FZ0SiXyixAx1Db86P6G6H4O8HhY2uFNzt10NjJYgVKkPD30ToShhQhgaVxCVCbClLFBOdIHquQGaRvEshTRmdC/OYzyag3eKD2zIEYjq2QV7DIhUr8HbU8D73vI1WRIpERNryGBe/wjveuQaWJt+10FLrykg5sXo8dfFcxVizut4nyLg4E8IOkvqhbwSxa73W9FMVAn3e1Nc4DMeS/FzFEK10IMkTrRZvNNDq6K3dOa8O1FGObL04YsJ4y0xEfo2QFyc1tM9EXU4wQ/vTUxXN+64EIWMG7n32tb0gKxQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2vCqrmegP2XwrmzsVvxjs1Xvroa9zlBWmMdx6BzIyU=;
 b=ab8gNqw+5j/lnU7uBsUI2imAODD9OcF2gvBD3F0d60S2XRXpUJC04l8ZoqSFo1tYQ1CI3FOxkhGM8AbvUe7SEdYC1WLAG7fcL6A5NbtEENzXhXxH9jqiwhStfpobphDbXweqsFm7coW+2mueJPQYmkwtaiVCRhtYXORb0fzsgkWFrlBY3V51iIoso/Bj8jFaSN+seZtinPn0mRTCMybzElNAgV6GL16FMtJRgYf4gGuMQ8mZgIrXFLpQm7IxbzuX2DltdG+LtD3RerhBTYV3MbQOAZXTszqs2814r8J3ba0CpC8ImCZk/gyPiEAIXJJepg196RERV35kfBxEKqV82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8060.namprd11.prod.outlook.com (2603:10b6:510:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:35:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 19:35:25 +0000
Date: Tue, 14 Jan 2025 11:35:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <6786bc792c66a_20f3294ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
 <20250109142433.00004ea7@huawei.com>
 <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
 <20250109160159.00002add@huawei.com>
 <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
 <20250109183448.000059ec@huawei.com>
 <6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20250110110106.00006cd5@huawei.com>
 <6781a3dfa53d6_2aff429471@dwillia2-xfh.jf.intel.com.notmuch>
 <20250113114026.0000548e@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113114026.0000548e@huawei.com>
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: e4886a98-d043-452c-2df2-08dd34d29803
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+UYWUBagPGtFYrz3b32mKQ2qKVDZQhPbQKNFluXZTJh7Gd+YXj30Cxd2VnYk?=
 =?us-ascii?Q?2Hs0pRomoCqW1w8XFbv7xFdC55lnxyR9sNP4V1Cl8TATAI3BqEywJAayqm2U?=
 =?us-ascii?Q?Y5H3xJm1Gl33DGfgBmTcDhDuOzeJW0RMNrCHmvBGr5IPxtQBYylPiwc91oiJ?=
 =?us-ascii?Q?gPi4vzjpw0VhGEZjgU04kBlDJDDIUfJ91LLWykLNuzPV5LcDPpnA/Ais8joQ?=
 =?us-ascii?Q?Op9WwDrIxYIJpdkoWFMjhy0B9t15WyUTGm5/kvEiQ7FgRtSAA/7p7UXqKPOx?=
 =?us-ascii?Q?3DEf3m7bg90D618xIwgG1UaAXXg7ncVFkO8RK6MFR9yfhA90lejJqHhu/NT7?=
 =?us-ascii?Q?WclcTBiNvb5EO9/epHzo2sPQBBJ2v+uYylDDMCOR4e/QioDfmbND437pXhbC?=
 =?us-ascii?Q?89rvCwo/ugD51dme8Jk+zUquj5Pt4cKmMpAqpxF2VbGs5jScggRUnUVuXJ00?=
 =?us-ascii?Q?MSkvm8sICOm/gCNFI30PcInn+aGY0VQLVOZvWo9/zMJqo1UgA5cMjiIm+82q?=
 =?us-ascii?Q?ZQN9uQoXWBXTXXMfC4DxzTlfE3s+pIpjIxdEzI8Pm42GlQIZwa99CgF+3P8G?=
 =?us-ascii?Q?Sx0Ko3ViYFReJbCAIKFFHDZMQguc9UQHu9C63VwWr+xbbXDoTI92SuG9rXvj?=
 =?us-ascii?Q?OsKAQbk+TBsYoUv7drHfxLgtWZBVeayQoQBiStcmAQKTODG2W85vZLBV4khJ?=
 =?us-ascii?Q?HiDhaaaYsAmkM+V6aEa5fEF2GbY/91oY2SeB3ztn1W8bd1YhEIQYNkY3IoUb?=
 =?us-ascii?Q?Rm9PPEekrUaXNVWqENe2Mm1vTF0ZGR+2C2tfjMvCZXuNEUjnDW6czZ3GMVFx?=
 =?us-ascii?Q?HX3DOQnv+dBAmLpIAfCv+hRXQ4DNh96FTdKEUtoDUUoyV/oqXpX8yG5saFXK?=
 =?us-ascii?Q?e0TX9gBppqLSYi8ApBqvb+AkrNmf0vIf/qsf++b5xWljH7CrDctbIOBJ/hd0?=
 =?us-ascii?Q?B1vPo7i4tNKTvnY7mjHGniZG6oTYF7AQKW4exJenKUn6VJwTIZrlacOXiG3+?=
 =?us-ascii?Q?sy8I2uZ+nedsKwMGFchQ/FIIA71yK0fLQE+cPdJ2PXV9Ie2+nMtib24MpGxl?=
 =?us-ascii?Q?w0+6IFXLxEaqlJhFNPaUCgku3iivcoCmZ+h0ES78NS54raHDEEGvBNJjO21u?=
 =?us-ascii?Q?JPBqtexnaHNNoNLVjgCoh6GZrlIOTvpi6q9Ji4u4uR5YQVEbztrielYyLBtt?=
 =?us-ascii?Q?YheU/MHHRBRXU2Ka+aicp05lNW5uRONobLj9ZSI2Gr+0XxqK48xeqi39zdk0?=
 =?us-ascii?Q?YKxMbepPHZfOeBWY1qKjpY0v8k+R7uPe/iMwh6PAbkSZsDejrKQCJCKqMJ6T?=
 =?us-ascii?Q?yNOSsaxxz1K+zbRSAHVhyw6HvOFFeb95L6gJJ9YEBerbQmzhUKMvzpcJ1djD?=
 =?us-ascii?Q?ZofhOEDpErGe8KtZC4UFTwCvjgwJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhPVHS5E01DcQyEFxG2++Q9zXKvztOMTo6ouMqoQMQ0K+Hl47wXMz25TrBsX?=
 =?us-ascii?Q?uG37G6ROF9UeyTscvUh/gfv1DYH7HAP4TbGf9keBP9DYBLv+4p2Ow9+500Ih?=
 =?us-ascii?Q?roKUBMqreA6Anr4ip9ZSO8o//mPscnXgZ4AeeS4JRqqhpi4eJ9gOgepJy7l6?=
 =?us-ascii?Q?qNEntq+dxyRoQmacpWvsSWXeD4gVWAogHlI2FS4Qqs/xWN3sFA7J3PYj5vU0?=
 =?us-ascii?Q?t/0F32r86DUReITz/cHzBPXeusGRIRbTBKX9dVJt87f/FSgWPVH6yqZRZleh?=
 =?us-ascii?Q?CwNm1GvM5VBfGohlvIjdw5hr7OYpJQvlsLqQzesYEZT3RFjLGyOwt1Mk22MW?=
 =?us-ascii?Q?qIhjZitbADTYoqPC7rLY9/JhORiSUNt57WJfSrAQF+7TrfTRaF2oyS8Kl6f6?=
 =?us-ascii?Q?creVygQjGKTJpeSpfmBPvimH1dDf2Iaa6PYUYzKZ6PuDU3wLtBWqcEObHpGb?=
 =?us-ascii?Q?b4TFkzneVBHZST6D5WeQg7ltBEfIjdy5H1B+avfEkHL6S4PpdDFhX2W56KXm?=
 =?us-ascii?Q?5WpBhTB1FEIIe0KAAi/65L5Zvx4wEPL7hEzyP9BLpE0TU6mCK4pPFxWqAS8L?=
 =?us-ascii?Q?vOchBe1PDt2YBvqtTF6kVczpoKx5TUdsqcC+pBeK+xoamp1FdG1qyZ8qE7ZW?=
 =?us-ascii?Q?ivMPHiWsgRiQw5yXd2GcmwPpn9vh25iE69ZYPDWHKiwpQKlCKGZeiFvC3eHF?=
 =?us-ascii?Q?uQ85ByKF0lKRSJwC/G4tVMDiAIODDtDNkMQyMDw8tm/eTszbkbHt9BKz0kVe?=
 =?us-ascii?Q?x48j3jiw22+9QK1FF6n5/o5U7oO81HCfPfzcdNRnoaFSHhD4AEXNXN0aEymg?=
 =?us-ascii?Q?4ZL6SuqanWnRSGHrAQXsnGzpdw1qf1q0c8VqHJvxn7/cncyBmiC0AXS4yCmO?=
 =?us-ascii?Q?eTfRzYpG2gzIsrhJqVUHmnEHzM71NEJD7dySVaT4wvlyxi2MAX28naZmZgXE?=
 =?us-ascii?Q?7Jd4F43px94jRlQSKisFp4N18YNZMCDgk37x9ebNzY7QnOn3MrLcVQ40tkfW?=
 =?us-ascii?Q?+BR6chXi+sj01f5DQxyEFpGvLJ1OAFtpLsLv5BpxQicny+zLy4dv/bsrS3uD?=
 =?us-ascii?Q?7oQRdbxvJioYIHFDCgZNtnvbDOPMh62CO9I3SWGuxMuQBfhnfiBTnzxItgZj?=
 =?us-ascii?Q?6c/9klHIDsUt1JxPId9uHQc/mACUY+SDjhNLSmZH5J3OaZnAniqdi8ydJv+M?=
 =?us-ascii?Q?o23C+Wr1rXctSrte9SBg2/9DNTZuB/2XKK3tI/R/Hax6UqVGQv5O/hdkoV9l?=
 =?us-ascii?Q?D6h65Oozze6BKdT+HDlPaL4pupBbWSAa2EzywLDtybvwRJ0/5ML+lOslzDMo?=
 =?us-ascii?Q?KzGS3zjgd2EVOlET+vexKPSYAoL7XG+FtherJIjO11RXcW+SkE3gTLoLrAL5?=
 =?us-ascii?Q?+kjLZ/7TZEVFsRyjN84F44MqNoZI3KCr5yzthHjTn9lI0IWbG9zuBFs7Vo6B?=
 =?us-ascii?Q?VSjaJLAbVtHzfSY6gzXy03P3al3M8HJ7elJT163XjiHaKnpDdJVjQr20ICnt?=
 =?us-ascii?Q?h8WNrXsCq/l/ESEcBLyhg480F3mHAHr1XZrt98ef2PK43XLT03YAJhDMB4wS?=
 =?us-ascii?Q?3aBrzjkJrhou7DIMEZ/enh4Hw73yhsidwGlaxiBvc9/FLz4Iy8pZ6ZsRQU8o?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4886a98-d043-452c-2df2-08dd34d29803
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:35:25.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqxf8LIUBBw4PBqr/1r5gws+J3r5YzUDSfKyotVjtb3H4UQfLLDkzUTaI9qqCBkdS4R5NBlq7xO2AXMNw4nbdIekCn1BOI0GZbH8aj+Zuk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8060
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 14:49:03 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > This is where you lose me. The error record is a point in time snapshot
> > of the SPA:HPA:DPA:<proprietary internal "DIMM" mapping>. The security
> > model for memory operations is based on coordinating with the kernel's
> > understanding of how that SPA is *currently* being used.
> 
> Whilst it is being used I agree.  Key is to only do disruptive / data
> changing actions when it is not being used.

Sure.

> > The kernel can not just take userspace's word for it that potentially
> > data changing, or temporary loss-of-use operations are safe to execute
> > just because once upon a time userspace saw an error record that
> > implicated a given SPA in the past, especially over reboot. 
> 
> There are two cases (discoverable from hardware)
> 
> 1) Non disruptive.  No security concern as the device guarantees to
>    not interrupt traffic and the memory contents is copied to the new
>    location. Basically software never knows it happened.
> 2) Disruptive.  We only allow this if the memory is offline. In the CXL case
>    the CXL specific code must check no memory on the device is online so
>    we aren't disrupting anything.  The other implementation we have code
>    for (will post after this lands) has finer granularity constraints and only
>    the page needs to be offline.
>    As it is offline the content is not preserved anyway. We may need to add extra
>    constraints along with future support for temporal persistence / sharing but
>    we can do that as part of adding that support in general.
>    (Personally I think in those cases memory repair is a job for the out of
>     band management anyway).
> 
> In neither case am I seeing a security concern.  Am I missing something?

s/security/system-integrity/

1/ Hardware engineers may have a different definition of "non-disuptive"
than software. See the history around hibernate_quiet_exec() to work
around the disruption of latency spikes. If this is poorly specified
across vendors we are going to wish that we did not build a "take
userspace's word for it" interface.

2/ Yes, if the device is not actively decoding any in use memory feel
free to run destructive operations on the device. However, is sysfs the
right interface for "submit multi-parameter atomic operation with
transient result"? I lean heavily into sysfs, but ioctl and netlink have
a role to play in scenarios like this. Otherwise userspace can inject
error records back into the kernel with the expectation that the kernel
can only accept the DIMM address and not any of the translation data
which might be stale.

[..]
> > Again, the repair control assumes that the kernel can just trust
> > userspace to get it right. When the kernel knows the SPA implications it
> > can add safety like "you are going to issue sparing on deviceA that will
> > temporarily take deviceA offline. CXL subsystem tells me deviceA is
> > interleaved with deviceB in SPA so the whole SPA range needs to be
> > offline before this operation proceeds". That is not someting that
> > userspace can reliably coordinate.
> 
> Absolutely he kernel has to enforce this. Same way we protect against
> poison injection in some cases.  Right now the enforcement is slightly
> wrong (Shiju is looking at it again) as we were enforcing at wrong
> granularity (specific dpa, not device). Identifying that hole is a good
> outcome of this discussion making us take another look.
> 
> Enforcing this is one of the key jobs of the CXL specific driver.
> We considered doing it in the core, but the granularity differences
> between our initial few examples meant we decided on specific driver
> implementations of the checks for now.

Which specific driver? Is this not just a callback provided via the EDAC
registration interface to say "sparing allowed"?

Yes, this needs to avoid the midlayer mistake, but I expect more CXL
memory exporting devices can live with the CXL core's determination that
HDM decode is live or not.

> > > > 3/ What if the device does not use DDR terminology / topology terms for
> > > > repair?  
> > > 
> > > Then we provide the additional interfaces assuming the correspond to well
> > > known terms.  If someone is using a magic key then we can get grumpy
> > > with them, but that can also be supported.
> > > 
> > > Mostly I'd expect a new technology to overlap a lot of the existing
> > > interface and maybe add one or two more; which layer in the stack for
> > > HBM for instance.  
> > 
> > The concern is the assertion that sysfs needs to care about all these
> > parameters vs an ABI that says "repair errorX". If persistence and
> > validity of error records is the concern lets build an ABI for that and
> > not depend upon trust in userspace to properly coordinate memory
> > integrity concerns.
> 
> It doesn't have to.  It just has to ensure that the memory device is in the correct
> state.  So check, not coordinate. At a larger scale, coordination is already doable
> (subject to races that we must avoid by holding locks), tear down the regions
> so there are no mappings on the device you want to repair.  Don't bring them
> up again until after you are done.
> 
> The main use case is probably do it before you bring the mappings up, but
> same result.

Agree.

> 
> > 
> > > 
> > > The main alternative is where the device takes an HPA / SPA / DPA. We have one
> > > driver that does that queued up behind this series that uses HPA. PPR uses
> > > DPA.  In that case userspace first tries to see if it can repair by HPA then
> > > DPA and if not moves on to see if it it can use the fuller description.
> > > We will see devices supporting HPA / DPA (which to use depends on when you
> > > are doing the operation and what has been configured) but mostly I'd expect
> > > either HPA/DPA or fine grained on a given repair instance.
> > > 
> > > HPA only works if the address decoders are always configured (so not on CXL)
> > > What is actually happening in that case is typically that a firmware is
> > > involved that can look up address decoders etc, and map the control HPA
> > > to Bank / row etc to issue the actual low level commands.  This keeps
> > > the memory mapping completely secret rather than exposing it in error
> > > records.
> > >   
> > > > 
> > > > I expect the flow rasdaemon would want is that the current PFA (leaky
> > > > bucket Pre-Failure Analysis) decides that the number of soft-offlines it
> > > > has performed exceeds some threshold and it wants to attempt to repair
> > > > memory.  
> > > 
> > > Sparing may happen prior to point where we'd have done a soft offline
> > > if non disruptive (whether it is can be read from another bit of the
> > > ABI).  Memory repair might be much less disruptive than soft-offline!
> > > I rather hope memory manufacturers build that, but I'm aware of at least
> > > one case where they didn't and the memory must be offline.  
> > 
> > That's a good point, spare before offline makes sense.
> 
> If transparent an resources not constrained.
> Very much not if we have to tear down the memory first.
> 
> > 
> > [..]
> > > However, there are other usecases where this isn't needed which is why
> > > that isn't a precursor for this series.
> > > 
> > > Initial enablement targets two situations:
> > > 1) Repair can be done in non disruptive way - no need to soft offline at all.  
> > 
> > Modulo needing to quiesce access over the sparing event?
> 
> Absolutely.  This is only doable in devices that don't need to quiesce.
> 
> > 
> > > 2) Repair can be done at boot before memory is onlined or on admin
> > >    action to take the whole region offline, then repair specific chunks of
> > >    memory before bringing it back online.  
> > 
> > Which is userspace racing the kernel to online memory?
> 
> If you are doing this scheme you don't automatically online memory. So
> both are in userspace control and can be easily sequenced.
> If you aren't auto onlining then buy devices with hard PPR and do it by offlining
> manually, repairing and rebooting. Or buy devices that don't need to quiecse
> and cross your fingers the dodgy ram doesn't throw an error before you get
> that far.  Little choice if you decide to online right at the start as normal
> memory.
> 
> > 
> > > > So, yes, +1 to simpler for now where software effectively just needs to
> > > > deal with a handful of "region repair" buttons and the semantics of
> > > > those are coarse and sub-optimal. Wait for a future where a tool author
> > > > says, "we have had good success getting bulk offlined pages back into
> > > > service, but now we need this specific finer grained kernel interface to
> > > > avoid wasting spare banks prematurely".  
> > > 
> > > Depends on where you think that interface is.  I can absolutely see that
> > > as a control to RAS Daemon.  Option 2 above, region is offline, repair
> > > all dodgy looking fine grained buckets.
> > > 
> > > Note though that a suboptimal repair may mean permanent use of very rare
> > > resources.  So there needs to be a control a the finest granularity as well.
> > > Which order those get added to userspace tools doesn't matter to me.
> > > 
> > > If you mean that interface in kernel it brings some non trivial requirements.
> > > The kernel would need all of:
> > > 1) Tracking interface for all error records so the reverse map from region
> > >    to specific bank / row etc is available for a subset of entries.  The
> > >    kernel would need to know which of those are important (soft offline
> > >    might help in that use case, otherwise that means decision algorithms
> > >    are in kernel or we have fine grained queue for region repair in parallel
> > >    with soft-offline).
> > > 2) A way to inject the reverse map information from a userspace store
> > >   (to deal with reboot etc).  
> > 
> > Not a way to inject the reverse map information, a way to inject the
> > error records and assert that memory topology changes have not
> > invalidated those records.
> 
> There is no way to tell that the topology hasn't changed.
> For the reasons above, I don't think we care. Instead of trying to stop
> userspace reparing the wrong memory, make sure it is safe for it to do that.
> (The kernel is rarely in the business of preventing the slightly stupid)

If the policy is "error records with SPA from the current boot can be
trusted" and "userspace requests outside of current boot error records
must only be submitted to known offline" then I think we are aligned.

> > > That sounds a lot harder to deal with than relying on the usespace program
> > > that already does the tracking across boots.  
> > 
> > I am stuck behind the barrier of userspace must not assume it knows
> > better than the kernel about the SPA impact of a DIMM sparing
> > event. The kernel needs evidence either live records from within the
> > same kernel boot or validated records from a previous boot.
> 
> I think this is the wrong approach.  The operation must be 'safe'.
> With that in place we absolutely can let userspace assume it knows better than
> the kernel. 

Violent agreement? Operation must be safe, yes, next what are the criteria
for kernel management of safety. Offline-only repair is great place to
be.

