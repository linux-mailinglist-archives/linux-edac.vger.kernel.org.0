Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07B2B22F8
	for <lists+linux-edac@lfdr.de>; Fri, 13 Nov 2020 18:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMRrd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Nov 2020 12:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgKMRqo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Nov 2020 12:46:44 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24945C0617A6
        for <linux-edac@vger.kernel.org>; Fri, 13 Nov 2020 09:46:44 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id n5so9218201ile.7
        for <linux-edac@vger.kernel.org>; Fri, 13 Nov 2020 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZOTFdjKMxWDW6EAVCBI0JinrLyj8iSSC/Af1k/3gnI=;
        b=KheRvfIvjADKYxvwGjJjKm/A6xh7xm10V4N93Y3RtUd+Y0mg0/LlorYo5HC+fc2sK5
         O7SIaohgeXI9OKtfF9oguSJZvlOuZqJsu1tJ0sfvp0hq9zS2AVRHr/92kx1DSLkR7J9R
         EfFVewz3LgBxDr9XCK23guEdJ8PbpKf+YhrX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZOTFdjKMxWDW6EAVCBI0JinrLyj8iSSC/Af1k/3gnI=;
        b=hBotUTYcuP8ct8b4fQTB4qOP1syA6nKIdJOJ8/PQ3NcjkRVjzX33UmUVg1BWPLJBi/
         wK4Tevh6ORS8FCNT9qUsmWM9Tc2DRagM4Pu3znMQaDi+lgBoeZm8yEDrcx+NW6FCJE/x
         wpjyzH+JEPlQ/McMnvcCM81LvULYRgUbQoNwz8w7doBDqc64Lwm0nuj/UReNbMygG2DL
         49DceUDHoJ/XfUnmskkWhwGujax8dip8NEigBvWRxffJmSRMVTAtHwDbdwlmJ+/brL4Y
         8CP2RtppYt9bheWUEiTF7EjbsRniD9ieuzNDEDlMN2IlRbSNKVjZs2I65gyUrnDVds/K
         BhYw==
X-Gm-Message-State: AOAM530b10XTzcRrdv1wICY8tkrbuYefXnw41rW9qf1SjKXGA+hzHs8c
        2OV3JkmETu0rHKg6jlQeK2r9pA==
X-Google-Smtp-Source: ABdhPJyWh55lbwwUW7m1OjaCNdAqaIRPhRIe3HVxdc+DBweTcV2FCaPQm11aD+uPc1OtJPOER0MuHQ==
X-Received: by 2002:a05:6e02:1114:: with SMTP id u20mr771268ilk.226.1605289600737;
        Fri, 13 Nov 2020 09:46:40 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:40 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] drivers/edac: convert pci counters to seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:09 -0700
Message-Id: <795814646174c12c68e1624e246e19a61b7ac2e0.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

atomic_t variables used for pci counters keep track of pci parity and
non-parity errors. Convert them to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/edac/edac_pci.h       |  5 +++--
 drivers/edac/edac_pci_sysfs.c | 30 +++++++++++++++---------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/edac_pci.h b/drivers/edac/edac_pci.h
index 5175f5724cfa..33b33e62c37f 100644
--- a/drivers/edac/edac_pci.h
+++ b/drivers/edac/edac_pci.h
@@ -30,12 +30,13 @@
 #include <linux/pci.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/seqnum_ops.h>
 
 #ifdef CONFIG_PCI
 
 struct edac_pci_counter {
-	atomic_t pe_count;
-	atomic_t npe_count;
+	struct seqnum32 pe_count;
+	struct seqnum32 npe_count;
 };
 
 /*
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 53042af7262e..08a34ecd2fb7 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -23,8 +23,8 @@ static int edac_pci_log_pe = 1;		/* log PCI parity errors */
 static int edac_pci_log_npe = 1;	/* log PCI non-parity error errors */
 static int edac_pci_poll_msec = 1000;	/* one second workq period */
 
-static atomic_t pci_parity_count = ATOMIC_INIT(0);
-static atomic_t pci_nonparity_count = ATOMIC_INIT(0);
+static struct seqnum32 pci_parity_count = SEQNUM_INIT(0);
+static struct seqnum32 pci_nonparity_count = SEQNUM_INIT(0);
 
 static struct kobject *edac_pci_top_main_kobj;
 static atomic_t edac_pci_sysfs_refcount = ATOMIC_INIT(0);
