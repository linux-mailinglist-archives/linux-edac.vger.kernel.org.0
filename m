Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767AE37F47B
	for <lists+linux-edac@lfdr.de>; Thu, 13 May 2021 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhEMI4W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 13 May 2021 04:56:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2494 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhEMI4V (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 May 2021 04:56:21 -0400
Received: from dggeml703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fglm44LwZzYkjc;
        Thu, 13 May 2021 16:52:36 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggeml703-chm.china.huawei.com (10.3.17.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 16:55:05 +0800
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 16:55:04 +0800
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.2176.012;
 Thu, 13 May 2021 09:55:02 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH v3 0/7] rasdaemon: Add support for memory_failure events
 and vendor errors 
Thread-Topic: [PATCH v3 0/7] rasdaemon: Add support for memory_failure events
 and vendor errors 
Thread-Index: AQHXFDx2GF1rzgorZEuUVxK8iHabd6rhf9cA
Date:   Thu, 13 May 2021 08:55:02 +0000
Message-ID: <45ad6a601f2c4dd1a66babdedecb1273@huawei.com>
References: <20210308165732.273-1-shiju.jose@huawei.com>
In-Reply-To: <20210308165732.273-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.84.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro,

Ping...
Any comments on this series?

Thanks,
Shiju

>-----Original Message-----
>From: Shiju Jose
>Sent: 08 March 2021 16:57
>To: linux-edac@vger.kernel.org; mchehab+huawei@kernel.org
>Cc: Linuxarm <linuxarm@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: [PATCH v3 0/7] rasdaemon: Add support for memory_failure events
>and vendor errors
>
>1. Add support for the memory_failure trace event in the rasdaemon.
>2. Add improvements & support for the vendor specific errors into the
>util/ras-mc-ctl.in script.
>
>Changes:
>v2 -> v3
>Re-based and removed fix patch for the ras-mc-ctl exception as another fix
>patch merged recently.
>
>v1 -> v2
>1. Fix the feedback by Mauro for the fix patch for the exception
>   in the ras-mc-ctl.in.
>2. Rebased and grouped the previous v1 rasdaemon patches posted.
>
>Shiju Jose (7):
>  rasdaemon: add support for memory_failure events
>  rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
>  rasdaemon: ras-mc-ctl: Add memory failure events
>  rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
>  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng920 errors
>  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng9xx common
>    errors
>  rasdaemon: Modify confiure.ac for Hisilicon Kunpeng errors
>
> .travis.yml                  |   2 +-
> Makefile.am                  |   7 +-
> configure.ac                 |  13 +-
> ras-events.c                 |  15 ++
> ras-events.h                 |   1 +
> ras-memory-failure-handler.c | 179 +++++++++++++++++++++  ras-memory-
>failure-handler.h |  25 +++
> ras-record.c                 |  70 ++++++++
> ras-record.h                 |  13 ++
> ras-report.c                 |  68 ++++++++
> ras-report.h                 |   2 +
> util/ras-mc-ctl.in           | 303 ++++++++++++++++++++++++++++++++++-
> 12 files changed, 688 insertions(+), 10 deletions(-)  create mode 100644 ras-
>memory-failure-handler.c  create mode 100644 ras-memory-failure-handler.h
>
>--
>2.17.1

