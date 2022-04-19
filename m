Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9C75067CB
	for <lists+linux-edac@lfdr.de>; Tue, 19 Apr 2022 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiDSJjk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Apr 2022 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiDSJjj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Apr 2022 05:39:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DDE103D;
        Tue, 19 Apr 2022 02:36:58 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E8D0B1EC054C;
        Tue, 19 Apr 2022 11:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650361012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PnKnxQ35ZL0ge6XWFSebofPawmBmjfvPskm/6anfykA=;
        b=HVu5BG/iD1SiftIOV/uuHJFlkfEAOSUTTsBWZZ6CTgbstdNKnkTqO3qg23DmMbylApahWG
        mjHh+7tDkDVbTqfNkjBJqEZbqpniHI5M7jgcBxn/TjXZBYhtVawykPyviDox3HI8y9hCzD
        QtcCrm22yUYv72FV1aC9Rs/0QG+eP4w=
Date:   Tue, 19 Apr 2022 11:36:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <Yl6CtMzNm5HaCE/I@zn.tnic>
References: <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
 <YefXQHXNlsxk8yUc@kroah.com>
 <Yefb7zO9p1iPF3Jm@zn.tnic>
 <YefnuCPwMq5V2lgl@kroah.com>
 <20220404215640.GA626436@sequoia>
 <20220418204029.GA31854@sequoia>
 <Yl3UgPtVV3t4pzVe@zn.tnic>
 <20220418213453.GB31854@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418213453.GB31854@sequoia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 04:34:53PM -0500, Tyler Hicks wrote:
> The patches to modify the API have become stale. There have been no
> new comments or revisions since Feb. What I'm proposing is to proceed
> with merging this simple fix and let the folks discussing the API
> changes adjust the use in the dmc250 driver if/when they decide to
> revive the API changes.

Ok, fair enough.

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
