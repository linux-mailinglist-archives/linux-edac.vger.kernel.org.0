Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8933B856A
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhF3OxW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:22 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:5600
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235733AbhF3OxU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frlWmHewZ/58hhY519tBYrY4Z3SL7QJpXCcHfirKeAZixsIvXCU5Hv7iJutNgiUNdKoXmnGfCfp8Hpjy6K6/yxKOeZuxzZrpw8wT7GI6fsWQO6UfTSVdr7vDYkf2SBmi/ZT4TrAdtP+omjpi1TC3F7EF0dF0mSHcbawtBZj9lNsmcz1WFbLqVflcKdAxBYBVW2Ey7ZB7XmxVag0iaLqFoqI80B3Ta25l6mt7qc4RTyKyTkFsfZqNSS41lZ0/xLjVnmSsMdjqhxaqJxWiZDTQUv6kJlJA0v3YU4Hw4f1DJsmp8QJspfj1y+EBshdA+O6RT1aV0HyA6VxpAxG2XIizRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRmHn+xVNdSaxeineYIlHRI9AaCnSK57OhoescDpoQg=;
 b=n9bd8NFT2wugnqEz5wWzKMCtu2KgWm6MpT7EOZfpaKe0Dmo29te+6w6ShKbWMJRK8ZpaMW+lXvOCE65l+SHPRpzuz9R+q+fR29QxcpqJQT273fJDl2FzhO9BTFlhIq08SimcEGoZVGif9rj3JXH4x0NSP7HIwJH8GIAn6fnNg0CfRuf+/Qc6vWYk44YGjRn6iEanaAu8E7vv60Yrj32Ao/yXhUrApGkxBTQvlr+Kg8gzaciJJ1x02rTOGF8Glax5UJP6jWIGWB/EZzT/apTSC9jsPyhVCz64jd2nZ2OM7zjHrqcPJZGHf27WSz+XJ71683hzn6ZxU9Mc6gDK7CHUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRmHn+xVNdSaxeineYIlHRI9AaCnSK57OhoescDpoQg=;
 b=fLslakFn1Eub2VBKsnyqhByfpPSno9PLppJnzlWUM6Tlm35bn6JytEVqpeMXA0QG4RRZvNuVw8TAK+dDduASFGRV+dzIkb7gxRM3Nee3S6usrQDDTHzILwtaEGcizsrd9ZDWChEILWm8gfeewlhbG3mAomRiQqVBtWirk/AVvbg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:50:49 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:50:49 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 2/7] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Wed, 30 Jun 2021 20:58:23 +0530
