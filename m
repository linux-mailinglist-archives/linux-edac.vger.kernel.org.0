Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1585415086
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhIVTiJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 15:38:09 -0400
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:30945
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229918AbhIVTiI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 15:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnxGCP3216TpappxpIVAChEP2KmDpROQwrCpwGLGJrrvjaBPJ6S4HSDtIH6wzk+ic2+nl4IxESgJfb9j4EKuFwQlGum1Ok8jafKJaTOOKaOuGpcVp+G5VrVLlGidp0Pr31yIYFjyEDZaVQfVFiMuhGpTVgC5ZPt4R7SQqgcj3VWuoDm5Bo7bkCDVYQEWa3WG0EbV9iFwXPRxgTxjiyHgcPJTaFtpAf5IsTGtsTFdXXaPNFDrc42QUUT7m3ZTasy3DzxK7actamBJCr/VOyD3lc5G6qOmAo0kiLF+L7QXy/jKJgDBeqcvLv4GZ/t8IehiaMWzGV0ubxsBPIIBpUE2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/Jdu3yWAbR5sktOSy6S+NvWEzKufuEyKN8Nibxm6yF0=;
 b=DahGC/pZpdUPR5B1VEDLhL/Wmex0ujpVUekoABmeJwI81jXTUMbobw5w17Ze+hCbeFtDjls8aBLF5xhc/LG7gqoepRfhLH5BnvdvkVXZrmoJ4qnat3WOGWDmDoF12+dGUHmBc3SFzs8yM3sC9d8DrTnHBl2/J4SSAv6873rt1FA1aoLNM1dqr+KZHfy6BAF2c71d55MUCHxsR7v7ypCWyb+Ybu5qeNdfaGQopod29Atj0/97T6LOj3Pc5t/MV+zUlETWgFA92a0lgp8uqjEWbb8ONMBLyxBC8QJiOyQiNrkb4hSiSyHdzP0s/zma5/RlABbHjzl9GgSRRFaK6giAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jdu3yWAbR5sktOSy6S+NvWEzKufuEyKN8Nibxm6yF0=;
 b=4AD5+Y5zi4gGro7haWfz158FVkw7wI8UYMqStWuZA6es+7msXlXSkc1ooKtL9CSSdTgCy7sHs4fXp7iybw1H5CdpoDL9u7VmJ3ZSLFnyx34c/9f6iBtQZe2DB2dGxkeD/S97EOyy06p0gQD3/Kr1KfsbMe1lYEl8o5SrXvHwK6M=
Received: from MWHPR15CA0055.namprd15.prod.outlook.com (2603:10b6:301:4c::17)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 19:36:36 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::8b) by MWHPR15CA0055.outlook.office365.com
 (2603:10b6:301:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 19:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 19:36:35 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 14:36:34 -0500
From:   Mukul Joshi <mukul.joshi@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Date:   Wed, 22 Sep 2021 15:36:20 -0400
Message-ID: <20210922193620.15925-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913021311.12896-2-mukul.joshi@amd.com>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c506468-ccea-408e-d50b-08d97e004a42
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2988A65F014F764238EE8888EEA29@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gh0/Cb+8d2dgAX6RONglFuaoYrmWdrrMIIMle2OZR2uMvOKRzpFT8CyTd71HQzuyT26QSVHi3bVFHz0CquE26kN6xaP3nm0DYTJCOaFtYnaIeC871Nb5YNywGA2zLei071YLS7+noFYWJjC8KOn4EIGq/P+FI/LdYDlMgmAUOv1Fkn4ukV1HeqdOmp/+2OqC+EfA4epDHNqRNT3Q4WzI/NnCz+9ouJa1FWYMoFXYW4RDPw3OdSHeJ4FpqHFb79DNXm7N9WB01mJ+Q0N4nQ2fem+syjV/y/F2dLfeJHjqigYBCmMBBiMGomz6lMRb5bjiehN2h4KNA9me5+LLZbs8PCT6c2gOV5kW3Gov4WCBNafUI5+EXrgRFGSFNR1MHUfk9Ei9re+RbS/FFxjgmsvIEPwbEowhiHPWInMrF7Mg8f3kUVrV3TlFI6pIe/ogZHNfk5V3fY/iIMakN4vgmjSIAvubQYyzdcxCRjJGBUy4YW1GDNtmirRWdIlDGu2xu2jGLAG2HrbHTvMPFD5O/KHHwawXdQRaWRqq+43JTkUTG36uSzsOSuxGwjLcXEeRz3PzmTKtnLgT8tTfnRX/79L5yFtaM6+L6mEej8pocy6j2xrWbCgXnczgCeMbb54MX+YP19mgOskIW7UiHWygEmf9fLeiO/g1DwHyegr8r6McK95L4Wmuu4jxR263u7PauIhIcTQD/JzhJDr+0Ozqh3qXH9l8/6JwPFbHmBR7foM+C+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(70586007)(508600001)(2906002)(426003)(110136005)(5660300002)(81166007)(6666004)(316002)(82310400003)(7696005)(70206006)(8936002)(26005)(2616005)(1076003)(47076005)(36860700001)(356005)(336012)(83380400001)(44832011)(8676002)(16526019)(54906003)(4326008)(186003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 19:36:35.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c506468-ccea-408e-d50b-08d97e004a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Aldebaran, GPU driver will handle bad page retirement
even though UMC is host managed. As a result, register a
bad page retirement handler on the mce notifier chain to
retire bad pages on Aldebaran.

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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 141 ++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 912ea1f9fd04..c1e806762e41 100644
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
@@ -2583,3 +2595,132 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev)
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
+		    (XEC(m->status, 0x1f) == 0x0)))
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

