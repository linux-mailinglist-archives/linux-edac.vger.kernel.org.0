Return-Path: <linux-edac+bounces-5233-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5782DC13CE3
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3795C584918
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846530217D;
	Tue, 28 Oct 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YViweNp7"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E66302160;
	Tue, 28 Oct 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643523; cv=fail; b=sZpJBbQKLq1qspFYPB40cU8mp9GRekEIqreXrSEqP4rCN4PHDYEHOxLFKbzcFJET7+MePGF4m0hVS+LJ87FWBRYUZW7hldegSO5hQZ5HtpHqxNqdVrtTt2ZjP0tvB8fx9qwo8JL1Hatp/I58y0ln67JcrMn/qfoGpRO7QgDxBh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643523; c=relaxed/simple;
	bh=n6pUpcev9E6XbhfqT4VB+4ltjNpU5r339EQRYYsliSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jvm3u15C7+8vF/CXfHjkhKRHgaVOXR2o0bCfDbV48hQKbxFitBJZTrwpwDwXQe/adKj6rjwtueUBGplA18/cAHF9cSdVCLvL6HMR70bq0h6R16UtyjIKwCxV0wbK+cc1udMU03izznnvuxheuvmFpQopjoz5Lt3s5NlAM26M5tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YViweNp7; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkL+pGLDuQhb0gbpYaIeHy3gl0AiHfXx9mYCxJr099oMNWfrDrjSemGpdn3or365ltxgE19NOGCyVGa9iYpFr7wJYgZTVK/dkN38agGUj+GmxLwZFWDyd/QyrXfyLjyXBWjjcJW71kZpNdanvYeQmfyApqPuwCW0gMFU8dI2wuZYqiMFolYGlyt9zhSR9OZYLUjXCL4d7DC+kdD03cBjjhr85b1OdSjiiB0Cckg4uaNVRWUHBBvo8V3dUXNGvC2gtIqiGZeLxOV0ufv51AysWlODBiChxrT14ZWAdz8gzSov51TXG2QtCDZLkZ4K/4WQIHFzxWwlSmtOhacW6eMaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HQ4Pn54HbCVbYo9182s8UluEMHDQSQXXCOgwuDZmKg=;
 b=hRbCCgDl0xp26nZ03mlt4vFolzjB2fWuia3I6qTfoy5SLnvGz4wjWGPTyglGxEb+8o7SCjYd4Bg8YQ0BXNpisuQeua97PsTjVHIUTdChJcwkXEiKFfExpjxlbDXKVyzpAzxu+FZ58Ry6pl6A3uB8JU+MHyBTsf/fHm3h2Ms1fe+Y8RltMZMheAhvpebDK1BRCLwRhHaPK+8WAQI6Q6TYBiMZ+fV9WQ81MiNHLwGFrvDs5x817eiAfbNjpXTOSikXZISKEHr1nh44tokJido0Xycm4XWbW3K4ii4eYUpi+RPpCsZKoTP9tWOzr457Zgy1wcbpl5QnjYPwhgljSufs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HQ4Pn54HbCVbYo9182s8UluEMHDQSQXXCOgwuDZmKg=;
 b=YViweNp7aLshvvUw6EFjalasw9Uem7SU66pRI5VOYC2X76xzThJIU0LrH6LKLevV+DPi9U5uEneY4p+np22CgFDGjeqWI/hXK6/q8thIO0kzE6sT6BwrmiCQZH4SjeEozqNBVKGgyh6PoLHRA90ncEIeGhuXf0mfkyCrLQGi+p5A7jSx1pvXGi+lojD1v6rKdQ2Hpzq8L3IHPSSLH7BXcQ988CPDqh9ts6nnBkqIVLdhyDHmtrvfxgmlPz9Jlb/ADOalcgtNjawIB/fDgxPA4gXVedSgMsvnLWRsGd6HwPTKC0Ej0DRBMLAHyvvNcgMcxSrSou4+dSdSkSsP+npT3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:25:19 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:25:19 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	matthew.gerlach@altera.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 4/6] EDAC/altera: Add IO96B ECC support for Agilex5 SoCFPGA
