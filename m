Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B136C71A1
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 21:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCWUYr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCWUYr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 16:24:47 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D7F23C6F;
        Thu, 23 Mar 2023 13:24:45 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NIqxa9010676;
        Thu, 23 Mar 2023 20:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=xJbSLKxPzmw1dFHRUfgRRXz+JkoGSWETzLUX8F2zI3M=;
 b=Lo5wrP3R/SpVVRugIAcgBisNu5U9bOkDnsa9BoSYqBQAInK2Qm8rsoaFhy+phwGZomeF
 HI9Cd78igMghmqQ/vbIA6QS4KBSAHj5vwen8nNrUnqmGmicRxExdTiC9lgVlnGFYb5GX
 6HmiH6UTv9JGulGc27xjObZwMgWSoCW4I3roLQfFjG8xIDNDPFonfCjmPf8FDUDB2Cpx
 n4r4P2usBAS+zIzdoOsvILY8qSJ0ToU0sD6/pSAfKztLGNeqA55MKgdNF/pWE9vHczmb
 MtSNbJc//+Mjt+qRWGP0/aflSFdj//8SOn+264XQxyQi9ZcEVp824bJKeAa2sXc2Nd6c zw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pgvec8my2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 20:24:25 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4341B13096;
        Thu, 23 Mar 2023 20:24:24 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 9932D813D8E;
        Thu, 23 Mar 2023 20:24:23 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id E0DF930062B07; Thu, 23 Mar 2023 15:24:22 -0500 (CDT)
From:   kyle-meyer <kyle.meyer@hpe.com>
To:     dimitri.sivanich@hpe.com, steve.wahl@hpe.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
        qiuxu.zhuo@intel.com, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     kyle.meyer@hpe.com
Subject: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Date:   Thu, 23 Mar 2023 15:22:01 -0500
Message-Id: <20230323202158.37937-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qXr59J__IJfRcOr108swO29VeHPtH2So
X-Proofpoint-ORIG-GUID: qXr59J__IJfRcOr108swO29VeHPtH2So
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230150
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Kyle Meyer <kyle.meyer@hpe.com>

When kernel lockdown is in effect, use of debugfs is not permitted. Move
decay_interval and action_threshold out of debugfs, from debugfs/ras/cec
to sysfs/system/devices/machinecheck/cec.

Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 arch/x86/include/asm/mce.h     |   1 +
 arch/x86/kernel/cpu/mce/core.c |   3 +-
 arch/x86/ras/Kconfig           |   4 +-
 drivers/ras/cec.c              | 141 ++++++++++++++++++++++-----------
 4 files changed, 101 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 9646ed6e8c0b..c5d358499899 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -206,6 +206,7 @@ static inline void enable_copy_mc_fragile(void)
 struct cper_ia_proc_ctx;
 
 #ifdef CONFIG_X86_MCE
+extern struct bus_type mce_subsys;
 int mcheck_init(void);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2eec60f50057..1a3eaa501ae4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2376,10 +2376,11 @@ static void mce_enable_ce(void *all)
 		__mcheck_cpu_init_timer();
 }
 
-static struct bus_type mce_subsys = {
+struct bus_type mce_subsys = {
 	.name		= "machinecheck",
 	.dev_name	= "machinecheck",
 };
+EXPORT_SYMBOL_GPL(mce_subsys);
 
 DEFINE_PER_CPU(struct device *, mce_device);
 
diff --git a/arch/x86/ras/Kconfig b/arch/x86/ras/Kconfig
index 7488c715427e..5f5f6f9a5f3c 100644
--- a/arch/x86/ras/Kconfig
+++ b/arch/x86/ras/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config RAS_CEC
 	bool "Correctable Errors Collector"
-	depends on X86_MCE && MEMORY_FAILURE && DEBUG_FS
+	depends on X86_MCE && MEMORY_FAILURE
 	help
 	  This is a small cache which collects correctable memory errors per 4K
 	  page PFN and counts their repeated occurrence. Once the counter for a
@@ -15,7 +15,7 @@ config RAS_CEC
 config RAS_CEC_DEBUG
 	bool "CEC debugging machinery"
 	default n
-	depends on RAS_CEC
+	depends on RAS_CEC && DEBUG_FS
 	help
 	  Add extra files to (debugfs)/ras/cec to test the correctable error
 	  collector feature. "pfn" is a writable file that allows user to
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 321af498ee11..b45b4e90b8de 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -7,6 +7,7 @@
 #include <linux/ras.h>
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include <asm/mce.h>
 
@@ -394,53 +395,96 @@ static int cec_add_elem(u64 pfn)
 	return ret;
 }
 
-static int u64_get(void *data, u64 *val)
-{
-	*val = *(u64 *)data;
+static struct kobject *cec_kobj;
 
-	return 0;
+static ssize_t decay_interval_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", decay_interval);
 }
 
