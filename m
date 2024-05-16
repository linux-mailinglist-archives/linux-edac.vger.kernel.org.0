Return-Path: <linux-edac+bounces-1061-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AE98C7CBB
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE0B1F218A0
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479E156F24;
	Thu, 16 May 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECtBA3Vf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94CEDE;
	Thu, 16 May 2024 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885784; cv=fail; b=Mxt9bZe+d5M3B4OucRZC+miOu0+pguCiHaQQeb1ruxtWY0V/WtWTU2vdb9QyZXyXoKRhqPMlPLXRrN189JbMohLIcVKGKXd8d3lW752vqrnr69UTXIXYKpQw4BbiSjiob2Xake4flh+7EO/KzazoVQrvzWdmuE/miaPn9aceF+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885784; c=relaxed/simple;
	bh=lwziwO4LZkNxb6IW5QwqS6PwMdIkOqId0cqKt40224A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HDMRnaKRdMl3WE2D+9B0deQHwbgCxm/JdePdiu2BUkOAgDTGugq1U1OZy1s5mlHTHw/Ouv+H8MDVx5nEr5QtqZgEOibdWmzCXAOo0RN4gAdCAGc4ll+6wbUeWlQ8fN42q57HLiPBPO5BtAPGM/Un6OLE2UJMGx3OCq+Ow5j1wNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECtBA3Vf; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715885782; x=1747421782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lwziwO4LZkNxb6IW5QwqS6PwMdIkOqId0cqKt40224A=;
  b=ECtBA3VfsJlhC5N0piYj4IMyn/DnXCLiMcEkSp2f5AgoML3FQP2ap6hE
   csF6fraj3wspPKMLDqJcsE5Zg/LkVxc+r18wktk8HunjOMWbWHn/1u5ZM
   dRR4urSFpHGx9GF9eHWawPd4WTGWL8T4cVI6GRJMSBgHqmK5I9yTHUarg
   q29POF0gX31fEPC4niWdWnQMfH7GmmYefdRjV2V7Rvh2HqMzLUHw5C4M3
   LHZoFNiE8hmVoaWk+bMXZM8FWe+l9t39J2Gm5ZYZ56OFtxR73+teFs6Ui
   z/sXBLWdUYR0yUoz56iivPhCgRyY8P7qLkxnyVRomGrz66rMbNwXhRVsT
   Q==;
X-CSE-ConnectionGUID: RVnPPc52QNa8Nu6HmU3FHg==
X-CSE-MsgGUID: +xYpQaYNRNKVHV20fhkYsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22701886"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="22701886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 11:56:21 -0700
X-CSE-ConnectionGUID: jRl6TtMKRTyP5cuK/C0zZg==
X-CSE-MsgGUID: A6IWBEJ8Q7CWhRIKfgLipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="32137797"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 11:56:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 11:56:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 11:56:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 11:56:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 11:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6eo5zFyMfASudIJdmyHZmV2tDXS+PBIfTN0T4sgFJjlXl58atj55kR53ONIMDHO2jUIrz+rQ5J/EUAkkMmp0xbzlOc8X/Cp/8P3MLAhM4DXQ6mnGjy7C/goruWL2ikwaNKRPyiDez+gORTOX+crejdx7ZX3M6s7RfZv5DX6+FwkUK8EC6nroE6n+lbNhYHYtd6no4e00UIpuTdZHxvlbZicepanvnSiGwjZMf8GGBVr9Puy+iiYbUQcsUXpG54DhgMRFKYyQdeq1q8mQ+SQfYrOCA+Y4TexCboMzmSYkhS07zCbqkcTS7LeFpDjPaRLbk+vWdduU4lY0rzWOG4X1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jey2+mAvgew40MD8VNLkE7EfJ/zTRUACN6apSOc0FUc=;
 b=PFpg1/wvDBZjHmbGY0n04Nv1C4JbgEgIoIxmuUdNSdTlutiLYxx+9ms809Cyw/PLECZ5NHH/bgPQtVZbZKUiQ5MUix+/iHNZRe7jIrorpWLxn8DnCn1WK9f0sVYwtr2870pmY6VGK5Qwqyhg1dNVWGN2NUxUy9TRzFCsvr/AQU0ehJXSAVINCxcVnrvfubKVMbeEySjoPKkdQGgVLkjtF3YIqVE9VrR/XOc+ZfhBFVOMcJzJbXXNsrzgz9SNpBRh9v3RoIBYvwNynqBxU1RKC6Cjy/uFWk3aaJegHauIkWW2o3bsAPd4d30Qde7h56s0XqtedQInYLkTJ3PFF9v3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 18:56:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 18:56:18 +0000
