Return-Path: <linux-edac+bounces-1631-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D694C0BA
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE38C1C22759
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F418F2FE;
	Thu,  8 Aug 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="k8QvTiS3"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F418E056;
	Thu,  8 Aug 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130093; cv=none; b=sUxvJe9tlPJQR5Qizr/owuoE92aeHJ8aMf7zSjGszfCGwSUTPyYGL3zEes+X1a8sOtc6hrGZMWNprlqSxrzTSKAigZi2Wu7Mj6/7duqohYoPe6hLepmK7i1z2oL7ajxpbrYxClWoCcR3h1jqaFfQgShGz/p8hcGcLe/rT9f4unU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130093; c=relaxed/simple;
	bh=V+txiutig01/lSTX5GU2xXQ/Ecok4xMPvtbSdLTFmbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdWza0aHbhdGmycPupn1mf9/7Z0iW3Cbrh19kJg7LEmzxXbQq3kYUqqd6d6hPTdQUxKECHCUUZJADPtd0xs+EgKtvG5JHr5Mgiu/LvybnFuPgjc2kkDMDMa3YQkcnym5lbY0JNxqxehX/FqziTsUuEIFkbsoplAvN8H44yC5ZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=k8QvTiS3; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1723130091; x=1754666091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V+txiutig01/lSTX5GU2xXQ/Ecok4xMPvtbSdLTFmbo=;
  b=k8QvTiS3n0EhWghdASQMXesk08qk70sKaZ3ebuM2O3yMm+kmXlFzVGNV
   SSjyb5406EzST8Yxiok3BELp4YXME+GvDQ3qB82FbAb/Rw1lPzv8MkmsI
   i2EpMeMEUe3PpKfOU2Y36NZs06pCslAapZGCwdqfdpcX1o81aqnjjTQvp
   F4a0IWcE/mPZxPfC/HN1sRjjqi3pIRaOWhFo5Imksld7dCCcKq6jW64ed
   SI17xspGFRoLxtjPyDK0Z76rEfqilj/8kBfvalThwy92arfmBk1q6eN9S
   1fOoGDduWmW6OLLKLDOjR6fAk/sIoCijlNI9YlDoq4pSl0FGNOQ5/P9X2
   Q==;
X-CSE-ConnectionGUID: TaI/qgQ0TdC5GMZuaMk6uw==
X-CSE-MsgGUID: omIfqhIhQHuYq4lFtHo7Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="149619046"
X-IronPort-AV: E=Sophos;i="6.09,273,1716217200"; 
   d="scan'208";a="149619046"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:13:35 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 68D0CD9041;
	Fri,  9 Aug 2024 00:13:33 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A6020D3F21;
	Fri,  9 Aug 2024 00:13:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C8E72007FADD;
	Fri,  9 Aug 2024 00:13:32 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4D8B81A000A;
	Thu,  8 Aug 2024 23:13:31 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-mm@kvack.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com
Cc: bp@alien8.de,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	james.morse@arm.com,
	linmiaohe@huawei.com,
	mchehab@kernel.org,
	nao.horiguchi@gmail.com,
	rric@kernel.org,
	tony.luck@intel.com,
	ruansy.fnst@fujitsu.com
Subject: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
Date: Thu,  8 Aug 2024 23:13:28 +0800
Message-Id: <20240808151328.707869-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28584.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28584.000
X-TMASE-Result: 10--16.139300-10.000000
X-TMASE-MatchedRID: mBR/8PU27l8ZHQl0dvECsazGfgakLdjaKQNhMboqZlpqrsOvUFEKy3kY
	O/9k4Xg2bn+bq+W8j6XQJxNDXN5QxO4rOj+PdZuMVnzlQiaE21qxXA8wqNmbVrwYtb0g7Ywtu0m
	nSBAOWht+3E64qYVhyfoS5B31PW6f3tF9vYxzQ43wgrvJFY9E0Vvh1cEykiSGLX3qyf3ewG+qbv
	7m/AcFJSbOYzaQt2Phra3G1NjT5m2njNSDi/vkV02xVQmDwU6mCZa9cSpBObnAuQ0xDMaXkH4qt
	YI9sRE/4K9FmervsqWylFSPywhifTBF72xzhJLNyRfzRkrgkUHzWEMQjooUzbs3Yh2IOCYz/svd
	Vly7w9ldRSgb+5TWboftADTYJ316uybvDkIalGDHyCtnYFmFhoIw3bnTjwR6icvz9DxarMGk86u
	MB98iNvBn25uFP/vzYcMGA+vBhspccQ8eam5EfRRFJJyf5BJe3QfwsVk0UbslCGssfkpInQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since CXL device is a memory device, while CPU is consuming a poison
