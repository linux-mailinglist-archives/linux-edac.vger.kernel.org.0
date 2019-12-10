Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC4117C27
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfLJAIs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 19:08:48 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26792 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAIs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Dec 2019 19:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1575936527; x=1607472527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yjeP0QuBYLEgvRSy1iLZMZ2p3fhxAaIk9IqnOA42U9c=;
  b=p1vu6kW4Wg38uHPFy6eR7lP4tYzlXnXNUIipWY8qj3U0DPH1P4dZSw/B
   rMofkjyI+ykZmajHoy6sZAnj0c/vHxLGTWT53VPCcRf08I1Tw1k8LilfP
   lkVi3rYLDExyyoIQuZDC+KbhOmoafPb2LplepnzjKFlelfIT/BCByI6C3
   E=;
IronPort-SDR: ZxTWYGc3xAQiywURUKXpRF+BOi14qJ40xrlN88Np3HyCPuouUMY9VSQrWT8mmjVOuvdWFyrS3W
 +vdFYklKOa+w==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="6901785"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Dec 2019 00:08:46 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 85FF9A24A6;
        Tue, 10 Dec 2019 00:08:45 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id xBA08ft1018300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:08:41 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id xBA08dUi018294;
        Tue, 10 Dec 2019 01:08:39 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 5/6] x86/mce: Pass MCE message to mce_panic() on failed kernel recovery
Date:   Tue, 10 Dec 2019 01:07:32 +0100
Message-Id: <20191210000733.17979-6-jschoenh@amazon.de>
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

In commit b2f9d678e28c ("x86/mce: Check for faults tagged in
EXTABLE_CLASS_FAULT exception table entries") another call to mce_panic()
was introduced. Pass the message of the handled MCE to that instance
of mce_panic() as well, as there doesn't seem to be a reason not to.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b11a74e3fea9..677e9079e5ba 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1351,7 +1351,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		ist_end_non_atomic();
 	} else {
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
-			mce_panic("Failed kernel mode recovery", &m, NULL);
+			mce_panic("Failed kernel mode recovery", &m, msg);
 	}
 
 out_ist:
-- 
2.22.0.3.gb49bb57c8208.dirty

