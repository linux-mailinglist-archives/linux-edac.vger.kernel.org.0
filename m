Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B317E3B7ABF
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 01:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhF2XpZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 29 Jun 2021 19:45:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:18675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235295AbhF2XpY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 29 Jun 2021 19:45:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208208662"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="208208662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 16:42:56 -0700
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="625815383"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 16:42:56 -0700
Date:   Tue, 29 Jun 2021 16:42:55 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     torvalds@agluck-desk2.amr.corp.intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Bixuan Cui <cuibixuan@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ras/edac changes for v5.14
Message-ID: <20210629234255.GA1239879@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.14

for you to fetch changes up to 0a9ece9ba154dd6205709108180952c55e630833:

  EDAC/igen6: fix core dependency (2021-06-20 14:04:48 -0700)

----------------------------------------------------------------
Various fixes and support for new CPUS
- Clean up error messages from thunderx_edac
- Add MODULE_DEVICE_TABLE to ti_edac so it will autoload
- Use %pR to print resources in aspeed_edac
- Add Yazen Ghannam as MAINTAINER for AMD edac drivers
- Fix Ice Lake and Sapphire Rapids drivers to report correct
  "near" or "far" device for errors in 2LM configurations
- Add support of on package high bandwidth memory in Sapphire Rapids
- New CPU support for three CPUs supporting in-band ECC (IOT SKUs for
  ICL-NNPI, Tiger Lake and Alder Lake)
- Don't even try to load Intel EDAC drivers when running as a guest
- Fix Kconfig dependency on X86_MCE_INTEL for EDAC_IGEN6

----------------------------------------------------------------
Arnd Bergmann (1):
      EDAC/aspeed: Use proper format string for printing resource

Bixuan Cui (1):
      EDAC/ti: Add missing MODULE_DEVICE_TABLE

Christophe JAILLET (1):
      EDAC/thunderx: Remove irrelevant variable from error messages

Qiuxu Zhuo (6):
      EDAC/skx_common: Add new ADXL components for 2-level memory
      EDAC/i10nm: Add detection of memory levels for ICX/SPR servers
      EDAC/i10nm: Add support for high bandwidth memory
      EDAC/igen6: Add Intel ICL-NNPI SoC support
      EDAC/igen6: Add Intel Tiger Lake SoC support
      EDAC/igen6: Add Intel Alder Lake SoC support

Randy Dunlap (1):
      EDAC/igen6: fix core dependency

Tony Luck (1):
      EDAC/Intel: Do not load EDAC driver when running as a guest

Yazen Ghannam (1):
      MAINTAINERS: Make Yazen Ghannam maintainer for EDAC-AMD64

 MAINTAINERS                  |   5 +-
 drivers/edac/Kconfig         |   3 +-
 drivers/edac/aspeed_edac.c   |   4 +-
 drivers/edac/i10nm_base.c    | 174 ++++++++++++++++++--
 drivers/edac/igen6_edac.c    | 374 ++++++++++++++++++++++++++++++++++++++++---
 drivers/edac/pnd2_edac.c     |   3 +
 drivers/edac/sb_edac.c       |   3 +
 drivers/edac/skx_base.c      |   3 +
 drivers/edac/skx_common.c    |  82 ++++++++--
 drivers/edac/skx_common.h    |  34 +++-
 drivers/edac/thunderx_edac.c |   4 +-
 drivers/edac/ti_edac.c       |   1 +
 12 files changed, 628 insertions(+), 62 deletions(-)
