Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC7668A22
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jan 2023 04:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjAMDa3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Jan 2023 22:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjAMD2a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Jan 2023 22:28:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C61A21A;
        Thu, 12 Jan 2023 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673580509; x=1705116509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WFGpcb2BGEaC7cyAn+o6T1CTx9FgSPGQkWdb0KmwAws=;
  b=VP0C4JJheK72BsrgrrWe0IKxTYJBvfijJIxLN8RWMDNwJwWy4RHx9aL9
   6AI8wrwWMGCQhfPoRIJdEuoEV68BjMUnFSl8ALWijpYymJswTxHLwdVLA
   qlss7PiiVgIGo9xJ1nVuXw+aQfQnhwbPQdVlen/ZFCmBx8ySNDsd2Pi7b
   Jmym/MEpDp75nKjRcL3x3HtazJc60O9AFy1XlY57AdfOVlpipWpBGJ8/O
   4esyaniSNnXq42Tl/w3CiKG9auZQwRiLlT+x0A0aGPozGAZgelOCnYK4Y
   SKpYEXN9BWjIWhFLauwgNBYALb2fuxPWfGZdFZSMe2Yz63dHiqZ4wSKuE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410138859"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="410138859"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651386230"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="651386230"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:26 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] EDAC/i10nm: Add Intel Emerald Rapids server support
Date:   Fri, 13 Jan 2023 11:28:00 +0800
Message-Id: <20230113032802.41752-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
References: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Emerald Rapids CPU model uses similar memory controller registers
as Sapphire Rapids server. Add Emerald Rapids CPU model number ID for
EDAC support.

Tested-by: Li Zhang <li4.zhang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 65aeea53e2df..e11726f7fe36 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -637,6 +637,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_X,		X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_D,		X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
-- 
2.17.1

