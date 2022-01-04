Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247784840BB
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jan 2022 12:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiADLYv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jan 2022 06:24:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58692 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiADLYt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jan 2022 06:24:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36D461341;
        Tue,  4 Jan 2022 11:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA53C36AEF;
        Tue,  4 Jan 2022 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641295488;
        bh=FB2EMxjc4Zu9vbfnuQP/X9gtqIuraY1zXG5BfKRYTiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GA9x/8KSOs1Jf0+TRUvjmGEEu8BlZTqCdAo6gt/ySfdHNeqwfGxeh0VL1TWSZXH1U
         ONeBmayw20akdLhIrZzTcQ3S/I1iM0QvUv7SuCCkMV+SpOaIES8vU3PoXMYMiFYST+
         cDTGI7Gmo8iQREXsv+TMcezUtGdQ/rDAtj9iJNT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH v2 1/2] EDAC: use proper list of struct attribute for attributes
Date:   Tue,  4 Jan 2022 12:24:00 +0100
Message-Id: <20220104112401.1067148-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5665; h=from:subject; bh=FB2EMxjc4Zu9vbfnuQP/X9gtqIuraY1zXG5BfKRYTiQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlX9AKZlwvOXGK5Y82bGdEzlqlfulRmmKyXq7bh1dOcDQek pNqjOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAizxsY5ofL5Sj4te21STF/y3pn+W K717kCZxgWNJz5bR10pmVt3f/Q+eckTnwrvmQ2HQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The edac sysfs code is doing some crazy casting of the list of
attributes that is not necessary at all.  Instead, properly point to the
correct attribute structure in the lists, which removes the need to cast
anything and the code is now properly typesafe (as much as sysfs
attribute logic is typesafe...)

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: do the same thing in edac_pci_sysfs.c

 drivers/edac/edac_device_sysfs.c | 28 ++++++++++++++--------------
 drivers/edac/edac_pci_sysfs.c    | 24 ++++++++++++------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..f4aefced2ccf 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -163,11 +163,11 @@ CTL_INFO_ATTR(poll_msec, S_IRUGO | S_IWUSR,
 	edac_device_ctl_poll_msec_show, edac_device_ctl_poll_msec_store);
 
 /* Base Attributes of the EDAC_DEVICE ECC object */
