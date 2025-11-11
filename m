Return-Path: <linux-edac+bounces-5430-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07300C4C5D3
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 09:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F2E18C0BEA
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C42957B6;
	Tue, 11 Nov 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WCFmJK8t"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E232EA756;
	Tue, 11 Nov 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848955; cv=fail; b=iOQc45yJIY3DMvo5Rg5ihr55dK/BcWzfhm5tvbnPp56qGRGJjhIVCI0jrIiNilOdygDwpakrFGHf48+SyZ1zdHGaOvAB0xmzeD+gKWQKnQWvo0qyiscnVmV46tHgtn4SRy9lGG4lGuuyUpoAXwi9UqrEgjdJjOdeckdqaGXX3OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848955; c=relaxed/simple;
	bh=0HwrYi+ss7JUUv0tiqNVizs3q0/hcFwsegfLN7wsAsk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ff0AwbU57ili8875h9rrYAo1LjC3LSGBaQitKnqWd7ieMFVV8V/o0UgWco4xo156vZcbx+2QA+waGcMhsPtdxE8qE9zWV3BfDoukSk/YMc42IeyNyidHPfSfa9MXkFCfQS/rGTftKv5/WUV8kPpDDEdAeKt6gKAoCNfnH19OXfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WCFmJK8t; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRcfpZsE1p39w+iHpnE5Wkkk3LWCr2SAmwndmdWwtzFp5REyykHI5c4+1U2BdR2QgokvdSQcKYv2VVexg5M4g21YP+HlRW3F6DtNpCmEoJze3hZbiUQzfpvL5fYJKWuwgZF9NxlTzGjKJWtMp9g2n0rNqNi7u0tiH898ntvmkgws9hLoJzTSrJeqvQXsSATKEn+eh2sdRSoAiVQC0VKIhBRCMtelATKLqKmE6/fE9ViFZqOH5QzOMvVFAkdppov43OIINPfZcCi1jiFBE2x7BWvuJj6vNMb7LH2g1k4Ud0B9J4FVtI04+n4kbtS3W0r4Pu0plXjyMM0gPohhZkJLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itgkEogQdNS1kqF+xhSsatNJtL5PE3O6C4s2aOc8Aik=;
 b=U3z6cmnmzI3o8UfQWGdHlQgk5BXYpCng7npu29CAsWJoTbU5sXMklmiFo7g1pq9VEI9Jrp4cz2dyI8O7m9ePuHD9gf0nNG+8JQqY0X1rJjPhBhu+OdbHkJnVqdnkrzf2fcZ+3+zYTf/7K3Y0JK/4CgfYexrJbDlZGHRxcK3vxSBTlKl4dxWuTa7oPmT2tubyaynPwVXCl0QCFcIX5teSsKs6YevWVINSsFV3krhczsTVWSbMkkDM5Q6mrKX+xkTHtYjCtQQvcPpwxOkgwEbeesIUAuHtxY1cOq5swhhqIvkp2mSnE9Qtf7odUhvpglIarIbiZixRciNqrwokWYG49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itgkEogQdNS1kqF+xhSsatNJtL5PE3O6C4s2aOc8Aik=;
 b=WCFmJK8tr9aOlv7YH5DnLAiwqsrtYWqeLcltWpJTWo/aDSx5HO1uGgWFlVMViiDv4mNznJAifkUoFCW+3SNlCYcdPeOAg8mPowiHhmARkrQEUb8g2Nl+Nn8VCCnqfRLBL/hiQI4djMKH7U8NOjLJCN5wBeoxQiKGmW+ofGS2wgVp5dwVXtvWru632+uCinznT82dVDjIfBehabbg6S+EH/5Kh9t1euFH7XSPapQnWhc9CQOrq2TfBVG8eqv/ZECdPmmQju4fYZ7hrNML4z1fmiZr4qJZoJLm9+pGIuOcI4a2342f+CT3qBXaQywdAS7UjO3V1iOztTbZ12+8b64ZKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5669.namprd03.prod.outlook.com (2603:10b6:510:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:15:50 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:15:50 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2] EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection
