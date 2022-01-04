Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6984840BA
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jan 2022 12:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiADLYu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jan 2022 06:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiADLYs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jan 2022 06:24:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE9FC061761;
        Tue,  4 Jan 2022 03:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C610B811B9;
        Tue,  4 Jan 2022 11:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E97BC36AE9;
        Tue,  4 Jan 2022 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641295485;
        bh=+SihUiw2DIDcYbUPnMNvPilchYN3rmPFn1OS+ijzcHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQbmo8EV6O8pZ7w6GLLECt5GID4HHX6IJozwZoE4sZN9mG0DGbLbIVamgfRQaRO1d
         KqByNKIBx0874W07Oohwmk4/Ck52teRyRTYpfqJgNaOGTgg37bv2xRrIDgmG2gYyuk
         b6BwEWH3J9/OyiN93iA3MDCB0XsWK09kTtc5ODK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH v2 2/2] EDAC: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 12:24:01 +0100
Message-Id: <20220104112401.1067148-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104112401.1067148-1-gregkh@linuxfoundation.org>
References: <20220104112401.1067148-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5177; h=from:subject; bh=+SihUiw2DIDcYbUPnMNvPilchYN3rmPFn1OS+ijzcHM=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlX9AI15Z+1853bt+GcmFHXRBmN4nrVTcHfliQJ5e7b7WQ8 xbWpI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZidJ5hrqCPwmMmTkuZ9EPOd/5rNb O/vHboG8P8NLkt0rs5Xz3at+L95Ydv10z8IGaxBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the edac sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: do the same thing in edac_pci_sysfs.c

 drivers/edac/edac_device_sysfs.c | 15 +++++++++------
 drivers/edac/edac_pci_sysfs.c    | 10 ++++++----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index f4aefced2ccf..9a61d92bdf42 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -163,13 +163,14 @@ CTL_INFO_ATTR(poll_msec, S_IRUGO | S_IWUSR,
 	edac_device_ctl_poll_msec_show, edac_device_ctl_poll_msec_store);
 
 /* Base Attributes of the EDAC_DEVICE ECC object */
-static struct attribute *device_ctrl_attr[] = {
+static struct attribute *device_ctrl_attrs[] = {
 	&attr_ctl_info_panic_on_ue.attr,
 	&attr_ctl_info_log_ue.attr,
 	&attr_ctl_info_log_ce.attr,
 	&attr_ctl_info_poll_msec.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(device_ctrl);
 
 /*
  * edac_device_ctrl_master_release
@@ -217,7 +218,7 @@ static void edac_device_ctrl_master_release(struct kobject *kobj)
 static struct kobj_type ktype_device_ctrl = {
 	.release = edac_device_ctrl_master_release,
 	.sysfs_ops = &device_ctl_info_ops,
-	.default_attrs = device_ctrl_attr,
+	.default_groups = device_ctrl_groups,
 };
 
 /*
@@ -389,17 +390,18 @@ INSTANCE_ATTR(ce_count, S_IRUGO, instance_ce_count_show, NULL);
 INSTANCE_ATTR(ue_count, S_IRUGO, instance_ue_count_show, NULL);
 
 /* list of edac_dev 'instance' attributes */
-static struct attribute *device_instance_attr[] = {
+static struct attribute *device_instance_attrs[] = {
 	&attr_instance_ce_count.attr,
 	&attr_instance_ue_count.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(device_instance);
 
 /* The 'ktype' for each edac_dev 'instance' */
 static struct kobj_type ktype_instance_ctrl = {
 	.release = edac_device_ctrl_instance_release,
 	.sysfs_ops = &device_instance_ops,
-	.default_attrs = device_instance_attr,
+	.default_groups = device_instance_groups,
 };
 
 /* edac_dev -> instance -> block information */
@@ -487,17 +489,18 @@ BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show, NULL);
 BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show, NULL);
 
 /* list of edac_dev 'block' attributes */
-static struct attribute *device_block_attr[] = {
+static struct attribute *device_block_attrs[] = {
 	&attr_block_ce_count.attr,
 	&attr_block_ue_count.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(device_block);
 
 /* The 'ktype' for each edac_dev 'block' */
 static struct kobj_type ktype_block_ctrl = {
 	.release = edac_device_ctrl_block_release,
 	.sysfs_ops = &device_block_ops,
-	.default_attrs = device_block_attr,
+	.default_groups = device_block_groups,
 };
 
 /* block ctor/dtor  code */
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index c041fb8f3ef2..888d5728ecef 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -135,17 +135,18 @@ INSTANCE_ATTR(pe_count, S_IRUGO, instance_pe_count_show, NULL);
 INSTANCE_ATTR(npe_count, S_IRUGO, instance_npe_count_show, NULL);
 
 /* pci instance attributes */
-static struct attribute *pci_instance_attr[] = {
+static struct attribute *pci_instance_attrs[] = {
 	&attr_instance_pe_count.attr,
 	&attr_instance_npe_count.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(pci_instance);
 
 /* the ktype for a pci instance */
 static struct kobj_type ktype_pci_instance = {
 	.release = edac_pci_instance_release,
 	.sysfs_ops = &pci_instance_ops,
-	.default_attrs = pci_instance_attr,
+	.default_groups = pci_instance_groups,
 };
 
 /*
@@ -292,7 +293,7 @@ EDAC_PCI_ATTR(pci_parity_count, S_IRUGO, edac_pci_int_show, NULL);
 EDAC_PCI_ATTR(pci_nonparity_count, S_IRUGO, edac_pci_int_show, NULL);
 
 /* Base Attributes of the memory ECC object */
-static struct attribute *edac_pci_attr[] = {
+static struct attribute *edac_pci_attrs[] = {
 	&edac_pci_attr_check_pci_errors.attr,
 	&edac_pci_attr_edac_pci_log_pe.attr,
 	&edac_pci_attr_edac_pci_log_npe.attr,
@@ -301,6 +302,7 @@ static struct attribute *edac_pci_attr[] = {
 	&edac_pci_attr_pci_nonparity_count.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(edac_pci);
 
 /*
  * edac_pci_release_main_kobj
@@ -327,7 +329,7 @@ static void edac_pci_release_main_kobj(struct kobject *kobj)
 static struct kobj_type ktype_edac_pci_main_kobj = {
 	.release = edac_pci_release_main_kobj,
 	.sysfs_ops = &edac_pci_sysfs_ops,
-	.default_attrs = edac_pci_attr,
+	.default_groups = edac_pci_groups,
 };
 
 /**
-- 
2.34.1

