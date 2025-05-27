Return-Path: <linux-edac+bounces-4002-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3270AC5168
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AFD18872C1
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E9279909;
	Tue, 27 May 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kQLal2Vq"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4927602B;
	Tue, 27 May 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357839; cv=fail; b=C2QbPG5n3+1GXN3YHjlfTYrCmEOLFFV+hTE8ig/3rN7423oivA/4UHrIUo70NYI+41LJJ8JhhNh5JFUAT4Vy6PlB9xB4UIZWnA6oLALBvqzQhmV1PhmUGj9oIAOchPxwD8sPPRNbQH/NQC2llWPtO0AEF5EhlVT61lkAuHYW64s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357839; c=relaxed/simple;
	bh=NdSqPqiSL8SQQ/E/M/4HWWWAKimrpns7m/v09P6y1Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tHw7MDbaAOuo4iEpBxmJ3fqf/Oa/AL30jL3pzNBkRDgvArGukW05DLL0U7opXkm6rGNMXvl9wZHD9VFRBGyz16iOfJJQiJV1cRRzKUWRj7IA2wlsHeTossRWas00Z541cc1NbS1gMs3QaSvAO7NMzuwGscGpbWKV9obM2Z+Wr34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kQLal2Vq; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qczB4FAYpYxyGSzmxCaTeGO5QXauSDWNfd00Nv3YU4f9YcePGcUufdnFog0Oo+Q1InoinCJyhAlJaJyhqEIoaQ7upK4YZXgaZt2EHL2GmzXMhcKbxhlzfZoQ98oTggroNB4x9QYnlUWCmNNdl0ZJZlzPa5313HBZ26NkHvYpPyD6QdxCjbojzeCPtYkHpTY3beed2zOWfENk39DwVR09y8kUb9AgfWtW/LGjS7VvtnchDlkfA8d9YB783UughPBugR078FXIQ8LzhQz3g8kCb9ZSpFj0wYXw454UBkPBxrUzI4NRlZpGONnpsflo4NPcSv/v0N1K75JwsFmaRfW5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD+6+duKStMzOkvkMkAAAyLt+80jnN9uGjA5enAVxe0=;
 b=LyJv7iAT2TU6+SvIjIrVZ9X11rQGomcP3ia7gInt/CwFbBEt0kLgqhKJ5xUIzbVmTG37vyvp0VCeERfHfFRYNmXzETnthR7l4ny5qdQC+o20qiUrNU2vgTLZw0oCwKQ7WuZxf89/QZab6KJgdo+fpkKLO2aF4YJqkgfKne6Y0nAo/3YwQi1rDyppu/cs75CzDpc1MSOBENeeIR6xDD1KOcUgIhGhJu1aL/B1ts158j8gsZhCELeLRs/4vH4NVtxV8B+9yEhzsSg7iyXhdH5FuPhMzoCC5KmjMM+bmsk9M78DFdaR9o/2TqAmIUCwwUW/1jDL+2Rvl2deVel8Oyabhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD+6+duKStMzOkvkMkAAAyLt+80jnN9uGjA5enAVxe0=;
 b=kQLal2VqRvCmmph62mHBOZuBwiTVXaNDtlIxB87c4Qsp6uJvSjnIPMpGom7BUr/zVYUZlyiErNURU4WmS0kTlhgVVspDBKLfGbpeWJxaahmvrsyvwDd2QqQSNCCuGFawn4toAL6+VrYqwLZdtM1iVh2OiorIRPyL9+VS4gLfuYsUICAEzL2xiDxMxWrko2UPMdco5erPqLofgLKAKxuzc6Ga7MGtv87pBjeJCk4yf6LLhrlZY6AzwFqdM6vJsw/uYrTLthk3ZiC8JmfDmxSh2utWMiT6oOjN7igOEkEAaUiOCleI8FJcDFuqnnOioJqev8IR/C4DWB+ZokMeHS/QaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by CH5PR03MB7959.namprd03.prod.outlook.com (2603:10b6:610:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 14:57:13 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%7]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 14:57:12 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	stable@kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH] EDAC/altera: Use correct width with writes to INTTEST register.
