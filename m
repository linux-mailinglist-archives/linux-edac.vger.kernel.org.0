Return-Path: <linux-edac+bounces-4593-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20638B26FD9
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 21:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6691A1BC7763
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A402472A3;
	Thu, 14 Aug 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtQtex6b"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56F319860;
	Thu, 14 Aug 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755201255; cv=fail; b=pYGp3DQ+xGXhE8MXdVOm0Z/J6PP8T7v0VZMx78BDR9/s0wvm41Jp9zAnOZUjK476vHHxoEX1lfypABkI5ihegip/wcBGAaxxwQkHbhRLPSAzo2BUGJfWp819ab+j+SNQlJbesdCkWXxh+kJfa9uLTmqANYANzxio3tnCZ2MWAvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755201255; c=relaxed/simple;
	bh=J16+r2jmA4HC7USnajT2+2hXAcsFtZ20z3YX1aF3NVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JWpdNdEzILcddSAfUKUiwhv1ewG4WXjVgM4QdFCqF636R7jlOgHz9qDqd3hoKPcKiuW2U5GzjlCMSgTccQHwFIIAqY0U02DRqYWn2r+O7MYOFXQH5KHzZ4epOb2tdZx2auEGIHVdTVcjnY1PvVfHy39RDRzpme5IdW+4tKrGguI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtQtex6b; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755201254; x=1786737254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J16+r2jmA4HC7USnajT2+2hXAcsFtZ20z3YX1aF3NVs=;
  b=WtQtex6bcYnOpNWMwrnSEx+ogn31MZ5hPR+yRfhkBAbcf/qei0M1Nt/u
   VY6dHjO559IoDvFHiNZ9HFG07d1Oe4m+1vo8FK68OwNCVI9FWqp1IQQAa
   J1euqCnb5tX7CFYaYZWESR25dQF5tu8sy5yzT4WcriR/3y4wawdsAl978
   oGen8okxk97QqCxkYl9gOUB9b9imEN8reA1bKpfqnKMZO7SIOl2aTFXSc
   QOUaFv21VmXXtZDdL9rMfi5nQT8NhTVV5V6e1pmPGHeR9LoZ6Ht501YBm
   WugWAR8iAPe12Sk12szsTKa4yjdl2B3GNFtBvNPX54hnorcaTJYLbXZTX
   g==;
