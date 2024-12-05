Return-Path: <linux-edac+bounces-2646-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B79E5D19
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F7016414E
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2841224AFB;
	Thu,  5 Dec 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mc5ZDm6E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84B218AAB;
	Thu,  5 Dec 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419707; cv=none; b=aLqEzedcxM8++fYB+AzQVb5HXNN+hXAexYcjQkAJpaFWo+GsSdpZrRU5sqv5BLBokGVClQYcJb8iHQCBaocbZHa7en3nsJYbPUwkS+a6S8yHVoRGMStP5oVH2ujkwSM3PVt97jwthgR50J1ev058BnijrDYG3FcXbJMiPvncMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419707; c=relaxed/simple;
	bh=wPPo0g4fxDEgFUaSl2mauHZ4iYZc3o4TT1v8WNrTVAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bIKsM4zlsymNbL8piHM6UpFYX51zXbtrd4hwUC/N8zBTU5zGMPK5lyZKIjj08G2q+Y2N4WWGDzz1EUbcSxgWELTzBvdy/6iSxgRXykwZo+wx3avOkPZupqBk76zGUqoYj1zuiw2Kv39yzXHi8Jq4YiWLJPq71Y6vk4B7SbFKP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mc5ZDm6E; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5GwbxX008297;
	Thu, 5 Dec 2024 17:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=g4nBMB2P6jlcgfvUcApUSO9goh7Wa8tZE+pJS
	hCD/4M=; b=mc5ZDm6EZbc7Y/1cvhH2BJxl553h1J96jLlZi1LIiUmWBO1hwYtMN
	nxyzyaTq+TbvS5ORT137o9ebTvBf6hQ3kBk0OOpaB1OX29DGPDPUoyaa1PXhfKYV
	A10HTKsL113tRRnJ2JHaLukk0bCcnqvFziT5A4JB6yUD6J/+HEPjw1iJXJUFDmcd
	1Ayv6f2H6wKenuJEtgWJgWuXmSnUdaraOYO6tEKKCekyvoOQbX6gGkvBsF35jVik
	moGEWyLhoT6NDkjNSzdHWa30pGcJhKAO6cBgJ+D6vhjKfUc89TG66UPT7o68mdhl
	6rPMjTiK7/2B6mvH7W7PhtWb4spjowWPw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43bg5m80x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:00:51 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 1F309806B7C;
	Thu,  5 Dec 2024 17:00:51 +0000 (UTC)
Received: from cat.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id C767281298D;
	Thu,  5 Dec 2024 17:00:50 +0000 (UTC)
Received: by cat.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id C4F0AB490D; Thu,  5 Dec 2024 11:00:49 -0600 (CST)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: tony.luck@intel.com, bp@alien8.de, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Date: Thu,  5 Dec 2024 10:59:54 -0600
Message-Id: <20241205165954.7957-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i_NFms050yxzQ7EyI385ecErI3lOcPz9
X-Proofpoint-ORIG-GUID: i_NFms050yxzQ7EyI385ecErI3lOcPz9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050124

The 3-bit source IDs in PCI configuration space registers are limited to
8 unique IDs, and each ID is local to a clump (UPI/QPI domain).

Source IDs can not be used to map devices to sockets on systems with
multiple clumps because each clump has identical repeating source IDs.

Get package IDs instead of source IDs on systems with multiple clumps
and use package/source IDs to name IMC information structures.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 drivers/edac/i10nm_base.c | 21 +++++++++-------
 drivers/edac/skx_base.c   | 19 ++++++++------
 drivers/edac/skx_common.c | 52 +++++++++++++++++++++++++++++++++------
 drivers/edac/skx_common.h |  5 ++--
 4 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 51556c72a967..59384677d025 100644
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
@@ -1018,6 +1018,7 @@ static int __init i10nm_init(void)
 	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
 	u64 tolm, tohm;
 	int imc_num;
+	int dup_src_ids = 0;
 
 	edac_dbg(2, "\n");
 
@@ -1065,24 +1066,26 @@ static int __init i10nm_init(void)
 
 	imc_num = res_cfg->ddr_imc_num + res_cfg->hbm_imc_num;
 
