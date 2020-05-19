Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E021D92D7
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgESJBr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 05:01:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4863 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgESJBr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 05:01:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4050DD1B439CB79384C7;
        Tue, 19 May 2020 17:01:42 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 17:01:31 +0800
Subject: Re: [PATCH rasdaemon 0/2] support l3tag&l3data decoding and one fix
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <1584954845-21094-1-git-send-email-tanxiaofei@huawei.com>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5EC3A06B.2020106@huawei.com>
Date:   Tue, 19 May 2020 17:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1584954845-21094-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro
Could you please help to review this patch set. thanks.

On 2020/3/23 17:14, Xiaofei Tan wrote:
> This patch set does two things:
> 1.add decoding for two modules, l3tag and l3data.
> 2.fix the issue that non standard decoder can't work in pthread way.
> 
> t00396350 (2):
>   rasdaemon: add support of l3tag and l3data in hip08 OEM format2
>   rasdaemon: fix the issue that non standard decoder can't work in
>     pthread way
> 
>  non-standard-hisi_hip08.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  ras-events.c              |  8 ++------
>  2 files changed, 46 insertions(+), 6 deletions(-)
> 

-- 
 thanks
tanxiaofei

