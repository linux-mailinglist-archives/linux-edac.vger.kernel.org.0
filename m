Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE594DA226
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 19:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbiCOSQa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiCOSQ3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 14:16:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C710FD9;
        Tue, 15 Mar 2022 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647368117; x=1678904117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBl7++E0lyz16jxeiMNZ6a6aEo5QRd5rFAMudPSZAW0=;
  b=GjVi5pYN0/794iHUoba777cmlJ+Z4B0U43pAe654Zfq6hUpGE4+0UM37
   F0OunZLN1TAi/qIu9Q9bKsvl3jCBlMh+ByyQlKwiZMeLcYLklzJzbr8YY
   7vkT/23JWOgINvZZiGYidWBvJ5lvIt0K66KXTa15btu9xYoR9tha+4eHh
   6kzyVVALgGo0bTlwq7HlP7D6rdEV85vkmkaH/qIYdfHucPpgY/2kIaFht
   tnYgGYCk3FFYUF+Je3zNYESHJE+RKSiEtq2+YCVegfeLVGTFKWRoWdBl0
   iVOF2n8MopvisszQgO6ECJxSl0nLt88hHITRJhuUKr+0ePphUMCN1VTVZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256583264"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256583264"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 11:15:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="512713792"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 11:15:16 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/2] New CMCI storm mitigation for Intel CPUs
Date:   Tue, 15 Mar 2022 11:15:07 -0700
Message-Id: <20220315181509.351704-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
References: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Two-part motivation:

1) Disabling CMCI globally is an overly big hammer

2) Intel signals some UNCORRECTED errors using CMCI (yes, turns
out that was a poorly chosen name given the later evolution of
the architecture). Since we don't want to miss those, the proposed
storm code just bumps the threshold to (almost) maximum to mitigate,
but not eliminate the storm. Note that the threshold only applies
to corrected errors.

Patch 1 deletes the parts of the old storm code that are no
longer needed.

Patch 2 adds the new per-bank mitigation.

Smita: Unless Boris finds a some more stuff for me to fix, this
version will be a better starting point to merge with your changes.

Changes since v1 (based on feedback from Boris)

- Spelling fixes in commit message
- Many more comments explaining what is going on
- Change name of function that does tracking
- Change names for #defines for storm BEGIN/END
- #define for high threshold in decimal, not hex

Tony Luck (2):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation

 arch/x86/kernel/cpu/mce/core.c     |  46 +++---
 arch/x86/kernel/cpu/mce/intel.c    | 241 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h |  10 +-
 3 files changed, 141 insertions(+), 156 deletions(-)


base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
2.35.1

