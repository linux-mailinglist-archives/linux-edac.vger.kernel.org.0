Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13D117C2B
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLJAIw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 19:08:52 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6181 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAIv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Dec 2019 19:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1575936531; x=1607472531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PwOP4ZyxB9R575wj8vgIp3jwd7oy+8sBiI9LgJOgFtY=;
  b=v5O2T21XRuABzqnsjof0negCQIiHOoornFMuqTg1oRNw8a4EdALFFS69
   6wKzU62J74OJe2za0bFKCpzQTsRT1cwD4MjaquJWGOn5pDGPnON3zb0pM
   +twmROslYT5FYH3DlbdaiPRvljTP+FjvPANnPKLFGZloMz0GmgtdBzJpi
   E=;
IronPort-SDR: KWTMxw2eVwcNc0o3ykAP2cyBDQvBHn/I9jlq6UBA5qRN4V4oiSTFEHbZH0TyTs/0XPXzq6e1jG
 rhej8/w3mE0w==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="4144126"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Dec 2019 00:08:50 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id C86A2A0731;
        Tue, 10 Dec 2019 00:08:49 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id xBA08jQ2018322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:08:45 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id xBA08hT3018312;
        Tue, 10 Dec 2019 01:08:43 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 6/6] x86/mce: Remove mce_inject_log() in favor of mce_log()
Date:   Tue, 10 Dec 2019 01:07:33 +0100
Message-Id: <20191210000733.17979-7-jschoenh@amazon.de>
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

The mutex in mce_inject_log() became unnecessary with Linux 4.12 commit
5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver"),
though the original reason for its presence only vanished with Linux 4.14
commit 7298f08ea887 ("x86/mcelog: Get rid of RCU remnants").

Drop the mutex. And as that makes mce_inject_log() identical to mce_log(),
get rid of the former in favor of the latter.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 arch/x86/kernel/cpu/mce/core.c     | 11 +----------
 arch/x86/kernel/cpu/mce/inject.c   |  2 +-
 arch/x86/kernel/cpu/mce/internal.h |  2 --
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 677e9079e5ba..44cccae097cb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -53,8 +53,6 @@
 
 #include "internal.h"
 
-static DEFINE_MUTEX(mce_log_mutex);
-
 /* sysfs synchronization */
 static DEFINE_MUTEX(mce_sysfs_mutex);
 
@@ -156,14 +154,7 @@ void mce_log(struct mce *m)
 	if (!mce_gen_pool_add(m))
 		irq_work_queue(&mce_irq_work);
 }
-
-void mce_inject_log(struct mce *m)
-{
-	mutex_lock(&mce_log_mutex);
-	mce_log(m);
-	mutex_unlock(&mce_log_mutex);
-}
-EXPORT_SYMBOL_GPL(mce_inject_log);
+EXPORT_SYMBOL_GPL(mce_log);
 
 static struct notifier_block mce_srao_nb;
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 1f30117b24ba..3413b41b8d55 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -494,7 +494,7 @@ static void do_inject(void)
 		i_mce.status |= MCI_STATUS_SYNDV;
 
 	if (inj_type == SW_INJ) {
-		mce_inject_log(&i_mce);
+		mce_log(&i_mce);
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 43031db429d2..1eb1a9343188 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -78,8 +78,6 @@ static inline int apei_clear_mce(u64 record_id)
 }
 #endif
 
-void mce_inject_log(struct mce *m);
-
 /*
  * We consider records to be equivalent if bank+status+addr+misc all match.
  * This is only used when the system is going down because of a fatal error
-- 
2.22.0.3.gb49bb57c8208.dirty

