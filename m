Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF4668A17
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jan 2023 04:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAMD2Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Jan 2023 22:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAMD2W (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Jan 2023 22:28:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B7DE0BE;
        Thu, 12 Jan 2023 19:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673580501; x=1705116501;
  h=from:to:cc:subject:date:message-id;
  bh=cQ6DZ0tC0VuTMlzeUTqy9p1kl+bN0h8h3IREUYbQhRA=;
  b=TUvy9ixTD2O74cJs6Q63aLa/CIn4sgMH4NHkePpGvX2l944ebpY9SUZl
   cqLgimAbm6kEMeYrrVEchpZhL4qxkjU4GdvXMVbJSnazytOX8SyULyv/6
   dPSHE26u3ZYSdAq3tIWahGaZh6uVG2rd53qsEcYJxj08+dJM/dhQqU90o
   JJKwrt+Lc8ZYWTYxJf4s2gJM28rOHKB3SR2lSEV+kIdXq8IsXDxQGswNz
   1WLMCwixGG4eW7+Ry4UP8nnn+e4pRTjDVCqW+E/2NpuI+l8RNGSte1sL0
   qMd4BDYPM22jNwPhStLFi5oqQSRlh0lMpkCJXTwO4pPAeC+NZ7ULyT2qi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410138838"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="410138838"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651386193"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="651386193"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:18 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] EDAC/Intel: Intel EDAC driver updates for "near" memory and new CPUs
Date:   Fri, 13 Jan 2023 11:27:57 +0800
Message-Id: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Patch 1: Enable EDAC support for "near" memory (e.g., HBM used as
         cache for DDR) for Intel servers.

Patch 2: Clean up some unreachable code after applying Patch 1.

Patch 3: Add EDAC support for Intel Emerald Rapids server.

Patch 4: Make common configurations used in i10nm_edac CPU model specific.
         Prepare for Patch 5.

Patch 5: Add EDAC support for Intel Granite Rapids server.

Qiuxu Zhuo (5):
  EDAC/skx_common: Enable EDAC support for the "near" memory
  EDAC/skx_common: Delete duplicated and unreachable code
  EDAC/i10nm: Add Intel Emerald Rapids server support
  EDAC/i10nm: Make more configurations CPU model specific
  EDAC/i10nm: Add Intel Granite Rapids server support

 drivers/edac/i10nm_base.c | 357 ++++++++++++++++++++++++++++++++------
 drivers/edac/skx_common.c |  76 ++++----
 drivers/edac/skx_common.h |  61 ++++++-
 3 files changed, 390 insertions(+), 104 deletions(-)


base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
-- 
2.17.1

