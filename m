Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676FC5614D5
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jun 2022 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiF3IWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 30 Jun 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiF3IWb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 Jun 2022 04:22:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CEE65
        for <linux-edac@vger.kernel.org>; Thu, 30 Jun 2022 01:22:26 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYWWh11gXz67ms2;
        Thu, 30 Jun 2022 16:21:36 +0800 (CST)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 10:22:23 +0200
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 09:22:23 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.2375.024;
 Thu, 30 Jun 2022 09:22:23 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        luoshengwei <luoshengwei@huawei.com>,
        panjunchong <panjunchong@hisilicon.com>,
        fenglei <fenglei47@h-partners.com>
Subject: RE: [PATCH 00/10] rasdaemon: Add cpu fault isolation support and
 improvements to the HiSilicon vendor specific code
Thread-Topic: [PATCH 00/10] rasdaemon: Add cpu fault isolation support and
 improvements to the HiSilicon vendor specific code
Thread-Index: AQHYYU8E/8O/2/6Z+EGPu8b6kKI+bK1n8CKQ
Date:   Thu, 30 Jun 2022 08:22:23 +0000
Message-ID: <0dfa9b08d37a42d7b36d351ea3e7c641@huawei.com>
References: <20220506133307.1799-1-shiju.jose@huawei.com>
In-Reply-To: <20220506133307.1799-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.246.239]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Any feedback on these patches?

Thanks,
Shiju 

>-----Original Message-----
>From: Shiju Jose <shiju.jose@huawei.com>
>Sent: 06 May 2022 14:33
>To: linux-edac@vger.kernel.org; mchehab@kernel.org
>Cc: Linuxarm <linuxarm@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; luoshengwei <luoshengwei@huawei.com>;
>panjunchong <panjunchong@hisilicon.com>; fenglei <fenglei47@h-
>partners.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: [PATCH 00/10] rasdaemon: Add cpu fault isolation support and
>improvements to the HiSilicon vendor specific code
>
>From: Shiju Jose <shiju.jose@huawei.com>
>
>1. Support cpu fault isolation for the corrected and recoverable errors.
>2. Improvements to the HiSilicon vendor specific code.
>3. Bug fix for a memory out-of-bounds issue.
>
>Shengwei Luo (2):
>  rasdaemon: Support cpu fault isolation for corrected errors
>  rasdaemon: Support cpu fault isolation for recoverable errors
>
>Shiju Jose (8):
>  rasdaemon: Modify recording Hisilicon common error data
>  rasdaemon: ras-mc-ctl: Modify error statistics for HiSilicon
>    KunPeng9xx common errors
>  rasdaemon: ras-mc-ctl: Reformat error info of the HiSilicon Kunpeng920
>  rasdaemon: ras-mc-ctl: Add printing usage if necessary parameters are
>    not passed for the vendor-error options
>  rasdaemon: ras-mc-ctl: Add support to display the HiSilicon vendor
>    errors for a specified module
>  rasdaemon: ras-mc-ctl: Relocate reading and display Kunpeng920 errors
>    to under Kunpeng9xx
>  rasdaemon: ras-mc-ctl: Updated HiSilicon platform name
>  rasdaemon: Fix for a memory out-of-bounds issue and optimized code to
>    remove duplicate function.
>
> Makefile.am                |   6 +-
> configure.ac               |  11 +
> misc/rasdaemon.env         |  17 ++
> non-standard-hisi_hip08.c  |   6 +-
> non-standard-hisilicon.c   | 128 +++++++++---
> queue.c                    | 119 +++++++++++
> queue.h                    |  39 ++++
> ras-arm-handler.c          | 113 +++++++++++
> ras-arm-handler.h          |  18 ++
> ras-cpu-isolation.c        | 405 +++++++++++++++++++++++++++++++++++++
> ras-cpu-isolation.h        |  70 +++++++
> ras-events.c               |   9 +-
> ras-non-standard-handler.c |  16 +-
> util/ras-mc-ctl.in         | 196 ++++++++++--------
> 14 files changed, 1028 insertions(+), 125 deletions(-)  create mode 100644
>queue.c  create mode 100644 queue.h  create mode 100644 ras-cpu-
>isolation.c  create mode 100644 ras-cpu-isolation.h
>
>--
>2.25.1

