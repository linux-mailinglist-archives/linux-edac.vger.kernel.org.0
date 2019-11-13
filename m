Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88DBFB51C
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2019 17:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfKMQbf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Nov 2019 11:31:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbfKMQbf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Nov 2019 11:31:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E3222AA1BADC4D0F158A;
        Thu, 14 Nov 2019 00:31:32 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 00:31:21 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH rasdaemon 0/2] rasdaemon: add fix for the sql table
Date:   Wed, 13 Nov 2019 16:31:11 +0000
Message-ID: <20191113163113.3356-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

rasdaemon fail to prepare the sql table when new fields are added on top
of the existing sql table present in the system.

This patch set add solution for this issue and a patch for adding missing
information to the aer_event table.

Shiju Jose (2):
  rasdaemon: fix for the ras-record.c:ras_mc_prepare_stmt() failure when
    new fields added to the sql table
  rasdaemon: store PCIe dev name and TLP header for the aer event

 ras-aer-handler.c | 21 +++++++++++-
 ras-record.c      | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 ras-record.h      |  2 ++
 3 files changed, 115 insertions(+), 7 deletions(-)

-- 
1.9.1


