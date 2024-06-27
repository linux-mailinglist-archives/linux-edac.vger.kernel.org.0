Return-Path: <linux-edac+bounces-1415-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604D91AE30
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CF61C2249A
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCDE1A2551;
	Thu, 27 Jun 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJZfiG5v"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82B1A0B1A;
	Thu, 27 Jun 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509608; cv=none; b=a0Jt4bk37vx4q9rvpM9BElHe6sPuY3d82mEaoJX8Rz/DSH51eOERkyKj3xaYz3DXO1nf8Gx5pl5Khfoy6/ykXUu+A3Q0nevU4AsFM3cc+N3/3Jz70hRQ0K5IlMBSFTTcC1NzV2Vbdw8FYCCfh8Ep0KBkr+430z2tb98RFrtKSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509608; c=relaxed/simple;
	bh=6B6Tpt1w4sn/bIgMPp7pvJk1hOV3D2hTkiL04D6oqzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsqEmV9wSGDxbhxHFFaDMC9sC+q6yAIzxI1BzU00TspAdOmjdg433WhP5rIwOkLgAI+ecVU+wWDI9/vpgzGG99ozECFK8nQvnYwDizXn6FTbvS2FJZinI6oaIcw0uWNVb8Sm4AX7o2KLFxsdVVpSi71pO8o6U9JbEbfQt8Ihn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJZfiG5v; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso57529401fa.0;
        Thu, 27 Jun 2024 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509605; x=1720114405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4pJwmF1jgNFUD7Oai7hAjVVVwHSeVorw9V3FwoAE0Y=;
        b=dJZfiG5vnj7bi3LTrlAO98kehe4Mnwz0A8JPmfWhj77jOEziF6MIcHiPXb59oaq9bd
         zJJjH846T6TG901Q7ma0NQMjl1xDZwVO532vh7ssEyAbBskx4v5/DQW/TUghGP1qIjV2
         SHhiPyXXbTe8MjAMTnyjLj8HExTFGX5L0bSEinX368+1ggbMZyWsmQB76fxZRV5oz+27
         7BJXe95xBY/GHOzATKQupP1kZTWuhXz8Nc24tLMo+fMZFSklkGtyI4nxPb2/OUJhinaX
         WPb8eSnSwodXpcebl85798Fy5YN52ZpEbZDwJOY9yYXGRa8jedmjGY+1f4WhMrIMlDVT
         OOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509605; x=1720114405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4pJwmF1jgNFUD7Oai7hAjVVVwHSeVorw9V3FwoAE0Y=;
        b=ZxeWGr6Q0Uq6lrpavET9hI4EQqJprfmy9WXBcuYPNx1WtuzZenb0qzt97261m8jymL
         PYitOMltxXUaZkreIvJV5OHzVvMJMIWo2hAyKsNTsYTx5HVtnUPtHzhBPpXjC63XZm5j
         yl8a2y4d0Kj/Ocxg7hPsJzF/L3aTXQsxN01ZLqc+0uneGQUpvfPyjUF5P1H5YriqrGyV
         vi///vsvg2h5YM7X5kXyMnnC4TLLv47ZIx9KtSECNiKikTTPBJ72xnlatzeWxHb9mSie
         MuwNlHClhWVAfKl54HXB3wEc9BS6EOJMI3YpMuV1RxTSvEMHeAq4cWku0a5YZGX8OGcV
         rCLA==
X-Forwarded-Encrypted: i=1; AJvYcCWqYEj+jSls8bgQfyRWqGSQapS2NHPtTtEGWcCT+VQD+bmhfxDGypUE3fIQc4iE1qVE2yoOMoJ3Rs0U9isLe4iI+JvzX4pjBMrtrOgHO7x4q0N/ePc87+faZCsaDueuP1/vr//wR24yEg==
X-Gm-Message-State: AOJu0YyZJd8svO7J8lU/QmtpuvelitBGcGnAo2DefRy9fpNVnlkg17mw
	8XMk86GuUojTGnkPOKLR3tQ4gaG81r98dVjofpcdes+pRpaCVAUTFbXGcT6M
X-Google-Smtp-Source: AGHT+IFyjFx+AvS8A4ts842xWAA93/5d495eCH9q4XBBiBhYKMtAFIDkDdEzpYfWeG38F411tNP0hg==
X-Received: by 2002:a2e:720b:0:b0:2ec:4096:4bc6 with SMTP id 38308e7fff4ca-2ec5b318000mr83544711fa.7.1719509605159;
        Thu, 27 Jun 2024 10:33:25 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a350727sm3245431fa.38.2024.06.27.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:24 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 12/18] EDAC/mc: Add generic unique MC index allocation procedure
Date: Thu, 27 Jun 2024 20:32:19 +0300
Message-ID: <20240627173251.25718-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the EDAC subsystem relies on the low-level device drivers to
select an unique index for each memory controller available in the system.
Here are the already implemented approaches:
1. Fixed zero id. The vast majority of the drivers expect to have a single
memory controller in the system.
2. Calculate using a platform-specific way (Pre-defined devices order,
PCIe-bus address, Numa node ID + PCIe-function number, etc).
3. Use platform_device->id.
4. Use custom ACPI/OF property value.
5. Use locally maintained static MC counter.

