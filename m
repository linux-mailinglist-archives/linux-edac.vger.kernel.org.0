Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB493C3D3F
	for <lists+linux-edac@lfdr.de>; Sun, 11 Jul 2021 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhGKONe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 11 Jul 2021 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGKONd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 11 Jul 2021 10:13:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA6C0613DD;
        Sun, 11 Jul 2021 07:10:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso8888577pjp.5;
        Sun, 11 Jul 2021 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvtFH6dEWxmgm2kiz53lVWar4+wf2bsTVAhGnY9CGHk=;
        b=DYGvn1hpRHdduWc3mlLqhyakAtce3w9M0miP85VIx/fajBuYq4sQr0n6XJARM3wzxB
         LxIafI2UfaLVN7OyeKTgWGDzXku8UYGKOh9izrCe/TLunnFb5/II5Aow2tILRsU6vCmO
         UIXhZgSjUAjXnxRrYaO1nO5addrr38+joDqLiHmkCrO6MRa3gD3SS+7AGF4lmZ+SMVtx
         NBntF5UMv65ufiDsCYuscIH5ml6TO4V+THYZJGtOduGYuSVPejMr55mH3TYX7vGm+Bif
         Djorv5N24xYEaIUNbhEmgCtbjVn9DLqo9PpsKb7VQDBvldZ7PpOOR5qcfVkoVO13RUse
         8XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvtFH6dEWxmgm2kiz53lVWar4+wf2bsTVAhGnY9CGHk=;
        b=Yi2I0stV9ExhBdzIo9+tejNH4gE92vGTCcjS7lCRSKoNHm35lImCo0iV6IOXX1lyVP
         3K5PzI9S0ebAoCGjQZFnA48W/LeQCewTk8wlLrOsvHHnf3QalOzpLC0zyZ1SwsmjiNHU
         O5rGrN69U1xoViRZc0f8mHEdEudaIDkADjY+W7v5tM4Dxd7kPhVRSGiHs+LLC06ozVm3
         Kiyyf/Tbc7R7HMkjI0+JHeNHhFY84IODpn/ieYF/AL/gPXpvLLHWE2mF+sC8KzCZkkYi
         J7BsL2Oqw8ZnrDgzcNOkpMi7iy2lIc5nSe65yfxiLd+CxHXR0jBtIqqBlJW+pCe5GP6c
         x1AQ==
X-Gm-Message-State: AOAM533m2ilfwovoTdH1IaY/4MxTCtcGuOzy17wyl0zg3znMFsF3PcpP
        GQRQGCWhlO26FLTiVEVCqHY=
X-Google-Smtp-Source: ABdhPJwc1FFA67AgWbdXPKJpA582Ve/YYu7UVpw9+PMok4DfYeA9UvkcTr238uMUe+WJYKhEVr+JCA==
X-Received: by 2002:a17:90a:4491:: with SMTP id t17mr9540645pjg.30.1626012646188;
        Sun, 11 Jul 2021 07:10:46 -0700 (PDT)
Received: from localhost.localdomain ([49.37.49.148])
        by smtp.gmail.com with ESMTPSA id gb10sm1680584pjb.43.2021.07.11.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 07:10:45 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     yazen.ghannam@amd.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     lukas.bulwahn@gmail.com, kbuild-all@lists.01.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2] drivers:edac: Use DEVICE_ATTR helper macros
Date:   Sun, 11 Jul 2021 19:40:02 +0530
Message-Id: <20210711141002.103445-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Instead of "open coding" DEVICE_ATTR, use the corresponding
helper macros DEVICE_ATTR_{RW,RO_WO} in amd64_edac.c

Some function names needed to be changed to match the device
conventions <foo>_show and <foo>_store, but the functionality
itself is unchanged.

The devices using EDAC_DCT_ATTR_SHOW() are left unchanged.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v2:
- Revert back the device name changes which broke
  the kernel. These were using the macro EDAC_DCT_ATTR_SHOW()
  to construct the show methods based on device name.
  Reported by Kernel test bot.

 drivers/edac/amd64_edac.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0d8f60acee1..99b06a3e8fb1 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -571,8 +571,8 @@ EDAC_DCT_ATTR_SHOW(dbam0);
 EDAC_DCT_ATTR_SHOW(top_mem);
 EDAC_DCT_ATTR_SHOW(top_mem2);
 
-static ssize_t hole_show(struct device *dev, struct device_attribute *mattr,
-			 char *data)
+static ssize_t dram_hole_show(struct device *dev, struct device_attribute *mattr,
+			      char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
@@ -593,7 +593,7 @@ static DEVICE_ATTR(dhar, S_IRUGO, dhar_show, NULL);
 static DEVICE_ATTR(dbam, S_IRUGO, dbam0_show, NULL);
 static DEVICE_ATTR(topmem, S_IRUGO, top_mem_show, NULL);
 static DEVICE_ATTR(topmem2, S_IRUGO, top_mem2_show, NULL);
-static DEVICE_ATTR(dram_hole, S_IRUGO, hole_show, NULL);
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