@@ -58,13 +58,13 @@ int edac_pci_get_poll_msec(void)
 /**************************** EDAC PCI sysfs instance *******************/
 static ssize_t instance_pe_count_show(struct edac_pci_ctl_info *pci, char *data)
 {
-	return sprintf(data, "%u\n", atomic_read(&pci->counters.pe_count));
+	return sprintf(data, "%u\n", seqnum32_fetch(&pci->counters.pe_count));
 }
 
 static ssize_t instance_npe_count_show(struct edac_pci_ctl_info *pci,
 				char *data)
 {
-	return sprintf(data, "%u\n", atomic_read(&pci->counters.npe_count));
+	return sprintf(data, "%u\n", seqnum32_fetch(&pci->counters.npe_count));
 }
 
 #define to_instance(k) container_of(k, struct edac_pci_ctl_info, kobj)
@@ -553,7 +553,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 			edac_printk(KERN_CRIT, EDAC_PCI,
 				"Signaled System Error on %s\n",
 				pci_name(dev));
-			atomic_inc(&pci_nonparity_count);
+			seqnum32_inc_return(&pci_nonparity_count);
 		}
 
 		if (status & (PCI_STATUS_PARITY)) {
@@ -561,7 +561,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 				"Master Data Parity Error on %s\n",
 				pci_name(dev));
 
-			atomic_inc(&pci_parity_count);
+			seqnum32_inc_return(&pci_parity_count);
 		}
 
 		if (status & (PCI_STATUS_DETECTED_PARITY)) {
@@ -569,7 +569,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 				"Detected Parity Error on %s\n",
 				pci_name(dev));
 
-			atomic_inc(&pci_parity_count);
+			seqnum32_inc_return(&pci_parity_count);
 		}
 	}
 
@@ -592,7 +592,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
 					"Signaled System Error on %s\n",
 					pci_name(dev));
-				atomic_inc(&pci_nonparity_count);
+				seqnum32_inc_return(&pci_nonparity_count);
 			}
 
 			if (status & (PCI_STATUS_PARITY)) {
@@ -600,7 +600,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 					"Master Data Parity Error on "
 					"%s\n", pci_name(dev));
 
-				atomic_inc(&pci_parity_count);
+				seqnum32_inc_return(&pci_parity_count);
 			}
 
 			if (status & (PCI_STATUS_DETECTED_PARITY)) {
@@ -608,7 +608,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 					"Detected Parity Error on %s\n",
 					pci_name(dev));
 
-				atomic_inc(&pci_parity_count);
+				seqnum32_inc_return(&pci_parity_count);
 			}
 		}
 	}
@@ -638,7 +638,7 @@ static inline void edac_pci_dev_parity_iterator(pci_parity_check_fn_t fn)
  */
 void edac_pci_do_parity_check(void)
 {
-	int before_count;
+	u32 before_count;
 
 	edac_dbg(3, "\n");
 
@@ -646,7 +646,7 @@ void edac_pci_do_parity_check(void)
 	if (!check_pci_errors)
 		return;
 
-	before_count = atomic_read(&pci_parity_count);
+	before_count = seqnum32_fetch(&pci_parity_count);
 
 	/* scan all PCI devices looking for a Parity Error on devices and
 	 * bridges.
@@ -658,7 +658,7 @@ void edac_pci_do_parity_check(void)
 	/* Only if operator has selected panic on PCI Error */
 	if (edac_pci_get_panic_on_pe()) {
 		/* If the count is different 'after' from 'before' */
-		if (before_count != atomic_read(&pci_parity_count))
+		if (before_count != seqnum32_fetch(&pci_parity_count))
 			panic("EDAC: PCI Parity Error");
 	}
 }
@@ -686,7 +686,7 @@ void edac_pci_handle_pe(struct edac_pci_ctl_info *pci, const char *msg)
 {
 
 	/* global PE counter incremented by edac_pci_do_parity_check() */
-	atomic_inc(&pci->counters.pe_count);
+	seqnum32_inc_return(&pci->counters.pe_count);
 
 	if (edac_pci_get_log_pe())
 		edac_pci_printk(pci, KERN_WARNING,
@@ -711,7 +711,7 @@ void edac_pci_handle_npe(struct edac_pci_ctl_info *pci, const char *msg)
 {
 
 	/* global NPE counter incremented by edac_pci_do_parity_check() */
-	atomic_inc(&pci->counters.npe_count);
+	seqnum32_inc_return(&pci->counters.npe_count);
 
 	if (edac_pci_get_log_npe())
 		edac_pci_printk(pci, KERN_WARNING,
-- 
2.27.0

