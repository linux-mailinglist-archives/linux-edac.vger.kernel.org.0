Return-Path: <linux-edac+bounces-3374-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B203A6AB58
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 17:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4302998038B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0196121D3E2;
	Thu, 20 Mar 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="SpxQST3L"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB31DF739;
	Thu, 20 Mar 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489206; cv=fail; b=iZiNcw6p/9DFhqPYKPuo9s4ZW0ejUEh5UnYCs9W3eXfIF/cwR3rzyh3zsVFPBZR5jM2lvccLDOi0ntAplbz/dgBN7fP9wEtPnrXuFSqXpPQzSZcM2PPY+vqDmjzZRh+1H7PAHxRLsFR0EgLscOesCQzuTpVp8G5iDZk46NunM9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489206; c=relaxed/simple;
	bh=1DUuukOb12zbehszLyJ7y+Skc3rgugPP+fNjWJPuiMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmqnBE3Jv7QPQc1St9m3Teyuzs2Jz29WYMK4LvjArPFrpH4ezbPSxfAXVmIAdhZvXnK03PT9fng7tznDhzmyzpWMyfH9ctOQQybNq7KpNPVxoQ32CvRfFeksTv9K5V+KGp8Iit8P/CMP/QI5FO5epKo0mEcapL8SbsDon0lD/Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=SpxQST3L; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk9jWFXSzetd7Z1h3oTCihJD/c64KBSL8cY9tiI4pifdqCKx6UTaQ6tyw4+byE3rd7EI5zLK3dRUIJwxLOFJRcPYexWPIF7UMa0nyjCn1tVre9IarJYccuvn9evok8ltxHkTGEqgeJwQOMrmz9N3mj9FNGDaCUMgHEpRXM90MnmAj+a6KwGif30Xz0jINnygf+OukvwgbQnK4t2VInUxMrExVPGebTZ1Xq0nusMtcsbAcznekHAzcjCKiILdHER0fl4NSDjfJP2Jp91Jzs2q0temHe6jxiAqzIvTUDINlDH1M1U2hp1qmx3rUj3Pz6zkrVPoh2GBp3PsPgUyDevQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBHwzH+60c7mJn7oA0LpJXFJNmWFco2NOnC6Z+0HuS4=;
 b=ujXCmMUasXv9eFJhFo7SXfBZO/DYnjyTgTirgpmbW59rN3JSsg7r11M/2LUTS5eGnnHLuVKrKZEyjFMpu/6dTCAS17wdgEidX+3BZoDhNshRuFMib6p+U6CzuzaX+InP/kqBdYySah4ByoHxtpNEr9yY53QfK5hST1qQGU7soe+mzjSOnCRQnRvttMZSbCQlXskHrVAt61D4KjtnyZ3h7vfOhag/1Q0zhXwA0OFsNT741b8KNtmyL0UoMAvLM0COnX33iw4YzUFJEiFwjsZxmYzA0AFBtVUqFK0HF9a6yFf/S5QEn0l4UUD8yHSKlESb9wSvucKDPQSAB9VL6rQnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBHwzH+60c7mJn7oA0LpJXFJNmWFco2NOnC6Z+0HuS4=;
 b=SpxQST3LWeaCr5HwqEtQxI1XXlpdEa0WLkvPbze4bJPrDUHqPB7S5AAy6YAUU8O+ozoEx8HvJ2UGbBs5Usz/llTQYgMSsvQY4rBm9tJNIYDOeeBem4av+hf1sGbVHFEVpypuh1rZqjSI4/L1a9SUyaQNIzKETq4SN1rrzlOa2wgsj0QaDaZt0WeQ0mT/ydLedLGwjMw1uwjOdUZIGwV9oWIghrnlIjzHBg5G39iHI0C/VEj3Ho+IsaHt/LxOmqnoUpPUcbMTKjPnvWXGCrXekfXrEUSl1shQhlJ4OyaCDB6ce3o9WbSTfq+dYC6ylffurDzrK5AmtOPQJKS9I37kJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BY5PR03MB5014.namprd03.prod.outlook.com (2603:10b6:a03:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:46:42 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 16:46:42 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 2/4] EDAC, altera: update driver to reflect hw/yaml