-static struct ctl_info_attribute *device_ctrl_attr[] = {
-	&attr_ctl_info_panic_on_ue,
-	&attr_ctl_info_log_ue,
-	&attr_ctl_info_log_ce,
-	&attr_ctl_info_poll_msec,
+static struct attribute *device_ctrl_attr[] = {
+	&attr_ctl_info_panic_on_ue.attr,
+	&attr_ctl_info_log_ue.attr,
+	&attr_ctl_info_log_ce.attr,
+	&attr_ctl_info_poll_msec.attr,
 	NULL,
 };
 
@@ -217,7 +217,7 @@ static void edac_device_ctrl_master_release(struct kobject *kobj)
 static struct kobj_type ktype_device_ctrl = {
 	.release = edac_device_ctrl_master_release,
 	.sysfs_ops = &device_ctl_info_ops,
-	.default_attrs = (struct attribute **)device_ctrl_attr,
+	.default_attrs = device_ctrl_attr,
 };
 
 /*
@@ -389,9 +389,9 @@ INSTANCE_ATTR(ce_count, S_IRUGO, instance_ce_count_show, NULL);
 INSTANCE_ATTR(ue_count, S_IRUGO, instance_ue_count_show, NULL);
 
 /* list of edac_dev 'instance' attributes */
-static struct instance_attribute *device_instance_attr[] = {
-	&attr_instance_ce_count,
-	&attr_instance_ue_count,
+static struct attribute *device_instance_attr[] = {
+	&attr_instance_ce_count.attr,
+	&attr_instance_ue_count.attr,
 	NULL,
 };
 
@@ -399,7 +399,7 @@ static struct instance_attribute *device_instance_attr[] = {
 static struct kobj_type ktype_instance_ctrl = {
 	.release = edac_device_ctrl_instance_release,
 	.sysfs_ops = &device_instance_ops,
-	.default_attrs = (struct attribute **)device_instance_attr,
+	.default_attrs = device_instance_attr,
 };
 
 /* edac_dev -> instance -> block information */
@@ -487,9 +487,9 @@ BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show, NULL);
 BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show, NULL);
 
 /* list of edac_dev 'block' attributes */
-static struct edac_dev_sysfs_block_attribute *device_block_attr[] = {
-	&attr_block_ce_count,
-	&attr_block_ue_count,
+static struct attribute *device_block_attr[] = {
+	&attr_block_ce_count.attr,
+	&attr_block_ue_count.attr,
 	NULL,
 };
 
@@ -497,7 +497,7 @@ static struct edac_dev_sysfs_block_attribute *device_block_attr[] = {
 static struct kobj_type ktype_block_ctrl = {
 	.release = edac_device_ctrl_block_release,
 	.sysfs_ops = &device_block_ops,
-	.default_attrs = (struct attribute **)device_block_attr,
+	.default_attrs = device_block_attr,
 };
 
 /* block ctor/dtor  code */
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 53042af7262e..c041fb8f3ef2 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -135,9 +135,9 @@ INSTANCE_ATTR(pe_count, S_IRUGO, instance_pe_count_show, NULL);
 INSTANCE_ATTR(npe_count, S_IRUGO, instance_npe_count_show, NULL);
 
 /* pci instance attributes */
-static struct instance_attribute *pci_instance_attr[] = {
-	&attr_instance_pe_count,
-	&attr_instance_npe_count,
+static struct attribute *pci_instance_attr[] = {
+	&attr_instance_pe_count.attr,
+	&attr_instance_npe_count.attr,
 	NULL
 };
 
@@ -145,7 +145,7 @@ static struct instance_attribute *pci_instance_attr[] = {
 static struct kobj_type ktype_pci_instance = {
 	.release = edac_pci_instance_release,
 	.sysfs_ops = &pci_instance_ops,
-	.default_attrs = (struct attribute **)pci_instance_attr,
+	.default_attrs = pci_instance_attr,
 };
 
 /*
@@ -292,13 +292,13 @@ EDAC_PCI_ATTR(pci_parity_count, S_IRUGO, edac_pci_int_show, NULL);
 EDAC_PCI_ATTR(pci_nonparity_count, S_IRUGO, edac_pci_int_show, NULL);
 
 /* Base Attributes of the memory ECC object */
-static struct edac_pci_dev_attribute *edac_pci_attr[] = {
-	&edac_pci_attr_check_pci_errors,
-	&edac_pci_attr_edac_pci_log_pe,
-	&edac_pci_attr_edac_pci_log_npe,
-	&edac_pci_attr_edac_pci_panic_on_pe,
-	&edac_pci_attr_pci_parity_count,
-	&edac_pci_attr_pci_nonparity_count,
+static struct attribute *edac_pci_attr[] = {
+	&edac_pci_attr_check_pci_errors.attr,
+	&edac_pci_attr_edac_pci_log_pe.attr,
+	&edac_pci_attr_edac_pci_log_npe.attr,
+	&edac_pci_attr_edac_pci_panic_on_pe.attr,
+	&edac_pci_attr_pci_parity_count.attr,
+	&edac_pci_attr_pci_nonparity_count.attr,
 	NULL,
 };
 
@@ -327,7 +327,7 @@ static void edac_pci_release_main_kobj(struct kobject *kobj)
 static struct kobj_type ktype_edac_pci_main_kobj = {
 	.release = edac_pci_release_main_kobj,
 	.sysfs_ops = &edac_pci_sysfs_ops,
-	.default_attrs = (struct attribute **)edac_pci_attr,
+	.default_attrs = edac_pci_attr,
 };
 
 /**
-- 
2.34.1

