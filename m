Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF2391159
	for <lists+linux-edac@lfdr.de>; Wed, 26 May 2021 09:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhEZHXc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 May 2021 03:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhEZHXc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 May 2021 03:23:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C896661028;
        Wed, 26 May 2021 07:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622013721;
        bh=pv8H1BBLtsnpGMEFLtneXFpnHVJz2uDeHP97brRKJP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YvWGnce/NNZkBGEsGVx3IhFVSIk6K2vVG5ZnsxMzOcgZ9kGvscM9+xcx/yL9LkXde
         1ej1uDVcn0i2Nrg1fdOKDwnIBpU55dcOUrSiorR5dYCnJ9oV785BN7AjpwmRlq2njD
         bYqmTLoeBB8ti19uC4Ekf4GnZUm0nNTJf9lQ8PW7xgWE0bnn+rXJm8rZdSc4WdFtho
         /IX9W6o7Z0JqnZR/0VzTb86hZniMo66CvXE6QBxTXe9H7PBotNk/+8Wx2Mcn8FQD+m
         vSsKwWj25IWln69xw1+TBE+CZk+rZe/CithUfPdje6nCIoJyzBp2RkXLIBP03etIw6
         Np+m2mLkkt4xg==
Date:   Wed, 26 May 2021 09:21:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: Re: [PATCH v3 0/7] rasdaemon: Add support for memory_failure events
 and vendor errors
Message-ID: <20210526092156.0da6a9be@coco.lan>
In-Reply-To: <45ad6a601f2c4dd1a66babdedecb1273@huawei.com>
References: <20210308165732.273-1-shiju.jose@huawei.com>
        <45ad6a601f2c4dd1a66babdedecb1273@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 13 May 2021 08:55:02 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> Hi Mauro,
> 
> Ping...
> Any comments on this series?

Applied, thanks!

Next time, it would be better to use github[1], as it is easier for me to
track what's pending to review ;-)

[1] https://github.com/mchehab/rasdaemon

Regards,
Mauro

> 
> Thanks,
> Shiju
> 
> >-----Original Message-----
> >From: Shiju Jose
> >Sent: 08 March 2021 16:57
> >To: linux-edac@vger.kernel.org; mchehab+huawei@kernel.org
> >Cc: Linuxarm <linuxarm@huawei.com>; tanxiaofei
> ><tanxiaofei@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> >Subject: [PATCH v3 0/7] rasdaemon: Add support for memory_failure events
> >and vendor errors
> >
> >1. Add support for the memory_failure trace event in the rasdaemon.
> >2. Add improvements & support for the vendor specific errors into the
> >util/ras-mc-ctl.in script.
> >
> >Changes:
> >v2 -> v3
> >Re-based and removed fix patch for the ras-mc-ctl exception as another fix
> >patch merged recently.
> >
> >v1 -> v2
> >1. Fix the feedback by Mauro for the fix patch for the exception
> >   in the ras-mc-ctl.in.
> >2. Rebased and grouped the previous v1 rasdaemon patches posted.
> >
> >Shiju Jose (7):
> >  rasdaemon: add support for memory_failure events
> >  rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
> >  rasdaemon: ras-mc-ctl: Add memory failure events
> >  rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
> >  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng920 errors
> >  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng9xx common
> >    errors
> >  rasdaemon: Modify confiure.ac for Hisilicon Kunpeng errors
> >
> > .travis.yml                  |   2 +-
> > Makefile.am                  |   7 +-
> > configure.ac                 |  13 +-
> > ras-events.c                 |  15 ++
> > ras-events.h                 |   1 +
> > ras-memory-failure-handler.c | 179 +++++++++++++++++++++  ras-memory-
> >failure-handler.h |  25 +++
> > ras-record.c                 |  70 ++++++++
> > ras-record.h                 |  13 ++
> > ras-report.c                 |  68 ++++++++
> > ras-report.h                 |   2 +
> > util/ras-mc-ctl.in           | 303 ++++++++++++++++++++++++++++++++++-
> > 12 files changed, 688 insertions(+), 10 deletions(-)  create mode 100644 ras-
> >memory-failure-handler.c  create mode 100644 ras-memory-failure-handler.h
> >
> >--
> >2.17.1  
> 



Thanks,
Mauro
