Return-Path: <linux-edac+bounces-5235-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCCC13CFA
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 366255646A4
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0830215E;
	Tue, 28 Oct 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Qc7bFnS1"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746C2FFDC0;
	Tue, 28 Oct 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643539; cv=fail; b=U9W5RuRFmPbFcAw12Hth1FP6MnsbXok9hcZjtQPUu0usFX/FUDiPodSnJCX0jAnpJOmTJuYlFu5qJ4WLBvedsaq55m+7SIib8ywY/hXNTgd8gwkdEGZEQ9HSXxAFNKdcc/LREddSQZO3JfD8sxLahbbNup8Eyt57AjVbyJ35W3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643539; c=relaxed/simple;
	bh=pqmbI8Gs2B7ObECuUh0/T/VyHj4zhXWsC0VcREwfQZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqnBiWL6zPvZD60dgep1I6gz58DZo6YAZg1p+T6yz/4Af++yqPqwrw0EkTx2/MXhCi6ymR8UB2wVXToc92kFXBx6eHATCtWd2DiH6ht41ZR5Swg296kkNvEFhUiCTq+xpaAdDsUq+JmxaSu/wtZkXFM4amM0WUApDPtEcZXtgjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Qc7bFnS1; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irSkJCkHF8QHhdc7MIJXk9FX65otbZRq3o7N78dy8r20qB0En7Ze6G1ecjZleiY7IhbmYf3lN2qgUkM3eeA8vhUahWSpa5A2tVZydSst4tC2sPPZ0+SdHhKWSqX1iRVY74Oxr5RCmhBI3IT5yDU0dcVVCGrITfJA76jHeO+jfwvYv8LW/q2x0W7RAq7N3yGxK7waGGdQpIX4VyjRnBxerwz5h/7d6YlRYT5vB/IxstKRJ6wEUFU97CoHuVkVavU8Dn0zuVomHRjI+AiiGBsNbGHx1x4gxBPrVd+8kqXEP7hLJ9J8eI07GicJU0ItzDKMxyyvaVxj6AQuPzdJB91wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDGb8yfMg1ELX3zWo4Lf0h5HBsvB+4Faufk7QCi4cGM=;
 b=BIJzaWUAaNO1fxL76iFaeu9+/eu6CtPtlkilNpaBtSfLReAIL+hRDsKry2pgKsO8tx0AnCpI/WvOY2I5Mfy53i83LcTxifx++2/GRZQXfoE5CS8EeF+xEUUvdyJOd6zg4xJfPHvejHsdxNZLZ38o6LcAnvuikb9j5Ys9ROUqLTypMNVNt1WKyIH1oofw1h/c8JyaRAgN57iMM8NtAkcZguyykYSAc0XtXzOCQGdYQArJrSYZZ/JtUk1GoUp4RWvo2aTTctQUbZ2N90NvOGOcnXMrejZvocdDzBdhIh7RW9R/sW9tGQlhhYUEy5LbKwk+S9S9PbnZ1/1xyNN/KTiHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDGb8yfMg1ELX3zWo4Lf0h5HBsvB+4Faufk7QCi4cGM=;
 b=Qc7bFnS1yDeCPlxdOMxmIoQ44ET6VU7ExR8cDobhG0DaqTNM81PRSsAF2gCUYtKInRQofAz9XHj8HUXt+vwML4hu/1EV1nTmYrXkx3pbizvT46US+RqZV3vrqkBlUx9kOEPX6l4jBUB+97RHrd4GcU3+JIDV9eoIv5rFjf0V86TW/0xhTplhtiLKvJy0J+TMnanKqec/OhAN0r19FFfOYBAqKKjtNVVfDRt/cF64sCBm87H7qzB3RUc8cH1AvdVhAjA1b1Ki9CxAk+YLa54LP46ZNOfQ7jmv+7ob8Ub2NYqRbWcgFgxgBUJyLKZEucn54m5HoUFl/KhkzQ5fzDzK9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:25:31 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:25:31 +0000
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
Subject: [PATCH 6/6] EDAC: altera: Add ECC support for SDM QSPI on Agilex5
Date: Tue, 28 Oct 2025 17:22:32 +0800
Message-Id: <20251028092232.773991-7-niravkumarlaxmidas.rabara@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d27f270-8466-4f7a-ff24-08de1603f0ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9S1fcO2SN1DBjbS5uCkwxmU0N/RN5PEX04rxIHmnz32fLa8EUm8lL4oEy8x?=
 =?us-ascii?Q?2cFddQTe+nx59d07dEg+bUSOtantsapEBbDd6QVJzl9Rsxk4B00P7bSdgzgB?=
 =?us-ascii?Q?kiQ9Zf9PCH7U7sK1se7vw2gSN62hl2zbUyyp/v6+iJ5b/TERjZv9qvLqBRk9?=
 =?us-ascii?Q?f96GFvhtqHBMsZPgCbmoISrL21Chj1kgkNqfGTQ1XRcTcofheWRynhKaR3DL?=
 =?us-ascii?Q?Z+90HUDZD9q95AF0P9iadj0Mm3Frit8TqRFM6iC+mfDZXtTy4s2xk5ftPYKA?=
 =?us-ascii?Q?gn9uuiRrXCrQCQu2rJHDMdFK9XUTHbCoLBNmhAvm8R3GSyhC3SgbXqHVsHhP?=
 =?us-ascii?Q?ZUOoJV5FyrYn4OgJDKKCQ9FfG4kx+0nE+OMGX0PWjKHyPmSLU2FYJhO6kVLa?=
 =?us-ascii?Q?nl4mixRr8/0J9CyCOhgKPaZiBxKyAOhei3V5HGB+PPvCjMTQuw6JrXdp2dRh?=
 =?us-ascii?Q?rfW+m0e8hp5zEHB/i2EFNZbEXTR0uofOT1Vn+NtfTpMlqMtJuxEQoXd024w+?=
 =?us-ascii?Q?KbIegTzOSl5MhabXWGq7F/IJw8KowjZB9i3wiEW8Cw9wI+cUP0XgEChQr7PU?=
 =?us-ascii?Q?niUGvdL2GCb7g9csjHdXdr7swE2Le4T8I4D4d7J3EEEo0slnFVFTlBnOsj5j?=
 =?us-ascii?Q?t1eg1FhlklzcE2SBwas/QoSyDbB09Q56m3hGZwOK255q2ihcEX10qnNr/fRW?=
 =?us-ascii?Q?f1L3DKFe1RsnQHmgkc4vZPV+X3dUw8dWvz3L7+O1v4F3/QShn2Uv7TwZ/dfJ?=
 =?us-ascii?Q?T1hXrYlQi4O+gCIEjy8JH6e0XZlOfaeVwmOl9L2AyH3Igc4Cv99051BUTXh/?=
 =?us-ascii?Q?yhj97yC7jxRkXJ53L99DprrtcaBhUrGGM9OqSw9tb+o0o9nMmktdISzodpoE?=
 =?us-ascii?Q?YyUb5RR5tiOPIVqvTNShfYAzsZfgrq4QJukIfssgfJYK37Vm3k565hyHYitK?=
 =?us-ascii?Q?5fLtvEFR5sL4cYb1Hw94PA739/iVaZHzCZgP7XkFxFBuXAZXYqYn/q4EL0Ir?=
 =?us-ascii?Q?pAjGl2c0pftDvclwdetLX0OZQYBzXfTBoiJVLeHbM4JCU4Uz2tRAsittPvrS?=
 =?us-ascii?Q?PkSCi4YavlR5nlJyPTVGEzjXGDcDxcnSQXnt3AjZTKtdxA9+E4K+ECnJOBRf?=
 =?us-ascii?Q?l3jcKvahhD3H0YeYMO0QEL3LZmrVtiIcptwjibStGRIzRqiNIWTAVorQhNHe?=
 =?us-ascii?Q?usmbY+6ugEbJjsiXAZ0wDtExDvoWNKm4yUNIbczRuYTtgmtveP0TH3Q6Jrq/?=
 =?us-ascii?Q?38zJO222Qxo/0hOIqa7W3LonkFypmTwpjIJnNlTHCoXvK9ZgwHCmH/CZt/8j?=
 =?us-ascii?Q?RmyymFcyXwQihMFvmw/qjEpKB+2L/OyYK90SFsc86A5vU0sY2cYCDOj/S0eE?=
 =?us-ascii?Q?pxztMTBSEkPmWbvVZDxNBwvZpfvdKfnG6JnjugROSej5gwMuZIvzOSq3TYIq?=
 =?us-ascii?Q?GVXsk1kdgWwD7CiAt8z479CONRPUFctp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2DWldC1BUkojeoOZJ0iHz3v33Rn3QUOqqevmHG4/mOlE9kwJHcDcyOSRk/W?=
 =?us-ascii?Q?IQfu7fI/zYAh47roanqbxQf+4s3I0otBU7RUYpNk8g7yYTIDmX+iYRl82sGb?=
 =?us-ascii?Q?UkqOpKVAWrtA0i+CBdptOAVUTMq/oh7gLks+ox9NIR+u99HI0MoMnzO9cuEP?=
 =?us-ascii?Q?7lLyRvSmrCzjc4IpKmvOvnz1UeZH4KW+nN1fV2o/furevn3rZ2g3Xe80kzM1?=
 =?us-ascii?Q?Ubc0rOnIBuoMZdaWfG3Y6wRd/0OSbbmEFr/U0cTOQcFaUG6TXnVGyAwRX+U3?=
 =?us-ascii?Q?e8xgb34BtFI0iZ5H0e5CVf1aOC8oIbiE5Isvl8yccQovOglyQ7dnXKn11niL?=
 =?us-ascii?Q?2crf3aqQtu7WOOfCOv5a/NPrecaXPqvT/SRetlxaM//oK9G9Bm1QVuq7zttL?=
 =?us-ascii?Q?jc2FPAW3s88E0xdVUZi4bGU/ti4El4dnlyiLvn1HgR6GptncW3uiMJd8Ib+H?=
 =?us-ascii?Q?dVCVefM8nnPp+6vhK5Y8CbDeekCMORxs0fumAHnRRK33Emgu/LBq4br7Wald?=
 =?us-ascii?Q?qwzv2DL6WgznWW06B0QZ5oyNse86JrBOrRDmdQm7mgjCrmv+bsrIoEi/st/X?=
 =?us-ascii?Q?P/BDMJGOm31R4PjpSnb5ARZgHPRCrr8UsTqy2Dl5PUfDGqersuVWl0nZoHET?=
 =?us-ascii?Q?GXJTxrCI3P1GzmQ/88Jw+nLxYkNi/C6uXXV7MhoTPWf2zbUKA+kZScNcBO6N?=
 =?us-ascii?Q?SXP5bSD5gSE72UvkF284G9jM9p/vHlaYBWRvdO0m7jWWgN7guVf8inH265Bb?=
 =?us-ascii?Q?jrVsfk41cazY2cqyy+Bm8hcU4hSNgnPPlIfXrBTJyQf63jx+yMlWwKRI7DBf?=
 =?us-ascii?Q?jmVS9U7vz8TxyA7GFuPeVC8JJU1QOGjqF3/6o6bOija1pLgymQHTggXVsyFC?=
 =?us-ascii?Q?rB5PCSV6HYUiGeSt8U0bl13ngoig5950UnDW6yd6E0zPSlm5ID8ZITdbNn/l?=
 =?us-ascii?Q?yFnt1BC8LwTcUl73JeCKNLYekzSbQRCI500yJ9qNkAwGcMORBeKeIjvvUUlO?=
 =?us-ascii?Q?e9w1bnP9osuTfrJUyUxC1XkzqzBup8JsCU4YS+CbpJ/lA7ODog4LdJocgc7U?=
 =?us-ascii?Q?deZOeQ4jk9moPdA9G0Poxc5VUZk2lgFyKxgj8TdfarsVUh5N4gAhVfK1XROA?=
 =?us-ascii?Q?zdYo8xv08e/4KmEKShn0P47M2iOhGKHl2PQWji3MCxmD1FXGxbP/qFKlmLRJ?=
 =?us-ascii?Q?Kld66sn2XHmCQOw5CaZ4jKTyf0o1IM39CPcPAY30g7F6STiDHE/VOYAjmygB?=
 =?us-ascii?Q?xoJH5Xhv5KaLiSCVIOJve6FDbLNpbAJTcq96BTem5GwL4Fb63+SzFvNdn5Ui?=
 =?us-ascii?Q?H1TeFQyoQDWVMPDiD5ZQ6xy5wChMW+8nLG0Sh5vYq0jnLy+waxiOWNwqxBqM?=
 =?us-ascii?Q?aqrjGZGNfe4zfP1D3++D96dLq5TOg6P5BpxwP7bT5U7WbX0FI244XKnd56/3?=
 =?us-ascii?Q?9AY+6/Cq+SKm9dWOTXUwJWQb9iuUAriC7v4VJnlUbAQLTbiKN8lIT/aorClf?=
 =?us-ascii?Q?YlKAd1TqlCWoVxZEOBFPcfB+cYmLhs4MA5cTyxkT2JXDLerCxLUau9zdlyCA?=
 =?us-ascii?Q?slZ7UZBhwSutci9AlKM900xZTaOhvPCqRiu84X6RJzYuJFJaDU9U2cS4Iy8W?=
 =?us-ascii?Q?kcHli7XnfyAx52vuGFw3r0x9U0+KAwiHNSnbBkPCLE+q?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d27f270-8466-4f7a-ff24-08de1603f0ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:25:31.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GsS7Q5t1UOZOBJbGZIbMsfpkyHoLrf27XWhC4Ta47BHKmsM/3B2SMVnr1UDPTyqn+/wwW++d/jnzgxXnivLvjvVk7o8ImduLFzr6Kg4gDNpBKg0ahqksgol4+iHyXbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

