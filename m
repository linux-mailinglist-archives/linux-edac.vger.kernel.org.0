Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0428239CB6
	for <lists+linux-edac@lfdr.de>; Mon,  3 Aug 2020 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHBWDd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 2 Aug 2020 18:03:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:51631 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgHBWDc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 2 Aug 2020 18:03:32 -0400
IronPort-SDR: MMoc+Es0RM/eF/itp/5uKzIILdE//1eUT7vqSoZnX9M+lWXgNfdK+S3/d9Itrkc2gKwrwTr52s
 /oKFS7b1PPEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="213556387"
X-IronPort-AV: E=Sophos;i="5.75,427,1589266800"; 
   d="scan'208";a="213556387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 15:03:31 -0700
IronPort-SDR: zHmF67G0C6t+RqSNbsQR2JuTjknAm0KNygE22EuGYJnm9QRA3M6yzHaPWuPm6v/Nzw1tD4BwHO
 KyBzMIkPsTGA==
X-IronPort-AV: E=Sophos;i="5.75,427,1589266800"; 
   d="scan'208";a="466271087"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 15:03:31 -0700
Date:   Sun, 2 Aug 2020 15:03:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] EDAC for 5.9
Message-ID: <20200802220330.GA24423@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

Boris is on vacation and aske me to send you the pull request for EDAC
changes that are queued for v5.9

-Tony

---

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.9

for you to fetch changes up to 0f959e19fadf00638b686fdeb70e24dfcc7bbcac:

  Merge branch 'edac-ghes' into edac-for-next (2020-06-22 15:28:01 +0200)

----------------------------------------------------------------
17ed808ad243 ("EDAC: Fix reference count leaks")
e370f886fefc ("EDAC: Remove edac_get_dimm_by_index()")
b9cae27728d1 ("EDAC/ghes: Scan the system once on driver init")
b001694d60fe ("EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to ghes_pvt")
cb51a371d08e ("EDAC/ghes: Setup DIMM label from DMI and use it in error reports")
8807e1559749 ("EDAC, {skx,i10nm}: Use CPU stepping macro to pass configurations")
e9ff6636d3f9 ("EDAC/mc: Call edac_inc_ue_error() before panic")
30bf38e4341b ("EDAC, pnd2: Set MCE_PRIO_EDAC priority for pnd2_mce_dec notifier")

----------------------------------------------------------------
Borislav Petkov (3):
      EDAC/ghes: Scan the system once on driver init
      EDAC: Remove edac_get_dimm_by_index()
      Merge branch 'edac-ghes' into edac-for-next

Qiushi Wu (1):
      EDAC: Fix reference count leaks

Qiuxu Zhuo (1):
      EDAC, {skx,i10nm}: Use CPU stepping macro to pass configurations

Robert Richter (2):
      EDAC/ghes: Setup DIMM label from DMI and use it in error reports
      EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to ghes_pvt

Zhenzhong Duan (2):
      EDAC, pnd2: Set MCE_PRIO_EDAC priority for pnd2_mce_dec notifier
      EDAC/mc: Call edac_inc_ue_error() before panic

 drivers/edac/edac_device_sysfs.c |   1 +
 drivers/edac/edac_mc.c           |   4 +-
 drivers/edac/edac_pci_sysfs.c    |   2 +-
 drivers/edac/ghes_edac.c         | 323 +++++++++++++++++++++++----------------
 drivers/edac/i10nm_base.c        |  12 +-
 drivers/edac/pnd2_edac.c         |   1 +
 drivers/edac/skx_base.c          |   2 +-
 include/linux/edac.h             |  29 +---
 8 files changed, 211 insertions(+), 163 deletions(-)
