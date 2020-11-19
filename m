Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9745C2B9CE5
	for <lists+linux-edac@lfdr.de>; Thu, 19 Nov 2020 22:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKSVW1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 16:22:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:60831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSVW1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Nov 2020 16:22:27 -0500
IronPort-SDR: 063/Ov2fV4cO2yxU+hTcVnFSQFdXMBV0okEvq/buNavhs3Q8TadIJs9VGtH2a7YLuoo78jI9GT
 TtB+8QKJKD+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171535890"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171535890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:26 -0800
IronPort-SDR: Vj0FhmZLRsWHjL00kBNQhNo+59JFYWNycM73o1Qq2Tq73SQJQX3ladGiEsOgPokRIRoJicwLhF
 k2sNt3gcnkzA==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="476968885"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:26 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 0/3] EDAC - fix for i10nm driver + upgrade to support Sapphire Rapids
Date:   Thu, 19 Nov 2020 13:22:16 -0800
Message-Id: <20201119212219.1335-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

First patch is a bug fix (sort of) we haven't directly seen problems
in the driver, but when adding other bits to it there have been cases
where the compiler re-ordered the access to the MMIO registers. Which
can be a problem.

Second patch adds new type for DDR5 memory

Final patch updates the i10nm EDAC driver to support Sapphire Rapids.

This series on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-igen6
(which also adds some new memory types)

Qiuxu Zhuo (3):
  EDAC/i10nm: Use readl() to access MMIO registers
  EDAC: Add DDR5 new memory type
  EDAC/i10nm: Add Intel Sapphire Rapids server support

 drivers/edac/edac_mc.c    |  1 +
 drivers/edac/i10nm_base.c | 39 +++++++++++++++++++++++++++++----------
 drivers/edac/skx_base.c   |  6 +++---
 drivers/edac/skx_common.c | 23 ++++++++++++++++++-----
 drivers/edac/skx_common.h | 16 ++++++++++++----
 include/linux/edac.h      |  3 +++
 6 files changed, 66 insertions(+), 22 deletions(-)

-- 
2.21.1

