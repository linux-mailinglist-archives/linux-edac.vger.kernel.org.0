Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB54167D2
	for <lists+linux-edac@lfdr.de>; Fri, 24 Sep 2021 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhIWWGy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 18:06:54 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:50977
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236039AbhIWWGq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Sep 2021 18:06:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMxcaxnvpQ0mbeipCqOVXFX0QjaOJCakFI1NRJc9yRKmZmOo+8JiF5MOmpeAbXlFs9Ir25n49+wrhqTJNLk8gFpjIiou845g2tLG1w2EfPO4fL424KwTO8wDB9bceM8V5YM1A8EhWalWmBXDCYYpn4buy9dRFg05Tky/GJes0MEGrewDnnuIrz+UU/UGrqef0yuZoutUd9PiZg/DQEjM4wTJWFFYjOD4QehPZmUmHuH5D7tO99oAW9pe0oHBxRR39KRVQJlNIfdMfnAC+BfJyBDnNfguAKwf9N1gKQJcDSiCFqOqa7tfcY9f74suuQfxK0IOA8MN24VnufIkxYCnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3BVc5LGRwbCTUPLKuP6ez8b7mBafl5wzMzwle5nVS2o=;
 b=K2KRnsyekp8io5r+zrpTEM2T11NQ8/cifV58X7S2nTBElnB1ogDOSWqrb4AFpp1FD4epLQVUoZITF2WKXEP7B35+zmQtwzbKHgczqGlG6plK3E5mzYu/4XQsbhryguAa50zXwd+mfm5EaDJn3mzLPJONeMli3yEf8HXubUP5xJTf4uZXpFXgkbnHz/h3KllV692Aa7VoYbrRQi6OurZjgh+YwQaVMgQIHsXMyQIdVdN3Qc7rntz4iJMEM4Rg7oj0uwr+vQLJmQL0Oqy+uqRMeLM0WHib8blXWaS3r5BMyHgfbvHl5c0140Ov+K3QtRDHUEdR9AZ/KoTAIRzYfIDSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BVc5LGRwbCTUPLKuP6ez8b7mBafl5wzMzwle5nVS2o=;
 b=xKndvVxpY1SjyVltGGDqLZc7ZcWN5qvgp3GLhQ2wwbkqj2/2X2rjxNfRmbwFceAx67MG8GuIBGfqfcVFaZFQ+ayqgohHJyGEd3tzWLnc4SEa5e0n2CXho9iunt8sZ0vbgOF3DSqWFk5gMbN8YSm7wkGDtr6JIaTZmlQ81/PyS1k=
Received: from DM5PR07CA0121.namprd07.prod.outlook.com (2603:10b6:3:13e::11)
 by BN6PR12MB1347.namprd12.prod.outlook.com (2603:10b6:404:1c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 22:05:07 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::55) by DM5PR07CA0121.outlook.office365.com
 (2603:10b6:3:13e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 22:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 22:05:07 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 17:05:06 -0500
From:   Mukul Joshi <mukul.joshi@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv4 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Date:   Thu, 23 Sep 2021 18:04:34 -0400
Message-ID: <20210923220434.25245-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922193620.15925-1-mukul.joshi@amd.com>
References: <20210922193620.15925-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc423da9-5838-4a98-3f27-08d97ede3453
X-MS-TrafficTypeDiagnostic: BN6PR12MB1347:
X-Microsoft-Antispam-PRVS: <BN6PR12MB134792BDE9C4CE4D99ECAC03EEA39@BN6PR12MB1347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDReuf/lKjzFQOwt1zXHIIuCJnznJe9kVhy921QEjkHxijyhbNqJr66dzGU7km+9iXle5ytKt1JsYtdmtZ3WQCVmlgpnexW+zdIBHIeXhkYrjyT2wbaLEcNefl0zDypAXSU7L9y6cnpc/9FgAd5J2Y/xkQiD3YLM83VRe3fKKVo4zMpKA43at99JJb0Z4ps/j0Mkj6IMSEAzVIMMHTvsXoj6iZp6XEqVL/JT0s4hpV1LsbCIZYKrp1amxCe8uvLDM7d8BU9KcgJ1Zv7v7bP/iHhrokzPeArzC+2n84bnr0E1YkdIF6ytsz+GH18o1UGzWZ78mS9zJVnVD+v6PZBec/0XF0Vxj3RhgxqGgjlQjjJj7Tj2mGPVw1Jeg6pPcOFAPexhRwGCh6PaXyzIEQT6KvXw9GbNbDGPV6iUqLPkLj7qb8LXiMqx++7AzCrJ4phmaMWh5aWywMZ6wjJy3O4RwRMqIP64e18SCsK5SyF+pXdjKypvQTcnxArdBVxwcktezW1T/XVIrQ81WVdXZy+r0VdwwitHgNHT/uKSQEcTCUVx5xTGn7035Nx8hO4Um5k+Sy3mhIXM1ijER8P40R8OhBKdvjKWCCSuB6Y/gUqHW71Uw/BWsRpzFbiBXhJEwW8XBWe0AIqMHibp3IYsavV+My0z6Am7nhCd8kwnOVJHyJ8X/yzNIknkrc425b4TaKcXVjReZvSPGaDDHPvtV9yCwcZVInsdDdf3vZxic4VBSq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(26005)(54906003)(4326008)(81166007)(36860700001)(83380400001)(110136005)(86362001)(16526019)(2906002)(336012)(47076005)(70206006)(82310400003)(6666004)(70586007)(8936002)(7696005)(8676002)(2616005)(316002)(5660300002)(44832011)(186003)(426003)(1076003)(36756003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 22:05:07.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc423da9-5838-4a98-3f27-08d97ede3453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1347
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Aldebaran, GPU driver will handle bad page retirement
for GPU memory even though UMC is host managed. As a result,
register a bad page retirement handler on the mce notifier
chain to retire bad pages on Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Use smca_get_bank_type() to determine MCA bank.
- Envelope the changes under #ifdef CONFIG_X86_MCE_AMD.
- Use MCE_PRIORITY_UC instead of MCE_PRIO_ACCEL as we are
  only handling uncorrectable errors.
- Use macros to determine UMC instance and channel instance
  where the uncorrectable error occured.

v2->v3:
- Move the check for correctable error before find_adev().
- Fix a NULL pointer dereference if find_adev() returns NULL.

v3->v4:
- Update the commit log to specify page retirement for GPU
  memory only.
- Fix the mask passed to XEC macro.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 141 ++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e1c34eef76b7..02841a0efbb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -35,7 +35,11 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
+#ifdef CONFIG_X86_MCE_AMD
+#include <asm/mce.h>
 
+static bool notifier_registered;
+#endif
 static const char *RAS_FS_NAME = "ras";
 
 const char *ras_error_string[] = {
@@ -107,6 +111,9 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr);
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
+#ifdef CONFIG_X86_MCE_AMD
+static void amdgpu_register_bad_pages_mca_notifier(void);
+#endif
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)
 {
@@ -2089,6 +2096,11 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
 	}
 
+#ifdef CONFIG_X86_MCE_AMD
+	if ((adev->asic_type == CHIP_ALDEBARAN) &&
+	    (adev->gmc.xgmi.connected_to_cpu))
+		amdgpu_register_bad_pages_mca_notifier();
+#endif
 	return 0;
 
 free:
@@ -2552,3 +2564,132 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev)
 		kfree(con);
 	}
 }
