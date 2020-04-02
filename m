Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C110219B9E0
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgDBB20 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 21:28:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44248 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDBB20 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 21:28:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 51FC91A1109;
        Thu,  2 Apr 2020 03:28:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 993D71A1105;
        Thu,  2 Apr 2020 03:28:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DDF0A402DF;
        Thu,  2 Apr 2020 09:28:11 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [patch v3 0/4] Add edac driver for i.MX8MP based on synopsys edac driver
Date:   Thu,  2 Apr 2020 09:20:29 +0800
Message-Id: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset add edac driver support for i.MX8MP, since i.MX8MP use the same
synopsys memory controller with ZynqMP, so the driver is based on synopsys_edac
driver.

Considering that i.MX8MP dts file is still in kernel/git/shawnguo/linux.git and
isn't in mainline now, I will add EDAC node in i.MX8MP dts after this file is
pushed to mainline. 

And the edac driver for i.MX8MP has been tested in kernel/git/shawnguo/linux.git
where i.MX8MP is supported, it turns out that this driver works well to detect
corrected and uncorrected errors for LPDDR4 in i.MX8MP.

Changes since v2:
=================
- Use u64 data instead u32 data_low and u32 data_high as robert suggested in
patch 4/4.
- Add edac_dbg() for the != DEV_X8 cases in zynqmp_get_error_info() in patch
4/4.
- Change the format of the output data to avoid build warnings in patch 4/4.

Changes since v1:
=================
- Reorganized the patchset, no content changes. 

Sherry Sun (4):
  dt-bindings: memory-controllers: Add i.MX8MP DDRC binding doc
  EDAC: Add synopsys edac driver support for i.MX8MP
  EDAC: synopsys: Add edac driver support for i.MX8MP
  EDAC: synopsys: Add useful debug and output information for 64bit
    systems

 .../bindings/memory-controllers/synopsys.txt  |   8 +-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/synopsys_edac.c                  | 248 ++++++++++++------
 3 files changed, 179 insertions(+), 79 deletions(-)

-- 
2.17.1

