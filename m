Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0068B3C3AFD
	for <lists+linux-edac@lfdr.de>; Sun, 11 Jul 2021 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhGKHbP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 11 Jul 2021 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKHbP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 11 Jul 2021 03:31:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524BC0613DD;
        Sun, 11 Jul 2021 00:28:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 37so14735801pgq.0;
        Sun, 11 Jul 2021 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsCUaq/jkq/DjXSlYF0UoOV7d+Bpsk7nBtEeR14IAdg=;
        b=qkVVxiHCWZJDXdzTeYf8nKOzX3kMUHsBqfRkUdQZnFt11al5Lv4y5GlaN+WlNYh7y7
         IXPQjDRSriUu8HE3RnZlMvfkvhRlg9Lgm2I+bV4K5JssS+dCaHaOWXeiv/saFk9HjYes
         dppGRfG1o7RqJUwtXnmoc1rXeI/h4l7UOCgpoX/PrtNfDtsFLX4QlXnfVcVPfdTvX4uk
         uDBq1+XsFUmpgqjk5Wc5SJRrS3n2Xfe+/LfNyOw0l7y9Dj4b2lCqhVXuTYJNwSqn2hnL
         Ft7Z9dJGVUmtenrTP2TJDRPp1m23enqIeccV4FlL1IalgF/KECVUGYKYM4prEiE57euG
         20Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qsCUaq/jkq/DjXSlYF0UoOV7d+Bpsk7nBtEeR14IAdg=;
        b=iS0/AOo3T90tN4ty9tkYlMjQI6jlzkrAO8WiBKUFg3AiQAWxhsZg5iV7ctsr5YxqLM
         b+ALmEPKxesUy+pCFeJbz/jecGbk6hZQ9xXiDFcCFez+r6/se3NUE8wAhDEUDsQkx9Z2
         uYcbhvcus3pn2bgb/8wfTkUDIClBGyMzu+A1YMyVPPVFO7/CrxTv1QmWFML5D7/D4Bls
         RzgVGbpffeBHX2OI0PcP6YBHuAxRxNlXSJ4g05HHprBcZLWvCD3iJZkNshBIM5j5Hvta
         gmo35Kqp8MAy/cw4yGNzXIVQD8XHN0l/dTlnKA49m5S06KDATru073vPlBujynOnNzPr
         q83g==
X-Gm-Message-State: AOAM533dr49TI+SvWWRiYmLeBL/x11w//eBm214OKOA09EJ2wrLNBVNl
        OC1niAm2NbgscO0j+thSYvg=
X-Google-Smtp-Source: ABdhPJx9jMlLMVrZe/A6TYrYpZ7+vp5KX2Up3hL9wEGqOM2jrd1XJ61EH6XtR0waDnmdyfYSWpeGow==
X-Received: by 2002:aa7:8b0a:0:b029:329:f9e6:eaa6 with SMTP id f10-20020aa78b0a0000b0290329f9e6eaa6mr6417647pfd.13.1625988507501;
        Sun, 11 Jul 2021 00:28:27 -0700 (PDT)
Received: from localhost.localdomain ([49.37.51.242])
        by smtp.gmail.com with ESMTPSA id g1sm13125681pgs.23.2021.07.11.00.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 00:28:27 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     yazen.ghannam@amd.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] drivers:edac: Use DEVICE_ATTR helper macros
Date:   Sun, 11 Jul 2021 12:57:11 +0530
Message-Id: <20210711072711.86180-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Instead of "open coding" DEVICE_ATTR, use the corresponding
helper macros DEVICE_ATTR_{RW,RO_WO}.

Some function names needed to be changed to match the device
conventions <foo>_show and <foo>_store, but the functionality
itself is unchanged.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Build tested only with CONFIG_EDAC_DEBUG=y

 drivers/edac/amd64_edac.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0d8f60acee1..088dad0c7b40 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -567,12 +567,12 @@ static ssize_t reg##_show(struct device *dev,				\
 }
 
 EDAC_DCT_ATTR_SHOW(dhar);
-EDAC_DCT_ATTR_SHOW(dbam0);
-EDAC_DCT_ATTR_SHOW(top_mem);
-EDAC_DCT_ATTR_SHOW(top_mem2);
+EDAC_DCT_ATTR_SHOW(dbam);
+EDAC_DCT_ATTR_SHOW(topmem);
+EDAC_DCT_ATTR_SHOW(topmem2);
 
-static ssize_t hole_show(struct device *dev, struct device_attribute *mattr,
-			 char *data)
+static ssize_t dram_hole_show(struct device *dev, struct device_attribute *mattr,
+			      char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
@@ -589,11 +589,11 @@ static ssize_t hole_show(struct device *dev, struct device_attribute *mattr,
 /*
  * update NUM_DBG_ATTRS in case you add new members
  */
-static DEVICE_ATTR(dhar, S_IRUGO, dhar_show, NULL);
-static DEVICE_ATTR(dbam, S_IRUGO, dbam0_show, NULL);
-static DEVICE_ATTR(topmem, S_IRUGO, top_mem_show, NULL);
-static DEVICE_ATTR(topmem2, S_IRUGO, top_mem2_show, NULL);
-static DEVICE_ATTR(dram_hole, S_IRUGO, hole_show, NULL);
+static DEVICE_ATTR_RO(dhar);
+static DEVICE_ATTR_RO(dbam);
+static DEVICE_ATTR_RO(topmem);
+static DEVICE_ATTR_RO(topmem2);
+static DEVICE_ATTR_RO(dram_hole);
 
 static struct attribute *dbg_attrs[] = {
 	&dev_attr_dhar.attr,
@@ -802,16 +802,11 @@ static ssize_t inject_write_store(struct device *dev,
  * update NUM_INJ_ATTRS in case you add new members
  */
 
-static DEVICE_ATTR(inject_section, S_IRUGO | S_IWUSR,
-		   inject_section_show, inject_section_store);
-static DEVICE_ATTR(inject_word, S_IRUGO | S_IWUSR,
-		   inject_word_show, inject_word_store);
-static DEVICE_ATTR(inject_ecc_vector, S_IRUGO | S_IWUSR,
-		   inject_ecc_vector_show, inject_ecc_vector_store);
-static DEVICE_ATTR(inject_write, S_IWUSR,
-		   NULL, inject_write_store);
-static DEVICE_ATTR(inject_read,  S_IWUSR,
-		   NULL, inject_read_store);
+static DEVICE_ATTR_RW(inject_section);
+static DEVICE_ATTR_RW(inject_word);
+static DEVICE_ATTR_RW(inject_ecc_vector);
+static DEVICE_ATTR_WO(inject_write);
+static DEVICE_ATTR_WO(inject_read);
 
 static struct attribute *inj_attrs[] = {
 	&dev_attr_inject_section.attr,
-- 
2.28.0

