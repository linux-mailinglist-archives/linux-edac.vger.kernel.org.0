Return-Path: <linux-edac+bounces-5589-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B527DCE8F39
	for <lists+linux-edac@lfdr.de>; Tue, 30 Dec 2025 09:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AC753017204
	for <lists+linux-edac@lfdr.de>; Tue, 30 Dec 2025 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF02FFF8D;
	Tue, 30 Dec 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rUBfgaG4"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFE3002A0;
	Tue, 30 Dec 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081608; cv=none; b=JO9vG4ZIl45JgE6w1zEOpxVOCpSLfLfdXSZ4A50BCVTsZCVtE9mbccNy1zKkuxC2MbHVG0u7EEs+l8e3DAV9ZH3Zj57UROOpdGLVjUP9Z4F0dvZ3nrU8V9/yVRnFZ5GIXJ5JZDQA0UACGFN+SEa+oslf1Q8vuduHN7uThuSTjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081608; c=relaxed/simple;
	bh=eCCYJjKE6CD+uM3U7MkDkM0hIvY1cQm9VjBaCMPn0fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QwLhyxEM1nfZDJL7Wr+4VEt99fab6SiauuR3jQUsxePYptrNNaabh47ttfqNfeNk7V/y5JG+DGd5c5f0ySftWLrEg3bRVV9sC2MyLeK7Z8zdLY7UiBYAqeahPJ66WBbZRdj6TlyIhRhAmvd8wNe8Vej1aJX8++9nQkCE8aWzT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rUBfgaG4; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767081594; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J/INasNsc6dwCLeywPMorn73E7fm1dR7+Oa4nPzj7lg=;
	b=rUBfgaG4a2hYvEOzto5pIa7f90fGj8B4nM6Diapf15pbaPyb46uHXvT+zaRnYMMLu3WXewxLtD+NTjf0Wsp33B7l1voe0VvZUQI7ynW5iPMfZw2NLPdo90wsMSsPpyghi6iNM5TsMqTC1qfwdPPl9sb/nui2X6J7Fv2imgzeZsk=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzM7Xx_1767081593 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 15:59:54 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	tony.luck@intel.com,
	bp@alien8.de,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com
Cc: Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [RFC PATCH] device/dax: Allow MCE recovery when accessing PFN metadata
Date: Tue, 30 Dec 2025 15:59:51 +0800
Message-Id: <20251230075951.85252-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both fsdax and devdax modes require significant space to store Page Frame
Number (PFN) metadata (struct page). For a 1TiB namespace, approximately
17.18GiB of metadata is needed[0]. As namespace sizes scale, hardware
memory errors within this metadata region become increasingly frequent.

Currently, the kernel treats any access to corrupted PFN metadata as an
unrecoverable event, leading to an immediate system panic. However, in
DAX scenarios (e.g., CXL-attached memory), the impact of metadata
corruption is logically confined to the physical device backing that
specific memory range.

Instead of a global panic, the kernel can ideally localize the failure.
By allowing the affected DAX memory range to be offlined or the specific
device to be decommissioned, we can limit the blast radius of hardware
errors. This enables other processes to migrate or exit gracefully
rather than being terminated by a system-wide crash.

Reproduce and testing:
1. Inject error to PFN metadata
2. mmap and read

Before apply this patch, kernel will panic:
  CPU 120: Machine Check Exception: f Bank 1: bd80000000100134
  RIP 10:<ffffffff8598300e> {dax_set_mapping.isra.0+0xce/0x140}
  TSC ee24b9e2d5 ADDR b213398000 MISC 86 PPIN 6deeb6484732971d
  PROCESSOR 0:a06d1 TIME 1765336050 SOCKET 0 APIC b1 microcode 10003f3
  Run the above through 'mcelog --ascii'
  Machine check: Data load in unrecoverable area of kernel
Kernel panic - not syncing: Fatal local machine check

After apply this patch:
User application receive SIGBUS, system still alive.

[0]: https://docs.pmem.io/ndctl-user-guide/managing-namespaces#fsdax-and-devdax-capacity-considerations

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/dax/dax-private.h | 26 ++++++++++++++++++++++++++
 drivers/dax/device.c      | 20 ++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..84325963fa3d 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -129,4 +129,30 @@ static inline bool dax_align_valid(unsigned long align)
 	return align == PAGE_SIZE;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#ifndef copy_mc_to_kernel
+static inline int dax_test_page_mc(const struct page *page)
+{
+	return 0;
+}
+static inline int dax_test_folio_mc(const struct folio *page)
+{
+	return 0;
+}
+#else
+#include <linux/uaccess.h>
+static inline int dax_test_page_mc(const struct page *page)
+{
+	struct page _p;
+
+	return copy_mc_to_kernel(&_p, page, sizeof(struct page));
+}
+static inline int dax_test_folio_mc(const struct folio *folio)
+{
+	struct folio _f;
+
+	return copy_mc_to_kernel(&_f, folio, sizeof(struct folio));
+}
+#endif
+#endif
 #endif
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 22999a402e02..a7f2217b9b62 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -80,7 +80,7 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
+static int dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 			      unsigned long fault_size)
 {
 	unsigned long i, nr_pages = fault_size / PAGE_SIZE;
@@ -95,6 +95,13 @@ static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 	pgoff = linear_page_index(vmf->vma,
 			ALIGN_DOWN(vmf->address, fault_size));
 
+	for (i = 0; i < nr_pages; i++) {
+		struct page *p = pfn_to_page(pfn + i);
+
+		if (dax_test_page_mc(p) || dax_test_page_mc(page_folio(p)))
+			return -EFAULT;
+	}
+
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = pfn_folio(pfn + i);
 
@@ -104,6 +111,8 @@ static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 		folio->mapping = filp->f_mapping;
 		folio->index = pgoff + i;
 	}
+
+	return 0;
 }
 
 static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
@@ -134,7 +143,8 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 
 	pfn = PHYS_PFN(phys);
 
-	dax_set_mapping(vmf, pfn, fault_size);
+	if (dax_set_mapping(vmf, pfn, fault_size))
+		return VM_FAULT_SIGBUS;
 
 	return vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn),
 					vmf->flags & FAULT_FLAG_WRITE);
@@ -178,7 +188,8 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 
 	pfn = PHYS_PFN(phys);
 
-	dax_set_mapping(vmf, pfn, fault_size);
+	if (dax_set_mapping(vmf, pfn, fault_size))
+		return VM_FAULT_SIGBUS;
 
 	return vmf_insert_folio_pmd(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
@@ -224,7 +235,8 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 
 	pfn = PHYS_PFN(phys);
 
-	dax_set_mapping(vmf, pfn, fault_size);
+	if (dax_set_mapping(vmf, pfn, fault_size))
+		return VM_FAULT_SIGBUS;
 
 	return vmf_insert_folio_pud(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
-- 
2.33.1


