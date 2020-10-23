Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B059D2974AE
	for <lists+linux-edac@lfdr.de>; Fri, 23 Oct 2020 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbgJWQii (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Oct 2020 12:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465672AbgJWQds (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:48 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CECF24655;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=nT+N+cDqRMSdMopYlBC9EqpjXb3tIbAp0+W/XgZ3fAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFanc/i1EBFbkN/NDUqHAK0tFpfQtmPXV1wdzzrGLfkfnjez1vBPm8ENrtO4+suSd
         id9C4rPhvYVMEnzKV4VqgO3I/mNXI6nDbzp22JksIX82DFTnVYzciwtRcZC3Ph94WR
         ptmM4fZTOCZT4SsBuA4Trvo50Bq02+vfyK/RUbrU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002Avh-W7; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/56] EDAC: fix some kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:57 +0200
Message-Id: <1d291393ba58c7b80908a3fedf02d2f53921ffe9.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Kernel-doc markup should use this format:
        identifier - description

Also, some enums are using wrong names at the kernel-doc
markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/edac/edac_device.h | 11 +++++------
 include/linux/edac.h       |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index c4c0e0bdce14..f90cbbb2ff73 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -258,7 +258,7 @@ extern struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 extern void edac_device_free_ctl_info(struct edac_device_ctl_info *ctl_info);
 
 /**
- * edac_device_add_device: Insert the 'edac_dev' structure into the
+ * edac_device_add_device - Insert the 'edac_dev' structure into the
  *	 edac_device global list and create sysfs entries associated with
  *	 edac_device structure.
  *
@@ -271,9 +271,8 @@ extern void edac_device_free_ctl_info(struct edac_device_ctl_info *ctl_info);
 extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
 
 /**
- * edac_device_del_device:
- *	Remove sysfs entries for specified edac_device structure and
- *	then remove edac_device structure from global list
+ * edac_device_del_device - Remove sysfs entries for specified edac_device
+ * 	structure and then remove edac_device structure from global list
  *
  * @dev:
  *	Pointer to struct &device representing the edac device
@@ -286,7 +285,7 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
 extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
 /**
- * Log correctable errors.
+ * edac_device_handle_ce_count - Log correctable errors.
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
  * @inst_nr: number of the instance where the CE error happened
@@ -299,7 +298,7 @@ void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
 				 const char *msg);
 
 /**
- * Log uncorrectable errors.
+ * edac_device_handle_ue_count - Log uncorrectable errors.
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
  * @inst_nr: number of the instance where the CE error happened
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 15e8f3d8a895..52d7487f6bd4 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -229,7 +229,7 @@ enum mem_type {
 #define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
 
 /**
- * enum edac-type - Error Detection and Correction capabilities and mode
+ * enum edac_type - Error Detection and Correction capabilities and mode
  * @EDAC_UNKNOWN:	Unknown if ECC is available
  * @EDAC_NONE:		Doesn't support ECC
  * @EDAC_RESERVED:	Reserved ECC type
@@ -309,7 +309,7 @@ enum scrub_type {
 #define OP_OFFLINE		0x300
 
 /**
- * enum edac_mc_layer - memory controller hierarchy layer
+ * enum edac_mc_layer_type - memory controller hierarchy layer
  *
  * @EDAC_MC_LAYER_BRANCH:	memory layer is named "branch"
  * @EDAC_MC_LAYER_CHANNEL:	memory layer is named "channel"
-- 
2.26.2

