Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DBA6F4FF3
	for <lists+linux-edac@lfdr.de>; Wed,  3 May 2023 08:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjECGKJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 May 2023 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECGKI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 May 2023 02:10:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2F1FE3;
        Tue,  2 May 2023 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683094207; x=1714630207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GR2N4HkxWLNSZ1b/uSNGEa2IIa7pPjdOtf4BvJc6jws=;
  b=G5JkODK91puXMCqHgnsaNCtjexTN16sYoPC0TZ3IB96PEDHvIqX+rd/h
   j8xBx/yXkbZ2AD1i7kkUaBdsk/niqFTRYKrSesCt8A6gkvroWOmkK/pyF
   xQeyS1gf6rkqYBFIJdEy6ehENhlqgPPitamh/D9W3+w60wAzS0VZzNykT
   BH5iRMK3oKmzhdWPh3ZGDTOL0Okjql/AyLXvcyIeiI/zpbx8ceDkdEdwk
   UPVHWpBJ3auFJKcDFKtjaVYWUDnbRsIi4LfcZvzm8HSf85Kd6yejTmX0F
   H9N5ZJZ1qT3E69FXbIrzwFzEjoxHxfudLIysNebEPQX14DpzXXrJcKJlj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="328205400"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="328205400"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 23:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="690573306"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="690573306"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga007.jf.intel.com with ESMTP; 02 May 2023 23:10:04 -0700
From:   niravkumar.l.rabara@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: [PATCH 0/2] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Wed,  3 May 2023 14:09:58 +0800
Message-Id: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