Date: Tue, 28 Oct 2025 17:22:30 +0800
Message-Id: <20251028092232.773991-5-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0010.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::7) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: b18ede79-191a-44c2-8a8e-08de1603e95b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRn4fYfYeBm5FeJpTiyIM5oiVpMKTeoXJbBkePsT1LoMtIFggw/vNqwfhC4O?=
 =?us-ascii?Q?Kz0dmpUXvp2peh+zCHRcWDS3SyR7qZyzSnSin7BNd/SSkPGUzRgqQ5Nk4HqO?=
 =?us-ascii?Q?pof1rW4WFEuHHpfv3kkgeWXxnV0+Hw9fvBATSZlnPYrHE/xfuYUzfjuEy2ZI?=
 =?us-ascii?Q?9DuHzoTuMbR5ZDqo9NyZ1VxpqlbWa0xFCZcXOE+g/sLaXAxGiavjhEhuHwdc?=
 =?us-ascii?Q?Tg9m5HX+6nwZJk73frbJu+huWHoEkh15w29FEtTg1BV2cPLD1DITtWTxbHxC?=
 =?us-ascii?Q?6AS9LTFjmlQS9/g3TI2s0tLeqN072ny8abiMVgvVa8sk8thOPPWJhMrLryOW?=
 =?us-ascii?Q?U995KyQSkljJrOJPv0MM5TVZEBZDaiuzi/SpKp7H6BzW7JZ/Iq4SzPUakXl+?=
 =?us-ascii?Q?YW7D6a6o1kfjOfQLd7/0Nmu2gbS6B58iX6rQ1aVy5IBexMyraYRGgELsuVpy?=
 =?us-ascii?Q?xEFe5c8GZaHEZZc1Fmr39vTzGW3SEvYs+bgQ3Srx+Vf7sVbMjxg3zKGH6flj?=
 =?us-ascii?Q?M/AFOTQ6ZTm+Z+IK1Kr8oyyMdQvwUUqKC4zYejvPUN13xxRtxyJwN8bWDFpO?=
 =?us-ascii?Q?njkOD5QRd7RUNSrFvKDVf0Eh8fKXYb/HD50WuTHWhwdvL0e2VGzkwmpYnsxz?=
 =?us-ascii?Q?Y40G47Wchnm5t1HrikCyG2z2+t9baa3r9A402t9EawV74z3nFBMVeFPhnzAy?=
 =?us-ascii?Q?hNQcFzn8s5DXwuVuErUaHgidsSupaEd/iu4kU+6t1Q7SVOie9LHmVSUYriGa?=
 =?us-ascii?Q?G6tkfkTrhDt8mb7Wc8OfIJRidr7yhLYeZg+2zGfzeC3L1sCemBk3Hg5a38fJ?=
 =?us-ascii?Q?AvbIFHz+eIQNxbOCPxnEM+5f09Cf/YiSa7uqQW2RqokHnvl3eGKx/nZgvvk+?=
 =?us-ascii?Q?7MAm78W22sHVuxPQOCiLHnqP4xby4KOm9z2tIHHxCzaYaroxy3k5zdSRan53?=
 =?us-ascii?Q?zo69xO4FtsADdn0wVUox1vZgwh6xrimdSnUXqSCZRu8OxpgIKvEjtFXLUWbl?=
 =?us-ascii?Q?MSYyXeygY5sSqOUr5XbLKbfK2S9B+6RmC2cIGm4GbiicGvo097Qk7MDPypBf?=
 =?us-ascii?Q?yvC4rrCKblopvJBNVoigUG9IunQWvXGFKYIFPte7RF6XU7lPdxFkd4tyddG6?=
 =?us-ascii?Q?FshysbzSeijI0WvG5//za2Xs7ACJMZ+JEaGPEbigWniTzlFsY2EiIrvgj//o?=
 =?us-ascii?Q?9zzp0QzUbvs8QMbtKTRRVHzXD1rgalcJha9z+1T4l/bQRpsNdfivwYrM7gWi?=
 =?us-ascii?Q?wDvfuf3Xmehw2kcz7C9inno8HqxAhqcGhUWVISSJEh6z6XqQXqnhxDJtsYAr?=
 =?us-ascii?Q?TgKIQ+YZo95x0fHtKD4HVgKOQ4RgUQx7oaV9S/fxkYmKeimJKsyn9YRykoDa?=
 =?us-ascii?Q?T+fH+xt8kizJCgvlEpWe/UUH6kcDufXSbyVn4nflw00qOSWIXj8Nz31fENGG?=
 =?us-ascii?Q?wiJcmr14K7SdT22gW48twrsBa+zkrepc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MF6HE4bh2mP4mGZxOWsihCAcWwvZrARVIV5dZkTlfD3tTk9zntUr2Ee7Mo4q?=
 =?us-ascii?Q?41IR/KU4jKv72tBeaApS6eoC6RN4kgnaYI9HkFWDmbO0JRHyKLzSe6bs3GQ6?=
 =?us-ascii?Q?DW0WzK7aAQTaEV3UPUVz7aBuwNKUMmv0hvB2cvF0HsCvg4pT4yoKyriMcm0K?=
 =?us-ascii?Q?BJU3eNMHwOKmVAvK+Qsj82XM29Vp5z/spr1cZ9GdkF9DVtAJrzp2vA3muYe5?=
 =?us-ascii?Q?R5+wvlMa8mTyn7a/rQgEw0qRg5DMR7kDVje40c8lmfChcUS1YBUY7bO2ZCfU?=
 =?us-ascii?Q?ze9qnTL9yukMzTUsro1A9ZJaMnHQ18GZtYW/dld1uJ5bv3D+FkMBHsftyPy9?=
 =?us-ascii?Q?WWCNLwEhGA+8iUC9aThyvf3GEHk0MY11OvAnpw8llJ6AGBh47DEqcjNc/uxp?=
 =?us-ascii?Q?rAVvE24heqssKPKPeZDskqWiAn5RYY8gu5tJG0abraY9HRTsbyn7KLP9+ehC?=
 =?us-ascii?Q?+QoCSxIIoOpLp1vCu9dM1m75Kvy/dexvjJG5OFVCSieSbpWxdQgPdpwN3Wma?=
 =?us-ascii?Q?Ses6X/3ycNpRC9ySQCSPzbztlz/ikshBZg272pGibnp2R3CchOtl0lqmKcQ0?=
 =?us-ascii?Q?39vYynmKEE7UNddWQd9kBSa3kSj9JlDWGUTQDDdeW0Je0mKUxSwqil5RuAmI?=
 =?us-ascii?Q?vc/+61YNsIPj6go/JmTQYnJ/uMdE0GT1f6CC6P0qNddryGu00mzB6K8jaTCc?=
 =?us-ascii?Q?k17M7z1RPilmU5+yhJuNxwoEs1vrPF4C338X/aOmZ1ulwa4qaWY1lVrdvgKF?=
 =?us-ascii?Q?LEaSjh0iEFdYCroT6nl2Y8Ot7L0i6tYL/5umLl+dazY77Jo4j9hHyFlqkSKU?=
 =?us-ascii?Q?mML0EDYbDX6T5ht/aHI8DhX2Crf4gUOrPDsjSfBQgWEs8NiSDZZ8PN1zANJU?=
 =?us-ascii?Q?goaQ+AMbsobdtAWcSGPjFe6tl6cZzSP0Hjj0EpLX+dUz3xy2tjc1MELC9klv?=
 =?us-ascii?Q?cVae8KMJoUtW3yF5FpK8p3DalS71/Y/pooTLTD4hM8yxyflVNUK5BxwI6tFX?=
 =?us-ascii?Q?oINeY9N7hE/8z6Mm9GxsbC/jDy6vh5IvfsdDI8m7yYcDSGNbJ4kJlTrng8Nk?=
 =?us-ascii?Q?gN6gFo+aKTc2/Q54j4U5MIwWZpL30Tuo6hl7YYEz5XYXHMKAZrx8fheAcUR1?=
 =?us-ascii?Q?Pg35gy3uqET23FXjPm6v0oJ6bsNqNEi+Pb1P4EPCVy2ROobxG8XUKSFSwToQ?=
 =?us-ascii?Q?blQ3D9sxd1cY4oF0E4qaACjwcfzcZIrZ7cXlRo7GQoCfDBfPL3MOI5Twnfqo?=
 =?us-ascii?Q?R8v1LE/V9y0J8krdD6kR8CX0UrF93gxrPsGv+ze7U12nR6jTDd6RGoWmQHr4?=
 =?us-ascii?Q?OWGEEM2s+aCEOESZ1jq1gOug/IV2u5UEXp4L4RSU68u1qNr4QStH44HLHXrQ?=
 =?us-ascii?Q?FDbu3zVpreeWt8eCZUBRTQrVAyXfE+E3TWg7QxSGAcwk4Q2r3mE0xoh+AI1f?=
 =?us-ascii?Q?qVBJVdHTANreuSUAYZPffLpRYM9RBHXMXBqmDHLcOh4UXkyQZGEN4BVyYAL7?=
 =?us-ascii?Q?PMV9781ULuIIJzbWyJwjLDFkL/VLvl4+rG1iPME/3eQMXqxxQYMBtLZUAsGg?=
 =?us-ascii?Q?qWm4BOtPkbGUTHDssxWsAGtHoTUZ7+sE1G/xinGPUgXfSnahCKNgKpUyLD4m?=
 =?us-ascii?Q?qrPSb7MoDkhDOKKWHMNVNXVknXWOPHvw0YwnOaykg7p/?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18ede79-191a-44c2-8a8e-08de1603e95b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:25:19.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNX8bwUxGWwywlZCrQSHVVDte/mkYypGm2tztKonEnmQKE8WMFG9zwMsP0AQpFvVNuXZGpeFPZBdDIkOt7VLT3veJlZphcE+0JaNZzLLhAyKsDAd/BpCAPqdvVwwCRsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add EDAC driver support for the two IO96B memory controllers present in
