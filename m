Return-Path: <linux-edac+bounces-1728-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C283D95CBF0
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 14:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797A0284A7D
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091D183CDC;
	Fri, 23 Aug 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j5TANNwW"
X-Original-To: linux-edac@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E6469D;
	Fri, 23 Aug 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414523; cv=fail; b=EMQVCMG/ZVLtxs7ShtZfO5V6HrO26nziSIzG7hYu0EzmgtyJPyOiL3r1vWzkyn/AmN3hfo7roaj7JD5OWqzlHGNmoSVQNUtuzDhcttPZL6AHHTnquRw4MFX3l3JF7fxjErJl3+Zl//29zHFD0FBZuaVco6RfJiQUEzJhRRAsN1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414523; c=relaxed/simple;
	bh=5GfVw9RdQ1FhGYE3XajiGxokYnBzWmpwLki09GwR/HY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O32M/rBii2HkryPUMIGFRa8DdAEbG2iqLA079JIXzeU1z4LdOrPWjIfO1lC/T+g7QXgvCiW/UuizNEJefXSJegXMBeRXT8HgfhzsD/B8dbf1gkr9Mv1s99JFQ9cDWEo8hNSfRVLmRrXxkLfRPmsGDcFJyDhxD/EaEwbL3c8iriA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j5TANNwW; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjO1Wkuc560JjK76kAjX2H+MimjNBXYWZ6dKcgG4iz3kX53n5qR7XlcGlaMiDoD42JLJuVf1lw6Ro1z8KnGQP2FH8skn8nfw6hGu25M9tpgJXlO0d5T4XgvrELH0FA6plif8ZYGKx0x/EcM7Kt3G464Gdflq0sXZPJq1ybHlLdSh/TNLofHW5cFoaLjzQQXU23UAifmgELUI8Ktj8Ca3EYoLV/vd8NTwubSMFwZCZPR05tFF3l8GTeNBBImn623FYL2iscI4eUhJBiBzGW2ngVc2Cq9Cr/crq+AbpZRAcaxOL1JT+gFHuYSKHtUIoK0VdJbrO9SbqVz9G+aCXLz7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coWrnAQ+ytaG4q6MTf311gfh617L5/rAx0Cryhk1vuY=;
 b=ioQn6bFxrFTaqgQEDZ06LhcFbZvahzcRgciZwagu1d5u0dttE47bXtcf1h071aCnnTs4ZgIrs4xnxFz6aydZSEoVeypu24t8KG3GNTHydRR8PFCgRhf6HbTMBPlMcZnBMVyexR0TzdhKevNXf66RbMZUcaJxiFXW/xL40VkgRn0+al7QzE43YXwCARgNKIQdPkIH9JR5uFkCzgxR/vvrBpT1ceuqv7aRpW643JG2uA5x+0bjlZ3uq0CGKLe1cHDk+oUnGdDn1xkBh25LCVJWmb2pxnjHPXNPQNYk2ZY6PSUEa+Uqt0hsPjqLK4A0VNcxrSwV5xN/gqm0h+o5Hjwt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coWrnAQ+ytaG4q6MTf311gfh617L5/rAx0Cryhk1vuY=;
 b=j5TANNwWkEd6ATI0tnBOzjzXoeebCNcL82TxVJSUN2TUFnFSTqQLUhdf3J4EQPQLqTFY4gXczKVH74DYBee1HYXHa0NbmNmL33tZzIh+u5zYy+AdScux7rlmjNf+lYAq11mKBB3EsrIQcvnk3SIc14PVgpans8cDfVeth8OhNVZiKDQCSJ2SEWTXgdpJ+e5uGJKORgzmxnDX/jU6R7BMVsuzw/2Yr7u8dQMI8PUFUkzwdtZJ4/nV3UnPE68UnOisx/QxTnRYWfDQvS+DUal8XgY9WnkGz+j1r/PLyTSe90JZnrMIYGyFC5xZNohmHyL680p0BrjdT45gi0csIuay9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by KL1PR06MB6760.apcprd06.prod.outlook.com (2603:1096:820:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 12:01:56 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 12:01:56 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v3] drivers:ras:Use IS_ERR() to check debugfs_create_dir() return value
