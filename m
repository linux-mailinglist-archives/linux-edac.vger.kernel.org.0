Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1405E6C09
	for <lists+linux-edac@lfdr.de>; Thu, 22 Sep 2022 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIVTv6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Sep 2022 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiIVTvs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Sep 2022 15:51:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508E10C78E;
        Thu, 22 Sep 2022 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663876307; x=1695412307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Dio6FuAowFSRZXpVJEI0kJ8UFwvjWovjlQsBMPapkk=;
  b=DVsai5c1GpFcgrO2K9GFywrgT3u3exlF3Tw1Fv8w29M1TSHv73nmk1EF
   LmP5bAVZCw4HC562Y+yyIw8FRwfUV5uq1CzsvOs/It792ysFJeUY3fxO6
   szdT5QEXU5aPgKskw3vMGEMMEfl94jbloJTRXmDWXOyjTkdPI7apZPZJE
   /ldw2R/BXfGWuBJ8acT85hMiOyaHP63eEFC+ahQnQLhHhP9I+YVMXignw
   T/ni1rNtWwikW92CXUNcLSzta2iUDIfd3gBSi0enufARHKHajQDKWZWrz
   h/dYMC6mrLPWT3jTbcNd2gf3Qi5jycjDIXEuAPi3ICPx/jI9bnxxrVEH5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280783420"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280783420"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:51:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622246712"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:51:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/2] Dump stack after certain machine checks
Date:   Thu, 22 Sep 2022 12:51:34 -0700
Message-Id: <20220922195136.54575-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In general it isn't very useful to dump the kernel stack in the panic
from a fatal machine check. The problem is almost always hardware
related, so knowing how the kernel got to the routine that triggered the
machine check isn't useful.

But Linux now has the capability to recover from most user mode and a
few kernel mode memory related machine checks. Validation folks are
testing that out and occasionally bring a kernel log like this to me:

[69608.047771] mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
[69608.021729] mce: [Hardware Error]: TSC 7874eb580177 ADDR 43bb84bd00 MISC 86 PPIN 9f061818e1a92082 
[69608.047773] Kernel panic - not syncing: Fatal local machine check
[69608.021720] mce: [Hardware Error]: RIP 10:<ffffffff8b767517> {copy_page+0x7/0x10}

All I can tell them is that Linux was copying a page and hit poison in
the source of the copy. But there are lots of reasons why Linux may be
copying a page. A stack trace would help figure out if:
1) the test was bad and just injected an error into the wrong location
2) an injected error sat around in memory and was later consumed

Case 2 will help identify places where Linux might use a "safe" copy
function that returns an error to the caller which may attempt some sort
of recovery.

Patch 1 cleans up the Intel severity calculation by using a new severity
table entry instead of some, now dubious, code to adjust the severity
for errors in kernel context.

Patch 2 adds a new severity level that triggers printing a stack trace.

I've only updated the Intel severity calculation to use this new
severity level. I'm not sure if AMD also has situations where this would
be useful. If so, then mce_severity_amd() would need to be updated too
to return different severity for IN_KERNEL and IN_KERNEL_RECOV cases.

I've tested this out on systems that do both broadcast and local machine
checks.

Tony Luck (2):
  x86/mce: Use severity table to handle uncorrected errors in kernel
  x86/mce: Dump the stack for recoverable machine checks in kernel
    context

 arch/x86/kernel/cpu/mce/internal.h |  1 +
 arch/x86/kernel/cpu/mce/core.c     | 11 +++++++++--
 arch/x86/kernel/cpu/mce/severity.c | 10 ++++++----
 3 files changed, 16 insertions(+), 6 deletions(-)


base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
-- 
2.37.3

