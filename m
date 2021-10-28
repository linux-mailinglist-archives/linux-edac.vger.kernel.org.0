Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCCB43E7A1
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhJ1SAl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:41 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:2369
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230520AbhJ1SA2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3yMxIqUn3zlqdSdgdFzezr4VUrlCeUfp3dRugmia+ob65/J/berm9jgSiCEs3VNcamLi1wPB5puouDXvVLqvA+hA3pwA0M8SDubu0bvBn+Al6b+EYdeXnKOyD3aXJvnd+bnSR2jLDXoom1GXfkwew4luxE5K7Kdt8dGbdnaRq20T/Pxfl/hGw6/g58fcEE2cZzIGB2WNXdXHgx3XtkbJBxTGM2WAnhxtH2t1TOR2oUiz4P424sHl21VgI38ZToC8inP1cknuvcMkanAnhylviKtVz7v51GiQ1l7xQMywQLRpzi1+2P4jV9UpSnXyycprpOTzFj4UQWR8TRDpTqiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/NcQFhyp8xDbGgRBbJ3+Czk61O9rmXPqueqHaVU568=;
 b=Mxr0k9ZAcfJt9CuHHDPkERv6R/diteq+dPMS0DZMnXuoMCEKSwjHMjqcqkI/o7oBv8NHgMkE69j/1VbnJZj9KJK9ZuLl/EthKnGveEmnGaV52J9HhAsR8Wy0pDuKBHA+ZoE1QBTffUGLwaF5BBJIwUhzSC1G8eUbXlrCNjYJg8k0NnZpx5/l9st7Rq+W7Xiw1vhtwZC6ooJmb1iZ4BlGE0prHDCKFi3dTMz2QS4+vWurXhVpgwNVFTVQFMxqkXP4YY1P5zQB+W27idyDio3vFOXqCsEo68owMF7HCm/VxghKNt3sa5uBLxzYIrem53jyYPnpeqApg8Ol8d7+XnB87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/NcQFhyp8xDbGgRBbJ3+Czk61O9rmXPqueqHaVU568=;
 b=s0LAotJOueb3Hxto7UWnpIFKFDWXR7cxw4m/Lp1nTrJb/VP6qkAD+cHHsSufHmDEdqu+UfI71CJg6BHX/URksqcuxpppYs8KjXslNNiQRmEw+g5sVsN90dyqc009U7fcwAt/P14eGsc51OFreIbEszPLq9dckR+B9bbZdOKwQEY=
