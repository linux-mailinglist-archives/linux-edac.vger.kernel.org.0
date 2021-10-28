Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B905843E7A2
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhJ1SAm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:42 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:10080
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231124AbhJ1SA3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLWIRePkkqd2sYkg/HXYUzzFVfpxaMae9sfYrZcvElrQ3SEAF9WVq9xx431QWtmgGflWiKi0oHSmgXMYIxmKhT/3z+Zj//M6RWzT35vwiy8H5IH2i2MhDE9zM0+uAkJDT9di0Nvpp2b1wn6O9+xy+ezI/kkCd8d1djATBx+ocknvQdC/kwfAde9un7+eBjgT12pwWIn3ArFhngpJiiwXOpPwKCsjUM/XnBbuVtW/LMUA5ZlE2UQgV976y5ue/6zgY4220Yd1LtQwIZiJDYutS4KX6OD+WFnucuKzbjc6KVSS36wB5UabWrJowlekOUI2gO84Py5cEhUaMhkdRqrBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwWd7rziYJBxfKIKYPrc7UWdFVCHHjANRkbKyQTMNGw=;
 b=bfDXlGv3N9+bv8oF+1LsaUW26o2IAdbcEnuZ7EELJo5W6YziwKs3N8KxBS69e7U7PSzBwwCr+RLFDFkV8yI6OmkzHxPPNZvBTXaNwrImY/Dxq62uCjoXvsyKC8jJXs0cw3n6XCGhAr3PAYOW1ViSLR8n3xnXe4Dq41ryY9swQGR41JRxhxqEZ19/8BVCmmws9fUkUrBtTld8sEOekLeaF0DTf19ryJUiBuCE/WmfHUYpap/YFDPYCdnGOrSoER2iEPM05Ag3zvgdy5VmUmSpvtGxH0pFub0eJ6GFlpUSlvg6cqirV6I5sBmB9oVcuObfeCIY0RRpvO/op9KsxXuKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwWd7rziYJBxfKIKYPrc7UWdFVCHHjANRkbKyQTMNGw=;
 b=M0RPUuf+AIQIbU13O7zcX7YGYWyp5SKOHNR3RmhJYUw4qfujTWmYwEZRUM9YNke5e3TBq4WGxpe3uMTgIeLl0ODHTXN0A0DVk9pSnzw0RF1CX3EUoKwQZDDpabhnPwExE5/41w0GP6qVIqCAXA8J+gDX4Tqz/zYVaOgZGryctjU=
Received: from MWHPR10CA0020.namprd10.prod.outlook.com (2603:10b6:301::30) by
 MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 17:57:59 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::d9) by MWHPR10CA0020.outlook.office365.com
 (2603:10b6:301::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:57:58 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:57:57 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 03/33] EDAC/amd64: Allow for DF Indirect Broadcast reads
Date:   Thu, 28 Oct 2021 17:56:58 +0000
Message-ID: <20211028175728.121452-4-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0490f894-5b44-453b-a9c1-08d99a3c7a5d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1133:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1133A518205A7D20C573D721F8869@MWHPR12MB1133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CBm7N0pjX+UPaHxqFciMjuRsB5u3cDG6DPV8VCrJ71ys4podmG6w7+1zJ+00DtMZpEOxnqgnxzCFIVtqBdHbbbw131m3+PXpsItbRhCXmK+g3JuCerAoqgWOhVNAr2f+1LyEeqnk7iYyB3lLsfz1t1j4u/21/BjZmechh5yqozM7YipM9mX6R3s3LtfhsPqY1Zn9oSrfHDij4QQC1VY6q32v5BdVaZaHY6xlg7AN3Qdxrj08SGHAsK5wkWcCj7Ky9Z1+bKYTFz/39vd01/iCy5aIieOa/A5G0mkKy+xxY0DH3iIKYckvP/nV5Wu9NbPN3/4jTkcITc9hqt03+FIABFujhPNAMxRumJSUdGiGT5hZNbpnfL5QRkEuSeqB/txR61X0vzvxcyM37Rjsh7nyLo7JhazP7lWlsVyM4j6WuhtX87MmhefMrTird2tV8bpUuhwtkxxKLmcxZ1ibC0CUMtYGVhRawqsB83gNk7Rq9ogk9/fQylRbm0tDkvBItWMBAGzbz3eAAYMfPlfxfgMLF/4AYSPJaAh5prhoc9gBIpzssg3aoht19/8t/CJkC4qPeudgeTgXTeBoDulpQooBNhj5vB3g5kVbVAgibNclbZPUaPsHLqkh7WPGyc9lWSQ80rKP/2g/+VDS5tLWE29xNK0NoCTRsH0bGGSlF29aPomI14phmAvawdKZmaOThCcBns6pzInlvqH5tlfQwXh7IB6QS7yZA/51Hpm6PrGvvawFdBlqFe6uXjnoeKPy6EuvJYuGL3v5HQQS5EMF3TZKW3INGDAtyH8ChahFSeqYxLD4dRDIQ4zUf30/Vp8AhNB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(7696005)(82310400003)(336012)(36860700001)(86362001)(2616005)(316002)(6916009)(54906003)(2906002)(36756003)(44832011)(356005)(426003)(16526019)(186003)(1076003)(8936002)(8676002)(70586007)(5660300002)(83380400001)(81166007)(966005)(4326008)(47076005)(26005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:57:58.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0490f894-5b44-453b-a9c1-08d99a3c7a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The DF Indirect Access method allows for "Broadcast" accesses in which
case no specific instance is targeted. Add support using a reserved
instance ID of 0xFF to indicate a broadcast access. Set the FICAA
register appropriately.

Define helpers functions for instance and broadcast reads and use them
where appropriate.

Drop the "amd_" prefix since these functions are all static.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-5-yazen.ghannam@amd.com

v2->v3:
* Was patch 4 in v2.
* Define wrapper functions for instance/broadcast access.
* Drop "amd_" prefix.
* Dropped "df_regs" use.

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 28c96fd06019..bad230745d60 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -998,8 +998,11 @@ static DEFINE_MUTEX(df_indirect_mutex);
  *
  * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
  * and FICAD HI registers but so far we only need the LO register.
+ *
+ * Use Instance Id 0xFF to indicate a broadcast read.
  */
-static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+#define DF_BROADCAST	0xFF
+static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
 {
 	struct pci_dev *F4;
 	u32 ficaa;
@@ -1012,7 +1015,7 @@ static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32
 	if (!F4)
 		goto out;
 
-	ficaa  = 1;
+	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
 	ficaa |= reg & 0x3FC;
 	ficaa |= (func & 0x7) << 11;
 	ficaa |= instance_id << 16;
@@ -1036,6 +1039,16 @@ static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32
 	return err;
 }
 
+static int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	return __df_indirect_read(node, func, reg, instance_id, lo);
+}
+
+static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
+{
+	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1053,7 +1066,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	bool hash_enabled = false;
 
 	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
@@ -1067,7 +1080,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -1090,7 +1103,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &tmp))
 		goto out_err;
 
 	intlv_num_sockets = (tmp >> 8) & 0x1;
@@ -1146,7 +1159,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+		if (df_indirect_read_instance(nid, 0, 0x50, umc, &tmp))
 			goto out_err;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
@@ -1163,7 +1176,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+			if (df_indirect_read_broadcast(nid, 1, 0x208, &tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
@@ -1202,7 +1215,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+		if (df_indirect_read_broadcast(nid, 0, 0x104, &tmp))
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
-- 
2.25.1

