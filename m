Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308AE55CE6B
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jun 2022 15:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiF0Rgb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jun 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiF0Rga (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jun 2022 13:36:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78FFD11C;
        Mon, 27 Jun 2022 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656351389; x=1687887389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Em0msSweJpuFDsPd3dCpZXzqrTObd8eQjNQD6ivh7qM=;
  b=NtW5Mb0slweTn6Ii0E5gc+JYWyRO9iYH4E/N5phIomTga0qVEVSj84en
   cES2LViyKwZmDWFqkHlVcOWfTNec2YWrcvbrap3b/GMHNxzFgaTl9vuDu
   AxC7bKuafe07FjWX97iyr4ycAF0WPklc/Zw7Q2kIHt08R2h+Z5DKHwJ/B
   cGy0F3VfvIbfuF4f5XNnZCg83ij13q3J7dpPO31Y7ynoquPOTxwSYwhRC
   yJKltdsdogAQOCUJmM8CfdnVTv7nOq1CWAjWIUi9kFQoQh9VRAs4mamFW
   jTCv3jsolnXTvESBOKG269T+j+Mk3yCK+ES8dE0lPnruwETC9keOOH63e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270262440"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="270262440"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:36:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="594399442"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:36:11 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, yazen.ghannam@amd.com, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/5] Handle corrected machine check interrupt storms
Date:   Mon, 27 Jun 2022 10:36:00 -0700
Message-Id: <20220627173605.514504-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <YrFSSZqjtWlm9rUr@agluck-desk3.sc.intel.com>
References: <YrFSSZqjtWlm9rUr@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Extend the logic of handling Intel's corrected machine check interrupt
storms to AMD's threshold interrupts.

First two patches are from Tony which cleans up the existing storm
handling for Intel and proposes per CPU per bank storm handling.

Third and fourth patches do some cleanup and refactoring on the CMCI
storm handling in order to extend similar workaround for AMD's threshold
interrupt storms. These two patches could be merged into Tony's second
patch of CMCI storm mitigation.

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

Changes since v1:

1) Fix shift computation when keeping track of bank history. Shift
should be "1" when a storm is in progress (because polling once per
second). When a storm is not in progress shift should be based on
number of seconds since the bank was last checked.

2) Changed Smita's code in part 0003 to avoid use of a function pointer
(since the kernel is avoiding indirect branch points that might be
trainable for various Spectre-like issues).

Smita Koralahalli (2):
  x86/mce: Introduce mce_handle_storm() to deal with begin/end of storms
  x86/mce: Handle AMD threshold interrupt storms
  x86/mce: Move storm handling to core.

Tony Luck (3):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation

 arch/x86/kernel/cpu/mce/amd.c      |  49 ++++++++
 arch/x86/kernel/cpu/mce/core.c     | 139 +++++++++++++++++-----
 arch/x86/kernel/cpu/mce/intel.c    | 179 +++++++----------------------
 arch/x86/kernel/cpu/mce/internal.h |  33 ++++--
 4 files changed, 230 insertions(+), 170 deletions(-)

-- 
2.35.3

