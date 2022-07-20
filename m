Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56E57BA94
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGTPjW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbiGTPjL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 11:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440EE41D30
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658331549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crkEBiF7Hd+QSV78V9K+bjM6tT9vutvbICuWR5vfpXA=;
        b=HmXlbHP7OaZWa74tLz7oDQbWr36E21gT6oxozccaPnaF/6tg8F9vdEH9BWo3hKlVhZl+a3
        rbQYxn95Cm+yiuXhcPxoJrDPTMymwS51NAfDOpwveoxhVgN7kSApsXFJYmrEy1/V1eiTuR
        8arR0G2/oFDCqG+MaxosfmFD7XRIt5M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-o06XRBBPNhqI-Z1ymFZbNQ-1; Wed, 20 Jul 2022 11:39:01 -0400
X-MC-Unique: o06XRBBPNhqI-Z1ymFZbNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68B4A824063;
        Wed, 20 Jul 2022 15:39:01 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59DE9403162;
        Wed, 20 Jul 2022 15:39:01 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 23EA0C0521; Wed, 20 Jul 2022 11:39:01 -0400 (EDT)
Date:   Wed, 20 Jul 2022 11:39:01 -0400
From:   "'arozansk@redhat.com'" <arozansk@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH 3/3] rasdaemon: ras-memory-failure-handler: handle
 localtime() failure correctly
Message-ID: <20220720153901.ylxednn2d44h7r3t@redhat.com>
References: <20220720143957.795358633@redhat.com>
 <20220720143957.977427150@redhat.com>
 <MW5PR84MB1842E4A18E672F6E13896D0CAB8E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842E4A18E672F6E13896D0CAB8E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 20, 2022 at 03:33:49PM +0000, Elliott, Robert (Servers) wrote:
> > -----Original Message-----
> > From: arozansk@redhat.com <arozansk@redhat.com>
> > Sent: Wednesday, July 20, 2022 9:40 AM
> ...
> > Subject: [PATCH 3/3] rasdaemon: ras-memory-failure-handler: handle
> > localtime() failure correctly
> > 
> > We could just have an empty string but keeping the format could prevent
> > issues if someone is actually parsing this.
> > Found with covscan.
> > 
> ...
> > diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
> ...
> > @@ -148,6 +148,8 @@ int ras_memory_failure_event_handler(struct trace_seq
> > *s,
> >  	if (tm)
> >  		strftime(ev.timestamp, sizeof(ev.timestamp),
> >  			 "%Y-%m-%d %H:%M:%S %z", tm);
> > +	else
> > +		strncpy(ev.timestamp, "0000-00-00 00:00:00 GMT", sizeof(ev.timestamp));
> 
> 
> Per man strftime:
>        %z     The +hhmm or -hhmm numeric timezone (that is, the hour and minute offset from UTC). (SU)
>        %Z     The timezone name or abbreviation.
> 
> GMT does not match the lowercase %z format of +hhmm or -hhmm

Good catch, thanks

> Returning the UNIX epoch might be safer, too:
>     1970-01-01 00:00:00 +0000

Agreed, v2 will follow

-- 
Aristeu

