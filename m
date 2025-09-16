Return-Path: <linux-edac+bounces-4812-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB655B5990A
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 16:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC994161315
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5476A31DDBC;
	Tue, 16 Sep 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IRlkuAbC"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEA3191B2;
	Tue, 16 Sep 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031678; cv=fail; b=BgVkt4FaLrV7VpV0bPBsI34HC31KEsMmcMEpu1UT98vlFoewvE/ylthBVSQw4P/Bqtmwq4mEvHps4cihltzfOaEeszBMJ+0avSprvJpGdG0nGU7Vxx19LTdD+f8D8gb83L5ZTLhxZcLQNToMIMwSsAiqEPaFmmm2hmuciFIN5EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031678; c=relaxed/simple;
	bh=rLvUhcTDiW2IhjI/rswNtsOK04uPLj9u6OCe/YKPrA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hjeE7VRSQXqz2YnGypanL80PROLS4H8grbiDLaNxaGeKWjk+bJ8PciGX/C3amCudHCtloMZ9o02BfwhvpqZ/4sjQQCNoBBpCqsQnhcNvZ6fQR9TVOBUmcEeBjRTwa4xSnQdUMlSHyoFhWTz13bgJStRUI7Mma4+fAp9dtbO/Z9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IRlkuAbC; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGiBRlCoMyxnnh2jEfe1w3pK1hOYlfoIqbWIPciglxHftVUuL5dMHSqWRpeua6slnVU68qsY2azHCbr34mzzEVEyDVZP08bpKFfMyORRaJueQmOQm/SbUgPx+bPlKfIAQ43Ps8fKuSDGLvOJmYN5XtI48WSLQtjyFgUch5w9Dta77YaXz3QkehPlN6EoWiIz7l5yiYU1mG0QoWpnv/nF2i1qJka/RNhRnjyv7F5nCRUcuKl47VBAjPtvlU3KiEq+2KZLoCTWxM6bU3Zfd47NaKkpgPiTA+8y6iLf46QSv3rgXbW0xxgt2D32Xq1n9hAvjgEDazZ6tVd1iROrWI9Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ght4C5uvCDid4NaJz7t0nz4ROjr+N303RjY8PHhiiu8=;
 b=cIND435Wgr9zJQ0ACBpwNOlsgE4Kyw6ji2UFSxClGokMbvbC75IXJSQv6dhuZllmYz9JuCIW+2gGnzPuvVLke89UJte+ATh2hJuIWZwvLMmzzzzByQmkHEB9BX7VxW1EgdUwCfjmPh5T+4ycaIHcEjkOfTG77YL65FvfqaqqmACwjzyyPl0YKVCWqMyz4Y8PhhOd2epIJtx3wpUkxR/dHXXjcVQBOQxuFBJ3ty6KNtrLxRNxhEcdmF0rRY6xpJQmVClmg8Y2aBw60F+La+ZEZRp08bwi65S9NxqecwaW+NUqykgRVS87XQOa/YbPGhvzEjNFWSFtkcAZT1oZaYRx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ght4C5uvCDid4NaJz7t0nz4ROjr+N303RjY8PHhiiu8=;
 b=IRlkuAbCd0wP+Y7OO7ZlIzyr3R21Ffxow30S5KNipf/39IBAg5SwP88prtAvPG8Ze2bQppbXACUEchDx/Zx90JKpvlyGIIJYLxTzzwvyZZFiLxlddum4byxUfU+sLgJFqHkYYjCMfWgqyaWbi7W5+wBbWlfl7yO8XG8UVgcLkDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:07:53 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 14:07:53 +0000
Date: Tue, 16 Sep 2025 10:07:44 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, rafael@kernel.org, qiuxu.zhuo@intel.com,
	nik.borisov@suse.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250916140744.GA1054485@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
 <20250915175531.GB869676@yaz-khff2.amd.com>
 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
