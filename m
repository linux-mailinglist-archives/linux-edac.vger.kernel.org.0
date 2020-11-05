Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63E2A86BA
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 20:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgKETFq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 14:05:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:24077 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbgKETFp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Nov 2020 14:05:45 -0500
IronPort-SDR: nPFxp7ZCCPUhLRquNXeob+hG6RC1bKOaxfaBZpgLeV29vyUUZq3PdQ8KPqB4VBGn65YWhZR1lO
 vHSPl12tM3cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="169584672"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="169584672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 11:05:23 -0800
IronPort-SDR: VPldczNnceXFAG2hrqfcXWjvtnG2ec/PYXgaMDXJLLg0PeP4+3cLaLOsgwkkwqvccImhXx0xk2
 D9kutLn7XbQw==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="539529293"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 11:05:20 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add entry for Intel IGEN6 EDAC driver
Date:   Thu,  5 Nov 2020 11:05:08 -0800
Message-Id: <20201105190509.19719-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201105190509.19719-1-tony.luck@intel.com>
References: <20201105074807.3697-1-qiuxu.zhuo@intel.com>
 <20201105190509.19719-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

New driver for "client" system on chip CPUs.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..86eb55697c8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6353,6 +6353,13 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/ie31200_edac.c
 
+EDAC-IGEN6
+M:	Tony Luck <tony.luck@intel.com>
+R:	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/igen6_edac.c
+
 EDAC-MPC85XX
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
 L:	linux-edac@vger.kernel.org
-- 
2.21.1

