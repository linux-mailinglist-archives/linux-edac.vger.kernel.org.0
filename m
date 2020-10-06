Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF29285365
	for <lists+linux-edac@lfdr.de>; Tue,  6 Oct 2020 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgJFUqL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Oct 2020 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgJFUqG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Oct 2020 16:46:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798D4C0613D2
        for <linux-edac@vger.kernel.org>; Tue,  6 Oct 2020 13:46:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t7so103217ilf.10
        for <linux-edac@vger.kernel.org>; Tue, 06 Oct 2020 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bv+5GiaG/LcuKTT3iu5LLoZTiwRc7KlRllwmZiSrosw=;
        b=FL8PP2NVW1HIPVO0IhjN7z+q8LP6474DNBoj6mJ2Xe/zmlZ5SBxBZKeP8wTK0EA4m9
         RVkR5yD5ZzEOrrZRc1AU6QSUAUlgm0zC1pTD9wl/S/brmd6Bxo3qDwTgPVyF9v5A5Kpr
         Z2fcw3h193wXNzMBc6N8GeXXP+IXPaNOZ3a+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bv+5GiaG/LcuKTT3iu5LLoZTiwRc7KlRllwmZiSrosw=;
        b=JT0s5R73ANxHCKjBIPCviLQ2ZpXs02KhuPhms2G67H432zGUGjNoMhvHfGrTTXNAtU
         Bi/wIkQIQfJtjyuUE+sj1fF3wHug8BF3ekxaQH3CU7XTCRzwhquc06cOaOsX6jzDdz+v
         kaVzNOtzJctsM4kiJVvOOtMraWn7Q6eoZ6vnTzyh9a9cmCTFk5U+xCmg/6jbEA4g+U5m
         ZainZg5SPVyhbZlhP/Cv7/+itzJoOBKsVWLbpsZtRTdbhgk+Bqtu8BEO9ZJA0LJR1vdC
         v1qownPozsnCZkdXEFnO7bKBrvVDLXO91Gbwa7uugdR/t2nAI8VgBYWMSAmRc9bSabVY
         jmmQ==
X-Gm-Message-State: AOAM5316Ub9OBnYlQqbMLlNR0vw0H+uflRSPhJs1X/BVTcgXNas/eRq1
        BHbWIVA546L7syQHYhXprimktA==
X-Google-Smtp-Source: ABdhPJy7xF551ziYXOReG4BPUfTRZBAq199bpzKm3MbF/0nJHFcRodAHVwJxtWbsU8uC4/CbzkcL1Q==
X-Received: by 2002:a05:6e02:54d:: with SMTP id i13mr4975410ils.219.1602017163833;
        Tue, 06 Oct 2020 13:46:03 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:46:03 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 11/11] drivers/edac: convert pci counters to counter_atomic32
Date:   Tue,  6 Oct 2020 14:44:42 -0600
Message-Id: <03dc29c130e6522448a4328b1cfa8fbf7c9a8c97.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used for pci counters keep track of pci parity and
non-parity errors. Convert them to use counter_atomic32.

Overflow will wrap around and reset the counts as was the case prior to
the conversion.

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/edac/edac_pci.h       |  5 +++--
 drivers/edac/edac_pci_sysfs.c | 28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/edac_pci.h b/drivers/edac/edac_pci.h
index 5175f5724cfa..797b25a6afc0 100644
--- a/drivers/edac/edac_pci.h
+++ b/drivers/edac/edac_pci.h
@@ -30,12 +30,13 @@
 #include <linux/pci.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/counters.h>
 
 #ifdef CONFIG_PCI
 
 struct edac_pci_counter {
-	atomic_t pe_count;
-	atomic_t npe_count;
+	struct counter_atomic32 pe_count;
+	struct counter_atomic32 npe_count;
 };
 
 /*
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 53042af7262e..d33a726234c0 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -23,8 +23,8 @@ static int edac_pci_log_pe = 1;		/* log PCI parity errors */
 static int edac_pci_log_npe = 1;	/* log PCI non-parity error errors */
 static int edac_pci_poll_msec = 1000;	/* one second workq period */
 
-static atomic_t pci_parity_count = ATOMIC_INIT(0);
-static atomic_t pci_nonparity_count = ATOMIC_INIT(0);
+static struct counter_atomic32 pci_parity_count = COUNTER_ATOMIC_INIT(0);
+static struct counter_atomic32 pci_nonparity_count = COUNTER_ATOMIC_INIT(0);
 
 static struct kobject *edac_pci_top_main_kobj;
 static atomic_t edac_pci_sysfs_refcount = ATOMIC_INIT(0);
