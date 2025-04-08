Return-Path: <linux-edac+bounces-3491-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF14A810D5
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A31881E66
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154122A7F6;
	Tue,  8 Apr 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pegJrbeM"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592E288CC;
	Tue,  8 Apr 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127570; cv=fail; b=J4rZfOvFXrsWKpmhFMEQWeAAyCrIGii5oU/1v9dVwJ9PLJYn2R74yrtjp7LEQVm8bJUW6PYq3RgbIQBynqkyut2EEBPGe8lGezhWkzJPJL8kXe20xE8bvodq22NK00PEsniEp+DhoUEnGCoqN2mVgf9pyv6bUgQThPm0yIifDao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127570; c=relaxed/simple;
	bh=JTNLRg6Af6el454N3gSPjhAPVFoavrkJi70kO6ZVgK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tGElufqwpdnzkXNTf18B7raq7ZtUSZ0h32b2NR8Spkv74x64YuZZ1tOFRBMzwwJxMFqaUdLrqwYe7ovzBwFQLj29SQJbELNOGUGovcp8KrAHIyKGHh9uVh9bfn8PmoojuzAvXfUsqBJ0et496RMeeSw1wg314Sb0Y3Jpm4KSzTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pegJrbeM; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZiQnA+xaaAR0sGq6LgCClKnxp6fcxoKew7HfVP6huAKEj1P7mgjmLubx8GpeDb0p8TqHE3wAbRV/Gd5abKajObyQwpKl1tdGzyi+QPAUTOgGGrwt4G2L2khw3/ycgoPD7TSykf7Je+qFG7tUVdeXHG8hNohuHVgbEZrJ1ByL1jhuyBL1iyfNreea97PhRTLL6dBRTt00RLn1zddvsOhKhIxo74yIE5NNR09wo9oTc9IZrbst1XIy9RKy7TnukfRnYlGmDXsmFghR8xYX0nnxzz2wG882j5d9osur5q/u8m7Y6fTJ9Q8hk0FPWkZjFp0uiaBPRDD9FjerWexfcATow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA7YLzPqDkZy75lX6nnCjeRKd9p5HnQoaNVEXKLrNOI=;
 b=lugBE19JK7TYbzkOgwH9/gKPVwV7AfIIhSuA+JcHzU7IC0UQzPv2wc/dc4C26qwN+h1zxlMB61b+nmwsAQzY8mgoFObj2LhiOqo5ttxzKAmkLmP+vydyh7GxDME7EK2hCgOUvIg8GrCxVzLgRjBJ9TESiQj6IUeAmdLVxAMcOc8Mw+JHolsXrYxMxkRksrqJBGAn+Z88pof3Jpo4W7AoXVqexebPdQZvrVRlIL0m/gexbhYgHhQ19Y568Qy3ZeiwkG4NBO+tJ+S5vC0Ex5tSNsgQXR788yXbsbIBcYtyk1wLH5hllMxUi+b5P2sx2V7UW0X7GROLWjvveK4rQmjQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA7YLzPqDkZy75lX6nnCjeRKd9p5HnQoaNVEXKLrNOI=;
 b=pegJrbeMaRrezXDzmmI75YGFIaqp8yK1dd2rb0DGbjFYZ1Pf+oNdZ2dRmLlWy+f1rZoMZ6T++jM+TEuD4vHUkwCE1ErRHZHOaXeqOFNUqvmk5JX6qacoTCAfT4BGUj3qG5RRJxko1rMCDyyt1qmRo49c8QDkCDhSHP2ia3Zxieg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Tue, 8 Apr 2025 15:52:46 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8583.043; Tue, 8 Apr 2025
 15:52:46 +0000
