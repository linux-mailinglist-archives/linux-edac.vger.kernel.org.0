Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86EB2829
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2019 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfIMWNq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 18:13:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:24050 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390143AbfIMWNq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 18:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:13:45 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="337033392"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:13:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 0/2] EDAC, skx: Provide more machine specific location detail
Date:   Fri, 13 Sep 2019 15:13:42 -0700
Message-Id: <20190913221344.13055-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

First patch refactors code so that second can work on systems
with and without the ACPI ADXL address translation code. Perhaps
has some value on its own as the code is, IMHO, a little cleaner.

Second is in RFC state. Im looking for input on whether to just print
the extra information to the console log (as the patch does now) or
whether to tag it onto the long string that we push though the EDAC
reporting path.

Tony Luck (2):
  EDAC, skx_common: Refactor so that we initialize "dev" in result of
    adxl decode.
  EDAC, skx: Retrieve and print retry_rd_err_log registers

 drivers/edac/skx_base.c   | 38 +++++++++++++++++++++++++--
 drivers/edac/skx_common.c | 55 +++++++++++++++++++++------------------
 drivers/edac/skx_common.h |  4 ++-
 3 files changed, 68 insertions(+), 29 deletions(-)

-- 
2.20.1

