Return-Path: <linux-edac+bounces-2949-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C8A1BD92
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2025 21:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336A11889582
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2025 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB591ADC9A;
	Fri, 24 Jan 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P67sRBxC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5E1D5149;
	Fri, 24 Jan 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751182; cv=fail; b=uutsUYUI6vNbko+hSGDpZfKUwfMbN3j+lSThQlOZPwITjd7fZUkBLh4HBSI2A5KafNYMa/X297hBj8H3YqiuksN4n2p5kb5CQ71s36/lQROHaKT0ViTDc2nrmFA7hVIbM4+fB1iXrTXckHv48Ie3PDxIdUoiicpFT8UDeQa5XuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751182; c=relaxed/simple;
	bh=ssGoJtQFsGc5/E0MujQ4AEZbetHP7xgpwx9rlcNvaQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WhZdWnn6RqJZ2/J+SUZjxiMN2Q+M8KKZX3SlPXzt9Jh7rff5+ebVAFnrfkY5SR4aW3AfslnX0GP0WodTuDZEQMNqgzlRlbzefcME5H2YOJQsgh2IvZbmF7DWV3gZghR79nkGgHUFXQqtKmeBnzClHA4baCtDnfHAybTvnM7cwnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P67sRBxC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737751180; x=1769287180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ssGoJtQFsGc5/E0MujQ4AEZbetHP7xgpwx9rlcNvaQs=;
  b=P67sRBxCm8t4m8LNg9pNc4+0kexqz6orH/RLl+z0FmprtpTNtbY0Pab4
   kncwzseM+VgO/Nr98j10jgjTh2CbsFujdskdwgwLY+d/sogrz3YyNAKkC
   vrAuIJYYK6D84QvcEcBFRoSiqNsTYmRfKdxtzHn4d/R3uYkpuF/DqarI+
   88E60GxCoA9hSDrqKI1N06M4ECcQH8WERYm2cnxOtdkbE7Cev6FvJdLOs
   hiHLFZlsMgRnXNYmBtdyXgt65v4FjhFSrjG2P5lFgfEKGTuw7sK5VjDyH
   S2e5s6zI0SrOvSQvNhoui4WeoFIBGVpkCoBXn65LxaCdNimca4KiuI6c1
   w==;