Date: Tue, 8 Apr 2025 11:52:42 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Message-ID: <20250408155242.GA2523543@yaz-khff2.amd.com>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
 <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
 <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
 <20250407151657.GA1948540@yaz-khff2.amd.com>
 <20250408101415.GEZ_T29wiuh-_sExlk@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408101415.GEZ_T29wiuh-_sExlk@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cde5e19-47d4-4bba-720c-08dd76b56817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y3X2szh7Y3bm1FnSi1xVDQ47XVuGfpXJ5eAM8Pl/p77CD30B+vKA3muyBhQP?=
 =?us-ascii?Q?l0eLUVTVmmHRCYsViohM5zkE0LdRMija0sHZIf3VhRD3L2l4C32a6OW/eBpp?=
 =?us-ascii?Q?80tZl34M7glJ1I6w7R9iFgAgNql8yHtLqPsJUwv/6jKlyObb8WqzAStoLPib?=
 =?us-ascii?Q?F/BghVZ4sZzeIEpdPhWqnVcUVS+1n4XiAByvlEZJQuJz6HcbdgTrkTCn8t37?=
 =?us-ascii?Q?DF823Cxtps2Q1V1V1wfag6E2wGBpy/il+RtWJQCO5MiBJqdLjGTiBo318r89?=
 =?us-ascii?Q?OaKlxhrHwGUyk0fYHgsGUEZ8/Fmqqu8ZxS1kvtm7LIv3fs032ARBb7RyutHl?=
 =?us-ascii?Q?vktBf05RFpQg6U0UUrxhI1KM9MuHzoDLusc90th/QtcGrOwbu9aIM7wpZtW5?=
 =?us-ascii?Q?iud6oFSg1JazrjcJWXaNbwN2YY91cO8cNUD89z34ANBpApA8KC0WuZqCzvAA?=
 =?us-ascii?Q?syH7f427XfJ8fPBm2eWoBcjXCziZZHiYF0PnlPwW+ndVicZgwYtpmyuZFIXq?=
 =?us-ascii?Q?BOwiZMrQRJ5KXwlAG3WAPDxd6EcfL5U/4lWTIIQuMI16jV4CXRYTNDpQBng7?=
 =?us-ascii?Q?2sEw+cyDrg881H5LTMZfRX/fAIMW+AFIjsRioLDbclGMNkF9Bwj2FwSQu7ER?=
 =?us-ascii?Q?WmnlbK/hy8DU2Yj6GZhdDXRoQhmivNwUXBruKPwCbP/2V9xq8m6Os33CFj9j?=
 =?us-ascii?Q?lGNjhbBG8IYEFOp+XvDWDTD2jJJuVunHXStzuGWgRJ0QJzIM/DIJjiG7VzL/?=
 =?us-ascii?Q?U8S7qxv+WjW9Vp5vK0an5uWyGVbNmrku/0r4p3iKwRRaPsnl3n8DKx94fPGi?=
 =?us-ascii?Q?YbiDsG38bx55GGRn0ensUTvuuraqhFPx1o87vLykHr3MQ9yesr62xbv7CuSj?=
 =?us-ascii?Q?jH2X9HqRsvNv8HaMvk+e3XnxiGTannGFx+xYFg5RHOV8zvpW+Ws7/g3tZceb?=
 =?us-ascii?Q?VB2GmnZEJ5kh4sMpM04/ivIb+O8hh+L8/QwpWeu5MZpOROpwKzTE1zVB6can?=
 =?us-ascii?Q?jFlhjEgE87Y0tVywaWZBS0y0fzMvsM2oe70SsfzN65Scb+HJil9SoGZkfEHq?=
 =?us-ascii?Q?RCW+4BLtVqMGkhlk+0/vMfNmtFB/yBwLDyVTK79w/mocW6FTHLZBcxJgzjwC?=
 =?us-ascii?Q?Ntrr1wPnAJiPYT7sqYAR5PVKHu74ETmwY+ABZfTQpQGGxFD3ufyG9KxcxTH1?=
 =?us-ascii?Q?adJmFUFRP7VZyTCtgcy2rWHxjAM0iai/CI3evdtQm/xKvD74c8q+928zCMfJ?=
 =?us-ascii?Q?T9qoX4TWytQNODY3J1s8WW39EvqzIJpGzVG0h8XnUYCyp0iU4T7/EaIrD1/K?=
 =?us-ascii?Q?ypRPw4rgB3rbQVDwl5ejC1UcyqMLIy3iZLxCyUqA++wW7aWkNWOvcyet+sVP?=
 =?us-ascii?Q?EoFEaqeQTYv/jh/xOAdT8RLYU0VS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0YYY3q0ccQtrIz+r0I/vYhOfnQ59vtQG80if6zo4qyXO3UpXj/pD/UUpVgrE?=
 =?us-ascii?Q?gE8YxHJH42JEj9Q9svfR5sP+3u/xWy9v9gJ2JkRFhVT6Jwm/gU+/C/HI2t1d?=
 =?us-ascii?Q?JQEtvU/DCLQ9YEyvrBtH0IEXKOhkpenDpBp8ijvFolntqEw1+DJ0oJKQRvGf?=
 =?us-ascii?Q?/rfdeL4pimhQrbVx2dDNFZBSssCCi5nFmTpg1sQ8E3LTHrZU6NBhuHHui83S?=
 =?us-ascii?Q?Ie3k+/f/vbKeZR9oAk5IHR1bWQX2iBLeE/JT+++UOjz8Woht+BYrrGJ/5Kxc?=
 =?us-ascii?Q?xSYUdVUHeTaS5Z8xOySrOWaCvic+7oic7zz93838Zqh0EVw5Q5LKZKUxcIYx?=
 =?us-ascii?Q?x7U69iDYRP97EWZ2s72kjIs4lxyyKnULoNK8OE0AJVI65zpHz3Dw/whPImG9?=
 =?us-ascii?Q?Fw3ALZrevAs8fuxNIKow5C0gEqSjmnt4T53zKLxyI+Qo/WeL0MB5/LvdEou8?=
 =?us-ascii?Q?dW8JFvUlIz/y9K+N45WROMUV3vvB6U5CD7XkWpiEDYvP6aMSvcfmimka2y7m?=
 =?us-ascii?Q?irdOvrS3LciSRjTLRE3BocuBI+ECtaSYqfH7U7d/S4VkDuykroyRc4BTSZDg?=
 =?us-ascii?Q?LG28K/Ggh6JDvPNfFeeJEHHPH2o3gltQW+39Mumf6SuvfBuNH/gR5pu06JAZ?=
 =?us-ascii?Q?0Nur8w4pWCxohpl/g4G8dR/N0oZ4P2FXp3vBqH59ODOFhos6govTXvtjhrFI?=
 =?us-ascii?Q?sQ6ADmCdHfe/9/UkZ8toRJwJyw2hiWDpV8GdyrM0HEA0j+vPMRlCsLjhyI+s?=
 =?us-ascii?Q?jEomye4fPhBdtlde6R9KBIvaYxw5UKScnaoCNBWELVSzgIIuRtnG1MOGjznK?=
 =?us-ascii?Q?I5/cNJatAjPY/xbhZ+eOzseEAL5czlEVCCb2kBH5uSFp5R+myIrfxucx0nAW?=
 =?us-ascii?Q?8ZjEPay6LqIF1l8WZIc9RyUQQJyFb0nrHIS3kWvrs159DLXA7fBGpnQJsN9v?=
 =?us-ascii?Q?oLjD+8Z3/vtyJuRMtWaykioVu8yBf+Od7lAz+UqtpoII4giuiERoJRTI8Kl6?=
 =?us-ascii?Q?LktO4dK2TusN58Rc3QD/oagxsKSfV5m2p4VamsJAcBV12IW18W1aNzMCJvW1?=
 =?us-ascii?Q?kPwiNdc8XuECEMLm9Olje49OluOKKJR+ktR+At01fESQtgDFWl4e0VijXRlm?=
 =?us-ascii?Q?iBRREYLiB5h/D4lkGDojP2H/sc+kUlXdo4Y52TxiXeZxakBQXbZfxaZfp1bB?=
 =?us-ascii?Q?poUkQ0ctFM7Ld54IflIZk1x1RDEGiYZbQEJe2RGD/raocCx9Kkrhu+JCs3sa?=
 =?us-ascii?Q?reDQqNa7155Xww2W9OudfeXaUhtTQKODvW5PORdnxOtdgqT1gmRYU10rQwvy?=
 =?us-ascii?Q?1ZM2jlzybHSrXhBufWpGVC74tScdwf8Se9J5EC9/sIiQNDd0tVNib8lmRwN3?=
 =?us-ascii?Q?AreI+CGaPsRHhGH7rfEBa0vXYV4cJdI7H9gptoD7yzBuT/HGjKDxXc7Lv8gO?=
 =?us-ascii?Q?HoLJbEOWq8cvP/vP7sLpkB+Qxc3ldn6rEM7OUuRHVmYtmsCwszliiBgdJyNg?=
 =?us-ascii?Q?uacQCBZseSNQve1ze/Z5lw0kS2Z25mtW8pkODJ7e7IVjwa6jnxpMDSknhM7I?=
 =?us-ascii?Q?MDwKlJr/m2tTP6di19i96GI2BHb3HCFGZpEeGsqm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde5e19-47d4-4bba-720c-08dd76b56817
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:52:46.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gh8PRW3Ru8uBBVR6bESZP5dv2rGkWqiPJmcgQWY46CcOLFSlGZlZCJih3p0L5WkzsjY6N4HAMJcmrC5J4O7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

