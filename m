Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C348A131484
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2020 16:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFPMt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jan 2020 10:12:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbgAFPMt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Jan 2020 10:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578323567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDOCNUl865ssd6gP7Il6J99UTFKaktrtb6RDRoy01yc=;
        b=jCdDdIXPsrZNnxyDfVIglJpBDHsiGnHn6ktKVw6fuMF6zCOyqXYdTKO8sR3s9/mS2TzL/U
        ZMfaZKFWRMtN2+swI923Ki5VG1GHIgD/BJfcYJdyAVM07Mkt/fgnyKmQHlmqbeZbQE8RO7
        sPAnWzO4QDBOa49odiSFCjhaM9J+38U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-35QtnFYiMFWIHWaePn8fDw-1; Mon, 06 Jan 2020 10:12:44 -0500
X-MC-Unique: 35QtnFYiMFWIHWaePn8fDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D2C107AFFC;
        Mon,  6 Jan 2020 15:12:43 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B757DB58;
        Mon,  6 Jan 2020 15:12:43 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id D2E02C0C59; Mon,  6 Jan 2020 10:12:42 -0500 (EST)
Date:   Mon, 6 Jan 2020 10:12:42 -0500
From:   'Aristeu Rozanski' <aris@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200106151242.vkdiiwhubmkx5osh@redhat.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210090013.GA9395@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 10:00:13AM +0100, Borislav Petkov wrote:
> On Tue, Dec 10, 2019 at 12:02:45AM +0000, Luck, Tony wrote:
> > > This looks like we call skx_init() once per core. Do we keep calling it because
> > > the calls are failing?  Or do we do that even when calls succeed?
> > >
> > > I was only really expecting that skx_init() would be called once.
> > 
> > So (by experimentation) it seems that if the module load fails it
> > will be retried num_online_cpus times (though not bound to each
> > CPU in turn ... it will maybe try the init call on the same CPU multiple
> > times, but miss running on some CPUs).
> > 
> > If the load succeeds, then whoever is repeating the load decides
> > to stop.
> 
> That's the result of our conversion to MODULE_DEVICE_TABLE to match CPU
> models. So it tries once on each CPU:
> 
> https://lkml.kernel.org/r/20191107103857.GC19501@zn.tnic
> 
> I have no clean solution for this except maybe remembering the return
> value of the first instance probing in the edac core module and then
> asking it... it ain't pretty though.

The other option I can think about is just allowing the module to load
in this situation: the CPU is present but you have no memory controller
PCI devices present. Some drivers will allow loading without having a
device present without errors. It's not clean as having to come up with
something modutils can pick up as hint to not try to load more than once.

Or could just downgrade this specific message since it's a very common
case and let the more unusual situations report more than once.

-- 
Aristeu