On Agilex5 SoCFPGA, the Secure Device Manager(SDM) manages ECC protection
for the QSPI. Since SDM operates in secure mode, all register accesses
must go through ARM Trusted Firmware (ATF) using Secure Monitor Calls
(SMC).
This driver uses the SMC interface to initialize ECC, handle correctable
and uncorrectable error interrupts, and support error injection using
debugfs.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 drivers/edac/Kconfig       |  11 +++
 drivers/edac/altera_edac.c | 177 ++++++++++++++++++++++++++++++++++++-
 drivers/edac/altera_edac.h |   5 ++
 3 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 701b15e73a39..439b823a6549 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -470,6 +470,17 @@ config EDAC_ALTERA_QSPI
 	  Support for error detection and correction on the
 	  Altera QSPI FIFO Memory for Altera SoCs.
 
+config EDAC_ALTERA_SDM_QSPI
+	bool "Altera SDM QSPI FIFO ECC"
+	depends on EDAC_ALTERA=y && ARM64 && SPI_CADENCE_QUADSPI
+	help
+	  Support for error detection and correction on the
+	  Secure Device Manager (SDM) QSPI FIFO Memory that HPS
+	  access on Agilex5 onwards platform.
+
+	  SDM QSPI ECC is always in secure mode, so access to register
+	  is through ATF using ARM Secure Monitor Call(SMC).
+
 config EDAC_ALTERA_SDMMC
 	bool "Altera SDMMC FIFO ECC"
 	depends on EDAC_ALTERA=y && MMC_DW
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index ac2151c625a2..2f2755ab2c45 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -682,6 +682,19 @@ altr_edac_io96b_inject_fops __maybe_unused = {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_SDM_QSPI)
+static ssize_t __maybe_unused
+altr_edac_sdm_qspi_device_trig(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos);
+
+static const struct file_operations
+altr_edac_sdm_qspi_device_inject_fops __maybe_unused = {
+	.open = simple_open,
+	.write = altr_edac_sdm_qspi_device_trig,
+	.llseek = generic_file_llseek,
+};
+#endif
+
 static ssize_t __maybe_unused
 altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos);
