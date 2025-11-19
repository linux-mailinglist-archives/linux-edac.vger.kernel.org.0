Return-Path: <linux-edac+bounces-5467-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFAC6DE11
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 11:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60EC24EE63D
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C0346E6A;
	Wed, 19 Nov 2025 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tVgeMTXm"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0233B6F1;
	Wed, 19 Nov 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546414; cv=none; b=lTBmqrKrKuCb8k+LmoJIii2vKmp11asK7tL7bpw8XjKz/oq52GM22g7ygJRoQI0n1Ov6R0V+RTBhpGRwYwP6BvWv4BKfKtDqa7dl8ICuxOxSn1SX1Hjntbx4xSmdYfN6z0CTwgGf2H9mw0pP/GaVmNSxVaiQRlxN3g1CFpiA4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546414; c=relaxed/simple;
	bh=QX8AWgDyHlyTUAKqwQ8fej+X7jBQ6YdJOZjiEhyDVQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtSZyit/vcNUSSoGGrY7w5T+n6BJS2lmubhyAOM7xCbRpxnyBfXGfQCSrDuwyuNEEnr495yWzC50cZrrFsHcBH2LXOTkJY/IX0sgsGYV/9oNljsK6G4+Q7zjAXRvdaK2c40d9Efc8Ob0x+zo04dLjOe8o5dvtVe3YzE5UjLya+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tVgeMTXm; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=D4O0opZ/OFA/+IIFkS92viMctiZDX4MAOGWcfGTkr+w=;
	b=tVgeMTXmNU0Njc1cg5QPWH5pPTLf2rIOcUS3j8WiU7UV2Z/MxTlhmSb/tTBVPMAWpxGAAowu1
	Qf1SYectQSTFwasuEG5G6HGwV1q3zs7kNTA5I4RF9wncMjX713KyvA6lPKvZ+erz9kD8yclY9CB
	LDn8k4q0lKWlcz5CaF6FRYU=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBH4B0JNdznTWH;
	Wed, 19 Nov 2025 17:58:34 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 84908140135;
	Wed, 19 Nov 2025 18:00:01 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 18:00:00 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@redhat.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<akpm@linux-foundation.org>, <david@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<will@kernel.org>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>, Xie Yuanbin
	<xieyuanbin1@huawei.com>
Subject: [PATCH v3] mm/memory-failure: remove the selection of RAS
Date: Wed, 19 Nov 2025 17:59:43 +0800
Message-ID: <20251119095943.67125-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

