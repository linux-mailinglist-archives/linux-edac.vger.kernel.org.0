Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BCD6BEF7A
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 18:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCQRUz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQRUy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 13:20:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5AAE1FCC;
        Fri, 17 Mar 2023 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679073653; x=1710609653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=me1YBwks8BolRJDJwSw1YQ5GKXju7AeGeCEcg1Uk3OA=;
  b=GgqUZOtlOymMs09IZqx3llL2nEJ1cda7hT1BEMGQzRTJJ0G2pr+ZXINH
   4LGOVgooWo82VOrMYT5La4zlh4ZyQZcNK1kpkisJ1vpZPmyInZYGeEO5O
   dzOGhdU1SZ8y/+WlsFSKy+I5kZmaW9yJ3N0qn4rykUYPDNrDCWjniQYrV
   06r3rM2XdB0qTlasrnqRCleTVbUGYXpz7PdVTOpdQvEoZ3GgAc0ONlSMb
   jeK22qc5GIvbrz7cevciSPqL9Inze8/G31150IThi6chBSY+2jviFOeiT
   gtMzUo8cWVxSMO7XiJOAnwP0N05TLi9LPpT0Ns6jp1Pas4wROv3cxF5bA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="339858212"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339858212"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804166595"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804166595"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:20:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 0/5] Handle corrected machine check interrupt storms
Date:   Fri, 17 Mar 2023 10:20:37 -0700
Message-Id: <20230317172042.117201-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZBR+GMH0olGoDMGs@yaz-fattaah>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is the same as v2 (posted June 2022) rebased to v6.1-rc4. I meant to post
when I did that, but apparently got distracted.

Pathces 1-4 still apply cleanly to upstream but there's a trivial fixup
needed to arch/x86/kernel/cpu/mce/internal.h to make patch 5 apply
to v6.3-rc2.

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


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.39.2

