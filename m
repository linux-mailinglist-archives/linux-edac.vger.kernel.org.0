Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5040D39705D
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jun 2021 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhFAJ3j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Jun 2021 05:29:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38319 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhFAJ3j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Jun 2021 05:29:39 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo0gm-0001rr-RQ
        for linux-edac@vger.kernel.org; Tue, 01 Jun 2021 09:27:56 +0000
Received: by mail-wm1-f72.google.com with SMTP id a19-20020a1c98130000b02901960b3b5621so2463391wme.8
        for <linux-edac@vger.kernel.org>; Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LpP1wbaBTd6CznJkAVeLVRWdOIhuA1LgB5xje3HBMh4=;
        b=Z10l+zUq6W3DeoPXHoZW9pVfve5PGCa0F8UDEp2ElKyBfIutuUoXDl32ZOJd7OhazS
         mKQg9xnf6Fm2iu1DFWHIspcsDXQDobLMU2nJrcB/6diEhJM0CL3TKtl/zGR5nIl+jvfK
         QMfRbgIiYpsQX/advz/yWJsxpII0dh+6Z/gQPPa5Q0bqWxIsVz9TqgudThGqNiZrEsHd
         smlRdGoqnkYuA0pBQS20ntgPeiHo7Q1PTEIcsWcPm31ODiGVoZhF5/9O/c5V2l32rYvV
         I4iGmktoZ3psmKSOWUPQjL4UtNznfRzLr12/EyBabxUPEwGVCfcpr3B8+cqMC3+E03TF
         o4lg==
X-Gm-Message-State: AOAM530j5R9MElQxesLtoQsavea18LR7NwMnTVmBpXHeS9J4cQe7Kqqb
        +7z08xXWlvyfOBIqfbiwq/ssfwYWm0M12PhFt52u1wK1rIdZDjs0wZLNry0Prj6zEGipyGLSk/s
        lg1f8lgCqy6I+w4E9EN5o36VG1yG3TrIeGc5nEtk=
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr26128729wrz.79.1622539676590;
        Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlt27WwKmWPgGZjKKTi+R3wpNAquWKWHEBbnXQTizR9DhlKa/nCvounLTe/91cT5Daw9FHrA==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr26128711wrz.79.1622539676431;
        Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id k82sm2053571wmf.11.2021.06.01.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:27:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] EDAC, altera: skip defining unused structures for specific configs
Date:   Tue,  1 Jun 2021 11:27:04 +0200
Message-Id: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Altera EDAC driver has several features conditionally built
depending on Kconfig options.  The edac_device_prv_data structures are
conditionally used in of_device_id tables.  They reference other
functions and structures which can be defined as __maybe_unused.  This
silences build warnings like:

    drivers/edac/altera_edac.c:643:37: warning:
        ‘altr_edac_device_inject_fops’ defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/edac/altera_edac.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 61c21bd880a4..2949edb93454 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -539,10 +539,18 @@ module_platform_driver(altr_edac_driver);
  * trigger testing are different for each memory.
  */
 
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
 static const struct edac_device_prv_data ocramecc_data;
+#endif
+#ifdef CONFIG_EDAC_ALTERA_L2C
 static const struct edac_device_prv_data l2ecc_data;
+#endif
+#ifdef CONFIG_EDAC_ALTERA_OCRAM
 static const struct edac_device_prv_data a10_ocramecc_data;
+#endif
+#ifdef CONFIG_EDAC_ALTERA_L2C
 static const struct edac_device_prv_data a10_l2ecc_data;
+#endif
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 {
@@ -569,9 +577,9 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 	return ret_value;
 }
 
-static ssize_t altr_edac_device_trig(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t __maybe_unused
+altr_edac_device_trig(struct file *file, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
 
 {
 	u32 *ptemp, i, error_mask;
@@ -640,27 +648,27 @@ static ssize_t altr_edac_device_trig(struct file *file,
 	return count;
 }
 
-static const struct file_operations altr_edac_device_inject_fops = {
+static const struct file_operations altr_edac_device_inject_fops __maybe_unused = {
 	.open = simple_open,
 	.write = altr_edac_device_trig,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t altr_edac_a10_device_trig(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos);
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
+			  size_t count, loff_t *ppos);
 
-static const struct file_operations altr_edac_a10_device_inject_fops = {
+static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unused = {
 	.open = simple_open,
 	.write = altr_edac_a10_device_trig,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t altr_edac_a10_device_trig2(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos);
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
+			   size_t count, loff_t *ppos);
 
-static const struct file_operations altr_edac_a10_device_inject2_fops = {
+static const struct file_operations altr_edac_a10_device_inject2_fops __maybe_unused = {
 	.open = simple_open,
 	.write = altr_edac_a10_device_trig2,
 	.llseek = generic_file_llseek,
@@ -1697,9 +1705,9 @@ MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
  * Based on xgene_edac.c peripheral code.
  */
 
-static ssize_t altr_edac_a10_device_trig(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
+			  size_t count, loff_t *ppos)
 {
 	struct edac_device_ctl_info *edac_dci = file->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
@@ -1729,9 +1737,9 @@ static ssize_t altr_edac_a10_device_trig(struct file *file,
  * slightly. A few Arria10 peripherals can use this injection function.
  * Inject the error into the memory and then readback to trigger the IRQ.
  */
-static ssize_t altr_edac_a10_device_trig2(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t __maybe_unused
+altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
+			   size_t count, loff_t *ppos)
 {
 	struct edac_device_ctl_info *edac_dci = file->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
-- 
2.27.0