Received: from MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17) by
 DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 17:57:58 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::74) by MWHPR10CA0007.outlook.office365.com
 (2603:10b6:301::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:57:57 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:57:55 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, <x86@kernel.org>
Subject: [PATCH v3 02/33] x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC
Date:   Thu, 28 Oct 2021 17:56:57 +0000
Message-ID: <20211028175728.121452-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589a151a-5737-40be-af2d-08d99a3c79a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3131349BF5E61E801BFFF45DF8869@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0IceAySDnxqhFqwAnsiIG7yNus81XoMm1ddyxWgy5/G/po6HlYUASAs5uhc6bVE3hrV0Ua1PlxaIm1srw+sCm+ZvPC+1qyHcEgzjZJpkd3pqOJEFm2HElxaCHpHN+AVnavNirS1lAfV5xP3mRwMnCYZeHpgKxy48odXEggDD5R+fWVKCj+UaQdxy0l/FdjRBQafSgp7i1q/R7U7BVwTiatcPkn36RVCxLikvhWh08hCTUcbUs46nW8g1GMMYThej2TSKDUcj09LdFCXYAEUU+igCCL7H39mERmMQeD9XZ22CcNqcY/q4yrh5MME984WTygKiZjp0v4aj59/jQgKq9GveAIADFW9Vt1y7geuCM8btzYfNRUr+hjZylFnKgypwZG+3HZ5P6VyWdyXO20uBHlmfrFAd3bm2vA3G5CdiCUyjpGGQi+2gGD33GyCnylu86y5/2Tsu384XXn/22HWxn1vub2KR9vAg6lV2Xd3xfv1KwXOOBLOEoL3cc4P07kjwHovs6LTgMgU0tDYF511WsoQkTHEM5/awlzitwpUHqLlFatvOAJAbs47b8E5ldUulruJD9DNojvpLjsMX5BG0enCDx+nR0isNaY68D73JUye9m04IkNw0g28os+Bto1jYlcsbN0fes8aKbnPU6FBOOmlI60wiTYJ4PpVXW/7tze24uwqS2IjmhShHnmF8DDwX6vusIblYJYAQ/ZgjF1hNQWZXIDlpSvA15B/kGd1l7rp6/E+XgPzkqaaCg5dGAA99wrgUunZvXyA+9rqa8uFGfYyt9ZVC92gOSOeQohuaQ3eC0cz7UoRQimTwqJKyAOx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(8936002)(44832011)(36860700001)(86362001)(47076005)(2616005)(4326008)(16526019)(82310400003)(336012)(966005)(426003)(36756003)(54906003)(186003)(83380400001)(508600001)(70206006)(6916009)(316002)(70586007)(7696005)(81166007)(5660300002)(356005)(8676002)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:57:57.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589a151a-5737-40be-af2d-08d99a3c79a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The df_indirect_read() function is only used for address translation.
Move this to EDAC along with the translation code.

Cc: <x86@kernel.org>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:       
https://lkml.kernel.org/r/20210623192002.3671647-3-yazen.ghannam@amd.com
            
v2->v3:     
* No change.
                                                                                                                                 
v1->v2:     
* New in v2.

 arch/x86/include/asm/amd_nb.h |  1 -
 arch/x86/kernel/amd_nb.c      | 49 +---------------------------------
 drivers/edac/amd64_edac.c     | 50 +++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index a78d088dae40..2ccac1efe1e9 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -24,7 +24,6 @@ extern int amd_set_subcaches(int, unsigned long);
 
 extern int amd_smn_read(u16 node, u32 address, u32 *value);
 extern int amd_smn_write(u16 node, u32 address, u32 value);
-extern int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 0b495406ab9c..17f4e6e25613 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -31,7 +31,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 #define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4 0x14d4
 
-/* Protect the PCI config register pairs used for SMN and DF indirect access. */
+/* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
 static u32 *flush_words;
@@ -247,53 +247,6 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-/*
- * Data Fabric Indirect Access uses FICAA/FICAD.
- *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
- * on the device's Instance Id and the PCI function and register offset of
- * the desired register.
- *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
- */
-int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	struct pci_dev *F4;
-	u32 ficaa;
-	int err = -ENODEV;
-
-	if (node >= amd_northbridges.num)
-		goto out;
-
-	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
-		goto out;
-
-	ficaa  = 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
-	ficaa |= instance_id << 16;
-
-	mutex_lock(&smn_mutex);
-
-	err = pci_write_config_dword(F4, 0x5C, ficaa);
-	if (err) {
-		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
-		goto out_unlock;
-	}
-
-	err = pci_read_config_dword(F4, 0x98, lo);
-	if (err)
-		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
-
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
-}
-EXPORT_SYMBOL_GPL(amd_df_indirect_read);
 
 struct pci_dev *get_root_devs(struct pci_dev *root,
 			      const struct pci_device_id *root_ids,
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b87aa38803d..28c96fd06019 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -986,6 +986,56 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/* Protect the PCI config register pairs used for DF indirect access. */
+static DEFINE_MUTEX(df_indirect_mutex);
+
+/*
+ * Data Fabric Indirect Access uses FICAA/FICAD.
+ *
+ * Fabric Indirect Configuration Access Address (FICAA): Constructed based
+ * on the device's Instance Id and the PCI function and register offset of
+ * the desired register.
+ *
+ * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
+ * and FICAD HI registers but so far we only need the LO register.
+ */
+static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	struct pci_dev *F4;
+	u32 ficaa;
+	int err = -ENODEV;
+
+	if (node >= amd_nb_num())
+		goto out;
+
+	F4 = node_to_amd_nb(node)->link;
+	if (!F4)
+		goto out;
+
+	ficaa  = 1;
+	ficaa |= reg & 0x3FC;
+	ficaa |= (func & 0x7) << 11;
+	ficaa |= instance_id << 16;
+
+	mutex_lock(&df_indirect_mutex);
+
+	err = pci_write_config_dword(F4, 0x5C, ficaa);
+	if (err) {
+		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
+		goto out_unlock;
+	}
+
+	err = pci_read_config_dword(F4, 0x98, lo);
+	if (err)
+		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
+
+out_unlock:
+	mutex_unlock(&df_indirect_mutex);
+
+out:
+	return err;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-- 
2.25.1

