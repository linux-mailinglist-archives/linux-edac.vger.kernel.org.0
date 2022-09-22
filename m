Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C15E6C10
	for <lists+linux-edac@lfdr.de>; Thu, 22 Sep 2022 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiIVTv7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Sep 2022 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiIVTvw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Sep 2022 15:51:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040310C7AB;
        Thu, 22 Sep 2022 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663876309; x=1695412309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O1l2uVNEbdwj40S1UTdkiiCL6HpII17U25snIiNO9Ho=;
  b=DdUpUNcM6+UYg/jdVTkOqLQb5rtC42qM0G20dJEkpcyMEGt++J7eL3s3
   SPz4Zxzy6xGmHLp10425iT5l3pH/fV/PPUuBk+kNld1fGgn7oq2RKPBRI
   Dp3SHieyIR7jO9ABuwQ/6fox0Aa8J1XlF4VIU+FMZHleiCUGFeGRoTtNM
   lnh/SSo3UU5+IP/dktu+XuCszhWAObyTNWwNot+QAvfeC5+5jEh31eog5
   uJZvhqlD5TnX7XFUr9jPIcsGEkTnL7pipOX/UK7Y+Gplk9x+nGBjSS+Tw
   ZwwfGqcqkWgY6Z+WhZe7NHap+HT2k0XmpLmDq2vdpSiX+0qZcnpTcE5jf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280783421"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280783421"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:51:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622246715"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:51:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/2] x86/mce: Use severity table to handle uncorrected errors in kernel
Date:   Thu, 22 Sep 2022 12:51:35 -0700
Message-Id: <20220922195136.54575-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922195136.54575-1-tony.luck@intel.com>
References: <20220922195136.54575-1-tony.luck@intel.com>
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

mce_severity_intel() has a special case to promote UC and AR errors
in kernel context to PANIC severity.

The "AR" case is already handled with separate entries in the severity
table for all instruction fetch errors, and those data fetch errors that
are not in a recoverable area of the kernel (i.e. have an extable fixup
entry).

Add an entry to the severity table for UC errors in kernel context that
reports severity = PANIC. Delete the special case code from
mce_severity_intel().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 00483d1c27e4..c4477162c07d 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -202,6 +202,11 @@ static struct severity {
 		PANIC, "Overflowed uncorrected",
 		BITSET(MCI_STATUS_OVER|MCI_STATUS_UC)
 		),
+	MCESEV(
+		PANIC, "Uncorrected in kernel",
+		BITSET(MCI_STATUS_UC),
+		KERNEL
+		),
 	MCESEV(
 		UC, "Uncorrected",
 		BITSET(MCI_STATUS_UC)
@@ -391,9 +396,6 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
 			*msg = s->msg;
 		s->covered = 1;
 
-		if (s->sev >= MCE_UC_SEVERITY && ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
-
 		return s->sev;
 	}
 }
-- 
2.37.3

