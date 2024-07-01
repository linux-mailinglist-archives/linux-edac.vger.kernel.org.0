Return-Path: <linux-edac+bounces-1444-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008691E5A6
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 18:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36007282850
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDCC16E895;
	Mon,  1 Jul 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="11+bdZIT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490816E883;
	Mon,  1 Jul 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852230; cv=fail; b=JvDyIrJHKg1NT5TM5Mz5RTiuefKQUjG78EIADEJ+1MhhHJJM1jenuQE5TRXsMein3cu57jiOoxfnC3IkN9FamZOgkmflJyKk/7WODcS5UETGcYGfdRplBnFEwf/hE9faMbP97B3ZAC+Y64kMwkOQ5PZRyFPVJ2dFvCcGwQC6XwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852230; c=relaxed/simple;
	bh=iZFNVY/GwHXwNBmvsclvoYyjPpTbgQjPx/l3haPyau0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pV5oBD8l3CtFAppJ9v0beIBuc79OKZI8LUlRKlA+8uSsBm2WLm4gtCcDJtfSKJbkrDF2AMCBGbA1McFjFv7621sEq64wuqQ3fPOH9f3l3nEY6jo2GjNXPrLUfNbtId0S8szqlxuVP14LwO+RfUVmF0yHxz+BjZHpPghKVtuMk1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=11+bdZIT; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEvdi+/KDNIytcQ8CkyGP81EaGMwCvbSd8w0rJpx3tdfdPIdLQuiROmn0QzfkF++/yWYhZFoG7TMSF5ozs6WG4XwBNnGQEdpkGGpr3zk9eJRtojcOPIPpuVznFL4lUVVtpLpgY2ryI26geSfJesNKqCpwVZ+hwKABLHFlSNDK1WjUHgWCRHb5WRmi1UUd3Fyy0OzEZMKbDBlKT7tPapukFnBUmjknDvseu0/+tEDd8wKyr8lxV6rSLLGZzodTdv+BWiYWmEaD4IgXhTxgDM8sQszW9qxnikkGepNyjSNcAdAnncfYpZb9N0HvdCOoj2wwDa8MC+816i5Qm2MDTkJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hfENHmdYdJnVY7hvQxMwddxShn+Be126iDmcuEF9h4=;
 b=Ot5h4hBvzpXB/Pz4/MZp0uZjCbs2pDN4PE7KfRXlRfgdUrj5HOYoscpFFirgYzYBL5ZqxQeerjqr1iAJQAhrelgfdGoaffkxPMsJpGK6aRfigCa8Y7rqxnwa8zjXHEtSsErRq/dTGks55uaTxAmnP2nj5SUvm3cZJj4xtykg6Pr7GVwRy3ViAHON9LoMEa3KNZFvw33dgQBTX+ZODkCf6bDblEjxq0QZ8WeqKME8bYljImnjGON2/H/Hb5KPE+yprhvD1mrjiWeMWBfBMAQhbnkk9Rg1r3OIEyIwLhEX7lO2/NkXwxqMMuA4W000j5f0PMF/dtTgRI9d2HDrSSV92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hfENHmdYdJnVY7hvQxMwddxShn+Be126iDmcuEF9h4=;
 b=11+bdZITsIJoc/rJ6ujezysnVtVZncXflO/CJFu2sa1kWz7pg2lr5s6205HADJwLTONlcPBukWe0Q5huPYlJRgGbYL+WiIAzAIB1+n1xONrzcGZsW7aHj75+WhwB5VxnwJq+bFc5hyOY3d5GWneNVKq8/OsDOiIohrm8Oaxo7P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:43:40 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 16:43:40 +0000
Date: Mon, 1 Jul 2024 11:43:35 -0500
From: John Allen <john.allen@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system
 physical addresses using PRM
