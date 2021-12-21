Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760AC47B6CD
	for <lists+linux-edac@lfdr.de>; Tue, 21 Dec 2021 02:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhLUBWZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Dec 2021 20:22:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33883 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLUBWZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Dec 2021 20:22:25 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JHzFj6sVRzcc4X;
        Tue, 21 Dec 2021 09:22:01 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 09:22:23 +0800
Received: from [10.67.100.236] (10.67.100.236) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 09:22:23 +0800
Message-ID: <1976430a-7912-47b0-f392-20efafe11ff2@huawei.com>
Date:   Tue, 21 Dec 2021 09:22:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/4] rasdaemon: Some little fixes and add some modules
 support
To:     <mchehab@kernel.org>, <mchehab+huawei@kernel.org>
CC:     <shiju.jose@huawei.com>, <linuxarm@openeuler.org>,
        <jonathan.cameron@huawei.com>, <linux-edac@vger.kernel.org>
References: <20211020063340.26079-1-tanxiaofei@huawei.com>
From:   tanxiaofei <tanxiaofei@huawei.com>
In-Reply-To: <20211020063340.26079-1-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.100.236]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro

Please help to review this patchset, many thanks.

在 2021/10/20 14:33, Xiaofei Tan 写道:
> Some little fixes and add some modules support for kunpeng series.
> 
> Xiaofei Tan (4):
>    rasdaemon: Fix the issue of sprintf data type mismatch in uuid_le()
>    rasdaemon: Fix the issue of command option -r for hip08
>    rasdaemon: Fix some print format issues for hisi common error section
>    rasdaemon: Add some modules supported by hisi common error section
> 
>   non-standard-hisi_hip08.c  |  6 +++---
>   non-standard-hisilicon.c   | 32 +++++++++++++++++++++-----------
>   ras-extlog-handler.c       |  2 +-
>   ras-non-standard-handler.c |  4 ++--
>   4 files changed, 27 insertions(+), 17 deletions(-)
> 
