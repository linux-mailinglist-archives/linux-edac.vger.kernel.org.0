Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB616A057
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXIsI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 03:48:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgBXIsI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Feb 2020 03:48:08 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BD976897F9D30089C632;
        Mon, 24 Feb 2020 16:48:05 +0800 (CST)
Received: from huawei.com (10.175.104.242) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 16:47:56 +0800
From:   lvying <lvying6@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <guanyalong@huawei.com>, <wuyun.wu@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: [PATCH 0/2] rasdaemon: add support for memory Corrected Error predictive failure analysis 
Date:   Mon, 24 Feb 2020 12:07:42 +0800
Message-ID: <1582517264-24003-1-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.242]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

rasdaemon: add support for memory Corrected Error predictive failure analysis

wuyun (2):
  rasdaemon: add rbtree support for page record
  rasdaemon: add support for memory Corrected Error predictive failure
    analysis

 Makefile.am               |   4 +-
 misc/rasdaemon.env        |  29 ++++
 misc/rasdaemon.service.in |   1 +
 ras-events.c              |   3 +
 ras-mc-handler.c          |   5 +
 ras-page-isolation.c      | 308 +++++++++++++++++++++++++++++++++++++
 ras-page-isolation.h      |  68 ++++++++
 rbtree.c                  | 385 ++++++++++++++++++++++++++++++++++++++++++++++
 rbtree.h                  | 166 ++++++++++++++++++++
 9 files changed, 967 insertions(+), 2 deletions(-)
 create mode 100644 misc/rasdaemon.env
 create mode 100644 ras-page-isolation.c
 create mode 100644 ras-page-isolation.h
 create mode 100644 rbtree.c
 create mode 100644 rbtree.h

-- 
1.8.3.1