Agilex5 SoCFPGA.

The IO96B controller provides dedicated mailbox registers for status
and control. ECC error injection is handled via Secure Monitor Calls (SMC).

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 drivers/edac/Kconfig                         |  10 +
 drivers/edac/altera_edac.c                   | 305 ++++++++++++++++---
 drivers/edac/altera_edac.h                   |  42 +++
 include/linux/firmware/intel/stratix10-smc.h |  18 ++
 4 files changed, 326 insertions(+), 49 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 39352b9b7a7e..33a9fccde2fe 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -410,6 +410,16 @@ config EDAC_ALTERA_SDRAM
 	  preloader must initialize the SDRAM before loading
 	  the kernel.
 
+config EDAC_ALTERA_IO96B
+	bool "Altera I096B ECC"
+	depends on EDAC_ALTERA=y && ARM64
+	help
+	  Support for SERR and DERR detection and correction on the
+	  IO96B memory controller interface for Altera SoCFPGA.
+
+	  I096B memory controller provides dedicated mailbox registers
+	  for error injection and error information.
+
 config EDAC_ALTERA_L2C
 	bool "Altera L2 Cache ECC"
 	depends on EDAC_ALTERA=y && CACHE_L2X0
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index ee3270bf75e6..a82c3b01be1a 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -656,6 +656,19 @@ static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unu
 	.llseek = generic_file_llseek,
 };
 
