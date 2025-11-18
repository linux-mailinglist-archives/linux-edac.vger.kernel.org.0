Return-Path: <linux-edac+bounces-5454-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF8C68251
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 09:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9626F347238
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C81306D3E;
	Tue, 18 Nov 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FhjutcSH"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92D2D8364;
	Tue, 18 Nov 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453362; cv=none; b=gbyHRJHAhQaIR8NWE25bOblpUtR/YND7iD8HJnJQfMrXFbEawgn0TMFNjyMNK/ThN3I/RPkhS61KcUBcg5Wmw6vak3Gwj/DHSKXhK22P6ix3q8Geeb0LfNX7n9mWjiOHfa9q0+UUjZ20dCmYVIP6X6o0L8cu7CU+90oD+2D1wmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453362; c=relaxed/simple;
	bh=lK1HB/Kphuzht/fKjlSnl7t4tqI6/FHUtmR470ubWBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py++5ddF1mu87/9L0mxPAvnddCvIdKobP/GNnWQ2g006UqtPgm7jAfB50zeUBK71yJTqow+/9zcI06qKAZfe76rQjWwCdlwh0QVpz+Qo3Q3jqjGDWZ1gsZ+lw0ffRs+6QGSApIv4YtNd4JnrWfA3cm6Z3ClttTaMoOpaNHvUvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FhjutcSH; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VM3CpdBrLvEcqbt2ukVSKGcYUHg4qRv1vBw4aiOt220=;
	b=FhjutcSHCsZYzhDkkGkeXjx6bgKeQlFXTjDevAPUmlNpMa3T45Cdm41HnhIOaNbznmUj1nYYv
	tNOyJ1B0FmGqRsnU4iwlV2M5mnPn8D81neOkCv9U9ax8l9YS3U8WuoDb2w+o3sZA3V18fbrchIG
	x+pQyK5HotXD5erxnPoe/Nk=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d9cfY3CSwzRhR1;
	Tue, 18 Nov 2025 16:07:33 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F718140137;
	Tue, 18 Nov 2025 16:09:16 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 16:09:14 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@kernel.org>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, <linmiaohe@huawei.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lorenzo.stoakes@oracle.com>, <luto@kernel.org>,
	<mhocko@suse.com>, <mingo@redhat.com>, <nao.horiguchi@gmail.com>,
	<peterz@infradead.org>, <rppt@kernel.org>, <surenb@google.com>,
	<tglx@linutronix.de>, <tony.luck@intel.com>, <vbabka@suse.cz>,
	<will@kernel.org>, <x86@kernel.org>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Tue, 18 Nov 2025 16:09:10 +0800
Message-ID: <20251118080910.833858-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <534dfba8-6222-4eea-aeb8-440d47c67f5b@kernel.org>
References: <534dfba8-6222-4eea-aeb8-440d47c67f5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Wed, Mon, 17 Nov 2025 14:03:46 +0100, David Hildenbrand wrote:
> I'd say, if nobody will really make use of that right now (customer 
> request etc), just leave x86 alone for now.

Okay, thanks, I will only submit patch 2 in the V3 patches.

On Tue, 4 Nov 2025 10:38:54 +0100, David Hildenbrand wrote:
Link: https://lore.kernel.org/01b44e0f-ea2e-406f-9f65-b698b5504f42@kernel.org
> This trace system should not be called "ras". All RAS terminology should 
> be removed here.
>
> #define TRACE_SYSTEM memory_failure
>
> We want to add that new file to the "HWPOISON MEMORY FAILURE HANDLING"
> section in MAINTAINERS.
>
> Nothing else jumped at me.

Can I add an
"Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>"
in the patch 2?

The full patch will be:
```patch
From: Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: [PATCH v3] mm/memory-failure: remove the selection of RAS

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
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
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
```

Thanks very much.

Xie Yuanbin

