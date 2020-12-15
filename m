Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447FB2DAB9E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Dec 2020 12:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgLOLGF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Dec 2020 06:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgLOLGF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Dec 2020 06:06:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB8C06179C;
        Tue, 15 Dec 2020 03:05:24 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f9e0004c09a106cc893ab.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:9e00:4c0:9a10:6cc8:93ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B0C71EC0531;
        Tue, 15 Dec 2020 12:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608030323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ik/SYb2l7svBOZl65tmQV1OhmQBvNT4E7Nsqu0rZpng=;
        b=MjcmQ8wo60+U5HPWNaDDAbEN5U+tf8P8zCMMD6pWQYTxnPur9rjcUjbsNOYlx6x0MxPQop
        DeflbWidlouIRvZoOKXOCM83VNlaWh0cjWWuIm+jb94PiFC1gWtqAnt8WW+PIuH6UsdV9C
        Kh1SFKRlONE98xcgekVyaUq5oCQfM/A=
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] EDAC/amd64: Merge sysfs debugging attributes setup code
Date:   Tue, 15 Dec 2020 12:05:16 +0100
Message-Id: <20201215110517.5215-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There's no need for them to be in a separate file so merge them into the
main driver compilation unit like the other EDAC drivers do.

Drop now-unneeded function export, make the function static and shorten
static function names.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/Makefile         |  1 -
 drivers/edac/amd64_edac.c     | 65 +++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h     |  3 --
 drivers/edac/amd64_edac_dbg.c | 55 -----------------------------
 4 files changed, 59 insertions(+), 65 deletions(-)
 delete mode 100644 drivers/edac/amd64_edac_dbg.c

diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 3a849168780d..195e851652b6 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_EDAC_I82860)		+= i82860_edac.o
 obj-$(CONFIG_EDAC_R82600)		+= r82600_edac.o
 
 amd64_edac_mod-y := amd64_edac.o
-amd64_edac_mod-$(CONFIG_EDAC_DEBUG) += amd64_edac_dbg.o
 amd64_edac_mod-$(CONFIG_EDAC_AMD64_ERROR_INJECTION) += amd64_edac_inj.o
 
 obj-$(CONFIG_EDAC_AMD64)		+= amd64_edac_mod.o
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1362274d840b..b793ccd6c6bd 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -497,8 +497,8 @@ static int input_addr_to_csrow(struct mem_ctl_info *mci, u64 input_addr)
  * complete 32-bit values despite the fact that the bitfields in the DHAR
  * only represent bits 31-24 of the base and offset values.
  */