X-ClientProxiedBy: BN0PR04CA0137.namprd04.prod.outlook.com
 (2603:10b6:408:ed::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: d98a6d4d-ae78-410a-f1e7-08ddf52a6d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUFa+bfAcRc2yihS8EGp88lalwtLaES1G3FJTmOExcfpNBdIIotWtbES8ctN?=
 =?us-ascii?Q?jBsMGxWWotHID6hCacyGdziUbO0dq5rq7AK19DP42A7i48ZTecuvbOsDa8pT?=
 =?us-ascii?Q?+62MebsBnDUDcWCzZOVUBzJs5lNowP6h/FDyXZSfeIEpy4goSUuQJdymX/4f?=
 =?us-ascii?Q?NKqtse9oXxdQQNbRcCB7tBlY6//9Km5jVTgMjqVQaXKpR0jaXSPXA6HLwWub?=
 =?us-ascii?Q?AoPwnTZgq1YwBjJNG85+wkfKMkcmlw2DGiN06Bq/h/eD76sR7ebc4KdwgdIF?=
 =?us-ascii?Q?uwohnMJ6xgWTYw8+wxuPyByklt65nhER7H5s1sXrGC09VVw1xicaE3AGn6P0?=
 =?us-ascii?Q?JKvTEIQpGMUMlAt8WefHwC1WBDHIZ3svIxYiSqXIjj3X0TriIEm6+2/Jnz2Q?=
 =?us-ascii?Q?5ENuC/3fSOaSgvoKfKzAL1EOweeoWUDpZbZqGE/Sk6Wb2hXNiOMe7pTFLimG?=
 =?us-ascii?Q?Wl6+/4RpRbHqardvHRJo8oH+RGZ68EkiKzcHvZv5d4EKNgFABukzFndKFkam?=
 =?us-ascii?Q?Ezn0jDGMPhJjXPhHDOtmatd2S4RpQ8evFrAbMWZBPPvEZJHPt/pWE8FB3lYw?=
 =?us-ascii?Q?b+tqzqeJOckTTOW3n6yVelCE/koItTauDha6cSG5bjQppoeA8Vw3r2sAOXrk?=
 =?us-ascii?Q?j/S0gmyFpZZmMq6h9Ovppn/BGmFBvy1nRJLgba3yahF26TtOMXHhog3awqzQ?=
 =?us-ascii?Q?hM68gd+sYRAehYnr67pI4bfUQHcK4dYr1unZqFEimd8/yzZ74PnymRyKBPPT?=
 =?us-ascii?Q?szuJx8fBn1QJlo+jSJLTkzpOeGfcZHx/NkKGVeeLrFCz43Z+9zroQyRi83B4?=
 =?us-ascii?Q?Bz7Y3v5vc3PerQMaetNJPRb+Yp8Q52UvVROPEfPzmhgQ6JVfyhFPftZAo6pK?=
 =?us-ascii?Q?e20afB76nZxSLY+/euT+IGv/fHu4uKhy3iwyBK/wd0XdoqOdvNM5OMPYmIM8?=
 =?us-ascii?Q?70CRfbDiizkR0L0jMz0Q84rtqFdX3eF54s6EO4rmX0VZAFUOYUqpC97zi/tV?=
 =?us-ascii?Q?Wr8gqEdyzvVOKxHPyRVyjUFLI4kxuhmWq9syOWWOl2godZydqcQaShpwkigR?=
 =?us-ascii?Q?CiaMJGVxbkCqHwIFR+hf70U4npwoxDDC3bEbfpVVFY7wCNxIuLUXN4qO2OiY?=
 =?us-ascii?Q?/4mn2UfNO/yf/oCMni2SJhWs2hqeKcS0IVrhXHJtF/GMrz0gtUL5KKIW3+Py?=
 =?us-ascii?Q?JRhSKf7qC79ThOShyy9tIIafkCVcMp2Td1MMZqfwom15Pqw7aedqbiMcaWIZ?=
 =?us-ascii?Q?caO9pqybOJ+v1lvYfcLG8A0yfAsOjTfLAR+rnrXQIAScEJZV9XPscZFRANtQ?=
 =?us-ascii?Q?1AdRE+Cu/Dlp1bmJuDvf7dPw5kzCjxZxsESG7uojmVOLr28dOOQGuMNXZ5OH?=
 =?us-ascii?Q?8kKfMKfQkDHqgBH7xBP2Kh9/aEEzQNl+10jgEm62ysJU2dun1rk60Hn6CeyM?=
 =?us-ascii?Q?wqKD1qAp/oA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+aj16oQJ5TRGVngHoDU94w37XN0nrNEyWQRLqoR5E5Scll6gssjI7PVO3obA?=
 =?us-ascii?Q?gRlyxrBcLIQi0IZvHMt65xRAyt4kXpVgsD7027oTcZdi3EFIn9TbZonRhtrR?=
 =?us-ascii?Q?G948oLuqUrkF1dI4dMDMt+6rlm7E4b7ymMrTXaSQRVga4pXnkB9j8HfhbCFQ?=
 =?us-ascii?Q?C4obl+himYnYjhLonZ0uVhtcHORmgAJ5lqzkJClW0FdaGVGhzAuqEVzh3Pb+?=
 =?us-ascii?Q?yznZJyT7KhD38qWPcJPnenxrjFt9/JpVhhd7Yt8wCFaw0LJ2/Iwc+jJmSPHb?=
 =?us-ascii?Q?lnXO/x7/V/0cg4m29q41CiPn0y/NiHEa1HGBDVu4zcz+5lgT9J2U8DeR+IKN?=
 =?us-ascii?Q?yH9l38vOgC/PwGGXAppmu+MFLtCwFdMUJ3moZUpcRJV4gmkLae/Kqc3J+PJ+?=
 =?us-ascii?Q?kG3AoCTmSNca0Pzsz20Bx6tZvUP6l1sbWaPU4jlZCxO2p7Qhauvk8uLESPoV?=
 =?us-ascii?Q?tLRUtYdECOPv13dHOycWMYJrlrERCIJS49cqRPhCCIbk/HPXel9Bk9pwcAY/?=
 =?us-ascii?Q?a7OgfyDx+pg/TEPMuvpfmMBx8NPNt39F6iYpEJLhGfVmFwCdnueGAHBRWqOW?=
 =?us-ascii?Q?Lk9TrgbaeBCWzOnosEQeSYBfuOoiGJwzPooV/ULP7wpjJBn2jPgzAmvH+KHu?=
 =?us-ascii?Q?cd0CB6x9DHuUMJzUOffQFCArq3quNeU36CjJtVWcNanONmcNB39pKvJLD5CU?=
 =?us-ascii?Q?6L86YG7zsPlfI+Phv/wDvBGuo4Zu2Y31FH7KRljam0cHD3ArZiDp3OmRfaOc?=
 =?us-ascii?Q?/vaPESz45Rotypef4Oy4vLZ1DMl/HDz/VQmoxnl14d+BWUyB8b45ZvpUVPgP?=
 =?us-ascii?Q?zWu1npovd8F/5giwG+QXqaAnfyVgN55bd9U9iXMWr+zwSTGJLkWMJP2/J5FL?=
 =?us-ascii?Q?mEh828QmsuHLIf0l8qdpKLVCRoLiYzMo6JLl4amyQHMb/eXAP3UdEja8wArc?=
 =?us-ascii?Q?RgWHrp7IkMG25Tm0JkEJ9kSvejrn1yjic5wswMbosN3d4WQ0vHrZ78Vy9Set?=
 =?us-ascii?Q?91jIhSt96cCd4+NotuTmvfolXiANKDrp+yFuMqpd635QEGyzj27Es6P6jk3g?=
 =?us-ascii?Q?j6s+RdqMNA9HbuZMBcoU4+tyAIELu1WG//VW0gRhM4QF3XfjTMy3WqW6BkRf?=
 =?us-ascii?Q?DNzjuw25S2PruCOmo1w3Wa0n60f+mU4Kgm/Tp2bVu6W9Bqxb8Qkd7zJ75fwa?=
 =?us-ascii?Q?ilIU8yDRefbc8lo4SXZD4/JEyVEnDnaA0tW21rswHS1eKqimQLGwaILGLmGF?=
 =?us-ascii?Q?Q95X2rj9pD7FiaX62RXc/4JR+x4a5hjqsSSC/Qd9tcjqwBhPTUjxJA2NQDrI?=
 =?us-ascii?Q?9/MzlBg9Eyh7a6b97XZOjZp5AVYrpln9rAeJeo0YyGNaOKBadnGSV2F5Y88d?=
 =?us-ascii?Q?/tTeVgpvS/1zzzZmIca5STm2BNRW5xSa2E2y9uEPIiYcf5WKNIynn1EQxveW?=
 =?us-ascii?Q?M6SZu/Uj0tf4Kn2KshK+JZj2gdI9DrOR18Bv2eZE/FxMuLgKdhFPNUtUZNAA?=
 =?us-ascii?Q?rY52mLzNx4y3HiQ/B/tu8Dsk7PCFrbI2Ig29QyA3jMaHuzRsBFgo2fcVXn7a?=
 =?us-ascii?Q?uIZF+m4xICgF7BimyjL87b/NIf4TYNKCBbkr9mPL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98a6d4d-ae78-410a-f1e7-08ddf52a6d55
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:07:53.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvq+xeKooRj6DFYD3YVQoSLQfZ3I0/IAbWTQe+ipPJK5+tECQX/WHmfkyC+18iXqGbiy64V8ZXZPQ7M6UOxWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C

On Tue, Sep 16, 2025 at 11:10:55AM +0200, Borislav Petkov wrote:
> On Mon, Sep 15, 2025 at 11:43:26PM +0200, Bert Karwatzki wrote:
> > After re-cloning linux-next I tested next-20250911 and I get no mce error messages
> > even if I set the check_interval to 10.
> 
> Yazen, I've zapped everything from the handler unification onwards:
> 
> 28e82d6f03b0 x86/mce: Save and use APEI corrected threshold limit
> c8f4cea38959 x86/mce: Handle AMD threshold interrupt storms
> 5a92e88ffc49 x86/mce/amd: Define threshold restart function for banks
> 922300abd79d x86/mce/amd: Remove redundant reset_block()
> 9b92e18973ce x86/mce/amd: Support SMCA corrected error interrupt
> fe02d3d00b06 x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
> cf6f155e848b x86/mce: Unify AMD DFR handler with MCA Polling
> 53b3be0e79ef x86/mce: Unify AMD THR handler with MCA Polling
> 
> until this is properly sorted out, now this close to the merge window.
> 
> Thanks, Bert, for reporting!
> 

No problem, thanks Boris.

Bert, can you please try the following patch on next-20250912?

I expect that you will see the "debug" message, but the regular MCA
logging should be gone.

Also, we haven't been able to reproduce this issue yet. So thank you for
your help. It's much appreciated.

Thanks,
Yazen

From 6674a70f2369711aa28a20b88de7d89a9b6d03e0 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 16 Sep 2025 09:44:24 -0400
Subject: [PATCH] x86/mce: Debug spurious MCA errors

Suspect that unexpected error information is present in MCA_DESTAT
register.

Print some info for debug.

Check for the "Deferred" status bit to decide if the deferred error
registers should be logged. Only deferred errors should be logged in
these registers, so anything else should be ignored.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6e48290a3844..741473ef7fdc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -741,6 +741,11 @@ static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
 
+	pr_err("DEBUG: CPU%d Bank:%d Status:0x%016llx\n", m->extcpu, m->bank, m->status);
+
+	if (!(m->status & MCI_STATUS_DEFERRED))
+		return false;
+
 	m->kflags |= MCE_CHECK_DFR_REGS;
 	return true;
 }
-- 
2.51.0



