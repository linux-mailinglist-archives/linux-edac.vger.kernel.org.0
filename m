Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78306FEA85
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 06:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEKEMg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 00:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEKEMf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 00:12:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522949C0;
        Wed, 10 May 2023 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683778354; x=1715314354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+g78DzIgPnotxKbjQZUyQiRs7PXweLqQiSMjMRFCM8=;
  b=QXIiygcOAwKpum1jyb63enWer/jJT279RHnuS3Ouz2fnOLr3ioieS6s+
   m0zFt7SdTP9BIQXTb4q7MUfptYWMVScywCimdG4lRuymiLAs3GQnXJBGL
   NPCZrzrWH4JUEZx4WVH3uZ2HYMl7UXArjg6r2bCOn0h1JNqQGTOf8fcnh
   E0aq8MkjH34S8r4BqswQ2T4L10MfSyf9O3lECL/15lNME4MxqlmCeKAtO
   cnkvN1H6ax7DFHW3MmZzidatg3v125/5C1CzTcU3HdjenekiKUDqVNxY2
   ckdzCVlxxJoiGG1NBBoh9RTr4300K6MFP/i3JXsEEDZCi+gyLNexDwutc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="347854499"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="347854499"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 21:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="1029467214"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="1029467214"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2023 21:12:32 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v3 1/2] firmware: stratix10-svc: Add command to get SEU error info
Date:   Thu, 11 May 2023 12:12:20 +0800
Message-Id: <20230511041221.135527-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511041221.135527-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230511041221.135527-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Introduce a new command to get Single Event Upset Error information.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..48810c39f612 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -595,4 +595,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_READ_SEU_ERR
+ * Sync call to get Single Event Upset Error information
+ * SEU detects both corrected and uncorrected error
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_READ_SEU_ERR
+ * a1-7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 error count of response data
+ * a2 sector address of response data
+ * a3 error data
+ */
+#define INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS 153
+#define INTEL_SIP_SMC_READ_SEU_ERR \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS)
+
 #endif
-- 
2.25.1

