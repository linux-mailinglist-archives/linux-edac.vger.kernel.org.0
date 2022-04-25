Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046450DAD4
	for <lists+linux-edac@lfdr.de>; Mon, 25 Apr 2022 10:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiDYIFf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Apr 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiDYIFd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Apr 2022 04:05:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D32FD1139;
        Mon, 25 Apr 2022 01:02:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C501FB;
        Mon, 25 Apr 2022 01:02:26 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.40.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A9293F73B;
        Mon, 25 Apr 2022 01:02:21 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory-failure: Add new memory failure message MF_MSG_HUGE_ZERO
Date:   Mon, 25 Apr 2022 13:33:06 +0530
Message-Id: <20220425080306.1771480-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Memory failure just gets ignored for global huge_zero_page even without a
split attempt. But corresponding memory failure message MF_MSG_UNSPLIT_THP
is misleading as if the THP page could not be split during memory failure
handling. This adds a new message MF_MSG_HUGE_ZERO indicating that memory
got ignored for being a huge zero page.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: linux-mm@kvack.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.18-rc4

 include/linux/mm.h      | 1 +
 include/ras/ras_event.h | 1 +
 mm/memory-failure.c     | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..a947d87b1ada 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3236,6 +3236,7 @@ enum mf_action_page_type {
 	MF_MSG_SLAB,
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_HUGE,
+	MF_MSG_HUGE_ZERO,
 	MF_MSG_FREE_HUGE,
 	MF_MSG_NON_PMD_HUGE,
 	MF_MSG_UNMAP_FAILED,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 1e694fd239b9..feb9eafee966 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -359,6 +359,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_SLAB, "kernel slab page" )				\
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_HUGE, "huge page" )					\
+	EM ( MF_MSG_HUGE_ZERO, "huge zero page" )			\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
 	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 27760c19bad7..efe99e8afb73 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -718,6 +718,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_SLAB]			= "kernel slab page",
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
+	[MF_MSG_HUGE_ZERO]		= "huge zero page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
 	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
@@ -1868,7 +1869,7 @@ int memory_failure(unsigned long pfn, int flags)
 		 * TODO: Handle memory failure of huge_zero_page thoroughly.
 		 */
 		if (is_huge_zero_page(hpage)) {
-			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+			action_result(pfn, MF_MSG_HUGE_ZERO, MF_IGNORED);
 			res = -EBUSY;
 			goto unlock_mutex;
 		}
-- 
2.20.1

