Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ACB397AF2
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jun 2021 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhFAUG6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Jun 2021 16:06:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:35476 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234638AbhFAUG6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Jun 2021 16:06:58 -0400
IronPort-SDR: Ku4Wsti7BHZ8oKdQGAk0DAPaW8yzPVBBc6ILFzewisoqnkoNzFpS3WSIHUfiEHpXO3CKj+J46E
 /S4cNbHtc/bw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="183994635"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="183994635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 13:05:16 -0700
IronPort-SDR: DjJfAB4g7QXJ7aEB/ShUAQrmmdVPyObelpyuK5Mn5Ut6LxPLpxrPP8uGIqaJ9E9lr6keeCZcsM
 6SqsAgorXNPA==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="479418474"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 13:05:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Christopher BeSerra <beserra@amazon.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm state
Date:   Tue,  1 Jun 2021 13:05:05 -0700
Message-Id: <20210601200505.966849-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Scripts that process error logs can do better if they know whether
Linux is executing in CMCI storm mode (only polling and reporting
some errors instead of trying to report them all). While it is possible
to parse the console log for:

	CMCI storm detected: switching to poll mode
	CMCI storm subsided: switching to interrupt mode

messages, that is error prone.

Add a new file to sysfs to report the current storm count.

Reported-by: Christopher BeSerra <beserra@amazon.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

RFC questions:
1) Is there a better way to do this?
2) Maybe just return 0 or 1 instead of the count?
3) Is there a cleaner way to handle the CONFIG_X86_MCE_INTEL dependency

 arch/x86/kernel/cpu/mce/core.c  | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bf7fe87a7e88..4c4d6b1ec120 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2431,6 +2431,20 @@ static ssize_t store_int_with_restart(struct device *s,
 	return ret;
 }
 
+#ifndef CONFIG_X86_MCE_INTEL
+static int cmci_storm_value(void)
+{
+	return 0;
+}
+#else
+int cmci_storm_value(void);
+#endif
+
+static ssize_t show_storm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", cmci_storm_value());
+}
+
 static DEVICE_INT_ATTR(tolerant, 0644, mca_cfg.tolerant);
 static DEVICE_INT_ATTR(monarch_timeout, 0644, mca_cfg.monarch_timeout);
 static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
@@ -2451,6 +2465,11 @@ static struct dev_ext_attribute dev_attr_cmci_disabled = {
 	&mca_cfg.cmci_disabled
 };
 
+static struct dev_ext_attribute dev_attr_show_storm = {
+	__ATTR(show_storm, 0444, show_storm, NULL),
+	NULL
+};
+
 static struct device_attribute *mce_device_attrs[] = {
 	&dev_attr_tolerant.attr,
 	&dev_attr_check_interval.attr,
@@ -2462,6 +2481,7 @@ static struct device_attribute *mce_device_attrs[] = {
 	&dev_attr_print_all.attr,
 	&dev_attr_ignore_ce.attr,
 	&dev_attr_cmci_disabled.attr,
+	&dev_attr_show_storm.attr,
 	NULL
 };
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index acfd5d9f93c6..4edaa0608de3 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -73,6 +73,11 @@ enum {
 
 static atomic_t cmci_storm_on_cpus;
 
+int cmci_storm_value(void)
+{
+	return atomic_read(&cmci_storm_on_cpus);
+}
+
 static int cmci_supported(int *banks)
 {
 	u64 cap;
-- 
2.29.2

