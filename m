Return-Path: <linux-edac+bounces-4578-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C46B2553D
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 23:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF9F7BCD8F
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326528AAFB;
	Wed, 13 Aug 2025 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApezmaRZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BC2C0F62;
	Wed, 13 Aug 2025 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120032; cv=fail; b=VLoA3bX1HLGhFAu6nrJbPv0tqWJRdwsncyeItEeUJFCZEhF5rG8CZLzG2+fMC+1lXoBuftZ5F3WgYNPF9vWF3pAKMH071P30rOJ6LHCOTJAQ8PzDQbDX7gG9m6AZLzQ2AOoZAMsonfgDiPfxacj7mV1vXGzZwxOU+SVHMr7qTYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120032; c=relaxed/simple;
	bh=gsIXsrR3zoAsCTWZxFa/B3/ZXFXgh0QXpokBY5Cmen0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lm8SXX4ZrQj/8fiSezIHN6O5HY7vPWeaw47MwVQ6b8QDZ72C6LcHmzaLTB8HJLMkNVu8ikzJcTRje6pJCcJ0qJucMjhhJrLFp/wxFaoVr7Cu8JY3gdpcTHSgA9+1PJfYiJnmOzFbTLnIrbe/TxJgNBZL0n99oCaM4V96/slL+e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApezmaRZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755120031; x=1786656031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gsIXsrR3zoAsCTWZxFa/B3/ZXFXgh0QXpokBY5Cmen0=;
  b=ApezmaRZcIH2BhLtsOAROdU7E5VrZcJW9ckEBO6EYEeulTG7sca1zjsA
   4ATNVroL/i4t6Ok3TAEUdahdl9T/WC4Ep6Q5hmPi1XJntsFYecNCghAsG
   MAZAdWEfkg1DWYg27GCAOMYDBgg4Y0WWl5h+ns068PrFFdHxLXDhAblVl
   ehrGWMegKC5sTj+Hr4P4pphfg2joOpMZhsAtdblVCqH3T38JBm3BdC6Pk
   20DnDs0Sy7exOcXtMwPjmPi+BGhBAO61cUBQOOGJfSpArHRGM+DDPEWei
   8FK4OkCcPjSDUtYIEbDMRS0ZHFMhijb0DYzDo+1B2ZHKAFkDn52TXjxOx
   g==;
X-CSE-ConnectionGUID: zyuPGuXaQzWttv8BJYMwpw==
X-CSE-MsgGUID: U4YYi7tuS/6KMrhdkjljHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57297754"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57297754"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:20:31 -0700
X-CSE-ConnectionGUID: UkDpQ18IRAaN3ry6W1VcRA==
X-CSE-MsgGUID: tKidatGaQ6ea0QiJM7RtbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171915535"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:20:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 14:20:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 14:20:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 Aug 2025 14:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaPX4AnSE+40qV49bonEJRN8YL9lHSonWNGcZfkLNVpRypifirOpdcC1XSElM2MIcXfxOKAUpnoJOUBLZqSoT9FusVhxp0r1DzgM/yOUQ0gHQA4El8aOxloV49B1g1m9j7UfsWO+xsiSWpVgic9t9a0xWJSHTJlXQ7rTcwi0zo1SNLJvDJu7zrP9KEEcVPnF5SyhT6vytktfHPyr378rh4K+bidGARGsztpNBLx9IUQvs93UWLlbG3/vvrrvxhcc52p+h4Yva7DXnUMl3hkz1lZeKa9bRgjlvIBOID4cPzR7GXyJi5DbTvfqEXZUD18bczSK9JLoR6sDEfW6sLCW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZMDDe+aaTITUsVffdwJKTGFQnyDGxRI/FG3P6TsqqQ=;
 b=VlDWcZEz4CJGrSnFDZw9X7dYQ0HnL9vPlR5j4bKtzWfPvb8IJOhpd4xRGZtAfHAEXPAiccxWp8WtwYGfjuHoP/L661E5C4a23g7p/vEC1ow1VKg6o2fKMrGrizD0AhwpBljgEvRDtmYXqpl69k0OjOrathJqkJ61i97L+wQp1YJ1RoYLHjNHcCbH04G8bHdbwh2OM72TBkdC9XnIzUI6wSe1doKBf+V01RQKNlzNPYJOv5jRolOSvk77t7P5S4Wj1It+ewnCFofn7JO2Fw1L12LG54eWmgEjgEcRjXcaK9/dZywgrO2wzuvhixZVp67eiVYD0ncAIYBavDxcykomgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 21:20:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 21:20:27 +0000