X-CSE-ConnectionGUID: WqB4OFKETSe5DGUtz0s0aQ==
X-CSE-MsgGUID: rCFwOW5IQACfI8oFNuhilQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61160602"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61160602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 12:52:25 -0700
X-CSE-ConnectionGUID: It104QLvTW2g1DtYuAjxkA==
X-CSE-MsgGUID: RDLvv16ATUazzrUq8norzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166338651"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 12:52:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 12:52:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 12:52:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 12:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtHLsekOK7u+n89ysIrBuN9cfBj7J1EHRgqOTrfUUD+P/QM3iN1CC5J2qeOOO17NW4pLqhgglh4YmoCOHEhFaPnMNr/Qs+j5U/j+/hBLT33+okKM3uxBQVz+adIad1GFl0WZDQQO8k8VAaL5ZZ2OOY3kIfY4CG4rxXuWBLRsMurNaU77mABhsCml75PnpFTSJfMNCON9O4mMgbIVxk+tOM5HOdQ9M+p/Yw6BvjE1XdFYVVJTyN472JlHKzHucAdsn5K0Qh/8sCBqZbM7R1n1NZJtZZwfXO9VdsWYADY6M2VbiBtUL+aAE2I+sPf8z3gJ30ql4x5S5trpmQrQr7slJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f26mIP8yLN5XfVfJiCag9B3zWx4+0r5Phm+NfHPUfQM=;
 b=YAwSWJBViFREYLNn1uCBDm+K3/RmrMx9mYw3+UI/YEimAvSUKLlKKuIOS1Bqj3KXay4oQMHiW6b+J9NcsKuKiO1d6tnbuKJgQfnGOh6XSGEnX2fcliKJj2+yzxcbr1iYXaSA/ssPwblXrc2b+NgBj/Ce1S06XwTbU7VmFhSCNeWr2JICRKM0DaQQVb5IbeRDq7fF6ebEZRIumiwKaTJY8DbQL3wtIdqdvI7iXKiVt74D8vzaApJ8cx3tat2omcb56jSB6B+GukzCMgax2yUmHVoZPyFtGZS7Pspr3ETtx9F0QfbBa/ukGELNf2ZflvEE4p9sPFdKZLOH1pYBMHcnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6556.namprd11.prod.outlook.com (2603:10b6:510:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 19:52:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 19:52:21 +0000
Date: Thu, 14 Aug 2025 12:52:19 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>
Subject: Re: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Message-ID: <aJ4-c0gNPbwwU3jk@agluck-desk3>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
 <aJ4U3g4fDNNibUOz@agluck-desk3>
 <20250814193056.GA192444@yaz-khff2.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814193056.GA192444@yaz-khff2.amd.com>
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: ed41e2cd-43f8-4812-73b6-08dddb6c14fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UsxOM9kVQjrdeYFUXsmkNkynI876xnUX+q94p1acEJsCCkOzqLHqGayTc0Ik?=
 =?us-ascii?Q?7qTYKWdtd84LcXwkqS8L1SrRz25l/IJvA7f7OBs7EusE5GZEr4l28AC1HuC+?=
 =?us-ascii?Q?wQ0I3d2FBsMaV7mY8rHCb9PowmoBQirthPL9qokNok8Z/FmuFClKQQF/66O6?=
 =?us-ascii?Q?eBZgdnLAQ7aK+HdBfDWm1JB6wz4+f3K/XX6DwFcTyYBLVsydfMRMPxZIbubC?=
 =?us-ascii?Q?fQiNeQlo64Kt7QqwBzEvRwCh+HaEUZQGiw+00U9xqs26bjl6E/fuH5cOoh6X?=
 =?us-ascii?Q?sN3m8tr4zhal7oMUy/LAtm4L5bZDyEGPOykjO/cjPGTivXdi2kr3gIiCCW1S?=
 =?us-ascii?Q?vRJVyLKp8ts8WUB6qqjc2rOEH26+NIZ7zQtzoxtu85mOfeNTCva59n8SZw8v?=
 =?us-ascii?Q?m5ZGvSfm1WzIguQgyia1mhpWgFNGnQUFIdsxw0ZbQx20ywZBII8YyXc7iSu1?=
 =?us-ascii?Q?xJBJBKNlCLqHMI3ZWCkkT961cG4xjFV3DxQMPBLbVhxZlmXqdQl2ckwbNzpZ?=
 =?us-ascii?Q?OgIZewudnXAQvBYuSvh0gw/u3RlGDem18EI7i65ToCU5HQlXfVcLyMZ57IGW?=
 =?us-ascii?Q?ooAlCfYi/fLFgiDP1MQnlaF+Fxl4gpuH5ye+8/ptW3tlPO0lCxDqVRjj9trZ?=
 =?us-ascii?Q?E9zn04/w1uLacpzaLgr6GMUzqSo/R2dgqSpt3It/Hi3YH/MQ1DifTS3+uQVF?=
 =?us-ascii?Q?giTCN2WVPNIL59x41qR6LJtpV0VLD/UbfPOIjFbEcDyAbDsR8+bIYtB6gx8F?=
 =?us-ascii?Q?qBPFLxZriTCswPus2ldjgrTbfWjtAHAA2oPRKNW3v4iQoOq2nMaHSQkKdYc9?=
 =?us-ascii?Q?1vOFjq58yyN9dpCPZQ9o55szc2K//EHd1NviTPBmVsQjaQcRZ9ieHQycoZoc?=
 =?us-ascii?Q?HQSZjHKVf5fPVcRwNWhxvxD1T1Xd5qavvqH+mVlVgAIWt8d5Cw8JFU7uknQj?=
 =?us-ascii?Q?ytqZSFgp/SsUw9IVGTMhguQ7oooqhgbl9exmQRVnOIhQ/wxtXMsjnzrScckC?=
 =?us-ascii?Q?4zhFVmuWfFiizRr//zHh2oZTgwmGLkrej5hNOZSWODL+pyuJbENKu8QlP3uz?=
 =?us-ascii?Q?ZkMPGqhoj+grqhI1boeRsm7Vk/1IuiPh/ua18pyB8pYs3aS3jExTgdGEhPVg?=
 =?us-ascii?Q?gdt4XA+8uLN8r6VqGAbgJBUjev2v+XlnX0Wz5OX9axPg/KatNJg1dGo5mg7P?=
 =?us-ascii?Q?HFvjJkX5HQVE3y4/EbCg6i4Je9kDqqjHt03fN4gM1CZKbOpbj6rUN/Fp6tud?=
 =?us-ascii?Q?XJ6kyV9sx/Mu2dJUjG/OjyIIoubyyxAIn08ZWTdIKERrkiLeaZScACEHkbx3?=
 =?us-ascii?Q?/f3JHSDH+yHXS2LUU8gtBNm41UTKf7FCze7IbnTD2flfgoY49+wUNake5uhI?=
 =?us-ascii?Q?JNLKyLvSAE96+wRMDSReYhhy11oetQxX8gOXk5JKkliD1ysGXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Nj6jXeRNZXlqeAEAvGM5w908/mJiXI2W4JlzeDKeO0Kyl7IospX3EO8i9Wj?=
 =?us-ascii?Q?z0naMnMJrSlrzL+uu7LZ/GOSJbpzG2m2AUrmwN4bh4rtaCfm1OEjeUDCkRPH?=
 =?us-ascii?Q?DNfW1CpAYPtQEyxkk6h9PKOXP1UYFxcGm3JNiDjEVkkDiyHQDloLDYN1v0P+?=
 =?us-ascii?Q?nAta4sCKRQ4X0BP4x/tSajYKcrrB5j4Da2k6YQVcpBdzWrINj0134F2Y9bEk?=
 =?us-ascii?Q?x3sCzFyl2ao4DzZ4vcSLDegXyeSARgVpGniM+POsr1suUSAmLAXwNNQjuRCO?=
 =?us-ascii?Q?DCNb1PYlTYkeSEf5w4qjyHTF2FNX9Hbnmsc3CGNRu8/9H5PEB0YMHESd8pPs?=
 =?us-ascii?Q?crGZRqhB6E19sMf8leiMcuXgsUM7IOKaQ9knfahlqMveZqXrpUQPtbwznw0n?=
 =?us-ascii?Q?Bi8o748QFnhm48lnuWu4l9b67i+MNWBj9ZASEvLoFZ8RGFmlnU8DwX/OFLvf?=
 =?us-ascii?Q?AjgKlhZDt+FFVAFyruXPofyoG0XxM50KBZl6SpLUBIWnAo1MCjqybaIMJxtY?=
 =?us-ascii?Q?IpFHqhnz4taO7tDVAPA0UAqcHqjkBUwCmVFoBJBkdXrbEKpKHRLNZdraxIPZ?=
 =?us-ascii?Q?+2fhGUuQ+L1vexdw9xaRIVxyAiyNceRr9d93JYcYxR95FsOOPwlCQhzwaaMM?=
 =?us-ascii?Q?TMac52OPBPX3ufpt92Bl1aDPNe+QTGboWpZZm3sr0EINjh3RrV24PajA/63i?=
 =?us-ascii?Q?pJWSX92FQ2zv7LfIFs9JCJlh1SzkURPSYai/E3jl5epRF63JOtnyzZzDQyAx?=
 =?us-ascii?Q?7hkVbrPHQRrET8q2JniivodsbxGC2tohSnYuDy9WQcRveD9H9QpnG+mqHblA?=
 =?us-ascii?Q?JbsBl8WsKz3PnLD60tLZItkNfZbwXVMvWEGva7/Txziz6j5Uy4I/3g7LL3Ho?=
 =?us-ascii?Q?sKv0+ytJ+LYuHpoYEyH1PEaZnXgbSf/utnRU4m0asnLQnec+HgIArkP6/gfs?=
 =?us-ascii?Q?qjE5B/mJzfUqshSw26r2Pf8eoCTNEeGZYN68G1E+Bidt0OV+l8dVZLWBRgUr?=
 =?us-ascii?Q?1W9E57XcgkLoHZp8sgCqQDXVDY2PdiTsF8AEB/DVgEKYX06NJeYeBdz/4WRP?=
 =?us-ascii?Q?Wvg0nBu+wgh4VAP4ldqAkKdA90ClTx8V9gvKRr8FhvDdDFjdRqqChRA4RfYS?=
 =?us-ascii?Q?R7QkSQjN3b2m1hRvQFNfKJ8K36eayoEetxLf0ODRayMU168Yljpwyf1UWuD3?=
 =?us-ascii?Q?eZS/52OuOTXBKJ3+inrDVJ1H0M6sGVR7yOPHjEzUZROYfjo3zsU/LJwcWZ1k?=
 =?us-ascii?Q?Jjwo0l3HuUoLzV6ggQ+OkKjRuCqMr6hpQnwgPrRUsWKT96ezkgYl1dlUFuI0?=
 =?us-ascii?Q?An9sljMeQkHw/zzimAAyjI6E6Mu8dFocZ9uhiyeLQ5tnH+PwNPm44DKlVZMH?=
 =?us-ascii?Q?SB2COQV8yx45M3WIBOFyKROpkE1NaPbAbym7fjHgejG0geLixzlDDmVHHF+u?=
 =?us-ascii?Q?XF/uSJ1uo/jx71uX9aKlPWCFwtxId01bRVMsnP8bvUFGP2oztAhMMfOR6/wL?=
 =?us-ascii?Q?IeA9Q3at3Oh2Xu3tWUsVpOtspHcyn7fLulOoqWIOyb2WE1HIytaIoGdnTYRz?=
 =?us-ascii?Q?AIK8/5rC7MZKJ1Yup6wl/NSFRd2fdvOLGu0e843v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed41e2cd-43f8-4812-73b6-08dddb6c14fb
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 19:52:21.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaJ1GM9Ec/VzAQV1ioPeKP0dyEhUqkIOEJIP2wdK7GE3Xjw/tet5AU9Ah3Q9ilqs3OvOjpWjMrXZ3B84rTGScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6556
X-OriginatorOrg: intel.com

On Thu, Aug 14, 2025 at 03:30:56PM -0400, Yazen Ghannam wrote:
> On Thu, Aug 14, 2025 at 09:54:54AM -0700, Luck, Tony wrote:
> > On Thu, Aug 14, 2025 at 11:48:09AM -0400, Yazen Ghannam wrote:
> > > -/*
> > > - * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
> > > - * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
> > > - * Vol 3B Table 15-20). But this confuses both the code that determines
> > > - * whether the machine check occurred in kernel or user mode, and also
> > > - * the severity assessment code. Pretend that EIPV was set, and take the
> > > - * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
> > > - */
> > > -static __always_inline void
> > > -quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
> > > -{
> > > -	if (bank != 0)
> > > -		return;
> > > -	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
> > > -		return;
> > > -	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
> > > -		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
> > > -			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
> > > -			  MCACOD)) !=
> > > -			 (MCI_STATUS_UC|MCI_STATUS_EN|
> > > -			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
> > > -			  MCI_STATUS_AR|MCACOD_INSTR))
> > > -		return;
> > > -
> > > -	m->mcgstatus |= MCG_STATUS_EIPV;
> > 
> > I don't think this part of the Sandybridge quirk is covered in your
> > new code. Without EIPV set, the Intel severity table driven code will
> > fail to note this as recoverable.
> > 
> 
> Which severity do you mean? EIPV is not needed to be set in any of them.
> 
> Unless you mean this check:
> 
> 	if (!mc_recoverable(m->mcgstatus))
> 		return IN_KERNEL;
> 
> This would never give the "IN_KERNEL_RECOV" context.
> 
> And this is the only case affected:
> "Action required: data load in error recoverable area of kernel"
> 
> But that is for "Data": MCACOD_DATA
> 
> And the quirk is for "Instructions": MCACOD_INSTR
> 
> So I *think* we're covered.
> 
> I got the impression that setting EIPV in the quirk was to fake our way
> through getting the CS register. It seemed to me that it wasn't directly
> needed for severity grading in the quirky case.
> 
> If we unconditionally get the CS register, then we no longer need to
> fake EIPV. At least, that is my understanding.
 