@@ -1585,6 +1598,104 @@ static const struct edac_device_prv_data a10_qspiecc_data = {
 
 #endif	/* CONFIG_EDAC_ALTERA_QSPI */
 
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_SDM_QSPI)
+
+static ssize_t __maybe_unused
+altr_edac_sdm_qspi_device_trig(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
+	unsigned long flags;
+	u8 trig_type;
+	struct arm_smccc_res result;
+
+	if (!user_buf || get_user(trig_type, user_buf))
+		return -EFAULT;
+
+	local_irq_save(flags);
+	if (trig_type == ALTR_UE_TRIGGER_CHAR)
+		arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+			      drvdata->sdm_qspi_addr + ALTR_A10_ECC_INTTEST_OFST,
+			      ALTR_A10_ECC_TDERRA, 0, 0, 0, 0, 0, &result);
+	else
+		arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+			      drvdata->sdm_qspi_addr + ALTR_A10_ECC_INTTEST_OFST,
+			      ALTR_A10_ECC_TSERRA, 0, 0, 0, 0, 0, &result);
+
+	/* Ensure the interrupt test bits are set */
+	wmb();
+	local_irq_restore(flags);
+
+	return count;
+}
+
+static int __init socfpga_init_sdm_qspi_ecc(struct altr_edac_device_dev *device)
+{
+	struct arm_smccc_res result;
+	u32 read_reg;
+	int limit = ALTR_A10_ECC_INIT_WATCHDOG_10US;
+
+	/* Disable ECC */
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_ERRINTENR_OFST,
+		      ALTR_A10_ECC_SERRINTEN, 0, 0, 0, 0, 0, &result);
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_CTRL_OFST,
+		      0, 0, 0, 0, 0, 0, &result);
+	read_reg = (unsigned int)result.a1 & 0x00;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_CTRL_OFST,
+		      read_reg, 0, 0, 0, 0, 0, &result);
+
+	/* Ensure all writes complete */
+	wmb();
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_CTRL_OFST,
+		      0, 0, 0, 0, 0, 0, &result);
+	read_reg = (unsigned int)result.a1 | ALTR_A10_ECC_INITA;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_CTRL_OFST,
+		      read_reg, 0, 0, 0, 0, 0, &result);
+
+	while (limit--) {
+		arm_smccc_smc(INTEL_SIP_SMC_REG_READ,
+			      device->sdm_qspi_addr + ALTR_A10_ECC_INITSTAT_OFST,
+			      0, 0, 0, 0, 0, 0, &result);
+
+		if ((unsigned int)result.a1 & ALTR_A10_ECC_INITCOMPLETEA)
+			break;
+		udelay(1);
+	}
+	if (limit <= 0)
+		return -EBUSY;
+
+	/* Enable ECC */
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_CTRL_OFST,
+		      0, 0, 0, 0, 0, 0, &result);
+	read_reg = (unsigned int)result.a1 | ALTR_A10_ECC_SERRINTEN;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_CTRL_OFST,
+		      read_reg, 0, 0, 0, 0, 0, &result);
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+		      device->sdm_qspi_addr + ALTR_A10_ECC_ERRINTEN_OFST,
+		      ALTR_A10_ECC_SERRINTEN, 0, 0, 0, 0, 0, &result);
+	return 0;
+}
+
+static const struct edac_device_prv_data a10_sdmqspiecc_data = {
+	.setup = socfpga_init_sdm_qspi_ecc,
+	.inject_fops = &altr_edac_sdm_qspi_device_inject_fops,
+};
+
+#endif	/* CONFIG_EDAC_ALTERA_SDM_QSPI */
+
 /********************* SDMMC Device Functions **********************/
 
 #ifdef CONFIG_EDAC_ALTERA_SDMMC