Date: Wed, 13 Aug 2025 14:20:26 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>
Subject: Re: [PATCH] x86/mce: Do away with unnecessary context quirks
Message-ID: <aJ0Bmgx7-h1uMFG2@agluck-desk3>
References: <20250813154455.162489-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813154455.162489-1-yazen.ghannam@amd.com>
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac241f1-2553-4cd3-7c0b-08dddaaf398d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZoMsl23h87hMUbbxGOg+N2dF7ygkW5GZumOe1QJ0evILeF6mCY8YQbwlaaN+?=
 =?us-ascii?Q?tEIF2CHKmv1CPI1KySghkB+hB1PkxGqM1JvsFCSNv2OWby9KEmhI+iWzOegD?=
 =?us-ascii?Q?etf73MEjTjQJK/eY6LN6doavxl8VHv6ug1UhynP50AJzpxNxi7BStfTyrZIA?=
 =?us-ascii?Q?KgNqNfYgN9kxUKNneVLvjGaMu2x92qFdC0eWqf+wtcE/Gj33u15kXZa2RY7M?=
 =?us-ascii?Q?t25FUBz9TQi8CicOAYJ+tgragnQtQOS9Gy+pm4Z0/QJ7V4roYqr9+7y5U4nC?=
 =?us-ascii?Q?r+CUQSFkEu5/1YFuJ/i8zqHpQt+ju7TteF7/sBtFRvy0pN2lJog2o3N8U+rc?=
 =?us-ascii?Q?JYWw/APuwdsHv1dmAgNOaMfQTFAXPGmWyrwOWW4bC6etPtT33KoTOfo4fHQl?=
 =?us-ascii?Q?JXDJhECSZqAuGZ5KdFrkQUDrRvJAphapRreE130JE2UgIWmQKuSTUFxXQtYk?=
 =?us-ascii?Q?NHcEwbe1mfSpYRSJ+bMSSXUyYuwvO/rKkWbo36ji+hbDSN1eTo4g/KfnqUyJ?=
 =?us-ascii?Q?5bMKjHL484dgf7cfxxHYmPdOF2nDk17Z0aZ294QpyIiTiMwVIi6dQ79Gypn7?=
 =?us-ascii?Q?EkGjkAe5FK9YAwuzTKekYp9k5Lr1tHJv8fR8X/UWVf5XeU7UcpZsXxGcRKke?=
 =?us-ascii?Q?04lJA4jIms8ibZ9dFqKicNd9+75nYgoi6XVvsEMH/nsnUpuYaRoYvqgEcGNf?=
 =?us-ascii?Q?GfEhz5BYNlRJ6MRWvD5Jl8vKTFBfAxiqC4hpyrgkzr1XSZu0uJZpcHau31w9?=
 =?us-ascii?Q?MCzum8hShM1JUTOWKFBnhtsxvd2FRimOyNiTL0rNptw2QvqWjxOudcnocq9P?=
 =?us-ascii?Q?960d0EiDWFnvhBxBu1NkGtjR3RGdR17c7fhSfB1ZBsUN9BBfK5pgMbT4JRfs?=
 =?us-ascii?Q?eMYqS2/05m/qwuM61MWdrWkeYTV2mg1RX9gFbdxR2Ri8Ju0MsqmmLjAnHeQl?=
 =?us-ascii?Q?LLhQH0IDEmIztG+wcqV2Zq+v1qH1NxI2AXDjUm6TQ0jrHRbipwwjWrycixv5?=
 =?us-ascii?Q?JoVRsqCs1Sd8db955AgZtg1xenqXlySzbIQyx33iAEg2q45JDZ+0HgBBCdJi?=
 =?us-ascii?Q?qxa0SAuRYOxy0GtYOp0larVm/1g3YrNiT5yzbWc6mI/qTrhMPlPSzcHf7amh?=
 =?us-ascii?Q?D6BN2Y3iiGSVMQHKTwCFWY4bwfT0IYWj2jzZCxgZXP90GqzGW4o/i7JfyA1x?=
 =?us-ascii?Q?UlYqCwbn8rPEY8LwfR9++MEt9c600YfTQAkiBOaMUp1nfP1c6Wbfvq2WyfRD?=
 =?us-ascii?Q?UZ7Rsb8m515Ffg/gpRbkuZZc0LXjNfpIgI6/Mch5YPvXD+Um619BXLneKtnQ?=
 =?us-ascii?Q?LSXazp3d1BxTheIrjpvUp1Mb1PGeZNFSR5G6ovVrDC1POdsGxSZ4MAX+t7lQ?=
 =?us-ascii?Q?NoHKN9XHOMxhjPQYa0SMTL8vuyBUw6sgJ0gckxrpupy/azTlYst9NskXt8ZX?=
 =?us-ascii?Q?AAqg+m/Wju0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3OCz3Hb+B4RZezxhCKWfkPPwjfXMIAVfpQLS9hua59IkCVnitczK3S5HHU/v?=
 =?us-ascii?Q?OBCe02wRNHRQdaJvD9VXG7zLbJX0mWhw+vO6V04L0vHijk9ca1DBF4e8rUeO?=
 =?us-ascii?Q?9ioytCTtV0uiAtkztLxzX0gnyWmR3ir/ZbQGwGiqGvPBjAAFkYM3urG2f0k7?=
 =?us-ascii?Q?l1H5353CAV1K9nqIzTxcLJly0+C3wcMK5eBtMWmpLMjuRYwn7w7w+IiVBLBc?=
 =?us-ascii?Q?Wq1WCcWnnLfX0ps3pGkh5h3ke9Mk06J/en2sbd3YGZW4QH4f+nIYOUlQ6jCM?=
 =?us-ascii?Q?DCquclw60TH5Hq549nK7JcnuuxtPF7klIrr/ylY8bU1z6176stkQSav8t8N2?=
 =?us-ascii?Q?r4+D8xSISlGrGl6/iKM08/retE3LpWKw8zV4rQWuuvwANec1DjAoJBnDOJZ/?=
 =?us-ascii?Q?HXkGdbQrJU4rFsnxb6kz8uV8ejjF0Vts1Fuv8voGv0vSARUALXDy0t58JdCC?=
 =?us-ascii?Q?tjlF3ktfmO8BKck/x13LzaCJaaR0K/BchgTkWCowpkSGuyr6xyT5AqFnBp/g?=
 =?us-ascii?Q?WozxTZsIjIX0u+2T9kTAf2GjefAjGnhAUVCILMp78chfXmuG/bZbJmpnWJUj?=
 =?us-ascii?Q?ejH7cKsp/G8j9H+3K/XlIBnEw8nqsjkB3ueQeN0QGxkkfacJKAYkEFZzQDIP?=
 =?us-ascii?Q?C0tPu2F5gBio47PDNSMgKphfVKEc1LbuOWoYBsq4juMf1r7s6nriNMWKHXmk?=
 =?us-ascii?Q?PoQTvMtzaAJnKL2TmzJmKQTQNWEgpMB0Vx9eSr7quP8Uiv4Z5qYL8xdYeacU?=
 =?us-ascii?Q?hUSh6JIjy3wIZID5Bgxc9UdwORtVV22gWQfyjwjmvRuxxY15Fj5pci4whX5i?=
 =?us-ascii?Q?GPEnv8VHmw1boedPG9qpn8mHydV4rC+LoEBj2GwbbgGENAcjpvBHjUTrChwy?=
 =?us-ascii?Q?t8wC8mgVOZn2ptjMVGXKeCdROab7g/g4zpIlmiezQSCCwyzRu1zA3soqZ83U?=
 =?us-ascii?Q?xlkGF8OsN4cyZ0ZfpiFjL0DgsXz/IkgQykon4rC+Rz68NBfBmuAB8gh6UPvA?=
 =?us-ascii?Q?YbrAn/Pcp7aoGR7KHfVEZXYYw/hikROy1VX9gc3DN7sU7OsNk19H5hcCb0Ys?=
 =?us-ascii?Q?bvwbW6g7MgpnkiSJ+VHygxjEJFX0RyZ5RSbAe4ZldKZosd+2oKoIAwfk7DpT?=
 =?us-ascii?Q?0anTEpB0NpqCHH5if1C0kQLVr9n/MHAmD1ZPRC2lIBsuFWkSjhZMrt/MBJro?=
 =?us-ascii?Q?7ZrlKm03jB9L2267n+CORzKCJ0jvsfKoms9QyOapGpv6qviczK5pBx1KP9Xd?=
 =?us-ascii?Q?pEoJIQFuMBWhQTi6XBdjblUi2Rb3QYjtzn46Ousox1W2nlDg4nPgRbQntUlJ?=
 =?us-ascii?Q?HuvOMgp8zrjxYdhJtEE0+km3vKoazO5lhpsqVRdEEQTR7Yh5H/+tBorSMIlR?=
 =?us-ascii?Q?vazaB/bCC3UTOULsyXoKcy5lBLyuQ+FAO/T7lRJO+QzRnBJD0UUm5izSNZJ/?=
 =?us-ascii?Q?+xhJHo5ADK2gu9UVdgG5ZlJMMvGdT6gM0iL9EyS73DIHA1eI2IKKqk9VMcL0?=
 =?us-ascii?Q?flMeZix13iBTqJpJVopUc8ql/BxdLfqgTu1Pfp+0105wcJyo2fb1KpjV0APh?=
 =?us-ascii?Q?G19yINoHP3U/vsKkRuDPEqfY0nXzt9XJrmQKW2Vx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac241f1-2553-4cd3-7c0b-08dddaaf398d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:20:27.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZhiof9eOuqrztRxm3CBEjIjw3QMX9nOJvDFGfYvhgakmpN8I7lLZAh5iJQtGkiQmSh5f0s+oHt7tMHEpUF18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com

