Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC22023C6
	for <lists+linux-edac@lfdr.de>; Sat, 20 Jun 2020 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgFTM0i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 20 Jun 2020 08:26:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6371 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbgFTM0h (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 20 Jun 2020 08:26:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 075FC3DE42BAD52C9A35;
        Sat, 20 Jun 2020 20:26:35 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 20:26:27 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <guanyalong@huawei.com>, <wuyun.wu@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: [PATCH v2 rasdaemon 0/2] support memory CE predictive failure analysis
Date:   Sat, 20 Jun 2020 20:26:20 +0800
Message-ID: <1592655982-12725-1-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
References: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The patch v2 has been modified according to Mauro's code review.
Changelog:
v1 -- v2
1. add a configure option(WITH_MEMORY_CE_PFA) to isolate this feature.
2. add %install and %files content into misc/rasdaemon.spec.in
3. add config file man page
4. rewrite parse_isolation_env function to make it clearly

lvying6 (2):
  rasdaemon: add rbtree support for page record
  rasdaemon: add support for memory Corrected Error predictive failure
    analysis

 .travis.yml               |   2 +-
 Makefile.am               |   5 +-
 configure.ac              |  11 ++
 man/rasdaemon.1.in        |   7 +
 misc/rasdaemon.env        |  29 ++++
 misc/rasdaemon.service.in |   1 +
 misc/rasdaemon.spec.in    |   2 +
 ras-events.c              |   6 +
 ras-mc-handler.c          |   7 +
 ras-page-isolation.c      | 332 +++++++++++++++++++++++++++++++++++++++
 ras-page-isolation.h      |  66 ++++++++
 rbtree.c                  | 384 ++++++++++++++++++++++++++++++++++++++++++++++
 rbtree.h                  | 165 ++++++++++++++++++++
 13 files changed, 1015 insertions(+), 2 deletions(-)
 create mode 100644 misc/rasdaemon.env
 create mode 100644 ras-page-isolation.c
 create mode 100644 ras-page-isolation.h
 create mode 100644 rbtree.c
 create mode 100644 rbtree.h

-- 
1.8.3.1

