Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF8730D34
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 04:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjFOC0B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 22:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOC0B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 22:26:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467151BF9;
        Wed, 14 Jun 2023 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686795960; x=1718331960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFuV4fbow0deFzZsY7O6O+syFbkpiFXL5iVNmGJrgV4=;
  b=Qdq//YRFFT/oTOSEw5Wm6ojs2+nbBKUmPVZCKI3HmKtfnjBneHvowVCK
   C9aXDpyAWT0wN9JTIWhanZn4SiFgdC4WRET0w6obKEYInSdTPya0VqVoA
   epbG2fLbLZErM67hbPCsq5+msSRS06bE7AtUvf+YTuSxpjUX+Rulp4Him
   ST1C+BMK98cVL3fdEPEIK0rvMpVrLeKK3WRxGQJZwpDxCqA4eQ5jn3tHu
   zKIWAnxlY3eWw959SuArOTlOv98cHk/56sX3PgOaLqjmja8WB8tZAKMHS
   lYovqz3lD5EEd3yRbPuzGXtYYbrhjgeLOPRX0zm4ymgZMnvwbAlqu7Fzs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361270554"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361270554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 19:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="856753123"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="856753123"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2023 19:25:55 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v4 0/1] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Thu, 15 Jun 2023 10:25:33 +0800
Message-Id: <20230615022534.4163918-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Starting from SoCFPGA Agilex7, new SDM mailbox command is introduced to
read Single Event Upset Error information, SEU can detect both corrected
and uncorrected error.

If the previous HPS reboot caused by the DDR double bit error, bit-31 is
set high of boot scratch register 8. EDAC driver probe will check this
bit status and sends the SMC command to Arm Trusted Firmware.
Firmware will send mailbox command to SDM to get the SEU error
information and pass it to EDAC driver, driver will print error count,
sector address and error data for previous DDR DBE.

Introduce a new command to get Single Event Upset Error information.

changelog v4:
* Combined both the patch as per last review comment.

changelog v3:
* Fixed unnecessary type case, checkpatch warnings and typo

changelog v2:
* Updated command ID for SEU error

Niravkumar L Rabara (1):
  EDAC/altera: Check previous DDR DBE during driver probe

 drivers/edac/altera_edac.c                   | 29 ++++++++++++++++----
 include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.25.1

