Return-Path: <linux-edac+bounces-3587-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D323A938B9
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9161920CAB
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954F1B4243;
	Fri, 18 Apr 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="asT7WIC3"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C41A7045;
	Fri, 18 Apr 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986677; cv=fail; b=aCuLOvBE3McImQQm1FeRKSFD4eW2UUKt7/fmd7+Hs/HFnrJsqas3Uw1h5VaxnzJKGqP0T8R1EuBEnGzWWoVLHmUkU4ubqqzTiKH/oEvAcMXZ8640sT7E5pGR7aCReHp+aduwYgB8POVzLmRMenXuW3wmP9E+KrXcBd19sRSvrFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986677; c=relaxed/simple;
	bh=hpNi6IAusLCuw7QSvzI5UUpOKNV0binGCRTmxL2Yn8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juh82VTGtL97GTCIHL0kzzI6BYdLiIBaQJo2L6TrahpBa2f/Q7TJJx6oJMDqtBpfn+K5efUnDgABf5OxwEAEuXHyeQctswITE8gjmXV2zOvxLRGB6rAZ0g4yaPkRg+kLRlgdLV6L1mNXWn7fbiczGx2tvFHQtRzrKu8yR4ACBcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=asT7WIC3; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkTFu8zN8xA7dDbLBQpOvh6IlYJKoDe7eblSM/EvsitsNtf9tDmiblQF/ynpgUxKspLiPvvrYUrQvCyfyFc58EqSNJhKIeLwcch6SswdMj767hbt5vJGu8WaTm53uI50M1j6w6zErKkcDdJfwoHsdpHtZoDrUJcvc44ZRbjOkJZ90q0diremzdlAO3uOv6cX5NCpp15v4zoejde8uO59QHfxztb9um9hheXJNCkb98v5rLfT0vUXVH+yMKIfyFwtbOk2N/mGPOaT9LLpI3T02iLsZJldhYG7zkz9zbbvQJLVMjdxN0VO3VaxJP4bEdHEM9aB+m8ALuHWRor4s9ACpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13l7FWwrwXiCf4K/P2oMalPKe72HNXJNB4jM5iUXLH4=;
 b=W+KKvzBjvmf5ln62HiQdj4U1gkVco/klt046tD+AlptCr5xZqmBMv1bUmUWW/FM4beEnUjWMriH7WZU9M+3mWUV/XU0Botx2x0Ul/M67kh1+g63wVe3PqCERcQSobhSZXGMDkGGrDZfHYxNTV1q7YnNr9ztIY2DJJQlhLxSPVqtJc2k+ggzCaljlczA2m1jWgSsXNzUC3QPXqwaRd9JVkltKEHEy0FUoJS5NObNDN+8x4849EGQqvkzyUxa4M/plAbNEpew/4wGldrH+Z4HMESWdBWy55AUuEpQTtuxvjRwHNWG/ImjNV++kxcS9Dk52r7e4QVBu0y9bXcpYahzM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13l7FWwrwXiCf4K/P2oMalPKe72HNXJNB4jM5iUXLH4=;
 b=asT7WIC3v4eh5uN6aVn3K8Nch1mnO8HneB3kcbP7bwZ1OAuvBmOXcbBj5IjYPZ55ONPc379HTkxpkxbpomDCN05rEk0qnHISggiGddqxQVxI4wUjMk67ddvCMhEQXT3MJa5xQlC7mkOCXoDe2M9crHWnYb0nabXNLLkobA0vV06l/sjbzn2RP0egNE11LeqbZ0bB/xf9xmrnic+m83uTZQ4+yfwe9BnMKO/+1uXQyq4gqvys/khazDsiUeIlP5mzay51EoxQ1NjI7NwuEq1onNFpcMbUxf7RkDE5Aihu5Q4k7F5usIJeMUM6+UBghll7hSyqKztmWNyXp0z4ErKe4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ0PR03MB6674.namprd03.prod.outlook.com (2603:10b6:a03:396::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 18 Apr
 2025 14:31:07 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 14:31:06 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 1/2] EDAC/altera: fix cut and paste error
