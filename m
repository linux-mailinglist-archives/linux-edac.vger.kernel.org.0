Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062A84EF25
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2019 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFUS4G (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Jun 2019 14:56:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfFUS4G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 21 Jun 2019 14:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SyOfB2Xe5lSMwJ5Axvyuhm/8OhedEgUcL8u58j5Tx7A=; b=V4xG0Eg8pNZNXKiqjjBpCj5Dz
        QlBAqqEdS0xHBpjyYreMP5n5aWXoohprLPrgIzvjtzfCS4KnnGTx77kZLWcz2bEeOL3reoM5nUdnZ
        Onu99kv0CelFVOaWmrOptltNwyU/3xImEOnXJet5OThVVC9QAzfUZhj6Me+odYgNk4gRNidyOdkzI
        JR80gl1rjyQyUinzJ8glzV/neniawLEedMJeVfkL+0qsPKBAr5fJEKiSLBZjjqP2CTHDrhCVOCgnD
        M2H8pvRIxZiwk+ja1auj1ZMfeVfLOUdpDMf1+Fpzk9FX0Ip5zPJg+Wr9wNKOo9nI16CoCoCIiSv6K
        m6wWgHixw==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heOhg-0008IF-Ge; Fri, 21 Jun 2019 18:56:04 +0000
Date:   Fri, 21 Jun 2019 15:56:00 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <jcm@redhat.com>
Subject: Re: [RFC PATCH 0/6] CCIX rasdaemon support
Message-ID: <20190621155600.537b7e68@coco.lan>
In-Reply-To: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
References: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Sat, 15 Jun 2019 01:55:11 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> This is an RFC because the kernel side is currently under review and
> may change with obvious follow through effects on this.
> 
> https://lore.kernel.org/linux-edac/20190606123654.78973-1-Jonathan.Cameron@huawei.com/

Yeah, we should wait for it to be merged upstream before adding them to
rasdaemon ;-)

> 
> There are a few additional questions around this:
> 1. Divide between specifity of DB fields vs blobs.
>    Where possible I have tried to fully describe the contents via
>    separate fields rather than large blobs.

OK!

>    One common SQL convention
>    that doesn't seem to have been previously done in rasdaemon is to
>    use explicit NULL entries for elements where data is missing.

We tried to be a simple as possible when we added the dB option.

We even opted to use sqllite, instead of having support for 
MySQL or Postgres - Not only due to simplicity, but also because,
if a machine has problems, a database at the same machine may crash.

That's said, with MySQL/Postgres support, the logs could be done
via a remote machine, with would be safer.

-

I don't see much problem on adding such things to new tables or even
add optional support for other dB types, but Changing the existing dBs 
can be a problem.

Perhaps it could have a table somewhere storing the Rasdaemon version,
in order to be able to detect if a table has missing something. If
Rasdaemon version is bigger than the one at the server, it could do some
database changes in order to support new features - including things like
replacing empty fields by NULL.

If you think such changes would be useful, feel free to submit patches.

> 2. Should we split ras-record.c and have the ccix handling in a separate
>    ras-record-ccix.c file or similar as that one is getting rather large.

Makes sense to me. As all projects, it started small. As things are
getting bigger, it makes sense to split some features on separate
files.

Thanks,
Mauro
