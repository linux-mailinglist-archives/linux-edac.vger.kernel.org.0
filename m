Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95FB43453E
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 08:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJTGkr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Oct 2021 02:40:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25172 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGkq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Oct 2021 02:40:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HZ19S19w7z1DHgm;
        Wed, 20 Oct 2021 14:36:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 14:38:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 14:38:30 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <shiju.jose@huawei.com>, <linuxarm@openeuler.org>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 0/4] rasdaemon: Some little fixes and add some modules support
Date:   Wed, 20 Oct 2021 14:33:36 +0800
Message-ID: <20211020063340.26079-1-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some little fixes and add some modules support for kunpeng series.

Xiaofei Tan (4):
  rasdaemon: Fix the issue of sprintf data type mismatch in uuid_le()
  rasdaemon: Fix the issue of command option -r for hip08
  rasdaemon: Fix some print format issues for hisi common error section
  rasdaemon: Add some modules supported by hisi common error section

 non-standard-hisi_hip08.c  |  6 +++---
 non-standard-hisilicon.c   | 32 +++++++++++++++++++++-----------
 ras-extlog-handler.c       |  2 +-
 ras-non-standard-handler.c |  4 ++--
 4 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.33.0