@@ -1815,6 +1926,10 @@ static const struct of_device_id altr_edac_a10_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_QSPI
 	{ .compatible = "altr,socfpga-qspi-ecc", .data = &a10_qspiecc_data },
 #endif
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_SDM_QSPI)
+	{ .compatible = "altr,socfpga-sdm-qspi-ecc",
+	  .data = &a10_sdmqspiecc_data },
+#endif
 #ifdef CONFIG_EDAC_ALTERA_SDMMC
 	{ .compatible = "altr,socfpga-sdmmc-ecc", .data = &a10_sdmmcecca_data },
 #endif
@@ -2037,6 +2152,25 @@ static irqreturn_t io96b_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t sdm_qspi_irq_handler(int irq, void *dev_id)
+{
+	struct altr_edac_device_dev *dci = dev_id;
+	struct arm_smccc_res result;
+
+	if (irq == dci->sdm_qspi_sb_irq) {
+		arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+			      dci->sdm_qspi_addr + ALTR_A10_ECC_INTSTAT_OFST,
+			      ALTR_A10_ECC_SERRPENA, 0, 0, 0, 0, 0, &result);
+		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+	} else {
+		arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE,
+			      dci->sdm_qspi_addr + ALTR_A10_ECC_INTSTAT_OFST,
+			      ALTR_A10_ECC_DERRPENA, 0, 0, 0, 0, 0, &result);
+		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+	}
+	return IRQ_HANDLED;
+}
+
 static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 {
 	int dberr, bit, sm_offset, irq_status;
@@ -2214,6 +2348,7 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	struct resource res;
 	int edac_idx;
 	int rc = 0;
+	bool sdm_qspi_ecc = false;
 	bool io96b0_ecc = false;
 	bool io96b1_ecc = false;
 	const struct edac_device_prv_data *prv;
@@ -2237,6 +2372,8 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 		io96b0_ecc = true;
 	} else if (of_device_is_compatible(np, "altr,socfpga-io96b1-ecc")) {
 		io96b1_ecc = true;
+	} else if (of_device_is_compatible(np, "altr,socfpga-sdm-qspi-ecc")) {
+		sdm_qspi_ecc = true;
 	} else if (of_device_is_compatible(np, "altr,sdram-edac-s10")) {
 		rc = get_s10_sdram_edac_resource(np, &res);
 	} else {
@@ -2283,6 +2420,13 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 			rc = PTR_ERR(altdev->base);
 			goto err_release_group1;
 		}
