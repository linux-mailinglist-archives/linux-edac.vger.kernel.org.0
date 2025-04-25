Return-Path: <linux-edac+bounces-3748-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9AA9CBAA
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350651B801B9
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89B256C8D;
	Fri, 25 Apr 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YiNdJQ7n"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEE257AF9;
	Fri, 25 Apr 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591220; cv=fail; b=EZU38u6JbWKCpo2ZnGZRoISfvtCaaasA8nX1BsqJEHVDETMhWvIYOv8KRbIBgWXQPzCvR4jkat939p3+Fuvj+qitiQPIrPtO0Uu6YGS913HRH2aQKef/Mk4WLj092R80WkmBPNywOfu144t7os/g2BVso4LfVfsXrQWti8xIXQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591220; c=relaxed/simple;
	bh=tvYVVp71r4bceY0JZ6ukPCrXVcPLAulPmoKpiD+dGOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOaAZXRKXEScZNTLW2+SN2PbdSlHp4LqhG02aPPwttCFDNyX0jPCPyuotcmqed5JuvITxnlIuQz2xX5+EEisGAuHKI58zd2aqwjvSSWop8GCyPnRd6MskhAJbQmHFz5Mj8BxSEqjnFjeOg69kmUjMRn6yQxSCa2gvAhPWYLBKWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YiNdJQ7n; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG+eVwygiaHoW+uP1RkPMJK2ZR0xSkHAqcleJNsQf5byKKk/oz5AKI5M647UvTYlWY8VgbvP8VQoQtfS6RbTICwJzRD6KVJJe8+GwOnD+J6s4wE7Wxgfb2rXVpzONEWq7R0kE4zhEjdhMEIb2sSVap1CFpIpLiAot4TXDPcXXtPJOY0NxGwy2bD8Ggx2+WptBigAJ+zqI5wrlUapURgjMEwsCFqCXznZeNJNY1ZuP0UZch4AfnDkJtw6lE0JxqCv5zQ3FAmBHsFGwup2qCGJdXImb1wINDP0HEyLQ0YKSA5bqgnumu/TDIYLmWgNy+SQlMjIhRPL7y78kUiIZT6MPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwGLiwZBkZnIetZOtNLRCF1MZwP1Xs1CHK0YWdQJEyo=;
 b=iALaPV598H1Q1pQK4094x6VNaFrDGdlPb06wTIw5tvIOsUNjfE32Qo36CYqjdAg3469Q8mjTqZ+cqloAu1F+F6apxi/7FK2uGylsv4JU91+JWLbQkfWHA6flwHsYQ66B4GnRD0M/KDBqr4IA2lfioFq//oryJG516L+659ajR/7lwoBlEIwyGsA421eY40m4hDAQqT6Byq7ionj/w/uWdqMhNYrzoOsBDR/DvG0YFwu6V8sPVK8uIosvmy0nPDaAnDSXxasoabBRBTkSZQxTpWUM74xR50h1E92iDN9BxwEmSaQh1E0LKuYASXZd7Q8LJjTzKsNO8rNHRF44IH3yHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwGLiwZBkZnIetZOtNLRCF1MZwP1Xs1CHK0YWdQJEyo=;
 b=YiNdJQ7n9ZlSmYeOcw3d7FuTc+73STIuHIsLwoPqhZOmW1eo0ifgFiPMP1YtwbV/src67NI6DrAm2++AgW0+VluZiBUfL8AeVoOt57Dv9v9AgucN9IU5/v0wXQg9bZ6QM5gHNIMXoRfby09zWKDTHo50yoyeQ+aKx+TXV2wRdNhTVudfmTdKYRtpKYExqsfLNLeHyqCQ00rzgoObATaGwDZUPH2CvWi/cOzmmKnD7VvHbv0m/HfJFq5YzXGzqrv0IwjdGqv2CZAc+JyxqQcbTqqMS+0MJYP23bIt8smaIg0gFkLEoq0+BlnuV96ZJMlTIpFohLdhJ3bCpjHMl6JZbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA2PR03MB5818.namprd03.prod.outlook.com (2603:10b6:806:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:26:51 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8678.023; Fri, 25 Apr 2025
 14:26:51 +0000
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
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	stable@kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3 2/2] EDAC/altera: Set DDR and SDMMC interrupt mask before registration
Date: Fri, 25 Apr 2025 07:26:40 -0700
Message-Id: <20250425142640.33125-3-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425142640.33125-1-matthew.gerlach@altera.com>
References: <20250425142640.33125-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA2PR03MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4612044e-0b69-4fec-e632-08dd840537d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5x+x/EPL3IGuONoRha/v0ClHUeIqZpPQGdaDEsjPt6bIMYM3IrnP/rrx4ne9?=
 =?us-ascii?Q?1JWKpEHMiRi5jC/DADOJYZpqOUtD8miC6xHBFqqtWJkRMLUV+NDUBvIwmO0P?=
 =?us-ascii?Q?Bp+rDPdFf5JEnj7depAEUMNSk2CAaBDDuoaftoBfP/sSV85zhYuxdSu/EHwo?=
 =?us-ascii?Q?8IUuzLGWBhYnR1hmkqmLRhcrhnkE0a51b+Vh26ILLFmd98fq9u9eSsT/n/kH?=
 =?us-ascii?Q?sUEc3rfTWAQwUxsRFAsOsBJnF1B63XNe1uc1vUYG10pMzAOvbHZ0dU4Fc59W?=
 =?us-ascii?Q?8SCr8GlUYt0kp1qxqWCqKKn3esnbyn2KcGKOSVngpqRqXPOEmRsgz+My1CYb?=
 =?us-ascii?Q?zom0MCTQxANeGV9JYAXo1e/e4UchsWH2i9z023D3f+CdwEdmhdjLaAdtuMvr?=
 =?us-ascii?Q?TL9DVUq7bUdtnMt9go5fl0qzEhBSfa0k82bMdt1UvISi12VsvhuvPofZWgDk?=
 =?us-ascii?Q?m4ayJYDPrj9kNhKB5vA3xQ3gLk+dtW33QV+6+wPfoZ/DtUhzSaYE1xIGy+q6?=
 =?us-ascii?Q?MACxIznM1tryAcMcwgg57XDK3MRat0PT4iX1Cvmmnj2PGb3aLyQ6W/SaKb6z?=
 =?us-ascii?Q?UYf9QYLJUXXj6d2FF8hayPSho7mYnZCHPe+S5q9Bz6+lwPm0dKerrCWPoRd6?=
 =?us-ascii?Q?mS9Kb7afw7Nfczs8pxu9lqAlK+OlJHJRWRWr2MVj5Afiiz/2Mxv6dbm8DZAR?=
 =?us-ascii?Q?rngC4dqLT3k3Nd48kwYB6UCG1EhqczL1vm8FxhJbAVPdA/9/CBcnC5uuhjXF?=
 =?us-ascii?Q?1RgJ2rqA5VtkYczOZRG32OViAXANVvLwL5L2BDqKf6ExIbIFqxY7sNcSmOEr?=
 =?us-ascii?Q?o/fJ2mhz41x7EUTDh86QhPe0l5LQpnf2dv30Rzt3H3md9aEzyQBcsuMrd4MJ?=
 =?us-ascii?Q?D3KgFw9OYD1BUsz9tUTDmdm+CmfdZEejQh+J2nG0mIG5yNF0j3/mBIlO4lA6?=
 =?us-ascii?Q?WQIAyged0UeqNn+wnEK5UyM9LEMHfu2rUYmczeM///9wB2nnH9f8eG9/B6Cg?=
 =?us-ascii?Q?BkEXALFWr6azs0x15Cmc1N8SiuxNCzd+Yryyowi3i0p7WU91T/19q1RBKKyU?=
 =?us-ascii?Q?07LndsB1v8CpFvJrzIyaqQyYMq2TyZCycSTEn34NvjPxzH6/Hvy79JfMefV8?=
 =?us-ascii?Q?xU/HY2tujqqHueR4QmndLPQOwFWcM2H3P9McBsd4acCDHciNeA3+lfmLA3X0?=
 =?us-ascii?Q?gq1/BzwUa1hJo3i1k/VCPWxqFDdYgwnRimFF5/425FUzpOZJf0jeVfSlC+Ep?=
 =?us-ascii?Q?Td7tPo2geFH+MqVZUWOBxj0JmECRRRbyS7wkorK/LaHnbS8nILEIAL6qnDTG?=
 =?us-ascii?Q?bBcDi/on54fScXDc9LwChzcdqZAGl26l90s7hhjVtGk7imfalZn0oLz2Denh?=
 =?us-ascii?Q?PBYdEgyd2terRj1fzcwsvOBmegAzgUvPCIVeLQCE25isIrFdiFrhhv3TApHO?=
 =?us-ascii?Q?FAdI6EbHDDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4iW5VVjfSzgEYXgLOc+QX/RmN9H9VjGPoPMxIKtw7mdBtF6r3LFQGPrs8l3K?=
 =?us-ascii?Q?CNPF5VeedkLALm2oagvpacNNa5CpVtihAACiOS4Cq5WH7Y7zpOmxa6umzFUX?=
 =?us-ascii?Q?uCr8r0uNQKriGOtAj5tyg9kN33TwGyd7NUhk4jowXdnZUugTr5XYMRIOOUXM?=
 =?us-ascii?Q?2YE08PoXAWkKNnzHSWc1T6FTGSdaWQ1rTJ/hivj1kSLcupUZah1trgdkuZPq?=
 =?us-ascii?Q?gM5bBNwLkCDTp4upGcAWwEKsqE9+VVODAkAsA5YeBGx0LTE6noUVEZ+DGPbw?=
 =?us-ascii?Q?Ik0wBdDvntifbHKwJUbe2p7wkCpRK5jmsV7Q49RxJNyDv1TI746l9FE4De4S?=
 =?us-ascii?Q?sDCs35YC6BbiJiECF/8VBLUGl651pBELooACjj4bI83F2R2q79pU7K/avWIh?=
 =?us-ascii?Q?GZFnZNBsFP9ZBc7GDwO/sdoN/FYphQY/+MAMpo5bOsrtWXGVQRj1Yf2Zqn0g?=
 =?us-ascii?Q?/NTWAy7GoxiD07kBlaZrESNtDArgg0vfO8tl185yA50yPA/tKx+8zZXa7Gte?=
 =?us-ascii?Q?82/4IQV9yTsS57lv7LI4j9w+XIc+Yel+5a4dP7JDqUmR0uJLg/+hKUoO4Txn?=
 =?us-ascii?Q?IsVquRL88P0yDS2taDvx/v/uxPFWKOFYCqvaFdqPGjjZE9z/nkQS5sFpnnX0?=
 =?us-ascii?Q?LoatK1NDMbwIqtWLIsmuNyHM6c1sXLPthzUAJsImQpDGnjujkCzfrzT7jjSG?=
 =?us-ascii?Q?yXqAkQKpijpA/G8+8rPEMEKsJuQZk9peJqq4XoyQkBC2xfNKe07izJDz/awP?=
 =?us-ascii?Q?oQeKDWlNCKD7vi3wsYiaDFnQKtI2c9G5VbBLSrnToni48DQPPbEJq9DNR1hr?=
 =?us-ascii?Q?Tfi6ZRYAfxJaOdRPud6IcMSL1GFtqpSsS+hEsoXNSEMIc4ilP9+WgZo0pN9e?=
 =?us-ascii?Q?V8AjAPnm/kvhpE9oEXP9w69/ToYIACETjbiJv/JBsXAVcuV3v/28Vrsldcco?=
 =?us-ascii?Q?JZ0DHsVOXksAKMBED36MNQ+j1aSiFi9jgjK5ta6FJVLDDu0R0sebWFFdIAM8?=
 =?us-ascii?Q?c5Rz+aMJgjoWx/Nz8CC8j1ZSb3LGDO6kRWzvfeIAl3XWf5z123dWxInJ89Sz?=
 =?us-ascii?Q?HBlKSkoRBJPCMB1AXbLCr2F3sz+1tUJoBAdrkqufptSeajN3oOn29/7IGwUX?=
 =?us-ascii?Q?ZXrqasoaF5fwea3a1Yq0ivPTwtkZAcKNV7cwvwc/7MCTRO8hqJYz/FaLr/4k?=
 =?us-ascii?Q?QxzPE/tNC8eFf6gtHRNsslV0acKTChhAN9BVd9tMsBwfvpRDC7jDhUgNZ3aY?=
 =?us-ascii?Q?C42q9dTEdyHlWpXBDQPC7ZP6MU7lZTSJ0JQHPEyCg+8qc+wMEruN0TpqD8L8?=
 =?us-ascii?Q?qNHLQs4Sk7Fd5MJHss0uDF3v4fe0lKHjz2cXld1Aj3ihYqtYBl12phErsDn1?=
 =?us-ascii?Q?wTiYYUYH/MZlVsMoL/TuVBMVHHsTzgwaEiG/bVq4CxbJ0ZO2wprBwy0tqlbh?=
 =?us-ascii?Q?bJRCAg8lPpsfFCni/S96NTKbCTh9kdKjMPthozC2eJ9v4JFlFS1tiEBVuC0v?=
 =?us-ascii?Q?wI3v2vtkWHhZzfyh5/gw1IlsasAiw+/PsP6y9SQOWOJea9qi0K9iEKwNZjOk?=
 =?us-ascii?Q?blP8o0mowfSFNxqRNwq6gU2ZG24nV4FzPPDvDOFtw+H1k7vcJXI6LYwxBPZW?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4612044e-0b69-4fec-e632-08dd840537d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:26:51.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNUr13Otcft54XLw5gLDrHoRV/q6udVF3dDch1rYAuUlYRf3RrseKn+X3I2KK9shtU5YTzQNqNBtq4p7u4StSw1p409dWtycY067Zm16gs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5818

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

Mask DDR and SDMMC in probe function to avoid spurious irq before
registration.  Removed invalid register write to system manager.

Fixes: 1166fde93d5b ("EDAC, altera: Add Arria10 ECC memory init functions")
Cc: stable@kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v3:
 - Use 12 digit HASH for Fixes: tag.

v2:
 - Add Fixes: and Cc: tags.
---
 drivers/edac/altera_edac.c | 7 ++++---
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 88d9d2f458ee..dcd7008fe06b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1005,9 +1005,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2127,6 +2124,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return PTR_ERR(edac->ecc_mgr_map);
 	}
 
+	/* Set irq mask for DDR SBE to avoid any pending irq before registration */
+	regmap_write(edac->ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_SET_OFST,
+		     (A10_SYSMGR_ECC_INTMASK_SDMMCB | A10_SYSMGR_ECC_INTMASK_DDR0));
+
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 3727e72c8c2e..7248d24c4908 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -249,6 +249,8 @@ struct altr_sdram_mc_data {
 #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
 #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
 #define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+#define A10_SYSMGR_ECC_INTMASK_SDMMCB     BIT(16)
+#define A10_SYSMGR_ECC_INTMASK_DDR0       BIT(17)
 
 #define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
-- 
2.35.3


