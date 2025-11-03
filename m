Return-Path: <linux-edac+bounces-5298-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD6C2C579
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D934622D
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FE30C620;
	Mon,  3 Nov 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dZUjrPSD"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386E313279;
	Mon,  3 Nov 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179104; cv=fail; b=BabbvMviuBSeg1KYRiGJ9XsDh71XAcPb0LpKwqGUNeJxauhWhD1DtoNd1PPyQNsilpmMdpyG+7rDPaAnfjbyVYEI0LsQSwUEWxdd3i+ciqcNUpSlvcPoFT4UXl2LPhUmu0qFb8jb9PjB7ACStfzQdC0jQ5TYBERNMNzMNVDPfKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179104; c=relaxed/simple;
	bh=0mMFBu+dPVrSYg0/o6VVkzMp/tiPrM1U96bdndIqFEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S43gayNvydZJGIplX+xxftzRF9JJrk+Hvu+uL4AghR1asW2qOgqBD+ESzWn77U0P1+kWzJlC6RFmN07AuVUZCf3CaNK//VCGx6UhYPWhJxVOApM9fsWXk7tTnW4TUWuFtbMAESnZJ2SOuuYQVoHq3Fqwq295+O16lqS9Jkk3GX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dZUjrPSD; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltbgXT30RSb3CjfrVepLCWlgPdHCQSnRCqk48v1YufNBequwCJjSL2TmlxmpQTcjyctjyOq95ZN35iXtsZPr6Mo+N4zg/MiII2CUTqUzpN6O8qiIO2AP3y6KJ8HwHrcGIcGwyudzri/ci3kfPJQI8gYcukVDIPv56rjKrW3ARMFLX+Q0xYGN6tdvMqUH56HBGMKRJk5riUOB86MYFyIAoIEMuwzpqy5So/DFbVhBXAYtoRWt9PgGF7IagDCbl+7SpQ1AE0xmzwWlC4o/Q9IBwd64an+MocUnYoIucuJCM05uiziH5zWSIw90cp7SBIthlZL1AHwUPCeeC7NSxkeaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Md3olzhd8A/mF+hS4Dst6KRaD5qug47TcYiQ7//NQ=;
 b=N9zJCBx+mw2OlJsPOjWI5Ujv/8xH/YMk+mGBG6KdekplUKaxULOD1vOrIS9j4w5iJz1AK1m7J9lyt1mHPAtWM989yP1tYTTUaj8/KaD3wW/18NL1sw7nv6kHt6n5Sh6Nc9mKtmjUEcq+zMR+UhvWwBsXXiP1ZmAgt95kPYiFb3RyvMBAbcAJmtxQcU/QHG6QfdQD9269cw18U3Qi4eqr8DiqKbIjqCHy5SQBAbD3k+HTFnV21zuigE+Nho44NOj8+k1Xrd4H3EDiFmF59vyDltlIJ0rvoAZSb4BT9/T9dQ8MtSYVNITm0OcOKFcmz2bCb7ELklXCHVIEIsnUb5qAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Md3olzhd8A/mF+hS4Dst6KRaD5qug47TcYiQ7//NQ=;
 b=dZUjrPSD4bcd0yBcjJEiYiinN4FFDFKlsZfxPvp1/q66qmnUuTAkyKidE8tUlvTQMbq4d4TqXUhsv33nVU+h/PLxUeP3z3IHrRpf5MU6Ko06dyfQ03AbBOVlmGergN+dfBM6yeWzmK7GFMyy9RU6zBBj3EnXkwabu8J1Z6GvuWPovOPPMjEYk7zxyWjs9EeMGjsspxHiSxpNn/Ui+zHFwMjiwwyx3qhfREN5ERmblS9A5FDckachg4ga2+Uo+juzEW4A14B9OA0h/hBswibQtYsnYx1VIOUftPFQQWobUZfGfLfCnQRS8xhAy3KNFKuUg/2HSArUd9WRBBFs6KCIcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SJ2PR03MB7473.namprd03.prod.outlook.com (2603:10b6:a03:554::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:11:36 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 14:11:36 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH] EDAC/altera: Handle OCRAM ECC enable after warm reset
