Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA8105980
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUS3M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 13:29:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:3683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUS3M (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 13:29:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 10:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="381823333"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2019 10:29:10 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     Meng.Li@windriver.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2 0/3] Altera EDAC Fix & Cleanup Patches
Date:   Thu, 21 Nov 2019 12:30:45 -0600
Message-Id: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patchset includes a fix for the Stratix10 IRQ regmap
and cleanup of the driver as it has evolved.

Patch 2 and 3 were accepted into the edac-for-next branch [1]
but the fix should be included. Version 2 of the patches
rebase on top of the fix.

This patchset should replace the current patches[1].

[1] https://lore.kernel.org/linux-edac/1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com/

Meng Li (1):
  EDAC/altera: Use fast register IO for S10 IRQs

Thor Thayer (2):
  EDAC/altera: Cleanup the ECC Manager
  EDAC/altera: Use the Altera System Manager driver

 drivers/edac/altera_edac.c | 152 +++------------------------------------------
 1 file changed, 9 insertions(+), 143 deletions(-)

-- 
2.7.4