Date: Thu, 16 May 2024 11:56:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck
	<tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <664656cf7c59b_2c2629493@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
 <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240516095714.GCZkXYeiKbUk2QXoIO@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516095714.GCZkXYeiKbUk2QXoIO@fat_crate.local>
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6156d3-c7d8-445b-7ec3-08dc75d9deb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5N77b9ZA76iJVj0/gJvMDAtpl2Y6UO3NUq/HYeF0sK2i5lzZ6Rv+7NZMtxZX?=
 =?us-ascii?Q?GCIdC3uTUQqjuIcTgBMySHX98wB0EBLt/QV+1+YEbJqMokpQITzrx24YeEu6?=
 =?us-ascii?Q?srYq12M8nqUHU/1FDGQ+zs9cnaBfR747MDASXhAPpIoPMXfuksH+CAfS7VK6?=
 =?us-ascii?Q?Bv2SDMagLYN4dr9B33EUxCgXqb+kVvF/7FV7qTEWfoWlmdv3FMQL1487kxM/?=
 =?us-ascii?Q?YXlVCg+OQYK8C3Vuhv8oaKgrO/k2l6HaOZReMunUheN5d2AdYKJ/ealbfmqf?=
 =?us-ascii?Q?EgNkHNZDveXlYyQnsmJx0jPafY/e7EjCOlfRYjkltwErf5z71DI5SJ2CjD1/?=
 =?us-ascii?Q?43Fov2iYf2T2bjc78JhzzetQshOJv7TwSJRNKkwgfRBg56Umr4xkQ6A8mngK?=
 =?us-ascii?Q?ObUcTjZnoilaLdNus3HTnROn9iGLVYWKHefBWYM1ccfmuQzDcr/4x4YNyt/g?=
 =?us-ascii?Q?rzjKsT7SCc93DGjuF0ZndCdkbg7Vxno7RLJMjQSioGvfoK88C11anV7vfofU?=
 =?us-ascii?Q?tqfqYtn+000+SFynYxnv9at2ZDGO+PWpoSMOF6P5VMV/GcHE314Qh/7PjfEx?=
 =?us-ascii?Q?uvs3rdSL6F3xfebeexEBu/t3W4QqDzCM+OkadWsmmwflp28SO8xvTcGK2e9o?=
 =?us-ascii?Q?EbdSr/UPhIf1elhbmcEziqa/po5MZH2j98x14Bm8B5/Pyz2K5YpfSMfytW4E?=
 =?us-ascii?Q?WgpPAKY31auTN1S3V+Mkg8wGdZibTaGl7Y9SQG771smLpHFr9JTL7E1+2vtN?=
 =?us-ascii?Q?CVyAH40wZ229BDEqr+qWAjP5XVm+38aCMAx+qdCF66XkOOkR+gfIicNtHGyF?=
 =?us-ascii?Q?EVuzs09MSxHYIRR5lX+kbY0V3V1RCQN06NTftOO2BINKTFtlayKXB5lfK99S?=
 =?us-ascii?Q?e1Z5f0LjOvZUUFxX5+QBpBkxNaQ8IoBaKIbaRcxnXdQ3I+Niae57U8AWWb5P?=
 =?us-ascii?Q?pvUuvt6YPqoNslo8DQbEZ9sgMFco0uVpFWFQx70Mkyz3tnhNf/2EkSeRf6Ld?=
 =?us-ascii?Q?DGKNPr8Po/969iMYeEHGr5l/mYVOjBSqdJxTyoO5GdmeDBg/VcwxaynUGlOb?=
 =?us-ascii?Q?Fr/ysp0vDq837CySrIbz04+eGT3BqDZJpVlZ1p9eFS06OoRb5g7DiFPqZP42?=
 =?us-ascii?Q?ZwxWSsjM6HIqtockYMSuDXPpekmSXSMgWaoMSZYpb5KuqpHe61ErxulElrsS?=
 =?us-ascii?Q?IAe+ZdFiTH+Q8FFTpJ86ZZ1HALcyaKGPC8ziMHoCzN1x5H/OpKpMWeCoY1ad?=
 =?us-ascii?Q?XSFuXem72fugsqL1TYddhls9GhHGIgDY0SoaWVApBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9zukV6BNAopPpj0ZJEB+8lt5E3/y/8x1Ri35bgKFsboDpWVL1uERzc/jBKJ?=
 =?us-ascii?Q?IDqiSZ4KK+FBjO+EFhI7kqiEt3wJisvjbLVubpYyHyl3nCZ/KengTCzgxTQJ?=
 =?us-ascii?Q?jGf7WZmflJjOT5WHXst5RY/S2SoRGWTEpcG+e/giSWMGOjU5zzx7DQMGm7c1?=
 =?us-ascii?Q?ARhOLmaMuPBGCCNwDhHlhaCdgaDIZMke7DBkOPe74enG1iuykCBTydJTtSbQ?=
 =?us-ascii?Q?T03HurJ8/npjZQ45/KL5OGlbD3kSR36TauFtydoViX0kUox1jkcpZ2Ifywjb?=
 =?us-ascii?Q?9CnGn9zJPGV7/WcTpaeQVTBY3M+BNl/KoBvssushGm3/E0lPSOkT33kZ4i1a?=
 =?us-ascii?Q?HeT/ap7pCBFCVr74KoV3Ym1Cc5PIww10Zms4oHPwiauQhIPvF/7YkMgKkqxG?=
 =?us-ascii?Q?c3PdnDpRBYhM8yKLcXA3wkLKfCCKVIDr0GrFihDKlKwzUAYwTSi8m7vwm+o0?=
 =?us-ascii?Q?i1SvR3j+tStSqD7+lWh7a+u1sRjiQ1iuDYOx2Shw3IhTsi8NHrGWPymlPTOW?=
 =?us-ascii?Q?pRBmWiWcNlW+rnZMBsLC4oMLLmSa8ExXQVgljxGc3OwBX8spblZn0OEby84I?=
 =?us-ascii?Q?BNZBZiQwBa/jqSjiLPDZu7KNYmJZHOlE58NG76uohBWcKTmCgFfvCeczn+hV?=
 =?us-ascii?Q?EK6GU7+EWyixdutCWd6aajFUztD0Y3lEHsnL2ieGK4Ogd1MAaO/MaNPRcrc8?=
 =?us-ascii?Q?uNQBlVPIyJwDt+/Pj4bnANyk7aweMA+LeEYhY3ylnJ+yvqIh+FSYzpzd2HWj?=
 =?us-ascii?Q?nzt2E716KhS2mLB8pc6l6G1aIUqsHzM/al3OTq21vBrejOv61HlNx3ZFP4Yd?=
 =?us-ascii?Q?pOk1iyvYTXkTLW21yzRIvnj5Mt6CcxP6Oha1FRnkVm5Vg6MiC97HPtOWDvKS?=
 =?us-ascii?Q?etaQE7ij+wIuCZi6fzLCf/Jvhf3Cy4bN0LlcfFemNoW6PBtgwpEPRszN/SbH?=
 =?us-ascii?Q?7VNcvfGLPpL/+KuYM8z5RPCq/5GY4LL1s6dZWI9HFeu3Rr20FP2GD5qNqCSA?=
 =?us-ascii?Q?oMs8FDRRt6rlJoptbHtZt8yqdlyGh2PLhCf3FrFIXIqp3UUeIX2RnlWETDCm?=
 =?us-ascii?Q?C8M34wAtGggZ3El+uner1vRk+kjYAt/4RGhY8LreG171gwEAwbAMw7MM3CV0?=
 =?us-ascii?Q?kyB5oniTh3J8caPJNbrOarRqYVRe+3TlYPm6Ih2CqGryvqosmuDJQeRp21WK?=
 =?us-ascii?Q?98zAVfcGQ+ejR9plmV1RTPN8jqdNdGLyAyr6MvGswlCn1tSIdIuRlXg1mJ7T?=
 =?us-ascii?Q?AvZaZhTd91VfLBJgBuMZYv4f9QPEc8/e7ecwaAKRXxNrf8aQ7e0HYLVFc0Q+?=
 =?us-ascii?Q?fUNd9Hi2lOj09e4BV27hvEiswTqWBEylJMkmc8vFNmxVM/3CmaeUywzl6iKF?=
 =?us-ascii?Q?S+KHmXDrvMX/rfJVgTlk2q723Mv3LXggYkIf2yINvU1fYXDxWsS6wt3L0kJG?=
 =?us-ascii?Q?Ei6jSVlBQcWGvXVwKFZPqLng9j9tRQPtzDBBE1Zv2qV5sQS5kLirD8oYOhGW?=
 =?us-ascii?Q?4MEbS9XQOMQQGzFX0FhKzGm3GEpSFC6Z0AXLe7x7ZNtuxxxSRBQQAGhT2Uek?=
 =?us-ascii?Q?QQJLFbdVVkMsRouum9G2K/4BX5oKv/OmH8B3J9Vu3XbhoLUUfjfCyLYaWOIn?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6156d3-c7d8-445b-7ec3-08dc75d9deb7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 18:56:18.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvQd+4u/fCOwN9Kbnn7b3MeH8NBfVvUSwENX4H6pZIxREOW66OyaS2Vu9sO2FH5rAOQhSpnYKeETrxGPupVMQQ+uJh3dshpds3k23CzMCFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