page of CXL device, it always triggers a MCE (via interrupt #18) and
calls memory_failure() to handle POISON page, no matter which-First path
is configured.  CXL device could also find and report the POISON, kernel
now not only traces but also calls memory_failure() to handle it, which
is marked as "NEW" in the figure blow.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure() <---------------------------- EXISTS
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
                                                  \-> memory_failure()
                                                      ^----- NEW
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
                        \-> memory_failure()
                            ^------------------------------- NEW
```

But in this way, the memory_failure() could be called twice or even at
same time, as is shown in the figure above: (1.) and (2.a or 2.b),
before the POISON page is cleared.  memory_failure() has it own mutex
lock so it actually won't be called at same time and the later call
could be avoided because HWPoison bit has been set.  However, assume
such a scenario, "CXL device reports POISON error" triggers 1st call,
user see it from log and want to clear the poison by executing `cxl
clear-poison` command, and at the same time, a process tries to access
this POISON page, which triggers MCE (it's the 2nd call).  Since there
is no lock between the 2nd call with clearing poison operation, race
condition may happen, which may cause HWPoison bit of the page in an
unknown state.

Thus, we have to avoid the 2nd call. This patch[2] introduces a new
notifier_block into `x86_mce_decoder_chain` and a POISON cache list, to
stop the 2nd call of memory_failure(). It checks whether the current
poison page has been reported (if yes, stop the notifier chain, don't
call the following memory_failure() to report again).

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 arch/x86/include/asm/mce.h |   1 +
 drivers/cxl/core/mbox.c    | 115 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c  |   6 +-
 drivers/cxl/cxlmem.h       |   3 +
 4 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3ad29b128943..5da45e870858 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -182,6 +182,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_NFIT,
 	MCE_PRIO_EXTLOG,
 	MCE_PRIO_UC,
+	MCE_PRIO_CXL,
 	MCE_PRIO_EARLY,
 	MCE_PRIO_CEC,
 	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0cb6ef2e6600..b21700428c35 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,8 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <asm/mce.h>
 #include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -925,6 +927,9 @@ void cxl_event_handle_record(struct cxl_memdev *cxlmd,
 		if (cxlr)
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
 
+		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
+			return;
+
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						&evt->gen_media);
@@ -1457,6 +1462,112 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
 
+DEFINE_XARRAY(cxl_mce_records);
+
+bool cxl_mce_recorded(u64 hpa)
+{
+	XA_STATE(xas, &cxl_mce_records, hpa);
+	void *entry;
+
+	xas_lock_irq(&xas);
+	entry = xas_load(&xas);
+	if (entry) {
+		xas_unlock_irq(&xas);
+		return true;
+	}
+	entry = xa_mk_value(hpa);
+	xas_store(&xas, entry);
+	xas_unlock_irq(&xas);
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mce_recorded, CXL);
+
+void cxl_mce_clear(u64 hpa)
+{
+	XA_STATE(xas, &cxl_mce_records, hpa);
+	void *entry;
+
+	xas_lock_irq(&xas);
+	entry = xas_load(&xas);
+	if (entry) {
+		xas_store(&xas, NULL);
+	}
+	xas_unlock_irq(&xas);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mce_clear, CXL);
+
+struct cxl_contains_hpa_context {
+	bool contains;
+	u64 hpa;
+};
+
+static int __cxl_contains_hpa(struct device *dev, void *arg)
+{
+	struct cxl_contains_hpa_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	struct range *range;
+	u64 hpa = ctx->hpa;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	range = &cxled->cxld.hpa_range;
+
+	if (range->start <= hpa && hpa <= range->end) {
+		ctx->contains = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
+{
+	struct cxl_contains_hpa_context ctx = {
+		.contains = false,
+		.hpa = hpa,
+	};
+	struct cxl_port *port;
+
+	port = cxlmd->endpoint;
+	guard(rwsem_write)(&cxl_region_rwsem);
+	if (port && cxl_num_decoders_committed(port))
+		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
+
+	return ctx.contains;
+}
+
+static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
+			  void *data)
+{
+	struct mce *mce = (struct mce *)data;
+	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
+						    mce_notifier);
+	u64 hpa;
+
+	if (!mce || !mce_usable_address(mce))
+		return NOTIFY_DONE;
+
+	hpa = mce->addr & MCI_ADDR_PHYSADDR;
+
+	/* Check if the PFN is located on this CXL device */
+	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
+	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
+		return NOTIFY_DONE;
+
+	/*
+	 * Search PFN in the cxl_mce_records, if already exists, don't continue
+	 * to do memory_failure() to avoid a poison address being reported
+	 * more than once.
+	 */
+	if (cxl_mce_recorded(hpa))
+		return NOTIFY_STOP;
+	else
+		return NOTIFY_OK;
+}
+
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
@@ -1476,6 +1587,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
+	mds->mce_notifier.notifier_call = cxl_handle_mce;
+	mds->mce_notifier.priority = MCE_PRIO_CXL;
+	mce_register_decode_chain(&mds->mce_notifier);
+
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..9d4ed4dc4d51 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		goto out;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
-	if (cxlr)
+	if (cxlr) {
+		u64 hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
+
+		cxl_mce_clear(hpa);
 		dev_warn_once(mds->cxlds.dev,
 			      "poison clear dpa:%#llx region: %s\n", dpa,
 			      dev_name(&cxlr->dev));
+	}
 
 	record = (struct cxl_poison_record) {
 		.address = cpu_to_le64(dpa),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5c4810dcbdeb..d2d906c26755 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -502,6 +502,7 @@ struct cxl_memdev_state {
 	struct cxl_fw_state fw;
 
 	struct rcuwait mbox_wait;
+	struct notifier_block mce_notifier;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
 			 struct cxl_mbox_cmd *cmd);
 };
@@ -837,6 +838,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
+bool cxl_mce_recorded(u64 pfn);
+void cxl_mce_clear(u64 pfn);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
-- 
2.34.1


