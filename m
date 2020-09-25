Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5127950C
	for <lists+linux-edac@lfdr.de>; Sat, 26 Sep 2020 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgIYXsK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Sep 2020 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgIYXrw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Sep 2020 19:47:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B356C0613D5
        for <linux-edac@vger.kernel.org>; Fri, 25 Sep 2020 16:47:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w16so4579789oia.2
        for <linux-edac@vger.kernel.org>; Fri, 25 Sep 2020 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaFO4/DZPDKszC/xRpOIOT0ycaBKLtlgtTY1MefcPH8=;
        b=PiUAdIZ04VKkfl039PRVCjljz02s4126/db3qy3qAXdHKiBlncUbrsfv8GXqasdyJf
         ZM8J6+q4V5RTCzJg0UMCjlHoTGSQhE2FZS6KOpeTaMLIQZ63Ax9zw4nWQ18vSgtif/sK
         2kNCCg4F1eajDOOSbY3Ar37JHTfR54e873gLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaFO4/DZPDKszC/xRpOIOT0ycaBKLtlgtTY1MefcPH8=;
        b=CubtjwqwnM28Yiujaj1Ytdu/8GO1pdxId5wdMyYfSyFXdu6WNNyGycLyV1w/NQMX+8
         PtXMZeU3WTgDZvWYAzpJ5ysgO1jIiCMBVv31y1bNcVkN/htPYK3vWvXsMKUvGDXvFjy6
         nMMjkRiI+XJz3cweNSi6V102lZweR/irMSPZr4E/ae+he+WVx0tX0s8SYprBayjdhcSV
         IDVNfgVMOuXv19y02yiXG0dee0dEqOgLwNh+gxPDd49VRaYR+eu4PbQuYnXO136VtNQB
         Nl5BdNur+8b6P6Q8CHylsKNeoLwMdoCkjmjAWPd4JxxEMsj+qoZAOiuT4JA8dvDpaLkJ
         q1JQ==
X-Gm-Message-State: AOAM532xczjAxh/xJIjyILZSwbqUENa0I10x7h9xOc+NHyEyVWb0r6gn
        HVUYMAeVtAR8RaDOIPASuZ6W4g==
X-Google-Smtp-Source: ABdhPJzsc6gQeJHySt+ZzxO4uOqrMB1CqsAIZXxtpLYY69pztH7Ynj225JEgu5520ZhCQjRcpfhTIg==
X-Received: by 2002:aca:628b:: with SMTP id w133mr10625oib.39.1601077671614;
        Fri, 25 Sep 2020 16:47:51 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:51 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] drivers/edac: convert pci counters to counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:25 -0600
Message-Id: <f69320551ff9526b648dd587d15f433c84c13ca3.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
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