Date: Fri, 18 Apr 2025 07:30:51 -0700
Message-Id: <20250418143052.38593-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250418143052.38593-1-matthew.gerlach@altera.com>
References: <20250418143052.38593-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ0PR03MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aca4868-4ee0-4b6f-2085-08dd7e85a6e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CkBRqjfQkGoF5nsojvrTaTsoKuPrmmyQ7lcd0Z5vEZcYIUQ0ROKM23uIuCO4?=
 =?us-ascii?Q?r2kTYrZ/9QHAyEmTkkvfjXqhT4DmBHmpxPwW1nMddEsdnqvrg9yYcfCl1Qso?=
 =?us-ascii?Q?eMQnjnwYN8ctcFQ3fs+2m8c4V7gv2fje3IM+21D4CY0iV6oAadyaJmZNkA9J?=
 =?us-ascii?Q?dd2cFXZ5fSz69toZl0tGV/5Mvqbaj+d+7KYNdak6Jwm/zEt32R4iPH9fGlZz?=
 =?us-ascii?Q?VruJVFAc5Fc+uUG2btWy2f80eLFP8xLcZfq9eG8mfIm+fQc2kjKqEyGmjls1?=
 =?us-ascii?Q?sEz6SNpDQ8jJt+bNNcDAdNkgzQhJqUm+oI8xbDpZpgqkieolOtewBf4hcrCy?=
 =?us-ascii?Q?K/nn0JCHPPtJYUqZuGWN4lJijCt09g5P+GjnnnIStcpMFYDhOaBMH6QALcDy?=
 =?us-ascii?Q?IkUnmluNzL2da6Pm/HMQuQPof4whLxhCN/7nBel7QVP1F8dhS1Z0ynK3l7BV?=
 =?us-ascii?Q?J6jWmNilmDL/ehVNIuUOgiZombdKGRM+bccwqMsMmM4HHiqlhFbYnzcsKpBI?=
 =?us-ascii?Q?qrMYYpgIMgwtUaKyMJi/ulUdVQ8Xr7OfgunzYiCRhKS+2i1HlhswgXRXLnxm?=
 =?us-ascii?Q?2nRZVPdIcPqUyG2cM7vzxb6VS4F4IM9e3jjWF/cJ0MaUu8PfSRvm4bHrx5LQ?=
 =?us-ascii?Q?lj7PfqilCD/iUTN77chw9U01jgoPDTpfO4cwRYQyteLTb6Cz3QQmZVw0/pn0?=
 =?us-ascii?Q?LPRRqcL5N/Dp2fhvjjbU+uthMmokl+s1jBZkkUNWdh89T109fPFlWcHAF1f2?=
 =?us-ascii?Q?gA2QOTbQHzGKtRPmHqBDebY8hXltOeEBQyzzsYuFZ/NN5RmSJUpcY74ISwnw?=
 =?us-ascii?Q?DnWtOwIDN7VGEMeI9qWxw8FQjxhSk5xVOKYldbWDcVVrxK+0/+//+mkaL5uQ?=
 =?us-ascii?Q?QQ5KXipwPpxFJOvwVipJeMPi6EOjTaIRY5rXNDCot00JWv7+i6+IexNeWQXL?=
 =?us-ascii?Q?gNiNS2DsqS1v3nWUn7/clufe0i3v5tMzobloBNvzEbL4ebT1MtnrykEdMGDM?=
 =?us-ascii?Q?U8HnftCIKwwElyVMgLGC9c6zFKPn7DlDQXpFafy02aPh5S7DxETB122+vp7w?=
 =?us-ascii?Q?LlIdIktjjc6fybTCJLJpdyO2s7c6KoycVerrcc/NGbWkM6vO5bFGfyffqjYU?=
 =?us-ascii?Q?PStGG2T+7GwZJ0cfH3/d6SipByWbn1WERDXaFC33IRZJEGDDju9zIIRNXQfO?=
 =?us-ascii?Q?nBz2y4X0rTpJhHxoSQwXr3wBIkzBT3M9ngp3cSUacoWob0aAF1n3fSSfRXmM?=
 =?us-ascii?Q?x4N5g4+ebiAHENGozmTecyZpvfpQVaU/9nghcmu796T9Eglnj2x6Pd4DFmau?=
 =?us-ascii?Q?HNhkH1/jWayW0r0dCzlmiKOOf+UyBFgpTRNDmahUM+pC982H6HCrX8mBlyfu?=
 =?us-ascii?Q?rOUzU/jo73qC/xJwlSuVoogS20qrjE7nHLNV4gCkWRiw/XRrbwp82CpLWL7q?=
 =?us-ascii?Q?xArMdxNYP1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RsqoDDtk6FhaM1SjTlpkHqkBTJYV603IYAp1QItcKh709qhluoPvVcskI0AR?=
 =?us-ascii?Q?oF1N81RhN0rxmETDeB0V48Dhsa8L0l8f2v7RAN7LKY3vBU1XSPwyx/JH9eJ1?=
 =?us-ascii?Q?gsP076PYBAShWPnLQNfcarFkfYnVttbikPSX4JkV8uEvjp7T5B5Ok3lL6cFm?=
 =?us-ascii?Q?xS+W7tygcpaC3T6MkD6/JCeb1B6Mjto0VEaqCBY5YVN1m/izU1NscHhO4JYc?=
 =?us-ascii?Q?hNd3gHtL2oSkJ3uZBX8LOpToVIbY2NJQUhQK4tccdiq038r2S+BViLh6zdBg?=
 =?us-ascii?Q?Mzk4yQGgZH3W26RvJ4Q695bbdJr4BorqHszVdeoWHyeI5Q7PSgSkrBTJm0+e?=
 =?us-ascii?Q?gALDfKZcpO1WAbjCLPSchOoUeVQFoeOH7rPjAveGfVTebC9+utGfnGIYR5it?=
 =?us-ascii?Q?7CB9opI4cGr7++6DeJBkf/2C9l+z7KCZjap37GOB9OUCk/KGR79RdrGPpMAO?=
 =?us-ascii?Q?VDJwhYfnarDJpDjCZZo/ffxtpt5U9+861h0zMS4bJf5KpsPr8oW8/IveKoGj?=
 =?us-ascii?Q?BiMuFyBUf1tEjjxrzrg1ZSZGJ0Jq+JZlCsCSjLHf5YAbzT+tYYd8yNg3sOYl?=
 =?us-ascii?Q?IzSgiZCDW1x8BUgibEUm803PzfRpT8xZFzWGqscImz3ijpAFsfrIy8Rnt+y8?=
 =?us-ascii?Q?eOhCy/G8tHClbbgimwB5FDOeAZxjVtRvYZ6Pah4Yw91rRcgik47uhwKaG/bS?=
 =?us-ascii?Q?r5QppX3nLxGMgZpQsuPlUYp6by+H/uS4MhqjDeGyrZ9ua92TVTVFeZAIibg3?=
 =?us-ascii?Q?JBe5PeV/sn4oLdTTaHEECjD9lXstC8MTs+qkj4hpwfxXWOJEyY6BfqRWjHdR?=
 =?us-ascii?Q?uKnliKKGgrzSaYOZv5vQtYfjnuSoCU69agtQ7K6R8NQcdpEzTVEh/iOvRKFl?=
 =?us-ascii?Q?iUcpaY66X15VB0T3rrFu6jmYxh71tGesD1ZPacfvioFf05aCNJ/5r8J+ncpI?=
 =?us-ascii?Q?OehF3DEZg7YSOOwwI/hEwtCujdNl3rpaYSydz2WWkYehJxpwEWJqF+SKTfUz?=
 =?us-ascii?Q?ahIMfO19kWWZMDLVYhBENvFIIz3v0Thbo5KS7eOkH/GGTzwoYycSnRomEkR0?=
 =?us-ascii?Q?kDOdlb0j2PphPeDYGEhCWdOaYPlHbNFtpzAbF6SK7hQjXkcc2n7oaEYuhhAD?=
 =?us-ascii?Q?QQUVHL/JKGocWCM4SsIDp4m8Ju8btYZNv2fw/fhchIlAv8QHxdEu9rOtasxN?=
 =?us-ascii?Q?M0elY0N9Cr099u4Fv0+IE7fHEZh0890hBu/vzmIty1yKnUfMY5KtnJg6Z8Nx?=
 =?us-ascii?Q?wway1il6KgnoKYqY9CSoE9GCEzPosDyPGwwNqTSeX5SDa2qvhpnksEUPUq9O?=
 =?us-ascii?Q?46G6oJ8faCSt3O4GVoC/1bDXz7VzFzevKhbL5yQbP4u8tcPqsBhfWC+20gNU?=
 =?us-ascii?Q?VK6QE4rfhWkZcoIkWMXambgIN6RCshchOAY/8iDrUKrAQqoXyU4epD2BZHVs?=
 =?us-ascii?Q?h0Byi/6tnRetipUEORkD81HPK0ackC0/Go737iYKAvNE7MC3ffz0sckABART?=
 =?us-ascii?Q?5oXGbJg0Qm3sdzFb1bTUSNtiYP/FF0u83AA98wNQjwhrpkLGVqTB9hV6XNJO?=
 =?us-ascii?Q?moXzoqdoSzHeRC3tN488ebZXCTfwN97QPXPhrBUEsF+OD40w2ua2iDKwJ8d0?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aca4868-4ee0-4b6f-2085-08dd7e85a6e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:31:05.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG+gxouUuEVYe6807DJazu/BBOMFgi+nycsSUrBmSKzeTj5YkIwFLY3Tt4vRxqG05WnhjjgEdL17SxHsWk7UxWcaFP6Tbp1eSrjfnufZ0Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6674

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

Fix bug testing the wrong structure member, ecc_uecnt_offset, before using
ecc_cecnt_offset.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f902363..88d9d2f458ee 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -99,7 +99,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
-- 
2.35.3


