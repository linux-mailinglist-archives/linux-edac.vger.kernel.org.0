Return-Path: <linux-edac+bounces-312-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E08242B4
	for <lists+linux-edac@lfdr.de>; Thu,  4 Jan 2024 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29561F22857
	for <lists+linux-edac@lfdr.de>; Thu,  4 Jan 2024 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6A219FC;
	Thu,  4 Jan 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fmttV+Fw"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F7224C2
	for <linux-edac@vger.kernel.org>; Thu,  4 Jan 2024 13:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFA9C433C8;
	Thu,  4 Jan 2024 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704375287;
	bh=LTyKe+k64m7X+ARP0Ap7IAKr34oUbJv+H5+g0s4HNAU=;
	h=Subject:To:From:Date:From;
	b=fmttV+Fwme+gz0pnzqnF5+KbZfprJWBPO2kqduN42KYUQ0EmdRsWZRacFjYCREqDa
	 TqlKnM5YHUL6gmKF4khfIKn53w8ncSLFTLiCW6XdTUuKCQYAiDNzILs5j0J/AUVCGa
	 MPNtUEhEO2M/En/VbBsV7G5mnuOERXxE0cNQQLMo=
Subject: patch "EDAC: constantify the struct bus_type usage" added to driver-core-testing
To: gregkh@linuxfoundation.org,bp@alien8.de,james.morse@arm.com,linux-edac@vger.kernel.org,mchehab@kernel.org,rric@kernel.org,tony.luck@intel.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 14:34:44 +0100
Message-ID: <2024010443-paramedic-limping-ac0f@gregkh>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    EDAC: constantify the struct bus_type usage

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From f36be9ce8146faabdbbf74ee0499edb2039c53a5 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 19 Dec 2023 14:13:10 +0100
Subject: EDAC: constantify the struct bus_type usage

In many places in the edac code, struct bus_type pointers are passed
around and then eventually sent to the driver core, which can handle a
constant pointer.  So constantify all of the edac usage of these as well
because the data in them is never modified by the edac code either.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc:  <linux-edac@vger.kernel.org>
Link: https://lore.kernel.org/r/2023121909-tribute-punctuate-4b22@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/edac_device.h       | 2 +-
 drivers/edac/edac_device_sysfs.c | 2 +-
 drivers/edac/edac_module.c       | 4 ++--
 drivers/edac/edac_pci_sysfs.c    | 2 +-
 include/linux/edac.h             | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 3f44e6b9d387..7db22a4c83ef 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -176,7 +176,7 @@ struct edac_device_ctl_info {
 	struct edac_dev_sysfs_attribute *sysfs_attributes;
 
 	/* pointer to main 'edac' subsys in sysfs */
-	struct bus_type *edac_subsys;
+	const struct bus_type *edac_subsys;
 
 	/* the internal state of this controller instance */
 	int op_state;
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 010c26be5846..237a542e045a 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -229,7 +229,7 @@ static struct kobj_type ktype_device_ctrl = {
 int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 {
 	struct device *dev_root;
-	struct bus_type *edac_subsys;
+	const struct bus_type *edac_subsys;
 	int err = -ENODEV;
 
 	edac_dbg(1, "\n");
diff --git a/drivers/edac/edac_module.c b/drivers/edac/edac_module.c
index 32a931d0cb71..1c9f62382666 100644
--- a/drivers/edac/edac_module.c
+++ b/drivers/edac/edac_module.c
@@ -67,7 +67,7 @@ char *edac_op_state_to_string(int opstate)
  * sysfs object: /sys/devices/system/edac
  *	need to export to other files
  */
-static struct bus_type edac_subsys = {
+static const struct bus_type edac_subsys = {
 	.name = "edac",
 	.dev_name = "edac",
 };
@@ -90,7 +90,7 @@ static void edac_subsys_exit(void)
 }
 
 /* return pointer to the 'edac' node in sysfs */
-struct bus_type *edac_get_sysfs_subsys(void)
+const struct bus_type *edac_get_sysfs_subsys(void)
 {
 	return &edac_subsys;
 }
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 287cc51dbc86..e823e4da086a 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -338,7 +338,7 @@ static struct kobj_type ktype_edac_pci_main_kobj = {
 static int edac_pci_main_kobj_setup(void)
 {
 	int err = -ENODEV;
-	struct bus_type *edac_subsys;
+	const struct bus_type *edac_subsys;
 	struct device *dev_root;
 
 	edac_dbg(0, "\n");
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..ccaf2ae0801d 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -30,7 +30,7 @@ struct device;
 
 extern int edac_op_state;
 
-struct bus_type *edac_get_sysfs_subsys(void);
+const struct bus_type *edac_get_sysfs_subsys(void);
 
 static inline void opstate_init(void)
 {
@@ -492,7 +492,7 @@ struct edac_raw_error_desc {
  */
 struct mem_ctl_info {
 	struct device			dev;
-	struct bus_type			*bus;
+	const struct bus_type		*bus;
 
 	struct list_head link;	/* for global list of mem_ctl_info structs */
 
-- 
2.43.0