Yazen,

It's horribly subtle.  On Sandybridge machine check bank 0 is shared by
the two hyperthreads on a core, and machine checks are always broadcast.

For instruction poison consumption both threads on the core see the
machine check and the same IA32_MC0_STATUS value.

IA32_MCG_STATUS is per-thread.

The thread that tried to consume the poison sees: RIPV=0, EIPV=0, MCIP=1

The innocent bystander thread sees: RIPV=1, EIPV=0, MCIP=1

The innocent bystander matches this entry in the severity table:

        MCESEV(
                KEEP, "Action required but unaffected thread is continuable",
                SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR, MCI_UC_SAR|MCI_ADDR),
                MCGMASK(MCG_STATUS_RIPV|MCG_STATUS_EIPV, MCG_STATUS_RIPV)
                ),

I need the consuming thread to match this one:

        MCESEV(
                AR, "Action required: instruction fetch error in a user process",
                SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
                USER
                ),


But the first match nature of the table means that this rule hits
(becauase neither or RIPV or EIPV is set):

        /* Neither return not error IP -- no chance to recover -> PANIC */
        MCESEV(
                PANIC, "Neither restart nor error IP",
                EXCP, MCGMASK(MCG_STATUS_RIPV|MCG_STATUS_EIPV, 0)
                ),

-Tony

