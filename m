Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6DF8FAD
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2019 13:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfKLMaa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Nov 2019 07:30:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLMa3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Nov 2019 07:30:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4A2240B04904A4B55EC;
        Tue, 12 Nov 2019 20:30:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 20:30:17 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 0/9] rasdaemon: fix some issues reported by static code analysis
Date:   Tue, 12 Nov 2019 20:27:05 +0800
Message-ID: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix some issues reported by static code analysis, and sub module name issue
in the last patch 3/9 and 4/9.

Xiaofei Tan (9):
  rasdaemon: fix the wrong declaring of 'sruct ras_events' in
    ras-record.h
  rasdaemon: fix an warning reported by PC-Lint
  rasdaemon: decode submodule of OEM type1 for hip08
  rasdaemon: fix sub module name of HHA and DDRC for hip08
  rasdaemon: split OEM type1 table decode function to reduce length
  rasdaemon: split OEM type2 table decode function to reduce length
  rasdaemon: split PCIe local table decode function to reduce length
  rasdaemon: fix magic number issues reported by static code analysis
    for hip08
  rasdaemon: replace sprintf with snprintf for hip08

 non-standard-hisi_hip08.c | 686 +++++++++++++++++++++++++++++++---------------
 ras-record.h              |   2 +-
 2 files changed, 462 insertions(+), 226 deletions(-)

-- 
2.8.1

