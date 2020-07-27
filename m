Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE68A22E6BC
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgG0Hjm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 03:39:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgG0Hjm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 03:39:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 510FA401677BAA2719CA;
        Mon, 27 Jul 2020 15:39:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 15:39:30 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH rasdaemon 0/3] add support for hisilicon common section decoder
Date:   Mon, 27 Jul 2020 15:38:36 +0800
Message-ID: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

1.Delete some duplicate/useless code.
2.Add support of hisilicon common section decoder for Kunpeng series.

Xiaofei Tan (3):
  rasdaemon: delete the duplicate code about the definition of hip08 DB
    fields
  rasdaemon: delete the code of non-standard error decoder for hip07
  rasdaemon: add support for hisilicon common section decoder

 Makefile.am               |   2 +-
 non-standard-hisi_hip07.c | 151 -----------------------
 non-standard-hisi_hip08.c | 102 +--------------
 non-standard-hisilicon.c  | 307 ++++++++++++++++++++++++++++++++++++++++++++++
 non-standard-hisilicon.h  |  49 ++++++++
 5 files changed, 363 insertions(+), 248 deletions(-)
 delete mode 100644 non-standard-hisi_hip07.c
 create mode 100644 non-standard-hisilicon.c
 create mode 100644 non-standard-hisilicon.h

-- 
2.8.1

