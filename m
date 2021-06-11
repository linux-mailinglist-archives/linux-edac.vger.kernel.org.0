Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E343A4753
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFKRDt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Jun 2021 13:03:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:56290 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFKRDs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:48 -0400
IronPort-SDR: 0UbfJxnrTTeRiY4SvMIaCPwhLcacG9uksr1MtZdKxk/erIjLQUsKtpMOBbDvvSpLZ4z0oN9Tw6
 63j2iLaKPJsg==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="266715348"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266715348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:36 -0700
IronPort-SDR: uV9DVA4WoFFn5XpDU4LgPXD++za1rFPU3Zd9a/2lS5hS2tVu+laNrnSRl9J6VSydl384I56TTt
 w2Z4aNEV9Hpg==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483329856"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:36 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Aristeu Rozanski <aris@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Bundle of Intel EDAC patches
Date:   Fri, 11 Jun 2021 10:01:17 -0700
Message-Id: <20210611170123.1057025-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel EDAC patches are like trains/buses ... nothing for a long time
and then six arrive together.

Patch 1 & 2:	Mix logging for 2-level memory configurations (to report
		the error in either the "near" (cache) or "far" memory
		as appropriate.

Patch 3:	On package memory is coming (in the future)

Patch 4, 5, 6:	Add support to igen6_edac driver for three extra CPU
		models.

Qiuxu Zhuo (6):
  EDAC/skx_common: Add new ADXL components for 2-level memory
  EDAC/i10nm: Add detection of memory levels for ICX/SPR servers
  EDAC/i10nm: Add support for high bandwidth memory
  EDAC/igen6: Add Intel ICL-NNPI SoC support
  EDAC/igen6: Add Intel Tiger Lake SoC support
  EDAC/igen6: Add Intel Alder Lake SoC support

 drivers/edac/i10nm_base.c | 171 +++++++++++++++--
 drivers/edac/igen6_edac.c | 374 +++++++++++++++++++++++++++++++++++---
 drivers/edac/skx_common.c |  82 +++++++--
 drivers/edac/skx_common.h |  34 +++-
 4 files changed, 606 insertions(+), 55 deletions(-)


base-commit: 614124bea77e452aa6df7a8714e8bc820b489922
-- 
2.29.2