Date: Tue, 27 May 2025 07:57:07 -0700
Message-Id: <20250527145707.25458-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::16) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|CH5PR03MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: e48d1a8d-458f-4e9a-011f-08dd9d2ec27e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+Ji65XiBnQyRKFpO9dtWlT1ri9CXJ6kkYTpSiRolImXFIM6/Uq7l8+TjmRg?=
 =?us-ascii?Q?CGGC8AaVtSP4H3eGmAbLHtB+GfBeUsCMhcXb2Zw+MaWJKLX4at+1DwirfJEF?=
 =?us-ascii?Q?59gqWqO0G6sJS/hMbFP6RlwaN+Yxw8qY/DIJwuml7BsRAT5hd1YAS3IvFBLP?=
 =?us-ascii?Q?zE0Oakp+HZhGzSpb4/l2h09/Sk77/wr0GCLi0JhBCDLD32PtigdBIySgFlB3?=
 =?us-ascii?Q?zI3q1c8oUGjdRo4TGukFBfTP0jgjHiMvzmlHFbHLn/8y6q9vHshIlfNFVZXX?=
 =?us-ascii?Q?mbwd7zGmOPXalk7/EO0jJJBhPlmFdJwCQ0kS25ZtEl9yLKJl/oVZY4+PMX+3?=
 =?us-ascii?Q?rhDlwCjGU7FO6FODLex4NfuT04uODyiniePZuee8DI+3fOJ+xhO6Mko3rl1n?=
 =?us-ascii?Q?2Ctl325YLngGUiyEC2AY3RYedtkTX3O8eaavwv9hLR+RwQGOkfqNjrW8vuKe?=
 =?us-ascii?Q?R3zjbFYHASWYOregGu+rMaHE7UDExZ9ujli8GAoUPiHisN0hlUhnM8zAdKbo?=
 =?us-ascii?Q?q2TwOI10d776/kL+H4a47WwzoBwtyvnLvGjhQUAWN5Kkx7Ga08NRTIWD1ixG?=
 =?us-ascii?Q?GkXcvHzcpZ3qlqLlz3PVGXWs8we6Mb+AAEOfPkrHz5F8aIfEtusJAV1VYAem?=
 =?us-ascii?Q?rp3r9W749nsP2cC0oybY7Uanoh93TRmKIEUlxVmyjk5NRJJod0NY03PStehD?=
 =?us-ascii?Q?zn0pXWA47QEqebaI38id3GM46mUp4d6n0zCH6u0ronQ9jUUnMjs3Vi2ZhCZ1?=
 =?us-ascii?Q?lKCGrgJe5n2lV9XebZE37qfI5D21oKbA7oyBstm+LwyKpiJBpsNXQAs7+Low?=
 =?us-ascii?Q?ENpcEnPEF5DtFYVb97YSBGvh8aEcBDIx3v+xl+9LWhLTCDXo8o+QqO2GlulN?=
 =?us-ascii?Q?IGIY06ygzvYjDfA9Cih+vMR/zemh6leqWHQhVuAr8PRLWZpkP1bvfpO7ecyU?=
 =?us-ascii?Q?tcFfi2vmF+YeLD6x5BGKtuZSmWTRjB7woDWvyrXJR4BKigqmGUceYiLEM7AP?=
 =?us-ascii?Q?uby4m0uz1roMmUvvh24rFfAhfoJEzbAmtD/HxwPAOMBD/+DA95NhNZw5wfj0?=
 =?us-ascii?Q?6s/CyvzsHHtAgdfZXjZm3FjOgdAXr9RHObg1Ks3le6eYfxJBpwgsUgmz3xVW?=
 =?us-ascii?Q?GMMVk1Mr4sLgtf+01oTieyVdQtjQfiKUqcFc8SknzuI23zXlYhiUAsZAMNnT?=
 =?us-ascii?Q?a3kYaWhDIsD5tf2y+TRyv9PVN4SIdm5djYeEVPXAAVe34bBjZRUeQa1wMqxO?=
 =?us-ascii?Q?tqUmm5xvHXW91185FJj2LCHH7wskKn9vZZUrizpaZYg+CQYW7ysANkh128OA?=
 =?us-ascii?Q?/tCs/UUs3EZapI12I0K2mc79JJnZ3v4a8oW0Fpw3gF93OgRuYlnMB7DVA9be?=
 =?us-ascii?Q?d/8p89B7h+7tu63rUpAONCmyz35ABq/3BEvHfPRWTqrlAw+Lvgu3Ih9XLQ9/?=
 =?us-ascii?Q?gF0yLLvOrF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+gyN2yLyOsQHyIghM2ThRq4AQ28huGKUS3KxB0S5XlO52kI+qWo6pWNvUe1?=
 =?us-ascii?Q?PSjy2c1qXzEAXIyM4x/Q7c2xppvY9qoGeEG8jRKATVkQk7+mAuUdDYGJlTax?=
 =?us-ascii?Q?4l8CGXbu+GQmSHafWzBg6da5/+YOKcONaebk8T6tLbzgYZuYywX/OJoGYj0n?=
 =?us-ascii?Q?h+wJGD2dw23N7jB/FDai0dMIWY1SQx2KPUzMPFy97KLNvSgaW6LtJkmEI64p?=
 =?us-ascii?Q?7MrUpH6EJuCLVqN25xeHh3+5CHm7qR6qg8U1a9qc7eOcB97ezXc7iBM0JIsn?=
 =?us-ascii?Q?9MParF9iYIWestGPoFZUwy/v+rEv4b1Ap2r23ZbWp8RXMebXZMxwfzw6tP85?=
 =?us-ascii?Q?N+hgsk4MWwe3Z4FAP6PJ1+qsR0j+rydrMyXzpys4Ca8FDwrOFlRYsW245JN1?=
 =?us-ascii?Q?Ekr+XlTrkB2p/vEETgv/VRKfoqSD2KpyEUuqBaDdwabOJclrt39wSuV/6phP?=
 =?us-ascii?Q?BWbaMMjxEk7G65T1PMtT6DtLWio4kgZCQJavzwAynSNo/Z2bUx9Z92zJA/lY?=
 =?us-ascii?Q?coNP6xdKNceXziJnbHgqYihGq7Edesy1n0b/Llz4fR+uHEri94WfdDdXutqH?=
 =?us-ascii?Q?weda8AWpHWpS8uXcZ6crZIttHG2OJWDFRODirANmG7/6LctD7q7quFOBIhTx?=
 =?us-ascii?Q?pZLOxeEeAI0q6FTQSxVuQhFuVbqZ625f+Qh/4rlALNLzdqrZBbaQIUGGrjdC?=
 =?us-ascii?Q?rzz6/R3Sgk1SnSwczu+OcMFwy6BfUN3Vk6xFu1j6hs0Gc5eLmnTyirpeM3Xc?=
 =?us-ascii?Q?DVGZdykoNc+BaDAeFxNWyZ1ILG0GWGmcUAhSdGtyrA8At8RTmPW4e0Joj5RG?=
 =?us-ascii?Q?/BDpY4OYfZhJg47Kko+PPj9FVP/qedXbiPMjfpfw+X4bJYCflHxqoLcJC3dZ?=
 =?us-ascii?Q?xowB3A3nS4rRir20QWQhv5P5cXSjX6p+zMtLLVK1Fz6wX2hDMZ5BRZzIU6BP?=
 =?us-ascii?Q?GiTJKj1Lvuh8C9fVwyj4C2iEKWqq7LGjjDAyM2dL8lnT6q4wOAHxMXQb3ojt?=
 =?us-ascii?Q?fZ6hNmpwA46qy1+/qOsBjMZ3NWfxGsxT8m6j0HKo875dvFf3HNgo/4uYwq2k?=
 =?us-ascii?Q?ZvBuZjAJ0v5LuN1CbqzhHyCi6uTmyrFEkx4CiNvze6+3TI0vinm9znYxXHtV?=
 =?us-ascii?Q?fqASAwnXgO4Tt//52RYaMvMzgGHP6i5QaEDn509KmF3b5ua1VctNlxSqQ70J?=
 =?us-ascii?Q?9bYjP2po80dJ5QNmMV5HXs38scyNxs8ha/DW7RzchjgtGoRgyo12R1YbtVEz?=
 =?us-ascii?Q?9YJ/Z2AIg8dijVRi6suCYMr2OHRnD1FZi5dGDSDnXSMcg7DTfjn5hRkBgHOH?=
 =?us-ascii?Q?KFclKUMFgY68/0ZSkA+ES8FZRX6BFOXfINNxh89YRrZStZ7FiGkW7lzlWFiz?=
 =?us-ascii?Q?nhAGQam7tRPy0dS+kbQfuhWN7WxWhYmc890n22NuzYtdieO2BC8Zy4KVFNTr?=
 =?us-ascii?Q?b3gKyuUvGZnchV1nbwIN2K7fzkWi1dCX+qRDF/HXEMxKwl9Cd/9RW0Stvgzb?=
 =?us-ascii?Q?rWpqluZtJDgs43B/yELq4XnIDCmFV9yZlImb3HiZrOdAYsp4o8L+dtRdtEfr?=
 =?us-ascii?Q?vZHfN8nTF2F0rU8L96P19st33qmftql+lAgI15/cJmA5RMNe3vOnNMbw9GI3?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48d1a8d-458f-4e9a-011f-08dd9d2ec27e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:57:12.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4/969yXp+M2eqirMPx8Gto551ZYXx7QfTvWHTmBcgsCeO3Kl1DHodMmqXmaNKlhghMoPdVnJWie5NGVGKzZt3gHyGCYgga51QoYWnsrkg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7959

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

On SoCFPGA platform INTTEST register only supports 16-bit write based on
the HW design, writing 32-bit to INTTEST register triggers SError to CPU.
Use 16-bit write for INITTEST register.

Fixes: c7b4be8db8bc ("EDAC, altera: Add Arria10 OCRAM ECC support")
Cc: stable@kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/edac/altera_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 20333608b983..cae52c654a15 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1746,9 +1746,9 @@ altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
 
 	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR)
-		writel(priv->ue_set_mask, set_addr);
+		writew(priv->ue_set_mask, set_addr);
 	else
-		writel(priv->ce_set_mask, set_addr);
+		writew(priv->ce_set_mask, set_addr);
 
 	/* Ensure the interrupt test bits are set */
 	wmb();
@@ -1778,7 +1778,7 @@ altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 
 	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR) {
-		writel(priv->ue_set_mask, set_addr);
+		writew(priv->ue_set_mask, set_addr);
 	} else {
 		/* Setup read/write of 4 bytes */
 		writel(ECC_WORD_WRITE, drvdata->base + ECC_BLK_DBYTECTRL_OFST);
-- 
2.35.3