+#ifdef CONFIG_EDAC_ALTERA_IO96B
+static ssize_t __maybe_unused
+altr_edac_io96b_device_trig(struct file *file, const char __user *user_buf,
+			    size_t count, loff_t *ppos);
+
+static const struct file_operations
+altr_edac_io96b_inject_fops __maybe_unused = {
+	.open = simple_open,
+	.write = altr_edac_io96b_device_trig,
+	.llseek = generic_file_llseek,
+};
+#endif
+
 static ssize_t __maybe_unused
 altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos);
@@ -1121,6 +1134,33 @@ static const struct edac_device_prv_data s10_sdramecc_data = {
 };
 #endif /* CONFIG_EDAC_ALTERA_SDRAM */
 
+/************************IO96B EDAC *************************************/
+
+#ifdef CONFIG_EDAC_ALTERA_IO96B
+static DEFINE_MUTEX(io96b_mb_mutex);
+
+static int altr_agilex5_io96b_ecc_init(struct altr_edac_device_dev *device)
+{
+	u32 ecc_status;
+
+	ecc_status = readl(device->base + IO96B_ECC_ENABLE_INFO_OFST);
+	ecc_status &= GENMASK(1, 0);
+
+	if (!ecc_status) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s: No ECC present or ECC disabled.\n",
+			    device->edac_dev_name);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static const struct edac_device_prv_data agilex5_io96b_data = {
+	.setup = altr_agilex5_io96b_ecc_init,
+	.inject_fops = &altr_edac_io96b_inject_fops,
+};
+#endif /* CONFIG_EDAC_ALTERA_IO96B */
+
 /*********************** OCRAM EDAC Device Functions *********************/
 
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
@@ -1717,11 +1757,62 @@ static const struct of_device_id altr_edac_a10_device_of_match[] = {
 #endif
 #ifdef CONFIG_EDAC_ALTERA_SDRAM
 	{ .compatible = "altr,sdram-edac-s10", .data = &s10_sdramecc_data },
+#endif
+#ifdef CONFIG_EDAC_ALTERA_IO96B
+	{ .compatible = "altr,socfpga-io96b0-ecc", .data = &agilex5_io96b_data },
+	{ .compatible = "altr,socfpga-io96b1-ecc", .data = &agilex5_io96b_data },
 #endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
 
+/*
+ * The IO96B EDAC Device Functions differ from the rest of the
+ * ECC peripherals.
+ */
+
+#ifdef CONFIG_EDAC_ALTERA_IO96B
+static ssize_t __maybe_unused
+altr_edac_io96b_device_trig(struct file *file, const char __user *user_buf,
+			    size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
+	u8 trig_type;
+	u32 val;
+	struct arm_smccc_res result;
+
+	if (!user_buf || get_user(trig_type, user_buf))
+		return -EFAULT;
+
+	mutex_lock(&io96b_mb_mutex);
+	if (readl(drvdata->base + IO96B_CMD_RESP_STATUS_OFST))
+		writel(0, drvdata->base + IO96B_CMD_RESP_STATUS_OFST);
+
+	arm_smccc_smc(INTEL_SIP_SMC_IO96B_INJECT_ECC_ERR,
+		      (trig_type == ALTR_UE_TRIGGER_CHAR) ?
+		      IO96B_DBE_SYNDROME : IO96B_SBE_SYNDROME,
+		      IO96B_CMD_TRIG_ECC_ENJECT_OP, 0, 0, 0, 0, 0, &result);
+
+	writel(IO06B_ECC_SCRUB_INTERVAL, drvdata->base + IO96B_CMD_PARAM_0_OFST);
+	writel(IO06B_ECC_SCRUB_LEN, drvdata->base + IO96B_CMD_PARAM_1_OFST);
+	writel(IO06B_ECC_SCRUB_FULL_MEM, drvdata->base + IO96B_CMD_PARAM_2_OFST);
+	writel(IO96B_CMD_ECC_SCRUB_MODE_0, drvdata->base + IO96B_CMD_REQ_OFST);
+
+	if (readl_relaxed_poll_timeout(drvdata->base + IO96B_ECC_SCRUB_STAT0_OFST,
+				       val, !(val & IO96B_ECC_SCRUB_COMPLETE),
+				       IO96B_ECC_SCRUB_POLL_US,
+				       IO96B_ECC_SCRUB_TIMEOUT))
+		edac_printk(KERN_ALERT, EDAC_DEVICE,
+			    "IO96B ECC Scrubing timeout - Try again.\n");
+
+	writel(0, drvdata->base + IO96B_CMD_RESP_STATUS_OFST);
+	mutex_unlock(&io96b_mb_mutex);
+
+	return count;
+}
+#endif
+
 /*
  * The Arria10 EDAC Device Functions differ from the Cyclone5/Arria5
  * because 2 IRQs are shared among the all ECC peripherals. The ECC
@@ -1819,6 +1910,70 @@ altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 	return count;
 }
 
+static irqreturn_t io96b_irq_handler(int irq, void *dev_id)
+{
+	struct altr_edac_device_dev *dci = dev_id;
+	u32 err_word0;
+	u32 err_word1;
+	u32 cnt = 0;
+	u32 ecc_error_status;
+	u16 err_queue_overflow;
+	u16 err_count = 0;
+	bool dbe = false;
+	enum io96b_error_type error_type;
+	u32 err_queue = IO96B_ECC_ERR_ENTRIES_OFST;
+
+	ecc_error_status = readl(dci->base + IO96B_ECC_ERR_REG_OFST);
+	err_queue_overflow = ecc_error_status & GENMASK(31, 16);
+	err_count = ecc_error_status & GENMASK(15, 0);
+
+	if (!err_queue_overflow) {
+		while (cnt < err_count) {
+			err_word0 = readl(dci->base + err_queue);
+			err_word1 = readl(dci->base + (err_queue + 4));
+
+			error_type = (err_word0 & GENMASK(9, 6)) >> 6;
+			if (error_type == ECC_SINGLE_DBE || error_type == ECC_MULTI_DBE ||
+			    error_type == ECC_WRITE_LINK_DBE ||
+			    error_type == ECC_READ_LINK_DBE ||
+			    error_type == ECC_READ_LINK_RMW_DBE) {
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+					    "%s: DBE: word0:0x%08X, word1:0x%08X\n",
+					    dci->edac_dev_name, err_word0, err_word1);
+				dbe = true;
+			} else {
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+					    "%s: SBE: word0:0x%08X, word1:0x%08X\n",
+					    dci->edac_dev_name, err_word0, err_word1);
+				edac_device_handle_ce(dci->edac_dev, 0, 0,
+						      dci->edac_dev_name);
+			}
+			cnt++;
+			err_queue += 8;
+		}
+		if (dbe)
+			panic("\nEDAC:IO96B[Uncorrectable errors]\n");
+	} else {
+		err_queue_overflow = (err_word0 & GENMASK(9, 6)) >> 6;
+		if (error_type == ECC_SINGLE_DBE || error_type == ECC_MULTI_DBE ||
+		    error_type == ECC_WRITE_LINK_DBE ||
+		    error_type == ECC_READ_LINK_DBE ||
+		    error_type == ECC_READ_LINK_RMW_DBE) {
+			panic("\nEDAC: UE: %s: word0:0x%08X, word1:0x%08X\n",
+			      dci->edac_dev_name, err_word0, err_word1);
+		} else {
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "%s: Buffer Overflow SBE:0x%08X\n",
+				    dci->edac_dev_name, err_queue_overflow);
+			edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		}
+	}
+
+	//Clear Queue
+	writel(IO96B_ECC_ERROR_QUEUE_CLEAR, dci->base + IO96B_CMD_REQ_OFST);
+	return IRQ_HANDLED;
+}
+
 static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 {
 	int dberr, bit, sm_offset, irq_status;
@@ -1885,6 +2040,8 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	struct resource res;
 	int edac_idx;
 	int rc = 0;
+	bool io96b0_ecc = false;
+	bool io96b1_ecc = false;
 	const struct edac_device_prv_data *prv;
 	/* Get matching node and check for valid result */
 	const struct of_device_id *pdev_id =
@@ -1902,11 +2059,15 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 
 	if (!devres_open_group(edac->dev, altr_edac_a10_device_add, GFP_KERNEL))
 		return -ENOMEM;
-
-	if (of_device_is_compatible(np, "altr,sdram-edac-s10"))
+	if (of_device_is_compatible(np, "altr,socfpga-io96b0-ecc")) {
+		io96b0_ecc = true;
+	} else if (of_device_is_compatible(np, "altr,socfpga-io96b1-ecc")) {
+		io96b1_ecc = true;
+	} else if (of_device_is_compatible(np, "altr,sdram-edac-s10")) {
 		rc = get_s10_sdram_edac_resource(np, &res);
-	else
+	} else {
 		rc = of_address_to_resource(np, 0, &res);
+	}
 
 	if (rc < 0) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -1938,10 +2099,22 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	dci->mod_name = ecc_name;
 	dci->dev_name = ecc_name;
 
-	altdev->base = devm_ioremap_resource(edac->dev, &res);
-	if (IS_ERR(altdev->base)) {
-		rc = PTR_ERR(altdev->base);
-		goto err_release_group1;
+	if (io96b0_ecc || io96b1_ecc) {
+		rc = of_address_to_resource(np, 0, &res);
+		if (rc)
+			goto err_release_group1;
+
+		altdev->base = ioremap(res.start, resource_size(&res));
+		if (IS_ERR(altdev->base)) {
+			rc = PTR_ERR(altdev->base);
+			goto err_release_group1;
+		}
+	} else {
+		altdev->base = devm_ioremap_resource(edac->dev, &res);
+		if (IS_ERR(altdev->base)) {
+			rc = PTR_ERR(altdev->base);
+			goto err_release_group1;
+		}
 	}
 
 	/* Check specific dependencies for the module */
@@ -1951,26 +2124,70 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 			goto err_release_group1;
 	}
 
-	altdev->sb_irq = irq_of_parse_and_map(np, 0);
-	if (!altdev->sb_irq) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating SBIRQ\n");
-		rc = -ENODEV;
-		goto err_release_group1;
-	}
-	rc = devm_request_irq(edac->dev, altdev->sb_irq, prv->ecc_irq_handler,
-			      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-			      ecc_name, altdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "No SBERR IRQ resource\n");
-		goto err_release_group1;
-	}
+	if (io96b0_ecc) {
+		altdev->io96b0_irq = altdev->edac->io96b0_irq;
+		rc = devm_request_threaded_irq(edac->dev, altdev->io96b0_irq, NULL,
+					       io96b_irq_handler, IRQF_ONESHOT,
+					       ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No IO96B0 IRQ resource\n");
+			goto err_release_group1;
+		}
+	} else if (io96b1_ecc) {
+		altdev->io96b1_irq = altdev->edac->io96b1_irq;
+		rc = devm_request_threaded_irq(edac->dev, altdev->io96b1_irq, NULL,
+					       io96b_irq_handler, IRQF_ONESHOT,
+					       ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No IO96B1 IRQ resource\n");
+			goto err_release_group1;
+		}
+	} else {
+		altdev->sb_irq = irq_of_parse_and_map(np, 0);
+		if (!altdev->sb_irq) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating SBIRQ\n");
+			rc = -ENODEV;
+			goto err_release_group1;
+		}
+		rc = devm_request_irq(edac->dev, altdev->sb_irq, prv->ecc_irq_handler,
+				      IRQF_ONESHOT | IRQF_TRIGGER_HIGH, ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No SBERR IRQ resource\n");
+			goto err_release_group1;
+		}
 
 #ifdef CONFIG_64BIT
