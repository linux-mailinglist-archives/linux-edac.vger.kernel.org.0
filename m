Return-Path: <linux-edac+bounces-1934-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599E989BBC
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E20281D47
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B46B15C140;
	Mon, 30 Sep 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jaXB+2L6"
X-Original-To: linux-edac@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2066.outbound.protection.outlook.com [40.107.117.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D801547DB;
	Mon, 30 Sep 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682056; cv=fail; b=LjpWlZTRrguwsCbf+S1Cs9686K5gycJzWuO+CYXsCbGT/kgI2DnzErOlSdyFspaShe8Rz5Er+/49LBMgOyMmoQuBYflOA4f3oL6Z+9BNF83e7rmJi14EG33pHp9U0YNWua3lMJJwzp2o0HR+BWnEftJhv1OaxPiodPv2dxm+hyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682056; c=relaxed/simple;
	bh=Lt6ZVTbk1KOUCwLYMtYqmp1ssNT7qtl8qYbCgESs2Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pL0YuGW5h2TZIKABtAte1OUHYPO/i4dSgFaKdcpEO6lyOuyFiZFVwnD/3pmV6jHxCAWfF8SNuTpUaX/d8AB9iNc95tOrA5NXJUZpXTU41n7I6UAmMbk/evOimo2ujYEwBy/5Ch+0m11ophZW9UOeEaIROC3sheMAgnsd2DH2bXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jaXB+2L6; arc=fail smtp.client-ip=40.107.117.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGCnarDswOr9vb52DtuAY+ooGahRz+gEzZkru9jpNyQtXTjgZmRPdb8A5mw0ZyrHwJHtOsS+ndDxIdVtidsx9BPldkCDlqIPrud27kUbvW3nP5Or52D4Pp2EDJq6tppIDt/fLrtP46FsatRcLbgq/W19y0Q6T+1d7bC2Y4HDk8hoVGY54TaU7AuOxGo3uWp7Oqns86DcRZqLcYAhW8j7YsAVObUZJOtHT/8CmUZtRDOcGkA0ncc8Ocx4BX7mdz2DsySU2vT1SxBA4hD3PIBicnBXyCWaFaLMWxys9O4J9K6aaDfr2lzYUof+pzAP6H+MhQf4DouhN5jqalSHps63Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39AUcV72cp8kWbeIedZIHOSqCWIh9m+lzDTuldehsfY=;
 b=vKFmNQgUv65+a1qwddWOMW3x9LdxeinHNp9rx9zXAGsMB80WzZTOMiIs5hrpbT3Zif7x6ltJ1ZYV3vQDxjrh5fIib88vtBnkJEq2IJVpmsMSFfDV5mAEfqM3LdlSolwjBqw+NOv7WR0Th/a/xAc2iUxgVkJt0/DbSbhOQGFBjfhy8gP+uzU+p8n6WGorKuwCEgc5pQ01rqLaD/84gDA4fXMbs27EsR/x/506bqydpM6qllyOsX4sRndsIDRkxMj2E3Y8Q6/47k44dkQVYl/uOlAHWWX7d0nK+d0uG6RCdSdFzqX/beV2X1UnFD1/3wJrAOcdYCfmlqmI88fCTJOKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39AUcV72cp8kWbeIedZIHOSqCWIh9m+lzDTuldehsfY=;
 b=jaXB+2L6v+6/vPQ5vBsUeNx/bLp2uG2SMYLMyLH45Mdn8WdCRePG83WrD8Q347kK9jw9DFcEu6fnRR/3Y+fQXT8h394wkurCeAqwcDwt2joPJriN4mWd5vZOKO5E+8HquyFhBWz7seXqvybreJ5mxv+4eSnFkzRo4K+e7gHQWzB972uDHAg87T96cQAoBzE1beA6cBpnqD3TBrEeYmzx9rGINbtY66eXwZyBQQ84MlTJ/fucrGjDewDCkEmLN22JAD9GQ0uI8KfPY7kuNMMsJ0rHMuFMK+l8J4KonJgfdYclLA053YKApmeBTb0cOYvg6BQ745w2HvEA/JSn3PYAEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by KL1PR06MB6790.apcprd06.prod.outlook.com (2603:1096:820:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 30 Sep
 2024 07:40:46 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:40:46 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] EDAC: Fix typos in the comments
Date: Mon, 30 Sep 2024 15:40:23 +0800
Message-Id: <20240930074023.618110-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|KL1PR06MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 905cd669-33c5-47b9-1f48-08dce12331b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8V3o71Oq/14bkIzGU8g4YnfeyWC3RjhbIw4nD1qLGsFYLfQyPMrzRzVuxP5?=
 =?us-ascii?Q?kX4sRfKS/s4tlBuE0naqbzyNCn9uUmbCzMk91Pjh/fHG2V0U/CZP4dOfxxIF?=
 =?us-ascii?Q?lGI+w85VUHM4o11JeabkZnFpwKb0NEfmtxl+F25toBtVL35SHshSMn9QYLYL?=
 =?us-ascii?Q?GcKy/FTVhr+S0hUT/5O//4V3Z48zJkIq9q6rAiS4pBbzR1BWtz/EWbU5Bnud?=
 =?us-ascii?Q?kUOxM8ZnLbh8mY6npmChB5j+ypxRX39xAfpu2THmgPQ0p11tiJb1LaseMiWj?=
 =?us-ascii?Q?X3a5xKHmpZDRPAy6vOapAlX21QDKt3Dw3pALEyBCs8pfWLCz4HEAFsTKtw0N?=
 =?us-ascii?Q?DqcPy6hs7Wz0xPp01Z/8SvmF+tLhhdiRThMqLMEhKINZXa4tKWRreoyCn7Bk?=
 =?us-ascii?Q?2vdLGs310cJN4jovzzhRPSP+OpPkg3vFVP4UUooSzKwM+0arL5R+ahIu56pW?=
 =?us-ascii?Q?ULo8cguHuU01hD5RqcGyQg0t32lffPGeZ406PmeDkvmvxNhnUZ+/0zCin/Vn?=
 =?us-ascii?Q?QuWlaDovrbUQ2AO0dOe7u9X5UPrtEqRLwNRpKic2yF/7kISdoXyIY2sjAYs3?=
 =?us-ascii?Q?xtzbxUiJTZRYhdCU6kFw3CE5Pr7uI4ZYnAO8I7skWPovCwrLVWIhviw5V7KO?=
 =?us-ascii?Q?MHFixV2z36yC5Eu1rVu2w+rkukU3GJW0OnocJJLmsTZFiZEwTaMowza4JwCp?=
 =?us-ascii?Q?nK4x4tF7oBq83cQQg90aPfSZBh2/3aidSTGC1Rao7TD1vSzERXOH26eivGTr?=
 =?us-ascii?Q?ZMREaFVAYVxx03usFx0B6PG+H10v/cdCP2XpMks+SJncR5o0pl4P9ATcIfe1?=
 =?us-ascii?Q?aaNPNoom+X2BKLE1cvFc2KA03SvEh/ZQZzscw/UJsMtCGk+KcDKMSIUZcGll?=
 =?us-ascii?Q?OPN4bi3Z6NRkV/uuHdv2Y3fbZDXh7tV9mcrjNHrLGf7Xd+geIQmL/5QhI3Mo?=
 =?us-ascii?Q?ZVIC4MhjCx/+ZyxtrLJ7To1aFTXRP97Zg0quuLXmQSIk1eVmAQb9/27xX5tN?=
 =?us-ascii?Q?mu2hVdI0NtBXS4WWmQuCrBmp1SoMXM7b/T1WVlhN9Xxt4Lyb21ucqrLoDtWo?=
 =?us-ascii?Q?+W19yxC5VScdd1fWPUUnRvxkKTL+QRlF3BZRPPHqR+BxhbD9ZzCrskdVvBJU?=
 =?us-ascii?Q?8hXi0smxAZJ1LFeCRdVS8AswY0kMNORnIZ1OKJvVekuDE5hT+5nOuGza9g4+?=
 =?us-ascii?Q?k1BA7JTfdP2G0mTlRlv21ZKrHQH68F04kN/Xqj2AzXjmZsSIdCaxTFEvUIlh?=
 =?us-ascii?Q?2AksNRtyxtgNASbwsBYBnBbZqoOGSztK0YKhG3vJ19yxNsCrN+WuWlqKIVrL?=
 =?us-ascii?Q?leBGC6UxoeqU1V8C99kIU1yKKAI8Ymh6WMp1sJ74mPTkFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eA3xqMWjwxEAfvt4EPwsrXBNKFM9LS/WKHOl63yeOlO5gBZ0MOP4a0gSBpba?=
 =?us-ascii?Q?Z7PdOLvxznKQxsEOaDNK8g0MJyQtzxQgybIprgsPDkEb4VGZQws9ovoTJOqM?=
 =?us-ascii?Q?p9q6ul+uXIgAF3/0USvz92eGYOhglhDkHUTHpbJy+SQlm949pBckteUNrRbo?=
 =?us-ascii?Q?fmSgJYtEHOiML8D4lTsuMasUszbkIPoJwmgyOs3T0krGktgj5ahRF7cBYOzr?=
 =?us-ascii?Q?QxP/V771ma+RAYHkPXl1gR5rEmax3efawHX1kGagTK/IAXyl3YFUXRbs5c05?=
 =?us-ascii?Q?KmWN3aZCB2vp6cnj3ntXOvCM4bGtEwdtxvsk3dU4LY8RgpHn0onyGqdHD/am?=
 =?us-ascii?Q?VOe6ptsavYZpiQa8RqeZPNB5kHfNlRFfIRs9rTzO7yIXSPkZYUQlPWRGPHeW?=
 =?us-ascii?Q?T+3A6bY+JsFZuuNCb2lt+TQqvtfqVSxfAoS31csdTuEcg33SL9looRE6WVkN?=
 =?us-ascii?Q?xEtcKzcA02tOyuWqKEpuwk58B0B+YGgYpjA1zUwP/bq3efVHJnyA+FHsphKv?=
 =?us-ascii?Q?OqIGMjt+o40hkXPeyKQ5T4sKvNLcIhBf4pP6trey64EywywIrwl1cym0vvOv?=
 =?us-ascii?Q?/hssml2Ekt9HeeCMmj4TXcg4cihYT0dbVW3JBOd8mpIy2i2NA9q8psz4so1/?=
 =?us-ascii?Q?XSVceApR6rEgaA8cON9Nh6Nz7ZoDkbsTzuZ6tqAAO8d2QJ+IH8KXqwwCQo+Z?=
 =?us-ascii?Q?peaMajOhLo/YEIJ7DvYWqRp2/zPIRbz67dwLDq8HRHHc2oeyA64fwciOZJls?=
 =?us-ascii?Q?U6KLsyTTXprRUVBuhU1JrEh1UPHRdtqO+Ary6ZxgrtEBSbhWndnRivDTVAMq?=
 =?us-ascii?Q?fMqZkOv3iqXzi8T0hID7XdueVAcxur7RvMlfc1t/Gwh7stt4Rm0BSe8Spo5D?=
 =?us-ascii?Q?cxA/j3Aq37g5b0OEY1xSMaPCwn1jSoYD3iM9izKxMoqUEcH6jAs/kaIoZhSz?=
 =?us-ascii?Q?ArPvOR2kzAvgbZN1siBn56h2mm7uIDqLS5jc7yyavrMLapi1PgVDt7jtYyMi?=
 =?us-ascii?Q?MIu1DgA90KCA4zpSC3HYpsDfs5IKGyZlirJTSEdjCr85sTZsqbM1PTKXcT/I?=
 =?us-ascii?Q?qvvnta8hooWu2HvQgMkjhg4/SvwzkvWzYcZoAr1xQbfW12pcjIK4HcHSARuZ?=
 =?us-ascii?Q?yJo5D0arbw2eH745D60k8YLZBYd1Mk2mbA/9rsUdWsDo/0dZDMHdF9iGdgEc?=
 =?us-ascii?Q?mHnUBpwhfMVfv6VdxXtqMPfy/hm19tGMYU86wHa7cXPKer3xODDaetKmDYNZ?=
 =?us-ascii?Q?mwVEYesjUcG95XgpqLQsYLA/QTlqfM9IeZjr0UXr6PYTrswX0hSw14MTcCpj?=
 =?us-ascii?Q?wvZSruVuolCK7ZSEBWC/gpeL6HyiTkgvWfTfMQhgYz/97YKYVUFNIDV1ls+X?=
 =?us-ascii?Q?1kp3C3MOqOmxBLi5MglgeZsTLO5+F9FTlVYVxn2c9TMWGhyNfH+jIIdpwTJ4?=
 =?us-ascii?Q?i+NvdpGp3AkPT2qdkYpJJdS8qqcq5lhjHLR7as3UYGgx1eAyI5p21SuNpJjY?=
 =?us-ascii?Q?OF2XI1MegEC/5cgb1gzVkE4Azw7IGa2fhGt1enuat1W8evIKdA0oyUh/ySld?=
 =?us-ascii?Q?Srlz+PTnTY1BVs6TM+SWuaSIalOPM2K4/ZhqP/IE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905cd669-33c5-47b9-1f48-08dce12331b5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:40:46.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyDvSalWe7wtByJYpMBjUXVp03bE31x3qAS+SJjDcWHciv0vk8WqHDZeSZ6W9yajCp8gvsWQSgL8LZ/obq0RDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6790

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'Alocate' ==> 'Allocate',
'specifed' ==> 'specified',
'Technlogy' ==> 'Technology',
'Brnach' ==> 'Branch',
'branchs' ==> 'branches'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/edac/edac_mc.c       | 2 +-
 drivers/edac/edac_mc_sysfs.c | 6 +++---
 drivers/edac/i5000_edac.c    | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index d6eed727b0cd..0959320fe51c 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -214,7 +214,7 @@ static int edac_mc_alloc_csrows(struct mem_ctl_info *mci)
 	unsigned int row, chn;
 
 	/*
-	 * Alocate and fill the csrow/channels structs
+	 * Allocate and fill the csrow/channels structs
 	 */
 	mci->csrows = kcalloc(tot_csrows, sizeof(*mci->csrows), GFP_KERNEL);
 	if (!mci->csrows)
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4200aec04831..0f338adf7d93 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -422,7 +422,7 @@ static inline int nr_pages_per_csrow(struct csrow_info *csrow)
 	return nr_pages;
 }
 
