Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D532461EE49
	for <lists+linux-edac@lfdr.de>; Mon,  7 Nov 2022 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKGJKI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Nov 2022 04:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKGJKC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Nov 2022 04:10:02 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 01:10:00 PST
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC66A63EF
        for <linux-edac@vger.kernel.org>; Mon,  7 Nov 2022 01:10:00 -0800 (PST)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from shravankr@mellanox.com)
        with SMTP; 7 Nov 2022 11:03:18 +0200
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 2A793Hlg028154;
        Mon, 7 Nov 2022 04:03:17 -0500
Received: (from shravankr@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 2A793BTq008287;
        Mon, 7 Nov 2022 04:03:11 -0500
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     James Morse <james.morse@arm.com>
Cc:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH v1 0/2] EDAC: Updates to bluefield_edac
Date:   Mon,  7 Nov 2022 04:02:52 -0500
Message-Id: <cover.1667561793.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The first patch adds secure read/write calls for accessing
the BlueField EMI registers. The second patch updates the
license and copyright info for the same driver.

Shravan Kumar Ramani (2):
  EDAC/bluefield_edac: Add SMC support
  EDAC/bluefield_edac: Update license and copyright info

 drivers/edac/bluefield_edac.c | 184 +++++++++++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 24 deletions(-)

-- 
2.30.1

