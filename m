Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129096F55D7
	for <lists+linux-edac@lfdr.de>; Wed,  3 May 2023 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjECKSs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 May 2023 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjECKSs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 May 2023 06:18:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688646B7;
        Wed,  3 May 2023 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683109125; x=1714645125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IeX5zpf9vANmRB96uEv41/7DBPYQIebkCf3dFEIZlL8=;
  b=HWhkLKigJ8WVBzItMo9uYEcCXb5Lv0C0v0dWOiqTzKjr78jroqLOllOb
   ENXWCdENkhFK7XCvRCbAkA1hYyl2/fKM0ALUqNnCXX9waz1DnvjqILUqg
   aMyrdRc0PXpOJGZEomtk9m16gBeB2X6Em0WrdBv+nYb3X7QubgIPelJFZ
   39poHnvnTMIoq2KKg/TYHGC6EKpzUyEwlmb78Jre1rMNET7ZIouIBVEZa
   mPwDEav+KbZAIUgHiIJau3Exnga810dnzN+5U0zcjOa6nhJCc+ZbJr1g1
   XC+001GS76vrR/SQD3DGWv3we2kEbo5k5UdPdSqK2lHMTEZC0jZ9WrvBB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="332982764"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="332982764"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 03:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="820720397"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="820720397"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 03:18:26 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v2 0/2]EDAC/altera: Check previous DDR DBE during driver probe
Date:   Wed,  3 May 2023 18:18:19 +0800
Message-Id: <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
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

Starting from SoCFPGA Agilex7, new SDM mailbox command is introduced to
read Single Event Upset Error information, SEU can detect both corrected
and uncorrected error.

If the previous HPS reboot caused by the DDR double bit error, bit-31 is
set high of boot scratch register 8. EDAC driver probe will check this
bit status and sends the SMC command to Arm Trusted Firmware.
Firmware will send mailbox command to SDM to get the SEU error
information and pass it to EDAC driver, driver will print error count,
sector address and error data for previous DDR DBE.

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

