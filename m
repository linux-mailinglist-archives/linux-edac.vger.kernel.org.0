Return-Path: <linux-edac+bounces-30-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05A7ED075
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C712C1F20F90
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4F3A8F7;
	Wed, 15 Nov 2023 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/9EAips"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCB1AB;
	Wed, 15 Nov 2023 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078101; x=1731614101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LW9FFyvXyEXGBuKqTjhKjTk25cxpgH4sSafAbcbh/OQ=;
  b=g/9EAipss7qLUoiaSbyqIIPQYORqQ7x4UQpqRMMRCOkCYLoAyCiPvRM6
   F28khbq5uhVjwNAd21ohNqbqLEErd6LV01KCRivlCC5BTCe1XhSt6R0/M
   wNo5mM+fZ6iS0+zwxX/qyWo9gyam8QFaX4+gVUj6hJrWBOoJD0Ed9sCOT
   /+PX1mklTVTU7mEp7LZ8548+lpgNq0nbrrMSVymNulnFIYdhl8AjfJBGo
   ksPOOaIDweQXEzJNUSnelQf8Ptfzy6kF8HeYZuxE5JffZzVTJ8adA5FJc
   nfC/vlH92K2stMsflwPMeuLhKD8/butOcyHBjCfoHeT427Z/3U6LoUPqP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477165984"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477165984"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768693278"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="768693278"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:57 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Smita.KoralahalliChannabasappa@amd.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 0/3] Handle corrected machine check interrupt storms
Date: Wed, 15 Nov 2023 11:54:47 -0800
Message-ID: <20231115195450.12963-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004183623.17067-1-tony.luck@intel.com>
References: <20231004183623.17067-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes since v9 (based on Boris reviews)

#1 Better commit comment on flow. Added detail that both timer poll
   and CMCI feed results of scanning each bank into the history
   calculation. Also added comment in code where mce_trac_storm()
   is called.
#2 Set a flag for banks that don't support CMCI so they can be
   excluded from history processing
#3 Skip history processing if CMCI globally disabled with boot
   argument mce=cmci_disable
#4 Move struct mca_storm_desc definition to internal.h (I had argued
   against the need for this, but the new "poll_mode" flag added in
   change #2 needs to be set in intel.c).
#5 Add #define NUM_HISTORY_BITS instead of hard-coded "64".
#6 Rebase to v6.7-rc1
  

Tony Luck (3):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation
  x86/mce: Handle Intel threshold interrupt storms

 arch/x86/kernel/cpu/mce/internal.h  |  66 +++++-
 arch/x86/kernel/cpu/mce/core.c      |  53 +++--
 arch/x86/kernel/cpu/mce/intel.c     | 304 ++++++++++++----------------
 arch/x86/kernel/cpu/mce/threshold.c | 115 +++++++++++
 4 files changed, 332 insertions(+), 206 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.41.0