Message-Id: <20210630152828.162659-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13fd25ae-731f-4710-cd27-08d93bd67332
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB504563FF9422CD7D50BE5DA0E8019@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Yc/sEEK9/X9mXjMj/TTW4bV3kJTQZommRJKlp/FDg0pL2XA3pDROBORjsZC/E2TkM/1/Cda/QZWj2cQHlSzVc0XWXOaRjpM0A9d6ygsXgPLOY2ckwG9Nb53PMHidHu2vK+LSLQNe42uochUvxitIPXkX0z+kZtjOPzkNVa3UTHAre1jqb5PmsFL9rAjRX5PL/A5A1SpQVwzddwOG7T/hEVoi9FmezKWf7pWZu/78Zr7ks/ZFoQZhfmHV8Cm8juKby6faedcWGdmv1xDDEY+QHalPwlWTMe2yTAcPCN1KHJiBDXpGS5qa2pbRtUgACF+ycegNs4fyuiJ6NM71vaDyK9IxSQcNTXEFA8FmAU4dekGaleiB9OW4/40WJedN6DYKFLvsL8z8sK552XBxumI5kqerX/ANS3WRXs9hCg5GGzwB/H5jumyRwf+u1k9iwqGHSbic4Fo9rUezYzOzGE84ToRzz133EJRKnSutn26sfbOqq5CSau2FarjmN/fWXVCHTCc5smkX1iImsMMjK5oho3x3SOuWFzatjsQAiPMfLDp4HD/B0g6s6yrnsEioy5wROpj6ZGSBQCb9ElU7WGfmsKagyy0YbSdLHwf1ZPKnir4u3//nIaQ8gU6/L97AV4XD+tl4kLXbxWcCeKREiveRC+8OvS0xeP8uM7TFkshbX0YdqfigcRFZbf+LVmiOUmhgg+eRHk78205Z77ZeEytfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(36756003)(478600001)(83380400001)(6666004)(52116002)(26005)(7696005)(2906002)(6486002)(4326008)(66476007)(2616005)(956004)(8676002)(16526019)(186003)(5660300002)(66946007)(66556008)(38100700002)(38350700002)(316002)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwinvCKr7lsyU7qZhecfWD4lGtIIYW1yey03pRufPR9Tdo8xrYYK1p9w8hwq?=
 =?us-ascii?Q?3w8hIYpZtdNtd4kmtzBa5UBRieOBwIiX21vSbKHV7hdNh9yONUgJU/H6HwhH?=
 =?us-ascii?Q?8HebuxA9ynkVX9x0wCT0YTEf0SttW3E+ML3hPbNr5SO2sxrmoX5/oFRBkd9W?=
 =?us-ascii?Q?ysiw0nV8U+iYqIJ1JT9AqYRkJzYLsO7Y8PQUmAuyUAfMGL4B1Q1Q/wpLnbLD?=
 =?us-ascii?Q?HIhVqR6wRb63l5HHMxqYUD61rqCOmUi3HNoldSYpdhCfOFYVqsKup38PLcdW?=
 =?us-ascii?Q?TeffVsvpxSh8v4BCP/ulglKCogb7Zsy6zhInElvuUJ/iRLPKbY19P6V2wqHN?=
 =?us-ascii?Q?+ivs2L4yy69HAAgXXYy0TWmyCkZ/PKAQXYGji9McocDw/2XdeHxelOwaruRA?=
 =?us-ascii?Q?PJAYjOzHE7uUoqiwsD6Ig6R/72fk4qhDudkzbBjVm/iq+K+ujTWQoisIK7Vr?=
 =?us-ascii?Q?2Zd+sXq3chC9jmPJcs4g0aMTpNs2tbr9X9Wn99ZNonBQlXMjL4DI1qA73FAw?=
 =?us-ascii?Q?iOC5pt5lQoPjsr3lRX+HMfoOkb+n0jB8zUaHX/iyKfcRsWYCQjI86K+OvMWf?=
 =?us-ascii?Q?cUiLLVhO+kC6rfPdMwpTZ20pVHEawesjHFFSwJFI+E1Gl/Wiem5S46n4mlDc?=
 =?us-ascii?Q?ZdlKweTaz4hyz+/Il42htrdoOnyC6VYJHGZ8sqnw/cOxJi/ZUGkI2d41FY/v?=
 =?us-ascii?Q?stR6zyMheJ9h3PJwX1Bnqw3ZJMBFoGNFunQe+QgdL/+QKCpvZKw0YdmShE2I?=
 =?us-ascii?Q?byo51Bf/7csTJzty2R5vQ91JXuqMiUG6iPuzcs6iLotmY8LHBEiqiSFDlVmF?=
 =?us-ascii?Q?4dONwsYTOaNBRfOJ5Y68ETdjVidq8xnJ5Y0Ex2WpA0JHtGFpw5EoBZG3dvw4?=
 =?us-ascii?Q?k/nErAzNy8gFq/ZILRZuJCxmG7NpKmLlRlCAOxGe+WSVeyOpEj8KmgeQmP2T?=
 =?us-ascii?Q?ez/ZPXrV7VDjxFwKgKE8ZQZyjvcL53od1WtFSpLIGmX0Dgeaw8VWcvdSgLxI?=
 =?us-ascii?Q?PrNotRmE1mttrl7AURAK1aK7DdVUum0okpJ4lvJwAq7H2zCJ7yZBzATBxjZg?=
 =?us-ascii?Q?L+wNJF3UY9/cYUVV00KI+sVMkhAf/nMblUSKqF/VCTNNgq1D5/AlQUuI48d2?=
 =?us-ascii?Q?cASnXRUqjcsQmECj9jGuEKhJt5xVvIqoGtH6Md7EDqTVeoRrwM66QN5K708j?=
 =?us-ascii?Q?RB/qiMSQFUSHWhwtm+7BRSwYjYwgNztSSod/eRH7Iaehd7xjoZIePowCKriG?=
 =?us-ascii?Q?8B1pbA9mtQQiy+Z1jooq3l8gUxYS7eRF2gwdfDjFH5Cx5aw+Bk4CnDkMaUjZ?=
 =?us-ascii?Q?JORV7FVHxqSoPwwu9FESuxIm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fd25ae-731f-4710-cd27-08d93bd67332
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:50:49.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUW1+PDp3DIkknJRb8lrAUodopL5QJDnDlHR4ytDee6SvpTvEnhO+2cb3YyfolQeHGtXMMVBHI/06mku5OU55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On newer heterogeneous systems from AMD, there is a possibility of
having GPU nodes along with CPU nodes with the MCA banks. The GPU
nodes (noncpu nodes) starts enumerating from northbridge index 8.

