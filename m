Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA6498993
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jan 2022 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiAXS5N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jan 2022 13:57:13 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:38320 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbiAXSzI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jan 2022 13:55:08 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 9E48020624B6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 0/2] Fix deferred probing in the EDAC drivers
Date:   Mon, 24 Jan 2022 21:55:01 +0300
Message-ID: <20220124185503.6720-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Here are 2 patches against the 'edac-for-next' branch of the 'ras.git' repo
(for the lack of a better branch for fixes?).  The affected drivers call
platform_get_irq[_optional]() but override its result in case of error --
which prevents the deferred probing from working.

Sergey Shtylyov (2):
  edac: altera: fix deferred probing
  edac: xgene: fix deferred probing

 drivers/edac/altera_edac.c | 2 +-
 drivers/edac/xgene_edac.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.3

