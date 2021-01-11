Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C82F221C
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 22:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbhAKVqa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 16:46:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:20926 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731135AbhAKVq3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Jan 2021 16:46:29 -0500
IronPort-SDR: +2t+Mdtmtl6g2dk7YF2UYUJ8jJN6w4gl6ZCntod3VCageBFm0FUumbmb2OfQQLVaqgHVaW7slc
 Qzpqh8swNDAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177166211"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="177166211"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
IronPort-SDR: +hZpGNm/k1XCMrPo4g89/aNf7U2+ZmNAXdUEFb5sHxdr4/ePzBAjecP6x/wx3X/nPg3xc+P4vb
 GyWVQYoOAztw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352760874"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 3/3] futex, x86/mce: Avoid double machine checks
Date:   Mon, 11 Jan 2021 13:44:52 -0800
Message-Id: <20210111214452.1826-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20210111214452.1826-1-tony.luck@intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210111214452.1826-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

futex_wait_setup() first tries to read the user value with page faults
disabled (because it holds a lock, and so cannot sleep). If that read
fails it drops the lock and tries again.

But there are now two reasons why the user space read can fail. Either:
1) legacy case of a page fault, in which case it is reasonable to retry
2) machine check on the user address, bad idea to re-read

Check for the ENXIO return code from the first get_user() call and
immediately return an error without re-reading the futex.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 kernel/futex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c47d1015d759..b11166712a9f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -723,7 +723,7 @@ static int get_futex_value_locked(u32 *dest, u32 __user *from)
 	ret = __get_user(*dest, from);
 	pagefault_enable();
 
-	return ret ? -EFAULT : 0;
+	return (ret == -ENXIO) ? ret : ret ? -EFAULT : 0;
 }
 
 
@@ -2658,6 +2658,9 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	if (ret) {
 		queue_unlock(*hb);
 
+		if (ret == -ENXIO)
+			return ret;
+
 		ret = get_user(uval, uaddr);
 		if (ret)
 			return ret;
-- 
2.21.1