-	if (of_machine_is_compatible("intel,socfpga-agilex5")) {
+		if (of_machine_is_compatible("intel,socfpga-agilex5")) {
+			altdev->db_irq = irq_of_parse_and_map(np, 1);
+			if (!altdev->db_irq) {
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+					    "Error allocating DBIRQ\n");
+				rc = -ENODEV;
+				goto err_release_group1;
+			}
+			rc = devm_request_irq(edac->dev, altdev->db_irq,
+					      prv->ecc_irq_handler,
+					      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					      ecc_name, altdev);
+			if (rc) {
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+					    "No DBERR IRQ resource\n");
+				goto err_release_group1;
+			}
+		} else {
+			/* Use IRQ to determine SError origin instead of assigning IRQ */
+			rc = of_property_read_u32_index(np, "interrupts", 0,
+							&altdev->db_irq);
+			if (rc) {
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+					    "Unable to parse DB IRQ index\n");
+				goto err_release_group1;
+			}
+		}
+#else
 		altdev->db_irq = irq_of_parse_and_map(np, 1);
 		if (!altdev->db_irq) {
-			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "Error allocating DBIRQ\n");
+			edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating DBIRQ\n");
 			rc = -ENODEV;
 			goto err_release_group1;
 		}
@@ -1979,35 +2196,11 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 				      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
 				      ecc_name, altdev);
 		if (rc) {
-			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "No DBERR IRQ resource\n");
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
 			goto err_release_group1;
 		}
