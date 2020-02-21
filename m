Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A31166FB8
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2020 07:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgBUGqy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Feb 2020 01:46:54 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40248 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUGqy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 21 Feb 2020 01:46:54 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 905121A6D81;
        Fri, 21 Feb 2020 07:46:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A8AA1A6D7F;
        Fri, 21 Feb 2020 07:46:44 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 295E1403AE;
        Fri, 21 Feb 2020 14:45:58 +0800 (SGT)
From:   sherry sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH 0/3] Add edac driver for i.MX8MP based on synopsys edac driver 
Date:   Fri, 21 Feb 2020 14:39:13 +0800
Message-Id: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

This patchset add edac driver support for i.MX8MP, since i.MX8MP use the same
synopsys memory controller with ZynqMP, so the driver is based on synopsys_edac
driver.

Considering that i.MX8MP dts file is still in kernel/git/shawnguo/linux.git and
isn't in mainline now, I will add EDAC node in i.MX8MP dts after this file is
pushed to mainline. 

And the edac driver for i.MX8MP has been tested in kernel/git/shawnguo/linux.git
where i.MX8MP is supported, it turns out that this driver works well to detect
corrected and uncorrected errors for LPDDR4 in i.MX8MP.

Sherry Sun (3):
  dt-bindings: memory-controllers: Add i.MX8MP DDRC binding doc
  EDAC: Add synopsys edac driver support for i.MX8MP
  EDAC: synopsys: Add edac driver support for i.MX8MP

 .../bindings/memory-controllers/synopsys.txt  |  8 +-
 drivers/edac/Kconfig                          |  2 +-
 drivers/edac/synopsys_edac.c                  | 77 ++++++++++++++++++-
 3 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.17.1