X-CSE-ConnectionGUID: iA3Xp5O4QCSHy7JuE/fqlA==
X-CSE-MsgGUID: siV2epsoRN2GGR8qUFO8jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38209815"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="38209815"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 12:39:39 -0800
X-CSE-ConnectionGUID: 44Dq+easS5C2CznreNNRmw==
X-CSE-MsgGUID: QZjc13PISiGy23158kRM5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="138740978"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 12:39:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 12:39:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 12:39:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 12:39:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+n5i1zv8oJAr22SINTwF97tDIRletxmS6D3q13YWcONpto256vE/maNuv3XhxhZgV6F7TCZpnd2VIdMRidgmQ7InVhIDJEdNqehcXMwT6EYWm8wZliEcbyLlcla28ZlD33ym01pJrWxz4seJzX9uFWUsKtusg8edsHbN7JaJw35kNjEAY3ZPm8ylsTXMvmihwvsPgofyZdgYbBa9Bn6dezmIhy2gBxLjQBKk5daQR3AHp2CT1gzPWpW49filauqvTaYrUxAH0JQ+uKHXfwhYiBCannljTZR/tngOeWVDleXKY91X/k2+XZhZLcR64jo02rCpEadS7eD3OGPSV3TWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peeExKlVw4Z3GthekhWWHcAEqDdZDBr7fSSOitEkxLs=;
 b=uQtDA+iwIyEJpx0h3vfbZ4MTwwwvJCks4lyuiK5C9EacFfvuUrBROEYtYG/2prVm8iCucdBMAO/y4/UBdzryK0Psj/cXQAizuK1RPoBYj+ZNAhBPMoB3/SF0eqwU06SpFPBGl7Yat734fHzD5kZZHymeIk6OuvFQ0EE+X8hAJze6qTPQsy3KdSTTI9yz1w0CrVI6z/itMVEK7zwh2n8EJMmdG53qrbB3vgUvnqcHLNm2CqGSKBuOWWbKR/o+6Eu9iyxbFJzNW2XIRK9bmCMwg7YsYd+7FGu59y8WEN1b3c5jNcQJ7EKsgxUrNO05Vpwvp6RVEykswxAP9D3Xs+cQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4534.namprd11.prod.outlook.com (2603:10b6:208:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 20:38:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:38:47 +0000
Date: Fri, 24 Jan 2025 12:38:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-16-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250106121017.1620-16-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c7c98f-a2c0-45d5-9675-08dd3cb71a58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YttOEBAJZ9LXZO20ngdVi6nDwNdH8HTN1zRruiGycQ3/HuyrKPzLNnPCTsb4?=
 =?us-ascii?Q?OvZdK3+TzjbViuf/Sl9/iJnadKP0lIEIkC1SBmse0qYQgWzL6B3col5xBj7B?=
 =?us-ascii?Q?kIGPNveU4pFfrnvcIBx7P8WH5mTPXOikf/KRum5hHcsmD2IkfdRbOLDwjiJE?=
 =?us-ascii?Q?q3ce3FSWw9hi75N+9EhnYKQ2yy5Q6WCp7iwycUsyFVGPWEGPO1DJZ//J5YxP?=
 =?us-ascii?Q?eVVDzrxi+zzWgiIHWZZ7hJKxosHwpHGUJont7CEMh4GMyO6C37r5xceaKAFB?=
 =?us-ascii?Q?AdD+ITAJOxDB3cs7d40nnqYkG4rzC0Hfhq/fgaOvQlNi5s4Wm/GK2bT+jAsY?=
 =?us-ascii?Q?uhnWmyFmxXejIGHQwQ6VUPkSlObAt9fTlooV7POrScYwR/A2/5vpnVblYFA9?=
 =?us-ascii?Q?4IfGZBdJ6DVJe0tvMyV6TRxBftVmEe/xdWSyFD1lmBCuIX9VzWhkGprjN4nc?=
 =?us-ascii?Q?ZX0d27Ojgaz3pBk3hF6mktDeKMYcqEjjHNHrOxX4Iz2eBLwmuv2rjaN/cHTP?=
 =?us-ascii?Q?CieXhfUkrYxGxhLB0SzWTtiptmWtCwUmblf5dxn02JGpgbJtemBvVanznUDK?=
 =?us-ascii?Q?CYI8RqQyc45zL0PGhEdhwL1Wt1tsjM288wW4+DNS6o2wzUfQL5rV8Q+71hrC?=
 =?us-ascii?Q?ztvJ1pVVYqnqeVZe7ZHIpAopyRyB2W5G+umhLlUbhQd6fdMfRP6LKitqC3oT?=
 =?us-ascii?Q?xjNY3lvZCMxzb6ZG0SStELNdwl9zjjx0BHqAlGJXxnHq6pgl3p1SsrKMV9sN?=
 =?us-ascii?Q?nlWYuxYtztgIgA3Sb6XioI1nVS4uKy1956lYlC7fACaH+Sn7BmbEH0XVJzNO?=
 =?us-ascii?Q?xHLzmvbbgOikniuV49rJlGhfELu0Wxvz900ofwWL7e6dqdfgstLWuBOVv7fB?=
 =?us-ascii?Q?pvPz3UVarIR0q4oCQCRzPKTDBe8jXe0asBjJIF/toR1x5XtRMmdNxZvkb5AL?=
 =?us-ascii?Q?LDAf/t03FB1MZDDV+gKeRdP/SSjiv6SugPOAz+bzYhwNsS/IAz/YRzrIYBL6?=
 =?us-ascii?Q?+DowVORMLoIQ0qb6r1bape1DDWeaZeuXQBjz0CdkZp6oO20YYbxDtCSRB4um?=
 =?us-ascii?Q?VgNm4EqW/aHyVUd5V049iiaDvS/0C1UHhmZPoFtBR8FpLH+BSF/Pr3CXEVCq?=
 =?us-ascii?Q?8emxjGxTFtQpACoiONLO/DqDFcRCdiER3i0iH+FT4Q9zV8cTu2Mo1964Lre/?=
 =?us-ascii?Q?ZSv8ptIQ4pFpYfP2eL8yEb8T0umuK5fqM46hNerP22hY7r4rZVNgjxzEu9Dn?=
 =?us-ascii?Q?E+NzF/MdTJJj+64+EYA/QXNWR58mNHRYHSRLBiEo5yi6N7/0MY7Z/EZDp5ek?=
 =?us-ascii?Q?9ORpXcgxfJCqD00iMLKM3IbQJqYW63iGd3Q3NCWfmBkmBSd69vkVWD701Cee?=
 =?us-ascii?Q?goeIskvzb1EpLCnVNlO/w9T5Hp/4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bp9uo3cVCCNQ8U5csnY9BXCoempoMqsfuEd1RwsrYmIsaOIrxQWYtGWDEbPY?=
 =?us-ascii?Q?dZxiWtdyl7DpnOZWdbE+lgUaiIxB1tNdQ2nEVs9dHt8k073sZQM02ZHHn8x+?=
 =?us-ascii?Q?NnHmSB1UOScqBzr8bN2hf74xeri5HXOI2zp3IJXL7j/LRoTd8GBnScV6rYo5?=
 =?us-ascii?Q?0lHbbHNZpoFpBmpxbs86kCqRQJ5rR6JCfN/Sc5fPqVf/Q80t+TFJCagOURnr?=
 =?us-ascii?Q?uMkI1E6PUUE9ZSofuHdyEZCZf3zoZqAq/ll4IzKPW4xOmWlpqFeVN8RDBDpT?=
 =?us-ascii?Q?e01jWQRduh8qKx7klwQ3YK610dovQXItkkOkQcA6jBTaN6mDQvNFzoZ1D0Qi?=
 =?us-ascii?Q?dXb+30GKmL46EDVdFDCSq1ohZE01/gbctAca24bNdC4H9kyh0BK3ZZlzc5eh?=
 =?us-ascii?Q?W5ybU0mLS27nls3x2ERAKmhaDIZOTRau1tvVr7lt8EBuPsNQu++51i3kpEIm?=
 =?us-ascii?Q?yPbhvqb78a31kr/3GDkCCXsEVOQMaAvvCpMH5crAEN8qDtx3cIqR0eCFOxcF?=
 =?us-ascii?Q?GPmgLQPnlhln4lHP4C57hGlAcN3oNmwpprg1G0vVtqdCVPXWB2Ia720ja8qC?=
 =?us-ascii?Q?pBLUzIhX+duWSrYlKGuZNaUTM0r0b2oybfi37/utJzQZACMs09zVtpsj5hjW?=
 =?us-ascii?Q?oQUSTSVtKUD0J7vIRykiUgwrQlsdC0MgjNE9BTkiQg35hGkCTl1GG0mS6UJw?=
 =?us-ascii?Q?JgUxFefvYyDLHWJv9w9ZnoXUtZ0r8nQ5SN4eOCHyZtlJZ3QOd0NUlgZwUc7D?=
 =?us-ascii?Q?YvnOIPaRXKoP9rbbhm7hESlD6xVci/W7Do5wl3+GpLRpMz+osi21hsLFhIjm?=
 =?us-ascii?Q?24Y1YtGJFEGaSlkB8T8gag+OkkxX7dAN3bcG9vT5YIkCJ0N6xxgpR0YNFrfT?=
 =?us-ascii?Q?9jzG77E7udF2/9yl9a6ZlChFPTkdw7B9uH3j2LhiwtArfTc8Ly+j0/U70Cpo?=
 =?us-ascii?Q?8ZHjIWHxGEvsyQpofi9RHJgm+RVLFf60rStxVxN1MA1ScQcWraEymtrNIoCy?=
 =?us-ascii?Q?c5BG00m9JE1NH+K9mmV/hTBxs36a9t3i23+WycVQkau9tSii9zAGPpWDLBvR?=
 =?us-ascii?Q?9PG6h7GorQVtHyWFzHTu4h+cEKmUUUWQ0jqD6OM115+hQ3ENwI/xgYHrZq52?=
 =?us-ascii?Q?AlFPPm7lxMWsF+XfmgBg+P0VlRRiHdKOHb/7bKk96R9giV4acqJj4u5zZuVJ?=
 =?us-ascii?Q?b7AZwfiHZc5UTCt1r9TIk34z4TJ8I4nu/rJiTKwFu1AolqUV8gnnroGj6PJk?=
 =?us-ascii?Q?mOfB5TOvllNRDp3superEHEeVfFURIj+k7zlqlRUys+9i+Agkt88GvXq6U2S?=
 =?us-ascii?Q?ob06uh6jd3LNeI5LAXE27qdS0Cnd8zkruhNBUI9+GJHRH8Z7jJVjOuW0Icn1?=
 =?us-ascii?Q?tu0NVdsXtzrqbxNIMisN0pg/fZTgy20DxWGpbVtOGT9WSzYtmFBnGioKZ9Pu?=
 =?us-ascii?Q?yyHnKFtPFaZmgr0qlMfJjYlVfHaBfBHdz1gbCf/WH6my6ZizZcOehcCBJQtd?=
 =?us-ascii?Q?XjaJOfmM59d2QVjzYx4YC/o2Jen6LzSBDQBT/wpqR9bvSe6Q8fzGT0SR+pZe?=
 =?us-ascii?Q?Qh5m3LeMXV8AtotUrmk3oPTcFEn19rOf8gnPO+iOX/BVtfe3XTjgg1BF6IPo?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c7c98f-a2c0-45d5-9675-08dd3cb71a58
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:38:47.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hIAnmMKg/I4S2kWN7rziPvKCroEilD54W+vFBHtQlhBzrONQ863bqxPlwTSaIslJgGxsm6pQmrSUVeKQrJF5Zx6h+2MKtIh+I9OpLPDMpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4534
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle.
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
>  Documentation/edac/scrub.rst  |  66 ++++++
>  drivers/cxl/Kconfig           |  17 ++
>  drivers/cxl/core/Makefile     |   1 +
>  drivers/cxl/core/memfeature.c | 392 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c     |   6 +
>  drivers/cxl/cxlmem.h          |   7 +
>  drivers/cxl/mem.c             |   5 +
>  include/cxl/features.h        |  16 ++
>  8 files changed, 510 insertions(+)
>  create mode 100644 drivers/cxl/core/memfeature.c
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index f86645c7f0af..80e986c57885 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -325,3 +325,69 @@ root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_d
>  10800
>  
>  root@localhost:~# echo 0 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
> +
> +2. CXL memory device patrol scrubber
> +
> +2.1 Device based scrubbing
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
> +
> +3600
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
> +
> +918000
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +
> +43200
> +
> +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +
> +54000
> +
> +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +
> +1
> +
> +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +
> +0
> +
> +2.2. Region based scrubbing
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
> +
> +3600
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
> +
> +918000
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +
> +43200
> +
> +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +
> +54000
> +
> +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +
> +1
> +
> +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background

What is this content-free blob of cat and echo statements? Please write actual
documentation with theory of operation, clarification of assumptions,
rationale for defaults, guidance on changing defaults... 

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 0bc6a2cb8474..6078f02e883b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -154,4 +154,21 @@ config CXL_FEATURES
>  
>  	  If unsure say 'y'.
>  
> +config CXL_RAS_FEATURES
> +	tristate "CXL: Memory RAS features"
> +	depends on CXL_PCI

What is the build dependency on CXL_PCI? This enabling does not call back into
symbols provided by cxl_pci.ko does it?

> +	depends on CXL_MEM

Similar comment, and this also goes away if all of this just moves into
the new cxl_features driver.

> +	depends on EDAC
> +	help
> +	  The CXL memory RAS feature control is optional and allows host to
> +	  control the RAS features configurations of CXL Type 3 devices.
> +
> +	  It registers with the EDAC device subsystem to expose control
> +	  attributes of CXL memory device's RAS features to the user.
> +	  It provides interface functions to support configuring the CXL
> +	  memory device's RAS features.
> +	  Say 'y/m/n' to enable/disable control of the CXL.mem device's RAS features.
> +	  See section 8.2.9.9.11 of CXL 3.1 specification for the detailed
> +	  information of CXL memory device features.

Usually the "say X" statement provides a rationale like.

"Say y/m if you have an expert need to change default memory scrub rates established
by the platform/device, otherwise say n"

> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 73b6348afd67..54baca513ecb 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,3 +17,4 @@ cxl_core-y += cdat.o
>  cxl_core-y += features.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_RAS_FEATURES) += memfeature.o
> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> new file mode 100644
> index 000000000000..77d1bf6ce45f
> --- /dev/null
> +++ b/drivers/cxl/core/memfeature.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CXL memory RAS feature driver.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + *
> + *  - Supports functions to configure RAS features of the
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
> +
> +#define CXL_DEV_NUM_RAS_FEATURES	1
> +#define CXL_DEV_HOUR_IN_SECS	3600
> +
> +#define CXL_DEV_NAME_LEN	128
> +
> +/* CXL memory patrol scrub control functions */
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
> +	u8 scrub_cycle_hrs;
> +	u8 min_scrub_cycle_hrs;
> +};
> +
> +enum cxl_scrub_param {
> +	CXL_PS_PARAM_ENABLE,
> +	CXL_PS_PARAM_SCRUB_CYCLE,
> +};
> +
> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
> +
> +struct cxl_memdev_ps_rd_attrs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle_hrs;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ps_wr_attrs {
> +	u8 scrub_cycle_hrs;
> +	u8 scrub_flags;
> +}  __packed;

