Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DEA4BD16A
	for <lists+linux-edac@lfdr.de>; Sun, 20 Feb 2022 21:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiBTU0V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Feb 2022 15:26:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiBTU0U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 20 Feb 2022 15:26:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD63968C;
        Sun, 20 Feb 2022 12:25:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B56BD1F38A;
        Sun, 20 Feb 2022 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645388753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIujPNmLzAcbExdyDmdlncVPlTYaCUXow8+FxcIJUvI=;
        b=YektIrWqMYcdViQHwohDwBXpNM/qjP8cXxJt1pcyTQ5hY3Ovw7cOeRaOTD6Az2jnCLwUK0
        WfTWRPf/KkscT1acoM5UmettcHfGz7j3qN3Djkwb2GXVuMVRKqNGq2zUpSdWCOF0iXlUQO
        pSH1lQawW+/dVovF83uYDdfVFdEROXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645388753;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIujPNmLzAcbExdyDmdlncVPlTYaCUXow8+FxcIJUvI=;
        b=n1XQ+auv8Snhqzoy6A7K//7+C3BZIGTaeDlyKqEYnNzh0PKYmmaU0OQ60UCZS0gxynj+YS
        p+BntTi7w9IFXHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95AD21331E;
        Sun, 20 Feb 2022 20:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l1TSI9GjEmJFIgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Feb 2022 20:25:53 +0000
Date:   Sun, 20 Feb 2022 21:25:55 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC fix for 5.17
Message-ID: <YhKj08BBnevqtbch@zn.tnic>
References: <YhIq94B0MpYGrEm2@zn.tnic>
 <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Feb 20, 2022 at 12:12:41PM -0800, Linus Torvalds wrote:
> Or maybe the comment should be fixed instead, and talk about "natural
> alignment" rather than "compiler alignment".

Yah, where do I start... so, about this, I think I can simplify it by
simply unconditionally aligning to 8. My gut feeling is telling me
8-bytes alignment should simply work on everything. Because if it does,
all that crap becomes a lot simpler. But maybe I'm being too simplistic
here and there might be a corner-case where 8-bytes alignment just
doesn't work...

Then, that edac_align_ptr() thing is an abomination. It probably has
made sense at some point to allocate the whole structure, including the
embedded pointers in one go but I can't recall of ever seeing something
like that done somewhere else around the kernel. But maybe you'll know
of another example and why that would have made sense in the past.

If not, I'm thinking of gradually converting all drivers to do normal
structs allocation like the rest of the tree does and then getting rid
of that thing. 

And I keep hoping someone else would volunteer but no one has so far...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
