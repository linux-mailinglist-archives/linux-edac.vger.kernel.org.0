Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873C96F4EFC
	for <lists+linux-edac@lfdr.de>; Wed,  3 May 2023 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjECDGh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 May 2023 23:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjECDGf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 May 2023 23:06:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1903D1FD2;
        Tue,  2 May 2023 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683083193; x=1714619193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GR2N4HkxWLNSZ1b/uSNGEa2IIa7pPjdOtf4BvJc6jws=;
  b=QsJci4NMNjgfuVIO0Jd6W1ILUseiV/6ThWQiLv1HsQERl4RPhE8rskeC
   wpTvO9WpjVaJ0h64EtAvSUFSYWcm+HJmMRLyPeceqishP12T+n1Iih/FO
   ugTqlXarxrw5v8TddWBs5Xf4hLM1S1MMk20cjmxRKRH3dQbk1fvHOVsJo
   GljHmnjTstHv7x6CLq882OCZkSfgOCFGHxsDC6zLCMjqe+veu+OPM2Lcj
   VL08lC+zQRKKTeXvNVfKipvTuOEoW9u8fLPJSoEhlpcnSVuKuY/tf0NRq
   LuwfKD9mX3k6GDaA4e+jBvqQnT6oFuBACSn2KYVevWgFnyn3R3zsgCAw2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350629350"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="350629350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 20:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="840541281"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="840541281"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2023 20:06:30 -0700
From:   niravkumar.l.rabara@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: [PATCH 0/2] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Wed,  3 May 2023 11:06:22 +0800
Message-Id: <20230503030622.3269205-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Starting from SoCFPGA Agilex7, new SDM mailbox command is introduced
to read Single Event Update Error information, SEU detects both
corrected and uncorrected error.

If the previous HPS reboot caused by the DDR double bit error, bit-31 is
set high of boot scratch register 8. EDAC driver probe will check this
bit status and sends the SMC command to Arm Trusted Firmware.
Firmware will send mailbox command to SDM to get the SEU error
information and pass it to EDAC driver, driver will print error count,
sector address and error data for previous DDR DBE.

Niravkumar L Rabara (2):
  firmware: stratix10-svc: Add command to get SEU error info
  EDAC/altera: Check previous DDR DBE during driver probe

 drivers/edac/altera_edac.c                   | 29 ++++++++++++++++----
 include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.25.1

