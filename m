Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF93938B4
	for <lists+linux-edac@lfdr.de>; Fri, 28 May 2021 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhE0Waa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 May 2021 18:30:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:17756 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233848AbhE0Wa1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 May 2021 18:30:27 -0400
IronPort-SDR: 8G6v6l4BINu11ie5nsW6zisVEs2zIsT26NEZOfnj9qiT/LnGEeMY14Csop0GZ68Fwe/NQWUA0X
 VFrpE2xTHoww==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="182507305"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="182507305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 15:28:53 -0700
IronPort-SDR: s7iJE4QMr5QvnGny3w/1hOq4cI1K9Qim36Iq4xN34LXP0C1iQAtGKhxAb0MbpCaYOsUMCcP228
 ZiaS6/CFHGwA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="477684654"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 15:28:52 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH] x86/mce: Include a MCi_MISC value in faked mce logs
Date:   Thu, 27 May 2021 15:28:46 -0700
Message-Id: <20210527222846.931851-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When BIOS reports memory errors to Linux using the ACPI/APEI
error reporting method Linux creates a "struct mce" to pass
to the normal reporting code path.

The constructed record doesn't include a value for the "misc"
field of the structure, and so mce_usable_address() says this
record doesn't include a valid address.

Net result is that functions like uc_decode_notifier() will
just ignore this record instead of taking action to offline
a page.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index b58b85380ddb..0e3ae64d3b76 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -36,7 +36,8 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	mce_setup(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
-	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
+	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
-- 
2.29.2

