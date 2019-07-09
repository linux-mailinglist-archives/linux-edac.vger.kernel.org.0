Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27CD63DD1
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2019 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfGIWWu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 18:22:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:10284 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGIWWt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 18:22:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 15:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,472,1557212400"; 
   d="scan'208";a="364289183"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2019 15:22:47 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 0/3] Stratix10 SDRAM Common EDAC Framework
Date:   Tue,  9 Jul 2019 17:24:47 -0500
Message-Id: <1562711090-900-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Use the common Altera EDAC Device Framework for the SDRAM so that
Double Bit Error Addresses can be tracked for SDRAM.
This also simplifies the device tree.

Thor Thayer (3):
  Documentation: dt: edac: Add reg to S10 SDRAM node
  arm64: dts: Stratix10: Include regs in SDRAM ECC node
  EDAC, altera: Use common framework for Stratix10 SDRAM ECC

 .../devicetree/bindings/edac/socfpga-eccmgr.txt    |  4 ++-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  9 ++----
 drivers/edac/altera_edac.c                         | 32 ++++++++++++++++++++--
 drivers/edac/altera_edac.h                         | 25 ++++++++++++++++-
 4 files changed, 58 insertions(+), 12 deletions(-)

-- 
2.7.4