-	list_for_each_entry(d, i10nm_edac_list, list) {
-		rc = skx_get_src_id(d, 0xf8, &src_id);
-		if (rc < 0)
-			goto fail;
+	rc = dup_src_ids = skx_check_dup_src_ids(0xf8);
+	if (rc < 0)
+		goto fail;
 
-		rc = skx_get_node_id(d, &node_id);
+	list_for_each_entry(d, i10nm_edac_list, list) {
+		if (dup_src_ids)
+			rc = skx_get_pkg_id(d, &src_id);
+		else
+			rc = skx_get_src_id(d, 0xf8, &src_id);
 		if (rc < 0)
 			goto fail;
 
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
index 14cfd394b469..189b8c5a1bda 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -600,8 +600,9 @@ static int __init skx_init(void)
 	const struct munit *m;
 	const char *owner;
 	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
-	u8 mc = 0, src_id, node_id;
+	u8 mc = 0, src_id;
 	struct skx_dev *d;
+	int dup_src_ids = 0;
 
 	edac_dbg(2, "\n");
 
@@ -646,19 +647,23 @@ static int __init skx_init(void)
 		}
 	}
 
+	rc = dup_src_ids = skx_check_dup_src_ids(0xf0);
+	if (rc < 0)
+		goto fail;
+
 	list_for_each_entry(d, skx_edac_list, list) {
-		rc = skx_get_src_id(d, 0xf0, &src_id);
-		if (rc < 0)
-			goto fail;
-		rc = skx_get_node_id(d, &node_id);
+		if (dup_src_ids)
+			rc = skx_get_pkg_id(d, &src_id);
+		else
+			rc = skx_get_src_id(d, 0xf0, &src_id);
 		if (rc < 0)
 			goto fail;
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
index 6cf17af7d911..56fec7310f40 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -235,19 +235,55 @@ int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 }
 EXPORT_SYMBOL_GPL(skx_get_src_id);
 
-int skx_get_node_id(struct skx_dev *d, u8 *id)
+int skx_check_dup_src_ids(int off)
 {
-	u32 reg;
+	u8 id;
+	struct skx_dev *d;
+	int rc;
+	DECLARE_BITMAP(id_map, 8);
 
-	if (pci_read_config_dword(d->util_all, 0xf4, &reg)) {
-		skx_printk(KERN_ERR, "Failed to read node id\n");
-		return -ENODEV;
+	bitmap_zero(id_map, 8);
+
+	/*
+	 * The 3-bit source IDs in PCI configuration space registers are limited
+	 * to 8 unique IDs, and each ID is local to a clump (UPI/QPI domain).
+	 */
+	list_for_each_entry(d, &dev_edac_list, list) {
+		rc = skx_get_src_id(d, off, &id);
+		if (rc < 0)
+			return rc;
+
+		if (test_bit(id, id_map))
+			return 1;
+
+		set_bit(id, id_map);
 	}
 
-	*id = GET_BITFIELD(reg, 0, 2);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(skx_get_node_id);
+EXPORT_SYMBOL_GPL(skx_check_dup_src_ids);
+
+int skx_get_pkg_id(struct skx_dev *d, u8 *id)
+{
+	int node;
+	int cpu;
+
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
+	}
+
+	skx_printk(KERN_ERR, "Failed to get package ID from NUMA information\n");
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(skx_get_pkg_id);
 
 static int get_width(u32 mtr)
 {
@@ -507,7 +543,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	pvt->imc = imc;
 
 	mci->ctl_name = kasprintf(GFP_KERNEL, "%s#%d IMC#%d", ctl_name,
-				  imc->node_id, imc->lmc);
+				  imc->src_id, imc->lmc);
 	if (!mci->ctl_name) {
 		rc = -ENOMEM;
 		goto fail0;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 54bba8a62f72..0f06d45c9b3e 100644
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
@@ -244,7 +244,8 @@ void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
-int skx_get_node_id(struct skx_dev *d, u8 *id);
+int skx_check_dup_src_ids(int off);
+int skx_get_pkg_id(struct skx_dev *d, u8 *id);
 
 int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 
-- 
2.47.1