Date: Thu, 20 Mar 2025 09:46:20 -0700
Message-Id: <20250320164622.6971-3-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250320164622.6971-1-matthew.gerlach@altera.com>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BY5PR03MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f1b9be-f426-4752-21ba-08dd67cecb47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LpKagnNyZxblvlQZ8dAHi3P+8z7u6CbZWoGnyYn9ngyaEkGjmf0szZ/QnFgR?=
 =?us-ascii?Q?B5W6+sV3reaf9+/zAM4ujMPetkfdzavxLcBy9w4XldGzTWUz38/DXXLeuUwh?=
 =?us-ascii?Q?s0hmvDPTWFYqSZ/kMqRiu7o+y58H69ZL2pESvcviBBIQOh3k6npQU8GFenos?=
 =?us-ascii?Q?/h2hcb/lW8yCNx688Z77bUMc8iA7avBgNQ3zTiyz/oRW41IGOHChQFdlt0fK?=
 =?us-ascii?Q?4Z0jaNmjYOWg3tNJzEnZZQ7RvF03srOLICMe+MQX3BEWByU6m72QtGhF+cCW?=
 =?us-ascii?Q?0DLAHP7tsEGlXCp/tMAJyFeadUthekpu5BniBmd+cgAR8cIQQG2bMYhR7rFR?=
 =?us-ascii?Q?jfv5MgPbkwul3rvn8cvXxgf3MqvuELWJBUnTQjnb8kUe21HYU6pvkW/agy/d?=
 =?us-ascii?Q?Y72hugfXbz5wwYQm2OW9zEQ+tHnuJPk3RQG/dLRJg7Qjnq9N4o5LktFunOr2?=
 =?us-ascii?Q?m04DKf23TPW0ZFtV1CniL0g0KkT4XtkP6kkGpWXRRU1e72kmqoarJmQaqcDE?=
 =?us-ascii?Q?ISbrjO6V0xZj9/C5yaoV/2IhHzJnnQIVB5+P/QGgfzhxEK9+IafdWFHPC5qO?=
 =?us-ascii?Q?EnXcWGT/H2/kt+DfbM31ZF+ygDXjDbZka9D/Eg8v2+9qiUOaY5naj+/lMEJf?=
 =?us-ascii?Q?30aHWnS4SJq6qi6pC5YPnmACxZ2JBTkDQUX+cL3pySrHrHWt4TZ+Xlh1D3rN?=
 =?us-ascii?Q?xpIljYvBbWPxoum2eNU0FCX4HwRi8Y38i78PgAq8FdKecS/KUtPrYcJ6ojMT?=
 =?us-ascii?Q?SRLEVRFpdra8XS3ZEpDe5cvJWIEjFQOmzJLltRNafz/iY6ICNbStb7VQZjee?=
 =?us-ascii?Q?ydkLwN3g4edTVAp0oY12as3AIEiw5BY+XvtcWwxKQn6JqZab5+8BrIdNvP2M?=
 =?us-ascii?Q?ssbSjQCVdsaqgxis3y4ZojCiPDBh2M3fMr76Q9iDtes2Z8it/d5LkX59Un6N?=
 =?us-ascii?Q?0yIflJKKZrWFWXJFqLuU5+ZPRkz+FiGgbq9l3gCD+Xr1I4m+VtPtwBb32PeB?=
 =?us-ascii?Q?zaQuXLaCAXqinPEzk7Ugblh68tMErszTE32ToqqdE3dHqZlZM/K7JthulzH/?=
 =?us-ascii?Q?1BK4KDMNFVp1PxXy1b1dTyOIhonX62xNbpsPiiusCcv7/nBLn3uRzBj42clI?=
 =?us-ascii?Q?fW3vc4hMtZXPmGlDN96I4/jyjhV/3NzmKzouWGyAry63pNvM0+Sl47ar/Bp/?=
 =?us-ascii?Q?8SF86mvBJW+Wl7+G6nsJQZUaFVgqlAeGeQpLssXOTcGRME5S5MaUSqfdZwLX?=
 =?us-ascii?Q?lxMsNXjkFu3W7K9zeY8m+D/MGeGR2emeucwiHtV+VNAV0NELKVSxqQ/UyU0V?=
 =?us-ascii?Q?4HJ5FnQvWkoFuVqNDRmMbzOwYH27Yp83o9E9ojh5AG/KJraFY3WaAd0l78UR?=
 =?us-ascii?Q?taXvDmIXrQjuvReXTxsmQHnWzrEGOaF8hoN9EPD4R6QCuREMYqrfdtSb2fce?=
 =?us-ascii?Q?e7y0yacVxR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNb1rZOb61mjT6CXcRcpM0S2+4TgXOuMEzVAeZVUJQSt+to12Qdbk3ddx9xx?=
 =?us-ascii?Q?n/UGW3K52W9BBuVvWFLgw9wQwpv+EVps/w67kkirJhNQXOFlp6X/w0Xx2mJX?=
 =?us-ascii?Q?a1NbP0NwI8wTQhRvwMGHDxoLM5UKkB+NBh9k5lVP3TJA80A6awaONZbOCVBR?=
 =?us-ascii?Q?ZKozq3XohwqRuP+xWgl+ouIOqICT5V7B4D+xix4xGuIv7YbJIx/uWsKJaQnz?=
 =?us-ascii?Q?nEB4C+PFDo4W577bQZBMmTUGCpxX3vGxYJGnn6c1Gx50xvYpJF7oGlmnj0fH?=
 =?us-ascii?Q?mcZQhKP+7mmLHLINgfBpIwdYi2g3I1tVfpRQ+rrrMdQIdbHaPBkUM0lMUI6S?=
 =?us-ascii?Q?LUOH+uv+a5VLAJV9Prf6WM7cJ3vy2erfvctNPMJth9KsQCeSlzgKZUVeEnoQ?=
 =?us-ascii?Q?3Dpg6pp7WJyzv6tf5b6nc4CZDagL5u0zYac9ZIK1x93S7agV8U535VxYF/65?=
 =?us-ascii?Q?+KVq25Lkn8WPW0kYK3PeeXsKjbkHXobqAHvQ5U6d9e2g4VxlvjlQ4tMM3Sep?=
 =?us-ascii?Q?X6QdJj+7RyO2qjBFAAMhSYuCWRAyFb9y9xqAZ5ug5bChQKpJP9rcRgklevhk?=
 =?us-ascii?Q?6C2gYRFDAm+zYNTS+KlASt/veIHlQloUt+at9GIBj8jHzSKGsVepU4KLDkDG?=
 =?us-ascii?Q?W+GX5IX9ENj995oNRiL/OrKiosF+k2xEjn16CboSUSEcwwKGzDAK1C/xxBjx?=
 =?us-ascii?Q?T0bl6pYBXbzEKqaXdfggiipTKZkYWm3GTOdl/8itJMKW4R464LDdkJcgSB1m?=
 =?us-ascii?Q?5dLK077wKNZD6P6KLFv5H9czLKLgb7gCmgSK/EWErx/aBZoYJk3oZR1mVxM/?=
 =?us-ascii?Q?buf5X/sx1Pru5X09xolehg41khdNmE7HWIfYPglj/JkydUq/ZXNowiYqlK+l?=
 =?us-ascii?Q?tpL910eYlbcj+Xv063EgrooU7F8kKs7lhEU8XzQyV4bYJzc/A0r+kFE82lfr?=
 =?us-ascii?Q?fGhkjeZfUJnWnaBxoWn8LO8CB0eD02LT1bAow8s7Oduht754oQAHPB/XT/bZ?=
 =?us-ascii?Q?XGpMPdVq0CMNG786NiQ/zyoGeo0RGJ1a0EiSRQciKGPDSKG65iV25nFtnVAk?=
 =?us-ascii?Q?R2JNxGp4fyFpqePvruMvGSV6LHHGvd8AtZ5CvzBJRscE7oRraORk/xpo0OFz?=
 =?us-ascii?Q?YSYRFLJVe/e/H4N0UCHgU+lFQT9o7fOdqJ9R1eS8FpTvaTmlNka5WnCsn+Nc?=
 =?us-ascii?Q?gYl/J87aZO3Q80G8CqJ2AVHkdwodpxcB08XBwfQAAXvDnkLbb3LvPnNHpIIo?=
 =?us-ascii?Q?y0a2AGFv5qB2ZfUkU0+picOlratnvNFs9nfoVFrA50l4e7xZ+exb3ZgPL/4e?=
 =?us-ascii?Q?6jn4m4g90zuPHPu1PSoIvRa3WqfNafS1E3FRi5VuHt3CHrrBIKcAfIkz8bTn?=
 =?us-ascii?Q?O6xf2f0L7THgHX+rQDwy3k+GhbeTZDGsIW4l2nKwP6qFUQU6tp7JAcel4U3J?=
 =?us-ascii?Q?Hi39PTqQyHCTZ8eCvj7zy8DCmjkxjtTwAP7SuoLMABnz0tUXMjMY6W9l3pR5?=
 =?us-ascii?Q?x5KSKlZoqj5Yq34M6FXMrqcStvhDnOpMERtQZjqGtjFAHxdZ064nDUvIrMXB?=
 =?us-ascii?Q?mIAqwcWJNHFM6XZLWI27kC/hOVovwxTSKIQBoJfoEb0YY4a+olpK3o6RmNU5?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f1b9be-f426-4752-21ba-08dd67cecb47
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:46:42.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+Xn/y+5+8WDHD2ihLblUGVRLt7+YZPIiJwY4YylbIWC10x7eI6yLP3OBgOGjd2fjRO/573CcpeNiezSFsmF1IOLIHH4flfNQdAvKnemYHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5014

The device tree subnodes, and hardware, for the eccmgr are
the same for Arria10, Stratix10, and Agilex. Update driver
to allow the subnodes to be allowed for "altr,socfpga-s10-ecc-manager".

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/edac/altera_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f902363..895a5beb700f 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1030,6 +1030,9 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 
 	np = of_find_compatible_node(NULL, NULL,
 				     "altr,socfpga-a10-ecc-manager");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL,
+					     "altr,socfpga-s10-ecc-manager");
 	if (!np) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "ECC Manager not found\n");
 		return -ENODEV;
-- 
2.35.3


