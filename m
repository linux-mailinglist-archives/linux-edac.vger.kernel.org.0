Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE7B629E66
	for <lists+linux-edac@lfdr.de>; Tue, 15 Nov 2022 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKOQEm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Nov 2022 11:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiKOQEj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Nov 2022 11:04:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14041000
        for <linux-edac@vger.kernel.org>; Tue, 15 Nov 2022 08:04:36 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBWCT5wbfz687wc;
        Wed, 16 Nov 2022 00:02:13 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:04:35 +0100
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.200) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 16:04:34 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 02/11] rasdaemon: Support cpu fault isolation for recoverable errors
Date:   Tue, 15 Nov 2022 16:04:10 +0000
Message-ID: <20221115160419.355-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221115160419.355-1-shiju.jose@huawei.com>
References: <20221115160419.355-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.156.200]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shengwei Luo <luoshengwei@huawei.com>

When the recoverable errors in cpu core occurred, try to offline
the related cpu core.

Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Junchong Pan <panjunchong@hisilicon.com>
Signed-off-by: Lei Feng <fenglei47@h-partners.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-arm-handler.c   | 22 +++++++++++++++++++---
 ras-cpu-isolation.c | 17 +++++++++++++++++
 ras-cpu-isolation.h |  4 +++-
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/ras-arm-handler.c b/ras-arm-handler.c
index 9c7a3c3..a0dfc51 100644
--- a/ras-arm-handler.c
+++ b/ras-arm-handler.c
@@ -26,6 +26,7 @@
 
 #define ARM_ERR_VALID_ERROR_COUNT BIT(0)
 #define ARM_ERR_VALID_FLAGS BIT(1)
+#define BIT2 2
 
 void display_raw_data(struct trace_seq *s,
 		const uint8_t *buf,
@@ -47,7 +48,20 @@ void display_raw_data(struct trace_seq *s,
 }
 
 #ifdef HAVE_CPU_FAULT_ISOLATION
-static int count_errors(struct ras_arm_event *ev)
+static int is_core_failure(struct ras_arm_err_info *err_info)
+{
+	if (err_info->validation_bits & ARM_ERR_VALID_FLAGS) {
+		/*
+		 * core failure:
+		 * Bit 0\1\3: (at lease 1)
+		 * Bit 2: 0
+		 */
+		return (err_info->flags & 0xf) && !(err_info->flags & (0x1 << BIT2));
+	}
+	return 0;
+}
+
+static int count_errors(struct ras_arm_event *ev, int sev)
 {
 	struct ras_arm_err_info *err_info;
 	int num_pei;
@@ -75,6 +89,8 @@ static int count_errors(struct ras_arm_event *ev)
 			 */
 			error_count = err_info->multiple_error + 1;
 		}
+		if (sev == GHES_SEV_RECOVERABLE && !is_core_failure(err_info))
+			error_count = 0;
 
 		num += error_count;
 		err_info += 1;
@@ -118,8 +134,8 @@ static int ras_handle_cpu_error(struct trace_seq *s,
 	}
 	trace_seq_printf(s, "\n severity: %s", severity);
 
-	if (val == GHES_SEV_CORRECTED) {
-		int nums = count_errors(ev);
+	if (val == GHES_SEV_CORRECTED || val == GHES_SEV_RECOVERABLE) {
+		int nums = count_errors(ev, val);
 
 		if (nums > 0) {
 			err_info.nums = nums;
diff --git a/ras-cpu-isolation.c b/ras-cpu-isolation.c
index 1694a08..90633fd 100644
--- a/ras-cpu-isolation.c
+++ b/ras-cpu-isolation.c
@@ -126,6 +126,7 @@ static int init_cpu_info(unsigned int cpus)
 
 	for (unsigned int i = 0; i < cpus; ++i) {
 		cpu_infos[i].ce_nums = 0;
+		cpu_infos[i].uce_nums = 0;
 		cpu_infos[i].state = get_cpu_status(i);
 		cpu_infos[i].ce_queue = init_queue();
 
@@ -306,6 +307,15 @@ static int do_ce_handler(unsigned int cpu)
 	return HANDLE_NOTHING;
 }
 
+static int do_uce_handler(unsigned int cpu)
+{
+	if (cpu_infos[cpu].uce_nums > 0) {
+		log(TERM, LOG_INFO, "Uncorrected Errors occurred, try to offline cpu%u\n", cpu);
+		return do_cpu_offline(cpu);
+	}
+	return HANDLE_NOTHING;
+}
+
 static int error_handler(unsigned int cpu, struct error_info *err_info)
 {
 	int ret = HANDLE_NOTHING;
@@ -314,6 +324,9 @@ static int error_handler(unsigned int cpu, struct error_info *err_info)
 	case CE:
 		ret = do_ce_handler(cpu);
 		break;
+	case UCE:
+		ret = do_uce_handler(cpu);
+		break;
 	default:
 		break;
 	}
@@ -336,6 +349,9 @@ static void record_error_info(unsigned int cpu, struct error_info *err_info)
 		cpu_infos[cpu].ce_nums += err_info->nums;
 		break;
 	}
+	case UCE:
+		cpu_infos[cpu].uce_nums++;
+		break;
 	default:
 		break;
 	}
@@ -382,6 +398,7 @@ void ras_record_cpu_error(struct error_info *err_info, int cpu)
 			cpu, cpu_state[cpu_infos[cpu].state]);
 		clear_queue(cpu_infos[cpu].ce_queue);
 		cpu_infos[cpu].ce_nums = 0;
+		cpu_infos[cpu].uce_nums = 0;
 	} else
 		log(TERM, LOG_WARNING, "Offline cpu%d fail, the state is %s\n",
 			cpu, cpu_state[cpu_infos[cpu].state]);
diff --git a/ras-cpu-isolation.h b/ras-cpu-isolation.h
index 35b5225..5682106 100644
--- a/ras-cpu-isolation.h
+++ b/ras-cpu-isolation.h
@@ -45,10 +45,12 @@ enum error_handle_result {
 };
 
 enum error_type {
-	CE = 1
+	CE = 1,
+	UCE
 };
 
 struct cpu_info {
+	unsigned long uce_nums;
 	unsigned long ce_nums;
 	struct link_queue *ce_queue;
 	enum cpu_state state;
-- 
2.25.1