Date: Mon,  3 Nov 2025 22:09:20 +0800
Message-Id: <20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0087.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::11) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SJ2PR03MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 738a6fd7-94ed-4d78-8941-08de1ae2e645
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dj/2JvVqvLhP9hAyxypFDfz4XcWbxL+iKK0ZP1BINeRsbyBAhSsA51/0CYQx?=
 =?us-ascii?Q?f6UJHDpLzXcROskYeXzip9GyeAKdNo5ZLEu7g0+TqKnuzK+p501eWX80NxJs?=
 =?us-ascii?Q?czXKMoSAcuS88Gpe6bCqjKL3fwulaAUtRH+P+DKYfH+twh4IK1HBIaxcEa+s?=
 =?us-ascii?Q?k5QFDAUoSCRjuGWyOGGD/LigSGUZEEzWM5A4sp6yAZtYZQHg4Bew3ctNrcl8?=
 =?us-ascii?Q?uEHo+b/kt+SLRymk1StJxM3vcX7U5O19stEjjMoacSrHJE4CcGolZDMzh/vU?=
 =?us-ascii?Q?UA6TrEdEpQ4wc3hE6e7j7rJTLOO2E8fwODmxQwOuU6/kbiJwoiFfpt36Xg08?=
 =?us-ascii?Q?V8g2zDx1MVteSSQJ58q6fSqIayxRy9ZznhIJ2WaQ/eHL6eHNPCyAiXs0cSb1?=
 =?us-ascii?Q?G+DOkGNz5skCLNZwl+lfWIhaYiZb5g8NfYX3Gml5NcCCmsWpWcQxJPe4p2lz?=
 =?us-ascii?Q?HSTRs3y6++C/SLvEeUBGU3+nT4BUezQsmrG9Q9+pQYxWe30f3eIWPMm310HJ?=
 =?us-ascii?Q?tFKyFIijbj+mDlaYu0ZALS5Ero51N8f2R+yrjgi6+43vsIBgMTAzgjXMzc2a?=
 =?us-ascii?Q?bPuvuG7nBXizDY6Dd5uEe0Q7eViwoaw7yVezU4NbhCHZZPsrIM13rY3AjeCL?=
 =?us-ascii?Q?7K856xHliEKpAIghcU5HSDi7PMOlImbUU6bKPj7SwpJP7+7Ewa1UvssEIhTC?=
 =?us-ascii?Q?TkSHLpp91QxEAEC1osp+uq1WGrheRP18sah+vZanS6Ta3+bZbzRUyRb17/8A?=
 =?us-ascii?Q?MJvChP5XypcOFduNqdvLtd4h8CExmZzxT4EC8j6/idQDrWY4hS30Um44A26K?=
 =?us-ascii?Q?miqz+rP1u07GNGfHdQA3a4B8YHxqAqxlc16Th8t/SCNQBGKaeLs8dy1YLIya?=
 =?us-ascii?Q?yuhBqZHdXyF8vO3PtHsy9nqVkWXB81oAD58WgJbN2jye8/8G7cwfQ+IDPO/J?=
 =?us-ascii?Q?TMOChbZuNlrUclfk7Q/OicTs5B+ir53fJ+P8XHTq1SkIOmQhj0zwMnvynXBy?=
 =?us-ascii?Q?IEZusmULgjGaeDtB6XrbzEcVrC2tVu494ciOosCRVgi6kbRkF5BnuwcWtGq7?=
 =?us-ascii?Q?1btp5k7Y9N8dT6q9QJhHkOEcl+Ic8/7p/T1ap6Z5XBkdQ+x6j0f5Es9Co1nO?=
 =?us-ascii?Q?WdyHH+jXkZWIyyfe9EgUPfnctcDbx+/mV9NZe1KKBpGlXmUMCmPvOc50VU43?=
 =?us-ascii?Q?gLSs5SzqA89SjlYU6th9AICXvDDyZUMDhL9qf3GuyrfDZriwhUF2QvD4R4Gf?=
 =?us-ascii?Q?U3nPE+iTpnn+66Ce5k3uTvcgQtEE3WdsvE5ahSTbfihZ/C/ddI8nxRRWF7Uv?=
 =?us-ascii?Q?uBJ1BohK0+LblsQVFJ3zaLFiJI48fQYBzm1x9V30qs0/Wtv1kYoK6aBVCXJs?=
 =?us-ascii?Q?UWxvY5g9tW6lsrfvujG6hTZZ5/JI9Ff0wLfneRDNVXhsX7QzQv1ZtODMXTCC?=
 =?us-ascii?Q?hsYqGdTetW0CCe14mgA+OYoWTPvafY1O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pejD9OhqyGQzdg5gZnV0ruFNg1/ApKH439LlLQ3x8q0ghij2mY8aVhCx2sO3?=
 =?us-ascii?Q?W1os05oczZ1hdyP3eBahFbE+5g2n0BswUsAOoQA62BdCrAGUXFZ69LVxWHZa?=
 =?us-ascii?Q?eTBFUCV6NNK0hsevyhRMDw5tRpFC3yc69WycFz0eoWhrcRSjxG2/dHh29bdW?=
 =?us-ascii?Q?Hc0XePHXZw/ngayE6YpRsIGCB1/shIMa0ETF6ruOWCbI6q6EGEI4mgHIeBEj?=
 =?us-ascii?Q?W9J3S1Bv0OnDzE7wevqS3C6tdJCBCmx9gVL9Y4V97PLDumeNpfgy1/OxGnoJ?=
 =?us-ascii?Q?suMmLihgPe8plf/YhUZQM3K3HkuwGaeSB8RiwQygHNj+uQbYBoozEsTpYXtZ?=
 =?us-ascii?Q?G4tIvC29WLhTbqfuPaaS4uYFbtJnGzKQvzsPVvdd1vt9tbI98rfH97GTOmXV?=
 =?us-ascii?Q?9fLOo32gGCtipG4X6g41KQEi1ZGeHBwbNz1oXppxG22hKaptolrU8N6uSuCB?=
 =?us-ascii?Q?Gy59Bwo9KwZ0H3Pra0SUo58EzqH8bdlFGCdmwJyd2kQxrbU6bFFvjM7KL6x7?=
 =?us-ascii?Q?D/oNAim9MM7PBJVvDw/H+DF/je04LVEc/K0JFmaKn3oNwAfBOI2/ZKsKr0Hr?=
 =?us-ascii?Q?hOPUWc8a9K2Sf2bZzKq4v+CVHIcm+GeW49SlR+X7/5Ee6B3Spl9cTntjJJcK?=
 =?us-ascii?Q?ZDmZDj0hBPJnH6mhhoDpcClr9qXaXPe4sK14Ffo7ZvPsL1wjHSw5P8dP+9Yy?=
 =?us-ascii?Q?ktRmxm/mc9Z1kWmfTPkzXrlJ7VSm/oCG82WFXD/17Svio+jwa9jrqCgHI1+7?=
 =?us-ascii?Q?igUqMy03nTJ4r5RPAuUiDqhSKFrXGwzr9bry3kP3v7pFmZq9KtuIGu4V53jZ?=
 =?us-ascii?Q?Bsa/LzyHxau6Q3rlLtQ1Ij41hJWkT59+HSVo/lO56Sg56BGWcnOwNCNNiYhF?=
 =?us-ascii?Q?gJ80ZKZD06TqL4yUg8WJnvaynWskwg4YXJ28kQD2WYcWCcIAwemN03n02eA3?=
 =?us-ascii?Q?KZy38MEmaCJtoaYuxC9A4uF4uZxpXqZrAgmhaSMsBbkyLv/OPPp1ZcmSRK9e?=
 =?us-ascii?Q?8mNUtbGNBRVVdNX9xQQU36Bs5BJK9/Xx4DcBc3x3rSVWjq0bGVoWS/fvxWfl?=
 =?us-ascii?Q?cjhuyeLxr5tMf+upWV3l3gXLwDLys3VwIwGNJkDiUe67XaHVRXovhH6NOOmr?=
 =?us-ascii?Q?J7LgZEWrSlmuBVgV9hFUXpR+ZF97I7bN9x3tEXgPTzS8/3zndRnJS6Bw3c38?=
 =?us-ascii?Q?CKXlUk4dCVeDw+8S26sVkbrkM1p936hjfmpnB/4NXRThkUuJmv5wxPl4wWE4?=
 =?us-ascii?Q?/jZQHrP8Hab+i9k9yfVt36ZVMOiUIj2HwClvZZVmE8tEZMv1O37PPOlS/7ia?=
 =?us-ascii?Q?Md7Sta6Xbr6mgwdNaLMAca2r4CVzykuJOzi5ffHSrmgIqh/A8e3TAHAIpLBg?=
 =?us-ascii?Q?A8hCOstPA8E+pvOeHRmO8Nx765cxCTiCaK9tQ6o61dkVPp9dqFuupEgxoArp?=
 =?us-ascii?Q?cyOET6IMuNldjWV5hX0bKaieU6X1V/36Y6Ee6/iKSsOrabbEiqNXD+JVhO/J?=
 =?us-ascii?Q?MxW/4KX5aIWSeVVhXE/oET8YhNrBRalNPcMgHq0B2iGbhMGiVETBEHoNqFcJ?=
 =?us-ascii?Q?BDxnsGbj7kB+yXMMf6MMUb69uN7XpAIi46CJz0btJVnDqeN8k2YYMNlmDyFn?=
 =?us-ascii?Q?OV4UyRoDhTHejwQv4VlxOn8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738a6fd7-94ed-4d78-8941-08de1ae2e645
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:11:36.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsBwbuDjWIYiagYEt/287VOW1aFT3PD+RIzLqTEx8+mdvYGWZhc9gznRtUkJJxw68ND0DHMmuNJ5Dh1RGPE4v1642jB69HhVXZCmsqd1DYc+4cgSoBzDQDWcsfXDAAVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7473

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The OCRAM ECC is always enabled either by the BootROM or by the Secure
Device Manager (SDM) during a power-on reset on SoCFPGA.