Create a generic method of the MC index allocation which could be utilized
for the case 5 (it doesn't imply any strict memory controller order) and
which would prevent the new MC EDAC drivers re-implementing the approaches
3 and 4. Moreover it will be useful for the cases when a platform is
equipped with memory-controllers of different types [1] and which are
probed by different drivers [2].

[1] Link: https://lore.kernel.org/all/9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl/
[2] Link: https://lore.kernel.org/linux-edac/BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com

The suggested implementation is based on the IDA kernel API and implies
the next semantics:
1. If a particular MC index is specified it will be registered in the
IDR pool unless the specified ID has already been reserved.
2. If a special MC index is specified (EDAC_AUTO_MC_NUM) the EDAC
core will check whether there is a "mcID" alias is defined in the device
tree and use the ID from there if it's found.
3. Otherwise a next free index will be allocated and assigned to the
registered memory controller.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note the approach implemented here has been partly ported from the SPI
core driver using IDA to track/allocate SPI bus numbers.
Link: https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L2957
---
 drivers/edac/edac_mc.c | 89 +++++++++++++++++++++++++++++++++++++++---
 drivers/edac/edac_mc.h |  4 ++
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c0b36349999f..2144e0615679 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -29,6 +29,9 @@
 #include <linux/edac.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+
 #include <asm/page.h>
 #include "edac_mc.h"
 #include "edac_module.h"
@@ -46,6 +49,7 @@ EXPORT_SYMBOL_GPL(edac_op_state);
 /* lock to memory controller's control array */
 static DEFINE_MUTEX(mem_ctls_mutex);
 static LIST_HEAD(mc_devices);
+static DEFINE_IDR(mc_idr);
 
 /*
  * Used to lock EDAC MC to just one module, avoiding two drivers e. g.
@@ -494,7 +498,64 @@ void edac_mc_reset_delay_period(unsigned long value)
 	mutex_unlock(&mem_ctls_mutex);
 }
 
+/**
+ * edac_mc_alloc_id() - Allocate unique Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to allocate ID for
+ *
+ * Use edac_mc_free_id() to coherently free the MC identifier.
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ *
+ * Returns:
+ *	0 on Success, or an error code on failure
+ */
+static int edac_mc_alloc_id(struct mem_ctl_info *mci)
+{
+	struct device_node *np = dev_of_node(mci->pdev);
+	int ret, min, max;
+
+	if (mci->mc_idx == EDAC_AUTO_MC_NUM) {
+		ret = of_alias_get_id(np, "mc");
+		if (ret >= 0) {
+			min = ret;
+			max = ret + 1;
+		} else {
+			min = of_alias_get_highest_id("mc");
+			if (min >= 0)
+				min++;
+			else
+				min = 0;
+
+			max = 0;
+		}
+	} else {
+		min = mci->mc_idx;
+		max = mci->mc_idx + 1;
+	}
+
+	ret = idr_alloc(&mc_idr, mci, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return ret == -ENOSPC ? -EBUSY : ret;
+
+	mci->mc_idx = ret;
+
+	return 0;
+}
 
+/**
+ * edac_mc_free_id() - Free Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to free ID from
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_free_id(struct mem_ctl_info *mci)
+{
+	idr_remove(&mc_idr, mci->mc_idx);
+}
 
 /**
  * edac_mc_init_labels() - Initialize DIMM labels
@@ -613,7 +674,8 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 			       const struct attribute_group **groups)
 {
-	int ret = -EINVAL;
+	int ret;
+
 	edac_dbg(0, "\n");
 
 #ifdef CONFIG_EDAC_DEBUG
@@ -650,20 +712,30 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	ret = edac_mc_alloc_id(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_MC, "failed to allocate MC idx %u\n",
+			    mci->mc_idx);
+		goto fail0;
+	}
+
 	edac_mc_init_labels(mci);
 
-	if (add_mc_to_global_list(mci))
-		goto fail0;
+	if (add_mc_to_global_list(mci)) {
+		ret = -EINVAL;
+		goto fail1;
+	}
 
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
 	mci->bus = edac_get_sysfs_subsys();
 
-	if (edac_create_sysfs_mci_device(mci, groups)) {
+	ret = edac_create_sysfs_mci_device(mci, groups);
+	if (ret) {
 		edac_mc_printk(mci, KERN_WARNING,
 			"failed to create sysfs device\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	if (mci->edac_check) {
@@ -687,9 +759,12 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	mutex_unlock(&mem_ctls_mutex);
 	return 0;
 
-fail1:
+fail2:
 	del_mc_from_global_list(mci);
 
+fail1:
+	edac_mc_free_id(mci);
+
 fail0:
 	mutex_unlock(&mem_ctls_mutex);
 	return ret;
@@ -717,6 +792,8 @@ struct mem_ctl_info *edac_mc_del_mc(struct device *dev)
 	if (del_mc_from_global_list(mci))
 		edac_mc_owner = NULL;
 
+	edac_mc_free_id(mci);
+
 	mutex_unlock(&mem_ctls_mutex);
 
 	if (mci->edac_check)
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..4b6676235b1b 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -23,6 +23,7 @@
 #define _EDAC_MC_H_
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -37,6 +38,9 @@
 #include <linux/workqueue.h>
 #include <linux/edac.h>
 
+/* Generate MC identifier automatically */
+#define EDAC_AUTO_MC_NUM	UINT_MAX
+
 #if PAGE_SHIFT < 20
 #define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
 #define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
-- 
2.43.0


