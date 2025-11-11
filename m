Return-Path: <linux-edac+bounces-5429-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16150C4C503
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 09:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44D43A3695
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860252BE658;
	Tue, 11 Nov 2025 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pA00tEHi"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F371EEE6;
	Tue, 11 Nov 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848624; cv=fail; b=jkRyVeCrvY5AyxpHyUPxYuEG1fNls5w37Rz8itoGrZrGI3wo+pCat9hza/2e+RKsarrvGzgx2FkwE4j/3gdVMMtMmDyi3fnC8rd5be60qEeP4bF3oxHH2PvkeWIc4n6w9wHQFhTVxo8Pdd6Syn7ob3N7QfCQ9InBNxU9ppn1yn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848624; c=relaxed/simple;
	bh=NDv/BEmimQc76g+b59zdSbJvzSFSnrZi651uUdvOATg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hVK++MF1Y14IoS9xq5z5Sx3H+33e6bZ+sWIhG6g8gtXvE046KGDjJSU+e1c44FA6Td2z8G1UO0tLwVxPt/3b79Fim9Yi3+R7oPVN21OSyjio8fMDUlV0befYwz36A7Y6yrfwf+6ti5bSYflsHj2Ii+2jtTSgCvxE8QRjPzwlVfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pA00tEHi; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9DJipdGdGO/PGKJONKy+WBBvUrAzxJICPAC+LBFo4W1Gf8uiSXzKhlDAWljiLXwtgM5QQELR0MSaWbTs2tXOX4vbyfpzrrAdh7afQWNn3uvZnvDDGh5VrTPztL1GPz0la8oFcL77240uZRXcO+lUv3Ns3d/HKPeMpk9MDPK8DI2NJCwL62bnYPYEZeruuMFRDd0Z8rihYQSXGWC3Yw0jfWK9AqV08IXMTIiLBSMG4toPidhRWOus0qKBrN1wnv2K/wnYYX7F4rIFKwwwYyfWwsJB5+g3CAJAMoW3EPUr/WW4MtMpalue8VsU2XVzlXBieaZ/xG2dImbIvjsbzG9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmor1E7C/UjhBupfoY4KVJGtCkCViXv4vILiOrs7sLQ=;
 b=NMeZScMz+EfJCcyhjCn98PXylD4aFgt6gSHD8v5+54LKRlGLPbF0wxaS3Z6lEKr9i7NJse2YfpoBUZ3pWPx07J9ZLBO8xD5SAe7jDfeA2Il//+Knk4bojPivIpRcnzHDi8aF/UZiI7QGqSd6bbOSNH2vbGvPXqHyO4hQO1/635dfJFi+ZygqWKX2mxnRdEr6OO3BTq9ghn0vOiAtctUFIS0WW6CyO8T/MGMgLOMhLFbTTyTTJawQ8n/jv6PT1qZR/ImCZ7f6QOAz/ve7VfytNLvV/BEiKONfhztG5hITy0tfOqM5t+qJJJGTrmnSOP5p1pZ2OfcVAYJ0/qcYffHe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmor1E7C/UjhBupfoY4KVJGtCkCViXv4vILiOrs7sLQ=;
 b=pA00tEHir+jFnMt/NaFeo4HbFpDNtvWdW8D0nOE03qgK+9iV7uuF8n8wZgrMzTCi3PMunPWtw5yP1a30eCvnKjExo90v25b+AD/SUuVE7WcFMOZVFxlY4TW9kE44Q+MZM2qzjpB+JLL6+hD1xqp3kRsA/RpN1FGt40JPH20Qyhukb9LSjGOwsws3tZpaTuELJ8w2LPRvMwZoUBfr838TPlDm5Qf8AyHJ4ia4WrPhWFCDPQ/qLHg0ddNhCcJAUjeAhHV54Z9DvFOZANKQCQyehI3cObtn6w4lSFtzxUe9xDLcNiqPurtiSjRz7hhD4rXXHVRIwvfUYvtL6FKLwDsCXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5669.namprd03.prod.outlook.com (2603:10b6:510:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:10:18 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:10:18 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2] EDAC/altera: Handle OCRAM ECC enable after warm reset