-static int pfn_set(void *data, u64 val)
+static ssize_t decay_interval_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
 {
-	*(u64 *)data = val;
+	unsigned long long res;
+	int ret;
 
-	cec_add_elem(val);
+	ret = kstrtoull(buf, 10, &res);
+	if (ret)
+		return ret;
 
-	return 0;
+	if (res < CEC_DECAY_MIN_INTERVAL)
+		return -EINVAL;
+
+	if (res > CEC_DECAY_MAX_INTERVAL)
+		return -EINVAL;
+
+	decay_interval = res;
+
+	cec_mod_work(decay_interval);
+
+	return count;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
+static ssize_t action_threshold_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", action_threshold);
+}
 
-static int decay_interval_set(void *data, u64 val)
+static ssize_t action_threshold_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
 {
-	if (val < CEC_DECAY_MIN_INTERVAL)
-		return -EINVAL;
+	unsigned long long res;
+	int ret;
 
-	if (val > CEC_DECAY_MAX_INTERVAL)
-		return -EINVAL;
+	ret = kstrtoull(buf, 10, &res);
+	if (ret)
+		return ret;
 
-	*(u64 *)data   = val;
-	decay_interval = val;
+	if (res > COUNT_MASK)
+		res = COUNT_MASK;
 
-	cec_mod_work(decay_interval);
+	action_threshold = res;
+
+	return count;
+}
+
+static struct kobj_attribute decay_interval_attr =
+	__ATTR_RW_MODE(decay_interval, 0600);
+
+static struct kobj_attribute action_threshold_attr =
+	__ATTR_RW_MODE(action_threshold, 0600);
+
+static struct attribute *cec_attrs[] = {
+	&decay_interval_attr.attr,
+	&action_threshold_attr.attr,
+	NULL
+};
+
+static const struct attribute_group cec_attr_group = {
+	.attrs = cec_attrs
+};
+
+static int u64_get(void *data, u64 *val)
+{
+	*val = *(u64 *)data;
 
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
 
-static int action_threshold_set(void *data, u64 val)
+static int pfn_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	if (val > COUNT_MASK)
-		val = COUNT_MASK;
-
-	action_threshold = val;
+	cec_add_elem(val);
 
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%lld\n");
+
+DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
 
 static const char * const bins[] = { "00", "01", "10", "11" };
 
@@ -480,7 +524,7 @@ DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array;
+	struct dentry *d, *pfn, *array;
 
 	d = debugfs_create_dir("cec", ras_debugfs_dir);
 	if (!d) {
@@ -488,23 +532,6 @@ static int __init create_debugfs_nodes(void)
 		return -1;
 	}
 
-	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
-				    &decay_interval, &decay_interval_ops);
-	if (!decay) {
-		pr_warn("Error creating decay_interval debugfs node!\n");
-		goto err;
-	}
-
-	count = debugfs_create_file("action_threshold", S_IRUSR | S_IWUSR, d,
-				    &action_threshold, &action_threshold_ops);
-	if (!count) {
-		pr_warn("Error creating action_threshold debugfs node!\n");
-		goto err;
-	}
-
-	if (!IS_ENABLED(CONFIG_RAS_CEC_DEBUG))
-		return 0;
-
 	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
 	if (!pfn) {
 		pr_warn("Error creating pfn debugfs node!\n");
@@ -553,6 +580,8 @@ static struct notifier_block cec_nb = {
 
 static int __init cec_init(void)
 {
+	int ret;
+
 	if (ce_arr.disabled)
 		return -ENODEV;
 
@@ -570,9 +599,22 @@ static int __init cec_init(void)
 		return -ENOMEM;
 	}
 
-	if (create_debugfs_nodes()) {
-		free_page((unsigned long)ce_arr.array);
-		return -ENOMEM;
+	cec_kobj = kobject_create_and_add("cec", &mce_subsys.dev_root->kobj);
+	if (!cec_kobj) {
+		pr_err("Error creating CEC kobject!\n");
+		ret = -ENOMEM;
+		goto err_kobject;
+	}
+
+	ret = sysfs_create_group(cec_kobj, &cec_attr_group);
+	if (ret) {
+		pr_err("Error creating CEC attribute group!\n");
+		goto err_group;
+	}
+
+	if (IS_ENABLED(CONFIG_RAS_CEC_DEBUG) && create_debugfs_nodes()) {
+		ret = -ENOMEM;
+		goto err_debug;
 	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
@@ -582,6 +624,15 @@ static int __init cec_init(void)
 
 	pr_info("Correctable Errors collector initialized.\n");
 	return 0;
+
+err_debug:
+	sysfs_remove_group(cec_kobj, &cec_attr_group);
+err_group:
+	kobject_put(cec_kobj);
+err_kobject:
+	free_page((unsigned long)ce_arr.array);
+
+	return ret;
 }
 late_initcall(cec_init);
 
-- 
2.26.2

