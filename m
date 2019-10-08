Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD51CFA2A
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfJHMlw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 08:41:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730605AbfJHMlv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 08:41:51 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F94734F8692B1D1AE2B;
        Tue,  8 Oct 2019 20:41:48 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 20:41:41 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 0/5] some optimizations of hip08 oem error records
Date:   Tue, 8 Oct 2019 20:38:53 +0800
Message-ID: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset is to optimize hip08 oem error records to make it easier to
understand, and support three more modules for OEM type1 error for hip08.

Xiaofei Tan (5):
  rasdaemon: optimize sqlite3 DB record of register fields for hip08
  rasdaemon: add underscore(_) for some logging item names for hip08
  rasdaemon: change submodule ID of sqlite3 DB field to text for hip08
  rasdaemon: add timestamp for hip08 OEM error records in sqlite3 DB
  rasdaemon: support three more modules for OEM type1 error for hip08

 non-standard-hisi_hip07.c  |   9 +-
 non-standard-hisi_hip08.c  | 375 ++++++++++++++++++++-------------------------
 ras-non-standard-handler.c |   3 +-
 ras-non-standard-handler.h |   2 +-
 4 files changed, 177 insertions(+), 212 deletions(-)

-- 
2.8.1