-/* Create a CSROW object under specifed edac_mc_device */
+/* Create a CSROW object under specified edac_mc_device */
 static int edac_create_csrow_object(struct mem_ctl_info *mci,
 				    struct csrow_info *csrow, int index)
 {
@@ -449,7 +449,7 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 	return 0;
 }
 
-/* Create a CSROW object under specifed edac_mc_device */
+/* Create a CSROW object under specified edac_mc_device */
 static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 {
 	int err, i;
@@ -636,7 +636,7 @@ static void dimm_release(struct device *dev)
 	 */
 }
 
-/* Create a DIMM object under specifed memory controller device */
+/* Create a DIMM object under specified memory controller device */
 static int edac_create_dimm_object(struct mem_ctl_info *mci,
 				   struct dimm_info *dimm)
 {
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 4b5a71f8739d..4a1bebc1ff14 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -338,11 +338,11 @@ struct i5000_pvt {
 
 	u16 mir0, mir1, mir2;
 
-	u16 b0_mtr[NUM_MTRS];	/* Memory Technlogy Reg */
+	u16 b0_mtr[NUM_MTRS];	/* Memory Technology Reg */
 	u16 b0_ambpresent0;	/* Branch 0, Channel 0 */
-	u16 b0_ambpresent1;	/* Brnach 0, Channel 1 */
+	u16 b0_ambpresent1;	/* Branch 0, Channel 1 */
 
-	u16 b1_mtr[NUM_MTRS];	/* Memory Technlogy Reg */
+	u16 b1_mtr[NUM_MTRS];	/* Memory Technology Reg */
 	u16 b1_ambpresent0;	/* Branch 1, Channel 8 */
 	u16 b1_ambpresent1;	/* Branch 1, Channel 1 */
 
@@ -1210,7 +1210,7 @@ static void i5000_get_mc_regs(struct mem_ctl_info *mci)
 			&pvt->b0_ambpresent1);
 	edac_dbg(2, "\t\tAMB-Branch 0-present1 0x%x:\n", pvt->b0_ambpresent1);
 
-	/* Only if we have 2 branchs (4 channels) */
+	/* Only if we have 2 branches (4 channels) */
 	if (pvt->maxch < CHANNELS_PER_BRANCH) {
 		pvt->b1_ambpresent0 = 0;
 		pvt->b1_ambpresent1 = 0;
-- 
2.34.1


