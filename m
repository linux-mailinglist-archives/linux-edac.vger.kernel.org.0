Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B431B7E6F
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDXS5l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 14:57:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:21121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgDXS5k (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Apr 2020 14:57:40 -0400
IronPort-SDR: vJQbHb1yfMa0bajxOZWDydS+Zjccw+b8M4Ao6P+pw36OsEAtmWj9xkTC9GgDeuCyo1sCmOp9c0
 L0F6s8VFqCuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 11:57:39 -0700
IronPort-SDR: qGAbW3+tf8q/XCpcmcJS7MI9gCD5cfe0rTht3/0WSOOlenq7St1CsdlEva/i2INAuyFhLoTj8u
 MpxETXisVMTw==
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="430893781"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 11:57:39 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 1/2] EDAC, {skx,i10nm}: Make some configurations CPU model specific
Date:   Fri, 24 Apr 2020 11:57:37 -0700
Message-Id: <20200424185738.7985-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424185738.7985-1-tony.luck@intel.com>
References: <20200424185738.7985-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The device ID for configuration agent PCI device and the offset for
bus number configuration register can be CPU model specific. So add
a new structure res_config to make them configurable and pass res_config
to {skx,i10nm}_init() and skx_get_all_bus_mappings() for use.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 16 ++++++++++++----
 drivers/edac/skx_base.c   | 12 ++++++++++--
 drivers/edac/skx_common.c | 11 +++++------
 drivers/edac/skx_common.h | 11 +++++++++--
 4 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index df08de963d10..ba4578c6ef2b 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -122,10 +122,16 @@ static int i10nm_get_all_munits(void)
 	return 0;
 }
 
+static struct res_config i10nm_cfg = {
+	.type			= I10NM,
+	.decs_did		= 0x3452,
+	.busno_cfg_offset	= 0xcc,
+};
+
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
@@ -234,6 +240,7 @@ static int __init i10nm_init(void)
 {
 	u8 mc = 0, src_id = 0, node_id = 0;
 	const struct x86_cpu_id *id;
+	struct res_config *cfg;
 	const char *owner;
 	struct skx_dev *d;
 	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
@@ -248,12 +255,13 @@ static int __init i10nm_init(void)
 	id = x86_match_cpu(i10nm_cpuids);
 	if (!id)
 		return -ENODEV;
+	cfg = (struct res_config *)id->driver_data;
 
 	rc = skx_get_hi_lo(0x09a2, off, &tolm, &tohm);
 	if (rc)
 		return rc;
 
-	rc = skx_get_all_bus_mappings(0x3452, 0xcc, I10NM, &i10nm_edac_list);
+	rc = skx_get_all_bus_mappings(cfg, &i10nm_edac_list);
 	if (rc < 0)
 		goto fail;
 	if (rc == 0) {
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 46a3a3440f5e..ae2c2b516adc 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -157,8 +157,14 @@ static int get_all_munits(const struct munit *m)
 	return -ENODEV;
 }
 
+static struct res_config skx_cfg = {
+	.type			= SKX,
+	.decs_did		= 0x2016,
+	.busno_cfg_offset	= 0xcc,
+};
+
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	&skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
@@ -641,6 +647,7 @@ static inline void teardown_skx_debug(void) {}
 static int __init skx_init(void)
 {
 	const struct x86_cpu_id *id;
+	struct res_config *cfg;
 	const struct munit *m;
 	const char *owner;
 	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
@@ -656,12 +663,13 @@ static int __init skx_init(void)
 	id = x86_match_cpu(skx_cpuids);
 	if (!id)
 		return -ENODEV;
+	cfg = (struct res_config *)id->driver_data;
 
 	rc = skx_get_hi_lo(0x2034, off, &skx_tolm, &skx_tohm);
 	if (rc)
 		return rc;
 
-	rc = skx_get_all_bus_mappings(0x2016, 0xcc, SKX, &skx_edac_list);
+	rc = skx_get_all_bus_mappings(cfg, &skx_edac_list);
 	if (rc < 0)
 		goto fail;
 	if (rc == 0) {
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 99bbaf629b8d..abc9ddd2b7d1 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -197,12 +197,11 @@ static int get_width(u32 mtr)
 }
 
 /*
- * We use the per-socket device @did to count how many sockets are present,
+ * We use the per-socket device @cfg->did to count how many sockets are present,
  * and to detemine which PCI buses are associated with each socket. Allocate
  * and build the full list of all the skx_dev structures that we need here.
  */
-int skx_get_all_bus_mappings(unsigned int did, int off, enum type type,
-			     struct list_head **list)
+int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 {
 	struct pci_dev *pdev, *prev;
 	struct skx_dev *d;
@@ -211,7 +210,7 @@ int skx_get_all_bus_mappings(unsigned int did, int off, enum type type,
 
 	prev = NULL;
 	for (;;) {
-		pdev = pci_get_device(PCI_VENDOR_ID_INTEL, did, prev);
+		pdev = pci_get_device(PCI_VENDOR_ID_INTEL, cfg->decs_did, prev);
 		if (!pdev)
 			break;
 		ndev++;
@@ -221,7 +220,7 @@ int skx_get_all_bus_mappings(unsigned int did, int off, enum type type,
 			return -ENOMEM;
 		}
 
-		if (pci_read_config_dword(pdev, off, &reg)) {
+		if (pci_read_config_dword(pdev, cfg->busno_cfg_offset, &reg)) {
 			kfree(d);
 			pci_dev_put(pdev);
 			skx_printk(KERN_ERR, "Failed to read bus idx\n");
@@ -230,7 +229,7 @@ int skx_get_all_bus_mappings(unsigned int did, int off, enum type type,
 
 		d->bus[0] = GET_BITFIELD(reg, 0, 7);
 		d->bus[1] = GET_BITFIELD(reg, 8, 15);
-		if (type == SKX) {
+		if (cfg->type == SKX) {
 			d->seg = pci_domain_nr(pdev->bus);
 			d->bus[2] = GET_BITFIELD(reg, 16, 23);
 			d->bus[3] = GET_BITFIELD(reg, 24, 31);
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 60d1ea669afd..19dd8c099520 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -112,6 +112,14 @@ struct decoded_addr {
 	int	bank_group;
 };
 
+struct res_config {
+	enum type type;
+	/* Configuration agent device ID */
+	unsigned int decs_did;
+	/* Default bus number configuration register offset */
+	int busno_cfg_offset;
+};
+
 typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci);
 typedef bool (*skx_decode_f)(struct decoded_addr *res);
 typedef void (*skx_show_retry_log_f)(struct decoded_addr *res, char *msg, int len);
@@ -123,8 +131,7 @@ void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
 
-int skx_get_all_bus_mappings(unsigned int did, int off, enum type,
-			     struct list_head **list);
+int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm);
 
-- 
2.21.1