+	} else if (sdm_qspi_ecc) {
+		altdev->sdm_qspi_addr =
+				(u32)of_translate_address(np,
+							  of_get_address(np,
+									 0,
+									 NULL,
+									 NULL));
 	} else {
 		altdev->base = devm_ioremap_resource(edac->dev, &res);
 		if (IS_ERR(altdev->base)) {
@@ -2298,7 +2442,24 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 			goto err_release_group1;
 	}
 
-	if (io96b0_ecc) {
+	if (sdm_qspi_ecc) {
+		altdev->sdm_qspi_sb_irq = altdev->edac->sdm_qspi_sb_irq;
+		rc = devm_request_threaded_irq(edac->dev, altdev->sdm_qspi_sb_irq, NULL,
+					       sdm_qspi_irq_handler, IRQF_ONESHOT,
+					       ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No SDM QSPI SBE IRQ resource\n");
+			goto err_release_group1;
+		}
+		altdev->sdm_qspi_db_irq = altdev->edac->sdm_qspi_db_irq;
+		rc = devm_request_threaded_irq(edac->dev, altdev->sdm_qspi_db_irq, NULL,
+					       sdm_qspi_irq_handler, IRQF_ONESHOT,
+					       ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No SDM QSPI DBE IRQ resource\n");
+			goto err_release_group1;
+		}
+	} else if (io96b0_ecc) {
 		altdev->io96b0_irq = altdev->edac->io96b0_irq;
 		rc = devm_request_threaded_irq(edac->dev, altdev->io96b0_irq, NULL,
 					       io96b_irq_handler, IRQF_ONESHOT,
@@ -2578,6 +2739,20 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 			return edac->io96b1_irq;
 		}
 #endif
+
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_SDM_QSPI)
+		edac->sdm_qspi_sb_irq = platform_get_irq_byname(pdev, "sdm_qspi_sbe");
+		if (edac->sdm_qspi_sb_irq < 0) {
+			dev_err(&pdev->dev, "no %s IRQ defined\n", "sdm_qspi_sbe");
+			return edac->sdm_qspi_sb_irq;
+		}
+
+		edac->sdm_qspi_db_irq = platform_get_irq_byname(pdev, "sdm_qspi_dbe");
+		if (edac->sdm_qspi_db_irq < 0) {
+			dev_err(&pdev->dev, "no %s IRQ defined\n", "sdm_qspi_dbe");
+			return edac->sdm_qspi_db_irq;
+		}
+#endif
 	}
 
 #else
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 8b475dc692e1..e537304522fb 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -431,6 +431,9 @@ struct altr_edac_device_dev {
 	int edac_idx;
 	int io96b0_irq;
 	int io96b1_irq;
+	int sdm_qspi_sb_irq;
+	int sdm_qspi_db_irq;
+	u32 sdm_qspi_addr;
 	int seu_irq;
 	struct altr_seu seu;
 };
@@ -446,6 +449,8 @@ struct altr_arria10_edac {
 	struct notifier_block	panic_notifier;
 	int io96b0_irq;
 	int io96b1_irq;
+	int sdm_qspi_sb_irq;
+	int sdm_qspi_db_irq;
 };
 
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
2.25.1


