Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1D2DABA1
	for <lists+linux-edac@lfdr.de>; Tue, 15 Dec 2020 12:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLOLGG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Dec 2020 06:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgLOLGF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Dec 2020 06:06:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8243FC0617A7;
        Tue, 15 Dec 2020 03:05:25 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f9e0004c09a106cc893ab.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:9e00:4c0:9a10:6cc8:93ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D783E1EC04EF;
        Tue, 15 Dec 2020 12:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608030324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ar+S7KklmEqRohSxM8GvqPlOqKI8x3eVADd4paee/cM=;
        b=EoHFpb/BYOIvqyKvubo+YwNtXP3jO8vm5AhhnBzkor+dEmNR0Keg28OxwMJ98HKhVTK2NB
        MsnSZbJyEQ/ehpR/X3funLAnMsYGiQeKXa8+8Js3ghXTjLDkT0cMqNsInKE1tMzxuH1xXK
        dD5AGOKLG4jN3ElvvnURbJ6NHH95G2I=
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] EDAC/amd64: Merge error injection sysfs facilities
Date:   Tue, 15 Dec 2020 12:05:17 +0100
Message-Id: <20201215110517.5215-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215110517.5215-1-bp@alien8.de>
References: <20201215110517.5215-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Merge them into the main driver and put them inside an EDAC_DEBUG
ifdeffery to simplify the driver and have all debugging/injection stuff
behind a debug build-time switch.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/Kconfig          |   7 +-
 drivers/edac/Makefile         |   6 +-
 drivers/edac/amd64_edac.c     | 237 +++++++++++++++++++++++++++++++++-
 drivers/edac/amd64_edac.h     |   8 --
 drivers/edac/amd64_edac_inj.c | 235 ---------------------------------
 5 files changed, 236 insertions(+), 257 deletions(-)
 delete mode 100644 drivers/edac/amd64_edac_inj.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7a47680d6f07..9c2e719cb86a 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -81,10 +81,9 @@ config EDAC_AMD64
 	  Support for error detection and correction of DRAM ECC errors on
 	  the AMD64 families (>= K8) of memory controllers.
 
-config EDAC_AMD64_ERROR_INJECTION
-	bool "Sysfs HW Error injection facilities"
-	depends on EDAC_AMD64
-	help
+	  When EDAC_DEBUG is enabled, hardware error injection facilities
+	  through sysfs are available:
+
 	  Recent Opterons (Family 10h and later) provide for Memory Error
 	  Injection into the ECC detection circuits. The amd64_edac module
 	  allows the operator/user to inject Uncorrectable and Correctable
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 195e851652b6..b8133cd32059 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -43,11 +43,7 @@ obj-$(CONFIG_EDAC_IE31200)		+= ie31200_edac.o
 obj-$(CONFIG_EDAC_X38)			+= x38_edac.o
 obj-$(CONFIG_EDAC_I82860)		+= i82860_edac.o
 obj-$(CONFIG_EDAC_R82600)		+= r82600_edac.o
-
-amd64_edac_mod-y := amd64_edac.o
-amd64_edac_mod-$(CONFIG_EDAC_AMD64_ERROR_INJECTION) += amd64_edac_inj.o
-
-obj-$(CONFIG_EDAC_AMD64)		+= amd64_edac_mod.o
+obj-$(CONFIG_EDAC_AMD64)		+= amd64_edac.o
 
 obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b793ccd6c6bd..f5de5857a84e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -601,11 +601,240 @@ static struct attribute *dbg_attrs[] = {
 	NULL
 };
 
