Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAE117C26
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLJAIp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 19:08:45 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6165 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAIo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Dec 2019 19:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1575936524; x=1607472524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpv4VG7PIjudrNgaI7UFOxOh5o/9bkkIlS+d2xSAdhI=;
  b=a9JxCM3pEHc0hF4kMWssEhkOR8fhK0pAtwzp2ty7BFzWT/2NTKzsW2zm
   yn+C1+1VYc6ZHAQqBeGuXuF5J6JF2vmjO9Jft0J7rYk80KsCGsOkeCmrK
   daVCNGr1jFpDPoS/bu33rLvuxu0sRTC/7/rtsSwVV3poUfvHsYzD7g2lt
   w=;
IronPort-SDR: 7mN0fRfcHf5mgSLbtzcJ/TUol1ei8kMCusTiSYbu7F8XfET/DGC0HP+u2MQBFlSeWVjYLT/UAM
 JVcZlVW2ZG4A==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="4144095"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Dec 2019 00:08:33 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 4AE891416B1;
        Tue, 10 Dec 2019 00:08:29 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id xBA08OKm018214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:08:24 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id xBA08Mbg018201;
        Tue, 10 Dec 2019 01:08:22 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 1/6] x86/mce: Take action on UCNA/Deferred errors again
Date:   Tue, 10 Dec 2019 01:07:28 +0100
Message-Id: <20191210000733.17979-2-jschoenh@amazon.de>
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

Linux 3.19 commit fa92c5869426 ("x86, mce: Support memory error recovery
for both UCNA and Deferred error in machine_check_poll") added handling
of UCNA and Deferred errors by adding them to the ring for SRAO errors.

Later, Linux 4.3 commit fd4cf79fcc4b ("x86/mce: Remove the MCE ring for
Action Optional errors") switched storage from the SRAO ring to the
unified pool that is still in use today. In order to only act on the
intended errors, a filter for MCE_AO_SEVERITY was used -- effectively
removing handling of UCNA/Deferred errors again.

Extend the severity filter to include UCNA/Deferred errors once more.

Fixes: fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action Optional errors")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 arch/x86/kernel/cpu/mce/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370ee4983..d5a8b99f7ba3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -595,14 +595,16 @@ static int srao_decode_notifier(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	unsigned long pfn;
 
-	if (!mce)
+	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
 
-	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
-		pfn = mce->addr >> PAGE_SHIFT;
-		if (!memory_failure(pfn, 0))
-			set_mce_nospec(pfn);
-	}
+	if (mce->severity != MCE_AO_SEVERITY &&
+	    mce->severity != MCE_DEFERRED_SEVERITY)
+		return NOTIFY_DONE;
+
+	pfn = mce->addr >> PAGE_SHIFT;
+	if (!memory_failure(pfn, 0))
+		set_mce_nospec(pfn);
 
 	return NOTIFY_OK;
 }
-- 
2.22.0.3.gb49bb57c8208.dirty

