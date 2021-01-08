Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F672EFB1E
	for <lists+linux-edac@lfdr.de>; Fri,  8 Jan 2021 23:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAHWXk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 17:23:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:1525 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbhAHWXk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 Jan 2021 17:23:40 -0500
IronPort-SDR: JmqZjCqzXYq4jjLV3aRuy08R+2eAjGXnDe1rTuK6zHDBgJsbkr2yzAMaKFDCsh2Lz7t6BW87mU
 axc98tB0IYnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="177810716"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="177810716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 14:22:58 -0800
IronPort-SDR: inne7I/ttTGlK6FhJGrjlSnCkt68DVMtrUoWr9UxVXLC1ADl9ukwd2+bA27atxUv7mcL4Y7SBK
 PWIOzmEuBpLA==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="423091290"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 14:22:58 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] Fix infinite machine check loop in futex_wait_setup()
Date:   Fri,  8 Jan 2021 14:22:49 -0800
Message-Id: <20210108222251.14391-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Linux can now recover from machine checks where kernel code is
doing get_user() to access application memory. But there isn't
a way to distinguish whether get_user() failed because of a page
fault or a machine check.

Thus there is a problem if any kernel code thinks it can retry
an access after doing something that would fix the page fault.

One such example (I'm sure there are more) is in futex_wait_setup()
where an attempt to read the futex with page faults disabled. Then
a retry (after dropping a lock so page faults are safe):


        ret = get_futex_value_locked(&uval, uaddr);

        if (ret) {
                queue_unlock(*hb);

                ret = get_user(uval, uaddr);

It would be good to avoid deliberately taking a second machine
check (especially as the recovery code does really bad things
and ends up in an infinite loop!).

My proposal is to add a new function arch_memory_failure()
that can be called after get_user() returns -EFAULT to allow
graceful recovery.

Futex reviewers: I just have one new call (that fixes my test
case). If you could point out other places this is needed,
that would be most helpful.

Patch roadmap:

Part 1: Add code to avoid the infinite loop in the machine check
code. Just panic if code runs into the same machine check a second
time. This should make it much easier to debug other places where
this happens.

Part 2: Add arch_memory_failure() and use it in futex_wait_setup().
[Suggestions gladly accepted for the current best way to handle the
#defines etc. to define an arch specific function to be used in
generic code]

Tony Luck (2):
  x86/mce: Avoid infinite loop for copy from user recovery
  futex, x86/mce: Avoid double machine checks

 arch/x86/include/asm/mmu.h     |  7 +++++++
 arch/x86/kernel/cpu/mce/core.c | 17 ++++++++++++++++-
 include/linux/mm.h             |  4 ++++
 include/linux/sched.h          |  3 ++-
 kernel/futex.c                 |  3 +++
 5 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.21.1