Aldebaran GPUs have 2 root ports, with 4 misc port for each root.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 arch/x86/include/asm/amd_nb.h |  6 ++++
 arch/x86/kernel/amd_nb.c      | 62 ++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00d1a400b7a1..e71581cf00e3 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -79,6 +79,12 @@ struct amd_northbridge_info {
 
 #ifdef CONFIG_AMD_NB
 
+/*
+ * On Newer heterogeneous systems from AMD with CPU and GPU nodes connected
+ * via xGMI links, the NON CPU Nodes are enumerated from index 8
+ */
+#define NONCPU_NODE_INDEX	8
+
 u16 amd_nb_num(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 5884dfa619ff..489003e850dd 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -26,6 +26,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -94,6 +96,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id amd_noncpu_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
+	{}
+};
+
+static const struct pci_device_id amd_noncpu_nb_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id amd_noncpu_nb_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -182,11 +199,16 @@ int amd_cache_northbridges(void)
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *link_ids = amd_nb_link_ids;
 	const struct pci_device_id *root_ids = amd_root_ids;
+
+	const struct pci_device_id *noncpu_misc_ids = amd_noncpu_nb_misc_ids;
+	const struct pci_device_id *noncpu_link_ids = amd_noncpu_nb_link_ids;
+	const struct pci_device_id *noncpu_root_ids = amd_noncpu_root_ids;
+
 	struct pci_dev *root, *misc, *link;
 	struct amd_northbridge *nb;
 	u16 roots_per_misc = 0;
-	u16 misc_count = 0;
-	u16 root_count = 0;
+	u16 misc_count = 0, misc_count_noncpu = 0;
+	u16 root_count = 0, root_count_noncpu = 0;
 	u16 i, j;
 
 	if (amd_northbridges.num)
@@ -205,10 +227,16 @@ int amd_cache_northbridges(void)
 	if (!misc_count)
 		return -ENODEV;
 
+	while ((misc = next_northbridge(misc, noncpu_misc_ids)) != NULL)
+		misc_count_noncpu++;
+
 	root = NULL;
 	while ((root = next_northbridge(root, root_ids)) != NULL)
 		root_count++;
 
+	while ((root = next_northbridge(root, noncpu_root_ids)) != NULL)
+		root_count_noncpu++;
+
 	if (root_count) {
 		roots_per_misc = root_count / misc_count;
 
@@ -222,15 +250,27 @@ int amd_cache_northbridges(void)
 		}
 	}
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	/*
+	 * The valid amd_northbridges are in between (0 ~ misc_count) and
+	 * (NONCPU_NODE_INDEX ~ NONCPU_NODE_INDEX + misc_count_noncpu)
+	 */
+	if (misc_count_noncpu)
+		/*
+		 * There are NONCPU Nodes with pci root ports starting at index 8
+		 * allocate few extra cells for simplicity in handling the indexes
+		 */
+		amd_northbridges.num = NONCPU_NODE_INDEX + misc_count_noncpu;
+	else
+		amd_northbridges.num = misc_count;
+
+	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = misc_count;
 
 	link = misc = root = NULL;
-	for (i = 0; i < amd_northbridges.num; i++) {
+	for (i = 0; i < misc_count; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
@@ -251,6 +291,18 @@ int amd_cache_northbridges(void)
 			root = next_northbridge(root, root_ids);
 	}
 
+	link = misc = root = NULL;
+	if (misc_count_noncpu) {
+		for (i = NONCPU_NODE_INDEX; i < NONCPU_NODE_INDEX + misc_count_noncpu; i++) {
+			node_to_amd_nb(i)->root = root =
+				next_northbridge(root, noncpu_root_ids);
+			node_to_amd_nb(i)->misc = misc =
+				next_northbridge(misc, noncpu_misc_ids);
+			node_to_amd_nb(i)->link = link =
+				next_northbridge(link, noncpu_link_ids);
+		}
+	}
+
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
-- 
2.25.1

