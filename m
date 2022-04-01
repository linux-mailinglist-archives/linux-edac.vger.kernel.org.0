Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B84EEA1C
	for <lists+linux-edac@lfdr.de>; Fri,  1 Apr 2022 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiDAJKT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Apr 2022 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbiDAJKS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 1 Apr 2022 05:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8996CC6EEF
        for <linux-edac@vger.kernel.org>; Fri,  1 Apr 2022 02:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40AD7B82278
        for <linux-edac@vger.kernel.org>; Fri,  1 Apr 2022 09:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA14C2BBE4;
        Fri,  1 Apr 2022 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648804105;
        bh=VpWFoo8koXh3P8W57Qm6RmVDfV9MbF66XtP4UlJRLxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1IHSwha/sLmDnkMKXQYtTljiQB8SbgKdrjnBSyPaU0Hu4ERZ1u1vmm6ruIhCb/DO
         w/jxwos+UvC2iTq3kfKn2bYNW92UHhGkZX/T5Mx4SZ/US5eC7JkAwYBg2MhAP60Mae
         Vh1fwIzApAgNnZwCaG9mVd79E0Oerx21eJ47aSOU6ny9hwFpDM/NRSWsXCogPEJ89x
         Nh6Cqp5V6B1ItZD1wVQSy4L1RacK5PdJdngTXJdI4fg5OPZMk1UC22V0ouv3W2V7hx
         X7n4DT9ZmXkImSAg+xLi9hJpXafSpSZ9IzdDN15q2KJXSi522l0ZUsvIg6ayB37Wav
         H21BEkRf6VC/w==
Date:   Fri, 1 Apr 2022 11:08:21 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <shiju.jose@huawei.com>,
        <linuxarm@openeuler.org>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 0/4] rasdaemon: Some little fixes and add some modules
 support
Message-ID: <20220401110821.751621ee@coco.lan>
In-Reply-To: <20211020063340.26079-1-tanxiaofei@huawei.com>
References: <20211020063340.26079-1-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 20 Oct 2021 14:33:36 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

> Some little fixes and add some modules support for kunpeng series.
> 
> Xiaofei Tan (4):
>   rasdaemon: Fix the issue of sprintf data type mismatch in uuid_le()
>   rasdaemon: Fix the issue of command option -r for hip08
>   rasdaemon: Fix some print format issues for hisi common error section
>   rasdaemon: Add some modules supported by hisi common error section
> 
>  non-standard-hisi_hip08.c  |  6 +++---
>  non-standard-hisilicon.c   | 32 +++++++++++++++++++++-----------
>  ras-extlog-handler.c       |  2 +-
>  ras-non-standard-handler.c |  4 ++--
>  4 files changed, 27 insertions(+), 17 deletions(-)
> 

Patches applied, thanks!


Thanks,
Mauro
