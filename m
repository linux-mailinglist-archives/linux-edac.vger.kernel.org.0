Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5904288D7E
	for <lists+linux-edac@lfdr.de>; Fri,  9 Oct 2020 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbgJIP4s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Oct 2020 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389530AbgJIP4X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Oct 2020 11:56:23 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FBC0613D7
        for <linux-edac@vger.kernel.org>; Fri,  9 Oct 2020 08:56:23 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id q136so9479598oic.8
        for <linux-edac@vger.kernel.org>; Fri, 09 Oct 2020 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQ5eLe+N4TKk/m2MMVA9WxD3zh9YwwO+rS3bSXey4Wc=;
        b=bUZbPQtzA9pUhxrcS6vt0BGsTzkif6acM0aF+G1b+4J7XeoF5YOaum3JjOkbb4bCf2
         w4vsWZTQDntyQiqtHpL/bc3FKiqnRE9RxPzgQ06eofbqczcP+H0zlg8QxKozOnygX3Mn
         MWeSrNakbEcZroGo3Ba3L7GQ9QgwjyHxj0h08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQ5eLe+N4TKk/m2MMVA9WxD3zh9YwwO+rS3bSXey4Wc=;
        b=ujNZvr7aaJFIg6ByFUp/lneAxtjzEJoqDAw/xAdzLORzss0adBiyzPbSRs8IaSJxFr
         n7c8aAKEUhZT8h1LQX9xm7pTF6MZotbFJtPRM+ErzFz8O37qBE5Dm1wehFH8mwiNcCBb
         +4VzVoTT50mFeisRMYK1eCkpVWGIj1oWU5ikEy7OBmUeh4gzJSGsM8M9McDlSX3uSRFl
         VtVwsXnIO4ZA4rgf9szrEHexC0HGM9D5jCmJVXvxQSp15+ztVbtXTQXNkjnxCH+UObb2
         qJ8Np3Fw9/o9hcJMeB+YdNAaCX7Yl3trqukynWSnnru/YEvj9OEDTObOJC4SK5FVRV5/
         Ehbw==
X-Gm-Message-State: AOAM532D9vEsg+vnL1k5t/urtD69QBk/XtmQGDNEqXbfAd3oOjSFRzKm
        oShr+PP2zxRnQssUF/5QMyKygw==
X-Google-Smtp-Source: ABdhPJyIRUbXMEBaOpRA/UeckaoQbQLGCn4azC5hq8s6xg7AvRm71FpXPQd06yoIXel6sWS6sMN7ww==
X-Received: by 2002:aca:b644:: with SMTP id g65mr2765521oif.164.1602258982986;
        Fri, 09 Oct 2020 08:56:22 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:22 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 11/11] drivers/edac: convert pci counters to counter_atomic32
Date:   Fri,  9 Oct 2020 09:56:06 -0600
Message-Id: <a54b105478ac598e49cd14a003e5692aedb5fb7c.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and open
counts that control state changes, and pm states.

atomic_t variables used for pci counters keep track of pci parity and
non-parity errors. Convert them to use counter_atomic32.

Overflow will wrap around and reset the counts as was the case prior to
the conversion.

Acked-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
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