[ add Steven for a "deprecate emitting hardware errors with explicit printk" discussion ]

Borislav Petkov wrote:
> On Sun, May 12, 2024 at 04:45:08PM -0700, Dan Williams wrote:
> > Yes, my point though was that if it got deleted I doubt anyone would
> > notice. rasdaemon explicitly does not check the return from
> > open("daemon_active").
> 
> The intent was for userspace to open it and thus it'll increment
> trace_count which then ras_userspace_consumers() reads...
> 
> > I am also curious about the history here. This "daemon_active" scheme is
> > an awkward way to detect that something is consuming the tracepoint. It
> > was added on v4.0, but Steven had added "tracepoint_enabled()" back in
> > v3.17:
> > 
> > 7c65bbc7dcfa tracing: Add trace_<tracepoint>_enabled() function
> 
> Ha, I usually talk to Rostedt for all things tracepoint when wondering
> how we could use them for RAS purposes but I haven't this time, it
> seems.
> 
> > So even if non-rasdaemon userspace was watching the extlog tracepoints
> > they would not fire because ras_userspace_consumers() prevents it.
> >
> > I am finding it difficult to see why ras_userspace_consumers() needs to
> > continue to be maintained.
> 
> Well, you still need some functionality which tests whether a userspace
> daemon consumes RAS events. Whether it is something cludgy like now or
> something which checks whether all RAS tracepoints have been enabled,
> something's gotta be there.

