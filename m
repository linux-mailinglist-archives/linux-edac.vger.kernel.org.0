Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1772BFEAA
	for <lists+linux-edac@lfdr.de>; Mon, 23 Nov 2020 04:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKWDTD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Nov 2020 22:19:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:31117 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbgKWDTD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 22 Nov 2020 22:19:03 -0500
IronPort-SDR: kg7asXXsLhgCG+cuwZrufOP1mdS5AUJM+1VqfPjycRcsHCGY8ZEL/5xgtD1oteRsQPz32q+vwt
 r76xUsM0eiyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="158737538"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="158737538"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 19:19:02 -0800
IronPort-SDR: H4KwNxHQ4teJDChuX0cG4rz6msgqOpfVG+eiOWMjLidMKEogf5wX0XAAwOoC5PJ+IduJ7bVUML
 40qOkywKjaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="342687886"
Received: from lkp-server01.sh.intel.com (HELO ce8054c7261d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2020 19:19:00 -0800
Received: from kbuild by ce8054c7261d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kh2NX-0000PQ-Fh; Mon, 23 Nov 2020 03:18:59 +0000
Date:   Mon, 23 Nov 2020 11:18:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] EDAC/igen6: ecclog_llist can be static
Message-ID: <20201123031850.GA20416@aef56166e5fc>
References: <202011231120.nLkm6K9s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011231120.nLkm6K9s-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


Fixes: 62a8cb0cbbfe ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 igen6_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index b8a6d692c1e4f9..71d29297221054 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -164,7 +164,7 @@ struct ecclog_node {
  * to EDAC core in a worker.
  */
 #define ECCLOG_POOL_SIZE	PAGE_SIZE
-LLIST_HEAD(ecclog_llist);
+static LLIST_HEAD(ecclog_llist);
 static struct gen_pool *ecclog_pool;
 static char ecclog_buf[ECCLOG_POOL_SIZE];
 static struct irq_work ecclog_irq_work;
