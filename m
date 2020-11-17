Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C82B5CAC
	for <lists+linux-edac@lfdr.de>; Tue, 17 Nov 2020 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKQKNT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 17 Nov 2020 05:13:19 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:45391 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgKQKNT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Nov 2020 05:13:19 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 05:13:16 EST
X-AuditID: 0a580155-613ff7000003c60c-b1-5fb39ac11490
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id E6.20.50700.1CA93BF5; Tue, 17 Nov 2020 17:41:21 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 17:58:09 +0800
Date:   Tue, 17 Nov 2020 17:58:04 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <bp@alien8.de>, <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <yangfeng1@kingsoft.com>, <CHENGUOMIN@kingsoft.com>
Subject: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
In-Reply-To: <20201104065057.40442-1-yaoaili126@163.com>
References: <20201104065057.40442-1-yaoaili126@163.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXCFcGooHtw1uZ4gx1TuSw+b/jHZnF/33Im
        i50P37JZLN/Xz2hx4VQDk8WZ05dYLd5cuMfiwO7xvbWPxWPNvDWMHov3vGTy2LSqk81jy9V2
        Fo/Pm+QC2KK4bFJSczLLUov07RK4Mqbtn8NW8NC44vG6w4wNjNe0uhg5OSQETCQOLbnC1sXI
        xSEkMJ1J4un314wQzgtGiaeHDjGCVLEIqEosvnuFCcRmA7J33ZvFCmKLCGRJNPzdxgxiMwuU
        SszcfQYozsEhLGAm0Xg0CiTMK2AlcfNiPxtImFPAQuLo/TiQsJCAucSsvkvMIGF+ATGJVw3G
        EOfYSzz/e5YZolNQ4uTMJywQw3UkTqw6BrVIW2LZwtfMEGMUJQ4v+cUO0askcaR7BhuEHSux
        bN4r1gmMwrOQjJqFZNQsJKMWMDKvYmQpzk032sQIiYjQHYwzmj7qHWJk4mA8xCjBwawkwuti
        sjFeiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+f76Z4IYH0xJLU7NTUgtQimCwTB6dUA5Np6AWN
        R5uP5OvOnya08dPkKeYFmzw75n1jD0xz2qyxh59T/VhfUeBMx60Fzgb+/Se49lTZpooE2me5
        vZh2aMXyMiujpJUrby1dUWrbyPoo8nV9qUW2U8eDlqd2P3c4Le/y13d9eGzHhrlrttzb6SaY
        /eaiibyo0vJ5ga/+3q5yef7/54oNUdcvbPzxaVL4BQ5Bx8XlPxsa7JbpcFmKp9jd2LfbgW2X
        wbKZXknvV67+db/aao9y1J9XgQslfh49I2sQ9lzQR8S1i++x78/bWzrXxqs4e3x5Xvn4/Klz
        TZx7A6Iu/5E6e7akZK92QOF1q74HW29Om6aQezxEkCOusvz1ndfKT2ozfq4Oq910Y8NXJZbi
        jERDLeai4kQABzZoI/cCAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From 3b2602aa50f37321f9b05f9e377ac52f8a1db90a Mon Sep 17 00:00:00 2001
From: Aili Yao <yaoaili@kingsoft.com>
Date: Tue, 17 Nov 2020 17:41:54 +0800
Subject: [PATCH v2] Dump cper error table in mce_panic

For X86_MCE, When BIOS option WHEA memory log is enabled,if there is a
fatal ue error, BIOS will prepare one cper error table before raising MCE,
this cper table is meant to supply addtional error information and not to
race with mce handler to panic, but currently ghes_notify_nmi() from
unexpected NMI watchdog may race to panic with mce.

Usually possible unexpected cper process from NMI watchdog race panic
with MCE panic is not a problem, the panic process will coordinate with
each core. But When the CPER is not processed in the first kernel and
leave it to the second kernel, that is a problem, lead to a kdump fail.

Now in this patch, the mce_panic will race with unexpected NMI to dump
the cper error log and get it cleaned, this will prevent the cper table
leaked to the second kernel, which will prevent ghes_notify_nmi to
process and fix the kdump fail problem, and also guarrante the cper log is
collected which it's meant to.

