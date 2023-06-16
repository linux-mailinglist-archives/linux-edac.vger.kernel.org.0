Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC0733815
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 20:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjFPS1x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Jun 2023 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFPS1x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Jun 2023 14:27:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1911FD5;
        Fri, 16 Jun 2023 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686940072; x=1718476072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1P73af2PU29diiA8lKo+STH5zOYKWYk0+UumfR4BUbY=;
  b=TyDzO1i1SiHw4L6+/1UUdk/w2o5jrFvuS2tsCM+aGQFuhm/jtumU7WgU
   gV05/pNgtfRn1oV3/ZZygkzTCprKyrIWVEKMrdhUvkPna6XCw6GuSej3Q
   u3cuO9CUvr31e7ZrhbY4pyS8h/mmPLYEaKgBIioPBSbeu+IFXL4Pyxtfz
   Cv4iwTO8wdGT7sBBShbYap9RWETn8rzO3LUr9AHMy3yj4DNokaCzNKRIt
   w9Ijzzo55cc4syFqiBoV3H56Y65CTh1bNWBqROMww41N9jNh/ZQxfC6cz
   tYHikvFkgHxw8ktfR/ASqFdBe27FQow+9X3AlJLwZ7m5Sul/nEq/rcVnr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361815181"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="361815181"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="783018161"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="783018161"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:27:50 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 0/4] Handle corrected machine check interrupt storms
Date:   Fri, 16 Jun 2023 11:27:40 -0700
Message-Id: <20230616182744.17632-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230411173841.70491-1-tony.luck@intel.com>
References: <20230411173841.70491-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Linux CMCI storm mitigation is a big hammer that just disables the CMCI
interrupt globally and switches to polling all banks.

There are two problems with this:
1) It really is a big hammer. It means that errors reported in other
banks from different functional units are all subject to the same
polling delay before being processed.
2) Intel systems signal some uncorrected errors using CMCI (e.g.
memory controller patrol scrub on Icelake Xeon and newer). Delaying
processing these error reports negates some of the benefit of the patrol
scrubber providing early notice of errors before they are consumed and
cause a machine check.

This series throws away the old storm implementation and replaces it
with one that keeps track of the weather on each separate machine check
bank. When a storm is detected from a bank. On Intel the storm is
mitigated by setting a very high threshold for corrected errors to
signal CMCI. This threshold does not affect signaling CMCI for
uncorrected errors.

AMD's storm mitigation for threshold interrupts also relies on per CPU
per bank approach similar to Intel. But unlike CMCI storm handling it does
not set thresholds to reduce rate of interrupts on a storm. Rather it
turns off the interrupt on the current CPU and bank if there is a storm
and re-enables back the interrupts when the storm subsides.

It is okay to turn off threshold interrupts on AMD systems as other error
severities continue to be handled even if the threshold interrupts are
turned off. Uncorrected errors will generate a #MC and deferred errors
have a unique separate deferred error interrupt. The final patch adds
support for handling threshold interrupt storms on AMD systems.

Changes since last version:

1) Broke series into different steps. Previous series was based on
the sequence of development:
	a) Remove old storm code
	b) Add Intel specific storm mitigation
	c) Small refactor by to allow for support for multiple vendors
	d) Move all the generic parts from intel.c to core.c
	e) Add support for AMD
but this resulted in a lot of code being added in step 'b' and then
moved in step 'd'. Preserving this history in Linux GIT commits doesn't
seem overly useful. So I squashed parts 'b' through 'e' together and
then split them into a more rationale set:
	a) Same as before, removes old storm code.
	b) Add generic code for storm handling
	c) Add AMD vendor specific code
	d) Add Intel vendor specific code.

2) Boris suggested that all the storm tracking variables should be
bundled into a "storm_desc" structure, then declare a "storm" pointer
initialized using this_cpu_ptr() then replace the forest of this_cpu_*()
code with operation on "storm->field".

3) The Intel cmci_discover() function is far too large, with
many separate things going on in the inner loop. Per Boris suggestion
refactored with some helper functions.

4) Numerous other small cleanups, additional comments to explain
what is happening in areas where it wasn't obvious.

Smita Koralahalli (1):
  x86/mce: Handle AMD threshold interrupt storms

Tony Luck (3):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation
  x86/mce: Handle Intel threshold interrupt storms

 arch/x86/kernel/cpu/mce/internal.h |  43 +++-
 arch/x86/kernel/cpu/mce/amd.c      |  49 +++++
 arch/x86/kernel/cpu/mce/core.c     | 135 +++++++++---
 arch/x86/kernel/cpu/mce/intel.c    | 333 +++++++++++++----------------
 4 files changed, 337 insertions(+), 223 deletions(-)


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.40.1

