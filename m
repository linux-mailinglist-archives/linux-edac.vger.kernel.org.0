Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91845E6413
	for <lists+linux-edac@lfdr.de>; Thu, 22 Sep 2022 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIVNsM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Sep 2022 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiIVNrv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Sep 2022 09:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D358CF162E
        for <linux-edac@vger.kernel.org>; Thu, 22 Sep 2022 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663854422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGEl6LqWKLvSypDLQWoU7iz6FLzava7tusAf8V+Uyf0=;
        b=hG87I0WmJnUvUkYHBohsIaWpmsdzw8qH5R2YusQfebPR+eBnoAupdyBdlLWQZnS9hAVbkn
        A93dA1duC27H3qeWFv4nx2/SI+hGm7kxHFqtZaWMJtFrqB4TKG7pNR56Liayw9Dvh1rjV5
        ixgkL7Ip340RZnu1goivRaj/+cCoSSI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-6hTGikOjNyGaHsE_q3FerQ-1; Thu, 22 Sep 2022 09:47:00 -0400
X-MC-Unique: 6hTGikOjNyGaHsE_q3FerQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51A983C0ED52;
        Thu, 22 Sep 2022 13:47:00 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42CA040C6EC3;
        Thu, 22 Sep 2022 13:47:00 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id C79E0C04E2; Thu, 22 Sep 2022 09:46:59 -0400 (EDT)
Date:   Thu, 22 Sep 2022 09:46:59 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org
Subject: Re: [RESEND PATCH] i5000_edac: fix slot number passed to
 determine_mtr()
Message-ID: <20220922134659.biiy6g743qplzgiq@redhat.com>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
 <YytoHtVULW7w3/8Z@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytoHtVULW7w3/8Z@zn.tnic>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 21, 2022 at 09:38:06PM +0200, Borislav Petkov wrote:
> So it looks to me like back then, the number of CS rows was twice the
> DIMMs per channel, implying two CS rows per DIMM, I guess dual-ranked
> DIMMs or so.
> 
> Now you're saying the number CS rows is the number of DIMMs. Which
> means, single-ranked DIMMs?

I'm only fixing a out of bounds access, on purpose.
Look at 64e1fdaf55d6 and the new version of determine_mtr().

> But all this is broken as it needs to deal with both single-ranked and
> dual-ranked DIMMs elegantly and not assume any DIMM types...

That's correct, while talking to Mauro he suggested fixing the entire
thing.

> Do we have hardware where we can test this or can we declare this hw for
> dead?

And this is the reason why I decided to not do it. We do have the hardware
but last time I checked none of them had functional EINJ.

-- 
Aristeu