Honest question, why? Lets deprecate that path. As an example, this
extlog path has bit-rotted and not kept pace with the same level of
error reporting that is available via ACPI GHES or OS native
tracepoints.

Given that is has not kept pace the next question is whether the kernel
should bother to maintain the contract => "if nothing is watching
tracepoints some subset (all?) hardware error messages will be reflected
to the kernel log".

I would point to tp_printk as a way to get tracepoints into the kernel
log. If that is too coarse-grained a replacement for print_extlog_rcd()
I would advocate spending time making tp_printk control more
fine-grained rather than perpetuate this duplicated emission path for
error info.

Something like a new annotation for tracepoints marking them as "emit to
kernel log if no-one is watching this high-priority trace event"?

> > That would be odd since there is no ras_userspace_consumers() in the
> > ACPI GHES path,
> 
> Probably because no one's using RAS daemon with GHES. I at least haven't
> heard of anyone complaining about this yet...

Well no, there is little to complain about in that path because that
path does not play "is anybody watching" games. It always emits to the
kernel log (subject to rate limiting) and then follows up with always
emitting a tracepoint (subject to standard trace filtering).

For CXL I asked that its events deprecate the kernel log path with the
hope of not growing new userspace dependencies on kernel log parsing for
newfangled CXL errors.

[..]
> > Would be great to hear from folks that have a reasons for kernel log
> > message error reporting to continue.
> 
> Right, from my experience so far, you never hear anything. :-\
> 
> So if we do anything, it should be something simple and which works for
> almost everyone.
> 
> With RAS, everyone does their own thing. And then there's the firmware
> which claims that it can do better RAS but then f*cks up on basic things
> like *actually* shipping a working EINJ or whatever implementation.

*sad nod*

> So in the end of the day it is, oh, we need our drivers in the OS
> because we can't fix firmware. It is harder to fix it than *hardware*
> :-P

At least when the firmware gets out of the way Linux has a chance to
solve user issues.

> > Uniformity of error response to "fatal" events, but that is mainly a
> > PCIe error handling concern not  CPU errors.
> 
> Sure, just make sure to keep it simple and generic.

Yes, tracepoints feel simple and generic to me while kernel log messages
with rate-limiting is already a lossy proposition.