On Wed, Aug 13, 2025 at 03:44:55PM +0000, Yazen Ghannam wrote:

> -static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs)
> +static noinstr void mce_gather_info(struct mce_hw_err *err)
>  {
> -	struct mce *m;
>  	/*
>  	 * Enable instrumentation around mce_prep_record() which calls external
>  	 * facilities.
> @@ -467,29 +466,7 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
>  	mce_prep_record(err);
>  	instrumentation_end();
>  
> -	m = &err->m;
> -	m->mcgstatus = mce_rdmsrq(MSR_IA32_MCG_STATUS);
> -	if (regs) {
> -		/*
> -		 * Get the address of the instruction at the time of
> -		 * the machine check error.
> -		 */
> -		if (m->mcgstatus & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) {
> -			m->ip = regs->ip;
> -			m->cs = regs->cs;
> -
> -			/*
> -			 * When in VM86 mode make the cs look like ring 3
> -			 * always. This is a lie, but it's better than passing
> -			 * the additional vm86 bit around everywhere.
> -			 */
> -			if (v8086_mode(regs))
> -				m->cs |= 3;
> -		}
> -		/* Use accurate RIP reporting if available. */
> -		if (mca_cfg.rip_msr)
> -			m->ip = mce_rdmsrq(mca_cfg.rip_msr);
> -	}

You moved an abbrevated vesion of this code from mce_gather_info() ...

>  static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  {
>  	int fixup_type;
>  	bool copy_user;
>  
> -	if ((m->cs & 3) == 3)
> +	/* Without register info, assume the worst. */
> +	if (!regs)
> +		return IN_KERNEL;
> +
> +	m->ip = regs->ip;
> +	m->cs = regs->cs;

... to here in error_context().

Would it work to hoist the error_context() code into mce_gather_info()
and have it set a new mce::error_context field?

I ask because mce_gather_info() is called once, while error_context()
is called multiple times (on Intel ... not sure of flow on AMD).

-Tony

