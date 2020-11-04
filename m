Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7D2A5E8F
	for <lists+linux-edac@lfdr.de>; Wed,  4 Nov 2020 08:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKDHIV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Nov 2020 02:08:21 -0500
Received: from m12-13.163.com ([220.181.12.13]:34872 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDHIV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Nov 2020 02:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=wfnKKCR7jCAnqTDL8v
        44KWUkhqyUDHHTypDVNtffWLo=; b=aNCY0qULCW1s4JZXXiSTg+ebyY/5X0EGM9
        dY3wZQWlUql4a5inoCIOGEmrDCmMvgO0uklCNnA5ipBLdGzuuEPYntR11mUf3CGN
        /NwCC3pP9LQdml3EM7XnbEywTHjscYMDTvlRzbhs8WqKIn6QeaQNjg5fyFUvBTff
        neyPdA4PI=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp9 (Coremail) with SMTP id DcCowAD3_IhnT6JfJUIgOw--.47711S2;
        Wed, 04 Nov 2020 14:51:19 +0800 (CST)
From:   yaoaili126@163.com
To:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, james.morse@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        yangfeng1@kingsoft.com, CHENGUOMIN@kingsoft.com,
        yaoaili@kingsoft.com
Subject: [PATCH] Dump cper error table in mce_panic
Date:   Tue,  3 Nov 2020 22:50:57 -0800
Message-Id: <20201104065057.40442-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
X-CM-TRANSID: DcCowAD3_IhnT6JfJUIgOw--.47711S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1fJFyruw1xuryfuF13CFg_yoW7uw45pF
        W8urWrKw48Wr4xK34xAr4UKr45Z3ykW3y3GasrC3s5X3W5XrWF9rZYqa4jvF15Gry8Wr4f
        Xa90qrn3Can2vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jT388UUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbiLAfSG1spZUsbNgAAsT
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

For X86_MCE, When there is a fatal ue error, BIOS will prepare one
detailed cper error table before raising MCE, this cper table is meant
to supply addtional error information and not to race with mce handler
to panic.

Usually possible unexpected cper process from NMI watchdog race panic
with MCE panic is not a problem, the panic process will coordinate with
each core. But When the CPER is not processed in the first kernel and
leave it to the second kernel, this is a problem, lead to a kdump fail.

Now in this patch, the mce_panic will race with unexpected NMI to dump
the cper error log and get it cleaned, this will prevent the cper table
leak to the second kernel, which will fix the kdump fail problem, and
also guarrante the cper log is collected which it's meant to.

Anyway,For x86_mce platform, the ghes module is still needed not to
panic for fatal memory UE as it's MCE handler's work.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/core.c     |  2 +
 arch/x86/kernel/cpu/mce/internal.h |  5 ++
 drivers/acpi/apei/ghes.c           | 79 ++++++++++++++++++++++++++++++
 include/acpi/ghes.h                |  2 +
 4 files changed, 88 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..22efa708ef53 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -341,6 +341,8 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
+	/* Print possible additional cper error info, get cper cleared */
+	ghes_in_mce_cper_entry_check();
 	if (cpu_missing)
 		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
 	if (exp)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 88dcc79cfb07..3aea48400af3 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -71,6 +71,7 @@ int apei_write_mce(struct mce *m);
 ssize_t apei_read_mce(struct mce *m, u64 *record_id);
 int apei_check_mce(void);
 int apei_clear_mce(u64 record_id);
+extern int ghes_in_mce_cper_entry_check(void);
 #else
 static inline int apei_write_mce(struct mce *m)
 {
@@ -88,6 +89,10 @@ static inline int apei_clear_mce(u64 record_id)
 {
 	return -EINVAL;
 }
+static inline int ghes_in_mce_cper_entry_check(void)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..2c4274a0bec0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1147,9 +1147,88 @@ static void ghes_nmi_remove(struct ghes *ghes)
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
+			goto done;
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
+done:
+	rcu_read_unlock();
+	atomic_dec(&ghes_in_nmi);
+	return ret;
+}
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline void ghes_nmi_add(struct ghes *ghes) { }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
+int ghes_in_mce_cper_entry_check(void) {}
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static void ghes_nmi_init_cxt(void)
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..be1ee0e993d2 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -145,4 +145,6 @@ int ghes_notify_sea(void);
 static inline int ghes_notify_sea(void) { return -ENOENT; }
 #endif
 
+int ghes_in_mce_cper_entry_check(void);
+
 #endif /* GHES_H */
-- 
2.18.4


