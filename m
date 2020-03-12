Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C6182861
	for <lists+linux-edac@lfdr.de>; Thu, 12 Mar 2020 06:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgCLFZe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Mar 2020 01:25:34 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:56284 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLFZe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Mar 2020 01:25:34 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 01:25:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4795; q=dns/txt; s=iport;
  t=1583990732; x=1585200332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YoDySlt/LTy9TAPdafT2LQxNbqjm2MWaEYRZ+jiodFM=;
  b=TP/Qdo1WpNCYYHD7MBwlkAKyNgJPIMA+OkD8xs21sanKdFjops54clOK
   x+NQu9nqvxffdRGWr0yXlmYNQjw5e9nWHm2+lbjnIRlXExLO4GsEbKvKy
   UCqGG2WHQ2XEBzTXlI9/unC/WVVFkNvWu+SkrafRPpPR7K7b/B3AWrik4
   Y=;
X-IronPort-AV: E=Sophos;i="5.70,543,1574121600"; 
   d="scan'208";a="731667992"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Mar 2020 05:22:28 +0000
Received: from sjc-ads-7741.cisco.com (sjc-ads-7741.cisco.com [10.30.222.28])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTP id 02C5MSHc007242;
        Thu, 12 Mar 2020 05:22:28 GMT
Received: by sjc-ads-7741.cisco.com (Postfix, from userid 381789)
        id 46D7C122A; Wed, 11 Mar 2020 22:22:28 -0700 (PDT)
From:   Manali K Shukla <manashuk@cisco.com>
To:     bp@alien8.de, linux-edac@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     xe-linux-external@cisco.com, Borislav Petkov <bp@suse.de>,
        Aristeu Rozanski Filho <arozansk@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Russ Anderson <rja@hpe.com>, Tony Luck <tony.luck@intel.com>,
        Manali K Shukla <manashuk@cisco.com>
Subject: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Date:   Wed, 11 Mar 2020 22:22:01 -0700
Message-Id: <20200312052201.49456-1-manashuk@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.222.28, sjc-ads-7741.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

upstream 861e6ed667c83d64a42b0db41a22d6b4de4e913f commit

... and use the single edac_subsys object returned from
subsys_system_register(). The idea is to have a single bus
and multiple devices on it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC: Aristeu Rozanski Filho <arozansk@redhat.com>
CC: Greg KH <gregkh@linuxfoundation.org>
CC: Justin Ernst <justin.ernst@hpe.com>
CC: linux-edac <linux-edac@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Russ Anderson <rja@hpe.com>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20180926152752.GG5584@zn.tnic
[Manali: backport to v4.19 -stable :
- removing per-MC bus, this enables to get rid of memory controllers
  maximum number notion
- value of max number of memory controllers is 2 * MAX_NUMNODES. On two nodes system MAX_NUMNODES value is ‘1’ and
  so value of max number of memory controller becomes ‘2’, this patch fixes this issue when there are only 2 nodes on the system
  and number of memory controllers are more than ‘2’]
(cherry picked from commit 861e6ed667c83d64a42b0db41a22d6b4de4e913f)
Signed-off-by: Manali K Shukla <manashuk@cisco.com>
---
 drivers/edac/edac_mc.c       |  9 +--------
 drivers/edac/edac_mc_sysfs.c | 30 ++----------------------------
 include/linux/edac.h         |  6 ------
 3 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index fd440b35d76e..d899d86897d0 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -55,8 +55,6 @@ static LIST_HEAD(mc_devices);
  */
 static const char *edac_mc_owner;
 
-static struct bus_type mc_bus[EDAC_MAX_MCS];
-
 int edac_get_report_status(void)
 {
 	return edac_report;
@@ -712,11 +710,6 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	int ret = -EINVAL;
 	edac_dbg(0, "\n");
 
-	if (mci->mc_idx >= EDAC_MAX_MCS) {
-		pr_warn_once("Too many memory controllers: %d\n", mci->mc_idx);
-		return -ENODEV;
-	}
-
 #ifdef CONFIG_EDAC_DEBUG
 	if (edac_debug_level >= 3)
 		edac_mc_dump_mci(mci);
@@ -756,7 +749,7 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
-	mci->bus = &mc_bus[mci->mc_idx];
+	mci->bus = edac_get_sysfs_subsys();
 
 	if (edac_create_sysfs_mci_device(mci, groups)) {
 		edac_mc_printk(mci, KERN_WARNING,
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index d4545a9222a0..90ba228af57d 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -920,27 +920,8 @@ static const struct device_type mci_attr_type = {
 int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 				 const struct attribute_group **groups)
 {
-	char *name;
 	int i, err;
 
-	/*
-	 * The memory controller needs its own bus, in order to avoid
-	 * namespace conflicts at /sys/bus/edac.
-	 */
-	name = kasprintf(GFP_KERNEL, "mc%d", mci->mc_idx);
-	if (!name)
-		return -ENOMEM;
-
-	mci->bus->name = name;
-
-	edac_dbg(0, "creating bus %s\n", mci->bus->name);
-
-	err = bus_register(mci->bus);
-	if (err < 0) {
-		kfree(name);
-		return err;
-	}
-
 	/* get the /sys/devices/system/edac subsys reference */
 	mci->dev.type = &mci_attr_type;
 	device_initialize(&mci->dev);
@@ -956,7 +937,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
-		goto fail_unregister_bus;
+		goto out;
 	}
 
 	/*
@@ -1004,10 +985,8 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 		device_unregister(&dimm->dev);
 	}
 	device_unregister(&mci->dev);
-fail_unregister_bus:
-	bus_unregister(mci->bus);
-	kfree(name);
 
+out:
 	return err;
 }
 
@@ -1038,13 +1017,8 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 
 void edac_unregister_sysfs(struct mem_ctl_info *mci)
 {
-	struct bus_type *bus = mci->bus;
-	const char *name = mci->bus->name;
-
 	edac_dbg(1, "Unregistering device %s\n", dev_name(&mci->dev));
 	device_unregister(&mci->dev);
-	bus_unregister(bus);
-	kfree(name);
 }
 
 static void mc_attr_release(struct device *dev)
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 958d69332c1d..efd5145a4c10 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -667,10 +667,4 @@ struct mem_ctl_info {
 	bool fake_inject_ue;
 	u16 fake_inject_count;
 };
-
-/*
- * Maximum number of memory controllers in the coherent fabric.
- */
-#define EDAC_MAX_MCS	2 * MAX_NUMNODES
-
 #endif
-- 
2.19.1

