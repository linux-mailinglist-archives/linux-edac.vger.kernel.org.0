Return-Path: <linux-edac+bounces-5277-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF0C2787F
	for <lists+linux-edac@lfdr.de>; Sat, 01 Nov 2025 06:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E191B22BE1
	for <lists+linux-edac@lfdr.de>; Sat,  1 Nov 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390D242D86;
	Sat,  1 Nov 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="CSjDy6Hp"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35A20CCCC;
	Sat,  1 Nov 2025 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761974389; cv=fail; b=O2oj7T0k3JNfMJ5bDzKPefDIB1MhOuTptVW+2jU+pFDxsLSGEMPHLTGqkyTideMvWZvOyEGeNJ6O/hWPRaZauKEhzxp6gU276qgU+ln5j1zVZKhucWZ5qX6R6IJ2EJYmyPUBCZQKjCghDWbpTEGi9GdNqHj8y3OfbK2yry8Oi80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761974389; c=relaxed/simple;
	bh=LhzQjKuHf3CnShvUO2COh0nS1i/ttzeVicTpIVx97D4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fq6TgAYhiFEp8D7YX29UW1il4TaNBBL4T++kKCL5hgaNdaRBrIVCpbSW9QRKNV7OIq5EuaDqZVi24DtTa2ITA0jLWrHYxvznCDew10KjAya3EL05jpDSwB7oTVUtgBzpjK37cGoECK4QeCA3xdOd3ldg33+y/I4j/shBjqgM9+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=CSjDy6Hp; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBZFLoKd4bFjjjmL8FCeNNaUySdzc3lPPCDpitGNRyKNi3atsR5UEV5miIhICIIpXbuB5EOo9sOOKibF4GNJddhI0kB27EfSpIcL+2P7e/JhPndSaMsbi8e7eSZCIVMefSi5EYUnuUcBV3Idu8agwNRTQfzA3tlBsd20kXcqFlsCzPcQiophglHXqmeU0ZZeJh9ziUZFS8ZP4Rt3WoUI5u2llIvAmfDespIj/17SUEE9ilOJSEN49I6uXIyf46RYgy94psUuHXqLte74tumU6CA9aBa2xda6U7QYmeMXz3COHrzN/wipuE+f56Goc/d6uBFb/8U+eHvQmQXXIUIAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8cIi5Jy9RdBza7V8b0mdYimUoYEF1lbqICJypBzank=;
 b=PPF+CxIasQ6u7O4f0fh+fog12fKQi4yS2+LuRJjQWxj9bDj86P86s0Ls9DxMSKuPcVpUhJCx4t1+4bWiBUoSUI2aRWWfmrsHun8LS53TsayJDluCPsw0vGY/bRiGL92mg+N2xsHy/qHfhaC8c5vgutKEM7ifhp5EksnTWaaWAEqn95ZyVFUNIl2nCD/UpoYXfD0TkeFnxHJ/TCclmNpKBm/xYkWk7xgPJkw6dD6Ax0hi/bXJ0nJaSlUHQZWfbe49XBkXq4hWzpVG1xPSWtAuUCzyz7c7OSOo2R2oAv9DdSHoGhB7FmY8Lh40AAKcgZMlXrfxHEttzZMUWrPQzz/wSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8cIi5Jy9RdBza7V8b0mdYimUoYEF1lbqICJypBzank=;
 b=CSjDy6HpbEiCEUISWNOVhXlqxEEKkmrmamBl/YozefS8VPR5wGuca2uBvOKDRb+laNQ1fxtkBwWR9hDeJB/Unxqk4mucu56F0W7L3LuDiLUiMgr7/LsdJMgHfdD+3nsHlv3a0bMyAcq2nE5/XD9YxEsupYbFtDF+ZcqOQoYfSpOzpTQWGhfylbnKSY3qWjJJpHxO5dxsW9/AlEYY6GMnrgwTrdeQOmFo7LlPYBaElZvufC+Y3i9LeclzGeeyUe+eaOVnxrpqMvUJyicodYU9OPsJVDcaqg2QUeKR52VEm9UJnTIWPThQUo2/JKy8A0fQZ8U83fv5YSnkfx4dFxDfPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by DM4PR03MB6157.namprd03.prod.outlook.com (2603:10b6:5:398::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 05:19:44 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Sat, 1 Nov 2025
 05:19:43 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: thor.thayer@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH] EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection
