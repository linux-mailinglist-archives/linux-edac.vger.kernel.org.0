Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2184A4669F
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfFNRzp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 13:55:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfFNRzo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FAF26C89ED8D3F9C9A6;
        Sat, 15 Jun 2019 01:55:42 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Jun 2019 01:55:34 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <mchehab@kernel.org>, <linuxarm@huawei.com>, <jcm@redhat.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/6] CCIX rasdaemon support
Date:   Sat, 15 Jun 2019 01:55:11 +0800
Message-ID: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
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

This is an RFC because the kernel side is currently under review and
may change with obvious follow through effects on this.

https://lore.kernel.org/linux-edac/20190606123654.78973-1-Jonathan.Cameron@huawei.com/

There are a few additional questions around this:
1. Divide between specifity of DB fields vs blobs.
   Where possible I have tried to fully describe the contents via
   separate fields rather than large blobs.  One common SQL convention
   that doesn't seem to have been previously done in rasdaemon is to
   use explicit NULL entries for elements where data is missing.
2. Should we split ras-record.c and have the ccix handling in a separate
   ras-record-ccix.c file or similar as that one is getting rather large.

Note the following is a trademark grant and doesn't prevent normal
stuff covered under fair use.  Given this doesn't current quote from
the spec, there are no such copyright notices.

This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
you and other parties that are paticipating (the "participants") in
rasdemon project with the understanding that the participants will use CCIX's
name and trademark only when this patch is used in association with 
rasdaemon.

CCIX is also distributing this patch to these participants with the
understanding that if any portion of the CCIX specification will be
used or referenced in rasdaemon, the participants will not modify
the cited portion of the CCIX specification and will give CCIX propery
copyright attribution by including the following copyright notice with
the cited part of the CCIX specification:
"© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Jonathan Cameron (6):
  rasdaemon: CCIX: CCIX memory error reporting.
  rasdaemon: CCIX: Cache error support
  rasdaemon: CCIX: ATC errors
  rasdaemon: CCIX: Port error handling
  rasdaemon: CCIX: Link error support
  rasdaemon: CCIX: Agent Internal error support

 Makefile.am        |   6 +-
 configure.ac       |  10 +
 ras-ccix-handler.c | 648 +++++++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h | 139 ++++++++++
 ras-events.c       |  61 +++++
 ras-record.c       | 568 +++++++++++++++++++++++++++++++++++++++
 ras-record.h       |  35 +++
 ras-report.h       |   6 +-
 8 files changed, 1471 insertions(+), 2 deletions(-)
 create mode 100644 ras-ccix-handler.c
 create mode 100644 ras-ccix-handler.h

-- 
2.20.1

