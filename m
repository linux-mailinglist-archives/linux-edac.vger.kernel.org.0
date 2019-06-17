Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5348CD0
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFQSoQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 14:44:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34027 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726007AbfFQSln (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Jun 2019 14:41:43 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 Jun 2019 21:41:41 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x5HIfeLY003389;
        Mon, 17 Jun 2019 14:41:40 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x5HIfd96011255;
        Mon, 17 Jun 2019 14:41:39 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Mon, 17 Jun 2019 14:41:15 -0400
Message-Id: <cover.1560786127.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Changes since v4:
Shorten long macro names.

Changes since v3:
Replace bitfields with shifts and masks.
Make use of SZ_ and PAGE_ macros.
Read DIMM count from the ACPI table instead of hard-coding the info in
the driver.

Shravan Kumar Ramani (1):
  EDAC, mellanox: Add ECC support for BlueField DDR4

 MAINTAINERS                   |   5 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 366 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

-- 
2.1.2

