Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31C316F57E
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 03:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBZCLb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 21:11:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:30408 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729998AbgBZCLa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 21:11:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 18:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="436469854"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2020 18:11:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j6mAa-000FgU-Jt; Wed, 26 Feb 2020 10:11:28 +0800
Date:   Wed, 26 Feb 2020 10:11:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     kbuild-all@lists.01.org, linux-edac@vger.kernel.org
Subject: [RFC PATCH] EDAC/Cadence: data_synd[] can be static
Message-ID: <20200226021101.GA16779@e50d7db646c3>
References: <20200225093856.7328-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225093856.7328-2-dkangude@cadence.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


Fixes: 201447a5db9b ("EDAC/Cadence:Add EDAC driver for cadence memory controller")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cadence_edac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/cadence_edac.c b/drivers/edac/cadence_edac.c
index 3887db5665eee..17aa656a740ee 100644
--- a/drivers/edac/cadence_edac.c
+++ b/drivers/edac/cadence_edac.c
@@ -121,7 +121,7 @@
 /* Syndrome values */
 #define ECC_DOUBLE_MULTI_ERR_SYND	0x03
 
-char data_synd[] = {
+static char data_synd[] = {
 			0xf4, 0xf1, 0xec, 0xea, 0xe9, 0xe6, 0xe5, 0xe3,
 			0xdc, 0xda, 0xd9, 0xd6, 0xd5, 0xd3, 0xce, 0xcb,
 			0xb5, 0xb0, 0xad, 0xab, 0xa8, 0xa7, 0xa4, 0xa2,
@@ -132,7 +132,7 @@ char data_synd[] = {
 			0x1c, 0x1a, 0x19, 0x16, 0x15, 0x13, 0x0e, 0x0b
 		  };
 
-char check_synd[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
+static char check_synd[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
 
 /**
  * struct cdns_platform_data -  cadence platform data structure.
