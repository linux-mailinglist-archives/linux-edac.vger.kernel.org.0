Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3F1B7E6E
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgDXS5k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 14:57:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:21121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgDXS5k (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Apr 2020 14:57:40 -0400
IronPort-SDR: eMjt2dYWHIfRKL+VR1iLLBg6rtorTmookw8ZJoZr9/0AUS6E+VR+/58NZbrNOy/wiKPZIHkOwB
 6DKf6U9CMVVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 11:57:39 -0700
IronPort-SDR: 7lp/f9HMUzqv+8fiU5aduDJoaUKXB5gZxLKkW14oUdVV/+ctvEvCwG993u78+/lRGTloMiS9DW
 ZJzcs0kimsdA==
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="430893777"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 11:57:39 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 0/2] Fix i10nm_edac driver load failure
Date:   Fri, 24 Apr 2020 11:57:36 -0700
Message-Id: <20200424185738.7985-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The root cause is that one of the configuration registers
needed by EDAC changed offset between pre-production and
final stepping of some CPU models. Ordinarily we might fix
this by just making the driver only support the production
stepping. But there are still significant numbers of the
pre-production parts in use (both within Intel and with
customers), so we need to adapt to use the right offset
for the register depending on both model and stepping.

Patch 1: Adds a configuration structure to make this, and future
changes, possible.
Patch 2: Adjusts the register offset

Qiuxu Zhuo (2):
  EDAC, {skx,i10nm}: Make some configurations CPU model specific
  EDAC, i10nm: Fix i10nm_edac loading failure on some servers

 drivers/edac/i10nm_base.c | 28 ++++++++++++++++++++++++----
 drivers/edac/skx_base.c   | 12 ++++++++++--
 drivers/edac/skx_common.c | 11 +++++------
 drivers/edac/skx_common.h | 11 +++++++++--
 4 files changed, 48 insertions(+), 14 deletions(-)

-- 
2.21.1