@@ -58,13 +58,13 @@ int edac_pci_get_poll_msec(void)
 /**************************** EDAC PCI sysfs instance *******************/
 static ssize_t instance_pe_count_show(struct edac_pci_ctl_info *pci, char *data)
 {
-	return sprintf(data, "%u\n", atomic_read(&pci->counters.pe_count));
+	return sprintf(data, "%u\n", counter_atomic32_read(&pci->counters.pe_count));
 }
 
 static ssize_t instance_npe_count_show(struct edac_pci_ctl_info *pci,
 				char *data)
 {
-	return sprintf(data, "%u\n", atomic_read(&pci->counters.npe_count));
+	return sprintf(data, "%u\n", counter_atomic32_read(&pci->counters.npe_count));
 }
 
 #define to_instance(k) container_of(k, struct edac_pci_ctl_info, kobj)
@@ -553,7 +553,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 			edac_printk(KERN_CRIT, EDAC_PCI,
 				"Signaled System Error on %s\n",
 				pci_name(dev));
-			atomic_inc(&pci_nonparity_count);
+			counter_atomic32_inc(&pci_nonparity_count);
 		}
 
 		if (status & (PCI_STATUS_PARITY)) {
@@ -561,7 +561,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 				"Master Data Parity Error on %s\n",
 				pci_name(dev));
 
-			atomic_inc(&pci_parity_count);
+			counter_atomic32_inc(&pci_parity_count);
 		}
 
 		if (status & (PCI_STATUS_DETECTED_PARITY)) {
@@ -569,7 +569,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 				"Detected Parity Error on %s\n",
 				pci_name(dev));
 
-			atomic_inc(&pci_parity_count);
+			counter_atomic32_inc(&pci_parity_count);
 		}
 	}
 
@@ -592,7 +592,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
 					"Signaled System Error on %s\n",
 					pci_name(dev));
-				atomic_inc(&pci_nonparity_count);
+				counter_atomic32_inc(&pci_nonparity_count);
 			}
 
 			if (status & (PCI_STATUS_PARITY)) {
@@ -600,7 +600,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 					"Master Data Parity Error on "
 					"%s\n", pci_name(dev));
 
-				atomic_inc(&pci_parity_count);
+				counter_atomic32_inc(&pci_parity_count);
 			}
 
 			if (status & (PCI_STATUS_DETECTED_PARITY)) {
@@ -608,7 +608,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 					"Detected Parity Error on %s\n",
 					pci_name(dev));
 
-				atomic_inc(&pci_parity_count);
+				counter_atomic32_inc(&pci_parity_count);
 			}
 		}
 	}
@@ -646,7 +646,7 @@ void edac_pci_do_parity_check(void)
 	if (!check_pci_errors)
 		return;
 
-	before_count = atomic_read(&pci_parity_count);
+	before_count = counter_atomic32_read(&pci_parity_count);
 
 	/* scan all PCI devices looking for a Parity Error on devices and
 	 * bridges.
@@ -658,7 +658,7 @@ void edac_pci_do_parity_check(void)
 	/* Only if operator has selected panic on PCI Error */
 	if (edac_pci_get_panic_on_pe()) {
 		/* If the count is different 'after' from 'before' */
-		if (before_count != atomic_read(&pci_parity_count))
+		if (before_count != counter_atomic32_read(&pci_parity_count))
 			panic("EDAC: PCI Parity Error");
 	}
 }
@@ -686,7 +686,7 @@ void edac_pci_handle_pe(struct edac_pci_ctl_info *pci, const char *msg)
 {
 
 	/* global PE counter incremented by edac_pci_do_parity_check() */
-	atomic_inc(&pci->counters.pe_count);
+	counter_atomic32_inc(&pci->counters.pe_count);
 
 	if (edac_pci_get_log_pe())
 		edac_pci_printk(pci, KERN_WARNING,
@@ -711,7 +711,7 @@ void edac_pci_handle_npe(struct edac_pci_ctl_info *pci, const char *msg)
 {
 
 	/* global NPE counter incremented by edac_pci_do_parity_check() */
-	atomic_inc(&pci->counters.npe_count);
+	counter_atomic32_inc(&pci->counters.npe_count);
 
 	if (edac_pci_get_log_npe())
 		edac_pci_printk(pci, KERN_WARNING,
-- 
2.25.1