Message-ID: <ZoLct9pSnqXm4OFd@AUS-L1-JOHALLEN.amd.com>
References: <20240506174721.72018-1-john.allen@amd.com>
 <20240506174721.72018-3-john.allen@amd.com>
 <20240628074522.GDZn5qEkTXG0EvQ4Lv@fat_crate.local>
 <ZoLYCJVfoRLJbGtW@AUS-L1-JOHALLEN.amd.com>
 <20240701163424.GHZoLakCmNflWa_Lzm@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701163424.GHZoLakCmNflWa_Lzm@fat_crate.local>
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b53550-bacc-4952-f7bd-08dc99ecf5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evLHS/9m2M1D6uveXjI5ZHMQdgKyGn6Flee/dpbaY1PeEKGW+smq9GHO4EGQ?=
 =?us-ascii?Q?AZl0o4QIXyDyg6hdTlgrbmCuZU4uFkJje5zo4UUmx273H8w0m+yV6emf+IuK?=
 =?us-ascii?Q?hlQV+RxtmQxiQ7hzE6ZxcpIW72KpSkNP/WbW0K5LzevsYFks22xI0HiHUzwE?=
 =?us-ascii?Q?bnDJLRPXqX+G8Y4a0mrmq2b76PszxapHb2t/8TWthn6/3rUypbi8l1XdJbIw?=
 =?us-ascii?Q?YRBFbE/BvLd9ZCh9Sn86anbmTJCW8J7KnJwqf9I4l37OzAb3dWc8DFUZvZK7?=
 =?us-ascii?Q?6VtwsWzHpDM+vqKjF5k1xSLpRm0RoncEZdu6tXftbiAelYHpEAHAnDLCQ94z?=
 =?us-ascii?Q?7cLQtPEJfC4Pv4I9V4Meslntv4Piyv+0D9tcU5LVfv5GyLGMSTY+wd1KkD7B?=
 =?us-ascii?Q?8kzR81P9UVFlBmfhR61MoIqTmUfJ951b9VBNPbMB1ut2Sz1sahXkuwJ6L2LQ?=
 =?us-ascii?Q?KsNt0nbCor79I3rwny5k1vjJKrr72UszwcgcBj8MAkL9ftFMcvPaqDys8N1q?=
 =?us-ascii?Q?RYvvSzRKC60znHc8Awf617RpqLHx9t+rM0r7S6jFJUVgWJb5eZb1xVyrt8OX?=
 =?us-ascii?Q?OCfnyh74OEAiJQXjZ1X6JQ+tijRSXtmbioC9l4bcwT9ct7wKT0vZ+nQNC6nu?=
 =?us-ascii?Q?o99uirq/RbQ5wDo4vKtDtxSjTSMzoxpm5d5n87i6NZTxqz/U6f3GTZlBNRYr?=
 =?us-ascii?Q?05j+5vt44d0W9/jMTR/H4yY7mXTyYi+Ze44KEGV4NiZS4lwqD1e4ELhS7STo?=
 =?us-ascii?Q?MnWf26phLLS6dtnhKX+G5QZgJRoKAUPKSlzQ9FQjlvzItde0lFXNz9or1kE4?=
 =?us-ascii?Q?SBt6hjhI0tq22fg68XhALqefRS18+p0dBK83D8VepaAf7EahE53ng85KdLQa?=
 =?us-ascii?Q?uZ6R3rMbNSw7IJhRkSYotHFtdYicw9AAb0g96Mab3dG9bOQ+uj3a+XLTGDhl?=
 =?us-ascii?Q?r8wu/FJxsRVubKHguqQjJpVnbBg+mvCWkyXHg8ZkrHdsg9DPGivvwvmzuBkx?=
 =?us-ascii?Q?0qfpYGS2zSbG/6/1Q2tfmBO/yQ+uTafOSsNzPubm8oXNQ8iYNcaVcK7fyKaF?=
 =?us-ascii?Q?5kCcbDjf6ePLbUFSQHOwFcGhE20ulMi7TmzobsFRZJIwFbRv6il4SASqFZ9d?=
 =?us-ascii?Q?j5DT/LIoAbv0tWV5PLL2iIq4WgbBGDPZD9N31P6Y2+eZyVpNQfjoKr9S4al/?=
 =?us-ascii?Q?KjI3P9RTcnlXGz+hdHGwD/ShJdkqMtrwig0pImXAS3VbVTFHxozLpuhZlLi5?=
 =?us-ascii?Q?nsh8fzL5Piz0MgVEom2blZMPIdZKIZmwwnfMc0UWKtraBVs0dbvFQW8KPMMo?=
 =?us-ascii?Q?CMnr/phfo74niTxVEsvJ4gkr4y9mmujOcbPXUf5mltVhbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGccDgmn6QyrUCx+Pg7IBN+15PzOdxesqgmUsVnKDs7XVxSihaado96PFDOq?=
 =?us-ascii?Q?fUSylpuzYitRrkQOwVgFbmkZ0KAXhLT4IM3Ir8dUhxiYo8JiYwPRLzr27Hs7?=
 =?us-ascii?Q?exZvB7e+XLiw+w4D+YVZ3kE3nkDn0Jj/lp/bt7eQ88vJbxB9zc+R6VlDey6R?=
 =?us-ascii?Q?7IUM0/CooqOMNMomHWZCWsKxko3ubCU5S46/vICcv3H0aWKhbAm64SDAMov+?=
 =?us-ascii?Q?OJMdPKK1IcppIaA3Hlb+c6N3aBaukC4EXYrmHxpYFrvDY5C6UZ3bBrxa3FwV?=
 =?us-ascii?Q?F+8eg5EAmuotLK42ebH4zLAemaugoE5iES1C98jMpjsG6rksSaJT+/eUJOvb?=
 =?us-ascii?Q?QJ2VDW0hcodqzh6+lYklttTGwp9UQ3PUV5Mp+Vu0bRRZm/Nnvewsk1SXBUdr?=
 =?us-ascii?Q?vbBRwF4uDgpsXGdHV4B+glXEnQSAS3GS2CaW0B4NWnzLdOtbmQsF5pLblxjE?=
 =?us-ascii?Q?cHy+2Fl59JwtNnVVqtM9fCfA3jj3269R4Qc5Z6hHB8xjulMgtXL1QVCFIsez?=
 =?us-ascii?Q?s9mjknqASu5unioAiXtYE+iaprJeixUEIsdnfzYifHVZnQlP43EI9hrfvLe1?=
 =?us-ascii?Q?Py/TZYeqScC7DXkDsIf9qsFxxoCAsqyHqxRTRY2SI5grscYxQg3FRNzYEauR?=
 =?us-ascii?Q?FmFN58MG2+dE2v7O+J8PtbBbzQ9+5xDckZMXUuGbeQ8KWkw4yFfE/+pzcRET?=
 =?us-ascii?Q?FlOgy9WvdPKFju+zbMlXWOz8QY5sKZ/P7HTvQ3a0NcWOquOR+8Fbj/uldcpP?=
 =?us-ascii?Q?w8KLGzQRbceJ9x/hnhEtA9mcAIDv8n3ZVJAPawLTH2FGIqe6mdJnIaioOpff?=
 =?us-ascii?Q?A51lS3GqPcKyVxLea69ymMfWV/Bujet9kxLx7HFWyndefx4fbjtx93ryGG6d?=
 =?us-ascii?Q?i2Z/vor9b1i8JIKT4RnSXyI4NrGuzpZBRtXkitzd+zPU0PpqgBbJ5Eloyyg6?=
 =?us-ascii?Q?bpo06I4PS/cAGr2wiafD/1JwBIuW5dRVM9/i1VluZNW+y/LYJMjVMeL2tSwR?=
 =?us-ascii?Q?V8/TXUYlNlpYPGFwvl+RvtCoXfgzZviF6wdgdtL2kZbPqS4z1CclLqNgOUSk?=
 =?us-ascii?Q?dFuMOYtfU054vEEMQgmOQOjKxNGweRzMicvD6iSZayTGJwAujKFsy1rimbde?=
 =?us-ascii?Q?0O8QNOQMwAwRinKijT7GsOLTkdGAyK02WT5tBGyi1Rm+f5LHDuPxpeP0xwk/?=
 =?us-ascii?Q?jNik/zJzaQnjZ6Gx/F3U6wTEI2L3TOEoIpINGhb+j1sAJIJ1v/VC9xV5I3Ge?=
 =?us-ascii?Q?9eQenRGORX1RhH54JcReHDqR1GQhzKHNBIUMcWmdcDCX0hwWeR7pi3p1lMhy?=
 =?us-ascii?Q?qRgsIQT7pi7n64j4rUt+uzpLIhVyw6cP3t2HyVnw8rnpXvLvqVQfKBb71qRZ?=
 =?us-ascii?Q?SQTsIKpStFrsKkkmCjBBlr99SIWvI8L3kl93Q9HTm5gTZUUUn6SHPp1eKcUK?=
 =?us-ascii?Q?UOG/wlEKRlqLHx2wyCKstJ9r7HK4uPa+WtmDypb2LS+E5y6VESSkbe4UA6ZA?=
 =?us-ascii?Q?9KTjaQK9NRMIgHwGfS/Qq16yujMy6ncMEyLaakvelKFK4IVMF2dHCSkcFHWu?=
 =?us-ascii?Q?wUFTmL5AOYV0eCnNN8UmtceQd2xoba5NLe+IrtIo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b53550-bacc-4952-f7bd-08dc99ecf5f2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:43:39.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrz/GUEYX8Gu4gTe5n7v4jweNYzIhssw/6tVfRRvLYmY8PMuLSmz51qinCsfa2sOasNqGtjE5Fp86VQ3MVi/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Mon, Jul 01, 2024 at 06:35:05PM +0200, Borislav Petkov wrote:
> On Mon, Jul 01, 2024 at 11:23:36AM -0500, John Allen wrote:
> > This is the param buffer struct used for norm -> X tranlations. I can
> > shorten and clarify this along with the others you pointed out. Maybe
> > "param_buffer_norm" instead and a comment explaining the purpose?
> 
> What's wrong with
> 
> struct param_buffer
> 
> simply?
> 
> It is obvious from the code that it is used in the normalized -> physical
> address translation.

This is because the spec defines different param buffer structures for
different types of translation. We can call this just param_buffer for
now, but would need to be renamed if/when we add use cases for the other
translation handlers. My preference would be to sort of future-proof
the name now, but I don't have an issue calling it param_buffer now and
changing it later if that's what you'd prefer.

> Btw, pls do me a favor and trim your replies like I just did.

Sure, sorry about that.

Thanks,
John

