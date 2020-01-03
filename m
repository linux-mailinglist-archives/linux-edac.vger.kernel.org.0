Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B312F97F
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgACPHo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:07:44 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1991 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgACPHo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064063; x=1609600063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJ+5iDQ/bAjdGRg85z5wISvP/YmqlU1qWWJuDNu53GA=;
  b=YtyCxLXeOAiEb+hLTmuEwTvpqskGdlWjUoe+ooyHH2vs3w0W9n6tZpfI
   LBfT0+krAqOBdOi7TM9yeQnquyW6bGxGD+ExR9lvN2cG7RJYie7mLUW9L
   j4GTi89qJBCIpHQhCYsHp4PXTU4YVPsRVKzlNttDE6LBYi/aEQlWjZPAz
   4=;
IronPort-SDR: 6JCejOW49GdUl02089QUnN3QGIvR5rbC69HjFv2Pmg3ANnTfSbTR7m2evmt/aRx0vrcWtiVBBE
 2eAjLLQPTp6g==
X-IronPort-AV: E=Sophos;i="5.69,390,1571702400"; 
   d="scan'208";a="10829612"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Jan 2020 15:07:41 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id ABF44A22F7;
        Fri,  3 Jan 2020 15:07:39 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7cnN020465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:38 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7cj2020464;
        Fri, 3 Jan 2020 16:07:38 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 3/6] x86/mce: Fix use of uninitialized MCE message string
Date:   Fri,  3 Jan 2020 16:07:19 +0100
Message-Id: <20200103150722.20313-4-jschoenh@amazon.de>
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

The function mce_severity() is not required to update its msg argument.
In fact, mce_severity_amd() does not, which makes mce_no_way_out()
return uninitialized data, which may be used later for printing.

Assuming that implementations of mce_severity() either always or never
update the msg argument (which is currently the case), it is sufficient
to initialize the temporary variable in mce_no_way_out().

While at it, avoid printing a useless "Unknown".

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
Changes v1->v2:
- simplify fix by assuming that mce_severity() either always or never
  updates the msg argument -- as opposed to mce_severity() having the
  freedom to decide on a case by case basis (requested by Boris);
- stop printing "Unknown" (requested by Boris).
---
 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0ccd6cf3402d..1d91ce956772 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -790,7 +790,7 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
 static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			  struct pt_regs *regs)
 {
-	char *tmp;
+	char *tmp = *msg;
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
@@ -1209,8 +1209,8 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
 	int cpu = smp_processor_id();
-	char *msg = "Unknown";
 	struct mce m, *final;
+	char *msg = NULL;
 	int worst = 0;
 
 	/*
-- 
2.22.0.3.gb49bb57c8208.dirty

