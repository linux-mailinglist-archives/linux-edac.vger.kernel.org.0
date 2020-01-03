Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AE12F984
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgACPIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:08:04 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:28273 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgACPIE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064084; x=1609600084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4sqTgTN+u6x0cMWwPxL9+fdn8jhOiyRZfXoDVoHTe7Q=;
  b=DQ3+qIP1M75gapuwNM3ThdLG0tng8bAt7LT1AhnFBlmyVo9XJsqeRMh+
   pJaQ1P0hp87PVaW+F/GJPs8cpgjdtnMIa+3zPtRJeJjpr2daYungaqy90
   WZZ+xY2HeJ3qrkgCWxfNcMkgCCBcX+QJ+q0ZC0NGSliMpMlNYi/UI1FBo
   U=;
IronPort-SDR: vKEXyCsVAAGBvB15UoH4WLyjHsp29/C13vcFVXRdggYw9zMoCecdzC/wyAVP6B2n+SHy8eF6v4
 gzHRlF1vWvkA==
X-IronPort-AV: E=Sophos;i="5.69,390,1571702400"; 
   d="scan'208";a="16652117"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Jan 2020 15:07:41 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id E0760A18E5;
        Fri,  3 Jan 2020 15:07:39 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7cMf020481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:38 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7ckP020480;
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
Subject: [PATCH v2 5/6] x86/mce: Do not take action on SRAO/Deferred errors on AMD for now
Date:   Fri,  3 Jan 2020 16:07:21 +0100
Message-Id: <20200103150722.20313-6-jschoenh@amazon.de>
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

Per Yazen Ghannam we should not use the UC notifier for the time
being on AMD.

Reported-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
New in v2. This is due to a remark from Yazen on v1, that we shouldn't
be handling neither SRAO nor Deferred errors in that handler.

An alternative implementation would do the architecture "if" directly
within uc_decode_notifier(), in which case we could decide to not apply
patch 4.
---
 arch/x86/kernel/cpu/mce/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d48deb127071..d8fe5b048ee7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1970,7 +1970,8 @@ int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
 	mce_register_decode_chain_internal(&first_nb);
-	mce_register_decode_chain_internal(&mce_uc_nb);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		mce_register_decode_chain_internal(&mce_uc_nb);
 	mce_register_decode_chain_internal(&mce_default_nb);
 	mcheck_vendor_init_severity();
 
-- 
2.22.0.3.gb49bb57c8208.dirty

