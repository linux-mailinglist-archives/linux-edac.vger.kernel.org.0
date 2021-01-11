Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B762F2214
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 22:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhAKVpt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 16:45:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:20892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbhAKVpt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Jan 2021 16:45:49 -0500
IronPort-SDR: U51tNpuckr48qFMG8nMhNGUsX2rHdBiyDqVmh8k/xd771wBmcFu3zMe0DLajWMsusXqlX9FWoN
 126g363h+aLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177166208"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="177166208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
IronPort-SDR: ON9q/4OUcxoRqdb/E+9YK6bG+4BABofaWZXDjw0hAlpGBfjFP81JT1sCssE0/B5bVIeoAnbObJ
 FMM4xUtYQTKA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352760861"
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
Subject: [PATCH v2 0/3] Fix infinite machine check loop in futex_wait_setup()
Date:   Mon, 11 Jan 2021 13:44:49 -0800
Message-Id: <20210111214452.1826-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20210108222251.14391-1-tony.luck@intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
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

V2 (thanks to feedback from PeterZ) fixes this by changing get_user() to
return -ENXIO ("No such device or address") for the case where a machine
check occurred. Peter left it open which error code to use (suggesting
"-EMEMERR or whatever name we come up with"). I think the existing ENXIO
error code seems appropriate (the address being accessed has effectively
gone away). But I don't have a strong attachment if anyone thinks we
need a new code.

Callers can check for ENXIO in paths where the access would be
retried so they can avoid a second machine check.

Patch roadmap:

Part 1 (unchanged since v1):
Add code to avoid the infinite loop in the machine check
code. Just panic if code runs into the same machine check a second
time. This should make it much easier to debug other places where
this happens.

Part 2: Change recovery path for get_user() to return -ENXIO

Part 3: Fix the one case in futex code that my test case hits (I'm
sure there are more).

TBD: There are a few places in arch/x86 code that test "ret == -EFAULT"
or have "switch (ret) { case -EFAULT: }" that may benefit from an
additional check for -ENXIO. For now those will continue to crash
(just like every pre-v5.10 kernel crashed when get_user() touched
poison).


Tony Luck (3):
  x86/mce: Avoid infinite loop for copy from user recovery
  x86/mce: Add new return value to get_user() for machine check
  futex, x86/mce: Avoid double machine checks

 arch/x86/kernel/cpu/mce/core.c | 7 ++++++-
 arch/x86/lib/getuser.S         | 8 +++++++-
 arch/x86/mm/extable.c          | 1 +
 include/linux/sched.h          | 3 ++-
 kernel/futex.c                 | 5 ++++-
 5 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.21.1

