Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934A7109DAA
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKZMQA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727638AbfKZMQA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CB5DEF9A712ED0DF5A3D;
        Tue, 26 Nov 2019 20:15:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:45 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 0/9] rasdaemon: fix some issues reported by static code analysis
Date:   Tue, 26 Nov 2019 20:12:27 +0800
Message-ID: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix some issues reported by static code analysis.

Changelogs:
v1->v2:
* 1.Remove two accepted patches.
* 2.Optimize the buffer pointer check macro.
* 3.Add patch "rasdaemon: fix case style issues for enum constant".
* 4.Add patch "rasdaemon: add default branch for switch statement".

Xiaofei Tan (9):
  rasdaemon: decode submodule of OEM type1 for hip08
  rasdaemon: fix sub module name of HHA and DDRC for hip08
  rasdaemon: split OEM type1 table decode function to reduce length
  rasdaemon: split OEM type2 table decode function to reduce length
  rasdaemon: split PCIe local table decode function to reduce length
  rasdaemon: fix magic number issues reported by static code analysis
    for hip08
  rasdaemon: replace sprintf with snprintf for hip08
  rasdaemon: fix case style issues for enum constant
  rasdaemon: add default branch for switch statement

 non-standard-hisi_hip08.c | 885 ++++++++++++++++++++++++++++++----------------
 1 file changed, 574 insertions(+), 311 deletions(-)

-- 
2.8.1

