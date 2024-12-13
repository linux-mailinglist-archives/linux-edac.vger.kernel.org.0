Return-Path: <linux-edac+bounces-2708-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734A9F0230
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2024 02:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425012811B1
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2024 01:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2418027;
	Fri, 13 Dec 2024 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="dXEGbXjZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6952114;
	Fri, 13 Dec 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053215; cv=none; b=FviaMdulIKQM7qjqidWMc1owx17Tw81pa+CuqpwyE8FhLdN5NxeRWheRGokxNPnecOAGEGLDuXzsoLF6b9p4dmgCbJbtnGL8PhWPQhcghy6tHxGcdlpo1zmGhME5zPPc6wJp09UtThvAm6RKMOeS22b2EfenbhBDJagKXpILYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053215; c=relaxed/simple;
	bh=VGHG0qHhgbiXH4T7pWO4pCdBYAgUCkk71JVt6/ftIGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNkxU/YiWyvJIAQPh4FZ+i0pCokUf7Z1smorUOqsC3bukg+nHeIiRbVI3GQqvKWpdx28Jnwe43ZogjRxCn6yTNqiRcwsVMgIfuOLy+pPZ6qNIjyhdKtwRz8o4oDhMzhyciPfOCw4Wm5+1Vdf8vYZJQUAg3l26gUVs0PjxC/BC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=dXEGbXjZ; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD0cOQC016948;
	Fri, 13 Dec 2024 01:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=+kNqt8gT4XcT8FfWVtVN5U7vj2wrzXxkwSHKL
	/HeMAU=; b=dXEGbXjZXB216MTCHPDJNbG/h/7kno9IKS5tvOfcw+XmoP8W2kYLH
	VMqJOrzKdI+V/XNYRqD7N8ZAMwT2rnjwHf1wrkkaEkLoAFJHdtIH371C2FEUCCEv
	y6jxUCfnjdBehMxfTTRuvtouW2iDVyIXwQyHixdnQH9glpziW3e1ZGqilSgHVYiO
	PBxoetJpFZDI8jeTe7Gm+fMpkaJ+XviqHQvTFv+c1JzgO/fNvrDKPH9d+Lw9cggj
	YwB2VoJh4kDkHhEvI3NYCrUNN1gwhOElIZ+5ciYHG0rfub9sfiLSbiQ/8cb3T2oW
	Ks8hVApG30nW4HbMI/ShPlJB70HlG0dBA==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43gaj80apw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 01:26:17 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B8AA82BADA;
	Fri, 13 Dec 2024 01:26:16 +0000 (UTC)
Received: from cat.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2722A80C15A;
	Fri, 13 Dec 2024 01:26:15 +0000 (UTC)
Received: by cat.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 4BE2CB490D; Thu, 12 Dec 2024 19:26:15 -0600 (CST)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: tony.luck@intel.com, bp@alien8.de, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v2] EDAC/{i10nm,skx,skx_common}: Support UV systems
Date: Thu, 12 Dec 2024 19:25:49 -0600
Message-Id: <20241213012549.43099-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i5eKDRReObgBuHTFJTnHfUYCAPwc8P_0
X-Proofpoint-ORIG-GUID: i5eKDRReObgBuHTFJTnHfUYCAPwc8P_0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130009

The 3-bit source IDs in PCI configuration space registers, used to map
devices to sockets, are limited to 8 unique IDs, and each ID is local to
a UPI/QPI domain.

Source IDs cannot be used to map devices to sockets on UV systems
because they can exceed 8 sockets and have multiple UPI/QPI domains with
identical, repeating source IDs.

Use NUMA information to get package IDs instead of source IDs on UV
systems, and use package/source IDs to name IMC information structures.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---