The commit 97f0b13452198290799f ("tracing: add trace event for
memory-failure") introduces the selection of RAS in memory-failure.
This commit is just a tracing feature; in reality, there is no dependency
between memory-failure and RAS. RAS increases the size of the bzImage
image by 8k, which is very valuable for embedded devices.

Move the memory-failure traceing code from ras_event.h to
memory-failure.h and remove the selection of RAS.

v2->v3: https://lore.kernel.org/20251104072306.100738-3-xieyuanbin1@huawei.com
  - Change define TRACE_SYSTEM from ras to memory_failure
  - Add include/trace/events/memory-failure.h to
    "HWPOISON MEMORY FAILURE HANDLING" section in MAINTAINERS
  - Rebase to latest linux-next source

v1->v2: https://lore.kernel.org/20251103033536.52234-2-xieyuanbin1@huawei.com
  - Move the memory-failure traceing code from ras_event.h to
    memory-failure.h

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
---
 MAINTAINERS                           |  1 +
 include/ras/ras_event.h               | 87 ------------------------
 include/trace/events/memory-failure.h | 98 +++++++++++++++++++++++++++
 mm/Kconfig                            |  1 -
 mm/memory-failure.c                   |  5 +-
 5 files changed, 103 insertions(+), 89 deletions(-)
 create mode 100644 include/trace/events/memory-failure.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7310d9ca0370..43d6eb95fb05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11631,10 +11631,11 @@ R:	Naoya Horiguchi <nao.horiguchi@gmail.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/memory-failure.h
 F:	mm/hwpoison-inject.c
 F:	mm/memory-failure.c
+F:	include/trace/events/memory-failure.h
 
 HYCON HY46XX TOUCHSCREEN SUPPORT
 M:	Giulio Benetti <giulio.benetti@benettiengineering.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fecfeb7c8be7..1e5e87020eef 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -10,11 +10,10 @@
 #include <linux/edac.h>
 #include <linux/ktime.h>
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/cper.h>
-#include <linux/mm.h>
 
 /*
  * MCE Extended Error Log trace event
  *
  * These events are generated when hardware detects a corrected or
@@ -337,95 +336,9 @@ TRACE_EVENT(aer_event,
 		__entry->tlp_header_valid ?
 			__print_array(__entry->tlp_header, PCIE_STD_MAX_TLP_HEADERLOG, 4) :
 			"Not available")
 );
 #endif /* CONFIG_PCIEAER */
-
-/*
- * memory-failure recovery action result event
- *
- * unsigned long pfn -	Page Frame Number of the corrupted page
- * int type	-	Page types of the corrupted page
- * int result	-	Result of recovery action
- */
-
-#ifdef CONFIG_MEMORY_FAILURE
-#define MF_ACTION_RESULT	\
-	EM ( MF_IGNORED, "Ignored" )	\
-	EM ( MF_FAILED,  "Failed" )	\
-	EM ( MF_DELAYED, "Delayed" )	\
-	EMe ( MF_RECOVERED, "Recovered" )
-
-#define MF_PAGE_TYPE		\
-	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
-	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
-	EM ( MF_MSG_HUGE, "huge page" )					\
-	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
-	EM ( MF_MSG_GET_HWPOISON, "get hwpoison page" )			\
-	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
-	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
-	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
-	EM ( MF_MSG_DIRTY_MLOCKED_LRU, "dirty mlocked LRU page" )	\
-	EM ( MF_MSG_CLEAN_MLOCKED_LRU, "clean mlocked LRU page" )	\
-	EM ( MF_MSG_DIRTY_UNEVICTABLE_LRU, "dirty unevictable LRU page" )	\
-	EM ( MF_MSG_CLEAN_UNEVICTABLE_LRU, "clean unevictable LRU page" )	\
-	EM ( MF_MSG_DIRTY_LRU, "dirty LRU page" )			\
-	EM ( MF_MSG_CLEAN_LRU, "clean LRU page" )			\
-	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
-	EM ( MF_MSG_BUDDY, "free buddy page" )				\
-	EM ( MF_MSG_DAX, "dax page" )					\
-	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
-	EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )		\
-	EM ( MF_MSG_PFN_MAP, "non struct page pfn" )                    \
-	EMe ( MF_MSG_UNKNOWN, "unknown page" )
-
-/*
- * First define the enums in MM_ACTION_RESULT to be exported to userspace
- * via TRACE_DEFINE_ENUM().
- */
-#undef EM
-#undef EMe
-#define EM(a, b) TRACE_DEFINE_ENUM(a);
-#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
-
-MF_ACTION_RESULT
-MF_PAGE_TYPE
-
-/*
- * Now redefine the EM() and EMe() macros to map the enums to the strings
- * that will be printed in the output.
- */
-#undef EM
-#undef EMe
-#define EM(a, b)		{ a, b },
-#define EMe(a, b)	{ a, b }
-
-TRACE_EVENT(memory_failure_event,
-	TP_PROTO(unsigned long pfn,
-		 int type,
-		 int result),
-
-	TP_ARGS(pfn, type, result),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, pfn)
-		__field(int, type)
-		__field(int, result)
-	),
-
-	TP_fast_assign(
-		__entry->pfn	= pfn;
-		__entry->type	= type;
-		__entry->result	= result;
-	),
-
-	TP_printk("pfn %#lx: recovery action for %s: %s",
-		__entry->pfn,
-		__print_symbolic(__entry->type, MF_PAGE_TYPE),
-		__print_symbolic(__entry->result, MF_ACTION_RESULT)
-	)
-);
-#endif /* CONFIG_MEMORY_FAILURE */
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/memory-failure.h b/include/trace/events/memory-failure.h
new file mode 100644
index 000000000000..aa57cc8f896b
--- /dev/null
+++ b/include/trace/events/memory-failure.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM memory_failure
+#define TRACE_INCLUDE_FILE memory-failure
+
+#if !defined(_TRACE_MEMORY_FAILURE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MEMORY_FAILURE_H
+
+#include <linux/tracepoint.h>
+#include <linux/mm.h>
+
+/*
+ * memory-failure recovery action result event
+ *
+ * unsigned long pfn -	Page Frame Number of the corrupted page
+ * int type	-	Page types of the corrupted page
+ * int result	-	Result of recovery action
+ */
+
+#define MF_ACTION_RESULT	\
+	EM ( MF_IGNORED, "Ignored" )	\
+	EM ( MF_FAILED,  "Failed" )	\
+	EM ( MF_DELAYED, "Delayed" )	\
+	EMe ( MF_RECOVERED, "Recovered" )
+
+#define MF_PAGE_TYPE		\
+	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
+	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
+	EM ( MF_MSG_HUGE, "huge page" )					\
+	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
+	EM ( MF_MSG_GET_HWPOISON, "get hwpoison page" )			\
+	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
+	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
+	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
+	EM ( MF_MSG_DIRTY_MLOCKED_LRU, "dirty mlocked LRU page" )	\
+	EM ( MF_MSG_CLEAN_MLOCKED_LRU, "clean mlocked LRU page" )	\
+	EM ( MF_MSG_DIRTY_UNEVICTABLE_LRU, "dirty unevictable LRU page" )	\
+	EM ( MF_MSG_CLEAN_UNEVICTABLE_LRU, "clean unevictable LRU page" )	\
+	EM ( MF_MSG_DIRTY_LRU, "dirty LRU page" )			\
+	EM ( MF_MSG_CLEAN_LRU, "clean LRU page" )			\
+	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
+	EM ( MF_MSG_BUDDY, "free buddy page" )				\
+	EM ( MF_MSG_DAX, "dax page" )					\
+	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
+	EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )		\
+	EM ( MF_MSG_PFN_MAP, "non struct page pfn" )                    \
+	EMe ( MF_MSG_UNKNOWN, "unknown page" )
+
+/*
+ * First define the enums in MM_ACTION_RESULT to be exported to userspace
+ * via TRACE_DEFINE_ENUM().
+ */
+#undef EM
+#undef EMe
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+MF_ACTION_RESULT
+MF_PAGE_TYPE
+
+/*
+ * Now redefine the EM() and EMe() macros to map the enums to the strings
+ * that will be printed in the output.
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)		{ a, b },
+#define EMe(a, b)	{ a, b }
+
+TRACE_EVENT(memory_failure_event,
+	TP_PROTO(unsigned long pfn,
+		 int type,
+		 int result),
+
+	TP_ARGS(pfn, type, result),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(int, type)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->pfn	= pfn;
+		__entry->type	= type;
+		__entry->result	= result;
+	),
+
+	TP_printk("pfn %#lx: recovery action for %s: %s",
+		__entry->pfn,
+		__print_symbolic(__entry->type, MF_PAGE_TYPE),
+		__print_symbolic(__entry->result, MF_ACTION_RESULT)
+	)
+);
+#endif /* _TRACE_MEMORY_FAILURE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/Kconfig b/mm/Kconfig
index d548976d0e0a..bd0ea5454af8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -738,11 +738,10 @@ config ARCH_SUPPORTS_MEMORY_FAILURE
 
 config MEMORY_FAILURE
 	depends on MMU
 	depends on ARCH_SUPPORTS_MEMORY_FAILURE
 	bool "Enable recovery from hardware memory errors"
-	select RAS
 	select INTERVAL_TREE
 	help
 	  Enables code to recover from some memory failures on systems
 	  with MCA recovery. This allows a system to continue running
 	  even when some of its memory has uncorrected errors. This requires
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7f908ad795ad..fbc5a01260c8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -59,13 +59,16 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
 #include <linux/sysctl.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/memory-failure.h>
+
 #include "swap.h"
 #include "internal.h"
-#include "ras/ras_event.h"
 
 static int sysctl_memory_failure_early_kill __read_mostly;
 
 static int sysctl_memory_failure_recovery __read_mostly = 1;
 
-- 
2.51.0


