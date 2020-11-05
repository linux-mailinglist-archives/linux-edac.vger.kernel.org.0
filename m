Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D262A7838
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKEHrl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 02:47:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:34320 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKEHrl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Nov 2020 02:47:41 -0500
IronPort-SDR: 2YETVFw5jMfNyjgujHMyA8Yc6xMK6a5dNrJYxZUJRwgeW7lzJTas7uAaZHf8RaDmEsjc9hTM4e
 BOwdXO7wMCpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="168559563"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="168559563"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:47:40 -0800
IronPort-SDR: egypu5fOQmMUueEbfMgFuhfoewcqzPNECww9AqWvwg9UvRZPslheDG1SJ2/+s0u0TJARZ/1xPS
 UdgpaP/EDYxA==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="306443448"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.133])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:47:38 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     bp@alien8.de
Cc:     tony.luck@intel.com, aris@redhat.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v1 0/3] Add EDAC driver for Intel client SoCs using In-Band ECC
Date:   Thu,  5 Nov 2020 15:48:07 +0800
Message-Id: <20201105074807.3697-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

part1: Add new memory types used by part2

part2: Add EDAC driver for Intel client SoCs using In-Band ECC(IBECC) IP.
       The first IBECC-supported SoC is Elkhart Lake.

part3: Add debugfs interface for error address decoding test.

Qiuxu Zhuo (3):
  EDAC: Add three new memory types
  EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC
  EDAC/igen6: Add debugfs interface for Intel client SoC EDAC driver

 drivers/edac/Kconfig      |   9 +
 drivers/edac/Makefile     |   1 +
 drivers/edac/edac_mc.c    |   3 +
 drivers/edac/igen6_edac.c | 977 ++++++++++++++++++++++++++++++++++++++
 include/linux/edac.h      |   9 +
 5 files changed, 999 insertions(+)
 create mode 100644 drivers/edac/igen6_edac.c

-- 
2.17.1

