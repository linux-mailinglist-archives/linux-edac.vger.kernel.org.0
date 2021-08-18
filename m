Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F83EF6D9
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 02:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhHRAa1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 20:30:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:60945 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234302AbhHRAa0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Aug 2021 20:30:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195807457"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="195807457"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 17:29:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="520687339"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 17:29:52 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/3] More machine check recovery fixes
Date:   Tue, 17 Aug 2021 17:29:39 -0700
Message-Id: <20210818002942.1607544-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210706190620.1290391-1-tony.luck@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix a couple of issues in machine check handling

1) A repeated machine check inside the kernel without calling the task
   work function between machine checks it will go into an infinite
   loop
2) Machine checks in kernel functions copying data from user addresses
   send SIGBUS to the user as if the application had consumed the
   poison. But this is wrong. The user should see either an -EFAULT
   error return or a reduced byte count (in the case of write(2)).

My latest tests have been on v4.14-rc6 with this patch (that's already
in -mm) applied:
https://lore.kernel.org/r/20210817053703.2267588-1-naoya.horiguchi@linux.dev

Changes since v1:
1) Fix bug in kill_me_never() that forgot to clear p->mce_count so
   repeated recovery in the same task would trigger the panic for
	"Machine checks to different user pages"
   [Note to Jue Wang ... this *might* be why your test that injects
    two errors into the same buffer passed to a write(2) syscall
    failed with this message]
2) Re-order patches so that "Avoid infinite loop" can be backported
   to stable.

Note that the other two parts of this series depend upon Al Viro's
extensive re-work to lib/iov_iter.c ... so don't try to backport those
without also picking up Al's work.

Tony Luck (3):
  x86/mce: Avoid infinite loop for copy from user recovery
  x86/mce: Change to not send SIGBUS error during copy from user
  x86/mce: Drop copyin special case for #MC

 arch/x86/kernel/cpu/mce/core.c | 62 ++++++++++++++++++++++++----------
 arch/x86/lib/copy_user_64.S    | 13 -------
 include/linux/sched.h          |  1 +
 3 files changed, 45 insertions(+), 31 deletions(-)


base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.29.2

