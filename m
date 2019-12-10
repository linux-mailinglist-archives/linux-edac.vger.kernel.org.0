Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC9117C28
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLJAIt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 19:08:49 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64342 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfLJAIs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Dec 2019 19:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1575936527; x=1607472527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHaekBAwMl2x2lGh3VEH7z4c4/wBagr2Y0BFnAx8418=;
  b=DNv3txkezIQ5oaN4jR1QA4V9ysVA5qBZXe+179szZzRVPZRyJTSMmq72
   42Me3shcjb4u3XItj4MB5v4TZ6+/MvVuNI5LFg4vYV9P6/OSUiLAqjtRd
   aB1h7/mW9n8lZgV4AWdOsIFNItGTTtvWmLxUKKctOdeBqQins1cwhrXs7
   w=;
IronPort-SDR: b1LrS38+VaIfbQV48Ex2dsSzkjoaqIYAGOQZQYdjhD73H3FWP+FulaD/1XJbzRXKDEKyDpLp31
 tuSfWhcsB9TQ==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="13925660"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Dec 2019 00:08:34 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 3BC52A1D6A;
        Tue, 10 Dec 2019 00:08:33 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id xBA08SO7018233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:08:29 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id xBA08Q7h018227;
        Tue, 10 Dec 2019 01:08:26 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 2/6] x86/mce: Make mce=nobootlog work again
Date:   Tue, 10 Dec 2019 01:07:29 +0100
Message-Id: <20191210000733.17979-3-jschoenh@amazon.de>
X-Mailer: git-send-email 2.22.0.3.gb49bb57c8208.dirty
In-Reply-To: <20191210000733.17979-1-jschoenh@amazon.de>
References: <20191210000733.17979-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since Linux 4.5 commit 8b38937b7ab5 ("x86/mce: Do not enter deferred
errors into the generic pool twice") the mce=nobootlog option has become
mostly ineffective (after being only slightly ineffective before), as
the code is taking actions on MCEs left over from boot when they have a
usable address.

Move the check for MCP_DONTLOG a bit outward to make it effective again.

Also, since Linux 4.12 commit 011d82611172 ("RAS: Add a Corrected Errors
Collector") the two branches of the remaining "if" the bottom of
machine_check_poll() do the same. Unify them.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 arch/x86/kernel/cpu/mce/core.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d5a8b99f7ba3..81ab25d5357a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -760,24 +760,17 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 log_it:
 		error_seen = true;
 
-		mce_read_aux(&m, i);
-
-		m.severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
-
-		/*
-		 * Don't get the IP here because it's unlikely to
-		 * have anything to do with the actual error location.
-		 */
-		if (!(flags & MCP_DONTLOG) && !mca_cfg.dont_log_ce)
-			mce_log(&m);
-		else if (mce_usable_address(&m)) {
+		if (!(flags & MCP_DONTLOG)) {
+			mce_read_aux(&m, i);
+			m.severity = mce_severity(&m, mca_cfg.tolerant, NULL,
+						  false);
 			/*
-			 * Although we skipped logging this, we still want
-			 * to take action. Add to the pool so the registered
-			 * notifiers will see it.
+			 * Don't get the IP here because it's unlikely to
+			 * have anything to do with the actual error location.
 			 */
-			if (!mce_gen_pool_add(&m))
-				mce_schedule_work();
+
+			if (!mca_cfg.dont_log_ce || mce_usable_address(&m))
+				mce_log(&m);
 		}
 
 		/*
-- 
2.22.0.3.gb49bb57c8208.dirty

