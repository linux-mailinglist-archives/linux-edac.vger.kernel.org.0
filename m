Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC6D6840
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbfJNRT3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 13:19:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731347AbfJNRT3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 13:19:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2261628;
        Mon, 14 Oct 2019 10:19:29 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399AA3F6C4;
        Mon, 14 Oct 2019 10:19:28 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-edac@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Date:   Mon, 14 Oct 2019 18:19:17 +0100
Message-Id: <20191014171919.85044-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

ghes_edac can only be registered once, later attempts will silently
do nothing as the driver is already setup. The unregister path also
only expects to be called once, but doesn't check.

This leads to KASAN splats if multiple GHES entries are unregistered,
as the free()d memory is dereferenced, and if we're lucky, free()d
a second time.

Link: lore.kernel.org/r/304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com

Patch 1 is the minimum needed to prevent the dereference and double
free, but this does expose the lack of symmetry. If we unregister
one GHES entry, subsequent notifications will be lost.
Unregistering is unsafe if another CPU is using the free()d memory in
ghes_edac_report_mem_error().

To fix this, Patch 2 uses ghes_init as a reference count.

We can now unbind all the GHES entries, causing ghes_edac to be
unregistered, and start rebinding them again.


Thanks,

James Morse (2):
  EDAC, ghes: Fix Use after free in ghes_edac remove path
  EDAC, ghes: Reference count GHES users of ghes_edac

 drivers/edac/ghes_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.20.1