Date: Tue, 11 Nov 2025 16:13:33 +0800
Message-Id: <20251111081333.1279635-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::14) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH0PR03MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a392d3-1f41-40cc-9560-08de20fa8683
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+1yKor1j+DLDp3OOgI90qLo8COPi14CC7OBDn2ASh4l63nQXZZnPywsUhuK?=
 =?us-ascii?Q?MLo46G4ycSbO0J8rV7MAP8fjxhRHFBsSa9PpvVFatRlaAJa5OHbGYZDjnnmm?=
 =?us-ascii?Q?pa6TlWcqfVXgEDEY0EN8MDZOXwcpKoqFd5EXmH+oKur0X+Y1EYmU+ElU0zkP?=
 =?us-ascii?Q?16Py52gmzNo4+6ALpQgigrRyBxgxNj2LrX/yPTSPN3fBzf2ch26iyxUW7NMk?=
 =?us-ascii?Q?Nb6yTubGB6ITnmNvggQnqcDT9JeroULiDkqKopLi3dq2H1mn6m+1Hz7IIDmf?=
 =?us-ascii?Q?FPniUhv0SJHpX3hrF3bJbOYvkpIijepR4dmnjWMXcStYfUxETBlb31n0WJ8J?=
 =?us-ascii?Q?4JbT2WfCeviwr4PF27AzNPt3JiTQgQ8OqsW8UWVdE3xg/LIYJhrzSg3yUpci?=
 =?us-ascii?Q?Ud7R1PU+tkFLVYPwZhF/45GBEjUASPeaNXZrKoI4wqSinRMeHhQgYuZBL0hs?=
 =?us-ascii?Q?YL5vz2RESw1ii3cf+/N+6m3FVwG7R6MAI2RzRBtRq7PW4WAiViNL2KOF0n25?=
 =?us-ascii?Q?QY6AalxPS0U3C9aYHT3vE809xvCbmNy3nuo1Ij9Yg37AMdLgzZoqYCNBNvSe?=
 =?us-ascii?Q?NYhs4v4h0Ge9A0Q0j8IZ7tPKUAI0X3Oxh03KUfdZRoYTxTcQ7ZS3j3lP1mPU?=
 =?us-ascii?Q?FYwLmDgXUII77Dv/fSnEmEC17EZlJmVXBEh68gzyoPO+ktkNMzdrubdvImnu?=
 =?us-ascii?Q?uJVz7icmnIuH7XCos0Rl/sbmN1j83zE1RJoFPyOfNCSM+X/GE6NiR52rn2KZ?=
 =?us-ascii?Q?K3XE827ysnMMYpAT6GDkoSS2Cop8hYIOVeYCpZ3WN1wUX2Xsbjy9kITKBfu1?=
 =?us-ascii?Q?s1K0/3I/zpS9PTejTbjBgCgMKX/Zmnj8UWw/ZLQS2qC+RQVGOeZbfTIV0Evl?=
 =?us-ascii?Q?udLlhgIStQ05+ulhhIJB5qd/yDIJh3l2xytwf/3lWDFmg1KVGkChRL4f45Xr?=
 =?us-ascii?Q?12d6gCTkbuPmVg7gy+aOqGePvWz9wY/cnpBTJylygkhLzgV04SDOhj+hqF7W?=
 =?us-ascii?Q?1iOKmPGfWxanZ3clpmwEUtHaOsepm+hsF09Wov0RKBRwvq57mWNNITavn5N+?=
 =?us-ascii?Q?5Ia0Jt2GzjpgvBOikfhePbYCj+yLcZxtGw/Oz+Hz7KkNMnKpEburGKVAkxAQ?=
 =?us-ascii?Q?yXc0gkXCrz1i4uwcSg99j9HRlhPZ3jQrws8xPY9ROvtWVi3xP20+QCx8LE1m?=
 =?us-ascii?Q?WHfB7McnHigwwpYM3ML2MEGGn6FuZEArTLuNFsldZFTIKxQ3XLrNPcd2kdKV?=
 =?us-ascii?Q?Y4SHdgcovUIuoCSmS7ZXyIt4KHX+LghCeooa+hCbqkXwnIzFOjvDCKGWROWp?=
 =?us-ascii?Q?BIkAzG7Imhwjeckc0BeWdVubcNsVLkvQby21/g6mjZ7SQMwMuIDmclErdH2r?=
 =?us-ascii?Q?Kmx09V8TXHKWwtJD7/BbmRB1ww8g12aQ30qIUW9FyqEnZwQ+A2tCEnCLjxo1?=
 =?us-ascii?Q?Hd1j+kLr7z6jIrLgemCtrk8mcX7abDVaTENjSl2jZjsOZVcgFID2sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9dGWHohIph4BtkH/vefdM0CEWK6fjfUOgd/qm7d0fm/E4WYB5k+SVlDzxtl?=
 =?us-ascii?Q?jjFGAD+riYdgmu0ZzDLWBTWOfjY9BUdOtnRNcjTuM7eQFflegudUrOJgjXa7?=
 =?us-ascii?Q?YUvWKYrcqA3824YumXKLaO85sXArGn1CaZA2iXiXuMyinjfC6w0TNGYL7Bbk?=
 =?us-ascii?Q?eXGX8m7EWyCoz+IXxdJumX38nRrp5UNzEGJetOr6+i5MozmoQfedFr+8XO4W?=
 =?us-ascii?Q?H13aChBUjVOROadT7PQUWWWBq16uZ0PTZnQ0SIUoobF8L6bbC0iqsm4uHk4f?=
 =?us-ascii?Q?V63W58AVkKfbQVdgPourTny57ENq9Ct+rhYjFkCGxFPlOUCn21sjtsPD0ewi?=
 =?us-ascii?Q?DC6NAHjLmYYF6gYyNTA9F9EOMXwIPf2O/hsf8Vczv3QcnJebkqn5H0YQvo7N?=
 =?us-ascii?Q?rb4zDi63FJTq2mNEBikiLDzUFWUT42ZrnoCDE5kOgolmzbs6iE6mfRz7R/qT?=
 =?us-ascii?Q?20tDVv8kdmnn4KTuljpDnwv2Jc1rLe69un1CJpi14c5qH0EpoVW546K8Olpc?=
 =?us-ascii?Q?K/ADLaLEXgb9jgaI3IWTDIx8OUlymtgMadglbIYZe0hRghoOBO+iBLx7Vwr6?=
 =?us-ascii?Q?n3koUhO9N6dQ48bHPII0ToohLF2bXLtkVcGFM+cjsirZOw14/gdc6ttxhwl0?=
 =?us-ascii?Q?zrkm2/wOA4UwPDR6o+/59TBR+2yHBUC+hnPg6/y4iE7qkwSzpFKTlbuN6hkX?=
 =?us-ascii?Q?17yBea6vFyxZyrcNqruwSVYwleN5raeXLBui14NrEZsuwXQuIbcAdsegQUQj?=
 =?us-ascii?Q?EnB575s+lFJ6VRencFgflL/QEmNat+vgCWj1vRGLYupsnmJH6P+gJDA+5lyI?=
 =?us-ascii?Q?irfpktE9oXBURmVy+1rKBe7LOp8PEbWGwphTPzVhoOjN5aRgE3HX4fjq60ZI?=
 =?us-ascii?Q?UpNE50YBmbgKD7Zce2bzyI6HiNEQ6EMnNrpGa8VQkYJslMQlhA4Ac7lUc+NZ?=
 =?us-ascii?Q?BS5+KJ8ruddhBA4HY4gQP6uHP0XEUl8AcTTrB/I+iu4aun8oQ4pr9bYXJeZH?=
 =?us-ascii?Q?/cv/pkSrTs9y5n7NpEaavGvScwDnr6GZpR9eQkc5yO/F896FyFtivzstGAdZ?=
 =?us-ascii?Q?pUx1HXB2JibGayOBDoDWL69sqK7fYO1sYgtuEF7/bZj6U2VLmVLDkeUbL8CR?=
 =?us-ascii?Q?zSnRDo3Rm5ji/MkG6t0u/T1czH/+5KwYl0qPJf1B73aEHYV5zWNceP2bfnVM?=
 =?us-ascii?Q?P4aCGpMmoa2U7mUtTg/IwPTD160/YPN0zXvNDVRsvwG1Y68kcj5w79V7jkIm?=
 =?us-ascii?Q?5zAa2xTGhTcIuPJkW+/qmaUuiHqPnuptbvgZypMA3K1x7EAo1u0BP8LeFXH2?=
 =?us-ascii?Q?d4S6vy1aT7xdJigO05HZHqkPnUlwPc2b2edwSiWbXsykFvhpTwpblzk1cCe3?=
 =?us-ascii?Q?LM+tMGvdgL9c7QGVob0PFM7vOYpqez71Dz2F+rdcJyZV1dVgN3ZwZJawKJKD?=
 =?us-ascii?Q?JRSR80sAixcW9Wwo+SNhCYp14wtYG2NCDiz8OxFcP1sYTUODRmGp5oSlNwvm?=
 =?us-ascii?Q?4JWEjIMll+DMI5OwEMsPNk9dF2NVz1ctHxl231yfarANYQfN+BSIuhL+cC5A?=
 =?us-ascii?Q?opbS8/e/AXb/i+rLX3Qi3OyfTMA3mVtWxNmYkT9BC4eBKH5/q9ZVjNnbTw8Z?=
 =?us-ascii?Q?aEowlaF5fSiRLr4u2llQsPSsIUqVgqZz7KzoIeXBBvNM?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a392d3-1f41-40cc-9560-08de20fa8683
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:15:50.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/1/hBBLvs5PlnyZR8/3qDpBXTs/3jQwzTzP1YaMFArqd/qBLewt0RjeDmKLoUSNOOEqLN7CHANrqG4QdQPkkuyy+PbISZwGqHCXiAWT667i8mryOWp9Gudy8qiFKi82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5669

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The current single-bit error injection mechanism flips bits directly in
ECC RAM by performing write and read operations. When the ECC RAM is
actively used by the Ethernet or USB controller, this approach sometimes
trigger a false double-bit error.

Switch both Ethernet and USB EDAC devices to use the INTTEST register
(altr_edac_a10_device_inject_fops) for single-bit error injection,
similar to the existing double-bit error injection method.

Fixes: 064acbd4f4ab ("EDAC, altera: Add Stratix10 peripheral support")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

v2 changes:
 - Add missing Cc tag

v1 link:
https://lore.kernel.org/all/20251101051723.917688-1-niravkumarlaxmidas.rabara@altera.com/

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