However, during a warm reset, the OCRAM content is retained to preserve
data, while the control and status registers are reset to their default
values. As a result, ECC must be explicitly re-enabled after a warm reset.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 drivers/edac/altera_edac.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 103b2c2eba2a..a776d61027f2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1184,10 +1184,22 @@ altr_check_ocram_deps_init(struct altr_edac_device_dev *device)
 	if (ret)
 		return ret;
 
-	/* Verify OCRAM has been initialized */
+	/*
+	 * Verify that OCRAM has been initialized.
+	 * During a warm reset, OCRAM contents are retained, but the control
+	 * and status registers are reset to their default values. Therefore,
+	 * ECC must be explicitly re-enabled in the control register.
+	 * Error condition: if INITCOMPLETEA is clear and ECC_EN is already set.
+	 */
 	if (!ecc_test_bits(ALTR_A10_ECC_INITCOMPLETEA,
-			   (base + ALTR_A10_ECC_INITSTAT_OFST)))
-		return -ENODEV;
+			   (base + ALTR_A10_ECC_INITSTAT_OFST))) {
+		if (!ecc_test_bits(ALTR_A10_ECC_EN,
+				   (base + ALTR_A10_ECC_CTRL_OFST)))
+			ecc_set_bits(ALTR_A10_ECC_EN,
+				     (base + ALTR_A10_ECC_CTRL_OFST));
+		else
+			return -ENODEV;
+	}
 
 	/* Enable IRQ on Single Bit Error */
 	writel(ALTR_A10_ECC_SERRINTEN, (base + ALTR_A10_ECC_ERRINTENS_OFST));
-- 
2.25.1