Date: Sat,  1 Nov 2025 13:17:23 +0800
Message-Id: <20251101051723.917688-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::11) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|DM4PR03MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 793fed89-ab31-4b48-2a35-08de190643d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AdBKnIOKMUMkCQNdLzQMgSHciIlaKcX9BHF1C/A5fnnjPwB9lh7fiBPiQx+?=
 =?us-ascii?Q?HokhWatbae5I/Cq8YX0d4uc/HyIfBPkKgIqyx/25RKxFOJfCITT2LIChBRrS?=
 =?us-ascii?Q?XqC153mffpmuk4OMyZxLWugdypjPgySJP+T91/ffhJqHwlRwB9OMgg/z0iOO?=
 =?us-ascii?Q?wDgLo5KtBACeI5VeIB+d+BknCCA1iPyPh/63Cgf6UwIwiI7TtwB2MigN0B9O?=
 =?us-ascii?Q?7Y0OnS0oqAWlDX/o9h798NwL0+EffLUiijXGsXw3YpMg3N2BcDDdABczn6g7?=
 =?us-ascii?Q?jQatUxR8NS4ziDBOZ6Nl1sHk21Ok5d7NnI1O3g3rrqNvOgXr2vOG5XcoojQu?=
 =?us-ascii?Q?rg1CJAc1aEv1WgM9ZrfMJM03l/NLyzMHIuIIogDZkTvMBPlNDojrSUI4piD4?=
 =?us-ascii?Q?UqBbiKMtgBtgwscOfYE7Gqd2zMbrPHyxJaMTBY5vxjKx+d+CXWg4C5yK7j7M?=
 =?us-ascii?Q?z33RTLUTYibJL/1P1yTG0IW8wA9uHha3tVd06/OnoqlfwzgWGLqOk6A+hwCQ?=
 =?us-ascii?Q?6Usg9JUFP8SORLd5EP1HJcxxk3RCuhAORtIhI/1hdcXDLhdX5Aae//j0No3j?=
 =?us-ascii?Q?u3fB8bLdnRUlqLZ4xb1e4jcl3rHG84/rAEcmf51JT8q3Shu73ZMcdStKz/pS?=
 =?us-ascii?Q?PW+LM/EeB32B9c6/azVJt1HCx7vH7q8VSv+k5SlduoUZR9yTXokMDmTFQYUi?=
 =?us-ascii?Q?JHJixRDSGKVFQhwtr3WWRMdvLwA9Jvc78ATf7AiEZPLXsDxZXvmRznCASwcU?=
 =?us-ascii?Q?vK3k4YnL6krVy9GSXDOXTENzeywVE9wMNYuubyjZQbYSKu1LjCt5ICSTYzM6?=
 =?us-ascii?Q?3wQktVY9TbZ3FvduB4kYCRlm24KuVx+8/NKI6jTA0s3kipzHK9p7iyYmYUrw?=
 =?us-ascii?Q?/QYyXxyDRsUvcIusV43EvE3aUizd+c99fVpBr/Wl8qpnGqaLa56ORBiFsTLP?=
 =?us-ascii?Q?CGLXpbtTOTWalIRn0B4n68dDUKHTpd09m6cXH9gGCPk2Fbcl8lL9mAibKpFk?=
 =?us-ascii?Q?8GYZUngP5OBuQHvelwJKPeRcRUbofcdXa2w/cQ2ifphokgO/s6aJFQ9iJRpO?=
 =?us-ascii?Q?Nrx8oLPcPkQBF2XAZ+W6ss4+Z9r8Z1ZA9xyi3TbH+bY13fAAiJnKlnkKFW4v?=
 =?us-ascii?Q?vpytqQJFh5fHaLi6YZoS7Gjrxd0Jwtu6obQfvhPfD8oFYZvHPjS/x5cmFQDC?=
 =?us-ascii?Q?TCUnR05UKILw2dk4k7LEsM8iSjacj687j/4jwKzl7WEAxcURZJHshs/1rRef?=
 =?us-ascii?Q?qfLWlULhcXDz41A/kWHPJKvlrYhFDs22LU08KBrblPAEAO91HB6rOemO25ig?=
 =?us-ascii?Q?x5Mwj/IzhFPd+/ugegs2qrbxRlylmg2yQlcEXcgi/LXEaVdw2D7idYThx++O?=
 =?us-ascii?Q?et+a2rhDlCBhdrH5y6BUw/seZnXKVtCDUi/ositrdpwMXCFjMP6KJ/daTBfl?=
 =?us-ascii?Q?lQdjXq56jJd6oFmmw85Xdkda4NLjFZkE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kznluJFKpngpHGkwWVeBH467mqPcXKtaXqlldUk+aJyuAGTc7EsIhu0VST9?=
 =?us-ascii?Q?AqUfvbMi40HBOt4985EmRWR8C+0oHHgiXWJeTRUPSfdAWFLth/xzUiXAx5jz?=
 =?us-ascii?Q?ICdJVIsC0OLpGmE+IlyGNke610aNhLEe4s+3B0LBHS9LVicuK+fX/CCXJny0?=
 =?us-ascii?Q?09cFDnAVyWA37JufxNWCQzHY2DLRGzUJ3cv8Sv2JD6jiWAEKwDtblUOvOzm5?=
 =?us-ascii?Q?OdOLzAwXb67oQwz5y+o4Upps1RbuU4Y1FOSJcth6Pkjo6YjASDYsFr/xiZLv?=
 =?us-ascii?Q?SotgEAFsjsexxyrRyuuxIKGpyVEkbQJTWWmbY7qbfMOv54+hsWy46+fBnlkT?=
 =?us-ascii?Q?cfDLlV+XNPNraYrpVbZ0D76l3gpNP+b5Pwdn68vnSPY5a/b23ow/0Z6v0mNU?=
 =?us-ascii?Q?Sc+vzXpSqS3UpaP0TlWUZCDW5rOdEkKHKcGrorRVGAU1Q7nsy1eJuqvz/A5O?=
 =?us-ascii?Q?xfw5wdyOf9hDY5/7oahkg/EGoYyccZQvkLOChJecXOareZfvQFQf9LsMfx2c?=
 =?us-ascii?Q?Y+O0NSkjp0UjmqkpSEpgU2rZGQKAsYHJ1Z/dcGkNj77cHVBJFXYHAoxxAGKQ?=
 =?us-ascii?Q?VyMOUkpeiQbzLyBS66+sLUZTjaSYbrCdCibDG95G9sf7Hjp/nRw3m48LZlZ4?=
 =?us-ascii?Q?r82uwZC7+LcHnVFKJG/6iC+ztrDuNYHalrdVE6q8aAqA7uiHFXzgKsw50lBH?=
 =?us-ascii?Q?Ox+BcSKk7t9iSJ+QtdmxYRDiXxxZbjR6oKHF2wByHXEot1acEgY2ugmFGm4I?=
 =?us-ascii?Q?a3zEECMICPhTXly5XwE2UWjcRpfQCQVNJwEiI7f3im7a+Z3ZNnxyDE7N25sI?=
 =?us-ascii?Q?6sZ5LxC5m082P3f6DQ16ofhSHHG5HipFXNNFKtTGe+HclcfS7gpxC/5UUWiQ?=
 =?us-ascii?Q?5D+18DBLQ+Z7NhYQrc3iLtehByHiJXVAog0kiNyNPcOADV/xFidb/nexhENE?=
 =?us-ascii?Q?gxxCb+MQVJP3vLFtdfGlmoKLg853NXyjKtVyRzEALbU955r+181zbfxdu1wd?=
 =?us-ascii?Q?g+XSHWbF5VdGxW8kcqTvcME5iI9vcQkXpqhDFoY8yFG6zUpBY2wTO5mkYi1P?=
 =?us-ascii?Q?UDWE26963YW9Iwuuhb96mAJ7dybVJaBuA79DsJkvuYNv6+3iLg4YshGrVura?=
 =?us-ascii?Q?J5Ioo2wWlMzk/sgF+w8EOxI8GoDmAu2zhP0wiTofqm2yz2h3BjgA9cYAr6vT?=
 =?us-ascii?Q?MhgaYMnmRYTtWQsUjyPocpWAcqaZPYuOX4tCjUQ1kxaqYc3Fd4AlsI03Vm0O?=
 =?us-ascii?Q?8BSFuZOPUmmwrCfS86PHVBsLoqtiLens+T3b6M8czPp4uHpMOySxkbhYy+6o?=
 =?us-ascii?Q?3h9lllfnYoyQm4bWHDIrS09bGUZCd6jQXDNtTGdHwOKnLs6nj4Go2yYrWLXD?=
 =?us-ascii?Q?qafQIT7Dx/aNiZTl7pqubnFurSqvDpQ0nXc2GA5IjkoCrVgvFbc3K8q7leGD?=
 =?us-ascii?Q?Qpa4rMYxtmM435arN1P7OdXMCZsaYZY0fakm6f/xZdDCPRO0GKtjwd5zxInN?=
 =?us-ascii?Q?m8K0rxkX5hkjhTS2TiZwkZtFI88cbEpRvtZeFSDrkWrp7AetN/isEpF5LQyg?=
 =?us-ascii?Q?ru64wO5Mts1WLTQvdf8t7Sa46fuwBB+y4AR0lgLxbLT30jsocjccDvPLjJnq?=
 =?us-ascii?Q?Q4tsBz3WoqD30PGOVp+R6hI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793fed89-ab31-4b48-2a35-08de190643d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 05:19:43.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMQiixXYUcyra0UZOokzFbypI/dRFTKkMvjD/d9la19x2Lsev/YZPi+4pQXEgHD1Zl/FbmsRtOE/CB3taIz9e6v3vw1s3FMHXk/sDXJd5elf1j1C468T9tIy5YPwZTJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6157

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The current single-bit error injection mechanism flips bits directly in
ECC RAM by performing write and read operations. When the ECC RAM is
actively used by the Ethernet or USB controller, this approach sometimes
trigger a false double-bit error.

Switch both Ethernet and USB EDAC devices to use the INTTEST register
(altr_edac_a10_device_inject_fops) for single-bit error injection,
similar to the existing double-bit error injection method.

Fixes: 064acbd4f4ab ("EDAC, altera: Add Stratix10 peripheral support")
Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 103b2c2eba2a..5c5d4585d8ae 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1357,7 +1357,7 @@ static const struct edac_device_prv_data a10_enetecc_data = {
 	.ue_set_mask = ALTR_A10_ECC_TDERRA,
 	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
 	.ecc_irq_handler = altr_edac_a10_ecc_irq,
-	.inject_fops = &altr_edac_a10_device_inject2_fops,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_ETHERNET */
@@ -1447,7 +1447,7 @@ static const struct edac_device_prv_data a10_usbecc_data = {
 	.ue_set_mask = ALTR_A10_ECC_TDERRA,
 	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
 	.ecc_irq_handler = altr_edac_a10_ecc_irq,
-	.inject_fops = &altr_edac_a10_device_inject2_fops,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_USB */
-- 
2.25.1


