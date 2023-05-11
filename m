Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86406FEA83
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 06:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEKEMc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEKEMb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 00:12:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FC1BEE;
        Wed, 10 May 2023 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683778350; x=1715314350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4MCLpYMiPwclxpqObds42XMMI0dVh9kAXfSHwDTJy8=;
  b=Hf2ydTvO98Vv3aBSeNk30O95oPLVvhiuGyGf58IqB1axmeg2ixqLfWZv
   3chxzkQ0van3721Uu2OczoRKEekM1UihVWF5FDxJKbT5xiPE22zXXxeI7
   +g1eSvhdNPesXcMRpLSyrRJax0VgL+gPVH/cuNq1Z22M4SEqiZCW1rut6
   K73Bd3B5hYjzmhHLKeOdFly5GoGHIiYc1jasarY30ltLov5f5Nip8P1sZ
   /hX098+sIisRylsbZa1ZYHufzgL1QfgLLu4b9bgBCtnV/lHj6TrqJWRb7
   JyOKicUMJIJ5fmSUdNQkIkebcHOqfBIXFdsJ+MIWKkpc6n556GqcQpcTV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="347854490"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="347854490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 21:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="1029467199"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="1029467199"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2023 21:12:27 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v3 0/2] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Thu, 11 May 2023 12:12:19 +0800
Message-Id: <20230511041221.135527-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
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

Starting from SoCFPGA Agilex7, new SDM mailbox command is introduced to
read Single Event Upset Error information, SEU can detect both corrected
and uncorrected error.

If the previous HPS reboot caused by the DDR double bit error, bit-31 is
set high of boot scratch register 8. EDAC driver probe will check this
bit status and sends the SMC command to Arm Trusted Firmware.
Firmware will send mailbox command to SDM to get the SEU error
information and pass it to EDAC driver, driver will print error count,
sector address and error data for previous DDR DBE.

changelog v3:
* Fixed unnecessary type case, checkpatch warnings and typo

changelog v2:
* Updated command ID for SEU error

Niravkumar L Rabara (2):
  firmware: stratix10-svc: Add command to get SEU error info
  EDAC/altera: Check previous DDR DBE during driver probe

 drivers/edac/altera_edac.c                   | 29 ++++++++++++++++----
 include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.25.1

