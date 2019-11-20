Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC5F103295
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2019 05:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKTEht (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Nov 2019 23:37:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKTEht (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Nov 2019 23:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lPo4c5dbNwDK853TpeEByVuN+U6mdicfp6vecFPXBWI=; b=Z1GYiMRzUunSIz0pVRypFMCFc
        KvmXX+J/z74ymro6PXpgGx5VgsvGs7o86ulY0Hbf6WZVMA9Qs7r5FiGW6dsEYb/blGJnecXrB/N6I
        pugna+cqKQiSMyQFyDr/nVuT2gNxArFlg92DO9HtuJ69FxxiCFmNIWo9o0nkWYs6rFJmmXHMvPSQC
        Ts0OSvk8QrxNQAQFxypcd7zurOdVlpUstktVm8NVMg+6hvxVfzvF6hijQ+vQrnoGBsnzkID2/jZSb
        4HH0aOM3NMHdacwP5z0fgD4ra3+NFzR6eO2YRlTgoJHnmEZYPTO6pP5tlCIdafMiDei4UsB6wBcvS
        +wiX/1aDg==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXHkR-0001iP-18; Wed, 20 Nov 2019 04:37:47 +0000
Date:   Wed, 20 Nov 2019 05:37:38 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 0/7] rasdaemon: add fixes, database closure and signal
 handling
Message-ID: <20191120053725.6c80d631@localhost>
In-Reply-To: <3214142033cc4a8d8d050721bdaa8340@huawei.com>
References: <Shiju Jose>
        <20191016163401.16980-1-shiju.jose@huawei.com>
        <3214142033cc4a8d8d050721bdaa8340@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 13 Nov 2019 16:38:45 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> Hi Mauro,
> 
> Can you please review this patch set?

Reviewed both rasdaemon patchsets and applied.

Thanks!
Mauro

> 
> Thanks,
> Shiju
> 
> >-----Original Message-----
> >From: Shiju Jose
> >Sent: 16 October 2019 17:34
> >To: mchehab@kernel.org; linux-edac@vger.kernel.org
> >Cc: Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> >Subject: [PATCH 0/7] rasdaemon: add fixes, database closure and signal
> >handling
> >
> >This patch set add
> >1. fixes for some memory leaks and file closure.
> >2. closure for the sqlite3 database.
> >3. signal handling for the cleanup.
> >
> >Shiju Jose (7):
> >  rasdaemon: fix cleanup issues in
> >    ras-events.c:read_ras_event_all_cpus()
> >  rasdaemon: fix memory leak in ras-events.c:handle_ras_events()
> >  rasdaemon: fix missing fclose in
> >    ras-events.c:select_tracing_timestamp()
> >  rasdaemon: fix memory leak in ras-events.c:add_event_handler()
> >  rasdaemon: delete multiple definitions of ARRAY_SIZE
> >  rasdaemon: add closure and cleanups for the database
> >  rasdaemon: add signal handling for the cleanup
> >
> > ras-diskerror-handler.c    |   2 -
> > ras-events.c               |  88 +++++++++++++++++++++++++++-----
> > ras-mce-handler.h          |   3 --
> > ras-non-standard-handler.c |  16 ++++++
> > ras-non-standard-handler.h |   6 ++-
> > ras-record.c               | 123
> >+++++++++++++++++++++++++++++++++++++++++++--
> > ras-record.h               |   5 ++
> > 7 files changed, 222 insertions(+), 21 deletions(-)
> >
> >--
> >2.1.4
> >
> 




Cheers,
Mauro