Date: Fri, 23 Aug 2024 20:01:47 +0800
Message-Id: <20240823120147.3950878-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|KL1PR06MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0c70ea-0657-44f3-c6b1-08dcc36b6289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hL45gaUbB4SicxlhJc9s0fKqGdhnvPDM6qMAj0rmJZr/1vB7HqBRSC2lUQ2H?=
 =?us-ascii?Q?l0wSkgxAHhmR5zzgKWChX87/veKkXylJ498bKH9l8TUI3zTknPDS5So9kaF8?=
 =?us-ascii?Q?Mxkf9cROHthHup+PrPOhyOQpVrcrjc7FmvPl5urcEO8EWKxWPaKbQtl0RIsQ?=
 =?us-ascii?Q?zw4g1WnPpvH8GcbQnq8dcVLCarm2mNV+Zjk1XPBhzNdCdfLujyLB+MmEcK4U?=
 =?us-ascii?Q?rMqxf1oiT5qDAB4RuQ+UqWiSZUyqbU1DqSnuqSP691NtJVvBS09DSYVQVJ9Y?=
 =?us-ascii?Q?GzpAVkAtqRwfevHBFQJsoyhLMXQrJJrpG35EDS9Ep+phWqSvRPO69uwelmwO?=
 =?us-ascii?Q?xQ2mVFqFchjF7vcol31ehlhcgYFHOjwBK/u3ndYKWacbXpsLGS+uVW8GHmAQ?=
 =?us-ascii?Q?s+in/t8+SQPXocxbyXoWyMkLPQyoIgegKH6OfkGKoJbPtUvy3umqXzfOLYqy?=
 =?us-ascii?Q?JoaaqRZgcY+gr6wYId86as5ikhhCJgFMxyeG3i1vE9Wg59phGnHuqyPYX0EU?=
 =?us-ascii?Q?kd8tiy7gD8reel2Ts2pczvGFEKHDrT7aoOpjN6YWACJA7MW077tG++kmtFFO?=
 =?us-ascii?Q?kzUAWatBKvt/VVDSa9eqsaV5HIci2BbvClS/dqUh0bcbLWifECKcquPLTTSu?=
 =?us-ascii?Q?6BZIhjYbW2FyKeBxcQTKCFOKTpx6yZ7Ts+uZ2o+fv5jyzJs3cqDYuOBM9xiy?=
 =?us-ascii?Q?zHlkg5EQ4xrEskx2ZZIPCJmy5P48hio+z1+ECK/DWI2Hz9mQMoRl9yJjMb8c?=
 =?us-ascii?Q?XLK0698X4QI5yo13dPjrROL4hC7ME+bzJewxfhVHpGyNjC4CCpU8Z4SFqppe?=
 =?us-ascii?Q?Z0QKiywHU7RiuYm4uxv0w0Zk7w2ZgodI8U4ZsHvwyvdkhSLgWTh1kXqdrXH0?=
 =?us-ascii?Q?Cyj90ckdwydD4qy7GW5RRgZ+/i56/86UBwqVpXFlumqlzB/zU8nzegEvSBfZ?=
 =?us-ascii?Q?RL9DxHtHynMfaVa9c4ty0bddjqNU1BYvf0Vj0Dq2cWcN65/KZeaQ6CO8wZc0?=
 =?us-ascii?Q?/jlD6jeDlcNSNcvj6vCg1Rn6ftVQPmeV+C2djlt+LmFGVg2LSWt5luBc0dFV?=
 =?us-ascii?Q?xlFPGLMTKOEP3gEYFlxJBCALTR4BTX9KjInzj3WktYlHPzNGuYtSj6u2NoDG?=
 =?us-ascii?Q?J/YURB4ivOrDllxvomkLRHuZgkGipFslNu/K0vw5BzD3lz/OnnrWCYIltzwD?=
 =?us-ascii?Q?NXbzlm+c/8jbc+7M9GJAZBTHkm0jSbETriaEteqTj2Bv55DUYHaWCODiMF+w?=
 =?us-ascii?Q?51c+jjUKvWmW5tat3kDpilA1xuFoeC2lyyi2b9o4HBcdKHmR7fzpbexSmuYe?=
 =?us-ascii?Q?lgMnhKXKdzs1hA5D7Niajo4dpSGSAt06g7m9EwjymbGg6JVaOATYNtsSu7pW?=
 =?us-ascii?Q?i+Wex7H+1ur8Y2B4CVhh9VtIGD5oykiiqmCrSb7b8WEPil80FE1XPwH4ReDA?=
 =?us-ascii?Q?HpYecT/I4jU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FaxlW73cIeJGxYw52SSvF44lbpnkkM995nib646xmzsf9kuqD2ISECJjYf+K?=
 =?us-ascii?Q?lXqOQagt1zgavjRXaU2QRCzHE956b3MKBQYJQxRs1wRmaQsVzPL3WsgFX8S8?=
 =?us-ascii?Q?vOI8/WSEbovLPi2MgWdndXQHHdAG9xsp9xO+UMHtVZ5eR4jOffgG7jARhPfw?=
 =?us-ascii?Q?0rh5+Ew2QBVNqIFkj7BRy16BHTMGhMjHcKeun3C3l6IzNM+PrUzIvbSp7HX3?=
 =?us-ascii?Q?8x1MirH4fiGRATKfJKk1nPodMs8hlNTMQIDlbY3MFgvIRSFDlPHvlcXILvaW?=
 =?us-ascii?Q?WPJMAYir7Exnf4RBNPdBroyP9y+GbYlO6ifQ+5VVDta8OP/0wT3NCQCl7DNs?=
 =?us-ascii?Q?tbXDgczbxzsShdG3hJTDiJL6p/ij9noiGnJOBGXHvrkGWpPDWZnY5GiCbx4d?=
 =?us-ascii?Q?AM3roAkZeyAVizu2djcStN37u4EGL+Xw1V+WtVU7Gs9jE0Ch6qlJPXhV2N7o?=
 =?us-ascii?Q?wHLmQ4r0+XoXMpyJrPqDr2Tuf2ltLTRJuQgYOxtE1KRjyrWM52H5tjr3zk3V?=
 =?us-ascii?Q?GwfcB4ADNYFGDNbdfPySHMogCl4HstY3xZS9AtfNdcgJ6/EdGXtXKtCzjMKv?=
 =?us-ascii?Q?R/ZjL4mIo6yGZmUxNgeb/LCHPNwmqJVqhQX7gtFwORqpTV41qctxQVO9wiKn?=
 =?us-ascii?Q?KXJNkDtvGXfOPoeDqG3AtR+f5eMQL0yM7FAPq+LlFO2pw1LTZ+mx8TyYdE7M?=
 =?us-ascii?Q?5bttHnpfWaeO1i0YlHhBD2qb9c2UiVCRoi3xQIbGO3mSVgPNxEAxPP61v1nv?=
 =?us-ascii?Q?ptU1FI3JfsUDp+aUKQshzSXtleVkOAErmHVwtCTT1ZQ3QrfKFF9HavEI0fY8?=
 =?us-ascii?Q?2okF3xEZz4eRwepaCFJwQqH4H962kwCjyDK+bZTn6N7LY9BClVk6l39vieV7?=
 =?us-ascii?Q?/K1uWl/TMhk8aYRmhqxqv6AIbZS+yxh1oX+3nU6St/sd6TG8ibln3r1h5qfR?=
 =?us-ascii?Q?jX6OP5ViBK8m1IeXqFnaA/MEt51ORHRHeE9pTxyOYvbYonXQcCfF7M/wUkaB?=
 =?us-ascii?Q?IaeYRIp9/1gXdu1GiME9tlh+M9eM3Avn1iPtEMTB7yjS36AmjEgAi2mrbwVq?=
 =?us-ascii?Q?ES5JNCHoCe/NIdlSVjf2AUBxCddhKXKjfvzEqcCZ4ewpycAVtThh7xol53w7?=
 =?us-ascii?Q?wwx5pqi9i/YEcS5HyLWtChgW12ZA5Ee6DyHGvhjeZCZr6CHPkZ8A8DmQPauO?=
 =?us-ascii?Q?2gEl6sY0/+Qi25kqDzmtB/YRJizpAKuN0VDskT1+ViV7pCmHkXdh3sK/K2Hw?=
 =?us-ascii?Q?hkxsBMtb8ayfTwhFofwXfqcoCsl/up8YFY7rRze4LYlSlzzQzC3fLqDj3v0M?=
 =?us-ascii?Q?NP/v40EX4lr5Kx5ouJKOeGusQTPRe3tsbWpoIBXs0d3aL+iYTj1Scv33+ZG+?=
 =?us-ascii?Q?7IFKpuB+hPtAfT7LX21xpDmykpBy+2r/NoeVUKpK0Bi7OSSfK87EJQzUpC2K?=
 =?us-ascii?Q?8s2bO7Ty0duafqMRjMqNW4c/1eSZBRr9ITnVzO+4NyNX5sonkcMedUF7KkTk?=
 =?us-ascii?Q?w9h1i9OyFmqu/M551p49tcVA/9ZNVhW67xJAuYDgvZiKC9eLTue9bhay5fYf?=
 =?us-ascii?Q?ofyNXt8qeFeHVgZy7+q24zdXdDwdO4w1vJcTEUb/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0c70ea-0657-44f3-c6b1-08dcc36b6289
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:01:56.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qat6ULf+kTadjsijS9i2d/iTgZ5PeKSsGrKaorn3+wAxDntjxbZQ7z304YeRR6R2XrGPHzho3pnWHWuomGI8+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6760

The debugfs_create_dir() function returns error pointers.It
never returns NULL. So use IS_ERR() to check its return value.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes V3:
-Fixed the wrong tiltle compared to V2.
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fb..ebd4631b6 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -489,7 +489,7 @@ static int __init create_debugfs_nodes(void)
 	}
 
 	d = debugfs_create_dir("cec", dfs);
-	if (!d) {
+	if (IS_ERR(d)) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
 	}
-- 
2.34.1