Anyway,For x86_mce platform, the ghes module is better not to panic with
fatal memory UE as it's MCE handler's work.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/apei.c     |  5 ++
 arch/x86/kernel/cpu/mce/core.c     |  2 +
 arch/x86/kernel/cpu/mce/internal.h |  5 ++
 drivers/acpi/apei/ghes.c           | 78 ++++++++++++++++++++++++++++++
 include/acpi/ghes.h                |  6 +++
 5 files changed, 96 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index af8d37962586..d2dcae90613b 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -143,3 +143,8 @@ int apei_clear_mce(u64 record_id)
 {
 	return erst_clear(record_id);
 }
+
+int apei_check_cper(void)
+{
+	return ghes_in_mce_cper_entry_check();
+}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..ce468bed352d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -342,6 +342,8 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
+	/* Print possible additional cper error info, get cper cleared */
+	apei_check_cper();
 	if (cpu_missing)
 		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
 	if (exp)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 6473070b5da4..ad68119fb15c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -70,6 +70,7 @@ int apei_write_mce(struct mce *m);
 ssize_t apei_read_mce(struct mce *m, u64 *record_id);
 int apei_check_mce(void);
 int apei_clear_mce(u64 record_id);
+int apei_check_cper(void);
 #else
 static inline int apei_write_mce(struct mce *m)
 {
@@ -87,6 +88,10 @@ static inline int apei_clear_mce(u64 record_id)
 {
 	return -EINVAL;
 }
+static inline int apei_check_cper(void)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..80342e2f9760 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1084,6 +1084,84 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	 */
 	synchronize_rcu();
 }
+
+/*
+ * Only called by mce_panic, Return value will be ignored, just for debug
+ * purpose; when mce_panic is called, there may be meanwhile other hw error
+ * triggered through NMI, this function may lead that NMI unhandled,
+ * as we are in panic, collecting log will be sufficient.
+ */
+int ghes_in_mce_cper_entry_check(void)
+{
+	int ret = -ENOENT;
+	struct ghes *ghes;
+	struct list_head *rcu_list = &ghes_nmi;
+	enum fixed_addresses fixmap_idx = FIX_APEI_GHES_NMI;
+	struct acpi_hest_generic_status *estatus, tmp_header;
+	struct ghes_estatus_node *estatus_node;
+	u32 len, node_len;
+	u64 buf_paddr;
+
+	/* if NMI handler already in process, let NMI do its job */
+	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
+		return 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, rcu_list, list) {
+		int rc;
+
+		rc = __ghes_peek_estatus(ghes, &tmp_header, &buf_paddr, fixmap_idx);
+		if (rc) {
+			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+			ret = rc;
+			continue;
+		}
+
+		rc = __ghes_check_estatus(ghes, &tmp_header);
+		if (rc) {
+			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+			ret = rc;
+			continue;
+		}
+
+		len = cper_estatus_len(&tmp_header);
+		node_len = GHES_ESTATUS_NODE_LEN(len);
+		estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
+		if (!estatus_node) {
+			/* Going to panic, No need to keep the error. */
+			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+			ret = -ENOMEM;
+			continue;
+		}
+
+		estatus_node->ghes = ghes;
+		estatus_node->generic = ghes->generic;
+		estatus_node->task_work.func = NULL;
+		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+
+		if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
+			ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+			gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
+			ret = -ENOENT;
+			continue;
+		}
+
+		/*
+		 * As we are going to panic, and preemt the possible NMI handing,
+		 * dump all the info and get it cleared.
+		 */
+		ghes_print_queued_estatus();
+		__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
+		ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+		      node_len);
+	}
+
+	rcu_read_unlock();
+	atomic_dec(&ghes_in_nmi);
+	return ret;
+}
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline void ghes_nmi_add(struct ghes *ghes) { }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 517a5231cc1b..52a8638a0495 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -127,4 +127,10 @@ int ghes_notify_sea(void);
 static inline int ghes_notify_sea(void) { return -ENOENT; }
 #endif
 
+#if defined(CONFIG_ACPI_APEI_GHES) && defined(CONFIG_HAVE_ACPI_APEI_NMI)
+int ghes_in_mce_cper_entry_check(void);
+#else
+static inline int ghes_in_mce_cper_entry_check(void) { return 0; }
+#endif
+
 #endif /* GHES_H */
-- 
2.25.1