If these are packed to match specification layout, include a
specification reference comment.

> +
> +static int cxl_mem_ps_get_attrs(struct cxl_mailbox *cxl_mbox,
> +				struct cxl_memdev_ps_params *params)
> +{
> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
> +	u16 scrub_cycle_hrs;
> +	size_t data_size;
> +	u16 return_code;
> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
> +						kmalloc(rd_data_size, GFP_KERNEL);

I would feel better with kzalloc() if short reads are possible.

How big can rd_data_size get? I.e. should this be kvzalloc()?

> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox->features, CXL_FEAT_PATROL_SCRUB_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +				    rd_attrs, rd_data_size, 0, &return_code);
> +	if (!data_size || return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +		return -EIO;
> +
> +	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
> +						   rd_attrs->scrub_cycle_cap);
> +	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +				   rd_attrs->scrub_flags);
> +	scrub_cycle_hrs = le16_to_cpu(rd_attrs->scrub_cycle_hrs);
> +	params->scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +					    scrub_cycle_hrs);
> +	params->min_scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
> +						scrub_cycle_hrs);
> +
> +	return 0;
> +}
> +
> +static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +			    struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_memdev *cxlmd;
> +	u16 min_scrub_cycle = 0;
> +	int i, ret;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];

It looks like this is called directly as a callback from EDAC. Where is
the locking that keeps cxl_ps_ctx->cxlr valid, or p->targets content
stable?

> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			ret = cxl_mem_ps_get_attrs(&cxlmd->cxlds->cxl_mbox, params);
> +			if (ret)
> +				return ret;
> +
> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
> +				min_scrub_cycle = params->min_scrub_cycle_hrs;
> +		}
> +		params->min_scrub_cycle_hrs = min_scrub_cycle;
> +		return 0;
> +	}
> +	cxlmd = cxl_ps_ctx->cxlmd;
> +
> +	return cxl_mem_ps_get_attrs(&cxlmd->cxlds->cxl_mbox, params);
> +}
> +
> +static int cxl_mem_ps_set_attrs(struct device *dev,
> +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				struct cxl_mailbox *cxl_mbox,
> +				struct cxl_memdev_ps_params *params,
> +				enum cxl_scrub_param param_type)
> +{
> +	struct cxl_memdev_ps_wr_attrs wr_attrs;
> +	struct cxl_memdev_ps_params rd_params;
> +	u16 return_code;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(cxl_mbox, &rd_params);
> +	if (ret) {
> +		dev_err(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (param_type) {
> +	case CXL_PS_PARAM_ENABLE:
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  params->enable);
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      rd_params.scrub_cycle_hrs);
> +		break;
> +	case CXL_PS_PARAM_SCRUB_CYCLE:
> +		if (params->scrub_cycle_hrs < rd_params.min_scrub_cycle_hrs) {
> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +				params->scrub_cycle_hrs);
> +			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
> +				rd_params.min_scrub_cycle_hrs);
> +			return -EINVAL;
> +		}
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      params->scrub_cycle_hrs);
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  rd_params.enable);
> +		break;
> +	}
> +
> +	ret = cxl_set_feature(cxl_mbox->features, CXL_FEAT_PATROL_SCRUB_UUID,
> +			      cxl_ps_ctx->set_version,
> +			      &wr_attrs, sizeof(wr_attrs),
> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> +			      0, &return_code);
> +	if (ret || return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> +		dev_err(dev, "CXL patrol scrub set feature failed ret=%d return_code=%u\n",
> +			ret, return_code);

What can the admin do with this log spam? I would reconsider making all
of these dev_dbg() and improving the sysfs documentation on what error
codes mean.

[..]
> +
> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)

