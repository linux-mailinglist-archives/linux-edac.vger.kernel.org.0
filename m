Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3E3BDDBD
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jul 2021 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhGFTJI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jul 2021 15:09:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:6713 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhGFTJH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 6 Jul 2021 15:09:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206166874"
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="206166874"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 12:06:27 -0700
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="427687568"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 12:06:26 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] More machine check recovery fixes
Date:   Tue,  6 Jul 2021 12:06:17 -0700
Message-Id: <20210706190620.1290391-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix a couple of issues in machine check handling

1) A repeated machine check inside the kernel without calling the task
   work function between machine checks it will go into an infinite
   loop
2) Machine checks in kernel functions copying data from user addresses
   send SIGBUS to the user as if the application had consumed the
   poison. But this is wrong. The user should see either an -EFAULT
   error return or a reduced byte count (in the case of write(2)).

Tony Luck (3):
  x86/mce: Change to not send SIGBUS error during copy from user
  x86/mce: Avoid infinite loop for copy from user recovery
  x86/mce: Drop copyin special case for #MC

 arch/x86/kernel/cpu/mce/core.c | 62 ++++++++++++++++++++++++----------
 arch/x86/lib/copy_user_64.S    | 13 -------
 include/linux/sched.h          |  1 +
 3 files changed, 45 insertions(+), 31 deletions(-)

-- 
2.29.2