-const struct attribute_group dbg_group = {
+static const struct attribute_group dbg_group = {
 	.attrs = dbg_attrs,
 };
-#endif /* CONFIG_EDAC_DEBUG */
 
+static ssize_t inject_section_show(struct device *dev,
+				   struct device_attribute *mattr, char *buf)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	return sprintf(buf, "0x%x\n", pvt->injection.section);
+}
+
+/*
+ * store error injection section value which refers to one of 4 16-byte sections
+ * within a 64-byte cacheline
+ *
+ * range: 0..3
+ */
+static ssize_t inject_section_store(struct device *dev,
+				    struct device_attribute *mattr,
+				    const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul(data, 10, &value);
+	if (ret < 0)
+		return ret;
+
+	if (value > 3) {
+		amd64_warn("%s: invalid section 0x%lx\n", __func__, value);
+		return -EINVAL;
+	}
+
+	pvt->injection.section = (u32) value;
+	return count;
+}
+
+static ssize_t inject_word_show(struct device *dev,
+				struct device_attribute *mattr, char *buf)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	return sprintf(buf, "0x%x\n", pvt->injection.word);
+}
+
+/*
+ * store error injection word value which refers to one of 9 16-bit word of the
+ * 16-byte (128-bit + ECC bits) section
+ *
+ * range: 0..8
+ */
+static ssize_t inject_word_store(struct device *dev,
+				 struct device_attribute *mattr,
+				 const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul(data, 10, &value);
+	if (ret < 0)
+		return ret;
+
+	if (value > 8) {
+		amd64_warn("%s: invalid word 0x%lx\n", __func__, value);
+		return -EINVAL;
+	}
+
+	pvt->injection.word = (u32) value;
+	return count;
+}
+
+static ssize_t inject_ecc_vector_show(struct device *dev,
+				      struct device_attribute *mattr,
+				      char *buf)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	return sprintf(buf, "0x%x\n", pvt->injection.bit_map);
+}
+
+/*
+ * store 16 bit error injection vector which enables injecting errors to the
+ * corresponding bit within the error injection word above. When used during a
+ * DRAM ECC read, it holds the contents of the of the DRAM ECC bits.
+ */
+static ssize_t inject_ecc_vector_store(struct device *dev,
+				       struct device_attribute *mattr,
+				       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul(data, 16, &value);
+	if (ret < 0)
+		return ret;
+
+	if (value & 0xFFFF0000) {
+		amd64_warn("%s: invalid EccVector: 0x%lx\n", __func__, value);
+		return -EINVAL;
+	}
+
+	pvt->injection.bit_map = (u32) value;
+	return count;
+}
+
+/*
+ * Do a DRAM ECC read. Assemble staged values in the pvt area, format into
+ * fields needed by the injection registers and read the NB Array Data Port.
+ */
+static ssize_t inject_read_store(struct device *dev,
+				 struct device_attribute *mattr,
+				 const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	unsigned long value;
+	u32 section, word_bits;
+	int ret;
+
+	ret = kstrtoul(data, 10, &value);
+	if (ret < 0)
+		return ret;
+
+	/* Form value to choose 16-byte section of cacheline */
+	section = F10_NB_ARRAY_DRAM | SET_NB_ARRAY_ADDR(pvt->injection.section);
+
+	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_ADDR, section);
+
+	word_bits = SET_NB_DRAM_INJECTION_READ(pvt->injection);
+
+	/* Issue 'word' and 'bit' along with the READ request */
+	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, word_bits);
+
+	edac_dbg(0, "section=0x%x word_bits=0x%x\n", section, word_bits);
+
+	return count;
+}
+
+/*
+ * Do a DRAM ECC write. Assemble staged values in the pvt area and format into
+ * fields needed by the injection registers.
+ */
+static ssize_t inject_write_store(struct device *dev,
+				  struct device_attribute *mattr,
+				  const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+	u32 section, word_bits, tmp;
+	unsigned long value;
+	int ret;
+
+	ret = kstrtoul(data, 10, &value);
+	if (ret < 0)
+		return ret;
+
+	/* Form value to choose 16-byte section of cacheline */
+	section = F10_NB_ARRAY_DRAM | SET_NB_ARRAY_ADDR(pvt->injection.section);
+
+	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_ADDR, section);
+
+	word_bits = SET_NB_DRAM_INJECTION_WRITE(pvt->injection);
+
+	pr_notice_once("Don't forget to decrease MCE polling interval in\n"
+			"/sys/bus/machinecheck/devices/machinecheck<CPUNUM>/check_interval\n"
+			"so that you can get the error report faster.\n");
+
+	on_each_cpu(disable_caches, NULL, 1);
+
+	/* Issue 'word' and 'bit' along with the READ request */
+	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, word_bits);
+
+ retry:
+	/* wait until injection happens */
+	amd64_read_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, &tmp);
+	if (tmp & F10_NB_ARR_ECC_WR_REQ) {
+		cpu_relax();
+		goto retry;
+	}
+
+	on_each_cpu(enable_caches, NULL, 1);
+
+	edac_dbg(0, "section=0x%x word_bits=0x%x\n", section, word_bits);
+
+	return count;
+}
+
+/*
+ * update NUM_INJ_ATTRS in case you add new members
+ */
+
+static DEVICE_ATTR(inject_section, S_IRUGO | S_IWUSR,
+		   inject_section_show, inject_section_store);
+static DEVICE_ATTR(inject_word, S_IRUGO | S_IWUSR,
+		   inject_word_show, inject_word_store);
+static DEVICE_ATTR(inject_ecc_vector, S_IRUGO | S_IWUSR,
+		   inject_ecc_vector_show, inject_ecc_vector_store);
+static DEVICE_ATTR(inject_write, S_IWUSR,
+		   NULL, inject_write_store);
+static DEVICE_ATTR(inject_read,  S_IWUSR,
+		   NULL, inject_read_store);
+
+static struct attribute *inj_attrs[] = {
+	&dev_attr_inject_section.attr,
+	&dev_attr_inject_word.attr,
+	&dev_attr_inject_ecc_vector.attr,
+	&dev_attr_inject_write.attr,
+	&dev_attr_inject_read.attr,
+	NULL
+};
+
+static umode_t inj_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
+	struct amd64_pvt *pvt = mci->pvt_info;
+
+	if (pvt->fam < 0x10)
+		return 0;
+	return attr->mode;
+}
+
+static const struct attribute_group inj_group = {
+	.attrs = inj_attrs,
+	.is_visible = inj_is_visible,
+};
+#endif /* CONFIG_EDAC_DEBUG */
 
 /*
  * Return the DramAddr that the SysAddr given by @sys_addr maps to.  It is
@@ -3465,9 +3694,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 static const struct attribute_group *amd64_edac_attr_groups[] = {
 #ifdef CONFIG_EDAC_DEBUG
 	&dbg_group,
-#endif
-#ifdef CONFIG_EDAC_AMD64_ERROR_INJECTION
-	&amd64_edac_inj_group,
+	&inj_group,
 #endif
 	NULL
 };
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 7c9f8c0b46d7..85aa820bc165 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -462,14 +462,6 @@ struct ecc_settings {
 	} flags;
 };
 
-#ifdef CONFIG_EDAC_DEBUG
-extern const struct attribute_group amd64_edac_dbg_group;
-#endif
-
-#ifdef CONFIG_EDAC_AMD64_ERROR_INJECTION
-extern const struct attribute_group amd64_edac_inj_group;
-#endif
-
 /*
  * Each of the PCI Device IDs types have their own set of hardware accessor
  * functions and per device encoding/decoding logic.
diff --git a/drivers/edac/amd64_edac_inj.c b/drivers/edac/amd64_edac_inj.c
deleted file mode 100644
index d96d6116f0fb..000000000000
--- a/drivers/edac/amd64_edac_inj.c
+++ /dev/null
@@ -1,235 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "amd64_edac.h"
-
-static ssize_t amd64_inject_section_show(struct device *dev,
-					 struct device_attribute *mattr,
-					 char *buf)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	return sprintf(buf, "0x%x\n", pvt->injection.section);
-}
-
-/*
- * store error injection section value which refers to one of 4 16-byte sections
- * within a 64-byte cacheline
- *
- * range: 0..3
- */
-static ssize_t amd64_inject_section_store(struct device *dev,
-					  struct device_attribute *mattr,
-					  const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(data, 10, &value);
-	if (ret < 0)
-		return ret;
-
-	if (value > 3) {
-		amd64_warn("%s: invalid section 0x%lx\n", __func__, value);
-		return -EINVAL;
-	}
-
-	pvt->injection.section = (u32) value;
-	return count;
-}
-
-static ssize_t amd64_inject_word_show(struct device *dev,
-					struct device_attribute *mattr,
-					char *buf)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	return sprintf(buf, "0x%x\n", pvt->injection.word);
-}
-
-/*
- * store error injection word value which refers to one of 9 16-bit word of the
- * 16-byte (128-bit + ECC bits) section
- *
- * range: 0..8
- */
-static ssize_t amd64_inject_word_store(struct device *dev,
-				       struct device_attribute *mattr,
-				       const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(data, 10, &value);
-	if (ret < 0)
-		return ret;
-
-	if (value > 8) {
-		amd64_warn("%s: invalid word 0x%lx\n", __func__, value);
-		return -EINVAL;
-	}
-
-	pvt->injection.word = (u32) value;
-	return count;
-}
-
-static ssize_t amd64_inject_ecc_vector_show(struct device *dev,
-					    struct device_attribute *mattr,
-					    char *buf)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	return sprintf(buf, "0x%x\n", pvt->injection.bit_map);
-}
-
-/*
- * store 16 bit error injection vector which enables injecting errors to the
- * corresponding bit within the error injection word above. When used during a
- * DRAM ECC read, it holds the contents of the of the DRAM ECC bits.
- */
-static ssize_t amd64_inject_ecc_vector_store(struct device *dev,
-				       struct device_attribute *mattr,
-				       const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(data, 16, &value);
-	if (ret < 0)
-		return ret;
-
-	if (value & 0xFFFF0000) {
-		amd64_warn("%s: invalid EccVector: 0x%lx\n", __func__, value);
-		return -EINVAL;
-	}
-
-	pvt->injection.bit_map = (u32) value;
-	return count;
-}
-
-/*
- * Do a DRAM ECC read. Assemble staged values in the pvt area, format into
- * fields needed by the injection registers and read the NB Array Data Port.
- */
-static ssize_t amd64_inject_read_store(struct device *dev,
-				       struct device_attribute *mattr,
-				       const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	unsigned long value;
-	u32 section, word_bits;
-	int ret;
-
-	ret = kstrtoul(data, 10, &value);
-	if (ret < 0)
-		return ret;
-
-	/* Form value to choose 16-byte section of cacheline */
-	section = F10_NB_ARRAY_DRAM | SET_NB_ARRAY_ADDR(pvt->injection.section);
-
-	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_ADDR, section);
-
-	word_bits = SET_NB_DRAM_INJECTION_READ(pvt->injection);
-
-	/* Issue 'word' and 'bit' along with the READ request */
-	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, word_bits);
-
-	edac_dbg(0, "section=0x%x word_bits=0x%x\n", section, word_bits);
-
-	return count;
-}
-
-/*
- * Do a DRAM ECC write. Assemble staged values in the pvt area and format into
- * fields needed by the injection registers.
- */
-static ssize_t amd64_inject_write_store(struct device *dev,
-					struct device_attribute *mattr,
-					const char *data, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-	u32 section, word_bits, tmp;
-	unsigned long value;
-	int ret;
-
-	ret = kstrtoul(data, 10, &value);
-	if (ret < 0)
-		return ret;
-
-	/* Form value to choose 16-byte section of cacheline */
-	section = F10_NB_ARRAY_DRAM | SET_NB_ARRAY_ADDR(pvt->injection.section);
-
-	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_ADDR, section);
-
-	word_bits = SET_NB_DRAM_INJECTION_WRITE(pvt->injection);
-
-	pr_notice_once("Don't forget to decrease MCE polling interval in\n"
-			"/sys/bus/machinecheck/devices/machinecheck<CPUNUM>/check_interval\n"
-			"so that you can get the error report faster.\n");
-
-	on_each_cpu(disable_caches, NULL, 1);
-
-	/* Issue 'word' and 'bit' along with the READ request */
-	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, word_bits);
-
- retry:
-	/* wait until injection happens */
-	amd64_read_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, &tmp);
-	if (tmp & F10_NB_ARR_ECC_WR_REQ) {
-		cpu_relax();
-		goto retry;
-	}
-
-	on_each_cpu(enable_caches, NULL, 1);
-
-	edac_dbg(0, "section=0x%x word_bits=0x%x\n", section, word_bits);
-
-	return count;
-}
-
-/*
- * update NUM_INJ_ATTRS in case you add new members
- */
-
-static DEVICE_ATTR(inject_section, S_IRUGO | S_IWUSR,
-		   amd64_inject_section_show, amd64_inject_section_store);
-static DEVICE_ATTR(inject_word, S_IRUGO | S_IWUSR,
-		   amd64_inject_word_show, amd64_inject_word_store);
-static DEVICE_ATTR(inject_ecc_vector, S_IRUGO | S_IWUSR,
-		   amd64_inject_ecc_vector_show, amd64_inject_ecc_vector_store);
-static DEVICE_ATTR(inject_write, S_IWUSR,
-		   NULL, amd64_inject_write_store);
-static DEVICE_ATTR(inject_read,  S_IWUSR,
-		   NULL, amd64_inject_read_store);
-
-static struct attribute *amd64_edac_inj_attrs[] = {
-	&dev_attr_inject_section.attr,
-	&dev_attr_inject_word.attr,
-	&dev_attr_inject_ecc_vector.attr,
-	&dev_attr_inject_write.attr,
-	&dev_attr_inject_read.attr,
-	NULL
-};
-
-static umode_t amd64_edac_inj_is_visible(struct kobject *kobj,
-					 struct attribute *attr, int idx)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
-	struct amd64_pvt *pvt = mci->pvt_info;
-
-	if (pvt->fam < 0x10)
-		return 0;
-	return attr->mode;
-}
-
-const struct attribute_group amd64_edac_inj_group = {
-	.attrs = amd64_edac_inj_attrs,
-	.is_visible = amd64_edac_inj_is_visible,
-};
-- 
2.29.2

