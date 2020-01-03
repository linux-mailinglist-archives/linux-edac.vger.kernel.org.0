Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605ED12F982
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgACPID (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:08:03 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:64088 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgACPID (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064082; x=1609600082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ilxhrqiz2sA0xCthbk4rbmbS2FVPt/6iJofX5fmxfxs=;
  b=lmzDQfpRvRrdUhojVEjvWcTJUKrDmhwiXVzihyVNvH4ai1QPD+mI4yNU
   nn3ZPyDR4i0EAXDJkEKJtvWoZqOF6wt8Cz2Nmbpjbizo9rKt619zkVMkZ
   naSDiElI+S1WkYHOOxna8apGlbNlqYQyDh3u7bVHso7u+UJYhPARRW0CB
   s=;
IronPort-SDR: Oa/ojuSblhpUdRZMEVQrq0/DmPhELYjRcS+BsILcI1wiMfgpmZPicI7pxuGVx0EHyidjvUARu4
 tDS7RvKJ+U9w==
X-IronPort-AV: E=Sophos;i="5.69,391,1571702400"; 
   d="scan'208";a="10900535"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 03 Jan 2020 15:07:44 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 737AFA1D0E;
        Fri,  3 Jan 2020 15:07:39 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7bDS020457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:37 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7bQ5020456;
        Fri, 3 Jan 2020 16:07:37 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 2/6] x86/mce: Make mce=nobootlog work again
Date:   Fri,  3 Jan 2020 16:07:18 +0100
Message-Id: <20200103150722.20313-3-jschoenh@amazon.de>
X-Mailer: git-send-email 2.22.0.3.gb49bb57c8208.dirty
In-Reply-To: <20200103150722.20313-1-jschoenh@amazon.de>
References: <20200103150722.20313-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since commit 8b38937b7ab5 ("x86/mce: Do not enter deferred errors into
the generic pool twice") the mce=nobootlog option has become mostly
ineffective (after being only slightly ineffective before), as the
code is taking actions on MCEs left over from boot when they have a
usable address.

Move the check for MCP_DONTLOG a bit outward to make it effective again.

Also, since commit 011d82611172 ("RAS: Add a Corrected Errors Collector")
the two branches of the remaining "if" the bottom of machine_check_poll()
do same. Unify them.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
Changes v1->v2:
- remove an indentation level in favor of a goto (requested by Boris)
- don't mention Linux version (per remark from Boris)
---
 arch/x86/kernel/cpu/mce/core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 16134ce587fd..0ccd6cf3402d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -750,26 +750,22 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 log_it:
 		error_seen = true;
 
-		mce_read_aux(&m, i);
+		if (flags & MCP_DONTLOG)
+			goto clear_it;
 
+		mce_read_aux(&m, i);
 		m.severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
-
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
 		 */
-		if (!(flags & MCP_DONTLOG) && !mca_cfg.dont_log_ce)
-			mce_log(&m);
-		else if (mce_usable_address(&m)) {
-			/*
-			 * Although we skipped logging this, we still want
-			 * to take action. Add to the pool so the registered
-			 * notifiers will see it.
-			 */
-			if (!mce_gen_pool_add(&m))
-				mce_schedule_work();
-		}
 
+		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
+			goto clear_it;
+
+		mce_log(&m);
+
+clear_it:
 		/*
 		 * Clear state for this bank.
 		 */
-- 
2.22.0.3.gb49bb57c8208.dirty

