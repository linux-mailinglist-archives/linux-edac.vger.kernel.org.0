Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204166DC736
	for <lists+linux-edac@lfdr.de>; Mon, 10 Apr 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDJNP6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Apr 2023 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDJNP6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Apr 2023 09:15:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C64687;
        Mon, 10 Apr 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681132557; x=1712668557;
  h=from:to:cc:subject:date:message-id;
  bh=u5tzT5HAj5F9flU09hnwvyF0s5KiBKIQ5wca2zvBD2A=;
  b=AaonuUtr0+x8GdO4gR0inMnmBMr2K606ObjfT2s2MKT7iqKxHqDmszwY
   aE3ottGVBh0HZvxocr5Zs5oIRTQEe0ugMwU6xoaA0J6m7UM+T+RmMlSlj
   akPALe2rH9cZcNixZgrrOtcvsXS6PBTYecmJePe6ToZh33+enCHn61tye
   fpenTZk4USLVILQ74eON6CrKoPuWFGnUp5lwPvn4kbiDwmNNLox/liz/4
   T49F5qsWQapnaOW4B47B8XptkQrorMclti9dkdobkHbGsUcVPSL2SGwZV
   Gj7LZVhrm8jd2ZWHydZoQ8sju/Vyq2OxpFs4rjgRkxGuN2jYVLenu2KCF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="429635847"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="429635847"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 06:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="720813918"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="720813918"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 06:15:54 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/i10nm: Add Intel Sierra Forest server support
Date:   Mon, 10 Apr 2023 21:15:31 +0800
Message-Id: <20230410131531.11914-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Sierra Forest CPU model uses similar memory controller registers as
Granite Rapids server. Add Sierra Forest CPU model ID for EDAC support.

Tested-by: Li Zhang <li4.zhang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 0a4691792801..a897b6aff368 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -906,6 +906,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SIERRAFOREST_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
-- 
2.17.1

