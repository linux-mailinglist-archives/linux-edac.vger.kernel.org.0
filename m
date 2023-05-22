Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43870C23B
	for <lists+linux-edac@lfdr.de>; Mon, 22 May 2023 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjEVPWQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 May 2023 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjEVPWP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 May 2023 11:22:15 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F170A1
        for <linux-edac@vger.kernel.org>; Mon, 22 May 2023 08:22:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684768930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8ZqrS9FKR6Xdsh32ocQyA55bL9M7rQO1nVdym5t3Lmw=;
        b=LRzD28DKY78w9e5AjonxLuR6N65A66ci2+xncDA3ryhlt/YjL30+PZYt2KnVf6WAwenhZm
        3+QF4pPOolX24Q/ZtCptzYA78SJEu90EK9k5Z49Ryr+INKXczHP427ytk/xT4C2h4SxaUH
        ilfRplLU3pjSnQ7wy7U6fYNKvG0n2KU=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     tony.luck@intel.com, bp@alien8.de, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-doc@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH v2] EDAC: Expose node and memory controller link in sysfs if CONFIG_NUMA
Date:   Mon, 22 May 2023 23:21:55 +0800
Message-Id: <20230522152155.2614466-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The node* directory in sysfs already has cpu link and memory link, memory
controller is also a resource under node. Therefore, expose the memory
controller symbolic link under the node* directory if CONFIG_NUMA.

The mc directory in sysfs can have multiple mc* directories, which can
belong to different nodes. To know which node each mc belogs to, expose
node symbolic link under the mc* directory if CONFIG_NUMA.

At the same time, change the type of EDAC from tristate to boolean
because it needs node_devices.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305221451.b48d9b55-yujie.liu@intel.com
---
 Documentation/ABI/testing/sysfs-devices-edac | 26 +++++++++
 Documentation/admin-guide/ras.rst            |  2 +
 drivers/edac/Kconfig                         |  2 +-
 drivers/edac/edac_mc_sysfs.c                 | 60 ++++++++++++++++++++
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-edac b/Documentation/ABI/testing/sysfs-devices-edac
index 256a9e990c0b..2735dde61e0b 100644
--- a/Documentation/ABI/testing/sysfs-devices-edac
+++ b/Documentation/ABI/testing/sysfs-devices-edac
@@ -155,3 +155,29 @@ Description:	This attribute file displays the total count of uncorrectable
 		errors that have occurred on this DIMM. If panic_on_ue is set, this
 		counter will not have a chance to increment, since EDAC will panic the
 		system
+
+What:		/sys/devices/system/edac/mc/mc*/node*
+Date:		May 2023
+Contact:	Yajun Deng <yajun.deng@linux.dev>
+		linux-edac@vger.kernel.org
+Description:	When CONFIG_NUMA is enabled, a symbolic link that points to the
+		corresponding NUMA node directory.
+
+		For example, on node0 with two memory control directories mc0 and mc1
+		the symlinks are::
+
+		  /sys/devices/system/edac/mc/mc0/node0 -> ../../../node/node0
+		  /sys/devices/system/edac/mc/mc1/node0 -> ../../../node/node0
+
+What:		/sys/devices/system/node/node*/mc*
+Date:		May 2023
+Contact:	Yajun Deng <yajun.deng@linux.dev>
+		linux-edac@vger.kernel.org
+Description:	When CONFIG_NUMA is enabled, a symbolic link that points to the
+		corresponding memory control directory.
+
+		For example, on node0 with two memory control directories mc0 and mc1
+		the symlinks are::
+
+		  /sys/devices/system/node/node0/mc0 -> ../../edac/mc/mc0
+		  /sys/devices/system/node/node0/mc1 -> ../../edac/mc/mc1
diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 8e03751d126d..ef7cc9867fc8 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -458,6 +458,7 @@ A typical EDAC system has the following structure under
 	│   │   │   └── uevent
 	│   │   ├── max_location
 	│   │   ├── mc_name
+	│   │   ├── node0 -> ../../../node/node0  #if CONFIG_NUMA
 	│   │   ├── reset_counters
 	│   │   ├── seconds_since_reset
 	│   │   ├── size_mb
@@ -479,6 +480,7 @@ A typical EDAC system has the following structure under
 	│   │   │   └── uevent
 	│   │   ├── max_location
 	│   │   ├── mc_name
+	│   │   ├── node0 -> ../../../node/node0  #if CONFIG_NUMA
 	│   │   ├── reset_counters
 	│   │   ├── seconds_since_reset
 	│   │   ├── size_mb
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 68f576700911..e61a29e0eb28 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -10,7 +10,7 @@ config EDAC_SUPPORT
 	bool
 
 menuconfig EDAC
-	tristate "EDAC (Error Detection And Correction) reporting"
+	bool "EDAC (Error Detection And Correction) reporting"
 	depends on HAS_IOMEM && EDAC_SUPPORT && RAS
 	help
 	  EDAC is a subsystem along with hardware-specific drivers designed to
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..e0a99c5f736f 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/bug.h>
 #include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
+#include <linux/node.h>
 
 #include "edac_mc.h"
 #include "edac_module.h"
@@ -922,6 +923,61 @@ static const struct device_type mci_attr_type = {
 	.groups		= mci_attr_groups,
 };
 
+#ifdef CONFIG_NUMA
+static int edac_create_node_link(struct mem_ctl_info *mci)
+{
+	int nid = dev_to_node(mci->pdev);
+	struct node *node;
+	struct device *dev;
+	int ret;
+
+	if (nid < 0 || nid >= MAX_NUMNODES)
+		return 0;
+
+	if (!node_online(nid) || !node_devices[nid])
+		return 0;
+
+	node = node_devices[nid];
+	dev = &mci->dev;
+
+	ret = sysfs_create_link(&node->dev.kobj, &dev->kobj,
+				kobject_name(&dev->kobj));
+	if (ret)
+		return ret;
+
+	return sysfs_create_link(&dev->kobj, &node->dev.kobj,
+				 kobject_name(&node->dev.kobj));
+}
+
+static void edac_remove_node_link(struct mem_ctl_info *mci)
+{
+	int nid = dev_to_node(mci->pdev);
+	struct node *node;
+	struct device *dev;
+
+	if (nid < 0 || nid >= MAX_NUMNODES)
+		return;
+
+	if (!node_online(nid) || !node_devices[nid])
+		return;
+
+	node = node_devices[nid];
+	dev = &mci->dev;
+
+	sysfs_remove_link(&node->dev.kobj, kobject_name(&dev->kobj));
+
+	sysfs_remove_link(&dev->kobj, kobject_name(&node->dev.kobj));
+}
+#else
+static inline int edac_create_node_link(struct mem_ctl_info *mci)
+{
+	return 0;
+}
+static inline void edac_remove_node_link(struct mem_ctl_info *mci)
+{
+}
+#endif
+
 /*
  * Create a new Memory Controller kobject instance,
  *	mc<id> under the 'mc' directory
@@ -966,6 +1022,8 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 			goto fail;
 	}
 
+	edac_create_node_link(mci);
+
 #ifdef CONFIG_EDAC_LEGACY_SYSFS
 	err = edac_create_csrow_objects(mci);
 	if (err < 0)
@@ -1000,6 +1058,8 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 	edac_delete_csrow_objects(mci);
 #endif
 
+	edac_remove_node_link(mci);
+
 	mci_for_each_dimm(mci, dimm) {
 		if (!device_is_registered(&dimm->dev))
 			continue;
-- 
2.25.1

