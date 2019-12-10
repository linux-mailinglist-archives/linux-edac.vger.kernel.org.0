Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C0117C29
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfLJAIt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 19:08:49 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64342 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAIt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Dec 2019 19:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1575936529; x=1607472529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=diyFI+RzBffASURwBK3Ni++loyuQbTc2IKXMyHuvZtM=;
  b=DfRwjri9fC2CN6pJxvzcW3JJuSnQMqeHQD7REHarJBl8pUjq1xBdLIEL
   zHtquvNwZs7f01Vk5dpyb6F/U9y8d9POiHiTJ5hnNPbEIfulRVeNhHHJr
   Q9AR5bOw8CRN25SFkCQxv71N0gUddU+kZCUei8usjZXQc7STIaFmPuu12
   8=;
IronPort-SDR: KBPs6GRqDzqTG3zmlI/xsFn3k8Q0+ScvDlijyUu9zAosHvDKpX1W7eM0GnSfPWWUKwLJB72/uT
 zazJ9f7JqqUA==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="13925675"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Dec 2019 00:08:42 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 67ADAA1D34;
        Tue, 10 Dec 2019 00:08:41 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id xBA08bm2018278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:08:37 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id xBA08ZB9018272;
        Tue, 10 Dec 2019 01:08:35 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 4/6] x86/mce: Fix handling of optional message string
Date:   Tue, 10 Dec 2019 01:07:31 +0100
Message-Id: <20191210000733.17979-5-jschoenh@amazon.de>
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

The function mce_severity() is not required to update its msg argument.
In fact, mce_severity_amd() doesn't. Fix some code paths, that assume
that it is always updated.

In particular, this avoids returning uninitialized data in
mce_no_way_out(), which may be used later for printing.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6afb9de251f2..b11a74e3fea9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -809,10 +809,12 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 		if (quirk_no_way_out)
 			quirk_no_way_out(i, m, regs);
 
+		tmp = NULL;
 		m->bank = i;
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
-			*msg = tmp;
+			if (tmp)
+				*msg = tmp;
 			return 1;
 		}
 	}
@@ -1313,6 +1315,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		 * make sure we have the right "msg".
 		 */
 		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+			msg = "Unknown";
 			mce_severity(&m, cfg->tolerant, &msg, true);
 			mce_panic("Local fatal machine check!", &m, msg);
 		}
-- 
2.22.0.3.gb49bb57c8208.dirty

