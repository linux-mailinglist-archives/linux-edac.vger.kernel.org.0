Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5018F190
	for <lists+linux-edac@lfdr.de>; Mon, 23 Mar 2020 10:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCWJSE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Mar 2020 05:18:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbgCWJSE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Mar 2020 05:18:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08872966C67CBD467CAE;
        Mon, 23 Mar 2020 17:17:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Mar 2020 17:17:49 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH rasdaemon 0/2] support l3tag&l3data decoding and one fix
Date:   Mon, 23 Mar 2020 17:14:03 +0800
Message-ID: <1584954845-21094-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch set does two things:
1.add decoding for two modules, l3tag and l3data.
2.fix the issue that non standard decoder can't work in pthread way.

t00396350 (2):
  rasdaemon: add support of l3tag and l3data in hip08 OEM format2
  rasdaemon: fix the issue that non standard decoder can't work in
    pthread way

 non-standard-hisi_hip08.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 ras-events.c              |  8 ++------
 2 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.8.1

