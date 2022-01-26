Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A487E49D308
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiAZUD5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:03:57 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:53846 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiAZUD5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:03:57 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7C0B020763E2
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 0/5] Stop calling request_irq(), etc. with invalid IRQs in the EDAC drivers
Date:   Wed, 26 Jan 2022 23:03:48 +0300
Message-ID: <20220126200353.14582-1-s.shtylyov@omp.ru>
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

Here are 5 patches against the 'edac-for-next' branch of the 'ras.git' repo
(for the lack of a better branch for fixes?).  The affected drivers call
platform_get_irq() but largely ignore its result -- they blithely pass the
negative error codes to request_irq() (and its ilk) which expects *unsigned*
IRQ #. Stop doing that by checking what exactly platform_get_irq() returns.

Sergey Shtylyov (5):
  edac: altera: add IRQ checks for L2 cache and OCRAM
  edac: altera: add IRQ check for Arria10
  edac: fsl_ddr: add IRQ check
  edac: highbank_l2: add IRQ checks
  edac: highbank_mc: add IRQ check

 drivers/edac/altera_edac.c      | 17 ++++++++++++++---
 drivers/edac/fsl_ddr_edac.c     |  4 ++++
 drivers/edac/highbank_l2_edac.c |  8 ++++++++
 drivers/edac/highbank_mc_edac.c |  4 ++++
 4 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.26.3

