Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6F4082C7
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 04:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhIMCPx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 12 Sep 2021 22:15:53 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:7988
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236907AbhIMCPx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 12 Sep 2021 22:15:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0fPXDeqiNAoLWesulRG86m28ULkS3NGMcz+dVn6ET6LTiZXvWPEFd269q4278rDjhJNoWPqC6GuXRi/z0iXyogIF0w0jnIdMcX7ocDnRDyv4Gm9fVl3G+cKKM3x/6cN4LRVeew2QoONBg2AFh6qtyknS1dzXvyDe5y3Xe7QJnNE5+8KO/wPoaoR/Ys2kotG4+NtP8cVN8oqvfhIhjY85DFql1fDsV+BGIie/kfmkB/c5s+LT7Hmx1j6swY3kzLnJt/x4DUVXUj/DIncZifoUDiAHdsHpXU6LL4LnyaV9lbqSUI+70OebpRVbu+5nPSNMZk72w3f4nUbzboNizuJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2P+b1YQyLOTeiAO8k5z3O1PoTvodRz3acpTN/YgXwE0=;
 b=iLepLgLYWN65sw4oa7RhZw+MXkJS3BBs8/Ajg94ATg3l7PQAXkLd8TxAniWL+9qZufUUWGpIGKSS8L0kXyblj1Eh67FdMrZ+LzLQZswzJG15o5Z3YMxmwv64Knjt1Gdgo1mwX/5Ci1I8l2B9ggfOYT/cJUxPrAG7V977acho9NNQJRIw/AkH4vnfewgQ7Pa4TfgSeQd+Hd23w/UJD+03mk93/kM9aZeIYlS/dEkhlz1QAZEunv9Jt7/mSP5k5321Uhgltv4Kzxb/pCxv+s5gqe36HGyqRoXRtS0e+HVoRMPJ+cGkOXF95zU4GZVKmMfVdzUWjsYtUU0LS7R3+mejNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P+b1YQyLOTeiAO8k5z3O1PoTvodRz3acpTN/YgXwE0=;
 b=Ip3TVfWOHAxxiIJOfxPAHgM5CB1am5S7Ap6okrLPPvnyp2A5ELIhjZJ9cEAZN2PNPI3qtPrzx4MPKoDcT+hrL9pegCKjLznBrU8ZVa6EUPqKQsUOP3ituKDoiduQLQMWGxfR2KfLQFvzh5uX+dnbZkIEEFpMgyFFko+L6p2EHjs=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by MN2PR12MB3582.namprd12.prod.outlook.com (2603:10b6:208:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 02:14:35 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::14) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 02:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 02:14:35 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 12 Sep
 2021 21:14:33 -0500
From:   Mukul Joshi <mukul.joshi@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Date:   Sun, 12 Sep 2021 22:13:11 -0400
Message-ID: <20210913021311.12896-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913021311.12896-1-mukul.joshi@amd.com>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab88d86f-6c52-4056-2e7a-08d9765c3b4f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3582:
X-Microsoft-Antispam-PRVS: <MN2PR12MB358229D611F24B15342B3735EED99@MN2PR12MB3582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kimhcA9F/cNbw0zPmAlwspTP/0FJZUvgHejZmJwpdvx9+g26mHhKC5D41cHwvg2B05nyvvS0ISn8nf1O4bltfH8oY3W4nlBxh9QlctzqrnrAAgbCcF3eBxLTQBtNuwgM2lLsC5+/QJSITCFkXlPDC+QYcvUin7CqbQEWKdK8pdBnqZd6nMWFg0NC1YIEya4GqJc/NktdR0EU1QuhJLtLf0r7GoU01TO/W8yRR7wyFY3cvNoueAbhHm7ziKMYDeQrhfkTpHWrq7GpYf2VQ8VU4syRjX5Ize61QUANPdBjEjat7kd1K17uFI48XZlnD2Zj/6Yr2un3hAiP1S/ExZWU2V2Br+9o/9/0viMgWbjmSQYco4cTFsNQqC9ddkbZVOEbhEym4bZ9IN/7GECDL/8lmCxvSsWkGgUqPLnJWk16C0Dh5REUyQWl1eJEkYEUah0EtmaR8QkSNPRuaccXmdf+/fTuavMB1dWoFyEMQEBjoKjkZFdSkZsvKV2C8tIId7qMiWAsNjXFkWCofu5VIOhvCb+eMPU05+N5ENJ3Cs0J8wBOGt9wC7JECJY0AFgmgb29LNHLUeLOhyJGRcBkixD3cgi/FSsLnXImEOaUKzsLUV58ysuKXritItYL5lJW0sbUGBhAtq3HGuYGYIKKkmTJqZk//WIJJ33JXa07Bu0jHCKNAWw8xwIdyp2oal2N8ziMj6HuAq0QpaMXWdrkpzeCqCwISKnphBLOuexK5lpo3AdvgfO3lDkqKXYCE0jAAgUrtpfCcA4sjKmLZ6XgyClvuhjP0FR6Pa2EEkCl0NVPJ4AGit72xHFq0JEVxDXqm+e8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(1076003)(47076005)(356005)(81166007)(16526019)(44832011)(110136005)(70206006)(83380400001)(86362001)(36756003)(966005)(316002)(8936002)(5660300002)(2616005)(8676002)(54906003)(2906002)(336012)(4326008)(6666004)(82310400003)(36860700001)(26005)(7696005)(508600001)(70586007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 02:14:35.2070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab88d86f-6c52-4056-2e7a-08d9765c3b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3582
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Aldebaran, GPU driver will handle bad page retirement
even though UMC is host managed. As a result, register a
bad page retirement handler on the mce notifier chain to
retire bad pages on Aldebaran.

v1->v2:
- Use smca_get_bank_type() to determine MCA bank.
- Envelope the changes under #ifdef CONFIG_X86_MCE_AMD.
- Use MCE_PRIORITY_UC instead of MCE_PRIO_ACCEL as we are
  only handling uncorrectable errors.
- Use macros to determine UMC instance and channel instance
  where the uncorrectable error occured.
- Update the headline.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Link: https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 142 ++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b5332db4d287..35cfcc71ff94 100644
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
@@ -86,6 +90,9 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr);
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
+#ifdef CONFIG_X86_MCE_AMD
+static void amdgpu_register_bad_pages_mca_notifier(void);
+#endif
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)
 {
@@ -2018,6 +2025,11 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
 	}
 
+#ifdef CONFIG_X86_MCE_AMD
+	if ((adev->asic_type == CHIP_ALDEBARAN) &&
+	    (adev->gmc.xgmi.connected_to_cpu))
+		amdgpu_register_bad_pages_mca_notifier();
+#endif
 	return 0;
 
 free:
@@ -2511,3 +2523,133 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev)
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
+	 * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
+	 */
+	gpu_id = GET_MCA_IPID_GPUID(m->ipid) - GPU_ID_OFFSET;
+
+	adev = find_adev(gpu_id);
+	if (!adev) {
+		dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: %d\n",
+				     __func__, gpu_id);
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * If it is correctable error, return.
+	 */
+	if (mce_is_correctable(m)) {
+		return NOTIFY_OK;
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