-	} else {
-		/* Use IRQ to determine SError origin instead of assigning IRQ */
-		rc = of_property_read_u32_index(np, "interrupts", 0,
-						&altdev->db_irq);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "Unable to parse DB IRQ index\n");
-			goto err_release_group1;
-		}
-	}
-#else
-	altdev->db_irq = irq_of_parse_and_map(np, 1);
-	if (!altdev->db_irq) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating DBIRQ\n");
-		rc = -ENODEV;
-		goto err_release_group1;
-	}
-	rc = devm_request_irq(edac->dev, altdev->db_irq, prv->ecc_irq_handler,
-			      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-			      ecc_name, altdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
-		goto err_release_group1;
-	}
 #endif
+	}
 
 	rc = edac_device_add_device(dci);
 	if (rc) {
@@ -2198,7 +2391,21 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 			regmap_write(edac->ecc_mgr_map,
 				     S10_SYSMGR_UE_ADDR_OFST, 0);
 		}
+
+#ifdef CONFIG_EDAC_ALTERA_IO96B
+		edac->io96b0_irq = platform_get_irq_byname(pdev, "io96b0");
+		if (edac->io96b0_irq < 0) {
+			dev_err(&pdev->dev, "No io96b0 IRQ resource\n");
+			return edac->io96b0_irq;
+		}
+		edac->io96b1_irq = platform_get_irq_byname(pdev, "io96b1");
+		if (edac->io96b1_irq < 0) {
+			dev_err(&pdev->dev, "No io96b1 IRQ resource\n");
+			return edac->io96b1_irq;
+		}
+#endif
 	}
