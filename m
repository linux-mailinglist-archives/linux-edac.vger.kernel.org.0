Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DA6D530A
	for <lists+linux-edac@lfdr.de>; Mon,  3 Apr 2023 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDCVHe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjDCVHd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 17:07:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627C3AAC;
        Mon,  3 Apr 2023 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680556049; x=1712092049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bULC+4W24U6LNIp+7cxjOt/4gnwVchddiVVfkEBsyfQ=;
  b=diOjZ/mRe0Wj6e3cLg9WsDOTa9oRlQwAKbz9T7ClmJWEUG/X2Dgh1CA+
   4uv4iv/gckywy+4R1Nx6qaepZVo+1vhoMjFmfbKmx1YsyS5DiP1THTSFM
   SNdMR7t63FbDezFWFqvi2g324Z2hh+qx2vk7VPoSAVrUVzcMt4MiLlr2w
   OuwoKPAwM8YoG/liNpNDWgVy8TMemJuJXt/px6sdIxqYNYZbG7Kq0ygFr
   fG8YP0Yk10Yng9WMexfLpkbflLjQXyAFQ/3mpthudUJkhUJ5fV8/NuV/O
   UdDlHqkLBX9oGE4oAFaw+Mt/9O5nM0KjauFdWk2Byp/OObLC5EIOXPVoQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330590839"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="330590839"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775354450"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="775354450"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:07:25 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 0/5] Handle corrected machine check interrupt storms
Date:   Mon,  3 Apr 2023 14:07:11 -0700
Message-Id: <20230403210716.347773-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
References: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Yazen:
	Reported inverted tests in two places that cancelled each other
	out so the code worked. But the logic was backwards.
	Provided Tested-by and Reviewed-by tags


Smita Koralahalli (3):
  x86/mce: Introduce mce_handle_storm() to deal with begin/end of storms
  x86/mce: Move storm handling to core.
  x86/mce: Handle AMD threshold interrupt storms

Tony Luck (2):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation

 arch/x86/kernel/cpu/mce/internal.h |  33 ++++--
 arch/x86/kernel/cpu/mce/amd.c      |  49 ++++++++
 arch/x86/kernel/cpu/mce/core.c     | 139 +++++++++++++++++-----
 arch/x86/kernel/cpu/mce/intel.c    | 179 +++++++----------------------
 4 files changed, 230 insertions(+), 170 deletions(-)


base-commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
-- 
2.39.2

