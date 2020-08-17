Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1140246F08
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 19:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgHQRlT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 13:41:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57100 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbgHQRkD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Aug 2020 13:40:03 -0400
Received: from zn.tnic (p200300ec2f26be005d5d46115b1a3c6f.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:5d5d:4611:5b1a:3c6f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 263DD1EC0373;
        Mon, 17 Aug 2020 19:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597686002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fw1454RQoPux7IHeoJy+rsjGku6lKkDblw9peEpp6e8=;
        b=GxHe3TcTxwxflCvn+9qeE1LBFfvK3qDKSyoOB5yjrCoYMparPakQTOzOg29E3XclG0FJQe
        HByM67RIOodSL5yW6+xU1dX4s96B/UMowfvZ1zgw66OBKIPofaSI9gmKXu3CAz9gJ/8qws
        yKfD6Z0Txej1Mw6aQYMF1tfFUx6X9gA=
Date:   Mon, 17 Aug 2020 19:41:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
Message-ID: <20200817174102.GN549@zn.tnic>
References: <20200805045955.GB9127@nazgul.tnic>
 <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
 <20200812210909.GA3283093@google.com>
 <20200817151357.GK549@zn.tnic>
 <CABCJKuccY-wOEuQm--TQYgJvErOXu5u-jBMgCrM7JYsNqYK=gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKuccY-wOEuQm--TQYgJvErOXu5u-jBMgCrM7JYsNqYK=gg@mail.gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 17, 2020 at 08:58:26AM -0700, Sami Tolvanen wrote:
> Sorry for not clarifying. This was in a tree with patches for enabling
> Clang's Control-Flow Integrity.

Well, I just did:

$ make CC=clang-10 HOSTCC=clang-10 allyesconfig
$ make -j...

and it built fine here, no complaints. So your toolchain must have
something else.

> However, this type mismatch looks like something that should be fixed
> regardless.

No question there - I'm just trying to figure out how something as minor
as this would break a build.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
