Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA46F55D8
	for <lists+linux-edac@lfdr.de>; Wed,  3 May 2023 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjECKSt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 May 2023 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjECKSs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 May 2023 06:18:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4701449CF;
        Wed,  3 May 2023 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683109127; x=1714645127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3K8zwgw8WJTycgKxdkjCeC1H6LAwPHSrUbzD0KiCA0=;
  b=ZWUZRU2gqozjPAFbNrQvfHRFqAFOFfMbYfvHqD0MxvP5vpdcvku3ud4b
   366sQYl5qWrKNLH5ABqrkJUHJwqeb4To8O86c4LCH/TcnVGRlP/z5n0gm
   ewytcQIKe5V7+uO5Y+BrmHXUeJln+DuPW002w++Ha/5/2xm0jVz0IiiV+
   woszgF/uasxSsJ/zduaAMPX5JTseXsfeIaJq9qomxJ7BtBNLu6NXbmVwa
   hvb8KQ0ZedV+ApUxU6nJWL+FmxdHqTpZAm2T0QOzGQLyZgzAqpIkovHF9
   IpzjD8jzzgz+eupWsnL6yB55TO8lL/MPYL+9Eye26PAj/lea+kmCTeRJ3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="332982791"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="332982791"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 03:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="820720429"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="820720429"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 03:18:30 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v2 1/2] firmware: stratix10-svc: Add command to get SEU error info
Date:   Wed,  3 May 2023 18:18:20 +0800
Message-Id: <20230503101821.3342935-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
index a718f853d457..669e2b12be39 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -595,4 +595,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_READ_SEU_ERR
+ * Sync call to get Single Event Upsate Error information
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