On Tue, Apr 08, 2025 at 12:14:15PM +0200, Borislav Petkov wrote:
> On Mon, Apr 07, 2025 at 11:16:57AM -0400, Yazen Ghannam wrote:
> > Okay, will do.
> 
> Yah, except that df_cfg crap needs an export now:
> 
> ERROR: modpost: "df_cfg" [drivers/ras/amd/fmpm.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1956: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 

*sigh*, sorry for the noise. I did a 'make -f' build rather than a full
build.

> Looking at the call chain how we land in that fpds_equal() in fmpm, can we
> read out from the error records themselves that those are from MI300 and not
> need df_cfg at all?
> 
> There's a struct mce here:
> 
> static void update_fru_record(struct fru_rec *rec, struct mce *m)
> 
> which has CPUID for example.
> 
> Otherwise we'll have to go back to your original thing if we're going to have
> to export *something*...
> 

At the moment, FMPM only loads on MI300A. We can just have a local
function to mask the addresses. I was thinking we can have function
pointers to make things generic. But maybe we keep it simple until
really necessary by just using the MI300 version by default.

Please see patch below.

Thanks,
Yazen

----------------

From 7f6e2196cb54bb2134e5c1854e5a54530eec77a1 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 27 Feb 2025 19:31:32 +0000
Subject: [PATCH] RAS/AMD/FMPM: Get masked address

Some operations require checking, or ignoring, specific bits in an
address value. For example, this can be comparing address values to
identify unique structures.

Currently, the full address value is compared when filtering for
duplicates. This results in over counting and creation of extra records.
This gives the impression that more unique events occurred than did in
reality.

Introduce a helper to return a masked address. Start with the case for
physical rows on MI300.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/ras/amd/atl/internal.h |  3 +++
 drivers/ras/amd/atl/umc.c      |  2 --
 drivers/ras/amd/fmpm.c         | 14 +++++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index f9be26d25348..d096b58cd0ae 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -362,4 +362,7 @@ static inline void atl_debug_on_bad_intlv_mode(struct addr_ctx *ctx)
 	atl_debug(ctx, "Unrecognized interleave mode: %u", ctx->map.intlv_mode);
 }
 
