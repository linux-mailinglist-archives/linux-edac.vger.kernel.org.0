Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B96B80AD
	for <lists+linux-edac@lfdr.de>; Mon, 13 Mar 2023 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCMSb7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Mar 2023 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCMSb2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Mar 2023 14:31:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0184F41;
        Mon, 13 Mar 2023 11:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4E7B811D9;
        Mon, 13 Mar 2023 18:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D08C433EF;
        Mon, 13 Mar 2023 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732164;
        bh=Y/2uHv7UuAu/TK9ErBIs8mV0SWLcXTcZZH/WgWkSiX0=;
        h=From:To:Cc:Subject:Date:From;
        b=h0FQLumSJSQdBb0rjII8jRPFNkX0uljxQbTywcCw66Xlq+q3CcDOUTPIWuAA7BimD
         KX8vi85pxzLO3wOueMkHSu/+WQYf2dvT1f/4M3shWz8G1bXB+Nq2nFB2o3NlTYjBYh
         hkEJQz+gNs+ZpBkP0+XRdkuCyYXh5nRreY7G+uh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH 01/36] EDAC/sysfs: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:43 +0100
Message-Id: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3456; i=gregkh@linuxfoundation.org; h=from:subject; bh=Y/2uHv7UuAu/TK9ErBIs8mV0SWLcXTcZZH/WgWkSiX0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82cUfGs++u2V+7lpaslPa1Vv9E18fU1yu9zB4843Ai xcsTCbHdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE3hczLNh6Om/Cq3XOzFbz A/0bS+f6t8/OP8qwYN9DlhWq+hksDzw/182f83bZihZuIwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/edac/edac_device_sysfs.c | 16 +++++++++-------
 drivers/edac/edac_pci_sysfs.c    | 14 +++++++++-----
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index ac678b4a21fc..010c26be5846 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -228,8 +228,9 @@ static struct kobj_type ktype_device_ctrl = {
  */
 int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 {
+	struct device *dev_root;
 	struct bus_type *edac_subsys;
-	int err;
+	int err = -ENODEV;
 
 	edac_dbg(1, "\n");
 
@@ -247,15 +248,16 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 	 */
 	edac_dev->owner = THIS_MODULE;
 
-	if (!try_module_get(edac_dev->owner)) {
-		err = -ENODEV;
+	if (!try_module_get(edac_dev->owner))
 		goto err_out;
-	}
 
 	/* register */
-	err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
-				   &edac_subsys->dev_root->kobj,
-				   "%s", edac_dev->name);
+	dev_root = bus_get_dev_root(edac_subsys);
+	if (dev_root) {
+		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
+					   &dev_root->kobj, "%s", edac_dev->name);
+		put_device(dev_root);
+	}
 	if (err) {
 		edac_dbg(1, "Failed to register '.../edac/%s'\n",
 			 edac_dev->name);
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 888d5728ecef..287cc51dbc86 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -337,8 +337,9 @@ static struct kobj_type ktype_edac_pci_main_kobj = {
  */
 static int edac_pci_main_kobj_setup(void)
 {
-	int err;
+	int err = -ENODEV;
 	struct bus_type *edac_subsys;
+	struct device *dev_root;
 
 	edac_dbg(0, "\n");
 
@@ -357,7 +358,6 @@ static int edac_pci_main_kobj_setup(void)
 	 */
 	if (!try_module_get(THIS_MODULE)) {
 		edac_dbg(1, "try_module_get() failed\n");
-		err = -ENODEV;
 		goto decrement_count_fail;
 	}
 
@@ -369,9 +369,13 @@ static int edac_pci_main_kobj_setup(void)
 	}
 
 	/* Instanstiate the pci object */
-	err = kobject_init_and_add(edac_pci_top_main_kobj,
-				   &ktype_edac_pci_main_kobj,
-				   &edac_subsys->dev_root->kobj, "pci");
+	dev_root = bus_get_dev_root(edac_subsys);
+	if (dev_root) {
+		err = kobject_init_and_add(edac_pci_top_main_kobj,
+					   &ktype_edac_pci_main_kobj,
+					   &dev_root->kobj, "pci");
+		put_device(dev_root);
+	}
 	if (err) {
 		edac_dbg(1, "Failed to register '.../edac/pci'\n");
 		goto kobject_init_and_add_fail;
-- 
2.39.2

