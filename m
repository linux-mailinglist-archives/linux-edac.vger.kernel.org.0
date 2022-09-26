Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6203C5EAE3F
	for <lists+linux-edac@lfdr.de>; Mon, 26 Sep 2022 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIZRdn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Sep 2022 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiIZRdU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Sep 2022 13:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B813F6E
        for <linux-edac@vger.kernel.org>; Mon, 26 Sep 2022 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664211101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmGwLK1akcXsTArfMW2f6Di9pqS3uBZ3uZRT99f11UA=;
        b=gJtkxvI0k6SILl9V9UfQlyULY+yhZuyVYGmQ5NjmFfayOeW17B8whWhRvvjDVBRAjVMA6U
        8cxVkhA7hFx3f4SPLexk1s0LX24WM2c0omimrmtqsbpvzx5y8MSxyoE7iB5NFCXcZFBmhD
        yy3XIc5bTyjg4luRCZrU/BUjq/rvGFM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-Yil1hCagOzWmpLMgoQRkjQ-1; Mon, 26 Sep 2022 12:51:39 -0400
X-MC-Unique: Yil1hCagOzWmpLMgoQRkjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDAE8185A7A4;
        Mon, 26 Sep 2022 16:51:38 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACB5AC15995;
        Mon, 26 Sep 2022 16:51:38 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 5A3BDC0502; Mon, 26 Sep 2022 12:51:38 -0400 (EDT)
Date:   Mon, 26 Sep 2022 12:51:38 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org
Subject: Re: [RESEND PATCH] i5000_edac: fix slot number passed to
 determine_mtr()
Message-ID: <20220926165138.kyp24vhh2czvmu2z@redhat.com>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
 <YytoHtVULW7w3/8Z@zn.tnic>
 <20220922134659.biiy6g743qplzgiq@redhat.com>
 <YyxpbRkuLPIcW1Om@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxpbRkuLPIcW1Om@zn.tnic>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 22, 2022 at 03:55:57PM +0200, Borislav Petkov wrote:
> On Thu, Sep 22, 2022 at 09:46:59AM -0400, Aristeu Rozanski wrote:
> > I'm only fixing a out of bounds access, on purpose.
> > Look at 64e1fdaf55d6 and the new version of determine_mtr().
> 
> I have been looking at that one. And I'm questioning it:
> 
> "The logic there is broken: it basically creates two csrows for each
> DIMM and assumes that all DIMM's are dual rank."
> 
> That commit message doesn't explain why this assumption is wrong.
> 
> Furthermore, "If single rank memories are found, they'll be marked with
> 0 bytes."
> 
> So this looks to me like this commit is breaking dual-ranked DIMMs
> configs in order to fix single-ranked ones.

Declare it dead. Only have a single working system and I don't have
physical access to it along with the fact it's unlikely we have memory
modules single and dual rank to swap around for testing purposes.

-- 
Aristeu