+
+#ifdef CONFIG_X86_MCE_AMD
+static struct amdgpu_device *find_adev(uint32_t node_id)
+{
+	struct amdgpu_gpu_instance *gpu_instance;
+	int i;
+	struct amdgpu_device *adev = NULL;
+
+	mutex_lock(&mgpu_info.mutex);
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		gpu_instance = &(mgpu_info.gpu_ins[i]);
+		adev = gpu_instance->adev;
+
+		if (adev->gmc.xgmi.connected_to_cpu &&
+		    adev->gmc.xgmi.physical_node_id == node_id)
+			break;
+		adev = NULL;
+	}
+
+	mutex_unlock(&mgpu_info.mutex);
+
+	return adev;
+}
+
+#define GET_MCA_IPID_GPUID(m)	(((m) >> 44) & 0xF)
+#define GET_UMC_INST(m)		(((m) >> 21) & 0x7)
+#define GET_CHAN_INDEX(m)	((((m) >> 12) & 0x3) | (((m) >> 18) & 0x4))
+#define GPU_ID_OFFSET		8
+
+static int amdgpu_bad_page_notifier(struct notifier_block *nb,
+				    unsigned long val, void *data)
+{
+	struct mce *m = (struct mce *)data;
+	struct amdgpu_device *adev = NULL;
+	uint32_t gpu_id = 0;
+	uint32_t umc_inst = 0;
+	uint32_t ch_inst, channel_index = 0;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct eeprom_table_record err_rec;
+	uint64_t retired_page;
+
+	/*
+	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
+	 * and error occurred in DramECC (Extended error code = 0) then only
+	 * process the error, else bail out.
+	 */
+	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
+		    (XEC(m->status, 0x3f) == 0x0)))
+		return NOTIFY_DONE;
+
+	/*
+	 * If it is correctable error, return.
+	 */
+	if (mce_is_correctable(m))
+		return NOTIFY_OK;
+
+	/*
+	 * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
+	 */
+	gpu_id = GET_MCA_IPID_GPUID(m->ipid) - GPU_ID_OFFSET;
+
+	adev = find_adev(gpu_id);
+	if (!adev) {
+		DRM_WARN("%s: Unable to find adev for gpu_id: %d\n", __func__,
+								gpu_id);
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * If it is uncorrectable error, then find out UMC instance and
+	 * channel index.
+	 */
+	umc_inst = GET_UMC_INST(m->ipid);
+	ch_inst = GET_CHAN_INDEX(m->ipid);
+
+	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
+			     umc_inst, ch_inst);
+
+	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
+
+	/*
+	 * Translate UMC channel address to Physical address
+	 */
+	channel_index =
+		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num
+					  + ch_inst];
+
+	retired_page = ADDR_OF_8KB_BLOCK(m->addr) |
+			ADDR_OF_256B_BLOCK(channel_index) |
+			OFFSET_IN_256B_BLOCK(m->addr);
+
+	err_rec.address = m->addr;
+	err_rec.retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+	err_rec.ts = (uint64_t)ktime_get_real_seconds();
+	err_rec.err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+	err_rec.cu = 0;
+	err_rec.mem_channel = channel_index;
+	err_rec.mcumc_id = umc_inst;
+
+	err_data.err_addr = &err_rec;
+	err_data.err_addr_cnt = 1;
+
+	if (amdgpu_bad_page_threshold != 0) {
+		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
+						err_data.err_addr_cnt);
+		amdgpu_ras_save_bad_pages(adev);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block amdgpu_bad_page_nb = {
+	.notifier_call  = amdgpu_bad_page_notifier,
+	.priority       = MCE_PRIO_UC,
+};
+
+static void amdgpu_register_bad_pages_mca_notifier(void)
+{
+	/*
+	 * Register the x86 notifier only once
+	 * with MCE subsystem.
+	 */
+	if (notifier_registered == false) {
+		mce_register_decode_chain(&amdgpu_bad_page_nb);
+		notifier_registered = true;
+	}
+}
+#endif
-- 
2.17.1

