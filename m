Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446D658A4BD
	for <lists+linux-edac@lfdr.de>; Fri,  5 Aug 2022 04:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiHECc3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Aug 2022 22:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECc2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Aug 2022 22:32:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7998417A84;
        Thu,  4 Aug 2022 19:32:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA0C113E;
        Thu,  4 Aug 2022 19:32:26 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F7DD3F73B;
        Thu,  4 Aug 2022 19:32:21 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv register
Date:   Fri,  5 Aug 2022 02:32:00 +0000
Message-Id: <20220805023200.154634-1-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
apci_init()") introduced a bug that invoking ghes_edac_register()
before edac_init(). Because at that time, the bus "edac" hasn't been
registered, this created sysfs /devices/mc0 instead of
/sys/devices/system/edac/mc/mc0 and caused a sysfs dup splat on an
Ampere eMag server:
 sysfs: cannot create duplicate filename '/devices/mc0'
 CPU: 19 PID: 1 Comm: swapper/0 Not tainted 5.19.0+ #138
 random: crng init done
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
 Call trace:
  sysfs_warn_dup+0x6c/0x88
  sysfs_create_dir_ns+0xec/0x108
  kobject_add_internal+0xc0/0x328
  kobject_add+0x94/0x108
  device_add+0x104/0x8b0
  pmu_dev_alloc+0xb4/0x128
  perf_pmu_register+0x308/0x438
  xgene_pmu_dev_add+0x168/0x2c8
  acpi_pmu_dev_add+0x1f0/0x370
  acpi_ns_walk_namespace+0x16c/0x1ec
  acpi_walk_namespace+0xb0/0xf8
  xgene_pmu_probe+0x6b8/0x8a0
  platform_probe+0x70/0xe0
  really_probe+0x164/0x3b0
  __driver_probe_device+0x11c/0x190
  driver_probe_device+0x44/0xf8
  __driver_attach+0xc4/0x1b8
  bus_for_each_dev+0x78/0xd0
  driver_attach+0x2c/0x38
  bus_add_driver+0x150/0x240
  driver_register+0x6c/0x128
  __platform_driver_register+0x30/0x40
  xgene_pmu_driver_init+0x24/0x30
  do_one_initcall+0x50/0x248
  kernel_init_freeable+0x284/0x328
  kernel_init+0x2c/0x140
  ret_from_fork+0x10/0x20
 kobject_add_internal failed for mc0 with -EEXIST, don't try to register things with the same name in the same

This patch fixes it by moving edac_init() into acpi_ghes_init() and ahead of
platform_driver_register().

Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
Signed-off-by: Jia He <justin.he@arm.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c   | 1 +
 drivers/edac/edac_module.c | 3 +--
 include/linux/edac.h       | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..1127dfffeeb0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1462,6 +1462,7 @@ void __init acpi_ghes_init(void)
 	int rc;
 
 	sdei_init();
+	edac_init();
 
 	if (acpi_disabled)
 		return;
diff --git a/drivers/edac/edac_module.c b/drivers/edac/edac_module.c
index 32a931d0cb71..34ada2064b36 100644
--- a/drivers/edac/edac_module.c
+++ b/drivers/edac/edac_module.c
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(edac_get_sysfs_subsys);
  * edac_init
  *      module initialization entry point
  */
-static int __init edac_init(void)
+int __init edac_init(void)
 {
 	int err = 0;
 
@@ -160,7 +160,6 @@ static void __exit edac_exit(void)
 /*
  * Inform the kernel of our entry and exit points
  */
-subsys_initcall(edac_init);
 module_exit(edac_exit);
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/edac.h b/include/linux/edac.h
index e730b3468719..104b22c2c177 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -30,6 +30,7 @@ struct device;
 
 extern int edac_op_state;
 
+int __init edac_init(void);
 struct bus_type *edac_get_sysfs_subsys(void);
 
 static inline void opstate_init(void)
-- 
2.25.1

