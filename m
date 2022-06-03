Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8653CE1F
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jun 2022 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbiFCRee (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jun 2022 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiFCRee (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jun 2022 13:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 717BF52E4A
        for <linux-edac@vger.kernel.org>; Fri,  3 Jun 2022 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654277670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ca1MSou98O4NdvVroyRc5kObHKDy6N8tL0SYQPt+OE=;
        b=f/BkpUV6Cq5ZtKvqea5cSSVGOYFVCiGeGSDt0iqOrd1e9aCdcY/bIe2wNzLp+bEwpfw+5o
        UY/UEuQ7vwKipG4y5ljVRwGYgiMa3lxn5HsXzV9TqZf5+qbUwAqiKgjQYC3BO4RfBbgn3D
        W/UQoke7PG/zeeASfZMX83myIUTiBdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-fMHQfR9QNhOr0gh0IvSkKQ-1; Fri, 03 Jun 2022 13:34:27 -0400
X-MC-Unique: fMHQfR9QNhOr0gh0IvSkKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE76685A5B9;
        Fri,  3 Jun 2022 17:34:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FA51410DDB;
        Fri,  3 Jun 2022 17:34:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 253HYQvJ025627;
        Fri, 3 Jun 2022 13:34:26 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 253HYQSf025624;
        Fri, 3 Jun 2022 13:34:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 3 Jun 2022 13:34:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yazen Ghannam <yazen.ghannam@amd.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
In-Reply-To: <Ypjr5yIMan1N0bqH@yaz-fattaah>
Message-ID: <alpine.LRH.2.02.2206031327190.25179@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com> <YpUcf19E+qgb6Eyu@kroah.com> <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com> <Ypjr5yIMan1N0bqH@yaz-fattaah>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Thu, 2 Jun 2022, Yazen Ghannam wrote:

> On Tue, May 31, 2022 at 03:42:12AM -0400, Mikulas Patocka wrote:
> 
> ...
> 
> > > > The machine is two six-core Opterons 8435.
> > > > 
> > > > Mikulas
> 
> Hi Mikulas,
> 
> I'm not able to reproduce this issue on the systems I have access to. But I
> think the following patch may be the solution. Can you please try this?
> 
> Thanks,
> Yazen

I tried this patch and it doesn't help.

With this patch, it's even worse - before the patch, I had 48 warnings per 
suspend, with the patch, I have 72 warnings.

Mikulas