v1 -> v2:
 * Instead of checking for duplicate source IDs to determine if a system
   has multiple UPI/QPI domains, just check if it's a UV system.
 * https://lore.kernel.org/all/20241205165954.7957-1-kyle.meyer@hpe.com

 drivers/edac/i10nm_base.c | 11 +++------
 drivers/edac/skx_base.c   |  9 +++-----
 drivers/edac/skx_common.c | 47 +++++++++++++++++++++++++++------------
 drivers/edac/skx_common.h |  3 +--
 4 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 51556c72a967..16d1110c0692 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1010,7 +1010,7 @@ static struct notifier_block i10nm_mce_dec = {
 
 static int __init i10nm_init(void)
 {
-	u8 mc = 0, src_id = 0, node_id = 0;
+	u8 mc = 0, src_id = 0;
 	const struct x86_cpu_id *id;
 	struct res_config *cfg;
 	const char *owner;
@@ -1070,19 +1070,14 @@ static int __init i10nm_init(void)
 		if (rc < 0)
 			goto fail;
 
-		rc = skx_get_node_id(d, &node_id);
-		if (rc < 0)
-			goto fail;
-
-		edac_dbg(2, "src_id = %d node_id = %d\n", src_id, node_id);
+		edac_dbg(2, "src_id = %d\n", src_id);
 		for (i = 0; i < imc_num; i++) {
 			if (!d->imc[i].mdev)
 				continue;
 
 			d->imc[i].mc  = mc++;
 			d->imc[i].lmc = i;
-			d->imc[i].src_id  = src_id;
-			d->imc[i].node_id = node_id;
+			d->imc[i].src_id = src_id;
 			if (d->imc[i].hbm_mc) {
 				d->imc[i].chan_mmio_sz = cfg->hbm_chan_mmio_sz;
 				d->imc[i].num_channels = cfg->hbm_chan_num;
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 14cfd394b469..93f7c05faccc 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -600,7 +600,7 @@ static int __init skx_init(void)
 	const struct munit *m;
 	const char *owner;
 	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
-	u8 mc = 0, src_id, node_id;
+	u8 mc = 0, src_id;
 	struct skx_dev *d;
 
 	edac_dbg(2, "\n");
@@ -650,15 +650,12 @@ static int __init skx_init(void)
 		rc = skx_get_src_id(d, 0xf0, &src_id);
 		if (rc < 0)
 			goto fail;
-		rc = skx_get_node_id(d, &node_id);
-		if (rc < 0)
-			goto fail;
-		edac_dbg(2, "src_id=%d node_id=%d\n", src_id, node_id);
+
+		edac_dbg(2, "src_id = %d\n", src_id);
 		for (i = 0; i < SKX_NUM_IMC; i++) {
 			d->imc[i].mc = mc++;
 			d->imc[i].lmc = i;
 			d->imc[i].src_id = src_id;
-			d->imc[i].node_id = node_id;
 			rc = skx_register_mci(&d->imc[i], d->imc[i].chan[0].cdev,
 					      "Skylake Socket", EDAC_MOD_STR,
 					      skx_get_dimm_config, cfg);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 6cf17af7d911..f7bd930e058f 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -19,6 +19,7 @@
 #include <linux/adxl.h>
 #include <acpi/nfit.h>
 #include <asm/mce.h>
+#include <asm/uv/uv.h>
 #include "edac_module.h"
 #include "skx_common.h"
 
@@ -221,33 +222,51 @@ void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 }
 EXPORT_SYMBOL_GPL(skx_set_decode);
 
-int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
+static int skx_get_pkg_id(struct skx_dev *d, u8 *id)
 {
-	u32 reg;
+	int node;
+	int cpu;
 
-	if (pci_read_config_dword(d->util_all, off, &reg)) {
-		skx_printk(KERN_ERR, "Failed to read src id\n");
-		return -ENODEV;
+	node = pcibus_to_node(d->util_all->bus);
+	if (numa_valid_node(node)) {
+		for_each_cpu(cpu, cpumask_of_pcibus(d->util_all->bus)) {
+			struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+			if (c->initialized && cpu_to_node(cpu) == node) {
+				*id = c->topo.pkg_id;
+				return 0;
+			}
+		}
 	}
 
-	*id = GET_BITFIELD(reg, 12, 14);
-	return 0;
+	skx_printk(KERN_ERR, "Failed to get package ID from NUMA information\n");
+	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(skx_get_src_id);
 
-int skx_get_node_id(struct skx_dev *d, u8 *id)
+int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 {
 	u32 reg;
 
-	if (pci_read_config_dword(d->util_all, 0xf4, &reg)) {
-		skx_printk(KERN_ERR, "Failed to read node id\n");
+	/*
+	 * The 3-bit source IDs in PCI configuration space registers are limited
+	 * to 8 unique IDs, and each ID is local to a UPI/QPI domain.
+	 *
+	 * Source IDs cannot be used to map devices to sockets on UV systems
+	 * because they can exceed 8 sockets and have multiple UPI/QPI domains
+	 * with identical, repeating source IDs.
+	 */
+	if (is_uv_system())
+		return skx_get_pkg_id(d, id);
+
+	if (pci_read_config_dword(d->util_all, off, &reg)) {
+		skx_printk(KERN_ERR, "Failed to read src id\n");
 		return -ENODEV;
 	}
 
-	*id = GET_BITFIELD(reg, 0, 2);
+	*id = GET_BITFIELD(reg, 12, 14);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(skx_get_node_id);
+EXPORT_SYMBOL_GPL(skx_get_src_id);
 
 static int get_width(u32 mtr)
 {
@@ -507,7 +526,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	pvt->imc = imc;
 
 	mci->ctl_name = kasprintf(GFP_KERNEL, "%s#%d IMC#%d", ctl_name,
-				  imc->node_id, imc->lmc);
+				  imc->src_id, imc->lmc);
 	if (!mci->ctl_name) {
 		rc = -ENOMEM;
 		goto fail0;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 54bba8a62f72..b0845bdd4516 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -103,7 +103,7 @@ struct skx_dev {
 		bool hbm_mc;
 		u8 mc;	/* system wide mc# */
 		u8 lmc;	/* socket relative mc# */
-		u8 src_id, node_id;
+		u8 src_id;
 		struct skx_channel {
 			struct pci_dev	*cdev;
 			struct pci_dev	*edev;
@@ -244,7 +244,6 @@ void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
-int skx_get_node_id(struct skx_dev *d, u8 *id);
 
 int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 
-- 
2.47.1


