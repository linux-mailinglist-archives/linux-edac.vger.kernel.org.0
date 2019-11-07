Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17870F390E
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 20:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKGT7o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 14:59:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:34947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfKGT7o (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 14:59:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 11:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; 
   d="scan'208";a="233379305"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 11:59:42 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 0/2] Altera EDAC Cleanup
Date:   Thu,  7 Nov 2019 14:01:28 -0600
Message-Id: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patchset is a cleanup of the Altera EDAC driver that has
accumulated as the driver evolved.

Thor Thayer (2):
  EDAC/altera: Cleanup the ECC Manager
  EDAC/altera: Use Altera System Manager driver

 drivers/edac/altera_edac.c | 150 +++------------------------------------------
 1 file changed, 9 insertions(+), 141 deletions(-)

-- 
2.7.4

