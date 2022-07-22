Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31557EA40
	for <lists+linux-edac@lfdr.de>; Sat, 23 Jul 2022 01:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiGVXdw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jul 2022 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiGVXdv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Jul 2022 19:33:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDFC88CE3;
        Fri, 22 Jul 2022 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658532831; x=1690068831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yw+5sbrqD00Mkg0zJD1e2qgbq/qqFtjTGEKESiXhYpI=;
  b=CA5iLvfYoLdjE/RFU1G7+Em0+2T7pQpTl6pIuio5bCGaTv1Vua3Dj2Ix
   KtfgOvHkBo3gVwcBIrq/JIhzwMtjeKk/NJpzJJmDC8hHbR3XszQbwHqrc
   XBmz4PSRXEmRuYMl3gfX/RlXt/7yocPUsjZT2GLmZjQ48A6cbri+z7DHZ
   sx/n41YQIHGdnKCYXFzbYszrc81v106hYFZXDrbP6tHSXvogmYG6Ac0Ss
   8bPyI7Urdpmc78qV3mzKS+KwCxivgitX4SOiPzOMvlb0yN90ptMewBGIr
   GjxWsjTQYT8H5EWulsB5JR5x0rOTtImhT7j4Gb87zgosRZwEIeZOf2qM1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="286185331"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="286185331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="574346058"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:47 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 0/4] EDAC/intel: Some Intel EDAC driver updates
Date:   Fri, 22 Jul 2022 16:33:34 -0700
Message-Id: <20220722233338.341567-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Patch 1&2 add printing of retry_rd_log registers for the HBM (high
bandwidth memory) on Sapphire Rapids CPUs.

Patch 3 prints from an extra set of retry_rd_log registers on Sapphire
Rapids.

Patch 4 adds sub-DIMM decode (bank, row, column) for Broadwell CPUs

When community review is complete, plan is to add to RAS tree after
v5.20-rc1 comes out for the v5.21 (v6.0?) merge window.

Qiuxu Zhuo (3):
  EDAC/skx_common: Add ChipSelect ADXL component
  EDAC/i10nm: Retrieve and print retry_rd_err_log registers for HBM
  EDAC/i10nm: Print an extra register set of retry_rd_err_log

Youquan Song (1):
  x86/sb_edac: Add row column translation for Broadwell

 drivers/edac/skx_common.h |  10 +++
 drivers/edac/i10nm_base.c | 153 ++++++++++++++++++++++++++++++++------
 drivers/edac/sb_edac.c    | 148 +++++++++++++++++++++++++++++++++---
 drivers/edac/skx_common.c |   5 ++
 4 files changed, 284 insertions(+), 32 deletions(-)


base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.35.3