-int amd64_get_dram_hole_info(struct mem_ctl_info *mci, u64 *hole_base,
-			     u64 *hole_offset, u64 *hole_size)
+static int get_dram_hole_info(struct mem_ctl_info *mci, u64 *hole_base,
+			      u64 *hole_offset, u64 *hole_size)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 
@@ -551,7 +551,61 @@ int amd64_get_dram_hole_info(struct mem_ctl_info *mci, u64 *hole_base,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd64_get_dram_hole_info);
+
+#ifdef CONFIG_EDAC_DEBUG
+#define EDAC_DCT_ATTR_SHOW(reg)						\
+static ssize_t reg##_show(struct device *dev,				\
+			 struct device_attribute *mattr, char *data)	\
+{									\
+	struct mem_ctl_info *mci = to_mci(dev);				\
+	struct amd64_pvt *pvt = mci->pvt_info;				\
+									\
+	return sprintf(data, "0x%016llx\n", (u64)pvt->reg);		\
+}
+
+EDAC_DCT_ATTR_SHOW(dhar);
+EDAC_DCT_ATTR_SHOW(dbam0);
+EDAC_DCT_ATTR_SHOW(top_mem);
+EDAC_DCT_ATTR_SHOW(top_mem2);
+
+static ssize_t hole_show(struct device *dev, struct device_attribute *mattr,
+			 char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+
+	u64 hole_base = 0;
+	u64 hole_offset = 0;
+	u64 hole_size = 0;
+
+	get_dram_hole_info(mci, &hole_base, &hole_offset, &hole_size);
+
+	return sprintf(data, "%llx %llx %llx\n", hole_base, hole_offset,
+						 hole_size);
+}
+
+/*
+ * update NUM_DBG_ATTRS in case you add new members
+ */
+static DEVICE_ATTR(dhar, S_IRUGO, dhar_show, NULL);
+static DEVICE_ATTR(dbam, S_IRUGO, dbam0_show, NULL);
+static DEVICE_ATTR(topmem, S_IRUGO, top_mem_show, NULL);
+static DEVICE_ATTR(topmem2, S_IRUGO, top_mem2_show, NULL);
+static DEVICE_ATTR(dram_hole, S_IRUGO, hole_show, NULL);
+
+static struct attribute *dbg_attrs[] = {
+	&dev_attr_dhar.attr,
+	&dev_attr_dbam.attr,
+	&dev_attr_topmem.attr,
+	&dev_attr_topmem2.attr,
+	&dev_attr_dram_hole.attr,
+	NULL
+};
+
+const struct attribute_group dbg_group = {
+	.attrs = dbg_attrs,
+};
+#endif /* CONFIG_EDAC_DEBUG */
+
 
 /*
  * Return the DramAddr that the SysAddr given by @sys_addr maps to.  It is
@@ -590,8 +644,7 @@ static u64 sys_addr_to_dram_addr(struct mem_ctl_info *mci, u64 sys_addr)
 
 	dram_base = get_dram_base(pvt, pvt->mc_node_id);
 
-	ret = amd64_get_dram_hole_info(mci, &hole_base, &hole_offset,
-				      &hole_size);
+	ret = get_dram_hole_info(mci, &hole_base, &hole_offset, &hole_size);
 	if (!ret) {
 		if ((sys_addr >= (1ULL << 32)) &&
 		    (sys_addr < ((1ULL << 32) + hole_size))) {
@@ -3411,7 +3464,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
 #ifdef CONFIG_EDAC_DEBUG
-	&amd64_edac_dbg_group,
+	&dbg_group,
 #endif
 #ifdef CONFIG_EDAC_AMD64_ERROR_INJECTION
 	&amd64_edac_inj_group,
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 52b5d03eeba0..7c9f8c0b46d7 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -501,9 +501,6 @@ int __amd64_write_pci_cfg_dword(struct pci_dev *pdev, int offset,
 #define amd64_write_pci_cfg(pdev, offset, val)	\
 	__amd64_write_pci_cfg_dword(pdev, offset, val, __func__)
 
-int amd64_get_dram_hole_info(struct mem_ctl_info *mci, u64 *hole_base,
-			     u64 *hole_offset, u64 *hole_size);
-
 #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
 
 /* Injection helpers */
diff --git a/drivers/edac/amd64_edac_dbg.c b/drivers/edac/amd64_edac_dbg.c
deleted file mode 100644
index 393be3351493..000000000000
--- a/drivers/edac/amd64_edac_dbg.c
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "amd64_edac.h"
-
-#define EDAC_DCT_ATTR_SHOW(reg)						\
-static ssize_t amd64_##reg##_show(struct device *dev,			\
-			       struct device_attribute *mattr,		\
-			       char *data)				\
-{									\
-	struct mem_ctl_info *mci = to_mci(dev);				\
-	struct amd64_pvt *pvt = mci->pvt_info;				\
-		return sprintf(data, "0x%016llx\n", (u64)pvt->reg);	\
-}
-
-EDAC_DCT_ATTR_SHOW(dhar);
-EDAC_DCT_ATTR_SHOW(dbam0);
-EDAC_DCT_ATTR_SHOW(top_mem);
-EDAC_DCT_ATTR_SHOW(top_mem2);
-
-static ssize_t amd64_hole_show(struct device *dev,
-			       struct device_attribute *mattr,
-			       char *data)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-
-	u64 hole_base = 0;
-	u64 hole_offset = 0;
-	u64 hole_size = 0;
-
-	amd64_get_dram_hole_info(mci, &hole_base, &hole_offset, &hole_size);
-
-	return sprintf(data, "%llx %llx %llx\n", hole_base, hole_offset,
-						 hole_size);
-}
-
-/*
- * update NUM_DBG_ATTRS in case you add new members
- */
-static DEVICE_ATTR(dhar, S_IRUGO, amd64_dhar_show, NULL);
-static DEVICE_ATTR(dbam, S_IRUGO, amd64_dbam0_show, NULL);
-static DEVICE_ATTR(topmem, S_IRUGO, amd64_top_mem_show, NULL);
-static DEVICE_ATTR(topmem2, S_IRUGO, amd64_top_mem2_show, NULL);
-static DEVICE_ATTR(dram_hole, S_IRUGO, amd64_hole_show, NULL);
-
-static struct attribute *amd64_edac_dbg_attrs[] = {
-	&dev_attr_dhar.attr,
-	&dev_attr_dbam.attr,
-	&dev_attr_topmem.attr,
-	&dev_attr_topmem2.attr,
-	&dev_attr_dram_hole.attr,
-	NULL
-};
-
-const struct attribute_group amd64_edac_dbg_group = {
-	.attrs = amd64_edac_dbg_attrs,
-};
-- 
2.29.2

