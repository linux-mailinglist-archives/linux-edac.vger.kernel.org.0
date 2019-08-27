Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A19E6C8
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0Lav (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 07:30:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfH0Lav (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Aug 2019 07:30:51 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02E8A79CFB4614B224A2;
        Tue, 27 Aug 2019 19:30:49 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 19:30:41 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <jcm@redhat.com>, <shiju.jose@huawei.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH V2 0/6] CCIX rasdaemon support
Date:   Tue, 27 Aug 2019 19:30:04 +0800
Message-ID: <20190827113010.50405-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Depends on the kernel patches being accepted:
https://lore.kernel.org/linux-edac/20190820144732.2370-1-Jonathan.Cameron@huawei.com/T/#t

Changes since v1:
* Separated out the ras-record section into its own file.
* Rebased on current rasdaemon tree.

This series introduced rasdaemon support to match against the above
series which provides the tracepoints for CCIX PER error reporting from
the kernel to userspace.

These are errors which occur at the CCIX protocol layer which sits
on top of PCIe (for which we have AER).  They are defined in the
CCIX base specification v1.0 an evaluation version of which is available
at www.ccixconsortium.org.

Note the following is a trademark grant and doesn't prevent normal
stuff covered under fair use.  Given this set doesn't quote from
the spec (other than field names), there are no such copyright
notices.

This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
you and other parties that are participating (the "participants") in
rasdemon project with the understanding that the participants will use CCIX's
name and trademark only when this patch is used in association with
rasdaemon.

CCIX is also distributing this patch to these participants with the
understanding that if any portion of the CCIX specification will be
used or referenced in rasdaemon, the participants will not modify
the cited portion of the CCIX specification and will give CCIX proper
copyright attribution by including the following copyright notice with
the cited part of the CCIX specification:
"© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Jonathan Cameron (6):
  rasdaemon: CCIX: memory error support
  rasdaemon: CCIX: Cache error support
  rasdaemon: CCIX: ATC error support
  rasdaemon: CCIX: Port error suppport
  rasdaemon: CCIX: Link error support
  rasdaemon: CCIX: Agent Internal error support

 Makefile.am        |   8 +-
 configure.ac       |  10 +
 ras-ccix-handler.c | 648 +++++++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h | 139 ++++++++++
 ras-events.c       |  61 +++++
 ras-record-ccix.c  | 596 +++++++++++++++++++++++++++++++++++++++++
 ras-record.c       |  15 +-
 ras-record.h       |  43 +++
 ras-report.h       |   6 +-
 9 files changed, 1519 insertions(+), 7 deletions(-)
 create mode 100644 ras-ccix-handler.c
 create mode 100644 ras-ccix-handler.h
 create mode 100644 ras-record-ccix.c

-- 
2.20.1