Date: Tue, 11 Nov 2025 16:08:01 +0800
Message-Id: <20251111080801.1279401-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::13) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH0PR03MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 452d7a21-6fe6-494c-bf0c-08de20f9c088
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBb9r3y2i3ra1qi+Z0BAvEjbuEzlhpJim5amK/pd3fEtALML78EVM9w1Go4x?=
 =?us-ascii?Q?JSg2ZAN+bETRVd7hyeiQnsDDE9KJb9nW4iWKg2wC/NhQtk4hV80mKMWwsO0F?=
 =?us-ascii?Q?6sjM0uZETsWO+sQBfrX6/ltITAsRcRL0EmyRVE+4Z/z5yR2vnXglNkbzQBiq?=
 =?us-ascii?Q?StgvxT1OlUvf89u/yCyH1AIynj2GqsxBKE64pxriJr2gqmdy0tTChtrm9AIr?=
 =?us-ascii?Q?Pk1pR2eWymqYPnz+cskAHmubli9kvXJkNkFcbU7T7kD0YZpq4sU/66n8Bzgc?=
 =?us-ascii?Q?+9PBXIFzP5rjogY1P35iOtP8YkAmSvLtTvv9kX/hOK7wlDBmwnEEgPdMuI8t?=
 =?us-ascii?Q?E6qoWD9Zyo4mTEwGF2dZImLO46c4vq2hDHhgdNmdPdx9BkrUHUC52h04s9b2?=
 =?us-ascii?Q?XL5+mP6PCcEkbMU0TZwNFY35Sy3BEpBapcl6ihLCOUXQGBOO5b3neOkoR9lp?=
 =?us-ascii?Q?dauwqibLtwH2tUjR7y3rO4rEG9p19MGCwbsHkPKqM8g5hcqkNqO9wR+fpYyR?=
 =?us-ascii?Q?NzEAsnfkNtIeRQ9viRgyMN+PwswTRqvf5qXimaEibZvAZmLNFYkZwRs085R+?=
 =?us-ascii?Q?RgMwAzc7UaAlYD0cealh4VzxjQWSK9la4v19BBWNdPItIbypGqn6WjWCO9kj?=
 =?us-ascii?Q?m6mcK8cj816K96wVpzu3SKvZzie+tXdhaTpQW9lbNDyjPK8DGkYHmfbApqHk?=
 =?us-ascii?Q?70jJsrAhO6bHS0GNsDlD1x78EV8VQh7bmpxAMvhGQ7CN4SMoG+9gCua3+O8I?=
 =?us-ascii?Q?aeYT3KzNTyrj7pAaN5uhANAPK4lQ8CUR5LCZc53bg46hk8AwjgqsrpwnJ/+n?=
 =?us-ascii?Q?+NNsekSs65TWcanq62tWtgSnqXTlqix6y8fm93fBu/LeiQH7BXlwDrE+9OEj?=
 =?us-ascii?Q?KxVK7/+zadiVYkt1hXqf1FgccGXLhmPuPcb/+qdQ0983nIHLDcoSwPDOMnZ0?=
 =?us-ascii?Q?X/48FBcjG0leCdqvQtspDZUFdMCEEGmuWbbarIRBr1u7Y7Hjl9gOllXLlutx?=
 =?us-ascii?Q?0cQRigJ9Ml9LTSt0II8ABUucr8dPuZgeNd82dMG0arRYwnBrJBcA576S196i?=
 =?us-ascii?Q?JwRcBt6ps/5EPOCK5tYun015yZ92UOFC1smn/ytu3GaY+RDWzpCqjGaI49sJ?=
 =?us-ascii?Q?tCmkMngOox+m6++HFstFPdekzaDHcFyYzo8lJl0sbJlJJWQHBr195nCalmML?=
 =?us-ascii?Q?8Idty9V12cjbGD/yYFmPFrodxnlJ8N6kZXZJ1Ccp8DOhCNiDZtg1ybIguyCl?=
 =?us-ascii?Q?l51ctAIEAHBzXxdrO/BT8J5tPFZoEi8kLBXbmRjKTFNwPp5VKcmGYnFmLx40?=
 =?us-ascii?Q?cXdMU8VaZlM0w2RAEF+NDpo0GukB16vVNFW2qm/Sp8SIvgrdMaQJYny4cDb9?=
 =?us-ascii?Q?mL8yXfTjHd2LRiwjU6V4FILQVdx/ehXw2OmLY0WVCleIRGjncCFODbh6u0ey?=
 =?us-ascii?Q?XPXVXgR7DaoC+cjsFUV/DYHT1FMFRWnK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3iXtjQYW5zPowvTg0tzb0k4dscA9L7OZnoakS5mBys3jYMGrCEueADwdWtPl?=
 =?us-ascii?Q?gFfCo5BnPlte+Y1HGnr6jbs1wox6MOmK223JL1UXZhBfDkrvZPfww59Miew2?=
 =?us-ascii?Q?+NTgimovPQITfy+fWvcRd1WXmxvYT2NUbLvQW0PapbVwK63sMUBLAT7Q084J?=
 =?us-ascii?Q?NdKf2BjiZw/Ltbz9iY5yWHdMKU/L8w06PmLGPF8K+QmLZ0om5gM2HSoo6XH1?=
 =?us-ascii?Q?Ha+RnUXckG8xx3WdeBODmi6IV7KDmkb8GoPOyNoYqJkYbdv5TiXTIM1TBPdg?=
 =?us-ascii?Q?WJdkE1QaDuIbd/TLRWynQxsPYJzc1BNmDsQqP582B4J5Gn8kbcs4XJ/3juhz?=
 =?us-ascii?Q?atyG/Vfwzeei2+slNCf494bYep7ijkrwdezJS3l1A+tkA8Nba/hGHDQx6Siz?=
 =?us-ascii?Q?9pr0fVFVTMFlEF2LUytENUqX6Y9C47Hqop/gTqXq5H72n9E3AdsfHNwdQdXU?=
 =?us-ascii?Q?GjGO2rOm73s4liohU6ZOZnKFyVwqOjH4IZAjrVsMOXBxu1bjDdLfYteQx38a?=
 =?us-ascii?Q?Ii87v37uwf8cRoXQDc9hf68OVXW+ygV6eTxxmmWdvZzpud8LetyFSMHdo+Of?=
 =?us-ascii?Q?pqgqGbl3ovsz5DsLAfwHuzBf/TsrXLrRp75xUMy0+abpInewFevxRTBbNyFz?=
 =?us-ascii?Q?QkMxMqe2h5DL0cMlXZIgcIU8mn3vSgVfbAPakF8dFc5FpkkvEf6h8w8EULsw?=
 =?us-ascii?Q?WHgIdG0j0ZCAF2mkHmb0b82uvwM/+GSuygqfIkSEZxfnc5RR+YBlq2u8mph2?=
 =?us-ascii?Q?FtpIXVVxqAkF2GEbEfLv/8xGGVIc7kiSRGgpak0OEHbyfbtgwNLZs/JIpX9K?=
 =?us-ascii?Q?/T1OeyqkRh+XahPkenxjBq1SR4s3wv4wQqC0B5pZzZi2LYA8CqEWDpYzY3iF?=
 =?us-ascii?Q?KPKcnf3sd3q8i8HHjJ2tg1heT3LTGT08EJXCpkpI2rCrz1fxyh8RrlWomipj?=
 =?us-ascii?Q?5CJCnjtOxRa0Ylr70mrV7F9voPBp3/ySK7ft1rSTNPpL3F1si4mztE6beggh?=
 =?us-ascii?Q?ZqwQ7qSDo0ga2EpQ543ecuoFufrezMt3kJtDlzfLwFX86xRKmJjnfF1BMwJG?=
 =?us-ascii?Q?7MMscmZ5afBcw1jdMouyuzhHwPzypfQrgwyvOrptjR/JGlMKw0NCNB5pkT/j?=
 =?us-ascii?Q?HkDSlKmQ/Lq2bE/W8FbcQVlmfRgi4PYi1Wp1mlGzc5QrewWuivuoW4+Y/oga?=
 =?us-ascii?Q?HHdYaiPlhITFJUmQcnfZEAxDP0HACUL5NvmyC7n2yUdjO57De+7oyeExUCvv?=
 =?us-ascii?Q?h/2JD2cR4qpT6iS4I1gchCze3tm0adeae8Wr++Sex44iYL7RWgtNuXvNlAyy?=
 =?us-ascii?Q?k9aMJK/PokmeseZKhr6L8AApu34IfznWnh3gxdWX2ND4Hm4cSKj8iT/eUQVN?=
 =?us-ascii?Q?kM5Qyjyt0bcY7iWm/P1R4aJj7GGAvyvxRiA5SzcH/CtK8UsAaFgrsttZBCuB?=
 =?us-ascii?Q?5+/jXgKoIOR6u9sLbO9h8G1RBfvIPappONUyxm5UiMTZ9kIVJdN7c590ROfo?=
 =?us-ascii?Q?x8By3uewSxTzNSD49LHnLKCp51wbyf/tf2vrc/TfgbTzd7UPAfbjH8+/TJzG?=
 =?us-ascii?Q?KmUT90MCCghMbydcaw/NUOX/O8lhhW9Un+YbQu10flgsVYNZdyYYnpgf44Bm?=
 =?us-ascii?Q?86tSwIpdZtSTAVY/yFE19KvlKIGHzVoGj32CkES28Ldc?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452d7a21-6fe6-494c-bf0c-08de20f9c088
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:10:18.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARa3SvFNKn3wXGu7bDbxi2pfcoZscTF8Woo0l3Jo2rniEtrVMT6EwPEABDWB1aNleHxF042PJ3xu69ZU+cL+zdPZEa89IP/MNm2H01vSj/WgNEk25X3boNrnDOxGRaGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5669

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The OCRAM ECC is always enabled either by the BootROM or by the Secure
Device Manager (SDM) during a power-on reset on SoCFPGA.

However, during a warm reset, the OCRAM content is retained to preserve
data, while the control and status registers are reset to their default
values. As a result, ECC must be explicitly re-enabled after a warm reset.

Fixes: 17e47dc6db4f ("EDAC/altera: Add Stratix10 OCRAM ECC support")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---

v2 changes:
 - Add Fixes and Cc tags
 - Retains Acked-by from v1 patch

v1 link:
https://lore.kernel.org/all/20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com/

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


