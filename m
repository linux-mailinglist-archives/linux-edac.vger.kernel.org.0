Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84F5578E
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2019 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfFYTOK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Jun 2019 15:14:10 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48072 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730291AbfFYTOK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Jun 2019 15:14:10 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Jun 2019 22:14:06 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x5PJE4b8024022;
        Tue, 25 Jun 2019 15:14:04 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x5PJE2jI001851;
        Tue, 25 Jun 2019 15:14:02 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Joe Perches <joe@perches.com>,
        James Morse <james.morse@arm.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Tue, 25 Jun 2019 15:13:58 -0400
Message-Id: <cover.1561489514.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Changes since v6:
Use FIELD_GET and GENMASK instead of shifting/masking using separate macros

Shravan Kumar Ramani (1):
  EDAC, mellanox: Add ECC support for BlueField DDR4

 MAINTAINERS                   |   5 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 356 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

-- 
2.1.2

