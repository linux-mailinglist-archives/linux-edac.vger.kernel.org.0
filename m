Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DDC3CA886
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jul 2021 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbhGOTBY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jul 2021 15:01:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:58175 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242613AbhGOS7s (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 15 Jul 2021 14:59:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="232440214"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="232440214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:55:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="489554318"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:55:36 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org,
        bowsingbetee <bowsingbetee@protonmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH Linus - please apply] EDAC/igen6: fix core dependency AGAIN
Date:   Thu, 15 Jul 2021 11:55:31 -0700
Message-Id: <20210715185531.1374900-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

My previous patch had a typo/thinko which prevents this driver
from being enabled: change X64_64 to X86_64.

Fixes: 0a9ece9ba154 ("EDAC/igen6: fix core dependency")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Cc: bowsingbetee <bowsingbetee@protonmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 91164c5f0757..2fc4c3f91fd5 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -271,7 +271,7 @@ config EDAC_PND2
 config EDAC_IGEN6
 	tristate "Intel client SoC Integrated MC"
 	depends on PCI && PCI_MMCONFIG && ARCH_HAVE_NMI_SAFE_CMPXCHG
-	depends on X64_64 && X86_MCE_INTEL
+	depends on X86_64 && X86_MCE_INTEL
 	help
 	  Support for error detection and correction on the Intel
 	  client SoC Integrated Memory Controller using In-Band ECC IP.
-- 
2.29.2