+#define MI300_UMC_MCA_COL	GENMASK(5, 1)
+#define MI300_UMC_MCA_ROW13	BIT(23)
+
 #endif /* __AMD_ATL_INTERNAL_H__ */
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index cb8ace3d4e42..6e072b7667e9 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -229,7 +229,6 @@ int get_umc_info_mi300(void)
  * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
  * reconstructing the normalized address.
  */
-#define MI300_UMC_MCA_COL	GENMASK(5, 1)
 #define MI300_UMC_MCA_BANK	GENMASK(9, 6)
 #define MI300_UMC_MCA_ROW	GENMASK(24, 10)
 #define MI300_UMC_MCA_PC	BIT(25)
@@ -360,7 +359,6 @@ static void _retire_row_mi300(struct atl_err *a_err)
  *
  * See MI300_UMC_MCA_ROW for the row bits in MCA_ADDR_UMC value.
  */
-#define MI300_UMC_MCA_ROW13	BIT(23)
 static void retire_row_mi300(struct atl_err *a_err)
 {
 	_retire_row_mi300(a_err);
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..6119bd0d6ae1 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -167,6 +167,18 @@ static unsigned int spa_nr_entries;
  */
 static DEFINE_MUTEX(fmpm_update_mutex);
 
+/*
+ * Row retirement is done on MI300 systems, and some bits are 'don't care'
+ * for comparing addresses with unique physical rows.
+ * This includes all column bits and the row[13] bit.
+ */
+static u64 mi300_mask_address(u64 addr)
+{
+	return addr & ~(MI300_UMC_MCA_ROW13 | MI300_UMC_MCA_COL);
+}
+
+static u64 (*fmpm_mask_address)(u64 addr) = mi300_mask_address;
+
 #define for_each_fru(i, rec) \
 	for (i = 0; rec = fru_records[i], i < max_nr_fru; i++)
 
@@ -258,7 +270,7 @@ static bool fpds_equal(struct cper_fru_poison_desc *old, struct cper_fru_poison_
 	 *
 	 * Also, order the checks from most->least likely to fail to shortcut the code.
 	 */
-	if (old->addr != new->addr)
+	if (fmpm_mask_address(old->addr) != fmpm_mask_address(new->addr))
 		return false;
 
 	if (old->hw_id != new->hw_id)
-- 
2.49.0


