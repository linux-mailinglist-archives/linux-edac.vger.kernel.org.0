Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4651ADE
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFXSmt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 14:42:49 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:36562 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727263AbfFXSmt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jun 2019 14:42:49 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Jun 2019 21:42:47 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x5OIgjKM016895;
        Mon, 24 Jun 2019 14:42:45 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x5OIgieg000879;
        Mon, 24 Jun 2019 14:42:44 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Mon, 24 Jun 2019 14:42:11 -0400
Message-Id: <cover.1561400421.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Chnages since v5:
Use shifts/masks for SMC response fields.
Add limit check for dimm_per_mc read from firmware.
Make use of offset_in_page() call.

Shravan Kumar Ramani (1):
  EDAC, mellanox: Add ECC support for BlueField DDR4

 MAINTAINERS                   |   5 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 381 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

-- 
2.1.2

