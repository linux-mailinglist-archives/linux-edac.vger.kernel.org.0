Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A742A86BC
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKETFw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 14:05:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:24077 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732074AbgKETFq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Nov 2020 14:05:46 -0500
IronPort-SDR: 0u5U/aL8UtkmMvvQooSphpILIk0OP+0wR1oAjVvE8CwM3ERKDIQdcBdCq3F1+nFGeYaKVyHjx0
 lXlIw1ch7OOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="169584673"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="169584673"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 11:05:23 -0800
IronPort-SDR: U6LL00R3L5K8HnFU6WDvb17WFVQ6lZ/RmZwdLagNdFLEWm2CvsbCVKNKUt/CDrO5QmkrMYH7pA
 wDOwzC7tU1rg==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="539529301"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 11:05:22 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Clean up the F: entries for some EDAC drivers
Date:   Thu,  5 Nov 2020 11:05:09 -0800
Message-Id: <20201105190509.19719-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201105190509.19719-1-tony.luck@intel.com>
References: <20201105074807.3697-1-qiuxu.zhuo@intel.com>
 <20201105190509.19719-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The edac_altera entry stopped at the "." and needed "[ch]" to match
both the driver and the header file.

The edac_skx entry only matched on ".c" files so didn't include skx_common.h

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86eb55697c8b..8def38b814a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2486,7 +2486,7 @@ F:	drivers/clk/socfpga/
 ARM/SOCFPGA EDAC SUPPORT
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-F:	drivers/edac/altera_edac.
+F:	drivers/edac/altera_edac.[ch]
 
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
@@ -6409,7 +6409,7 @@ EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-F:	drivers/edac/skx_*.c
+F:	drivers/edac/skx_*.[ch]
 
 EDAC-TI
 M:	Tero Kristo <t-kristo@ti.com>
-- 
2.21.1