+
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
 	if (edac->db_irq < 0)
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 7248d24c4908..a2c8b80eefa8 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -352,6 +352,44 @@ struct altr_sdram_mc_data {
 #define ECC_READ_EOVR                     0x2
 #define ECC_READ_EDOVR                    0x3
 
+/************ IO96B ECC defines *******/
+#define IO96B_ECC_ENABLE_INFO_OFST		0x240
+#define IO96B_ECC_SCRUB_STAT0_OFST		0x244
+#define IO96B_ECC_ERR_REG_OFST			0x300
+#define IO96B_ECC_ERR_ENTRIES_OFST		0x310
+
+#define IO96B_CMD_RESP_STATUS_OFST		0x45C
+#define IO96B_CMD_RESP_DATA_0_OFST		0x458
+#define IO96B_CMD_RESP_DATA_1_OFST		0x454
+#define IO96B_CMD_RESP_DATA_2_OFST		0x450
+#define IO96B_CMD_REQ_OFST			0x43C
+#define IO96B_CMD_PARAM_0_OFST			0x438
+#define IO96B_CMD_PARAM_1_OFST			0x434
+#define IO96B_CMD_PARAM_2_OFST			0x430
+
+#define IO96B_CMD_TRIG_ECC_ENJECT_OP		0x20040109
+#define IO96B_CMD_ECC_SCRUB_MODE_0		0x20040202
+#define IO96B_ECC_ERROR_QUEUE_CLEAR		0x20040110
+
+#define IO06B_ECC_SCRUB_INTERVAL		0x14
+#define IO06B_ECC_SCRUB_LEN			0x100
+#define IO06B_ECC_SCRUB_FULL_MEM		0x1
+
+#define IO96B_SBE_SYNDROME			0xF4
+#define IO96B_DBE_SYNDROME			0xFF
+
+#define IO96B_ECC_SCRUB_TIMEOUT		400000
+#define IO96B_ECC_SCRUB_POLL_US		500
+#define IO96B_ECC_SCRUB_COMPLETE		BIT(1)
+
+enum io96b_error_type {
+	ECC_SINGLE_DBE = 2,
+	ECC_MULTI_DBE = 3,
+	ECC_WRITE_LINK_DBE = 0xa,
+	ECC_READ_LINK_DBE = 0xc,
+	ECC_READ_LINK_RMW_DBE
+};
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
@@ -384,6 +422,8 @@ struct altr_edac_device_dev {
 	struct edac_device_ctl_info *edac_dev;
 	struct device ddev;
 	int edac_idx;
+	int io96b0_irq;
+	int io96b1_irq;
 };
 
 struct altr_arria10_edac {
@@ -395,6 +435,8 @@ struct altr_arria10_edac {
 	struct irq_chip		irq_chip;
 	struct list_head	a10_ecc_devices;
 	struct notifier_block	panic_notifier;
+	int io96b0_irq;
+	int io96b1_irq;
 };
 
 #endif	/* #ifndef _ALTERA_EDAC_H */
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ee80ca4bb0d0..283597022e61 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -620,4 +620,22 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_IO96B_INJECT_ECC_ERR
+ * Sync call to inject IO96B ECC Error.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FUNCID_IO96B_INJECT_ECC_ERR
+ * a1 IO96B error syndrome
+ * a2 I096B mailbox command
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1-a3 Not used
+ */
+#define INTEL_SIP_SMC_FUNCID_IO96B_INJECT_ECC_ERR 156
+#define INTEL_SIP_SMC_IO96B_INJECT_ECC_ERR \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_IO96B_INJECT_ECC_ERR)
+
 #endif
-- 
2.25.1


