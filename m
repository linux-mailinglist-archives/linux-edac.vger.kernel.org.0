Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7443B20EF
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFWTXC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:02 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:51744
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230037AbhFWTXA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7pfTTf33WC7yYEw6s0b8nU73ut6cbtZ78B6X3UNba2WXYhXVPK8NJ4jtwDIsA7vY7HQ7iYStlrDMIvW+/dXjZXuu9V3301IfyOxo+MUqQilCvyI6DB/DDYbnIKj5t2V5fGanIxc+yhv67iP670X2OPJAew5xM4vB3yRlftM1DUkh+QFWOsVHpD8pz0Phsyo/XUxZlCBonc/3IkxTRqkWcaKwEEqmdLZc6D41vcCQgRiUOHkNZ6UTE9bYnQEuPK0LZXycwJBMZQsm0GamlumAMO8DFkc5aAe43aSE8oNivVRYiPomkc8NZkLyNKsXSqx4THSTc+An1bdA85USdR/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKYtlWoUUoudcsoq1z4wNLahWFDEe/vmixTAREwzqr4=;
 b=M0+kF3GtJK20dMkoKPIwyARBAiJzmWExJd8A0khNxd5gANnL1XJH+LfqF8kvEqMo5XzFlYe88IKfCjSvL35FzuweWIGkzQ+1wArjtxSi/v5jtl+DRuvYu5O0jMo3MMHoCJQ0UXZl6k8zeTjguZGc1AdTZm0kx7TPRnEv0+9nKXETTjjDuDE0bgPcUBCYz92c5mdQ5jVcXg2Vg/NHLSik+UGt/9MuRWmkzmGCWY5Spfbf3Yrt+MGUrIPg+N4t1obQnXTJfKvfsB1T8rujIzZCmGhajoIxapqzaoUtW9SmoIKquC2J+zgX6q6X5w81sbnTSZ+Q78IjSjV8QmGBRY38lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKYtlWoUUoudcsoq1z4wNLahWFDEe/vmixTAREwzqr4=;
 b=VMrZPg7FYZaN57Zd55kRor/oZaiuQacizlTcImOn4l/Prk7PARiAKqKg50nHLVtuJ1C/cALxu4XN0TJ6LdpkazGBE+kZdnzONROlTJYzbg8SE5fQEepgU8XnKb92VaMZ2n1VMpDQUEYM/9x+ZJJtCxTyzeOLBCIjMRdOiyBB50c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:42 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:42 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 04/31] EDAC/amd64: Allow for DF Indirect Broadcast reads
