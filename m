Return-Path: <linux-edac+bounces-3746-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375EA9CBA2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1CC189E134
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29917255259;
	Fri, 25 Apr 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GGtM9me5"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416C1E519;
	Fri, 25 Apr 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591214; cv=fail; b=R7wMj7jAGAdGox6mikNYkKC4L7+OQB4Y7JkQIbDfTr4DOxOVUtiJ/e4V2x5cNpS1Co3g+jZie0cSJ2XFxnYnVyxTStFOlDLWWs7PSyVmMEQdC0ojmwR0G3IwLW0smObFOemfLx31dJ7N60Cqju4MO4hhPWsWYIbWxt6Ha13L2tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591214; c=relaxed/simple;
	bh=ii/ZRy7YCksaiW8E633PAb3esJzIoeryt+ZR0Rp13mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p74FaFL9VMb6srLwp2MFMgFnk02A0tMtU4on9pBsfRAameJtybgkSCSeoPDkASrusem0wSKTjP2WEFlmkPiuBLuvd9OojQ4X2yE8WTHb5vjMJ+LdPEPpzfjIe1XqylxT5XV89Pw8SmNRJ+9338Z4GvdPTdMvC5NHj70Ao11rTVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GGtM9me5; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgzZLoYXrszSRZwST8J2YP3L2M/7Qv/+sysW3+PSufqxqguYnwO77l+dP4Bj4krHyhaPFafl229W3TQMLc7XjF1P1opEWHI8LE4VS6L1D7M5LadorcPfmAsndmgq00VAY3JR8xDEOfNqaOMCg35UZ1nEsH5dMfJFKyKmGd2X29gxYEDBwIsyFD3DF6OwlKEgp2Oo5GOFpU98FRdbZ7hcuVxgVuFmpVMEHGZYWiBXMH34uLnuXbAc7NaN9gZzEyaJe/0WqxWiAJp4wY68f96QXUriXvHyN6EaEX5ILf+HdzIDIeOchkHjHj9X0DD2RcOuVlwiGsD41QFFWciCe/cg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Kk0xlKQtGdSskDhCbwGn+OV7rFfRBYLn5Sn4K3Msg=;
 b=aePqdKN+BTaeg98zdC1ZjJeFfP365fvn6XF9IAPgvdCNDewBN9GAdTwPlbF6+6hn3LZWyzygqZznAYiwPY44hpWybEYYBgGYJGks3UujYEvOPACTxQBRdEceAtMJqBE7cNk7KaQ/8aax4K5c/hdYNG7sUTAJ9tKVDPEy0vcXtrlTExTHClgXIA3+WXnXC02R/g7nY1Rb0YHLJHSY6UPxEh7D7KyfOe8OP695xxKXLYaMvWj+HRDMpeyxS1iOS3jGYJegSaHz2ObIReJ24zAoNZGX4CPpEXtbKdSP+RJizWPdxwcUfXTwz6M8+BuFvT9LH1myh43JSDKDWTciO1DvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Kk0xlKQtGdSskDhCbwGn+OV7rFfRBYLn5Sn4K3Msg=;
 b=GGtM9me5ThWYtnaQd/zB4Hb1kIRnkIeU+eTAhZvTK3Dgu4IQQ8Eof9vUES+iH+ledIWEc/sBZPNH8Yo6GnlVRYhSoqHjdZeZsTeQAa47BgllrDqfqnDAD1VbHyCT7b8y0HglAVQevcMsbNJGmbWuvPTyyjds1HW8cTfQMRuKbnLDXx4Vd4Pn42RUNWEXbn1nR61zRUzgCQc/lm63Rw1fViRX3w2+36X2Pq3UWi2nQdepLCkBHunv6oSyNDm1Gvqe4xZybzQwMRWUL6ZUtVKBlmvQxihMghCYCILXoic3gWEzKENMDKz/sM/0NigFnXJxlpfmaa4MmBePlhh8vmofdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA2PR03MB5818.namprd03.prod.outlook.com (2603:10b6:806:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:26:48 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8678.023; Fri, 25 Apr 2025
 14:26:48 +0000
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
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3 0/2] EDAC/altera: two bug fixes
Date: Fri, 25 Apr 2025 07:26:38 -0700
Message-Id: <20250425142640.33125-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
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
X-MS-Office365-Filtering-Correlation-Id: d98ccf45-81e8-4cad-43fa-08dd84053640
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5h5tSocxxvKbpU1CZOyx4IkTwWIOQZW5s66jCuL1ZXPQt5f7Hc6GgYdmJa/4?=
 =?us-ascii?Q?6LoSKDQM62Hz9BsGrFfiHkYgruSRjvU5ulFdXtK+JcGZ/xuSsF/Dl8AlhAs2?=
 =?us-ascii?Q?UnEVGz4FieTr/PUBik+g3H/zIS+g8isaVfbDg5ciHQuTfNCo9gtrLiFGpBL3?=
 =?us-ascii?Q?Yihn/RwKJZvweWVO9uKK5OM2Ky5lPXR0JjK68X4ggAMwNTyn3mEwFVoBXk32?=
 =?us-ascii?Q?W2BL4mV2ycjFcZ5L16yTCKaguR1EjHlfBgUWKxOGo63Xpb5umOALrwDKJmH6?=
 =?us-ascii?Q?CBwN35Wn/yWVjUZpXdR7U5fkv4VifH/+4yeK4MdlGqouRyD9/zBSHXiSrZt+?=
 =?us-ascii?Q?nzH96D7ywM2mOV1x4jXPjB6fAggsgCXZI1Yh9gxklys1PbkGKw3a2bfNHJCD?=
 =?us-ascii?Q?PVOIUCNzW8nuuwmzaS3uPAAEBPGnUF+XYIwyKmvvMaRPDRB+e0aL+pKlMSJn?=
 =?us-ascii?Q?ZTI+qtTjk2D2/1ZaqtJUMpRk7hIH8LOkLUA/A4oh3Ghj+8yNRPCQ7+Fx0QUW?=
 =?us-ascii?Q?M4o1OWK0OBS7x8AqCjQlDV/HVoXLKlLNuRMfrvzidCbcWsQuZmkYY+ABvx41?=
 =?us-ascii?Q?osSi8HhSjorouWBGHBhLG3nbBWmUKNNi68jgJB61y4TIhTF01mk6lmWmQJx9?=
 =?us-ascii?Q?CFmhPAfepeYTDdUu3to0CV0NSGdb61jq7SLlhvWHMjk2X59yJZ9tSKfarKoE?=
 =?us-ascii?Q?3KFkqR93DSpjMX/JY4eFvJVapZOdol9lW4sPFGFOGYaqZUH2KE4tznACbsyH?=
 =?us-ascii?Q?6/+o5R/kAJkBroR6N4bB1GJgKc/AnjEw9DMvUx1marioSRdQ7Lz5Ub68LITR?=
 =?us-ascii?Q?7rToPMsVyRrBY4RPvAkVIX5qPRIFSqE6lR/VAC1SBDL8EgddcmYYtSEgXFbY?=
 =?us-ascii?Q?i3n6qxwckPb11pJZTvEFarIZr05sRFgXDA8E53UGGRMoPAMXL3KOtEY/7R+6?=
 =?us-ascii?Q?0p4M3pwXk6J1N5Q/3DEkQL2UUjELijz5jK2nOCJ9hBPUz6x44KZs0fsiQwYg?=
 =?us-ascii?Q?bOhs9U23zgOocbWrrkEueTEpFuh1AGMchGD+4FxLkvwzYGrsUcq87H5LwDWk?=
 =?us-ascii?Q?8O4rUXQ4/A6ZbN/jl5pRxIfHpvw/ZmZhI8Tuu5rvwt1GNbzEy4Jt8AIOJ1O0?=
 =?us-ascii?Q?yCxBD7cXZSTZ0IWC6sFqAVK1Bk9ncm+kaiKkPIfiS7wAmpG5pYywgormuAIQ?=
 =?us-ascii?Q?fEfXT6c0nMtWJVMYBRjFGfh5DwtHLaniCAmffzt/zDccMfTkTHDs2aiI5L8e?=
 =?us-ascii?Q?rZqfTNnxuiKIa/CjTC1Chu/yMqZAmjwWeDPZTX0v7aEO6RgTSub7eTmmig3D?=
 =?us-ascii?Q?2YqdpMZvQHoJ8PkzLeW71uLEpcYa9guE/tKkGVPloJbUqKqZPgdf4Ow6Fq7o?=
 =?us-ascii?Q?NPY0tZLvlvRO70GIhbPcG5hN9P+4f6PVZNpmHzYLXv34BOZOsEF4kLT5lvZ3?=
 =?us-ascii?Q?kJ/it6bKzv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOT87CDL3jXH6t2gnck+JknFBdX+hCAcKj6R/Udi3lAoOX9/wPy2TQEVN5Gf?=
 =?us-ascii?Q?anQ/+0yN82Y/cC8Hd9+MIln7qx9buBHeUN387RB5FHeuPWfft2IV2UX/ZzQT?=
 =?us-ascii?Q?Co9aJ26Hw9+FYnc0is+kcoYyfgqEUIT7hjVmhmGd0ONpmkNQdjWigN12VnJd?=
 =?us-ascii?Q?oetyHiVjCJhZ9bA/s5tkhXf819WRlh545UV5xCbYiodDPq1dAfwS+Q6x2Y2i?=
 =?us-ascii?Q?CDjZOv1qYKjlW7ejVFb1A8h7IBoT6CRxPCy+dyF5XlDEdoiXP1z554LDFGqV?=
 =?us-ascii?Q?TJM0Q5WtlNtGENwoVGViwxRt8PFQwbmqBUCXb/6faf+8ng8whIQblku8+Tut?=
 =?us-ascii?Q?nwghhp41AUPR53jal0QTjYpkdV6kZKKT1gRbtXo+tI79PnmUGsh/jliWEHoP?=
 =?us-ascii?Q?Tx4dvYzYACYgHMHkMxC/NqGtrdYNefBubTMqlHLsRTUm2ppkGtyxm8rRxw+h?=
 =?us-ascii?Q?A4RQ1gScEcqJjnWnjc67vvL7+Mwo4Qvb3SzbNZDMIWdtVr9xAtRRko2dcFrA?=
 =?us-ascii?Q?r51yT9twbaVRJ/QXsi6gSnw0lzHaOYcTGIp4jXu8a/sY5NpVMRuyT7sUwJHN?=
 =?us-ascii?Q?z+pmXXRkjCPgToz70SCG5Zogkgr4zm0nAmG77n/2NpOv4sXbFN3IEnZ1gs9h?=
 =?us-ascii?Q?lE/dt05KY25NXYUSJAULkn3zNa+LzvVCbOedYBszJvJw+4YMVRt9U8KGk3SE?=
 =?us-ascii?Q?c9F8m3BtGZIvnklS5qDDzNEhu0x7iNoxuY2m+q9wUDDRmUgnt+HC+RjeoHwM?=
 =?us-ascii?Q?lZ3/xHYO35UAFaXIjAXl8FBRHzA7CLcMYmNfM2Bn1V+kSbkPv53SeZ72fbfp?=
 =?us-ascii?Q?jZeiEhjYL10ZaPsWIY6l5XaBABVyxbJecRUlXEjICAsMxzAS+FxVnlb0LFsb?=
 =?us-ascii?Q?XGXsZtipGy9TW37cv1wVRC83APOmBmR6PQ6hgK16juDrywF+FRAs4Xt0G5zi?=
 =?us-ascii?Q?ct8yz/ecZj/wGJr0MhHTLqtuLU5BdE72f3za0oPLaAiRHmsKu/TdRvO0qHxI?=
 =?us-ascii?Q?teSfqdFyapual6fqRWnP0aBSxK1bA2/dfprlVvO7PSTHk1AvDWPXKIn/scSI?=
 =?us-ascii?Q?MHfo52D96DBOBWd11IXlcp8E7zogbLr3Vcb6BIusOsuEMjDbzSlrbV5bul+w?=
 =?us-ascii?Q?7cfQ9OaaEbr2pNdBjm0MaGqABJMBgwm6P1DAv3k+GcspX1+jQOwDIrM27hVe?=
 =?us-ascii?Q?2PJHZ1CJkjl+gSflQMt6gkSeMoDLsMIPOCKdPXGcuWWje3f/NQloJhIm1ZsT?=
 =?us-ascii?Q?lkbZDRG22H5QGwDMBC67x6oBOi7r10e/9jv3+4ZtTYYzrwUW2f9Wkg0fRbLB?=
 =?us-ascii?Q?3YhhrVWvh+B9H6YQeT5jY/uuOoqnOXYuC7z8S8kc2TWNJcxA3Voup1KV2lpO?=
 =?us-ascii?Q?Q91ocdSC1C26BJA0E0kvDHNx3lSAlTbi8SHPQEv4ot7Wo24y0yqcopBBu2qv?=
 =?us-ascii?Q?XXSUyyiKYZ7PR2ayi9QPzLcPQDnKHJhQXsLxVIlxB08FW3bogNJ3/XSINRAq?=
 =?us-ascii?Q?ANJBzUBhBWC+epXQ3FHOgZYQhryVM2O9egxIMqpLBnNE3WWtJolO8N3qnNcp?=
 =?us-ascii?Q?F+eGT1+JjHXdO+4bsPgnHUsHjJrG1Nfcz7+8au44ClTDa+0BjmSRs6FJushw?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98ccf45-81e8-4cad-43fa-08dd84053640
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:26:48.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7NWS035TOhGuypH4YprNC9fTCRhgVAenti6Yu9iJHrWrkPlvvVkhsdLYkvKl9auU19fYswFQZZfuBXa8ObQxXcK5ZW6XB7ykUOHU+O1fa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5818

This patch set contains two bug fixes for the Altera ECC manager.

Patch 1:
 - Fix bug testing the wrong structure member.

Patch 2:
 - Mask HW interrupts until handler registered.

Niravkumar L Rabara (2):
  EDAC/altera: fix cut and paste error
  EDAC/altera: Set DDR and SDMMC interrupt mask before registration

 drivers/edac/altera_edac.c | 9 +++++----
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.35.3