Please separate this into a memdev helper and a region helper. It is
silly to have two arguments to a function where one is expected to be
NULL at all times, and then have an if else statement inside that to
effectively turn it back into 2 code paths.

If there is code to be shared amongst those, make *that* the shared
helper.

> +{
> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> +	char cxl_dev_name[CXL_DEV_NAME_LEN];
> +	int num_ras_features = 0;
> +	u8 scrub_inst = 0;
> +	int rc;
> +
> +	rc = cxl_memdev_scrub_init(cxlmd, cxlr, &ras_features[num_ras_features],
> +				   scrub_inst);
> +	if (rc < 0)
> +		return rc;
> +
> +	scrub_inst++;
> +	num_ras_features++;
> +
> +	if (cxlr)
> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> +			 "cxl_region%d", cxlr->id);

Why not pass dev_name(&cxlr->dev) directly?

> +	else
> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> +			 "%s_%s", "cxl", dev_name(&cxlmd->dev));

Can a "cxl" directory be created so that the raw name can be used?

> +
> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
> +				 num_ras_features, ras_features);

I'm so confused... a few lines down in this patch we have:

    rc = cxl_mem_ras_features_init(NULL, cxlr);

...so how can this call to edac_dev_register() unconditionally
de-reference @cxlmd?

Are there any tests for this? cxl-test is purpose-built for this kind
of basic coverage tests.

> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ras_features_init, "CXL");
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b98b1ccffd1c..c2be70cd87f8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3449,6 +3449,12 @@ static int cxl_region_probe(struct device *dev)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +
> +		rc = cxl_mem_ras_features_init(NULL, cxlr);
> +		if (rc)
> +			dev_warn(&cxlr->dev, "CXL RAS features init for region_id=%d failed\n",
> +				 cxlr->id);

There is more to RAS than EDAC memory scrub so this message is
misleading. It is also unnecessary because the driver continues to load
and the admin, if they care, will notice that the EDAC attributes are
missing.

> +
>  		return devm_cxl_add_dax_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 55c55685cb39..2b02e47cd7e7 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -800,6 +800,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +#if IS_ENABLED(CONFIG_CXL_RAS_FEATURES)
> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr);
> +#else
> +static inline int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
> +{ return 0; }
> +#endif
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..d236b4b8a93c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -116,6 +116,10 @@ static int cxl_mem_probe(struct device *dev)
>  	if (!cxlds->media_ready)
>  		return -EBUSY;
>  
> +	rc = cxl_mem_ras_features_init(cxlmd, NULL);
> +	if (rc)
> +		dev_warn(&cxlmd->dev, "CXL RAS features init failed\n");
> +
>  	/*
>  	 * Someone is trying to reattach this device after it lost its port
>  	 * connection (an endpoint port previously registered by this memdev was
> @@ -259,3 +263,4 @@ MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
>   * endpoint registration.
>   */
>  MODULE_SOFTDEP("pre: cxl_port");
> +MODULE_SOFTDEP("pre: cxl_features");

Why?

