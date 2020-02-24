Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8E16A2F8
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 10:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBXJtN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 04:49:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:52676 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBXJtN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Feb 2020 04:49:13 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 514CB20DC21;
        Mon, 24 Feb 2020 10:49:11 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C5BE20DC1A;
        Mon, 24 Feb 2020 10:49:05 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 36FC8402B3;
        Mon, 24 Feb 2020 17:48:58 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH 0/3] Improve the output message for CE/UE
Date:   Mon, 24 Feb 2020 17:42:34 +0800
Message-Id: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset correct and reorganize the output message which shows the CE/UE
relevant information, and add more useful output information for 64 bit systems.

Sherry Sun (3):
  EDAC: synopsys: Remove pinf->col parameter for ZynqMP and i.MX8MP
  EDAC: synopsys: Reorganizing the output message for CE/UE
  EDAC: synopsys: Add useful output information for 64 bit systems

 drivers/edac/synopsys_edac.c | 198 +++++++++++++++++++----------------
 1 file changed, 106 insertions(+), 92 deletions(-)

-- 
2.17.1