Date:   Wed, 23 Jun 2021 19:19:35 +0000
Message-Id: <20210623192002.3671647-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5cebf7d-8873-4558-4b1f-08d9367bfde7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187E56A062CFACCA04624FAF8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAeiFeL1p7uScyshvQ9lyGwh0Vyn905PfBoyVH2U2NdgUjwkVjC55G3Dx3yz5RX4Ze8Sj/KNbuh5QD9TDVWE8lek7zBinP2rpG6abNt0HLoBmsmNV5JTpLQuHIQkmY8XqvdyBg1EfILGriT7e7njv0Lb3EVPB5U7S5bqTc5T3VKr5V4Aj8ce1JABhFbLKUnhbSohPWpAgya8vPVuefao/Y+S1eEw4GNE5kA1fV9HC28qNyqxoROn24VrMy976KUMW2js9OSxjULqIRgPc6P41CVonqKKZRqagZoCLCvSceINcoKC2+/AgxJ6LZnsLzcPU3CjvCqqPeCLL3DW7rqBhgpUJ2x5SJpuAflPICg/04uflDc3FEAFAyThGSNc729sV6XadWsMCblxfYP8caoD4SFodsjRCRXdQYCUTB63ysj3s2YrCAZ9ZxVRr/k4NOadfRZbR8llxDurlzdnrxjrxZyPaGRW+hAPDE322gVzF6VG23LmxF2oKo1LTB0XNkjdOycFVmhyDKM+rkM4Jq+aWDaXCfPcKKx2w1qTUnotFxrDnkms/UlIDe+0A3fYDM9z8IzHjLnxH4ITreiGmELXLBdWQBpOUDY0vKaSZhzv5RslWUX8x/UbmPExinM6p4fGncZGAuEdefJdLRbpuYThWsOFoyQqL3Ru+VMDyXVh2/aDA4zRFe+kjvU5i2ZXvqwh6ag6uZe165guLjz4qo0fDUGNoMkHmxqD7wGWQMZ88Xgcv4gvTWH2PnsqdOj1sBMazsyu2qkxci5PV9bcDH2cH7wAMwXlgPwEVmWQ50VFxuerMsxgDCmW1IdAcBV4bzFjCdFaT8VGv9EOneKKftLP3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrP/SQqsp4TylvPCPAwVmlElbnkJSeQzbTzcCfYr4uXhWZVOA/X2c6hmmnYl?=
 =?us-ascii?Q?th2assajJuQc8YsP0bzQZlL95aa8kDMu8jPKw5mkQbKJQH7HQtx2yCuigCDi?=
 =?us-ascii?Q?ZIh/gzmuP4P1XdsrnhEzqRvj27Mdtl6ZnBjGOZEjZIkJxY8COBaYl31Jza6+?=
 =?us-ascii?Q?hcxZCrrywW6R5lRHdAL7JjuwHpOj0TQTNmsMoGbWMOMRF4hjQMKqrhNbZvAa?=
 =?us-ascii?Q?w3j/xj2xG1lzAGL4L09bmfJBunyqfTXA29CsGf3tCK4jnrbi6UsxUxYrVNO4?=
 =?us-ascii?Q?gCpy2isCf4+46hA24KDJBeeS8Bw+Me7vyqap4AW63JDjb2pmRM2a7IOFPDQc?=
 =?us-ascii?Q?4wxcwqZoilEh1yAyzMBEI6L4ZkuRZ73H+Jg3TTQ3fJaVu3u1rYLq8Q94GBaK?=
 =?us-ascii?Q?fE4wFQdzQkC71XWe9mfaPRfKN9iRpqAItkvnOBZAIbbkq47WFJv0r7JpwdxR?=
 =?us-ascii?Q?LqlLOWqXXAmsx2SAm2OqehZW/oDtN6qsB4DUR/qTjtNgnLsv4GHGNFGDhXGh?=
 =?us-ascii?Q?Sc0TToqSYLFcQEtBQLlPWtSpW6G+nFfKR0BKSVOLIk6sV5oDjb+9GDxFlaOa?=
 =?us-ascii?Q?rPYwVUFvAChOkGQ6DRa6CxxflDP3OEBopBH6eXaDvw3ca+IyqPaFginQQYyg?=
 =?us-ascii?Q?L3Uw4Zbjhvc8c4S3lzDCi3B90OUrwRekyUuWUr48Pg14Aru+YmTxLwCuH3Gy?=
 =?us-ascii?Q?7gIdAzB/+1uB/ydmCKO7Vw81JcTclE17J/Xx+/dzoJjfM5Hafn4mr2ybqxe8?=
 =?us-ascii?Q?bqSKaNvvpo88D/9FjFp+lKKMgqGD7jgtOBeOBNsHL9Xv/9VeRATkUm4P7heM?=
 =?us-ascii?Q?Fv65zpfOSjdpdf55n2uzaluTHOrtShO9cwpvJwzYis+wg/Qbj1bQazSBWcMb?=
 =?us-ascii?Q?vR0aFUZ+Ty0yr6JrcjKihwQsjrTOR9kwd44R2W9bdLR564x9Mle8MK/Bc+d1?=
 =?us-ascii?Q?OlhwyGcCqUitERJPMFaEKsQnetRsw1VLFqpRFJq7x/RjyGXIbWFj0J5EEIaM?=
 =?us-ascii?Q?0qGUsAgn9qMI5hDAT9nqOhvixk570B5DE97RroH3eadMjk2e0lbPlbuLLu/G?=
 =?us-ascii?Q?7vvx+olqyVuYtttxL4GApCCrn2T7elnFkvaf3y6IaAmO2+y0uYLxvaeL37lH?=
 =?us-ascii?Q?MmxwwylNNssGD7Jlm4VLWFpKVW2PjTiyHI8TlsPVPcUud6nTDOPQqaNbpZ1B?=
 =?us-ascii?Q?n8H2n0eFPNM1OnEXlR2vheGsIWImQbLzdnacswQAWqI47M4cuHxnNys8HQ6P?=
 =?us-ascii?Q?qJBqrRy9OLR5VqiTqvvkWMqlfOUYbByKkho683N2sQ6jhw4p4CXC31UNNrg9?=
 =?us-ascii?Q?uxi1y63PbBMYyEnvZtuTX/Hk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cebf7d-8873-4558-4b1f-08d9367bfde7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:42.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37U7pIR3XZeqXTjloFpG3sErtfGFIl0SdmkhcWGnAr6y6Nj9cK8zdm9qRwZBtPBD2qEP+eMcupD+Q75oGvRNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The DF Indirect Access method allows for "Broadcast" accesses in which
case no specific instance is targeted. Add support using a reserved
instance ID of 0xFF to indicate a broadcast access. Set the FICAA
register appropriately.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-1-Yazen.Ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b94067e3952b..d67cd8f57b94 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1010,7 +1010,11 @@ struct df_reg {
  *
  * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
  * and FICAD HI registers but so far we only need the LO register.
+ *
+ * Use Instance Id 0xFF to indicate a broadcast read.
  */
+
+#define DF_BROADCAST	0xFF
 static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)
 {
 	struct pci_dev *F4;
@@ -1024,7 +1028,7 @@ static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32
 	if (!F4)
 		goto out;
 
-	ficaa  = 1;
+	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
 	ficaa |= reg.offset & 0x3FC;
 	ficaa |= (reg.func & 0x7) << 11;
 	ficaa |= instance_id << 16;
-- 
2.25.1

